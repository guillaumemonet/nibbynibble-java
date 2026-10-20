package nibby.amiga;

/**
 * Line-based PAL display: runs the copper list for one frame and converts the
 * planar bitplanes and hardware sprites into a 320x264 RGB framebuffer
 * (beam lines 44..307). Also computes sprite/playfield collisions (CLXDAT).
 */
public final class Video {
    public static final int WIDTH = 320;
    public static final int FIRST_LINE = 0x2c;
    public static final int HEIGHT = 264;
    private static final int LINES = 312;
    /**
     * Sprite HSTART that lines up with bitplane pixel 0 (DDFSTRT $38, DIWSTRT $81).
     * The game places the head sprite at 2x+$80 and blits the body at pixel 2x;
     * with $81 the head would sit one pixel left of the body and a tight vertical
     * U-turn would wrongly trigger the head/body collision.
     */
    private static final int HSTART0 = 0x80;

    private final Custom c;
    private final Memory mem;
    public final int[] pixels = new int[WIDTH * HEIGHT];
    /**
     * Frames during which the CPU hammers COLOR00 (cheat code: a dbra loop
     * writing a decreasing counter, roughly one write every 13 pixels).
     */
    public int flashFrames;
    private int flashValue;

    // sprite DMA state for the current frame
    private final int[] sprVStart = new int[8], sprVStop = new int[8], sprX = new int[8], sprData = new int[8];
    private final boolean[] sprAttach = new boolean[8];

    private int copPC;
    private boolean copStopped;
    private boolean diwOpen;

    // per-line scratch buffers
    private final int[] planes = new int[WIDTH];
    private final int[] sprCol = new int[WIDTH];
    private final int[] sprPair = new int[WIDTH];
    private final boolean[] spr01 = new boolean[WIDTH];
    private final int[][] sprVal = new int[8][WIDTH];

    public Video(Custom c) {
        this.c = c;
        this.mem = c.mem;
    }

    /** Runs one video frame; {@code copperInterrupt} services INTREQ COPER writes. */
    public void frame(Runnable copperInterrupt) {
        copPC = c.cop1lc;
        copStopped = false;
        c.copJump = null;
        diwOpen = false;
        for (int line = 0; line < LINES; line++) {
            runCopper(line, copperInterrupt);
            if (line == 25) fetchSpriteControl();
            updateWindow(line);
            if (line >= FIRST_LINE && line < FIRST_LINE + HEIGHT) renderLine(line);
        }
        if (flashFrames > 0) flashFrames--;
    }

    // ---------------------------------------------------------------- copper

    private void runCopper(int line, Runnable irq) {
        int guard = 0;
        while (!copStopped && guard++ < 4000) {
            int w1 = mem.w(copPC), w2 = mem.w(copPC + 2);
            if ((w1 & 1) == 0) {
                copPC += 4;
                c.w(w1 & 0x1fe, w2);
                if (c.copJump != null) {
                    copPC = c.copJump;
                    c.copJump = null;
                }
                if (c.copperInterrupt) {
                    c.copperInterrupt = false;
                    irq.run();
                }
                continue;
            }
            if ((w2 & 1) != 0) { // SKIP: not used by the game
                copPC += 4;
                continue;
            }
            int vp = w1 >> 8, hp = w1 & 0xfe;
            int vmask = 0x80 | (w2 >> 8 & 0x7f);
            if (hp > 0xe2 && (w2 & 0xfe) != 0) { // unreachable horizontal position: end of list
                copStopped = true;
                return;
            }
            // positions at the far right of a line take effect from the next line
            int beam = (w2 & 0xfe) != 0 && hp >= 0xd0 ? line - 1 : line;
            if (beam < 0 || ((beam & 0xff) & vmask) < (vp & vmask)) return;
            copPC += 4;
        }
    }

    // --------------------------------------------------------------- sprites

    private void fetchSpriteControl() {
        for (int s = 0; s < 8; s++) {
            sprVStart[s] = sprVStop[s] = -1;
            if ((c.dmacon & 0x220) != 0x220) continue;
            int p = c.sprpt[s];
            int pos = mem.w(p), ctl = mem.w(p + 2);
            sprVStart[s] = pos >> 8 | (ctl & 4) << 6;
            sprVStop[s] = ctl >> 8 | (ctl & 2) << 7;
            sprX[s] = (pos & 0xff) << 1 | (ctl & 1);
            sprAttach[s] = (ctl & 0x80) != 0;
            sprData[s] = p + 4;
        }
    }

    // --------------------------------------------------------------- display

    private void updateWindow(int line) {
        int vstart = c.diwstrt >> 8;
        int vstop = c.diwstop >> 8 | ((c.diwstop & 0x8000) == 0 ? 0x100 : 0);
        if (line == vstart) diwOpen = true;
        if (line == vstop) diwOpen = false;
    }

    private void renderLine(int line) {
        if (flashFrames > 0) flashValue -= 35;
        int y = line - FIRST_LINE;
        int base = y * WIDTH;
        int nplanes = c.bplcon0 >> 12 & 7;
        boolean dual = (c.bplcon0 & 0x400) != 0;
        boolean display = diwOpen && (c.dmacon & 0x300) == 0x300;

        java.util.Arrays.fill(planes, 0);
        if (display) {
            for (int p = 0; p < nplanes && p < 6; p++) {
                int ptr = c.bplpt[p];
                for (int bx = 0; bx < 40; bx++) {
                    int v = mem.b(ptr + bx);
                    if (v == 0) continue;
                    for (int k = 0; k < 8; k++) if ((v & 0x80 >> k) != 0) planes[bx * 8 + k] |= 1 << p;
                }
                c.bplpt[p] = ptr + 40 + ((p & 1) == 0 ? c.bpl1mod : c.bpl2mod);
            }
        }

        // sprites: gather the 2-bit value of each sprite at each pixel
        for (int[] row : sprVal) java.util.Arrays.fill(row, 0);
        for (int s = 0; s < 8; s++) {
            if (line < sprVStart[s] || line >= sprVStop[s]) continue;
            int a = mem.w(sprData[s]), b = mem.w(sprData[s] + 2);
            sprData[s] += 4;
            if (!display) continue;
            for (int i = 0; i < 16; i++) {
                int x = sprX[s] - HSTART0 + i;
                if (x >= 0 && x < WIDTH) sprVal[s][x] = (a >> (15 - i) & 1) | (b >> (15 - i) & 1) << 1;
            }
        }
        // resolve pairs: the lowest pair wins, attached pairs give 15 colours
        for (int x = 0; x < WIDTH; x++) {
            sprCol[x] = 0;
            spr01[x] = sprVal[0][x] != 0 || (c.clxcon & 0x1000) != 0 && sprVal[1][x] != 0;
            for (int p = 0; p < 4; p++) {
                int e = sprVal[2 * p][x], o = sprVal[2 * p + 1][x];
                int col = 0;
                if (sprAttach[2 * p + 1]) {
                    if ((e | o) != 0) col = 16 + (e | o << 2);
                } else if (e != 0) {
                    col = 16 + 4 * p + e;
                } else if (o != 0) {
                    col = 16 + 4 * p + o;
                }
                if (col != 0) {
                    sprCol[x] = col;
                    sprPair[x] = p;
                    break;
                }
            }
        }

        int pf1p = c.bplcon2 & 7, pf2p = c.bplcon2 >> 3 & 7;
        boolean pf2pri = (c.bplcon2 & 0x40) != 0;
        int clx = c.clxcon;
        for (int x = 0; x < WIDTH; x++) {
            int bits = planes[x];
            int col;
            int pf1 = 0, pf2 = 0;
            if (dual) {
                pf1 = (bits & 1) | (bits >> 1 & 2) | (bits >> 2 & 4);
                pf2 = (bits >> 1 & 1) | (bits >> 2 & 2) | (bits >> 3 & 4);
            } else {
                pf1 = bits;
            }
            int spr = sprCol[x];
            // depth: smaller is in front
            int best = Integer.MAX_VALUE;
            col = 0;
            if (spr != 0) {
                best = sprPair[x] * 8 + 4;
                col = spr;
            }
            if (pf1 != 0) {
                int d = pf1p * 8 + (dual && pf2pri ? 1 : 0);
                if (d < best) {
                    best = d;
                    col = pf1;
                }
            }
            if (pf2 != 0) {
                int d = pf2p * 8 + (pf2pri ? 0 : 1);
                if (d < best) {
                    col = 8 + pf2;
                }
            }
            // collisions of sprite group 0/1 with the playfields (CLXCON: ENBPx bits 6-11, MVBPx bits 0-5)
            if (spr01[x]) {
                if (match(bits, clx, 0) && match(bits, clx, 2) && match(bits, clx, 4)) c.clxdat |= 0x02;
                if (match(bits, clx, 1) && match(bits, clx, 3) && match(bits, clx, 5)) c.clxdat |= 0x20;
            }
            int rgb = c.color[col];
            if (col == 0 && flashFrames > 0) rgb = (flashValue - x / 13) & 0xfff;
            pixels[base + x] = 0xff000000 | (rgb >> 8 & 15) * 0x110000 | (rgb >> 4 & 15) * 0x1100 | (rgb & 15) * 0x11;
        }
    }

    private static boolean match(int bits, int clxcon, int plane) {
        if ((clxcon & 0x40 << plane) == 0) return true;
        return (bits >> plane & 1) == (clxcon >> plane & 1);
    }
}
