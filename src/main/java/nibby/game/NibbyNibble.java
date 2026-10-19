package nibby.game;

import nibby.amiga.Custom;
import nibby.amiga.Machine;
import nibby.amiga.Memory;

/**
 * Nibby Nibble (c) 1993 Gabriele Roncolato - Java port of the 68000 main
 * program (data/Nibby, unpacked and loaded at $30000).
 *
 * <p>The code follows the structure of the original routines; each method
 * names the address it was translated from. Graphics, copper lists, levels
 * and music are used straight from the original memory image, so the game
 * code still writes into copper lists, sprite control words and bitplanes
 * exactly like the original did. CPU variables live in Java fields (their
 * original address is given in the comment).
 */
public final class NibbyNibble implements Runnable {

    // ------------------------------------------------------------ memory map
    static final int COPPER_GAME = 0x31956;
    static final int COPPER_DEATH = 0x31a76;
    static final int COPPER_LEVEL = 0x31bfa;
    static final int COPPER_GAME_OVER = 0x31c66;
    static final int COPPER_STATUS = 0x31cd2;
    static final int COPPER_TITLE = 0x31d6e;

    static final int PLAYFIELD = 0x70000;          // 3 interleaved planes, 320x224, 120 bytes/line
    static final int STATUS_TEXT = 0x57a58;        // status bar plane 1, line 15
    static final int LEVEL_TEXT = 0x35054;         // "LEVEL" banner (1 plane, 320x7)
    static final int GAME_OVER_TEXT = 0x34f3c;
    static final int FONT_DIGITS = 0x35194;        // 8x8 digits
    static final int EMPTY_TILE = 0x33b04;
    static final int LEVEL_TABLE = 0x318a2;        // 10 level descriptors {map, wall, dot, palette}
    static final int CHEAT_KEYS = 0x31878;         // "THE RONCLER GANG" as raw keycodes, $FF terminated
    static final int RAINBOW = 0x323d2;            // colour table, negative terminated
    static final int START_TRAIL = 0x3044e;        // 15 initial (x,y) positions
    static final int START_COLOURS = 0x3048e;
    static final int SHIFT_TABLE = 0x34cbc, XOFF_TABLE = 0x34dfc, YOFF_TABLE = 0x35214;
    static final int BODY_MASK = 0x33304;
    static final int BODY_H = 0x33144, BODY_V = 0x332e4;           // animated body shape tables
    static final int TAIL1_V = 0x32da8, TAIL1_H = 0x32cac;         // sprite 4 shape tables
    static final int TAIL2_V = 0x32fa0, TAIL2_H = 0x32ea4;         // sprite 5 shape tables
    static final int HEAD_RIGHT = 0x32bb0, HEAD_LEFT = 0x329dc, HEAD_DOWN = 0x32634, HEAD_UP = 0x32808;
    static final int DEATH_SPIN = 0x3149c, DEATH_BURN = 0x314c2, DEATH_EXPLOSION = 0x314fa;
    static final int ERASE_MASK = 0x31556;

    // copper list words patched by the game
    static final int GAME_SPRITES = 0x319a8;       // SPR0,1,4,5 pointer values (low/high)
    static final int GAME_PF1_COLOURS = 0x319e8;   // COLOR00-07
    static final int GAME_BODY_COLOURS = 0x31a0c;  // COLOR09-11
    static final int GAME_SPR_COLOURS = 0x31a2c;   // COLOR17-23
    static final int GAME_TAIL_COLOURS = 0x31a4c;  // COLOR25-27
    static final int DEATH_PF1_COLOURS = 0x31b08;
    static final int STATUS_RAINBOW = 0x31d30;     // 7 x COLOR01
    static final int TITLE_RAINBOW = 0x31e34;      // 180 x COLOR14

    // directions ($318CA / $318D0)
    static final int RIGHT = 1, LEFT = 2, DOWN = 4, UP = 8;
    static final int KEY_ESC = 0x45;
    static final int HISTORY = 600;                // $35418-$35D78 ring of (x*2, y*2)

    private final Machine machine;
    private final Memory mem;
    private final Custom custom;
    private final Replay replay;

    // ------------------------------------------------------------ variables
    /** $3188A: last raw key code, written by the keyboard interrupt. */
    public volatile int key;
    private int lastKey;            // $3188B
    private int cheatPos;           // $3188C
    private boolean cheat;          // $31890: infinite lives (cheat code)
    private int level;              // $31892
    private int rainbow;            // $31894
    private int lives;              // $31896
    private int time;               // $31898
    private boolean timeOut;        // $3189A
    private boolean timerOn;        // $3189C
    private int timerFrames;        // $3189E
    private int score;              // $318A0
    private int wantDir;            // $318CA
    private int x = 0x50, y = 0xc0; // $318CC/$318CE: x in 2-pixel units, y in lines
    private int dir;                // $318D0
    private boolean dirChanged;     // $318D2
    private int segments;           // $318D4: blitted body segments (max 91)
    private int growCount = 2;      // $318D6
    private int growA = 2, growB = 1; // $318D8 (swapped after each growth)
    private int levelMap;           // $318DC: address of the level map
    private int dotsLeft;           // $318E0
    private boolean levelDone;      // $318E2
    private int headSpr0 = 0x32a00, headSpr1 = 0x32a48; // $318E4/$318E8
    private int headAnim = HEAD_RIGHT; // $318EC
    private int animDelay = 4;      // $318F0
    private int animFrame;          // $318F2
    private int bufFree = 0x60000, bufDraw = 0x65000, bufShow = 0x6a000; // $318FA/$318FE/$31902
    private int copDraw = 0x5e000, copShow = 0x5f000;                    // $31906/$3190A
    private final byte[] map = new byte[280];   // $33B64: working copy of the level
    private final int[] histX = new int[HISTORY], histY = new int[HISTORY];
    private int histIdx;            // $35414

    // trainer options of the WHDLoad install (CUSTOM1)
    private final boolean trainerLives, trainerTime;

    private enum Outcome { ESCAPE, COMPLETE, DEATH }

    public NibbyNibble(Machine machine, boolean trainerLives, boolean trainerTime) {
        this.machine = machine;
        this.mem = machine.mem;
        this.custom = machine.custom;
        this.replay = new Replay(mem, custom);
        this.trainerLives = trainerLives;
        this.trainerTime = trainerTime;
        replay.setTickHook(c -> {
            if (c == 1) printScore();
            else printTime();
        });
    }

    /** Level 3 (copper) interrupt, $3676E. */
    public void level3Interrupt() {
        music();
    }

    /** Keyboard interrupt, $3181A. */
    public void keyboard(int rawCode, boolean down) {
        key = down ? rawCode : 0;
    }

    private void vsync() {
        machine.vsync();
    }

    // ================================================================ flow

    /** Entry point at $30000. */
    @Override
    public void run() {
        custom.w(0x09a, 0x3fff);
        custom.w(0x096, 0x83e0);
        custom.w(0x096, 0x0400);
        replay.init();
        custom.w(0x09a, 0xc018);
        setPointer(0x31c88, 0x31c8c, GAME_OVER_TEXT);
        setPointer(0x31c1c, 0x31c20, LEVEL_TEXT);
        setPointer(0x319cc, 0x319c8, 0x31916);  // SPR6 / SPR7: decorations on the bottom wall
        setPointer(0x319d4, 0x319d0, 0x31936);
        cheatPos = 0;
        cheat = false;

        while (true) {
            titleScreen();
            // $30262: new game
            score = 0;
            printScore();
            timerOn = false;
            lives = 3;
            level = 1;                         // $305FE
            boolean playing = true;
            while (playing) {
                levelIntro();                  // $30606
                startLevel();                  // $300C4
                switch (mainLoop()) {
                    case ESCAPE -> {           // $301B2
                        fadeOut();
                        playing = false;
                    }
                    case COMPLETE -> {         // $305E8
                        fadeOut();
                        if (++level == 11) level = 1;
                    }
                    case DEATH -> playing = death();
                }
            }
        }
    }

    /** $301B6: title screen with copper rainbow, waits for fire or the cheat code. */
    private void titleScreen() {
        key = 0;
        custom.l(0x080, COPPER_TITLE);
        while (true) {
            vsync();
            int a = nextRainbow();
            for (int i = 0; i < 180; i++) {
                int v = mem.sw(a);
                a += 2;
                if (v < 0) {
                    a = RAINBOW;
                    v = mem.sw(a);
                    a += 2;
                }
                mem.setW(TITLE_RAINBOW + i * 8, v);
            }
            int k = key;
            if (k != 0 && k != lastKey) {
                lastKey = k;
                if (k == mem.b(CHEAT_KEYS + cheatPos)) cheatPos++;
                else cheatPos = 0;
                if ((mem.b(CHEAT_KEYS + cheatPos) & 0x80) != 0) {
                    // $30282: flash the background and start with infinite lives
                    machine.video.flashFrames = 12;
                    while (machine.video.flashFrames > 0) vsync();
                    cheat = true;
                    return;
                }
            }
            if (machine.input.fire) break;
        }
        while (machine.input.fire) vsync();
    }

    /** Advances the shared rainbow index ($31894), returns the table address to start from. */
    private int nextRainbow() {
        int idx = rainbow + 2;
        if (mem.sw(RAINBOW + idx) < 0) idx = 0;
        rainbow = idx;
        return RAINBOW + idx;
    }

    /** $30606: "LEVEL nn" screen, waits for fire. */
    private void levelIntro() {
        drawDigit(LEVEL_TEXT, 0x17, level % 10);
        drawDigit(LEVEL_TEXT, 0x16, level / 10 % 10);
        custom.l(0x080, COPPER_LEVEL);
        while (!machine.input.fire) vsync();
    }

    /** $300C4 */
    private void startLevel() {
        initGame();
        loadLevel();
        custom.l(0x080, COPPER_GAME);
        timerOn = true;
    }

    /** $300DE: the in-game frame loop. */
    private Outcome mainLoop() {
        while (true) {
            vsync();                                    // wait for raster line $100
            if (key == KEY_ESC) return Outcome.ESCAPE;
            music();
            clearBuffer();
            move();
            if (levelDone) return Outcome.COMPLETE;
            // right button + fire + left button: skip level
            if (machine.input.rmb && machine.input.fire && machine.input.lmb) return Outcome.COMPLETE;
            swapBuffers();
            int clx = custom.readClxdat();
            if ((clx & 0x20) != 0 || timeOut) return Outcome.DEATH;   // head sprite hit the body
            updateSprites();
            buildBlitList();
            statusRainbow();
        }
    }

    // ================================================================ init

    /** $3029C: reset snake, buffers, blitter and copper lists for a new life/level. */
    private void initGame() {
        mem.setL(0, 0);                         // null sprite at address 0
        wantDir = 0;
        x = 0x50;
        y = 0xc0;
        dir = 0;
        dirChanged = false;
        segments = 0;
        growCount = 2;
        growA = 2;
        growB = 1;
        headSpr0 = 0x32a00;
        headSpr1 = 0x32a48;
        headAnim = HEAD_RIGHT;
        animDelay = 4;
        histIdx = 0;
        for (int i = 0; i < 8; i++) mem.setW(GAME_SPRITES + i * 4, 0);
        levelDone = false;
        key = 0;
        lastKey = 0;
        timeOut = false;
        mem.fill(0x60000, 0x7d000, 0);
        mem.setL(copDraw, 0xfffffffe);
        mem.setL(copShow, 0xfffffffe);
        custom.l(0x044, 0xffffffff);
        custom.w(0x060, 0x24);
        custom.w(0x062, 0);
        custom.w(0x064, 0);
        custom.w(0x066, 0x24);
        custom.l(0x048, bufDraw);
        custom.l(0x04c, 0x32fc4);
        custom.l(0x050, BODY_MASK);
        custom.l(0x054, bufDraw);
        custom.w(0x098, 0x17df);                // CLXCON: sprites 0+1 vs playfields
        custom.readClxdat();
        for (int i = 0; i < 15; i++) {
            histX[i] = mem.w(START_TRAIL + i * 4);
            histY[i] = mem.w(START_TRAIL + i * 4 + 2);
        }
        int a = START_COLOURS;
        for (int i = 0; i < 3; i++, a += 2) {
            mem.setW(GAME_BODY_COLOURS + i * 4, mem.w(a));
            mem.setW(GAME_TAIL_COLOURS + i * 4, mem.w(a));
        }
        for (int i = 0; i < 7; i++, a += 2) mem.setW(GAME_SPR_COLOURS + i * 4, mem.w(a));
        drawDigit(STATUS_TEXT, 0x24, lives % 10);
    }

    /** $31656: copies the level map and draws its tiles with the blitter. */
    private void loadLevel() {
        int desc = mem.l(LEVEL_TABLE + (level - 1) * 4);
        int m = mem.l(desc);
        dotsLeft = mem.w(m);
        time = mem.w(m + 2);
        levelMap = m + 4;
        for (int i = 0; i < 280; i++) map[i] = (byte) mem.b(levelMap + i);
        int p = levelMap;
        for (int row = 0; row < 14; row++) {
            for (int col = 0; col < 20; col++) {
                int c = mem.b(p++);
                int src = c == ' ' ? EMPTY_TILE : c == '.' ? mem.l(desc + 8) : mem.l(desc + 4);
                custom.w(0x040, 0x09f0);
                custom.w(0x042, 0);
                custom.l(0x044, 0xffffffff);
                custom.l(0x050, src);
                custom.l(0x054, PLAYFIELD + row * 0x780 + col * 2);
                custom.w(0x064, 0);
                custom.w(0x066, 0x26);
                custom.w(0x058, 0x0c01);        // 16x48 (16 lines x 3 planes)
            }
        }
        int pal = mem.l(desc + 12);
        for (int i = 0; i < 8; i++) {
            mem.setW(GAME_PF1_COLOURS + i * 4, mem.w(pal + i * 2));
            mem.setW(DEATH_PF1_COLOURS + i * 4, mem.w(pal + i * 2));
        }
    }

    // ================================================================ per frame

    /** $367A6: one-second game timer, then the music replay. */
    private void music() {
        if (!cheat && timerOn && ++timerFrames == 50) {
            timerFrames = 0;
            if (time != 0 && !trainerTime) time--;
        }
        replay.tick();
    }

    /** $3083C: CPU clears the upper part of the free body buffer (the blitter does the rest). */
    private void clearBuffer() {
        mem.fill(bufFree + 0x2300, bufFree + 0x4100, 0);
    }

    /** $30AA2: rotates the three body buffers and the two blitter copper lists. */
    private void swapBuffers() {
        int a = bufFree, b = bufDraw, c = bufShow;
        bufFree = c;
        bufDraw = a;
        bufShow = b;
        mem.setW(0x31974, b);
        mem.setW(0x3197c, b + 0x28);
        mem.setW(0x31970, b >>> 16);
        mem.setW(0x31978, b >>> 16);
        int t = copDraw;
        copDraw = copShow;
        copShow = t;
        mem.setW(0x31a6c, copDraw);
        mem.setW(0x31a68, copDraw >>> 16);
    }

    /** $30B0C: joystick, wall tests and movement on the 16x16 grid. */
    private void move() {
        levelDone = false;
        if ((x & 7) == 0 && (y & 15) == 0) {
            int cell = (x >> 3) + (y >> 4) * 20;
            if (map[cell] == '.') {
                map[cell] = ' ';
                eatDot();
            }
            // $30B5E: a turn may be requested only perpendicular to the current motion
            var in = machine.input;
            if ((dir & (RIGHT | LEFT)) == 0 && in.right) wantDir = RIGHT;
            else if ((dir & (RIGHT | LEFT)) == 0 && in.left) wantDir = LEFT;
            else if ((dir & (DOWN | UP)) == 0) {
                if (in.down) wantDir = DOWN;
                else if (in.up) wantDir = UP;
            }
        } else {
            blocked();
        }
        dispatch();
    }

    /** $30BFE: keep the current direction; moving with no time left kills Nibby. */
    private void blocked() {
        if (time == 0) timeOut = true;
        wantDir = dir;
    }

    /** $30BCE */
    private void dispatch() {
        if ((wantDir & RIGHT) != 0) step(RIGHT, 0, 1, HEAD_RIGHT);
        else if ((wantDir & LEFT) != 0) step(LEFT, 0, -1, HEAD_LEFT);
        else if ((wantDir & DOWN) != 0) step(DOWN, 1, 0, HEAD_DOWN);
        else if ((wantDir & UP) != 0) step(UP, -1, 0, HEAD_UP);
        else dir = 0;
    }

    /** $30C1A/$30C7E/$30CE2/$30D48: move one step (x by 1 unit, y by 2 lines). */
    private void step(int d, int dy, int dx, int anim) {
        int c = peek(dy, dx);
        if (dir == d) {
            if (c == '0') return;               // facing a wall: stop
        } else {
            if (c == '0') {                     // turn refused
                blocked();
                dispatch();
                return;
            }
            dir = d;
            dirChanged = true;
            headAnim = anim;
        }
        x += dx;
        y += dy * 2;
        pushHistory();
    }

    /** $30DAE: map cell next to the head, '?' when between two cells. */
    private int peek(int dy, int dx) {
        if ((x & 7) != 0 || (y & 15) != 0) return '?';
        return mem.b(levelMap + ((y >> 4) + dy) * 20 + (x >> 3) + dx);
    }

    /** $30DEC */
    private void pushHistory() {
        histIdx = (histIdx + HISTORY - 1) % HISTORY;
        histX[histIdx] = x * 2 & 0xffff;
        histY[histIdx] = y * 2 & 0xffff;
    }

    private int hx(int k) {
        return histX[(histIdx + k) % HISTORY];
    }

    private int hy(int k) {
        return histY[(histIdx + k) % HISTORY];
    }

    /** $306F8: erase the dot tile, score, sound, growth. */
    private void eatDot() {
        int a = PLAYFIELD + ((x & 0xfff8) >> 2) + (y & 0xfff0) * 0x78;
        for (int i = 0; i < 48; i++) mem.setW(a + i * 0x28, 0);
        score = score + 1 & 0xffff;
        replay.playSfx(Replay.SFX_EAT);
        if (--dotsLeft == 0) {
            levelDone = true;
            return;
        }
        growCount = growCount - 1 & 0xffff;
        if (growCount != 0 || segments == 0x5b) return;
        segments++;
        int t = growA;
        growA = growB;
        growB = t;
        growCount = growB;
    }

    /** Writes VSTART/HSTART/VSTOP of a 16 line sprite (positions are stored doubled). */
    private void placeSprite(int spr, int sx, int sy) {
        mem.setB(spr, sy + 0x2c);
        mem.setB(spr + 2, sy + 0x2c + 0x10);
        mem.setB(spr + 1, sx + 0x40);
    }

    /** $30E24: head animation (sprites 0+1, attached) and the two tail sprites 4 and 5. */
    private void updateSprites() {
        int a2 = headSpr0, a3 = headSpr1;
        boolean next;
        if (dirChanged) {
            dirChanged = false;
            next = true;
        } else {
            next = --animDelay == 0;
        }
        if (next) {
            animDelay = 4;
            animFrame = animFrame + 8 == 0x20 ? 0 : animFrame + 8;
            a2 = mem.l(headAnim + animFrame);
            a3 = mem.l(headAnim + animFrame + 4);
        }
        placeSprite(a2, x, y);
        placeSprite(a3, x, y);
        headSpr0 = a2;
        headSpr1 = a3;
        mem.setW(GAME_SPRITES, a2);
        mem.setW(GAME_SPRITES + 4, a2 >>> 16);
        mem.setW(GAME_SPRITES + 8, a3);
        mem.setW(GAME_SPRITES + 12, a3 >>> 16);

        int s = mem.l((hx(5) == hx(6) ? TAIL1_V : TAIL1_H) + animFrame);
        placeSprite(s, hx(6) >> 1, hy(6) >> 1);
        mem.setW(GAME_SPRITES + 16, s);
        mem.setW(GAME_SPRITES + 20, s >>> 16);

        s = mem.l((hx(11) == hx(12) ? TAIL2_V : TAIL2_H) + animFrame);
        placeSprite(s, hx(12) >> 1, hy(12) >> 1);
        mem.setW(GAME_SPRITES + 24, s);
        mem.setW(GAME_SPRITES + 28, s >>> 16);
    }

    /**
     * $30F7E: writes the copper list that blits every body segment (one every
     * 6 steps of the trail) into the draw buffer during the next frame, then
     * clears part of the free buffer and jumps to the status bar copper list.
     */
    private void buildBlitList() {
        int shapeH = mem.l(BODY_H + animFrame), shapeV = mem.l(BODY_V + animFrame);
        int p = copDraw;
        p = cop(p, 0x066, 0x24);
        for (int i = 0, k = 18; i < segments; i++, k += 6) {
            int shape = hx(k - 1) == hx(k) ? shapeV : shapeH;
            int px = hx(k), py = hy(k);
            int dest = bufDraw + mem.w(XOFF_TABLE + px) + mem.sw(YOFF_TABLE + py);
            int shift = mem.w(SHIFT_TABLE + px);
            p = cop(p, 0x040, shift | 0x0fca);   // D = A ? B : C (cookie cut)
            p = cop(p, 0x042, shift);
            p = cop(p, 0x04a, dest);
            p = cop(p, 0x04e, shape);
            p = cop(p, 0x056, dest);
            p = cop(p, 0x052, BODY_MASK);
            p = cop(p, 0x058, 0x0802);
            for (int w = 0; w < 3; w++) {
                mem.setL(p, 0x00010000);         // wait for the blitter
                p += 4;
            }
        }
        int clear = bufFree + 0x500;
        p = cop(p, 0x056, clear);
        p = cop(p, 0x054, clear >>> 16);
        p = cop(p, 0x040, 0x01f0);
        p = cop(p, 0x042, 0);
        p = cop(p, 0x074, 0);
        p = cop(p, 0x066, 0);
        p = cop(p, 0x058, 0x1828);
        mem.setL(p, 0xffdffffe);
        mem.setL(p + 4, 0x0c01fffe);
        p += 8;
        p = cop(p, 0x086, COPPER_STATUS);
        p = cop(p, 0x084, COPPER_STATUS >>> 16);
        cop(p, 0x08a, 0);
    }

    private int cop(int p, int reg, int value) {
        mem.setW(p, reg);
        mem.setW(p + 2, value);
        return p + 4;
    }

    /** $306B4: cycles the status bar text colours. */
    private void statusRainbow() {
        int a = nextRainbow();
        for (int i = 0; i < 7; i++) {
            int v = mem.sw(a);
            a += 2;
            if (v < 0) {
                a = RAINBOW;
                v = mem.sw(a);
                a += 2;
            }
            mem.setW(STATUS_RAINBOW + i * 8, v);
        }
    }

    // ================================================================ end of level

    /** $304A2: fade body and sprite colours to white then black, then the maze. */
    private void fadeOut() {
        timerOn = false;
        mem.setL(copDraw, 0xfffffffe);
        mem.setL(copShow, 0xfffffffe);
        int[] snake = new int[13];
        for (int i = 0; i < 3; i++) snake[i] = GAME_BODY_COLOURS + i * 4;
        for (int i = 0; i < 7; i++) snake[3 + i] = GAME_SPR_COLOURS + i * 4;
        for (int i = 0; i < 3; i++) snake[10 + i] = GAME_TAIL_COLOURS + i * 4;
        int[] maze = new int[7];
        for (int i = 0; i < 7; i++) maze[i] = GAME_PF1_COLOURS + 4 + i * 4;
        fade(snake);
        fade(maze);
    }

    private void fade(int[] colours) {
        int white;
        do {
            twoFrames();
            white = 0;
            for (int a : colours) if (brighten(a)) white++;
        } while (white != colours.length);
        for (int i = 0; i < 15; i++) {
            twoFrames();
            for (int a : colours) mem.setW(a, mem.w(a) - 0x111);
        }
    }

    private void twoFrames() {
        vsync();
        music();
        vsync();
        music();
    }

    /** $30652: +1 on each RGB component; true when the colour is white. */
    private boolean brighten(int a) {
        int v = mem.w(a);
        int r = Math.min((v >> 8 & 15) + 1, 15), g = Math.min((v >> 4 & 15) + 1, 15), b = Math.min((v & 15) + 1, 15);
        v = r << 8 | g << 4 | b;
        mem.setW(a, v);
        return v == 0xfff;
    }

    // ================================================================ death

    /**
     * $3108C: the body burns from the tail to the head, the tail sprites
     * slide into the head, the head spins and explodes. Returns false on
     * game over.
     */
    private boolean death() {
        timerOn = false;
        custom.l(0x080, COPPER_DEATH);
        for (int i = 0; i < 32; i += 2) mem.setW(0x31ac2 + i, mem.w(0x319a6 + i));
        for (int i = 0; i < 16; i += 2) mem.setW(0x31a8a + i, mem.w(0x3196e + i));
        int count = segments;               // $31552
        vsync();
        vsync();
        vsync();
        custom.w(0x062, 0);
        custom.w(0x064, 0);
        custom.w(0x066, 0x24);
        custom.w(0x060, 0x24);

        int[] shift = new int[8], dest = new int[8];  // $3152E
        while (true) {
            vsync();
            int d0 = count--;
            java.util.Arrays.fill(shift, 0);
            java.util.Arrays.fill(dest, 0);
            boolean last = true;
            for (int j = 0; j < 8; j++, d0++) {
                if (d0 >= 1) {
                    if (d0 > segments) {
                        last = false;
                        break;
                    }
                    int k = 13 + 6 * d0;
                    dest[j] = bufShow + mem.w(XOFF_TABLE + hx(k)) + mem.sw(YOFF_TABLE + hy(k)) & 0xffff;
                    shift[j] = mem.w(SHIFT_TABLE + hx(k));
                }
            }
            if (last && d0 <= 1) break;
            for (int j = 1; j < 8; j++) {       // erase entries 1-7 (entry 7 is only erased)
                if (dest[j] == 0) continue;
                custom.w(0x040, shift[j] | 0x0bca);
                custom.w(0x042, shift[j]);
                custom.w(0x072, 0);
                custom.w(0x04a, dest[j]);
                custom.w(0x056, dest[j]);
                custom.l(0x050, ERASE_MASK);
                custom.w(0x058, 0x0802);
            }
            replay.playSfx(Replay.SFX_DEATH);
            for (int j = 0; j < 7; j++) {       // and draw the burning frames (entries 0-6)
                int b = mem.l(DEATH_BURN + j * 8), a = mem.l(DEATH_BURN + j * 8 + 4);
                if (dest[j] == 0) continue;
                custom.w(0x040, shift[j] | 0x0fca);
                custom.w(0x042, shift[j]);
                custom.w(0x04a, dest[j]);
                custom.w(0x04e, b);
                custom.w(0x056, dest[j]);
                custom.w(0x052, a);
                custom.w(0x058, 0x0802);
            }
        }

        // $31256: tail sprites slide into the head and vanish
        int lo = 0x31adc, hi = 0x31ae0, k = 12;
        for (int pass = 0; pass < 2; pass++) {
            for (int i = 0; i < 6; i++, k--) {
                vsync();
                int s = hx(k - 1) == hx(k) ? 0x32f10 : 0x32e14;
                placeSprite(s, hx(k) >> 1, hy(k) >> 1);
                mem.setW(lo, s);
                mem.setW(hi, s >>> 16);
            }
            mem.setW(lo, 0);
            mem.setW(hi, 0);
            lo = 0x31ad4;
            hi = 0x31ad8;
        }

        // $312D8: the head spins
        int spin = 0;
        for (int i = 0; i < 26; i++) {
            vsync();
            vsync();
            vsync();
            spin = spin + 8 == 0x20 ? 0 : spin + 8;
            int s0 = mem.l(DEATH_SPIN + spin), s1 = mem.l(DEATH_SPIN + spin + 4);
            placeSprite(s0, x, y);
            placeSprite(s1, x, y);
            mem.setW(0x31ac4, s0);
            mem.setW(0x31ac8, s0 >>> 16);
            mem.setW(0x31acc, s1);
            mem.setW(0x31ad0, s1 >>> 16);
        }
        for (int a = 0x31ac4; a <= 0x31ad0; a += 4) mem.setW(a, 0);

        // $31386: explosion drawn into the body playfield
        int px = x * 2, d = bufShow + mem.w(XOFF_TABLE + px) + mem.sw(YOFF_TABLE + y * 2);
        int sh = mem.w(SHIFT_TABLE + px);
        replay.playSfx(Replay.SFX_DEATH);
        for (int i = 0; i < 13; i++) {
            int shape = mem.l(DEATH_EXPLOSION + i * 4);
            vsync();
            vsync();
            custom.w(0x040, sh | 0x0fca);
            custom.w(0x042, sh);
            custom.w(0x04a, d);
            custom.l(0x04c, shape);
            custom.w(0x056, d);
            custom.l(0x050, BODY_MASK);
            custom.w(0x058, 0x0802);
        }
        for (int i = 0; i < 51; i++) vsync();

        // $31424
        if (cheat || trainerLives) return true;
        if (--lives >= 0) return true;
        custom.l(0x080, COPPER_GAME_OVER);
        for (int i = 0; i < 151; i++) vsync();
        return false;
    }

    // ================================================================ status bar

    /** $317F6: 8x8 digit into a 40 byte wide plane. */
    private void drawDigit(int base, int col, int digit) {
        int a = base + col, g = FONT_DIGITS + (digit & 15) * 8;
        for (int r = 0; r < 8; r++, a += 40) mem.setB(a, mem.b(g + r));
    }

    /** $31786 */
    private void printScore() {
        int s = score;
        for (int col = 0x0c; col >= 0x09; col--) {
            drawDigit(STATUS_TEXT, col, s % 10);
            s /= 10;
        }
    }

    /** $3174E */
    private void printTime() {
        drawDigit(STATUS_TEXT, 0x18, time % 10);
        drawDigit(STATUS_TEXT, 0x17, time / 10 % 10);
    }

    private void setPointer(int low, int high, int address) {
        mem.setW(low, address);
        mem.setW(high, address >>> 16);
    }
}
