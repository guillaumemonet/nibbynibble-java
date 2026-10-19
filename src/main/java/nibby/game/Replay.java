package nibby.game;

import nibby.amiga.Custom;
import nibby.amiga.Memory;

/**
 * Port of the game's module replay routine ($366D8-$36E1E), a NoiseTracker
 * style player for the 31-sample module "nib-rsi" stored at $40000.
 * Supported effects are exactly those of the original: 0 arpeggio,
 * 1/2 portamento, 3 tone portamento, 4 vibrato, 5 and 6 (3/4 + volume slide),
 * A volume slide, B position jump, C volume, D pattern break, E filter, F speed.
 * Sound effects are played by replacing the note of channel 2 ($36E6A-$36E70).
 */
public final class Replay {
    static final int MODULE = 0x40000;
    private static final int POSITIONS = MODULE + 0x3b8;
    private static final int PATTERNS = MODULE + 0x43c;
    private static final int PERIOD_TABLE = 0x36e20;  // 36 periods, followed by zeros
    private static final int VIBRATO_SINE = 0x36be8;   // 32 bytes

    /** Sound effects, written as a pattern cell (sample 17 "bopp", sample 16 "esplosione"). */
    public static final int SFX_EAT = 0x11ac1c40;
    public static final int SFX_DEATH = 0x11ac0c40;

    private final Memory mem;
    private final Custom custom;

    private final int[] sampleStart = new int[32];   // $36E7A
    private final int[] sampleHeader = new int[32];  // $36A72 (address of each length word)
    private int speed = 6;          // $36E72
    private int counter;            // $36E73
    private int patternPos;         // $36E74
    private int songPos;            // $36E76
    private boolean breakFlag;      // $36E77
    private int dmaFlags;           // $36E78

    // channel 2 sound effect override
    private boolean sfxActive;      // $36E6A
    private int sfxCell;            // $36E6C
    private int sfxRows;            // $36E70

    private final Voice[] voices = {new Voice(1), new Voice(2), new Voice(4), new Voice(8)};

    /** Channel structure ($36EF6 + n*$1C). */
    private static final class Voice {
        int cell;           // 0: current pattern cell
        int start;          // 4: sample start
        int length;         // 8: length in words
        int loopStart;      // $A
        int repLen;         // $E
        int period;         // $10
        int volume;         // $13
        int portDir;        // $14
        int portSpeed;      // $15
        int wantPeriod;     // $16
        int vibCmd;         // $18
        int vibPos;         // $19 (signed byte)
        final int dmaBit;   // $1A
        int regs;           // AUDx register base

        Voice(int dmaBit) {
            this.dmaBit = dmaBit;
            this.regs = 0x0a0 + 0x10 * Integer.numberOfTrailingZeros(dmaBit);
        }
    }

    /** Called on non-row ticks, where the original refreshes the status bar. */
    public interface TickHook {
        void tick(int counter);
    }

    private TickHook hook = c -> { };

    public Replay(Memory mem, Custom custom) {
        this.mem = mem;
        this.custom = custom;
    }

    public void setTickHook(TickHook hook) {
        this.hook = hook;
    }

    /** mt_init ($366D8) */
    public void init() {
        int hdr = 0x4000c;
        for (int i = 0; i < 32; i++, hdr += 30) sampleHeader[i] = hdr;
        int maxPattern = 0;
        for (int i = 0; i < 128; i++) maxPattern = Math.max(maxPattern, mem.b(POSITIONS + i));
        int sample = PATTERNS + (maxPattern + 1) * 1024;
        int h = MODULE + 0x2a;
        for (int i = 1; i <= 31; i++, h += 30) {
            mem.setL(sample, 0);
            sampleStart[i] = sample;
            mem.setB(h + 2, 0);              // clear finetune
            sample += mem.w(h) * 2;
        }
        speed = 6;
        counter = 0;
        patternPos = 0;
        songPos = 0;
        for (Voice v : voices) custom.w(v.regs + 8, 0);
    }

    /** mt_end ($36784) */
    public void end() {
        for (Voice v : voices) custom.w(v.regs + 8, 0);
        custom.w(0x096, 0x000f);
    }

    /** Requests a sound effect on channel 2 (game writes $36E6C/$36E6A). */
    public void playSfx(int cell) {
        sfxCell = cell;
        sfxActive = true;
    }

    /** mt_music, the part after the game timer ($367E0). */
    public void tick() {
        counter++;
        if (counter < speed) {
            nonRowTick();
            return;
        }
        counter = 0;
        dmaFlags = 0;
        int offset = mem.b(POSITIONS + songPos) * 1024 + patternPos;

        playRow(voices[0], mem.l(PATTERNS + offset));
        Voice v2 = voices[1];
        if (sfxActive) {
            if (sfxCell != 0) {
                sfxRows = sfxCell == SFX_EAT ? 1 : 4;
                v2.cell = sfxCell;
                sfxCell = 0;
                newNote(v2);
            } else {
                v2.cell = 0;
                newNote(v2);
                if (--sfxRows == 0) sfxActive = false;
            }
        } else {
            playRow(v2, mem.l(PATTERNS + offset + 4));
        }
        playRow(voices[2], mem.l(PATTERNS + offset + 8));
        playRow(voices[3], mem.l(PATTERNS + offset + 12));

        if (dmaFlags != 0) {
            // CIA-B one-shot interrupts ($36994/$369B4): start DMA, then set loop registers
            custom.w(0x096, 0x8000 | dmaFlags);
            for (Voice v : voices) {
                custom.l(v.regs, v.loopStart);
                custom.w(v.regs + 4, v.repLen);
            }
        }

        patternPos += 16;
        if (patternPos == 0x400) nextPosition();
        while (breakFlag) nextPosition();
    }

    private void nextPosition() {
        patternPos = 0;
        breakFlag = false;
        songPos = (songPos + 1) & 0x7f;
        if (songPos == mem.b(MODULE + 0x3b6)) songPos = mem.b(MODULE + 0x3b7);
    }

    private void nonRowTick() {
        hook.tick(counter);
        for (Voice v : voices) effects(v);
        while (breakFlag) nextPosition();
    }

    private void playRow(Voice v, int cell) {
        v.cell = cell;
        newNote(v);
    }

    /** $36A28 */
    private void newNote(Voice v) {
        int c = v.cell;
        int sample = (c >>> 12 & 0x0f) | (c >>> 24 & 0xf0);
        if (sample != 0) {
            v.start = sampleStart[sample];
            int h = sampleHeader[sample];
            v.length = mem.w(h);
            v.volume = mem.w(h + 2) & 0xff;
            int repStart = mem.w(h + 4);
            int repLen = mem.w(h + 6);
            v.loopStart = v.start + repStart * 2;
            if (repStart != 0) v.length = repStart + repLen;
            v.repLen = repLen;
            custom.w(v.regs + 8, v.volume);
        }
        int period = c >>> 16 & 0xfff;
        if (period != 0) {
            if (v.length == 0) {
                custom.w(0x096, v.dmaBit);
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
                    custom.w(0x096, v.dmaBit);
                    v.vibPos = 0;
                    custom.l(v.regs, v.start);
                    custom.w(v.regs + 4, v.length);
                    custom.w(v.regs + 6, v.period);
                    dmaFlags |= v.dmaBit;
                }
            }
        }
        moreEffects(v);
    }

    /** $36D88: effects evaluated on the row tick */
    private void moreEffects(Voice v) {
        int fx = v.cell >>> 8 & 0xf, param = v.cell & 0xff;
        switch (fx) {
            case 0xe -> { } // LED filter: not emulated
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
                custom.w(v.regs + 8, param);
            }
            case 0xf -> speed = param > 0x1f ? 0x1f : Math.max(param, 1);
            default -> { }
        }
    }

    /** $36CB2: effects evaluated on the other ticks */
    private void effects(Voice v) {
        if ((v.cell & 0xfff) == 0) {
            setPeriod(v, v.period);
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
                v.period -= v.cell & 0xff;
                if (v.period < 0x71) v.period = 0x71;
                setPeriod(v, v.period);
            }
            case 0x2 -> {
                v.period += v.cell & 0xff;
                if (v.period >= 0x358) v.period = 0x358;
                setPeriod(v, v.period);
            }
            default -> {
                setPeriod(v, v.period);
                if (fx == 0xa) volumeSlide(v);
            }
        }
    }

    private void setPeriod(Voice v, int p) {
        custom.w(v.regs + 6, p);
    }

    /** $36C72 */
    private void arpeggio(Voice v) {
        int step = counter % 3;
        if (step == 0) {
            setPeriod(v, v.period);
            return;
        }
        int x = step == 1 ? (v.cell >> 4 & 0xf) : (v.cell & 0xf);
        int a = PERIOD_TABLE;
        while (v.period < mem.w(a)) a += 2;
        setPeriod(v, mem.w(a + x * 2));
    }

    /** $36B98 */
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
        setPeriod(v, v.period);
    }

    /** $36C12 */
    private void vibrato(Voice v) {
        int d = mem.b(VIBRATO_SINE + (v.vibPos >> 2 & 0x1f));
        d = d * (v.vibCmd & 0xf) >> 7;
        setPeriod(v, (byte) v.vibPos < 0 ? v.period - d : v.period + d);
        v.vibPos = (v.vibPos + (v.vibCmd >> 2 & 0x3c)) & 0xff;
    }

    /** $36D4A */
    private void volumeSlide(Voice v) {
        int up = v.cell >> 4 & 0xf;
        if (up != 0) {
            v.volume += up;
            if (v.volume >= 0x40) v.volume = 0x40;
        } else {
            v.volume -= v.cell & 0xf;
            if (v.volume < 0) v.volume = 0;
        }
        custom.w(v.regs + 8, v.volume);
    }
}
