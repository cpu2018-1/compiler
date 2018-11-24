	.data
	.literal8
	.align 3
l.6808:	 # 128.000000
	.long	0
	.long	1080033280
	.align 3
l.6800:	 # 0.900000
	.long	-858993459
	.long	1072483532
	.align 3
l.6790:	 # 150.000000
	.long	0
	.long	1080213504
	.align 3
l.6789:	 # -150.000000
	.long	0
	.long	-1067270144
	.align 3
l.6788:	 # 0.100000
	.long	-1717986918
	.long	1069128089
	.align 3
l.6787:	 # -2.000000
	.long	0
	.long	-1073741824
	.align 3
l.6786:	 # 0.003906
	.long	0
	.long	1064304640
	.align 3
l.6785:	 # 20.000000
	.long	0
	.long	1077149696
	.align 3
l.6784:	 # 0.050000
	.long	-1717986918
	.long	1068079513
	.align 3
l.6783:	 # 0.250000
	.long	0
	.long	1070596096
	.align 3
l.6782:	 # 10.000000
	.long	0
	.long	1076101120
	.align 3
l.6781:	 # 0.300000
	.long	858993459
	.long	1070805811
	.align 3
l.6780:	 # 255.000000
	.long	0
	.long	1081073664
	.align 3
l.6779:	 # 0.150000
	.long	858993459
	.long	1069757235
	.align 3
l.6778:	 # 30.000000
	.long	0
	.long	1077805056
	.align 3
l.6777:	 # 15.000000
	.long	0
	.long	1076756480
	.align 3
l.6776:	 # 0.000100
	.long	-350469331
	.long	1058682594
	.align 3
l.6775:	 # 100000000.000000
	.long	0
	.long	1100470148
	.align 3
l.6774:	 # 1000000000.000000
	.long	0
	.long	1104006501
	.align 3
l.6773:	 # -0.100000
	.long	-1717986918
	.long	-1078355559
	.align 3
l.6772:	 # 0.010000
	.long	1202590843
	.long	1065646817
	.align 3
l.6771:	 # -0.200000
	.long	-1717986918
	.long	-1077306983
	.align 3
l.6758:	 # -200.000000
	.long	0
	.long	-1066860544
	.align 3
l.6757:	 # 200.000000
	.long	0
	.long	1080623104
	.align 3
l.6756:	 # 0.017453
	.long	-1433277178
	.long	1066524486
	.align 3
l.6755:	 # 2.437500
	.long	0
	.long	1073971200
	.align 3
l.6754:	 # 4.375000
	.long	0
	.long	1074888704
	.align 3
l.6753:	 # 0.060035
	.long	-1722198048
	.long	1068416248
	.align 3
l.6752:	 # 0.089764
	.long	-1140127587
	.long	1068956365
	.align 3
l.6751:	 # 0.111111
	.long	-35190969
	.long	1069314502
	.align 3
l.6750:	 # 0.142857
	.long	-1871582096
	.long	1069697316
	.align 3
l.6749:	 # 0.200000
	.long	-1717986918
	.long	1070176665
	.align 3
l.6748:	 # 0.333333
	.long	831175815
	.long	1070945621
	.align 3
l.6747:	 # 0.785399
	.long	-1683902058
	.long	1072243197
	.align 3
l.6746:	 # 1.570798
	.long	-1683902058
	.long	1073291773
	.align 3
l.6745:	 # 3.141597
	.long	-1683902058
	.long	1074340349
	.align 3
l.6744:	 # 0.785398
	.long	1518260631
	.long	1072243195
	.align 3
l.6743:	 # 1.570796
	.long	1518260631
	.long	1073291771
	.align 3
l.6742:	 # -1.000000
	.long	0
	.long	-1074790400
	.align 3
l.6741:	 # 0.001370
	.long	-1162164879
	.long	1062629408
	.align 3
l.6740:	 # 0.041664
	.long	504356979
	.long	1067799793
	.align 3
l.6739:	 # 0.000196
	.long	-1160135268
	.long	1059695766
	.align 3
l.6738:	 # 0.008333
	.long	-1266569225
	.long	1065423052
	.align 3
l.6737:	 # 0.166667
	.long	1912039726
	.long	1069897045
	.align 3
l.6736:	 # 6.283185
	.long	1518260631
	.long	1075388923
	.align 3
l.6735:	 # 3.141593
	.long	1518260631
	.long	1074340347
	.align 3
l.6734:	 # 2.000000
	.long	0
	.long	1073741824
	.align 3
l.6733:	 # 1.000000
	.long	0
	.long	1072693248
	.align 3
l.6732:	 # 0.500000
	.long	0
	.long	1071644672
	.align 3
l.6731:	 # 0.000000
	.long	0
	.long	0
	.text
	.globl _min_caml_start
lib_print_char:
  out r1
  jr  r31
lib_print_newline:
  addi  r30, r0, 10
  out r30
  jr  r31
lib_itof:
  itof  f1, r1
  jr  r31
lib_ftoi:
  ftoi  r1, f1
  jr  r31
lib_fneg:
  fneg  f1, f1
  jr  r31
lib_sqrt:
  fsqrt  f1, f1
  jr  r31
lib_create_array:
  addi  r30, r1, 0
  addi  r29, r0, 1
  addi  r1, r4, 0
lib_create_array_loop:
  beq r30, r0, lib_create_array_exit
lib_create_array_cont:
  sw  r2, 0(r4)
  sub r30, r30, r29
  addi  r4, r4, 1
  j lib_create_array_loop:
lib_create_array_exit:
  jr  r31
lib_create_float_array:
  addi  r30, r1, 0
  addi  r1, r4, 0
lib_create_float_array_loop:
  beq r30, r0, lib_create_float_array_exit
lib_create_float_array_cont:
  fmvtr r29, f1
  sw  r29, 0(r4)
  addi  r29, r0, 1
  sub r30, r30, r29
  addi  r4, r4, 1
  j lib_create_float_array_loop:
lib_create_float_array_exit:
  jr  r31
lib_read_char:
  in  r1
  jr  r31
lib_buffer_add_char:
  addi  r30, r0, 10000
  lw  r29, 16(r30)
  addi  r29, r29, 1
  sw  r29, 16(r30)
  addi  r29, r29, -1
  add r30, r30, r29
  sw  r1, 0(r30)
  jr  r31  
lib_buffer_clear:
  addi  r30, r0, 10000
  sw  r0, 0(r30)
  sw  r0, 1(r30)
  sw  r0, 2(r30)
  sw  r0, 3(r30)
  sw  r0, 4(r30)
  sw  r0, 5(r30)
  sw  r0, 6(r30)
  sw  r0, 7(r30)
  sw  r0, 8(r30)
  sw  r0, 9(r30)
  sw  r0, 10(r30)
  sw  r0, 11(r30)
  sw  r0, 12(r30)
  sw  r0, 13(r30)
  sw  r0, 14(r30)
  sw  r0, 15(r30)
  sw  r0, 16(r30)
  jr  r31
lib_buffer_get:
  addi  r30, r0, 10000
  add r30, r30, r1
  lw  r1, 0(r30)
  jr r31
lib_buffer_to_int:
  addi  r30, r0, 10000
  lw  r2, 16(r30)
  addi  r1, r0, 0
  lw  r5, 0(r30)
  addi  r29, r0, 45
  ble r5, r29, lib_buffer_to_int_minus
lib_buffer_to_int_cont:
  beq r2, r0, lib_buffer_to_int_exit
  sw  r1, 0(r3)
  sw  r2, 1(r3)
  sw  r30, 2(r3)
  sw  r31, 3(r3)
  lw  r1, 0(r30)
  addi  r1, r1, -48
  addi  r2, r2, -1
  addi  r3, r3, 4
  jal lib_iter_mul10
  addi  r3, r3, -4
  lw  r5, 0(r3)
  lw  r2, 1(r3)
  lw  r30, 2(r3)
  lw  r31, 3(r3)
  addi  r30, r30, 1
  add r1, r1, r5
  addi  r2, r2, -1
  j lib_buffer_to_int_cont:
lib_buffer_to_int_exit:
  jr  r31
lib_buffer_to_int_minus:
  addi  r30, r30, 1
  addi  r2, r2, -1
lib_buffer_to_int_minus_cont:
  beq r2, r0, lib_buffer_to_int_minus_exit
  sw  r1, 0(r3)
  sw  r2, 1(r3)
  sw  r30, 2(r3)
  sw  r31, 3(r3)
  lw  r1, 0(r30)
  addi  r1, r1, -48
  addi  r2, r2, -1
  addi  r3, r3, 4
  jal lib_iter_mul10
  addi  r3, r3, -4
  lw  r5, 0(r3)
  lw  r2, 1(r3)
  lw  r30, 2(r3)
  lw  r31, 3(r3)
  addi  r30, r30, 1
  add r1, r1, r5
  addi  r2, r2, -1
  j lib_buffer_to_int_minus_cont:
lib_buffer_to_int_minus_exit:
  sub r1, r0, r1
  jr  r31
lib_buffer_to_int_of_float:
  addi  r30, r0, 10000
  addi  r1, r0, 0
  addi  r5, r0, 46
  addi  r7, r0, 45
  addi  r8, r0, 0
  addi  r2, r0, 0
lib_buffer_to_pos_loop:
  lw  r6, 0(r30)
  beq r6, r5, lib_buffer_to_int_cont_ready
  beq r6, r0, lib_buffer_to_int_cont_ready
  beq r6, r7, lib_buffer_to_int_of_float_minus
  addi  r2, r2, 1
  addi r30, r30, 1
  j lib_buffer_to_pos_loop
lib_buffer_to_int_of_float_minus:
  addi  r30, r30, 1
  addi  r8, r0, 1
  j lib_buffer_to_pos_loop
lib_buffer_to_int_cont_ready:
  addi r30, r0, 10000
  add r30, r30, r8
  j lib_buffer_to_int_cont
# for read_float
lib_buffer_to_dec_of_float:
  addi  r30, r0, 10000
  addi  r1, r0, 0
  addi  r5, r0, 46
  addi  r2, r0, 0
lib_buffer_to_pos_loop_dec:
  lw  r6, 0(r30)
  beq r6, r5, lib_buffer_to_dec_of_float_cont
  beq r6, r0, lib_buffer_to_dec_zero
  addi  r2, r2, 1
  addi r30, r30, 1
  j lib_buffer_to_pos_loop_dec
lib_buffer_to_dec_zero:
  addi r1, r0, 0
  jr  r31
lib_buffer_to_dec_of_float_cont:
  addi  r29, r0, 10000
  addi  r2, r2, 1
  lw  r7, 16(r29)
  sub r2, r7, r2
  addi  r1, r0, 0
  addi  r30, r30, 1
  j lib_buffer_to_int_cont
lib_buffer_to_ika_keta_of_float:
  addi  r30, r0, 10000
  addi  r1, r0, 0
  addi  r5, r0, 46
  addi  r2, r0, 0
lib_buffer_to_pos_loop_keta:
  lw  r6, 0(r30)
  beq r6, r5, lib_buffer_to_ika_keta_of_float_cont
  beq r6, r0, lib_buffer_to_ika_keta_zero
  addi  r2, r2, 1
  addi r30, r30, 1
  j lib_buffer_to_pos_loop_keta
lib_buffer_to_ika_keta_zero:
  addi r1, r0, 0
  jr  r31
lib_buffer_to_ika_keta_of_float_cont:
  addi  r29, r0, 10000
  addi  r2, r2, 1
  lw  r7, 16(r29)
  sub r1, r7, r2
  jr  r31
lib_fless:
	flt r1, f1, f2
	jr	r31				#	blr
lib_read_int:
  in  r30
  slli  r30, r30, 24
  add r1, r0, r30
  in  r30
  slli  r30, r30, 16
  add r1, r1, r30
  in  r30
  slli  r30, r30, 8
  add r1, r1, r30
  in  r30
  add r1, r1, r30
  jr  r31
lib_read_float:
  in  r30
  slli  r30, r30, 24
  add r1, r0, r30
  in  r30
  slli  r30, r30, 16
  add r1, r1, r30
  in  r30
  slli  r30, r30, 8
  add r1, r1, r30
  in  r30
  add r1, r1, r30
  fmvfr f1, r1
  jr  r31
lib_fispos:
	flup	f2, 0
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.874
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
_fle_else.874:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
lib_fisneg:
	flup	f2, 0
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.875
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
_fle_else.875:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
lib_fiszero:
	flup	f2, 0
	feq	r30, f1, f2
	beq	r0, r30, _feq_else.876
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
_feq_else.876:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
lib_xor:
	beq	r1, r2, _beq_then.877
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
_beq_then.877:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
lib_fhalf:
	flup	f2, 1
	fmul	f1, f1, f2
	jr	r31				#	blr
lib_fsqr:
	fmul	f1, f1, f1
	jr	r31				#	blr
lib_fabs:
	flup	f2, 0
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.878
	jr	r31				#	blr
_fle_else.878:
 lib_fneg	f1, f1
	jr	r31				#	blr
lib_floor:
	fmvtr	r30, f1
	sw	r30, 0(r3)				#stfd	f1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.879
	jr	r31				#	blr
_fle_else.879:
	flup	f2, 2
	fsub	f1, f1, f2
	jr	r31				#	blr
lib_int_of_float:
	flup	f2, 0
	feq	r30, f1, f2
	beq	r0, r30, _feq_else.880
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
_feq_else.880:
	flup	f2, 0
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.881
	flup	f2, 1
	fsub	f1, f1, f2
	j	lib_ftoi
_fle_else.881:
	flup	f2, 1
	fadd	f1, f1, f2
	j	lib_ftoi
lib_float_of_int:
	j	lib_itof
lib_hoge:
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.882
	flup	f3, 3
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.883
	flup	f3, 3
	fmul	f2, f3, f2
	j lib_hoge
_fle_else.883:
	fadd	f1, f0, f2				# fmr	f1, f2
	jr	r31				#	blr
_fle_else.882:
	fadd	f1, f0, f2				# fmr	f1, f2
	jr	r31				#	blr
lib_fuga:
	flup	f4, 3
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.884
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.885
	fsub	f1, f1, f2
	flup	f4, 3
	fdiv	f2, f2, f4
	j lib_fuga
_fle_else.885:
	flup	f4, 3
	fdiv	f2, f2, f4
	j lib_fuga
_fle_else.884:
	jr	r31				#	blr
lib_modulo_2pi:
	addi	r30, r0, 4059
	lui	r30, r30, 16457	# to load float		3.141593
	fmvfr	f3, r30
	flup	f2, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16585	# to load float		6.283185
	fmvfr	f2, r30
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.886
	flup	f2, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16713	# to load float		12.566371
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_hoge				#	bl lib_hoge
	addi	r3, r3, -5
	lw	r30, 4(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	j	_fle_cont.887
_fle_else.886:
_fle_cont.887:
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
	j lib_fuga
lib_sin_body:
	fmul	f2, f1, f1
	addi	r30, r0, 43692
	lui	r30, r30, 15914	# to load float		0.166667
	fmvfr	f3, r30
	fmul	f3, f3, f1
	fmul	f3, f3, f2
	fsub	f3, f1, f3
	addi	r30, r0, 34406
	lui	r30, r30, 15368	# to load float		0.008333
	fmvfr	f4, r30
	fmul	f4, f4, f1
	fmul	f4, f4, f2
	fmul	f4, f4, f2
	fadd	f3, f3, f4
	addi	r30, r0, 25782
	lui	r30, r30, 14669	# to load float		0.000196
	fmvfr	f4, r30
	fmul	f1, f4, f1
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fsub	f1, f3, f1
	jr	r31				#	blr
lib_cos_body:
	fmul	f1, f1, f1
	flup	f2, 2
	flup	f3, 1
	addi	r30, r0, 42889
	lui	r30, r30, 15658	# to load float		0.041664
	fmvfr	f4, r30
	addi	r30, r0, 33030
	lui	r30, r30, 15027	# to load float		0.001370
	fmvfr	f5, r30
	fmul	f5, f1, f5
	fsub	f4, f4, f5
	fmul	f4, f1, f4
	fsub	f3, f3, f4
	fmul	f1, f1, f3
	fsub	f1, f2, f1
	jr	r31				#	blr
lib_sin:
	addi	r30, r0, 4059
	lui	r30, r30, 16457	# to load float		3.141593
	fmvfr	f2, r30
	flup	f3, 0
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.888
	flup	f3, 2
	j	_fle_cont.889
_fle_else.888:
	flup	f3, 2
	flup	f3, 11
_fle_cont.889:
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				#	bl	lib_abs_float
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_modulo_2pi				#	bl lib_modulo_2pi
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.890
	fsub	f1, f1, f2
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
 lib_fneg	f3, f3
	flup	f4, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f4, r30
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.891
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.892
	fmvtr	r30, f3
	sw	r30, 4(r3)				#stfd	f3, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.892:
	flup	f2, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f2, r30
	fsub	f1, f2, f1
	fmvtr	r30, f3
	sw	r30, 4(r3)				#stfd	f3, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.891:
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.893
	fmvtr	r30, f3
	sw	r30, 4(r3)				#stfd	f3, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.893:
	flup	f2, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f2, r30
	fsub	f1, f2, f1
	fmvtr	r30, f3
	sw	r30, 4(r3)				#stfd	f3, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.890:
	flup	f3, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f3, r30
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.894
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.895
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.895:
	flup	f2, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.894:
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.896
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.896:
	flup	f2, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
lib_cos:
	addi	r30, r0, 4059
	lui	r30, r30, 16457	# to load float		3.141593
	fmvfr	f2, r30
	flup	f3, 2
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				#	bl	lib_abs_float
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_modulo_2pi				#	bl lib_modulo_2pi
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.897
	fsub	f1, f1, f2
	flup	f3, 11
	flup	f4, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f4, r30
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.898
	fsub	f1, f2, f1
	flup	f2, 2
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f3, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f3, r30
	fle	r30, f1, f3
	beq	r0, r30, _fle_else.899
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.899:
	flup	f3, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f3, r30
	fsub	f1, f3, f1
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.898:
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.900
	fmvtr	r30, f3
	sw	r30, 6(r3)				#stfd	f3, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.900:
	flup	f2, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f2, r30
	fsub	f1, f2, f1
	fmvtr	r30, f3
	sw	r30, 6(r3)				#stfd	f3, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.897:
	flup	f3, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f3, r30
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.901
	fsub	f1, f2, f1
	flup	f2, 11
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f3, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f3, r30
	fle	r30, f1, f3
	beq	r0, r30, _fle_else.902
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.902:
	flup	f3, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f3, r30
	fsub	f1, f3, f1
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.901:
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.903
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.903:
	flup	f2, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
lib_atan_body:
	addi	r30, r0, 43690
	lui	r30, r30, 16042	# to load float		0.333333
	fmvfr	f2, r30
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fsub	f2, f1, f2
	flup	f3, 18
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fadd	f2, f2, f3
	addi	r30, r0, 18725
	lui	r30, r30, 15890	# to load float		0.142857
	fmvfr	f3, r30
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fsub	f2, f2, f3
	addi	r30, r0, 36408
	lui	r30, r30, 15843	# to load float		0.111111
	fmvfr	f3, r30
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fadd	f2, f2, f3
	addi	r30, r0, 54894
	lui	r30, r30, 15799	# to load float		0.089764
	fmvfr	f3, r30
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fsub	f2, f2, f3
	addi	r30, r0, 59333
	lui	r30, r30, 15733	# to load float		0.060035
	fmvfr	f3, r30
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f1, f3, f1
	fadd	f1, f2, f1
	jr	r31				#	blr
lib_atan:
	addi	r30, r0, 4059
	lui	r30, r30, 16457	# to load float		3.141593
	fmvfr	f2, r30
	flup	f2, 0
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.904
	flup	f2, 2
	j	_fle_cont.905
_fle_else.904:
	flup	f2, 2
	flup	f2, 11
_fle_cont.905:
	fmul	f1, f1, f2
	flup	f3, 23
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.906
	flup	f3, 24
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.907
	flup	f3, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f3, r30
	flup	f4, 2
	fdiv	f1, f4, f1
	fmvtr	r30, f2
	sw	r30, 0(r3)				#stfd	f2, 0(r3)
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_atan_body				#	bl lib_atan_body
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.907:
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f3, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f3, r30
	flup	f4, 2
	fsub	f4, f1, f4
	flup	f5, 2
	fadd	f1, f1, f5
	fdiv	f1, f4, f1
	fmvtr	r30, f2
	sw	r30, 0(r3)				#stfd	f2, 0(r3)
	fmvtr	r30, f3
	sw	r30, 4(r3)				#stfd	f3, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_atan_body				#	bl lib_atan_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.906:
	j lib_atan_body
lib_print_num:
	addi	r1, r1, 48
	j	lib_print_char
lib_mul10:
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	jr	r31				#	blr
lib_div10_sub:
	add	r6, r2, r5
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	ble	r7, r1, _ble_then.908
	add	r5, r0, r6				# mr	r5, r6
	j lib_div10_sub
_ble_then.908:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, _ble_then.909
	add	r2, r0, r6				# mr	r2, r6
	j lib_div10_sub
_ble_then.909:
	add	r1, r0, r6				# mr	r1, r6
	jr	r31				#	blr
lib_div10:
	addi	r2, r0, 0				# li	r2, 0
	add	r5, r0, r1				# mr	r5, r1
	j lib_div10_sub
lib_iter_mul10:
	beqi	r2, 0, _beq_then.910
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	j lib_iter_mul10
_beq_then.910:
	jr	r31				#	blr
lib_iter_div10:
	beqi	r2, 0, _beq_then.911
	addi	r5, r0, 0				# li	r5, 0
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal lib_div10_sub				#	bl lib_div10_sub
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	addi	r2, r2, -1
	j lib_iter_div10
_beq_then.911:
	jr	r31				#	blr
lib_keta_sub:
	addi	r5, r0, 10				# li	r5, 10
	ble	r5, r1, _ble_then.912
	addi	r1, r2, 1
	jr	r31				#	blr
_ble_then.912:
	addi	r5, r0, 0				# li	r5, 0
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal lib_div10_sub				#	bl lib_div10_sub
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	addi	r2, r2, 1
	j lib_keta_sub
lib_keta:
	addi	r2, r0, 0				# li	r2, 0
	j lib_keta_sub
lib_print_uint_keta:
	beqi	r2, 1, _beq_then.913
	addi	r5, r0, 1				# li	r5, 1
	addi	r6, r2, -1
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal lib_iter_mul10				#	bl lib_iter_mul10
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	ble	r1, r2, _ble_then.914
	addi	r1, r0, 48				# li	r1, 48
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	addi	r2, r1, -1
	lw	r1, 1(r3)
	j lib_print_uint_keta
_ble_then.914:
	lw	r1, 0(r3)
	addi	r5, r1, -1
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal lib_iter_div10				#	bl lib_iter_div10
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r1, 48
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	addi	r2, r1, -1
	lw	r5, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal lib_iter_mul10				#	bl lib_iter_mul10
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	sub	r1, r2, r1
	lw	r2, 0(r3)
	addi	r2, r2, -1
	j lib_print_uint_keta
_beq_then.913:
	addi	r1, r1, 48
	j	lib_print_char
lib_print_uint:
	addi	r2, r0, 10				# li	r2, 10
	ble	r2, r1, _ble_then.915
	addi	r1, r1, 48
	j	lib_print_char
_ble_then.915:
	addi	r2, r0, 0				# li	r2, 0
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r1				# mr	r5, r1
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal lib_div10_sub				#	bl lib_div10_sub
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal lib_print_uint				#	bl lib_print_uint
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	j	lib_print_char
lib_print_int:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, _ble_then.916
	addi	r2, r0, 45				# li	r2, 45
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	sub	r1, r0, r1
	j lib_print_uint
_ble_then.916:
	j lib_print_uint
lib_read_token:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_char				#	bl	lib_read_char
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 32				# li	r2, 32
	beq	r1, r2, _beq_then.917
	beqi	r1, 9, _beq_then.918
	beqi	r1, 13, _beq_then.919
	beqi	r1, 10, _beq_then.920
	addi	r2, r0, 26				# li	r2, 26
	beq	r1, r2, _beq_then.921
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_buffer_add_char				#	bl	lib_buffer_add_char
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	j lib_read_token
_beq_then.921:
	jr	r31				#	blr
_beq_then.920:
	lw	r1, 0(r3)
	beqi	r1, 0, _beq_then.923
	jr	r31				#	blr
_beq_then.923:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
_beq_then.919:
	lw	r1, 0(r3)
	beqi	r1, 0, _beq_then.925
	jr	r31				#	blr
_beq_then.925:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
_beq_then.918:
	lw	r1, 0(r3)
	beqi	r1, 0, _beq_then.927
	jr	r31				#	blr
_beq_then.927:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
_beq_then.917:
	lw	r1, 0(r3)
	beqi	r1, 0, _beq_then.929
	jr	r31				#	blr
_beq_then.929:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
lib_read_int_ascii:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 0(r3)
	addi	r3, r3, 1
	jal	lib_buffer_clear				#	bl	lib_buffer_clear
	addi	r3, r3, -1
	lw	r30, 0(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 0(r3)
	addi	r3, r3, 1
	jal lib_read_token				#	bl lib_read_token
	addi	r3, r3, -1
	lw	r30, 0(r3)
	add	r31, r0, r30				#mtlr	r30
	j	lib_buffer_to_int
lib_iter_div10_float:
	beqi	r1, 0, _beq_then.931
	flup	f2, 39
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	j lib_iter_div10_float
_beq_then.931:
	jr	r31				#	blr
lib_read_float_ascii:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 0(r3)
	addi	r3, r3, 1
	jal	lib_buffer_clear				#	bl	lib_buffer_clear
	addi	r3, r3, -1
	lw	r30, 0(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 0(r3)
	addi	r3, r3, 1
	jal lib_read_token				#	bl lib_read_token
	addi	r3, r3, -1
	lw	r30, 0(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 0(r3)
	addi	r3, r3, 1
	jal	lib_buffer_get				#	bl	lib_buffer_get
	addi	r3, r3, -1
	lw	r30, 0(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_buffer_to_int_of_float				#	bl	lib_buffer_to_int_of_float
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_buffer_to_dec_of_float				#	bl	lib_buffer_to_dec_of_float
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	lib_buffer_to_ika_keta_of_float				#	bl	lib_buffer_to_ika_keta_of_float
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 45				# li	r2, 45
	lw	r5, 0(r3)
	beq	r5, r2, _beq_then.932
	lw	r2, 1(r3)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_itof				#	bl	lib_itof
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_itof				#	bl	lib_itof
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_iter_div10_float				#	bl lib_iter_div10_float
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	jr	r31				#	blr
_beq_then.932:
	flup	f1, 2
	flup	f1, 11
	lw	r2, 1(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_itof				#	bl	lib_itof
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_itof				#	bl	lib_itof
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal lib_iter_div10_float				#	bl lib_iter_div10_float
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	jr	r31				#	blr
lib_truncate:
	j lib_int_of_float
lib_abs_float:
	flup	f2, 0
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.933
	jr	r31				#	blr
_fle_else.933:
 lib_fneg	f1, f1
	jr	r31				#	blr
lib_print_dec:
	flup	f2, 0
	feq	r30, f1, f2
	beq	r0, r30, _feq_else.934
	jr	r31				#	blr
_feq_else.934:
	flup	f2, 39
	fmul	f1, f2, f1
	fmvtr	r30, f1
	sw	r30, 0(r3)				#stfd	f1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal lib_print_int				#	bl lib_print_int
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f1, 0(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_itof				#	bl	lib_itof
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	j lib_print_dec
lib_print_ufloat:
	fmvtr	r30, f1
	sw	r30, 0(r3)				#stfd	f1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal lib_print_int				#	bl lib_print_int
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 46				# li	r1, 46
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f1, 0(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_itof				#	bl	lib_itof
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	j lib_print_dec
lib_print_float:
	flup	f2, 0
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.936
	j lib_print_ufloat
_fle_else.936:
	addi	r1, r0, 45				# li	r1, 45
	fmvtr	r30, f1
	sw	r30, 0(r3)				#stfd	f1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f1, 0(r3)
	fmvfr	f1, r30
 lib_fneg	f1, f1
	j lib_print_ufloat
# library ends
fispos.2735:
	flup	f2, 0
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8939
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
fle_else.8939:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
fisneg.2737:
	flup	f2, 0
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8940
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
fle_else.8940:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
fiszero.2739:
	flup	f2, 0
	feq	r30, f1, f2
	beq	r0, r30, feq_else.8941
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
feq_else.8941:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
fhalf.2744:
	flup	f2, 1
	fmul	f1, f1, f2
	jr	r31				#	blr
fsqr.2746:
	fmul	f1, f1, f1
	jr	r31				#	blr
fabs.2748:
	flup	f2, 0
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8942
	jr	r31				#	blr
fle_else.8942:
	fneg	f1, f1
	jr	r31				#	blr
fneg.2750:
	fneg	f1, f1
	jr	r31				#	blr
floor.2752:
	fmvtr	r30, f1
	sw	r30, 0(r3)				#stfd	f1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8943
	jr	r31				#	blr
fle_else.8943:
	flup	f2, 2
	fsub	f1, f1, f2
	jr	r31				#	blr
int_of_float.2754:
	flup	f2, 0
	feq	r30, f1, f2
	beq	r0, r30, feq_else.8944
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
feq_else.8944:
	flup	f2, 0
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8945
	flup	f2, 1
	fsub	f1, f1, f2
	j	lib_ftoi
fle_else.8945:
	flup	f2, 1
	fadd	f1, f1, f2
	j	lib_ftoi
float_of_int.2756:
	j	lib_itof
hoge.6699:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8946
	flup	f3, 3
	fmul	f2, f3, f2
	j	hoge.6699
fle_else.8946:
	fadd	f1, f0, f2				# fmr	f1, f2
	jr	r31				#	blr
fuga.6703:
	flup	f4, 3
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.8947
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8948
	fsub	f1, f1, f2
	flup	f4, 3
	fdiv	f2, f2, f4
	j	fuga.6703
fle_else.8948:
	flup	f4, 3
	fdiv	f2, f2, f4
	j	fuga.6703
fle_else.8947:
	jr	r31				#	blr
modulo_2pi.2758:
	flup	f2, 4
	flup	f3, 5
	fmvtr	r30, f2
	sw	r30, 0(r3)				#stfd	f2, 0(r3)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f2, f0, f3				# fmr	f2, f3
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	hoge.6699				#	bl	hoge.6699
	addi	r3, r3, -5
	lw	r30, 4(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
	j	fuga.6703
sin_body.2760:
	fmul	f2, f1, f1
	flup	f3, 6
	fmul	f3, f3, f1
	fmul	f3, f3, f2
	fsub	f3, f1, f3
	flup	f4, 7
	fmul	f4, f4, f1
	fmul	f4, f4, f2
	fmul	f4, f4, f2
	fadd	f3, f3, f4
	flup	f4, 8
	fmul	f1, f4, f1
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fsub	f1, f3, f1
	jr	r31				#	blr
cos_body.2762:
	fmul	f1, f1, f1
	flup	f2, 2
	flup	f3, 1
	flup	f4, 9
	flup	f5, 10
	fmul	f5, f1, f5
	fsub	f4, f4, f5
	fmul	f4, f1, f4
	fsub	f3, f3, f4
	fmul	f1, f1, f3
	fsub	f1, f2, f1
	jr	r31				#	blr
sin.2764:
	flup	f2, 4
	flup	f3, 0
	fle	r30, f3, f1
	beq	r0, r30, fle_else.8949
	flup	f3, 2
	j	fle_cont.8950
fle_else.8949:
	flup	f3, 11
fle_cont.8950:
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				#	bl	lib_abs_float
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	modulo_2pi.2758				#	bl	modulo_2pi.2758
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8951
	fsub	f1, f1, f2
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
	fneg	f3, f3
	flup	f4, 12
	fle	r30, f4, f1
	beq	r0, r30, fle_else.8952
	fsub	f1, f2, f1
	flup	f2, 13
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8953
	fmvtr	r30, f3
	sw	r30, 4(r3)				#stfd	f3, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8953:
	flup	f2, 12
	fsub	f1, f2, f1
	fmvtr	r30, f3
	sw	r30, 4(r3)				#stfd	f3, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8952:
	flup	f2, 13
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8954
	fmvtr	r30, f3
	sw	r30, 4(r3)				#stfd	f3, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8954:
	flup	f2, 12
	fsub	f1, f2, f1
	fmvtr	r30, f3
	sw	r30, 4(r3)				#stfd	f3, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8951:
	flup	f3, 12
	fle	r30, f3, f1
	beq	r0, r30, fle_else.8955
	fsub	f1, f2, f1
	flup	f2, 13
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8956
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8956:
	flup	f2, 12
	fsub	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8955:
	flup	f2, 13
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8957
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8957:
	flup	f2, 12
	fsub	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
cos.2766:
	flup	f2, 14
	flup	f3, 2
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				#	bl	lib_abs_float
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	modulo_2pi.2758				#	bl	modulo_2pi.2758
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8958
	fsub	f1, f1, f2
	flup	f3, 11
	flup	f4, 15
	fle	r30, f4, f1
	beq	r0, r30, fle_else.8959
	fsub	f1, f2, f1
	flup	f2, 2
	flup	f3, 16
	fle	r30, f1, f3
	beq	r0, r30, fle_else.8960
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8960:
	flup	f3, 15
	fsub	f1, f3, f1
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8959:
	flup	f2, 16
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8961
	fmvtr	r30, f3
	sw	r30, 6(r3)				#stfd	f3, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8961:
	flup	f2, 15
	fsub	f1, f2, f1
	fmvtr	r30, f3
	sw	r30, 6(r3)				#stfd	f3, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8958:
	flup	f3, 15
	fle	r30, f3, f1
	beq	r0, r30, fle_else.8962
	fsub	f1, f2, f1
	flup	f2, 11
	flup	f3, 16
	fle	r30, f1, f3
	beq	r0, r30, fle_else.8963
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8963:
	flup	f3, 15
	fsub	f1, f3, f1
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8962:
	flup	f2, 16
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8964
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8964:
	flup	f2, 15
	fsub	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
atan_body.2768:
	flup	f2, 17
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fsub	f2, f1, f2
	flup	f3, 18
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fadd	f2, f2, f3
	flup	f3, 19
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fsub	f2, f2, f3
	flup	f3, 20
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fadd	f2, f2, f3
	flup	f3, 21
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fsub	f2, f2, f3
	flup	f3, 22
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f1, f3, f1
	fadd	f1, f2, f1
	jr	r31				#	blr
atan.2770:
	flup	f2, 0
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8965
	flup	f2, 2
	j	fle_cont.8966
fle_else.8965:
	flup	f2, 11
fle_cont.8966:
	fmul	f1, f1, f2
	flup	f3, 23
	fle	r30, f3, f1
	beq	r0, r30, fle_else.8967
	flup	f3, 24
	fle	r30, f3, f1
	beq	r0, r30, fle_else.8968
	flup	f3, 12
	flup	f4, 2
	fdiv	f1, f4, f1
	fmvtr	r30, f2
	sw	r30, 0(r3)				#stfd	f2, 0(r3)
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	atan_body.2768				#	bl	atan_body.2768
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8968:
	flup	f3, 13
	flup	f4, 2
	fsub	f4, f1, f4
	flup	f5, 2
	fadd	f1, f1, f5
	fdiv	f1, f4, f1
	fmvtr	r30, f2
	sw	r30, 0(r3)				#stfd	f2, 0(r3)
	fmvtr	r30, f3
	sw	r30, 4(r3)				#stfd	f3, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	atan_body.2768				#	bl	atan_body.2768
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.8967:
	j	atan_body.2768
print_num.2772:
	addi	r1, r1, 48
	j	lib_print_char
mul10.2774:
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	jr	r31				#	blr
div10_sub.2776:
	add	r6, r2, r5
	srai	r6, r6, 1
	sw	r2, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	mul10.2774				#	bl	mul10.2774
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	ble	r1, r2, ble_then.8969
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	div10_sub.2776
ble_then.8969:
	lw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	mul10.2774				#	bl	mul10.2774
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r1, 9
	lw	r2, 3(r3)
	ble	r2, r1, ble_then.8970
	lw	r1, 2(r3)
	lw	r5, 1(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	div10_sub.2776
ble_then.8970:
	lw	r1, 2(r3)
	jr	r31				#	blr
div10.2780:
	addi	r2, r0, 0				# li	r2, 0
	add	r5, r0, r1				# mr	r5, r1
	j	div10_sub.2776
print_uint.2796:
	addi	r2, r0, 10				# li	r2, 10
	ble	r2, r1, ble_then.8971
	j	print_num.2772
ble_then.8971:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	div10.2780				#	bl	div10.2780
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	print_uint.2796				#	bl	print_uint.2796
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	mul10.2774				#	bl	mul10.2774
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sub	r1, r2, r1
	j	print_num.2772
print_int.2798:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.8972
	addi	r2, r0, 45				# li	r2, 45
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	sub	r1, r0, r1
	j	print_uint.2796
ble_then.8972:
	j	print_uint.2796
xor.2851:
	beqi	r1, 0, beq_then.8973
	beqi	r2, 0, beq_then.8974
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8974:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.8973:
	add	r1, r0, r2				# mr	r1, r2
	jr	r31				#	blr
sgn.2854:
	fmvtr	r30, f1
	sw	r30, 0(r3)				#stfd	f1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8975
	flup	f1, 0
	jr	r31				#	blr
beq_then.8975:
	lw	r30, 0(r3)				#lfd	f1, 0(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	fispos.2735				#	bl	fispos.2735
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8976
	flup	f1, 2
	jr	r31				#	blr
beq_then.8976:
	flup	f1, 11
	jr	r31				#	blr
fneg_cond.2856:
	beqi	r1, 0, beq_then.8977
	jr	r31				#	blr
beq_then.8977:
	j	fneg.2750
add_mod5.2859:
	add	r1, r1, r2
	addi	r2, r0, 5				# li	r2, 5
	ble	r2, r1, ble_then.8978
	jr	r31				#	blr
ble_then.8978:
	addi	r1, r1, -5
	jr	r31				#	blr
vecset.2862:
	fsw	r30, 0(r1)
	fsw	r30, 1(r1)
	fsw	r30, 2(r1)
	jr	r31				#	blr
vecfill.2867:
	fsw	r30, 0(r1)
	fsw	r30, 1(r1)
	fsw	r30, 2(r1)
	jr	r31				#	blr
vecbzero.2870:
	flup	f1, 0
	j	vecfill.2867
veccpy.2872:
	flw	f1, 0(r2)
	fsw	r30, 0(r1)
	flw	f1, 1(r2)
	fsw	r30, 1(r1)
	flw	f1, 2(r2)
	fsw	r30, 2(r1)
	jr	r31				#	blr
vecunit_sgn.2880:
	flw	f1, 0(r1)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8982
	flup	f1, 2
	j	beq_cont.8983
beq_then.8982:
	lw	r1, 0(r3)
	beqi	r1, 0, beq_then.8984
	flup	f1, 11
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	j	beq_cont.8985
beq_then.8984:
	flup	f1, 2
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
beq_cont.8985:
beq_cont.8983:
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	fmul	f2, f2, f1
	fsw	r30, 0(r1)
	flw	f2, 1(r1)
	fmul	f2, f2, f1
	fsw	r30, 1(r1)
	flw	f2, 2(r1)
	fmul	f1, f2, f1
	fsw	r30, 2(r1)
	jr	r31				#	blr
veciprod.2883:
	flw	f1, 0(r1)
	flw	f2, 0(r2)
	fmul	f1, f1, f2
	flw	f2, 1(r1)
	flw	f3, 1(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	flw	f3, 2(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	jr	r31				#	blr
veciprod2.2886:
	flw	f4, 0(r1)
	fmul	f1, f4, f1
	flw	f4, 1(r1)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	jr	r31				#	blr
vecaccum.2891:
	flw	f2, 0(r1)
	flw	f3, 0(r2)
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fsw	r30, 0(r1)
	flw	f2, 1(r1)
	flw	f3, 1(r2)
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fsw	r30, 1(r1)
	flw	f2, 2(r1)
	flw	f3, 2(r2)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	fsw	r30, 2(r1)
	jr	r31				#	blr
vecadd.2895:
	flw	f1, 0(r1)
	flw	f2, 0(r2)
	fadd	f1, f1, f2
	fsw	r30, 0(r1)
	flw	f1, 1(r1)
	flw	f2, 1(r2)
	fadd	f1, f1, f2
	fsw	r30, 1(r1)
	flw	f1, 2(r1)
	flw	f2, 2(r2)
	fadd	f1, f1, f2
	fsw	r30, 2(r1)
	jr	r31				#	blr
vecscale.2901:
	flw	f2, 0(r1)
	fmul	f2, f2, f1
	fsw	r30, 0(r1)
	flw	f2, 1(r1)
	fmul	f2, f2, f1
	fsw	r30, 1(r1)
	flw	f2, 2(r1)
	fmul	f1, f2, f1
	fsw	r30, 2(r1)
	jr	r31				#	blr
vecaccumv.2904:
	flw	f1, 0(r1)
	flw	f2, 0(r2)
	flw	f3, 0(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	r30, 0(r1)
	flw	f1, 1(r1)
	flw	f2, 1(r2)
	flw	f3, 1(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	r30, 1(r1)
	flw	f1, 2(r1)
	flw	f2, 2(r2)
	flw	f3, 2(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	r30, 2(r1)
	jr	r31				#	blr
o_texturetype.2908:
	lw	r1, 0(r1)
	jr	r31				#	blr
o_form.2910:
	lw	r1, 1(r1)
	jr	r31				#	blr
o_reflectiontype.2912:
	lw	r1, 2(r1)
	jr	r31				#	blr
o_isinvert.2914:
	lw	r1, 6(r1)
	jr	r31				#	blr
o_isrot.2916:
	lw	r1, 3(r1)
	jr	r31				#	blr
o_param_a.2918:
	lw	r1, 4(r1)
	flw	f1, 0(r1)
	jr	r31				#	blr
o_param_b.2920:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	jr	r31				#	blr
o_param_c.2922:
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	jr	r31				#	blr
o_param_abc.2924:
	lw	r1, 4(r1)
	jr	r31				#	blr
o_param_x.2926:
	lw	r1, 5(r1)
	flw	f1, 0(r1)
	jr	r31				#	blr
o_param_y.2928:
	lw	r1, 5(r1)
	flw	f1, 1(r1)
	jr	r31				#	blr
o_param_z.2930:
	lw	r1, 5(r1)
	flw	f1, 2(r1)
	jr	r31				#	blr
o_diffuse.2932:
	lw	r1, 7(r1)
	flw	f1, 0(r1)
	jr	r31				#	blr
o_hilight.2934:
	lw	r1, 7(r1)
	flw	f1, 1(r1)
	jr	r31				#	blr
o_color_red.2936:
	lw	r1, 8(r1)
	flw	f1, 0(r1)
	jr	r31				#	blr
o_color_green.2938:
	lw	r1, 8(r1)
	flw	f1, 1(r1)
	jr	r31				#	blr
o_color_blue.2940:
	lw	r1, 8(r1)
	flw	f1, 2(r1)
	jr	r31				#	blr
o_param_r1.2942:
	lw	r1, 9(r1)
	flw	f1, 0(r1)
	jr	r31				#	blr
o_param_r2.2944:
	lw	r1, 9(r1)
	flw	f1, 1(r1)
	jr	r31				#	blr
o_param_r3.2946:
	lw	r1, 9(r1)
	flw	f1, 2(r1)
	jr	r31				#	blr
o_param_ctbl.2948:
	lw	r1, 10(r1)
	jr	r31				#	blr
p_rgb.2950:
	lw	r1, 0(r1)
	jr	r31				#	blr
p_intersection_points.2952:
	lw	r1, 1(r1)
	jr	r31				#	blr
p_surface_ids.2954:
	lw	r1, 2(r1)
	jr	r31				#	blr
p_calc_diffuse.2956:
	lw	r1, 3(r1)
	jr	r31				#	blr
p_energy.2958:
	lw	r1, 4(r1)
	jr	r31				#	blr
p_received_ray_20percent.2960:
	lw	r1, 5(r1)
	jr	r31				#	blr
p_group_id.2962:
	lw	r1, 6(r1)
	lw	r1, 0(r1)
	jr	r31				#	blr
p_set_group_id.2964:
	lw	r1, 6(r1)
	sw	r2, 0(r1)
	jr	r31				#	blr
p_nvectors.2967:
	lw	r1, 7(r1)
	jr	r31				#	blr
d_vec.2969:
	lw	r1, 0(r1)
	jr	r31				#	blr
d_const.2971:
	lw	r1, 1(r1)
	jr	r31				#	blr
r_surface_id.2973:
	lw	r1, 0(r1)
	jr	r31				#	blr
r_dvec.2975:
	lw	r1, 1(r1)
	jr	r31				#	blr
r_bright.2977:
	flw	f1, 2(r1)
	jr	r31				#	blr
rad.2979:
	flup	f2, 25
	fmul	f1, f1, f2
	jr	r31				#	blr
read_screen_settings.2981:
	lw	r1, 5(29)
	lw	r2, 4(29)
	lw	r5, 3(29)
	lw	r6, 2(29)
	lw	r7, 1(29)
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fsw	r30, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fsw	r30, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fsw	r30, 2(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	rad.2979				#	bl	rad.2979
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	sin.2764				#	bl	sin.2764
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	rad.2979				#	bl	rad.2979
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	sin.2764				#	bl	sin.2764
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fmul	f3, f2, f1
	flup	f4, 26
	fmul	f3, f3, f4
	lw	r1, 3(r3)
	fsw	r30, 0(r1)
	flup	f3, 27
	lw	r30, 10(r3)				#lfd	f4, 10(r3)
	fmvfr	f4, r30
	fmul	f3, f4, f3
	fsw	r30, 1(r1)
	lw	r30, 14(r3)				#lfd	f3, 14(r3)
	fmvfr	f3, r30
	fmul	f5, f2, f3
	flup	f6, 26
	fmul	f5, f5, f6
	fsw	r30, 2(r1)
	lw	r2, 2(r3)
	fsw	r30, 0(r2)
	flup	f5, 0
	fsw	r30, 1(r2)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	fsw	r30, 2(r1)
	lw	r30, 10(r3)				#lfd	f1, 10(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 1(r3)
	fsw	r30, 0(r1)
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	fsw	r30, 1(r1)
	lw	r30, 10(r3)				#lfd	f1, 10(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 1(r3)
	fsw	r30, 2(r1)
	lw	r1, 4(r3)
	flw	f1, 0(r1)
	lw	r2, 3(r3)
	flw	f2, 0(r2)
	fsub	f1, f1, f2
	lw	r5, 0(r3)
	fsw	r30, 0(r5)
	flw	f1, 1(r1)
	flw	f2, 1(r2)
	fsub	f1, f1, f2
	fsw	r30, 1(r5)
	flw	f1, 2(r1)
	flw	f2, 2(r2)
	fsub	f1, f1, f2
	fsw	r30, 2(r5)
	jr	r31				#	blr
read_light.2983:
	lw	r1, 2(29)
	lw	r2, 1(29)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	rad.2979				#	bl	rad.2979
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	sin.2764				#	bl	sin.2764
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	fsw	r30, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	rad.2979				#	bl	rad.2979
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	sin.2764				#	bl	sin.2764
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	fsw	r30, 0(r1)
	lw	r30, 4(r3)				#lfd	f1, 4(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	fsw	r30, 2(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	fsw	r30, 0(r1)
	jr	r31				#	blr
rotate_quadratic_matrix.2985:
	flw	f1, 0(r2)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	sin.2764				#	bl	sin.2764
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	sin.2764				#	bl	sin.2764
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	sin.2764				#	bl	sin.2764
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 6(r3)				#lfd	f3, 6(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r30, 8(r3)				#lfd	f5, 8(r3)
	fmvfr	f5, r30
	lw	r30, 4(r3)				#lfd	f6, 4(r3)
	fmvfr	f6, r30
	fmul	f7, f6, f5
	fmul	f8, f7, f2
	lw	r30, 2(r3)				#lfd	f9, 2(r3)
	fmvfr	f9, r30
	fmul	f10, f9, f1
	fsub	f8, f8, f10
	fmul	f10, f9, f5
	fmul	f11, f10, f2
	fmul	f12, f6, f1
	fadd	f11, f11, f12
	fmul	f12, f3, f1
	fmul	f7, f7, f1
	fmul	f13, f9, f2
	fadd	f7, f7, f13
	fmul	f1, f10, f1
	fmul	f2, f6, f2
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	fmvtr	r30, f11
	sw	r30, 14(r3)				#stfd	f11, 14(r3)
	fmvtr	r30, f7
	sw	r30, 16(r3)				#stfd	f7, 16(r3)
	fmvtr	r30, f8
	sw	r30, 18(r3)				#stfd	f8, 18(r3)
	fmvtr	r30, f12
	sw	r30, 20(r3)				#stfd	f12, 20(r3)
	fmvtr	r30, f4
	sw	r30, 22(r3)				#stfd	f4, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f5				# fmr	f1, f5
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	lw	r30, 4(r3)				#lfd	f3, 4(r3)
	fmvfr	f3, r30
	fmul	f3, f3, f2
	lw	r30, 2(r3)				#lfd	f4, 2(r3)
	fmvfr	f4, r30
	fmul	f2, f4, f2
	lw	r1, 0(r3)
	flw	f4, 0(r1)
	flw	f5, 1(r1)
	flw	f6, 2(r1)
	lw	r30, 22(r3)				#lfd	f7, 22(r3)
	fmvfr	f7, r30
	fmvtr	r30, f2
	sw	r30, 24(r3)				#stfd	f2, 24(r3)
	fmvtr	r30, f3
	sw	r30, 26(r3)				#stfd	f3, 26(r3)
	fmvtr	r30, f6
	sw	r30, 28(r3)				#stfd	f6, 28(r3)
	fmvtr	r30, f1
	sw	r30, 30(r3)				#stfd	f1, 30(r3)
	fmvtr	r30, f5
	sw	r30, 32(r3)				#stfd	f5, 32(r3)
	fmvtr	r30, f4
	sw	r30, 34(r3)				#stfd	f4, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f7				# fmr	f1, f7
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 20(r3)				#lfd	f3, 20(r3)
	fmvfr	f3, r30
	fmvtr	r30, f1
	sw	r30, 36(r3)				#stfd	f1, 36(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 36(r3)				#lfd	f3, 36(r3)
	fmvfr	f3, r30
	fadd	f1, f3, f1
	lw	r30, 30(r3)				#lfd	f3, 30(r3)
	fmvfr	f3, r30
	fmvtr	r30, f1
	sw	r30, 38(r3)				#stfd	f1, 38(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 38(r3)				#lfd	f3, 38(r3)
	fmvfr	f3, r30
	fadd	f1, f3, f1
	lw	r1, 0(r3)
	fsw	r30, 0(r1)
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 16(r3)				#lfd	f3, 16(r3)
	fmvfr	f3, r30
	fmvtr	r30, f1
	sw	r30, 40(r3)				#stfd	f1, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 40(r3)				#lfd	f3, 40(r3)
	fmvfr	f3, r30
	fadd	f1, f3, f1
	lw	r30, 26(r3)				#lfd	f3, 26(r3)
	fmvfr	f3, r30
	fmvtr	r30, f1
	sw	r30, 42(r3)				#stfd	f1, 42(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 42(r3)				#lfd	f3, 42(r3)
	fmvfr	f3, r30
	fadd	f1, f3, f1
	lw	r1, 0(r3)
	fsw	r30, 1(r1)
	lw	r30, 14(r3)				#lfd	f1, 14(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 12(r3)				#lfd	f3, 12(r3)
	fmvfr	f3, r30
	fmvtr	r30, f1
	sw	r30, 44(r3)				#stfd	f1, 44(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 44(r3)				#lfd	f3, 44(r3)
	fmvfr	f3, r30
	fadd	f1, f3, f1
	lw	r30, 24(r3)				#lfd	f3, 24(r3)
	fmvfr	f3, r30
	fmvtr	r30, f1
	sw	r30, 46(r3)				#stfd	f1, 46(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 46(r3)				#lfd	f3, 46(r3)
	fmvfr	f3, r30
	fadd	f1, f3, f1
	lw	r1, 0(r3)
	fsw	r30, 2(r1)
	flup	f1, 3
	lw	r30, 18(r3)				#lfd	f3, 18(r3)
	fmvfr	f3, r30
	lw	r30, 34(r3)				#lfd	f4, 34(r3)
	fmvfr	f4, r30
	fmul	f5, f4, f3
	lw	r30, 14(r3)				#lfd	f6, 14(r3)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	lw	r30, 16(r3)				#lfd	f7, 16(r3)
	fmvfr	f7, r30
	lw	r30, 32(r3)				#lfd	f8, 32(r3)
	fmvfr	f8, r30
	fmul	f9, f8, f7
	lw	r30, 12(r3)				#lfd	f10, 12(r3)
	fmvfr	f10, r30
	fmul	f9, f9, f10
	fadd	f5, f5, f9
	lw	r30, 26(r3)				#lfd	f9, 26(r3)
	fmvfr	f9, r30
	fmul	f11, f2, f9
	lw	r30, 24(r3)				#lfd	f12, 24(r3)
	fmvfr	f12, r30
	fmul	f11, f11, f12
	fadd	f5, f5, f11
	fmul	f1, f1, f5
	lw	r1, 1(r3)
	fsw	r30, 0(r1)
	flup	f1, 3
	lw	r30, 22(r3)				#lfd	f5, 22(r3)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fmul	f5, f4, f6
	lw	r30, 20(r3)				#lfd	f6, 20(r3)
	fmvfr	f6, r30
	fmul	f6, f8, f6
	fmul	f8, f6, f10
	fadd	f5, f5, f8
	lw	r30, 30(r3)				#lfd	f8, 30(r3)
	fmvfr	f8, r30
	fmul	f2, f2, f8
	fmul	f8, f2, f12
	fadd	f5, f5, f8
	fmul	f1, f1, f5
	fsw	r30, 1(r1)
	flup	f1, 3
	fmul	f3, f4, f3
	fmul	f4, f6, f7
	fadd	f3, f3, f4
	fmul	f2, f2, f9
	fadd	f2, f3, f2
	fmul	f1, f1, f2
	fsw	r30, 2(r1)
	jr	r31				#	blr
read_nth_object.2988:
	lw	r2, 1(29)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, -1, beq_then.8996
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	fsw	r30, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	fsw	r30, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	fsw	r30, 2(r1)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	fsw	r30, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	fsw	r30, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	fsw	r30, 2(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	fisneg.2737				#	bl	fisneg.2737
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 2				# li	r2, 2
	flup	f1, 0
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 9(r3)
	fsw	r30, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 9(r3)
	fsw	r30, 1(r1)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	fsw	r30, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	fsw	r30, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	fsw	r30, 2(r1)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	beqi	r2, 0, beq_then.8997
	sw	r1, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	rad.2979				#	bl	rad.2979
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	fsw	r30, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	rad.2979				#	bl	rad.2979
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	fsw	r30, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	rad.2979				#	bl	rad.2979
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	fsw	r30, 2(r1)
	j	beq_cont.8998
beq_then.8997:
beq_cont.8998:
	lw	r2, 3(r3)
	beqi	r2, 2, beq_then.8999
	lw	r5, 8(r3)
	j	beq_cont.9000
beq_then.8999:
	addi	r5, r0, 1				# li	r5, 1
beq_cont.9000:
	addi	r6, r0, 4				# li	r6, 4
	flup	f1, 0
	sw	r5, 12(r3)
	sw	r1, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 11
	sw	r1, 10(r2)
	lw	r1, 11(r3)
	sw	r1, 9(r2)
	lw	r5, 10(r3)
	sw	r5, 8(r2)
	lw	r5, 9(r3)
	sw	r5, 7(r2)
	lw	r5, 12(r3)
	sw	r5, 6(r2)
	lw	r5, 7(r3)
	sw	r5, 5(r2)
	lw	r5, 6(r3)
	sw	r5, 4(r2)
	lw	r6, 5(r3)
	sw	r6, 3(r2)
	lw	r7, 4(r3)
	sw	r7, 2(r2)
	lw	r7, 3(r3)
	sw	r7, 1(r2)
	lw	r8, 2(r3)
	sw	r8, 0(r2)
	lw	r8, 0(r3)
	lw	r9, 1(r3)
	add	r30, r9, r8
	sw	r2, 0(r30)
	beqi	r7, 3, beq_then.9001
	beqi	r7, 2, beq_then.9003
	j	beq_cont.9004
beq_then.9003:
	lw	r2, 8(r3)
	beqi	r2, 0, beq_then.9005
	addi	r2, r0, 0				# li	r2, 0
	j	beq_cont.9006
beq_then.9005:
	addi	r2, r0, 1				# li	r2, 1
beq_cont.9006:
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	vecunit_sgn.2880				#	bl	vecunit_sgn.2880
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.9004:
	j	beq_cont.9002
beq_then.9001:
	flw	f1, 0(r5)
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9008
	flup	f1, 0
	j	beq_cont.9009
beq_then.9008:
	lw	r30, 14(r3)				#lfd	f1, 14(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	sgn.2854				#	bl	sgn.2854
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
beq_cont.9009:
	lw	r1, 6(r3)
	fsw	r30, 0(r1)
	flw	f1, 1(r1)
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9010
	flup	f1, 0
	j	beq_cont.9011
beq_then.9010:
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	sgn.2854				#	bl	sgn.2854
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
beq_cont.9011:
	lw	r1, 6(r3)
	fsw	r30, 1(r1)
	flw	f1, 2(r1)
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9012
	flup	f1, 0
	j	beq_cont.9013
beq_then.9012:
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	sgn.2854				#	bl	sgn.2854
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 24(r3)				#stfd	f1, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
beq_cont.9013:
	lw	r1, 6(r3)
	fsw	r30, 2(r1)
beq_cont.9002:
	lw	r1, 5(r3)
	beqi	r1, 0, beq_then.9014
	lw	r1, 6(r3)
	lw	r2, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	rotate_quadratic_matrix.2985				#	bl	rotate_quadratic_matrix.2985
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.9015
beq_then.9014:
beq_cont.9015:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.8996:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
read_object.2990:
	lw	r2, 2(29)
	lw	r5, 1(29)
	addi	r6, r0, 60				# li	r6, 60
	ble	r6, r1, ble_then.9016
	sw	29, 0(r3)
	sw	r5, 1(r3)
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	29, r0, r2				# mr	29, r2
	sw	r30, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9017
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9017:
	lw	r1, 1(r3)
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	jr	r31				#	blr
ble_then.9016:
	jr	r31				#	blr
read_all_object.2992:
	lw	29, 1(29)
	addi	r1, r0, 0				# li	r1, 0
	lw	r28, 0(29)
	jr	r28
read_net_item.2994:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, -1, beq_then.9020
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	read_net_item.2994				#	bl	read_net_item.2994
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#	blr
beq_then.9020:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1				# li	r2, -1
	j	lib_create_array
read_or_network.2996:
	addi	r2, r0, 0				# li	r2, 0
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	read_net_item.2994				#	bl	read_net_item.2994
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r2)
	beqi	r1, -1, beq_then.9021
	lw	r1, 0(r3)
	addi	r5, r1, 1
	sw	r2, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	read_or_network.2996				#	bl	read_or_network.2996
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#	blr
beq_then.9021:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.2998:
	lw	r2, 1(29)
	addi	r5, r0, 0				# li	r5, 0
	sw	29, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	read_net_item.2994				#	bl	read_net_item.2994
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r1)
	beqi	r2, -1, beq_then.9022
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9022:
	jr	r31				#	blr
read_parameter.3000:
	lw	r1, 5(29)
	lw	r2, 4(29)
	lw	r5, 3(29)
	lw	r6, 2(29)
	lw	r7, 1(29)
	sw	r7, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	sw	r2, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	29, r0, r1				# mr	29, r1
	sw	r30, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	29, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	29, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	lw	29, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	read_or_network.2996				#	bl	read_or_network.2996
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#	blr
solver_rect_surface.3002:
	lw	r8, 1(29)
	add	r30, r2, r5
	flw	f4, 0(r30)
	sw	r8, 0(r3)
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	sw	r7, 4(r3)
	fmvtr	r30, f2
	sw	r30, 6(r3)				#stfd	f2, 6(r3)
	sw	r6, 8(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	sw	r5, 12(r3)
	sw	r2, 13(r3)
	sw	r1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9028
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.9028:
	lw	r1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	o_param_abc.2924				#	bl	o_param_abc.2924
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 14(r3)
	sw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	o_isinvert.2914				#	bl	o_isinvert.2914
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	flw	f1, 0(r30)
	sw	r1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	fisneg.2737				#	bl	fisneg.2737
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	xor.2851				#	bl	xor.2851
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 12(r3)
	lw	r5, 15(r3)
	add	r30, r5, r2
	flw	f1, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	fneg_cond.2856				#	bl	fneg_cond.2856
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r1, 12(r3)
	lw	r2, 13(r3)
	add	r30, r2, r1
	flw	f2, 0(r30)
	fdiv	f1, f1, f2
	lw	r1, 8(r3)
	add	r30, r2, r1
	flw	f2, 0(r30)
	fmul	f2, f1, f2
	lw	r30, 6(r3)				#lfd	f3, 6(r3)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	fabs.2748				#	bl	fabs.2748
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	lw	r2, 15(r3)
	add	r30, r2, r1
	flw	f2, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9030
	lw	r1, 4(r3)
	lw	r2, 13(r3)
	add	r30, r2, r1
	flw	f1, 0(r30)
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fadd	f1, f1, f3
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	fabs.2748				#	bl	fabs.2748
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	lw	r2, 15(r3)
	add	r30, r2, r1
	flw	f2, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9031
	lw	r1, 0(r3)
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	fsw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.9031:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.9030:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_rect.3011:
	lw	29, 1(29)
	addi	r5, r0, 0				# li	r5, 0
	addi	r6, r0, 1				# li	r6, 1
	addi	r7, r0, 2				# li	r7, 2
	fmvtr	r30, f1
	sw	r30, 0(r3)				#stfd	f1, 0(r3)
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	sw	29, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9032
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.9032:
	addi	r5, r0, 1				# li	r5, 1
	addi	r6, r0, 2				# li	r6, 2
	addi	r7, r0, 0				# li	r7, 0
	lw	r30, 4(r3)				#lfd	f1, 4(r3)
	fmvfr	f1, r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
	lw	r1, 7(r3)
	lw	r2, 6(r3)
	lw	29, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9033
	addi	r1, r0, 2				# li	r1, 2
	jr	r31				#	blr
beq_then.9033:
	addi	r5, r0, 2				# li	r5, 2
	addi	r6, r0, 0				# li	r6, 0
	addi	r7, r0, 1				# li	r7, 1
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	lw	r30, 4(r3)				#lfd	f3, 4(r3)
	fmvfr	f3, r30
	lw	r1, 7(r3)
	lw	r2, 6(r3)
	lw	29, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9034
	addi	r1, r0, 3				# li	r1, 3
	jr	r31				#	blr
beq_then.9034:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_surface.3017:
	lw	r5, 1(29)
	sw	r5, 0(r3)
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	sw	r2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	o_param_abc.2924				#	bl	o_param_abc.2924
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	sw	r2, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	fispos.2735				#	bl	fispos.2735
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9036
	lw	r30, 6(r3)				#lfd	f1, 6(r3)
	fmvfr	f1, r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	lw	r1, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	veciprod2.2886				#	bl	veciprod2.2886
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fsw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.9036:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
quadratic.3023:
	fmvtr	r30, f1
	sw	r30, 0(r3)				#stfd	f1, 0(r3)
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	o_param_a.2918				#	bl	o_param_a.2918
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	o_param_b.2920				#	bl	o_param_b.2920
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	o_param_c.2922				#	bl	o_param_c.2922
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	o_isrot.2916				#	bl	o_isrot.2916
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9038
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f3, f2, f1
	lw	r1, 6(r3)
	fmvtr	r30, f3
	sw	r30, 20(r3)				#stfd	f3, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	o_param_r1.2942				#	bl	o_param_r1.2942
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fmul	f3, f3, f2
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	fmvtr	r30, f3
	sw	r30, 24(r3)				#stfd	f3, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	o_param_r2.2944				#	bl	o_param_r2.2944
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 26(r3)				#stfd	f1, 26(r3)
	fmvtr	r30, f2
	sw	r30, 28(r3)				#stfd	f2, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	o_param_r3.2946				#	bl	o_param_r3.2946
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	jr	r31				#	blr
beq_then.9038:
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	jr	r31				#	blr
bilinear.3028:
	fmul	f7, f1, f4
	fmvtr	r30, f4
	sw	r30, 0(r3)				#stfd	f4, 0(r3)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	fmvtr	r30, f6
	sw	r30, 4(r3)				#stfd	f6, 4(r3)
	fmvtr	r30, f3
	sw	r30, 6(r3)				#stfd	f3, 6(r3)
	sw	r1, 8(r3)
	fmvtr	r30, f5
	sw	r30, 10(r3)				#stfd	f5, 10(r3)
	fmvtr	r30, f2
	sw	r30, 12(r3)				#stfd	f2, 12(r3)
	fmvtr	r30, f7
	sw	r30, 14(r3)				#stfd	f7, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	o_param_a.2918				#	bl	o_param_a.2918
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 12(r3)				#lfd	f3, 12(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r1, 8(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	fmvtr	r30, f4
	sw	r30, 18(r3)				#stfd	f4, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	o_param_b.2920				#	bl	o_param_b.2920
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	lw	r30, 6(r3)				#lfd	f3, 6(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r1, 8(r3)
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	fmvtr	r30, f4
	sw	r30, 22(r3)				#stfd	f4, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	o_param_c.2922				#	bl	o_param_c.2922
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 8(r3)
	fmvtr	r30, f1
	sw	r30, 24(r3)				#stfd	f1, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	o_isrot.2916				#	bl	o_isrot.2916
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9040
	lw	r30, 10(r3)				#lfd	f1, 10(r3)
	fmvfr	f1, r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f3, f2, f1
	lw	r30, 4(r3)				#lfd	f4, 4(r3)
	fmvfr	f4, r30
	lw	r30, 12(r3)				#lfd	f5, 12(r3)
	fmvfr	f5, r30
	fmul	f6, f5, f4
	fadd	f3, f3, f6
	lw	r1, 8(r3)
	fmvtr	r30, f3
	sw	r30, 26(r3)				#stfd	f3, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	o_param_r1.2942				#	bl	o_param_r1.2942
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	lw	r30, 0(r3)				#lfd	f4, 0(r3)
	fmvfr	f4, r30
	lw	r30, 6(r3)				#lfd	f5, 6(r3)
	fmvfr	f5, r30
	fmul	f5, f5, f4
	fadd	f2, f2, f5
	lw	r1, 8(r3)
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	fmvtr	r30, f2
	sw	r30, 30(r3)				#stfd	f2, 30(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	o_param_r2.2944				#	bl	o_param_r2.2944
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
	lw	r30, 12(r3)				#lfd	f4, 12(r3)
	fmvfr	f4, r30
	fmul	f3, f4, f3
	fadd	f2, f2, f3
	lw	r1, 8(r3)
	fmvtr	r30, f1
	sw	r30, 32(r3)				#stfd	f1, 32(r3)
	fmvtr	r30, f2
	sw	r30, 34(r3)				#stfd	f2, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	o_param_r3.2946				#	bl	o_param_r3.2946
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	fhalf.2744				#	bl	fhalf.2744
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	jr	r31				#	blr
beq_then.9040:
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	jr	r31				#	blr
solver_second.3036:
	lw	r5, 1(29)
	flw	f4, 0(r2)
	flw	f5, 1(r2)
	flw	f6, 2(r2)
	sw	r5, 0(r3)
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	sw	r1, 8(r3)
	sw	r2, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	quadratic.3023				#	bl	quadratic.3023
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9042
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.9042:
	lw	r1, 9(r3)
	flw	f1, 0(r1)
	flw	f2, 1(r1)
	flw	f3, 2(r1)
	lw	r30, 6(r3)				#lfd	f4, 6(r3)
	fmvfr	f4, r30
	lw	r30, 4(r3)				#lfd	f5, 4(r3)
	fmvfr	f5, r30
	lw	r30, 2(r3)				#lfd	f6, 2(r3)
	fmvfr	f6, r30
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	bilinear.3028				#	bl	bilinear.3028
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	lw	r30, 4(r3)				#lfd	f3, 4(r3)
	fmvfr	f3, r30
	lw	r30, 2(r3)				#lfd	f4, 2(r3)
	fmvfr	f4, r30
	lw	r1, 8(r3)
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	quadratic.3023				#	bl	quadratic.3023
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	o_form.2910				#	bl	o_form.2910
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 3, beq_then.9043
	lw	r30, 14(r3)				#lfd	f1, 14(r3)
	fmvfr	f1, r30
	j	beq_cont.9044
beq_then.9043:
	flup	f1, 2
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
beq_cont.9044:
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	lw	r30, 10(r3)				#lfd	f3, 10(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	fispos.2735				#	bl	fispos.2735
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9045
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	o_isinvert.2914				#	bl	o_isinvert.2914
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9046
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	j	beq_cont.9047
beq_then.9046:
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.9047:
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fsw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.9045:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver.3042:
	lw	r6, 4(29)
	lw	r7, 3(29)
	lw	r8, 2(29)
	lw	r9, 1(29)
	add	r30, r9, r1
	lw	r1, 0(r30)
	flw	f1, 0(r5)
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r2, 2(r3)
	sw	r8, 3(r3)
	sw	r1, 4(r3)
	sw	r5, 5(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	o_param_x.2926				#	bl	o_param_x.2926
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 5(r3)
	flw	f2, 1(r1)
	lw	r2, 4(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	fmvtr	r30, f2
	sw	r30, 10(r3)				#stfd	f2, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	o_param_y.2928				#	bl	o_param_y.2928
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 5(r3)
	flw	f2, 2(r1)
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	fmvtr	r30, f2
	sw	r30, 14(r3)				#stfd	f2, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	o_param_z.2930				#	bl	o_param_z.2930
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	o_form.2910				#	bl	o_form.2910
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 1, beq_then.9048
	beqi	r1, 2, beq_then.9049
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	lw	r30, 16(r3)				#lfd	f3, 16(r3)
	fmvfr	f3, r30
	lw	r1, 4(r3)
	lw	r2, 2(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9049:
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	lw	r30, 16(r3)				#lfd	f3, 16(r3)
	fmvfr	f3, r30
	lw	r1, 4(r3)
	lw	r2, 2(r3)
	lw	29, 1(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9048:
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	lw	r30, 16(r3)				#lfd	f3, 16(r3)
	fmvfr	f3, r30
	lw	r1, 4(r3)
	lw	r2, 2(r3)
	lw	29, 3(r3)
	lw	r28, 0(29)
	jr	r28
solver_rect_fast.3046:
	lw	r6, 1(29)
	flw	f4, 0(r5)
	fsub	f4, f4, f1
	flw	f5, 1(r5)
	fmul	f4, f4, f5
	flw	f5, 1(r2)
	fmul	f5, f4, f5
	fadd	f5, f5, f2
	sw	r6, 0(r3)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	sw	r5, 6(r3)
	fmvtr	r30, f3
	sw	r30, 8(r3)				#stfd	f3, 8(r3)
	fmvtr	r30, f4
	sw	r30, 10(r3)				#stfd	f4, 10(r3)
	sw	r2, 12(r3)
	sw	r1, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f5				# fmr	f1, f5
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	fabs.2748				#	bl	fabs.2748
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	o_param_b.2920				#	bl	o_param_b.2920
	addi	r3, r3, -17
	lw	r30, 16(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f1, 14(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9052
	lw	r1, 12(r3)
	flw	f1, 2(r1)
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 8(r3)				#lfd	f3, 8(r3)
	fmvfr	f3, r30
	fadd	f1, f1, f3
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	fabs.2748				#	bl	fabs.2748
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	o_param_c.2922				#	bl	o_param_c.2922
	addi	r3, r3, -19
	lw	r30, 18(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9054
	lw	r1, 6(r3)
	flw	f1, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9056
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.9057
beq_then.9056:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.9057:
	j	beq_cont.9055
beq_then.9054:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.9055:
	j	beq_cont.9053
beq_then.9052:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.9053:
	beqi	r1, 0, beq_then.9058
	lw	r1, 0(r3)
	lw	r30, 10(r3)				#lfd	f1, 10(r3)
	fmvfr	f1, r30
	fsw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.9058:
	lw	r1, 6(r3)
	flw	f1, 2(r1)
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	flw	f3, 3(r1)
	fmul	f1, f1, f3
	lw	r2, 12(r3)
	flw	f3, 0(r2)
	fmul	f3, f1, f3
	lw	r30, 2(r3)				#lfd	f4, 2(r3)
	fmvfr	f4, r30
	fadd	f3, f3, f4
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	fabs.2748				#	bl	fabs.2748
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	o_param_a.2918				#	bl	o_param_a.2918
	addi	r3, r3, -23
	lw	r30, 22(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9059
	lw	r1, 12(r3)
	flw	f1, 2(r1)
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 8(r3)				#lfd	f3, 8(r3)
	fmvfr	f3, r30
	fadd	f1, f1, f3
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	fabs.2748				#	bl	fabs.2748
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	o_param_c.2922				#	bl	o_param_c.2922
	addi	r3, r3, -25
	lw	r30, 24(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9061
	lw	r1, 6(r3)
	flw	f1, 3(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9063
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.9064
beq_then.9063:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.9064:
	j	beq_cont.9062
beq_then.9061:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.9062:
	j	beq_cont.9060
beq_then.9059:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.9060:
	beqi	r1, 0, beq_then.9065
	lw	r1, 0(r3)
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	fsw	r30, 0(r1)
	addi	r1, r0, 2				# li	r1, 2
	jr	r31				#	blr
beq_then.9065:
	lw	r1, 6(r3)
	flw	f1, 4(r1)
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	flw	f2, 5(r1)
	fmul	f1, f1, f2
	lw	r2, 12(r3)
	flw	f2, 0(r2)
	fmul	f2, f1, f2
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	fmvtr	r30, f1
	sw	r30, 24(r3)				#stfd	f1, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	fabs.2748				#	bl	fabs.2748
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	fmvtr	r30, f1
	sw	r30, 26(r3)				#stfd	f1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	o_param_a.2918				#	bl	o_param_a.2918
	addi	r3, r3, -29
	lw	r30, 28(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f1, 26(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9066
	lw	r1, 12(r3)
	flw	f1, 1(r1)
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 4(r3)				#lfd	f3, 4(r3)
	fmvfr	f3, r30
	fadd	f1, f1, f3
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	fabs.2748				#	bl	fabs.2748
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	o_param_b.2920				#	bl	o_param_b.2920
	addi	r3, r3, -31
	lw	r30, 30(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 28(r3)				#lfd	f1, 28(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9068
	lw	r1, 6(r3)
	flw	f1, 5(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9070
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.9071
beq_then.9070:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.9071:
	j	beq_cont.9069
beq_then.9068:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.9069:
	j	beq_cont.9067
beq_then.9066:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.9067:
	beqi	r1, 0, beq_then.9072
	lw	r1, 0(r3)
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	fsw	r30, 0(r1)
	addi	r1, r0, 3				# li	r1, 3
	jr	r31				#	blr
beq_then.9072:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_surface_fast.3053:
	lw	r1, 1(29)
	flw	f4, 0(r2)
	sw	r1, 0(r3)
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	sw	r2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	fisneg.2737				#	bl	fisneg.2737
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9074
	lw	r1, 8(r3)
	flw	f1, 1(r1)
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	flw	f2, 2(r1)
	lw	r30, 4(r3)				#lfd	f3, 4(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 3(r1)
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r1, 0(r3)
	fsw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.9074:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_second_fast.3059:
	lw	r5, 1(29)
	flw	f4, 0(r2)
	sw	r5, 0(r3)
	fmvtr	r30, f4
	sw	r30, 2(r3)				#stfd	f4, 2(r3)
	sw	r1, 4(r3)
	fmvtr	r30, f3
	sw	r30, 6(r3)				#stfd	f3, 6(r3)
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	sw	r2, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9077
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.9077:
	lw	r1, 12(r3)
	flw	f1, 1(r1)
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	flw	f3, 2(r1)
	lw	r30, 8(r3)				#lfd	f4, 8(r3)
	fmvfr	f4, r30
	fmul	f3, f3, f4
	fadd	f1, f1, f3
	flw	f3, 3(r1)
	lw	r30, 6(r3)				#lfd	f5, 6(r3)
	fmvfr	f5, r30
	fmul	f3, f3, f5
	fadd	f1, f1, f3
	lw	r2, 4(r3)
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	fadd	f3, f0, f5				# fmr	f3, f5
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f4				# fmr	f2, f4
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	quadratic.3023				#	bl	quadratic.3023
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	o_form.2910				#	bl	o_form.2910
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 3, beq_then.9079
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	j	beq_cont.9080
beq_then.9079:
	flup	f1, 2
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
beq_cont.9080:
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	fispos.2735				#	bl	fispos.2735
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9081
	lw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	o_isinvert.2914				#	bl	o_isinvert.2914
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9082
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 12(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	r30, 0(r1)
	j	beq_cont.9083
beq_then.9082:
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 12(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	r30, 0(r1)
beq_cont.9083:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.9081:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_fast.3065:
	lw	r6, 4(29)
	lw	r7, 3(29)
	lw	r8, 2(29)
	lw	r9, 1(29)
	add	r30, r9, r1
	lw	r9, 0(r30)
	flw	f1, 0(r5)
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r8, 2(r3)
	sw	r1, 3(r3)
	sw	r2, 4(r3)
	sw	r9, 5(r3)
	sw	r5, 6(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r9				# mr	r1, r9
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	o_param_x.2926				#	bl	o_param_x.2926
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 6(r3)
	flw	f2, 1(r1)
	lw	r2, 5(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	fmvtr	r30, f2
	sw	r30, 12(r3)				#stfd	f2, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	o_param_y.2928				#	bl	o_param_y.2928
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 6(r3)
	flw	f2, 2(r1)
	lw	r1, 5(r3)
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	fmvtr	r30, f2
	sw	r30, 16(r3)				#stfd	f2, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	o_param_z.2930				#	bl	o_param_z.2930
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	d_const.2971				#	bl	d_const.2971
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r2, 5(r3)
	sw	r1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	o_form.2910				#	bl	o_form.2910
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 1, beq_then.9085
	beqi	r1, 2, beq_then.9086
	lw	r30, 10(r3)				#lfd	f1, 10(r3)
	fmvfr	f1, r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	lw	r30, 18(r3)				#lfd	f3, 18(r3)
	fmvfr	f3, r30
	lw	r1, 5(r3)
	lw	r2, 20(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9086:
	lw	r30, 10(r3)				#lfd	f1, 10(r3)
	fmvfr	f1, r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	lw	r30, 18(r3)				#lfd	f3, 18(r3)
	fmvfr	f3, r30
	lw	r1, 5(r3)
	lw	r2, 20(r3)
	lw	29, 1(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9085:
	lw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f1, 10(r3)
	fmvfr	f1, r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	lw	r30, 18(r3)				#lfd	f3, 18(r3)
	fmvfr	f3, r30
	lw	r1, 5(r3)
	lw	r5, 20(r3)
	lw	29, 2(r3)
	lw	r28, 0(29)
	jr	r28
solver_surface_fast2.3069:
	lw	r1, 1(29)
	flw	f1, 0(r2)
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	fisneg.2737				#	bl	fisneg.2737
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9087
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r1, 1(r3)
	flw	f2, 3(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.9087:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_second_fast2.3076:
	lw	r6, 1(29)
	flw	f4, 0(r2)
	sw	r6, 0(r3)
	sw	r1, 1(r3)
	fmvtr	r30, f4
	sw	r30, 2(r3)				#stfd	f4, 2(r3)
	sw	r5, 4(r3)
	fmvtr	r30, f3
	sw	r30, 6(r3)				#stfd	f3, 6(r3)
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	sw	r2, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9089
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.9089:
	lw	r1, 12(r3)
	flw	f1, 1(r1)
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	flw	f2, 2(r1)
	lw	r30, 8(r3)				#lfd	f3, 8(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 3(r1)
	lw	r30, 6(r3)				#lfd	f3, 6(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r2, 4(r3)
	flw	f2, 3(r2)
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	fmvtr	r30, f2
	sw	r30, 16(r3)				#stfd	f2, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	fispos.2735				#	bl	fispos.2735
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9091
	lw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	o_isinvert.2914				#	bl	o_isinvert.2914
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9092
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 12(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	r30, 0(r1)
	j	beq_cont.9093
beq_then.9092:
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 12(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	r30, 0(r1)
beq_cont.9093:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.9091:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_fast2.3083:
	lw	r5, 4(29)
	lw	r6, 3(29)
	lw	r7, 2(29)
	lw	r8, 1(29)
	add	r30, r8, r1
	lw	r8, 0(r30)
	sw	r6, 0(r3)
	sw	r5, 1(r3)
	sw	r7, 2(r3)
	sw	r8, 3(r3)
	sw	r1, 4(r3)
	sw	r2, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r8				# mr	r1, r8
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	o_param_ctbl.2948				#	bl	o_param_ctbl.2948
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f1, 0(r1)
	flw	f2, 1(r1)
	flw	f3, 2(r1)
	lw	r2, 5(r3)
	sw	r1, 6(r3)
	fmvtr	r30, f3
	sw	r30, 8(r3)				#stfd	f3, 8(r3)
	fmvtr	r30, f2
	sw	r30, 10(r3)				#stfd	f2, 10(r3)
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	d_const.2971				#	bl	d_const.2971
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r2, 3(r3)
	sw	r1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	o_form.2910				#	bl	o_form.2910
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 1, beq_then.9095
	beqi	r1, 2, beq_then.9096
	lw	r30, 12(r3)				#lfd	f1, 12(r3)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 8(r3)				#lfd	f3, 8(r3)
	fmvfr	f3, r30
	lw	r1, 3(r3)
	lw	r2, 14(r3)
	lw	r5, 6(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9096:
	lw	r30, 12(r3)				#lfd	f1, 12(r3)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 8(r3)				#lfd	f3, 8(r3)
	fmvfr	f3, r30
	lw	r1, 3(r3)
	lw	r2, 14(r3)
	lw	r5, 6(r3)
	lw	29, 1(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9095:
	lw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f1, 12(r3)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 8(r3)				#lfd	f3, 8(r3)
	fmvfr	f3, r30
	lw	r1, 3(r3)
	lw	r5, 14(r3)
	lw	29, 2(r3)
	lw	r28, 0(29)
	jr	r28
setup_rect_table.3086:
	addi	r5, r0, 6				# li	r5, 6
	flup	f1, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	flw	f1, 0(r2)
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9097
	flup	f1, 0
	lw	r1, 2(r3)
	fsw	r30, 1(r1)
	j	beq_cont.9098
beq_then.9097:
	lw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	o_isinvert.2914				#	bl	o_isinvert.2914
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	flw	f1, 0(r2)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	fisneg.2737				#	bl	fisneg.2737
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	xor.2851				#	bl	xor.2851
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	o_param_a.2918				#	bl	o_param_a.2918
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	fneg_cond.2856				#	bl	fneg_cond.2856
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	fsw	r30, 0(r1)
	flup	f1, 2
	lw	r2, 1(r3)
	flw	f2, 0(r2)
	fdiv	f1, f1, f2
	fsw	r30, 1(r1)
beq_cont.9098:
	lw	r2, 1(r3)
	flw	f1, 1(r2)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9099
	flup	f1, 0
	lw	r1, 2(r3)
	fsw	r30, 3(r1)
	j	beq_cont.9100
beq_then.9099:
	lw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	o_isinvert.2914				#	bl	o_isinvert.2914
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	flw	f1, 1(r2)
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	fisneg.2737				#	bl	fisneg.2737
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	xor.2851				#	bl	xor.2851
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	o_param_b.2920				#	bl	o_param_b.2920
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	fneg_cond.2856				#	bl	fneg_cond.2856
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	fsw	r30, 2(r1)
	flup	f1, 2
	lw	r2, 1(r3)
	flw	f2, 1(r2)
	fdiv	f1, f1, f2
	fsw	r30, 3(r1)
beq_cont.9100:
	lw	r2, 1(r3)
	flw	f1, 2(r2)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9101
	flup	f1, 0
	lw	r1, 2(r3)
	fsw	r30, 5(r1)
	j	beq_cont.9102
beq_then.9101:
	lw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	o_isinvert.2914				#	bl	o_isinvert.2914
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	flw	f1, 2(r2)
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	fisneg.2737				#	bl	fisneg.2737
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	xor.2851				#	bl	xor.2851
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	o_param_c.2922				#	bl	o_param_c.2922
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	fneg_cond.2856				#	bl	fneg_cond.2856
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	fsw	r30, 4(r1)
	flup	f1, 2
	lw	r2, 1(r3)
	flw	f2, 2(r2)
	fdiv	f1, f1, f2
	fsw	r30, 5(r1)
beq_cont.9102:
	jr	r31				#	blr
setup_surface_table.3089:
	addi	r5, r0, 4				# li	r5, 4
	flup	f1, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	flw	f1, 0(r2)
	lw	r5, 0(r3)
	sw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	o_param_a.2918				#	bl	o_param_a.2918
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	lw	r2, 0(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	o_param_b.2920				#	bl	o_param_b.2920
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	fmvtr	r30, f2
	sw	r30, 12(r3)				#stfd	f2, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	o_param_c.2922				#	bl	o_param_c.2922
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	fispos.2735				#	bl	fispos.2735
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9104
	flup	f1, 11
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 2(r3)
	fsw	r30, 0(r1)
	lw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	o_param_a.2918				#	bl	o_param_a.2918
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	fsw	r30, 1(r1)
	lw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	o_param_b.2920				#	bl	o_param_b.2920
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	fsw	r30, 2(r1)
	lw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	o_param_c.2922				#	bl	o_param_c.2922
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	fsw	r30, 3(r1)
	j	beq_cont.9105
beq_then.9104:
	flup	f1, 0
	lw	r1, 2(r3)
	fsw	r30, 0(r1)
beq_cont.9105:
	jr	r31				#	blr
setup_second_table.3092:
	addi	r5, r0, 5				# li	r5, 5
	flup	f1, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	flw	f1, 0(r2)
	flw	f2, 1(r2)
	flw	f3, 2(r2)
	lw	r5, 0(r3)
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	quadratic.3023				#	bl	quadratic.3023
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	lw	r2, 0(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	fmvtr	r30, f2
	sw	r30, 6(r3)				#stfd	f2, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	o_param_a.2918				#	bl	o_param_a.2918
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	lw	r2, 0(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	fmvtr	r30, f2
	sw	r30, 10(r3)				#stfd	f2, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	o_param_b.2920				#	bl	o_param_b.2920
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	lw	r2, 0(r3)
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	fmvtr	r30, f2
	sw	r30, 14(r3)				#stfd	f2, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	o_param_c.2922				#	bl	o_param_c.2922
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fsw	r30, 0(r1)
	lw	r2, 0(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	o_isrot.2916				#	bl	o_isrot.2916
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9107
	lw	r1, 1(r3)
	flw	f1, 2(r1)
	lw	r2, 0(r3)
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	o_param_r2.2944				#	bl	o_param_r2.2944
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	lw	r2, 0(r3)
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	fmvtr	r30, f2
	sw	r30, 22(r3)				#stfd	f2, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	o_param_r3.2946				#	bl	o_param_r3.2946
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	fhalf.2744				#	bl	fhalf.2744
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 2(r3)
	fsw	r30, 1(r1)
	lw	r2, 1(r3)
	flw	f1, 2(r2)
	lw	r5, 0(r3)
	fmvtr	r30, f1
	sw	r30, 24(r3)				#stfd	f1, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	o_param_r1.2942				#	bl	o_param_r1.2942
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	lw	r2, 0(r3)
	fmvtr	r30, f1
	sw	r30, 26(r3)				#stfd	f1, 26(r3)
	fmvtr	r30, f2
	sw	r30, 28(r3)				#stfd	f2, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	o_param_r3.2946				#	bl	o_param_r3.2946
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	fhalf.2744				#	bl	fhalf.2744
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 2(r3)
	fsw	r30, 2(r1)
	lw	r2, 1(r3)
	flw	f1, 1(r2)
	lw	r5, 0(r3)
	fmvtr	r30, f1
	sw	r30, 30(r3)				#stfd	f1, 30(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	o_param_r1.2942				#	bl	o_param_r1.2942
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 32(r3)				#stfd	f1, 32(r3)
	fmvtr	r30, f2
	sw	r30, 34(r3)				#stfd	f2, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	o_param_r2.2944				#	bl	o_param_r2.2944
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	fhalf.2744				#	bl	fhalf.2744
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 2(r3)
	fsw	r30, 3(r1)
	j	beq_cont.9108
beq_then.9107:
	lw	r1, 2(r3)
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	fsw	r30, 1(r1)
	lw	r30, 12(r3)				#lfd	f1, 12(r3)
	fmvfr	f1, r30
	fsw	r30, 2(r1)
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	fsw	r30, 3(r1)
beq_cont.9108:
	lw	r30, 4(r3)				#lfd	f1, 4(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	fiszero.2739				#	bl	fiszero.2739
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9109
	j	beq_cont.9110
beq_then.9109:
	flup	f1, 2
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 2(r3)
	fsw	r30, 4(r1)
beq_cont.9110:
	lw	r1, 2(r3)
	jr	r31				#	blr
iter_setup_dirvec_constants.3095:
	lw	r5, 1(29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.9111
	jr	r31				#	blr
ble_then.9111:
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	29, 0(r3)
	sw	r2, 1(r3)
	sw	r5, 2(r3)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	d_const.2971				#	bl	d_const.2971
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	o_form.2910				#	bl	o_form.2910
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 1, beq_then.9113
	beqi	r1, 2, beq_then.9115
	lw	r1, 5(r3)
	lw	r2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	setup_second_table.3092				#	bl	setup_second_table.3092
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.9116
beq_then.9115:
	lw	r1, 5(r3)
	lw	r2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	setup_surface_table.3089				#	bl	setup_surface_table.3089
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.9116:
	j	beq_cont.9114
beq_then.9113:
	lw	r1, 5(r3)
	lw	r2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	setup_rect_table.3086				#	bl	setup_rect_table.3086
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.9114:
	addi	r2, r2, -1
	lw	r1, 3(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
setup_dirvec_constants.3098:
	lw	r2, 2(29)
	lw	29, 1(29)
	lw	r2, 0(r2)
	addi	r2, r2, -1
	lw	r28, 0(29)
	jr	r28
setup_startp_constants.3100:
	lw	r5, 1(29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.9117
	jr	r31				#	blr
ble_then.9117:
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	29, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	o_param_ctbl.2948				#	bl	o_param_ctbl.2948
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	o_form.2910				#	bl	o_form.2910
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	flw	f1, 0(r2)
	lw	r5, 3(r3)
	sw	r1, 5(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	o_param_x.2926				#	bl	o_param_x.2926
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 4(r3)
	fsw	r30, 0(r1)
	lw	r2, 2(r3)
	flw	f1, 1(r2)
	lw	r5, 3(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	o_param_y.2928				#	bl	o_param_y.2928
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 4(r3)
	fsw	r30, 1(r1)
	lw	r2, 2(r3)
	flw	f1, 2(r2)
	lw	r5, 3(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	o_param_z.2930				#	bl	o_param_z.2930
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 4(r3)
	fsw	r30, 2(r1)
	lw	r2, 5(r3)
	beqi	r2, 2, beq_then.9119
	blei	r2, 2, ble_then.9121
	flw	f1, 0(r1)
	flw	f2, 1(r1)
	flw	f3, 2(r1)
	lw	r5, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	quadratic.3023				#	bl	quadratic.3023
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	beqi	r1, 3, beq_then.9123
	j	beq_cont.9124
beq_then.9123:
	flup	f2, 2
	fsub	f1, f1, f2
beq_cont.9124:
	lw	r1, 4(r3)
	fsw	r30, 3(r1)
	j	ble_cont.9122
ble_then.9121:
ble_cont.9122:
	j	beq_cont.9120
beq_then.9119:
	lw	r2, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	o_param_abc.2924				#	bl	o_param_abc.2924
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	flw	f1, 0(r2)
	flw	f2, 1(r2)
	flw	f3, 2(r2)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	veciprod2.2886				#	bl	veciprod2.2886
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fsw	r30, 3(r1)
beq_cont.9120:
	lw	r1, 1(r3)
	addi	r2, r1, -1
	lw	r1, 2(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
setup_startp.3103:
	lw	r2, 3(29)
	lw	r5, 2(29)
	lw	r6, 1(29)
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r1, 0(r1)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	lw	29, 1(r3)
	lw	r28, 0(29)
	jr	r28
is_rect_outside.3105:
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	fabs.2748				#	bl	fabs.2748
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	o_param_a.2918				#	bl	o_param_a.2918
	addi	r3, r3, -9
	lw	r30, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f1, 6(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9126
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	fabs.2748				#	bl	fabs.2748
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	o_param_b.2920				#	bl	o_param_b.2920
	addi	r3, r3, -11
	lw	r30, 10(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9128
	lw	r30, 0(r3)				#lfd	f1, 0(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	fabs.2748				#	bl	fabs.2748
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	o_param_c.2922				#	bl	o_param_c.2922
	addi	r3, r3, -13
	lw	r30, 12(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f1, 10(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.9129
beq_then.9128:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.9129:
	j	beq_cont.9127
beq_then.9126:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.9127:
	beqi	r1, 0, beq_then.9130
	lw	r1, 4(r3)
	j	o_isinvert.2914
beq_then.9130:
	lw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	o_isinvert.2914				#	bl	o_isinvert.2914
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9131
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.9131:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
is_plane_outside.3110:
	sw	r1, 0(r3)
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	o_param_abc.2924				#	bl	o_param_abc.2924
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f1, 6(r3)
	fmvfr	f1, r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	veciprod2.2886				#	bl	veciprod2.2886
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	o_isinvert.2914				#	bl	o_isinvert.2914
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	sw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	fisneg.2737				#	bl	fisneg.2737
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	xor.2851				#	bl	xor.2851
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9133
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.9133:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
is_second_outside.3115:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3023				#	bl	quadratic.3023
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	o_form.2910				#	bl	o_form.2910
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 3, beq_then.9135
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	j	beq_cont.9136
beq_then.9135:
	flup	f1, 2
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
beq_cont.9136:
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	o_isinvert.2914				#	bl	o_isinvert.2914
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f1, 4(r3)
	fmvfr	f1, r30
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	fisneg.2737				#	bl	fisneg.2737
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	xor.2851				#	bl	xor.2851
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9137
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.9137:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
is_outside.3120:
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	sw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	o_param_x.2926				#	bl	o_param_x.2926
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	o_param_y.2928				#	bl	o_param_y.2928
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	o_param_z.2930				#	bl	o_param_z.2930
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	o_form.2910				#	bl	o_form.2910
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 1, beq_then.9139
	beqi	r1, 2, beq_then.9140
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 12(r3)				#lfd	f3, 12(r3)
	fmvfr	f3, r30
	lw	r1, 4(r3)
	j	is_second_outside.3115
beq_then.9140:
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 12(r3)				#lfd	f3, 12(r3)
	fmvfr	f3, r30
	lw	r1, 4(r3)
	j	is_plane_outside.3110
beq_then.9139:
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 12(r3)				#lfd	f3, 12(r3)
	fmvfr	f3, r30
	lw	r1, 4(r3)
	j	is_rect_outside.3105
check_all_inside.3125:
	lw	r5, 1(29)
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	r6, -1, beq_then.9141
	add	r30, r5, r6
	lw	r5, 0(r30)
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	sw	r2, 6(r3)
	sw	29, 7(r3)
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	is_outside.3120				#	bl	is_outside.3120
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9142
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.9142:
	lw	r1, 8(r3)
	addi	r1, r1, 1
	lw	r30, 4(r3)				#lfd	f1, 4(r3)
	fmvfr	f1, r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
	lw	r2, 6(r3)
	lw	29, 7(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9141:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
shadow_check_and_group.3131:
	lw	r5, 7(29)
	lw	r6, 6(29)
	lw	r7, 5(29)
	lw	r8, 4(29)
	lw	r9, 3(29)
	lw	r10, 2(29)
	lw	r11, 1(29)
	add	r30, r2, r1
	lw	r12, 0(r30)
	beqi	r12, -1, beq_then.9143
	add	r30, r2, r1
	lw	r12, 0(r30)
	sw	r11, 0(r3)
	sw	r10, 1(r3)
	sw	r9, 2(r3)
	sw	r2, 3(r3)
	sw	29, 4(r3)
	sw	r1, 5(r3)
	sw	r12, 6(r3)
	sw	r7, 7(r3)
	sw	r6, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r12				# mr	r1, r12
	add	29, r0, r5				# mr	29, r5
	add	r5, r0, r10				# mr	r5, r10
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 8(r3)
	flw	f1, 0(r2)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	beqi	r1, 0, beq_then.9145
	flup	f2, 28
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.9146
beq_then.9145:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.9146:
	beqi	r1, 0, beq_then.9147
	flup	f1, 29
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 2(r3)
	flw	f2, 0(r1)
	fmul	f2, f2, f1
	lw	r2, 1(r3)
	flw	f3, 0(r2)
	fadd	f2, f2, f3
	flw	f3, 1(r1)
	fmul	f3, f3, f1
	flw	f4, 1(r2)
	fadd	f3, f3, f4
	flw	f4, 2(r1)
	fmul	f1, f4, f1
	flw	f4, 2(r2)
	fadd	f1, f1, f4
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 3(r3)
	lw	29, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9148
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.9148:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	29, 4(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9147:
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	o_isinvert.2914				#	bl	o_isinvert.2914
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9149
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	29, 4(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9149:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.9143:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
shadow_check_one_or_group.3134:
	lw	r5, 2(29)
	lw	r6, 1(29)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	r7, -1, beq_then.9150
	add	r30, r6, r7
	lw	r6, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	sw	r2, 0(r3)
	sw	29, 1(r3)
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	add	29, r0, r5				# mr	29, r5
	sw	r30, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9151
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.9151:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	lw	29, 1(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9150:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
shadow_check_one_or_matrix.3137:
	lw	r5, 5(29)
	lw	r6, 4(29)
	lw	r7, 3(29)
	lw	r8, 2(29)
	lw	r9, 1(29)
	add	r30, r2, r1
	lw	r10, 0(r30)
	lw	r11, 0(r10)
	beqi	r11, -1, beq_then.9152
	addi	r12, r0, 99				# li	r12, 99
	sw	r10, 0(r3)
	sw	r7, 1(r3)
	sw	r2, 2(r3)
	sw	29, 3(r3)
	sw	r1, 4(r3)
	beq	r11, r12, beq_then.9153
	sw	r6, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r11				# mr	r1, r11
	add	29, r0, r5				# mr	29, r5
	add	r5, r0, r9				# mr	r5, r9
	sw	r30, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9155
	lw	r1, 5(r3)
	flw	f1, 0(r1)
	flup	f2, 30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9157
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 0(r3)
	lw	29, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9159
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.9160
beq_then.9159:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.9160:
	j	beq_cont.9158
beq_then.9157:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.9158:
	j	beq_cont.9156
beq_then.9155:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.9156:
	j	beq_cont.9154
beq_then.9153:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.9154:
	beqi	r1, 0, beq_then.9161
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 0(r3)
	lw	29, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9162
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.9162:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	29, 3(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9161:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	29, 3(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9152:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solve_each_element.3140:
	lw	r6, 9(29)
	lw	r7, 8(29)
	lw	r8, 7(29)
	lw	r9, 6(29)
	lw	r10, 5(29)
	lw	r11, 4(29)
	lw	r12, 3(29)
	lw	r13, 2(29)
	lw	r14, 1(29)
	add	r30, r2, r1
	lw	r15, 0(r30)
	beqi	r15, -1, beq_then.9163
	sw	r11, 0(r3)
	sw	r13, 1(r3)
	sw	r12, 2(r3)
	sw	r14, 3(r3)
	sw	r7, 4(r3)
	sw	r6, 5(r3)
	sw	r8, 6(r3)
	sw	r5, 7(r3)
	sw	r2, 8(r3)
	sw	29, 9(r3)
	sw	r1, 10(r3)
	sw	r15, 11(r3)
	sw	r10, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r15				# mr	r1, r15
	add	29, r0, r9				# mr	29, r9
	add	r5, r0, r7				# mr	r5, r7
	sw	r30, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9164
	lw	r2, 6(r3)
	flw	f2, 0(r2)
	flup	f1, 0
	sw	r1, 13(r3)
	fmvtr	r30, f2
	sw	r30, 14(r3)				#stfd	f2, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9165
	lw	r1, 5(r3)
	flw	f2, 0(r1)
	lw	r30, 14(r3)				#lfd	f1, 14(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9167
	flup	f1, 29
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 7(r3)
	flw	f2, 0(r1)
	fmul	f2, f2, f1
	lw	r2, 4(r3)
	flw	f3, 0(r2)
	fadd	f2, f2, f3
	flw	f3, 1(r1)
	fmul	f3, f3, f1
	flw	f4, 1(r2)
	fadd	f3, f3, f4
	flw	f4, 2(r1)
	fmul	f4, f4, f1
	flw	f5, 2(r2)
	fadd	f4, f4, f5
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 8(r3)
	lw	29, 3(r3)
	fmvtr	r30, f4
	sw	r30, 16(r3)				#stfd	f4, 16(r3)
	fmvtr	r30, f3
	sw	r30, 18(r3)				#stfd	f3, 18(r3)
	fmvtr	r30, f2
	sw	r30, 20(r3)				#stfd	f2, 20(r3)
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r30, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9169
	lw	r1, 5(r3)
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	fsw	r30, 0(r1)
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	lw	r30, 16(r3)				#lfd	f3, 16(r3)
	fmvfr	f3, r30
	lw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	vecset.2862				#	bl	vecset.2862
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	lw	r2, 11(r3)
	sw	r2, 0(r1)
	lw	r1, 0(r3)
	lw	r2, 13(r3)
	sw	r2, 0(r1)
	j	beq_cont.9170
beq_then.9169:
beq_cont.9170:
	j	beq_cont.9168
beq_then.9167:
beq_cont.9168:
	j	beq_cont.9166
beq_then.9165:
beq_cont.9166:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	29, 9(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9164:
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	o_isinvert.2914				#	bl	o_isinvert.2914
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9171
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	29, 9(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9171:
	jr	r31				#	blr
beq_then.9163:
	jr	r31				#	blr
solve_one_or_network.3144:
	lw	r6, 2(29)
	lw	r7, 1(29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	r8, -1, beq_then.9174
	add	r30, r7, r8
	lw	r7, 0(r30)
	addi	r8, r0, 0				# li	r8, 0
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	29, 2(r3)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	add	29, r0, r6				# mr	29, r6
	sw	r30, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	29, 2(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9174:
	jr	r31				#	blr
trace_or_matrix.3148:
	lw	r6, 5(29)
	lw	r7, 4(29)
	lw	r8, 3(29)
	lw	r9, 2(29)
	lw	r10, 1(29)
	add	r30, r2, r1
	lw	r11, 0(r30)
	lw	r12, 0(r11)
	beqi	r12, -1, beq_then.9176
	addi	r13, r0, 99				# li	r13, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	29, 2(r3)
	sw	r1, 3(r3)
	beq	r12, r13, beq_then.9177
	sw	r11, 4(r3)
	sw	r10, 5(r3)
	sw	r6, 6(r3)
	sw	r8, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r12				# mr	r1, r12
	add	29, r0, r9				# mr	29, r9
	add	r5, r0, r7				# mr	r5, r7
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9179
	lw	r1, 7(r3)
	flw	f1, 0(r1)
	lw	r1, 6(r3)
	flw	f2, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9181
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 4(r3)
	lw	r5, 0(r3)
	lw	29, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.9182
beq_then.9181:
beq_cont.9182:
	j	beq_cont.9180
beq_then.9179:
beq_cont.9180:
	j	beq_cont.9178
beq_then.9177:
	addi	r6, r0, 1				# li	r6, 1
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r11				# mr	r2, r11
	add	r1, r0, r6				# mr	r1, r6
	add	29, r0, r10				# mr	29, r10
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.9178:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	29, 2(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9176:
	jr	r31				#	blr
judge_intersection.3152:
	lw	r2, 3(29)
	lw	r5, 2(29)
	lw	r6, 1(29)
	flup	f1, 31
	fsw	r30, 0(r5)
	addi	r7, r0, 0				# li	r7, 0
	lw	r6, 0(r6)
	sw	r5, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r1				# mr	r5, r1
	add	29, r0, r2				# mr	29, r2
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	sw	r30, 1(r3)
	addi	r3, r3, 2
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	flw	f2, 0(r1)
	flup	f1, 30
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9185
	flup	f2, 32
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	j	lib_fless
beq_then.9185:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solve_each_element_fast.3154:
	lw	r6, 9(29)
	lw	r7, 8(29)
	lw	r8, 7(29)
	lw	r9, 6(29)
	lw	r10, 5(29)
	lw	r11, 4(29)
	lw	r12, 3(29)
	lw	r13, 2(29)
	lw	r14, 1(29)
	sw	r11, 0(r3)
	sw	r13, 1(r3)
	sw	r12, 2(r3)
	sw	r14, 3(r3)
	sw	r7, 4(r3)
	sw	r6, 5(r3)
	sw	r9, 6(r3)
	sw	29, 7(r3)
	sw	r10, 8(r3)
	sw	r5, 9(r3)
	sw	r8, 10(r3)
	sw	r1, 11(r3)
	sw	r2, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	lw	r6, 0(r30)
	beqi	r6, -1, beq_then.9186
	lw	r7, 9(r3)
	lw	29, 10(r3)
	sw	r1, 13(r3)
	sw	r6, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9187
	lw	r2, 6(r3)
	flw	f2, 0(r2)
	flup	f1, 0
	sw	r1, 15(r3)
	fmvtr	r30, f2
	sw	r30, 16(r3)				#stfd	f2, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9188
	lw	r1, 5(r3)
	flw	f2, 0(r1)
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9190
	flup	f1, 29
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 13(r3)
	flw	f2, 0(r1)
	fmul	f2, f2, f1
	lw	r2, 4(r3)
	flw	f3, 0(r2)
	fadd	f2, f2, f3
	flw	f3, 1(r1)
	fmul	f3, f3, f1
	flw	f4, 1(r2)
	fadd	f3, f3, f4
	flw	f4, 2(r1)
	fmul	f4, f4, f1
	flw	f5, 2(r2)
	fadd	f4, f4, f5
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 12(r3)
	lw	29, 3(r3)
	fmvtr	r30, f4
	sw	r30, 18(r3)				#stfd	f4, 18(r3)
	fmvtr	r30, f3
	sw	r30, 20(r3)				#stfd	f3, 20(r3)
	fmvtr	r30, f2
	sw	r30, 22(r3)				#stfd	f2, 22(r3)
	fmvtr	r30, f1
	sw	r30, 24(r3)				#stfd	f1, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r30, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9192
	lw	r1, 5(r3)
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	fsw	r30, 0(r1)
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	lw	r30, 18(r3)				#lfd	f3, 18(r3)
	fmvfr	f3, r30
	lw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	vecset.2862				#	bl	vecset.2862
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	lw	r2, 14(r3)
	sw	r2, 0(r1)
	lw	r1, 0(r3)
	lw	r2, 15(r3)
	sw	r2, 0(r1)
	j	beq_cont.9193
beq_then.9192:
beq_cont.9193:
	j	beq_cont.9191
beq_then.9190:
beq_cont.9191:
	j	beq_cont.9189
beq_then.9188:
beq_cont.9189:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 12(r3)
	lw	r5, 9(r3)
	lw	29, 7(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9187:
	lw	r1, 14(r3)
	lw	r2, 8(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	o_isinvert.2914				#	bl	o_isinvert.2914
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9194
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 12(r3)
	lw	r5, 9(r3)
	lw	29, 7(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9194:
	jr	r31				#	blr
beq_then.9186:
	jr	r31				#	blr
solve_one_or_network_fast.3158:
	lw	r6, 2(29)
	lw	r7, 1(29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	r8, -1, beq_then.9197
	add	r30, r7, r8
	lw	r7, 0(r30)
	addi	r8, r0, 0				# li	r8, 0
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	29, 2(r3)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	add	29, r0, r6				# mr	29, r6
	sw	r30, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	29, 2(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9197:
	jr	r31				#	blr
trace_or_matrix_fast.3162:
	lw	r6, 4(29)
	lw	r7, 3(29)
	lw	r8, 2(29)
	lw	r9, 1(29)
	add	r30, r2, r1
	lw	r10, 0(r30)
	lw	r11, 0(r10)
	beqi	r11, -1, beq_then.9199
	addi	r12, r0, 99				# li	r12, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	29, 2(r3)
	sw	r1, 3(r3)
	beq	r11, r12, beq_then.9200
	sw	r10, 4(r3)
	sw	r9, 5(r3)
	sw	r6, 6(r3)
	sw	r8, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r11				# mr	r1, r11
	add	29, r0, r7				# mr	29, r7
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9202
	lw	r1, 7(r3)
	flw	f1, 0(r1)
	lw	r1, 6(r3)
	flw	f2, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9204
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 4(r3)
	lw	r5, 0(r3)
	lw	29, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.9205
beq_then.9204:
beq_cont.9205:
	j	beq_cont.9203
beq_then.9202:
beq_cont.9203:
	j	beq_cont.9201
beq_then.9200:
	addi	r6, r0, 1				# li	r6, 1
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r6				# mr	r1, r6
	add	29, r0, r9				# mr	29, r9
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.9201:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	29, 2(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9199:
	jr	r31				#	blr
judge_intersection_fast.3166:
	lw	r2, 3(29)
	lw	r5, 2(29)
	lw	r6, 1(29)
	flup	f1, 31
	fsw	r30, 0(r5)
	addi	r7, r0, 0				# li	r7, 0
	lw	r6, 0(r6)
	sw	r5, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r1				# mr	r5, r1
	add	29, r0, r2				# mr	29, r2
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	sw	r30, 1(r3)
	addi	r3, r3, 2
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	flw	f2, 0(r1)
	flup	f1, 30
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9208
	flup	f2, 32
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	j	lib_fless
beq_then.9208:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
get_nvector_rect.3168:
	lw	r2, 2(29)
	lw	r5, 1(29)
	lw	r5, 0(r5)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	vecbzero.2870				#	bl	vecbzero.2870
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	addi	r2, r1, -1
	addi	r1, r1, -1
	lw	r5, 1(r3)
	add	r30, r5, r1
	flw	f1, 0(r30)
	sw	r2, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	sgn.2854				#	bl	sgn.2854
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	lw	r2, 0(r3)
	add	r30, r2, r1
	sw	f1, 0(r30)
	jr	r31				#	blr
get_nvector_plane.3170:
	lw	r2, 1(29)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	o_param_a.2918				#	bl	o_param_a.2918
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	fsw	r30, 0(r1)
	lw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	o_param_b.2920				#	bl	o_param_b.2920
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	fsw	r30, 1(r1)
	lw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	o_param_c.2922				#	bl	o_param_c.2922
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	fsw	r30, 2(r1)
	jr	r31				#	blr
get_nvector_second.3172:
	lw	r2, 2(29)
	lw	r5, 1(29)
	flw	f1, 0(r5)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	o_param_x.2926				#	bl	o_param_x.2926
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 2(r3)
	flw	f2, 1(r1)
	lw	r2, 1(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	o_param_y.2928				#	bl	o_param_y.2928
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 2(r3)
	flw	f2, 2(r1)
	lw	r1, 1(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	fmvtr	r30, f2
	sw	r30, 12(r3)				#stfd	f2, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	o_param_z.2930				#	bl	o_param_z.2930
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 1(r3)
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	o_param_a.2918				#	bl	o_param_a.2918
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	o_param_b.2920				#	bl	o_param_b.2920
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	o_param_c.2922				#	bl	o_param_c.2922
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	o_isrot.2916				#	bl	o_isrot.2916
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9212
	lw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	o_param_r3.2946				#	bl	o_param_r3.2946
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	o_param_r2.2944				#	bl	o_param_r2.2944
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 22(r3)				#lfd	f3, 22(r3)
	fmvfr	f3, r30
	fadd	f1, f3, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	fhalf.2744				#	bl	fhalf.2744
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 0(r3)
	fsw	r30, 0(r1)
	lw	r2, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	o_param_r3.2946				#	bl	o_param_r3.2946
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	fmvtr	r30, f1
	sw	r30, 24(r3)				#stfd	f1, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	o_param_r1.2942				#	bl	o_param_r1.2942
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	fhalf.2744				#	bl	fhalf.2744
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 0(r3)
	fsw	r30, 1(r1)
	lw	r2, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	o_param_r2.2944				#	bl	o_param_r2.2944
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	fmvtr	r30, f1
	sw	r30, 26(r3)				#stfd	f1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	o_param_r1.2942				#	bl	o_param_r1.2942
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	fhalf.2744				#	bl	fhalf.2744
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 0(r3)
	fsw	r30, 2(r1)
	j	beq_cont.9213
beq_then.9212:
	lw	r1, 0(r3)
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	fsw	r30, 0(r1)
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	fsw	r30, 1(r1)
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	fsw	r30, 2(r1)
beq_cont.9213:
	lw	r2, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	o_isinvert.2914				#	bl	o_isinvert.2914
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	j	vecunit_sgn.2880
get_nvector.3174:
	lw	r5, 3(29)
	lw	r6, 2(29)
	lw	r7, 1(29)
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	sw	r7, 2(r3)
	sw	r2, 3(r3)
	sw	r6, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	o_form.2910				#	bl	o_form.2910
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 1, beq_then.9214
	beqi	r1, 2, beq_then.9215
	lw	r1, 1(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9215:
	lw	r1, 1(r3)
	lw	29, 2(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9214:
	lw	r1, 3(r3)
	lw	29, 4(r3)
	lw	r28, 0(29)
	jr	r28
utexture.3177:
	lw	r5, 1(29)
	sw	r2, 0(r3)
	sw	r5, 1(r3)
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	o_texturetype.2908				#	bl	o_texturetype.2908
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	o_color_red.2936				#	bl	o_color_red.2936
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	fsw	r30, 0(r1)
	lw	r2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	o_color_green.2938				#	bl	o_color_green.2938
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	fsw	r30, 1(r1)
	lw	r2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	o_color_blue.2940				#	bl	o_color_blue.2940
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	fsw	r30, 2(r1)
	lw	r2, 3(r3)
	beqi	r2, 1, beq_then.9216
	beqi	r2, 2, beq_then.9217
	beqi	r2, 3, beq_then.9218
	beqi	r2, 4, beq_then.9219
	jr	r31				#	blr
beq_then.9219:
	lw	r2, 0(r3)
	flw	f1, 0(r2)
	lw	r5, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	o_param_x.2926				#	bl	o_param_x.2926
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	o_param_a.2918				#	bl	o_param_a.2918
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 0(r3)
	flw	f2, 2(r1)
	lw	r2, 2(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	fmvtr	r30, f2
	sw	r30, 10(r3)				#stfd	f2, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	o_param_z.2930				#	bl	o_param_z.2930
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	o_param_c.2922				#	bl	o_param_c.2922
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	fabs.2748				#	bl	fabs.2748
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 33
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9221
	flup	f1, 34
	j	beq_cont.9222
beq_then.9221:
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	fabs.2748				#	bl	fabs.2748
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	atan.2770				#	bl	atan.2770
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 35
	fmul	f1, f1, f2
	flup	f2, 4
	fdiv	f1, f1, f2
beq_cont.9222:
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	floor.2752				#	bl	floor.2752
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 0(r3)
	flw	f2, 1(r1)
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	fmvtr	r30, f2
	sw	r30, 24(r3)				#stfd	f2, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	o_param_y.2928				#	bl	o_param_y.2928
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 26(r3)				#stfd	f1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	o_param_b.2920				#	bl	o_param_b.2920
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	fabs.2748				#	bl	fabs.2748
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 33
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9223
	flup	f1, 34
	j	beq_cont.9224
beq_then.9223:
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	fabs.2748				#	bl	fabs.2748
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	atan.2770				#	bl	atan.2770
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 35
	fmul	f1, f1, f2
	flup	f2, 4
	fdiv	f1, f1, f2
beq_cont.9224:
	fmvtr	r30, f1
	sw	r30, 30(r3)				#stfd	f1, 30(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	floor.2752				#	bl	floor.2752
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	flup	f2, 36
	flup	f3, 1
	lw	r30, 22(r3)				#lfd	f4, 22(r3)
	fmvfr	f4, r30
	fsub	f3, f3, f4
	fmvtr	r30, f1
	sw	r30, 32(r3)				#stfd	f1, 32(r3)
	fmvtr	r30, f2
	sw	r30, 34(r3)				#stfd	f2, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	flup	f2, 1
	lw	r30, 32(r3)				#lfd	f3, 32(r3)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	fmvtr	r30, f1
	sw	r30, 36(r3)				#stfd	f1, 36(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 36(r3)				#lfd	f2, 36(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	fmvtr	r30, f1
	sw	r30, 38(r3)				#stfd	f1, 38(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	fisneg.2737				#	bl	fisneg.2737
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9225
	flup	f1, 0
	j	beq_cont.9226
beq_then.9225:
	lw	r30, 38(r3)				#lfd	f1, 38(r3)
	fmvfr	f1, r30
beq_cont.9226:
	flup	f2, 37
	fmul	f1, f2, f1
	flup	f2, 38
	fdiv	f1, f1, f2
	lw	r1, 1(r3)
	fsw	r30, 2(r1)
	jr	r31				#	blr
beq_then.9218:
	lw	r2, 0(r3)
	flw	f1, 0(r2)
	lw	r5, 2(r3)
	fmvtr	r30, f1
	sw	r30, 40(r3)				#stfd	f1, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	o_param_x.2926				#	bl	o_param_x.2926
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 40(r3)				#lfd	f2, 40(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 0(r3)
	flw	f2, 2(r1)
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 42(r3)				#stfd	f1, 42(r3)
	fmvtr	r30, f2
	sw	r30, 44(r3)				#stfd	f2, 44(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	o_param_z.2930				#	bl	o_param_z.2930
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 44(r3)				#lfd	f2, 44(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r30, 42(r3)				#lfd	f2, 42(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 46(r3)				#stfd	f1, 46(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 46(r3)				#lfd	f2, 46(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 48(r3)				#stfd	f1, 48(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 48(r3)				#lfd	f2, 48(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 39
	fdiv	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 50(r3)				#stfd	f1, 50(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	floor.2752				#	bl	floor.2752
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 50(r3)				#lfd	f2, 50(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	flup	f2, 4
	fmul	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 37
	fmul	f2, f1, f2
	lw	r1, 1(r3)
	fsw	r30, 1(r1)
	flup	f2, 2
	fsub	f1, f2, f1
	flup	f2, 37
	fmul	f1, f1, f2
	fsw	r30, 2(r1)
	jr	r31				#	blr
beq_then.9217:
	lw	r2, 0(r3)
	flw	f1, 1(r2)
	flup	f2, 40
	fmul	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	sin.2764				#	bl	sin.2764
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 37
	fmul	f2, f2, f1
	lw	r1, 1(r3)
	fsw	r30, 0(r1)
	flup	f2, 37
	flup	f3, 2
	fsub	f1, f3, f1
	fmul	f1, f2, f1
	fsw	r30, 1(r1)
	jr	r31				#	blr
beq_then.9216:
	lw	r2, 0(r3)
	flw	f1, 0(r2)
	lw	r5, 2(r3)
	fmvtr	r30, f1
	sw	r30, 52(r3)				#stfd	f1, 52(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 54(r3)
	addi	r3, r3, 55
	jal	o_param_x.2926				#	bl	o_param_x.2926
	addi	r3, r3, -55
	lw	r30, 54(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 52(r3)				#lfd	f2, 52(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	flup	f2, 41
	fmul	f2, f1, f2
	fmvtr	r30, f1
	sw	r30, 54(r3)				#stfd	f1, 54(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 56(r3)
	addi	r3, r3, 57
	jal	floor.2752				#	bl	floor.2752
	addi	r3, r3, -57
	lw	r30, 56(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 42
	fmul	f1, f1, f2
	lw	r30, 54(r3)				#lfd	f2, 54(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	flup	f2, 39
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 56(r3)
	addi	r3, r3, 57
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -57
	lw	r30, 56(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	flw	f1, 2(r2)
	lw	r2, 2(r3)
	sw	r1, 56(r3)
	fmvtr	r30, f1
	sw	r30, 58(r3)				#stfd	f1, 58(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 60(r3)
	addi	r3, r3, 61
	jal	o_param_z.2930				#	bl	o_param_z.2930
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 58(r3)				#lfd	f2, 58(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	flup	f2, 41
	fmul	f2, f1, f2
	fmvtr	r30, f1
	sw	r30, 60(r3)				#stfd	f1, 60(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 62(r3)
	addi	r3, r3, 63
	jal	floor.2752				#	bl	floor.2752
	addi	r3, r3, -63
	lw	r30, 62(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 42
	fmul	f1, f1, f2
	lw	r30, 60(r3)				#lfd	f2, 60(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	flup	f2, 39
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 62(r3)
	addi	r3, r3, 63
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -63
	lw	r30, 62(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 56(r3)
	beqi	r2, 0, beq_then.9231
	beqi	r1, 0, beq_then.9233
	flup	f1, 37
	j	beq_cont.9234
beq_then.9233:
	flup	f1, 0
beq_cont.9234:
	j	beq_cont.9232
beq_then.9231:
	beqi	r1, 0, beq_then.9235
	flup	f1, 0
	j	beq_cont.9236
beq_then.9235:
	flup	f1, 37
beq_cont.9236:
beq_cont.9232:
	lw	r1, 1(r3)
	fsw	r30, 1(r1)
	jr	r31				#	blr
add_light.3180:
	lw	r1, 2(29)
	lw	r2, 1(29)
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	fispos.2735				#	bl	fispos.2735
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9238
	lw	r30, 4(r3)				#lfd	f1, 4(r3)
	fmvfr	f1, r30
	lw	r1, 7(r3)
	lw	r2, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	vecaccum.2891				#	bl	vecaccum.2891
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.9239
beq_then.9238:
beq_cont.9239:
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	fispos.2735				#	bl	fispos.2735
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9240
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 7(r3)
	flw	f2, 0(r1)
	fadd	f2, f2, f1
	fsw	r30, 0(r1)
	flw	f2, 1(r1)
	fadd	f2, f2, f1
	fsw	r30, 1(r1)
	flw	f2, 2(r1)
	fadd	f1, f2, f1
	fsw	r30, 2(r1)
	jr	r31				#	blr
beq_then.9240:
	jr	r31				#	blr
trace_reflections.3184:
	lw	r5, 8(29)
	lw	r6, 7(29)
	lw	r7, 6(29)
	lw	r8, 5(29)
	lw	r9, 4(29)
	lw	r10, 3(29)
	lw	r11, 2(29)
	lw	r12, 1(29)
	addi	r13, r0, 0				# li	r13, 0
	ble	r13, r1, ble_then.9243
	jr	r31				#	blr
ble_then.9243:
	add	r30, r6, r1
	lw	r6, 0(r30)
	sw	29, 0(r3)
	sw	r1, 1(r3)
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	sw	r12, 4(r3)
	sw	r2, 5(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	sw	r8, 8(r3)
	sw	r5, 9(r3)
	sw	r7, 10(r3)
	sw	r6, 11(r3)
	sw	r10, 12(r3)
	sw	r11, 13(r3)
	sw	r9, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	r_dvec.2975				#	bl	r_dvec.2975
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	29, 14(r3)
	sw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9245
	lw	r1, 13(r3)
	lw	r1, 0(r1)
	slli	r1, r1, 2
	lw	r2, 12(r3)
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 11(r3)
	sw	r1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	r_surface_id.2973				#	bl	r_surface_id.2973
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 16(r3)
	beq	r2, r1, beq_then.9247
	j	beq_cont.9248
beq_then.9247:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 10(r3)
	lw	r2, 0(r2)
	lw	29, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9249
	j	beq_cont.9250
beq_then.9249:
	lw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	r_bright.2977				#	bl	r_bright.2977
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f3, f1, f2
	lw	r30, 18(r3)				#lfd	f4, 18(r3)
	fmvfr	f4, r30
	fmul	f3, f3, f4
	lw	r1, 15(r3)
	fmvtr	r30, f3
	sw	r30, 20(r3)				#stfd	f3, 20(r3)
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	lw	29, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.9250:
beq_cont.9248:
	j	beq_cont.9246
beq_then.9245:
beq_cont.9246:
	lw	r1, 1(r3)
	addi	r1, r1, -1
	lw	r30, 6(r3)				#lfd	f1, 6(r3)
	fmvfr	f1, r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	lw	r2, 5(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
trace_ray.3189:
	lw	r6, 22(29)
	lw	r7, 21(29)
	lw	r8, 20(29)
	lw	r9, 19(29)
	lw	r10, 18(29)
	lw	r11, 17(29)
	lw	r12, 16(29)
	lw	r13, 15(29)
	lw	r14, 14(29)
	lw	r15, 13(29)
	lw	r16, 12(29)
	lw	r17, 11(29)
	lw	r18, 10(29)
	lw	r19, 9(29)
	lw	r20, 8(29)
	lw	r21, 7(29)
	lw	r22, 6(29)
	lw	r23, 5(29)
	lw	r24, 4(29)
	lw	r25, 3(29)
	lw	r26, 2(29)
	lw	r27, 1(29)
	blei	r1, 4, ble_then.9252
	jr	r31				#	blr
ble_then.9252:
	sw	29, 0(r3)
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	sw	r9, 4(r3)
	sw	r8, 5(r3)
	sw	r18, 6(r3)
	sw	r13, 7(r3)
	sw	r27, 8(r3)
	sw	r12, 9(r3)
	sw	r15, 10(r3)
	sw	r25, 11(r3)
	sw	r17, 12(r3)
	sw	r10, 13(r3)
	sw	r7, 14(r3)
	sw	r5, 15(r3)
	sw	r21, 16(r3)
	sw	r6, 17(r3)
	sw	r22, 18(r3)
	sw	r11, 19(r3)
	sw	r24, 20(r3)
	sw	r16, 21(r3)
	sw	r23, 22(r3)
	sw	r14, 23(r3)
	sw	r26, 24(r3)
	fmvtr	r30, f1
	sw	r30, 26(r3)				#stfd	f1, 26(r3)
	sw	r19, 28(r3)
	sw	r1, 29(r3)
	sw	r2, 30(r3)
	sw	r20, 31(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	p_surface_ids.2954				#	bl	p_surface_ids.2954
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 30(r3)
	lw	29, 31(r3)
	sw	r1, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9256
	lw	r1, 22(r3)
	lw	r1, 0(r1)
	lw	r2, 21(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	sw	r1, 33(r3)
	sw	r2, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 35(r3)
	addi	r3, r3, 36
	jal	o_reflectiontype.2912				#	bl	o_reflectiontype.2912
	addi	r3, r3, -36
	lw	r30, 35(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 34(r3)
	sw	r1, 35(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	o_diffuse.2932				#	bl	o_diffuse.2932
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 34(r3)
	lw	r2, 30(r3)
	lw	29, 20(r3)
	fmvtr	r30, f1
	sw	r30, 36(r3)				#stfd	f1, 36(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 38(r3)
	addi	r3, r3, 39
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 19(r3)
	lw	r2, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 34(r3)
	lw	r2, 18(r3)
	lw	29, 17(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 38(r3)
	addi	r3, r3, 39
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 33(r3)
	slli	r1, r1, 2
	lw	r2, 16(r3)
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 29(r3)
	lw	r5, 32(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	p_intersection_points.2952				#	bl	p_intersection_points.2952
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 29(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r5, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	p_calc_diffuse.2956				#	bl	p_calc_diffuse.2956
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 34(r3)
	sw	r1, 38(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 39(r3)
	addi	r3, r3, 40
	jal	o_diffuse.2932				#	bl	o_diffuse.2932
	addi	r3, r3, -40
	lw	r30, 39(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 39(r3)
	addi	r3, r3, 40
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -40
	lw	r30, 39(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9257
	lw	r1, 29(r3)
	lw	r2, 38(r3)
	lw	r5, 11(r3)
	add	r30, r2, r1
	sw	r5, 0(r30)
	j	beq_cont.9258
beq_then.9257:
	lw	r1, 29(r3)
	lw	r2, 38(r3)
	lw	r5, 14(r3)
	add	r30, r2, r1
	sw	r5, 0(r30)
	lw	r2, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 39(r3)
	addi	r3, r3, 40
	jal	p_energy.2958				#	bl	p_energy.2958
	addi	r3, r3, -40
	lw	r30, 39(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 29(r3)
	add	r30, r1, r2
	lw	r5, 0(r30)
	lw	r6, 13(r3)
	sw	r1, 39(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 29(r3)
	lw	r2, 39(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	flup	f1, 43
	lw	r30, 36(r3)				#lfd	f2, 36(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	vecscale.2901				#	bl	vecscale.2901
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	p_nvectors.2967				#	bl	p_nvectors.2967
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 29(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r5, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.9258:
	flup	f1, 44
	lw	r1, 30(r3)
	lw	r2, 12(r3)
	fmvtr	r30, f1
	sw	r30, 40(r3)				#stfd	f1, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 40(r3)				#lfd	f2, 40(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 30(r3)
	lw	r2, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	vecaccum.2891				#	bl	vecaccum.2891
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	o_hilight.2934				#	bl	o_hilight.2934
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 10(r3)
	lw	r2, 0(r2)
	lw	29, 9(r3)
	fmvtr	r30, f1
	sw	r30, 42(r3)				#stfd	f1, 42(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 45
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9259
	j	beq_cont.9260
beq_then.9259:
	lw	r1, 12(r3)
	lw	r2, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 36(r3)				#lfd	f2, 36(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 30(r3)
	lw	r2, 28(r3)
	fmvtr	r30, f1
	sw	r30, 44(r3)				#stfd	f1, 44(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -47
	lw	r30, 46(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 44(r3)				#lfd	f1, 44(r3)
	fmvfr	f1, r30
	lw	r30, 42(r3)				#lfd	f3, 42(r3)
	fmvfr	f3, r30
	lw	29, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.9260:
	lw	r1, 18(r3)
	lw	29, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	lw	r1, 0(r1)
	addi	r1, r1, -1
	lw	r30, 36(r3)				#lfd	f1, 36(r3)
	fmvfr	f1, r30
	lw	r30, 42(r3)				#lfd	f2, 42(r3)
	fmvfr	f2, r30
	lw	r2, 30(r3)
	lw	29, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f1, 45
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9261
	addi	r1, r0, 4				# li	r1, 4
	lw	r2, 29(r3)
	ble	r1, r2, ble_then.9262
	addi	r1, r2, 1
	addi	r5, r0, -1				# li	r5, -1
	lw	r6, 32(r3)
	add	r30, r6, r1
	sw	r5, 0(r30)
	j	ble_cont.9263
ble_then.9262:
ble_cont.9263:
	lw	r1, 35(r3)
	beqi	r1, 2, beq_then.9264
	j	beq_cont.9265
beq_then.9264:
	flup	f1, 2
	lw	r1, 34(r3)
	fmvtr	r30, f1
	sw	r30, 46(r3)				#stfd	f1, 46(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	o_diffuse.2932				#	bl	o_diffuse.2932
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 46(r3)				#lfd	f2, 46(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 29(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	flw	f2, 0(r2)
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fadd	f2, f3, f2
	lw	r2, 30(r3)
	lw	r5, 15(r3)
	lw	29, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.9265:
	jr	r31				#	blr
beq_then.9261:
	jr	r31				#	blr
beq_then.9256:
	addi	r1, r0, -1				# li	r1, -1
	lw	r2, 29(r3)
	lw	r5, 32(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	r2, 0, beq_then.9268
	lw	r1, 30(r3)
	lw	r2, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 48(r3)				#stfd	f1, 48(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	fispos.2735				#	bl	fispos.2735
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9269
	lw	r30, 48(r3)				#lfd	f1, 48(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 48(r3)				#lfd	f2, 48(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 24(r3)
	flw	f2, 0(r1)
	fmul	f1, f1, f2
	lw	r1, 23(r3)
	flw	f2, 0(r1)
	fadd	f2, f2, f1
	fsw	r30, 0(r1)
	flw	f2, 1(r1)
	fadd	f2, f2, f1
	fsw	r30, 1(r1)
	flw	f2, 2(r1)
	fadd	f1, f2, f1
	fsw	r30, 2(r1)
	jr	r31				#	blr
beq_then.9269:
	jr	r31				#	blr
beq_then.9268:
	jr	r31				#	blr
trace_diffuse_ray.3195:
	lw	r2, 12(29)
	lw	r5, 11(29)
	lw	r6, 10(29)
	lw	r7, 9(29)
	lw	r8, 8(29)
	lw	r9, 7(29)
	lw	r10, 6(29)
	lw	r11, 5(29)
	lw	r12, 4(29)
	lw	r13, 3(29)
	lw	r14, 2(29)
	lw	r15, 1(29)
	sw	r5, 0(r3)
	sw	r15, 1(r3)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	sw	r10, 4(r3)
	sw	r9, 5(r3)
	sw	r6, 6(r3)
	sw	r7, 7(r3)
	sw	r12, 8(r3)
	sw	r2, 9(r3)
	sw	r14, 10(r3)
	sw	r1, 11(r3)
	sw	r8, 12(r3)
	sw	r13, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	add	29, r0, r11				# mr	29, r11
	sw	r30, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9273
	lw	r1, 13(r3)
	lw	r1, 0(r1)
	lw	r2, 12(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 11(r3)
	sw	r1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 14(r3)
	lw	29, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 14(r3)
	lw	r2, 8(r3)
	lw	29, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 7(r3)
	lw	r2, 0(r2)
	lw	29, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9274
	jr	r31				#	blr
beq_then.9274:
	lw	r1, 5(r3)
	lw	r2, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	fispos.2735				#	bl	fispos.2735
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9277
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	j	beq_cont.9278
beq_then.9277:
	flup	f1, 0
beq_cont.9278:
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 14(r3)
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	o_diffuse.2932				#	bl	o_diffuse.2932
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	lw	r2, 0(r3)
	j	vecaccum.2891
beq_then.9273:
	jr	r31				#	blr
iter_trace_diffuse_rays.3198:
	lw	r7, 1(29)
	addi	r8, r0, 0				# li	r8, 0
	ble	r8, r6, ble_then.9280
	jr	r31				#	blr
ble_then.9280:
	add	r30, r1, r6
	lw	r8, 0(r30)
	sw	r5, 0(r3)
	sw	29, 1(r3)
	sw	r7, 2(r3)
	sw	r6, 3(r3)
	sw	r1, 4(r3)
	sw	r2, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r8				# mr	r1, r8
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	fisneg.2737				#	bl	fisneg.2737
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9282
	lw	r1, 3(r3)
	addi	r2, r1, 1
	lw	r5, 4(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	flup	f1, 46
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	29, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.9283
beq_then.9282:
	lw	r1, 3(r3)
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	flup	f1, 47
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	29, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.9283:
	lw	r1, 3(r3)
	addi	r6, r1, -2
	lw	r1, 4(r3)
	lw	r2, 5(r3)
	lw	r5, 0(r3)
	lw	29, 1(r3)
	lw	r28, 0(29)
	jr	r28
trace_diffuse_rays.3203:
	lw	r6, 2(29)
	lw	r7, 1(29)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r7, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	29, r0, r6				# mr	29, r6
	sw	r30, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 2(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	29, 3(r3)
	lw	r28, 0(29)
	jr	r28
trace_diffuse_ray_80percent.3207:
	lw	r6, 2(29)
	lw	r7, 1(29)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	sw	r1, 4(r3)
	beqi	r1, 0, beq_then.9284
	lw	r8, 0(r7)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r8				# mr	r1, r8
	add	29, r0, r6				# mr	29, r6
	sw	r30, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.9285
beq_then.9284:
beq_cont.9285:
	lw	r1, 4(r3)
	beqi	r1, 1, beq_then.9286
	lw	r2, 3(r3)
	lw	r5, 1(r2)
	lw	r6, 1(r3)
	lw	r7, 0(r3)
	lw	29, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r7				# mr	r5, r7
	sw	r30, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.9287
beq_then.9286:
beq_cont.9287:
	lw	r1, 4(r3)
	beqi	r1, 2, beq_then.9288
	lw	r2, 3(r3)
	lw	r5, 2(r2)
	lw	r6, 1(r3)
	lw	r7, 0(r3)
	lw	29, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r7				# mr	r5, r7
	sw	r30, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.9289
beq_then.9288:
beq_cont.9289:
	lw	r1, 4(r3)
	beqi	r1, 3, beq_then.9290
	lw	r2, 3(r3)
	lw	r5, 3(r2)
	lw	r6, 1(r3)
	lw	r7, 0(r3)
	lw	29, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r7				# mr	r5, r7
	sw	r30, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.9291
beq_then.9290:
beq_cont.9291:
	lw	r1, 4(r3)
	beqi	r1, 4, beq_then.9292
	lw	r1, 3(r3)
	lw	r1, 4(r1)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	29, 2(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9292:
	jr	r31				#	blr
calc_diffuse_using_1point.3211:
	lw	r5, 3(29)
	lw	r6, 2(29)
	lw	r7, 1(29)
	sw	r6, 0(r3)
	sw	r5, 1(r3)
	sw	r7, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	p_received_ray_20percent.2960				#	bl	p_received_ray_20percent.2960
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	p_nvectors.2967				#	bl	p_nvectors.2967
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	p_intersection_points.2952				#	bl	p_intersection_points.2952
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	p_energy.2958				#	bl	p_energy.2958
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 2(r3)
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	p_group_id.2962				#	bl	p_group_id.2962
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 7(r3)
	add	r30, r6, r2
	lw	r6, 0(r30)
	lw	29, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	lw	r2, 8(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	j	vecaccumv.2904
calc_diffuse_using_5points.3214:
	lw	r8, 2(29)
	lw	r9, 1(29)
	add	r30, r2, r1
	lw	r2, 0(r30)
	sw	r8, 0(r3)
	sw	r9, 1(r3)
	sw	r7, 2(r3)
	sw	r6, 3(r3)
	sw	r5, 4(r3)
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	p_received_ray_20percent.2960				#	bl	p_received_ray_20percent.2960
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	addi	r5, r2, -1
	lw	r6, 4(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	p_received_ray_20percent.2960				#	bl	p_received_ray_20percent.2960
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	lw	r6, 0(r30)
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	p_received_ray_20percent.2960				#	bl	p_received_ray_20percent.2960
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	addi	r5, r2, 1
	lw	r6, 4(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	p_received_ray_20percent.2960				#	bl	p_received_ray_20percent.2960
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r1, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	p_received_ray_20percent.2960				#	bl	p_received_ray_20percent.2960
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 1(r3)
	sw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	vecadd.2895				#	bl	vecadd.2895
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r2, 8(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	vecadd.2895				#	bl	vecadd.2895
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	vecadd.2895				#	bl	vecadd.2895
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r2, 10(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	vecadd.2895				#	bl	vecadd.2895
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	p_energy.2958				#	bl	p_energy.2958
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	add	r30, r1, r2
	lw	r2, 0(r30)
	lw	r1, 0(r3)
	lw	r5, 1(r3)
	j	vecaccumv.2904
do_without_neighbors.3220:
	lw	r5, 1(29)
	blei	r2, 4, ble_then.9294
	jr	r31				#	blr
ble_then.9294:
	sw	29, 0(r3)
	sw	r5, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	p_surface_ids.2954				#	bl	p_surface_ids.2954
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 3(r3)
	add	r30, r1, r5
	lw	r1, 0(r30)
	ble	r2, r1, ble_then.9296
	jr	r31				#	blr
ble_then.9296:
	lw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	p_calc_diffuse.2956				#	bl	p_calc_diffuse.2956
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	beqi	r1, 0, beq_then.9298
	lw	r1, 2(r3)
	lw	29, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.9299
beq_then.9298:
beq_cont.9299:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
neighbors_exist.3223:
	lw	r5, 1(29)
	lw	r6, 1(r5)
	addi	r7, r2, 1
	ble	r6, r7, ble_then.9300
	blei	r2, 0, ble_then.9301
	lw	r2, 0(r5)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.9302
	blei	r1, 0, ble_then.9303
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
ble_then.9303:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
ble_then.9302:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
ble_then.9301:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
ble_then.9300:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
get_surface_id.3227:
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	p_surface_ids.2954				#	bl	p_surface_ids.2954
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	jr	r31				#	blr
neighbors_are_available.3230:
	add	r30, r5, r1
	lw	r8, 0(r30)
	sw	r5, 0(r3)
	sw	r6, 1(r3)
	sw	r7, 2(r3)
	sw	r1, 3(r3)
	sw	r2, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	get_surface_id.3227				#	bl	get_surface_id.3227
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 2(r3)
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	get_surface_id.3227				#	bl	get_surface_id.3227
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	beq	r1, r2, beq_then.9304
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.9304:
	lw	r1, 3(r3)
	lw	r5, 1(r3)
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r6, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	get_surface_id.3227				#	bl	get_surface_id.3227
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	beq	r1, r2, beq_then.9305
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.9305:
	lw	r1, 3(r3)
	addi	r5, r1, -1
	lw	r6, 0(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	lw	r7, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	get_surface_id.3227				#	bl	get_surface_id.3227
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	beq	r1, r2, beq_then.9306
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.9306:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r5, 0(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r5, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	get_surface_id.3227				#	bl	get_surface_id.3227
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	beq	r1, r2, beq_then.9307
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.9307:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
try_exploit_neighbors.3236:
	lw	r9, 2(29)
	lw	r10, 1(29)
	add	r30, r6, r1
	lw	r11, 0(r30)
	blei	r8, 4, ble_then.9308
	jr	r31				#	blr
ble_then.9308:
	addi	r12, r0, 0				# li	r12, 0
	sw	r2, 0(r3)
	sw	29, 1(r3)
	sw	r10, 2(r3)
	sw	r11, 3(r3)
	sw	r9, 4(r3)
	sw	r8, 5(r3)
	sw	r7, 6(r3)
	sw	r6, 7(r3)
	sw	r5, 8(r3)
	sw	r1, 9(r3)
	sw	r12, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r11				# mr	r1, r11
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	get_surface_id.3227				#	bl	get_surface_id.3227
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 10(r3)
	ble	r2, r1, ble_then.9310
	jr	r31				#	blr
ble_then.9310:
	lw	r1, 9(r3)
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r6, 6(r3)
	lw	r7, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	neighbors_are_available.3230				#	bl	neighbors_are_available.3230
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9312
	lw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	p_calc_diffuse.2956				#	bl	p_calc_diffuse.2956
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r7, 5(r3)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beqi	r1, 0, beq_then.9313
	lw	r1, 9(r3)
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r6, 6(r3)
	lw	29, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.9314
beq_then.9313:
beq_cont.9314:
	lw	r1, 5(r3)
	addi	r8, r1, 1
	lw	r1, 9(r3)
	lw	r2, 0(r3)
	lw	r5, 8(r3)
	lw	r6, 7(r3)
	lw	r7, 6(r3)
	lw	29, 1(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9312:
	lw	r1, 9(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 5(r3)
	lw	29, 4(r3)
	lw	r28, 0(29)
	jr	r28
write_ppm_header.3243:
	lw	r1, 1(29)
	addi	r2, r0, 80				# li	r2, 80
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 51				# li	r1, 51
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 10				# li	r1, 10
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	lw	r2, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	print_int.2798				#	bl	print_int.2798
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 32				# li	r1, 32
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	lw	r1, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	print_int.2798				#	bl	print_int.2798
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 32				# li	r1, 32
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 255				# li	r1, 255
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	print_int.2798				#	bl	print_int.2798
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 10				# li	r1, 10
	j	lib_print_char
write_rgb_element.3245:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 0(r3)
	addi	r3, r3, 1
	jal	int_of_float.2754				#	bl	int_of_float.2754
	addi	r3, r3, -1
	lw	r30, 0(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 255				# li	r2, 255
	ble	r1, r2, ble_then.9315
	addi	r1, r0, 255				# li	r1, 255
	j	ble_cont.9316
ble_then.9315:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.9317
	addi	r1, r0, 0				# li	r1, 0
	j	ble_cont.9318
ble_then.9317:
ble_cont.9318:
ble_cont.9316:
	j	print_int.2798
write_rgb.3247:
	lw	r1, 1(29)
	flw	f1, 0(r1)
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	write_rgb_element.3245				#	bl	write_rgb_element.3245
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 32				# li	r1, 32
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	flw	f1, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	write_rgb_element.3245				#	bl	write_rgb_element.3245
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 32				# li	r1, 32
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	flw	f1, 2(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	write_rgb_element.3245				#	bl	write_rgb_element.3245
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 10				# li	r1, 10
	j	lib_print_char
pretrace_diffuse_rays.3249:
	lw	r5, 3(29)
	lw	r6, 2(29)
	lw	r7, 1(29)
	blei	r2, 4, ble_then.9319
	jr	r31				#	blr
ble_then.9319:
	sw	29, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	get_surface_id.3227				#	bl	get_surface_id.3227
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.9321
	jr	r31				#	blr
ble_then.9321:
	lw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	p_calc_diffuse.2956				#	bl	p_calc_diffuse.2956
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	beqi	r1, 0, beq_then.9323
	lw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	p_group_id.2962				#	bl	p_group_id.2962
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	vecbzero.2870				#	bl	vecbzero.2870
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	p_nvectors.2967				#	bl	p_nvectors.2967
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	p_intersection_points.2952				#	bl	p_intersection_points.2952
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 6(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r5, 4(r3)
	lw	r6, 7(r3)
	add	r30, r6, r5
	lw	r6, 0(r30)
	add	r30, r1, r5
	lw	r1, 0(r30)
	lw	29, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r1				# mr	r5, r1
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r6				# mr	r2, r6
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	p_received_ray_20percent.2960				#	bl	p_received_ray_20percent.2960
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r5, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.9324
beq_then.9323:
beq_cont.9324:
	lw	r1, 4(r3)
	addi	r2, r1, 1
	lw	r1, 5(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
pretrace_pixels.3252:
	lw	r6, 10(29)
	lw	r7, 9(29)
	lw	r8, 8(29)
	lw	r9, 7(29)
	lw	r10, 6(29)
	lw	r11, 5(29)
	lw	r12, 4(29)
	lw	r13, 3(29)
	lw	r14, 2(29)
	lw	r15, 1(29)
	addi	r16, r0, 0				# li	r16, 0
	ble	r16, r2, ble_then.9325
	jr	r31				#	blr
ble_then.9325:
	flw	f4, 0(r10)
	lw	r10, 0(r14)
	sub	r10, r2, r10
	sw	29, 0(r3)
	sw	r13, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	sw	r8, 7(r3)
	sw	r11, 8(r3)
	sw	r15, 9(r3)
	fmvtr	r30, f3
	sw	r30, 10(r3)				#stfd	f3, 10(r3)
	fmvtr	r30, f2
	sw	r30, 12(r3)				#stfd	f2, 12(r3)
	sw	r12, 14(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	sw	r9, 18(r3)
	fmvtr	r30, f4
	sw	r30, 20(r3)				#stfd	f4, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	float_of_int.2756				#	bl	float_of_int.2756
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 18(r3)
	flw	f2, 0(r1)
	fmul	f2, f1, f2
	lw	r30, 16(r3)				#lfd	f3, 16(r3)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	lw	r2, 14(r3)
	fsw	r30, 0(r2)
	flw	f2, 1(r1)
	fmul	f2, f1, f2
	lw	r30, 12(r3)				#lfd	f4, 12(r3)
	fmvfr	f4, r30
	fadd	f2, f2, f4
	fsw	r30, 1(r2)
	flw	f2, 2(r1)
	fmul	f1, f1, f2
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fsw	r30, 2(r2)
	lw	r1, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	vecunit_sgn.2880				#	bl	vecunit_sgn.2880
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	vecbzero.2870				#	bl	vecbzero.2870
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	lw	r2, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	flup	f1, 2
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r6, 0(r30)
	flup	f2, 0
	lw	r7, 14(r3)
	lw	29, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r6				# mr	r5, r6
	add	r2, r0, r7				# mr	r2, r7
	sw	r30, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	lw	r2, 5(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	p_rgb.2950				#	bl	p_rgb.2950
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	lw	r2, 5(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	p_set_group_id.2964				#	bl	p_set_group_id.2964
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	lw	r2, 5(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	29, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	addi	r1, r1, -1
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 2(r3)
	sw	r1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	add_mod5.2859				#	bl	add_mod5.2859
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r5, r0, r1				# mr	r5, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	lw	r30, 10(r3)				#lfd	f3, 10(r3)
	fmvfr	f3, r30
	lw	r1, 5(r3)
	lw	r2, 22(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
pretrace_line.3259:
	lw	r6, 6(29)
	lw	r7, 5(29)
	lw	r8, 4(29)
	lw	r9, 3(29)
	lw	r10, 2(29)
	lw	r11, 1(29)
	flw	f1, 0(r8)
	lw	r8, 1(r11)
	sub	r2, r2, r8
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	sw	r9, 2(r3)
	sw	r10, 3(r3)
	sw	r6, 4(r3)
	sw	r7, 5(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	float_of_int.2756				#	bl	float_of_int.2756
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 5(r3)
	flw	f2, 0(r1)
	fmul	f2, f1, f2
	lw	r2, 4(r3)
	flw	f3, 0(r2)
	fadd	f2, f2, f3
	flw	f3, 1(r1)
	fmul	f3, f1, f3
	flw	f4, 1(r2)
	fadd	f3, f3, f4
	flw	f4, 2(r1)
	fmul	f1, f1, f4
	flw	f4, 2(r2)
	fadd	f1, f1, f4
	lw	r1, 3(r3)
	lw	r1, 0(r1)
	addi	r2, r1, -1
	lw	r1, 1(r3)
	lw	r5, 0(r3)
	lw	29, 2(r3)
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	lw	r28, 0(29)
	jr	r28
scan_pixel.3263:
	lw	r8, 6(29)
	lw	r9, 5(29)
	lw	r10, 4(29)
	lw	r11, 3(29)
	lw	r12, 2(29)
	lw	r13, 1(29)
	lw	r12, 0(r12)
	ble	r12, r1, ble_then.9329
	add	r30, r6, r1
	lw	r12, 0(r30)
	sw	29, 0(r3)
	sw	r8, 1(r3)
	sw	r5, 2(r3)
	sw	r9, 3(r3)
	sw	r13, 4(r3)
	sw	r6, 5(r3)
	sw	r7, 6(r3)
	sw	r2, 7(r3)
	sw	r1, 8(r3)
	sw	r11, 9(r3)
	sw	r10, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r12				# mr	r1, r12
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	p_rgb.2950				#	bl	p_rgb.2950
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	lw	r2, 7(r3)
	lw	r5, 6(r3)
	lw	29, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9330
	addi	r8, r0, 0				# li	r8, 0
	lw	r1, 8(r3)
	lw	r2, 7(r3)
	lw	r5, 2(r3)
	lw	r6, 5(r3)
	lw	r7, 6(r3)
	lw	29, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.9331
beq_then.9330:
	lw	r1, 8(r3)
	lw	r2, 5(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	29, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.9331:
	lw	29, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	addi	r1, r1, 1
	lw	r2, 7(r3)
	lw	r5, 2(r3)
	lw	r6, 5(r3)
	lw	r7, 6(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
ble_then.9329:
	jr	r31				#	blr
scan_line.3269:
	lw	r8, 3(29)
	lw	r9, 2(29)
	lw	r10, 1(29)
	lw	r11, 1(r10)
	ble	r11, r1, ble_then.9333
	lw	r10, 1(r10)
	addi	r10, r10, -1
	sw	29, 0(r3)
	sw	r7, 1(r3)
	sw	r6, 2(r3)
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	sw	r8, 6(r3)
	ble	r10, r1, ble_then.9334
	addi	r10, r1, 1
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r6				# mr	r1, r6
	add	29, r0, r9				# mr	29, r9
	sw	r30, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	j	ble_cont.9335
ble_then.9334:
ble_cont.9335:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 5(r3)
	lw	r5, 4(r3)
	lw	r6, 3(r3)
	lw	r7, 2(r3)
	lw	29, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	addi	r1, r1, 1
	addi	r2, r0, 2				# li	r2, 2
	lw	r5, 1(r3)
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	add_mod5.2859				#	bl	add_mod5.2859
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r7, r0, r1				# mr	r7, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	lw	29, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	jr	r31				#	blr
ble_then.9333:
	jr	r31				#	blr
create_float5x3array.3275:
	addi	r1, r0, 3				# li	r1, 3
	flup	f1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 0(r3)
	addi	r3, r3, 1
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -1
	lw	r30, 0(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 0(r3)
	addi	r3, r3, 1
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -1
	lw	r30, 0(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	flup	f1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	flup	f1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	flup	f1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sw	r1, 4(r2)
	add	r1, r0, r2				# mr	r1, r2
	jr	r31				#	blr
create_pixel.3277:
	lw	r1, 1(29)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	create_float5x3array.3275				#	bl	create_float5x3array.3275
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 5				# li	r2, 5
	addi	r5, r0, 0				# li	r5, 0
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 5				# li	r2, 5
	lw	r5, 0(r3)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	create_float5x3array.3275				#	bl	create_float5x3array.3275
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3275				#	bl	create_float5x3array.3275
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	addi	r5, r0, 0				# li	r5, 0
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	create_float5x3array.3275				#	bl	create_float5x3array.3275
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 7(r3)
	sw	r1, 6(r2)
	lw	r1, 6(r3)
	sw	r1, 5(r2)
	lw	r1, 5(r3)
	sw	r1, 4(r2)
	lw	r1, 4(r3)
	sw	r1, 3(r2)
	lw	r1, 3(r3)
	sw	r1, 2(r2)
	lw	r1, 2(r3)
	sw	r1, 1(r2)
	lw	r1, 1(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	jr	r31				#	blr
init_line_elements.3279:
	lw	r5, 1(29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.9338
	jr	r31				#	blr
ble_then.9338:
	sw	29, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	29, r0, r5				# mr	29, r5
	sw	r30, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	29, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r28, 0(29)
	jr	r28
create_pixelline.3282:
	lw	r1, 3(29)
	lw	r2, 2(29)
	lw	29, 1(29)
	lw	r5, 0(r2)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r5, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	lw	r2, 0(r2)
	addi	r2, r2, -2
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
tan.3284:
	fmvtr	r30, f1
	sw	r30, 0(r3)				#stfd	f1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	sin.2764				#	bl	sin.2764
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	jr	r31				#	blr
adjust_position.3286:
	fmul	f1, f1, f1
	flup	f3, 45
	fadd	f1, f1, f3
	fmvtr	r30, f2
	sw	r30, 0(r3)				#stfd	f2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 2
	fdiv	f2, f2, f1
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	atan.2770				#	bl	atan.2770
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	tan.3284				#	bl	tan.3284
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
calc_dirvec.3289:
	lw	r6, 1(29)
	addi	r7, r0, 5				# li	r7, 5
	ble	r7, r1, ble_then.9339
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	29, 4(r3)
	fmvtr	r30, f4
	sw	r30, 6(r3)				#stfd	f4, 6(r3)
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	adjust_position.3286				#	bl	adjust_position.3286
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	addi	r1, r1, 1
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	adjust_position.3286				#	bl	adjust_position.3286
	addi	r3, r3, -14
	lw	r30, 13(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f1, 10(r3)
	fmvfr	f1, r30
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
	lw	r30, 6(r3)				#lfd	f4, 6(r3)
	fmvfr	f4, r30
	lw	r1, 12(r3)
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	lw	29, 4(r3)
	lw	r28, 0(29)
	jr	r28
ble_then.9339:
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r6, 13(r3)
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	fmvtr	r30, f2
	sw	r30, 16(r3)				#stfd	f2, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	fsqr.2746				#	bl	fsqr.2746
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	flup	f2, 2
	fadd	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f2, f2, f1
	lw	r30, 16(r3)				#lfd	f3, 16(r3)
	fmvfr	f3, r30
	fdiv	f3, f3, f1
	flup	f4, 2
	fdiv	f1, f4, f1
	lw	r1, 3(r3)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 2(r3)
	add	r30, r1, r2
	lw	r5, 0(r30)
	sw	r1, 20(r3)
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	fmvtr	r30, f3
	sw	r30, 24(r3)				#stfd	f3, 24(r3)
	fmvtr	r30, f2
	sw	r30, 26(r3)				#stfd	f2, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f1, 26(r3)
	fmvfr	f1, r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	lw	r30, 22(r3)				#lfd	f3, 22(r3)
	fmvfr	f3, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	vecset.2862				#	bl	vecset.2862
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	addi	r2, r1, 40
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	sw	r1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 29(r3)
	addi	r3, r3, 30
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -30
	lw	r30, 29(r3)
	fadd	f3, f0, f1				# fmr	f3, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f1, 26(r3)
	fmvfr	f1, r30
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	lw	r1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 29(r3)
	addi	r3, r3, 30
	jal	vecset.2862				#	bl	vecset.2862
	addi	r3, r3, -30
	lw	r30, 29(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	addi	r2, r1, 80
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 29(r3)
	addi	r3, r3, 30
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -30
	lw	r30, 29(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f1, 26(r3)
	fmvfr	f1, r30
	sw	r1, 29(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 30(r3)				#stfd	f1, 30(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -33
	lw	r30, 32(r3)
	fadd	f3, f0, f1				# fmr	f3, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	lw	r1, 29(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	vecset.2862				#	bl	vecset.2862
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	addi	r2, r1, 1
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f1, 26(r3)
	fmvfr	f1, r30
	sw	r1, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 33(r3)
	addi	r3, r3, 34
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 34(r3)				#stfd	f1, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 36(r3)				#stfd	f1, 36(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -39
	lw	r30, 38(r3)
	fadd	f3, f0, f1				# fmr	f3, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 34(r3)				#lfd	f1, 34(r3)
	fmvfr	f1, r30
	lw	r30, 36(r3)				#lfd	f2, 36(r3)
	fmvfr	f2, r30
	lw	r1, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	vecset.2862				#	bl	vecset.2862
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	addi	r2, r1, 41
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f1, 26(r3)
	fmvfr	f1, r30
	sw	r1, 38(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 39(r3)
	addi	r3, r3, 40
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -40
	lw	r30, 39(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 40(r3)				#stfd	f1, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -43
	lw	r30, 42(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 40(r3)				#lfd	f1, 40(r3)
	fmvfr	f1, r30
	lw	r30, 24(r3)				#lfd	f3, 24(r3)
	fmvfr	f3, r30
	lw	r1, 38(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	vecset.2862				#	bl	vecset.2862
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	addi	r1, r1, 81
	lw	r2, 20(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	sw	r1, 42(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 43(r3)
	addi	r3, r3, 44
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	lw	r30, 24(r3)				#lfd	f3, 24(r3)
	fmvfr	f3, r30
	lw	r1, 42(r3)
	j	vecset.2862
calc_dirvecs.3297:
	lw	r6, 1(29)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.9345
	jr	r31				#	blr
ble_then.9345:
	sw	29, 0(r3)
	sw	r1, 1(r3)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	sw	r5, 4(r3)
	sw	r2, 5(r3)
	sw	r6, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	float_of_int.2756				#	bl	float_of_int.2756
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 18
	fmul	f1, f1, f2
	flup	f2, 48
	fsub	f3, f1, f2
	addi	r1, r0, 0				# li	r1, 0
	flup	f1, 0
	flup	f2, 0
	lw	r30, 2(r3)				#lfd	f4, 2(r3)
	fmvfr	f4, r30
	lw	r2, 5(r3)
	lw	r5, 4(r3)
	lw	29, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	float_of_int.2756				#	bl	float_of_int.2756
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 18
	fmul	f1, f1, f2
	flup	f2, 45
	fadd	f3, f1, f2
	addi	r1, r0, 0				# li	r1, 0
	flup	f1, 0
	flup	f2, 0
	lw	r2, 4(r3)
	addi	r5, r2, 2
	lw	r30, 2(r3)				#lfd	f4, 2(r3)
	fmvfr	f4, r30
	lw	r6, 5(r3)
	lw	29, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	sw	r30, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	addi	r1, r1, -1
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 5(r3)
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	add_mod5.2859				#	bl	add_mod5.2859
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	lw	r1, 7(r3)
	lw	r5, 4(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
calc_dirvec_rows.3302:
	lw	r6, 1(29)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.9347
	jr	r31				#	blr
ble_then.9347:
	sw	29, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r6, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	float_of_int.2756				#	bl	float_of_int.2756
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 18
	fmul	f1, f1, f2
	flup	f2, 48
	fsub	f1, f1, f2
	addi	r1, r0, 4				# li	r1, 4
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	lw	29, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	addi	r1, r1, -1
	addi	r2, r0, 2				# li	r2, 2
	lw	r5, 3(r3)
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	add_mod5.2859				#	bl	add_mod5.2859
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	addi	r5, r1, 4
	lw	r1, 5(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
create_dirvec.3306:
	lw	r1, 1(29)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	lw	r1, 0(r1)
	sw	r2, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 1(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	jr	r31				#	blr
create_dirvec_elements.3308:
	lw	r5, 1(29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.9349
	jr	r31				#	blr
ble_then.9349:
	sw	29, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	29, r0, r5				# mr	29, r5
	sw	r30, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	29, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r28, 0(29)
	jr	r28
create_dirvecs.3311:
	lw	r2, 3(29)
	lw	r5, 2(29)
	lw	r6, 1(29)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.9351
	jr	r31				#	blr
ble_then.9351:
	addi	r7, r0, 120				# li	r7, 120
	sw	29, 0(r3)
	sw	r5, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	29, r0, r6				# mr	29, r6
	sw	r30, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	add	r30, r5, r2
	lw	r1, 0(r30)
	addi	r5, r0, 118				# li	r5, 118
	lw	29, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	addi	r1, r1, -1
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
init_dirvec_constants.3313:
	lw	r5, 1(29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.9353
	jr	r31				#	blr
ble_then.9353:
	add	r30, r1, r2
	lw	r6, 0(r30)
	sw	r1, 0(r3)
	sw	29, 1(r3)
	sw	r2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	add	29, r0, r5				# mr	29, r5
	sw	r30, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	lw	29, 1(r3)
	lw	r28, 0(29)
	jr	r28
init_vecset_constants.3316:
	lw	r2, 2(29)
	lw	r5, 1(29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r1, ble_then.9355
	jr	r31				#	blr
ble_then.9355:
	add	r30, r5, r1
	lw	r5, 0(r30)
	addi	r6, r0, 119				# li	r6, 119
	sw	29, 0(r3)
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	29, r0, r2				# mr	29, r2
	add	r2, r0, r6				# mr	r2, r6
	sw	r30, 2(r3)
	addi	r3, r3, 3
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	addi	r1, r1, -1
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
init_dirvecs.3318:
	lw	r1, 3(29)
	lw	r2, 2(29)
	lw	r5, 1(29)
	addi	r6, r0, 4				# li	r6, 4
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	add	29, r0, r2				# mr	29, r2
	sw	r30, 2(r3)
	addi	r3, r3, 3
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 9				# li	r1, 9
	addi	r2, r0, 0				# li	r2, 0
	addi	r5, r0, 0				# li	r5, 0
	lw	29, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 4				# li	r1, 4
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
add_reflection.3320:
	lw	r5, 3(29)
	lw	r6, 2(29)
	lw	29, 1(29)
	sw	r1, 0(r3)
	sw	r6, 1(r3)
	sw	r2, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	sw	r5, 6(r3)
	fmvtr	r30, f4
	sw	r30, 8(r3)				#stfd	f4, 8(r3)
	fmvtr	r30, f3
	sw	r30, 10(r3)				#stfd	f3, 10(r3)
	fmvtr	r30, f2
	sw	r30, 12(r3)				#stfd	f2, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f1, 12(r3)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 8(r3)				#lfd	f3, 8(r3)
	fmvfr	f3, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	vecset.2862				#	bl	vecset.2862
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 14(r3)
	lw	29, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 3
	lw	r30, 4(r3)				#lfd	f1, 4(r3)
	fmvfr	f1, r30
	fsw	r30, 2(r1)
	lw	r2, 14(r3)
	sw	r2, 1(r1)
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	jr	r31				#	blr
setup_rect_reflection.3327:
	lw	r5, 3(29)
	lw	r6, 2(29)
	lw	r7, 1(29)
	slli	r1, r1, 2
	lw	r8, 0(r5)
	flup	f1, 2
	sw	r5, 0(r3)
	sw	r8, 1(r3)
	sw	r7, 2(r3)
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	o_diffuse.2932				#	bl	o_diffuse.2932
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 4(r3)
	flw	f2, 0(r1)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	flw	f2, 1(r1)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	flw	f2, 2(r1)
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	fneg.2750				#	bl	fneg.2750
	addi	r3, r3, -15
	lw	r30, 14(r3)
	fadd	f4, f0, f1				# fmr	f4, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	addi	r2, r1, 1
	lw	r5, 4(r3)
	flw	f2, 0(r5)
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 12(r3)				#lfd	f3, 12(r3)
	fmvfr	f3, r30
	lw	r6, 1(r3)
	lw	29, 2(r3)
	fmvtr	r30, f4
	sw	r30, 14(r3)				#stfd	f4, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	addi	r2, r1, 1
	lw	r5, 3(r3)
	addi	r6, r5, 2
	lw	r7, 4(r3)
	flw	f3, 1(r7)
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 14(r3)				#lfd	f4, 14(r3)
	fmvfr	f4, r30
	lw	29, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r6				# mr	r2, r6
	sw	r30, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	addi	r2, r1, 2
	lw	r5, 3(r3)
	addi	r5, r5, 3
	lw	r6, 4(r3)
	flw	f4, 2(r6)
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 12(r3)				#lfd	f3, 12(r3)
	fmvfr	f3, r30
	lw	29, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	addi	r1, r1, 3
	lw	r2, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#	blr
setup_surface_reflection.3330:
	lw	r5, 3(29)
	lw	r6, 2(29)
	lw	r7, 1(29)
	slli	r1, r1, 2
	addi	r1, r1, 1
	lw	r8, 0(r5)
	flup	f1, 2
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	sw	r8, 2(r3)
	sw	r7, 3(r3)
	sw	r6, 4(r3)
	sw	r2, 5(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	o_diffuse.2932				#	bl	o_diffuse.2932
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 5(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	o_param_abc.2924				#	bl	o_param_abc.2924
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 3
	lw	r1, 5(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	fmvtr	r30, f2
	sw	r30, 12(r3)				#stfd	f2, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	o_param_a.2918				#	bl	o_param_a.2918
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 4(r3)
	flw	f3, 0(r1)
	fsub	f1, f1, f3
	flup	f3, 3
	lw	r2, 5(r3)
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	fmvtr	r30, f3
	sw	r30, 16(r3)				#stfd	f3, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	o_param_b.2920				#	bl	o_param_b.2920
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 4(r3)
	flw	f3, 1(r1)
	fsub	f1, f1, f3
	flup	f3, 3
	lw	r2, 5(r3)
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	fmvtr	r30, f3
	sw	r30, 20(r3)				#stfd	f3, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	o_param_c.2922				#	bl	o_param_c.2922
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 4(r3)
	flw	f2, 2(r1)
	fsub	f4, f1, f2
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	lw	r30, 18(r3)				#lfd	f3, 18(r3)
	fmvfr	f3, r30
	lw	r1, 2(r3)
	lw	r2, 1(r3)
	lw	29, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#	blr
setup_reflections.3333:
	lw	r2, 3(29)
	lw	r5, 2(29)
	lw	r6, 1(29)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.9363
	jr	r31				#	blr
ble_then.9363:
	add	r30, r6, r1
	lw	r6, 0(r30)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r6, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	o_reflectiontype.2912				#	bl	o_reflectiontype.2912
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 2, beq_then.9365
	jr	r31				#	blr
beq_then.9365:
	lw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	o_diffuse.2932				#	bl	o_diffuse.2932
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	flup	f2, 2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.9367
	lw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	o_form.2910				#	bl	o_form.2910
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 1, beq_then.9368
	beqi	r1, 2, beq_then.9369
	jr	r31				#	blr
beq_then.9369:
	lw	r1, 1(r3)
	lw	r2, 3(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9368:
	lw	r1, 1(r3)
	lw	r2, 3(r3)
	lw	29, 2(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.9367:
	jr	r31				#	blr
rt.3335:
	lw	r5, 14(29)
	lw	r6, 13(29)
	lw	r7, 12(29)
	lw	r8, 11(29)
	lw	r9, 10(29)
	lw	r10, 9(29)
	lw	r11, 8(29)
	lw	r12, 7(29)
	lw	r13, 6(29)
	lw	r14, 5(29)
	lw	r15, 4(29)
	lw	r16, 3(29)
	lw	r17, 2(29)
	lw	r18, 1(29)
	sw	r1, 0(r16)
	sw	r2, 1(r16)
	srai	r16, r1, 1
	sw	r16, 0(r17)
	srai	r2, r2, 1
	sw	r2, 1(r17)
	flup	f1, 49
	sw	r9, 0(r3)
	sw	r11, 1(r3)
	sw	r6, 2(r3)
	sw	r12, 3(r3)
	sw	r7, 4(r3)
	sw	r14, 5(r3)
	sw	r13, 6(r3)
	sw	r15, 7(r3)
	sw	r5, 8(r3)
	sw	r10, 9(r3)
	sw	r18, 10(r3)
	sw	r8, 11(r3)
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	float_of_int.2756				#	bl	float_of_int.2756
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r1, 11(r3)
	fsw	r30, 0(r1)
	lw	29, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	29, 10(r3)
	sw	r1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	29, 10(r3)
	sw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	29, 9(r3)
	sw	r1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	29, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	29, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	d_vec.2969				#	bl	d_vec.2969
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	lw	29, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	lw	r1, 0(r1)
	addi	r1, r1, -1
	lw	29, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	addi	r5, r0, 0				# li	r5, 0
	lw	r1, 15(r3)
	lw	29, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	addi	r7, r0, 2				# li	r7, 2
	lw	r2, 14(r3)
	lw	r5, 15(r3)
	lw	r6, 16(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
_min_caml_start: # main entry point
  addi  r3, r0, 0
  addi  r4, r0, 10000
# initialize buf
  sw  r0, 0(r4)
  sw  r0, 1(r4)
  sw  r0, 2(r4)
  sw  r0, 3(r4)
  sw  r0, 4(r4)
  sw  r0, 5(r4)
  sw  r0, 6(r4)
  sw  r0, 7(r4)
  sw  r0, 8(r4)
  sw  r0, 9(r4)
  sw  r0, 10(r4)
  sw  r0, 11(r4)
  sw  r0, 12(r4)
  sw  r0, 13(r4)
  sw  r0, 14(r4)
  sw  r0, 15(r4)
  sw  r0, 16(r4)
  addi  r4, r4, 17
#	main program starts
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, 0				# li	r2, 0
	addi	r5, r0, 1				# li	r5, 1
	addi	r6, r0, 0				# li	r6, 0
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	flup	f1, 0
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 60				# li	r2, 60
	addi	r5, r0, 0				# li	r5, 0
	addi	r6, r0, 0				# li	r6, 0
	addi	r7, r0, 0				# li	r7, 0
	addi	r8, r0, 0				# li	r8, 0
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 11
	sw	r1, 10(r9)
	sw	r1, 9(r9)
	sw	r1, 8(r9)
	sw	r1, 7(r9)
	lw	r10, 1(r3)
	sw	r10, 6(r9)
	sw	r1, 5(r9)
	sw	r1, 4(r9)
	sw	r8, 3(r9)
	sw	r7, 2(r9)
	sw	r6, 1(r9)
	sw	r5, 0(r9)
	add	r1, r0, r9				# mr	r1, r9
	addi	r30, r31, 0				#mflr	r30
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	flup	f1, 37
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 50				# li	r2, 50
	addi	r5, r0, 1				# li	r5, 1
	addi	r6, r0, -1				# li	r6, -1
	sw	r1, 7(r3)
	sw	r2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	addi	r5, r0, 1				# li	r5, 1
	lw	r6, 0(r1)
	sw	r1, 9(r3)
	sw	r2, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	flup	f1, 0
	sw	r1, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	addi	r5, r0, 0				# li	r5, 0
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	flup	f1, 31
	sw	r1, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	addi	r5, r0, 0				# li	r5, 0
	sw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 17(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 2				# li	r2, 2
	addi	r5, r0, 0				# li	r5, 0
	sw	r1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 2				# li	r2, 2
	addi	r5, r0, 0				# li	r5, 0
	sw	r1, 21(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	flup	f1, 0
	sw	r1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 23(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 25(r3)
	addi	r3, r3, 26
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -26
	lw	r30, 25(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 25(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 27(r3)
	addi	r3, r3, 28
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -28
	lw	r30, 27(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 27(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 29(r3)
	addi	r3, r3, 30
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -30
	lw	r30, 29(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	flup	f1, 0
	sw	r1, 29(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	sw	r2, 30(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r30, 31(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	add	r5, r0, r4				# mr	r5, r4
	addi	r4, r4, 2
	sw	r1, 1(r5)
	lw	r1, 30(r3)
	sw	r1, 0(r5)
	add	r1, r0, r5				# mr	r1, r5
	addi	r30, r31, 0				#mflr	r30
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r30, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r30, 31(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r30, 31(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	flup	f1, 0
	sw	r1, 31(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0
	sw	r1, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 33(r3)
	addi	r3, r3, 34
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 60				# li	r2, 60
	lw	r5, 32(r3)
	sw	r1, 33(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 33(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	addi	r2, r0, 0				# li	r2, 0
	flup	f1, 0
	sw	r1, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 35(r3)
	addi	r3, r3, 36
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -36
	lw	r30, 35(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	sw	r2, 35(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 35(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	addi	r2, r0, 180				# li	r2, 180
	addi	r5, r0, 0				# li	r5, 0
	flup	f1, 0
	add	r6, r0, r4				# mr	r6, r4
	addi	r4, r4, 3
	fsw	r30, 2(r6)
	sw	r1, 1(r6)
	sw	r5, 0(r6)
	add	r1, r0, r6				# mr	r1, r6
	addi	r30, r31, 0				#mflr	r30
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	addi	r5, r0, 0				# li	r5, 0
	sw	r1, 36(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 37(r3)
	addi	r3, r3, 38
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -38
	lw	r30, 37(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 6
	addi	r5, r0, read_screen_settings.2981
	sw	r5, 0(r2)
	lw	r5, 5(r3)
	sw	r5, 5(r2)
	lw	r6, 28(r3)
	sw	r6, 4(r2)
	lw	r7, 27(r3)
	sw	r7, 3(r2)
	lw	r8, 26(r3)
	sw	r8, 2(r2)
	lw	r9, 4(r3)
	sw	r9, 1(r2)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 3
	addi	r10, r0, read_light.2983
	sw	r10, 0(r9)
	lw	r10, 6(r3)
	sw	r10, 2(r9)
	lw	r11, 7(r3)
	sw	r11, 1(r9)
	add	r12, r0, r4				# mr	r12, r4
	addi	r4, r4, 2
	addi	r13, r0, read_nth_object.2988
	sw	r13, 0(r12)
	lw	r13, 3(r3)
	sw	r13, 1(r12)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 3
	addi	r15, r0, read_object.2990
	sw	r15, 0(r14)
	sw	r12, 2(r14)
	lw	r12, 2(r3)
	sw	r12, 1(r14)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 2
	addi	r16, r0, read_all_object.2992
	sw	r16, 0(r15)
	sw	r14, 1(r15)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 2
	addi	r16, r0, read_and_network.2998
	sw	r16, 0(r14)
	lw	r16, 9(r3)
	sw	r16, 1(r14)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 6
	addi	r18, r0, read_parameter.3000
	sw	r18, 0(r17)
	sw	r2, 5(r17)
	sw	r9, 4(r17)
	sw	r14, 3(r17)
	sw	r15, 2(r17)
	lw	r2, 11(r3)
	sw	r2, 1(r17)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r14, r0, solver_rect_surface.3002
	sw	r14, 0(r9)
	lw	r14, 12(r3)
	sw	r14, 1(r9)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 2
	addi	r18, r0, solver_rect.3011
	sw	r18, 0(r15)
	sw	r9, 1(r15)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r18, r0, solver_surface.3017
	sw	r18, 0(r9)
	sw	r14, 1(r9)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 2
	addi	r19, r0, solver_second.3036
	sw	r19, 0(r18)
	sw	r14, 1(r18)
	add	r19, r0, r4				# mr	r19, r4
	addi	r4, r4, 5
	addi	r20, r0, solver.3042
	sw	r20, 0(r19)
	sw	r9, 4(r19)
	sw	r18, 3(r19)
	sw	r15, 2(r19)
	sw	r13, 1(r19)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r15, r0, solver_rect_fast.3046
	sw	r15, 0(r9)
	sw	r14, 1(r9)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 2
	addi	r18, r0, solver_surface_fast.3053
	sw	r18, 0(r15)
	sw	r14, 1(r15)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 2
	addi	r20, r0, solver_second_fast.3059
	sw	r20, 0(r18)
	sw	r14, 1(r18)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 5
	addi	r21, r0, solver_fast.3065
	sw	r21, 0(r20)
	sw	r15, 4(r20)
	sw	r18, 3(r20)
	sw	r9, 2(r20)
	sw	r13, 1(r20)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 2
	addi	r18, r0, solver_surface_fast2.3069
	sw	r18, 0(r15)
	sw	r14, 1(r15)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 2
	addi	r21, r0, solver_second_fast2.3076
	sw	r21, 0(r18)
	sw	r14, 1(r18)
	add	r21, r0, r4				# mr	r21, r4
	addi	r4, r4, 5
	addi	r22, r0, solver_fast2.3083
	sw	r22, 0(r21)
	sw	r15, 4(r21)
	sw	r18, 3(r21)
	sw	r9, 2(r21)
	sw	r13, 1(r21)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r15, r0, iter_setup_dirvec_constants.3095
	sw	r15, 0(r9)
	sw	r13, 1(r9)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 3
	addi	r18, r0, setup_dirvec_constants.3098
	sw	r18, 0(r15)
	sw	r12, 2(r15)
	sw	r9, 1(r15)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r18, r0, setup_startp_constants.3100
	sw	r18, 0(r9)
	sw	r13, 1(r9)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 4
	addi	r22, r0, setup_startp.3103
	sw	r22, 0(r18)
	lw	r22, 25(r3)
	sw	r22, 3(r18)
	sw	r9, 2(r18)
	sw	r12, 1(r18)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r23, r0, check_all_inside.3125
	sw	r23, 0(r9)
	sw	r13, 1(r9)
	add	r23, r0, r4				# mr	r23, r4
	addi	r4, r4, 8
	addi	r24, r0, shadow_check_and_group.3131
	sw	r24, 0(r23)
	sw	r20, 7(r23)
	sw	r14, 6(r23)
	sw	r13, 5(r23)
	lw	r24, 34(r3)
	sw	r24, 4(r23)
	sw	r10, 3(r23)
	lw	r25, 15(r3)
	sw	r25, 2(r23)
	sw	r9, 1(r23)
	add	r26, r0, r4				# mr	r26, r4
	addi	r4, r4, 3
	addi	r27, r0, shadow_check_one_or_group.3134
	sw	r27, 0(r26)
	sw	r23, 2(r26)
	sw	r16, 1(r26)
	add	r23, r0, r4				# mr	r23, r4
	addi	r4, r4, 6
	addi	r27, r0, shadow_check_one_or_matrix.3137
	sw	r27, 0(r23)
	sw	r20, 5(r23)
	sw	r14, 4(r23)
	sw	r26, 3(r23)
	sw	r24, 2(r23)
	sw	r25, 1(r23)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 10
	addi	r26, r0, solve_each_element.3140
	sw	r26, 0(r20)
	lw	r26, 14(r3)
	sw	r26, 9(r20)
	lw	r27, 24(r3)
	sw	r27, 8(r20)
	sw	r14, 7(r20)
	sw	r19, 6(r20)
	sw	r13, 5(r20)
	lw	r28, 13(r3)
	sw	r28, 4(r20)
	sw	r25, 3(r20)
	lw	29, 16(r3)
	sw	29, 2(r20)
	sw	r9, 1(r20)
	add	r24, r0, r4				# mr	r24, r4
	addi	r4, r4, 3
	sw	r17, 37(r3)
	addi	r17, r0, solve_one_or_network.3144
	sw	r17, 0(r24)
	sw	r20, 2(r24)
	sw	r16, 1(r24)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 6
	addi	r20, r0, trace_or_matrix.3148
	sw	r20, 0(r17)
	sw	r26, 5(r17)
	sw	r27, 4(r17)
	sw	r14, 3(r17)
	sw	r19, 2(r17)
	sw	r24, 1(r17)
	add	r19, r0, r4				# mr	r19, r4
	addi	r4, r4, 4
	addi	r20, r0, judge_intersection.3152
	sw	r20, 0(r19)
	sw	r17, 3(r19)
	sw	r26, 2(r19)
	sw	r2, 1(r19)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 10
	addi	r20, r0, solve_each_element_fast.3154
	sw	r20, 0(r17)
	sw	r26, 9(r17)
	sw	r22, 8(r17)
	sw	r21, 7(r17)
	sw	r14, 6(r17)
	sw	r13, 5(r17)
	sw	r28, 4(r17)
	sw	r25, 3(r17)
	sw	29, 2(r17)
	sw	r9, 1(r17)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 3
	addi	r20, r0, solve_one_or_network_fast.3158
	sw	r20, 0(r9)
	sw	r17, 2(r9)
	sw	r16, 1(r9)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 5
	addi	r17, r0, trace_or_matrix_fast.3162
	sw	r17, 0(r16)
	sw	r26, 4(r16)
	sw	r21, 3(r16)
	sw	r14, 2(r16)
	sw	r9, 1(r16)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 4
	addi	r14, r0, judge_intersection_fast.3166
	sw	r14, 0(r9)
	sw	r16, 3(r9)
	sw	r26, 2(r9)
	sw	r2, 1(r9)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 3
	addi	r16, r0, get_nvector_rect.3168
	sw	r16, 0(r14)
	lw	r16, 17(r3)
	sw	r16, 2(r14)
	sw	r28, 1(r14)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 2
	addi	r20, r0, get_nvector_plane.3170
	sw	r20, 0(r17)
	sw	r16, 1(r17)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 3
	addi	r21, r0, get_nvector_second.3172
	sw	r21, 0(r20)
	sw	r16, 2(r20)
	sw	r25, 1(r20)
	add	r21, r0, r4				# mr	r21, r4
	addi	r4, r4, 4
	addi	r22, r0, get_nvector.3174
	sw	r22, 0(r21)
	sw	r20, 3(r21)
	sw	r14, 2(r21)
	sw	r17, 1(r21)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 2
	addi	r17, r0, utexture.3177
	sw	r17, 0(r14)
	lw	r17, 18(r3)
	sw	r17, 1(r14)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 3
	addi	r22, r0, add_light.3180
	sw	r22, 0(r20)
	sw	r17, 2(r20)
	lw	r22, 20(r3)
	sw	r22, 1(r20)
	add	r24, r0, r4				# mr	r24, r4
	addi	r4, r4, 9
	sw	r15, 38(r3)
	addi	r15, r0, trace_reflections.3184
	sw	r15, 0(r24)
	sw	r23, 8(r24)
	lw	r15, 36(r3)
	sw	r15, 7(r24)
	sw	r2, 6(r24)
	sw	r16, 5(r24)
	sw	r9, 4(r24)
	sw	r28, 3(r24)
	sw	29, 2(r24)
	sw	r20, 1(r24)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 23
	addi	r12, r0, trace_ray.3189
	sw	r12, 0(r15)
	sw	r14, 22(r15)
	lw	r12, 0(r3)
	sw	r12, 21(r15)
	sw	r24, 20(r15)
	sw	r26, 19(r15)
	sw	r17, 18(r15)
	sw	r27, 17(r15)
	sw	r23, 16(r15)
	sw	r18, 15(r15)
	sw	r22, 14(r15)
	sw	r2, 13(r15)
	sw	r13, 12(r15)
	sw	r16, 11(r15)
	sw	r1, 10(r15)
	sw	r10, 9(r15)
	sw	r19, 8(r15)
	sw	r28, 7(r15)
	sw	r25, 6(r15)
	sw	29, 5(r15)
	sw	r21, 4(r15)
	lw	r12, 1(r3)
	sw	r12, 3(r15)
	sw	r11, 2(r15)
	sw	r20, 1(r15)
	add	r11, r0, r4				# mr	r11, r4
	addi	r4, r4, 13
	addi	r19, r0, trace_diffuse_ray.3195
	sw	r19, 0(r11)
	sw	r14, 12(r11)
	sw	r17, 11(r11)
	sw	r23, 10(r11)
	sw	r2, 9(r11)
	sw	r13, 8(r11)
	sw	r16, 7(r11)
	sw	r10, 6(r11)
	sw	r9, 5(r11)
	sw	r25, 4(r11)
	sw	29, 3(r11)
	sw	r21, 2(r11)
	lw	r2, 19(r3)
	sw	r2, 1(r11)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r14, r0, iter_trace_diffuse_rays.3198
	sw	r14, 0(r9)
	sw	r11, 1(r9)
	add	r11, r0, r4				# mr	r11, r4
	addi	r4, r4, 3
	addi	r14, r0, trace_diffuse_rays.3203
	sw	r14, 0(r11)
	sw	r18, 2(r11)
	sw	r9, 1(r11)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 3
	addi	r14, r0, trace_diffuse_ray_80percent.3207
	sw	r14, 0(r9)
	sw	r11, 2(r9)
	lw	r14, 31(r3)
	sw	r14, 1(r9)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 4
	addi	r17, r0, calc_diffuse_using_1point.3211
	sw	r17, 0(r16)
	sw	r9, 3(r16)
	sw	r22, 2(r16)
	sw	r2, 1(r16)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 3
	addi	r17, r0, calc_diffuse_using_5points.3214
	sw	r17, 0(r9)
	sw	r22, 2(r9)
	sw	r2, 1(r9)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 2
	addi	r18, r0, do_without_neighbors.3220
	sw	r18, 0(r17)
	sw	r16, 1(r17)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 2
	addi	r18, r0, neighbors_exist.3223
	sw	r18, 0(r16)
	lw	r18, 21(r3)
	sw	r18, 1(r16)
	add	r19, r0, r4				# mr	r19, r4
	addi	r4, r4, 3
	addi	r20, r0, try_exploit_neighbors.3236
	sw	r20, 0(r19)
	sw	r17, 2(r19)
	sw	r9, 1(r19)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r20, r0, write_ppm_header.3243
	sw	r20, 0(r9)
	sw	r18, 1(r9)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 2
	addi	r21, r0, write_rgb.3247
	sw	r21, 0(r20)
	sw	r22, 1(r20)
	add	r21, r0, r4				# mr	r21, r4
	addi	r4, r4, 4
	addi	r23, r0, pretrace_diffuse_rays.3249
	sw	r23, 0(r21)
	sw	r11, 3(r21)
	sw	r14, 2(r21)
	sw	r2, 1(r21)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 11
	addi	r11, r0, pretrace_pixels.3252
	sw	r11, 0(r2)
	sw	r5, 10(r2)
	sw	r15, 9(r2)
	sw	r27, 8(r2)
	sw	r8, 7(r2)
	lw	r5, 23(r3)
	sw	r5, 6(r2)
	sw	r22, 5(r2)
	lw	r8, 29(r3)
	sw	r8, 4(r2)
	sw	r21, 3(r2)
	lw	r8, 22(r3)
	sw	r8, 2(r2)
	sw	r12, 1(r2)
	add	r11, r0, r4				# mr	r11, r4
	addi	r4, r4, 7
	addi	r15, r0, pretrace_line.3259
	sw	r15, 0(r11)
	sw	r6, 6(r11)
	sw	r7, 5(r11)
	sw	r5, 4(r11)
	sw	r2, 3(r11)
	sw	r18, 2(r11)
	sw	r8, 1(r11)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 7
	addi	r6, r0, scan_pixel.3263
	sw	r6, 0(r2)
	sw	r20, 6(r2)
	sw	r19, 5(r2)
	sw	r22, 4(r2)
	sw	r16, 3(r2)
	sw	r18, 2(r2)
	sw	r17, 1(r2)
	add	r6, r0, r4				# mr	r6, r4
	addi	r4, r4, 4
	addi	r7, r0, scan_line.3269
	sw	r7, 0(r6)
	sw	r2, 3(r6)
	sw	r11, 2(r6)
	sw	r18, 1(r6)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	addi	r7, r0, create_pixel.3277
	sw	r7, 0(r2)
	sw	r12, 1(r2)
	add	r7, r0, r4				# mr	r7, r4
	addi	r4, r4, 2
	addi	r12, r0, init_line_elements.3279
	sw	r12, 0(r7)
	sw	r2, 1(r7)
	add	r12, r0, r4				# mr	r12, r4
	addi	r4, r4, 4
	addi	r15, r0, create_pixelline.3282
	sw	r15, 0(r12)
	sw	r7, 3(r12)
	sw	r18, 2(r12)
	sw	r2, 1(r12)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	addi	r7, r0, calc_dirvec.3289
	sw	r7, 0(r2)
	sw	r14, 1(r2)
	add	r7, r0, r4				# mr	r7, r4
	addi	r4, r4, 2
	addi	r15, r0, calc_dirvecs.3297
	sw	r15, 0(r7)
	sw	r2, 1(r7)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	addi	r15, r0, calc_dirvec_rows.3302
	sw	r15, 0(r2)
	sw	r7, 1(r2)
	add	r7, r0, r4				# mr	r7, r4
	addi	r4, r4, 2
	addi	r15, r0, create_dirvec.3306
	sw	r15, 0(r7)
	lw	r15, 2(r3)
	sw	r15, 1(r7)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 2
	addi	r17, r0, create_dirvec_elements.3308
	sw	r17, 0(r16)
	sw	r7, 1(r16)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 4
	addi	r19, r0, create_dirvecs.3311
	sw	r19, 0(r17)
	sw	r14, 3(r17)
	sw	r16, 2(r17)
	sw	r7, 1(r17)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 2
	addi	r19, r0, init_dirvec_constants.3313
	sw	r19, 0(r16)
	lw	r19, 38(r3)
	sw	r19, 1(r16)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 3
	addi	r21, r0, init_vecset_constants.3316
	sw	r21, 0(r20)
	sw	r16, 2(r20)
	sw	r14, 1(r20)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 4
	addi	r16, r0, init_dirvecs.3318
	sw	r16, 0(r14)
	sw	r20, 3(r14)
	sw	r17, 2(r14)
	sw	r2, 1(r14)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 4
	addi	r16, r0, add_reflection.3320
	sw	r16, 0(r2)
	sw	r19, 3(r2)
	lw	r16, 36(r3)
	sw	r16, 2(r2)
	sw	r7, 1(r2)
	add	r7, r0, r4				# mr	r7, r4
	addi	r4, r4, 4
	addi	r16, r0, setup_rect_reflection.3327
	sw	r16, 0(r7)
	sw	r1, 3(r7)
	sw	r10, 2(r7)
	sw	r2, 1(r7)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 4
	addi	r17, r0, setup_surface_reflection.3330
	sw	r17, 0(r16)
	sw	r1, 3(r16)
	sw	r10, 2(r16)
	sw	r2, 1(r16)
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 4
	addi	r2, r0, setup_reflections.3333
	sw	r2, 0(r1)
	sw	r16, 3(r1)
	sw	r7, 2(r1)
	sw	r13, 1(r1)
	add	29, r0, r4				# mr	29, r4
	addi	r4, r4, 15
	addi	r2, r0, rt.3335
	sw	r2, 0(29)
	sw	r9, 14(29)
	sw	r1, 13(29)
	sw	r19, 12(29)
	sw	r5, 11(29)
	sw	r6, 10(29)
	lw	r1, 37(r3)
	sw	r1, 9(29)
	sw	r11, 8(29)
	sw	r15, 7(29)
	lw	r1, 34(r3)
	sw	r1, 6(29)
	sw	r10, 5(29)
	sw	r14, 4(29)
	sw	r18, 3(29)
	sw	r8, 2(29)
	sw	r12, 1(29)
	addi	r1, r0, 128				# li	r1, 128
	addi	r2, r0, 128				# li	r2, 128
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 39(r3)
	addi	r3, r3, 40
	lw	r30, 0(29)
	jalr	r30
	addi	r3, r3, -40
	lw	r30, 39(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	_R_0, r0, 0				# li	_R_0, 0
