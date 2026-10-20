package nibby;

import java.awt.image.BufferedImage;
import java.awt.image.IndexColorModel;
import java.io.IOException;
import java.io.InputStream;
import java.io.UncheckedIOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import javax.imageio.ImageIO;

/** Loads the assets extracted from the original game (src/main/resources/assets). */
public final class Assets {
    private Assets() {}

    public static InputStream open(String name) {
        InputStream in = Assets.class.getResourceAsStream("/assets/" + name);
        if (in == null) throw new IllegalStateException("missing asset " + name);
        return in;
    }

    public static byte[] bytes(String name) {
        try (InputStream in = open(name)) {
            return in.readAllBytes();
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

    private static BufferedImage image(String name) {
        try (InputStream in = open(name)) {
            BufferedImage img = ImageIO.read(in);
            if (!(img.getColorModel() instanceof IndexColorModel))
                throw new IllegalStateException(name + " is not an indexed image");
            return img;
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }

    /** Indexed PNG to palette indices. */
    public static Bitmap bitmap(String name) {
        BufferedImage img = image(name);
        Bitmap b = new Bitmap(img.getWidth(), img.getHeight());
        var r = img.getRaster();
        for (int y = 0; y < b.height; y++)
            for (int x = 0; x < b.width; x++) b.set(x, y, r.getSample(x, y, 0));
        return b;
    }

    /** The palette stored in an indexed PNG, as Amiga 12-bit colours. */
    public static int[] palette(String name, int size) {
        IndexColorModel cm = (IndexColorModel) image(name).getColorModel();
        int[] pal = new int[size];
        for (int i = 0; i < size && i < cm.getMapSize(); i++)
            pal[i] = (cm.getRed(i) / 17) << 8 | (cm.getGreen(i) / 17) << 4 | cm.getBlue(i) / 17;
        return pal;
    }

    /** "fff 0a0 ..." to 12-bit colours. */
    public static int[] colours(String line) {
        String[] t = line.trim().split("\\s+");
        int[] c = new int[t.length];
        for (int i = 0; i < t.length; i++) c[i] = Integer.parseInt(t[i], 16);
        return c;
    }
}
