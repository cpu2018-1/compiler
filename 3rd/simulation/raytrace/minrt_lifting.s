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
hoge.2726.6693:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21842
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21843
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21844
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21845
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21846
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21847
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21848
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21849
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21850
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21851
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21852
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21853
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21854
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21855
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21856
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21857
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2726.6693
fle_else.21857:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.21856:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.21855:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.21854:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.21853:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.21852:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.21851:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.21850:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.21849:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.21848:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.21847:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.21846:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.21845:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.21844:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.21843:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.21842:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2729.6696:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.21858
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21859
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.21860
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21861
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2729.6696
fle_else.21861:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2729.6696
fle_else.21860:
	jr	r31				#
fle_else.21859:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.21862
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21863
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2729.6696
fle_else.21863:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2729.6696
fle_else.21862:
	jr	r31				#
fle_else.21858:
	jr	r31				#
sin.2739.6706:
	flup	f2, 14		# fli	f2, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, fle_else.21864
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.21865
fle_else.21864:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.21865:
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
	beq	r0, r30, fle_else.21866
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21868
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21870
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21872
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21874
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21876
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21878
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21880
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21882
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21884
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21886
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21888
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21890
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21892
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2726.6693				#	bl	hoge.2726.6693
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.21893
fle_else.21892:
fle_cont.21893:
	j	fle_cont.21891
fle_else.21890:
fle_cont.21891:
	j	fle_cont.21889
fle_else.21888:
fle_cont.21889:
	j	fle_cont.21887
fle_else.21886:
fle_cont.21887:
	j	fle_cont.21885
fle_else.21884:
fle_cont.21885:
	j	fle_cont.21883
fle_else.21882:
fle_cont.21883:
	j	fle_cont.21881
fle_else.21880:
fle_cont.21881:
	j	fle_cont.21879
fle_else.21878:
fle_cont.21879:
	j	fle_cont.21877
fle_else.21876:
fle_cont.21877:
	j	fle_cont.21875
fle_else.21874:
fle_cont.21875:
	j	fle_cont.21873
fle_else.21872:
fle_cont.21873:
	j	fle_cont.21871
fle_else.21870:
fle_cont.21871:
	j	fle_cont.21869
fle_else.21868:
fle_cont.21869:
	j	fle_cont.21867
fle_else.21866:
fle_cont.21867:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2729.6696				#	bl	fuga.2729.6696
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21894
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.21895
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.21896
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
fle_else.21896:
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
fle_else.21895:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.21897
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
fle_else.21897:
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
fle_else.21894:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.21898
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.21899
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
fle_else.21899:
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
fle_else.21898:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.21900
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
fle_else.21900:
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
cos.2741.6708:
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
	beq	r0, r30, fle_else.21901
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21903
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21905
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21907
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21909
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21911
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21913
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21915
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21917
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21919
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21921
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21923
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21925
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21927
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2726.6693				#	bl	hoge.2726.6693
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.21928
fle_else.21927:
fle_cont.21928:
	j	fle_cont.21926
fle_else.21925:
fle_cont.21926:
	j	fle_cont.21924
fle_else.21923:
fle_cont.21924:
	j	fle_cont.21922
fle_else.21921:
fle_cont.21922:
	j	fle_cont.21920
fle_else.21919:
fle_cont.21920:
	j	fle_cont.21918
fle_else.21917:
fle_cont.21918:
	j	fle_cont.21916
fle_else.21915:
fle_cont.21916:
	j	fle_cont.21914
fle_else.21913:
fle_cont.21914:
	j	fle_cont.21912
fle_else.21911:
fle_cont.21912:
	j	fle_cont.21910
fle_else.21909:
fle_cont.21910:
	j	fle_cont.21908
fle_else.21907:
fle_cont.21908:
	j	fle_cont.21906
fle_else.21905:
fle_cont.21906:
	j	fle_cont.21904
fle_else.21903:
fle_cont.21904:
	j	fle_cont.21902
fle_else.21901:
fle_cont.21902:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2729.6696				#	bl	fuga.2729.6696
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.21929
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.21930
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.21931
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
fle_else.21931:
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
fle_else.21930:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.21932
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
fle_else.21932:
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
fle_else.21929:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.21933
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.21934
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
fle_else.21934:
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
fle_else.21933:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.21935
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
fle_else.21935:
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
atan_body.2743.6710:
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
div10_sub.2751.6718:
	add	r6, r2, r5
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.21936
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r7, r5, 3
	slli	r8, r5, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.21937
	j	div10_sub.2751.6718
ble_then.21937:
	slli	r2, r5, 3
	slli	r7, r5, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.21938
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	j	div10_sub.2751.6718
ble_then.21938:
	add	r1, r0, r5
	jr	r31				#
ble_then.21936:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.21939
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r7, r2, 3
	slli	r8, r2, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.21940
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r6				# mr	r2, r6
	j	div10_sub.2751.6718
ble_then.21940:
	slli	r6, r2, 3
	slli	r7, r2, 1
	add	r6, r6, r7
	addi	r6, r6, 9
	ble	r1, r6, ble_then.21941
	j	div10_sub.2751.6718
ble_then.21941:
	add	r1, r0, r2
	jr	r31				#
ble_then.21939:
	add	r1, r0, r6
	jr	r31				#
print_uint.2771.6738:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.21942
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.21942:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 10
	sw	r1, 1(r3)
	ble	r2, r1, ble_then.21943
	addi	r2, r1, 48
	out	r2
	j	ble_cont.21944
ble_then.21943:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.21945
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.21946
ble_then.21945:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.21947
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.21948
ble_then.21947:
	add	r1, r0, r5
ble_cont.21948:
ble_cont.21946:
	addi	r2, r0, 10
	sw	r1, 2(r3)
	ble	r2, r1, ble_then.21949
	addi	r2, r1, 48
	out	r2
	j	ble_cont.21950
ble_then.21949:
	addi	r2, r0, 0
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 10
	sw	r1, 3(r3)
	ble	r2, r1, ble_then.21951
	addi	r2, r1, 48
	out	r2
	j	ble_cont.21952
ble_then.21951:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.21953
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.21954
ble_then.21953:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.21955
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.21956
ble_then.21955:
	add	r1, r0, r5
ble_cont.21956:
ble_cont.21954:
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
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
ble_cont.21952:
	lw	r1, 3(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 2(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.21950:
	lw	r1, 2(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 1(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.21944:
	lw	r1, 1(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
	jr	r31				#
vecunit_sgn.2855.6822:
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
	beq	r0, r30, feq_else.21957
	addi	r5, r0, 1
	j	feq_cont.21958
feq_else.21957:
	addi	r5, r0, 0
feq_cont.21958:
	beqi	0, r5, beq_then.21959
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.21960
beq_then.21959:
	beqi	0, r2, beq_then.21961
	flup	f2, 11		# fli	f2, -1.000000
	fdiv	f1, f2, f1
	j	beq_cont.21962
beq_then.21961:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
beq_cont.21962:
beq_cont.21960:
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
vecaccumv.2879.6846:
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
read_screen_settings.2956.6923:
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
	jal	cos.2741.6708				#	bl	cos.2741.6708
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin.2739.6706				#	bl	sin.2739.6706
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
	jal	cos.2741.6708				#	bl	cos.2741.6708
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fsw	f1, 14(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	sin.2739.6706				#	bl	sin.2739.6706
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
read_light.2958.6925:
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
	jal	sin.2739.6706				#	bl	sin.2739.6706
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
	jal	cos.2741.6708				#	bl	cos.2741.6708
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2739.6706				#	bl	sin.2739.6706
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	fsw	f1, 0(r1)
	flw	f1, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos.2741.6708				#	bl	cos.2741.6708
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
rotate_quadratic_matrix.2960.6927:
	flw	f1, 0(r2)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	cos.2741.6708				#	bl	cos.2741.6708
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2739.6706				#	bl	sin.2739.6706
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2741.6708				#	bl	cos.2741.6708
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2739.6706				#	bl	sin.2739.6706
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos.2741.6708				#	bl	cos.2741.6708
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 10(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2739.6706				#	bl	sin.2739.6706
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
read_nth_object.2963.6930:
	lw	r2, 1(r29)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.21969
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
	beq	r0, r30, fle_else.21970
	addi	r1, r0, 0
	j	fle_cont.21971
fle_else.21970:
	addi	r1, r0, 1
fle_cont.21971:
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
	beqi	0, r2, beq_then.21972
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
	j	beq_cont.21973
beq_then.21972:
beq_cont.21973:
	lw	r2, 3(r3)
	beqi	2, r2, beq_then.21974
	lw	r5, 8(r3)
	j	beq_cont.21975
beq_then.21974:
	addi	r5, r0, 1
beq_cont.21975:
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
	beqi	3, r7, beq_then.21976
	beqi	2, r7, beq_then.21978
	j	beq_cont.21979
beq_then.21978:
	lw	r2, 8(r3)
	beqi	0, r2, beq_then.21980
	addi	r2, r0, 0
	j	beq_cont.21981
beq_then.21980:
	addi	r2, r0, 1
beq_cont.21981:
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	vecunit_sgn.2855.6822				#	bl	vecunit_sgn.2855.6822
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.21979:
	j	beq_cont.21977
beq_then.21976:
	flw	f1, 0(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.21982
	addi	r2, r0, 1
	j	feq_cont.21983
feq_else.21982:
	addi	r2, r0, 0
feq_cont.21983:
	beqi	0, r2, beq_then.21984
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.21985
beq_then.21984:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.21986
	addi	r2, r0, 1
	j	feq_cont.21987
feq_else.21986:
	addi	r2, r0, 0
feq_cont.21987:
	beqi	0, r2, beq_then.21988
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.21989
beq_then.21988:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.21990
	addi	r2, r0, 0
	j	fle_cont.21991
fle_else.21990:
	addi	r2, r0, 1
fle_cont.21991:
	beqi	0, r2, beq_then.21992
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.21993
beq_then.21992:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.21993:
beq_cont.21989:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.21985:
	fsw	f1, 0(r5)
	flw	f1, 1(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.21994
	addi	r2, r0, 1
	j	feq_cont.21995
feq_else.21994:
	addi	r2, r0, 0
feq_cont.21995:
	beqi	0, r2, beq_then.21996
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.21997
beq_then.21996:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.21998
	addi	r2, r0, 1
	j	feq_cont.21999
feq_else.21998:
	addi	r2, r0, 0
feq_cont.21999:
	beqi	0, r2, beq_then.22000
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.22001
beq_then.22000:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.22002
	addi	r2, r0, 0
	j	fle_cont.22003
fle_else.22002:
	addi	r2, r0, 1
fle_cont.22003:
	beqi	0, r2, beq_then.22004
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.22005
beq_then.22004:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.22005:
beq_cont.22001:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.21997:
	fsw	f1, 1(r5)
	flw	f1, 2(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22006
	addi	r2, r0, 1
	j	feq_cont.22007
feq_else.22006:
	addi	r2, r0, 0
feq_cont.22007:
	beqi	0, r2, beq_then.22008
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.22009
beq_then.22008:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22010
	addi	r2, r0, 1
	j	feq_cont.22011
feq_else.22010:
	addi	r2, r0, 0
feq_cont.22011:
	beqi	0, r2, beq_then.22012
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.22013
beq_then.22012:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.22014
	addi	r2, r0, 0
	j	fle_cont.22015
fle_else.22014:
	addi	r2, r0, 1
fle_cont.22015:
	beqi	0, r2, beq_then.22016
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.22017
beq_then.22016:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.22017:
beq_cont.22013:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.22009:
	fsw	f1, 2(r5)
beq_cont.21977:
	lw	r1, 5(r3)
	beqi	0, r1, beq_then.22018
	lw	r1, 6(r3)
	lw	r2, 11(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	rotate_quadratic_matrix.2960.6927				#	bl	rotate_quadratic_matrix.2960.6927
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.22019
beq_then.22018:
beq_cont.22019:
	addi	r1, r0, 1
	jr	r31				#
beq_then.21969:
	addi	r1, r0, 0
	jr	r31				#
read_object.2965.6932:
	lw	r2, 2(r29)
	lw	r5, 1(r29)
	addi	r6, r0, 60
	ble	r6, r1, ble_then.22020
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
	beqi	0, r1, beq_then.22021
	lw	r1, 3(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.22022
	lw	r29, 1(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.22023
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.22024
	lw	r29, 1(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.22025
	lw	r1, 5(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.22026
	lw	r29, 1(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	0, r1, beq_then.22027
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.22027:
	lw	r1, 2(r3)
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.22026:
	jr	r31				#
beq_then.22025:
	lw	r1, 2(r3)
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.22024:
	jr	r31				#
beq_then.22023:
	lw	r1, 2(r3)
	lw	r2, 4(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.22022:
	jr	r31				#
beq_then.22021:
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.22020:
	jr	r31				#
read_net_item.2969.6936:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.22036
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.22037
	lw	r2, 2(r3)
	addi	r5, r2, 1
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.22039
	lw	r2, 4(r3)
	addi	r5, r2, 1
	sw	r1, 5(r3)
	sw	r5, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.22041
	lw	r2, 6(r3)
	addi	r5, r2, 1
	sw	r1, 7(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.2969.6936				#	bl	read_net_item.2969.6936
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.22042
beq_then.22041:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.22042:
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.22040
beq_then.22039:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.22040:
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.22038
beq_then.22037:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.22038:
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.22036:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	j	lib_create_array
read_or_network.2971.6938:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.22043
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.22045
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.22047
	addi	r2, r0, 3
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.2969.6936				#	bl	read_net_item.2969.6936
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 2(r1)
	j	beq_cont.22048
beq_then.22047:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.22048:
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.22046
beq_then.22045:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.22046:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.22044
beq_then.22043:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.22044:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.22049
	lw	r1, 0(r3)
	addi	r5, r1, 1
	sw	r2, 4(r3)
	sw	r5, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.22050
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.22052
	addi	r2, r0, 2
	sw	r1, 7(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.2969.6936				#	bl	read_net_item.2969.6936
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 7(r3)
	sw	r2, 1(r1)
	j	beq_cont.22053
beq_then.22052:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.22053:
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.22051
beq_then.22050:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.22051:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.22054
	lw	r1, 5(r3)
	addi	r5, r1, 1
	sw	r2, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	read_or_network.2971.6938				#	bl	read_or_network.2971.6938
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 5(r3)
	lw	r5, 8(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.22055
beq_then.22054:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.22055:
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.22049:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.2973.6940:
	lw	r2, 1(r29)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.22056
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	-1, r1, beq_then.22058
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.22060
	addi	r2, r0, 3
	sw	r1, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	read_net_item.2969.6936				#	bl	read_net_item.2969.6936
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 5(r3)
	sw	r2, 2(r1)
	j	beq_cont.22061
beq_then.22060:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.22061:
	lw	r2, 4(r3)
	sw	r2, 1(r1)
	j	beq_cont.22059
beq_then.22058:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.22059:
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	j	beq_cont.22057
beq_then.22056:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.22057:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.22062
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
	beqi	-1, r1, beq_then.22063
	sw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	-1, r1, beq_then.22065
	addi	r2, r0, 2
	sw	r1, 8(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	read_net_item.2969.6936				#	bl	read_net_item.2969.6936
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 8(r3)
	sw	r2, 1(r1)
	j	beq_cont.22066
beq_then.22065:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.22066:
	lw	r2, 7(r3)
	sw	r2, 0(r1)
	j	beq_cont.22064
beq_then.22063:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.22064:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.22067
	lw	r2, 6(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.22067:
	jr	r31				#
beq_then.22062:
	jr	r31				#
solver_rect_surface.2977.6944:
	lw	r8, 1(r29)
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.22070
	addi	r9, r0, 1
	j	feq_cont.22071
feq_else.22070:
	addi	r9, r0, 0
feq_cont.22071:
	beqi	0, r9, beq_then.22072
	addi	r1, r0, 0
	jr	r31				#
beq_then.22072:
	lw	r9, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.22073
	addi	r10, r0, 0
	j	fle_cont.22074
fle_else.22073:
	addi	r10, r0, 1
fle_cont.22074:
	beqi	0, r1, beq_then.22075
	beqi	0, r10, beq_then.22077
	addi	r1, r0, 0
	j	beq_cont.22078
beq_then.22077:
	addi	r1, r0, 1
beq_cont.22078:
	j	beq_cont.22076
beq_then.22075:
	add	r1, r0, r10
beq_cont.22076:
	add	r30, r9, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.22079
	j	beq_cont.22080
beq_then.22079:
	fneg	f4, f4
beq_cont.22080:
	fsub	f1, f4, f1
	add	r30, r2, r5
	flw	f4, 0(r30)
	fdiv	f1, f1, f4
	add	r30, r2, r6
	flw	f4, 0(r30)
	fmul	f4, f1, f4
	fadd	f2, f4, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.22081
	j	fle_cont.22082
fle_else.22081:
	fneg	f2, f2
fle_cont.22082:
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
	beqi	0, r1, beq_then.22083
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	flw	f1, 0(r30)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	flw	f3, 2(r3)
	fadd	f1, f1, f3
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22084
	j	fle_cont.22085
fle_else.22084:
	fneg	f1, f1
fle_cont.22085:
	lw	r2, 1(r3)
	add	r30, r2, r1
	flw	f3, 0(r30)
	fadd	f2, f0, f3				# fmr	f2, f3
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.22086
	lw	r1, 0(r3)
	flw	f1, 4(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.22086:
	addi	r1, r0, 0
	jr	r31				#
beq_then.22083:
	addi	r1, r0, 0
	jr	r31				#
solver_surface.2992.6959:
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
	beq	r0, r30, fle_else.22087
	addi	r2, r0, 0
	j	fle_cont.22088
fle_else.22087:
	addi	r2, r0, 1
fle_cont.22088:
	beqi	0, r2, beq_then.22089
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
beq_then.22089:
	addi	r1, r0, 0
	jr	r31				#
quadratic.2998.6965:
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
	beqi	0, r2, beq_then.22090
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
beq_then.22090:
	fadd	f1, f0, f4
	jr	r31				#
bilinear.3003.6970:
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
	beqi	0, r2, beq_then.22091
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
beq_then.22091:
	fadd	f1, f0, f7
	jr	r31				#
solver_second.3011.6978:
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
	jal	quadratic.2998.6965				#	bl	quadratic.2998.6965
	addi	r3, r3, -11
	lw	r31, 10(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22093
	addi	r1, r0, 1
	j	feq_cont.22094
feq_else.22093:
	addi	r1, r0, 0
feq_cont.22094:
	beqi	0, r1, beq_then.22095
	addi	r1, r0, 0
	jr	r31				#
beq_then.22095:
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
	jal	bilinear.3003.6970				#	bl	bilinear.3003.6970
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
	jal	quadratic.2998.6965				#	bl	quadratic.2998.6965
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 8(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.22096
	j	beq_cont.22097
beq_then.22096:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.22097:
	flw	f2, 12(r3)
	fmul	f3, f2, f2
	flw	f4, 10(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.22098
	addi	r2, r0, 0
	j	fle_cont.22099
fle_else.22098:
	addi	r2, r0, 1
fle_cont.22099:
	beqi	0, r2, beq_then.22100
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.22101
	j	beq_cont.22102
beq_then.22101:
	fneg	f1, f1
beq_cont.22102:
	fsub	f1, f1, f2
	fdiv	f1, f1, f4
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.22100:
	addi	r1, r0, 0
	jr	r31				#
solver.3017.6984:
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
	beqi	1, r5, beq_then.22103
	beqi	2, r5, beq_then.22104
	add	r29, r0, r6				# mr	r29, r6
	lw	r28, 0(r29)
	jr	r28
beq_then.22104:
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
	beq	r0, r30, fle_else.22105
	addi	r2, r0, 0
	j	fle_cont.22106
fle_else.22105:
	addi	r2, r0, 1
fle_cont.22106:
	beqi	0, r2, beq_then.22107
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
beq_then.22107:
	addi	r1, r0, 0
	jr	r31				#
beq_then.22103:
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
	beqi	0, r1, beq_then.22108
	addi	r1, r0, 1
	jr	r31				#
beq_then.22108:
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
	beqi	0, r1, beq_then.22109
	addi	r1, r0, 2
	jr	r31				#
beq_then.22109:
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
	beqi	0, r1, beq_then.22110
	addi	r1, r0, 3
	jr	r31				#
beq_then.22110:
	addi	r1, r0, 0
	jr	r31				#
solver_rect_fast.3021.6988:
	lw	r6, 1(r29)
	flw	f4, 0(r5)
	fsub	f4, f4, f1
	flw	f5, 1(r5)
	fmul	f4, f4, f5
	flw	f5, 1(r2)
	fmul	f5, f4, f5
	fadd	f5, f5, f2
	fle	r30, f0, f5
	beq	r0, r30, fle_else.22111
	j	fle_cont.22112
fle_else.22111:
	fneg	f5, f5
fle_cont.22112:
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
	beqi	0, r1, beq_then.22114
	lw	r1, 12(r3)
	flw	f1, 2(r1)
	flw	f2, 10(r3)
	fmul	f1, f2, f1
	flw	f3, 8(r3)
	fadd	f1, f1, f3
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22116
	j	fle_cont.22117
fle_else.22116:
	fneg	f1, f1
fle_cont.22117:
	lw	r2, 7(r3)
	lw	r5, 4(r2)
	flw	f4, 2(r5)
	fadd	f2, f0, f4				# fmr	f2, f4
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.22118
	lw	r1, 6(r3)
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22120
	addi	r2, r0, 1
	j	feq_cont.22121
feq_else.22120:
	addi	r2, r0, 0
feq_cont.22121:
	beqi	0, r2, beq_then.22122
	addi	r1, r0, 0
	j	beq_cont.22123
beq_then.22122:
	addi	r1, r0, 1
beq_cont.22123:
	j	beq_cont.22119
beq_then.22118:
	addi	r1, r0, 0
beq_cont.22119:
	j	beq_cont.22115
beq_then.22114:
	addi	r1, r0, 0
beq_cont.22115:
	beqi	0, r1, beq_then.22124
	lw	r1, 0(r3)
	flw	f1, 10(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.22124:
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
	beq	r0, r30, fle_else.22125
	j	fle_cont.22126
fle_else.22125:
	fneg	f3, f3
fle_cont.22126:
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
	beqi	0, r1, beq_then.22128
	lw	r1, 12(r3)
	flw	f1, 2(r1)
	flw	f2, 14(r3)
	fmul	f1, f2, f1
	flw	f3, 8(r3)
	fadd	f1, f1, f3
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22130
	j	fle_cont.22131
fle_else.22130:
	fneg	f1, f1
fle_cont.22131:
	lw	r2, 7(r3)
	lw	r5, 4(r2)
	flw	f4, 2(r5)
	fadd	f2, f0, f4				# fmr	f2, f4
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.22132
	lw	r1, 6(r3)
	flw	f1, 3(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22134
	addi	r2, r0, 1
	j	feq_cont.22135
feq_else.22134:
	addi	r2, r0, 0
feq_cont.22135:
	beqi	0, r2, beq_then.22136
	addi	r1, r0, 0
	j	beq_cont.22137
beq_then.22136:
	addi	r1, r0, 1
beq_cont.22137:
	j	beq_cont.22133
beq_then.22132:
	addi	r1, r0, 0
beq_cont.22133:
	j	beq_cont.22129
beq_then.22128:
	addi	r1, r0, 0
beq_cont.22129:
	beqi	0, r1, beq_then.22138
	lw	r1, 0(r3)
	flw	f1, 14(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 2
	jr	r31				#
beq_then.22138:
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
	beq	r0, r30, fle_else.22139
	j	fle_cont.22140
fle_else.22139:
	fneg	f2, f2
fle_cont.22140:
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
	beqi	0, r1, beq_then.22141
	lw	r1, 12(r3)
	flw	f1, 1(r1)
	flw	f2, 16(r3)
	fmul	f1, f2, f1
	flw	f3, 4(r3)
	fadd	f1, f1, f3
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22143
	j	fle_cont.22144
fle_else.22143:
	fneg	f1, f1
fle_cont.22144:
	lw	r1, 7(r3)
	lw	r1, 4(r1)
	flw	f3, 1(r1)
	fadd	f2, f0, f3				# fmr	f2, f3
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.22145
	lw	r1, 6(r3)
	flw	f1, 5(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22147
	addi	r1, r0, 1
	j	feq_cont.22148
feq_else.22147:
	addi	r1, r0, 0
feq_cont.22148:
	beqi	0, r1, beq_then.22149
	addi	r1, r0, 0
	j	beq_cont.22150
beq_then.22149:
	addi	r1, r0, 1
beq_cont.22150:
	j	beq_cont.22146
beq_then.22145:
	addi	r1, r0, 0
beq_cont.22146:
	j	beq_cont.22142
beq_then.22141:
	addi	r1, r0, 0
beq_cont.22142:
	beqi	0, r1, beq_then.22151
	lw	r1, 0(r3)
	flw	f1, 16(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 3
	jr	r31				#
beq_then.22151:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3034.7001:
	lw	r5, 1(r29)
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.22152
	addi	r6, r0, 1
	j	feq_cont.22153
feq_else.22152:
	addi	r6, r0, 0
feq_cont.22153:
	beqi	0, r6, beq_then.22154
	addi	r1, r0, 0
	jr	r31				#
beq_then.22154:
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
	jal	quadratic.2998.6965				#	bl	quadratic.2998.6965
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.22155
	j	beq_cont.22156
beq_then.22155:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.22156:
	flw	f2, 4(r3)
	fmul	f3, f2, f2
	flw	f4, 2(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.22157
	addi	r2, r0, 0
	j	fle_cont.22158
fle_else.22157:
	addi	r2, r0, 1
fle_cont.22158:
	beqi	0, r2, beq_then.22159
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.22160
	fsqrt	f1, f1
	fadd	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	j	beq_cont.22161
beq_then.22160:
	fsqrt	f1, f1
	fsub	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
beq_cont.22161:
	addi	r1, r0, 1
	jr	r31				#
beq_then.22159:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3051.7018:
	lw	r6, 1(r29)
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.22162
	addi	r7, r0, 1
	j	feq_cont.22163
feq_else.22162:
	addi	r7, r0, 0
feq_cont.22163:
	beqi	0, r7, beq_then.22164
	addi	r1, r0, 0
	jr	r31				#
beq_then.22164:
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
	beq	r0, r30, fle_else.22165
	addi	r5, r0, 0
	j	fle_cont.22166
fle_else.22165:
	addi	r5, r0, 1
fle_cont.22166:
	beqi	0, r5, beq_then.22167
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.22168
	fsqrt	f2, f2
	fadd	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r6)
	j	beq_cont.22169
beq_then.22168:
	fsqrt	f2, f2
	fsub	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r6)
beq_cont.22169:
	addi	r1, r0, 1
	jr	r31				#
beq_then.22167:
	addi	r1, r0, 0
	jr	r31				#
solver_fast2.3058.7025:
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
	beqi	1, r10, beq_then.22170
	beqi	2, r10, beq_then.22171
	add	r2, r0, r1				# mr	r2, r1
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r9				# mr	r5, r9
	add	r1, r0, r8				# mr	r1, r8
	lw	r28, 0(r29)
	jr	r28
beq_then.22171:
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22172
	addi	r2, r0, 0
	j	fle_cont.22173
fle_else.22172:
	addi	r2, r0, 1
fle_cont.22173:
	beqi	0, r2, beq_then.22174
	flw	f1, 0(r1)
	flw	f2, 3(r9)
	fmul	f1, f1, f2
	fsw	f1, 0(r7)
	addi	r1, r0, 1
	jr	r31				#
beq_then.22174:
	addi	r1, r0, 0
	jr	r31				#
beq_then.22170:
	lw	r2, 0(r2)
	add	r5, r0, r1				# mr	r5, r1
	add	r29, r0, r6				# mr	r29, r6
	add	r1, r0, r8				# mr	r1, r8
	lw	r28, 0(r29)
	jr	r28
setup_rect_table.3061.7028:
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
	beq	r0, r30, feq_else.22175
	addi	r5, r0, 1
	j	feq_cont.22176
feq_else.22175:
	addi	r5, r0, 0
feq_cont.22176:
	beqi	0, r5, beq_then.22177
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 1(r1)
	j	beq_cont.22178
beq_then.22177:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22179
	addi	r7, r0, 0
	j	fle_cont.22180
fle_else.22179:
	addi	r7, r0, 1
fle_cont.22180:
	beqi	0, r6, beq_then.22181
	beqi	0, r7, beq_then.22183
	addi	r6, r0, 0
	j	beq_cont.22184
beq_then.22183:
	addi	r6, r0, 1
beq_cont.22184:
	j	beq_cont.22182
beq_then.22181:
	add	r6, r0, r7
beq_cont.22182:
	lw	r7, 4(r5)
	flw	f1, 0(r7)
	beqi	0, r6, beq_then.22185
	j	beq_cont.22186
beq_then.22185:
	fneg	f1, f1
beq_cont.22186:
	fsw	f1, 0(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r2)
	fdiv	f1, f1, f2
	fsw	f1, 1(r1)
beq_cont.22178:
	flw	f1, 1(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22187
	addi	r5, r0, 1
	j	feq_cont.22188
feq_else.22187:
	addi	r5, r0, 0
feq_cont.22188:
	beqi	0, r5, beq_then.22189
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 3(r1)
	j	beq_cont.22190
beq_then.22189:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 1(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22191
	addi	r7, r0, 0
	j	fle_cont.22192
fle_else.22191:
	addi	r7, r0, 1
fle_cont.22192:
	beqi	0, r6, beq_then.22193
	beqi	0, r7, beq_then.22195
	addi	r6, r0, 0
	j	beq_cont.22196
beq_then.22195:
	addi	r6, r0, 1
beq_cont.22196:
	j	beq_cont.22194
beq_then.22193:
	add	r6, r0, r7
beq_cont.22194:
	lw	r7, 4(r5)
	flw	f1, 1(r7)
	beqi	0, r6, beq_then.22197
	j	beq_cont.22198
beq_then.22197:
	fneg	f1, f1
beq_cont.22198:
	fsw	f1, 2(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 1(r2)
	fdiv	f1, f1, f2
	fsw	f1, 3(r1)
beq_cont.22190:
	flw	f1, 2(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22199
	addi	r5, r0, 1
	j	feq_cont.22200
feq_else.22199:
	addi	r5, r0, 0
feq_cont.22200:
	beqi	0, r5, beq_then.22201
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 5(r1)
	j	beq_cont.22202
beq_then.22201:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 2(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22203
	addi	r7, r0, 0
	j	fle_cont.22204
fle_else.22203:
	addi	r7, r0, 1
fle_cont.22204:
	beqi	0, r6, beq_then.22205
	beqi	0, r7, beq_then.22207
	addi	r6, r0, 0
	j	beq_cont.22208
beq_then.22207:
	addi	r6, r0, 1
beq_cont.22208:
	j	beq_cont.22206
beq_then.22205:
	add	r6, r0, r7
beq_cont.22206:
	lw	r5, 4(r5)
	flw	f1, 2(r5)
	beqi	0, r6, beq_then.22209
	j	beq_cont.22210
beq_then.22209:
	fneg	f1, f1
beq_cont.22210:
	fsw	f1, 4(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 2(r2)
	fdiv	f1, f1, f2
	fsw	f1, 5(r1)
beq_cont.22202:
	jr	r31				#
setup_surface_table.3064.7031:
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
	beq	r0, r30, fle_else.22211
	addi	r2, r0, 0
	j	fle_cont.22212
fle_else.22211:
	addi	r2, r0, 1
fle_cont.22212:
	beqi	0, r2, beq_then.22213
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
	j	beq_cont.22214
beq_then.22213:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
beq_cont.22214:
	jr	r31				#
setup_second_table.3067.7034:
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
	jal	quadratic.2998.6965				#	bl	quadratic.2998.6965
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
	beqi	0, r6, beq_then.22215
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
	j	beq_cont.22216
beq_then.22215:
	fsw	f2, 1(r5)
	fsw	f3, 2(r5)
	fsw	f4, 3(r5)
beq_cont.22216:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22217
	addi	r1, r0, 1
	j	feq_cont.22218
feq_else.22217:
	addi	r1, r0, 0
feq_cont.22218:
	beqi	0, r1, beq_then.22219
	j	beq_cont.22220
beq_then.22219:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
	fsw	f1, 4(r5)
beq_cont.22220:
	add	r1, r0, r5
	jr	r31				#
iter_setup_dirvec_constants.3070.7037:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.22221
	jr	r31				#
ble_then.22221:
	add	r30, r5, r2
	lw	r6, 0(r30)
	lw	r7, 1(r1)
	lw	r8, 0(r1)
	lw	r9, 1(r6)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	beqi	1, r9, beq_then.22223
	beqi	2, r9, beq_then.22225
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3067.7034				#	bl	setup_second_table.3067.7034
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.22226
beq_then.22225:
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3064.7031				#	bl	setup_surface_table.3064.7031
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.22226:
	j	beq_cont.22224
beq_then.22223:
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3061.7028				#	bl	setup_rect_table.3061.7028
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.22224:
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.22227
	jr	r31				#
ble_then.22227:
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 1(r3)
	lw	r6, 1(r5)
	lw	r7, 0(r5)
	lw	r8, 1(r2)
	beqi	1, r8, beq_then.22229
	beqi	2, r8, beq_then.22231
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_second_table.3067.7034				#	bl	setup_second_table.3067.7034
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.22232
beq_then.22231:
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_surface_table.3064.7031				#	bl	setup_surface_table.3064.7031
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.22232:
	j	beq_cont.22230
beq_then.22229:
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_rect_table.3061.7028				#	bl	setup_rect_table.3061.7028
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.22230:
	addi	r2, r2, -1
	lw	r1, 1(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
setup_startp_constants.3075.7042:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.22233
	jr	r31				#
ble_then.22233:
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
	beqi	2, r7, beq_then.22235
	blei	2, r7, ble_then.22237
	flw	f1, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 2(r6)
	sw	r6, 3(r3)
	sw	r7, 4(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	quadratic.2998.6965				#	bl	quadratic.2998.6965
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	beqi	3, r1, beq_then.22239
	j	beq_cont.22240
beq_then.22239:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.22240:
	lw	r1, 3(r3)
	fsw	f1, 3(r1)
	j	ble_cont.22238
ble_then.22237:
ble_cont.22238:
	j	beq_cont.22236
beq_then.22235:
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
beq_cont.22236:
	lw	r1, 2(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
is_rect_outside.3080.7047:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22241
	j	fle_cont.22242
fle_else.22241:
	fneg	f1, f1
fle_cont.22242:
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
	beqi	0, r1, beq_then.22244
	flw	f1, 4(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22246
	j	fle_cont.22247
fle_else.22246:
	fneg	f1, f1
fle_cont.22247:
	lw	r1, 2(r3)
	lw	r2, 4(r1)
	flw	f2, 1(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.22248
	flw	f1, 0(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22250
	j	fle_cont.22251
fle_else.22250:
	fneg	f1, f1
fle_cont.22251:
	lw	r1, 2(r3)
	lw	r2, 4(r1)
	flw	f2, 2(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.22249
beq_then.22248:
	addi	r1, r0, 0
beq_cont.22249:
	j	beq_cont.22245
beq_then.22244:
	addi	r1, r0, 0
beq_cont.22245:
	beqi	0, r1, beq_then.22252
	lw	r1, 2(r3)
	lw	r1, 6(r1)
	jr	r31				#
beq_then.22252:
	lw	r1, 2(r3)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.22253
	addi	r1, r0, 0
	jr	r31				#
beq_then.22253:
	addi	r1, r0, 1
	jr	r31				#
is_outside.3095.7062:
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
	beqi	1, r2, beq_then.22254
	beqi	2, r2, beq_then.22255
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.2998.6965				#	bl	quadratic.2998.6965
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.22256
	j	beq_cont.22257
beq_then.22256:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.22257:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22258
	addi	r2, r0, 0
	j	fle_cont.22259
fle_else.22258:
	addi	r2, r0, 1
fle_cont.22259:
	beqi	0, r1, beq_then.22260
	beqi	0, r2, beq_then.22262
	addi	r1, r0, 0
	j	beq_cont.22263
beq_then.22262:
	addi	r1, r0, 1
beq_cont.22263:
	j	beq_cont.22261
beq_then.22260:
	add	r1, r0, r2
beq_cont.22261:
	beqi	0, r1, beq_then.22264
	addi	r1, r0, 0
	jr	r31				#
beq_then.22264:
	addi	r1, r0, 1
	jr	r31				#
beq_then.22255:
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
	beq	r0, r30, fle_else.22265
	addi	r2, r0, 0
	j	fle_cont.22266
fle_else.22265:
	addi	r2, r0, 1
fle_cont.22266:
	beqi	0, r1, beq_then.22267
	beqi	0, r2, beq_then.22269
	addi	r1, r0, 0
	j	beq_cont.22270
beq_then.22269:
	addi	r1, r0, 1
beq_cont.22270:
	j	beq_cont.22268
beq_then.22267:
	add	r1, r0, r2
beq_cont.22268:
	beqi	0, r1, beq_then.22271
	addi	r1, r0, 0
	jr	r31				#
beq_then.22271:
	addi	r1, r0, 1
	jr	r31				#
beq_then.22254:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22272
	j	fle_cont.22273
fle_else.22272:
	fneg	f1, f1
fle_cont.22273:
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
	beqi	0, r1, beq_then.22275
	flw	f1, 4(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22277
	j	fle_cont.22278
fle_else.22277:
	fneg	f1, f1
fle_cont.22278:
	lw	r1, 0(r3)
	lw	r2, 4(r1)
	flw	f2, 1(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.22279
	flw	f1, 2(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22281
	j	fle_cont.22282
fle_else.22281:
	fneg	f1, f1
fle_cont.22282:
	lw	r1, 0(r3)
	lw	r2, 4(r1)
	flw	f2, 2(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.22280
beq_then.22279:
	addi	r1, r0, 0
beq_cont.22280:
	j	beq_cont.22276
beq_then.22275:
	addi	r1, r0, 0
beq_cont.22276:
	beqi	0, r1, beq_then.22283
	lw	r1, 0(r3)
	lw	r1, 6(r1)
	jr	r31				#
beq_then.22283:
	lw	r1, 0(r3)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.22284
	addi	r1, r0, 0
	jr	r31				#
beq_then.22284:
	addi	r1, r0, 1
	jr	r31				#
check_all_inside.3100.7067:
	lw	r5, 1(r29)
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.22285
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
	beqi	1, r7, beq_then.22287
	beqi	2, r7, beq_then.22289
	sw	r6, 11(r3)
	add	r1, r0, r6				# mr	r1, r6
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	quadratic.2998.6965				#	bl	quadratic.2998.6965
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 11(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.22291
	j	beq_cont.22292
beq_then.22291:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.22292:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22293
	addi	r2, r0, 0
	j	fle_cont.22294
fle_else.22293:
	addi	r2, r0, 1
fle_cont.22294:
	beqi	0, r1, beq_then.22295
	beqi	0, r2, beq_then.22297
	addi	r1, r0, 0
	j	beq_cont.22298
beq_then.22297:
	addi	r1, r0, 1
beq_cont.22298:
	j	beq_cont.22296
beq_then.22295:
	add	r1, r0, r2
beq_cont.22296:
	beqi	0, r1, beq_then.22299
	addi	r1, r0, 0
	j	beq_cont.22300
beq_then.22299:
	addi	r1, r0, 1
beq_cont.22300:
	j	beq_cont.22290
beq_then.22289:
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
	beq	r0, r30, fle_else.22301
	addi	r7, r0, 0
	j	fle_cont.22302
fle_else.22301:
	addi	r7, r0, 1
fle_cont.22302:
	beqi	0, r6, beq_then.22303
	beqi	0, r7, beq_then.22305
	addi	r6, r0, 0
	j	beq_cont.22306
beq_then.22305:
	addi	r6, r0, 1
beq_cont.22306:
	j	beq_cont.22304
beq_then.22303:
	add	r6, r0, r7
beq_cont.22304:
	beqi	0, r6, beq_then.22307
	addi	r1, r0, 0
	j	beq_cont.22308
beq_then.22307:
	addi	r1, r0, 1
beq_cont.22308:
beq_cont.22290:
	j	beq_cont.22288
beq_then.22287:
	add	r1, r0, r6				# mr	r1, r6
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	is_rect_outside.3080.7047				#	bl	is_rect_outside.3080.7047
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.22288:
	beqi	0, r1, beq_then.22309
	addi	r1, r0, 0
	jr	r31				#
beq_then.22309:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.22310
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
	jal	is_outside.3095.7062				#	bl	is_outside.3095.7062
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.22311
	addi	r1, r0, 0
	jr	r31				#
beq_then.22311:
	lw	r1, 12(r3)
	addi	r1, r1, 1
	flw	f1, 6(r3)
	flw	f2, 4(r3)
	flw	f3, 2(r3)
	lw	r2, 9(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.22310:
	addi	r1, r0, 1
	jr	r31				#
beq_then.22285:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3106.7073:
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
	beqi	-1, r14, beq_then.22312
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
	beqi	1, r16, beq_then.22313
	beqi	2, r16, beq_then.22315
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r6				# mr	r29, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.22316
beq_then.22315:
	flw	f4, 0(r12)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.22317
	addi	r5, r0, 0
	j	fle_cont.22318
fle_else.22317:
	addi	r5, r0, 1
fle_cont.22318:
	beqi	0, r5, beq_then.22319
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
	j	beq_cont.22320
beq_then.22319:
	addi	r1, r0, 0
beq_cont.22320:
beq_cont.22316:
	j	beq_cont.22314
beq_then.22313:
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
beq_cont.22314:
	lw	r2, 8(r3)
	flw	f1, 0(r2)
	fsw	f1, 10(r3)
	beqi	0, r1, beq_then.22322
	flup	f2, 28		# fli	f2, -0.200000
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.22323
beq_then.22322:
	addi	r1, r0, 0
beq_cont.22323:
	beqi	0, r1, beq_then.22324
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
	beqi	-1, r1, beq_then.22325
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
	jal	is_outside.3095.7062				#	bl	is_outside.3095.7062
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.22327
	addi	r1, r0, 0
	j	beq_cont.22328
beq_then.22327:
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
beq_cont.22328:
	j	beq_cont.22326
beq_then.22325:
	addi	r1, r0, 1
beq_cont.22326:
	beqi	0, r1, beq_then.22329
	addi	r1, r0, 1
	jr	r31				#
beq_then.22329:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.22324:
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.22330
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.22330:
	addi	r1, r0, 0
	jr	r31				#
beq_then.22312:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3109.7076:
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.22331
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
	beqi	0, r1, beq_then.22332
	addi	r1, r0, 1
	jr	r31				#
beq_then.22332:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.22333
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
	beqi	0, r1, beq_then.22334
	addi	r1, r0, 1
	jr	r31				#
beq_then.22334:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.22335
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
	beqi	0, r1, beq_then.22336
	addi	r1, r0, 1
	jr	r31				#
beq_then.22336:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.22337
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
	beqi	0, r1, beq_then.22338
	addi	r1, r0, 1
	jr	r31				#
beq_then.22338:
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.22337:
	addi	r1, r0, 0
	jr	r31				#
beq_then.22335:
	addi	r1, r0, 0
	jr	r31				#
beq_then.22333:
	addi	r1, r0, 0
	jr	r31				#
beq_then.22331:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3112.7079:
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
	beqi	-1, r16, beq_then.22339
	addi	r17, r0, 99
	sw	r9, 0(r3)
	sw	r10, 1(r3)
	sw	r14, 2(r3)
	sw	r15, 3(r3)
	sw	r2, 4(r3)
	sw	r29, 5(r3)
	sw	r1, 6(r3)
	beq	r16, r17, beq_then.22340
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
	beqi	1, r13, beq_then.22342
	beqi	2, r13, beq_then.22344
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r11				# mr	r1, r11
	add	r29, r0, r6				# mr	r29, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.22345
beq_then.22344:
	flw	f4, 0(r12)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.22346
	addi	r5, r0, 0
	j	fle_cont.22347
fle_else.22346:
	addi	r5, r0, 1
fle_cont.22347:
	beqi	0, r5, beq_then.22348
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
	j	beq_cont.22349
beq_then.22348:
	addi	r1, r0, 0
beq_cont.22349:
beq_cont.22345:
	j	beq_cont.22343
beq_then.22342:
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
beq_cont.22343:
	beqi	0, r1, beq_then.22350
	lw	r1, 7(r3)
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.22352
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.22354
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
	beqi	0, r1, beq_then.22356
	addi	r1, r0, 1
	j	beq_cont.22357
beq_then.22356:
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.22358
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
	beqi	0, r1, beq_then.22360
	addi	r1, r0, 1
	j	beq_cont.22361
beq_then.22360:
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.22362
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
	beqi	0, r1, beq_then.22364
	addi	r1, r0, 1
	j	beq_cont.22365
beq_then.22364:
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.22365:
	j	beq_cont.22363
beq_then.22362:
	addi	r1, r0, 0
beq_cont.22363:
beq_cont.22361:
	j	beq_cont.22359
beq_then.22358:
	addi	r1, r0, 0
beq_cont.22359:
beq_cont.22357:
	j	beq_cont.22355
beq_then.22354:
	addi	r1, r0, 0
beq_cont.22355:
	beqi	0, r1, beq_then.22366
	addi	r1, r0, 1
	j	beq_cont.22367
beq_then.22366:
	addi	r1, r0, 0
beq_cont.22367:
	j	beq_cont.22353
beq_then.22352:
	addi	r1, r0, 0
beq_cont.22353:
	j	beq_cont.22351
beq_then.22350:
	addi	r1, r0, 0
beq_cont.22351:
	j	beq_cont.22341
beq_then.22340:
	addi	r1, r0, 1
beq_cont.22341:
	beqi	0, r1, beq_then.22368
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.22369
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
	beqi	0, r1, beq_then.22371
	addi	r1, r0, 1
	j	beq_cont.22372
beq_then.22371:
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.22373
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
	beqi	0, r1, beq_then.22375
	addi	r1, r0, 1
	j	beq_cont.22376
beq_then.22375:
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.22377
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
	beqi	0, r1, beq_then.22379
	addi	r1, r0, 1
	j	beq_cont.22380
beq_then.22379:
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r29, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.22380:
	j	beq_cont.22378
beq_then.22377:
	addi	r1, r0, 0
beq_cont.22378:
beq_cont.22376:
	j	beq_cont.22374
beq_then.22373:
	addi	r1, r0, 0
beq_cont.22374:
beq_cont.22372:
	j	beq_cont.22370
beq_then.22369:
	addi	r1, r0, 0
beq_cont.22370:
	beqi	0, r1, beq_then.22381
	addi	r1, r0, 1
	jr	r31				#
beq_then.22381:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r29, 5(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.22368:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r29, 5(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.22339:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3115.7082:
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
	beqi	-1, r17, beq_then.22382
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
	beqi	1, r19, beq_then.22383
	beqi	2, r19, beq_then.22385
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r18				# mr	r1, r18
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.22386
beq_then.22385:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r18				# mr	r1, r18
	add	r29, r0, r8				# mr	r29, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.22386:
	j	beq_cont.22384
beq_then.22383:
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
	beqi	0, r1, beq_then.22388
	addi	r1, r0, 1
	j	beq_cont.22389
beq_then.22388:
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
	beqi	0, r1, beq_then.22390
	addi	r1, r0, 2
	j	beq_cont.22391
beq_then.22390:
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
	beqi	0, r1, beq_then.22392
	addi	r1, r0, 3
	j	beq_cont.22393
beq_then.22392:
	addi	r1, r0, 0
beq_cont.22393:
beq_cont.22391:
beq_cont.22389:
beq_cont.22384:
	beqi	0, r1, beq_then.22394
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
	beqi	0, r1, beq_then.22396
	lw	r1, 5(r3)
	flw	f2, 0(r1)
	flw	f1, 24(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -27
	lw	r31, 26(r3)
	beqi	0, r1, beq_then.22398
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
	beqi	-1, r1, beq_then.22400
	lw	r6, 12(r3)
	add	r30, r6, r1
	lw	r1, 0(r30)
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	is_outside.3095.7062				#	bl	is_outside.3095.7062
	addi	r3, r3, -35
	lw	r31, 34(r3)
	beqi	0, r1, beq_then.22402
	addi	r1, r0, 0
	j	beq_cont.22403
beq_then.22402:
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
beq_cont.22403:
	j	beq_cont.22401
beq_then.22400:
	addi	r1, r0, 1
beq_cont.22401:
	beqi	0, r1, beq_then.22404
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
	j	beq_cont.22405
beq_then.22404:
beq_cont.22405:
	j	beq_cont.22399
beq_then.22398:
beq_cont.22399:
	j	beq_cont.22397
beq_then.22396:
beq_cont.22397:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r29, 9(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.22394:
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.22406
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r29, 9(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.22406:
	jr	r31				#
beq_then.22382:
	jr	r31				#
solve_one_or_network.3119.7086:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.22409
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
	beqi	-1, r5, beq_then.22410
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
	beqi	-1, r5, beq_then.22411
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
	beqi	-1, r5, beq_then.22412
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
beq_then.22412:
	jr	r31				#
beq_then.22411:
	jr	r31				#
beq_then.22410:
	jr	r31				#
beq_then.22409:
	jr	r31				#
trace_or_matrix.3123.7090:
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
	beqi	-1, r18, beq_then.22417
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
	beq	r18, r19, beq_then.22418
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
	beqi	1, r18, beq_then.22420
	beqi	2, r18, beq_then.22422
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.22423
beq_then.22422:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r8				# mr	r29, r8
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.22423:
	j	beq_cont.22421
beq_then.22420:
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
	beqi	0, r1, beq_then.22424
	addi	r1, r0, 1
	j	beq_cont.22425
beq_then.22424:
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
	beqi	0, r1, beq_then.22426
	addi	r1, r0, 2
	j	beq_cont.22427
beq_then.22426:
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
	beqi	0, r1, beq_then.22428
	addi	r1, r0, 3
	j	beq_cont.22429
beq_then.22428:
	addi	r1, r0, 0
beq_cont.22429:
beq_cont.22427:
beq_cont.22425:
beq_cont.22421:
	beqi	0, r1, beq_then.22430
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r2, 1(r3)
	flw	f2, 0(r2)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.22432
	lw	r1, 11(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.22434
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
	beqi	-1, r2, beq_then.22436
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
	beqi	-1, r2, beq_then.22438
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
	j	beq_cont.22439
beq_then.22438:
beq_cont.22439:
	j	beq_cont.22437
beq_then.22436:
beq_cont.22437:
	j	beq_cont.22435
beq_then.22434:
beq_cont.22435:
	j	beq_cont.22433
beq_then.22432:
beq_cont.22433:
	j	beq_cont.22431
beq_then.22430:
beq_cont.22431:
	j	beq_cont.22419
beq_then.22418:
	lw	r8, 1(r17)
	beqi	-1, r8, beq_then.22440
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
	beqi	-1, r2, beq_then.22442
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
	beqi	-1, r2, beq_then.22444
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
	j	beq_cont.22445
beq_then.22444:
beq_cont.22445:
	j	beq_cont.22443
beq_then.22442:
beq_cont.22443:
	j	beq_cont.22441
beq_then.22440:
beq_cont.22441:
beq_cont.22419:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.22446
	addi	r7, r0, 99
	sw	r1, 20(r3)
	beq	r6, r7, beq_then.22447
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
	beqi	0, r1, beq_then.22449
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -23
	lw	r31, 22(r3)
	beqi	0, r1, beq_then.22451
	lw	r1, 21(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.22453
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
	beqi	-1, r2, beq_then.22455
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
	j	beq_cont.22456
beq_then.22455:
beq_cont.22456:
	j	beq_cont.22454
beq_then.22453:
beq_cont.22454:
	j	beq_cont.22452
beq_then.22451:
beq_cont.22452:
	j	beq_cont.22450
beq_then.22449:
beq_cont.22450:
	j	beq_cont.22448
beq_then.22447:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.22457
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
	beqi	-1, r2, beq_then.22459
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
	j	beq_cont.22460
beq_then.22459:
beq_cont.22460:
	j	beq_cont.22458
beq_then.22457:
beq_cont.22458:
beq_cont.22448:
	lw	r1, 20(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 6(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.22446:
	jr	r31				#
beq_then.22417:
	jr	r31				#
solve_each_element_fast.3129.7096:
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
	beqi	-1, r17, beq_then.22463
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
	beqi	1, r21, beq_then.22464
	beqi	2, r21, beq_then.22466
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
	j	beq_cont.22467
beq_then.22466:
	flw	f1, 0(r20)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22468
	addi	r8, r0, 0
	j	fle_cont.22469
fle_else.22468:
	addi	r8, r0, 1
fle_cont.22469:
	beqi	0, r8, beq_then.22470
	flw	f1, 0(r20)
	flw	f2, 3(r19)
	fmul	f1, f1, f2
	fsw	f1, 0(r10)
	addi	r1, r0, 1
	j	beq_cont.22471
beq_then.22470:
	addi	r1, r0, 0
beq_cont.22471:
beq_cont.22467:
	j	beq_cont.22465
beq_then.22464:
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
beq_cont.22465:
	beqi	0, r1, beq_then.22472
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
	beqi	0, r1, beq_then.22474
	lw	r1, 6(r3)
	flw	f2, 0(r1)
	flw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.22476
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
	beqi	-1, r1, beq_then.22478
	lw	r5, 13(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	is_outside.3095.7062				#	bl	is_outside.3095.7062
	addi	r3, r3, -27
	lw	r31, 26(r3)
	beqi	0, r1, beq_then.22480
	addi	r1, r0, 0
	j	beq_cont.22481
beq_then.22480:
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
beq_cont.22481:
	j	beq_cont.22479
beq_then.22478:
	addi	r1, r0, 1
beq_cont.22479:
	beqi	0, r1, beq_then.22482
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
	j	beq_cont.22483
beq_then.22482:
beq_cont.22483:
	j	beq_cont.22477
beq_then.22476:
beq_cont.22477:
	j	beq_cont.22475
beq_then.22474:
beq_cont.22475:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r29, 10(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.22472:
	lw	r1, 12(r3)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.22484
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r29, 10(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.22484:
	jr	r31				#
beq_then.22463:
	jr	r31				#
solve_one_or_network_fast.3133.7100:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.22487
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
	beqi	-1, r5, beq_then.22488
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
	beqi	-1, r5, beq_then.22489
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
	beqi	-1, r5, beq_then.22490
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
beq_then.22490:
	jr	r31				#
beq_then.22489:
	jr	r31				#
beq_then.22488:
	jr	r31				#
beq_then.22487:
	jr	r31				#
trace_or_matrix_fast.3137.7104:
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
	beqi	-1, r16, beq_then.22495
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
	beq	r16, r17, beq_then.22496
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
	beqi	1, r18, beq_then.22498
	beqi	2, r18, beq_then.22500
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
	j	beq_cont.22501
beq_then.22500:
	flw	f1, 0(r16)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22502
	addi	r7, r0, 0
	j	fle_cont.22503
fle_else.22502:
	addi	r7, r0, 1
fle_cont.22503:
	beqi	0, r7, beq_then.22504
	flw	f1, 0(r16)
	flw	f2, 3(r17)
	fmul	f1, f1, f2
	fsw	f1, 0(r10)
	addi	r1, r0, 1
	j	beq_cont.22505
beq_then.22504:
	addi	r1, r0, 0
beq_cont.22505:
beq_cont.22501:
	j	beq_cont.22499
beq_then.22498:
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
beq_cont.22499:
	beqi	0, r1, beq_then.22506
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r2, 1(r3)
	flw	f2, 0(r2)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.22508
	lw	r1, 10(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.22510
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
	beqi	-1, r2, beq_then.22512
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
	beqi	-1, r2, beq_then.22514
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
	j	beq_cont.22515
beq_then.22514:
beq_cont.22515:
	j	beq_cont.22513
beq_then.22512:
beq_cont.22513:
	j	beq_cont.22511
beq_then.22510:
beq_cont.22511:
	j	beq_cont.22509
beq_then.22508:
beq_cont.22509:
	j	beq_cont.22507
beq_then.22506:
beq_cont.22507:
	j	beq_cont.22497
beq_then.22496:
	lw	r7, 1(r15)
	beqi	-1, r7, beq_then.22516
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
	beqi	-1, r2, beq_then.22518
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
	beqi	-1, r2, beq_then.22520
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
	j	beq_cont.22521
beq_then.22520:
beq_cont.22521:
	j	beq_cont.22519
beq_then.22518:
beq_cont.22519:
	j	beq_cont.22517
beq_then.22516:
beq_cont.22517:
beq_cont.22497:
	lw	r1, 9(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.22522
	addi	r7, r0, 99
	sw	r1, 11(r3)
	beq	r6, r7, beq_then.22523
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
	beqi	0, r1, beq_then.22525
	lw	r1, 2(r3)
	flw	f1, 0(r1)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.22527
	lw	r1, 12(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.22529
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
	beqi	-1, r2, beq_then.22531
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
	j	beq_cont.22532
beq_then.22531:
beq_cont.22532:
	j	beq_cont.22530
beq_then.22529:
beq_cont.22530:
	j	beq_cont.22528
beq_then.22527:
beq_cont.22528:
	j	beq_cont.22526
beq_then.22525:
beq_cont.22526:
	j	beq_cont.22524
beq_then.22523:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.22533
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
	beqi	-1, r2, beq_then.22535
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
	j	beq_cont.22536
beq_then.22535:
beq_cont.22536:
	j	beq_cont.22534
beq_then.22533:
beq_cont.22534:
beq_cont.22524:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 5(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.22522:
	jr	r31				#
beq_then.22495:
	jr	r31				#
judge_intersection_fast.3141.7108:
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
	beqi	-1, r13, beq_then.22539
	addi	r14, r0, 99
	sw	r1, 1(r3)
	sw	r10, 2(r3)
	sw	r2, 3(r3)
	beq	r13, r14, beq_then.22541
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
	beqi	0, r1, beq_then.22543
	lw	r1, 8(r3)
	flw	f1, 0(r1)
	lw	r1, 0(r3)
	flw	f2, 0(r1)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -10
	lw	r31, 9(r3)
	beqi	0, r1, beq_then.22545
	lw	r1, 7(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.22547
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
	beqi	-1, r2, beq_then.22549
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
	j	beq_cont.22550
beq_then.22549:
beq_cont.22550:
	j	beq_cont.22548
beq_then.22547:
beq_cont.22548:
	j	beq_cont.22546
beq_then.22545:
beq_cont.22546:
	j	beq_cont.22544
beq_then.22543:
beq_cont.22544:
	j	beq_cont.22542
beq_then.22541:
	lw	r6, 1(r12)
	beqi	-1, r6, beq_then.22551
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
	beqi	-1, r2, beq_then.22553
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
	j	beq_cont.22554
beq_then.22553:
beq_cont.22554:
	j	beq_cont.22552
beq_then.22551:
beq_cont.22552:
beq_cont.22542:
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
	j	beq_cont.22540
beq_then.22539:
beq_cont.22540:
	lw	r1, 0(r3)
	flw	f2, 0(r1)
	flup	f1, 30		# fli	f1, -0.100000
	fsw	f2, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -13
	lw	r31, 12(r3)
	beqi	0, r1, beq_then.22556
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 10(r3)
	j	lib_fless
beq_then.22556:
	addi	r1, r0, 0
	jr	r31				#
get_nvector_second.3147.7114:
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
	beqi	0, r5, beq_then.22557
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
	j	beq_cont.22558
beq_then.22557:
	fsw	f4, 0(r2)
	fsw	f5, 1(r2)
	fsw	f6, 2(r2)
beq_cont.22558:
	lw	r1, 6(r1)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	vecunit_sgn.2855.6822
get_nvector.3149.7116:
	lw	r5, 3(r29)
	lw	r6, 2(r29)
	lw	r29, 1(r29)
	lw	r7, 1(r1)
	beqi	1, r7, beq_then.22559
	beqi	2, r7, beq_then.22560
	lw	r28, 0(r29)
	jr	r28
beq_then.22560:
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
beq_then.22559:
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
	beq	r0, r30, feq_else.22562
	addi	r1, r0, 1
	j	feq_cont.22563
feq_else.22562:
	addi	r1, r0, 0
feq_cont.22563:
	beqi	0, r1, beq_then.22564
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.22565
beq_then.22564:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.22566
	addi	r1, r0, 0
	j	fle_cont.22567
fle_else.22566:
	addi	r1, r0, 1
fle_cont.22567:
	beqi	0, r1, beq_then.22568
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.22569
beq_then.22568:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.22569:
beq_cont.22565:
	fneg	f1, f1
	add	r30, r5, r6
	fsw	f1, 0(r30)
	jr	r31				#
utexture.3152.7119:
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
	beqi	1, r6, beq_then.22571
	beqi	2, r6, beq_then.22572
	beqi	3, r6, beq_then.22573
	beqi	4, r6, beq_then.22574
	jr	r31				#
beq_then.22574:
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
	beq	r0, r30, fle_else.22576
	fadd	f4, f0, f1
	j	fle_cont.22577
fle_else.22576:
	fneg	f4, f1
fle_cont.22577:
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
	beqi	0, r1, beq_then.22579
	flup	f1, 34		# fli	f1, 15.000000
	j	beq_cont.22580
beq_then.22579:
	flw	f1, 6(r3)
	flw	f2, 8(r3)
	fdiv	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22581
	j	fle_cont.22582
fle_else.22581:
	fneg	f1, f1
fle_cont.22582:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22583
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.22584
fle_else.22583:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.22584:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.22585
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.22587
	flup	f3, 15		# fli	f3, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	fsw	f2, 10(r3)
	fsw	f3, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	atan_body.2743.6710				#	bl	atan_body.2743.6710
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fadd	f1, f2, f1
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	j	fle_cont.22588
fle_else.22587:
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
	jal	atan_body.2743.6710				#	bl	atan_body.2743.6710
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	flw	f2, 10(r3)
	fmul	f1, f1, f2
fle_cont.22588:
	j	fle_cont.22586
fle_else.22585:
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2743.6710				#	bl	atan_body.2743.6710
	addi	r3, r3, -17
	lw	r31, 16(r3)
fle_cont.22586:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
beq_cont.22580:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22589
	addi	r1, r0, 0
	j	feq_cont.22590
feq_else.22589:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22591
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.22592
fle_else.22591:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.22592:
feq_cont.22590:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.22593
	j	fle_cont.22594
fle_else.22593:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.22594:
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
	beq	r0, r30, fle_else.22595
	fadd	f4, f0, f3
	j	fle_cont.22596
fle_else.22595:
	fneg	f4, f3
fle_cont.22596:
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
	beqi	0, r1, beq_then.22597
	flup	f1, 34		# fli	f1, 15.000000
	j	beq_cont.22598
beq_then.22597:
	flw	f1, 2(r3)
	flw	f2, 18(r3)
	fdiv	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22599
	j	fle_cont.22600
fle_else.22599:
	fneg	f1, f1
fle_cont.22600:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22601
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.22602
fle_else.22601:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.22602:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.22603
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.22605
	flup	f3, 15		# fli	f3, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	fsw	f2, 20(r3)
	fsw	f3, 22(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	atan_body.2743.6710				#	bl	atan_body.2743.6710
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 22(r3)
	fadd	f1, f2, f1
	flw	f2, 20(r3)
	fmul	f1, f1, f2
	j	fle_cont.22606
fle_else.22605:
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
	jal	atan_body.2743.6710				#	bl	atan_body.2743.6710
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 24(r3)
	fadd	f1, f2, f1
	flw	f2, 20(r3)
	fmul	f1, f1, f2
fle_cont.22606:
	j	fle_cont.22604
fle_else.22603:
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	atan_body.2743.6710				#	bl	atan_body.2743.6710
	addi	r3, r3, -27
	lw	r31, 26(r3)
fle_cont.22604:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
beq_cont.22598:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22607
	addi	r1, r0, 0
	j	feq_cont.22608
feq_else.22607:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22609
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.22610
fle_else.22609:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.22610:
feq_cont.22608:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.22611
	j	fle_cont.22612
fle_else.22611:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.22612:
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
	beq	r0, r30, fle_else.22613
	addi	r1, r0, 0
	j	fle_cont.22614
fle_else.22613:
	addi	r1, r0, 1
fle_cont.22614:
	beqi	0, r1, beq_then.22615
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.22616
beq_then.22615:
beq_cont.22616:
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f2, f1
	flup	f2, 38		# fli	f2, 0.300000
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.22573:
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
	beq	r0, r30, feq_else.22618
	addi	r1, r0, 0
	j	feq_cont.22619
feq_else.22618:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22620
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.22621
fle_else.22620:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.22621:
feq_cont.22619:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.22622
	j	fle_cont.22623
fle_else.22622:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.22623:
	fsub	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fmul	f1, f1, f2
	sw	r5, 0(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	cos.2741.6708				#	bl	cos.2741.6708
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
beq_then.22572:
	flw	f1, 1(r2)
	flup	f2, 40		# fli	f2, 0.250000
	fmul	f1, f1, f2
	sw	r5, 0(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	sin.2739.6706				#	bl	sin.2739.6706
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
beq_then.22571:
	flw	f1, 0(r2)
	lw	r6, 5(r1)
	flw	f2, 0(r6)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	feq	r30, f2, f0
	beq	r0, r30, feq_else.22626
	addi	r6, r0, 0
	j	feq_cont.22627
feq_else.22626:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.22628
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r6, f3
	j	fle_cont.22629
fle_else.22628:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r6, f3
fle_cont.22629:
feq_cont.22627:
	itof	f3, r6
	fle	r30, f3, f2
	beq	r0, r30, fle_else.22630
	fadd	f2, f0, f3
	j	fle_cont.22631
fle_else.22630:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.22631:
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
	beq	r0, r30, feq_else.22632
	addi	r2, r0, 0
	j	feq_cont.22633
feq_else.22632:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.22634
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r2, f3
	j	fle_cont.22635
fle_else.22634:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r2, f3
fle_cont.22635:
feq_cont.22633:
	itof	f3, r2
	fle	r30, f3, f2
	beq	r0, r30, fle_else.22636
	fadd	f2, f0, f3
	j	fle_cont.22637
fle_else.22636:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.22637:
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
	beqi	0, r2, beq_then.22638
	beqi	0, r1, beq_then.22640
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.22641
beq_then.22640:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.22641:
	j	beq_cont.22639
beq_then.22638:
	beqi	0, r1, beq_then.22642
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.22643
beq_then.22642:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.22643:
beq_cont.22639:
	lw	r1, 0(r3)
	fsw	f1, 1(r1)
	jr	r31				#
trace_reflections.3159.7126:
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
	ble	r15, r1, ble_then.22645
	jr	r31				#
ble_then.22645:
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
	beqi	0, r1, beq_then.22648
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -21
	lw	r31, 20(r3)
	j	beq_cont.22649
beq_then.22648:
	addi	r1, r0, 0
beq_cont.22649:
	beqi	0, r1, beq_then.22650
	lw	r1, 16(r3)
	lw	r1, 0(r1)
	slli	r1, r1, 2
	lw	r2, 15(r3)
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 14(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.22652
	j	beq_cont.22653
beq_then.22652:
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
	beqi	0, r1, beq_then.22654
	j	beq_cont.22655
beq_then.22654:
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
	beq	r0, r30, fle_else.22656
	addi	r1, r0, 0
	j	fle_cont.22657
fle_else.22656:
	addi	r1, r0, 1
fle_cont.22657:
	beqi	0, r1, beq_then.22658
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
	j	beq_cont.22659
beq_then.22658:
beq_cont.22659:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.22660
	addi	r1, r0, 0
	j	fle_cont.22661
fle_else.22660:
	addi	r1, r0, 1
fle_cont.22661:
	beqi	0, r1, beq_then.22662
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
	j	beq_cont.22663
beq_then.22662:
beq_cont.22663:
beq_cont.22655:
beq_cont.22653:
	j	beq_cont.22651
beq_then.22650:
beq_cont.22651:
	lw	r1, 1(r3)
	addi	r1, r1, -1
	flw	f1, 8(r3)
	flw	f2, 2(r3)
	lw	r2, 6(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
trace_ray.3164.7131:
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
	blei	4, r1, ble_then.22664
	jr	r31				#
ble_then.22664:
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
	beqi	0, r1, beq_then.22669
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 34(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -37
	lw	r31, 36(r3)
	j	beq_cont.22670
beq_then.22669:
	addi	r1, r0, 0
beq_cont.22670:
	beqi	0, r1, beq_then.22671
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
	beqi	1, r6, beq_then.22673
	beqi	2, r6, beq_then.22675
	lw	r29, 18(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -43
	lw	r31, 42(r3)
	j	beq_cont.22676
beq_then.22675:
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
beq_cont.22676:
	j	beq_cont.22674
beq_then.22673:
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
	beq	r0, r30, feq_else.22677
	addi	r7, r0, 1
	j	feq_cont.22678
feq_else.22677:
	addi	r7, r0, 0
feq_cont.22678:
	beqi	0, r7, beq_then.22679
	flup	f3, 0		# fli	f3, 0.000000
	j	beq_cont.22680
beq_then.22679:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.22681
	addi	r7, r0, 0
	j	fle_cont.22682
fle_else.22681:
	addi	r7, r0, 1
fle_cont.22682:
	beqi	0, r7, beq_then.22683
	flup	f3, 2		# fli	f3, 1.000000
	j	beq_cont.22684
beq_then.22683:
	flup	f3, 11		# fli	f3, -1.000000
beq_cont.22684:
beq_cont.22680:
	fneg	f3, f3
	add	r30, r8, r9
	fsw	f3, 0(r30)
beq_cont.22674:
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
	beqi	0, r1, beq_then.22685
	lw	r1, 30(r3)
	lw	r2, 42(r3)
	lw	r5, 11(r3)
	add	r30, r2, r1
	sw	r5, 0(r30)
	j	beq_cont.22686
beq_then.22685:
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
beq_cont.22686:
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
	beqi	0, r1, beq_then.22688
	j	beq_cont.22689
beq_then.22688:
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
	beq	r0, r30, fle_else.22690
	addi	r2, r0, 0
	j	fle_cont.22691
fle_else.22690:
	addi	r2, r0, 1
fle_cont.22691:
	beqi	0, r2, beq_then.22692
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
	j	beq_cont.22693
beq_then.22692:
beq_cont.22693:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.22694
	addi	r2, r0, 0
	j	fle_cont.22695
fle_else.22694:
	addi	r2, r0, 1
fle_cont.22695:
	beqi	0, r2, beq_then.22696
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
	j	beq_cont.22697
beq_then.22696:
beq_cont.22697:
beq_cont.22689:
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
	beqi	0, r1, beq_then.22698
	addi	r1, r0, 4
	lw	r2, 30(r3)
	ble	r1, r2, ble_then.22699
	addi	r1, r2, 1
	addi	r5, r0, -1
	lw	r6, 31(r3)
	add	r30, r6, r1
	sw	r5, 0(r30)
	j	ble_cont.22700
ble_then.22699:
ble_cont.22700:
	lw	r1, 36(r3)
	beqi	2, r1, beq_then.22701
	j	beq_cont.22702
beq_then.22701:
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
beq_cont.22702:
	jr	r31				#
beq_then.22698:
	jr	r31				#
beq_then.22671:
	addi	r1, r0, -1
	lw	r2, 30(r3)
	lw	r5, 31(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	0, r2, beq_then.22705
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
	beq	r0, r30, fle_else.22706
	addi	r1, r0, 0
	j	fle_cont.22707
fle_else.22706:
	addi	r1, r0, 1
fle_cont.22707:
	beqi	0, r1, beq_then.22708
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
beq_then.22708:
	jr	r31				#
beq_then.22705:
	jr	r31				#
trace_diffuse_ray.3170.7137:
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
	beqi	0, r1, beq_then.22712
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	j	beq_cont.22713
beq_then.22712:
	addi	r1, r0, 0
beq_cont.22713:
	beqi	0, r1, beq_then.22714
	lw	r1, 14(r3)
	lw	r1, 0(r1)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 12(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	sw	r1, 18(r3)
	beqi	1, r5, beq_then.22715
	beqi	2, r5, beq_then.22717
	lw	r29, 9(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
	j	beq_cont.22718
beq_then.22717:
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
beq_cont.22718:
	j	beq_cont.22716
beq_then.22715:
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
	beq	r0, r30, feq_else.22719
	addi	r2, r0, 1
	j	feq_cont.22720
feq_else.22719:
	addi	r2, r0, 0
feq_cont.22720:
	beqi	0, r2, beq_then.22721
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.22722
beq_then.22721:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.22723
	addi	r2, r0, 0
	j	fle_cont.22724
fle_else.22723:
	addi	r2, r0, 1
fle_cont.22724:
	beqi	0, r2, beq_then.22725
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.22726
beq_then.22725:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.22726:
beq_cont.22722:
	fneg	f1, f1
	add	r30, r6, r7
	fsw	f1, 0(r30)
beq_cont.22716:
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
	beqi	0, r1, beq_then.22727
	jr	r31				#
beq_then.22727:
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
	beq	r0, r30, fle_else.22729
	addi	r1, r0, 0
	j	fle_cont.22730
fle_else.22729:
	addi	r1, r0, 1
fle_cont.22730:
	beqi	0, r1, beq_then.22731
	j	beq_cont.22732
beq_then.22731:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.22732:
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
beq_then.22714:
	jr	r31				#
iter_trace_diffuse_rays.3173.7140:
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
	ble	r20, r6, ble_then.22735
	jr	r31				#
ble_then.22735:
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
	beq	r0, r30, fle_else.22737
	addi	r20, r0, 0
	j	fle_cont.22738
fle_else.22737:
	addi	r20, r0, 1
fle_cont.22738:
	sw	r5, 0(r3)
	sw	r29, 1(r3)
	sw	r8, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	sw	r6, 5(r3)
	beqi	0, r20, beq_then.22739
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
	beqi	0, r1, beq_then.22741
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
	beqi	0, r1, beq_then.22743
	j	beq_cont.22744
beq_then.22743:
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
	beq	r0, r30, fle_else.22745
	addi	r1, r0, 0
	j	fle_cont.22746
fle_else.22745:
	addi	r1, r0, 1
fle_cont.22746:
	beqi	0, r1, beq_then.22747
	j	beq_cont.22748
beq_then.22747:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.22748:
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
beq_cont.22744:
	j	beq_cont.22742
beq_then.22741:
beq_cont.22742:
	j	beq_cont.22740
beq_then.22739:
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
	beqi	0, r1, beq_then.22750
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
	beqi	0, r1, beq_then.22752
	j	beq_cont.22753
beq_then.22752:
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
	beq	r0, r30, fle_else.22754
	addi	r1, r0, 0
	j	fle_cont.22755
fle_else.22754:
	addi	r1, r0, 1
fle_cont.22755:
	beqi	0, r1, beq_then.22756
	j	beq_cont.22757
beq_then.22756:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.22757:
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
beq_cont.22753:
	j	beq_cont.22751
beq_then.22750:
beq_cont.22751:
beq_cont.22740:
	lw	r1, 5(r3)
	addi	r1, r1, -2
	addi	r2, r0, 0
	ble	r2, r1, ble_then.22758
	jr	r31				#
ble_then.22758:
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
	beq	r0, r30, fle_else.22760
	addi	r5, r0, 0
	j	fle_cont.22761
fle_else.22760:
	addi	r5, r0, 1
fle_cont.22761:
	sw	r1, 26(r3)
	beqi	0, r5, beq_then.22762
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
	j	beq_cont.22763
beq_then.22762:
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
beq_cont.22763:
	lw	r1, 26(r3)
	addi	r6, r1, -2
	lw	r1, 4(r3)
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
trace_diffuse_ray_80percent.3182.7149:
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
	beqi	0, r1, beq_then.22764
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
	j	beq_cont.22765
beq_then.22764:
beq_cont.22765:
	lw	r1, 7(r3)
	beqi	1, r1, beq_then.22766
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
	j	beq_cont.22767
beq_then.22766:
beq_cont.22767:
	lw	r1, 7(r3)
	beqi	2, r1, beq_then.22768
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
	j	beq_cont.22769
beq_then.22768:
beq_cont.22769:
	lw	r1, 7(r3)
	beqi	3, r1, beq_then.22770
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
	j	beq_cont.22771
beq_then.22770:
beq_cont.22771:
	lw	r1, 7(r3)
	beqi	4, r1, beq_then.22772
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
beq_then.22772:
	jr	r31				#
calc_diffuse_using_1point.3186.7153:
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
	beqi	0, r1, beq_then.22774
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
	beq	r0, r30, fle_else.22776
	addi	r2, r0, 0
	j	fle_cont.22777
fle_else.22776:
	addi	r2, r0, 1
fle_cont.22777:
	beqi	0, r2, beq_then.22778
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
	j	beq_cont.22779
beq_then.22778:
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
beq_cont.22779:
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
	j	beq_cont.22775
beq_then.22774:
beq_cont.22775:
	lw	r1, 12(r3)
	beqi	1, r1, beq_then.22780
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
	beq	r0, r30, fle_else.22782
	addi	r2, r0, 0
	j	fle_cont.22783
fle_else.22782:
	addi	r2, r0, 1
fle_cont.22783:
	beqi	0, r2, beq_then.22784
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
	j	beq_cont.22785
beq_then.22784:
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
beq_cont.22785:
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
	j	beq_cont.22781
beq_then.22780:
beq_cont.22781:
	lw	r1, 12(r3)
	beqi	2, r1, beq_then.22786
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
	beq	r0, r30, fle_else.22788
	addi	r2, r0, 0
	j	fle_cont.22789
fle_else.22788:
	addi	r2, r0, 1
fle_cont.22789:
	beqi	0, r2, beq_then.22790
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
	j	beq_cont.22791
beq_then.22790:
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
beq_cont.22791:
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
	j	beq_cont.22787
beq_then.22786:
beq_cont.22787:
	lw	r1, 12(r3)
	beqi	3, r1, beq_then.22792
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
	beq	r0, r30, fle_else.22794
	addi	r2, r0, 0
	j	fle_cont.22795
fle_else.22794:
	addi	r2, r0, 1
fle_cont.22795:
	beqi	0, r2, beq_then.22796
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
	j	beq_cont.22797
beq_then.22796:
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
beq_cont.22797:
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
	j	beq_cont.22793
beq_then.22792:
beq_cont.22793:
	lw	r1, 12(r3)
	beqi	4, r1, beq_then.22798
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
	beq	r0, r30, fle_else.22800
	addi	r2, r0, 0
	j	fle_cont.22801
fle_else.22800:
	addi	r2, r0, 1
fle_cont.22801:
	beqi	0, r2, beq_then.22802
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
	j	beq_cont.22803
beq_then.22802:
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
beq_cont.22803:
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
	j	beq_cont.22799
beq_then.22798:
beq_cont.22799:
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r1, 1(r3)
	lw	r5, 0(r3)
	j	vecaccumv.2879.6846
calc_diffuse_using_5points.3189.7156:
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
	j	vecaccumv.2879.6846
do_without_neighbors.3195.7162:
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	blei	4, r2, ble_then.22804
	jr	r31				#
ble_then.22804:
	lw	r9, 2(r1)
	addi	r10, r0, 0
	add	r30, r9, r2
	lw	r9, 0(r30)
	ble	r10, r9, ble_then.22806
	jr	r31				#
ble_then.22806:
	lw	r9, 3(r1)
	add	r30, r9, r2
	lw	r9, 0(r30)
	sw	r29, 0(r3)
	sw	r8, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	beqi	0, r9, beq_then.22808
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
	jal	vecaccumv.2879.6846				#	bl	vecaccumv.2879.6846
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.22809
beq_then.22808:
beq_cont.22809:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	blei	4, r2, ble_then.22810
	jr	r31				#
ble_then.22810:
	lw	r1, 2(r3)
	lw	r5, 2(r1)
	addi	r6, r0, 0
	add	r30, r5, r2
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.22812
	jr	r31				#
ble_then.22812:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 7(r3)
	beqi	0, r5, beq_then.22814
	lw	r29, 1(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.22815
beq_then.22814:
beq_cont.22815:
	lw	r1, 7(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
try_exploit_neighbors.3211.7178:
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	add	r30, r6, r1
	lw	r12, 0(r30)
	blei	4, r8, ble_then.22816
	jr	r31				#
ble_then.22816:
	addi	r13, r0, 0
	lw	r14, 2(r12)
	add	r30, r14, r8
	lw	r14, 0(r30)
	ble	r13, r14, ble_then.22818
	jr	r31				#
ble_then.22818:
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
	beq	r14, r13, beq_then.22820
	addi	r13, r0, 0
	j	beq_cont.22821
beq_then.22820:
	add	r30, r7, r1
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.22822
	addi	r13, r0, 0
	j	beq_cont.22823
beq_then.22822:
	addi	r14, r1, -1
	add	r30, r6, r14
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.22824
	addi	r13, r0, 0
	j	beq_cont.22825
beq_then.22824:
	addi	r14, r1, 1
	add	r30, r6, r14
	lw	r14, 0(r30)
	lw	r14, 2(r14)
	add	r30, r14, r8
	lw	r14, 0(r30)
	beq	r14, r13, beq_then.22826
	addi	r13, r0, 0
	j	beq_cont.22827
beq_then.22826:
	addi	r13, r0, 1
beq_cont.22827:
beq_cont.22825:
beq_cont.22823:
beq_cont.22821:
	beqi	0, r13, beq_then.22828
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
	beqi	0, r11, beq_then.22829
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
	j	beq_cont.22830
beq_then.22829:
beq_cont.22830:
	lw	r1, 8(r3)
	addi	r2, r1, 1
	lw	r1, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r1
	lw	r6, 0(r30)
	blei	4, r2, ble_then.22831
	jr	r31				#
ble_then.22831:
	addi	r7, r0, 0
	lw	r8, 2(r6)
	add	r30, r8, r2
	lw	r8, 0(r30)
	ble	r7, r8, ble_then.22833
	jr	r31				#
ble_then.22833:
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
	beq	r9, r7, beq_then.22835
	addi	r7, r0, 0
	j	beq_cont.22836
beq_then.22835:
	lw	r9, 4(r3)
	add	r30, r9, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.22837
	addi	r7, r0, 0
	j	beq_cont.22838
beq_then.22837:
	addi	r10, r1, -1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.22839
	addi	r7, r0, 0
	j	beq_cont.22840
beq_then.22839:
	addi	r10, r1, 1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.22841
	addi	r7, r0, 0
	j	beq_cont.22842
beq_then.22841:
	addi	r7, r0, 1
beq_cont.22842:
beq_cont.22840:
beq_cont.22838:
beq_cont.22836:
	beqi	0, r7, beq_then.22843
	lw	r6, 3(r6)
	add	r30, r6, r2
	lw	r6, 0(r30)
	sw	r2, 9(r3)
	beqi	0, r6, beq_then.22844
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
	j	beq_cont.22845
beq_then.22844:
beq_cont.22845:
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
beq_then.22843:
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r29, 3(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.22828:
	add	r30, r6, r1
	lw	r1, 0(r30)
	blei	4, r8, ble_then.22846
	jr	r31				#
ble_then.22846:
	lw	r2, 2(r1)
	addi	r5, r0, 0
	add	r30, r2, r8
	lw	r2, 0(r30)
	ble	r5, r2, ble_then.22848
	jr	r31				#
ble_then.22848:
	lw	r2, 3(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	sw	r1, 10(r3)
	sw	r9, 3(r3)
	sw	r8, 8(r3)
	beqi	0, r2, beq_then.22850
	add	r2, r0, r8				# mr	r2, r8
	add	r29, r0, r11				# mr	r29, r11
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.22851
beq_then.22850:
beq_cont.22851:
	lw	r1, 8(r3)
	addi	r2, r1, 1
	lw	r1, 10(r3)
	lw	r29, 3(r3)
	lw	r28, 0(r29)
	jr	r28
write_rgb.3222.7189:
	lw	r1, 1(r29)
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22852
	addi	r2, r0, 0
	j	feq_cont.22853
feq_else.22852:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22854
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.22855
fle_else.22854:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.22855:
feq_cont.22853:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.22856
	addi	r5, r0, 255
	j	ble_cont.22857
ble_then.22856:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.22858
	addi	r5, r0, 0
	j	ble_cont.22859
ble_then.22858:
	add	r5, r0, r2
ble_cont.22859:
ble_cont.22857:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	ble	r2, r5, ble_then.22860
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.22862
	addi	r2, r5, 48
	out	r2
	j	ble_cont.22863
ble_then.22862:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 1(r3)
	ble	r7, r5, ble_then.22864
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.22865
ble_then.22864:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.22866
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.22867
ble_then.22866:
	add	r1, r0, r6
ble_cont.22867:
ble_cont.22865:
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
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
ble_cont.22863:
	j	ble_cont.22861
ble_then.22860:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.22868
	addi	r2, r5, 48
	out	r2
	j	ble_cont.22869
ble_then.22868:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 3(r3)
	ble	r7, r5, ble_then.22870
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.22871
ble_then.22870:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.22872
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.22873
ble_then.22872:
	add	r1, r0, r6
ble_cont.22873:
ble_cont.22871:
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
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
ble_cont.22869:
ble_cont.22861:
	addi	r1, r0, 32
	out	r1
	lw	r1, 0(r3)
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22874
	addi	r2, r0, 0
	j	feq_cont.22875
feq_else.22874:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22876
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.22877
fle_else.22876:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.22877:
feq_cont.22875:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.22878
	addi	r5, r0, 255
	j	ble_cont.22879
ble_then.22878:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.22880
	addi	r5, r0, 0
	j	ble_cont.22881
ble_then.22880:
	add	r5, r0, r2
ble_cont.22881:
ble_cont.22879:
	addi	r2, r0, 0
	ble	r2, r5, ble_then.22882
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.22884
	addi	r2, r5, 48
	out	r2
	j	ble_cont.22885
ble_then.22884:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 5(r3)
	ble	r7, r5, ble_then.22886
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	ble_cont.22887
ble_then.22886:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.22888
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	ble_cont.22889
ble_then.22888:
	add	r1, r0, r6
ble_cont.22889:
ble_cont.22887:
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
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
ble_cont.22885:
	j	ble_cont.22883
ble_then.22882:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.22890
	addi	r2, r5, 48
	out	r2
	j	ble_cont.22891
ble_then.22890:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 7(r3)
	ble	r7, r5, ble_then.22892
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	ble_cont.22893
ble_then.22892:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.22894
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	ble_cont.22895
ble_then.22894:
	add	r1, r0, r6
ble_cont.22895:
ble_cont.22893:
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
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
ble_cont.22891:
ble_cont.22883:
	addi	r1, r0, 32
	out	r1
	lw	r1, 0(r3)
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22896
	addi	r1, r0, 0
	j	feq_cont.22897
feq_else.22896:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22898
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.22899
fle_else.22898:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.22899:
feq_cont.22897:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.22900
	addi	r1, r0, 255
	j	ble_cont.22901
ble_then.22900:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.22902
	addi	r1, r0, 0
	j	ble_cont.22903
ble_then.22902:
ble_cont.22903:
ble_cont.22901:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.22904
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	addi	r2, r0, 10
	ble	r2, r1, ble_then.22906
	addi	r1, r1, 48
	out	r1
	j	ble_cont.22907
ble_then.22906:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	sw	r1, 9(r3)
	ble	r6, r1, ble_then.22908
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	ble_cont.22909
ble_then.22908:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.22910
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	ble_cont.22911
ble_then.22910:
	add	r1, r0, r5
ble_cont.22911:
ble_cont.22909:
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
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
ble_cont.22907:
	j	ble_cont.22905
ble_then.22904:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.22912
	addi	r1, r1, 48
	out	r1
	j	ble_cont.22913
ble_then.22912:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	sw	r1, 11(r3)
	ble	r6, r1, ble_then.22914
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.22915
ble_then.22914:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.22916
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.22917
ble_then.22916:
	add	r1, r0, r5
ble_cont.22917:
ble_cont.22915:
	sw	r1, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
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
ble_cont.22913:
ble_cont.22905:
	addi	r1, r0, 10
	out	r1
	jr	r31				#
pretrace_diffuse_rays.3224.7191:
	lw	r5, 7(r29)
	lw	r6, 6(r29)
	lw	r7, 5(r29)
	lw	r8, 4(r29)
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	blei	4, r2, ble_then.22918
	jr	r31				#
ble_then.22918:
	lw	r12, 2(r1)
	add	r30, r12, r2
	lw	r12, 0(r30)
	addi	r13, r0, 0
	ble	r13, r12, ble_then.22920
	jr	r31				#
ble_then.22920:
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
	beqi	0, r12, beq_then.22922
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
	j	beq_cont.22923
beq_then.22922:
beq_cont.22923:
	lw	r2, 8(r3)
	addi	r2, r2, 1
	blei	4, r2, ble_then.22924
	jr	r31				#
ble_then.22924:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 0
	ble	r6, r5, ble_then.22926
	jr	r31				#
ble_then.22926:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 13(r3)
	beqi	0, r5, beq_then.22928
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
	beq	r0, r30, fle_else.22930
	addi	r2, r0, 0
	j	fle_cont.22931
fle_else.22930:
	addi	r2, r0, 1
fle_cont.22931:
	beqi	0, r2, beq_then.22932
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
	j	beq_cont.22933
beq_then.22932:
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
beq_cont.22933:
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
	j	beq_cont.22929
beq_then.22928:
beq_cont.22929:
	lw	r2, 13(r3)
	addi	r2, r2, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_pixels.3227.7194:
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
	ble	r23, r2, ble_then.22934
	jr	r31				#
ble_then.22934:
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
	jal	vecunit_sgn.2855.6822				#	bl	vecunit_sgn.2855.6822
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
	ble	r8, r7, ble_then.22936
	j	ble_cont.22937
ble_then.22936:
	lw	r7, 3(r5)
	lw	r7, 0(r7)
	sw	r5, 23(r3)
	beqi	0, r7, beq_then.22938
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
	beq	r0, r30, fle_else.22940
	addi	r2, r0, 0
	j	fle_cont.22941
fle_else.22940:
	addi	r2, r0, 1
fle_cont.22941:
	beqi	0, r2, beq_then.22942
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
	j	beq_cont.22943
beq_then.22942:
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
beq_cont.22943:
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
	j	beq_cont.22939
beq_then.22938:
beq_cont.22939:
	addi	r2, r0, 1
	lw	r1, 23(r3)
	lw	r29, 7(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
ble_cont.22937:
	lw	r1, 18(r3)
	addi	r2, r1, -1
	lw	r1, 15(r3)
	addi	r1, r1, 1
	addi	r5, r0, 5
	ble	r5, r1, ble_then.22944
	add	r5, r0, r1
	j	ble_cont.22945
ble_then.22944:
	addi	r5, r1, -5
ble_cont.22945:
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r1, 19(r3)
	lw	r29, 6(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_line.3234.7201:
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
scan_pixel.3238.7205:
	lw	r8, 7(r29)
	lw	r9, 6(r29)
	lw	r10, 5(r29)
	lw	r11, 4(r29)
	lw	r12, 3(r29)
	lw	r13, 2(r29)
	lw	r14, 1(r29)
	lw	r15, 0(r11)
	ble	r15, r1, ble_then.22946
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
	ble	r15, r16, ble_then.22947
	blei	0, r2, ble_then.22949
	lw	r15, 0(r11)
	addi	r16, r1, 1
	ble	r15, r16, ble_then.22951
	blei	0, r1, ble_then.22953
	addi	r15, r0, 1
	j	ble_cont.22954
ble_then.22953:
	addi	r15, r0, 0
ble_cont.22954:
	j	ble_cont.22952
ble_then.22951:
	addi	r15, r0, 0
ble_cont.22952:
	j	ble_cont.22950
ble_then.22949:
	addi	r15, r0, 0
ble_cont.22950:
	j	ble_cont.22948
ble_then.22947:
	addi	r15, r0, 0
ble_cont.22948:
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
	beqi	0, r15, beq_then.22955
	addi	r14, r0, 0
	add	r30, r6, r1
	lw	r15, 0(r30)
	addi	r16, r0, 0
	lw	r17, 2(r15)
	lw	r17, 0(r17)
	ble	r16, r17, ble_then.22957
	j	ble_cont.22958
ble_then.22957:
	add	r30, r6, r1
	lw	r16, 0(r30)
	lw	r16, 2(r16)
	lw	r16, 0(r16)
	add	r30, r5, r1
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.22959
	addi	r16, r0, 0
	j	beq_cont.22960
beq_then.22959:
	add	r30, r7, r1
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.22961
	addi	r16, r0, 0
	j	beq_cont.22962
beq_then.22961:
	addi	r17, r1, -1
	add	r30, r6, r17
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.22963
	addi	r16, r0, 0
	j	beq_cont.22964
beq_then.22963:
	addi	r17, r1, 1
	add	r30, r6, r17
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	lw	r17, 0(r17)
	beq	r17, r16, beq_then.22965
	addi	r16, r0, 0
	j	beq_cont.22966
beq_then.22965:
	addi	r16, r0, 1
beq_cont.22966:
beq_cont.22964:
beq_cont.22962:
beq_cont.22960:
	beqi	0, r16, beq_then.22967
	lw	r15, 3(r15)
	lw	r15, 0(r15)
	beqi	0, r15, beq_then.22969
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
	j	beq_cont.22970
beq_then.22969:
beq_cont.22970:
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
	j	beq_cont.22968
beq_then.22967:
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
beq_cont.22968:
ble_cont.22958:
	j	beq_cont.22956
beq_then.22955:
	add	r30, r6, r1
	lw	r13, 0(r30)
	addi	r15, r0, 0
	lw	r16, 2(r13)
	addi	r17, r0, 0
	lw	r16, 0(r16)
	ble	r17, r16, ble_then.22971
	j	ble_cont.22972
ble_then.22971:
	lw	r16, 3(r13)
	lw	r16, 0(r16)
	sw	r13, 11(r3)
	beqi	0, r16, beq_then.22973
	add	r2, r0, r15				# mr	r2, r15
	add	r1, r0, r13				# mr	r1, r13
	add	r29, r0, r14				# mr	r29, r14
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.22974
beq_then.22973:
beq_cont.22974:
	addi	r2, r0, 1
	lw	r1, 11(r3)
	lw	r29, 5(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.22972:
beq_cont.22956:
	lw	r1, 10(r3)
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22975
	addi	r2, r0, 0
	j	feq_cont.22976
feq_else.22975:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22977
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.22978
fle_else.22977:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.22978:
feq_cont.22976:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.22979
	addi	r2, r0, 255
	j	ble_cont.22980
ble_then.22979:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.22981
	addi	r2, r0, 0
	j	ble_cont.22982
ble_then.22981:
ble_cont.22982:
ble_cont.22980:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.22983
	addi	r5, r0, 45
	out	r5
	sub	r2, r0, r2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.22984
ble_then.22983:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.22984:
	addi	r1, r0, 32
	out	r1
	lw	r1, 10(r3)
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22985
	addi	r2, r0, 0
	j	feq_cont.22986
feq_else.22985:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22987
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.22988
fle_else.22987:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.22988:
feq_cont.22986:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.22989
	addi	r2, r0, 255
	j	ble_cont.22990
ble_then.22989:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.22991
	addi	r2, r0, 0
	j	ble_cont.22992
ble_then.22991:
ble_cont.22992:
ble_cont.22990:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.22993
	addi	r5, r0, 45
	out	r5
	sub	r2, r0, r2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.22994
ble_then.22993:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.22994:
	addi	r1, r0, 32
	out	r1
	lw	r1, 10(r3)
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.22995
	addi	r2, r0, 0
	j	feq_cont.22996
feq_else.22995:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.22997
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r2, f1
	j	fle_cont.22998
fle_else.22997:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r2, f1
fle_cont.22998:
feq_cont.22996:
	addi	r5, r0, 255
	ble	r2, r5, ble_then.22999
	addi	r2, r0, 255
	j	ble_cont.23000
ble_then.22999:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.23001
	addi	r2, r0, 0
	j	ble_cont.23002
ble_then.23001:
ble_cont.23002:
ble_cont.23000:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.23003
	addi	r5, r0, 45
	out	r5
	sub	r2, r0, r2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.23004
ble_then.23003:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
	addi	r3, r3, -13
	lw	r31, 12(r3)
ble_cont.23004:
	addi	r1, r0, 10
	out	r1
	lw	r1, 9(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 0(r2)
	ble	r5, r1, ble_then.23005
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
	ble	r5, r8, ble_then.23006
	blei	0, r7, ble_then.23008
	lw	r2, 0(r2)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.23010
	blei	0, r1, ble_then.23012
	addi	r2, r0, 1
	j	ble_cont.23013
ble_then.23012:
	addi	r2, r0, 0
ble_cont.23013:
	j	ble_cont.23011
ble_then.23010:
	addi	r2, r0, 0
ble_cont.23011:
	j	ble_cont.23009
ble_then.23008:
	addi	r2, r0, 0
ble_cont.23009:
	j	ble_cont.23007
ble_then.23006:
	addi	r2, r0, 0
ble_cont.23007:
	sw	r1, 12(r3)
	beqi	0, r2, beq_then.23014
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
	j	beq_cont.23015
beq_then.23014:
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
beq_cont.23015:
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
ble_then.23005:
	jr	r31				#
ble_then.22946:
	jr	r31				#
scan_line.3244.7211:
	lw	r8, 7(r29)
	lw	r9, 6(r29)
	lw	r10, 5(r29)
	lw	r11, 4(r29)
	lw	r12, 3(r29)
	lw	r13, 2(r29)
	lw	r14, 1(r29)
	lw	r15, 1(r13)
	ble	r15, r1, ble_then.23018
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
	ble	r15, r1, ble_then.23019
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
	j	ble_cont.23020
ble_then.23019:
ble_cont.23020:
	addi	r1, r0, 0
	lw	r2, 12(r3)
	lw	r5, 0(r2)
	blei	0, r5, ble_then.23021
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
	ble	r5, r8, ble_then.23023
	blei	0, r7, ble_then.23025
	lw	r5, 0(r2)
	blei	1, r5, ble_then.23027
	addi	r5, r0, 0
	j	ble_cont.23028
ble_then.23027:
	addi	r5, r0, 0
ble_cont.23028:
	j	ble_cont.23026
ble_then.23025:
	addi	r5, r0, 0
ble_cont.23026:
	j	ble_cont.23024
ble_then.23023:
	addi	r5, r0, 0
ble_cont.23024:
	beqi	0, r5, beq_then.23029
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
	j	beq_cont.23030
beq_then.23029:
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
beq_cont.23030:
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
	j	ble_cont.23022
ble_then.23021:
ble_cont.23022:
	lw	r1, 9(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	addi	r1, r1, 2
	addi	r5, r0, 5
	ble	r5, r1, ble_then.23031
	add	r5, r0, r1
	j	ble_cont.23032
ble_then.23031:
	addi	r5, r1, -5
ble_cont.23032:
	lw	r1, 12(r3)
	lw	r6, 1(r1)
	ble	r6, r2, ble_then.23033
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r5, 13(r3)
	sw	r2, 14(r3)
	ble	r1, r2, ble_then.23035
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
	j	ble_cont.23036
ble_then.23035:
ble_cont.23036:
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
	ble	r5, r2, ble_then.23037
	add	r7, r0, r2
	j	ble_cont.23038
ble_then.23037:
	addi	r7, r2, -5
ble_cont.23038:
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
	j	ble_cont.23034
ble_then.23033:
ble_cont.23034:
	jr	r31				#
ble_then.23018:
	jr	r31				#
create_float5x3array.3250.7217:
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
init_line_elements.3254.7221:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.23041
	jr	r31				#
ble_then.23041:
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
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
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
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
	addi	r3, r3, -9
	lw	r31, 8(r3)
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
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
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
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
	ble	r2, r1, ble_then.23042
	add	r1, r0, r5
	jr	r31				#
ble_then.23042:
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
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
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
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
	addi	r3, r3, -17
	lw	r31, 16(r3)
	sw	r1, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
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
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
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
calc_dirvec.3264.7231:
	lw	r6, 1(r29)
	addi	r7, r0, 5
	ble	r7, r1, ble_then.23043
	fmul	f1, f2, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f1, f1, f2
	fsqrt	f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f2, f2, f1
	fle	r30, f0, f2
	beq	r0, r30, fle_else.23044
	flup	f5, 2		# fli	f5, 1.000000
	j	fle_cont.23045
fle_else.23044:
	flup	f5, 11		# fli	f5, -1.000000
fle_cont.23045:
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
	beq	r0, r30, fle_else.23048
	flup	f6, 24		# fli	f6, 2.437500
	fle	r30, f6, f2
	beq	r0, r30, fle_else.23050
	flup	f6, 15		# fli	f6, 1.570796
	flup	f7, 2		# fli	f7, 1.000000
	fdiv	f2, f7, f2
	fsw	f5, 12(r3)
	fsw	f6, 14(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2743.6710				#	bl	atan_body.2743.6710
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	flw	f2, 12(r3)
	fmul	f1, f1, f2
	j	fle_cont.23051
fle_else.23050:
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
	jal	atan_body.2743.6710				#	bl	atan_body.2743.6710
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fadd	f1, f2, f1
	flw	f2, 12(r3)
	fmul	f1, f1, f2
fle_cont.23051:
	j	fle_cont.23049
fle_else.23048:
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2743.6710				#	bl	atan_body.2743.6710
	addi	r3, r3, -19
	lw	r31, 18(r3)
fle_cont.23049:
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	fsw	f1, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	sin.2739.6706				#	bl	sin.2739.6706
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 18(r3)
	fsw	f1, 20(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	cos.2741.6708				#	bl	cos.2741.6708
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
	beq	r0, r30, fle_else.23052
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.23053
fle_else.23052:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.23053:
	fmul	f3, f3, f4
	flup	f5, 23		# fli	f5, 4.375000
	fsw	f1, 22(r3)
	sw	r1, 24(r3)
	fsw	f2, 26(r3)
	fle	r30, f5, f3
	beq	r0, r30, fle_else.23055
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f3
	beq	r0, r30, fle_else.23057
	flup	f5, 15		# fli	f5, 1.570796
	flup	f6, 2		# fli	f6, 1.000000
	fdiv	f3, f6, f3
	fsw	f4, 28(r3)
	fsw	f5, 30(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	atan_body.2743.6710				#	bl	atan_body.2743.6710
	addi	r3, r3, -33
	lw	r31, 32(r3)
	flw	f2, 30(r3)
	fadd	f1, f2, f1
	flw	f2, 28(r3)
	fmul	f1, f1, f2
	j	fle_cont.23058
fle_else.23057:
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
	jal	atan_body.2743.6710				#	bl	atan_body.2743.6710
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flw	f2, 32(r3)
	fadd	f1, f2, f1
	flw	f2, 28(r3)
	fmul	f1, f1, f2
fle_cont.23058:
	j	fle_cont.23056
fle_else.23055:
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	atan_body.2743.6710				#	bl	atan_body.2743.6710
	addi	r3, r3, -35
	lw	r31, 34(r3)
fle_cont.23056:
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	fsw	f1, 34(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	sin.2739.6706				#	bl	sin.2739.6706
	addi	r3, r3, -37
	lw	r31, 36(r3)
	flw	f2, 34(r3)
	fsw	f1, 36(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 38(r3)
	addi	r3, r3, 39
	jal	cos.2741.6708				#	bl	cos.2741.6708
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
ble_then.23043:
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
calc_dirvecs.3272.7239:
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.23060
	jr	r31				#
ble_then.23060:
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
	ble	r5, r2, ble_then.23063
	j	ble_cont.23064
ble_then.23063:
	addi	r2, r2, -5
ble_cont.23064:
	flw	f1, 2(r3)
	lw	r5, 6(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
calc_dirvec_rows.3277.7244:
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.23065
	jr	r31				#
ble_then.23065:
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
	ble	r5, r2, ble_then.23067
	j	ble_cont.23068
ble_then.23067:
	addi	r2, r2, -5
ble_cont.23068:
	lw	r5, 2(r3)
	addi	r5, r5, 4
	addi	r6, r0, 0
	ble	r6, r1, ble_then.23069
	jr	r31				#
ble_then.23069:
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
	ble	r5, r2, ble_then.23071
	j	ble_cont.23072
ble_then.23071:
	addi	r2, r2, -5
ble_cont.23072:
	lw	r5, 5(r3)
	addi	r5, r5, 4
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
create_dirvec_elements.3283.7250:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.23073
	jr	r31				#
ble_then.23073:
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
	ble	r2, r1, ble_then.23075
	jr	r31				#
ble_then.23075:
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
	ble	r2, r1, ble_then.23077
	jr	r31				#
ble_then.23077:
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
	ble	r2, r1, ble_then.23079
	jr	r31				#
ble_then.23079:
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
create_dirvecs.3286.7253:
	lw	r2, 3(r29)
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.23081
	jr	r31				#
ble_then.23081:
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
	ble	r2, r1, ble_then.23083
	jr	r31				#
ble_then.23083:
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
init_dirvec_constants.3288.7255:
	lw	r5, 3(r29)
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	addi	r8, r0, 0
	ble	r8, r2, ble_then.23085
	jr	r31				#
ble_then.23085:
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
	ble	r2, r1, ble_then.23087
	jr	r31				#
ble_then.23087:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	lw	r7, 0(r6)
	addi	r7, r7, -1
	addi	r8, r0, 0
	sw	r1, 6(r3)
	ble	r8, r7, ble_then.23089
	j	ble_cont.23090
ble_then.23089:
	lw	r8, 2(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r5)
	lw	r11, 0(r5)
	lw	r12, 1(r9)
	sw	r5, 7(r3)
	beqi	1, r12, beq_then.23091
	beqi	2, r12, beq_then.23093
	sw	r7, 8(r3)
	sw	r10, 9(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_second_table.3067.7034				#	bl	setup_second_table.3067.7034
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.23094
beq_then.23093:
	sw	r7, 8(r3)
	sw	r10, 9(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_surface_table.3064.7031				#	bl	setup_surface_table.3064.7031
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23094:
	j	beq_cont.23092
beq_then.23091:
	sw	r7, 8(r3)
	sw	r10, 9(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_rect_table.3061.7028				#	bl	setup_rect_table.3061.7028
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23092:
	addi	r2, r2, -1
	lw	r1, 7(r3)
	lw	r29, 1(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
ble_cont.23090:
	lw	r1, 6(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.23095
	jr	r31				#
ble_then.23095:
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
	ble	r2, r1, ble_then.23097
	jr	r31				#
ble_then.23097:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r1, 11(r3)
	ble	r7, r6, ble_then.23099
	j	ble_cont.23100
ble_then.23099:
	lw	r7, 2(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 12(r3)
	beqi	1, r10, beq_then.23101
	beqi	2, r10, beq_then.23103
	sw	r6, 13(r3)
	sw	r8, 14(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	setup_second_table.3067.7034				#	bl	setup_second_table.3067.7034
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.23104
beq_then.23103:
	sw	r6, 13(r3)
	sw	r8, 14(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	setup_surface_table.3064.7031				#	bl	setup_surface_table.3064.7031
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23104:
	j	beq_cont.23102
beq_then.23101:
	sw	r6, 13(r3)
	sw	r8, 14(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	setup_rect_table.3061.7028				#	bl	setup_rect_table.3061.7028
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23102:
	addi	r2, r2, -1
	lw	r1, 12(r3)
	lw	r29, 1(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -16
	lw	r31, 15(r3)
ble_cont.23100:
	lw	r1, 11(r3)
	addi	r2, r1, -1
	lw	r1, 4(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
init_vecset_constants.3291.7258:
	lw	r2, 5(r29)
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	addi	r9, r0, 0
	ble	r9, r1, ble_then.23105
	jr	r31				#
ble_then.23105:
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
	ble	r12, r11, ble_then.23107
	j	ble_cont.23108
ble_then.23107:
	add	r30, r2, r11
	lw	r12, 0(r30)
	lw	r13, 1(r10)
	lw	r14, 0(r10)
	lw	r15, 1(r12)
	sw	r10, 8(r3)
	beqi	1, r15, beq_then.23109
	beqi	2, r15, beq_then.23111
	sw	r11, 9(r3)
	sw	r13, 10(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r14				# mr	r1, r14
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_second_table.3067.7034				#	bl	setup_second_table.3067.7034
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.23112
beq_then.23111:
	sw	r11, 9(r3)
	sw	r13, 10(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r14				# mr	r1, r14
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_surface_table.3064.7031				#	bl	setup_surface_table.3064.7031
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23112:
	j	beq_cont.23110
beq_then.23109:
	sw	r11, 9(r3)
	sw	r13, 10(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r14				# mr	r1, r14
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_rect_table.3061.7028				#	bl	setup_rect_table.3061.7028
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23110:
	addi	r2, r2, -1
	lw	r1, 8(r3)
	lw	r29, 5(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
ble_cont.23108:
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
	ble	r7, r6, ble_then.23113
	j	ble_cont.23114
ble_then.23113:
	lw	r7, 4(r3)
	add	r30, r7, r6
	lw	r8, 0(r30)
	lw	r9, 1(r2)
	lw	r10, 0(r2)
	lw	r11, 1(r8)
	sw	r2, 11(r3)
	beqi	1, r11, beq_then.23115
	beqi	2, r11, beq_then.23117
	sw	r6, 12(r3)
	sw	r9, 13(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_second_table.3067.7034				#	bl	setup_second_table.3067.7034
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.23118
beq_then.23117:
	sw	r6, 12(r3)
	sw	r9, 13(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_surface_table.3064.7031				#	bl	setup_surface_table.3064.7031
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23118:
	j	beq_cont.23116
beq_then.23115:
	sw	r6, 12(r3)
	sw	r9, 13(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_rect_table.3061.7028				#	bl	setup_rect_table.3061.7028
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23116:
	addi	r2, r2, -1
	lw	r1, 11(r3)
	lw	r29, 5(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
ble_cont.23114:
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
	ble	r2, r1, ble_then.23119
	jr	r31				#
ble_then.23119:
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
	ble	r7, r6, ble_then.23121
	j	ble_cont.23122
ble_then.23121:
	lw	r7, 4(r3)
	add	r30, r7, r6
	lw	r8, 0(r30)
	lw	r9, 1(r2)
	lw	r10, 0(r2)
	lw	r11, 1(r8)
	sw	r2, 16(r3)
	beqi	1, r11, beq_then.23123
	beqi	2, r11, beq_then.23125
	sw	r6, 17(r3)
	sw	r9, 18(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_second_table.3067.7034				#	bl	setup_second_table.3067.7034
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.23126
beq_then.23125:
	sw	r6, 17(r3)
	sw	r9, 18(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_surface_table.3064.7031				#	bl	setup_surface_table.3064.7031
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23126:
	j	beq_cont.23124
beq_then.23123:
	sw	r6, 17(r3)
	sw	r9, 18(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_rect_table.3061.7028				#	bl	setup_rect_table.3061.7028
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23124:
	addi	r2, r2, -1
	lw	r1, 16(r3)
	lw	r29, 5(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
ble_cont.23122:
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
	ble	r2, r1, ble_then.23127
	jr	r31				#
ble_then.23127:
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
	ble	r8, r7, ble_then.23129
	j	ble_cont.23130
ble_then.23129:
	lw	r8, 4(r3)
	add	r30, r8, r7
	lw	r8, 0(r30)
	lw	r9, 1(r6)
	lw	r10, 0(r6)
	lw	r11, 1(r8)
	sw	r6, 21(r3)
	beqi	1, r11, beq_then.23131
	beqi	2, r11, beq_then.23133
	sw	r7, 22(r3)
	sw	r9, 23(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	setup_second_table.3067.7034				#	bl	setup_second_table.3067.7034
	addi	r3, r3, -25
	lw	r31, 24(r3)
	lw	r2, 22(r3)
	lw	r5, 23(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.23134
beq_then.23133:
	sw	r7, 22(r3)
	sw	r9, 23(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	setup_surface_table.3064.7031				#	bl	setup_surface_table.3064.7031
	addi	r3, r3, -25
	lw	r31, 24(r3)
	lw	r2, 22(r3)
	lw	r5, 23(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23134:
	j	beq_cont.23132
beq_then.23131:
	sw	r7, 22(r3)
	sw	r9, 23(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	setup_rect_table.3061.7028				#	bl	setup_rect_table.3061.7028
	addi	r3, r3, -25
	lw	r31, 24(r3)
	lw	r2, 22(r3)
	lw	r5, 23(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23132:
	addi	r2, r2, -1
	lw	r1, 21(r3)
	lw	r29, 5(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -25
	lw	r31, 24(r3)
ble_cont.23130:
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
	ble	r2, r1, ble_then.23135
	jr	r31				#
ble_then.23135:
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
setup_rect_reflection.3302.7269:
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
	ble	r8, r7, ble_then.23139
	j	ble_cont.23140
ble_then.23139:
	lw	r8, 13(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r9)
	beqi	1, r10, beq_then.23141
	beqi	2, r10, beq_then.23143
	sw	r7, 23(r3)
	sw	r1, 24(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_second_table.3067.7034				#	bl	setup_second_table.3067.7034
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 24(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.23144
beq_then.23143:
	sw	r7, 23(r3)
	sw	r1, 24(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_surface_table.3064.7031				#	bl	setup_surface_table.3064.7031
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 24(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23144:
	j	beq_cont.23142
beq_then.23141:
	sw	r7, 23(r3)
	sw	r1, 24(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_rect_table.3061.7028				#	bl	setup_rect_table.3061.7028
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 23(r3)
	lw	r5, 24(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23142:
	addi	r2, r2, -1
	lw	r1, 22(r3)
	lw	r29, 12(r3)
	sw	r31, 25(r3)
	addi	r3, r3, 26
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -26
	lw	r31, 25(r3)
ble_cont.23140:
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
	ble	r8, r7, ble_then.23146
	j	ble_cont.23147
ble_then.23146:
	lw	r8, 13(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r9)
	beqi	1, r10, beq_then.23148
	beqi	2, r10, beq_then.23150
	sw	r7, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_second_table.3067.7034				#	bl	setup_second_table.3067.7034
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.23151
beq_then.23150:
	sw	r7, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_surface_table.3064.7031				#	bl	setup_surface_table.3064.7031
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23151:
	j	beq_cont.23149
beq_then.23148:
	sw	r7, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_rect_table.3061.7028				#	bl	setup_rect_table.3061.7028
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23149:
	addi	r2, r2, -1
	lw	r1, 31(r3)
	lw	r29, 12(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -35
	lw	r31, 34(r3)
ble_cont.23147:
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
	ble	r7, r6, ble_then.23152
	j	ble_cont.23153
ble_then.23152:
	lw	r7, 13(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.23154
	beqi	2, r8, beq_then.23156
	sw	r6, 40(r3)
	sw	r1, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	setup_second_table.3067.7034				#	bl	setup_second_table.3067.7034
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 40(r3)
	lw	r5, 41(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.23157
beq_then.23156:
	sw	r6, 40(r3)
	sw	r1, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	setup_surface_table.3064.7031				#	bl	setup_surface_table.3064.7031
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 40(r3)
	lw	r5, 41(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23157:
	j	beq_cont.23155
beq_then.23154:
	sw	r6, 40(r3)
	sw	r1, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	setup_rect_table.3061.7028				#	bl	setup_rect_table.3061.7028
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r2, 40(r3)
	lw	r5, 41(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23155:
	addi	r2, r2, -1
	lw	r1, 39(r3)
	lw	r29, 12(r3)
	sw	r31, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -43
	lw	r31, 42(r3)
ble_cont.23153:
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
setup_surface_reflection.3305.7272:
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
	ble	r7, r6, ble_then.23159
	j	ble_cont.23160
ble_then.23159:
	lw	r7, 7(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.23161
	beqi	2, r8, beq_then.23163
	sw	r6, 17(r3)
	sw	r1, 18(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_second_table.3067.7034				#	bl	setup_second_table.3067.7034
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.23164
beq_then.23163:
	sw	r6, 17(r3)
	sw	r1, 18(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_surface_table.3064.7031				#	bl	setup_surface_table.3064.7031
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23164:
	j	beq_cont.23162
beq_then.23161:
	sw	r6, 17(r3)
	sw	r1, 18(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	setup_rect_table.3061.7028				#	bl	setup_rect_table.3061.7028
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23162:
	addi	r2, r2, -1
	lw	r1, 16(r3)
	lw	r29, 6(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
ble_cont.23160:
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
rt.3310.7277:
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
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
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
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
	addi	r3, r3, -31
	lw	r31, 30(r3)
	sw	r1, 30(r3)
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
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
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
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
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
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
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
	addi	r3, r3, -40
	lw	r31, 39(r3)
	sw	r1, 39(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
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
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
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
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
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
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
	addi	r3, r3, -49
	lw	r31, 48(r3)
	sw	r1, 48(r3)
	sw	r31, 49(r3)
	addi	r3, r3, 50
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
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
	jal	create_float5x3array.3250.7217				#	bl	create_float5x3array.3250.7217
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
	beqi	0, r1, beq_then.23166
	addi	r1, r0, 1
	lw	r29, 17(r3)
	sw	r31, 53(r3)
	addi	r3, r3, 54
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -54
	lw	r31, 53(r3)
	j	beq_cont.23167
beq_then.23166:
	lw	r1, 18(r3)
	lw	r2, 52(r3)
	sw	r2, 0(r1)
beq_cont.23167:
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
	jal	read_or_network.2971.6938				#	bl	read_or_network.2971.6938
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
	ble	r2, r5, ble_then.23168
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.23170
	addi	r2, r5, 48
	out	r2
	j	ble_cont.23171
ble_then.23170:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 53(r3)
	ble	r7, r5, ble_then.23172
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 54(r3)
	addi	r3, r3, 55
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -55
	lw	r31, 54(r3)
	j	ble_cont.23173
ble_then.23172:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.23174
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 54(r3)
	addi	r3, r3, 55
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -55
	lw	r31, 54(r3)
	j	ble_cont.23175
ble_then.23174:
	add	r1, r0, r6
ble_cont.23175:
ble_cont.23173:
	sw	r1, 54(r3)
	sw	r31, 55(r3)
	addi	r3, r3, 56
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
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
ble_cont.23171:
	j	ble_cont.23169
ble_then.23168:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.23176
	addi	r2, r5, 48
	out	r2
	j	ble_cont.23177
ble_then.23176:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 55(r3)
	ble	r7, r5, ble_then.23178
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 56(r3)
	addi	r3, r3, 57
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -57
	lw	r31, 56(r3)
	j	ble_cont.23179
ble_then.23178:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.23180
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 56(r3)
	addi	r3, r3, 57
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -57
	lw	r31, 56(r3)
	j	ble_cont.23181
ble_then.23180:
	add	r1, r0, r6
ble_cont.23181:
ble_cont.23179:
	sw	r1, 56(r3)
	sw	r31, 57(r3)
	addi	r3, r3, 58
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
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
ble_cont.23177:
ble_cont.23169:
	addi	r1, r0, 32
	out	r1
	lw	r1, 23(r3)
	lw	r5, 1(r1)
	addi	r2, r0, 0
	ble	r2, r5, ble_then.23182
	addi	r2, r0, 45
	out	r2
	sub	r5, r0, r5
	addi	r2, r0, 10
	ble	r2, r5, ble_then.23184
	addi	r2, r5, 48
	out	r2
	j	ble_cont.23185
ble_then.23184:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 57(r3)
	ble	r7, r5, ble_then.23186
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 58(r3)
	addi	r3, r3, 59
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -59
	lw	r31, 58(r3)
	j	ble_cont.23187
ble_then.23186:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.23188
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 58(r3)
	addi	r3, r3, 59
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -59
	lw	r31, 58(r3)
	j	ble_cont.23189
ble_then.23188:
	add	r1, r0, r6
ble_cont.23189:
ble_cont.23187:
	sw	r1, 58(r3)
	sw	r31, 59(r3)
	addi	r3, r3, 60
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
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
ble_cont.23185:
	j	ble_cont.23183
ble_then.23182:
	addi	r2, r0, 10
	ble	r2, r5, ble_then.23190
	addi	r2, r5, 48
	out	r2
	j	ble_cont.23191
ble_then.23190:
	addi	r2, r0, 0
	addi	r6, r5, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r5, 59(r3)
	ble	r7, r5, ble_then.23192
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 60(r3)
	addi	r3, r3, 61
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -61
	lw	r31, 60(r3)
	j	ble_cont.23193
ble_then.23192:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r5, r2, ble_then.23194
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 60(r3)
	addi	r3, r3, 61
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -61
	lw	r31, 60(r3)
	j	ble_cont.23195
ble_then.23194:
	add	r1, r0, r6
ble_cont.23195:
ble_cont.23193:
	sw	r1, 60(r3)
	sw	r31, 61(r3)
	addi	r3, r3, 62
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
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
ble_cont.23191:
ble_cont.23183:
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 255
	addi	r2, r0, 0
	addi	r5, r0, 127
	sw	r1, 61(r3)
	sw	r31, 62(r3)
	addi	r3, r3, 63
	jal	div10_sub.2751.6718				#	bl	div10_sub.2751.6718
	addi	r3, r3, -63
	lw	r31, 62(r3)
	sw	r1, 62(r3)
	sw	r31, 63(r3)
	addi	r3, r3, 64
	jal	print_uint.2771.6738				#	bl	print_uint.2771.6738
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
	ble	r8, r7, ble_then.23196
	j	ble_cont.23197
ble_then.23196:
	lw	r8, 11(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r5)
	lw	r11, 0(r5)
	lw	r12, 1(r9)
	sw	r5, 64(r3)
	beqi	1, r12, beq_then.23198
	beqi	2, r12, beq_then.23200
	sw	r7, 65(r3)
	sw	r10, 66(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 67(r3)
	addi	r3, r3, 68
	jal	setup_second_table.3067.7034				#	bl	setup_second_table.3067.7034
	addi	r3, r3, -68
	lw	r31, 67(r3)
	lw	r2, 65(r3)
	lw	r5, 66(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.23201
beq_then.23200:
	sw	r7, 65(r3)
	sw	r10, 66(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 67(r3)
	addi	r3, r3, 68
	jal	setup_surface_table.3064.7031				#	bl	setup_surface_table.3064.7031
	addi	r3, r3, -68
	lw	r31, 67(r3)
	lw	r2, 65(r3)
	lw	r5, 66(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23201:
	j	beq_cont.23199
beq_then.23198:
	sw	r7, 65(r3)
	sw	r10, 66(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r31, 67(r3)
	addi	r3, r3, 68
	jal	setup_rect_table.3061.7028				#	bl	setup_rect_table.3061.7028
	addi	r3, r3, -68
	lw	r31, 67(r3)
	lw	r2, 65(r3)
	lw	r5, 66(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.23199:
	addi	r2, r2, -1
	lw	r1, 64(r3)
	lw	r29, 10(r3)
	sw	r31, 67(r3)
	addi	r3, r3, 68
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -68
	lw	r31, 67(r3)
ble_cont.23197:
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
	ble	r2, r1, ble_then.23202
	j	ble_cont.23203
ble_then.23202:
	lw	r2, 11(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.23204
	j	beq_cont.23205
beq_then.23204:
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
	beqi	0, r1, beq_then.23206
	lw	r2, 68(r3)
	lw	r1, 1(r2)
	beqi	1, r1, beq_then.23208
	beqi	2, r1, beq_then.23210
	j	beq_cont.23211
beq_then.23210:
	lw	r1, 67(r3)
	lw	r29, 3(r3)
	sw	r31, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -70
	lw	r31, 69(r3)
beq_cont.23211:
	j	beq_cont.23209
beq_then.23208:
	lw	r1, 67(r3)
	lw	r29, 4(r3)
	sw	r31, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -70
	lw	r31, 69(r3)
beq_cont.23209:
	j	beq_cont.23207
beq_then.23206:
beq_cont.23207:
beq_cont.23205:
ble_cont.23203:
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
	blei	0, r6, ble_then.23212
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r2, 69(r3)
	blei	0, r1, ble_then.23213
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
	j	ble_cont.23214
ble_then.23213:
ble_cont.23214:
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
ble_then.23212:
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
	addi	r5, r0, read_screen_settings.2956.6923
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
	addi	r10, r0, read_light.2958.6925
	sw	r10, 0(r9)
	lw	r10, 6(r3)
	sw	r10, 2(r9)
	lw	r11, 7(r3)
	sw	r11, 1(r9)
	add	r12, r0, r4
	addi	r4, r4, 2
	addi	r13, r0, read_nth_object.2963.6930
	sw	r13, 0(r12)
	lw	r13, 3(r3)
	sw	r13, 1(r12)
	add	r14, r0, r4
	addi	r4, r4, 3
	addi	r15, r0, read_object.2965.6932
	sw	r15, 0(r14)
	sw	r12, 2(r14)
	lw	r15, 2(r3)
	sw	r15, 1(r14)
	add	r16, r0, r4
	addi	r4, r4, 2
	addi	r17, r0, read_and_network.2973.6940
	sw	r17, 0(r16)
	lw	r17, 9(r3)
	sw	r17, 1(r16)
	add	r18, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, solver_rect_surface.2977.6944
	sw	r19, 0(r18)
	lw	r19, 12(r3)
	sw	r19, 1(r18)
	add	r20, r0, r4
	addi	r4, r4, 2
	addi	r21, r0, solver_surface.2992.6959
	sw	r21, 0(r20)
	sw	r19, 1(r20)
	add	r21, r0, r4
	addi	r4, r4, 2
	addi	r22, r0, solver_second.3011.6978
	sw	r22, 0(r21)
	sw	r19, 1(r21)
	add	r22, r0, r4
	addi	r4, r4, 5
	addi	r23, r0, solver.3017.6984
	sw	r23, 0(r22)
	sw	r21, 4(r22)
	sw	r18, 3(r22)
	sw	r19, 2(r22)
	sw	r13, 1(r22)
	add	r23, r0, r4
	addi	r4, r4, 2
	addi	r24, r0, solver_rect_fast.3021.6988
	sw	r24, 0(r23)
	sw	r19, 1(r23)
	add	r24, r0, r4
	addi	r4, r4, 2
	addi	r25, r0, solver_second_fast.3034.7001
	sw	r25, 0(r24)
	sw	r19, 1(r24)
	add	r25, r0, r4
	addi	r4, r4, 2
	addi	r26, r0, solver_second_fast2.3051.7018
	sw	r26, 0(r25)
	sw	r19, 1(r25)
	add	r26, r0, r4
	addi	r4, r4, 5
	addi	r27, r0, solver_fast2.3058.7025
	sw	r27, 0(r26)
	sw	r25, 4(r26)
	sw	r23, 3(r26)
	sw	r19, 2(r26)
	sw	r13, 1(r26)
	add	r27, r0, r4
	addi	r4, r4, 2
	addi	r28, r0, iter_setup_dirvec_constants.3070.7037
	sw	r28, 0(r27)
	sw	r13, 1(r27)
	add	r28, r0, r4
	addi	r4, r4, 2
	addi	r29, r0, setup_startp_constants.3075.7042
	sw	r29, 0(r28)
	sw	r13, 1(r28)
	add	r29, r0, r4
	addi	r4, r4, 2
	sw	r16, 38(r3)
	addi	r16, r0, check_all_inside.3100.7067
	sw	r16, 0(r29)
	sw	r13, 1(r29)
	add	r16, r0, r4
	addi	r4, r4, 10
	sw	r9, 39(r3)
	addi	r9, r0, shadow_check_and_group.3106.7073
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
	addi	r27, r0, shadow_check_one_or_group.3109.7076
	sw	r27, 0(r2)
	sw	r16, 2(r2)
	sw	r17, 1(r2)
	add	r27, r0, r4
	addi	r4, r4, 11
	addi	r7, r0, shadow_check_one_or_matrix.3112.7079
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
	addi	r7, r0, solve_each_element.3115.7082
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
	addi	r6, r0, solve_one_or_network.3119.7086
	sw	r6, 0(r9)
	sw	r2, 2(r9)
	sw	r17, 1(r9)
	add	r6, r0, r4
	addi	r4, r4, 12
	addi	r8, r0, trace_or_matrix.3123.7090
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
	addi	r8, r0, solve_each_element_fast.3129.7096
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
	addi	r18, r0, solve_one_or_network_fast.3133.7100
	sw	r18, 0(r9)
	sw	r2, 2(r9)
	sw	r17, 1(r9)
	add	r18, r0, r4
	addi	r4, r4, 10
	addi	r20, r0, trace_or_matrix_fast.3137.7104
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
	addi	r21, r0, judge_intersection_fast.3141.7108
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
	addi	r17, r0, get_nvector_second.3147.7114
	sw	r17, 0(r9)
	lw	r17, 17(r3)
	sw	r17, 2(r9)
	sw	r12, 1(r9)
	add	r19, r0, r4
	addi	r4, r4, 4
	addi	r21, r0, get_nvector.3149.7116
	sw	r21, 0(r19)
	sw	r17, 3(r19)
	sw	r16, 2(r19)
	sw	r9, 1(r19)
	add	r21, r0, r4
	addi	r4, r4, 2
	addi	r22, r0, utexture.3152.7119
	sw	r22, 0(r21)
	lw	r22, 18(r3)
	sw	r22, 1(r21)
	add	r23, r0, r4
	addi	r4, r4, 11
	addi	r25, r0, trace_reflections.3159.7126
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
	addi	r26, r0, trace_ray.3164.7131
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
	addi	r23, r0, trace_diffuse_ray.3170.7137
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
	addi	r16, r0, iter_trace_diffuse_rays.3173.7140
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
	addi	r16, r0, trace_diffuse_ray_80percent.3182.7149
	sw	r16, 0(r12)
	sw	r8, 5(r12)
	sw	r28, 4(r12)
	sw	r15, 3(r12)
	sw	r9, 2(r12)
	lw	r16, 31(r3)
	sw	r16, 1(r12)
	add	r17, r0, r4
	addi	r4, r4, 9
	addi	r18, r0, calc_diffuse_using_1point.3186.7153
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
	addi	r19, r0, calc_diffuse_using_5points.3189.7156
	sw	r19, 0(r18)
	sw	r25, 2(r18)
	sw	r7, 1(r18)
	add	r19, r0, r4
	addi	r4, r4, 5
	addi	r20, r0, do_without_neighbors.3195.7162
	sw	r20, 0(r19)
	sw	r12, 4(r19)
	sw	r25, 3(r19)
	sw	r7, 2(r19)
	sw	r17, 1(r19)
	add	r12, r0, r4
	addi	r4, r4, 4
	addi	r20, r0, try_exploit_neighbors.3211.7178
	sw	r20, 0(r12)
	sw	r19, 3(r12)
	sw	r18, 2(r12)
	sw	r17, 1(r12)
	add	r20, r0, r4
	addi	r4, r4, 2
	addi	r21, r0, write_rgb.3222.7189
	sw	r21, 0(r20)
	sw	r25, 1(r20)
	add	r21, r0, r4
	addi	r4, r4, 8
	addi	r22, r0, pretrace_diffuse_rays.3224.7191
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
	addi	r23, r0, pretrace_pixels.3227.7194
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
	addi	r9, r0, pretrace_line.3234.7201
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
	addi	r14, r0, scan_pixel.3238.7205
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
	addi	r17, r0, scan_line.3244.7211
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
	addi	r17, r0, init_line_elements.3254.7221
	sw	r17, 0(r12)
	sw	r6, 1(r12)
	add	r17, r0, r4
	addi	r4, r4, 2
	addi	r18, r0, calc_dirvec.3264.7231
	sw	r18, 0(r17)
	sw	r16, 1(r17)
	add	r18, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, calc_dirvecs.3272.7239
	sw	r19, 0(r18)
	sw	r17, 1(r18)
	add	r17, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, calc_dirvec_rows.3277.7244
	sw	r19, 0(r17)
	sw	r18, 1(r17)
	add	r18, r0, r4
	addi	r4, r4, 2
	addi	r19, r0, create_dirvec_elements.3283.7250
	sw	r19, 0(r18)
	sw	r15, 1(r18)
	add	r19, r0, r4
	addi	r4, r4, 4
	addi	r20, r0, create_dirvecs.3286.7253
	sw	r20, 0(r19)
	sw	r15, 3(r19)
	sw	r16, 2(r19)
	sw	r18, 1(r19)
	add	r18, r0, r4
	addi	r4, r4, 4
	addi	r20, r0, init_dirvec_constants.3288.7255
	sw	r20, 0(r18)
	sw	r13, 3(r18)
	sw	r15, 2(r18)
	lw	r20, 43(r3)
	sw	r20, 1(r18)
	add	r21, r0, r4
	addi	r4, r4, 6
	addi	r22, r0, init_vecset_constants.3291.7258
	sw	r22, 0(r21)
	sw	r13, 5(r21)
	sw	r15, 4(r21)
	sw	r20, 3(r21)
	sw	r18, 2(r21)
	sw	r16, 1(r21)
	add	r22, r0, r4
	addi	r4, r4, 7
	addi	r23, r0, setup_rect_reflection.3302.7269
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
	addi	r25, r0, setup_surface_reflection.3305.7272
	sw	r25, 0(r24)
	sw	r23, 6(r24)
	sw	r13, 5(r24)
	sw	r1, 4(r24)
	sw	r15, 3(r24)
	sw	r10, 2(r24)
	sw	r20, 1(r24)
	add	r29, r0, r4
	addi	r4, r4, 28
	addi	r1, r0, rt.3310.7277
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
