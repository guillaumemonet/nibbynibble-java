package nibby.amiga;

import java.util.concurrent.ConcurrentLinkedQueue;

/** Joystick in port 2, mouse buttons and keyboard events. */
public final class Input {
    public volatile boolean up, down, left, right, fire, lmb, rmb;

    /** Amiga raw key events (code, or code|0x80 when released), delivered one per frame. */
    final ConcurrentLinkedQueue<Integer> keys = new ConcurrentLinkedQueue<>();

    public void keyEvent(int rawCode, boolean pressed) {
        keys.add(pressed ? rawCode : rawCode | 0x80);
    }
}
