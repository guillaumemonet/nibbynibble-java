package nibby.amiga;

/**
 * Rob Northen "ProPack" method 1 decompressor.
 * The original WHDLoad slave loads data/Nibby with resload_LoadFileDecrunch,
 * which unpacks this format transparently.
 */
public final class Rnc {
    private Rnc() {}

    public static boolean isPacked(byte[] d) {
        return d.length > 18 && d[0] == 'R' && d[1] == 'N' && d[2] == 'C' && d[3] == 1;
    }

    public static byte[] unpack(byte[] src) {
        if (!isPacked(src)) throw new IllegalArgumentException("not an RNC method 1 file");
        int ulen = be32(src, 4);
        byte[] in = new byte[src.length - 18 + 8];
        System.arraycopy(src, 18, in, 0, src.length - 18);
        return new Decoder(in, ulen).run();
    }

    private static int be32(byte[] d, int o) {
        return (d[o] & 0xff) << 24 | (d[o + 1] & 0xff) << 16 | (d[o + 2] & 0xff) << 8 | (d[o + 3] & 0xff);
    }

    private static final class Decoder {
        final byte[] in;
        final byte[] out;
        int p, o;
        long bitBuf;
        int bitCount;

        Decoder(byte[] in, int ulen) {
            this.in = in;
            this.out = new byte[ulen];
        }

        long lword(int i) {
            return (in[i] & 0xffL) | (in[i + 1] & 0xffL) << 8 | (in[i + 2] & 0xffL) << 16 | (in[i + 3] & 0xffL) << 24;
        }

        void advance(int n) {
            bitBuf >>>= n;
            bitCount -= n;
            if (bitCount < 16) {
                p += 2;
                bitBuf |= lword(p) << bitCount;
                bitCount += 16;
            }
        }

        int read(int mask, int n) {
            int x = (int) (bitBuf & mask);
            advance(n);
            return x;
        }

        void fix() {
            bitCount -= 16;
            bitBuf &= (1L << bitCount) - 1;
            bitBuf |= lword(p) << bitCount;
            bitCount += 16;
        }

        int[][] table() {
            int num = read(0x1f, 5);
            if (num == 0) return new int[0][];
            int[] len = new int[num];
            for (int i = 0; i < num; i++) len[i] = read(0xf, 4);
            int[][] t = new int[num][];
            int k = 0, code = 0;
            for (int bits = 1; bits <= 16; bits++) {
                for (int j = 0; j < num; j++) {
                    if (len[j] == bits) t[k++] = new int[] {mirror(code++, bits), bits, j};
                }
                code <<= 1;
            }
            int[][] r = new int[k][];
            System.arraycopy(t, 0, r, 0, k);
            return r;
        }

        static int mirror(int x, int n) {
            int r = 0;
            for (int i = 0; i < n; i++) r = r << 1 | (x >> i & 1);
            return r;
        }

        int huf(int[][] t) {
            for (int[] e : t) {
                if ((bitBuf & ((1L << e[1]) - 1)) == e[0]) {
                    advance(e[1]);
                    int v = e[2];
                    if (v >= 2) {
                        int base = 1 << (v - 1);
                        return base | read(base - 1, v - 1);
                    }
                    return v;
                }
            }
            throw new IllegalStateException("RNC: bad huffman code");
        }

        byte[] run() {
            bitBuf = lword(0);
            bitCount = 16;
            advance(2);
            while (o < out.length) {
                int[][] raw = table(), dist = table(), len = table();
                int count = read(0xffff, 16);
                while (true) {
                    int l = huf(raw);
                    if (l > 0) {
                        System.arraycopy(in, p, out, o, l);
                        p += l;
                        o += l;
                        fix();
                    }
                    if (--count <= 0) break;
                    int d = huf(dist) + 1;
                    l = huf(len) + 2;
                    for (int i = 0; i < l; i++, o++) out[o] = out[o - d];
                }
            }
            return out;
        }
    }
}
