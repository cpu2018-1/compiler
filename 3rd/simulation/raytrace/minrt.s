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
	beq	r0, r30, fle_else.17937
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17938
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17939
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17940
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17941
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17942
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17943
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17944
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17945
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17946
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17947
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17948
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17949
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17950
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17951
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17952
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2726
fle_else.17952:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17951:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17950:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17949:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17948:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17947:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17946:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17945:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17944:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17943:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17942:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17941:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17940:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17939:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17938:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17937:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2729:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17953
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17954
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17955
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17956
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2729
fle_else.17956:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2729
fle_else.17955:
	jr	r31				#
fle_else.17954:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17957
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17958
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2729
fle_else.17958:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2729
fle_else.17957:
	jr	r31				#
fle_else.17953:
	jr	r31				#
sin.2739:
	flup	f2, 14		# fli	f2, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17959
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.17960
fle_else.17959:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.17960:
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
	beq	r0, r30, fle_else.17961
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17963
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17965
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17967
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17969
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17971
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17973
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17975
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17977
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17979
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17981
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17983
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17985
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17987
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2726				#	bl	hoge.2726
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.17988
fle_else.17987:
fle_cont.17988:
	j	fle_cont.17986
fle_else.17985:
fle_cont.17986:
	j	fle_cont.17984
fle_else.17983:
fle_cont.17984:
	j	fle_cont.17982
fle_else.17981:
fle_cont.17982:
	j	fle_cont.17980
fle_else.17979:
fle_cont.17980:
	j	fle_cont.17978
fle_else.17977:
fle_cont.17978:
	j	fle_cont.17976
fle_else.17975:
fle_cont.17976:
	j	fle_cont.17974
fle_else.17973:
fle_cont.17974:
	j	fle_cont.17972
fle_else.17971:
fle_cont.17972:
	j	fle_cont.17970
fle_else.17969:
fle_cont.17970:
	j	fle_cont.17968
fle_else.17967:
fle_cont.17968:
	j	fle_cont.17966
fle_else.17965:
fle_cont.17966:
	j	fle_cont.17964
fle_else.17963:
fle_cont.17964:
	j	fle_cont.17962
fle_else.17961:
fle_cont.17962:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2729				#	bl	fuga.2729
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17989
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17990
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17991
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
fle_else.17991:
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
fle_else.17990:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17992
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
fle_else.17992:
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
fle_else.17989:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.17993
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17994
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
fle_else.17994:
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
fle_else.17993:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17995
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
fle_else.17995:
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
	beq	r0, r30, fle_else.17996
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17998
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18000
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18002
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18004
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18006
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18008
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18010
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18012
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18014
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18016
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18018
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18020
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18022
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2726				#	bl	hoge.2726
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.18023
fle_else.18022:
fle_cont.18023:
	j	fle_cont.18021
fle_else.18020:
fle_cont.18021:
	j	fle_cont.18019
fle_else.18018:
fle_cont.18019:
	j	fle_cont.18017
fle_else.18016:
fle_cont.18017:
	j	fle_cont.18015
fle_else.18014:
fle_cont.18015:
	j	fle_cont.18013
fle_else.18012:
fle_cont.18013:
	j	fle_cont.18011
fle_else.18010:
fle_cont.18011:
	j	fle_cont.18009
fle_else.18008:
fle_cont.18009:
	j	fle_cont.18007
fle_else.18006:
fle_cont.18007:
	j	fle_cont.18005
fle_else.18004:
fle_cont.18005:
	j	fle_cont.18003
fle_else.18002:
fle_cont.18003:
	j	fle_cont.18001
fle_else.18000:
fle_cont.18001:
	j	fle_cont.17999
fle_else.17998:
fle_cont.17999:
	j	fle_cont.17997
fle_else.17996:
fle_cont.17997:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2729				#	bl	fuga.2729
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18024
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.18025
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.18026
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
fle_else.18026:
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
fle_else.18025:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18027
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
fle_else.18027:
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
fle_else.18024:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.18028
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.18029
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
fle_else.18029:
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
fle_else.18028:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18030
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
fle_else.18030:
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
	ble	r7, r1, ble_then.18031
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r7, r5, 3
	slli	r8, r5, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.18032
	j	div10_sub.2751
ble_then.18032:
	slli	r2, r5, 3
	slli	r7, r5, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.18033
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	j	div10_sub.2751
ble_then.18033:
	add	r1, r0, r5
	jr	r31				#
ble_then.18031:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.18034
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r7, r2, 3
	slli	r8, r2, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.18035
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r6				# mr	r2, r6
	j	div10_sub.2751
ble_then.18035:
	slli	r6, r2, 3
	slli	r7, r2, 1
	add	r6, r6, r7
	addi	r6, r6, 9
	ble	r1, r6, ble_then.18036
	j	div10_sub.2751
ble_then.18036:
	add	r1, r0, r2
	jr	r31				#
ble_then.18034:
	add	r1, r0, r6
	jr	r31				#
print_uint.2771:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.18037
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.18037:
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
	ble	r2, r1, ble_then.18038
	addi	r2, r1, 48
	out	r2
	j	ble_cont.18039
ble_then.18038:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.18040
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.18041
ble_then.18040:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.18042
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.18043
ble_then.18042:
	add	r1, r0, r5
ble_cont.18043:
ble_cont.18041:
	addi	r2, r0, 10
	sw	r1, 2(r3)
	ble	r2, r1, ble_then.18044
	addi	r2, r1, 48
	out	r2
	j	ble_cont.18045
ble_then.18044:
	addi	r2, r0, 0
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 10
	sw	r1, 3(r3)
	ble	r2, r1, ble_then.18046
	addi	r2, r1, 48
	out	r2
	j	ble_cont.18047
ble_then.18046:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.18048
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.18049
ble_then.18048:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.18050
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.18051
ble_then.18050:
	add	r1, r0, r5
ble_cont.18051:
ble_cont.18049:
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
ble_cont.18047:
	lw	r1, 3(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 2(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.18045:
	lw	r1, 2(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 1(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.18039:
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
	beq	r0, r30, feq_else.18052
	addi	r5, r0, 1
	j	feq_cont.18053
feq_else.18052:
	addi	r5, r0, 0
feq_cont.18053:
	beqi	0, r5, beq_then.18054
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.18055
beq_then.18054:
	beqi	0, r2, beq_then.18056
	flup	f2, 11		# fli	f2, -1.000000
	fdiv	f1, f2, f1
	j	beq_cont.18057
beq_then.18056:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
beq_cont.18057:
beq_cont.18055:
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
	beqi	-1, r1, beq_then.18064
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
	beq	r0, r30, fle_else.18065
	addi	r1, r0, 0
	j	fle_cont.18066
fle_else.18065:
	addi	r1, r0, 1
fle_cont.18066:
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
	beqi	0, r2, beq_then.18067
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
	j	beq_cont.18068
beq_then.18067:
beq_cont.18068:
	lw	r2, 3(r3)
	beqi	2, r2, beq_then.18069
	lw	r5, 8(r3)
	j	beq_cont.18070
beq_then.18069:
	addi	r5, r0, 1
beq_cont.18070:
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
	beqi	3, r7, beq_then.18071
	beqi	2, r7, beq_then.18073
	j	beq_cont.18074
beq_then.18073:
	lw	r2, 8(r3)
	beqi	0, r2, beq_then.18075
	addi	r2, r0, 0
	j	beq_cont.18076
beq_then.18075:
	addi	r2, r0, 1
beq_cont.18076:
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	vecunit_sgn.2855				#	bl	vecunit_sgn.2855
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.18074:
	j	beq_cont.18072
beq_then.18071:
	flw	f1, 0(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18077
	addi	r2, r0, 1
	j	feq_cont.18078
feq_else.18077:
	addi	r2, r0, 0
feq_cont.18078:
	beqi	0, r2, beq_then.18079
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18080
beq_then.18079:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18081
	addi	r2, r0, 1
	j	feq_cont.18082
feq_else.18081:
	addi	r2, r0, 0
feq_cont.18082:
	beqi	0, r2, beq_then.18083
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.18084
beq_then.18083:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18085
	addi	r2, r0, 0
	j	fle_cont.18086
fle_else.18085:
	addi	r2, r0, 1
fle_cont.18086:
	beqi	0, r2, beq_then.18087
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.18088
beq_then.18087:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.18088:
beq_cont.18084:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.18080:
	fsw	f1, 0(r5)
	flw	f1, 1(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18089
	addi	r2, r0, 1
	j	feq_cont.18090
feq_else.18089:
	addi	r2, r0, 0
feq_cont.18090:
	beqi	0, r2, beq_then.18091
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18092
beq_then.18091:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18093
	addi	r2, r0, 1
	j	feq_cont.18094
feq_else.18093:
	addi	r2, r0, 0
feq_cont.18094:
	beqi	0, r2, beq_then.18095
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.18096
beq_then.18095:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18097
	addi	r2, r0, 0
	j	fle_cont.18098
fle_else.18097:
	addi	r2, r0, 1
fle_cont.18098:
	beqi	0, r2, beq_then.18099
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.18100
beq_then.18099:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.18100:
beq_cont.18096:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.18092:
	fsw	f1, 1(r5)
	flw	f1, 2(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18101
	addi	r2, r0, 1
	j	feq_cont.18102
feq_else.18101:
	addi	r2, r0, 0
feq_cont.18102:
	beqi	0, r2, beq_then.18103
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18104
beq_then.18103:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18105
	addi	r2, r0, 1
	j	feq_cont.18106
feq_else.18105:
	addi	r2, r0, 0
feq_cont.18106:
	beqi	0, r2, beq_then.18107
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.18108
beq_then.18107:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18109
	addi	r2, r0, 0
	j	fle_cont.18110
fle_else.18109:
	addi	r2, r0, 1
fle_cont.18110:
	beqi	0, r2, beq_then.18111
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.18112
beq_then.18111:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.18112:
beq_cont.18108:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.18104:
	fsw	f1, 2(r5)
beq_cont.18072:
	lw	r1, 5(r3)
	beqi	0, r1, beq_then.18113
	lw	r1, 6(r3)
	lw	r2, 11(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	rotate_quadratic_matrix.2960				#	bl	rotate_quadratic_matrix.2960
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.18114
beq_then.18113:
beq_cont.18114:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18064:
	addi	r1, r0, 0
	jr	r31				#
read_object.2965:
	lw	r2, 2(r29)
	lw	r5, 1(r29)
	addi	r6, r0, 60
	ble	r6, r1, ble_then.18115
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
	beqi	0, r1, beq_then.18116
	lw	r1, 3(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.18117
	lw	r29, 1(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.18118
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.18119
	lw	r29, 1(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.18120
	lw	r1, 5(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.18121
	lw	r29, 1(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	0, r1, beq_then.18122
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18122:
	lw	r1, 2(r3)
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.18121:
	jr	r31				#
beq_then.18120:
	lw	r1, 2(r3)
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.18119:
	jr	r31				#
beq_then.18118:
	lw	r1, 2(r3)
	lw	r2, 4(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.18117:
	jr	r31				#
beq_then.18116:
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.18115:
	jr	r31				#
read_net_item.2969:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.18131
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.18132
	lw	r2, 2(r3)
	addi	r5, r2, 1
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.18134
	lw	r2, 4(r3)
	addi	r5, r2, 1
	sw	r1, 5(r3)
	sw	r5, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.18136
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
	j	beq_cont.18137
beq_then.18136:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18137:
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.18135
beq_then.18134:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18135:
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.18133
beq_then.18132:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18133:
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.18131:
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
	beqi	-1, r1, beq_then.18138
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.18140
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.18142
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
	j	beq_cont.18143
beq_then.18142:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.18143:
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.18141
beq_then.18140:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.18141:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.18139
beq_then.18138:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.18139:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.18144
	lw	r1, 0(r3)
	addi	r5, r1, 1
	sw	r2, 4(r3)
	sw	r5, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.18145
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.18147
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
	j	beq_cont.18148
beq_then.18147:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18148:
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.18146
beq_then.18145:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.18146:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.18149
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
	j	beq_cont.18150
beq_then.18149:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.18150:
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.18144:
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
	beqi	-1, r1, beq_then.18151
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	-1, r1, beq_then.18153
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.18155
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
	j	beq_cont.18156
beq_then.18155:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.18156:
	lw	r2, 4(r3)
	sw	r2, 1(r1)
	j	beq_cont.18154
beq_then.18153:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.18154:
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	j	beq_cont.18152
beq_then.18151:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.18152:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.18157
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
	beqi	-1, r1, beq_then.18158
	sw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	-1, r1, beq_then.18160
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
	j	beq_cont.18161
beq_then.18160:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.18161:
	lw	r2, 7(r3)
	sw	r2, 0(r1)
	j	beq_cont.18159
beq_then.18158:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.18159:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.18162
	lw	r2, 6(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18162:
	jr	r31				#
beq_then.18157:
	jr	r31				#
solver_rect_surface.2977:
	lw	r8, 1(r29)
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.18165
	addi	r9, r0, 1
	j	feq_cont.18166
feq_else.18165:
	addi	r9, r0, 0
feq_cont.18166:
	beqi	0, r9, beq_then.18167
	addi	r1, r0, 0
	jr	r31				#
beq_then.18167:
	lw	r9, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.18168
	addi	r10, r0, 0
	j	fle_cont.18169
fle_else.18168:
	addi	r10, r0, 1
fle_cont.18169:
	beqi	0, r1, beq_then.18170
	beqi	0, r10, beq_then.18172
	addi	r1, r0, 0
	j	beq_cont.18173
beq_then.18172:
	addi	r1, r0, 1
beq_cont.18173:
	j	beq_cont.18171
beq_then.18170:
	add	r1, r0, r10
beq_cont.18171:
	add	r30, r9, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.18174
	j	beq_cont.18175
beq_then.18174:
	fneg	f4, f4
beq_cont.18175:
	fsub	f1, f4, f1
	add	r30, r2, r5
	flw	f4, 0(r30)
	fdiv	f1, f1, f4
	add	r30, r2, r6
	flw	f4, 0(r30)
	fmul	f4, f1, f4
	fadd	f2, f4, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18176
	j	fle_cont.18177
fle_else.18176:
	fneg	f2, f2
fle_cont.18177:
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
	beqi	0, r1, beq_then.18178
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	flw	f1, 0(r30)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	flw	f3, 2(r3)
	fadd	f1, f1, f3
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18179
	j	fle_cont.18180
fle_else.18179:
	fneg	f1, f1
fle_cont.18180:
	lw	r2, 1(r3)
	add	r30, r2, r1
	flw	f3, 0(r30)
	fadd	f2, f0, f3				# fmr	f2, f3
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.18181
	lw	r1, 0(r3)
	flw	f1, 4(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.18181:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18178:
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
	beq	r0, r30, fle_else.18182
	addi	r2, r0, 0
	j	fle_cont.18183
fle_else.18182:
	addi	r2, r0, 1
fle_cont.18183:
	beqi	0, r2, beq_then.18184
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
beq_then.18184:
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
	beqi	0, r2, beq_then.18185
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
beq_then.18185:
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
	beqi	0, r2, beq_then.18186
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
beq_then.18186:
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
	beq	r0, r30, feq_else.18188
	addi	r1, r0, 1
	j	feq_cont.18189
feq_else.18188:
	addi	r1, r0, 0
feq_cont.18189:
	beqi	0, r1, beq_then.18190
	addi	r1, r0, 0
	jr	r31				#
beq_then.18190:
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
	beqi	3, r2, beq_then.18191
	j	beq_cont.18192
beq_then.18191:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.18192:
	flw	f2, 12(r3)
	fmul	f3, f2, f2
	flw	f4, 10(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18193
	addi	r2, r0, 0
	j	fle_cont.18194
fle_else.18193:
	addi	r2, r0, 1
fle_cont.18194:
	beqi	0, r2, beq_then.18195
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18196
	j	beq_cont.18197
beq_then.18196:
	fneg	f1, f1
beq_cont.18197:
	fsub	f1, f1, f2
	fdiv	f1, f1, f4
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.18195:
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
	beqi	1, r5, beq_then.18198
	beqi	2, r5, beq_then.18199
	add	r29, r0, r6				# mr	r29, r6
	lw	r28, 0(r29)
	jr	r28
beq_then.18199:
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
	beq	r0, r30, fle_else.18200
	addi	r2, r0, 0
	j	fle_cont.18201
fle_else.18200:
	addi	r2, r0, 1
fle_cont.18201:
	beqi	0, r2, beq_then.18202
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
beq_then.18202:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18198:
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
	beqi	0, r1, beq_then.18203
	addi	r1, r0, 1
	jr	r31				#
beq_then.18203:
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
	beqi	0, r1, beq_then.18204
	addi	r1, r0, 2
	jr	r31				#
beq_then.18204:
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
	beqi	0, r1, beq_then.18205
	addi	r1, r0, 3
	jr	r31				#
beq_then.18205:
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
	beq	r0, r30, fle_else.18206
	j	fle_cont.18207
fle_else.18206:
	fneg	f5, f5
fle_cont.18207:
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
	beqi	0, r1, beq_then.18209
	lw	r1, 12(r3)
	flw	f1, 2(r1)
	flw	f2, 10(r3)
	fmul	f1, f2, f1
	flw	f3, 8(r3)
	fadd	f1, f1, f3
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18211
	j	fle_cont.18212
fle_else.18211:
	fneg	f1, f1
fle_cont.18212:
	lw	r2, 7(r3)
	lw	r5, 4(r2)
	flw	f4, 2(r5)
	fadd	f2, f0, f4				# fmr	f2, f4
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.18213
	lw	r1, 6(r3)
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18215
	addi	r2, r0, 1
	j	feq_cont.18216
feq_else.18215:
	addi	r2, r0, 0
feq_cont.18216:
	beqi	0, r2, beq_then.18217
	addi	r1, r0, 0
	j	beq_cont.18218
beq_then.18217:
	addi	r1, r0, 1
beq_cont.18218:
	j	beq_cont.18214
beq_then.18213:
	addi	r1, r0, 0
beq_cont.18214:
	j	beq_cont.18210
beq_then.18209:
	addi	r1, r0, 0
beq_cont.18210:
	beqi	0, r1, beq_then.18219
	lw	r1, 0(r3)
	flw	f1, 10(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.18219:
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
	beq	r0, r30, fle_else.18220
	j	fle_cont.18221
fle_else.18220:
	fneg	f3, f3
fle_cont.18221:
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
	beqi	0, r1, beq_then.18223
	lw	r1, 12(r3)
	flw	f1, 2(r1)
	flw	f2, 14(r3)
	fmul	f1, f2, f1
	flw	f3, 8(r3)
	fadd	f1, f1, f3
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18225
	j	fle_cont.18226
fle_else.18225:
	fneg	f1, f1
fle_cont.18226:
	lw	r2, 7(r3)
	lw	r5, 4(r2)
	flw	f4, 2(r5)
	fadd	f2, f0, f4				# fmr	f2, f4
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.18227
	lw	r1, 6(r3)
	flw	f1, 3(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18229
	addi	r2, r0, 1
	j	feq_cont.18230
feq_else.18229:
	addi	r2, r0, 0
feq_cont.18230:
	beqi	0, r2, beq_then.18231
	addi	r1, r0, 0
	j	beq_cont.18232
beq_then.18231:
	addi	r1, r0, 1
beq_cont.18232:
	j	beq_cont.18228
beq_then.18227:
	addi	r1, r0, 0
beq_cont.18228:
	j	beq_cont.18224
beq_then.18223:
	addi	r1, r0, 0
beq_cont.18224:
	beqi	0, r1, beq_then.18233
	lw	r1, 0(r3)
	flw	f1, 14(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 2
	jr	r31				#
beq_then.18233:
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
	beq	r0, r30, fle_else.18234
	j	fle_cont.18235
fle_else.18234:
	fneg	f2, f2
fle_cont.18235:
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
	beqi	0, r1, beq_then.18236
	lw	r1, 12(r3)
	flw	f1, 1(r1)
	flw	f2, 16(r3)
	fmul	f1, f2, f1
	flw	f3, 4(r3)
	fadd	f1, f1, f3
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18238
	j	fle_cont.18239
fle_else.18238:
	fneg	f1, f1
fle_cont.18239:
	lw	r1, 7(r3)
	lw	r1, 4(r1)
	flw	f3, 1(r1)
	fadd	f2, f0, f3				# fmr	f2, f3
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.18240
	lw	r1, 6(r3)
	flw	f1, 5(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18242
	addi	r1, r0, 1
	j	feq_cont.18243
feq_else.18242:
	addi	r1, r0, 0
feq_cont.18243:
	beqi	0, r1, beq_then.18244
	addi	r1, r0, 0
	j	beq_cont.18245
beq_then.18244:
	addi	r1, r0, 1
beq_cont.18245:
	j	beq_cont.18241
beq_then.18240:
	addi	r1, r0, 0
beq_cont.18241:
	j	beq_cont.18237
beq_then.18236:
	addi	r1, r0, 0
beq_cont.18237:
	beqi	0, r1, beq_then.18246
	lw	r1, 0(r3)
	flw	f1, 16(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 3
	jr	r31				#
beq_then.18246:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3034:
	lw	r5, 1(r29)
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.18247
	addi	r6, r0, 1
	j	feq_cont.18248
feq_else.18247:
	addi	r6, r0, 0
feq_cont.18248:
	beqi	0, r6, beq_then.18249
	addi	r1, r0, 0
	jr	r31				#
beq_then.18249:
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
	beqi	3, r2, beq_then.18250
	j	beq_cont.18251
beq_then.18250:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.18251:
	flw	f2, 4(r3)
	fmul	f3, f2, f2
	flw	f4, 2(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18252
	addi	r2, r0, 0
	j	fle_cont.18253
fle_else.18252:
	addi	r2, r0, 1
fle_cont.18253:
	beqi	0, r2, beq_then.18254
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18255
	fsqrt	f1, f1
	fadd	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	j	beq_cont.18256
beq_then.18255:
	fsqrt	f1, f1
	fsub	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
beq_cont.18256:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18254:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3051:
	lw	r6, 1(r29)
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.18257
	addi	r7, r0, 1
	j	feq_cont.18258
feq_else.18257:
	addi	r7, r0, 0
feq_cont.18258:
	beqi	0, r7, beq_then.18259
	addi	r1, r0, 0
	jr	r31				#
beq_then.18259:
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
	beq	r0, r30, fle_else.18260
	addi	r5, r0, 0
	j	fle_cont.18261
fle_else.18260:
	addi	r5, r0, 1
fle_cont.18261:
	beqi	0, r5, beq_then.18262
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18263
	fsqrt	f2, f2
	fadd	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r6)
	j	beq_cont.18264
beq_then.18263:
	fsqrt	f2, f2
	fsub	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r6)
beq_cont.18264:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18262:
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
	beqi	1, r10, beq_then.18265
	beqi	2, r10, beq_then.18266
	add	r2, r0, r1				# mr	r2, r1
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r9				# mr	r5, r9
	add	r1, r0, r8				# mr	r1, r8
	lw	r28, 0(r29)
	jr	r28
beq_then.18266:
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18267
	addi	r2, r0, 0
	j	fle_cont.18268
fle_else.18267:
	addi	r2, r0, 1
fle_cont.18268:
	beqi	0, r2, beq_then.18269
	flw	f1, 0(r1)
	flw	f2, 3(r9)
	fmul	f1, f1, f2
	fsw	f1, 0(r7)
	addi	r1, r0, 1
	jr	r31				#
beq_then.18269:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18265:
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
	beq	r0, r30, feq_else.18270
	addi	r5, r0, 1
	j	feq_cont.18271
feq_else.18270:
	addi	r5, r0, 0
feq_cont.18271:
	beqi	0, r5, beq_then.18272
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 1(r1)
	j	beq_cont.18273
beq_then.18272:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18274
	addi	r7, r0, 0
	j	fle_cont.18275
fle_else.18274:
	addi	r7, r0, 1
fle_cont.18275:
	beqi	0, r6, beq_then.18276
	beqi	0, r7, beq_then.18278
	addi	r6, r0, 0
	j	beq_cont.18279
beq_then.18278:
	addi	r6, r0, 1
beq_cont.18279:
	j	beq_cont.18277
beq_then.18276:
	add	r6, r0, r7
beq_cont.18277:
	lw	r7, 4(r5)
	flw	f1, 0(r7)
	beqi	0, r6, beq_then.18280
	j	beq_cont.18281
beq_then.18280:
	fneg	f1, f1
beq_cont.18281:
	fsw	f1, 0(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r2)
	fdiv	f1, f1, f2
	fsw	f1, 1(r1)
beq_cont.18273:
	flw	f1, 1(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18282
	addi	r5, r0, 1
	j	feq_cont.18283
feq_else.18282:
	addi	r5, r0, 0
feq_cont.18283:
	beqi	0, r5, beq_then.18284
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 3(r1)
	j	beq_cont.18285
beq_then.18284:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 1(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18286
	addi	r7, r0, 0
	j	fle_cont.18287
fle_else.18286:
	addi	r7, r0, 1
fle_cont.18287:
	beqi	0, r6, beq_then.18288
	beqi	0, r7, beq_then.18290
	addi	r6, r0, 0
	j	beq_cont.18291
beq_then.18290:
	addi	r6, r0, 1
beq_cont.18291:
	j	beq_cont.18289
beq_then.18288:
	add	r6, r0, r7
beq_cont.18289:
	lw	r7, 4(r5)
	flw	f1, 1(r7)
	beqi	0, r6, beq_then.18292
	j	beq_cont.18293
beq_then.18292:
	fneg	f1, f1
beq_cont.18293:
	fsw	f1, 2(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 1(r2)
	fdiv	f1, f1, f2
	fsw	f1, 3(r1)
beq_cont.18285:
	flw	f1, 2(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18294
	addi	r5, r0, 1
	j	feq_cont.18295
feq_else.18294:
	addi	r5, r0, 0
feq_cont.18295:
	beqi	0, r5, beq_then.18296
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 5(r1)
	j	beq_cont.18297
beq_then.18296:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 2(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18298
	addi	r7, r0, 0
	j	fle_cont.18299
fle_else.18298:
	addi	r7, r0, 1
fle_cont.18299:
	beqi	0, r6, beq_then.18300
	beqi	0, r7, beq_then.18302
	addi	r6, r0, 0
	j	beq_cont.18303
beq_then.18302:
	addi	r6, r0, 1
beq_cont.18303:
	j	beq_cont.18301
beq_then.18300:
	add	r6, r0, r7
beq_cont.18301:
	lw	r5, 4(r5)
	flw	f1, 2(r5)
	beqi	0, r6, beq_then.18304
	j	beq_cont.18305
beq_then.18304:
	fneg	f1, f1
beq_cont.18305:
	fsw	f1, 4(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 2(r2)
	fdiv	f1, f1, f2
	fsw	f1, 5(r1)
beq_cont.18297:
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
	beq	r0, r30, fle_else.18306
	addi	r2, r0, 0
	j	fle_cont.18307
fle_else.18306:
	addi	r2, r0, 1
fle_cont.18307:
	beqi	0, r2, beq_then.18308
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
	j	beq_cont.18309
beq_then.18308:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
beq_cont.18309:
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
	beqi	0, r6, beq_then.18310
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
	j	beq_cont.18311
beq_then.18310:
	fsw	f2, 1(r5)
	fsw	f3, 2(r5)
	fsw	f4, 3(r5)
beq_cont.18311:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18312
	addi	r1, r0, 1
	j	feq_cont.18313
feq_else.18312:
	addi	r1, r0, 0
feq_cont.18313:
	beqi	0, r1, beq_then.18314
	j	beq_cont.18315
beq_then.18314:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
	fsw	f1, 4(r5)
beq_cont.18315:
	add	r1, r0, r5
	jr	r31				#
iter_setup_dirvec_constants.3070:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.18316
	jr	r31				#
ble_then.18316:
	add	r30, r5, r2
	lw	r6, 0(r30)
	lw	r7, 1(r1)
	lw	r8, 0(r1)
	lw	r9, 1(r6)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	beqi	1, r9, beq_then.18318
	beqi	2, r9, beq_then.18320
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
	j	beq_cont.18321
beq_then.18320:
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
beq_cont.18321:
	j	beq_cont.18319
beq_then.18318:
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
beq_cont.18319:
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18322
	jr	r31				#
ble_then.18322:
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 1(r3)
	lw	r6, 1(r5)
	lw	r7, 0(r5)
	lw	r8, 1(r2)
	beqi	1, r8, beq_then.18324
	beqi	2, r8, beq_then.18326
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
	j	beq_cont.18327
beq_then.18326:
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
beq_cont.18327:
	j	beq_cont.18325
beq_then.18324:
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
beq_cont.18325:
	addi	r2, r2, -1
	lw	r1, 1(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
setup_startp_constants.3075:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.18328
	jr	r31				#
ble_then.18328:
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
	beqi	2, r7, beq_then.18330
	blei	2, r7, ble_then.18332
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
	beqi	3, r1, beq_then.18334
	j	beq_cont.18335
beq_then.18334:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.18335:
	lw	r1, 3(r3)
	fsw	f1, 3(r1)
	j	ble_cont.18333
ble_then.18332:
ble_cont.18333:
	j	beq_cont.18331
beq_then.18330:
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
beq_cont.18331:
	lw	r1, 2(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
is_rect_outside.3080:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18336
	j	fle_cont.18337
fle_else.18336:
	fneg	f1, f1
fle_cont.18337:
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
	beqi	0, r1, beq_then.18339
	flw	f1, 4(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18341
	j	fle_cont.18342
fle_else.18341:
	fneg	f1, f1
fle_cont.18342:
	lw	r1, 2(r3)
	lw	r2, 4(r1)
	flw	f2, 1(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.18343
	flw	f1, 0(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18345
	j	fle_cont.18346
fle_else.18345:
	fneg	f1, f1
fle_cont.18346:
	lw	r1, 2(r3)
	lw	r2, 4(r1)
	flw	f2, 2(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.18344
beq_then.18343:
	addi	r1, r0, 0
beq_cont.18344:
	j	beq_cont.18340
beq_then.18339:
	addi	r1, r0, 0
beq_cont.18340:
	beqi	0, r1, beq_then.18347
	lw	r1, 2(r3)
	lw	r1, 6(r1)
	jr	r31				#
beq_then.18347:
	lw	r1, 2(r3)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18348
	addi	r1, r0, 0
	jr	r31				#
beq_then.18348:
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
	beqi	1, r2, beq_then.18349
	beqi	2, r2, beq_then.18350
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.2998				#	bl	quadratic.2998
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.18351
	j	beq_cont.18352
beq_then.18351:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.18352:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18353
	addi	r2, r0, 0
	j	fle_cont.18354
fle_else.18353:
	addi	r2, r0, 1
fle_cont.18354:
	beqi	0, r1, beq_then.18355
	beqi	0, r2, beq_then.18357
	addi	r1, r0, 0
	j	beq_cont.18358
beq_then.18357:
	addi	r1, r0, 1
beq_cont.18358:
	j	beq_cont.18356
beq_then.18355:
	add	r1, r0, r2
beq_cont.18356:
	beqi	0, r1, beq_then.18359
	addi	r1, r0, 0
	jr	r31				#
beq_then.18359:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18350:
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
	beq	r0, r30, fle_else.18360
	addi	r2, r0, 0
	j	fle_cont.18361
fle_else.18360:
	addi	r2, r0, 1
fle_cont.18361:
	beqi	0, r1, beq_then.18362
	beqi	0, r2, beq_then.18364
	addi	r1, r0, 0
	j	beq_cont.18365
beq_then.18364:
	addi	r1, r0, 1
beq_cont.18365:
	j	beq_cont.18363
beq_then.18362:
	add	r1, r0, r2
beq_cont.18363:
	beqi	0, r1, beq_then.18366
	addi	r1, r0, 0
	jr	r31				#
beq_then.18366:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18349:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18367
	j	fle_cont.18368
fle_else.18367:
	fneg	f1, f1
fle_cont.18368:
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
	beqi	0, r1, beq_then.18370
	flw	f1, 4(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18372
	j	fle_cont.18373
fle_else.18372:
	fneg	f1, f1
fle_cont.18373:
	lw	r1, 0(r3)
	lw	r2, 4(r1)
	flw	f2, 1(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.18374
	flw	f1, 2(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18376
	j	fle_cont.18377
fle_else.18376:
	fneg	f1, f1
fle_cont.18377:
	lw	r1, 0(r3)
	lw	r2, 4(r1)
	flw	f2, 2(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.18375
beq_then.18374:
	addi	r1, r0, 0
beq_cont.18375:
	j	beq_cont.18371
beq_then.18370:
	addi	r1, r0, 0
beq_cont.18371:
	beqi	0, r1, beq_then.18378
	lw	r1, 0(r3)
	lw	r1, 6(r1)
	jr	r31				#
beq_then.18378:
	lw	r1, 0(r3)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18379
	addi	r1, r0, 0
	jr	r31				#
beq_then.18379:
	addi	r1, r0, 1
	jr	r31				#
check_all_inside.3100:
	lw	r5, 1(r29)
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.18380
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
	beqi	1, r7, beq_then.18382
	beqi	2, r7, beq_then.18384
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
	beqi	3, r2, beq_then.18386
	j	beq_cont.18387
beq_then.18386:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.18387:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18388
	addi	r2, r0, 0
	j	fle_cont.18389
fle_else.18388:
	addi	r2, r0, 1
fle_cont.18389:
	beqi	0, r1, beq_then.18390
	beqi	0, r2, beq_then.18392
	addi	r1, r0, 0
	j	beq_cont.18393
beq_then.18392:
	addi	r1, r0, 1
beq_cont.18393:
	j	beq_cont.18391
beq_then.18390:
	add	r1, r0, r2
beq_cont.18391:
	beqi	0, r1, beq_then.18394
	addi	r1, r0, 0
	j	beq_cont.18395
beq_then.18394:
	addi	r1, r0, 1
beq_cont.18395:
	j	beq_cont.18385
beq_then.18384:
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
	beq	r0, r30, fle_else.18396
	addi	r7, r0, 0
	j	fle_cont.18397
fle_else.18396:
	addi	r7, r0, 1
fle_cont.18397:
	beqi	0, r6, beq_then.18398
	beqi	0, r7, beq_then.18400
	addi	r6, r0, 0
	j	beq_cont.18401
beq_then.18400:
	addi	r6, r0, 1
beq_cont.18401:
	j	beq_cont.18399
beq_then.18398:
	add	r6, r0, r7
beq_cont.18399:
	beqi	0, r6, beq_then.18402
	addi	r1, r0, 0
	j	beq_cont.18403
beq_then.18402:
	addi	r1, r0, 1
beq_cont.18403:
beq_cont.18385:
	j	beq_cont.18383
beq_then.18382:
	add	r1, r0, r6				# mr	r1, r6
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	is_rect_outside.3080				#	bl	is_rect_outside.3080
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.18383:
	beqi	0, r1, beq_then.18404
	addi	r1, r0, 0
	jr	r31				#
beq_then.18404:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18405
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
	beqi	0, r1, beq_then.18406
	addi	r1, r0, 0
	jr	r31				#
beq_then.18406:
	lw	r1, 12(r3)
	addi	r1, r1, 1
	flw	f1, 6(r3)
	flw	f2, 4(r3)
	flw	f3, 2(r3)
	lw	r2, 9(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18405:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18380:
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
	beqi	-1, r14, beq_then.18407
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
	beqi	1, r16, beq_then.18408
	beqi	2, r16, beq_then.18410
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r6				# mr	r29, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.18411
beq_then.18410:
	flw	f4, 0(r12)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.18412
	addi	r5, r0, 0
	j	fle_cont.18413
fle_else.18412:
	addi	r5, r0, 1
fle_cont.18413:
	beqi	0, r5, beq_then.18414
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
	j	beq_cont.18415
beq_then.18414:
	addi	r1, r0, 0
beq_cont.18415:
beq_cont.18411:
	j	beq_cont.18409
beq_then.18408:
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
beq_cont.18409:
	lw	r2, 8(r3)
	flw	f1, 0(r2)
	fsw	f1, 10(r3)
	beqi	0, r1, beq_then.18417
	flup	f2, 28		# fli	f2, -0.200000
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.18418
beq_then.18417:
	addi	r1, r0, 0
beq_cont.18418:
	beqi	0, r1, beq_then.18419
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
	beqi	-1, r1, beq_then.18420
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
	beqi	0, r1, beq_then.18422
	addi	r1, r0, 0
	j	beq_cont.18423
beq_then.18422:
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
beq_cont.18423:
	j	beq_cont.18421
beq_then.18420:
	addi	r1, r0, 1
beq_cont.18421:
	beqi	0, r1, beq_then.18424
	addi	r1, r0, 1
	jr	r31				#
beq_then.18424:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18419:
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18425
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18425:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18407:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3109:
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.18426
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
	beqi	0, r1, beq_then.18427
	addi	r1, r0, 1
	jr	r31				#
beq_then.18427:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18428
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
	beqi	0, r1, beq_then.18429
	addi	r1, r0, 1
	jr	r31				#
beq_then.18429:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18430
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
	beqi	0, r1, beq_then.18431
	addi	r1, r0, 1
	jr	r31				#
beq_then.18431:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18432
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
	beqi	0, r1, beq_then.18433
	addi	r1, r0, 1
	jr	r31				#
beq_then.18433:
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18432:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18430:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18428:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18426:
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
	beqi	-1, r16, beq_then.18434
	addi	r17, r0, 99
	sw	r9, 0(r3)
	sw	r10, 1(r3)
	sw	r14, 2(r3)
	sw	r15, 3(r3)
	sw	r2, 4(r3)
	sw	r29, 5(r3)
	sw	r1, 6(r3)
	beq	r16, r17, beq_then.18435
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
	beqi	1, r13, beq_then.18437
	beqi	2, r13, beq_then.18439
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r11				# mr	r1, r11
	add	r29, r0, r6				# mr	r29, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.18440
beq_then.18439:
	flw	f4, 0(r12)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.18441
	addi	r5, r0, 0
	j	fle_cont.18442
fle_else.18441:
	addi	r5, r0, 1
fle_cont.18442:
	beqi	0, r5, beq_then.18443
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
	j	beq_cont.18444
beq_then.18443:
	addi	r1, r0, 0
beq_cont.18444:
beq_cont.18440:
	j	beq_cont.18438
beq_then.18437:
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
beq_cont.18438:
	beqi	0, r1, beq_then.18445
	lw	r1, 7(r3)
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.18447
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18449
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
	beqi	0, r1, beq_then.18451
	addi	r1, r0, 1
	j	beq_cont.18452
beq_then.18451:
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18453
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
	beqi	0, r1, beq_then.18455
	addi	r1, r0, 1
	j	beq_cont.18456
beq_then.18455:
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.18457
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
	beqi	0, r1, beq_then.18459
	addi	r1, r0, 1
	j	beq_cont.18460
beq_then.18459:
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18460:
	j	beq_cont.18458
beq_then.18457:
	addi	r1, r0, 0
beq_cont.18458:
beq_cont.18456:
	j	beq_cont.18454
beq_then.18453:
	addi	r1, r0, 0
beq_cont.18454:
beq_cont.18452:
	j	beq_cont.18450
beq_then.18449:
	addi	r1, r0, 0
beq_cont.18450:
	beqi	0, r1, beq_then.18461
	addi	r1, r0, 1
	j	beq_cont.18462
beq_then.18461:
	addi	r1, r0, 0
beq_cont.18462:
	j	beq_cont.18448
beq_then.18447:
	addi	r1, r0, 0
beq_cont.18448:
	j	beq_cont.18446
beq_then.18445:
	addi	r1, r0, 0
beq_cont.18446:
	j	beq_cont.18436
beq_then.18435:
	addi	r1, r0, 1
beq_cont.18436:
	beqi	0, r1, beq_then.18463
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18464
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
	beqi	0, r1, beq_then.18466
	addi	r1, r0, 1
	j	beq_cont.18467
beq_then.18466:
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18468
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
	beqi	0, r1, beq_then.18470
	addi	r1, r0, 1
	j	beq_cont.18471
beq_then.18470:
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.18472
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
	beqi	0, r1, beq_then.18474
	addi	r1, r0, 1
	j	beq_cont.18475
beq_then.18474:
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18475:
	j	beq_cont.18473
beq_then.18472:
	addi	r1, r0, 0
beq_cont.18473:
beq_cont.18471:
	j	beq_cont.18469
beq_then.18468:
	addi	r1, r0, 0
beq_cont.18469:
beq_cont.18467:
	j	beq_cont.18465
beq_then.18464:
	addi	r1, r0, 0
beq_cont.18465:
	beqi	0, r1, beq_then.18476
	addi	r1, r0, 1
	jr	r31				#
beq_then.18476:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r29, 5(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18463:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r29, 5(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18434:
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
	beqi	-1, r17, beq_then.18477
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
	beqi	1, r19, beq_then.18478
	beqi	2, r19, beq_then.18480
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r18				# mr	r1, r18
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.18481
beq_then.18480:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r18				# mr	r1, r18
	add	r29, r0, r8				# mr	r29, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.18481:
	j	beq_cont.18479
beq_then.18478:
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
	beqi	0, r1, beq_then.18483
	addi	r1, r0, 1
	j	beq_cont.18484
beq_then.18483:
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
	beqi	0, r1, beq_then.18485
	addi	r1, r0, 2
	j	beq_cont.18486
beq_then.18485:
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
	beqi	0, r1, beq_then.18487
	addi	r1, r0, 3
	j	beq_cont.18488
beq_then.18487:
	addi	r1, r0, 0
beq_cont.18488:
beq_cont.18486:
beq_cont.18484:
beq_cont.18479:
	beqi	0, r1, beq_then.18489
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
	beqi	0, r1, beq_then.18491
	lw	r1, 5(r3)
	flw	f2, 0(r1)
	flw	f1, 24(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -27
	lw	r31, 26(r3)
	beqi	0, r1, beq_then.18493
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
	beqi	-1, r1, beq_then.18495
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
	beqi	0, r1, beq_then.18497
	addi	r1, r0, 0
	j	beq_cont.18498
beq_then.18497:
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
beq_cont.18498:
	j	beq_cont.18496
beq_then.18495:
	addi	r1, r0, 1
beq_cont.18496:
	beqi	0, r1, beq_then.18499
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
	j	beq_cont.18500
beq_then.18499:
beq_cont.18500:
	j	beq_cont.18494
beq_then.18493:
beq_cont.18494:
	j	beq_cont.18492
beq_then.18491:
beq_cont.18492:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r29, 9(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18489:
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18501
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r29, 9(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18501:
	jr	r31				#
beq_then.18477:
	jr	r31				#
solve_one_or_network.3119:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.18504
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
	beqi	-1, r5, beq_then.18505
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
	beqi	-1, r5, beq_then.18506
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
	beqi	-1, r5, beq_then.18507
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
beq_then.18507:
	jr	r31				#
beq_then.18506:
	jr	r31				#
beq_then.18505:
	jr	r31				#
beq_then.18504:
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
	beqi	-1, r18, beq_then.18512
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
	beq	r18, r19, beq_then.18513
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
	beqi	1, r18, beq_then.18515
	beqi	2, r18, beq_then.18517
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.18518
beq_then.18517:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r8				# mr	r29, r8
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.18518:
	j	beq_cont.18516
beq_then.18515:
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
	beqi	0, r1, beq_then.18519
	addi	r1, r0, 1
	j	beq_cont.18520
beq_then.18519:
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
	beqi	0, r1, beq_then.18521
	addi	r1, r0, 2
	j	beq_cont.18522
beq_then.18521:
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
	beqi	0, r1, beq_then.18523
	addi	r1, r0, 3
	j	beq_cont.18524
beq_then.18523:
	addi	r1, r0, 0
beq_cont.18524:
beq_cont.18522:
beq_cont.18520:
beq_cont.18516:
	beqi	0, r1, beq_then.18525
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r2, 1(r3)
	flw	f2, 0(r2)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.18527
	lw	r1, 11(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18529
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
	beqi	-1, r2, beq_then.18531
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
	beqi	-1, r2, beq_then.18533
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
	j	beq_cont.18534
beq_then.18533:
beq_cont.18534:
	j	beq_cont.18532
beq_then.18531:
beq_cont.18532:
	j	beq_cont.18530
beq_then.18529:
beq_cont.18530:
	j	beq_cont.18528
beq_then.18527:
beq_cont.18528:
	j	beq_cont.18526
beq_then.18525:
beq_cont.18526:
	j	beq_cont.18514
beq_then.18513:
	lw	r8, 1(r17)
	beqi	-1, r8, beq_then.18535
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
	beqi	-1, r2, beq_then.18537
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
	beqi	-1, r2, beq_then.18539
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
	j	beq_cont.18540
beq_then.18539:
beq_cont.18540:
	j	beq_cont.18538
beq_then.18537:
beq_cont.18538:
	j	beq_cont.18536
beq_then.18535:
beq_cont.18536:
beq_cont.18514:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.18541
	addi	r7, r0, 99
	sw	r1, 20(r3)
	beq	r6, r7, beq_then.18542
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
	beqi	0, r1, beq_then.18544
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -23
	lw	r31, 22(r3)
	beqi	0, r1, beq_then.18546
	lw	r1, 21(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18548
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
	beqi	-1, r2, beq_then.18550
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
	j	beq_cont.18551
beq_then.18550:
beq_cont.18551:
	j	beq_cont.18549
beq_then.18548:
beq_cont.18549:
	j	beq_cont.18547
beq_then.18546:
beq_cont.18547:
	j	beq_cont.18545
beq_then.18544:
beq_cont.18545:
	j	beq_cont.18543
beq_then.18542:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.18552
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
	beqi	-1, r2, beq_then.18554
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
	j	beq_cont.18555
beq_then.18554:
beq_cont.18555:
	j	beq_cont.18553
beq_then.18552:
beq_cont.18553:
beq_cont.18543:
	lw	r1, 20(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 6(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18541:
	jr	r31				#
beq_then.18512:
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
	beqi	-1, r17, beq_then.18558
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
	beqi	1, r21, beq_then.18559
	beqi	2, r21, beq_then.18561
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
	j	beq_cont.18562
beq_then.18561:
	flw	f1, 0(r20)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18563
	addi	r8, r0, 0
	j	fle_cont.18564
fle_else.18563:
	addi	r8, r0, 1
fle_cont.18564:
	beqi	0, r8, beq_then.18565
	flw	f1, 0(r20)
	flw	f2, 3(r19)
	fmul	f1, f1, f2
	fsw	f1, 0(r10)
	addi	r1, r0, 1
	j	beq_cont.18566
beq_then.18565:
	addi	r1, r0, 0
beq_cont.18566:
beq_cont.18562:
	j	beq_cont.18560
beq_then.18559:
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
beq_cont.18560:
	beqi	0, r1, beq_then.18567
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
	beqi	0, r1, beq_then.18569
	lw	r1, 6(r3)
	flw	f2, 0(r1)
	flw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.18571
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
	beqi	-1, r1, beq_then.18573
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
	beqi	0, r1, beq_then.18575
	addi	r1, r0, 0
	j	beq_cont.18576
beq_then.18575:
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
beq_cont.18576:
	j	beq_cont.18574
beq_then.18573:
	addi	r1, r0, 1
beq_cont.18574:
	beqi	0, r1, beq_then.18577
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
	j	beq_cont.18578
beq_then.18577:
beq_cont.18578:
	j	beq_cont.18572
beq_then.18571:
beq_cont.18572:
	j	beq_cont.18570
beq_then.18569:
beq_cont.18570:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r29, 10(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18567:
	lw	r1, 12(r3)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18579
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r29, 10(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18579:
	jr	r31				#
beq_then.18558:
	jr	r31				#
solve_one_or_network_fast.3133:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.18582
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
	beqi	-1, r5, beq_then.18583
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
	beqi	-1, r5, beq_then.18584
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
	beqi	-1, r5, beq_then.18585
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
beq_then.18585:
	jr	r31				#
beq_then.18584:
	jr	r31				#
beq_then.18583:
	jr	r31				#
beq_then.18582:
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
	beqi	-1, r16, beq_then.18590
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
	beq	r16, r17, beq_then.18591
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
	beqi	1, r18, beq_then.18593
	beqi	2, r18, beq_then.18595
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
	j	beq_cont.18596
beq_then.18595:
	flw	f1, 0(r16)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18597
	addi	r7, r0, 0
	j	fle_cont.18598
fle_else.18597:
	addi	r7, r0, 1
fle_cont.18598:
	beqi	0, r7, beq_then.18599
	flw	f1, 0(r16)
	flw	f2, 3(r17)
	fmul	f1, f1, f2
	fsw	f1, 0(r10)
	addi	r1, r0, 1
	j	beq_cont.18600
beq_then.18599:
	addi	r1, r0, 0
beq_cont.18600:
beq_cont.18596:
	j	beq_cont.18594
beq_then.18593:
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
beq_cont.18594:
	beqi	0, r1, beq_then.18601
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r2, 1(r3)
	flw	f2, 0(r2)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.18603
	lw	r1, 10(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18605
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
	beqi	-1, r2, beq_then.18607
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
	beqi	-1, r2, beq_then.18609
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
	j	beq_cont.18610
beq_then.18609:
beq_cont.18610:
	j	beq_cont.18608
beq_then.18607:
beq_cont.18608:
	j	beq_cont.18606
beq_then.18605:
beq_cont.18606:
	j	beq_cont.18604
beq_then.18603:
beq_cont.18604:
	j	beq_cont.18602
beq_then.18601:
beq_cont.18602:
	j	beq_cont.18592
beq_then.18591:
	lw	r7, 1(r15)
	beqi	-1, r7, beq_then.18611
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
	beqi	-1, r2, beq_then.18613
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
	beqi	-1, r2, beq_then.18615
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
	j	beq_cont.18616
beq_then.18615:
beq_cont.18616:
	j	beq_cont.18614
beq_then.18613:
beq_cont.18614:
	j	beq_cont.18612
beq_then.18611:
beq_cont.18612:
beq_cont.18592:
	lw	r1, 9(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.18617
	addi	r7, r0, 99
	sw	r1, 11(r3)
	beq	r6, r7, beq_then.18618
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
	beqi	0, r1, beq_then.18620
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.18622
	lw	r1, 12(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18624
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
	beqi	-1, r2, beq_then.18626
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
	j	beq_cont.18627
beq_then.18626:
beq_cont.18627:
	j	beq_cont.18625
beq_then.18624:
beq_cont.18625:
	j	beq_cont.18623
beq_then.18622:
beq_cont.18623:
	j	beq_cont.18621
beq_then.18620:
beq_cont.18621:
	j	beq_cont.18619
beq_then.18618:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.18628
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
	beqi	-1, r2, beq_then.18630
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
	j	beq_cont.18631
beq_then.18630:
beq_cont.18631:
	j	beq_cont.18629
beq_then.18628:
beq_cont.18629:
beq_cont.18619:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 5(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18617:
	jr	r31				#
beq_then.18590:
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
	beqi	-1, r13, beq_then.18634
	addi	r14, r0, 99
	sw	r1, 1(r3)
	sw	r10, 2(r3)
	sw	r2, 3(r3)
	beq	r13, r14, beq_then.18636
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
	beqi	0, r1, beq_then.18638
	lw	r1, 8(r3)
	flw	f1, 0(r1)
	lw	r1, 0(r3)
	flw	f2, 0(r1)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -10
	lw	r31, 9(r3)
	beqi	0, r1, beq_then.18640
	lw	r1, 7(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18642
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
	beqi	-1, r2, beq_then.18644
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
	j	beq_cont.18645
beq_then.18644:
beq_cont.18645:
	j	beq_cont.18643
beq_then.18642:
beq_cont.18643:
	j	beq_cont.18641
beq_then.18640:
beq_cont.18641:
	j	beq_cont.18639
beq_then.18638:
beq_cont.18639:
	j	beq_cont.18637
beq_then.18636:
	lw	r6, 1(r12)
	beqi	-1, r6, beq_then.18646
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
	beqi	-1, r2, beq_then.18648
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
	j	beq_cont.18649
beq_then.18648:
beq_cont.18649:
	j	beq_cont.18647
beq_then.18646:
beq_cont.18647:
beq_cont.18637:
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
	j	beq_cont.18635
beq_then.18634:
beq_cont.18635:
	lw	r1, 0(r3)
	flw	f2, 0(r1)
	flup	f1, 30		# fli	f1, -0.100000
	fsw	f2, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -13
	lw	r31, 12(r3)
	beqi	0, r1, beq_then.18651
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 10(r3)
	j	lib_fless
beq_then.18651:
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
	beqi	0, r5, beq_then.18652
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
	j	beq_cont.18653
beq_then.18652:
	fsw	f4, 0(r2)
	fsw	f5, 1(r2)
	fsw	f6, 2(r2)
beq_cont.18653:
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
	beqi	1, r7, beq_then.18654
	beqi	2, r7, beq_then.18655
	lw	r28, 0(r29)
	jr	r28
beq_then.18655:
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
beq_then.18654:
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
	beq	r0, r30, feq_else.18657
	addi	r1, r0, 1
	j	feq_cont.18658
feq_else.18657:
	addi	r1, r0, 0
feq_cont.18658:
	beqi	0, r1, beq_then.18659
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18660
beq_then.18659:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18661
	addi	r1, r0, 0
	j	fle_cont.18662
fle_else.18661:
	addi	r1, r0, 1
fle_cont.18662:
	beqi	0, r1, beq_then.18663
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.18664
beq_then.18663:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.18664:
beq_cont.18660:
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
	beqi	1, r6, beq_then.18666
	beqi	2, r6, beq_then.18667
	beqi	3, r6, beq_then.18668
	beqi	4, r6, beq_then.18669
	jr	r31				#
beq_then.18669:
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
	beq	r0, r30, fle_else.18671
	fadd	f4, f0, f1
	j	fle_cont.18672
fle_else.18671:
	fneg	f4, f1
fle_cont.18672:
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
	beqi	0, r1, beq_then.18674
	flup	f1, 34		# fli	f1, 15.000000
	j	beq_cont.18675
beq_then.18674:
	flw	f1, 6(r3)
	flw	f2, 8(r3)
	fdiv	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18676
	j	fle_cont.18677
fle_else.18676:
	fneg	f1, f1
fle_cont.18677:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18678
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.18679
fle_else.18678:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.18679:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.18680
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.18682
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
	j	fle_cont.18683
fle_else.18682:
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
fle_cont.18683:
	j	fle_cont.18681
fle_else.18680:
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -17
	lw	r31, 16(r3)
fle_cont.18681:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
beq_cont.18675:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18684
	addi	r1, r0, 0
	j	feq_cont.18685
feq_else.18684:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18686
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.18687
fle_else.18686:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.18687:
feq_cont.18685:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18688
	j	fle_cont.18689
fle_else.18688:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.18689:
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
	beq	r0, r30, fle_else.18690
	fadd	f4, f0, f3
	j	fle_cont.18691
fle_else.18690:
	fneg	f4, f3
fle_cont.18691:
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
	beqi	0, r1, beq_then.18692
	flup	f1, 34		# fli	f1, 15.000000
	j	beq_cont.18693
beq_then.18692:
	flw	f1, 2(r3)
	flw	f2, 18(r3)
	fdiv	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18694
	j	fle_cont.18695
fle_else.18694:
	fneg	f1, f1
fle_cont.18695:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18696
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.18697
fle_else.18696:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.18697:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.18698
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.18700
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
	j	fle_cont.18701
fle_else.18700:
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
fle_cont.18701:
	j	fle_cont.18699
fle_else.18698:
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -27
	lw	r31, 26(r3)
fle_cont.18699:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
beq_cont.18693:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18702
	addi	r1, r0, 0
	j	feq_cont.18703
feq_else.18702:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18704
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.18705
fle_else.18704:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.18705:
feq_cont.18703:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18706
	j	fle_cont.18707
fle_else.18706:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.18707:
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
	beq	r0, r30, fle_else.18708
	addi	r1, r0, 0
	j	fle_cont.18709
fle_else.18708:
	addi	r1, r0, 1
fle_cont.18709:
	beqi	0, r1, beq_then.18710
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18711
beq_then.18710:
beq_cont.18711:
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f2, f1
	flup	f2, 38		# fli	f2, 0.300000
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.18668:
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
	beq	r0, r30, feq_else.18713
	addi	r1, r0, 0
	j	feq_cont.18714
feq_else.18713:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18715
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.18716
fle_else.18715:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.18716:
feq_cont.18714:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18717
	j	fle_cont.18718
fle_else.18717:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.18718:
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
beq_then.18667:
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
beq_then.18666:
	flw	f1, 0(r2)
	lw	r6, 5(r1)
	flw	f2, 0(r6)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	feq	r30, f2, f0
	beq	r0, r30, feq_else.18721
	addi	r6, r0, 0
	j	feq_cont.18722
feq_else.18721:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18723
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r6, f3
	j	fle_cont.18724
fle_else.18723:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r6, f3
fle_cont.18724:
feq_cont.18722:
	itof	f3, r6
	fle	r30, f3, f2
	beq	r0, r30, fle_else.18725
	fadd	f2, f0, f3
	j	fle_cont.18726
fle_else.18725:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.18726:
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
	beq	r0, r30, feq_else.18727
	addi	r2, r0, 0
	j	feq_cont.18728
feq_else.18727:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18729
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r2, f3
	j	fle_cont.18730
fle_else.18729:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r2, f3
fle_cont.18730:
feq_cont.18728:
	itof	f3, r2
	fle	r30, f3, f2
	beq	r0, r30, fle_else.18731
	fadd	f2, f0, f3
	j	fle_cont.18732
fle_else.18731:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.18732:
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
	beqi	0, r2, beq_then.18733
	beqi	0, r1, beq_then.18735
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.18736
beq_then.18735:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.18736:
	j	beq_cont.18734
beq_then.18733:
	beqi	0, r1, beq_then.18737
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18738
beq_then.18737:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.18738:
beq_cont.18734:
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
	ble	r15, r1, ble_then.18740
	jr	r31				#
ble_then.18740:
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
	beqi	0, r1, beq_then.18743
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -21
	lw	r31, 20(r3)
	j	beq_cont.18744
beq_then.18743:
	addi	r1, r0, 0
beq_cont.18744:
	beqi	0, r1, beq_then.18745
	lw	r1, 16(r3)
	lw	r1, 0(r1)
	slli	r1, r1, 2
	lw	r2, 15(r3)
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 14(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.18747
	j	beq_cont.18748
beq_then.18747:
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
	beqi	0, r1, beq_then.18749
	j	beq_cont.18750
beq_then.18749:
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
	beq	r0, r30, fle_else.18751
	addi	r1, r0, 0
	j	fle_cont.18752
fle_else.18751:
	addi	r1, r0, 1
fle_cont.18752:
	beqi	0, r1, beq_then.18753
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
	j	beq_cont.18754
beq_then.18753:
beq_cont.18754:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.18755
	addi	r1, r0, 0
	j	fle_cont.18756
fle_else.18755:
	addi	r1, r0, 1
fle_cont.18756:
	beqi	0, r1, beq_then.18757
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
	j	beq_cont.18758
beq_then.18757:
beq_cont.18758:
beq_cont.18750:
beq_cont.18748:
	j	beq_cont.18746
beq_then.18745:
beq_cont.18746:
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
	blei	4, r1, ble_then.18759
	jr	r31				#
ble_then.18759:
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
	beqi	0, r1, beq_then.18764
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 34(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -37
	lw	r31, 36(r3)
	j	beq_cont.18765
beq_then.18764:
	addi	r1, r0, 0
beq_cont.18765:
	beqi	0, r1, beq_then.18766
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
	beqi	1, r6, beq_then.18768
	beqi	2, r6, beq_then.18770
	lw	r29, 18(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -43
	lw	r31, 42(r3)
	j	beq_cont.18771
beq_then.18770:
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
beq_cont.18771:
	j	beq_cont.18769
beq_then.18768:
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
	beq	r0, r30, feq_else.18772
	addi	r7, r0, 1
	j	feq_cont.18773
feq_else.18772:
	addi	r7, r0, 0
feq_cont.18773:
	beqi	0, r7, beq_then.18774
	flup	f3, 0		# fli	f3, 0.000000
	j	beq_cont.18775
beq_then.18774:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.18776
	addi	r7, r0, 0
	j	fle_cont.18777
fle_else.18776:
	addi	r7, r0, 1
fle_cont.18777:
	beqi	0, r7, beq_then.18778
	flup	f3, 2		# fli	f3, 1.000000
	j	beq_cont.18779
beq_then.18778:
	flup	f3, 11		# fli	f3, -1.000000
beq_cont.18779:
beq_cont.18775:
	fneg	f3, f3
	add	r30, r8, r9
	fsw	f3, 0(r30)
beq_cont.18769:
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
	beqi	0, r1, beq_then.18780
	lw	r1, 30(r3)
	lw	r2, 42(r3)
	lw	r5, 11(r3)
	add	r30, r2, r1
	sw	r5, 0(r30)
	j	beq_cont.18781
beq_then.18780:
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
beq_cont.18781:
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
	beqi	0, r1, beq_then.18783
	j	beq_cont.18784
beq_then.18783:
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
	beq	r0, r30, fle_else.18785
	addi	r2, r0, 0
	j	fle_cont.18786
fle_else.18785:
	addi	r2, r0, 1
fle_cont.18786:
	beqi	0, r2, beq_then.18787
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
	j	beq_cont.18788
beq_then.18787:
beq_cont.18788:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.18789
	addi	r2, r0, 0
	j	fle_cont.18790
fle_else.18789:
	addi	r2, r0, 1
fle_cont.18790:
	beqi	0, r2, beq_then.18791
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
	j	beq_cont.18792
beq_then.18791:
beq_cont.18792:
beq_cont.18784:
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
	beqi	0, r1, beq_then.18793
	addi	r1, r0, 4
	lw	r2, 30(r3)
	ble	r1, r2, ble_then.18794
	addi	r1, r2, 1
	addi	r5, r0, -1
	lw	r6, 31(r3)
	add	r30, r6, r1
	sw	r5, 0(r30)
	j	ble_cont.18795
ble_then.18794:
ble_cont.18795:
	lw	r1, 36(r3)
	beqi	2, r1, beq_then.18796
	j	beq_cont.18797
beq_then.18796:
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
beq_cont.18797:
	jr	r31				#
beq_then.18793:
	jr	r31				#
beq_then.18766:
	addi	r1, r0, -1
	lw	r2, 30(r3)
	lw	r5, 31(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	0, r2, beq_then.18800
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
	beq	r0, r30, fle_else.18801
	addi	r1, r0, 0
	j	fle_cont.18802
fle_else.18801:
	addi	r1, r0, 1
fle_cont.18802:
	beqi	0, r1, beq_then.18803
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
beq_then.18803:
	jr	r31				#
beq_then.18800:
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
	beqi	0, r1, beq_then.18807
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	j	beq_cont.18808
beq_then.18807:
	addi	r1, r0, 0
beq_cont.18808:
	beqi	0, r1, beq_then.18809
	lw	r1, 14(r3)
	lw	r1, 0(r1)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 12(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	sw	r1, 18(r3)
	beqi	1, r5, beq_then.18810
	beqi	2, r5, beq_then.18812
	lw	r29, 9(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
	j	beq_cont.18813
beq_then.18812:
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
beq_cont.18813:
	j	beq_cont.18811
beq_then.18810:
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
	beq	r0, r30, feq_else.18814
	addi	r2, r0, 1
	j	feq_cont.18815
feq_else.18814:
	addi	r2, r0, 0
feq_cont.18815:
	beqi	0, r2, beq_then.18816
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18817
beq_then.18816:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18818
	addi	r2, r0, 0
	j	fle_cont.18819
fle_else.18818:
	addi	r2, r0, 1
fle_cont.18819:
	beqi	0, r2, beq_then.18820
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.18821
beq_then.18820:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.18821:
beq_cont.18817:
	fneg	f1, f1
	add	r30, r6, r7
	fsw	f1, 0(r30)
beq_cont.18811:
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
	beqi	0, r1, beq_then.18822
	jr	r31				#
beq_then.18822:
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
	beq	r0, r30, fle_else.18824
	addi	r1, r0, 0
	j	fle_cont.18825
fle_else.18824:
	addi	r1, r0, 1
fle_cont.18825:
	beqi	0, r1, beq_then.18826
	j	beq_cont.18827
beq_then.18826:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.18827:
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
beq_then.18809:
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
	ble	r20, r6, ble_then.18830
	jr	r31				#
ble_then.18830:
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
	beq	r0, r30, fle_else.18832
	addi	r20, r0, 0
	j	fle_cont.18833
fle_else.18832:
	addi	r20, r0, 1
fle_cont.18833:
	sw	r5, 0(r3)
	sw	r29, 1(r3)
	sw	r8, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	sw	r6, 5(r3)
	beqi	0, r20, beq_then.18834
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
	beqi	0, r1, beq_then.18836
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
	beqi	0, r1, beq_then.18838
	j	beq_cont.18839
beq_then.18838:
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
	beq	r0, r30, fle_else.18840
	addi	r1, r0, 0
	j	fle_cont.18841
fle_else.18840:
	addi	r1, r0, 1
fle_cont.18841:
	beqi	0, r1, beq_then.18842
	j	beq_cont.18843
beq_then.18842:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.18843:
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
beq_cont.18839:
	j	beq_cont.18837
beq_then.18836:
beq_cont.18837:
	j	beq_cont.18835
beq_then.18834:
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
	beqi	0, r1, beq_then.18845
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
	beqi	0, r1, beq_then.18847
	j	beq_cont.18848
beq_then.18847:
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
	beq	r0, r30, fle_else.18849
	addi	r1, r0, 0
	j	fle_cont.18850
fle_else.18849:
	addi	r1, r0, 1
fle_cont.18850:
	beqi	0, r1, beq_then.18851
	j	beq_cont.18852
beq_then.18851:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.18852:
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
beq_cont.18848:
	j	beq_cont.18846
beq_then.18845:
beq_cont.18846:
beq_cont.18835:
	lw	r1, 5(r3)
	addi	r1, r1, -2
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18853
	jr	r31				#
ble_then.18853:
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
	beq	r0, r30, fle_else.18855
	addi	r5, r0, 0
	j	fle_cont.18856
fle_else.18855:
	addi	r5, r0, 1
fle_cont.18856:
	sw	r1, 26(r3)
	beqi	0, r5, beq_then.18857
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
	j	beq_cont.18858
beq_then.18857:
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
beq_cont.18858:
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
	beqi	0, r1, beq_then.18859
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
	j	beq_cont.18860
beq_then.18859:
beq_cont.18860:
	lw	r1, 7(r3)
	beqi	1, r1, beq_then.18861
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
	j	beq_cont.18862
beq_then.18861:
beq_cont.18862:
	lw	r1, 7(r3)
	beqi	2, r1, beq_then.18863
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
	j	beq_cont.18864
beq_then.18863:
beq_cont.18864:
	lw	r1, 7(r3)
	beqi	3, r1, beq_then.18865
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
	j	beq_cont.18866
beq_then.18865:
beq_cont.18866:
	lw	r1, 7(r3)
	beqi	4, r1, beq_then.18867
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
beq_then.18867:
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
	beqi	0, r1, beq_then.18869
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
	beq	r0, r30, fle_else.18871
	addi	r2, r0, 0
	j	fle_cont.18872
fle_else.18871:
	addi	r2, r0, 1
fle_cont.18872:
	beqi	0, r2, beq_then.18873
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
	j	beq_cont.18874
beq_then.18873:
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
beq_cont.18874:
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
	j	beq_cont.18870
beq_then.18869:
beq_cont.18870:
	lw	r1, 12(r3)
	beqi	1, r1, beq_then.18875
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
	beq	r0, r30, fle_else.18877
	addi	r2, r0, 0
	j	fle_cont.18878
fle_else.18877:
	addi	r2, r0, 1
fle_cont.18878:
	beqi	0, r2, beq_then.18879
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
	j	beq_cont.18880
beq_then.18879:
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
beq_cont.18880:
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
	j	beq_cont.18876
beq_then.18875:
beq_cont.18876:
	lw	r1, 12(r3)
	beqi	2, r1, beq_then.18881
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
	beq	r0, r30, fle_else.18883
	addi	r2, r0, 0
	j	fle_cont.18884
fle_else.18883:
	addi	r2, r0, 1
fle_cont.18884:
	beqi	0, r2, beq_then.18885
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
	j	beq_cont.18886
beq_then.18885:
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
beq_cont.18886:
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
	j	beq_cont.18882
beq_then.18881:
beq_cont.18882:
	lw	r1, 12(r3)
	beqi	3, r1, beq_then.18887
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
	beq	r0, r30, fle_else.18889
	addi	r2, r0, 0
	j	fle_cont.18890
fle_else.18889:
	addi	r2, r0, 1
fle_cont.18890:
	beqi	0, r2, beq_then.18891
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
	j	beq_cont.18892
beq_then.18891:
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
beq_cont.18892:
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
	j	beq_cont.18888
beq_then.18887:
beq_cont.18888:
	lw	r1, 12(r3)
	beqi	4, r1, beq_then.18893
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
	beq	r0, r30, fle_else.18895
	addi	r2, r0, 0
	j	fle_cont.18896
fle_else.18895:
	addi	r2, r0, 1
fle_cont.18896:
	beqi	0, r2, beq_then.18897
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
	j	beq_cont.18898
beq_then.18897:
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
beq_cont.18898:
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
	j	beq_cont.18894
beq_then.18893:
beq_cont.18894:
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
	blei	4, r2, ble_then.18899
	jr	r31				#
ble_then.18899:
	lw	r9, 2(r1)
	addi	r10, r0, 0
	add	r30, r9, r2
	lw	r9, 0(r30)
	ble	r10, r9, ble_then.18901
	jr	r31				#
ble_then.18901:
	lw	r9, 3(r1)
	add	r30, r9, r2
	lw	r9, 0(r30)
	sw	r29, 0(r3)
	sw	r8, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	beqi	0, r9, beq_then.18903
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
	j	beq_cont.18904
beq_then.18903:
beq_cont.18904:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	blei	4, r2, ble_then.18905
	jr	r31				#
ble_then.18905:
	lw	r1, 2(r3)
	lw	r5, 2(r1)
	addi	r6, r0, 0
	add	r30, r5, r2
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.18907
	jr	r31				#
ble_then.18907:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 7(r3)
	beqi	0, r5, beq_then.18909
	lw	r29, 1(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.18910
beq_then.18909:
beq_cont.18910:
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
	blei	4, r8, ble_then.18911
	jr	r31				#
ble_then.18911:
	addi	r13, r0, 0
	lw	r14, 2(r12)
	add	r30, r14, r8
	lw	r14, 0(r30)
	ble	r13, r14, ble_then.18913
	jr	r31				#
ble_then.18913:
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
	beq	r14, r13, beq_then.18915
	addi	r13, r0, 0
	j	beq_cont.18916
beq_then.18915:
	add	r30, r7, r1
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.18917
	addi	r13, r0, 0
	j	beq_cont.18918
beq_then.18917:
	addi	r14, r1, -1
	add	r30, r6, r14
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.18919
	addi	r13, r0, 0
	j	beq_cont.18920
beq_then.18919:
	addi	r14, r1, 1
	add	r30, r6, r14
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.18921
	addi	r13, r0, 0
	j	beq_cont.18922
beq_then.18921:
	addi	r13, r0, 1
beq_cont.18922:
beq_cont.18920:
beq_cont.18918:
beq_cont.18916:
	beqi	0, r13, beq_then.18923
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
	beqi	0, r11, beq_then.18924
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
	j	beq_cont.18925
beq_then.18924:
beq_cont.18925:
	lw	r1, 8(r3)
	addi	r2, r1, 1
	lw	r1, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r1
	lw	r6, 0(r30)
	blei	4, r2, ble_then.18926
	jr	r31				#
ble_then.18926:
	addi	r7, r0, 0
	lw	r8, 2(r6)
	add	r30, r8, r2
	lw	r8, 0(r30)
	ble	r7, r8, ble_then.18928
	jr	r31				#
ble_then.18928:
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
	beq	r9, r7, beq_then.18930
	addi	r7, r0, 0
	j	beq_cont.18931
beq_then.18930:
	lw	r9, 4(r3)
	add	r30, r9, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.18932
	addi	r7, r0, 0
	j	beq_cont.18933
beq_then.18932:
	addi	r10, r1, -1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.18934
	addi	r7, r0, 0
	j	beq_cont.18935
beq_then.18934:
	addi	r10, r1, 1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.18936
	addi	r7, r0, 0
	j	beq_cont.18937
beq_then.18936:
	addi	r7, r0, 1
beq_cont.18937:
beq_cont.18935:
beq_cont.18933:
beq_cont.18931:
	beqi	0, r7, beq_then.18938
	lw	r6, 3(r6)
	add	r30, r6, r2
	lw	r6, 0(r30)
	sw	r2, 9(r3)
	beqi	0, r6, beq_then.18939
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
	j	beq_cont.18940
beq_then.18939:
beq_cont.18940:
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
beq_then.18938:
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r29, 3(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18923:
	add	r30, r6, r1
	lw	r1, 0(r30)
	blei	4, r8, ble_then.18941
	jr	r31				#
ble_then.18941:
	lw	r2, 2(r1)
	addi	r5, r0, 0
	add	r30, r2, r8
	lw	r2, 0(r30)
	ble	r5, r2, ble_then.18943
	jr	r31				#
ble_then.18943:
	lw	r2, 3(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	sw	r1, 10(r3)
	sw	r9, 3(r3)
	sw	r8, 8(r3)
	beqi	0, r2, beq_then.18945
	add	r2, r0, r8				# mr	r2, r8
	add	r29, r0, r11				# mr	r29, r11
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.18946
beq_then.18945:
beq_cont.18946:
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
	beq	r0, r30, feq_else.18947
	addi	r2, r0, 0
	j	feq_cont.18948
feq_else.18947:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18949
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.18950
fle_else.18949:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.18950:
feq_cont.18948:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.18951
	addi	r5, r0, 255
	j	ble_cont.18952
ble_then.18951:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.18953
	addi	r5, r0, 0
	j	ble_cont.18954
ble_then.18953:
	add	r5, r0, r2
ble_cont.18954:
ble_cont.18952:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	ble	r2, r5, ble_then.18955
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.18957
	addi	r2, r5, 48
	out	r2
	j	ble_cont.18958
ble_then.18957:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 1(r3)
	ble	r7, r5, ble_then.18959
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.18960
ble_then.18959:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.18961
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.18962
ble_then.18961:
	add	r1, r0, r6
ble_cont.18962:
ble_cont.18960:
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
ble_cont.18958:
	j	ble_cont.18956
ble_then.18955:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.18963
	addi	r2, r5, 48
	out	r2
	j	ble_cont.18964
ble_then.18963:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 3(r3)
	ble	r7, r5, ble_then.18965
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.18966
ble_then.18965:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.18967
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.18968
ble_then.18967:
	add	r1, r0, r6
ble_cont.18968:
ble_cont.18966:
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
ble_cont.18964:
ble_cont.18956:
	addi	r1, r0, 32
	out	r1
	lw	r1, 0(r3)
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18969
	addi	r2, r0, 0
	j	feq_cont.18970
feq_else.18969:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18971
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.18972
fle_else.18971:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.18972:
feq_cont.18970:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.18973
	addi	r5, r0, 255
	j	ble_cont.18974
ble_then.18973:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.18975
	addi	r5, r0, 0
	j	ble_cont.18976
ble_then.18975:
	add	r5, r0, r2
ble_cont.18976:
ble_cont.18974:
	addi	r2, r0, 0
	ble	r2, r5, ble_then.18977
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.18979
	addi	r2, r5, 48
	out	r2
	j	ble_cont.18980
ble_then.18979:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 5(r3)
	ble	r7, r5, ble_then.18981
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	ble_cont.18982
ble_then.18981:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.18983
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	ble_cont.18984
ble_then.18983:
	add	r1, r0, r6
ble_cont.18984:
ble_cont.18982:
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
ble_cont.18980:
	j	ble_cont.18978
ble_then.18977:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.18985
	addi	r2, r5, 48
	out	r2
	j	ble_cont.18986
ble_then.18985:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 7(r3)
	ble	r7, r5, ble_then.18987
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	ble_cont.18988
ble_then.18987:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.18989
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	ble_cont.18990
ble_then.18989:
	add	r1, r0, r6
ble_cont.18990:
ble_cont.18988:
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
ble_cont.18986:
ble_cont.18978:
	addi	r1, r0, 32
	out	r1
	lw	r1, 0(r3)
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18991
	addi	r1, r0, 0
	j	feq_cont.18992
feq_else.18991:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18993
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.18994
fle_else.18993:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.18994:
feq_cont.18992:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.18995
	addi	r1, r0, 255
	j	ble_cont.18996
ble_then.18995:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18997
	addi	r1, r0, 0
	j	ble_cont.18998
ble_then.18997:
ble_cont.18998:
ble_cont.18996:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18999
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	addi	r2, r0, 10
	ble	r2, r1, ble_then.19001
	addi	r1, r1, 48
	out	r1
	j	ble_cont.19002
ble_then.19001:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	sw	r1, 9(r3)
	ble	r6, r1, ble_then.19003
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	ble_cont.19004
ble_then.19003:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.19005
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	ble_cont.19006
ble_then.19005:
	add	r1, r0, r5
ble_cont.19006:
ble_cont.19004:
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
ble_cont.19002:
	j	ble_cont.19000
ble_then.18999:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.19007
	addi	r1, r1, 48
	out	r1
	j	ble_cont.19008
ble_then.19007:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	sw	r1, 11(r3)
	ble	r6, r1, ble_then.19009
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.19010
ble_then.19009:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.19011
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.19012
ble_then.19011:
	add	r1, r0, r5
ble_cont.19012:
ble_cont.19010:
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
ble_cont.19008:
ble_cont.19000:
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
	blei	4, r2, ble_then.19013
	jr	r31				#
ble_then.19013:
	lw	r12, 2(r1)
	add	r30, r12, r2
	lw	r12, 0(r30)
	addi	r13, r0, 0
	ble	r13, r12, ble_then.19015
	jr	r31				#
ble_then.19015:
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
	beqi	0, r12, beq_then.19017
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
	j	beq_cont.19018
beq_then.19017:
beq_cont.19018:
	lw	r2, 8(r3)
	addi	r2, r2, 1
	blei	4, r2, ble_then.19019
	jr	r31				#
ble_then.19019:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 0
	ble	r6, r5, ble_then.19021
	jr	r31				#
ble_then.19021:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 13(r3)
	beqi	0, r5, beq_then.19023
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
	beq	r0, r30, fle_else.19025
	addi	r2, r0, 0
	j	fle_cont.19026
fle_else.19025:
	addi	r2, r0, 1
fle_cont.19026:
	beqi	0, r2, beq_then.19027
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
	j	beq_cont.19028
beq_then.19027:
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
beq_cont.19028:
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
	j	beq_cont.19024
beq_then.19023:
beq_cont.19024:
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
	ble	r23, r2, ble_then.19029
	jr	r31				#
ble_then.19029:
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
	ble	r8, r7, ble_then.19031
	j	ble_cont.19032
ble_then.19031:
	lw	r7, 3(r5)
	lw	r7, 0(r7)
	sw	r5, 23(r3)
	beqi	0, r7, beq_then.19033
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
	beq	r0, r30, fle_else.19035
	addi	r2, r0, 0
	j	fle_cont.19036
fle_else.19035:
	addi	r2, r0, 1
fle_cont.19036:
	beqi	0, r2, beq_then.19037
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
	j	beq_cont.19038
beq_then.19037:
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
beq_cont.19038:
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
	j	beq_cont.19034
beq_then.19033:
beq_cont.19034:
	addi	r2, r0, 1
	lw	r1, 23(r3)
	lw	r29, 7(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
ble_cont.19032:
	lw	r1, 18(r3)
	addi	r2, r1, -1
	lw	r1, 15(r3)
	addi	r1, r1, 1
	addi	r5, r0, 5
	ble	r5, r1, ble_then.19039
	add	r5, r0, r1
	j	ble_cont.19040
ble_then.19039:
	addi	r5, r1, -5
ble_cont.19040:
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
	ble	r15, r1, ble_then.19041
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
	ble	r15, r16, ble_then.19042
	blei	0, r2, ble_then.19044
	lw	r15, 0(r11)
	addi	r16, r1, 1
	ble	r15, r16, ble_then.19046
	blei	0, r1, ble_then.19048
	addi	r15, r0, 1
	j	ble_cont.19049
ble_then.19048:
	addi	r15, r0, 0
ble_cont.19049:
	j	ble_cont.19047
ble_then.19046:
	addi	r15, r0, 0
ble_cont.19047:
	j	ble_cont.19045
ble_then.19044:
	addi	r15, r0, 0
ble_cont.19045:
	j	ble_cont.19043
ble_then.19042:
	addi	r15, r0, 0
ble_cont.19043:
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
	beqi	0, r15, beq_then.19050
	addi	r14, r0, 0
	add	r30, r6, r1
	lw	r15, 0(r30)
	addi	r16, r0, 0
	lw	r17, 2(r15)
	lw	r17, 0(r17)
	ble	r16, r17, ble_then.19052
	j	ble_cont.19053
ble_then.19052:
	add	r30, r6, r1
	lw	r16, 0(r30)
	lw	r16, 2(r16)
	lw	r16, 0(r16)
	add	r30, r5, r1
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.19054
	addi	r16, r0, 0
	j	beq_cont.19055
beq_then.19054:
	add	r30, r7, r1
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.19056
	addi	r16, r0, 0
	j	beq_cont.19057
beq_then.19056:
	addi	r17, r1, -1
	add	r30, r6, r17
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.19058
	addi	r16, r0, 0
	j	beq_cont.19059
beq_then.19058:
	addi	r17, r1, 1
	add	r30, r6, r17
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.19060
	addi	r16, r0, 0
	j	beq_cont.19061
beq_then.19060:
	addi	r16, r0, 1
beq_cont.19061:
beq_cont.19059:
beq_cont.19057:
beq_cont.19055:
	beqi	0, r16, beq_then.19062
	lw	r15, 3(r15)
	lw	r15, 0(r15)
	beqi	0, r15, beq_then.19064
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
	j	beq_cont.19065
beq_then.19064:
beq_cont.19065:
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
	j	beq_cont.19063
beq_then.19062:
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
beq_cont.19063:
ble_cont.19053:
	j	beq_cont.19051
beq_then.19050:
	add	r30, r6, r1
	lw	r13, 0(r30)
	addi	r15, r0, 0
	lw	r16, 2(r13)
	addi	r17, r0, 0
	lw	r16, 0(r16)
	ble	r17, r16, ble_then.19066
	j	ble_cont.19067
ble_then.19066:
	lw	r16, 3(r13)
	lw	r16, 0(r16)
	sw	r13, 11(r3)
	beqi	0, r16, beq_then.19068
	add	r2, r0, r15				# mr	r2, r15
	add	r1, r0, r13				# mr	r1, r13
	add	r29, r0, r14				# mr	r29, r14
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.19069
beq_then.19068:
beq_cont.19069:
	addi	r2, r0, 1
	lw	r1, 11(r3)
	lw	r29, 5(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.19067:
beq_cont.19051:
	lw	r1, 10(r3)
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.19070
	addi	r2, r0, 0
	j	feq_cont.19071
feq_else.19070:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.19072
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.19073
fle_else.19072:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.19073:
feq_cont.19071:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.19074
	addi	r2, r0, 255
	j	ble_cont.19075
ble_then.19074:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.19076
	addi	r2, r0, 0
	j	ble_cont.19077
ble_then.19076:
ble_cont.19077:
ble_cont.19075:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.19078
	addi	r5, r0, 45
	out	r5
	sub	r2, r0, r2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.19079
ble_then.19078:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.19079:
	addi	r1, r0, 32
	out	r1
	lw	r1, 10(r3)
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.19080
	addi	r2, r0, 0
	j	feq_cont.19081
feq_else.19080:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.19082
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.19083
fle_else.19082:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.19083:
feq_cont.19081:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.19084
	addi	r2, r0, 255
	j	ble_cont.19085
ble_then.19084:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.19086
	addi	r2, r0, 0
	j	ble_cont.19087
ble_then.19086:
ble_cont.19087:
ble_cont.19085:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.19088
	addi	r5, r0, 45
	out	r5
	sub	r2, r0, r2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.19089
ble_then.19088:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.19089:
	addi	r1, r0, 32
	out	r1
	lw	r1, 10(r3)
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.19090
	addi	r2, r0, 0
	j	feq_cont.19091
feq_else.19090:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.19092
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.19093
fle_else.19092:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.19093:
feq_cont.19091:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.19094
	addi	r2, r0, 255
	j	ble_cont.19095
ble_then.19094:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.19096
	addi	r2, r0, 0
	j	ble_cont.19097
ble_then.19096:
ble_cont.19097:
ble_cont.19095:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.19098
	addi	r5, r0, 45
	out	r5
	sub	r2, r0, r2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.19099
ble_then.19098:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771				#	bl	print_uint.2771
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.19099:
	addi	r1, r0, 10
	out	r1
	lw	r1, 9(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 0(r2)
	ble	r5, r1, ble_then.19100
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
	ble	r5, r8, ble_then.19101
	blei	0, r7, ble_then.19103
	lw	r2, 0(r2)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.19105
	blei	0, r1, ble_then.19107
	addi	r2, r0, 1
	j	ble_cont.19108
ble_then.19107:
	addi	r2, r0, 0
ble_cont.19108:
	j	ble_cont.19106
ble_then.19105:
	addi	r2, r0, 0
ble_cont.19106:
	j	ble_cont.19104
ble_then.19103:
	addi	r2, r0, 0
ble_cont.19104:
	j	ble_cont.19102
ble_then.19101:
	addi	r2, r0, 0
ble_cont.19102:
	sw	r1, 12(r3)
	beqi	0, r2, beq_then.19109
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
	j	beq_cont.19110
beq_then.19109:
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
beq_cont.19110:
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
ble_then.19100:
	jr	r31				#
ble_then.19041:
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
	ble	r15, r1, ble_then.19113
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
	ble	r15, r1, ble_then.19114
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
	j	ble_cont.19115
ble_then.19114:
ble_cont.19115:
	addi	r1, r0, 0
	lw	r2, 12(r3)
	lw	r5, 0(r2)
	blei	0, r5, ble_then.19116
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
	ble	r5, r8, ble_then.19118
	blei	0, r7, ble_then.19120
	lw	r5, 0(r2)
	blei	1, r5, ble_then.19122
	addi	r5, r0, 0
	j	ble_cont.19123
ble_then.19122:
	addi	r5, r0, 0
ble_cont.19123:
	j	ble_cont.19121
ble_then.19120:
	addi	r5, r0, 0
ble_cont.19121:
	j	ble_cont.19119
ble_then.19118:
	addi	r5, r0, 0
ble_cont.19119:
	beqi	0, r5, beq_then.19124
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
	j	beq_cont.19125
beq_then.19124:
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
beq_cont.19125:
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
	j	ble_cont.19117
ble_then.19116:
ble_cont.19117:
	lw	r1, 9(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	addi	r1, r1, 2
	addi	r5, r0, 5
	ble	r5, r1, ble_then.19126
	add	r5, r0, r1
	j	ble_cont.19127
ble_then.19126:
	addi	r5, r1, -5
ble_cont.19127:
	lw	r1, 12(r3)
	lw	r6, 1(r1)
	ble	r6, r2, ble_then.19128
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r5, 13(r3)
	sw	r2, 14(r3)
	ble	r1, r2, ble_then.19130
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
	j	ble_cont.19131
ble_then.19130:
ble_cont.19131:
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
	ble	r5, r2, ble_then.19132
	add	r7, r0, r2
	j	ble_cont.19133
ble_then.19132:
	addi	r7, r2, -5
ble_cont.19133:
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
	j	ble_cont.19129
ble_then.19128:
ble_cont.19129:
	jr	r31				#
ble_then.19113:
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
	ble	r6, r2, ble_then.19136
	jr	r31				#
ble_then.19136:
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
	ble	r2, r1, ble_then.19137
	add	r1, r0, r5
	jr	r31				#
ble_then.19137:
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
	ble	r7, r1, ble_then.19138
	fmul	f1, f2, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f1, f1, f2
	fsqrt	f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f2, f2, f1
	fle	r30, f0, f2
	beq	r0, r30, fle_else.19139
	flup	f5, 2		# fli	f5, 1.000000
	j	fle_cont.19140
fle_else.19139:
	flup	f5, 11		# fli	f5, -1.000000
fle_cont.19140:
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
	beq	r0, r30, fle_else.19143
	flup	f6, 24		# fli	f6, 2.437500
	fle	r30, f6, f2
	beq	r0, r30, fle_else.19145
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
	j	fle_cont.19146
fle_else.19145:
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
fle_cont.19146:
	j	fle_cont.19144
fle_else.19143:
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -19
	lw	r31, 18(r3)
fle_cont.19144:
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
	beq	r0, r30, fle_else.19147
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.19148
fle_else.19147:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.19148:
	fmul	f3, f3, f4
	flup	f5, 23		# fli	f5, 4.375000
	fsw	f1, 22(r3)
	sw	r1, 24(r3)
	fsw	f2, 26(r3)
	fle	r30, f5, f3
	beq	r0, r30, fle_else.19150
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f3
	beq	r0, r30, fle_else.19152
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
	j	fle_cont.19153
fle_else.19152:
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
fle_cont.19153:
	j	fle_cont.19151
fle_else.19150:
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	atan_body.2743				#	bl	atan_body.2743
	addi	r3, r3, -35
	lw	r31, 34(r3)
fle_cont.19151:
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
ble_then.19138:
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
	ble	r7, r1, ble_then.19155
	jr	r31				#
ble_then.19155:
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
	ble	r5, r2, ble_then.19158
	j	ble_cont.19159
ble_then.19158:
	addi	r2, r2, -5
ble_cont.19159:
	flw	f1, 2(r3)
	lw	r5, 6(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
calc_dirvec_rows.3277:
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.19160
	jr	r31				#
ble_then.19160:
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
	ble	r5, r2, ble_then.19162
	j	ble_cont.19163
ble_then.19162:
	addi	r2, r2, -5
ble_cont.19163:
	lw	r5, 2(r3)
	addi	r5, r5, 4
	addi	r6, r0, 0
	ble	r6, r1, ble_then.19164
	jr	r31				#
ble_then.19164:
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
	ble	r5, r2, ble_then.19166
	j	ble_cont.19167
ble_then.19166:
	addi	r2, r2, -5
ble_cont.19167:
	lw	r5, 5(r3)
	addi	r5, r5, 4
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
create_dirvec_elements.3283:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.19168
	jr	r31				#
ble_then.19168:
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
	ble	r2, r1, ble_then.19170
	jr	r31				#
ble_then.19170:
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
	ble	r2, r1, ble_then.19172
	jr	r31				#
ble_then.19172:
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
	ble	r2, r1, ble_then.19174
	jr	r31				#
ble_then.19174:
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
	ble	r7, r1, ble_then.19176
	jr	r31				#
ble_then.19176:
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
	ble	r2, r1, ble_then.19178
	jr	r31				#
ble_then.19178:
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
	ble	r8, r2, ble_then.19180
	jr	r31				#
ble_then.19180:
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
	ble	r2, r1, ble_then.19182
	jr	r31				#
ble_then.19182:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	lw	r7, 0(r6)
	addi	r7, r7, -1
	addi	r8, r0, 0
	sw	r1, 6(r3)
	ble	r8, r7, ble_then.19184
	j	ble_cont.19185
ble_then.19184:
	lw	r8, 2(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r5)
	lw	r11, 0(r5)
	lw	r12, 1(r9)
	sw	r5, 7(r3)
	beqi	1, r12, beq_then.19186
	beqi	2, r12, beq_then.19188
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
	j	beq_cont.19189
beq_then.19188:
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
beq_cont.19189:
	j	beq_cont.19187
beq_then.19186:
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
beq_cont.19187:
	addi	r2, r2, -1
	lw	r1, 7(r3)
	lw	r29, 1(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
ble_cont.19185:
	lw	r1, 6(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.19190
	jr	r31				#
ble_then.19190:
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
	ble	r2, r1, ble_then.19192
	jr	r31				#
ble_then.19192:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r1, 11(r3)
	ble	r7, r6, ble_then.19194
	j	ble_cont.19195
ble_then.19194:
	lw	r7, 2(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 12(r3)
	beqi	1, r10, beq_then.19196
	beqi	2, r10, beq_then.19198
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
	j	beq_cont.19199
beq_then.19198:
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
beq_cont.19199:
	j	beq_cont.19197
beq_then.19196:
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
beq_cont.19197:
	addi	r2, r2, -1
	lw	r1, 12(r3)
	lw	r29, 1(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -16
	lw	r31, 15(r3)
ble_cont.19195:
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
	ble	r9, r1, ble_then.19200
	jr	r31				#
ble_then.19200:
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
	ble	r12, r11, ble_then.19202
	j	ble_cont.19203
ble_then.19202:
	add	r30, r2, r11
	lw	r12, 0(r30)
	lw	r13, 1(r10)
	lw	r14, 0(r10)
	lw	r15, 1(r12)
	sw	r10, 8(r3)
	beqi	1, r15, beq_then.19204
	beqi	2, r15, beq_then.19206
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
	j	beq_cont.19207
beq_then.19206:
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
beq_cont.19207:
	j	beq_cont.19205
beq_then.19204:
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
beq_cont.19205:
	addi	r2, r2, -1
	lw	r1, 8(r3)
	lw	r29, 5(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
ble_cont.19203:
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
	ble	r7, r6, ble_then.19208
	j	ble_cont.19209
ble_then.19208:
	lw	r7, 4(r3)
	add	r30, r7, r6
	lw	r8, 0(r30)
	lw	r9, 1(r2)
	lw	r10, 0(r2)
	lw	r11, 1(r8)
	sw	r2, 11(r3)
	beqi	1, r11, beq_then.19210
	beqi	2, r11, beq_then.19212
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
	j	beq_cont.19213
beq_then.19212:
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
beq_cont.19213:
	j	beq_cont.19211
beq_then.19210:
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
beq_cont.19211:
	addi	r2, r2, -1
	lw	r1, 11(r3)
	lw	r29, 5(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
ble_cont.19209:
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
	ble	r2, r1, ble_then.19214
	jr	r31				#
ble_then.19214:
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
	ble	r7, r6, ble_then.19216
	j	ble_cont.19217
ble_then.19216:
	lw	r7, 4(r3)
	add	r30, r7, r6
	lw	r8, 0(r30)
	lw	r9, 1(r2)
	lw	r10, 0(r2)
	lw	r11, 1(r8)
	sw	r2, 16(r3)
	beqi	1, r11, beq_then.19218
	beqi	2, r11, beq_then.19220
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
	j	beq_cont.19221
beq_then.19220:
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
beq_cont.19221:
	j	beq_cont.19219
beq_then.19218:
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
beq_cont.19219:
	addi	r2, r2, -1
	lw	r1, 16(r3)
	lw	r29, 5(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
ble_cont.19217:
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
	ble	r2, r1, ble_then.19222
	jr	r31				#
ble_then.19222:
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
	ble	r8, r7, ble_then.19224
	j	ble_cont.19225
ble_then.19224:
	lw	r8, 4(r3)
	add	r30, r8, r7
	lw	r8, 0(r30)
	lw	r9, 1(r6)
	lw	r10, 0(r6)
	lw	r11, 1(r8)
	sw	r6, 21(r3)
	beqi	1, r11, beq_then.19226
	beqi	2, r11, beq_then.19228
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
	j	beq_cont.19229
beq_then.19228:
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
beq_cont.19229:
	j	beq_cont.19227
beq_then.19226:
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
beq_cont.19227:
	addi	r2, r2, -1
	lw	r1, 21(r3)
	lw	r29, 5(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -25
	lw	r31, 24(r3)
ble_cont.19225:
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
	ble	r2, r1, ble_then.19230
	jr	r31				#
ble_then.19230:
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
	ble	r8, r7, ble_then.19234
	j	ble_cont.19235
ble_then.19234:
	lw	r8, 13(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r9)
	beqi	1, r10, beq_then.19236
	beqi	2, r10, beq_then.19238
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
	j	beq_cont.19239
beq_then.19238:
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
beq_cont.19239:
	j	beq_cont.19237
beq_then.19236:
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
beq_cont.19237:
	addi	r2, r2, -1
	lw	r1, 22(r3)
	lw	r29, 12(r3)
	sw	r31, 25(r3)
	addi	r3, r3, 26
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -26
	lw	r31, 25(r3)
ble_cont.19235:
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
	ble	r8, r7, ble_then.19241
	j	ble_cont.19242
ble_then.19241:
	lw	r8, 13(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r9)
	beqi	1, r10, beq_then.19243
	beqi	2, r10, beq_then.19245
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
	j	beq_cont.19246
beq_then.19245:
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
beq_cont.19246:
	j	beq_cont.19244
beq_then.19243:
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
beq_cont.19244:
	addi	r2, r2, -1
	lw	r1, 31(r3)
	lw	r29, 12(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -35
	lw	r31, 34(r3)
ble_cont.19242:
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
	ble	r7, r6, ble_then.19247
	j	ble_cont.19248
ble_then.19247:
	lw	r7, 13(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.19249
	beqi	2, r8, beq_then.19251
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
	j	beq_cont.19252
beq_then.19251:
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
beq_cont.19252:
	j	beq_cont.19250
beq_then.19249:
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
beq_cont.19250:
	addi	r2, r2, -1
	lw	r1, 39(r3)
	lw	r29, 12(r3)
	sw	r31, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -43
	lw	r31, 42(r3)
ble_cont.19248:
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
	ble	r7, r6, ble_then.19254
	j	ble_cont.19255
ble_then.19254:
	lw	r7, 7(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.19256
	beqi	2, r8, beq_then.19258
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
	j	beq_cont.19259
beq_then.19258:
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
beq_cont.19259:
	j	beq_cont.19257
beq_then.19256:
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
beq_cont.19257:
	addi	r2, r2, -1
	lw	r1, 16(r3)
	lw	r29, 6(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
ble_cont.19255:
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
	beqi	0, r1, beq_then.19261
	addi	r1, r0, 1
	lw	r29, 17(r3)
	sw	r31, 53(r3)
	addi	r3, r3, 54
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -54
	lw	r31, 53(r3)
	j	beq_cont.19262
beq_then.19261:
	lw	r1, 18(r3)
	lw	r2, 52(r3)
	sw	r2, 0(r1)
beq_cont.19262:
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
	ble	r2, r5, ble_then.19263
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.19265
	addi	r2, r5, 48
	out	r2
	j	ble_cont.19266
ble_then.19265:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 53(r3)
	ble	r7, r5, ble_then.19267
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 54(r3)
	addi	r3, r3, 55
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -55
	lw	r31, 54(r3)
	j	ble_cont.19268
ble_then.19267:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.19269
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 54(r3)
	addi	r3, r3, 55
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -55
	lw	r31, 54(r3)
	j	ble_cont.19270
ble_then.19269:
	add	r1, r0, r6
ble_cont.19270:
ble_cont.19268:
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
ble_cont.19266:
	j	ble_cont.19264
ble_then.19263:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.19271
	addi	r2, r5, 48
	out	r2
	j	ble_cont.19272
ble_then.19271:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 55(r3)
	ble	r7, r5, ble_then.19273
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 56(r3)
	addi	r3, r3, 57
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -57
	lw	r31, 56(r3)
	j	ble_cont.19274
ble_then.19273:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.19275
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 56(r3)
	addi	r3, r3, 57
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -57
	lw	r31, 56(r3)
	j	ble_cont.19276
ble_then.19275:
	add	r1, r0, r6
ble_cont.19276:
ble_cont.19274:
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
ble_cont.19272:
ble_cont.19264:
	addi	r1, r0, 32
	out	r1
	lw	r1, 23(r3)
	lw	r5, 1(r1)
	addi	r2, r0, 0
	ble	r2, r5, ble_then.19277
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.19279
	addi	r2, r5, 48
	out	r2
	j	ble_cont.19280
ble_then.19279:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 57(r3)
	ble	r7, r5, ble_then.19281
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 58(r3)
	addi	r3, r3, 59
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -59
	lw	r31, 58(r3)
	j	ble_cont.19282
ble_then.19281:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.19283
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 58(r3)
	addi	r3, r3, 59
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -59
	lw	r31, 58(r3)
	j	ble_cont.19284
ble_then.19283:
	add	r1, r0, r6
ble_cont.19284:
ble_cont.19282:
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
ble_cont.19280:
	j	ble_cont.19278
ble_then.19277:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.19285
	addi	r2, r5, 48
	out	r2
	j	ble_cont.19286
ble_then.19285:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 59(r3)
	ble	r7, r5, ble_then.19287
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 60(r3)
	addi	r3, r3, 61
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -61
	lw	r31, 60(r3)
	j	ble_cont.19288
ble_then.19287:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.19289
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 60(r3)
	addi	r3, r3, 61
	jal	div10_sub.2751				#	bl	div10_sub.2751
	addi	r3, r3, -61
	lw	r31, 60(r3)
	j	ble_cont.19290
ble_then.19289:
	add	r1, r0, r6
ble_cont.19290:
ble_cont.19288:
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
ble_cont.19286:
ble_cont.19278:
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
	ble	r8, r7, ble_then.19291
	j	ble_cont.19292
ble_then.19291:
	lw	r8, 11(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r5)
	lw	r11, 0(r5)
	lw	r12, 1(r9)
	sw	r5, 64(r3)
	beqi	1, r12, beq_then.19293
	beqi	2, r12, beq_then.19295
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
	j	beq_cont.19296
beq_then.19295:
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
beq_cont.19296:
	j	beq_cont.19294
beq_then.19293:
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
beq_cont.19294:
	addi	r2, r2, -1
	lw	r1, 64(r3)
	lw	r29, 10(r3)
	sw	r31, 67(r3)
	addi	r3, r3, 68
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -68
	lw	r31, 67(r3)
ble_cont.19292:
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
	ble	r2, r1, ble_then.19297
	j	ble_cont.19298
ble_then.19297:
	lw	r2, 11(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.19299
	j	beq_cont.19300
beq_then.19299:
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
	beqi	0, r1, beq_then.19301
	lw	r2, 68(r3)
	lw	r1, 1(r2)
	beqi	1, r1, beq_then.19303
	beqi	2, r1, beq_then.19305
	j	beq_cont.19306
beq_then.19305:
	lw	r1, 67(r3)
	lw	r29, 3(r3)
	sw	r31, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -70
	lw	r31, 69(r3)
beq_cont.19306:
	j	beq_cont.19304
beq_then.19303:
	lw	r1, 67(r3)
	lw	r29, 4(r3)
	sw	r31, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -70
	lw	r31, 69(r3)
beq_cont.19304:
	j	beq_cont.19302
beq_then.19301:
beq_cont.19302:
beq_cont.19300:
ble_cont.19298:
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
	blei	0, r6, ble_then.19307
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r2, 69(r3)
	blei	0, r1, ble_then.19308
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
	j	ble_cont.19309
ble_then.19308:
ble_cont.19309:
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
ble_then.19307:
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
