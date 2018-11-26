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
	beq	r0, r30, _fle_else.846
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
_fle_else.846:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
lib_fisneg:
	flup	f2, 0
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.847
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
_fle_else.847:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
lib_fiszero:
	flup	f2, 0
	feq	r30, f1, f2
	beq	r0, r30, _feq_else.848
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
_feq_else.848:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
lib_xor:
	beq	r1, r2, _beq_then.849
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
_beq_then.849:
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
	beq	r0, r30, _fle_else.850
	jr	r31				#	blr
_fle_else.850:
	fneg	f1, f1
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
	beq	r0, r30, _fle_else.851
	jr	r31				#	blr
_fle_else.851:
	flup	f2, 2
	fsub	f1, f1, f2
	jr	r31				#	blr
lib_int_of_float:
	flup	f2, 0
	feq	r30, f1, f2
	beq	r0, r30, _feq_else.852
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
_feq_else.852:
	flup	f2, 0
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.853
	flup	f2, 1
	fsub	f1, f1, f2
	j	lib_ftoi
_fle_else.853:
	flup	f2, 1
	fadd	f1, f1, f2
	j	lib_ftoi
lib_float_of_int:
	j	lib_itof
lib_hoge:
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.854
	flup	f3, 3
	fmul	f2, f3, f2
	j lib_hoge
_fle_else.854:
	fadd	f1, f0, f2				# fmr	f1, f2
	jr	r31				#	blr
lib_fuga:
	flup	f4, 3
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.855
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.856
	fsub	f1, f1, f2
	flup	f4, 3
	fdiv	f2, f2, f4
	j lib_fuga
_fle_else.856:
	flup	f4, 3
	fdiv	f2, f2, f4
	j lib_fuga
_fle_else.855:
	jr	r31				#	blr
lib_modulo_2pi:
	addi	r30, r0, 4059
	lui	r30, r30, 16457	# to load float		3.141593
	fmvfr	f2, r30
	flup	f3, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16585	# to load float		6.283185
	fmvfr	f3, r30
	fmvtr	r30, f2
	sw	r30, 0(r3)				#stfd	f2, 0(r3)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f2, f0, f3				# fmr	f2, f3
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_hoge				#	bl lib_hoge
	addi	r3, r3, -5
	lw	r30, 4(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
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
	beq	r0, r30, _fle_else.857
	flup	f3, 2
	j	_fle_cont.858
_fle_else.857:
	flup	f3, 2
	flup	f3, 11
_fle_cont.858:
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
	beq	r0, r30, _fle_else.859
	fsub	f1, f1, f2
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
	fneg	f3, f3
	flup	f4, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f4, r30
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.860
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.861
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
_fle_else.861:
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
_fle_else.860:
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.862
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
_fle_else.862:
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
_fle_else.859:
	flup	f3, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f3, r30
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.863
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.864
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
_fle_else.864:
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
_fle_else.863:
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.865
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
_fle_else.865:
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
	beq	r0, r30, _fle_else.866
	fsub	f1, f1, f2
	flup	f3, 11
	flup	f4, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f4, r30
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.867
	fsub	f1, f2, f1
	flup	f2, 2
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f3, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f3, r30
	fle	r30, f1, f3
	beq	r0, r30, _fle_else.868
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
_fle_else.868:
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
_fle_else.867:
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.869
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
_fle_else.869:
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
_fle_else.866:
	flup	f3, 3
	addi	r30, r0, 4059
	lui	r30, r30, 16329	# to load float		1.570796
	fmvfr	f3, r30
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.870
	fsub	f1, f2, f1
	flup	f2, 11
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f3, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f3, r30
	fle	r30, f1, f3
	beq	r0, r30, _fle_else.871
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
_fle_else.871:
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
_fle_else.870:
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	addi	r30, r0, 4059
	lui	r30, r30, 16201	# to load float		0.785398
	fmvfr	f2, r30
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.872
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
_fle_else.872:
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
	beq	r0, r30, _fle_else.873
	flup	f2, 2
	j	_fle_cont.874
_fle_else.873:
	flup	f2, 2
	flup	f2, 11
_fle_cont.874:
	fmul	f1, f1, f2
	flup	f3, 23
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.875
	flup	f3, 24
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.876
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
_fle_else.876:
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
_fle_else.875:
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
	sw	r2, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_mul10				#	bl lib_mul10
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	ble	r1, r2, _ble_then.877
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j lib_div10_sub
_ble_then.877:
	lw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_mul10				#	bl lib_mul10
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r1, 9
	lw	r2, 3(r3)
	ble	r2, r1, _ble_then.878
	lw	r1, 2(r3)
	lw	r5, 1(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j lib_div10_sub
_ble_then.878:
	lw	r1, 2(r3)
	jr	r31				#	blr
lib_div10:
	addi	r2, r0, 0				# li	r2, 0
	add	r5, r0, r1				# mr	r5, r1
	j lib_div10_sub
lib_iter_mul10:
	beqi	r2, 0, _beq_then.879
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal lib_mul10				#	bl lib_mul10
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	addi	r2, r2, -1
	j lib_iter_mul10
_beq_then.879:
	jr	r31				#	blr
lib_iter_div10:
	beqi	r2, 0, _beq_then.880
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal lib_div10				#	bl lib_div10
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	addi	r2, r2, -1
	j lib_iter_div10
_beq_then.880:
	jr	r31				#	blr
lib_keta_sub:
	addi	r5, r0, 10				# li	r5, 10
	ble	r5, r1, _ble_then.881
	addi	r1, r2, 1
	jr	r31				#	blr
_ble_then.881:
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal lib_div10				#	bl lib_div10
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
	beqi	r2, 1, _beq_then.882
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
	ble	r1, r2, _ble_then.883
	addi	r1, r0, 0				# li	r1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal lib_print_num				#	bl lib_print_num
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	addi	r2, r1, -1
	lw	r1, 1(r3)
	j lib_print_uint_keta
_ble_then.883:
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
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal lib_print_num				#	bl lib_print_num
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
_beq_then.882:
	j lib_print_num
lib_print_uint:
	addi	r2, r0, 10				# li	r2, 10
	ble	r2, r1, _ble_then.884
	j lib_print_num
_ble_then.884:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal lib_div10				#	bl lib_div10
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
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal lib_mul10				#	bl lib_mul10
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sub	r1, r2, r1
	j lib_print_num
lib_print_int:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, _ble_then.885
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
_ble_then.885:
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
	beq	r1, r2, _beq_then.886
	beqi	r1, 9, _beq_then.887
	beqi	r1, 13, _beq_then.888
	beqi	r1, 10, _beq_then.889
	addi	r2, r0, 26				# li	r2, 26
	beq	r1, r2, _beq_then.890
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_buffer_add_char				#	bl	lib_buffer_add_char
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	j lib_read_token
_beq_then.890:
	jr	r31				#	blr
_beq_then.889:
	lw	r1, 0(r3)
	beqi	r1, 0, _beq_then.892
	jr	r31				#	blr
_beq_then.892:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
_beq_then.888:
	lw	r1, 0(r3)
	beqi	r1, 0, _beq_then.894
	jr	r31				#	blr
_beq_then.894:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
_beq_then.887:
	lw	r1, 0(r3)
	beqi	r1, 0, _beq_then.896
	jr	r31				#	blr
_beq_then.896:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
_beq_then.886:
	lw	r1, 0(r3)
	beqi	r1, 0, _beq_then.898
	jr	r31				#	blr
_beq_then.898:
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
	beqi	r1, 0, _beq_then.900
	flup	f2, 39
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	j lib_iter_div10_float
_beq_then.900:
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
	beq	r5, r2, _beq_then.901
	lw	r2, 1(r3)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_float_of_int				#	bl lib_float_of_int
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_float_of_int				#	bl lib_float_of_int
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
_beq_then.901:
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
	jal lib_float_of_int				#	bl lib_float_of_int
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal lib_float_of_int				#	bl lib_float_of_int
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
	beq	r0, r30, _fle_else.902
	jr	r31				#	blr
_fle_else.902:
	fneg	f1, f1
	jr	r31				#	blr
lib_print_dec:
	flup	f2, 0
	feq	r30, f1, f2
	beq	r0, r30, _feq_else.903
	jr	r31				#	blr
_feq_else.903:
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
	jal lib_float_of_int				#	bl lib_float_of_int
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
	jal lib_float_of_int				#	bl lib_float_of_int
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
	beq	r0, r30, _fle_else.905
	j lib_print_ufloat
_fle_else.905:
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
	fneg	f1, f1
	j lib_print_ufloat
# library ends
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10231
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	jr	r31				#	blr
beq_then.10231:
	lw	r30, 0(r3)				#lfd	f1, 0(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10232
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	jr	r31				#	blr
beq_then.10232:
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
	jr	r31				#	blr
vecset.2473:
	fmvtr	r30, f1
	sw	r30, 0(r1)
	fmvtr	r30, f2
	sw	r30, 1(r1)
	fmvtr	r30, f3
	sw	r30, 2(r1)
	jr	r31				#	blr
vecfill.2478:
	fmvtr	r30, f1
	sw	r30, 0(r1)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	jr	r31				#	blr
veccpy.2483:
	lw	r30, 0(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r1)
	jr	r31				#	blr
vecunit_sgn.2491:
	lw	r30, 0(r1)
	fmvfr	f1, r30
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
	lw	r30, 1(r1)
	fmvfr	f2, r30
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
	lw	r30, 2(r1)
	fmvfr	f2, r30
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10236
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	j	beq_cont.10237
beq_then.10236:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 0(r3)
	beq	r2, r1, beq_then.10238
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	j	beq_cont.10239
beq_then.10238:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
beq_cont.10239:
beq_cont.10237:
	lw	r1, 1(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	fmvtr	r30, f2
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	fmvtr	r30, f2
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	fmvtr	r30, f1
	sw	r30, 2(r1)
	jr	r31				#	blr
veciprod.2494:
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r30, 1(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	jr	r31				#	blr
veciprod2.2497:
	lw	r30, 0(r1)
	fmvfr	f4, r30
	fmul	f1, f4, f1
	lw	r30, 1(r1)
	fmvfr	f4, r30
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	lw	r30, 2(r1)
	fmvfr	f2, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	jr	r31				#	blr
vecaccum.2502:
	lw	r30, 0(r1)
	fmvfr	f2, r30
	lw	r30, 0(r2)
	fmvfr	f3, r30
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fmvtr	r30, f2
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r30, 1(r2)
	fmvfr	f3, r30
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fmvtr	r30, f2
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	fmvtr	r30, f1
	sw	r30, 2(r1)
	jr	r31				#	blr
vecadd.2506:
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r1)
	jr	r31				#	blr
vecscale.2512:
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	fmvtr	r30, f2
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	fmvtr	r30, f2
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	fmvtr	r30, f1
	sw	r30, 2(r1)
	jr	r31				#	blr
vecaccumv.2515:
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r30, 0(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r1)
	jr	r31				#	blr
read_screen_settings.2592:
	lw	r1, 5(r28)
	lw	r2, 4(r28)
	lw	r5, 3(r28)
	lw	r6, 2(r28)
	lw	r7, 1(r28)
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
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 64053
	lui	r30, r30, 15502	# to load float		0.017453
	fmvfr	f2, r30
	fmul	f1, f1, f2
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
	addi	r30, r0, 64053
	lui	r30, r30, 15502	# to load float		0.017453
	fmvfr	f2, r30
	fmul	f1, f1, f2
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
	fmvtr	r30, f3
	sw	r30, 0(r1)
	addi	r30, r0, 0
	lui	r30, r30, 49992	# to load float		-200.000000
	fmvfr	f3, r30
	lw	r30, 10(r3)				#lfd	f4, 10(r3)
	fmvfr	f4, r30
	fmul	f3, f4, f3
	fmvtr	r30, f3
	sw	r30, 1(r1)
	lw	r30, 14(r3)				#lfd	f3, 14(r3)
	fmvfr	f3, r30
	fmul	f5, f2, f3
	addi	r30, r0, 0
	lui	r30, r30, 17224	# to load float		200.000000
	fmvfr	f6, r30
	fmul	f5, f5, f6
	fmvtr	r30, f5
	sw	r30, 2(r1)
	lw	r2, 2(r3)
	fmvtr	r30, f3
	sw	r30, 0(r2)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f5, r30
	fmvtr	r30, f5
	sw	r30, 1(r2)
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
	fmvtr	r30, f1
	sw	r30, 2(r1)
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
	fmvtr	r30, f1
	sw	r30, 0(r1)
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
	fmvtr	r30, f1
	sw	r30, 1(r1)
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
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r1, 4(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r2, 3(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r5, 0(r3)
	fmvtr	r30, f1
	sw	r30, 0(r5)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r5)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r5)
	jr	r31				#	blr
read_light.2594:
	lw	r1, 2(r28)
	lw	r2, 1(r28)
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
	addi	r30, r0, 64053
	lui	r30, r30, 15502	# to load float		0.017453
	fmvfr	f2, r30
	fmul	f1, f1, f2
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
	fmvtr	r30, f1
	sw	r30, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 64053
	lui	r30, r30, 15502	# to load float		0.017453
	fmvfr	f2, r30
	fmul	f1, f1, f2
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
	fmvtr	r30, f1
	sw	r30, 0(r1)
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
	fmvtr	r30, f1
	sw	r30, 2(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	jr	r31				#	blr
rotate_quadratic_matrix.2596:
	lw	r30, 0(r2)
	fmvfr	f1, r30
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
	lw	r30, 0(r1)
	fmvfr	f2, r30
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
	lw	r30, 1(r1)
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
	lw	r1, 1(r3)
	lw	r30, 1(r1)
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
	lw	r1, 1(r3)
	lw	r30, 2(r1)
	fmvfr	f2, r30
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
	lw	r30, 2(r1)
	fmvfr	f2, r30
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
	lw	r30, 0(r1)
	fmvfr	f4, r30
	lw	r30, 1(r1)
	fmvfr	f5, r30
	lw	r30, 2(r1)
	fmvfr	f6, r30
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
	fmvtr	r30, f1
	sw	r30, 0(r1)
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
	fmvtr	r30, f1
	sw	r30, 1(r1)
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
	fmvtr	r30, f1
	sw	r30, 2(r1)
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
	fmvtr	r30, f1
	sw	r30, 0(r1)
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
	fmvtr	r30, f1
	sw	r30, 1(r1)
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f1, r30
	fmul	f3, f4, f3
	fmul	f4, f6, f7
	fadd	f3, f3, f4
	fmul	f2, f2, f9
	fadd	f2, f3, f2
	fmul	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r1)
	jr	r31				#	blr
read_nth_object.2599:
	lw	r2, 1(r28)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.10249
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
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
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
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
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
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 9(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
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
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
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
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 5(r3)
	beq	r5, r2, beq_then.10250
	sw	r1, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 64053
	lui	r30, r30, 15502	# to load float		0.017453
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 11(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 64053
	lui	r30, r30, 15502	# to load float		0.017453
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 11(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 64053
	lui	r30, r30, 15502	# to load float		0.017453
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 11(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	j	beq_cont.10251
beq_then.10250:
beq_cont.10251:
	addi	r2, r0, 2				# li	r2, 2
	lw	r5, 3(r3)
	beq	r5, r2, beq_then.10252
	lw	r2, 8(r3)
	j	beq_cont.10253
beq_then.10252:
	addi	r2, r0, 1				# li	r2, 1
beq_cont.10253:
	addi	r6, r0, 4				# li	r6, 4
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r2, 12(r3)
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
	addi	r2, r0, 3				# li	r2, 3
	beq	r7, r2, beq_then.10254
	addi	r2, r0, 2				# li	r2, 2
	beq	r7, r2, beq_then.10256
	j	beq_cont.10257
beq_then.10256:
	addi	r2, r0, 0				# li	r2, 0
	lw	r7, 8(r3)
	beq	r7, r2, beq_then.10258
	addi	r2, r0, 0				# li	r2, 0
	j	beq_cont.10259
beq_then.10258:
	addi	r2, r0, 1				# li	r2, 1
beq_cont.10259:
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	vecunit_sgn.2491				#	bl	vecunit_sgn.2491
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10257:
	j	beq_cont.10255
beq_then.10254:
	lw	r30, 0(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10261
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.10262
beq_then.10261:
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
beq_cont.10262:
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10263
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.10264
beq_then.10263:
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
beq_cont.10264:
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10265
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.10266
beq_then.10265:
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
beq_cont.10266:
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
beq_cont.10255:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 5(r3)
	beq	r2, r1, beq_then.10267
	lw	r1, 6(r3)
	lw	r2, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	rotate_quadratic_matrix.2596				#	bl	rotate_quadratic_matrix.2596
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.10268
beq_then.10267:
beq_cont.10268:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.10249:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
read_object.2601:
	lw	r2, 2(r28)
	lw	r5, 1(r28)
	addi	r6, r0, 60				# li	r6, 60
	ble	r6, r1, ble_then.10269
	sw	r28, 0(r3)
	sw	r5, 1(r3)
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r28, r0, r2				# mr	r28, r2
	sw	r30, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10270
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10270:
	lw	r1, 1(r3)
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	jr	r31				#	blr
ble_then.10269:
	jr	r31				#	blr
read_net_item.2605:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.10273
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
beq_then.10273:
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
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.10274
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
beq_then.10274:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.2609:
	lw	r2, 1(r28)
	addi	r5, r0, 0				# li	r5, 0
	sw	r28, 0(r3)
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
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.10275
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10275:
	jr	r31				#	blr
read_parameter.2611:
	lw	r1, 5(r28)
	lw	r2, 4(r28)
	lw	r5, 3(r28)
	lw	r6, 2(r28)
	lw	r7, 1(r28)
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r2, 2(r3)
	sw	r5, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r28, r0, r1				# mr	r28, r1
	sw	r30, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	lw	r28, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r28)
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
	lw	r8, 1(r28)
	add	r30, r2, r5
	lw	r30, 0(r30)
	fmvfr	f4, r30
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10281
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.10281:
	lw	r1, 14(r3)
	lw	r2, 4(r1)
	lw	r1, 6(r1)
	lw	r5, 12(r3)
	lw	r6, 13(r3)
	add	r30, r6, r5
	lw	r30, 0(r30)
	fmvfr	f1, r30
	sw	r2, 15(r3)
	sw	r1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 16(r3)
	beq	r5, r2, beq_then.10282
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10284
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.10285
beq_then.10284:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.10285:
	j	beq_cont.10283
beq_then.10282:
beq_cont.10283:
	lw	r2, 12(r3)
	lw	r5, 15(r3)
	add	r30, r5, r2
	lw	r30, 0(r30)
	fmvfr	f1, r30
	addi	r6, r0, 0				# li	r6, 0
	beq	r1, r6, beq_then.10286
	j	beq_cont.10287
beq_then.10286:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10287:
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r1, 12(r3)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r30, 0(r30)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 8(r3)
	add	r30, r2, r1
	lw	r30, 0(r30)
	fmvfr	f2, r30
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
	lw	r30, 0(r30)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10289
	lw	r1, 4(r3)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r30, 0(r30)
	fmvfr	f1, r30
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
	lw	r30, 0(r30)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10290
	lw	r1, 0(r3)
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.10290:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.10289:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_rect.2622:
	lw	r28, 1(r28)
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
	sw	r28, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10291
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.10291:
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
	lw	r28, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10292
	addi	r1, r0, 2				# li	r1, 2
	jr	r31				#	blr
beq_then.10292:
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
	lw	r28, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10293
	addi	r1, r0, 3				# li	r1, 3
	jr	r31				#	blr
beq_then.10293:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_surface.2628:
	lw	r5, 1(r28)
	lw	r1, 4(r1)
	sw	r5, 0(r3)
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	veciprod.2494				#	bl	veciprod.2494
	addi	r3, r3, -10
	lw	r30, 9(r3)
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10296
	lw	r30, 6(r3)				#lfd	f1, 6(r3)
	fmvfr	f1, r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	lw	r1, 8(r3)
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
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.10296:
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
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
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
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.10298
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	lw	r30, 4(r3)				#lfd	f3, 4(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f1, f1, f4
	lw	r30, 0(r3)				#lfd	f4, 0(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r1, 9(r1)
	lw	r30, 2(r1)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	jr	r31				#	blr
beq_then.10298:
	jr	r31				#	blr
bilinear.2639:
	fmul	f7, f1, f4
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f8, r30
	fmul	f7, f7, f8
	fmul	f8, f2, f5
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f9, r30
	fmul	f8, f8, f9
	fadd	f7, f7, f8
	fmul	f8, f3, f6
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f9, r30
	fmul	f8, f8, f9
	fadd	f7, f7, f8
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.10299
	fmul	f8, f3, f5
	fmul	f9, f2, f6
	fadd	f8, f8, f9
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f9, r30
	fmul	f8, f8, f9
	fmul	f6, f1, f6
	fmul	f3, f3, f4
	fadd	f3, f6, f3
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f6, r30
	fmul	f3, f3, f6
	fadd	f3, f8, f3
	fmul	f1, f1, f5
	fmul	f2, f2, f4
	fadd	f1, f1, f2
	lw	r1, 9(r1)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	fadd	f1, f3, f1
	fmvtr	r30, f7
	sw	r30, 0(r3)				#stfd	f7, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_fhalf				#	bl	lib_fhalf
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	jr	r31				#	blr
beq_then.10299:
	fadd	f1, f0, f7				# fmr	f1, f7
	jr	r31				#	blr
solver_second.2647:
	lw	r5, 1(r28)
	lw	r30, 0(r2)
	fmvfr	f4, r30
	lw	r30, 1(r2)
	fmvfr	f5, r30
	lw	r30, 2(r2)
	fmvfr	f6, r30
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10301
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.10301:
	lw	r1, 9(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r30, 2(r1)
	fmvfr	f3, r30
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
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.10302
	j	beq_cont.10303
beq_then.10302:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.10303:
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
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
	lw	r30, 10(r3)				#lfd	f3, 10(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10304
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10305
	j	beq_cont.10306
beq_then.10305:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10306:
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.10304:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver.2653:
	lw	r6, 4(r28)
	lw	r7, 3(r28)
	lw	r8, 2(r28)
	lw	r9, 1(r28)
	add	r30, r9, r1
	lw	r1, 0(r30)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r9, 5(r1)
	lw	r30, 0(r9)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 1(r5)
	fmvfr	f2, r30
	lw	r9, 5(r1)
	lw	r30, 1(r9)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	lw	r30, 2(r5)
	fmvfr	f3, r30
	lw	r5, 5(r1)
	lw	r30, 2(r5)
	fmvfr	f4, r30
	fsub	f3, f3, f4
	lw	r5, 1(r1)
	addi	r9, r0, 1				# li	r9, 1
	beq	r5, r9, beq_then.10307
	addi	r8, r0, 2				# li	r8, 2
	beq	r5, r8, beq_then.10308
	add	r28, r0, r7				# mr	r28, r7
	lw	r27, 0(r28)
	jr	r27
beq_then.10308:
	add	r28, r0, r6				# mr	r28, r6
	lw	r27, 0(r28)
	jr	r27
beq_then.10307:
	add	r28, r0, r8				# mr	r28, r8
	lw	r27, 0(r28)
	jr	r27
solver_rect_fast.2657:
	lw	r6, 1(r28)
	lw	r30, 0(r5)
	fmvfr	f4, r30
	fsub	f4, f4, f1
	lw	r30, 1(r5)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	lw	r30, 1(r2)
	fmvfr	f5, r30
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
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10311
	lw	r1, 12(r3)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 8(r3)				#lfd	f3, 8(r3)
	fmvfr	f3, r30
	fadd	f1, f1, f3
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10313
	lw	r1, 6(r3)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10315
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.10316
beq_then.10315:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.10316:
	j	beq_cont.10314
beq_then.10313:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.10314:
	j	beq_cont.10312
beq_then.10311:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.10312:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10317
	lw	r1, 0(r3)
	lw	r30, 10(r3)				#lfd	f1, 10(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.10317:
	lw	r1, 6(r3)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 3(r1)
	fmvfr	f3, r30
	fmul	f1, f1, f3
	lw	r2, 12(r3)
	lw	r30, 0(r2)
	fmvfr	f3, r30
	fmul	f3, f1, f3
	lw	r30, 2(r3)				#lfd	f4, 2(r3)
	fmvfr	f4, r30
	fadd	f3, f3, f4
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10318
	lw	r1, 12(r3)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
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
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10320
	lw	r1, 6(r3)
	lw	r30, 3(r1)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10322
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.10323
beq_then.10322:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.10323:
	j	beq_cont.10321
beq_then.10320:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.10321:
	j	beq_cont.10319
beq_then.10318:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.10319:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10324
	lw	r1, 0(r3)
	lw	r30, 14(r3)				#lfd	f1, 14(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 2				# li	r1, 2
	jr	r31				#	blr
beq_then.10324:
	lw	r1, 6(r3)
	lw	r30, 4(r1)
	fmvfr	f1, r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 5(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r2, 12(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10325
	lw	r1, 12(r3)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 4(r3)				#lfd	f3, 4(r3)
	fmvfr	f3, r30
	fadd	f1, f1, f3
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	lw	r1, 4(r1)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10327
	lw	r1, 6(r3)
	lw	r30, 5(r1)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10329
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.10330
beq_then.10329:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.10330:
	j	beq_cont.10328
beq_then.10327:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.10328:
	j	beq_cont.10326
beq_then.10325:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.10326:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10331
	lw	r1, 0(r3)
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 3				# li	r1, 3
	jr	r31				#	blr
beq_then.10331:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_surface_fast.2664:
	lw	r1, 1(r28)
	lw	r30, 0(r2)
	fmvfr	f4, r30
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10333
	lw	r1, 8(r3)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 4(r3)				#lfd	f3, 4(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 3(r1)
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.10333:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_second_fast.2670:
	lw	r5, 1(r28)
	lw	r30, 0(r2)
	fmvfr	f4, r30
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10336
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.10336:
	lw	r1, 12(r3)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 2(r1)
	fmvfr	f3, r30
	lw	r30, 8(r3)				#lfd	f4, 8(r3)
	fmvfr	f4, r30
	fmul	f3, f3, f4
	fadd	f1, f1, f3
	lw	r30, 3(r1)
	fmvfr	f3, r30
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
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.10338
	j	beq_cont.10339
beq_then.10338:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.10339:
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10340
	lw	r1, 4(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10341
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
	lw	r30, 4(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	j	beq_cont.10342
beq_then.10341:
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
	lw	r30, 4(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
beq_cont.10342:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.10340:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_fast.2676:
	lw	r6, 4(r28)
	lw	r7, 3(r28)
	lw	r8, 2(r28)
	lw	r9, 1(r28)
	add	r30, r9, r1
	lw	r9, 0(r30)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r10, 5(r9)
	lw	r30, 0(r10)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 1(r5)
	fmvfr	f2, r30
	lw	r10, 5(r9)
	lw	r30, 1(r10)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	lw	r30, 2(r5)
	fmvfr	f3, r30
	lw	r5, 5(r9)
	lw	r30, 2(r5)
	fmvfr	f4, r30
	fsub	f3, f3, f4
	lw	r5, 1(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r1, 1(r9)
	addi	r10, r0, 1				# li	r10, 1
	beq	r1, r10, beq_then.10343
	addi	r2, r0, 2				# li	r2, 2
	beq	r1, r2, beq_then.10344
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r9				# mr	r1, r9
	add	r28, r0, r7				# mr	r28, r7
	lw	r27, 0(r28)
	jr	r27
beq_then.10344:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r9				# mr	r1, r9
	add	r28, r0, r6				# mr	r28, r6
	lw	r27, 0(r28)
	jr	r27
beq_then.10343:
	lw	r2, 0(r2)
	add	r1, r0, r9				# mr	r1, r9
	add	r28, r0, r8				# mr	r28, r8
	lw	r27, 0(r28)
	jr	r27
solver_surface_fast2.2680:
	lw	r1, 1(r28)
	lw	r30, 0(r2)
	fmvfr	f1, r30
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10345
	lw	r1, 2(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r1, 1(r3)
	lw	r30, 3(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.10345:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_second_fast2.2687:
	lw	r6, 1(r28)
	lw	r30, 0(r2)
	fmvfr	f4, r30
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10347
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.10347:
	lw	r1, 12(r3)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 8(r3)				#lfd	f3, 8(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 3(r1)
	fmvfr	f2, r30
	lw	r30, 6(r3)				#lfd	f3, 6(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r2, 4(r3)
	lw	r30, 3(r2)
	fmvfr	f2, r30
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10349
	lw	r1, 1(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10350
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
	lw	r30, 4(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	j	beq_cont.10351
beq_then.10350:
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
	lw	r30, 4(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
beq_cont.10351:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.10349:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_fast2.2694:
	lw	r5, 4(r28)
	lw	r6, 3(r28)
	lw	r7, 2(r28)
	lw	r8, 1(r28)
	add	r30, r8, r1
	lw	r8, 0(r30)
	lw	r9, 10(r8)
	lw	r30, 0(r9)
	fmvfr	f1, r30
	lw	r30, 1(r9)
	fmvfr	f2, r30
	lw	r30, 2(r9)
	fmvfr	f3, r30
	lw	r10, 1(r2)
	add	r30, r10, r1
	lw	r1, 0(r30)
	lw	r10, 1(r8)
	addi	r11, r0, 1				# li	r11, 1
	beq	r10, r11, beq_then.10352
	addi	r2, r0, 2				# li	r2, 2
	beq	r10, r2, beq_then.10353
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r1				# mr	r2, r1
	add	r28, r0, r6				# mr	r28, r6
	add	r1, r0, r8				# mr	r1, r8
	lw	r27, 0(r28)
	jr	r27
beq_then.10353:
	add	r2, r0, r1				# mr	r2, r1
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r9				# mr	r5, r9
	add	r1, r0, r8				# mr	r1, r8
	lw	r27, 0(r28)
	jr	r27
beq_then.10352:
	lw	r2, 0(r2)
	add	r5, r0, r1				# mr	r5, r1
	add	r28, r0, r7				# mr	r28, r7
	add	r1, r0, r8				# mr	r1, r8
	lw	r27, 0(r28)
	jr	r27
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
	lw	r30, 0(r2)
	fmvfr	f1, r30
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10354
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	j	beq_cont.10355
beq_then.10354:
	lw	r1, 0(r3)
	lw	r2, 6(r1)
	lw	r5, 1(r3)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	sw	r2, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 3(r3)
	beq	r5, r2, beq_then.10356
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10358
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.10359
beq_then.10358:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.10359:
	j	beq_cont.10357
beq_then.10356:
beq_cont.10357:
	lw	r2, 0(r3)
	lw	r5, 4(r2)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	addi	r5, r0, 0				# li	r5, 0
	beq	r1, r5, beq_then.10360
	j	beq_cont.10361
beq_then.10360:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10361:
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r2, 1(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r1)
beq_cont.10355:
	lw	r2, 1(r3)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10362
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 3(r1)
	j	beq_cont.10363
beq_then.10362:
	lw	r1, 0(r3)
	lw	r2, 6(r1)
	lw	r5, 1(r3)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	sw	r2, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 4(r3)
	beq	r5, r2, beq_then.10364
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10366
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.10367
beq_then.10366:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.10367:
	j	beq_cont.10365
beq_then.10364:
beq_cont.10365:
	lw	r2, 0(r3)
	lw	r5, 4(r2)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	addi	r5, r0, 0				# li	r5, 0
	beq	r1, r5, beq_then.10368
	j	beq_cont.10369
beq_then.10368:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10369:
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r2, 1(r3)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 3(r1)
beq_cont.10363:
	lw	r2, 1(r3)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10370
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 5(r1)
	j	beq_cont.10371
beq_then.10370:
	lw	r1, 0(r3)
	lw	r2, 6(r1)
	lw	r5, 1(r3)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	sw	r2, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 5(r3)
	beq	r5, r2, beq_then.10372
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10374
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.10375
beq_then.10374:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.10375:
	j	beq_cont.10373
beq_then.10372:
beq_cont.10373:
	lw	r2, 0(r3)
	lw	r2, 4(r2)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10376
	j	beq_cont.10377
beq_then.10376:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10377:
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r1)
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r2, 1(r3)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 5(r1)
beq_cont.10371:
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
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r5, 0(r3)
	lw	r6, 4(r5)
	lw	r30, 0(r6)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r2)
	fmvfr	f2, r30
	lw	r6, 4(r5)
	lw	r30, 1(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r2, 4(r5)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10378
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r2, 0(r3)
	lw	r5, 4(r2)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	fdiv	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r2, 0(r3)
	lw	r5, 4(r2)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r2, 0(r3)
	lw	r2, 4(r2)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 3(r1)
	j	beq_cont.10379
beq_then.10378:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
beq_cont.10379:
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
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	lw	r30, 2(r2)
	fmvfr	f3, r30
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
	lw	r30, 0(r1)
	fmvfr	f2, r30
	lw	r2, 0(r3)
	lw	r5, 4(r2)
	lw	r30, 0(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r2, 0(r3)
	lw	r5, 4(r2)
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r2, 0(r3)
	lw	r5, 4(r2)
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
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
	lw	r1, 2(r3)
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmvtr	r30, f2
	sw	r30, 0(r1)
	lw	r2, 0(r3)
	lw	r5, 3(r2)
	addi	r6, r0, 0				# li	r6, 0
	beq	r5, r6, beq_then.10381
	lw	r5, 1(r3)
	lw	r30, 2(r5)
	fmvfr	f3, r30
	lw	r6, 9(r2)
	lw	r30, 1(r6)
	fmvfr	f4, r30
	fmul	f3, f3, f4
	lw	r30, 1(r5)
	fmvfr	f4, r30
	lw	r6, 9(r2)
	lw	r30, 2(r6)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f3, f3, f4
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_fhalf				#	bl	lib_fhalf
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r2, 1(r3)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	lw	r5, 0(r3)
	lw	r6, 9(r5)
	lw	r30, 0(r6)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r6, 9(r5)
	lw	r30, 2(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_fhalf				#	bl	lib_fhalf
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r2, 1(r3)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	lw	r5, 0(r3)
	lw	r6, 9(r5)
	lw	r30, 0(r6)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r2, 9(r5)
	lw	r30, 1(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_fhalf				#	bl	lib_fhalf
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 3(r1)
	j	beq_cont.10382
beq_then.10381:
	lw	r30, 6(r3)				#lfd	f3, 6(r3)
	fmvfr	f3, r30
	fmvtr	r30, f3
	sw	r30, 1(r1)
	lw	r30, 8(r3)				#lfd	f3, 8(r3)
	fmvfr	f3, r30
	fmvtr	r30, f3
	sw	r30, 2(r1)
	fmvtr	r30, f1
	sw	r30, 3(r1)
beq_cont.10382:
	lw	r30, 4(r3)				#lfd	f1, 4(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10383
	j	beq_cont.10384
beq_then.10383:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r1)
beq_cont.10384:
	lw	r1, 2(r3)
	jr	r31				#	blr
iter_setup_dirvec_constants.2706:
	lw	r5, 1(r28)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.10385
	jr	r31				#	blr
ble_then.10385:
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 1(r1)
	lw	r7, 0(r1)
	lw	r8, 1(r5)
	addi	r9, r0, 1				# li	r9, 1
	sw	r1, 0(r3)
	sw	r28, 1(r3)
	beq	r8, r9, beq_then.10387
	addi	r9, r0, 2				# li	r9, 2
	beq	r8, r9, beq_then.10389
	sw	r2, 2(r3)
	sw	r6, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	setup_second_table.2703				#	bl	setup_second_table.2703
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.10390
beq_then.10389:
	sw	r2, 2(r3)
	sw	r6, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	setup_surface_table.2700				#	bl	setup_surface_table.2700
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.10390:
	j	beq_cont.10388
beq_then.10387:
	sw	r2, 2(r3)
	sw	r6, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	setup_rect_table.2697				#	bl	setup_rect_table.2697
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.10388:
	addi	r1, r0, 1				# li	r1, 1
	sub	r2, r2, r1
	lw	r1, 0(r3)
	lw	r28, 1(r3)
	lw	r27, 0(r28)
	jr	r27
setup_startp_constants.2711:
	lw	r5, 1(r28)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.10391
	jr	r31				#	blr
ble_then.10391:
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 10(r5)
	lw	r7, 1(r5)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r8, 5(r5)
	lw	r30, 0(r8)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r6)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r8, 5(r5)
	lw	r30, 1(r8)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r6)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	lw	r8, 5(r5)
	lw	r30, 2(r8)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r6)
	addi	r8, r0, 2				# li	r8, 2
	sw	r1, 0(r3)
	sw	r28, 1(r3)
	sw	r2, 2(r3)
	beq	r7, r8, beq_then.10393
	addi	r8, r0, 2				# li	r8, 2
	ble	r7, r8, ble_then.10395
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r30, 1(r6)
	fmvfr	f2, r30
	lw	r30, 2(r6)
	fmvfr	f3, r30
	sw	r6, 3(r3)
	sw	r7, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	quadratic.2634				#	bl	quadratic.2634
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 3				# li	r1, 3
	lw	r2, 4(r3)
	beq	r2, r1, beq_then.10397
	j	beq_cont.10398
beq_then.10397:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.10398:
	lw	r1, 3(r3)
	fmvtr	r30, f1
	sw	r30, 3(r1)
	j	ble_cont.10396
ble_then.10395:
ble_cont.10396:
	j	beq_cont.10394
beq_then.10393:
	lw	r5, 4(r5)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r30, 1(r6)
	fmvfr	f2, r30
	lw	r30, 2(r6)
	fmvfr	f3, r30
	sw	r6, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	veciprod2.2497				#	bl	veciprod2.2497
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	fmvtr	r30, f1
	sw	r30, 3(r1)
beq_cont.10394:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 2(r3)
	sub	r2, r2, r1
	lw	r1, 0(r3)
	lw	r28, 1(r3)
	lw	r27, 0(r28)
	jr	r27
setup_startp.2714:
	lw	r2, 3(r28)
	lw	r5, 2(r28)
	lw	r6, 1(r28)
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r1, 0(r1)
	addi	r2, r0, 1				# li	r2, 1
	sub	r2, r1, r2
	lw	r1, 0(r3)
	lw	r28, 1(r3)
	lw	r27, 0(r28)
	jr	r27
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
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10399
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10401
	lw	r30, 0(r3)				#lfd	f1, 0(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.10402
beq_then.10401:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.10402:
	j	beq_cont.10400
beq_then.10399:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.10400:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10403
	lw	r1, 4(r3)
	lw	r1, 6(r1)
	jr	r31				#	blr
beq_then.10403:
	lw	r1, 4(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10404
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.10404:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
is_plane_outside.2721:
	lw	r2, 4(r1)
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	veciprod2.2497				#	bl	veciprod2.2497
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	lw	r1, 6(r1)
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 1(r3)
	beq	r5, r2, beq_then.10405
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10407
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.10408
beq_then.10407:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.10408:
	j	beq_cont.10406
beq_then.10405:
beq_cont.10406:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10409
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.10409:
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
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.10410
	j	beq_cont.10411
beq_then.10410:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.10411:
	lw	r1, 6(r1)
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 1(r3)
	beq	r5, r2, beq_then.10412
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10414
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.10415
beq_then.10414:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.10415:
	j	beq_cont.10413
beq_then.10412:
beq_cont.10413:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10416
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.10416:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
is_outside.2731:
	lw	r2, 5(r1)
	lw	r30, 0(r2)
	fmvfr	f4, r30
	fsub	f1, f1, f4
	lw	r2, 5(r1)
	lw	r30, 1(r2)
	fmvfr	f4, r30
	fsub	f2, f2, f4
	lw	r2, 5(r1)
	lw	r30, 2(r2)
	fmvfr	f4, r30
	fsub	f3, f3, f4
	lw	r2, 1(r1)
	addi	r5, r0, 1				# li	r5, 1
	beq	r2, r5, beq_then.10417
	addi	r5, r0, 2				# li	r5, 2
	beq	r2, r5, beq_then.10418
	j	is_second_outside.2726
beq_then.10418:
	j	is_plane_outside.2721
beq_then.10417:
	j	is_rect_outside.2716
check_all_inside.2736:
	lw	r5, 1(r28)
	add	r30, r2, r1
	lw	r6, 0(r30)
	addi	r7, r0, -1				# li	r7, -1
	beq	r6, r7, beq_then.10419
	add	r30, r5, r6
	lw	r5, 0(r30)
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	sw	r2, 6(r3)
	sw	r28, 7(r3)
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	is_outside.2731				#	bl	is_outside.2731
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10420
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.10420:
	lw	r1, 8(r3)
	addi	r1, r1, 1
	lw	r30, 4(r3)				#lfd	f1, 4(r3)
	fmvfr	f1, r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
	lw	r2, 6(r3)
	lw	r28, 7(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10419:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
shadow_check_and_group.2742:
	lw	r5, 7(r28)
	lw	r6, 6(r28)
	lw	r7, 5(r28)
	lw	r8, 4(r28)
	lw	r9, 3(r28)
	lw	r10, 2(r28)
	lw	r11, 1(r28)
	add	r30, r2, r1
	lw	r12, 0(r30)
	addi	r13, r0, -1				# li	r13, -1
	beq	r12, r13, beq_then.10421
	add	r30, r2, r1
	lw	r12, 0(r30)
	sw	r11, 0(r3)
	sw	r10, 1(r3)
	sw	r9, 2(r3)
	sw	r2, 3(r3)
	sw	r28, 4(r3)
	sw	r1, 5(r3)
	sw	r12, 6(r3)
	sw	r7, 7(r3)
	sw	r6, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r12				# mr	r1, r12
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r10				# mr	r5, r10
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 8(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	addi	r2, r0, 0				# li	r2, 0
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	beq	r1, r2, beq_then.10423
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
	j	beq_cont.10424
beq_then.10423:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.10424:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10425
	addi	r30, r0, 55050
	lui	r30, r30, 15395	# to load float		0.010000
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 2(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	lw	r2, 1(r3)
	lw	r30, 0(r2)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	lw	r30, 1(r1)
	fmvfr	f3, r30
	fmul	f3, f3, f1
	lw	r30, 1(r2)
	fmvfr	f4, r30
	fadd	f3, f3, f4
	lw	r30, 2(r1)
	fmvfr	f4, r30
	fmul	f1, f4, f1
	lw	r30, 2(r2)
	fmvfr	f4, r30
	fadd	f1, f1, f4
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 3(r3)
	lw	r28, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10426
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.10426:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r28, 4(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10425:
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10427
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r28, 4(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10427:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.10421:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
shadow_check_one_or_group.2745:
	lw	r5, 2(r28)
	lw	r6, 1(r28)
	add	r30, r2, r1
	lw	r7, 0(r30)
	addi	r8, r0, -1				# li	r8, -1
	beq	r7, r8, beq_then.10428
	add	r30, r6, r7
	lw	r6, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	sw	r2, 0(r3)
	sw	r28, 1(r3)
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	add	r28, r0, r5				# mr	r28, r5
	sw	r30, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10429
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.10429:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	lw	r28, 1(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10428:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
shadow_check_one_or_matrix.2748:
	lw	r5, 5(r28)
	lw	r6, 4(r28)
	lw	r7, 3(r28)
	lw	r8, 2(r28)
	lw	r9, 1(r28)
	add	r30, r2, r1
	lw	r10, 0(r30)
	lw	r11, 0(r10)
	addi	r12, r0, -1				# li	r12, -1
	beq	r11, r12, beq_then.10430
	addi	r12, r0, 99				# li	r12, 99
	sw	r10, 0(r3)
	sw	r7, 1(r3)
	sw	r2, 2(r3)
	sw	r28, 3(r3)
	sw	r1, 4(r3)
	beq	r11, r12, beq_then.10431
	sw	r6, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r11				# mr	r1, r11
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r9				# mr	r5, r9
	sw	r30, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10433
	lw	r1, 5(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10435
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 0(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10437
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.10438
beq_then.10437:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.10438:
	j	beq_cont.10436
beq_then.10435:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.10436:
	j	beq_cont.10434
beq_then.10433:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.10434:
	j	beq_cont.10432
beq_then.10431:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.10432:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10439
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 0(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10440
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.10440:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r28, 3(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10439:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r28, 3(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10430:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solve_each_element.2751:
	lw	r6, 9(r28)
	lw	r7, 8(r28)
	lw	r8, 7(r28)
	lw	r9, 6(r28)
	lw	r10, 5(r28)
	lw	r11, 4(r28)
	lw	r12, 3(r28)
	lw	r13, 2(r28)
	lw	r14, 1(r28)
	add	r30, r2, r1
	lw	r15, 0(r30)
	addi	r16, r0, -1				# li	r16, -1
	beq	r15, r16, beq_then.10441
	sw	r11, 0(r3)
	sw	r13, 1(r3)
	sw	r12, 2(r3)
	sw	r14, 3(r3)
	sw	r7, 4(r3)
	sw	r6, 5(r3)
	sw	r8, 6(r3)
	sw	r5, 7(r3)
	sw	r2, 8(r3)
	sw	r28, 9(r3)
	sw	r1, 10(r3)
	sw	r15, 11(r3)
	sw	r10, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r15				# mr	r1, r15
	add	r28, r0, r9				# mr	r28, r9
	add	r5, r0, r7				# mr	r5, r7
	sw	r30, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10442
	lw	r2, 6(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10443
	lw	r1, 5(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	lw	r30, 14(r3)				#lfd	f1, 14(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10445
	addi	r30, r0, 55050
	lui	r30, r30, 15395	# to load float		0.010000
	fmvfr	f1, r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 7(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	lw	r2, 4(r3)
	lw	r30, 0(r2)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	lw	r30, 1(r1)
	fmvfr	f3, r30
	fmul	f3, f3, f1
	lw	r30, 1(r2)
	fmvfr	f4, r30
	fadd	f3, f3, f4
	lw	r30, 2(r1)
	fmvfr	f4, r30
	fmul	f4, f4, f1
	lw	r30, 2(r2)
	fmvfr	f5, r30
	fadd	f4, f4, f5
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 8(r3)
	lw	r28, 3(r3)
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
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10447
	lw	r1, 5(r3)
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
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
	j	beq_cont.10448
beq_then.10447:
beq_cont.10448:
	j	beq_cont.10446
beq_then.10445:
beq_cont.10446:
	j	beq_cont.10444
beq_then.10443:
beq_cont.10444:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r28, 9(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10442:
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10449
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r28, 9(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10449:
	jr	r31				#	blr
beq_then.10441:
	jr	r31				#	blr
solve_one_or_network.2755:
	lw	r6, 2(r28)
	lw	r7, 1(r28)
	add	r30, r2, r1
	lw	r8, 0(r30)
	addi	r9, r0, -1				# li	r9, -1
	beq	r8, r9, beq_then.10452
	add	r30, r7, r8
	lw	r7, 0(r30)
	addi	r8, r0, 0				# li	r8, 0
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r28, 2(r3)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	add	r28, r0, r6				# mr	r28, r6
	sw	r30, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r28, 2(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10452:
	jr	r31				#	blr
trace_or_matrix.2759:
	lw	r6, 5(r28)
	lw	r7, 4(r28)
	lw	r8, 3(r28)
	lw	r9, 2(r28)
	lw	r10, 1(r28)
	add	r30, r2, r1
	lw	r11, 0(r30)
	lw	r12, 0(r11)
	addi	r13, r0, -1				# li	r13, -1
	beq	r12, r13, beq_then.10454
	addi	r13, r0, 99				# li	r13, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r28, 2(r3)
	sw	r1, 3(r3)
	beq	r12, r13, beq_then.10455
	sw	r11, 4(r3)
	sw	r10, 5(r3)
	sw	r6, 6(r3)
	sw	r8, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r12				# mr	r1, r12
	add	r28, r0, r9				# mr	r28, r9
	add	r5, r0, r7				# mr	r5, r7
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10457
	lw	r1, 7(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r1, 6(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10459
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 4(r3)
	lw	r5, 0(r3)
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.10460
beq_then.10459:
beq_cont.10460:
	j	beq_cont.10458
beq_then.10457:
beq_cont.10458:
	j	beq_cont.10456
beq_then.10455:
	addi	r6, r0, 1				# li	r6, 1
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r11				# mr	r2, r11
	add	r1, r0, r6				# mr	r1, r6
	add	r28, r0, r10				# mr	r28, r10
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10456:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r28, 2(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10454:
	jr	r31				#	blr
judge_intersection.2763:
	lw	r2, 3(r28)
	lw	r5, 2(r28)
	lw	r6, 1(r28)
	addi	r30, r0, 27432
	lui	r30, r30, 20078	# to load float		1000000000.000000
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r5)
	addi	r7, r0, 0				# li	r7, 0
	lw	r6, 0(r6)
	sw	r5, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r1				# mr	r5, r1
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	sw	r30, 1(r3)
	addi	r3, r3, 2
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10463
	addi	r30, r0, 48160
	lui	r30, r30, 19646	# to load float		100000000.000000
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	j	lib_fless
beq_then.10463:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solve_each_element_fast.2765:
	lw	r6, 9(r28)
	lw	r7, 8(r28)
	lw	r8, 7(r28)
	lw	r9, 6(r28)
	lw	r10, 5(r28)
	lw	r11, 4(r28)
	lw	r12, 3(r28)
	lw	r13, 2(r28)
	lw	r14, 1(r28)
	lw	r15, 0(r5)
	add	r30, r2, r1
	lw	r16, 0(r30)
	addi	r17, r0, -1				# li	r17, -1
	beq	r16, r17, beq_then.10464
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
	sw	r28, 10(r3)
	sw	r1, 11(r3)
	sw	r16, 12(r3)
	sw	r10, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r16				# mr	r1, r16
	add	r28, r0, r8				# mr	r28, r8
	sw	r30, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10465
	lw	r2, 7(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 14(r3)
	fmvtr	r30, f2
	sw	r30, 16(r3)				#stfd	f2, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10467
	lw	r1, 6(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10469
	addi	r30, r0, 55050
	lui	r30, r30, 15395	# to load float		0.010000
	fmvfr	f1, r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 5(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	lw	r2, 4(r3)
	lw	r30, 0(r2)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	lw	r30, 1(r1)
	fmvfr	f3, r30
	fmul	f3, f3, f1
	lw	r30, 1(r2)
	fmvfr	f4, r30
	fadd	f3, f3, f4
	lw	r30, 2(r1)
	fmvfr	f4, r30
	fmul	f4, f4, f1
	lw	r30, 2(r2)
	fmvfr	f5, r30
	fadd	f4, f4, f5
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 9(r3)
	lw	r28, 3(r3)
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
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10471
	lw	r1, 6(r3)
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
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
	lw	r2, 12(r3)
	sw	r2, 0(r1)
	lw	r1, 0(r3)
	lw	r2, 14(r3)
	sw	r2, 0(r1)
	j	beq_cont.10472
beq_then.10471:
beq_cont.10472:
	j	beq_cont.10470
beq_then.10469:
beq_cont.10470:
	j	beq_cont.10468
beq_then.10467:
beq_cont.10468:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r28, 10(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10465:
	lw	r1, 12(r3)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10473
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r28, 10(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10473:
	jr	r31				#	blr
beq_then.10464:
	jr	r31				#	blr
solve_one_or_network_fast.2769:
	lw	r6, 2(r28)
	lw	r7, 1(r28)
	add	r30, r2, r1
	lw	r8, 0(r30)
	addi	r9, r0, -1				# li	r9, -1
	beq	r8, r9, beq_then.10476
	add	r30, r7, r8
	lw	r7, 0(r30)
	addi	r8, r0, 0				# li	r8, 0
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r28, 2(r3)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	add	r28, r0, r6				# mr	r28, r6
	sw	r30, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r28, 2(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10476:
	jr	r31				#	blr
trace_or_matrix_fast.2773:
	lw	r6, 4(r28)
	lw	r7, 3(r28)
	lw	r8, 2(r28)
	lw	r9, 1(r28)
	add	r30, r2, r1
	lw	r10, 0(r30)
	lw	r11, 0(r10)
	addi	r12, r0, -1				# li	r12, -1
	beq	r11, r12, beq_then.10478
	addi	r12, r0, 99				# li	r12, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r28, 2(r3)
	sw	r1, 3(r3)
	beq	r11, r12, beq_then.10479
	sw	r10, 4(r3)
	sw	r9, 5(r3)
	sw	r6, 6(r3)
	sw	r8, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r11				# mr	r1, r11
	add	r28, r0, r7				# mr	r28, r7
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10481
	lw	r1, 7(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r1, 6(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10483
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 4(r3)
	lw	r5, 0(r3)
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.10484
beq_then.10483:
beq_cont.10484:
	j	beq_cont.10482
beq_then.10481:
beq_cont.10482:
	j	beq_cont.10480
beq_then.10479:
	addi	r6, r0, 1				# li	r6, 1
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r6				# mr	r1, r6
	add	r28, r0, r9				# mr	r28, r9
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10480:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r28, 2(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10478:
	jr	r31				#	blr
judge_intersection_fast.2777:
	lw	r2, 3(r28)
	lw	r5, 2(r28)
	lw	r6, 1(r28)
	addi	r30, r0, 27432
	lui	r30, r30, 20078	# to load float		1000000000.000000
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r5)
	addi	r7, r0, 0				# li	r7, 0
	lw	r6, 0(r6)
	sw	r5, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r1				# mr	r5, r1
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	sw	r30, 1(r3)
	addi	r3, r3, 2
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10487
	addi	r30, r0, 48160
	lui	r30, r30, 19646	# to load float		100000000.000000
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	j	lib_fless
beq_then.10487:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
get_nvector_rect.2779:
	lw	r2, 2(r28)
	lw	r5, 1(r28)
	lw	r5, 0(r5)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	vecfill.2478				#	bl	vecfill.2478
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 2(r3)
	sub	r1, r2, r1
	addi	r5, r0, 1				# li	r5, 1
	sub	r2, r2, r5
	lw	r5, 1(r3)
	add	r30, r5, r2
	lw	r30, 0(r30)
	fmvfr	f1, r30
	sw	r1, 3(r3)
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
	add	r29, r2, r1
	fmvtr	r30, f1
	sw	r30, 0(r29)
	jr	r31				#	blr
get_nvector_plane.2781:
	lw	r2, 1(r28)
	lw	r5, 4(r1)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r2, 0(r3)
	lw	r5, 4(r2)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r2, 0(r3)
	lw	r2, 4(r2)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	jr	r31				#	blr
get_nvector_second.2783:
	lw	r2, 2(r28)
	lw	r5, 1(r28)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r6, 5(r1)
	lw	r30, 0(r6)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 1(r5)
	fmvfr	f2, r30
	lw	r6, 5(r1)
	lw	r30, 1(r6)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	lw	r30, 2(r5)
	fmvfr	f3, r30
	lw	r5, 5(r1)
	lw	r30, 2(r5)
	fmvfr	f4, r30
	fsub	f3, f3, f4
	lw	r5, 4(r1)
	lw	r30, 0(r5)
	fmvfr	f4, r30
	fmul	f4, f1, f4
	lw	r5, 4(r1)
	lw	r30, 1(r5)
	fmvfr	f5, r30
	fmul	f5, f2, f5
	lw	r5, 4(r1)
	lw	r30, 2(r5)
	fmvfr	f6, r30
	fmul	f6, f3, f6
	lw	r5, 3(r1)
	addi	r6, r0, 0				# li	r6, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	beq	r5, r6, beq_then.10490
	lw	r5, 9(r1)
	lw	r30, 2(r5)
	fmvfr	f7, r30
	fmul	f7, f2, f7
	lw	r5, 9(r1)
	lw	r30, 1(r5)
	fmvfr	f8, r30
	fmul	f8, f3, f8
	fadd	f7, f7, f8
	fmvtr	r30, f6
	sw	r30, 2(r3)				#stfd	f6, 2(r3)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	fmvtr	r30, f5
	sw	r30, 6(r3)				#stfd	f5, 6(r3)
	fmvtr	r30, f3
	sw	r30, 8(r3)				#stfd	f3, 8(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	fmvtr	r30, f4
	sw	r30, 12(r3)				#stfd	f4, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f7				# fmr	f1, f7
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fhalf				#	bl	lib_fhalf
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r2, 1(r3)
	lw	r5, 9(r2)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r5, 9(r2)
	lw	r30, 0(r5)
	fmvfr	f3, r30
	lw	r30, 8(r3)				#lfd	f4, 8(r3)
	fmvfr	f4, r30
	fmul	f3, f4, f3
	fadd	f1, f1, f3
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fhalf				#	bl	lib_fhalf
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r2, 1(r3)
	lw	r5, 9(r2)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r5, 9(r2)
	lw	r30, 0(r5)
	fmvfr	f2, r30
	lw	r30, 4(r3)				#lfd	f3, 4(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fadd	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fhalf				#	bl	lib_fhalf
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	j	beq_cont.10491
beq_then.10490:
	fmvtr	r30, f4
	sw	r30, 0(r2)
	fmvtr	r30, f5
	sw	r30, 1(r2)
	fmvtr	r30, f6
	sw	r30, 2(r2)
beq_cont.10491:
	lw	r1, 1(r3)
	lw	r2, 6(r1)
	lw	r1, 0(r3)
	j	vecunit_sgn.2491
utexture.2788:
	lw	r5, 1(r28)
	lw	r6, 0(r1)
	lw	r7, 8(r1)
	lw	r30, 0(r7)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r5)
	lw	r7, 8(r1)
	lw	r30, 1(r7)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r5)
	lw	r7, 8(r1)
	lw	r30, 2(r7)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r5)
	addi	r7, r0, 1				# li	r7, 1
	beq	r6, r7, beq_then.10492
	addi	r7, r0, 2				# li	r7, 2
	beq	r6, r7, beq_then.10493
	addi	r7, r0, 3				# li	r7, 3
	beq	r6, r7, beq_then.10494
	addi	r7, r0, 4				# li	r7, 4
	beq	r6, r7, beq_then.10495
	jr	r31				#	blr
beq_then.10495:
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r6, 5(r1)
	lw	r30, 0(r6)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r6, 4(r1)
	lw	r30, 0(r6)
	fmvfr	f2, r30
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 2(r3)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r2, 1(r3)
	lw	r5, 5(r2)
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	lw	r5, 4(r2)
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
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
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 46871
	lui	r30, r30, 14545	# to load float		0.000100
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10498
	addi	r30, r0, 0
	lui	r30, r30, 16752	# to load float		15.000000
	fmvfr	f1, r30
	j	beq_cont.10499
beq_then.10498:
	lw	r30, 6(r3)				#lfd	f1, 6(r3)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_atan				#	bl	lib_atan
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 16880	# to load float		30.000000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	addi	r30, r0, 4059
	lui	r30, r30, 16457	# to load float		3.141593
	fmvfr	f2, r30
	fdiv	f1, f1, f2
beq_cont.10499:
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_floor				#	bl	lib_floor
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 2(r3)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r1, 1(r3)
	lw	r2, 5(r1)
	lw	r30, 1(r2)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	lw	r1, 4(r1)
	lw	r30, 1(r1)
	fmvfr	f3, r30
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	fmvtr	r30, f2
	sw	r30, 20(r3)				#stfd	f2, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 46871
	lui	r30, r30, 14545	# to load float		0.000100
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10500
	addi	r30, r0, 0
	lui	r30, r30, 16752	# to load float		15.000000
	fmvfr	f1, r30
	j	beq_cont.10501
beq_then.10500:
	lw	r30, 14(r3)				#lfd	f1, 14(r3)
	fmvfr	f1, r30
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_atan				#	bl	lib_atan
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 16880	# to load float		30.000000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	addi	r30, r0, 4059
	lui	r30, r30, 16457	# to load float		3.141593
	fmvfr	f2, r30
	fdiv	f1, f1, f2
beq_cont.10501:
	fmvtr	r30, f1
	sw	r30, 24(r3)				#stfd	f1, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_floor				#	bl	lib_floor
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r0, 39322
	lui	r30, r30, 15897	# to load float		0.150000
	fmvfr	f2, r30
	addi	r30, r0, 0
	lui	r30, r30, 16128	# to load float		0.500000
	fmvfr	f3, r30
	lw	r30, 18(r3)				#lfd	f4, 18(r3)
	fmvfr	f4, r30
	fsub	f3, f3, f4
	fmvtr	r30, f1
	sw	r30, 26(r3)				#stfd	f1, 26(r3)
	fmvtr	r30, f2
	sw	r30, 28(r3)				#stfd	f2, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16128	# to load float		0.500000
	fmvfr	f2, r30
	lw	r30, 26(r3)				#lfd	f3, 26(r3)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	fmvtr	r30, f1
	sw	r30, 30(r3)				#stfd	f1, 30(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	fmvtr	r30, f1
	sw	r30, 32(r3)				#stfd	f1, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10502
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.10503
beq_then.10502:
	lw	r30, 32(r3)				#lfd	f1, 32(r3)
	fmvfr	f1, r30
beq_cont.10503:
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f2, r30
	fmul	f1, f2, f1
	addi	r30, r0, 39322
	lui	r30, r30, 16025	# to load float		0.300000
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	jr	r31				#	blr
beq_then.10494:
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r6, 5(r1)
	lw	r30, 0(r6)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r1, 5(r1)
	lw	r30, 2(r1)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	sw	r5, 0(r3)
	fmvtr	r30, f2
	sw	r30, 34(r3)				#stfd	f2, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
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
	fadd	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 16672	# to load float		10.000000
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 38(r3)				#stfd	f1, 38(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	lib_floor				#	bl	lib_floor
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 38(r3)				#lfd	f2, 38(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r0, 4059
	lui	r30, r30, 16457	# to load float		3.141593
	fmvfr	f2, r30
	fmul	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	lib_cos				#	bl	lib_cos
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r1, 0(r3)
	fmvtr	r30, f2
	sw	r30, 1(r1)
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r1)
	jr	r31				#	blr
beq_then.10493:
	lw	r30, 1(r2)
	fmvfr	f1, r30
	addi	r30, r0, 0
	lui	r30, r30, 16000	# to load float		0.250000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	sw	r5, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	lib_sin				#	bl	lib_sin
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f2, r30
	fmul	f2, f2, f1
	lw	r1, 0(r3)
	fmvtr	r30, f2
	sw	r30, 0(r1)
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f2, r30
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f3, r30
	fsub	f1, f3, f1
	fmul	f1, f2, f1
	fmvtr	r30, f1
	sw	r30, 1(r1)
	jr	r31				#	blr
beq_then.10492:
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r6, 5(r1)
	lw	r30, 0(r6)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	addi	r30, r0, 52429
	lui	r30, r30, 15692	# to load float		0.050000
	fmvfr	f2, r30
	fmul	f2, f1, f2
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	fmvtr	r30, f1
	sw	r30, 40(r3)				#stfd	f1, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_floor				#	bl	lib_floor
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 16800	# to load float		20.000000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 40(r3)				#lfd	f2, 40(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16672	# to load float		10.000000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	lw	r2, 1(r3)
	lw	r2, 5(r2)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	addi	r30, r0, 52429
	lui	r30, r30, 15692	# to load float		0.050000
	fmvfr	f2, r30
	fmul	f2, f1, f2
	sw	r1, 42(r3)
	fmvtr	r30, f1
	sw	r30, 44(r3)				#stfd	f1, 44(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	lib_floor				#	bl	lib_floor
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 16800	# to load float		20.000000
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 44(r3)				#lfd	f2, 44(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16672	# to load float		10.000000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 42(r3)
	beq	r5, r2, beq_then.10508
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10510
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f1, r30
	j	beq_cont.10511
beq_then.10510:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
beq_cont.10511:
	j	beq_cont.10509
beq_then.10508:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10512
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.10513
beq_then.10512:
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f1, r30
beq_cont.10513:
beq_cont.10509:
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	jr	r31				#	blr
add_light.2791:
	lw	r1, 2(r28)
	lw	r2, 1(r28)
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10515
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
	j	beq_cont.10516
beq_then.10515:
beq_cont.10516:
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10517
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
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fadd	f2, f2, f1
	fmvtr	r30, f2
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	fadd	f2, f2, f1
	fmvtr	r30, f2
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	fmvtr	r30, f1
	sw	r30, 2(r1)
	jr	r31				#	blr
beq_then.10517:
	jr	r31				#	blr
trace_reflections.2795:
	lw	r5, 8(r28)
	lw	r6, 7(r28)
	lw	r7, 6(r28)
	lw	r8, 5(r28)
	lw	r9, 4(r28)
	lw	r10, 3(r28)
	lw	r11, 2(r28)
	lw	r12, 1(r28)
	addi	r13, r0, 0				# li	r13, 0
	ble	r13, r1, ble_then.10520
	jr	r31				#	blr
ble_then.10520:
	add	r30, r6, r1
	lw	r6, 0(r30)
	lw	r13, 1(r6)
	sw	r28, 0(r3)
	sw	r1, 1(r3)
	fmvtr	r30, f2
	sw	r30, 2(r3)				#stfd	f2, 2(r3)
	sw	r12, 4(r3)
	sw	r2, 5(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	sw	r8, 8(r3)
	sw	r13, 9(r3)
	sw	r5, 10(r3)
	sw	r7, 11(r3)
	sw	r6, 12(r3)
	sw	r10, 13(r3)
	sw	r11, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r13				# mr	r1, r13
	add	r28, r0, r9				# mr	r28, r9
	sw	r30, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10522
	lw	r1, 14(r3)
	lw	r1, 0(r1)
	slli	r1, r1, 2
	lw	r2, 13(r3)
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 12(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.10524
	j	beq_cont.10525
beq_then.10524:
	addi	r1, r0, 0				# li	r1, 0
	lw	r5, 11(r3)
	lw	r5, 0(r5)
	lw	r28, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10526
	j	beq_cont.10527
beq_then.10526:
	lw	r1, 9(r3)
	lw	r2, 0(r1)
	lw	r5, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	veciprod.2494				#	bl	veciprod.2494
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 12(r3)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 6(r3)				#lfd	f3, 6(r3)
	fmvfr	f3, r30
	fmul	f4, f2, f3
	fmul	f1, f4, f1
	lw	r1, 9(r3)
	lw	r2, 0(r1)
	lw	r1, 5(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	fmvtr	r30, f2
	sw	r30, 18(r3)				#stfd	f2, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	veciprod.2494				#	bl	veciprod.2494
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10527:
beq_cont.10525:
	j	beq_cont.10523
beq_then.10522:
beq_cont.10523:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 1(r3)
	sub	r1, r2, r1
	lw	r30, 6(r3)				#lfd	f1, 6(r3)
	fmvfr	f1, r30
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	lw	r2, 5(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
trace_ray.2800:
	lw	r6, 24(r28)
	lw	r7, 23(r28)
	lw	r8, 22(r28)
	lw	r9, 21(r28)
	lw	r10, 20(r28)
	lw	r11, 19(r28)
	lw	r12, 18(r28)
	lw	r13, 17(r28)
	lw	r14, 16(r28)
	lw	r15, 15(r28)
	lw	r16, 14(r28)
	lw	r17, 13(r28)
	lw	r18, 12(r28)
	lw	r19, 11(r28)
	lw	r20, 10(r28)
	lw	r21, 9(r28)
	lw	r22, 8(r28)
	lw	r23, 7(r28)
	lw	r24, 6(r28)
	lw	r25, 5(r28)
	lw	r26, 4(r28)
	lw	r27, 3(r28)
	sw	r9, 0(r3)
	lw	r9, 2(r28)
	sw	r28, 1(r3)
	lw	r28, 1(r28)
	sw	r8, 2(r3)
	addi	r8, r0, 4				# li	r8, 4
	ble	r1, r8, ble_then.10529
	jr	r31				#	blr
ble_then.10529:
	lw	r8, 2(r5)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	sw	r18, 6(r3)
	sw	r13, 7(r3)
	sw	r28, 8(r3)
	sw	r12, 9(r3)
	sw	r15, 10(r3)
	sw	r27, 11(r3)
	sw	r17, 12(r3)
	sw	r10, 13(r3)
	sw	r7, 14(r3)
	sw	r5, 15(r3)
	sw	r21, 16(r3)
	sw	r6, 17(r3)
	sw	r22, 18(r3)
	sw	r11, 19(r3)
	sw	r24, 20(r3)
	sw	r26, 21(r3)
	sw	r25, 22(r3)
	sw	r16, 23(r3)
	sw	r23, 24(r3)
	sw	r14, 25(r3)
	sw	r9, 26(r3)
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	sw	r19, 30(r3)
	sw	r2, 31(r3)
	sw	r1, 32(r3)
	sw	r8, 33(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r28, r0, r20				# mr	r28, r20
	sw	r30, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10533
	lw	r1, 24(r3)
	lw	r1, 0(r1)
	lw	r2, 23(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	lw	r6, 7(r2)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r6, 1(r2)
	addi	r7, r0, 1				# li	r7, 1
	sw	r5, 34(r3)
	fmvtr	r30, f1
	sw	r30, 36(r3)				#stfd	f1, 36(r3)
	sw	r1, 38(r3)
	sw	r2, 39(r3)
	beq	r6, r7, beq_then.10535
	addi	r7, r0, 2				# li	r7, 2
	beq	r6, r7, beq_then.10537
	lw	r28, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.10538
beq_then.10537:
	lw	r28, 21(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10538:
	j	beq_cont.10536
beq_then.10535:
	lw	r6, 31(r3)
	lw	r28, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10536:
	lw	r1, 19(r3)
	lw	r2, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 39(r3)
	lw	r2, 18(r3)
	lw	r28, 17(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
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
	lw	r7, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 15(r3)
	lw	r2, 3(r1)
	lw	r5, 39(r3)
	lw	r6, 7(r5)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	addi	r30, r0, 0
	lui	r30, r30, 16128	# to load float		0.500000
	fmvfr	f2, r30
	sw	r2, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 41(r3)
	addi	r3, r3, 42
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10539
	lw	r1, 32(r3)
	lw	r2, 40(r3)
	lw	r5, 11(r3)
	add	r30, r2, r1
	sw	r5, 0(r30)
	j	beq_cont.10540
beq_then.10539:
	lw	r1, 32(r3)
	lw	r2, 40(r3)
	lw	r5, 14(r3)
	add	r30, r2, r1
	sw	r5, 0(r30)
	lw	r2, 15(r3)
	lw	r5, 4(r2)
	add	r30, r5, r1
	lw	r6, 0(r30)
	lw	r7, 13(r3)
	sw	r5, 41(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 32(r3)
	lw	r2, 41(r3)
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
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	vecscale.2512				#	bl	vecscale.2512
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 15(r3)
	lw	r2, 7(r1)
	lw	r5, 32(r3)
	add	r30, r2, r5
	lw	r2, 0(r30)
	lw	r6, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r6				# mr	r2, r6
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10540:
	addi	r30, r0, 0
	lui	r30, r30, 49152	# to load float		-2.000000
	fmvfr	f1, r30
	lw	r1, 31(r3)
	lw	r2, 12(r3)
	fmvtr	r30, f1
	sw	r30, 42(r3)				#stfd	f1, 42(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	veciprod.2494				#	bl	veciprod.2494
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 42(r3)				#lfd	f2, 42(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 31(r3)
	lw	r2, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	vecaccum.2502				#	bl	vecaccum.2502
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 39(r3)
	lw	r2, 7(r1)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 10(r3)
	lw	r5, 0(r5)
	lw	r28, 9(r3)
	fmvtr	r30, f1
	sw	r30, 44(r3)				#stfd	f1, 44(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10541
	j	beq_cont.10542
beq_then.10541:
	lw	r1, 12(r3)
	lw	r2, 30(r3)
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
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 36(r3)				#lfd	f2, 36(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 31(r3)
	lw	r2, 30(r3)
	fmvtr	r30, f1
	sw	r30, 46(r3)				#stfd	f1, 46(r3)
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
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 46(r3)				#lfd	f1, 46(r3)
	fmvfr	f1, r30
	lw	r30, 44(r3)				#lfd	f3, 44(r3)
	fmvfr	f3, r30
	lw	r28, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10542:
	lw	r1, 18(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	lw	r1, 0(r1)
	addi	r2, r0, 1				# li	r2, 1
	sub	r1, r1, r2
	lw	r30, 36(r3)				#lfd	f1, 36(r3)
	fmvfr	f1, r30
	lw	r30, 44(r3)				#lfd	f2, 44(r3)
	fmvfr	f2, r30
	lw	r2, 31(r3)
	lw	r28, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 52429
	lui	r30, r30, 15820	# to load float		0.100000
	fmvfr	f1, r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10543
	addi	r1, r0, 4				# li	r1, 4
	lw	r2, 32(r3)
	ble	r1, r2, ble_then.10544
	addi	r1, r2, 1
	addi	r5, r0, -1				# li	r5, -1
	lw	r6, 33(r3)
	add	r30, r6, r1
	sw	r5, 0(r30)
	j	ble_cont.10545
ble_then.10544:
ble_cont.10545:
	addi	r1, r0, 2				# li	r1, 2
	lw	r5, 34(r3)
	beq	r5, r1, beq_then.10546
	j	beq_cont.10547
beq_then.10546:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r1, 39(r3)
	lw	r1, 7(r1)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	addi	r1, r2, 1
	lw	r2, 0(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r30, 4(r3)				#lfd	f3, 4(r3)
	fmvfr	f3, r30
	fadd	f2, f3, f2
	lw	r2, 31(r3)
	lw	r5, 15(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10547:
	jr	r31				#	blr
beq_then.10543:
	jr	r31				#	blr
beq_then.10533:
	addi	r1, r0, -1				# li	r1, -1
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 0				# li	r1, 0
	beq	r2, r1, beq_then.10550
	lw	r1, 31(r3)
	lw	r2, 30(r3)
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10551
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
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 26(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 25(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fadd	f2, f2, f1
	fmvtr	r30, f2
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	fadd	f2, f2, f1
	fmvtr	r30, f2
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	fmvtr	r30, f1
	sw	r30, 2(r1)
	jr	r31				#	blr
beq_then.10551:
	jr	r31				#	blr
beq_then.10550:
	jr	r31				#	blr
trace_diffuse_ray.2806:
	lw	r2, 14(r28)
	lw	r5, 13(r28)
	lw	r6, 12(r28)
	lw	r7, 11(r28)
	lw	r8, 10(r28)
	lw	r9, 9(r28)
	lw	r10, 8(r28)
	lw	r11, 7(r28)
	lw	r12, 6(r28)
	lw	r13, 5(r28)
	lw	r14, 4(r28)
	lw	r15, 3(r28)
	lw	r16, 2(r28)
	lw	r17, 1(r28)
	sw	r5, 0(r3)
	sw	r17, 1(r3)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	sw	r10, 4(r3)
	sw	r9, 5(r3)
	sw	r6, 6(r3)
	sw	r7, 7(r3)
	sw	r12, 8(r3)
	sw	r2, 9(r3)
	sw	r14, 10(r3)
	sw	r16, 11(r3)
	sw	r15, 12(r3)
	sw	r1, 13(r3)
	sw	r8, 14(r3)
	sw	r13, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r28, r0, r11				# mr	r28, r11
	sw	r30, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10555
	lw	r1, 15(r3)
	lw	r1, 0(r1)
	lw	r2, 14(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 13(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	addi	r6, r0, 1				# li	r6, 1
	sw	r1, 16(r3)
	beq	r5, r6, beq_then.10556
	addi	r2, r0, 2				# li	r2, 2
	beq	r5, r2, beq_then.10558
	lw	r28, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.10559
beq_then.10558:
	lw	r28, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10559:
	j	beq_cont.10557
beq_then.10556:
	lw	r28, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10557:
	lw	r1, 16(r3)
	lw	r2, 8(r3)
	lw	r28, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 7(r3)
	lw	r2, 0(r2)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10560
	jr	r31				#	blr
beq_then.10560:
	lw	r1, 5(r3)
	lw	r2, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	veciprod.2494				#	bl	veciprod.2494
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10563
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	j	beq_cont.10564
beq_then.10563:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
beq_cont.10564:
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 16(r3)
	lw	r1, 7(r1)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 1(r3)
	lw	r2, 0(r3)
	j	vecaccum.2502
beq_then.10555:
	jr	r31				#	blr
iter_trace_diffuse_rays.2809:
	lw	r7, 1(r28)
	addi	r8, r0, 0				# li	r8, 0
	ble	r8, r6, ble_then.10566
	jr	r31				#	blr
ble_then.10566:
	add	r30, r1, r6
	lw	r8, 0(r30)
	lw	r8, 0(r8)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r28, 2(r3)
	sw	r7, 3(r3)
	sw	r6, 4(r3)
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r8				# mr	r1, r8
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
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10568
	lw	r1, 4(r3)
	addi	r2, r1, 1
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r30, r0, 0
	lui	r30, r30, 49942	# to load float		-150.000000
	fmvfr	f1, r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.10569
beq_then.10568:
	lw	r1, 4(r3)
	lw	r2, 5(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r30, r0, 0
	lui	r30, r30, 17174	# to load float		150.000000
	fmvfr	f1, r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10569:
	addi	r1, r0, 2				# li	r1, 2
	lw	r2, 4(r3)
	sub	r6, r2, r1
	lw	r1, 5(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r28, 2(r3)
	lw	r27, 0(r28)
	jr	r27
trace_diffuse_ray_80percent.2818:
	lw	r6, 3(r28)
	lw	r7, 2(r28)
	lw	r8, 1(r28)
	addi	r9, r0, 0				# li	r9, 0
	sw	r2, 0(r3)
	sw	r7, 1(r3)
	sw	r5, 2(r3)
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	sw	r1, 5(r3)
	beq	r1, r9, beq_then.10570
	lw	r9, 0(r8)
	sw	r9, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r28, r0, r6				# mr	r28, r6
	sw	r30, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 6(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.10571
beq_then.10570:
beq_cont.10571:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 5(r3)
	beq	r2, r1, beq_then.10572
	lw	r1, 4(r3)
	lw	r5, 1(r1)
	lw	r6, 2(r3)
	lw	r28, 3(r3)
	sw	r5, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 7(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.10573
beq_then.10572:
beq_cont.10573:
	addi	r1, r0, 2				# li	r1, 2
	lw	r2, 5(r3)
	beq	r2, r1, beq_then.10574
	lw	r1, 4(r3)
	lw	r5, 2(r1)
	lw	r6, 2(r3)
	lw	r28, 3(r3)
	sw	r5, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 8(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.10575
beq_then.10574:
beq_cont.10575:
	addi	r1, r0, 3				# li	r1, 3
	lw	r2, 5(r3)
	beq	r2, r1, beq_then.10576
	lw	r1, 4(r3)
	lw	r5, 3(r1)
	lw	r6, 2(r3)
	lw	r28, 3(r3)
	sw	r5, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 9(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.10577
beq_then.10576:
beq_cont.10577:
	addi	r1, r0, 4				# li	r1, 4
	lw	r2, 5(r3)
	beq	r2, r1, beq_then.10578
	lw	r1, 4(r3)
	lw	r1, 4(r1)
	lw	r2, 2(r3)
	lw	r28, 3(r3)
	sw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 10(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r28, 1(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10578:
	jr	r31				#	blr
calc_diffuse_using_1point.2822:
	lw	r5, 3(r28)
	lw	r6, 2(r28)
	lw	r7, 1(r28)
	lw	r8, 5(r1)
	lw	r9, 7(r1)
	lw	r10, 1(r1)
	lw	r11, 4(r1)
	add	r30, r8, r2
	lw	r8, 0(r30)
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r11, 2(r3)
	sw	r5, 3(r3)
	sw	r10, 4(r3)
	sw	r2, 5(r3)
	sw	r9, 6(r3)
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r7				# mr	r1, r7
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	lw	r1, 6(r1)
	lw	r1, 0(r1)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 4(r3)
	add	r30, r6, r2
	lw	r6, 0(r30)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r1, 1(r3)
	lw	r5, 0(r3)
	j	vecaccumv.2515
calc_diffuse_using_5points.2825:
	lw	r8, 2(r28)
	lw	r9, 1(r28)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r2, 5(r2)
	addi	r10, r0, 1				# li	r10, 1
	sub	r10, r1, r10
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
	sw	r8, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r6, 3(r3)
	sw	r12, 4(r3)
	sw	r11, 5(r3)
	sw	r9, 6(r3)
	sw	r7, 7(r3)
	sw	r10, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r9				# mr	r1, r9
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	lw	r2, 8(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	vecadd.2506				#	bl	vecadd.2506
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	lw	r2, 5(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	vecadd.2506				#	bl	vecadd.2506
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	vecadd.2506				#	bl	vecadd.2506
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	vecadd.2506				#	bl	vecadd.2506
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 1(r3)
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 4(r1)
	lw	r2, 7(r3)
	add	r30, r1, r2
	lw	r2, 0(r30)
	lw	r1, 0(r3)
	lw	r5, 6(r3)
	j	vecaccumv.2515
do_without_neighbors.2831:
	lw	r5, 1(r28)
	addi	r6, r0, 4				# li	r6, 4
	ble	r2, r6, ble_then.10580
	jr	r31				#	blr
ble_then.10580:
	lw	r6, 2(r1)
	addi	r7, r0, 0				# li	r7, 0
	add	r30, r6, r2
	lw	r6, 0(r30)
	ble	r7, r6, ble_then.10582
	jr	r31				#	blr
ble_then.10582:
	lw	r6, 3(r1)
	add	r30, r6, r2
	lw	r6, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	sw	r1, 0(r3)
	sw	r28, 1(r3)
	sw	r2, 2(r3)
	beq	r6, r7, beq_then.10584
	addi	r30, r31, 0				#mflr	r30
	add	r28, r0, r5				# mr	r28, r5
	sw	r30, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.10585
beq_then.10584:
beq_cont.10585:
	lw	r1, 2(r3)
	addi	r2, r1, 1
	lw	r1, 0(r3)
	lw	r28, 1(r3)
	lw	r27, 0(r28)
	jr	r27
neighbors_exist.2834:
	lw	r5, 1(r28)
	lw	r6, 1(r5)
	addi	r7, r2, 1
	ble	r6, r7, ble_then.10586
	addi	r6, r0, 0				# li	r6, 0
	ble	r2, r6, ble_then.10587
	lw	r2, 0(r5)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.10588
	addi	r2, r0, 0				# li	r2, 0
	ble	r1, r2, ble_then.10589
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
ble_then.10589:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
ble_then.10588:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
ble_then.10587:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
ble_then.10586:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
neighbors_are_available.2841:
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
	beq	r2, r8, beq_then.10590
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.10590:
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.10591
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.10591:
	addi	r2, r0, 1				# li	r2, 1
	sub	r2, r1, r2
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.10592
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.10592:
	addi	r1, r1, 1
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beq	r1, r8, beq_then.10593
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.10593:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
try_exploit_neighbors.2847:
	lw	r9, 2(r28)
	lw	r10, 1(r28)
	add	r30, r6, r1
	lw	r11, 0(r30)
	addi	r12, r0, 4				# li	r12, 4
	ble	r8, r12, ble_then.10594
	jr	r31				#	blr
ble_then.10594:
	addi	r12, r0, 0				# li	r12, 0
	lw	r13, 2(r11)
	add	r30, r13, r8
	lw	r13, 0(r30)
	ble	r12, r13, ble_then.10596
	jr	r31				#	blr
ble_then.10596:
	sw	r2, 0(r3)
	sw	r28, 1(r3)
	sw	r7, 2(r3)
	sw	r5, 3(r3)
	sw	r10, 4(r3)
	sw	r11, 5(r3)
	sw	r8, 6(r3)
	sw	r9, 7(r3)
	sw	r1, 8(r3)
	sw	r6, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r8				# mr	r7, r8
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	neighbors_are_available.2841				#	bl	neighbors_are_available.2841
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10598
	lw	r1, 5(r3)
	lw	r1, 3(r1)
	lw	r7, 6(r3)
	add	r30, r1, r7
	lw	r1, 0(r30)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10599
	lw	r1, 8(r3)
	lw	r2, 3(r3)
	lw	r5, 9(r3)
	lw	r6, 2(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.10600
beq_then.10599:
beq_cont.10600:
	lw	r1, 6(r3)
	addi	r8, r1, 1
	lw	r1, 8(r3)
	lw	r2, 0(r3)
	lw	r5, 3(r3)
	lw	r6, 9(r3)
	lw	r7, 2(r3)
	lw	r28, 1(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10598:
	lw	r1, 8(r3)
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 6(r3)
	lw	r28, 7(r3)
	lw	r27, 0(r28)
	jr	r27
write_ppm_header.2854:
	lw	r1, 1(r28)
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
	ble	r1, r2, ble_then.10601
	addi	r1, r0, 255				# li	r1, 255
	j	ble_cont.10602
ble_then.10601:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.10603
	addi	r1, r0, 0				# li	r1, 0
	j	ble_cont.10604
ble_then.10603:
ble_cont.10604:
ble_cont.10602:
	j	lib_print_int
write_rgb.2858:
	lw	r1, 1(r28)
	lw	r30, 0(r1)
	fmvfr	f1, r30
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
	lw	r30, 1(r1)
	fmvfr	f1, r30
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
	lw	r30, 2(r1)
	fmvfr	f1, r30
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
	lw	r5, 4(r28)
	lw	r6, 3(r28)
	lw	r7, 2(r28)
	lw	r8, 1(r28)
	addi	r9, r0, 4				# li	r9, 4
	ble	r2, r9, ble_then.10605
	jr	r31				#	blr
ble_then.10605:
	lw	r9, 2(r1)
	add	r30, r9, r2
	lw	r9, 0(r30)
	addi	r10, r0, 0				# li	r10, 0
	ble	r10, r9, ble_then.10607
	jr	r31				#	blr
ble_then.10607:
	lw	r9, 3(r1)
	add	r30, r9, r2
	lw	r9, 0(r30)
	addi	r10, r0, 0				# li	r10, 0
	sw	r1, 0(r3)
	sw	r28, 1(r3)
	sw	r2, 2(r3)
	beq	r9, r10, beq_then.10609
	lw	r9, 6(r1)
	lw	r9, 0(r9)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r8, 3(r3)
	sw	r6, 4(r3)
	sw	r5, 5(r3)
	sw	r9, 6(r3)
	sw	r7, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r8				# mr	r1, r8
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	vecfill.2478				#	bl	vecfill.2478
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	lw	r2, 7(r1)
	lw	r5, 1(r1)
	lw	r6, 6(r3)
	lw	r7, 7(r3)
	add	r30, r7, r6
	lw	r6, 0(r30)
	lw	r7, 2(r3)
	add	r30, r2, r7
	lw	r2, 0(r30)
	add	r30, r5, r7
	lw	r5, 0(r30)
	lw	r28, 5(r3)
	sw	r5, 8(r3)
	sw	r2, 9(r3)
	sw	r6, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 10(r3)
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	lw	r2, 5(r1)
	lw	r5, 2(r3)
	add	r30, r2, r5
	lw	r2, 0(r30)
	lw	r6, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r6				# mr	r2, r6
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.10610
beq_then.10609:
beq_cont.10610:
	lw	r1, 2(r3)
	addi	r2, r1, 1
	lw	r1, 0(r3)
	lw	r28, 1(r3)
	lw	r27, 0(r28)
	jr	r27
pretrace_pixels.2863:
	lw	r6, 10(r28)
	lw	r7, 9(r28)
	lw	r8, 8(r28)
	lw	r9, 7(r28)
	lw	r10, 6(r28)
	lw	r11, 5(r28)
	lw	r12, 4(r28)
	lw	r13, 3(r28)
	lw	r14, 2(r28)
	lw	r15, 1(r28)
	addi	r16, r0, 0				# li	r16, 0
	ble	r16, r2, ble_then.10611
	jr	r31				#	blr
ble_then.10611:
	lw	r30, 0(r10)
	fmvfr	f4, r30
	lw	r10, 0(r14)
	sub	r10, r2, r10
	sw	r28, 0(r3)
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
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r30, 16(r3)				#lfd	f3, 16(r3)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	lw	r2, 14(r3)
	fmvtr	r30, f2
	sw	r30, 0(r2)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r30, 12(r3)				#lfd	f4, 12(r3)
	fmvfr	f4, r30
	fadd	f2, f2, f4
	fmvtr	r30, f2
	sw	r30, 1(r2)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r2)
	lw	r1, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	vecunit_sgn.2491				#	bl	vecunit_sgn.2491
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	vecfill.2478				#	bl	vecfill.2478
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
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r6				# mr	r5, r6
	add	r2, r0, r7				# mr	r2, r7
	sw	r30, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	lw	r2, 5(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	lw	r6, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
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
	lw	r5, 6(r5)
	lw	r6, 2(r3)
	sw	r6, 0(r5)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 4(r3)
	sub	r2, r2, r1
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r1, ble_then.10615
	add	r5, r0, r1				# mr	r5, r1
	j	ble_cont.10616
ble_then.10615:
	addi	r5, r0, 5				# li	r5, 5
	sub	r5, r1, r5
ble_cont.10616:
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	lw	r30, 10(r3)				#lfd	f3, 10(r3)
	fmvfr	f3, r30
	lw	r1, 5(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
pretrace_line.2870:
	lw	r6, 6(r28)
	lw	r7, 5(r28)
	lw	r8, 4(r28)
	lw	r9, 3(r28)
	lw	r10, 2(r28)
	lw	r11, 1(r28)
	lw	r30, 0(r8)
	fmvfr	f1, r30
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
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r2, 4(r3)
	lw	r30, 0(r2)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	lw	r30, 1(r1)
	fmvfr	f3, r30
	fmul	f3, f1, f3
	lw	r30, 1(r2)
	fmvfr	f4, r30
	fadd	f3, f3, f4
	lw	r30, 2(r1)
	fmvfr	f4, r30
	fmul	f1, f1, f4
	lw	r30, 2(r2)
	fmvfr	f4, r30
	fadd	f1, f1, f4
	lw	r1, 3(r3)
	lw	r1, 0(r1)
	addi	r2, r0, 1				# li	r2, 1
	sub	r2, r1, r2
	lw	r1, 1(r3)
	lw	r5, 0(r3)
	lw	r28, 2(r3)
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	lw	r27, 0(r28)
	jr	r27
scan_pixel.2874:
	lw	r8, 6(r28)
	lw	r9, 5(r28)
	lw	r10, 4(r28)
	lw	r11, 3(r28)
	lw	r12, 2(r28)
	lw	r13, 1(r28)
	lw	r12, 0(r12)
	ble	r12, r1, ble_then.10617
	add	r30, r6, r1
	lw	r12, 0(r30)
	lw	r12, 0(r12)
	sw	r28, 0(r3)
	sw	r8, 1(r3)
	sw	r5, 2(r3)
	sw	r9, 3(r3)
	sw	r13, 4(r3)
	sw	r6, 5(r3)
	sw	r7, 6(r3)
	sw	r2, 7(r3)
	sw	r1, 8(r3)
	sw	r11, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	lw	r2, 7(r3)
	lw	r5, 6(r3)
	lw	r28, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10618
	addi	r8, r0, 0				# li	r8, 0
	lw	r1, 8(r3)
	lw	r2, 7(r3)
	lw	r5, 2(r3)
	lw	r6, 5(r3)
	lw	r7, 6(r3)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.10619
beq_then.10618:
	lw	r1, 8(r3)
	lw	r2, 5(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.10619:
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	addi	r1, r1, 1
	lw	r2, 7(r3)
	lw	r5, 2(r3)
	lw	r6, 5(r3)
	lw	r7, 6(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
ble_then.10617:
	jr	r31				#	blr
scan_line.2880:
	lw	r8, 3(r28)
	lw	r9, 2(r28)
	lw	r10, 1(r28)
	lw	r11, 1(r10)
	ble	r11, r1, ble_then.10621
	lw	r10, 1(r10)
	addi	r11, r0, 1				# li	r11, 1
	sub	r10, r10, r11
	sw	r28, 0(r3)
	sw	r7, 1(r3)
	sw	r6, 2(r3)
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	sw	r8, 6(r3)
	ble	r10, r1, ble_then.10622
	addi	r10, r1, 1
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r6				# mr	r1, r6
	add	r28, r0, r9				# mr	r28, r9
	sw	r30, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	j	ble_cont.10623
ble_then.10622:
ble_cont.10623:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 5(r3)
	lw	r5, 4(r3)
	lw	r6, 3(r3)
	lw	r7, 2(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r2, ble_then.10624
	add	r7, r0, r2				# mr	r7, r2
	j	ble_cont.10625
ble_then.10624:
	addi	r5, r0, 5				# li	r5, 5
	sub	r7, r2, r5
ble_cont.10625:
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	lw	r28, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	jr	r31				#	blr
ble_then.10621:
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
	lw	r1, 1(r28)
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
	lw	r5, 1(r28)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.10628
	jr	r31				#	blr
ble_then.10628:
	sw	r28, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r28, r0, r5				# mr	r28, r5
	sw	r30, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r2, r2, r1
	lw	r28, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r27, 0(r28)
	jr	r27
create_pixelline.2893:
	lw	r1, 3(r28)
	lw	r2, 2(r28)
	lw	r28, 1(r28)
	lw	r5, 0(r2)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r5, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(r28)
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
	addi	r5, r0, 2				# li	r5, 2
	sub	r2, r2, r5
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
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
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_sin				#	bl	lib_sin
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
	jal	lib_cos				#	bl	lib_cos
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
calc_dirvec.2900:
	lw	r6, 1(r28)
	addi	r7, r0, 5				# li	r7, 5
	ble	r7, r1, ble_then.10629
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r28, 4(r3)
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
	lw	r28, 4(r3)
	lw	r27, 0(r28)
	jr	r27
ble_then.10629:
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
	lw	r5, 0(r5)
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	fmvtr	r30, f2
	sw	r30, 22(r3)				#stfd	f2, 22(r3)
	fmvtr	r30, f3
	sw	r30, 24(r3)				#stfd	f3, 24(r3)
	sw	r1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	sw	r30, 27(r3)
	addi	r3, r3, 28
	jal	vecset.2473				#	bl	vecset.2473
	addi	r3, r3, -28
	lw	r30, 27(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	addi	r2, r1, 40
	lw	r5, 26(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 0(r2)
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	sw	r2, 27(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -29
	lw	r30, 28(r3)
	fadd	f3, f0, f1				# fmr	f3, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	lw	r1, 27(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	vecset.2473				#	bl	vecset.2473
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	addi	r2, r1, 80
	lw	r5, 26(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 0(r2)
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	sw	r2, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 29(r3)
	addi	r3, r3, 30
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -30
	lw	r30, 29(r3)
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
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	lw	r1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	vecset.2473				#	bl	vecset.2473
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	addi	r2, r1, 1
	lw	r5, 26(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 0(r2)
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	sw	r2, 32(r3)
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
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
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
	lw	r5, 26(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 0(r2)
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	sw	r2, 38(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 39(r3)
	addi	r3, r3, 40
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -40
	lw	r30, 39(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
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
	lw	r2, 26(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 0(r1)
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	sw	r1, 42(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 43(r3)
	addi	r3, r3, 44
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	lw	r30, 24(r3)				#lfd	f3, 24(r3)
	fmvfr	f3, r30
	lw	r1, 42(r3)
	j	vecset.2473
calc_dirvecs.2908:
	lw	r6, 1(r28)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.10635
	jr	r31				#	blr
ble_then.10635:
	sw	r28, 0(r3)
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
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r28)
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
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	sw	r30, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 1(r3)
	sub	r1, r2, r1
	lw	r2, 5(r3)
	addi	r2, r2, 1
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r2, ble_then.10637
	j	ble_cont.10638
ble_then.10637:
	addi	r5, r0, 5				# li	r5, 5
	sub	r2, r2, r5
ble_cont.10638:
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	lw	r5, 4(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
calc_dirvec_rows.2913:
	lw	r6, 1(r28)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.10639
	jr	r31				#	blr
ble_then.10639:
	sw	r28, 0(r3)
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
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 1(r3)
	sub	r1, r2, r1
	lw	r2, 3(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r2, ble_then.10641
	j	ble_cont.10642
ble_then.10641:
	addi	r5, r0, 5				# li	r5, 5
	sub	r2, r2, r5
ble_cont.10642:
	lw	r5, 2(r3)
	addi	r5, r5, 4
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
create_dirvec.2917:
	lw	r1, 1(r28)
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
	lw	r5, 1(r28)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.10643
	jr	r31				#	blr
ble_then.10643:
	sw	r28, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r28, r0, r5				# mr	r28, r5
	sw	r30, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r2, r2, r1
	lw	r28, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r27, 0(r28)
	jr	r27
create_dirvecs.2922:
	lw	r2, 3(r28)
	lw	r5, 2(r28)
	lw	r6, 1(r28)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.10645
	jr	r31				#	blr
ble_then.10645:
	addi	r7, r0, 120				# li	r7, 120
	sw	r28, 0(r3)
	sw	r5, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r28, r0, r6				# mr	r28, r6
	sw	r30, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r28)
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
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 2(r3)
	sub	r1, r2, r1
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
init_dirvec_constants.2924:
	lw	r5, 2(r28)
	lw	r6, 1(r28)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r2, ble_then.10647
	jr	r31				#	blr
ble_then.10647:
	add	r30, r1, r2
	lw	r7, 0(r30)
	lw	r5, 0(r5)
	addi	r8, r0, 1				# li	r8, 1
	sub	r5, r5, r8
	sw	r1, 0(r3)
	sw	r28, 1(r3)
	sw	r2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r28, r0, r6				# mr	r28, r6
	sw	r30, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 2(r3)
	sub	r2, r2, r1
	lw	r1, 0(r3)
	lw	r28, 1(r3)
	lw	r27, 0(r28)
	jr	r27
init_vecset_constants.2927:
	lw	r2, 2(r28)
	lw	r5, 1(r28)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r1, ble_then.10649
	jr	r31				#	blr
ble_then.10649:
	add	r30, r5, r1
	lw	r5, 0(r30)
	addi	r6, r0, 119				# li	r6, 119
	sw	r28, 0(r3)
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r6				# mr	r2, r6
	sw	r30, 2(r3)
	addi	r3, r3, 3
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 1(r3)
	sub	r1, r2, r1
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
init_dirvecs.2929:
	lw	r1, 3(r28)
	lw	r2, 2(r28)
	lw	r5, 1(r28)
	addi	r6, r0, 4				# li	r6, 4
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	add	r28, r0, r2				# mr	r28, r2
	sw	r30, 2(r3)
	addi	r3, r3, 3
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 9				# li	r1, 9
	addi	r2, r0, 0				# li	r2, 0
	addi	r5, r0, 0				# li	r5, 0
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 4				# li	r1, 4
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
add_reflection.2931:
	lw	r5, 4(r28)
	lw	r6, 3(r28)
	lw	r7, 2(r28)
	lw	r28, 1(r28)
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	sw	r7, 6(r3)
	sw	r6, 7(r3)
	fmvtr	r30, f4
	sw	r30, 8(r3)				#stfd	f4, 8(r3)
	fmvtr	r30, f3
	sw	r30, 10(r3)				#stfd	f3, 10(r3)
	fmvtr	r30, f2
	sw	r30, 12(r3)				#stfd	f2, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r1)
	lw	r30, 12(r3)				#lfd	f1, 12(r3)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	lw	r30, 8(r3)				#lfd	f3, 8(r3)
	fmvfr	f3, r30
	sw	r1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	vecset.2473				#	bl	vecset.2473
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	lw	r1, 0(r1)
	addi	r2, r0, 1				# li	r2, 1
	sub	r2, r1, r2
	lw	r1, 14(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 3
	lw	r30, 4(r3)				#lfd	f1, 4(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r1)
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
	lw	r5, 3(r28)
	lw	r6, 2(r28)
	lw	r7, 1(r28)
	slli	r1, r1, 2
	lw	r8, 0(r5)
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r2, 7(r2)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 0(r6)
	fmvfr	f2, r30
	sw	r5, 0(r3)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	sw	r8, 4(r3)
	sw	r7, 5(r3)
	sw	r1, 6(r3)
	sw	r6, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	lw	r30, 1(r1)
	fmvfr	f2, r30
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
	lw	r1, 7(r3)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -13
	lw	r30, 12(r3)
	fadd	f4, f0, f1				# fmr	f4, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	addi	r2, r1, 1
	lw	r5, 7(r3)
	lw	r30, 0(r5)
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	lw	r30, 10(r3)				#lfd	f3, 10(r3)
	fmvfr	f3, r30
	lw	r6, 4(r3)
	lw	r28, 5(r3)
	fmvtr	r30, f4
	sw	r30, 12(r3)				#stfd	f4, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	addi	r2, r1, 1
	lw	r5, 6(r3)
	addi	r6, r5, 2
	lw	r7, 7(r3)
	lw	r30, 1(r7)
	fmvfr	f3, r30
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	lw	r30, 12(r3)				#lfd	f4, 12(r3)
	fmvfr	f4, r30
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r6				# mr	r2, r6
	sw	r30, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	addi	r2, r1, 2
	lw	r5, 6(r3)
	addi	r5, r5, 3
	lw	r6, 7(r3)
	lw	r30, 2(r6)
	fmvfr	f4, r30
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	lw	r30, 10(r3)				#lfd	f3, 10(r3)
	fmvfr	f3, r30
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	addi	r1, r1, 3
	lw	r2, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#	blr
setup_surface_reflection.2941:
	lw	r5, 3(r28)
	lw	r6, 2(r28)
	lw	r7, 1(r28)
	slli	r1, r1, 2
	addi	r1, r1, 1
	lw	r8, 0(r5)
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r9, 7(r2)
	lw	r30, 0(r9)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r9, 4(r2)
	sw	r5, 0(r3)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	sw	r1, 4(r3)
	sw	r8, 5(r3)
	sw	r7, 6(r3)
	sw	r6, 7(r3)
	sw	r2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	veciprod.2494				#	bl	veciprod.2494
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f2, r30
	lw	r1, 8(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fmul	f2, f2, f1
	lw	r2, 7(r3)
	lw	r30, 0(r2)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f3, r30
	lw	r5, 4(r1)
	lw	r30, 1(r5)
	fmvfr	f4, r30
	fmul	f3, f3, f4
	fmul	f3, f3, f1
	lw	r30, 1(r2)
	fmvfr	f4, r30
	fsub	f3, f3, f4
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f4, r30
	lw	r1, 4(r1)
	lw	r30, 2(r1)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fmul	f1, f4, f1
	lw	r30, 2(r2)
	fmvfr	f4, r30
	fsub	f4, f1, f4
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	lw	r1, 5(r3)
	lw	r2, 4(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#	blr
setup_reflections.2944:
	lw	r2, 3(r28)
	lw	r5, 2(r28)
	lw	r6, 1(r28)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.10657
	jr	r31				#	blr
ble_then.10657:
	add	r30, r6, r1
	lw	r6, 0(r30)
	lw	r7, 2(r6)
	addi	r8, r0, 2				# li	r8, 2
	beq	r7, r8, beq_then.10659
	jr	r31				#	blr
beq_then.10659:
	lw	r7, 7(r6)
	lw	r30, 0(r7)
	fmvfr	f1, r30
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r6, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.10661
	lw	r2, 3(r3)
	lw	r1, 1(r2)
	addi	r5, r0, 1				# li	r5, 1
	beq	r1, r5, beq_then.10662
	addi	r5, r0, 2				# li	r5, 2
	beq	r1, r5, beq_then.10663
	jr	r31				#	blr
beq_then.10663:
	lw	r1, 1(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10662:
	lw	r1, 1(r3)
	lw	r28, 2(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.10661:
	jr	r31				#	blr
rt.2946:
	lw	r5, 15(r28)
	lw	r6, 14(r28)
	lw	r7, 13(r28)
	lw	r8, 12(r28)
	lw	r9, 11(r28)
	lw	r10, 10(r28)
	lw	r11, 9(r28)
	lw	r12, 8(r28)
	lw	r13, 7(r28)
	lw	r14, 6(r28)
	lw	r15, 5(r28)
	lw	r16, 4(r28)
	lw	r17, 3(r28)
	lw	r18, 2(r28)
	lw	r19, 1(r28)
	sw	r1, 0(r17)
	sw	r2, 1(r17)
	srai	r17, r1, 1
	sw	r17, 0(r18)
	srai	r2, r2, 1
	sw	r2, 1(r18)
	addi	r30, r0, 0
	lui	r30, r30, 17152	# to load float		128.000000
	fmvfr	f1, r30
	sw	r9, 0(r3)
	sw	r11, 1(r3)
	sw	r7, 2(r3)
	sw	r13, 3(r3)
	sw	r15, 4(r3)
	sw	r12, 5(r3)
	sw	r14, 6(r3)
	sw	r6, 7(r3)
	sw	r16, 8(r3)
	sw	r5, 9(r3)
	sw	r10, 10(r3)
	sw	r19, 11(r3)
	sw	r8, 12(r3)
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r1, 12(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r28, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r28, 11(r3)
	sw	r1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r28, 11(r3)
	sw	r1, 17(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r28, 10(r3)
	sw	r1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r28, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r28, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	lw	r2, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	veccpy.2483				#	bl	veccpy.2483
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r2, 0(r1)
	addi	r5, r0, 1				# li	r5, 1
	sub	r2, r2, r5
	lw	r5, 3(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r1, 0(r1)
	addi	r2, r0, 1				# li	r2, 1
	sub	r1, r1, r2
	lw	r28, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	addi	r5, r0, 0				# li	r5, 0
	lw	r1, 17(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	addi	r7, r0, 2				# li	r7, 2
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	lw	r6, 18(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
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
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
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
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
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
	addi	r5, r0, 0				# li	r5, 0
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r2, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
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
	fmvtr	r30, f1
	sw	r30, 2(r6)
	sw	r1, 1(r6)
	sw	r5, 0(r6)
	add	r1, r0, r6				# mr	r1, r6
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
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
	addi	r16, r0, read_and_network.2609
	sw	r16, 0(r15)
	lw	r16, 9(r3)
	sw	r16, 1(r15)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 6
	addi	r18, r0, read_parameter.2611
	sw	r18, 0(r17)
	sw	r2, 5(r17)
	sw	r14, 4(r17)
	sw	r9, 3(r17)
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
	addi	r4, r4, 2
	addi	r18, r0, setup_startp_constants.2711
	sw	r18, 0(r15)
	sw	r13, 1(r15)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 4
	addi	r22, r0, setup_startp.2714
	sw	r22, 0(r18)
	lw	r22, 25(r3)
	sw	r22, 3(r18)
	sw	r15, 2(r18)
	sw	r12, 1(r18)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 2
	addi	r23, r0, check_all_inside.2736
	sw	r23, 0(r15)
	sw	r13, 1(r15)
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
	sw	r15, 1(r23)
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
	lw	r24, 16(r3)
	sw	r24, 2(r20)
	sw	r15, 1(r20)
	sw	r17, 37(r3)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 3
	sw	r9, 38(r3)
	addi	r9, r0, solve_one_or_network.2755
	sw	r9, 0(r17)
	sw	r20, 2(r17)
	sw	r16, 1(r17)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 6
	addi	r20, r0, trace_or_matrix.2759
	sw	r20, 0(r9)
	sw	r26, 5(r9)
	sw	r27, 4(r9)
	sw	r14, 3(r9)
	sw	r19, 2(r9)
	sw	r17, 1(r9)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 4
	addi	r19, r0, judge_intersection.2763
	sw	r19, 0(r17)
	sw	r9, 3(r17)
	sw	r26, 2(r17)
	sw	r2, 1(r17)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 10
	addi	r19, r0, solve_each_element_fast.2765
	sw	r19, 0(r9)
	sw	r26, 9(r9)
	sw	r22, 8(r9)
	sw	r21, 7(r9)
	sw	r14, 6(r9)
	sw	r13, 5(r9)
	sw	r28, 4(r9)
	sw	r25, 3(r9)
	sw	r24, 2(r9)
	sw	r15, 1(r9)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 3
	addi	r19, r0, solve_one_or_network_fast.2769
	sw	r19, 0(r15)
	sw	r9, 2(r15)
	sw	r16, 1(r15)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 5
	addi	r16, r0, trace_or_matrix_fast.2773
	sw	r16, 0(r9)
	sw	r26, 4(r9)
	sw	r21, 3(r9)
	sw	r14, 2(r9)
	sw	r15, 1(r9)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 4
	addi	r15, r0, judge_intersection_fast.2777
	sw	r15, 0(r14)
	sw	r9, 3(r14)
	sw	r26, 2(r14)
	sw	r2, 1(r14)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 3
	addi	r15, r0, get_nvector_rect.2779
	sw	r15, 0(r9)
	lw	r15, 17(r3)
	sw	r15, 2(r9)
	sw	r28, 1(r9)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 2
	addi	r19, r0, get_nvector_plane.2781
	sw	r19, 0(r16)
	sw	r15, 1(r16)
	add	r19, r0, r4				# mr	r19, r4
	addi	r4, r4, 3
	addi	r20, r0, get_nvector_second.2783
	sw	r20, 0(r19)
	sw	r15, 2(r19)
	sw	r25, 1(r19)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 2
	addi	r21, r0, utexture.2788
	sw	r21, 0(r20)
	lw	r21, 18(r3)
	sw	r21, 1(r20)
	add	r22, r0, r4				# mr	r22, r4
	addi	r4, r4, 3
	addi	r12, r0, add_light.2791
	sw	r12, 0(r22)
	sw	r21, 2(r22)
	lw	r12, 20(r3)
	sw	r12, 1(r22)
	add	r7, r0, r4				# mr	r7, r4
	addi	r4, r4, 9
	addi	r6, r0, trace_reflections.2795
	sw	r6, 0(r7)
	sw	r23, 8(r7)
	lw	r6, 36(r3)
	sw	r6, 7(r7)
	sw	r2, 6(r7)
	sw	r15, 5(r7)
	sw	r14, 4(r7)
	sw	r28, 3(r7)
	sw	r24, 2(r7)
	sw	r22, 1(r7)
	add	r6, r0, r4				# mr	r6, r4
	addi	r4, r4, 25
	addi	r8, r0, trace_ray.2800
	sw	r8, 0(r6)
	sw	r20, 24(r6)
	lw	r8, 0(r3)
	sw	r8, 23(r6)
	sw	r7, 22(r6)
	sw	r26, 21(r6)
	sw	r21, 20(r6)
	sw	r27, 19(r6)
	sw	r23, 18(r6)
	sw	r18, 17(r6)
	sw	r12, 16(r6)
	sw	r2, 15(r6)
	sw	r13, 14(r6)
	sw	r15, 13(r6)
	sw	r1, 12(r6)
	sw	r10, 11(r6)
	sw	r17, 10(r6)
	sw	r28, 9(r6)
	sw	r25, 8(r6)
	sw	r24, 7(r6)
	sw	r19, 6(r6)
	sw	r9, 5(r6)
	sw	r16, 4(r6)
	lw	r7, 1(r3)
	sw	r7, 3(r6)
	sw	r11, 2(r6)
	sw	r22, 1(r6)
	add	r8, r0, r4				# mr	r8, r4
	addi	r4, r4, 15
	addi	r11, r0, trace_diffuse_ray.2806
	sw	r11, 0(r8)
	sw	r20, 14(r8)
	sw	r21, 13(r8)
	sw	r23, 12(r8)
	sw	r2, 11(r8)
	sw	r13, 10(r8)
	sw	r15, 9(r8)
	sw	r10, 8(r8)
	sw	r14, 7(r8)
	sw	r25, 6(r8)
	sw	r24, 5(r8)
	sw	r19, 4(r8)
	sw	r9, 3(r8)
	sw	r16, 2(r8)
	lw	r2, 19(r3)
	sw	r2, 1(r8)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r11, r0, iter_trace_diffuse_rays.2809
	sw	r11, 0(r9)
	sw	r8, 1(r9)
	add	r8, r0, r4				# mr	r8, r4
	addi	r4, r4, 4
	addi	r11, r0, trace_diffuse_ray_80percent.2818
	sw	r11, 0(r8)
	sw	r18, 3(r8)
	sw	r9, 2(r8)
	lw	r11, 31(r3)
	sw	r11, 1(r8)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 4
	addi	r15, r0, calc_diffuse_using_1point.2822
	sw	r15, 0(r14)
	sw	r8, 3(r14)
	sw	r12, 2(r14)
	sw	r2, 1(r14)
	add	r8, r0, r4				# mr	r8, r4
	addi	r4, r4, 3
	addi	r15, r0, calc_diffuse_using_5points.2825
	sw	r15, 0(r8)
	sw	r12, 2(r8)
	sw	r2, 1(r8)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 2
	addi	r16, r0, do_without_neighbors.2831
	sw	r16, 0(r15)
	sw	r14, 1(r15)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 2
	addi	r16, r0, neighbors_exist.2834
	sw	r16, 0(r14)
	lw	r16, 21(r3)
	sw	r16, 1(r14)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 3
	addi	r19, r0, try_exploit_neighbors.2847
	sw	r19, 0(r17)
	sw	r15, 2(r17)
	sw	r8, 1(r17)
	add	r8, r0, r4				# mr	r8, r4
	addi	r4, r4, 2
	addi	r19, r0, write_ppm_header.2854
	sw	r19, 0(r8)
	sw	r16, 1(r8)
	add	r19, r0, r4				# mr	r19, r4
	addi	r4, r4, 2
	addi	r20, r0, write_rgb.2858
	sw	r20, 0(r19)
	sw	r12, 1(r19)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 5
	addi	r21, r0, pretrace_diffuse_rays.2860
	sw	r21, 0(r20)
	sw	r18, 4(r20)
	sw	r9, 3(r20)
	sw	r11, 2(r20)
	sw	r2, 1(r20)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 11
	addi	r9, r0, pretrace_pixels.2863
	sw	r9, 0(r2)
	sw	r5, 10(r2)
	sw	r6, 9(r2)
	sw	r27, 8(r2)
	lw	r5, 26(r3)
	sw	r5, 7(r2)
	lw	r5, 23(r3)
	sw	r5, 6(r2)
	sw	r12, 5(r2)
	lw	r6, 29(r3)
	sw	r6, 4(r2)
	sw	r20, 3(r2)
	lw	r6, 22(r3)
	sw	r6, 2(r2)
	sw	r7, 1(r2)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 7
	addi	r18, r0, pretrace_line.2870
	sw	r18, 0(r9)
	lw	r18, 28(r3)
	sw	r18, 6(r9)
	lw	r18, 27(r3)
	sw	r18, 5(r9)
	sw	r5, 4(r9)
	sw	r2, 3(r9)
	sw	r16, 2(r9)
	sw	r6, 1(r9)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 7
	addi	r18, r0, scan_pixel.2874
	sw	r18, 0(r2)
	sw	r19, 6(r2)
	sw	r17, 5(r2)
	sw	r12, 4(r2)
	sw	r14, 3(r2)
	sw	r16, 2(r2)
	sw	r15, 1(r2)
	add	r12, r0, r4				# mr	r12, r4
	addi	r4, r4, 4
	addi	r14, r0, scan_line.2880
	sw	r14, 0(r12)
	sw	r2, 3(r12)
	sw	r9, 2(r12)
	sw	r16, 1(r12)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	addi	r14, r0, create_pixel.2888
	sw	r14, 0(r2)
	sw	r7, 1(r2)
	add	r7, r0, r4				# mr	r7, r4
	addi	r4, r4, 2
	addi	r14, r0, init_line_elements.2890
	sw	r14, 0(r7)
	sw	r2, 1(r7)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 4
	addi	r15, r0, create_pixelline.2893
	sw	r15, 0(r14)
	sw	r7, 3(r14)
	sw	r16, 2(r14)
	sw	r2, 1(r14)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	addi	r7, r0, calc_dirvec.2900
	sw	r7, 0(r2)
	sw	r11, 1(r2)
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
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 2
	addi	r18, r0, create_dirvec_elements.2919
	sw	r18, 0(r17)
	sw	r7, 1(r17)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 4
	addi	r19, r0, create_dirvecs.2922
	sw	r19, 0(r18)
	sw	r11, 3(r18)
	sw	r17, 2(r18)
	sw	r7, 1(r18)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 3
	addi	r19, r0, init_dirvec_constants.2924
	sw	r19, 0(r17)
	sw	r15, 2(r17)
	lw	r19, 38(r3)
	sw	r19, 1(r17)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 3
	addi	r21, r0, init_vecset_constants.2927
	sw	r21, 0(r20)
	sw	r17, 2(r20)
	sw	r11, 1(r20)
	add	r11, r0, r4				# mr	r11, r4
	addi	r4, r4, 4
	addi	r17, r0, init_dirvecs.2929
	sw	r17, 0(r11)
	sw	r20, 3(r11)
	sw	r18, 2(r11)
	sw	r2, 1(r11)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 5
	addi	r17, r0, add_reflection.2931
	sw	r17, 0(r2)
	lw	r17, 36(r3)
	sw	r17, 4(r2)
	sw	r15, 3(r2)
	sw	r19, 2(r2)
	sw	r7, 1(r2)
	add	r7, r0, r4				# mr	r7, r4
	addi	r4, r4, 4
	addi	r17, r0, setup_rect_reflection.2938
	sw	r17, 0(r7)
	sw	r1, 3(r7)
	sw	r10, 2(r7)
	sw	r2, 1(r7)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 4
	addi	r18, r0, setup_surface_reflection.2941
	sw	r18, 0(r17)
	sw	r1, 3(r17)
	sw	r10, 2(r17)
	sw	r2, 1(r17)
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 4
	addi	r2, r0, setup_reflections.2944
	sw	r2, 0(r1)
	sw	r17, 3(r1)
	sw	r7, 2(r1)
	sw	r13, 1(r1)
	add	r28, r0, r4				# mr	r28, r4
	addi	r4, r4, 16
	addi	r2, r0, rt.2946
	sw	r2, 0(r28)
	sw	r8, 15(r28)
	lw	r2, 33(r3)
	sw	r2, 14(r28)
	sw	r1, 13(r28)
	sw	r5, 12(r28)
	sw	r12, 11(r28)
	lw	r1, 37(r3)
	sw	r1, 10(r28)
	sw	r9, 9(r28)
	sw	r15, 8(r28)
	lw	r1, 34(r3)
	sw	r1, 7(r28)
	sw	r10, 6(r28)
	sw	r19, 5(r28)
	sw	r11, 4(r28)
	sw	r16, 3(r28)
	sw	r6, 2(r28)
	sw	r14, 1(r28)
	addi	r1, r0, 128				# li	r1, 128
	addi	r2, r0, 128				# li	r2, 128
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 39(r3)
	addi	r3, r3, 40
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -40
	lw	r30, 39(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	_R_0, r0, 0				# li	_R_0, 0
