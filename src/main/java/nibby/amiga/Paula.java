package nibby.amiga;

/**
 * Paula audio: four 8-bit DMA channels. Emulates the register latch behaviour
 * the replay routine relies on: when DMA is switched on a channel copies
 * AUDxLC/AUDxLEN into its internal counters, and when the block ends it
 * reloads them from whatever the registers hold at that moment (the loop).
 */
public final class Paula {
    public static final int RATE = 44100;
    private static final double CLOCK = 3546895.0; // PAL

    private final Memory mem;
    private final Channel[] ch = {new Channel(), new Channel(), new Channel(), new Channel()};

    private static final class Channel {
        int lc, len, per, vol;      // registers
        boolean on;
        int ptr, remaining;          // internal counters (bytes)
        double frac;
        int pos;
    }

    Paula(Memory mem) {
        this.mem = mem;
    }

    boolean write(int reg, int v) {
        if (reg < 0x0a0 || reg > 0x0df) return false;
        Channel c = ch[(reg - 0x0a0) >> 4];
        switch (reg & 0xf) {
            case 0x0 -> c.lc = (v & 7) << 16 | (c.lc & 0xffff);
            case 0x2 -> c.lc = (c.lc & 0x70000) | (v & 0xfffe);
            case 0x4 -> c.len = v;
            case 0x6 -> c.per = v;
            case 0x8 -> c.vol = Math.min(v & 0x7f, 64);
            default -> { }
        }
        return true;
    }

    /** DMACON audio bits (0-3). */
    void dma(int bits, boolean set) {
        for (int i = 0; i < 4; i++) {
            if ((bits & 1 << i) == 0) continue;
            Channel c = ch[i];
            if (set && !c.on) {
                c.on = true;
                latch(c);
            } else if (!set) {
                c.on = false;
            }
        }
    }

    private static void latch(Channel c) {
        c.ptr = c.lc;
        c.remaining = (c.len == 0 ? 0x10000 : c.len) * 2;
        c.pos = 0;
        c.frac = 0;
    }

    /** Mixes {@code n} stereo frames as signed 16-bit little-endian into out. */
    public void mix(byte[] out, int n) {
        for (int i = 0; i < n; i++) {
            int[] s = new int[4];
            for (int k = 0; k < 4; k++) {
                Channel c = ch[k];
                if (!c.on || c.per < 64) continue;
                s[k] = mem.sb(c.ptr + c.pos) * c.vol;
                c.frac += CLOCK / c.per / RATE;
                while (c.frac >= 1.0) {
                    c.frac -= 1.0;
                    if (++c.pos >= c.remaining) latch(c);
                }
            }
            // Amiga panning: channels 0 and 3 left, 1 and 2 right (with a little crossfeed)
            int left = s[0] + s[3], right = s[1] + s[2];
            int l = (left * 3 + right) / 4 * 2, r = (right * 3 + left) / 4 * 2;
            l = Math.max(-32768, Math.min(32767, l));
            r = Math.max(-32768, Math.min(32767, r));
            out[i * 4] = (byte) l;
            out[i * 4 + 1] = (byte) (l >> 8);
            out[i * 4 + 2] = (byte) r;
            out[i * 4 + 3] = (byte) (r >> 8);
        }
    }
}
