import sys, capstone
data=open(sys.argv[1],'rb').read()
start=int(sys.argv[2],0); end=int(sys.argv[3],0); base=int(sys.argv[4],0) if len(sys.argv)>4 else 0
md=capstone.Cs(capstone.CS_ARCH_M68K, capstone.CS_MODE_BIG_ENDIAN|capstone.CS_MODE_M68K_000)
off=start
while off<end:
    got=False
    for i in md.disasm(data[off:end], base+off):
        print("%06x: %-20s %s %s"%(i.address, i.bytes.hex(), i.mnemonic, i.op_str)); off=i.address-base+i.size; got=True
    if off<end:
        print("%06x: dc.w %s"%(base+off, data[off:off+2].hex())); off+=2
