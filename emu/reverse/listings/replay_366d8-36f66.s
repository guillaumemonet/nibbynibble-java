0366d8: 41f900040000         lea.l $40000.l, a0
0366de: 43fa0392             lea.l $36a72(pc), a1
0366e2: 203c0004000c         move.l #$4000c, d0
0366e8: 721f                 moveq #$1f, d1
0366ea: 761e                 moveq #$1e, d3
0366ec: 22c0                 move.l d0, (a1)+
0366ee: d083                 add.l d3, d0
0366f0: 51c9fffa             dbra d1, $366ec
0366f4: 43e803b8             lea.l $3b8(a0), a1
0366f8: 707f                 moveq #$7f, d0
0366fa: 7200                 moveq #$0, d1
0366fc: 7400                 moveq #$0, d2
0366fe: 1219                 move.b (a1)+, d1
036700: b202                 cmp.b d2, d1
036702: 6f02                 ble.b $36706
036704: 2401                 move.l d1, d2
036706: 51c8fff6             dbra d0, $366fe
03670a: 5242                 addq.w #$1, d2
03670c: e182                 asl.l #$8, d2
03670e: e582                 asl.l #$2, d2
036710: 45f12804             lea.l $4(a1, d2.l), a2
036714: 43fa0764             lea.l $36e7a(pc), a1
036718: d0fc002a             adda.w #$2a, a0
03671c: 701e                 moveq #$1e, d0
03671e: 4292                 clr.l (a2)
036720: 22ca                 move.l a2, (a1)+
036722: 7200                 moveq #$0, d1
036724: 11410002             move.b d1, $2(a0)
036728: 3210                 move.w (a0), d1
03672a: e381                 asl.l #$1, d1
03672c: d5c1                 adda.l d1, a2
03672e: d1c3                 adda.l d3, a0
036730: 51c8ffec             dbra d0, $3671e
036734: 237800780070         move.l $78.w, $70(a1)
03673a: 0039000200bfe001     ori.b #$2, $bfe001.l
036742: 137c0006ff7c         move.b #$6, -$84(a1)
036748: 7000                 moveq #$0, d0
03674a: 41f900dff000         lea.l $dff000.l, a0
036750: 314000a8             move.w d0, $a8(a0)
036754: 314000b8             move.w d0, $b8(a0)
036758: 314000c8             move.w d0, $c8(a0)
03675c: 314000d8             move.w d0, $d8(a0)
036760: 1340ff80             move.b d0, -$80(a1)
036764: 1340ff7d             move.b d0, -$83(a1)
036768: 3340ff7e             move.w d0, -$82(a1)
03676c: 4e75                 rts 
03676e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
036772: 61000032             bsr.w $367a6
036776: 4cdf7fff             movem.l (a7)+, d0-d7/a0-a6
03677a: 33fc001000dff09c     move.w #$10, $dff09c.l
036782: 4e73                 rte 
036784: 7000                 moveq #$0, d0
036786: 41f900dff000         lea.l $dff000.l, a0
03678c: 314000a8             move.w d0, $a8(a0)
036790: 314000b8             move.w d0, $b8(a0)
036794: 314000c8             move.w d0, $c8(a0)
036798: 314000d8             move.w d0, $d8(a0)
03679c: 33fc000f00dff096     move.w #$f, $dff096.l
0367a4: 4e75                 rts 
0367a6: 4a7900031890         tst.w $31890.l
0367ac: 6632                 bne.b $367e0
0367ae: 4a790003189c         tst.w $3189c.l
0367b4: 672a                 beq.b $367e0
0367b6: 067900010003189e     addi.w #$1, $3189e.l
0367be: 0c7900320003189e     cmpi.w #$32, $3189e.l
0367c6: 6618                 bne.b $367e0
0367c8: 33fc00000003189e     move.w #$0, $3189e.l
0367d0: 4a7900031898         tst.w $31898.l
0367d6: 6708                 beq.b $367e0
0367d8: 0479000100031898     subi.w #$1, $31898.l
0367e0: 41f900040000         lea.l $40000.l, a0
0367e6: 49fa070e             lea.l $36ef6(pc), a4
0367ea: 522cff7d             addq.b #$1, -$83(a4)
0367ee: 103a0683             move.b $36e73(pc), d0
0367f2: b03a067e             cmp.b $36e72(pc), d0
0367f6: 6d000146             blt.w $3693e
0367fa: 7000                 moveq #$0, d0
0367fc: 1940ff7d             move.b d0, -$83(a4)
036800: 3940ff82             move.w d0, -$7e(a4)
036804: 41f900040000         lea.l $40000.l, a0
03680a: 45e803b8             lea.l $3b8(a0), a2
03680e: 41e8043c             lea.l $43c(a0), a0
036812: 7200                 moveq #$0, d1
036814: 103a0660             move.b $36e76(pc), d0
036818: 12320000             move.b (a2, d0.w), d1
03681c: e149                 lsl.w #$8, d1
03681e: e549                 lsl.w #$2, d1
036820: d27a0652             add.w $36e74(pc), d1
036824: 4bf900dff0a0         lea.l $dff0a0.l, a5
03682a: 43fa064a             lea.l $36e76(pc), a1
03682e: 4dfa01f4             lea.l $36a24(pc), a6
036832: 4e96                 jsr (a6)
036834: 5881                 addq.l #$4, d1
036836: 4bf900dff0b0         lea.l $dff0b0.l, a5
03683c: 49fa06d4             lea.l $36f12(pc), a4
036840: 4a7900036e6a         tst.w $36e6a.l
036846: 6754                 beq.b $3689c
036848: 4ab900036e6c         tst.l $36e6c.l
03684e: 672e                 beq.b $3687e
036850: 33fc000400036e70     move.w #$4, $36e70.l
036858: 0cb911ac1c4000036e6c cmpi.l #$11ac1c40, $36e6c.l
036862: 6608                 bne.b $3686c
036864: 33fc000100036e70     move.w #$1, $36e70.l
03686c: 28b900036e6c         move.l $36e6c.l, (a4)
036872: 42b900036e6c         clr.l $36e6c.l
036878: 610001ae             bsr.w $36a28
03687c: 6020                 bra.b $3689e
03687e: 28b900036e6c         move.l $36e6c.l, (a4)
036884: 610001a2             bsr.w $36a28
036888: 0479000100036e70     subi.w #$1, $36e70.l
036890: 660c                 bne.b $3689e
036892: 33fc000000036e6a     move.w #$0, $36e6a.l
03689a: 6002                 bra.b $3689e
03689c: 4e96                 jsr (a6)
03689e: 5881                 addq.l #$4, d1
0368a0: 4bf900dff0c0         lea.l $dff0c0.l, a5
0368a6: 49fa0686             lea.l $36f2e(pc), a4
0368aa: 4e96                 jsr (a6)
0368ac: 5881                 addq.l #$4, d1
0368ae: 4bf900dff0d0         lea.l $dff0d0.l, a5
0368b4: 49fa0694             lea.l $36f4a(pc), a4
0368b8: 4e96                 jsr (a6)
0368ba: 303a05bc             move.w $36e78(pc), d0
0368be: 6746                 beq.b $36906
0368c0: 47f900bfd000         lea.l $bfd000.l, a3
0368c6: 177c007f0d00         move.b #$7f, $d00(a3)
0368cc: 33fc200000dff09c     move.w #$2000, $dff09c.l
0368d4: 33fca00000dff09a     move.w #$a000, $dff09a.l
0368dc: 21fc000369940078     move.l #$36994, $78.w
0368e4: 7000                 moveq #$0, d0
0368e6: 17400e00             move.b d0, $e00(a3)
0368ea: 177c00a80400         move.b #$a8, $400(a3)
0368f0: 17400500             move.b d0, $500(a3)
0368f4: 006c8000ff2e         ori.w #$8000, -$d2(a4)
0368fa: 177c00110e00         move.b #$11, $e00(a3)
036900: 177c00810d00         move.b #$81, $d00(a3)
036906: 066c0010ff2a         addi.w #$10, -$d6(a4)
03690c: 0c6c0400ff2a         cmpi.w #$400, -$d6(a4)
036912: 6622                 bne.b $36936
036914: 426cff2a             clr.w -$d6(a4)
036918: 422cff2d             clr.b -$d3(a4)
03691c: 522cff2c             addq.b #$1, -$d4(a4)
036920: 022c007fff2c         andi.b #$7f, -$d4(a4)
036926: 102afffe             move.b -$2(a2), d0
03692a: b03a054a             cmp.b $36e76(pc), d0
03692e: 6606                 bne.b $36936
036930: 196affffff2c         move.b -$1(a2), -$d4(a4)
036936: 4a2cff2d             tst.b -$d3(a4)
03693a: 66d8                 bne.b $36914
03693c: 4e75                 rts 
03693e: 48e7c1c0             movem.l d0-d1/d7/a0-a1, -(a7)
036942: 0c39000100036e73     cmpi.b #$1, $36e73.l
03694a: 6606                 bne.b $36952
03694c: 6100ae38             bsr.w $31786
036950: 6004                 bra.b $36956
036952: 6100adfa             bsr.w $3174e
036956: 4cdf0383             movem.l (a7)+, d0-d1/d7/a0-a1
03695a: 4bf900dff0a0         lea.l $dff0a0.l, a5
036960: 4dfa0350             lea.l $36cb2(pc), a6
036964: 4e96                 jsr (a6)
036966: 49fa05aa             lea.l $36f12(pc), a4
03696a: 4bf900dff0b0         lea.l $dff0b0.l, a5
036970: 4e96                 jsr (a6)
036972: 49fa05ba             lea.l $36f2e(pc), a4
036976: 4bf900dff0c0         lea.l $dff0c0.l, a5
03697c: 4e96                 jsr (a6)
03697e: 49fa05ca             lea.l $36f4a(pc), a4
036982: 4bf900dff0d0         lea.l $dff0d0.l, a5
036988: 4e96                 jsr (a6)
03698a: 4a2cff2d             tst.b -$d3(a4)
03698e: 6600ff84             bne.w $36914
036992: 4e75                 rts 
036994: 4a3900bfdd00         tst.b $bfdd00.l
03699a: 33fa04dc00dff096     move.w $36e78(pc), $dff096.l
0369a2: 21fc000369b40078     move.l #$369b4, $78.w
0369aa: 33fc200000dff09c     move.w #$2000, $dff09c.l
0369b2: 4e73                 rte 
0369b4: 4a3900bfdd00         tst.b $bfdd00.l
0369ba: 48e70018             movem.l a3-a4, -(a7)
0369be: 49fa0536             lea.l $36ef6(pc), a4
0369c2: 47f900dff000         lea.l $dff000.l, a3
0369c8: 276c000a00a0         move.l $a(a4), $a0(a3)
0369ce: 376c000e00a4         move.w $e(a4), $a4(a3)
0369d4: 276c002600b0         move.l $26(a4), $b0(a3)
0369da: 376c002a00b4         move.w $2a(a4), $b4(a3)
0369e0: 276c004200c0         move.l $42(a4), $c0(a3)
0369e6: 376c004600c4         move.w $46(a4), $c4(a3)
0369ec: 276c005e00d0         move.l $5e(a4), $d0(a3)
0369f2: 376c006200d4         move.w $62(a4), $d4(a3)
0369f8: 4cdf1800             movem.l (a7)+, a3-a4
0369fc: 13fc000000bfde00     move.b #$0, $bfde00.l
036a04: 13fc007f00bfdd00     move.b #$7f, $bfdd00.l
036a0c: 21fa05580078         move.l $36f66(pc), $78.w
036a12: 33fc200000dff09c     move.w #$2000, $dff09c.l
036a1a: 33fc200000dff09a     move.w #$2000, $dff09a.l
036a22: 4e73                 rte 
036a24: 28b01800             move.l (a0, d1.l), (a4)
036a28: 7400                 moveq #$0, d2
036a2a: 142c0002             move.b $2(a4), d2
036a2e: e80a                 lsr.b #$4, d2
036a30: 1014                 move.b (a4), d0
036a32: 020000f0             andi.b #$f0, d0
036a36: 8400                 or.b d0, d2
036a38: 670000c8             beq.w $36b02
036a3c: e542                 asl.w #$2, d2
036a3e: 297128000004         move.l (a1, d2.l), $4(a4)
036a44: 267b202c             movea.l $36a72(pc, d2.w), a3
036a48: 395b0008             move.w (a3)+, $8(a4)
036a4c: 395b0012             move.w (a3)+, $12(a4)
036a50: 202c0004             move.l $4(a4), d0
036a54: 7600                 moveq #$0, d3
036a56: 361b                 move.w (a3)+, d3
036a58: 67000098             beq.w $36af2
036a5c: e343                 asl.w #$1, d3
036a5e: d083                 add.l d3, d0
036a60: 2940000a             move.l d0, $a(a4)
036a64: 302bfffe             move.w -$2(a3), d0
036a68: d053                 add.w (a3), d0
036a6a: 39400008             move.w d0, $8(a4)
036a6e: 60000088             bra.w $36af8
036a72: 00000000             ori.b #$0, d0
036a76: 00000000             ori.b #$0, d0
036a7a: 00000000             ori.b #$0, d0
036a7e: 00000000             ori.b #$0, d0
036a82: 00000000             ori.b #$0, d0
036a86: 00000000             ori.b #$0, d0
036a8a: 00000000             ori.b #$0, d0
036a8e: 00000000             ori.b #$0, d0
036a92: 00000000             ori.b #$0, d0
036a96: 00000000             ori.b #$0, d0
036a9a: 00000000             ori.b #$0, d0
036a9e: 00000000             ori.b #$0, d0
036aa2: 00000000             ori.b #$0, d0
036aa6: 00000000             ori.b #$0, d0
036aaa: 00000000             ori.b #$0, d0
036aae: 00000000             ori.b #$0, d0
036ab2: 00000000             ori.b #$0, d0
036ab6: 00000000             ori.b #$0, d0
036aba: 00000000             ori.b #$0, d0
036abe: 00000000             ori.b #$0, d0
036ac2: 00000000             ori.b #$0, d0
036ac6: 00000000             ori.b #$0, d0
036aca: 00000000             ori.b #$0, d0
036ace: 00000000             ori.b #$0, d0
036ad2: 00000000             ori.b #$0, d0
036ad6: 00000000             ori.b #$0, d0
036ada: 00000000             ori.b #$0, d0
036ade: 00000000             ori.b #$0, d0
036ae2: 00000000             ori.b #$0, d0
036ae6: 00000000             ori.b #$0, d0
036aea: 00000000             ori.b #$0, d0
036aee: 00000000             ori.b #$0, d0
036af2: d083                 add.l d3, d0
036af4: 2940000a             move.l d0, $a(a4)
036af8: 3953000e             move.w (a3), $e(a4)
036afc: 3b6c00120008         move.w $12(a4), $8(a5)
036b02: 3614                 move.w (a4), d3
036b04: 02430fff             andi.w #$fff, d3
036b08: 6700027e             beq.w $36d88
036b0c: 4a6c0008             tst.w $8(a4)
036b10: 6740                 beq.b $36b52
036b12: 102c0002             move.b $2(a4), d0
036b16: 0200000f             andi.b #$f, d0
036b1a: 0c000005             cmpi.b #$5, d0
036b1e: 673e                 beq.b $36b5e
036b20: 0c000003             cmpi.b #$3, d0
036b24: 6738                 beq.b $36b5e
036b26: 39430010             move.w d3, $10(a4)
036b2a: 33ec001a00dff096     move.w $1a(a4), $dff096.l
036b32: 422c0019             clr.b $19(a4)
036b36: 2aac0004             move.l $4(a4), (a5)
036b3a: 3b6c00080004         move.w $8(a4), $4(a5)
036b40: 3b6c00100006         move.w $10(a4), $6(a5)
036b46: 302c001a             move.w $1a(a4), d0
036b4a: 816e0454             or.w d0, $454(a6)
036b4e: 60000238             bra.w $36d88
036b52: 33ec001a00dff096     move.w $1a(a4), $dff096.l
036b5a: 6000022c             bra.w $36d88
036b5e: 3414                 move.w (a4), d2
036b60: 02420fff             andi.w #$fff, d2
036b64: 39420016             move.w d2, $16(a4)
036b68: 302c0010             move.w $10(a4), d0
036b6c: 422c0014             clr.b $14(a4)
036b70: b440                 cmp.w d0, d2
036b72: 670e                 beq.b $36b82
036b74: 6c000212             bge.w $36d88
036b78: 197c00010014         move.b #$1, $14(a4)
036b7e: 60000208             bra.w $36d88
036b82: 426c0016             clr.w $16(a4)
036b86: 4e75                 rts 
036b88: 7000                 moveq #$0, d0
036b8a: 142c0003             move.b $3(a4), d2
036b8e: 6708                 beq.b $36b98
036b90: 19420015             move.b d2, $15(a4)
036b94: 19400003             move.b d0, $3(a4)
036b98: 4a6c0016             tst.w $16(a4)
036b9c: 6728                 beq.b $36bc6
036b9e: 102c0015             move.b $15(a4), d0
036ba2: 4a2c0014             tst.b $14(a4)
036ba6: 6620                 bne.b $36bc8
036ba8: d16c0010             add.w d0, $10(a4)
036bac: 302c0016             move.w $16(a4), d0
036bb0: b06c0010             cmp.w $10(a4), d0
036bb4: 6e0a                 bgt.b $36bc0
036bb6: 396c00160010         move.w $16(a4), $10(a4)
036bbc: 426c0016             clr.w $16(a4)
036bc0: 3b6c00100006         move.w $10(a4), $6(a5)
036bc6: 4e75                 rts 
036bc8: 916c0010             sub.w d0, $10(a4)
036bcc: 302c0016             move.w $16(a4), d0
036bd0: b06c0010             cmp.w $10(a4), d0
036bd4: 6dea                 blt.b $36bc0
036bd6: 396c00160010         move.w $16(a4), $10(a4)
036bdc: 426c0016             clr.w $16(a4)
036be0: 3b6c00100006         move.w $10(a4), $6(a5)
036be6: 4e75                 rts 
036be8: 0018314a             ori.b #$4a, (a0)+
036bec: 6178                 bsr.b $36c66
036bee: 8da1                 or.l d6, -(a1)
036bf0: b4c5                 cmpa.w d5, a2
036bf2: d4e0                 adda.w -(a0), a2
036bf4: dc.w ebf4
036bf6: fafd                 dc.w $fafd
036bf8: dc.w fffd
036bfa: faf4                 dc.w $faf4
036bfc: dc.w ebe0
036bfe: d4c5                 adda.w d5, a2
036c00: b4a1                 cmp.l -(a1), d2
036c02: 8d78614a             or.w d6, $614a.w
036c06: 3118                 move.w (a0)+, -(a0)
036c08: 102c0003             move.b $3(a4), d0
036c0c: 6704                 beq.b $36c12
036c0e: 19400018             move.b d0, $18(a4)
036c12: 102c0019             move.b $19(a4), d0
036c16: e448                 lsr.w #$2, d0
036c18: 0240001f             andi.w #$1f, d0
036c1c: 7400                 moveq #$0, d2
036c1e: 143b00c8             move.b $36be8(pc, d0.w), d2
036c22: 102c0018             move.b $18(a4), d0
036c26: 0240000f             andi.w #$f, d0
036c2a: c4c0                 mulu.w d0, d2
036c2c: ee4a                 lsr.w #$7, d2
036c2e: 302c0010             move.w $10(a4), d0
036c32: 4a2c0019             tst.b $19(a4)
036c36: 6b04                 bmi.b $36c3c
036c38: d042                 add.w d2, d0
036c3a: 6002                 bra.b $36c3e
036c3c: 9042                 sub.w d2, d0
036c3e: 3b400006             move.w d0, $6(a5)
036c42: 102c0018             move.b $18(a4), d0
036c46: e448                 lsr.w #$2, d0
036c48: 0240003c             andi.w #$3c, d0
036c4c: d12c0019             add.b d0, $19(a4)
036c50: 4e75                 rts 
036c52: 00010200             ori.b #$0, d1
036c56: 0102                 btst.l d0, d2
036c58: 00010200             ori.b #$0, d1
036c5c: 0102                 btst.l d0, d2
036c5e: 00010200             ori.b #$0, d1
036c62: 0102                 btst.l d0, d2
036c64: 00010200             ori.b #$0, d1
036c68: 0102                 btst.l d0, d2
036c6a: 00010200             ori.b #$0, d1
036c6e: 0102                 btst.l d0, d2
036c70: 00017000             ori.b #$0, d1
036c74: 103a01fd             move.b $36e73(pc), d0
036c78: 103b00d8             move.b $36c52(pc, d0.w), d0
036c7c: 672c                 beq.b $36caa
036c7e: 0c000002             cmpi.b #$2, d0
036c82: 6708                 beq.b $36c8c
036c84: 102c0003             move.b $3(a4), d0
036c88: e848                 lsr.w #$4, d0
036c8a: 6008                 bra.b $36c94
036c8c: 102c0003             move.b $3(a4), d0
036c90: 0240000f             andi.w #$f, d0
036c94: e340                 asl.w #$1, d0
036c96: 322c0010             move.w $10(a4), d1
036c9a: 41fa0184             lea.l $36e20(pc), a0
036c9e: b258                 cmp.w (a0)+, d1
036ca0: 6dfc                 blt.b $36c9e
036ca2: 3b7000fe0006         move.w -$2(a0, d0.w), $6(a5)
036ca8: 4e75                 rts 
036caa: 3b6c00100006         move.w $10(a4), $6(a5)
036cb0: 4e75                 rts 
036cb2: 302c0002             move.w $2(a4), d0
036cb6: 02400fff             andi.w #$fff, d0
036cba: 67ee                 beq.b $36caa
036cbc: 102c0002             move.b $2(a4), d0
036cc0: 0200000f             andi.b #$f, d0
036cc4: 67ac                 beq.b $36c72
036cc6: 0c000006             cmpi.b #$6, d0
036cca: 6774                 beq.b $36d40
036ccc: 0c000004             cmpi.b #$4, d0
036cd0: 6700ff36             beq.w $36c08
036cd4: 0c000005             cmpi.b #$5, d0
036cd8: 676c                 beq.b $36d46
036cda: 0c000003             cmpi.b #$3, d0
036cde: 6700fea8             beq.w $36b88
036ce2: 0c000001             cmpi.b #$1, d0
036ce6: 6714                 beq.b $36cfc
036ce8: 0c000002             cmpi.b #$2, d0
036cec: 6730                 beq.b $36d1e
036cee: 3b6c00100006         move.w $10(a4), $6(a5)
036cf4: 0c00000a             cmpi.b #$a, d0
036cf8: 6750                 beq.b $36d4a
036cfa: 4e75                 rts 
036cfc: 7000                 moveq #$0, d0
036cfe: 102c0003             move.b $3(a4), d0
036d02: 916c0010             sub.w d0, $10(a4)
036d06: 302c0010             move.w $10(a4), d0
036d0a: 0c400071             cmpi.w #$71, d0
036d0e: 6a06                 bpl.b $36d16
036d10: 397c00710010         move.w #$71, $10(a4)
036d16: 3b6c00100006         move.w $10(a4), $6(a5)
036d1c: 4e75                 rts 
036d1e: 7000                 moveq #$0, d0
036d20: 102c0003             move.b $3(a4), d0
036d24: d16c0010             add.w d0, $10(a4)
036d28: 302c0010             move.w $10(a4), d0
036d2c: 0c400358             cmpi.w #$358, d0
036d30: 6b06                 bmi.b $36d38
036d32: 397c03580010         move.w #$358, $10(a4)
036d38: 3b6c00100006         move.w $10(a4), $6(a5)
036d3e: 4e75                 rts 
036d40: 6100fed0             bsr.w $36c12
036d44: 6004                 bra.b $36d4a
036d46: 6100fe50             bsr.w $36b98
036d4a: 7000                 moveq #$0, d0
036d4c: 102c0003             move.b $3(a4), d0
036d50: e808                 lsr.b #$4, d0
036d52: 671a                 beq.b $36d6e
036d54: d12c0013             add.b d0, $13(a4)
036d58: 0c2c00400013         cmpi.b #$40, $13(a4)
036d5e: 6b06                 bmi.b $36d66
036d60: 197c00400013         move.b #$40, $13(a4)
036d66: 3b6c00120008         move.w $12(a4), $8(a5)
036d6c: 4e75                 rts 
036d6e: 102c0003             move.b $3(a4), d0
036d72: 0200000f             andi.b #$f, d0
036d76: 912c0013             sub.b d0, $13(a4)
036d7a: 6a04                 bpl.b $36d80
036d7c: 422c0013             clr.b $13(a4)
036d80: 3b6c00120008         move.w $12(a4), $8(a5)
036d86: 4e75                 rts 
036d88: 102c0002             move.b $2(a4), d0
036d8c: 0200000f             andi.b #$f, d0
036d90: 6700fe34             beq.w $36bc6
036d94: 0c00000e             cmpi.b #$e, d0
036d98: 671a                 beq.b $36db4
036d9a: 0c00000d             cmpi.b #$d, d0
036d9e: 672e                 beq.b $36dce
036da0: 0c00000b             cmpi.b #$b, d0
036da4: 6730                 beq.b $36dd6
036da6: 0c00000c             cmpi.b #$c, d0
036daa: 673c                 beq.b $36de8
036dac: 0c00000f             cmpi.b #$f, d0
036db0: 6754                 beq.b $36e06
036db2: 4e75                 rts 
036db4: 102c0003             move.b $3(a4), d0
036db8: 02000001             andi.b #$1, d0
036dbc: e300                 asl.b #$1, d0
036dbe: 023900fd00bfe001     andi.b #$fd, $bfe001.l
036dc6: 813900bfe001         or.b d0, $bfe001.l
036dcc: 4e75                 rts 
036dce: 1d7c00010453         move.b #$1, $453(a6)
036dd4: 4e75                 rts 
036dd6: 1d7c00010453         move.b #$1, $453(a6)
036ddc: 102c0003             move.b $3(a4), d0
036de0: 5300                 subq.b #$1, d0
036de2: 1d400452             move.b d0, $452(a6)
036de6: 4e75                 rts 
036de8: 0c2c00400003         cmpi.b #$40, $3(a4)
036dee: 6306                 bls.b $36df6
036df0: 197c00400003         move.b #$40, $3(a4)
036df6: 7000                 moveq #$0, d0
036df8: 102c0003             move.b $3(a4), d0
036dfc: 19400013             move.b d0, $13(a4)
036e00: 3b400008             move.w d0, $8(a5)
036e04: 4e75                 rts 
036e06: 7000                 moveq #$0, d0
036e08: 102c0003             move.b $3(a4), d0
036e0c: 0c00001f             cmpi.b #$1f, d0
036e10: 6302                 bls.b $36e14
036e12: 701f                 moveq #$1f, d0
036e14: 4a40                 tst.w d0
036e16: 6602                 bne.b $36e1a
036e18: 7001                 moveq #$1, d0
036e1a: 1d40044e             move.b d0, $44e(a6)
036e1e: 4e75                 rts 
036e20: 0358                 bchg.b d1, (a0)+
036e22: 032802fa             btst.l d1, $2fa(a0)
036e26: dc.w 02d0
036e28: 02a60280025c         andi.l #$280025c, -(a6)
036e2e: dc.w 023a
036e30: 021a01fc             andi.b #$fc, (a2)+
036e34: 01e0                 bset.b d0, -(a0)
036e36: 01c5                 bset.b d0, d5
036e38: 01ac0194             bclr.b d0, $194(a4)
036e3c: dc.w 017d
036e3e: 01680153             bchg.b d0, $153(a0)
036e42: 0140                 bchg.b d0, d0
036e44: 012e011d             btst.l d0, $11d(a6)
036e48: 010d00fe             movep.w $fe(a5), d0
036e4c: dc.w 00f0
036e4e: dc.w 00e2
036e50: dc.w 00d6
036e52: dc.w 00ca
036e54: dc.w 00be
036e56: 00b400aa00a00097     ori.l #$aa00a0, -$69(a4, d0.w)
036e5e: dc.w 008f
036e60: 0087007f0078         ori.l #$7f0078, d7
036e66: 007100000000         ori.w #$0, (a1, d0.w)
036e6c: 00000000             ori.b #$0, d0
036e70: 00000600             ori.b #$0, d0
036e74: 00000000             ori.b #$0, d0
036e78: 00000000             ori.b #$0, d0
036e7c: 00000000             ori.b #$0, d0
036e80: 00000000             ori.b #$0, d0
036e84: 00000000             ori.b #$0, d0
036e88: 00000000             ori.b #$0, d0
036e8c: 00000000             ori.b #$0, d0
036e90: 00000000             ori.b #$0, d0
036e94: 00000000             ori.b #$0, d0
036e98: 00000000             ori.b #$0, d0
036e9c: 00000000             ori.b #$0, d0
036ea0: 00000000             ori.b #$0, d0
036ea4: 00000000             ori.b #$0, d0
036ea8: 00000000             ori.b #$0, d0
036eac: 00000000             ori.b #$0, d0
036eb0: 00000000             ori.b #$0, d0
036eb4: 00000000             ori.b #$0, d0
036eb8: 00000000             ori.b #$0, d0
036ebc: 00000000             ori.b #$0, d0
036ec0: 00000000             ori.b #$0, d0
036ec4: 00000000             ori.b #$0, d0
036ec8: 00000000             ori.b #$0, d0
036ecc: 00000000             ori.b #$0, d0
036ed0: 00000000             ori.b #$0, d0
036ed4: 00000000             ori.b #$0, d0
036ed8: 00000000             ori.b #$0, d0
036edc: 00000000             ori.b #$0, d0
036ee0: 00000000             ori.b #$0, d0
036ee4: 00000000             ori.b #$0, d0
036ee8: 00000000             ori.b #$0, d0
036eec: 00000000             ori.b #$0, d0
036ef0: 00000000             ori.b #$0, d0
036ef4: 00000000             ori.b #$0, d0
036ef8: 00000000             ori.b #$0, d0
036efc: 00000000             ori.b #$0, d0
036f00: 00000000             ori.b #$0, d0
036f04: 00000000             ori.b #$0, d0
036f08: 00000000             ori.b #$0, d0
036f0c: 00000000             ori.b #$0, d0
036f10: 00010000             ori.b #$0, d1
036f14: 00000000             ori.b #$0, d0
036f18: 00000000             ori.b #$0, d0
036f1c: 00000000             ori.b #$0, d0
036f20: 00000000             ori.b #$0, d0
036f24: 00000000             ori.b #$0, d0
036f28: 00000000             ori.b #$0, d0
036f2c: 00020000             ori.b #$0, d2
036f30: 00000000             ori.b #$0, d0
036f34: 00000000             ori.b #$0, d0
036f38: 00000000             ori.b #$0, d0
036f3c: 00000000             ori.b #$0, d0
036f40: 00000000             ori.b #$0, d0
036f44: 00000000             ori.b #$0, d0
036f48: 00040000             ori.b #$0, d4
036f4c: 00000000             ori.b #$0, d0
036f50: 00000000             ori.b #$0, d0
036f54: 00000000             ori.b #$0, d0
036f58: 00000000             ori.b #$0, d0
036f5c: 00000000             ori.b #$0, d0
036f60: 00000000             ori.b #$0, d0
036f64: dc.w 0008
