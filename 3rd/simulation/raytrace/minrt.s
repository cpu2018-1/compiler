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
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.889
	addi	r1, r0, 0
	jr	r31				#
_fle_else.889:
	addi	r1, r0, 1
	jr	r31				#
lib_fisneg:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.890
	addi	r1, r0, 0
	jr	r31				#
_fle_else.890:
	addi	r1, r0, 1
	jr	r31				#
lib_fiszero:
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, _feq_else.891
	addi	r1, r0, 1
	jr	r31				#
_feq_else.891:
	addi	r1, r0, 0
	jr	r31				#
lib_xor:
	beq	r1, r2, _beq_then.892
	addi	r1, r0, 1
	jr	r31				#
_beq_then.892:
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
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.893
	jr	r31				#
_fle_else.893:
	fneg	f1, f1
	jr	r31				#
lib_int_of_float:
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, _feq_else.894
	addi	r1, r0, 0
	jr	r31				#
_feq_else.894:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.895
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
_fle_else.895:
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
	beq	r0, r30, _fle_else.896
	jr	r31				#
_fle_else.896:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
	jr	r31				#
lib_hoge:
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.897
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.898
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j lib_hoge
_fle_else.898:
	fadd	f1, f0, f2
	jr	r31				#
_fle_else.897:
	fadd	f1, f0, f2
	jr	r31				#
lib_fuga:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.899
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.900
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j lib_fuga
_fle_else.900:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j lib_fuga
_fle_else.899:
	jr	r31				#
lib_modulo_2pi:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 0(r3)
	fsw	f1, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.901
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal lib_hoge				#	bl lib_hoge
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	_fle_cont.902
_fle_else.901:
_fle_cont.902:
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
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.903
	jr	r31				#
_fle_else.903:
	fneg	f1, f1
	jr	r31				#
lib_sin:
	flup	f2, 14		# fli	f2, 3.141593
	flup	f3, 0		# fli	f3, 0.000000
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.904
	flup	f3, 2		# fli	f3, 1.000000
	j	_fle_cont.905
_fle_else.904:
	flup	f3, 11		# fli	f3, -1.000000
_fle_cont.905:
	flup	f4, 0		# fli	f4, 0.000000
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.906
	j	_fle_cont.907
_fle_else.906:
	fneg	f1, f1
_fle_cont.907:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal lib_modulo_2pi				#	bl lib_modulo_2pi
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.908
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.909
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.910
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.910:
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
_fle_else.909:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.911
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.911:
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
_fle_else.908:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.912
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.913
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.913:
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
_fle_else.912:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.914
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.914:
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
	flup	f4, 0		# fli	f4, 0.000000
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.915
	j	_fle_cont.916
_fle_else.915:
	fneg	f1, f1
_fle_cont.916:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal lib_modulo_2pi				#	bl lib_modulo_2pi
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.917
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.918
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, _fle_else.919
	fsw	f2, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.919:
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
_fle_else.918:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.920
	fsw	f3, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.920:
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
_fle_else.917:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.921
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, _fle_else.922
	fsw	f2, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.922:
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
_fle_else.921:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.923
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.923:
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
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.924
	flup	f2, 2		# fli	f2, 1.000000
	j	_fle_cont.925
_fle_else.924:
	flup	f2, 11		# fli	f2, -1.000000
_fle_cont.925:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.926
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.927
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
_fle_else.927:
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
_fle_else.926:
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
	ble	r7, r1, _ble_then.928
	add	r5, r0, r6				# mr	r5, r6
	j lib_div10_sub
_ble_then.928:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, _ble_then.929
	add	r2, r0, r6				# mr	r2, r6
	j lib_div10_sub
_ble_then.929:
	add	r1, r0, r6
	jr	r31				#
lib_div10:
	addi	r2, r0, 0
	add	r5, r0, r1				# mr	r5, r1
	j lib_div10_sub
lib_iter_mul10:
	beqi	0, r2, _beq_then.930
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	j lib_iter_mul10
_beq_then.930:
	jr	r31				#
lib_iter_div10:
	beqi	0, r2, _beq_then.931
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
_beq_then.931:
	jr	r31				#
lib_keta_sub:
	addi	r5, r0, 10
	ble	r5, r1, _ble_then.932
	addi	r1, r2, 1
	jr	r31				#
_ble_then.932:
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
	beqi	1, r2, _beq_then.933
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
	ble	r1, r2, _ble_then.934
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
_ble_then.934:
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
_beq_then.933:
	addi	r1, r1, 48
	j	lib_print_char
lib_print_uint:
	addi	r2, r0, 10
	ble	r2, r1, _ble_then.935
	addi	r1, r1, 48
	j	lib_print_char
_ble_then.935:
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
	ble	r2, r1, _ble_then.936
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
_ble_then.936:
	j lib_print_uint
lib_read_token:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_char				#	bl	lib_read_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 32
	beq	r1, r2, _beq_then.937
	beqi	9, r1, _beq_then.938
	beqi	13, r1, _beq_then.939
	beqi	10, r1, _beq_then.940
	addi	r2, r0, 26
	beq	r1, r2, _beq_then.941
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_buffer_add_char				#	bl	lib_buffer_add_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 1
	j lib_read_token
_beq_then.941:
	jr	r31				#
_beq_then.940:
	lw	r1, 0(r3)
	beqi	0, r1, _beq_then.943
	jr	r31				#
_beq_then.943:
	addi	r1, r0, 0
	j lib_read_token
_beq_then.939:
	lw	r1, 0(r3)
	beqi	0, r1, _beq_then.945
	jr	r31				#
_beq_then.945:
	addi	r1, r0, 0
	j lib_read_token
_beq_then.938:
	lw	r1, 0(r3)
	beqi	0, r1, _beq_then.947
	jr	r31				#
_beq_then.947:
	addi	r1, r0, 0
	j lib_read_token
_beq_then.937:
	lw	r1, 0(r3)
	beqi	0, r1, _beq_then.949
	jr	r31				#
_beq_then.949:
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
	beqi	0, r1, _beq_then.951
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	j lib_iter_div10_float
_beq_then.951:
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
	beq	r5, r2, _beq_then.952
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
_beq_then.952:
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
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, _feq_else.954
	jr	r31				#
_feq_else.954:
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
	beq	r0, r30, _fle_else.956
	j	_fle_cont.957
_fle_else.956:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f1, f1, f3
_fle_cont.957:
	fsub	f1, f2, f1
	j lib_print_dec
lib_print_float:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.958
	j lib_print_ufloat
_fle_else.958:
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
hoge.2726:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17875
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17876
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17877
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17878
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17879
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17880
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17881
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17882
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17883
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17884
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17885
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17886
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17887
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17888
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17889
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17890
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2726
fle_else.17890:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17889:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17888:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17887:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17886:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17885:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17884:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17883:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17882:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17881:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17880:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17879:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17878:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17877:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17876:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17875:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2729:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17891
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17892
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17893
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17894
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2729
fle_else.17894:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2729
fle_else.17893:
	jr	r31				#
fle_else.17892:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17895
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17896
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2729
fle_else.17896:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2729
fle_else.17895:
	jr	r31				#
fle_else.17891:
	jr	r31				#
sin.2739:
	flup	f2, 14		# fli	f2, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17897
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.17898
fle_else.17897:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.17898:
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
	beq	r0, r30, fle_else.17899
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17901
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17903
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17905
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17907
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17909
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17911
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17913
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17915
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17917
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17919
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17921
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17923
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17925
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2726				#	bl	hoge.2726
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.17926
fle_else.17925:
fle_cont.17926:
	j	fle_cont.17924
fle_else.17923:
fle_cont.17924:
	j	fle_cont.17922
fle_else.17921:
fle_cont.17922:
	j	fle_cont.17920
fle_else.17919:
fle_cont.17920:
	j	fle_cont.17918
fle_else.17917:
fle_cont.17918:
	j	fle_cont.17916
fle_else.17915:
fle_cont.17916:
	j	fle_cont.17914
fle_else.17913:
fle_cont.17914:
	j	fle_cont.17912
fle_else.17911:
fle_cont.17912:
	j	fle_cont.17910
fle_else.17909:
fle_cont.17910:
	j	fle_cont.17908
fle_else.17907:
fle_cont.17908:
	j	fle_cont.17906
fle_else.17905:
fle_cont.17906:
	j	fle_cont.17904
fle_else.17903:
fle_cont.17904:
	j	fle_cont.17902
fle_else.17901:
fle_cont.17902:
	j	fle_cont.17900
fle_else.17899:
fle_cont.17900:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2729				#	bl	fuga.2729
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17927
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17928
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17929
	fmul	f2, f1, f1
	flup	f4, 6		# fli	f4, 0.166667
	fmul	f4, f4, f1
	fmul	f4, f4, f2
	fsub	f4, f1, f4
	flup	f5, 7		# fli	f5, 0.008333
	fmul	f5, f5, f1
	fmul	f5, f5, f2
	fmul	f5, f5, f2
	fadd	f4, f4, f5
	flup	f5, 8		# fli	f5, 0.000196
	fmul	f1, f5, f1
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fsub	f1, f4, f1
	fmul	f1, f1, f3
	jr	r31				#
fle_else.17929:
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
fle_else.17928:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17930
	fmul	f2, f1, f1
	flup	f4, 6		# fli	f4, 0.166667
	fmul	f4, f4, f1
	fmul	f4, f4, f2
	fsub	f4, f1, f4
	flup	f5, 7		# fli	f5, 0.008333
	fmul	f5, f5, f1
	fmul	f5, f5, f2
	fmul	f5, f5, f2
	fadd	f4, f4, f5
	flup	f5, 8		# fli	f5, 0.000196
	fmul	f1, f5, f1
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fsub	f1, f4, f1
	fmul	f1, f1, f3
	jr	r31				#
fle_else.17930:
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
fle_else.17927:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.17931
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17932
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
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.17932:
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
fle_else.17931:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17933
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
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.17933:
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
cos.2741:
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
	beq	r0, r30, fle_else.17934
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17936
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17938
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17940
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17942
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17944
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17946
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17948
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17950
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17952
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17954
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17956
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17958
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17960
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2726				#	bl	hoge.2726
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.17961
fle_else.17960:
fle_cont.17961:
	j	fle_cont.17959
fle_else.17958:
fle_cont.17959:
	j	fle_cont.17957
fle_else.17956:
fle_cont.17957:
	j	fle_cont.17955
fle_else.17954:
fle_cont.17955:
	j	fle_cont.17953
fle_else.17952:
fle_cont.17953:
	j	fle_cont.17951
fle_else.17950:
fle_cont.17951:
	j	fle_cont.17949
fle_else.17948:
fle_cont.17949:
	j	fle_cont.17947
fle_else.17946:
fle_cont.17947:
	j	fle_cont.17945
fle_else.17944:
fle_cont.17945:
	j	fle_cont.17943
fle_else.17942:
fle_cont.17943:
	j	fle_cont.17941
fle_else.17940:
fle_cont.17941:
	j	fle_cont.17939
fle_else.17938:
fle_cont.17939:
	j	fle_cont.17937
fle_else.17936:
fle_cont.17937:
	j	fle_cont.17935
fle_else.17934:
fle_cont.17935:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2729				#	bl	fuga.2729
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17962
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17963
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.17964
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
fle_else.17964:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fmul	f3, f1, f1
	flup	f4, 6		# fli	f4, 0.166667
	fmul	f4, f4, f1
	fmul	f4, f4, f3
	fsub	f4, f1, f4
	flup	f5, 7		# fli	f5, 0.008333
	fmul	f5, f5, f1
	fmul	f5, f5, f3
	fmul	f5, f5, f3
	fadd	f4, f4, f5
	flup	f5, 8		# fli	f5, 0.000196
	fmul	f1, f5, f1
	fmul	f1, f1, f3
	fmul	f1, f1, f3
	fmul	f1, f1, f3
	fsub	f1, f4, f1
	fmul	f1, f1, f2
	jr	r31				#
fle_else.17963:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17965
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
fle_else.17965:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fmul	f2, f1, f1
	flup	f4, 6		# fli	f4, 0.166667
	fmul	f4, f4, f1
	fmul	f4, f4, f2
	fsub	f4, f1, f4
	flup	f5, 7		# fli	f5, 0.008333
	fmul	f5, f5, f1
	fmul	f5, f5, f2
	fmul	f5, f5, f2
	fadd	f4, f4, f5
	flup	f5, 8		# fli	f5, 0.000196
	fmul	f1, f5, f1
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fsub	f1, f4, f1
	fmul	f1, f1, f3
	jr	r31				#
fle_else.17962:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.17966
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.17967
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
fle_else.17967:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fmul	f3, f1, f1
	flup	f4, 6		# fli	f4, 0.166667
	fmul	f4, f4, f1
	fmul	f4, f4, f3
	fsub	f4, f1, f4
	flup	f5, 7		# fli	f5, 0.008333
	fmul	f5, f5, f1
	fmul	f5, f5, f3
	fmul	f5, f5, f3
	fadd	f4, f4, f5
	flup	f5, 8		# fli	f5, 0.000196
	fmul	f1, f5, f1
	fmul	f1, f1, f3
	fmul	f1, f1, f3
	fmul	f1, f1, f3
	fsub	f1, f4, f1
	fmul	f1, f1, f2
	jr	r31				#
fle_else.17966:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17968
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
fle_else.17968:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
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
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
atan_body.2743:
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
div10_sub.2751:
	add	r6, r2, r5
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.17969
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r7, r5, 3
	slli	r8, r5, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.17970
	j	div10_sub.2751
ble_then.17970:
	slli	r2, r5, 3
	slli	r7, r5, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.17971
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	j	div10_sub.2751
ble_then.17971:
	add	r1, r0, r5
	jr	r31				#
ble_then.17969:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.17972
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r7, r2, 3
	slli	r8, r2, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.17973
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r6				# mr	r2, r6
	j	div10_sub.2751
ble_then.17973:
	slli	r6, r2, 3
	slli	r7, r2, 1
	add	r6, r6, r7
	addi	r6, r6, 9
	ble	r1, r6, ble_then.17974
	j	div10_sub.2751
ble_then.17974:
	add	r1, r0, r2
	jr	r31				#
ble_then.17972:
	add	r1, r0, r6
	jr	r31				#
print_uint.2771:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.17975
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.17975:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 10
	sw	r1, 1(r3)
	ble	r2, r1, ble_then.17976
	addi	r2, r1, 48
	out	r2
	j	ble_cont.17977
ble_then.17976:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.17978
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.17979
ble_then.17978:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.17980
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.17981
ble_then.17980:
	add	r1, r0, r5
ble_cont.17981:
ble_cont.17979:
	addi	r2, r0, 10
	sw	r1, 2(r3)
	ble	r2, r1, ble_then.17982
	addi	r2, r1, 48
	out	r2
	j	ble_cont.17983
ble_then.17982:
	addi	r2, r0, 0
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 10
	sw	r1, 3(r3)
	ble	r2, r1, ble_then.17984
	addi	r2, r1, 48
	out	r2
	j	ble_cont.17985
ble_then.17984:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.17986
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.17987
ble_then.17986:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.17988
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.17989
ble_then.17988:
	add	r1, r0, r5
ble_cont.17989:
ble_cont.17987:
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 3(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.17985:
	lw	r1, 3(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 2(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.17983:
	lw	r1, 2(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 1(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.17977:
	lw	r1, 1(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
	jr	r31				#
vecunit_sgn.2855:
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
	beq	r0, r30, feq_else.17990
	addi	r5, r0, 1
	j	feq_cont.17991
feq_else.17990:
	addi	r5, r0, 0
feq_cont.17991:
	beqi	0, r5, beq_then.17992
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.17993
beq_then.17992:
	beqi	0, r2, beq_then.17994
	flup	f2, 11		# fli	f2, -1.000000
	fdiv	f1, f2, f1
	j	beq_cont.17995
beq_then.17994:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
beq_cont.17995:
beq_cont.17993:
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
vecaccumv.2879:
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
read_screen_settings.2956:
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
	jal	cos.2741				#	bl	cos.2741
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin.2739				#	bl	sin.2739
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
	jal	cos.2741				#	bl	cos.2741
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fsw	f1, 14(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	sin.2739				#	bl	sin.2739
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
read_light.2958:
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
	jal	sin.2739				#	bl	sin.2739
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
	jal	cos.2741				#	bl	cos.2741
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2739				#	bl	sin.2739
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	fsw	f1, 0(r1)
	flw	f1, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos.2741				#	bl	cos.2741
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
rotate_quadratic_matrix.2960:
	flw	f1, 0(r2)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	cos.2741				#	bl	cos.2741
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2739				#	bl	sin.2739
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2741				#	bl	cos.2741
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2739				#	bl	sin.2739
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos.2741				#	bl	cos.2741
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 10(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2739				#	bl	sin.2739
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
read_nth_object.2963:
	lw	r2, 1(r29)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.18002
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
	beq	r0, r30, fle_else.18003
	addi	r1, r0, 0
	j	fle_cont.18004
fle_else.18003:
	addi	r1, r0, 1
fle_cont.18004:
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
	beqi	0, r2, beq_then.18005
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
	j	beq_cont.18006
beq_then.18005:
beq_cont.18006:
	lw	r2, 3(r3)
	beqi	2, r2, beq_then.18007
	lw	r5, 8(r3)
	j	beq_cont.18008
beq_then.18007:
	addi	r5, r0, 1
beq_cont.18008:
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
	beqi	3, r7, beq_then.18009
	beqi	2, r7, beq_then.18011
	j	beq_cont.18012
beq_then.18011:
	lw	r2, 8(r3)
	beqi	0, r2, beq_then.18013
	addi	r2, r0, 0
	j	beq_cont.18014
beq_then.18013:
	addi	r2, r0, 1
beq_cont.18014:
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	vecunit_sgn.2855				#	bl	vecunit_sgn.2855
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.18012:
	j	beq_cont.18010
beq_then.18009:
	flw	f1, 0(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18015
	addi	r2, r0, 1
	j	feq_cont.18016
feq_else.18015:
	addi	r2, r0, 0
feq_cont.18016:
	beqi	0, r2, beq_then.18017
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18018
beq_then.18017:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18019
	addi	r2, r0, 1
	j	feq_cont.18020
feq_else.18019:
	addi	r2, r0, 0
feq_cont.18020:
	beqi	0, r2, beq_then.18021
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.18022
beq_then.18021:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18023
	addi	r2, r0, 0
	j	fle_cont.18024
fle_else.18023:
	addi	r2, r0, 1
fle_cont.18024:
	beqi	0, r2, beq_then.18025
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.18026
beq_then.18025:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.18026:
beq_cont.18022:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.18018:
	fsw	f1, 0(r5)
	flw	f1, 1(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18027
	addi	r2, r0, 1
	j	feq_cont.18028
feq_else.18027:
	addi	r2, r0, 0
feq_cont.18028:
	beqi	0, r2, beq_then.18029
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18030
beq_then.18029:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18031
	addi	r2, r0, 1
	j	feq_cont.18032
feq_else.18031:
	addi	r2, r0, 0
feq_cont.18032:
	beqi	0, r2, beq_then.18033
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.18034
beq_then.18033:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18035
	addi	r2, r0, 0
	j	fle_cont.18036
fle_else.18035:
	addi	r2, r0, 1
fle_cont.18036:
	beqi	0, r2, beq_then.18037
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.18038
beq_then.18037:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.18038:
beq_cont.18034:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.18030:
	fsw	f1, 1(r5)
	flw	f1, 2(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18039
	addi	r2, r0, 1
	j	feq_cont.18040
feq_else.18039:
	addi	r2, r0, 0
feq_cont.18040:
	beqi	0, r2, beq_then.18041
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18042
beq_then.18041:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18043
	addi	r2, r0, 1
	j	feq_cont.18044
feq_else.18043:
	addi	r2, r0, 0
feq_cont.18044:
	beqi	0, r2, beq_then.18045
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.18046
beq_then.18045:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18047
	addi	r2, r0, 0
	j	fle_cont.18048
fle_else.18047:
	addi	r2, r0, 1
fle_cont.18048:
	beqi	0, r2, beq_then.18049
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.18050
beq_then.18049:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.18050:
beq_cont.18046:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.18042:
	fsw	f1, 2(r5)
beq_cont.18010:
	lw	r1, 5(r3)
	beqi	0, r1, beq_then.18051
	lw	r1, 6(r3)
	lw	r2, 11(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	rotate_quadratic_matrix.2960				#	bl	rotate_quadratic_matrix.2960
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.18052
beq_then.18051:
beq_cont.18052:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18002:
	addi	r1, r0, 0
	jr	r31				#
read_object.2965:
	lw	r2, 2(r29)
	lw	r5, 1(r29)
	addi	r6, r0, 60
	ble	r6, r1, ble_then.18053
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
	beqi	0, r1, beq_then.18054
	lw	r1, 3(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.18055
	lw	r29, 1(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.18056
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.18057
	lw	r29, 1(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.18058
	lw	r1, 5(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.18059
	lw	r29, 1(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	0, r1, beq_then.18060
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18060:
	lw	r1, 2(r3)
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.18059:
	jr	r31				#
beq_then.18058:
	lw	r1, 2(r3)
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.18057:
	jr	r31				#
beq_then.18056:
	lw	r1, 2(r3)
	lw	r2, 4(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.18055:
	jr	r31				#
beq_then.18054:
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.18053:
	jr	r31				#
read_net_item.2969:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.18069
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.18070
	lw	r2, 2(r3)
	addi	r5, r2, 1
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.18072
	lw	r2, 4(r3)
	addi	r5, r2, 1
	sw	r1, 5(r3)
	sw	r5, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.18074
	lw	r2, 6(r3)
	addi	r5, r2, 1
	sw	r1, 7(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.2969				#	bl	read_net_item.2969
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.18075
beq_then.18074:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18075:
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.18073
beq_then.18072:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18073:
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.18071
beq_then.18070:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18071:
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.18069:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	j	lib_create_array
read_or_network.2971:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.18076
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.18078
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.18080
	addi	r2, r0, 3
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.2969				#	bl	read_net_item.2969
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 2(r1)
	j	beq_cont.18081
beq_then.18080:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.18081:
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.18079
beq_then.18078:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.18079:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.18077
beq_then.18076:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.18077:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.18082
	lw	r1, 0(r3)
	addi	r5, r1, 1
	sw	r2, 4(r3)
	sw	r5, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.18083
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.18085
	addi	r2, r0, 2
	sw	r1, 7(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.2969				#	bl	read_net_item.2969
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 7(r3)
	sw	r2, 1(r1)
	j	beq_cont.18086
beq_then.18085:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18086:
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.18084
beq_then.18083:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.18084:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.18087
	lw	r1, 5(r3)
	addi	r5, r1, 1
	sw	r2, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	read_or_network.2971				#	bl	read_or_network.2971
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 5(r3)
	lw	r5, 8(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.18088
beq_then.18087:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.18088:
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.18082:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.2973:
	lw	r2, 1(r29)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.18089
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	-1, r1, beq_then.18091
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.18093
	addi	r2, r0, 3
	sw	r1, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	read_net_item.2969				#	bl	read_net_item.2969
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 5(r3)
	sw	r2, 2(r1)
	j	beq_cont.18094
beq_then.18093:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.18094:
	lw	r2, 4(r3)
	sw	r2, 1(r1)
	j	beq_cont.18092
beq_then.18091:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.18092:
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	j	beq_cont.18090
beq_then.18089:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.18090:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.18095
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.18096
	sw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	-1, r1, beq_then.18098
	addi	r2, r0, 2
	sw	r1, 8(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	read_net_item.2969				#	bl	read_net_item.2969
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 8(r3)
	sw	r2, 1(r1)
	j	beq_cont.18099
beq_then.18098:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.18099:
	lw	r2, 7(r3)
	sw	r2, 0(r1)
	j	beq_cont.18097
beq_then.18096:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.18097:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.18100
	lw	r2, 6(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18100:
	jr	r31				#
beq_then.18095:
	jr	r31				#
solver_rect_surface.2977:
	lw	r8, 1(r29)
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.18103
	addi	r9, r0, 1
	j	feq_cont.18104
feq_else.18103:
	addi	r9, r0, 0
feq_cont.18104:
	beqi	0, r9, beq_then.18105
	addi	r1, r0, 0
	jr	r31				#
beq_then.18105:
	lw	r9, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.18106
	addi	r10, r0, 0
	j	fle_cont.18107
fle_else.18106:
	addi	r10, r0, 1
fle_cont.18107:
	beqi	0, r1, beq_then.18108
	beqi	0, r10, beq_then.18110
	addi	r1, r0, 0
	j	beq_cont.18111
beq_then.18110:
	addi	r1, r0, 1
beq_cont.18111:
	j	beq_cont.18109
beq_then.18108:
	add	r1, r0, r10
beq_cont.18109:
	add	r30, r9, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.18112
	j	beq_cont.18113
beq_then.18112:
	fneg	f4, f4
beq_cont.18113:
	fsub	f1, f4, f1
	add	r30, r2, r5
	flw	f4, 0(r30)
	fdiv	f1, f1, f4
	add	r30, r2, r6
	flw	f4, 0(r30)
	fmul	f4, f1, f4
	fadd	f2, f4, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18114
	j	fle_cont.18115
fle_else.18114:
	fneg	f2, f2
fle_cont.18115:
	add	r30, r9, r6
	flw	f4, 0(r30)
	sw	r8, 0(r3)
	sw	r9, 1(r3)
	fsw	f3, 2(r3)
	fsw	f1, 4(r3)
	sw	r7, 6(r3)
	sw	r2, 7(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f4				# fmr	f2, f4
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.18116
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	flw	f1, 0(r30)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	flw	f3, 2(r3)
	fadd	f1, f1, f3
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18117
	j	fle_cont.18118
fle_else.18117:
	fneg	f1, f1
fle_cont.18118:
	lw	r2, 1(r3)
	add	r30, r2, r1
	flw	f3, 0(r30)
	fadd	f2, f0, f3				# fmr	f2, f3
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.18119
	lw	r1, 0(r3)
	flw	f1, 4(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.18119:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18116:
	addi	r1, r0, 0
	jr	r31				#
solver_surface.2992:
	lw	r5, 1(r29)
	lw	r1, 4(r1)
	flw	f4, 0(r2)
	flw	f5, 0(r1)
	fmul	f4, f4, f5
	flw	f5, 1(r2)
	flw	f6, 1(r1)
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	flw	f5, 2(r2)
	flw	f6, 2(r1)
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	fle	r30, f4, f0
	beq	r0, r30, fle_else.18120
	addi	r2, r0, 0
	j	fle_cont.18121
fle_else.18120:
	addi	r2, r0, 1
fle_cont.18121:
	beqi	0, r2, beq_then.18122
	flw	f5, 0(r1)
	fmul	f1, f5, f1
	flw	f5, 1(r1)
	fmul	f2, f5, f2
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fneg	f1, f1
	fdiv	f1, f1, f4
	fsw	f1, 0(r5)
	addi	r1, r0, 1
	jr	r31				#
beq_then.18122:
	addi	r1, r0, 0
	jr	r31				#
quadratic.2998:
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
	beqi	0, r2, beq_then.18123
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
beq_then.18123:
	fadd	f1, f0, f4
	jr	r31				#
bilinear.3003:
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
	beqi	0, r2, beq_then.18124
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
beq_then.18124:
	fadd	f1, f0, f7
	jr	r31				#
solver_second.3011:
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
	jal	quadratic.2998				#	bl	quadratic.2998
	addi	r3, r3, -11
	lw	r31, 10(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18126
	addi	r1, r0, 1
	j	feq_cont.18127
feq_else.18126:
	addi	r1, r0, 0
feq_cont.18127:
	beqi	0, r1, beq_then.18128
	addi	r1, r0, 0
	jr	r31				#
beq_then.18128:
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
	jal	bilinear.3003				#	bl	bilinear.3003
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
	jal	quadratic.2998				#	bl	quadratic.2998
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 8(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.18129
	j	beq_cont.18130
beq_then.18129:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.18130:
	flw	f2, 12(r3)
	fmul	f3, f2, f2
	flw	f4, 10(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18131
	addi	r2, r0, 0
	j	fle_cont.18132
fle_else.18131:
	addi	r2, r0, 1
fle_cont.18132:
	beqi	0, r2, beq_then.18133
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18134
	j	beq_cont.18135
beq_then.18134:
	fneg	f1, f1
beq_cont.18135:
	fsub	f1, f1, f2
	fdiv	f1, f1, f4
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.18133:
	addi	r1, r0, 0
	jr	r31				#
solver.3017:
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
	beqi	1, r5, beq_then.18136
	beqi	2, r5, beq_then.18137
	add	r29, r0, r6				# mr	r29, r6
	lw	r28, 0(r29)
	jr	r28
beq_then.18137:
	lw	r1, 4(r1)
	flw	f4, 0(r2)
	flw	f5, 0(r1)
	fmul	f4, f4, f5
	flw	f5, 1(r2)
	flw	f6, 1(r1)
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	flw	f5, 2(r2)
	flw	f6, 2(r1)
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	fle	r30, f4, f0
	beq	r0, r30, fle_else.18138
	addi	r2, r0, 0
	j	fle_cont.18139
fle_else.18138:
	addi	r2, r0, 1
fle_cont.18139:
	beqi	0, r2, beq_then.18140
	flw	f5, 0(r1)
	fmul	f1, f5, f1
	flw	f5, 1(r1)
	fmul	f2, f5, f2
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fneg	f1, f1
	fdiv	f1, f1, f4
	fsw	f1, 0(r8)
	addi	r1, r0, 1
	jr	r31				#
beq_then.18140:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18136:
	addi	r5, r0, 0
	addi	r6, r0, 1
	addi	r8, r0, 2
	fsw	f1, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	sw	r7, 8(r3)
	add	r29, r0, r7				# mr	r29, r7
	add	r7, r0, r8				# mr	r7, r8
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	beqi	0, r1, beq_then.18141
	addi	r1, r0, 1
	jr	r31				#
beq_then.18141:
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
	beqi	0, r1, beq_then.18142
	addi	r1, r0, 2
	jr	r31				#
beq_then.18142:
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
	beqi	0, r1, beq_then.18143
	addi	r1, r0, 3
	jr	r31				#
beq_then.18143:
	addi	r1, r0, 0
	jr	r31				#
solver_rect_fast.3021:
	lw	r6, 1(r29)
	flw	f4, 0(r5)
	fsub	f4, f4, f1
	flw	f5, 1(r5)
	fmul	f4, f4, f5
	flw	f5, 1(r2)
	fmul	f5, f4, f5
	fadd	f5, f5, f2
	fle	r30, f0, f5
	beq	r0, r30, fle_else.18144
	j	fle_cont.18145
fle_else.18144:
	fneg	f5, f5
fle_cont.18145:
	lw	r7, 4(r1)
	flw	f6, 1(r7)
	sw	r6, 0(r3)
	fsw	f1, 2(r3)
	fsw	f2, 4(r3)
	sw	r5, 6(r3)
	sw	r1, 7(r3)
	fsw	f3, 8(r3)
	fsw	f4, 10(r3)
	sw	r2, 12(r3)
	fadd	f2, f0, f6				# fmr	f2, f6
	fadd	f1, f0, f5				# fmr	f1, f5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.18147
	lw	r1, 12(r3)
	flw	f1, 2(r1)
	flw	f2, 10(r3)
	fmul	f1, f2, f1
	flw	f3, 8(r3)
	fadd	f1, f1, f3
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18149
	j	fle_cont.18150
fle_else.18149:
	fneg	f1, f1
fle_cont.18150:
	lw	r2, 7(r3)
	lw	r5, 4(r2)
	flw	f4, 2(r5)
	fadd	f2, f0, f4				# fmr	f2, f4
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.18151
	lw	r1, 6(r3)
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18153
	addi	r2, r0, 1
	j	feq_cont.18154
feq_else.18153:
	addi	r2, r0, 0
feq_cont.18154:
	beqi	0, r2, beq_then.18155
	addi	r1, r0, 0
	j	beq_cont.18156
beq_then.18155:
	addi	r1, r0, 1
beq_cont.18156:
	j	beq_cont.18152
beq_then.18151:
	addi	r1, r0, 0
beq_cont.18152:
	j	beq_cont.18148
beq_then.18147:
	addi	r1, r0, 0
beq_cont.18148:
	beqi	0, r1, beq_then.18157
	lw	r1, 0(r3)
	flw	f1, 10(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.18157:
	lw	r1, 6(r3)
	flw	f1, 2(r1)
	flw	f2, 4(r3)
	fsub	f1, f1, f2
	flw	f3, 3(r1)
	fmul	f1, f1, f3
	lw	r2, 12(r3)
	flw	f3, 0(r2)
	fmul	f3, f1, f3
	flw	f4, 2(r3)
	fadd	f3, f3, f4
	fle	r30, f0, f3
	beq	r0, r30, fle_else.18158
	j	fle_cont.18159
fle_else.18158:
	fneg	f3, f3
fle_cont.18159:
	lw	r5, 7(r3)
	lw	r6, 4(r5)
	flw	f5, 0(r6)
	fsw	f1, 14(r3)
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.18161
	lw	r1, 12(r3)
	flw	f1, 2(r1)
	flw	f2, 14(r3)
	fmul	f1, f2, f1
	flw	f3, 8(r3)
	fadd	f1, f1, f3
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18163
	j	fle_cont.18164
fle_else.18163:
	fneg	f1, f1
fle_cont.18164:
	lw	r2, 7(r3)
	lw	r5, 4(r2)
	flw	f4, 2(r5)
	fadd	f2, f0, f4				# fmr	f2, f4
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.18165
	lw	r1, 6(r3)
	flw	f1, 3(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18167
	addi	r2, r0, 1
	j	feq_cont.18168
feq_else.18167:
	addi	r2, r0, 0
feq_cont.18168:
	beqi	0, r2, beq_then.18169
	addi	r1, r0, 0
	j	beq_cont.18170
beq_then.18169:
	addi	r1, r0, 1
beq_cont.18170:
	j	beq_cont.18166
beq_then.18165:
	addi	r1, r0, 0
beq_cont.18166:
	j	beq_cont.18162
beq_then.18161:
	addi	r1, r0, 0
beq_cont.18162:
	beqi	0, r1, beq_then.18171
	lw	r1, 0(r3)
	flw	f1, 14(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 2
	jr	r31				#
beq_then.18171:
	lw	r1, 6(r3)
	flw	f1, 4(r1)
	flw	f2, 8(r3)
	fsub	f1, f1, f2
	flw	f2, 5(r1)
	fmul	f1, f1, f2
	lw	r2, 12(r3)
	flw	f2, 0(r2)
	fmul	f2, f1, f2
	flw	f3, 2(r3)
	fadd	f2, f2, f3
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18172
	j	fle_cont.18173
fle_else.18172:
	fneg	f2, f2
fle_cont.18173:
	lw	r5, 7(r3)
	lw	r6, 4(r5)
	flw	f3, 0(r6)
	fsw	f1, 16(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.18174
	lw	r1, 12(r3)
	flw	f1, 1(r1)
	flw	f2, 16(r3)
	fmul	f1, f2, f1
	flw	f3, 4(r3)
	fadd	f1, f1, f3
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18176
	j	fle_cont.18177
fle_else.18176:
	fneg	f1, f1
fle_cont.18177:
	lw	r1, 7(r3)
	lw	r1, 4(r1)
	flw	f3, 1(r1)
	fadd	f2, f0, f3				# fmr	f2, f3
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.18178
	lw	r1, 6(r3)
	flw	f1, 5(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18180
	addi	r1, r0, 1
	j	feq_cont.18181
feq_else.18180:
	addi	r1, r0, 0
feq_cont.18181:
	beqi	0, r1, beq_then.18182
	addi	r1, r0, 0
	j	beq_cont.18183
beq_then.18182:
	addi	r1, r0, 1
beq_cont.18183:
	j	beq_cont.18179
beq_then.18178:
	addi	r1, r0, 0
beq_cont.18179:
	j	beq_cont.18175
beq_then.18174:
	addi	r1, r0, 0
beq_cont.18175:
	beqi	0, r1, beq_then.18184
	lw	r1, 0(r3)
	flw	f1, 16(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 3
	jr	r31				#
beq_then.18184:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3034:
	lw	r5, 1(r29)
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.18185
	addi	r6, r0, 1
	j	feq_cont.18186
feq_else.18185:
	addi	r6, r0, 0
feq_cont.18186:
	beqi	0, r6, beq_then.18187
	addi	r1, r0, 0
	jr	r31				#
beq_then.18187:
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
	jal	quadratic.2998				#	bl	quadratic.2998
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.18188
	j	beq_cont.18189
beq_then.18188:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.18189:
	flw	f2, 4(r3)
	fmul	f3, f2, f2
	flw	f4, 2(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18190
	addi	r2, r0, 0
	j	fle_cont.18191
fle_else.18190:
	addi	r2, r0, 1
fle_cont.18191:
	beqi	0, r2, beq_then.18192
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18193
	fsqrt	f1, f1
	fadd	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	j	beq_cont.18194
beq_then.18193:
	fsqrt	f1, f1
	fsub	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
beq_cont.18194:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18192:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3051:
	lw	r6, 1(r29)
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.18195
	addi	r7, r0, 1
	j	feq_cont.18196
feq_else.18195:
	addi	r7, r0, 0
feq_cont.18196:
	beqi	0, r7, beq_then.18197
	addi	r1, r0, 0
	jr	r31				#
beq_then.18197:
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
	beq	r0, r30, fle_else.18198
	addi	r5, r0, 0
	j	fle_cont.18199
fle_else.18198:
	addi	r5, r0, 1
fle_cont.18199:
	beqi	0, r5, beq_then.18200
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18201
	fsqrt	f2, f2
	fadd	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r6)
	j	beq_cont.18202
beq_then.18201:
	fsqrt	f2, f2
	fsub	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r6)
beq_cont.18202:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18200:
	addi	r1, r0, 0
	jr	r31				#
solver_fast2.3058:
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
	beqi	1, r10, beq_then.18203
	beqi	2, r10, beq_then.18204
	add	r2, r0, r1				# mr	r2, r1
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r9				# mr	r5, r9
	add	r1, r0, r8				# mr	r1, r8
	lw	r28, 0(r29)
	jr	r28
beq_then.18204:
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18205
	addi	r2, r0, 0
	j	fle_cont.18206
fle_else.18205:
	addi	r2, r0, 1
fle_cont.18206:
	beqi	0, r2, beq_then.18207
	flw	f1, 0(r1)
	flw	f2, 3(r9)
	fmul	f1, f1, f2
	fsw	f1, 0(r7)
	addi	r1, r0, 1
	jr	r31				#
beq_then.18207:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18203:
	lw	r2, 0(r2)
	add	r5, r0, r1				# mr	r5, r1
	add	r29, r0, r6				# mr	r29, r6
	add	r1, r0, r8				# mr	r1, r8
	lw	r28, 0(r29)
	jr	r28
setup_rect_table.3061:
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
	beq	r0, r30, feq_else.18208
	addi	r5, r0, 1
	j	feq_cont.18209
feq_else.18208:
	addi	r5, r0, 0
feq_cont.18209:
	beqi	0, r5, beq_then.18210
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 1(r1)
	j	beq_cont.18211
beq_then.18210:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18212
	addi	r7, r0, 0
	j	fle_cont.18213
fle_else.18212:
	addi	r7, r0, 1
fle_cont.18213:
	beqi	0, r6, beq_then.18214
	beqi	0, r7, beq_then.18216
	addi	r6, r0, 0
	j	beq_cont.18217
beq_then.18216:
	addi	r6, r0, 1
beq_cont.18217:
	j	beq_cont.18215
beq_then.18214:
	add	r6, r0, r7
beq_cont.18215:
	lw	r7, 4(r5)
	flw	f1, 0(r7)
	beqi	0, r6, beq_then.18218
	j	beq_cont.18219
beq_then.18218:
	fneg	f1, f1
beq_cont.18219:
	fsw	f1, 0(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r2)
	fdiv	f1, f1, f2
	fsw	f1, 1(r1)
beq_cont.18211:
	flw	f1, 1(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18220
	addi	r5, r0, 1
	j	feq_cont.18221
feq_else.18220:
	addi	r5, r0, 0
feq_cont.18221:
	beqi	0, r5, beq_then.18222
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 3(r1)
	j	beq_cont.18223
beq_then.18222:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 1(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18224
	addi	r7, r0, 0
	j	fle_cont.18225
fle_else.18224:
	addi	r7, r0, 1
fle_cont.18225:
	beqi	0, r6, beq_then.18226
	beqi	0, r7, beq_then.18228
	addi	r6, r0, 0
	j	beq_cont.18229
beq_then.18228:
	addi	r6, r0, 1
beq_cont.18229:
	j	beq_cont.18227
beq_then.18226:
	add	r6, r0, r7
beq_cont.18227:
	lw	r7, 4(r5)
	flw	f1, 1(r7)
	beqi	0, r6, beq_then.18230
	j	beq_cont.18231
beq_then.18230:
	fneg	f1, f1
beq_cont.18231:
	fsw	f1, 2(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 1(r2)
	fdiv	f1, f1, f2
	fsw	f1, 3(r1)
beq_cont.18223:
	flw	f1, 2(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18232
	addi	r5, r0, 1
	j	feq_cont.18233
feq_else.18232:
	addi	r5, r0, 0
feq_cont.18233:
	beqi	0, r5, beq_then.18234
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 5(r1)
	j	beq_cont.18235
beq_then.18234:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 2(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18236
	addi	r7, r0, 0
	j	fle_cont.18237
fle_else.18236:
	addi	r7, r0, 1
fle_cont.18237:
	beqi	0, r6, beq_then.18238
	beqi	0, r7, beq_then.18240
	addi	r6, r0, 0
	j	beq_cont.18241
beq_then.18240:
	addi	r6, r0, 1
beq_cont.18241:
	j	beq_cont.18239
beq_then.18238:
	add	r6, r0, r7
beq_cont.18239:
	lw	r5, 4(r5)
	flw	f1, 2(r5)
	beqi	0, r6, beq_then.18242
	j	beq_cont.18243
beq_then.18242:
	fneg	f1, f1
beq_cont.18243:
	fsw	f1, 4(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 2(r2)
	fdiv	f1, f1, f2
	fsw	f1, 5(r1)
beq_cont.18235:
	jr	r31				#
setup_surface_table.3064:
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
	beq	r0, r30, fle_else.18244
	addi	r2, r0, 0
	j	fle_cont.18245
fle_else.18244:
	addi	r2, r0, 1
fle_cont.18245:
	beqi	0, r2, beq_then.18246
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
	j	beq_cont.18247
beq_then.18246:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
beq_cont.18247:
	jr	r31				#
setup_second_table.3067:
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
	jal	quadratic.2998				#	bl	quadratic.2998
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
	beqi	0, r6, beq_then.18248
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
	j	beq_cont.18249
beq_then.18248:
	fsw	f2, 1(r5)
	fsw	f3, 2(r5)
	fsw	f4, 3(r5)
beq_cont.18249:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18250
	addi	r1, r0, 1
	j	feq_cont.18251
feq_else.18250:
	addi	r1, r0, 0
feq_cont.18251:
	beqi	0, r1, beq_then.18252
	j	beq_cont.18253
beq_then.18252:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
	fsw	f1, 4(r5)
beq_cont.18253:
	add	r1, r0, r5
	jr	r31				#
iter_setup_dirvec_constants.3070:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.18254
	jr	r31				#
ble_then.18254:
	add	r30, r5, r2
	lw	r6, 0(r30)
	lw	r7, 1(r1)
	lw	r8, 0(r1)
	lw	r9, 1(r6)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	beqi	1, r9, beq_then.18256
	beqi	2, r9, beq_then.18258
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3067				#	bl	setup_second_table.3067
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18259
beq_then.18258:
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3064				#	bl	setup_surface_table.3064
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18259:
	j	beq_cont.18257
beq_then.18256:
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3061				#	bl	setup_rect_table.3061
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18257:
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18260
	jr	r31				#
ble_then.18260:
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 1(r3)
	lw	r6, 1(r5)
	lw	r7, 0(r5)
	lw	r8, 1(r2)
	beqi	1, r8, beq_then.18262
	beqi	2, r8, beq_then.18264
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_second_table.3067				#	bl	setup_second_table.3067
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18265
beq_then.18264:
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_surface_table.3064				#	bl	setup_surface_table.3064
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18265:
	j	beq_cont.18263
beq_then.18262:
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_rect_table.3061				#	bl	setup_rect_table.3061
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18263:
	addi	r2, r2, -1
	lw	r1, 1(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
setup_startp_constants.3075:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.18266
	jr	r31				#
ble_then.18266:
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
	beqi	2, r7, beq_then.18268
	blei	2, r7, ble_then.18270
	flw	f1, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 2(r6)
	sw	r6, 3(r3)
	sw	r7, 4(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	quadratic.2998				#	bl	quadratic.2998
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	beqi	3, r1, beq_then.18272
	j	beq_cont.18273
beq_then.18272:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.18273:
	lw	r1, 3(r3)
	fsw	f1, 3(r1)
	j	ble_cont.18271
ble_then.18270:
ble_cont.18271:
	j	beq_cont.18269
beq_then.18268:
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
beq_cont.18269:
	lw	r1, 2(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
is_rect_outside.3080:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18274
	j	fle_cont.18275
fle_else.18274:
	fneg	f1, f1
fle_cont.18275:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fsw	f3, 0(r3)
	sw	r1, 2(r3)
	fsw	f2, 4(r3)
	fadd	f2, f0, f4				# fmr	f2, f4
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.18277
	flw	f1, 4(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18279
	j	fle_cont.18280
fle_else.18279:
	fneg	f1, f1
fle_cont.18280:
	lw	r1, 2(r3)
	lw	r2, 4(r1)
	flw	f2, 1(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.18281
	flw	f1, 0(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18283
	j	fle_cont.18284
fle_else.18283:
	fneg	f1, f1
fle_cont.18284:
	lw	r1, 2(r3)
	lw	r2, 4(r1)
	flw	f2, 2(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.18282
beq_then.18281:
	addi	r1, r0, 0
beq_cont.18282:
	j	beq_cont.18278
beq_then.18277:
	addi	r1, r0, 0
beq_cont.18278:
	beqi	0, r1, beq_then.18285
	lw	r1, 2(r3)
	lw	r1, 6(r1)
	jr	r31				#
beq_then.18285:
	lw	r1, 2(r3)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18286
	addi	r1, r0, 0
	jr	r31				#
beq_then.18286:
	addi	r1, r0, 1
	jr	r31				#
is_outside.3095:
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
	beqi	1, r2, beq_then.18287
	beqi	2, r2, beq_then.18288
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.2998				#	bl	quadratic.2998
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.18289
	j	beq_cont.18290
beq_then.18289:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.18290:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18291
	addi	r2, r0, 0
	j	fle_cont.18292
fle_else.18291:
	addi	r2, r0, 1
fle_cont.18292:
	beqi	0, r1, beq_then.18293
	beqi	0, r2, beq_then.18295
	addi	r1, r0, 0
	j	beq_cont.18296
beq_then.18295:
	addi	r1, r0, 1
beq_cont.18296:
	j	beq_cont.18294
beq_then.18293:
	add	r1, r0, r2
beq_cont.18294:
	beqi	0, r1, beq_then.18297
	addi	r1, r0, 0
	jr	r31				#
beq_then.18297:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18288:
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
	beq	r0, r30, fle_else.18298
	addi	r2, r0, 0
	j	fle_cont.18299
fle_else.18298:
	addi	r2, r0, 1
fle_cont.18299:
	beqi	0, r1, beq_then.18300
	beqi	0, r2, beq_then.18302
	addi	r1, r0, 0
	j	beq_cont.18303
beq_then.18302:
	addi	r1, r0, 1
beq_cont.18303:
	j	beq_cont.18301
beq_then.18300:
	add	r1, r0, r2
beq_cont.18301:
	beqi	0, r1, beq_then.18304
	addi	r1, r0, 0
	jr	r31				#
beq_then.18304:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18287:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18305
	j	fle_cont.18306
fle_else.18305:
	fneg	f1, f1
fle_cont.18306:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fsw	f3, 2(r3)
	sw	r1, 0(r3)
	fsw	f2, 4(r3)
	fadd	f2, f0, f4				# fmr	f2, f4
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.18308
	flw	f1, 4(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18310
	j	fle_cont.18311
fle_else.18310:
	fneg	f1, f1
fle_cont.18311:
	lw	r1, 0(r3)
	lw	r2, 4(r1)
	flw	f2, 1(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.18312
	flw	f1, 2(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18314
	j	fle_cont.18315
fle_else.18314:
	fneg	f1, f1
fle_cont.18315:
	lw	r1, 0(r3)
	lw	r2, 4(r1)
	flw	f2, 2(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.18313
beq_then.18312:
	addi	r1, r0, 0
beq_cont.18313:
	j	beq_cont.18309
beq_then.18308:
	addi	r1, r0, 0
beq_cont.18309:
	beqi	0, r1, beq_then.18316
	lw	r1, 0(r3)
	lw	r1, 6(r1)
	jr	r31				#
beq_then.18316:
	lw	r1, 0(r3)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18317
	addi	r1, r0, 0
	jr	r31				#
beq_then.18317:
	addi	r1, r0, 1
	jr	r31				#
check_all_inside.3100:
	lw	r5, 1(r29)
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.18318
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
	beqi	1, r7, beq_then.18320
	beqi	2, r7, beq_then.18322
	sw	r6, 11(r3)
	add	r1, r0, r6				# mr	r1, r6
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	quadratic.2998				#	bl	quadratic.2998
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 11(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.18324
	j	beq_cont.18325
beq_then.18324:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.18325:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18326
	addi	r2, r0, 0
	j	fle_cont.18327
fle_else.18326:
	addi	r2, r0, 1
fle_cont.18327:
	beqi	0, r1, beq_then.18328
	beqi	0, r2, beq_then.18330
	addi	r1, r0, 0
	j	beq_cont.18331
beq_then.18330:
	addi	r1, r0, 1
beq_cont.18331:
	j	beq_cont.18329
beq_then.18328:
	add	r1, r0, r2
beq_cont.18329:
	beqi	0, r1, beq_then.18332
	addi	r1, r0, 0
	j	beq_cont.18333
beq_then.18332:
	addi	r1, r0, 1
beq_cont.18333:
	j	beq_cont.18323
beq_then.18322:
	lw	r7, 4(r6)
	flw	f7, 0(r7)
	fmul	f4, f7, f4
	flw	f7, 1(r7)
	fmul	f5, f7, f5
	fadd	f4, f4, f5
	flw	f5, 2(r7)
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	lw	r6, 6(r6)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.18334
	addi	r7, r0, 0
	j	fle_cont.18335
fle_else.18334:
	addi	r7, r0, 1
fle_cont.18335:
	beqi	0, r6, beq_then.18336
	beqi	0, r7, beq_then.18338
	addi	r6, r0, 0
	j	beq_cont.18339
beq_then.18338:
	addi	r6, r0, 1
beq_cont.18339:
	j	beq_cont.18337
beq_then.18336:
	add	r6, r0, r7
beq_cont.18337:
	beqi	0, r6, beq_then.18340
	addi	r1, r0, 0
	j	beq_cont.18341
beq_then.18340:
	addi	r1, r0, 1
beq_cont.18341:
beq_cont.18323:
	j	beq_cont.18321
beq_then.18320:
	add	r1, r0, r6				# mr	r1, r6
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	is_rect_outside.3080				#	bl	is_rect_outside.3080
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.18321:
	beqi	0, r1, beq_then.18342
	addi	r1, r0, 0
	jr	r31				#
beq_then.18342:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18343
	lw	r6, 8(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	flw	f1, 6(r3)
	flw	f2, 4(r3)
	flw	f3, 2(r3)
	sw	r1, 12(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	is_outside.3095				#	bl	is_outside.3095
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.18344
	addi	r1, r0, 0
	jr	r31				#
beq_then.18344:
	lw	r1, 12(r3)
	addi	r1, r1, 1
	flw	f1, 6(r3)
	flw	f2, 4(r3)
	flw	f3, 2(r3)
	lw	r2, 9(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18343:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18318:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3106:
	lw	r5, 9(r29)
	lw	r6, 8(r29)
	lw	r7, 7(r29)
	lw	r8, 6(r29)
	lw	r9, 5(r29)
	lw	r10, 4(r29)
	lw	r11, 3(r29)
	lw	r12, 2(r29)
	lw	r13, 1(r29)
	add	r30, r2, r1
	lw	r14, 0(r30)
	beqi	-1, r14, beq_then.18345
	add	r30, r2, r1
	lw	r14, 0(r30)
	add	r30, r9, r14
	lw	r15, 0(r30)
	flw	f1, 0(r11)
	lw	r16, 5(r15)
	flw	f2, 0(r16)
	fsub	f1, f1, f2
	flw	f2, 1(r11)
	lw	r16, 5(r15)
	flw	f3, 1(r16)
	fsub	f2, f2, f3
	flw	f3, 2(r11)
	lw	r16, 5(r15)
	flw	f4, 2(r16)
	fsub	f3, f3, f4
	add	r30, r12, r14
	lw	r12, 0(r30)
	lw	r16, 1(r15)
	sw	r13, 0(r3)
	sw	r11, 1(r3)
	sw	r10, 2(r3)
	sw	r2, 3(r3)
	sw	r29, 4(r3)
	sw	r1, 5(r3)
	sw	r14, 6(r3)
	sw	r9, 7(r3)
	sw	r8, 8(r3)
	beqi	1, r16, beq_then.18346
	beqi	2, r16, beq_then.18348
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r6				# mr	r29, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.18349
beq_then.18348:
	flw	f4, 0(r12)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.18350
	addi	r5, r0, 0
	j	fle_cont.18351
fle_else.18350:
	addi	r5, r0, 1
fle_cont.18351:
	beqi	0, r5, beq_then.18352
	flw	f4, 1(r12)
	fmul	f1, f4, f1
	flw	f4, 2(r12)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 3(r12)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 0(r8)
	addi	r1, r0, 1
	j	beq_cont.18353
beq_then.18352:
	addi	r1, r0, 0
beq_cont.18353:
beq_cont.18349:
	j	beq_cont.18347
beq_then.18346:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r7				# mr	r29, r7
	add	r5, r0, r12				# mr	r5, r12
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.18347:
	lw	r2, 8(r3)
	flw	f1, 0(r2)
	fsw	f1, 10(r3)
	beqi	0, r1, beq_then.18355
	flup	f2, 28		# fli	f2, -0.200000
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.18356
beq_then.18355:
	addi	r1, r0, 0
beq_cont.18356:
	beqi	0, r1, beq_then.18357
	flup	f1, 29		# fli	f1, 0.010000
	flw	f2, 10(r3)
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
	lw	r2, 3(r3)
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.18358
	lw	r5, 7(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	fsw	f1, 12(r3)
	fsw	f3, 14(r3)
	fsw	f2, 16(r3)
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	is_outside.3095				#	bl	is_outside.3095
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.18360
	addi	r1, r0, 0
	j	beq_cont.18361
beq_then.18360:
	addi	r1, r0, 1
	flw	f1, 16(r3)
	flw	f2, 14(r3)
	flw	f3, 12(r3)
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
beq_cont.18361:
	j	beq_cont.18359
beq_then.18358:
	addi	r1, r0, 1
beq_cont.18359:
	beqi	0, r1, beq_then.18362
	addi	r1, r0, 1
	jr	r31				#
beq_then.18362:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18357:
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18363
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18363:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18345:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3109:
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.18364
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
	beqi	0, r1, beq_then.18365
	addi	r1, r0, 1
	jr	r31				#
beq_then.18365:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18366
	lw	r6, 2(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0
	lw	r29, 1(r3)
	sw	r1, 5(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.18367
	addi	r1, r0, 1
	jr	r31				#
beq_then.18367:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18368
	lw	r6, 2(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0
	lw	r29, 1(r3)
	sw	r1, 6(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	0, r1, beq_then.18369
	addi	r1, r0, 1
	jr	r31				#
beq_then.18369:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18370
	lw	r6, 2(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r29, 1(r3)
	sw	r1, 7(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.18371
	addi	r1, r0, 1
	jr	r31				#
beq_then.18371:
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18370:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18368:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18366:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18364:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3112:
	lw	r5, 10(r29)
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
	lw	r16, 0(r15)
	beqi	-1, r16, beq_then.18372
	addi	r17, r0, 99
	sw	r9, 0(r3)
	sw	r10, 1(r3)
	sw	r14, 2(r3)
	sw	r15, 3(r3)
	sw	r2, 4(r3)
	sw	r29, 5(r3)
	sw	r1, 6(r3)
	beq	r16, r17, beq_then.18373
	add	r30, r11, r16
	lw	r11, 0(r30)
	flw	f1, 0(r12)
	lw	r17, 5(r11)
	flw	f2, 0(r17)
	fsub	f1, f1, f2
	flw	f2, 1(r12)
	lw	r17, 5(r11)
	flw	f3, 1(r17)
	fsub	f2, f2, f3
	flw	f3, 2(r12)
	lw	r12, 5(r11)
	flw	f4, 2(r12)
	fsub	f3, f3, f4
	add	r30, r13, r16
	lw	r12, 0(r30)
	lw	r13, 1(r11)
	sw	r8, 7(r3)
	beqi	1, r13, beq_then.18375
	beqi	2, r13, beq_then.18377
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r11				# mr	r1, r11
	add	r29, r0, r6				# mr	r29, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.18378
beq_then.18377:
	flw	f4, 0(r12)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.18379
	addi	r5, r0, 0
	j	fle_cont.18380
fle_else.18379:
	addi	r5, r0, 1
fle_cont.18380:
	beqi	0, r5, beq_then.18381
	flw	f4, 1(r12)
	fmul	f1, f4, f1
	flw	f4, 2(r12)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 3(r12)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 0(r8)
	addi	r1, r0, 1
	j	beq_cont.18382
beq_then.18381:
	addi	r1, r0, 0
beq_cont.18382:
beq_cont.18378:
	j	beq_cont.18376
beq_then.18375:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r11				# mr	r1, r11
	add	r29, r0, r7				# mr	r29, r7
	add	r5, r0, r12				# mr	r5, r12
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18376:
	beqi	0, r1, beq_then.18383
	lw	r1, 7(r3)
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.18385
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18387
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
	beqi	0, r1, beq_then.18389
	addi	r1, r0, 1
	j	beq_cont.18390
beq_then.18389:
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18391
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
	beqi	0, r1, beq_then.18393
	addi	r1, r0, 1
	j	beq_cont.18394
beq_then.18393:
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.18395
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
	beqi	0, r1, beq_then.18397
	addi	r1, r0, 1
	j	beq_cont.18398
beq_then.18397:
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18398:
	j	beq_cont.18396
beq_then.18395:
	addi	r1, r0, 0
beq_cont.18396:
beq_cont.18394:
	j	beq_cont.18392
beq_then.18391:
	addi	r1, r0, 0
beq_cont.18392:
beq_cont.18390:
	j	beq_cont.18388
beq_then.18387:
	addi	r1, r0, 0
beq_cont.18388:
	beqi	0, r1, beq_then.18399
	addi	r1, r0, 1
	j	beq_cont.18400
beq_then.18399:
	addi	r1, r0, 0
beq_cont.18400:
	j	beq_cont.18386
beq_then.18385:
	addi	r1, r0, 0
beq_cont.18386:
	j	beq_cont.18384
beq_then.18383:
	addi	r1, r0, 0
beq_cont.18384:
	j	beq_cont.18374
beq_then.18373:
	addi	r1, r0, 1
beq_cont.18374:
	beqi	0, r1, beq_then.18401
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18402
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
	beqi	0, r1, beq_then.18404
	addi	r1, r0, 1
	j	beq_cont.18405
beq_then.18404:
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18406
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
	beqi	0, r1, beq_then.18408
	addi	r1, r0, 1
	j	beq_cont.18409
beq_then.18408:
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.18410
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
	beqi	0, r1, beq_then.18412
	addi	r1, r0, 1
	j	beq_cont.18413
beq_then.18412:
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18413:
	j	beq_cont.18411
beq_then.18410:
	addi	r1, r0, 0
beq_cont.18411:
beq_cont.18409:
	j	beq_cont.18407
beq_then.18406:
	addi	r1, r0, 0
beq_cont.18407:
beq_cont.18405:
	j	beq_cont.18403
beq_then.18402:
	addi	r1, r0, 0
beq_cont.18403:
	beqi	0, r1, beq_then.18414
	addi	r1, r0, 1
	jr	r31				#
beq_then.18414:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r29, 5(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18401:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r29, 5(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18372:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3115:
	lw	r6, 11(r29)
	lw	r7, 10(r29)
	lw	r8, 9(r29)
	lw	r9, 8(r29)
	lw	r10, 7(r29)
	lw	r11, 6(r29)
	lw	r12, 5(r29)
	lw	r13, 4(r29)
	lw	r14, 3(r29)
	lw	r15, 2(r29)
	lw	r16, 1(r29)
	add	r30, r2, r1
	lw	r17, 0(r30)
	beqi	-1, r17, beq_then.18415
	add	r30, r12, r17
	lw	r18, 0(r30)
	flw	f1, 0(r7)
	lw	r19, 5(r18)
	flw	f2, 0(r19)
	fsub	f1, f1, f2
	flw	f2, 1(r7)
	lw	r19, 5(r18)
	flw	f3, 1(r19)
	fsub	f2, f2, f3
	flw	f3, 2(r7)
	lw	r19, 5(r18)
	flw	f4, 2(r19)
	fsub	f3, f3, f4
	lw	r19, 1(r18)
	sw	r13, 0(r3)
	sw	r15, 1(r3)
	sw	r14, 2(r3)
	sw	r16, 3(r3)
	sw	r7, 4(r3)
	sw	r6, 5(r3)
	sw	r11, 6(r3)
	sw	r5, 7(r3)
	sw	r2, 8(r3)
	sw	r29, 9(r3)
	sw	r1, 10(r3)
	sw	r17, 11(r3)
	sw	r12, 12(r3)
	beqi	1, r19, beq_then.18416
	beqi	2, r19, beq_then.18418
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r18				# mr	r1, r18
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.18419
beq_then.18418:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r18				# mr	r1, r18
	add	r29, r0, r8				# mr	r29, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.18419:
	j	beq_cont.18417
beq_then.18416:
	addi	r8, r0, 0
	addi	r9, r0, 1
	addi	r19, r0, 2
	fsw	f1, 14(r3)
	fsw	f3, 16(r3)
	fsw	f2, 18(r3)
	sw	r18, 20(r3)
	sw	r10, 21(r3)
	add	r7, r0, r19				# mr	r7, r19
	add	r6, r0, r9				# mr	r6, r9
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r18				# mr	r1, r18
	add	r29, r0, r10				# mr	r29, r10
	add	r5, r0, r8				# mr	r5, r8
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
	beqi	0, r1, beq_then.18421
	addi	r1, r0, 1
	j	beq_cont.18422
beq_then.18421:
	addi	r5, r0, 1
	addi	r6, r0, 2
	addi	r7, r0, 0
	flw	f1, 18(r3)
	flw	f2, 16(r3)
	flw	f3, 14(r3)
	lw	r1, 20(r3)
	lw	r2, 7(r3)
	lw	r29, 21(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
	beqi	0, r1, beq_then.18423
	addi	r1, r0, 2
	j	beq_cont.18424
beq_then.18423:
	addi	r5, r0, 2
	addi	r6, r0, 0
	addi	r7, r0, 1
	flw	f1, 16(r3)
	flw	f2, 14(r3)
	flw	f3, 18(r3)
	lw	r1, 20(r3)
	lw	r2, 7(r3)
	lw	r29, 21(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
	beqi	0, r1, beq_then.18425
	addi	r1, r0, 3
	j	beq_cont.18426
beq_then.18425:
	addi	r1, r0, 0
beq_cont.18426:
beq_cont.18424:
beq_cont.18422:
beq_cont.18417:
	beqi	0, r1, beq_then.18427
	lw	r2, 6(r3)
	flw	f2, 0(r2)
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 22(r3)
	fsw	f2, 24(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -27
	lw	r31, 26(r3)
	beqi	0, r1, beq_then.18429
	lw	r1, 5(r3)
	flw	f2, 0(r1)
	flw	f1, 24(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -27
	lw	r31, 26(r3)
	beqi	0, r1, beq_then.18431
	flup	f1, 29		# fli	f1, 0.010000
	flw	f2, 24(r3)
	fadd	f1, f2, f1
	lw	r5, 7(r3)
	flw	f2, 0(r5)
	fmul	f2, f2, f1
	lw	r1, 4(r3)
	flw	f3, 0(r1)
	fadd	f2, f2, f3
	flw	f3, 1(r5)
	fmul	f3, f3, f1
	flw	f4, 1(r1)
	fadd	f3, f3, f4
	flw	f4, 2(r5)
	fmul	f4, f4, f1
	flw	f5, 2(r1)
	fadd	f4, f4, f5
	lw	r2, 8(r3)
	lw	r1, 0(r2)
	fsw	f4, 26(r3)
	fsw	f3, 28(r3)
	fsw	f2, 30(r3)
	fsw	f1, 32(r3)
	beqi	-1, r1, beq_then.18433
	lw	r6, 12(r3)
	add	r30, r6, r1
	lw	r1, 0(r30)
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	is_outside.3095				#	bl	is_outside.3095
	addi	r3, r3, -35
	lw	r31, 34(r3)
	beqi	0, r1, beq_then.18435
	addi	r1, r0, 0
	j	beq_cont.18436
beq_then.18435:
	addi	r1, r0, 1
	flw	f1, 30(r3)
	flw	f2, 28(r3)
	flw	f3, 26(r3)
	lw	r2, 8(r3)
	lw	r29, 3(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -35
	lw	r31, 34(r3)
beq_cont.18436:
	j	beq_cont.18434
beq_then.18433:
	addi	r1, r0, 1
beq_cont.18434:
	beqi	0, r1, beq_then.18437
	lw	r1, 5(r3)
	flw	f1, 32(r3)
	fsw	f1, 0(r1)
	lw	r1, 2(r3)
	flw	f1, 30(r3)
	fsw	f1, 0(r1)
	flw	f1, 28(r3)
	fsw	f1, 1(r1)
	flw	f1, 26(r3)
	fsw	f1, 2(r1)
	lw	r1, 1(r3)
	lw	r2, 11(r3)
	sw	r2, 0(r1)
	lw	r1, 0(r3)
	lw	r2, 22(r3)
	sw	r2, 0(r1)
	j	beq_cont.18438
beq_then.18437:
beq_cont.18438:
	j	beq_cont.18432
beq_then.18431:
beq_cont.18432:
	j	beq_cont.18430
beq_then.18429:
beq_cont.18430:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r29, 9(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18427:
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18439
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r29, 9(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18439:
	jr	r31				#
beq_then.18415:
	jr	r31				#
solve_one_or_network.3119:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.18442
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
	beqi	-1, r5, beq_then.18443
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0
	lw	r8, 1(r3)
	lw	r29, 2(r3)
	sw	r1, 6(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18444
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0
	lw	r8, 1(r3)
	lw	r29, 2(r3)
	sw	r1, 7(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18445
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 1(r3)
	lw	r29, 2(r3)
	sw	r1, 8(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 8(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r5, 1(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18445:
	jr	r31				#
beq_then.18444:
	jr	r31				#
beq_then.18443:
	jr	r31				#
beq_then.18442:
	jr	r31				#
trace_or_matrix.3123:
	lw	r6, 11(r29)
	lw	r7, 10(r29)
	lw	r8, 9(r29)
	lw	r9, 8(r29)
	lw	r10, 7(r29)
	lw	r11, 6(r29)
	lw	r12, 5(r29)
	lw	r13, 4(r29)
	lw	r14, 3(r29)
	lw	r15, 2(r29)
	lw	r16, 1(r29)
	add	r30, r2, r1
	lw	r17, 0(r30)
	lw	r18, 0(r17)
	beqi	-1, r18, beq_then.18450
	addi	r19, r0, 99
	sw	r29, 0(r3)
	sw	r6, 1(r3)
	sw	r11, 2(r3)
	sw	r7, 3(r3)
	sw	r12, 4(r3)
	sw	r13, 5(r3)
	sw	r5, 6(r3)
	sw	r14, 7(r3)
	sw	r16, 8(r3)
	sw	r2, 9(r3)
	sw	r1, 10(r3)
	beq	r18, r19, beq_then.18451
	add	r30, r15, r18
	lw	r15, 0(r30)
	flw	f1, 0(r7)
	lw	r18, 5(r15)
	flw	f2, 0(r18)
	fsub	f1, f1, f2
	flw	f2, 1(r7)
	lw	r18, 5(r15)
	flw	f3, 1(r18)
	fsub	f2, f2, f3
	flw	f3, 2(r7)
	lw	r18, 5(r15)
	flw	f4, 2(r18)
	fsub	f3, f3, f4
	lw	r18, 1(r15)
	sw	r17, 11(r3)
	beqi	1, r18, beq_then.18453
	beqi	2, r18, beq_then.18455
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.18456
beq_then.18455:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r8				# mr	r29, r8
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.18456:
	j	beq_cont.18454
beq_then.18453:
	addi	r8, r0, 0
	addi	r9, r0, 1
	addi	r18, r0, 2
	fsw	f1, 12(r3)
	fsw	f3, 14(r3)
	fsw	f2, 16(r3)
	sw	r15, 18(r3)
	sw	r10, 19(r3)
	add	r7, r0, r18				# mr	r7, r18
	add	r6, r0, r9				# mr	r6, r9
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r10				# mr	r29, r10
	add	r5, r0, r8				# mr	r5, r8
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.18457
	addi	r1, r0, 1
	j	beq_cont.18458
beq_then.18457:
	addi	r5, r0, 1
	addi	r6, r0, 2
	addi	r7, r0, 0
	flw	f1, 16(r3)
	flw	f2, 14(r3)
	flw	f3, 12(r3)
	lw	r1, 18(r3)
	lw	r2, 6(r3)
	lw	r29, 19(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.18459
	addi	r1, r0, 2
	j	beq_cont.18460
beq_then.18459:
	addi	r5, r0, 2
	addi	r6, r0, 0
	addi	r7, r0, 1
	flw	f1, 14(r3)
	flw	f2, 12(r3)
	flw	f3, 16(r3)
	lw	r1, 18(r3)
	lw	r2, 6(r3)
	lw	r29, 19(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.18461
	addi	r1, r0, 3
	j	beq_cont.18462
beq_then.18461:
	addi	r1, r0, 0
beq_cont.18462:
beq_cont.18460:
beq_cont.18458:
beq_cont.18454:
	beqi	0, r1, beq_then.18463
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r2, 1(r3)
	flw	f2, 0(r2)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.18465
	lw	r1, 11(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18467
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 6(r3)
	lw	r29, 7(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
	lw	r1, 11(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18469
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 6(r3)
	lw	r29, 7(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
	lw	r1, 11(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.18471
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 6(r3)
	lw	r29, 7(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
	addi	r1, r0, 4
	lw	r2, 11(r3)
	lw	r5, 6(r3)
	lw	r29, 5(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
	j	beq_cont.18472
beq_then.18471:
beq_cont.18472:
	j	beq_cont.18470
beq_then.18469:
beq_cont.18470:
	j	beq_cont.18468
beq_then.18467:
beq_cont.18468:
	j	beq_cont.18466
beq_then.18465:
beq_cont.18466:
	j	beq_cont.18464
beq_then.18463:
beq_cont.18464:
	j	beq_cont.18452
beq_then.18451:
	lw	r8, 1(r17)
	beqi	-1, r8, beq_then.18473
	add	r30, r16, r8
	lw	r8, 0(r30)
	addi	r9, r0, 0
	sw	r17, 11(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r9				# mr	r1, r9
	add	r29, r0, r14				# mr	r29, r14
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
	lw	r1, 11(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18475
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 6(r3)
	lw	r29, 7(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
	lw	r1, 11(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.18477
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 6(r3)
	lw	r29, 7(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
	addi	r1, r0, 4
	lw	r2, 11(r3)
	lw	r5, 6(r3)
	lw	r29, 5(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
	j	beq_cont.18478
beq_then.18477:
beq_cont.18478:
	j	beq_cont.18476
beq_then.18475:
beq_cont.18476:
	j	beq_cont.18474
beq_then.18473:
beq_cont.18474:
beq_cont.18452:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.18479
	addi	r7, r0, 99
	sw	r1, 20(r3)
	beq	r6, r7, beq_then.18480
	lw	r7, 6(r3)
	lw	r8, 3(r3)
	lw	r29, 4(r3)
	sw	r5, 21(r3)
	add	r5, r0, r8				# mr	r5, r8
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
	beqi	0, r1, beq_then.18482
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -23
	lw	r31, 22(r3)
	beqi	0, r1, beq_then.18484
	lw	r1, 21(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18486
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 6(r3)
	lw	r29, 7(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
	lw	r1, 21(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18488
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 6(r3)
	lw	r29, 7(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
	addi	r1, r0, 3
	lw	r2, 21(r3)
	lw	r5, 6(r3)
	lw	r29, 5(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
	j	beq_cont.18489
beq_then.18488:
beq_cont.18489:
	j	beq_cont.18487
beq_then.18486:
beq_cont.18487:
	j	beq_cont.18485
beq_then.18484:
beq_cont.18485:
	j	beq_cont.18483
beq_then.18482:
beq_cont.18483:
	j	beq_cont.18481
beq_then.18480:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.18490
	lw	r7, 8(r3)
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r8, r0, 0
	lw	r9, 6(r3)
	lw	r29, 7(r3)
	sw	r5, 21(r3)
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
	lw	r1, 21(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18492
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 6(r3)
	lw	r29, 7(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
	addi	r1, r0, 3
	lw	r2, 21(r3)
	lw	r5, 6(r3)
	lw	r29, 5(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
	j	beq_cont.18493
beq_then.18492:
beq_cont.18493:
	j	beq_cont.18491
beq_then.18490:
beq_cont.18491:
beq_cont.18481:
	lw	r1, 20(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 6(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18479:
	jr	r31				#
beq_then.18450:
	jr	r31				#
solve_each_element_fast.3129:
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
	lw	r16, 0(r5)
	add	r30, r2, r1
	lw	r17, 0(r30)
	beqi	-1, r17, beq_then.18496
	add	r30, r11, r17
	lw	r18, 0(r30)
	lw	r19, 10(r18)
	flw	f1, 0(r19)
	flw	f2, 1(r19)
	flw	f3, 2(r19)
	lw	r20, 1(r5)
	add	r30, r20, r17
	lw	r20, 0(r30)
	lw	r21, 1(r18)
	sw	r12, 0(r3)
	sw	r14, 1(r3)
	sw	r13, 2(r3)
	sw	r15, 3(r3)
	sw	r7, 4(r3)
	sw	r16, 5(r3)
	sw	r6, 6(r3)
	sw	r10, 7(r3)
	sw	r5, 8(r3)
	sw	r2, 9(r3)
	sw	r29, 10(r3)
	sw	r1, 11(r3)
	sw	r17, 12(r3)
	sw	r11, 13(r3)
	beqi	1, r21, beq_then.18497
	beqi	2, r21, beq_then.18499
	add	r5, r0, r19				# mr	r5, r19
	add	r2, r0, r20				# mr	r2, r20
	add	r1, r0, r18				# mr	r1, r18
	add	r29, r0, r8				# mr	r29, r8
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
	j	beq_cont.18500
beq_then.18499:
	flw	f1, 0(r20)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18501
	addi	r8, r0, 0
	j	fle_cont.18502
fle_else.18501:
	addi	r8, r0, 1
fle_cont.18502:
	beqi	0, r8, beq_then.18503
	flw	f1, 0(r20)
	flw	f2, 3(r19)
	fmul	f1, f1, f2
	fsw	f1, 0(r10)
	addi	r1, r0, 1
	j	beq_cont.18504
beq_then.18503:
	addi	r1, r0, 0
beq_cont.18504:
beq_cont.18500:
	j	beq_cont.18498
beq_then.18497:
	lw	r8, 0(r5)
	add	r5, r0, r20				# mr	r5, r20
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r18				# mr	r1, r18
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
beq_cont.18498:
	beqi	0, r1, beq_then.18505
	lw	r2, 7(r3)
	flw	f2, 0(r2)
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 14(r3)
	fsw	f2, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.18507
	lw	r1, 6(r3)
	flw	f2, 0(r1)
	flw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.18509
	flup	f1, 29		# fli	f1, 0.010000
	flw	f2, 16(r3)
	fadd	f1, f2, f1
	lw	r1, 5(r3)
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
	lw	r2, 9(r3)
	lw	r1, 0(r2)
	fsw	f4, 18(r3)
	fsw	f3, 20(r3)
	fsw	f2, 22(r3)
	fsw	f1, 24(r3)
	beqi	-1, r1, beq_then.18511
	lw	r5, 13(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	is_outside.3095				#	bl	is_outside.3095
	addi	r3, r3, -27
	lw	r31, 26(r3)
	beqi	0, r1, beq_then.18513
	addi	r1, r0, 0
	j	beq_cont.18514
beq_then.18513:
	addi	r1, r0, 1
	flw	f1, 22(r3)
	flw	f2, 20(r3)
	flw	f3, 18(r3)
	lw	r2, 9(r3)
	lw	r29, 3(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -27
	lw	r31, 26(r3)
beq_cont.18514:
	j	beq_cont.18512
beq_then.18511:
	addi	r1, r0, 1
beq_cont.18512:
	beqi	0, r1, beq_then.18515
	lw	r1, 6(r3)
	flw	f1, 24(r3)
	fsw	f1, 0(r1)
	lw	r1, 2(r3)
	flw	f1, 22(r3)
	fsw	f1, 0(r1)
	flw	f1, 20(r3)
	fsw	f1, 1(r1)
	flw	f1, 18(r3)
	fsw	f1, 2(r1)
	lw	r1, 1(r3)
	lw	r2, 12(r3)
	sw	r2, 0(r1)
	lw	r1, 0(r3)
	lw	r2, 14(r3)
	sw	r2, 0(r1)
	j	beq_cont.18516
beq_then.18515:
beq_cont.18516:
	j	beq_cont.18510
beq_then.18509:
beq_cont.18510:
	j	beq_cont.18508
beq_then.18507:
beq_cont.18508:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r29, 10(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18505:
	lw	r1, 12(r3)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18517
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r29, 10(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18517:
	jr	r31				#
beq_then.18496:
	jr	r31				#
solve_one_or_network_fast.3133:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.18520
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
	beqi	-1, r5, beq_then.18521
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0
	lw	r8, 1(r3)
	lw	r29, 2(r3)
	sw	r1, 6(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18522
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0
	lw	r8, 1(r3)
	lw	r29, 2(r3)
	sw	r1, 7(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18523
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 1(r3)
	lw	r29, 2(r3)
	sw	r1, 8(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 8(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r5, 1(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18523:
	jr	r31				#
beq_then.18522:
	jr	r31				#
beq_then.18521:
	jr	r31				#
beq_then.18520:
	jr	r31				#
trace_or_matrix_fast.3137:
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
	lw	r16, 0(r15)
	beqi	-1, r16, beq_then.18528
	addi	r17, r0, 99
	sw	r29, 0(r3)
	sw	r6, 1(r3)
	sw	r10, 2(r3)
	sw	r9, 3(r3)
	sw	r11, 4(r3)
	sw	r5, 5(r3)
	sw	r12, 6(r3)
	sw	r14, 7(r3)
	sw	r2, 8(r3)
	sw	r1, 9(r3)
	beq	r16, r17, beq_then.18529
	add	r30, r13, r16
	lw	r13, 0(r30)
	lw	r17, 10(r13)
	flw	f1, 0(r17)
	flw	f2, 1(r17)
	flw	f3, 2(r17)
	lw	r18, 1(r5)
	add	r30, r18, r16
	lw	r16, 0(r30)
	lw	r18, 1(r13)
	sw	r15, 10(r3)
	beqi	1, r18, beq_then.18531
	beqi	2, r18, beq_then.18533
	add	r5, r0, r17				# mr	r5, r17
	add	r2, r0, r16				# mr	r2, r16
	add	r1, r0, r13				# mr	r1, r13
	add	r29, r0, r7				# mr	r29, r7
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.18534
beq_then.18533:
	flw	f1, 0(r16)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18535
	addi	r7, r0, 0
	j	fle_cont.18536
fle_else.18535:
	addi	r7, r0, 1
fle_cont.18536:
	beqi	0, r7, beq_then.18537
	flw	f1, 0(r16)
	flw	f2, 3(r17)
	fmul	f1, f1, f2
	fsw	f1, 0(r10)
	addi	r1, r0, 1
	j	beq_cont.18538
beq_then.18537:
	addi	r1, r0, 0
beq_cont.18538:
beq_cont.18534:
	j	beq_cont.18532
beq_then.18531:
	lw	r7, 0(r5)
	add	r5, r0, r16				# mr	r5, r16
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r13				# mr	r1, r13
	add	r29, r0, r8				# mr	r29, r8
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
beq_cont.18532:
	beqi	0, r1, beq_then.18539
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r2, 1(r3)
	flw	f2, 0(r2)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.18541
	lw	r1, 10(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18543
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 5(r3)
	lw	r29, 6(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 10(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18545
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 5(r3)
	lw	r29, 6(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 10(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.18547
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 5(r3)
	lw	r29, 6(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r1, r0, 4
	lw	r2, 10(r3)
	lw	r5, 5(r3)
	lw	r29, 4(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.18548
beq_then.18547:
beq_cont.18548:
	j	beq_cont.18546
beq_then.18545:
beq_cont.18546:
	j	beq_cont.18544
beq_then.18543:
beq_cont.18544:
	j	beq_cont.18542
beq_then.18541:
beq_cont.18542:
	j	beq_cont.18540
beq_then.18539:
beq_cont.18540:
	j	beq_cont.18530
beq_then.18529:
	lw	r7, 1(r15)
	beqi	-1, r7, beq_then.18549
	add	r30, r14, r7
	lw	r7, 0(r30)
	addi	r8, r0, 0
	sw	r15, 10(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	add	r29, r0, r12				# mr	r29, r12
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 10(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18551
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 5(r3)
	lw	r29, 6(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 10(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.18553
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 5(r3)
	lw	r29, 6(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r1, r0, 4
	lw	r2, 10(r3)
	lw	r5, 5(r3)
	lw	r29, 4(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.18554
beq_then.18553:
beq_cont.18554:
	j	beq_cont.18552
beq_then.18551:
beq_cont.18552:
	j	beq_cont.18550
beq_then.18549:
beq_cont.18550:
beq_cont.18530:
	lw	r1, 9(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.18555
	addi	r7, r0, 99
	sw	r1, 11(r3)
	beq	r6, r7, beq_then.18556
	lw	r7, 5(r3)
	lw	r29, 3(r3)
	sw	r5, 12(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.18558
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.18560
	lw	r1, 12(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18562
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 5(r3)
	lw	r29, 6(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 12(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18564
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 5(r3)
	lw	r29, 6(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r1, r0, 3
	lw	r2, 12(r3)
	lw	r5, 5(r3)
	lw	r29, 4(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.18565
beq_then.18564:
beq_cont.18565:
	j	beq_cont.18563
beq_then.18562:
beq_cont.18563:
	j	beq_cont.18561
beq_then.18560:
beq_cont.18561:
	j	beq_cont.18559
beq_then.18558:
beq_cont.18559:
	j	beq_cont.18557
beq_then.18556:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.18566
	lw	r7, 7(r3)
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r8, r0, 0
	lw	r9, 5(r3)
	lw	r29, 6(r3)
	sw	r5, 12(r3)
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 12(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18568
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 5(r3)
	lw	r29, 6(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r1, r0, 3
	lw	r2, 12(r3)
	lw	r5, 5(r3)
	lw	r29, 4(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.18569
beq_then.18568:
beq_cont.18569:
	j	beq_cont.18567
beq_then.18566:
beq_cont.18567:
beq_cont.18557:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 5(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18555:
	jr	r31				#
beq_then.18528:
	jr	r31				#
judge_intersection_fast.3141:
	lw	r2, 8(r29)
	lw	r5, 7(r29)
	lw	r6, 6(r29)
	lw	r7, 5(r29)
	lw	r8, 4(r29)
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r5)
	lw	r10, 0(r10)
	lw	r12, 0(r10)
	lw	r13, 0(r12)
	sw	r5, 0(r3)
	beqi	-1, r13, beq_then.18572
	addi	r14, r0, 99
	sw	r1, 1(r3)
	sw	r10, 2(r3)
	sw	r2, 3(r3)
	beq	r13, r14, beq_then.18574
	sw	r8, 4(r3)
	sw	r9, 5(r3)
	sw	r11, 6(r3)
	sw	r12, 7(r3)
	sw	r7, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r29, r0, r6				# mr	r29, r6
	add	r1, r0, r13				# mr	r1, r13
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	beqi	0, r1, beq_then.18576
	lw	r1, 8(r3)
	flw	f1, 0(r1)
	lw	r1, 0(r3)
	flw	f2, 0(r1)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -10
	lw	r31, 9(r3)
	beqi	0, r1, beq_then.18578
	lw	r1, 7(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18580
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 1(r3)
	lw	r29, 5(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 7(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18582
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 1(r3)
	lw	r29, 5(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r1, r0, 3
	lw	r2, 7(r3)
	lw	r5, 1(r3)
	lw	r29, 4(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.18583
beq_then.18582:
beq_cont.18583:
	j	beq_cont.18581
beq_then.18580:
beq_cont.18581:
	j	beq_cont.18579
beq_then.18578:
beq_cont.18579:
	j	beq_cont.18577
beq_then.18576:
beq_cont.18577:
	j	beq_cont.18575
beq_then.18574:
	lw	r6, 1(r12)
	beqi	-1, r6, beq_then.18584
	add	r30, r11, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r8, 4(r3)
	sw	r9, 5(r3)
	sw	r11, 6(r3)
	sw	r12, 7(r3)
	add	r5, r0, r1				# mr	r5, r1
	add	r2, r0, r6				# mr	r2, r6
	add	r29, r0, r9				# mr	r29, r9
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 7(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18586
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 1(r3)
	lw	r29, 5(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r1, r0, 3
	lw	r2, 7(r3)
	lw	r5, 1(r3)
	lw	r29, 4(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.18587
beq_then.18586:
beq_cont.18587:
	j	beq_cont.18585
beq_then.18584:
beq_cont.18585:
beq_cont.18575:
	addi	r1, r0, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	lw	r29, 3(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.18573
beq_then.18572:
beq_cont.18573:
	lw	r1, 0(r3)
	flw	f2, 0(r1)
	flup	f1, 30		# fli	f1, -0.100000
	fsw	f2, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -13
	lw	r31, 12(r3)
	beqi	0, r1, beq_then.18589
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 10(r3)
	j	lib_fless
beq_then.18589:
	addi	r1, r0, 0
	jr	r31				#
get_nvector_second.3147:
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
	beqi	0, r5, beq_then.18590
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
	j	beq_cont.18591
beq_then.18590:
	fsw	f4, 0(r2)
	fsw	f5, 1(r2)
	fsw	f6, 2(r2)
beq_cont.18591:
	lw	r1, 6(r1)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	vecunit_sgn.2855
get_nvector.3149:
	lw	r5, 3(r29)
	lw	r6, 2(r29)
	lw	r29, 1(r29)
	lw	r7, 1(r1)
	beqi	1, r7, beq_then.18592
	beqi	2, r7, beq_then.18593
	lw	r28, 0(r29)
	jr	r28
beq_then.18593:
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
beq_then.18592:
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
	beq	r0, r30, feq_else.18595
	addi	r1, r0, 1
	j	feq_cont.18596
feq_else.18595:
	addi	r1, r0, 0
feq_cont.18596:
	beqi	0, r1, beq_then.18597
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18598
beq_then.18597:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18599
	addi	r1, r0, 0
	j	fle_cont.18600
fle_else.18599:
	addi	r1, r0, 1
fle_cont.18600:
	beqi	0, r1, beq_then.18601
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.18602
beq_then.18601:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.18602:
beq_cont.18598:
	fneg	f1, f1
	add	r30, r5, r6
	fsw	f1, 0(r30)
	jr	r31				#
utexture.3152:
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
	beqi	1, r6, beq_then.18604
	beqi	2, r6, beq_then.18605
	beqi	3, r6, beq_then.18606
	beqi	4, r6, beq_then.18607
	jr	r31				#
beq_then.18607:
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
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18609
	fadd	f4, f0, f1
	j	fle_cont.18610
fle_else.18609:
	fneg	f4, f1
fle_cont.18610:
	flup	f5, 33		# fli	f5, 0.000100
	sw	r5, 0(r3)
	fsw	f3, 2(r3)
	sw	r1, 4(r3)
	sw	r2, 5(r3)
	fsw	f1, 6(r3)
	fsw	f2, 8(r3)
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.18612
	flup	f1, 34		# fli	f1, 15.000000
	j	beq_cont.18613
beq_then.18612:
	flw	f1, 6(r3)
	flw	f2, 8(r3)
	fdiv	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18614
	j	fle_cont.18615
fle_else.18614:
	fneg	f1, f1
fle_cont.18615:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18616
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.18617
fle_else.18616:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.18617:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.18618
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.18620
	flup	f3, 15		# fli	f3, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	fsw	f2, 10(r3)
	fsw	f3, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fadd	f1, f2, f1
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	j	fle_cont.18621
fle_else.18620:
	flup	f3, 16		# fli	f3, 0.785398
	flup	f4, 2		# fli	f4, 1.000000
	fsub	f4, f1, f4
	flup	f5, 2		# fli	f5, 1.000000
	fadd	f1, f1, f5
	fdiv	f1, f4, f1
	fsw	f2, 10(r3)
	fsw	f3, 14(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	flw	f2, 10(r3)
	fmul	f1, f1, f2
fle_cont.18621:
	j	fle_cont.18619
fle_else.18618:
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -17
	lw	r31, 16(r3)
fle_cont.18619:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
beq_cont.18613:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18622
	addi	r1, r0, 0
	j	feq_cont.18623
feq_else.18622:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18624
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.18625
fle_else.18624:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.18625:
feq_cont.18623:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18626
	j	fle_cont.18627
fle_else.18626:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.18627:
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
	flw	f3, 2(r3)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.18628
	fadd	f4, f0, f3
	j	fle_cont.18629
fle_else.18628:
	fneg	f4, f3
fle_cont.18629:
	flup	f5, 33		# fli	f5, 0.000100
	fsw	f1, 16(r3)
	fsw	f2, 18(r3)
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.18630
	flup	f1, 34		# fli	f1, 15.000000
	j	beq_cont.18631
beq_then.18630:
	flw	f1, 2(r3)
	flw	f2, 18(r3)
	fdiv	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18632
	j	fle_cont.18633
fle_else.18632:
	fneg	f1, f1
fle_cont.18633:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18634
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.18635
fle_else.18634:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.18635:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.18636
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.18638
	flup	f3, 15		# fli	f3, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	fsw	f2, 20(r3)
	fsw	f3, 22(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 22(r3)
	fadd	f1, f2, f1
	flw	f2, 20(r3)
	fmul	f1, f1, f2
	j	fle_cont.18639
fle_else.18638:
	flup	f3, 16		# fli	f3, 0.785398
	flup	f4, 2		# fli	f4, 1.000000
	fsub	f4, f1, f4
	flup	f5, 2		# fli	f5, 1.000000
	fadd	f1, f1, f5
	fdiv	f1, f4, f1
	fsw	f2, 20(r3)
	fsw	f3, 24(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 24(r3)
	fadd	f1, f2, f1
	flw	f2, 20(r3)
	fmul	f1, f1, f2
fle_cont.18639:
	j	fle_cont.18637
fle_else.18636:
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -27
	lw	r31, 26(r3)
fle_cont.18637:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
beq_cont.18631:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18640
	addi	r1, r0, 0
	j	feq_cont.18641
feq_else.18640:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18642
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.18643
fle_else.18642:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.18643:
feq_cont.18641:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18644
	j	fle_cont.18645
fle_else.18644:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.18645:
	fsub	f1, f1, f2
	flup	f2, 36		# fli	f2, 0.150000
	flup	f3, 1		# fli	f3, 0.500000
	flw	f4, 16(r3)
	fsub	f3, f3, f4
	fmul	f3, f3, f3
	fsub	f2, f2, f3
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f1, f3, f1
	fmul	f1, f1, f1
	fsub	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18646
	addi	r1, r0, 0
	j	fle_cont.18647
fle_else.18646:
	addi	r1, r0, 1
fle_cont.18647:
	beqi	0, r1, beq_then.18648
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18649
beq_then.18648:
beq_cont.18649:
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f2, f1
	flup	f2, 38		# fli	f2, 0.300000
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.18606:
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
	beq	r0, r30, feq_else.18651
	addi	r1, r0, 0
	j	feq_cont.18652
feq_else.18651:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18653
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.18654
fle_else.18653:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.18654:
feq_cont.18652:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18655
	j	fle_cont.18656
fle_else.18655:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.18656:
	fsub	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fmul	f1, f1, f2
	sw	r5, 0(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	cos.2741				#	bl	cos.2741
	addi	r3, r3, -27
	lw	r31, 26(r3)
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
beq_then.18605:
	flw	f1, 1(r2)
	flup	f2, 40		# fli	f2, 0.250000
	fmul	f1, f1, f2
	sw	r5, 0(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	sin.2739				#	bl	sin.2739
	addi	r3, r3, -27
	lw	r31, 26(r3)
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
beq_then.18604:
	flw	f1, 0(r2)
	lw	r6, 5(r1)
	flw	f2, 0(r6)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	feq	r30, f2, f0
	beq	r0, r30, feq_else.18659
	addi	r6, r0, 0
	j	feq_cont.18660
feq_else.18659:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18661
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r6, f3
	j	fle_cont.18662
fle_else.18661:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r6, f3
fle_cont.18662:
feq_cont.18660:
	itof	f3, r6
	fle	r30, f3, f2
	beq	r0, r30, fle_else.18663
	fadd	f2, f0, f3
	j	fle_cont.18664
fle_else.18663:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.18664:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	fsub	f1, f1, f2
	flup	f2, 39		# fli	f2, 10.000000
	sw	r5, 0(r3)
	sw	r1, 4(r3)
	sw	r2, 5(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 5(r3)
	flw	f1, 2(r2)
	lw	r2, 4(r3)
	lw	r2, 5(r2)
	flw	f2, 2(r2)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	feq	r30, f2, f0
	beq	r0, r30, feq_else.18665
	addi	r2, r0, 0
	j	feq_cont.18666
feq_else.18665:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18667
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r2, f3
	j	fle_cont.18668
fle_else.18667:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r2, f3
fle_cont.18668:
feq_cont.18666:
	itof	f3, r2
	fle	r30, f3, f2
	beq	r0, r30, fle_else.18669
	fadd	f2, f0, f3
	j	fle_cont.18670
fle_else.18669:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.18670:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	fsub	f1, f1, f2
	flup	f2, 39		# fli	f2, 10.000000
	sw	r1, 26(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -28
	lw	r31, 27(r3)
	lw	r2, 26(r3)
	beqi	0, r2, beq_then.18671
	beqi	0, r1, beq_then.18673
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.18674
beq_then.18673:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.18674:
	j	beq_cont.18672
beq_then.18671:
	beqi	0, r1, beq_then.18675
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18676
beq_then.18675:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.18676:
beq_cont.18672:
	lw	r1, 0(r3)
	fsw	f1, 1(r1)
	jr	r31				#
trace_reflections.3159:
	lw	r5, 10(r29)
	lw	r6, 9(r29)
	lw	r7, 8(r29)
	lw	r8, 7(r29)
	lw	r9, 6(r29)
	lw	r10, 5(r29)
	lw	r11, 4(r29)
	lw	r12, 3(r29)
	lw	r13, 2(r29)
	lw	r14, 1(r29)
	addi	r15, r0, 0
	ble	r15, r1, ble_then.18678
	jr	r31				#
ble_then.18678:
	add	r30, r10, r1
	lw	r10, 0(r30)
	lw	r15, 1(r10)
	flup	f3, 31		# fli	f3, 1000000000.000000
	fsw	f3, 0(r6)
	addi	r16, r0, 0
	lw	r17, 0(r11)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	fsw	f2, 2(r3)
	sw	r7, 4(r3)
	sw	r9, 5(r3)
	sw	r2, 6(r3)
	fsw	f1, 8(r3)
	sw	r12, 10(r3)
	sw	r15, 11(r3)
	sw	r8, 12(r3)
	sw	r11, 13(r3)
	sw	r10, 14(r3)
	sw	r13, 15(r3)
	sw	r14, 16(r3)
	sw	r6, 17(r3)
	add	r2, r0, r17				# mr	r2, r17
	add	r1, r0, r16				# mr	r1, r16
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r15				# mr	r5, r15
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r1, 17(r3)
	flw	f2, 0(r1)
	flup	f1, 30		# fli	f1, -0.100000
	fsw	f2, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.18681
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -21
	lw	r31, 20(r3)
	j	beq_cont.18682
beq_then.18681:
	addi	r1, r0, 0
beq_cont.18682:
	beqi	0, r1, beq_then.18683
	lw	r1, 16(r3)
	lw	r1, 0(r1)
	slli	r1, r1, 2
	lw	r2, 15(r3)
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 14(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.18685
	j	beq_cont.18686
beq_then.18685:
	addi	r1, r0, 0
	lw	r5, 13(r3)
	lw	r5, 0(r5)
	lw	r29, 12(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.18687
	j	beq_cont.18688
beq_then.18687:
	lw	r1, 11(r3)
	lw	r2, 0(r1)
	lw	r5, 10(r3)
	flw	f1, 0(r5)
	flw	f2, 0(r2)
	fmul	f1, f1, f2
	flw	f2, 1(r5)
	flw	f3, 1(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r5)
	flw	f3, 2(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r2, 14(r3)
	flw	f2, 2(r2)
	flw	f3, 8(r3)
	fmul	f4, f2, f3
	fmul	f1, f4, f1
	lw	r1, 0(r1)
	lw	r2, 6(r3)
	flw	f4, 0(r2)
	flw	f5, 0(r1)
	fmul	f4, f4, f5
	flw	f5, 1(r2)
	flw	f6, 1(r1)
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	flw	f5, 2(r2)
	flw	f6, 2(r1)
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	fmul	f2, f2, f4
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18689
	addi	r1, r0, 0
	j	fle_cont.18690
fle_else.18689:
	addi	r1, r0, 1
fle_cont.18690:
	beqi	0, r1, beq_then.18691
	lw	r1, 5(r3)
	flw	f4, 0(r1)
	lw	r5, 4(r3)
	flw	f5, 0(r5)
	fmul	f5, f1, f5
	fadd	f4, f4, f5
	fsw	f4, 0(r1)
	flw	f4, 1(r1)
	flw	f5, 1(r5)
	fmul	f5, f1, f5
	fadd	f4, f4, f5
	fsw	f4, 1(r1)
	flw	f4, 2(r1)
	flw	f5, 2(r5)
	fmul	f1, f1, f5
	fadd	f1, f4, f1
	fsw	f1, 2(r1)
	j	beq_cont.18692
beq_then.18691:
beq_cont.18692:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.18693
	addi	r1, r0, 0
	j	fle_cont.18694
fle_else.18693:
	addi	r1, r0, 1
fle_cont.18694:
	beqi	0, r1, beq_then.18695
	fmul	f1, f2, f2
	fmul	f1, f1, f1
	flw	f2, 2(r3)
	fmul	f1, f1, f2
	lw	r1, 5(r3)
	flw	f4, 0(r1)
	fadd	f4, f4, f1
	fsw	f4, 0(r1)
	flw	f4, 1(r1)
	fadd	f4, f4, f1
	fsw	f4, 1(r1)
	flw	f4, 2(r1)
	fadd	f1, f4, f1
	fsw	f1, 2(r1)
	j	beq_cont.18696
beq_then.18695:
beq_cont.18696:
beq_cont.18688:
beq_cont.18686:
	j	beq_cont.18684
beq_then.18683:
beq_cont.18684:
	lw	r1, 1(r3)
	addi	r1, r1, -1
	flw	f1, 8(r3)
	flw	f2, 2(r3)
	lw	r2, 6(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
trace_ray.3164:
	lw	r6, 23(r29)
	lw	r7, 22(r29)
	lw	r8, 21(r29)
	lw	r9, 20(r29)
	lw	r10, 19(r29)
	lw	r11, 18(r29)
	lw	r12, 17(r29)
	lw	r13, 16(r29)
	lw	r14, 15(r29)
	lw	r15, 14(r29)
	lw	r16, 13(r29)
	lw	r17, 12(r29)
	lw	r18, 11(r29)
	lw	r19, 10(r29)
	lw	r20, 9(r29)
	lw	r21, 8(r29)
	lw	r22, 7(r29)
	lw	r23, 6(r29)
	lw	r24, 5(r29)
	lw	r25, 4(r29)
	lw	r26, 3(r29)
	lw	r27, 2(r29)
	lw	r28, 1(r29)
	blei	4, r1, ble_then.18697
	jr	r31				#
ble_then.18697:
	sw	r29, 0(r3)
	lw	r29, 2(r5)
	flup	f3, 31		# fli	f3, 1000000000.000000
	fsw	f3, 0(r10)
	sw	r8, 1(r3)
	addi	r8, r0, 0
	sw	r20, 2(r3)
	lw	r20, 0(r17)
	fsw	f2, 4(r3)
	sw	r15, 6(r3)
	sw	r21, 7(r3)
	sw	r12, 8(r3)
	sw	r14, 9(r3)
	sw	r17, 10(r3)
	sw	r27, 11(r3)
	sw	r11, 12(r3)
	sw	r7, 13(r3)
	sw	r5, 14(r3)
	sw	r6, 15(r3)
	sw	r13, 16(r3)
	sw	r24, 17(r3)
	sw	r26, 18(r3)
	sw	r19, 19(r3)
	sw	r23, 20(r3)
	sw	r18, 21(r3)
	sw	r25, 22(r3)
	sw	r16, 23(r3)
	sw	r28, 24(r3)
	fsw	f1, 26(r3)
	sw	r22, 28(r3)
	sw	r2, 29(r3)
	sw	r1, 30(r3)
	sw	r29, 31(r3)
	sw	r10, 32(r3)
	add	r5, r0, r2				# mr	r5, r2
	add	r1, r0, r8				# mr	r1, r8
	add	r29, r0, r9				# mr	r29, r9
	add	r2, r0, r20				# mr	r2, r20
	sw	r31, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r1, 32(r3)
	flw	f2, 0(r1)
	flup	f1, 30		# fli	f1, -0.100000
	fsw	f2, 34(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -37
	lw	r31, 36(r3)
	beqi	0, r1, beq_then.18702
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 34(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -37
	lw	r31, 36(r3)
	j	beq_cont.18703
beq_then.18702:
	addi	r1, r0, 0
beq_cont.18703:
	beqi	0, r1, beq_then.18704
	lw	r1, 22(r3)
	lw	r1, 0(r1)
	lw	r2, 21(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	lw	r6, 7(r2)
	flw	f1, 0(r6)
	flw	f2, 26(r3)
	fmul	f1, f1, f2
	lw	r6, 1(r2)
	sw	r5, 36(r3)
	fsw	f1, 38(r3)
	sw	r1, 40(r3)
	sw	r2, 41(r3)
	beqi	1, r6, beq_then.18706
	beqi	2, r6, beq_then.18708
	lw	r29, 18(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -43
	lw	r31, 42(r3)
	j	beq_cont.18709
beq_then.18708:
	lw	r6, 4(r2)
	flw	f3, 0(r6)
	fneg	f3, f3
	lw	r6, 19(r3)
	fsw	f3, 0(r6)
	lw	r7, 4(r2)
	flw	f3, 1(r7)
	fneg	f3, f3
	fsw	f3, 1(r6)
	lw	r7, 4(r2)
	flw	f3, 2(r7)
	fneg	f3, f3
	fsw	f3, 2(r6)
beq_cont.18709:
	j	beq_cont.18707
beq_then.18706:
	lw	r6, 20(r3)
	lw	r7, 0(r6)
	flup	f3, 0		# fli	f3, 0.000000
	lw	r8, 19(r3)
	fsw	f3, 0(r8)
	fsw	f3, 1(r8)
	fsw	f3, 2(r8)
	addi	r9, r7, -1
	addi	r7, r7, -1
	lw	r10, 29(r3)
	add	r30, r10, r7
	flw	f3, 0(r30)
	feq	r30, f3, f0
	beq	r0, r30, feq_else.18710
	addi	r7, r0, 1
	j	feq_cont.18711
feq_else.18710:
	addi	r7, r0, 0
feq_cont.18711:
	beqi	0, r7, beq_then.18712
	flup	f3, 0		# fli	f3, 0.000000
	j	beq_cont.18713
beq_then.18712:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.18714
	addi	r7, r0, 0
	j	fle_cont.18715
fle_else.18714:
	addi	r7, r0, 1
fle_cont.18715:
	beqi	0, r7, beq_then.18716
	flup	f3, 2		# fli	f3, 1.000000
	j	beq_cont.18717
beq_then.18716:
	flup	f3, 11		# fli	f3, -1.000000
beq_cont.18717:
beq_cont.18713:
	fneg	f3, f3
	add	r30, r8, r9
	fsw	f3, 0(r30)
beq_cont.18707:
	lw	r2, 17(r3)
	flw	f1, 0(r2)
	lw	r1, 16(r3)
	fsw	f1, 0(r1)
	flw	f1, 1(r2)
	fsw	f1, 1(r1)
	flw	f1, 2(r2)
	fsw	f1, 2(r1)
	lw	r1, 41(r3)
	lw	r29, 15(r3)
	sw	r31, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r1, 40(r3)
	slli	r1, r1, 2
	lw	r2, 20(r3)
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 30(r3)
	lw	r5, 31(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 14(r3)
	lw	r6, 1(r1)
	add	r30, r6, r2
	lw	r6, 0(r30)
	lw	r7, 17(r3)
	flw	f1, 0(r7)
	fsw	f1, 0(r6)
	flw	f1, 1(r7)
	fsw	f1, 1(r6)
	flw	f1, 2(r7)
	fsw	f1, 2(r6)
	lw	r6, 3(r1)
	lw	r8, 41(r3)
	lw	r9, 7(r8)
	flw	f1, 0(r9)
	flup	f2, 1		# fli	f2, 0.500000
	sw	r6, 42(r3)
	sw	r31, 43(r3)
	addi	r3, r3, 44
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -44
	lw	r31, 43(r3)
	beqi	0, r1, beq_then.18718
	lw	r1, 30(r3)
	lw	r2, 42(r3)
	lw	r5, 11(r3)
	add	r30, r2, r1
	sw	r5, 0(r30)
	j	beq_cont.18719
beq_then.18718:
	lw	r1, 30(r3)
	lw	r2, 42(r3)
	lw	r5, 13(r3)
	add	r30, r2, r1
	sw	r5, 0(r30)
	lw	r2, 14(r3)
	lw	r5, 4(r2)
	add	r30, r5, r1
	lw	r6, 0(r30)
	lw	r7, 12(r3)
	flw	f1, 0(r7)
	fsw	f1, 0(r6)
	flw	f1, 1(r7)
	fsw	f1, 1(r6)
	flw	f1, 2(r7)
	fsw	f1, 2(r6)
	add	r30, r5, r1
	lw	r5, 0(r30)
	flup	f1, 43		# fli	f1, 0.003906
	flw	f2, 38(r3)
	fmul	f1, f1, f2
	flw	f3, 0(r5)
	fmul	f3, f3, f1
	fsw	f3, 0(r5)
	flw	f3, 1(r5)
	fmul	f3, f3, f1
	fsw	f3, 1(r5)
	flw	f3, 2(r5)
	fmul	f1, f3, f1
	fsw	f1, 2(r5)
	lw	r5, 7(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r6, 19(r3)
	flw	f1, 0(r6)
	fsw	f1, 0(r5)
	flw	f1, 1(r6)
	fsw	f1, 1(r5)
	flw	f1, 2(r6)
	fsw	f1, 2(r5)
beq_cont.18719:
	flup	f1, 44		# fli	f1, -2.000000
	lw	r2, 29(r3)
	flw	f2, 0(r2)
	lw	r5, 19(r3)
	flw	f3, 0(r5)
	fmul	f2, f2, f3
	flw	f3, 1(r2)
	flw	f4, 1(r5)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flw	f3, 2(r2)
	flw	f4, 2(r5)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	fmul	f1, f1, f2
	flw	f2, 0(r2)
	flw	f3, 0(r5)
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fsw	f2, 0(r2)
	flw	f2, 1(r2)
	flw	f3, 1(r5)
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fsw	f2, 1(r2)
	flw	f2, 2(r2)
	flw	f3, 2(r5)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	fsw	f1, 2(r2)
	lw	r6, 41(r3)
	lw	r7, 7(r6)
	flw	f1, 1(r7)
	flw	f2, 26(r3)
	fmul	f1, f2, f1
	addi	r7, r0, 0
	lw	r8, 10(r3)
	lw	r8, 0(r8)
	lw	r29, 9(r3)
	fsw	f1, 44(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -47
	lw	r31, 46(r3)
	beqi	0, r1, beq_then.18721
	j	beq_cont.18722
beq_then.18721:
	lw	r1, 19(r3)
	flw	f1, 0(r1)
	lw	r2, 28(r3)
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
	fneg	f1, f1
	flw	f2, 38(r3)
	fmul	f1, f1, f2
	lw	r1, 29(r3)
	flw	f3, 0(r1)
	flw	f4, 0(r2)
	fmul	f3, f3, f4
	flw	f4, 1(r1)
	flw	f5, 1(r2)
	fmul	f4, f4, f5
	fadd	f3, f3, f4
	flw	f4, 2(r1)
	flw	f5, 2(r2)
	fmul	f4, f4, f5
	fadd	f3, f3, f4
	fneg	f3, f3
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18723
	addi	r2, r0, 0
	j	fle_cont.18724
fle_else.18723:
	addi	r2, r0, 1
fle_cont.18724:
	beqi	0, r2, beq_then.18725
	lw	r2, 23(r3)
	flw	f4, 0(r2)
	lw	r5, 12(r3)
	flw	f5, 0(r5)
	fmul	f5, f1, f5
	fadd	f4, f4, f5
	fsw	f4, 0(r2)
	flw	f4, 1(r2)
	flw	f5, 1(r5)
	fmul	f5, f1, f5
	fadd	f4, f4, f5
	fsw	f4, 1(r2)
	flw	f4, 2(r2)
	flw	f5, 2(r5)
	fmul	f1, f1, f5
	fadd	f1, f4, f1
	fsw	f1, 2(r2)
	j	beq_cont.18726
beq_then.18725:
beq_cont.18726:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.18727
	addi	r2, r0, 0
	j	fle_cont.18728
fle_else.18727:
	addi	r2, r0, 1
fle_cont.18728:
	beqi	0, r2, beq_then.18729
	fmul	f1, f3, f3
	fmul	f1, f1, f1
	flw	f3, 44(r3)
	fmul	f1, f1, f3
	lw	r2, 23(r3)
	flw	f4, 0(r2)
	fadd	f4, f4, f1
	fsw	f4, 0(r2)
	flw	f4, 1(r2)
	fadd	f4, f4, f1
	fsw	f4, 1(r2)
	flw	f4, 2(r2)
	fadd	f1, f4, f1
	fsw	f1, 2(r2)
	j	beq_cont.18730
beq_then.18729:
beq_cont.18730:
beq_cont.18722:
	lw	r1, 17(r3)
	flw	f1, 0(r1)
	lw	r2, 8(r3)
	fsw	f1, 0(r2)
	flw	f1, 1(r1)
	fsw	f1, 1(r2)
	flw	f1, 2(r1)
	fsw	f1, 2(r2)
	lw	r2, 7(r3)
	lw	r2, 0(r2)
	addi	r2, r2, -1
	lw	r29, 6(r3)
	sw	r31, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -47
	lw	r31, 46(r3)
	lw	r1, 2(r3)
	lw	r1, 0(r1)
	addi	r1, r1, -1
	flw	f1, 38(r3)
	flw	f2, 44(r3)
	lw	r2, 29(r3)
	lw	r29, 1(r3)
	sw	r31, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -47
	lw	r31, 46(r3)
	flup	f1, 45		# fli	f1, 0.100000
	flw	f2, 26(r3)
	sw	r31, 46(r3)
	addi	r3, r3, 47
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -47
	lw	r31, 46(r3)
	beqi	0, r1, beq_then.18731
	addi	r1, r0, 4
	lw	r2, 30(r3)
	ble	r1, r2, ble_then.18732
	addi	r1, r2, 1
	addi	r5, r0, -1
	lw	r6, 31(r3)
	add	r30, r6, r1
	sw	r5, 0(r30)
	j	ble_cont.18733
ble_then.18732:
ble_cont.18733:
	lw	r1, 36(r3)
	beqi	2, r1, beq_then.18734
	j	beq_cont.18735
beq_then.18734:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r1, 41(r3)
	lw	r1, 7(r1)
	flw	f2, 0(r1)
	fsub	f1, f1, f2
	flw	f2, 26(r3)
	fmul	f1, f2, f1
	addi	r1, r2, 1
	lw	r2, 32(r3)
	flw	f2, 0(r2)
	flw	f3, 4(r3)
	fadd	f2, f3, f2
	lw	r2, 29(r3)
	lw	r5, 14(r3)
	lw	r29, 0(r3)
	sw	r31, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -47
	lw	r31, 46(r3)
beq_cont.18735:
	jr	r31				#
beq_then.18731:
	jr	r31				#
beq_then.18704:
	addi	r1, r0, -1
	lw	r2, 30(r3)
	lw	r5, 31(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	0, r2, beq_then.18738
	lw	r1, 29(r3)
	flw	f1, 0(r1)
	lw	r2, 28(r3)
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
	fneg	f1, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18739
	addi	r1, r0, 0
	j	fle_cont.18740
fle_else.18739:
	addi	r1, r0, 1
fle_cont.18740:
	beqi	0, r1, beq_then.18741
	fmul	f2, f1, f1
	fmul	f1, f2, f1
	flw	f2, 26(r3)
	fmul	f1, f1, f2
	lw	r1, 24(r3)
	flw	f2, 0(r1)
	fmul	f1, f1, f2
	lw	r1, 23(r3)
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
beq_then.18741:
	jr	r31				#
beq_then.18738:
	jr	r31				#
trace_diffuse_ray.3170:
	lw	r2, 14(r29)
	lw	r5, 13(r29)
	lw	r6, 12(r29)
	lw	r7, 11(r29)
	lw	r8, 10(r29)
	lw	r9, 9(r29)
	lw	r10, 8(r29)
	lw	r11, 7(r29)
	lw	r12, 6(r29)
	lw	r13, 5(r29)
	lw	r14, 4(r29)
	lw	r15, 3(r29)
	lw	r16, 2(r29)
	lw	r17, 1(r29)
	flup	f2, 31		# fli	f2, 1000000000.000000
	fsw	f2, 0(r6)
	addi	r18, r0, 0
	lw	r19, 0(r9)
	sw	r7, 0(r3)
	sw	r17, 1(r3)
	fsw	f1, 2(r3)
	sw	r12, 4(r3)
	sw	r8, 5(r3)
	sw	r9, 6(r3)
	sw	r14, 7(r3)
	sw	r2, 8(r3)
	sw	r16, 9(r3)
	sw	r11, 10(r3)
	sw	r13, 11(r3)
	sw	r1, 12(r3)
	sw	r10, 13(r3)
	sw	r15, 14(r3)
	sw	r6, 15(r3)
	add	r2, r0, r19				# mr	r2, r19
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r1				# mr	r5, r1
	add	r1, r0, r18				# mr	r1, r18
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r1, 15(r3)
	flw	f2, 0(r1)
	flup	f1, 30		# fli	f1, -0.100000
	fsw	f2, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.18745
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	j	beq_cont.18746
beq_then.18745:
	addi	r1, r0, 0
beq_cont.18746:
	beqi	0, r1, beq_then.18747
	lw	r1, 14(r3)
	lw	r1, 0(r1)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 12(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	sw	r1, 18(r3)
	beqi	1, r5, beq_then.18748
	beqi	2, r5, beq_then.18750
	lw	r29, 9(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
	j	beq_cont.18751
beq_then.18750:
	lw	r2, 4(r1)
	flw	f1, 0(r2)
	fneg	f1, f1
	lw	r2, 10(r3)
	fsw	f1, 0(r2)
	lw	r5, 4(r1)
	flw	f1, 1(r5)
	fneg	f1, f1
	fsw	f1, 1(r2)
	lw	r5, 4(r1)
	flw	f1, 2(r5)
	fneg	f1, f1
	fsw	f1, 2(r2)
beq_cont.18751:
	j	beq_cont.18749
beq_then.18748:
	lw	r5, 11(r3)
	lw	r5, 0(r5)
	flup	f1, 0		# fli	f1, 0.000000
	lw	r6, 10(r3)
	fsw	f1, 0(r6)
	fsw	f1, 1(r6)
	fsw	f1, 2(r6)
	addi	r7, r5, -1
	addi	r5, r5, -1
	add	r30, r2, r5
	flw	f1, 0(r30)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18752
	addi	r2, r0, 1
	j	feq_cont.18753
feq_else.18752:
	addi	r2, r0, 0
feq_cont.18753:
	beqi	0, r2, beq_then.18754
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18755
beq_then.18754:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18756
	addi	r2, r0, 0
	j	fle_cont.18757
fle_else.18756:
	addi	r2, r0, 1
fle_cont.18757:
	beqi	0, r2, beq_then.18758
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.18759
beq_then.18758:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.18759:
beq_cont.18755:
	fneg	f1, f1
	add	r30, r6, r7
	fsw	f1, 0(r30)
beq_cont.18749:
	lw	r1, 18(r3)
	lw	r2, 7(r3)
	lw	r29, 8(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
	addi	r1, r0, 0
	lw	r2, 6(r3)
	lw	r2, 0(r2)
	lw	r29, 5(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
	beqi	0, r1, beq_then.18760
	jr	r31				#
beq_then.18760:
	lw	r1, 10(r3)
	flw	f1, 0(r1)
	lw	r2, 4(r3)
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
	fneg	f1, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18762
	addi	r1, r0, 0
	j	fle_cont.18763
fle_else.18762:
	addi	r1, r0, 1
fle_cont.18763:
	beqi	0, r1, beq_then.18764
	j	beq_cont.18765
beq_then.18764:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.18765:
	flw	f2, 2(r3)
	fmul	f1, f2, f1
	lw	r1, 18(r3)
	lw	r1, 7(r1)
	flw	f2, 0(r1)
	fmul	f1, f1, f2
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	lw	r2, 0(r3)
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
beq_then.18747:
	jr	r31				#
iter_trace_diffuse_rays.3173:
	lw	r7, 13(r29)
	lw	r8, 12(r29)
	lw	r9, 11(r29)
	lw	r10, 10(r29)
	lw	r11, 9(r29)
	lw	r12, 8(r29)
	lw	r13, 7(r29)
	lw	r14, 6(r29)
	lw	r15, 5(r29)
	lw	r16, 4(r29)
	lw	r17, 3(r29)
	lw	r18, 2(r29)
	lw	r19, 1(r29)
	addi	r20, r0, 0
	ble	r20, r6, ble_then.18768
	jr	r31				#
ble_then.18768:
	add	r30, r1, r6
	lw	r20, 0(r30)
	lw	r20, 0(r20)
	flw	f1, 0(r20)
	flw	f2, 0(r2)
	fmul	f1, f1, f2
	flw	f2, 1(r20)
	flw	f3, 1(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r20)
	flw	f3, 2(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18770
	addi	r20, r0, 0
	j	fle_cont.18771
fle_else.18770:
	addi	r20, r0, 1
fle_cont.18771:
	sw	r5, 0(r3)
	sw	r29, 1(r3)
	sw	r8, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	sw	r6, 5(r3)
	beqi	0, r20, beq_then.18772
	addi	r20, r6, 1
	add	r30, r1, r20
	lw	r20, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	sw	r9, 6(r3)
	sw	r19, 7(r3)
	fsw	f1, 8(r3)
	sw	r14, 10(r3)
	sw	r13, 11(r3)
	sw	r10, 12(r3)
	sw	r11, 13(r3)
	sw	r16, 14(r3)
	sw	r7, 15(r3)
	sw	r18, 16(r3)
	sw	r20, 17(r3)
	sw	r12, 18(r3)
	sw	r17, 19(r3)
	add	r1, r0, r20				# mr	r1, r20
	add	r29, r0, r15				# mr	r29, r15
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.18774
	lw	r1, 19(r3)
	lw	r1, 0(r1)
	lw	r2, 18(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 17(r3)
	lw	r2, 0(r2)
	lw	r29, 16(r3)
	sw	r1, 20(r3)
	sw	r31, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -22
	lw	r31, 21(r3)
	lw	r1, 20(r3)
	lw	r2, 14(r3)
	lw	r29, 15(r3)
	sw	r31, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -22
	lw	r31, 21(r3)
	addi	r1, r0, 0
	lw	r2, 13(r3)
	lw	r2, 0(r2)
	lw	r29, 12(r3)
	sw	r31, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -22
	lw	r31, 21(r3)
	beqi	0, r1, beq_then.18776
	j	beq_cont.18777
beq_then.18776:
	lw	r1, 11(r3)
	flw	f1, 0(r1)
	lw	r2, 10(r3)
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
	fneg	f1, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18778
	addi	r1, r0, 0
	j	fle_cont.18779
fle_else.18778:
	addi	r1, r0, 1
fle_cont.18779:
	beqi	0, r1, beq_then.18780
	j	beq_cont.18781
beq_then.18780:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.18781:
	flw	f2, 8(r3)
	fmul	f1, f2, f1
	lw	r1, 20(r3)
	lw	r1, 7(r1)
	flw	f2, 0(r1)
	fmul	f1, f1, f2
	lw	r1, 7(r3)
	flw	f2, 0(r1)
	lw	r2, 6(r3)
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
beq_cont.18777:
	j	beq_cont.18775
beq_then.18774:
beq_cont.18775:
	j	beq_cont.18773
beq_then.18772:
	add	r30, r1, r6
	lw	r20, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	sw	r9, 6(r3)
	sw	r19, 7(r3)
	fsw	f1, 22(r3)
	sw	r14, 10(r3)
	sw	r13, 11(r3)
	sw	r10, 12(r3)
	sw	r11, 13(r3)
	sw	r16, 14(r3)
	sw	r7, 15(r3)
	sw	r18, 16(r3)
	sw	r20, 24(r3)
	sw	r12, 18(r3)
	sw	r17, 19(r3)
	add	r1, r0, r20				# mr	r1, r20
	add	r29, r0, r15				# mr	r29, r15
	sw	r31, 25(r3)
	addi	r3, r3, 26
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -26
	lw	r31, 25(r3)
	beqi	0, r1, beq_then.18783
	lw	r1, 19(r3)
	lw	r1, 0(r1)
	lw	r2, 18(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 24(r3)
	lw	r2, 0(r2)
	lw	r29, 16(r3)
	sw	r1, 25(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r1, 25(r3)
	lw	r2, 14(r3)
	lw	r29, 15(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -27
	lw	r31, 26(r3)
	addi	r1, r0, 0
	lw	r2, 13(r3)
	lw	r2, 0(r2)
	lw	r29, 12(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -27
	lw	r31, 26(r3)
	beqi	0, r1, beq_then.18785
	j	beq_cont.18786
beq_then.18785:
	lw	r1, 11(r3)
	flw	f1, 0(r1)
	lw	r2, 10(r3)
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
	fneg	f1, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18787
	addi	r1, r0, 0
	j	fle_cont.18788
fle_else.18787:
	addi	r1, r0, 1
fle_cont.18788:
	beqi	0, r1, beq_then.18789
	j	beq_cont.18790
beq_then.18789:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.18790:
	flw	f2, 22(r3)
	fmul	f1, f2, f1
	lw	r1, 25(r3)
	lw	r1, 7(r1)
	flw	f2, 0(r1)
	fmul	f1, f1, f2
	lw	r1, 7(r3)
	flw	f2, 0(r1)
	lw	r2, 6(r3)
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
beq_cont.18786:
	j	beq_cont.18784
beq_then.18783:
beq_cont.18784:
beq_cont.18773:
	lw	r1, 5(r3)
	addi	r1, r1, -2
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18791
	jr	r31				#
ble_then.18791:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	flw	f1, 0(r5)
	lw	r6, 3(r3)
	flw	f2, 0(r6)
	fmul	f1, f1, f2
	flw	f2, 1(r5)
	flw	f3, 1(r6)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r5)
	flw	f3, 2(r6)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18793
	addi	r5, r0, 0
	j	fle_cont.18794
fle_else.18793:
	addi	r5, r0, 1
fle_cont.18794:
	sw	r1, 26(r3)
	beqi	0, r5, beq_then.18795
	addi	r5, r1, 1
	add	r30, r2, r5
	lw	r5, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	lw	r29, 2(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
	j	beq_cont.18796
beq_then.18795:
	add	r30, r2, r1
	lw	r5, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	lw	r29, 2(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
beq_cont.18796:
	lw	r1, 26(r3)
	addi	r6, r1, -2
	lw	r1, 4(r3)
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
trace_diffuse_ray_80percent.3182:
	lw	r6, 5(r29)
	lw	r7, 4(r29)
	lw	r8, 3(r29)
	lw	r9, 2(r29)
	lw	r10, 1(r29)
	sw	r2, 0(r3)
	sw	r9, 1(r3)
	sw	r7, 2(r3)
	sw	r8, 3(r3)
	sw	r6, 4(r3)
	sw	r5, 5(r3)
	sw	r10, 6(r3)
	sw	r1, 7(r3)
	beqi	0, r1, beq_then.18797
	lw	r11, 0(r10)
	flw	f1, 0(r5)
	fsw	f1, 0(r6)
	flw	f1, 1(r5)
	fsw	f1, 1(r6)
	flw	f1, 2(r5)
	fsw	f1, 2(r6)
	lw	r12, 0(r8)
	addi	r12, r12, -1
	sw	r11, 8(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r5				# mr	r1, r5
	add	r29, r0, r7				# mr	r29, r7
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r6, r0, 118
	lw	r1, 8(r3)
	lw	r2, 0(r3)
	lw	r5, 5(r3)
	lw	r29, 1(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.18798
beq_then.18797:
beq_cont.18798:
	lw	r1, 7(r3)
	beqi	1, r1, beq_then.18799
	lw	r2, 6(r3)
	lw	r5, 1(r2)
	lw	r6, 5(r3)
	flw	f1, 0(r6)
	lw	r7, 4(r3)
	fsw	f1, 0(r7)
	flw	f1, 1(r6)
	fsw	f1, 1(r7)
	flw	f1, 2(r6)
	fsw	f1, 2(r7)
	lw	r8, 3(r3)
	lw	r9, 0(r8)
	addi	r9, r9, -1
	lw	r29, 2(r3)
	sw	r5, 9(r3)
	add	r2, r0, r9				# mr	r2, r9
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
	lw	r5, 5(r3)
	lw	r29, 1(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.18800
beq_then.18799:
beq_cont.18800:
	lw	r1, 7(r3)
	beqi	2, r1, beq_then.18801
	lw	r2, 6(r3)
	lw	r5, 2(r2)
	lw	r6, 5(r3)
	flw	f1, 0(r6)
	lw	r7, 4(r3)
	fsw	f1, 0(r7)
	flw	f1, 1(r6)
	fsw	f1, 1(r7)
	flw	f1, 2(r6)
	fsw	f1, 2(r7)
	lw	r8, 3(r3)
	lw	r9, 0(r8)
	addi	r9, r9, -1
	lw	r29, 2(r3)
	sw	r5, 10(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r6, r0, 118
	lw	r1, 10(r3)
	lw	r2, 0(r3)
	lw	r5, 5(r3)
	lw	r29, 1(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.18802
beq_then.18801:
beq_cont.18802:
	lw	r1, 7(r3)
	beqi	3, r1, beq_then.18803
	lw	r2, 6(r3)
	lw	r5, 3(r2)
	lw	r6, 5(r3)
	flw	f1, 0(r6)
	lw	r7, 4(r3)
	fsw	f1, 0(r7)
	flw	f1, 1(r6)
	fsw	f1, 1(r7)
	flw	f1, 2(r6)
	fsw	f1, 2(r7)
	lw	r8, 3(r3)
	lw	r9, 0(r8)
	addi	r9, r9, -1
	lw	r29, 2(r3)
	sw	r5, 11(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r6, r0, 118
	lw	r1, 11(r3)
	lw	r2, 0(r3)
	lw	r5, 5(r3)
	lw	r29, 1(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.18804
beq_then.18803:
beq_cont.18804:
	lw	r1, 7(r3)
	beqi	4, r1, beq_then.18805
	lw	r1, 6(r3)
	lw	r1, 4(r1)
	lw	r2, 5(r3)
	flw	f1, 0(r2)
	lw	r5, 4(r3)
	fsw	f1, 0(r5)
	flw	f1, 1(r2)
	fsw	f1, 1(r5)
	flw	f1, 2(r2)
	fsw	f1, 2(r5)
	lw	r5, 3(r3)
	lw	r5, 0(r5)
	addi	r5, r5, -1
	lw	r29, 2(r3)
	sw	r1, 12(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r6, r0, 118
	lw	r1, 12(r3)
	lw	r2, 0(r3)
	lw	r5, 5(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18805:
	jr	r31				#
calc_diffuse_using_1point.3186:
	lw	r5, 8(r29)
	lw	r6, 7(r29)
	lw	r7, 6(r29)
	lw	r8, 5(r29)
	lw	r9, 4(r29)
	lw	r10, 3(r29)
	lw	r11, 2(r29)
	lw	r12, 1(r29)
	lw	r13, 5(r1)
	lw	r14, 7(r1)
	lw	r15, 1(r1)
	lw	r16, 4(r1)
	add	r30, r13, r2
	lw	r13, 0(r30)
	flw	f1, 0(r13)
	fsw	f1, 0(r12)
	flw	f1, 1(r13)
	fsw	f1, 1(r12)
	flw	f1, 2(r13)
	fsw	f1, 2(r12)
	lw	r1, 6(r1)
	lw	r1, 0(r1)
	add	r30, r14, r2
	lw	r13, 0(r30)
	add	r30, r15, r2
	lw	r14, 0(r30)
	sw	r12, 0(r3)
	sw	r8, 1(r3)
	sw	r2, 2(r3)
	sw	r16, 3(r3)
	sw	r10, 4(r3)
	sw	r5, 5(r3)
	sw	r13, 6(r3)
	sw	r7, 7(r3)
	sw	r9, 8(r3)
	sw	r6, 9(r3)
	sw	r14, 10(r3)
	sw	r11, 11(r3)
	sw	r1, 12(r3)
	beqi	0, r1, beq_then.18807
	lw	r15, 0(r11)
	flw	f1, 0(r14)
	fsw	f1, 0(r6)
	flw	f1, 1(r14)
	fsw	f1, 1(r6)
	flw	f1, 2(r14)
	fsw	f1, 2(r6)
	lw	r17, 0(r9)
	addi	r17, r17, -1
	sw	r15, 13(r3)
	add	r2, r0, r17				# mr	r2, r17
	add	r1, r0, r14				# mr	r1, r14
	add	r29, r0, r7				# mr	r29, r7
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 13(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	flw	f1, 0(r2)
	lw	r5, 6(r3)
	flw	f2, 0(r5)
	fmul	f1, f1, f2
	flw	f2, 1(r2)
	flw	f3, 1(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r2)
	flw	f3, 2(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18809
	addi	r2, r0, 0
	j	fle_cont.18810
fle_else.18809:
	addi	r2, r0, 1
fle_cont.18810:
	beqi	0, r2, beq_then.18811
	lw	r2, 119(r1)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	lw	r29, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
	j	beq_cont.18812
beq_then.18811:
	lw	r2, 118(r1)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	lw	r29, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
beq_cont.18812:
	addi	r6, r0, 116
	lw	r1, 13(r3)
	lw	r2, 6(r3)
	lw	r5, 10(r3)
	lw	r29, 4(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
	j	beq_cont.18808
beq_then.18807:
beq_cont.18808:
	lw	r1, 12(r3)
	beqi	1, r1, beq_then.18813
	lw	r2, 11(r3)
	lw	r5, 1(r2)
	lw	r6, 10(r3)
	flw	f1, 0(r6)
	lw	r7, 9(r3)
	fsw	f1, 0(r7)
	flw	f1, 1(r6)
	fsw	f1, 1(r7)
	flw	f1, 2(r6)
	fsw	f1, 2(r7)
	lw	r8, 8(r3)
	lw	r9, 0(r8)
	addi	r9, r9, -1
	lw	r29, 7(r3)
	sw	r5, 14(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r1, 14(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	flw	f1, 0(r2)
	lw	r5, 6(r3)
	flw	f2, 0(r5)
	fmul	f1, f1, f2
	flw	f2, 1(r2)
	flw	f3, 1(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r2)
	flw	f3, 2(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18815
	addi	r2, r0, 0
	j	fle_cont.18816
fle_else.18815:
	addi	r2, r0, 1
fle_cont.18816:
	beqi	0, r2, beq_then.18817
	lw	r2, 119(r1)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	lw	r29, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -16
	lw	r31, 15(r3)
	j	beq_cont.18818
beq_then.18817:
	lw	r2, 118(r1)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	lw	r29, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -16
	lw	r31, 15(r3)
beq_cont.18818:
	addi	r6, r0, 116
	lw	r1, 14(r3)
	lw	r2, 6(r3)
	lw	r5, 10(r3)
	lw	r29, 4(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -16
	lw	r31, 15(r3)
	j	beq_cont.18814
beq_then.18813:
beq_cont.18814:
	lw	r1, 12(r3)
	beqi	2, r1, beq_then.18819
	lw	r2, 11(r3)
	lw	r5, 2(r2)
	lw	r6, 10(r3)
	flw	f1, 0(r6)
	lw	r7, 9(r3)
	fsw	f1, 0(r7)
	flw	f1, 1(r6)
	fsw	f1, 1(r7)
	flw	f1, 2(r6)
	fsw	f1, 2(r7)
	lw	r8, 8(r3)
	lw	r9, 0(r8)
	addi	r9, r9, -1
	lw	r29, 7(r3)
	sw	r5, 15(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r1, 15(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	flw	f1, 0(r2)
	lw	r5, 6(r3)
	flw	f2, 0(r5)
	fmul	f1, f1, f2
	flw	f2, 1(r2)
	flw	f3, 1(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r2)
	flw	f3, 2(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18821
	addi	r2, r0, 0
	j	fle_cont.18822
fle_else.18821:
	addi	r2, r0, 1
fle_cont.18822:
	beqi	0, r2, beq_then.18823
	lw	r2, 119(r1)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	lw	r29, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
	j	beq_cont.18824
beq_then.18823:
	lw	r2, 118(r1)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	lw	r29, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
beq_cont.18824:
	addi	r6, r0, 116
	lw	r1, 15(r3)
	lw	r2, 6(r3)
	lw	r5, 10(r3)
	lw	r29, 4(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
	j	beq_cont.18820
beq_then.18819:
beq_cont.18820:
	lw	r1, 12(r3)
	beqi	3, r1, beq_then.18825
	lw	r2, 11(r3)
	lw	r5, 3(r2)
	lw	r6, 10(r3)
	flw	f1, 0(r6)
	lw	r7, 9(r3)
	fsw	f1, 0(r7)
	flw	f1, 1(r6)
	fsw	f1, 1(r7)
	flw	f1, 2(r6)
	fsw	f1, 2(r7)
	lw	r8, 8(r3)
	lw	r9, 0(r8)
	addi	r9, r9, -1
	lw	r29, 7(r3)
	sw	r5, 16(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r1, 16(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	flw	f1, 0(r2)
	lw	r5, 6(r3)
	flw	f2, 0(r5)
	fmul	f1, f1, f2
	flw	f2, 1(r2)
	flw	f3, 1(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r2)
	flw	f3, 2(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18827
	addi	r2, r0, 0
	j	fle_cont.18828
fle_else.18827:
	addi	r2, r0, 1
fle_cont.18828:
	beqi	0, r2, beq_then.18829
	lw	r2, 119(r1)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	lw	r29, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
	j	beq_cont.18830
beq_then.18829:
	lw	r2, 118(r1)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	lw	r29, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
beq_cont.18830:
	addi	r6, r0, 116
	lw	r1, 16(r3)
	lw	r2, 6(r3)
	lw	r5, 10(r3)
	lw	r29, 4(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
	j	beq_cont.18826
beq_then.18825:
beq_cont.18826:
	lw	r1, 12(r3)
	beqi	4, r1, beq_then.18831
	lw	r1, 11(r3)
	lw	r1, 4(r1)
	lw	r2, 10(r3)
	flw	f1, 0(r2)
	lw	r5, 9(r3)
	fsw	f1, 0(r5)
	flw	f1, 1(r2)
	fsw	f1, 1(r5)
	flw	f1, 2(r2)
	fsw	f1, 2(r5)
	lw	r5, 8(r3)
	lw	r5, 0(r5)
	addi	r5, r5, -1
	lw	r29, 7(r3)
	sw	r1, 17(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r1, 17(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	flw	f1, 0(r2)
	lw	r5, 6(r3)
	flw	f2, 0(r5)
	fmul	f1, f1, f2
	flw	f2, 1(r2)
	flw	f3, 1(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r2)
	flw	f3, 2(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18833
	addi	r2, r0, 0
	j	fle_cont.18834
fle_else.18833:
	addi	r2, r0, 1
fle_cont.18834:
	beqi	0, r2, beq_then.18835
	lw	r2, 119(r1)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	lw	r29, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	j	beq_cont.18836
beq_then.18835:
	lw	r2, 118(r1)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	lw	r29, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
beq_cont.18836:
	addi	r6, r0, 116
	lw	r1, 17(r3)
	lw	r2, 6(r3)
	lw	r5, 10(r3)
	lw	r29, 4(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	j	beq_cont.18832
beq_then.18831:
beq_cont.18832:
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r1, 1(r3)
	lw	r5, 0(r3)
	j	vecaccumv.2879
calc_diffuse_using_5points.3189:
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
	flw	f1, 0(r9)
	flw	f2, 0(r2)
	fadd	f1, f1, f2
	fsw	f1, 0(r9)
	flw	f1, 1(r9)
	flw	f2, 1(r2)
	fadd	f1, f1, f2
	fsw	f1, 1(r9)
	flw	f1, 2(r9)
	flw	f2, 2(r2)
	fadd	f1, f1, f2
	fsw	f1, 2(r9)
	add	r30, r11, r7
	lw	r2, 0(r30)
	flw	f1, 0(r9)
	flw	f2, 0(r2)
	fadd	f1, f1, f2
	fsw	f1, 0(r9)
	flw	f1, 1(r9)
	flw	f2, 1(r2)
	fadd	f1, f1, f2
	fsw	f1, 1(r9)
	flw	f1, 2(r9)
	flw	f2, 2(r2)
	fadd	f1, f1, f2
	fsw	f1, 2(r9)
	add	r30, r12, r7
	lw	r2, 0(r30)
	flw	f1, 0(r9)
	flw	f2, 0(r2)
	fadd	f1, f1, f2
	fsw	f1, 0(r9)
	flw	f1, 1(r9)
	flw	f2, 1(r2)
	fadd	f1, f1, f2
	fsw	f1, 1(r9)
	flw	f1, 2(r9)
	flw	f2, 2(r2)
	fadd	f1, f1, f2
	fsw	f1, 2(r9)
	add	r30, r6, r7
	lw	r2, 0(r30)
	flw	f1, 0(r9)
	flw	f2, 0(r2)
	fadd	f1, f1, f2
	fsw	f1, 0(r9)
	flw	f1, 1(r9)
	flw	f2, 1(r2)
	fadd	f1, f1, f2
	fsw	f1, 1(r9)
	flw	f1, 2(r9)
	flw	f2, 2(r2)
	fadd	f1, f1, f2
	fsw	f1, 2(r9)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 4(r1)
	add	r30, r1, r7
	lw	r2, 0(r30)
	add	r5, r0, r9				# mr	r5, r9
	add	r1, r0, r8				# mr	r1, r8
	j	vecaccumv.2879
do_without_neighbors.3195:
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	blei	4, r2, ble_then.18837
	jr	r31				#
ble_then.18837:
	lw	r9, 2(r1)
	addi	r10, r0, 0
	add	r30, r9, r2
	lw	r9, 0(r30)
	ble	r10, r9, ble_then.18839
	jr	r31				#
ble_then.18839:
	lw	r9, 3(r1)
	add	r30, r9, r2
	lw	r9, 0(r30)
	sw	r29, 0(r3)
	sw	r8, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	beqi	0, r9, beq_then.18841
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
	jal	vecaccumv.2879				#	bl	vecaccumv.2879
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.18842
beq_then.18841:
beq_cont.18842:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	blei	4, r2, ble_then.18843
	jr	r31				#
ble_then.18843:
	lw	r1, 2(r3)
	lw	r5, 2(r1)
	addi	r6, r0, 0
	add	r30, r5, r2
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.18845
	jr	r31				#
ble_then.18845:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 7(r3)
	beqi	0, r5, beq_then.18847
	lw	r29, 1(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.18848
beq_then.18847:
beq_cont.18848:
	lw	r1, 7(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
try_exploit_neighbors.3211:
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	add	r30, r6, r1
	lw	r12, 0(r30)
	blei	4, r8, ble_then.18849
	jr	r31				#
ble_then.18849:
	addi	r13, r0, 0
	lw	r14, 2(r12)
	add	r30, r14, r8
	lw	r14, 0(r30)
	ble	r13, r14, ble_then.18851
	jr	r31				#
ble_then.18851:
	add	r30, r6, r1
	lw	r13, 0(r30)
	lw	r13, 2(r13)
	add	r30, r13, r8
	lw	r13, 0(r30)
	add	r30, r5, r1
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.18853
	addi	r13, r0, 0
	j	beq_cont.18854
beq_then.18853:
	add	r30, r7, r1
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.18855
	addi	r13, r0, 0
	j	beq_cont.18856
beq_then.18855:
	addi	r14, r1, -1
	add	r30, r6, r14
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.18857
	addi	r13, r0, 0
	j	beq_cont.18858
beq_then.18857:
	addi	r14, r1, 1
	add	r30, r6, r14
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.18859
	addi	r13, r0, 0
	j	beq_cont.18860
beq_then.18859:
	addi	r13, r0, 1
beq_cont.18860:
beq_cont.18858:
beq_cont.18856:
beq_cont.18854:
	beqi	0, r13, beq_then.18861
	lw	r11, 3(r12)
	add	r30, r11, r8
	lw	r11, 0(r30)
	sw	r2, 0(r3)
	sw	r29, 1(r3)
	sw	r10, 2(r3)
	sw	r9, 3(r3)
	sw	r7, 4(r3)
	sw	r5, 5(r3)
	sw	r1, 6(r3)
	sw	r6, 7(r3)
	sw	r8, 8(r3)
	beqi	0, r11, beq_then.18862
	add	r2, r0, r5				# mr	r2, r5
	add	r29, r0, r10				# mr	r29, r10
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r8				# mr	r7, r8
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.18863
beq_then.18862:
beq_cont.18863:
	lw	r1, 8(r3)
	addi	r2, r1, 1
	lw	r1, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r1
	lw	r6, 0(r30)
	blei	4, r2, ble_then.18864
	jr	r31				#
ble_then.18864:
	addi	r7, r0, 0
	lw	r8, 2(r6)
	add	r30, r8, r2
	lw	r8, 0(r30)
	ble	r7, r8, ble_then.18866
	jr	r31				#
ble_then.18866:
	add	r30, r5, r1
	lw	r7, 0(r30)
	lw	r7, 2(r7)
	add	r30, r7, r2
	lw	r7, 0(r30)
	lw	r8, 5(r3)
	add	r30, r8, r1
	lw	r9, 0(r30)
	lw	r9, 2(r9)
	add	r30, r9, r2
	lw	r9, 0(r30)
	beq	r9, r7, beq_then.18868
	addi	r7, r0, 0
	j	beq_cont.18869
beq_then.18868:
	lw	r9, 4(r3)
	add	r30, r9, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.18870
	addi	r7, r0, 0
	j	beq_cont.18871
beq_then.18870:
	addi	r10, r1, -1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.18872
	addi	r7, r0, 0
	j	beq_cont.18873
beq_then.18872:
	addi	r10, r1, 1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.18874
	addi	r7, r0, 0
	j	beq_cont.18875
beq_then.18874:
	addi	r7, r0, 1
beq_cont.18875:
beq_cont.18873:
beq_cont.18871:
beq_cont.18869:
	beqi	0, r7, beq_then.18876
	lw	r6, 3(r6)
	add	r30, r6, r2
	lw	r6, 0(r30)
	sw	r2, 9(r3)
	beqi	0, r6, beq_then.18877
	lw	r6, 4(r3)
	lw	r29, 2(r3)
	add	r7, r0, r2				# mr	r7, r2
	add	r2, r0, r8				# mr	r2, r8
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.18878
beq_then.18877:
beq_cont.18878:
	lw	r1, 9(r3)
	addi	r8, r1, 1
	lw	r1, 6(r3)
	lw	r2, 0(r3)
	lw	r5, 5(r3)
	lw	r6, 7(r3)
	lw	r7, 4(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18876:
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r29, 3(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18861:
	add	r30, r6, r1
	lw	r1, 0(r30)
	blei	4, r8, ble_then.18879
	jr	r31				#
ble_then.18879:
	lw	r2, 2(r1)
	addi	r5, r0, 0
	add	r30, r2, r8
	lw	r2, 0(r30)
	ble	r5, r2, ble_then.18881
	jr	r31				#
ble_then.18881:
	lw	r2, 3(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	sw	r1, 10(r3)
	sw	r9, 3(r3)
	sw	r8, 8(r3)
	beqi	0, r2, beq_then.18883
	add	r2, r0, r8				# mr	r2, r8
	add	r29, r0, r11				# mr	r29, r11
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.18884
beq_then.18883:
beq_cont.18884:
	lw	r1, 8(r3)
	addi	r2, r1, 1
	lw	r1, 10(r3)
	lw	r29, 3(r3)
	lw	r28, 0(r29)
	jr	r28
write_rgb.3222:
	lw	r1, 1(r29)
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18885
	addi	r2, r0, 0
	j	feq_cont.18886
feq_else.18885:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18887
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.18888
fle_else.18887:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.18888:
feq_cont.18886:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.18889
	addi	r5, r0, 255
	j	ble_cont.18890
ble_then.18889:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.18891
	addi	r5, r0, 0
	j	ble_cont.18892
ble_then.18891:
	add	r5, r0, r2
ble_cont.18892:
ble_cont.18890:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	ble	r2, r5, ble_then.18893
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.18895
	addi	r2, r5, 48
	out	r2
	j	ble_cont.18896
ble_then.18895:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 1(r3)
	ble	r7, r5, ble_then.18897
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.18898
ble_then.18897:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.18899
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.18900
ble_then.18899:
	add	r1, r0, r6
ble_cont.18900:
ble_cont.18898:
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2771				#	bl	print_uint.2771
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
ble_cont.18896:
	j	ble_cont.18894
ble_then.18893:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.18901
	addi	r2, r5, 48
	out	r2
	j	ble_cont.18902
ble_then.18901:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 3(r3)
	ble	r7, r5, ble_then.18903
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.18904
ble_then.18903:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.18905
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.18906
ble_then.18905:
	add	r1, r0, r6
ble_cont.18906:
ble_cont.18904:
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 3(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.18902:
ble_cont.18894:
	addi	r1, r0, 32
	out	r1
	lw	r1, 0(r3)
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18907
	addi	r2, r0, 0
	j	feq_cont.18908
feq_else.18907:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18909
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.18910
fle_else.18909:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.18910:
feq_cont.18908:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.18911
	addi	r5, r0, 255
	j	ble_cont.18912
ble_then.18911:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.18913
	addi	r5, r0, 0
	j	ble_cont.18914
ble_then.18913:
	add	r5, r0, r2
ble_cont.18914:
ble_cont.18912:
	addi	r2, r0, 0
	ble	r2, r5, ble_then.18915
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.18917
	addi	r2, r5, 48
	out	r2
	j	ble_cont.18918
ble_then.18917:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 5(r3)
	ble	r7, r5, ble_then.18919
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	ble_cont.18920
ble_then.18919:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.18921
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	ble_cont.18922
ble_then.18921:
	add	r1, r0, r6
ble_cont.18922:
ble_cont.18920:
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 5(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.18918:
	j	ble_cont.18916
ble_then.18915:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.18923
	addi	r2, r5, 48
	out	r2
	j	ble_cont.18924
ble_then.18923:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 7(r3)
	ble	r7, r5, ble_then.18925
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	ble_cont.18926
ble_then.18925:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.18927
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	ble_cont.18928
ble_then.18927:
	add	r1, r0, r6
ble_cont.18928:
ble_cont.18926:
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 8(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 7(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.18924:
ble_cont.18916:
	addi	r1, r0, 32
	out	r1
	lw	r1, 0(r3)
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18929
	addi	r1, r0, 0
	j	feq_cont.18930
feq_else.18929:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18931
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.18932
fle_else.18931:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.18932:
feq_cont.18930:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.18933
	addi	r1, r0, 255
	j	ble_cont.18934
ble_then.18933:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18935
	addi	r1, r0, 0
	j	ble_cont.18936
ble_then.18935:
ble_cont.18936:
ble_cont.18934:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18937
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	addi	r2, r0, 10
	ble	r2, r1, ble_then.18939
	addi	r1, r1, 48
	out	r1
	j	ble_cont.18940
ble_then.18939:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	sw	r1, 9(r3)
	ble	r6, r1, ble_then.18941
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	ble_cont.18942
ble_then.18941:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.18943
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	ble_cont.18944
ble_then.18943:
	add	r1, r0, r5
ble_cont.18944:
ble_cont.18942:
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 10(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 9(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.18940:
	j	ble_cont.18938
ble_then.18937:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.18945
	addi	r1, r1, 48
	out	r1
	j	ble_cont.18946
ble_then.18945:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	sw	r1, 11(r3)
	ble	r6, r1, ble_then.18947
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.18948
ble_then.18947:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.18949
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.18950
ble_then.18949:
	add	r1, r0, r5
ble_cont.18950:
ble_cont.18948:
	sw	r1, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 12(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 11(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.18946:
ble_cont.18938:
	addi	r1, r0, 10
	out	r1
	jr	r31				#
pretrace_diffuse_rays.3224:
	lw	r5, 7(r29)
	lw	r6, 6(r29)
	lw	r7, 5(r29)
	lw	r8, 4(r29)
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	blei	4, r2, ble_then.18951
	jr	r31				#
ble_then.18951:
	lw	r12, 2(r1)
	add	r30, r12, r2
	lw	r12, 0(r30)
	addi	r13, r0, 0
	ble	r13, r12, ble_then.18953
	jr	r31				#
ble_then.18953:
	lw	r12, 3(r1)
	add	r30, r12, r2
	lw	r12, 0(r30)
	sw	r29, 0(r3)
	sw	r9, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	sw	r8, 4(r3)
	sw	r6, 5(r3)
	sw	r10, 6(r3)
	sw	r11, 7(r3)
	sw	r2, 8(r3)
	beqi	0, r12, beq_then.18955
	lw	r12, 6(r1)
	lw	r12, 0(r12)
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r11)
	fsw	f1, 1(r11)
	fsw	f1, 2(r11)
	lw	r13, 7(r1)
	lw	r14, 1(r1)
	add	r30, r10, r12
	lw	r12, 0(r30)
	add	r30, r13, r2
	lw	r13, 0(r30)
	add	r30, r14, r2
	lw	r14, 0(r30)
	flw	f1, 0(r14)
	fsw	f1, 0(r6)
	flw	f1, 1(r14)
	fsw	f1, 1(r6)
	flw	f1, 2(r14)
	fsw	f1, 2(r6)
	lw	r15, 0(r8)
	addi	r15, r15, -1
	sw	r1, 9(r3)
	sw	r14, 10(r3)
	sw	r13, 11(r3)
	sw	r12, 12(r3)
	add	r2, r0, r15				# mr	r2, r15
	add	r1, r0, r14				# mr	r1, r14
	add	r29, r0, r7				# mr	r29, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r6, r0, 118
	lw	r1, 12(r3)
	lw	r2, 11(r3)
	lw	r5, 10(r3)
	lw	r29, 1(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 9(r3)
	lw	r2, 5(r1)
	lw	r5, 8(r3)
	add	r30, r2, r5
	lw	r2, 0(r30)
	lw	r6, 7(r3)
	flw	f1, 0(r6)
	fsw	f1, 0(r2)
	flw	f1, 1(r6)
	fsw	f1, 1(r2)
	flw	f1, 2(r6)
	fsw	f1, 2(r2)
	j	beq_cont.18956
beq_then.18955:
beq_cont.18956:
	lw	r2, 8(r3)
	addi	r2, r2, 1
	blei	4, r2, ble_then.18957
	jr	r31				#
ble_then.18957:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 0
	ble	r6, r5, ble_then.18959
	jr	r31				#
ble_then.18959:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 13(r3)
	beqi	0, r5, beq_then.18961
	lw	r5, 6(r1)
	lw	r5, 0(r5)
	flup	f1, 0		# fli	f1, 0.000000
	lw	r6, 7(r3)
	fsw	f1, 0(r6)
	fsw	f1, 1(r6)
	fsw	f1, 2(r6)
	lw	r7, 7(r1)
	lw	r8, 1(r1)
	lw	r9, 6(r3)
	add	r30, r9, r5
	lw	r5, 0(r30)
	add	r30, r7, r2
	lw	r7, 0(r30)
	add	r30, r8, r2
	lw	r8, 0(r30)
	flw	f1, 0(r8)
	lw	r9, 5(r3)
	fsw	f1, 0(r9)
	flw	f1, 1(r8)
	fsw	f1, 1(r9)
	flw	f1, 2(r8)
	fsw	f1, 2(r9)
	lw	r9, 4(r3)
	lw	r9, 0(r9)
	addi	r9, r9, -1
	lw	r29, 3(r3)
	sw	r1, 9(r3)
	sw	r8, 14(r3)
	sw	r7, 15(r3)
	sw	r5, 16(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r1, 16(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	flw	f1, 0(r2)
	lw	r5, 15(r3)
	flw	f2, 0(r5)
	fmul	f1, f1, f2
	flw	f2, 1(r2)
	flw	f3, 1(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r2)
	flw	f3, 2(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18963
	addi	r2, r0, 0
	j	fle_cont.18964
fle_else.18963:
	addi	r2, r0, 1
fle_cont.18964:
	beqi	0, r2, beq_then.18965
	lw	r2, 119(r1)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	lw	r29, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
	j	beq_cont.18966
beq_then.18965:
	lw	r2, 118(r1)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	lw	r29, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
beq_cont.18966:
	addi	r6, r0, 116
	lw	r1, 16(r3)
	lw	r2, 15(r3)
	lw	r5, 14(r3)
	lw	r29, 1(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r1, 9(r3)
	lw	r2, 5(r1)
	lw	r5, 13(r3)
	add	r30, r2, r5
	lw	r2, 0(r30)
	lw	r6, 7(r3)
	flw	f1, 0(r6)
	fsw	f1, 0(r2)
	flw	f1, 1(r6)
	fsw	f1, 1(r2)
	flw	f1, 2(r6)
	fsw	f1, 2(r2)
	j	beq_cont.18962
beq_then.18961:
beq_cont.18962:
	lw	r2, 13(r3)
	addi	r2, r2, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_pixels.3227:
	lw	r6, 17(r29)
	lw	r7, 16(r29)
	lw	r8, 15(r29)
	lw	r9, 14(r29)
	lw	r10, 13(r29)
	lw	r11, 12(r29)
	lw	r12, 11(r29)
	lw	r13, 10(r29)
	lw	r14, 9(r29)
	lw	r15, 8(r29)
	lw	r16, 7(r29)
	lw	r17, 6(r29)
	lw	r18, 5(r29)
	lw	r19, 4(r29)
	lw	r20, 3(r29)
	lw	r21, 2(r29)
	lw	r22, 1(r29)
	addi	r23, r0, 0
	ble	r23, r2, ble_then.18967
	jr	r31				#
ble_then.18967:
	flw	f4, 0(r13)
	lw	r13, 0(r19)
	sub	r13, r2, r13
	itof	f5, r13
	fmul	f4, f4, f5
	flw	f5, 0(r12)
	fmul	f5, f4, f5
	fadd	f5, f5, f1
	fsw	f5, 0(r15)
	flw	f5, 1(r12)
	fmul	f5, f4, f5
	fadd	f5, f5, f2
	fsw	f5, 1(r15)
	flw	f5, 2(r12)
	fmul	f4, f4, f5
	fadd	f4, f4, f3
	fsw	f4, 2(r15)
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r29, 6(r3)
	sw	r16, 7(r3)
	sw	r18, 8(r3)
	sw	r8, 9(r3)
	sw	r11, 10(r3)
	sw	r17, 11(r3)
	sw	r9, 12(r3)
	sw	r21, 13(r3)
	sw	r22, 14(r3)
	sw	r5, 15(r3)
	sw	r15, 16(r3)
	sw	r7, 17(r3)
	sw	r2, 18(r3)
	sw	r1, 19(r3)
	sw	r10, 20(r3)
	sw	r6, 21(r3)
	sw	r14, 22(r3)
	add	r2, r0, r20				# mr	r2, r20
	add	r1, r0, r15				# mr	r1, r15
	sw	r31, 23(r3)
	addi	r3, r3, 24
	jal	vecunit_sgn.2855				#	bl	vecunit_sgn.2855
	addi	r3, r3, -24
	lw	r31, 23(r3)
	flup	f1, 0		# fli	f1, 0.000000
	lw	r1, 22(r3)
	fsw	f1, 0(r1)
	fsw	f1, 1(r1)
	fsw	f1, 2(r1)
	lw	r2, 21(r3)
	flw	f1, 0(r2)
	lw	r5, 20(r3)
	fsw	f1, 0(r5)
	flw	f1, 1(r2)
	fsw	f1, 1(r5)
	flw	f1, 2(r2)
	fsw	f1, 2(r5)
	addi	r2, r0, 0
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 18(r3)
	lw	r6, 19(r3)
	add	r30, r6, r5
	lw	r7, 0(r30)
	flup	f2, 0		# fli	f2, 0.000000
	lw	r8, 16(r3)
	lw	r29, 17(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r8				# mr	r2, r8
	sw	r31, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -24
	lw	r31, 23(r3)
	lw	r1, 18(r3)
	lw	r2, 19(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	lw	r6, 22(r3)
	flw	f1, 0(r6)
	fsw	f1, 0(r5)
	flw	f1, 1(r6)
	fsw	f1, 1(r5)
	flw	f1, 2(r6)
	fsw	f1, 2(r5)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 6(r5)
	lw	r6, 15(r3)
	sw	r6, 0(r5)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r7, 2(r5)
	lw	r7, 0(r7)
	addi	r8, r0, 0
	ble	r8, r7, ble_then.18969
	j	ble_cont.18970
ble_then.18969:
	lw	r7, 3(r5)
	lw	r7, 0(r7)
	sw	r5, 23(r3)
	beqi	0, r7, beq_then.18971
	lw	r7, 6(r5)
	lw	r7, 0(r7)
	flup	f1, 0		# fli	f1, 0.000000
	lw	r8, 14(r3)
	fsw	f1, 0(r8)
	fsw	f1, 1(r8)
	fsw	f1, 2(r8)
	lw	r9, 7(r5)
	lw	r10, 1(r5)
	lw	r11, 13(r3)
	add	r30, r11, r7
	lw	r7, 0(r30)
	lw	r9, 0(r9)
	lw	r10, 0(r10)
	flw	f1, 0(r10)
	lw	r11, 12(r3)
	fsw	f1, 0(r11)
	flw	f1, 1(r10)
	fsw	f1, 1(r11)
	flw	f1, 2(r10)
	fsw	f1, 2(r11)
	lw	r11, 11(r3)
	lw	r11, 0(r11)
	addi	r11, r11, -1
	lw	r29, 10(r3)
	sw	r10, 24(r3)
	sw	r9, 25(r3)
	sw	r7, 26(r3)
	add	r2, r0, r11				# mr	r2, r11
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
	lw	r1, 26(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	flw	f1, 0(r2)
	lw	r5, 25(r3)
	flw	f2, 0(r5)
	fmul	f1, f1, f2
	flw	f2, 1(r2)
	flw	f3, 1(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r2)
	flw	f3, 2(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18973
	addi	r2, r0, 0
	j	fle_cont.18974
fle_else.18973:
	addi	r2, r0, 1
fle_cont.18974:
	beqi	0, r2, beq_then.18975
	lw	r2, 119(r1)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	lw	r29, 9(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
	j	beq_cont.18976
beq_then.18975:
	lw	r2, 118(r1)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	lw	r29, 9(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
beq_cont.18976:
	addi	r6, r0, 116
	lw	r1, 26(r3)
	lw	r2, 25(r3)
	lw	r5, 24(r3)
	lw	r29, 8(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
	lw	r1, 23(r3)
	lw	r2, 5(r1)
	lw	r2, 0(r2)
	lw	r5, 14(r3)
	flw	f1, 0(r5)
	fsw	f1, 0(r2)
	flw	f1, 1(r5)
	fsw	f1, 1(r2)
	flw	f1, 2(r5)
	fsw	f1, 2(r2)
	j	beq_cont.18972
beq_then.18971:
beq_cont.18972:
	addi	r2, r0, 1
	lw	r1, 23(r3)
	lw	r29, 7(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
ble_cont.18970:
	lw	r1, 18(r3)
	addi	r2, r1, -1
	lw	r1, 15(r3)
	addi	r1, r1, 1
	addi	r5, r0, 5
	ble	r5, r1, ble_then.18977
	add	r5, r0, r1
	j	ble_cont.18978
ble_then.18977:
	addi	r5, r1, -5
ble_cont.18978:
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r1, 19(r3)
	lw	r29, 6(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_line.3234:
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
scan_pixel.3238:
	lw	r8, 7(r29)
	lw	r9, 6(r29)
	lw	r10, 5(r29)
	lw	r11, 4(r29)
	lw	r12, 3(r29)
	lw	r13, 2(r29)
	lw	r14, 1(r29)
	lw	r15, 0(r11)
	ble	r15, r1, ble_then.18979
	add	r30, r6, r1
	lw	r15, 0(r30)
	lw	r15, 0(r15)
	flw	f1, 0(r15)
	fsw	f1, 0(r10)
	flw	f1, 1(r15)
	fsw	f1, 1(r10)
	flw	f1, 2(r15)
	fsw	f1, 2(r10)
	lw	r15, 1(r11)
	addi	r16, r2, 1
	ble	r15, r16, ble_then.18980
	blei	0, r2, ble_then.18982
	lw	r15, 0(r11)
	addi	r16, r1, 1
	ble	r15, r16, ble_then.18984
	blei	0, r1, ble_then.18986
	addi	r15, r0, 1
	j	ble_cont.18987
ble_then.18986:
	addi	r15, r0, 0
ble_cont.18987:
	j	ble_cont.18985
ble_then.18984:
	addi	r15, r0, 0
ble_cont.18985:
	j	ble_cont.18983
ble_then.18982:
	addi	r15, r0, 0
ble_cont.18983:
	j	ble_cont.18981
ble_then.18980:
	addi	r15, r0, 0
ble_cont.18981:
	sw	r29, 0(r3)
	sw	r8, 1(r3)
	sw	r7, 2(r3)
	sw	r5, 3(r3)
	sw	r9, 4(r3)
	sw	r12, 5(r3)
	sw	r2, 6(r3)
	sw	r6, 7(r3)
	sw	r11, 8(r3)
	sw	r1, 9(r3)
	sw	r10, 10(r3)
	beqi	0, r15, beq_then.18988
	addi	r14, r0, 0
	add	r30, r6, r1
	lw	r15, 0(r30)
	addi	r16, r0, 0
	lw	r17, 2(r15)
	lw	r17, 0(r17)
	ble	r16, r17, ble_then.18990
	j	ble_cont.18991
ble_then.18990:
	add	r30, r6, r1
	lw	r16, 0(r30)
	lw	r16, 2(r16)
	lw	r16, 0(r16)
	add	r30, r5, r1
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.18992
	addi	r16, r0, 0
	j	beq_cont.18993
beq_then.18992:
	add	r30, r7, r1
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.18994
	addi	r16, r0, 0
	j	beq_cont.18995
beq_then.18994:
	addi	r17, r1, -1
	add	r30, r6, r17
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.18996
	addi	r16, r0, 0
	j	beq_cont.18997
beq_then.18996:
	addi	r17, r1, 1
	add	r30, r6, r17
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.18998
	addi	r16, r0, 0
	j	beq_cont.18999
beq_then.18998:
	addi	r16, r0, 1
beq_cont.18999:
beq_cont.18997:
beq_cont.18995:
beq_cont.18993:
	beqi	0, r16, beq_then.19000
	lw	r15, 3(r15)
	lw	r15, 0(r15)
	beqi	0, r15, beq_then.19002
	add	r2, r0, r5				# mr	r2, r5
	add	r29, r0, r13				# mr	r29, r13
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r14				# mr	r7, r14
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.19003
beq_then.19002:
beq_cont.19003:
	addi	r8, r0, 1
	lw	r1, 9(r3)
	lw	r2, 6(r3)
	lw	r5, 3(r3)
	lw	r6, 7(r3)
	lw	r7, 2(r3)
	lw	r29, 4(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.19001
beq_then.19000:
	add	r30, r6, r1
	lw	r13, 0(r30)
	add	r2, r0, r14				# mr	r2, r14
	add	r1, r0, r13				# mr	r1, r13
	add	r29, r0, r12				# mr	r29, r12
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
beq_cont.19001:
ble_cont.18991:
	j	beq_cont.18989
beq_then.18988:
	add	r30, r6, r1
	lw	r13, 0(r30)
	addi	r15, r0, 0
	lw	r16, 2(r13)
	addi	r17, r0, 0
	lw	r16, 0(r16)
	ble	r17, r16, ble_then.19004
	j	ble_cont.19005
ble_then.19004:
	lw	r16, 3(r13)
	lw	r16, 0(r16)
	sw	r13, 11(r3)
	beqi	0, r16, beq_then.19006
	add	r2, r0, r15				# mr	r2, r15
	add	r1, r0, r13				# mr	r1, r13
	add	r29, r0, r14				# mr	r29, r14
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.19007
beq_then.19006:
beq_cont.19007:
	addi	r2, r0, 1
	lw	r1, 11(r3)
	lw	r29, 5(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.19005:
beq_cont.18989:
	lw	r1, 10(r3)
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.19008
	addi	r2, r0, 0
	j	feq_cont.19009
feq_else.19008:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.19010
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.19011
fle_else.19010:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.19011:
feq_cont.19009:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.19012
	addi	r2, r0, 255
	j	ble_cont.19013
ble_then.19012:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.19014
	addi	r2, r0, 0
	j	ble_cont.19015
ble_then.19014:
ble_cont.19015:
ble_cont.19013:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.19016
	addi	r5, r0, 45
	out	r5
	sub	r2, r0, r2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.19017
ble_then.19016:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.19017:
	addi	r1, r0, 32
	out	r1
	lw	r1, 10(r3)
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.19018
	addi	r2, r0, 0
	j	feq_cont.19019
feq_else.19018:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.19020
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.19021
fle_else.19020:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.19021:
feq_cont.19019:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.19022
	addi	r2, r0, 255
	j	ble_cont.19023
ble_then.19022:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.19024
	addi	r2, r0, 0
	j	ble_cont.19025
ble_then.19024:
ble_cont.19025:
ble_cont.19023:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.19026
	addi	r5, r0, 45
	out	r5
	sub	r2, r0, r2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.19027
ble_then.19026:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.19027:
	addi	r1, r0, 32
	out	r1
	lw	r1, 10(r3)
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.19028
	addi	r2, r0, 0
	j	feq_cont.19029
feq_else.19028:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.19030
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.19031
fle_else.19030:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.19031:
feq_cont.19029:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.19032
	addi	r2, r0, 255
	j	ble_cont.19033
ble_then.19032:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.19034
	addi	r2, r0, 0
	j	ble_cont.19035
ble_then.19034:
ble_cont.19035:
ble_cont.19033:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.19036
	addi	r5, r0, 45
	out	r5
	sub	r2, r0, r2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.19037
ble_then.19036:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.19037:
	addi	r1, r0, 10
	out	r1
	lw	r1, 9(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 0(r2)
	ble	r5, r1, ble_then.19038
	lw	r6, 7(r3)
	add	r30, r6, r1
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	flw	f1, 0(r5)
	lw	r7, 10(r3)
	fsw	f1, 0(r7)
	flw	f1, 1(r5)
	fsw	f1, 1(r7)
	flw	f1, 2(r5)
	fsw	f1, 2(r7)
	lw	r5, 1(r2)
	lw	r7, 6(r3)
	addi	r8, r7, 1
	ble	r5, r8, ble_then.19039
	blei	0, r7, ble_then.19041
	lw	r2, 0(r2)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.19043
	blei	0, r1, ble_then.19045
	addi	r2, r0, 1
	j	ble_cont.19046
ble_then.19045:
	addi	r2, r0, 0
ble_cont.19046:
	j	ble_cont.19044
ble_then.19043:
	addi	r2, r0, 0
ble_cont.19044:
	j	ble_cont.19042
ble_then.19041:
	addi	r2, r0, 0
ble_cont.19042:
	j	ble_cont.19040
ble_then.19039:
	addi	r2, r0, 0
ble_cont.19040:
	sw	r1, 12(r3)
	beqi	0, r2, beq_then.19047
	addi	r8, r0, 0
	lw	r5, 3(r3)
	lw	r2, 2(r3)
	lw	r29, 4(r3)
	add	r28, r0, r7				# mr	r28, r7
	add	r7, r0, r2				# mr	r7, r2
	add	r2, r0, r28				# mr	r2, r28
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.19048
beq_then.19047:
	add	r30, r6, r1
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r29, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.19048:
	lw	r29, 1(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 12(r3)
	addi	r1, r1, 1
	lw	r2, 6(r3)
	lw	r5, 3(r3)
	lw	r6, 7(r3)
	lw	r7, 2(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
ble_then.19038:
	jr	r31				#
ble_then.18979:
	jr	r31				#
scan_line.3244:
	lw	r8, 7(r29)
	lw	r9, 6(r29)
	lw	r10, 5(r29)
	lw	r11, 4(r29)
	lw	r12, 3(r29)
	lw	r13, 2(r29)
	lw	r14, 1(r29)
	lw	r15, 1(r13)
	ble	r15, r1, ble_then.19051
	lw	r15, 1(r13)
	addi	r15, r15, -1
	sw	r29, 0(r3)
	sw	r12, 1(r3)
	sw	r7, 2(r3)
	sw	r10, 3(r3)
	sw	r8, 4(r3)
	sw	r6, 5(r3)
	sw	r2, 6(r3)
	sw	r9, 7(r3)
	sw	r14, 8(r3)
	sw	r1, 9(r3)
	sw	r11, 10(r3)
	sw	r5, 11(r3)
	sw	r13, 12(r3)
	ble	r15, r1, ble_then.19052
	addi	r15, r1, 1
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r15				# mr	r2, r15
	add	r1, r0, r6				# mr	r1, r6
	add	r29, r0, r12				# mr	r29, r12
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	ble_cont.19053
ble_then.19052:
ble_cont.19053:
	addi	r1, r0, 0
	lw	r2, 12(r3)
	lw	r5, 0(r2)
	blei	0, r5, ble_then.19054
	lw	r6, 11(r3)
	lw	r5, 0(r6)
	lw	r5, 0(r5)
	flw	f1, 0(r5)
	lw	r7, 10(r3)
	fsw	f1, 0(r7)
	flw	f1, 1(r5)
	fsw	f1, 1(r7)
	flw	f1, 2(r5)
	fsw	f1, 2(r7)
	lw	r5, 1(r2)
	lw	r7, 9(r3)
	addi	r8, r7, 1
	ble	r5, r8, ble_then.19056
	blei	0, r7, ble_then.19058
	lw	r5, 0(r2)
	blei	1, r5, ble_then.19060
	addi	r5, r0, 0
	j	ble_cont.19061
ble_then.19060:
	addi	r5, r0, 0
ble_cont.19061:
	j	ble_cont.19059
ble_then.19058:
	addi	r5, r0, 0
ble_cont.19059:
	j	ble_cont.19057
ble_then.19056:
	addi	r5, r0, 0
ble_cont.19057:
	beqi	0, r5, beq_then.19062
	addi	r8, r0, 0
	lw	r5, 6(r3)
	lw	r9, 5(r3)
	lw	r29, 7(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r7, r0, r9				# mr	r7, r9
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.19063
beq_then.19062:
	lw	r1, 0(r6)
	addi	r5, r0, 0
	lw	r29, 8(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.19063:
	lw	r29, 4(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r1, r0, 1
	lw	r2, 9(r3)
	lw	r5, 6(r3)
	lw	r6, 11(r3)
	lw	r7, 5(r3)
	lw	r29, 3(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	ble_cont.19055
ble_then.19054:
ble_cont.19055:
	lw	r1, 9(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	addi	r1, r1, 2
	addi	r5, r0, 5
	ble	r5, r1, ble_then.19064
	add	r5, r0, r1
	j	ble_cont.19065
ble_then.19064:
	addi	r5, r1, -5
ble_cont.19065:
	lw	r1, 12(r3)
	lw	r6, 1(r1)
	ble	r6, r2, ble_then.19066
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r5, 13(r3)
	sw	r2, 14(r3)
	ble	r1, r2, ble_then.19068
	addi	r1, r2, 1
	lw	r6, 6(r3)
	lw	r29, 1(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -16
	lw	r31, 15(r3)
	j	ble_cont.19069
ble_then.19068:
ble_cont.19069:
	addi	r1, r0, 0
	lw	r2, 14(r3)
	lw	r5, 11(r3)
	lw	r6, 5(r3)
	lw	r7, 6(r3)
	lw	r29, 3(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r1, 14(r3)
	addi	r1, r1, 1
	lw	r2, 13(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5
	ble	r5, r2, ble_then.19070
	add	r7, r0, r2
	j	ble_cont.19071
ble_then.19070:
	addi	r7, r2, -5
ble_cont.19071:
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	lw	r6, 11(r3)
	lw	r29, 0(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -16
	lw	r31, 15(r3)
	j	ble_cont.19067
ble_then.19066:
ble_cont.19067:
	jr	r31				#
ble_then.19051:
	jr	r31				#
create_float5x3array.3250:
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
init_line_elements.3254:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.19074
	jr	r31				#
ble_then.19074:
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
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r2, r0, 5
	lw	r5, 3(r3)
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
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -9
	lw	r31, 8(r3)
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 9(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -11
	lw	r31, 10(r3)
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 10(r3)
	sw	r1, 6(r2)
	lw	r1, 9(r3)
	sw	r1, 5(r2)
	lw	r1, 8(r3)
	sw	r1, 4(r2)
	lw	r1, 7(r3)
	sw	r1, 3(r2)
	lw	r1, 6(r3)
	sw	r1, 2(r2)
	lw	r1, 5(r3)
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
	ble	r2, r1, ble_then.19075
	add	r1, r0, r5
	jr	r31				#
ble_then.19075:
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 11(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -13
	lw	r31, 12(r3)
	sw	r1, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 13(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r2, r0, 5
	lw	r5, 3(r3)
	sw	r1, 14(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -16
	lw	r31, 15(r3)
	sw	r1, 15(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -17
	lw	r31, 16(r3)
	sw	r1, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -18
	lw	r31, 17(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 17(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -19
	lw	r31, 18(r3)
	sw	r1, 18(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -20
	lw	r31, 19(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 18(r3)
	sw	r1, 6(r2)
	lw	r1, 17(r3)
	sw	r1, 5(r2)
	lw	r1, 16(r3)
	sw	r1, 4(r2)
	lw	r1, 15(r3)
	sw	r1, 3(r2)
	lw	r1, 14(r3)
	sw	r1, 2(r2)
	lw	r1, 13(r3)
	sw	r1, 1(r2)
	lw	r1, 12(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 11(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r28, 0(r29)
	jr	r28
calc_dirvec.3264:
	lw	r6, 1(r29)
	addi	r7, r0, 5
	ble	r7, r1, ble_then.19076
	fmul	f1, f2, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f1, f1, f2
	fsqrt	f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f2, f2, f1
	fle	r30, f0, f2
	beq	r0, r30, fle_else.19077
	flup	f5, 2		# fli	f5, 1.000000
	j	fle_cont.19078
fle_else.19077:
	flup	f5, 11		# fli	f5, -1.000000
fle_cont.19078:
	fmul	f2, f2, f5
	flup	f6, 23		# fli	f6, 4.375000
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r29, 2(r3)
	fsw	f4, 4(r3)
	sw	r1, 6(r3)
	fsw	f1, 8(r3)
	fsw	f3, 10(r3)
	fle	r30, f6, f2
	beq	r0, r30, fle_else.19081
	flup	f6, 24		# fli	f6, 2.437500
	fle	r30, f6, f2
	beq	r0, r30, fle_else.19083
	flup	f6, 15		# fli	f6, 1.570796
	flup	f7, 2		# fli	f7, 1.000000
	fdiv	f2, f7, f2
	fsw	f5, 12(r3)
	fsw	f6, 14(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	flw	f2, 12(r3)
	fmul	f1, f1, f2
	j	fle_cont.19084
fle_else.19083:
	flup	f6, 16		# fli	f6, 0.785398
	flup	f7, 2		# fli	f7, 1.000000
	fsub	f7, f2, f7
	flup	f8, 2		# fli	f8, 1.000000
	fadd	f2, f2, f8
	fdiv	f2, f7, f2
	fsw	f5, 12(r3)
	fsw	f6, 16(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fadd	f1, f2, f1
	flw	f2, 12(r3)
	fmul	f1, f1, f2
fle_cont.19084:
	j	fle_cont.19082
fle_else.19081:
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -19
	lw	r31, 18(r3)
fle_cont.19082:
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	fsw	f1, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	sin.2739				#	bl	sin.2739
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 18(r3)
	fsw	f1, 20(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	cos.2741				#	bl	cos.2741
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 20(r3)
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
	fle	r30, f0, f3
	beq	r0, r30, fle_else.19085
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.19086
fle_else.19085:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.19086:
	fmul	f3, f3, f4
	flup	f5, 23		# fli	f5, 4.375000
	fsw	f1, 22(r3)
	sw	r1, 24(r3)
	fsw	f2, 26(r3)
	fle	r30, f5, f3
	beq	r0, r30, fle_else.19088
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f3
	beq	r0, r30, fle_else.19090
	flup	f5, 15		# fli	f5, 1.570796
	flup	f6, 2		# fli	f6, 1.000000
	fdiv	f3, f6, f3
	fsw	f4, 28(r3)
	fsw	f5, 30(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -33
	lw	r31, 32(r3)
	flw	f2, 30(r3)
	fadd	f1, f2, f1
	flw	f2, 28(r3)
	fmul	f1, f1, f2
	j	fle_cont.19091
fle_else.19090:
	flup	f5, 16		# fli	f5, 0.785398
	flup	f6, 2		# fli	f6, 1.000000
	fsub	f6, f3, f6
	flup	f7, 2		# fli	f7, 1.000000
	fadd	f3, f3, f7
	fdiv	f3, f6, f3
	fsw	f4, 28(r3)
	fsw	f5, 32(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flw	f2, 32(r3)
	fadd	f1, f2, f1
	flw	f2, 28(r3)
	fmul	f1, f1, f2
fle_cont.19091:
	j	fle_cont.19089
fle_else.19088:
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -35
	lw	r31, 34(r3)
fle_cont.19089:
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	fsw	f1, 34(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	sin.2739				#	bl	sin.2739
	addi	r3, r3, -37
	lw	r31, 36(r3)
	flw	f2, 34(r3)
	fsw	f1, 36(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 38(r3)
	addi	r3, r3, 39
	jal	cos.2741				#	bl	cos.2741
	addi	r3, r3, -39
	lw	r31, 38(r3)
	flw	f2, 36(r3)
	fdiv	f1, f2, f1
	flw	f2, 26(r3)
	fmul	f2, f1, f2
	flw	f1, 22(r3)
	flw	f3, 10(r3)
	flw	f4, 4(r3)
	lw	r1, 24(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
ble_then.19076:
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
calc_dirvecs.3272:
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.19093
	jr	r31				#
ble_then.19093:
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
	ble	r5, r2, ble_then.19096
	j	ble_cont.19097
ble_then.19096:
	addi	r2, r2, -5
ble_cont.19097:
	flw	f1, 2(r3)
	lw	r5, 6(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
calc_dirvec_rows.3277:
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.19098
	jr	r31				#
ble_then.19098:
	itof	f1, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f1, f1, f2
	addi	r7, r0, 4
	sw	r29, 0(r3)
	sw	r6, 1(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	add	r1, r0, r7				# mr	r1, r7
	add	r29, r0, r6				# mr	r29, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r1, r1, -1
	lw	r2, 3(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5
	ble	r5, r2, ble_then.19100
	j	ble_cont.19101
ble_then.19100:
	addi	r2, r2, -5
ble_cont.19101:
	lw	r5, 2(r3)
	addi	r5, r5, 4
	addi	r6, r0, 0
	ble	r6, r1, ble_then.19102
	jr	r31				#
ble_then.19102:
	itof	f1, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f1, f1, f2
	addi	r6, r0, 4
	lw	r29, 1(r3)
	sw	r5, 5(r3)
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 7(r3)
	addi	r1, r1, -1
	lw	r2, 6(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5
	ble	r5, r2, ble_then.19104
	j	ble_cont.19105
ble_then.19104:
	addi	r2, r2, -5
ble_cont.19105:
	lw	r5, 5(r3)
	addi	r5, r5, 4
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
create_dirvec_elements.3283:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.19106
	jr	r31				#
ble_then.19106:
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
	ble	r2, r1, ble_then.19108
	jr	r31				#
ble_then.19108:
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
	add	r1, r0, r2
	lw	r2, 5(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.19110
	jr	r31				#
ble_then.19110:
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 7(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 3(r3)
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
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.19112
	jr	r31				#
ble_then.19112:
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 9(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 3(r3)
	lw	r1, 0(r1)
	sw	r2, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 10(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 9(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r28, 0(r29)
	jr	r28
create_dirvecs.3286:
	lw	r2, 3(r29)
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.19114
	jr	r31				#
ble_then.19114:
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
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 9(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 9(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 7(r3)
	sw	r1, 117(r2)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 10(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 10(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 7(r3)
	sw	r1, 116(r2)
	addi	r1, r0, 115
	lw	r29, 1(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 2(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.19116
	jr	r31				#
ble_then.19116:
	addi	r2, r0, 120
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 11(r3)
	sw	r2, 12(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 13(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 13(r3)
	sw	r1, 0(r2)
	lw	r1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 11(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	add	r30, r5, r2
	lw	r1, 0(r30)
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 14(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 5(r3)
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
	lw	r1, 15(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 14(r3)
	sw	r1, 118(r2)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -17
	lw	r31, 16(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 5(r3)
	lw	r1, 0(r1)
	sw	r2, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -18
	lw	r31, 17(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 16(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 14(r3)
	sw	r1, 117(r2)
	addi	r1, r0, 116
	lw	r29, 1(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r1, 11(r3)
	addi	r1, r1, -1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
init_dirvec_constants.3288:
	lw	r5, 3(r29)
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	addi	r8, r0, 0
	ble	r8, r2, ble_then.19118
	jr	r31				#
ble_then.19118:
	add	r30, r1, r2
	lw	r8, 0(r30)
	lw	r9, 0(r6)
	addi	r9, r9, -1
	sw	r29, 0(r3)
	sw	r7, 1(r3)
	sw	r5, 2(r3)
	sw	r6, 3(r3)
	sw	r1, 4(r3)
	sw	r2, 5(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	add	r29, r0, r7				# mr	r29, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.19120
	jr	r31				#
ble_then.19120:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	lw	r7, 0(r6)
	addi	r7, r7, -1
	addi	r8, r0, 0
	sw	r1, 6(r3)
	ble	r8, r7, ble_then.19122
	j	ble_cont.19123
ble_then.19122:
	lw	r8, 2(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r5)
	lw	r11, 0(r5)
	lw	r12, 1(r9)
	sw	r5, 7(r3)
	beqi	1, r12, beq_then.19124
	beqi	2, r12, beq_then.19126
	sw	r7, 8(r3)
	sw	r10, 9(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_second_table.3067				#	bl	setup_second_table.3067
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19127
beq_then.19126:
	sw	r7, 8(r3)
	sw	r10, 9(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_surface_table.3064				#	bl	setup_surface_table.3064
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19127:
	j	beq_cont.19125
beq_then.19124:
	sw	r7, 8(r3)
	sw	r10, 9(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_rect_table.3061				#	bl	setup_rect_table.3061
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19125:
	addi	r2, r2, -1
	lw	r1, 7(r3)
	lw	r29, 1(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
ble_cont.19123:
	lw	r1, 6(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.19128
	jr	r31				#
ble_then.19128:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	lw	r7, 0(r6)
	addi	r7, r7, -1
	lw	r29, 1(r3)
	sw	r1, 10(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 10(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.19130
	jr	r31				#
ble_then.19130:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r1, 11(r3)
	ble	r7, r6, ble_then.19132
	j	ble_cont.19133
ble_then.19132:
	lw	r7, 2(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 12(r3)
	beqi	1, r10, beq_then.19134
	beqi	2, r10, beq_then.19136
	sw	r6, 13(r3)
	sw	r8, 14(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	setup_second_table.3067				#	bl	setup_second_table.3067
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19137
beq_then.19136:
	sw	r6, 13(r3)
	sw	r8, 14(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	setup_surface_table.3064				#	bl	setup_surface_table.3064
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19137:
	j	beq_cont.19135
beq_then.19134:
	sw	r6, 13(r3)
	sw	r8, 14(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	setup_rect_table.3061				#	bl	setup_rect_table.3061
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19135:
	addi	r2, r2, -1
	lw	r1, 12(r3)
	lw	r29, 1(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -16
	lw	r31, 15(r3)
ble_cont.19133:
	lw	r1, 11(r3)
	addi	r2, r1, -1
	lw	r1, 4(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
init_vecset_constants.3291:
	lw	r2, 5(r29)
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	addi	r9, r0, 0
	ble	r9, r1, ble_then.19138
	jr	r31				#
ble_then.19138:
	add	r30, r8, r1
	lw	r9, 0(r30)
	lw	r10, 119(r9)
	lw	r11, 0(r5)
	addi	r11, r11, -1
	addi	r12, r0, 0
	sw	r29, 0(r3)
	sw	r8, 1(r3)
	sw	r1, 2(r3)
	sw	r7, 3(r3)
	sw	r2, 4(r3)
	sw	r6, 5(r3)
	sw	r5, 6(r3)
	sw	r9, 7(r3)
	ble	r12, r11, ble_then.19140
	j	ble_cont.19141
ble_then.19140:
	add	r30, r2, r11
	lw	r12, 0(r30)
	lw	r13, 1(r10)
	lw	r14, 0(r10)
	lw	r15, 1(r12)
	sw	r10, 8(r3)
	beqi	1, r15, beq_then.19142
	beqi	2, r15, beq_then.19144
	sw	r11, 9(r3)
	sw	r13, 10(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r14				# mr	r1, r14
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_second_table.3067				#	bl	setup_second_table.3067
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19145
beq_then.19144:
	sw	r11, 9(r3)
	sw	r13, 10(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r14				# mr	r1, r14
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_surface_table.3064				#	bl	setup_surface_table.3064
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19145:
	j	beq_cont.19143
beq_then.19142:
	sw	r11, 9(r3)
	sw	r13, 10(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r14				# mr	r1, r14
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_rect_table.3061				#	bl	setup_rect_table.3061
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19143:
	addi	r2, r2, -1
	lw	r1, 8(r3)
	lw	r29, 5(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
ble_cont.19141:
	lw	r1, 7(r3)
	lw	r2, 118(r1)
	lw	r5, 6(r3)
	lw	r6, 0(r5)
	addi	r6, r6, -1
	lw	r29, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r6				# mr	r2, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 7(r3)
	lw	r2, 117(r1)
	lw	r5, 6(r3)
	lw	r6, 0(r5)
	addi	r6, r6, -1
	addi	r7, r0, 0
	ble	r7, r6, ble_then.19146
	j	ble_cont.19147
ble_then.19146:
	lw	r7, 4(r3)
	add	r30, r7, r6
	lw	r8, 0(r30)
	lw	r9, 1(r2)
	lw	r10, 0(r2)
	lw	r11, 1(r8)
	sw	r2, 11(r3)
	beqi	1, r11, beq_then.19148
	beqi	2, r11, beq_then.19150
	sw	r6, 12(r3)
	sw	r9, 13(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_second_table.3067				#	bl	setup_second_table.3067
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19151
beq_then.19150:
	sw	r6, 12(r3)
	sw	r9, 13(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_surface_table.3064				#	bl	setup_surface_table.3064
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19151:
	j	beq_cont.19149
beq_then.19148:
	sw	r6, 12(r3)
	sw	r9, 13(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_rect_table.3061				#	bl	setup_rect_table.3061
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19149:
	addi	r2, r2, -1
	lw	r1, 11(r3)
	lw	r29, 5(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
ble_cont.19147:
	addi	r2, r0, 116
	lw	r1, 7(r3)
	lw	r29, 3(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 2(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.19152
	jr	r31				#
ble_then.19152:
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 119(r5)
	lw	r7, 6(r3)
	lw	r8, 0(r7)
	addi	r8, r8, -1
	lw	r29, 5(r3)
	sw	r1, 14(r3)
	sw	r5, 15(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r1, 15(r3)
	lw	r2, 118(r1)
	lw	r5, 6(r3)
	lw	r6, 0(r5)
	addi	r6, r6, -1
	addi	r7, r0, 0
	ble	r7, r6, ble_then.19154
	j	ble_cont.19155
ble_then.19154:
	lw	r7, 4(r3)
	add	r30, r7, r6
	lw	r8, 0(r30)
	lw	r9, 1(r2)
	lw	r10, 0(r2)
	lw	r11, 1(r8)
	sw	r2, 16(r3)
	beqi	1, r11, beq_then.19156
	beqi	2, r11, beq_then.19158
	sw	r6, 17(r3)
	sw	r9, 18(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_second_table.3067				#	bl	setup_second_table.3067
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19159
beq_then.19158:
	sw	r6, 17(r3)
	sw	r9, 18(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_surface_table.3064				#	bl	setup_surface_table.3064
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19159:
	j	beq_cont.19157
beq_then.19156:
	sw	r6, 17(r3)
	sw	r9, 18(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_rect_table.3061				#	bl	setup_rect_table.3061
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19157:
	addi	r2, r2, -1
	lw	r1, 16(r3)
	lw	r29, 5(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
ble_cont.19155:
	addi	r2, r0, 117
	lw	r1, 15(r3)
	lw	r29, 3(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r1, 14(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.19160
	jr	r31				#
ble_then.19160:
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 119(r5)
	lw	r7, 6(r3)
	lw	r7, 0(r7)
	addi	r7, r7, -1
	addi	r8, r0, 0
	sw	r1, 19(r3)
	sw	r5, 20(r3)
	ble	r8, r7, ble_then.19162
	j	ble_cont.19163
ble_then.19162:
	lw	r8, 4(r3)
	add	r30, r8, r7
	lw	r8, 0(r30)
	lw	r9, 1(r6)
	lw	r10, 0(r6)
	lw	r11, 1(r8)
	sw	r6, 21(r3)
	beqi	1, r11, beq_then.19164
	beqi	2, r11, beq_then.19166
	sw	r7, 22(r3)
	sw	r9, 23(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	setup_second_table.3067				#	bl	setup_second_table.3067
	addi	r3, r3, -25
	lw	r31, 24(r3)
	lw	r2, 22(r3)
	lw	r5, 23(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19167
beq_then.19166:
	sw	r7, 22(r3)
	sw	r9, 23(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	setup_surface_table.3064				#	bl	setup_surface_table.3064
	addi	r3, r3, -25
	lw	r31, 24(r3)
	lw	r2, 22(r3)
	lw	r5, 23(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19167:
	j	beq_cont.19165
beq_then.19164:
	sw	r7, 22(r3)
	sw	r9, 23(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	setup_rect_table.3061				#	bl	setup_rect_table.3061
	addi	r3, r3, -25
	lw	r31, 24(r3)
	lw	r2, 22(r3)
	lw	r5, 23(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19165:
	addi	r2, r2, -1
	lw	r1, 21(r3)
	lw	r29, 5(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -25
	lw	r31, 24(r3)
ble_cont.19163:
	addi	r2, r0, 118
	lw	r1, 20(r3)
	lw	r29, 3(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -25
	lw	r31, 24(r3)
	lw	r1, 19(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.19168
	jr	r31				#
ble_then.19168:
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	addi	r5, r0, 119
	lw	r29, 3(r3)
	sw	r1, 24(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r1, 24(r3)
	addi	r1, r1, -1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
setup_rect_reflection.3302:
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
	ble	r8, r7, ble_then.19172
	j	ble_cont.19173
ble_then.19172:
	lw	r8, 13(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r9)
	beqi	1, r10, beq_then.19174
	beqi	2, r10, beq_then.19176
	sw	r7, 23(r3)
	sw	r1, 24(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_second_table.3067				#	bl	setup_second_table.3067
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 24(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19177
beq_then.19176:
	sw	r7, 23(r3)
	sw	r1, 24(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_surface_table.3064				#	bl	setup_surface_table.3064
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 24(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19177:
	j	beq_cont.19175
beq_then.19174:
	sw	r7, 23(r3)
	sw	r1, 24(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_rect_table.3061				#	bl	setup_rect_table.3061
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 24(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19175:
	addi	r2, r2, -1
	lw	r1, 22(r3)
	lw	r29, 12(r3)
	sw	r31, 25(r3)
	addi	r3, r3, 26
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -26
	lw	r31, 25(r3)
ble_cont.19173:
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
	ble	r8, r7, ble_then.19179
	j	ble_cont.19180
ble_then.19179:
	lw	r8, 13(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r9)
	beqi	1, r10, beq_then.19181
	beqi	2, r10, beq_then.19183
	sw	r7, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_second_table.3067				#	bl	setup_second_table.3067
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19184
beq_then.19183:
	sw	r7, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_surface_table.3064				#	bl	setup_surface_table.3064
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19184:
	j	beq_cont.19182
beq_then.19181:
	sw	r7, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_rect_table.3061				#	bl	setup_rect_table.3061
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19182:
	addi	r2, r2, -1
	lw	r1, 31(r3)
	lw	r29, 12(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -35
	lw	r31, 34(r3)
ble_cont.19180:
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
	ble	r7, r6, ble_then.19185
	j	ble_cont.19186
ble_then.19185:
	lw	r7, 13(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.19187
	beqi	2, r8, beq_then.19189
	sw	r6, 40(r3)
	sw	r1, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	setup_second_table.3067				#	bl	setup_second_table.3067
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 40(r3)
	lw	r5, 41(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19190
beq_then.19189:
	sw	r6, 40(r3)
	sw	r1, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	setup_surface_table.3064				#	bl	setup_surface_table.3064
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 40(r3)
	lw	r5, 41(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19190:
	j	beq_cont.19188
beq_then.19187:
	sw	r6, 40(r3)
	sw	r1, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	setup_rect_table.3061				#	bl	setup_rect_table.3061
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 40(r3)
	lw	r5, 41(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19188:
	addi	r2, r2, -1
	lw	r1, 39(r3)
	lw	r29, 12(r3)
	sw	r31, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -43
	lw	r31, 42(r3)
ble_cont.19186:
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
setup_surface_reflection.3305:
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
	flw	f2, 0(r9)
	flw	f3, 0(r12)
	fmul	f2, f2, f3
	flw	f3, 1(r9)
	flw	f4, 1(r12)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flw	f3, 2(r9)
	flw	f4, 2(r12)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flup	f3, 3		# fli	f3, 2.000000
	lw	r12, 4(r2)
	flw	f4, 0(r12)
	fmul	f3, f3, f4
	fmul	f3, f3, f2
	flw	f4, 0(r9)
	fsub	f3, f3, f4
	flup	f4, 3		# fli	f4, 2.000000
	lw	r12, 4(r2)
	flw	f5, 1(r12)
	fmul	f4, f4, f5
	fmul	f4, f4, f2
	flw	f5, 1(r9)
	fsub	f4, f4, f5
	flup	f5, 3		# fli	f5, 2.000000
	lw	r2, 4(r2)
	flw	f6, 2(r2)
	fmul	f5, f5, f6
	fmul	f2, f5, f2
	flw	f5, 2(r9)
	fsub	f2, f2, f5
	addi	r2, r0, 3
	flup	f5, 0		# fli	f5, 0.000000
	sw	r7, 0(r3)
	sw	r11, 1(r3)
	sw	r5, 2(r3)
	sw	r1, 3(r3)
	fsw	f1, 4(r3)
	sw	r10, 6(r3)
	sw	r6, 7(r3)
	fsw	f2, 8(r3)
	fsw	f4, 10(r3)
	fsw	f3, 12(r3)
	sw	r8, 14(r3)
	add	r1, r0, r2				# mr	r1, r2
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
	ble	r7, r6, ble_then.19192
	j	ble_cont.19193
ble_then.19192:
	lw	r7, 7(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.19194
	beqi	2, r8, beq_then.19196
	sw	r6, 17(r3)
	sw	r1, 18(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_second_table.3067				#	bl	setup_second_table.3067
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19197
beq_then.19196:
	sw	r6, 17(r3)
	sw	r1, 18(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_surface_table.3064				#	bl	setup_surface_table.3064
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19197:
	j	beq_cont.19195
beq_then.19194:
	sw	r6, 17(r3)
	sw	r1, 18(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_rect_table.3061				#	bl	setup_rect_table.3061
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19195:
	addi	r2, r2, -1
	lw	r1, 16(r3)
	lw	r29, 6(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
ble_cont.19193:
	add	r1, r0, r4
	addi	r4, r4, 3
	flw	f1, 4(r3)
	fsw	f1, 2(r1)
	lw	r2, 16(r3)
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
rt.3310:
	lw	r5, 27(r29)
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
	sw	r10, 0(r3)
	lw	r10, 3(r29)
	sw	r8, 1(r3)
	lw	r8, 2(r29)
	lw	r29, 1(r29)
	sw	r1, 0(r26)
	sw	r2, 1(r26)
	sw	r16, 2(r3)
	srai	r16, r1, 1
	sw	r16, 0(r27)
	srai	r2, r2, 1
	sw	r2, 1(r27)
	flup	f1, 49		# fli	f1, 128.000000
	itof	f2, r1
	fdiv	f1, f1, f2
	fsw	f1, 0(r9)
	lw	r1, 0(r26)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r6, 3(r3)
	sw	r7, 4(r3)
	sw	r20, 5(r3)
	sw	r5, 6(r3)
	sw	r21, 7(r3)
	sw	r23, 8(r3)
	sw	r25, 9(r3)
	sw	r22, 10(r3)
	sw	r18, 11(r3)
	sw	r10, 12(r3)
	sw	r29, 13(r3)
	sw	r8, 14(r3)
	sw	r17, 15(r3)
	sw	r15, 16(r3)
	sw	r12, 17(r3)
	sw	r19, 18(r3)
	sw	r13, 19(r3)
	sw	r14, 20(r3)
	sw	r11, 21(r3)
	sw	r24, 22(r3)
	sw	r26, 23(r3)
	sw	r1, 24(r3)
	sw	r28, 25(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -27
	lw	r31, 26(r3)
	sw	r1, 26(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 27(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -29
	lw	r31, 28(r3)
	addi	r2, r0, 5
	lw	r5, 25(r3)
	sw	r1, 28(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -30
	lw	r31, 29(r3)
	sw	r1, 29(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -31
	lw	r31, 30(r3)
	sw	r1, 30(r3)
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -32
	lw	r31, 31(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 31(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -33
	lw	r31, 32(r3)
	sw	r1, 32(r3)
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -34
	lw	r31, 33(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 32(r3)
	sw	r1, 6(r2)
	lw	r1, 31(r3)
	sw	r1, 5(r2)
	lw	r1, 30(r3)
	sw	r1, 4(r2)
	lw	r1, 29(r3)
	sw	r1, 3(r2)
	lw	r1, 28(r3)
	sw	r1, 2(r2)
	lw	r1, 27(r3)
	sw	r1, 1(r2)
	lw	r1, 26(r3)
	sw	r1, 0(r2)
	lw	r1, 24(r3)
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r2, 23(r3)
	lw	r5, 0(r2)
	addi	r5, r5, -2
	lw	r29, 22(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r2, 23(r3)
	lw	r5, 0(r2)
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 33(r3)
	sw	r5, 34(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 35(r3)
	addi	r3, r3, 36
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -36
	lw	r31, 35(r3)
	sw	r1, 35(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -37
	lw	r31, 36(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 36(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 37(r3)
	addi	r3, r3, 38
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -38
	lw	r31, 37(r3)
	addi	r2, r0, 5
	lw	r5, 25(r3)
	sw	r1, 37(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 38(r3)
	addi	r3, r3, 39
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -39
	lw	r31, 38(r3)
	sw	r1, 38(r3)
	sw	r31, 39(r3)
	addi	r3, r3, 40
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -40
	lw	r31, 39(r3)
	sw	r1, 39(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -41
	lw	r31, 40(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 40(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 41(r3)
	addi	r3, r3, 42
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -42
	lw	r31, 41(r3)
	sw	r1, 41(r3)
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -43
	lw	r31, 42(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 41(r3)
	sw	r1, 6(r2)
	lw	r1, 40(r3)
	sw	r1, 5(r2)
	lw	r1, 39(r3)
	sw	r1, 4(r2)
	lw	r1, 38(r3)
	sw	r1, 3(r2)
	lw	r1, 37(r3)
	sw	r1, 2(r2)
	lw	r1, 36(r3)
	sw	r1, 1(r2)
	lw	r1, 35(r3)
	sw	r1, 0(r2)
	lw	r1, 34(r3)
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 23(r3)
	lw	r5, 0(r2)
	addi	r5, r5, -2
	lw	r29, 22(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 23(r3)
	lw	r5, 0(r2)
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 42(r3)
	sw	r5, 43(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 44(r3)
	addi	r3, r3, 45
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -45
	lw	r31, 44(r3)
	sw	r1, 44(r3)
	sw	r31, 45(r3)
	addi	r3, r3, 46
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -46
	lw	r31, 45(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 45(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 46(r3)
	addi	r3, r3, 47
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -47
	lw	r31, 46(r3)
	addi	r2, r0, 5
	lw	r5, 25(r3)
	sw	r1, 46(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 47(r3)
	addi	r3, r3, 48
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -48
	lw	r31, 47(r3)
	sw	r1, 47(r3)
	sw	r31, 48(r3)
	addi	r3, r3, 49
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -49
	lw	r31, 48(r3)
	sw	r1, 48(r3)
	sw	r31, 49(r3)
	addi	r3, r3, 50
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -50
	lw	r31, 49(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 49(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 50(r3)
	addi	r3, r3, 51
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -51
	lw	r31, 50(r3)
	sw	r1, 50(r3)
	sw	r31, 51(r3)
	addi	r3, r3, 52
	jal	create_float5x3array.3250				#	bl	create_float5x3array.3250
	addi	r3, r3, -52
	lw	r31, 51(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 50(r3)
	sw	r1, 6(r2)
	lw	r1, 49(r3)
	sw	r1, 5(r2)
	lw	r1, 48(r3)
	sw	r1, 4(r2)
	lw	r1, 47(r3)
	sw	r1, 3(r2)
	lw	r1, 46(r3)
	sw	r1, 2(r2)
	lw	r1, 45(r3)
	sw	r1, 1(r2)
	lw	r1, 44(r3)
	sw	r1, 0(r2)
	lw	r1, 43(r3)
	sw	r31, 51(r3)
	addi	r3, r3, 52
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -52
	lw	r31, 51(r3)
	lw	r2, 23(r3)
	lw	r5, 0(r2)
	addi	r5, r5, -2
	lw	r29, 22(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 51(r3)
	addi	r3, r3, 52
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -52
	lw	r31, 51(r3)
	lw	r29, 21(r3)
	sw	r1, 51(r3)
	sw	r31, 52(r3)
	addi	r3, r3, 53
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -53
	lw	r31, 52(r3)
	lw	r29, 20(r3)
	sw	r31, 52(r3)
	addi	r3, r3, 53
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -53
	lw	r31, 52(r3)
	addi	r1, r0, 0
	lw	r29, 19(r3)
	sw	r1, 52(r3)
	sw	r31, 53(r3)
	addi	r3, r3, 54
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -54
	lw	r31, 53(r3)
	beqi	0, r1, beq_then.19199
	addi	r1, r0, 1
	lw	r29, 17(r3)
	sw	r31, 53(r3)
	addi	r3, r3, 54
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -54
	lw	r31, 53(r3)
	j	beq_cont.19200
beq_then.19199:
	lw	r1, 18(r3)
	lw	r2, 52(r3)
	sw	r2, 0(r1)
beq_cont.19200:
	addi	r1, r0, 0
	lw	r29, 16(r3)
	sw	r31, 53(r3)
	addi	r3, r3, 54
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -54
	lw	r31, 53(r3)
	addi	r1, r0, 0
	sw	r31, 53(r3)
	addi	r3, r3, 54
	jal	read_or_network.2971				#	bl	read_or_network.2971
	addi	r3, r3, -54
	lw	r31, 53(r3)
	lw	r2, 15(r3)
	sw	r1, 0(r2)
	addi	r1, r0, 80
	out	r1
	addi	r1, r0, 51
	out	r1
	addi	r1, r0, 10
	out	r1
	lw	r1, 23(r3)
	lw	r5, 0(r1)
	addi	r2, r0, 0
	ble	r2, r5, ble_then.19201
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.19203
	addi	r2, r5, 48
	out	r2
	j	ble_cont.19204
ble_then.19203:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 53(r3)
	ble	r7, r5, ble_then.19205
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 54(r3)
	addi	r3, r3, 55
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -55
	lw	r31, 54(r3)
	j	ble_cont.19206
ble_then.19205:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.19207
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 54(r3)
	addi	r3, r3, 55
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -55
	lw	r31, 54(r3)
	j	ble_cont.19208
ble_then.19207:
	add	r1, r0, r6
ble_cont.19208:
ble_cont.19206:
	sw	r1, 54(r3)
	sw	r31, 55(r3)
	addi	r3, r3, 56
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -56
	lw	r31, 55(r3)
	lw	r1, 54(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 53(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.19204:
	j	ble_cont.19202
ble_then.19201:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.19209
	addi	r2, r5, 48
	out	r2
	j	ble_cont.19210
ble_then.19209:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 55(r3)
	ble	r7, r5, ble_then.19211
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 56(r3)
	addi	r3, r3, 57
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -57
	lw	r31, 56(r3)
	j	ble_cont.19212
ble_then.19211:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.19213
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 56(r3)
	addi	r3, r3, 57
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -57
	lw	r31, 56(r3)
	j	ble_cont.19214
ble_then.19213:
	add	r1, r0, r6
ble_cont.19214:
ble_cont.19212:
	sw	r1, 56(r3)
	sw	r31, 57(r3)
	addi	r3, r3, 58
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -58
	lw	r31, 57(r3)
	lw	r1, 56(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 55(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.19210:
ble_cont.19202:
	addi	r1, r0, 32
	out	r1
	lw	r1, 23(r3)
	lw	r5, 1(r1)
	addi	r2, r0, 0
	ble	r2, r5, ble_then.19215
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.19217
	addi	r2, r5, 48
	out	r2
	j	ble_cont.19218
ble_then.19217:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 57(r3)
	ble	r7, r5, ble_then.19219
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 58(r3)
	addi	r3, r3, 59
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -59
	lw	r31, 58(r3)
	j	ble_cont.19220
ble_then.19219:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.19221
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 58(r3)
	addi	r3, r3, 59
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -59
	lw	r31, 58(r3)
	j	ble_cont.19222
ble_then.19221:
	add	r1, r0, r6
ble_cont.19222:
ble_cont.19220:
	sw	r1, 58(r3)
	sw	r31, 59(r3)
	addi	r3, r3, 60
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -60
	lw	r31, 59(r3)
	lw	r1, 58(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 57(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.19218:
	j	ble_cont.19216
ble_then.19215:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.19223
	addi	r2, r5, 48
	out	r2
	j	ble_cont.19224
ble_then.19223:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 59(r3)
	ble	r7, r5, ble_then.19225
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 60(r3)
	addi	r3, r3, 61
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -61
	lw	r31, 60(r3)
	j	ble_cont.19226
ble_then.19225:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.19227
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 60(r3)
	addi	r3, r3, 61
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -61
	lw	r31, 60(r3)
	j	ble_cont.19228
ble_then.19227:
	add	r1, r0, r6
ble_cont.19228:
ble_cont.19226:
	sw	r1, 60(r3)
	sw	r31, 61(r3)
	addi	r3, r3, 62
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -62
	lw	r31, 61(r3)
	lw	r1, 60(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 59(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.19224:
ble_cont.19216:
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 255
	addi	r2, r0, 0
	addi	r5, r0, 127
	sw	r1, 61(r3)
	sw	r31, 62(r3)
	addi	r3, r3, 63
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -63
	lw	r31, 62(r3)
	sw	r1, 62(r3)
	sw	r31, 63(r3)
	addi	r3, r3, 64
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -64
	lw	r31, 63(r3)
	lw	r1, 62(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 61(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
	addi	r1, r0, 10
	out	r1
	addi	r1, r0, 4
	lw	r29, 14(r3)
	sw	r31, 63(r3)
	addi	r3, r3, 64
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -64
	lw	r31, 63(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r29, 13(r3)
	sw	r31, 63(r3)
	addi	r3, r3, 64
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -64
	lw	r31, 63(r3)
	lw	r1, 12(r3)
	lw	r2, 4(r1)
	lw	r5, 119(r2)
	lw	r6, 18(r3)
	lw	r7, 0(r6)
	addi	r7, r7, -1
	addi	r8, r0, 0
	sw	r2, 63(r3)
	ble	r8, r7, ble_then.19229
	j	ble_cont.19230
ble_then.19229:
	lw	r8, 11(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r5)
	lw	r11, 0(r5)
	lw	r12, 1(r9)
	sw	r5, 64(r3)
	beqi	1, r12, beq_then.19231
	beqi	2, r12, beq_then.19233
	sw	r7, 65(r3)
	sw	r10, 66(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 67(r3)
	addi	r3, r3, 68
	jal	setup_second_table.3067				#	bl	setup_second_table.3067
	addi	r3, r3, -68
	lw	r31, 67(r3)
	lw	r2, 65(r3)
	lw	r5, 66(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19234
beq_then.19233:
	sw	r7, 65(r3)
	sw	r10, 66(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 67(r3)
	addi	r3, r3, 68
	jal	setup_surface_table.3064				#	bl	setup_surface_table.3064
	addi	r3, r3, -68
	lw	r31, 67(r3)
	lw	r2, 65(r3)
	lw	r5, 66(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19234:
	j	beq_cont.19232
beq_then.19231:
	sw	r7, 65(r3)
	sw	r10, 66(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 67(r3)
	addi	r3, r3, 68
	jal	setup_rect_table.3061				#	bl	setup_rect_table.3061
	addi	r3, r3, -68
	lw	r31, 67(r3)
	lw	r2, 65(r3)
	lw	r5, 66(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19232:
	addi	r2, r2, -1
	lw	r1, 64(r3)
	lw	r29, 10(r3)
	sw	r31, 67(r3)
	addi	r3, r3, 68
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -68
	lw	r31, 67(r3)
ble_cont.19230:
	addi	r2, r0, 118
	lw	r1, 63(r3)
	lw	r29, 9(r3)
	sw	r31, 67(r3)
	addi	r3, r3, 68
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -68
	lw	r31, 67(r3)
	lw	r1, 12(r3)
	lw	r1, 3(r1)
	addi	r2, r0, 119
	lw	r29, 9(r3)
	sw	r31, 67(r3)
	addi	r3, r3, 68
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -68
	lw	r31, 67(r3)
	addi	r1, r0, 2
	lw	r29, 8(r3)
	sw	r31, 67(r3)
	addi	r3, r3, 68
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -68
	lw	r31, 67(r3)
	lw	r1, 7(r3)
	flw	f1, 0(r1)
	lw	r2, 6(r3)
	fsw	f1, 0(r2)
	flw	f1, 1(r1)
	fsw	f1, 1(r2)
	flw	f1, 2(r1)
	fsw	f1, 2(r2)
	lw	r1, 18(r3)
	lw	r2, 0(r1)
	addi	r2, r2, -1
	lw	r5, 5(r3)
	lw	r29, 10(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 67(r3)
	addi	r3, r3, 68
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -68
	lw	r31, 67(r3)
	lw	r1, 18(r3)
	lw	r1, 0(r1)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.19235
	j	ble_cont.19236
ble_then.19235:
	lw	r2, 11(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.19237
	j	beq_cont.19238
beq_then.19237:
	lw	r5, 7(r2)
	flw	f1, 0(r5)
	flup	f2, 2		# fli	f2, 1.000000
	sw	r1, 67(r3)
	sw	r2, 68(r3)
	sw	r31, 69(r3)
	addi	r3, r3, 70
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -70
	lw	r31, 69(r3)
	beqi	0, r1, beq_then.19239
	lw	r2, 68(r3)
	lw	r1, 1(r2)
	beqi	1, r1, beq_then.19241
	beqi	2, r1, beq_then.19243
	j	beq_cont.19244
beq_then.19243:
	lw	r1, 67(r3)
	lw	r29, 3(r3)
	sw	r31, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -70
	lw	r31, 69(r3)
beq_cont.19244:
	j	beq_cont.19242
beq_then.19241:
	lw	r1, 67(r3)
	lw	r29, 4(r3)
	sw	r31, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -70
	lw	r31, 69(r3)
beq_cont.19242:
	j	beq_cont.19240
beq_then.19239:
beq_cont.19240:
beq_cont.19238:
ble_cont.19236:
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r1, 42(r3)
	lw	r29, 2(r3)
	sw	r31, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -70
	lw	r31, 69(r3)
	addi	r2, r0, 0
	addi	r5, r0, 2
	lw	r1, 23(r3)
	lw	r6, 1(r1)
	blei	0, r6, ble_then.19245
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r2, 69(r3)
	blei	0, r1, ble_then.19246
	addi	r1, r0, 1
	lw	r6, 51(r3)
	lw	r29, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 70(r3)
	addi	r3, r3, 71
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -71
	lw	r31, 70(r3)
	j	ble_cont.19247
ble_then.19246:
ble_cont.19247:
	addi	r1, r0, 0
	lw	r2, 69(r3)
	lw	r5, 33(r3)
	lw	r6, 42(r3)
	lw	r7, 51(r3)
	lw	r29, 1(r3)
	sw	r31, 70(r3)
	addi	r3, r3, 71
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -71
	lw	r31, 70(r3)
	addi	r1, r0, 1
	addi	r7, r0, 4
	lw	r2, 42(r3)
	lw	r5, 51(r3)
	lw	r6, 33(r3)
	lw	r29, 0(r3)
	sw	r31, 70(r3)
	addi	r3, r3, 71
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -71
	lw	r31, 70(r3)
	jr	r31				#
ble_then.19245:
	jr	r31				#
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
	sw	r2, 34(r3)
	sw	r1, 35(r3)
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
	addi	r5, r0, read_screen_settings.2956
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
	addi	r10, r0, read_light.2958
	sw	r10, 0(r9)
	lw	r10, 6(r3)
	sw	r10, 2(r9)
	lw	r11, 7(r3)
	sw	r11, 1(r9)
	add	r12, r0, r4
	addi	r4, r4, 2
	addi	r13, r0, read_nth_object.2963
	sw	r13, 0(r12)
	lw	r13, 3(r3)
	sw	r13, 1(r12)
	add	r14, r0, r4
	addi	r4, r4, 3
	addi	r15, r0, read_object.2965
	sw	r15, 0(r14)
	sw	r12, 2(r14)
	lw	r15, 2(r3)
	sw	r15, 1(r14)
	add	r16, r0, r4
	addi	r4, r4, 2
	addi	r17, r0, read_and_network.2973
	sw	r17, 0(r16)
	lw	r17, 9(r3)
	sw	r17, 1(r16)
	add	r18, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, solver_rect_surface.2977
	sw	r19, 0(r18)
	lw	r19, 12(r3)
	sw	r19, 1(r18)
	add	r20, r0, r4
	addi	r4, r4, 2
	addi	r21, r0, solver_surface.2992
	sw	r21, 0(r20)
	sw	r19, 1(r20)
	add	r21, r0, r4
	addi	r4, r4, 2
	addi	r22, r0, solver_second.3011
	sw	r22, 0(r21)
	sw	r19, 1(r21)
	add	r22, r0, r4
	addi	r4, r4, 5
	addi	r23, r0, solver.3017
	sw	r23, 0(r22)
	sw	r21, 4(r22)
	sw	r18, 3(r22)
	sw	r19, 2(r22)
	sw	r13, 1(r22)
	add	r23, r0, r4
	addi	r4, r4, 2
	addi	r24, r0, solver_rect_fast.3021
	sw	r24, 0(r23)
	sw	r19, 1(r23)
	add	r24, r0, r4
	addi	r4, r4, 2
	addi	r25, r0, solver_second_fast.3034
	sw	r25, 0(r24)
	sw	r19, 1(r24)
	add	r25, r0, r4
	addi	r4, r4, 2
	addi	r26, r0, solver_second_fast2.3051
	sw	r26, 0(r25)
	sw	r19, 1(r25)
	add	r26, r0, r4
	addi	r4, r4, 5
	addi	r27, r0, solver_fast2.3058
	sw	r27, 0(r26)
	sw	r25, 4(r26)
	sw	r23, 3(r26)
	sw	r19, 2(r26)
	sw	r13, 1(r26)
	add	r27, r0, r4
	addi	r4, r4, 2
	addi	r28, r0, iter_setup_dirvec_constants.3070
	sw	r28, 0(r27)
	sw	r13, 1(r27)
	add	r28, r0, r4
	addi	r4, r4, 2
	addi	r29, r0, setup_startp_constants.3075
	sw	r29, 0(r28)
	sw	r13, 1(r28)
	add	r29, r0, r4
	addi	r4, r4, 2
	sw	r16, 38(r3)
	addi	r16, r0, check_all_inside.3100
	sw	r16, 0(r29)
	sw	r13, 1(r29)
	add	r16, r0, r4
	addi	r4, r4, 10
	sw	r9, 39(r3)
	addi	r9, r0, shadow_check_and_group.3106
	sw	r9, 0(r16)
	lw	r9, 33(r3)
	sw	r9, 9(r16)
	sw	r24, 8(r16)
	sw	r23, 7(r16)
	sw	r19, 6(r16)
	sw	r13, 5(r16)
	sw	r10, 4(r16)
	sw	r12, 40(r3)
	lw	r12, 15(r3)
	sw	r12, 3(r16)
	sw	r14, 41(r3)
	lw	r14, 35(r3)
	sw	r14, 2(r16)
	sw	r29, 1(r16)
	sw	r2, 42(r3)
	add	r2, r0, r4
	addi	r4, r4, 3
	sw	r27, 43(r3)
	addi	r27, r0, shadow_check_one_or_group.3109
	sw	r27, 0(r2)
	sw	r16, 2(r2)
	sw	r17, 1(r2)
	add	r27, r0, r4
	addi	r4, r4, 11
	addi	r7, r0, shadow_check_one_or_matrix.3112
	sw	r7, 0(r27)
	sw	r9, 10(r27)
	sw	r24, 9(r27)
	sw	r23, 8(r27)
	sw	r19, 7(r27)
	sw	r2, 6(r27)
	sw	r16, 5(r27)
	sw	r13, 4(r27)
	sw	r12, 3(r27)
	sw	r14, 2(r27)
	sw	r17, 1(r27)
	add	r2, r0, r4
	addi	r4, r4, 12
	addi	r7, r0, solve_each_element.3115
	sw	r7, 0(r2)
	lw	r7, 14(r3)
	sw	r7, 11(r2)
	lw	r14, 24(r3)
	sw	r14, 10(r2)
	sw	r20, 9(r2)
	sw	r21, 8(r2)
	sw	r18, 7(r2)
	sw	r19, 6(r2)
	sw	r13, 5(r2)
	lw	r16, 13(r3)
	sw	r16, 4(r2)
	sw	r12, 3(r2)
	lw	r24, 16(r3)
	sw	r24, 2(r2)
	sw	r29, 1(r2)
	add	r9, r0, r4
	addi	r4, r4, 3
	addi	r6, r0, solve_one_or_network.3119
	sw	r6, 0(r9)
	sw	r2, 2(r9)
	sw	r17, 1(r9)
	add	r6, r0, r4
	addi	r4, r4, 12
	addi	r8, r0, trace_or_matrix.3123
	sw	r8, 0(r6)
	sw	r7, 11(r6)
	sw	r14, 10(r6)
	sw	r20, 9(r6)
	sw	r21, 8(r6)
	sw	r18, 7(r6)
	sw	r19, 6(r6)
	sw	r22, 5(r6)
	sw	r9, 4(r6)
	sw	r2, 3(r6)
	sw	r13, 2(r6)
	sw	r17, 1(r6)
	add	r2, r0, r4
	addi	r4, r4, 11
	addi	r8, r0, solve_each_element_fast.3129
	sw	r8, 0(r2)
	sw	r7, 10(r2)
	lw	r8, 25(r3)
	sw	r8, 9(r2)
	sw	r25, 8(r2)
	sw	r23, 7(r2)
	sw	r19, 6(r2)
	sw	r13, 5(r2)
	sw	r16, 4(r2)
	sw	r12, 3(r2)
	sw	r24, 2(r2)
	sw	r29, 1(r2)
	add	r9, r0, r4
	addi	r4, r4, 3
	addi	r18, r0, solve_one_or_network_fast.3133
	sw	r18, 0(r9)
	sw	r2, 2(r9)
	sw	r17, 1(r9)
	add	r18, r0, r4
	addi	r4, r4, 10
	addi	r20, r0, trace_or_matrix_fast.3137
	sw	r20, 0(r18)
	sw	r7, 9(r18)
	sw	r25, 8(r18)
	sw	r23, 7(r18)
	sw	r26, 6(r18)
	sw	r19, 5(r18)
	sw	r9, 4(r18)
	sw	r2, 3(r18)
	sw	r13, 2(r18)
	sw	r17, 1(r18)
	add	r20, r0, r4
	addi	r4, r4, 9
	addi	r21, r0, judge_intersection_fast.3141
	sw	r21, 0(r20)
	sw	r18, 8(r20)
	sw	r7, 7(r20)
	sw	r26, 6(r20)
	sw	r19, 5(r20)
	sw	r9, 4(r20)
	sw	r2, 3(r20)
	lw	r2, 11(r3)
	sw	r2, 2(r20)
	sw	r17, 1(r20)
	add	r9, r0, r4
	addi	r4, r4, 3
	addi	r17, r0, get_nvector_second.3147
	sw	r17, 0(r9)
	lw	r17, 17(r3)
	sw	r17, 2(r9)
	sw	r12, 1(r9)
	add	r19, r0, r4
	addi	r4, r4, 4
	addi	r21, r0, get_nvector.3149
	sw	r21, 0(r19)
	sw	r17, 3(r19)
	sw	r16, 2(r19)
	sw	r9, 1(r19)
	add	r21, r0, r4
	addi	r4, r4, 2
	addi	r22, r0, utexture.3152
	sw	r22, 0(r21)
	lw	r22, 18(r3)
	sw	r22, 1(r21)
	add	r23, r0, r4
	addi	r4, r4, 11
	addi	r25, r0, trace_reflections.3159
	sw	r25, 0(r23)
	sw	r18, 10(r23)
	sw	r7, 9(r23)
	sw	r22, 8(r23)
	sw	r27, 7(r23)
	lw	r25, 20(r3)
	sw	r25, 6(r23)
	lw	r26, 37(r3)
	sw	r26, 5(r23)
	sw	r2, 4(r23)
	sw	r17, 3(r23)
	sw	r16, 2(r23)
	sw	r24, 1(r23)
	add	r29, r0, r4
	addi	r4, r4, 24
	addi	r26, r0, trace_ray.3164
	sw	r26, 0(r29)
	sw	r21, 23(r29)
	lw	r26, 0(r3)
	sw	r26, 22(r29)
	sw	r23, 21(r29)
	sw	r6, 20(r29)
	sw	r7, 19(r29)
	sw	r22, 18(r29)
	sw	r8, 17(r29)
	sw	r14, 16(r29)
	sw	r27, 15(r29)
	sw	r28, 14(r29)
	sw	r25, 13(r29)
	sw	r2, 12(r29)
	sw	r13, 11(r29)
	sw	r17, 10(r29)
	sw	r1, 9(r29)
	sw	r15, 8(r29)
	sw	r10, 7(r29)
	sw	r16, 6(r29)
	sw	r12, 5(r29)
	sw	r24, 4(r29)
	sw	r9, 3(r29)
	lw	r6, 1(r3)
	sw	r6, 2(r29)
	sw	r11, 1(r29)
	add	r11, r0, r4
	addi	r4, r4, 15
	addi	r23, r0, trace_diffuse_ray.3170
	sw	r23, 0(r11)
	sw	r21, 14(r11)
	sw	r18, 13(r11)
	sw	r7, 12(r11)
	sw	r22, 11(r11)
	sw	r27, 10(r11)
	sw	r2, 9(r11)
	sw	r13, 8(r11)
	sw	r17, 7(r11)
	sw	r10, 6(r11)
	sw	r16, 5(r11)
	sw	r12, 4(r11)
	sw	r24, 3(r11)
	sw	r9, 2(r11)
	lw	r7, 19(r3)
	sw	r7, 1(r11)
	add	r9, r0, r4
	addi	r4, r4, 14
	addi	r16, r0, iter_trace_diffuse_rays.3173
	sw	r16, 0(r9)
	sw	r21, 13(r9)
	sw	r11, 12(r9)
	sw	r22, 11(r9)
	sw	r27, 10(r9)
	sw	r2, 9(r9)
	sw	r13, 8(r9)
	sw	r17, 7(r9)
	sw	r10, 6(r9)
	sw	r20, 5(r9)
	sw	r12, 4(r9)
	sw	r24, 3(r9)
	sw	r19, 2(r9)
	sw	r7, 1(r9)
	add	r12, r0, r4
	addi	r4, r4, 6
	addi	r16, r0, trace_diffuse_ray_80percent.3182
	sw	r16, 0(r12)
	sw	r8, 5(r12)
	sw	r28, 4(r12)
	sw	r15, 3(r12)
	sw	r9, 2(r12)
	lw	r16, 31(r3)
	sw	r16, 1(r12)
	add	r17, r0, r4
	addi	r4, r4, 9
	addi	r18, r0, calc_diffuse_using_1point.3186
	sw	r18, 0(r17)
	sw	r11, 8(r17)
	sw	r8, 7(r17)
	sw	r28, 6(r17)
	sw	r25, 5(r17)
	sw	r15, 4(r17)
	sw	r9, 3(r17)
	sw	r16, 2(r17)
	sw	r7, 1(r17)
	add	r18, r0, r4
	addi	r4, r4, 3
	addi	r19, r0, calc_diffuse_using_5points.3189
	sw	r19, 0(r18)
	sw	r25, 2(r18)
	sw	r7, 1(r18)
	add	r19, r0, r4
	addi	r4, r4, 5
	addi	r20, r0, do_without_neighbors.3195
	sw	r20, 0(r19)
	sw	r12, 4(r19)
	sw	r25, 3(r19)
	sw	r7, 2(r19)
	sw	r17, 1(r19)
	add	r12, r0, r4
	addi	r4, r4, 4
	addi	r20, r0, try_exploit_neighbors.3211
	sw	r20, 0(r12)
	sw	r19, 3(r12)
	sw	r18, 2(r12)
	sw	r17, 1(r12)
	add	r20, r0, r4
	addi	r4, r4, 2
	addi	r21, r0, write_rgb.3222
	sw	r21, 0(r20)
	sw	r25, 1(r20)
	add	r21, r0, r4
	addi	r4, r4, 8
	addi	r22, r0, pretrace_diffuse_rays.3224
	sw	r22, 0(r21)
	sw	r11, 7(r21)
	sw	r8, 6(r21)
	sw	r28, 5(r21)
	sw	r15, 4(r21)
	sw	r9, 3(r21)
	sw	r16, 2(r21)
	sw	r7, 1(r21)
	add	r22, r0, r4
	addi	r4, r4, 18
	addi	r23, r0, pretrace_pixels.3227
	sw	r23, 0(r22)
	sw	r5, 17(r22)
	sw	r29, 16(r22)
	sw	r11, 15(r22)
	sw	r8, 14(r22)
	sw	r14, 13(r22)
	sw	r28, 12(r22)
	lw	r5, 26(r3)
	sw	r5, 11(r22)
	lw	r5, 23(r3)
	sw	r5, 10(r22)
	sw	r25, 9(r22)
	lw	r8, 29(r3)
	sw	r8, 8(r22)
	sw	r21, 7(r22)
	sw	r15, 6(r22)
	sw	r9, 5(r22)
	lw	r8, 22(r3)
	sw	r8, 4(r22)
	sw	r6, 3(r22)
	sw	r16, 2(r22)
	sw	r7, 1(r22)
	add	r7, r0, r4
	addi	r4, r4, 7
	addi	r9, r0, pretrace_line.3234
	sw	r9, 0(r7)
	lw	r9, 28(r3)
	sw	r9, 6(r7)
	lw	r9, 27(r3)
	sw	r9, 5(r7)
	sw	r5, 4(r7)
	sw	r22, 3(r7)
	lw	r9, 21(r3)
	sw	r9, 2(r7)
	sw	r8, 1(r7)
	add	r11, r0, r4
	addi	r4, r4, 8
	addi	r14, r0, scan_pixel.3238
	sw	r14, 0(r11)
	sw	r20, 7(r11)
	sw	r12, 6(r11)
	sw	r25, 5(r11)
	sw	r9, 4(r11)
	sw	r19, 3(r11)
	sw	r18, 2(r11)
	sw	r17, 1(r11)
	add	r14, r0, r4
	addi	r4, r4, 8
	addi	r17, r0, scan_line.3244
	sw	r17, 0(r14)
	sw	r20, 7(r14)
	sw	r12, 6(r14)
	sw	r11, 5(r14)
	sw	r25, 4(r14)
	sw	r7, 3(r14)
	sw	r9, 2(r14)
	sw	r19, 1(r14)
	add	r12, r0, r4
	addi	r4, r4, 2
	addi	r17, r0, init_line_elements.3254
	sw	r17, 0(r12)
	sw	r6, 1(r12)
	add	r17, r0, r4
	addi	r4, r4, 2
	addi	r18, r0, calc_dirvec.3264
	sw	r18, 0(r17)
	sw	r16, 1(r17)
	add	r18, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, calc_dirvecs.3272
	sw	r19, 0(r18)
	sw	r17, 1(r18)
	add	r17, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, calc_dirvec_rows.3277
	sw	r19, 0(r17)
	sw	r18, 1(r17)
	add	r18, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, create_dirvec_elements.3283
	sw	r19, 0(r18)
	sw	r15, 1(r18)
	add	r19, r0, r4
	addi	r4, r4, 4
	addi	r20, r0, create_dirvecs.3286
	sw	r20, 0(r19)
	sw	r15, 3(r19)
	sw	r16, 2(r19)
	sw	r18, 1(r19)
	add	r18, r0, r4
	addi	r4, r4, 4
	addi	r20, r0, init_dirvec_constants.3288
	sw	r20, 0(r18)
	sw	r13, 3(r18)
	sw	r15, 2(r18)
	lw	r20, 43(r3)
	sw	r20, 1(r18)
	add	r21, r0, r4
	addi	r4, r4, 6
	addi	r22, r0, init_vecset_constants.3291
	sw	r22, 0(r21)
	sw	r13, 5(r21)
	sw	r15, 4(r21)
	sw	r20, 3(r21)
	sw	r18, 2(r21)
	sw	r16, 1(r21)
	add	r22, r0, r4
	addi	r4, r4, 7
	addi	r23, r0, setup_rect_reflection.3302
	sw	r23, 0(r22)
	lw	r23, 37(r3)
	sw	r23, 6(r22)
	sw	r13, 5(r22)
	sw	r1, 4(r22)
	sw	r15, 3(r22)
	sw	r10, 2(r22)
	sw	r20, 1(r22)
	add	r24, r0, r4
	addi	r4, r4, 7
	addi	r25, r0, setup_surface_reflection.3305
	sw	r25, 0(r24)
	sw	r23, 6(r24)
	sw	r13, 5(r24)
	sw	r1, 4(r24)
	sw	r15, 3(r24)
	sw	r10, 2(r24)
	sw	r20, 1(r24)
	add	r29, r0, r4
	addi	r4, r4, 28
	addi	r1, r0, rt.3310
	sw	r1, 0(r29)
	lw	r1, 33(r3)
	sw	r1, 27(r29)
	sw	r24, 26(r29)
	sw	r22, 25(r29)
	sw	r11, 24(r29)
	sw	r5, 23(r29)
	sw	r14, 22(r29)
	lw	r1, 42(r3)
	sw	r1, 21(r29)
	lw	r1, 41(r3)
	sw	r1, 20(r29)
	lw	r1, 40(r3)
	sw	r1, 19(r29)
	lw	r1, 39(r3)
	sw	r1, 18(r29)
	lw	r1, 38(r3)
	sw	r1, 17(r29)
	sw	r7, 16(r29)
	sw	r2, 15(r29)
	sw	r13, 14(r29)
	sw	r15, 13(r29)
	lw	r1, 34(r3)
	sw	r1, 12(r29)
	sw	r10, 11(r29)
	sw	r20, 10(r29)
	sw	r21, 9(r29)
	sw	r12, 8(r29)
	sw	r18, 7(r29)
	sw	r9, 6(r29)
	sw	r8, 5(r29)
	sw	r6, 4(r29)
	sw	r16, 3(r29)
	sw	r19, 2(r29)
	sw	r17, 1(r29)
	addi	r1, r0, 128
	addi	r2, r0, 128
	sw	r31, 44(r3)
	addi	r3, r3, 45
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -45
	lw	r31, 44(r3)
	addi	_R_0, r0, 0
