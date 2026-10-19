030000: 33f900dff01c000318f6 move.w $dff01c.l, $318f6.l
03000a: 0079c000000318f6     ori.w #$c000, $318f6.l
030012: 33fc3fff00dff09a     move.w #$3fff, $dff09a.l
03001a: 33fc83e000dff096     move.w #$83e0, $dff096.l
030022: 33fc040000dff096     move.w #$400, $dff096.l
03002a: 23f9000000680003190e move.l $68.l, $3190e.l
030034: 23fc0003181a00000068 move.l #$3181a, $68.l
03003e: 61006698             bsr.w $366d8
030042: 23f90000006c00031912 move.l $6c.l, $31912.l
03004c: 23fc0003676e0000006c move.l #$3676e, $6c.l
030056: 33fc801800dff09a     move.w #$8018, $dff09a.l
03005e: 203c00034f3c         move.l #$34f3c, d0
030064: 33c000031c88         move.w d0, $31c88.l
03006a: 4840                 swap d0
03006c: 33c000031c8c         move.w d0, $31c8c.l
030072: 203c00035054         move.l #$35054, d0
030078: 33c000031c1c         move.w d0, $31c1c.l
03007e: 4840                 swap d0
030080: 33c000031c20         move.w d0, $31c20.l
030086: 203c00031916         move.l #$31916, d0
03008c: 33c0000319cc         move.w d0, $319cc.l
030092: 4840                 swap d0
030094: 33c0000319c8         move.w d0, $319c8.l
03009a: 203c00031936         move.l #$31936, d0
0300a0: 33c0000319d4         move.w d0, $319d4.l
0300a6: 4840                 swap d0
0300a8: 33c0000319d0         move.w d0, $319d0.l
0300ae: 23fc000318780003188c move.l #$31878, $3188c.l
0300b8: 33fc000000031890     move.w #$0, $31890.l
0300c0: 600000f4             bra.w $301b6
0300c4: 610001d6             bsr.w $3029c
0300c8: 6100158c             bsr.w $31656
0300cc: 23fc0003195600dff080 move.l #$31956, $dff080.l
0300d6: 33fcffff0003189c     move.w #$ffff, $3189c.l
0300de: 203900dff004         move.l $dff004.l, d0
0300e4: 02800001ff00         andi.l #$1ff00, d0
0300ea: 0c8000000100         cmpi.l #$100, d0
0300f0: 66ec                 bne.b $300de
0300f2: 0c3900450003188a     cmpi.b #$45, $3188a.l
0300fa: 670000b6             beq.w $301b2
0300fe: 610066a6             bsr.w $367a6
030102: 61000738             bsr.w $3083c
030106: 61000a04             bsr.w $30b0c
03010a: 4a79000318e2         tst.w $318e2.l
030110: 660004d6             bne.w $305e8
030114: 0839000a00dff016     btst.b #$a, $dff016.l
03011c: 6616                 bne.b $30134
03011e: 0839000700bfe001     btst.b #$7, $bfe001.l
030126: 660c                 bne.b $30134
030128: 0839000600bfe001     btst.b #$6, $bfe001.l
030130: 670004b6             beq.w $305e8
030134: 6100096c             bsr.w $30aa2
030138: 303900dff00e         move.w $dff00e.l, d0
03013e: 08000005             btst.b #$5, d0
030142: 66000f48             bne.w $3108c
030146: 4a790003189a         tst.w $3189a.l
03014c: 66000f3e             bne.w $3108c
030150: 61000cd2             bsr.w $30e24
030154: 61000e28             bsr.w $30f7e
030158: 6100055a             bsr.w $306b4
03015c: 6000ff80             bra.w $300de
030160: 23f90003190e00000068 move.l $3190e.l, $68.l
03016a: 23f9000319120000006c move.l $31912.l, $6c.l
030174: 6100660e             bsr.w $36784
030178: 2c7900000004         movea.l $4.l, a6
03017e: 7000                 moveq #$0, d0
030180: 227c000301a0         movea.l #$301a0, a1
030186: 4eaefdd8             jsr -$228(a6)
03018a: 2040                 movea.l d0, a0
03018c: 23e8002600dff080     move.l $26(a0), $dff080.l
030194: 33f9000318f600dff09a move.w $318f6.l, $dff09a.l
03019e: 4e75                 rts 
0301a0: 6772                 beq.b $30214
0301a2: 6170                 bsr.b $30214
0301a4: 6869                 bvc.b $3020f
0301a6: 6373                 bls.b $3021b
0301a8: 2e6c6962             movea.l $6962(a4), a7
0301ac: 7261                 moveq #$61, d1
0301ae: 7279                 moveq #$79, d1
0301b0: 00006100             ori.b #$0, d0
0301b4: dc.w 02ee
0301b6: 13fc00000003188a     move.b #$0, $3188a.l
0301be: 23fc00031d6e00dff080 move.l #$31d6e, $dff080.l
0301c8: 41fa2208             lea.l $323d2(pc), a0
0301cc: 0c3900450003188a     cmpi.b #$45, $3188a.l
0301d4: 61001288             bsr.w $3145e
0301d8: 303900031894         move.w $31894.l, d0
0301de: 06400002             addi.w #$2, d0
0301e2: 4a700000             tst.w (a0, d0.w)
0301e6: 6a000004             bpl.w $301ec
0301ea: 7000                 moveq #$0, d0
0301ec: 33c000031894         move.w d0, $31894.l
0301f2: 43f00000             lea.l (a0, d0.w), a1
0301f6: 45fa1c3c             lea.l $31e34(pc), a2
0301fa: 303c00b3             move.w #$b3, d0
0301fe: 3219                 move.w (a1)+, d1
030200: 6a000008             bpl.w $3020a
030204: 43fa21cc             lea.l $323d2(pc), a1
030208: 3219                 move.w (a1)+, d1
03020a: 3481                 move.w d1, (a2)
03020c: d5fc00000008         adda.l #$8, a2
030212: 51c8ffea             dbra d0, $301fe
030216: 10390003188a         move.b $3188a.l, d0
03021c: 672a                 beq.b $30248
03021e: b0390003188b         cmp.b $3188b.l, d0
030224: 6722                 beq.b $30248
030226: 13c00003188b         move.b d0, $3188b.l
03022c: 22790003188c         movea.l $3188c.l, a1
030232: b019                 cmp.b (a1)+, d0
030234: 6706                 beq.b $3023c
030236: 227c00031878         movea.l #$31878, a1
03023c: 4a11                 tst.b (a1)
03023e: 6b000042             bmi.w $30282
030242: 23c90003188c         move.l a1, $3188c.l
030248: 0839000700bfe001     btst.b #$7, $bfe001.l
030250: 6600ff7a             bne.w $301cc
030254: 61001208             bsr.w $3145e
030258: 0839000700bfe001     btst.b #$7, $bfe001.l
030260: 67f2                 beq.b $30254
030262: 33fc0000000318a0     move.w #$0, $318a0.l
03026a: 6100151a             bsr.w $31786
03026e: 33fc00000003189c     move.w #$0, $3189c.l
030276: 33fc000300031896     move.w #$3, $31896.l
03027e: 6000037e             bra.w $305fe
030282: 303cffff             move.w #$ffff, d0
030286: 33c000dff180         move.w d0, $dff180.l
03028c: 51c8fff8             dbra d0, $30286
030290: 33fcffff00031890     move.w #$ffff, $31890.l
030298: 6000ffc8             bra.w $30262
03029c: 7000                 moveq #$0, d0
03029e: 23c000000000         move.l d0, $0.l
0302a4: 33c0000318ca         move.w d0, $318ca.l
0302aa: 33fc0050000318cc     move.w #$50, $318cc.l
0302b2: 33fc00c0000318ce     move.w #$c0, $318ce.l
0302ba: 33c0000318d0         move.w d0, $318d0.l
0302c0: 33c0000318d2         move.w d0, $318d2.l
0302c6: 33c0000318d4         move.w d0, $318d4.l
0302cc: 33fc0002000318d6     move.w #$2, $318d6.l
0302d4: 23fc00020001000318d8 move.l #$20001, $318d8.l
0302de: 23fc00032a00000318e4 move.l #$32a00, $318e4.l
0302e8: 23fc00032a48000318e8 move.l #$32a48, $318e8.l
0302f2: 23fc00032bb0000318ec move.l #$32bb0, $318ec.l
0302fc: 33fc0004000318f0     move.w #$4, $318f0.l
030304: 23fc00035d7800035414 move.l #$35d78, $35414.l
03030e: 33c0000319a8         move.w d0, $319a8.l
030314: 33c0000319ac         move.w d0, $319ac.l
03031a: 33c0000319b0         move.w d0, $319b0.l
030320: 33c0000319b4         move.w d0, $319b4.l
030326: 33c0000319b8         move.w d0, $319b8.l
03032c: 33c0000319bc         move.w d0, $319bc.l
030332: 33c0000319c0         move.w d0, $319c0.l
030338: 33c0000319c4         move.w d0, $319c4.l
03033e: 33c0000318e2         move.w d0, $318e2.l
030344: 33c00003188a         move.w d0, $3188a.l
03034a: 33c00003189a         move.w d0, $3189a.l
030350: 41f900060000         lea.l $60000.l, a0
030356: 43f90007d000         lea.l $7d000.l, a1
03035c: 20c0                 move.l d0, (a0)+
03035e: b3c8                 cmpa.l a0, a1
030360: 66fa                 bne.b $3035c
030362: 207900031906         movea.l $31906.l, a0
030368: 20bcfffffffe         move.l #$fffffffe, (a0)
03036e: 20790003190a         movea.l $3190a.l, a0
030374: 20bcfffffffe         move.l #$fffffffe, (a0)
03037a: 23fcffffffff00dff044 move.l #$ffffffff, $dff044.l
030384: 33fc002400dff060     move.w #$24, $dff060.l
03038c: 33c000dff062         move.w d0, $dff062.l
030392: 33c000dff064         move.w d0, $dff064.l
030398: 33fc002400dff066     move.w #$24, $dff066.l
0303a0: 23f9000318fe00dff048 move.l $318fe.l, $dff048.l
0303aa: 23fc00032fc400dff04c move.l #$32fc4, $dff04c.l
0303b4: 23fc0003330400dff050 move.l #$33304, $dff050.l
0303be: 23f9000318fe00dff054 move.l $318fe.l, $dff054.l
0303c8: 33fc000200dff02e     move.w #$2, $dff02e.l
0303d0: 33fc17df00dff098     move.w #$17df, $dff098.l
0303d8: 303900dff00e         move.w $dff00e.l, d0
0303de: 227900035414         movea.l $35414.l, a1
0303e4: 41f90003044e         lea.l $3044e.l, a0
0303ea: 303c000e             move.w #$e, d0
0303ee: 2350f6a0             move.l (a0), -$960(a1)
0303f2: 22d8                 move.l (a0)+, (a1)+
0303f4: 51c8fff8             dbra d0, $303ee
0303f8: 43fa0094             lea.l $3048e(pc), a1
0303fc: 41fa160e             lea.l $31a0c(pc), a0
030400: 45fa164a             lea.l $31a4c(pc), a2
030404: 303c0002             move.w #$2, d0
030408: 3091                 move.w (a1), (a0)
03040a: 3499                 move.w (a1)+, (a2)
03040c: d1fc00000004         adda.l #$4, a0
030412: d5fc00000004         adda.l #$4, a2
030418: 51c8ffee             dbra d0, $30408
03041c: 41fa160e             lea.l $31a2c(pc), a0
030420: 303c0006             move.w #$6, d0
030424: 3099                 move.w (a1)+, (a0)
030426: d1fc00000004         adda.l #$4, a0
03042c: 51c8fff6             dbra d0, $30424
030430: 7000                 moveq #$0, d0
030432: 303900031896         move.w $31896.l, d0
030438: 80fc000a             divu.w #$a, d0
03043c: 4840                 swap d0
03043e: 323c0024             move.w #$24, d1
030442: 41f900057a58         lea.l $57a58.l, a0
030448: 610013ac             bsr.w $317f6
03044c: 4e75                 rts 
03044e: 00a00180009e         ori.l #$180009e, -(a0)
030454: 0180                 bclr.b d0, d0
030456: 009c0180009a         ori.l #$180009a, (a4)+
03045c: 0180                 bclr.b d0, d0
03045e: 009801800096         ori.l #$1800096, (a0)+
030464: 0180                 bclr.b d0, d0
030466: 009401800092         ori.l #$1800092, (a4)
03046c: 0180                 bclr.b d0, d0
03046e: 00900180008e         ori.l #$180008e, (a0)
030474: 0180                 bclr.b d0, d0
030476: dc.w 008c
030478: 0180                 bclr.b d0, d0
03047a: dc.w 008a
03047c: 0180                 bclr.b d0, d0
03047e: dc.w 0088
030480: 0180                 bclr.b d0, d0
030482: 008601800084         ori.l #$1800084, d6
030488: 0180                 bclr.b d0, d0
03048a: 008201800e00         ori.l #$1800e00, d2
030490: 0a000333             eori.b #$33, d0
030494: dc.w 0eca
030496: dc.w 00dd
030498: 070f0fe0             movep.w $fe0(a7), d3
03049c: dc.w 0e00
03049e: 0a000333             eori.b #$33, d0
0304a2: 33fc00000003189c     move.w #$0, $3189c.l
0304aa: 207900031906         movea.l $31906.l, a0
0304b0: 20bcfffffffe         move.l #$fffffffe, (a0)
0304b6: 20790003190a         movea.l $3190a.l, a0
0304bc: 20bcfffffffe         move.l #$fffffffe, (a0)
0304c2: 61000f9a             bsr.w $3145e
0304c6: 610062de             bsr.w $367a6
0304ca: 61000f92             bsr.w $3145e
0304ce: 610062d6             bsr.w $367a6
0304d2: 33fc0000000306b2     move.w #$0, $306b2.l
0304da: 41fa1530             lea.l $31a0c(pc), a0
0304de: 3e3c0002             move.w #$2, d7
0304e2: 6100016e             bsr.w $30652
0304e6: d1fc00000004         adda.l #$4, a0
0304ec: 51cffff4             dbra d7, $304e2
0304f0: 41fa153a             lea.l $31a2c(pc), a0
0304f4: 3e3c0006             move.w #$6, d7
0304f8: 61000158             bsr.w $30652
0304fc: d1fc00000004         adda.l #$4, a0
030502: 51cffff4             dbra d7, $304f8
030506: 41fa1544             lea.l $31a4c(pc), a0
03050a: 3e3c0002             move.w #$2, d7
03050e: 61000142             bsr.w $30652
030512: d1fc00000004         adda.l #$4, a0
030518: 51cffff4             dbra d7, $3050e
03051c: 0c79000d000306b2     cmpi.w #$d, $306b2.l
030524: 669c                 bne.b $304c2
030526: 3c3c000e             move.w #$e, d6
03052a: 61000f32             bsr.w $3145e
03052e: 61006276             bsr.w $367a6
030532: 61000f2a             bsr.w $3145e
030536: 6100626e             bsr.w $367a6
03053a: 41fa14d0             lea.l $31a0c(pc), a0
03053e: 3e3c0002             move.w #$2, d7
030542: 04500111             subi.w #$111, (a0)
030546: d1fc00000004         adda.l #$4, a0
03054c: 51cffff4             dbra d7, $30542
030550: 41fa14da             lea.l $31a2c(pc), a0
030554: 3e3c0006             move.w #$6, d7
030558: 04500111             subi.w #$111, (a0)
03055c: d1fc00000004         adda.l #$4, a0
030562: 51cffff4             dbra d7, $30558
030566: 41fa14e4             lea.l $31a4c(pc), a0
03056a: 3e3c0002             move.w #$2, d7
03056e: 04500111             subi.w #$111, (a0)
030572: d1fc00000004         adda.l #$4, a0
030578: 51cffff4             dbra d7, $3056e
03057c: 51ceffac             dbra d6, $3052a
030580: 61000edc             bsr.w $3145e
030584: 61006220             bsr.w $367a6
030588: 61000ed4             bsr.w $3145e
03058c: 61006218             bsr.w $367a6
030590: 33fc0000000306b2     move.w #$0, $306b2.l
030598: 41fa1452             lea.l $319ec(pc), a0
03059c: 3e3c0006             move.w #$6, d7
0305a0: 610000b0             bsr.w $30652
0305a4: d1fc00000004         adda.l #$4, a0
0305aa: 51cffff4             dbra d7, $305a0
0305ae: 0c790007000306b2     cmpi.w #$7, $306b2.l
0305b6: 66c8                 bne.b $30580
0305b8: 3c3c000e             move.w #$e, d6
0305bc: 61000ea0             bsr.w $3145e
0305c0: 610061e4             bsr.w $367a6
0305c4: 61000e98             bsr.w $3145e
0305c8: 610061dc             bsr.w $367a6
0305cc: 41fa141e             lea.l $319ec(pc), a0
0305d0: 3e3c0006             move.w #$6, d7
0305d4: 04500111             subi.w #$111, (a0)
0305d8: d1fc00000004         adda.l #$4, a0
0305de: 51cffff4             dbra d7, $305d4
0305e2: 51ceffd8             dbra d6, $305bc
0305e6: 4e75                 rts 
0305e8: 6100feb8             bsr.w $304a2
0305ec: 0679000100031892     addi.w #$1, $31892.l
0305f4: 0c79000b00031892     cmpi.w #$b, $31892.l
0305fc: 6608                 bne.b $30606
0305fe: 33fc000100031892     move.w #$1, $31892.l
030606: 7000                 moveq #$0, d0
030608: 303900031892         move.w $31892.l, d0
03060e: 80fc000a             divu.w #$a, d0
030612: 7e00                 moveq #$0, d7
030614: 3e00                 move.w d0, d7
030616: 4840                 swap d0
030618: 323c0017             move.w #$17, d1
03061c: 41fa4a36             lea.l $35054(pc), a0
030620: 610011d4             bsr.w $317f6
030624: 2007                 move.l d7, d0
030626: 80fc000a             divu.w #$a, d0
03062a: 4840                 swap d0
03062c: 323c0016             move.w #$16, d1
030630: 41fa4a22             lea.l $35054(pc), a0
030634: 610011c0             bsr.w $317f6
030638: 23fc00031bfa00dff080 move.l #$31bfa, $dff080.l
030642: 0839000700bfe001     btst.b #$7, $bfe001.l
03064a: 6600fff6             bne.w $30642
03064e: 6000fa74             bra.w $300c4
030652: 3010                 move.w (a0), d0
030654: 3200                 move.w d0, d1
030656: 3400                 move.w d0, d2
030658: 02400f00             andi.w #$f00, d0
03065c: 024100f0             andi.w #$f0, d1
030660: 0242000f             andi.w #$f, d2
030664: e048                 lsr.w #$8, d0
030666: e849                 lsr.w #$4, d1
030668: 06400001             addi.w #$1, d0
03066c: 0c40000f             cmpi.w #$f, d0
030670: 6f000006             ble.w $30678
030674: 303c000f             move.w #$f, d0
030678: 06410001             addi.w #$1, d1
03067c: 0c41000f             cmpi.w #$f, d1
030680: 6f000006             ble.w $30688
030684: 323c000f             move.w #$f, d1
030688: 06420001             addi.w #$1, d2
03068c: 0c42000f             cmpi.w #$f, d2
030690: 6f000006             ble.w $30698
030694: 343c000f             move.w #$f, d2
030698: e148                 lsl.w #$8, d0
03069a: e949                 lsl.w #$4, d1
03069c: 8042                 or.w d2, d0
03069e: 8041                 or.w d1, d0
0306a0: 3080                 move.w d0, (a0)
0306a2: 0c400fff             cmpi.w #$fff, d0
0306a6: 6608                 bne.b $306b0
0306a8: 06790001000306b2     addi.w #$1, $306b2.l
0306b0: 4e75                 rts 
0306b2: 000041fa             ori.b #$fa, d0
0306b6: 1d1c                 move.b (a4)+, -(a6)
0306b8: 303900031894         move.w $31894.l, d0
0306be: 06400002             addi.w #$2, d0
0306c2: 4a700000             tst.w (a0, d0.w)
0306c6: 6a000004             bpl.w $306cc
0306ca: 7000                 moveq #$0, d0
0306cc: 33c000031894         move.w d0, $31894.l
0306d2: 43f00000             lea.l (a0, d0.w), a1
0306d6: 45fa1658             lea.l $31d30(pc), a2
0306da: 303c0006             move.w #$6, d0
0306de: 3219                 move.w (a1)+, d1
0306e0: 6a000008             bpl.w $306ea
0306e4: 43fa1cec             lea.l $323d2(pc), a1
0306e8: 3219                 move.w (a1)+, d1
0306ea: 3481                 move.w d1, (a2)
0306ec: d5fc00000008         adda.l #$8, a2
0306f2: 51c8ffea             dbra d0, $306de
0306f6: 4e75                 rts 
0306f8: 3039000318cc         move.w $318cc.l, d0
0306fe: 0240fff8             andi.w #$fff8, d0
030702: e448                 lsr.w #$2, d0
030704: 3239000318ce         move.w $318ce.l, d1
03070a: 0241fff0             andi.w #$fff0, d1
03070e: c2fc0078             mulu.w #$78, d1
030712: d240                 add.w d0, d1
030714: 207c00070000         movea.l #$70000, a0
03071a: d0c1                 adda.w d1, a0
03071c: 7000                 moveq #$0, d0
03071e: 3080                 move.w d0, (a0)
030720: 31400028             move.w d0, $28(a0)
030724: 31400050             move.w d0, $50(a0)
030728: 31400078             move.w d0, $78(a0)
03072c: 314000a0             move.w d0, $a0(a0)
030730: 314000c8             move.w d0, $c8(a0)
030734: 314000f0             move.w d0, $f0(a0)
030738: 31400118             move.w d0, $118(a0)
03073c: 31400140             move.w d0, $140(a0)
030740: 31400168             move.w d0, $168(a0)
030744: 31400190             move.w d0, $190(a0)
030748: 314001b8             move.w d0, $1b8(a0)
03074c: 314001e0             move.w d0, $1e0(a0)
030750: 31400208             move.w d0, $208(a0)
030754: 31400230             move.w d0, $230(a0)
030758: 31400258             move.w d0, $258(a0)
03075c: 31400280             move.w d0, $280(a0)
030760: 314002a8             move.w d0, $2a8(a0)
030764: 314002d0             move.w d0, $2d0(a0)
030768: 314002f8             move.w d0, $2f8(a0)
03076c: 31400320             move.w d0, $320(a0)
030770: 31400348             move.w d0, $348(a0)
030774: 31400370             move.w d0, $370(a0)
030778: 31400398             move.w d0, $398(a0)
03077c: 314003c0             move.w d0, $3c0(a0)
030780: 314003e8             move.w d0, $3e8(a0)
030784: 31400410             move.w d0, $410(a0)
030788: 31400438             move.w d0, $438(a0)
03078c: 31400460             move.w d0, $460(a0)
030790: 31400488             move.w d0, $488(a0)
030794: 314004b0             move.w d0, $4b0(a0)
030798: 314004d8             move.w d0, $4d8(a0)
03079c: 31400500             move.w d0, $500(a0)
0307a0: 31400528             move.w d0, $528(a0)
0307a4: 31400550             move.w d0, $550(a0)
0307a8: 31400578             move.w d0, $578(a0)
0307ac: 314005a0             move.w d0, $5a0(a0)
0307b0: 314005c8             move.w d0, $5c8(a0)
0307b4: 314005f0             move.w d0, $5f0(a0)
0307b8: 31400618             move.w d0, $618(a0)
0307bc: 31400640             move.w d0, $640(a0)
0307c0: 31400668             move.w d0, $668(a0)
0307c4: 31400690             move.w d0, $690(a0)
0307c8: 314006b8             move.w d0, $6b8(a0)
0307cc: 314006e0             move.w d0, $6e0(a0)
0307d0: 31400708             move.w d0, $708(a0)
0307d4: 31400730             move.w d0, $730(a0)
0307d8: 31400758             move.w d0, $758(a0)
0307dc: 06790001000318a0     addi.w #$1, $318a0.l
0307e4: 23fc11ac1c4000036e6c move.l #$11ac1c40, $36e6c.l
0307ee: 33fcffff00036e6a     move.w #$ffff, $36e6a.l
0307f6: 04790001000318e0     subi.w #$1, $318e0.l
0307fe: 660a                 bne.b $3080a
030800: 33fcffff000318e2     move.w #$ffff, $318e2.l
030808: 4e75                 rts 
03080a: 04790001000318d6     subi.w #$1, $318d6.l
030812: 6626                 bne.b $3083a
030814: 0c79005b000318d4     cmpi.w #$5b, $318d4.l
03081c: 671c                 beq.b $3083a
03081e: 06790001000318d4     addi.w #$1, $318d4.l
030826: 2039000318d8         move.l $318d8.l, d0
03082c: 4840                 swap d0
03082e: 23c0000318d8         move.l d0, $318d8.l
030834: 33c0000318d6         move.w d0, $318d6.l
03083a: 4e75                 rts 
03083c: 4cf97fff00030a62     movem.l $30a62.l, d0-d7/a0-a6
030844: 23cf00030a5e         move.l a7, $30a5e.l
03084a: 2e79000318fa         movea.l $318fa.l, a7
030850: dffc00004100         adda.l #$4100, a7
030856: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03085a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03085e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030862: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030866: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03086a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03086e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030872: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030876: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03087a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03087e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030882: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030886: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03088a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03088e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030892: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030896: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03089a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03089e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308a2: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308a6: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308aa: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308ae: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308b2: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308b6: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308ba: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308be: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308c2: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308c6: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308ca: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308ce: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308d2: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308d6: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308da: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308de: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308e2: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308e6: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308ea: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308ee: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308f2: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308f6: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308fa: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0308fe: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030902: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030906: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03090a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03090e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030912: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030916: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03091a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03091e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030922: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030926: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03092a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03092e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030932: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030936: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03093a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03093e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030942: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030946: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03094a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03094e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030952: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030956: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03095a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03095e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030962: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030966: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03096a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03096e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030972: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030976: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03097a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03097e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030982: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030986: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03098a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03098e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030992: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030996: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03099a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
03099e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309a2: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309a6: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309aa: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309ae: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309b2: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309b6: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309ba: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309be: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309c2: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309c6: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309ca: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309ce: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309d2: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309d6: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309da: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309de: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309e2: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309e6: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309ea: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309ee: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309f2: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309f6: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309fa: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
0309fe: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a02: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a06: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a0a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a0e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a12: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a16: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a1a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a1e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a22: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a26: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a2a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a2e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a32: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a36: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a3a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a3e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a42: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a46: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a4a: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a4e: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a52: 48e7fffe             movem.l d0-d7/a0-a6, -(a7)
030a56: 2e7900030a5e         movea.l $30a5e.l, a7
030a5c: 4e75                 rts 
030a5e: 00000000             ori.b #$0, d0
030a62: 00000000             ori.b #$0, d0
030a66: 00000000             ori.b #$0, d0
030a6a: 00000000             ori.b #$0, d0
030a6e: 00000000             ori.b #$0, d0
030a72: 00000000             ori.b #$0, d0
030a76: 00000000             ori.b #$0, d0
030a7a: 00000000             ori.b #$0, d0
030a7e: 00000000             ori.b #$0, d0
030a82: 00000000             ori.b #$0, d0
030a86: 00000000             ori.b #$0, d0
030a8a: 00000000             ori.b #$0, d0
030a8e: 00000000             ori.b #$0, d0
030a92: 00000000             ori.b #$0, d0
030a96: 00000000             ori.b #$0, d0
030a9a: 00000000             ori.b #$0, d0
030a9e: 00000000             ori.b #$0, d0
030aa2: 2039000318fa         move.l $318fa.l, d0
030aa8: 2239000318fe         move.l $318fe.l, d1
030aae: 243900031902         move.l $31902.l, d2
030ab4: 23c2000318fa         move.l d2, $318fa.l
030aba: 23c0000318fe         move.l d0, $318fe.l
030ac0: 23c100031902         move.l d1, $31902.l
030ac6: 33c100031974         move.w d1, $31974.l
030acc: 06410028             addi.w #$28, d1
030ad0: 33c10003197c         move.w d1, $3197c.l
030ad6: 4841                 swap d1
030ad8: 33c100031970         move.w d1, $31970.l
030ade: 33c100031978         move.w d1, $31978.l
030ae4: 203900031906         move.l $31906.l, d0
030aea: 22390003190a         move.l $3190a.l, d1
030af0: 23c100031906         move.l d1, $31906.l
030af6: 23c00003190a         move.l d0, $3190a.l
030afc: 33c100031a6c         move.w d1, $31a6c.l
030b02: 4841                 swap d1
030b04: 33c100031a68         move.w d1, $31a68.l
030b0a: 4e75                 rts 
030b0c: 33fc0000000318e2     move.w #$0, $318e2.l
030b14: 3039000318cc         move.w $318cc.l, d0
030b1a: 02400007             andi.w #$7, d0
030b1e: 660000de             bne.w $30bfe
030b22: 3039000318ce         move.w $318ce.l, d0
030b28: 0240000f             andi.w #$f, d0
030b2c: 660000d0             bne.w $30bfe
030b30: 3039000318cc         move.w $318cc.l, d0
030b36: 3239000318ce         move.w $318ce.l, d1
030b3c: e648                 lsr.w #$3, d0
030b3e: e849                 lsr.w #$4, d1
030b40: c2fc0014             mulu.w #$14, d1
030b44: d041                 add.w d1, d0
030b46: 41fa301c             lea.l $33b64(pc), a0
030b4a: 12300000             move.b (a0, d0.w), d1
030b4e: 0c01002e             cmpi.b #$2e, d1
030b52: 660a                 bne.b $30b5e
030b54: 11bc00200000         move.b #$20, (a0, d0.w)
030b5a: 6100fb9c             bsr.w $306f8
030b5e: 303900dff00c         move.w $dff00c.l, d0
030b64: 3439000318d0         move.w $318d0.l, d2
030b6a: 08020000             btst.b #$0, d2
030b6e: 6626                 bne.b $30b96
030b70: 08020001             btst.b #$1, d2
030b74: 6620                 bne.b $30b96
030b76: 08000001             btst.b #$1, d0
030b7a: 670a                 beq.b $30b86
030b7c: 33fc0001000318ca     move.w #$1, $318ca.l
030b84: 6040                 bra.b $30bc6
030b86: 08000009             btst.b #$9, d0
030b8a: 670a                 beq.b $30b96
030b8c: 33fc0002000318ca     move.w #$2, $318ca.l
030b94: 6030                 bra.b $30bc6
030b96: 08020002             btst.b #$2, d2
030b9a: 662a                 bne.b $30bc6
030b9c: 08020003             btst.b #$3, d2
030ba0: 6624                 bne.b $30bc6
030ba2: 3200                 move.w d0, d1
030ba4: e249                 lsr.w #$1, d1
030ba6: b141                 eor.w d0, d1
030ba8: 08010000             btst.b #$0, d1
030bac: 670a                 beq.b $30bb8
030bae: 33fc0004000318ca     move.w #$4, $318ca.l
030bb6: 600e                 bra.b $30bc6
030bb8: 08010008             btst.b #$8, d1
030bbc: 6708                 beq.b $30bc6
030bbe: 33fc0008000318ca     move.w #$8, $318ca.l
030bc6: 0839000700bfe001     btst.b #$7, $bfe001.l
030bce: 3039000318ca         move.w $318ca.l, d0
030bd4: 08000000             btst.b #$0, d0
030bd8: 66000040             bne.w $30c1a
030bdc: 08000001             btst.b #$1, d0
030be0: 6600009c             bne.w $30c7e
030be4: 08000002             btst.b #$2, d0
030be8: 660000f8             bne.w $30ce2
030bec: 08000003             btst.b #$3, d0
030bf0: 66000156             bne.w $30d48
030bf4: 33fc0000000318d0     move.w #$0, $318d0.l
030bfc: 4e75                 rts 
030bfe: 4a7900031898         tst.w $31898.l
030c04: 6608                 bne.b $30c0e
030c06: 33fcffff0003189a     move.w #$ffff, $3189a.l
030c0e: 33f9000318d0000318ca move.w $318d0.l, $318ca.l
030c18: 60b4                 bra.b $30bce
030c1a: 0c790001000318d0     cmpi.w #$1, $318d0.l
030c22: 67000038             beq.w $30c5c
030c26: 7400                 moveq #$0, d2
030c28: 7601                 moveq #$1, d3
030c2a: 61000182             bsr.w $30dae
030c2e: 0c000030             cmpi.b #$30, d0
030c32: 6700ffca             beq.w $30bfe
030c36: 06790001000318cc     addi.w #$1, $318cc.l
030c3e: 33fc0001000318d0     move.w #$1, $318d0.l
030c46: 33fcffff000318d2     move.w #$ffff, $318d2.l
030c4e: 41fa0c9c             lea.l $318ec(pc), a0
030c52: 20fc00032bb0         move.l #$32bb0, (a0)+
030c58: 60000192             bra.w $30dec
030c5c: 7400                 moveq #$0, d2
030c5e: 7601                 moveq #$1, d3
030c60: 6100014c             bsr.w $30dae
030c64: 0c00003f             cmpi.b #$3f, d0
030c68: 6708                 beq.b $30c72
030c6a: 0c000030             cmpi.b #$30, d0
030c6e: 6700011a             beq.w $30d8a
030c72: 06790001000318cc     addi.w #$1, $318cc.l
030c7a: 60000170             bra.w $30dec
030c7e: 0c790002000318d0     cmpi.w #$2, $318d0.l
030c86: 67000038             beq.w $30cc0
030c8a: 7400                 moveq #$0, d2
030c8c: 76ff                 moveq #$ff, d3
030c8e: 6100011e             bsr.w $30dae
030c92: 0c000030             cmpi.b #$30, d0
030c96: 6700ff66             beq.w $30bfe
030c9a: 04790001000318cc     subi.w #$1, $318cc.l
030ca2: 33fc0002000318d0     move.w #$2, $318d0.l
030caa: 33fcffff000318d2     move.w #$ffff, $318d2.l
030cb2: 41fa0c38             lea.l $318ec(pc), a0
030cb6: 20fc000329dc         move.l #$329dc, (a0)+
030cbc: 6000012e             bra.w $30dec
030cc0: 7400                 moveq #$0, d2
030cc2: 76ff                 moveq #$ff, d3
030cc4: 610000e8             bsr.w $30dae
030cc8: 0c00003f             cmpi.b #$3f, d0
030ccc: 6708                 beq.b $30cd6
030cce: 0c000030             cmpi.b #$30, d0
030cd2: 670000b6             beq.w $30d8a
030cd6: 04790001000318cc     subi.w #$1, $318cc.l
030cde: 6000010c             bra.w $30dec
030ce2: 0c790004000318d0     cmpi.w #$4, $318d0.l
030cea: 67000038             beq.w $30d24
030cee: 7401                 moveq #$1, d2
030cf0: 7600                 moveq #$0, d3
030cf2: 610000ba             bsr.w $30dae
030cf6: 0c000030             cmpi.b #$30, d0
030cfa: 6700ff02             beq.w $30bfe
030cfe: 06790002000318ce     addi.w #$2, $318ce.l
030d06: 33fc0004000318d0     move.w #$4, $318d0.l
030d0e: 33fcffff000318d2     move.w #$ffff, $318d2.l
030d16: 41fa0bd4             lea.l $318ec(pc), a0
030d1a: 20fc00032634         move.l #$32634, (a0)+
030d20: 600000ca             bra.w $30dec
030d24: 7401                 moveq #$1, d2
030d26: 7600                 moveq #$0, d3
030d28: 61000084             bsr.w $30dae
030d2c: 0c00003f             cmpi.b #$3f, d0
030d30: 6700000a             beq.w $30d3c
030d34: 0c000030             cmpi.b #$30, d0
030d38: 67000050             beq.w $30d8a
030d3c: 06790002000318ce     addi.w #$2, $318ce.l
030d44: 600000a6             bra.w $30dec
030d48: 0c790008000318d0     cmpi.w #$8, $318d0.l
030d50: 6700003a             beq.w $30d8c
030d54: 74ff                 moveq #$ff, d2
030d56: 7600                 moveq #$0, d3
030d58: 61000054             bsr.w $30dae
030d5c: 0c000030             cmpi.b #$30, d0
030d60: 6700fe9c             beq.w $30bfe
030d64: 04790002000318ce     subi.w #$2, $318ce.l
030d6c: 33fc0008000318d0     move.w #$8, $318d0.l
030d74: 33fcffff000318d2     move.w #$ffff, $318d2.l
030d7c: 41fa0b6e             lea.l $318ec(pc), a0
030d80: 20fc00032808         move.l #$32808, (a0)+
030d86: 60000064             bra.w $30dec
030d8a: 4e75                 rts 
030d8c: 74ff                 moveq #$ff, d2
030d8e: 7600                 moveq #$0, d3
030d90: 6100001c             bsr.w $30dae
030d94: 0c00003f             cmpi.b #$3f, d0
030d98: 6708                 beq.b $30da2
030d9a: 0c000030             cmpi.b #$30, d0
030d9e: 6700ffea             beq.w $30d8a
030da2: 04790002000318ce     subi.w #$2, $318ce.l
030daa: 60000040             bra.w $30dec
030dae: 3039000318cc         move.w $318cc.l, d0
030db4: 3200                 move.w d0, d1
030db6: 02400007             andi.w #$7, d0
030dba: 6600002a             bne.w $30de6
030dbe: e649                 lsr.w #$3, d1
030dc0: 3039000318ce         move.w $318ce.l, d0
030dc6: 3800                 move.w d0, d4
030dc8: 0244000f             andi.w #$f, d4
030dcc: 66000018             bne.w $30de6
030dd0: e848                 lsr.w #$4, d0
030dd2: d042                 add.w d2, d0
030dd4: d243                 add.w d3, d1
030dd6: c0fc0014             mulu.w #$14, d0
030dda: d041                 add.w d1, d0
030ddc: 207a0afe             movea.l $318dc(pc), a0
030de0: 10300000             move.b (a0, d0.w), d0
030de4: 4e75                 rts 
030de6: 103c003f             move.b #$3f, d0
030dea: 4e75                 rts 
030dec: 207900035414         movea.l $35414.l, a0
030df2: 3039000318ce         move.w $318ce.l, d0
030df8: d040                 add.w d0, d0
030dfa: 3100                 move.w d0, -(a0)
030dfc: 31400960             move.w d0, $960(a0)
030e00: 3039000318cc         move.w $318cc.l, d0
030e06: d040                 add.w d0, d0
030e08: 3100                 move.w d0, -(a0)
030e0a: 31400960             move.w d0, $960(a0)
030e0e: b1fc00035418         cmpa.l #$35418, a0
030e14: 6606                 bne.b $30e1c
030e16: 207c00035d78         movea.l #$35d78, a0
030e1c: 23c800035414         move.l a0, $35414.l
030e22: 4e75                 rts 
030e24: 4a79000318d2         tst.w $318d2.l
030e2a: 670a                 beq.b $30e36
030e2c: 33fc0000000318d2     move.w #$0, $318d2.l
030e34: 601a                 bra.b $30e50
030e36: 04790001000318f0     subi.w #$1, $318f0.l
030e3e: 6710                 beq.b $30e50
030e40: 2479000318e4         movea.l $318e4.l, a2
030e46: 2679000318e8         movea.l $318e8.l, a3
030e4c: 6000002e             bra.w $30e7c
030e50: 33fc0004000318f0     move.w #$4, $318f0.l
030e58: 2e39000318f2         move.l $318f2.l, d7
030e5e: 5087                 addq.l #$8, d7
030e60: 0c8700000020         cmpi.l #$20, d7
030e66: 6602                 bne.b $30e6a
030e68: 7e00                 moveq #$0, d7
030e6a: 23c7000318f2         move.l d7, $318f2.l
030e70: 2079000318ec         movea.l $318ec.l, a0
030e76: d1c7                 adda.l d7, a0
030e78: 2458                 movea.l (a0)+, a2
030e7a: 2658                 movea.l (a0)+, a3
030e7c: 2e39000318f2         move.l $318f2.l, d7
030e82: 3039000318ce         move.w $318ce.l, d0
030e88: 0640002c             addi.w #$2c, d0
030e8c: 1480                 move.b d0, (a2)
030e8e: 1680                 move.b d0, (a3)
030e90: 06400010             addi.w #$10, d0
030e94: 15400002             move.b d0, $2(a2)
030e98: 17400002             move.b d0, $2(a3)
030e9c: 3039000318cc         move.w $318cc.l, d0
030ea2: 06400040             addi.w #$40, d0
030ea6: 15400001             move.b d0, $1(a2)
030eaa: 17400001             move.b d0, $1(a3)
030eae: 200a                 move.l a2, d0
030eb0: 220b                 move.l a3, d1
030eb2: 23c0000318e4         move.l d0, $318e4.l
030eb8: 23c1000318e8         move.l d1, $318e8.l
030ebe: 33c0000319a8         move.w d0, $319a8.l
030ec4: 4840                 swap d0
030ec6: 33c0000319ac         move.w d0, $319ac.l
030ecc: 33c1000319b0         move.w d1, $319b0.l
030ed2: 4841                 swap d1
030ed4: 33c1000319b4         move.w d1, $319b4.l
030eda: 227900035414         movea.l $35414.l, a1
030ee0: 207c00032da8         movea.l #$32da8, a0
030ee6: d3fc00000018         adda.l #$18, a1
030eec: 3029fffc             move.w -$4(a1), d0
030ef0: b051                 cmp.w (a1), d0
030ef2: 6706                 beq.b $30efa
030ef4: 207c00032cac         movea.l #$32cac, a0
030efa: d1c7                 adda.l d7, a0
030efc: 2458                 movea.l (a0)+, a2
030efe: 30290002             move.w $2(a1), d0
030f02: e248                 lsr.w #$1, d0
030f04: 0640002c             addi.w #$2c, d0
030f08: 1480                 move.b d0, (a2)
030f0a: 06400010             addi.w #$10, d0
030f0e: 15400002             move.b d0, $2(a2)
030f12: 3011                 move.w (a1), d0
030f14: e248                 lsr.w #$1, d0
030f16: 06400040             addi.w #$40, d0
030f1a: 15400001             move.b d0, $1(a2)
030f1e: 200a                 move.l a2, d0
030f20: 33c0000319b8         move.w d0, $319b8.l
030f26: 4840                 swap d0
030f28: 33c0000319bc         move.w d0, $319bc.l
030f2e: 207c00032fa0         movea.l #$32fa0, a0
030f34: d3fc00000018         adda.l #$18, a1
030f3a: 3029fffc             move.w -$4(a1), d0
030f3e: b051                 cmp.w (a1), d0
030f40: 6706                 beq.b $30f48
030f42: 207c00032ea4         movea.l #$32ea4, a0
030f48: d1c7                 adda.l d7, a0
030f4a: 2458                 movea.l (a0)+, a2
030f4c: 30290002             move.w $2(a1), d0
030f50: e248                 lsr.w #$1, d0
030f52: 0640002c             addi.w #$2c, d0
030f56: 1480                 move.b d0, (a2)
030f58: 06400010             addi.w #$10, d0
030f5c: 15400002             move.b d0, $2(a2)
030f60: 3011                 move.w (a1), d0
030f62: e248                 lsr.w #$1, d0
030f64: 06400040             addi.w #$40, d0
030f68: 15400001             move.b d0, $1(a2)
030f6c: 200a                 move.l a2, d0
030f6e: 33c0000319c0         move.w d0, $319c0.l
030f74: 4840                 swap d0
030f76: 33c0000319c4         move.w d0, $319c4.l
030f7c: 4e75                 rts 
030f7e: 47fa3d3c             lea.l $34cbc(pc), a3
030f82: 49fa3e78             lea.l $34dfc(pc), a4
030f86: 4bfa428c             lea.l $35214(pc), a5
030f8a: 2c7900031906         movea.l $31906.l, a6
030f90: 207c00033144         movea.l #$33144, a0
030f96: d1c7                 adda.l d7, a0
030f98: 2c10                 move.l (a0), d6
030f9a: 207c000332e4         movea.l #$332e4, a0
030fa0: d1c7                 adda.l d7, a0
030fa2: 2e10                 move.l (a0), d7
030fa4: 263c00580802         move.l #$580802, d3
030faa: 283c00033304         move.l #$33304, d4
030fb0: 2cfc00660024         move.l #$660024, (a6)+
030fb6: 3a39000318d4         move.w $318d4.l, d5
030fbc: 676e                 beq.b $3102c
030fbe: 5345                 subq.w #$1, d5
030fc0: 2047                 movea.l d7, a0
030fc2: d3fc00000018         adda.l #$18, a1
030fc8: 3029fffc             move.w -$4(a1), d0
030fcc: b051                 cmp.w (a1), d0
030fce: 6702                 beq.b $30fd2
030fd0: 2046                 movea.l d6, a0
030fd2: 3011                 move.w (a1), d0
030fd4: 2479000318fe         movea.l $318fe.l, a2
030fda: d4f40000             adda.w (a4, d0.w), a2
030fde: 30330000             move.w (a3, d0.w), d0
030fe2: 34290002             move.w $2(a1), d2
030fe6: d4f52000             adda.w (a5, d2.w), a2
030fea: 3200                 move.w d0, d1
030fec: 00400fca             ori.w #$fca, d0
030ff0: 3cfc0040             move.w #$40, (a6)+
030ff4: 3cc0                 move.w d0, (a6)+
030ff6: 3cfc0042             move.w #$42, (a6)+
030ffa: 3cc1                 move.w d1, (a6)+
030ffc: 3cfc004a             move.w #$4a, (a6)+
031000: 3cca                 move.w a2, (a6)+
031002: 3cfc004e             move.w #$4e, (a6)+
031006: 3cc8                 move.w a0, (a6)+
031008: 3cfc0056             move.w #$56, (a6)+
03100c: 3cca                 move.w a2, (a6)+
03100e: 3cfc0052             move.w #$52, (a6)+
031012: 3cc4                 move.w d4, (a6)+
031014: 2cc3                 move.l d3, (a6)+
031016: 2cfc00010000         move.l #$10000, (a6)+
03101c: 2cfc00010000         move.l #$10000, (a6)+
031022: 2cfc00010000         move.l #$10000, (a6)+
031028: 51cdff96             dbra d5, $30fc0
03102c: 2039000318fa         move.l $318fa.l, d0
031032: 068000000500         addi.l #$500, d0
031038: 3cfc0056             move.w #$56, (a6)+
03103c: 3cc0                 move.w d0, (a6)+
03103e: 4840                 swap d0
031040: 3cfc0054             move.w #$54, (a6)+
031044: 3cc0                 move.w d0, (a6)+
031046: 2cfc004001f0         move.l #$4001f0, (a6)+
03104c: 2cfc00420000         move.l #$420000, (a6)+
031052: 2cfc00740000         move.l #$740000, (a6)+
031058: 2cfc00660000         move.l #$660000, (a6)+
03105e: 2cfc00581828         move.l #$581828, (a6)+
031064: 2cfcffdffffe         move.l #$ffdffffe, (a6)+
03106a: 2cfc0c01fffe         move.l #$c01fffe, (a6)+
031070: 203c00031cd2         move.l #$31cd2, d0
031076: 3cfc0086             move.w #$86, (a6)+
03107a: 3cc0                 move.w d0, (a6)+
03107c: 4840                 swap d0
03107e: 3cfc0084             move.w #$84, (a6)+
031082: 3cc0                 move.w d0, (a6)+
031084: 2cfc008a0000         move.l #$8a0000, (a6)+
03108a: 4e75                 rts 
03108c: 33fc00000003189c     move.w #$0, $3189c.l
031094: 23fc00031a7600dff080 move.l #$31a76, $dff080.l
03109e: 41fa0906             lea.l $319a6(pc), a0
0310a2: 43fa0a1e             lea.l $31ac2(pc), a1
0310a6: 303c0007             move.w #$7, d0
0310aa: 22d8                 move.l (a0)+, (a1)+
0310ac: 51c8fffc             dbra d0, $310aa
0310b0: 41fa08bc             lea.l $3196e(pc), a0
0310b4: 43fa09d4             lea.l $31a8a(pc), a1
0310b8: 303c0003             move.w #$3, d0
0310bc: 22d8                 move.l (a0)+, (a1)+
0310be: 51c8fffc             dbra d0, $310bc
0310c2: 207900035414         movea.l $35414.l, a0
0310c8: d1fc00000034         adda.l #$34, a0
0310ce: 33f9000318d400031552 move.w $318d4.l, $31552.l
0310d8: 47fa3be2             lea.l $34cbc(pc), a3
0310dc: 49fa3d1e             lea.l $34dfc(pc), a4
0310e0: 4bfa4132             lea.l $35214(pc), a5
0310e4: 61000378             bsr.w $3145e
0310e8: 61000374             bsr.w $3145e
0310ec: 61000370             bsr.w $3145e
0310f0: 61000396             bsr.w $31488
0310f4: 33fc000000dff062     move.w #$0, $dff062.l
0310fc: 33fc000000dff064     move.w #$0, $dff064.l
031104: 33fc002400dff066     move.w #$24, $dff066.l
03110c: 33fc002400dff060     move.w #$24, $dff060.l
031114: 61000348             bsr.w $3145e
031118: 303900031552         move.w $31552.l, d0
03111e: 0479000100031552     subi.w #$1, $31552.l
031126: 4df90003152e         lea.l $3152e.l, a6
03112c: 7e00                 moveq #$0, d7
03112e: 2c87                 move.l d7, (a6)
031130: 2d470004             move.l d7, $4(a6)
031134: 2d470008             move.l d7, $8(a6)
031138: 2d47000c             move.l d7, $c(a6)
03113c: 2d470010             move.l d7, $10(a6)
031140: 2d470014             move.l d7, $14(a6)
031144: 2d470018             move.l d7, $18(a6)
031148: 2d47001c             move.l d7, $1c(a6)
03114c: 3e3c0007             move.w #$7, d7
031150: 7200                 moveq #$0, d1
031152: 3441                 movea.w d1, a2
031154: 0c400001             cmpi.w #$1, d0
031158: 6d00002e             blt.w $31188
03115c: b079000318d4         cmp.w $318d4.l, d0
031162: 6e000038             bgt.w $3119c
031166: 3200                 move.w d0, d1
031168: c2fc0018             mulu.w #$18, d1
03116c: 43f01000             lea.l (a0, d1.w), a1
031170: 3211                 move.w (a1), d1
031172: 247900031902         movea.l $31902.l, a2
031178: d4f41000             adda.w (a4, d1.w), a2
03117c: 32331000             move.w (a3, d1.w), d1
031180: 34290002             move.w $2(a1), d2
031184: d4f52000             adda.w (a5, d2.w), a2
031188: 3cc1                 move.w d1, (a6)+
03118a: 3cca                 move.w a2, (a6)+
03118c: 06400001             addi.w #$1, d0
031190: 51cfffbe             dbra d7, $31150
031194: 0c400001             cmpi.w #$1, d0
031198: 6f0000bc             ble.w $31256
03119c: 4df900031532         lea.l $31532.l, a6
0311a2: 3e3c0006             move.w #$6, d7
0311a6: 321e                 move.w (a6)+, d1
0311a8: 301e                 move.w (a6)+, d0
0311aa: 673c                 beq.b $311e8
0311ac: 3401                 move.w d1, d2
0311ae: 00410bca             ori.w #$bca, d1
0311b2: 610002d4             bsr.w $31488
0311b6: 33c100dff040         move.w d1, $dff040.l
0311bc: 33c200dff042         move.w d2, $dff042.l
0311c2: 33fc000000dff072     move.w #$0, $dff072.l
0311ca: 33c000dff04a         move.w d0, $dff04a.l
0311d0: 33c000dff056         move.w d0, $dff056.l
0311d6: 23fc0003155600dff050 move.l #$31556, $dff050.l
0311e0: 33fc080200dff058     move.w #$802, $dff058.l
0311e8: 51cfffbc             dbra d7, $311a6
0311ec: 23fc11ac0c4000036e6c move.l #$11ac0c40, $36e6c.l
0311f6: 33fcffff00036e6a     move.w #$ffff, $36e6a.l
0311fe: 4df90003152e         lea.l $3152e.l, a6
031204: 45f9000314c2         lea.l $314c2.l, a2
03120a: 3e3c0006             move.w #$6, d7
03120e: 281a                 move.l (a2)+, d4
031210: 261a                 move.l (a2)+, d3
031212: 321e                 move.w (a6)+, d1
031214: 301e                 move.w (a6)+, d0
031216: 6736                 beq.b $3124e
031218: 3401                 move.w d1, d2
03121a: 00410fca             ori.w #$fca, d1
03121e: 61000268             bsr.w $31488
031222: 33c100dff040         move.w d1, $dff040.l
031228: 33c200dff042         move.w d2, $dff042.l
03122e: 33c000dff04a         move.w d0, $dff04a.l
031234: 33c400dff04e         move.w d4, $dff04e.l
03123a: 33c000dff056         move.w d0, $dff056.l
031240: 33c300dff052         move.w d3, $dff052.l
031246: 33fc080200dff058     move.w #$802, $dff058.l
03124e: 51cfffbe             dbra d7, $3120e
031252: 6000fec0             bra.w $31114
031256: 47f900031adc         lea.l $31adc.l, a3
03125c: 49f900031ae0         lea.l $31ae0.l, a4
031262: 227900035414         movea.l $35414.l, a1
031268: d3fc00000030         adda.l #$30, a1
03126e: 3a3c0001             move.w #$1, d5
031272: 3e3c0005             move.w #$5, d7
031276: 610001e6             bsr.w $3145e
03127a: 247c00032f10         movea.l #$32f10, a2
031280: 3029fffc             move.w -$4(a1), d0
031284: b051                 cmp.w (a1), d0
031286: 6706                 beq.b $3128e
031288: 247c00032e14         movea.l #$32e14, a2
03128e: 30290002             move.w $2(a1), d0
031292: e248                 lsr.w #$1, d0
031294: 0640002c             addi.w #$2c, d0
031298: 1480                 move.b d0, (a2)
03129a: 06400010             addi.w #$10, d0
03129e: 15400002             move.b d0, $2(a2)
0312a2: 3011                 move.w (a1), d0
0312a4: e248                 lsr.w #$1, d0
0312a6: 06400040             addi.w #$40, d0
0312aa: 15400001             move.b d0, $1(a2)
0312ae: 200a                 move.l a2, d0
0312b0: 3680                 move.w d0, (a3)
0312b2: 4840                 swap d0
0312b4: 3880                 move.w d0, (a4)
0312b6: 93fc00000004         suba.l #$4, a1
0312bc: 51cfffb8             dbra d7, $31276
0312c0: 36bc0000             move.w #$0, (a3)
0312c4: 38bc0000             move.w #$0, (a4)
0312c8: 47f900031ad4         lea.l $31ad4.l, a3
0312ce: 49f900031ad8         lea.l $31ad8.l, a4
0312d4: 51cdff9c             dbra d5, $31272
0312d8: 33fc0000000314c0     move.w #$0, $314c0.l
0312e0: 3e3c0019             move.w #$19, d7
0312e4: 61000178             bsr.w $3145e
0312e8: 61000174             bsr.w $3145e
0312ec: 61000170             bsr.w $3145e
0312f0: 41f90003149c         lea.l $3149c.l, a0
0312f6: 3039000314c0         move.w $314c0.l, d0
0312fc: 06400008             addi.w #$8, d0
031300: 0c400020             cmpi.w #$20, d0
031304: 6602                 bne.b $31308
031306: 7000                 moveq #$0, d0
031308: 33c0000314c0         move.w d0, $314c0.l
03130e: 41f00000             lea.l (a0, d0.w), a0
031312: 2458                 movea.l (a0)+, a2
031314: 2658                 movea.l (a0)+, a3
031316: 3039000318ce         move.w $318ce.l, d0
03131c: 0640002c             addi.w #$2c, d0
031320: 1480                 move.b d0, (a2)
031322: 1680                 move.b d0, (a3)
031324: 06400010             addi.w #$10, d0
031328: 15400002             move.b d0, $2(a2)
03132c: 17400002             move.b d0, $2(a3)
031330: 3039000318cc         move.w $318cc.l, d0
031336: 06400040             addi.w #$40, d0
03133a: 15400001             move.b d0, $1(a2)
03133e: 17400001             move.b d0, $1(a3)
031342: 200a                 move.l a2, d0
031344: 220b                 move.l a3, d1
031346: 33c000031ac4         move.w d0, $31ac4.l
03134c: 4840                 swap d0
03134e: 33c000031ac8         move.w d0, $31ac8.l
031354: 33c100031acc         move.w d1, $31acc.l
03135a: 4841                 swap d1
03135c: 33c100031ad0         move.w d1, $31ad0.l
031362: 51cfff80             dbra d7, $312e4
031366: 33fc000000031ac4     move.w #$0, $31ac4.l
03136e: 33fc000000031ac8     move.w #$0, $31ac8.l
031376: 33fc000000031acc     move.w #$0, $31acc.l
03137e: 33fc000000031ad0     move.w #$0, $31ad0.l
031386: 47fa3934             lea.l $34cbc(pc), a3
03138a: 49fa3a70             lea.l $34dfc(pc), a4
03138e: 4bfa3e84             lea.l $35214(pc), a5
031392: 3239000318cc         move.w $318cc.l, d1
031398: d241                 add.w d1, d1
03139a: 247900031902         movea.l $31902.l, a2
0313a0: d4f41000             adda.w (a4, d1.w), a2
0313a4: 32331000             move.w (a3, d1.w), d1
0313a8: 3439000318ce         move.w $318ce.l, d2
0313ae: d442                 add.w d2, d2
0313b0: d4f52000             adda.w (a5, d2.w), a2
0313b4: 3401                 move.w d1, d2
0313b6: 00410fca             ori.w #$fca, d1
0313ba: 41f9000314fa         lea.l $314fa.l, a0
0313c0: 23fc11ac0c4000036e6c move.l #$11ac0c40, $36e6c.l
0313ca: 33fcffff00036e6a     move.w #$ffff, $36e6a.l
0313d2: 3e3c000c             move.w #$c, d7
0313d6: 2818                 move.l (a0)+, d4
0313d8: 61000084             bsr.w $3145e
0313dc: 61000080             bsr.w $3145e
0313e0: 610000a6             bsr.w $31488
0313e4: 33c100dff040         move.w d1, $dff040.l
0313ea: 33c200dff042         move.w d2, $dff042.l
0313f0: 33ca00dff04a         move.w a2, $dff04a.l
0313f6: 23c400dff04c         move.l d4, $dff04c.l
0313fc: 33ca00dff056         move.w a2, $dff056.l
031402: 23fc0003330400dff050 move.l #$33304, $dff050.l
03140c: 33fc080200dff058     move.w #$802, $dff058.l
031414: 51cfffc0             dbra d7, $313d6
031418: 3e3c0032             move.w #$32, d7
03141c: 61000040             bsr.w $3145e
031420: 51cffffa             dbra d7, $3141c
031424: 4a7900031890         tst.w $31890.l
03142a: 6600f1da             bne.w $30606
03142e: 0479000100031896     subi.w #$1, $31896.l
031436: 4a7900031896         tst.w $31896.l
03143c: 6b000006             bmi.w $31444
031440: 6000f1c4             bra.w $30606
031444: 23fc00031c6600dff080 move.l #$31c66, $dff080.l
03144e: 3e3c0096             move.w #$96, d7
031452: 6100000a             bsr.w $3145e
031456: 51cffffa             dbra d7, $31452
03145a: 6000ed5a             bra.w $301b6
03145e: 203900dff004         move.l $dff004.l, d0
031464: 02800001ff00         andi.l #$1ff00, d0
03146a: 0c800000fe00         cmpi.l #$fe00, d0
031470: 66ec                 bne.b $3145e
031472: 203900dff004         move.l $dff004.l, d0
031478: 02800001ff00         andi.l #$1ff00, d0
03147e: 0c800000ff00         cmpi.l #$ff00, d0
031484: 66ec                 bne.b $31472
031486: 4e75                 rts 
031488: 0839000e00dff002     btst.b #$e, $dff002.l
031490: 0839000e00dff002     btst.b #$e, $dff002.l
031498: 66ee                 bne.b $31488
03149a: 4e75                 rts 
03149c: 00032484             ori.b #$84, d3
0314a0: 000324cc             ori.b #$cc, d3
0314a4: 0003282c             ori.b #$2c, d3
0314a8: 00032874             ori.b #$74, d3
0314ac: 00032658             ori.b #$58, d3
0314b0: 000326a0             ori.b #$a0, d3
0314b4: 00032a00             ori.b #$0, d3
0314b8: 00032a48             ori.b #$48, d3
0314bc: 00000000             ori.b #$0, d0
0314c0: 00000003             ori.b #$3, d0
0314c4: 3404                 move.w d4, d2
0314c6: 00033784             ori.b #$84, d3
0314ca: 00033704             ori.b #$4, d3
0314ce: 00033a84             ori.b #$84, d3
0314d2: 00033684             ori.b #$84, d3
0314d6: 00033a04             ori.b #$4, d3
0314da: 00033604             ori.b #$4, d3
0314de: 00033984             ori.b #$84, d3
0314e2: 00033584             ori.b #$84, d3
0314e6: 00033904             ori.b #$4, d3
0314ea: 00033504             ori.b #$4, d3
0314ee: 00033884             ori.b #$84, d3
0314f2: 00033484             ori.b #$84, d3
0314f6: 00033804             ori.b #$4, d3
0314fa: 00033404             ori.b #$4, d3
0314fe: 00033704             ori.b #$4, d3
031502: 00033684             ori.b #$84, d3
031506: 00033604             ori.b #$4, d3
03150a: 00033584             ori.b #$84, d3
03150e: 00033504             ori.b #$4, d3
031512: 00033484             ori.b #$84, d3
031516: 00033504             ori.b #$4, d3
03151a: 00033584             ori.b #$84, d3
03151e: 00033604             ori.b #$4, d3
031522: 00033684             ori.b #$84, d3
031526: 00033704             ori.b #$4, d3
03152a: 00033384             ori.b #$84, d3
03152e: 00000000             ori.b #$0, d0
031532: 00000000             ori.b #$0, d0
031536: 00000000             ori.b #$0, d0
03153a: 00000000             ori.b #$0, d0
03153e: 00000000             ori.b #$0, d0
031542: 00000000             ori.b #$0, d0
031546: 00000000             ori.b #$0, d0
03154a: 00000000             ori.b #$0, d0
03154e: 00000000             ori.b #$0, d0
031552: 00000000             ori.b #$0, d0
031556: dc.w ffff
031558: 0000ffff             ori.b #$ff, d0
03155c: 0000ffff             ori.b #$ff, d0
031560: 0000ffff             ori.b #$ff, d0
031564: 0000ffff             ori.b #$ff, d0
031568: 0000ffff             ori.b #$ff, d0
03156c: 0000ffff             ori.b #$ff, d0
031570: 0000ffff             ori.b #$ff, d0
031574: 0000ffff             ori.b #$ff, d0
031578: 0000ffff             ori.b #$ff, d0
03157c: 0000ffff             ori.b #$ff, d0
031580: 0000ffff             ori.b #$ff, d0
031584: 0000ffff             ori.b #$ff, d0
031588: 0000ffff             ori.b #$ff, d0
03158c: 0000ffff             ori.b #$ff, d0
031590: 0000ffff             ori.b #$ff, d0
031594: 0000ffff             ori.b #$ff, d0
031598: 0000ffff             ori.b #$ff, d0
03159c: 0000ffff             ori.b #$ff, d0
0315a0: 0000ffff             ori.b #$ff, d0
0315a4: 0000ffff             ori.b #$ff, d0
0315a8: 0000ffff             ori.b #$ff, d0
0315ac: 0000ffff             ori.b #$ff, d0
0315b0: 0000ffff             ori.b #$ff, d0
0315b4: 0000ffff             ori.b #$ff, d0
0315b8: 0000ffff             ori.b #$ff, d0
0315bc: 0000ffff             ori.b #$ff, d0
0315c0: 0000ffff             ori.b #$ff, d0
0315c4: 0000ffff             ori.b #$ff, d0
0315c8: 0000ffff             ori.b #$ff, d0
0315cc: 0000ffff             ori.b #$ff, d0
0315d0: 0000ffff             ori.b #$ff, d0
0315d4: 0000ffff             ori.b #$ff, d0
0315d8: 0000ffff             ori.b #$ff, d0
0315dc: 0000ffff             ori.b #$ff, d0
0315e0: 0000ffff             ori.b #$ff, d0
0315e4: 0000ffff             ori.b #$ff, d0
0315e8: 0000ffff             ori.b #$ff, d0
0315ec: 0000ffff             ori.b #$ff, d0
0315f0: 0000ffff             ori.b #$ff, d0
0315f4: 0000ffff             ori.b #$ff, d0
0315f8: 0000ffff             ori.b #$ff, d0
0315fc: 0000ffff             ori.b #$ff, d0
031600: 0000ffff             ori.b #$ff, d0
031604: 0000ffff             ori.b #$ff, d0
031608: 0000ffff             ori.b #$ff, d0
03160c: 0000ffff             ori.b #$ff, d0
031610: 0000ffff             ori.b #$ff, d0
031614: 0000ffff             ori.b #$ff, d0
031618: 0000ffff             ori.b #$ff, d0
03161c: 0000ffff             ori.b #$ff, d0
031620: 0000ffff             ori.b #$ff, d0
031624: 0000ffff             ori.b #$ff, d0
031628: 0000ffff             ori.b #$ff, d0
03162c: 0000ffff             ori.b #$ff, d0
031630: 0000ffff             ori.b #$ff, d0
031634: 0000ffff             ori.b #$ff, d0
031638: 0000ffff             ori.b #$ff, d0
03163c: 0000ffff             ori.b #$ff, d0
031640: 0000ffff             ori.b #$ff, d0
031644: 0000ffff             ori.b #$ff, d0
031648: 0000ffff             ori.b #$ff, d0
03164c: 0000ffff             ori.b #$ff, d0
031650: 0000ffff             ori.b #$ff, d0
031654: 00003039             ori.b #$39, d0
031658: 00031892             ori.b #$92, d3
03165c: 5340                 subq.w #$1, d0
03165e: e548                 lsl.w #$2, d0
031660: 41fa0240             lea.l $318a2(pc), a0
031664: 20700000             movea.l (a0, d0.w), a0
031668: 2250                 movea.l (a0), a1
03166a: 33d9000318e0         move.w (a1)+, $318e0.l
031670: 33d900031898         move.w (a1)+, $31898.l
031676: 23c9000318dc         move.l a1, $318dc.l
03167c: 47fa24e6             lea.l $33b64(pc), a3
031680: 2c49                 movea.l a1, a6
031682: 303c0117             move.w #$117, d0
031686: 16de                 move.b (a6)+, (a3)+
031688: 51c8fffc             dbra d0, $31686
03168c: 247c00070000         movea.l #$70000, a2
031692: 2c49                 movea.l a1, a6
031694: 3c3c0000             move.w #$0, d6
031698: 3e3c0000             move.w #$0, d7
03169c: 101e                 move.b (a6)+, d0
03169e: 0c000020             cmpi.b #$20, d0
0316a2: 67000016             beq.w $316ba
0316a6: 0c00002e             cmpi.b #$2e, d0
0316aa: 67000008             beq.w $316b4
0316ae: 26680004             movea.l $4(a0), a3
0316b2: 600a                 bra.b $316be
0316b4: 26680008             movea.l $8(a0), a3
0316b8: 6004                 bra.b $316be
0316ba: 47fa2448             lea.l $33b04(pc), a3
0316be: 224a                 movea.l a2, a1
0316c0: 323c0780             move.w #$780, d1
0316c4: c2c6                 mulu.w d6, d1
0316c6: d247                 add.w d7, d1
0316c8: 224a                 movea.l a2, a1
0316ca: d2c1                 adda.w d1, a1
0316cc: 0839000e00dff002     btst.b #$e, $dff002.l
0316d4: 66f6                 bne.b $316cc
0316d6: 33fc09f000dff040     move.w #$9f0, $dff040.l
0316de: 33fc000000dff042     move.w #$0, $dff042.l
0316e6: 23fcffffffff00dff044 move.l #$ffffffff, $dff044.l
0316f0: 23cb00dff050         move.l a3, $dff050.l
0316f6: 23c900dff054         move.l a1, $dff054.l
0316fc: 33fc000000dff064     move.w #$0, $dff064.l
031704: 33fc002600dff066     move.w #$26, $dff066.l
03170c: 33fc0c0100dff058     move.w #$c01, $dff058.l
031714: 06470002             addi.w #$2, d7
031718: 0c470028             cmpi.w #$28, d7
03171c: 6600ff7e             bne.w $3169c
031720: 3e3c0000             move.w #$0, d7
031724: 06460001             addi.w #$1, d6
031728: 0c46000e             cmpi.w #$e, d6
03172c: 6600ff6e             bne.w $3169c
031730: 2268000c             movea.l $c(a0), a1
031734: 41fa02b2             lea.l $319e8(pc), a0
031738: 45fa03ce             lea.l $31b08(pc), a2
03173c: 303c0007             move.w #$7, d0
031740: 30d1                 move.w (a1), (a0)+
031742: 34d9                 move.w (a1)+, (a2)+
031744: 4a58                 tst.w (a0)+
031746: 4a5a                 tst.w (a2)+
031748: 51c8fff6             dbra d0, $31740
03174c: 4e75                 rts 
03174e: 7000                 moveq #$0, d0
031750: 303900031898         move.w $31898.l, d0
031756: 80fc000a             divu.w #$a, d0
03175a: 7e00                 moveq #$0, d7
03175c: 3e00                 move.w d0, d7
03175e: 4840                 swap d0
031760: 323c0018             move.w #$18, d1
031764: 41f900057a58         lea.l $57a58.l, a0
03176a: 6100008a             bsr.w $317f6
03176e: 2007                 move.l d7, d0
031770: 80fc000a             divu.w #$a, d0
031774: 4840                 swap d0
031776: 323c0017             move.w #$17, d1
03177a: 41f900057a58         lea.l $57a58.l, a0
031780: 61000074             bsr.w $317f6
031784: 4e75                 rts 
031786: 7000                 moveq #$0, d0
031788: 3039000318a0         move.w $318a0.l, d0
03178e: 80fc000a             divu.w #$a, d0
031792: 7e00                 moveq #$0, d7
031794: 3e00                 move.w d0, d7
031796: 4840                 swap d0
031798: 323c000c             move.w #$c, d1
03179c: 41f900057a58         lea.l $57a58.l, a0
0317a2: 61000052             bsr.w $317f6
0317a6: 2007                 move.l d7, d0
0317a8: 80fc000a             divu.w #$a, d0
0317ac: 7e00                 moveq #$0, d7
0317ae: 3e00                 move.w d0, d7
0317b0: 4840                 swap d0
0317b2: 323c000b             move.w #$b, d1
0317b6: 41f900057a58         lea.l $57a58.l, a0
0317bc: 61000038             bsr.w $317f6
0317c0: 2007                 move.l d7, d0
0317c2: 80fc000a             divu.w #$a, d0
0317c6: 7e00                 moveq #$0, d7
0317c8: 3e00                 move.w d0, d7
0317ca: 4840                 swap d0
0317cc: 323c000a             move.w #$a, d1
0317d0: 41f900057a58         lea.l $57a58.l, a0
0317d6: 6100001e             bsr.w $317f6
0317da: 2007                 move.l d7, d0
0317dc: 80fc000a             divu.w #$a, d0
0317e0: 7e00                 moveq #$0, d7
0317e2: 3e00                 move.w d0, d7
0317e4: 4840                 swap d0
0317e6: 323c0009             move.w #$9, d1
0317ea: 41f900057a58         lea.l $57a58.l, a0
0317f0: 61000004             bsr.w $317f6
0317f4: 4e75                 rts 
0317f6: d0c1                 adda.w d1, a0
0317f8: 0240000f             andi.w #$f, d0
0317fc: c0fc0008             mulu.w #$8, d0
031800: 43fa3992             lea.l $35194(pc), a1
031804: 43f10000             lea.l (a1, d0.w), a1
031808: 303c0007             move.w #$7, d0
03180c: 1099                 move.b (a1)+, (a0)
03180e: d1fc00000028         adda.l #$28, a0
031814: 51c8fff6             dbra d0, $3180c
031818: 4e75                 rts 
03181a: 48e78080             movem.l d0/a0, -(a7)
03181e: 33fc000800dff09c     move.w #$8, $dff09c.l
031826: 0839000300bfed01     btst.b #$3, $bfed01.l
03182e: 6742                 beq.b $31872
031830: 7000                 moveq #$0, d0
031832: 103900bfec01         move.b $bfec01.l, d0
031838: 08f9000600bfee01     bset.b #$6, $bfee01.l
031840: 423900bfec01         clr.b $bfec01.l
031846: e218                 ror.b #$1, d0
031848: 4600                 not.b d0
03184a: 6b08                 bmi.b $31854
03184c: 13c00003188a         move.b d0, $3188a.l
031852: 6008                 bra.b $3185c
031854: 13fc00000003188a     move.b #$0, $3188a.l
03185c: 7064                 moveq #$64, d0
03185e: 51c8fffe             dbra d0, $3185e
031862: 13fc00ff00bfec01     move.b #$ff, $bfec01.l
03186a: 08b9000600bfee01     bclr.b #$6, $bfee01.l
031872: 4cdf0101             movem.l (a7)+, d0/a0
031876: 4e73                 rte 
031878: 1425                 move.b -(a5), d2
03187a: dc.w 1240
03187c: 1318                 move.b (a0)+, -(a1)
03187e: 36332812             move.w $12(a3, d2.l), d3
031882: 13402420             move.b d0, $2420(a1)
031886: 3624                 move.w -(a4), d3
031888: dc.w ffff
03188a: 00000000             ori.b #$0, d0
03188e: 00000000             ori.b #$0, d0
031892: 00000000             ori.b #$0, d0
031896: 00000000             ori.b #$0, d0
03189a: 00000000             ori.b #$0, d0
03189e: 00000000             ori.b #$0, d0
0318a2: 00033c7c             ori.b #$7c, d3
0318a6: 00033e90             ori.b #$90, d3
0318aa: 000340a4             ori.b #$a4, d3
0318ae: 000342b8             ori.b #$b8, d3
0318b2: 000344cc             ori.b #$cc, d3
0318b6: 000346e0             ori.b #$e0, d3
0318ba: 0003480c             ori.b #$c, d3
0318be: 00034938             ori.b #$38, d3
0318c2: 00034a64             ori.b #$64, d3
0318c6: 00034b90             ori.b #$90, d3
0318ca: 00000050             ori.b #$50, d0
0318ce: dc.w 00c0
0318d0: 00000000             ori.b #$0, d0
0318d4: 00000002             ori.b #$2, d0
0318d8: 00020001             ori.b #$1, d2
0318dc: 00000000             ori.b #$0, d0
0318e0: 00000000             ori.b #$0, d0
0318e4: 00032a00             ori.b #$0, d3
0318e8: 00032a48             ori.b #$48, d3
0318ec: 00032bb0             ori.b #$b0, d3
0318f0: 00040000             ori.b #$0, d4
0318f4: 00000000             ori.b #$0, d0
0318f8: 00000006             ori.b #$6, d0
0318fc: 00000006             ori.b #$6, d0
031900: 5000                 addq.b #$8, d0
031902: 0006a000             ori.b #$0, d6
031906: 0005e000             ori.b #$0, d5
03190a: 0005f000             ori.b #$0, d5
03190e: 00000000             ori.b #$0, d0
031912: 00000000             ori.b #$0, d0
031916: 01d0                 bset.b d0, (a0)
031918: 0706                 btst.l d3, d6
03191a: dc.w 0fbe
03191c: dc.w 0fbe
03191e: dc.w 0820
031920: dc.w 0fff
031922: dc.w 0822
031924: 0c3308200eff         cmpi.b #$20, -$1(a3, d0.l)
03192a: 09a2                 bclr.b d4, -(a2)
03192c: dc.w 0ffb
03192e: 000007d9             ori.b #$d9, d0
031932: 00000000             ori.b #$0, d0
031936: 01d8                 bset.b d0, (a0)+
031938: 0706                 btst.l d3, d6
03193a: dc.w f180
03193c: dc.w f180
03193e: 8300                 sbcd.b d0, d1
031940: dc.w fbc0
031942: dc.w a000
031944: e5e0                 roxl.w -(a0)
031946: 8000                 or.b d0, d0
031948: f8c0                 dc.w $f8c0
03194a: 9180                 subx.l d0, d0
03194c: dc.w f580
03194e: 000078c0             ori.b #$c0, d0
031952: 00000000             ori.b #$0, d0
031956: 009680200102         ori.l #$80200102, (a6)
03195c: 0000008e             ori.b #$8e, d0
031960: 2c81                 move.l d1, (a6)
031962: 00902cc10092         ori.l #$2cc10092, (a0)
031968: 0038009400d0         ori.b #$94, $d0.w
03196e: dc.w 00e4
031970: 000600e6             ori.b #$e6, d6
031974: 000000ec             ori.b #$ec, d0
031978: 000600ee             ori.b #$ee, d6
03197c: 002800e00007         ori.b #$e0, $7(a0)
031982: dc.w 00e2
031984: 000000e8             ori.b #$e8, d0
031988: 000700ea             ori.b #$ea, d7
03198c: 002800f00007         ori.b #$f0, $7(a0)
031992: dc.w 00f2
031994: 00500100             ori.w #$100, (a0)
031998: 5600                 addq.b #$3, d0
03199a: 01080050             movep.w $50(a0), d0
03199e: 010a0028             movep.w $28(a2), d0
0319a2: 0104                 btst.l d0, d4
0319a4: 00440122             ori.w #$122, d4
0319a8: 00000120             ori.b #$20, d0
0319ac: 00000126             ori.b #$26, d0
0319b0: 00000124             ori.b #$24, d0
0319b4: 00000132             ori.b #$32, d0
0319b8: 00000130             ori.b #$30, d0
0319bc: 00000136             ori.b #$36, d0
0319c0: 00000134             ori.b #$34, d0
0319c4: 00000138             ori.b #$38, d0
0319c8: 0000013a             ori.b #$3a, d0
0319cc: 0000013c             ori.b #$3c, d0
0319d0: 0000013e             ori.b #$3e, d0
0319d4: 00000128             ori.b #$28, d0
0319d8: 0000012a             ori.b #$2a, d0
0319dc: 0000012c             ori.b #$2c, d0
0319e0: 0000012e             ori.b #$2e, d0
0319e4: 00000180             ori.b #$80, d0
0319e8: 00000182             ori.b #$82, d0
0319ec: 00000184             ori.b #$84, d0
0319f0: 00000186             ori.b #$86, d0
0319f4: 00000188             ori.b #$88, d0
0319f8: 0000018a             ori.b #$8a, d0
0319fc: 0000018c             ori.b #$8c, d0
031a00: 0000018e             ori.b #$8e, d0
031a04: 00000190             ori.b #$90, d0
031a08: 00000192             ori.b #$92, d0
031a0c: dc.w 0e00
031a0e: 0194                 bclr.b d0, (a4)
031a10: 0a000196             eori.b #$96, d0
031a14: 03330198             btst.l d1, (d0.w)
031a18: 0000019a             ori.b #$9a, d0
031a1c: 0000019c             ori.b #$9c, d0
031a20: 0000019e             ori.b #$9e, d0
031a24: 000001a0             ori.b #$a0, d0
031a28: 000001a2             ori.b #$a2, d0
031a2c: dc.w 0eca
031a2e: 01a4                 bclr.b d0, -(a4)
031a30: dc.w 00dd
031a32: 01a6                 bclr.b d0, -(a6)
031a34: 070f01a8             movep.w $1a8(a7), d3
031a38: 0fe0                 bset.b d7, -(a0)
031a3a: 01aa0e00             bclr.b d0, $e00(a2)
031a3e: 01ac0a00             bclr.b d0, $a00(a4)
031a42: 01ae0333             bclr.b d0, $333(a6)
031a46: 01b00000             bclr.b d0, (a0, d0.w)
031a4a: 01b20e00             bclr.b d0, (a2, d0.l * 8)
031a4e: 01b40a00             bclr.b d0, (a4, d0.l * 2)
031a52: 01b6033301b8000001ba0000 bclr.b d0, ([$1b80000, a6, d0.w * 2], $1ba0000)
031a5e: dc.w 01bc
031a60: dc.w 0bbb
031a62: dc.w 01be
031a64: 06660084             addi.w #$84, -(a6)
031a68: 00050086             ori.b #$86, d5
031a6c: e000                 asr.b #$8, d0
031a6e: dc.w 008a
031a70: 0000ffff             ori.b #$ff, d0
031a74: dc.w fffe
031a76: 00968020008e         ori.l #$8020008e, (a6)
031a7c: 2c81                 move.l d1, (a6)
031a7e: 00902cc10092         ori.l #$2cc10092, (a0)
031a84: 0038009400d0         ori.b #$94, $d0.w
031a8a: dc.w 00e4
031a8c: 000600e6             ori.b #$e6, d6
031a90: 000000ec             ori.b #$ec, d0
031a94: 000600ee             ori.b #$ee, d6
031a98: 002800e00007         ori.b #$e0, $7(a0)
031a9e: dc.w 00e2
031aa0: 000000e8             ori.b #$e8, d0
031aa4: 000700ea             ori.b #$ea, d7
031aa8: 002800f00007         ori.b #$f0, $7(a0)
031aae: dc.w 00f2
031ab0: 00500100             ori.w #$100, (a0)
031ab4: 5600                 addq.b #$3, d0
031ab6: 01080050             movep.w $50(a0), d0
031aba: 010a0028             movep.w $28(a2), d0
031abe: 0104                 btst.l d0, d4
031ac0: 00440122             ori.w #$122, d4
031ac4: 00000120             ori.b #$20, d0
031ac8: 00000126             ori.b #$26, d0
031acc: 00000124             ori.b #$24, d0
031ad0: 00000132             ori.b #$32, d0
031ad4: 00000130             ori.b #$30, d0
031ad8: 00000136             ori.b #$36, d0
031adc: 00000134             ori.b #$34, d0
031ae0: 00000128             ori.b #$28, d0
031ae4: 0000012a             ori.b #$2a, d0
031ae8: 0000012c             ori.b #$2c, d0
031aec: 0000012e             ori.b #$2e, d0
031af0: 00000138             ori.b #$38, d0
031af4: 0000013a             ori.b #$3a, d0
031af8: 0000013c             ori.b #$3c, d0
031afc: 0000013e             ori.b #$3e, d0
031b00: 00000180             ori.b #$80, d0
031b04: 00000180             ori.b #$80, d0
031b08: 00000182             ori.b #$82, d0
031b0c: 00000184             ori.b #$84, d0
031b10: 00000186             ori.b #$86, d0
031b14: 00000188             ori.b #$88, d0
031b18: 0000018a             ori.b #$8a, d0
031b1c: 0000018c             ori.b #$8c, d0
031b20: 0000018e             ori.b #$8e, d0
031b24: 00000190             ori.b #$90, d0
031b28: 00000192             ori.b #$92, d0
031b2c: dc.w 0e00
031b2e: 0194                 bclr.b d0, (a4)
031b30: 0f80                 bclr.b d7, d0
031b32: 0196                 bclr.b d0, (a6)
031b34: 0ff00198             bset.b d7, (d0.w)
031b38: 0000019a             ori.b #$9a, d0
031b3c: 0000019c             ori.b #$9c, d0
031b40: 0000019e             ori.b #$9e, d0
031b44: 000001a0             ori.b #$a0, d0
031b48: 000001a2             ori.b #$a2, d0
031b4c: dc.w 0eca
031b4e: 01a4                 bclr.b d0, -(a4)
031b50: dc.w 00dd
031b52: 01a6                 bclr.b d0, -(a6)
031b54: 070f01a8             movep.w $1a8(a7), d3
031b58: 0fe0                 bset.b d7, -(a0)
031b5a: 01aa0e00             bclr.b d0, $e00(a2)
031b5e: 01ac0a00             bclr.b d0, $a00(a4)
031b62: 01ae0333             bclr.b d0, $333(a6)
031b66: 01b00000             bclr.b d0, (a0, d0.w)
031b6a: 01b20e00             bclr.b d0, (a2, d0.l * 8)
031b6e: 01b40f80             bclr.b d0, (d0.l * 8)
031b72: 01b60ff001b80000     bclr.b d0, $1b80000(invalid.w)
031b7a: dc.w 01ba
031b7c: 000001bc             ori.b #$bc, d0
031b80: 000001be             ori.b #$be, d0
031b84: 0000009c             ori.b #$9c, d0
031b88: 8010                 or.b (a0), d0
031b8a: dc.w ffdf
031b8c: dc.w fffe
031b8e: 0c01fffe             cmpi.b #$fe, d1
031b92: 0100                 btst.l d0, d0
031b94: 0000008e             ori.b #$8e, d0
031b98: 0d81                 bclr.b d6, d1
031b9a: 009032c10092         ori.l #$32c10092, (a0)
031ba0: 0038009400d0         ori.b #$94, $d0.w
031ba6: dc.w 00e0
031ba8: 000500e2             ori.b #$e2, d5
031bac: 7800                 moveq #$0, d4
031bae: dc.w 00e4
031bb0: 000500e6             ori.b #$e6, d5
031bb4: dc.w 7dc8
031bb6: dc.w 00e8
031bb8: 000500ea             ori.b #$ea, d5
031bbc: 8390                 or.l d1, (a0)
031bbe: 01080000             movep.w $0(a0), d0
031bc2: 010a0000             movep.w $0(a2), d0
031bc6: 0182                 bclr.b d0, d2
031bc8: 0f00                 btst.l d7, d0
031bca: 0184                 bclr.b d0, d4
031bcc: 0ddd                 bset.b d6, (a5)+
031bce: 0186                 bclr.b d0, d6
031bd0: 0aaa01880888018a     eori.l #$1880888, $18a(a2)
031bd8: 0666018c             addi.w #$18c, -(a6)
031bdc: 0444018e             subi.w #$18e, d4
031be0: 03330d01             btst.l d1, ([a3, d0.l * 4])
031be4: dc.w fffe
031be6: 0100                 btst.l d0, d0
031be8: 3200                 move.w d0, d1
031bea: 3201                 move.w d1, d1
031bec: dc.w fffe
031bee: 0100                 btst.l d0, d0
031bf0: 0000ffff             ori.b #$ff, d0
031bf4: dc.w fffe
031bf6: dc.w ffff
031bf8: dc.w fffe
031bfa: 00960020008e         ori.l #$20008e, (a6)
031c00: 9081                 sub.l d1, d0
031c02: 009097c10092         ori.l #$97c10092, (a0)
031c08: 0038009400d0         ori.b #$94, $d0.w
031c0e: 01080000             movep.w $0(a0), d0
031c12: 0180                 bclr.b d0, d0
031c14: 00000182             ori.b #$82, d0
031c18: 0f00                 btst.l d7, d0
031c1a: dc.w 00e2
031c1c: 000000e0             ori.b #$e0, d0
031c20: 00000100             ori.b #$0, d0
031c24: 1200                 move.b d0, d1
031c26: 9001                 sub.b d1, d0
031c28: dc.w fffe
031c2a: 0182                 bclr.b d0, d2
031c2c: 0a809101fffe         eori.l #$9101fffe, d0
031c32: 0182                 bclr.b d0, d2
031c34: 0da0                 bclr.b d6, -(a0)
031c36: 9201                 sub.b d1, d1
031c38: dc.w fffe
031c3a: 0182                 bclr.b d0, d2
031c3c: 0fd0                 bset.b d7, (a0)
031c3e: 9301                 subx.b d1, d1
031c40: dc.w fffe
031c42: 0182                 bclr.b d0, d2
031c44: 0ff09401             bset.b d7, $1(a0, a1.w)
031c48: dc.w fffe
031c4a: 0182                 bclr.b d0, d2
031c4c: 0fd0                 bset.b d7, (a0)
031c4e: 9501                 subx.b d1, d2
031c50: dc.w fffe
031c52: 0182                 bclr.b d0, d2
031c54: 0da0                 bclr.b d6, -(a0)
031c56: 9601                 sub.b d1, d3
031c58: dc.w fffe
031c5a: 0182                 bclr.b d0, d2
031c5c: 0a80009c8010         eori.l #$9c8010, d0
031c62: dc.w ffff
031c64: dc.w fffe
031c66: 00960020008e         ori.l #$20008e, (a6)
031c6c: 9081                 sub.l d1, d0
031c6e: 009097c10092         ori.l #$97c10092, (a0)
031c74: 0038009400d0         ori.b #$94, $d0.w
031c7a: 01080000             movep.w $0(a0), d0
031c7e: 0180                 bclr.b d0, d0
031c80: 00000182             ori.b #$82, d0
031c84: 0f00                 btst.l d7, d0
031c86: dc.w 00e2
031c88: 000000e0             ori.b #$e0, d0
031c8c: 00070100             ori.b #$0, d7
031c90: 1200                 move.b d0, d1
031c92: 9001                 sub.b d1, d0
031c94: dc.w fffe
031c96: 0182                 bclr.b d0, d2
031c98: 0a809101fffe         eori.l #$9101fffe, d0
031c9e: 0182                 bclr.b d0, d2
031ca0: 0da0                 bclr.b d6, -(a0)
031ca2: 9201                 sub.b d1, d1
031ca4: dc.w fffe
031ca6: 0182                 bclr.b d0, d2
031ca8: 0fd0                 bset.b d7, (a0)
031caa: 9301                 subx.b d1, d1
031cac: dc.w fffe
031cae: 0182                 bclr.b d0, d2
031cb0: 0ff09401             bset.b d7, $1(a0, a1.w)
031cb4: dc.w fffe
031cb6: 0182                 bclr.b d0, d2
031cb8: 0fd0                 bset.b d7, (a0)
031cba: 9501                 subx.b d1, d2
031cbc: dc.w fffe
031cbe: 0182                 bclr.b d0, d2
031cc0: 0da0                 bclr.b d6, -(a0)
031cc2: 9601                 sub.b d1, d3
031cc4: dc.w fffe
031cc6: 0182                 bclr.b d0, d2
031cc8: 0a80009c8010         eori.l #$9c8010, d0
031cce: dc.w ffff
031cd0: dc.w fffe
031cd2: 0100                 btst.l d0, d0
031cd4: 0200008e             andi.b #$8e, d0
031cd8: 0d81                 bclr.b d6, d1
031cda: 009032c10092         ori.l #$32c10092, (a0)
031ce0: 0038009400d0         ori.b #$94, $d0.w
031ce6: dc.w 00e0
031ce8: 000500e2             ori.b #$e2, d5
031cec: 7800                 moveq #$0, d4
031cee: dc.w 00e4
031cf0: 000500e6             ori.b #$e6, d5
031cf4: dc.w 7dc8
031cf6: dc.w 00e8
031cf8: 000500ea             ori.b #$ea, d5
031cfc: 8390                 or.l d1, (a0)
031cfe: 01080000             movep.w $0(a0), d0
031d02: 010a0000             movep.w $0(a2), d0
031d06: 0182                 bclr.b d0, d2
031d08: dc.w 00c0
031d0a: 0184                 bclr.b d0, d4
031d0c: 0ddd                 bset.b d6, (a5)+
031d0e: 0186                 bclr.b d0, d6
031d10: 0aaa01880888018a     eori.l #$1880888, $18a(a2)
031d18: 0666018c             addi.w #$18c, -(a6)
031d1c: 0444018e             subi.w #$18e, d4
031d20: 03330d01             btst.l d1, ([a3, d0.l * 4])
031d24: dc.w fffe
031d26: 0100                 btst.l d0, d0
031d28: 3200                 move.w d0, d1
031d2a: 1c01                 move.b d1, d6
031d2c: dc.w fffe
031d2e: 0182                 bclr.b d0, d2
031d30: dc.w 000f
031d32: 1d01                 move.b d1, -(a6)
031d34: dc.w fffe
031d36: 0182                 bclr.b d0, d2
031d38: dc.w 00f0
031d3a: 1e01                 move.b d1, d7
031d3c: dc.w fffe
031d3e: 0182                 bclr.b d0, d2
031d40: 0f00                 btst.l d7, d0
031d42: 1f01                 move.b d1, -(a7)
031d44: dc.w fffe
031d46: 0182                 bclr.b d0, d2
031d48: dc.w 000f
031d4a: 2001                 move.l d1, d0
031d4c: dc.w fffe
031d4e: 0182                 bclr.b d0, d2
031d50: 0f00                 btst.l d7, d0
031d52: 2101                 move.l d1, -(a0)
031d54: dc.w fffe
031d56: 0182                 bclr.b d0, d2
031d58: dc.w 00f0
031d5a: 2201                 move.l d1, d1
031d5c: dc.w fffe
031d5e: 0182                 bclr.b d0, d2
031d60: dc.w 000f
031d62: 3201                 move.w d1, d1
031d64: dc.w fffe
031d66: 0100                 btst.l d0, d0
031d68: 0000ffff             ori.b #$ff, d0
031d6c: dc.w fffe
031d6e: dc.w 008e
031d70: 2c81                 move.l d1, (a6)
031d72: 0090f4c10092         ori.l #$f4c10092, (a0)
031d78: 0038009400d0         ori.b #$94, $d0.w
031d7e: dc.w 00e0
031d80: 000300e2             ori.b #$e2, d3
031d84: 8000                 or.b d0, d0
031d86: dc.w 00e4
031d88: 000300e6             ori.b #$e6, d3
031d8c: 9f40                 subx.w d0, d7
031d8e: dc.w 00e8
031d90: 000300ea             ori.b #$ea, d3
031d94: be80                 cmp.l d0, d7
031d96: dc.w 00ec
031d98: 000300ee             ori.b #$ee, d3
031d9c: ddc0                 adda.l d0, a6
031d9e: 01080000             movep.w $0(a0), d0
031da2: 010a0000             movep.w $0(a2), d0
031da6: 0100                 btst.l d0, d0
031da8: 4200                 clr.b d0
031daa: 0180                 bclr.b d0, d0
031dac: 00000182             ori.b #$82, d0
031db0: dc.w 0fff
031db2: 0184                 bclr.b d0, d4
031db4: 0fc90186             movep.l d7, $186(a1)
031db8: 0fa5                 bclr.b d7, -(a5)
031dba: 01880d81             movep.w d0, $d81(a0)
031dbe: 018a0b60             movep.w d0, $b60(a2)
031dc2: 018c0940             movep.w d0, $940(a4)
031dc6: 018e0720             movep.w d0, $720(a6)
031dca: 0190                 bclr.b d0, (a0)
031dcc: dc.w 0e0a
031dce: 0192                 bclr.b d0, (a2)
031dd0: 0fe0                 bset.b d7, -(a0)
031dd2: 0194                 bclr.b d0, (a4)
031dd4: dc.w 0e00
031dd6: 0196                 bclr.b d0, (a6)
031dd8: 058c0198             movep.w d2, $198(a4)
031ddc: dc.w 040a
031dde: 019a                 bclr.b d0, (a2)+
031de0: 075c                 bchg.b d3, (a4)+
031de2: 019c                 bclr.b d0, (a4)+
031de4: dc.w 040a
031de6: 019e                 bclr.b d0, (a6)+
031de8: dc.w 00e0
031dea: 0120                 btst.l d0, -(a0)
031dec: 00000122             ori.b #$22, d0
031df0: 00000124             ori.b #$24, d0
031df4: 00000126             ori.b #$26, d0
031df8: 00000128             ori.b #$28, d0
031dfc: 0000012a             ori.b #$2a, d0
031e00: 0000012c             ori.b #$2c, d0
031e04: 0000012e             ori.b #$2e, d0
031e08: 00000130             ori.b #$30, d0
031e0c: 00000132             ori.b #$32, d0
031e10: 00000134             ori.b #$34, d0
031e14: 00000136             ori.b #$36, d0
031e18: 00000138             ori.b #$38, d0
031e1c: 0000013a             ori.b #$3a, d0
031e20: 0000013c             ori.b #$3c, d0
031e24: 0000013e             ori.b #$3e, d0
031e28: 0000009c             ori.b #$9c, d0
031e2c: 8010                 or.b (a0), d0
031e2e: 2e01                 move.l d1, d7
031e30: dc.w fffe
031e32: 019c                 bclr.b d0, (a4)+
031e34: 00002f01             ori.b #$1, d0
031e38: dc.w fffe
031e3a: 019c                 bclr.b d0, (a4)+
031e3c: 00003001             ori.b #$1, d0
031e40: dc.w fffe
031e42: 019c                 bclr.b d0, (a4)+
031e44: 00003101             ori.b #$1, d0
031e48: dc.w fffe
031e4a: 019c                 bclr.b d0, (a4)+
031e4c: 00003201             ori.b #$1, d0
031e50: dc.w fffe
031e52: 019c                 bclr.b d0, (a4)+
031e54: 00003301             ori.b #$1, d0
031e58: dc.w fffe
031e5a: 019c                 bclr.b d0, (a4)+
031e5c: 00003401             ori.b #$1, d0
031e60: dc.w fffe
031e62: 019c                 bclr.b d0, (a4)+
031e64: 00003501             ori.b #$1, d0
031e68: dc.w fffe
031e6a: 019c                 bclr.b d0, (a4)+
031e6c: 00003601             ori.b #$1, d0
031e70: dc.w fffe
031e72: 019c                 bclr.b d0, (a4)+
031e74: 00003701             ori.b #$1, d0
031e78: dc.w fffe
031e7a: 019c                 bclr.b d0, (a4)+
031e7c: 00003801             ori.b #$1, d0
031e80: dc.w fffe
031e82: 019c                 bclr.b d0, (a4)+
031e84: 00003901             ori.b #$1, d0
031e88: dc.w fffe
031e8a: 019c                 bclr.b d0, (a4)+
031e8c: 00003a01             ori.b #$1, d0
031e90: dc.w fffe
031e92: 019c                 bclr.b d0, (a4)+
031e94: 00003b01             ori.b #$1, d0
031e98: dc.w fffe
031e9a: 019c                 bclr.b d0, (a4)+
031e9c: 00003c01             ori.b #$1, d0
031ea0: dc.w fffe
031ea2: 019c                 bclr.b d0, (a4)+
031ea4: 00003d01             ori.b #$1, d0
031ea8: dc.w fffe
031eaa: 019c                 bclr.b d0, (a4)+
031eac: 00003e01             ori.b #$1, d0
031eb0: dc.w fffe
031eb2: 019c                 bclr.b d0, (a4)+
031eb4: 00003f01             ori.b #$1, d0
031eb8: dc.w fffe
031eba: 019c                 bclr.b d0, (a4)+
031ebc: 00004001             ori.b #$1, d0
031ec0: dc.w fffe
031ec2: 019c                 bclr.b d0, (a4)+
031ec4: 00004101             ori.b #$1, d0
031ec8: dc.w fffe
031eca: 019c                 bclr.b d0, (a4)+
031ecc: 00004201             ori.b #$1, d0
031ed0: dc.w fffe
031ed2: 019c                 bclr.b d0, (a4)+
031ed4: 00004301             ori.b #$1, d0
031ed8: dc.w fffe
031eda: 019c                 bclr.b d0, (a4)+
031edc: 00004401             ori.b #$1, d0
031ee0: dc.w fffe
031ee2: 019c                 bclr.b d0, (a4)+
031ee4: 00004501             ori.b #$1, d0
031ee8: dc.w fffe
031eea: 019c                 bclr.b d0, (a4)+
031eec: 00004601             ori.b #$1, d0
031ef0: dc.w fffe
031ef2: 019c                 bclr.b d0, (a4)+
031ef4: 00004701             ori.b #$1, d0
031ef8: dc.w fffe
031efa: 019c                 bclr.b d0, (a4)+
031efc: 00004801             ori.b #$1, d0
031f00: dc.w fffe
031f02: 019c                 bclr.b d0, (a4)+
031f04: 00004901             ori.b #$1, d0
031f08: dc.w fffe
031f0a: 019c                 bclr.b d0, (a4)+
031f0c: 00004a01             ori.b #$1, d0
031f10: dc.w fffe
031f12: 019c                 bclr.b d0, (a4)+
031f14: 00004b01             ori.b #$1, d0
031f18: dc.w fffe
031f1a: 019c                 bclr.b d0, (a4)+
031f1c: 00004c01             ori.b #$1, d0
031f20: dc.w fffe
031f22: 019c                 bclr.b d0, (a4)+
031f24: 00004d01             ori.b #$1, d0
031f28: dc.w fffe
031f2a: 019c                 bclr.b d0, (a4)+
031f2c: 00004e01             ori.b #$1, d0
031f30: dc.w fffe
031f32: 019c                 bclr.b d0, (a4)+
031f34: 00004f01             ori.b #$1, d0
031f38: dc.w fffe
031f3a: 019c                 bclr.b d0, (a4)+
031f3c: 00005001             ori.b #$1, d0
031f40: dc.w fffe
031f42: 019c                 bclr.b d0, (a4)+
031f44: 00005101             ori.b #$1, d0
031f48: dc.w fffe
031f4a: 019c                 bclr.b d0, (a4)+
031f4c: 00005201             ori.b #$1, d0
031f50: dc.w fffe
031f52: 019c                 bclr.b d0, (a4)+
031f54: 00005301             ori.b #$1, d0
031f58: dc.w fffe
031f5a: 019c                 bclr.b d0, (a4)+
031f5c: 00005401             ori.b #$1, d0
031f60: dc.w fffe
031f62: 019c                 bclr.b d0, (a4)+
031f64: 00005501             ori.b #$1, d0
031f68: dc.w fffe
031f6a: 019c                 bclr.b d0, (a4)+
031f6c: 00005601             ori.b #$1, d0
031f70: dc.w fffe
031f72: 019c                 bclr.b d0, (a4)+
031f74: 00005701             ori.b #$1, d0
031f78: dc.w fffe
031f7a: 019c                 bclr.b d0, (a4)+
031f7c: 00005801             ori.b #$1, d0
031f80: dc.w fffe
031f82: 019c                 bclr.b d0, (a4)+
031f84: 00005901             ori.b #$1, d0
031f88: dc.w fffe
031f8a: 019c                 bclr.b d0, (a4)+
031f8c: 00005a01             ori.b #$1, d0
031f90: dc.w fffe
031f92: 019c                 bclr.b d0, (a4)+
031f94: 00005b01             ori.b #$1, d0
031f98: dc.w fffe
031f9a: 019c                 bclr.b d0, (a4)+
031f9c: 00005c01             ori.b #$1, d0
031fa0: dc.w fffe
031fa2: 019c                 bclr.b d0, (a4)+
031fa4: 00005d01             ori.b #$1, d0
031fa8: dc.w fffe
031faa: 019c                 bclr.b d0, (a4)+
031fac: 00005e01             ori.b #$1, d0
031fb0: dc.w fffe
031fb2: 019c                 bclr.b d0, (a4)+
031fb4: 00005f01             ori.b #$1, d0
031fb8: dc.w fffe
031fba: 019c                 bclr.b d0, (a4)+
031fbc: 00006001             ori.b #$1, d0
031fc0: dc.w fffe
031fc2: 019c                 bclr.b d0, (a4)+
031fc4: 00006101             ori.b #$1, d0
031fc8: dc.w fffe
031fca: 019c                 bclr.b d0, (a4)+
031fcc: 00006201             ori.b #$1, d0
031fd0: dc.w fffe
031fd2: 019c                 bclr.b d0, (a4)+
031fd4: 00006301             ori.b #$1, d0
031fd8: dc.w fffe
031fda: 019c                 bclr.b d0, (a4)+
031fdc: 00006401             ori.b #$1, d0
031fe0: dc.w fffe
031fe2: 019c                 bclr.b d0, (a4)+
031fe4: 00006501             ori.b #$1, d0
031fe8: dc.w fffe
031fea: 019c                 bclr.b d0, (a4)+
031fec: 00006601             ori.b #$1, d0
031ff0: dc.w fffe
031ff2: 019c                 bclr.b d0, (a4)+
031ff4: 00006701             ori.b #$1, d0
031ff8: dc.w fffe
031ffa: 019c                 bclr.b d0, (a4)+
031ffc: 00006801             ori.b #$1, d0
032000: dc.w fffe
032002: 019c                 bclr.b d0, (a4)+
032004: 00006901             ori.b #$1, d0
032008: dc.w fffe
03200a: 019c                 bclr.b d0, (a4)+
03200c: 00006a01             ori.b #$1, d0
032010: dc.w fffe
032012: 019c                 bclr.b d0, (a4)+
032014: 00006b01             ori.b #$1, d0
032018: dc.w fffe
03201a: 019c                 bclr.b d0, (a4)+
03201c: 00006c01             ori.b #$1, d0
032020: dc.w fffe
032022: 019c                 bclr.b d0, (a4)+
032024: 00006d01             ori.b #$1, d0
032028: dc.w fffe
03202a: 019c                 bclr.b d0, (a4)+
03202c: 00006e01             ori.b #$1, d0
032030: dc.w fffe
032032: 019c                 bclr.b d0, (a4)+
032034: 00006f01             ori.b #$1, d0
032038: dc.w fffe
03203a: 019c                 bclr.b d0, (a4)+
03203c: 00007001             ori.b #$1, d0
032040: dc.w fffe
032042: 019c                 bclr.b d0, (a4)+
032044: 00007101             ori.b #$1, d0
032048: dc.w fffe
03204a: 019c                 bclr.b d0, (a4)+
03204c: 00007201             ori.b #$1, d0
032050: dc.w fffe
032052: 019c                 bclr.b d0, (a4)+
032054: 00007301             ori.b #$1, d0
032058: dc.w fffe
03205a: 019c                 bclr.b d0, (a4)+
03205c: 00007401             ori.b #$1, d0
032060: dc.w fffe
032062: 019c                 bclr.b d0, (a4)+
032064: 00007501             ori.b #$1, d0
032068: dc.w fffe
03206a: 019c                 bclr.b d0, (a4)+
03206c: 00007601             ori.b #$1, d0
032070: dc.w fffe
032072: 019c                 bclr.b d0, (a4)+
032074: 00007701             ori.b #$1, d0
032078: dc.w fffe
03207a: 019c                 bclr.b d0, (a4)+
03207c: 00007801             ori.b #$1, d0
032080: dc.w fffe
032082: 019c                 bclr.b d0, (a4)+
032084: 00007901             ori.b #$1, d0
032088: dc.w fffe
03208a: 019c                 bclr.b d0, (a4)+
03208c: 00007a01             ori.b #$1, d0
032090: dc.w fffe
032092: 019c                 bclr.b d0, (a4)+
032094: 00007b01             ori.b #$1, d0
032098: dc.w fffe
03209a: 019c                 bclr.b d0, (a4)+
03209c: 00007c01             ori.b #$1, d0
0320a0: dc.w fffe
0320a2: 019c                 bclr.b d0, (a4)+
0320a4: 00007d01             ori.b #$1, d0
0320a8: dc.w fffe
0320aa: 019c                 bclr.b d0, (a4)+
0320ac: 00007e01             ori.b #$1, d0
0320b0: dc.w fffe
0320b2: 019c                 bclr.b d0, (a4)+
0320b4: 00007f01             ori.b #$1, d0
0320b8: dc.w fffe
0320ba: 019c                 bclr.b d0, (a4)+
0320bc: 00008001             ori.b #$1, d0
0320c0: dc.w fffe
0320c2: 019c                 bclr.b d0, (a4)+
0320c4: 00008101             ori.b #$1, d0
0320c8: dc.w fffe
0320ca: 019c                 bclr.b d0, (a4)+
0320cc: 00008201             ori.b #$1, d0
0320d0: dc.w fffe
0320d2: 019c                 bclr.b d0, (a4)+
0320d4: 00008301             ori.b #$1, d0
0320d8: dc.w fffe
0320da: 019c                 bclr.b d0, (a4)+
0320dc: 00008401             ori.b #$1, d0
0320e0: dc.w fffe
0320e2: 019c                 bclr.b d0, (a4)+
0320e4: 00008501             ori.b #$1, d0
0320e8: dc.w fffe
0320ea: 019c                 bclr.b d0, (a4)+
0320ec: 00008601             ori.b #$1, d0
0320f0: dc.w fffe
0320f2: 019c                 bclr.b d0, (a4)+
0320f4: 00008701             ori.b #$1, d0
0320f8: dc.w fffe
0320fa: 019c                 bclr.b d0, (a4)+
0320fc: 00008801             ori.b #$1, d0
032100: dc.w fffe
032102: 019c                 bclr.b d0, (a4)+
032104: 00008901             ori.b #$1, d0
032108: dc.w fffe
03210a: 019c                 bclr.b d0, (a4)+
03210c: 00008a01             ori.b #$1, d0
032110: dc.w fffe
032112: 019c                 bclr.b d0, (a4)+
032114: 00008b01             ori.b #$1, d0
032118: dc.w fffe
03211a: 019c                 bclr.b d0, (a4)+
03211c: 00008c01             ori.b #$1, d0
032120: dc.w fffe
032122: 019c                 bclr.b d0, (a4)+
032124: 00008d01             ori.b #$1, d0
032128: dc.w fffe
03212a: 019c                 bclr.b d0, (a4)+
03212c: 00008e01             ori.b #$1, d0
032130: dc.w fffe
032132: 019c                 bclr.b d0, (a4)+
032134: 00008f01             ori.b #$1, d0
032138: dc.w fffe
03213a: 019c                 bclr.b d0, (a4)+
03213c: 00009001             ori.b #$1, d0
032140: dc.w fffe
032142: 019c                 bclr.b d0, (a4)+
032144: 00009101             ori.b #$1, d0
032148: dc.w fffe
03214a: 019c                 bclr.b d0, (a4)+
03214c: 00009201             ori.b #$1, d0
032150: dc.w fffe
032152: 019c                 bclr.b d0, (a4)+
032154: 00009301             ori.b #$1, d0
032158: dc.w fffe
03215a: 019c                 bclr.b d0, (a4)+
03215c: 00009401             ori.b #$1, d0
032160: dc.w fffe
032162: 019c                 bclr.b d0, (a4)+
032164: 00009501             ori.b #$1, d0
032168: dc.w fffe
03216a: 019c                 bclr.b d0, (a4)+
03216c: 00009601             ori.b #$1, d0
032170: dc.w fffe
032172: 019c                 bclr.b d0, (a4)+
032174: 00009701             ori.b #$1, d0
032178: dc.w fffe
03217a: 019c                 bclr.b d0, (a4)+
03217c: 00009801             ori.b #$1, d0
032180: dc.w fffe
032182: 019c                 bclr.b d0, (a4)+
032184: 00009901             ori.b #$1, d0
032188: dc.w fffe
03218a: 019c                 bclr.b d0, (a4)+
03218c: 00009a01             ori.b #$1, d0
032190: dc.w fffe
032192: 019c                 bclr.b d0, (a4)+
032194: 00009b01             ori.b #$1, d0
032198: dc.w fffe
03219a: 019c                 bclr.b d0, (a4)+
03219c: 00009c01             ori.b #$1, d0
0321a0: dc.w fffe
0321a2: 019c                 bclr.b d0, (a4)+
0321a4: 00009d01             ori.b #$1, d0
0321a8: dc.w fffe
0321aa: 019c                 bclr.b d0, (a4)+
0321ac: 00009e01             ori.b #$1, d0
0321b0: dc.w fffe
0321b2: 019c                 bclr.b d0, (a4)+
0321b4: 00009f01             ori.b #$1, d0
0321b8: dc.w fffe
0321ba: 019c                 bclr.b d0, (a4)+
0321bc: 0000a001             ori.b #$1, d0
0321c0: dc.w fffe
0321c2: 019c                 bclr.b d0, (a4)+
0321c4: 0000a101             ori.b #$1, d0
0321c8: dc.w fffe
0321ca: 019c                 bclr.b d0, (a4)+
0321cc: 0000a201             ori.b #$1, d0
0321d0: dc.w fffe
0321d2: 019c                 bclr.b d0, (a4)+
0321d4: 0000a301             ori.b #$1, d0
0321d8: dc.w fffe
0321da: 019c                 bclr.b d0, (a4)+
0321dc: 0000a401             ori.b #$1, d0
0321e0: dc.w fffe
0321e2: 019c                 bclr.b d0, (a4)+
0321e4: 0000a501             ori.b #$1, d0
0321e8: dc.w fffe
0321ea: 019c                 bclr.b d0, (a4)+
0321ec: 0000a601             ori.b #$1, d0
0321f0: dc.w fffe
0321f2: 019c                 bclr.b d0, (a4)+
0321f4: 0000a701             ori.b #$1, d0
0321f8: dc.w fffe
0321fa: 019c                 bclr.b d0, (a4)+
0321fc: 0000a801             ori.b #$1, d0
032200: dc.w fffe
032202: 019c                 bclr.b d0, (a4)+
032204: 0000a901             ori.b #$1, d0
032208: dc.w fffe
03220a: 019c                 bclr.b d0, (a4)+
03220c: 0000aa01             ori.b #$1, d0
032210: dc.w fffe
032212: 019c                 bclr.b d0, (a4)+
032214: 0000ab01             ori.b #$1, d0
032218: dc.w fffe
03221a: 019c                 bclr.b d0, (a4)+
03221c: 0000ac01             ori.b #$1, d0
032220: dc.w fffe
032222: 019c                 bclr.b d0, (a4)+
032224: 0000ad01             ori.b #$1, d0
032228: dc.w fffe
03222a: 019c                 bclr.b d0, (a4)+
03222c: 0000ae01             ori.b #$1, d0
032230: dc.w fffe
032232: 019c                 bclr.b d0, (a4)+
032234: 0000af01             ori.b #$1, d0
032238: dc.w fffe
03223a: 019c                 bclr.b d0, (a4)+
03223c: 0000b001             ori.b #$1, d0
032240: dc.w fffe
032242: 019c                 bclr.b d0, (a4)+
032244: 0000b101             ori.b #$1, d0
032248: dc.w fffe
03224a: 019c                 bclr.b d0, (a4)+
03224c: 0000b201             ori.b #$1, d0
032250: dc.w fffe
032252: 019c                 bclr.b d0, (a4)+
032254: 0000b301             ori.b #$1, d0
032258: dc.w fffe
03225a: 019c                 bclr.b d0, (a4)+
03225c: 0000b401             ori.b #$1, d0
032260: dc.w fffe
032262: 019c                 bclr.b d0, (a4)+
032264: 0000b501             ori.b #$1, d0
032268: dc.w fffe
03226a: 019c                 bclr.b d0, (a4)+
03226c: 0000b601             ori.b #$1, d0
032270: dc.w fffe
032272: 019c                 bclr.b d0, (a4)+
032274: 0000b701             ori.b #$1, d0
032278: dc.w fffe
03227a: 019c                 bclr.b d0, (a4)+
03227c: 0000b801             ori.b #$1, d0
032280: dc.w fffe
032282: 019c                 bclr.b d0, (a4)+
032284: 0000b901             ori.b #$1, d0
032288: dc.w fffe
03228a: 019c                 bclr.b d0, (a4)+
03228c: 0000ba01             ori.b #$1, d0
032290: dc.w fffe
032292: 019c                 bclr.b d0, (a4)+
032294: 0000bb01             ori.b #$1, d0
032298: dc.w fffe
03229a: 019c                 bclr.b d0, (a4)+
03229c: 0000bc01             ori.b #$1, d0
0322a0: dc.w fffe
0322a2: 019c                 bclr.b d0, (a4)+
0322a4: 0000bd01             ori.b #$1, d0
0322a8: dc.w fffe
0322aa: 019c                 bclr.b d0, (a4)+
0322ac: 0000be01             ori.b #$1, d0
0322b0: dc.w fffe
0322b2: 019c                 bclr.b d0, (a4)+
0322b4: 0000bf01             ori.b #$1, d0
0322b8: dc.w fffe
0322ba: 019c                 bclr.b d0, (a4)+
0322bc: 0000c001             ori.b #$1, d0
0322c0: dc.w fffe
0322c2: 019c                 bclr.b d0, (a4)+
0322c4: 0000c101             ori.b #$1, d0
0322c8: dc.w fffe
0322ca: 019c                 bclr.b d0, (a4)+
0322cc: 0000c201             ori.b #$1, d0
0322d0: dc.w fffe
0322d2: 019c                 bclr.b d0, (a4)+
0322d4: 0000c301             ori.b #$1, d0
0322d8: dc.w fffe
0322da: 019c                 bclr.b d0, (a4)+
0322dc: 0000c401             ori.b #$1, d0
0322e0: dc.w fffe
0322e2: 019c                 bclr.b d0, (a4)+
0322e4: 0000c501             ori.b #$1, d0
0322e8: dc.w fffe
0322ea: 019c                 bclr.b d0, (a4)+
0322ec: 0000c601             ori.b #$1, d0
0322f0: dc.w fffe
0322f2: 019c                 bclr.b d0, (a4)+
0322f4: 0000c701             ori.b #$1, d0
0322f8: dc.w fffe
0322fa: 019c                 bclr.b d0, (a4)+
0322fc: 0000c801             ori.b #$1, d0
032300: dc.w fffe
032302: 019c                 bclr.b d0, (a4)+
032304: 0000c901             ori.b #$1, d0
032308: dc.w fffe
03230a: 019c                 bclr.b d0, (a4)+
03230c: 0000ca01             ori.b #$1, d0
032310: dc.w fffe
032312: 019c                 bclr.b d0, (a4)+
032314: 0000cb01             ori.b #$1, d0
032318: dc.w fffe
03231a: 019c                 bclr.b d0, (a4)+
03231c: 0000cc01             ori.b #$1, d0
032320: dc.w fffe
032322: 019c                 bclr.b d0, (a4)+
032324: 0000cd01             ori.b #$1, d0
032328: dc.w fffe
03232a: 019c                 bclr.b d0, (a4)+
03232c: 0000ce01             ori.b #$1, d0
032330: dc.w fffe
032332: 019c                 bclr.b d0, (a4)+
032334: 0000cf01             ori.b #$1, d0
032338: dc.w fffe
03233a: 019c                 bclr.b d0, (a4)+
03233c: 0000d001             ori.b #$1, d0
032340: dc.w fffe
032342: 019c                 bclr.b d0, (a4)+
032344: 0000d101             ori.b #$1, d0
032348: dc.w fffe
03234a: 019c                 bclr.b d0, (a4)+
03234c: 0000d201             ori.b #$1, d0
032350: dc.w fffe
032352: 019c                 bclr.b d0, (a4)+
032354: 0000d301             ori.b #$1, d0
032358: dc.w fffe
03235a: 019c                 bclr.b d0, (a4)+
03235c: 0000d401             ori.b #$1, d0
032360: dc.w fffe
032362: 019c                 bclr.b d0, (a4)+
032364: 0000d501             ori.b #$1, d0
032368: dc.w fffe
03236a: 019c                 bclr.b d0, (a4)+
03236c: 0000d601             ori.b #$1, d0
032370: dc.w fffe
032372: 019c                 bclr.b d0, (a4)+
032374: 0000d701             ori.b #$1, d0
032378: dc.w fffe
03237a: 019c                 bclr.b d0, (a4)+
03237c: 0000d801             ori.b #$1, d0
032380: dc.w fffe
032382: 019c                 bclr.b d0, (a4)+
032384: 0000d901             ori.b #$1, d0
032388: dc.w fffe
03238a: 019c                 bclr.b d0, (a4)+
03238c: 0000da01             ori.b #$1, d0
032390: dc.w fffe
032392: 019c                 bclr.b d0, (a4)+
032394: 0000db01             ori.b #$1, d0
032398: dc.w fffe
03239a: 019c                 bclr.b d0, (a4)+
03239c: 0000dc01             ori.b #$1, d0
0323a0: dc.w fffe
0323a2: 019c                 bclr.b d0, (a4)+
0323a4: 0000dd01             ori.b #$1, d0
0323a8: dc.w fffe
0323aa: 019c                 bclr.b d0, (a4)+
0323ac: 0000de01             ori.b #$1, d0
0323b0: dc.w fffe
0323b2: 019c                 bclr.b d0, (a4)+
0323b4: 0000df01             ori.b #$1, d0
0323b8: dc.w fffe
0323ba: 019c                 bclr.b d0, (a4)+
0323bc: 0000e001             ori.b #$1, d0
0323c0: dc.w fffe
0323c2: 019c                 bclr.b d0, (a4)+
0323c4: 0000e101             ori.b #$1, d0
0323c8: dc.w fffe
0323ca: 019c                 bclr.b d0, (a4)+
0323cc: 0000ffff             ori.b #$ff, d0
0323d0: dc.w fffe
0323d2: dc.w 000f
0323d4: 001f002f             ori.b #$2f, (a7)+
0323d8: dc.w 003f
0323da: dc.w 004f
0323dc: 005f006f             ori.w #$6f, (a7)+
0323e0: dc.w 007f
0323e2: dc.w 008f
0323e4: 009e00ad00bc         ori.l #$ad00bc, (a6)+
0323ea: dc.w 00cb
0323ec: dc.w 00da
0323ee: dc.w 00e9
0323f0: dc.w 00f8
0323f2: dc.w 00f7
0323f4: dc.w 00f6
0323f6: dc.w 00f5
0323f8: dc.w 00f4
0323fa: dc.w 00f3
0323fc: dc.w 00f2
0323fe: dc.w 00f1
032400: dc.w 00f0
032402: dc.w 00f0
032404: 01f002f0             bset.b d0, -$10(a0, d0.w)
032408: 03f004f0             bset.b d1, -$10(a0, d0.w)
03240c: 05f006f0             bset.b d2, -$10(a0, d0.w)
032410: 07f008f0             bset.b d3, -$10(a0, d0.l)
032414: 09f00af0             bset.b d4, -$10(a0, d0.l)
032418: 0bf00cf0             bset.b d5, -$10(a0, d0.l)
03241c: 0df00ef0             bset.b d6, -$10(a0, d0.l)
032420: 0ff00ff00fe00fd0     bset.b d7, $fe00fd0(invalid.w)
032428: 0fc0                 bset.b d7, d0
03242a: 0fb00fa00f90         bclr.b d7, $f90(d0.l * 8)
032430: 0f80                 bclr.b d7, d0
032432: 0f700f600f50         bchg.b d7, $f50(a0, invalid.w)
032438: 0f40                 bchg.b d7, d0
03243a: 0f300f200f10         btst.l d7, $f10(a0, d0.l * 8)
032440: 0f00                 btst.l d7, d0
032442: 0f00                 btst.l d7, d0
032444: 0f01                 btst.l d7, d1
032446: 0f02                 btst.l d7, d2
032448: 0f03                 btst.l d7, d3
03244a: 0f04                 btst.l d7, d4
03244c: 0f05                 btst.l d7, d5
03244e: 0f06                 btst.l d7, d6
032450: 0f07                 btst.l d7, d7
032452: 0f080f09             movep.w $f09(a0), d7
032456: 0f0a0f0b             movep.w $f0b(a2), d7
03245a: 0f0c0f0d             movep.w $f0d(a4), d7
03245e: 0f0e0f0f             movep.w $f0f(a6), d7
032462: 0f0f0e0f             movep.w $e0f(a7), d7
032466: 0d0f0c0f             movep.w $c0f(a7), d6
03246a: 0b0f0a0f             movep.w $a0f(a7), d5
03246e: 090f080f             movep.w $80f(a7), d4
032472: 070f060f             movep.w $60f(a7), d3
032476: 050f040f             movep.w $40f(a7), d2
03247a: 030f020f             movep.w $20f(a7), d1
03247e: 010f000f             movep.w $f(a7), d0
032482: dc.w ffff
032484: 4064                 negx.w -(a4)
032486: 5000                 addq.b #$8, d0
032488: 000007e0             ori.b #$e0, d0
03248c: 07e0                 bset.b d3, -(a0)
03248e: 1818                 move.b (a0)+, d4
032490: dc.w 1ff8
032492: 2004                 move.l d4, d0
032494: dc.w 27e4
032496: 4002                 negx.b d2
032498: dc.w 3bdc
03249a: 4002                 negx.b d2
03249c: dc.w 7bde
03249e: 8001                 or.b d1, d0
0324a0: dc.w 7ffe
0324a2: 8001                 or.b d1, d0
0324a4: 63c6                 bls.b $3246c
0324a6: 9c395dbabe7d         sub.b $5dbabe7d.l, d6
0324ac: 2244                 movea.l d4, a1
0324ae: dc.w ffff
0324b0: 0000ffff             ori.b #$ff, d0
0324b4: 1c387ffe             move.b $7ffe.w, d6
0324b8: 3e7c7ffe             movea.w #$7ffe, a7
0324bc: 3e7c7ffe             movea.w #$7ffe, a7
0324c0: 1db83e7c0000         move.b $3e7c.w, (a6, d0.w)
0324c6: dc.w 1ff8
0324c8: 00000000             ori.b #$0, d0
0324cc: 4064                 negx.w -(a4)
0324ce: 5080                 addq.l #$8, d0
0324d0: 07e0                 bset.b d3, -(a0)
0324d2: 00001ff8             ori.b #$f8, d0
0324d6: 00003ffc             ori.b #$fc, d0
0324da: 00007ffe             ori.b #$fe, d0
0324de: 00007ffe             ori.b #$fe, d0
0324e2: 0000ffff             ori.b #$ff, d0
0324e6: 0000ffff             ori.b #$ff, d0
0324ea: 0000e3c7             ori.b #$c7, d0
0324ee: 0000c183             ori.b #$83, d0
0324f2: 00008001             ori.b #$1, d0
0324f6: 00008001             ori.b #$1, d0
0324fa: 00001c38             ori.b #$38, d0
0324fe: 00003e7c             ori.b #$7c, d0
032502: 00003e7c             ori.b #$7c, d0
032506: 00001db8             ori.b #$b8, d0
03250a: 000003c0             ori.b #$c0, d0
03250e: 00000000             ori.b #$0, d0
032512: 00004064             ori.b #$64, d0
032516: 5000                 addq.b #$8, d0
032518: 000007e0             ori.b #$e0, d0
03251c: 07e0                 bset.b d3, -(a0)
03251e: 1818                 move.b (a0)+, d4
032520: dc.w 1ff8
032522: 2004                 move.l d4, d0
032524: dc.w 3bdc
032526: 4002                 negx.b d2
032528: dc.w 3bdc
03252a: 4002                 negx.b d2
03252c: dc.w 7bde
03252e: 8001                 or.b d1, d0
032530: dc.w 7ffe
032532: 8001                 or.b d1, d0
032534: 63c6                 bls.b $324fc
032536: 9c395dbabe7d         sub.b $5dbabe7d.l, d6
03253c: 2244                 movea.l d4, a1
03253e: dc.w ffff
032540: 0000ffff             ori.b #$ff, d0
032544: dc.w 0810
032546: dc.w 7ffe
032548: 1c387ffe             move.b $7ffe.w, d6
03254c: 1c387ffe             move.b $7ffe.w, d6
032550: 0990                 bclr.b d4, (a0)
032552: 3e7c0000             movea.w #$0, a7
032556: dc.w 1ff8
032558: 00000000             ori.b #$0, d0
03255c: 4064                 negx.w -(a4)
03255e: 5080                 addq.l #$8, d0
032560: 07e0                 bset.b d3, -(a0)
032562: 00001ff8             ori.b #$f8, d0
032566: 00003ffc             ori.b #$fc, d0
03256a: 00007ffe             ori.b #$fe, d0
03256e: 00007ffe             ori.b #$fe, d0
032572: 0000ffff             ori.b #$ff, d0
032576: 0000ffff             ori.b #$ff, d0
03257a: 0000e3c7             ori.b #$c7, d0
03257e: 0000c183             ori.b #$83, d0
032582: 00008001             ori.b #$1, d0
032586: 00008001             ori.b #$1, d0
03258a: 00000810             ori.b #$10, d0
03258e: 00001c38             ori.b #$38, d0
032592: 00001c38             ori.b #$38, d0
032596: 00000990             ori.b #$90, d0
03259a: 000003c0             ori.b #$c0, d0
03259e: 00000000             ori.b #$0, d0
0325a2: 00004064             ori.b #$64, d0
0325a6: 5000                 addq.b #$8, d0
0325a8: 000007e0             ori.b #$e0, d0
0325ac: 07e0                 bset.b d3, -(a0)
0325ae: 1818                 move.b (a0)+, d4
0325b0: dc.w 1ff8
0325b2: 2004                 move.l d4, d0
0325b4: 3c3c4002             move.w #$4002, d6
0325b8: dc.w 3bdc
0325ba: 4002                 negx.b d2
0325bc: dc.w 7bde
0325be: 8001                 or.b d1, d0
0325c0: dc.w 7ffe
0325c2: 8001                 or.b d1, d0
0325c4: 63c6                 bls.b $3258c
0325c6: 9c395dbabe7d         sub.b $5dbabe7d.l, d6
0325cc: 2244                 movea.l d4, a1
0325ce: dc.w ffff
0325d0: 0000ffff             ori.b #$ff, d0
0325d4: dc.w 0810
0325d6: dc.w 7ffe
0325d8: 1c387ffe             move.b $7ffe.w, d6
0325dc: dc.w 0810
0325de: dc.w 7ffe
0325e0: 0180                 bclr.b d0, d0
0325e2: 3e7c0000             movea.w #$0, a7
0325e6: dc.w 1ff8
0325e8: 00000000             ori.b #$0, d0
0325ec: 4064                 negx.w -(a4)
0325ee: 5080                 addq.l #$8, d0
0325f0: 07e0                 bset.b d3, -(a0)
0325f2: 00001ff8             ori.b #$f8, d0
0325f6: 00003ffc             ori.b #$fc, d0
0325fa: 00007ffe             ori.b #$fe, d0
0325fe: 00007ffe             ori.b #$fe, d0
032602: 0000ffff             ori.b #$ff, d0
032606: 0000ffff             ori.b #$ff, d0
03260a: 0000e3c7             ori.b #$c7, d0
03260e: 0000c183             ori.b #$83, d0
032612: 00008001             ori.b #$1, d0
032616: 00008001             ori.b #$1, d0
03261a: 00000810             ori.b #$10, d0
03261e: 00001c38             ori.b #$38, d0
032622: 00000810             ori.b #$10, d0
032626: 00000180             ori.b #$80, d0
03262a: 000003c0             ori.b #$c0, d0
03262e: 00000000             ori.b #$0, d0
032632: 00000003             ori.b #$3, d0
032636: 2484                 move.l d4, (a2)
032638: 000324cc             ori.b #$cc, d3
03263c: 00032514             ori.b #$14, d3
032640: 0003255c             ori.b #$5c, d3
032644: 000325a4             ori.b #$a4, d3
032648: 000325ec             ori.b #$ec, d3
03264c: 00032514             ori.b #$14, d3
032650: 0003255c             ori.b #$5c, d3
032654: 00000000             ori.b #$0, d0
032658: 4064                 negx.w -(a4)
03265a: 5000                 addq.b #$8, d0
03265c: 00001ff8             ori.b #$f8, d0
032660: 1db83e7c3e7c         move.b $3e7c.w, $7c(a6, d3.l)
032666: dc.w 7ffe
032668: 3e7c7ffe             movea.w #$7ffe, a7
03266c: 1c387ffe             move.b $7ffe.w, d6
032670: 0000ffff             ori.b #$ff, d0
032674: 2244                 movea.l d4, a1
032676: dc.w ffff
032678: dc.w 5dba
03267a: dc.w be7d
03267c: 63c6                 bls.b $32644
03267e: 9c397ffe8001         sub.b $7ffe8001.l, d6
032684: dc.w 7bde
032686: 8001                 or.b d1, d0
032688: dc.w 3bdc
03268a: 4002                 negx.b d2
03268c: dc.w 27e4
03268e: 4002                 negx.b d2
032690: dc.w 1ff8
032692: 2004                 move.l d4, d0
032694: 07e0                 bset.b d3, -(a0)
032696: 1818                 move.b (a0)+, d4
032698: 000007e0             ori.b #$e0, d0
03269c: 00000000             ori.b #$0, d0
0326a0: 4064                 negx.w -(a4)
0326a2: 5080                 addq.l #$8, d0
0326a4: 03c0                 bset.b d1, d0
0326a6: 00001db8             ori.b #$b8, d0
0326aa: 00003e7c             ori.b #$7c, d0
0326ae: 00003e7c             ori.b #$7c, d0
0326b2: 00001c38             ori.b #$38, d0
0326b6: 00008001             ori.b #$1, d0
0326ba: 00008001             ori.b #$1, d0
0326be: 0000c183             ori.b #$83, d0
0326c2: 0000e3c7             ori.b #$c7, d0
0326c6: 0000ffff             ori.b #$ff, d0
0326ca: 0000ffff             ori.b #$ff, d0
0326ce: 00007ffe             ori.b #$fe, d0
0326d2: 00007ffe             ori.b #$fe, d0
0326d6: 00003ffc             ori.b #$fc, d0
0326da: 00001ff8             ori.b #$f8, d0
0326de: 000007e0             ori.b #$e0, d0
0326e2: 00000000             ori.b #$0, d0
0326e6: 00004064             ori.b #$64, d0
0326ea: 5000                 addq.b #$8, d0
0326ec: 00001ff8             ori.b #$f8, d0
0326f0: 0990                 bclr.b d4, (a0)
0326f2: 3e7c1c38             movea.w #$1c38, a7
0326f6: dc.w 7ffe
0326f8: 1c387ffe             move.b $7ffe.w, d6
0326fc: dc.w 0810
0326fe: dc.w 7ffe
032700: 0000ffff             ori.b #$ff, d0
032704: 2244                 movea.l d4, a1
032706: dc.w ffff
032708: dc.w 5dba
03270a: dc.w be7d
03270c: 63c6                 bls.b $326d4
03270e: 9c397ffe8001         sub.b $7ffe8001.l, d6
032714: dc.w 7bde
032716: 8001                 or.b d1, d0
032718: dc.w 3bdc
03271a: 4002                 negx.b d2
03271c: dc.w 3bdc
03271e: 4002                 negx.b d2
032720: dc.w 1ff8
032722: 2004                 move.l d4, d0
032724: 07e0                 bset.b d3, -(a0)
032726: 1818                 move.b (a0)+, d4
032728: 000007e0             ori.b #$e0, d0
03272c: 00000000             ori.b #$0, d0
032730: 4064                 negx.w -(a4)
032732: 5080                 addq.l #$8, d0
032734: 03c0                 bset.b d1, d0
032736: 00000990             ori.b #$90, d0
03273a: 00001c38             ori.b #$38, d0
03273e: 00001c38             ori.b #$38, d0
032742: 00000810             ori.b #$10, d0
032746: 00008001             ori.b #$1, d0
03274a: 00008001             ori.b #$1, d0
03274e: 0000c183             ori.b #$83, d0
032752: 0000e3c7             ori.b #$c7, d0
032756: 0000ffff             ori.b #$ff, d0
03275a: 0000ffff             ori.b #$ff, d0
03275e: 00007ffe             ori.b #$fe, d0
032762: 00007ffe             ori.b #$fe, d0
032766: 00003ffc             ori.b #$fc, d0
03276a: 00001ff8             ori.b #$f8, d0
03276e: 000007e0             ori.b #$e0, d0
032772: 00000000             ori.b #$0, d0
032776: 00004064             ori.b #$64, d0
03277a: 5000                 addq.b #$8, d0
03277c: 00001ff8             ori.b #$f8, d0
032780: 0180                 bclr.b d0, d0
032782: 3e7c0810             movea.w #$810, a7
032786: dc.w 7ffe
032788: 1c387ffe             move.b $7ffe.w, d6
03278c: dc.w 0810
03278e: dc.w 7ffe
032790: 0000ffff             ori.b #$ff, d0
032794: 2244                 movea.l d4, a1
032796: dc.w ffff
032798: dc.w 5dba
03279a: dc.w be7d
03279c: 63c6                 bls.b $32764
03279e: 9c397ffe8001         sub.b $7ffe8001.l, d6
0327a4: dc.w 7bde
0327a6: 8001                 or.b d1, d0
0327a8: dc.w 3bdc
0327aa: 4002                 negx.b d2
0327ac: 3c3c4002             move.w #$4002, d6
0327b0: dc.w 1ff8
0327b2: 2004                 move.l d4, d0
0327b4: 07e0                 bset.b d3, -(a0)
0327b6: 1818                 move.b (a0)+, d4
0327b8: 000007e0             ori.b #$e0, d0
0327bc: 00000000             ori.b #$0, d0
0327c0: 4064                 negx.w -(a4)
0327c2: 5080                 addq.l #$8, d0
0327c4: 03c0                 bset.b d1, d0
0327c6: 00000180             ori.b #$80, d0
0327ca: 00000810             ori.b #$10, d0
0327ce: 00001c38             ori.b #$38, d0
0327d2: 00000810             ori.b #$10, d0
0327d6: 00008001             ori.b #$1, d0
0327da: 00008001             ori.b #$1, d0
0327de: 0000c183             ori.b #$83, d0
0327e2: 0000e3c7             ori.b #$c7, d0
0327e6: 0000ffff             ori.b #$ff, d0
0327ea: 0000ffff             ori.b #$ff, d0
0327ee: 00007ffe             ori.b #$fe, d0
0327f2: 00007ffe             ori.b #$fe, d0
0327f6: 00003ffc             ori.b #$fc, d0
0327fa: 00001ff8             ori.b #$f8, d0
0327fe: 000007e0             ori.b #$e0, d0
032802: 00000000             ori.b #$0, d0
032806: 00000003             ori.b #$3, d0
03280a: 2658                 movea.l (a0)+, a3
03280c: 000326a0             ori.b #$a0, d3
032810: 000326e8             ori.b #$e8, d3
032814: 00032730             ori.b #$30, d3
032818: 00032778             ori.b #$78, d3
03281c: 000327c0             ori.b #$c0, d3
032820: 000326e8             ori.b #$e8, d3
032824: 00032730             ori.b #$30, d3
032828: 00000000             ori.b #$0, d0
03282c: 4064                 negx.w -(a4)
03282e: 5000                 addq.b #$8, d0
032830: 000007e0             ori.b #$e0, d0
032834: 01e0                 bset.b d0, -(a0)
032836: 3e18                 move.w (a0)+, d7
032838: 32f87f04             move.w $7f04.w, (a1)+
03283c: dc.w 7974
03283e: dc.w ff82
032840: dc.w 7974
032842: dc.w ff82
032844: dc.w 794e
032846: dc.w ff81
032848: dc.w 32fe
03284a: dc.w ff01
03284c: dc.w 41fe
03284e: be01                 cmp.b d1, d7
032850: dc.w 41fe
032852: be01                 cmp.b d1, d7
032854: dc.w 32fe
032856: dc.w ff01
032858: dc.w 794e
03285a: dc.w ff81
03285c: dc.w 7974
03285e: dc.w ff82
032860: dc.w 7974
032862: dc.w ff82
032864: 32f87f04             move.w $7f04.w, (a1)+
032868: 01e0                 bset.b d0, -(a0)
03286a: 3e18                 move.w (a0)+, d7
03286c: 000007e0             ori.b #$e0, d0
032870: 00000000             ori.b #$0, d0
032874: 4064                 negx.w -(a4)
032876: 5080                 addq.l #$8, d0
032878: 07e0                 bset.b d3, -(a0)
03287a: 000001f8             ori.b #$f8, d0
03287e: 000030fc             ori.b #$fc, d0
032882: 0000787e             ori.b #$7e, d0
032886: 0000787e             ori.b #$7e, d0
03288a: 0000787f             ori.b #$7f, d0
03288e: 0000b0ff             ori.b #$ff, d0
032892: 0000c1ff             ori.b #$ff, d0
032896: 0000c1ff             ori.b #$ff, d0
03289a: 0000b0ff             ori.b #$ff, d0
03289e: 0000787f             ori.b #$7f, d0
0328a2: 0000787e             ori.b #$7e, d0
0328a6: 0000787e             ori.b #$7e, d0
0328aa: 000030fc             ori.b #$fc, d0
0328ae: 000001f8             ori.b #$f8, d0
0328b2: 000007e0             ori.b #$e0, d0
0328b6: 00000000             ori.b #$0, d0
0328ba: 00004064             ori.b #$64, d0
0328be: 5000                 addq.b #$8, d0
0328c0: 000007e0             ori.b #$e0, d0
0328c4: 01e0                 bset.b d0, -(a0)
0328c6: 3e18                 move.w (a0)+, d7
0328c8: dc.w 02f8
0328ca: dc.w 7f04
0328cc: 317cff82797c         move.w #$ff82, $797c(a0)
0328d2: dc.w ff82
0328d4: 3146ff81             move.w d6, -$7f(a0)
0328d8: dc.w 02fe
0328da: dc.w ff01
0328dc: dc.w 41fe
0328de: be01                 cmp.b d1, d7
0328e0: dc.w 41fe
0328e2: be01                 cmp.b d1, d7
0328e4: dc.w 02fe
0328e6: dc.w ff01
0328e8: 3146ff81             move.w d6, -$7f(a0)
0328ec: dc.w 797c
0328ee: dc.w ff82
0328f0: 317cff8202f8         move.w #$ff82, $2f8(a0)
0328f6: dc.w 7f04
0328f8: 01e0                 bset.b d0, -(a0)
0328fa: 3e18                 move.w (a0)+, d7
0328fc: 000007e0             ori.b #$e0, d0
032900: 00000000             ori.b #$0, d0
032904: 4064                 negx.w -(a4)
032906: 5080                 addq.l #$8, d0
032908: 07e0                 bset.b d3, -(a0)
03290a: 000001f8             ori.b #$f8, d0
03290e: 000000fc             ori.b #$fc, d0
032912: 0000307e             ori.b #$7e, d0
032916: 0000787e             ori.b #$7e, d0
03291a: 0000307f             ori.b #$7f, d0
03291e: 000080ff             ori.b #$ff, d0
032922: 0000c1ff             ori.b #$ff, d0
032926: 0000c1ff             ori.b #$ff, d0
03292a: 000080ff             ori.b #$ff, d0
03292e: 0000307f             ori.b #$7f, d0
032932: 0000787e             ori.b #$7e, d0
032936: 0000307e             ori.b #$7e, d0
03293a: 000000fc             ori.b #$fc, d0
03293e: 000001f8             ori.b #$f8, d0
032942: 000007e0             ori.b #$e0, d0
032946: 00000000             ori.b #$0, d0
03294a: 00004064             ori.b #$64, d0
03294e: 5000                 addq.b #$8, d0
032950: 000007e0             ori.b #$e0, d0
032954: 01e0                 bset.b d0, -(a0)
032956: 3e18                 move.w (a0)+, d7
032958: dc.w 02f8
03295a: dc.w 7f04
03295c: 117cff82397c         move.b #$82, $397c(a0)
032962: dc.w ff82
032964: dc.w 114e
032966: dc.w ff81
032968: dc.w 02f6
03296a: dc.w ff01
03296c: 41f6be01             lea.l $1(a6, a3.l), a0
032970: 41f6be01             lea.l $1(a6, a3.l), a0
032974: dc.w 02f6
032976: dc.w ff01
032978: dc.w 114e
03297a: dc.w ff81
03297c: 397cff82117c         move.w #$ff82, $117c(a4)
032982: dc.w ff82
032984: dc.w 02f8
032986: dc.w 7f04
032988: 01e0                 bset.b d0, -(a0)
03298a: 3e18                 move.w (a0)+, d7
03298c: 000007e0             ori.b #$e0, d0
032990: 00000000             ori.b #$0, d0
032994: 4064                 negx.w -(a4)
032996: 5080                 addq.l #$8, d0
032998: 07e0                 bset.b d3, -(a0)
03299a: 000001f8             ori.b #$f8, d0
03299e: 000000fc             ori.b #$fc, d0
0329a2: 0000107e             ori.b #$7e, d0
0329a6: 0000387e             ori.b #$7e, d0
0329aa: 0000107f             ori.b #$7f, d0
0329ae: 000080ff             ori.b #$ff, d0
0329b2: 0000c1ff             ori.b #$ff, d0
0329b6: 0000c1ff             ori.b #$ff, d0
0329ba: 000080ff             ori.b #$ff, d0
0329be: 0000107f             ori.b #$7f, d0
0329c2: 0000387e             ori.b #$7e, d0
0329c6: 0000107e             ori.b #$7e, d0
0329ca: 000000fc             ori.b #$fc, d0
0329ce: 000001f8             ori.b #$f8, d0
0329d2: 000007e0             ori.b #$e0, d0
0329d6: 00000000             ori.b #$0, d0
0329da: 00000003             ori.b #$3, d0
0329de: 282c0003             move.l $3(a4), d4
0329e2: 28740003             movea.l $3(a4, d0.w), a4
0329e6: 28bc00032904         move.l #$32904, (a4)
0329ec: 0003294c             ori.b #$4c, d3
0329f0: 00032994             ori.b #$94, d3
0329f4: 000328bc             ori.b #$bc, d3
0329f8: 00032904             ori.b #$4, d3
0329fc: 00000000             ori.b #$0, d0
032a00: 4064                 negx.w -(a4)
032a02: 5000                 addq.b #$8, d0
032a04: 000007e0             ori.b #$e0, d0
032a08: 0780                 bclr.b d3, d0
032a0a: dc.w 187c
032a0c: dc.w 1f4c
032a0e: dc.w 20fe
032a10: 2e9e                 move.l (a6)+, (a7)
032a12: dc.w 41ff
032a14: 2e9e                 move.l (a6)+, (a7)
032a16: dc.w 41ff
032a18: 729e                 moveq #$9e, d1
032a1a: dc.w 81ff
032a1c: dc.w 7f4c
032a1e: dc.w 80ff
032a20: dc.w 7f82
032a22: dc.w 807d
032a24: dc.w 7f82
032a26: dc.w 807d
032a28: dc.w 7f4c
032a2a: dc.w 80ff
032a2c: 729e                 moveq #$9e, d1
032a2e: dc.w 81ff
032a30: 2e9e                 move.l (a6)+, (a7)
032a32: dc.w 41ff
032a34: 2e9e                 move.l (a6)+, (a7)
032a36: dc.w 41ff
032a38: dc.w 1f4c
032a3a: dc.w 20fe
032a3c: 0780                 bclr.b d3, d0
032a3e: dc.w 187c
032a40: 000007e0             ori.b #$e0, d0
032a44: 00000000             ori.b #$0, d0
032a48: 4064                 negx.w -(a4)
032a4a: 5080                 addq.l #$8, d0
032a4c: 07e0                 bset.b d3, -(a0)
032a4e: 00001f80             ori.b #$80, d0
032a52: 00003f0c             ori.b #$c, d0
032a56: 00007e1e             ori.b #$1e, d0
032a5a: 00007e1e             ori.b #$1e, d0
032a5e: 0000fe1e             ori.b #$1e, d0
032a62: 0000ff0d             ori.b #$d, d0
032a66: 0000ff83             ori.b #$83, d0
032a6a: 0000ff83             ori.b #$83, d0
032a6e: 0000ff0d             ori.b #$d, d0
032a72: 0000fe1e             ori.b #$1e, d0
032a76: 00007e1e             ori.b #$1e, d0
032a7a: 00007e1e             ori.b #$1e, d0
032a7e: 00003f0c             ori.b #$c, d0
032a82: 00001f80             ori.b #$80, d0
032a86: 000007e0             ori.b #$e0, d0
032a8a: 00000000             ori.b #$0, d0
032a8e: 00004064             ori.b #$64, d0
032a92: 5000                 addq.b #$8, d0
032a94: 000007e0             ori.b #$e0, d0
032a98: 0780                 bclr.b d3, d0
032a9a: dc.w 187c
032a9c: 1f4020fe             move.b d0, $20fe(a7)
032aa0: 3e8c                 move.w a4, (a7)
032aa2: dc.w 41ff
032aa4: 3e9e                 move.w (a6)+, (a7)
032aa6: dc.w 41ff
032aa8: 628c                 bhi.b $32a36
032aaa: dc.w 81ff
032aac: dc.w 7f40
032aae: dc.w 80ff
032ab0: dc.w 7f82
032ab2: dc.w 807d
032ab4: dc.w 7f82
032ab6: dc.w 807d
032ab8: dc.w 7f40
032aba: dc.w 80ff
032abc: 628c                 bhi.b $32a4a
032abe: dc.w 81ff
032ac0: 3e9e                 move.w (a6)+, (a7)
032ac2: dc.w 41ff
032ac4: 3e8c                 move.w a4, (a7)
032ac6: dc.w 41ff
032ac8: 1f4020fe             move.b d0, $20fe(a7)
032acc: 0780                 bclr.b d3, d0
032ace: dc.w 187c
032ad0: 000007e0             ori.b #$e0, d0
032ad4: 00000000             ori.b #$0, d0
032ad8: 4064                 negx.w -(a4)
032ada: 5080                 addq.l #$8, d0
032adc: 07e0                 bset.b d3, -(a0)
032ade: 00001f80             ori.b #$80, d0
032ae2: 00003f00             ori.b #$0, d0
032ae6: 00007e0c             ori.b #$c, d0
032aea: 00007e1e             ori.b #$1e, d0
032aee: 0000fe0c             ori.b #$c, d0
032af2: 0000ff01             ori.b #$1, d0
032af6: 0000ff83             ori.b #$83, d0
032afa: 0000ff83             ori.b #$83, d0
032afe: 0000ff01             ori.b #$1, d0
032b02: 0000fe0c             ori.b #$c, d0
032b06: 00007e1e             ori.b #$1e, d0
032b0a: 00007e0c             ori.b #$c, d0
032b0e: 00003f00             ori.b #$0, d0
032b12: 00001f80             ori.b #$80, d0
032b16: 000007e0             ori.b #$e0, d0
032b1a: 00000000             ori.b #$0, d0
032b1e: 00004064             ori.b #$64, d0
032b22: 5000                 addq.b #$8, d0
032b24: 000007e0             ori.b #$e0, d0
032b28: 0780                 bclr.b d3, d0
032b2a: dc.w 187c
032b2c: 1f4020fe             move.b d0, $20fe(a7)
032b30: 3e88                 move.w a0, (a7)
032b32: dc.w 41ff
032b34: 3e9c                 move.w (a4)+, (a7)
032b36: dc.w 41ff
032b38: 7288                 moveq #$88, d1
032b3a: dc.w 81ff
032b3c: 6f40                 ble.b $32b7e
032b3e: dc.w 80ff
032b40: 6f82                 ble.b $32ac4
032b42: dc.w 807d
032b44: 6f82                 ble.b $32ac8
032b46: dc.w 807d
032b48: 6f40                 ble.b $32b8a
032b4a: dc.w 80ff
032b4c: 7288                 moveq #$88, d1
032b4e: dc.w 81ff
032b50: 3e9c                 move.w (a4)+, (a7)
032b52: dc.w 41ff
032b54: 3e88                 move.w a0, (a7)
032b56: dc.w 41ff
032b58: 1f4020fe             move.b d0, $20fe(a7)
032b5c: 0780                 bclr.b d3, d0
032b5e: dc.w 187c
032b60: 000007e0             ori.b #$e0, d0
032b64: 00000000             ori.b #$0, d0
032b68: 4064                 negx.w -(a4)
032b6a: 5080                 addq.l #$8, d0
032b6c: 07e0                 bset.b d3, -(a0)
032b6e: 00001f80             ori.b #$80, d0
032b72: 00003f00             ori.b #$0, d0
032b76: 00007e08             ori.b #$8, d0
032b7a: 00007e1c             ori.b #$1c, d0
032b7e: 0000fe08             ori.b #$8, d0
032b82: 0000ff01             ori.b #$1, d0
032b86: 0000ff83             ori.b #$83, d0
032b8a: 0000ff83             ori.b #$83, d0
032b8e: 0000ff01             ori.b #$1, d0
032b92: 0000fe08             ori.b #$8, d0
032b96: 00007e1c             ori.b #$1c, d0
032b9a: 00007e08             ori.b #$8, d0
032b9e: 00003f00             ori.b #$0, d0
032ba2: 00001f80             ori.b #$80, d0
032ba6: 000007e0             ori.b #$e0, d0
032baa: 00000000             ori.b #$0, d0
032bae: 00000003             ori.b #$3, d0
032bb2: 2a00                 move.l d0, d5
032bb4: 00032a48             ori.b #$48, d3
032bb8: 00032a90             ori.b #$90, d3
032bbc: 00032ad8             ori.b #$d8, d3
032bc0: 00032b20             ori.b #$20, d3
032bc4: 00032b68             ori.b #$68, d3
032bc8: 00032a90             ori.b #$90, d3
032bcc: 00032ad8             ori.b #$d8, d3
032bd0: 00000000             ori.b #$0, d0
032bd4: 4064                 negx.w -(a4)
032bd6: 5000                 addq.b #$8, d0
032bd8: 0780                 bclr.b d3, d0
032bda: 07e0                 bset.b d3, -(a0)
032bdc: 07e0                 bset.b d3, -(a0)
032bde: 1f981ff827843ffc     move.b (a0)+, $27843ffc(invalid.w)
032be6: 4302                 dc.w $4302
032be8: dc.w 3ffc
032bea: 4002                 negx.b d2
032bec: 7c3e                 moveq #$3e, d6
032bee: 83c1                 divs.w d1, d1
032bf0: dc.w 7bde
032bf2: 87e1                 divs.w -(a1), d3
032bf4: dc.w 7bde
032bf6: 87e1                 divs.w -(a1), d3
032bf8: dc.w 7bde
032bfa: 87e1                 divs.w -(a1), d3
032bfc: dc.w 7bde
032bfe: 87e1                 divs.w -(a1), d3
032c00: 7c3e                 moveq #$3e, d6
032c02: 83c1                 divs.w d1, d1
032c04: dc.w 3ffc
032c06: 4002                 negx.b d2
032c08: dc.w 3ffc
032c0a: 40c2                 move.w sr, d2
032c0c: dc.w 1ff8
032c0e: 21e407e0             move.l -(a4), $7e0.w
032c12: dc.w 19f8
032c14: 01e0                 bset.b d0, -(a0)
032c16: 07e0                 bset.b d3, -(a0)
032c18: 00000000             ori.b #$0, d0
032c1c: 4064                 negx.w -(a4)
032c1e: 5000                 addq.b #$8, d0
032c20: 03c0                 bset.b d1, d0
032c22: 07e0                 bset.b d3, -(a0)
032c24: 07e0                 bset.b d3, -(a0)
032c26: dc.w 1bd8
032c28: dc.w 1ff8
032c2a: 23c43ffc4182         move.l d4, $3ffc4182.l
032c30: dc.w 3ffc
032c32: 4002                 negx.b d2
032c34: 7e7e                 moveq #$7e, d7
032c36: 8181                 dc.w $8181
032c38: dc.w 7dbe
032c3a: 83c1                 divs.w d1, d1
032c3c: dc.w 7bde
032c3e: 87e1                 divs.w -(a1), d3
032c40: dc.w 7bde
032c42: 87e1                 divs.w -(a1), d3
032c44: dc.w 7dbe
032c46: 83c1                 divs.w d1, d1
032c48: 7e7e                 moveq #$7e, d7
032c4a: 8181                 dc.w $8181
032c4c: dc.w 3ffc
032c4e: 4002                 negx.b d2
032c50: dc.w 3ffc
032c52: 4182                 chk.w d2, d0
032c54: dc.w 1ff8
032c56: 23c407e01bd8         move.l d4, $7e01bd8.l
032c5c: 03c0                 bset.b d1, d0
032c5e: 07e0                 bset.b d3, -(a0)
032c60: 00000000             ori.b #$0, d0
032c64: 4064                 negx.w -(a4)
032c66: 5000                 addq.b #$8, d0
032c68: 01e0                 bset.b d0, -(a0)
032c6a: 07e0                 bset.b d3, -(a0)
032c6c: 07e0                 bset.b d3, -(a0)
032c6e: dc.w 19f8
032c70: dc.w 1ff8
032c72: 21e43ffc             move.l -(a4), $3ffc.w
032c76: 40c2                 move.w sr, d2
032c78: dc.w 3ffc
032c7a: 4002                 negx.b d2
032c7c: dc.w 7ffe
032c7e: 8001                 or.b d1, d0
032c80: 7e7e                 moveq #$7e, d7
032c82: 8181                 dc.w $8181
032c84: dc.w 7dbe
032c86: 83c1                 divs.w d1, d1
032c88: dc.w 7dbe
032c8a: 83c1                 divs.w d1, d1
032c8c: 7e7e                 moveq #$7e, d7
032c8e: 8181                 dc.w $8181
032c90: dc.w 7ffe
032c92: 8001                 or.b d1, d0
032c94: dc.w 3ffc
032c96: 4002                 negx.b d2
032c98: dc.w 3ffc
032c9a: 4302                 dc.w $4302
032c9c: dc.w 1ff8
032c9e: 278407e01f98         move.l d4, $1f98(invalid.w)
032ca4: 0780                 bclr.b d3, d0
032ca6: 07e0                 bset.b d3, -(a0)
032ca8: 00000000             ori.b #$0, d0
032cac: 00032bd4             ori.b #$d4, d3
032cb0: 00032bd4             ori.b #$d4, d3
032cb4: 00032c1c             ori.b #$1c, d3
032cb8: 00032c1c             ori.b #$1c, d3
032cbc: 00032c64             ori.b #$64, d3
032cc0: 00032c64             ori.b #$64, d3
032cc4: 00032c1c             ori.b #$1c, d3
032cc8: 00032c1c             ori.b #$1c, d3
032ccc: 00000000             ori.b #$0, d0
032cd0: 4064                 negx.w -(a4)
032cd2: 5000                 addq.b #$8, d0
032cd4: 000007e0             ori.b #$e0, d0
032cd8: 07e0                 bset.b d3, -(a0)
032cda: 1818                 move.b (a0)+, d4
032cdc: dc.w 1ff8
032cde: 2004                 move.l d4, d0
032ce0: dc.w 3ffc
032ce2: 4002                 negx.b d2
032ce4: dc.w 3ffc
032ce6: 4002                 negx.b d2
032ce8: 7c3f                 moveq #$3f, d6
032cea: 83c7                 divs.w d7, d1
032cec: dc.w 7bdf
032cee: 87effbdf             divs.w -$421(a7), d3
032cf2: e7effbdf             rol.w -$421(a7)
032cf6: dc.w f7e7
032cf8: dc.w fbde
032cfa: dc.w f7e1
032cfc: fc3e                 dc.w $fc3e
032cfe: dc.w e3c1
032d00: dc.w 3ffc
032d02: 4002                 negx.b d2
032d04: dc.w 3ffc
032d06: 4002                 negx.b d2
032d08: dc.w 1ff8
032d0a: 2004                 move.l d4, d0
032d0c: 07e0                 bset.b d3, -(a0)
032d0e: 1818                 move.b (a0)+, d4
032d10: 000007e0             ori.b #$e0, d0
032d14: 00000000             ori.b #$0, d0
032d18: 4064                 negx.w -(a4)
032d1a: 5000                 addq.b #$8, d0
032d1c: 000007e0             ori.b #$e0, d0
032d20: 07e0                 bset.b d3, -(a0)
032d22: 1818                 move.b (a0)+, d4
032d24: dc.w 1ff8
032d26: 2004                 move.l d4, d0
032d28: dc.w 3ffc
032d2a: 4002                 negx.b d2
032d2c: dc.w 3ffc
032d2e: 4002                 negx.b d2
032d30: 7e7e                 moveq #$7e, d7
032d32: 8181                 dc.w $8181
032d34: dc.w fdbf
032d36: dc.w e3c7
032d38: dc.w fbdf
032d3a: dc.w f7ef
032d3c: dc.w fbdf
032d3e: dc.w f7ef
032d40: dc.w fdbf
032d42: dc.w e3c7
032d44: 7e7e                 moveq #$7e, d7
032d46: 8181                 dc.w $8181
032d48: dc.w 3ffc
032d4a: 4002                 negx.b d2
032d4c: dc.w 3ffc
032d4e: 4002                 negx.b d2
032d50: dc.w 1ff8
032d52: 2004                 move.l d4, d0
032d54: 07e0                 bset.b d3, -(a0)
032d56: 1818                 move.b (a0)+, d4
032d58: 000007e0             ori.b #$e0, d0
032d5c: 00000000             ori.b #$0, d0
032d60: 4064                 negx.w -(a4)
032d62: 5000                 addq.b #$8, d0
032d64: 000007e0             ori.b #$e0, d0
032d68: 07e0                 bset.b d3, -(a0)
032d6a: 1818                 move.b (a0)+, d4
032d6c: dc.w 1ff8
032d6e: 2004                 move.l d4, d0
032d70: dc.w 3ffc
032d72: 4002                 negx.b d2
032d74: dc.w 3ffc
032d76: 4002                 negx.b d2
032d78: dc.w fffe
032d7a: e001                 asr.b #$8, d1
032d7c: dc.w fe7e
032d7e: dc.w f181
032d80: dc.w fdbf
032d82: dc.w f3c7
032d84: dc.w fdbf
032d86: dc.w e3cf
032d88: 7e7f                 moveq #$7f, d7
032d8a: 818f                 dc.w $818f
032d8c: dc.w 7fff
032d8e: 8007                 or.b d7, d0
032d90: dc.w 3ffc
032d92: 4002                 negx.b d2
032d94: dc.w 3ffc
032d96: 4002                 negx.b d2
032d98: dc.w 1ff8
032d9a: 2004                 move.l d4, d0
032d9c: 07e0                 bset.b d3, -(a0)
032d9e: 1818                 move.b (a0)+, d4
032da0: 000007e0             ori.b #$e0, d0
032da4: 00000000             ori.b #$0, d0
032da8: 00032cd0             ori.b #$d0, d3
032dac: 00032cd0             ori.b #$d0, d3
032db0: 00032d18             ori.b #$18, d3
032db4: 00032d18             ori.b #$18, d3
032db8: 00032d60             ori.b #$60, d3
032dbc: 00032d60             ori.b #$60, d3
032dc0: 00032d18             ori.b #$18, d3
032dc4: 00032d18             ori.b #$18, d3
032dc8: 00000000             ori.b #$0, d0
032dcc: 4064                 negx.w -(a4)
032dce: 5000                 addq.b #$8, d0
032dd0: 0780                 bclr.b d3, d0
032dd2: 07e0                 bset.b d3, -(a0)
032dd4: 07e0                 bset.b d3, -(a0)
032dd6: 1f981ff827843ffc     move.b (a0)+, $27843ffc(invalid.w)
032dde: 4302                 dc.w $4302
032de0: dc.w 3ffc
032de2: 4002                 negx.b d2
032de4: 7c3e                 moveq #$3e, d6
032de6: 83c1                 divs.w d1, d1
032de8: dc.w 7bde
032dea: 87e1                 divs.w -(a1), d3
032dec: dc.w 7bde
032dee: 87e1                 divs.w -(a1), d3
032df0: dc.w 7bde
032df2: 87e1                 divs.w -(a1), d3
032df4: dc.w 7bde
032df6: 87e1                 divs.w -(a1), d3
032df8: 7c3e                 moveq #$3e, d6
032dfa: 83c1                 divs.w d1, d1
032dfc: dc.w 3ffc
032dfe: 4002                 negx.b d2
032e00: dc.w 3ffc
032e02: 40c2                 move.w sr, d2
032e04: dc.w 1ff8
032e06: 21e407e0             move.l -(a4), $7e0.w
032e0a: dc.w 19f8
032e0c: 01e0                 bset.b d0, -(a0)
032e0e: 07e0                 bset.b d3, -(a0)
032e10: 00000000             ori.b #$0, d0
032e14: 4064                 negx.w -(a4)
032e16: 5000                 addq.b #$8, d0
032e18: 03c0                 bset.b d1, d0
032e1a: 07e0                 bset.b d3, -(a0)
032e1c: 07e0                 bset.b d3, -(a0)
032e1e: dc.w 1bd8
032e20: dc.w 1ff8
032e22: 23c43ffc4182         move.l d4, $3ffc4182.l
032e28: dc.w 3ffc
032e2a: 4002                 negx.b d2
032e2c: 7e7e                 moveq #$7e, d7
032e2e: 8181                 dc.w $8181
032e30: dc.w 7dbe
032e32: 83c1                 divs.w d1, d1
032e34: dc.w 7bde
032e36: 87e1                 divs.w -(a1), d3
032e38: dc.w 7bde
032e3a: 87e1                 divs.w -(a1), d3
032e3c: dc.w 7dbe
032e3e: 83c1                 divs.w d1, d1
032e40: 7e7e                 moveq #$7e, d7
032e42: 8181                 dc.w $8181
032e44: dc.w 3ffc
032e46: 4002                 negx.b d2
032e48: dc.w 3ffc
032e4a: 4182                 chk.w d2, d0
032e4c: dc.w 1ff8
032e4e: 23c407e01bd8         move.l d4, $7e01bd8.l
032e54: 03c0                 bset.b d1, d0
032e56: 07e0                 bset.b d3, -(a0)
032e58: 00000000             ori.b #$0, d0
032e5c: 4064                 negx.w -(a4)
032e5e: 5000                 addq.b #$8, d0
032e60: 01e0                 bset.b d0, -(a0)
032e62: 07e0                 bset.b d3, -(a0)
032e64: 07e0                 bset.b d3, -(a0)
032e66: dc.w 19f8
032e68: dc.w 1ff8
032e6a: 21e43ffc             move.l -(a4), $3ffc.w
032e6e: 40c2                 move.w sr, d2
032e70: dc.w 3ffc
032e72: 4002                 negx.b d2
032e74: dc.w 7ffe
032e76: 8001                 or.b d1, d0
032e78: 7e7e                 moveq #$7e, d7
032e7a: 8181                 dc.w $8181
032e7c: dc.w 7dbe
032e7e: 83c1                 divs.w d1, d1
032e80: dc.w 7dbe
032e82: 83c1                 divs.w d1, d1
032e84: 7e7e                 moveq #$7e, d7
032e86: 8181                 dc.w $8181
032e88: dc.w 7ffe
032e8a: 8001                 or.b d1, d0
032e8c: dc.w 3ffc
032e8e: 4002                 negx.b d2
032e90: dc.w 3ffc
032e92: 4302                 dc.w $4302
032e94: dc.w 1ff8
032e96: 278407e01f98         move.l d4, $1f98(invalid.w)
032e9c: 0780                 bclr.b d3, d0
032e9e: 07e0                 bset.b d3, -(a0)
032ea0: 00000000             ori.b #$0, d0
032ea4: 00032dcc             ori.b #$cc, d3
032ea8: 00032dcc             ori.b #$cc, d3
032eac: 00032e14             ori.b #$14, d3
032eb0: 00032e14             ori.b #$14, d3
032eb4: 00032e5c             ori.b #$5c, d3
032eb8: 00032e5c             ori.b #$5c, d3
032ebc: 00032e14             ori.b #$14, d3
032ec0: 00032e14             ori.b #$14, d3
032ec4: 00000000             ori.b #$0, d0
032ec8: 4064                 negx.w -(a4)
032eca: 5000                 addq.b #$8, d0
032ecc: 000007e0             ori.b #$e0, d0
032ed0: 07e0                 bset.b d3, -(a0)
032ed2: 1818                 move.b (a0)+, d4
032ed4: dc.w 1ff8
032ed6: 2004                 move.l d4, d0
032ed8: dc.w 3ffc
032eda: 4002                 negx.b d2
032edc: dc.w 3ffc
032ede: 4002                 negx.b d2
032ee0: 7c3f                 moveq #$3f, d6
032ee2: 83c7                 divs.w d7, d1
032ee4: dc.w 7bdf
032ee6: 87effbdf             divs.w -$421(a7), d3
032eea: e7effbdf             rol.w -$421(a7)
032eee: dc.w f7e7
032ef0: dc.w fbde
032ef2: dc.w f7e1
032ef4: fc3e                 dc.w $fc3e
032ef6: dc.w e3c1
032ef8: dc.w 3ffc
032efa: 4002                 negx.b d2
032efc: dc.w 3ffc
032efe: 4002                 negx.b d2
032f00: dc.w 1ff8
032f02: 2004                 move.l d4, d0
032f04: 07e0                 bset.b d3, -(a0)
032f06: 1818                 move.b (a0)+, d4
032f08: 000007e0             ori.b #$e0, d0
032f0c: 00000000             ori.b #$0, d0
032f10: 4064                 negx.w -(a4)
032f12: 5000                 addq.b #$8, d0
032f14: 000007e0             ori.b #$e0, d0
032f18: 07e0                 bset.b d3, -(a0)
032f1a: 1818                 move.b (a0)+, d4
032f1c: dc.w 1ff8
032f1e: 2004                 move.l d4, d0
032f20: dc.w 3ffc
032f22: 4002                 negx.b d2
032f24: dc.w 3ffc
032f26: 4002                 negx.b d2
032f28: 7e7e                 moveq #$7e, d7
032f2a: 8181                 dc.w $8181
032f2c: dc.w fdbf
032f2e: dc.w e3c7
032f30: dc.w fbdf
032f32: dc.w f7ef
032f34: dc.w fbdf
032f36: dc.w f7ef
032f38: dc.w fdbf
032f3a: dc.w e3c7
032f3c: 7e7e                 moveq #$7e, d7
032f3e: 8181                 dc.w $8181
032f40: dc.w 3ffc
032f42: 4002                 negx.b d2
032f44: dc.w 3ffc
032f46: 4002                 negx.b d2
032f48: dc.w 1ff8
032f4a: 2004                 move.l d4, d0
032f4c: 07e0                 bset.b d3, -(a0)
032f4e: 1818                 move.b (a0)+, d4
032f50: 000007e0             ori.b #$e0, d0
032f54: 00000000             ori.b #$0, d0
032f58: 4064                 negx.w -(a4)
032f5a: 5000                 addq.b #$8, d0
032f5c: 000007e0             ori.b #$e0, d0
032f60: 07e0                 bset.b d3, -(a0)
032f62: 1818                 move.b (a0)+, d4
032f64: dc.w 1ff8
032f66: 2004                 move.l d4, d0
032f68: dc.w 3ffc
032f6a: 4002                 negx.b d2
032f6c: dc.w 3ffc
032f6e: 4002                 negx.b d2
032f70: dc.w fffe
032f72: e001                 asr.b #$8, d1
032f74: dc.w fe7e
032f76: dc.w f181
032f78: dc.w fdbf
032f7a: dc.w f3c7
032f7c: dc.w fdbf
032f7e: dc.w e3cf
032f80: 7e7f                 moveq #$7f, d7
032f82: 818f                 dc.w $818f
032f84: dc.w 7fff
032f86: 8007                 or.b d7, d0
032f88: dc.w 3ffc
032f8a: 4002                 negx.b d2
032f8c: dc.w 3ffc
032f8e: 4002                 negx.b d2
032f90: dc.w 1ff8
032f92: 2004                 move.l d4, d0
032f94: 07e0                 bset.b d3, -(a0)
032f96: 1818                 move.b (a0)+, d4
032f98: 000007e0             ori.b #$e0, d0
032f9c: 00000000             ori.b #$0, d0
032fa0: 00032ec8             ori.b #$c8, d3
032fa4: 00032ec8             ori.b #$c8, d3
032fa8: 00032f10             ori.b #$10, d3
032fac: 00032f10             ori.b #$10, d3
032fb0: 00032f58             ori.b #$58, d3
032fb4: 00032f58             ori.b #$58, d3
032fb8: 00032f10             ori.b #$10, d3
032fbc: 00032f10             ori.b #$10, d3
032fc0: 00000000             ori.b #$0, d0
032fc4: 0780                 bclr.b d3, d0
032fc6: 000007e0             ori.b #$e0, d0
032fca: 000007e0             ori.b #$e0, d0
032fce: 00001f98             ori.b #$98, d0
032fd2: 00001ff8             ori.b #$f8, d0
032fd6: 00002784             ori.b #$84, d0
032fda: 00003ffc             ori.b #$fc, d0
032fde: 00004302             ori.b #$2, d0
032fe2: 00003ffc             ori.b #$fc, d0
032fe6: 00004002             ori.b #$2, d0
032fea: 00007c3e             ori.b #$3e, d0
032fee: 000083c1             ori.b #$c1, d0
032ff2: 00007bde             ori.b #$de, d0
032ff6: 000087e1             ori.b #$e1, d0
032ffa: 00007bde             ori.b #$de, d0
032ffe: 000087e1             ori.b #$e1, d0
033002: 00007bde             ori.b #$de, d0
033006: 000087e1             ori.b #$e1, d0
03300a: 00007bde             ori.b #$de, d0
03300e: 000087e1             ori.b #$e1, d0
033012: 00007c3e             ori.b #$3e, d0
033016: 000083c1             ori.b #$c1, d0
03301a: 00003ffc             ori.b #$fc, d0
03301e: 00004002             ori.b #$2, d0
033022: 00003ffc             ori.b #$fc, d0
033026: 000040c2             ori.b #$c2, d0
03302a: 00001ff8             ori.b #$f8, d0
03302e: 000021e4             ori.b #$e4, d0
033032: 000007e0             ori.b #$e0, d0
033036: 000019f8             ori.b #$f8, d0
03303a: 000001e0             ori.b #$e0, d0
03303e: 000007e0             ori.b #$e0, d0
033042: 000003c0             ori.b #$c0, d0
033046: 000007e0             ori.b #$e0, d0
03304a: 000007e0             ori.b #$e0, d0
03304e: 00001bd8             ori.b #$d8, d0
033052: 00001ff8             ori.b #$f8, d0
033056: 000023c4             ori.b #$c4, d0
03305a: 00003ffc             ori.b #$fc, d0
03305e: 00004182             ori.b #$82, d0
033062: 00003ffc             ori.b #$fc, d0
033066: 00004002             ori.b #$2, d0
03306a: 00007e7e             ori.b #$7e, d0
03306e: 00008181             ori.b #$81, d0
033072: 00007dbe             ori.b #$be, d0
033076: 000083c1             ori.b #$c1, d0
03307a: 00007bde             ori.b #$de, d0
03307e: 000087e1             ori.b #$e1, d0
033082: 00007bde             ori.b #$de, d0
033086: 000087e1             ori.b #$e1, d0
03308a: 00007dbe             ori.b #$be, d0
03308e: 000083c1             ori.b #$c1, d0
033092: 00007e7e             ori.b #$7e, d0
033096: 00008181             ori.b #$81, d0
03309a: 00003ffc             ori.b #$fc, d0
03309e: 00004002             ori.b #$2, d0
0330a2: 00003ffc             ori.b #$fc, d0
0330a6: 00004182             ori.b #$82, d0
0330aa: 00001ff8             ori.b #$f8, d0
0330ae: 000023c4             ori.b #$c4, d0
0330b2: 000007e0             ori.b #$e0, d0
0330b6: 00001bd8             ori.b #$d8, d0
0330ba: 000003c0             ori.b #$c0, d0
0330be: 000007e0             ori.b #$e0, d0
0330c2: 000001e0             ori.b #$e0, d0
0330c6: 000007e0             ori.b #$e0, d0
0330ca: 000007e0             ori.b #$e0, d0
0330ce: 000019f8             ori.b #$f8, d0
0330d2: 00001ff8             ori.b #$f8, d0
0330d6: 000021e4             ori.b #$e4, d0
0330da: 00003ffc             ori.b #$fc, d0
0330de: 000040c2             ori.b #$c2, d0
0330e2: 00003ffc             ori.b #$fc, d0
0330e6: 00004002             ori.b #$2, d0
0330ea: 00007ffe             ori.b #$fe, d0
0330ee: 00008001             ori.b #$1, d0
0330f2: 00007e7e             ori.b #$7e, d0
0330f6: 00008181             ori.b #$81, d0
0330fa: 00007dbe             ori.b #$be, d0
0330fe: 000083c1             ori.b #$c1, d0
033102: 00007dbe             ori.b #$be, d0
033106: 000083c1             ori.b #$c1, d0
03310a: 00007e7e             ori.b #$7e, d0
03310e: 00008181             ori.b #$81, d0
033112: 00007ffe             ori.b #$fe, d0
033116: 00008001             ori.b #$1, d0
03311a: 00003ffc             ori.b #$fc, d0
03311e: 00004002             ori.b #$2, d0
033122: 00003ffc             ori.b #$fc, d0
033126: 00004302             ori.b #$2, d0
03312a: 00001ff8             ori.b #$f8, d0
03312e: 00002784             ori.b #$84, d0
033132: 000007e0             ori.b #$e0, d0
033136: 00001f98             ori.b #$98, d0
03313a: 00000780             ori.b #$80, d0
03313e: 000007e0             ori.b #$e0, d0
033142: 00000003             ori.b #$3, d0
033146: dc.w 2fc4
033148: 00032fc4             ori.b #$c4, d3
03314c: 00033044             ori.b #$44, d3
033150: 00033044             ori.b #$44, d3
033154: 000330c4             ori.b #$c4, d3
033158: 000330c4             ori.b #$c4, d3
03315c: 00033044             ori.b #$44, d3
033160: 00033044             ori.b #$44, d3
033164: 00000000             ori.b #$0, d0
033168: 07e0                 bset.b d3, -(a0)
03316a: 000007e0             ori.b #$e0, d0
03316e: 00001818             ori.b #$18, d0
033172: 00001ff8             ori.b #$f8, d0
033176: 00002004             ori.b #$4, d0
03317a: 00003ffc             ori.b #$fc, d0
03317e: 00004002             ori.b #$2, d0
033182: 00003ffc             ori.b #$fc, d0
033186: 00004002             ori.b #$2, d0
03318a: 00007c3f             ori.b #$3f, d0
03318e: 000083c7             ori.b #$c7, d0
033192: 00007bdf             ori.b #$df, d0
033196: 000087ef             ori.b #$ef, d0
03319a: 0000fbdf             ori.b #$df, d0
03319e: 0000e7ef             ori.b #$ef, d0
0331a2: 0000fbdf             ori.b #$df, d0
0331a6: 0000f7e7             ori.b #$e7, d0
0331aa: 0000fbde             ori.b #$de, d0
0331ae: 0000f7e1             ori.b #$e1, d0
0331b2: 0000fc3e             ori.b #$3e, d0
0331b6: 0000e3c1             ori.b #$c1, d0
0331ba: 00003ffc             ori.b #$fc, d0
0331be: 00004002             ori.b #$2, d0
0331c2: 00003ffc             ori.b #$fc, d0
0331c6: 00004002             ori.b #$2, d0
0331ca: 00001ff8             ori.b #$f8, d0
0331ce: 00002004             ori.b #$4, d0
0331d2: 000007e0             ori.b #$e0, d0
0331d6: 00001818             ori.b #$18, d0
0331da: 00000000             ori.b #$0, d0
0331de: 000007e0             ori.b #$e0, d0
0331e2: 00000000             ori.b #$0, d0
0331e6: 000007e0             ori.b #$e0, d0
0331ea: 000007e0             ori.b #$e0, d0
0331ee: 00001818             ori.b #$18, d0
0331f2: 00001ff8             ori.b #$f8, d0
0331f6: 00002004             ori.b #$4, d0
0331fa: 00003ffc             ori.b #$fc, d0
0331fe: 00004002             ori.b #$2, d0
033202: 00003ffc             ori.b #$fc, d0
033206: 00004002             ori.b #$2, d0
03320a: 00007e7e             ori.b #$7e, d0
03320e: 00008181             ori.b #$81, d0
033212: 0000fdbf             ori.b #$bf, d0
033216: 0000e3c7             ori.b #$c7, d0
03321a: 0000fbdf             ori.b #$df, d0
03321e: 0000f7ef             ori.b #$ef, d0
033222: 0000fbdf             ori.b #$df, d0
033226: 0000f7ef             ori.b #$ef, d0
03322a: 0000fdbf             ori.b #$bf, d0
03322e: 0000e3c7             ori.b #$c7, d0
033232: 00007e7e             ori.b #$7e, d0
033236: 00008181             ori.b #$81, d0
03323a: 00003ffc             ori.b #$fc, d0
03323e: 00004002             ori.b #$2, d0
033242: 00003ffc             ori.b #$fc, d0
033246: 00004002             ori.b #$2, d0
03324a: 00001ff8             ori.b #$f8, d0
03324e: 00002004             ori.b #$4, d0
033252: 000007e0             ori.b #$e0, d0
033256: 00001818             ori.b #$18, d0
03325a: 00000000             ori.b #$0, d0
03325e: 000007e0             ori.b #$e0, d0
033262: 00000000             ori.b #$0, d0
033266: 000007e0             ori.b #$e0, d0
03326a: 000007e0             ori.b #$e0, d0
03326e: 00001818             ori.b #$18, d0
033272: 00001ff8             ori.b #$f8, d0
033276: 00002004             ori.b #$4, d0
03327a: 00003ffc             ori.b #$fc, d0
03327e: 00004002             ori.b #$2, d0
033282: 00003ffc             ori.b #$fc, d0
033286: 00004002             ori.b #$2, d0
03328a: 0000fffe             ori.b #$fe, d0
03328e: 0000e001             ori.b #$1, d0
033292: 0000fe7e             ori.b #$7e, d0
033296: 0000f181             ori.b #$81, d0
03329a: 0000fdbf             ori.b #$bf, d0
03329e: 0000f3c7             ori.b #$c7, d0
0332a2: 0000fdbf             ori.b #$bf, d0
0332a6: 0000e3cf             ori.b #$cf, d0
0332aa: 00007e7f             ori.b #$7f, d0
0332ae: 0000818f             ori.b #$8f, d0
0332b2: 00007fff             ori.b #$ff, d0
0332b6: 00008007             ori.b #$7, d0
0332ba: 00003ffc             ori.b #$fc, d0
0332be: 00004002             ori.b #$2, d0
0332c2: 00003ffc             ori.b #$fc, d0
0332c6: 00004002             ori.b #$2, d0
0332ca: 00001ff8             ori.b #$f8, d0
0332ce: 00002004             ori.b #$4, d0
0332d2: 000007e0             ori.b #$e0, d0
0332d6: 00001818             ori.b #$18, d0
0332da: 00000000             ori.b #$0, d0
0332de: 000007e0             ori.b #$e0, d0
0332e2: 00000003             ori.b #$3, d0
0332e6: 31640003             move.w -(a4), $3(a0)
0332ea: 31640003             move.w -(a4), $3(a0)
0332ee: 31e40003             move.w -(a4), $3.w
0332f2: 31e40003             move.w -(a4), $3.w
0332f6: 3264                 movea.w -(a4), a1
0332f8: 00033264             ori.b #$64, d3
0332fc: 000331e4             ori.b #$e4, d3
033300: 000331e4             ori.b #$e4, d3
033304: 07e0                 bset.b d3, -(a0)
033306: 000007e0             ori.b #$e0, d0
03330a: 00001ff8             ori.b #$f8, d0
03330e: 00001ff8             ori.b #$f8, d0
033312: 00003ffc             ori.b #$fc, d0
033316: 00003ffc             ori.b #$fc, d0
03331a: 00007ffe             ori.b #$fe, d0
03331e: 00007ffe             ori.b #$fe, d0
033322: 00007ffe             ori.b #$fe, d0
033326: 00007ffe             ori.b #$fe, d0
03332a: 0000ffff             ori.b #$ff, d0
03332e: 0000ffff             ori.b #$ff, d0
033332: 0000ffff             ori.b #$ff, d0
033336: 0000ffff             ori.b #$ff, d0
03333a: 0000ffff             ori.b #$ff, d0
03333e: 0000ffff             ori.b #$ff, d0
033342: 0000ffff             ori.b #$ff, d0
033346: 0000ffff             ori.b #$ff, d0
03334a: 0000ffff             ori.b #$ff, d0
03334e: 0000ffff             ori.b #$ff, d0
033352: 0000ffff             ori.b #$ff, d0
033356: 0000ffff             ori.b #$ff, d0
03335a: 00007ffe             ori.b #$fe, d0
03335e: 00007ffe             ori.b #$fe, d0
033362: 00007ffe             ori.b #$fe, d0
033366: 00007ffe             ori.b #$fe, d0
03336a: 00003ffc             ori.b #$fc, d0
03336e: 00003ffc             ori.b #$fc, d0
033372: 00001ff8             ori.b #$f8, d0
033376: 00001ff8             ori.b #$f8, d0
03337a: 000007e0             ori.b #$e0, d0
03337e: 000007e0             ori.b #$e0, d0
033382: 00000000             ori.b #$0, d0
033386: 00000000             ori.b #$0, d0
03338a: 00000000             ori.b #$0, d0
03338e: 00000000             ori.b #$0, d0
033392: 00000000             ori.b #$0, d0
033396: 00000000             ori.b #$0, d0
03339a: 00000000             ori.b #$0, d0
03339e: 00000000             ori.b #$0, d0
0333a2: 00000000             ori.b #$0, d0
0333a6: 00000000             ori.b #$0, d0
0333aa: 00000000             ori.b #$0, d0
0333ae: 00000000             ori.b #$0, d0
0333b2: 00000000             ori.b #$0, d0
0333b6: 00000000             ori.b #$0, d0
0333ba: 00000000             ori.b #$0, d0
0333be: 00000000             ori.b #$0, d0
0333c2: 00000000             ori.b #$0, d0
0333c6: 00000000             ori.b #$0, d0
0333ca: 00000000             ori.b #$0, d0
0333ce: 00000000             ori.b #$0, d0
0333d2: 00000000             ori.b #$0, d0
0333d6: 00000000             ori.b #$0, d0
0333da: 00000000             ori.b #$0, d0
0333de: 00000000             ori.b #$0, d0
0333e2: 00000000             ori.b #$0, d0
0333e6: 00000000             ori.b #$0, d0
0333ea: 00000000             ori.b #$0, d0
0333ee: 00000000             ori.b #$0, d0
0333f2: 00000000             ori.b #$0, d0
0333f6: 00000000             ori.b #$0, d0
0333fa: 00000000             ori.b #$0, d0
0333fe: 00000000             ori.b #$0, d0
033402: 000007c0             ori.b #$c0, d0
033406: 00000000             ori.b #$0, d0
03340a: 00000c60             ori.b #$60, d0
03340e: 00000380             ori.b #$80, d0
033412: 00003838             ori.b #$38, d0
033416: 000007c0             ori.b #$c0, d0
03341a: 0000638c             ori.b #$8c, d0
03341e: 00001ff0             ori.b #$f0, d0
033422: 00004fe4             ori.b #$e4, d0
033426: 00003ff8             ori.b #$f8, d0
03342a: 0000dff6             ori.b #$f6, d0
03342e: 00003ff8             ori.b #$f8, d0
033432: 00009ff2             ori.b #$f2, d0
033436: 00007ffc             ori.b #$fc, d0
03343a: 00009ff2             ori.b #$f2, d0
03343e: 00007ffc             ori.b #$fc, d0
033442: 00009ff2             ori.b #$f2, d0
033446: 00007ffc             ori.b #$fc, d0
03344a: 00009ff2             ori.b #$f2, d0
03344e: 00007ffc             ori.b #$fc, d0
033452: 00009ff2             ori.b #$f2, d0
033456: 00007ffc             ori.b #$fc, d0
03345a: 0000cfe6             ori.b #$e6, d0
03345e: 00003ff8             ori.b #$f8, d0
033462: 0000438c             ori.b #$8c, d0
033466: 00003ff0             ori.b #$f0, d0
03346a: 00002018             ori.b #$18, d0
03346e: 00001fe0             ori.b #$e0, d0
033472: 00001c70             ori.b #$70, d0
033476: 00000380             ori.b #$80, d0
03347a: 000007c0             ori.b #$c0, d0
03347e: 00000000             ori.b #$0, d0
033482: 00000000             ori.b #$0, d0
033486: 00000000             ori.b #$0, d0
03348a: 00000000             ori.b #$0, d0
03348e: 00000000             ori.b #$0, d0
033492: 00000000             ori.b #$0, d0
033496: 00000000             ori.b #$0, d0
03349a: 00000440             ori.b #$40, d0
03349e: 00000000             ori.b #$0, d0
0334a2: 00000810             ori.b #$10, d0
0334a6: 00000420             ori.b #$20, d0
0334aa: 00001008             ori.b #$8, d0
0334ae: 00000830             ori.b #$30, d0
0334b2: 00001468             ori.b #$68, d0
0334b6: 00000c70             ori.b #$70, d0
0334ba: 000017e8             ori.b #$e8, d0
0334be: 00000ff0             ori.b #$f0, d0
0334c2: 000013c8             ori.b #$c8, d0
0334c6: 00000ff0             ori.b #$f0, d0
0334ca: 00000990             ori.b #$90, d0
0334ce: 000007e0             ori.b #$e0, d0
0334d2: 00000420             ori.b #$20, d0
0334d6: 000003c0             ori.b #$c0, d0
0334da: 000003c0             ori.b #$c0, d0
0334de: 00000000             ori.b #$0, d0
0334e2: 00000000             ori.b #$0, d0
0334e6: 00000000             ori.b #$0, d0
0334ea: 00000000             ori.b #$0, d0
0334ee: 00000000             ori.b #$0, d0
0334f2: 00000000             ori.b #$0, d0
0334f6: 00000000             ori.b #$0, d0
0334fa: 00000000             ori.b #$0, d0
0334fe: 00000000             ori.b #$0, d0
033502: 00000000             ori.b #$0, d0
033506: 00000000             ori.b #$0, d0
03350a: 00000000             ori.b #$0, d0
03350e: 00000000             ori.b #$0, d0
033512: 000003c0             ori.b #$c0, d0
033516: 00000000             ori.b #$0, d0
03351a: 00000030             ori.b #$30, d0
03351e: 00000040             ori.b #$40, d0
033522: 00001008             ori.b #$8, d0
033526: 00000070             ori.b #$70, d0
03352a: 00002068             ori.b #$68, d0
03352e: 00000070             ori.b #$70, d0
033532: 00002064             ori.b #$64, d0
033536: 00000078             ori.b #$78, d0
03353a: 00002064             ori.b #$64, d0
03353e: 00001078             ori.b #$78, d0
033542: 000028e4             ori.b #$e4, d0
033546: 000018f8             ori.b #$f8, d0
03354a: 000027e4             ori.b #$e4, d0
03354e: 00001ff8             ori.b #$f8, d0
033552: 000017c8             ori.b #$c8, d0
033556: 00000ff0             ori.b #$f0, d0
03355a: 00001008             ori.b #$8, d0
03355e: 00000ff0             ori.b #$f0, d0
033562: 00000c30             ori.b #$30, d0
033566: 000003c0             ori.b #$c0, d0
03356a: 000003c0             ori.b #$c0, d0
03356e: 00000000             ori.b #$0, d0
033572: 00000000             ori.b #$0, d0
033576: 00000000             ori.b #$0, d0
03357a: 00000000             ori.b #$0, d0
03357e: 00000000             ori.b #$0, d0
033582: 00000000             ori.b #$0, d0
033586: 00000000             ori.b #$0, d0
03358a: 00000000             ori.b #$0, d0
03358e: 00000000             ori.b #$0, d0
033592: 000007c0             ori.b #$c0, d0
033596: 00000000             ori.b #$0, d0
03359a: 00000830             ori.b #$30, d0
03359e: 000007c0             ori.b #$c0, d0
0335a2: 000000c8             ori.b #$c8, d0
0335a6: 000008f0             ori.b #$f0, d0
0335aa: 00000064             ori.b #$64, d0
0335ae: 00000078             ori.b #$78, d0
0335b2: 00002034             ori.b #$34, d0
0335b6: 00000038             ori.b #$38, d0
0335ba: 00000034             ori.b #$34, d0
0335be: 00000038             ori.b #$38, d0
0335c2: 00000034             ori.b #$34, d0
0335c6: 00000038             ori.b #$38, d0
0335ca: 00000034             ori.b #$34, d0
0335ce: 00000038             ori.b #$38, d0
0335d2: 00000034             ori.b #$34, d0
0335d6: 00000038             ori.b #$38, d0
0335da: 000010e8             ori.b #$e8, d0
0335de: 000000f0             ori.b #$f0, d0
0335e2: 00000808             ori.b #$8, d0
0335e6: 000007f0             ori.b #$f0, d0
0335ea: 000007f0             ori.b #$f0, d0
0335ee: 00000000             ori.b #$0, d0
0335f2: 00000000             ori.b #$0, d0
0335f6: 00000000             ori.b #$0, d0
0335fa: 00000000             ori.b #$0, d0
0335fe: 00000000             ori.b #$0, d0
033602: 00000000             ori.b #$0, d0
033606: 00000000             ori.b #$0, d0
03360a: 000003c0             ori.b #$c0, d0
03360e: 00000000             ori.b #$0, d0
033612: 00000c70             ori.b #$70, d0
033616: 00000380             ori.b #$80, d0
03361a: 00001008             ori.b #$8, d0
03361e: 00000ff0             ori.b #$f0, d0
033622: 00002064             ori.b #$64, d0
033626: 00001c78             ori.b #$78, d0
03362a: 00002010             ori.b #$10, d0
03362e: 0000101c             ori.b #$1c, d0
033632: 00004012             ori.b #$12, d0
033636: 0000201c             ori.b #$1c, d0
03363a: 0000400a             ori.b #$a, d0
03363e: 0000200c             ori.b #$c, d0
033642: 0000400a             ori.b #$a, d0
033646: 0000000c             ori.b #$c, d0
03364a: 0000000a             ori.b #$a, d0
03364e: 0000000c             ori.b #$c, d0
033652: 0000000c             ori.b #$c, d0
033656: 00000008             ori.b #$8, d0
03365a: 00000014             ori.b #$14, d0
03365e: 00000018             ori.b #$18, d0
033662: 00000008             ori.b #$8, d0
033666: 00000010             ori.b #$10, d0
03366a: 00000810             ori.b #$10, d0
03366e: 00000020             ori.b #$20, d0
033672: 000007e0             ori.b #$e0, d0
033676: 00000000             ori.b #$0, d0
03367a: 00000000             ori.b #$0, d0
03367e: 00000000             ori.b #$0, d0
033682: 00000000             ori.b #$0, d0
033686: 00000000             ori.b #$0, d0
03368a: 000007e0             ori.b #$e0, d0
03368e: 00000000             ori.b #$0, d0
033692: 00000810             ori.b #$10, d0
033696: 000007e0             ori.b #$e0, d0
03369a: 000013c8             ori.b #$c8, d0
03369e: 00000ff0             ori.b #$f0, d0
0336a2: 00002434             ori.b #$34, d0
0336a6: 00001c38             ori.b #$38, d0
0336aa: 0000080a             ori.b #$a, d0
0336ae: 0000380c             ori.b #$c, d0
0336b2: 00005000             ori.b #$0, d0
0336b6: 00003006             ori.b #$6, d0
0336ba: 00004000             ori.b #$0, d0
0336be: 00002006             ori.b #$6, d0
0336c2: 00004000             ori.b #$0, d0
0336c6: 00002002             ori.b #$2, d0
0336ca: 00004000             ori.b #$0, d0
0336ce: 00002002             ori.b #$2, d0
0336d2: 00000002             ori.b #$2, d0
0336d6: 00002000             ori.b #$0, d0
0336da: 00000002             ori.b #$2, d0
0336de: 00002000             ori.b #$0, d0
0336e2: 00000004             ori.b #$4, d0
0336e6: 00000000             ori.b #$0, d0
0336ea: 00000008             ori.b #$8, d0
0336ee: 00000000             ori.b #$0, d0
0336f2: 00000010             ori.b #$10, d0
0336f6: 00000000             ori.b #$0, d0
0336fa: 00000000             ori.b #$0, d0
0336fe: 00000000             ori.b #$0, d0
033702: 000007c0             ori.b #$c0, d0
033706: 00000000             ori.b #$0, d0
03370a: 00000860             ori.b #$60, d0
03370e: 00000780             ori.b #$80, d0
033712: 00002010             ori.b #$10, d0
033716: 00001c20             ori.b #$20, d0
03371a: 00004000             ori.b #$0, d0
03371e: 00003008             ori.b #$8, d0
033722: 00000004             ori.b #$4, d0
033726: 00006000             ori.b #$0, d0
03372a: 00008000             ori.b #$0, d0
03372e: 00004004             ori.b #$4, d0
033732: 00000002             ori.b #$2, d0
033736: 0000c000             ori.b #$0, d0
03373a: 00000002             ori.b #$2, d0
03373e: 00008000             ori.b #$0, d0
033742: 00000002             ori.b #$2, d0
033746: 00008000             ori.b #$0, d0
03374a: 00000002             ori.b #$2, d0
03374e: 00008000             ori.b #$0, d0
033752: 00008000             ori.b #$0, d0
033756: 00000000             ori.b #$0, d0
03375a: 00008000             ori.b #$0, d0
03375e: 00004000             ori.b #$0, d0
033762: 00004000             ori.b #$0, d0
033766: 00000000             ori.b #$0, d0
03376a: 00000000             ori.b #$0, d0
03376e: 00002008             ori.b #$8, d0
033772: 00001000             ori.b #$0, d0
033776: 00000800             ori.b #$0, d0
03377a: 00000780             ori.b #$80, d0
03377e: 00000000             ori.b #$0, d0
033782: 000007c0             ori.b #$c0, d0
033786: 000007c0             ori.b #$c0, d0
03378a: 00000fe0             ori.b #$e0, d0
03378e: 00000fe0             ori.b #$e0, d0
033792: 00003ff8             ori.b #$f8, d0
033796: 00003ff8             ori.b #$f8, d0
03379a: 00007ffc             ori.b #$fc, d0
03379e: 00007ffc             ori.b #$fc, d0
0337a2: 00007ffc             ori.b #$fc, d0
0337a6: 00007ffc             ori.b #$fc, d0
0337aa: 0000fffe             ori.b #$fe, d0
0337ae: 0000fffe             ori.b #$fe, d0
0337b2: 0000fffe             ori.b #$fe, d0
0337b6: 0000fffe             ori.b #$fe, d0
0337ba: 0000fffe             ori.b #$fe, d0
0337be: 0000fffe             ori.b #$fe, d0
0337c2: 0000fffe             ori.b #$fe, d0
0337c6: 0000fffe             ori.b #$fe, d0
0337ca: 0000fffe             ori.b #$fe, d0
0337ce: 0000fffe             ori.b #$fe, d0
0337d2: 0000fffe             ori.b #$fe, d0
0337d6: 0000fffe             ori.b #$fe, d0
0337da: 0000fffe             ori.b #$fe, d0
0337de: 0000fffe             ori.b #$fe, d0
0337e2: 00007ffc             ori.b #$fc, d0
0337e6: 00007ffc             ori.b #$fc, d0
0337ea: 00003ff8             ori.b #$f8, d0
0337ee: 00003ff8             ori.b #$f8, d0
0337f2: 00001ff0             ori.b #$f0, d0
0337f6: 00001ff0             ori.b #$f0, d0
0337fa: 000007c0             ori.b #$c0, d0
0337fe: 000007c0             ori.b #$c0, d0
033802: 00000000             ori.b #$0, d0
033806: 00000000             ori.b #$0, d0
03380a: 00000000             ori.b #$0, d0
03380e: 00000000             ori.b #$0, d0
033812: 00000000             ori.b #$0, d0
033816: 00000000             ori.b #$0, d0
03381a: 00000440             ori.b #$40, d0
03381e: 00000440             ori.b #$40, d0
033822: 00000c30             ori.b #$30, d0
033826: 00000c30             ori.b #$30, d0
03382a: 00001838             ori.b #$38, d0
03382e: 00001838             ori.b #$38, d0
033832: 00001c78             ori.b #$78, d0
033836: 00001c78             ori.b #$78, d0
03383a: 00001ff8             ori.b #$f8, d0
03383e: 00001ff8             ori.b #$f8, d0
033842: 00001ff8             ori.b #$f8, d0
033846: 00001ff8             ori.b #$f8, d0
03384a: 00000ff0             ori.b #$f0, d0
03384e: 00000ff0             ori.b #$f0, d0
033852: 000007e0             ori.b #$e0, d0
033856: 000007e0             ori.b #$e0, d0
03385a: 000003c0             ori.b #$c0, d0
03385e: 000003c0             ori.b #$c0, d0
033862: 00000000             ori.b #$0, d0
033866: 00000000             ori.b #$0, d0
03386a: 00000000             ori.b #$0, d0
03386e: 00000000             ori.b #$0, d0
033872: 00000000             ori.b #$0, d0
033876: 00000000             ori.b #$0, d0
03387a: 00000000             ori.b #$0, d0
03387e: 00000000             ori.b #$0, d0
033882: 00000000             ori.b #$0, d0
033886: 00000000             ori.b #$0, d0
03388a: 00000000             ori.b #$0, d0
03388e: 00000000             ori.b #$0, d0
033892: 000003c0             ori.b #$c0, d0
033896: 000003c0             ori.b #$c0, d0
03389a: 00000070             ori.b #$70, d0
03389e: 00000070             ori.b #$70, d0
0338a2: 00001078             ori.b #$78, d0
0338a6: 00001078             ori.b #$78, d0
0338aa: 00002078             ori.b #$78, d0
0338ae: 00002078             ori.b #$78, d0
0338b2: 0000207c             ori.b #$7c, d0
0338b6: 0000207c             ori.b #$7c, d0
0338ba: 0000307c             ori.b #$7c, d0
0338be: 0000307c             ori.b #$7c, d0
0338c2: 000038fc             ori.b #$fc, d0
0338c6: 000038fc             ori.b #$fc, d0
0338ca: 00003ffc             ori.b #$fc, d0
0338ce: 00003ffc             ori.b #$fc, d0
0338d2: 00001ff8             ori.b #$f8, d0
0338d6: 00001ff8             ori.b #$f8, d0
0338da: 00001ff8             ori.b #$f8, d0
0338de: 00001ff8             ori.b #$f8, d0
0338e2: 00000ff0             ori.b #$f0, d0
0338e6: 00000ff0             ori.b #$f0, d0
0338ea: 000003c0             ori.b #$c0, d0
0338ee: 000003c0             ori.b #$c0, d0
0338f2: 00000000             ori.b #$0, d0
0338f6: 00000000             ori.b #$0, d0
0338fa: 00000000             ori.b #$0, d0
0338fe: 00000000             ori.b #$0, d0
033902: 00000000             ori.b #$0, d0
033906: 00000000             ori.b #$0, d0
03390a: 00000000             ori.b #$0, d0
03390e: 00000000             ori.b #$0, d0
033912: 000007c0             ori.b #$c0, d0
033916: 000007c0             ori.b #$c0, d0
03391a: 00000ff0             ori.b #$f0, d0
03391e: 00000ff0             ori.b #$f0, d0
033922: 000008f8             ori.b #$f8, d0
033926: 000008f8             ori.b #$f8, d0
03392a: 0000007c             ori.b #$7c, d0
03392e: 0000007c             ori.b #$7c, d0
033932: 0000203c             ori.b #$3c, d0
033936: 0000203c             ori.b #$3c, d0
03393a: 0000003c             ori.b #$3c, d0
03393e: 0000003c             ori.b #$3c, d0
033942: 0000003c             ori.b #$3c, d0
033946: 0000003c             ori.b #$3c, d0
03394a: 0000003c             ori.b #$3c, d0
03394e: 0000003c             ori.b #$3c, d0
033952: 0000003c             ori.b #$3c, d0
033956: 0000003c             ori.b #$3c, d0
03395a: 000010f8             ori.b #$f8, d0
03395e: 000010f8             ori.b #$f8, d0
033962: 00000ff8             ori.b #$f8, d0
033966: 00000ff8             ori.b #$f8, d0
03396a: 000007f0             ori.b #$f0, d0
03396e: 000007f0             ori.b #$f0, d0
033972: 00000000             ori.b #$0, d0
033976: 00000000             ori.b #$0, d0
03397a: 00000000             ori.b #$0, d0
03397e: 00000000             ori.b #$0, d0
033982: 00000000             ori.b #$0, d0
033986: 00000000             ori.b #$0, d0
03398a: 000003c0             ori.b #$c0, d0
03398e: 000003c0             ori.b #$c0, d0
033992: 00000ff0             ori.b #$f0, d0
033996: 00000ff0             ori.b #$f0, d0
03399a: 00001ff8             ori.b #$f8, d0
03399e: 00001ff8             ori.b #$f8, d0
0339a2: 00003c7c             ori.b #$7c, d0
0339a6: 00003c7c             ori.b #$7c, d0
0339aa: 0000301c             ori.b #$1c, d0
0339ae: 0000301c             ori.b #$1c, d0
0339b2: 0000601e             ori.b #$1e, d0
0339b6: 0000601e             ori.b #$1e, d0
0339ba: 0000600e             ori.b #$e, d0
0339be: 0000600e             ori.b #$e, d0
0339c2: 0000400e             ori.b #$e, d0
0339c6: 0000400e             ori.b #$e, d0
0339ca: 0000000e             ori.b #$e, d0
0339ce: 0000000e             ori.b #$e, d0
0339d2: 0000000c             ori.b #$c, d0
0339d6: 0000000c             ori.b #$c, d0
0339da: 0000001c             ori.b #$1c, d0
0339de: 0000001c             ori.b #$1c, d0
0339e2: 00000018             ori.b #$18, d0
0339e6: 00000018             ori.b #$18, d0
0339ea: 00000830             ori.b #$30, d0
0339ee: 00000830             ori.b #$30, d0
0339f2: 000007e0             ori.b #$e0, d0
0339f6: 000007e0             ori.b #$e0, d0
0339fa: 00000000             ori.b #$0, d0
0339fe: 00000000             ori.b #$0, d0
033a02: 00000000             ori.b #$0, d0
033a06: 00000000             ori.b #$0, d0
033a0a: 000007e0             ori.b #$e0, d0
033a0e: 000007e0             ori.b #$e0, d0
033a12: 00000ff0             ori.b #$f0, d0
033a16: 00000ff0             ori.b #$f0, d0
033a1a: 00001ff8             ori.b #$f8, d0
033a1e: 00001ff8             ori.b #$f8, d0
033a22: 00003c3c             ori.b #$3c, d0
033a26: 00003c3c             ori.b #$3c, d0
033a2a: 0000380e             ori.b #$e, d0
033a2e: 0000380e             ori.b #$e, d0
033a32: 00007006             ori.b #$6, d0
033a36: 00007006             ori.b #$6, d0
033a3a: 00006006             ori.b #$6, d0
033a3e: 00006006             ori.b #$6, d0
033a42: 00006002             ori.b #$2, d0
033a46: 00006002             ori.b #$2, d0
033a4a: 00006002             ori.b #$2, d0
033a4e: 00006002             ori.b #$2, d0
033a52: 00002002             ori.b #$2, d0
033a56: 00002002             ori.b #$2, d0
033a5a: 00002002             ori.b #$2, d0
033a5e: 00002002             ori.b #$2, d0
033a62: 00000004             ori.b #$4, d0
033a66: 00000004             ori.b #$4, d0
033a6a: 00000008             ori.b #$8, d0
033a6e: 00000008             ori.b #$8, d0
033a72: 00000010             ori.b #$10, d0
033a76: 00000010             ori.b #$10, d0
033a7a: 00000000             ori.b #$0, d0
033a7e: 00000000             ori.b #$0, d0
033a82: 000007c0             ori.b #$c0, d0
033a86: 000007c0             ori.b #$c0, d0
033a8a: 00000fe0             ori.b #$e0, d0
033a8e: 00000fe0             ori.b #$e0, d0
033a92: 00003c30             ori.b #$30, d0
033a96: 00003c30             ori.b #$30, d0
033a9a: 00007008             ori.b #$8, d0
033a9e: 00007008             ori.b #$8, d0
033aa2: 00006004             ori.b #$4, d0
033aa6: 00006004             ori.b #$4, d0
033aaa: 0000c004             ori.b #$4, d0
033aae: 0000c004             ori.b #$4, d0
033ab2: 0000c002             ori.b #$2, d0
033ab6: 0000c002             ori.b #$2, d0
033aba: 00008002             ori.b #$2, d0
033abe: 00008002             ori.b #$2, d0
033ac2: 00008002             ori.b #$2, d0
033ac6: 00008002             ori.b #$2, d0
033aca: 00008002             ori.b #$2, d0
033ace: 00008002             ori.b #$2, d0
033ad2: 00008000             ori.b #$0, d0
033ad6: 00008000             ori.b #$0, d0
033ada: 0000c000             ori.b #$0, d0
033ade: 0000c000             ori.b #$0, d0
033ae2: 00004000             ori.b #$0, d0
033ae6: 00004000             ori.b #$0, d0
033aea: 00002008             ori.b #$8, d0
033aee: 00002008             ori.b #$8, d0
033af2: 00001800             ori.b #$0, d0
033af6: 00001800             ori.b #$0, d0
033afa: 00000780             ori.b #$80, d0
033afe: 00000780             ori.b #$80, d0
033b02: 00000000             ori.b #$0, d0
033b06: 00000000             ori.b #$0, d0
033b0a: 00000000             ori.b #$0, d0
033b0e: 00000000             ori.b #$0, d0
033b12: 00000000             ori.b #$0, d0
033b16: 00000000             ori.b #$0, d0
033b1a: 00000000             ori.b #$0, d0
033b1e: 00000000             ori.b #$0, d0
033b22: 00000000             ori.b #$0, d0
033b26: 00000000             ori.b #$0, d0
033b2a: 00000000             ori.b #$0, d0
033b2e: 00000000             ori.b #$0, d0
033b32: 00000000             ori.b #$0, d0
033b36: 00000000             ori.b #$0, d0
033b3a: 00000000             ori.b #$0, d0
033b3e: 00000000             ori.b #$0, d0
033b42: 00000000             ori.b #$0, d0
033b46: 00000000             ori.b #$0, d0
033b4a: 00000000             ori.b #$0, d0
033b4e: 00000000             ori.b #$0, d0
033b52: 00000000             ori.b #$0, d0
033b56: 00000000             ori.b #$0, d0
033b5a: 00000000             ori.b #$0, d0
033b5e: 00000000             ori.b #$0, d0
033b62: 0000                 ori.b #$aa, d0
