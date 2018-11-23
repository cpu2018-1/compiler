	.data
	.literal8
	.align 3
l.6052:	 # 128.000000
	.long	0
	.long	1080033280
	.align 3
l.6044:	 # 0.900000
	.long	-858993459
	.long	1072483532
	.align 3
l.6043:	 # 0.200000
	.long	-1717986918
	.long	1070176665
	.align 3
l.6033:	 # 150.000000
	.long	0
	.long	1080213504
	.align 3
l.6032:	 # -150.000000
	.long	0
	.long	-1067270144
	.align 3
l.6031:	 # 0.100000
	.long	-1717986918
	.long	1069128089
	.align 3
l.6030:	 # -2.000000
	.long	0
	.long	-1073741824
	.align 3
l.6029:	 # 0.003906
	.long	0
	.long	1064304640
	.align 3
l.6028:	 # 20.000000
	.long	0
	.long	1077149696
	.align 3
l.6027:	 # 0.050000
	.long	-1717986918
	.long	1068079513
	.align 3
l.6026:	 # 0.250000
	.long	0
	.long	1070596096
	.align 3
l.6025:	 # 10.000000
	.long	0
	.long	1076101120
	.align 3
l.6024:	 # 0.300000
	.long	858993459
	.long	1070805811
	.align 3
l.6023:	 # 255.000000
	.long	0
	.long	1081073664
	.align 3
l.6022:	 # 0.500000
	.long	0
	.long	1071644672
	.align 3
l.6021:	 # 0.150000
	.long	858993459
	.long	1069757235
	.align 3
l.6020:	 # 3.141593
	.long	1518260631
	.long	1074340347
	.align 3
l.6019:	 # 30.000000
	.long	0
	.long	1077805056
	.align 3
l.6018:	 # 15.000000
	.long	0
	.long	1076756480
	.align 3
l.6017:	 # 0.000100
	.long	-350469331
	.long	1058682594
	.align 3
l.6016:	 # 100000000.000000
	.long	0
	.long	1100470148
	.align 3
l.6015:	 # 1000000000.000000
	.long	0
	.long	1104006501
	.align 3
l.6014:	 # -0.100000
	.long	-1717986918
	.long	-1078355559
	.align 3
l.6013:	 # 0.010000
	.long	1202590843
	.long	1065646817
	.align 3
l.6012:	 # -0.200000
	.long	-1717986918
	.long	-1077306983
	.align 3
l.5999:	 # 2.000000
	.long	0
	.long	1073741824
	.align 3
l.5998:	 # -200.000000
	.long	0
	.long	-1066860544
	.align 3
l.5997:	 # 200.000000
	.long	0
	.long	1080623104
	.align 3
l.5996:	 # 0.017453
	.long	-1433277178
	.long	1066524486
	.align 3
l.5995:	 # -1.000000
	.long	0
	.long	-1074790400
	.align 3
l.5994:	 # 1.000000
	.long	0
	.long	1072693248
	.align 3
l.5993:	 # 0.000000
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.851
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
_fle_then.851:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
lib_fisneg:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.852
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
_fle_then.852:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
lib_fiszero:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
	feq	r30, f1, f2
	bne	r0, r30, _feq_then.853
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
_feq_then.853:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
lib_xor:
	beq	r1, r2, _beq_then.854
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
_beq_then.854:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
lib_fhalf:
	addi	r30, r0, 0
	lui	r30, r30, 16128	# to load float		0.500000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
lib_fsqr:
	fmul	f1, f1, f1
	jr	r31				#	blr
lib_fabs:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.855
 lib_fneg	f1, f1
	jr	r31				#	blr
_fle_then.855:
	jr	r31				#	blr
lib_fneg:
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
	bne	r0, r30, _fle_then.856
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
	jr	r31				#	blr
_fle_then.856:
	jr	r31				#	blr
lib_int_of_float:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
	feq	r30, f1, f2
	bne	r0, r30, _feq_then.857
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.858
	addi	r30, r0, 0
	lui	r30, r30, 16128	# to load float		0.500000
	fmvfr	f2, r30
	fadd	f1, f1, f2
	j	lib_ftoi
_fle_then.858:
	addi	r30, r0, 0
	lui	r30, r30, 16128	# to load float		0.500000
	fmvfr	f2, r30
	fsub	f1, f1, f2
	j	lib_ftoi
_feq_then.857:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
lib_float_of_int:
	j	lib_itof
lib_hoge:
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.859
	fadd	f1, f0, f2				# fmr	f1, f2
	jr	r31				#	blr
_fle_then.859:
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.860
	fadd	f1, f0, f2				# fmr	f1, f2
	jr	r31				#	blr
_fle_then.860:
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f3, r30
	fmul	f2, f3, f2
	j lib_hoge
lib_fuga:
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f4, r30
	fmul	f4, f3, f4
	fle	r30, f4, f1
	bne	r0, r30, _fle_then.861
	jr	r31				#	blr
_fle_then.861:
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.862
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f4, r30
	fdiv	f2, f2, f4
	j lib_fuga
_fle_then.862:
	fsub	f1, f1, f2
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f4, r30
	fdiv	f2, f2, f4
	j lib_fuga
lib_modulo_2pi:
	addi	r30, r0, 4059
	lui	r30, r30, 16457	# to load float		3.141593
	fmvfr	f3, r30
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16585	# to load float		6.283185
	fmvfr	f2, r30
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.863
	j	_fle_cont.864
_fle_then.863:
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f2, r30
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
_fle_cont.864:
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
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	addi	r30, r0, 0
	lui	r30, r30, 16128	# to load float		0.500000
	fmvfr	f3, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.865
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f3, r30
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f3, r30
	j	_fle_cont.866
_fle_then.865:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f3, r30
_fle_cont.866:
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
	bne	r0, r30, _fle_then.867
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f3, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.868
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.869
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.869:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.868:
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.870
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.870:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.867:
	fsub	f1, f1, f2
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
 lib_fneg	f3, f3
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f4, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f4, r30
	fle	r30, f4, f1
	bne	r0, r30, _fle_then.871
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.872
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f2, r30
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
_fle_then.872:
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
_fle_then.871:
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.873
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f2, r30
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
_fle_then.873:
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
lib_cos:
	addi	r30, r0, 4059
	lui	r30, r30, 16457	# to load float		3.141593
	fmvfr	f2, r30
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f3, r30
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
	bne	r0, r30, _fle_then.874
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f3, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.875
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.876
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.876:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.875:
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f2, r30
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f3, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f3, r30
	fle	r30, f1, f3
	bne	r0, r30, _fle_then.877
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f3, r30
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
_fle_then.877:
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
_fle_then.874:
	fsub	f1, f1, f2
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f3, r30
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f4, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f4, r30
	fle	r30, f4, f1
	bne	r0, r30, _fle_then.878
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.879
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f2, r30
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
_fle_then.879:
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
_fle_then.878:
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f3, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f3, r30
	fle	r30, f1, f3
	bne	r0, r30, _fle_then.880
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f3, r30
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
_fle_then.880:
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
lib_atan_body:
	addi	r30, r0, 43690
	lui	r30, r30, 16042	# to load float		0.333333
	fmvfr	f2, r30
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fsub	f2, f1, f2
	addi	r30, r0, 52429
	lui	r30, r30, 15948	# to load float		0.200000
	fmvfr	f3, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.881
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f2, r30
	j	_fle_cont.882
_fle_then.881:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
_fle_cont.882:
	fmul	f1, f1, f2
	addi	r30, r0, 0
	lui	r30, r30, 16524	# to load float		4.375000
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.883
	j lib_atan_body
_fle_then.883:
	addi	r30, r0, 0
	lui	r30, r30, 16412	# to load float		2.437500
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.884
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f3, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f3, r30
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f4, r30
	fsub	f4, f1, f4
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f5, r30
	fadd	f1, f1, f5
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
_fle_then.884:
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f3, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f3, r30
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f4, r30
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
	ble	r7, r1, _ble_then.885
	add	r5, r0, r6				# mr	r5, r6
	j lib_div10_sub
_ble_then.885:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, _ble_then.886
	add	r2, r0, r6				# mr	r2, r6
	j lib_div10_sub
_ble_then.886:
	add	r1, r0, r6				# mr	r1, r6
	jr	r31				#	blr
lib_div10:
	addi	r2, r0, 0				# li	r2, 0
	add	r5, r0, r1				# mr	r5, r1
	j lib_div10_sub
lib_iter_mul10:
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, _beq_then.887
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r5, r0, 1				# li	r5, 1
	sub	r2, r2, r5
	j lib_iter_mul10
_beq_then.887:
	jr	r31				#	blr
lib_iter_div10:
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, _beq_then.888
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
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j lib_iter_div10
_beq_then.888:
	jr	r31				#	blr
lib_keta_sub:
	addi	r5, r0, 10				# li	r5, 10
	ble	r5, r1, _ble_then.889
	addi	r1, r2, 1
	jr	r31				#	blr
_ble_then.889:
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
	addi	r5, r0, 1				# li	r5, 1
	beq	r2, r5, _beq_then.890
	addi	r5, r0, 1				# li	r5, 1
	addi	r6, r0, 1				# li	r6, 1
	sub	r6, r2, r6
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
	ble	r1, r2, _ble_then.891
	addi	r1, r0, 48				# li	r1, 48
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 0(r3)
	sub	r2, r2, r1
	lw	r1, 1(r3)
	j lib_print_uint_keta
_ble_then.891:
	addi	r1, r0, 1				# li	r1, 1
	lw	r5, 0(r3)
	sub	r1, r5, r1
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
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
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 0(r3)
	sub	r1, r2, r1
	lw	r5, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal lib_iter_mul10				#	bl lib_iter_mul10
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	sub	r1, r2, r1
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j lib_print_uint_keta
_beq_then.890:
	addi	r1, r1, 48
	j	lib_print_char
lib_print_uint:
	addi	r2, r0, 10				# li	r2, 10
	ble	r2, r1, _ble_then.892
	addi	r1, r1, 48
	j	lib_print_char
_ble_then.892:
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
	ble	r2, r1, _ble_then.893
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
_ble_then.893:
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
	beq	r1, r2, _beq_then.894
	addi	r2, r0, 9				# li	r2, 9
	beq	r1, r2, _beq_then.895
	addi	r2, r0, 13				# li	r2, 13
	beq	r1, r2, _beq_then.896
	addi	r2, r0, 10				# li	r2, 10
	beq	r1, r2, _beq_then.897
	addi	r2, r0, 26				# li	r2, 26
	beq	r1, r2, _beq_then.898
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_buffer_add_char				#	bl	lib_buffer_add_char
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	j lib_read_token
_beq_then.898:
	jr	r31				#	blr
_beq_then.897:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 0(r3)
	beq	r2, r1, _beq_then.900
	jr	r31				#	blr
_beq_then.900:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
_beq_then.896:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 0(r3)
	beq	r2, r1, _beq_then.902
	jr	r31				#	blr
_beq_then.902:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
_beq_then.895:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 0(r3)
	beq	r2, r1, _beq_then.904
	jr	r31				#	blr
_beq_then.904:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
_beq_then.894:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 0(r3)
	beq	r2, r1, _beq_then.906
	jr	r31				#	blr
_beq_then.906:
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, _beq_then.908
	addi	r30, r0, 0
	lui	r30, r30, 16672	# to load float		10.000000
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	addi	r2, r0, 1				# li	r2, 1
	sub	r1, r1, r2
	j lib_iter_div10_float
_beq_then.908:
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
	beq	r5, r2, _beq_then.909
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
_beq_then.909:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.910
 lib_fneg	f1, f1
	jr	r31				#	blr
_fle_then.910:
	jr	r31				#	blr
lib_print_dec:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
	feq	r30, f1, f2
	bne	r0, r30, _feq_then.911
	addi	r30, r0, 0
	lui	r30, r30, 16672	# to load float		10.000000
	fmvfr	f2, r30
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
_feq_then.911:
	jr	r31				#	blr
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.913
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
_fle_then.913:
	j lib_print_ufloat
# library ends
xor.2462:
	beqi	r1, 0, beq_then.8139
	beqi	r2, 0, beq_then.8140
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8140:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.8139:
	add	r1, r0, r2				# mr	r1, r2
	jr	r31				#	blr
sgn.2465:
	fmvtr	r30, f1
	sw	r30, 0(r3)				#stfd	f1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8141
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	jr	r31				#	blr
beq_then.8141:
	lw	r30, 0(r3)				#lfd	f1, 0(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8142
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	jr	r31				#	blr
beq_then.8142:
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
	jr	r31				#	blr
fneg_cond.2467:
	beqi	r1, 0, beq_then.8143
	jr	r31				#	blr
beq_then.8143:
	j	lib_fneg
add_mod5.2470:
	add	r1, r1, r2
	addi	r2, r0, 5				# li	r2, 5
	ble	r2, r1, ble_then.8144
	jr	r31				#	blr
ble_then.8144:
	addi	r1, r1, -5
	jr	r31				#	blr
vecset.2473:
	fsw	r30, 0(r1)
	fsw	r30, 1(r1)
	fsw	r30, 2(r1)
	jr	r31				#	blr
vecfill.2478:
	fsw	r30, 0(r1)
	fsw	r30, 1(r1)
	fsw	r30, 2(r1)
	jr	r31				#	blr
vecbzero.2481:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	vecfill.2478
veccpy.2483:
	flw	f1, 0(r2)
	fsw	r30, 0(r1)
	flw	f1, 1(r2)
	fsw	r30, 1(r1)
	flw	f1, 2(r2)
	fsw	r30, 2(r1)
	jr	r31				#	blr
vecunit_sgn.2491:
	flw	f1, 0(r1)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8148
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	j	beq_cont.8149
beq_then.8148:
	lw	r1, 0(r3)
	beqi	r1, 0, beq_then.8150
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	j	beq_cont.8151
beq_then.8150:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
beq_cont.8151:
beq_cont.8149:
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
veciprod.2494:
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
veciprod2.2497:
	flw	f4, 0(r1)
	fmul	f1, f4, f1
	flw	f4, 1(r1)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	jr	r31				#	blr
vecaccum.2502:
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
vecadd.2506:
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
vecscale.2512:
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
vecaccumv.2515:
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
o_texturetype.2519:
	lw	r1, 0(r1)
	jr	r31				#	blr
o_form.2521:
	lw	r1, 1(r1)
	jr	r31				#	blr
o_reflectiontype.2523:
	lw	r1, 2(r1)
	jr	r31				#	blr
o_isinvert.2525:
	lw	r1, 6(r1)
	jr	r31				#	blr
o_isrot.2527:
	lw	r1, 3(r1)
	jr	r31				#	blr
o_param_a.2529:
	lw	r1, 4(r1)
	flw	f1, 0(r1)
	jr	r31				#	blr
o_param_b.2531:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	jr	r31				#	blr
o_param_c.2533:
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	jr	r31				#	blr
o_param_abc.2535:
	lw	r1, 4(r1)
	jr	r31				#	blr
o_param_x.2537:
	lw	r1, 5(r1)
	flw	f1, 0(r1)
	jr	r31				#	blr
o_param_y.2539:
	lw	r1, 5(r1)
	flw	f1, 1(r1)
	jr	r31				#	blr
o_param_z.2541:
	lw	r1, 5(r1)
	flw	f1, 2(r1)
	jr	r31				#	blr
o_diffuse.2543:
	lw	r1, 7(r1)
	flw	f1, 0(r1)
	jr	r31				#	blr
o_hilight.2545:
	lw	r1, 7(r1)
	flw	f1, 1(r1)
	jr	r31				#	blr
o_color_red.2547:
	lw	r1, 8(r1)
	flw	f1, 0(r1)
	jr	r31				#	blr
o_color_green.2549:
	lw	r1, 8(r1)
	flw	f1, 1(r1)
	jr	r31				#	blr
o_color_blue.2551:
	lw	r1, 8(r1)
	flw	f1, 2(r1)
	jr	r31				#	blr
o_param_r1.2553:
	lw	r1, 9(r1)
	flw	f1, 0(r1)
	jr	r31				#	blr
o_param_r2.2555:
	lw	r1, 9(r1)
	flw	f1, 1(r1)
	jr	r31				#	blr
o_param_r3.2557:
	lw	r1, 9(r1)
	flw	f1, 2(r1)
	jr	r31				#	blr
o_param_ctbl.2559:
	lw	r1, 10(r1)
	jr	r31				#	blr
p_rgb.2561:
	lw	r1, 0(r1)
	jr	r31				#	blr
p_intersection_points.2563:
	lw	r1, 1(r1)
	jr	r31				#	blr
p_surface_ids.2565:
	lw	r1, 2(r1)
	jr	r31				#	blr
p_calc_diffuse.2567:
	lw	r1, 3(r1)
	jr	r31				#	blr
p_energy.2569:
	lw	r1, 4(r1)
	jr	r31				#	blr
p_received_ray_20percent.2571:
	lw	r1, 5(r1)
	jr	r31				#	blr
p_group_id.2573:
	lw	r1, 6(r1)
	lw	r1, 0(r1)
	jr	r31				#	blr
p_set_group_id.2575:
	lw	r1, 6(r1)
	sw	r2, 0(r1)
	jr	r31				#	blr
p_nvectors.2578:
	lw	r1, 7(r1)
	jr	r31				#	blr
d_vec.2580:
	lw	r1, 0(r1)
	jr	r31				#	blr
d_const.2582:
	lw	r1, 1(r1)
	jr	r31				#	blr
r_surface_id.2584:
	lw	r1, 0(r1)
	jr	r31				#	blr
r_dvec.2586:
	lw	r1, 1(r1)
	jr	r31				#	blr
r_bright.2588:
	flw	f1, 2(r1)
	jr	r31				#	blr
rad.2590:
	addi	r30, r0, 64053
	lui	r30, r30, 15502	# to load float		0.017453
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
read_screen_settings.2592:
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
	jal	rad.2590				#	bl	rad.2590
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_cos				#	bl	lib_cos
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
	jal	lib_sin				#	bl	lib_sin
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
	jal	rad.2590				#	bl	rad.2590
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_cos				#	bl	lib_cos
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
	jal	lib_sin				#	bl	lib_sin
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fmul	f3, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 17224	# to load float		200.000000
	fmvfr	f4, r30
	fmul	f3, f3, f4
	lw	r1, 3(r3)
	fsw	r30, 0(r1)
	addi	r30, r0, 0
	lui	r30, r30, 49992	# to load float		-200.000000
	fmvfr	f3, r30
	lw	r30, 10(r3)				#lfd	f4, 10(r3)
	fmvfr	f4, r30
	fmul	f3, f4, f3
	fsw	r30, 1(r1)
	lw	r30, 14(r3)				#lfd	f3, 14(r3)
	fmvfr	f3, r30
	fmul	f5, f2, f3
	addi	r30, r0, 0
	lui	r30, r30, 17224	# to load float		200.000000
	fmvfr	f6, r30
	fmul	f5, f5, f6
	fsw	r30, 2(r1)
	lw	r2, 2(r3)
	fsw	r30, 0(r2)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f5, r30
	fsw	r30, 1(r2)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	lib_fneg				#	bl	lib_fneg
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
read_light.2594:
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
	jal	rad.2590				#	bl	rad.2590
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_sin				#	bl	lib_sin
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	rad.2590				#	bl	rad.2590
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
	jal	lib_cos				#	bl	lib_cos
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
	jal	lib_sin				#	bl	lib_sin
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
	jal	lib_cos				#	bl	lib_cos
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
rotate_quadratic_matrix.2596:
	flw	f1, 0(r2)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_cos				#	bl	lib_cos
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
	jal	lib_sin				#	bl	lib_sin
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
	jal	lib_cos				#	bl	lib_cos
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
	jal	lib_sin				#	bl	lib_sin
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
	jal	lib_cos				#	bl	lib_cos
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
	jal	lib_sin				#	bl	lib_sin
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
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f1, r30
	fmul	f3, f4, f3
	fmul	f4, f6, f7
	fadd	f3, f3, f4
	fmul	f2, f2, f9
	fadd	f2, f3, f2
	fmul	f1, f1, f2
	fsw	r30, 2(r1)
	jr	r31				#	blr
read_nth_object.2599:
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
	beqi	r1, -1, beq_then.8162
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 2				# li	r2, 2
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	beqi	r2, 0, beq_then.8163
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
	jal	rad.2590				#	bl	rad.2590
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
	jal	rad.2590				#	bl	rad.2590
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
	jal	rad.2590				#	bl	rad.2590
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	fsw	r30, 2(r1)
	j	beq_cont.8164
beq_then.8163:
beq_cont.8164:
	lw	r2, 3(r3)
	beqi	r2, 2, beq_then.8165
	lw	r5, 8(r3)
	j	beq_cont.8166
beq_then.8165:
	addi	r5, r0, 1				# li	r5, 1
beq_cont.8166:
	addi	r6, r0, 4				# li	r6, 4
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	beqi	r7, 3, beq_then.8167
	beqi	r7, 2, beq_then.8169
	j	beq_cont.8170
beq_then.8169:
	lw	r2, 8(r3)
	beqi	r2, 0, beq_then.8171
	addi	r2, r0, 0				# li	r2, 0
	j	beq_cont.8172
beq_then.8171:
	addi	r2, r0, 1				# li	r2, 1
beq_cont.8172:
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	vecunit_sgn.2491				#	bl	vecunit_sgn.2491
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.8170:
	j	beq_cont.8168
beq_then.8167:
	flw	f1, 0(r5)
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8174
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.8175
beq_then.8174:
	lw	r30, 14(r3)				#lfd	f1, 14(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	sgn.2465				#	bl	sgn.2465
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
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
beq_cont.8175:
	lw	r1, 6(r3)
	fsw	r30, 0(r1)
	flw	f1, 1(r1)
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8176
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.8177
beq_then.8176:
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	sgn.2465				#	bl	sgn.2465
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
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
beq_cont.8177:
	lw	r1, 6(r3)
	fsw	r30, 1(r1)
	flw	f1, 2(r1)
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8178
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.8179
beq_then.8178:
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	sgn.2465				#	bl	sgn.2465
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
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
beq_cont.8179:
	lw	r1, 6(r3)
	fsw	r30, 2(r1)
beq_cont.8168:
	lw	r1, 5(r3)
	beqi	r1, 0, beq_then.8180
	lw	r1, 6(r3)
	lw	r2, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	rotate_quadratic_matrix.2596				#	bl	rotate_quadratic_matrix.2596
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.8181
beq_then.8180:
beq_cont.8181:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.8162:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
read_object.2601:
	lw	r2, 2(29)
	lw	r5, 1(29)
	addi	r6, r0, 60				# li	r6, 60
	ble	r6, r1, ble_then.8182
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
	beqi	r1, 0, beq_then.8183
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8183:
	lw	r1, 1(r3)
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	jr	r31				#	blr
ble_then.8182:
	jr	r31				#	blr
read_all_object.2603:
	lw	29, 1(29)
	addi	r1, r0, 0				# li	r1, 0
	lw	r28, 0(29)
	jr	r28
read_net_item.2605:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, -1, beq_then.8186
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#	blr
beq_then.8186:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1				# li	r2, -1
	j	lib_create_array
read_or_network.2607:
	addi	r2, r0, 0				# li	r2, 0
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r2)
	beqi	r1, -1, beq_then.8187
	lw	r1, 0(r3)
	addi	r5, r1, 1
	sw	r2, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	read_or_network.2607				#	bl	read_or_network.2607
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#	blr
beq_then.8187:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.2609:
	lw	r2, 1(29)
	addi	r5, r0, 0				# li	r5, 0
	sw	29, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r1)
	beqi	r2, -1, beq_then.8188
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8188:
	jr	r31				#	blr
read_parameter.2611:
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
	jal	read_or_network.2607				#	bl	read_or_network.2607
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#	blr
solver_rect_surface.2613:
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
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8194
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8194:
	lw	r1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	o_param_abc.2535				#	bl	o_param_abc.2535
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 14(r3)
	sw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	o_isinvert.2525				#	bl	o_isinvert.2525
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
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	xor.2462				#	bl	xor.2462
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
	jal	fneg_cond.2467				#	bl	fneg_cond.2467
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
	jal	lib_fabs				#	bl	lib_fabs
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
	beqi	r1, 0, beq_then.8196
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
	jal	lib_fabs				#	bl	lib_fabs
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
	beqi	r1, 0, beq_then.8197
	lw	r1, 0(r3)
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	fsw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.8197:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8196:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_rect.2622:
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
	beqi	r1, 0, beq_then.8198
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.8198:
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
	beqi	r1, 0, beq_then.8199
	addi	r1, r0, 2				# li	r1, 2
	jr	r31				#	blr
beq_then.8199:
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
	beqi	r1, 0, beq_then.8200
	addi	r1, r0, 3				# li	r1, 3
	jr	r31				#	blr
beq_then.8200:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_surface.2628:
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
	jal	o_param_abc.2535				#	bl	o_param_abc.2535
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	sw	r2, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	veciprod.2494				#	bl	veciprod.2494
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8202
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
	jal	veciprod2.2497				#	bl	veciprod2.2497
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_fneg				#	bl	lib_fneg
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
beq_then.8202:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
quadratic.2634:
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
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	o_param_a.2529				#	bl	o_param_a.2529
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
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	o_param_b.2531				#	bl	o_param_b.2531
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
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	o_param_c.2533				#	bl	o_param_c.2533
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
	jal	o_isrot.2527				#	bl	o_isrot.2527
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8204
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
	jal	o_param_r1.2553				#	bl	o_param_r1.2553
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
	jal	o_param_r2.2555				#	bl	o_param_r2.2555
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
	jal	o_param_r3.2557				#	bl	o_param_r3.2557
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
beq_then.8204:
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	jr	r31				#	blr
bilinear.2639:
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
	jal	o_param_a.2529				#	bl	o_param_a.2529
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
	jal	o_param_b.2531				#	bl	o_param_b.2531
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
	jal	o_param_c.2533				#	bl	o_param_c.2533
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
	jal	o_isrot.2527				#	bl	o_isrot.2527
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8206
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
	jal	o_param_r1.2553				#	bl	o_param_r1.2553
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
	jal	o_param_r2.2555				#	bl	o_param_r2.2555
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
	jal	o_param_r3.2557				#	bl	o_param_r3.2557
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
	jal	lib_fhalf				#	bl	lib_fhalf
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	jr	r31				#	blr
beq_then.8206:
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	jr	r31				#	blr
solver_second.2647:
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
	jal	quadratic.2634				#	bl	quadratic.2634
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8208
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8208:
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
	jal	bilinear.2639				#	bl	bilinear.2639
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
	jal	quadratic.2634				#	bl	quadratic.2634
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	o_form.2521				#	bl	o_form.2521
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 3, beq_then.8209
	lw	r30, 14(r3)				#lfd	f1, 14(r3)
	fmvfr	f1, r30
	j	beq_cont.8210
beq_then.8209:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
beq_cont.8210:
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8211
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
	jal	o_isinvert.2525				#	bl	o_isinvert.2525
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8212
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	j	beq_cont.8213
beq_then.8212:
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.8213:
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
beq_then.8211:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver.2653:
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
	jal	o_param_x.2537				#	bl	o_param_x.2537
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
	jal	o_param_y.2539				#	bl	o_param_y.2539
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
	jal	o_param_z.2541				#	bl	o_param_z.2541
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
	jal	o_form.2521				#	bl	o_form.2521
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 1, beq_then.8214
	beqi	r1, 2, beq_then.8215
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
beq_then.8215:
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
beq_then.8214:
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
solver_rect_fast.2657:
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
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	o_param_b.2531				#	bl	o_param_b.2531
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
	beqi	r1, 0, beq_then.8218
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
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	o_param_c.2533				#	bl	o_param_c.2533
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
	beqi	r1, 0, beq_then.8220
	lw	r1, 6(r3)
	flw	f1, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8222
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.8223
beq_then.8222:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.8223:
	j	beq_cont.8221
beq_then.8220:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.8221:
	j	beq_cont.8219
beq_then.8218:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.8219:
	beqi	r1, 0, beq_then.8224
	lw	r1, 0(r3)
	lw	r30, 10(r3)				#lfd	f1, 10(r3)
	fmvfr	f1, r30
	fsw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.8224:
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
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	o_param_a.2529				#	bl	o_param_a.2529
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
	beqi	r1, 0, beq_then.8225
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
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	o_param_c.2533				#	bl	o_param_c.2533
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
	beqi	r1, 0, beq_then.8227
	lw	r1, 6(r3)
	flw	f1, 3(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8229
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.8230
beq_then.8229:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.8230:
	j	beq_cont.8228
beq_then.8227:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.8228:
	j	beq_cont.8226
beq_then.8225:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.8226:
	beqi	r1, 0, beq_then.8231
	lw	r1, 0(r3)
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	fsw	r30, 0(r1)
	addi	r1, r0, 2				# li	r1, 2
	jr	r31				#	blr
beq_then.8231:
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
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	fmvtr	r30, f1
	sw	r30, 26(r3)				#stfd	f1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	o_param_a.2529				#	bl	o_param_a.2529
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
	beqi	r1, 0, beq_then.8232
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
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	o_param_b.2531				#	bl	o_param_b.2531
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
	beqi	r1, 0, beq_then.8234
	lw	r1, 6(r3)
	flw	f1, 5(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8236
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.8237
beq_then.8236:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.8237:
	j	beq_cont.8235
beq_then.8234:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.8235:
	j	beq_cont.8233
beq_then.8232:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.8233:
	beqi	r1, 0, beq_then.8238
	lw	r1, 0(r3)
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	fsw	r30, 0(r1)
	addi	r1, r0, 3				# li	r1, 3
	jr	r31				#	blr
beq_then.8238:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_surface_fast.2664:
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
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8240
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
beq_then.8240:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_second_fast.2670:
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
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8243
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8243:
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
	jal	quadratic.2634				#	bl	quadratic.2634
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	o_form.2521				#	bl	o_form.2521
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 3, beq_then.8245
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	j	beq_cont.8246
beq_then.8245:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
beq_cont.8246:
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8247
	lw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	o_isinvert.2525				#	bl	o_isinvert.2525
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8248
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
	j	beq_cont.8249
beq_then.8248:
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
beq_cont.8249:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.8247:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_fast.2676:
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
	jal	o_param_x.2537				#	bl	o_param_x.2537
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
	jal	o_param_y.2539				#	bl	o_param_y.2539
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
	jal	o_param_z.2541				#	bl	o_param_z.2541
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
	jal	d_const.2582				#	bl	d_const.2582
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
	jal	o_form.2521				#	bl	o_form.2521
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 1, beq_then.8251
	beqi	r1, 2, beq_then.8252
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
beq_then.8252:
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
beq_then.8251:
	lw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	d_vec.2580				#	bl	d_vec.2580
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
solver_surface_fast2.2680:
	lw	r1, 1(29)
	flw	f1, 0(r2)
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8253
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r1, 1(r3)
	flw	f2, 3(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.8253:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_second_fast2.2687:
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
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8255
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8255:
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8257
	lw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	o_isinvert.2525				#	bl	o_isinvert.2525
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8258
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
	j	beq_cont.8259
beq_then.8258:
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
beq_cont.8259:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.8257:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_fast2.2694:
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
	jal	o_param_ctbl.2559				#	bl	o_param_ctbl.2559
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
	jal	d_const.2582				#	bl	d_const.2582
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
	jal	o_form.2521				#	bl	o_form.2521
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 1, beq_then.8261
	beqi	r1, 2, beq_then.8262
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
beq_then.8262:
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
beq_then.8261:
	lw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	d_vec.2580				#	bl	d_vec.2580
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
setup_rect_table.2697:
	addi	r5, r0, 6				# li	r5, 6
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8263
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 2(r3)
	fsw	r30, 1(r1)
	j	beq_cont.8264
beq_then.8263:
	lw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	o_isinvert.2525				#	bl	o_isinvert.2525
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	flw	f1, 0(r2)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	xor.2462				#	bl	xor.2462
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	o_param_a.2529				#	bl	o_param_a.2529
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	fneg_cond.2467				#	bl	fneg_cond.2467
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	fsw	r30, 0(r1)
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r2, 1(r3)
	flw	f2, 0(r2)
	fdiv	f1, f1, f2
	fsw	r30, 1(r1)
beq_cont.8264:
	lw	r2, 1(r3)
	flw	f1, 1(r2)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8265
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 2(r3)
	fsw	r30, 3(r1)
	j	beq_cont.8266
beq_then.8265:
	lw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	o_isinvert.2525				#	bl	o_isinvert.2525
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	flw	f1, 1(r2)
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	xor.2462				#	bl	xor.2462
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	o_param_b.2531				#	bl	o_param_b.2531
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	fneg_cond.2467				#	bl	fneg_cond.2467
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	fsw	r30, 2(r1)
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r2, 1(r3)
	flw	f2, 1(r2)
	fdiv	f1, f1, f2
	fsw	r30, 3(r1)
beq_cont.8266:
	lw	r2, 1(r3)
	flw	f1, 2(r2)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8267
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 2(r3)
	fsw	r30, 5(r1)
	j	beq_cont.8268
beq_then.8267:
	lw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	o_isinvert.2525				#	bl	o_isinvert.2525
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	flw	f1, 2(r2)
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	xor.2462				#	bl	xor.2462
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	o_param_c.2533				#	bl	o_param_c.2533
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	fneg_cond.2467				#	bl	fneg_cond.2467
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	fsw	r30, 4(r1)
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r2, 1(r3)
	flw	f2, 2(r2)
	fdiv	f1, f1, f2
	fsw	r30, 5(r1)
beq_cont.8268:
	jr	r31				#	blr
setup_surface_table.2700:
	addi	r5, r0, 4				# li	r5, 4
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	jal	o_param_a.2529				#	bl	o_param_a.2529
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
	jal	o_param_b.2531				#	bl	o_param_b.2531
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
	jal	o_param_c.2533				#	bl	o_param_c.2533
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
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8270
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
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
	jal	o_param_a.2529				#	bl	o_param_a.2529
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	o_param_b.2531				#	bl	o_param_b.2531
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	o_param_c.2533				#	bl	o_param_c.2533
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	fsw	r30, 3(r1)
	j	beq_cont.8271
beq_then.8270:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 2(r3)
	fsw	r30, 0(r1)
beq_cont.8271:
	jr	r31				#	blr
setup_second_table.2703:
	addi	r5, r0, 5				# li	r5, 5
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	jal	quadratic.2634				#	bl	quadratic.2634
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
	jal	o_param_a.2529				#	bl	o_param_a.2529
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	o_param_b.2531				#	bl	o_param_b.2531
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	o_param_c.2533				#	bl	o_param_c.2533
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	o_isrot.2527				#	bl	o_isrot.2527
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8273
	lw	r1, 1(r3)
	flw	f1, 2(r1)
	lw	r2, 0(r3)
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	o_param_r2.2555				#	bl	o_param_r2.2555
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
	jal	o_param_r3.2557				#	bl	o_param_r3.2557
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
	jal	lib_fhalf				#	bl	lib_fhalf
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
	jal	o_param_r1.2553				#	bl	o_param_r1.2553
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
	jal	o_param_r3.2557				#	bl	o_param_r3.2557
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
	jal	lib_fhalf				#	bl	lib_fhalf
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
	jal	o_param_r1.2553				#	bl	o_param_r1.2553
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
	jal	o_param_r2.2555				#	bl	o_param_r2.2555
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
	jal	lib_fhalf				#	bl	lib_fhalf
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 2(r3)
	fsw	r30, 3(r1)
	j	beq_cont.8274
beq_then.8273:
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
beq_cont.8274:
	lw	r30, 4(r3)				#lfd	f1, 4(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8275
	j	beq_cont.8276
beq_then.8275:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 2(r3)
	fsw	r30, 4(r1)
beq_cont.8276:
	lw	r1, 2(r3)
	jr	r31				#	blr
iter_setup_dirvec_constants.2706:
	lw	r5, 1(29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.8277
	jr	r31				#	blr
ble_then.8277:
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	29, 0(r3)
	sw	r2, 1(r3)
	sw	r5, 2(r3)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	d_const.2582				#	bl	d_const.2582
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	d_vec.2580				#	bl	d_vec.2580
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	o_form.2521				#	bl	o_form.2521
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 1, beq_then.8279
	beqi	r1, 2, beq_then.8281
	lw	r1, 5(r3)
	lw	r2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	setup_second_table.2703				#	bl	setup_second_table.2703
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.8282
beq_then.8281:
	lw	r1, 5(r3)
	lw	r2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	setup_surface_table.2700				#	bl	setup_surface_table.2700
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.8282:
	j	beq_cont.8280
beq_then.8279:
	lw	r1, 5(r3)
	lw	r2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	setup_rect_table.2697				#	bl	setup_rect_table.2697
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.8280:
	addi	r2, r2, -1
	lw	r1, 3(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
setup_dirvec_constants.2709:
	lw	r2, 2(29)
	lw	29, 1(29)
	lw	r2, 0(r2)
	addi	r2, r2, -1
	lw	r28, 0(29)
	jr	r28
setup_startp_constants.2711:
	lw	r5, 1(29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.8283
	jr	r31				#	blr
ble_then.8283:
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
	jal	o_param_ctbl.2559				#	bl	o_param_ctbl.2559
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	o_form.2521				#	bl	o_form.2521
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
	jal	o_param_x.2537				#	bl	o_param_x.2537
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
	jal	o_param_y.2539				#	bl	o_param_y.2539
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
	jal	o_param_z.2541				#	bl	o_param_z.2541
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 4(r3)
	fsw	r30, 2(r1)
	lw	r2, 5(r3)
	beqi	r2, 2, beq_then.8285
	blei	r2, 2, ble_then.8287
	flw	f1, 0(r1)
	flw	f2, 1(r1)
	flw	f3, 2(r1)
	lw	r5, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	quadratic.2634				#	bl	quadratic.2634
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	beqi	r1, 3, beq_then.8289
	j	beq_cont.8290
beq_then.8289:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.8290:
	lw	r1, 4(r3)
	fsw	r30, 3(r1)
	j	ble_cont.8288
ble_then.8287:
ble_cont.8288:
	j	beq_cont.8286
beq_then.8285:
	lw	r2, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	o_param_abc.2535				#	bl	o_param_abc.2535
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
	jal	veciprod2.2497				#	bl	veciprod2.2497
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fsw	r30, 3(r1)
beq_cont.8286:
	lw	r1, 1(r3)
	addi	r2, r1, -1
	lw	r1, 2(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
setup_startp.2714:
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
	jal	veccpy.2483				#	bl	veccpy.2483
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
is_rect_outside.2716:
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	o_param_a.2529				#	bl	o_param_a.2529
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
	beqi	r1, 0, beq_then.8292
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	o_param_b.2531				#	bl	o_param_b.2531
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
	beqi	r1, 0, beq_then.8294
	lw	r30, 0(r3)				#lfd	f1, 0(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	o_param_c.2533				#	bl	o_param_c.2533
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
	j	beq_cont.8295
beq_then.8294:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.8295:
	j	beq_cont.8293
beq_then.8292:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.8293:
	beqi	r1, 0, beq_then.8296
	lw	r1, 4(r3)
	j	o_isinvert.2525
beq_then.8296:
	lw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	o_isinvert.2525				#	bl	o_isinvert.2525
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8297
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8297:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
is_plane_outside.2721:
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
	jal	o_param_abc.2535				#	bl	o_param_abc.2535
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
	jal	veciprod2.2497				#	bl	veciprod2.2497
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	o_isinvert.2525				#	bl	o_isinvert.2525
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	sw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	xor.2462				#	bl	xor.2462
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8299
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8299:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
is_second_outside.2726:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.2634				#	bl	quadratic.2634
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	o_form.2521				#	bl	o_form.2521
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 3, beq_then.8301
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	j	beq_cont.8302
beq_then.8301:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
beq_cont.8302:
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	o_isinvert.2525				#	bl	o_isinvert.2525
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f1, 4(r3)
	fmvfr	f1, r30
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	xor.2462				#	bl	xor.2462
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8303
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8303:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
is_outside.2731:
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
	jal	o_param_x.2537				#	bl	o_param_x.2537
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
	jal	o_param_y.2539				#	bl	o_param_y.2539
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
	jal	o_param_z.2541				#	bl	o_param_z.2541
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
	jal	o_form.2521				#	bl	o_form.2521
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 1, beq_then.8305
	beqi	r1, 2, beq_then.8306
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 12(r3)				#lfd	f3, 12(r3)
	fmvfr	f3, r30
	lw	r1, 4(r3)
	j	is_second_outside.2726
beq_then.8306:
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 12(r3)				#lfd	f3, 12(r3)
	fmvfr	f3, r30
	lw	r1, 4(r3)
	j	is_plane_outside.2721
beq_then.8305:
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 12(r3)				#lfd	f3, 12(r3)
	fmvfr	f3, r30
	lw	r1, 4(r3)
	j	is_rect_outside.2716
check_all_inside.2736:
	lw	r5, 1(29)
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	r6, -1, beq_then.8307
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
	jal	is_outside.2731				#	bl	is_outside.2731
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8308
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8308:
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
beq_then.8307:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
shadow_check_and_group.2742:
	lw	r5, 7(29)
	lw	r6, 6(29)
	lw	r7, 5(29)
	lw	r8, 4(29)
	lw	r9, 3(29)
	lw	r10, 2(29)
	lw	r11, 1(29)
	add	r30, r2, r1
	lw	r12, 0(r30)
	beqi	r12, -1, beq_then.8309
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
	beqi	r1, 0, beq_then.8311
	addi	r30, r0, 52429
	lui	r30, r30, 48716	# to load float		-0.200000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.8312
beq_then.8311:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.8312:
	beqi	r1, 0, beq_then.8313
	addi	r30, r0, 55050
	lui	r30, r30, 15395	# to load float		0.010000
	fmvfr	f1, r30
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
	beqi	r1, 0, beq_then.8314
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.8314:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	29, 4(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8313:
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	o_isinvert.2525				#	bl	o_isinvert.2525
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8315
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	29, 4(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8315:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8309:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
shadow_check_one_or_group.2745:
	lw	r5, 2(29)
	lw	r6, 1(29)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	r7, -1, beq_then.8316
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
	beqi	r1, 0, beq_then.8317
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.8317:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	lw	29, 1(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8316:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
shadow_check_one_or_matrix.2748:
	lw	r5, 5(29)
	lw	r6, 4(29)
	lw	r7, 3(29)
	lw	r8, 2(29)
	lw	r9, 1(29)
	add	r30, r2, r1
	lw	r10, 0(r30)
	lw	r11, 0(r10)
	beqi	r11, -1, beq_then.8318
	addi	r12, r0, 99				# li	r12, 99
	sw	r10, 0(r3)
	sw	r7, 1(r3)
	sw	r2, 2(r3)
	sw	29, 3(r3)
	sw	r1, 4(r3)
	beq	r11, r12, beq_then.8319
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
	beqi	r1, 0, beq_then.8321
	lw	r1, 5(r3)
	flw	f1, 0(r1)
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8323
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
	beqi	r1, 0, beq_then.8325
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.8326
beq_then.8325:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.8326:
	j	beq_cont.8324
beq_then.8323:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.8324:
	j	beq_cont.8322
beq_then.8321:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.8322:
	j	beq_cont.8320
beq_then.8319:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.8320:
	beqi	r1, 0, beq_then.8327
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
	beqi	r1, 0, beq_then.8328
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.8328:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	29, 3(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8327:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	29, 3(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8318:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solve_each_element.2751:
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
	beqi	r15, -1, beq_then.8329
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
	beqi	r1, 0, beq_then.8330
	lw	r2, 6(r3)
	flw	f2, 0(r2)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	beqi	r1, 0, beq_then.8331
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
	beqi	r1, 0, beq_then.8333
	addi	r30, r0, 55050
	lui	r30, r30, 15395	# to load float		0.010000
	fmvfr	f1, r30
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
	beqi	r1, 0, beq_then.8335
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
	jal	vecset.2473				#	bl	vecset.2473
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	lw	r2, 11(r3)
	sw	r2, 0(r1)
	lw	r1, 0(r3)
	lw	r2, 13(r3)
	sw	r2, 0(r1)
	j	beq_cont.8336
beq_then.8335:
beq_cont.8336:
	j	beq_cont.8334
beq_then.8333:
beq_cont.8334:
	j	beq_cont.8332
beq_then.8331:
beq_cont.8332:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	29, 9(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8330:
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	o_isinvert.2525				#	bl	o_isinvert.2525
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8337
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	29, 9(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8337:
	jr	r31				#	blr
beq_then.8329:
	jr	r31				#	blr
solve_one_or_network.2755:
	lw	r6, 2(29)
	lw	r7, 1(29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	r8, -1, beq_then.8340
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
beq_then.8340:
	jr	r31				#	blr
trace_or_matrix.2759:
	lw	r6, 5(29)
	lw	r7, 4(29)
	lw	r8, 3(29)
	lw	r9, 2(29)
	lw	r10, 1(29)
	add	r30, r2, r1
	lw	r11, 0(r30)
	lw	r12, 0(r11)
	beqi	r12, -1, beq_then.8342
	addi	r13, r0, 99				# li	r13, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	29, 2(r3)
	sw	r1, 3(r3)
	beq	r12, r13, beq_then.8343
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
	beqi	r1, 0, beq_then.8345
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
	beqi	r1, 0, beq_then.8347
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
	j	beq_cont.8348
beq_then.8347:
beq_cont.8348:
	j	beq_cont.8346
beq_then.8345:
beq_cont.8346:
	j	beq_cont.8344
beq_then.8343:
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
beq_cont.8344:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	29, 2(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8342:
	jr	r31				#	blr
judge_intersection.2763:
	lw	r2, 3(29)
	lw	r5, 2(29)
	lw	r6, 1(29)
	addi	r30, r0, 27432
	lui	r30, r30, 20078	# to load float		1000000000.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f1, r30
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8351
	addi	r30, r0, 48160
	lui	r30, r30, 19646	# to load float		100000000.000000
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	j	lib_fless
beq_then.8351:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solve_each_element_fast.2765:
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
	jal	d_vec.2580				#	bl	d_vec.2580
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	lw	r6, 0(r30)
	beqi	r6, -1, beq_then.8352
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
	beqi	r1, 0, beq_then.8353
	lw	r2, 6(r3)
	flw	f2, 0(r2)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	beqi	r1, 0, beq_then.8354
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
	beqi	r1, 0, beq_then.8356
	addi	r30, r0, 55050
	lui	r30, r30, 15395	# to load float		0.010000
	fmvfr	f1, r30
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
	beqi	r1, 0, beq_then.8358
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
	jal	vecset.2473				#	bl	vecset.2473
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	lw	r2, 14(r3)
	sw	r2, 0(r1)
	lw	r1, 0(r3)
	lw	r2, 15(r3)
	sw	r2, 0(r1)
	j	beq_cont.8359
beq_then.8358:
beq_cont.8359:
	j	beq_cont.8357
beq_then.8356:
beq_cont.8357:
	j	beq_cont.8355
beq_then.8354:
beq_cont.8355:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 12(r3)
	lw	r5, 9(r3)
	lw	29, 7(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8353:
	lw	r1, 14(r3)
	lw	r2, 8(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	o_isinvert.2525				#	bl	o_isinvert.2525
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8360
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 12(r3)
	lw	r5, 9(r3)
	lw	29, 7(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8360:
	jr	r31				#	blr
beq_then.8352:
	jr	r31				#	blr
solve_one_or_network_fast.2769:
	lw	r6, 2(29)
	lw	r7, 1(29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	r8, -1, beq_then.8363
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
beq_then.8363:
	jr	r31				#	blr
trace_or_matrix_fast.2773:
	lw	r6, 4(29)
	lw	r7, 3(29)
	lw	r8, 2(29)
	lw	r9, 1(29)
	add	r30, r2, r1
	lw	r10, 0(r30)
	lw	r11, 0(r10)
	beqi	r11, -1, beq_then.8365
	addi	r12, r0, 99				# li	r12, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	29, 2(r3)
	sw	r1, 3(r3)
	beq	r11, r12, beq_then.8366
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
	beqi	r1, 0, beq_then.8368
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
	beqi	r1, 0, beq_then.8370
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
	j	beq_cont.8371
beq_then.8370:
beq_cont.8371:
	j	beq_cont.8369
beq_then.8368:
beq_cont.8369:
	j	beq_cont.8367
beq_then.8366:
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
beq_cont.8367:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	29, 2(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8365:
	jr	r31				#	blr
judge_intersection_fast.2777:
	lw	r2, 3(29)
	lw	r5, 2(29)
	lw	r6, 1(29)
	addi	r30, r0, 27432
	lui	r30, r30, 20078	# to load float		1000000000.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f1, r30
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8374
	addi	r30, r0, 48160
	lui	r30, r30, 19646	# to load float		100000000.000000
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	j	lib_fless
beq_then.8374:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
get_nvector_rect.2779:
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
	jal	vecbzero.2481				#	bl	vecbzero.2481
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
	jal	sgn.2465				#	bl	sgn.2465
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	lw	r2, 0(r3)
	add	r30, r2, r1
	sw	f1, 0(r30)
	jr	r31				#	blr
get_nvector_plane.2781:
	lw	r2, 1(29)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	o_param_a.2529				#	bl	o_param_a.2529
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	o_param_b.2531				#	bl	o_param_b.2531
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	o_param_c.2533				#	bl	o_param_c.2533
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	fsw	r30, 2(r1)
	jr	r31				#	blr
get_nvector_second.2783:
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
	jal	o_param_x.2537				#	bl	o_param_x.2537
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
	jal	o_param_y.2539				#	bl	o_param_y.2539
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
	jal	o_param_z.2541				#	bl	o_param_z.2541
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
	jal	o_param_a.2529				#	bl	o_param_a.2529
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
	jal	o_param_b.2531				#	bl	o_param_b.2531
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
	jal	o_param_c.2533				#	bl	o_param_c.2533
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
	jal	o_isrot.2527				#	bl	o_isrot.2527
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8378
	lw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	o_param_r3.2557				#	bl	o_param_r3.2557
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
	jal	o_param_r2.2555				#	bl	o_param_r2.2555
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
	jal	lib_fhalf				#	bl	lib_fhalf
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
	jal	o_param_r3.2557				#	bl	o_param_r3.2557
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
	jal	o_param_r1.2553				#	bl	o_param_r1.2553
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
	jal	lib_fhalf				#	bl	lib_fhalf
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
	jal	o_param_r2.2555				#	bl	o_param_r2.2555
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
	jal	o_param_r1.2553				#	bl	o_param_r1.2553
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
	jal	lib_fhalf				#	bl	lib_fhalf
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 0(r3)
	fsw	r30, 2(r1)
	j	beq_cont.8379
beq_then.8378:
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
beq_cont.8379:
	lw	r2, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	o_isinvert.2525				#	bl	o_isinvert.2525
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	j	vecunit_sgn.2491
get_nvector.2785:
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
	jal	o_form.2521				#	bl	o_form.2521
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 1, beq_then.8380
	beqi	r1, 2, beq_then.8381
	lw	r1, 1(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8381:
	lw	r1, 1(r3)
	lw	29, 2(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8380:
	lw	r1, 3(r3)
	lw	29, 4(r3)
	lw	r28, 0(29)
	jr	r28
utexture.2788:
	lw	r5, 1(29)
	sw	r2, 0(r3)
	sw	r5, 1(r3)
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	o_texturetype.2519				#	bl	o_texturetype.2519
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	o_color_red.2547				#	bl	o_color_red.2547
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
	jal	o_color_green.2549				#	bl	o_color_green.2549
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
	jal	o_color_blue.2551				#	bl	o_color_blue.2551
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	fsw	r30, 2(r1)
	lw	r2, 3(r3)
	beqi	r2, 1, beq_then.8382
	beqi	r2, 2, beq_then.8383
	beqi	r2, 3, beq_then.8384
	beqi	r2, 4, beq_then.8385
	jr	r31				#	blr
beq_then.8385:
	lw	r2, 0(r3)
	flw	f1, 0(r2)
	lw	r5, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	o_param_x.2537				#	bl	o_param_x.2537
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
	jal	o_param_a.2529				#	bl	o_param_a.2529
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
	jal	o_param_z.2541				#	bl	o_param_z.2541
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
	jal	o_param_c.2533				#	bl	o_param_c.2533
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 46871
	lui	r30, r30, 14545	# to load float		0.000100
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8387
	addi	r30, r0, 0
	lui	r30, r30, 16752	# to load float		15.000000
	fmvfr	f1, r30
	j	beq_cont.8388
beq_then.8387:
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_atan				#	bl	lib_atan
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 16880	# to load float		30.000000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	addi	r30, r0, 4059
	lui	r30, r30, 16457	# to load float		3.141593
	fmvfr	f2, r30
	fdiv	f1, f1, f2
beq_cont.8388:
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_floor				#	bl	lib_floor
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
	jal	o_param_y.2539				#	bl	o_param_y.2539
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
	jal	o_param_b.2531				#	bl	o_param_b.2531
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
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 46871
	lui	r30, r30, 14545	# to load float		0.000100
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8389
	addi	r30, r0, 0
	lui	r30, r30, 16752	# to load float		15.000000
	fmvfr	f1, r30
	j	beq_cont.8390
beq_then.8389:
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_atan				#	bl	lib_atan
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 16880	# to load float		30.000000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	addi	r30, r0, 4059
	lui	r30, r30, 16457	# to load float		3.141593
	fmvfr	f2, r30
	fdiv	f1, f1, f2
beq_cont.8390:
	fmvtr	r30, f1
	sw	r30, 30(r3)				#stfd	f1, 30(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	lib_floor				#	bl	lib_floor
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r0, 39322
	lui	r30, r30, 15897	# to load float		0.150000
	fmvfr	f2, r30
	addi	r30, r0, 0
	lui	r30, r30, 16128	# to load float		0.500000
	fmvfr	f3, r30
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
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16128	# to load float		0.500000
	fmvfr	f2, r30
	lw	r30, 32(r3)				#lfd	f3, 32(r3)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	fmvtr	r30, f1
	sw	r30, 36(r3)				#stfd	f1, 36(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8391
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.8392
beq_then.8391:
	lw	r30, 38(r3)				#lfd	f1, 38(r3)
	fmvfr	f1, r30
beq_cont.8392:
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f2, r30
	fmul	f1, f2, f1
	addi	r30, r0, 39322
	lui	r30, r30, 16025	# to load float		0.300000
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 1(r3)
	fsw	r30, 2(r1)
	jr	r31				#	blr
beq_then.8384:
	lw	r2, 0(r3)
	flw	f1, 0(r2)
	lw	r5, 2(r3)
	fmvtr	r30, f1
	sw	r30, 40(r3)				#stfd	f1, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	o_param_x.2537				#	bl	o_param_x.2537
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
	jal	o_param_z.2541				#	bl	o_param_z.2541
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	addi	r30, r0, 0
	lui	r30, r30, 16672	# to load float		10.000000
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 50(r3)				#stfd	f1, 50(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	lib_floor				#	bl	lib_floor
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 50(r3)				#lfd	f2, 50(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r0, 4059
	lui	r30, r30, 16457	# to load float		3.141593
	fmvfr	f2, r30
	fmul	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	lib_cos				#	bl	lib_cos
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r1, 1(r3)
	fsw	r30, 1(r1)
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	fsw	r30, 2(r1)
	jr	r31				#	blr
beq_then.8383:
	lw	r2, 0(r3)
	flw	f1, 1(r2)
	addi	r30, r0, 0
	lui	r30, r30, 16000	# to load float		0.250000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	lib_sin				#	bl	lib_sin
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f2, r30
	fmul	f2, f2, f1
	lw	r1, 1(r3)
	fsw	r30, 0(r1)
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f2, r30
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f3, r30
	fsub	f1, f3, f1
	fmul	f1, f2, f1
	fsw	r30, 1(r1)
	jr	r31				#	blr
beq_then.8382:
	lw	r2, 0(r3)
	flw	f1, 0(r2)
	lw	r5, 2(r3)
	fmvtr	r30, f1
	sw	r30, 52(r3)				#stfd	f1, 52(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 54(r3)
	addi	r3, r3, 55
	jal	o_param_x.2537				#	bl	o_param_x.2537
	addi	r3, r3, -55
	lw	r30, 54(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 52(r3)				#lfd	f2, 52(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r0, 52429
	lui	r30, r30, 15692	# to load float		0.050000
	fmvfr	f2, r30
	fmul	f2, f1, f2
	fmvtr	r30, f1
	sw	r30, 54(r3)				#stfd	f1, 54(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 56(r3)
	addi	r3, r3, 57
	jal	lib_floor				#	bl	lib_floor
	addi	r3, r3, -57
	lw	r30, 56(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 16800	# to load float		20.000000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 54(r3)				#lfd	f2, 54(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16672	# to load float		10.000000
	fmvfr	f2, r30
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
	jal	o_param_z.2541				#	bl	o_param_z.2541
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 58(r3)				#lfd	f2, 58(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r0, 52429
	lui	r30, r30, 15692	# to load float		0.050000
	fmvfr	f2, r30
	fmul	f2, f1, f2
	fmvtr	r30, f1
	sw	r30, 60(r3)				#stfd	f1, 60(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 62(r3)
	addi	r3, r3, 63
	jal	lib_floor				#	bl	lib_floor
	addi	r3, r3, -63
	lw	r30, 62(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 16800	# to load float		20.000000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 60(r3)				#lfd	f2, 60(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16672	# to load float		10.000000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 62(r3)
	addi	r3, r3, 63
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -63
	lw	r30, 62(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 56(r3)
	beqi	r2, 0, beq_then.8397
	beqi	r1, 0, beq_then.8399
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f1, r30
	j	beq_cont.8400
beq_then.8399:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
beq_cont.8400:
	j	beq_cont.8398
beq_then.8397:
	beqi	r1, 0, beq_then.8401
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.8402
beq_then.8401:
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f1, r30
beq_cont.8402:
beq_cont.8398:
	lw	r1, 1(r3)
	fsw	r30, 1(r1)
	jr	r31				#	blr
add_light.2791:
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
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8404
	lw	r30, 4(r3)				#lfd	f1, 4(r3)
	fmvfr	f1, r30
	lw	r1, 7(r3)
	lw	r2, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	vecaccum.2502				#	bl	vecaccum.2502
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.8405
beq_then.8404:
beq_cont.8405:
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8406
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_fsqr				#	bl	lib_fsqr
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
beq_then.8406:
	jr	r31				#	blr
trace_reflections.2795:
	lw	r5, 8(29)
	lw	r6, 7(29)
	lw	r7, 6(29)
	lw	r8, 5(29)
	lw	r9, 4(29)
	lw	r10, 3(29)
	lw	r11, 2(29)
	lw	r12, 1(29)
	addi	r13, r0, 0				# li	r13, 0
	ble	r13, r1, ble_then.8409
	jr	r31				#	blr
ble_then.8409:
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
	jal	r_dvec.2586				#	bl	r_dvec.2586
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
	beqi	r1, 0, beq_then.8411
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
	jal	r_surface_id.2584				#	bl	r_surface_id.2584
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 16(r3)
	beq	r2, r1, beq_then.8413
	j	beq_cont.8414
beq_then.8413:
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
	beqi	r1, 0, beq_then.8415
	j	beq_cont.8416
beq_then.8415:
	lw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	d_vec.2580				#	bl	d_vec.2580
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	veciprod.2494				#	bl	veciprod.2494
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	r_bright.2588				#	bl	r_bright.2588
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
	jal	d_vec.2580				#	bl	d_vec.2580
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	veciprod.2494				#	bl	veciprod.2494
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
beq_cont.8416:
beq_cont.8414:
	j	beq_cont.8412
beq_then.8411:
beq_cont.8412:
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
trace_ray.2800:
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
	blei	r1, 4, ble_then.8418
	jr	r31				#	blr
ble_then.8418:
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
	jal	p_surface_ids.2565				#	bl	p_surface_ids.2565
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
	beqi	r1, 0, beq_then.8422
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
	jal	o_reflectiontype.2523				#	bl	o_reflectiontype.2523
	addi	r3, r3, -36
	lw	r30, 35(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 34(r3)
	sw	r1, 35(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	o_diffuse.2543				#	bl	o_diffuse.2543
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
	jal	veccpy.2483				#	bl	veccpy.2483
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
	jal	p_intersection_points.2563				#	bl	p_intersection_points.2563
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
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	p_calc_diffuse.2567				#	bl	p_calc_diffuse.2567
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 34(r3)
	sw	r1, 38(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 39(r3)
	addi	r3, r3, 40
	jal	o_diffuse.2543				#	bl	o_diffuse.2543
	addi	r3, r3, -40
	lw	r30, 39(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 16128	# to load float		0.500000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 39(r3)
	addi	r3, r3, 40
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -40
	lw	r30, 39(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8423
	lw	r1, 29(r3)
	lw	r2, 38(r3)
	lw	r5, 11(r3)
	add	r30, r2, r1
	sw	r5, 0(r30)
	j	beq_cont.8424
beq_then.8423:
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
	jal	p_energy.2569				#	bl	p_energy.2569
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
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 29(r3)
	lw	r2, 39(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	addi	r30, r0, 0
	lui	r30, r30, 15232	# to load float		0.003906
	fmvfr	f1, r30
	lw	r30, 36(r3)				#lfd	f2, 36(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	vecscale.2512				#	bl	vecscale.2512
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	p_nvectors.2578				#	bl	p_nvectors.2578
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
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.8424:
	addi	r30, r0, 0
	lui	r30, r30, 49152	# to load float		-2.000000
	fmvfr	f1, r30
	lw	r1, 30(r3)
	lw	r2, 12(r3)
	fmvtr	r30, f1
	sw	r30, 40(r3)				#stfd	f1, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	veciprod.2494				#	bl	veciprod.2494
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
	jal	vecaccum.2502				#	bl	vecaccum.2502
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	o_hilight.2545				#	bl	o_hilight.2545
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
	beqi	r1, 0, beq_then.8425
	j	beq_cont.8426
beq_then.8425:
	lw	r1, 12(r3)
	lw	r2, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	veciprod.2494				#	bl	veciprod.2494
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	veciprod.2494				#	bl	veciprod.2494
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	lib_fneg				#	bl	lib_fneg
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
beq_cont.8426:
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
	addi	r30, r0, 52429
	lui	r30, r30, 15820	# to load float		0.100000
	fmvfr	f1, r30
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8427
	addi	r1, r0, 4				# li	r1, 4
	lw	r2, 29(r3)
	ble	r1, r2, ble_then.8428
	addi	r1, r2, 1
	addi	r5, r0, -1				# li	r5, -1
	lw	r6, 32(r3)
	add	r30, r6, r1
	sw	r5, 0(r30)
	j	ble_cont.8429
ble_then.8428:
ble_cont.8429:
	lw	r1, 35(r3)
	beqi	r1, 2, beq_then.8430
	j	beq_cont.8431
beq_then.8430:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r1, 34(r3)
	fmvtr	r30, f1
	sw	r30, 46(r3)				#stfd	f1, 46(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	o_diffuse.2543				#	bl	o_diffuse.2543
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
beq_cont.8431:
	jr	r31				#	blr
beq_then.8427:
	jr	r31				#	blr
beq_then.8422:
	addi	r1, r0, -1				# li	r1, -1
	lw	r2, 29(r3)
	lw	r5, 32(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	r2, 0, beq_then.8434
	lw	r1, 30(r3)
	lw	r2, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	veciprod.2494				#	bl	veciprod.2494
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 48(r3)				#stfd	f1, 48(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8435
	lw	r30, 48(r3)				#lfd	f1, 48(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	lib_fsqr				#	bl	lib_fsqr
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
beq_then.8435:
	jr	r31				#	blr
beq_then.8434:
	jr	r31				#	blr
trace_diffuse_ray.2806:
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
	beqi	r1, 0, beq_then.8439
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
	jal	d_vec.2580				#	bl	d_vec.2580
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
	beqi	r1, 0, beq_then.8440
	jr	r31				#	blr
beq_then.8440:
	lw	r1, 5(r3)
	lw	r2, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	veciprod.2494				#	bl	veciprod.2494
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8443
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	j	beq_cont.8444
beq_then.8443:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
beq_cont.8444:
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 14(r3)
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	o_diffuse.2543				#	bl	o_diffuse.2543
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	lw	r2, 0(r3)
	j	vecaccum.2502
beq_then.8439:
	jr	r31				#	blr
iter_trace_diffuse_rays.2809:
	lw	r7, 1(29)
	addi	r8, r0, 0				# li	r8, 0
	ble	r8, r6, ble_then.8446
	jr	r31				#	blr
ble_then.8446:
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
	jal	d_vec.2580				#	bl	d_vec.2580
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	veciprod.2494				#	bl	veciprod.2494
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8448
	lw	r1, 3(r3)
	addi	r2, r1, 1
	lw	r5, 4(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r30, r0, 0
	lui	r30, r30, 49942	# to load float		-150.000000
	fmvfr	f1, r30
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
	j	beq_cont.8449
beq_then.8448:
	lw	r1, 3(r3)
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r30, r0, 0
	lui	r30, r30, 17174	# to load float		150.000000
	fmvfr	f1, r30
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
beq_cont.8449:
	lw	r1, 3(r3)
	addi	r6, r1, -2
	lw	r1, 4(r3)
	lw	r2, 5(r3)
	lw	r5, 0(r3)
	lw	29, 1(r3)
	lw	r28, 0(29)
	jr	r28
trace_diffuse_rays.2814:
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
trace_diffuse_ray_80percent.2818:
	lw	r6, 2(29)
	lw	r7, 1(29)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	sw	r1, 4(r3)
	beqi	r1, 0, beq_then.8450
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
	j	beq_cont.8451
beq_then.8450:
beq_cont.8451:
	lw	r1, 4(r3)
	beqi	r1, 1, beq_then.8452
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
	j	beq_cont.8453
beq_then.8452:
beq_cont.8453:
	lw	r1, 4(r3)
	beqi	r1, 2, beq_then.8454
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
	j	beq_cont.8455
beq_then.8454:
beq_cont.8455:
	lw	r1, 4(r3)
	beqi	r1, 3, beq_then.8456
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
	j	beq_cont.8457
beq_then.8456:
beq_cont.8457:
	lw	r1, 4(r3)
	beqi	r1, 4, beq_then.8458
	lw	r1, 3(r3)
	lw	r1, 4(r1)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	29, 2(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8458:
	jr	r31				#	blr
calc_diffuse_using_1point.2822:
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
	jal	p_received_ray_20percent.2571				#	bl	p_received_ray_20percent.2571
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	p_nvectors.2578				#	bl	p_nvectors.2578
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	p_intersection_points.2563				#	bl	p_intersection_points.2563
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	p_energy.2569				#	bl	p_energy.2569
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
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	p_group_id.2573				#	bl	p_group_id.2573
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
	j	vecaccumv.2515
calc_diffuse_using_5points.2825:
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
	jal	p_received_ray_20percent.2571				#	bl	p_received_ray_20percent.2571
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
	jal	p_received_ray_20percent.2571				#	bl	p_received_ray_20percent.2571
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
	jal	p_received_ray_20percent.2571				#	bl	p_received_ray_20percent.2571
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
	jal	p_received_ray_20percent.2571				#	bl	p_received_ray_20percent.2571
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
	jal	p_received_ray_20percent.2571				#	bl	p_received_ray_20percent.2571
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
	jal	veccpy.2483				#	bl	veccpy.2483
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
	jal	vecadd.2506				#	bl	vecadd.2506
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
	jal	vecadd.2506				#	bl	vecadd.2506
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
	jal	vecadd.2506				#	bl	vecadd.2506
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
	jal	vecadd.2506				#	bl	vecadd.2506
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
	jal	p_energy.2569				#	bl	p_energy.2569
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	add	r30, r1, r2
	lw	r2, 0(r30)
	lw	r1, 0(r3)
	lw	r5, 1(r3)
	j	vecaccumv.2515
do_without_neighbors.2831:
	lw	r5, 1(29)
	blei	r2, 4, ble_then.8460
	jr	r31				#	blr
ble_then.8460:
	sw	29, 0(r3)
	sw	r5, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	p_surface_ids.2565				#	bl	p_surface_ids.2565
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 3(r3)
	add	r30, r1, r5
	lw	r1, 0(r30)
	ble	r2, r1, ble_then.8462
	jr	r31				#	blr
ble_then.8462:
	lw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	p_calc_diffuse.2567				#	bl	p_calc_diffuse.2567
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	beqi	r1, 0, beq_then.8464
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
	j	beq_cont.8465
beq_then.8464:
beq_cont.8465:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
neighbors_exist.2834:
	lw	r5, 1(29)
	lw	r6, 1(r5)
	addi	r7, r2, 1
	ble	r6, r7, ble_then.8466
	blei	r2, 0, ble_then.8467
	lw	r2, 0(r5)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.8468
	blei	r1, 0, ble_then.8469
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
ble_then.8469:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
ble_then.8468:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
ble_then.8467:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
ble_then.8466:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
get_surface_id.2838:
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	p_surface_ids.2565				#	bl	p_surface_ids.2565
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	jr	r31				#	blr
neighbors_are_available.2841:
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
	jal	get_surface_id.2838				#	bl	get_surface_id.2838
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
	jal	get_surface_id.2838				#	bl	get_surface_id.2838
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	beq	r1, r2, beq_then.8470
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8470:
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
	jal	get_surface_id.2838				#	bl	get_surface_id.2838
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	beq	r1, r2, beq_then.8471
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8471:
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
	jal	get_surface_id.2838				#	bl	get_surface_id.2838
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	beq	r1, r2, beq_then.8472
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8472:
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
	jal	get_surface_id.2838				#	bl	get_surface_id.2838
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	beq	r1, r2, beq_then.8473
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.8473:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
try_exploit_neighbors.2847:
	lw	r9, 2(29)
	lw	r10, 1(29)
	add	r30, r6, r1
	lw	r11, 0(r30)
	blei	r8, 4, ble_then.8474
	jr	r31				#	blr
ble_then.8474:
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
	jal	get_surface_id.2838				#	bl	get_surface_id.2838
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 10(r3)
	ble	r2, r1, ble_then.8476
	jr	r31				#	blr
ble_then.8476:
	lw	r1, 9(r3)
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r6, 6(r3)
	lw	r7, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	neighbors_are_available.2841				#	bl	neighbors_are_available.2841
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8478
	lw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	p_calc_diffuse.2567				#	bl	p_calc_diffuse.2567
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r7, 5(r3)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beqi	r1, 0, beq_then.8479
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
	j	beq_cont.8480
beq_then.8479:
beq_cont.8480:
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
beq_then.8478:
	lw	r1, 9(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 5(r3)
	lw	29, 4(r3)
	lw	r28, 0(29)
	jr	r28
write_ppm_header.2854:
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
	jal	lib_print_int				#	bl	lib_print_int
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
	jal	lib_print_int				#	bl	lib_print_int
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
	jal	lib_print_int				#	bl	lib_print_int
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 10				# li	r1, 10
	j	lib_print_char
write_rgb_element.2856:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 0(r3)
	addi	r3, r3, 1
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -1
	lw	r30, 0(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 255				# li	r2, 255
	ble	r1, r2, ble_then.8481
	addi	r1, r0, 255				# li	r1, 255
	j	ble_cont.8482
ble_then.8481:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.8483
	addi	r1, r0, 0				# li	r1, 0
	j	ble_cont.8484
ble_then.8483:
ble_cont.8484:
ble_cont.8482:
	j	lib_print_int
write_rgb.2858:
	lw	r1, 1(29)
	flw	f1, 0(r1)
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	write_rgb_element.2856				#	bl	write_rgb_element.2856
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
	jal	write_rgb_element.2856				#	bl	write_rgb_element.2856
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
	jal	write_rgb_element.2856				#	bl	write_rgb_element.2856
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 10				# li	r1, 10
	j	lib_print_char
pretrace_diffuse_rays.2860:
	lw	r5, 3(29)
	lw	r6, 2(29)
	lw	r7, 1(29)
	blei	r2, 4, ble_then.8485
	jr	r31				#	blr
ble_then.8485:
	sw	29, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	get_surface_id.2838				#	bl	get_surface_id.2838
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.8487
	jr	r31				#	blr
ble_then.8487:
	lw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	p_calc_diffuse.2567				#	bl	p_calc_diffuse.2567
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	beqi	r1, 0, beq_then.8489
	lw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	p_group_id.2573				#	bl	p_group_id.2573
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	vecbzero.2481				#	bl	vecbzero.2481
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	p_nvectors.2578				#	bl	p_nvectors.2578
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	p_intersection_points.2563				#	bl	p_intersection_points.2563
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
	jal	p_received_ray_20percent.2571				#	bl	p_received_ray_20percent.2571
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
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.8490
beq_then.8489:
beq_cont.8490:
	lw	r1, 4(r3)
	addi	r2, r1, 1
	lw	r1, 5(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
pretrace_pixels.2863:
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
	ble	r16, r2, ble_then.8491
	jr	r31				#	blr
ble_then.8491:
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
	jal	lib_float_of_int				#	bl	lib_float_of_int
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
	jal	vecunit_sgn.2491				#	bl	vecunit_sgn.2491
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	vecbzero.2481				#	bl	vecbzero.2481
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	lw	r2, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r6, 0(r30)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
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
	jal	p_rgb.2561				#	bl	p_rgb.2561
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	veccpy.2483				#	bl	veccpy.2483
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
	jal	p_set_group_id.2575				#	bl	p_set_group_id.2575
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
	jal	add_mod5.2470				#	bl	add_mod5.2470
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
pretrace_line.2870:
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
	jal	lib_float_of_int				#	bl	lib_float_of_int
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
scan_pixel.2874:
	lw	r8, 6(29)
	lw	r9, 5(29)
	lw	r10, 4(29)
	lw	r11, 3(29)
	lw	r12, 2(29)
	lw	r13, 1(29)
	lw	r12, 0(r12)
	ble	r12, r1, ble_then.8495
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
	jal	p_rgb.2561				#	bl	p_rgb.2561
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	veccpy.2483				#	bl	veccpy.2483
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
	beqi	r1, 0, beq_then.8496
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
	j	beq_cont.8497
beq_then.8496:
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
beq_cont.8497:
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
ble_then.8495:
	jr	r31				#	blr
scan_line.2880:
	lw	r8, 3(29)
	lw	r9, 2(29)
	lw	r10, 1(29)
	lw	r11, 1(r10)
	ble	r11, r1, ble_then.8499
	lw	r10, 1(r10)
	addi	r10, r10, -1
	sw	29, 0(r3)
	sw	r7, 1(r3)
	sw	r6, 2(r3)
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	sw	r8, 6(r3)
	ble	r10, r1, ble_then.8500
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
	j	ble_cont.8501
ble_then.8500:
ble_cont.8501:
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
	jal	add_mod5.2470				#	bl	add_mod5.2470
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
ble_then.8499:
	jr	r31				#	blr
create_float5x3array.2886:
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
create_pixel.2888:
	lw	r1, 1(29)
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	jal	create_float5x3array.2886				#	bl	create_float5x3array.2886
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
	jal	create_float5x3array.2886				#	bl	create_float5x3array.2886
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.2886				#	bl	create_float5x3array.2886
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
	jal	create_float5x3array.2886				#	bl	create_float5x3array.2886
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
init_line_elements.2890:
	lw	r5, 1(29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.8504
	jr	r31				#	blr
ble_then.8504:
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
create_pixelline.2893:
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
tan.2895:
	fmvtr	r30, f1
	sw	r30, 0(r3)				#stfd	f1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_sin				#	bl	lib_sin
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
	jal	lib_cos				#	bl	lib_cos
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	jr	r31				#	blr
adjust_position.2897:
	fmul	f1, f1, f1
	addi	r30, r0, 52429
	lui	r30, r30, 15820	# to load float		0.100000
	fmvfr	f3, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fdiv	f2, f2, f1
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_atan				#	bl	lib_atan
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	tan.2895				#	bl	tan.2895
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
calc_dirvec.2900:
	lw	r6, 1(29)
	addi	r7, r0, 5				# li	r7, 5
	ble	r7, r1, ble_then.8505
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
	jal	adjust_position.2897				#	bl	adjust_position.2897
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
	jal	adjust_position.2897				#	bl	adjust_position.2897
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
ble_then.8505:
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
	jal	lib_fsqr				#	bl	lib_fsqr
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
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f4, r30
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
	jal	d_vec.2580				#	bl	d_vec.2580
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
	jal	vecset.2473				#	bl	vecset.2473
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
	jal	d_vec.2580				#	bl	d_vec.2580
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	sw	r1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 29(r3)
	addi	r3, r3, 30
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	vecset.2473				#	bl	vecset.2473
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
	jal	d_vec.2580				#	bl	d_vec.2580
	addi	r3, r3, -30
	lw	r30, 29(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f1, 26(r3)
	fmvfr	f1, r30
	sw	r1, 29(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	vecset.2473				#	bl	vecset.2473
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
	jal	d_vec.2580				#	bl	d_vec.2580
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f1, 26(r3)
	fmvfr	f1, r30
	sw	r1, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 33(r3)
	addi	r3, r3, 34
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	vecset.2473				#	bl	vecset.2473
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
	jal	d_vec.2580				#	bl	d_vec.2580
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f1, 26(r3)
	fmvfr	f1, r30
	sw	r1, 38(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 39(r3)
	addi	r3, r3, 40
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	vecset.2473				#	bl	vecset.2473
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
	jal	d_vec.2580				#	bl	d_vec.2580
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	sw	r1, 42(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 43(r3)
	addi	r3, r3, 44
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	lw	r30, 24(r3)				#lfd	f3, 24(r3)
	fmvfr	f3, r30
	lw	r1, 42(r3)
	j	vecset.2473
calc_dirvecs.2908:
	lw	r6, 1(29)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.8511
	jr	r31				#	blr
ble_then.8511:
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
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 52429
	lui	r30, r30, 15948	# to load float		0.200000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	addi	r30, r0, 26214
	lui	r30, r30, 16230	# to load float		0.900000
	fmvfr	f2, r30
	fsub	f3, f1, f2
	addi	r1, r0, 0				# li	r1, 0
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
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
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 52429
	lui	r30, r30, 15948	# to load float		0.200000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	addi	r30, r0, 52429
	lui	r30, r30, 15820	# to load float		0.100000
	fmvfr	f2, r30
	fadd	f3, f1, f2
	addi	r1, r0, 0				# li	r1, 0
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
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
	jal	add_mod5.2470				#	bl	add_mod5.2470
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
calc_dirvec_rows.2913:
	lw	r6, 1(29)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.8513
	jr	r31				#	blr
ble_then.8513:
	sw	29, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r6, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 52429
	lui	r30, r30, 15948	# to load float		0.200000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	addi	r30, r0, 26214
	lui	r30, r30, 16230	# to load float		0.900000
	fmvfr	f2, r30
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
	jal	add_mod5.2470				#	bl	add_mod5.2470
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
create_dirvec.2917:
	lw	r1, 1(29)
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
create_dirvec_elements.2919:
	lw	r5, 1(29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.8515
	jr	r31				#	blr
ble_then.8515:
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
create_dirvecs.2922:
	lw	r2, 3(29)
	lw	r5, 2(29)
	lw	r6, 1(29)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.8517
	jr	r31				#	blr
ble_then.8517:
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
init_dirvec_constants.2924:
	lw	r5, 1(29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.8519
	jr	r31				#	blr
ble_then.8519:
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
init_vecset_constants.2927:
	lw	r2, 2(29)
	lw	r5, 1(29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r1, ble_then.8521
	jr	r31				#	blr
ble_then.8521:
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
init_dirvecs.2929:
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
add_reflection.2931:
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
	jal	d_vec.2580				#	bl	d_vec.2580
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
	jal	vecset.2473				#	bl	vecset.2473
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
setup_rect_reflection.2938:
	lw	r5, 3(29)
	lw	r6, 2(29)
	lw	r7, 1(29)
	slli	r1, r1, 2
	lw	r8, 0(r5)
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
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
	jal	o_diffuse.2543				#	bl	o_diffuse.2543
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
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	lib_fneg				#	bl	lib_fneg
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
	jal	lib_fneg				#	bl	lib_fneg
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
setup_surface_reflection.2941:
	lw	r5, 3(29)
	lw	r6, 2(29)
	lw	r7, 1(29)
	slli	r1, r1, 2
	addi	r1, r1, 1
	lw	r8, 0(r5)
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
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
	jal	o_diffuse.2543				#	bl	o_diffuse.2543
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
	jal	o_param_abc.2535				#	bl	o_param_abc.2535
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	veciprod.2494				#	bl	veciprod.2494
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f2, r30
	lw	r1, 5(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	fmvtr	r30, f2
	sw	r30, 12(r3)				#stfd	f2, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	o_param_a.2529				#	bl	o_param_a.2529
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
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f3, r30
	lw	r2, 5(r3)
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	fmvtr	r30, f3
	sw	r30, 16(r3)				#stfd	f3, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	o_param_b.2531				#	bl	o_param_b.2531
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
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f3, r30
	lw	r2, 5(r3)
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	fmvtr	r30, f3
	sw	r30, 20(r3)				#stfd	f3, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	o_param_c.2533				#	bl	o_param_c.2533
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
setup_reflections.2944:
	lw	r2, 3(29)
	lw	r5, 2(29)
	lw	r6, 1(29)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.8529
	jr	r31				#	blr
ble_then.8529:
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
	jal	o_reflectiontype.2523				#	bl	o_reflectiontype.2523
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 2, beq_then.8531
	jr	r31				#	blr
beq_then.8531:
	lw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	o_diffuse.2543				#	bl	o_diffuse.2543
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 0, beq_then.8533
	lw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	o_form.2521				#	bl	o_form.2521
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	beqi	r1, 1, beq_then.8534
	beqi	r1, 2, beq_then.8535
	jr	r31				#	blr
beq_then.8535:
	lw	r1, 1(r3)
	lw	r2, 3(r3)
	lw	29, 0(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8534:
	lw	r1, 1(r3)
	lw	r2, 3(r3)
	lw	29, 2(r3)
	lw	r28, 0(29)
	jr	r28
beq_then.8533:
	jr	r31				#	blr
rt.2946:
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
	addi	r30, r0, 0
	lui	r30, r30, 17152	# to load float		128.000000
	fmvfr	f1, r30
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
	jal	lib_float_of_int				#	bl	lib_float_of_int
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
	jal	d_vec.2580				#	bl	d_vec.2580
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	veccpy.2483				#	bl	veccpy.2483
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 27432
	lui	r30, r30, 20078	# to load float		1000000000.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
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
	addi	r5, r0, read_screen_settings.2592
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
	addi	r10, r0, read_light.2594
	sw	r10, 0(r9)
	lw	r10, 6(r3)
	sw	r10, 2(r9)
	lw	r11, 7(r3)
	sw	r11, 1(r9)
	add	r12, r0, r4				# mr	r12, r4
	addi	r4, r4, 2
	addi	r13, r0, read_nth_object.2599
	sw	r13, 0(r12)
	lw	r13, 3(r3)
	sw	r13, 1(r12)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 3
	addi	r15, r0, read_object.2601
	sw	r15, 0(r14)
	sw	r12, 2(r14)
	lw	r12, 2(r3)
	sw	r12, 1(r14)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 2
	addi	r16, r0, read_all_object.2603
	sw	r16, 0(r15)
	sw	r14, 1(r15)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 2
	addi	r16, r0, read_and_network.2609
	sw	r16, 0(r14)
	lw	r16, 9(r3)
	sw	r16, 1(r14)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 6
	addi	r18, r0, read_parameter.2611
	sw	r18, 0(r17)
	sw	r2, 5(r17)
	sw	r9, 4(r17)
	sw	r14, 3(r17)
	sw	r15, 2(r17)
	lw	r2, 11(r3)
	sw	r2, 1(r17)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r14, r0, solver_rect_surface.2613
	sw	r14, 0(r9)
	lw	r14, 12(r3)
	sw	r14, 1(r9)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 2
	addi	r18, r0, solver_rect.2622
	sw	r18, 0(r15)
	sw	r9, 1(r15)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r18, r0, solver_surface.2628
	sw	r18, 0(r9)
	sw	r14, 1(r9)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 2
	addi	r19, r0, solver_second.2647
	sw	r19, 0(r18)
	sw	r14, 1(r18)
	add	r19, r0, r4				# mr	r19, r4
	addi	r4, r4, 5
	addi	r20, r0, solver.2653
	sw	r20, 0(r19)
	sw	r9, 4(r19)
	sw	r18, 3(r19)
	sw	r15, 2(r19)
	sw	r13, 1(r19)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r15, r0, solver_rect_fast.2657
	sw	r15, 0(r9)
	sw	r14, 1(r9)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 2
	addi	r18, r0, solver_surface_fast.2664
	sw	r18, 0(r15)
	sw	r14, 1(r15)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 2
	addi	r20, r0, solver_second_fast.2670
	sw	r20, 0(r18)
	sw	r14, 1(r18)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 5
	addi	r21, r0, solver_fast.2676
	sw	r21, 0(r20)
	sw	r15, 4(r20)
	sw	r18, 3(r20)
	sw	r9, 2(r20)
	sw	r13, 1(r20)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 2
	addi	r18, r0, solver_surface_fast2.2680
	sw	r18, 0(r15)
	sw	r14, 1(r15)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 2
	addi	r21, r0, solver_second_fast2.2687
	sw	r21, 0(r18)
	sw	r14, 1(r18)
	add	r21, r0, r4				# mr	r21, r4
	addi	r4, r4, 5
	addi	r22, r0, solver_fast2.2694
	sw	r22, 0(r21)
	sw	r15, 4(r21)
	sw	r18, 3(r21)
	sw	r9, 2(r21)
	sw	r13, 1(r21)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r15, r0, iter_setup_dirvec_constants.2706
	sw	r15, 0(r9)
	sw	r13, 1(r9)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 3
	addi	r18, r0, setup_dirvec_constants.2709
	sw	r18, 0(r15)
	sw	r12, 2(r15)
	sw	r9, 1(r15)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r18, r0, setup_startp_constants.2711
	sw	r18, 0(r9)
	sw	r13, 1(r9)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 4
	addi	r22, r0, setup_startp.2714
	sw	r22, 0(r18)
	lw	r22, 25(r3)
	sw	r22, 3(r18)
	sw	r9, 2(r18)
	sw	r12, 1(r18)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r23, r0, check_all_inside.2736
	sw	r23, 0(r9)
	sw	r13, 1(r9)
	add	r23, r0, r4				# mr	r23, r4
	addi	r4, r4, 8
	addi	r24, r0, shadow_check_and_group.2742
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
	addi	r27, r0, shadow_check_one_or_group.2745
	sw	r27, 0(r26)
	sw	r23, 2(r26)
	sw	r16, 1(r26)
	add	r23, r0, r4				# mr	r23, r4
	addi	r4, r4, 6
	addi	r27, r0, shadow_check_one_or_matrix.2748
	sw	r27, 0(r23)
	sw	r20, 5(r23)
	sw	r14, 4(r23)
	sw	r26, 3(r23)
	sw	r24, 2(r23)
	sw	r25, 1(r23)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 10
	addi	r26, r0, solve_each_element.2751
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
	addi	r17, r0, solve_one_or_network.2755
	sw	r17, 0(r24)
	sw	r20, 2(r24)
	sw	r16, 1(r24)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 6
	addi	r20, r0, trace_or_matrix.2759
	sw	r20, 0(r17)
	sw	r26, 5(r17)
	sw	r27, 4(r17)
	sw	r14, 3(r17)
	sw	r19, 2(r17)
	sw	r24, 1(r17)
	add	r19, r0, r4				# mr	r19, r4
	addi	r4, r4, 4
	addi	r20, r0, judge_intersection.2763
	sw	r20, 0(r19)
	sw	r17, 3(r19)
	sw	r26, 2(r19)
	sw	r2, 1(r19)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 10
	addi	r20, r0, solve_each_element_fast.2765
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
	addi	r20, r0, solve_one_or_network_fast.2769
	sw	r20, 0(r9)
	sw	r17, 2(r9)
	sw	r16, 1(r9)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 5
	addi	r17, r0, trace_or_matrix_fast.2773
	sw	r17, 0(r16)
	sw	r26, 4(r16)
	sw	r21, 3(r16)
	sw	r14, 2(r16)
	sw	r9, 1(r16)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 4
	addi	r14, r0, judge_intersection_fast.2777
	sw	r14, 0(r9)
	sw	r16, 3(r9)
	sw	r26, 2(r9)
	sw	r2, 1(r9)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 3
	addi	r16, r0, get_nvector_rect.2779
	sw	r16, 0(r14)
	lw	r16, 17(r3)
	sw	r16, 2(r14)
	sw	r28, 1(r14)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 2
	addi	r20, r0, get_nvector_plane.2781
	sw	r20, 0(r17)
	sw	r16, 1(r17)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 3
	addi	r21, r0, get_nvector_second.2783
	sw	r21, 0(r20)
	sw	r16, 2(r20)
	sw	r25, 1(r20)
	add	r21, r0, r4				# mr	r21, r4
	addi	r4, r4, 4
	addi	r22, r0, get_nvector.2785
	sw	r22, 0(r21)
	sw	r20, 3(r21)
	sw	r14, 2(r21)
	sw	r17, 1(r21)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 2
	addi	r17, r0, utexture.2788
	sw	r17, 0(r14)
	lw	r17, 18(r3)
	sw	r17, 1(r14)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 3
	addi	r22, r0, add_light.2791
	sw	r22, 0(r20)
	sw	r17, 2(r20)
	lw	r22, 20(r3)
	sw	r22, 1(r20)
	add	r24, r0, r4				# mr	r24, r4
	addi	r4, r4, 9
	sw	r15, 38(r3)
	addi	r15, r0, trace_reflections.2795
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
	addi	r12, r0, trace_ray.2800
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
	addi	r19, r0, trace_diffuse_ray.2806
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
	addi	r14, r0, iter_trace_diffuse_rays.2809
	sw	r14, 0(r9)
	sw	r11, 1(r9)
	add	r11, r0, r4				# mr	r11, r4
	addi	r4, r4, 3
	addi	r14, r0, trace_diffuse_rays.2814
	sw	r14, 0(r11)
	sw	r18, 2(r11)
	sw	r9, 1(r11)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 3
	addi	r14, r0, trace_diffuse_ray_80percent.2818
	sw	r14, 0(r9)
	sw	r11, 2(r9)
	lw	r14, 31(r3)
	sw	r14, 1(r9)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 4
	addi	r17, r0, calc_diffuse_using_1point.2822
	sw	r17, 0(r16)
	sw	r9, 3(r16)
	sw	r22, 2(r16)
	sw	r2, 1(r16)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 3
	addi	r17, r0, calc_diffuse_using_5points.2825
	sw	r17, 0(r9)
	sw	r22, 2(r9)
	sw	r2, 1(r9)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 2
	addi	r18, r0, do_without_neighbors.2831
	sw	r18, 0(r17)
	sw	r16, 1(r17)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 2
	addi	r18, r0, neighbors_exist.2834
	sw	r18, 0(r16)
	lw	r18, 21(r3)
	sw	r18, 1(r16)
	add	r19, r0, r4				# mr	r19, r4
	addi	r4, r4, 3
	addi	r20, r0, try_exploit_neighbors.2847
	sw	r20, 0(r19)
	sw	r17, 2(r19)
	sw	r9, 1(r19)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r20, r0, write_ppm_header.2854
	sw	r20, 0(r9)
	sw	r18, 1(r9)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 2
	addi	r21, r0, write_rgb.2858
	sw	r21, 0(r20)
	sw	r22, 1(r20)
	add	r21, r0, r4				# mr	r21, r4
	addi	r4, r4, 4
	addi	r23, r0, pretrace_diffuse_rays.2860
	sw	r23, 0(r21)
	sw	r11, 3(r21)
	sw	r14, 2(r21)
	sw	r2, 1(r21)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 11
	addi	r11, r0, pretrace_pixels.2863
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
	addi	r15, r0, pretrace_line.2870
	sw	r15, 0(r11)
	sw	r6, 6(r11)
	sw	r7, 5(r11)
	sw	r5, 4(r11)
	sw	r2, 3(r11)
	sw	r18, 2(r11)
	sw	r8, 1(r11)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 7
	addi	r6, r0, scan_pixel.2874
	sw	r6, 0(r2)
	sw	r20, 6(r2)
	sw	r19, 5(r2)
	sw	r22, 4(r2)
	sw	r16, 3(r2)
	sw	r18, 2(r2)
	sw	r17, 1(r2)
	add	r6, r0, r4				# mr	r6, r4
	addi	r4, r4, 4
	addi	r7, r0, scan_line.2880
	sw	r7, 0(r6)
	sw	r2, 3(r6)
	sw	r11, 2(r6)
	sw	r18, 1(r6)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	addi	r7, r0, create_pixel.2888
	sw	r7, 0(r2)
	sw	r12, 1(r2)
	add	r7, r0, r4				# mr	r7, r4
	addi	r4, r4, 2
	addi	r12, r0, init_line_elements.2890
	sw	r12, 0(r7)
	sw	r2, 1(r7)
	add	r12, r0, r4				# mr	r12, r4
	addi	r4, r4, 4
	addi	r15, r0, create_pixelline.2893
	sw	r15, 0(r12)
	sw	r7, 3(r12)
	sw	r18, 2(r12)
	sw	r2, 1(r12)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	addi	r7, r0, calc_dirvec.2900
	sw	r7, 0(r2)
	sw	r14, 1(r2)
	add	r7, r0, r4				# mr	r7, r4
	addi	r4, r4, 2
	addi	r15, r0, calc_dirvecs.2908
	sw	r15, 0(r7)
	sw	r2, 1(r7)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	addi	r15, r0, calc_dirvec_rows.2913
	sw	r15, 0(r2)
	sw	r7, 1(r2)
	add	r7, r0, r4				# mr	r7, r4
	addi	r4, r4, 2
	addi	r15, r0, create_dirvec.2917
	sw	r15, 0(r7)
	lw	r15, 2(r3)
	sw	r15, 1(r7)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 2
	addi	r17, r0, create_dirvec_elements.2919
	sw	r17, 0(r16)
	sw	r7, 1(r16)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 4
	addi	r19, r0, create_dirvecs.2922
	sw	r19, 0(r17)
	sw	r14, 3(r17)
	sw	r16, 2(r17)
	sw	r7, 1(r17)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 2
	addi	r19, r0, init_dirvec_constants.2924
	sw	r19, 0(r16)
	lw	r19, 38(r3)
	sw	r19, 1(r16)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 3
	addi	r21, r0, init_vecset_constants.2927
	sw	r21, 0(r20)
	sw	r16, 2(r20)
	sw	r14, 1(r20)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 4
	addi	r16, r0, init_dirvecs.2929
	sw	r16, 0(r14)
	sw	r20, 3(r14)
	sw	r17, 2(r14)
	sw	r2, 1(r14)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 4
	addi	r16, r0, add_reflection.2931
	sw	r16, 0(r2)
	sw	r19, 3(r2)
	lw	r16, 36(r3)
	sw	r16, 2(r2)
	sw	r7, 1(r2)
	add	r7, r0, r4				# mr	r7, r4
	addi	r4, r4, 4
	addi	r16, r0, setup_rect_reflection.2938
	sw	r16, 0(r7)
	sw	r1, 3(r7)
	sw	r10, 2(r7)
	sw	r2, 1(r7)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 4
	addi	r17, r0, setup_surface_reflection.2941
	sw	r17, 0(r16)
	sw	r1, 3(r16)
	sw	r10, 2(r16)
	sw	r2, 1(r16)
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 4
	addi	r2, r0, setup_reflections.2944
	sw	r2, 0(r1)
	sw	r16, 3(r1)
	sw	r7, 2(r1)
	sw	r13, 1(r1)
	add	29, r0, r4				# mr	29, r4
	addi	r4, r4, 15
	addi	r2, r0, rt.2946
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
