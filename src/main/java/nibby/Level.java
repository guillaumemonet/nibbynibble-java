package nibby;

import java.util.List;

/** One of the 10 mazes: 20x14 cells of 16x16 pixels ('0' wall, '.' dot, ' ' empty). */
public final class Level {
    public static final int COLS = 20, ROWS = 14, TILE = 16;

    public final int number;
    public final int dots;
    public final int time;
    public final int[] palette;
    public final String[] map = new String[ROWS];
    public final Bitmap wall, dot;

    private Level(int number) {
        this.number = number;
        String n = String.format("levels/level%02d", number);
        List<String> lines = Assets.lines(n + ".txt");
        int dots = 0, time = 0;
        int[] pal = null;
        int row = -1;
        for (String l : lines) {
            if (row >= 0) {
                if (row < ROWS) map[row++] = l;
            } else if (l.startsWith("dots=")) {
                dots = Integer.parseInt(l.substring(5).trim());
            } else if (l.startsWith("time=")) {
                time = Integer.parseInt(l.substring(5).trim());
            } else if (l.startsWith("palette=")) {
                pal = Assets.colours(l.substring(8));
            } else if (l.startsWith("map:")) {
                row = 0;
            }
        }
        this.dots = dots;
        this.time = time;
        this.palette = pal;
        this.wall = Assets.bitmap(n + "_wall.png");
        this.dot = Assets.bitmap(n + "_dot.png");
    }

    public static Level load(int number) {
        return new Level(number);
    }

    public char cell(int col, int row) {
        return map[row].charAt(col);
    }
}
