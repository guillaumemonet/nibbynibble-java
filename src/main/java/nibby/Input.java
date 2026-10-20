package nibby;

import java.util.concurrent.ConcurrentLinkedQueue;

/** Joystick (arrows), fire, mouse buttons and typed keys. */
public final class Input {
    public volatile boolean up, down, left, right, fire, lmb, rmb;

    /** Key presses (char) and releases (0), delivered to the game one per frame. */
    private final ConcurrentLinkedQueue<Character> keys = new ConcurrentLinkedQueue<>();

    public void key(char c, boolean pressed) {
        keys.add(pressed ? c : (char) 0);
    }

    Character nextKey() {
        return keys.poll();
    }
}
