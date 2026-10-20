package nibby;

import java.awt.Canvas;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.image.BufferStrategy;
import java.awt.image.BufferedImage;
import java.awt.image.DataBufferInt;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import javax.imageio.ImageIO;
import javax.sound.sampled.AudioFileFormat;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.SourceDataLine;
import javax.swing.JFrame;

/**
 * Launcher of the native version.
 *
 * <pre>
 * java -jar nibbynibble.jar [--scale N] [--lives] [--time]
 * java -jar nibbynibble.jar --headless FRAMES OUTDIR [frame:action ...]
 * </pre>
 */
public final class Main {
    private static final int SAMPLES_PER_FRAME = ModPlayer.RATE / 50;
    private static final AudioFormat FORMAT = new AudioFormat(ModPlayer.RATE, 16, 2, true, false);

    public static void main(String[] args) throws Exception {
        int scale = 3;
        boolean lives = false, time = false;
        Integer frames = null;
        String out = null;
        List<String> script = new ArrayList<>();
        for (int i = 0; i < args.length; i++) {
            switch (args[i]) {
                case "--scale" -> scale = Integer.parseInt(args[++i]);
                case "--lives" -> lives = true;
                case "--time" -> time = true;
                case "--headless" -> {
                    frames = Integer.parseInt(args[++i]);
                    out = args[++i];
                }
                default -> script.add(args[i]);
            }
        }
        Input input = new Input();
        Game game = new Game(input, lives, time);
        game.start();
        if (frames != null) headless(game, input, frames, Path.of(out), script);
        else new Window(game, input, scale).run();
    }

    /** Runs without a window, saves frames and audio.wav: "100:fire+ 110:fire- 300:shot 120:key=T+ 123:key=T-". */
    static void headless(Game game, Input input, int frames, Path out, List<String> script) throws IOException {
        Files.createDirectories(out);
        BufferedImage img = new BufferedImage(Game.WIDTH, Game.HEIGHT, BufferedImage.TYPE_INT_RGB);
        int[] fb = ((DataBufferInt) img.getRaster().getDataBuffer()).getData();
        byte[] audio = new byte[SAMPLES_PER_FRAME * 4];
        ByteArrayOutputStream wav = new ByteArrayOutputStream();
        for (int f = 0; f < frames; f++) {
            boolean shot = false;
            for (String s : script) {
                String[] p = s.split(":", 2);
                if (Integer.parseInt(p[0]) != f) continue;
                String a = p[1];
                if (a.equals("shot")) {
                    shot = true;
                } else if (a.startsWith("key=")) {
                    // key=X (press and release), key=X+ / key=X- ; '_' stands for space
                    char c = a.charAt(4) == '_' ? ' ' : a.charAt(4);
                    if (a.length() == 5 || a.endsWith("+")) input.key(c, true);
                    if (a.length() == 5 || a.endsWith("-")) input.key(c, false);
                } else {
                    boolean on = a.endsWith("+");
                    switch (a.substring(0, a.length() - 1)) {
                        case "fire" -> input.fire = on;
                        case "up" -> input.up = on;
                        case "down" -> input.down = on;
                        case "left" -> input.left = on;
                        case "right" -> input.right = on;
                        case "lmb" -> input.lmb = on;
                        case "rmb" -> input.rmb = on;
                        case "esc" -> input.key((char) 27, on);
                        default -> throw new IllegalArgumentException(a);
                    }
                }
            }
            game.step(input.nextKey());
            game.render(fb);
            game.music().mix(audio, SAMPLES_PER_FRAME);
            wav.write(audio);
            if (shot) ImageIO.write(img, "png", out.resolve(String.format("frame%05d.png", f)).toFile());
        }
        byte[] pcm = wav.toByteArray();
        try (var ais = new AudioInputStream(new ByteArrayInputStream(pcm), FORMAT, pcm.length / 4)) {
            AudioSystem.write(ais, AudioFileFormat.Type.WAVE, out.resolve("audio.wav").toFile());
        }
    }

    /** Swing window; the audio line paces the loop at 50 frames per second. */
    static final class Window {
        private final Game game;
        private final Input input;
        private final JFrame frame = new JFrame("Nibby Nibble");
        private final Canvas canvas = new Canvas();
        private final BufferedImage image = new BufferedImage(Game.WIDTH, Game.HEIGHT, BufferedImage.TYPE_INT_RGB);
        private final int[] fb = ((DataBufferInt) image.getRaster().getDataBuffer()).getData();
        private volatile boolean running = true;

        Window(Game game, Input input, int scale) {
            this.game = game;
            this.input = input;
            canvas.setPreferredSize(new Dimension(Game.WIDTH * scale, Game.HEIGHT * scale));
            canvas.setBackground(Color.BLACK);
            canvas.setFocusTraversalKeysEnabled(false);
            frame.add(canvas);
            frame.pack();
            frame.setLocationRelativeTo(null);
            frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
            frame.addWindowListener(new WindowAdapter() {
                @Override
                public void windowClosing(WindowEvent e) {
                    running = false;
                }

                @Override
                public void windowClosed(WindowEvent e) {
                    running = false;
                }
            });
            KeyAdapter keys = new KeyAdapter() {
                @Override
                public void keyPressed(KeyEvent e) {
                    key(e, true);
                }

                @Override
                public void keyReleased(KeyEvent e) {
                    key(e, false);
                }
            };
            canvas.addKeyListener(keys);
            frame.addKeyListener(keys);
            canvas.addMouseListener(new MouseAdapter() {
                @Override
                public void mousePressed(MouseEvent e) {
                    mouse(e, true);
                }

                @Override
                public void mouseReleased(MouseEvent e) {
                    mouse(e, false);
                }
            });
        }

        private void mouse(MouseEvent e, boolean on) {
            if (e.getButton() == MouseEvent.BUTTON1) input.lmb = on;
            if (e.getButton() == MouseEvent.BUTTON3) input.rmb = on;
        }

        private final boolean[] down = new boolean[256];

        private void key(KeyEvent e, boolean on) {
            int k = e.getKeyCode();
            switch (k) {
                case KeyEvent.VK_UP, KeyEvent.VK_NUMPAD8 -> input.up = on;
                case KeyEvent.VK_DOWN, KeyEvent.VK_NUMPAD2 -> input.down = on;
                case KeyEvent.VK_LEFT, KeyEvent.VK_NUMPAD4 -> input.left = on;
                case KeyEvent.VK_RIGHT, KeyEvent.VK_NUMPAD6 -> input.right = on;
                case KeyEvent.VK_SHIFT, KeyEvent.VK_CONTROL, KeyEvent.VK_ENTER -> input.fire = on;
                case KeyEvent.VK_F10 -> running = false;
                default -> { }
            }
            char c = 0;
            if (k >= KeyEvent.VK_A && k <= KeyEvent.VK_Z) c = (char) k;
            else if (k == KeyEvent.VK_SPACE) c = ' ';
            else if (k == KeyEvent.VK_ESCAPE) c = 27;
            if (c != 0 && k < down.length && down[k] != on) {   // ignore key repeat
                down[k] = on;
                input.key(c, on);
            }
        }

        void run() throws Exception {
            frame.setVisible(true);
            canvas.createBufferStrategy(2);
            canvas.requestFocus();
            SourceDataLine line = openAudio();
            byte[] audio = new byte[SAMPLES_PER_FRAME * 4];
            long next = System.nanoTime();
            while (running) {
                game.step(input.nextKey());
                game.render(fb);
                game.music().mix(audio, SAMPLES_PER_FRAME);
                if (line != null) {
                    line.write(audio, 0, audio.length);       // blocks: 50 Hz pacing
                } else {
                    next += 20_000_000L;
                    long wait = next - System.nanoTime();
                    if (wait > 0) Thread.sleep(wait / 1_000_000, (int) (wait % 1_000_000));
                    else next = System.nanoTime();
                }
                present();
            }
            if (line != null) line.close();
            frame.dispose();
            System.exit(0);
        }

        private SourceDataLine openAudio() {
            try {
                SourceDataLine line = AudioSystem.getSourceDataLine(FORMAT);
                line.open(FORMAT, SAMPLES_PER_FRAME * 4 * 4);
                line.start();
                return line;
            } catch (Exception e) {
                System.err.println("No audio: " + e.getMessage());
                return null;
            }
        }

        private void present() {
            if (!canvas.isDisplayable()) {
                running = false;
                return;
            }
            try {
                BufferStrategy bs = canvas.getBufferStrategy();
                if (bs == null) {
                    canvas.createBufferStrategy(2);
                    return;
                }
                Graphics2D g = (Graphics2D) bs.getDrawGraphics();
                g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_NEAREST_NEIGHBOR);
                g.drawImage(image, 0, 0, canvas.getWidth(), canvas.getHeight(), null);
                g.dispose();
                if (!bs.contentsLost()) bs.show();
            } catch (IllegalStateException e) {
                if (!canvas.isDisplayable()) running = false;
            }
        }
    }
}
