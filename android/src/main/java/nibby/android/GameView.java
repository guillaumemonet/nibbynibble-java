package nibby.android;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Rect;
import android.media.AudioAttributes;
import android.media.AudioFormat;
import android.media.AudioTrack;
import android.os.Build;
import android.view.MotionEvent;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import nibby.Game;
import nibby.Input;
import nibby.ModPlayer;

/**
 * Runs the game at 50 Hz (paced by the audio stream, like the desktop version),
 * draws the 320x262 frame scaled up without smoothing, and provides touch
 * controls: a direction pad on the left, a fire button on the right.
 */
@SuppressLint("ViewConstructor")
final class GameView extends SurfaceView implements SurfaceHolder.Callback, Runnable {
    private static final int SAMPLES_PER_FRAME = ModPlayer.RATE / 50;

    private final Game game;
    private final Input input;
    private final int[] fb = new int[Game.WIDTH * Game.HEIGHT];
    private final Bitmap frame = Bitmap.createBitmap(Game.WIDTH, Game.HEIGHT, Bitmap.Config.ARGB_8888);
    private final byte[] audio = new byte[SAMPLES_PER_FRAME * 4];
    private final Paint pixels = new Paint();
    private final Paint pad = new Paint(Paint.ANTI_ALIAS_FLAG), padOn = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint label = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Rect src = new Rect(0, 0, Game.WIDTH, Game.HEIGHT), dst = new Rect();

    private AudioTrack track;
    private Thread loop;
    private volatile boolean running, surface;

    // controls geometry (pixels)
    private float padX, padY, padR, fireX, fireY, fireR;
    private int touchDir;      // 0, or Game direction bits currently pressed by touch
    private boolean touchFire;

    GameView(Context context, Game game, Input input) {
        super(context);
        this.game = game;
        this.input = input;
        pixels.setFilterBitmap(false);
        pad.setColor(Color.argb(70, 255, 255, 255));
        padOn.setColor(Color.argb(150, 255, 210, 0));
        label.setColor(Color.argb(170, 255, 255, 255));
        label.setTextAlign(Paint.Align.CENTER);
        label.setFakeBoldText(true);
        getHolder().addCallback(this);
        setFocusable(true);
        setKeepScreenOn(true);
    }

    // ---------------------------------------------------------------- lifecycle

    void resume() {
        if (track == null) {
            int min = AudioTrack.getMinBufferSize(ModPlayer.RATE, AudioFormat.CHANNEL_OUT_STEREO, AudioFormat.ENCODING_PCM_16BIT);
            track = new AudioTrack.Builder()
                    .setAudioAttributes(new AudioAttributes.Builder()
                            .setUsage(AudioAttributes.USAGE_GAME)
                            .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC).build())
                    .setAudioFormat(new AudioFormat.Builder()
                            .setSampleRate(ModPlayer.RATE)
                            .setEncoding(AudioFormat.ENCODING_PCM_16BIT)
                            .setChannelMask(AudioFormat.CHANNEL_OUT_STEREO).build())
                    .setBufferSizeInBytes(Math.max(min, audio.length * 4))
                    .setTransferMode(AudioTrack.MODE_STREAM)
                    .build();
        }
        track.play();
        running = true;
        loop = new Thread(this, "nibby-loop");
        loop.start();
    }

    void pause() {
        running = false;
        if (loop != null) {
            try {
                loop.join(1000);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
            loop = null;
        }
        if (track != null) {
            track.pause();
            track.flush();
        }
        input.up = input.down = input.left = input.right = input.fire = false;
    }

    @Override
    public void surfaceCreated(SurfaceHolder holder) {
        surface = true;
    }

    @Override
    public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
        layout(width, height);
    }

    @Override
    public void surfaceDestroyed(SurfaceHolder holder) {
        surface = false;
    }

    /** Integer scaling when possible; controls in the side margins (over the picture if there is no room). */
    private void layout(int w, int h) {
        int scale = Math.min(w / Game.WIDTH, h / Game.HEIGHT);
        int gw, gh;
        if (scale >= 1) {
            gw = Game.WIDTH * scale;
            gh = Game.HEIGHT * scale;
        } else {
            float s = Math.min((float) w / Game.WIDTH, (float) h / Game.HEIGHT);
            gw = Math.round(Game.WIDTH * s);
            gh = Math.round(Game.HEIGHT * s);
        }
        int x = (w - gw) / 2, y = (h - gh) / 2;
        dst.set(x, y, x + gw, y + gh);
        float margin = x;
        float size = Math.min(h * 0.5f, Math.max(margin, w * 0.2f));
        padR = size * 0.42f;
        fireR = size * 0.32f;
        padX = margin >= padR * 2 ? margin / 2 : padR * 1.2f;
        fireX = margin >= fireR * 2 ? w - margin / 2 : w - fireR * 1.3f;
        padY = fireY = h * 0.62f;
        label.setTextSize(fireR * 0.42f);
    }

    // ---------------------------------------------------------------- loop

    @Override
    public void run() {
        while (running) {
            game.step(input.nextKey());
            game.render(fb);
            game.music().mix(audio, SAMPLES_PER_FRAME);
            track.write(audio, 0, audio.length);           // blocks: 50 frames per second
            if (surface) draw();
        }
    }

    private void draw() {
        SurfaceHolder holder = getHolder();
        Canvas c = Build.VERSION.SDK_INT >= 26 ? holder.lockHardwareCanvas() : holder.lockCanvas();
        if (c == null) return;
        try {
            frame.setPixels(fb, 0, Game.WIDTH, 0, 0, Game.WIDTH, Game.HEIGHT);
            c.drawColor(Color.BLACK);
            c.drawBitmap(frame, src, dst, pixels);
            drawControls(c);
        } finally {
            holder.unlockCanvasAndPost(c);
        }
    }

    private void drawControls(Canvas c) {
        c.drawCircle(padX, padY, padR, pad);
        float a = padR * 0.62f, t = padR * 0.22f;
        arrow(c, 0, -1, a, t, (touchDir & UP) != 0);
        arrow(c, 0, 1, a, t, (touchDir & DOWN) != 0);
        arrow(c, -1, 0, a, t, (touchDir & LEFT) != 0);
        arrow(c, 1, 0, a, t, (touchDir & RIGHT) != 0);
        c.drawCircle(fireX, fireY, fireR, touchFire ? padOn : pad);
        c.drawText("FIRE", fireX, fireY + label.getTextSize() * 0.35f, label);
    }

    private void arrow(Canvas c, int dx, int dy, float dist, float size, boolean on) {
        float cx = padX + dx * dist, cy = padY + dy * dist;
        Path p = new Path();
        p.moveTo(cx + dx * size, cy + dy * size);
        p.lineTo(cx - dx * size * 0.6f + dy * size, cy - dy * size * 0.6f + dx * size);
        p.lineTo(cx - dx * size * 0.6f - dy * size, cy - dy * size * 0.6f - dx * size);
        p.close();
        c.drawPath(p, on ? padOn : label);
    }

    // ---------------------------------------------------------------- touch

    private static final int RIGHT = 1, LEFT = 2, DOWN = 4, UP = 8;

    @Override
    @SuppressLint("ClickableViewAccessibility")
    public boolean onTouchEvent(MotionEvent e) {
        int dir = 0;
        boolean fire = false;
        int up = e.getActionMasked() == MotionEvent.ACTION_UP || e.getActionMasked() == MotionEvent.ACTION_CANCEL
                ? -2 : e.getActionMasked() == MotionEvent.ACTION_POINTER_UP ? e.getActionIndex() : -1;
        if (up != -2) {
            for (int i = 0; i < e.getPointerCount(); i++) {
                if (i == up) continue;
                float x = e.getX(i), y = e.getY(i);
                if (x < getWidth() / 2f) {
                    // direction pad: the dominant axis from its centre, with a small dead zone
                    float dx = x - padX, dy = y - padY;
                    if (Math.hypot(dx, dy) > padR * 0.15f)
                        dir = Math.abs(dx) > Math.abs(dy) ? (dx > 0 ? RIGHT : LEFT) : (dy > 0 ? DOWN : UP);
                } else {
                    fire = true;
                }
            }
        }
        touchDir = dir;
        touchFire = fire;
        input.right = (dir & RIGHT) != 0;
        input.left = (dir & LEFT) != 0;
        input.down = (dir & DOWN) != 0;
        input.up = (dir & UP) != 0;
        input.fire = fire;
        return true;
    }
}
