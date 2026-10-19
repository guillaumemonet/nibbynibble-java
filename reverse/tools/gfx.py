import sys
from PIL import Image
d=open('work/nibby.bin','rb').read();B=0x30000
def w(a): return int.from_bytes(d[a-B:a-B+2],'big')
def l(a): return int.from_bytes(d[a-B:a-B+4],'big')
def rgb(c): return (((c>>8)&15)*17,((c>>4)&15)*17,(c&15)*17)
def planar(addr,wbytes,h,planes,planestride,rowstride,pal,scale=2):
    im=Image.new('RGB',(wbytes*8,h))
    for y in range(h):
        for x in range(wbytes*8):
            c=0
            for p in range(planes):
                b=d[addr-B+p*planestride+y*rowstride+x//8]
                if b&(0x80>>(x&7)): c|=1<<p
            im.putpixel((x,y),rgb(pal[c]) if c<len(pal) else (255,0,255))
    return im.resize((im.width*scale,im.height*scale),Image.NEAREST)
title=[0x000,0xfff,0xfc9,0xfa5,0xd81,0xb60,0x940,0x720,0xe0a,0xfe0,0xe00,0x58c,0x40a,0x75c,0x40a,0x0e0]
planar(0x38000,40,200,4,0x1f40,40,title,1).save('work/png/title.png')
sb=[0,0x0c0,0xddd,0xaaa,0x888,0x666,0x444,0x333]
planar(0x57800,40,37,3,0x5c8,40,sb,2).save('work/png/status.png')
planar(0x35054,40,8,1,0,40,[0,0xff0],2).save('work/png/leveltxt.png')
planar(0x34f3c,40,7,1,0,40,[0,0xff0],2).save('work/png/gameover.png')
planar(0x35194,1,8*16,1,0,1,[0,0xfff],4).save('work/png/digits.png')
# tiles per level
for i in range(10):
    p=l(0x318a2+4*i); pal=[w(l(p+12)+2*k) for k in range(8)]
    ims=[planar(l(p+4),2,16,3,2,6,pal,4),planar(l(p+8),2,16,3,2,6,pal,4)]
    im=Image.new('RGB',(128,64)); im.paste(ims[0],(0,0)); im.paste(ims[1],(64,0)); im.save('work/png/tiles%d.png'%(i+1))
def sprite(addr):
    rows=[]
    for y in range(16):
        a=w(addr+4+4*y); b=w(addr+6+4*y); rows.append((a,b))
    return rows
sp=[0,0xeca,0x0dd,0x70f,0xfe0,0xe00,0xa00,0x333,0,0xe00,0xa00,0x333,0,0,0xbbb,0x666]
im=Image.new('RGB',(16*16,16*6))
for n,base in enumerate([0x32484,0x32658,0x3282c,0x32a00]):
    for f in range(3):
        s0=sprite(base+f*0x90); s1=sprite(base+0x48+f*0x90)
        for y in range(16):
            for x in range(16):
                bit=0x8000>>x
                c=(1 if s0[y][0]&bit else 0)|(2 if s0[y][1]&bit else 0)|(4 if s1[y][0]&bit else 0)|(8 if s1[y][1]&bit else 0)
                im.putpixel((f*20+x,n*20+y),rgb(sp[c]) if c else (40,40,40))
print('ctl', ['%04x %04x'%(w(a),w(a+2)) for a in [0x32a00,0x32a48]])
# body shapes 32x32 rows (2 planes interleaved, 4 bytes wide)
for k,a in enumerate([0x32fc4,0x33044,0x330c4,0x33164,0x331e4,0x33264,0x33304]+[0x33384+0x80*i for i in range(9)]):
    for y in range(16):
        for x in range(32):
            p0=d[a-B+y*8+x//8]; p1=d[a-B+y*8+4+x//8]
            c=(1 if p0&(0x80>>(x&7)) else 0)|(2 if p1&(0x80>>(x&7)) else 0)
            im.putpixel((80+(k%5)*34+x, (k//5)*20+y), rgb([0x222,0xe00,0xa00,0xfff][c]))
im.resize((im.width*3,im.height*3),Image.NEAREST).save('work/png/sprites.png')
