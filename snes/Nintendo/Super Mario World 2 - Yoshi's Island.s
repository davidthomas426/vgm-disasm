; Yoshi's Island - loveemu labo
; Disassembler: spcdas v0.01
; 
; some other infos available at:
; http://boldkey.hp.infoseek.co.jp/

0400: 20        clrp
0401: cd cf     mov   x,#$cf
0403: bd        mov   sp,x              ; set SP to (01)cf
0404: e8 00     mov   a,#$00
0406: 5d        mov   x,a
0407: af        mov   (x)+,a
0408: c8 e0     cmp   x,#$e0
040a: d0 fb     bne   $0407             ; zero 00-e0
040c: cd 00     mov   x,#$00
040e: d5 00 02  mov   $0200+x,a
0411: 3d        inc   x
0412: d0 fa     bne   $040e             ; zero 0200-02ff
0414: d5 00 03  mov   $0300+x,a
0417: 3d        inc   x
0418: d0 fa     bne   $0414             ; zero 0300-03ff
041a: bc        inc   a
041b: 3f 96 0a  call  $0a96             ; set echo delay to 1 (16ms)
041e: a2 48     set5  $48
0420: e8 60     mov   a,#$60
0422: 8d 0c     mov   y,#$0c
0424: 3f fa 05  call  $05fa             ; master vol L = $60
0427: 8d 1c     mov   y,#$1c
0429: 3f fa 05  call  $05fa             ; master vol R = $60
042c: e8 3c     mov   a,#$3c
042e: 8d 5d     mov   y,#$5d
0430: 3f fa 05  call  $05fa             ; source dir = $3c00
0433: e8 f0     mov   a,#$f0
0435: c5 f1 00  mov   $00f1,a           ; reset ports, disable timers
0438: e8 10     mov   a,#$10
043a: c5 fa 00  mov   $00fa,a           ; set timer0 latch to #$10 (500 Hz, 2ms)
043d: c4 53     mov   $53,a
043f: e8 01     mov   a,#$01
0441: c5 f1 00  mov   $00f1,a           ; start timer0
; main loop
0444: 8d 0a     mov   y,#$0a            ; set DSP regs from shadow:
0446: ad 05     cmp   y,#$05
0448: f0 07     beq   $0451
044a: b0 08     bcs   $0454
044c: 69 4d 4c  cmp   ($4c),($4d)
044f: d0 11     bne   $0462
0451: e3 4c 0e  bbs7  $4c,$0462
0454: f6 1d 0e  mov   a,$0e1d+y
0457: c5 f2 00  mov   $00f2,a
045a: f6 27 0e  mov   a,$0e27+y
045d: 5d        mov   x,a
045e: e6        mov   a,(x)
045f: c5 f3 00  mov   $00f3,a           ; write to DSP reg
0462: fe e2     dbnz  y,$0446           ; loop for each reg
0464: cb 45     mov   $45,y
0466: cb 46     mov   $46,y
0468: e4 18     mov   a,$18
046a: 44 19     eor   a,$19
046c: 5c        lsr   a
046d: 5c        lsr   a
046e: ed        notc
046f: 6b 18     ror   $18
0471: 6b 19     ror   $19
0473: ec fd 00  mov   y,$00fd           ; wait for counter0 increment
0476: f0 fb     beq   $0473
0478: 6d        push  y
0479: e8 38     mov   a,#$38
047b: cf        mul   ya
047c: 60        clrc
047d: 84 43     adc   a,$43
047f: c4 43     mov   $43,a
0481: 90 23     bcc   $04a6
0483: 3f dc 1e  call  $1edc
0486: cd 01     mov   x,#$01
0488: 3f da 04  call  $04da
048b: cd 02     mov   x,#$02
048d: 3f da 04  call  $04da
0490: 3f 37 21  call  $2137
0493: 3f 66 20  call  $2066
0496: 69 4d 4c  cmp   ($4c),($4d)
0499: f0 0b     beq   $04a6
049b: ac c7 03  inc   $03c7
049e: e5 c7 03  mov   a,$03c7
04a1: 5c        lsr   a
04a2: b0 02     bcs   $04a6
04a4: ab 4c     inc   $4c
04a6: e4 53     mov   a,$53
04a8: ee        pop   y
04a9: cf        mul   ya
04aa: 60        clrc
04ab: 84 51     adc   a,$51
04ad: c4 51     mov   $51,a
04af: 90 10     bcc   $04c1
04b1: e5 f8 03  mov   a,$03f8
04b4: d0 08     bne   $04be
04b6: 3f 54 07  call  $0754
04b9: cd 00     mov   x,#$00
04bb: 3f eb 04  call  $04eb
04be: 5f 44 04  jmp   $0444

04c1: e4 04     mov   a,$04
04c3: f0 12     beq   $04d7
04c5: cd 00     mov   x,#$00
04c7: 8f 01 47  mov   $47,#$01
04ca: f4 31     mov   a,$31+x
04cc: f0 03     beq   $04d1
04ce: 3f 46 0d  call  $0d46
04d1: 3d        inc   x
04d2: 3d        inc   x
04d3: 0b 47     asl   $47
04d5: d0 f3     bne   $04ca
04d7: 5f 44 04  jmp   $0444

04da: f4 04     mov   a,$04+x
04dc: d5 f4 00  mov   $00f4+x,a
04df: f5 f4 00  mov   a,$00f4+x
04e2: 75 f4 00  cmp   a,$00f4+x
04e5: d0 f8     bne   $04df
04e7: fd        mov   y,a
04e8: db 00     mov   $00+x,y
04ea: 6f        ret

04eb: f4 04     mov   a,$04+x
04ed: d5 f4 00  mov   $00f4+x,a
04f0: f5 f4 00  mov   a,$00f4+x
04f3: 75 f4 00  cmp   a,$00f4+x
04f6: d0 f8     bne   $04f0
04f8: fd        mov   y,a
04f9: f4 08     mov   a,$08+x
04fb: db 08     mov   $08+x,y
04fd: de 08 02  cbne  $08+x,$0502
0500: 8d 00     mov   y,#$00
0502: db 00     mov   $00+x,y
0504: 6f        ret

; handle a note vcmd (80-df)
0505: ad ca     cmp   y,#$ca
0507: 90 05     bcc   $050e
; vcmds ca-df - percussion note
0509: 3f b1 08  call  $08b1             ; set sample
050c: 8d a4     mov   y,#$a4            ; dispatch as note $a4
; vcmds 80-c7,c8,c9 - note/tie/rest
050e: ad c8     cmp   y,#$c8
0510: b0 d8     bcs   $04ea             ; skip if tie/rest
0512: e4 1a     mov   a,$1a
0514: 24 47     and   a,$47
0516: d0 d2     bne   $04ea
; vcmds 80-c7 - note (note number in Y)
0518: dd        mov   a,y
0519: 28 7f     and   a,#$7f
051b: 60        clrc
051c: 84 50     adc   a,$50             ; add global transpose
051e: 60        clrc
051f: 95 f0 02  adc   a,$02f0+x         ; add per-voice transpose
0522: d5 61 03  mov   $0361+x,a
0525: f5 81 03  mov   a,$0381+x
0528: d5 60 03  mov   $0360+x,a
052b: f5 b1 02  mov   a,$02b1+x
052e: 5c        lsr   a
052f: e8 00     mov   a,#$00
0531: 7c        ror   a
0532: d5 a0 02  mov   $02a0+x,a
0535: e8 00     mov   a,#$00
0537: d4 b0     mov   $b0+x,a
0539: d5 00 01  mov   $0100+x,a
053c: d5 d0 02  mov   $02d0+x,a
053f: d4 c0     mov   $c0+x,a
0541: 09 47 5e  or    ($5e),($47)       ; set volume changed flg
0544: 09 47 45  or    ($45),($47)       ; set key on shadow bit
0547: f5 80 02  mov   a,$0280+x         ; pitch envelope counter
054a: d4 a0     mov   $a0+x,a           ; portamento counter
054c: f0 1e     beq   $056c
054e: f5 81 02  mov   a,$0281+x
0551: d4 a1     mov   $a1+x,a
0553: f5 90 02  mov   a,$0290+x         ; pitch envelope mode (0:attack / 1:release)
0556: d0 0a     bne   $0562
0558: f5 61 03  mov   a,$0361+x
055b: 80        setc
055c: b5 91 02  sbc   a,$0291+x
055f: d5 61 03  mov   $0361+x,a
0562: f5 91 02  mov   a,$0291+x
0565: 60        clrc
; set DSP pitch from $10/1
0566: 95 61 03  adc   a,$0361+x
0569: 3f 1d 0b  call  $0b1d
056c: 3f 35 0b  call  $0b35
056f: 8d 00     mov   y,#$00
0571: e4 11     mov   a,$11
0573: 80        setc
0574: a8 34     sbc   a,#$34
0576: b0 09     bcs   $0581
0578: e4 11     mov   a,$11
057a: 80        setc
057b: a8 13     sbc   a,#$13
057d: b0 06     bcs   $0585
057f: dc        dec   y
0580: 1c        asl   a
0581: 7a 10     addw  ya,$10
0583: da 10     movw  $10,ya
0585: 4d        push  x
0586: e4 11     mov   a,$11
; get pitch from note number in A (with octave correction)
0588: 1c        asl   a
0589: 8d 00     mov   y,#$00
058b: cd 18     mov   x,#$18
058d: 9e        div   ya,x
058e: 5d        mov   x,a
058f: f6 33 0e  mov   a,$0e33+y
0592: c4 15     mov   $15,a
0594: f6 32 0e  mov   a,$0e32+y
0597: c4 14     mov   $14,a             ; set $14/5 from pitch table
0599: f6 35 0e  mov   a,$0e35+y
059c: 2d        push  a
059d: f6 34 0e  mov   a,$0e34+y
05a0: ee        pop   y
05a1: 9a 14     subw  ya,$14
05a3: eb 10     mov   y,$10
05a5: cf        mul   ya
05a6: dd        mov   a,y
05a7: 8d 00     mov   y,#$00
05a9: 7a 14     addw  ya,$14
05ab: cb 15     mov   $15,y
05ad: 1c        asl   a
05ae: 2b 15     rol   $15
05b0: c4 14     mov   $14,a
05b2: 2f 04     bra   $05b8
05b4: 4b 15     lsr   $15
05b6: 7c        ror   a
05b7: 3d        inc   x
05b8: c8 06     cmp   x,#$06
05ba: d0 f8     bne   $05b4
05bc: c4 14     mov   $14,a
05be: ce        pop   x
05bf: f5 20 02  mov   a,$0220+x
05c2: eb 15     mov   y,$15
05c4: cf        mul   ya
05c5: da 16     movw  $16,ya
05c7: f5 20 02  mov   a,$0220+x
05ca: eb 14     mov   y,$14
05cc: cf        mul   ya
05cd: 6d        push  y
05ce: f5 21 02  mov   a,$0221+x
05d1: eb 14     mov   y,$14
05d3: cf        mul   ya
05d4: 7a 16     addw  ya,$16
05d6: da 16     movw  $16,ya
05d8: f5 21 02  mov   a,$0221+x
05db: eb 15     mov   y,$15
05dd: cf        mul   ya
05de: fd        mov   y,a
05df: ae        pop   a
05e0: 7a 16     addw  ya,$16
05e2: da 16     movw  $16,ya
05e4: 7d        mov   a,x               ; set voice X pitch DSP reg from $16/7
05e5: 9f        xcn   a                 ;  (if vbit clear in $1a)
05e6: 5c        lsr   a
05e7: 08 02     or    a,#$02
05e9: fd        mov   y,a               ; Y = voice X pitch DSP reg
05ea: e4 16     mov   a,$16
05ec: 3f f2 05  call  $05f2
05ef: fc        inc   y
05f0: e4 17     mov   a,$17
; write A to DSP reg Y if vbit clear in $1a
05f2: 2d        push  a
05f3: e4 47     mov   a,$47
05f5: 24 1a     and   a,$1a
05f7: ae        pop   a
05f8: d0 06     bne   $0600
; write A to DSP reg Y
05fa: cc f2 00  mov   $00f2,y
05fd: c5 f3 00  mov   $00f3,a
0600: 6f        ret

0601: e8 00     mov   a,#$00
0603: 8d 2c     mov   y,#$2c
0605: 3f fa 05  call  $05fa
0608: 8d 3c     mov   y,#$3c
060a: 3f fa 05  call  $05fa
060d: e8 ff     mov   a,#$ff
060f: 8d 5c     mov   y,#$5c
0611: 3f fa 05  call  $05fa
0614: 3f 57 0e  call  $0e57
0617: e8 00     mov   a,#$00
0619: c5 ca 03  mov   $03ca,a
061c: c4 04     mov   $04,a
061e: c5 05 00  mov   $0005,a
0621: c5 06 00  mov   $0006,a
0624: c5 07 00  mov   $0007,a
0627: c4 1a     mov   $1a,a
0629: 8d 10     mov   y,#$10
062b: d6 9f 03  mov   $039f+y,a
062e: fe fb     dbnz  y,$062b
0630: 6f        ret

0631: 78 11 04  cmp   $04,#$11
0634: f0 13     beq   $0649
0636: cd 40     mov   x,#$40
0638: d8 5a     mov   $5a,x
063a: c9 ca 03  mov   $03ca,x
063d: e8 00     mov   a,#$00
063f: c4 5b     mov   $5b,a
0641: 80        setc
0642: a4 59     sbc   a,$59
0644: 3f 40 0b  call  $0b40
0647: da 5c     movw  $5c,ya
0649: 5f 5b 07  jmp   $075b

064c: e5 f1 03  mov   a,$03f1
064f: d0 1e     bne   $066f
0651: e4 59     mov   a,$59
0653: c5 f1 03  mov   $03f1,a
0656: e8 70     mov   a,#$70
0658: c4 59     mov   $59,a
065a: 5f 5b 07  jmp   $075b

065d: e5 f1 03  mov   a,$03f1
0660: f0 0d     beq   $066f
0662: e5 f1 03  mov   a,$03f1
0665: c4 59     mov   $59,a
0667: e8 00     mov   a,#$00
0669: c5 f1 03  mov   $03f1,a
066c: 5f 5b 07  jmp   $075b

066f: 6f        ret

0670: 68 ff     cmp   a,#$ff
0672: f0 8d     beq   $0601
0674: 68 f1     cmp   a,#$f1
0676: f0 b9     beq   $0631
0678: 68 f2     cmp   a,#$f2
067a: f0 d0     beq   $064c
067c: 68 f3     cmp   a,#$f3
067e: f0 dd     beq   $065d
0680: 68 f4     cmp   a,#$f4
0682: f0 23     beq   $06a7
0684: 68 f5     cmp   a,#$f5
0686: f0 18     beq   $06a0
0688: 68 f6     cmp   a,#$f6
068a: f0 09     beq   $0695
068c: 68 f0     cmp   a,#$f0
068e: f0 33     beq   $06c3
0690: 68 14     cmp   a,#$14
0692: 90 51     bcc   $06e5
0694: 6f        ret

0695: e5 cf 03  mov   a,$03cf
0698: c4 53     mov   $53,a
069a: 8f 00 54  mov   $54,#$00
069d: 5f 5b 07  jmp   $075b

06a0: 8f ef 54  mov   $54,#$ef
06a3: e8 44     mov   a,#$44
06a5: d0 05     bne   $06ac
06a7: 8f 8f 54  mov   $54,#$8f
06aa: e8 16     mov   a,#$16
06ac: c4 55     mov   $55,a
06ae: 80        setc
06af: a4 53     sbc   a,$53
06b1: f8 54     mov   x,$54
06b3: 3f 40 0b  call  $0b40
06b6: da 56     movw  $56,ya
06b8: 5f 5b 07  jmp   $075b

06bb: 8c ca 03  dec   $03ca
06be: f0 03     beq   $06c3
06c0: 5f 67 07  jmp   $0767

06c3: e4 1a     mov   a,$1a
06c5: 48 ff     eor   a,#$ff
06c7: 0e 46 00  tset1 $0046
06ca: 8f 00 04  mov   $04,#$00
06cd: 8f 00 47  mov   $47,#$00
06d0: 8f c0 59  mov   $59,#$c0
06d3: 8f 20 53  mov   $53,#$20
06d6: 6f        ret

; read $40/1 into YA with advancing the ptr
06d7: 8d 00     mov   y,#$00
06d9: f7 40     mov   a,($40)+y
06db: 3a 40     incw  $40
06dd: 2d        push  a
06de: f7 40     mov   a,($40)+y
06e0: 3a 40     incw  $40
06e2: fd        mov   y,a
06e3: ae        pop   a
06e4: 6f        ret

; play song in A
06e5: 60        clrc
06e6: cd 00     mov   x,#$00
06e8: c9 ca 03  mov   $03ca,x
06eb: c9 f1 03  mov   $03f1,x
06ee: c4 04     mov   $04,a
06f0: 1c        asl   a
06f1: 5d        mov   x,a
06f2: f5 8f ff  mov   a,$ff8f+x
06f5: fd        mov   y,a
06f6: d0 03     bne   $06fb
06f8: c4 04     mov   $04,a
06fa: 6f        ret
06fb: f5 8e ff  mov   a,$ff8e+x
06fe: da 40     movw  $40,ya
0700: 8f 02 0c  mov   $0c,#$02
0703: e4 1a     mov   a,$1a
0705: 48 ff     eor   a,#$ff
0707: 0e 46 00  tset1 $0046
070a: 6f        ret

; reset song params
070b: cd 0e     mov   x,#$0e
070d: 8f 80 47  mov   $47,#$80          ; last voice
0710: e4 47     mov   a,$47
0712: 24 1a     and   a,$1a
0714: 28 c0     and   a,#$c0
0716: d0 23     bne   $073b
0718: e8 ff     mov   a,#$ff
071a: d5 01 03  mov   $0301+x,a         ; voice volume = $ff
071d: e8 0a     mov   a,#$0a
071f: 3f 0a 09  call  $090a             ; pan = $0a.00
0722: d5 11 02  mov   $0211+x,a         ; zero instrument
0725: d5 81 03  mov   $0381+x,a
0728: d5 f0 02  mov   $02f0+x,a
072b: d5 80 02  mov   $0280+x,a
072e: d5 e1 03  mov   $03e1+x,a
0731: d5 e0 03  mov   $03e0+x,a
0734: d5 d0 03  mov   $03d0+x,a
0737: d4 b1     mov   $b1+x,a
0739: d4 c1     mov   $c1+x,a
073b: 1d        dec   x
073c: 1d        dec   x
073d: 4b 47     lsr   $47
073f: d0 cf     bne   $0710             ; loop for each voice
0741: c4 5a     mov   $5a,a             ; zero master vol fade counter
0743: c4 68     mov   $68,a             ; zero echo vol fade counter
0745: c4 54     mov   $54,a             ; zero tempo fade counter
0747: c4 50     mov   $50,a             ; zero global transpose
0749: c4 42     mov   $42,a             ; zero block repeat count
074b: c4 5f     mov   $5f,a             ; 
074d: 8f c0 59  mov   $59,#$c0          ; master vol
0750: 8f 20 53  mov   $53,#$20          ; tempo
0753: 6f        ret

0754: e4 00     mov   a,$00
0756: f0 03     beq   $075b
0758: 5f 70 06  jmp   $0670

075b: e4 04     mov   a,$04
075d: f0 f4     beq   $0753
075f: e5 ca 03  mov   a,$03ca
0762: f0 03     beq   $0767
0764: 5f bb 06  jmp   $06bb

0767: e4 0c     mov   a,$0c
0769: f0 59     beq   $07c4
;
076b: 6e 0c 9d  dbnz  $0c,$070b
076e: 3f d7 06  call  $06d7             ; read block addr from $40/1, advance ptr
0771: d0 17     bne   $078a             ; load start addresses, if hi-byte is non zero
0773: fd        mov   y,a               ; refetch lo-byte
0774: d0 03     bne   $0779             ; set/dec repeat count
0776: 5f c3 06  jmp   $06c3             ; key off, return if also zero
; set/dec repeat count
0779: 8b 42     dec   $42
077b: 10 02     bpl   $077f
077d: c4 42     mov   $42,a
077f: 3f d7 06  call  $06d7             ; read next word as well
0782: f8 42     mov   x,$42
0784: f0 e8     beq   $076e
0786: da 40     movw  $40,ya            ;   "goto" that address
0788: 2f e4     bra   $076e             ; continue
; load start addresses - hi-byte not zero
078a: da 16     movw  $16,ya
078c: 8d 0f     mov   y,#$0f
078e: f7 16     mov   a,($16)+y
0790: d6 30 00  mov   $0030+y,a
0793: dc        dec   y
0794: 10 f8     bpl   $078e             ; set all reading ptrs
0796: cd 00     mov   x,#$00
0798: 8f 01 47  mov   $47,#$01          ; first voice
079b: f4 31     mov   a,$31+x
079d: f0 0a     beq   $07a9             ; if vptr hi != 0
079f: f5 11 02  mov   a,$0211+x
07a2: d0 05     bne   $07a9
07a4: e8 00     mov   a,#$00
07a6: 3f b1 08  call  $08b1             ; set instrument #0 if not set
07a9: e8 00     mov   a,#$00
07ab: d4 80     mov   $80+x,a           ; zero subroutine repeat counter
07ad: 2d        push  a
07ae: e4 47     mov   a,$47
07b0: 24 1a     and   a,$1a
07b2: 28 c0     and   a,#$c0
07b4: ae        pop   a
07b5: d0 04     bne   $07bb
07b7: d4 91     mov   $91+x,a           ; zero pan fade counter
07b9: d4 90     mov   $90+x,a           ; zero voice vol fade counter
07bb: bc        inc   a
07bc: d4 70     mov   $70+x,a           ; set duration counter to 1
07be: 3d        inc   x
07bf: 3d        inc   x
07c0: 0b 47     asl   $47               ; next voice
07c2: d0 d7     bne   $079b             ; foreach voice
;
07c4: cd 00     mov   x,#$00
07c6: d8 5e     mov   $5e,x
07c8: 8f 01 47  mov   $47,#$01          ; first voice
07cb: d8 44     mov   $44,x
07cd: f4 31     mov   a,$31+x
07cf: f0 6e     beq   $083f             ; next if vptr hi zero
07d1: 9b 70     dec   $70+x             ; dec duration counter
07d3: d0 64     bne   $0839             ; if not zero, skip to voice readahead
07d5: 3f a7 08  call  $08a7             ; read vcmd into A and Y
07d8: d0 17     bne   $07f1
; vcmd 00 - end repeat/return
07da: f4 80     mov   a,$80+x
07dc: f0 90     beq   $076e             ; read next block if loop has been done
; repeat / return from subroutine
07de: 3f 2b 0a  call  $0a2b             ; jump to loop start addr
07e1: 9b 80     dec   $80+x             ; dec repeat count
07e3: d0 f0     bne   $07d5             ; if the loop has been done
07e5: f5 30 02  mov   a,$0230+x
07e8: d4 30     mov   $30+x,a
07ea: f5 31 02  mov   a,$0231+x
07ed: d4 31     mov   $31+x,a           ; back to return addr instead
07ef: 2f e4     bra   $07d5             ; then continue
; vcmd branches
07f1: 30 20     bmi   $0813             ; vcmds 01-7f - note info:
07f3: d5 00 02  mov   $0200+x,a         ;   set cmd as duration
07f6: 3f a7 08  call  $08a7             ;   read next byte
07f9: 30 18     bmi   $0813             ;   if note note then
07fb: 2d        push  a
07fc: 9f        xcn   a
07fd: 28 07     and   a,#$07
07ff: fd        mov   y,a
0800: f6 e8 3f  mov   a,$3fe8+y
0803: d5 01 02  mov   $0201+x,a         ;   set dur% from high nybble
0806: ae        pop   a
0807: 28 0f     and   a,#$0f
0809: fd        mov   y,a
080a: f6 f0 3f  mov   a,$3ff0+y
080d: d5 10 02  mov   $0210+x,a         ;   set per-note vol from low nybble
0810: 3f a7 08  call  $08a7             ;   read vcmd into A and Y
; vcmd branches 80-ff
0813: 68 e0     cmp   a,#$e0
0815: 90 05     bcc   $081c
0817: 3f 95 08  call  $0895             ; vcmds e0-ff
081a: 2f b9     bra   $07d5
; vcmds 80-df - note
081c: 2d        push  a
081d: e4 47     mov   a,$47
081f: 24 1a     and   a,$1a
0821: ae        pop   a
0822: d0 03     bne   $0827
0824: 3f 05 05  call  $0505             ; handle note cmd if vbit $1a clear
0827: f5 00 02  mov   a,$0200+x
082a: d4 70     mov   $70+x,a           ; set duration counter from duration
082c: fd        mov   y,a
082d: f5 01 02  mov   a,$0201+x
0830: cf        mul   ya
0831: dd        mov   a,y
0832: d0 01     bne   $0835
0834: bc        inc   a
0835: d4 71     mov   $71+x,a           ; set actual key-off dur counter
0837: 2f 03     bra   $083c
0839: 3f 67 0c  call  $0c67             ; do readahead
083c: 3f ec 0a  call  $0aec
083f: 3d        inc   x
0840: 3d        inc   x
0841: 0b 47     asl   $47
0843: f0 03     beq   $0848
0845: 5f cb 07  jmp   $07cb

0848: e4 54     mov   a,$54             ; tempo fade counter
084a: f0 0b     beq   $0857
084c: ba 56     movw  ya,$56
084e: 7a 52     addw  ya,$52            ; add tempo fade to tempo
0850: 6e 54 02  dbnz  $54,$0855
0853: ba 54     movw  ya,$54            ; last time: move tempo target to tempo
0855: da 52     movw  $52,ya
0857: e4 68     mov   a,$68             ; echo vol fade counter
0859: f0 15     beq   $0870
085b: ba 64     movw  ya,$64
085d: 7a 60     addw  ya,$60
085f: da 60     movw  $60,ya            ; add echo L delta to echo L vol
0861: ba 66     movw  ya,$66
0863: 7a 62     addw  ya,$62            ; add echo R delta to echo R vol
0865: 6e 68 06  dbnz  $68,$086e
0868: ba 68     movw  ya,$68
086a: da 60     movw  $60,ya
086c: eb 6a     mov   y,$6a
086e: da 62     movw  $62,ya
0870: e4 5a     mov   a,$5a             ; master vol fade counter
0872: f0 0e     beq   $0882
0874: ba 5c     movw  ya,$5c
0876: 7a 58     addw  ya,$58            ; add master vol delta to value
0878: 6e 5a 02  dbnz  $5a,$087d
087b: ba 5a     movw  ya,$5a
087d: da 58     movw  $58,ya
087f: 8f ff 5e  mov   $5e,#$ff          ; set all vol chg flags
0882: cd 00     mov   x,#$00
0884: 8f 01 47  mov   $47,#$01          ; first voice
0887: f4 31     mov   a,$31+x
0889: f0 03     beq   $088e
088b: 3f ad 0b  call  $0bad             ; do per-voice fades
088e: 3d        inc   x
088f: 3d        inc   x
0890: 0b 47     asl   $47
0892: d0 f3     bne   $0887
0894: 6f        ret

; dispatch vcmd in A (e0-ff)
0895: 1c        asl   a                 ; e0-ff => c0-fe (8 bit)
0896: fd        mov   y,a
0897: f6 9d 0a  mov   a,$0a9d+y
089a: 2d        push  a
089b: f6 9c 0a  mov   a,$0a9c+y
089e: 2d        push  a                 ; push jump address from table
089f: dd        mov   a,y
08a0: 5c        lsr   a
08a1: fd        mov   y,a
08a2: f6 32 0b  mov   a,$0b32+y         ; vcmd length
08a5: f0 08     beq   $08af             ; if non zero
; read new argument to A and Y
08a7: e7 30     mov   a,($30+x)
; advance reading ptr
08a9: bb 30     inc   $30+x
08ab: d0 02     bne   $08af
08ad: bb 31     inc   $31+x             ; inc reading ptr
08af: fd        mov   y,a
08b0: 6f        ret                     ; jump to vcmd

; vcmd e0 - set instrument
08b1: d5 11 02  mov   $0211+x,a
08b4: fd        mov   y,a
08b5: 10 06     bpl   $08bd             ; if percussion note:
08b7: 80        setc
08b8: a8 ca     sbc   a,#$ca            ;   ca-dd => 00-15
08ba: 60        clrc
08bb: 84 5f     adc   a,$5f             ; add perc patch base
08bd: 8d 06     mov   y,#$06
; set sample A in bank at $14/5 width Y
08bf: cf        mul   ya
08c0: da 14     movw  $14,ya
08c2: 60        clrc
08c3: 98 00 14  adc   $14,#$00
08c6: 98 3d 15  adc   $15,#$3d
08c9: e4 1a     mov   a,$1a
08cb: 24 47     and   a,$47
08cd: d0 3a     bne   $0909
08cf: 4d        push  x
08d0: 7d        mov   a,x
08d1: 9f        xcn   a
08d2: 5c        lsr   a
08d3: 08 04     or    a,#$04            ; voice X SRCN
08d5: 5d        mov   x,a
08d6: 8d 00     mov   y,#$00
08d8: f7 14     mov   a,($14)+y
08da: 10 0e     bpl   $08ea
08dc: 28 1f     and   a,#$1f            ; sample > 80: noise, freq in low bits
08de: 38 20 48  and   $48,#$20          ;  keep echo bit from FLG
08e1: 0e 48 00  tset1 $0048             ;  OR in noise freq
08e4: 09 47 49  or    ($49),($47)       ;  set vbit in noise enable
08e7: dd        mov   a,y               ;  set SRCN to 0
08e8: 2f 07     bra   $08f1             ; else
08ea: e4 47     mov   a,$47
08ec: 4e 49 00  tclr1 $0049             ;  clear noise vbit
08ef: f7 14     mov   a,($14)+y         ;  set SRCN from table
08f1: c9 f2 00  mov   $00f2,x
08f4: c5 f3 00  mov   $00f3,a
08f7: 3d        inc   x
08f8: fc        inc   y
08f9: ad 04     cmp   y,#$04
08fb: d0 f2     bne   $08ef             ; set SRCN, ADSR1/2, GAIN from table
08fd: ce        pop   x
08fe: f7 14     mov   a,($14)+y
0900: d5 21 02  mov   $0221+x,a         ; set pitch multiplier
0903: fc        inc   y
0904: f7 14     mov   a,($14)+y
0906: d5 20 02  mov   $0220+x,a
0909: 6f        ret

; vcmd e1 - pan
090a: d5 51 03  mov   $0351+x,a
090d: 28 1f     and   a,#$1f
090f: d5 31 03  mov   $0331+x,a         ; voice pan value
0912: e8 00     mov   a,#$00
0914: d5 30 03  mov   $0330+x,a
0917: 6f        ret

; vcmd e2 - pan fade
0918: d4 91     mov   $91+x,a
091a: 2d        push  a
091b: 3f a7 08  call  $08a7
091e: d5 50 03  mov   $0350+x,a
0921: 80        setc
0922: b5 31 03  sbc   a,$0331+x         ; current pan value
0925: ce        pop   x
0926: 3f 40 0b  call  $0b40             ; delta = pan value / steps
0929: d5 40 03  mov   $0340+x,a
092c: dd        mov   a,y
092d: d5 41 03  mov   $0341+x,a
0930: 6f        ret

; vcmd e3 - vibrato on
0931: d5 b0 02  mov   $02b0+x,a
0934: 3f a7 08  call  $08a7
0937: d5 a1 02  mov   $02a1+x,a
093a: 3f a7 08  call  $08a7
; vcmd e4 - vibrato off
093d: d4 b1     mov   $b1+x,a
093f: d5 c1 02  mov   $02c1+x,a
0942: e8 00     mov   a,#$00
0944: d5 b1 02  mov   $02b1+x,a
0947: 6f        ret

; vcmd f0 - vibrato fade
0948: d5 b1 02  mov   $02b1+x,a
094b: 2d        push  a
094c: 8d 00     mov   y,#$00
094e: f4 b1     mov   a,$b1+x
0950: ce        pop   x
0951: 9e        div   ya,x
0952: f8 44     mov   x,$44
0954: d5 c0 02  mov   $02c0+x,a
0957: 6f        ret

; vcmd e5 - master volume
0958: e5 ca 03  mov   a,$03ca
095b: d0 09     bne   $0966
095d: e5 f1 03  mov   a,$03f1
0960: d0 04     bne   $0966
0962: e8 00     mov   a,#$00
0964: da 58     movw  $58,ya
0966: 6f        ret

; vcmd e6 - master volume fade
0967: c4 5a     mov   $5a,a
0969: 3f a7 08  call  $08a7
096c: c4 5b     mov   $5b,a
096e: 80        setc
096f: a4 59     sbc   a,$59
0971: f8 5a     mov   x,$5a
0973: 3f 40 0b  call  $0b40
0976: da 5c     movw  $5c,ya
0978: 6f        ret

; vcmd e7 - tempo
0979: e8 00     mov   a,#$00
097b: da 52     movw  $52,ya
097d: cc cf 03  mov   $03cf,y
0980: 6f        ret

; vcmd e8 - tempo fade
0981: c4 54     mov   $54,a
0983: 3f a7 08  call  $08a7
0986: c4 55     mov   $55,a
0988: 80        setc
0989: a4 53     sbc   a,$53
098b: f8 54     mov   x,$54
098d: 3f 40 0b  call  $0b40
0990: da 56     movw  $56,ya
0992: 6f        ret

; vcmd e9 - global transpose
0993: c4 50     mov   $50,a
0995: 6f        ret

; vcmd ea - per-voice transpose
0996: d5 d0 03  mov   $03d0+x,a
0999: f5 a0 03  mov   a,$03a0+x
099c: d0 06     bne   $09a4
099e: f5 d0 03  mov   a,$03d0+x
09a1: d5 f0 02  mov   $02f0+x,a
09a4: 6f        ret

; vcmd eb - tremolo on
09a5: d5 e0 02  mov   $02e0+x,a
09a8: 3f a7 08  call  $08a7
09ab: d5 d1 02  mov   $02d1+x,a
09ae: 3f a7 08  call  $08a7
; vcmd ec - tremolo off
09b1: d4 c1     mov   $c1+x,a
09b3: 6f        ret

; vcmd f1 - pitch envelope (release)
09b4: e8 01     mov   a,#$01
09b6: 2f 02     bra   $09ba
; vcmd f2 - pitch envelope (attack)
09b8: e8 00     mov   a,#$00
09ba: d5 90 02  mov   $0290+x,a
09bd: dd        mov   a,y
09be: d5 81 02  mov   $0281+x,a
09c1: 3f a7 08  call  $08a7
09c4: d5 e1 03  mov   $03e1+x,a
09c7: 2d        push  a
09c8: e4 47     mov   a,$47
09ca: 24 1a     and   a,$1a
09cc: ae        pop   a
09cd: f0 02     beq   $09d1
09cf: e8 00     mov   a,#$00
09d1: d5 80 02  mov   $0280+x,a
09d4: 3f a7 08  call  $08a7
09d7: d5 91 02  mov   $0291+x,a
09da: 6f        ret

; vcmd f3 - pitch envelope off
09db: d5 80 02  mov   $0280+x,a
09de: d5 e1 03  mov   $03e1+x,a
09e1: 6f        ret

; vcmd ed - volume
09e2: d5 01 03  mov   $0301+x,a
09e5: e8 00     mov   a,#$00
09e7: d5 00 03  mov   $0300+x,a
09ea: 6f        ret

; vcmd ee - volume fade
09eb: d4 90     mov   $90+x,a
09ed: 2d        push  a
09ee: 3f a7 08  call  $08a7
09f1: d5 20 03  mov   $0320+x,a
09f4: 80        setc
09f5: b5 01 03  sbc   a,$0301+x
09f8: ce        pop   x
09f9: 3f 40 0b  call  $0b40
09fc: d5 10 03  mov   $0310+x,a
09ff: dd        mov   a,y
0a00: d5 11 03  mov   $0311+x,a
0a03: 6f        ret

; vcmd f4 - tuning
0a04: d5 e0 03  mov   $03e0+x,a
0a07: f5 a0 03  mov   a,$03a0+x
0a0a: d0 06     bne   $0a12
0a0c: f5 e0 03  mov   a,$03e0+x
0a0f: d5 81 03  mov   $0381+x,a
0a12: 6f        ret

; vcmd ef - call subroutine
0a13: d5 40 02  mov   $0240+x,a
0a16: 3f a7 08  call  $08a7
0a19: d5 41 02  mov   $0241+x,a         ; $0240/1+X - destination (arg1/2)
0a1c: 3f a7 08  call  $08a7
0a1f: d4 80     mov   $80+x,a           ; repeat count from arg3
0a21: f4 30     mov   a,$30+x
0a23: d5 30 02  mov   $0230+x,a
0a26: f4 31     mov   a,$31+x
0a28: d5 31 02  mov   $0231+x,a         ; $0230/1+X - return addr
; jump to $0240/1+X (loop destination)
0a2b: f5 40 02  mov   a,$0240+x
0a2e: d4 30     mov   $30+x,a
0a30: f5 41 02  mov   a,$0241+x
0a33: d4 31     mov   $31+x,a
0a35: 6f        ret

; vcmd f5 - echo vbits/volume
0a36: c5 c3 03  mov   $03c3,a
0a39: c4 4a     mov   $4a,a             ; echo vbit shadow = arg1
0a3b: 3f a7 08  call  $08a7
0a3e: e8 00     mov   a,#$00
0a40: da 60     movw  $60,ya            ; echo vol L shadow = arg2
0a42: 3f a7 08  call  $08a7
0a45: e8 00     mov   a,#$00
0a47: da 62     movw  $62,ya            ; echo vol R shadow = arg3
0a49: b2 48     clr5  $48
0a4b: 6f        ret

; vcmd f8 - echo volume fade
0a4c: c4 68     mov   $68,a
0a4e: 3f a7 08  call  $08a7
0a51: c4 69     mov   $69,a
0a53: 80        setc
0a54: a4 61     sbc   a,$61
0a56: f8 68     mov   x,$68
0a58: 3f 40 0b  call  $0b40
0a5b: da 64     movw  $64,ya
0a5d: 3f a7 08  call  $08a7
0a60: c4 6a     mov   $6a,a
0a62: 80        setc
0a63: a4 63     sbc   a,$63
0a65: f8 68     mov   x,$68
0a67: 3f 40 0b  call  $0b40
0a6a: da 66     movw  $66,ya
0a6c: 6f        ret

; vcmd f6 - disable echo
0a6d: da 60     movw  $60,ya            ; zero echo vol L shadow
0a6f: da 62     movw  $62,ya            ; zero echo vol R shadow
0a71: a2 48     set5  $48               ; disable echo write
0a73: 6f        ret

; vcmd f7 - set echo params
0a74: 3f 96 0a  call  $0a96             ; set echo delay from arg1
0a77: 3f a7 08  call  $08a7
0a7a: c4 4e     mov   $4e,a             ; set echo feedback shadow from arg2
0a7c: 3f a7 08  call  $08a7
0a7f: 8d 08     mov   y,#$08
0a81: cf        mul   ya
0a82: 5d        mov   x,a
0a83: 8d 0f     mov   y,#$0f
0a85: f5 fe 0d  mov   a,$0dfe+x         ; filter table
0a88: 3f fa 05  call  $05fa
0a8b: 3d        inc   x
0a8c: dd        mov   a,y
0a8d: 60        clrc
0a8e: 88 10     adc   a,#$10
0a90: fd        mov   y,a
0a91: 10 f2     bpl   $0a85             ; set echo filter from table index arg3
0a93: f8 44     mov   x,$44
0a95: 6f        ret
; set echo delay to A
0a96: c4 4d     mov   $4d,a
0a98: 8d 7d     mov   y,#$7d
0a9a: cc f2 00  mov   $00f2,y
0a9d: e5 f3 00  mov   a,$00f3           ; set echo delay
0aa0: 64 4d     cmp   a,$4d
0aa2: f0 2b     beq   $0acf             ; same as $4d?
0aa4: 28 0f     and   a,#$0f
0aa6: 48 ff     eor   a,#$ff
0aa8: f3 4c 03  bbc7  $4c,$0aae
0aab: 60        clrc
0aac: 84 4c     adc   a,$4c
0aae: c4 4c     mov   $4c,a
0ab0: 8d 04     mov   y,#$04
0ab2: f6 1d 0e  mov   a,$0e1d+y         ; shadow reg DSP reg table
0ab5: c5 f2 00  mov   $00f2,a
0ab8: e8 00     mov   a,#$00
0aba: c5 f3 00  mov   $00f3,a
0abd: fe f3     dbnz  y,$0ab2           ; zero echo vol, feedback, vbit DSP regs
0abf: e4 48     mov   a,$48
0ac1: 08 20     or    a,#$20
0ac3: 8d 6c     mov   y,#$6c
0ac5: 3f fa 05  call  $05fa             ; set FLG from shadow but disable echo
0ac8: e4 4d     mov   a,$4d
0aca: 8d 7d     mov   y,#$7d
0acc: 3f fa 05  call  $05fa             ; set echo delay from $4d
0acf: 1c        asl   a
0ad0: 1c        asl   a
0ad1: 1c        asl   a
0ad2: 48 ff     eor   a,#$ff
0ad4: 80        setc
0ad5: 88 3c     adc   a,#$3c
0ad7: 8d 6d     mov   y,#$6d
0ad9: 5f fa 05  jmp   $05fa             ; set echo region to $3c00-8*delay

; vcmd fa - set perc patch base
0adc: c4 5f     mov   $5f,a
0ade: 6f        ret

; vcmd f9 - pitch slide
0adf: 2d        push  a
0ae0: e4 47     mov   a,$47
0ae2: 24 1a     and   a,$1a
0ae4: ae        pop   a
0ae5: f0 26     beq   $0b0d
0ae7: 8f 02 10  mov   $10,#$02
0aea: 2f 13     bra   $0aff
0aec: f4 a0     mov   a,$a0+x
0aee: d0 44     bne   $0b34
0af0: e7 30     mov   a,($30+x)
0af2: 68 f9     cmp   a,#$f9
0af4: d0 3e     bne   $0b34
0af6: e4 47     mov   a,$47
0af8: 24 1a     and   a,$1a
0afa: f0 0b     beq   $0b07
0afc: 8f 04 10  mov   $10,#$04
0aff: 3f a9 08  call  $08a9
0b02: 6e 10 fa  dbnz  $10,$0aff
0b05: 2f 2d     bra   $0b34
0b07: 3f a9 08  call  $08a9
0b0a: 3f a7 08  call  $08a7
0b0d: d4 a1     mov   $a1+x,a
0b0f: 3f a7 08  call  $08a7
0b12: d4 a0     mov   $a0+x,a
0b14: 3f a7 08  call  $08a7
0b17: 60        clrc
0b18: 84 50     adc   a,$50             ; add global transpose
0b1a: 95 f0 02  adc   a,$02f0+x         ; per-voice transpose
; calculate portamento delta
0b1d: 28 7f     and   a,#$7f
0b1f: d5 80 03  mov   $0380+x,a         ; final portamento value
0b22: 80        setc
0b23: b5 61 03  sbc   a,$0361+x         ; note number
0b26: fb a0     mov   y,$a0+x           ; portamento steps
0b28: 6d        push  y
0b29: ce        pop   x
0b2a: 3f 40 0b  call  $0b40
0b2d: d5 70 03  mov   $0370+x,a
0b30: dd        mov   a,y
0b31: d5 71 03  mov   $0371+x,a         ; portamento delta
0b34: 6f        ret

0b35: f5 61 03  mov   a,$0361+x
0b38: c4 11     mov   $11,a
0b3a: f5 60 03  mov   a,$0360+x
0b3d: c4 10     mov   $10,a
0b3f: 6f        ret

; signed 16 bit division
0b40: ed        notc
0b41: 6b 12     ror   $12
0b43: 10 03     bpl   $0b48
0b45: 48 ff     eor   a,#$ff
0b47: bc        inc   a
0b48: 8d 00     mov   y,#$00
0b4a: 9e        div   ya,x
0b4b: 2d        push  a
0b4c: e8 00     mov   a,#$00
0b4e: 9e        div   ya,x
0b4f: ee        pop   y
0b50: f8 44     mov   x,$44
0b52: f3 12 06  bbc7  $12,$0b5b
0b55: da 14     movw  $14,ya
0b57: ba 0e     movw  ya,$0e
0b59: 9a 14     subw  ya,$14
0b5b: 6f        ret

; vcmd dispatch table ($0a9c)
0b5c: dw $08b1  ; e0 - set instrument
0b5e: dw $090a  ; e1 - pan
0b60: dw $0918  ; e2 - pan fade
0b62: dw $0931  ; e3 - vibrato on
0b64: dw $093d  ; e4 - vibrato off
0b66: dw $0958  ; e5 - master volume
0b68: dw $0967  ; e6 - master volume fade
0b6a: dw $0979  ; e7 - tempo
0b6c: dw $0981  ; e8 - tempo fade
0b6e: dw $0993  ; e9 - global transpose
0b70: dw $0996  ; ea - per-voice transpose
0b72: dw $09a5  ; eb - tremolo on
0b74: dw $09b1  ; ec - tremolo off
0b76: dw $09e2  ; ed - volume
0b78: dw $09eb  ; ee - volume fade
0b7a: dw $0a13  ; ef - call subroutine
0b7c: dw $0948  ; f0 - vibrato fade
0b7e: dw $09b4  ; f1 - pitch envelope (release)
0b80: dw $09b8  ; f2 - pitch envelope (attack)
0b82: dw $09db  ; f3 - pitch envelope off
0b84: dw $0a04  ; f4 - tuning
0b86: dw $0a36  ; f5 - echo vbits/volume
0b88: dw $0a6d  ; f6 - disable echo
0b8a: dw $0a74  ; f7 - set echo params
0b8c: dw $0a4c  ; f8 - echo volume fade
0b8e: dw $0adf  ; f9 - pitch slide
0b90: dw $0adc  ; fa - set perc patch base
                ; fb-ff undefined

; vcmd lengths ($0b32)
0b92: db $01,$01,$02,$03,$00,$01,$02,$01 ; e0-e7
0b9a: db $02,$01,$01,$03,$00,$01,$02,$03 ; e8-ef
0ba2: db $01,$03,$03,$00,$01,$03,$00,$03 ; f0-f7
0baa: db $03,$03,$01                     ; f8-fa

; do voice fades
0bad: f4 90     mov   a,$90+x           ; voice volume fade counter
0baf: f0 09     beq   $0bba
0bb1: e8 00     mov   a,#$00
0bb3: 8d 03     mov   y,#$03
0bb5: 9b 90     dec   $90+x             ; dec voice vol fade counter
0bb7: 3f 43 0c  call  $0c43
0bba: fb c1     mov   y,$c1+x
0bbc: f0 23     beq   $0be1
0bbe: f5 e0 02  mov   a,$02e0+x
0bc1: de c0 1b  cbne  $c0+x,$0bdf
0bc4: 09 47 5e  or    ($5e),($47)
0bc7: f5 d0 02  mov   a,$02d0+x
0bca: 10 07     bpl   $0bd3
0bcc: fc        inc   y
0bcd: d0 04     bne   $0bd3
0bcf: e8 80     mov   a,#$80
0bd1: 2f 04     bra   $0bd7
0bd3: 60        clrc
0bd4: 95 d1 02  adc   a,$02d1+x
0bd7: d5 d0 02  mov   $02d0+x,a
0bda: 3f cc 0d  call  $0dcc
0bdd: 2f 07     bra   $0be6
0bdf: bb c0     inc   $c0+x
0be1: e8 ff     mov   a,#$ff
0be3: 3f d7 0d  call  $0dd7
0be6: f4 91     mov   a,$91+x
0be8: f0 09     beq   $0bf3
0bea: e8 30     mov   a,#$30
0bec: 8d 03     mov   y,#$03
0bee: 9b 91     dec   $91+x
0bf0: 3f 43 0c  call  $0c43
0bf3: e4 47     mov   a,$47
0bf5: 24 5e     and   a,$5e
0bf7: f0 49     beq   $0c42
0bf9: f5 31 03  mov   a,$0331+x
0bfc: fd        mov   y,a
0bfd: f5 30 03  mov   a,$0330+x
0c00: da 10     movw  $10,ya
0c02: 7d        mov   a,x
0c03: 9f        xcn   a
0c04: 5c        lsr   a
0c05: c4 12     mov   $12,a
0c07: eb 11     mov   y,$11
0c09: f6 ea 0d  mov   a,$0dea+y         ; next pan val from table
0c0c: 80        setc
0c0d: b6 e9 0d  sbc   a,$0de9+y         ; pan val
0c10: eb 10     mov   y,$10
0c12: cf        mul   ya
0c13: dd        mov   a,y
0c14: eb 11     mov   y,$11
0c16: 60        clrc
0c17: 96 e9 0d  adc   a,$0de9+y         ; add integer part to pan val
0c1a: fd        mov   y,a
0c1b: d5 50 02  mov   $0250+x,a         ; volume
0c1e: f5 21 03  mov   a,$0321+x
0c21: cf        mul   ya
0c22: f5 51 03  mov   a,$0351+x         ; bits 7/6 will negate volume L/R
0c25: 1c        asl   a
0c26: 13 12 01  bbc0  $12,$0c2a
0c29: 1c        asl   a
0c2a: dd        mov   a,y
0c2b: 90 03     bcc   $0c30
0c2d: 48 ff     eor   a,#$ff
0c2f: bc        inc   a
0c30: eb 12     mov   y,$12
0c32: 3f f2 05  call  $05f2
0c35: 8d 14     mov   y,#$14
0c37: e8 00     mov   a,#$00
0c39: 9a 10     subw  ya,$10
0c3b: da 10     movw  $10,ya
0c3d: ab 12     inc   $12
0c3f: 33 12 c5  bbc1  $12,$0c07
0c42: 6f        ret

0c43: 09 47 5e  or    ($5e),($47)
0c46: da 14     movw  $14,ya
0c48: da 16     movw  $16,ya
0c4a: 4d        push  x
0c4b: ee        pop   y
0c4c: 60        clrc
0c4d: d0 0a     bne   $0c59
0c4f: 98 1f 16  adc   $16,#$1f
0c52: e8 00     mov   a,#$00
0c54: d7 14     mov   ($14)+y,a
0c56: fc        inc   y
0c57: 2f 09     bra   $0c62
0c59: 98 10 16  adc   $16,#$10
0c5c: 3f 60 0c  call  $0c60
0c5f: fc        inc   y
0c60: f7 14     mov   a,($14)+y
0c62: 97 16     adc   a,($16)+y
0c64: d7 14     mov   ($14)+y,a
0c66: 6f        ret

; do readahead
0c67: f4 71     mov   a,$71+x
0c69: f0 65     beq   $0cd0
0c6b: 9b 71     dec   $71+x
0c6d: f0 05     beq   $0c74
0c6f: e8 02     mov   a,#$02
0c71: de 70 5c  cbne  $70+x,$0cd0
0c74: f4 80     mov   a,$80+x
0c76: c4 17     mov   $17,a
0c78: f4 30     mov   a,$30+x
0c7a: fb 31     mov   y,$31+x
0c7c: da 14     movw  $14,ya
0c7e: 8d 00     mov   y,#$00
0c80: f7 14     mov   a,($14)+y
0c82: f0 1e     beq   $0ca2
0c84: 30 07     bmi   $0c8d
0c86: fc        inc   y
0c87: 30 40     bmi   $0cc9
0c89: f7 14     mov   a,($14)+y
0c8b: 10 f9     bpl   $0c86
0c8d: 68 c8     cmp   a,#$c8
0c8f: f0 3f     beq   $0cd0
0c91: 68 ef     cmp   a,#$ef
0c93: f0 29     beq   $0cbe
0c95: 68 e0     cmp   a,#$e0
0c97: 90 30     bcc   $0cc9
0c99: 6d        push  y
0c9a: fd        mov   y,a
0c9b: ae        pop   a
0c9c: 96 b2 0a  adc   a,$0ab2+y         ; vcmd lengths
0c9f: fd        mov   y,a
0ca0: 2f de     bra   $0c80
0ca2: e4 17     mov   a,$17
0ca4: f0 23     beq   $0cc9
0ca6: 8b 17     dec   $17
0ca8: d0 0a     bne   $0cb4
; read $0230/1+X into YA
0caa: f5 31 02  mov   a,$0231+x
0cad: 2d        push  a
0cae: f5 30 02  mov   a,$0230+x
0cb1: ee        pop   y
0cb2: 2f c8     bra   $0c7c
; read $0240/1+X into YA
0cb4: f5 41 02  mov   a,$0241+x
0cb7: 2d        push  a
0cb8: f5 40 02  mov   a,$0240+x
0cbb: ee        pop   y
0cbc: 2f be     bra   $0c7c
;
0cbe: fc        inc   y
0cbf: f7 14     mov   a,($14)+y
0cc1: 2d        push  a
0cc2: fc        inc   y
0cc3: f7 14     mov   a,($14)+y
0cc5: fd        mov   y,a
0cc6: ae        pop   a
0cc7: 2f b3     bra   $0c7c
0cc9: e4 47     mov   a,$47
0ccb: 8d 5c     mov   y,#$5c
0ccd: 3f f2 05  call  $05f2
0cd0: f2 13     clr7  $13
0cd2: f4 a0     mov   a,$a0+x
0cd4: f0 19     beq   $0cef
0cd6: f4 a1     mov   a,$a1+x
0cd8: f0 04     beq   $0cde
0cda: 9b a1     dec   $a1+x
0cdc: 2f 11     bra   $0cef
0cde: e4 1a     mov   a,$1a
0ce0: 24 47     and   a,$47
0ce2: d0 0b     bne   $0cef
0ce4: e2 13     set7  $13
0ce6: e8 60     mov   a,#$60
0ce8: 8d 03     mov   y,#$03
0cea: 9b a0     dec   $a0+x
0cec: 3f 46 0c  call  $0c46
0cef: 3f 35 0b  call  $0b35
0cf2: f4 b1     mov   a,$b1+x
0cf4: f0 4c     beq   $0d42
0cf6: f5 b0 02  mov   a,$02b0+x
0cf9: de b0 44  cbne  $b0+x,$0d40
0cfc: f5 00 01  mov   a,$0100+x
0cff: 75 b1 02  cmp   a,$02b1+x
0d02: d0 05     bne   $0d09
0d04: f5 c1 02  mov   a,$02c1+x
0d07: 2f 0d     bra   $0d16
0d09: 40        setp
0d0a: bb 00     inc   $00+x
0d0c: 20        clrp
0d0d: fd        mov   y,a
0d0e: f0 02     beq   $0d12
0d10: f4 b1     mov   a,$b1+x
0d12: 60        clrc
0d13: 95 c0 02  adc   a,$02c0+x
0d16: d4 b1     mov   $b1+x,a
0d18: f5 a0 02  mov   a,$02a0+x
0d1b: 60        clrc
0d1c: 95 a1 02  adc   a,$02a1+x
0d1f: d5 a0 02  mov   $02a0+x,a
0d22: c4 12     mov   $12,a
0d24: 1c        asl   a
0d25: 1c        asl   a
0d26: 90 02     bcc   $0d2a
0d28: 48 ff     eor   a,#$ff
0d2a: fd        mov   y,a
0d2b: f4 b1     mov   a,$b1+x
0d2d: 68 f1     cmp   a,#$f1
0d2f: 90 05     bcc   $0d36
0d31: 28 0f     and   a,#$0f
0d33: cf        mul   ya
0d34: 2f 04     bra   $0d3a
0d36: cf        mul   ya
0d37: dd        mov   a,y
0d38: 8d 00     mov   y,#$00
0d3a: 3f b7 0d  call  $0db7
0d3d: 5f 6f 05  jmp   $056f

0d40: bb b0     inc   $b0+x
0d42: e3 13 f8  bbs7  $13,$0d3d
0d45: 6f        ret

; per-voice fades/dsps
0d46: f2 13     clr7  $13
0d48: f4 c1     mov   a,$c1+x
0d4a: f0 09     beq   $0d55
0d4c: f5 e0 02  mov   a,$02e0+x
0d4f: de c0 03  cbne  $c0+x,$0d55
0d52: 3f bf 0d  call  $0dbf             ; voice vol calculations
0d55: f5 31 03  mov   a,$0331+x
0d58: fd        mov   y,a
0d59: f5 30 03  mov   a,$0330+x
0d5c: da 10     movw  $10,ya            ; $10/1 = voice pan value
0d5e: f4 91     mov   a,$91+x           ; voice pan fade counter
0d60: f0 0a     beq   $0d6c
0d62: f5 41 03  mov   a,$0341+x
0d65: fd        mov   y,a
0d66: f5 40 03  mov   a,$0340+x         ; pan fade delta
0d69: 3f a1 0d  call  $0da1             ; add delta (with mutations)?
0d6c: f3 13 03  bbc7  $13,$0d72
0d6f: 3f 02 0c  call  $0c02
0d72: f2 13     clr7  $13
0d74: 3f 35 0b  call  $0b35
0d77: f4 a0     mov   a,$a0+x
0d79: f0 0e     beq   $0d89
0d7b: f4 a1     mov   a,$a1+x
0d7d: d0 0a     bne   $0d89
0d7f: f5 71 03  mov   a,$0371+x
0d82: fd        mov   y,a
0d83: f5 70 03  mov   a,$0370+x
0d86: 3f a1 0d  call  $0da1
0d89: f4 b1     mov   a,$b1+x
0d8b: f0 b5     beq   $0d42
0d8d: f5 b0 02  mov   a,$02b0+x
0d90: de b0 af  cbne  $b0+x,$0d42
0d93: eb 51     mov   y,$51
0d95: f5 a1 02  mov   a,$02a1+x
0d98: cf        mul   ya
0d99: dd        mov   a,y
0d9a: 60        clrc
0d9b: 95 a0 02  adc   a,$02a0+x
0d9e: 5f 22 0d  jmp   $0d22

0da1: e2 13     set7  $13
0da3: cb 12     mov   $12,y
0da5: 3f 52 0b  call  $0b52
0da8: 6d        push  y
0da9: eb 51     mov   y,$51
0dab: cf        mul   ya
0dac: cb 14     mov   $14,y
0dae: 8f 00 15  mov   $15,#$00
0db1: eb 51     mov   y,$51
0db3: ae        pop   a
0db4: cf        mul   ya
0db5: 7a 14     addw  ya,$14
0db7: 3f 52 0b  call  $0b52
0dba: 7a 10     addw  ya,$10
0dbc: da 10     movw  $10,ya
0dbe: 6f        ret

0dbf: e2 13     set7  $13
0dc1: eb 51     mov   y,$51
0dc3: f5 d1 02  mov   a,$02d1+x
0dc6: cf        mul   ya
0dc7: dd        mov   a,y
0dc8: 60        clrc
0dc9: 95 d0 02  adc   a,$02d0+x
0dcc: 1c        asl   a
0dcd: 90 02     bcc   $0dd1
0dcf: 48 ff     eor   a,#$ff
0dd1: fb c1     mov   y,$c1+x
0dd3: cf        mul   ya
0dd4: dd        mov   a,y
0dd5: 48 ff     eor   a,#$ff
0dd7: eb 59     mov   y,$59
0dd9: cf        mul   ya
0dda: f5 10 02  mov   a,$0210+x
0ddd: cf        mul   ya
0dde: f5 01 03  mov   a,$0301+x
0de1: cf        mul   ya
0de2: dd        mov   a,y
0de3: cf        mul   ya
0de4: dd        mov   a,y
0de5: d5 21 03  mov   $0321+x,a
0de8: 6f        ret

; pan table
0de9: db $00,$01,$03,$07,$0d,$15,$1e,$29
0df1: db $34,$42,$51,$5e,$67,$6e,$73,$77
0df9: db $7a,$7c,$7d,$7e,$7f

; echo FIR presets
0dfe: db $7f,$00,$00,$00,$00,$00,$00,$00 ; 00
0e06: db $58,$bf,$db,$f0,$fe,$07,$0c,$0c ; 01
0e0e: db $0c,$21,$2b,$2b,$13,$fe,$f3,$f9 ; 02
0e16: db $34,$33,$00,$d9,$e5,$01,$fc,$eb ; 03

; EVOL(L),EVOL(R),EFB,EON,FLG,KOL,KOF,NON,PMON,KOF
; dsp shadow addrs ($0e27+1) for dsp regs ($0e1d+1)
0e1e: db $2c,$3c,$0d,$4d,$6c,$4c,$5c,$3d,$2d,$5c
0e28: db $61,$63,$4e,$4a,$48,$45,$0e,$49,$4b,$46

; pitch table
0e32: dw $085f
0e34: dw $08de
0e36: dw $0965
0e38: dw $09f4
0e3a: dw $0a8c
0e3c: dw $0b2c
0e3e: dw $0bd6
0e40: dw $0c8b
0e42: dw $0d4a
0e44: dw $0e14
0e46: dw $0eea
0e48: dw $0fcd
0e4a: dw $10be

0e4c: db $2a,$56,$65,$72,$20,$53,$31,$2e,$32,$30,$2a

0e57: e8 aa     mov   a,#$aa
0e59: c5 f4 00  mov   $00f4,a
0e5c: e8 bb     mov   a,#$bb
0e5e: c5 f5 00  mov   $00f5,a
0e61: e5 f4 00  mov   a,$00f4
0e64: 68 cc     cmp   a,#$cc
0e66: d0 f9     bne   $0e61
0e68: 2f 20     bra   $0e8a
0e6a: ec f4 00  mov   y,$00f4
0e6d: d0 fb     bne   $0e6a
0e6f: 5e f4 00  cmp   y,$00f4
0e72: d0 0f     bne   $0e83
0e74: e5 f5 00  mov   a,$00f5
0e77: cc f4 00  mov   $00f4,y
0e7a: d7 14     mov   ($14)+y,a
0e7c: fc        inc   y
0e7d: d0 f0     bne   $0e6f
0e7f: ab 15     inc   $15
0e81: 2f ec     bra   $0e6f
0e83: 10 ea     bpl   $0e6f
0e85: 5e f4 00  cmp   y,$00f4
0e88: 10 e5     bpl   $0e6f
0e8a: e5 f6 00  mov   a,$00f6
0e8d: ec f7 00  mov   y,$00f7
0e90: da 14     movw  $14,ya
0e92: ec f4 00  mov   y,$00f4
0e95: e5 f5 00  mov   a,$00f5
0e98: cc f4 00  mov   $00f4,y
0e9b: d0 cd     bne   $0e6a
0e9d: cd 31     mov   x,#$31
0e9f: c9 f1 00  mov   $00f1,x
0ea2: 6f        ret

; note dur%'s
3fe8: db $33,$66,$7f,$99,$b2,$cc,$e5,$fc
; per-note velocity values
3ff0: db $19,$33,$4c,$66,$72,$7f,$8c,$99
3ff8: db $a5,$b2,$bf,$cc,$d8,$e5,$f2,$fc
