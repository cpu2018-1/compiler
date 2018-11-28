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
hoge.2724:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15345
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15346
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15347
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15348
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15349
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15350
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15351
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15352
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2724
fle_else.15352:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15351:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15350:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15349:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15348:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15347:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15346:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15345:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2727:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15353
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15354
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15355
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15356
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2727
fle_else.15356:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2727
fle_else.15355:
	jr	r31				#
fle_else.15354:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15357
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15358
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2727
fle_else.15358:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2727
fle_else.15357:
	jr	r31				#
fle_else.15353:
	jr	r31				#
sin.2737:
	flup	f2, 14		# fli	f2, 3.141593
	flup	f3, 0		# fli	f3, 0.000000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15359
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.15360
fle_else.15359:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.15360:
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
	beq	r0, r30, fle_else.15361
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15363
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15365
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15367
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15369
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15371
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2724				#	bl	hoge.2724
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.15372
fle_else.15371:
fle_cont.15372:
	j	fle_cont.15370
fle_else.15369:
fle_cont.15370:
	j	fle_cont.15368
fle_else.15367:
fle_cont.15368:
	j	fle_cont.15366
fle_else.15365:
fle_cont.15366:
	j	fle_cont.15364
fle_else.15363:
fle_cont.15364:
	j	fle_cont.15362
fle_else.15361:
fle_cont.15362:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2727				#	bl	fuga.2727
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15373
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15374
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15375
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
fle_else.15375:
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
fle_else.15374:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15376
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
fle_else.15376:
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
fle_else.15373:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15377
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15378
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
fle_else.15378:
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
fle_else.15377:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15379
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
fle_else.15379:
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
cos.2739:
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
	beq	r0, r30, fle_else.15380
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15382
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15384
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15386
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15388
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15390
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2724				#	bl	hoge.2724
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.15391
fle_else.15390:
fle_cont.15391:
	j	fle_cont.15389
fle_else.15388:
fle_cont.15389:
	j	fle_cont.15387
fle_else.15386:
fle_cont.15387:
	j	fle_cont.15385
fle_else.15384:
fle_cont.15385:
	j	fle_cont.15383
fle_else.15382:
fle_cont.15383:
	j	fle_cont.15381
fle_else.15380:
fle_cont.15381:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2727				#	bl	fuga.2727
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15392
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15393
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15394
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
fle_else.15394:
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
fle_else.15393:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15395
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
fle_else.15395:
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
fle_else.15392:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15396
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15397
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
fle_else.15397:
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
fle_else.15396:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15398
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
fle_else.15398:
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
atan_body.2741:
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
atan.2743:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15399
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.15400
fle_else.15399:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.15400:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15401
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15402
	flup	f3, 15		# fli	f3, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan_body.2741				#	bl	atan_body.2741
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.15402:
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
	jal	atan_body.2741				#	bl	atan_body.2741
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.15401:
	j	atan_body.2741
div10_sub.2749:
	add	r6, r2, r5
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.15403
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r7, r5, 3
	slli	r8, r5, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.15404
	j	div10_sub.2749
ble_then.15404:
	slli	r2, r5, 3
	slli	r7, r5, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15405
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	j	div10_sub.2749
ble_then.15405:
	add	r1, r0, r5
	jr	r31				#
ble_then.15403:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15406
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r7, r2, 3
	slli	r8, r2, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.15407
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r6				# mr	r2, r6
	j	div10_sub.2749
ble_then.15407:
	slli	r6, r2, 3
	slli	r7, r2, 1
	add	r6, r6, r7
	addi	r6, r6, 9
	ble	r1, r6, ble_then.15408
	j	div10_sub.2749
ble_then.15408:
	add	r1, r0, r2
	jr	r31				#
ble_then.15406:
	add	r1, r0, r6
	jr	r31				#
print_uint.2769:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.15409
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.15409:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10_sub.2749				#	bl	div10_sub.2749
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 10
	sw	r1, 1(r3)
	ble	r2, r1, ble_then.15410
	addi	r2, r1, 48
	out	r2
	j	ble_cont.15411
ble_then.15410:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.15412
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2749				#	bl	div10_sub.2749
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.15413
ble_then.15412:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15414
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2749				#	bl	div10_sub.2749
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.15415
ble_then.15414:
	add	r1, r0, r5
ble_cont.15415:
ble_cont.15413:
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2769				#	bl	print_uint.2769
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
ble_cont.15411:
	lw	r1, 1(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
	jr	r31				#
vecunit_sgn.2853:
	flw	f1, 0(r1)
	fmul	f1, f1, f1
	flw	f2, 1(r1)
	fmul	f2, f2, f2
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	fmul	f2, f2, f2
	fadd	f1, f1, f2
	fsqrt	f1, f1
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15416
	addi	r5, r0, 1
	j	feq_cont.15417
feq_else.15416:
	addi	r5, r0, 0
feq_cont.15417:
	beqi	0, r5, beq_then.15418
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.15419
beq_then.15418:
	beqi	0, r2, beq_then.15420
	flup	f2, 11		# fli	f2, -1.000000
	fdiv	f1, f2, f1
	j	beq_cont.15421
beq_then.15420:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
beq_cont.15421:
beq_cont.15419:
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
vecaccum.2864:
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
vecaccumv.2877:
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
read_screen_settings.2954:
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
	jal	cos.2739				#	bl	cos.2739
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin.2737				#	bl	sin.2737
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
	jal	cos.2739				#	bl	cos.2739
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fsw	f1, 14(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	sin.2737				#	bl	sin.2737
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
read_light.2956:
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
	jal	sin.2737				#	bl	sin.2737
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
	jal	cos.2739				#	bl	cos.2739
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2737				#	bl	sin.2737
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	fsw	f1, 0(r1)
	flw	f1, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos.2739				#	bl	cos.2739
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
rotate_quadratic_matrix.2958:
	flw	f1, 0(r2)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	cos.2739				#	bl	cos.2739
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2737				#	bl	sin.2737
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2739				#	bl	cos.2739
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2737				#	bl	sin.2737
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos.2739				#	bl	cos.2739
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 10(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2737				#	bl	sin.2737
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
read_nth_object.2961:
	lw	r2, 1(r29)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.15429
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
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15430
	addi	r1, r0, 0
	j	fle_cont.15431
fle_else.15430:
	addi	r1, r0, 1
fle_cont.15431:
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
	beqi	0, r2, beq_then.15432
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
	j	beq_cont.15433
beq_then.15432:
beq_cont.15433:
	lw	r2, 3(r3)
	beqi	2, r2, beq_then.15434
	lw	r5, 8(r3)
	j	beq_cont.15435
beq_then.15434:
	addi	r5, r0, 1
beq_cont.15435:
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
	beqi	3, r7, beq_then.15436
	beqi	2, r7, beq_then.15438
	j	beq_cont.15439
beq_then.15438:
	lw	r2, 8(r3)
	beqi	0, r2, beq_then.15440
	addi	r2, r0, 0
	j	beq_cont.15441
beq_then.15440:
	addi	r2, r0, 1
beq_cont.15441:
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	vecunit_sgn.2853				#	bl	vecunit_sgn.2853
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.15439:
	j	beq_cont.15437
beq_then.15436:
	flw	f1, 0(r5)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15442
	addi	r2, r0, 1
	j	feq_cont.15443
feq_else.15442:
	addi	r2, r0, 0
feq_cont.15443:
	beqi	0, r2, beq_then.15444
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.15445
beq_then.15444:
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15446
	addi	r2, r0, 1
	j	feq_cont.15447
feq_else.15446:
	addi	r2, r0, 0
feq_cont.15447:
	beqi	0, r2, beq_then.15448
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.15449
beq_then.15448:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15450
	addi	r2, r0, 0
	j	fle_cont.15451
fle_else.15450:
	addi	r2, r0, 1
fle_cont.15451:
	beqi	0, r2, beq_then.15452
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.15453
beq_then.15452:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.15453:
beq_cont.15449:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.15445:
	fsw	f1, 0(r5)
	flw	f1, 1(r5)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15454
	addi	r2, r0, 1
	j	feq_cont.15455
feq_else.15454:
	addi	r2, r0, 0
feq_cont.15455:
	beqi	0, r2, beq_then.15456
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.15457
beq_then.15456:
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15458
	addi	r2, r0, 1
	j	feq_cont.15459
feq_else.15458:
	addi	r2, r0, 0
feq_cont.15459:
	beqi	0, r2, beq_then.15460
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.15461
beq_then.15460:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15462
	addi	r2, r0, 0
	j	fle_cont.15463
fle_else.15462:
	addi	r2, r0, 1
fle_cont.15463:
	beqi	0, r2, beq_then.15464
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.15465
beq_then.15464:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.15465:
beq_cont.15461:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.15457:
	fsw	f1, 1(r5)
	flw	f1, 2(r5)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15466
	addi	r2, r0, 1
	j	feq_cont.15467
feq_else.15466:
	addi	r2, r0, 0
feq_cont.15467:
	beqi	0, r2, beq_then.15468
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.15469
beq_then.15468:
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15470
	addi	r2, r0, 1
	j	feq_cont.15471
feq_else.15470:
	addi	r2, r0, 0
feq_cont.15471:
	beqi	0, r2, beq_then.15472
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.15473
beq_then.15472:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15474
	addi	r2, r0, 0
	j	fle_cont.15475
fle_else.15474:
	addi	r2, r0, 1
fle_cont.15475:
	beqi	0, r2, beq_then.15476
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.15477
beq_then.15476:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.15477:
beq_cont.15473:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.15469:
	fsw	f1, 2(r5)
beq_cont.15437:
	lw	r1, 5(r3)
	beqi	0, r1, beq_then.15478
	lw	r1, 6(r3)
	lw	r2, 11(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	rotate_quadratic_matrix.2958				#	bl	rotate_quadratic_matrix.2958
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.15479
beq_then.15478:
beq_cont.15479:
	addi	r1, r0, 1
	jr	r31				#
beq_then.15429:
	addi	r1, r0, 0
	jr	r31				#
read_object.2963:
	lw	r2, 2(r29)
	lw	r5, 1(r29)
	addi	r6, r0, 60
	ble	r6, r1, ble_then.15480
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
	beqi	0, r1, beq_then.15481
	lw	r1, 3(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.15482
	lw	r29, 1(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.15483
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.15484
	lw	r29, 1(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.15485
	lw	r1, 5(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.15486
	lw	r29, 1(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	0, r1, beq_then.15487
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.15487:
	lw	r1, 2(r3)
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.15486:
	jr	r31				#
beq_then.15485:
	lw	r1, 2(r3)
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.15484:
	jr	r31				#
beq_then.15483:
	lw	r1, 2(r3)
	lw	r2, 4(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.15482:
	jr	r31				#
beq_then.15481:
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.15480:
	jr	r31				#
read_net_item.2967:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.15496
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.15497
	lw	r2, 2(r3)
	addi	r5, r2, 1
	sw	r1, 3(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.2967				#	bl	read_net_item.2967
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.15498
beq_then.15497:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15498:
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.15496:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	j	lib_create_array
read_or_network.2969:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.15499
	addi	r2, r0, 1
	sw	r1, 1(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_net_item.2967				#	bl	read_net_item.2967
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.15500
beq_then.15499:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.15500:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.15501
	lw	r1, 0(r3)
	addi	r5, r1, 1
	addi	r6, r0, 0
	sw	r2, 2(r3)
	sw	r5, 3(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.2967				#	bl	read_net_item.2967
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.15502
	lw	r1, 3(r3)
	addi	r5, r1, 1
	sw	r2, 4(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	read_or_network.2969				#	bl	read_or_network.2969
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.15503
beq_then.15502:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.15503:
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.15501:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.2971:
	lw	r2, 1(r29)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.15504
	addi	r2, r0, 1
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.2967				#	bl	read_net_item.2967
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	j	beq_cont.15505
beq_then.15504:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15505:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.15506
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
	jal	read_net_item.2967				#	bl	read_net_item.2967
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.15507
	lw	r2, 4(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.15507:
	jr	r31				#
beq_then.15506:
	jr	r31				#
solver_rect_surface.2975:
	lw	r8, 1(r29)
	add	r30, r2, r5
	flw	f4, 0(r30)
	flup	f5, 0		# fli	f5, 0.000000
	feq	r30, f4, f5
	beq	r0, r30, feq_else.15510
	addi	r9, r0, 1
	j	feq_cont.15511
feq_else.15510:
	addi	r9, r0, 0
feq_cont.15511:
	beqi	0, r9, beq_then.15512
	addi	r1, r0, 0
	jr	r31				#
beq_then.15512:
	lw	r9, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	flup	f5, 0		# fli	f5, 0.000000
	fle	r30, f5, f4
	beq	r0, r30, fle_else.15513
	addi	r10, r0, 0
	j	fle_cont.15514
fle_else.15513:
	addi	r10, r0, 1
fle_cont.15514:
	beqi	0, r1, beq_then.15515
	beqi	0, r10, beq_then.15517
	addi	r1, r0, 0
	j	beq_cont.15518
beq_then.15517:
	addi	r1, r0, 1
beq_cont.15518:
	j	beq_cont.15516
beq_then.15515:
	add	r1, r0, r10
beq_cont.15516:
	add	r30, r9, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.15519
	j	beq_cont.15520
beq_then.15519:
	fneg	f4, f4
beq_cont.15520:
	fsub	f1, f4, f1
	add	r30, r2, r5
	flw	f4, 0(r30)
	fdiv	f1, f1, f4
	add	r30, r2, r6
	flw	f4, 0(r30)
	fmul	f4, f1, f4
	fadd	f2, f4, f2
	flup	f4, 0		# fli	f4, 0.000000
	fle	r30, f4, f2
	beq	r0, r30, fle_else.15521
	j	fle_cont.15522
fle_else.15521:
	fneg	f2, f2
fle_cont.15522:
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
	beqi	0, r1, beq_then.15523
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	flw	f1, 0(r30)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	flw	f3, 2(r3)
	fadd	f1, f1, f3
	flup	f3, 0		# fli	f3, 0.000000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15524
	j	fle_cont.15525
fle_else.15524:
	fneg	f1, f1
fle_cont.15525:
	lw	r2, 1(r3)
	add	r30, r2, r1
	flw	f3, 0(r30)
	fadd	f2, f0, f3				# fmr	f2, f3
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.15526
	lw	r1, 0(r3)
	flw	f1, 4(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.15526:
	addi	r1, r0, 0
	jr	r31				#
beq_then.15523:
	addi	r1, r0, 0
	jr	r31				#
solver_surface.2990:
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
	flup	f5, 0		# fli	f5, 0.000000
	fle	r30, f4, f5
	beq	r0, r30, fle_else.15527
	addi	r2, r0, 0
	j	fle_cont.15528
fle_else.15527:
	addi	r2, r0, 1
fle_cont.15528:
	beqi	0, r2, beq_then.15529
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
beq_then.15529:
	addi	r1, r0, 0
	jr	r31				#
quadratic.2996:
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
	beqi	0, r2, beq_then.15530
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
beq_then.15530:
	fadd	f1, f0, f4
	jr	r31				#
bilinear.3001:
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
	beqi	0, r2, beq_then.15531
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
beq_then.15531:
	fadd	f1, f0, f7
	jr	r31				#
solver_second.3009:
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
	jal	quadratic.2996				#	bl	quadratic.2996
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15533
	addi	r1, r0, 1
	j	feq_cont.15534
feq_else.15533:
	addi	r1, r0, 0
feq_cont.15534:
	beqi	0, r1, beq_then.15535
	addi	r1, r0, 0
	jr	r31				#
beq_then.15535:
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
	jal	bilinear.3001				#	bl	bilinear.3001
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
	jal	quadratic.2996				#	bl	quadratic.2996
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 8(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.15536
	j	beq_cont.15537
beq_then.15536:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.15537:
	flw	f2, 12(r3)
	fmul	f3, f2, f2
	flw	f4, 10(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	flup	f3, 0		# fli	f3, 0.000000
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15538
	addi	r2, r0, 0
	j	fle_cont.15539
fle_else.15538:
	addi	r2, r0, 1
fle_cont.15539:
	beqi	0, r2, beq_then.15540
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.15541
	j	beq_cont.15542
beq_then.15541:
	fneg	f1, f1
beq_cont.15542:
	fsub	f1, f1, f2
	fdiv	f1, f1, f4
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.15540:
	addi	r1, r0, 0
	jr	r31				#
solver_rect_fast.3019:
	lw	r6, 1(r29)
	flw	f4, 0(r5)
	fsub	f4, f4, f1
	flw	f5, 1(r5)
	fmul	f4, f4, f5
	flw	f5, 1(r2)
	fmul	f5, f4, f5
	fadd	f5, f5, f2
	flup	f6, 0		# fli	f6, 0.000000
	fle	r30, f6, f5
	beq	r0, r30, fle_else.15543
	j	fle_cont.15544
fle_else.15543:
	fneg	f5, f5
fle_cont.15544:
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
	beqi	0, r1, beq_then.15546
	lw	r1, 12(r3)
	flw	f1, 2(r1)
	flw	f2, 10(r3)
	fmul	f1, f2, f1
	flw	f3, 8(r3)
	fadd	f1, f1, f3
	flup	f4, 0		# fli	f4, 0.000000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15548
	j	fle_cont.15549
fle_else.15548:
	fneg	f1, f1
fle_cont.15549:
	lw	r2, 7(r3)
	lw	r5, 4(r2)
	flw	f4, 2(r5)
	fadd	f2, f0, f4				# fmr	f2, f4
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.15550
	lw	r1, 6(r3)
	flw	f1, 1(r1)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15552
	addi	r2, r0, 1
	j	feq_cont.15553
feq_else.15552:
	addi	r2, r0, 0
feq_cont.15553:
	beqi	0, r2, beq_then.15554
	addi	r1, r0, 0
	j	beq_cont.15555
beq_then.15554:
	addi	r1, r0, 1
beq_cont.15555:
	j	beq_cont.15551
beq_then.15550:
	addi	r1, r0, 0
beq_cont.15551:
	j	beq_cont.15547
beq_then.15546:
	addi	r1, r0, 0
beq_cont.15547:
	beqi	0, r1, beq_then.15556
	lw	r1, 0(r3)
	flw	f1, 10(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.15556:
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
	flup	f5, 0		# fli	f5, 0.000000
	fle	r30, f5, f3
	beq	r0, r30, fle_else.15557
	j	fle_cont.15558
fle_else.15557:
	fneg	f3, f3
fle_cont.15558:
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
	beqi	0, r1, beq_then.15560
	lw	r1, 12(r3)
	flw	f1, 2(r1)
	flw	f2, 14(r3)
	fmul	f1, f2, f1
	flw	f3, 8(r3)
	fadd	f1, f1, f3
	flup	f4, 0		# fli	f4, 0.000000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15562
	j	fle_cont.15563
fle_else.15562:
	fneg	f1, f1
fle_cont.15563:
	lw	r2, 7(r3)
	lw	r5, 4(r2)
	flw	f4, 2(r5)
	fadd	f2, f0, f4				# fmr	f2, f4
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.15564
	lw	r1, 6(r3)
	flw	f1, 3(r1)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15566
	addi	r2, r0, 1
	j	feq_cont.15567
feq_else.15566:
	addi	r2, r0, 0
feq_cont.15567:
	beqi	0, r2, beq_then.15568
	addi	r1, r0, 0
	j	beq_cont.15569
beq_then.15568:
	addi	r1, r0, 1
beq_cont.15569:
	j	beq_cont.15565
beq_then.15564:
	addi	r1, r0, 0
beq_cont.15565:
	j	beq_cont.15561
beq_then.15560:
	addi	r1, r0, 0
beq_cont.15561:
	beqi	0, r1, beq_then.15570
	lw	r1, 0(r3)
	flw	f1, 14(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 2
	jr	r31				#
beq_then.15570:
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
	flup	f3, 0		# fli	f3, 0.000000
	fle	r30, f3, f2
	beq	r0, r30, fle_else.15571
	j	fle_cont.15572
fle_else.15571:
	fneg	f2, f2
fle_cont.15572:
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
	beqi	0, r1, beq_then.15573
	lw	r1, 12(r3)
	flw	f1, 1(r1)
	flw	f2, 16(r3)
	fmul	f1, f2, f1
	flw	f3, 4(r3)
	fadd	f1, f1, f3
	flup	f3, 0		# fli	f3, 0.000000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15575
	j	fle_cont.15576
fle_else.15575:
	fneg	f1, f1
fle_cont.15576:
	lw	r1, 7(r3)
	lw	r1, 4(r1)
	flw	f3, 1(r1)
	fadd	f2, f0, f3				# fmr	f2, f3
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.15577
	lw	r1, 6(r3)
	flw	f1, 5(r1)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15579
	addi	r1, r0, 1
	j	feq_cont.15580
feq_else.15579:
	addi	r1, r0, 0
feq_cont.15580:
	beqi	0, r1, beq_then.15581
	addi	r1, r0, 0
	j	beq_cont.15582
beq_then.15581:
	addi	r1, r0, 1
beq_cont.15582:
	j	beq_cont.15578
beq_then.15577:
	addi	r1, r0, 0
beq_cont.15578:
	j	beq_cont.15574
beq_then.15573:
	addi	r1, r0, 0
beq_cont.15574:
	beqi	0, r1, beq_then.15583
	lw	r1, 0(r3)
	flw	f1, 16(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 3
	jr	r31				#
beq_then.15583:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3032:
	lw	r5, 1(r29)
	flw	f4, 0(r2)
	flup	f5, 0		# fli	f5, 0.000000
	feq	r30, f4, f5
	beq	r0, r30, feq_else.15584
	addi	r6, r0, 1
	j	feq_cont.15585
feq_else.15584:
	addi	r6, r0, 0
feq_cont.15585:
	beqi	0, r6, beq_then.15586
	addi	r1, r0, 0
	jr	r31				#
beq_then.15586:
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
	jal	quadratic.2996				#	bl	quadratic.2996
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.15587
	j	beq_cont.15588
beq_then.15587:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.15588:
	flw	f2, 4(r3)
	fmul	f3, f2, f2
	flw	f4, 2(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	flup	f3, 0		# fli	f3, 0.000000
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15589
	addi	r2, r0, 0
	j	fle_cont.15590
fle_else.15589:
	addi	r2, r0, 1
fle_cont.15590:
	beqi	0, r2, beq_then.15591
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.15592
	fsqrt	f1, f1
	fadd	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	j	beq_cont.15593
beq_then.15592:
	fsqrt	f1, f1
	fsub	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
beq_cont.15593:
	addi	r1, r0, 1
	jr	r31				#
beq_then.15591:
	addi	r1, r0, 0
	jr	r31				#
solver_fast.3038:
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
	beqi	1, r1, beq_then.15594
	beqi	2, r1, beq_then.15595
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r9				# mr	r1, r9
	add	r29, r0, r6				# mr	r29, r6
	lw	r28, 0(r29)
	jr	r28
beq_then.15595:
	flw	f4, 0(r5)
	flup	f5, 0		# fli	f5, 0.000000
	fle	r30, f5, f4
	beq	r0, r30, fle_else.15596
	addi	r1, r0, 0
	j	fle_cont.15597
fle_else.15596:
	addi	r1, r0, 1
fle_cont.15597:
	beqi	0, r1, beq_then.15598
	flw	f4, 1(r5)
	fmul	f1, f4, f1
	flw	f4, 2(r5)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 3(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 0(r8)
	addi	r1, r0, 1
	jr	r31				#
beq_then.15598:
	addi	r1, r0, 0
	jr	r31				#
beq_then.15594:
	lw	r2, 0(r2)
	add	r1, r0, r9				# mr	r1, r9
	add	r29, r0, r7				# mr	r29, r7
	lw	r28, 0(r29)
	jr	r28
solver_second_fast2.3049:
	lw	r6, 1(r29)
	flw	f4, 0(r2)
	flup	f5, 0		# fli	f5, 0.000000
	feq	r30, f4, f5
	beq	r0, r30, feq_else.15599
	addi	r7, r0, 1
	j	feq_cont.15600
feq_else.15599:
	addi	r7, r0, 0
feq_cont.15600:
	beqi	0, r7, beq_then.15601
	addi	r1, r0, 0
	jr	r31				#
beq_then.15601:
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
	flup	f3, 0		# fli	f3, 0.000000
	fle	r30, f2, f3
	beq	r0, r30, fle_else.15602
	addi	r5, r0, 0
	j	fle_cont.15603
fle_else.15602:
	addi	r5, r0, 1
fle_cont.15603:
	beqi	0, r5, beq_then.15604
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.15605
	fsqrt	f2, f2
	fadd	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r6)
	j	beq_cont.15606
beq_then.15605:
	fsqrt	f2, f2
	fsub	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r6)
beq_cont.15606:
	addi	r1, r0, 1
	jr	r31				#
beq_then.15604:
	addi	r1, r0, 0
	jr	r31				#
setup_rect_table.3059:
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
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15607
	addi	r5, r0, 1
	j	feq_cont.15608
feq_else.15607:
	addi	r5, r0, 0
feq_cont.15608:
	beqi	0, r5, beq_then.15609
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 1(r1)
	j	beq_cont.15610
beq_then.15609:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 0(r2)
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15611
	addi	r7, r0, 0
	j	fle_cont.15612
fle_else.15611:
	addi	r7, r0, 1
fle_cont.15612:
	beqi	0, r6, beq_then.15613
	beqi	0, r7, beq_then.15615
	addi	r6, r0, 0
	j	beq_cont.15616
beq_then.15615:
	addi	r6, r0, 1
beq_cont.15616:
	j	beq_cont.15614
beq_then.15613:
	add	r6, r0, r7
beq_cont.15614:
	lw	r7, 4(r5)
	flw	f1, 0(r7)
	beqi	0, r6, beq_then.15617
	j	beq_cont.15618
beq_then.15617:
	fneg	f1, f1
beq_cont.15618:
	fsw	f1, 0(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r2)
	fdiv	f1, f1, f2
	fsw	f1, 1(r1)
beq_cont.15610:
	flw	f1, 1(r2)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15619
	addi	r5, r0, 1
	j	feq_cont.15620
feq_else.15619:
	addi	r5, r0, 0
feq_cont.15620:
	beqi	0, r5, beq_then.15621
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 3(r1)
	j	beq_cont.15622
beq_then.15621:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 1(r2)
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15623
	addi	r7, r0, 0
	j	fle_cont.15624
fle_else.15623:
	addi	r7, r0, 1
fle_cont.15624:
	beqi	0, r6, beq_then.15625
	beqi	0, r7, beq_then.15627
	addi	r6, r0, 0
	j	beq_cont.15628
beq_then.15627:
	addi	r6, r0, 1
beq_cont.15628:
	j	beq_cont.15626
beq_then.15625:
	add	r6, r0, r7
beq_cont.15626:
	lw	r7, 4(r5)
	flw	f1, 1(r7)
	beqi	0, r6, beq_then.15629
	j	beq_cont.15630
beq_then.15629:
	fneg	f1, f1
beq_cont.15630:
	fsw	f1, 2(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 1(r2)
	fdiv	f1, f1, f2
	fsw	f1, 3(r1)
beq_cont.15622:
	flw	f1, 2(r2)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15631
	addi	r5, r0, 1
	j	feq_cont.15632
feq_else.15631:
	addi	r5, r0, 0
feq_cont.15632:
	beqi	0, r5, beq_then.15633
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 5(r1)
	j	beq_cont.15634
beq_then.15633:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 2(r2)
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15635
	addi	r7, r0, 0
	j	fle_cont.15636
fle_else.15635:
	addi	r7, r0, 1
fle_cont.15636:
	beqi	0, r6, beq_then.15637
	beqi	0, r7, beq_then.15639
	addi	r6, r0, 0
	j	beq_cont.15640
beq_then.15639:
	addi	r6, r0, 1
beq_cont.15640:
	j	beq_cont.15638
beq_then.15637:
	add	r6, r0, r7
beq_cont.15638:
	lw	r5, 4(r5)
	flw	f1, 2(r5)
	beqi	0, r6, beq_then.15641
	j	beq_cont.15642
beq_then.15641:
	fneg	f1, f1
beq_cont.15642:
	fsw	f1, 4(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 2(r2)
	fdiv	f1, f1, f2
	fsw	f1, 5(r1)
beq_cont.15634:
	jr	r31				#
setup_surface_table.3062:
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
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15643
	addi	r2, r0, 0
	j	fle_cont.15644
fle_else.15643:
	addi	r2, r0, 1
fle_cont.15644:
	beqi	0, r2, beq_then.15645
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
	j	beq_cont.15646
beq_then.15645:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
beq_cont.15646:
	jr	r31				#
setup_second_table.3065:
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
	jal	quadratic.2996				#	bl	quadratic.2996
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
	beqi	0, r6, beq_then.15647
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
	j	beq_cont.15648
beq_then.15647:
	fsw	f2, 1(r5)
	fsw	f3, 2(r5)
	fsw	f4, 3(r5)
beq_cont.15648:
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15649
	addi	r1, r0, 1
	j	feq_cont.15650
feq_else.15649:
	addi	r1, r0, 0
feq_cont.15650:
	beqi	0, r1, beq_then.15651
	j	beq_cont.15652
beq_then.15651:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
	fsw	f1, 4(r5)
beq_cont.15652:
	add	r1, r0, r5
	jr	r31				#
iter_setup_dirvec_constants.3068:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.15653
	jr	r31				#
ble_then.15653:
	add	r30, r5, r2
	lw	r6, 0(r30)
	lw	r7, 1(r1)
	lw	r8, 0(r1)
	lw	r9, 1(r6)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	beqi	1, r9, beq_then.15655
	beqi	2, r9, beq_then.15657
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3065				#	bl	setup_second_table.3065
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.15658
beq_then.15657:
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3062				#	bl	setup_surface_table.3062
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.15658:
	j	beq_cont.15656
beq_then.15655:
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3059				#	bl	setup_rect_table.3059
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.15656:
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.15659
	jr	r31				#
ble_then.15659:
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 1(r3)
	lw	r6, 1(r5)
	lw	r7, 0(r5)
	lw	r8, 1(r2)
	beqi	1, r8, beq_then.15661
	beqi	2, r8, beq_then.15663
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_second_table.3065				#	bl	setup_second_table.3065
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.15664
beq_then.15663:
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_surface_table.3062				#	bl	setup_surface_table.3062
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.15664:
	j	beq_cont.15662
beq_then.15661:
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_rect_table.3059				#	bl	setup_rect_table.3059
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.15662:
	addi	r2, r2, -1
	lw	r1, 1(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
setup_startp_constants.3073:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.15665
	jr	r31				#
ble_then.15665:
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
	beqi	2, r7, beq_then.15667
	blei	2, r7, ble_then.15669
	flw	f1, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 2(r6)
	sw	r6, 3(r3)
	sw	r7, 4(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	quadratic.2996				#	bl	quadratic.2996
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	beqi	3, r1, beq_then.15671
	j	beq_cont.15672
beq_then.15671:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.15672:
	lw	r1, 3(r3)
	fsw	f1, 3(r1)
	j	ble_cont.15670
ble_then.15669:
ble_cont.15670:
	j	beq_cont.15668
beq_then.15667:
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
beq_cont.15668:
	lw	r1, 2(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
is_rect_outside.3078:
	flup	f4, 0		# fli	f4, 0.000000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15673
	j	fle_cont.15674
fle_else.15673:
	fneg	f1, f1
fle_cont.15674:
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
	beqi	0, r1, beq_then.15676
	flup	f1, 0		# fli	f1, 0.000000
	flw	f2, 4(r3)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15678
	fadd	f1, f0, f2
	j	fle_cont.15679
fle_else.15678:
	fneg	f1, f2
fle_cont.15679:
	lw	r1, 2(r3)
	lw	r2, 4(r1)
	flw	f2, 1(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.15680
	flup	f1, 0		# fli	f1, 0.000000
	flw	f2, 0(r3)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15682
	fadd	f1, f0, f2
	j	fle_cont.15683
fle_else.15682:
	fneg	f1, f2
fle_cont.15683:
	lw	r1, 2(r3)
	lw	r2, 4(r1)
	flw	f2, 2(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.15681
beq_then.15680:
	addi	r1, r0, 0
beq_cont.15681:
	j	beq_cont.15677
beq_then.15676:
	addi	r1, r0, 0
beq_cont.15677:
	beqi	0, r1, beq_then.15684
	lw	r1, 2(r3)
	lw	r1, 6(r1)
	jr	r31				#
beq_then.15684:
	lw	r1, 2(r3)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.15685
	addi	r1, r0, 0
	jr	r31				#
beq_then.15685:
	addi	r1, r0, 1
	jr	r31				#
is_plane_outside.3083:
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
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15686
	addi	r2, r0, 0
	j	fle_cont.15687
fle_else.15686:
	addi	r2, r0, 1
fle_cont.15687:
	beqi	0, r1, beq_then.15688
	beqi	0, r2, beq_then.15690
	addi	r1, r0, 0
	j	beq_cont.15691
beq_then.15690:
	addi	r1, r0, 1
beq_cont.15691:
	j	beq_cont.15689
beq_then.15688:
	add	r1, r0, r2
beq_cont.15689:
	beqi	0, r1, beq_then.15692
	addi	r1, r0, 0
	jr	r31				#
beq_then.15692:
	addi	r1, r0, 1
	jr	r31				#
is_outside.3093:
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
	beqi	1, r2, beq_then.15693
	beqi	2, r2, beq_then.15694
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.2996				#	bl	quadratic.2996
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.15695
	j	beq_cont.15696
beq_then.15695:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.15696:
	lw	r1, 6(r1)
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15697
	addi	r2, r0, 0
	j	fle_cont.15698
fle_else.15697:
	addi	r2, r0, 1
fle_cont.15698:
	beqi	0, r1, beq_then.15699
	beqi	0, r2, beq_then.15701
	addi	r1, r0, 0
	j	beq_cont.15702
beq_then.15701:
	addi	r1, r0, 1
beq_cont.15702:
	j	beq_cont.15700
beq_then.15699:
	add	r1, r0, r2
beq_cont.15700:
	beqi	0, r1, beq_then.15703
	addi	r1, r0, 0
	jr	r31				#
beq_then.15703:
	addi	r1, r0, 1
	jr	r31				#
beq_then.15694:
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
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15704
	addi	r2, r0, 0
	j	fle_cont.15705
fle_else.15704:
	addi	r2, r0, 1
fle_cont.15705:
	beqi	0, r1, beq_then.15706
	beqi	0, r2, beq_then.15708
	addi	r1, r0, 0
	j	beq_cont.15709
beq_then.15708:
	addi	r1, r0, 1
beq_cont.15709:
	j	beq_cont.15707
beq_then.15706:
	add	r1, r0, r2
beq_cont.15707:
	beqi	0, r1, beq_then.15710
	addi	r1, r0, 0
	jr	r31				#
beq_then.15710:
	addi	r1, r0, 1
	jr	r31				#
beq_then.15693:
	flup	f4, 0		# fli	f4, 0.000000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15711
	j	fle_cont.15712
fle_else.15711:
	fneg	f1, f1
fle_cont.15712:
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
	beqi	0, r1, beq_then.15714
	flup	f1, 0		# fli	f1, 0.000000
	flw	f2, 4(r3)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15716
	fadd	f1, f0, f2
	j	fle_cont.15717
fle_else.15716:
	fneg	f1, f2
fle_cont.15717:
	lw	r1, 0(r3)
	lw	r2, 4(r1)
	flw	f2, 1(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.15718
	flup	f1, 0		# fli	f1, 0.000000
	flw	f2, 2(r3)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15720
	fadd	f1, f0, f2
	j	fle_cont.15721
fle_else.15720:
	fneg	f1, f2
fle_cont.15721:
	lw	r1, 0(r3)
	lw	r2, 4(r1)
	flw	f2, 2(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.15719
beq_then.15718:
	addi	r1, r0, 0
beq_cont.15719:
	j	beq_cont.15715
beq_then.15714:
	addi	r1, r0, 0
beq_cont.15715:
	beqi	0, r1, beq_then.15722
	lw	r1, 0(r3)
	lw	r1, 6(r1)
	jr	r31				#
beq_then.15722:
	lw	r1, 0(r3)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.15723
	addi	r1, r0, 0
	jr	r31				#
beq_then.15723:
	addi	r1, r0, 1
	jr	r31				#
check_all_inside.3098:
	lw	r5, 1(r29)
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.15724
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
	beqi	1, r7, beq_then.15726
	beqi	2, r7, beq_then.15728
	sw	r6, 11(r3)
	add	r1, r0, r6				# mr	r1, r6
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	quadratic.2996				#	bl	quadratic.2996
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 11(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.15730
	j	beq_cont.15731
beq_then.15730:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.15731:
	lw	r1, 6(r1)
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15732
	addi	r2, r0, 0
	j	fle_cont.15733
fle_else.15732:
	addi	r2, r0, 1
fle_cont.15733:
	beqi	0, r1, beq_then.15734
	beqi	0, r2, beq_then.15736
	addi	r1, r0, 0
	j	beq_cont.15737
beq_then.15736:
	addi	r1, r0, 1
beq_cont.15737:
	j	beq_cont.15735
beq_then.15734:
	add	r1, r0, r2
beq_cont.15735:
	beqi	0, r1, beq_then.15738
	addi	r1, r0, 0
	j	beq_cont.15739
beq_then.15738:
	addi	r1, r0, 1
beq_cont.15739:
	j	beq_cont.15729
beq_then.15728:
	add	r1, r0, r6				# mr	r1, r6
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	is_plane_outside.3083				#	bl	is_plane_outside.3083
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.15729:
	j	beq_cont.15727
beq_then.15726:
	add	r1, r0, r6				# mr	r1, r6
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	is_rect_outside.3078				#	bl	is_rect_outside.3078
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.15727:
	beqi	0, r1, beq_then.15740
	addi	r1, r0, 0
	jr	r31				#
beq_then.15740:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.15741
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
	jal	is_outside.3093				#	bl	is_outside.3093
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.15742
	addi	r1, r0, 0
	jr	r31				#
beq_then.15742:
	lw	r1, 12(r3)
	addi	r1, r1, 1
	flw	f1, 6(r3)
	flw	f2, 4(r3)
	flw	f3, 2(r3)
	lw	r2, 9(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.15741:
	addi	r1, r0, 1
	jr	r31				#
beq_then.15724:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3104:
	lw	r5, 7(r29)
	lw	r6, 6(r29)
	lw	r7, 5(r29)
	lw	r8, 4(r29)
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	add	r30, r2, r1
	lw	r12, 0(r30)
	beqi	-1, r12, beq_then.15743
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
	fsw	f1, 10(r3)
	beqi	0, r1, beq_then.15745
	flup	f2, 28		# fli	f2, -0.200000
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.15746
beq_then.15745:
	addi	r1, r0, 0
beq_cont.15746:
	beqi	0, r1, beq_then.15747
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
	beqi	-1, r1, beq_then.15748
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
	jal	is_outside.3093				#	bl	is_outside.3093
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.15750
	addi	r1, r0, 0
	j	beq_cont.15751
beq_then.15750:
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
beq_cont.15751:
	j	beq_cont.15749
beq_then.15748:
	addi	r1, r0, 1
beq_cont.15749:
	beqi	0, r1, beq_then.15752
	addi	r1, r0, 1
	jr	r31				#
beq_then.15752:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.15747:
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.15753
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.15753:
	addi	r1, r0, 0
	jr	r31				#
beq_then.15743:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3107:
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.15754
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
	beqi	0, r1, beq_then.15755
	addi	r1, r0, 1
	jr	r31				#
beq_then.15755:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.15756
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
	beqi	0, r1, beq_then.15757
	addi	r1, r0, 1
	jr	r31				#
beq_then.15757:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.15758
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
	beqi	0, r1, beq_then.15759
	addi	r1, r0, 1
	jr	r31				#
beq_then.15759:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.15760
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
	beqi	0, r1, beq_then.15761
	addi	r1, r0, 1
	jr	r31				#
beq_then.15761:
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.15760:
	addi	r1, r0, 0
	jr	r31				#
beq_then.15758:
	addi	r1, r0, 0
	jr	r31				#
beq_then.15756:
	addi	r1, r0, 0
	jr	r31				#
beq_then.15754:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3110:
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
	beqi	-1, r13, beq_then.15762
	addi	r14, r0, 99
	sw	r7, 0(r3)
	sw	r8, 1(r3)
	sw	r11, 2(r3)
	sw	r12, 3(r3)
	sw	r2, 4(r3)
	sw	r29, 5(r3)
	sw	r1, 6(r3)
	beq	r13, r14, beq_then.15763
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
	beqi	0, r1, beq_then.15765
	lw	r1, 7(r3)
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.15767
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.15769
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
	beqi	0, r1, beq_then.15771
	addi	r1, r0, 1
	j	beq_cont.15772
beq_then.15771:
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.15773
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
	beqi	0, r1, beq_then.15775
	addi	r1, r0, 1
	j	beq_cont.15776
beq_then.15775:
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.15777
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
	beqi	0, r1, beq_then.15779
	addi	r1, r0, 1
	j	beq_cont.15780
beq_then.15779:
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.15780:
	j	beq_cont.15778
beq_then.15777:
	addi	r1, r0, 0
beq_cont.15778:
beq_cont.15776:
	j	beq_cont.15774
beq_then.15773:
	addi	r1, r0, 0
beq_cont.15774:
beq_cont.15772:
	j	beq_cont.15770
beq_then.15769:
	addi	r1, r0, 0
beq_cont.15770:
	beqi	0, r1, beq_then.15781
	addi	r1, r0, 1
	j	beq_cont.15782
beq_then.15781:
	addi	r1, r0, 0
beq_cont.15782:
	j	beq_cont.15768
beq_then.15767:
	addi	r1, r0, 0
beq_cont.15768:
	j	beq_cont.15766
beq_then.15765:
	addi	r1, r0, 0
beq_cont.15766:
	j	beq_cont.15764
beq_then.15763:
	addi	r1, r0, 1
beq_cont.15764:
	beqi	0, r1, beq_then.15783
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.15784
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
	beqi	0, r1, beq_then.15786
	addi	r1, r0, 1
	j	beq_cont.15787
beq_then.15786:
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.15788
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
	beqi	0, r1, beq_then.15790
	addi	r1, r0, 1
	j	beq_cont.15791
beq_then.15790:
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.15792
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
	beqi	0, r1, beq_then.15794
	addi	r1, r0, 1
	j	beq_cont.15795
beq_then.15794:
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.15795:
	j	beq_cont.15793
beq_then.15792:
	addi	r1, r0, 0
beq_cont.15793:
beq_cont.15791:
	j	beq_cont.15789
beq_then.15788:
	addi	r1, r0, 0
beq_cont.15789:
beq_cont.15787:
	j	beq_cont.15785
beq_then.15784:
	addi	r1, r0, 0
beq_cont.15785:
	beqi	0, r1, beq_then.15796
	addi	r1, r0, 1
	jr	r31				#
beq_then.15796:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r29, 5(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.15783:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r29, 5(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.15762:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3113:
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
	beqi	-1, r17, beq_then.15797
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
	beqi	1, r19, beq_then.15798
	beqi	2, r19, beq_then.15800
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r18				# mr	r1, r18
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.15801
beq_then.15800:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r18				# mr	r1, r18
	add	r29, r0, r8				# mr	r29, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.15801:
	j	beq_cont.15799
beq_then.15798:
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
	beqi	0, r1, beq_then.15803
	addi	r1, r0, 1
	j	beq_cont.15804
beq_then.15803:
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
	beqi	0, r1, beq_then.15805
	addi	r1, r0, 2
	j	beq_cont.15806
beq_then.15805:
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
	beqi	0, r1, beq_then.15807
	addi	r1, r0, 3
	j	beq_cont.15808
beq_then.15807:
	addi	r1, r0, 0
beq_cont.15808:
beq_cont.15806:
beq_cont.15804:
beq_cont.15799:
	beqi	0, r1, beq_then.15809
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
	beqi	0, r1, beq_then.15811
	lw	r1, 5(r3)
	flw	f2, 0(r1)
	flw	f1, 24(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -27
	lw	r31, 26(r3)
	beqi	0, r1, beq_then.15813
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
	beqi	-1, r1, beq_then.15815
	lw	r6, 12(r3)
	add	r30, r6, r1
	lw	r1, 0(r30)
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	is_outside.3093				#	bl	is_outside.3093
	addi	r3, r3, -35
	lw	r31, 34(r3)
	beqi	0, r1, beq_then.15817
	addi	r1, r0, 0
	j	beq_cont.15818
beq_then.15817:
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
beq_cont.15818:
	j	beq_cont.15816
beq_then.15815:
	addi	r1, r0, 1
beq_cont.15816:
	beqi	0, r1, beq_then.15819
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
	j	beq_cont.15820
beq_then.15819:
beq_cont.15820:
	j	beq_cont.15814
beq_then.15813:
beq_cont.15814:
	j	beq_cont.15812
beq_then.15811:
beq_cont.15812:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r29, 9(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.15809:
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.15821
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r29, 9(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.15821:
	jr	r31				#
beq_then.15797:
	jr	r31				#
solve_one_or_network.3117:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.15824
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
	beqi	-1, r5, beq_then.15825
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
	beqi	-1, r5, beq_then.15826
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
	beqi	-1, r5, beq_then.15827
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
beq_then.15827:
	jr	r31				#
beq_then.15826:
	jr	r31				#
beq_then.15825:
	jr	r31				#
beq_then.15824:
	jr	r31				#
trace_or_matrix.3121:
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
	add	r30, r2, r1
	lw	r16, 0(r30)
	lw	r17, 0(r16)
	beqi	-1, r17, beq_then.15832
	addi	r18, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r29, 2(r3)
	sw	r1, 3(r3)
	beq	r17, r18, beq_then.15833
	add	r30, r14, r17
	lw	r14, 0(r30)
	flw	f1, 0(r7)
	lw	r17, 5(r14)
	flw	f2, 0(r17)
	fsub	f1, f1, f2
	flw	f2, 1(r7)
	lw	r17, 5(r14)
	flw	f3, 1(r17)
	fsub	f2, f2, f3
	flw	f3, 2(r7)
	lw	r7, 5(r14)
	flw	f4, 2(r7)
	fsub	f3, f3, f4
	lw	r7, 1(r14)
	sw	r12, 4(r3)
	sw	r13, 5(r3)
	sw	r15, 6(r3)
	sw	r16, 7(r3)
	sw	r6, 8(r3)
	sw	r11, 9(r3)
	beqi	1, r7, beq_then.15835
	beqi	2, r7, beq_then.15837
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r14				# mr	r1, r14
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.15838
beq_then.15837:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r14				# mr	r1, r14
	add	r29, r0, r8				# mr	r29, r8
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
beq_cont.15838:
	j	beq_cont.15836
beq_then.15835:
	addi	r7, r0, 0
	addi	r8, r0, 1
	addi	r9, r0, 2
	fsw	f1, 10(r3)
	fsw	f3, 12(r3)
	fsw	f2, 14(r3)
	sw	r14, 16(r3)
	sw	r10, 17(r3)
	add	r6, r0, r8				# mr	r6, r8
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r14				# mr	r1, r14
	add	r29, r0, r10				# mr	r29, r10
	add	r5, r0, r7				# mr	r5, r7
	add	r7, r0, r9				# mr	r7, r9
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.15839
	addi	r1, r0, 1
	j	beq_cont.15840
beq_then.15839:
	addi	r5, r0, 1
	addi	r6, r0, 2
	addi	r7, r0, 0
	flw	f1, 14(r3)
	flw	f2, 12(r3)
	flw	f3, 10(r3)
	lw	r1, 16(r3)
	lw	r2, 0(r3)
	lw	r29, 17(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.15841
	addi	r1, r0, 2
	j	beq_cont.15842
beq_then.15841:
	addi	r5, r0, 2
	addi	r6, r0, 0
	addi	r7, r0, 1
	flw	f1, 12(r3)
	flw	f2, 10(r3)
	flw	f3, 14(r3)
	lw	r1, 16(r3)
	lw	r2, 0(r3)
	lw	r29, 17(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.15843
	addi	r1, r0, 3
	j	beq_cont.15844
beq_then.15843:
	addi	r1, r0, 0
beq_cont.15844:
beq_cont.15842:
beq_cont.15840:
beq_cont.15836:
	beqi	0, r1, beq_then.15845
	lw	r1, 9(r3)
	flw	f1, 0(r1)
	lw	r1, 8(r3)
	flw	f2, 0(r1)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.15847
	lw	r1, 7(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.15849
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	lw	r29, 5(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r1, 7(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.15851
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	lw	r29, 5(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r1, 7(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.15853
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	lw	r29, 5(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	addi	r1, r0, 4
	lw	r2, 7(r3)
	lw	r5, 0(r3)
	lw	r29, 4(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	j	beq_cont.15854
beq_then.15853:
beq_cont.15854:
	j	beq_cont.15852
beq_then.15851:
beq_cont.15852:
	j	beq_cont.15850
beq_then.15849:
beq_cont.15850:
	j	beq_cont.15848
beq_then.15847:
beq_cont.15848:
	j	beq_cont.15846
beq_then.15845:
beq_cont.15846:
	j	beq_cont.15834
beq_then.15833:
	lw	r6, 1(r16)
	beqi	-1, r6, beq_then.15855
	add	r30, r15, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r12, 4(r3)
	sw	r13, 5(r3)
	sw	r15, 6(r3)
	sw	r16, 7(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	add	r29, r0, r13				# mr	r29, r13
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r1, 7(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.15857
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	lw	r29, 5(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r1, 7(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.15859
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	lw	r29, 5(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	addi	r1, r0, 4
	lw	r2, 7(r3)
	lw	r5, 0(r3)
	lw	r29, 4(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	j	beq_cont.15860
beq_then.15859:
beq_cont.15860:
	j	beq_cont.15858
beq_then.15857:
beq_cont.15858:
	j	beq_cont.15856
beq_then.15855:
beq_cont.15856:
beq_cont.15834:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.15832:
	jr	r31				#
solve_each_element_fast.3127:
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
	beqi	-1, r17, beq_then.15862
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
	beqi	1, r21, beq_then.15863
	beqi	2, r21, beq_then.15865
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
	j	beq_cont.15866
beq_then.15865:
	flw	f1, 0(r20)
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15867
	addi	r8, r0, 0
	j	fle_cont.15868
fle_else.15867:
	addi	r8, r0, 1
fle_cont.15868:
	beqi	0, r8, beq_then.15869
	flw	f1, 0(r20)
	flw	f2, 3(r19)
	fmul	f1, f1, f2
	fsw	f1, 0(r10)
	addi	r1, r0, 1
	j	beq_cont.15870
beq_then.15869:
	addi	r1, r0, 0
beq_cont.15870:
beq_cont.15866:
	j	beq_cont.15864
beq_then.15863:
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
beq_cont.15864:
	beqi	0, r1, beq_then.15871
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
	beqi	0, r1, beq_then.15873
	lw	r1, 6(r3)
	flw	f2, 0(r1)
	flw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.15875
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
	beqi	-1, r1, beq_then.15877
	lw	r5, 13(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	is_outside.3093				#	bl	is_outside.3093
	addi	r3, r3, -27
	lw	r31, 26(r3)
	beqi	0, r1, beq_then.15879
	addi	r1, r0, 0
	j	beq_cont.15880
beq_then.15879:
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
beq_cont.15880:
	j	beq_cont.15878
beq_then.15877:
	addi	r1, r0, 1
beq_cont.15878:
	beqi	0, r1, beq_then.15881
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
	j	beq_cont.15882
beq_then.15881:
beq_cont.15882:
	j	beq_cont.15876
beq_then.15875:
beq_cont.15876:
	j	beq_cont.15874
beq_then.15873:
beq_cont.15874:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r29, 10(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.15871:
	lw	r1, 12(r3)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.15883
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r29, 10(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.15883:
	jr	r31				#
beq_then.15862:
	jr	r31				#
solve_one_or_network_fast.3131:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.15886
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
	beqi	-1, r5, beq_then.15887
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
	beqi	-1, r5, beq_then.15888
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
	beqi	-1, r5, beq_then.15889
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
beq_then.15889:
	jr	r31				#
beq_then.15888:
	jr	r31				#
beq_then.15887:
	jr	r31				#
beq_then.15886:
	jr	r31				#
trace_or_matrix_fast.3135:
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
	lw	r15, 0(r14)
	beqi	-1, r15, beq_then.15894
	addi	r16, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r29, 2(r3)
	sw	r1, 3(r3)
	beq	r15, r16, beq_then.15895
	add	r30, r12, r15
	lw	r12, 0(r30)
	lw	r16, 10(r12)
	flw	f1, 0(r16)
	flw	f2, 1(r16)
	flw	f3, 2(r16)
	lw	r17, 1(r5)
	add	r30, r17, r15
	lw	r15, 0(r30)
	lw	r17, 1(r12)
	sw	r10, 4(r3)
	sw	r11, 5(r3)
	sw	r13, 6(r3)
	sw	r14, 7(r3)
	sw	r6, 8(r3)
	sw	r9, 9(r3)
	beqi	1, r17, beq_then.15897
	beqi	2, r17, beq_then.15899
	add	r5, r0, r16				# mr	r5, r16
	add	r2, r0, r15				# mr	r2, r15
	add	r1, r0, r12				# mr	r1, r12
	add	r29, r0, r7				# mr	r29, r7
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.15900
beq_then.15899:
	flw	f1, 0(r15)
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15901
	addi	r7, r0, 0
	j	fle_cont.15902
fle_else.15901:
	addi	r7, r0, 1
fle_cont.15902:
	beqi	0, r7, beq_then.15903
	flw	f1, 0(r15)
	flw	f2, 3(r16)
	fmul	f1, f1, f2
	fsw	f1, 0(r9)
	addi	r1, r0, 1
	j	beq_cont.15904
beq_then.15903:
	addi	r1, r0, 0
beq_cont.15904:
beq_cont.15900:
	j	beq_cont.15898
beq_then.15897:
	lw	r7, 0(r5)
	add	r5, r0, r15				# mr	r5, r15
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r12				# mr	r1, r12
	add	r29, r0, r8				# mr	r29, r8
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
beq_cont.15898:
	beqi	0, r1, beq_then.15905
	lw	r1, 9(r3)
	flw	f1, 0(r1)
	lw	r1, 8(r3)
	flw	f2, 0(r1)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.15907
	lw	r1, 7(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.15909
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	lw	r29, 5(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 7(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.15911
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	lw	r29, 5(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 7(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.15913
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
	addi	r1, r0, 4
	lw	r2, 7(r3)
	lw	r5, 0(r3)
	lw	r29, 4(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.15914
beq_then.15913:
beq_cont.15914:
	j	beq_cont.15912
beq_then.15911:
beq_cont.15912:
	j	beq_cont.15910
beq_then.15909:
beq_cont.15910:
	j	beq_cont.15908
beq_then.15907:
beq_cont.15908:
	j	beq_cont.15906
beq_then.15905:
beq_cont.15906:
	j	beq_cont.15896
beq_then.15895:
	lw	r6, 1(r14)
	beqi	-1, r6, beq_then.15915
	add	r30, r13, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r10, 4(r3)
	sw	r11, 5(r3)
	sw	r13, 6(r3)
	sw	r14, 7(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	add	r29, r0, r11				# mr	r29, r11
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 7(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.15917
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	lw	r29, 5(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 7(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.15919
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
	addi	r1, r0, 4
	lw	r2, 7(r3)
	lw	r5, 0(r3)
	lw	r29, 4(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.15920
beq_then.15919:
beq_cont.15920:
	j	beq_cont.15918
beq_then.15917:
beq_cont.15918:
	j	beq_cont.15916
beq_then.15915:
beq_cont.15916:
beq_cont.15896:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.15894:
	jr	r31				#
get_nvector_second.3145:
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
	beqi	0, r5, beq_then.15922
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
	j	beq_cont.15923
beq_then.15922:
	fsw	f4, 0(r2)
	fsw	f5, 1(r2)
	fsw	f6, 2(r2)
beq_cont.15923:
	lw	r1, 6(r1)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	vecunit_sgn.2853
utexture.3150:
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
	beqi	1, r6, beq_then.15924
	beqi	2, r6, beq_then.15925
	beqi	3, r6, beq_then.15926
	beqi	4, r6, beq_then.15927
	jr	r31				#
beq_then.15927:
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
	flup	f4, 0		# fli	f4, 0.000000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15929
	fadd	f4, f0, f1
	j	fle_cont.15930
fle_else.15929:
	fneg	f4, f1
fle_cont.15930:
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
	beqi	0, r1, beq_then.15932
	flup	f1, 34		# fli	f1, 15.000000
	j	beq_cont.15933
beq_then.15932:
	flw	f1, 6(r3)
	flw	f2, 8(r3)
	fdiv	f1, f2, f1
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15934
	j	fle_cont.15935
fle_else.15934:
	fneg	f1, f1
fle_cont.15935:
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan.2743				#	bl	atan.2743
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
beq_cont.15933:
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15936
	addi	r1, r0, 0
	j	feq_cont.15937
feq_else.15936:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15938
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.15939
fle_else.15938:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.15939:
feq_cont.15937:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15940
	j	fle_cont.15941
fle_else.15940:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.15941:
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
	flup	f3, 0		# fli	f3, 0.000000
	flw	f4, 2(r3)
	fle	r30, f3, f4
	beq	r0, r30, fle_else.15942
	fadd	f3, f0, f4
	j	fle_cont.15943
fle_else.15942:
	fneg	f3, f4
fle_cont.15943:
	flup	f5, 33		# fli	f5, 0.000100
	fsw	f1, 10(r3)
	fsw	f2, 12(r3)
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.15944
	flup	f1, 34		# fli	f1, 15.000000
	j	beq_cont.15945
beq_then.15944:
	flw	f1, 2(r3)
	flw	f2, 12(r3)
	fdiv	f1, f2, f1
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15946
	j	fle_cont.15947
fle_else.15946:
	fneg	f1, f1
fle_cont.15947:
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	atan.2743				#	bl	atan.2743
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
beq_cont.15945:
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15948
	addi	r1, r0, 0
	j	feq_cont.15949
feq_else.15948:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15950
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.15951
fle_else.15950:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.15951:
feq_cont.15949:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15952
	j	fle_cont.15953
fle_else.15952:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.15953:
	fsub	f1, f1, f2
	flup	f2, 36		# fli	f2, 0.150000
	flup	f3, 1		# fli	f3, 0.500000
	flw	f4, 10(r3)
	fsub	f3, f3, f4
	fmul	f3, f3, f3
	fsub	f2, f2, f3
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f1, f3, f1
	fmul	f1, f1, f1
	fsub	f1, f2, f1
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15954
	addi	r1, r0, 0
	j	fle_cont.15955
fle_else.15954:
	addi	r1, r0, 1
fle_cont.15955:
	beqi	0, r1, beq_then.15956
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.15957
beq_then.15956:
beq_cont.15957:
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f2, f1
	flup	f2, 38		# fli	f2, 0.300000
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.15926:
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
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.15959
	addi	r1, r0, 0
	j	feq_cont.15960
feq_else.15959:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15961
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.15962
fle_else.15961:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.15962:
feq_cont.15960:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15963
	j	fle_cont.15964
fle_else.15963:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.15964:
	fsub	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fmul	f1, f1, f2
	sw	r5, 0(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	cos.2739				#	bl	cos.2739
	addi	r3, r3, -15
	lw	r31, 14(r3)
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
beq_then.15925:
	flw	f1, 1(r2)
	flup	f2, 40		# fli	f2, 0.250000
	fmul	f1, f1, f2
	sw	r5, 0(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin.2737				#	bl	sin.2737
	addi	r3, r3, -15
	lw	r31, 14(r3)
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
beq_then.15924:
	flw	f1, 0(r2)
	lw	r6, 5(r1)
	flw	f2, 0(r6)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	flup	f3, 0		# fli	f3, 0.000000
	feq	r30, f2, f3
	beq	r0, r30, feq_else.15967
	addi	r6, r0, 0
	j	feq_cont.15968
feq_else.15967:
	flup	f3, 0		# fli	f3, 0.000000
	fle	r30, f3, f2
	beq	r0, r30, fle_else.15969
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r6, f3
	j	fle_cont.15970
fle_else.15969:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r6, f3
fle_cont.15970:
feq_cont.15968:
	itof	f3, r6
	fle	r30, f3, f2
	beq	r0, r30, fle_else.15971
	fadd	f2, f0, f3
	j	fle_cont.15972
fle_else.15971:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.15972:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	fsub	f1, f1, f2
	flup	f2, 39		# fli	f2, 10.000000
	sw	r5, 0(r3)
	sw	r1, 4(r3)
	sw	r2, 5(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 5(r3)
	flw	f1, 2(r2)
	lw	r2, 4(r3)
	lw	r2, 5(r2)
	flw	f2, 2(r2)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	flup	f3, 0		# fli	f3, 0.000000
	feq	r30, f2, f3
	beq	r0, r30, feq_else.15973
	addi	r2, r0, 0
	j	feq_cont.15974
feq_else.15973:
	flup	f3, 0		# fli	f3, 0.000000
	fle	r30, f3, f2
	beq	r0, r30, fle_else.15975
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r2, f3
	j	fle_cont.15976
fle_else.15975:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r2, f3
fle_cont.15976:
feq_cont.15974:
	itof	f3, r2
	fle	r30, f3, f2
	beq	r0, r30, fle_else.15977
	fadd	f2, f0, f3
	j	fle_cont.15978
fle_else.15977:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.15978:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	fsub	f1, f1, f2
	flup	f2, 39		# fli	f2, 10.000000
	sw	r1, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 14(r3)
	beqi	0, r2, beq_then.15979
	beqi	0, r1, beq_then.15981
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.15982
beq_then.15981:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.15982:
	j	beq_cont.15980
beq_then.15979:
	beqi	0, r1, beq_then.15983
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.15984
beq_then.15983:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.15984:
beq_cont.15980:
	lw	r1, 0(r3)
	fsw	f1, 1(r1)
	jr	r31				#
add_light.3153:
	lw	r2, 2(r29)
	lw	r1, 1(r29)
	flup	f4, 0		# fli	f4, 0.000000
	fle	r30, f1, f4
	beq	r0, r30, fle_else.15986
	addi	r5, r0, 0
	j	fle_cont.15987
fle_else.15986:
	addi	r5, r0, 1
fle_cont.15987:
	sw	r1, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	beqi	0, r5, beq_then.15989
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecaccum.2864				#	bl	vecaccum.2864
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.15990
beq_then.15989:
beq_cont.15990:
	flup	f1, 0		# fli	f1, 0.000000
	flw	f2, 4(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15991
	addi	r1, r0, 0
	j	fle_cont.15992
fle_else.15991:
	addi	r1, r0, 1
fle_cont.15992:
	beqi	0, r1, beq_then.15993
	fmul	f1, f2, f2
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
beq_then.15993:
	jr	r31				#
trace_reflections.3157:
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
	ble	r14, r1, ble_then.15996
	jr	r31				#
ble_then.15996:
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
	flw	f2, 0(r1)
	flup	f1, 30		# fli	f1, -0.100000
	fsw	f2, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.15998
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	j	beq_cont.15999
beq_then.15998:
	addi	r1, r0, 0
beq_cont.15999:
	beqi	0, r1, beq_then.16000
	lw	r1, 14(r3)
	lw	r1, 0(r1)
	slli	r1, r1, 2
	lw	r2, 13(r3)
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 12(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.16002
	j	beq_cont.16003
beq_then.16002:
	addi	r1, r0, 0
	lw	r5, 11(r3)
	lw	r5, 0(r5)
	lw	r29, 10(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.16004
	j	beq_cont.16005
beq_then.16004:
	lw	r1, 9(r3)
	lw	r2, 0(r1)
	lw	r5, 8(r3)
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
	lw	r2, 12(r3)
	flw	f2, 2(r2)
	flw	f3, 6(r3)
	fmul	f4, f2, f3
	fmul	f1, f4, f1
	lw	r1, 0(r1)
	lw	r2, 5(r3)
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
	flw	f4, 2(r3)
	lw	r29, 4(r3)
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
beq_cont.16005:
beq_cont.16003:
	j	beq_cont.16001
beq_then.16000:
beq_cont.16001:
	lw	r1, 1(r3)
	addi	r1, r1, -1
	flw	f1, 6(r3)
	flw	f2, 2(r3)
	lw	r2, 5(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
trace_ray.3162:
	lw	r6, 24(r29)
	lw	r7, 23(r29)
	lw	r8, 22(r29)
	lw	r9, 21(r29)
	lw	r10, 20(r29)
	lw	r11, 19(r29)
	lw	r12, 18(r29)
	lw	r13, 17(r29)
	lw	r14, 16(r29)
	lw	r15, 15(r29)
	lw	r16, 14(r29)
	lw	r17, 13(r29)
	lw	r18, 12(r29)
	lw	r19, 11(r29)
	lw	r20, 10(r29)
	lw	r21, 9(r29)
	lw	r22, 8(r29)
	lw	r23, 7(r29)
	lw	r24, 6(r29)
	lw	r25, 5(r29)
	lw	r26, 4(r29)
	lw	r27, 3(r29)
	lw	r28, 2(r29)
	sw	r29, 0(r3)
	lw	r29, 1(r29)
	blei	4, r1, ble_then.16006
	jr	r31				#
ble_then.16006:
	sw	r8, 1(r3)
	lw	r8, 2(r5)
	flup	f3, 31		# fli	f3, 1000000000.000000
	fsw	f3, 0(r10)
	sw	r20, 2(r3)
	addi	r20, r0, 0
	sw	r15, 3(r3)
	lw	r15, 0(r17)
	fsw	f2, 4(r3)
	sw	r21, 6(r3)
	sw	r12, 7(r3)
	sw	r29, 8(r3)
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
	sw	r8, 31(r3)
	sw	r10, 32(r3)
	add	r5, r0, r2				# mr	r5, r2
	add	r1, r0, r20				# mr	r1, r20
	add	r29, r0, r9				# mr	r29, r9
	add	r2, r0, r15				# mr	r2, r15
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
	beqi	0, r1, beq_then.16010
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 34(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -37
	lw	r31, 36(r3)
	j	beq_cont.16011
beq_then.16010:
	addi	r1, r0, 0
beq_cont.16011:
	beqi	0, r1, beq_then.16012
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
	beqi	1, r6, beq_then.16014
	beqi	2, r6, beq_then.16016
	lw	r29, 18(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -43
	lw	r31, 42(r3)
	j	beq_cont.16017
beq_then.16016:
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
beq_cont.16017:
	j	beq_cont.16015
beq_then.16014:
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
	flup	f4, 0		# fli	f4, 0.000000
	feq	r30, f3, f4
	beq	r0, r30, feq_else.16018
	addi	r7, r0, 1
	j	feq_cont.16019
feq_else.16018:
	addi	r7, r0, 0
feq_cont.16019:
	beqi	0, r7, beq_then.16020
	flup	f3, 0		# fli	f3, 0.000000
	j	beq_cont.16021
beq_then.16020:
	flup	f4, 0		# fli	f4, 0.000000
	fle	r30, f3, f4
	beq	r0, r30, fle_else.16022
	addi	r7, r0, 0
	j	fle_cont.16023
fle_else.16022:
	addi	r7, r0, 1
fle_cont.16023:
	beqi	0, r7, beq_then.16024
	flup	f3, 2		# fli	f3, 1.000000
	j	beq_cont.16025
beq_then.16024:
	flup	f3, 11		# fli	f3, -1.000000
beq_cont.16025:
beq_cont.16021:
	fneg	f3, f3
	add	r30, r8, r9
	fsw	f3, 0(r30)
beq_cont.16015:
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
	beqi	0, r1, beq_then.16026
	lw	r1, 30(r3)
	lw	r2, 42(r3)
	lw	r5, 11(r3)
	add	r30, r2, r1
	sw	r5, 0(r30)
	j	beq_cont.16027
beq_then.16026:
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
beq_cont.16027:
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
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 43(r3)
	addi	r3, r3, 44
	jal	vecaccum.2864				#	bl	vecaccum.2864
	addi	r3, r3, -44
	lw	r31, 43(r3)
	lw	r1, 41(r3)
	lw	r2, 7(r1)
	flw	f1, 1(r2)
	flw	f2, 26(r3)
	fmul	f1, f2, f1
	addi	r2, r0, 0
	lw	r5, 10(r3)
	lw	r5, 0(r5)
	lw	r29, 9(r3)
	fsw	f1, 44(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -47
	lw	r31, 46(r3)
	beqi	0, r1, beq_then.16029
	j	beq_cont.16030
beq_then.16029:
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
	flw	f4, 44(r3)
	lw	r29, 8(r3)
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -47
	lw	r31, 46(r3)
beq_cont.16030:
	lw	r1, 17(r3)
	flw	f1, 0(r1)
	lw	r2, 7(r3)
	fsw	f1, 0(r2)
	flw	f1, 1(r1)
	fsw	f1, 1(r2)
	flw	f1, 2(r1)
	fsw	f1, 2(r2)
	lw	r2, 6(r3)
	lw	r2, 0(r2)
	addi	r2, r2, -1
	lw	r29, 3(r3)
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
	beqi	0, r1, beq_then.16031
	addi	r1, r0, 4
	lw	r2, 30(r3)
	ble	r1, r2, ble_then.16032
	addi	r1, r2, 1
	addi	r5, r0, -1
	lw	r6, 31(r3)
	add	r30, r6, r1
	sw	r5, 0(r30)
	j	ble_cont.16033
ble_then.16032:
ble_cont.16033:
	lw	r1, 36(r3)
	beqi	2, r1, beq_then.16034
	j	beq_cont.16035
beq_then.16034:
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
beq_cont.16035:
	jr	r31				#
beq_then.16031:
	jr	r31				#
beq_then.16012:
	addi	r1, r0, -1
	lw	r2, 30(r3)
	lw	r5, 31(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	0, r2, beq_then.16038
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
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16039
	addi	r1, r0, 0
	j	fle_cont.16040
fle_else.16039:
	addi	r1, r0, 1
fle_cont.16040:
	beqi	0, r1, beq_then.16041
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
beq_then.16041:
	jr	r31				#
beq_then.16038:
	jr	r31				#
trace_diffuse_ray.3168:
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
	beqi	0, r1, beq_then.16045
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	j	beq_cont.16046
beq_then.16045:
	addi	r1, r0, 0
beq_cont.16046:
	beqi	0, r1, beq_then.16047
	lw	r1, 14(r3)
	lw	r1, 0(r1)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 12(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	sw	r1, 18(r3)
	beqi	1, r5, beq_then.16048
	beqi	2, r5, beq_then.16050
	lw	r29, 9(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
	j	beq_cont.16051
beq_then.16050:
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
beq_cont.16051:
	j	beq_cont.16049
beq_then.16048:
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
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.16052
	addi	r2, r0, 1
	j	feq_cont.16053
feq_else.16052:
	addi	r2, r0, 0
feq_cont.16053:
	beqi	0, r2, beq_then.16054
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16055
beq_then.16054:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16056
	addi	r2, r0, 0
	j	fle_cont.16057
fle_else.16056:
	addi	r2, r0, 1
fle_cont.16057:
	beqi	0, r2, beq_then.16058
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16059
beq_then.16058:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.16059:
beq_cont.16055:
	fneg	f1, f1
	add	r30, r6, r7
	fsw	f1, 0(r30)
beq_cont.16049:
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
	beqi	0, r1, beq_then.16060
	jr	r31				#
beq_then.16060:
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
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16062
	addi	r1, r0, 0
	j	fle_cont.16063
fle_else.16062:
	addi	r1, r0, 1
fle_cont.16063:
	beqi	0, r1, beq_then.16064
	j	beq_cont.16065
beq_then.16064:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.16065:
	flw	f2, 2(r3)
	fmul	f1, f2, f1
	lw	r1, 18(r3)
	lw	r1, 7(r1)
	flw	f2, 0(r1)
	fmul	f1, f1, f2
	lw	r1, 1(r3)
	lw	r2, 0(r3)
	j	vecaccum.2864
beq_then.16047:
	jr	r31				#
iter_trace_diffuse_rays.3171:
	lw	r7, 1(r29)
	addi	r8, r0, 0
	ble	r8, r6, ble_then.16067
	jr	r31				#
ble_then.16067:
	add	r30, r1, r6
	lw	r8, 0(r30)
	lw	r8, 0(r8)
	flw	f1, 0(r8)
	flw	f2, 0(r2)
	fmul	f1, f1, f2
	flw	f2, 1(r8)
	flw	f3, 1(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r8)
	flw	f3, 2(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16069
	addi	r8, r0, 0
	j	fle_cont.16070
fle_else.16069:
	addi	r8, r0, 1
fle_cont.16070:
	sw	r5, 0(r3)
	sw	r29, 1(r3)
	sw	r7, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	sw	r6, 5(r3)
	beqi	0, r8, beq_then.16071
	addi	r8, r6, 1
	add	r30, r1, r8
	lw	r8, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r8				# mr	r1, r8
	add	r29, r0, r7				# mr	r29, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16072
beq_then.16071:
	add	r30, r1, r6
	lw	r8, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r8				# mr	r1, r8
	add	r29, r0, r7				# mr	r29, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.16072:
	lw	r1, 5(r3)
	addi	r1, r1, -2
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16073
	jr	r31				#
ble_then.16073:
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
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16075
	addi	r5, r0, 0
	j	fle_cont.16076
fle_else.16075:
	addi	r5, r0, 1
fle_cont.16076:
	sw	r1, 6(r3)
	beqi	0, r5, beq_then.16077
	addi	r5, r1, 1
	add	r30, r2, r5
	lw	r5, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	lw	r29, 2(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.16078
beq_then.16077:
	add	r30, r2, r1
	lw	r5, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	lw	r29, 2(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.16078:
	lw	r1, 6(r3)
	addi	r6, r1, -2
	lw	r1, 4(r3)
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
trace_diffuse_ray_80percent.3180:
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
	beqi	0, r1, beq_then.16079
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
	j	beq_cont.16080
beq_then.16079:
beq_cont.16080:
	lw	r1, 7(r3)
	beqi	1, r1, beq_then.16081
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
	j	beq_cont.16082
beq_then.16081:
beq_cont.16082:
	lw	r1, 7(r3)
	beqi	2, r1, beq_then.16083
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
	j	beq_cont.16084
beq_then.16083:
beq_cont.16084:
	lw	r1, 7(r3)
	beqi	3, r1, beq_then.16085
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
	j	beq_cont.16086
beq_then.16085:
beq_cont.16086:
	lw	r1, 7(r3)
	beqi	4, r1, beq_then.16087
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
beq_then.16087:
	jr	r31				#
calc_diffuse_using_1point.3184:
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
	j	vecaccumv.2877
calc_diffuse_using_5points.3187:
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
	j	vecaccumv.2877
do_without_neighbors.3193:
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	blei	4, r2, ble_then.16089
	jr	r31				#
ble_then.16089:
	lw	r9, 2(r1)
	addi	r10, r0, 0
	add	r30, r9, r2
	lw	r9, 0(r30)
	ble	r10, r9, ble_then.16091
	jr	r31				#
ble_then.16091:
	lw	r9, 3(r1)
	add	r30, r9, r2
	lw	r9, 0(r30)
	sw	r29, 0(r3)
	sw	r8, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	beqi	0, r9, beq_then.16093
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
	jal	vecaccumv.2877				#	bl	vecaccumv.2877
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.16094
beq_then.16093:
beq_cont.16094:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	blei	4, r2, ble_then.16095
	jr	r31				#
ble_then.16095:
	lw	r1, 2(r3)
	lw	r5, 2(r1)
	addi	r6, r0, 0
	add	r30, r5, r2
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.16097
	jr	r31				#
ble_then.16097:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 7(r3)
	beqi	0, r5, beq_then.16099
	lw	r29, 1(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.16100
beq_then.16099:
beq_cont.16100:
	lw	r1, 7(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
try_exploit_neighbors.3209:
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	add	r30, r6, r1
	lw	r12, 0(r30)
	blei	4, r8, ble_then.16101
	jr	r31				#
ble_then.16101:
	addi	r13, r0, 0
	lw	r14, 2(r12)
	add	r30, r14, r8
	lw	r14, 0(r30)
	ble	r13, r14, ble_then.16103
	jr	r31				#
ble_then.16103:
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
	beq	r14, r13, beq_then.16105
	addi	r13, r0, 0
	j	beq_cont.16106
beq_then.16105:
	add	r30, r7, r1
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.16107
	addi	r13, r0, 0
	j	beq_cont.16108
beq_then.16107:
	addi	r14, r1, -1
	add	r30, r6, r14
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.16109
	addi	r13, r0, 0
	j	beq_cont.16110
beq_then.16109:
	addi	r14, r1, 1
	add	r30, r6, r14
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.16111
	addi	r13, r0, 0
	j	beq_cont.16112
beq_then.16111:
	addi	r13, r0, 1
beq_cont.16112:
beq_cont.16110:
beq_cont.16108:
beq_cont.16106:
	beqi	0, r13, beq_then.16113
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
	beqi	0, r11, beq_then.16114
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
	j	beq_cont.16115
beq_then.16114:
beq_cont.16115:
	lw	r1, 8(r3)
	addi	r2, r1, 1
	lw	r1, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r1
	lw	r6, 0(r30)
	blei	4, r2, ble_then.16116
	jr	r31				#
ble_then.16116:
	addi	r7, r0, 0
	lw	r8, 2(r6)
	add	r30, r8, r2
	lw	r8, 0(r30)
	ble	r7, r8, ble_then.16118
	jr	r31				#
ble_then.16118:
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
	beq	r9, r7, beq_then.16120
	addi	r7, r0, 0
	j	beq_cont.16121
beq_then.16120:
	lw	r9, 4(r3)
	add	r30, r9, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.16122
	addi	r7, r0, 0
	j	beq_cont.16123
beq_then.16122:
	addi	r10, r1, -1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.16124
	addi	r7, r0, 0
	j	beq_cont.16125
beq_then.16124:
	addi	r10, r1, 1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.16126
	addi	r7, r0, 0
	j	beq_cont.16127
beq_then.16126:
	addi	r7, r0, 1
beq_cont.16127:
beq_cont.16125:
beq_cont.16123:
beq_cont.16121:
	beqi	0, r7, beq_then.16128
	lw	r6, 3(r6)
	add	r30, r6, r2
	lw	r6, 0(r30)
	sw	r2, 9(r3)
	beqi	0, r6, beq_then.16129
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
	j	beq_cont.16130
beq_then.16129:
beq_cont.16130:
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
beq_then.16128:
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r29, 3(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.16113:
	add	r30, r6, r1
	lw	r1, 0(r30)
	blei	4, r8, ble_then.16131
	jr	r31				#
ble_then.16131:
	lw	r2, 2(r1)
	addi	r5, r0, 0
	add	r30, r2, r8
	lw	r2, 0(r30)
	ble	r5, r2, ble_then.16133
	jr	r31				#
ble_then.16133:
	lw	r2, 3(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	sw	r1, 10(r3)
	sw	r9, 3(r3)
	sw	r8, 8(r3)
	beqi	0, r2, beq_then.16135
	add	r2, r0, r8				# mr	r2, r8
	add	r29, r0, r11				# mr	r29, r11
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.16136
beq_then.16135:
beq_cont.16136:
	lw	r1, 8(r3)
	addi	r2, r1, 1
	lw	r1, 10(r3)
	lw	r29, 3(r3)
	lw	r28, 0(r29)
	jr	r28
write_ppm_header.3216:
	lw	r1, 1(r29)
	addi	r2, r0, 80
	sw	r1, 0(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 51
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 10
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 0(r1)
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16137
	addi	r5, r0, 45
	sw	r2, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	sub	r1, r0, r1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.16138
ble_then.16137:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -3
	lw	r31, 2(r3)
ble_cont.16138:
	addi	r1, r0, 32
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 0(r3)
	lw	r1, 1(r1)
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16139
	addi	r2, r0, 45
	sw	r1, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	sub	r1, r0, r1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	ble_cont.16140
ble_then.16139:
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -4
	lw	r31, 3(r3)
ble_cont.16140:
	addi	r1, r0, 32
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 255
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 10
	j	lib_print_char
write_rgb.3220:
	lw	r1, 1(r29)
	flw	f1, 0(r1)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.16141
	addi	r2, r0, 0
	j	feq_cont.16142
feq_else.16141:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16143
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.16144
fle_else.16143:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.16144:
feq_cont.16142:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.16145
	addi	r5, r0, 255
	j	ble_cont.16146
ble_then.16145:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16147
	addi	r5, r0, 0
	j	ble_cont.16148
ble_then.16147:
	add	r5, r0, r2
ble_cont.16148:
ble_cont.16146:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	ble	r2, r5, ble_then.16149
	addi	r2, r0, 45
	sw	r5, 1(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	sub	r1, r0, r1
	addi	r2, r0, 10
	ble	r2, r1, ble_then.16151
	addi	r1, r1, 48
	out	r1
	j	ble_cont.16152
ble_then.16151:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	sw	r1, 2(r3)
	ble	r6, r1, ble_then.16153
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2749				#	bl	div10_sub.2749
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	ble_cont.16154
ble_then.16153:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.16155
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2749				#	bl	div10_sub.2749
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	ble_cont.16156
ble_then.16155:
	add	r1, r0, r5
ble_cont.16156:
ble_cont.16154:
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 2(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.16152:
	j	ble_cont.16150
ble_then.16149:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.16157
	addi	r2, r5, 48
	out	r2
	j	ble_cont.16158
ble_then.16157:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 1(r3)
	ble	r7, r5, ble_then.16159
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2749				#	bl	div10_sub.2749
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.16160
ble_then.16159:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.16161
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2749				#	bl	div10_sub.2749
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.16162
ble_then.16161:
	add	r1, r0, r6
ble_cont.16162:
ble_cont.16160:
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 1(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.16158:
ble_cont.16150:
	addi	r1, r0, 32
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 0(r3)
	flw	f1, 1(r1)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.16163
	addi	r2, r0, 0
	j	feq_cont.16164
feq_else.16163:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16165
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.16166
fle_else.16165:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.16166:
feq_cont.16164:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.16167
	addi	r5, r0, 255
	j	ble_cont.16168
ble_then.16167:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16169
	addi	r5, r0, 0
	j	ble_cont.16170
ble_then.16169:
	add	r5, r0, r2
ble_cont.16170:
ble_cont.16168:
	addi	r2, r0, 0
	ble	r2, r5, ble_then.16171
	addi	r2, r0, 45
	sw	r5, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	sub	r1, r0, r1
	addi	r2, r0, 10
	ble	r2, r1, ble_then.16173
	addi	r1, r1, 48
	out	r1
	j	ble_cont.16174
ble_then.16173:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	sw	r1, 6(r3)
	ble	r6, r1, ble_then.16175
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	div10_sub.2749				#	bl	div10_sub.2749
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	ble_cont.16176
ble_then.16175:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.16177
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	div10_sub.2749				#	bl	div10_sub.2749
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	ble_cont.16178
ble_then.16177:
	add	r1, r0, r5
ble_cont.16178:
ble_cont.16176:
	sw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 7(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 6(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.16174:
	j	ble_cont.16172
ble_then.16171:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.16179
	addi	r2, r5, 48
	out	r2
	j	ble_cont.16180
ble_then.16179:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 5(r3)
	ble	r7, r5, ble_then.16181
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	div10_sub.2749				#	bl	div10_sub.2749
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	ble_cont.16182
ble_then.16181:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.16183
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	div10_sub.2749				#	bl	div10_sub.2749
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	ble_cont.16184
ble_then.16183:
	add	r1, r0, r6
ble_cont.16184:
ble_cont.16182:
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 8(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 5(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.16180:
ble_cont.16172:
	addi	r1, r0, 32
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 0(r3)
	flw	f1, 2(r1)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.16185
	addi	r1, r0, 0
	j	feq_cont.16186
feq_else.16185:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16187
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.16188
fle_else.16187:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.16188:
feq_cont.16186:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16189
	addi	r1, r0, 255
	j	ble_cont.16190
ble_then.16189:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16191
	addi	r1, r0, 0
	j	ble_cont.16192
ble_then.16191:
ble_cont.16192:
ble_cont.16190:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16193
	addi	r2, r0, 45
	sw	r1, 9(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 9(r3)
	sub	r1, r0, r1
	addi	r2, r0, 10
	ble	r2, r1, ble_then.16195
	addi	r1, r1, 48
	out	r1
	j	ble_cont.16196
ble_then.16195:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	sw	r1, 10(r3)
	ble	r6, r1, ble_then.16197
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	div10_sub.2749				#	bl	div10_sub.2749
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	ble_cont.16198
ble_then.16197:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.16199
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	div10_sub.2749				#	bl	div10_sub.2749
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	ble_cont.16200
ble_then.16199:
	add	r1, r0, r5
ble_cont.16200:
ble_cont.16198:
	sw	r1, 11(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 11(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 10(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.16196:
	j	ble_cont.16194
ble_then.16193:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.16201
	addi	r1, r1, 48
	out	r1
	j	ble_cont.16202
ble_then.16201:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	sw	r1, 9(r3)
	ble	r6, r1, ble_then.16203
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	div10_sub.2749				#	bl	div10_sub.2749
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.16204
ble_then.16203:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.16205
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	div10_sub.2749				#	bl	div10_sub.2749
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.16206
ble_then.16205:
	add	r1, r0, r5
ble_cont.16206:
ble_cont.16204:
	sw	r1, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 12(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 9(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.16202:
ble_cont.16194:
	addi	r1, r0, 10
	j	lib_print_char
pretrace_diffuse_rays.3222:
	lw	r5, 6(r29)
	lw	r6, 5(r29)
	lw	r7, 4(r29)
	lw	r8, 3(r29)
	lw	r9, 2(r29)
	lw	r10, 1(r29)
	blei	4, r2, ble_then.16207
	jr	r31				#
ble_then.16207:
	lw	r11, 2(r1)
	add	r30, r11, r2
	lw	r11, 0(r30)
	addi	r12, r0, 0
	ble	r12, r11, ble_then.16209
	jr	r31				#
ble_then.16209:
	lw	r11, 3(r1)
	add	r30, r11, r2
	lw	r11, 0(r30)
	sw	r29, 0(r3)
	sw	r2, 1(r3)
	beqi	0, r11, beq_then.16211
	lw	r11, 6(r1)
	lw	r11, 0(r11)
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r10)
	fsw	f1, 1(r10)
	fsw	f1, 2(r10)
	lw	r12, 7(r1)
	lw	r13, 1(r1)
	add	r30, r9, r11
	lw	r9, 0(r30)
	add	r30, r12, r2
	lw	r11, 0(r30)
	add	r30, r13, r2
	lw	r12, 0(r30)
	flw	f1, 0(r12)
	fsw	f1, 0(r5)
	flw	f1, 1(r12)
	fsw	f1, 1(r5)
	flw	f1, 2(r12)
	fsw	f1, 2(r5)
	lw	r5, 0(r7)
	addi	r5, r5, -1
	sw	r10, 2(r3)
	sw	r1, 3(r3)
	sw	r12, 4(r3)
	sw	r11, 5(r3)
	sw	r9, 6(r3)
	sw	r8, 7(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r12				# mr	r1, r12
	add	r29, r0, r6				# mr	r29, r6
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
	j	beq_cont.16212
beq_then.16211:
beq_cont.16212:
	lw	r2, 1(r3)
	addi	r2, r2, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_pixels.3225:
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
	ble	r16, r2, ble_then.16213
	jr	r31				#
ble_then.16213:
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
	jal	vecunit_sgn.2853				#	bl	vecunit_sgn.2853
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
	ble	r5, r1, ble_then.16215
	add	r5, r0, r1
	j	ble_cont.16216
ble_then.16215:
	addi	r5, r1, -5
ble_cont.16216:
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r1, 12(r3)
	lw	r29, 6(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_line.3232:
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
scan_pixel.3236:
	lw	r8, 7(r29)
	lw	r9, 6(r29)
	lw	r10, 5(r29)
	lw	r11, 4(r29)
	lw	r12, 3(r29)
	lw	r13, 2(r29)
	lw	r14, 1(r29)
	lw	r15, 0(r11)
	ble	r15, r1, ble_then.16217
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
	ble	r15, r16, ble_then.16218
	blei	0, r2, ble_then.16220
	lw	r15, 0(r11)
	addi	r16, r1, 1
	ble	r15, r16, ble_then.16222
	blei	0, r1, ble_then.16224
	addi	r15, r0, 1
	j	ble_cont.16225
ble_then.16224:
	addi	r15, r0, 0
ble_cont.16225:
	j	ble_cont.16223
ble_then.16222:
	addi	r15, r0, 0
ble_cont.16223:
	j	ble_cont.16221
ble_then.16220:
	addi	r15, r0, 0
ble_cont.16221:
	j	ble_cont.16219
ble_then.16218:
	addi	r15, r0, 0
ble_cont.16219:
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
	beqi	0, r15, beq_then.16226
	addi	r14, r0, 0
	add	r30, r6, r1
	lw	r15, 0(r30)
	addi	r16, r0, 0
	lw	r17, 2(r15)
	lw	r17, 0(r17)
	ble	r16, r17, ble_then.16228
	j	ble_cont.16229
ble_then.16228:
	add	r30, r6, r1
	lw	r16, 0(r30)
	lw	r16, 2(r16)
	lw	r16, 0(r16)
	add	r30, r5, r1
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.16230
	addi	r16, r0, 0
	j	beq_cont.16231
beq_then.16230:
	add	r30, r7, r1
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.16232
	addi	r16, r0, 0
	j	beq_cont.16233
beq_then.16232:
	addi	r17, r1, -1
	add	r30, r6, r17
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.16234
	addi	r16, r0, 0
	j	beq_cont.16235
beq_then.16234:
	addi	r17, r1, 1
	add	r30, r6, r17
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.16236
	addi	r16, r0, 0
	j	beq_cont.16237
beq_then.16236:
	addi	r16, r0, 1
beq_cont.16237:
beq_cont.16235:
beq_cont.16233:
beq_cont.16231:
	beqi	0, r16, beq_then.16238
	lw	r15, 3(r15)
	lw	r15, 0(r15)
	beqi	0, r15, beq_then.16240
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
	j	beq_cont.16241
beq_then.16240:
beq_cont.16241:
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
	j	beq_cont.16239
beq_then.16238:
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
beq_cont.16239:
ble_cont.16229:
	j	beq_cont.16227
beq_then.16226:
	add	r30, r6, r1
	lw	r13, 0(r30)
	addi	r15, r0, 0
	lw	r16, 2(r13)
	addi	r17, r0, 0
	lw	r16, 0(r16)
	ble	r17, r16, ble_then.16242
	j	ble_cont.16243
ble_then.16242:
	lw	r16, 3(r13)
	lw	r16, 0(r16)
	sw	r13, 11(r3)
	beqi	0, r16, beq_then.16244
	add	r2, r0, r15				# mr	r2, r15
	add	r1, r0, r13				# mr	r1, r13
	add	r29, r0, r14				# mr	r29, r14
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.16245
beq_then.16244:
beq_cont.16245:
	addi	r2, r0, 1
	lw	r1, 11(r3)
	lw	r29, 5(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.16243:
beq_cont.16227:
	lw	r1, 10(r3)
	flw	f1, 0(r1)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.16246
	addi	r2, r0, 0
	j	feq_cont.16247
feq_else.16246:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16248
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.16249
fle_else.16248:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.16249:
feq_cont.16247:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.16250
	addi	r2, r0, 255
	j	ble_cont.16251
ble_then.16250:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16252
	addi	r2, r0, 0
	j	ble_cont.16253
ble_then.16252:
ble_cont.16253:
ble_cont.16251:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16254
	addi	r5, r0, 45
	sw	r2, 12(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 12(r3)
	sub	r1, r0, r1
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	ble_cont.16255
ble_then.16254:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -14
	lw	r31, 13(r3)
ble_cont.16255:
	addi	r1, r0, 32
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 10(r3)
	flw	f1, 1(r1)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.16256
	addi	r2, r0, 0
	j	feq_cont.16257
feq_else.16256:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16258
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.16259
fle_else.16258:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.16259:
feq_cont.16257:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.16260
	addi	r2, r0, 255
	j	ble_cont.16261
ble_then.16260:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16262
	addi	r2, r0, 0
	j	ble_cont.16263
ble_then.16262:
ble_cont.16263:
ble_cont.16261:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16264
	addi	r5, r0, 45
	sw	r2, 13(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 13(r3)
	sub	r1, r0, r1
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -15
	lw	r31, 14(r3)
	j	ble_cont.16265
ble_then.16264:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -15
	lw	r31, 14(r3)
ble_cont.16265:
	addi	r1, r0, 32
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 10(r3)
	flw	f1, 2(r1)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.16266
	addi	r2, r0, 0
	j	feq_cont.16267
feq_else.16266:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16268
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.16269
fle_else.16268:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.16269:
feq_cont.16267:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.16270
	addi	r2, r0, 255
	j	ble_cont.16271
ble_then.16270:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16272
	addi	r2, r0, 0
	j	ble_cont.16273
ble_then.16272:
ble_cont.16273:
ble_cont.16271:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16274
	addi	r5, r0, 45
	sw	r2, 14(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r1, 14(r3)
	sub	r1, r0, r1
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -16
	lw	r31, 15(r3)
	j	ble_cont.16275
ble_then.16274:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	print_uint.2769				#	bl	print_uint.2769
	addi	r3, r3, -16
	lw	r31, 15(r3)
ble_cont.16275:
	addi	r1, r0, 10
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r1, 9(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 0(r2)
	ble	r5, r1, ble_then.16276
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
	ble	r5, r8, ble_then.16277
	blei	0, r7, ble_then.16279
	lw	r2, 0(r2)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.16281
	blei	0, r1, ble_then.16283
	addi	r2, r0, 1
	j	ble_cont.16284
ble_then.16283:
	addi	r2, r0, 0
ble_cont.16284:
	j	ble_cont.16282
ble_then.16281:
	addi	r2, r0, 0
ble_cont.16282:
	j	ble_cont.16280
ble_then.16279:
	addi	r2, r0, 0
ble_cont.16280:
	j	ble_cont.16278
ble_then.16277:
	addi	r2, r0, 0
ble_cont.16278:
	sw	r1, 15(r3)
	beqi	0, r2, beq_then.16285
	addi	r8, r0, 0
	lw	r5, 3(r3)
	lw	r2, 2(r3)
	lw	r29, 4(r3)
	add	r28, r0, r7				# mr	r28, r7
	add	r7, r0, r2				# mr	r7, r2
	add	r2, r0, r28				# mr	r2, r28
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
	j	beq_cont.16286
beq_then.16285:
	add	r30, r6, r1
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r29, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
beq_cont.16286:
	lw	r29, 1(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r1, 15(r3)
	addi	r1, r1, 1
	lw	r2, 6(r3)
	lw	r5, 3(r3)
	lw	r6, 7(r3)
	lw	r7, 2(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
ble_then.16276:
	jr	r31				#
ble_then.16217:
	jr	r31				#
scan_line.3242:
	lw	r8, 7(r29)
	lw	r9, 6(r29)
	lw	r10, 5(r29)
	lw	r11, 4(r29)
	lw	r12, 3(r29)
	lw	r13, 2(r29)
	lw	r14, 1(r29)
	lw	r15, 1(r13)
	ble	r15, r1, ble_then.16289
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
	ble	r15, r1, ble_then.16290
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
	j	ble_cont.16291
ble_then.16290:
ble_cont.16291:
	addi	r1, r0, 0
	lw	r2, 12(r3)
	lw	r5, 0(r2)
	blei	0, r5, ble_then.16292
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
	ble	r5, r8, ble_then.16294
	blei	0, r7, ble_then.16296
	lw	r5, 0(r2)
	blei	1, r5, ble_then.16298
	addi	r5, r0, 0
	j	ble_cont.16299
ble_then.16298:
	addi	r5, r0, 0
ble_cont.16299:
	j	ble_cont.16297
ble_then.16296:
	addi	r5, r0, 0
ble_cont.16297:
	j	ble_cont.16295
ble_then.16294:
	addi	r5, r0, 0
ble_cont.16295:
	beqi	0, r5, beq_then.16300
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
	j	beq_cont.16301
beq_then.16300:
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
beq_cont.16301:
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
	j	ble_cont.16293
ble_then.16292:
ble_cont.16293:
	lw	r1, 9(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	addi	r1, r1, 2
	addi	r5, r0, 5
	ble	r5, r1, ble_then.16302
	add	r5, r0, r1
	j	ble_cont.16303
ble_then.16302:
	addi	r5, r1, -5
ble_cont.16303:
	lw	r1, 12(r3)
	lw	r6, 1(r1)
	ble	r6, r2, ble_then.16304
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r5, 13(r3)
	sw	r2, 14(r3)
	ble	r1, r2, ble_then.16306
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
	j	ble_cont.16307
ble_then.16306:
ble_cont.16307:
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
	ble	r5, r2, ble_then.16308
	add	r7, r0, r2
	j	ble_cont.16309
ble_then.16308:
	addi	r7, r2, -5
ble_cont.16309:
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
	j	ble_cont.16305
ble_then.16304:
ble_cont.16305:
	jr	r31				#
ble_then.16289:
	jr	r31				#
create_float5x3array.3248:
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
init_line_elements.3252:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.16312
	jr	r31				#
ble_then.16312:
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
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
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
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
	addi	r3, r3, -9
	lw	r31, 8(r3)
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
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
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
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
	ble	r2, r1, ble_then.16313
	add	r1, r0, r5
	jr	r31				#
ble_then.16313:
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
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
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
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
	addi	r3, r3, -17
	lw	r31, 16(r3)
	sw	r1, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
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
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
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
calc_dirvec.3262:
	lw	r6, 1(r29)
	addi	r7, r0, 5
	ble	r7, r1, ble_then.16314
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
	jal	atan.2743				#	bl	atan.2743
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin.2737				#	bl	sin.2737
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fsw	f1, 14(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	cos.2739				#	bl	cos.2739
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
	jal	atan.2743				#	bl	atan.2743
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	fsw	f1, 22(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	sin.2737				#	bl	sin.2737
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 22(r3)
	fsw	f1, 24(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	cos.2739				#	bl	cos.2739
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
ble_then.16314:
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
calc_dirvecs.3270:
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.16319
	jr	r31				#
ble_then.16319:
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
	ble	r5, r2, ble_then.16322
	j	ble_cont.16323
ble_then.16322:
	addi	r2, r2, -5
ble_cont.16323:
	flw	f1, 2(r3)
	lw	r5, 6(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
calc_dirvec_rows.3275:
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.16324
	jr	r31				#
ble_then.16324:
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
	ble	r5, r2, ble_then.16326
	j	ble_cont.16327
ble_then.16326:
	addi	r2, r2, -5
ble_cont.16327:
	lw	r5, 2(r3)
	addi	r5, r5, 4
	addi	r6, r0, 0
	ble	r6, r1, ble_then.16328
	jr	r31				#
ble_then.16328:
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
	ble	r5, r2, ble_then.16330
	j	ble_cont.16331
ble_then.16330:
	addi	r2, r2, -5
ble_cont.16331:
	lw	r5, 5(r3)
	addi	r5, r5, 4
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
create_dirvec_elements.3281:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.16332
	jr	r31				#
ble_then.16332:
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
	ble	r2, r1, ble_then.16334
	jr	r31				#
ble_then.16334:
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
	ble	r2, r1, ble_then.16336
	jr	r31				#
ble_then.16336:
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
	ble	r2, r1, ble_then.16338
	jr	r31				#
ble_then.16338:
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
create_dirvecs.3284:
	lw	r2, 3(r29)
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.16340
	jr	r31				#
ble_then.16340:
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
	ble	r2, r1, ble_then.16342
	jr	r31				#
ble_then.16342:
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
init_dirvec_constants.3286:
	lw	r5, 3(r29)
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	addi	r8, r0, 0
	ble	r8, r2, ble_then.16344
	jr	r31				#
ble_then.16344:
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
	ble	r2, r1, ble_then.16346
	jr	r31				#
ble_then.16346:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	lw	r7, 0(r6)
	addi	r7, r7, -1
	addi	r8, r0, 0
	sw	r1, 6(r3)
	ble	r8, r7, ble_then.16348
	j	ble_cont.16349
ble_then.16348:
	lw	r8, 2(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r5)
	lw	r11, 0(r5)
	lw	r12, 1(r9)
	sw	r5, 7(r3)
	beqi	1, r12, beq_then.16350
	beqi	2, r12, beq_then.16352
	sw	r7, 8(r3)
	sw	r10, 9(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_second_table.3065				#	bl	setup_second_table.3065
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16353
beq_then.16352:
	sw	r7, 8(r3)
	sw	r10, 9(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_surface_table.3062				#	bl	setup_surface_table.3062
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16353:
	j	beq_cont.16351
beq_then.16350:
	sw	r7, 8(r3)
	sw	r10, 9(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_rect_table.3059				#	bl	setup_rect_table.3059
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16351:
	addi	r2, r2, -1
	lw	r1, 7(r3)
	lw	r29, 1(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
ble_cont.16349:
	lw	r1, 6(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16354
	jr	r31				#
ble_then.16354:
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
	ble	r2, r1, ble_then.16356
	jr	r31				#
ble_then.16356:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r1, 11(r3)
	ble	r7, r6, ble_then.16358
	j	ble_cont.16359
ble_then.16358:
	lw	r7, 2(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 12(r3)
	beqi	1, r10, beq_then.16360
	beqi	2, r10, beq_then.16362
	sw	r6, 13(r3)
	sw	r8, 14(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	setup_second_table.3065				#	bl	setup_second_table.3065
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16363
beq_then.16362:
	sw	r6, 13(r3)
	sw	r8, 14(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	setup_surface_table.3062				#	bl	setup_surface_table.3062
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16363:
	j	beq_cont.16361
beq_then.16360:
	sw	r6, 13(r3)
	sw	r8, 14(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	setup_rect_table.3059				#	bl	setup_rect_table.3059
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16361:
	addi	r2, r2, -1
	lw	r1, 12(r3)
	lw	r29, 1(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -16
	lw	r31, 15(r3)
ble_cont.16359:
	lw	r1, 11(r3)
	addi	r2, r1, -1
	lw	r1, 4(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
init_vecset_constants.3289:
	lw	r2, 5(r29)
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	addi	r9, r0, 0
	ble	r9, r1, ble_then.16364
	jr	r31				#
ble_then.16364:
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
	ble	r12, r11, ble_then.16366
	j	ble_cont.16367
ble_then.16366:
	add	r30, r2, r11
	lw	r12, 0(r30)
	lw	r13, 1(r10)
	lw	r14, 0(r10)
	lw	r15, 1(r12)
	sw	r10, 8(r3)
	beqi	1, r15, beq_then.16368
	beqi	2, r15, beq_then.16370
	sw	r11, 9(r3)
	sw	r13, 10(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r14				# mr	r1, r14
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_second_table.3065				#	bl	setup_second_table.3065
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16371
beq_then.16370:
	sw	r11, 9(r3)
	sw	r13, 10(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r14				# mr	r1, r14
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_surface_table.3062				#	bl	setup_surface_table.3062
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16371:
	j	beq_cont.16369
beq_then.16368:
	sw	r11, 9(r3)
	sw	r13, 10(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r14				# mr	r1, r14
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_rect_table.3059				#	bl	setup_rect_table.3059
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16369:
	addi	r2, r2, -1
	lw	r1, 8(r3)
	lw	r29, 5(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
ble_cont.16367:
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
	ble	r7, r6, ble_then.16372
	j	ble_cont.16373
ble_then.16372:
	lw	r7, 4(r3)
	add	r30, r7, r6
	lw	r8, 0(r30)
	lw	r9, 1(r2)
	lw	r10, 0(r2)
	lw	r11, 1(r8)
	sw	r2, 11(r3)
	beqi	1, r11, beq_then.16374
	beqi	2, r11, beq_then.16376
	sw	r6, 12(r3)
	sw	r9, 13(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_second_table.3065				#	bl	setup_second_table.3065
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16377
beq_then.16376:
	sw	r6, 12(r3)
	sw	r9, 13(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_surface_table.3062				#	bl	setup_surface_table.3062
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16377:
	j	beq_cont.16375
beq_then.16374:
	sw	r6, 12(r3)
	sw	r9, 13(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_rect_table.3059				#	bl	setup_rect_table.3059
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16375:
	addi	r2, r2, -1
	lw	r1, 11(r3)
	lw	r29, 5(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
ble_cont.16373:
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
	ble	r2, r1, ble_then.16378
	jr	r31				#
ble_then.16378:
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
	ble	r7, r6, ble_then.16380
	j	ble_cont.16381
ble_then.16380:
	lw	r7, 4(r3)
	add	r30, r7, r6
	lw	r8, 0(r30)
	lw	r9, 1(r2)
	lw	r10, 0(r2)
	lw	r11, 1(r8)
	sw	r2, 16(r3)
	beqi	1, r11, beq_then.16382
	beqi	2, r11, beq_then.16384
	sw	r6, 17(r3)
	sw	r9, 18(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_second_table.3065				#	bl	setup_second_table.3065
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16385
beq_then.16384:
	sw	r6, 17(r3)
	sw	r9, 18(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_surface_table.3062				#	bl	setup_surface_table.3062
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16385:
	j	beq_cont.16383
beq_then.16382:
	sw	r6, 17(r3)
	sw	r9, 18(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_rect_table.3059				#	bl	setup_rect_table.3059
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16383:
	addi	r2, r2, -1
	lw	r1, 16(r3)
	lw	r29, 5(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
ble_cont.16381:
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
	ble	r2, r1, ble_then.16386
	jr	r31				#
ble_then.16386:
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
	ble	r8, r7, ble_then.16388
	j	ble_cont.16389
ble_then.16388:
	lw	r8, 4(r3)
	add	r30, r8, r7
	lw	r8, 0(r30)
	lw	r9, 1(r6)
	lw	r10, 0(r6)
	lw	r11, 1(r8)
	sw	r6, 21(r3)
	beqi	1, r11, beq_then.16390
	beqi	2, r11, beq_then.16392
	sw	r7, 22(r3)
	sw	r9, 23(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	setup_second_table.3065				#	bl	setup_second_table.3065
	addi	r3, r3, -25
	lw	r31, 24(r3)
	lw	r2, 22(r3)
	lw	r5, 23(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16393
beq_then.16392:
	sw	r7, 22(r3)
	sw	r9, 23(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	setup_surface_table.3062				#	bl	setup_surface_table.3062
	addi	r3, r3, -25
	lw	r31, 24(r3)
	lw	r2, 22(r3)
	lw	r5, 23(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16393:
	j	beq_cont.16391
beq_then.16390:
	sw	r7, 22(r3)
	sw	r9, 23(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	setup_rect_table.3059				#	bl	setup_rect_table.3059
	addi	r3, r3, -25
	lw	r31, 24(r3)
	lw	r2, 22(r3)
	lw	r5, 23(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16391:
	addi	r2, r2, -1
	lw	r1, 21(r3)
	lw	r29, 5(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -25
	lw	r31, 24(r3)
ble_cont.16389:
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
	ble	r2, r1, ble_then.16394
	jr	r31				#
ble_then.16394:
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
setup_rect_reflection.3300:
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
	ble	r8, r7, ble_then.16398
	j	ble_cont.16399
ble_then.16398:
	lw	r8, 13(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r9)
	beqi	1, r10, beq_then.16400
	beqi	2, r10, beq_then.16402
	sw	r7, 23(r3)
	sw	r1, 24(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_second_table.3065				#	bl	setup_second_table.3065
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 24(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16403
beq_then.16402:
	sw	r7, 23(r3)
	sw	r1, 24(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_surface_table.3062				#	bl	setup_surface_table.3062
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 24(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16403:
	j	beq_cont.16401
beq_then.16400:
	sw	r7, 23(r3)
	sw	r1, 24(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_rect_table.3059				#	bl	setup_rect_table.3059
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 24(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16401:
	addi	r2, r2, -1
	lw	r1, 22(r3)
	lw	r29, 12(r3)
	sw	r31, 25(r3)
	addi	r3, r3, 26
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -26
	lw	r31, 25(r3)
ble_cont.16399:
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
	ble	r8, r7, ble_then.16405
	j	ble_cont.16406
ble_then.16405:
	lw	r8, 13(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r9)
	beqi	1, r10, beq_then.16407
	beqi	2, r10, beq_then.16409
	sw	r7, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_second_table.3065				#	bl	setup_second_table.3065
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16410
beq_then.16409:
	sw	r7, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_surface_table.3062				#	bl	setup_surface_table.3062
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16410:
	j	beq_cont.16408
beq_then.16407:
	sw	r7, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_rect_table.3059				#	bl	setup_rect_table.3059
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16408:
	addi	r2, r2, -1
	lw	r1, 31(r3)
	lw	r29, 12(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -35
	lw	r31, 34(r3)
ble_cont.16406:
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
	ble	r7, r6, ble_then.16411
	j	ble_cont.16412
ble_then.16411:
	lw	r7, 13(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.16413
	beqi	2, r8, beq_then.16415
	sw	r6, 40(r3)
	sw	r1, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	setup_second_table.3065				#	bl	setup_second_table.3065
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 40(r3)
	lw	r5, 41(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16416
beq_then.16415:
	sw	r6, 40(r3)
	sw	r1, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	setup_surface_table.3062				#	bl	setup_surface_table.3062
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 40(r3)
	lw	r5, 41(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16416:
	j	beq_cont.16414
beq_then.16413:
	sw	r6, 40(r3)
	sw	r1, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	setup_rect_table.3059				#	bl	setup_rect_table.3059
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 40(r3)
	lw	r5, 41(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16414:
	addi	r2, r2, -1
	lw	r1, 39(r3)
	lw	r29, 12(r3)
	sw	r31, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -43
	lw	r31, 42(r3)
ble_cont.16412:
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
setup_surface_reflection.3303:
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
	ble	r7, r6, ble_then.16418
	j	ble_cont.16419
ble_then.16418:
	lw	r7, 7(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.16420
	beqi	2, r8, beq_then.16422
	sw	r6, 17(r3)
	sw	r1, 18(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_second_table.3065				#	bl	setup_second_table.3065
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16423
beq_then.16422:
	sw	r6, 17(r3)
	sw	r1, 18(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_surface_table.3062				#	bl	setup_surface_table.3062
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16423:
	j	beq_cont.16421
beq_then.16420:
	sw	r6, 17(r3)
	sw	r1, 18(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_rect_table.3059				#	bl	setup_rect_table.3059
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16421:
	addi	r2, r2, -1
	lw	r1, 16(r3)
	lw	r29, 6(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
ble_cont.16419:
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
rt.3308:
	lw	r5, 28(r29)
	lw	r6, 27(r29)
	lw	r7, 26(r29)
	lw	r8, 25(r29)
	lw	r9, 24(r29)
	lw	r10, 23(r29)
	lw	r11, 22(r29)
	lw	r12, 21(r29)
	lw	r13, 20(r29)
	lw	r14, 19(r29)
	lw	r15, 18(r29)
	lw	r16, 17(r29)
	lw	r17, 16(r29)
	lw	r18, 15(r29)
	lw	r19, 14(r29)
	lw	r20, 13(r29)
	lw	r21, 12(r29)
	lw	r22, 11(r29)
	lw	r23, 10(r29)
	lw	r24, 9(r29)
	lw	r25, 8(r29)
	lw	r26, 7(r29)
	lw	r27, 6(r29)
	lw	r28, 5(r29)
	sw	r11, 0(r3)
	lw	r11, 4(r29)
	sw	r9, 1(r3)
	lw	r9, 3(r29)
	sw	r17, 2(r3)
	lw	r17, 2(r29)
	lw	r29, 1(r29)
	sw	r1, 0(r27)
	sw	r2, 1(r27)
	sw	r7, 3(r3)
	srai	r7, r1, 1
	sw	r7, 0(r28)
	srai	r2, r2, 1
	sw	r2, 1(r28)
	flup	f1, 49		# fli	f1, 128.000000
	itof	f2, r1
	fdiv	f1, f1, f2
	fsw	f1, 0(r10)
	lw	r1, 0(r27)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r8, 4(r3)
	sw	r21, 5(r3)
	sw	r6, 6(r3)
	sw	r22, 7(r3)
	sw	r24, 8(r3)
	sw	r26, 9(r3)
	sw	r23, 10(r3)
	sw	r19, 11(r3)
	sw	r9, 12(r3)
	sw	r29, 13(r3)
	sw	r17, 14(r3)
	sw	r5, 15(r3)
	sw	r18, 16(r3)
	sw	r16, 17(r3)
	sw	r13, 18(r3)
	sw	r20, 19(r3)
	sw	r14, 20(r3)
	sw	r15, 21(r3)
	sw	r12, 22(r3)
	sw	r25, 23(r3)
	sw	r27, 24(r3)
	sw	r1, 25(r3)
	sw	r11, 26(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -28
	lw	r31, 27(r3)
	sw	r1, 27(r3)
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
	addi	r3, r3, -29
	lw	r31, 28(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 28(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -30
	lw	r31, 29(r3)
	addi	r2, r0, 5
	lw	r5, 26(r3)
	sw	r1, 29(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -31
	lw	r31, 30(r3)
	sw	r1, 30(r3)
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
	addi	r3, r3, -32
	lw	r31, 31(r3)
	sw	r1, 31(r3)
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
	addi	r3, r3, -33
	lw	r31, 32(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 32(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -34
	lw	r31, 33(r3)
	sw	r1, 33(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
	addi	r3, r3, -35
	lw	r31, 34(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 33(r3)
	sw	r1, 6(r2)
	lw	r1, 32(r3)
	sw	r1, 5(r2)
	lw	r1, 31(r3)
	sw	r1, 4(r2)
	lw	r1, 30(r3)
	sw	r1, 3(r2)
	lw	r1, 29(r3)
	sw	r1, 2(r2)
	lw	r1, 28(r3)
	sw	r1, 1(r2)
	lw	r1, 27(r3)
	sw	r1, 0(r2)
	lw	r1, 25(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 24(r3)
	lw	r5, 0(r2)
	addi	r5, r5, -2
	lw	r29, 23(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 24(r3)
	lw	r5, 0(r2)
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 34(r3)
	sw	r5, 35(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -37
	lw	r31, 36(r3)
	sw	r1, 36(r3)
	sw	r31, 37(r3)
	addi	r3, r3, 38
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
	addi	r3, r3, -38
	lw	r31, 37(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 37(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 38(r3)
	addi	r3, r3, 39
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -39
	lw	r31, 38(r3)
	addi	r2, r0, 5
	lw	r5, 26(r3)
	sw	r1, 38(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 39(r3)
	addi	r3, r3, 40
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -40
	lw	r31, 39(r3)
	sw	r1, 39(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
	addi	r3, r3, -41
	lw	r31, 40(r3)
	sw	r1, 40(r3)
	sw	r31, 41(r3)
	addi	r3, r3, 42
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
	addi	r3, r3, -42
	lw	r31, 41(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 41(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -43
	lw	r31, 42(r3)
	sw	r1, 42(r3)
	sw	r31, 43(r3)
	addi	r3, r3, 44
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
	addi	r3, r3, -44
	lw	r31, 43(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 42(r3)
	sw	r1, 6(r2)
	lw	r1, 41(r3)
	sw	r1, 5(r2)
	lw	r1, 40(r3)
	sw	r1, 4(r2)
	lw	r1, 39(r3)
	sw	r1, 3(r2)
	lw	r1, 38(r3)
	sw	r1, 2(r2)
	lw	r1, 37(r3)
	sw	r1, 1(r2)
	lw	r1, 36(r3)
	sw	r1, 0(r2)
	lw	r1, 35(r3)
	sw	r31, 43(r3)
	addi	r3, r3, 44
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -44
	lw	r31, 43(r3)
	lw	r2, 24(r3)
	lw	r5, 0(r2)
	addi	r5, r5, -2
	lw	r29, 23(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 43(r3)
	addi	r3, r3, 44
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -44
	lw	r31, 43(r3)
	lw	r2, 24(r3)
	lw	r5, 0(r2)
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 43(r3)
	sw	r5, 44(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 45(r3)
	addi	r3, r3, 46
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -46
	lw	r31, 45(r3)
	sw	r1, 45(r3)
	sw	r31, 46(r3)
	addi	r3, r3, 47
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
	addi	r3, r3, -47
	lw	r31, 46(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 46(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 47(r3)
	addi	r3, r3, 48
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -48
	lw	r31, 47(r3)
	addi	r2, r0, 5
	lw	r5, 26(r3)
	sw	r1, 47(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 48(r3)
	addi	r3, r3, 49
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -49
	lw	r31, 48(r3)
	sw	r1, 48(r3)
	sw	r31, 49(r3)
	addi	r3, r3, 50
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
	addi	r3, r3, -50
	lw	r31, 49(r3)
	sw	r1, 49(r3)
	sw	r31, 50(r3)
	addi	r3, r3, 51
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
	addi	r3, r3, -51
	lw	r31, 50(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 50(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 51(r3)
	addi	r3, r3, 52
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -52
	lw	r31, 51(r3)
	sw	r1, 51(r3)
	sw	r31, 52(r3)
	addi	r3, r3, 53
	jal	create_float5x3array.3248				#	bl	create_float5x3array.3248
	addi	r3, r3, -53
	lw	r31, 52(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 51(r3)
	sw	r1, 6(r2)
	lw	r1, 50(r3)
	sw	r1, 5(r2)
	lw	r1, 49(r3)
	sw	r1, 4(r2)
	lw	r1, 48(r3)
	sw	r1, 3(r2)
	lw	r1, 47(r3)
	sw	r1, 2(r2)
	lw	r1, 46(r3)
	sw	r1, 1(r2)
	lw	r1, 45(r3)
	sw	r1, 0(r2)
	lw	r1, 44(r3)
	sw	r31, 52(r3)
	addi	r3, r3, 53
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -53
	lw	r31, 52(r3)
	lw	r2, 24(r3)
	lw	r5, 0(r2)
	addi	r5, r5, -2
	lw	r29, 23(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 52(r3)
	addi	r3, r3, 53
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -53
	lw	r31, 52(r3)
	lw	r29, 22(r3)
	sw	r1, 52(r3)
	sw	r31, 53(r3)
	addi	r3, r3, 54
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -54
	lw	r31, 53(r3)
	lw	r29, 21(r3)
	sw	r31, 53(r3)
	addi	r3, r3, 54
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -54
	lw	r31, 53(r3)
	addi	r1, r0, 0
	lw	r29, 20(r3)
	sw	r1, 53(r3)
	sw	r31, 54(r3)
	addi	r3, r3, 55
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -55
	lw	r31, 54(r3)
	beqi	0, r1, beq_then.16425
	addi	r1, r0, 1
	lw	r29, 18(r3)
	sw	r31, 54(r3)
	addi	r3, r3, 55
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -55
	lw	r31, 54(r3)
	j	beq_cont.16426
beq_then.16425:
	lw	r1, 19(r3)
	lw	r2, 53(r3)
	sw	r2, 0(r1)
beq_cont.16426:
	addi	r1, r0, 0
	lw	r29, 17(r3)
	sw	r31, 54(r3)
	addi	r3, r3, 55
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -55
	lw	r31, 54(r3)
	addi	r1, r0, 0
	sw	r31, 54(r3)
	addi	r3, r3, 55
	jal	read_or_network.2969				#	bl	read_or_network.2969
	addi	r3, r3, -55
	lw	r31, 54(r3)
	lw	r2, 16(r3)
	sw	r1, 0(r2)
	lw	r29, 15(r3)
	sw	r31, 54(r3)
	addi	r3, r3, 55
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -55
	lw	r31, 54(r3)
	addi	r1, r0, 4
	lw	r29, 14(r3)
	sw	r31, 54(r3)
	addi	r3, r3, 55
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -55
	lw	r31, 54(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r29, 13(r3)
	sw	r31, 54(r3)
	addi	r3, r3, 55
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -55
	lw	r31, 54(r3)
	lw	r1, 12(r3)
	lw	r2, 4(r1)
	lw	r5, 119(r2)
	lw	r6, 19(r3)
	lw	r7, 0(r6)
	addi	r7, r7, -1
	addi	r8, r0, 0
	sw	r2, 54(r3)
	ble	r8, r7, ble_then.16427
	j	ble_cont.16428
ble_then.16427:
	lw	r8, 11(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r5)
	lw	r11, 0(r5)
	lw	r12, 1(r9)
	sw	r5, 55(r3)
	beqi	1, r12, beq_then.16429
	beqi	2, r12, beq_then.16431
	sw	r7, 56(r3)
	sw	r10, 57(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 58(r3)
	addi	r3, r3, 59
	jal	setup_second_table.3065				#	bl	setup_second_table.3065
	addi	r3, r3, -59
	lw	r31, 58(r3)
	lw	r2, 56(r3)
	lw	r5, 57(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16432
beq_then.16431:
	sw	r7, 56(r3)
	sw	r10, 57(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 58(r3)
	addi	r3, r3, 59
	jal	setup_surface_table.3062				#	bl	setup_surface_table.3062
	addi	r3, r3, -59
	lw	r31, 58(r3)
	lw	r2, 56(r3)
	lw	r5, 57(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16432:
	j	beq_cont.16430
beq_then.16429:
	sw	r7, 56(r3)
	sw	r10, 57(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 58(r3)
	addi	r3, r3, 59
	jal	setup_rect_table.3059				#	bl	setup_rect_table.3059
	addi	r3, r3, -59
	lw	r31, 58(r3)
	lw	r2, 56(r3)
	lw	r5, 57(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16430:
	addi	r2, r2, -1
	lw	r1, 55(r3)
	lw	r29, 10(r3)
	sw	r31, 58(r3)
	addi	r3, r3, 59
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -59
	lw	r31, 58(r3)
ble_cont.16428:
	addi	r2, r0, 118
	lw	r1, 54(r3)
	lw	r29, 9(r3)
	sw	r31, 58(r3)
	addi	r3, r3, 59
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -59
	lw	r31, 58(r3)
	lw	r1, 12(r3)
	lw	r1, 3(r1)
	addi	r2, r0, 119
	lw	r29, 9(r3)
	sw	r31, 58(r3)
	addi	r3, r3, 59
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -59
	lw	r31, 58(r3)
	addi	r1, r0, 2
	lw	r29, 8(r3)
	sw	r31, 58(r3)
	addi	r3, r3, 59
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -59
	lw	r31, 58(r3)
	lw	r1, 7(r3)
	flw	f1, 0(r1)
	lw	r2, 6(r3)
	fsw	f1, 0(r2)
	flw	f1, 1(r1)
	fsw	f1, 1(r2)
	flw	f1, 2(r1)
	fsw	f1, 2(r2)
	lw	r1, 19(r3)
	lw	r2, 0(r1)
	addi	r2, r2, -1
	lw	r5, 5(r3)
	lw	r29, 10(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 58(r3)
	addi	r3, r3, 59
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -59
	lw	r31, 58(r3)
	lw	r1, 19(r3)
	lw	r1, 0(r1)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16433
	j	ble_cont.16434
ble_then.16433:
	lw	r2, 11(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.16435
	j	beq_cont.16436
beq_then.16435:
	lw	r5, 7(r2)
	flw	f1, 0(r5)
	flup	f2, 2		# fli	f2, 1.000000
	sw	r1, 58(r3)
	sw	r2, 59(r3)
	sw	r31, 60(r3)
	addi	r3, r3, 61
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -61
	lw	r31, 60(r3)
	beqi	0, r1, beq_then.16437
	lw	r2, 59(r3)
	lw	r1, 1(r2)
	beqi	1, r1, beq_then.16439
	beqi	2, r1, beq_then.16441
	j	beq_cont.16442
beq_then.16441:
	lw	r1, 58(r3)
	lw	r29, 3(r3)
	sw	r31, 60(r3)
	addi	r3, r3, 61
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -61
	lw	r31, 60(r3)
beq_cont.16442:
	j	beq_cont.16440
beq_then.16439:
	lw	r1, 58(r3)
	lw	r29, 4(r3)
	sw	r31, 60(r3)
	addi	r3, r3, 61
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -61
	lw	r31, 60(r3)
beq_cont.16440:
	j	beq_cont.16438
beq_then.16437:
beq_cont.16438:
beq_cont.16436:
ble_cont.16434:
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r1, 43(r3)
	lw	r29, 2(r3)
	sw	r31, 60(r3)
	addi	r3, r3, 61
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -61
	lw	r31, 60(r3)
	addi	r2, r0, 0
	addi	r5, r0, 2
	lw	r1, 24(r3)
	lw	r6, 1(r1)
	blei	0, r6, ble_then.16443
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r2, 60(r3)
	blei	0, r1, ble_then.16444
	addi	r1, r0, 1
	lw	r6, 52(r3)
	lw	r29, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 61(r3)
	addi	r3, r3, 62
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -62
	lw	r31, 61(r3)
	j	ble_cont.16445
ble_then.16444:
ble_cont.16445:
	addi	r1, r0, 0
	lw	r2, 60(r3)
	lw	r5, 34(r3)
	lw	r6, 43(r3)
	lw	r7, 52(r3)
	lw	r29, 1(r3)
	sw	r31, 61(r3)
	addi	r3, r3, 62
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -62
	lw	r31, 61(r3)
	addi	r1, r0, 1
	addi	r7, r0, 4
	lw	r2, 43(r3)
	lw	r5, 52(r3)
	lw	r6, 34(r3)
	lw	r29, 0(r3)
	sw	r31, 61(r3)
	addi	r3, r3, 62
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -62
	lw	r31, 61(r3)
	jr	r31				#
ble_then.16443:
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
	lw	r1, 33(r3)
	sw	r1, 0(r2)
	addi	r5, r0, 0
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 34(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 35(r3)
	addi	r3, r3, 36
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -36
	lw	r31, 35(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 0
	sw	r2, 35(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -37
	lw	r31, 36(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 35(r3)
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
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -37
	lw	r31, 36(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 36(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 37(r3)
	addi	r3, r3, 38
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -38
	lw	r31, 37(r3)
	add	r2, r0, r4
	addi	r4, r4, 6
	addi	r5, r0, read_screen_settings.2954
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
	addi	r10, r0, read_light.2956
	sw	r10, 0(r9)
	lw	r10, 6(r3)
	sw	r10, 2(r9)
	lw	r11, 7(r3)
	sw	r11, 1(r9)
	add	r12, r0, r4
	addi	r4, r4, 2
	addi	r13, r0, read_nth_object.2961
	sw	r13, 0(r12)
	lw	r13, 3(r3)
	sw	r13, 1(r12)
	add	r14, r0, r4
	addi	r4, r4, 3
	addi	r15, r0, read_object.2963
	sw	r15, 0(r14)
	sw	r12, 2(r14)
	lw	r15, 2(r3)
	sw	r15, 1(r14)
	add	r16, r0, r4
	addi	r4, r4, 2
	addi	r17, r0, read_and_network.2971
	sw	r17, 0(r16)
	lw	r17, 9(r3)
	sw	r17, 1(r16)
	add	r18, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, solver_rect_surface.2975
	sw	r19, 0(r18)
	lw	r19, 12(r3)
	sw	r19, 1(r18)
	add	r20, r0, r4
	addi	r4, r4, 2
	addi	r21, r0, solver_surface.2990
	sw	r21, 0(r20)
	sw	r19, 1(r20)
	add	r21, r0, r4
	addi	r4, r4, 2
	addi	r22, r0, solver_second.3009
	sw	r22, 0(r21)
	sw	r19, 1(r21)
	add	r22, r0, r4
	addi	r4, r4, 2
	addi	r23, r0, solver_rect_fast.3019
	sw	r23, 0(r22)
	sw	r19, 1(r22)
	add	r23, r0, r4
	addi	r4, r4, 2
	addi	r24, r0, solver_second_fast.3032
	sw	r24, 0(r23)
	sw	r19, 1(r23)
	add	r24, r0, r4
	addi	r4, r4, 5
	addi	r25, r0, solver_fast.3038
	sw	r25, 0(r24)
	sw	r23, 4(r24)
	sw	r22, 3(r24)
	sw	r19, 2(r24)
	sw	r13, 1(r24)
	add	r23, r0, r4
	addi	r4, r4, 2
	addi	r25, r0, solver_second_fast2.3049
	sw	r25, 0(r23)
	sw	r19, 1(r23)
	add	r25, r0, r4
	addi	r4, r4, 2
	addi	r26, r0, iter_setup_dirvec_constants.3068
	sw	r26, 0(r25)
	sw	r13, 1(r25)
	add	r26, r0, r4
	addi	r4, r4, 2
	addi	r27, r0, setup_startp_constants.3073
	sw	r27, 0(r26)
	sw	r13, 1(r26)
	add	r27, r0, r4
	addi	r4, r4, 2
	addi	r28, r0, check_all_inside.3098
	sw	r28, 0(r27)
	sw	r13, 1(r27)
	add	r28, r0, r4
	addi	r4, r4, 8
	addi	r29, r0, shadow_check_and_group.3104
	sw	r29, 0(r28)
	sw	r24, 7(r28)
	sw	r19, 6(r28)
	sw	r13, 5(r28)
	lw	r29, 34(r3)
	sw	r29, 4(r28)
	sw	r10, 3(r28)
	sw	r16, 37(r3)
	lw	r16, 15(r3)
	sw	r16, 2(r28)
	sw	r27, 1(r28)
	sw	r9, 38(r3)
	add	r9, r0, r4
	addi	r4, r4, 3
	sw	r12, 39(r3)
	addi	r12, r0, shadow_check_one_or_group.3107
	sw	r12, 0(r9)
	sw	r28, 2(r9)
	sw	r17, 1(r9)
	add	r12, r0, r4
	addi	r4, r4, 8
	sw	r14, 40(r3)
	addi	r14, r0, shadow_check_one_or_matrix.3110
	sw	r14, 0(r12)
	sw	r24, 7(r12)
	sw	r19, 6(r12)
	sw	r9, 5(r12)
	sw	r28, 4(r12)
	sw	r29, 3(r12)
	sw	r16, 2(r12)
	sw	r17, 1(r12)
	add	r9, r0, r4
	addi	r4, r4, 12
	addi	r14, r0, solve_each_element.3113
	sw	r14, 0(r9)
	lw	r14, 14(r3)
	sw	r14, 11(r9)
	lw	r24, 24(r3)
	sw	r24, 10(r9)
	sw	r20, 9(r9)
	sw	r21, 8(r9)
	sw	r18, 7(r9)
	sw	r19, 6(r9)
	sw	r13, 5(r9)
	lw	r28, 13(r3)
	sw	r28, 4(r9)
	sw	r16, 3(r9)
	lw	r29, 16(r3)
	sw	r29, 2(r9)
	sw	r27, 1(r9)
	sw	r2, 41(r3)
	add	r2, r0, r4
	addi	r4, r4, 3
	sw	r25, 42(r3)
	addi	r25, r0, solve_one_or_network.3117
	sw	r25, 0(r2)
	sw	r9, 2(r2)
	sw	r17, 1(r2)
	add	r25, r0, r4
	addi	r4, r4, 11
	addi	r7, r0, trace_or_matrix.3121
	sw	r7, 0(r25)
	sw	r14, 10(r25)
	sw	r24, 9(r25)
	sw	r20, 8(r25)
	sw	r21, 7(r25)
	sw	r18, 6(r25)
	sw	r19, 5(r25)
	sw	r2, 4(r25)
	sw	r9, 3(r25)
	sw	r13, 2(r25)
	sw	r17, 1(r25)
	add	r2, r0, r4
	addi	r4, r4, 11
	addi	r7, r0, solve_each_element_fast.3127
	sw	r7, 0(r2)
	sw	r14, 10(r2)
	lw	r7, 25(r3)
	sw	r7, 9(r2)
	sw	r23, 8(r2)
	sw	r22, 7(r2)
	sw	r19, 6(r2)
	sw	r13, 5(r2)
	sw	r28, 4(r2)
	sw	r16, 3(r2)
	sw	r29, 2(r2)
	sw	r27, 1(r2)
	add	r9, r0, r4
	addi	r4, r4, 3
	addi	r18, r0, solve_one_or_network_fast.3131
	sw	r18, 0(r9)
	sw	r2, 2(r9)
	sw	r17, 1(r9)
	add	r18, r0, r4
	addi	r4, r4, 9
	addi	r20, r0, trace_or_matrix_fast.3135
	sw	r20, 0(r18)
	sw	r14, 8(r18)
	sw	r23, 7(r18)
	sw	r22, 6(r18)
	sw	r19, 5(r18)
	sw	r9, 4(r18)
	sw	r2, 3(r18)
	sw	r13, 2(r18)
	sw	r17, 1(r18)
	add	r2, r0, r4
	addi	r4, r4, 3
	addi	r9, r0, get_nvector_second.3145
	sw	r9, 0(r2)
	lw	r9, 17(r3)
	sw	r9, 2(r2)
	sw	r16, 1(r2)
	add	r17, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, utexture.3150
	sw	r19, 0(r17)
	lw	r19, 18(r3)
	sw	r19, 1(r17)
	add	r20, r0, r4
	addi	r4, r4, 3
	addi	r21, r0, add_light.3153
	sw	r21, 0(r20)
	sw	r19, 2(r20)
	lw	r21, 20(r3)
	sw	r21, 1(r20)
	add	r22, r0, r4
	addi	r4, r4, 10
	addi	r23, r0, trace_reflections.3157
	sw	r23, 0(r22)
	sw	r18, 9(r22)
	sw	r14, 8(r22)
	sw	r12, 7(r22)
	lw	r23, 36(r3)
	sw	r23, 6(r22)
	lw	r27, 11(r3)
	sw	r27, 5(r22)
	sw	r9, 4(r22)
	sw	r28, 3(r22)
	sw	r29, 2(r22)
	sw	r20, 1(r22)
	add	r23, r0, r4
	addi	r4, r4, 25
	addi	r6, r0, trace_ray.3162
	sw	r6, 0(r23)
	sw	r17, 24(r23)
	lw	r6, 0(r3)
	sw	r6, 23(r23)
	sw	r22, 22(r23)
	sw	r25, 21(r23)
	sw	r14, 20(r23)
	sw	r19, 19(r23)
	sw	r7, 18(r23)
	sw	r24, 17(r23)
	sw	r12, 16(r23)
	sw	r26, 15(r23)
	sw	r21, 14(r23)
	sw	r27, 13(r23)
	sw	r13, 12(r23)
	sw	r9, 11(r23)
	sw	r1, 10(r23)
	sw	r15, 9(r23)
	sw	r10, 8(r23)
	sw	r28, 7(r23)
	sw	r16, 6(r23)
	sw	r29, 5(r23)
	sw	r2, 4(r23)
	lw	r6, 1(r3)
	sw	r6, 3(r23)
	sw	r11, 2(r23)
	sw	r20, 1(r23)
	add	r11, r0, r4
	addi	r4, r4, 15
	addi	r20, r0, trace_diffuse_ray.3168
	sw	r20, 0(r11)
	sw	r17, 14(r11)
	sw	r18, 13(r11)
	sw	r14, 12(r11)
	sw	r19, 11(r11)
	sw	r12, 10(r11)
	sw	r27, 9(r11)
	sw	r13, 8(r11)
	sw	r9, 7(r11)
	sw	r10, 6(r11)
	sw	r28, 5(r11)
	sw	r16, 4(r11)
	sw	r29, 3(r11)
	sw	r2, 2(r11)
	lw	r2, 19(r3)
	sw	r2, 1(r11)
	add	r9, r0, r4
	addi	r4, r4, 2
	addi	r12, r0, iter_trace_diffuse_rays.3171
	sw	r12, 0(r9)
	sw	r11, 1(r9)
	add	r11, r0, r4
	addi	r4, r4, 6
	addi	r12, r0, trace_diffuse_ray_80percent.3180
	sw	r12, 0(r11)
	sw	r7, 5(r11)
	sw	r26, 4(r11)
	sw	r15, 3(r11)
	sw	r9, 2(r11)
	lw	r12, 31(r3)
	sw	r12, 1(r11)
	add	r14, r0, r4
	addi	r4, r4, 4
	addi	r16, r0, calc_diffuse_using_1point.3184
	sw	r16, 0(r14)
	sw	r11, 3(r14)
	sw	r21, 2(r14)
	sw	r2, 1(r14)
	add	r16, r0, r4
	addi	r4, r4, 3
	addi	r17, r0, calc_diffuse_using_5points.3187
	sw	r17, 0(r16)
	sw	r21, 2(r16)
	sw	r2, 1(r16)
	add	r17, r0, r4
	addi	r4, r4, 5
	addi	r18, r0, do_without_neighbors.3193
	sw	r18, 0(r17)
	sw	r11, 4(r17)
	sw	r21, 3(r17)
	sw	r2, 2(r17)
	sw	r14, 1(r17)
	add	r11, r0, r4
	addi	r4, r4, 4
	addi	r18, r0, try_exploit_neighbors.3209
	sw	r18, 0(r11)
	sw	r17, 3(r11)
	sw	r16, 2(r11)
	sw	r14, 1(r11)
	add	r18, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, write_ppm_header.3216
	sw	r19, 0(r18)
	lw	r19, 21(r3)
	sw	r19, 1(r18)
	add	r20, r0, r4
	addi	r4, r4, 2
	addi	r22, r0, write_rgb.3220
	sw	r22, 0(r20)
	sw	r21, 1(r20)
	add	r22, r0, r4
	addi	r4, r4, 7
	addi	r25, r0, pretrace_diffuse_rays.3222
	sw	r25, 0(r22)
	sw	r7, 6(r22)
	sw	r26, 5(r22)
	sw	r15, 4(r22)
	sw	r9, 3(r22)
	sw	r12, 2(r22)
	sw	r2, 1(r22)
	add	r2, r0, r4
	addi	r4, r4, 11
	addi	r7, r0, pretrace_pixels.3225
	sw	r7, 0(r2)
	sw	r5, 10(r2)
	sw	r23, 9(r2)
	sw	r24, 8(r2)
	sw	r8, 7(r2)
	lw	r5, 23(r3)
	sw	r5, 6(r2)
	sw	r21, 5(r2)
	lw	r7, 29(r3)
	sw	r7, 4(r2)
	sw	r22, 3(r2)
	lw	r7, 22(r3)
	sw	r7, 2(r2)
	sw	r6, 1(r2)
	add	r8, r0, r4
	addi	r4, r4, 7
	addi	r9, r0, pretrace_line.3232
	sw	r9, 0(r8)
	lw	r9, 28(r3)
	sw	r9, 6(r8)
	lw	r9, 27(r3)
	sw	r9, 5(r8)
	sw	r5, 4(r8)
	sw	r2, 3(r8)
	sw	r19, 2(r8)
	sw	r7, 1(r8)
	add	r2, r0, r4
	addi	r4, r4, 8
	addi	r9, r0, scan_pixel.3236
	sw	r9, 0(r2)
	sw	r20, 7(r2)
	sw	r11, 6(r2)
	sw	r21, 5(r2)
	sw	r19, 4(r2)
	sw	r17, 3(r2)
	sw	r16, 2(r2)
	sw	r14, 1(r2)
	add	r9, r0, r4
	addi	r4, r4, 8
	addi	r14, r0, scan_line.3242
	sw	r14, 0(r9)
	sw	r20, 7(r9)
	sw	r11, 6(r9)
	sw	r2, 5(r9)
	sw	r21, 4(r9)
	sw	r8, 3(r9)
	sw	r19, 2(r9)
	sw	r17, 1(r9)
	add	r11, r0, r4
	addi	r4, r4, 2
	addi	r14, r0, init_line_elements.3252
	sw	r14, 0(r11)
	sw	r6, 1(r11)
	add	r14, r0, r4
	addi	r4, r4, 2
	addi	r16, r0, calc_dirvec.3262
	sw	r16, 0(r14)
	sw	r12, 1(r14)
	add	r16, r0, r4
	addi	r4, r4, 2
	addi	r17, r0, calc_dirvecs.3270
	sw	r17, 0(r16)
	sw	r14, 1(r16)
	add	r14, r0, r4
	addi	r4, r4, 2
	addi	r17, r0, calc_dirvec_rows.3275
	sw	r17, 0(r14)
	sw	r16, 1(r14)
	add	r16, r0, r4
	addi	r4, r4, 2
	addi	r17, r0, create_dirvec_elements.3281
	sw	r17, 0(r16)
	sw	r15, 1(r16)
	add	r17, r0, r4
	addi	r4, r4, 4
	addi	r20, r0, create_dirvecs.3284
	sw	r20, 0(r17)
	sw	r15, 3(r17)
	sw	r12, 2(r17)
	sw	r16, 1(r17)
	add	r16, r0, r4
	addi	r4, r4, 4
	addi	r20, r0, init_dirvec_constants.3286
	sw	r20, 0(r16)
	sw	r13, 3(r16)
	sw	r15, 2(r16)
	lw	r20, 42(r3)
	sw	r20, 1(r16)
	add	r21, r0, r4
	addi	r4, r4, 6
	addi	r22, r0, init_vecset_constants.3289
	sw	r22, 0(r21)
	sw	r13, 5(r21)
	sw	r15, 4(r21)
	sw	r20, 3(r21)
	sw	r16, 2(r21)
	sw	r12, 1(r21)
	add	r22, r0, r4
	addi	r4, r4, 7
	addi	r23, r0, setup_rect_reflection.3300
	sw	r23, 0(r22)
	lw	r23, 36(r3)
	sw	r23, 6(r22)
	sw	r13, 5(r22)
	sw	r1, 4(r22)
	sw	r15, 3(r22)
	sw	r10, 2(r22)
	sw	r20, 1(r22)
	add	r24, r0, r4
	addi	r4, r4, 7
	addi	r25, r0, setup_surface_reflection.3303
	sw	r25, 0(r24)
	sw	r23, 6(r24)
	sw	r13, 5(r24)
	sw	r1, 4(r24)
	sw	r15, 3(r24)
	sw	r10, 2(r24)
	sw	r20, 1(r24)
	add	r29, r0, r4
	addi	r4, r4, 29
	addi	r1, r0, rt.3308
	sw	r1, 0(r29)
	sw	r18, 28(r29)
	lw	r1, 33(r3)
	sw	r1, 27(r29)
	sw	r24, 26(r29)
	sw	r22, 25(r29)
	sw	r2, 24(r29)
	sw	r5, 23(r29)
	sw	r9, 22(r29)
	lw	r1, 41(r3)
	sw	r1, 21(r29)
	lw	r1, 40(r3)
	sw	r1, 20(r29)
	lw	r1, 39(r3)
	sw	r1, 19(r29)
	lw	r1, 38(r3)
	sw	r1, 18(r29)
	lw	r1, 37(r3)
	sw	r1, 17(r29)
	sw	r8, 16(r29)
	sw	r27, 15(r29)
	sw	r13, 14(r29)
	sw	r15, 13(r29)
	lw	r1, 34(r3)
	sw	r1, 12(r29)
	sw	r10, 11(r29)
	sw	r20, 10(r29)
	sw	r21, 9(r29)
	sw	r11, 8(r29)
	sw	r16, 7(r29)
	sw	r19, 6(r29)
	sw	r7, 5(r29)
	sw	r6, 4(r29)
	sw	r12, 3(r29)
	sw	r17, 2(r29)
	sw	r14, 1(r29)
	addi	r1, r0, 128
	addi	r2, r0, 128
	sw	r31, 43(r3)
	addi	r3, r3, 44
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -44
	lw	r31, 43(r3)
	addi	_R_0, r0, 0
