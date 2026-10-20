import sys, struct
def unpack(data):
    assert data[:3]==b'RNC' and data[3]==1
    ulen,plen=struct.unpack('>II',data[4:12])
    buf=data[18:]+b'\0'*8
    p=[0]
    def lword(i): return buf[i]|buf[i+1]<<8|buf[i+2]<<16|buf[i+3]<<24
    st={'bb':lword(0),'bc':16}
    def adv(n):
        st['bb']>>=n; st['bc']-=n
        if st['bc']<16:
            p[0]+=2; st['bb']|=lword(p[0])<<st['bc']; st['bc']+=16
    def read(mask,n):
        x=st['bb']&mask; adv(n); return x
    def fix():
        st['bc']-=16; st['bb']&=(1<<st['bc'])-1; st['bb']|=lword(p[0])<<st['bc']; st['bc']+=16
    def mirror(x,n):
        r=0
        for i in range(n): r=(r<<1)|((x>>i)&1)
        return r
    def table():
        num=read(0x1f,5); t=[]
        if not num: return t
        ll=[read(0xf,4) for _ in range(num)]
        codeb=0
        for i in range(1,17):
            for j in range(num):
                if ll[j]==i: t.append((mirror(codeb,i),i,j)); codeb+=1
            codeb<<=1
        return t
    def huf(t):
        for code,cl,v in t:
            if st['bb']&((1<<cl)-1)==code: break
        else: raise Exception('bad huff')
        adv(cl)
        if v>=2:
            v2=1<<(v-1); v2|=read(v2-1,v-1); return v2
        return v
    out=bytearray()
    adv(2)
    while len(out)<ulen:
        raw=table(); dist=table(); ln=table()
        cnt=read(0xffff,16)
        while True:
            l=huf(raw)
            if l:
                out+=buf[p[0]:p[0]+l]; p[0]+=l; fix()
            cnt-=1
            if cnt<=0: break
            d=huf(dist)+1; l=huf(ln)+2
            for _ in range(l): out.append(out[-d])
    return bytes(out[:ulen])
if __name__=='__main__':
    d=open(sys.argv[1],'rb').read(); o=unpack(d); open(sys.argv[2],'wb').write(o); print(len(o))
