package nibby;

/** An image made of palette indices (0 is transparent for sprites and shapes). */
public final class Bitmap {
    public final int width, height;
    public final byte[] px;

    public Bitmap(int width, int height) {
        this.width = width;
        this.height = height;
        this.px = new byte[width * height];
    }

    public int get(int x, int y) {
        return px[y * width + x];
    }

    public void set(int x, int y, int v) {
        px[y * width + x] = (byte) v;
    }

    public Bitmap copy() {
        Bitmap b = new Bitmap(width, height);
        System.arraycopy(px, 0, b.px, 0, px.length);
        return b;
    }

    public void clear() {
        java.util.Arrays.fill(px, (byte) 0);
    }

    /** Copies all pixels of {@code src} (including 0) at (x, y). */
    public void paste(Bitmap src, int x, int y) {
        for (int j = 0; j < src.height; j++)
            for (int i = 0; i < src.width; i++) put(x + i, y + j, src.get(i, j));
    }

    /** Cookie cut: where {@code mask} is set, the pixel is replaced by the one of {@code src}. */
    public void cut(Bitmap src, Bitmap mask, int x, int y) {
        for (int j = 0; j < src.height; j++)
            for (int i = 0; i < src.width; i++)
                if (mask.get(i, j) != 0) put(x + i, y + j, src.get(i, j));
    }

    /** Sets a rectangle to 0. */
    public void erase(int x, int y, int w, int h) {
        for (int j = 0; j < h; j++)
            for (int i = 0; i < w; i++) put(x + i, y + j, 0);
    }

    private void put(int x, int y, int v) {
        if (x >= 0 && y >= 0 && x < width && y < height) px[y * width + x] = (byte) v;
    }
}
