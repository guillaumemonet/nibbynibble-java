"""Extracts the assets of Nibby Nibble (Amiga, 1993) from the original data file.

usage: python extract_assets.py emu/original-assets/Nibby src/main/resources/assets

The data file is RNC ProPack packed; once unpacked it is a 256 KB memory image
loaded at $30000. Addresses below come from the analysis of the 68000 code
(see the emulated version in emu/). Images are written as indexed PNG files so
that the game can recolour them at run time (fades, death palette).
"""
import os
import struct
import sys

from PIL import Image

BASE = 0x30000


# ---------------------------------------------------------------- RNC unpack
def rnc_unpack(data):
    assert data[:3] == b'RNC' and data[3] == 1, 'not an RNC method 1 file'
    ulen = struct.unpack('>I', data[4:8])[0]
    buf = data[18:] + b'\0' * 8
    st = {'p': 0, 'bb': 0, 'bc': 16}

    def lword(i):
        return buf[i] | buf[i + 1] << 8 | buf[i + 2] << 16 | buf[i + 3] << 24

    def adv(n):
        st['bb'] >>= n
        st['bc'] -= n
        if st['bc'] < 16:
            st['p'] += 2
            st['bb'] |= lword(st['p']) << st['bc']
            st['bc'] += 16

    def read(mask, n):
        x = st['bb'] & mask
        adv(n)
        return x

    def fix():
        st['bc'] -= 16
        st['bb'] &= (1 << st['bc']) - 1
        st['bb'] |= lword(st['p']) << st['bc']
        st['bc'] += 16

    def mirror(x, n):
        r = 0
        for i in range(n):
            r = (r << 1) | ((x >> i) & 1)
        return r

    def table():
        num = read(0x1f, 5)
        t = []
        if not num:
            return t
        lens = [read(0xf, 4) for _ in range(num)]
        code = 0
        for bits in range(1, 17):
            for j in range(num):
                if lens[j] == bits:
                    t.append((mirror(code, bits), bits, j))
                    code += 1
            code <<= 1
        return t

    def huf(t):
        for code, bits, v in t:
            if st['bb'] & ((1 << bits) - 1) == code:
                adv(bits)
                if v >= 2:
                    base = 1 << (v - 1)
                    return base | read(base - 1, v - 1)
                return v
        raise ValueError('bad huffman code')

    out = bytearray()
    st['bb'] = lword(0)
    adv(2)
    while len(out) < ulen:
        raw, dist, ln = table(), table(), table()
        count = read(0xffff, 16)
        while True:
            n = huf(raw)
            if n:
                out += buf[st['p']:st['p'] + n]
                st['p'] += n
                fix()
            count -= 1
            if count <= 0:
                break
            dd = huf(dist) + 1
            n = huf(ln) + 2
            for _ in range(n):
                out.append(out[-dd])
    return bytes(out[:ulen])


# ---------------------------------------------------------------- helpers
class Mem:
    def __init__(self, data):
        self.d = data

    def b(self, a):
        return self.d[a - BASE]

    def w(self, a):
        return int.from_bytes(self.d[a - BASE:a - BASE + 2], 'big')

    def sw(self, a):
        v = self.w(a)
        return v - 0x10000 if v & 0x8000 else v

    def l(self, a):
        return int.from_bytes(self.d[a - BASE:a - BASE + 4], 'big')

    def bytes(self, a, n):
        return self.d[a - BASE:a - BASE + n]


def rgb12(c):
    return [((c >> 8) & 15) * 17, ((c >> 4) & 15) * 17, (c & 15) * 17]


def save_indexed(path, w, h, pixels, palette):
    im = Image.new('P', (w, h))
    pal = []
    for c in palette:
        pal += rgb12(c)
    pal += [0] * (768 - len(pal))
    im.putpalette(pal)
    im.putdata(pixels)
    im.save(path, transparency=0)


def planar(m, addr, wbytes, h, planes, plane_stride, row_stride):
    px = []
    for y in range(h):
        for x in range(wbytes * 8):
            c = 0
            for p in range(planes):
                if m.b(addr + p * plane_stride + y * row_stride + x // 8) & (0x80 >> (x & 7)):
                    c |= 1 << p
            px.append(c)
    return px


def sprite16(m, addr):
    """16 line hardware sprite: returns 2-bit values."""
    px = []
    for y in range(16):
        a, b = m.w(addr + 4 + 4 * y), m.w(addr + 6 + 4 * y)
        for x in range(16):
            bit = 0x8000 >> x
            px.append((1 if a & bit else 0) | (2 if b & bit else 0))
    return px


def attached16(m, a0, a1):
    lo, hi = sprite16(m, a0), sprite16(m, a1)
    return [l | h << 2 for l, h in zip(lo, hi)]


def shape16(m, addr):
    """Blitter shape: 32 px wide, 2 interleaved planes, 16 lines; only the left 16 px are used."""
    px = []
    for y in range(16):
        for x in range(16):
            bit = 0x80 >> (x & 7)
            p0 = m.b(addr + y * 8 + x // 8) & bit
            p1 = m.b(addr + y * 8 + 4 + x // 8) & bit
            px.append((1 if p0 else 0) | (2 if p1 else 0))
    return px


def mask16(m, addr):
    return [1 if v else 0 for v in shape16(m, addr)]


BODY_PAL = [0x000, 0xe00, 0xa00, 0x333]
SPRITE_PAL = [0x000, 0xeca, 0x0dd, 0x70f, 0xfe0, 0xe00, 0xa00, 0x333,
              0x000, 0xe00, 0xa00, 0x333, 0x000, 0x000, 0xbbb, 0x666]
MASK_PAL = [0x000, 0xfff]


def main(src, out):
    raw = open(src, 'rb').read()
    m = Mem(rnc_unpack(raw) if raw[:3] == b'RNC' else raw)
    for sub in ('', 'levels', 'sprites', 'shapes'):
        os.makedirs(os.path.join(out, sub), exist_ok=True)
    P = lambda *p: os.path.join(out, *p)

    # title: 4 planes of 320x200 at $38000, palette from the title copper list ($31D6E)
    title_pal = [m.w(0x31dac + 4 * i) for i in range(16)]
    save_indexed(P('title.png'), 320, 200, planar(m, 0x38000, 40, 200, 4, 0x1f40, 40), title_pal)

    # status bar: 3 planes of 320x37 at $57800 (palette from $31CD2)
    status_pal = [0x000] + [m.w(0x31d08 + 4 * i) for i in range(7)]
    save_indexed(P('statusbar.png'), 320, 37, planar(m, 0x57800, 40, 37, 3, 0x5c8, 40), status_pal)

    # "STAGE" and "GAME OVER" banners (1 plane, 320x7) and the 8x8 digits
    save_indexed(P('stage.png'), 320, 7, planar(m, 0x35054, 40, 7, 1, 0, 40), [0x000, 0xff0])
    save_indexed(P('gameover.png'), 320, 7, planar(m, 0x34f3c, 40, 7, 1, 0, 40), [0x000, 0xff0])
    save_indexed(P('digits.png'), 8, 80, planar(m, 0x35194, 1, 80, 1, 0, 1), [0x000, 0xfff])

    # colour tables
    rainbow = []
    a = 0x323d2
    while m.sw(a) >= 0:
        rainbow.append(m.w(a))
        a += 2
    with open(P('rainbow.txt'), 'w') as f:
        f.write('# copper rainbow ($323D2), 12-bit RGB\n')
        f.write(' '.join('%03x' % c for c in rainbow) + '\n')

    # levels: descriptor {map, wall tile, dot tile, palette}
    for i in range(10):
        desc = m.l(0x318a2 + 4 * i)
        mp, wall, dot, pal_addr = (m.l(desc + 4 * k) for k in range(4))
        pal = [m.w(pal_addr + 2 * k) for k in range(8)]
        n = '%02d' % (i + 1)
        # tiles: 16x16, 3 interleaved planes (2 bytes per plane line)
        save_indexed(P('levels', 'level%s_wall.png' % n), 16, 16, planar(m, wall, 2, 16, 3, 2, 6), pal)
        save_indexed(P('levels', 'level%s_dot.png' % n), 16, 16, planar(m, dot, 2, 16, 3, 2, 6), pal)
        rows = m.bytes(mp + 4, 280).decode('latin1')
        with open(P('levels', 'level%s.txt' % n), 'w') as f:
            f.write('# Nibby Nibble level %d\n' % (i + 1))
            f.write('dots=%d\n' % m.w(mp))
            f.write('time=%d\n' % m.w(mp + 2))
            f.write('palette=%s\n' % ' '.join('%03x' % c for c in pal))
            f.write('map:\n')
            for r in range(14):
                f.write(rows[r * 20:r * 20 + 20] + '\n')

    # head: attached sprite pairs, 4 directions x 3 frames (animation 0,1,2,1)
    for name, table in (('right', 0x32bb0), ('left', 0x329dc), ('down', 0x32634), ('up', 0x32808)):
        for f in range(3):
            a0, a1 = m.l(table + 8 * f), m.l(table + 8 * f + 4)
            save_indexed(P('sprites', 'head_%s_%d.png' % (name, f)), 16, 16, attached16(m, a0, a1), SPRITE_PAL)

    # tail sprites 4 and 5 (colours 24-27), horizontal / vertical, 3 frames
    for name, table in (('tail1_h', 0x32cac), ('tail1_v', 0x32da8), ('tail2_h', 0x32ea4), ('tail2_v', 0x32fa0)):
        for f in range(3):
            save_indexed(P('sprites', '%s_%d.png' % (name, f)), 16, 16, sprite16(m, m.l(table + 8 * f)), BODY_PAL)

    # "GR" signature sprites 6 and 7 on the bottom wall (colours 28-31), 6 lines each
    sig = []
    for y in range(6):
        for addr in (0x31916, 0x31936):
            a, b = m.w(addr + 4 + 4 * y), m.w(addr + 6 + 4 * y)
            for x in range(16):
                bit = 0x8000 >> x
                sig.append((1 if a & bit else 0) | (2 if b & bit else 0))
    save_indexed(P('sprites', 'signature.png'), 32, 6, sig, [0x000, 0x000, 0xbbb, 0x666])

    # body shapes (blitted, 2 planes) and masks
    for name, table in (('body_h', 0x33144), ('body_v', 0x332e4)):
        for f in range(3):
            save_indexed(P('shapes', '%s_%d.png' % (name, f)), 16, 16, shape16(m, m.l(table + 8 * f)), BODY_PAL)
    save_indexed(P('shapes', 'body_mask.png'), 16, 16, mask16(m, 0x33304), MASK_PAL)
    # death: 7 burning frames (shape + mask) and the 9 explosion shapes ($33384 + n*$80)
    for i in range(7):
        b, a = m.l(0x314c2 + 8 * i), m.l(0x314c6 + 8 * i)
        save_indexed(P('shapes', 'burn_%d.png' % i), 16, 16, shape16(m, b), BODY_PAL)
        save_indexed(P('shapes', 'burn_%d_mask.png' % i), 16, 16, mask16(m, a), MASK_PAL)
    for i in range(9):
        save_indexed(P('shapes', 'explosion_%d.png' % i), 16, 16, shape16(m, 0x33384 + 0x80 * i), BODY_PAL)
    seq = [(m.l(0x314fa + 4 * i) - 0x33384) // 0x80 for i in range(13)]
    with open(P('shapes', 'explosion.txt'), 'w') as f:
        f.write('# order of the explosion frames ($314FA)\n' + ' '.join(map(str, seq)) + '\n')

    # music: the ProTracker module at $40000
    mod = 0x40000
    npat = max(m.bytes(mod + 0x3b8, 128)) + 1
    size = 1084 + npat * 1024 + sum(m.w(mod + 0x2a + 30 * i) * 2 for i in range(31))
    with open(P('nib-rsi.mod'), 'wb') as f:
        f.write(m.bytes(mod, size))
    print('assets written to', out)


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])
