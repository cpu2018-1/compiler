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
hoge.2678:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17732
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17733
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17734
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17735
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17736
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17737
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17738
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17739
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17740
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17741
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17742
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17743
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17744
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17745
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17746
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17747
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2678
fle_else.17747:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17746:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17745:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17744:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17743:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17742:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17741:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17740:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17739:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17738:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17737:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17736:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17735:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17734:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17733:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17732:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2681:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17748
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17749
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17750
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17751
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2681
fle_else.17751:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2681
fle_else.17750:
	jr	r31				#
fle_else.17749:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17752
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17753
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2681
fle_else.17753:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2681
fle_else.17752:
	jr	r31				#
fle_else.17748:
	jr	r31				#
sin.2691:
	flup	f2, 14		# fli	f2, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17754
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.17755
fle_else.17754:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.17755:
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
	beq	r0, r30, fle_else.17756
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17758
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17760
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17762
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17764
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17766
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17768
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17770
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17772
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17774
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17776
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17778
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17780
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17782
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2678				#	bl	hoge.2678
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.17783
fle_else.17782:
fle_cont.17783:
	j	fle_cont.17781
fle_else.17780:
fle_cont.17781:
	j	fle_cont.17779
fle_else.17778:
fle_cont.17779:
	j	fle_cont.17777
fle_else.17776:
fle_cont.17777:
	j	fle_cont.17775
fle_else.17774:
fle_cont.17775:
	j	fle_cont.17773
fle_else.17772:
fle_cont.17773:
	j	fle_cont.17771
fle_else.17770:
fle_cont.17771:
	j	fle_cont.17769
fle_else.17768:
fle_cont.17769:
	j	fle_cont.17767
fle_else.17766:
fle_cont.17767:
	j	fle_cont.17765
fle_else.17764:
fle_cont.17765:
	j	fle_cont.17763
fle_else.17762:
fle_cont.17763:
	j	fle_cont.17761
fle_else.17760:
fle_cont.17761:
	j	fle_cont.17759
fle_else.17758:
fle_cont.17759:
	j	fle_cont.17757
fle_else.17756:
fle_cont.17757:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2681				#	bl	fuga.2681
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17784
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17785
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17786
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
fle_else.17786:
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
fle_else.17785:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17787
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
fle_else.17787:
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
fle_else.17784:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.17788
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17789
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
fle_else.17789:
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
fle_else.17788:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17790
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
fle_else.17790:
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
cos.2693:
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
	beq	r0, r30, fle_else.17791
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17793
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17795
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17797
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17799
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17801
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17803
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17805
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17807
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17809
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17811
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17813
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17815
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17817
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2678				#	bl	hoge.2678
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.17818
fle_else.17817:
fle_cont.17818:
	j	fle_cont.17816
fle_else.17815:
fle_cont.17816:
	j	fle_cont.17814
fle_else.17813:
fle_cont.17814:
	j	fle_cont.17812
fle_else.17811:
fle_cont.17812:
	j	fle_cont.17810
fle_else.17809:
fle_cont.17810:
	j	fle_cont.17808
fle_else.17807:
fle_cont.17808:
	j	fle_cont.17806
fle_else.17805:
fle_cont.17806:
	j	fle_cont.17804
fle_else.17803:
fle_cont.17804:
	j	fle_cont.17802
fle_else.17801:
fle_cont.17802:
	j	fle_cont.17800
fle_else.17799:
fle_cont.17800:
	j	fle_cont.17798
fle_else.17797:
fle_cont.17798:
	j	fle_cont.17796
fle_else.17795:
fle_cont.17796:
	j	fle_cont.17794
fle_else.17793:
fle_cont.17794:
	j	fle_cont.17792
fle_else.17791:
fle_cont.17792:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2681				#	bl	fuga.2681
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17819
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17820
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.17821
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
fle_else.17821:
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
fle_else.17820:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17822
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
fle_else.17822:
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
fle_else.17819:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.17823
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.17824
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
fle_else.17824:
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
fle_else.17823:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17825
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
fle_else.17825:
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
atan_body.2695:
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
div10_sub.2703:
	add	r6, r2, r5
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.17826
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r7, r5, 3
	slli	r8, r5, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.17827
	j	div10_sub.2703
ble_then.17827:
	slli	r2, r5, 3
	slli	r7, r5, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.17828
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	j	div10_sub.2703
ble_then.17828:
	add	r1, r0, r5
	jr	r31				#
ble_then.17826:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.17829
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r7, r2, 3
	slli	r8, r2, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.17830
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r6				# mr	r2, r6
	j	div10_sub.2703
ble_then.17830:
	slli	r6, r2, 3
	slli	r7, r2, 1
	add	r6, r6, r7
	addi	r6, r6, 9
	ble	r1, r6, ble_then.17831
	j	div10_sub.2703
ble_then.17831:
	add	r1, r0, r2
	jr	r31				#
ble_then.17829:
	add	r1, r0, r6
	jr	r31				#
print_uint.2723:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.17832
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.17832:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 10
	sw	r1, 1(r3)
	ble	r2, r1, ble_then.17833
	addi	r2, r1, 48
	out	r2
	j	ble_cont.17834
ble_then.17833:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.17835
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.17836
ble_then.17835:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.17837
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.17838
ble_then.17837:
	add	r1, r0, r5
ble_cont.17838:
ble_cont.17836:
	addi	r2, r0, 10
	sw	r1, 2(r3)
	ble	r2, r1, ble_then.17839
	addi	r2, r1, 48
	out	r2
	j	ble_cont.17840
ble_then.17839:
	addi	r2, r0, 0
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 10
	sw	r1, 3(r3)
	ble	r2, r1, ble_then.17841
	addi	r2, r1, 48
	out	r2
	j	ble_cont.17842
ble_then.17841:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.17843
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.17844
ble_then.17843:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.17845
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.17846
ble_then.17845:
	add	r1, r0, r5
ble_cont.17846:
ble_cont.17844:
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	print_uint.2723				#	bl	print_uint.2723
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
ble_cont.17842:
	lw	r1, 3(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 2(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.17840:
	lw	r1, 2(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 1(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.17834:
	lw	r1, 1(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
	jr	r31				#
vecunit_sgn.2807:
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
	beq	r0, r30, feq_else.17847
	addi	r5, r0, 1
	j	feq_cont.17848
feq_else.17847:
	addi	r5, r0, 0
feq_cont.17848:
	beqi	0, r5, beq_then.17849
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.17850
beq_then.17849:
	beqi	0, r2, beq_then.17851
	flup	f2, 11		# fli	f2, -1.000000
	fdiv	f1, f2, f1
	j	beq_cont.17852
beq_then.17851:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
beq_cont.17852:
beq_cont.17850:
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
vecaccumv.2831:
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
read_screen_settings.2908:
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
	jal	cos.2693				#	bl	cos.2693
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin.2691				#	bl	sin.2691
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
	jal	cos.2693				#	bl	cos.2693
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fsw	f1, 14(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	sin.2691				#	bl	sin.2691
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
read_light.2910:
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
	jal	sin.2691				#	bl	sin.2691
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
	jal	cos.2693				#	bl	cos.2693
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2691				#	bl	sin.2691
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	fsw	f1, 0(r1)
	flw	f1, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos.2693				#	bl	cos.2693
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
rotate_quadratic_matrix.2912:
	flw	f1, 0(r2)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	cos.2693				#	bl	cos.2693
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2691				#	bl	sin.2691
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2693				#	bl	cos.2693
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2691				#	bl	sin.2691
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos.2693				#	bl	cos.2693
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 10(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2691				#	bl	sin.2691
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
read_nth_object.2915:
	lw	r2, 1(r29)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.17859
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
	beq	r0, r30, fle_else.17860
	addi	r1, r0, 0
	j	fle_cont.17861
fle_else.17860:
	addi	r1, r0, 1
fle_cont.17861:
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
	beqi	0, r2, beq_then.17862
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
	j	beq_cont.17863
beq_then.17862:
beq_cont.17863:
	lw	r2, 3(r3)
	beqi	2, r2, beq_then.17864
	lw	r5, 8(r3)
	j	beq_cont.17865
beq_then.17864:
	addi	r5, r0, 1
beq_cont.17865:
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
	beqi	3, r7, beq_then.17866
	beqi	2, r7, beq_then.17868
	j	beq_cont.17869
beq_then.17868:
	lw	r2, 8(r3)
	beqi	0, r2, beq_then.17870
	addi	r2, r0, 0
	j	beq_cont.17871
beq_then.17870:
	addi	r2, r0, 1
beq_cont.17871:
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	vecunit_sgn.2807				#	bl	vecunit_sgn.2807
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.17869:
	j	beq_cont.17867
beq_then.17866:
	flw	f1, 0(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17872
	addi	r2, r0, 1
	j	feq_cont.17873
feq_else.17872:
	addi	r2, r0, 0
feq_cont.17873:
	beqi	0, r2, beq_then.17874
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.17875
beq_then.17874:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17876
	addi	r2, r0, 1
	j	feq_cont.17877
feq_else.17876:
	addi	r2, r0, 0
feq_cont.17877:
	beqi	0, r2, beq_then.17878
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.17879
beq_then.17878:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17880
	addi	r2, r0, 0
	j	fle_cont.17881
fle_else.17880:
	addi	r2, r0, 1
fle_cont.17881:
	beqi	0, r2, beq_then.17882
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.17883
beq_then.17882:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.17883:
beq_cont.17879:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.17875:
	fsw	f1, 0(r5)
	flw	f1, 1(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17884
	addi	r2, r0, 1
	j	feq_cont.17885
feq_else.17884:
	addi	r2, r0, 0
feq_cont.17885:
	beqi	0, r2, beq_then.17886
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.17887
beq_then.17886:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17888
	addi	r2, r0, 1
	j	feq_cont.17889
feq_else.17888:
	addi	r2, r0, 0
feq_cont.17889:
	beqi	0, r2, beq_then.17890
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.17891
beq_then.17890:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17892
	addi	r2, r0, 0
	j	fle_cont.17893
fle_else.17892:
	addi	r2, r0, 1
fle_cont.17893:
	beqi	0, r2, beq_then.17894
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.17895
beq_then.17894:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.17895:
beq_cont.17891:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.17887:
	fsw	f1, 1(r5)
	flw	f1, 2(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17896
	addi	r2, r0, 1
	j	feq_cont.17897
feq_else.17896:
	addi	r2, r0, 0
feq_cont.17897:
	beqi	0, r2, beq_then.17898
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.17899
beq_then.17898:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17900
	addi	r2, r0, 1
	j	feq_cont.17901
feq_else.17900:
	addi	r2, r0, 0
feq_cont.17901:
	beqi	0, r2, beq_then.17902
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.17903
beq_then.17902:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17904
	addi	r2, r0, 0
	j	fle_cont.17905
fle_else.17904:
	addi	r2, r0, 1
fle_cont.17905:
	beqi	0, r2, beq_then.17906
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.17907
beq_then.17906:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.17907:
beq_cont.17903:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.17899:
	fsw	f1, 2(r5)
beq_cont.17867:
	lw	r1, 5(r3)
	beqi	0, r1, beq_then.17908
	lw	r1, 6(r3)
	lw	r2, 11(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	rotate_quadratic_matrix.2912				#	bl	rotate_quadratic_matrix.2912
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.17909
beq_then.17908:
beq_cont.17909:
	addi	r1, r0, 1
	jr	r31				#
beq_then.17859:
	addi	r1, r0, 0
	jr	r31				#
read_object.2917:
	lw	r2, 2(r29)
	lw	r5, 1(r29)
	addi	r6, r0, 60
	ble	r6, r1, ble_then.17910
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
	beqi	0, r1, beq_then.17911
	lw	r1, 3(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.17912
	lw	r29, 1(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.17913
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.17914
	lw	r29, 1(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.17915
	lw	r1, 5(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.17916
	lw	r29, 1(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	0, r1, beq_then.17917
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.17917:
	lw	r1, 2(r3)
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.17916:
	jr	r31				#
beq_then.17915:
	lw	r1, 2(r3)
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.17914:
	jr	r31				#
beq_then.17913:
	lw	r1, 2(r3)
	lw	r2, 4(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.17912:
	jr	r31				#
beq_then.17911:
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.17910:
	jr	r31				#
read_net_item.2921:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.17926
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.17927
	lw	r2, 2(r3)
	addi	r5, r2, 1
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.17929
	lw	r2, 4(r3)
	addi	r5, r2, 1
	sw	r1, 5(r3)
	sw	r5, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.17931
	lw	r2, 6(r3)
	addi	r5, r2, 1
	sw	r1, 7(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.2921				#	bl	read_net_item.2921
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.17932
beq_then.17931:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.17932:
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.17930
beq_then.17929:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.17930:
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.17928
beq_then.17927:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.17928:
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.17926:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	j	lib_create_array
read_or_network.2923:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.17933
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.17935
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.17937
	addi	r2, r0, 3
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.2921				#	bl	read_net_item.2921
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 2(r1)
	j	beq_cont.17938
beq_then.17937:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.17938:
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.17936
beq_then.17935:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.17936:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.17934
beq_then.17933:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.17934:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.17939
	lw	r1, 0(r3)
	addi	r5, r1, 1
	sw	r2, 4(r3)
	sw	r5, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.17940
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.17942
	addi	r2, r0, 2
	sw	r1, 7(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.2921				#	bl	read_net_item.2921
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 7(r3)
	sw	r2, 1(r1)
	j	beq_cont.17943
beq_then.17942:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.17943:
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.17941
beq_then.17940:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.17941:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.17944
	lw	r1, 5(r3)
	addi	r5, r1, 1
	sw	r2, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	read_or_network.2923				#	bl	read_or_network.2923
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 5(r3)
	lw	r5, 8(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.17945
beq_then.17944:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.17945:
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.17939:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.2925:
	lw	r2, 1(r29)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.17946
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	-1, r1, beq_then.17948
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.17950
	addi	r2, r0, 3
	sw	r1, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	read_net_item.2921				#	bl	read_net_item.2921
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 5(r3)
	sw	r2, 2(r1)
	j	beq_cont.17951
beq_then.17950:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.17951:
	lw	r2, 4(r3)
	sw	r2, 1(r1)
	j	beq_cont.17949
beq_then.17948:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.17949:
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	j	beq_cont.17947
beq_then.17946:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.17947:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.17952
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
	beqi	-1, r1, beq_then.17953
	sw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	-1, r1, beq_then.17955
	addi	r2, r0, 2
	sw	r1, 8(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	read_net_item.2921				#	bl	read_net_item.2921
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 8(r3)
	sw	r2, 1(r1)
	j	beq_cont.17956
beq_then.17955:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.17956:
	lw	r2, 7(r3)
	sw	r2, 0(r1)
	j	beq_cont.17954
beq_then.17953:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.17954:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.17957
	lw	r2, 6(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.17957:
	jr	r31				#
beq_then.17952:
	jr	r31				#
solver_rect_surface.2929:
	lw	r8, 1(r29)
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.17960
	addi	r9, r0, 1
	j	feq_cont.17961
feq_else.17960:
	addi	r9, r0, 0
feq_cont.17961:
	beqi	0, r9, beq_then.17962
	addi	r1, r0, 0
	jr	r31				#
beq_then.17962:
	lw	r9, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.17963
	addi	r10, r0, 0
	j	fle_cont.17964
fle_else.17963:
	addi	r10, r0, 1
fle_cont.17964:
	beqi	0, r1, beq_then.17965
	beqi	0, r10, beq_then.17967
	addi	r1, r0, 0
	j	beq_cont.17968
beq_then.17967:
	addi	r1, r0, 1
beq_cont.17968:
	j	beq_cont.17966
beq_then.17965:
	add	r1, r0, r10
beq_cont.17966:
	add	r30, r9, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.17969
	j	beq_cont.17970
beq_then.17969:
	fneg	f4, f4
beq_cont.17970:
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
	beq	r0, r30, fle_else.17971
	j	fle_cont.17972
fle_else.17971:
	fneg	f2, f2
fle_cont.17972:
	fle	r30, f4, f2
	beq	r0, r30, fle_else.17973
	addi	r1, r0, 0
	jr	r31				#
fle_else.17973:
	add	r30, r9, r7
	flw	f2, 0(r30)
	add	r30, r2, r7
	flw	f4, 0(r30)
	fmul	f4, f1, f4
	fadd	f3, f4, f3
	fle	r30, f0, f3
	beq	r0, r30, fle_else.17974
	j	fle_cont.17975
fle_else.17974:
	fneg	f3, f3
fle_cont.17975:
	fle	r30, f2, f3
	beq	r0, r30, fle_else.17976
	addi	r1, r0, 0
	jr	r31				#
fle_else.17976:
	fsw	f1, 0(r8)
	addi	r1, r0, 1
	jr	r31				#
solver_surface.2944:
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
	beq	r0, r30, fle_else.17977
	addi	r2, r0, 0
	j	fle_cont.17978
fle_else.17977:
	addi	r2, r0, 1
fle_cont.17978:
	beqi	0, r2, beq_then.17979
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
beq_then.17979:
	addi	r1, r0, 0
	jr	r31				#
quadratic.2950:
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
	beqi	0, r2, beq_then.17980
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
beq_then.17980:
	fadd	f1, f0, f4
	jr	r31				#
bilinear.2955:
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
	beqi	0, r2, beq_then.17981
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
beq_then.17981:
	fadd	f1, f0, f7
	jr	r31				#
solver_second.2963:
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
	jal	quadratic.2950				#	bl	quadratic.2950
	addi	r3, r3, -11
	lw	r31, 10(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17983
	addi	r1, r0, 1
	j	feq_cont.17984
feq_else.17983:
	addi	r1, r0, 0
feq_cont.17984:
	beqi	0, r1, beq_then.17985
	addi	r1, r0, 0
	jr	r31				#
beq_then.17985:
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
	jal	bilinear.2955				#	bl	bilinear.2955
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
	jal	quadratic.2950				#	bl	quadratic.2950
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 8(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.17986
	j	beq_cont.17987
beq_then.17986:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.17987:
	flw	f2, 12(r3)
	fmul	f3, f2, f2
	flw	f4, 10(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17988
	addi	r2, r0, 0
	j	fle_cont.17989
fle_else.17988:
	addi	r2, r0, 1
fle_cont.17989:
	beqi	0, r2, beq_then.17990
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.17991
	j	beq_cont.17992
beq_then.17991:
	fneg	f1, f1
beq_cont.17992:
	fsub	f1, f1, f2
	fdiv	f1, f1, f4
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.17990:
	addi	r1, r0, 0
	jr	r31				#
solver.2969:
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
	beqi	1, r5, beq_then.17993
	beqi	2, r5, beq_then.17994
	add	r29, r0, r6				# mr	r29, r6
	lw	r28, 0(r29)
	jr	r28
beq_then.17994:
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
	beq	r0, r30, fle_else.17995
	addi	r2, r0, 0
	j	fle_cont.17996
fle_else.17995:
	addi	r2, r0, 1
fle_cont.17996:
	beqi	0, r2, beq_then.17997
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
beq_then.17997:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17993:
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
	beqi	0, r1, beq_then.17998
	addi	r1, r0, 1
	jr	r31				#
beq_then.17998:
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
	beqi	0, r1, beq_then.17999
	addi	r1, r0, 2
	jr	r31				#
beq_then.17999:
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
	beqi	0, r1, beq_then.18000
	addi	r1, r0, 3
	jr	r31				#
beq_then.18000:
	addi	r1, r0, 0
	jr	r31				#
solver_rect_fast.2973:
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
	beq	r0, r30, fle_else.18001
	j	fle_cont.18002
fle_else.18001:
	fneg	f6, f6
fle_cont.18002:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.18003
	addi	r7, r0, 0
	j	fle_cont.18004
fle_else.18003:
	lw	r7, 4(r1)
	flw	f5, 2(r7)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.18005
	j	fle_cont.18006
fle_else.18005:
	fneg	f6, f6
fle_cont.18006:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.18007
	addi	r7, r0, 0
	j	fle_cont.18008
fle_else.18007:
	flw	f5, 1(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.18009
	addi	r7, r0, 1
	j	feq_cont.18010
feq_else.18009:
	addi	r7, r0, 0
feq_cont.18010:
	beqi	0, r7, beq_then.18011
	addi	r7, r0, 0
	j	beq_cont.18012
beq_then.18011:
	addi	r7, r0, 1
beq_cont.18012:
fle_cont.18008:
fle_cont.18004:
	beqi	0, r7, beq_then.18013
	fsw	f4, 0(r6)
	addi	r1, r0, 1
	jr	r31				#
beq_then.18013:
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
	beq	r0, r30, fle_else.18014
	j	fle_cont.18015
fle_else.18014:
	fneg	f6, f6
fle_cont.18015:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.18016
	addi	r7, r0, 0
	j	fle_cont.18017
fle_else.18016:
	lw	r7, 4(r1)
	flw	f5, 2(r7)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.18018
	j	fle_cont.18019
fle_else.18018:
	fneg	f6, f6
fle_cont.18019:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.18020
	addi	r7, r0, 0
	j	fle_cont.18021
fle_else.18020:
	flw	f5, 3(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.18022
	addi	r7, r0, 1
	j	feq_cont.18023
feq_else.18022:
	addi	r7, r0, 0
feq_cont.18023:
	beqi	0, r7, beq_then.18024
	addi	r7, r0, 0
	j	beq_cont.18025
beq_then.18024:
	addi	r7, r0, 1
beq_cont.18025:
fle_cont.18021:
fle_cont.18017:
	beqi	0, r7, beq_then.18026
	fsw	f4, 0(r6)
	addi	r1, r0, 2
	jr	r31				#
beq_then.18026:
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
	beq	r0, r30, fle_else.18027
	j	fle_cont.18028
fle_else.18027:
	fneg	f1, f1
fle_cont.18028:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.18029
	addi	r1, r0, 0
	j	fle_cont.18030
fle_else.18029:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	flw	f4, 1(r2)
	fmul	f4, f3, f4
	fadd	f2, f4, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18031
	j	fle_cont.18032
fle_else.18031:
	fneg	f2, f2
fle_cont.18032:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18033
	addi	r1, r0, 0
	j	fle_cont.18034
fle_else.18033:
	flw	f1, 5(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18035
	addi	r1, r0, 1
	j	feq_cont.18036
feq_else.18035:
	addi	r1, r0, 0
feq_cont.18036:
	beqi	0, r1, beq_then.18037
	addi	r1, r0, 0
	j	beq_cont.18038
beq_then.18037:
	addi	r1, r0, 1
beq_cont.18038:
fle_cont.18034:
fle_cont.18030:
	beqi	0, r1, beq_then.18039
	fsw	f3, 0(r6)
	addi	r1, r0, 3
	jr	r31				#
beq_then.18039:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.2986:
	lw	r5, 1(r29)
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.18040
	addi	r6, r0, 1
	j	feq_cont.18041
feq_else.18040:
	addi	r6, r0, 0
feq_cont.18041:
	beqi	0, r6, beq_then.18042
	addi	r1, r0, 0
	jr	r31				#
beq_then.18042:
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
	jal	quadratic.2950				#	bl	quadratic.2950
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.18043
	j	beq_cont.18044
beq_then.18043:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.18044:
	flw	f2, 4(r3)
	fmul	f3, f2, f2
	flw	f4, 2(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18045
	addi	r2, r0, 0
	j	fle_cont.18046
fle_else.18045:
	addi	r2, r0, 1
fle_cont.18046:
	beqi	0, r2, beq_then.18047
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18048
	fsqrt	f1, f1
	fadd	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	j	beq_cont.18049
beq_then.18048:
	fsqrt	f1, f1
	fsub	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
beq_cont.18049:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18047:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3003:
	lw	r6, 1(r29)
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.18050
	addi	r7, r0, 1
	j	feq_cont.18051
feq_else.18050:
	addi	r7, r0, 0
feq_cont.18051:
	beqi	0, r7, beq_then.18052
	addi	r1, r0, 0
	jr	r31				#
beq_then.18052:
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
	beq	r0, r30, fle_else.18053
	addi	r5, r0, 0
	j	fle_cont.18054
fle_else.18053:
	addi	r5, r0, 1
fle_cont.18054:
	beqi	0, r5, beq_then.18055
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18056
	fsqrt	f2, f2
	fadd	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r6)
	j	beq_cont.18057
beq_then.18056:
	fsqrt	f2, f2
	fsub	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r6)
beq_cont.18057:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18055:
	addi	r1, r0, 0
	jr	r31				#
solver_fast2.3010:
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
	beqi	1, r10, beq_then.18058
	beqi	2, r10, beq_then.18059
	add	r2, r0, r1				# mr	r2, r1
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r9				# mr	r5, r9
	add	r1, r0, r8				# mr	r1, r8
	lw	r28, 0(r29)
	jr	r28
beq_then.18059:
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18060
	addi	r2, r0, 0
	j	fle_cont.18061
fle_else.18060:
	addi	r2, r0, 1
fle_cont.18061:
	beqi	0, r2, beq_then.18062
	flw	f1, 0(r1)
	flw	f2, 3(r9)
	fmul	f1, f1, f2
	fsw	f1, 0(r7)
	addi	r1, r0, 1
	jr	r31				#
beq_then.18062:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18058:
	lw	r2, 0(r2)
	add	r5, r0, r1				# mr	r5, r1
	add	r29, r0, r6				# mr	r29, r6
	add	r1, r0, r8				# mr	r1, r8
	lw	r28, 0(r29)
	jr	r28
setup_rect_table.3013:
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
	beq	r0, r30, feq_else.18063
	addi	r5, r0, 1
	j	feq_cont.18064
feq_else.18063:
	addi	r5, r0, 0
feq_cont.18064:
	beqi	0, r5, beq_then.18065
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 1(r1)
	j	beq_cont.18066
beq_then.18065:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18067
	addi	r7, r0, 0
	j	fle_cont.18068
fle_else.18067:
	addi	r7, r0, 1
fle_cont.18068:
	beqi	0, r6, beq_then.18069
	beqi	0, r7, beq_then.18071
	addi	r6, r0, 0
	j	beq_cont.18072
beq_then.18071:
	addi	r6, r0, 1
beq_cont.18072:
	j	beq_cont.18070
beq_then.18069:
	add	r6, r0, r7
beq_cont.18070:
	lw	r7, 4(r5)
	flw	f1, 0(r7)
	beqi	0, r6, beq_then.18073
	j	beq_cont.18074
beq_then.18073:
	fneg	f1, f1
beq_cont.18074:
	fsw	f1, 0(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r2)
	fdiv	f1, f1, f2
	fsw	f1, 1(r1)
beq_cont.18066:
	flw	f1, 1(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18075
	addi	r5, r0, 1
	j	feq_cont.18076
feq_else.18075:
	addi	r5, r0, 0
feq_cont.18076:
	beqi	0, r5, beq_then.18077
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 3(r1)
	j	beq_cont.18078
beq_then.18077:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 1(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18079
	addi	r7, r0, 0
	j	fle_cont.18080
fle_else.18079:
	addi	r7, r0, 1
fle_cont.18080:
	beqi	0, r6, beq_then.18081
	beqi	0, r7, beq_then.18083
	addi	r6, r0, 0
	j	beq_cont.18084
beq_then.18083:
	addi	r6, r0, 1
beq_cont.18084:
	j	beq_cont.18082
beq_then.18081:
	add	r6, r0, r7
beq_cont.18082:
	lw	r7, 4(r5)
	flw	f1, 1(r7)
	beqi	0, r6, beq_then.18085
	j	beq_cont.18086
beq_then.18085:
	fneg	f1, f1
beq_cont.18086:
	fsw	f1, 2(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 1(r2)
	fdiv	f1, f1, f2
	fsw	f1, 3(r1)
beq_cont.18078:
	flw	f1, 2(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18087
	addi	r5, r0, 1
	j	feq_cont.18088
feq_else.18087:
	addi	r5, r0, 0
feq_cont.18088:
	beqi	0, r5, beq_then.18089
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 5(r1)
	j	beq_cont.18090
beq_then.18089:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 2(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18091
	addi	r7, r0, 0
	j	fle_cont.18092
fle_else.18091:
	addi	r7, r0, 1
fle_cont.18092:
	beqi	0, r6, beq_then.18093
	beqi	0, r7, beq_then.18095
	addi	r6, r0, 0
	j	beq_cont.18096
beq_then.18095:
	addi	r6, r0, 1
beq_cont.18096:
	j	beq_cont.18094
beq_then.18093:
	add	r6, r0, r7
beq_cont.18094:
	lw	r5, 4(r5)
	flw	f1, 2(r5)
	beqi	0, r6, beq_then.18097
	j	beq_cont.18098
beq_then.18097:
	fneg	f1, f1
beq_cont.18098:
	fsw	f1, 4(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 2(r2)
	fdiv	f1, f1, f2
	fsw	f1, 5(r1)
beq_cont.18090:
	jr	r31				#
setup_surface_table.3016:
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
	beq	r0, r30, fle_else.18099
	addi	r2, r0, 0
	j	fle_cont.18100
fle_else.18099:
	addi	r2, r0, 1
fle_cont.18100:
	beqi	0, r2, beq_then.18101
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
	j	beq_cont.18102
beq_then.18101:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
beq_cont.18102:
	jr	r31				#
setup_second_table.3019:
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
	jal	quadratic.2950				#	bl	quadratic.2950
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
	beqi	0, r6, beq_then.18103
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
	j	beq_cont.18104
beq_then.18103:
	fsw	f2, 1(r5)
	fsw	f3, 2(r5)
	fsw	f4, 3(r5)
beq_cont.18104:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18105
	addi	r1, r0, 1
	j	feq_cont.18106
feq_else.18105:
	addi	r1, r0, 0
feq_cont.18106:
	beqi	0, r1, beq_then.18107
	j	beq_cont.18108
beq_then.18107:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
	fsw	f1, 4(r5)
beq_cont.18108:
	add	r1, r0, r5
	jr	r31				#
iter_setup_dirvec_constants.3022:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.18109
	jr	r31				#
ble_then.18109:
	add	r30, r5, r2
	lw	r6, 0(r30)
	lw	r7, 1(r1)
	lw	r8, 0(r1)
	lw	r9, 1(r6)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	beqi	1, r9, beq_then.18111
	beqi	2, r9, beq_then.18113
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3019				#	bl	setup_second_table.3019
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18114
beq_then.18113:
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3016				#	bl	setup_surface_table.3016
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18114:
	j	beq_cont.18112
beq_then.18111:
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3013				#	bl	setup_rect_table.3013
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18112:
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18115
	jr	r31				#
ble_then.18115:
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 1(r3)
	lw	r6, 1(r5)
	lw	r7, 0(r5)
	lw	r8, 1(r2)
	beqi	1, r8, beq_then.18117
	beqi	2, r8, beq_then.18119
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_second_table.3019				#	bl	setup_second_table.3019
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18120
beq_then.18119:
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_surface_table.3016				#	bl	setup_surface_table.3016
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18120:
	j	beq_cont.18118
beq_then.18117:
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_rect_table.3013				#	bl	setup_rect_table.3013
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18118:
	addi	r2, r2, -1
	lw	r1, 1(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
setup_startp_constants.3027:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.18121
	jr	r31				#
ble_then.18121:
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
	beqi	2, r7, beq_then.18123
	blei	2, r7, ble_then.18125
	flw	f1, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 2(r6)
	sw	r6, 3(r3)
	sw	r7, 4(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	quadratic.2950				#	bl	quadratic.2950
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	beqi	3, r1, beq_then.18127
	j	beq_cont.18128
beq_then.18127:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.18128:
	lw	r1, 3(r3)
	fsw	f1, 3(r1)
	j	ble_cont.18126
ble_then.18125:
ble_cont.18126:
	j	beq_cont.18124
beq_then.18123:
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
beq_cont.18124:
	lw	r1, 2(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
is_rect_outside.3032:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18129
	j	fle_cont.18130
fle_else.18129:
	fneg	f1, f1
fle_cont.18130:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.18131
	addi	r2, r0, 0
	j	fle_cont.18132
fle_else.18131:
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18133
	j	fle_cont.18134
fle_else.18133:
	fneg	f2, f2
fle_cont.18134:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18135
	addi	r2, r0, 0
	j	fle_cont.18136
fle_else.18135:
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.18137
	fadd	f2, f0, f3
	j	fle_cont.18138
fle_else.18137:
	fneg	f2, f3
fle_cont.18138:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18139
	addi	r2, r0, 0
	j	fle_cont.18140
fle_else.18139:
	addi	r2, r0, 1
fle_cont.18140:
fle_cont.18136:
fle_cont.18132:
	beqi	0, r2, beq_then.18141
	lw	r1, 6(r1)
	jr	r31				#
beq_then.18141:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18142
	addi	r1, r0, 0
	jr	r31				#
beq_then.18142:
	addi	r1, r0, 1
	jr	r31				#
is_outside.3047:
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
	beqi	1, r2, beq_then.18143
	beqi	2, r2, beq_then.18144
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.2950				#	bl	quadratic.2950
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.18145
	j	beq_cont.18146
beq_then.18145:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.18146:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18147
	addi	r2, r0, 0
	j	fle_cont.18148
fle_else.18147:
	addi	r2, r0, 1
fle_cont.18148:
	beqi	0, r1, beq_then.18149
	beqi	0, r2, beq_then.18151
	addi	r1, r0, 0
	j	beq_cont.18152
beq_then.18151:
	addi	r1, r0, 1
beq_cont.18152:
	j	beq_cont.18150
beq_then.18149:
	add	r1, r0, r2
beq_cont.18150:
	beqi	0, r1, beq_then.18153
	addi	r1, r0, 0
	jr	r31				#
beq_then.18153:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18144:
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
	beq	r0, r30, fle_else.18154
	addi	r2, r0, 0
	j	fle_cont.18155
fle_else.18154:
	addi	r2, r0, 1
fle_cont.18155:
	beqi	0, r1, beq_then.18156
	beqi	0, r2, beq_then.18158
	addi	r1, r0, 0
	j	beq_cont.18159
beq_then.18158:
	addi	r1, r0, 1
beq_cont.18159:
	j	beq_cont.18157
beq_then.18156:
	add	r1, r0, r2
beq_cont.18157:
	beqi	0, r1, beq_then.18160
	addi	r1, r0, 0
	jr	r31				#
beq_then.18160:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18143:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18161
	j	fle_cont.18162
fle_else.18161:
	fneg	f1, f1
fle_cont.18162:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.18163
	addi	r2, r0, 0
	j	fle_cont.18164
fle_else.18163:
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18165
	j	fle_cont.18166
fle_else.18165:
	fneg	f2, f2
fle_cont.18166:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18167
	addi	r2, r0, 0
	j	fle_cont.18168
fle_else.18167:
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.18169
	fadd	f2, f0, f3
	j	fle_cont.18170
fle_else.18169:
	fneg	f2, f3
fle_cont.18170:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18171
	addi	r2, r0, 0
	j	fle_cont.18172
fle_else.18171:
	addi	r2, r0, 1
fle_cont.18172:
fle_cont.18168:
fle_cont.18164:
	beqi	0, r2, beq_then.18173
	lw	r1, 6(r1)
	jr	r31				#
beq_then.18173:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18174
	addi	r1, r0, 0
	jr	r31				#
beq_then.18174:
	addi	r1, r0, 1
	jr	r31				#
check_all_inside.3052:
	lw	r5, 1(r29)
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.18175
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
	beqi	1, r7, beq_then.18177
	beqi	2, r7, beq_then.18179
	sw	r6, 11(r3)
	add	r1, r0, r6				# mr	r1, r6
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	quadratic.2950				#	bl	quadratic.2950
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 11(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.18181
	j	beq_cont.18182
beq_then.18181:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.18182:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18183
	addi	r2, r0, 0
	j	fle_cont.18184
fle_else.18183:
	addi	r2, r0, 1
fle_cont.18184:
	beqi	0, r1, beq_then.18185
	beqi	0, r2, beq_then.18187
	addi	r1, r0, 0
	j	beq_cont.18188
beq_then.18187:
	addi	r1, r0, 1
beq_cont.18188:
	j	beq_cont.18186
beq_then.18185:
	add	r1, r0, r2
beq_cont.18186:
	beqi	0, r1, beq_then.18189
	addi	r1, r0, 0
	j	beq_cont.18190
beq_then.18189:
	addi	r1, r0, 1
beq_cont.18190:
	j	beq_cont.18180
beq_then.18179:
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
	beq	r0, r30, fle_else.18191
	addi	r7, r0, 0
	j	fle_cont.18192
fle_else.18191:
	addi	r7, r0, 1
fle_cont.18192:
	beqi	0, r6, beq_then.18193
	beqi	0, r7, beq_then.18195
	addi	r6, r0, 0
	j	beq_cont.18196
beq_then.18195:
	addi	r6, r0, 1
beq_cont.18196:
	j	beq_cont.18194
beq_then.18193:
	add	r6, r0, r7
beq_cont.18194:
	beqi	0, r6, beq_then.18197
	addi	r1, r0, 0
	j	beq_cont.18198
beq_then.18197:
	addi	r1, r0, 1
beq_cont.18198:
beq_cont.18180:
	j	beq_cont.18178
beq_then.18177:
	add	r1, r0, r6				# mr	r1, r6
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	is_rect_outside.3032				#	bl	is_rect_outside.3032
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.18178:
	beqi	0, r1, beq_then.18199
	addi	r1, r0, 0
	jr	r31				#
beq_then.18199:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18200
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
	jal	is_outside.3047				#	bl	is_outside.3047
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.18201
	addi	r1, r0, 0
	jr	r31				#
beq_then.18201:
	lw	r1, 12(r3)
	addi	r1, r1, 1
	flw	f1, 6(r3)
	flw	f2, 4(r3)
	flw	f3, 2(r3)
	lw	r2, 9(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18200:
	addi	r1, r0, 1
	jr	r31				#
beq_then.18175:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3058:
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
	beqi	-1, r14, beq_then.18202
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
	beqi	1, r16, beq_then.18203
	beqi	2, r16, beq_then.18205
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r6				# mr	r29, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.18206
beq_then.18205:
	flw	f4, 0(r12)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.18207
	addi	r5, r0, 0
	j	fle_cont.18208
fle_else.18207:
	addi	r5, r0, 1
fle_cont.18208:
	beqi	0, r5, beq_then.18209
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
	j	beq_cont.18210
beq_then.18209:
	addi	r1, r0, 0
beq_cont.18210:
beq_cont.18206:
	j	beq_cont.18204
beq_then.18203:
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
beq_cont.18204:
	lw	r2, 8(r3)
	flw	f1, 0(r2)
	beqi	0, r1, beq_then.18211
	flup	f2, 28		# fli	f2, -0.200000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18213
	addi	r1, r0, 0
	j	fle_cont.18214
fle_else.18213:
	addi	r1, r0, 1
fle_cont.18214:
	j	beq_cont.18212
beq_then.18211:
	addi	r1, r0, 0
beq_cont.18212:
	beqi	0, r1, beq_then.18215
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
	beqi	-1, r1, beq_then.18216
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
	jal	is_outside.3047				#	bl	is_outside.3047
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.18219
	addi	r1, r0, 0
	j	beq_cont.18220
beq_then.18219:
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
beq_cont.18220:
	j	beq_cont.18217
beq_then.18216:
	addi	r1, r0, 1
beq_cont.18217:
	beqi	0, r1, beq_then.18221
	addi	r1, r0, 1
	jr	r31				#
beq_then.18221:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18215:
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18222
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18222:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18202:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3061:
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.18223
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
	beqi	0, r1, beq_then.18224
	addi	r1, r0, 1
	jr	r31				#
beq_then.18224:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18225
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
	beqi	0, r1, beq_then.18226
	addi	r1, r0, 1
	jr	r31				#
beq_then.18226:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18227
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
	beqi	0, r1, beq_then.18228
	addi	r1, r0, 1
	jr	r31				#
beq_then.18228:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18229
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
	beqi	0, r1, beq_then.18230
	addi	r1, r0, 1
	jr	r31				#
beq_then.18230:
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18229:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18227:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18225:
	addi	r1, r0, 0
	jr	r31				#
beq_then.18223:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3064:
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
	beqi	-1, r16, beq_then.18231
	addi	r17, r0, 99
	sw	r9, 0(r3)
	sw	r10, 1(r3)
	sw	r14, 2(r3)
	sw	r15, 3(r3)
	sw	r2, 4(r3)
	sw	r29, 5(r3)
	sw	r1, 6(r3)
	beq	r16, r17, beq_then.18232
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
	beqi	1, r13, beq_then.18234
	beqi	2, r13, beq_then.18236
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r11				# mr	r1, r11
	add	r29, r0, r6				# mr	r29, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.18237
beq_then.18236:
	flw	f4, 0(r12)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.18238
	addi	r5, r0, 0
	j	fle_cont.18239
fle_else.18238:
	addi	r5, r0, 1
fle_cont.18239:
	beqi	0, r5, beq_then.18240
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
	j	beq_cont.18241
beq_then.18240:
	addi	r1, r0, 0
beq_cont.18241:
beq_cont.18237:
	j	beq_cont.18235
beq_then.18234:
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
beq_cont.18235:
	beqi	0, r1, beq_then.18242
	flup	f1, 30		# fli	f1, -0.100000
	lw	r1, 7(r3)
	flw	f2, 0(r1)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18244
	addi	r1, r0, 0
	j	fle_cont.18245
fle_else.18244:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18246
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
	beqi	0, r1, beq_then.18248
	addi	r1, r0, 1
	j	beq_cont.18249
beq_then.18248:
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18250
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
	beqi	0, r1, beq_then.18252
	addi	r1, r0, 1
	j	beq_cont.18253
beq_then.18252:
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.18254
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
	beqi	0, r1, beq_then.18256
	addi	r1, r0, 1
	j	beq_cont.18257
beq_then.18256:
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18257:
	j	beq_cont.18255
beq_then.18254:
	addi	r1, r0, 0
beq_cont.18255:
beq_cont.18253:
	j	beq_cont.18251
beq_then.18250:
	addi	r1, r0, 0
beq_cont.18251:
beq_cont.18249:
	j	beq_cont.18247
beq_then.18246:
	addi	r1, r0, 0
beq_cont.18247:
	beqi	0, r1, beq_then.18258
	addi	r1, r0, 1
	j	beq_cont.18259
beq_then.18258:
	addi	r1, r0, 0
beq_cont.18259:
fle_cont.18245:
	j	beq_cont.18243
beq_then.18242:
	addi	r1, r0, 0
beq_cont.18243:
	j	beq_cont.18233
beq_then.18232:
	addi	r1, r0, 1
beq_cont.18233:
	beqi	0, r1, beq_then.18260
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18261
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
	beqi	0, r1, beq_then.18263
	addi	r1, r0, 1
	j	beq_cont.18264
beq_then.18263:
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18265
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
	beqi	0, r1, beq_then.18267
	addi	r1, r0, 1
	j	beq_cont.18268
beq_then.18267:
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.18269
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
	beqi	0, r1, beq_then.18271
	addi	r1, r0, 1
	j	beq_cont.18272
beq_then.18271:
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18272:
	j	beq_cont.18270
beq_then.18269:
	addi	r1, r0, 0
beq_cont.18270:
beq_cont.18268:
	j	beq_cont.18266
beq_then.18265:
	addi	r1, r0, 0
beq_cont.18266:
beq_cont.18264:
	j	beq_cont.18262
beq_then.18261:
	addi	r1, r0, 0
beq_cont.18262:
	beqi	0, r1, beq_then.18273
	addi	r1, r0, 1
	jr	r31				#
beq_then.18273:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r29, 5(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18260:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r29, 5(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18231:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3067:
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
	beqi	-1, r17, beq_then.18274
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
	beqi	1, r19, beq_then.18275
	beqi	2, r19, beq_then.18277
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r18				# mr	r1, r18
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.18278
beq_then.18277:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r18				# mr	r1, r18
	add	r29, r0, r8				# mr	r29, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.18278:
	j	beq_cont.18276
beq_then.18275:
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
	beqi	0, r1, beq_then.18280
	addi	r1, r0, 1
	j	beq_cont.18281
beq_then.18280:
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
	beqi	0, r1, beq_then.18282
	addi	r1, r0, 2
	j	beq_cont.18283
beq_then.18282:
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
	beqi	0, r1, beq_then.18284
	addi	r1, r0, 3
	j	beq_cont.18285
beq_then.18284:
	addi	r1, r0, 0
beq_cont.18285:
beq_cont.18283:
beq_cont.18281:
beq_cont.18276:
	beqi	0, r1, beq_then.18286
	lw	r2, 6(r3)
	flw	f1, 0(r2)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18287
	j	fle_cont.18288
fle_else.18287:
	lw	r2, 5(r3)
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18289
	j	fle_cont.18290
fle_else.18289:
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
	sw	r1, 22(r3)
	fsw	f4, 24(r3)
	fsw	f3, 26(r3)
	fsw	f2, 28(r3)
	fsw	f1, 30(r3)
	beqi	-1, r7, beq_then.18292
	lw	r8, 12(r3)
	add	r30, r8, r7
	lw	r7, 0(r30)
	add	r1, r0, r7				# mr	r1, r7
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	is_outside.3047				#	bl	is_outside.3047
	addi	r3, r3, -33
	lw	r31, 32(r3)
	beqi	0, r1, beq_then.18294
	addi	r1, r0, 0
	j	beq_cont.18295
beq_then.18294:
	addi	r1, r0, 1
	flw	f1, 28(r3)
	flw	f2, 26(r3)
	flw	f3, 24(r3)
	lw	r2, 8(r3)
	lw	r29, 3(r3)
	sw	r31, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -33
	lw	r31, 32(r3)
beq_cont.18295:
	j	beq_cont.18293
beq_then.18292:
	addi	r1, r0, 1
beq_cont.18293:
	beqi	0, r1, beq_then.18296
	lw	r1, 5(r3)
	flw	f1, 30(r3)
	fsw	f1, 0(r1)
	lw	r1, 2(r3)
	flw	f1, 28(r3)
	fsw	f1, 0(r1)
	flw	f1, 26(r3)
	fsw	f1, 1(r1)
	flw	f1, 24(r3)
	fsw	f1, 2(r1)
	lw	r1, 1(r3)
	lw	r2, 11(r3)
	sw	r2, 0(r1)
	lw	r1, 0(r3)
	lw	r2, 22(r3)
	sw	r2, 0(r1)
	j	beq_cont.18297
beq_then.18296:
beq_cont.18297:
fle_cont.18290:
fle_cont.18288:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r29, 9(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18286:
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18298
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r29, 9(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18298:
	jr	r31				#
beq_then.18274:
	jr	r31				#
solve_one_or_network.3071:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.18301
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
	beqi	-1, r5, beq_then.18302
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
	beqi	-1, r5, beq_then.18303
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
	beqi	-1, r5, beq_then.18304
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
beq_then.18304:
	jr	r31				#
beq_then.18303:
	jr	r31				#
beq_then.18302:
	jr	r31				#
beq_then.18301:
	jr	r31				#
trace_or_matrix.3075:
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
	beqi	-1, r18, beq_then.18309
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
	beq	r18, r19, beq_then.18310
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
	beqi	1, r18, beq_then.18312
	beqi	2, r18, beq_then.18314
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.18315
beq_then.18314:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r8				# mr	r29, r8
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.18315:
	j	beq_cont.18313
beq_then.18312:
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
	beqi	0, r1, beq_then.18316
	addi	r1, r0, 1
	j	beq_cont.18317
beq_then.18316:
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
	beqi	0, r1, beq_then.18318
	addi	r1, r0, 2
	j	beq_cont.18319
beq_then.18318:
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
	beqi	0, r1, beq_then.18320
	addi	r1, r0, 3
	j	beq_cont.18321
beq_then.18320:
	addi	r1, r0, 0
beq_cont.18321:
beq_cont.18319:
beq_cont.18317:
beq_cont.18313:
	beqi	0, r1, beq_then.18322
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r2, 1(r3)
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18324
	j	fle_cont.18325
fle_else.18324:
	lw	r5, 11(r3)
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.18326
	lw	r7, 8(r3)
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r8, r0, 0
	lw	r9, 6(r3)
	lw	r29, 7(r3)
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
	lw	r1, 11(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18328
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
	beqi	-1, r2, beq_then.18330
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
	j	beq_cont.18331
beq_then.18330:
beq_cont.18331:
	j	beq_cont.18329
beq_then.18328:
beq_cont.18329:
	j	beq_cont.18327
beq_then.18326:
beq_cont.18327:
fle_cont.18325:
	j	beq_cont.18323
beq_then.18322:
beq_cont.18323:
	j	beq_cont.18311
beq_then.18310:
	lw	r8, 1(r17)
	beqi	-1, r8, beq_then.18332
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
	beqi	-1, r2, beq_then.18334
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
	beqi	-1, r2, beq_then.18336
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
	j	beq_cont.18337
beq_then.18336:
beq_cont.18337:
	j	beq_cont.18335
beq_then.18334:
beq_cont.18335:
	j	beq_cont.18333
beq_then.18332:
beq_cont.18333:
beq_cont.18311:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.18338
	addi	r7, r0, 99
	sw	r1, 20(r3)
	beq	r6, r7, beq_then.18339
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
	beqi	0, r1, beq_then.18341
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18343
	j	fle_cont.18344
fle_else.18343:
	lw	r1, 21(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18345
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
	beqi	-1, r2, beq_then.18347
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
	j	beq_cont.18348
beq_then.18347:
beq_cont.18348:
	j	beq_cont.18346
beq_then.18345:
beq_cont.18346:
fle_cont.18344:
	j	beq_cont.18342
beq_then.18341:
beq_cont.18342:
	j	beq_cont.18340
beq_then.18339:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.18349
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
	beqi	-1, r2, beq_then.18351
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
	j	beq_cont.18352
beq_then.18351:
beq_cont.18352:
	j	beq_cont.18350
beq_then.18349:
beq_cont.18350:
beq_cont.18340:
	lw	r1, 20(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 6(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18338:
	jr	r31				#
beq_then.18309:
	jr	r31				#
solve_each_element_fast.3081:
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
	beqi	-1, r17, beq_then.18355
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
	beqi	1, r21, beq_then.18356
	beqi	2, r21, beq_then.18358
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
	j	beq_cont.18359
beq_then.18358:
	flw	f1, 0(r20)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18360
	addi	r8, r0, 0
	j	fle_cont.18361
fle_else.18360:
	addi	r8, r0, 1
fle_cont.18361:
	beqi	0, r8, beq_then.18362
	flw	f1, 0(r20)
	flw	f2, 3(r19)
	fmul	f1, f1, f2
	fsw	f1, 0(r10)
	addi	r1, r0, 1
	j	beq_cont.18363
beq_then.18362:
	addi	r1, r0, 0
beq_cont.18363:
beq_cont.18359:
	j	beq_cont.18357
beq_then.18356:
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
beq_cont.18357:
	beqi	0, r1, beq_then.18364
	lw	r2, 7(r3)
	flw	f1, 0(r2)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18365
	j	fle_cont.18366
fle_else.18365:
	lw	r2, 6(r3)
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18367
	j	fle_cont.18368
fle_else.18367:
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
	beqi	-1, r6, beq_then.18370
	lw	r7, 13(r3)
	add	r30, r7, r6
	lw	r6, 0(r30)
	add	r1, r0, r6				# mr	r1, r6
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	is_outside.3047				#	bl	is_outside.3047
	addi	r3, r3, -25
	lw	r31, 24(r3)
	beqi	0, r1, beq_then.18372
	addi	r1, r0, 0
	j	beq_cont.18373
beq_then.18372:
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
beq_cont.18373:
	j	beq_cont.18371
beq_then.18370:
	addi	r1, r0, 1
beq_cont.18371:
	beqi	0, r1, beq_then.18374
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
	j	beq_cont.18375
beq_then.18374:
beq_cont.18375:
fle_cont.18368:
fle_cont.18366:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r29, 10(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18364:
	lw	r1, 12(r3)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18376
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r29, 10(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18376:
	jr	r31				#
beq_then.18355:
	jr	r31				#
solve_one_or_network_fast.3085:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.18379
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
	beqi	-1, r5, beq_then.18380
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
	beqi	-1, r5, beq_then.18381
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
	beqi	-1, r5, beq_then.18382
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
beq_then.18382:
	jr	r31				#
beq_then.18381:
	jr	r31				#
beq_then.18380:
	jr	r31				#
beq_then.18379:
	jr	r31				#
trace_or_matrix_fast.3089:
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
	beqi	-1, r16, beq_then.18387
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
	beq	r16, r17, beq_then.18388
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
	beqi	1, r18, beq_then.18390
	beqi	2, r18, beq_then.18392
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
	j	beq_cont.18393
beq_then.18392:
	flw	f1, 0(r16)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18394
	addi	r7, r0, 0
	j	fle_cont.18395
fle_else.18394:
	addi	r7, r0, 1
fle_cont.18395:
	beqi	0, r7, beq_then.18396
	flw	f1, 0(r16)
	flw	f2, 3(r17)
	fmul	f1, f1, f2
	fsw	f1, 0(r10)
	addi	r1, r0, 1
	j	beq_cont.18397
beq_then.18396:
	addi	r1, r0, 0
beq_cont.18397:
beq_cont.18393:
	j	beq_cont.18391
beq_then.18390:
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
beq_cont.18391:
	beqi	0, r1, beq_then.18398
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r2, 1(r3)
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18400
	j	fle_cont.18401
fle_else.18400:
	lw	r5, 10(r3)
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.18402
	lw	r7, 7(r3)
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r8, r0, 0
	lw	r9, 5(r3)
	lw	r29, 6(r3)
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 10(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18404
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
	beqi	-1, r2, beq_then.18406
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
	j	beq_cont.18407
beq_then.18406:
beq_cont.18407:
	j	beq_cont.18405
beq_then.18404:
beq_cont.18405:
	j	beq_cont.18403
beq_then.18402:
beq_cont.18403:
fle_cont.18401:
	j	beq_cont.18399
beq_then.18398:
beq_cont.18399:
	j	beq_cont.18389
beq_then.18388:
	lw	r7, 1(r15)
	beqi	-1, r7, beq_then.18408
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
	beqi	-1, r2, beq_then.18410
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
	beqi	-1, r2, beq_then.18412
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
	j	beq_cont.18413
beq_then.18412:
beq_cont.18413:
	j	beq_cont.18411
beq_then.18410:
beq_cont.18411:
	j	beq_cont.18409
beq_then.18408:
beq_cont.18409:
beq_cont.18389:
	lw	r1, 9(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.18414
	addi	r7, r0, 99
	sw	r1, 11(r3)
	beq	r6, r7, beq_then.18415
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
	beqi	0, r1, beq_then.18417
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18419
	j	fle_cont.18420
fle_else.18419:
	lw	r1, 12(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18421
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
	beqi	-1, r2, beq_then.18423
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
	j	beq_cont.18424
beq_then.18423:
beq_cont.18424:
	j	beq_cont.18422
beq_then.18421:
beq_cont.18422:
fle_cont.18420:
	j	beq_cont.18418
beq_then.18417:
beq_cont.18418:
	j	beq_cont.18416
beq_then.18415:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.18425
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
	beqi	-1, r2, beq_then.18427
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
	j	beq_cont.18428
beq_then.18427:
beq_cont.18428:
	j	beq_cont.18426
beq_then.18425:
beq_cont.18426:
beq_cont.18416:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 5(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18414:
	jr	r31				#
beq_then.18387:
	jr	r31				#
judge_intersection_fast.3093:
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
	beqi	-1, r13, beq_then.18431
	addi	r14, r0, 99
	sw	r1, 1(r3)
	sw	r10, 2(r3)
	sw	r2, 3(r3)
	beq	r13, r14, beq_then.18433
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
	beqi	0, r1, beq_then.18435
	lw	r1, 8(r3)
	flw	f1, 0(r1)
	lw	r1, 0(r3)
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18437
	j	fle_cont.18438
fle_else.18437:
	lw	r2, 7(r3)
	lw	r5, 1(r2)
	beqi	-1, r5, beq_then.18439
	lw	r6, 6(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0
	lw	r8, 1(r3)
	lw	r29, 5(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 7(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18441
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
	j	beq_cont.18442
beq_then.18441:
beq_cont.18442:
	j	beq_cont.18440
beq_then.18439:
beq_cont.18440:
fle_cont.18438:
	j	beq_cont.18436
beq_then.18435:
beq_cont.18436:
	j	beq_cont.18434
beq_then.18433:
	lw	r6, 1(r12)
	beqi	-1, r6, beq_then.18443
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
	beqi	-1, r2, beq_then.18445
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
	j	beq_cont.18446
beq_then.18445:
beq_cont.18446:
	j	beq_cont.18444
beq_then.18443:
beq_cont.18444:
beq_cont.18434:
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
	j	beq_cont.18432
beq_then.18431:
beq_cont.18432:
	lw	r1, 0(r3)
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18447
	addi	r1, r0, 0
	jr	r31				#
fle_else.18447:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18448
	addi	r1, r0, 0
	jr	r31				#
fle_else.18448:
	addi	r1, r0, 1
	jr	r31				#
get_nvector_second.3099:
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
	beqi	0, r5, beq_then.18449
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
	j	beq_cont.18450
beq_then.18449:
	fsw	f4, 0(r2)
	fsw	f5, 1(r2)
	fsw	f6, 2(r2)
beq_cont.18450:
	lw	r1, 6(r1)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	vecunit_sgn.2807
get_nvector.3101:
	lw	r5, 3(r29)
	lw	r6, 2(r29)
	lw	r29, 1(r29)
	lw	r7, 1(r1)
	beqi	1, r7, beq_then.18451
	beqi	2, r7, beq_then.18452
	lw	r28, 0(r29)
	jr	r28
beq_then.18452:
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
beq_then.18451:
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
	beq	r0, r30, feq_else.18454
	addi	r1, r0, 1
	j	feq_cont.18455
feq_else.18454:
	addi	r1, r0, 0
feq_cont.18455:
	beqi	0, r1, beq_then.18456
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18457
beq_then.18456:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18458
	addi	r1, r0, 0
	j	fle_cont.18459
fle_else.18458:
	addi	r1, r0, 1
fle_cont.18459:
	beqi	0, r1, beq_then.18460
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.18461
beq_then.18460:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.18461:
beq_cont.18457:
	fneg	f1, f1
	add	r30, r5, r6
	fsw	f1, 0(r30)
	jr	r31				#
utexture.3104:
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
	beqi	1, r6, beq_then.18463
	beqi	2, r6, beq_then.18464
	beqi	3, r6, beq_then.18465
	beqi	4, r6, beq_then.18466
	jr	r31				#
beq_then.18466:
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
	beq	r0, r30, fle_else.18468
	fadd	f5, f0, f1
	j	fle_cont.18469
fle_else.18468:
	fneg	f5, f1
fle_cont.18469:
	sw	r5, 0(r3)
	fsw	f3, 2(r3)
	sw	r1, 4(r3)
	sw	r2, 5(r3)
	fle	r30, f4, f5
	beq	r0, r30, fle_else.18471
	fdiv	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18473
	j	fle_cont.18474
fle_else.18473:
	fneg	f1, f1
fle_cont.18474:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18475
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.18476
fle_else.18475:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.18476:
	fmul	f1, f1, f2
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.18477
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f1
	beq	r0, r30, fle_else.18479
	flup	f4, 15		# fli	f4, 1.570796
	flup	f5, 2		# fli	f5, 1.000000
	fdiv	f1, f5, f1
	fsw	f2, 6(r3)
	fsw	f4, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2695				#	bl	atan_body.2695
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	flw	f2, 6(r3)
	fmul	f1, f1, f2
	j	fle_cont.18480
fle_else.18479:
	flup	f4, 16		# fli	f4, 0.785398
	flup	f5, 2		# fli	f5, 1.000000
	fsub	f5, f1, f5
	flup	f6, 2		# fli	f6, 1.000000
	fadd	f1, f1, f6
	fdiv	f1, f5, f1
	fsw	f2, 6(r3)
	fsw	f4, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	atan_body.2695				#	bl	atan_body.2695
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fadd	f1, f2, f1
	flw	f2, 6(r3)
	fmul	f1, f1, f2
fle_cont.18480:
	j	fle_cont.18478
fle_else.18477:
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	atan_body.2695				#	bl	atan_body.2695
	addi	r3, r3, -13
	lw	r31, 12(r3)
fle_cont.18478:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.18472
fle_else.18471:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.18472:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18481
	addi	r1, r0, 0
	j	feq_cont.18482
feq_else.18481:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18483
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.18484
fle_else.18483:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.18484:
feq_cont.18482:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18485
	j	fle_cont.18486
fle_else.18485:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.18486:
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
	beq	r0, r30, fle_else.18487
	fadd	f5, f0, f4
	j	fle_cont.18488
fle_else.18487:
	fneg	f5, f4
fle_cont.18488:
	fsw	f1, 12(r3)
	fle	r30, f3, f5
	beq	r0, r30, fle_else.18489
	fdiv	f2, f2, f4
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18491
	j	fle_cont.18492
fle_else.18491:
	fneg	f2, f2
fle_cont.18492:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18493
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.18494
fle_else.18493:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.18494:
	fmul	f2, f2, f3
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f2
	beq	r0, r30, fle_else.18495
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f2
	beq	r0, r30, fle_else.18497
	flup	f4, 15		# fli	f4, 1.570796
	flup	f5, 2		# fli	f5, 1.000000
	fdiv	f2, f5, f2
	fsw	f3, 14(r3)
	fsw	f4, 16(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2695				#	bl	atan_body.2695
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fadd	f1, f2, f1
	flw	f2, 14(r3)
	fmul	f1, f1, f2
	j	fle_cont.18498
fle_else.18497:
	flup	f4, 16		# fli	f4, 0.785398
	flup	f5, 2		# fli	f5, 1.000000
	fsub	f5, f2, f5
	flup	f6, 2		# fli	f6, 1.000000
	fadd	f2, f2, f6
	fdiv	f2, f5, f2
	fsw	f3, 14(r3)
	fsw	f4, 18(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	atan_body.2695				#	bl	atan_body.2695
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 18(r3)
	fadd	f1, f2, f1
	flw	f2, 14(r3)
	fmul	f1, f1, f2
fle_cont.18498:
	j	fle_cont.18496
fle_else.18495:
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	atan_body.2695				#	bl	atan_body.2695
	addi	r3, r3, -21
	lw	r31, 20(r3)
fle_cont.18496:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.18490
fle_else.18489:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.18490:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18499
	addi	r1, r0, 0
	j	feq_cont.18500
feq_else.18499:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18501
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.18502
fle_else.18501:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.18502:
feq_cont.18500:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18503
	j	fle_cont.18504
fle_else.18503:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.18504:
	fsub	f1, f1, f2
	flup	f2, 36		# fli	f2, 0.150000
	flup	f3, 1		# fli	f3, 0.500000
	flw	f4, 12(r3)
	fsub	f3, f3, f4
	fmul	f3, f3, f3
	fsub	f2, f2, f3
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f1, f3, f1
	fmul	f1, f1, f1
	fsub	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18505
	addi	r1, r0, 0
	j	fle_cont.18506
fle_else.18505:
	addi	r1, r0, 1
fle_cont.18506:
	beqi	0, r1, beq_then.18507
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18508
beq_then.18507:
beq_cont.18508:
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f2, f1
	flup	f2, 38		# fli	f2, 0.300000
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.18465:
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
	beq	r0, r30, feq_else.18510
	addi	r1, r0, 0
	j	feq_cont.18511
feq_else.18510:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18512
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.18513
fle_else.18512:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.18513:
feq_cont.18511:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18514
	j	fle_cont.18515
fle_else.18514:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.18515:
	fsub	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fmul	f1, f1, f2
	sw	r5, 0(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	cos.2693				#	bl	cos.2693
	addi	r3, r3, -21
	lw	r31, 20(r3)
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
beq_then.18464:
	flw	f1, 1(r2)
	flup	f2, 40		# fli	f2, 0.250000
	fmul	f1, f1, f2
	sw	r5, 0(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	sin.2691				#	bl	sin.2691
	addi	r3, r3, -21
	lw	r31, 20(r3)
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
beq_then.18463:
	flw	f1, 0(r2)
	lw	r6, 5(r1)
	flw	f2, 0(r6)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	feq	r30, f2, f0
	beq	r0, r30, feq_else.18518
	addi	r6, r0, 0
	j	feq_cont.18519
feq_else.18518:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18520
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r6, f3
	j	fle_cont.18521
fle_else.18520:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r6, f3
fle_cont.18521:
feq_cont.18519:
	itof	f3, r6
	fle	r30, f3, f2
	beq	r0, r30, fle_else.18522
	fadd	f2, f0, f3
	j	fle_cont.18523
fle_else.18522:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.18523:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.18524
	addi	r6, r0, 0
	j	fle_cont.18525
fle_else.18524:
	addi	r6, r0, 1
fle_cont.18525:
	flw	f1, 2(r2)
	lw	r1, 5(r1)
	flw	f2, 2(r1)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	feq	r30, f2, f0
	beq	r0, r30, feq_else.18526
	addi	r1, r0, 0
	j	feq_cont.18527
feq_else.18526:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18528
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r1, f3
	j	fle_cont.18529
fle_else.18528:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r1, f3
fle_cont.18529:
feq_cont.18527:
	itof	f3, r1
	fle	r30, f3, f2
	beq	r0, r30, fle_else.18530
	fadd	f2, f0, f3
	j	fle_cont.18531
fle_else.18530:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.18531:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.18532
	addi	r1, r0, 0
	j	fle_cont.18533
fle_else.18532:
	addi	r1, r0, 1
fle_cont.18533:
	beqi	0, r6, beq_then.18534
	beqi	0, r1, beq_then.18536
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.18537
beq_then.18536:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.18537:
	j	beq_cont.18535
beq_then.18534:
	beqi	0, r1, beq_then.18538
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18539
beq_then.18538:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.18539:
beq_cont.18535:
	fsw	f1, 1(r5)
	jr	r31				#
trace_reflections.3111:
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
	ble	r15, r1, ble_then.18541
	jr	r31				#
ble_then.18541:
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
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18544
	addi	r1, r0, 0
	j	fle_cont.18545
fle_else.18544:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18546
	addi	r1, r0, 0
	j	fle_cont.18547
fle_else.18546:
	addi	r1, r0, 1
fle_cont.18547:
fle_cont.18545:
	beqi	0, r1, beq_then.18548
	lw	r1, 16(r3)
	lw	r1, 0(r1)
	slli	r1, r1, 2
	lw	r2, 15(r3)
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 14(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.18550
	j	beq_cont.18551
beq_then.18550:
	addi	r1, r0, 0
	lw	r5, 13(r3)
	lw	r5, 0(r5)
	lw	r29, 12(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.18552
	j	beq_cont.18553
beq_then.18552:
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
	beq	r0, r30, fle_else.18554
	addi	r1, r0, 0
	j	fle_cont.18555
fle_else.18554:
	addi	r1, r0, 1
fle_cont.18555:
	beqi	0, r1, beq_then.18556
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
	j	beq_cont.18557
beq_then.18556:
beq_cont.18557:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.18558
	addi	r1, r0, 0
	j	fle_cont.18559
fle_else.18558:
	addi	r1, r0, 1
fle_cont.18559:
	beqi	0, r1, beq_then.18560
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
	j	beq_cont.18561
beq_then.18560:
beq_cont.18561:
beq_cont.18553:
beq_cont.18551:
	j	beq_cont.18549
beq_then.18548:
beq_cont.18549:
	lw	r1, 1(r3)
	addi	r1, r1, -1
	flw	f1, 8(r3)
	flw	f2, 2(r3)
	lw	r2, 6(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
trace_ray.3116:
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
	blei	4, r1, ble_then.18562
	jr	r31				#
ble_then.18562:
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
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18566
	addi	r2, r0, 0
	j	fle_cont.18567
fle_else.18566:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18568
	addi	r2, r0, 0
	j	fle_cont.18569
fle_else.18568:
	addi	r2, r0, 1
fle_cont.18569:
fle_cont.18567:
	beqi	0, r2, beq_then.18570
	lw	r2, 22(r3)
	lw	r2, 0(r2)
	lw	r5, 21(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 2(r5)
	lw	r7, 7(r5)
	flw	f1, 0(r7)
	flw	f2, 26(r3)
	fmul	f1, f1, f2
	lw	r7, 1(r5)
	sw	r6, 33(r3)
	fsw	f1, 34(r3)
	sw	r2, 36(r3)
	sw	r5, 37(r3)
	beqi	1, r7, beq_then.18571
	beqi	2, r7, beq_then.18573
	lw	r29, 18(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 38(r3)
	addi	r3, r3, 39
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -39
	lw	r31, 38(r3)
	j	beq_cont.18574
beq_then.18573:
	lw	r7, 4(r5)
	flw	f3, 0(r7)
	fneg	f3, f3
	lw	r7, 19(r3)
	fsw	f3, 0(r7)
	lw	r8, 4(r5)
	flw	f3, 1(r8)
	fneg	f3, f3
	fsw	f3, 1(r7)
	lw	r8, 4(r5)
	flw	f3, 2(r8)
	fneg	f3, f3
	fsw	f3, 2(r7)
beq_cont.18574:
	j	beq_cont.18572
beq_then.18571:
	lw	r7, 20(r3)
	lw	r8, 0(r7)
	flup	f3, 0		# fli	f3, 0.000000
	lw	r9, 19(r3)
	fsw	f3, 0(r9)
	fsw	f3, 1(r9)
	fsw	f3, 2(r9)
	addi	r10, r8, -1
	addi	r8, r8, -1
	lw	r11, 29(r3)
	add	r30, r11, r8
	flw	f3, 0(r30)
	feq	r30, f3, f0
	beq	r0, r30, feq_else.18575
	addi	r8, r0, 1
	j	feq_cont.18576
feq_else.18575:
	addi	r8, r0, 0
feq_cont.18576:
	beqi	0, r8, beq_then.18577
	flup	f3, 0		# fli	f3, 0.000000
	j	beq_cont.18578
beq_then.18577:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.18579
	addi	r8, r0, 0
	j	fle_cont.18580
fle_else.18579:
	addi	r8, r0, 1
fle_cont.18580:
	beqi	0, r8, beq_then.18581
	flup	f3, 2		# fli	f3, 1.000000
	j	beq_cont.18582
beq_then.18581:
	flup	f3, 11		# fli	f3, -1.000000
beq_cont.18582:
beq_cont.18578:
	fneg	f3, f3
	add	r30, r9, r10
	fsw	f3, 0(r30)
beq_cont.18572:
	lw	r2, 17(r3)
	flw	f1, 0(r2)
	lw	r1, 16(r3)
	fsw	f1, 0(r1)
	flw	f1, 1(r2)
	fsw	f1, 1(r1)
	flw	f1, 2(r2)
	fsw	f1, 2(r1)
	lw	r1, 37(r3)
	lw	r29, 15(r3)
	sw	r31, 38(r3)
	addi	r3, r3, 39
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -39
	lw	r31, 38(r3)
	lw	r1, 36(r3)
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
	flup	f1, 1		# fli	f1, 0.500000
	lw	r8, 37(r3)
	lw	r9, 7(r8)
	flw	f2, 0(r9)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18583
	lw	r9, 13(r3)
	add	r30, r6, r2
	sw	r9, 0(r30)
	lw	r6, 4(r1)
	add	r30, r6, r2
	lw	r9, 0(r30)
	lw	r10, 12(r3)
	flw	f1, 0(r10)
	fsw	f1, 0(r9)
	flw	f1, 1(r10)
	fsw	f1, 1(r9)
	flw	f1, 2(r10)
	fsw	f1, 2(r9)
	add	r30, r6, r2
	lw	r6, 0(r30)
	flup	f1, 43		# fli	f1, 0.003906
	flw	f2, 34(r3)
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
	lw	r9, 19(r3)
	flw	f1, 0(r9)
	fsw	f1, 0(r6)
	flw	f1, 1(r9)
	fsw	f1, 1(r6)
	flw	f1, 2(r9)
	fsw	f1, 2(r6)
	j	fle_cont.18584
fle_else.18583:
	lw	r9, 11(r3)
	add	r30, r6, r2
	sw	r9, 0(r30)
fle_cont.18584:
	flup	f1, 44		# fli	f1, -2.000000
	lw	r6, 29(r3)
	flw	f2, 0(r6)
	lw	r9, 19(r3)
	flw	f3, 0(r9)
	fmul	f2, f2, f3
	flw	f3, 1(r6)
	flw	f4, 1(r9)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flw	f3, 2(r6)
	flw	f4, 2(r9)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	fmul	f1, f1, f2
	flw	f2, 0(r6)
	flw	f3, 0(r9)
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fsw	f2, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 1(r9)
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fsw	f2, 1(r6)
	flw	f2, 2(r6)
	flw	f3, 2(r9)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	fsw	f1, 2(r6)
	lw	r10, 7(r8)
	flw	f1, 1(r10)
	flw	f2, 26(r3)
	fmul	f1, f2, f1
	addi	r10, r0, 0
	lw	r11, 10(r3)
	lw	r11, 0(r11)
	lw	r29, 9(r3)
	fsw	f1, 38(r3)
	add	r2, r0, r11				# mr	r2, r11
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
	beqi	0, r1, beq_then.18585
	j	beq_cont.18586
beq_then.18585:
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
	flw	f2, 34(r3)
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
	beq	r0, r30, fle_else.18587
	addi	r2, r0, 0
	j	fle_cont.18588
fle_else.18587:
	addi	r2, r0, 1
fle_cont.18588:
	beqi	0, r2, beq_then.18589
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
	j	beq_cont.18590
beq_then.18589:
beq_cont.18590:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.18591
	addi	r2, r0, 0
	j	fle_cont.18592
fle_else.18591:
	addi	r2, r0, 1
fle_cont.18592:
	beqi	0, r2, beq_then.18593
	fmul	f1, f3, f3
	fmul	f1, f1, f1
	flw	f3, 38(r3)
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
	j	beq_cont.18594
beq_then.18593:
beq_cont.18594:
beq_cont.18586:
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
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
	lw	r1, 2(r3)
	lw	r1, 0(r1)
	addi	r1, r1, -1
	flw	f1, 34(r3)
	flw	f2, 38(r3)
	lw	r2, 29(r3)
	lw	r29, 1(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
	flup	f1, 45		# fli	f1, 0.100000
	flw	f2, 26(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18595
	jr	r31				#
fle_else.18595:
	addi	r1, r0, 4
	lw	r2, 30(r3)
	ble	r1, r2, ble_then.18597
	addi	r1, r2, 1
	addi	r5, r0, -1
	lw	r6, 31(r3)
	add	r30, r6, r1
	sw	r5, 0(r30)
	j	ble_cont.18598
ble_then.18597:
ble_cont.18598:
	lw	r1, 33(r3)
	beqi	2, r1, beq_then.18599
	j	beq_cont.18600
beq_then.18599:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r1, 37(r3)
	lw	r1, 7(r1)
	flw	f3, 0(r1)
	fsub	f1, f1, f3
	fmul	f1, f2, f1
	addi	r1, r2, 1
	lw	r2, 32(r3)
	flw	f2, 0(r2)
	flw	f3, 4(r3)
	fadd	f2, f3, f2
	lw	r2, 29(r3)
	lw	r5, 14(r3)
	lw	r29, 0(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
beq_cont.18600:
	jr	r31				#
beq_then.18570:
	addi	r1, r0, -1
	lw	r2, 30(r3)
	lw	r5, 31(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	0, r2, beq_then.18602
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
	beq	r0, r30, fle_else.18603
	addi	r1, r0, 0
	j	fle_cont.18604
fle_else.18603:
	addi	r1, r0, 1
fle_cont.18604:
	beqi	0, r1, beq_then.18605
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
beq_then.18605:
	jr	r31				#
beq_then.18602:
	jr	r31				#
trace_diffuse_ray.3122:
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
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18609
	addi	r1, r0, 0
	j	fle_cont.18610
fle_else.18609:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18611
	addi	r1, r0, 0
	j	fle_cont.18612
fle_else.18611:
	addi	r1, r0, 1
fle_cont.18612:
fle_cont.18610:
	beqi	0, r1, beq_then.18613
	lw	r1, 14(r3)
	lw	r1, 0(r1)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 12(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	sw	r1, 16(r3)
	beqi	1, r5, beq_then.18614
	beqi	2, r5, beq_then.18616
	lw	r29, 9(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
	j	beq_cont.18617
beq_then.18616:
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
beq_cont.18617:
	j	beq_cont.18615
beq_then.18614:
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
	beq	r0, r30, feq_else.18618
	addi	r2, r0, 1
	j	feq_cont.18619
feq_else.18618:
	addi	r2, r0, 0
feq_cont.18619:
	beqi	0, r2, beq_then.18620
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18621
beq_then.18620:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18622
	addi	r2, r0, 0
	j	fle_cont.18623
fle_else.18622:
	addi	r2, r0, 1
fle_cont.18623:
	beqi	0, r2, beq_then.18624
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.18625
beq_then.18624:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.18625:
beq_cont.18621:
	fneg	f1, f1
	add	r30, r6, r7
	fsw	f1, 0(r30)
beq_cont.18615:
	lw	r1, 16(r3)
	lw	r2, 7(r3)
	lw	r29, 8(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
	addi	r1, r0, 0
	lw	r2, 6(r3)
	lw	r2, 0(r2)
	lw	r29, 5(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
	beqi	0, r1, beq_then.18626
	jr	r31				#
beq_then.18626:
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
	beq	r0, r30, fle_else.18628
	addi	r1, r0, 0
	j	fle_cont.18629
fle_else.18628:
	addi	r1, r0, 1
fle_cont.18629:
	beqi	0, r1, beq_then.18630
	j	beq_cont.18631
beq_then.18630:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.18631:
	flw	f2, 2(r3)
	fmul	f1, f2, f1
	lw	r1, 16(r3)
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
beq_then.18613:
	jr	r31				#
iter_trace_diffuse_rays.3125:
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
	ble	r20, r6, ble_then.18634
	jr	r31				#
ble_then.18634:
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
	beq	r0, r30, fle_else.18636
	addi	r20, r0, 0
	j	fle_cont.18637
fle_else.18636:
	addi	r20, r0, 1
fle_cont.18637:
	sw	r5, 0(r3)
	sw	r29, 1(r3)
	sw	r8, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	sw	r6, 5(r3)
	beqi	0, r20, beq_then.18638
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
	beqi	0, r1, beq_then.18640
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
	beqi	0, r1, beq_then.18642
	j	beq_cont.18643
beq_then.18642:
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
	beq	r0, r30, fle_else.18644
	addi	r1, r0, 0
	j	fle_cont.18645
fle_else.18644:
	addi	r1, r0, 1
fle_cont.18645:
	beqi	0, r1, beq_then.18646
	j	beq_cont.18647
beq_then.18646:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.18647:
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
beq_cont.18643:
	j	beq_cont.18641
beq_then.18640:
beq_cont.18641:
	j	beq_cont.18639
beq_then.18638:
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
	beqi	0, r1, beq_then.18649
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
	beqi	0, r1, beq_then.18651
	j	beq_cont.18652
beq_then.18651:
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
	beq	r0, r30, fle_else.18653
	addi	r1, r0, 0
	j	fle_cont.18654
fle_else.18653:
	addi	r1, r0, 1
fle_cont.18654:
	beqi	0, r1, beq_then.18655
	j	beq_cont.18656
beq_then.18655:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.18656:
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
beq_cont.18652:
	j	beq_cont.18650
beq_then.18649:
beq_cont.18650:
beq_cont.18639:
	lw	r1, 5(r3)
	addi	r1, r1, -2
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18657
	jr	r31				#
ble_then.18657:
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
	beq	r0, r30, fle_else.18659
	addi	r5, r0, 0
	j	fle_cont.18660
fle_else.18659:
	addi	r5, r0, 1
fle_cont.18660:
	sw	r1, 26(r3)
	beqi	0, r5, beq_then.18661
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
	j	beq_cont.18662
beq_then.18661:
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
beq_cont.18662:
	lw	r1, 26(r3)
	addi	r6, r1, -2
	lw	r1, 4(r3)
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
trace_diffuse_ray_80percent.3134:
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
	beqi	0, r1, beq_then.18663
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
	j	beq_cont.18664
beq_then.18663:
beq_cont.18664:
	lw	r1, 7(r3)
	beqi	1, r1, beq_then.18665
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
	j	beq_cont.18666
beq_then.18665:
beq_cont.18666:
	lw	r1, 7(r3)
	beqi	2, r1, beq_then.18667
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
	j	beq_cont.18668
beq_then.18667:
beq_cont.18668:
	lw	r1, 7(r3)
	beqi	3, r1, beq_then.18669
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
	j	beq_cont.18670
beq_then.18669:
beq_cont.18670:
	lw	r1, 7(r3)
	beqi	4, r1, beq_then.18671
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
beq_then.18671:
	jr	r31				#
calc_diffuse_using_1point.3138:
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
	beqi	0, r1, beq_then.18673
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
	beq	r0, r30, fle_else.18675
	addi	r2, r0, 0
	j	fle_cont.18676
fle_else.18675:
	addi	r2, r0, 1
fle_cont.18676:
	beqi	0, r2, beq_then.18677
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
	j	beq_cont.18678
beq_then.18677:
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
beq_cont.18678:
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
	j	beq_cont.18674
beq_then.18673:
beq_cont.18674:
	lw	r1, 12(r3)
	beqi	1, r1, beq_then.18679
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
	beq	r0, r30, fle_else.18681
	addi	r2, r0, 0
	j	fle_cont.18682
fle_else.18681:
	addi	r2, r0, 1
fle_cont.18682:
	beqi	0, r2, beq_then.18683
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
	j	beq_cont.18684
beq_then.18683:
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
beq_cont.18684:
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
	j	beq_cont.18680
beq_then.18679:
beq_cont.18680:
	lw	r1, 12(r3)
	beqi	2, r1, beq_then.18685
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
	beq	r0, r30, fle_else.18687
	addi	r2, r0, 0
	j	fle_cont.18688
fle_else.18687:
	addi	r2, r0, 1
fle_cont.18688:
	beqi	0, r2, beq_then.18689
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
	j	beq_cont.18690
beq_then.18689:
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
beq_cont.18690:
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
	j	beq_cont.18686
beq_then.18685:
beq_cont.18686:
	lw	r1, 12(r3)
	beqi	3, r1, beq_then.18691
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
	beq	r0, r30, fle_else.18693
	addi	r2, r0, 0
	j	fle_cont.18694
fle_else.18693:
	addi	r2, r0, 1
fle_cont.18694:
	beqi	0, r2, beq_then.18695
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
	j	beq_cont.18696
beq_then.18695:
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
beq_cont.18696:
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
	j	beq_cont.18692
beq_then.18691:
beq_cont.18692:
	lw	r1, 12(r3)
	beqi	4, r1, beq_then.18697
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
	beq	r0, r30, fle_else.18699
	addi	r2, r0, 0
	j	fle_cont.18700
fle_else.18699:
	addi	r2, r0, 1
fle_cont.18700:
	beqi	0, r2, beq_then.18701
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
	j	beq_cont.18702
beq_then.18701:
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
beq_cont.18702:
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
	j	beq_cont.18698
beq_then.18697:
beq_cont.18698:
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r1, 1(r3)
	lw	r5, 0(r3)
	j	vecaccumv.2831
calc_diffuse_using_5points.3141:
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
	j	vecaccumv.2831
do_without_neighbors.3147:
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	blei	4, r2, ble_then.18703
	jr	r31				#
ble_then.18703:
	lw	r9, 2(r1)
	addi	r10, r0, 0
	add	r30, r9, r2
	lw	r9, 0(r30)
	ble	r10, r9, ble_then.18705
	jr	r31				#
ble_then.18705:
	lw	r9, 3(r1)
	add	r30, r9, r2
	lw	r9, 0(r30)
	sw	r29, 0(r3)
	sw	r8, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	beqi	0, r9, beq_then.18707
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
	jal	vecaccumv.2831				#	bl	vecaccumv.2831
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.18708
beq_then.18707:
beq_cont.18708:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	blei	4, r2, ble_then.18709
	jr	r31				#
ble_then.18709:
	lw	r1, 2(r3)
	lw	r5, 2(r1)
	addi	r6, r0, 0
	add	r30, r5, r2
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.18711
	jr	r31				#
ble_then.18711:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 7(r3)
	beqi	0, r5, beq_then.18713
	lw	r29, 1(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.18714
beq_then.18713:
beq_cont.18714:
	lw	r1, 7(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
try_exploit_neighbors.3163:
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	add	r30, r6, r1
	lw	r12, 0(r30)
	blei	4, r8, ble_then.18715
	jr	r31				#
ble_then.18715:
	addi	r13, r0, 0
	lw	r14, 2(r12)
	add	r30, r14, r8
	lw	r14, 0(r30)
	ble	r13, r14, ble_then.18717
	jr	r31				#
ble_then.18717:
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
	beq	r14, r13, beq_then.18719
	addi	r13, r0, 0
	j	beq_cont.18720
beq_then.18719:
	add	r30, r7, r1
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.18721
	addi	r13, r0, 0
	j	beq_cont.18722
beq_then.18721:
	addi	r14, r1, -1
	add	r30, r6, r14
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.18723
	addi	r13, r0, 0
	j	beq_cont.18724
beq_then.18723:
	addi	r14, r1, 1
	add	r30, r6, r14
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.18725
	addi	r13, r0, 0
	j	beq_cont.18726
beq_then.18725:
	addi	r13, r0, 1
beq_cont.18726:
beq_cont.18724:
beq_cont.18722:
beq_cont.18720:
	beqi	0, r13, beq_then.18727
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
	beqi	0, r11, beq_then.18728
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
	j	beq_cont.18729
beq_then.18728:
beq_cont.18729:
	lw	r1, 8(r3)
	addi	r2, r1, 1
	lw	r1, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r1
	lw	r6, 0(r30)
	blei	4, r2, ble_then.18730
	jr	r31				#
ble_then.18730:
	addi	r7, r0, 0
	lw	r8, 2(r6)
	add	r30, r8, r2
	lw	r8, 0(r30)
	ble	r7, r8, ble_then.18732
	jr	r31				#
ble_then.18732:
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
	beq	r9, r7, beq_then.18734
	addi	r7, r0, 0
	j	beq_cont.18735
beq_then.18734:
	lw	r9, 4(r3)
	add	r30, r9, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.18736
	addi	r7, r0, 0
	j	beq_cont.18737
beq_then.18736:
	addi	r10, r1, -1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.18738
	addi	r7, r0, 0
	j	beq_cont.18739
beq_then.18738:
	addi	r10, r1, 1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.18740
	addi	r7, r0, 0
	j	beq_cont.18741
beq_then.18740:
	addi	r7, r0, 1
beq_cont.18741:
beq_cont.18739:
beq_cont.18737:
beq_cont.18735:
	beqi	0, r7, beq_then.18742
	lw	r6, 3(r6)
	add	r30, r6, r2
	lw	r6, 0(r30)
	sw	r2, 9(r3)
	beqi	0, r6, beq_then.18743
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
	j	beq_cont.18744
beq_then.18743:
beq_cont.18744:
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
beq_then.18742:
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r29, 3(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18727:
	add	r30, r6, r1
	lw	r1, 0(r30)
	blei	4, r8, ble_then.18745
	jr	r31				#
ble_then.18745:
	lw	r2, 2(r1)
	addi	r5, r0, 0
	add	r30, r2, r8
	lw	r2, 0(r30)
	ble	r5, r2, ble_then.18747
	jr	r31				#
ble_then.18747:
	lw	r2, 3(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	sw	r1, 10(r3)
	sw	r9, 3(r3)
	sw	r8, 8(r3)
	beqi	0, r2, beq_then.18749
	add	r2, r0, r8				# mr	r2, r8
	add	r29, r0, r11				# mr	r29, r11
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.18750
beq_then.18749:
beq_cont.18750:
	lw	r1, 8(r3)
	addi	r2, r1, 1
	lw	r1, 10(r3)
	lw	r29, 3(r3)
	lw	r28, 0(r29)
	jr	r28
write_rgb.3174:
	lw	r1, 1(r29)
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18751
	addi	r2, r0, 0
	j	feq_cont.18752
feq_else.18751:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18753
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.18754
fle_else.18753:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.18754:
feq_cont.18752:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.18755
	addi	r5, r0, 255
	j	ble_cont.18756
ble_then.18755:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.18757
	addi	r5, r0, 0
	j	ble_cont.18758
ble_then.18757:
	add	r5, r0, r2
ble_cont.18758:
ble_cont.18756:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	ble	r2, r5, ble_then.18759
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.18761
	addi	r2, r5, 48
	out	r2
	j	ble_cont.18762
ble_then.18761:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 1(r3)
	ble	r7, r5, ble_then.18763
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.18764
ble_then.18763:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.18765
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.18766
ble_then.18765:
	add	r1, r0, r6
ble_cont.18766:
ble_cont.18764:
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2723				#	bl	print_uint.2723
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
ble_cont.18762:
	j	ble_cont.18760
ble_then.18759:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.18767
	addi	r2, r5, 48
	out	r2
	j	ble_cont.18768
ble_then.18767:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 3(r3)
	ble	r7, r5, ble_then.18769
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.18770
ble_then.18769:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.18771
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.18772
ble_then.18771:
	add	r1, r0, r6
ble_cont.18772:
ble_cont.18770:
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	print_uint.2723				#	bl	print_uint.2723
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
ble_cont.18768:
ble_cont.18760:
	addi	r1, r0, 32
	out	r1
	lw	r1, 0(r3)
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18773
	addi	r2, r0, 0
	j	feq_cont.18774
feq_else.18773:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18775
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.18776
fle_else.18775:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.18776:
feq_cont.18774:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.18777
	addi	r5, r0, 255
	j	ble_cont.18778
ble_then.18777:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.18779
	addi	r5, r0, 0
	j	ble_cont.18780
ble_then.18779:
	add	r5, r0, r2
ble_cont.18780:
ble_cont.18778:
	addi	r2, r0, 0
	ble	r2, r5, ble_then.18781
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.18783
	addi	r2, r5, 48
	out	r2
	j	ble_cont.18784
ble_then.18783:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 5(r3)
	ble	r7, r5, ble_then.18785
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	ble_cont.18786
ble_then.18785:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.18787
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	ble_cont.18788
ble_then.18787:
	add	r1, r0, r6
ble_cont.18788:
ble_cont.18786:
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_uint.2723				#	bl	print_uint.2723
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
ble_cont.18784:
	j	ble_cont.18782
ble_then.18781:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.18789
	addi	r2, r5, 48
	out	r2
	j	ble_cont.18790
ble_then.18789:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 7(r3)
	ble	r7, r5, ble_then.18791
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	ble_cont.18792
ble_then.18791:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.18793
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	ble_cont.18794
ble_then.18793:
	add	r1, r0, r6
ble_cont.18794:
ble_cont.18792:
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	print_uint.2723				#	bl	print_uint.2723
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
ble_cont.18790:
ble_cont.18782:
	addi	r1, r0, 32
	out	r1
	lw	r1, 0(r3)
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18795
	addi	r1, r0, 0
	j	feq_cont.18796
feq_else.18795:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18797
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.18798
fle_else.18797:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.18798:
feq_cont.18796:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.18799
	addi	r1, r0, 255
	j	ble_cont.18800
ble_then.18799:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18801
	addi	r1, r0, 0
	j	ble_cont.18802
ble_then.18801:
ble_cont.18802:
ble_cont.18800:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18803
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	addi	r2, r0, 10
	ble	r2, r1, ble_then.18805
	addi	r1, r1, 48
	out	r1
	j	ble_cont.18806
ble_then.18805:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	sw	r1, 9(r3)
	ble	r6, r1, ble_then.18807
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	ble_cont.18808
ble_then.18807:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.18809
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	ble_cont.18810
ble_then.18809:
	add	r1, r0, r5
ble_cont.18810:
ble_cont.18808:
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	print_uint.2723				#	bl	print_uint.2723
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
ble_cont.18806:
	j	ble_cont.18804
ble_then.18803:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.18811
	addi	r1, r1, 48
	out	r1
	j	ble_cont.18812
ble_then.18811:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	sw	r1, 11(r3)
	ble	r6, r1, ble_then.18813
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.18814
ble_then.18813:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.18815
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.18816
ble_then.18815:
	add	r1, r0, r5
ble_cont.18816:
ble_cont.18814:
	sw	r1, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	print_uint.2723				#	bl	print_uint.2723
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
ble_cont.18812:
ble_cont.18804:
	addi	r1, r0, 10
	out	r1
	jr	r31				#
pretrace_diffuse_rays.3176:
	lw	r5, 7(r29)
	lw	r6, 6(r29)
	lw	r7, 5(r29)
	lw	r8, 4(r29)
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	blei	4, r2, ble_then.18817
	jr	r31				#
ble_then.18817:
	lw	r12, 2(r1)
	add	r30, r12, r2
	lw	r12, 0(r30)
	addi	r13, r0, 0
	ble	r13, r12, ble_then.18819
	jr	r31				#
ble_then.18819:
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
	beqi	0, r12, beq_then.18821
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
	j	beq_cont.18822
beq_then.18821:
beq_cont.18822:
	lw	r2, 8(r3)
	addi	r2, r2, 1
	blei	4, r2, ble_then.18823
	jr	r31				#
ble_then.18823:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 0
	ble	r6, r5, ble_then.18825
	jr	r31				#
ble_then.18825:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 13(r3)
	beqi	0, r5, beq_then.18827
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
	beq	r0, r30, fle_else.18829
	addi	r2, r0, 0
	j	fle_cont.18830
fle_else.18829:
	addi	r2, r0, 1
fle_cont.18830:
	beqi	0, r2, beq_then.18831
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
	j	beq_cont.18832
beq_then.18831:
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
beq_cont.18832:
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
	j	beq_cont.18828
beq_then.18827:
beq_cont.18828:
	lw	r2, 13(r3)
	addi	r2, r2, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_pixels.3179:
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
	ble	r23, r2, ble_then.18833
	jr	r31				#
ble_then.18833:
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
	jal	vecunit_sgn.2807				#	bl	vecunit_sgn.2807
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
	ble	r8, r7, ble_then.18835
	j	ble_cont.18836
ble_then.18835:
	lw	r7, 3(r5)
	lw	r7, 0(r7)
	sw	r5, 23(r3)
	beqi	0, r7, beq_then.18837
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
	beq	r0, r30, fle_else.18839
	addi	r2, r0, 0
	j	fle_cont.18840
fle_else.18839:
	addi	r2, r0, 1
fle_cont.18840:
	beqi	0, r2, beq_then.18841
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
	j	beq_cont.18842
beq_then.18841:
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
beq_cont.18842:
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
	j	beq_cont.18838
beq_then.18837:
beq_cont.18838:
	addi	r2, r0, 1
	lw	r1, 23(r3)
	lw	r29, 7(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
ble_cont.18836:
	lw	r1, 18(r3)
	addi	r2, r1, -1
	lw	r1, 15(r3)
	addi	r1, r1, 1
	addi	r5, r0, 5
	ble	r5, r1, ble_then.18843
	add	r5, r0, r1
	j	ble_cont.18844
ble_then.18843:
	addi	r5, r1, -5
ble_cont.18844:
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r1, 19(r3)
	lw	r29, 6(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_line.3186:
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
scan_pixel.3190:
	lw	r8, 7(r29)
	lw	r9, 6(r29)
	lw	r10, 5(r29)
	lw	r11, 4(r29)
	lw	r12, 3(r29)
	lw	r13, 2(r29)
	lw	r14, 1(r29)
	lw	r15, 0(r11)
	ble	r15, r1, ble_then.18845
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
	ble	r15, r16, ble_then.18846
	blei	0, r2, ble_then.18848
	lw	r15, 0(r11)
	addi	r16, r1, 1
	ble	r15, r16, ble_then.18850
	blei	0, r1, ble_then.18852
	addi	r15, r0, 1
	j	ble_cont.18853
ble_then.18852:
	addi	r15, r0, 0
ble_cont.18853:
	j	ble_cont.18851
ble_then.18850:
	addi	r15, r0, 0
ble_cont.18851:
	j	ble_cont.18849
ble_then.18848:
	addi	r15, r0, 0
ble_cont.18849:
	j	ble_cont.18847
ble_then.18846:
	addi	r15, r0, 0
ble_cont.18847:
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
	beqi	0, r15, beq_then.18854
	addi	r14, r0, 0
	add	r30, r6, r1
	lw	r15, 0(r30)
	addi	r16, r0, 0
	lw	r17, 2(r15)
	lw	r17, 0(r17)
	ble	r16, r17, ble_then.18856
	j	ble_cont.18857
ble_then.18856:
	add	r30, r6, r1
	lw	r16, 0(r30)
	lw	r16, 2(r16)
	lw	r16, 0(r16)
	add	r30, r5, r1
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.18858
	addi	r16, r0, 0
	j	beq_cont.18859
beq_then.18858:
	add	r30, r7, r1
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.18860
	addi	r16, r0, 0
	j	beq_cont.18861
beq_then.18860:
	addi	r17, r1, -1
	add	r30, r6, r17
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.18862
	addi	r16, r0, 0
	j	beq_cont.18863
beq_then.18862:
	addi	r17, r1, 1
	add	r30, r6, r17
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.18864
	addi	r16, r0, 0
	j	beq_cont.18865
beq_then.18864:
	addi	r16, r0, 1
beq_cont.18865:
beq_cont.18863:
beq_cont.18861:
beq_cont.18859:
	beqi	0, r16, beq_then.18866
	lw	r15, 3(r15)
	lw	r15, 0(r15)
	beqi	0, r15, beq_then.18868
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
	j	beq_cont.18869
beq_then.18868:
beq_cont.18869:
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
	j	beq_cont.18867
beq_then.18866:
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
beq_cont.18867:
ble_cont.18857:
	j	beq_cont.18855
beq_then.18854:
	add	r30, r6, r1
	lw	r13, 0(r30)
	addi	r15, r0, 0
	lw	r16, 2(r13)
	addi	r17, r0, 0
	lw	r16, 0(r16)
	ble	r17, r16, ble_then.18870
	j	ble_cont.18871
ble_then.18870:
	lw	r16, 3(r13)
	lw	r16, 0(r16)
	sw	r13, 11(r3)
	beqi	0, r16, beq_then.18872
	add	r2, r0, r15				# mr	r2, r15
	add	r1, r0, r13				# mr	r1, r13
	add	r29, r0, r14				# mr	r29, r14
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.18873
beq_then.18872:
beq_cont.18873:
	addi	r2, r0, 1
	lw	r1, 11(r3)
	lw	r29, 5(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.18871:
beq_cont.18855:
	lw	r1, 10(r3)
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18874
	addi	r2, r0, 0
	j	feq_cont.18875
feq_else.18874:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18876
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.18877
fle_else.18876:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.18877:
feq_cont.18875:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.18878
	addi	r2, r0, 255
	j	ble_cont.18879
ble_then.18878:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.18880
	addi	r2, r0, 0
	j	ble_cont.18881
ble_then.18880:
ble_cont.18881:
ble_cont.18879:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.18882
	addi	r5, r0, 45
	out	r5
	sub	r2, r0, r2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2723				#	bl	print_uint.2723
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.18883
ble_then.18882:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2723				#	bl	print_uint.2723
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.18883:
	addi	r1, r0, 32
	out	r1
	lw	r1, 10(r3)
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18884
	addi	r2, r0, 0
	j	feq_cont.18885
feq_else.18884:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18886
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.18887
fle_else.18886:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.18887:
feq_cont.18885:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.18888
	addi	r2, r0, 255
	j	ble_cont.18889
ble_then.18888:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.18890
	addi	r2, r0, 0
	j	ble_cont.18891
ble_then.18890:
ble_cont.18891:
ble_cont.18889:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.18892
	addi	r5, r0, 45
	out	r5
	sub	r2, r0, r2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2723				#	bl	print_uint.2723
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.18893
ble_then.18892:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2723				#	bl	print_uint.2723
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.18893:
	addi	r1, r0, 32
	out	r1
	lw	r1, 10(r3)
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18894
	addi	r2, r0, 0
	j	feq_cont.18895
feq_else.18894:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18896
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.18897
fle_else.18896:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.18897:
feq_cont.18895:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.18898
	addi	r2, r0, 255
	j	ble_cont.18899
ble_then.18898:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.18900
	addi	r2, r0, 0
	j	ble_cont.18901
ble_then.18900:
ble_cont.18901:
ble_cont.18899:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.18902
	addi	r5, r0, 45
	out	r5
	sub	r2, r0, r2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2723				#	bl	print_uint.2723
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.18903
ble_then.18902:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2723				#	bl	print_uint.2723
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.18903:
	addi	r1, r0, 10
	out	r1
	lw	r1, 9(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 0(r2)
	ble	r5, r1, ble_then.18904
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
	ble	r5, r8, ble_then.18905
	blei	0, r7, ble_then.18907
	lw	r2, 0(r2)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.18909
	blei	0, r1, ble_then.18911
	addi	r2, r0, 1
	j	ble_cont.18912
ble_then.18911:
	addi	r2, r0, 0
ble_cont.18912:
	j	ble_cont.18910
ble_then.18909:
	addi	r2, r0, 0
ble_cont.18910:
	j	ble_cont.18908
ble_then.18907:
	addi	r2, r0, 0
ble_cont.18908:
	j	ble_cont.18906
ble_then.18905:
	addi	r2, r0, 0
ble_cont.18906:
	sw	r1, 12(r3)
	beqi	0, r2, beq_then.18913
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
	j	beq_cont.18914
beq_then.18913:
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
beq_cont.18914:
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
ble_then.18904:
	jr	r31				#
ble_then.18845:
	jr	r31				#
scan_line.3196:
	lw	r8, 7(r29)
	lw	r9, 6(r29)
	lw	r10, 5(r29)
	lw	r11, 4(r29)
	lw	r12, 3(r29)
	lw	r13, 2(r29)
	lw	r14, 1(r29)
	lw	r15, 1(r13)
	ble	r15, r1, ble_then.18917
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
	ble	r15, r1, ble_then.18918
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
	j	ble_cont.18919
ble_then.18918:
ble_cont.18919:
	addi	r1, r0, 0
	lw	r2, 12(r3)
	lw	r5, 0(r2)
	blei	0, r5, ble_then.18920
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
	ble	r5, r8, ble_then.18922
	blei	0, r7, ble_then.18924
	lw	r5, 0(r2)
	blei	1, r5, ble_then.18926
	addi	r5, r0, 0
	j	ble_cont.18927
ble_then.18926:
	addi	r5, r0, 0
ble_cont.18927:
	j	ble_cont.18925
ble_then.18924:
	addi	r5, r0, 0
ble_cont.18925:
	j	ble_cont.18923
ble_then.18922:
	addi	r5, r0, 0
ble_cont.18923:
	beqi	0, r5, beq_then.18928
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
	j	beq_cont.18929
beq_then.18928:
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
beq_cont.18929:
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
	j	ble_cont.18921
ble_then.18920:
ble_cont.18921:
	lw	r1, 9(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	addi	r1, r1, 2
	addi	r5, r0, 5
	ble	r5, r1, ble_then.18930
	add	r5, r0, r1
	j	ble_cont.18931
ble_then.18930:
	addi	r5, r1, -5
ble_cont.18931:
	lw	r1, 12(r3)
	lw	r6, 1(r1)
	ble	r6, r2, ble_then.18932
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r5, 13(r3)
	sw	r2, 14(r3)
	ble	r1, r2, ble_then.18934
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
	j	ble_cont.18935
ble_then.18934:
ble_cont.18935:
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
	ble	r5, r2, ble_then.18936
	add	r7, r0, r2
	j	ble_cont.18937
ble_then.18936:
	addi	r7, r2, -5
ble_cont.18937:
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
	j	ble_cont.18933
ble_then.18932:
ble_cont.18933:
	jr	r31				#
ble_then.18917:
	jr	r31				#
create_float5x3array.3202:
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
init_line_elements.3206:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.18940
	jr	r31				#
ble_then.18940:
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
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
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
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
	addi	r3, r3, -9
	lw	r31, 8(r3)
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
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
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
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
	ble	r2, r1, ble_then.18941
	add	r1, r0, r5
	jr	r31				#
ble_then.18941:
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
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
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
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
	addi	r3, r3, -17
	lw	r31, 16(r3)
	sw	r1, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
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
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
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
calc_dirvec.3216:
	lw	r6, 1(r29)
	addi	r7, r0, 5
	ble	r7, r1, ble_then.18942
	fmul	f1, f2, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f1, f1, f2
	fsqrt	f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f2, f2, f1
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18943
	flup	f5, 2		# fli	f5, 1.000000
	j	fle_cont.18944
fle_else.18943:
	flup	f5, 11		# fli	f5, -1.000000
fle_cont.18944:
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
	beq	r0, r30, fle_else.18947
	flup	f6, 24		# fli	f6, 2.437500
	fle	r30, f6, f2
	beq	r0, r30, fle_else.18949
	flup	f6, 15		# fli	f6, 1.570796
	flup	f7, 2		# fli	f7, 1.000000
	fdiv	f2, f7, f2
	fsw	f5, 12(r3)
	fsw	f6, 14(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2695				#	bl	atan_body.2695
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	flw	f2, 12(r3)
	fmul	f1, f1, f2
	j	fle_cont.18950
fle_else.18949:
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
	jal	atan_body.2695				#	bl	atan_body.2695
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fadd	f1, f2, f1
	flw	f2, 12(r3)
	fmul	f1, f1, f2
fle_cont.18950:
	j	fle_cont.18948
fle_else.18947:
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2695				#	bl	atan_body.2695
	addi	r3, r3, -19
	lw	r31, 18(r3)
fle_cont.18948:
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	fsw	f1, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	sin.2691				#	bl	sin.2691
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 18(r3)
	fsw	f1, 20(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	cos.2693				#	bl	cos.2693
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
	beq	r0, r30, fle_else.18951
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.18952
fle_else.18951:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.18952:
	fmul	f3, f3, f4
	flup	f5, 23		# fli	f5, 4.375000
	fsw	f1, 22(r3)
	sw	r1, 24(r3)
	fsw	f2, 26(r3)
	fle	r30, f5, f3
	beq	r0, r30, fle_else.18954
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f3
	beq	r0, r30, fle_else.18956
	flup	f5, 15		# fli	f5, 1.570796
	flup	f6, 2		# fli	f6, 1.000000
	fdiv	f3, f6, f3
	fsw	f4, 28(r3)
	fsw	f5, 30(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	atan_body.2695				#	bl	atan_body.2695
	addi	r3, r3, -33
	lw	r31, 32(r3)
	flw	f2, 30(r3)
	fadd	f1, f2, f1
	flw	f2, 28(r3)
	fmul	f1, f1, f2
	j	fle_cont.18957
fle_else.18956:
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
	jal	atan_body.2695				#	bl	atan_body.2695
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flw	f2, 32(r3)
	fadd	f1, f2, f1
	flw	f2, 28(r3)
	fmul	f1, f1, f2
fle_cont.18957:
	j	fle_cont.18955
fle_else.18954:
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	atan_body.2695				#	bl	atan_body.2695
	addi	r3, r3, -35
	lw	r31, 34(r3)
fle_cont.18955:
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	fsw	f1, 34(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	sin.2691				#	bl	sin.2691
	addi	r3, r3, -37
	lw	r31, 36(r3)
	flw	f2, 34(r3)
	fsw	f1, 36(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 38(r3)
	addi	r3, r3, 39
	jal	cos.2693				#	bl	cos.2693
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
ble_then.18942:
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
calc_dirvecs.3224:
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.18959
	jr	r31				#
ble_then.18959:
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
	ble	r5, r2, ble_then.18962
	j	ble_cont.18963
ble_then.18962:
	addi	r2, r2, -5
ble_cont.18963:
	flw	f1, 2(r3)
	lw	r5, 6(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
calc_dirvec_rows.3229:
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.18964
	jr	r31				#
ble_then.18964:
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
	ble	r5, r2, ble_then.18966
	j	ble_cont.18967
ble_then.18966:
	addi	r2, r2, -5
ble_cont.18967:
	lw	r5, 2(r3)
	addi	r5, r5, 4
	addi	r6, r0, 0
	ble	r6, r1, ble_then.18968
	jr	r31				#
ble_then.18968:
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
	ble	r5, r2, ble_then.18970
	j	ble_cont.18971
ble_then.18970:
	addi	r2, r2, -5
ble_cont.18971:
	lw	r5, 5(r3)
	addi	r5, r5, 4
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
create_dirvec_elements.3235:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.18972
	jr	r31				#
ble_then.18972:
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
	ble	r2, r1, ble_then.18974
	jr	r31				#
ble_then.18974:
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
	ble	r2, r1, ble_then.18976
	jr	r31				#
ble_then.18976:
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
	ble	r2, r1, ble_then.18978
	jr	r31				#
ble_then.18978:
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
create_dirvecs.3238:
	lw	r2, 3(r29)
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.18980
	jr	r31				#
ble_then.18980:
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
	ble	r2, r1, ble_then.18982
	jr	r31				#
ble_then.18982:
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
init_dirvec_constants.3240:
	lw	r5, 3(r29)
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	addi	r8, r0, 0
	ble	r8, r2, ble_then.18984
	jr	r31				#
ble_then.18984:
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
	ble	r2, r1, ble_then.18986
	jr	r31				#
ble_then.18986:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	lw	r7, 0(r6)
	addi	r7, r7, -1
	addi	r8, r0, 0
	sw	r1, 6(r3)
	ble	r8, r7, ble_then.18988
	j	ble_cont.18989
ble_then.18988:
	lw	r8, 2(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r5)
	lw	r11, 0(r5)
	lw	r12, 1(r9)
	sw	r5, 7(r3)
	beqi	1, r12, beq_then.18990
	beqi	2, r12, beq_then.18992
	sw	r7, 8(r3)
	sw	r10, 9(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_second_table.3019				#	bl	setup_second_table.3019
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18993
beq_then.18992:
	sw	r7, 8(r3)
	sw	r10, 9(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_surface_table.3016				#	bl	setup_surface_table.3016
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18993:
	j	beq_cont.18991
beq_then.18990:
	sw	r7, 8(r3)
	sw	r10, 9(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_rect_table.3013				#	bl	setup_rect_table.3013
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18991:
	addi	r2, r2, -1
	lw	r1, 7(r3)
	lw	r29, 1(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
ble_cont.18989:
	lw	r1, 6(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18994
	jr	r31				#
ble_then.18994:
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
	ble	r2, r1, ble_then.18996
	jr	r31				#
ble_then.18996:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r1, 11(r3)
	ble	r7, r6, ble_then.18998
	j	ble_cont.18999
ble_then.18998:
	lw	r7, 2(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 12(r3)
	beqi	1, r10, beq_then.19000
	beqi	2, r10, beq_then.19002
	sw	r6, 13(r3)
	sw	r8, 14(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	setup_second_table.3019				#	bl	setup_second_table.3019
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19003
beq_then.19002:
	sw	r6, 13(r3)
	sw	r8, 14(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	setup_surface_table.3016				#	bl	setup_surface_table.3016
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19003:
	j	beq_cont.19001
beq_then.19000:
	sw	r6, 13(r3)
	sw	r8, 14(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	setup_rect_table.3013				#	bl	setup_rect_table.3013
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19001:
	addi	r2, r2, -1
	lw	r1, 12(r3)
	lw	r29, 1(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -16
	lw	r31, 15(r3)
ble_cont.18999:
	lw	r1, 11(r3)
	addi	r2, r1, -1
	lw	r1, 4(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
init_vecset_constants.3243:
	lw	r2, 5(r29)
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	addi	r9, r0, 0
	ble	r9, r1, ble_then.19004
	jr	r31				#
ble_then.19004:
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
	ble	r12, r11, ble_then.19006
	j	ble_cont.19007
ble_then.19006:
	add	r30, r2, r11
	lw	r12, 0(r30)
	lw	r13, 1(r10)
	lw	r14, 0(r10)
	lw	r15, 1(r12)
	sw	r10, 8(r3)
	beqi	1, r15, beq_then.19008
	beqi	2, r15, beq_then.19010
	sw	r11, 9(r3)
	sw	r13, 10(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r14				# mr	r1, r14
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_second_table.3019				#	bl	setup_second_table.3019
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19011
beq_then.19010:
	sw	r11, 9(r3)
	sw	r13, 10(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r14				# mr	r1, r14
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_surface_table.3016				#	bl	setup_surface_table.3016
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19011:
	j	beq_cont.19009
beq_then.19008:
	sw	r11, 9(r3)
	sw	r13, 10(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r14				# mr	r1, r14
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_rect_table.3013				#	bl	setup_rect_table.3013
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19009:
	addi	r2, r2, -1
	lw	r1, 8(r3)
	lw	r29, 5(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
ble_cont.19007:
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
	ble	r7, r6, ble_then.19012
	j	ble_cont.19013
ble_then.19012:
	lw	r7, 4(r3)
	add	r30, r7, r6
	lw	r8, 0(r30)
	lw	r9, 1(r2)
	lw	r10, 0(r2)
	lw	r11, 1(r8)
	sw	r2, 11(r3)
	beqi	1, r11, beq_then.19014
	beqi	2, r11, beq_then.19016
	sw	r6, 12(r3)
	sw	r9, 13(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_second_table.3019				#	bl	setup_second_table.3019
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19017
beq_then.19016:
	sw	r6, 12(r3)
	sw	r9, 13(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_surface_table.3016				#	bl	setup_surface_table.3016
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19017:
	j	beq_cont.19015
beq_then.19014:
	sw	r6, 12(r3)
	sw	r9, 13(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_rect_table.3013				#	bl	setup_rect_table.3013
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19015:
	addi	r2, r2, -1
	lw	r1, 11(r3)
	lw	r29, 5(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
ble_cont.19013:
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
	ble	r2, r1, ble_then.19018
	jr	r31				#
ble_then.19018:
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
	ble	r7, r6, ble_then.19020
	j	ble_cont.19021
ble_then.19020:
	lw	r7, 4(r3)
	add	r30, r7, r6
	lw	r8, 0(r30)
	lw	r9, 1(r2)
	lw	r10, 0(r2)
	lw	r11, 1(r8)
	sw	r2, 16(r3)
	beqi	1, r11, beq_then.19022
	beqi	2, r11, beq_then.19024
	sw	r6, 17(r3)
	sw	r9, 18(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_second_table.3019				#	bl	setup_second_table.3019
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19025
beq_then.19024:
	sw	r6, 17(r3)
	sw	r9, 18(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_surface_table.3016				#	bl	setup_surface_table.3016
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19025:
	j	beq_cont.19023
beq_then.19022:
	sw	r6, 17(r3)
	sw	r9, 18(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_rect_table.3013				#	bl	setup_rect_table.3013
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19023:
	addi	r2, r2, -1
	lw	r1, 16(r3)
	lw	r29, 5(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
ble_cont.19021:
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
	ble	r2, r1, ble_then.19026
	jr	r31				#
ble_then.19026:
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
	ble	r8, r7, ble_then.19028
	j	ble_cont.19029
ble_then.19028:
	lw	r8, 4(r3)
	add	r30, r8, r7
	lw	r8, 0(r30)
	lw	r9, 1(r6)
	lw	r10, 0(r6)
	lw	r11, 1(r8)
	sw	r6, 21(r3)
	beqi	1, r11, beq_then.19030
	beqi	2, r11, beq_then.19032
	sw	r7, 22(r3)
	sw	r9, 23(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	setup_second_table.3019				#	bl	setup_second_table.3019
	addi	r3, r3, -25
	lw	r31, 24(r3)
	lw	r2, 22(r3)
	lw	r5, 23(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19033
beq_then.19032:
	sw	r7, 22(r3)
	sw	r9, 23(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	setup_surface_table.3016				#	bl	setup_surface_table.3016
	addi	r3, r3, -25
	lw	r31, 24(r3)
	lw	r2, 22(r3)
	lw	r5, 23(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19033:
	j	beq_cont.19031
beq_then.19030:
	sw	r7, 22(r3)
	sw	r9, 23(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	setup_rect_table.3013				#	bl	setup_rect_table.3013
	addi	r3, r3, -25
	lw	r31, 24(r3)
	lw	r2, 22(r3)
	lw	r5, 23(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19031:
	addi	r2, r2, -1
	lw	r1, 21(r3)
	lw	r29, 5(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -25
	lw	r31, 24(r3)
ble_cont.19029:
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
	ble	r2, r1, ble_then.19034
	jr	r31				#
ble_then.19034:
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
setup_rect_reflection.3254:
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
	ble	r8, r7, ble_then.19038
	j	ble_cont.19039
ble_then.19038:
	lw	r8, 13(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r9)
	beqi	1, r10, beq_then.19040
	beqi	2, r10, beq_then.19042
	sw	r7, 23(r3)
	sw	r1, 24(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_second_table.3019				#	bl	setup_second_table.3019
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 24(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19043
beq_then.19042:
	sw	r7, 23(r3)
	sw	r1, 24(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_surface_table.3016				#	bl	setup_surface_table.3016
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 24(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19043:
	j	beq_cont.19041
beq_then.19040:
	sw	r7, 23(r3)
	sw	r1, 24(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_rect_table.3013				#	bl	setup_rect_table.3013
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 24(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19041:
	addi	r2, r2, -1
	lw	r1, 22(r3)
	lw	r29, 12(r3)
	sw	r31, 25(r3)
	addi	r3, r3, 26
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -26
	lw	r31, 25(r3)
ble_cont.19039:
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
	ble	r8, r7, ble_then.19045
	j	ble_cont.19046
ble_then.19045:
	lw	r8, 13(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r9)
	beqi	1, r10, beq_then.19047
	beqi	2, r10, beq_then.19049
	sw	r7, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_second_table.3019				#	bl	setup_second_table.3019
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19050
beq_then.19049:
	sw	r7, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_surface_table.3016				#	bl	setup_surface_table.3016
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19050:
	j	beq_cont.19048
beq_then.19047:
	sw	r7, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_rect_table.3013				#	bl	setup_rect_table.3013
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19048:
	addi	r2, r2, -1
	lw	r1, 31(r3)
	lw	r29, 12(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -35
	lw	r31, 34(r3)
ble_cont.19046:
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
	ble	r7, r6, ble_then.19051
	j	ble_cont.19052
ble_then.19051:
	lw	r7, 13(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.19053
	beqi	2, r8, beq_then.19055
	sw	r6, 40(r3)
	sw	r1, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	setup_second_table.3019				#	bl	setup_second_table.3019
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 40(r3)
	lw	r5, 41(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19056
beq_then.19055:
	sw	r6, 40(r3)
	sw	r1, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	setup_surface_table.3016				#	bl	setup_surface_table.3016
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 40(r3)
	lw	r5, 41(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19056:
	j	beq_cont.19054
beq_then.19053:
	sw	r6, 40(r3)
	sw	r1, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	setup_rect_table.3013				#	bl	setup_rect_table.3013
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 40(r3)
	lw	r5, 41(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19054:
	addi	r2, r2, -1
	lw	r1, 39(r3)
	lw	r29, 12(r3)
	sw	r31, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -43
	lw	r31, 42(r3)
ble_cont.19052:
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
setup_surface_reflection.3257:
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
	ble	r7, r6, ble_then.19058
	j	ble_cont.19059
ble_then.19058:
	lw	r7, 7(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.19060
	beqi	2, r8, beq_then.19062
	sw	r6, 17(r3)
	sw	r1, 18(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_second_table.3019				#	bl	setup_second_table.3019
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19063
beq_then.19062:
	sw	r6, 17(r3)
	sw	r1, 18(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_surface_table.3016				#	bl	setup_surface_table.3016
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19063:
	j	beq_cont.19061
beq_then.19060:
	sw	r6, 17(r3)
	sw	r1, 18(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_rect_table.3013				#	bl	setup_rect_table.3013
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19061:
	addi	r2, r2, -1
	lw	r1, 16(r3)
	lw	r29, 6(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
ble_cont.19059:
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
rt.3262:
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
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
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
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
	addi	r3, r3, -31
	lw	r31, 30(r3)
	sw	r1, 30(r3)
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
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
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
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
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
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
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
	addi	r3, r3, -40
	lw	r31, 39(r3)
	sw	r1, 39(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
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
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
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
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
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
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
	addi	r3, r3, -49
	lw	r31, 48(r3)
	sw	r1, 48(r3)
	sw	r31, 49(r3)
	addi	r3, r3, 50
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
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
	jal	create_float5x3array.3202				#	bl	create_float5x3array.3202
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
	beqi	0, r1, beq_then.19065
	addi	r1, r0, 1
	lw	r29, 17(r3)
	sw	r31, 53(r3)
	addi	r3, r3, 54
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -54
	lw	r31, 53(r3)
	j	beq_cont.19066
beq_then.19065:
	lw	r1, 18(r3)
	lw	r2, 52(r3)
	sw	r2, 0(r1)
beq_cont.19066:
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
	jal	read_or_network.2923				#	bl	read_or_network.2923
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
	ble	r2, r5, ble_then.19067
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.19069
	addi	r2, r5, 48
	out	r2
	j	ble_cont.19070
ble_then.19069:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 53(r3)
	ble	r7, r5, ble_then.19071
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 54(r3)
	addi	r3, r3, 55
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -55
	lw	r31, 54(r3)
	j	ble_cont.19072
ble_then.19071:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.19073
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 54(r3)
	addi	r3, r3, 55
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -55
	lw	r31, 54(r3)
	j	ble_cont.19074
ble_then.19073:
	add	r1, r0, r6
ble_cont.19074:
ble_cont.19072:
	sw	r1, 54(r3)
	sw	r31, 55(r3)
	addi	r3, r3, 56
	jal	print_uint.2723				#	bl	print_uint.2723
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
ble_cont.19070:
	j	ble_cont.19068
ble_then.19067:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.19075
	addi	r2, r5, 48
	out	r2
	j	ble_cont.19076
ble_then.19075:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 55(r3)
	ble	r7, r5, ble_then.19077
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 56(r3)
	addi	r3, r3, 57
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -57
	lw	r31, 56(r3)
	j	ble_cont.19078
ble_then.19077:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.19079
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 56(r3)
	addi	r3, r3, 57
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -57
	lw	r31, 56(r3)
	j	ble_cont.19080
ble_then.19079:
	add	r1, r0, r6
ble_cont.19080:
ble_cont.19078:
	sw	r1, 56(r3)
	sw	r31, 57(r3)
	addi	r3, r3, 58
	jal	print_uint.2723				#	bl	print_uint.2723
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
ble_cont.19076:
ble_cont.19068:
	addi	r1, r0, 32
	out	r1
	lw	r1, 23(r3)
	lw	r5, 1(r1)
	addi	r2, r0, 0
	ble	r2, r5, ble_then.19081
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.19083
	addi	r2, r5, 48
	out	r2
	j	ble_cont.19084
ble_then.19083:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 57(r3)
	ble	r7, r5, ble_then.19085
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 58(r3)
	addi	r3, r3, 59
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -59
	lw	r31, 58(r3)
	j	ble_cont.19086
ble_then.19085:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.19087
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 58(r3)
	addi	r3, r3, 59
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -59
	lw	r31, 58(r3)
	j	ble_cont.19088
ble_then.19087:
	add	r1, r0, r6
ble_cont.19088:
ble_cont.19086:
	sw	r1, 58(r3)
	sw	r31, 59(r3)
	addi	r3, r3, 60
	jal	print_uint.2723				#	bl	print_uint.2723
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
ble_cont.19084:
	j	ble_cont.19082
ble_then.19081:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.19089
	addi	r2, r5, 48
	out	r2
	j	ble_cont.19090
ble_then.19089:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 59(r3)
	ble	r7, r5, ble_then.19091
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 60(r3)
	addi	r3, r3, 61
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -61
	lw	r31, 60(r3)
	j	ble_cont.19092
ble_then.19091:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.19093
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 60(r3)
	addi	r3, r3, 61
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -61
	lw	r31, 60(r3)
	j	ble_cont.19094
ble_then.19093:
	add	r1, r0, r6
ble_cont.19094:
ble_cont.19092:
	sw	r1, 60(r3)
	sw	r31, 61(r3)
	addi	r3, r3, 62
	jal	print_uint.2723				#	bl	print_uint.2723
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
ble_cont.19090:
ble_cont.19082:
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 255
	addi	r2, r0, 0
	addi	r5, r0, 127
	sw	r1, 61(r3)
	sw	r31, 62(r3)
	addi	r3, r3, 63
	jal	div10_sub.2703				#	bl	div10_sub.2703
	addi	r3, r3, -63
	lw	r31, 62(r3)
	sw	r1, 62(r3)
	sw	r31, 63(r3)
	addi	r3, r3, 64
	jal	print_uint.2723				#	bl	print_uint.2723
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
	ble	r8, r7, ble_then.19095
	j	ble_cont.19096
ble_then.19095:
	lw	r8, 11(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r5)
	lw	r11, 0(r5)
	lw	r12, 1(r9)
	sw	r5, 64(r3)
	beqi	1, r12, beq_then.19097
	beqi	2, r12, beq_then.19099
	sw	r7, 65(r3)
	sw	r10, 66(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 67(r3)
	addi	r3, r3, 68
	jal	setup_second_table.3019				#	bl	setup_second_table.3019
	addi	r3, r3, -68
	lw	r31, 67(r3)
	lw	r2, 65(r3)
	lw	r5, 66(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.19100
beq_then.19099:
	sw	r7, 65(r3)
	sw	r10, 66(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 67(r3)
	addi	r3, r3, 68
	jal	setup_surface_table.3016				#	bl	setup_surface_table.3016
	addi	r3, r3, -68
	lw	r31, 67(r3)
	lw	r2, 65(r3)
	lw	r5, 66(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19100:
	j	beq_cont.19098
beq_then.19097:
	sw	r7, 65(r3)
	sw	r10, 66(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 67(r3)
	addi	r3, r3, 68
	jal	setup_rect_table.3013				#	bl	setup_rect_table.3013
	addi	r3, r3, -68
	lw	r31, 67(r3)
	lw	r2, 65(r3)
	lw	r5, 66(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.19098:
	addi	r2, r2, -1
	lw	r1, 64(r3)
	lw	r29, 10(r3)
	sw	r31, 67(r3)
	addi	r3, r3, 68
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -68
	lw	r31, 67(r3)
ble_cont.19096:
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
	ble	r2, r1, ble_then.19101
	j	ble_cont.19102
ble_then.19101:
	lw	r2, 11(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.19103
	j	beq_cont.19104
beq_then.19103:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 7(r2)
	flw	f2, 0(r5)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.19105
	j	fle_cont.19106
fle_else.19105:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.19107
	beqi	2, r5, beq_then.19109
	j	beq_cont.19110
beq_then.19109:
	lw	r29, 3(r3)
	sw	r31, 67(r3)
	addi	r3, r3, 68
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -68
	lw	r31, 67(r3)
beq_cont.19110:
	j	beq_cont.19108
beq_then.19107:
	lw	r29, 4(r3)
	sw	r31, 67(r3)
	addi	r3, r3, 68
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -68
	lw	r31, 67(r3)
beq_cont.19108:
fle_cont.19106:
beq_cont.19104:
ble_cont.19102:
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r1, 42(r3)
	lw	r29, 2(r3)
	sw	r31, 67(r3)
	addi	r3, r3, 68
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -68
	lw	r31, 67(r3)
	addi	r2, r0, 0
	addi	r5, r0, 2
	lw	r1, 23(r3)
	lw	r6, 1(r1)
	blei	0, r6, ble_then.19111
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r2, 67(r3)
	blei	0, r1, ble_then.19112
	addi	r1, r0, 1
	lw	r6, 51(r3)
	lw	r29, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 68(r3)
	addi	r3, r3, 69
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -69
	lw	r31, 68(r3)
	j	ble_cont.19113
ble_then.19112:
ble_cont.19113:
	addi	r1, r0, 0
	lw	r2, 67(r3)
	lw	r5, 33(r3)
	lw	r6, 42(r3)
	lw	r7, 51(r3)
	lw	r29, 1(r3)
	sw	r31, 68(r3)
	addi	r3, r3, 69
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -69
	lw	r31, 68(r3)
	addi	r1, r0, 1
	addi	r7, r0, 4
	lw	r2, 42(r3)
	lw	r5, 51(r3)
	lw	r6, 33(r3)
	lw	r29, 0(r3)
	sw	r31, 68(r3)
	addi	r3, r3, 69
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -69
	lw	r31, 68(r3)
	jr	r31				#
ble_then.19111:
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
	addi	r5, r0, read_screen_settings.2908
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
	addi	r10, r0, read_light.2910
	sw	r10, 0(r9)
	lw	r10, 6(r3)
	sw	r10, 2(r9)
	lw	r11, 7(r3)
	sw	r11, 1(r9)
	add	r12, r0, r4
	addi	r4, r4, 2
	addi	r13, r0, read_nth_object.2915
	sw	r13, 0(r12)
	lw	r13, 3(r3)
	sw	r13, 1(r12)
	add	r14, r0, r4
	addi	r4, r4, 3
	addi	r15, r0, read_object.2917
	sw	r15, 0(r14)
	sw	r12, 2(r14)
	lw	r15, 2(r3)
	sw	r15, 1(r14)
	add	r16, r0, r4
	addi	r4, r4, 2
	addi	r17, r0, read_and_network.2925
	sw	r17, 0(r16)
	lw	r17, 9(r3)
	sw	r17, 1(r16)
	add	r18, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, solver_rect_surface.2929
	sw	r19, 0(r18)
	lw	r19, 12(r3)
	sw	r19, 1(r18)
	add	r20, r0, r4
	addi	r4, r4, 2
	addi	r21, r0, solver_surface.2944
	sw	r21, 0(r20)
	sw	r19, 1(r20)
	add	r21, r0, r4
	addi	r4, r4, 2
	addi	r22, r0, solver_second.2963
	sw	r22, 0(r21)
	sw	r19, 1(r21)
	add	r22, r0, r4
	addi	r4, r4, 5
	addi	r23, r0, solver.2969
	sw	r23, 0(r22)
	sw	r21, 4(r22)
	sw	r18, 3(r22)
	sw	r19, 2(r22)
	sw	r13, 1(r22)
	add	r23, r0, r4
	addi	r4, r4, 2
	addi	r24, r0, solver_rect_fast.2973
	sw	r24, 0(r23)
	sw	r19, 1(r23)
	add	r24, r0, r4
	addi	r4, r4, 2
	addi	r25, r0, solver_second_fast.2986
	sw	r25, 0(r24)
	sw	r19, 1(r24)
	add	r25, r0, r4
	addi	r4, r4, 2
	addi	r26, r0, solver_second_fast2.3003
	sw	r26, 0(r25)
	sw	r19, 1(r25)
	add	r26, r0, r4
	addi	r4, r4, 5
	addi	r27, r0, solver_fast2.3010
	sw	r27, 0(r26)
	sw	r25, 4(r26)
	sw	r23, 3(r26)
	sw	r19, 2(r26)
	sw	r13, 1(r26)
	add	r27, r0, r4
	addi	r4, r4, 2
	addi	r28, r0, iter_setup_dirvec_constants.3022
	sw	r28, 0(r27)
	sw	r13, 1(r27)
	add	r28, r0, r4
	addi	r4, r4, 2
	addi	r29, r0, setup_startp_constants.3027
	sw	r29, 0(r28)
	sw	r13, 1(r28)
	add	r29, r0, r4
	addi	r4, r4, 2
	sw	r16, 38(r3)
	addi	r16, r0, check_all_inside.3052
	sw	r16, 0(r29)
	sw	r13, 1(r29)
	add	r16, r0, r4
	addi	r4, r4, 10
	sw	r9, 39(r3)
	addi	r9, r0, shadow_check_and_group.3058
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
	addi	r27, r0, shadow_check_one_or_group.3061
	sw	r27, 0(r2)
	sw	r16, 2(r2)
	sw	r17, 1(r2)
	add	r27, r0, r4
	addi	r4, r4, 11
	addi	r7, r0, shadow_check_one_or_matrix.3064
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
	addi	r7, r0, solve_each_element.3067
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
	addi	r6, r0, solve_one_or_network.3071
	sw	r6, 0(r9)
	sw	r2, 2(r9)
	sw	r17, 1(r9)
	add	r6, r0, r4
	addi	r4, r4, 12
	addi	r8, r0, trace_or_matrix.3075
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
	addi	r8, r0, solve_each_element_fast.3081
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
	addi	r18, r0, solve_one_or_network_fast.3085
	sw	r18, 0(r9)
	sw	r2, 2(r9)
	sw	r17, 1(r9)
	add	r18, r0, r4
	addi	r4, r4, 10
	addi	r20, r0, trace_or_matrix_fast.3089
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
	addi	r21, r0, judge_intersection_fast.3093
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
	addi	r17, r0, get_nvector_second.3099
	sw	r17, 0(r9)
	lw	r17, 17(r3)
	sw	r17, 2(r9)
	sw	r12, 1(r9)
	add	r19, r0, r4
	addi	r4, r4, 4
	addi	r21, r0, get_nvector.3101
	sw	r21, 0(r19)
	sw	r17, 3(r19)
	sw	r16, 2(r19)
	sw	r9, 1(r19)
	add	r21, r0, r4
	addi	r4, r4, 2
	addi	r22, r0, utexture.3104
	sw	r22, 0(r21)
	lw	r22, 18(r3)
	sw	r22, 1(r21)
	add	r23, r0, r4
	addi	r4, r4, 11
	addi	r25, r0, trace_reflections.3111
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
	addi	r26, r0, trace_ray.3116
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
	addi	r23, r0, trace_diffuse_ray.3122
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
	addi	r16, r0, iter_trace_diffuse_rays.3125
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
	addi	r16, r0, trace_diffuse_ray_80percent.3134
	sw	r16, 0(r12)
	sw	r8, 5(r12)
	sw	r28, 4(r12)
	sw	r15, 3(r12)
	sw	r9, 2(r12)
	lw	r16, 31(r3)
	sw	r16, 1(r12)
	add	r17, r0, r4
	addi	r4, r4, 9
	addi	r18, r0, calc_diffuse_using_1point.3138
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
	addi	r19, r0, calc_diffuse_using_5points.3141
	sw	r19, 0(r18)
	sw	r25, 2(r18)
	sw	r7, 1(r18)
	add	r19, r0, r4
	addi	r4, r4, 5
	addi	r20, r0, do_without_neighbors.3147
	sw	r20, 0(r19)
	sw	r12, 4(r19)
	sw	r25, 3(r19)
	sw	r7, 2(r19)
	sw	r17, 1(r19)
	add	r12, r0, r4
	addi	r4, r4, 4
	addi	r20, r0, try_exploit_neighbors.3163
	sw	r20, 0(r12)
	sw	r19, 3(r12)
	sw	r18, 2(r12)
	sw	r17, 1(r12)
	add	r20, r0, r4
	addi	r4, r4, 2
	addi	r21, r0, write_rgb.3174
	sw	r21, 0(r20)
	sw	r25, 1(r20)
	add	r21, r0, r4
	addi	r4, r4, 8
	addi	r22, r0, pretrace_diffuse_rays.3176
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
	addi	r23, r0, pretrace_pixels.3179
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
	addi	r9, r0, pretrace_line.3186
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
	addi	r14, r0, scan_pixel.3190
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
	addi	r17, r0, scan_line.3196
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
	addi	r17, r0, init_line_elements.3206
	sw	r17, 0(r12)
	sw	r6, 1(r12)
	add	r17, r0, r4
	addi	r4, r4, 2
	addi	r18, r0, calc_dirvec.3216
	sw	r18, 0(r17)
	sw	r16, 1(r17)
	add	r18, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, calc_dirvecs.3224
	sw	r19, 0(r18)
	sw	r17, 1(r18)
	add	r17, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, calc_dirvec_rows.3229
	sw	r19, 0(r17)
	sw	r18, 1(r17)
	add	r18, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, create_dirvec_elements.3235
	sw	r19, 0(r18)
	sw	r15, 1(r18)
	add	r19, r0, r4
	addi	r4, r4, 4
	addi	r20, r0, create_dirvecs.3238
	sw	r20, 0(r19)
	sw	r15, 3(r19)
	sw	r16, 2(r19)
	sw	r18, 1(r19)
	add	r18, r0, r4
	addi	r4, r4, 4
	addi	r20, r0, init_dirvec_constants.3240
	sw	r20, 0(r18)
	sw	r13, 3(r18)
	sw	r15, 2(r18)
	lw	r20, 43(r3)
	sw	r20, 1(r18)
	add	r21, r0, r4
	addi	r4, r4, 6
	addi	r22, r0, init_vecset_constants.3243
	sw	r22, 0(r21)
	sw	r13, 5(r21)
	sw	r15, 4(r21)
	sw	r20, 3(r21)
	sw	r18, 2(r21)
	sw	r16, 1(r21)
	add	r22, r0, r4
	addi	r4, r4, 7
	addi	r23, r0, setup_rect_reflection.3254
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
	addi	r25, r0, setup_surface_reflection.3257
	sw	r25, 0(r24)
	sw	r23, 6(r24)
	sw	r13, 5(r24)
	sw	r1, 4(r24)
	sw	r15, 3(r24)
	sw	r10, 2(r24)
	sw	r20, 1(r24)
	add	r29, r0, r4
	addi	r4, r4, 28
	addi	r1, r0, rt.3262
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
