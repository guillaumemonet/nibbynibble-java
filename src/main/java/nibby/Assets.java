package nibby;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UncheckedIOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.DataFormatException;
import java.util.zip.Inflater;

/**
 * Loads the assets extracted from the original game (src/main/resources/assets).
 * Pure Java (no AWT): the same code runs on the desktop and on Android, which
 * only has to provide where the files come from with {@link #setSource}.
 */
public final class Assets {
    private Assets() {}

    /** Opens an asset by its name relative to the assets folder. */
    public interface Source {
        InputStream open(String name) throws IOException;
    }

    private static Source source = name -> Assets.class.getResourceAsStream("/assets/" + name);

    public static void setSource(Source s) {
        source = s;
    }

    public static InputStream open(String name) {
        try {
            InputStream in = source.open(name);
            if (in == null) throw new IllegalStateException("missing asset " + name);
            return in;
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }

    public static byte[] bytes(String name) {
        try (InputStream in = open(name)) {
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            byte[] buf = new byte[8192];
            for (int n; (n = in.read(buf)) > 0; ) out.write(buf, 0, n);
            return out.toByteArray();
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }

    public static List<String> lines(String name) {
        List<String> out = new ArrayList<>();
        for (String l : new String(bytes(name), StandardCharsets.ISO_8859_1).split("\r?\n"))
            if (!l.startsWith("#")) out.add(l);
        return out;
    }

    /** Indexed PNG to palette indices. */
    public static Bitmap bitmap(String name) {
        return new Png(bytes(name), name).bitmap;
    }

    /** The palette stored in an indexed PNG, as Amiga 12-bit colours. */
    public static int[] palette(String name, int size) {
        int[] rgb = new Png(bytes(name), name).palette;
        int[] pal = new int[size];
        for (int i = 0; i < size && i < rgb.length; i++) {
            int c = rgb[i];
            pal[i] = ((c >> 16 & 255) / 17) << 8 | ((c >> 8 & 255) / 17) << 4 | (c & 255) / 17;
        }
        return pal;
    }

    /** "fff 0a0 ..." to 12-bit colours. */
    public static int[] colours(String line) {
        String[] t = line.trim().split("\\s+");
        int[] c = new int[t.length];
        for (int i = 0; i < t.length; i++) c[i] = Integer.parseInt(t[i], 16);
        return c;
    }

    /** Minimal decoder for non-interlaced indexed PNG files (colour type 3, 1/2/4/8 bits). */
    private static final class Png {
        Bitmap bitmap;
        int[] palette = new int[0];

        Png(byte[] d, String name) {
            if (d.length < 8 || (d[1] & 255) != 'P' || (d[2] & 255) != 'N' || (d[3] & 255) != 'G')
                throw new IllegalStateException(name + " is not a PNG file");
            int width = 0, height = 0, depth = 0;
            ByteArrayOutputStream idat = new ByteArrayOutputStream();
            for (int p = 8; p + 8 <= d.length; ) {
                int len = be32(d, p);
                String type = new String(d, p + 4, 4, StandardCharsets.ISO_8859_1);
                int data = p + 8;
                switch (type) {
                    case "IHDR" -> {
                        width = be32(d, data);
                        height = be32(d, data + 4);
                        depth = d[data + 8];
                        if (d[data + 9] != 3 || d[data + 12] != 0)
                            throw new IllegalStateException(name + " is not a non-interlaced indexed PNG");
                    }
                    case "PLTE" -> {
                        palette = new int[len / 3];
                        for (int i = 0; i < palette.length; i++)
                            palette[i] = (d[data + i * 3] & 255) << 16 | (d[data + i * 3 + 1] & 255) << 8 | (d[data + i * 3 + 2] & 255);
                    }
                    case "IDAT" -> idat.write(d, data, len);
                    default -> { }
                }
                p = data + len + 4;    // skip the CRC
            }
            int stride = (width * depth + 7) / 8;
            byte[] raw = inflate(idat.toByteArray(), (stride + 1) * height, name);
            bitmap = new Bitmap(width, height);
            byte[] prev = new byte[stride], cur = new byte[stride];
            int bpp = Math.max(1, depth / 8);
            for (int y = 0; y < height; y++) {
                int filter = raw[y * (stride + 1)];
                System.arraycopy(raw, y * (stride + 1) + 1, cur, 0, stride);
                for (int i = 0; i < stride; i++) {
                    int a = i >= bpp ? cur[i - bpp] & 255 : 0, b = prev[i] & 255, c = i >= bpp ? prev[i - bpp] & 255 : 0;
                    int pred = switch (filter) {
                        case 1 -> a;
                        case 2 -> b;
                        case 3 -> (a + b) >> 1;
                        case 4 -> paeth(a, b, c);
                        default -> 0;
                    };
                    cur[i] = (byte) (cur[i] + pred);
                }
                for (int x = 0; x < width; x++) {
                    int bit = x * depth;
                    int v = (cur[bit >> 3] & 255) >> (8 - depth - (bit & 7)) & ((1 << depth) - 1);
                    bitmap.set(x, y, v);
                }
                byte[] t = prev;
                prev = cur;
                cur = t;
            }
        }

        private static int paeth(int a, int b, int c) {
            int p = a + b - c, pa = Math.abs(p - a), pb = Math.abs(p - b), pc = Math.abs(p - c);
            return pa <= pb && pa <= pc ? a : pb <= pc ? b : c;
        }

        private static byte[] inflate(byte[] z, int size, String name) {
            Inflater inf = new Inflater();
            inf.setInput(z);
            byte[] out = new byte[size];
            try {
                int n = 0;
                while (n < size && !inf.finished()) {
                    int k = inf.inflate(out, n, size - n);
                    if (k == 0 && (inf.needsInput() || inf.needsDictionary())) break;
                    n += k;
                }
                if (n != size) throw new IllegalStateException(name + ": truncated image data");
                return out;
            } catch (DataFormatException e) {
                throw new IllegalStateException(name + ": " + e.getMessage(), e);
            } finally {
                inf.end();
            }
        }

        private static int be32(byte[] d, int o) {
            return (d[o] & 255) << 24 | (d[o + 1] & 255) << 16 | (d[o + 2] & 255) << 8 | (d[o + 3] & 255);
        }
    }
}
