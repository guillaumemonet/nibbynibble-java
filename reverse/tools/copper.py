import sys
d=open('work/nibby.bin','rb').read();B=0x30000
names={0x80:'COP1LCH',0x82:'COP1LCL',0x84:'COP2LCH',0x86:'COP2LCL',0x88:'COPJMP1',0x8a:'COPJMP2',0x8e:'DIWSTRT',0x90:'DIWSTOP',0x92:'DDFSTRT',0x94:'DDFSTOP',0x96:'DMACON',0x9c:'INTREQ',0x100:'BPLCON0',0x102:'BPLCON1',0x104:'BPLCON2',0x108:'BPL1MOD',0x10a:'BPL2MOD'}
for i in range(8): names[0xe0+4*i]='BPL%dPTH'%(i+1); names[0xe2+4*i]='BPL%dPTL'%(i+1)
for i in range(8): names[0x120+4*i]='SPR%dPTH'%i; names[0x122+4*i]='SPR%dPTL'%i
for i in range(32): names[0x180+2*i]='COLOR%02d'%i
for i in range(4): names[0x40+2*i]=['BLTCON0','BLTCON1','BLTAFWM','BLTALWM'][i]
a=int(sys.argv[1],0)
for k in range(int(sys.argv[2]) if len(sys.argv)>2 else 200):
    w1=int.from_bytes(d[a-B:a-B+2],'big'); w2=int.from_bytes(d[a-B+2:a-B+4],'big')
    if w1&1:
        print('%x: WAIT/SKIP %04x %04x'%(a,w1,w2))
        if w1==0xffff and w2==0xfffe: break
    else: print('%x: MOVE %s(%03x) = %04x'%(a,names.get(w1,'?'),w1,w2))
    a+=4
