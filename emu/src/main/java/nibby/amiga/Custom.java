package nibby.amiga;

/**
 * The custom chip register file ($DFF000). Both the "CPU" (the ported game
 * code) and the copper write through {@link #w(int, int)}.
 */
public final class Custom {
    public final Memory mem;
    public final Blitter blitter;
    public final Paula paula;

    // copper
    int cop1lc, cop2lc;
    Integer copJump;            // pending COPJMPx while the copper runs
    // display
    int diwstrt = 0x2c81, diwstop = 0x2cc1, ddfstrt = 0x38, ddfstop = 0xd0;
    int bplcon0, bplcon1, bplcon2, bpl1mod, bpl2mod;
    final int[] bplpt = new int[6];
    final int[] sprpt = new int[8];
    final int[] color = new int[32];
    int dmacon, clxcon, clxdat, intena;
    /** Set when INTREQ COPER is written; serviced by {@link Machine}. */
    boolean copperInterrupt;

    public Custom(Memory mem) {
        this.mem = mem;
        this.blitter = new Blitter(mem);
        this.paula = new Paula(mem);
    }

    /** move.w v,$dffxxx */
    public void w(int reg, int v) {
        reg &= 0x1fe;
        v &= 0xffff;
        if (blitter.write(reg, v) || paula.write(reg, v)) return;
        if (reg >= 0x180 && reg < 0x1c0) {
            color[(reg - 0x180) >> 1] = v & 0xfff;
            return;
        }
        if (reg >= 0x0e0 && reg < 0x0f8) {
            int i = (reg - 0x0e0) >> 2;
            bplpt[i] = (reg & 2) == 0 ? (v & 7) << 16 | (bplpt[i] & 0xffff) : (bplpt[i] & 0x70000) | (v & 0xfffe);
            return;
        }
        if (reg >= 0x120 && reg < 0x140) {
            int i = (reg - 0x120) >> 2;
            sprpt[i] = (reg & 2) == 0 ? (v & 7) << 16 | (sprpt[i] & 0xffff) : (sprpt[i] & 0x70000) | (v & 0xfffe);
            return;
        }
        switch (reg) {
            case 0x080 -> cop1lc = (v & 7) << 16 | (cop1lc & 0xffff);
            case 0x082 -> cop1lc = (cop1lc & 0x70000) | (v & 0xfffe);
            case 0x084 -> cop2lc = (v & 7) << 16 | (cop2lc & 0xffff);
            case 0x086 -> cop2lc = (cop2lc & 0x70000) | (v & 0xfffe);
            case 0x088 -> copJump = cop1lc;
            case 0x08a -> copJump = cop2lc;
            case 0x08e -> diwstrt = v;
            case 0x090 -> diwstop = v;
            case 0x092 -> ddfstrt = v;
            case 0x094 -> ddfstop = v;
            case 0x096 -> {
                boolean set = (v & 0x8000) != 0;
                dmacon = set ? dmacon | (v & 0x7fff) : dmacon & ~v;
                if ((v & 0xf) != 0) paula.dma(v & 0xf, set);
            }
            case 0x098 -> clxcon = v;
            case 0x09a -> intena = (v & 0x8000) != 0 ? intena | (v & 0x7fff) : intena & ~v;
            case 0x09c -> {
                if ((v & 0x8010) == 0x8010) copperInterrupt = true;
            }
            case 0x100 -> bplcon0 = v;
            case 0x102 -> bplcon1 = v;
            case 0x104 -> bplcon2 = v;
            case 0x108 -> bpl1mod = (short) (v & 0xfffe);
            case 0x10a -> bpl2mod = (short) (v & 0xfffe);
            default -> { }
        }
    }

    /** move.l v,$dffxxx */
    public void l(int reg, int v) {
        w(reg, v >>> 16);
        w(reg + 2, v);
    }

    /** move.w $dff00e,dx : CLXDAT is cleared by reading. */
    public int readClxdat() {
        int v = clxdat;
        clxdat = 0;
        return v | 0x8000;
    }
}
