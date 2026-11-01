package nibby.android;

import android.app.Activity;
import android.os.Build;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import nibby.Assets;
import nibby.Game;
import nibby.Input;

/** Android front end: full screen landscape, the game view, keys and gamepads. */
public final class MainActivity extends Activity {
    // one game for the whole process: it keeps running state across activity restarts
    private static Input input;
    private static Game game;

    private GameView view;

    @Override
    protected void onCreate(Bundle state) {
        super.onCreate(state);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON | WindowManager.LayoutParams.FLAG_FULLSCREEN);
        if (Build.VERSION.SDK_INT >= 28) {
            getWindow().getAttributes().layoutInDisplayCutoutMode =
                    WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
        }
        if (game == null) {
            Assets.setSource(name -> getApplicationContext().getAssets().open(name));
            input = new Input();
            game = new Game(input, false, false);
            game.start();
        }
        view = new GameView(this, game, input, new GameView.Buttons() {
            @Override
            public void back() {
                runOnUiThread(MainActivity.this::goBack);
            }

            @Override
            public void quit() {
                runOnUiThread(MainActivity.this::quit);
            }
        });
        setContentView(view);
    }

    @Override
    protected void onResume() {
        super.onResume();
        hideSystemBars();
        view.resume();
    }

    @Override
    protected void onPause() {
        view.pause();
        super.onPause();
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
        if (hasFocus) hideSystemBars();
    }

    @SuppressWarnings("deprecation")
    private void hideSystemBars() {
        view.setSystemUiVisibility(View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY | View.SYSTEM_UI_FLAG_FULLSCREEN
                | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION | View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION);
    }

    @Override
    @SuppressWarnings("deprecation")
    public void onBackPressed() {
        goBack();
    }

    /** Back: Esc during a game (back to the title, like on the Amiga), quit from the title screen. */
    private void goBack() {
        if (game.onTitle()) {
            quit();
        } else {
            input.key((char) 27, true);
            input.key((char) 27, false);
        }
    }

    /** Closes the game for good: the next launch starts again from the title screen. */
    private void quit() {
        finishAndRemoveTask();
        view.pause();
        System.exit(0);
    }

    @Override
    public boolean onKeyDown(int code, KeyEvent e) {
        return key(code, e, true) || super.onKeyDown(code, e);
    }

    @Override
    public boolean onKeyUp(int code, KeyEvent e) {
        return key(code, e, false) || super.onKeyUp(code, e);
    }

    /** Gamepads and physical keyboards. */
    private boolean key(int code, KeyEvent e, boolean down) {
        switch (code) {
            case KeyEvent.KEYCODE_DPAD_UP -> input.up = down;
            case KeyEvent.KEYCODE_DPAD_DOWN -> input.down = down;
            case KeyEvent.KEYCODE_DPAD_LEFT -> input.left = down;
            case KeyEvent.KEYCODE_DPAD_RIGHT -> input.right = down;
            case KeyEvent.KEYCODE_BUTTON_A, KeyEvent.KEYCODE_BUTTON_B, KeyEvent.KEYCODE_BUTTON_X,
                 KeyEvent.KEYCODE_BUTTON_Y, KeyEvent.KEYCODE_DPAD_CENTER, KeyEvent.KEYCODE_ENTER,
                 KeyEvent.KEYCODE_SHIFT_LEFT, KeyEvent.KEYCODE_SHIFT_RIGHT,
                 KeyEvent.KEYCODE_CTRL_LEFT, KeyEvent.KEYCODE_CTRL_RIGHT -> input.fire = down;
            case KeyEvent.KEYCODE_ESCAPE, KeyEvent.KEYCODE_BUTTON_START -> {
                if (e.getRepeatCount() == 0) input.key((char) 27, down);
            }
            case KeyEvent.KEYCODE_SPACE -> {
                if (e.getRepeatCount() == 0) input.key(' ', down);   // the cheat code contains spaces
            }
            default -> {
                if (code >= KeyEvent.KEYCODE_A && code <= KeyEvent.KEYCODE_Z) {
                    if (e.getRepeatCount() == 0) input.key((char) ('A' + code - KeyEvent.KEYCODE_A), down);
                } else {
                    return false;
                }
            }
        }
        return true;
    }
}
