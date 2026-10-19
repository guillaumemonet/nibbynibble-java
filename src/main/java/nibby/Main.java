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
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import javax.imageio.ImageIO;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.SourceDataLine;
import javax.swing.JFrame;
import nibby.amiga.Input;
import nibby.amiga.Machine;
import nibby.amiga.Memory;
import nibby.amiga.Paula;
import nibby.amiga.Rnc;
import nibby.amiga.Video;
import nibby.game.NibbyNibble;

/**
 * Launcher: loads the original data file, starts the ported program and runs
 * the 50 Hz display/audio loop in a Swing window.
 *
 * <pre>
 * java -jar nibbynibble.jar [path/to/data/Nibby] [--scale N] [--lives] [--time]
 * java -jar nibbynibble.jar --headless FRAMES OUTDIR [frame:action ...]
 * </pre>
 */
public final class Main {
    private static final int LOAD_ADDRESS = 0x30000;
    private static final int SAMPLES_PER_FRAME = Paula.RATE / 50;

    public static void main(String[] args) throws Exception {
        String data = null;
        int scale = 3;
        boolean lives = false, time = false;
        Integer headlessFrames = null;
        String outDir = null;
        List<String> script = new ArrayList<>();
        for (int i = 0; i < args.length; i++) {
            switch (args[i]) {
                case "--scale" -> scale = Integer.parseInt(args[++i]);
                case "--lives" -> lives = true;
                case "--time" -> time = true;
                case "--data" -> data = args[++i];
                case "--headless" -> {
                    headlessFrames = Integer.parseInt(args[++i]);
                    outDir = args[++i];
                }
                default -> {
                    if (headlessFrames != null && args[i].contains(":")) script.add(args[i]);
                    else data = args[i];
                }
            }
        }

        Machine machine = new Machine();
        loadProgram(machine.mem, findData(data));
        NibbyNibble game = new NibbyNibble(machine, lives, time);
        machine.setInterrupts(game::level3Interrupt, game::keyboard);
        machine.start(game);

        if (headlessFrames != null) headless(machine, headlessFrames, Path.of(outDir), script);
        else new Window(machine, scale).run();
    }

    static Path findData(String explicit) throws IOException {
        List<String> candidates = explicit != null ? List.of(explicit)
                : List.of("data/Nibby", "nibbynibble/data/Nibby", "../nibbynibble/data/Nibby", "../../nibbynibble/data/Nibby");
        for (String c : candidates) {
            Path p = Path.of(c);
            if (Files.isRegularFile(p)) return p;
        }
        throw new IOException("data file 'Nibby' not found (tried " + candidates + "); pass its path as argument");
    }

    static void loadProgram(Memory mem, Path file) throws IOException {
        byte[] d = Files.readAllBytes(file);
        if (Rnc.isPacked(d)) d = Rnc.unpack(d);
        if (d.length != 0x40000) throw new IOException("unexpected size for " + file + ": " + d.length);
        mem.load(d, LOAD_ADDRESS);
    }

    /** Runs without a window, saves requested frames and audio.wav, for testing: "120:fire+ 125:fire- 300:shot". */
    static void headless(Machine m, int frames, Path out, List<String> script) throws IOException {
        Files.createDirectories(out);
        BufferedImage img = new BufferedImage(Video.WIDTH, Video.HEIGHT, BufferedImage.TYPE_INT_RGB);
        byte[] audio = new byte[SAMPLES_PER_FRAME * 4];
        var wav = new java.io.ByteArrayOutputStream();
        for (int f = 0; f < frames; f++) {
            for (String s : script) {
                String[] p = s.split(":", 2);
                if (Integer.parseInt(p[0]) != f) continue;
                if (p[1].equals("shot")) {
                    img.setRGB(0, 0, Video.WIDTH, Video.HEIGHT, m.video.pixels, 0, Video.WIDTH);
                    ImageIO.write(img, "png", out.resolve(String.format("frame%05d.png", f)).toFile());
                } else {
                    boolean on = p[1].endsWith("+");
                    String what = p[1].substring(0, p[1].length() - 1);
                    Input in = m.input;
                    switch (what) {
                        case "fire" -> in.fire = on;
                        case "up" -> in.up = on;
                        case "down" -> in.down = on;
                        case "left" -> in.left = on;
                        case "right" -> in.right = on;
                        case "lmb" -> in.lmb = on;
                        case "rmb" -> in.rmb = on;
                        default -> in.keyEvent(Integer.parseInt(what, 16), on);
                    }
                }
            }
            m.frame();
            m.custom.paula.mix(audio, SAMPLES_PER_FRAME);
            wav.write(audio);
        }
        byte[] pcm = wav.toByteArray();
        AudioFormat fmt = new AudioFormat(Paula.RATE, 16, 2, true, false);
        try (var ais = new javax.sound.sampled.AudioInputStream(new java.io.ByteArrayInputStream(pcm), fmt, pcm.length / 4)) {
            AudioSystem.write(ais, javax.sound.sampled.AudioFileFormat.Type.WAVE, out.resolve("audio.wav").toFile());
        }
    }

    /** Swing window; the audio line paces the loop at 50 frames per second. */
    static final class Window {
        private final Machine machine;
        private final JFrame frame = new JFrame("Nibby Nibble");
        private final Canvas canvas = new Canvas();
        private final BufferedImage image = new BufferedImage(Video.WIDTH, Video.HEIGHT, BufferedImage.TYPE_INT_RGB);
        private volatile boolean running = true;

        Window(Machine machine, int scale) {
            this.machine = machine;
            canvas.setPreferredSize(new Dimension(Video.WIDTH * scale, Video.HEIGHT * scale));
            canvas.setBackground(Color.BLACK);
            canvas.setFocusTraversalKeysEnabled(false);
            frame.add(canvas);
            frame.pack();
            frame.setLocationRelativeTo(null);
            frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
            frame.addWindowListener(new WindowAdapter() {
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
            if (e.getButton() == MouseEvent.BUTTON1) machine.input.lmb = on;
            if (e.getButton() == MouseEvent.BUTTON3) machine.input.rmb = on;
        }

        private void key(KeyEvent e, boolean on) {
            Input in = machine.input;
            switch (e.getKeyCode()) {
                case KeyEvent.VK_UP, KeyEvent.VK_NUMPAD8 -> in.up = on;
                case KeyEvent.VK_DOWN, KeyEvent.VK_NUMPAD2 -> in.down = on;
                case KeyEvent.VK_LEFT, KeyEvent.VK_NUMPAD4 -> in.left = on;
                case KeyEvent.VK_RIGHT, KeyEvent.VK_NUMPAD6 -> in.right = on;
                case KeyEvent.VK_SHIFT, KeyEvent.VK_CONTROL, KeyEvent.VK_ENTER -> in.fire = on;
                case KeyEvent.VK_F10 -> running = false;
                default -> { }
            }
            int raw = rawKey(e.getKeyCode());
            if (raw >= 0 && (on != pressed[raw])) {
                pressed[raw] = on;
                in.keyEvent(raw, on);
            }
        }

        private final boolean[] pressed = new boolean[128];

        /** AWT key code to Amiga raw key code (letters, digits, space, escape). */
        static int rawKey(int vk) {
            String rows = "QWERTYUIOP";
            String home = "ASDFGHJKL";
            String bottom = "ZXCVBNM";
            if (vk >= KeyEvent.VK_A && vk <= KeyEvent.VK_Z) {
                char c = (char) vk;
                if (rows.indexOf(c) >= 0) return 0x10 + rows.indexOf(c);
                if (home.indexOf(c) >= 0) return 0x20 + home.indexOf(c);
                return 0x31 + bottom.indexOf(c);
            }
            if (vk >= KeyEvent.VK_1 && vk <= KeyEvent.VK_9) return vk - KeyEvent.VK_1 + 1;
            return switch (vk) {
                case KeyEvent.VK_0 -> 0x0a;
                case KeyEvent.VK_SPACE -> 0x40;
                case KeyEvent.VK_ESCAPE -> 0x45;
                case KeyEvent.VK_ENTER -> 0x44;
                default -> -1;
            };
        }

        void run() throws Exception {
            frame.setVisible(true);
            canvas.createBufferStrategy(2);
            canvas.requestFocus();
            SourceDataLine line = openAudio();
            byte[] audio = new byte[SAMPLES_PER_FRAME * 4];
            long next = System.nanoTime();
            while (running) {
                machine.frame();
                machine.custom.paula.mix(audio, SAMPLES_PER_FRAME);
                if (line != null) {
                    line.write(audio, 0, audio.length);      // blocks: 50 Hz pacing
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
                AudioFormat fmt = new AudioFormat(Paula.RATE, 16, 2, true, false);
                SourceDataLine line = AudioSystem.getSourceDataLine(fmt);
                line.open(fmt, SAMPLES_PER_FRAME * 4 * 4);
                line.start();
                return line;
            } catch (Exception e) {
                System.err.println("No audio: " + e.getMessage());
                return null;
            }
        }

        private void present() {
            image.setRGB(0, 0, Video.WIDTH, Video.HEIGHT, machine.video.pixels, 0, Video.WIDTH);
            BufferStrategy bs = canvas.getBufferStrategy();
            Graphics2D g = (Graphics2D) bs.getDrawGraphics();
            g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_NEAREST_NEIGHBOR);
            g.drawImage(image, 0, 0, canvas.getWidth(), canvas.getHeight(), null);
            g.dispose();
            bs.show();
        }
    }
}
