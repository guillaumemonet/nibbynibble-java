package nibby.amiga;

import java.util.concurrent.Semaphore;
import java.util.function.BiConsumer;

/**
 * Glue between the ported 68000 program, which runs in its own thread and
 * blocks in {@link #vsync()} like the original busy-waits on the beam, and the
 * host loop which renders one PAL frame per {@link #frame()} call.
 */
public final class Machine {
    public final Memory mem = new Memory();
    public final Custom custom = new Custom(mem);
    public final Video video = new Video(custom);
    public final Input input = new Input();

    private final Semaphore toProgram = new Semaphore(0);
    private final Semaphore toHost = new Semaphore(0);
    private Runnable level3 = () -> { };
    private BiConsumer<Integer, Boolean> keyboard = (k, d) -> { };
    private Thread program;
    private volatile Throwable crash;

    public void setInterrupts(Runnable level3, BiConsumer<Integer, Boolean> keyboard) {
        this.level3 = level3;
        this.keyboard = keyboard;
    }

    public void start(Runnable entry) {
        program = new Thread(() -> {
            toProgram.acquireUninterruptibly();
            try {
                entry.run();
            } catch (Throwable t) {
                crash = t;
            } finally {
                toHost.release();
            }
        }, "68000");
        program.setDaemon(true);
        program.start();
    }

    /** Called by the program: wait for the next vertical blank. */
    public void vsync() {
        toHost.release();
        toProgram.acquireUninterruptibly();
    }

    /** Called by the host: display one frame, then let the program run until its next vsync. */
    public void frame() {
        Integer k = input.keys.poll();
        if (k != null) keyboard.accept(k & 0x7f, (k & 0x80) == 0);
        video.frame(level3);
        toProgram.release();
        toHost.acquireUninterruptibly();
        if (crash != null) throw new IllegalStateException("game code crashed", crash);
    }
}
