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
  addi  r1, r4, 0
lib_create_array_loop:
  beq r30, r0, lib_create_array_exit
lib_create_array_cont:
  sw  r2, 0(r4)
  addi r30, r30, -1
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
  fsw  f1, 0(r4)
  addi  r30, r30, -1
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
	fle	r30, f1, f0
	beq	r0, r30, _fle_else.862
	addi	r1, r0, 0
	jr	r31				#
_fle_else.862:
	addi	r1, r0, 1
	jr	r31				#
lib_fisneg:
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.863
	addi	r1, r0, 0
	jr	r31				#
_fle_else.863:
	addi	r1, r0, 1
	jr	r31				#
lib_fiszero:
	feq	r30, f1, f0
	beq	r0, r30, _feq_else.864
	addi	r1, r0, 1
	jr	r31				#
_feq_else.864:
	addi	r1, r0, 0
	jr	r31				#
lib_xor:
	beq	r1, r2, _beq_then.865
	addi	r1, r0, 1
	jr	r31				#
_beq_then.865:
	addi	r1, r0, 0
	jr	r31				#
lib_fhalf:
	flup	f2, 1		# fli	f2, 0.500000
	fmul	f1, f1, f2
	jr	r31				#
lib_fsqr:
	fmul	f1, f1, f1
	jr	r31				#
lib_fabs:
	addi	r1, r0, 48
	out	r1
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.866
	jr	r31				#
_fle_else.866:
	fneg	f1, f1
	jr	r31				#
lib_int_of_float:
	feq	r30, f1, f0
	beq	r0, r30, _feq_else.867
	addi	r1, r0, 0
	jr	r31				#
_feq_else.867:
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.868
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
_fle_else.868:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
lib_float_of_int:
	itof	r1, r1
	jr	r31				#
lib_floor:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
	itof	f1, r1
	flw	f2, 0(r3)
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.869
	jr	r31				#
_fle_else.869:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
	jr	r31				#
lib_hoge:
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.870
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.871
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j lib_hoge
_fle_else.871:
	fadd	f1, f0, f2
	jr	r31				#
_fle_else.870:
	fadd	f1, f0, f2
	jr	r31				#
lib_fuga:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.872
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.873
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j lib_fuga
_fle_else.873:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j lib_fuga
_fle_else.872:
	jr	r31				#
lib_modulo_2pi:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 0(r3)
	fsw	f1, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.874
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal lib_hoge				#	bl lib_hoge
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	_fle_cont.875
_fle_else.874:
_fle_cont.875:
	flw	f1, 2(r3)
	flw	f3, 0(r3)
	j lib_fuga
lib_sin_body:
	fmul	f2, f1, f1
	flup	f3, 6		# fli	f3, 0.166667
	fmul	f3, f3, f1
	fmul	f3, f3, f2
	fsub	f3, f1, f3
	flup	f4, 7		# fli	f4, 0.008333
	fmul	f4, f4, f1
	fmul	f4, f4, f2
	fmul	f4, f4, f2
	fadd	f3, f3, f4
	flup	f4, 8		# fli	f4, 0.000196
	fmul	f1, f4, f1
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fsub	f1, f3, f1
	jr	r31				#
lib_cos_body:
	fmul	f1, f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 1		# fli	f3, 0.500000
	flup	f4, 9		# fli	f4, 0.041664
	flup	f5, 10		# fli	f5, 0.001370
	fmul	f5, f1, f5
	fsub	f4, f4, f5
	fmul	f4, f1, f4
	fsub	f3, f3, f4
	fmul	f1, f1, f3
	fsub	f1, f2, f1
	jr	r31				#
lib_abs_float:
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.876
	jr	r31				#
_fle_else.876:
	fneg	f1, f1
	jr	r31				#
lib_sin:
	flup	f2, 14		# fli	f2, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.877
	flup	f3, 2		# fli	f3, 1.000000
	j	_fle_cont.878
_fle_else.877:
	flup	f3, 11		# fli	f3, -1.000000
_fle_cont.878:
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.879
	j	_fle_cont.880
_fle_else.879:
	fneg	f1, f1
_fle_cont.880:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal lib_modulo_2pi				#	bl lib_modulo_2pi
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.881
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.882
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.883
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.883:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.882:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.884
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.884:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.881:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.885
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.886
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.886:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.885:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.887
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.887:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
lib_cos:
	flup	f2, 14		# fli	f2, 3.141593
	flup	f3, 2		# fli	f3, 1.000000
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.888
	j	_fle_cont.889
_fle_else.888:
	fneg	f1, f1
_fle_cont.889:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal lib_modulo_2pi				#	bl lib_modulo_2pi
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.890
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.891
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, _fle_else.892
	fsw	f2, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.892:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fsw	f2, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.891:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.893
	fsw	f3, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.893:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.890:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.894
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, _fle_else.895
	fsw	f2, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.895:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fsw	f2, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.894:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.896
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.896:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
lib_atan_body:
	flup	f2, 17		# fli	f2, 0.333333
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fsub	f2, f1, f2
	flup	f3, 18		# fli	f3, 0.200000
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fadd	f2, f2, f3
	flup	f3, 19		# fli	f3, 0.142857
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fsub	f2, f2, f3
	flup	f3, 20		# fli	f3, 0.111111
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
	flup	f3, 21		# fli	f3, 0.089764
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
	flup	f3, 22		# fli	f3, 0.060035
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
	jr	r31				#
lib_atan:
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.897
	flup	f2, 2		# fli	f2, 1.000000
	j	_fle_cont.898
_fle_else.897:
	flup	f2, 11		# fli	f2, -1.000000
_fle_cont.898:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.899
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.900
	flup	f3, 15		# fli	f3, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal lib_atan_body				#	bl lib_atan_body
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.900:
	flup	f3, 16		# fli	f3, 0.785398
	flup	f4, 2		# fli	f4, 1.000000
	fsub	f4, f1, f4
	flup	f5, 2		# fli	f5, 1.000000
	fadd	f1, f1, f5
	fdiv	f1, f4, f1
	fsw	f2, 0(r3)
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_atan_body				#	bl lib_atan_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.899:
	j lib_atan_body
lib_print_num:
	addi	r1, r1, 48
	j	lib_print_char
lib_mul10:
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	jr	r31				#
lib_div10_sub:
	add	r6, r2, r5
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	ble	r7, r1, _ble_then.901
	add	r5, r0, r6				# mr	r5, r6
	j lib_div10_sub
_ble_then.901:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, _ble_then.902
	add	r2, r0, r6				# mr	r2, r6
	j lib_div10_sub
_ble_then.902:
	add	r1, r0, r6
	jr	r31				#
lib_div10:
	addi	r2, r0, 0
	add	r5, r0, r1				# mr	r5, r1
	j lib_div10_sub
lib_iter_mul10:
	beqi	0, r2, _beq_then.903
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	j lib_iter_mul10
_beq_then.903:
	jr	r31				#
lib_iter_div10:
	beqi	0, r2, _beq_then.904
	addi	r5, r0, 0
	sw	r2, 0(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal lib_div10_sub				#	bl lib_div10_sub
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	addi	r2, r2, -1
	j lib_iter_div10
_beq_then.904:
	jr	r31				#
lib_keta_sub:
	addi	r5, r0, 10
	ble	r5, r1, _ble_then.905
	addi	r1, r2, 1
	jr	r31				#
_ble_then.905:
	addi	r5, r0, 0
	sw	r2, 0(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal lib_div10_sub				#	bl lib_div10_sub
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	addi	r2, r2, 1
	j lib_keta_sub
lib_keta:
	addi	r2, r0, 0
	j lib_keta_sub
lib_print_uint_keta:
	beqi	1, r2, _beq_then.906
	addi	r5, r0, 1
	addi	r6, r2, -1
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_iter_mul10				#	bl lib_iter_mul10
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	ble	r1, r2, _ble_then.907
	addi	r1, r0, 48
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 0(r3)
	addi	r2, r1, -1
	lw	r1, 1(r3)
	j lib_print_uint_keta
_ble_then.907:
	lw	r1, 0(r3)
	addi	r5, r1, -1
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_iter_div10				#	bl lib_iter_div10
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r2, r1, 48
	sw	r1, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 0(r3)
	addi	r2, r1, -1
	lw	r5, 2(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal lib_iter_mul10				#	bl lib_iter_mul10
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	sub	r1, r2, r1
	lw	r2, 0(r3)
	addi	r2, r2, -1
	j lib_print_uint_keta
_beq_then.906:
	addi	r1, r1, 48
	j	lib_print_char
lib_print_uint:
	addi	r2, r0, 10
	ble	r2, r1, _ble_then.908
	addi	r1, r1, 48
	j	lib_print_char
_ble_then.908:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal lib_div10_sub				#	bl lib_div10_sub
	addi	r3, r3, -2
	lw	r31, 1(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_print_uint				#	bl lib_print_uint
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	j	lib_print_char
lib_print_int:
	addi	r2, r0, 0
	ble	r2, r1, _ble_then.909
	addi	r2, r0, 45
	sw	r1, 0(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	sub	r1, r0, r1
	j lib_print_uint
_ble_then.909:
	j lib_print_uint
lib_read_token:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_char				#	bl	lib_read_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 32
	beq	r1, r2, _beq_then.910
	beqi	9, r1, _beq_then.911
	beqi	13, r1, _beq_then.912
	beqi	10, r1, _beq_then.913
	addi	r2, r0, 26
	beq	r1, r2, _beq_then.914
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_buffer_add_char				#	bl	lib_buffer_add_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 1
	j lib_read_token
_beq_then.914:
	jr	r31				#
_beq_then.913:
	lw	r1, 0(r3)
	beqi	0, r1, _beq_then.916
	jr	r31				#
_beq_then.916:
	addi	r1, r0, 0
	j lib_read_token
_beq_then.912:
	lw	r1, 0(r3)
	beqi	0, r1, _beq_then.918
	jr	r31				#
_beq_then.918:
	addi	r1, r0, 0
	j lib_read_token
_beq_then.911:
	lw	r1, 0(r3)
	beqi	0, r1, _beq_then.920
	jr	r31				#
_beq_then.920:
	addi	r1, r0, 0
	j lib_read_token
_beq_then.910:
	lw	r1, 0(r3)
	beqi	0, r1, _beq_then.922
	jr	r31				#
_beq_then.922:
	addi	r1, r0, 0
	j lib_read_token
lib_read_int_ascii:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_buffer_clear				#	bl	lib_buffer_clear
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal lib_read_token				#	bl lib_read_token
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	lib_buffer_to_int
lib_iter_div10_float:
	beqi	0, r1, _beq_then.924
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	j lib_iter_div10_float
_beq_then.924:
	jr	r31				#
lib_read_float_ascii:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_buffer_clear				#	bl	lib_buffer_clear
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal lib_read_token				#	bl lib_read_token
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_buffer_get				#	bl	lib_buffer_get
	addi	r3, r3, -1
	lw	r31, 0(r3)
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_buffer_to_int_of_float				#	bl	lib_buffer_to_int_of_float
	addi	r3, r3, -2
	lw	r31, 1(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_buffer_to_dec_of_float				#	bl	lib_buffer_to_dec_of_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_buffer_to_ika_keta_of_float				#	bl	lib_buffer_to_ika_keta_of_float
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 45
	lw	r5, 0(r3)
	beq	r5, r2, _beq_then.925
	lw	r2, 1(r3)
	itof	f1, r2
	lw	r2, 2(r3)
	itof	f2, r2
	fsw	f1, 4(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_iter_div10_float				#	bl lib_iter_div10_float
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fadd	f1, f2, f1
	jr	r31				#
_beq_then.925:
	flup	f1, 11		# fli	f1, -1.000000
	lw	r2, 1(r3)
	itof	f2, r2
	lw	r2, 2(r3)
	itof	f3, r2
	fsw	f1, 6(r3)
	fsw	f2, 8(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal lib_iter_div10_float				#	bl lib_iter_div10_float
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	flw	f2, 6(r3)
	fmul	f1, f2, f1
	jr	r31				#
lib_truncate:
	j lib_int_of_float
lib_print_dec:
	feq	r30, f1, f0
	beq	r0, r30, _feq_else.927
	jr	r31				#
_feq_else.927:
	flup	f2, 39		# fli	f2, 10.000000
	fmul	f1, f2, f1
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_print_int				#	bl lib_print_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
	itof	f1, r1
	flw	f2, 0(r3)
	fsub	f1, f2, f1
	j lib_print_dec
lib_print_ufloat:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_print_int				#	bl lib_print_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r1, r0, 46
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
	itof	f1, r1
	flw	f2, 0(r3)
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.929
	j	_fle_cont.930
_fle_else.929:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f1, f1, f3
_fle_cont.930:
	fsub	f1, f2, f1
	j lib_print_dec
lib_print_float:
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.931
	j lib_print_ufloat
_fle_else.931:
	addi	r1, r0, 45
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f1, 0(r3)
	fneg	f1, f1
	j lib_print_ufloat
_R_0:
# library ends
print_char.2715:
	out	r1
	jr	r31				#
fispos.2717:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13094
	addi	r1, r0, 0
	jr	r31				#
fle_else.13094:
	addi	r1, r0, 1
	jr	r31				#
fisneg.2719:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13095
	addi	r1, r0, 0
	jr	r31				#
fle_else.13095:
	addi	r1, r0, 1
	jr	r31				#
fiszero.2721:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13096
	addi	r1, r0, 1
	jr	r31				#
feq_else.13096:
	addi	r1, r0, 0
	jr	r31				#
xor.2723:
	beq	r1, r2, beq_then.13097
	addi	r1, r0, 1
	jr	r31				#
beq_then.13097:
	addi	r1, r0, 0
	jr	r31				#
fhalf.2726:
	flup	f2, 1		# fli	f2, 0.500000
	fmul	f1, f1, f2
	jr	r31				#
fsqr.2728:
	fmul	f1, f1, f1
	jr	r31				#
fabs.2730:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13098
	jr	r31				#
fle_else.13098:
	fneg	f1, f1
	jr	r31				#
int_of_float.2732:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13099
	addi	r1, r0, 0
	jr	r31				#
feq_else.13099:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13100
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
fle_else.13100:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
float_of_int.2734:
	itof	r1, r1
	jr	r31				#
floor.2736:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13101
	addi	r1, r0, 0
	j	feq_cont.13102
feq_else.13101:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13103
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13104
fle_else.13103:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13104:
feq_cont.13102:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13105
	fadd	f1, f0, f2
	jr	r31				#
fle_else.13105:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
	jr	r31				#
hoge.2738:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13106
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13107
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13108
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13109
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13110
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13111
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13112
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13113
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2738
fle_else.13113:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.13112:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.13111:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.13110:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.13109:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.13108:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.13107:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.13106:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2741:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.13114
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13115
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.13116
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13117
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2741
fle_else.13117:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2741
fle_else.13116:
	jr	r31				#
fle_else.13115:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.13118
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13119
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2741
fle_else.13119:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2741
fle_else.13118:
	jr	r31				#
fle_else.13114:
	jr	r31				#
modulo_2pi.2745:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 0(r3)
	fsw	f1, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13120
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13122
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13124
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13126
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13128
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13130
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13132
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	hoge.2738				#	bl	hoge.2738
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	fle_cont.13133
fle_else.13132:
	fadd	f1, f0, f2
fle_cont.13133:
	j	fle_cont.13131
fle_else.13130:
	fadd	f1, f0, f2
fle_cont.13131:
	j	fle_cont.13129
fle_else.13128:
	fadd	f1, f0, f2
fle_cont.13129:
	j	fle_cont.13127
fle_else.13126:
	fadd	f1, f0, f2
fle_cont.13127:
	j	fle_cont.13125
fle_else.13124:
	fadd	f1, f0, f2
fle_cont.13125:
	j	fle_cont.13123
fle_else.13122:
	fadd	f1, f0, f2
fle_cont.13123:
	j	fle_cont.13121
fle_else.13120:
	fadd	f1, f0, f2
fle_cont.13121:
	flup	f2, 5		# fli	f2, 6.283186
	flw	f3, 2(r3)
	fle	r30, f2, f3
	beq	r0, r30, fle_else.13134
	fle	r30, f1, f3
	beq	r0, r30, fle_else.13135
	fsub	f2, f3, f1
	flup	f3, 3		# fli	f3, 2.000000
	fdiv	f1, f1, f3
	flw	f3, 0(r3)
	fadd	f30, f0, f2				# fmr	f30, f2
	fadd	f2, f0, f1				# fmr	f2, f1
	fadd	f1, f0, f30				# fmr	f1, f30
	j	fuga.2741
fle_else.13135:
	flup	f2, 3		# fli	f2, 2.000000
	fdiv	f2, f1, f2
	flw	f1, 0(r3)
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f30				# fmr	f1, f30
	j	fuga.2741
fle_else.13134:
	fadd	f1, f0, f3
	jr	r31				#
sin_body.2747:
	fmul	f2, f1, f1
	flup	f3, 6		# fli	f3, 0.166667
	fmul	f3, f3, f1
	fmul	f3, f3, f2
	fsub	f3, f1, f3
	flup	f4, 7		# fli	f4, 0.008333
	fmul	f4, f4, f1
	fmul	f4, f4, f2
	fmul	f4, f4, f2
	fadd	f3, f3, f4
	flup	f4, 8		# fli	f4, 0.000196
	fmul	f1, f4, f1
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fsub	f1, f3, f1
	jr	r31				#
cos_body.2749:
	fmul	f1, f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 1		# fli	f3, 0.500000
	flup	f4, 9		# fli	f4, 0.041664
	flup	f5, 10		# fli	f5, 0.001370
	fmul	f5, f1, f5
	fsub	f4, f4, f5
	fmul	f4, f1, f4
	fsub	f3, f3, f4
	fmul	f1, f1, f3
	fsub	f1, f2, f1
	jr	r31				#
sin.2751:
	flup	f2, 14		# fli	f2, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13136
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.13137
fle_else.13136:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.13137:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				#	bl	lib_abs_float
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 4(r3)
	fsw	f1, 6(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13138
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13140
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13142
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13144
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13146
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13148
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2738				#	bl	hoge.2738
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.13149
fle_else.13148:
fle_cont.13149:
	j	fle_cont.13147
fle_else.13146:
fle_cont.13147:
	j	fle_cont.13145
fle_else.13144:
fle_cont.13145:
	j	fle_cont.13143
fle_else.13142:
fle_cont.13143:
	j	fle_cont.13141
fle_else.13140:
fle_cont.13141:
	j	fle_cont.13139
fle_else.13138:
fle_cont.13139:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2741				#	bl	fuga.2741
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13150
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.13151
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13152
	fsw	f3, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2747				#	bl	sin_body.2747
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.13152:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fmul	f1, f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f4, 1		# fli	f4, 0.500000
	flup	f5, 9		# fli	f5, 0.041664
	flup	f6, 10		# fli	f6, 0.001370
	fmul	f6, f1, f6
	fsub	f5, f5, f6
	fmul	f5, f1, f5
	fsub	f4, f4, f5
	fmul	f1, f1, f4
	fsub	f1, f2, f1
	fmul	f1, f1, f3
	jr	r31				#
fle_else.13151:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13153
	fsw	f3, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2747				#	bl	sin_body.2747
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.13153:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fmul	f1, f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f4, 1		# fli	f4, 0.500000
	flup	f5, 9		# fli	f5, 0.041664
	flup	f6, 10		# fli	f6, 0.001370
	fmul	f6, f1, f6
	fsub	f5, f5, f6
	fmul	f5, f1, f5
	fsub	f4, f4, f5
	fmul	f1, f1, f4
	fsub	f1, f2, f1
	fmul	f1, f1, f3
	jr	r31				#
fle_else.13150:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.13154
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13155
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2747				#	bl	sin_body.2747
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.13155:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fmul	f1, f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 1		# fli	f3, 0.500000
	flup	f4, 9		# fli	f4, 0.041664
	flup	f5, 10		# fli	f5, 0.001370
	fmul	f5, f1, f5
	fsub	f4, f4, f5
	fmul	f4, f1, f4
	fsub	f3, f3, f4
	fmul	f1, f1, f3
	fsub	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.13154:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13156
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2747				#	bl	sin_body.2747
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.13156:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fmul	f1, f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 1		# fli	f3, 0.500000
	flup	f4, 9		# fli	f4, 0.041664
	flup	f5, 10		# fli	f5, 0.001370
	fmul	f5, f1, f5
	fsub	f4, f4, f5
	fmul	f4, f1, f4
	fsub	f3, f3, f4
	fmul	f1, f1, f3
	fsub	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
cos.2753:
	flup	f2, 14		# fli	f2, 3.141593
	flup	f3, 2		# fli	f3, 1.000000
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				#	bl	lib_abs_float
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 4(r3)
	fsw	f1, 6(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13157
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13159
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13161
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13163
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13165
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13167
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2738				#	bl	hoge.2738
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.13168
fle_else.13167:
fle_cont.13168:
	j	fle_cont.13166
fle_else.13165:
fle_cont.13166:
	j	fle_cont.13164
fle_else.13163:
fle_cont.13164:
	j	fle_cont.13162
fle_else.13161:
fle_cont.13162:
	j	fle_cont.13160
fle_else.13159:
fle_cont.13160:
	j	fle_cont.13158
fle_else.13157:
fle_cont.13158:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2741				#	bl	fuga.2741
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13169
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.13170
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.13171
	fmul	f1, f1, f1
	flup	f3, 2		# fli	f3, 1.000000
	flup	f4, 1		# fli	f4, 0.500000
	flup	f5, 9		# fli	f5, 0.041664
	flup	f6, 10		# fli	f6, 0.001370
	fmul	f6, f1, f6
	fsub	f5, f5, f6
	fmul	f5, f1, f5
	fsub	f4, f4, f5
	fmul	f1, f1, f4
	fsub	f1, f3, f1
	fmul	f1, f1, f2
	jr	r31				#
fle_else.13171:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fsw	f2, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2747				#	bl	sin_body.2747
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.13170:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13172
	fmul	f1, f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f4, 1		# fli	f4, 0.500000
	flup	f5, 9		# fli	f5, 0.041664
	flup	f6, 10		# fli	f6, 0.001370
	fmul	f6, f1, f6
	fsub	f5, f5, f6
	fmul	f5, f1, f5
	fsub	f4, f4, f5
	fmul	f1, f1, f4
	fsub	f1, f2, f1
	fmul	f1, f1, f3
	jr	r31				#
fle_else.13172:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin_body.2747				#	bl	sin_body.2747
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.13169:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.13173
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.13174
	fmul	f1, f1, f1
	flup	f3, 2		# fli	f3, 1.000000
	flup	f4, 1		# fli	f4, 0.500000
	flup	f5, 9		# fli	f5, 0.041664
	flup	f6, 10		# fli	f6, 0.001370
	fmul	f6, f1, f6
	fsub	f5, f5, f6
	fmul	f5, f1, f5
	fsub	f4, f4, f5
	fmul	f1, f1, f4
	fsub	f1, f3, f1
	fmul	f1, f1, f2
	jr	r31				#
fle_else.13174:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fsw	f2, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin_body.2747				#	bl	sin_body.2747
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.13173:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13175
	fmul	f1, f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 1		# fli	f3, 0.500000
	flup	f4, 9		# fli	f4, 0.041664
	flup	f5, 10		# fli	f5, 0.001370
	fmul	f5, f1, f5
	fsub	f4, f4, f5
	fmul	f4, f1, f4
	fsub	f3, f3, f4
	fmul	f1, f1, f3
	fsub	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.13175:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin_body.2747				#	bl	sin_body.2747
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
atan_body.2755:
	fmul	f2, f1, f1
	fmul	f3, f2, f2
	fmul	f4, f3, f3
	flup	f5, 17		# fli	f5, 0.333333
	fmul	f5, f5, f1
	fmul	f5, f5, f2
	fsub	f5, f1, f5
	flup	f6, 18		# fli	f6, 0.200000
	fmul	f6, f6, f1
	fmul	f6, f6, f3
	fadd	f5, f5, f6
	flup	f6, 19		# fli	f6, 0.142857
	fmul	f6, f6, f1
	fmul	f6, f6, f2
	fmul	f6, f6, f3
	fsub	f5, f5, f6
	flup	f6, 20		# fli	f6, 0.111111
	fmul	f6, f6, f1
	fmul	f6, f6, f3
	fmul	f6, f6, f3
	fadd	f5, f5, f6
	flup	f6, 21		# fli	f6, 0.089764
	fmul	f6, f6, f1
	fmul	f2, f6, f2
	fmul	f2, f2, f4
	fsub	f2, f5, f2
	flup	f5, 22		# fli	f5, 0.060035
	fmul	f1, f5, f1
	fmul	f1, f1, f3
	fmul	f1, f1, f4
	fadd	f1, f2, f1
	jr	r31				#
atan.2757:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13176
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.13177
fle_else.13176:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.13177:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.13178
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.13179
	flup	f3, 15		# fli	f3, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan_body.2755				#	bl	atan_body.2755
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.13179:
	flup	f3, 16		# fli	f3, 0.785398
	flup	f4, 2		# fli	f4, 1.000000
	fsub	f4, f1, f4
	flup	f5, 2		# fli	f5, 1.000000
	fadd	f1, f1, f5
	fdiv	f1, f4, f1
	fsw	f2, 0(r3)
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	atan_body.2755				#	bl	atan_body.2755
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.13178:
	j	atan_body.2755
print_num.2759:
	addi	r1, r1, 48
	out	r1
	jr	r31				#
mul10.2761:
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	jr	r31				#
div10_sub.2763:
	add	r6, r2, r5
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.13180
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r7, r5, 3
	slli	r8, r5, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.13181
	j	div10_sub.2763
ble_then.13181:
	slli	r2, r5, 3
	slli	r7, r5, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.13182
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	j	div10_sub.2763
ble_then.13182:
	add	r1, r0, r5
	jr	r31				#
ble_then.13180:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.13183
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r7, r2, 3
	slli	r8, r2, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.13184
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r6				# mr	r2, r6
	j	div10_sub.2763
ble_then.13184:
	slli	r6, r2, 3
	slli	r7, r2, 1
	add	r6, r6, r7
	addi	r6, r6, 9
	ble	r1, r6, ble_then.13185
	j	div10_sub.2763
ble_then.13185:
	add	r1, r0, r2
	jr	r31				#
ble_then.13183:
	add	r1, r0, r6
	jr	r31				#
div10.2767:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.13186
	j	div10_sub.2763
ble_then.13186:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.13187
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	j	div10_sub.2763
ble_then.13187:
	add	r1, r0, r5
	jr	r31				#
iter_mul10.2769:
	beqi	0, r2, beq_then.13188
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	beqi	0, r2, beq_then.13189
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	beqi	0, r2, beq_then.13190
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	beqi	0, r2, beq_then.13191
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	j	iter_mul10.2769
beq_then.13191:
	jr	r31				#
beq_then.13190:
	jr	r31				#
beq_then.13189:
	jr	r31				#
beq_then.13188:
	jr	r31				#
iter_div10.2772:
	beqi	0, r2, beq_then.13192
	addi	r5, r0, 0
	sw	r2, 0(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.13193
	addi	r5, r0, 0
	addi	r6, r1, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r2, 1(r3)
	ble	r7, r1, ble_then.13194
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.13195
ble_then.13194:
	slli	r5, r6, 3
	slli	r7, r6, 1
	add	r5, r5, r7
	addi	r5, r5, 9
	ble	r1, r5, ble_then.13196
	add	r5, r0, r1				# mr	r5, r1
	add	r2, r0, r6				# mr	r2, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.13197
ble_then.13196:
	add	r1, r0, r6
ble_cont.13197:
ble_cont.13195:
	lw	r2, 1(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.13198
	addi	r5, r0, 0
	sw	r2, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 2(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.13199
	sw	r2, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10.2767				#	bl	div10.2767
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	addi	r2, r2, -1
	j	iter_div10.2772
beq_then.13199:
	jr	r31				#
beq_then.13198:
	jr	r31				#
beq_then.13193:
	jr	r31				#
beq_then.13192:
	jr	r31				#
keta_sub.2775:
	addi	r5, r0, 10
	ble	r5, r1, ble_then.13200
	addi	r1, r2, 1
	jr	r31				#
ble_then.13200:
	addi	r5, r0, 0
	sw	r2, 0(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	addi	r2, r2, 1
	addi	r5, r0, 10
	ble	r5, r1, ble_then.13201
	addi	r1, r2, 1
	jr	r31				#
ble_then.13201:
	addi	r5, r0, 0
	addi	r6, r1, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r2, 1(r3)
	ble	r7, r1, ble_then.13202
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.13203
ble_then.13202:
	slli	r5, r6, 3
	slli	r7, r6, 1
	add	r5, r5, r7
	addi	r5, r5, 9
	ble	r1, r5, ble_then.13204
	add	r5, r0, r1				# mr	r5, r1
	add	r2, r0, r6				# mr	r2, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.13205
ble_then.13204:
	add	r1, r0, r6
ble_cont.13205:
ble_cont.13203:
	lw	r2, 1(r3)
	addi	r2, r2, 1
	addi	r5, r0, 10
	ble	r5, r1, ble_then.13206
	addi	r1, r2, 1
	jr	r31				#
ble_then.13206:
	addi	r5, r0, 0
	sw	r2, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 2(r3)
	addi	r2, r2, 1
	addi	r5, r0, 10
	ble	r5, r1, ble_then.13207
	addi	r1, r2, 1
	jr	r31				#
ble_then.13207:
	sw	r2, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10.2767				#	bl	div10.2767
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	addi	r2, r2, 1
	j	keta_sub.2775
keta.2778:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.13208
	addi	r1, r0, 1
	jr	r31				#
ble_then.13208:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.13209
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	ble_cont.13210
ble_then.13209:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.13211
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	ble_cont.13212
ble_then.13211:
	add	r1, r0, r5
ble_cont.13212:
ble_cont.13210:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.13213
	addi	r1, r0, 2
	jr	r31				#
ble_then.13213:
	addi	r2, r0, 0
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r2, r0, 10
	ble	r2, r1, ble_then.13214
	addi	r1, r0, 3
	jr	r31				#
ble_then.13214:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	div10.2767				#	bl	div10.2767
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r2, r0, 3
	j	keta_sub.2775
print_uint_keta.2780:
	beqi	1, r2, beq_then.13215
	addi	r5, r2, -1
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	beqi	0, r5, beq_then.13216
	addi	r5, r5, -1
	beqi	0, r5, beq_then.13218
	addi	r5, r5, -1
	beqi	0, r5, beq_then.13220
	addi	r6, r0, 1000
	addi	r5, r5, -1
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	iter_mul10.2769				#	bl	iter_mul10.2769
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.13221
beq_then.13220:
	addi	r1, r0, 100
beq_cont.13221:
	j	beq_cont.13219
beq_then.13218:
	addi	r1, r0, 10
beq_cont.13219:
	j	beq_cont.13217
beq_then.13216:
	addi	r1, r0, 1
beq_cont.13217:
	lw	r5, 1(r3)
	ble	r1, r5, ble_then.13222
	addi	r1, r0, 48
	out	r1
	lw	r1, 0(r3)
	addi	r2, r1, -1
	add	r1, r0, r5				# mr	r1, r5
	j	print_uint_keta.2780
ble_then.13222:
	lw	r1, 0(r3)
	addi	r2, r1, -1
	beqi	0, r2, beq_then.13223
	addi	r6, r0, 0
	addi	r7, r5, 0
	srai	r7, r7, 1
	slli	r8, r7, 3
	slli	r9, r7, 1
	add	r8, r8, r9
	sw	r2, 2(r3)
	ble	r8, r5, ble_then.13225
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	ble_cont.13226
ble_then.13225:
	slli	r6, r7, 3
	slli	r8, r7, 1
	add	r6, r6, r8
	addi	r6, r6, 9
	ble	r5, r6, ble_then.13227
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	ble_cont.13228
ble_then.13227:
	add	r1, r0, r7
ble_cont.13228:
ble_cont.13226:
	lw	r2, 2(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.13229
	addi	r5, r0, 0
	sw	r2, 3(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.13231
	sw	r2, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	div10.2767				#	bl	div10.2767
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 4(r3)
	addi	r2, r2, -1
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_div10.2772				#	bl	iter_div10.2772
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.13232
beq_then.13231:
beq_cont.13232:
	j	beq_cont.13230
beq_then.13229:
beq_cont.13230:
	j	beq_cont.13224
beq_then.13223:
	add	r1, r0, r5
beq_cont.13224:
	addi	r2, r1, 48
	out	r2
	lw	r2, 0(r3)
	addi	r5, r2, -1
	beqi	0, r5, beq_then.13233
	slli	r6, r1, 3
	slli	r1, r1, 1
	add	r1, r6, r1
	addi	r5, r5, -1
	beqi	0, r5, beq_then.13235
	slli	r6, r1, 3
	slli	r1, r1, 1
	add	r1, r6, r1
	addi	r5, r5, -1
	beqi	0, r5, beq_then.13237
	slli	r6, r1, 3
	slli	r1, r1, 1
	add	r1, r6, r1
	addi	r5, r5, -1
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_mul10.2769				#	bl	iter_mul10.2769
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.13238
beq_then.13237:
beq_cont.13238:
	j	beq_cont.13236
beq_then.13235:
beq_cont.13236:
	j	beq_cont.13234
beq_then.13233:
beq_cont.13234:
	lw	r2, 1(r3)
	sub	r1, r2, r1
	lw	r2, 0(r3)
	addi	r2, r2, -1
	j	print_uint_keta.2780
beq_then.13215:
	addi	r1, r1, 48
	out	r1
	jr	r31				#
print_uint.2783:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.13239
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.13239:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 10
	sw	r1, 1(r3)
	ble	r2, r1, ble_then.13240
	addi	r2, r1, 48
	out	r2
	j	ble_cont.13241
ble_then.13240:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.13242
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.13243
ble_then.13242:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.13244
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2763				#	bl	div10_sub.2763
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.13245
ble_then.13244:
	add	r1, r0, r5
ble_cont.13245:
ble_cont.13243:
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2783				#	bl	print_uint.2783
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 1(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.13241:
	lw	r1, 1(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
	jr	r31				#
print_int.2785:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13246
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	j	print_int.2785
ble_then.13246:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.13247
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.13247:
	addi	r2, r0, 100
	ble	r2, r1, ble_then.13248
	slli	r2, r1, 7
	slli	r5, r1, 6
	add	r2, r2, r5
	slli	r5, r1, 3
	add	r2, r2, r5
	slli	r5, r1, 2
	add	r2, r2, r5
	add	r2, r2, r1
	srli	r2, r2, 11
	addi	r5, r2, 48
	out	r5
	slli	r5, r2, 3
	slli	r2, r2, 1
	add	r2, r5, r2
	sub	r1, r1, r2
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.13248:
	slli	r2, r1, 7
	slli	r5, r1, 5
	add	r2, r2, r5
	slli	r5, r1, 2
	add	r2, r2, r5
	srli	r2, r2, 14
	slli	r5, r2, 6
	slli	r6, r2, 5
	add	r5, r5, r6
	slli	r6, r2, 2
	add	r5, r5, r6
	sub	r1, r1, r5
	slli	r5, r1, 7
	slli	r6, r1, 6
	add	r5, r5, r6
	slli	r6, r1, 3
	add	r5, r5, r6
	slli	r6, r1, 2
	add	r5, r5, r6
	add	r5, r5, r1
	srli	r5, r5, 11
	addi	r2, r2, 48
	out	r2
	addi	r2, r5, 48
	out	r2
	slli	r2, r5, 3
	slli	r5, r5, 1
	add	r2, r2, r5
	sub	r1, r1, r2
	addi	r1, r1, 48
	out	r1
	jr	r31				#
read_token.2787:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_char				#	bl	lib_read_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 32
	beq	r1, r2, beq_then.13249
	beqi	9, r1, beq_then.13250
	beqi	13, r1, beq_then.13251
	beqi	10, r1, beq_then.13252
	addi	r2, r0, 26
	beq	r1, r2, beq_then.13253
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_buffer_add_char				#	bl	lib_buffer_add_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 1
	j	read_token.2787
beq_then.13253:
	jr	r31				#
beq_then.13252:
	lw	r1, 0(r3)
	beqi	0, r1, beq_then.13255
	jr	r31				#
beq_then.13255:
	addi	r1, r0, 0
	j	read_token.2787
beq_then.13251:
	lw	r1, 0(r3)
	beqi	0, r1, beq_then.13257
	jr	r31				#
beq_then.13257:
	addi	r1, r0, 0
	j	read_token.2787
beq_then.13250:
	lw	r1, 0(r3)
	beqi	0, r1, beq_then.13259
	jr	r31				#
beq_then.13259:
	addi	r1, r0, 0
	j	read_token.2787
beq_then.13249:
	lw	r1, 0(r3)
	beqi	0, r1, beq_then.13261
	jr	r31				#
beq_then.13261:
	addi	r1, r0, 0
	j	read_token.2787
read_int_ascii.2789:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_buffer_clear				#	bl	lib_buffer_clear
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_token.2787				#	bl	read_token.2787
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	lib_buffer_to_int
iter_div10_float.2791:
	beqi	0, r1, beq_then.13263
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	beqi	0, r1, beq_then.13264
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	beqi	0, r1, beq_then.13265
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	beqi	0, r1, beq_then.13266
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	j	iter_div10_float.2791
beq_then.13266:
	jr	r31				#
beq_then.13265:
	jr	r31				#
beq_then.13264:
	jr	r31				#
beq_then.13263:
	jr	r31				#
read_float_ascii.2794:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_buffer_clear				#	bl	lib_buffer_clear
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_token.2787				#	bl	read_token.2787
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_buffer_get				#	bl	lib_buffer_get
	addi	r3, r3, -1
	lw	r31, 0(r3)
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_buffer_to_int_of_float				#	bl	lib_buffer_to_int_of_float
	addi	r3, r3, -2
	lw	r31, 1(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_buffer_to_dec_of_float				#	bl	lib_buffer_to_dec_of_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_buffer_to_ika_keta_of_float				#	bl	lib_buffer_to_ika_keta_of_float
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 45
	lw	r5, 0(r3)
	beq	r5, r2, beq_then.13267
	lw	r2, 1(r3)
	itof	f1, r2
	lw	r2, 2(r3)
	itof	f2, r2
	fsw	f1, 4(r3)
	beqi	0, r1, beq_then.13269
	flup	f3, 39		# fli	f3, 10.000000
	fdiv	f2, f2, f3
	addi	r1, r1, -1
	beqi	0, r1, beq_then.13271
	flup	f3, 39		# fli	f3, 10.000000
	fdiv	f2, f2, f3
	addi	r1, r1, -1
	beqi	0, r1, beq_then.13273
	flup	f3, 39		# fli	f3, 10.000000
	fdiv	f2, f2, f3
	addi	r1, r1, -1
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_div10_float.2791				#	bl	iter_div10_float.2791
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.13274
beq_then.13273:
	fadd	f1, f0, f2
beq_cont.13274:
	j	beq_cont.13272
beq_then.13271:
	fadd	f1, f0, f2
beq_cont.13272:
	j	beq_cont.13270
beq_then.13269:
	fadd	f1, f0, f2
beq_cont.13270:
	flw	f2, 4(r3)
	fadd	f1, f2, f1
	jr	r31				#
beq_then.13267:
	flup	f1, 11		# fli	f1, -1.000000
	lw	r2, 1(r3)
	itof	f2, r2
	lw	r2, 2(r3)
	itof	f3, r2
	fsw	f1, 6(r3)
	fsw	f2, 8(r3)
	beqi	0, r1, beq_then.13275
	flup	f4, 39		# fli	f4, 10.000000
	fdiv	f3, f3, f4
	addi	r1, r1, -1
	beqi	0, r1, beq_then.13277
	flup	f4, 39		# fli	f4, 10.000000
	fdiv	f3, f3, f4
	addi	r1, r1, -1
	beqi	0, r1, beq_then.13279
	flup	f4, 39		# fli	f4, 10.000000
	fdiv	f3, f3, f4
	addi	r1, r1, -1
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	iter_div10_float.2791				#	bl	iter_div10_float.2791
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.13280
beq_then.13279:
	fadd	f1, f0, f3
beq_cont.13280:
	j	beq_cont.13278
beq_then.13277:
	fadd	f1, f0, f3
beq_cont.13278:
	j	beq_cont.13276
beq_then.13275:
	fadd	f1, f0, f3
beq_cont.13276:
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	flw	f2, 6(r3)
	fmul	f1, f2, f1
	jr	r31				#
truncate.2796:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13281
	addi	r1, r0, 0
	jr	r31				#
feq_else.13281:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13282
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
fle_else.13282:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
abs_float.2798:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13283
	jr	r31				#
fle_else.13283:
	fneg	f1, f1
	jr	r31				#
print_dec.2800:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13284
	jr	r31				#
feq_else.13284:
	flup	f2, 39		# fli	f2, 10.000000
	fmul	f1, f2, f1
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13286
	addi	r1, r0, 0
	j	feq_cont.13287
feq_else.13286:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13288
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13289
fle_else.13288:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13289:
feq_cont.13287:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	print_int.2785				#	bl	print_int.2785
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f1, 0(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13290
	addi	r1, r0, 0
	j	feq_cont.13291
feq_else.13290:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13292
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13293
fle_else.13292:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13293:
feq_cont.13291:
	itof	f2, r1
	fsub	f1, f1, f2
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13294
	jr	r31				#
feq_else.13294:
	flup	f2, 39		# fli	f2, 10.000000
	fmul	f1, f2, f1
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13296
	addi	r1, r0, 0
	j	feq_cont.13297
feq_else.13296:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13298
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13299
fle_else.13298:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13299:
feq_cont.13297:
	fsw	f1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	print_int.2785				#	bl	print_int.2785
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f1, 2(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13300
	addi	r1, r0, 0
	j	feq_cont.13301
feq_else.13300:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13302
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13303
fle_else.13302:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13303:
feq_cont.13301:
	itof	f2, r1
	fsub	f1, f1, f2
	j	print_dec.2800
print_ufloat.2802:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13304
	addi	r1, r0, 0
	j	feq_cont.13305
feq_else.13304:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13306
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13307
fle_else.13306:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13307:
feq_cont.13305:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	print_int.2785				#	bl	print_int.2785
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r1, r0, 46
	out	r1
	flw	f1, 0(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13308
	addi	r1, r0, 0
	j	feq_cont.13309
feq_else.13308:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13310
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13311
fle_else.13310:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13311:
feq_cont.13309:
	itof	f2, r1
	fsub	f1, f1, f2
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13312
	jr	r31				#
feq_else.13312:
	flup	f2, 39		# fli	f2, 10.000000
	fmul	f1, f2, f1
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13314
	addi	r1, r0, 0
	j	feq_cont.13315
feq_else.13314:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13316
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13317
fle_else.13316:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13317:
feq_cont.13315:
	fsw	f1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	print_int.2785				#	bl	print_int.2785
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f1, 2(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13318
	addi	r1, r0, 0
	j	feq_cont.13319
feq_else.13318:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13320
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13321
fle_else.13320:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13321:
feq_cont.13319:
	itof	f2, r1
	fsub	f1, f1, f2
	j	print_dec.2800
print_float.2804:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13322
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13323
	addi	r1, r0, 0
	j	feq_cont.13324
feq_else.13323:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13325
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13326
fle_else.13325:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13326:
feq_cont.13324:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	print_int.2785				#	bl	print_int.2785
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r1, r0, 46
	out	r1
	flw	f1, 0(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13327
	addi	r1, r0, 0
	j	feq_cont.13328
feq_else.13327:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13329
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13330
fle_else.13329:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13330:
feq_cont.13328:
	itof	f2, r1
	fsub	f1, f1, f2
	j	print_dec.2800
fle_else.13322:
	addi	r1, r0, 45
	out	r1
	fneg	f1, f1
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13331
	addi	r1, r0, 0
	j	feq_cont.13332
feq_else.13331:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13333
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13334
fle_else.13333:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13334:
feq_cont.13332:
	fsw	f1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	print_int.2785				#	bl	print_int.2785
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 46
	out	r1
	flw	f1, 2(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13335
	addi	r1, r0, 0
	j	feq_cont.13336
feq_else.13335:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13337
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13338
fle_else.13337:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13338:
feq_cont.13336:
	itof	f2, r1
	fsub	f1, f1, f2
	j	print_dec.2800
xor.2838:
	beqi	0, r1, beq_then.13339
	beqi	0, r2, beq_then.13340
	addi	r1, r0, 0
	jr	r31				#
beq_then.13340:
	addi	r1, r0, 1
	jr	r31				#
beq_then.13339:
	add	r1, r0, r2
	jr	r31				#
sgn.2841:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13341
	addi	r1, r0, 1
	j	feq_cont.13342
feq_else.13341:
	addi	r1, r0, 0
feq_cont.13342:
	beqi	0, r1, beq_then.13343
	flup	f1, 0		# fli	f1, 0.000000
	jr	r31				#
beq_then.13343:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13344
	addi	r1, r0, 0
	j	fle_cont.13345
fle_else.13344:
	addi	r1, r0, 1
fle_cont.13345:
	beqi	0, r1, beq_then.13346
	flup	f1, 2		# fli	f1, 1.000000
	jr	r31				#
beq_then.13346:
	flup	f1, 11		# fli	f1, -1.000000
	jr	r31				#
fneg_cond.2843:
	beqi	0, r1, beq_then.13347
	jr	r31				#
beq_then.13347:
	fneg	f1, f1
	jr	r31				#
add_mod5.2846:
	add	r1, r1, r2
	addi	r2, r0, 5
	ble	r2, r1, ble_then.13348
	jr	r31				#
ble_then.13348:
	addi	r1, r1, -5
	jr	r31				#
vecset.2849:
	fsw	f1, 0(r1)
	fsw	f2, 1(r1)
	fsw	f3, 2(r1)
	jr	r31				#
vecfill.2854:
	fsw	f1, 0(r1)
	fsw	f1, 1(r1)
	fsw	f1, 2(r1)
	jr	r31				#
vecbzero.2857:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
	fsw	f1, 1(r1)
	fsw	f1, 2(r1)
	jr	r31				#
veccpy.2859:
	flw	f1, 0(r2)
	fsw	f1, 0(r1)
	flw	f1, 1(r2)
	fsw	f1, 1(r1)
	flw	f1, 2(r2)
	fsw	f1, 2(r1)
	jr	r31				#
vecdist2.2862:
	flw	f1, 0(r1)
	flw	f2, 0(r2)
	fsub	f1, f1, f2
	fmul	f1, f1, f1
	flw	f2, 1(r1)
	flw	f3, 1(r2)
	fsub	f2, f2, f3
	fmul	f2, f2, f2
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	flw	f3, 2(r2)
	fsub	f2, f2, f3
	fmul	f2, f2, f2
	fadd	f1, f1, f2
	jr	r31				#
vecunit.2865:
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r1)
	fmul	f2, f2, f2
	flw	f3, 1(r1)
	fmul	f3, f3, f3
	fadd	f2, f2, f3
	flw	f3, 2(r1)
	fmul	f3, f3, f3
	fadd	f2, f2, f3
	fsqrt	f2, f2
	fdiv	f1, f1, f2
	flw	f2, 0(r1)
	fmul	f2, f2, f1
	fsw	f2, 0(r1)
	flw	f2, 1(r1)
	fmul	f2, f2, f1
	fsw	f2, 1(r1)
	flw	f2, 2(r1)
	fmul	f1, f2, f1
	fsw	f1, 2(r1)
	jr	r31				#
vecunit_sgn.2867:
	flw	f1, 0(r1)
	fmul	f1, f1, f1
	flw	f2, 1(r1)
	fmul	f2, f2, f2
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	fmul	f2, f2, f2
	fadd	f1, f1, f2
	fsqrt	f1, f1
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13354
	addi	r5, r0, 1
	j	feq_cont.13355
feq_else.13354:
	addi	r5, r0, 0
feq_cont.13355:
	beqi	0, r5, beq_then.13356
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.13357
beq_then.13356:
	beqi	0, r2, beq_then.13358
	flup	f2, 11		# fli	f2, -1.000000
	fdiv	f1, f2, f1
	j	beq_cont.13359
beq_then.13358:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
beq_cont.13359:
beq_cont.13357:
	flw	f2, 0(r1)
	fmul	f2, f2, f1
	fsw	f2, 0(r1)
	flw	f2, 1(r1)
	fmul	f2, f2, f1
	fsw	f2, 1(r1)
	flw	f2, 2(r1)
	fmul	f1, f2, f1
	fsw	f1, 2(r1)
	jr	r31				#
veciprod.2870:
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
	jr	r31				#
veciprod2.2873:
	flw	f4, 0(r1)
	fmul	f1, f4, f1
	flw	f4, 1(r1)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	jr	r31				#
vecaccum.2878:
	flw	f2, 0(r1)
	flw	f3, 0(r2)
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fsw	f2, 0(r1)
	flw	f2, 1(r1)
	flw	f3, 1(r2)
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fsw	f2, 1(r1)
	flw	f2, 2(r1)
	flw	f3, 2(r2)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	fsw	f1, 2(r1)
	jr	r31				#
vecadd.2882:
	flw	f1, 0(r1)
	flw	f2, 0(r2)
	fadd	f1, f1, f2
	fsw	f1, 0(r1)
	flw	f1, 1(r1)
	flw	f2, 1(r2)
	fadd	f1, f1, f2
	fsw	f1, 1(r1)
	flw	f1, 2(r1)
	flw	f2, 2(r2)
	fadd	f1, f1, f2
	fsw	f1, 2(r1)
	jr	r31				#
vecmul.2885:
	flw	f1, 0(r1)
	flw	f2, 0(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	flw	f1, 1(r1)
	flw	f2, 1(r2)
	fmul	f1, f1, f2
	fsw	f1, 1(r1)
	flw	f1, 2(r1)
	flw	f2, 2(r2)
	fmul	f1, f1, f2
	fsw	f1, 2(r1)
	jr	r31				#
vecscale.2888:
	flw	f2, 0(r1)
	fmul	f2, f2, f1
	fsw	f2, 0(r1)
	flw	f2, 1(r1)
	fmul	f2, f2, f1
	fsw	f2, 1(r1)
	flw	f2, 2(r1)
	fmul	f1, f2, f1
	fsw	f1, 2(r1)
	jr	r31				#
vecaccumv.2891:
	flw	f1, 0(r1)
	flw	f2, 0(r2)
	flw	f3, 0(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 0(r1)
	flw	f1, 1(r1)
	flw	f2, 1(r2)
	flw	f3, 1(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 1(r1)
	flw	f1, 2(r1)
	flw	f2, 2(r2)
	flw	f3, 2(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 2(r1)
	jr	r31				#
o_texturetype.2895:
	lw	r1, 0(r1)
	jr	r31				#
o_form.2897:
	lw	r1, 1(r1)
	jr	r31				#
o_reflectiontype.2899:
	lw	r1, 2(r1)
	jr	r31				#
o_isinvert.2901:
	lw	r1, 6(r1)
	jr	r31				#
o_isrot.2903:
	lw	r1, 3(r1)
	jr	r31				#
o_param_a.2905:
	lw	r1, 4(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_param_b.2907:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_param_c.2909:
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_param_abc.2911:
	lw	r1, 4(r1)
	jr	r31				#
o_param_x.2913:
	lw	r1, 5(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_param_y.2915:
	lw	r1, 5(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_param_z.2917:
	lw	r1, 5(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_diffuse.2919:
	lw	r1, 7(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_hilight.2921:
	lw	r1, 7(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_color_red.2923:
	lw	r1, 8(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_color_green.2925:
	lw	r1, 8(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_color_blue.2927:
	lw	r1, 8(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_param_r1.2929:
	lw	r1, 9(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_param_r2.2931:
	lw	r1, 9(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_param_r3.2933:
	lw	r1, 9(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_param_ctbl.2935:
	lw	r1, 10(r1)
	jr	r31				#
p_rgb.2937:
	lw	r1, 0(r1)
	jr	r31				#
p_intersection_points.2939:
	lw	r1, 1(r1)
	jr	r31				#
p_surface_ids.2941:
	lw	r1, 2(r1)
	jr	r31				#
p_calc_diffuse.2943:
	lw	r1, 3(r1)
	jr	r31				#
p_energy.2945:
	lw	r1, 4(r1)
	jr	r31				#
p_received_ray_20percent.2947:
	lw	r1, 5(r1)
	jr	r31				#
p_group_id.2949:
	lw	r1, 6(r1)
	lw	r1, 0(r1)
	jr	r31				#
p_set_group_id.2951:
	lw	r1, 6(r1)
	sw	r2, 0(r1)
	jr	r31				#
p_nvectors.2954:
	lw	r1, 7(r1)
	jr	r31				#
d_vec.2956:
	lw	r1, 0(r1)
	jr	r31				#
d_const.2958:
	lw	r1, 1(r1)
	jr	r31				#
r_surface_id.2960:
	lw	r1, 0(r1)
	jr	r31				#
r_dvec.2962:
	lw	r1, 1(r1)
	jr	r31				#
r_bright.2964:
	flw	f1, 2(r1)
	jr	r31				#
rad.2966:
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	jr	r31				#
read_screen_settings.2968:
	lw	r1, 5(r29)
	lw	r2, 4(r29)
	lw	r5, 3(r29)
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	fsw	f1, 0(r1)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	fsw	f1, 1(r1)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	fsw	f1, 2(r1)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -6
	lw	r31, 5(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	fsw	f1, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos.2753				#	bl	cos.2753
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin.2751				#	bl	sin.2751
	addi	r3, r3, -11
	lw	r31, 10(r3)
	fsw	f1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	cos.2753				#	bl	cos.2753
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fsw	f1, 14(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	sin.2751				#	bl	sin.2751
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 8(r3)
	fmul	f3, f2, f1
	flup	f4, 26		# fli	f4, 200.000000
	fmul	f3, f3, f4
	lw	r1, 3(r3)
	fsw	f3, 0(r1)
	flup	f3, 27		# fli	f3, -200.000000
	flw	f4, 10(r3)
	fmul	f3, f4, f3
	fsw	f3, 1(r1)
	flw	f3, 14(r3)
	fmul	f5, f2, f3
	flup	f6, 26		# fli	f6, 200.000000
	fmul	f5, f5, f6
	fsw	f5, 2(r1)
	lw	r2, 2(r3)
	fsw	f3, 0(r2)
	flup	f5, 0		# fli	f5, 0.000000
	fsw	f5, 1(r2)
	fneg	f5, f1
	fsw	f5, 2(r2)
	fneg	f4, f4
	fmul	f1, f4, f1
	lw	r2, 1(r3)
	fsw	f1, 0(r2)
	fneg	f1, f2
	fsw	f1, 1(r2)
	fmul	f1, f4, f3
	fsw	f1, 2(r2)
	lw	r2, 4(r3)
	flw	f1, 0(r2)
	flw	f2, 0(r1)
	fsub	f1, f1, f2
	lw	r5, 0(r3)
	fsw	f1, 0(r5)
	flw	f1, 1(r2)
	flw	f2, 1(r1)
	fsub	f1, f1, f2
	fsw	f1, 1(r5)
	flw	f1, 2(r2)
	flw	f2, 2(r1)
	fsub	f1, f1, f2
	fsw	f1, 2(r5)
	jr	r31				#
read_light.2970:
	lw	r1, 2(r29)
	lw	r2, 1(r29)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	fsw	f1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2751				#	bl	sin.2751
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fneg	f1, f1
	lw	r1, 1(r3)
	fsw	f1, 1(r1)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	flw	f2, 2(r3)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2753				#	bl	cos.2753
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2751				#	bl	sin.2751
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	fsw	f1, 0(r1)
	flw	f1, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos.2753				#	bl	cos.2753
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	fsw	f1, 2(r1)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	jr	r31				#
rotate_quadratic_matrix.2972:
	flw	f1, 0(r2)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	cos.2753				#	bl	cos.2753
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2751				#	bl	sin.2751
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2753				#	bl	cos.2753
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2751				#	bl	sin.2751
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos.2753				#	bl	cos.2753
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 10(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2751				#	bl	sin.2751
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	flw	f3, 6(r3)
	fmul	f4, f3, f2
	flw	f5, 8(r3)
	flw	f6, 4(r3)
	fmul	f7, f6, f5
	fmul	f8, f7, f2
	flw	f9, 2(r3)
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
	fneg	f2, f5
	fmul	f5, f6, f3
	fmul	f3, f9, f3
	lw	r1, 0(r3)
	flw	f6, 0(r1)
	flw	f9, 1(r1)
	flw	f10, 2(r1)
	fmul	f13, f4, f4
	fmul	f13, f6, f13
	fmul	f14, f12, f12
	fmul	f14, f9, f14
	fadd	f13, f13, f14
	fmul	f14, f2, f2
	fmul	f14, f10, f14
	fadd	f13, f13, f14
	fsw	f13, 0(r1)
	fmul	f13, f8, f8
	fmul	f13, f6, f13
	fmul	f14, f7, f7
	fmul	f14, f9, f14
	fadd	f13, f13, f14
	fmul	f14, f5, f5
	fmul	f14, f10, f14
	fadd	f13, f13, f14
	fsw	f13, 1(r1)
	fmul	f13, f11, f11
	fmul	f13, f6, f13
	fmul	f14, f1, f1
	fmul	f14, f9, f14
	fadd	f13, f13, f14
	fmul	f14, f3, f3
	fmul	f14, f10, f14
	fadd	f13, f13, f14
	fsw	f13, 2(r1)
	flup	f13, 3		# fli	f13, 2.000000
	fmul	f14, f6, f8
	fmul	f14, f14, f11
	fmul	f15, f9, f7
	fmul	f15, f15, f1
	fadd	f14, f14, f15
	fmul	f15, f10, f5
	fmul	f15, f15, f3
	fadd	f14, f14, f15
	fmul	f13, f13, f14
	lw	r1, 1(r3)
	fsw	f13, 0(r1)
	flup	f13, 3		# fli	f13, 2.000000
	fmul	f4, f6, f4
	fmul	f6, f4, f11
	fmul	f9, f9, f12
	fmul	f1, f9, f1
	fadd	f1, f6, f1
	fmul	f2, f10, f2
	fmul	f3, f2, f3
	fadd	f1, f1, f3
	fmul	f1, f13, f1
	fsw	f1, 1(r1)
	flup	f1, 3		# fli	f1, 2.000000
	fmul	f3, f4, f8
	fmul	f4, f9, f7
	fadd	f3, f3, f4
	fmul	f2, f2, f5
	fadd	f2, f3, f2
	fmul	f1, f1, f2
	fsw	f1, 2(r1)
	jr	r31				#
read_nth_object.2975:
	lw	r2, 1(r29)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.13371
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -5
	lw	r31, 4(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	fsw	f1, 0(r1)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	fsw	f1, 1(r1)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	fsw	f1, 2(r1)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
	sw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 7(r3)
	fsw	f1, 0(r1)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 7(r3)
	fsw	f1, 1(r1)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 7(r3)
	fsw	f1, 2(r1)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13372
	addi	r1, r0, 0
	j	fle_cont.13373
fle_else.13372:
	addi	r1, r0, 1
fle_cont.13373:
	addi	r2, r0, 2
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 8(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
	sw	r1, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 9(r3)
	fsw	f1, 0(r1)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 9(r3)
	fsw	f1, 1(r1)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r31, 10(r3)
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 10(r3)
	fsw	f1, 0(r1)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 10(r3)
	fsw	f1, 1(r1)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 10(r3)
	fsw	f1, 2(r1)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 5(r3)
	beqi	0, r2, beq_then.13374
	sw	r1, 11(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	lw	r1, 11(r3)
	fsw	f1, 0(r1)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	lw	r1, 11(r3)
	fsw	f1, 1(r1)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	lw	r1, 11(r3)
	fsw	f1, 2(r1)
	j	beq_cont.13375
beq_then.13374:
beq_cont.13375:
	lw	r2, 3(r3)
	beqi	2, r2, beq_then.13376
	lw	r5, 8(r3)
	j	beq_cont.13377
beq_then.13376:
	addi	r5, r0, 1
beq_cont.13377:
	addi	r6, r0, 4
	flup	f1, 0		# fli	f1, 0.000000
	sw	r5, 12(r3)
	sw	r1, 11(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r2, r0, r4
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
	beqi	3, r7, beq_then.13378
	beqi	2, r7, beq_then.13380
	j	beq_cont.13381
beq_then.13380:
	lw	r2, 8(r3)
	beqi	0, r2, beq_then.13382
	addi	r2, r0, 0
	j	beq_cont.13383
beq_then.13382:
	addi	r2, r0, 1
beq_cont.13383:
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	vecunit_sgn.2867				#	bl	vecunit_sgn.2867
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.13381:
	j	beq_cont.13379
beq_then.13378:
	flw	f1, 0(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13384
	addi	r2, r0, 1
	j	feq_cont.13385
feq_else.13384:
	addi	r2, r0, 0
feq_cont.13385:
	beqi	0, r2, beq_then.13386
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.13387
beq_then.13386:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13388
	addi	r2, r0, 1
	j	feq_cont.13389
feq_else.13388:
	addi	r2, r0, 0
feq_cont.13389:
	beqi	0, r2, beq_then.13390
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.13391
beq_then.13390:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13392
	addi	r2, r0, 0
	j	fle_cont.13393
fle_else.13392:
	addi	r2, r0, 1
fle_cont.13393:
	beqi	0, r2, beq_then.13394
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.13395
beq_then.13394:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.13395:
beq_cont.13391:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.13387:
	fsw	f1, 0(r5)
	flw	f1, 1(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13396
	addi	r2, r0, 1
	j	feq_cont.13397
feq_else.13396:
	addi	r2, r0, 0
feq_cont.13397:
	beqi	0, r2, beq_then.13398
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.13399
beq_then.13398:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13400
	addi	r2, r0, 1
	j	feq_cont.13401
feq_else.13400:
	addi	r2, r0, 0
feq_cont.13401:
	beqi	0, r2, beq_then.13402
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.13403
beq_then.13402:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13404
	addi	r2, r0, 0
	j	fle_cont.13405
fle_else.13404:
	addi	r2, r0, 1
fle_cont.13405:
	beqi	0, r2, beq_then.13406
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.13407
beq_then.13406:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.13407:
beq_cont.13403:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.13399:
	fsw	f1, 1(r5)
	flw	f1, 2(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13408
	addi	r2, r0, 1
	j	feq_cont.13409
feq_else.13408:
	addi	r2, r0, 0
feq_cont.13409:
	beqi	0, r2, beq_then.13410
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.13411
beq_then.13410:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13412
	addi	r2, r0, 1
	j	feq_cont.13413
feq_else.13412:
	addi	r2, r0, 0
feq_cont.13413:
	beqi	0, r2, beq_then.13414
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.13415
beq_then.13414:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13416
	addi	r2, r0, 0
	j	fle_cont.13417
fle_else.13416:
	addi	r2, r0, 1
fle_cont.13417:
	beqi	0, r2, beq_then.13418
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.13419
beq_then.13418:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.13419:
beq_cont.13415:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.13411:
	fsw	f1, 2(r5)
beq_cont.13379:
	lw	r1, 5(r3)
	beqi	0, r1, beq_then.13420
	lw	r1, 6(r3)
	lw	r2, 11(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	rotate_quadratic_matrix.2972				#	bl	rotate_quadratic_matrix.2972
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.13421
beq_then.13420:
beq_cont.13421:
	addi	r1, r0, 1
	jr	r31				#
beq_then.13371:
	addi	r1, r0, 0
	jr	r31				#
read_object.2977:
	lw	r2, 2(r29)
	lw	r5, 1(r29)
	addi	r6, r0, 60
	ble	r6, r1, ble_then.13422
	sw	r29, 0(r3)
	sw	r2, 1(r3)
	sw	r5, 2(r3)
	sw	r1, 3(r3)
	add	r29, r0, r2				# mr	r29, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.13423
	lw	r1, 3(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.13424
	lw	r29, 1(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.13425
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13425:
	lw	r1, 2(r3)
	lw	r2, 4(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.13424:
	jr	r31				#
beq_then.13423:
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.13422:
	jr	r31				#
read_all_object.2979:
	lw	r1, 3(r29)
	lw	r2, 2(r29)
	lw	r5, 1(r29)
	addi	r6, r0, 0
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	add	r1, r0, r6				# mr	r1, r6
	add	r29, r0, r2				# mr	r29, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.13430
	addi	r1, r0, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13430:
	lw	r1, 1(r3)
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	jr	r31				#
read_net_item.2981:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.13432
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.13433
	lw	r2, 2(r3)
	addi	r5, r2, 1
	sw	r1, 3(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.2981				#	bl	read_net_item.2981
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.13434
beq_then.13433:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.13434:
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.13432:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	j	lib_create_array
read_or_network.2983:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.13435
	addi	r2, r0, 1
	sw	r1, 1(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_net_item.2981				#	bl	read_net_item.2981
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.13436
beq_then.13435:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.13436:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.13437
	lw	r1, 0(r3)
	addi	r5, r1, 1
	addi	r6, r0, 0
	sw	r2, 2(r3)
	sw	r5, 3(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.2981				#	bl	read_net_item.2981
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.13438
	lw	r1, 3(r3)
	addi	r5, r1, 1
	sw	r2, 4(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	read_or_network.2983				#	bl	read_or_network.2983
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.13439
beq_then.13438:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.13439:
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.13437:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.2985:
	lw	r2, 1(r29)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.13440
	addi	r2, r0, 1
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.2981				#	bl	read_net_item.2981
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	j	beq_cont.13441
beq_then.13440:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.13441:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.13442
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	addi	r2, r0, 0
	sw	r1, 4(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	read_net_item.2981				#	bl	read_net_item.2981
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.13443
	lw	r2, 4(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13443:
	jr	r31				#
beq_then.13442:
	jr	r31				#
read_parameter.2987:
	lw	r1, 6(r29)
	lw	r2, 5(r29)
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r8, 2(r3)
	sw	r2, 3(r3)
	sw	r5, 4(r3)
	add	r29, r0, r1				# mr	r29, r1
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r29, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r1, r0, 0
	lw	r29, 3(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r1, r0, 0
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	read_net_item.2981				#	bl	read_net_item.2981
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.13446
	lw	r2, 2(r3)
	sw	r1, 0(r2)
	addi	r1, r0, 1
	lw	r29, 1(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.13447
beq_then.13446:
beq_cont.13447:
	addi	r1, r0, 0
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	read_net_item.2981				#	bl	read_net_item.2981
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.13448
	addi	r1, r0, 1
	sw	r2, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	read_or_network.2983				#	bl	read_or_network.2983
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	j	beq_cont.13449
beq_then.13448:
	addi	r1, r0, 1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.13449:
	lw	r2, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#
solver_rect_surface.2989:
	lw	r8, 1(r29)
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.13451
	addi	r9, r0, 1
	j	feq_cont.13452
feq_else.13451:
	addi	r9, r0, 0
feq_cont.13452:
	beqi	0, r9, beq_then.13453
	addi	r1, r0, 0
	jr	r31				#
beq_then.13453:
	lw	r9, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.13454
	addi	r10, r0, 0
	j	fle_cont.13455
fle_else.13454:
	addi	r10, r0, 1
fle_cont.13455:
	beqi	0, r1, beq_then.13456
	beqi	0, r10, beq_then.13458
	addi	r1, r0, 0
	j	beq_cont.13459
beq_then.13458:
	addi	r1, r0, 1
beq_cont.13459:
	j	beq_cont.13457
beq_then.13456:
	add	r1, r0, r10
beq_cont.13457:
	add	r30, r9, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.13460
	j	beq_cont.13461
beq_then.13460:
	fneg	f4, f4
beq_cont.13461:
	fsub	f1, f4, f1
	add	r30, r2, r5
	flw	f4, 0(r30)
	fdiv	f1, f1, f4
	add	r30, r9, r6
	flw	f4, 0(r30)
	add	r30, r2, r6
	flw	f5, 0(r30)
	fmul	f5, f1, f5
	fadd	f2, f5, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.13462
	j	fle_cont.13463
fle_else.13462:
	fneg	f2, f2
fle_cont.13463:
	fle	r30, f4, f2
	beq	r0, r30, fle_else.13464
	addi	r1, r0, 0
	jr	r31				#
fle_else.13464:
	add	r30, r9, r7
	flw	f2, 0(r30)
	add	r30, r2, r7
	flw	f4, 0(r30)
	fmul	f4, f1, f4
	fadd	f3, f4, f3
	fle	r30, f0, f3
	beq	r0, r30, fle_else.13465
	j	fle_cont.13466
fle_else.13465:
	fneg	f3, f3
fle_cont.13466:
	fle	r30, f2, f3
	beq	r0, r30, fle_else.13467
	addi	r1, r0, 0
	jr	r31				#
fle_else.13467:
	fsw	f1, 0(r8)
	addi	r1, r0, 1
	jr	r31				#
solver_rect.2998:
	lw	r29, 1(r29)
	addi	r5, r0, 0
	addi	r6, r0, 1
	addi	r7, r0, 2
	fsw	f1, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	sw	r29, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	beqi	0, r1, beq_then.13468
	addi	r1, r0, 1
	jr	r31				#
beq_then.13468:
	addi	r5, r0, 1
	addi	r6, r0, 2
	addi	r7, r0, 0
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r1, 7(r3)
	lw	r2, 6(r3)
	lw	r29, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	beqi	0, r1, beq_then.13469
	addi	r1, r0, 2
	jr	r31				#
beq_then.13469:
	addi	r5, r0, 2
	addi	r6, r0, 0
	addi	r7, r0, 1
	flw	f1, 2(r3)
	flw	f2, 0(r3)
	flw	f3, 4(r3)
	lw	r1, 7(r3)
	lw	r2, 6(r3)
	lw	r29, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	beqi	0, r1, beq_then.13470
	addi	r1, r0, 3
	jr	r31				#
beq_then.13470:
	addi	r1, r0, 0
	jr	r31				#
solver_surface.3004:
	lw	r5, 1(r29)
	lw	r1, 4(r1)
	sw	r5, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	fsw	f1, 6(r3)
	sw	r1, 8(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	veciprod.2870				#	bl	veciprod.2870
	addi	r3, r3, -10
	lw	r31, 9(r3)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13472
	addi	r1, r0, 0
	j	fle_cont.13473
fle_else.13472:
	addi	r1, r0, 1
fle_cont.13473:
	beqi	0, r1, beq_then.13474
	lw	r1, 8(r3)
	flw	f2, 0(r1)
	flw	f3, 6(r3)
	fmul	f2, f2, f3
	flw	f3, 1(r1)
	flw	f4, 4(r3)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flw	f3, 2(r1)
	flw	f4, 2(r3)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	fneg	f2, f2
	fdiv	f1, f2, f1
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.13474:
	addi	r1, r0, 0
	jr	r31				#
quadratic.3010:
	fmul	f4, f1, f1
	lw	r2, 4(r1)
	flw	f5, 0(r2)
	fmul	f4, f4, f5
	fmul	f5, f2, f2
	lw	r2, 4(r1)
	flw	f6, 1(r2)
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	fmul	f5, f3, f3
	lw	r2, 4(r1)
	flw	f6, 2(r2)
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	lw	r2, 3(r1)
	beqi	0, r2, beq_then.13475
	fmul	f5, f2, f3
	lw	r2, 9(r1)
	flw	f6, 0(r2)
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	fmul	f3, f3, f1
	lw	r2, 9(r1)
	flw	f5, 1(r2)
	fmul	f3, f3, f5
	fadd	f3, f4, f3
	fmul	f1, f1, f2
	lw	r1, 9(r1)
	flw	f2, 2(r1)
	fmul	f1, f1, f2
	fadd	f1, f3, f1
	jr	r31				#
beq_then.13475:
	fadd	f1, f0, f4
	jr	r31				#
bilinear.3015:
	fmul	f7, f1, f4
	lw	r2, 4(r1)
	flw	f8, 0(r2)
	fmul	f7, f7, f8
	fmul	f8, f2, f5
	lw	r2, 4(r1)
	flw	f9, 1(r2)
	fmul	f8, f8, f9
	fadd	f7, f7, f8
	fmul	f8, f3, f6
	lw	r2, 4(r1)
	flw	f9, 2(r2)
	fmul	f8, f8, f9
	fadd	f7, f7, f8
	lw	r2, 3(r1)
	beqi	0, r2, beq_then.13476
	fmul	f8, f3, f5
	fmul	f9, f2, f6
	fadd	f8, f8, f9
	lw	r2, 9(r1)
	flw	f9, 0(r2)
	fmul	f8, f8, f9
	fmul	f6, f1, f6
	fmul	f3, f3, f4
	fadd	f3, f6, f3
	lw	r2, 9(r1)
	flw	f6, 1(r2)
	fmul	f3, f3, f6
	fadd	f3, f8, f3
	fmul	f1, f1, f5
	fmul	f2, f2, f4
	fadd	f1, f1, f2
	lw	r1, 9(r1)
	flw	f2, 2(r1)
	fmul	f1, f1, f2
	fadd	f1, f3, f1
	flup	f2, 1		# fli	f2, 0.500000
	fmul	f1, f1, f2
	fadd	f1, f7, f1
	jr	r31				#
beq_then.13476:
	fadd	f1, f0, f7
	jr	r31				#
solver_second.3023:
	lw	r5, 1(r29)
	flw	f4, 0(r2)
	flw	f5, 1(r2)
	flw	f6, 2(r2)
	sw	r5, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	fsw	f1, 6(r3)
	sw	r1, 8(r3)
	sw	r2, 9(r3)
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	quadratic.3010				#	bl	quadratic.3010
	addi	r3, r3, -11
	lw	r31, 10(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13478
	addi	r1, r0, 1
	j	feq_cont.13479
feq_else.13478:
	addi	r1, r0, 0
feq_cont.13479:
	beqi	0, r1, beq_then.13480
	addi	r1, r0, 0
	jr	r31				#
beq_then.13480:
	lw	r1, 9(r3)
	flw	f2, 0(r1)
	flw	f3, 1(r1)
	flw	f4, 2(r1)
	flw	f5, 6(r3)
	flw	f6, 4(r3)
	flw	f7, 2(r3)
	lw	r1, 8(r3)
	fsw	f1, 10(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	fadd	f4, f0, f5				# fmr	f4, f5
	fadd	f5, f0, f6				# fmr	f5, f6
	fadd	f6, f0, f7				# fmr	f6, f7
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	bilinear.3015				#	bl	bilinear.3015
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 6(r3)
	flw	f3, 4(r3)
	flw	f4, 2(r3)
	lw	r1, 8(r3)
	fsw	f1, 12(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	quadratic.3010				#	bl	quadratic.3010
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 8(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.13481
	j	beq_cont.13482
beq_then.13481:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.13482:
	flw	f2, 12(r3)
	fmul	f3, f2, f2
	flw	f4, 10(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13483
	addi	r2, r0, 0
	j	fle_cont.13484
fle_else.13483:
	addi	r2, r0, 1
fle_cont.13484:
	beqi	0, r2, beq_then.13485
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.13486
	j	beq_cont.13487
beq_then.13486:
	fneg	f1, f1
beq_cont.13487:
	fsub	f1, f1, f2
	fdiv	f1, f1, f4
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.13485:
	addi	r1, r0, 0
	jr	r31				#
solver.3029:
	lw	r6, 4(r29)
	lw	r7, 3(r29)
	lw	r8, 2(r29)
	lw	r9, 1(r29)
	add	r30, r9, r1
	lw	r1, 0(r30)
	flw	f1, 0(r5)
	lw	r9, 5(r1)
	flw	f2, 0(r9)
	fsub	f1, f1, f2
	flw	f2, 1(r5)
	lw	r9, 5(r1)
	flw	f3, 1(r9)
	fsub	f2, f2, f3
	flw	f3, 2(r5)
	lw	r5, 5(r1)
	flw	f4, 2(r5)
	fsub	f3, f3, f4
	lw	r5, 1(r1)
	beqi	1, r5, beq_then.13488
	beqi	2, r5, beq_then.13489
	add	r29, r0, r6				# mr	r29, r6
	lw	r28, 0(r29)
	jr	r28
beq_then.13489:
	lw	r1, 4(r1)
	sw	r8, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	fsw	f1, 6(r3)
	sw	r1, 8(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	veciprod.2870				#	bl	veciprod.2870
	addi	r3, r3, -10
	lw	r31, 9(r3)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13491
	addi	r1, r0, 0
	j	fle_cont.13492
fle_else.13491:
	addi	r1, r0, 1
fle_cont.13492:
	beqi	0, r1, beq_then.13493
	lw	r1, 8(r3)
	flw	f2, 0(r1)
	flw	f3, 6(r3)
	fmul	f2, f2, f3
	flw	f3, 1(r1)
	flw	f4, 4(r3)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flw	f3, 2(r1)
	flw	f4, 2(r3)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	fneg	f2, f2
	fdiv	f1, f2, f1
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.13493:
	addi	r1, r0, 0
	jr	r31				#
beq_then.13488:
	add	r29, r0, r7				# mr	r29, r7
	lw	r28, 0(r29)
	jr	r28
solver_rect_fast.3033:
	lw	r6, 1(r29)
	flw	f4, 0(r5)
	fsub	f4, f4, f1
	flw	f5, 1(r5)
	fmul	f4, f4, f5
	lw	r7, 4(r1)
	flw	f5, 1(r7)
	flw	f6, 1(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f2
	fle	r30, f0, f6
	beq	r0, r30, fle_else.13494
	j	fle_cont.13495
fle_else.13494:
	fneg	f6, f6
fle_cont.13495:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.13496
	addi	r7, r0, 0
	j	fle_cont.13497
fle_else.13496:
	lw	r7, 4(r1)
	flw	f5, 2(r7)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.13498
	j	fle_cont.13499
fle_else.13498:
	fneg	f6, f6
fle_cont.13499:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.13500
	addi	r7, r0, 0
	j	fle_cont.13501
fle_else.13500:
	flw	f5, 1(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.13502
	addi	r7, r0, 1
	j	feq_cont.13503
feq_else.13502:
	addi	r7, r0, 0
feq_cont.13503:
	beqi	0, r7, beq_then.13504
	addi	r7, r0, 0
	j	beq_cont.13505
beq_then.13504:
	addi	r7, r0, 1
beq_cont.13505:
fle_cont.13501:
fle_cont.13497:
	beqi	0, r7, beq_then.13506
	fsw	f4, 0(r6)
	addi	r1, r0, 1
	jr	r31				#
beq_then.13506:
	flw	f4, 2(r5)
	fsub	f4, f4, f2
	flw	f5, 3(r5)
	fmul	f4, f4, f5
	lw	r7, 4(r1)
	flw	f5, 0(r7)
	flw	f6, 0(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f1
	fle	r30, f0, f6
	beq	r0, r30, fle_else.13507
	j	fle_cont.13508
fle_else.13507:
	fneg	f6, f6
fle_cont.13508:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.13509
	addi	r7, r0, 0
	j	fle_cont.13510
fle_else.13509:
	lw	r7, 4(r1)
	flw	f5, 2(r7)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.13511
	j	fle_cont.13512
fle_else.13511:
	fneg	f6, f6
fle_cont.13512:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.13513
	addi	r7, r0, 0
	j	fle_cont.13514
fle_else.13513:
	flw	f5, 3(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.13515
	addi	r7, r0, 1
	j	feq_cont.13516
feq_else.13515:
	addi	r7, r0, 0
feq_cont.13516:
	beqi	0, r7, beq_then.13517
	addi	r7, r0, 0
	j	beq_cont.13518
beq_then.13517:
	addi	r7, r0, 1
beq_cont.13518:
fle_cont.13514:
fle_cont.13510:
	beqi	0, r7, beq_then.13519
	fsw	f4, 0(r6)
	addi	r1, r0, 2
	jr	r31				#
beq_then.13519:
	flw	f4, 4(r5)
	fsub	f3, f4, f3
	flw	f4, 5(r5)
	fmul	f3, f3, f4
	lw	r7, 4(r1)
	flw	f4, 0(r7)
	flw	f5, 0(r2)
	fmul	f5, f3, f5
	fadd	f1, f5, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13520
	j	fle_cont.13521
fle_else.13520:
	fneg	f1, f1
fle_cont.13521:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.13522
	addi	r1, r0, 0
	j	fle_cont.13523
fle_else.13522:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	flw	f4, 1(r2)
	fmul	f4, f3, f4
	fadd	f2, f4, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.13524
	j	fle_cont.13525
fle_else.13524:
	fneg	f2, f2
fle_cont.13525:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13526
	addi	r1, r0, 0
	j	fle_cont.13527
fle_else.13526:
	flw	f1, 5(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13528
	addi	r1, r0, 1
	j	feq_cont.13529
feq_else.13528:
	addi	r1, r0, 0
feq_cont.13529:
	beqi	0, r1, beq_then.13530
	addi	r1, r0, 0
	j	beq_cont.13531
beq_then.13530:
	addi	r1, r0, 1
beq_cont.13531:
fle_cont.13527:
fle_cont.13523:
	beqi	0, r1, beq_then.13532
	fsw	f3, 0(r6)
	addi	r1, r0, 3
	jr	r31				#
beq_then.13532:
	addi	r1, r0, 0
	jr	r31				#
solver_surface_fast.3040:
	lw	r1, 1(r29)
	flw	f4, 0(r2)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.13533
	addi	r5, r0, 0
	j	fle_cont.13534
fle_else.13533:
	addi	r5, r0, 1
fle_cont.13534:
	beqi	0, r5, beq_then.13535
	flw	f4, 1(r2)
	fmul	f1, f4, f1
	flw	f4, 2(r2)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 3(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.13535:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3046:
	lw	r5, 1(r29)
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.13536
	addi	r6, r0, 1
	j	feq_cont.13537
feq_else.13536:
	addi	r6, r0, 0
feq_cont.13537:
	beqi	0, r6, beq_then.13538
	addi	r1, r0, 0
	jr	r31				#
beq_then.13538:
	flw	f5, 1(r2)
	fmul	f5, f5, f1
	flw	f6, 2(r2)
	fmul	f6, f6, f2
	fadd	f5, f5, f6
	flw	f6, 3(r2)
	fmul	f6, f6, f3
	fadd	f5, f5, f6
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	fsw	f4, 2(r3)
	fsw	f5, 4(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	quadratic.3010				#	bl	quadratic.3010
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.13539
	j	beq_cont.13540
beq_then.13539:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.13540:
	flw	f2, 4(r3)
	fmul	f3, f2, f2
	flw	f4, 2(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13541
	addi	r2, r0, 0
	j	fle_cont.13542
fle_else.13541:
	addi	r2, r0, 1
fle_cont.13542:
	beqi	0, r2, beq_then.13543
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.13544
	fsqrt	f1, f1
	fadd	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	j	beq_cont.13545
beq_then.13544:
	fsqrt	f1, f1
	fsub	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
beq_cont.13545:
	addi	r1, r0, 1
	jr	r31				#
beq_then.13543:
	addi	r1, r0, 0
	jr	r31				#
solver_fast.3052:
	lw	r6, 4(r29)
	lw	r7, 3(r29)
	lw	r8, 2(r29)
	lw	r9, 1(r29)
	add	r30, r9, r1
	lw	r9, 0(r30)
	flw	f1, 0(r5)
	lw	r10, 5(r9)
	flw	f2, 0(r10)
	fsub	f1, f1, f2
	flw	f2, 1(r5)
	lw	r10, 5(r9)
	flw	f3, 1(r10)
	fsub	f2, f2, f3
	flw	f3, 2(r5)
	lw	r5, 5(r9)
	flw	f4, 2(r5)
	fsub	f3, f3, f4
	lw	r5, 1(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r1, 1(r9)
	beqi	1, r1, beq_then.13546
	beqi	2, r1, beq_then.13547
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r9				# mr	r1, r9
	add	r29, r0, r7				# mr	r29, r7
	lw	r28, 0(r29)
	jr	r28
beq_then.13547:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r9				# mr	r1, r9
	add	r29, r0, r6				# mr	r29, r6
	lw	r28, 0(r29)
	jr	r28
beq_then.13546:
	lw	r2, 0(r2)
	add	r1, r0, r9				# mr	r1, r9
	add	r29, r0, r8				# mr	r29, r8
	lw	r28, 0(r29)
	jr	r28
solver_surface_fast2.3056:
	lw	r1, 1(r29)
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13548
	addi	r6, r0, 0
	j	fle_cont.13549
fle_else.13548:
	addi	r6, r0, 1
fle_cont.13549:
	beqi	0, r6, beq_then.13550
	flw	f1, 0(r2)
	flw	f2, 3(r5)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.13550:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3063:
	lw	r6, 1(r29)
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.13551
	addi	r7, r0, 1
	j	feq_cont.13552
feq_else.13551:
	addi	r7, r0, 0
feq_cont.13552:
	beqi	0, r7, beq_then.13553
	addi	r1, r0, 0
	jr	r31				#
beq_then.13553:
	flw	f5, 1(r2)
	fmul	f1, f5, f1
	flw	f5, 2(r2)
	fmul	f2, f5, f2
	fadd	f1, f1, f2
	flw	f2, 3(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 3(r5)
	fmul	f3, f1, f1
	fmul	f2, f4, f2
	fsub	f2, f3, f2
	fle	r30, f2, f0
	beq	r0, r30, fle_else.13554
	addi	r5, r0, 0
	j	fle_cont.13555
fle_else.13554:
	addi	r5, r0, 1
fle_cont.13555:
	beqi	0, r5, beq_then.13556
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.13557
	fsqrt	f2, f2
	fadd	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r6)
	j	beq_cont.13558
beq_then.13557:
	fsqrt	f2, f2
	fsub	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r6)
beq_cont.13558:
	addi	r1, r0, 1
	jr	r31				#
beq_then.13556:
	addi	r1, r0, 0
	jr	r31				#
solver_fast2.3070:
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	add	r30, r8, r1
	lw	r8, 0(r30)
	lw	r9, 10(r8)
	flw	f1, 0(r9)
	flw	f2, 1(r9)
	flw	f3, 2(r9)
	lw	r10, 1(r2)
	add	r30, r10, r1
	lw	r1, 0(r30)
	lw	r10, 1(r8)
	beqi	1, r10, beq_then.13559
	beqi	2, r10, beq_then.13560
	add	r2, r0, r1				# mr	r2, r1
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r9				# mr	r5, r9
	add	r1, r0, r8				# mr	r1, r8
	lw	r28, 0(r29)
	jr	r28
beq_then.13560:
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13561
	addi	r2, r0, 0
	j	fle_cont.13562
fle_else.13561:
	addi	r2, r0, 1
fle_cont.13562:
	beqi	0, r2, beq_then.13563
	flw	f1, 0(r1)
	flw	f2, 3(r9)
	fmul	f1, f1, f2
	fsw	f1, 0(r7)
	addi	r1, r0, 1
	jr	r31				#
beq_then.13563:
	addi	r1, r0, 0
	jr	r31				#
beq_then.13559:
	lw	r2, 0(r2)
	add	r5, r0, r1				# mr	r5, r1
	add	r29, r0, r6				# mr	r29, r6
	add	r1, r0, r8				# mr	r1, r8
	lw	r28, 0(r29)
	jr	r28
setup_rect_table.3073:
	addi	r5, r0, 6
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	flw	f1, 0(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13564
	addi	r5, r0, 1
	j	feq_cont.13565
feq_else.13564:
	addi	r5, r0, 0
feq_cont.13565:
	beqi	0, r5, beq_then.13566
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 1(r1)
	j	beq_cont.13567
beq_then.13566:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13568
	addi	r7, r0, 0
	j	fle_cont.13569
fle_else.13568:
	addi	r7, r0, 1
fle_cont.13569:
	beqi	0, r6, beq_then.13570
	beqi	0, r7, beq_then.13572
	addi	r6, r0, 0
	j	beq_cont.13573
beq_then.13572:
	addi	r6, r0, 1
beq_cont.13573:
	j	beq_cont.13571
beq_then.13570:
	add	r6, r0, r7
beq_cont.13571:
	lw	r7, 4(r5)
	flw	f1, 0(r7)
	beqi	0, r6, beq_then.13574
	j	beq_cont.13575
beq_then.13574:
	fneg	f1, f1
beq_cont.13575:
	fsw	f1, 0(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r2)
	fdiv	f1, f1, f2
	fsw	f1, 1(r1)
beq_cont.13567:
	flw	f1, 1(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13576
	addi	r5, r0, 1
	j	feq_cont.13577
feq_else.13576:
	addi	r5, r0, 0
feq_cont.13577:
	beqi	0, r5, beq_then.13578
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 3(r1)
	j	beq_cont.13579
beq_then.13578:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 1(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13580
	addi	r7, r0, 0
	j	fle_cont.13581
fle_else.13580:
	addi	r7, r0, 1
fle_cont.13581:
	beqi	0, r6, beq_then.13582
	beqi	0, r7, beq_then.13584
	addi	r6, r0, 0
	j	beq_cont.13585
beq_then.13584:
	addi	r6, r0, 1
beq_cont.13585:
	j	beq_cont.13583
beq_then.13582:
	add	r6, r0, r7
beq_cont.13583:
	lw	r7, 4(r5)
	flw	f1, 1(r7)
	beqi	0, r6, beq_then.13586
	j	beq_cont.13587
beq_then.13586:
	fneg	f1, f1
beq_cont.13587:
	fsw	f1, 2(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 1(r2)
	fdiv	f1, f1, f2
	fsw	f1, 3(r1)
beq_cont.13579:
	flw	f1, 2(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13588
	addi	r5, r0, 1
	j	feq_cont.13589
feq_else.13588:
	addi	r5, r0, 0
feq_cont.13589:
	beqi	0, r5, beq_then.13590
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 5(r1)
	j	beq_cont.13591
beq_then.13590:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 2(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13592
	addi	r7, r0, 0
	j	fle_cont.13593
fle_else.13592:
	addi	r7, r0, 1
fle_cont.13593:
	beqi	0, r6, beq_then.13594
	beqi	0, r7, beq_then.13596
	addi	r6, r0, 0
	j	beq_cont.13597
beq_then.13596:
	addi	r6, r0, 1
beq_cont.13597:
	j	beq_cont.13595
beq_then.13594:
	add	r6, r0, r7
beq_cont.13595:
	lw	r5, 4(r5)
	flw	f1, 2(r5)
	beqi	0, r6, beq_then.13598
	j	beq_cont.13599
beq_then.13598:
	fneg	f1, f1
beq_cont.13599:
	fsw	f1, 4(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 2(r2)
	fdiv	f1, f1, f2
	fsw	f1, 5(r1)
beq_cont.13591:
	jr	r31				#
setup_surface_table.3076:
	addi	r5, r0, 4
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	flw	f1, 0(r2)
	lw	r5, 0(r3)
	lw	r6, 4(r5)
	flw	f2, 0(r6)
	fmul	f1, f1, f2
	flw	f2, 1(r2)
	lw	r6, 4(r5)
	flw	f3, 1(r6)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r2)
	lw	r2, 4(r5)
	flw	f3, 2(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13600
	addi	r2, r0, 0
	j	fle_cont.13601
fle_else.13600:
	addi	r2, r0, 1
fle_cont.13601:
	beqi	0, r2, beq_then.13602
	flup	f2, 11		# fli	f2, -1.000000
	fdiv	f2, f2, f1
	fsw	f2, 0(r1)
	lw	r2, 4(r5)
	flw	f2, 0(r2)
	fdiv	f2, f2, f1
	fneg	f2, f2
	fsw	f2, 1(r1)
	lw	r2, 4(r5)
	flw	f2, 1(r2)
	fdiv	f2, f2, f1
	fneg	f2, f2
	fsw	f2, 2(r1)
	lw	r2, 4(r5)
	flw	f2, 2(r2)
	fdiv	f1, f2, f1
	fneg	f1, f1
	fsw	f1, 3(r1)
	j	beq_cont.13603
beq_then.13602:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
beq_cont.13603:
	jr	r31				#
setup_second_table.3079:
	addi	r5, r0, 5
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	flw	f1, 0(r2)
	flw	f2, 1(r2)
	flw	f3, 2(r2)
	lw	r5, 0(r3)
	sw	r1, 2(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	quadratic.3010				#	bl	quadratic.3010
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	lw	r2, 0(r3)
	lw	r5, 4(r2)
	flw	f3, 0(r5)
	fmul	f2, f2, f3
	fneg	f2, f2
	flw	f3, 1(r1)
	lw	r5, 4(r2)
	flw	f4, 1(r5)
	fmul	f3, f3, f4
	fneg	f3, f3
	flw	f4, 2(r1)
	lw	r5, 4(r2)
	flw	f5, 2(r5)
	fmul	f4, f4, f5
	fneg	f4, f4
	lw	r5, 2(r3)
	fsw	f1, 0(r5)
	lw	r6, 3(r2)
	beqi	0, r6, beq_then.13604
	flw	f5, 2(r1)
	lw	r6, 9(r2)
	flw	f6, 1(r6)
	fmul	f5, f5, f6
	flw	f6, 1(r1)
	lw	r6, 9(r2)
	flw	f7, 2(r6)
	fmul	f6, f6, f7
	fadd	f5, f5, f6
	flup	f6, 1		# fli	f6, 0.500000
	fmul	f5, f5, f6
	fsub	f2, f2, f5
	fsw	f2, 1(r5)
	flw	f2, 2(r1)
	lw	r6, 9(r2)
	flw	f5, 0(r6)
	fmul	f2, f2, f5
	flw	f5, 0(r1)
	lw	r6, 9(r2)
	flw	f6, 2(r6)
	fmul	f5, f5, f6
	fadd	f2, f2, f5
	flup	f5, 1		# fli	f5, 0.500000
	fmul	f2, f2, f5
	fsub	f2, f3, f2
	fsw	f2, 2(r5)
	flw	f2, 1(r1)
	lw	r6, 9(r2)
	flw	f3, 0(r6)
	fmul	f2, f2, f3
	flw	f3, 0(r1)
	lw	r1, 9(r2)
	flw	f5, 1(r1)
	fmul	f3, f3, f5
	fadd	f2, f2, f3
	flup	f3, 1		# fli	f3, 0.500000
	fmul	f2, f2, f3
	fsub	f2, f4, f2
	fsw	f2, 3(r5)
	j	beq_cont.13605
beq_then.13604:
	fsw	f2, 1(r5)
	fsw	f3, 2(r5)
	fsw	f4, 3(r5)
beq_cont.13605:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13606
	addi	r1, r0, 1
	j	feq_cont.13607
feq_else.13606:
	addi	r1, r0, 0
feq_cont.13607:
	beqi	0, r1, beq_then.13608
	j	beq_cont.13609
beq_then.13608:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
	fsw	f1, 4(r5)
beq_cont.13609:
	add	r1, r0, r5
	jr	r31				#
iter_setup_dirvec_constants.3082:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.13610
	jr	r31				#
ble_then.13610:
	add	r30, r5, r2
	lw	r6, 0(r30)
	lw	r7, 1(r1)
	lw	r8, 0(r1)
	lw	r9, 1(r6)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	beqi	1, r9, beq_then.13612
	beqi	2, r9, beq_then.13614
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3079				#	bl	setup_second_table.3079
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.13615
beq_then.13614:
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3076				#	bl	setup_surface_table.3076
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.13615:
	j	beq_cont.13613
beq_then.13612:
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3073				#	bl	setup_rect_table.3073
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.13613:
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13616
	jr	r31				#
ble_then.13616:
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 1(r3)
	lw	r6, 1(r5)
	lw	r7, 0(r5)
	lw	r8, 1(r2)
	beqi	1, r8, beq_then.13618
	beqi	2, r8, beq_then.13620
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_second_table.3079				#	bl	setup_second_table.3079
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.13621
beq_then.13620:
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_surface_table.3076				#	bl	setup_surface_table.3076
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.13621:
	j	beq_cont.13619
beq_then.13618:
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_rect_table.3073				#	bl	setup_rect_table.3073
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.13619:
	addi	r2, r2, -1
	lw	r1, 1(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
setup_dirvec_constants.3085:
	lw	r2, 3(r29)
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	lw	r5, 0(r5)
	addi	r5, r5, -1
	addi	r7, r0, 0
	ble	r7, r5, ble_then.13622
	jr	r31				#
ble_then.13622:
	add	r30, r2, r5
	lw	r2, 0(r30)
	lw	r7, 1(r1)
	lw	r8, 0(r1)
	lw	r9, 1(r2)
	sw	r1, 0(r3)
	sw	r6, 1(r3)
	beqi	1, r9, beq_then.13624
	beqi	2, r9, beq_then.13626
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	setup_second_table.3079				#	bl	setup_second_table.3079
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.13627
beq_then.13626:
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	setup_surface_table.3076				#	bl	setup_surface_table.3076
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.13627:
	j	beq_cont.13625
beq_then.13624:
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	setup_rect_table.3073				#	bl	setup_rect_table.3073
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.13625:
	addi	r2, r2, -1
	lw	r1, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
setup_startp_constants.3087:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.13628
	jr	r31				#
ble_then.13628:
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 10(r5)
	lw	r7, 1(r5)
	flw	f1, 0(r1)
	lw	r8, 5(r5)
	flw	f2, 0(r8)
	fsub	f1, f1, f2
	fsw	f1, 0(r6)
	flw	f1, 1(r1)
	lw	r8, 5(r5)
	flw	f2, 1(r8)
	fsub	f1, f1, f2
	fsw	f1, 1(r6)
	flw	f1, 2(r1)
	lw	r8, 5(r5)
	flw	f2, 2(r8)
	fsub	f1, f1, f2
	fsw	f1, 2(r6)
	sw	r1, 0(r3)
	sw	r29, 1(r3)
	sw	r2, 2(r3)
	beqi	2, r7, beq_then.13630
	blei	2, r7, ble_then.13632
	flw	f1, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 2(r6)
	sw	r6, 3(r3)
	sw	r7, 4(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	quadratic.3010				#	bl	quadratic.3010
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	beqi	3, r1, beq_then.13634
	j	beq_cont.13635
beq_then.13634:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.13635:
	lw	r1, 3(r3)
	fsw	f1, 3(r1)
	j	ble_cont.13633
ble_then.13632:
ble_cont.13633:
	j	beq_cont.13631
beq_then.13630:
	lw	r5, 4(r5)
	flw	f1, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 2(r6)
	flw	f4, 0(r5)
	fmul	f1, f4, f1
	flw	f4, 1(r5)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 2(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 3(r6)
beq_cont.13631:
	lw	r1, 2(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
setup_startp.3090:
	lw	r2, 3(r29)
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	flw	f1, 0(r1)
	fsw	f1, 0(r2)
	flw	f1, 1(r1)
	fsw	f1, 1(r2)
	flw	f1, 2(r1)
	fsw	f1, 2(r2)
	lw	r2, 0(r6)
	addi	r2, r2, -1
	add	r29, r0, r5				# mr	r29, r5
	lw	r28, 0(r29)
	jr	r28
is_rect_outside.3092:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13636
	j	fle_cont.13637
fle_else.13636:
	fneg	f1, f1
fle_cont.13637:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.13638
	addi	r2, r0, 0
	j	fle_cont.13639
fle_else.13638:
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.13640
	j	fle_cont.13641
fle_else.13640:
	fneg	f2, f2
fle_cont.13641:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13642
	addi	r2, r0, 0
	j	fle_cont.13643
fle_else.13642:
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.13644
	fadd	f2, f0, f3
	j	fle_cont.13645
fle_else.13644:
	fneg	f2, f3
fle_cont.13645:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13646
	addi	r2, r0, 0
	j	fle_cont.13647
fle_else.13646:
	addi	r2, r0, 1
fle_cont.13647:
fle_cont.13643:
fle_cont.13639:
	beqi	0, r2, beq_then.13648
	lw	r1, 6(r1)
	jr	r31				#
beq_then.13648:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.13649
	addi	r1, r0, 0
	jr	r31				#
beq_then.13649:
	addi	r1, r0, 1
	jr	r31				#
is_plane_outside.3097:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fmul	f1, f4, f1
	flw	f4, 1(r2)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 2(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13650
	addi	r2, r0, 0
	j	fle_cont.13651
fle_else.13650:
	addi	r2, r0, 1
fle_cont.13651:
	beqi	0, r1, beq_then.13652
	beqi	0, r2, beq_then.13654
	addi	r1, r0, 0
	j	beq_cont.13655
beq_then.13654:
	addi	r1, r0, 1
beq_cont.13655:
	j	beq_cont.13653
beq_then.13652:
	add	r1, r0, r2
beq_cont.13653:
	beqi	0, r1, beq_then.13656
	addi	r1, r0, 0
	jr	r31				#
beq_then.13656:
	addi	r1, r0, 1
	jr	r31				#
is_second_outside.3102:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3010				#	bl	quadratic.3010
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.13657
	j	beq_cont.13658
beq_then.13657:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.13658:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13659
	addi	r2, r0, 0
	j	fle_cont.13660
fle_else.13659:
	addi	r2, r0, 1
fle_cont.13660:
	beqi	0, r1, beq_then.13661
	beqi	0, r2, beq_then.13663
	addi	r1, r0, 0
	j	beq_cont.13664
beq_then.13663:
	addi	r1, r0, 1
beq_cont.13664:
	j	beq_cont.13662
beq_then.13661:
	add	r1, r0, r2
beq_cont.13662:
	beqi	0, r1, beq_then.13665
	addi	r1, r0, 0
	jr	r31				#
beq_then.13665:
	addi	r1, r0, 1
	jr	r31				#
is_outside.3107:
	lw	r2, 5(r1)
	flw	f4, 0(r2)
	fsub	f1, f1, f4
	lw	r2, 5(r1)
	flw	f4, 1(r2)
	fsub	f2, f2, f4
	lw	r2, 5(r1)
	flw	f4, 2(r2)
	fsub	f3, f3, f4
	lw	r2, 1(r1)
	beqi	1, r2, beq_then.13666
	beqi	2, r2, beq_then.13667
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3010				#	bl	quadratic.3010
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.13668
	j	beq_cont.13669
beq_then.13668:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.13669:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13670
	addi	r2, r0, 0
	j	fle_cont.13671
fle_else.13670:
	addi	r2, r0, 1
fle_cont.13671:
	beqi	0, r1, beq_then.13672
	beqi	0, r2, beq_then.13674
	addi	r1, r0, 0
	j	beq_cont.13675
beq_then.13674:
	addi	r1, r0, 1
beq_cont.13675:
	j	beq_cont.13673
beq_then.13672:
	add	r1, r0, r2
beq_cont.13673:
	beqi	0, r1, beq_then.13676
	addi	r1, r0, 0
	jr	r31				#
beq_then.13676:
	addi	r1, r0, 1
	jr	r31				#
beq_then.13667:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fmul	f1, f4, f1
	flw	f4, 1(r2)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 2(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13677
	addi	r2, r0, 0
	j	fle_cont.13678
fle_else.13677:
	addi	r2, r0, 1
fle_cont.13678:
	beqi	0, r1, beq_then.13679
	beqi	0, r2, beq_then.13681
	addi	r1, r0, 0
	j	beq_cont.13682
beq_then.13681:
	addi	r1, r0, 1
beq_cont.13682:
	j	beq_cont.13680
beq_then.13679:
	add	r1, r0, r2
beq_cont.13680:
	beqi	0, r1, beq_then.13683
	addi	r1, r0, 0
	jr	r31				#
beq_then.13683:
	addi	r1, r0, 1
	jr	r31				#
beq_then.13666:
	j	is_rect_outside.3092
check_all_inside.3112:
	lw	r5, 1(r29)
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.13684
	add	r30, r5, r6
	lw	r6, 0(r30)
	lw	r7, 5(r6)
	flw	f4, 0(r7)
	fsub	f4, f1, f4
	lw	r7, 5(r6)
	flw	f5, 1(r7)
	fsub	f5, f2, f5
	lw	r7, 5(r6)
	flw	f6, 2(r7)
	fsub	f6, f3, f6
	lw	r7, 1(r6)
	sw	r29, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	fsw	f1, 6(r3)
	sw	r5, 8(r3)
	sw	r2, 9(r3)
	sw	r1, 10(r3)
	beqi	1, r7, beq_then.13686
	beqi	2, r7, beq_then.13688
	add	r1, r0, r6				# mr	r1, r6
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	is_second_outside.3102				#	bl	is_second_outside.3102
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.13689
beq_then.13688:
	add	r1, r0, r6				# mr	r1, r6
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	is_plane_outside.3097				#	bl	is_plane_outside.3097
	addi	r3, r3, -12
	lw	r31, 11(r3)
beq_cont.13689:
	j	beq_cont.13687
beq_then.13686:
	add	r1, r0, r6				# mr	r1, r6
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	is_rect_outside.3092				#	bl	is_rect_outside.3092
	addi	r3, r3, -12
	lw	r31, 11(r3)
beq_cont.13687:
	beqi	0, r1, beq_then.13690
	addi	r1, r0, 0
	jr	r31				#
beq_then.13690:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.13691
	lw	r6, 8(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	flw	f1, 6(r3)
	flw	f2, 4(r3)
	flw	f3, 2(r3)
	sw	r1, 11(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	is_outside.3107				#	bl	is_outside.3107
	addi	r3, r3, -13
	lw	r31, 12(r3)
	beqi	0, r1, beq_then.13692
	addi	r1, r0, 0
	jr	r31				#
beq_then.13692:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	flw	f1, 6(r3)
	flw	f2, 4(r3)
	flw	f3, 2(r3)
	lw	r2, 9(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13691:
	addi	r1, r0, 1
	jr	r31				#
beq_then.13684:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3118:
	lw	r5, 7(r29)
	lw	r6, 6(r29)
	lw	r7, 5(r29)
	lw	r8, 4(r29)
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	add	r30, r2, r1
	lw	r12, 0(r30)
	beqi	-1, r12, beq_then.13693
	add	r30, r2, r1
	lw	r12, 0(r30)
	sw	r11, 0(r3)
	sw	r10, 1(r3)
	sw	r9, 2(r3)
	sw	r2, 3(r3)
	sw	r29, 4(r3)
	sw	r1, 5(r3)
	sw	r12, 6(r3)
	sw	r7, 7(r3)
	sw	r6, 8(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r12				# mr	r1, r12
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r10				# mr	r5, r10
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 8(r3)
	flw	f1, 0(r2)
	beqi	0, r1, beq_then.13694
	flup	f2, 28		# fli	f2, -0.200000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13696
	addi	r1, r0, 0
	j	fle_cont.13697
fle_else.13696:
	addi	r1, r0, 1
fle_cont.13697:
	j	beq_cont.13695
beq_then.13694:
	addi	r1, r0, 0
beq_cont.13695:
	beqi	0, r1, beq_then.13698
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
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
	lw	r2, 3(r3)
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.13699
	lw	r5, 7(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	fsw	f1, 10(r3)
	fsw	f3, 12(r3)
	fsw	f2, 14(r3)
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	is_outside.3107				#	bl	is_outside.3107
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.13702
	addi	r1, r0, 0
	j	beq_cont.13703
beq_then.13702:
	addi	r1, r0, 1
	flw	f1, 14(r3)
	flw	f2, 12(r3)
	flw	f3, 10(r3)
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
beq_cont.13703:
	j	beq_cont.13700
beq_then.13699:
	addi	r1, r0, 1
beq_cont.13700:
	beqi	0, r1, beq_then.13704
	addi	r1, r0, 1
	jr	r31				#
beq_then.13704:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13698:
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.13705
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13705:
	addi	r1, r0, 0
	jr	r31				#
beq_then.13693:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3121:
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.13706
	add	r30, r6, r7
	lw	r7, 0(r30)
	addi	r8, r0, 0
	sw	r29, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	add	r29, r0, r5				# mr	r29, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.13707
	addi	r1, r0, 1
	jr	r31				#
beq_then.13707:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.13708
	lw	r6, 2(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r29, 1(r3)
	sw	r1, 5(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.13709
	addi	r1, r0, 1
	jr	r31				#
beq_then.13709:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13708:
	addi	r1, r0, 0
	jr	r31				#
beq_then.13706:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3124:
	lw	r5, 7(r29)
	lw	r6, 6(r29)
	lw	r7, 5(r29)
	lw	r8, 4(r29)
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	add	r30, r2, r1
	lw	r12, 0(r30)
	lw	r13, 0(r12)
	beqi	-1, r13, beq_then.13710
	addi	r14, r0, 99
	sw	r7, 0(r3)
	sw	r8, 1(r3)
	sw	r11, 2(r3)
	sw	r12, 3(r3)
	sw	r2, 4(r3)
	sw	r29, 5(r3)
	sw	r1, 6(r3)
	beq	r13, r14, beq_then.13711
	sw	r6, 7(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r13				# mr	r1, r13
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r10				# mr	r5, r10
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.13713
	flup	f1, 30		# fli	f1, -0.100000
	lw	r1, 7(r3)
	flw	f2, 0(r1)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13715
	addi	r1, r0, 0
	j	fle_cont.13716
fle_else.13715:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.13717
	lw	r5, 2(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r29, 1(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.13719
	addi	r1, r0, 1
	j	beq_cont.13720
beq_then.13719:
	addi	r1, r0, 2
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.13720:
	j	beq_cont.13718
beq_then.13717:
	addi	r1, r0, 0
beq_cont.13718:
	beqi	0, r1, beq_then.13721
	addi	r1, r0, 1
	j	beq_cont.13722
beq_then.13721:
	addi	r1, r0, 0
beq_cont.13722:
fle_cont.13716:
	j	beq_cont.13714
beq_then.13713:
	addi	r1, r0, 0
beq_cont.13714:
	j	beq_cont.13712
beq_then.13711:
	addi	r1, r0, 1
beq_cont.13712:
	beqi	0, r1, beq_then.13723
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.13724
	lw	r5, 2(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r29, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.13726
	addi	r1, r0, 1
	j	beq_cont.13727
beq_then.13726:
	addi	r1, r0, 2
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.13727:
	j	beq_cont.13725
beq_then.13724:
	addi	r1, r0, 0
beq_cont.13725:
	beqi	0, r1, beq_then.13728
	addi	r1, r0, 1
	jr	r31				#
beq_then.13728:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r29, 5(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13723:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r29, 5(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13710:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3127:
	lw	r6, 9(r29)
	lw	r7, 8(r29)
	lw	r8, 7(r29)
	lw	r9, 6(r29)
	lw	r10, 5(r29)
	lw	r11, 4(r29)
	lw	r12, 3(r29)
	lw	r13, 2(r29)
	lw	r14, 1(r29)
	add	r30, r2, r1
	lw	r15, 0(r30)
	beqi	-1, r15, beq_then.13729
	sw	r11, 0(r3)
	sw	r13, 1(r3)
	sw	r12, 2(r3)
	sw	r14, 3(r3)
	sw	r7, 4(r3)
	sw	r6, 5(r3)
	sw	r8, 6(r3)
	sw	r5, 7(r3)
	sw	r2, 8(r3)
	sw	r29, 9(r3)
	sw	r1, 10(r3)
	sw	r15, 11(r3)
	sw	r10, 12(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r9				# mr	r29, r9
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.13730
	lw	r2, 6(r3)
	flw	f1, 0(r2)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13731
	j	fle_cont.13732
fle_else.13731:
	lw	r2, 5(r3)
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13733
	j	fle_cont.13734
fle_else.13733:
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	lw	r5, 7(r3)
	flw	f2, 0(r5)
	fmul	f2, f2, f1
	lw	r6, 4(r3)
	flw	f3, 0(r6)
	fadd	f2, f2, f3
	flw	f3, 1(r5)
	fmul	f3, f3, f1
	flw	f4, 1(r6)
	fadd	f3, f3, f4
	flw	f4, 2(r5)
	fmul	f4, f4, f1
	flw	f5, 2(r6)
	fadd	f4, f4, f5
	lw	r6, 8(r3)
	lw	r7, 0(r6)
	sw	r1, 13(r3)
	fsw	f4, 14(r3)
	fsw	f3, 16(r3)
	fsw	f2, 18(r3)
	fsw	f1, 20(r3)
	beqi	-1, r7, beq_then.13735
	lw	r8, 12(r3)
	add	r30, r8, r7
	lw	r7, 0(r30)
	add	r1, r0, r7				# mr	r1, r7
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	is_outside.3107				#	bl	is_outside.3107
	addi	r3, r3, -23
	lw	r31, 22(r3)
	beqi	0, r1, beq_then.13737
	addi	r1, r0, 0
	j	beq_cont.13738
beq_then.13737:
	addi	r1, r0, 1
	flw	f1, 18(r3)
	flw	f2, 16(r3)
	flw	f3, 14(r3)
	lw	r2, 8(r3)
	lw	r29, 3(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
beq_cont.13738:
	j	beq_cont.13736
beq_then.13735:
	addi	r1, r0, 1
beq_cont.13736:
	beqi	0, r1, beq_then.13739
	lw	r1, 5(r3)
	flw	f1, 20(r3)
	fsw	f1, 0(r1)
	lw	r1, 2(r3)
	flw	f1, 18(r3)
	fsw	f1, 0(r1)
	flw	f1, 16(r3)
	fsw	f1, 1(r1)
	flw	f1, 14(r3)
	fsw	f1, 2(r1)
	lw	r1, 1(r3)
	lw	r2, 11(r3)
	sw	r2, 0(r1)
	lw	r1, 0(r3)
	lw	r2, 13(r3)
	sw	r2, 0(r1)
	j	beq_cont.13740
beq_then.13739:
beq_cont.13740:
fle_cont.13734:
fle_cont.13732:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r29, 9(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13730:
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.13741
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r29, 9(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13741:
	jr	r31				#
beq_then.13729:
	jr	r31				#
solve_one_or_network.3131:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.13744
	add	r30, r7, r8
	lw	r8, 0(r30)
	addi	r9, r0, 0
	sw	r29, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r9				# mr	r1, r9
	add	r29, r0, r6				# mr	r29, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.13745
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 1(r3)
	lw	r29, 2(r3)
	sw	r1, 6(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r5, 1(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13745:
	jr	r31				#
beq_then.13744:
	jr	r31				#
trace_or_matrix.3135:
	lw	r6, 7(r29)
	lw	r7, 6(r29)
	lw	r8, 5(r29)
	lw	r9, 4(r29)
	lw	r10, 3(r29)
	lw	r11, 2(r29)
	lw	r12, 1(r29)
	add	r30, r2, r1
	lw	r13, 0(r30)
	lw	r14, 0(r13)
	beqi	-1, r14, beq_then.13748
	addi	r15, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r29, 2(r3)
	sw	r1, 3(r3)
	beq	r14, r15, beq_then.13749
	sw	r10, 4(r3)
	sw	r11, 5(r3)
	sw	r12, 6(r3)
	sw	r13, 7(r3)
	sw	r6, 8(r3)
	sw	r8, 9(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r14				# mr	r1, r14
	add	r29, r0, r9				# mr	r29, r9
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.13751
	lw	r1, 9(r3)
	flw	f1, 0(r1)
	lw	r1, 8(r3)
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13753
	j	fle_cont.13754
fle_else.13753:
	lw	r1, 7(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.13755
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	lw	r29, 5(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r1, r0, 2
	lw	r2, 7(r3)
	lw	r5, 0(r3)
	lw	r29, 4(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.13756
beq_then.13755:
beq_cont.13756:
fle_cont.13754:
	j	beq_cont.13752
beq_then.13751:
beq_cont.13752:
	j	beq_cont.13750
beq_then.13749:
	lw	r6, 1(r13)
	beqi	-1, r6, beq_then.13757
	add	r30, r12, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r13, 7(r3)
	sw	r10, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	add	r29, r0, r11				# mr	r29, r11
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r1, r0, 2
	lw	r2, 7(r3)
	lw	r5, 0(r3)
	lw	r29, 4(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.13758
beq_then.13757:
beq_cont.13758:
beq_cont.13750:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13748:
	jr	r31				#
judge_intersection.3139:
	lw	r2, 3(r29)
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r5)
	addi	r7, r0, 0
	lw	r6, 0(r6)
	sw	r5, 0(r3)
	add	r5, r0, r1				# mr	r5, r1
	add	r29, r0, r2				# mr	r29, r2
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 1(r3)
	addi	r3, r3, 2
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13760
	addi	r1, r0, 0
	jr	r31				#
fle_else.13760:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13761
	addi	r1, r0, 0
	jr	r31				#
fle_else.13761:
	addi	r1, r0, 1
	jr	r31				#
solve_each_element_fast.3141:
	lw	r6, 9(r29)
	lw	r7, 8(r29)
	lw	r8, 7(r29)
	lw	r9, 6(r29)
	lw	r10, 5(r29)
	lw	r11, 4(r29)
	lw	r12, 3(r29)
	lw	r13, 2(r29)
	lw	r14, 1(r29)
	lw	r15, 0(r5)
	add	r30, r2, r1
	lw	r16, 0(r30)
	beqi	-1, r16, beq_then.13762
	sw	r11, 0(r3)
	sw	r13, 1(r3)
	sw	r12, 2(r3)
	sw	r14, 3(r3)
	sw	r7, 4(r3)
	sw	r15, 5(r3)
	sw	r6, 6(r3)
	sw	r9, 7(r3)
	sw	r5, 8(r3)
	sw	r2, 9(r3)
	sw	r29, 10(r3)
	sw	r1, 11(r3)
	sw	r16, 12(r3)
	sw	r10, 13(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r16				# mr	r1, r16
	add	r29, r0, r8				# mr	r29, r8
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.13763
	lw	r2, 7(r3)
	flw	f1, 0(r2)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13764
	j	fle_cont.13765
fle_else.13764:
	lw	r2, 6(r3)
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13766
	j	fle_cont.13767
fle_else.13766:
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	lw	r5, 5(r3)
	flw	f2, 0(r5)
	fmul	f2, f2, f1
	lw	r6, 4(r3)
	flw	f3, 0(r6)
	fadd	f2, f2, f3
	flw	f3, 1(r5)
	fmul	f3, f3, f1
	flw	f4, 1(r6)
	fadd	f3, f3, f4
	flw	f4, 2(r5)
	fmul	f4, f4, f1
	flw	f5, 2(r6)
	fadd	f4, f4, f5
	lw	r5, 9(r3)
	lw	r6, 0(r5)
	sw	r1, 14(r3)
	fsw	f4, 16(r3)
	fsw	f3, 18(r3)
	fsw	f2, 20(r3)
	fsw	f1, 22(r3)
	beqi	-1, r6, beq_then.13769
	lw	r7, 13(r3)
	add	r30, r7, r6
	lw	r6, 0(r30)
	add	r1, r0, r6				# mr	r1, r6
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	is_outside.3107				#	bl	is_outside.3107
	addi	r3, r3, -25
	lw	r31, 24(r3)
	beqi	0, r1, beq_then.13771
	addi	r1, r0, 0
	j	beq_cont.13772
beq_then.13771:
	addi	r1, r0, 1
	flw	f1, 20(r3)
	flw	f2, 18(r3)
	flw	f3, 16(r3)
	lw	r2, 9(r3)
	lw	r29, 3(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -25
	lw	r31, 24(r3)
beq_cont.13772:
	j	beq_cont.13770
beq_then.13769:
	addi	r1, r0, 1
beq_cont.13770:
	beqi	0, r1, beq_then.13773
	lw	r1, 6(r3)
	flw	f1, 22(r3)
	fsw	f1, 0(r1)
	lw	r1, 2(r3)
	flw	f1, 20(r3)
	fsw	f1, 0(r1)
	flw	f1, 18(r3)
	fsw	f1, 1(r1)
	flw	f1, 16(r3)
	fsw	f1, 2(r1)
	lw	r1, 1(r3)
	lw	r2, 12(r3)
	sw	r2, 0(r1)
	lw	r1, 0(r3)
	lw	r2, 14(r3)
	sw	r2, 0(r1)
	j	beq_cont.13774
beq_then.13773:
beq_cont.13774:
fle_cont.13767:
fle_cont.13765:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r29, 10(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13763:
	lw	r1, 12(r3)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.13775
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r29, 10(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13775:
	jr	r31				#
beq_then.13762:
	jr	r31				#
solve_one_or_network_fast.3145:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.13778
	add	r30, r7, r8
	lw	r8, 0(r30)
	addi	r9, r0, 0
	sw	r29, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r9				# mr	r1, r9
	add	r29, r0, r6				# mr	r29, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.13779
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 1(r3)
	lw	r29, 2(r3)
	sw	r1, 6(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r5, 1(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13779:
	jr	r31				#
beq_then.13778:
	jr	r31				#
trace_or_matrix_fast.3149:
	lw	r6, 6(r29)
	lw	r7, 5(r29)
	lw	r8, 4(r29)
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	add	r30, r2, r1
	lw	r12, 0(r30)
	lw	r13, 0(r12)
	beqi	-1, r13, beq_then.13782
	addi	r14, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r29, 2(r3)
	sw	r1, 3(r3)
	beq	r13, r14, beq_then.13783
	sw	r9, 4(r3)
	sw	r10, 5(r3)
	sw	r11, 6(r3)
	sw	r12, 7(r3)
	sw	r6, 8(r3)
	sw	r8, 9(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r13				# mr	r1, r13
	add	r29, r0, r7				# mr	r29, r7
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.13785
	lw	r1, 9(r3)
	flw	f1, 0(r1)
	lw	r1, 8(r3)
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13787
	j	fle_cont.13788
fle_else.13787:
	lw	r1, 7(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.13789
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	lw	r29, 5(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r1, r0, 2
	lw	r2, 7(r3)
	lw	r5, 0(r3)
	lw	r29, 4(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.13790
beq_then.13789:
beq_cont.13790:
fle_cont.13788:
	j	beq_cont.13786
beq_then.13785:
beq_cont.13786:
	j	beq_cont.13784
beq_then.13783:
	lw	r6, 1(r12)
	beqi	-1, r6, beq_then.13791
	add	r30, r11, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r12, 7(r3)
	sw	r9, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	add	r29, r0, r10				# mr	r29, r10
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r1, r0, 2
	lw	r2, 7(r3)
	lw	r5, 0(r3)
	lw	r29, 4(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.13792
beq_then.13791:
beq_cont.13792:
beq_cont.13784:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13782:
	jr	r31				#
judge_intersection_fast.3153:
	lw	r2, 3(r29)
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r5)
	addi	r7, r0, 0
	lw	r6, 0(r6)
	sw	r5, 0(r3)
	add	r5, r0, r1				# mr	r5, r1
	add	r29, r0, r2				# mr	r29, r2
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 1(r3)
	addi	r3, r3, 2
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13794
	addi	r1, r0, 0
	jr	r31				#
fle_else.13794:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13795
	addi	r1, r0, 0
	jr	r31				#
fle_else.13795:
	addi	r1, r0, 1
	jr	r31				#
get_nvector_rect.3155:
	lw	r2, 2(r29)
	lw	r5, 1(r29)
	lw	r5, 0(r5)
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r2)
	fsw	f1, 1(r2)
	fsw	f1, 2(r2)
	addi	r6, r5, -1
	addi	r5, r5, -1
	add	r30, r1, r5
	flw	f1, 0(r30)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13796
	addi	r1, r0, 1
	j	feq_cont.13797
feq_else.13796:
	addi	r1, r0, 0
feq_cont.13797:
	beqi	0, r1, beq_then.13798
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.13799
beq_then.13798:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13800
	addi	r1, r0, 0
	j	fle_cont.13801
fle_else.13800:
	addi	r1, r0, 1
fle_cont.13801:
	beqi	0, r1, beq_then.13802
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.13803
beq_then.13802:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.13803:
beq_cont.13799:
	fneg	f1, f1
	add	r30, r2, r6
	fsw	f1, 0(r30)
	jr	r31				#
get_nvector_plane.3157:
	lw	r2, 1(r29)
	lw	r5, 4(r1)
	flw	f1, 0(r5)
	fneg	f1, f1
	fsw	f1, 0(r2)
	lw	r5, 4(r1)
	flw	f1, 1(r5)
	fneg	f1, f1
	fsw	f1, 1(r2)
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	fneg	f1, f1
	fsw	f1, 2(r2)
	jr	r31				#
get_nvector_second.3159:
	lw	r2, 2(r29)
	lw	r5, 1(r29)
	flw	f1, 0(r5)
	lw	r6, 5(r1)
	flw	f2, 0(r6)
	fsub	f1, f1, f2
	flw	f2, 1(r5)
	lw	r6, 5(r1)
	flw	f3, 1(r6)
	fsub	f2, f2, f3
	flw	f3, 2(r5)
	lw	r5, 5(r1)
	flw	f4, 2(r5)
	fsub	f3, f3, f4
	lw	r5, 4(r1)
	flw	f4, 0(r5)
	fmul	f4, f1, f4
	lw	r5, 4(r1)
	flw	f5, 1(r5)
	fmul	f5, f2, f5
	lw	r5, 4(r1)
	flw	f6, 2(r5)
	fmul	f6, f3, f6
	lw	r5, 3(r1)
	beqi	0, r5, beq_then.13806
	lw	r5, 9(r1)
	flw	f7, 2(r5)
	fmul	f7, f2, f7
	lw	r5, 9(r1)
	flw	f8, 1(r5)
	fmul	f8, f3, f8
	fadd	f7, f7, f8
	flup	f8, 1		# fli	f8, 0.500000
	fmul	f7, f7, f8
	fadd	f4, f4, f7
	fsw	f4, 0(r2)
	lw	r5, 9(r1)
	flw	f4, 2(r5)
	fmul	f4, f1, f4
	lw	r5, 9(r1)
	flw	f7, 0(r5)
	fmul	f3, f3, f7
	fadd	f3, f4, f3
	flup	f4, 1		# fli	f4, 0.500000
	fmul	f3, f3, f4
	fadd	f3, f5, f3
	fsw	f3, 1(r2)
	lw	r5, 9(r1)
	flw	f3, 1(r5)
	fmul	f1, f1, f3
	lw	r5, 9(r1)
	flw	f3, 0(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flup	f2, 1		# fli	f2, 0.500000
	fmul	f1, f1, f2
	fadd	f1, f6, f1
	fsw	f1, 2(r2)
	j	beq_cont.13807
beq_then.13806:
	fsw	f4, 0(r2)
	fsw	f5, 1(r2)
	fsw	f6, 2(r2)
beq_cont.13807:
	lw	r1, 6(r1)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	vecunit_sgn.2867
get_nvector.3161:
	lw	r5, 3(r29)
	lw	r6, 2(r29)
	lw	r29, 1(r29)
	lw	r7, 1(r1)
	beqi	1, r7, beq_then.13808
	beqi	2, r7, beq_then.13809
	lw	r28, 0(r29)
	jr	r28
beq_then.13809:
	lw	r2, 4(r1)
	flw	f1, 0(r2)
	fneg	f1, f1
	fsw	f1, 0(r5)
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fneg	f1, f1
	fsw	f1, 1(r5)
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	fneg	f1, f1
	fsw	f1, 2(r5)
	jr	r31				#
beq_then.13808:
	lw	r1, 0(r6)
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r5)
	fsw	f1, 1(r5)
	fsw	f1, 2(r5)
	addi	r6, r1, -1
	addi	r1, r1, -1
	add	r30, r2, r1
	flw	f1, 0(r30)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13811
	addi	r1, r0, 1
	j	feq_cont.13812
feq_else.13811:
	addi	r1, r0, 0
feq_cont.13812:
	beqi	0, r1, beq_then.13813
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.13814
beq_then.13813:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13815
	addi	r1, r0, 0
	j	fle_cont.13816
fle_else.13815:
	addi	r1, r0, 1
fle_cont.13816:
	beqi	0, r1, beq_then.13817
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.13818
beq_then.13817:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.13818:
beq_cont.13814:
	fneg	f1, f1
	add	r30, r5, r6
	fsw	f1, 0(r30)
	jr	r31				#
utexture.3164:
	lw	r5, 1(r29)
	lw	r6, 0(r1)
	lw	r7, 8(r1)
	flw	f1, 0(r7)
	fsw	f1, 0(r5)
	lw	r7, 8(r1)
	flw	f1, 1(r7)
	fsw	f1, 1(r5)
	lw	r7, 8(r1)
	flw	f1, 2(r7)
	fsw	f1, 2(r5)
	beqi	1, r6, beq_then.13820
	beqi	2, r6, beq_then.13821
	beqi	3, r6, beq_then.13822
	beqi	4, r6, beq_then.13823
	jr	r31				#
beq_then.13823:
	flw	f1, 0(r2)
	lw	r6, 5(r1)
	flw	f2, 0(r6)
	fsub	f1, f1, f2
	lw	r6, 4(r1)
	flw	f2, 0(r6)
	fsqrt	f2, f2
	fmul	f1, f1, f2
	flw	f2, 2(r2)
	lw	r6, 5(r1)
	flw	f3, 2(r6)
	fsub	f2, f2, f3
	lw	r6, 4(r1)
	flw	f3, 2(r6)
	fsqrt	f3, f3
	fmul	f2, f2, f3
	fmul	f3, f1, f1
	fmul	f4, f2, f2
	fadd	f3, f3, f4
	flup	f4, 33		# fli	f4, 0.000100
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13825
	fadd	f5, f0, f1
	j	fle_cont.13826
fle_else.13825:
	fneg	f5, f1
fle_cont.13826:
	sw	r5, 0(r3)
	fsw	f3, 2(r3)
	sw	r1, 4(r3)
	sw	r2, 5(r3)
	fle	r30, f4, f5
	beq	r0, r30, fle_else.13828
	fdiv	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13830
	j	fle_cont.13831
fle_else.13830:
	fneg	f1, f1
fle_cont.13831:
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	atan.2757				#	bl	atan.2757
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.13829
fle_else.13828:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.13829:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13832
	addi	r1, r0, 0
	j	feq_cont.13833
feq_else.13832:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13834
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13835
fle_else.13834:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13835:
feq_cont.13833:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13836
	j	fle_cont.13837
fle_else.13836:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.13837:
	fsub	f1, f1, f2
	lw	r1, 5(r3)
	flw	f2, 1(r1)
	lw	r1, 4(r3)
	lw	r2, 5(r1)
	flw	f3, 1(r2)
	fsub	f2, f2, f3
	lw	r1, 4(r1)
	flw	f3, 1(r1)
	fsqrt	f3, f3
	fmul	f2, f2, f3
	flup	f3, 33		# fli	f3, 0.000100
	flw	f4, 2(r3)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.13838
	fadd	f5, f0, f4
	j	fle_cont.13839
fle_else.13838:
	fneg	f5, f4
fle_cont.13839:
	fsw	f1, 6(r3)
	fle	r30, f3, f5
	beq	r0, r30, fle_else.13840
	fdiv	f2, f2, f4
	fle	r30, f0, f2
	beq	r0, r30, fle_else.13842
	j	fle_cont.13843
fle_else.13842:
	fneg	f2, f2
fle_cont.13843:
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	atan.2757				#	bl	atan.2757
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.13841
fle_else.13840:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.13841:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13844
	addi	r1, r0, 0
	j	feq_cont.13845
feq_else.13844:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13846
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13847
fle_else.13846:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13847:
feq_cont.13845:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13848
	j	fle_cont.13849
fle_else.13848:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.13849:
	fsub	f1, f1, f2
	flup	f2, 36		# fli	f2, 0.150000
	flup	f3, 1		# fli	f3, 0.500000
	flw	f4, 6(r3)
	fsub	f3, f3, f4
	fmul	f3, f3, f3
	fsub	f2, f2, f3
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f1, f3, f1
	fmul	f1, f1, f1
	fsub	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13850
	addi	r1, r0, 0
	j	fle_cont.13851
fle_else.13850:
	addi	r1, r0, 1
fle_cont.13851:
	beqi	0, r1, beq_then.13852
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.13853
beq_then.13852:
beq_cont.13853:
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f2, f1
	flup	f2, 38		# fli	f2, 0.300000
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.13822:
	flw	f1, 0(r2)
	lw	r6, 5(r1)
	flw	f2, 0(r6)
	fsub	f1, f1, f2
	flw	f2, 2(r2)
	lw	r1, 5(r1)
	flw	f3, 2(r1)
	fsub	f2, f2, f3
	fmul	f1, f1, f1
	fmul	f2, f2, f2
	fadd	f1, f1, f2
	fsqrt	f1, f1
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13855
	addi	r1, r0, 0
	j	feq_cont.13856
feq_else.13855:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13857
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.13858
fle_else.13857:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.13858:
feq_cont.13856:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13859
	j	fle_cont.13860
fle_else.13859:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.13860:
	fsub	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fmul	f1, f1, f2
	sw	r5, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos.2753				#	bl	cos.2753
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fmul	f1, f1, f1
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f1, f2
	lw	r1, 0(r3)
	fsw	f2, 1(r1)
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f2, f1
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f1, f2
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.13821:
	flw	f1, 1(r2)
	flup	f2, 40		# fli	f2, 0.250000
	fmul	f1, f1, f2
	sw	r5, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2751				#	bl	sin.2751
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fmul	f1, f1, f1
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f2, f1
	lw	r1, 0(r3)
	fsw	f2, 0(r1)
	flup	f2, 37		# fli	f2, 255.000000
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f1, f3, f1
	fmul	f1, f2, f1
	fsw	f1, 1(r1)
	jr	r31				#
beq_then.13820:
	flw	f1, 0(r2)
	lw	r6, 5(r1)
	flw	f2, 0(r6)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	feq	r30, f2, f0
	beq	r0, r30, feq_else.13863
	addi	r6, r0, 0
	j	feq_cont.13864
feq_else.13863:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.13865
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r6, f3
	j	fle_cont.13866
fle_else.13865:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r6, f3
fle_cont.13866:
feq_cont.13864:
	itof	f3, r6
	fle	r30, f3, f2
	beq	r0, r30, fle_else.13867
	fadd	f2, f0, f3
	j	fle_cont.13868
fle_else.13867:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.13868:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.13869
	addi	r6, r0, 0
	j	fle_cont.13870
fle_else.13869:
	addi	r6, r0, 1
fle_cont.13870:
	flw	f1, 2(r2)
	lw	r1, 5(r1)
	flw	f2, 2(r1)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	feq	r30, f2, f0
	beq	r0, r30, feq_else.13871
	addi	r1, r0, 0
	j	feq_cont.13872
feq_else.13871:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.13873
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r1, f3
	j	fle_cont.13874
fle_else.13873:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r1, f3
fle_cont.13874:
feq_cont.13872:
	itof	f3, r1
	fle	r30, f3, f2
	beq	r0, r30, fle_else.13875
	fadd	f2, f0, f3
	j	fle_cont.13876
fle_else.13875:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.13876:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.13877
	addi	r1, r0, 0
	j	fle_cont.13878
fle_else.13877:
	addi	r1, r0, 1
fle_cont.13878:
	beqi	0, r6, beq_then.13879
	beqi	0, r1, beq_then.13881
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.13882
beq_then.13881:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.13882:
	j	beq_cont.13880
beq_then.13879:
	beqi	0, r1, beq_then.13883
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.13884
beq_then.13883:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.13884:
beq_cont.13880:
	fsw	f1, 1(r5)
	jr	r31				#
add_light.3167:
	lw	r2, 2(r29)
	lw	r1, 1(r29)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13886
	addi	r5, r0, 0
	j	fle_cont.13887
fle_else.13886:
	addi	r5, r0, 1
fle_cont.13887:
	sw	r1, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	beqi	0, r5, beq_then.13889
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecaccum.2878				#	bl	vecaccum.2878
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.13890
beq_then.13889:
beq_cont.13890:
	flw	f1, 4(r3)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13891
	addi	r1, r0, 0
	j	fle_cont.13892
fle_else.13891:
	addi	r1, r0, 1
fle_cont.13892:
	beqi	0, r1, beq_then.13893
	fmul	f1, f1, f1
	fmul	f1, f1, f1
	flw	f2, 2(r3)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	flw	f2, 0(r1)
	fadd	f2, f2, f1
	fsw	f2, 0(r1)
	flw	f2, 1(r1)
	fadd	f2, f2, f1
	fsw	f2, 1(r1)
	flw	f2, 2(r1)
	fadd	f1, f2, f1
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.13893:
	jr	r31				#
trace_reflections.3171:
	lw	r5, 9(r29)
	lw	r6, 8(r29)
	lw	r7, 7(r29)
	lw	r8, 6(r29)
	lw	r9, 5(r29)
	lw	r10, 4(r29)
	lw	r11, 3(r29)
	lw	r12, 2(r29)
	lw	r13, 1(r29)
	addi	r14, r0, 0
	ble	r14, r1, ble_then.13896
	jr	r31				#
ble_then.13896:
	add	r30, r8, r1
	lw	r8, 0(r30)
	lw	r14, 1(r8)
	flup	f3, 31		# fli	f3, 1000000000.000000
	fsw	f3, 0(r6)
	addi	r15, r0, 0
	lw	r16, 0(r9)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	fsw	f2, 2(r3)
	sw	r13, 4(r3)
	sw	r2, 5(r3)
	fsw	f1, 6(r3)
	sw	r10, 8(r3)
	sw	r14, 9(r3)
	sw	r7, 10(r3)
	sw	r9, 11(r3)
	sw	r8, 12(r3)
	sw	r11, 13(r3)
	sw	r12, 14(r3)
	sw	r6, 15(r3)
	add	r2, r0, r16				# mr	r2, r16
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r14				# mr	r5, r14
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r1, 15(r3)
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13898
	addi	r1, r0, 0
	j	fle_cont.13899
fle_else.13898:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13900
	addi	r1, r0, 0
	j	fle_cont.13901
fle_else.13900:
	addi	r1, r0, 1
fle_cont.13901:
fle_cont.13899:
	beqi	0, r1, beq_then.13902
	lw	r1, 14(r3)
	lw	r1, 0(r1)
	slli	r1, r1, 2
	lw	r2, 13(r3)
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 12(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.13904
	j	beq_cont.13905
beq_then.13904:
	addi	r1, r0, 0
	lw	r5, 11(r3)
	lw	r5, 0(r5)
	lw	r29, 10(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.13906
	j	beq_cont.13907
beq_then.13906:
	lw	r1, 9(r3)
	lw	r2, 0(r1)
	lw	r5, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	veciprod.2870				#	bl	veciprod.2870
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r1, 12(r3)
	flw	f2, 2(r1)
	flw	f3, 6(r3)
	fmul	f4, f2, f3
	fmul	f1, f4, f1
	lw	r1, 9(r3)
	lw	r2, 0(r1)
	lw	r1, 5(r3)
	fsw	f1, 16(r3)
	fsw	f2, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	veciprod.2870				#	bl	veciprod.2870
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 18(r3)
	fmul	f2, f2, f1
	flw	f1, 16(r3)
	flw	f3, 2(r3)
	lw	r29, 4(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
beq_cont.13907:
beq_cont.13905:
	j	beq_cont.13903
beq_then.13902:
beq_cont.13903:
	lw	r1, 1(r3)
	addi	r1, r1, -1
	flw	f1, 6(r3)
	flw	f2, 2(r3)
	lw	r2, 5(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
trace_ray.3176:
	lw	r6, 26(r29)
	lw	r7, 25(r29)
	lw	r8, 24(r29)
	lw	r9, 23(r29)
	lw	r10, 22(r29)
	lw	r11, 21(r29)
	lw	r12, 20(r29)
	lw	r13, 19(r29)
	lw	r14, 18(r29)
	lw	r15, 17(r29)
	lw	r16, 16(r29)
	lw	r17, 15(r29)
	lw	r18, 14(r29)
	lw	r19, 13(r29)
	lw	r20, 12(r29)
	lw	r21, 11(r29)
	lw	r22, 10(r29)
	lw	r23, 9(r29)
	lw	r24, 8(r29)
	lw	r25, 7(r29)
	lw	r26, 6(r29)
	lw	r27, 5(r29)
	lw	r28, 4(r29)
	sw	r8, 0(r3)
	lw	r8, 3(r29)
	sw	r20, 1(r3)
	lw	r20, 2(r29)
	sw	r29, 2(r3)
	lw	r29, 1(r29)
	blei	4, r1, ble_then.13908
	jr	r31				#
ble_then.13908:
	sw	r15, 3(r3)
	lw	r15, 2(r5)
	flup	f3, 31		# fli	f3, 1000000000.000000
	fsw	f3, 0(r10)
	sw	r21, 4(r3)
	addi	r21, r0, 0
	sw	r12, 5(r3)
	lw	r12, 0(r17)
	fsw	f2, 6(r3)
	sw	r29, 8(r3)
	sw	r14, 9(r3)
	sw	r17, 10(r3)
	sw	r8, 11(r3)
	sw	r19, 12(r3)
	sw	r11, 13(r3)
	sw	r7, 14(r3)
	sw	r5, 15(r3)
	sw	r23, 16(r3)
	sw	r6, 17(r3)
	sw	r13, 18(r3)
	sw	r24, 19(r3)
	sw	r26, 20(r3)
	sw	r28, 21(r3)
	sw	r27, 22(r3)
	sw	r18, 23(r3)
	sw	r25, 24(r3)
	sw	r16, 25(r3)
	sw	r20, 26(r3)
	fsw	f1, 28(r3)
	sw	r22, 30(r3)
	sw	r2, 31(r3)
	sw	r1, 32(r3)
	sw	r15, 33(r3)
	sw	r10, 34(r3)
	add	r5, r0, r2				# mr	r5, r2
	add	r1, r0, r21				# mr	r1, r21
	add	r29, r0, r9				# mr	r29, r9
	add	r2, r0, r12				# mr	r2, r12
	sw	r31, 35(r3)
	addi	r3, r3, 36
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -36
	lw	r31, 35(r3)
	lw	r1, 34(r3)
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13911
	addi	r2, r0, 0
	j	fle_cont.13912
fle_else.13911:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13913
	addi	r2, r0, 0
	j	fle_cont.13914
fle_else.13913:
	addi	r2, r0, 1
fle_cont.13914:
fle_cont.13912:
	beqi	0, r2, beq_then.13915
	lw	r2, 24(r3)
	lw	r2, 0(r2)
	lw	r5, 23(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 2(r5)
	lw	r7, 7(r5)
	flw	f1, 0(r7)
	flw	f2, 28(r3)
	fmul	f1, f1, f2
	lw	r7, 1(r5)
	sw	r6, 35(r3)
	fsw	f1, 36(r3)
	sw	r2, 38(r3)
	sw	r5, 39(r3)
	beqi	1, r7, beq_then.13916
	beqi	2, r7, beq_then.13918
	lw	r29, 20(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
	j	beq_cont.13919
beq_then.13918:
	lw	r29, 21(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
beq_cont.13919:
	j	beq_cont.13917
beq_then.13916:
	lw	r7, 31(r3)
	lw	r29, 22(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
beq_cont.13917:
	lw	r2, 19(r3)
	flw	f1, 0(r2)
	lw	r1, 18(r3)
	fsw	f1, 0(r1)
	flw	f1, 1(r2)
	fsw	f1, 1(r1)
	flw	f1, 2(r2)
	fsw	f1, 2(r1)
	lw	r1, 39(r3)
	lw	r29, 17(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
	lw	r1, 38(r3)
	slli	r1, r1, 2
	lw	r2, 16(r3)
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 15(r3)
	lw	r6, 1(r1)
	add	r30, r6, r2
	lw	r6, 0(r30)
	lw	r7, 19(r3)
	flw	f1, 0(r7)
	fsw	f1, 0(r6)
	flw	f1, 1(r7)
	fsw	f1, 1(r6)
	flw	f1, 2(r7)
	fsw	f1, 2(r6)
	lw	r6, 3(r1)
	flup	f1, 1		# fli	f1, 0.500000
	lw	r8, 39(r3)
	lw	r9, 7(r8)
	flw	f2, 0(r9)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13920
	lw	r9, 14(r3)
	add	r30, r6, r2
	sw	r9, 0(r30)
	lw	r6, 4(r1)
	add	r30, r6, r2
	lw	r9, 0(r30)
	lw	r10, 13(r3)
	flw	f1, 0(r10)
	fsw	f1, 0(r9)
	flw	f1, 1(r10)
	fsw	f1, 1(r9)
	flw	f1, 2(r10)
	fsw	f1, 2(r9)
	add	r30, r6, r2
	lw	r6, 0(r30)
	flup	f1, 43		# fli	f1, 0.003906
	flw	f2, 36(r3)
	fmul	f1, f1, f2
	flw	f3, 0(r6)
	fmul	f3, f3, f1
	fsw	f3, 0(r6)
	flw	f3, 1(r6)
	fmul	f3, f3, f1
	fsw	f3, 1(r6)
	flw	f3, 2(r6)
	fmul	f1, f3, f1
	fsw	f1, 2(r6)
	lw	r6, 7(r1)
	add	r30, r6, r2
	lw	r6, 0(r30)
	lw	r9, 12(r3)
	flw	f1, 0(r9)
	fsw	f1, 0(r6)
	flw	f1, 1(r9)
	fsw	f1, 1(r6)
	flw	f1, 2(r9)
	fsw	f1, 2(r6)
	j	fle_cont.13921
fle_else.13920:
	lw	r9, 11(r3)
	add	r30, r6, r2
	sw	r9, 0(r30)
fle_cont.13921:
	flup	f1, 44		# fli	f1, -2.000000
	lw	r6, 31(r3)
	lw	r9, 12(r3)
	fsw	f1, 40(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	veciprod.2870				#	bl	veciprod.2870
	addi	r3, r3, -43
	lw	r31, 42(r3)
	flw	f2, 40(r3)
	fmul	f1, f2, f1
	lw	r1, 31(r3)
	lw	r2, 12(r3)
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	vecaccum.2878				#	bl	vecaccum.2878
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r1, 39(r3)
	lw	r2, 7(r1)
	flw	f1, 1(r2)
	flw	f2, 28(r3)
	fmul	f1, f2, f1
	addi	r2, r0, 0
	lw	r5, 10(r3)
	lw	r5, 0(r5)
	lw	r29, 9(r3)
	fsw	f1, 42(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 44(r3)
	addi	r3, r3, 45
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -45
	lw	r31, 44(r3)
	beqi	0, r1, beq_then.13922
	j	beq_cont.13923
beq_then.13922:
	lw	r1, 12(r3)
	lw	r2, 30(r3)
	sw	r31, 44(r3)
	addi	r3, r3, 45
	jal	veciprod.2870				#	bl	veciprod.2870
	addi	r3, r3, -45
	lw	r31, 44(r3)
	fneg	f1, f1
	flw	f2, 36(r3)
	fmul	f1, f1, f2
	lw	r1, 31(r3)
	lw	r2, 30(r3)
	fsw	f1, 44(r3)
	sw	r31, 46(r3)
	addi	r3, r3, 47
	jal	veciprod.2870				#	bl	veciprod.2870
	addi	r3, r3, -47
	lw	r31, 46(r3)
	fneg	f2, f1
	flw	f1, 44(r3)
	flw	f3, 42(r3)
	lw	r29, 8(r3)
	sw	r31, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -47
	lw	r31, 46(r3)
beq_cont.13923:
	lw	r1, 19(r3)
	flw	f1, 0(r1)
	lw	r2, 5(r3)
	fsw	f1, 0(r2)
	flw	f1, 1(r1)
	fsw	f1, 1(r2)
	flw	f1, 2(r1)
	fsw	f1, 2(r2)
	lw	r2, 4(r3)
	lw	r2, 0(r2)
	addi	r2, r2, -1
	lw	r29, 3(r3)
	sw	r31, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -47
	lw	r31, 46(r3)
	lw	r1, 1(r3)
	lw	r1, 0(r1)
	addi	r1, r1, -1
	flw	f1, 36(r3)
	flw	f2, 42(r3)
	lw	r2, 31(r3)
	lw	r29, 0(r3)
	sw	r31, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -47
	lw	r31, 46(r3)
	flup	f1, 45		# fli	f1, 0.100000
	flw	f2, 28(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13924
	jr	r31				#
fle_else.13924:
	addi	r1, r0, 4
	lw	r2, 32(r3)
	ble	r1, r2, ble_then.13926
	addi	r1, r2, 1
	addi	r5, r0, -1
	lw	r6, 33(r3)
	add	r30, r6, r1
	sw	r5, 0(r30)
	j	ble_cont.13927
ble_then.13926:
ble_cont.13927:
	lw	r1, 35(r3)
	beqi	2, r1, beq_then.13928
	j	beq_cont.13929
beq_then.13928:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r1, 39(r3)
	lw	r1, 7(r1)
	flw	f3, 0(r1)
	fsub	f1, f1, f3
	fmul	f1, f2, f1
	addi	r1, r2, 1
	lw	r2, 34(r3)
	flw	f2, 0(r2)
	flw	f3, 6(r3)
	fadd	f2, f3, f2
	lw	r2, 31(r3)
	lw	r5, 15(r3)
	lw	r29, 2(r3)
	sw	r31, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -47
	lw	r31, 46(r3)
beq_cont.13929:
	jr	r31				#
beq_then.13915:
	addi	r1, r0, -1
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	0, r2, beq_then.13931
	lw	r1, 31(r3)
	lw	r2, 30(r3)
	sw	r31, 46(r3)
	addi	r3, r3, 47
	jal	veciprod.2870				#	bl	veciprod.2870
	addi	r3, r3, -47
	lw	r31, 46(r3)
	fneg	f1, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13932
	addi	r1, r0, 0
	j	fle_cont.13933
fle_else.13932:
	addi	r1, r0, 1
fle_cont.13933:
	beqi	0, r1, beq_then.13934
	fmul	f2, f1, f1
	fmul	f1, f2, f1
	flw	f2, 28(r3)
	fmul	f1, f1, f2
	lw	r1, 26(r3)
	flw	f2, 0(r1)
	fmul	f1, f1, f2
	lw	r1, 25(r3)
	flw	f2, 0(r1)
	fadd	f2, f2, f1
	fsw	f2, 0(r1)
	flw	f2, 1(r1)
	fadd	f2, f2, f1
	fsw	f2, 1(r1)
	flw	f2, 2(r1)
	fadd	f1, f2, f1
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.13934:
	jr	r31				#
beq_then.13931:
	jr	r31				#
trace_diffuse_ray.3182:
	lw	r2, 15(r29)
	lw	r5, 14(r29)
	lw	r6, 13(r29)
	lw	r7, 12(r29)
	lw	r8, 11(r29)
	lw	r9, 10(r29)
	lw	r10, 9(r29)
	lw	r11, 8(r29)
	lw	r12, 7(r29)
	lw	r13, 6(r29)
	lw	r14, 5(r29)
	lw	r15, 4(r29)
	lw	r16, 3(r29)
	lw	r17, 2(r29)
	lw	r18, 1(r29)
	flup	f2, 31		# fli	f2, 1000000000.000000
	fsw	f2, 0(r6)
	addi	r19, r0, 0
	lw	r20, 0(r9)
	sw	r7, 0(r3)
	sw	r18, 1(r3)
	fsw	f1, 2(r3)
	sw	r12, 4(r3)
	sw	r11, 5(r3)
	sw	r8, 6(r3)
	sw	r9, 7(r3)
	sw	r13, 8(r3)
	sw	r2, 9(r3)
	sw	r15, 10(r3)
	sw	r17, 11(r3)
	sw	r16, 12(r3)
	sw	r1, 13(r3)
	sw	r10, 14(r3)
	sw	r14, 15(r3)
	sw	r6, 16(r3)
	add	r2, r0, r20				# mr	r2, r20
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r1				# mr	r5, r1
	add	r1, r0, r19				# mr	r1, r19
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r1, 16(r3)
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13938
	addi	r1, r0, 0
	j	fle_cont.13939
fle_else.13938:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13940
	addi	r1, r0, 0
	j	fle_cont.13941
fle_else.13940:
	addi	r1, r0, 1
fle_cont.13941:
fle_cont.13939:
	beqi	0, r1, beq_then.13942
	lw	r1, 15(r3)
	lw	r1, 0(r1)
	lw	r2, 14(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 13(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	sw	r1, 17(r3)
	beqi	1, r5, beq_then.13943
	beqi	2, r5, beq_then.13945
	lw	r29, 10(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	j	beq_cont.13946
beq_then.13945:
	lw	r29, 11(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
beq_cont.13946:
	j	beq_cont.13944
beq_then.13943:
	lw	r29, 12(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
beq_cont.13944:
	lw	r1, 17(r3)
	lw	r2, 8(r3)
	lw	r29, 9(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	addi	r1, r0, 0
	lw	r2, 7(r3)
	lw	r2, 0(r2)
	lw	r29, 6(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.13947
	jr	r31				#
beq_then.13947:
	lw	r1, 5(r3)
	lw	r2, 4(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	veciprod.2870				#	bl	veciprod.2870
	addi	r3, r3, -19
	lw	r31, 18(r3)
	fneg	f1, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13949
	addi	r1, r0, 0
	j	fle_cont.13950
fle_else.13949:
	addi	r1, r0, 1
fle_cont.13950:
	beqi	0, r1, beq_then.13951
	j	beq_cont.13952
beq_then.13951:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.13952:
	flw	f2, 2(r3)
	fmul	f1, f2, f1
	lw	r1, 17(r3)
	lw	r1, 7(r1)
	flw	f2, 0(r1)
	fmul	f1, f1, f2
	lw	r1, 1(r3)
	lw	r2, 0(r3)
	j	vecaccum.2878
beq_then.13942:
	jr	r31				#
iter_trace_diffuse_rays.3185:
	lw	r7, 1(r29)
	addi	r8, r0, 0
	ble	r8, r6, ble_then.13954
	jr	r31				#
ble_then.13954:
	add	r30, r1, r6
	lw	r8, 0(r30)
	lw	r8, 0(r8)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r29, 2(r3)
	sw	r7, 3(r3)
	sw	r6, 4(r3)
	sw	r1, 5(r3)
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	veciprod.2870				#	bl	veciprod.2870
	addi	r3, r3, -7
	lw	r31, 6(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13956
	addi	r1, r0, 0
	j	fle_cont.13957
fle_else.13956:
	addi	r1, r0, 1
fle_cont.13957:
	beqi	0, r1, beq_then.13958
	lw	r1, 4(r3)
	addi	r2, r1, 1
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	lw	r29, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.13959
beq_then.13958:
	lw	r1, 4(r3)
	lw	r2, 5(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	lw	r29, 3(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.13959:
	lw	r1, 4(r3)
	addi	r6, r1, -2
	lw	r1, 5(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
trace_diffuse_rays.3190:
	lw	r6, 4(r29)
	lw	r7, 3(r29)
	lw	r8, 2(r29)
	lw	r9, 1(r29)
	flw	f1, 0(r5)
	fsw	f1, 0(r6)
	flw	f1, 1(r5)
	fsw	f1, 1(r6)
	flw	f1, 2(r5)
	fsw	f1, 2(r6)
	lw	r6, 0(r8)
	addi	r6, r6, -1
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r9, 3(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	add	r29, r0, r7				# mr	r29, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r6, r0, 118
	lw	r1, 2(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 3(r3)
	lw	r28, 0(r29)
	jr	r28
trace_diffuse_ray_80percent.3194:
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	sw	r2, 0(r3)
	sw	r7, 1(r3)
	sw	r5, 2(r3)
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	sw	r1, 5(r3)
	beqi	0, r1, beq_then.13960
	lw	r9, 0(r8)
	sw	r9, 6(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r29, r0, r6				# mr	r29, r6
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r6, r0, 118
	lw	r1, 6(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r29, 1(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.13961
beq_then.13960:
beq_cont.13961:
	lw	r1, 5(r3)
	beqi	1, r1, beq_then.13962
	lw	r2, 4(r3)
	lw	r5, 1(r2)
	lw	r6, 2(r3)
	lw	r29, 3(r3)
	sw	r5, 7(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	addi	r6, r0, 118
	lw	r1, 7(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r29, 1(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.13963
beq_then.13962:
beq_cont.13963:
	lw	r1, 5(r3)
	beqi	2, r1, beq_then.13964
	lw	r2, 4(r3)
	lw	r5, 2(r2)
	lw	r6, 2(r3)
	lw	r29, 3(r3)
	sw	r5, 8(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r6, r0, 118
	lw	r1, 8(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r29, 1(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.13965
beq_then.13964:
beq_cont.13965:
	lw	r1, 5(r3)
	beqi	3, r1, beq_then.13966
	lw	r2, 4(r3)
	lw	r5, 3(r2)
	lw	r6, 2(r3)
	lw	r29, 3(r3)
	sw	r5, 9(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r6, r0, 118
	lw	r1, 9(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r29, 1(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.13967
beq_then.13966:
beq_cont.13967:
	lw	r1, 5(r3)
	beqi	4, r1, beq_then.13968
	lw	r1, 4(r3)
	lw	r1, 4(r1)
	lw	r2, 2(r3)
	lw	r29, 3(r3)
	sw	r1, 10(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r6, r0, 118
	lw	r1, 10(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13968:
	jr	r31				#
calc_diffuse_using_1point.3198:
	lw	r5, 3(r29)
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	lw	r8, 5(r1)
	lw	r9, 7(r1)
	lw	r10, 1(r1)
	lw	r11, 4(r1)
	add	r30, r8, r2
	lw	r8, 0(r30)
	flw	f1, 0(r8)
	fsw	f1, 0(r7)
	flw	f1, 1(r8)
	fsw	f1, 1(r7)
	flw	f1, 2(r8)
	fsw	f1, 2(r7)
	lw	r1, 6(r1)
	lw	r1, 0(r1)
	add	r30, r9, r2
	lw	r8, 0(r30)
	add	r30, r10, r2
	lw	r9, 0(r30)
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r2, 2(r3)
	sw	r11, 3(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r9				# mr	r5, r9
	sw	r31, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r1, 1(r3)
	lw	r5, 0(r3)
	j	vecaccumv.2891
calc_diffuse_using_5points.3201:
	lw	r8, 2(r29)
	lw	r9, 1(r29)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r2, 5(r2)
	addi	r10, r1, -1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 5(r10)
	add	r30, r5, r1
	lw	r11, 0(r30)
	lw	r11, 5(r11)
	addi	r12, r1, 1
	add	r30, r5, r12
	lw	r12, 0(r30)
	lw	r12, 5(r12)
	add	r30, r6, r1
	lw	r6, 0(r30)
	lw	r6, 5(r6)
	add	r30, r2, r7
	lw	r2, 0(r30)
	flw	f1, 0(r2)
	fsw	f1, 0(r9)
	flw	f1, 1(r2)
	fsw	f1, 1(r9)
	flw	f1, 2(r2)
	fsw	f1, 2(r9)
	add	r30, r10, r7
	lw	r2, 0(r30)
	sw	r8, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r6, 3(r3)
	sw	r12, 4(r3)
	sw	r9, 5(r3)
	sw	r7, 6(r3)
	sw	r11, 7(r3)
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	vecadd.2882				#	bl	vecadd.2882
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 5(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	vecadd.2882				#	bl	vecadd.2882
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 6(r3)
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 5(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	vecadd.2882				#	bl	vecadd.2882
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 6(r3)
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 5(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	vecadd.2882				#	bl	vecadd.2882
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 4(r1)
	lw	r2, 6(r3)
	add	r30, r1, r2
	lw	r2, 0(r30)
	lw	r1, 0(r3)
	lw	r5, 5(r3)
	j	vecaccumv.2891
do_without_neighbors.3207:
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	blei	4, r2, ble_then.13970
	jr	r31				#
ble_then.13970:
	lw	r9, 2(r1)
	addi	r10, r0, 0
	add	r30, r9, r2
	lw	r9, 0(r30)
	ble	r10, r9, ble_then.13972
	jr	r31				#
ble_then.13972:
	lw	r9, 3(r1)
	add	r30, r9, r2
	lw	r9, 0(r30)
	sw	r29, 0(r3)
	sw	r8, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	beqi	0, r9, beq_then.13974
	lw	r9, 5(r1)
	lw	r10, 7(r1)
	lw	r11, 1(r1)
	lw	r12, 4(r1)
	add	r30, r9, r2
	lw	r9, 0(r30)
	flw	f1, 0(r9)
	fsw	f1, 0(r7)
	flw	f1, 1(r9)
	fsw	f1, 1(r7)
	flw	f1, 2(r9)
	fsw	f1, 2(r7)
	lw	r9, 6(r1)
	lw	r9, 0(r9)
	add	r30, r10, r2
	lw	r10, 0(r30)
	add	r30, r11, r2
	lw	r11, 0(r30)
	sw	r7, 4(r3)
	sw	r6, 5(r3)
	sw	r12, 6(r3)
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r9				# mr	r1, r9
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r11				# mr	r5, r11
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 3(r3)
	lw	r2, 6(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 5(r3)
	lw	r6, 4(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	vecaccumv.2891				#	bl	vecaccumv.2891
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.13975
beq_then.13974:
beq_cont.13975:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	blei	4, r2, ble_then.13976
	jr	r31				#
ble_then.13976:
	lw	r1, 2(r3)
	lw	r5, 2(r1)
	addi	r6, r0, 0
	add	r30, r5, r2
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.13978
	jr	r31				#
ble_then.13978:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 7(r3)
	beqi	0, r5, beq_then.13980
	lw	r29, 1(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.13981
beq_then.13980:
beq_cont.13981:
	lw	r1, 7(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
neighbors_exist.3210:
	lw	r5, 1(r29)
	lw	r6, 1(r5)
	addi	r7, r2, 1
	ble	r6, r7, ble_then.13982
	blei	0, r2, ble_then.13983
	lw	r2, 0(r5)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.13984
	blei	0, r1, ble_then.13985
	addi	r1, r0, 1
	jr	r31				#
ble_then.13985:
	addi	r1, r0, 0
	jr	r31				#
ble_then.13984:
	addi	r1, r0, 0
	jr	r31				#
ble_then.13983:
	addi	r1, r0, 0
	jr	r31				#
ble_then.13982:
	addi	r1, r0, 0
	jr	r31				#
get_surface_id.3214:
	lw	r1, 2(r1)
	add	r30, r1, r2
	lw	r1, 0(r30)
	jr	r31				#
neighbors_are_available.3217:
	add	r30, r5, r1
	lw	r8, 0(r30)
	lw	r8, 2(r8)
	add	r30, r8, r7
	lw	r8, 0(r30)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.13986
	addi	r1, r0, 0
	jr	r31				#
beq_then.13986:
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.13987
	addi	r1, r0, 0
	jr	r31				#
beq_then.13987:
	addi	r2, r1, -1
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.13988
	addi	r1, r0, 0
	jr	r31				#
beq_then.13988:
	addi	r1, r1, 1
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beq	r1, r8, beq_then.13989
	addi	r1, r0, 0
	jr	r31				#
beq_then.13989:
	addi	r1, r0, 1
	jr	r31				#
try_exploit_neighbors.3223:
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	add	r30, r6, r1
	lw	r12, 0(r30)
	blei	4, r8, ble_then.13990
	jr	r31				#
ble_then.13990:
	addi	r13, r0, 0
	lw	r14, 2(r12)
	add	r30, r14, r8
	lw	r14, 0(r30)
	ble	r13, r14, ble_then.13992
	jr	r31				#
ble_then.13992:
	sw	r2, 0(r3)
	sw	r29, 1(r3)
	sw	r7, 2(r3)
	sw	r5, 3(r3)
	sw	r10, 4(r3)
	sw	r12, 5(r3)
	sw	r9, 6(r3)
	sw	r11, 7(r3)
	sw	r8, 8(r3)
	sw	r1, 9(r3)
	sw	r6, 10(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r8				# mr	r7, r8
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	neighbors_are_available.3217				#	bl	neighbors_are_available.3217
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.13994
	lw	r1, 5(r3)
	lw	r1, 3(r1)
	lw	r7, 8(r3)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beqi	0, r1, beq_then.13995
	lw	r1, 9(r3)
	lw	r2, 3(r3)
	lw	r5, 10(r3)
	lw	r6, 2(r3)
	lw	r29, 4(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.13996
beq_then.13995:
beq_cont.13996:
	lw	r1, 8(r3)
	addi	r8, r1, 1
	lw	r1, 9(r3)
	lw	r2, 0(r3)
	lw	r5, 3(r3)
	lw	r6, 10(r3)
	lw	r7, 2(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13994:
	lw	r1, 9(r3)
	lw	r2, 10(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 8(r3)
	blei	4, r2, ble_then.13997
	jr	r31				#
ble_then.13997:
	lw	r5, 2(r1)
	addi	r6, r0, 0
	add	r30, r5, r2
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.13999
	jr	r31				#
ble_then.13999:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r1, 11(r3)
	beqi	0, r5, beq_then.14001
	lw	r29, 7(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.14002
beq_then.14001:
beq_cont.14002:
	lw	r1, 8(r3)
	addi	r2, r1, 1
	lw	r1, 11(r3)
	lw	r29, 6(r3)
	lw	r28, 0(r29)
	jr	r28
write_ppm_header.3230:
	lw	r1, 1(r29)
	addi	r2, r0, 80
	out	r2
	addi	r2, r0, 51
	out	r2
	addi	r2, r0, 10
	out	r2
	lw	r2, 0(r1)
	sw	r1, 0(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	print_int.2785				#	bl	print_int.2785
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 32
	out	r1
	lw	r1, 0(r3)
	lw	r1, 1(r1)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	print_int.2785				#	bl	print_int.2785
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 255
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	print_int.2785				#	bl	print_int.2785
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
write_rgb_element.3232:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.14003
	addi	r1, r0, 0
	j	feq_cont.14004
feq_else.14003:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.14005
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.14006
fle_else.14005:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.14006:
feq_cont.14004:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.14007
	addi	r1, r0, 255
	j	ble_cont.14008
ble_then.14007:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14009
	addi	r1, r0, 0
	j	ble_cont.14010
ble_then.14009:
ble_cont.14010:
ble_cont.14008:
	j	print_int.2785
write_rgb.3234:
	lw	r1, 1(r29)
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.14011
	addi	r2, r0, 0
	j	feq_cont.14012
feq_else.14011:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.14013
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.14014
fle_else.14013:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.14014:
feq_cont.14012:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.14015
	addi	r2, r0, 255
	j	ble_cont.14016
ble_then.14015:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.14017
	addi	r2, r0, 0
	j	ble_cont.14018
ble_then.14017:
ble_cont.14018:
ble_cont.14016:
	sw	r1, 0(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	print_int.2785				#	bl	print_int.2785
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 32
	out	r1
	lw	r1, 0(r3)
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.14019
	addi	r2, r0, 0
	j	feq_cont.14020
feq_else.14019:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.14021
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.14022
fle_else.14021:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.14022:
feq_cont.14020:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.14023
	addi	r2, r0, 255
	j	ble_cont.14024
ble_then.14023:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.14025
	addi	r2, r0, 0
	j	ble_cont.14026
ble_then.14025:
ble_cont.14026:
ble_cont.14024:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	print_int.2785				#	bl	print_int.2785
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 32
	out	r1
	lw	r1, 0(r3)
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.14027
	addi	r1, r0, 0
	j	feq_cont.14028
feq_else.14027:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.14029
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.14030
fle_else.14029:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.14030:
feq_cont.14028:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.14031
	addi	r1, r0, 255
	j	ble_cont.14032
ble_then.14031:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14033
	addi	r1, r0, 0
	j	ble_cont.14034
ble_then.14033:
ble_cont.14034:
ble_cont.14032:
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	print_int.2785				#	bl	print_int.2785
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
pretrace_diffuse_rays.3236:
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	blei	4, r2, ble_then.14035
	jr	r31				#
ble_then.14035:
	lw	r9, 2(r1)
	add	r30, r9, r2
	lw	r9, 0(r30)
	addi	r10, r0, 0
	ble	r10, r9, ble_then.14037
	jr	r31				#
ble_then.14037:
	lw	r9, 3(r1)
	add	r30, r9, r2
	lw	r9, 0(r30)
	sw	r29, 0(r3)
	sw	r2, 1(r3)
	beqi	0, r9, beq_then.14039
	lw	r9, 6(r1)
	lw	r9, 0(r9)
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r8)
	fsw	f1, 1(r8)
	fsw	f1, 2(r8)
	lw	r10, 7(r1)
	lw	r11, 1(r1)
	add	r30, r7, r9
	lw	r7, 0(r30)
	add	r30, r10, r2
	lw	r9, 0(r30)
	add	r30, r11, r2
	lw	r10, 0(r30)
	sw	r8, 2(r3)
	sw	r1, 3(r3)
	sw	r10, 4(r3)
	sw	r9, 5(r3)
	sw	r7, 6(r3)
	sw	r6, 7(r3)
	add	r1, r0, r10				# mr	r1, r10
	add	r29, r0, r5				# mr	r29, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	addi	r6, r0, 118
	lw	r1, 6(r3)
	lw	r2, 5(r3)
	lw	r5, 4(r3)
	lw	r29, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 3(r3)
	lw	r2, 5(r1)
	lw	r5, 1(r3)
	add	r30, r2, r5
	lw	r2, 0(r30)
	lw	r6, 2(r3)
	flw	f1, 0(r6)
	fsw	f1, 0(r2)
	flw	f1, 1(r6)
	fsw	f1, 1(r2)
	flw	f1, 2(r6)
	fsw	f1, 2(r2)
	j	beq_cont.14040
beq_then.14039:
beq_cont.14040:
	lw	r2, 1(r3)
	addi	r2, r2, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_pixels.3239:
	lw	r6, 10(r29)
	lw	r7, 9(r29)
	lw	r8, 8(r29)
	lw	r9, 7(r29)
	lw	r10, 6(r29)
	lw	r11, 5(r29)
	lw	r12, 4(r29)
	lw	r13, 3(r29)
	lw	r14, 2(r29)
	lw	r15, 1(r29)
	addi	r16, r0, 0
	ble	r16, r2, ble_then.14041
	jr	r31				#
ble_then.14041:
	flw	f4, 0(r10)
	lw	r10, 0(r14)
	sub	r10, r2, r10
	itof	f5, r10
	fmul	f4, f4, f5
	flw	f5, 0(r9)
	fmul	f5, f4, f5
	fadd	f5, f5, f1
	fsw	f5, 0(r12)
	flw	f5, 1(r9)
	fmul	f5, f4, f5
	fadd	f5, f5, f2
	fsw	f5, 1(r12)
	flw	f5, 2(r9)
	fmul	f4, f4, f5
	fadd	f4, f4, f3
	fsw	f4, 2(r12)
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r29, 6(r3)
	sw	r13, 7(r3)
	sw	r5, 8(r3)
	sw	r12, 9(r3)
	sw	r7, 10(r3)
	sw	r2, 11(r3)
	sw	r1, 12(r3)
	sw	r8, 13(r3)
	sw	r6, 14(r3)
	sw	r11, 15(r3)
	add	r2, r0, r15				# mr	r2, r15
	add	r1, r0, r12				# mr	r1, r12
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	vecunit_sgn.2867				#	bl	vecunit_sgn.2867
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flup	f1, 0		# fli	f1, 0.000000
	lw	r1, 15(r3)
	fsw	f1, 0(r1)
	fsw	f1, 1(r1)
	fsw	f1, 2(r1)
	lw	r2, 14(r3)
	flw	f1, 0(r2)
	lw	r5, 13(r3)
	fsw	f1, 0(r5)
	flw	f1, 1(r2)
	fsw	f1, 1(r5)
	flw	f1, 2(r2)
	fsw	f1, 2(r5)
	addi	r2, r0, 0
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 11(r3)
	lw	r6, 12(r3)
	add	r30, r6, r5
	lw	r7, 0(r30)
	flup	f2, 0		# fli	f2, 0.000000
	lw	r8, 9(r3)
	lw	r29, 10(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r8				# mr	r2, r8
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	lw	r6, 15(r3)
	flw	f1, 0(r6)
	fsw	f1, 0(r5)
	flw	f1, 1(r6)
	fsw	f1, 1(r5)
	flw	f1, 2(r6)
	fsw	f1, 2(r5)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 6(r5)
	lw	r6, 8(r3)
	sw	r6, 0(r5)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r7, r0, 0
	lw	r29, 7(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r1, 11(r3)
	addi	r2, r1, -1
	lw	r1, 8(r3)
	addi	r1, r1, 1
	addi	r5, r0, 5
	ble	r5, r1, ble_then.14043
	add	r5, r0, r1
	j	ble_cont.14044
ble_then.14043:
	addi	r5, r1, -5
ble_cont.14044:
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r1, 12(r3)
	lw	r29, 6(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_line.3246:
	lw	r6, 6(r29)
	lw	r7, 5(r29)
	lw	r8, 4(r29)
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	flw	f1, 0(r8)
	lw	r8, 1(r11)
	sub	r2, r2, r8
	itof	f2, r2
	fmul	f1, f1, f2
	flw	f2, 0(r7)
	fmul	f2, f1, f2
	flw	f3, 0(r6)
	fadd	f2, f2, f3
	flw	f3, 1(r7)
	fmul	f3, f1, f3
	flw	f4, 1(r6)
	fadd	f3, f3, f4
	flw	f4, 2(r7)
	fmul	f1, f1, f4
	flw	f4, 2(r6)
	fadd	f1, f1, f4
	lw	r2, 0(r10)
	addi	r2, r2, -1
	add	r29, r0, r9				# mr	r29, r9
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	lw	r28, 0(r29)
	jr	r28
scan_pixel.3250:
	lw	r8, 5(r29)
	lw	r9, 4(r29)
	lw	r10, 3(r29)
	lw	r11, 2(r29)
	lw	r12, 1(r29)
	lw	r13, 0(r10)
	ble	r13, r1, ble_then.14045
	add	r30, r6, r1
	lw	r13, 0(r30)
	lw	r13, 0(r13)
	flw	f1, 0(r13)
	fsw	f1, 0(r9)
	flw	f1, 1(r13)
	fsw	f1, 1(r9)
	flw	f1, 2(r13)
	fsw	f1, 2(r9)
	lw	r13, 1(r10)
	addi	r14, r2, 1
	ble	r13, r14, ble_then.14046
	blei	0, r2, ble_then.14048
	lw	r10, 0(r10)
	addi	r13, r1, 1
	ble	r10, r13, ble_then.14050
	blei	0, r1, ble_then.14052
	addi	r10, r0, 1
	j	ble_cont.14053
ble_then.14052:
	addi	r10, r0, 0
ble_cont.14053:
	j	ble_cont.14051
ble_then.14050:
	addi	r10, r0, 0
ble_cont.14051:
	j	ble_cont.14049
ble_then.14048:
	addi	r10, r0, 0
ble_cont.14049:
	j	ble_cont.14047
ble_then.14046:
	addi	r10, r0, 0
ble_cont.14047:
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r29, 4(r3)
	sw	r1, 5(r3)
	sw	r9, 6(r3)
	beqi	0, r10, beq_then.14054
	addi	r10, r0, 0
	add	r29, r0, r8				# mr	r29, r8
	add	r8, r0, r10				# mr	r8, r10
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.14055
beq_then.14054:
	add	r30, r6, r1
	lw	r8, 0(r30)
	addi	r10, r0, 0
	lw	r13, 2(r8)
	addi	r14, r0, 0
	lw	r13, 0(r13)
	ble	r14, r13, ble_then.14056
	j	ble_cont.14057
ble_then.14056:
	lw	r13, 3(r8)
	lw	r13, 0(r13)
	sw	r8, 7(r3)
	sw	r11, 8(r3)
	beqi	0, r13, beq_then.14058
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r8				# mr	r1, r8
	add	r29, r0, r12				# mr	r29, r12
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.14059
beq_then.14058:
beq_cont.14059:
	addi	r2, r0, 1
	lw	r1, 7(r3)
	lw	r29, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
ble_cont.14057:
beq_cont.14055:
	lw	r1, 6(r3)
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.14060
	addi	r2, r0, 0
	j	feq_cont.14061
feq_else.14060:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.14062
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.14063
fle_else.14062:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.14063:
feq_cont.14061:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.14064
	addi	r2, r0, 255
	j	ble_cont.14065
ble_then.14064:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.14066
	addi	r2, r0, 0
	j	ble_cont.14067
ble_then.14066:
ble_cont.14067:
ble_cont.14065:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	print_int.2785				#	bl	print_int.2785
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r1, r0, 32
	out	r1
	lw	r1, 6(r3)
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.14068
	addi	r2, r0, 0
	j	feq_cont.14069
feq_else.14068:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.14070
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.14071
fle_else.14070:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.14071:
feq_cont.14069:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.14072
	addi	r2, r0, 255
	j	ble_cont.14073
ble_then.14072:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.14074
	addi	r2, r0, 0
	j	ble_cont.14075
ble_then.14074:
ble_cont.14075:
ble_cont.14073:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	print_int.2785				#	bl	print_int.2785
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r1, r0, 32
	out	r1
	lw	r1, 6(r3)
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.14076
	addi	r1, r0, 0
	j	feq_cont.14077
feq_else.14076:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.14078
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.14079
fle_else.14078:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.14079:
feq_cont.14077:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.14080
	addi	r1, r0, 255
	j	ble_cont.14081
ble_then.14080:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14082
	addi	r1, r0, 0
	j	ble_cont.14083
ble_then.14082:
ble_cont.14083:
ble_cont.14081:
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	print_int.2785				#	bl	print_int.2785
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r1, r0, 10
	out	r1
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	lw	r6, 1(r3)
	lw	r7, 0(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
ble_then.14045:
	jr	r31				#
scan_line.3256:
	lw	r8, 3(r29)
	lw	r9, 2(r29)
	lw	r10, 1(r29)
	lw	r11, 1(r10)
	ble	r11, r1, ble_then.14085
	lw	r10, 1(r10)
	addi	r10, r10, -1
	sw	r29, 0(r3)
	sw	r7, 1(r3)
	sw	r6, 2(r3)
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	sw	r8, 6(r3)
	ble	r10, r1, ble_then.14086
	addi	r10, r1, 1
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r6				# mr	r1, r6
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	ble_cont.14087
ble_then.14086:
ble_cont.14087:
	addi	r1, r0, 0
	lw	r2, 5(r3)
	lw	r5, 4(r3)
	lw	r6, 3(r3)
	lw	r7, 2(r3)
	lw	r29, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5
	ble	r5, r2, ble_then.14088
	add	r7, r0, r2
	j	ble_cont.14089
ble_then.14088:
	addi	r7, r2, -5
ble_cont.14089:
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	lw	r29, 0(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	jr	r31				#
ble_then.14085:
	jr	r31				#
create_float5x3array.3262:
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -1
	lw	r31, 0(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 5
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	sw	r1, 4(r2)
	add	r1, r0, r2
	jr	r31				#
create_pixel.3264:
	lw	r1, 1(r29)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r31, 1(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	create_float5x3array.3262				#	bl	create_float5x3array.3262
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 5
	lw	r5, 0(r3)
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_float5x3array.3262				#	bl	create_float5x3array.3262
	addi	r3, r3, -6
	lw	r31, 5(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3262				#	bl	create_float5x3array.3262
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 6(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
	sw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	create_float5x3array.3262				#	bl	create_float5x3array.3262
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r4
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
	add	r1, r0, r2
	jr	r31				#
init_line_elements.3266:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.14092
	jr	r31				#
ble_then.14092:
	sw	r29, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	add	r29, r0, r5				# mr	r29, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14093
	add	r1, r0, r5
	jr	r31				#
ble_then.14093:
	lw	r29, 1(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 4(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14094
	add	r1, r0, r5
	jr	r31				#
ble_then.14094:
	lw	r29, 1(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 5(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14095
	add	r1, r0, r5
	jr	r31				#
ble_then.14095:
	lw	r29, 1(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r28, 0(r29)
	jr	r28
create_pixelline.3269:
	lw	r1, 3(r29)
	lw	r2, 2(r29)
	lw	r29, 1(r29)
	lw	r5, 0(r2)
	sw	r1, 0(r3)
	sw	r29, 1(r3)
	sw	r2, 2(r3)
	sw	r5, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
	lw	r2, 0(r2)
	addi	r2, r2, -2
	addi	r5, r0, 0
	ble	r5, r2, ble_then.14096
	jr	r31				#
ble_then.14096:
	lw	r29, 1(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14097
	add	r1, r0, r5
	jr	r31				#
ble_then.14097:
	lw	r29, 1(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14098
	add	r1, r0, r5
	jr	r31				#
ble_then.14098:
	lw	r29, 1(r3)
	sw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 7(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r28, 0(r29)
	jr	r28
tan.3271:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	sin.2751				#	bl	sin.2751
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f2, 0(r3)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	cos.2753				#	bl	cos.2753
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fdiv	f1, f2, f1
	jr	r31				#
adjust_position.3273:
	fmul	f1, f1, f1
	flup	f3, 45		# fli	f3, 0.100000
	fadd	f1, f1, f3
	fsqrt	f1, f1
	flup	f3, 2		# fli	f3, 1.000000
	fdiv	f3, f3, f1
	fsw	f1, 0(r3)
	fsw	f2, 2(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan.2757				#	bl	atan.2757
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fmul	f1, f1, f2
	fsw	f1, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin.2751				#	bl	sin.2751
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos.2753				#	bl	cos.2753
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fdiv	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
calc_dirvec.3276:
	lw	r6, 1(r29)
	addi	r7, r0, 5
	ble	r7, r1, ble_then.14099
	fmul	f1, f2, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f1, f1, f2
	fsqrt	f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f2, f2, f1
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r29, 2(r3)
	fsw	f4, 4(r3)
	sw	r1, 6(r3)
	fsw	f1, 8(r3)
	fsw	f3, 10(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	atan.2757				#	bl	atan.2757
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin.2751				#	bl	sin.2751
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fsw	f1, 14(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	cos.2753				#	bl	cos.2753
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fdiv	f1, f2, f1
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	lw	r1, 6(r3)
	addi	r1, r1, 1
	fmul	f2, f1, f1
	flup	f3, 45		# fli	f3, 0.100000
	fadd	f2, f2, f3
	fsqrt	f2, f2
	flup	f3, 2		# fli	f3, 1.000000
	fdiv	f3, f3, f2
	fsw	f1, 16(r3)
	sw	r1, 18(r3)
	fsw	f2, 20(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	atan.2757				#	bl	atan.2757
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	fsw	f1, 22(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	sin.2751				#	bl	sin.2751
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 22(r3)
	fsw	f1, 24(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	cos.2753				#	bl	cos.2753
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 24(r3)
	fdiv	f1, f2, f1
	flw	f2, 20(r3)
	fmul	f2, f1, f2
	flw	f1, 16(r3)
	flw	f3, 10(r3)
	flw	f4, 4(r3)
	lw	r1, 18(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
ble_then.14099:
	fmul	f3, f1, f1
	fmul	f4, f2, f2
	fadd	f3, f3, f4
	flup	f4, 2		# fli	f4, 1.000000
	fadd	f3, f3, f4
	fsqrt	f3, f3
	fdiv	f1, f1, f3
	fdiv	f2, f2, f3
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f3, f4, f3
	add	r30, r6, r2
	lw	r1, 0(r30)
	add	r30, r1, r5
	lw	r2, 0(r30)
	lw	r2, 0(r2)
	fsw	f1, 0(r2)
	fsw	f2, 1(r2)
	fsw	f3, 2(r2)
	addi	r2, r5, 40
	add	r30, r1, r2
	lw	r2, 0(r30)
	lw	r2, 0(r2)
	fneg	f4, f2
	fsw	f1, 0(r2)
	fsw	f3, 1(r2)
	fsw	f4, 2(r2)
	addi	r2, r5, 80
	add	r30, r1, r2
	lw	r2, 0(r30)
	lw	r2, 0(r2)
	fneg	f5, f1
	fsw	f3, 0(r2)
	fsw	f5, 1(r2)
	fsw	f4, 2(r2)
	addi	r2, r5, 1
	add	r30, r1, r2
	lw	r2, 0(r30)
	lw	r2, 0(r2)
	fneg	f3, f3
	fsw	f5, 0(r2)
	fsw	f4, 1(r2)
	fsw	f3, 2(r2)
	addi	r2, r5, 41
	add	r30, r1, r2
	lw	r2, 0(r30)
	lw	r2, 0(r2)
	fsw	f5, 0(r2)
	fsw	f3, 1(r2)
	fsw	f2, 2(r2)
	addi	r2, r5, 81
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 0(r1)
	fsw	f3, 0(r1)
	fsw	f1, 1(r1)
	fsw	f2, 2(r1)
	jr	r31				#
calc_dirvecs.3284:
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.14104
	jr	r31				#
ble_then.14104:
	itof	f2, r1
	flup	f3, 18		# fli	f3, 0.200000
	fmul	f2, f2, f3
	flup	f3, 48		# fli	f3, 0.900000
	fsub	f3, f2, f3
	addi	r7, r0, 0
	flup	f2, 0		# fli	f2, 0.000000
	flup	f4, 0		# fli	f4, 0.000000
	sw	r29, 0(r3)
	fsw	f1, 2(r3)
	sw	r2, 4(r3)
	sw	r6, 5(r3)
	sw	r5, 6(r3)
	sw	r1, 7(r3)
	add	r1, r0, r7				# mr	r1, r7
	add	r29, r0, r6				# mr	r29, r6
	fadd	f30, f0, f4				# fmr	f30, f4
	fadd	f4, f0, f1				# fmr	f4, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 7(r3)
	itof	f1, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f3, f1, f2
	addi	r2, r0, 0
	flup	f1, 0		# fli	f1, 0.000000
	flup	f2, 0		# fli	f2, 0.000000
	lw	r5, 6(r3)
	addi	r6, r5, 2
	flw	f4, 2(r3)
	lw	r7, 4(r3)
	lw	r29, 5(r3)
	add	r5, r0, r6				# mr	r5, r6
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r7				# mr	r2, r7
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 7(r3)
	addi	r1, r1, -1
	lw	r2, 4(r3)
	addi	r2, r2, 1
	addi	r5, r0, 5
	ble	r5, r2, ble_then.14107
	j	ble_cont.14108
ble_then.14107:
	addi	r2, r2, -5
ble_cont.14108:
	flw	f1, 2(r3)
	lw	r5, 6(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
calc_dirvec_rows.3289:
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.14109
	jr	r31				#
ble_then.14109:
	itof	f1, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f1, f1, f2
	addi	r7, r0, 4
	sw	r29, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	add	r1, r0, r7				# mr	r1, r7
	add	r29, r0, r6				# mr	r29, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	addi	r1, r1, -1
	lw	r2, 2(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5
	ble	r5, r2, ble_then.14111
	j	ble_cont.14112
ble_then.14111:
	addi	r2, r2, -5
ble_cont.14112:
	lw	r5, 1(r3)
	addi	r5, r5, 4
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
create_dirvec.3293:
	lw	r1, 1(r29)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r3)
	lw	r1, 0(r1)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 1(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	jr	r31				#
create_dirvec_elements.3295:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.14113
	jr	r31				#
ble_then.14113:
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r29, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 3(r3)
	lw	r5, 0(r1)
	sw	r2, 4(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 4(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14115
	jr	r31				#
ble_then.14115:
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 3(r3)
	lw	r1, 0(r1)
	sw	r2, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 6(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 5(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r28, 0(r29)
	jr	r28
create_dirvecs.3298:
	lw	r2, 3(r29)
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.14117
	jr	r31				#
ble_then.14117:
	addi	r7, r0, 120
	addi	r8, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r29, 0(r3)
	sw	r6, 1(r3)
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	sw	r7, 4(r3)
	sw	r2, 5(r3)
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 6(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 6(r3)
	sw	r1, 0(r2)
	lw	r1, 4(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	add	r30, r5, r2
	lw	r1, 0(r30)
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 7(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 8(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 7(r3)
	sw	r1, 118(r2)
	addi	r1, r0, 117
	lw	r29, 1(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 2(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14119
	jr	r31				#
ble_then.14119:
	addi	r2, r0, 120
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 9(r3)
	sw	r2, 10(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 5(r3)
	lw	r1, 0(r1)
	sw	r2, 11(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 11(r3)
	sw	r1, 0(r2)
	lw	r1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r2, 9(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	add	r30, r5, r2
	lw	r1, 0(r30)
	addi	r5, r0, 118
	lw	r29, 1(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 9(r3)
	addi	r1, r1, -1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
init_dirvec_constants.3300:
	lw	r5, 3(r29)
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	addi	r8, r0, 0
	ble	r8, r2, ble_then.14121
	jr	r31				#
ble_then.14121:
	add	r30, r1, r2
	lw	r8, 0(r30)
	lw	r9, 0(r6)
	addi	r9, r9, -1
	addi	r10, r0, 0
	sw	r29, 0(r3)
	sw	r7, 1(r3)
	sw	r5, 2(r3)
	sw	r6, 3(r3)
	sw	r1, 4(r3)
	sw	r2, 5(r3)
	ble	r10, r9, ble_then.14123
	j	ble_cont.14124
ble_then.14123:
	add	r30, r5, r9
	lw	r10, 0(r30)
	lw	r11, 1(r8)
	lw	r12, 0(r8)
	lw	r13, 1(r10)
	sw	r8, 6(r3)
	beqi	1, r13, beq_then.14125
	beqi	2, r13, beq_then.14127
	sw	r9, 7(r3)
	sw	r11, 8(r3)
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r12				# mr	r1, r12
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_second_table.3079				#	bl	setup_second_table.3079
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.14128
beq_then.14127:
	sw	r9, 7(r3)
	sw	r11, 8(r3)
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r12				# mr	r1, r12
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_surface_table.3076				#	bl	setup_surface_table.3076
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14128:
	j	beq_cont.14126
beq_then.14125:
	sw	r9, 7(r3)
	sw	r11, 8(r3)
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r12				# mr	r1, r12
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_rect_table.3073				#	bl	setup_rect_table.3073
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14126:
	addi	r2, r2, -1
	lw	r1, 6(r3)
	lw	r29, 1(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
ble_cont.14124:
	lw	r1, 5(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14129
	jr	r31				#
ble_then.14129:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r1, 9(r3)
	ble	r7, r6, ble_then.14131
	j	ble_cont.14132
ble_then.14131:
	lw	r7, 2(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 10(r3)
	beqi	1, r10, beq_then.14133
	beqi	2, r10, beq_then.14135
	sw	r6, 11(r3)
	sw	r8, 12(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_second_table.3079				#	bl	setup_second_table.3079
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.14136
beq_then.14135:
	sw	r6, 11(r3)
	sw	r8, 12(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_surface_table.3076				#	bl	setup_surface_table.3076
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14136:
	j	beq_cont.14134
beq_then.14133:
	sw	r6, 11(r3)
	sw	r8, 12(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_rect_table.3073				#	bl	setup_rect_table.3073
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14134:
	addi	r2, r2, -1
	lw	r1, 10(r3)
	lw	r29, 1(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
ble_cont.14132:
	lw	r1, 9(r3)
	addi	r2, r1, -1
	lw	r1, 4(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
init_vecset_constants.3303:
	lw	r2, 5(r29)
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	addi	r9, r0, 0
	ble	r9, r1, ble_then.14137
	jr	r31				#
ble_then.14137:
	add	r30, r8, r1
	lw	r9, 0(r30)
	lw	r10, 119(r9)
	lw	r5, 0(r5)
	addi	r5, r5, -1
	addi	r11, r0, 0
	sw	r29, 0(r3)
	sw	r8, 1(r3)
	sw	r1, 2(r3)
	sw	r9, 3(r3)
	sw	r7, 4(r3)
	ble	r11, r5, ble_then.14139
	j	ble_cont.14140
ble_then.14139:
	add	r30, r2, r5
	lw	r2, 0(r30)
	lw	r11, 1(r10)
	lw	r12, 0(r10)
	lw	r13, 1(r2)
	sw	r10, 5(r3)
	sw	r6, 6(r3)
	beqi	1, r13, beq_then.14141
	beqi	2, r13, beq_then.14143
	sw	r5, 7(r3)
	sw	r11, 8(r3)
	add	r1, r0, r12				# mr	r1, r12
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_second_table.3079				#	bl	setup_second_table.3079
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.14144
beq_then.14143:
	sw	r5, 7(r3)
	sw	r11, 8(r3)
	add	r1, r0, r12				# mr	r1, r12
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_surface_table.3076				#	bl	setup_surface_table.3076
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14144:
	j	beq_cont.14142
beq_then.14141:
	sw	r5, 7(r3)
	sw	r11, 8(r3)
	add	r1, r0, r12				# mr	r1, r12
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_rect_table.3073				#	bl	setup_rect_table.3073
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14142:
	addi	r2, r2, -1
	lw	r1, 5(r3)
	lw	r29, 6(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
ble_cont.14140:
	addi	r2, r0, 118
	lw	r1, 3(r3)
	lw	r29, 4(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 2(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14145
	jr	r31				#
ble_then.14145:
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	addi	r5, r0, 119
	lw	r29, 4(r3)
	sw	r1, 9(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 9(r3)
	addi	r1, r1, -1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
init_dirvecs.3305:
	lw	r1, 7(r29)
	lw	r2, 6(r29)
	lw	r5, 5(r29)
	lw	r6, 4(r29)
	lw	r7, 3(r29)
	lw	r8, 2(r29)
	lw	r9, 1(r29)
	addi	r10, r0, 120
	addi	r11, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 0(r3)
	sw	r5, 1(r3)
	sw	r9, 2(r3)
	sw	r7, 3(r3)
	sw	r8, 4(r3)
	sw	r6, 5(r3)
	sw	r10, 6(r3)
	sw	r1, 7(r3)
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 7(r3)
	lw	r1, 0(r1)
	sw	r2, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 8(r3)
	sw	r1, 0(r2)
	lw	r1, 6(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 5(r3)
	sw	r1, 4(r2)
	lw	r1, 4(r2)
	addi	r5, r0, 118
	lw	r29, 4(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r1, r0, 3
	lw	r29, 3(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r29, 2(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 5(r3)
	lw	r1, 4(r1)
	addi	r2, r0, 119
	lw	r29, 1(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r1, r0, 3
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
add_reflection.3307:
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	addi	r9, r0, 3
	flup	f5, 0		# fli	f5, 0.000000
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	fsw	f1, 4(r3)
	sw	r8, 6(r3)
	sw	r6, 7(r3)
	fsw	f4, 8(r3)
	fsw	f3, 10(r3)
	fsw	f2, 12(r3)
	sw	r7, 14(r3)
	add	r1, r0, r9				# mr	r1, r9
	fadd	f1, f0, f5				# fmr	f1, f5
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 14(r3)
	lw	r5, 0(r1)
	sw	r2, 15(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r31, 16(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r5, 15(r3)
	sw	r5, 0(r2)
	flw	f1, 12(r3)
	fsw	f1, 0(r5)
	flw	f1, 10(r3)
	fsw	f1, 1(r5)
	flw	f1, 8(r3)
	fsw	f1, 2(r5)
	lw	r6, 14(r3)
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r2, 16(r3)
	ble	r7, r6, ble_then.14148
	j	ble_cont.14149
ble_then.14148:
	lw	r7, 7(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.14150
	beqi	2, r8, beq_then.14152
	sw	r6, 17(r3)
	sw	r1, 18(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_second_table.3079				#	bl	setup_second_table.3079
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.14153
beq_then.14152:
	sw	r6, 17(r3)
	sw	r1, 18(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_surface_table.3076				#	bl	setup_surface_table.3076
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14153:
	j	beq_cont.14151
beq_then.14150:
	sw	r6, 17(r3)
	sw	r1, 18(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_rect_table.3073				#	bl	setup_rect_table.3073
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14151:
	addi	r2, r2, -1
	lw	r1, 16(r3)
	lw	r29, 6(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
ble_cont.14149:
	add	r1, r0, r4
	addi	r4, r4, 3
	flw	f1, 4(r3)
	fsw	f1, 2(r1)
	lw	r2, 16(r3)
	sw	r2, 1(r1)
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	jr	r31				#
setup_rect_reflection.3314:
	lw	r5, 6(r29)
	lw	r6, 5(r29)
	lw	r7, 4(r29)
	lw	r8, 3(r29)
	lw	r9, 2(r29)
	lw	r10, 1(r29)
	slli	r1, r1, 2
	lw	r11, 0(r7)
	flup	f1, 2		# fli	f1, 1.000000
	lw	r2, 7(r2)
	flw	f2, 0(r2)
	fsub	f1, f1, f2
	flw	f2, 0(r9)
	fneg	f2, f2
	flw	f3, 1(r9)
	fneg	f3, f3
	flw	f4, 2(r9)
	fneg	f4, f4
	addi	r2, r1, 1
	flw	f5, 0(r9)
	addi	r12, r0, 3
	flup	f6, 0		# fli	f6, 0.000000
	sw	r7, 0(r3)
	fsw	f2, 2(r3)
	sw	r9, 4(r3)
	sw	r1, 5(r3)
	sw	r11, 6(r3)
	sw	r5, 7(r3)
	sw	r2, 8(r3)
	fsw	f1, 10(r3)
	sw	r10, 12(r3)
	sw	r6, 13(r3)
	fsw	f4, 14(r3)
	fsw	f3, 16(r3)
	fsw	f5, 18(r3)
	sw	r8, 20(r3)
	add	r1, r0, r12				# mr	r1, r12
	fadd	f1, f0, f6				# fmr	f1, f6
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -22
	lw	r31, 21(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 20(r3)
	lw	r5, 0(r1)
	sw	r2, 21(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -23
	lw	r31, 22(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r5, 21(r3)
	sw	r5, 0(r2)
	flw	f1, 18(r3)
	fsw	f1, 0(r5)
	flw	f1, 16(r3)
	fsw	f1, 1(r5)
	flw	f2, 14(r3)
	fsw	f2, 2(r5)
	lw	r6, 20(r3)
	lw	r7, 0(r6)
	addi	r7, r7, -1
	addi	r8, r0, 0
	sw	r2, 22(r3)
	ble	r8, r7, ble_then.14157
	j	ble_cont.14158
ble_then.14157:
	lw	r8, 13(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r9)
	beqi	1, r10, beq_then.14159
	beqi	2, r10, beq_then.14161
	sw	r7, 23(r3)
	sw	r1, 24(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_second_table.3079				#	bl	setup_second_table.3079
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 24(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.14162
beq_then.14161:
	sw	r7, 23(r3)
	sw	r1, 24(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_surface_table.3076				#	bl	setup_surface_table.3076
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 24(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14162:
	j	beq_cont.14160
beq_then.14159:
	sw	r7, 23(r3)
	sw	r1, 24(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_rect_table.3073				#	bl	setup_rect_table.3073
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 24(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14160:
	addi	r2, r2, -1
	lw	r1, 22(r3)
	lw	r29, 12(r3)
	sw	r31, 25(r3)
	addi	r3, r3, 26
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -26
	lw	r31, 25(r3)
ble_cont.14158:
	add	r1, r0, r4
	addi	r4, r4, 3
	flw	f1, 10(r3)
	fsw	f1, 2(r1)
	lw	r2, 22(r3)
	sw	r2, 1(r1)
	lw	r2, 8(r3)
	sw	r2, 0(r1)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	r6, 5(r3)
	addi	r7, r6, 2
	lw	r8, 4(r3)
	flw	f2, 1(r8)
	addi	r9, r0, 3
	flup	f3, 0		# fli	f3, 0.000000
	sw	r1, 25(r3)
	sw	r7, 26(r3)
	fsw	f2, 28(r3)
	add	r1, r0, r9				# mr	r1, r9
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -31
	lw	r31, 30(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 20(r3)
	lw	r5, 0(r1)
	sw	r2, 30(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r31, 31(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r5, 30(r3)
	sw	r5, 0(r2)
	flw	f1, 2(r3)
	fsw	f1, 0(r5)
	flw	f2, 28(r3)
	fsw	f2, 1(r5)
	flw	f2, 14(r3)
	fsw	f2, 2(r5)
	lw	r6, 20(r3)
	lw	r7, 0(r6)
	addi	r7, r7, -1
	addi	r8, r0, 0
	sw	r2, 31(r3)
	ble	r8, r7, ble_then.14164
	j	ble_cont.14165
ble_then.14164:
	lw	r8, 13(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r9)
	beqi	1, r10, beq_then.14166
	beqi	2, r10, beq_then.14168
	sw	r7, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_second_table.3079				#	bl	setup_second_table.3079
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.14169
beq_then.14168:
	sw	r7, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_surface_table.3076				#	bl	setup_surface_table.3076
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14169:
	j	beq_cont.14167
beq_then.14166:
	sw	r7, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_rect_table.3073				#	bl	setup_rect_table.3073
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14167:
	addi	r2, r2, -1
	lw	r1, 31(r3)
	lw	r29, 12(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -35
	lw	r31, 34(r3)
ble_cont.14165:
	add	r1, r0, r4
	addi	r4, r4, 3
	flw	f1, 10(r3)
	fsw	f1, 2(r1)
	lw	r2, 31(r3)
	sw	r2, 1(r1)
	lw	r2, 26(r3)
	sw	r2, 0(r1)
	lw	r2, 25(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 6(r3)
	addi	r2, r1, 2
	lw	r6, 5(r3)
	addi	r6, r6, 3
	lw	r7, 4(r3)
	flw	f2, 2(r7)
	addi	r7, r0, 3
	flup	f3, 0		# fli	f3, 0.000000
	sw	r2, 34(r3)
	sw	r6, 35(r3)
	fsw	f2, 36(r3)
	add	r1, r0, r7				# mr	r1, r7
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 38(r3)
	addi	r3, r3, 39
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -39
	lw	r31, 38(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 20(r3)
	lw	r5, 0(r1)
	sw	r2, 38(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 39(r3)
	addi	r3, r3, 40
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -40
	lw	r31, 39(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r5, 38(r3)
	sw	r5, 0(r2)
	flw	f1, 2(r3)
	fsw	f1, 0(r5)
	flw	f1, 16(r3)
	fsw	f1, 1(r5)
	flw	f1, 36(r3)
	fsw	f1, 2(r5)
	lw	r6, 20(r3)
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r2, 39(r3)
	ble	r7, r6, ble_then.14170
	j	ble_cont.14171
ble_then.14170:
	lw	r7, 13(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.14172
	beqi	2, r8, beq_then.14174
	sw	r6, 40(r3)
	sw	r1, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	setup_second_table.3079				#	bl	setup_second_table.3079
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 40(r3)
	lw	r5, 41(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.14175
beq_then.14174:
	sw	r6, 40(r3)
	sw	r1, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	setup_surface_table.3076				#	bl	setup_surface_table.3076
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 40(r3)
	lw	r5, 41(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14175:
	j	beq_cont.14173
beq_then.14172:
	sw	r6, 40(r3)
	sw	r1, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	setup_rect_table.3073				#	bl	setup_rect_table.3073
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 40(r3)
	lw	r5, 41(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14173:
	addi	r2, r2, -1
	lw	r1, 39(r3)
	lw	r29, 12(r3)
	sw	r31, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -43
	lw	r31, 42(r3)
ble_cont.14171:
	add	r1, r0, r4
	addi	r4, r4, 3
	flw	f1, 10(r3)
	fsw	f1, 2(r1)
	lw	r2, 39(r3)
	sw	r2, 1(r1)
	lw	r2, 35(r3)
	sw	r2, 0(r1)
	lw	r2, 34(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 6(r3)
	addi	r1, r1, 3
	lw	r2, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#
setup_surface_reflection.3317:
	lw	r5, 6(r29)
	lw	r6, 5(r29)
	lw	r7, 4(r29)
	lw	r8, 3(r29)
	lw	r9, 2(r29)
	lw	r10, 1(r29)
	slli	r1, r1, 2
	addi	r1, r1, 1
	lw	r11, 0(r7)
	flup	f1, 2		# fli	f1, 1.000000
	lw	r12, 7(r2)
	flw	f2, 0(r12)
	fsub	f1, f1, f2
	lw	r12, 4(r2)
	sw	r7, 0(r3)
	sw	r11, 1(r3)
	sw	r5, 2(r3)
	sw	r1, 3(r3)
	fsw	f1, 4(r3)
	sw	r10, 6(r3)
	sw	r6, 7(r3)
	sw	r8, 8(r3)
	sw	r9, 9(r3)
	sw	r2, 10(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	veciprod.2870				#	bl	veciprod.2870
	addi	r3, r3, -12
	lw	r31, 11(r3)
	flup	f2, 3		# fli	f2, 2.000000
	lw	r1, 10(r3)
	lw	r2, 4(r1)
	flw	f3, 0(r2)
	fmul	f2, f2, f3
	fmul	f2, f2, f1
	lw	r2, 9(r3)
	flw	f3, 0(r2)
	fsub	f2, f2, f3
	flup	f3, 3		# fli	f3, 2.000000
	lw	r5, 4(r1)
	flw	f4, 1(r5)
	fmul	f3, f3, f4
	fmul	f3, f3, f1
	flw	f4, 1(r2)
	fsub	f3, f3, f4
	flup	f4, 3		# fli	f4, 2.000000
	lw	r1, 4(r1)
	flw	f5, 2(r1)
	fmul	f4, f4, f5
	fmul	f1, f4, f1
	flw	f4, 2(r2)
	fsub	f1, f1, f4
	addi	r1, r0, 3
	flup	f4, 0		# fli	f4, 0.000000
	fsw	f1, 12(r3)
	fsw	f3, 14(r3)
	fsw	f2, 16(r3)
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -19
	lw	r31, 18(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 8(r3)
	lw	r5, 0(r1)
	sw	r2, 18(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -20
	lw	r31, 19(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r5, 18(r3)
	sw	r5, 0(r2)
	flw	f1, 16(r3)
	fsw	f1, 0(r5)
	flw	f1, 14(r3)
	fsw	f1, 1(r5)
	flw	f1, 12(r3)
	fsw	f1, 2(r5)
	lw	r6, 8(r3)
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r2, 19(r3)
	ble	r7, r6, ble_then.14178
	j	ble_cont.14179
ble_then.14178:
	lw	r7, 7(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.14180
	beqi	2, r8, beq_then.14182
	sw	r6, 20(r3)
	sw	r1, 21(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	setup_second_table.3079				#	bl	setup_second_table.3079
	addi	r3, r3, -23
	lw	r31, 22(r3)
	lw	r2, 20(r3)
	lw	r5, 21(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.14183
beq_then.14182:
	sw	r6, 20(r3)
	sw	r1, 21(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	setup_surface_table.3076				#	bl	setup_surface_table.3076
	addi	r3, r3, -23
	lw	r31, 22(r3)
	lw	r2, 20(r3)
	lw	r5, 21(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14183:
	j	beq_cont.14181
beq_then.14180:
	sw	r6, 20(r3)
	sw	r1, 21(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	setup_rect_table.3073				#	bl	setup_rect_table.3073
	addi	r3, r3, -23
	lw	r31, 22(r3)
	lw	r2, 20(r3)
	lw	r5, 21(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14181:
	addi	r2, r2, -1
	lw	r1, 19(r3)
	lw	r29, 6(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
ble_cont.14179:
	add	r1, r0, r4
	addi	r4, r4, 3
	flw	f1, 4(r3)
	fsw	f1, 2(r1)
	lw	r2, 19(r3)
	sw	r2, 1(r1)
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	r2, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#
setup_reflections.3320:
	lw	r2, 3(r29)
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.14185
	jr	r31				#
ble_then.14185:
	add	r30, r6, r1
	lw	r6, 0(r30)
	lw	r7, 2(r6)
	beqi	2, r7, beq_then.14187
	jr	r31				#
beq_then.14187:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r7, 7(r6)
	flw	f2, 0(r7)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.14189
	jr	r31				#
fle_else.14189:
	lw	r7, 1(r6)
	beqi	1, r7, beq_then.14191
	beqi	2, r7, beq_then.14192
	jr	r31				#
beq_then.14192:
	add	r29, r0, r2				# mr	r29, r2
	add	r2, r0, r6				# mr	r2, r6
	lw	r28, 0(r29)
	jr	r28
beq_then.14191:
	add	r2, r0, r6				# mr	r2, r6
	add	r29, r0, r5				# mr	r29, r5
	lw	r28, 0(r29)
	jr	r28
rt.3322:
	lw	r5, 26(r29)
	lw	r6, 25(r29)
	lw	r7, 24(r29)
	lw	r8, 23(r29)
	lw	r9, 22(r29)
	lw	r10, 21(r29)
	lw	r11, 20(r29)
	lw	r12, 19(r29)
	lw	r13, 18(r29)
	lw	r14, 17(r29)
	lw	r15, 16(r29)
	lw	r16, 15(r29)
	lw	r17, 14(r29)
	lw	r18, 13(r29)
	lw	r19, 12(r29)
	lw	r20, 11(r29)
	lw	r21, 10(r29)
	lw	r22, 9(r29)
	lw	r23, 8(r29)
	lw	r24, 7(r29)
	lw	r25, 6(r29)
	lw	r26, 5(r29)
	lw	r27, 4(r29)
	lw	r28, 3(r29)
	sw	r10, 0(r3)
	lw	r10, 2(r29)
	lw	r29, 1(r29)
	sw	r1, 0(r25)
	sw	r2, 1(r25)
	sw	r16, 1(r3)
	srai	r16, r1, 1
	sw	r16, 0(r26)
	srai	r2, r2, 1
	sw	r2, 1(r26)
	flup	f1, 49		# fli	f1, 128.000000
	itof	f2, r1
	fdiv	f1, f1, f2
	fsw	f1, 0(r9)
	lw	r1, 0(r25)
	sw	r7, 2(r3)
	sw	r8, 3(r3)
	sw	r20, 4(r3)
	sw	r22, 5(r3)
	sw	r10, 6(r3)
	sw	r18, 7(r3)
	sw	r6, 8(r3)
	sw	r21, 9(r3)
	sw	r23, 10(r3)
	sw	r29, 11(r3)
	sw	r28, 12(r3)
	sw	r5, 13(r3)
	sw	r17, 14(r3)
	sw	r15, 15(r3)
	sw	r12, 16(r3)
	sw	r19, 17(r3)
	sw	r13, 18(r3)
	sw	r14, 19(r3)
	sw	r11, 20(r3)
	sw	r24, 21(r3)
	sw	r27, 22(r3)
	sw	r25, 23(r3)
	sw	r1, 24(r3)
	add	r29, r0, r27				# mr	r29, r27
	sw	r31, 25(r3)
	addi	r3, r3, 26
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -26
	lw	r31, 25(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 24(r3)
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 0(r2)
	addi	r5, r5, -2
	addi	r6, r0, 0
	ble	r6, r5, ble_then.14194
	j	ble_cont.14195
ble_then.14194:
	lw	r29, 22(r3)
	sw	r5, 25(r3)
	sw	r1, 26(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
	lw	r2, 25(r3)
	lw	r5, 26(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14196
	add	r1, r0, r5
	j	ble_cont.14197
ble_then.14196:
	lw	r29, 22(r3)
	sw	r1, 27(r3)
	sw	r31, 28(r3)
	addi	r3, r3, 29
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -29
	lw	r31, 28(r3)
	lw	r2, 27(r3)
	lw	r5, 26(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 21(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 28(r3)
	addi	r3, r3, 29
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -29
	lw	r31, 28(r3)
ble_cont.14197:
ble_cont.14195:
	lw	r2, 23(r3)
	lw	r5, 0(r2)
	lw	r29, 22(r3)
	sw	r1, 28(r3)
	sw	r5, 29(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -31
	lw	r31, 30(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 29(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -31
	lw	r31, 30(r3)
	lw	r2, 23(r3)
	lw	r5, 0(r2)
	addi	r5, r5, -2
	addi	r6, r0, 0
	ble	r6, r5, ble_then.14198
	j	ble_cont.14199
ble_then.14198:
	lw	r29, 22(r3)
	sw	r5, 30(r3)
	sw	r1, 31(r3)
	sw	r31, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -33
	lw	r31, 32(r3)
	lw	r2, 30(r3)
	lw	r5, 31(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14200
	add	r1, r0, r5
	j	ble_cont.14201
ble_then.14200:
	lw	r29, 22(r3)
	sw	r1, 32(r3)
	sw	r31, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r2, 32(r3)
	lw	r5, 31(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 21(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -34
	lw	r31, 33(r3)
ble_cont.14201:
ble_cont.14199:
	lw	r2, 23(r3)
	lw	r5, 0(r2)
	lw	r29, 22(r3)
	sw	r1, 33(r3)
	sw	r5, 34(r3)
	sw	r31, 35(r3)
	addi	r3, r3, 36
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -36
	lw	r31, 35(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 34(r3)
	sw	r31, 35(r3)
	addi	r3, r3, 36
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -36
	lw	r31, 35(r3)
	lw	r2, 23(r3)
	lw	r2, 0(r2)
	addi	r2, r2, -2
	addi	r5, r0, 0
	ble	r5, r2, ble_then.14202
	j	ble_cont.14203
ble_then.14202:
	lw	r29, 22(r3)
	sw	r2, 35(r3)
	sw	r1, 36(r3)
	sw	r31, 37(r3)
	addi	r3, r3, 38
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -38
	lw	r31, 37(r3)
	lw	r2, 35(r3)
	lw	r5, 36(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14204
	add	r1, r0, r5
	j	ble_cont.14205
ble_then.14204:
	lw	r29, 22(r3)
	sw	r1, 37(r3)
	sw	r31, 38(r3)
	addi	r3, r3, 39
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -39
	lw	r31, 38(r3)
	lw	r2, 37(r3)
	lw	r5, 36(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 21(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 38(r3)
	addi	r3, r3, 39
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -39
	lw	r31, 38(r3)
ble_cont.14205:
ble_cont.14203:
	lw	r29, 20(r3)
	sw	r1, 38(r3)
	sw	r31, 39(r3)
	addi	r3, r3, 40
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -40
	lw	r31, 39(r3)
	lw	r29, 19(r3)
	sw	r31, 39(r3)
	addi	r3, r3, 40
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -40
	lw	r31, 39(r3)
	addi	r1, r0, 0
	lw	r29, 18(r3)
	sw	r1, 39(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
	beqi	0, r1, beq_then.14206
	addi	r1, r0, 1
	lw	r29, 16(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
	j	beq_cont.14207
beq_then.14206:
	lw	r1, 17(r3)
	lw	r2, 39(r3)
	sw	r2, 0(r1)
beq_cont.14207:
	addi	r1, r0, 0
	lw	r29, 15(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
	addi	r1, r0, 0
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	read_or_network.2983				#	bl	read_or_network.2983
	addi	r3, r3, -41
	lw	r31, 40(r3)
	lw	r2, 14(r3)
	sw	r1, 0(r2)
	lw	r29, 13(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
	addi	r1, r0, 4
	lw	r29, 12(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r29, 11(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
	addi	r1, r0, 4
	lw	r29, 10(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
	lw	r1, 9(r3)
	flw	f1, 0(r1)
	lw	r2, 8(r3)
	fsw	f1, 0(r2)
	flw	f1, 1(r1)
	fsw	f1, 1(r2)
	flw	f1, 2(r1)
	fsw	f1, 2(r2)
	lw	r1, 17(r3)
	lw	r5, 0(r1)
	addi	r5, r5, -1
	addi	r6, r0, 0
	ble	r6, r5, ble_then.14208
	j	ble_cont.14209
ble_then.14208:
	lw	r6, 7(r3)
	add	r30, r6, r5
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.14210
	beqi	2, r8, beq_then.14212
	sw	r5, 40(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r7				# mr	r2, r7
	sw	r31, 41(r3)
	addi	r3, r3, 42
	jal	setup_second_table.3079				#	bl	setup_second_table.3079
	addi	r3, r3, -42
	lw	r31, 41(r3)
	lw	r2, 40(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.14213
beq_then.14212:
	sw	r5, 40(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r7				# mr	r2, r7
	sw	r31, 41(r3)
	addi	r3, r3, 42
	jal	setup_surface_table.3076				#	bl	setup_surface_table.3076
	addi	r3, r3, -42
	lw	r31, 41(r3)
	lw	r2, 40(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14213:
	j	beq_cont.14211
beq_then.14210:
	sw	r5, 40(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r7				# mr	r2, r7
	sw	r31, 41(r3)
	addi	r3, r3, 42
	jal	setup_rect_table.3073				#	bl	setup_rect_table.3073
	addi	r3, r3, -42
	lw	r31, 41(r3)
	lw	r2, 40(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.14211:
	addi	r2, r2, -1
	lw	r1, 4(r3)
	lw	r29, 5(r3)
	sw	r31, 41(r3)
	addi	r3, r3, 42
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -42
	lw	r31, 41(r3)
ble_cont.14209:
	lw	r1, 17(r3)
	lw	r1, 0(r1)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.14214
	j	ble_cont.14215
ble_then.14214:
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.14216
	j	beq_cont.14217
beq_then.14216:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 7(r2)
	flw	f2, 0(r5)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.14218
	j	fle_cont.14219
fle_else.14218:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.14220
	beqi	2, r5, beq_then.14222
	j	beq_cont.14223
beq_then.14222:
	lw	r29, 2(r3)
	sw	r31, 41(r3)
	addi	r3, r3, 42
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -42
	lw	r31, 41(r3)
beq_cont.14223:
	j	beq_cont.14221
beq_then.14220:
	lw	r29, 3(r3)
	sw	r31, 41(r3)
	addi	r3, r3, 42
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -42
	lw	r31, 41(r3)
beq_cont.14221:
fle_cont.14219:
beq_cont.14217:
ble_cont.14215:
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r1, 33(r3)
	lw	r29, 1(r3)
	sw	r31, 41(r3)
	addi	r3, r3, 42
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -42
	lw	r31, 41(r3)
	addi	r1, r0, 0
	addi	r7, r0, 2
	lw	r2, 28(r3)
	lw	r5, 33(r3)
	lw	r6, 38(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
_R_0:
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
	addi	r1, r0, 1
	addi	r2, r0, 0
	addi	r5, r0, 1
	addi	r6, r0, 0
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r2, r0, 0
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 60
	addi	r5, r0, 0
	addi	r6, r0, 0
	addi	r7, r0, 0
	addi	r8, r0, 0
	add	r9, r0, r4
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
	add	r1, r0, r9
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 4(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r2, r0, 1
	flup	f1, 37		# fli	f1, 255.000000
	sw	r1, 6(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r2, r0, 50
	addi	r5, r0, 1
	addi	r6, r0, -1
	sw	r1, 7(r3)
	sw	r2, 8(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r2, r0, 1
	addi	r5, r0, 1
	lw	r6, 0(r1)
	sw	r1, 9(r3)
	sw	r2, 10(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r2, r0, 1
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 11(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 12(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r2, r0, 1
	flup	f1, 31		# fli	f1, 1000000000.000000
	sw	r1, 13(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 14(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -16
	lw	r31, 15(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 15(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r31, 16(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 16(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -18
	lw	r31, 17(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 17(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -19
	lw	r31, 18(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 18(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -20
	lw	r31, 19(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 19(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -21
	lw	r31, 20(r3)
	addi	r2, r0, 2
	addi	r5, r0, 0
	sw	r1, 20(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -22
	lw	r31, 21(r3)
	addi	r2, r0, 2
	addi	r5, r0, 0
	sw	r1, 21(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -23
	lw	r31, 22(r3)
	addi	r2, r0, 1
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 22(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -24
	lw	r31, 23(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 23(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -25
	lw	r31, 24(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 24(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -26
	lw	r31, 25(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 25(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -27
	lw	r31, 26(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 26(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 27(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -29
	lw	r31, 28(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 28(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -30
	lw	r31, 29(r3)
	addi	r2, r0, 0
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 29(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -31
	lw	r31, 30(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 0
	sw	r2, 30(r3)
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r31, 31(r3)
	addi	r2, r0, 0
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r5)
	lw	r1, 30(r3)
	sw	r1, 0(r5)
	add	r1, r0, r5
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r31, 31(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 5
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r31, 31(r3)
	addi	r2, r0, 0
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 31(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -33
	lw	r31, 32(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 32(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -34
	lw	r31, 33(r3)
	addi	r2, r0, 60
	lw	r5, 32(r3)
	sw	r1, 33(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -35
	lw	r31, 34(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r5, 33(r3)
	sw	r5, 0(r2)
	addi	r6, r0, 0
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 34(r3)
	sw	r2, 35(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -37
	lw	r31, 36(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 0
	sw	r2, 36(r3)
	sw	r31, 37(r3)
	addi	r3, r3, 38
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -38
	lw	r31, 37(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 36(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	addi	r2, r0, 180
	addi	r5, r0, 0
	flup	f1, 0		# fli	f1, 0.000000
	add	r6, r0, r4
	addi	r4, r4, 3
	fsw	f1, 2(r6)
	sw	r1, 1(r6)
	sw	r5, 0(r6)
	add	r1, r0, r6
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 37(r3)
	addi	r3, r3, 38
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -38
	lw	r31, 37(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 37(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 38(r3)
	addi	r3, r3, 39
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -39
	lw	r31, 38(r3)
	add	r2, r0, r4
	addi	r4, r4, 6
	addi	r5, r0, read_screen_settings.2968
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
	add	r9, r0, r4
	addi	r4, r4, 3
	addi	r10, r0, read_light.2970
	sw	r10, 0(r9)
	lw	r10, 6(r3)
	sw	r10, 2(r9)
	lw	r11, 7(r3)
	sw	r11, 1(r9)
	add	r12, r0, r4
	addi	r4, r4, 2
	addi	r13, r0, read_nth_object.2975
	sw	r13, 0(r12)
	lw	r13, 3(r3)
	sw	r13, 1(r12)
	add	r14, r0, r4
	addi	r4, r4, 3
	addi	r15, r0, read_object.2977
	sw	r15, 0(r14)
	sw	r12, 2(r14)
	lw	r15, 2(r3)
	sw	r15, 1(r14)
	add	r16, r0, r4
	addi	r4, r4, 2
	addi	r17, r0, read_and_network.2985
	sw	r17, 0(r16)
	lw	r17, 9(r3)
	sw	r17, 1(r16)
	add	r18, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, solver_rect_surface.2989
	sw	r19, 0(r18)
	lw	r19, 12(r3)
	sw	r19, 1(r18)
	add	r20, r0, r4
	addi	r4, r4, 2
	addi	r21, r0, solver_rect.2998
	sw	r21, 0(r20)
	sw	r18, 1(r20)
	add	r18, r0, r4
	addi	r4, r4, 2
	addi	r21, r0, solver_second.3023
	sw	r21, 0(r18)
	sw	r19, 1(r18)
	add	r21, r0, r4
	addi	r4, r4, 5
	addi	r22, r0, solver.3029
	sw	r22, 0(r21)
	sw	r18, 4(r21)
	sw	r20, 3(r21)
	sw	r19, 2(r21)
	sw	r13, 1(r21)
	add	r18, r0, r4
	addi	r4, r4, 2
	addi	r20, r0, solver_rect_fast.3033
	sw	r20, 0(r18)
	sw	r19, 1(r18)
	add	r20, r0, r4
	addi	r4, r4, 2
	addi	r22, r0, solver_surface_fast.3040
	sw	r22, 0(r20)
	sw	r19, 1(r20)
	add	r22, r0, r4
	addi	r4, r4, 2
	addi	r23, r0, solver_second_fast.3046
	sw	r23, 0(r22)
	sw	r19, 1(r22)
	add	r23, r0, r4
	addi	r4, r4, 5
	addi	r24, r0, solver_fast.3052
	sw	r24, 0(r23)
	sw	r20, 4(r23)
	sw	r22, 3(r23)
	sw	r18, 2(r23)
	sw	r13, 1(r23)
	add	r20, r0, r4
	addi	r4, r4, 2
	addi	r22, r0, solver_second_fast2.3063
	sw	r22, 0(r20)
	sw	r19, 1(r20)
	add	r22, r0, r4
	addi	r4, r4, 5
	addi	r24, r0, solver_fast2.3070
	sw	r24, 0(r22)
	sw	r20, 4(r22)
	sw	r18, 3(r22)
	sw	r19, 2(r22)
	sw	r13, 1(r22)
	add	r18, r0, r4
	addi	r4, r4, 2
	addi	r20, r0, iter_setup_dirvec_constants.3082
	sw	r20, 0(r18)
	sw	r13, 1(r18)
	add	r20, r0, r4
	addi	r4, r4, 2
	addi	r24, r0, setup_startp_constants.3087
	sw	r24, 0(r20)
	sw	r13, 1(r20)
	add	r24, r0, r4
	addi	r4, r4, 4
	addi	r25, r0, setup_startp.3090
	sw	r25, 0(r24)
	lw	r25, 25(r3)
	sw	r25, 3(r24)
	sw	r20, 2(r24)
	sw	r15, 1(r24)
	add	r26, r0, r4
	addi	r4, r4, 2
	addi	r27, r0, check_all_inside.3112
	sw	r27, 0(r26)
	sw	r13, 1(r26)
	add	r27, r0, r4
	addi	r4, r4, 8
	addi	r28, r0, shadow_check_and_group.3118
	sw	r28, 0(r27)
	sw	r23, 7(r27)
	sw	r19, 6(r27)
	sw	r13, 5(r27)
	lw	r28, 35(r3)
	sw	r28, 4(r27)
	sw	r10, 3(r27)
	lw	r29, 15(r3)
	sw	r29, 2(r27)
	sw	r26, 1(r27)
	sw	r16, 38(r3)
	add	r16, r0, r4
	addi	r4, r4, 3
	sw	r9, 39(r3)
	addi	r9, r0, shadow_check_one_or_group.3121
	sw	r9, 0(r16)
	sw	r27, 2(r16)
	sw	r17, 1(r16)
	add	r9, r0, r4
	addi	r4, r4, 8
	sw	r12, 40(r3)
	addi	r12, r0, shadow_check_one_or_matrix.3124
	sw	r12, 0(r9)
	sw	r23, 7(r9)
	sw	r19, 6(r9)
	sw	r16, 5(r9)
	sw	r27, 4(r9)
	sw	r28, 3(r9)
	sw	r29, 2(r9)
	sw	r17, 1(r9)
	add	r12, r0, r4
	addi	r4, r4, 10
	addi	r16, r0, solve_each_element.3127
	sw	r16, 0(r12)
	lw	r16, 14(r3)
	sw	r16, 9(r12)
	lw	r23, 24(r3)
	sw	r23, 8(r12)
	sw	r19, 7(r12)
	sw	r21, 6(r12)
	sw	r13, 5(r12)
	lw	r27, 13(r3)
	sw	r27, 4(r12)
	sw	r29, 3(r12)
	lw	r28, 16(r3)
	sw	r28, 2(r12)
	sw	r26, 1(r12)
	sw	r14, 41(r3)
	add	r14, r0, r4
	addi	r4, r4, 3
	sw	r2, 42(r3)
	addi	r2, r0, solve_one_or_network.3131
	sw	r2, 0(r14)
	sw	r12, 2(r14)
	sw	r17, 1(r14)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r18, 43(r3)
	addi	r18, r0, trace_or_matrix.3135
	sw	r18, 0(r2)
	sw	r16, 7(r2)
	sw	r23, 6(r2)
	sw	r19, 5(r2)
	sw	r21, 4(r2)
	sw	r14, 3(r2)
	sw	r12, 2(r2)
	sw	r17, 1(r2)
	add	r12, r0, r4
	addi	r4, r4, 10
	addi	r14, r0, solve_each_element_fast.3141
	sw	r14, 0(r12)
	sw	r16, 9(r12)
	sw	r25, 8(r12)
	sw	r22, 7(r12)
	sw	r19, 6(r12)
	sw	r13, 5(r12)
	sw	r27, 4(r12)
	sw	r29, 3(r12)
	sw	r28, 2(r12)
	sw	r26, 1(r12)
	add	r14, r0, r4
	addi	r4, r4, 3
	addi	r18, r0, solve_one_or_network_fast.3145
	sw	r18, 0(r14)
	sw	r12, 2(r14)
	sw	r17, 1(r14)
	add	r18, r0, r4
	addi	r4, r4, 7
	addi	r21, r0, trace_or_matrix_fast.3149
	sw	r21, 0(r18)
	sw	r16, 6(r18)
	sw	r22, 5(r18)
	sw	r19, 4(r18)
	sw	r14, 3(r18)
	sw	r12, 2(r18)
	sw	r17, 1(r18)
	add	r12, r0, r4
	addi	r4, r4, 3
	addi	r14, r0, get_nvector_rect.3155
	sw	r14, 0(r12)
	lw	r14, 17(r3)
	sw	r14, 2(r12)
	sw	r27, 1(r12)
	add	r17, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, get_nvector_plane.3157
	sw	r19, 0(r17)
	sw	r14, 1(r17)
	add	r19, r0, r4
	addi	r4, r4, 3
	addi	r21, r0, get_nvector_second.3159
	sw	r21, 0(r19)
	sw	r14, 2(r19)
	sw	r29, 1(r19)
	add	r21, r0, r4
	addi	r4, r4, 2
	addi	r22, r0, utexture.3164
	sw	r22, 0(r21)
	lw	r22, 18(r3)
	sw	r22, 1(r21)
	add	r26, r0, r4
	addi	r4, r4, 3
	addi	r7, r0, add_light.3167
	sw	r7, 0(r26)
	sw	r22, 2(r26)
	lw	r7, 20(r3)
	sw	r7, 1(r26)
	add	r6, r0, r4
	addi	r4, r4, 10
	addi	r8, r0, trace_reflections.3171
	sw	r8, 0(r6)
	sw	r18, 9(r6)
	sw	r16, 8(r6)
	sw	r9, 7(r6)
	lw	r8, 37(r3)
	sw	r8, 6(r6)
	lw	r8, 11(r3)
	sw	r8, 5(r6)
	sw	r14, 4(r6)
	sw	r27, 3(r6)
	sw	r28, 2(r6)
	sw	r26, 1(r6)
	add	r5, r0, r4
	addi	r4, r4, 27
	sw	r24, 44(r3)
	addi	r24, r0, trace_ray.3176
	sw	r24, 0(r5)
	sw	r21, 26(r5)
	lw	r24, 0(r3)
	sw	r24, 25(r5)
	sw	r6, 24(r5)
	sw	r2, 23(r5)
	sw	r16, 22(r5)
	sw	r22, 21(r5)
	sw	r25, 20(r5)
	sw	r23, 19(r5)
	sw	r9, 18(r5)
	sw	r20, 17(r5)
	sw	r7, 16(r5)
	sw	r8, 15(r5)
	sw	r13, 14(r5)
	sw	r14, 13(r5)
	sw	r1, 12(r5)
	sw	r15, 11(r5)
	sw	r10, 10(r5)
	sw	r27, 9(r5)
	sw	r29, 8(r5)
	sw	r28, 7(r5)
	sw	r19, 6(r5)
	sw	r12, 5(r5)
	sw	r17, 4(r5)
	lw	r2, 1(r3)
	sw	r2, 3(r5)
	sw	r11, 2(r5)
	sw	r26, 1(r5)
	add	r6, r0, r4
	addi	r4, r4, 16
	addi	r11, r0, trace_diffuse_ray.3182
	sw	r11, 0(r6)
	sw	r21, 15(r6)
	sw	r18, 14(r6)
	sw	r16, 13(r6)
	sw	r22, 12(r6)
	sw	r9, 11(r6)
	sw	r8, 10(r6)
	sw	r13, 9(r6)
	sw	r14, 8(r6)
	sw	r10, 7(r6)
	sw	r29, 6(r6)
	sw	r28, 5(r6)
	sw	r19, 4(r6)
	sw	r12, 3(r6)
	sw	r17, 2(r6)
	lw	r9, 19(r3)
	sw	r9, 1(r6)
	add	r11, r0, r4
	addi	r4, r4, 2
	addi	r12, r0, iter_trace_diffuse_rays.3185
	sw	r12, 0(r11)
	sw	r6, 1(r11)
	add	r6, r0, r4
	addi	r4, r4, 4
	addi	r12, r0, trace_diffuse_ray_80percent.3194
	sw	r12, 0(r6)
	lw	r12, 44(r3)
	sw	r12, 3(r6)
	sw	r11, 2(r6)
	lw	r14, 31(r3)
	sw	r14, 1(r6)
	add	r16, r0, r4
	addi	r4, r4, 4
	addi	r17, r0, calc_diffuse_using_1point.3198
	sw	r17, 0(r16)
	sw	r6, 3(r16)
	sw	r7, 2(r16)
	sw	r9, 1(r16)
	add	r17, r0, r4
	addi	r4, r4, 3
	addi	r18, r0, calc_diffuse_using_5points.3201
	sw	r18, 0(r17)
	sw	r7, 2(r17)
	sw	r9, 1(r17)
	add	r18, r0, r4
	addi	r4, r4, 5
	addi	r19, r0, do_without_neighbors.3207
	sw	r19, 0(r18)
	sw	r6, 4(r18)
	sw	r7, 3(r18)
	sw	r9, 2(r18)
	sw	r16, 1(r18)
	add	r6, r0, r4
	addi	r4, r4, 4
	addi	r19, r0, try_exploit_neighbors.3223
	sw	r19, 0(r6)
	sw	r18, 3(r6)
	sw	r17, 2(r6)
	sw	r16, 1(r6)
	add	r17, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, write_ppm_header.3230
	sw	r19, 0(r17)
	lw	r19, 21(r3)
	sw	r19, 1(r17)
	add	r20, r0, r4
	addi	r4, r4, 5
	addi	r21, r0, pretrace_diffuse_rays.3236
	sw	r21, 0(r20)
	sw	r12, 4(r20)
	sw	r11, 3(r20)
	sw	r14, 2(r20)
	sw	r9, 1(r20)
	add	r9, r0, r4
	addi	r4, r4, 11
	addi	r11, r0, pretrace_pixels.3239
	sw	r11, 0(r9)
	lw	r11, 5(r3)
	sw	r11, 10(r9)
	sw	r5, 9(r9)
	sw	r23, 8(r9)
	lw	r5, 26(r3)
	sw	r5, 7(r9)
	lw	r5, 23(r3)
	sw	r5, 6(r9)
	sw	r7, 5(r9)
	lw	r11, 29(r3)
	sw	r11, 4(r9)
	sw	r20, 3(r9)
	lw	r11, 22(r3)
	sw	r11, 2(r9)
	sw	r2, 1(r9)
	add	r12, r0, r4
	addi	r4, r4, 7
	addi	r20, r0, pretrace_line.3246
	sw	r20, 0(r12)
	lw	r20, 28(r3)
	sw	r20, 6(r12)
	lw	r20, 27(r3)
	sw	r20, 5(r12)
	sw	r5, 4(r12)
	sw	r9, 3(r12)
	sw	r19, 2(r12)
	sw	r11, 1(r12)
	add	r9, r0, r4
	addi	r4, r4, 6
	addi	r20, r0, scan_pixel.3250
	sw	r20, 0(r9)
	sw	r6, 5(r9)
	sw	r7, 4(r9)
	sw	r19, 3(r9)
	sw	r18, 2(r9)
	sw	r16, 1(r9)
	add	r6, r0, r4
	addi	r4, r4, 4
	addi	r7, r0, scan_line.3256
	sw	r7, 0(r6)
	sw	r9, 3(r6)
	sw	r12, 2(r6)
	sw	r19, 1(r6)
	add	r7, r0, r4
	addi	r4, r4, 2
	addi	r9, r0, create_pixel.3264
	sw	r9, 0(r7)
	sw	r2, 1(r7)
	add	r2, r0, r4
	addi	r4, r4, 2
	addi	r9, r0, init_line_elements.3266
	sw	r9, 0(r2)
	sw	r7, 1(r2)
	add	r9, r0, r4
	addi	r4, r4, 2
	addi	r16, r0, calc_dirvec.3276
	sw	r16, 0(r9)
	sw	r14, 1(r9)
	add	r16, r0, r4
	addi	r4, r4, 2
	addi	r18, r0, calc_dirvecs.3284
	sw	r18, 0(r16)
	sw	r9, 1(r16)
	add	r9, r0, r4
	addi	r4, r4, 2
	addi	r18, r0, calc_dirvec_rows.3289
	sw	r18, 0(r9)
	sw	r16, 1(r9)
	add	r16, r0, r4
	addi	r4, r4, 2
	addi	r18, r0, create_dirvec_elements.3295
	sw	r18, 0(r16)
	sw	r15, 1(r16)
	add	r18, r0, r4
	addi	r4, r4, 4
	addi	r20, r0, create_dirvecs.3298
	sw	r20, 0(r18)
	sw	r15, 3(r18)
	sw	r14, 2(r18)
	sw	r16, 1(r18)
	add	r16, r0, r4
	addi	r4, r4, 4
	addi	r20, r0, init_dirvec_constants.3300
	sw	r20, 0(r16)
	sw	r13, 3(r16)
	sw	r15, 2(r16)
	lw	r20, 43(r3)
	sw	r20, 1(r16)
	add	r21, r0, r4
	addi	r4, r4, 6
	addi	r22, r0, init_vecset_constants.3303
	sw	r22, 0(r21)
	sw	r13, 5(r21)
	sw	r15, 4(r21)
	sw	r20, 3(r21)
	sw	r16, 2(r21)
	sw	r14, 1(r21)
	add	r14, r0, r4
	addi	r4, r4, 7
	addi	r16, r0, setup_rect_reflection.3314
	sw	r16, 0(r14)
	lw	r16, 37(r3)
	sw	r16, 6(r14)
	sw	r13, 5(r14)
	sw	r1, 4(r14)
	sw	r15, 3(r14)
	sw	r10, 2(r14)
	sw	r20, 1(r14)
	add	r22, r0, r4
	addi	r4, r4, 7
	addi	r23, r0, setup_surface_reflection.3317
	sw	r23, 0(r22)
	sw	r16, 6(r22)
	sw	r13, 5(r22)
	sw	r1, 4(r22)
	sw	r15, 3(r22)
	sw	r10, 2(r22)
	sw	r20, 1(r22)
	add	r29, r0, r4
	addi	r4, r4, 27
	addi	r1, r0, rt.3322
	sw	r1, 0(r29)
	sw	r17, 26(r29)
	lw	r1, 33(r3)
	sw	r1, 25(r29)
	sw	r22, 24(r29)
	sw	r14, 23(r29)
	sw	r5, 22(r29)
	sw	r6, 21(r29)
	lw	r1, 42(r3)
	sw	r1, 20(r29)
	lw	r1, 41(r3)
	sw	r1, 19(r29)
	lw	r1, 40(r3)
	sw	r1, 18(r29)
	lw	r1, 39(r3)
	sw	r1, 17(r29)
	lw	r1, 38(r3)
	sw	r1, 16(r29)
	sw	r12, 15(r29)
	sw	r8, 14(r29)
	sw	r13, 13(r29)
	sw	r15, 12(r29)
	lw	r1, 35(r3)
	sw	r1, 11(r29)
	sw	r10, 10(r29)
	sw	r20, 9(r29)
	sw	r21, 8(r29)
	sw	r2, 7(r29)
	sw	r19, 6(r29)
	sw	r11, 5(r29)
	sw	r7, 4(r29)
	sw	r18, 3(r29)
	lw	r1, 34(r3)
	sw	r1, 2(r29)
	sw	r9, 1(r29)
	addi	r1, r0, 128
	addi	r2, r0, 128
	sw	r31, 45(r3)
	addi	r3, r3, 46
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -46
	lw	r31, 45(r3)
	addi	_R_0, r0, 0
