package nibby;

/**
 * Plays the 4-channel module "nib-rsi.mod" exactly like the game's replay
 * routine (NoiseTracker style: effects 0-6, A-F), ticked once per frame (50 Hz),
 * and mixes it to 16-bit stereo PCM. Sound effects replace the note of channel
 * 2 for a few rows, as in the original.
 */
public final class ModPlayer {
    public static final int RATE = 44100;
    private static final double CLOCK = 3546895.0;   // PAL Paula clock

    /** Sound effects, written as pattern cells: sample 17 "bopp", sample 16 "esplosione". */
    public static final int SFX_EAT = 0x11ac1c40;
    public static final int SFX_DEATH = 0x11ac0c40;

    private static final int[] PERIODS = {
        856, 808, 762, 720, 678, 640, 604, 570, 538, 508, 480, 453,
        428, 404, 381, 360, 339, 320, 302, 285, 269, 254, 240, 226,
        214, 202, 190, 180, 170, 160, 151, 143, 135, 127, 120, 113, 0};
    private static final int[] SINE = {
        0, 24, 49, 74, 97, 120, 141, 161, 180, 197, 212, 224, 235, 244, 250, 253,
        255, 253, 250, 244, 235, 224, 212, 197, 180, 161, 141, 120, 97, 74, 49, 24};

    private final byte[] mod;
    private final int songLength, restart, patterns;
    private final int[] sampleStart = new int[32], sampleLen = new int[32], sampleVol = new int[32];
    private final int[] sampleRepStart = new int[32], sampleRepLen = new int[32];

    private int speed = 6, counter, patternPos, songPos;
    private boolean breakFlag;
    private int dmaFlags;
    private boolean sfxActive;
    private int sfxCell, sfxRows;

    private final Voice[] voices = {new Voice(), new Voice(), new Voice(), new Voice()};

    private static final class Voice {
        // replay state
        int cell, start, length, loopStart, repLen, period, volume;
        int portDir, portSpeed, wantPeriod, vibCmd, vibPos;
        // output ("Paula") state
        int outPeriod, outVolume;
        int regStart, regLen;          // registers reloaded at the end of each block
        boolean playing;
        int pos, end;
        double frac;
    }

    /** Called on the ticks without a new row; the game refreshes its status bar there. */
    public interface TickHook {
        void tick(int counter);
    }

    private TickHook hook = c -> { };

    public ModPlayer(byte[] module) {
        this.mod = module;
        songLength = u8(950);
        restart = u8(951);
        int max = 0;
        for (int i = 0; i < 128; i++) max = Math.max(max, u8(952 + i));
        patterns = 1084;
        int s = patterns + (max + 1) * 1024;
        for (int i = 1; i <= 31; i++) {
            int h = 20 + (i - 1) * 30;
            sampleStart[i] = s;
            sampleLen[i] = u16(h + 22);
            sampleVol[i] = u8(h + 25);
            sampleRepStart[i] = u16(h + 26);
            sampleRepLen[i] = u16(h + 28);
            // the replay clears the first word of each sample (used as silent loop)
            for (int k = 0; k < 4 && s + k < mod.length; k++) mod[s + k] = 0;
            s += sampleLen[i] * 2;
        }
    }

    public void setTickHook(TickHook hook) {
        this.hook = hook;
    }

    private int u8(int o) {
        return o < mod.length ? mod[o] & 0xff : 0;
    }

    private int u16(int o) {
        return u8(o) << 8 | u8(o + 1);
    }

    private int cellAt(int o) {
        return u16(o) << 16 | u16(o + 2);
    }

    public synchronized void playSfx(int cell) {
        sfxCell = cell;
        sfxActive = true;
    }

    // ------------------------------------------------------------ replay

    /** One 50 Hz tick. */
    public synchronized void tick() {
        counter++;
        if (counter < speed) {
            hook.tick(counter);
            for (Voice v : voices) effects(v);
            while (breakFlag) nextPosition();
            return;
        }
        counter = 0;
        dmaFlags = 0;
        int row = patterns + u8(952 + songPos) * 1024 + patternPos;
        newNote(0, cellAt(row));
        if (sfxActive) {
            Voice v = voices[1];
            if (sfxCell != 0) {
                sfxRows = sfxCell == SFX_EAT ? 1 : 4;
                v.cell = sfxCell;
                sfxCell = 0;
            } else {
                v.cell = 0;
                if (--sfxRows == 0) sfxActive = false;
            }
            play(1);
        } else {
            newNote(1, cellAt(row + 4));
        }
        newNote(2, cellAt(row + 8));
        newNote(3, cellAt(row + 12));
        if (dmaFlags != 0) {
            for (int i = 0; i < 4; i++) {
                Voice v = voices[i];
                if ((dmaFlags & 1 << i) != 0) start(v);
            }
            for (Voice v : voices) {
                v.regStart = v.loopStart;
                v.regLen = v.repLen;
            }
        }
        patternPos += 16;
        if (patternPos == 1024) nextPosition();
        while (breakFlag) nextPosition();
    }

    private void nextPosition() {
        patternPos = 0;
        breakFlag = false;
        songPos = (songPos + 1) & 0x7f;
        if (songPos == songLength) songPos = restart;
    }

    private void newNote(int ch, int cell) {
        voices[ch].cell = cell;
        play(ch);
    }

    private void play(int ch) {
        Voice v = voices[ch];
        int c = v.cell;
        int sample = (c >>> 12 & 0x0f) | (c >>> 24 & 0xf0);
        if (sample != 0 && sample < 32) {
            v.start = sampleStart[sample];
            v.length = sampleLen[sample];
            v.volume = sampleVol[sample];
            v.loopStart = v.start + sampleRepStart[sample] * 2;
            if (sampleRepStart[sample] != 0) v.length = sampleRepStart[sample] + sampleRepLen[sample];
            v.repLen = sampleRepLen[sample];
            v.outVolume = v.volume;
        }
        int period = c >>> 16 & 0xfff;
        if (period != 0) {
            if (v.length == 0) {
                v.playing = false;
            } else {
                int fx = c >>> 8 & 0xf;
                if (fx == 3 || fx == 5) {
                    v.wantPeriod = period;
                    v.portDir = 0;
                    if (period == v.period) {
                        v.wantPeriod = 0;
                        return;
                    }
                    if (period < v.period) v.portDir = 1;
                } else {
                    v.period = period;
                    v.playing = false;
                    v.vibPos = 0;
                    v.regStart = v.start;
                    v.regLen = v.length;
                    v.outPeriod = period;
                    dmaFlags |= 1 << ch;
                }
            }
        }
        rowEffects(v);
    }

    private void rowEffects(Voice v) {
        int fx = v.cell >>> 8 & 0xf, param = v.cell & 0xff;
        switch (fx) {
            case 0xd -> breakFlag = true;
            case 0xb -> {
                breakFlag = true;
                songPos = (param - 1) & 0xff;
            }
            case 0xc -> {
                if (param > 0x40) {
                    param = 0x40;
                    v.cell = (v.cell & ~0xff) | param;
                }
                v.volume = param;
                v.outVolume = param;
            }
            case 0xf -> speed = param > 0x1f ? 0x1f : Math.max(param, 1);
            default -> { }
        }
    }

    private void effects(Voice v) {
        if ((v.cell & 0xfff) == 0) {
            v.outPeriod = v.period;
            return;
        }
        int fx = v.cell >>> 8 & 0xf;
        switch (fx) {
            case 0x0 -> arpeggio(v);
            case 0x6 -> {
                vibrato(v);
                volumeSlide(v);
            }
            case 0x4 -> {
                if ((v.cell & 0xff) != 0) v.vibCmd = v.cell & 0xff;
                vibrato(v);
            }
            case 0x5 -> {
                tonePortamento(v);
                volumeSlide(v);
            }
            case 0x3 -> {
                if ((v.cell & 0xff) != 0) {
                    v.portSpeed = v.cell & 0xff;
                    v.cell &= ~0xff;
                }
                tonePortamento(v);
            }
            case 0x1 -> {
                v.period = Math.max(v.period - (v.cell & 0xff), 0x71);
                v.outPeriod = v.period;
            }
            case 0x2 -> {
                v.period = Math.min(v.period + (v.cell & 0xff), 0x358);
                v.outPeriod = v.period;
            }
            default -> {
                v.outPeriod = v.period;
                if (fx == 0xa) volumeSlide(v);
            }
        }
    }

    private void arpeggio(Voice v) {
        int step = counter % 3;
        if (step == 0) {
            v.outPeriod = v.period;
            return;
        }
        int x = step == 1 ? (v.cell >> 4 & 0xf) : (v.cell & 0xf);
        int i = 0;
        while (v.period < PERIODS[i]) i++;
        v.outPeriod = i + x < PERIODS.length ? PERIODS[i + x] : 0;
    }

    private void tonePortamento(Voice v) {
        if (v.wantPeriod == 0) return;
        if (v.portDir == 0) {
            v.period += v.portSpeed;
            if (v.wantPeriod <= v.period) {
                v.period = v.wantPeriod;
                v.wantPeriod = 0;
            }
        } else {
            v.period -= v.portSpeed;
            if (v.wantPeriod >= v.period) {
                v.period = v.wantPeriod;
                v.wantPeriod = 0;
            }
        }
        v.outPeriod = v.period;
    }

    private void vibrato(Voice v) {
        int d = SINE[v.vibPos >> 2 & 0x1f] * (v.vibCmd & 0xf) >> 7;
        v.outPeriod = (byte) v.vibPos < 0 ? v.period - d : v.period + d;
        v.vibPos = (v.vibPos + (v.vibCmd >> 2 & 0x3c)) & 0xff;
    }

    private void volumeSlide(Voice v) {
        int up = v.cell >> 4 & 0xf;
        v.volume = up != 0 ? Math.min(v.volume + up, 0x40) : Math.max(v.volume - (v.cell & 0xf), 0);
        v.outVolume = v.volume;
    }

    // ------------------------------------------------------------ mixer

    private static void start(Voice v) {
        v.playing = true;
        v.pos = v.regStart;
        v.end = v.regStart + v.regLen * 2;
        v.frac = 0;
    }

    /** Mixes {@code n} stereo frames (16-bit little-endian) into {@code out}. */
    public synchronized void mix(byte[] out, int n) {
        for (int i = 0; i < n; i++) {
            int[] s = new int[4];
            for (int k = 0; k < 4; k++) {
                Voice v = voices[k];
                if (!v.playing || v.outPeriod < 64) continue;
                s[k] = (v.pos < mod.length ? mod[v.pos] : 0) * Math.min(v.outVolume, 64);
                v.frac += CLOCK / v.outPeriod / RATE;
                while (v.frac >= 1.0) {
                    v.frac -= 1.0;
                    if (++v.pos >= v.end) start(v);
                }
            }
            // Amiga panning: channels 1 and 4 left, 2 and 3 right, with a little crossfeed
            int left = s[0] + s[3], right = s[1] + s[2];
            int l = clamp((left * 3 + right) / 2), r = clamp((right * 3 + left) / 2);
            out[i * 4] = (byte) l;
            out[i * 4 + 1] = (byte) (l >> 8);
            out[i * 4 + 2] = (byte) r;
            out[i * 4 + 3] = (byte) (r >> 8);
        }
    }

    private static int clamp(int v) {
        return Math.max(-32768, Math.min(32767, v));
    }
}
