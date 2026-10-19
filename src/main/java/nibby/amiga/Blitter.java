package nibby.amiga;

/**
 * Minimal Amiga blitter: ascending copy mode with A/B/C/D channels, barrel
 * shifters, first/last word masks and any minterm. Line and fill modes are not
 * used by the game. Blits complete instantly when BLTSIZE is written.
 */
public final class Blitter {
    private final Memory mem;
    int con0, con1, afwm = 0xffff, alwm = 0xffff;
    int apt, bpt, cpt, dpt;
    int amod, bmod, cmod, dmod;
    int adat, bdat, cdat;

    Blitter(Memory mem) {
        this.mem = mem;
    }

    /** Writes a blitter register ($040-$074); returns false if not a blitter register. */
    boolean write(int reg, int v) {
        switch (reg) {
            case 0x040 -> con0 = v;
            case 0x042 -> con1 = v;
            case 0x044 -> afwm = v;
            case 0x046 -> alwm = v;
            case 0x048 -> cpt = hi(cpt, v);
            case 0x04a -> cpt = lo(cpt, v);
            case 0x04c -> bpt = hi(bpt, v);
            case 0x04e -> bpt = lo(bpt, v);
            case 0x050 -> apt = hi(apt, v);
            case 0x052 -> apt = lo(apt, v);
            case 0x054 -> dpt = hi(dpt, v);
            case 0x056 -> dpt = lo(dpt, v);
            case 0x058 -> start(v);
            case 0x060 -> cmod = (short) (v & 0xfffe);
            case 0x062 -> bmod = (short) (v & 0xfffe);
            case 0x064 -> amod = (short) (v & 0xfffe);
            case 0x066 -> dmod = (short) (v & 0xfffe);
            case 0x070 -> cdat = v;
            case 0x072 -> bdat = v;
            case 0x074 -> adat = v;
            default -> {
                return false;
            }
        }
        return true;
    }

    private static int hi(int p, int v) {
        return (v & 0x7) << 16 | (p & 0xffff);
    }

    private static int lo(int p, int v) {
        return (p & 0xffff0000) | (v & 0xfffe);
    }

    private void start(int size) {
        int h = size >> 6 & 0x3ff;
        int w = size & 0x3f;
        if (h == 0) h = 1024;
        if (w == 0) w = 64;
        boolean useA = (con0 & 0x800) != 0, useB = (con0 & 0x400) != 0;
        boolean useC = (con0 & 0x200) != 0, useD = (con0 & 0x100) != 0;
        int ash = con0 >>> 12, bsh = con1 >>> 12, mt = con0 & 0xff;
        int aPrev = 0, bPrev = 0;
        for (int y = 0; y < h; y++) {
            for (int x = 0; x < w; x++) {
                int a = adat;
                if (useA) {
                    a = mem.w(apt);
                    apt += 2;
                }
                if (x == 0) a &= afwm;
                if (x == w - 1) a &= alwm;
                int as = ((aPrev << 16 | a) >>> ash) & 0xffff;
                aPrev = a;
                int b = bdat;
                if (useB) {
                    b = mem.w(bpt);
                    bpt += 2;
                }
                int bs = ((bPrev << 16 | b) >>> bsh) & 0xffff;
                bPrev = b;
                int c = cdat;
                if (useC) {
                    c = mem.w(cpt);
                    cpt += 2;
                }
                int d = minterm(mt, as, bs, c);
                if (useD) {
                    mem.setW(dpt, d);
                    dpt += 2;
                }
            }
            if (useA) apt += amod;
            if (useB) bpt += bmod;
            if (useC) cpt += cmod;
            if (useD) dpt += dmod;
        }
    }

    private static int minterm(int mt, int a, int b, int c) {
        int na = ~a, nb = ~b, nc = ~c, d = 0;
        if ((mt & 0x80) != 0) d |= a & b & c;
        if ((mt & 0x40) != 0) d |= a & b & nc;
        if ((mt & 0x20) != 0) d |= a & nb & c;
        if ((mt & 0x10) != 0) d |= a & nb & nc;
        if ((mt & 0x08) != 0) d |= na & b & c;
        if ((mt & 0x04) != 0) d |= na & b & nc;
        if ((mt & 0x02) != 0) d |= na & nb & c;
        if ((mt & 0x01) != 0) d |= na & nb & nc;
        return d & 0xffff;
    }
}
