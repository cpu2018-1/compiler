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
	addi	r30, r0, 62915
	lui	r30, r30, 16456	# to load float		3.140000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 0(r3)
	addi	r3, r3, 1
	jal	lib_floor				#	bl	lib_floor
	addi	r3, r3, -1
	lw	r30, 0(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 0(r3)
	addi	r3, r3, 1
	jal	lib_print_float				#	bl	lib_print_float
	addi	r3, r3, -1
	lw	r30, 0(r3)
	add	r31, r0, r30				#mtlr	r30
