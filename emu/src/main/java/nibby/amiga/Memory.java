package nibby.amiga;

/** 512 KB of chip memory, big-endian like the 68000. */
public final class Memory {
    public static final int SIZE = 0x80000;
    private static final int MASK = SIZE - 1;
    final byte[] ram = new byte[SIZE];

    public void load(byte[] data, int address) {
        System.arraycopy(data, 0, ram, address, Math.min(data.length, SIZE - address));
    }

    public int b(int a) {
        return ram[a & MASK] & 0xff;
    }

    /** signed byte */
    public int sb(int a) {
        return ram[a & MASK];
    }

    public int w(int a) {
        a &= MASK;
        return (ram[a] & 0xff) << 8 | (ram[a + 1] & 0xff);
    }

    /** signed word */
    public int sw(int a) {
        return (short) w(a);
    }

    public int l(int a) {
        return w(a) << 16 | w(a + 2);
    }

    public void setB(int a, int v) {
        ram[a & MASK] = (byte) v;
    }

    public void setW(int a, int v) {
        a &= MASK;
        ram[a] = (byte) (v >> 8);
        ram[a + 1] = (byte) v;
    }

    public void setL(int a, int v) {
        setW(a, v >>> 16);
        setW(a + 2, v);
    }

    public void fill(int from, int to, int v) {
        java.util.Arrays.fill(ram, from, Math.min(to, SIZE), (byte) v);
    }
}
