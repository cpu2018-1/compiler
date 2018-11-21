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
	beq	r1, r2, beq_then.30159
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
	beq	r5, r2, beq_then.30160
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
	j	beq_cont.30161
beq_then.30160:
beq_cont.30161:
	addi	r2, r0, 2				# li	r2, 2
	lw	r5, 3(r3)
	beq	r5, r2, beq_then.30162
	lw	r2, 8(r3)
	j	beq_cont.30163
beq_then.30162:
	addi	r2, r0, 1				# li	r2, 1
beq_cont.30163:
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
	beq	r7, r2, beq_then.30164
	addi	r2, r0, 2				# li	r2, 2
	beq	r7, r2, beq_then.30166
	j	beq_cont.30167
beq_then.30166:
	addi	r2, r0, 0				# li	r2, 0
	lw	r7, 8(r3)
	beq	r7, r2, beq_then.30168
	addi	r2, r0, 0				# li	r2, 0
	j	beq_cont.30169
beq_then.30168:
	addi	r2, r0, 1				# li	r2, 1
beq_cont.30169:
	lw	r30, 0(r5)
	fmvfr	f1, r30
	sw	r2, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	lw	r30, 1(r1)
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
	fadd	f1, f2, f1
	lw	r1, 6(r3)
	lw	r30, 2(r1)
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
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
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
	beq	r1, r2, beq_then.30170
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	j	beq_cont.30171
beq_then.30170:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 13(r3)
	beq	r2, r1, beq_then.30172
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	j	beq_cont.30173
beq_then.30172:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
beq_cont.30173:
beq_cont.30171:
	lw	r1, 6(r3)
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
beq_cont.30167:
	j	beq_cont.30165
beq_then.30164:
	lw	r30, 0(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30174
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.30175
beq_then.30174:
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30176
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.30177
beq_then.30176:
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30178
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	j	beq_cont.30179
beq_then.30178:
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
beq_cont.30179:
beq_cont.30177:
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
beq_cont.30175:
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 24(r3)				#stfd	f1, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30180
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.30181
beq_then.30180:
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30182
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.30183
beq_then.30182:
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30184
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	j	beq_cont.30185
beq_then.30184:
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
beq_cont.30185:
beq_cont.30183:
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 26(r3)				#stfd	f1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
beq_cont.30181:
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30186
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.30187
beq_then.30186:
	lw	r30, 28(r3)				#lfd	f1, 28(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30188
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.30189
beq_then.30188:
	lw	r30, 28(r3)				#lfd	f1, 28(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30190
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	j	beq_cont.30191
beq_then.30190:
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
beq_cont.30191:
beq_cont.30189:
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
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
	fdiv	f1, f2, f1
beq_cont.30187:
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
beq_cont.30165:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 5(r3)
	beq	r2, r1, beq_then.30192
	lw	r1, 6(r3)
	lw	r2, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	rotate_quadratic_matrix.2596				#	bl	rotate_quadratic_matrix.2596
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30193
beq_then.30192:
beq_cont.30193:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30159:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
read_object.2601:
	lw	r2, 2(r28)
	lw	r5, 1(r28)
	addi	r6, r0, 60				# li	r6, 60
	ble	r6, r1, ble_then.30194
	sw	r28, 0(r3)
	sw	r2, 1(r3)
	sw	r5, 2(r3)
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r28, r0, r2				# mr	r28, r2
	sw	r30, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30195
	lw	r1, 3(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60				# li	r2, 60
	ble	r2, r1, ble_then.30196
	lw	r28, 1(r3)
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30197
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60				# li	r2, 60
	ble	r2, r1, ble_then.30198
	lw	r28, 1(r3)
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30199
	lw	r1, 5(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60				# li	r2, 60
	ble	r2, r1, ble_then.30200
	lw	r28, 1(r3)
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30201
	lw	r1, 6(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60				# li	r2, 60
	ble	r2, r1, ble_then.30202
	lw	r28, 1(r3)
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30203
	lw	r1, 7(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60				# li	r2, 60
	ble	r2, r1, ble_then.30204
	lw	r28, 1(r3)
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30205
	lw	r1, 8(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60				# li	r2, 60
	ble	r2, r1, ble_then.30206
	lw	r28, 1(r3)
	sw	r1, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30207
	lw	r1, 9(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60				# li	r2, 60
	ble	r2, r1, ble_then.30208
	lw	r28, 1(r3)
	sw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30209
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.30209:
	lw	r1, 2(r3)
	lw	r2, 10(r3)
	sw	r2, 0(r1)
	jr	r31				#	blr
ble_then.30208:
	jr	r31				#	blr
beq_then.30207:
	lw	r1, 2(r3)
	lw	r2, 9(r3)
	sw	r2, 0(r1)
	jr	r31				#	blr
ble_then.30206:
	jr	r31				#	blr
beq_then.30205:
	lw	r1, 2(r3)
	lw	r2, 8(r3)
	sw	r2, 0(r1)
	jr	r31				#	blr
ble_then.30204:
	jr	r31				#	blr
beq_then.30203:
	lw	r1, 2(r3)
	lw	r2, 7(r3)
	sw	r2, 0(r1)
	jr	r31				#	blr
ble_then.30202:
	jr	r31				#	blr
beq_then.30201:
	lw	r1, 2(r3)
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	jr	r31				#	blr
ble_then.30200:
	jr	r31				#	blr
beq_then.30199:
	lw	r1, 2(r3)
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	jr	r31				#	blr
ble_then.30198:
	jr	r31				#	blr
beq_then.30197:
	lw	r1, 2(r3)
	lw	r2, 4(r3)
	sw	r2, 0(r1)
	jr	r31				#	blr
ble_then.30196:
	jr	r31				#	blr
beq_then.30195:
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	jr	r31				#	blr
ble_then.30194:
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
	beq	r1, r2, beq_then.30226
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30227
	lw	r2, 2(r3)
	addi	r5, r2, 1
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30229
	lw	r2, 4(r3)
	addi	r5, r2, 1
	sw	r1, 5(r3)
	sw	r5, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30231
	lw	r2, 6(r3)
	addi	r5, r2, 1
	sw	r1, 7(r3)
	sw	r5, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30233
	lw	r2, 8(r3)
	addi	r5, r2, 1
	sw	r1, 9(r3)
	sw	r5, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30235
	lw	r2, 10(r3)
	addi	r5, r2, 1
	sw	r1, 11(r3)
	sw	r5, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30237
	lw	r2, 12(r3)
	addi	r5, r2, 1
	sw	r1, 13(r3)
	sw	r5, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30239
	lw	r2, 14(r3)
	addi	r5, r2, 1
	sw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 14(r3)
	lw	r5, 15(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.30240
beq_then.30239:
	lw	r1, 14(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30240:
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.30238
beq_then.30237:
	lw	r1, 12(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30238:
	lw	r2, 10(r3)
	lw	r5, 11(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.30236
beq_then.30235:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30236:
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.30234
beq_then.30233:
	lw	r1, 8(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30234:
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.30232
beq_then.30231:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30232:
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.30230
beq_then.30229:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30230:
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.30228
beq_then.30227:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30228:
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#	blr
beq_then.30226:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1				# li	r2, -1
	j	lib_create_array
read_or_network.2607:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30241
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30243
	sw	r1, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30245
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30247
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30249
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30251
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30253
	addi	r2, r0, 7				# li	r2, 7
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 7(r3)
	sw	r2, 6(r1)
	j	beq_cont.30254
beq_then.30253:
	addi	r1, r0, 7				# li	r1, 7
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30254:
	lw	r2, 6(r3)
	sw	r2, 5(r1)
	j	beq_cont.30252
beq_then.30251:
	addi	r1, r0, 6				# li	r1, 6
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30252:
	lw	r2, 5(r3)
	sw	r2, 4(r1)
	j	beq_cont.30250
beq_then.30249:
	addi	r1, r0, 5				# li	r1, 5
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30250:
	lw	r2, 4(r3)
	sw	r2, 3(r1)
	j	beq_cont.30248
beq_then.30247:
	addi	r1, r0, 4				# li	r1, 4
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30248:
	lw	r2, 3(r3)
	sw	r2, 2(r1)
	j	beq_cont.30246
beq_then.30245:
	addi	r1, r0, 3				# li	r1, 3
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30246:
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.30244
beq_then.30243:
	addi	r1, r0, 2				# li	r1, 2
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30244:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1				# mr	r2, r1
	j	beq_cont.30242
beq_then.30241:
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
beq_cont.30242:
	lw	r1, 0(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.30255
	lw	r1, 0(r3)
	addi	r5, r1, 1
	sw	r2, 8(r3)
	sw	r5, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30256
	sw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30258
	sw	r1, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30260
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30262
	sw	r1, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30264
	sw	r1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30266
	addi	r2, r0, 6				# li	r2, 6
	sw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 15(r3)
	sw	r2, 5(r1)
	j	beq_cont.30267
beq_then.30266:
	addi	r1, r0, 6				# li	r1, 6
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30267:
	lw	r2, 14(r3)
	sw	r2, 4(r1)
	j	beq_cont.30265
beq_then.30264:
	addi	r1, r0, 5				# li	r1, 5
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30265:
	lw	r2, 13(r3)
	sw	r2, 3(r1)
	j	beq_cont.30263
beq_then.30262:
	addi	r1, r0, 4				# li	r1, 4
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30263:
	lw	r2, 12(r3)
	sw	r2, 2(r1)
	j	beq_cont.30261
beq_then.30260:
	addi	r1, r0, 3				# li	r1, 3
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30261:
	lw	r2, 11(r3)
	sw	r2, 1(r1)
	j	beq_cont.30259
beq_then.30258:
	addi	r1, r0, 2				# li	r1, 2
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30259:
	lw	r2, 10(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1				# mr	r2, r1
	j	beq_cont.30257
beq_then.30256:
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
beq_cont.30257:
	lw	r1, 0(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.30268
	lw	r1, 9(r3)
	addi	r5, r1, 1
	sw	r2, 16(r3)
	sw	r5, 17(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30270
	sw	r1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30272
	sw	r1, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30274
	sw	r1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30276
	sw	r1, 21(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30278
	addi	r2, r0, 5				# li	r2, 5
	sw	r1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 22(r3)
	sw	r2, 4(r1)
	j	beq_cont.30279
beq_then.30278:
	addi	r1, r0, 5				# li	r1, 5
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30279:
	lw	r2, 21(r3)
	sw	r2, 3(r1)
	j	beq_cont.30277
beq_then.30276:
	addi	r1, r0, 4				# li	r1, 4
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30277:
	lw	r2, 20(r3)
	sw	r2, 2(r1)
	j	beq_cont.30275
beq_then.30274:
	addi	r1, r0, 3				# li	r1, 3
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30275:
	lw	r2, 19(r3)
	sw	r2, 1(r1)
	j	beq_cont.30273
beq_then.30272:
	addi	r1, r0, 2				# li	r1, 2
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30273:
	lw	r2, 18(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1				# mr	r2, r1
	j	beq_cont.30271
beq_then.30270:
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
beq_cont.30271:
	lw	r1, 0(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.30280
	lw	r1, 17(r3)
	addi	r5, r1, 1
	sw	r2, 23(r3)
	sw	r5, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 25(r3)
	addi	r3, r3, 26
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -26
	lw	r30, 25(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30282
	sw	r1, 25(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30284
	sw	r1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 27(r3)
	addi	r3, r3, 28
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -28
	lw	r30, 27(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30286
	sw	r1, 27(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30288
	addi	r2, r0, 4				# li	r2, 4
	sw	r1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 29(r3)
	addi	r3, r3, 30
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -30
	lw	r30, 29(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 28(r3)
	sw	r2, 3(r1)
	j	beq_cont.30289
beq_then.30288:
	addi	r1, r0, 4				# li	r1, 4
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 29(r3)
	addi	r3, r3, 30
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -30
	lw	r30, 29(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30289:
	lw	r2, 27(r3)
	sw	r2, 2(r1)
	j	beq_cont.30287
beq_then.30286:
	addi	r1, r0, 3				# li	r1, 3
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 29(r3)
	addi	r3, r3, 30
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -30
	lw	r30, 29(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30287:
	lw	r2, 26(r3)
	sw	r2, 1(r1)
	j	beq_cont.30285
beq_then.30284:
	addi	r1, r0, 2				# li	r1, 2
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 29(r3)
	addi	r3, r3, 30
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -30
	lw	r30, 29(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30285:
	lw	r2, 25(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1				# mr	r2, r1
	j	beq_cont.30283
beq_then.30282:
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 29(r3)
	addi	r3, r3, 30
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -30
	lw	r30, 29(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
beq_cont.30283:
	lw	r1, 0(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.30290
	lw	r1, 24(r3)
	addi	r5, r1, 1
	sw	r2, 29(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	read_or_network.2607				#	bl	read_or_network.2607
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 24(r3)
	lw	r5, 29(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.30291
beq_then.30290:
	lw	r1, 24(r3)
	addi	r1, r1, 1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30291:
	lw	r2, 17(r3)
	lw	r5, 23(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.30281
beq_then.30280:
	lw	r1, 17(r3)
	addi	r1, r1, 1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30281:
	lw	r2, 9(r3)
	lw	r5, 16(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.30269
beq_then.30268:
	lw	r1, 9(r3)
	addi	r1, r1, 1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30269:
	lw	r2, 0(r3)
	lw	r5, 8(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#	blr
beq_then.30255:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.2609:
	lw	r2, 1(r28)
	sw	r28, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30292
	sw	r1, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30294
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30296
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30298
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30300
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30302
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30304
	addi	r2, r0, 7				# li	r2, 7
	sw	r1, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 9(r3)
	sw	r2, 6(r1)
	j	beq_cont.30305
beq_then.30304:
	addi	r1, r0, 7				# li	r1, 7
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30305:
	lw	r2, 8(r3)
	sw	r2, 5(r1)
	j	beq_cont.30303
beq_then.30302:
	addi	r1, r0, 6				# li	r1, 6
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30303:
	lw	r2, 7(r3)
	sw	r2, 4(r1)
	j	beq_cont.30301
beq_then.30300:
	addi	r1, r0, 5				# li	r1, 5
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30301:
	lw	r2, 6(r3)
	sw	r2, 3(r1)
	j	beq_cont.30299
beq_then.30298:
	addi	r1, r0, 4				# li	r1, 4
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30299:
	lw	r2, 5(r3)
	sw	r2, 2(r1)
	j	beq_cont.30297
beq_then.30296:
	addi	r1, r0, 3				# li	r1, 3
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30297:
	lw	r2, 4(r3)
	sw	r2, 1(r1)
	j	beq_cont.30295
beq_then.30294:
	addi	r1, r0, 2				# li	r1, 2
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30295:
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	j	beq_cont.30293
beq_then.30292:
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30293:
	lw	r2, 0(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.30306
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	sw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30307
	sw	r1, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30309
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30311
	sw	r1, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30313
	sw	r1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30315
	sw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30317
	addi	r2, r0, 6				# li	r2, 6
	sw	r1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 16(r3)
	sw	r2, 5(r1)
	j	beq_cont.30318
beq_then.30317:
	addi	r1, r0, 6				# li	r1, 6
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30318:
	lw	r2, 15(r3)
	sw	r2, 4(r1)
	j	beq_cont.30316
beq_then.30315:
	addi	r1, r0, 5				# li	r1, 5
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30316:
	lw	r2, 14(r3)
	sw	r2, 3(r1)
	j	beq_cont.30314
beq_then.30313:
	addi	r1, r0, 4				# li	r1, 4
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30314:
	lw	r2, 13(r3)
	sw	r2, 2(r1)
	j	beq_cont.30312
beq_then.30311:
	addi	r1, r0, 3				# li	r1, 3
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30312:
	lw	r2, 12(r3)
	sw	r2, 1(r1)
	j	beq_cont.30310
beq_then.30309:
	addi	r1, r0, 2				# li	r1, 2
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30310:
	lw	r2, 11(r3)
	sw	r2, 0(r1)
	j	beq_cont.30308
beq_then.30307:
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30308:
	lw	r2, 0(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.30319
	lw	r2, 10(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	sw	r1, 17(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30320
	sw	r1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30322
	sw	r1, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30324
	sw	r1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30326
	sw	r1, 21(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30328
	addi	r2, r0, 5				# li	r2, 5
	sw	r1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 22(r3)
	sw	r2, 4(r1)
	j	beq_cont.30329
beq_then.30328:
	addi	r1, r0, 5				# li	r1, 5
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30329:
	lw	r2, 21(r3)
	sw	r2, 3(r1)
	j	beq_cont.30327
beq_then.30326:
	addi	r1, r0, 4				# li	r1, 4
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30327:
	lw	r2, 20(r3)
	sw	r2, 2(r1)
	j	beq_cont.30325
beq_then.30324:
	addi	r1, r0, 3				# li	r1, 3
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30325:
	lw	r2, 19(r3)
	sw	r2, 1(r1)
	j	beq_cont.30323
beq_then.30322:
	addi	r1, r0, 2				# li	r1, 2
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30323:
	lw	r2, 18(r3)
	sw	r2, 0(r1)
	j	beq_cont.30321
beq_then.30320:
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30321:
	lw	r2, 0(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.30330
	lw	r2, 17(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	sw	r1, 23(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30331
	sw	r1, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 25(r3)
	addi	r3, r3, 26
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -26
	lw	r30, 25(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30333
	sw	r1, 25(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30335
	sw	r1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 27(r3)
	addi	r3, r3, 28
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -28
	lw	r30, 27(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30337
	addi	r2, r0, 4				# li	r2, 4
	sw	r1, 27(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 27(r3)
	sw	r2, 3(r1)
	j	beq_cont.30338
beq_then.30337:
	addi	r1, r0, 4				# li	r1, 4
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30338:
	lw	r2, 26(r3)
	sw	r2, 2(r1)
	j	beq_cont.30336
beq_then.30335:
	addi	r1, r0, 3				# li	r1, 3
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30336:
	lw	r2, 25(r3)
	sw	r2, 1(r1)
	j	beq_cont.30334
beq_then.30333:
	addi	r1, r0, 2				# li	r1, 2
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30334:
	lw	r2, 24(r3)
	sw	r2, 0(r1)
	j	beq_cont.30332
beq_then.30331:
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30332:
	lw	r2, 0(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.30339
	lw	r2, 23(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.30339:
	jr	r31				#	blr
beq_then.30330:
	jr	r31				#	blr
beq_then.30319:
	jr	r31				#	blr
beq_then.30306:
	jr	r31				#	blr
read_parameter.2611:
	lw	r1, 9(r28)
	lw	r2, 8(r28)
	lw	r5, 7(r28)
	lw	r6, 6(r28)
	lw	r7, 5(r28)
	lw	r8, 4(r28)
	lw	r9, 3(r28)
	lw	r10, 2(r28)
	lw	r11, 1(r28)
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r11, 2(r3)
	sw	r2, 3(r3)
	sw	r8, 4(r3)
	sw	r5, 5(r3)
	sw	r10, 6(r3)
	sw	r9, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r28, r0, r1				# mr	r28, r1
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 64053
	lui	r30, r30, 15502	# to load float		0.017453
	fmvfr	f2, r30
	fmul	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_sin				#	bl	lib_sin
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 64053
	lui	r30, r30, 15502	# to load float		0.017453
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_cos				#	bl	lib_cos
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
	jal	lib_sin				#	bl	lib_sin
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 7(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 10(r3)				#lfd	f1, 10(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_cos				#	bl	lib_cos
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 7(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 0				# li	r1, 0
	lw	r28, 5(r3)
	sw	r1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30344
	addi	r1, r0, 1				# li	r1, 1
	lw	r28, 5(r3)
	sw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30346
	addi	r1, r0, 2				# li	r1, 2
	lw	r28, 5(r3)
	sw	r1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30348
	addi	r1, r0, 3				# li	r1, 3
	lw	r28, 5(r3)
	sw	r1, 17(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30350
	addi	r1, r0, 4				# li	r1, 4
	lw	r28, 5(r3)
	sw	r1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30352
	addi	r1, r0, 5				# li	r1, 5
	lw	r28, 5(r3)
	sw	r1, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30354
	addi	r1, r0, 6				# li	r1, 6
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30355
beq_then.30354:
	lw	r1, 4(r3)
	lw	r2, 19(r3)
	sw	r2, 0(r1)
beq_cont.30355:
	j	beq_cont.30353
beq_then.30352:
	lw	r1, 4(r3)
	lw	r2, 18(r3)
	sw	r2, 0(r1)
beq_cont.30353:
	j	beq_cont.30351
beq_then.30350:
	lw	r1, 4(r3)
	lw	r2, 17(r3)
	sw	r2, 0(r1)
beq_cont.30351:
	j	beq_cont.30349
beq_then.30348:
	lw	r1, 4(r3)
	lw	r2, 16(r3)
	sw	r2, 0(r1)
beq_cont.30349:
	j	beq_cont.30347
beq_then.30346:
	lw	r1, 4(r3)
	lw	r2, 15(r3)
	sw	r2, 0(r1)
beq_cont.30347:
	j	beq_cont.30345
beq_then.30344:
	lw	r1, 4(r3)
	lw	r2, 14(r3)
	sw	r2, 0(r1)
beq_cont.30345:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30356
	sw	r1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30358
	sw	r1, 21(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30360
	sw	r1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30362
	sw	r1, 23(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30364
	sw	r1, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 25(r3)
	addi	r3, r3, 26
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -26
	lw	r30, 25(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30366
	addi	r2, r0, 6				# li	r2, 6
	sw	r1, 25(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 25(r3)
	sw	r2, 5(r1)
	j	beq_cont.30367
beq_then.30366:
	addi	r1, r0, 6				# li	r1, 6
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30367:
	lw	r2, 24(r3)
	sw	r2, 4(r1)
	j	beq_cont.30365
beq_then.30364:
	addi	r1, r0, 5				# li	r1, 5
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30365:
	lw	r2, 23(r3)
	sw	r2, 3(r1)
	j	beq_cont.30363
beq_then.30362:
	addi	r1, r0, 4				# li	r1, 4
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30363:
	lw	r2, 22(r3)
	sw	r2, 2(r1)
	j	beq_cont.30361
beq_then.30360:
	addi	r1, r0, 3				# li	r1, 3
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30361:
	lw	r2, 21(r3)
	sw	r2, 1(r1)
	j	beq_cont.30359
beq_then.30358:
	addi	r1, r0, 2				# li	r1, 2
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30359:
	lw	r2, 20(r3)
	sw	r2, 0(r1)
	j	beq_cont.30357
beq_then.30356:
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30357:
	lw	r2, 0(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.30368
	lw	r2, 2(r3)
	sw	r1, 0(r2)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30370
	sw	r1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 27(r3)
	addi	r3, r3, 28
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -28
	lw	r30, 27(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30372
	sw	r1, 27(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30374
	sw	r1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 29(r3)
	addi	r3, r3, 30
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -30
	lw	r30, 29(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30376
	sw	r1, 29(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30378
	addi	r2, r0, 5				# li	r2, 5
	sw	r1, 30(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 31(r3)
	addi	r3, r3, 32
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -32
	lw	r30, 31(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 30(r3)
	sw	r2, 4(r1)
	j	beq_cont.30379
beq_then.30378:
	addi	r1, r0, 5				# li	r1, 5
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r30, 31(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30379:
	lw	r2, 29(r3)
	sw	r2, 3(r1)
	j	beq_cont.30377
beq_then.30376:
	addi	r1, r0, 4				# li	r1, 4
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r30, 31(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30377:
	lw	r2, 28(r3)
	sw	r2, 2(r1)
	j	beq_cont.30375
beq_then.30374:
	addi	r1, r0, 3				# li	r1, 3
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r30, 31(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30375:
	lw	r2, 27(r3)
	sw	r2, 1(r1)
	j	beq_cont.30373
beq_then.30372:
	addi	r1, r0, 2				# li	r1, 2
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r30, 31(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30373:
	lw	r2, 26(r3)
	sw	r2, 0(r1)
	j	beq_cont.30371
beq_then.30370:
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r30, 31(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30371:
	lw	r2, 0(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.30380
	lw	r2, 2(r3)
	sw	r1, 1(r2)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 31(r3)
	addi	r3, r3, 32
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -32
	lw	r30, 31(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30382
	sw	r1, 31(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30384
	sw	r1, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 33(r3)
	addi	r3, r3, 34
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30386
	sw	r1, 33(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30388
	addi	r2, r0, 4				# li	r2, 4
	sw	r1, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 35(r3)
	addi	r3, r3, 36
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -36
	lw	r30, 35(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 34(r3)
	sw	r2, 3(r1)
	j	beq_cont.30389
beq_then.30388:
	addi	r1, r0, 4				# li	r1, 4
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 35(r3)
	addi	r3, r3, 36
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -36
	lw	r30, 35(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30389:
	lw	r2, 33(r3)
	sw	r2, 2(r1)
	j	beq_cont.30387
beq_then.30386:
	addi	r1, r0, 3				# li	r1, 3
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 35(r3)
	addi	r3, r3, 36
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -36
	lw	r30, 35(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30387:
	lw	r2, 32(r3)
	sw	r2, 1(r1)
	j	beq_cont.30385
beq_then.30384:
	addi	r1, r0, 2				# li	r1, 2
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 35(r3)
	addi	r3, r3, 36
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -36
	lw	r30, 35(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30385:
	lw	r2, 31(r3)
	sw	r2, 0(r1)
	j	beq_cont.30383
beq_then.30382:
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 35(r3)
	addi	r3, r3, 36
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -36
	lw	r30, 35(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30383:
	lw	r2, 0(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.30390
	lw	r2, 2(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 35(r3)
	addi	r3, r3, 36
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -36
	lw	r30, 35(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30391
beq_then.30390:
beq_cont.30391:
	j	beq_cont.30381
beq_then.30380:
beq_cont.30381:
	j	beq_cont.30369
beq_then.30368:
beq_cont.30369:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 35(r3)
	addi	r3, r3, 36
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -36
	lw	r30, 35(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30392
	sw	r1, 35(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30394
	sw	r1, 36(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 37(r3)
	addi	r3, r3, 38
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -38
	lw	r30, 37(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30396
	sw	r1, 37(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30398
	sw	r1, 38(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 39(r3)
	addi	r3, r3, 40
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -40
	lw	r30, 39(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30400
	sw	r1, 39(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30402
	addi	r2, r0, 6				# li	r2, 6
	sw	r1, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 41(r3)
	addi	r3, r3, 42
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 40(r3)
	sw	r2, 5(r1)
	j	beq_cont.30403
beq_then.30402:
	addi	r1, r0, 6				# li	r1, 6
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 41(r3)
	addi	r3, r3, 42
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30403:
	lw	r2, 39(r3)
	sw	r2, 4(r1)
	j	beq_cont.30401
beq_then.30400:
	addi	r1, r0, 5				# li	r1, 5
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 41(r3)
	addi	r3, r3, 42
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30401:
	lw	r2, 38(r3)
	sw	r2, 3(r1)
	j	beq_cont.30399
beq_then.30398:
	addi	r1, r0, 4				# li	r1, 4
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 41(r3)
	addi	r3, r3, 42
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30399:
	lw	r2, 37(r3)
	sw	r2, 2(r1)
	j	beq_cont.30397
beq_then.30396:
	addi	r1, r0, 3				# li	r1, 3
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 41(r3)
	addi	r3, r3, 42
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30397:
	lw	r2, 36(r3)
	sw	r2, 1(r1)
	j	beq_cont.30395
beq_then.30394:
	addi	r1, r0, 2				# li	r1, 2
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 41(r3)
	addi	r3, r3, 42
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30395:
	lw	r2, 35(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1				# mr	r2, r1
	j	beq_cont.30393
beq_then.30392:
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 41(r3)
	addi	r3, r3, 42
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
beq_cont.30393:
	lw	r1, 0(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.30404
	sw	r2, 41(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30406
	sw	r1, 42(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 43(r3)
	addi	r3, r3, 44
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30408
	sw	r1, 43(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30410
	sw	r1, 44(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 45(r3)
	addi	r3, r3, 46
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -46
	lw	r30, 45(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30412
	sw	r1, 45(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30414
	addi	r2, r0, 5				# li	r2, 5
	sw	r1, 46(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 47(r3)
	addi	r3, r3, 48
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 46(r3)
	sw	r2, 4(r1)
	j	beq_cont.30415
beq_then.30414:
	addi	r1, r0, 5				# li	r1, 5
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 47(r3)
	addi	r3, r3, 48
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30415:
	lw	r2, 45(r3)
	sw	r2, 3(r1)
	j	beq_cont.30413
beq_then.30412:
	addi	r1, r0, 4				# li	r1, 4
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 47(r3)
	addi	r3, r3, 48
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30413:
	lw	r2, 44(r3)
	sw	r2, 2(r1)
	j	beq_cont.30411
beq_then.30410:
	addi	r1, r0, 3				# li	r1, 3
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 47(r3)
	addi	r3, r3, 48
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30411:
	lw	r2, 43(r3)
	sw	r2, 1(r1)
	j	beq_cont.30409
beq_then.30408:
	addi	r1, r0, 2				# li	r1, 2
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 47(r3)
	addi	r3, r3, 48
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30409:
	lw	r2, 42(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1				# mr	r2, r1
	j	beq_cont.30407
beq_then.30406:
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 47(r3)
	addi	r3, r3, 48
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
beq_cont.30407:
	lw	r1, 0(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.30416
	sw	r2, 47(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30418
	sw	r1, 48(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 49(r3)
	addi	r3, r3, 50
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -50
	lw	r30, 49(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30420
	sw	r1, 49(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30422
	sw	r1, 50(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 51(r3)
	addi	r3, r3, 52
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -52
	lw	r30, 51(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, -1				# li	r2, -1
	beq	r1, r2, beq_then.30424
	addi	r2, r0, 4				# li	r2, 4
	sw	r1, 51(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	read_net_item.2605				#	bl	read_net_item.2605
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 51(r3)
	sw	r2, 3(r1)
	j	beq_cont.30425
beq_then.30424:
	addi	r1, r0, 4				# li	r1, 4
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30425:
	lw	r2, 50(r3)
	sw	r2, 2(r1)
	j	beq_cont.30423
beq_then.30422:
	addi	r1, r0, 3				# li	r1, 3
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30423:
	lw	r2, 49(r3)
	sw	r2, 1(r1)
	j	beq_cont.30421
beq_then.30420:
	addi	r1, r0, 2				# li	r1, 2
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30421:
	lw	r2, 48(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1				# mr	r2, r1
	j	beq_cont.30419
beq_then.30418:
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, -1				# li	r2, -1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
beq_cont.30419:
	lw	r1, 0(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.30426
	addi	r1, r0, 3				# li	r1, 3
	sw	r2, 52(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 53(r3)
	addi	r3, r3, 54
	jal	read_or_network.2607				#	bl	read_or_network.2607
	addi	r3, r3, -54
	lw	r30, 53(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 52(r3)
	sw	r2, 2(r1)
	j	beq_cont.30427
beq_then.30426:
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 53(r3)
	addi	r3, r3, 54
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -54
	lw	r30, 53(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30427:
	lw	r2, 47(r3)
	sw	r2, 1(r1)
	j	beq_cont.30417
beq_then.30416:
	addi	r1, r0, 2				# li	r1, 2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 53(r3)
	addi	r3, r3, 54
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -54
	lw	r30, 53(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30417:
	lw	r2, 41(r3)
	sw	r2, 0(r1)
	j	beq_cont.30405
beq_then.30404:
	addi	r1, r0, 1				# li	r1, 1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 53(r3)
	addi	r3, r3, 54
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -54
	lw	r30, 53(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30405:
	lw	r2, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#	blr
solver_rect.2622:
	lw	r5, 1(r28)
	lw	r30, 0(r2)
	fmvfr	f4, r30
	sw	r5, 0(r3)
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	sw	r2, 8(r3)
	sw	r1, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30430
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30431
beq_then.30430:
	lw	r1, 9(r3)
	lw	r2, 4(r1)
	lw	r5, 6(r1)
	lw	r6, 8(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	sw	r2, 10(r3)
	sw	r5, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 11(r3)
	beq	r5, r2, beq_then.30432
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30434
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30435
beq_then.30434:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30435:
	j	beq_cont.30433
beq_then.30432:
beq_cont.30433:
	lw	r2, 10(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	addi	r5, r0, 0				# li	r5, 0
	beq	r1, r5, beq_then.30436
	j	beq_cont.30437
beq_then.30436:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30437:
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r1, 8(r3)
	lw	r30, 0(r1)
	fmvfr	f3, r30
	fdiv	f1, f1, f3
	lw	r30, 1(r1)
	fmvfr	f3, r30
	fmul	f3, f1, f3
	lw	r30, 4(r3)				#lfd	f4, 4(r3)
	fmvfr	f4, r30
	fadd	f3, f3, f4
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30438
	lw	r1, 8(r3)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fadd	f1, f1, f3
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30440
	lw	r1, 0(r3)
	lw	r30, 12(r3)				#lfd	f1, 12(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.30441
beq_then.30440:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30441:
	j	beq_cont.30439
beq_then.30438:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30439:
beq_cont.30431:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30442
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30442:
	lw	r1, 8(r3)
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
	beq	r1, r2, beq_then.30443
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30444
beq_then.30443:
	lw	r1, 9(r3)
	lw	r2, 4(r1)
	lw	r5, 6(r1)
	lw	r6, 8(r3)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	sw	r2, 14(r3)
	sw	r5, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 15(r3)
	beq	r5, r2, beq_then.30445
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30447
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30448
beq_then.30447:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30448:
	j	beq_cont.30446
beq_then.30445:
beq_cont.30446:
	lw	r2, 14(r3)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	addi	r5, r0, 0				# li	r5, 0
	beq	r1, r5, beq_then.30449
	j	beq_cont.30450
beq_then.30449:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30450:
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r1, 8(r3)
	lw	r30, 1(r1)
	fmvfr	f3, r30
	fdiv	f1, f1, f3
	lw	r30, 2(r1)
	fmvfr	f3, r30
	fmul	f3, f1, f3
	lw	r30, 2(r3)				#lfd	f4, 2(r3)
	fmvfr	f4, r30
	fadd	f3, f3, f4
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 14(r3)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30451
	lw	r1, 8(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 6(r3)				#lfd	f3, 6(r3)
	fmvfr	f3, r30
	fadd	f1, f1, f3
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 14(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30453
	lw	r1, 0(r3)
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.30454
beq_then.30453:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30454:
	j	beq_cont.30452
beq_then.30451:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30452:
beq_cont.30444:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30455
	addi	r1, r0, 2				# li	r1, 2
	jr	r31				#	blr
beq_then.30455:
	lw	r1, 8(r3)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30456
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30457
beq_then.30456:
	lw	r1, 9(r3)
	lw	r2, 4(r1)
	lw	r1, 6(r1)
	lw	r5, 8(r3)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	sw	r2, 18(r3)
	sw	r1, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 19(r3)
	beq	r5, r2, beq_then.30458
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30460
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30461
beq_then.30460:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30461:
	j	beq_cont.30459
beq_then.30458:
beq_cont.30459:
	lw	r2, 18(r3)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	addi	r5, r0, 0				# li	r5, 0
	beq	r1, r5, beq_then.30462
	j	beq_cont.30463
beq_then.30462:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30463:
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r1, 8(r3)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r30, 6(r3)				#lfd	f3, 6(r3)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 18(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30464
	lw	r1, 8(r3)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 4(r3)				#lfd	f3, 4(r3)
	fmvfr	f3, r30
	fadd	f1, f1, f3
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 18(r3)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30466
	lw	r1, 0(r3)
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.30467
beq_then.30466:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30467:
	j	beq_cont.30465
beq_then.30464:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30465:
beq_cont.30457:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30468
	addi	r1, r0, 3				# li	r1, 3
	jr	r31				#	blr
beq_then.30468:
	addi	r1, r0, 0				# li	r1, 0
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
	sw	r2, 8(r3)
	fmvtr	r30, f4
	sw	r30, 10(r3)				#stfd	f4, 10(r3)
	fmvtr	r30, f6
	sw	r30, 12(r3)				#stfd	f6, 12(r3)
	fmvtr	r30, f5
	sw	r30, 14(r3)				#stfd	f5, 14(r3)
	sw	r1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
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
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
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
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30472
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	lw	r30, 14(r3)				#lfd	f3, 14(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f1, f1, f4
	lw	r30, 10(r3)				#lfd	f4, 10(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.30473
beq_then.30472:
beq_cont.30473:
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
	beq	r1, r2, beq_then.30474
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30474:
	lw	r1, 8(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r30, 2(r1)
	fmvfr	f3, r30
	lw	r30, 6(r3)				#lfd	f4, 6(r3)
	fmvfr	f4, r30
	fmul	f5, f1, f4
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	lw	r30, 4(r3)				#lfd	f6, 4(r3)
	fmvfr	f6, r30
	fmul	f7, f2, f6
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f8, r30
	fmul	f7, f7, f8
	fadd	f5, f5, f7
	lw	r30, 2(r3)				#lfd	f7, 2(r3)
	fmvfr	f7, r30
	fmul	f8, f3, f7
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f9, r30
	fmul	f8, f8, f9
	fadd	f5, f5, f8
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30475
	fmul	f8, f3, f6
	fmul	f9, f2, f7
	fadd	f8, f8, f9
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f9, r30
	fmul	f8, f8, f9
	fmul	f9, f1, f7
	fmul	f3, f3, f4
	fadd	f3, f9, f3
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f9, r30
	fmul	f3, f3, f9
	fadd	f3, f8, f3
	fmul	f1, f1, f6
	fmul	f2, f2, f4
	fadd	f1, f1, f2
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	fadd	f1, f3, f1
	fmvtr	r30, f5
	sw	r30, 24(r3)				#stfd	f5, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fhalf				#	bl	lib_fhalf
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	j	beq_cont.30476
beq_then.30475:
	fadd	f1, f0, f5				# fmr	f1, f5
beq_cont.30476:
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 26(r3)				#stfd	f1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
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
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30477
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
	lw	r30, 6(r3)				#lfd	f4, 6(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.30478
beq_then.30477:
beq_cont.30478:
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.30479
	j	beq_cont.30480
beq_then.30479:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.30480:
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 32(r3)				#stfd	f1, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	lw	r30, 22(r3)				#lfd	f3, 22(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 34(r3)				#stfd	f1, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30481
	lw	r30, 34(r3)				#lfd	f1, 34(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 16(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30482
	j	beq_cont.30483
beq_then.30482:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30483:
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30481:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver.2653:
	lw	r6, 2(r28)
	lw	r7, 1(r28)
	add	r30, r7, r1
	lw	r1, 0(r30)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r7, 5(r1)
	lw	r30, 0(r7)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 1(r5)
	fmvfr	f2, r30
	lw	r7, 5(r1)
	lw	r30, 1(r7)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	lw	r30, 2(r5)
	fmvfr	f3, r30
	lw	r5, 5(r1)
	lw	r30, 2(r5)
	fmvfr	f4, r30
	fsub	f3, f3, f4
	lw	r5, 1(r1)
	addi	r7, r0, 1				# li	r7, 1
	beq	r5, r7, beq_then.30484
	addi	r7, r0, 2				# li	r7, 2
	beq	r5, r7, beq_then.30485
	lw	r30, 0(r2)
	fmvfr	f4, r30
	lw	r30, 1(r2)
	fmvfr	f5, r30
	lw	r30, 2(r2)
	fmvfr	f6, r30
	sw	r6, 0(r3)
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	sw	r2, 8(r3)
	fmvtr	r30, f4
	sw	r30, 10(r3)				#stfd	f4, 10(r3)
	fmvtr	r30, f6
	sw	r30, 12(r3)				#stfd	f6, 12(r3)
	fmvtr	r30, f5
	sw	r30, 14(r3)				#stfd	f5, 14(r3)
	sw	r1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
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
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
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
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30489
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	lw	r30, 14(r3)				#lfd	f3, 14(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f1, f1, f4
	lw	r30, 10(r3)				#lfd	f4, 10(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.30490
beq_then.30489:
beq_cont.30490:
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
	beq	r1, r2, beq_then.30491
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30491:
	lw	r1, 8(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r30, 2(r1)
	fmvfr	f3, r30
	lw	r30, 6(r3)				#lfd	f4, 6(r3)
	fmvfr	f4, r30
	fmul	f5, f1, f4
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	lw	r30, 4(r3)				#lfd	f6, 4(r3)
	fmvfr	f6, r30
	fmul	f7, f2, f6
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f8, r30
	fmul	f7, f7, f8
	fadd	f5, f5, f7
	lw	r30, 2(r3)				#lfd	f7, 2(r3)
	fmvfr	f7, r30
	fmul	f8, f3, f7
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f9, r30
	fmul	f8, f8, f9
	fadd	f5, f5, f8
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30492
	fmul	f8, f3, f6
	fmul	f9, f2, f7
	fadd	f8, f8, f9
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f9, r30
	fmul	f8, f8, f9
	fmul	f9, f1, f7
	fmul	f3, f3, f4
	fadd	f3, f9, f3
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f9, r30
	fmul	f3, f3, f9
	fadd	f3, f8, f3
	fmul	f1, f1, f6
	fmul	f2, f2, f4
	fadd	f1, f1, f2
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	fadd	f1, f3, f1
	fmvtr	r30, f5
	sw	r30, 24(r3)				#stfd	f5, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fhalf				#	bl	lib_fhalf
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	j	beq_cont.30493
beq_then.30492:
	fadd	f1, f0, f5				# fmr	f1, f5
beq_cont.30493:
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 26(r3)				#stfd	f1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
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
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30494
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
	lw	r30, 6(r3)				#lfd	f4, 6(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.30495
beq_then.30494:
beq_cont.30495:
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.30496
	j	beq_cont.30497
beq_then.30496:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.30497:
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 32(r3)				#stfd	f1, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	lw	r30, 22(r3)				#lfd	f3, 22(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 34(r3)				#stfd	f1, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30498
	lw	r30, 34(r3)				#lfd	f1, 34(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 16(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30499
	j	beq_cont.30500
beq_then.30499:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30500:
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30498:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30485:
	lw	r1, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f4, r30
	lw	r30, 0(r1)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	lw	r30, 1(r2)
	fmvfr	f5, r30
	lw	r30, 1(r1)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	lw	r30, 2(r2)
	fmvfr	f5, r30
	lw	r30, 2(r1)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	sw	r6, 0(r3)
	fmvtr	r30, f4
	sw	r30, 36(r3)				#stfd	f4, 36(r3)
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	sw	r1, 38(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 39(r3)
	addi	r3, r3, 40
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -40
	lw	r30, 39(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30501
	lw	r1, 38(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r30, 4(r3)				#lfd	f3, 4(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 39(r3)
	addi	r3, r3, 40
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -40
	lw	r30, 39(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 36(r3)				#lfd	f2, 36(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30501:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30484:
	lw	r30, 0(r2)
	fmvfr	f4, r30
	sw	r6, 0(r3)
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	sw	r2, 8(r3)
	sw	r1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 39(r3)
	addi	r3, r3, 40
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -40
	lw	r30, 39(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30502
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30503
beq_then.30502:
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r5, 6(r1)
	lw	r6, 8(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	sw	r2, 39(r3)
	sw	r5, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 41(r3)
	addi	r3, r3, 42
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 40(r3)
	beq	r5, r2, beq_then.30504
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30506
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30507
beq_then.30506:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30507:
	j	beq_cont.30505
beq_then.30504:
beq_cont.30505:
	lw	r2, 39(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	addi	r5, r0, 0				# li	r5, 0
	beq	r1, r5, beq_then.30508
	j	beq_cont.30509
beq_then.30508:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 41(r3)
	addi	r3, r3, 42
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30509:
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r1, 8(r3)
	lw	r30, 0(r1)
	fmvfr	f3, r30
	fdiv	f1, f1, f3
	lw	r30, 1(r1)
	fmvfr	f3, r30
	fmul	f3, f1, f3
	lw	r30, 4(r3)				#lfd	f4, 4(r3)
	fmvfr	f4, r30
	fadd	f3, f3, f4
	fmvtr	r30, f1
	sw	r30, 42(r3)				#stfd	f1, 42(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 39(r3)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30511
	lw	r1, 8(r3)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	lw	r30, 42(r3)				#lfd	f2, 42(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fadd	f1, f1, f3
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 39(r3)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30513
	lw	r1, 0(r3)
	lw	r30, 42(r3)				#lfd	f1, 42(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.30514
beq_then.30513:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30514:
	j	beq_cont.30512
beq_then.30511:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30512:
beq_cont.30503:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30515
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30515:
	lw	r1, 8(r3)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30516
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30517
beq_then.30516:
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r5, 6(r1)
	lw	r6, 8(r3)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	sw	r2, 44(r3)
	sw	r5, 45(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 45(r3)
	beq	r5, r2, beq_then.30518
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30520
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30521
beq_then.30520:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30521:
	j	beq_cont.30519
beq_then.30518:
beq_cont.30519:
	lw	r2, 44(r3)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	addi	r5, r0, 0				# li	r5, 0
	beq	r1, r5, beq_then.30522
	j	beq_cont.30523
beq_then.30522:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30523:
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r1, 8(r3)
	lw	r30, 1(r1)
	fmvfr	f3, r30
	fdiv	f1, f1, f3
	lw	r30, 2(r1)
	fmvfr	f3, r30
	fmul	f3, f1, f3
	lw	r30, 2(r3)				#lfd	f4, 2(r3)
	fmvfr	f4, r30
	fadd	f3, f3, f4
	fmvtr	r30, f1
	sw	r30, 46(r3)				#stfd	f1, 46(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 44(r3)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30524
	lw	r1, 8(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r30, 46(r3)				#lfd	f2, 46(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 6(r3)				#lfd	f3, 6(r3)
	fmvfr	f3, r30
	fadd	f1, f1, f3
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 44(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30526
	lw	r1, 0(r3)
	lw	r30, 46(r3)				#lfd	f1, 46(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.30527
beq_then.30526:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30527:
	j	beq_cont.30525
beq_then.30524:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30525:
beq_cont.30517:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30528
	addi	r1, r0, 2				# li	r1, 2
	jr	r31				#	blr
beq_then.30528:
	lw	r1, 8(r3)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30529
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30530
beq_then.30529:
	lw	r1, 16(r3)
	lw	r2, 4(r1)
	lw	r1, 6(r1)
	lw	r5, 8(r3)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	sw	r2, 48(r3)
	sw	r1, 49(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 49(r3)
	beq	r5, r2, beq_then.30531
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30533
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30534
beq_then.30533:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30534:
	j	beq_cont.30532
beq_then.30531:
beq_cont.30532:
	lw	r2, 48(r3)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	addi	r5, r0, 0				# li	r5, 0
	beq	r1, r5, beq_then.30535
	j	beq_cont.30536
beq_then.30535:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30536:
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r1, 8(r3)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r30, 6(r3)				#lfd	f3, 6(r3)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	fmvtr	r30, f1
	sw	r30, 50(r3)				#stfd	f1, 50(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 48(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30537
	lw	r1, 8(r3)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 50(r3)				#lfd	f2, 50(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r30, 4(r3)				#lfd	f3, 4(r3)
	fmvfr	f3, r30
	fadd	f1, f1, f3
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 48(r3)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30539
	lw	r1, 0(r3)
	lw	r30, 50(r3)				#lfd	f1, 50(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.30540
beq_then.30539:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30540:
	j	beq_cont.30538
beq_then.30537:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30538:
beq_cont.30530:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30541
	addi	r1, r0, 3				# li	r1, 3
	jr	r31				#	blr
beq_then.30541:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
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
	beq	r1, r2, beq_then.30544
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
	beq	r1, r2, beq_then.30546
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
	beq	r1, r2, beq_then.30548
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30549
beq_then.30548:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30549:
	j	beq_cont.30547
beq_then.30546:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30547:
	j	beq_cont.30545
beq_then.30544:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30545:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30550
	lw	r1, 0(r3)
	lw	r30, 10(r3)				#lfd	f1, 10(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30550:
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
	beq	r1, r2, beq_then.30551
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
	beq	r1, r2, beq_then.30553
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
	beq	r1, r2, beq_then.30555
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30556
beq_then.30555:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30556:
	j	beq_cont.30554
beq_then.30553:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30554:
	j	beq_cont.30552
beq_then.30551:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30552:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30557
	lw	r1, 0(r3)
	lw	r30, 14(r3)				#lfd	f1, 14(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 2				# li	r1, 2
	jr	r31				#	blr
beq_then.30557:
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
	beq	r1, r2, beq_then.30558
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
	beq	r1, r2, beq_then.30560
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
	beq	r1, r2, beq_then.30562
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30563
beq_then.30562:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30563:
	j	beq_cont.30561
beq_then.30560:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30561:
	j	beq_cont.30559
beq_then.30558:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30559:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30564
	lw	r1, 0(r3)
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 3				# li	r1, 3
	jr	r31				#	blr
beq_then.30564:
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
	beq	r1, r2, beq_then.30567
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30567:
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
	lw	r1, 4(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
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
	lw	r1, 4(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
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
	lw	r1, 4(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30569
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	lw	r30, 8(r3)				#lfd	f3, 8(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f1, f1, f4
	lw	r30, 10(r3)				#lfd	f4, 10(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.30570
beq_then.30569:
beq_cont.30570:
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.30571
	j	beq_cont.30572
beq_then.30571:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.30572:
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
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
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30573
	lw	r1, 4(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30574
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -25
	lw	r30, 24(r3)
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
	j	beq_cont.30575
beq_then.30574:
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -25
	lw	r30, 24(r3)
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
beq_cont.30575:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30573:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_fast.2676:
	lw	r6, 3(r28)
	lw	r7, 2(r28)
	lw	r8, 1(r28)
	add	r30, r8, r1
	lw	r8, 0(r30)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r9, 5(r8)
	lw	r30, 0(r9)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 1(r5)
	fmvfr	f2, r30
	lw	r9, 5(r8)
	lw	r30, 1(r9)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	lw	r30, 2(r5)
	fmvfr	f3, r30
	lw	r5, 5(r8)
	lw	r30, 2(r5)
	fmvfr	f4, r30
	fsub	f3, f3, f4
	lw	r5, 1(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r1, 1(r8)
	addi	r9, r0, 1				# li	r9, 1
	beq	r1, r9, beq_then.30576
	addi	r2, r0, 2				# li	r2, 2
	beq	r1, r2, beq_then.30577
	lw	r30, 0(r5)
	fmvfr	f4, r30
	sw	r7, 0(r3)
	fmvtr	r30, f4
	sw	r30, 2(r3)				#stfd	f4, 2(r3)
	sw	r8, 4(r3)
	fmvtr	r30, f3
	sw	r30, 6(r3)				#stfd	f3, 6(r3)
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	sw	r5, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30580
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30580:
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
	lw	r1, 4(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
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
	lw	r1, 4(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
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
	lw	r1, 4(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30582
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	lw	r30, 8(r3)				#lfd	f3, 8(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f1, f1, f4
	lw	r30, 10(r3)				#lfd	f4, 10(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.30583
beq_then.30582:
beq_cont.30583:
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.30584
	j	beq_cont.30585
beq_then.30584:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.30585:
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
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
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30586
	lw	r1, 4(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30587
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -25
	lw	r30, 24(r3)
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
	j	beq_cont.30588
beq_then.30587:
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -25
	lw	r30, 24(r3)
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
beq_cont.30588:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30586:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30577:
	lw	r30, 0(r5)
	fmvfr	f4, r30
	sw	r7, 0(r3)
	fmvtr	r30, f3
	sw	r30, 6(r3)				#stfd	f3, 6(r3)
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	sw	r5, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30589
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
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30589:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30576:
	lw	r2, 0(r2)
	add	r1, r0, r8				# mr	r1, r8
	add	r28, r0, r6				# mr	r28, r6
	lw	r27, 0(r28)
	jr	r27
solver_fast2.2694:
	lw	r5, 3(r28)
	lw	r6, 2(r28)
	lw	r7, 1(r28)
	add	r30, r7, r1
	lw	r7, 0(r30)
	lw	r8, 10(r7)
	lw	r30, 0(r8)
	fmvfr	f1, r30
	lw	r30, 1(r8)
	fmvfr	f2, r30
	lw	r30, 2(r8)
	fmvfr	f3, r30
	lw	r9, 1(r2)
	add	r30, r9, r1
	lw	r1, 0(r30)
	lw	r9, 1(r7)
	addi	r10, r0, 1				# li	r10, 1
	beq	r9, r10, beq_then.30590
	addi	r2, r0, 2				# li	r2, 2
	beq	r9, r2, beq_then.30591
	lw	r30, 0(r1)
	fmvfr	f4, r30
	sw	r6, 0(r3)
	sw	r7, 1(r3)
	fmvtr	r30, f4
	sw	r30, 2(r3)				#stfd	f4, 2(r3)
	sw	r8, 4(r3)
	fmvtr	r30, f3
	sw	r30, 6(r3)				#stfd	f3, 6(r3)
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30593
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30593:
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
	beq	r1, r2, beq_then.30595
	lw	r1, 1(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30596
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
	j	beq_cont.30597
beq_then.30596:
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
beq_cont.30597:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30595:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30591:
	lw	r30, 0(r1)
	fmvfr	f1, r30
	sw	r6, 0(r3)
	sw	r8, 4(r3)
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30598
	lw	r1, 12(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r1, 4(r3)
	lw	r30, 3(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30598:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30590:
	lw	r2, 0(r2)
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r1				# mr	r5, r1
	add	r1, r0, r7				# mr	r1, r7
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
	beq	r1, r2, beq_then.30599
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	j	beq_cont.30600
beq_then.30599:
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
	beq	r5, r2, beq_then.30601
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30603
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30604
beq_then.30603:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30604:
	j	beq_cont.30602
beq_then.30601:
beq_cont.30602:
	lw	r2, 0(r3)
	lw	r5, 4(r2)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	addi	r5, r0, 0				# li	r5, 0
	beq	r1, r5, beq_then.30605
	j	beq_cont.30606
beq_then.30605:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30606:
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
beq_cont.30600:
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
	beq	r1, r2, beq_then.30607
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 3(r1)
	j	beq_cont.30608
beq_then.30607:
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
	beq	r5, r2, beq_then.30609
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30611
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30612
beq_then.30611:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30612:
	j	beq_cont.30610
beq_then.30609:
beq_cont.30610:
	lw	r2, 0(r3)
	lw	r5, 4(r2)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	addi	r5, r0, 0				# li	r5, 0
	beq	r1, r5, beq_then.30613
	j	beq_cont.30614
beq_then.30613:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30614:
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
beq_cont.30608:
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
	beq	r1, r2, beq_then.30615
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 5(r1)
	j	beq_cont.30616
beq_then.30615:
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
	beq	r5, r2, beq_then.30617
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30619
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30620
beq_then.30619:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30620:
	j	beq_cont.30618
beq_then.30617:
beq_cont.30618:
	lw	r2, 0(r3)
	lw	r2, 4(r2)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30621
	j	beq_cont.30622
beq_then.30621:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30622:
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
beq_cont.30616:
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
	beq	r1, r2, beq_then.30623
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
	j	beq_cont.30624
beq_then.30623:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 4(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
beq_cont.30624:
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
	sw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r3)				#stfd	f1, 4(r3)
	fmvtr	r30, f3
	sw	r30, 6(r3)				#stfd	f3, 6(r3)
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
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
	lw	r1, 0(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
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
	lw	r1, 0(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30626
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	lw	r30, 8(r3)				#lfd	f3, 8(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f1, f1, f4
	lw	r30, 4(r3)				#lfd	f4, 4(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.30627
beq_then.30626:
beq_cont.30627:
	lw	r2, 1(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r5, 4(r1)
	lw	r30, 0(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -17
	lw	r30, 16(r3)
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
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -19
	lw	r30, 18(r3)
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
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fmvtr	r30, f2
	sw	r30, 0(r1)
	lw	r2, 0(r3)
	lw	r5, 3(r2)
	addi	r6, r0, 0				# li	r6, 0
	beq	r5, r6, beq_then.30628
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
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fhalf				#	bl	lib_fhalf
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
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
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fhalf				#	bl	lib_fhalf
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
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
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fhalf				#	bl	lib_fhalf
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 3(r1)
	j	beq_cont.30629
beq_then.30628:
	lw	r30, 16(r3)				#lfd	f3, 16(r3)
	fmvfr	f3, r30
	fmvtr	r30, f3
	sw	r30, 1(r1)
	lw	r30, 18(r3)				#lfd	f3, 18(r3)
	fmvfr	f3, r30
	fmvtr	r30, f3
	sw	r30, 2(r1)
	fmvtr	r30, f1
	sw	r30, 3(r1)
beq_cont.30629:
	lw	r30, 14(r3)				#lfd	f1, 14(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30630
	j	beq_cont.30631
beq_then.30630:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 4(r1)
beq_cont.30631:
	lw	r1, 2(r3)
	jr	r31				#	blr
iter_setup_dirvec_constants.2706:
	lw	r5, 1(r28)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.30632
	jr	r31				#	blr
ble_then.30632:
	add	r30, r5, r2
	lw	r6, 0(r30)
	lw	r7, 1(r1)
	lw	r8, 0(r1)
	lw	r9, 1(r6)
	addi	r10, r0, 1				# li	r10, 1
	sw	r28, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	beq	r9, r10, beq_then.30634
	addi	r10, r0, 2				# li	r10, 2
	beq	r9, r10, beq_then.30636
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.2703				#	bl	setup_second_table.2703
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.30637
beq_then.30636:
	addi	r9, r0, 4				# li	r9, 4
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	sw	r6, 5(r3)
	sw	r8, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r9				# mr	r1, r9
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 6(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r5, 5(r3)
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
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	sw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30639
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 10(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r2, 5(r3)
	lw	r5, 4(r2)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	fdiv	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r2, 5(r3)
	lw	r5, 4(r2)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r2, 5(r3)
	lw	r2, 4(r2)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	fmvtr	r30, f1
	sw	r30, 3(r1)
	j	beq_cont.30640
beq_then.30639:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 10(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
beq_cont.30640:
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.30637:
	j	beq_cont.30635
beq_then.30634:
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	setup_rect_table.2697				#	bl	setup_rect_table.2697
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.30635:
	addi	r1, r0, 1				# li	r1, 1
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.30641
	jr	r31				#	blr
ble_then.30641:
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 1(r3)
	lw	r6, 1(r5)
	lw	r7, 0(r5)
	lw	r8, 1(r2)
	addi	r9, r0, 1				# li	r9, 1
	beq	r8, r9, beq_then.30643
	addi	r9, r0, 2				# li	r9, 2
	beq	r8, r9, beq_then.30645
	sw	r1, 11(r3)
	sw	r6, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r7				# mr	r1, r7
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	setup_second_table.2703				#	bl	setup_second_table.2703
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.30646
beq_then.30645:
	sw	r1, 11(r3)
	sw	r6, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r7				# mr	r1, r7
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	setup_surface_table.2700				#	bl	setup_surface_table.2700
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.30646:
	j	beq_cont.30644
beq_then.30643:
	sw	r1, 11(r3)
	sw	r6, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r7				# mr	r1, r7
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	setup_rect_table.2697				#	bl	setup_rect_table.2697
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.30644:
	addi	r1, r0, 1				# li	r1, 1
	sub	r2, r2, r1
	lw	r1, 1(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
setup_startp_constants.2711:
	lw	r5, 1(r28)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.30647
	jr	r31				#	blr
ble_then.30647:
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
	beq	r7, r8, beq_then.30649
	addi	r8, r0, 2				# li	r8, 2
	ble	r7, r8, ble_then.30651
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r30, 1(r6)
	fmvfr	f2, r30
	lw	r30, 2(r6)
	fmvfr	f3, r30
	sw	r6, 3(r3)
	sw	r7, 4(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	fmvtr	r30, f3
	sw	r30, 8(r3)				#stfd	f3, 8(r3)
	fmvtr	r30, f2
	sw	r30, 10(r3)				#stfd	f2, 10(r3)
	sw	r5, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 12(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
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
	lw	r1, 12(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
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
	lw	r1, 12(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30655
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	lw	r30, 10(r3)				#lfd	f3, 10(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f1, f1, f4
	lw	r30, 6(r3)				#lfd	f4, 6(r3)
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
	j	beq_cont.30656
beq_then.30655:
beq_cont.30656:
	addi	r1, r0, 3				# li	r1, 3
	lw	r2, 4(r3)
	beq	r2, r1, beq_then.30657
	j	beq_cont.30658
beq_then.30657:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.30658:
	lw	r1, 3(r3)
	fmvtr	r30, f1
	sw	r30, 3(r1)
	j	ble_cont.30652
ble_then.30651:
ble_cont.30652:
	j	beq_cont.30650
beq_then.30649:
	lw	r5, 4(r5)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r30, 1(r6)
	fmvfr	f2, r30
	lw	r30, 2(r6)
	fmvfr	f3, r30
	lw	r30, 0(r5)
	fmvfr	f4, r30
	fmul	f1, f4, f1
	lw	r30, 1(r5)
	fmvfr	f4, r30
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	lw	r30, 2(r5)
	fmvfr	f2, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 3(r6)
beq_cont.30650:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 2(r3)
	sub	r2, r2, r1
	lw	r1, 0(r3)
	lw	r28, 1(r3)
	lw	r27, 0(r28)
	jr	r27
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
	beq	r2, r5, beq_then.30659
	addi	r5, r0, 2				# li	r5, 2
	beq	r2, r5, beq_then.30660
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
	beq	r2, r5, beq_then.30662
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
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.30663
beq_then.30662:
beq_cont.30663:
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.30664
	j	beq_cont.30665
beq_then.30664:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.30665:
	lw	r1, 6(r1)
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 12(r3)
	beq	r5, r2, beq_then.30666
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30668
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30669
beq_then.30668:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30669:
	j	beq_cont.30667
beq_then.30666:
beq_cont.30667:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30670
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30670:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30660:
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f4, r30
	fmul	f1, f4, f1
	lw	r30, 1(r2)
	fmvfr	f4, r30
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r1, 6(r1)
	sw	r1, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 13(r3)
	beq	r5, r2, beq_then.30671
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30673
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30674
beq_then.30673:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30674:
	j	beq_cont.30672
beq_then.30671:
beq_cont.30672:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30675
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30675:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30659:
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30676
	lw	r30, 4(r3)				#lfd	f1, 4(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
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
	beq	r1, r2, beq_then.30678
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
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
	j	beq_cont.30679
beq_then.30678:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30679:
	j	beq_cont.30677
beq_then.30676:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30677:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30680
	lw	r1, 6(r3)
	lw	r1, 6(r1)
	jr	r31				#	blr
beq_then.30680:
	lw	r1, 6(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30681
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30681:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
check_all_inside.2736:
	lw	r5, 1(r28)
	add	r30, r2, r1
	lw	r6, 0(r30)
	addi	r7, r0, -1				# li	r7, -1
	beq	r6, r7, beq_then.30682
	add	r30, r5, r6
	lw	r6, 0(r30)
	lw	r7, 5(r6)
	lw	r30, 0(r7)
	fmvfr	f4, r30
	fsub	f4, f1, f4
	lw	r7, 5(r6)
	lw	r30, 1(r7)
	fmvfr	f5, r30
	fsub	f5, f2, f5
	lw	r7, 5(r6)
	lw	r30, 2(r7)
	fmvfr	f6, r30
	fsub	f6, f3, f6
	lw	r7, 1(r6)
	addi	r8, r0, 1				# li	r8, 1
	sw	r28, 0(r3)
	fmvtr	r30, f3
	sw	r30, 2(r3)				#stfd	f3, 2(r3)
	fmvtr	r30, f2
	sw	r30, 4(r3)				#stfd	f2, 4(r3)
	fmvtr	r30, f1
	sw	r30, 6(r3)				#stfd	f1, 6(r3)
	sw	r5, 8(r3)
	sw	r2, 9(r3)
	sw	r1, 10(r3)
	beq	r7, r8, beq_then.30684
	addi	r8, r0, 2				# li	r8, 2
	beq	r7, r8, beq_then.30686
	fmvtr	r30, f4
	sw	r30, 12(r3)				#stfd	f4, 12(r3)
	fmvtr	r30, f6
	sw	r30, 14(r3)				#stfd	f6, 14(r3)
	fmvtr	r30, f5
	sw	r30, 16(r3)				#stfd	f5, 16(r3)
	sw	r6, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 18(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
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
	lw	r1, 18(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 18(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30690
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	lw	r30, 16(r3)				#lfd	f3, 16(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f1, f1, f4
	lw	r30, 12(r3)				#lfd	f4, 12(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.30691
beq_then.30690:
beq_cont.30691:
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.30692
	j	beq_cont.30693
beq_then.30692:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.30693:
	lw	r1, 6(r1)
	sw	r1, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 25(r3)
	addi	r3, r3, 26
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -26
	lw	r30, 25(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 24(r3)
	beq	r5, r2, beq_then.30694
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30696
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30697
beq_then.30696:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30697:
	j	beq_cont.30695
beq_then.30694:
beq_cont.30695:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30698
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30699
beq_then.30698:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30699:
	j	beq_cont.30687
beq_then.30686:
	lw	r7, 4(r6)
	lw	r30, 0(r7)
	fmvfr	f7, r30
	fmul	f4, f7, f4
	lw	r30, 1(r7)
	fmvfr	f7, r30
	fmul	f5, f7, f5
	fadd	f4, f4, f5
	lw	r30, 2(r7)
	fmvfr	f5, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	lw	r6, 6(r6)
	sw	r6, 25(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 25(r3)
	beq	r5, r2, beq_then.30700
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30702
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30703
beq_then.30702:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30703:
	j	beq_cont.30701
beq_then.30700:
beq_cont.30701:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30704
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30705
beq_then.30704:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30705:
beq_cont.30687:
	j	beq_cont.30685
beq_then.30684:
	fmvtr	r30, f6
	sw	r30, 14(r3)				#stfd	f6, 14(r3)
	fmvtr	r30, f5
	sw	r30, 16(r3)				#stfd	f5, 16(r3)
	sw	r6, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 18(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30706
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 18(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30708
	lw	r30, 14(r3)				#lfd	f1, 14(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 18(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30709
beq_then.30708:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30709:
	j	beq_cont.30707
beq_then.30706:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30707:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30710
	lw	r1, 18(r3)
	lw	r1, 6(r1)
	j	beq_cont.30711
beq_then.30710:
	lw	r1, 18(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30712
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30713
beq_then.30712:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30713:
beq_cont.30711:
beq_cont.30685:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30714
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30714:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.30715
	lw	r6, 8(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	lw	r30, 6(r3)				#lfd	f1, 6(r3)
	fmvfr	f1, r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	sw	r1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 27(r3)
	addi	r3, r3, 28
	jal	is_outside.2731				#	bl	is_outside.2731
	addi	r3, r3, -28
	lw	r30, 27(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30716
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30716:
	lw	r1, 26(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.30717
	lw	r6, 8(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	lw	r7, 5(r5)
	lw	r30, 0(r7)
	fmvfr	f1, r30
	lw	r30, 6(r3)				#lfd	f2, 6(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r7, 5(r5)
	lw	r30, 1(r7)
	fmvfr	f3, r30
	lw	r30, 4(r3)				#lfd	f4, 4(r3)
	fmvfr	f4, r30
	fsub	f3, f4, f3
	lw	r7, 5(r5)
	lw	r30, 2(r7)
	fmvfr	f5, r30
	lw	r30, 2(r3)				#lfd	f6, 2(r3)
	fmvfr	f6, r30
	fsub	f5, f6, f5
	lw	r7, 1(r5)
	addi	r8, r0, 1				# li	r8, 1
	sw	r1, 27(r3)
	beq	r7, r8, beq_then.30718
	addi	r8, r0, 2				# li	r8, 2
	beq	r7, r8, beq_then.30720
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	fmvtr	r30, f5
	sw	r30, 30(r3)				#stfd	f5, 30(r3)
	fmvtr	r30, f3
	sw	r30, 32(r3)				#stfd	f3, 32(r3)
	sw	r5, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 35(r3)
	addi	r3, r3, 36
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -36
	lw	r30, 35(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 34(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
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
	lw	r1, 34(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 36(r3)				#lfd	f2, 36(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 38(r3)				#stfd	f1, 38(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 34(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 38(r3)				#lfd	f2, 38(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30723
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	lw	r30, 32(r3)				#lfd	f3, 32(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f1, f1, f4
	lw	r30, 28(r3)				#lfd	f4, 28(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.30724
beq_then.30723:
beq_cont.30724:
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.30725
	j	beq_cont.30726
beq_then.30725:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.30726:
	lw	r1, 6(r1)
	sw	r1, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 41(r3)
	addi	r3, r3, 42
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 40(r3)
	beq	r5, r2, beq_then.30727
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30729
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30730
beq_then.30729:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30730:
	j	beq_cont.30728
beq_then.30727:
beq_cont.30728:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30731
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30732
beq_then.30731:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30732:
	j	beq_cont.30721
beq_then.30720:
	lw	r7, 4(r5)
	lw	r30, 0(r7)
	fmvfr	f7, r30
	fmul	f1, f7, f1
	lw	r30, 1(r7)
	fmvfr	f7, r30
	fmul	f3, f7, f3
	fadd	f1, f1, f3
	lw	r30, 2(r7)
	fmvfr	f3, r30
	fmul	f3, f3, f5
	fadd	f1, f1, f3
	lw	r5, 6(r5)
	sw	r5, 41(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 41(r3)
	beq	r5, r2, beq_then.30733
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30735
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30736
beq_then.30735:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30736:
	j	beq_cont.30734
beq_then.30733:
beq_cont.30734:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30737
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30738
beq_then.30737:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30738:
beq_cont.30721:
	j	beq_cont.30719
beq_then.30718:
	fmvtr	r30, f5
	sw	r30, 30(r3)				#stfd	f5, 30(r3)
	fmvtr	r30, f3
	sw	r30, 32(r3)				#stfd	f3, 32(r3)
	sw	r5, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 34(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30739
	lw	r30, 32(r3)				#lfd	f1, 32(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 34(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30741
	lw	r30, 30(r3)				#lfd	f1, 30(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 34(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30742
beq_then.30741:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30742:
	j	beq_cont.30740
beq_then.30739:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30740:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30743
	lw	r1, 34(r3)
	lw	r1, 6(r1)
	j	beq_cont.30744
beq_then.30743:
	lw	r1, 34(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30745
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30746
beq_then.30745:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30746:
beq_cont.30744:
beq_cont.30719:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30747
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30747:
	lw	r1, 27(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.30748
	lw	r6, 8(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	lw	r30, 6(r3)				#lfd	f1, 6(r3)
	fmvfr	f1, r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	sw	r1, 42(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 43(r3)
	addi	r3, r3, 44
	jal	is_outside.2731				#	bl	is_outside.2731
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30749
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30749:
	lw	r1, 42(r3)
	addi	r1, r1, 1
	lw	r30, 6(r3)				#lfd	f1, 6(r3)
	fmvfr	f1, r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	lw	r30, 2(r3)				#lfd	f3, 2(r3)
	fmvfr	f3, r30
	lw	r2, 9(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.30748:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30717:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30715:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30682:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
shadow_check_and_group.2742:
	lw	r5, 11(r28)
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
	add	r30, r2, r1
	lw	r16, 0(r30)
	addi	r17, r0, -1				# li	r17, -1
	beq	r16, r17, beq_then.30750
	add	r30, r2, r1
	lw	r16, 0(r30)
	add	r30, r10, r16
	lw	r17, 0(r30)
	lw	r30, 0(r13)
	fmvfr	f1, r30
	lw	r18, 5(r17)
	lw	r30, 0(r18)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 1(r13)
	fmvfr	f2, r30
	lw	r18, 5(r17)
	lw	r30, 1(r18)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	lw	r30, 2(r13)
	fmvfr	f3, r30
	lw	r18, 5(r17)
	lw	r30, 2(r18)
	fmvfr	f4, r30
	fsub	f3, f3, f4
	add	r30, r14, r16
	lw	r14, 0(r30)
	lw	r18, 1(r17)
	addi	r19, r0, 1				# li	r19, 1
	sw	r15, 0(r3)
	sw	r12, 1(r3)
	sw	r28, 2(r3)
	sw	r13, 3(r3)
	sw	r11, 4(r3)
	sw	r8, 5(r3)
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	sw	r16, 8(r3)
	sw	r10, 9(r3)
	sw	r9, 10(r3)
	beq	r18, r19, beq_then.30751
	addi	r5, r0, 2				# li	r5, 2
	beq	r18, r5, beq_then.30753
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r14				# mr	r2, r14
	add	r1, r0, r17				# mr	r1, r17
	add	r28, r0, r6				# mr	r28, r6
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30754
beq_then.30753:
	lw	r30, 0(r14)
	fmvfr	f4, r30
	fmvtr	r30, f3
	sw	r30, 12(r3)				#stfd	f3, 12(r3)
	fmvtr	r30, f2
	sw	r30, 14(r3)				#stfd	f2, 14(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	sw	r14, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30756
	lw	r1, 18(r3)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 14(r3)				#lfd	f3, 14(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 3(r1)
	fmvfr	f2, r30
	lw	r30, 12(r3)				#lfd	f3, 12(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r1, 10(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.30757
beq_then.30756:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30757:
beq_cont.30754:
	j	beq_cont.30752
beq_then.30751:
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r17				# mr	r1, r17
	add	r28, r0, r7				# mr	r28, r7
	add	r5, r0, r14				# mr	r5, r14
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30752:
	lw	r2, 10(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	addi	r5, r0, 0				# li	r5, 0
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	beq	r1, r5, beq_then.30759
	addi	r30, r0, 52429
	lui	r30, r30, 48716	# to load float		-0.200000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30760
beq_then.30759:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30760:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30761
	addi	r30, r0, 55050
	lui	r30, r30, 15395	# to load float		0.010000
	fmvfr	f1, r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 1(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	lw	r5, 3(r3)
	lw	r30, 0(r5)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	lw	r30, 1(r1)
	fmvfr	f3, r30
	fmul	f3, f3, f1
	lw	r30, 1(r5)
	fmvfr	f4, r30
	fadd	f3, f3, f4
	lw	r30, 2(r1)
	fmvfr	f4, r30
	fmul	f1, f4, f1
	lw	r30, 2(r5)
	fmvfr	f4, r30
	fadd	f1, f1, f4
	lw	r2, 6(r3)
	lw	r6, 0(r2)
	addi	r7, r0, -1				# li	r7, -1
	beq	r6, r7, beq_then.30762
	lw	r7, 9(r3)
	add	r30, r7, r6
	lw	r6, 0(r30)
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	fmvtr	r30, f3
	sw	r30, 24(r3)				#stfd	f3, 24(r3)
	fmvtr	r30, f2
	sw	r30, 26(r3)				#stfd	f2, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	is_outside.2731				#	bl	is_outside.2731
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30764
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30765
beq_then.30764:
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.30766
	lw	r5, 9(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r6, 5(r2)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r6, 5(r2)
	lw	r30, 1(r6)
	fmvfr	f3, r30
	lw	r30, 24(r3)				#lfd	f4, 24(r3)
	fmvfr	f4, r30
	fsub	f3, f4, f3
	lw	r6, 5(r2)
	lw	r30, 2(r6)
	fmvfr	f5, r30
	lw	r30, 22(r3)				#lfd	f6, 22(r3)
	fmvfr	f6, r30
	fsub	f5, f6, f5
	lw	r6, 1(r2)
	addi	r7, r0, 1				# li	r7, 1
	beq	r6, r7, beq_then.30768
	addi	r7, r0, 2				# li	r7, 2
	beq	r6, r7, beq_then.30770
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	fmvtr	r30, f5
	sw	r30, 30(r3)				#stfd	f5, 30(r3)
	fmvtr	r30, f3
	sw	r30, 32(r3)				#stfd	f3, 32(r3)
	sw	r2, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 35(r3)
	addi	r3, r3, 36
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -36
	lw	r30, 35(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 34(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
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
	lw	r1, 34(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 36(r3)				#lfd	f2, 36(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 38(r3)				#stfd	f1, 38(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 34(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 38(r3)				#lfd	f2, 38(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30773
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	lw	r30, 32(r3)				#lfd	f3, 32(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f1, f1, f4
	lw	r30, 28(r3)				#lfd	f4, 28(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.30774
beq_then.30773:
beq_cont.30774:
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.30775
	j	beq_cont.30776
beq_then.30775:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.30776:
	lw	r1, 6(r1)
	sw	r1, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 41(r3)
	addi	r3, r3, 42
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 40(r3)
	beq	r5, r2, beq_then.30777
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30779
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30780
beq_then.30779:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30780:
	j	beq_cont.30778
beq_then.30777:
beq_cont.30778:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30781
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30782
beq_then.30781:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30782:
	j	beq_cont.30771
beq_then.30770:
	lw	r6, 4(r2)
	lw	r30, 0(r6)
	fmvfr	f7, r30
	fmul	f1, f7, f1
	lw	r30, 1(r6)
	fmvfr	f7, r30
	fmul	f3, f7, f3
	fadd	f1, f1, f3
	lw	r30, 2(r6)
	fmvfr	f3, r30
	fmul	f3, f3, f5
	fadd	f1, f1, f3
	lw	r2, 6(r2)
	sw	r2, 41(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 41(r3)
	beq	r5, r2, beq_then.30783
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30785
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30786
beq_then.30785:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30786:
	j	beq_cont.30784
beq_then.30783:
beq_cont.30784:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30787
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30788
beq_then.30787:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30788:
beq_cont.30771:
	j	beq_cont.30769
beq_then.30768:
	fmvtr	r30, f5
	sw	r30, 30(r3)				#stfd	f5, 30(r3)
	fmvtr	r30, f3
	sw	r30, 32(r3)				#stfd	f3, 32(r3)
	sw	r2, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 34(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30789
	lw	r30, 32(r3)				#lfd	f1, 32(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 34(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30791
	lw	r30, 30(r3)				#lfd	f1, 30(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 34(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30792
beq_then.30791:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30792:
	j	beq_cont.30790
beq_then.30789:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30790:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30793
	lw	r1, 34(r3)
	lw	r1, 6(r1)
	j	beq_cont.30794
beq_then.30793:
	lw	r1, 34(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30795
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30796
beq_then.30795:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30796:
beq_cont.30794:
beq_cont.30769:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30797
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30798
beq_then.30797:
	lw	r1, 6(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.30799
	lw	r5, 9(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r30, 26(r3)				#lfd	f1, 26(r3)
	fmvfr	f1, r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	lw	r30, 22(r3)				#lfd	f3, 22(r3)
	fmvfr	f3, r30
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	is_outside.2731				#	bl	is_outside.2731
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30801
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30802
beq_then.30801:
	addi	r1, r0, 3				# li	r1, 3
	lw	r30, 26(r3)				#lfd	f1, 26(r3)
	fmvfr	f1, r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	lw	r30, 22(r3)				#lfd	f3, 22(r3)
	fmvfr	f3, r30
	lw	r2, 6(r3)
	lw	r28, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30802:
	j	beq_cont.30800
beq_then.30799:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30800:
beq_cont.30798:
	j	beq_cont.30767
beq_then.30766:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30767:
beq_cont.30765:
	j	beq_cont.30763
beq_then.30762:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30763:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30803
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30803:
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 6(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.30804
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 4(r3)
	lw	r7, 3(r3)
	lw	r28, 5(r3)
	sw	r1, 42(r3)
	sw	r5, 43(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r7				# mr	r5, r7
	sw	r30, 44(r3)
	addi	r3, r3, 45
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 10(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	addi	r2, r0, 0				# li	r2, 0
	fmvtr	r30, f1
	sw	r30, 44(r3)				#stfd	f1, 44(r3)
	beq	r1, r2, beq_then.30805
	addi	r30, r0, 52429
	lui	r30, r30, 48716	# to load float		-0.200000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30806
beq_then.30805:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30806:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30807
	addi	r30, r0, 55050
	lui	r30, r30, 15395	# to load float		0.010000
	fmvfr	f1, r30
	lw	r30, 44(r3)				#lfd	f2, 44(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 1(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	lw	r2, 3(r3)
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
	lw	r2, 6(r3)
	lw	r1, 0(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.30808
	lw	r5, 9(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r6, 5(r1)
	lw	r30, 0(r6)
	fmvfr	f4, r30
	fsub	f4, f2, f4
	lw	r6, 5(r1)
	lw	r30, 1(r6)
	fmvfr	f5, r30
	fsub	f5, f3, f5
	lw	r6, 5(r1)
	lw	r30, 2(r6)
	fmvfr	f6, r30
	fsub	f6, f1, f6
	lw	r6, 1(r1)
	addi	r7, r0, 1				# li	r7, 1
	fmvtr	r30, f1
	sw	r30, 46(r3)				#stfd	f1, 46(r3)
	fmvtr	r30, f3
	sw	r30, 48(r3)				#stfd	f3, 48(r3)
	fmvtr	r30, f2
	sw	r30, 50(r3)				#stfd	f2, 50(r3)
	beq	r6, r7, beq_then.30810
	addi	r7, r0, 2				# li	r7, 2
	beq	r6, r7, beq_then.30812
	fmvtr	r30, f4
	sw	r30, 52(r3)				#stfd	f4, 52(r3)
	fmvtr	r30, f6
	sw	r30, 54(r3)				#stfd	f6, 54(r3)
	fmvtr	r30, f5
	sw	r30, 56(r3)				#stfd	f5, 56(r3)
	sw	r1, 58(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 59(r3)
	addi	r3, r3, 60
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -60
	lw	r30, 59(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 58(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 56(r3)				#lfd	f2, 56(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 60(r3)				#stfd	f1, 60(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 62(r3)
	addi	r3, r3, 63
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -63
	lw	r30, 62(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 58(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 60(r3)				#lfd	f2, 60(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 54(r3)				#lfd	f2, 54(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 62(r3)				#stfd	f1, 62(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 64(r3)
	addi	r3, r3, 65
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -65
	lw	r30, 64(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 58(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 62(r3)				#lfd	f2, 62(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30815
	lw	r30, 54(r3)				#lfd	f2, 54(r3)
	fmvfr	f2, r30
	lw	r30, 56(r3)				#lfd	f3, 56(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f1, f1, f4
	lw	r30, 52(r3)				#lfd	f4, 52(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.30816
beq_then.30815:
beq_cont.30816:
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.30817
	j	beq_cont.30818
beq_then.30817:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.30818:
	lw	r1, 6(r1)
	sw	r1, 64(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 65(r3)
	addi	r3, r3, 66
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -66
	lw	r30, 65(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 64(r3)
	beq	r5, r2, beq_then.30819
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30821
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30822
beq_then.30821:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30822:
	j	beq_cont.30820
beq_then.30819:
beq_cont.30820:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30823
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30824
beq_then.30823:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30824:
	j	beq_cont.30813
beq_then.30812:
	lw	r6, 4(r1)
	lw	r30, 0(r6)
	fmvfr	f7, r30
	fmul	f4, f7, f4
	lw	r30, 1(r6)
	fmvfr	f7, r30
	fmul	f5, f7, f5
	fadd	f4, f4, f5
	lw	r30, 2(r6)
	fmvfr	f5, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	lw	r1, 6(r1)
	sw	r1, 65(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 66(r3)
	addi	r3, r3, 67
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -67
	lw	r30, 66(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 65(r3)
	beq	r5, r2, beq_then.30825
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30827
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30828
beq_then.30827:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30828:
	j	beq_cont.30826
beq_then.30825:
beq_cont.30826:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30829
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30830
beq_then.30829:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30830:
beq_cont.30813:
	j	beq_cont.30811
beq_then.30810:
	fmvtr	r30, f6
	sw	r30, 54(r3)				#stfd	f6, 54(r3)
	fmvtr	r30, f5
	sw	r30, 56(r3)				#stfd	f5, 56(r3)
	sw	r1, 58(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 66(r3)
	addi	r3, r3, 67
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -67
	lw	r30, 66(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 58(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 66(r3)
	addi	r3, r3, 67
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -67
	lw	r30, 66(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30831
	lw	r30, 56(r3)				#lfd	f1, 56(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 66(r3)
	addi	r3, r3, 67
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -67
	lw	r30, 66(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 58(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 66(r3)
	addi	r3, r3, 67
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -67
	lw	r30, 66(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30833
	lw	r30, 54(r3)				#lfd	f1, 54(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 66(r3)
	addi	r3, r3, 67
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -67
	lw	r30, 66(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 58(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 66(r3)
	addi	r3, r3, 67
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -67
	lw	r30, 66(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30834
beq_then.30833:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30834:
	j	beq_cont.30832
beq_then.30831:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30832:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30835
	lw	r1, 58(r3)
	lw	r1, 6(r1)
	j	beq_cont.30836
beq_then.30835:
	lw	r1, 58(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30837
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30838
beq_then.30837:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30838:
beq_cont.30836:
beq_cont.30811:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30839
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30840
beq_then.30839:
	lw	r2, 6(r3)
	lw	r1, 1(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.30841
	lw	r5, 9(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r30, 50(r3)				#lfd	f1, 50(r3)
	fmvfr	f1, r30
	lw	r30, 48(r3)				#lfd	f2, 48(r3)
	fmvfr	f2, r30
	lw	r30, 46(r3)				#lfd	f3, 46(r3)
	fmvfr	f3, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 66(r3)
	addi	r3, r3, 67
	jal	is_outside.2731				#	bl	is_outside.2731
	addi	r3, r3, -67
	lw	r30, 66(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30843
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30844
beq_then.30843:
	addi	r1, r0, 2				# li	r1, 2
	lw	r30, 50(r3)				#lfd	f1, 50(r3)
	fmvfr	f1, r30
	lw	r30, 48(r3)				#lfd	f2, 48(r3)
	fmvfr	f2, r30
	lw	r30, 46(r3)				#lfd	f3, 46(r3)
	fmvfr	f3, r30
	lw	r2, 6(r3)
	lw	r28, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 66(r3)
	addi	r3, r3, 67
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -67
	lw	r30, 66(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30844:
	j	beq_cont.30842
beq_then.30841:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30842:
beq_cont.30840:
	j	beq_cont.30809
beq_then.30808:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30809:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30845
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30845:
	lw	r1, 42(r3)
	addi	r1, r1, 1
	lw	r2, 6(r3)
	lw	r28, 2(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.30807:
	lw	r1, 43(r3)
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30846
	lw	r1, 42(r3)
	addi	r1, r1, 1
	lw	r2, 6(r3)
	lw	r28, 2(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.30846:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30804:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30761:
	lw	r1, 8(r3)
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r1, r5, beq_then.30847
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r5, 6(r3)
	add	r30, r5, r1
	lw	r6, 0(r30)
	addi	r7, r0, -1				# li	r7, -1
	beq	r6, r7, beq_then.30848
	add	r30, r5, r1
	lw	r6, 0(r30)
	lw	r7, 4(r3)
	lw	r8, 3(r3)
	lw	r28, 5(r3)
	sw	r1, 66(r3)
	sw	r6, 67(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r8				# mr	r5, r8
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 68(r3)
	addi	r3, r3, 69
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -69
	lw	r30, 68(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 10(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	addi	r2, r0, 0				# li	r2, 0
	fmvtr	r30, f1
	sw	r30, 68(r3)				#stfd	f1, 68(r3)
	beq	r1, r2, beq_then.30849
	addi	r30, r0, 52429
	lui	r30, r30, 48716	# to load float		-0.200000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 70(r3)
	addi	r3, r3, 71
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -71
	lw	r30, 70(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30850
beq_then.30849:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30850:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30851
	addi	r30, r0, 55050
	lui	r30, r30, 15395	# to load float		0.010000
	fmvfr	f1, r30
	lw	r30, 68(r3)				#lfd	f2, 68(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 1(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	lw	r2, 3(r3)
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
	lw	r2, 6(r3)
	lw	r1, 0(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.30852
	lw	r5, 9(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r6, 5(r1)
	lw	r30, 0(r6)
	fmvfr	f4, r30
	fsub	f4, f2, f4
	lw	r6, 5(r1)
	lw	r30, 1(r6)
	fmvfr	f5, r30
	fsub	f5, f3, f5
	lw	r6, 5(r1)
	lw	r30, 2(r6)
	fmvfr	f6, r30
	fsub	f6, f1, f6
	lw	r6, 1(r1)
	addi	r7, r0, 1				# li	r7, 1
	fmvtr	r30, f1
	sw	r30, 70(r3)				#stfd	f1, 70(r3)
	fmvtr	r30, f3
	sw	r30, 72(r3)				#stfd	f3, 72(r3)
	fmvtr	r30, f2
	sw	r30, 74(r3)				#stfd	f2, 74(r3)
	beq	r6, r7, beq_then.30854
	addi	r7, r0, 2				# li	r7, 2
	beq	r6, r7, beq_then.30856
	fmvtr	r30, f4
	sw	r30, 76(r3)				#stfd	f4, 76(r3)
	fmvtr	r30, f6
	sw	r30, 78(r3)				#stfd	f6, 78(r3)
	fmvtr	r30, f5
	sw	r30, 80(r3)				#stfd	f5, 80(r3)
	sw	r1, 82(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 83(r3)
	addi	r3, r3, 84
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -84
	lw	r30, 83(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 82(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 80(r3)				#lfd	f2, 80(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 84(r3)				#stfd	f1, 84(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 86(r3)
	addi	r3, r3, 87
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -87
	lw	r30, 86(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 82(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 84(r3)				#lfd	f2, 84(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 78(r3)				#lfd	f2, 78(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 86(r3)				#stfd	f1, 86(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 88(r3)
	addi	r3, r3, 89
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -89
	lw	r30, 88(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 82(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 86(r3)				#lfd	f2, 86(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30859
	lw	r30, 78(r3)				#lfd	f2, 78(r3)
	fmvfr	f2, r30
	lw	r30, 80(r3)				#lfd	f3, 80(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f1, f1, f4
	lw	r30, 76(r3)				#lfd	f4, 76(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.30860
beq_then.30859:
beq_cont.30860:
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.30861
	j	beq_cont.30862
beq_then.30861:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.30862:
	lw	r1, 6(r1)
	sw	r1, 88(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 89(r3)
	addi	r3, r3, 90
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -90
	lw	r30, 89(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 88(r3)
	beq	r5, r2, beq_then.30863
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30865
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30866
beq_then.30865:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30866:
	j	beq_cont.30864
beq_then.30863:
beq_cont.30864:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30867
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30868
beq_then.30867:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30868:
	j	beq_cont.30857
beq_then.30856:
	lw	r6, 4(r1)
	lw	r30, 0(r6)
	fmvfr	f7, r30
	fmul	f4, f7, f4
	lw	r30, 1(r6)
	fmvfr	f7, r30
	fmul	f5, f7, f5
	fadd	f4, f4, f5
	lw	r30, 2(r6)
	fmvfr	f5, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	lw	r1, 6(r1)
	sw	r1, 89(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 90(r3)
	addi	r3, r3, 91
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -91
	lw	r30, 90(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 89(r3)
	beq	r5, r2, beq_then.30869
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30871
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30872
beq_then.30871:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30872:
	j	beq_cont.30870
beq_then.30869:
beq_cont.30870:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30873
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30874
beq_then.30873:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30874:
beq_cont.30857:
	j	beq_cont.30855
beq_then.30854:
	fmvtr	r30, f6
	sw	r30, 78(r3)				#stfd	f6, 78(r3)
	fmvtr	r30, f5
	sw	r30, 80(r3)				#stfd	f5, 80(r3)
	sw	r1, 82(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 90(r3)
	addi	r3, r3, 91
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -91
	lw	r30, 90(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 82(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 90(r3)
	addi	r3, r3, 91
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -91
	lw	r30, 90(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30875
	lw	r30, 80(r3)				#lfd	f1, 80(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 90(r3)
	addi	r3, r3, 91
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -91
	lw	r30, 90(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 82(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 90(r3)
	addi	r3, r3, 91
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -91
	lw	r30, 90(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30877
	lw	r30, 78(r3)				#lfd	f1, 78(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 90(r3)
	addi	r3, r3, 91
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -91
	lw	r30, 90(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 82(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 90(r3)
	addi	r3, r3, 91
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -91
	lw	r30, 90(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30878
beq_then.30877:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30878:
	j	beq_cont.30876
beq_then.30875:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30876:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30879
	lw	r1, 82(r3)
	lw	r1, 6(r1)
	j	beq_cont.30880
beq_then.30879:
	lw	r1, 82(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30881
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30882
beq_then.30881:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30882:
beq_cont.30880:
beq_cont.30855:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30883
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30884
beq_then.30883:
	lw	r2, 6(r3)
	lw	r1, 1(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.30885
	lw	r5, 9(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r30, 74(r3)				#lfd	f1, 74(r3)
	fmvfr	f1, r30
	lw	r30, 72(r3)				#lfd	f2, 72(r3)
	fmvfr	f2, r30
	lw	r30, 70(r3)				#lfd	f3, 70(r3)
	fmvfr	f3, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 90(r3)
	addi	r3, r3, 91
	jal	is_outside.2731				#	bl	is_outside.2731
	addi	r3, r3, -91
	lw	r30, 90(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30887
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30888
beq_then.30887:
	addi	r1, r0, 2				# li	r1, 2
	lw	r30, 74(r3)				#lfd	f1, 74(r3)
	fmvfr	f1, r30
	lw	r30, 72(r3)				#lfd	f2, 72(r3)
	fmvfr	f2, r30
	lw	r30, 70(r3)				#lfd	f3, 70(r3)
	fmvfr	f3, r30
	lw	r2, 6(r3)
	lw	r28, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 90(r3)
	addi	r3, r3, 91
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -91
	lw	r30, 90(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30888:
	j	beq_cont.30886
beq_then.30885:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30886:
beq_cont.30884:
	j	beq_cont.30853
beq_then.30852:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30853:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30889
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30889:
	lw	r1, 66(r3)
	addi	r1, r1, 1
	lw	r2, 6(r3)
	lw	r28, 2(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.30851:
	lw	r1, 67(r3)
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30890
	lw	r1, 66(r3)
	addi	r1, r1, 1
	lw	r2, 6(r3)
	lw	r28, 2(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.30890:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30848:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30847:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30750:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
shadow_check_one_or_group.2745:
	lw	r5, 9(r28)
	lw	r6, 8(r28)
	lw	r7, 7(r28)
	lw	r8, 6(r28)
	lw	r9, 5(r28)
	lw	r10, 4(r28)
	lw	r11, 3(r28)
	lw	r12, 2(r28)
	lw	r13, 1(r28)
	add	r30, r2, r1
	lw	r14, 0(r30)
	addi	r15, r0, -1				# li	r15, -1
	beq	r14, r15, beq_then.30891
	add	r30, r13, r14
	lw	r14, 0(r30)
	lw	r15, 0(r14)
	addi	r16, r0, -1				# li	r16, -1
	sw	r28, 0(r3)
	sw	r7, 1(r3)
	sw	r13, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	beq	r15, r16, beq_then.30892
	lw	r15, 0(r14)
	sw	r12, 5(r3)
	sw	r11, 6(r3)
	sw	r10, 7(r3)
	sw	r14, 8(r3)
	sw	r15, 9(r3)
	sw	r8, 10(r3)
	sw	r6, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r15				# mr	r1, r15
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r11				# mr	r5, r11
	sw	r30, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 11(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	addi	r2, r0, 0				# li	r2, 0
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	beq	r1, r2, beq_then.30894
	addi	r30, r0, 52429
	lui	r30, r30, 48716	# to load float		-0.200000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30895
beq_then.30894:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30895:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30896
	addi	r30, r0, 55050
	lui	r30, r30, 15395	# to load float		0.010000
	fmvfr	f1, r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 7(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	lw	r2, 6(r3)
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
	lw	r2, 8(r3)
	lw	r1, 0(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.30898
	lw	r5, 10(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r6, 5(r1)
	lw	r30, 0(r6)
	fmvfr	f4, r30
	fsub	f4, f2, f4
	lw	r6, 5(r1)
	lw	r30, 1(r6)
	fmvfr	f5, r30
	fsub	f5, f3, f5
	lw	r6, 5(r1)
	lw	r30, 2(r6)
	fmvfr	f6, r30
	fsub	f6, f1, f6
	lw	r6, 1(r1)
	addi	r7, r0, 1				# li	r7, 1
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	fmvtr	r30, f3
	sw	r30, 16(r3)				#stfd	f3, 16(r3)
	fmvtr	r30, f2
	sw	r30, 18(r3)				#stfd	f2, 18(r3)
	beq	r6, r7, beq_then.30900
	addi	r7, r0, 2				# li	r7, 2
	beq	r6, r7, beq_then.30902
	fmvtr	r30, f4
	sw	r30, 20(r3)				#stfd	f4, 20(r3)
	fmvtr	r30, f6
	sw	r30, 22(r3)				#stfd	f6, 22(r3)
	fmvtr	r30, f5
	sw	r30, 24(r3)				#stfd	f5, 24(r3)
	sw	r1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 27(r3)
	addi	r3, r3, 28
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -28
	lw	r30, 27(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 26(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 26(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
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
	lw	r1, 26(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.30905
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	lw	r30, 24(r3)				#lfd	f3, 24(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f1, f1, f4
	lw	r30, 20(r3)				#lfd	f4, 20(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.30906
beq_then.30905:
beq_cont.30906:
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.30907
	j	beq_cont.30908
beq_then.30907:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.30908:
	lw	r1, 6(r1)
	sw	r1, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 33(r3)
	addi	r3, r3, 34
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 32(r3)
	beq	r5, r2, beq_then.30909
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30911
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30912
beq_then.30911:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30912:
	j	beq_cont.30910
beq_then.30909:
beq_cont.30910:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30913
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30914
beq_then.30913:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30914:
	j	beq_cont.30903
beq_then.30902:
	lw	r6, 4(r1)
	lw	r30, 0(r6)
	fmvfr	f7, r30
	fmul	f4, f7, f4
	lw	r30, 1(r6)
	fmvfr	f7, r30
	fmul	f5, f7, f5
	fadd	f4, f4, f5
	lw	r30, 2(r6)
	fmvfr	f5, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	lw	r1, 6(r1)
	sw	r1, 33(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 33(r3)
	beq	r5, r2, beq_then.30915
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30917
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30918
beq_then.30917:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30918:
	j	beq_cont.30916
beq_then.30915:
beq_cont.30916:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30919
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30920
beq_then.30919:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30920:
beq_cont.30903:
	j	beq_cont.30901
beq_then.30900:
	fmvtr	r30, f6
	sw	r30, 22(r3)				#stfd	f6, 22(r3)
	fmvtr	r30, f5
	sw	r30, 24(r3)				#stfd	f5, 24(r3)
	sw	r1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 26(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30921
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 26(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30923
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 26(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30924
beq_then.30923:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30924:
	j	beq_cont.30922
beq_then.30921:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30922:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30925
	lw	r1, 26(r3)
	lw	r1, 6(r1)
	j	beq_cont.30926
beq_then.30925:
	lw	r1, 26(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30927
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30928
beq_then.30927:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30928:
beq_cont.30926:
beq_cont.30901:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30929
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30930
beq_then.30929:
	lw	r2, 8(r3)
	lw	r1, 1(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.30931
	lw	r5, 10(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	lw	r30, 14(r3)				#lfd	f3, 14(r3)
	fmvfr	f3, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	is_outside.2731				#	bl	is_outside.2731
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30933
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.30934
beq_then.30933:
	addi	r1, r0, 2				# li	r1, 2
	lw	r30, 18(r3)				#lfd	f1, 18(r3)
	fmvfr	f1, r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	lw	r30, 14(r3)				#lfd	f3, 14(r3)
	fmvfr	f3, r30
	lw	r2, 8(r3)
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30934:
	j	beq_cont.30932
beq_then.30931:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30932:
beq_cont.30930:
	j	beq_cont.30899
beq_then.30898:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30899:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30935
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.30936
beq_then.30935:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 8(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30936:
	j	beq_cont.30897
beq_then.30896:
	lw	r1, 9(r3)
	lw	r2, 10(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30937
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 8(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30938
beq_then.30937:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30938:
beq_cont.30897:
	j	beq_cont.30893
beq_then.30892:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30893:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30939
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30939:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.30940
	lw	r6, 2(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r28, 1(r3)
	sw	r1, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 35(r3)
	addi	r3, r3, 36
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -36
	lw	r30, 35(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30941
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30941:
	lw	r1, 34(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.30940:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30891:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
shadow_check_one_or_matrix.2748:
	lw	r5, 12(r28)
	lw	r6, 11(r28)
	lw	r7, 10(r28)
	lw	r8, 9(r28)
	lw	r9, 8(r28)
	lw	r10, 7(r28)
	lw	r11, 6(r28)
	lw	r12, 5(r28)
	lw	r13, 4(r28)
	lw	r14, 3(r28)
	lw	r15, 2(r28)
	lw	r16, 1(r28)
	add	r30, r2, r1
	lw	r17, 0(r30)
	lw	r18, 0(r17)
	addi	r19, r0, -1				# li	r19, -1
	beq	r18, r19, beq_then.30942
	addi	r19, r0, 99				# li	r19, 99
	sw	r11, 0(r3)
	sw	r16, 1(r3)
	sw	r17, 2(r3)
	sw	r28, 3(r3)
	sw	r10, 4(r3)
	sw	r9, 5(r3)
	sw	r14, 6(r3)
	sw	r13, 7(r3)
	sw	r8, 8(r3)
	sw	r2, 9(r3)
	sw	r1, 10(r3)
	beq	r18, r19, beq_then.30943
	add	r30, r12, r18
	lw	r12, 0(r30)
	lw	r30, 0(r14)
	fmvfr	f1, r30
	lw	r19, 5(r12)
	lw	r30, 0(r19)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 1(r14)
	fmvfr	f2, r30
	lw	r19, 5(r12)
	lw	r30, 1(r19)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	lw	r30, 2(r14)
	fmvfr	f3, r30
	lw	r19, 5(r12)
	lw	r30, 2(r19)
	fmvfr	f4, r30
	fsub	f3, f3, f4
	add	r30, r15, r18
	lw	r15, 0(r30)
	lw	r18, 1(r12)
	addi	r19, r0, 1				# li	r19, 1
	beq	r18, r19, beq_then.30945
	addi	r5, r0, 2				# li	r5, 2
	beq	r18, r5, beq_then.30947
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r15				# mr	r2, r15
	add	r1, r0, r12				# mr	r1, r12
	add	r28, r0, r6				# mr	r28, r6
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30948
beq_then.30947:
	lw	r30, 0(r15)
	fmvfr	f4, r30
	fmvtr	r30, f3
	sw	r30, 12(r3)				#stfd	f3, 12(r3)
	fmvtr	r30, f2
	sw	r30, 14(r3)				#stfd	f2, 14(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	sw	r15, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30950
	lw	r1, 18(r3)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 14(r3)				#lfd	f3, 14(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 3(r1)
	fmvfr	f2, r30
	lw	r30, 12(r3)				#lfd	f3, 12(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r1, 5(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.30951
beq_then.30950:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30951:
beq_cont.30948:
	j	beq_cont.30946
beq_then.30945:
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r12				# mr	r1, r12
	add	r28, r0, r7				# mr	r28, r7
	add	r5, r0, r15				# mr	r5, r15
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30946:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30952
	lw	r1, 5(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30954
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.30956
	lw	r5, 1(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r28, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30958
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.30959
beq_then.30958:
	addi	r1, r0, 2				# li	r1, 2
	lw	r2, 2(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30959:
	j	beq_cont.30957
beq_then.30956:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30957:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30960
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.30961
beq_then.30960:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30961:
	j	beq_cont.30955
beq_then.30954:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30955:
	j	beq_cont.30953
beq_then.30952:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30953:
	j	beq_cont.30944
beq_then.30943:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30944:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30962
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.30963
	lw	r5, 1(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
	lw	r28, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30965
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.30966
beq_then.30965:
	addi	r1, r0, 2				# li	r1, 2
	lw	r2, 2(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30966:
	j	beq_cont.30964
beq_then.30963:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30964:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30967
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30967:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	addi	r7, r0, -1				# li	r7, -1
	beq	r6, r7, beq_then.30968
	addi	r7, r0, 99				# li	r7, 99
	sw	r5, 19(r3)
	sw	r1, 20(r3)
	beq	r6, r7, beq_then.30969
	lw	r7, 7(r3)
	lw	r8, 6(r3)
	lw	r28, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r8				# mr	r5, r8
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30971
	lw	r1, 5(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30973
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 19(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30975
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.30976
beq_then.30975:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30976:
	j	beq_cont.30974
beq_then.30973:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30974:
	j	beq_cont.30972
beq_then.30971:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30972:
	j	beq_cont.30970
beq_then.30969:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30970:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30977
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 19(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30978
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30978:
	lw	r1, 20(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r28, 3(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.30977:
	lw	r1, 20(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r28, 3(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.30968:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30962:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	addi	r7, r0, -1				# li	r7, -1
	beq	r6, r7, beq_then.30979
	addi	r7, r0, 99				# li	r7, 99
	sw	r5, 21(r3)
	sw	r1, 22(r3)
	beq	r6, r7, beq_then.30980
	lw	r7, 7(r3)
	lw	r8, 6(r3)
	lw	r28, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r8				# mr	r5, r8
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30982
	lw	r1, 5(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30984
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 21(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30986
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.30987
beq_then.30986:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30987:
	j	beq_cont.30985
beq_then.30984:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30985:
	j	beq_cont.30983
beq_then.30982:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30983:
	j	beq_cont.30981
beq_then.30980:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.30981:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30988
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 21(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30989
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.30989:
	lw	r1, 22(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r28, 3(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.30988:
	lw	r1, 22(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r28, 3(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.30979:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.30942:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solve_each_element.2751:
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
	add	r30, r2, r1
	lw	r16, 0(r30)
	addi	r17, r0, -1				# li	r17, -1
	beq	r16, r17, beq_then.30990
	add	r30, r11, r16
	lw	r17, 0(r30)
	lw	r30, 0(r7)
	fmvfr	f1, r30
	lw	r18, 5(r17)
	lw	r30, 0(r18)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 1(r7)
	fmvfr	f2, r30
	lw	r18, 5(r17)
	lw	r30, 1(r18)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	lw	r30, 2(r7)
	fmvfr	f3, r30
	lw	r18, 5(r17)
	lw	r30, 2(r18)
	fmvfr	f4, r30
	fsub	f3, f3, f4
	lw	r18, 1(r17)
	addi	r19, r0, 1				# li	r19, 1
	sw	r12, 0(r3)
	sw	r14, 1(r3)
	sw	r13, 2(r3)
	sw	r15, 3(r3)
	sw	r7, 4(r3)
	sw	r6, 5(r3)
	sw	r10, 6(r3)
	sw	r5, 7(r3)
	sw	r2, 8(r3)
	sw	r28, 9(r3)
	sw	r1, 10(r3)
	sw	r16, 11(r3)
	sw	r11, 12(r3)
	beq	r18, r19, beq_then.30991
	addi	r9, r0, 2				# li	r9, 2
	beq	r18, r9, beq_then.30993
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r17				# mr	r1, r17
	add	r28, r0, r8				# mr	r28, r8
	sw	r30, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.30994
beq_then.30993:
	lw	r8, 4(r17)
	lw	r30, 0(r5)
	fmvfr	f4, r30
	lw	r30, 0(r8)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	lw	r30, 1(r5)
	fmvfr	f5, r30
	lw	r30, 1(r8)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	lw	r30, 2(r5)
	fmvfr	f5, r30
	lw	r30, 2(r8)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	fmvtr	r30, f4
	sw	r30, 14(r3)				#stfd	f4, 14(r3)
	fmvtr	r30, f3
	sw	r30, 16(r3)				#stfd	f3, 16(r3)
	fmvtr	r30, f2
	sw	r30, 18(r3)				#stfd	f2, 18(r3)
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	sw	r8, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30996
	lw	r1, 22(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r30, 18(r3)				#lfd	f3, 18(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 16(r3)				#lfd	f3, 16(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.30997
beq_then.30996:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.30997:
beq_cont.30994:
	j	beq_cont.30992
beq_then.30991:
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r17				# mr	r1, r17
	add	r28, r0, r9				# mr	r28, r9
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.30992:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30998
	lw	r2, 6(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 23(r3)
	fmvtr	r30, f2
	sw	r30, 24(r3)				#stfd	f2, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.30999
	lw	r1, 5(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31001
	addi	r30, r0, 55050
	lui	r30, r30, 15395	# to load float		0.010000
	fmvfr	f1, r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r5, 7(r3)
	lw	r30, 0(r5)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	lw	r1, 4(r3)
	lw	r30, 0(r1)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f3, f3, f1
	lw	r30, 1(r1)
	fmvfr	f4, r30
	fadd	f3, f3, f4
	lw	r30, 2(r5)
	fmvfr	f4, r30
	fmul	f4, f4, f1
	lw	r30, 2(r1)
	fmvfr	f5, r30
	fadd	f4, f4, f5
	lw	r2, 8(r3)
	lw	r1, 0(r2)
	addi	r6, r0, -1				# li	r6, -1
	fmvtr	r30, f4
	sw	r30, 26(r3)				#stfd	f4, 26(r3)
	fmvtr	r30, f3
	sw	r30, 28(r3)				#stfd	f3, 28(r3)
	fmvtr	r30, f2
	sw	r30, 30(r3)				#stfd	f2, 30(r3)
	fmvtr	r30, f1
	sw	r30, 32(r3)				#stfd	f1, 32(r3)
	beq	r1, r6, beq_then.31003
	lw	r6, 12(r3)
	add	r30, r6, r1
	lw	r1, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	is_outside.2731				#	bl	is_outside.2731
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31005
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31006
beq_then.31005:
	lw	r2, 8(r3)
	lw	r1, 1(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.31007
	lw	r5, 12(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r6, 5(r1)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r6, 5(r1)
	lw	r30, 1(r6)
	fmvfr	f3, r30
	lw	r30, 28(r3)				#lfd	f4, 28(r3)
	fmvfr	f4, r30
	fsub	f3, f4, f3
	lw	r6, 5(r1)
	lw	r30, 2(r6)
	fmvfr	f5, r30
	lw	r30, 26(r3)				#lfd	f6, 26(r3)
	fmvfr	f6, r30
	fsub	f5, f6, f5
	lw	r6, 1(r1)
	addi	r7, r0, 1				# li	r7, 1
	beq	r6, r7, beq_then.31009
	addi	r7, r0, 2				# li	r7, 2
	beq	r6, r7, beq_then.31011
	fmvtr	r30, f1
	sw	r30, 34(r3)				#stfd	f1, 34(r3)
	fmvtr	r30, f5
	sw	r30, 36(r3)				#stfd	f5, 36(r3)
	fmvtr	r30, f3
	sw	r30, 38(r3)				#stfd	f3, 38(r3)
	sw	r1, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 41(r3)
	addi	r3, r3, 42
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 40(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 38(r3)				#lfd	f2, 38(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 42(r3)				#stfd	f1, 42(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 40(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 42(r3)				#lfd	f2, 42(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 36(r3)				#lfd	f2, 36(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 44(r3)				#stfd	f1, 44(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 40(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 44(r3)				#lfd	f2, 44(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.31014
	lw	r30, 36(r3)				#lfd	f2, 36(r3)
	fmvfr	f2, r30
	lw	r30, 38(r3)				#lfd	f3, 38(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f1, f1, f4
	lw	r30, 34(r3)				#lfd	f4, 34(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.31015
beq_then.31014:
beq_cont.31015:
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.31016
	j	beq_cont.31017
beq_then.31016:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.31017:
	lw	r1, 6(r1)
	sw	r1, 46(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 47(r3)
	addi	r3, r3, 48
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 46(r3)
	beq	r5, r2, beq_then.31018
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31020
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31021
beq_then.31020:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31021:
	j	beq_cont.31019
beq_then.31018:
beq_cont.31019:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31022
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31023
beq_then.31022:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31023:
	j	beq_cont.31012
beq_then.31011:
	lw	r6, 4(r1)
	lw	r30, 0(r6)
	fmvfr	f7, r30
	fmul	f1, f7, f1
	lw	r30, 1(r6)
	fmvfr	f7, r30
	fmul	f3, f7, f3
	fadd	f1, f1, f3
	lw	r30, 2(r6)
	fmvfr	f3, r30
	fmul	f3, f3, f5
	fadd	f1, f1, f3
	lw	r1, 6(r1)
	sw	r1, 47(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 47(r3)
	beq	r5, r2, beq_then.31024
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31026
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31027
beq_then.31026:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31027:
	j	beq_cont.31025
beq_then.31024:
beq_cont.31025:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31028
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31029
beq_then.31028:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31029:
beq_cont.31012:
	j	beq_cont.31010
beq_then.31009:
	fmvtr	r30, f5
	sw	r30, 36(r3)				#stfd	f5, 36(r3)
	fmvtr	r30, f3
	sw	r30, 38(r3)				#stfd	f3, 38(r3)
	sw	r1, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 40(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31030
	lw	r30, 38(r3)				#lfd	f1, 38(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 40(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31032
	lw	r30, 36(r3)				#lfd	f1, 36(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 40(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31033
beq_then.31032:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31033:
	j	beq_cont.31031
beq_then.31030:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31031:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31034
	lw	r1, 40(r3)
	lw	r1, 6(r1)
	j	beq_cont.31035
beq_then.31034:
	lw	r1, 40(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31036
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31037
beq_then.31036:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31037:
beq_cont.31035:
beq_cont.31010:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31038
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31039
beq_then.31038:
	lw	r2, 8(r3)
	lw	r1, 2(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.31040
	lw	r5, 12(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r30, 30(r3)				#lfd	f1, 30(r3)
	fmvfr	f1, r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	lw	r30, 26(r3)				#lfd	f3, 26(r3)
	fmvfr	f3, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	is_outside.2731				#	bl	is_outside.2731
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31042
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31043
beq_then.31042:
	addi	r1, r0, 3				# li	r1, 3
	lw	r30, 30(r3)				#lfd	f1, 30(r3)
	fmvfr	f1, r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	lw	r30, 26(r3)				#lfd	f3, 26(r3)
	fmvfr	f3, r30
	lw	r2, 8(r3)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 48(r3)
	addi	r3, r3, 49
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31043:
	j	beq_cont.31041
beq_then.31040:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31041:
beq_cont.31039:
	j	beq_cont.31008
beq_then.31007:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31008:
beq_cont.31006:
	j	beq_cont.31004
beq_then.31003:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31004:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31044
	lw	r1, 5(r3)
	lw	r30, 32(r3)				#lfd	f1, 32(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r1, 2(r3)
	lw	r30, 30(r3)				#lfd	f1, 30(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 28(r3)				#lfd	f1, 28(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 26(r3)				#lfd	f1, 26(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r1, 1(r3)
	lw	r2, 11(r3)
	sw	r2, 0(r1)
	lw	r1, 0(r3)
	lw	r2, 23(r3)
	sw	r2, 0(r1)
	j	beq_cont.31045
beq_then.31044:
beq_cont.31045:
	j	beq_cont.31002
beq_then.31001:
beq_cont.31002:
	j	beq_cont.31000
beq_then.30999:
beq_cont.31000:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r28, 9(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.30998:
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31046
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r28, 9(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.31046:
	jr	r31				#	blr
beq_then.30990:
	jr	r31				#	blr
solve_one_or_network.2755:
	lw	r6, 2(r28)
	lw	r7, 1(r28)
	add	r30, r2, r1
	lw	r8, 0(r30)
	addi	r9, r0, -1				# li	r9, -1
	beq	r8, r9, beq_then.31049
	add	r30, r7, r8
	lw	r8, 0(r30)
	addi	r9, r0, 0				# li	r9, 0
	sw	r28, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r9				# mr	r1, r9
	add	r28, r0, r6				# mr	r28, r6
	sw	r30, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.31050
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	lw	r8, 1(r3)
	lw	r28, 2(r3)
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r30, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.31051
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	lw	r8, 1(r3)
	lw	r28, 2(r3)
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.31052
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	lw	r8, 1(r3)
	lw	r28, 2(r3)
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.31053
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	lw	r8, 1(r3)
	lw	r28, 2(r3)
	sw	r1, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r30, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 9(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.31054
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	lw	r8, 1(r3)
	lw	r28, 2(r3)
	sw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.31055
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	lw	r8, 1(r3)
	lw	r28, 2(r3)
	sw	r1, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r30, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.31056
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 1(r3)
	lw	r28, 2(r3)
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r30, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 12(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r5, 1(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.31056:
	jr	r31				#	blr
beq_then.31055:
	jr	r31				#	blr
beq_then.31054:
	jr	r31				#	blr
beq_then.31053:
	jr	r31				#	blr
beq_then.31052:
	jr	r31				#	blr
beq_then.31051:
	jr	r31				#	blr
beq_then.31050:
	jr	r31				#	blr
beq_then.31049:
	jr	r31				#	blr
trace_or_matrix.2759:
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
	add	r30, r2, r1
	lw	r16, 0(r30)
	lw	r17, 0(r16)
	addi	r18, r0, -1				# li	r18, -1
	beq	r17, r18, beq_then.31065
	addi	r18, r0, 99				# li	r18, 99
	sw	r28, 0(r3)
	sw	r6, 1(r3)
	sw	r10, 2(r3)
	sw	r7, 3(r3)
	sw	r11, 4(r3)
	sw	r12, 5(r3)
	sw	r5, 6(r3)
	sw	r13, 7(r3)
	sw	r15, 8(r3)
	sw	r2, 9(r3)
	sw	r1, 10(r3)
	beq	r17, r18, beq_then.31066
	add	r30, r14, r17
	lw	r14, 0(r30)
	lw	r30, 0(r7)
	fmvfr	f1, r30
	lw	r17, 5(r14)
	lw	r30, 0(r17)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 1(r7)
	fmvfr	f2, r30
	lw	r17, 5(r14)
	lw	r30, 1(r17)
	fmvfr	f3, r30
	fsub	f2, f2, f3
	lw	r30, 2(r7)
	fmvfr	f3, r30
	lw	r17, 5(r14)
	lw	r30, 2(r17)
	fmvfr	f4, r30
	fsub	f3, f3, f4
	lw	r17, 1(r14)
	addi	r18, r0, 1				# li	r18, 1
	sw	r16, 11(r3)
	beq	r17, r18, beq_then.31068
	addi	r9, r0, 2				# li	r9, 2
	beq	r17, r9, beq_then.31070
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r14				# mr	r1, r14
	add	r28, r0, r8				# mr	r28, r8
	sw	r30, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31071
beq_then.31070:
	lw	r8, 4(r14)
	lw	r30, 0(r5)
	fmvfr	f4, r30
	lw	r30, 0(r8)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	lw	r30, 1(r5)
	fmvfr	f5, r30
	lw	r30, 1(r8)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	lw	r30, 2(r5)
	fmvfr	f5, r30
	lw	r30, 2(r8)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	fmvtr	r30, f4
	sw	r30, 12(r3)				#stfd	f4, 12(r3)
	fmvtr	r30, f3
	sw	r30, 14(r3)				#stfd	f3, 14(r3)
	fmvtr	r30, f2
	sw	r30, 16(r3)				#stfd	f2, 16(r3)
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	sw	r8, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31072
	lw	r1, 20(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r30, 16(r3)				#lfd	f3, 16(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 14(r3)				#lfd	f3, 14(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 12(r3)				#lfd	f2, 12(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.31073
beq_then.31072:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31073:
beq_cont.31071:
	j	beq_cont.31069
beq_then.31068:
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r14				# mr	r1, r14
	add	r28, r0, r9				# mr	r28, r9
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31069:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31074
	lw	r1, 2(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r2, 1(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31076
	lw	r1, 11(r3)
	lw	r2, 1(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31078
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31080
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31082
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31084
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	lw	r2, 5(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31086
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	lw	r2, 6(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31088
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	lw	r2, 7(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31090
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 8				# li	r1, 8
	lw	r2, 11(r3)
	lw	r5, 6(r3)
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31091
beq_then.31090:
beq_cont.31091:
	j	beq_cont.31089
beq_then.31088:
beq_cont.31089:
	j	beq_cont.31087
beq_then.31086:
beq_cont.31087:
	j	beq_cont.31085
beq_then.31084:
beq_cont.31085:
	j	beq_cont.31083
beq_then.31082:
beq_cont.31083:
	j	beq_cont.31081
beq_then.31080:
beq_cont.31081:
	j	beq_cont.31079
beq_then.31078:
beq_cont.31079:
	j	beq_cont.31077
beq_then.31076:
beq_cont.31077:
	j	beq_cont.31075
beq_then.31074:
beq_cont.31075:
	j	beq_cont.31067
beq_then.31066:
	lw	r8, 1(r16)
	addi	r9, r0, -1				# li	r9, -1
	beq	r8, r9, beq_then.31092
	add	r30, r15, r8
	lw	r8, 0(r30)
	addi	r9, r0, 0				# li	r9, 0
	sw	r16, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r9				# mr	r1, r9
	add	r28, r0, r13				# mr	r28, r13
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31094
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31096
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31098
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	lw	r2, 5(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31100
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	lw	r2, 6(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31102
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	lw	r2, 7(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31104
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 8				# li	r1, 8
	lw	r2, 11(r3)
	lw	r5, 6(r3)
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31105
beq_then.31104:
beq_cont.31105:
	j	beq_cont.31103
beq_then.31102:
beq_cont.31103:
	j	beq_cont.31101
beq_then.31100:
beq_cont.31101:
	j	beq_cont.31099
beq_then.31098:
beq_cont.31099:
	j	beq_cont.31097
beq_then.31096:
beq_cont.31097:
	j	beq_cont.31095
beq_then.31094:
beq_cont.31095:
	j	beq_cont.31093
beq_then.31092:
beq_cont.31093:
beq_cont.31067:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	addi	r7, r0, -1				# li	r7, -1
	beq	r6, r7, beq_then.31106
	addi	r7, r0, 99				# li	r7, 99
	sw	r1, 21(r3)
	beq	r6, r7, beq_then.31107
	lw	r7, 6(r3)
	lw	r8, 3(r3)
	lw	r28, 4(r3)
	sw	r5, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r8				# mr	r5, r8
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31109
	lw	r1, 2(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r1, 1(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31111
	lw	r1, 22(r3)
	lw	r2, 1(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31113
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 22(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31115
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 22(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31117
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 22(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31119
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 22(r3)
	lw	r2, 5(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31121
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 22(r3)
	lw	r2, 6(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31123
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
	lw	r6, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 7				# li	r1, 7
	lw	r2, 22(r3)
	lw	r5, 6(r3)
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31124
beq_then.31123:
beq_cont.31124:
	j	beq_cont.31122
beq_then.31121:
beq_cont.31122:
	j	beq_cont.31120
beq_then.31119:
beq_cont.31120:
	j	beq_cont.31118
beq_then.31117:
beq_cont.31118:
	j	beq_cont.31116
beq_then.31115:
beq_cont.31116:
	j	beq_cont.31114
beq_then.31113:
beq_cont.31114:
	j	beq_cont.31112
beq_then.31111:
beq_cont.31112:
	j	beq_cont.31110
beq_then.31109:
beq_cont.31110:
	j	beq_cont.31108
beq_then.31107:
	lw	r6, 1(r5)
	addi	r7, r0, -1				# li	r7, -1
	beq	r6, r7, beq_then.31125
	lw	r7, 8(r3)
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r8, r0, 0				# li	r8, 0
	lw	r9, 6(r3)
	lw	r28, 7(r3)
	sw	r5, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 22(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31127
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 22(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31129
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 22(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31131
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 22(r3)
	lw	r2, 5(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31133
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 22(r3)
	lw	r2, 6(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31135
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
	lw	r6, 6(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 7				# li	r1, 7
	lw	r2, 22(r3)
	lw	r5, 6(r3)
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31136
beq_then.31135:
beq_cont.31136:
	j	beq_cont.31134
beq_then.31133:
beq_cont.31134:
	j	beq_cont.31132
beq_then.31131:
beq_cont.31132:
	j	beq_cont.31130
beq_then.31129:
beq_cont.31130:
	j	beq_cont.31128
beq_then.31127:
beq_cont.31128:
	j	beq_cont.31126
beq_then.31125:
beq_cont.31126:
beq_cont.31108:
	lw	r1, 21(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 6(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.31106:
	jr	r31				#	blr
beq_then.31065:
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
	beq	r16, r17, beq_then.31139
	add	r30, r10, r16
	lw	r17, 0(r30)
	lw	r18, 10(r17)
	lw	r30, 0(r18)
	fmvfr	f1, r30
	lw	r30, 1(r18)
	fmvfr	f2, r30
	lw	r30, 2(r18)
	fmvfr	f3, r30
	lw	r19, 1(r5)
	add	r30, r19, r16
	lw	r19, 0(r30)
	lw	r20, 1(r17)
	addi	r21, r0, 1				# li	r21, 1
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
	beq	r20, r21, beq_then.31140
	addi	r8, r0, 2				# li	r8, 2
	beq	r20, r8, beq_then.31142
	lw	r30, 0(r19)
	fmvfr	f4, r30
	sw	r17, 14(r3)
	fmvtr	r30, f4
	sw	r30, 16(r3)				#stfd	f4, 16(r3)
	sw	r18, 18(r3)
	fmvtr	r30, f3
	sw	r30, 20(r3)				#stfd	f3, 20(r3)
	fmvtr	r30, f2
	sw	r30, 22(r3)				#stfd	f2, 22(r3)
	fmvtr	r30, f1
	sw	r30, 24(r3)				#stfd	f1, 24(r3)
	sw	r19, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 27(r3)
	addi	r3, r3, 28
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -28
	lw	r30, 27(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31146
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31147
beq_then.31146:
	lw	r1, 26(r3)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 22(r3)				#lfd	f3, 22(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 3(r1)
	fmvfr	f2, r30
	lw	r30, 20(r3)				#lfd	f3, 20(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r2, 18(r3)
	lw	r30, 3(r2)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	fmvtr	r30, f2
	sw	r30, 30(r3)				#stfd	f2, 30(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	lw	r30, 16(r3)				#lfd	f3, 16(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 32(r3)				#stfd	f1, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31149
	lw	r1, 14(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31151
	lw	r30, 32(r3)				#lfd	f1, 32(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 26(r3)
	lw	r30, 4(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 7(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	j	beq_cont.31152
beq_then.31151:
	lw	r30, 32(r3)				#lfd	f1, 32(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 26(r3)
	lw	r30, 4(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 7(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
beq_cont.31152:
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.31150
beq_then.31149:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31150:
beq_cont.31147:
	j	beq_cont.31143
beq_then.31142:
	lw	r30, 0(r19)
	fmvfr	f1, r30
	sw	r18, 18(r3)
	sw	r19, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31153
	lw	r1, 26(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r1, 18(r3)
	lw	r30, 3(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 7(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.31154
beq_then.31153:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31154:
beq_cont.31143:
	j	beq_cont.31141
beq_then.31140:
	lw	r18, 0(r5)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r19				# mr	r5, r19
	add	r2, r0, r18				# mr	r2, r18
	add	r1, r0, r17				# mr	r1, r17
	add	r28, r0, r8				# mr	r28, r8
	sw	r30, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31141:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31155
	lw	r2, 7(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 34(r3)
	fmvtr	r30, f2
	sw	r30, 36(r3)				#stfd	f2, 36(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31157
	lw	r1, 6(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	lw	r30, 36(r3)				#lfd	f1, 36(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31159
	addi	r30, r0, 55050
	lui	r30, r30, 15395	# to load float		0.010000
	fmvfr	f1, r30
	lw	r30, 36(r3)				#lfd	f2, 36(r3)
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
	lw	r2, 9(r3)
	lw	r1, 0(r2)
	addi	r5, r0, -1				# li	r5, -1
	fmvtr	r30, f4
	sw	r30, 38(r3)				#stfd	f4, 38(r3)
	fmvtr	r30, f3
	sw	r30, 40(r3)				#stfd	f3, 40(r3)
	fmvtr	r30, f2
	sw	r30, 42(r3)				#stfd	f2, 42(r3)
	fmvtr	r30, f1
	sw	r30, 44(r3)				#stfd	f1, 44(r3)
	beq	r1, r5, beq_then.31161
	lw	r5, 13(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	is_outside.2731				#	bl	is_outside.2731
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31163
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31164
beq_then.31163:
	lw	r2, 9(r3)
	lw	r1, 1(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.31165
	lw	r5, 13(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r6, 5(r1)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r30, 42(r3)				#lfd	f2, 42(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r6, 5(r1)
	lw	r30, 1(r6)
	fmvfr	f3, r30
	lw	r30, 40(r3)				#lfd	f4, 40(r3)
	fmvfr	f4, r30
	fsub	f3, f4, f3
	lw	r6, 5(r1)
	lw	r30, 2(r6)
	fmvfr	f5, r30
	lw	r30, 38(r3)				#lfd	f6, 38(r3)
	fmvfr	f6, r30
	fsub	f5, f6, f5
	lw	r6, 1(r1)
	addi	r7, r0, 1				# li	r7, 1
	beq	r6, r7, beq_then.31167
	addi	r7, r0, 2				# li	r7, 2
	beq	r6, r7, beq_then.31169
	fmvtr	r30, f1
	sw	r30, 46(r3)				#stfd	f1, 46(r3)
	fmvtr	r30, f5
	sw	r30, 48(r3)				#stfd	f5, 48(r3)
	fmvtr	r30, f3
	sw	r30, 50(r3)				#stfd	f3, 50(r3)
	sw	r1, 52(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 53(r3)
	addi	r3, r3, 54
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -54
	lw	r30, 53(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 52(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 50(r3)				#lfd	f2, 50(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 54(r3)				#stfd	f1, 54(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 56(r3)
	addi	r3, r3, 57
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -57
	lw	r30, 56(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 52(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 54(r3)				#lfd	f2, 54(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 48(r3)				#lfd	f2, 48(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 56(r3)				#stfd	f1, 56(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 58(r3)
	addi	r3, r3, 59
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -59
	lw	r30, 58(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 52(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 56(r3)				#lfd	f2, 56(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r2, 3(r1)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.31172
	lw	r30, 48(r3)				#lfd	f2, 48(r3)
	fmvfr	f2, r30
	lw	r30, 50(r3)				#lfd	f3, 50(r3)
	fmvfr	f3, r30
	fmul	f4, f3, f2
	lw	r2, 9(r1)
	lw	r30, 0(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f1, f1, f4
	lw	r30, 46(r3)				#lfd	f4, 46(r3)
	fmvfr	f4, r30
	fmul	f2, f2, f4
	lw	r2, 9(r1)
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	fmul	f2, f4, f3
	lw	r2, 9(r1)
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	j	beq_cont.31173
beq_then.31172:
beq_cont.31173:
	lw	r2, 1(r1)
	addi	r5, r0, 3				# li	r5, 3
	beq	r2, r5, beq_then.31174
	j	beq_cont.31175
beq_then.31174:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fsub	f1, f1, f2
beq_cont.31175:
	lw	r1, 6(r1)
	sw	r1, 58(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 59(r3)
	addi	r3, r3, 60
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -60
	lw	r30, 59(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 58(r3)
	beq	r5, r2, beq_then.31176
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31178
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31179
beq_then.31178:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31179:
	j	beq_cont.31177
beq_then.31176:
beq_cont.31177:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31180
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31181
beq_then.31180:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31181:
	j	beq_cont.31170
beq_then.31169:
	lw	r6, 4(r1)
	lw	r30, 0(r6)
	fmvfr	f7, r30
	fmul	f1, f7, f1
	lw	r30, 1(r6)
	fmvfr	f7, r30
	fmul	f3, f7, f3
	fadd	f1, f1, f3
	lw	r30, 2(r6)
	fmvfr	f3, r30
	fmul	f3, f3, f5
	fadd	f1, f1, f3
	lw	r1, 6(r1)
	sw	r1, 59(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 60(r3)
	addi	r3, r3, 61
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 59(r3)
	beq	r5, r2, beq_then.31182
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31184
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31185
beq_then.31184:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31185:
	j	beq_cont.31183
beq_then.31182:
beq_cont.31183:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31186
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31187
beq_then.31186:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31187:
beq_cont.31170:
	j	beq_cont.31168
beq_then.31167:
	fmvtr	r30, f5
	sw	r30, 48(r3)				#stfd	f5, 48(r3)
	fmvtr	r30, f3
	sw	r30, 50(r3)				#stfd	f3, 50(r3)
	sw	r1, 52(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 60(r3)
	addi	r3, r3, 61
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 52(r3)
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 60(r3)
	addi	r3, r3, 61
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31188
	lw	r30, 50(r3)				#lfd	f1, 50(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 60(r3)
	addi	r3, r3, 61
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 52(r3)
	lw	r2, 4(r1)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 60(r3)
	addi	r3, r3, 61
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31190
	lw	r30, 48(r3)				#lfd	f1, 48(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 60(r3)
	addi	r3, r3, 61
	jal	lib_fabs				#	bl	lib_fabs
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 52(r3)
	lw	r2, 4(r1)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 60(r3)
	addi	r3, r3, 61
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31191
beq_then.31190:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31191:
	j	beq_cont.31189
beq_then.31188:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31189:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31192
	lw	r1, 52(r3)
	lw	r1, 6(r1)
	j	beq_cont.31193
beq_then.31192:
	lw	r1, 52(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31194
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31195
beq_then.31194:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31195:
beq_cont.31193:
beq_cont.31168:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31196
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31197
beq_then.31196:
	lw	r2, 9(r3)
	lw	r1, 2(r2)
	addi	r5, r0, -1				# li	r5, -1
	beq	r1, r5, beq_then.31198
	lw	r5, 13(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r30, 42(r3)				#lfd	f1, 42(r3)
	fmvfr	f1, r30
	lw	r30, 40(r3)				#lfd	f2, 40(r3)
	fmvfr	f2, r30
	lw	r30, 38(r3)				#lfd	f3, 38(r3)
	fmvfr	f3, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 60(r3)
	addi	r3, r3, 61
	jal	is_outside.2731				#	bl	is_outside.2731
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31200
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31201
beq_then.31200:
	addi	r1, r0, 3				# li	r1, 3
	lw	r30, 42(r3)				#lfd	f1, 42(r3)
	fmvfr	f1, r30
	lw	r30, 40(r3)				#lfd	f2, 40(r3)
	fmvfr	f2, r30
	lw	r30, 38(r3)				#lfd	f3, 38(r3)
	fmvfr	f3, r30
	lw	r2, 9(r3)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 60(r3)
	addi	r3, r3, 61
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31201:
	j	beq_cont.31199
beq_then.31198:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31199:
beq_cont.31197:
	j	beq_cont.31166
beq_then.31165:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31166:
beq_cont.31164:
	j	beq_cont.31162
beq_then.31161:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31162:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31202
	lw	r1, 6(r3)
	lw	r30, 44(r3)				#lfd	f1, 44(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r1, 2(r3)
	lw	r30, 42(r3)				#lfd	f1, 42(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 40(r3)				#lfd	f1, 40(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 38(r3)				#lfd	f1, 38(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r1, 1(r3)
	lw	r2, 12(r3)
	sw	r2, 0(r1)
	lw	r1, 0(r3)
	lw	r2, 34(r3)
	sw	r2, 0(r1)
	j	beq_cont.31203
beq_then.31202:
beq_cont.31203:
	j	beq_cont.31160
beq_then.31159:
beq_cont.31160:
	j	beq_cont.31158
beq_then.31157:
beq_cont.31158:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r28, 10(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.31155:
	lw	r1, 12(r3)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31204
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r28, 10(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.31204:
	jr	r31				#	blr
beq_then.31139:
	jr	r31				#	blr
solve_one_or_network_fast.2769:
	lw	r6, 2(r28)
	lw	r7, 1(r28)
	add	r30, r2, r1
	lw	r8, 0(r30)
	addi	r9, r0, -1				# li	r9, -1
	beq	r8, r9, beq_then.31207
	add	r30, r7, r8
	lw	r8, 0(r30)
	addi	r9, r0, 0				# li	r9, 0
	sw	r28, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r9				# mr	r1, r9
	add	r28, r0, r6				# mr	r28, r6
	sw	r30, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.31208
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	lw	r8, 1(r3)
	lw	r28, 2(r3)
	sw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r30, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.31209
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	lw	r8, 1(r3)
	lw	r28, 2(r3)
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r30, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.31210
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	lw	r8, 1(r3)
	lw	r28, 2(r3)
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.31211
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	lw	r8, 1(r3)
	lw	r28, 2(r3)
	sw	r1, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r30, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 9(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.31212
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	lw	r8, 1(r3)
	lw	r28, 2(r3)
	sw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.31213
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	lw	r8, 1(r3)
	lw	r28, 2(r3)
	sw	r1, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r30, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.31214
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 1(r3)
	lw	r28, 2(r3)
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r30, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 12(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r5, 1(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.31214:
	jr	r31				#	blr
beq_then.31213:
	jr	r31				#	blr
beq_then.31212:
	jr	r31				#	blr
beq_then.31211:
	jr	r31				#	blr
beq_then.31210:
	jr	r31				#	blr
beq_then.31209:
	jr	r31				#	blr
beq_then.31208:
	jr	r31				#	blr
beq_then.31207:
	jr	r31				#	blr
trace_or_matrix_fast.2773:
	lw	r6, 8(r28)
	lw	r7, 7(r28)
	lw	r8, 6(r28)
	lw	r9, 5(r28)
	lw	r10, 4(r28)
	lw	r11, 3(r28)
	lw	r12, 2(r28)
	lw	r13, 1(r28)
	add	r30, r2, r1
	lw	r14, 0(r30)
	lw	r15, 0(r14)
	addi	r16, r0, -1				# li	r16, -1
	beq	r15, r16, beq_then.31223
	addi	r16, r0, 99				# li	r16, 99
	sw	r28, 0(r3)
	sw	r6, 1(r3)
	sw	r9, 2(r3)
	sw	r8, 3(r3)
	sw	r10, 4(r3)
	sw	r5, 5(r3)
	sw	r11, 6(r3)
	sw	r13, 7(r3)
	sw	r2, 8(r3)
	sw	r1, 9(r3)
	beq	r15, r16, beq_then.31224
	add	r30, r12, r15
	lw	r12, 0(r30)
	lw	r16, 10(r12)
	lw	r30, 0(r16)
	fmvfr	f1, r30
	lw	r30, 1(r16)
	fmvfr	f2, r30
	lw	r30, 2(r16)
	fmvfr	f3, r30
	lw	r17, 1(r5)
	add	r30, r17, r15
	lw	r15, 0(r30)
	lw	r17, 1(r12)
	addi	r18, r0, 1				# li	r18, 1
	sw	r14, 10(r3)
	beq	r17, r18, beq_then.31226
	addi	r7, r0, 2				# li	r7, 2
	beq	r17, r7, beq_then.31228
	lw	r30, 0(r15)
	fmvfr	f4, r30
	sw	r12, 11(r3)
	fmvtr	r30, f4
	sw	r30, 12(r3)				#stfd	f4, 12(r3)
	sw	r16, 14(r3)
	fmvtr	r30, f3
	sw	r30, 16(r3)				#stfd	f3, 16(r3)
	fmvtr	r30, f2
	sw	r30, 18(r3)				#stfd	f2, 18(r3)
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	sw	r15, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31231
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.31232
beq_then.31231:
	lw	r1, 22(r3)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 18(r3)				#lfd	f3, 18(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 3(r1)
	fmvfr	f2, r30
	lw	r30, 16(r3)				#lfd	f3, 16(r3)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r2, 14(r3)
	lw	r30, 3(r2)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 24(r3)				#stfd	f1, 24(r3)
	fmvtr	r30, f2
	sw	r30, 26(r3)				#stfd	f2, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	lw	r30, 12(r3)				#lfd	f3, 12(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fsub	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31234
	lw	r1, 11(r3)
	lw	r1, 6(r1)
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31236
	lw	r30, 28(r3)				#lfd	f1, 28(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 22(r3)
	lw	r30, 4(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	j	beq_cont.31237
beq_then.31236:
	lw	r30, 28(r3)				#lfd	f1, 28(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	lw	r1, 22(r3)
	lw	r30, 4(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
beq_cont.31237:
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.31235
beq_then.31234:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31235:
beq_cont.31232:
	j	beq_cont.31229
beq_then.31228:
	lw	r30, 0(r15)
	fmvfr	f1, r30
	sw	r16, 14(r3)
	sw	r15, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31238
	lw	r1, 22(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r1, 14(r3)
	lw	r30, 3(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 2(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.31239
beq_then.31238:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31239:
beq_cont.31229:
	j	beq_cont.31227
beq_then.31226:
	lw	r16, 0(r5)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r15				# mr	r5, r15
	add	r2, r0, r16				# mr	r2, r16
	add	r1, r0, r12				# mr	r1, r12
	add	r28, r0, r7				# mr	r28, r7
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31227:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31240
	lw	r1, 2(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r2, 1(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31242
	lw	r1, 10(r3)
	lw	r2, 1(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31244
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31246
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31248
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31250
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	lw	r2, 5(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31252
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	lw	r2, 6(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31254
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	lw	r2, 7(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31256
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 8				# li	r1, 8
	lw	r2, 10(r3)
	lw	r5, 5(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31257
beq_then.31256:
beq_cont.31257:
	j	beq_cont.31255
beq_then.31254:
beq_cont.31255:
	j	beq_cont.31253
beq_then.31252:
beq_cont.31253:
	j	beq_cont.31251
beq_then.31250:
beq_cont.31251:
	j	beq_cont.31249
beq_then.31248:
beq_cont.31249:
	j	beq_cont.31247
beq_then.31246:
beq_cont.31247:
	j	beq_cont.31245
beq_then.31244:
beq_cont.31245:
	j	beq_cont.31243
beq_then.31242:
beq_cont.31243:
	j	beq_cont.31241
beq_then.31240:
beq_cont.31241:
	j	beq_cont.31225
beq_then.31224:
	lw	r7, 1(r14)
	addi	r12, r0, -1				# li	r12, -1
	beq	r7, r12, beq_then.31258
	add	r30, r13, r7
	lw	r7, 0(r30)
	addi	r12, r0, 0				# li	r12, 0
	sw	r14, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r12				# mr	r1, r12
	add	r28, r0, r11				# mr	r28, r11
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31260
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31262
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31264
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	lw	r2, 5(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31266
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	lw	r2, 6(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31268
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	lw	r2, 7(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31270
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 8				# li	r1, 8
	lw	r2, 10(r3)
	lw	r5, 5(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31271
beq_then.31270:
beq_cont.31271:
	j	beq_cont.31269
beq_then.31268:
beq_cont.31269:
	j	beq_cont.31267
beq_then.31266:
beq_cont.31267:
	j	beq_cont.31265
beq_then.31264:
beq_cont.31265:
	j	beq_cont.31263
beq_then.31262:
beq_cont.31263:
	j	beq_cont.31261
beq_then.31260:
beq_cont.31261:
	j	beq_cont.31259
beq_then.31258:
beq_cont.31259:
beq_cont.31225:
	lw	r1, 9(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	addi	r7, r0, -1				# li	r7, -1
	beq	r6, r7, beq_then.31272
	addi	r7, r0, 99				# li	r7, 99
	sw	r1, 30(r3)
	beq	r6, r7, beq_then.31273
	lw	r7, 5(r3)
	lw	r28, 3(r3)
	sw	r5, 31(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31275
	lw	r1, 2(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r1, 1(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31277
	lw	r1, 31(r3)
	lw	r2, 1(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31279
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 31(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31281
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 31(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31283
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 31(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31285
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 31(r3)
	lw	r2, 5(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31287
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 31(r3)
	lw	r2, 6(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31289
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
	lw	r6, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 7				# li	r1, 7
	lw	r2, 31(r3)
	lw	r5, 5(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31290
beq_then.31289:
beq_cont.31290:
	j	beq_cont.31288
beq_then.31287:
beq_cont.31288:
	j	beq_cont.31286
beq_then.31285:
beq_cont.31286:
	j	beq_cont.31284
beq_then.31283:
beq_cont.31284:
	j	beq_cont.31282
beq_then.31281:
beq_cont.31282:
	j	beq_cont.31280
beq_then.31279:
beq_cont.31280:
	j	beq_cont.31278
beq_then.31277:
beq_cont.31278:
	j	beq_cont.31276
beq_then.31275:
beq_cont.31276:
	j	beq_cont.31274
beq_then.31273:
	lw	r6, 1(r5)
	addi	r7, r0, -1				# li	r7, -1
	beq	r6, r7, beq_then.31291
	lw	r7, 7(r3)
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r8, r0, 0				# li	r8, 0
	lw	r9, 5(r3)
	lw	r28, 6(r3)
	sw	r5, 31(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 31(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31293
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 31(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31295
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 31(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31297
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 31(r3)
	lw	r2, 5(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31299
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 31(r3)
	lw	r2, 6(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31301
	lw	r5, 7(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
	lw	r6, 5(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 7				# li	r1, 7
	lw	r2, 31(r3)
	lw	r5, 5(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31302
beq_then.31301:
beq_cont.31302:
	j	beq_cont.31300
beq_then.31299:
beq_cont.31300:
	j	beq_cont.31298
beq_then.31297:
beq_cont.31298:
	j	beq_cont.31296
beq_then.31295:
beq_cont.31296:
	j	beq_cont.31294
beq_then.31293:
beq_cont.31294:
	j	beq_cont.31292
beq_then.31291:
beq_cont.31292:
beq_cont.31274:
	lw	r1, 30(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 5(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.31272:
	jr	r31				#	blr
beq_then.31223:
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
	beq	r5, r6, beq_then.31305
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
	j	beq_cont.31306
beq_then.31305:
	fmvtr	r30, f4
	sw	r30, 0(r2)
	fmvtr	r30, f5
	sw	r30, 1(r2)
	fmvtr	r30, f6
	sw	r30, 2(r2)
beq_cont.31306:
	lw	r1, 1(r3)
	lw	r1, 6(r1)
	lw	r2, 0(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	sw	r1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	lw	r30, 1(r1)
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
	lw	r1, 0(r3)
	lw	r30, 2(r1)
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
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31308
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	j	beq_cont.31309
beq_then.31308:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 14(r3)
	beq	r2, r1, beq_then.31310
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	j	beq_cont.31311
beq_then.31310:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
beq_cont.31311:
beq_cont.31309:
	lw	r1, 0(r3)
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
	beq	r6, r7, beq_then.31313
	addi	r7, r0, 2				# li	r7, 2
	beq	r6, r7, beq_then.31314
	addi	r7, r0, 3				# li	r7, 3
	beq	r6, r7, beq_then.31315
	addi	r7, r0, 4				# li	r7, 4
	beq	r6, r7, beq_then.31316
	jr	r31				#	blr
beq_then.31316:
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
	beq	r1, r2, beq_then.31319
	addi	r30, r0, 0
	lui	r30, r30, 16752	# to load float		15.000000
	fmvfr	f1, r30
	j	beq_cont.31320
beq_then.31319:
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
beq_cont.31320:
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
	beq	r1, r2, beq_then.31321
	addi	r30, r0, 0
	lui	r30, r30, 16752	# to load float		15.000000
	fmvfr	f1, r30
	j	beq_cont.31322
beq_then.31321:
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
beq_cont.31322:
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
	beq	r1, r2, beq_then.31323
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.31324
beq_then.31323:
	lw	r30, 32(r3)				#lfd	f1, 32(r3)
	fmvfr	f1, r30
beq_cont.31324:
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
beq_then.31315:
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
beq_then.31314:
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
beq_then.31313:
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
	beq	r5, r2, beq_then.31329
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31331
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f1, r30
	j	beq_cont.31332
beq_then.31331:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
beq_cont.31332:
	j	beq_cont.31330
beq_then.31329:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31333
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.31334
beq_then.31333:
	addi	r30, r0, 0
	lui	r30, r30, 17279	# to load float		255.000000
	fmvfr	f1, r30
beq_cont.31334:
beq_cont.31330:
	lw	r1, 0(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	jr	r31				#	blr
trace_reflections.2795:
	lw	r5, 19(r28)
	lw	r6, 18(r28)
	lw	r7, 17(r28)
	lw	r8, 16(r28)
	lw	r9, 15(r28)
	lw	r10, 14(r28)
	lw	r11, 13(r28)
	lw	r12, 12(r28)
	lw	r13, 11(r28)
	lw	r14, 10(r28)
	lw	r15, 9(r28)
	lw	r16, 8(r28)
	lw	r17, 7(r28)
	lw	r18, 6(r28)
	lw	r19, 5(r28)
	lw	r20, 4(r28)
	lw	r21, 3(r28)
	lw	r22, 2(r28)
	lw	r23, 1(r28)
	addi	r24, r0, 0				# li	r24, 0
	ble	r24, r1, ble_then.31336
	jr	r31				#	blr
ble_then.31336:
	add	r30, r16, r1
	lw	r24, 0(r30)
	lw	r25, 1(r24)
	addi	r30, r0, 27432
	lui	r30, r30, 20078	# to load float		1000000000.000000
	fmvfr	f3, r30
	fmvtr	r30, f3
	sw	r30, 0(r6)
	addi	r26, r0, 0				# li	r26, 0
	lw	r27, 0(r17)
	sw	r28, 0(r3)
	sw	r5, 1(r3)
	sw	r8, 2(r3)
	sw	r11, 3(r3)
	sw	r12, 4(r3)
	sw	r23, 5(r3)
	sw	r16, 6(r3)
	sw	r1, 7(r3)
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	sw	r7, 10(r3)
	sw	r15, 11(r3)
	sw	r2, 12(r3)
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	sw	r18, 16(r3)
	sw	r25, 17(r3)
	sw	r13, 18(r3)
	sw	r14, 19(r3)
	sw	r10, 20(r3)
	sw	r21, 21(r3)
	sw	r19, 22(r3)
	sw	r9, 23(r3)
	sw	r17, 24(r3)
	sw	r24, 25(r3)
	sw	r20, 26(r3)
	sw	r22, 27(r3)
	sw	r6, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r27				# mr	r2, r27
	add	r1, r0, r26				# mr	r1, r26
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r25				# mr	r5, r25
	sw	r30, 29(r3)
	addi	r3, r3, 30
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -30
	lw	r30, 29(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 28(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f1, r30
	fmvtr	r30, f2
	sw	r30, 30(r3)				#stfd	f2, 30(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31340
	addi	r30, r0, 48160
	lui	r30, r30, 19646	# to load float		100000000.000000
	fmvfr	f2, r30
	lw	r30, 30(r3)				#lfd	f1, 30(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31341
beq_then.31340:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31341:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31342
	lw	r1, 27(r3)
	lw	r2, 0(r1)
	slli	r2, r2, 2
	lw	r5, 26(r3)
	lw	r6, 0(r5)
	add	r2, r2, r6
	lw	r6, 25(r3)
	lw	r7, 0(r6)
	beq	r2, r7, beq_then.31344
	j	beq_cont.31345
beq_then.31344:
	lw	r2, 24(r3)
	lw	r7, 0(r2)
	lw	r8, 0(r7)
	lw	r9, 0(r8)
	addi	r10, r0, -1				# li	r10, -1
	beq	r9, r10, beq_then.31346
	addi	r10, r0, 99				# li	r10, 99
	sw	r8, 32(r3)
	sw	r7, 33(r3)
	beq	r9, r10, beq_then.31348
	lw	r10, 22(r3)
	lw	r11, 21(r3)
	lw	r28, 23(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r11				# mr	r5, r11
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r9				# mr	r1, r9
	sw	r30, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31350
	lw	r1, 20(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31352
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 32(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31354
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.31355
beq_then.31354:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31355:
	j	beq_cont.31353
beq_then.31352:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31353:
	j	beq_cont.31351
beq_then.31350:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31351:
	j	beq_cont.31349
beq_then.31348:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31349:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31356
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 32(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31358
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.31359
beq_then.31358:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 33(r3)
	lw	r28, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31359:
	j	beq_cont.31357
beq_then.31356:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 33(r3)
	lw	r28, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31357:
	j	beq_cont.31347
beq_then.31346:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31347:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31360
	j	beq_cont.31361
beq_then.31360:
	lw	r1, 17(r3)
	lw	r2, 0(r1)
	lw	r5, 16(r3)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r5)
	fmvfr	f2, r30
	lw	r30, 1(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r5)
	fmvfr	f2, r30
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r2, 25(r3)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 14(r3)				#lfd	f3, 14(r3)
	fmvfr	f3, r30
	fmul	f4, f2, f3
	fmul	f1, f4, f1
	lw	r1, 0(r1)
	lw	r2, 12(r3)
	lw	r30, 0(r2)
	fmvfr	f4, r30
	lw	r30, 0(r1)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	lw	r30, 1(r2)
	fmvfr	f5, r30
	lw	r30, 1(r1)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	lw	r30, 2(r2)
	fmvfr	f5, r30
	lw	r30, 2(r1)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	fmul	f2, f2, f4
	fmvtr	r30, f2
	sw	r30, 34(r3)				#stfd	f2, 34(r3)
	fmvtr	r30, f1
	sw	r30, 36(r3)				#stfd	f1, 36(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31362
	lw	r1, 11(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r2, 10(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r30, 36(r3)				#lfd	f3, 36(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f2, f3, f2
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f2, f3, f2
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r1)
	j	beq_cont.31363
beq_then.31362:
beq_cont.31363:
	lw	r30, 34(r3)				#lfd	f1, 34(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31364
	lw	r30, 34(r3)				#lfd	f1, 34(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 11(r3)
	lw	r30, 0(r1)
	fmvfr	f3, r30
	fadd	f3, f3, f1
	fmvtr	r30, f3
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f3, r30
	fadd	f3, f3, f1
	fmvtr	r30, f3
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f3, r30
	fadd	f1, f3, f1
	fmvtr	r30, f1
	sw	r30, 2(r1)
	j	beq_cont.31365
beq_then.31364:
beq_cont.31365:
beq_cont.31361:
beq_cont.31345:
	j	beq_cont.31343
beq_then.31342:
beq_cont.31343:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 7(r3)
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31366
	jr	r31				#	blr
ble_then.31366:
	lw	r2, 6(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 1(r2)
	addi	r30, r0, 27432
	lui	r30, r30, 20078	# to load float		1000000000.000000
	fmvfr	f1, r30
	lw	r6, 28(r3)
	fmvtr	r30, f1
	sw	r30, 0(r6)
	lw	r7, 24(r3)
	lw	r8, 0(r7)
	lw	r9, 0(r8)
	lw	r10, 0(r9)
	addi	r11, r0, -1				# li	r11, -1
	sw	r1, 38(r3)
	sw	r5, 39(r3)
	sw	r2, 40(r3)
	beq	r10, r11, beq_then.31368
	addi	r11, r0, 99				# li	r11, 99
	sw	r8, 41(r3)
	beq	r10, r11, beq_then.31370
	lw	r28, 2(r3)
	sw	r9, 42(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 43(r3)
	addi	r3, r3, 44
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31372
	lw	r1, 20(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r1, 28(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 43(r3)
	addi	r3, r3, 44
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31374
	lw	r1, 42(r3)
	lw	r2, 1(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31376
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 39(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 43(r3)
	addi	r3, r3, 44
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 42(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31378
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 39(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 43(r3)
	addi	r3, r3, 44
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 42(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31380
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 39(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 43(r3)
	addi	r3, r3, 44
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 42(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31382
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
	lw	r6, 39(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 43(r3)
	addi	r3, r3, 44
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	lw	r2, 42(r3)
	lw	r5, 39(r3)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 43(r3)
	addi	r3, r3, 44
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31383
beq_then.31382:
beq_cont.31383:
	j	beq_cont.31381
beq_then.31380:
beq_cont.31381:
	j	beq_cont.31379
beq_then.31378:
beq_cont.31379:
	j	beq_cont.31377
beq_then.31376:
beq_cont.31377:
	j	beq_cont.31375
beq_then.31374:
beq_cont.31375:
	j	beq_cont.31373
beq_then.31372:
beq_cont.31373:
	j	beq_cont.31371
beq_then.31370:
	lw	r10, 1(r9)
	addi	r11, r0, -1				# li	r11, -1
	beq	r10, r11, beq_then.31384
	lw	r11, 5(r3)
	add	r30, r11, r10
	lw	r10, 0(r30)
	addi	r12, r0, 0				# li	r12, 0
	lw	r28, 4(r3)
	sw	r9, 42(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r12				# mr	r1, r12
	sw	r30, 43(r3)
	addi	r3, r3, 44
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 42(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31386
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 39(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 43(r3)
	addi	r3, r3, 44
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 42(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31388
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 39(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 43(r3)
	addi	r3, r3, 44
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 42(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31390
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
	lw	r6, 39(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 43(r3)
	addi	r3, r3, 44
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	lw	r2, 42(r3)
	lw	r5, 39(r3)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 43(r3)
	addi	r3, r3, 44
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31391
beq_then.31390:
beq_cont.31391:
	j	beq_cont.31389
beq_then.31388:
beq_cont.31389:
	j	beq_cont.31387
beq_then.31386:
beq_cont.31387:
	j	beq_cont.31385
beq_then.31384:
beq_cont.31385:
beq_cont.31371:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 41(r3)
	lw	r5, 39(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 43(r3)
	addi	r3, r3, 44
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31369
beq_then.31368:
beq_cont.31369:
	lw	r1, 28(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f1, r30
	fmvtr	r30, f2
	sw	r30, 44(r3)				#stfd	f2, 44(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31393
	addi	r30, r0, 48160
	lui	r30, r30, 19646	# to load float		100000000.000000
	fmvfr	f2, r30
	lw	r30, 44(r3)				#lfd	f1, 44(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31394
beq_then.31393:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31394:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31395
	lw	r1, 27(r3)
	lw	r1, 0(r1)
	slli	r1, r1, 2
	lw	r2, 26(r3)
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 40(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.31397
	j	beq_cont.31398
beq_then.31397:
	addi	r1, r0, 0				# li	r1, 0
	lw	r5, 24(r3)
	lw	r5, 0(r5)
	lw	r28, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31399
	j	beq_cont.31400
beq_then.31399:
	lw	r1, 39(r3)
	lw	r2, 0(r1)
	lw	r5, 16(r3)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r5)
	fmvfr	f2, r30
	lw	r30, 1(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r5)
	fmvfr	f2, r30
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r2, 40(r3)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 14(r3)				#lfd	f3, 14(r3)
	fmvfr	f3, r30
	fmul	f4, f2, f3
	fmul	f1, f4, f1
	lw	r1, 0(r1)
	lw	r2, 12(r3)
	lw	r30, 0(r2)
	fmvfr	f4, r30
	lw	r30, 0(r1)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	lw	r30, 1(r2)
	fmvfr	f5, r30
	lw	r30, 1(r1)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	lw	r30, 2(r2)
	fmvfr	f5, r30
	lw	r30, 2(r1)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	fmul	f2, f2, f4
	fmvtr	r30, f2
	sw	r30, 46(r3)				#stfd	f2, 46(r3)
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
	beq	r1, r2, beq_then.31401
	lw	r1, 11(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r2, 10(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r30, 48(r3)				#lfd	f3, 48(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f2, f3, f2
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f2, f3, f2
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r1)
	j	beq_cont.31402
beq_then.31401:
beq_cont.31402:
	lw	r30, 46(r3)				#lfd	f1, 46(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31403
	lw	r30, 46(r3)				#lfd	f1, 46(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 11(r3)
	lw	r30, 0(r1)
	fmvfr	f3, r30
	fadd	f3, f3, f1
	fmvtr	r30, f3
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f3, r30
	fadd	f3, f3, f1
	fmvtr	r30, f3
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f3, r30
	fadd	f1, f3, f1
	fmvtr	r30, f1
	sw	r30, 2(r1)
	j	beq_cont.31404
beq_then.31403:
beq_cont.31404:
beq_cont.31400:
beq_cont.31398:
	j	beq_cont.31396
beq_then.31395:
beq_cont.31396:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 38(r3)
	sub	r1, r2, r1
	lw	r30, 14(r3)				#lfd	f1, 14(r3)
	fmvfr	f1, r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	lw	r2, 12(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
trace_ray.2800:
	lw	r6, 33(r28)
	lw	r7, 32(r28)
	lw	r8, 31(r28)
	lw	r9, 30(r28)
	lw	r10, 29(r28)
	lw	r11, 28(r28)
	lw	r12, 27(r28)
	lw	r13, 26(r28)
	lw	r14, 25(r28)
	lw	r15, 24(r28)
	lw	r16, 23(r28)
	lw	r17, 22(r28)
	lw	r18, 21(r28)
	lw	r19, 20(r28)
	lw	r20, 19(r28)
	lw	r21, 18(r28)
	lw	r22, 17(r28)
	lw	r23, 16(r28)
	lw	r24, 15(r28)
	lw	r25, 14(r28)
	lw	r26, 13(r28)
	lw	r27, 12(r28)
	sw	r8, 0(r3)
	lw	r8, 11(r28)
	sw	r9, 1(r3)
	lw	r9, 10(r28)
	sw	r15, 2(r3)
	lw	r15, 9(r28)
	sw	r18, 3(r3)
	lw	r18, 8(r28)
	sw	r19, 4(r3)
	lw	r19, 7(r28)
	sw	r24, 5(r3)
	lw	r24, 6(r28)
	sw	r8, 6(r3)
	lw	r8, 5(r28)
	sw	r22, 7(r3)
	lw	r22, 4(r28)
	sw	r9, 8(r3)
	lw	r9, 3(r28)
	sw	r13, 9(r3)
	lw	r13, 2(r28)
	sw	r28, 10(r3)
	lw	r28, 1(r28)
	sw	r28, 11(r3)
	addi	r28, r0, 4				# li	r28, 4
	ble	r1, r28, ble_then.31405
	jr	r31				#	blr
ble_then.31405:
	lw	r28, 2(r5)
	addi	r30, r0, 27432
	lui	r30, r30, 20078	# to load float		1000000000.000000
	fmvfr	f3, r30
	fmvtr	r30, f3
	sw	r30, 0(r11)
	sw	r20, 12(r3)
	addi	r20, r0, 0				# li	r20, 0
	sw	r21, 13(r3)
	lw	r21, 0(r25)
	fmvtr	r30, f2
	sw	r30, 14(r3)				#stfd	f2, 14(r3)
	sw	r17, 16(r3)
	sw	r15, 17(r3)
	sw	r16, 18(r3)
	sw	r25, 19(r3)
	sw	r9, 20(r3)
	sw	r12, 21(r3)
	sw	r7, 22(r3)
	sw	r5, 23(r3)
	sw	r6, 24(r3)
	sw	r14, 25(r3)
	sw	r24, 26(r3)
	sw	r22, 27(r3)
	sw	r27, 28(r3)
	sw	r19, 29(r3)
	sw	r26, 30(r3)
	sw	r8, 31(r3)
	sw	r23, 32(r3)
	sw	r13, 33(r3)
	fmvtr	r30, f1
	sw	r30, 34(r3)				#stfd	f1, 34(r3)
	sw	r18, 36(r3)
	sw	r2, 37(r3)
	sw	r1, 38(r3)
	sw	r28, 39(r3)
	sw	r11, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r2				# mr	r5, r2
	add	r1, r0, r20				# mr	r1, r20
	add	r28, r0, r10				# mr	r28, r10
	add	r2, r0, r21				# mr	r2, r21
	sw	r30, 41(r3)
	addi	r3, r3, 42
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 40(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f1, r30
	fmvtr	r30, f2
	sw	r30, 42(r3)				#stfd	f2, 42(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31408
	addi	r30, r0, 48160
	lui	r30, r30, 19646	# to load float		100000000.000000
	fmvfr	f2, r30
	lw	r30, 42(r3)				#lfd	f1, 42(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31409
beq_then.31408:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31409:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31410
	lw	r1, 31(r3)
	lw	r2, 0(r1)
	lw	r5, 30(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 2(r5)
	lw	r7, 7(r5)
	lw	r30, 0(r7)
	fmvfr	f1, r30
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r7, 1(r5)
	addi	r8, r0, 1				# li	r8, 1
	sw	r6, 44(r3)
	fmvtr	r30, f1
	sw	r30, 46(r3)				#stfd	f1, 46(r3)
	sw	r2, 48(r3)
	sw	r5, 49(r3)
	beq	r7, r8, beq_then.31412
	addi	r8, r0, 2				# li	r8, 2
	beq	r7, r8, beq_then.31414
	lw	r28, 27(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 50(r3)
	addi	r3, r3, 51
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31415
beq_then.31414:
	lw	r7, 4(r5)
	lw	r30, 0(r7)
	fmvfr	f3, r30
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 28(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r2, 49(r3)
	lw	r5, 4(r2)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 28(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r2, 49(r3)
	lw	r5, 4(r2)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 28(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
beq_cont.31415:
	j	beq_cont.31413
beq_then.31412:
	lw	r7, 29(r3)
	lw	r8, 0(r7)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f3, r30
	lw	r9, 28(r3)
	fmvtr	r30, f3
	sw	r30, 0(r9)
	fmvtr	r30, f3
	sw	r30, 1(r9)
	fmvtr	r30, f3
	sw	r30, 2(r9)
	addi	r10, r0, 1				# li	r10, 1
	sub	r10, r8, r10
	addi	r11, r0, 1				# li	r11, 1
	sub	r8, r8, r11
	lw	r11, 37(r3)
	add	r30, r11, r8
	lw	r30, 0(r30)
	fmvfr	f3, r30
	sw	r10, 50(r3)
	fmvtr	r30, f3
	sw	r30, 52(r3)				#stfd	f3, 52(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 54(r3)
	addi	r3, r3, 55
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -55
	lw	r30, 54(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31417
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.31418
beq_then.31417:
	lw	r30, 52(r3)				#lfd	f1, 52(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 54(r3)
	addi	r3, r3, 55
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -55
	lw	r30, 54(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31419
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	j	beq_cont.31420
beq_then.31419:
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
beq_cont.31420:
beq_cont.31418:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 54(r3)
	addi	r3, r3, 55
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -55
	lw	r30, 54(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 50(r3)
	lw	r2, 28(r3)
	add	r29, r2, r1
	fmvtr	r30, f1
	sw	r30, 0(r29)
beq_cont.31413:
	lw	r2, 26(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r1, 25(r3)
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
	lw	r1, 49(r3)
	lw	r28, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 54(r3)
	addi	r3, r3, 55
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -55
	lw	r30, 54(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 48(r3)
	slli	r1, r1, 2
	lw	r2, 29(r3)
	lw	r5, 0(r2)
	add	r1, r1, r5
	lw	r5, 38(r3)
	lw	r6, 39(r3)
	add	r30, r6, r5
	sw	r1, 0(r30)
	lw	r1, 23(r3)
	lw	r7, 1(r1)
	add	r30, r7, r5
	lw	r7, 0(r30)
	lw	r8, 26(r3)
	lw	r30, 0(r8)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r7)
	lw	r30, 1(r8)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r7)
	lw	r30, 2(r8)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r7)
	lw	r7, 3(r1)
	lw	r9, 49(r3)
	lw	r10, 7(r9)
	lw	r30, 0(r10)
	fmvfr	f1, r30
	addi	r30, r0, 0
	lui	r30, r30, 16128	# to load float		0.500000
	fmvfr	f2, r30
	sw	r7, 54(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 55(r3)
	addi	r3, r3, 56
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -56
	lw	r30, 55(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31421
	lw	r1, 38(r3)
	lw	r2, 54(r3)
	lw	r5, 20(r3)
	add	r30, r2, r1
	sw	r5, 0(r30)
	j	beq_cont.31422
beq_then.31421:
	lw	r1, 38(r3)
	lw	r2, 54(r3)
	lw	r5, 22(r3)
	add	r30, r2, r1
	sw	r5, 0(r30)
	lw	r2, 23(r3)
	lw	r5, 4(r2)
	add	r30, r5, r1
	lw	r6, 0(r30)
	lw	r7, 21(r3)
	lw	r30, 0(r7)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r6)
	lw	r30, 1(r7)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r6)
	lw	r30, 2(r7)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r6)
	add	r30, r5, r1
	lw	r5, 0(r30)
	addi	r30, r0, 0
	lui	r30, r30, 15232	# to load float		0.003906
	fmvfr	f1, r30
	lw	r30, 46(r3)				#lfd	f2, 46(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 0(r5)
	fmvfr	f3, r30
	fmul	f3, f3, f1
	fmvtr	r30, f3
	sw	r30, 0(r5)
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f3, f3, f1
	fmvtr	r30, f3
	sw	r30, 1(r5)
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f1, f3, f1
	fmvtr	r30, f1
	sw	r30, 2(r5)
	lw	r5, 7(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r6, 28(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r5)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r5)
	lw	r30, 2(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r5)
beq_cont.31422:
	addi	r30, r0, 0
	lui	r30, r30, 49152	# to load float		-2.000000
	fmvfr	f1, r30
	lw	r2, 37(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r5, 28(r3)
	lw	r30, 0(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	lw	r30, 1(r2)
	fmvfr	f3, r30
	lw	r30, 1(r5)
	fmvfr	f4, r30
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	lw	r30, 2(r2)
	fmvfr	f3, r30
	lw	r30, 2(r5)
	fmvfr	f4, r30
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	fmul	f1, f1, f2
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r30, 0(r5)
	fmvfr	f3, r30
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fmvtr	r30, f2
	sw	r30, 0(r2)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fmvtr	r30, f2
	sw	r30, 1(r2)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	fmvtr	r30, f1
	sw	r30, 2(r2)
	lw	r6, 49(r3)
	lw	r7, 7(r6)
	lw	r30, 1(r7)
	fmvfr	f1, r30
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r7, 19(r3)
	lw	r8, 0(r7)
	lw	r9, 0(r8)
	lw	r10, 0(r9)
	addi	r11, r0, -1				# li	r11, -1
	fmvtr	r30, f1
	sw	r30, 56(r3)				#stfd	f1, 56(r3)
	beq	r10, r11, beq_then.31424
	addi	r11, r0, 99				# li	r11, 99
	sw	r9, 58(r3)
	sw	r8, 59(r3)
	beq	r10, r11, beq_then.31426
	lw	r11, 17(r3)
	lw	r12, 26(r3)
	lw	r28, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r12				# mr	r5, r12
	add	r2, r0, r11				# mr	r2, r11
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 60(r3)
	addi	r3, r3, 61
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31428
	lw	r1, 16(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 60(r3)
	addi	r3, r3, 61
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31430
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 58(r3)
	lw	r28, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 60(r3)
	addi	r3, r3, 61
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31432
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.31433
beq_then.31432:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31433:
	j	beq_cont.31431
beq_then.31430:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31431:
	j	beq_cont.31429
beq_then.31428:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31429:
	j	beq_cont.31427
beq_then.31426:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31427:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31434
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 58(r3)
	lw	r28, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 60(r3)
	addi	r3, r3, 61
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31436
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.31437
beq_then.31436:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 59(r3)
	lw	r28, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 60(r3)
	addi	r3, r3, 61
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31437:
	j	beq_cont.31435
beq_then.31434:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 59(r3)
	lw	r28, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 60(r3)
	addi	r3, r3, 61
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31435:
	j	beq_cont.31425
beq_then.31424:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31425:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31438
	j	beq_cont.31439
beq_then.31438:
	lw	r1, 28(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r2, 36(r3)
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
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 60(r3)
	addi	r3, r3, 61
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 46(r3)				#lfd	f2, 46(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 37(r3)
	lw	r30, 0(r1)
	fmvfr	f3, r30
	lw	r2, 36(r3)
	lw	r30, 0(r2)
	fmvfr	f4, r30
	fmul	f3, f3, f4
	lw	r30, 1(r1)
	fmvfr	f4, r30
	lw	r30, 1(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f3, f3, f4
	lw	r30, 2(r1)
	fmvfr	f4, r30
	lw	r30, 2(r2)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fadd	f3, f3, f4
	fmvtr	r30, f1
	sw	r30, 60(r3)				#stfd	f1, 60(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 62(r3)
	addi	r3, r3, 63
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -63
	lw	r30, 62(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 60(r3)				#lfd	f2, 60(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 62(r3)				#stfd	f1, 62(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 64(r3)
	addi	r3, r3, 65
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -65
	lw	r30, 64(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31440
	lw	r1, 32(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r2, 21(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r30, 60(r3)				#lfd	f3, 60(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f2, f3, f2
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f2, f3, f2
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r1)
	j	beq_cont.31441
beq_then.31440:
beq_cont.31441:
	lw	r30, 62(r3)				#lfd	f1, 62(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 64(r3)
	addi	r3, r3, 65
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -65
	lw	r30, 64(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31442
	lw	r30, 62(r3)				#lfd	f1, 62(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 64(r3)
	addi	r3, r3, 65
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -65
	lw	r30, 64(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 64(r3)
	addi	r3, r3, 65
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -65
	lw	r30, 64(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 56(r3)				#lfd	f2, 56(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 32(r3)
	lw	r30, 0(r1)
	fmvfr	f3, r30
	fadd	f3, f3, f1
	fmvtr	r30, f3
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f3, r30
	fadd	f3, f3, f1
	fmvtr	r30, f3
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f3, r30
	fadd	f1, f3, f1
	fmvtr	r30, f1
	sw	r30, 2(r1)
	j	beq_cont.31443
beq_then.31442:
beq_cont.31443:
beq_cont.31439:
	lw	r1, 26(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r2, 9(r3)
	fmvtr	r30, f1
	sw	r30, 0(r2)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r2)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r2)
	lw	r2, 8(r3)
	lw	r2, 0(r2)
	addi	r5, r0, 1				# li	r5, 1
	sub	r2, r2, r5
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 64(r3)
	addi	r3, r3, 65
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -65
	lw	r30, 64(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	lw	r1, 0(r1)
	addi	r2, r0, 1				# li	r2, 1
	sub	r1, r1, r2
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31444
	j	ble_cont.31445
ble_then.31444:
	lw	r2, 5(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 1(r2)
	addi	r30, r0, 27432
	lui	r30, r30, 20078	# to load float		1000000000.000000
	fmvfr	f1, r30
	lw	r6, 40(r3)
	fmvtr	r30, f1
	sw	r30, 0(r6)
	lw	r7, 19(r3)
	lw	r8, 0(r7)
	lw	r9, 0(r8)
	lw	r10, 0(r9)
	addi	r11, r0, -1				# li	r11, -1
	sw	r1, 64(r3)
	sw	r5, 65(r3)
	sw	r2, 66(r3)
	beq	r10, r11, beq_then.31446
	addi	r11, r0, 99				# li	r11, 99
	sw	r8, 67(r3)
	beq	r10, r11, beq_then.31448
	lw	r28, 2(r3)
	sw	r9, 68(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -70
	lw	r30, 69(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31450
	lw	r1, 16(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r1, 40(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 69(r3)
	addi	r3, r3, 70
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -70
	lw	r30, 69(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31452
	lw	r1, 68(r3)
	lw	r2, 1(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31454
	lw	r5, 11(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 65(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -70
	lw	r30, 69(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 68(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31456
	lw	r5, 11(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 65(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -70
	lw	r30, 69(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 68(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31458
	lw	r5, 11(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 65(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -70
	lw	r30, 69(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 68(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31460
	lw	r5, 11(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
	lw	r6, 65(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -70
	lw	r30, 69(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	lw	r2, 68(r3)
	lw	r5, 65(r3)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -70
	lw	r30, 69(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31461
beq_then.31460:
beq_cont.31461:
	j	beq_cont.31459
beq_then.31458:
beq_cont.31459:
	j	beq_cont.31457
beq_then.31456:
beq_cont.31457:
	j	beq_cont.31455
beq_then.31454:
beq_cont.31455:
	j	beq_cont.31453
beq_then.31452:
beq_cont.31453:
	j	beq_cont.31451
beq_then.31450:
beq_cont.31451:
	j	beq_cont.31449
beq_then.31448:
	lw	r10, 1(r9)
	addi	r11, r0, -1				# li	r11, -1
	beq	r10, r11, beq_then.31462
	lw	r11, 11(r3)
	add	r30, r11, r10
	lw	r10, 0(r30)
	addi	r12, r0, 0				# li	r12, 0
	lw	r28, 4(r3)
	sw	r9, 68(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r12				# mr	r1, r12
	sw	r30, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -70
	lw	r30, 69(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 68(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31464
	lw	r5, 11(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 65(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -70
	lw	r30, 69(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 68(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31466
	lw	r5, 11(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 65(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -70
	lw	r30, 69(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 68(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31468
	lw	r5, 11(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
	lw	r6, 65(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -70
	lw	r30, 69(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	lw	r2, 68(r3)
	lw	r5, 65(r3)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -70
	lw	r30, 69(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31469
beq_then.31468:
beq_cont.31469:
	j	beq_cont.31467
beq_then.31466:
beq_cont.31467:
	j	beq_cont.31465
beq_then.31464:
beq_cont.31465:
	j	beq_cont.31463
beq_then.31462:
beq_cont.31463:
beq_cont.31449:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 67(r3)
	lw	r5, 65(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 69(r3)
	addi	r3, r3, 70
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -70
	lw	r30, 69(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31447
beq_then.31446:
beq_cont.31447:
	lw	r1, 40(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f1, r30
	fmvtr	r30, f2
	sw	r30, 70(r3)				#stfd	f2, 70(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 72(r3)
	addi	r3, r3, 73
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -73
	lw	r30, 72(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31471
	addi	r30, r0, 48160
	lui	r30, r30, 19646	# to load float		100000000.000000
	fmvfr	f2, r30
	lw	r30, 70(r3)				#lfd	f1, 70(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 72(r3)
	addi	r3, r3, 73
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -73
	lw	r30, 72(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31472
beq_then.31471:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31472:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31473
	lw	r1, 31(r3)
	lw	r1, 0(r1)
	slli	r1, r1, 2
	lw	r2, 29(r3)
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 66(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.31475
	j	beq_cont.31476
beq_then.31475:
	addi	r1, r0, 0				# li	r1, 0
	lw	r5, 19(r3)
	lw	r5, 0(r5)
	lw	r28, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 72(r3)
	addi	r3, r3, 73
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -73
	lw	r30, 72(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31477
	j	beq_cont.31478
beq_then.31477:
	lw	r1, 65(r3)
	lw	r2, 0(r1)
	lw	r5, 28(r3)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r5)
	fmvfr	f2, r30
	lw	r30, 1(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r5)
	fmvfr	f2, r30
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r2, 66(r3)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 46(r3)				#lfd	f3, 46(r3)
	fmvfr	f3, r30
	fmul	f4, f2, f3
	fmul	f1, f4, f1
	lw	r1, 0(r1)
	lw	r2, 37(r3)
	lw	r30, 0(r2)
	fmvfr	f4, r30
	lw	r30, 0(r1)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	lw	r30, 1(r2)
	fmvfr	f5, r30
	lw	r30, 1(r1)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	lw	r30, 2(r2)
	fmvfr	f5, r30
	lw	r30, 2(r1)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	fmul	f2, f2, f4
	fmvtr	r30, f2
	sw	r30, 72(r3)				#stfd	f2, 72(r3)
	fmvtr	r30, f1
	sw	r30, 74(r3)				#stfd	f1, 74(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 76(r3)
	addi	r3, r3, 77
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -77
	lw	r30, 76(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31479
	lw	r1, 32(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r2, 21(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r30, 74(r3)				#lfd	f3, 74(r3)
	fmvfr	f3, r30
	fmul	f2, f3, f2
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f2, f3, f2
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f2, f3, f2
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r1)
	j	beq_cont.31480
beq_then.31479:
beq_cont.31480:
	lw	r30, 72(r3)				#lfd	f1, 72(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 76(r3)
	addi	r3, r3, 77
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -77
	lw	r30, 76(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31481
	lw	r30, 72(r3)				#lfd	f1, 72(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 76(r3)
	addi	r3, r3, 77
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -77
	lw	r30, 76(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 76(r3)
	addi	r3, r3, 77
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -77
	lw	r30, 76(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 56(r3)				#lfd	f2, 56(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 32(r3)
	lw	r30, 0(r1)
	fmvfr	f3, r30
	fadd	f3, f3, f1
	fmvtr	r30, f3
	sw	r30, 0(r1)
	lw	r30, 1(r1)
	fmvfr	f3, r30
	fadd	f3, f3, f1
	fmvtr	r30, f3
	sw	r30, 1(r1)
	lw	r30, 2(r1)
	fmvfr	f3, r30
	fadd	f1, f3, f1
	fmvtr	r30, f1
	sw	r30, 2(r1)
	j	beq_cont.31482
beq_then.31481:
beq_cont.31482:
beq_cont.31478:
beq_cont.31476:
	j	beq_cont.31474
beq_then.31473:
beq_cont.31474:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 64(r3)
	sub	r1, r2, r1
	lw	r30, 46(r3)				#lfd	f1, 46(r3)
	fmvfr	f1, r30
	lw	r30, 56(r3)				#lfd	f2, 56(r3)
	fmvfr	f2, r30
	lw	r2, 37(r3)
	lw	r28, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 76(r3)
	addi	r3, r3, 77
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -77
	lw	r30, 76(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.31445:
	addi	r30, r0, 52429
	lui	r30, r30, 15820	# to load float		0.100000
	fmvfr	f1, r30
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 76(r3)
	addi	r3, r3, 77
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -77
	lw	r30, 76(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31483
	addi	r1, r0, 4				# li	r1, 4
	lw	r2, 38(r3)
	ble	r1, r2, ble_then.31484
	addi	r1, r2, 1
	addi	r5, r0, -1				# li	r5, -1
	lw	r6, 39(r3)
	add	r30, r6, r1
	sw	r5, 0(r30)
	j	ble_cont.31485
ble_then.31484:
ble_cont.31485:
	addi	r1, r0, 2				# li	r1, 2
	lw	r5, 44(r3)
	beq	r5, r1, beq_then.31486
	j	beq_cont.31487
beq_then.31486:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r1, 49(r3)
	lw	r1, 7(r1)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	addi	r1, r2, 1
	lw	r2, 40(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r30, 14(r3)				#lfd	f3, 14(r3)
	fmvfr	f3, r30
	fadd	f2, f3, f2
	lw	r2, 37(r3)
	lw	r5, 23(r3)
	lw	r28, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 76(r3)
	addi	r3, r3, 77
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -77
	lw	r30, 76(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31487:
	jr	r31				#	blr
beq_then.31483:
	jr	r31				#	blr
beq_then.31410:
	addi	r1, r0, -1				# li	r1, -1
	lw	r2, 38(r3)
	lw	r5, 39(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 0				# li	r1, 0
	beq	r2, r1, beq_then.31490
	lw	r1, 37(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r2, 36(r3)
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
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 76(r3)
	addi	r3, r3, 77
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -77
	lw	r30, 76(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 76(r3)				#stfd	f1, 76(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 78(r3)
	addi	r3, r3, 79
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -79
	lw	r30, 78(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31491
	lw	r30, 76(r3)				#lfd	f1, 76(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 78(r3)
	addi	r3, r3, 79
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -79
	lw	r30, 78(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 76(r3)				#lfd	f2, 76(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 33(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 32(r3)
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
beq_then.31491:
	jr	r31				#	blr
beq_then.31490:
	jr	r31				#	blr
trace_diffuse_ray.2806:
	lw	r2, 18(r28)
	lw	r5, 17(r28)
	lw	r6, 16(r28)
	lw	r7, 15(r28)
	lw	r8, 14(r28)
	lw	r9, 13(r28)
	lw	r10, 12(r28)
	lw	r11, 11(r28)
	lw	r12, 10(r28)
	lw	r13, 9(r28)
	lw	r14, 8(r28)
	lw	r15, 7(r28)
	lw	r16, 6(r28)
	lw	r17, 5(r28)
	lw	r18, 4(r28)
	lw	r19, 3(r28)
	lw	r20, 2(r28)
	lw	r21, 1(r28)
	addi	r30, r0, 27432
	lui	r30, r30, 20078	# to load float		1000000000.000000
	fmvfr	f2, r30
	fmvtr	r30, f2
	sw	r30, 0(r6)
	addi	r22, r0, 0				# li	r22, 0
	lw	r23, 0(r12)
	sw	r7, 0(r3)
	sw	r21, 1(r3)
	fmvtr	r30, f1
	sw	r30, 2(r3)				#stfd	f1, 2(r3)
	sw	r16, 4(r3)
	sw	r10, 5(r3)
	sw	r11, 6(r3)
	sw	r9, 7(r3)
	sw	r15, 8(r3)
	sw	r8, 9(r3)
	sw	r12, 10(r3)
	sw	r18, 11(r3)
	sw	r2, 12(r3)
	sw	r20, 13(r3)
	sw	r14, 14(r3)
	sw	r17, 15(r3)
	sw	r1, 16(r3)
	sw	r13, 17(r3)
	sw	r19, 18(r3)
	sw	r6, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r23				# mr	r2, r23
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r1				# mr	r5, r1
	add	r1, r0, r22				# mr	r1, r22
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 19(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f1, r30
	fmvtr	r30, f2
	sw	r30, 20(r3)				#stfd	f2, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31495
	addi	r30, r0, 48160
	lui	r30, r30, 19646	# to load float		100000000.000000
	fmvfr	f2, r30
	lw	r30, 20(r3)				#lfd	f1, 20(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31496
beq_then.31495:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31496:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31497
	lw	r1, 18(r3)
	lw	r1, 0(r1)
	lw	r2, 17(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 16(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	addi	r6, r0, 1				# li	r6, 1
	sw	r1, 22(r3)
	beq	r5, r6, beq_then.31498
	addi	r2, r0, 2				# li	r2, 2
	beq	r5, r2, beq_then.31500
	lw	r28, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31501
beq_then.31500:
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 14(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r2, 22(r3)
	lw	r5, 4(r2)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 14(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r2, 22(r3)
	lw	r5, 4(r2)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 14(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
beq_cont.31501:
	j	beq_cont.31499
beq_then.31498:
	lw	r5, 15(r3)
	lw	r5, 0(r5)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r6, 14(r3)
	fmvtr	r30, f1
	sw	r30, 0(r6)
	fmvtr	r30, f1
	sw	r30, 1(r6)
	fmvtr	r30, f1
	sw	r30, 2(r6)
	addi	r7, r0, 1				# li	r7, 1
	sub	r7, r5, r7
	addi	r8, r0, 1				# li	r8, 1
	sub	r5, r5, r8
	add	r30, r2, r5
	lw	r30, 0(r30)
	fmvfr	f1, r30
	sw	r7, 23(r3)
	fmvtr	r30, f1
	sw	r30, 24(r3)				#stfd	f1, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31502
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.31503
beq_then.31502:
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31504
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	j	beq_cont.31505
beq_then.31504:
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
beq_cont.31505:
beq_cont.31503:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 23(r3)
	lw	r2, 14(r3)
	add	r29, r2, r1
	fmvtr	r30, f1
	sw	r30, 0(r29)
beq_cont.31499:
	lw	r1, 22(r3)
	lw	r2, 11(r3)
	lw	r28, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 10(r3)
	lw	r2, 0(r1)
	lw	r1, 0(r2)
	lw	r5, 0(r1)
	addi	r6, r0, -1				# li	r6, -1
	beq	r5, r6, beq_then.31506
	addi	r6, r0, 99				# li	r6, 99
	sw	r1, 26(r3)
	sw	r2, 27(r3)
	beq	r5, r6, beq_then.31508
	lw	r6, 8(r3)
	lw	r7, 11(r3)
	lw	r28, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r7				# mr	r5, r7
	sw	r30, 28(r3)
	addi	r3, r3, 29
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31510
	lw	r1, 7(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31512
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 26(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31514
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.31515
beq_then.31514:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31515:
	j	beq_cont.31513
beq_then.31512:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31513:
	j	beq_cont.31511
beq_then.31510:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31511:
	j	beq_cont.31509
beq_then.31508:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.31509:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31516
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 26(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31518
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.31519
beq_then.31518:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 27(r3)
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31519:
	j	beq_cont.31517
beq_then.31516:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 27(r3)
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31517:
	j	beq_cont.31507
beq_then.31506:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31507:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31520
	jr	r31				#	blr
beq_then.31520:
	lw	r1, 14(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r2, 4(r3)
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
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31522
	lw	r30, 28(r3)				#lfd	f1, 28(r3)
	fmvfr	f1, r30
	j	beq_cont.31523
beq_then.31522:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
beq_cont.31523:
	lw	r30, 2(r3)				#lfd	f2, 2(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 22(r3)
	lw	r1, 7(r1)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 1(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	lw	r2, 0(r3)
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
beq_then.31497:
	jr	r31				#	blr
iter_trace_diffuse_rays.2809:
	lw	r7, 20(r28)
	lw	r8, 19(r28)
	lw	r9, 18(r28)
	lw	r10, 17(r28)
	lw	r11, 16(r28)
	lw	r12, 15(r28)
	lw	r13, 14(r28)
	lw	r14, 13(r28)
	lw	r15, 12(r28)
	lw	r16, 11(r28)
	lw	r17, 10(r28)
	lw	r18, 9(r28)
	lw	r19, 8(r28)
	lw	r20, 7(r28)
	lw	r21, 6(r28)
	lw	r22, 5(r28)
	lw	r23, 4(r28)
	lw	r24, 3(r28)
	lw	r25, 2(r28)
	lw	r26, 1(r28)
	addi	r27, r0, 0				# li	r27, 0
	ble	r27, r6, ble_then.31526
	jr	r31				#	blr
ble_then.31526:
	add	r30, r1, r6
	lw	r27, 0(r30)
	lw	r27, 0(r27)
	lw	r30, 0(r27)
	fmvfr	f1, r30
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r27)
	fmvfr	f2, r30
	lw	r30, 1(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r27)
	fmvfr	f2, r30
	lw	r30, 2(r2)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	sw	r5, 0(r3)
	sw	r28, 1(r3)
	sw	r9, 2(r3)
	sw	r2, 3(r3)
	sw	r11, 4(r3)
	sw	r25, 5(r3)
	sw	r20, 6(r3)
	sw	r16, 7(r3)
	sw	r22, 8(r3)
	sw	r7, 9(r3)
	sw	r24, 10(r3)
	sw	r19, 11(r3)
	sw	r21, 12(r3)
	sw	r18, 13(r3)
	sw	r23, 14(r3)
	sw	r8, 15(r3)
	sw	r13, 16(r3)
	sw	r12, 17(r3)
	sw	r14, 18(r3)
	sw	r15, 19(r3)
	sw	r26, 20(r3)
	sw	r17, 21(r3)
	sw	r10, 22(r3)
	fmvtr	r30, f1
	sw	r30, 24(r3)				#stfd	f1, 24(r3)
	sw	r6, 26(r3)
	sw	r1, 27(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31529
	lw	r1, 26(r3)
	addi	r2, r1, 1
	lw	r5, 27(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r30, r0, 0
	lui	r30, r30, 49942	# to load float		-150.000000
	fmvfr	f1, r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	addi	r30, r0, 27432
	lui	r30, r30, 20078	# to load float		1000000000.000000
	fmvfr	f2, r30
	lw	r6, 22(r3)
	fmvtr	r30, f2
	sw	r30, 0(r6)
	lw	r7, 21(r3)
	lw	r8, 0(r7)
	lw	r9, 0(r8)
	lw	r10, 0(r9)
	addi	r11, r0, -1				# li	r11, -1
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	sw	r2, 30(r3)
	beq	r10, r11, beq_then.31531
	addi	r11, r0, 99				# li	r11, 99
	sw	r8, 31(r3)
	beq	r10, r11, beq_then.31533
	lw	r28, 17(r3)
	sw	r9, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31535
	lw	r1, 16(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r1, 22(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 33(r3)
	addi	r3, r3, 34
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31537
	lw	r1, 32(r3)
	lw	r2, 1(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31539
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 30(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 32(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31541
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 30(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 32(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31543
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 30(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 32(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31545
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
	lw	r6, 30(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	lw	r2, 32(r3)
	lw	r5, 30(r3)
	lw	r28, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31546
beq_then.31545:
beq_cont.31546:
	j	beq_cont.31544
beq_then.31543:
beq_cont.31544:
	j	beq_cont.31542
beq_then.31541:
beq_cont.31542:
	j	beq_cont.31540
beq_then.31539:
beq_cont.31540:
	j	beq_cont.31538
beq_then.31537:
beq_cont.31538:
	j	beq_cont.31536
beq_then.31535:
beq_cont.31536:
	j	beq_cont.31534
beq_then.31533:
	lw	r10, 1(r9)
	addi	r11, r0, -1				# li	r11, -1
	beq	r10, r11, beq_then.31547
	lw	r11, 20(r3)
	add	r30, r11, r10
	lw	r10, 0(r30)
	addi	r12, r0, 0				# li	r12, 0
	lw	r28, 19(r3)
	sw	r9, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r2				# mr	r5, r2
	add	r1, r0, r12				# mr	r1, r12
	add	r2, r0, r10				# mr	r2, r10
	sw	r30, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 32(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31549
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 30(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 32(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31551
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 30(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 32(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31553
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
	lw	r6, 30(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	lw	r2, 32(r3)
	lw	r5, 30(r3)
	lw	r28, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31554
beq_then.31553:
beq_cont.31554:
	j	beq_cont.31552
beq_then.31551:
beq_cont.31552:
	j	beq_cont.31550
beq_then.31549:
beq_cont.31550:
	j	beq_cont.31548
beq_then.31547:
beq_cont.31548:
beq_cont.31534:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 31(r3)
	lw	r5, 30(r3)
	lw	r28, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31532
beq_then.31531:
beq_cont.31532:
	lw	r1, 22(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f1, r30
	fmvtr	r30, f2
	sw	r30, 34(r3)				#stfd	f2, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31556
	addi	r30, r0, 48160
	lui	r30, r30, 19646	# to load float		100000000.000000
	fmvfr	f2, r30
	lw	r30, 34(r3)				#lfd	f1, 34(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31557
beq_then.31556:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31557:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31558
	lw	r1, 14(r3)
	lw	r1, 0(r1)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 30(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	addi	r6, r0, 1				# li	r6, 1
	sw	r1, 36(r3)
	beq	r5, r6, beq_then.31560
	addi	r2, r0, 2				# li	r2, 2
	beq	r5, r2, beq_then.31562
	lw	r28, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 37(r3)
	addi	r3, r3, 38
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -38
	lw	r30, 37(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31563
beq_then.31562:
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 37(r3)
	addi	r3, r3, 38
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -38
	lw	r30, 37(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r2, 36(r3)
	lw	r5, 4(r2)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 37(r3)
	addi	r3, r3, 38
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -38
	lw	r30, 37(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r2, 36(r3)
	lw	r5, 4(r2)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 37(r3)
	addi	r3, r3, 38
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -38
	lw	r30, 37(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
beq_cont.31563:
	j	beq_cont.31561
beq_then.31560:
	lw	r5, 12(r3)
	lw	r5, 0(r5)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r6, 11(r3)
	fmvtr	r30, f1
	sw	r30, 0(r6)
	fmvtr	r30, f1
	sw	r30, 1(r6)
	fmvtr	r30, f1
	sw	r30, 2(r6)
	addi	r7, r0, 1				# li	r7, 1
	sub	r7, r5, r7
	addi	r8, r0, 1				# li	r8, 1
	sub	r5, r5, r8
	add	r30, r2, r5
	lw	r30, 0(r30)
	fmvfr	f1, r30
	sw	r7, 37(r3)
	fmvtr	r30, f1
	sw	r30, 38(r3)				#stfd	f1, 38(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31564
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.31565
beq_then.31564:
	lw	r30, 38(r3)				#lfd	f1, 38(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31566
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	j	beq_cont.31567
beq_then.31566:
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
beq_cont.31567:
beq_cont.31565:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 37(r3)
	lw	r2, 11(r3)
	add	r29, r2, r1
	fmvtr	r30, f1
	sw	r30, 0(r29)
beq_cont.31561:
	lw	r1, 36(r3)
	lw	r2, 8(r3)
	lw	r28, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 21(r3)
	lw	r2, 0(r2)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31568
	j	beq_cont.31569
beq_then.31568:
	lw	r1, 11(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r2, 6(r3)
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
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 40(r3)				#stfd	f1, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31570
	lw	r30, 40(r3)				#lfd	f1, 40(r3)
	fmvfr	f1, r30
	j	beq_cont.31571
beq_then.31570:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
beq_cont.31571:
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 36(r3)
	lw	r1, 7(r1)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 5(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	lw	r2, 4(r3)
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
beq_cont.31569:
	j	beq_cont.31559
beq_then.31558:
beq_cont.31559:
	j	beq_cont.31530
beq_then.31529:
	lw	r1, 26(r3)
	lw	r2, 27(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r30, r0, 0
	lui	r30, r30, 17174	# to load float		150.000000
	fmvfr	f1, r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	addi	r30, r0, 27432
	lui	r30, r30, 20078	# to load float		1000000000.000000
	fmvfr	f2, r30
	lw	r6, 22(r3)
	fmvtr	r30, f2
	sw	r30, 0(r6)
	lw	r7, 21(r3)
	lw	r8, 0(r7)
	lw	r9, 0(r8)
	lw	r10, 0(r9)
	addi	r11, r0, -1				# li	r11, -1
	fmvtr	r30, f1
	sw	r30, 42(r3)				#stfd	f1, 42(r3)
	sw	r5, 44(r3)
	beq	r10, r11, beq_then.31572
	addi	r11, r0, 99				# li	r11, 99
	sw	r8, 45(r3)
	beq	r10, r11, beq_then.31574
	lw	r28, 17(r3)
	sw	r9, 46(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 47(r3)
	addi	r3, r3, 48
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31576
	lw	r1, 16(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r1, 22(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 47(r3)
	addi	r3, r3, 48
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31578
	lw	r1, 46(r3)
	lw	r2, 1(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31580
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 44(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 47(r3)
	addi	r3, r3, 48
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 46(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31582
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 44(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 47(r3)
	addi	r3, r3, 48
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 46(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31584
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 44(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 47(r3)
	addi	r3, r3, 48
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 46(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31586
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
	lw	r6, 44(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 47(r3)
	addi	r3, r3, 48
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	lw	r2, 46(r3)
	lw	r5, 44(r3)
	lw	r28, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 47(r3)
	addi	r3, r3, 48
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31587
beq_then.31586:
beq_cont.31587:
	j	beq_cont.31585
beq_then.31584:
beq_cont.31585:
	j	beq_cont.31583
beq_then.31582:
beq_cont.31583:
	j	beq_cont.31581
beq_then.31580:
beq_cont.31581:
	j	beq_cont.31579
beq_then.31578:
beq_cont.31579:
	j	beq_cont.31577
beq_then.31576:
beq_cont.31577:
	j	beq_cont.31575
beq_then.31574:
	lw	r10, 1(r9)
	addi	r11, r0, -1				# li	r11, -1
	beq	r10, r11, beq_then.31588
	lw	r11, 20(r3)
	add	r30, r11, r10
	lw	r10, 0(r30)
	addi	r12, r0, 0				# li	r12, 0
	lw	r28, 19(r3)
	sw	r9, 46(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r12				# mr	r1, r12
	sw	r30, 47(r3)
	addi	r3, r3, 48
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 46(r3)
	lw	r2, 2(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31590
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 44(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 47(r3)
	addi	r3, r3, 48
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 46(r3)
	lw	r2, 3(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31592
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 44(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r7				# mr	r5, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 47(r3)
	addi	r3, r3, 48
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 46(r3)
	lw	r2, 4(r1)
	addi	r5, r0, -1				# li	r5, -1
	beq	r2, r5, beq_then.31594
	lw	r5, 20(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
	lw	r6, 44(r3)
	lw	r28, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 47(r3)
	addi	r3, r3, 48
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	lw	r2, 46(r3)
	lw	r5, 44(r3)
	lw	r28, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 47(r3)
	addi	r3, r3, 48
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31595
beq_then.31594:
beq_cont.31595:
	j	beq_cont.31593
beq_then.31592:
beq_cont.31593:
	j	beq_cont.31591
beq_then.31590:
beq_cont.31591:
	j	beq_cont.31589
beq_then.31588:
beq_cont.31589:
beq_cont.31575:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 45(r3)
	lw	r5, 44(r3)
	lw	r28, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 47(r3)
	addi	r3, r3, 48
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -48
	lw	r30, 47(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31573
beq_then.31572:
beq_cont.31573:
	lw	r1, 22(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	addi	r30, r0, 52429
	lui	r30, r30, 48588	# to load float		-0.100000
	fmvfr	f1, r30
	fmvtr	r30, f2
	sw	r30, 48(r3)				#stfd	f2, 48(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31597
	addi	r30, r0, 48160
	lui	r30, r30, 19646	# to load float		100000000.000000
	fmvfr	f2, r30
	lw	r30, 48(r3)				#lfd	f1, 48(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 50(r3)
	addi	r3, r3, 51
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31598
beq_then.31597:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.31598:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31599
	lw	r1, 14(r3)
	lw	r1, 0(r1)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 44(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	addi	r6, r0, 1				# li	r6, 1
	sw	r1, 50(r3)
	beq	r5, r6, beq_then.31601
	addi	r2, r0, 2				# li	r2, 2
	beq	r5, r2, beq_then.31603
	lw	r28, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 51(r3)
	addi	r3, r3, 52
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -52
	lw	r30, 51(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31604
beq_then.31603:
	lw	r2, 4(r1)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 51(r3)
	addi	r3, r3, 52
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -52
	lw	r30, 51(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r2, 50(r3)
	lw	r5, 4(r2)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 51(r3)
	addi	r3, r3, 52
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -52
	lw	r30, 51(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r2, 50(r3)
	lw	r5, 4(r2)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 51(r3)
	addi	r3, r3, 52
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -52
	lw	r30, 51(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	fmvtr	r30, f1
	sw	r30, 2(r1)
beq_cont.31604:
	j	beq_cont.31602
beq_then.31601:
	lw	r5, 12(r3)
	lw	r5, 0(r5)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r6, 11(r3)
	fmvtr	r30, f1
	sw	r30, 0(r6)
	fmvtr	r30, f1
	sw	r30, 1(r6)
	fmvtr	r30, f1
	sw	r30, 2(r6)
	addi	r7, r0, 1				# li	r7, 1
	sub	r7, r5, r7
	addi	r8, r0, 1				# li	r8, 1
	sub	r5, r5, r8
	add	r30, r2, r5
	lw	r30, 0(r30)
	fmvfr	f1, r30
	sw	r7, 51(r3)
	fmvtr	r30, f1
	sw	r30, 52(r3)				#stfd	f1, 52(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 54(r3)
	addi	r3, r3, 55
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -55
	lw	r30, 54(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31605
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	j	beq_cont.31606
beq_then.31605:
	lw	r30, 52(r3)				#lfd	f1, 52(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 54(r3)
	addi	r3, r3, 55
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -55
	lw	r30, 54(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31607
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	j	beq_cont.31608
beq_then.31607:
	addi	r30, r0, 0
	lui	r30, r30, 49024	# to load float		-1.000000
	fmvfr	f1, r30
beq_cont.31608:
beq_cont.31606:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 54(r3)
	addi	r3, r3, 55
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -55
	lw	r30, 54(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 51(r3)
	lw	r2, 11(r3)
	add	r29, r2, r1
	fmvtr	r30, f1
	sw	r30, 0(r29)
beq_cont.31602:
	lw	r1, 50(r3)
	lw	r2, 8(r3)
	lw	r28, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 54(r3)
	addi	r3, r3, 55
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -55
	lw	r30, 54(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 21(r3)
	lw	r2, 0(r2)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 54(r3)
	addi	r3, r3, 55
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -55
	lw	r30, 54(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31609
	j	beq_cont.31610
beq_then.31609:
	lw	r1, 11(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r2, 6(r3)
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
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 54(r3)
	addi	r3, r3, 55
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -55
	lw	r30, 54(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 54(r3)				#stfd	f1, 54(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 56(r3)
	addi	r3, r3, 57
	jal	lib_fispos				#	bl	lib_fispos
	addi	r3, r3, -57
	lw	r30, 56(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31611
	lw	r30, 54(r3)				#lfd	f1, 54(r3)
	fmvfr	f1, r30
	j	beq_cont.31612
beq_then.31611:
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
beq_cont.31612:
	lw	r30, 42(r3)				#lfd	f2, 42(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 50(r3)
	lw	r1, 7(r1)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 5(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	lw	r2, 4(r3)
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
beq_cont.31610:
	j	beq_cont.31600
beq_then.31599:
beq_cont.31600:
beq_cont.31530:
	addi	r1, r0, 2				# li	r1, 2
	lw	r2, 26(r3)
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31613
	jr	r31				#	blr
ble_then.31613:
	lw	r2, 27(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r6, 3(r3)
	lw	r30, 0(r6)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r5)
	fmvfr	f2, r30
	lw	r30, 1(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r5)
	fmvfr	f2, r30
	lw	r30, 2(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 56(r3)				#stfd	f1, 56(r3)
	sw	r1, 58(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 59(r3)
	addi	r3, r3, 60
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -60
	lw	r30, 59(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31615
	lw	r1, 58(r3)
	addi	r2, r1, 1
	lw	r5, 27(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r30, r0, 0
	lui	r30, r30, 49942	# to load float		-150.000000
	fmvfr	f1, r30
	lw	r30, 56(r3)				#lfd	f2, 56(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 59(r3)
	addi	r3, r3, 60
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -60
	lw	r30, 59(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31616
beq_then.31615:
	lw	r1, 58(r3)
	lw	r2, 27(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r30, r0, 0
	lui	r30, r30, 17174	# to load float		150.000000
	fmvfr	f1, r30
	lw	r30, 56(r3)				#lfd	f2, 56(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 59(r3)
	addi	r3, r3, 60
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -60
	lw	r30, 59(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31616:
	addi	r1, r0, 2				# li	r1, 2
	lw	r2, 58(r3)
	sub	r6, r2, r1
	lw	r1, 27(r3)
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	lw	r28, 1(r3)
	lw	r27, 0(r28)
	jr	r27
trace_diffuse_ray_80percent.2818:
	lw	r6, 5(r28)
	lw	r7, 4(r28)
	lw	r8, 3(r28)
	lw	r9, 2(r28)
	lw	r10, 1(r28)
	addi	r11, r0, 0				# li	r11, 0
	sw	r2, 0(r3)
	sw	r9, 1(r3)
	sw	r7, 2(r3)
	sw	r8, 3(r3)
	sw	r6, 4(r3)
	sw	r5, 5(r3)
	sw	r10, 6(r3)
	sw	r1, 7(r3)
	beq	r1, r11, beq_then.31617
	lw	r11, 0(r10)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r6)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r6)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r6)
	lw	r12, 0(r8)
	addi	r13, r0, 1				# li	r13, 1
	sub	r12, r12, r13
	sw	r11, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r5				# mr	r1, r5
	add	r28, r0, r7				# mr	r28, r7
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
	lw	r5, 5(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31618
beq_then.31617:
beq_cont.31618:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 7(r3)
	beq	r2, r1, beq_then.31619
	lw	r1, 6(r3)
	lw	r5, 1(r1)
	lw	r6, 5(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r7, 4(r3)
	fmvtr	r30, f1
	sw	r30, 0(r7)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r7)
	lw	r30, 2(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r7)
	lw	r8, 3(r3)
	lw	r9, 0(r8)
	addi	r10, r0, 1				# li	r10, 1
	sub	r9, r9, r10
	lw	r28, 2(r3)
	sw	r5, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
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
	lw	r5, 5(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31620
beq_then.31619:
beq_cont.31620:
	addi	r1, r0, 2				# li	r1, 2
	lw	r2, 7(r3)
	beq	r2, r1, beq_then.31621
	lw	r1, 6(r3)
	lw	r5, 2(r1)
	lw	r6, 5(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r7, 4(r3)
	fmvtr	r30, f1
	sw	r30, 0(r7)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r7)
	lw	r30, 2(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r7)
	lw	r8, 3(r3)
	lw	r9, 0(r8)
	addi	r10, r0, 1				# li	r10, 1
	sub	r9, r9, r10
	lw	r28, 2(r3)
	sw	r5, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
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
	lw	r5, 5(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31622
beq_then.31621:
beq_cont.31622:
	addi	r1, r0, 3				# li	r1, 3
	lw	r2, 7(r3)
	beq	r2, r1, beq_then.31623
	lw	r1, 6(r3)
	lw	r5, 3(r1)
	lw	r6, 5(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r7, 4(r3)
	fmvtr	r30, f1
	sw	r30, 0(r7)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r7)
	lw	r30, 2(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r7)
	lw	r8, 3(r3)
	lw	r9, 0(r8)
	addi	r10, r0, 1				# li	r10, 1
	sub	r9, r9, r10
	lw	r28, 2(r3)
	sw	r5, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 11(r3)
	lw	r2, 0(r3)
	lw	r5, 5(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31624
beq_then.31623:
beq_cont.31624:
	addi	r1, r0, 4				# li	r1, 4
	lw	r2, 7(r3)
	beq	r2, r1, beq_then.31625
	lw	r1, 6(r3)
	lw	r1, 4(r1)
	lw	r2, 5(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r5, 4(r3)
	fmvtr	r30, f1
	sw	r30, 0(r5)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r5)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r5)
	lw	r5, 3(r3)
	lw	r5, 0(r5)
	addi	r6, r0, 1				# li	r6, 1
	sub	r5, r5, r6
	lw	r28, 2(r3)
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 12(r3)
	lw	r2, 0(r3)
	lw	r5, 5(r3)
	lw	r28, 1(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.31625:
	jr	r31				#	blr
calc_diffuse_using_1point.2822:
	lw	r5, 8(r28)
	lw	r6, 7(r28)
	lw	r7, 6(r28)
	lw	r8, 5(r28)
	lw	r9, 4(r28)
	lw	r10, 3(r28)
	lw	r11, 2(r28)
	lw	r12, 1(r28)
	lw	r13, 5(r1)
	lw	r14, 7(r1)
	lw	r15, 1(r1)
	lw	r16, 4(r1)
	add	r30, r13, r2
	lw	r13, 0(r30)
	lw	r30, 0(r13)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r12)
	lw	r30, 1(r13)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r12)
	lw	r30, 2(r13)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r12)
	lw	r1, 6(r1)
	lw	r1, 0(r1)
	add	r30, r14, r2
	lw	r13, 0(r30)
	add	r30, r15, r2
	lw	r14, 0(r30)
	addi	r15, r0, 0				# li	r15, 0
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
	beq	r1, r15, beq_then.31627
	lw	r15, 0(r11)
	lw	r30, 0(r14)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r6)
	lw	r30, 1(r14)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r6)
	lw	r30, 2(r14)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r6)
	lw	r17, 0(r9)
	addi	r18, r0, 1				# li	r18, 1
	sub	r17, r17, r18
	sw	r15, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r17				# mr	r2, r17
	add	r1, r0, r14				# mr	r1, r14
	add	r28, r0, r7				# mr	r28, r7
	sw	r30, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r5, 6(r3)
	lw	r30, 0(r5)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r2)
	fmvfr	f2, r30
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 14(r3)				#stfd	f1, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31629
	lw	r1, 13(r3)
	lw	r2, 119(r1)
	addi	r30, r0, 0
	lui	r30, r30, 49942	# to load float		-150.000000
	fmvfr	f1, r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31630
beq_then.31629:
	lw	r1, 13(r3)
	lw	r2, 118(r1)
	addi	r30, r0, 0
	lui	r30, r30, 17174	# to load float		150.000000
	fmvfr	f1, r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31630:
	addi	r6, r0, 116				# li	r6, 116
	lw	r1, 13(r3)
	lw	r2, 6(r3)
	lw	r5, 10(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31628
beq_then.31627:
beq_cont.31628:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 12(r3)
	beq	r2, r1, beq_then.31631
	lw	r1, 11(r3)
	lw	r5, 1(r1)
	lw	r6, 10(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r7, 9(r3)
	fmvtr	r30, f1
	sw	r30, 0(r7)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r7)
	lw	r30, 2(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r7)
	lw	r8, 8(r3)
	lw	r9, 0(r8)
	addi	r10, r0, 1				# li	r10, 1
	sub	r9, r9, r10
	lw	r28, 7(r3)
	sw	r5, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 16(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r5, 6(r3)
	lw	r30, 0(r5)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r2)
	fmvfr	f2, r30
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31634
	lw	r1, 16(r3)
	lw	r2, 119(r1)
	addi	r30, r0, 0
	lui	r30, r30, 49942	# to load float		-150.000000
	fmvfr	f1, r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31635
beq_then.31634:
	lw	r1, 16(r3)
	lw	r2, 118(r1)
	addi	r30, r0, 0
	lui	r30, r30, 17174	# to load float		150.000000
	fmvfr	f1, r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31635:
	addi	r6, r0, 116				# li	r6, 116
	lw	r1, 16(r3)
	lw	r2, 6(r3)
	lw	r5, 10(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31632
beq_then.31631:
beq_cont.31632:
	addi	r1, r0, 2				# li	r1, 2
	lw	r2, 12(r3)
	beq	r2, r1, beq_then.31636
	lw	r1, 11(r3)
	lw	r5, 2(r1)
	lw	r6, 10(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r7, 9(r3)
	fmvtr	r30, f1
	sw	r30, 0(r7)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r7)
	lw	r30, 2(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r7)
	lw	r8, 8(r3)
	lw	r9, 0(r8)
	addi	r10, r0, 1				# li	r10, 1
	sub	r9, r9, r10
	lw	r28, 7(r3)
	sw	r5, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 20(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r5, 6(r3)
	lw	r30, 0(r5)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r2)
	fmvfr	f2, r30
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31639
	lw	r1, 20(r3)
	lw	r2, 119(r1)
	addi	r30, r0, 0
	lui	r30, r30, 49942	# to load float		-150.000000
	fmvfr	f1, r30
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31640
beq_then.31639:
	lw	r1, 20(r3)
	lw	r2, 118(r1)
	addi	r30, r0, 0
	lui	r30, r30, 17174	# to load float		150.000000
	fmvfr	f1, r30
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31640:
	addi	r6, r0, 116				# li	r6, 116
	lw	r1, 20(r3)
	lw	r2, 6(r3)
	lw	r5, 10(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31637
beq_then.31636:
beq_cont.31637:
	addi	r1, r0, 3				# li	r1, 3
	lw	r2, 12(r3)
	beq	r2, r1, beq_then.31641
	lw	r1, 11(r3)
	lw	r5, 3(r1)
	lw	r6, 10(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r7, 9(r3)
	fmvtr	r30, f1
	sw	r30, 0(r7)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r7)
	lw	r30, 2(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r7)
	lw	r8, 8(r3)
	lw	r9, 0(r8)
	addi	r10, r0, 1				# li	r10, 1
	sub	r9, r9, r10
	lw	r28, 7(r3)
	sw	r5, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 25(r3)
	addi	r3, r3, 26
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -26
	lw	r30, 25(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 24(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r5, 6(r3)
	lw	r30, 0(r5)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r2)
	fmvfr	f2, r30
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 26(r3)				#stfd	f1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31644
	lw	r1, 24(r3)
	lw	r2, 119(r1)
	addi	r30, r0, 0
	lui	r30, r30, 49942	# to load float		-150.000000
	fmvfr	f1, r30
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 28(r3)
	addi	r3, r3, 29
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31645
beq_then.31644:
	lw	r1, 24(r3)
	lw	r2, 118(r1)
	addi	r30, r0, 0
	lui	r30, r30, 17174	# to load float		150.000000
	fmvfr	f1, r30
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 28(r3)
	addi	r3, r3, 29
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31645:
	addi	r6, r0, 116				# li	r6, 116
	lw	r1, 24(r3)
	lw	r2, 6(r3)
	lw	r5, 10(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31642
beq_then.31641:
beq_cont.31642:
	addi	r1, r0, 4				# li	r1, 4
	lw	r2, 12(r3)
	beq	r2, r1, beq_then.31646
	lw	r1, 11(r3)
	lw	r1, 4(r1)
	lw	r2, 10(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r5, 9(r3)
	fmvtr	r30, f1
	sw	r30, 0(r5)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r5)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r5)
	lw	r5, 8(r3)
	lw	r5, 0(r5)
	addi	r6, r0, 1				# li	r6, 1
	sub	r5, r5, r6
	lw	r28, 7(r3)
	sw	r1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 29(r3)
	addi	r3, r3, 30
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -30
	lw	r30, 29(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 28(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r5, 6(r3)
	lw	r30, 0(r5)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r2)
	fmvfr	f2, r30
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 30(r3)				#stfd	f1, 30(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31649
	lw	r1, 28(r3)
	lw	r2, 119(r1)
	addi	r30, r0, 0
	lui	r30, r30, 49942	# to load float		-150.000000
	fmvfr	f1, r30
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31650
beq_then.31649:
	lw	r1, 28(r3)
	lw	r2, 118(r1)
	addi	r30, r0, 0
	lui	r30, r30, 17174	# to load float		150.000000
	fmvfr	f1, r30
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31650:
	addi	r6, r0, 116				# li	r6, 116
	lw	r1, 28(r3)
	lw	r2, 6(r3)
	lw	r5, 10(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31647
beq_then.31646:
beq_cont.31647:
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 1(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r30, 0(r1)
	fmvfr	f2, r30
	lw	r5, 0(r3)
	lw	r30, 0(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r2)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r2)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r2)
	jr	r31				#	blr
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
	lw	r30, 0(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r9)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r9)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r9)
	add	r30, r10, r7
	lw	r2, 0(r30)
	lw	r30, 0(r9)
	fmvfr	f1, r30
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r9)
	lw	r30, 1(r9)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r9)
	lw	r30, 2(r9)
	fmvfr	f1, r30
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r9)
	add	r30, r11, r7
	lw	r2, 0(r30)
	lw	r30, 0(r9)
	fmvfr	f1, r30
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r9)
	lw	r30, 1(r9)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r9)
	lw	r30, 2(r9)
	fmvfr	f1, r30
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r9)
	add	r30, r12, r7
	lw	r2, 0(r30)
	lw	r30, 0(r9)
	fmvfr	f1, r30
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r9)
	lw	r30, 1(r9)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r9)
	lw	r30, 2(r9)
	fmvfr	f1, r30
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r9)
	add	r30, r6, r7
	lw	r2, 0(r30)
	lw	r30, 0(r9)
	fmvfr	f1, r30
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r9)
	lw	r30, 1(r9)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r9)
	lw	r30, 2(r9)
	fmvfr	f1, r30
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r9)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 4(r1)
	add	r30, r1, r7
	lw	r1, 0(r30)
	lw	r30, 0(r8)
	fmvfr	f1, r30
	lw	r30, 0(r1)
	fmvfr	f2, r30
	lw	r30, 0(r9)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r8)
	lw	r30, 1(r8)
	fmvfr	f1, r30
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r30, 1(r9)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r8)
	lw	r30, 2(r8)
	fmvfr	f1, r30
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 2(r9)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r8)
	jr	r31				#	blr
do_without_neighbors.2831:
	lw	r5, 9(r28)
	lw	r6, 8(r28)
	lw	r7, 7(r28)
	lw	r8, 6(r28)
	lw	r9, 5(r28)
	lw	r10, 4(r28)
	lw	r11, 3(r28)
	lw	r12, 2(r28)
	lw	r13, 1(r28)
	addi	r14, r0, 4				# li	r14, 4
	ble	r2, r14, ble_then.31653
	jr	r31				#	blr
ble_then.31653:
	lw	r14, 2(r1)
	addi	r15, r0, 0				# li	r15, 0
	add	r30, r14, r2
	lw	r14, 0(r30)
	ble	r15, r14, ble_then.31655
	jr	r31				#	blr
ble_then.31655:
	lw	r14, 3(r1)
	add	r30, r14, r2
	lw	r14, 0(r30)
	addi	r15, r0, 0				# li	r15, 0
	sw	r28, 0(r3)
	sw	r8, 1(r3)
	sw	r5, 2(r3)
	sw	r12, 3(r3)
	sw	r13, 4(r3)
	sw	r1, 5(r3)
	sw	r2, 6(r3)
	beq	r14, r15, beq_then.31657
	lw	r14, 5(r1)
	lw	r15, 7(r1)
	lw	r16, 1(r1)
	lw	r17, 4(r1)
	add	r30, r14, r2
	lw	r14, 0(r30)
	lw	r30, 0(r14)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r12)
	lw	r30, 1(r14)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r12)
	lw	r30, 2(r14)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r12)
	lw	r14, 6(r1)
	lw	r14, 0(r14)
	add	r30, r15, r2
	lw	r15, 0(r30)
	add	r30, r16, r2
	lw	r16, 0(r30)
	addi	r18, r0, 0				# li	r18, 0
	sw	r17, 7(r3)
	sw	r15, 8(r3)
	sw	r10, 9(r3)
	sw	r7, 10(r3)
	sw	r9, 11(r3)
	sw	r6, 12(r3)
	sw	r16, 13(r3)
	sw	r11, 14(r3)
	sw	r14, 15(r3)
	beq	r14, r18, beq_then.31659
	lw	r18, 0(r11)
	lw	r30, 0(r16)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r6)
	lw	r30, 1(r16)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r6)
	lw	r30, 2(r16)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r6)
	lw	r19, 0(r9)
	addi	r20, r0, 1				# li	r20, 1
	sub	r19, r19, r20
	sw	r18, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r19				# mr	r2, r19
	add	r1, r0, r16				# mr	r1, r16
	add	r28, r0, r7				# mr	r28, r7
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 16(r3)
	lw	r2, 8(r3)
	lw	r5, 13(r3)
	lw	r28, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31660
beq_then.31659:
beq_cont.31660:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 15(r3)
	beq	r2, r1, beq_then.31661
	lw	r1, 14(r3)
	lw	r5, 1(r1)
	lw	r6, 13(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r7, 12(r3)
	fmvtr	r30, f1
	sw	r30, 0(r7)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r7)
	lw	r30, 2(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r7)
	lw	r8, 11(r3)
	lw	r9, 0(r8)
	addi	r10, r0, 1				# li	r10, 1
	sub	r9, r9, r10
	lw	r28, 10(r3)
	sw	r5, 17(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 17(r3)
	lw	r2, 8(r3)
	lw	r5, 13(r3)
	lw	r28, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31662
beq_then.31661:
beq_cont.31662:
	addi	r1, r0, 2				# li	r1, 2
	lw	r2, 15(r3)
	beq	r2, r1, beq_then.31663
	lw	r1, 14(r3)
	lw	r5, 2(r1)
	lw	r6, 13(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r7, 12(r3)
	fmvtr	r30, f1
	sw	r30, 0(r7)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r7)
	lw	r30, 2(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r7)
	lw	r8, 11(r3)
	lw	r9, 0(r8)
	addi	r10, r0, 1				# li	r10, 1
	sub	r9, r9, r10
	lw	r28, 10(r3)
	sw	r5, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 18(r3)
	lw	r2, 8(r3)
	lw	r5, 13(r3)
	lw	r28, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31664
beq_then.31663:
beq_cont.31664:
	addi	r1, r0, 3				# li	r1, 3
	lw	r2, 15(r3)
	beq	r2, r1, beq_then.31665
	lw	r1, 14(r3)
	lw	r5, 3(r1)
	lw	r6, 13(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	lw	r7, 12(r3)
	fmvtr	r30, f1
	sw	r30, 0(r7)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r7)
	lw	r30, 2(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r7)
	lw	r8, 11(r3)
	lw	r9, 0(r8)
	addi	r10, r0, 1				# li	r10, 1
	sub	r9, r9, r10
	lw	r28, 10(r3)
	sw	r5, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 19(r3)
	lw	r2, 8(r3)
	lw	r5, 13(r3)
	lw	r28, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31666
beq_then.31665:
beq_cont.31666:
	addi	r1, r0, 4				# li	r1, 4
	lw	r2, 15(r3)
	beq	r2, r1, beq_then.31667
	lw	r1, 14(r3)
	lw	r1, 4(r1)
	lw	r2, 13(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r5, 12(r3)
	fmvtr	r30, f1
	sw	r30, 0(r5)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r5)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r5)
	lw	r5, 11(r3)
	lw	r5, 0(r5)
	addi	r6, r0, 1				# li	r6, 1
	sub	r5, r5, r6
	lw	r28, 10(r3)
	sw	r1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 20(r3)
	lw	r2, 8(r3)
	lw	r5, 13(r3)
	lw	r28, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31668
beq_then.31667:
beq_cont.31668:
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 1(r3)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r6, 3(r3)
	lw	r30, 0(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r5)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	lw	r30, 1(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r5)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 2(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r5)
	j	beq_cont.31658
beq_then.31657:
beq_cont.31658:
	lw	r1, 6(r3)
	addi	r2, r1, 1
	addi	r1, r0, 4				# li	r1, 4
	ble	r2, r1, ble_then.31669
	jr	r31				#	blr
ble_then.31669:
	lw	r1, 5(r3)
	lw	r5, 2(r1)
	addi	r6, r0, 0				# li	r6, 0
	add	r30, r5, r2
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.31671
	jr	r31				#	blr
ble_then.31671:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	sw	r2, 21(r3)
	beq	r5, r6, beq_then.31673
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31674
beq_then.31673:
beq_cont.31674:
	lw	r1, 21(r3)
	addi	r1, r1, 1
	addi	r2, r0, 4				# li	r2, 4
	ble	r1, r2, ble_then.31675
	jr	r31				#	blr
ble_then.31675:
	lw	r2, 5(r3)
	lw	r5, 2(r2)
	addi	r6, r0, 0				# li	r6, 0
	add	r30, r5, r1
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.31677
	jr	r31				#	blr
ble_then.31677:
	lw	r5, 3(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	beq	r5, r6, beq_then.31679
	lw	r5, 5(r2)
	lw	r6, 7(r2)
	lw	r7, 1(r2)
	lw	r8, 4(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r9, 3(r3)
	fmvtr	r30, f1
	sw	r30, 0(r9)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r9)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r9)
	lw	r5, 6(r2)
	lw	r5, 0(r5)
	add	r30, r6, r1
	lw	r6, 0(r30)
	add	r30, r7, r1
	lw	r7, 0(r30)
	lw	r28, 2(r3)
	sw	r1, 22(r3)
	sw	r8, 23(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r7				# mr	r5, r7
	sw	r30, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 22(r3)
	lw	r2, 23(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 1(r3)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r6, 3(r3)
	lw	r30, 0(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r5)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	lw	r30, 1(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r5)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 2(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r5)
	j	beq_cont.31680
beq_then.31679:
beq_cont.31680:
	addi	r2, r1, 1
	addi	r1, r0, 4				# li	r1, 4
	ble	r2, r1, ble_then.31681
	jr	r31				#	blr
ble_then.31681:
	lw	r1, 5(r3)
	lw	r5, 2(r1)
	addi	r6, r0, 0				# li	r6, 0
	add	r30, r5, r2
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.31683
	jr	r31				#	blr
ble_then.31683:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	sw	r2, 24(r3)
	beq	r5, r6, beq_then.31685
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 25(r3)
	addi	r3, r3, 26
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -26
	lw	r30, 25(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31686
beq_then.31685:
beq_cont.31686:
	lw	r1, 24(r3)
	addi	r2, r1, 1
	lw	r1, 5(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
try_exploit_neighbors.2847:
	lw	r9, 6(r28)
	lw	r10, 5(r28)
	lw	r11, 4(r28)
	lw	r12, 3(r28)
	lw	r13, 2(r28)
	lw	r14, 1(r28)
	add	r30, r6, r1
	lw	r15, 0(r30)
	addi	r16, r0, 4				# li	r16, 4
	ble	r8, r16, ble_then.31687
	jr	r31				#	blr
ble_then.31687:
	addi	r16, r0, 0				# li	r16, 0
	lw	r17, 2(r15)
	add	r30, r17, r8
	lw	r17, 0(r30)
	ble	r16, r17, ble_then.31689
	jr	r31				#	blr
ble_then.31689:
	add	r30, r6, r1
	lw	r16, 0(r30)
	lw	r16, 2(r16)
	add	r30, r16, r8
	lw	r16, 0(r30)
	add	r30, r5, r1
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	add	r30, r17, r8
	lw	r17, 0(r30)
	beq	r17, r16, beq_then.31691
	addi	r16, r0, 0				# li	r16, 0
	j	beq_cont.31692
beq_then.31691:
	add	r30, r7, r1
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	add	r30, r17, r8
	lw	r17, 0(r30)
	beq	r17, r16, beq_then.31693
	addi	r16, r0, 0				# li	r16, 0
	j	beq_cont.31694
beq_then.31693:
	addi	r17, r0, 1				# li	r17, 1
	sub	r17, r1, r17
	add	r30, r6, r17
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	add	r30, r17, r8
	lw	r17, 0(r30)
	beq	r17, r16, beq_then.31695
	addi	r16, r0, 0				# li	r16, 0
	j	beq_cont.31696
beq_then.31695:
	addi	r17, r1, 1
	add	r30, r6, r17
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	add	r30, r17, r8
	lw	r17, 0(r30)
	beq	r17, r16, beq_then.31697
	addi	r16, r0, 0				# li	r16, 0
	j	beq_cont.31698
beq_then.31697:
	addi	r16, r0, 1				# li	r16, 1
beq_cont.31698:
beq_cont.31696:
beq_cont.31694:
beq_cont.31692:
	addi	r17, r0, 0				# li	r17, 0
	beq	r16, r17, beq_then.31699
	lw	r15, 3(r15)
	add	r30, r15, r8
	lw	r15, 0(r30)
	addi	r16, r0, 0				# li	r16, 0
	beq	r15, r16, beq_then.31700
	add	r30, r5, r1
	lw	r15, 0(r30)
	lw	r15, 5(r15)
	addi	r16, r0, 1				# li	r16, 1
	sub	r16, r1, r16
	add	r30, r6, r16
	lw	r16, 0(r30)
	lw	r16, 5(r16)
	add	r30, r6, r1
	lw	r17, 0(r30)
	lw	r17, 5(r17)
	addi	r18, r1, 1
	add	r30, r6, r18
	lw	r18, 0(r30)
	lw	r18, 5(r18)
	add	r30, r7, r1
	lw	r19, 0(r30)
	lw	r19, 5(r19)
	add	r30, r15, r8
	lw	r15, 0(r30)
	lw	r30, 0(r15)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r12)
	lw	r30, 1(r15)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r12)
	lw	r30, 2(r15)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r12)
	add	r30, r16, r8
	lw	r15, 0(r30)
	lw	r30, 0(r12)
	fmvfr	f1, r30
	lw	r30, 0(r15)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r12)
	lw	r30, 1(r12)
	fmvfr	f1, r30
	lw	r30, 1(r15)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r12)
	lw	r30, 2(r12)
	fmvfr	f1, r30
	lw	r30, 2(r15)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r12)
	add	r30, r17, r8
	lw	r15, 0(r30)
	lw	r30, 0(r12)
	fmvfr	f1, r30
	lw	r30, 0(r15)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r12)
	lw	r30, 1(r12)
	fmvfr	f1, r30
	lw	r30, 1(r15)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r12)
	lw	r30, 2(r12)
	fmvfr	f1, r30
	lw	r30, 2(r15)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r12)
	add	r30, r18, r8
	lw	r15, 0(r30)
	lw	r30, 0(r12)
	fmvfr	f1, r30
	lw	r30, 0(r15)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r12)
	lw	r30, 1(r12)
	fmvfr	f1, r30
	lw	r30, 1(r15)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r12)
	lw	r30, 2(r12)
	fmvfr	f1, r30
	lw	r30, 2(r15)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r12)
	add	r30, r19, r8
	lw	r15, 0(r30)
	lw	r30, 0(r12)
	fmvfr	f1, r30
	lw	r30, 0(r15)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r12)
	lw	r30, 1(r12)
	fmvfr	f1, r30
	lw	r30, 1(r15)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r12)
	lw	r30, 2(r12)
	fmvfr	f1, r30
	lw	r30, 2(r15)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r12)
	add	r30, r6, r1
	lw	r15, 0(r30)
	lw	r15, 4(r15)
	add	r30, r15, r8
	lw	r15, 0(r30)
	lw	r30, 0(r10)
	fmvfr	f1, r30
	lw	r30, 0(r15)
	fmvfr	f2, r30
	lw	r30, 0(r12)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r10)
	lw	r30, 1(r10)
	fmvfr	f1, r30
	lw	r30, 1(r15)
	fmvfr	f2, r30
	lw	r30, 1(r12)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r10)
	lw	r30, 2(r10)
	fmvfr	f1, r30
	lw	r30, 2(r15)
	fmvfr	f2, r30
	lw	r30, 2(r12)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r10)
	j	beq_cont.31701
beq_then.31700:
beq_cont.31701:
	addi	r8, r8, 1
	add	r30, r6, r1
	lw	r15, 0(r30)
	addi	r16, r0, 4				# li	r16, 4
	ble	r8, r16, ble_then.31702
	jr	r31				#	blr
ble_then.31702:
	addi	r16, r0, 0				# li	r16, 0
	lw	r17, 2(r15)
	add	r30, r17, r8
	lw	r17, 0(r30)
	ble	r16, r17, ble_then.31704
	jr	r31				#	blr
ble_then.31704:
	add	r30, r6, r1
	lw	r16, 0(r30)
	lw	r16, 2(r16)
	add	r30, r16, r8
	lw	r16, 0(r30)
	add	r30, r5, r1
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	add	r30, r17, r8
	lw	r17, 0(r30)
	beq	r17, r16, beq_then.31706
	addi	r16, r0, 0				# li	r16, 0
	j	beq_cont.31707
beq_then.31706:
	add	r30, r7, r1
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	add	r30, r17, r8
	lw	r17, 0(r30)
	beq	r17, r16, beq_then.31708
	addi	r16, r0, 0				# li	r16, 0
	j	beq_cont.31709
beq_then.31708:
	addi	r17, r0, 1				# li	r17, 1
	sub	r17, r1, r17
	add	r30, r6, r17
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	add	r30, r17, r8
	lw	r17, 0(r30)
	beq	r17, r16, beq_then.31710
	addi	r16, r0, 0				# li	r16, 0
	j	beq_cont.31711
beq_then.31710:
	addi	r17, r1, 1
	add	r30, r6, r17
	lw	r17, 0(r30)
	lw	r17, 2(r17)
	add	r30, r17, r8
	lw	r17, 0(r30)
	beq	r17, r16, beq_then.31712
	addi	r16, r0, 0				# li	r16, 0
	j	beq_cont.31713
beq_then.31712:
	addi	r16, r0, 1				# li	r16, 1
beq_cont.31713:
beq_cont.31711:
beq_cont.31709:
beq_cont.31707:
	addi	r17, r0, 0				# li	r17, 0
	beq	r16, r17, beq_then.31714
	lw	r9, 3(r15)
	add	r30, r9, r8
	lw	r9, 0(r30)
	addi	r10, r0, 0				# li	r10, 0
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	sw	r28, 5(r3)
	sw	r8, 6(r3)
	beq	r9, r10, beq_then.31715
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r28, r0, r13				# mr	r28, r13
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r8				# mr	r7, r8
	sw	r30, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31716
beq_then.31715:
beq_cont.31716:
	lw	r1, 6(r3)
	addi	r8, r1, 1
	lw	r1, 4(r3)
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	lw	r6, 1(r3)
	lw	r7, 0(r3)
	lw	r28, 5(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.31714:
	add	r30, r6, r1
	lw	r1, 0(r30)
	addi	r2, r0, 4				# li	r2, 4
	ble	r8, r2, ble_then.31717
	jr	r31				#	blr
ble_then.31717:
	lw	r2, 2(r1)
	addi	r5, r0, 0				# li	r5, 0
	add	r30, r2, r8
	lw	r2, 0(r30)
	ble	r5, r2, ble_then.31719
	jr	r31				#	blr
ble_then.31719:
	lw	r2, 3(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
	sw	r11, 7(r3)
	sw	r14, 8(r3)
	sw	r1, 9(r3)
	sw	r8, 6(r3)
	beq	r2, r5, beq_then.31721
	lw	r2, 5(r1)
	lw	r5, 7(r1)
	lw	r6, 1(r1)
	lw	r7, 4(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r12)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r12)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r12)
	lw	r2, 6(r1)
	lw	r2, 0(r2)
	add	r30, r5, r8
	lw	r5, 0(r30)
	add	r30, r6, r8
	lw	r6, 0(r30)
	sw	r12, 10(r3)
	sw	r10, 11(r3)
	sw	r7, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r28, r0, r9				# mr	r28, r9
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	lw	r2, 12(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 11(r3)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r6, 10(r3)
	lw	r30, 0(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r5)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	lw	r30, 1(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r5)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 2(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r5)
	j	beq_cont.31722
beq_then.31721:
beq_cont.31722:
	lw	r1, 6(r3)
	addi	r2, r1, 1
	addi	r1, r0, 4				# li	r1, 4
	ble	r2, r1, ble_then.31723
	jr	r31				#	blr
ble_then.31723:
	lw	r1, 9(r3)
	lw	r5, 2(r1)
	addi	r6, r0, 0				# li	r6, 0
	add	r30, r5, r2
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.31725
	jr	r31				#	blr
ble_then.31725:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	sw	r2, 13(r3)
	beq	r5, r6, beq_then.31727
	lw	r28, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31728
beq_then.31727:
beq_cont.31728:
	lw	r1, 13(r3)
	addi	r2, r1, 1
	lw	r1, 9(r3)
	lw	r28, 7(r3)
	lw	r27, 0(r28)
	jr	r27
beq_then.31699:
	add	r30, r6, r1
	lw	r1, 0(r30)
	addi	r2, r0, 4				# li	r2, 4
	ble	r8, r2, ble_then.31729
	jr	r31				#	blr
ble_then.31729:
	lw	r2, 2(r1)
	addi	r5, r0, 0				# li	r5, 0
	add	r30, r2, r8
	lw	r2, 0(r30)
	ble	r5, r2, ble_then.31731
	jr	r31				#	blr
ble_then.31731:
	lw	r2, 3(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
	sw	r11, 7(r3)
	sw	r14, 8(r3)
	sw	r10, 11(r3)
	sw	r9, 14(r3)
	sw	r12, 10(r3)
	sw	r1, 15(r3)
	sw	r8, 16(r3)
	beq	r2, r5, beq_then.31733
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r28, r0, r14				# mr	r28, r14
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31734
beq_then.31733:
beq_cont.31734:
	lw	r1, 16(r3)
	addi	r1, r1, 1
	addi	r2, r0, 4				# li	r2, 4
	ble	r1, r2, ble_then.31735
	jr	r31				#	blr
ble_then.31735:
	lw	r2, 15(r3)
	lw	r5, 2(r2)
	addi	r6, r0, 0				# li	r6, 0
	add	r30, r5, r1
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.31737
	jr	r31				#	blr
ble_then.31737:
	lw	r5, 3(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	beq	r5, r6, beq_then.31739
	lw	r5, 5(r2)
	lw	r6, 7(r2)
	lw	r7, 1(r2)
	lw	r8, 4(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r9, 10(r3)
	fmvtr	r30, f1
	sw	r30, 0(r9)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r9)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r9)
	lw	r5, 6(r2)
	lw	r5, 0(r5)
	add	r30, r6, r1
	lw	r6, 0(r30)
	add	r30, r7, r1
	lw	r7, 0(r30)
	lw	r28, 14(r3)
	sw	r1, 17(r3)
	sw	r8, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r7				# mr	r5, r7
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 17(r3)
	lw	r2, 18(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 11(r3)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r30, 0(r2)
	fmvfr	f2, r30
	lw	r6, 10(r3)
	lw	r30, 0(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r5)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	lw	r30, 1(r2)
	fmvfr	f2, r30
	lw	r30, 1(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r5)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 2(r6)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r5)
	j	beq_cont.31740
beq_then.31739:
beq_cont.31740:
	addi	r2, r1, 1
	addi	r1, r0, 4				# li	r1, 4
	ble	r2, r1, ble_then.31741
	jr	r31				#	blr
ble_then.31741:
	lw	r1, 15(r3)
	lw	r5, 2(r1)
	addi	r6, r0, 0				# li	r6, 0
	add	r30, r5, r2
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.31743
	jr	r31				#	blr
ble_then.31743:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	sw	r2, 19(r3)
	beq	r5, r6, beq_then.31745
	lw	r28, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31746
beq_then.31745:
beq_cont.31746:
	lw	r1, 19(r3)
	addi	r2, r1, 1
	lw	r1, 15(r3)
	lw	r28, 7(r3)
	lw	r27, 0(r28)
	jr	r27
pretrace_diffuse_rays.2860:
	lw	r5, 7(r28)
	lw	r6, 6(r28)
	lw	r7, 5(r28)
	lw	r8, 4(r28)
	lw	r9, 3(r28)
	lw	r10, 2(r28)
	lw	r11, 1(r28)
	addi	r12, r0, 4				# li	r12, 4
	ble	r2, r12, ble_then.31747
	jr	r31				#	blr
ble_then.31747:
	lw	r12, 2(r1)
	add	r30, r12, r2
	lw	r12, 0(r30)
	addi	r13, r0, 0				# li	r13, 0
	ble	r13, r12, ble_then.31749
	jr	r31				#	blr
ble_then.31749:
	lw	r12, 3(r1)
	add	r30, r12, r2
	lw	r12, 0(r30)
	addi	r13, r0, 0				# li	r13, 0
	sw	r28, 0(r3)
	sw	r9, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	sw	r8, 4(r3)
	sw	r6, 5(r3)
	sw	r10, 6(r3)
	sw	r11, 7(r3)
	sw	r2, 8(r3)
	beq	r12, r13, beq_then.31751
	lw	r12, 6(r1)
	lw	r12, 0(r12)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r11)
	fmvtr	r30, f1
	sw	r30, 1(r11)
	fmvtr	r30, f1
	sw	r30, 2(r11)
	lw	r13, 7(r1)
	lw	r14, 1(r1)
	add	r30, r10, r12
	lw	r12, 0(r30)
	add	r30, r13, r2
	lw	r13, 0(r30)
	add	r30, r14, r2
	lw	r14, 0(r30)
	lw	r30, 0(r14)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r6)
	lw	r30, 1(r14)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r6)
	lw	r30, 2(r14)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r6)
	lw	r15, 0(r8)
	addi	r16, r0, 1				# li	r16, 1
	sub	r15, r15, r16
	sw	r1, 9(r3)
	sw	r14, 10(r3)
	sw	r13, 11(r3)
	sw	r12, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r15				# mr	r2, r15
	add	r1, r0, r14				# mr	r1, r14
	add	r28, r0, r7				# mr	r28, r7
	sw	r30, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 12(r3)
	lw	r2, 11(r3)
	lw	r5, 10(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 9(r3)
	lw	r2, 5(r1)
	lw	r5, 8(r3)
	add	r30, r2, r5
	lw	r2, 0(r30)
	lw	r6, 7(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r2)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r2)
	lw	r30, 2(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r2)
	j	beq_cont.31752
beq_then.31751:
beq_cont.31752:
	lw	r2, 8(r3)
	addi	r2, r2, 1
	addi	r5, r0, 4				# li	r5, 4
	ble	r2, r5, ble_then.31753
	jr	r31				#	blr
ble_then.31753:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r5, ble_then.31755
	jr	r31				#	blr
ble_then.31755:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	sw	r2, 13(r3)
	beq	r5, r6, beq_then.31757
	lw	r5, 6(r1)
	lw	r5, 0(r5)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r6, 7(r3)
	fmvtr	r30, f1
	sw	r30, 0(r6)
	fmvtr	r30, f1
	sw	r30, 1(r6)
	fmvtr	r30, f1
	sw	r30, 2(r6)
	lw	r7, 7(r1)
	lw	r8, 1(r1)
	lw	r9, 6(r3)
	add	r30, r9, r5
	lw	r5, 0(r30)
	add	r30, r7, r2
	lw	r7, 0(r30)
	add	r30, r8, r2
	lw	r8, 0(r30)
	lw	r30, 0(r8)
	fmvfr	f1, r30
	lw	r9, 5(r3)
	fmvtr	r30, f1
	sw	r30, 0(r9)
	lw	r30, 1(r8)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r9)
	lw	r30, 2(r8)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r9)
	lw	r9, 4(r3)
	lw	r9, 0(r9)
	addi	r10, r0, 1				# li	r10, 1
	sub	r9, r9, r10
	lw	r28, 3(r3)
	sw	r1, 9(r3)
	sw	r8, 14(r3)
	sw	r7, 15(r3)
	sw	r5, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 16(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r5, 15(r3)
	lw	r30, 0(r5)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r2)
	fmvfr	f2, r30
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31760
	lw	r1, 16(r3)
	lw	r2, 119(r1)
	addi	r30, r0, 0
	lui	r30, r30, 49942	# to load float		-150.000000
	fmvfr	f1, r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31761
beq_then.31760:
	lw	r1, 16(r3)
	lw	r2, 118(r1)
	addi	r30, r0, 0
	lui	r30, r30, 17174	# to load float		150.000000
	fmvfr	f1, r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31761:
	addi	r6, r0, 116				# li	r6, 116
	lw	r1, 16(r3)
	lw	r2, 15(r3)
	lw	r5, 14(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 9(r3)
	lw	r2, 5(r1)
	lw	r5, 13(r3)
	add	r30, r2, r5
	lw	r2, 0(r30)
	lw	r6, 7(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r2)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r2)
	lw	r30, 2(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r2)
	j	beq_cont.31758
beq_then.31757:
beq_cont.31758:
	lw	r2, 13(r3)
	addi	r2, r2, 1
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
pretrace_pixels.2863:
	lw	r6, 16(r28)
	lw	r7, 15(r28)
	lw	r8, 14(r28)
	lw	r9, 13(r28)
	lw	r10, 12(r28)
	lw	r11, 11(r28)
	lw	r12, 10(r28)
	lw	r13, 9(r28)
	lw	r14, 8(r28)
	lw	r15, 7(r28)
	lw	r16, 6(r28)
	lw	r17, 5(r28)
	lw	r18, 4(r28)
	lw	r19, 3(r28)
	lw	r20, 2(r28)
	lw	r21, 1(r28)
	addi	r22, r0, 0				# li	r22, 0
	ble	r22, r2, ble_then.31762
	jr	r31				#	blr
ble_then.31762:
	lw	r30, 0(r13)
	fmvfr	f4, r30
	lw	r22, 0(r19)
	sub	r22, r2, r22
	sw	r28, 0(r3)
	sw	r19, 1(r3)
	sw	r13, 2(r3)
	sw	r16, 3(r3)
	sw	r18, 4(r3)
	sw	r8, 5(r3)
	sw	r11, 6(r3)
	sw	r17, 7(r3)
	sw	r9, 8(r3)
	sw	r20, 9(r3)
	sw	r21, 10(r3)
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	sw	r2, 13(r3)
	sw	r1, 14(r3)
	sw	r10, 15(r3)
	sw	r6, 16(r3)
	sw	r14, 17(r3)
	fmvtr	r30, f3
	sw	r30, 18(r3)				#stfd	f3, 18(r3)
	fmvtr	r30, f2
	sw	r30, 20(r3)				#stfd	f2, 20(r3)
	sw	r15, 22(r3)
	fmvtr	r30, f1
	sw	r30, 24(r3)				#stfd	f1, 24(r3)
	sw	r12, 26(r3)
	fmvtr	r30, f4
	sw	r30, 28(r3)				#stfd	f4, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r22				# mr	r1, r22
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 26(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r30, 24(r3)				#lfd	f3, 24(r3)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	lw	r2, 22(r3)
	fmvtr	r30, f2
	sw	r30, 0(r2)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r30, 20(r3)				#lfd	f4, 20(r3)
	fmvfr	f4, r30
	fadd	f2, f2, f4
	fmvtr	r30, f2
	sw	r30, 1(r2)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r2)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 22(r3)
	lw	r30, 1(r1)
	fmvfr	f2, r30
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
	fadd	f1, f2, f1
	lw	r1, 22(r3)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 32(r3)				#stfd	f1, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 34(r3)				#stfd	f1, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31766
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	j	beq_cont.31767
beq_then.31766:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
beq_cont.31767:
	lw	r2, 22(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	fmvtr	r30, f2
	sw	r30, 0(r2)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	fmvtr	r30, f2
	sw	r30, 1(r2)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	fmvtr	r30, f1
	sw	r30, 2(r2)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 17(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r5, 16(r3)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r6, 15(r3)
	fmvtr	r30, f1
	sw	r30, 0(r6)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r6)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r6)
	addi	r7, r0, 0				# li	r7, 0
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r8, 13(r3)
	lw	r9, 14(r3)
	add	r30, r9, r8
	lw	r10, 0(r30)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
	lw	r28, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r10				# mr	r5, r10
	add	r1, r0, r7				# mr	r1, r7
	sw	r30, 36(r3)
	addi	r3, r3, 37
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 13(r3)
	lw	r2, 14(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	lw	r6, 17(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r5)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r5)
	lw	r30, 2(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r5)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 6(r5)
	lw	r7, 11(r3)
	sw	r7, 0(r5)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r8, 2(r5)
	lw	r8, 0(r8)
	addi	r9, r0, 0				# li	r9, 0
	ble	r9, r8, ble_then.31768
	j	ble_cont.31769
ble_then.31768:
	lw	r8, 3(r5)
	lw	r8, 0(r8)
	addi	r9, r0, 0				# li	r9, 0
	sw	r5, 36(r3)
	beq	r8, r9, beq_then.31770
	lw	r8, 6(r5)
	lw	r8, 0(r8)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r9, 10(r3)
	fmvtr	r30, f1
	sw	r30, 0(r9)
	fmvtr	r30, f1
	sw	r30, 1(r9)
	fmvtr	r30, f1
	sw	r30, 2(r9)
	lw	r10, 7(r5)
	lw	r11, 1(r5)
	lw	r12, 9(r3)
	add	r30, r12, r8
	lw	r8, 0(r30)
	lw	r10, 0(r10)
	lw	r11, 0(r11)
	lw	r30, 0(r11)
	fmvfr	f1, r30
	lw	r12, 8(r3)
	fmvtr	r30, f1
	sw	r30, 0(r12)
	lw	r30, 1(r11)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r12)
	lw	r30, 2(r11)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r12)
	lw	r12, 7(r3)
	lw	r12, 0(r12)
	addi	r13, r0, 1				# li	r13, 1
	sub	r12, r12, r13
	lw	r28, 6(r3)
	sw	r11, 37(r3)
	sw	r10, 38(r3)
	sw	r8, 39(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r11				# mr	r1, r11
	sw	r30, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 39(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r5, 38(r3)
	lw	r30, 0(r5)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 1(r2)
	fmvfr	f2, r30
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r30, 2(r2)
	fmvfr	f2, r30
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 40(r3)				#stfd	f1, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_fisneg				#	bl	lib_fisneg
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31772
	lw	r1, 39(r3)
	lw	r2, 119(r1)
	addi	r30, r0, 0
	lui	r30, r30, 49942	# to load float		-150.000000
	fmvfr	f1, r30
	lw	r30, 40(r3)				#lfd	f2, 40(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31773
beq_then.31772:
	lw	r1, 39(r3)
	lw	r2, 118(r1)
	addi	r30, r0, 0
	lui	r30, r30, 17174	# to load float		150.000000
	fmvfr	f1, r30
	lw	r30, 40(r3)				#lfd	f2, 40(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
beq_cont.31773:
	addi	r6, r0, 116				# li	r6, 116
	lw	r1, 39(r3)
	lw	r2, 38(r3)
	lw	r5, 37(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 36(r3)
	lw	r2, 5(r1)
	lw	r2, 0(r2)
	lw	r5, 10(r3)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r2)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r2)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r2)
	j	beq_cont.31771
beq_then.31770:
beq_cont.31771:
	addi	r2, r0, 1				# li	r2, 1
	lw	r1, 36(r3)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.31769:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 13(r3)
	sub	r1, r2, r1
	lw	r2, 11(r3)
	addi	r2, r2, 1
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r2, ble_then.31774
	j	ble_cont.31775
ble_then.31774:
	addi	r5, r0, 5				# li	r5, 5
	sub	r2, r2, r5
ble_cont.31775:
	addi	r5, r0, 0				# li	r5, 0
	ble	r5, r1, ble_then.31776
	jr	r31				#	blr
ble_then.31776:
	lw	r5, 2(r3)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r5, 1(r3)
	lw	r5, 0(r5)
	sub	r5, r1, r5
	sw	r2, 42(r3)
	sw	r1, 43(r3)
	fmvtr	r30, f1
	sw	r30, 44(r3)				#stfd	f1, 44(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 44(r3)				#lfd	f2, 44(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 26(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r30, 24(r3)				#lfd	f3, 24(r3)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	lw	r2, 22(r3)
	fmvtr	r30, f2
	sw	r30, 0(r2)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r30, 20(r3)				#lfd	f4, 20(r3)
	fmvfr	f4, r30
	fadd	f2, f2, f4
	fmvtr	r30, f2
	sw	r30, 1(r2)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r2)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 46(r3)
	addi	r3, r3, 47
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -47
	lw	r30, 46(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 22(r3)
	lw	r30, 1(r1)
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
	fadd	f1, f2, f1
	lw	r1, 22(r3)
	lw	r30, 2(r1)
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
	fmvtr	r30, f1
	sw	r30, 50(r3)				#stfd	f1, 50(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31778
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	j	beq_cont.31779
beq_then.31778:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r30, 50(r3)				#lfd	f2, 50(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
beq_cont.31779:
	lw	r2, 22(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	fmvtr	r30, f2
	sw	r30, 0(r2)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	fmvtr	r30, f2
	sw	r30, 1(r2)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	fmvtr	r30, f1
	sw	r30, 2(r2)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 17(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r5, 16(r3)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r6, 15(r3)
	fmvtr	r30, f1
	sw	r30, 0(r6)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r6)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r6)
	addi	r5, r0, 0				# li	r5, 0
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r6, 43(r3)
	lw	r7, 14(r3)
	add	r30, r7, r6
	lw	r8, 0(r30)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
	lw	r28, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r8				# mr	r5, r8
	sw	r30, 52(r3)
	addi	r3, r3, 53
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 43(r3)
	lw	r2, 14(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	lw	r6, 17(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r5)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r5)
	lw	r30, 2(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r5)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 6(r5)
	lw	r6, 42(r3)
	sw	r6, 0(r5)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 52(r3)
	addi	r3, r3, 53
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 43(r3)
	sub	r2, r2, r1
	lw	r1, 42(r3)
	addi	r1, r1, 1
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r1, ble_then.31780
	add	r5, r0, r1				# mr	r5, r1
	j	ble_cont.31781
ble_then.31780:
	addi	r5, r0, 5				# li	r5, 5
	sub	r5, r1, r5
ble_cont.31781:
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	lw	r30, 18(r3)				#lfd	f3, 18(r3)
	fmvfr	f3, r30
	lw	r1, 14(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
pretrace_line.2870:
	lw	r6, 13(r28)
	lw	r7, 12(r28)
	lw	r8, 11(r28)
	lw	r9, 10(r28)
	lw	r10, 9(r28)
	lw	r11, 8(r28)
	lw	r12, 7(r28)
	lw	r13, 6(r28)
	lw	r14, 5(r28)
	lw	r15, 4(r28)
	lw	r16, 3(r28)
	lw	r17, 2(r28)
	lw	r18, 1(r28)
	lw	r30, 0(r12)
	fmvfr	f1, r30
	lw	r19, 1(r18)
	sub	r2, r2, r19
	sw	r15, 0(r3)
	sw	r16, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	sw	r1, 4(r3)
	sw	r8, 5(r3)
	sw	r6, 6(r3)
	sw	r13, 7(r3)
	sw	r14, 8(r3)
	sw	r11, 9(r3)
	sw	r18, 10(r3)
	sw	r12, 11(r3)
	sw	r17, 12(r3)
	sw	r9, 13(r3)
	sw	r10, 14(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 14(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r2, 13(r3)
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
	lw	r1, 12(r3)
	lw	r1, 0(r1)
	addi	r2, r0, 1				# li	r2, 1
	sub	r1, r1, r2
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31783
	jr	r31				#	blr
ble_then.31783:
	lw	r2, 11(r3)
	lw	r30, 0(r2)
	fmvfr	f4, r30
	lw	r2, 10(r3)
	lw	r2, 0(r2)
	sub	r2, r1, r2
	sw	r1, 18(r3)
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	fmvtr	r30, f3
	sw	r30, 22(r3)				#stfd	f3, 22(r3)
	fmvtr	r30, f2
	sw	r30, 24(r3)				#stfd	f2, 24(r3)
	fmvtr	r30, f4
	sw	r30, 26(r3)				#stfd	f4, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 26(r3)				#lfd	f2, 26(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 9(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r30, 24(r3)				#lfd	f3, 24(r3)
	fmvfr	f3, r30
	fadd	f2, f2, f3
	lw	r2, 8(r3)
	fmvtr	r30, f2
	sw	r30, 0(r2)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r30, 22(r3)				#lfd	f4, 22(r3)
	fmvfr	f4, r30
	fadd	f2, f2, f4
	fmvtr	r30, f2
	sw	r30, 1(r2)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r2)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r1, 8(r3)
	lw	r30, 2(r1)
	fmvfr	f2, r30
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
	fadd	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	fmvtr	r30, f1
	sw	r30, 32(r3)				#stfd	f1, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fiszero				#	bl	lib_fiszero
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.31786
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	j	beq_cont.31787
beq_then.31786:
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fdiv	f1, f1, f2
beq_cont.31787:
	lw	r2, 8(r3)
	lw	r30, 0(r2)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	fmvtr	r30, f2
	sw	r30, 0(r2)
	lw	r30, 1(r2)
	fmvfr	f2, r30
	fmul	f2, f2, f1
	fmvtr	r30, f2
	sw	r30, 1(r2)
	lw	r30, 2(r2)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	fmvtr	r30, f1
	sw	r30, 2(r2)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	lw	r1, 7(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r5, 6(r3)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r6, 5(r3)
	fmvtr	r30, f1
	sw	r30, 0(r6)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r6)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r6)
	addi	r5, r0, 0				# li	r5, 0
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r6, 18(r3)
	lw	r7, 4(r3)
	add	r30, r7, r6
	lw	r8, 0(r30)
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f2, r30
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r8				# mr	r5, r8
	sw	r30, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 18(r3)
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	lw	r6, 7(r3)
	lw	r30, 0(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r5)
	lw	r30, 1(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r5)
	lw	r30, 2(r6)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r5)
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
	sw	r30, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 18(r3)
	sub	r2, r2, r1
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r1, ble_then.31788
	add	r5, r0, r1				# mr	r5, r1
	j	ble_cont.31789
ble_then.31788:
	addi	r5, r0, 5				# li	r5, 5
	sub	r5, r1, r5
ble_cont.31789:
	lw	r30, 24(r3)				#lfd	f1, 24(r3)
	fmvfr	f1, r30
	lw	r30, 22(r3)				#lfd	f2, 22(r3)
	fmvfr	f2, r30
	lw	r30, 20(r3)				#lfd	f3, 20(r3)
	fmvfr	f3, r30
	lw	r1, 4(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
scan_pixel.2874:
	lw	r8, 8(r28)
	lw	r9, 7(r28)
	lw	r10, 6(r28)
	lw	r11, 5(r28)
	lw	r12, 4(r28)
	lw	r13, 3(r28)
	lw	r14, 2(r28)
	lw	r15, 1(r28)
	lw	r16, 0(r11)
	ble	r16, r1, ble_then.31790
	add	r30, r6, r1
	lw	r16, 0(r30)
	lw	r16, 0(r16)
	lw	r30, 0(r16)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r10)
	lw	r30, 1(r16)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r10)
	lw	r30, 2(r16)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r10)
	lw	r16, 1(r11)
	addi	r17, r2, 1
	ble	r16, r17, ble_then.31791
	addi	r16, r0, 0				# li	r16, 0
	ble	r2, r16, ble_then.31793
	lw	r16, 0(r11)
	addi	r17, r1, 1
	ble	r16, r17, ble_then.31795
	addi	r16, r0, 0				# li	r16, 0
	ble	r1, r16, ble_then.31797
	addi	r16, r0, 1				# li	r16, 1
	j	ble_cont.31798
ble_then.31797:
	addi	r16, r0, 0				# li	r16, 0
ble_cont.31798:
	j	ble_cont.31796
ble_then.31795:
	addi	r16, r0, 0				# li	r16, 0
ble_cont.31796:
	j	ble_cont.31794
ble_then.31793:
	addi	r16, r0, 0				# li	r16, 0
ble_cont.31794:
	j	ble_cont.31792
ble_then.31791:
	addi	r16, r0, 0				# li	r16, 0
ble_cont.31792:
	addi	r17, r0, 0				# li	r17, 0
	sw	r28, 0(r3)
	sw	r7, 1(r3)
	sw	r5, 2(r3)
	sw	r8, 3(r3)
	sw	r12, 4(r3)
	sw	r15, 5(r3)
	sw	r9, 6(r3)
	sw	r13, 7(r3)
	sw	r2, 8(r3)
	sw	r6, 9(r3)
	sw	r11, 10(r3)
	sw	r1, 11(r3)
	sw	r10, 12(r3)
	beq	r16, r17, beq_then.31799
	addi	r16, r0, 0				# li	r16, 0
	add	r30, r6, r1
	lw	r17, 0(r30)
	addi	r18, r0, 0				# li	r18, 0
	lw	r19, 2(r17)
	lw	r19, 0(r19)
	ble	r18, r19, ble_then.31801
	j	ble_cont.31802
ble_then.31801:
	add	r30, r6, r1
	lw	r18, 0(r30)
	lw	r18, 2(r18)
	lw	r18, 0(r18)
	add	r30, r5, r1
	lw	r19, 0(r30)
	lw	r19, 2(r19)
	lw	r19, 0(r19)
	beq	r19, r18, beq_then.31803
	addi	r18, r0, 0				# li	r18, 0
	j	beq_cont.31804
beq_then.31803:
	add	r30, r7, r1
	lw	r19, 0(r30)
	lw	r19, 2(r19)
	lw	r19, 0(r19)
	beq	r19, r18, beq_then.31805
	addi	r18, r0, 0				# li	r18, 0
	j	beq_cont.31806
beq_then.31805:
	addi	r19, r0, 1				# li	r19, 1
	sub	r19, r1, r19
	add	r30, r6, r19
	lw	r19, 0(r30)
	lw	r19, 2(r19)
	lw	r19, 0(r19)
	beq	r19, r18, beq_then.31807
	addi	r18, r0, 0				# li	r18, 0
	j	beq_cont.31808
beq_then.31807:
	addi	r19, r1, 1
	add	r30, r6, r19
	lw	r19, 0(r30)
	lw	r19, 2(r19)
	lw	r19, 0(r19)
	beq	r19, r18, beq_then.31809
	addi	r18, r0, 0				# li	r18, 0
	j	beq_cont.31810
beq_then.31809:
	addi	r18, r0, 1				# li	r18, 1
beq_cont.31810:
beq_cont.31808:
beq_cont.31806:
beq_cont.31804:
	addi	r19, r0, 0				# li	r19, 0
	beq	r18, r19, beq_then.31811
	lw	r17, 3(r17)
	lw	r17, 0(r17)
	addi	r18, r0, 0				# li	r18, 0
	beq	r17, r18, beq_then.31813
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r28, r0, r14				# mr	r28, r14
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r16				# mr	r7, r16
	sw	r30, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31814
beq_then.31813:
beq_cont.31814:
	addi	r8, r0, 1				# li	r8, 1
	lw	r1, 11(r3)
	lw	r2, 8(r3)
	lw	r5, 2(r3)
	lw	r6, 9(r3)
	lw	r7, 1(r3)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31812
beq_then.31811:
	add	r30, r6, r1
	lw	r14, 0(r30)
	lw	r16, 2(r14)
	addi	r17, r0, 0				# li	r17, 0
	lw	r16, 0(r16)
	ble	r17, r16, ble_then.31815
	j	ble_cont.31816
ble_then.31815:
	lw	r16, 3(r14)
	lw	r16, 0(r16)
	addi	r17, r0, 0				# li	r17, 0
	sw	r14, 13(r3)
	beq	r16, r17, beq_then.31817
	lw	r16, 5(r14)
	lw	r17, 7(r14)
	lw	r18, 1(r14)
	lw	r19, 4(r14)
	lw	r16, 0(r16)
	lw	r30, 0(r16)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r13)
	lw	r30, 1(r16)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r13)
	lw	r30, 2(r16)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r13)
	lw	r16, 6(r14)
	lw	r16, 0(r16)
	lw	r17, 0(r17)
	lw	r18, 0(r18)
	sw	r19, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r5, r0, r18				# mr	r5, r18
	add	r2, r0, r17				# mr	r2, r17
	add	r1, r0, r16				# mr	r1, r16
	add	r28, r0, r9				# mr	r28, r9
	sw	r30, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 14(r3)
	lw	r1, 0(r1)
	lw	r2, 12(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r30, 0(r1)
	fmvfr	f2, r30
	lw	r5, 7(r3)
	lw	r30, 0(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r2)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r2)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r2)
	j	beq_cont.31818
beq_then.31817:
beq_cont.31818:
	addi	r2, r0, 1				# li	r2, 1
	lw	r1, 13(r3)
	lw	r5, 2(r1)
	addi	r6, r0, 0				# li	r6, 0
	lw	r5, 1(r5)
	ble	r6, r5, ble_then.31819
	j	ble_cont.31820
ble_then.31819:
	lw	r5, 3(r1)
	lw	r5, 1(r5)
	addi	r6, r0, 0				# li	r6, 0
	beq	r5, r6, beq_then.31821
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31822
beq_then.31821:
beq_cont.31822:
	addi	r2, r0, 2				# li	r2, 2
	lw	r1, 13(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.31820:
ble_cont.31816:
beq_cont.31812:
ble_cont.31802:
	j	beq_cont.31800
beq_then.31799:
	add	r30, r6, r1
	lw	r14, 0(r30)
	addi	r16, r0, 0				# li	r16, 0
	lw	r17, 2(r14)
	addi	r18, r0, 0				# li	r18, 0
	lw	r17, 0(r17)
	ble	r18, r17, ble_then.31823
	j	ble_cont.31824
ble_then.31823:
	lw	r17, 3(r14)
	lw	r17, 0(r17)
	addi	r18, r0, 0				# li	r18, 0
	sw	r14, 15(r3)
	beq	r17, r18, beq_then.31825
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r16				# mr	r2, r16
	add	r1, r0, r14				# mr	r1, r14
	add	r28, r0, r15				# mr	r28, r15
	sw	r30, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31826
beq_then.31825:
beq_cont.31826:
	lw	r1, 15(r3)
	lw	r2, 2(r1)
	addi	r5, r0, 0				# li	r5, 0
	lw	r2, 1(r2)
	ble	r5, r2, ble_then.31827
	j	ble_cont.31828
ble_then.31827:
	lw	r2, 3(r1)
	lw	r2, 1(r2)
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.31829
	lw	r2, 5(r1)
	lw	r5, 7(r1)
	lw	r6, 1(r1)
	lw	r7, 4(r1)
	lw	r2, 1(r2)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r8, 7(r3)
	fmvtr	r30, f1
	sw	r30, 0(r8)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r8)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r8)
	lw	r2, 6(r1)
	lw	r2, 0(r2)
	lw	r5, 1(r5)
	lw	r6, 1(r6)
	lw	r28, 6(r3)
	sw	r7, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 16(r3)
	lw	r1, 1(r1)
	lw	r2, 12(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r30, 0(r1)
	fmvfr	f2, r30
	lw	r5, 7(r3)
	lw	r30, 0(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r2)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r2)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r2)
	j	beq_cont.31830
beq_then.31829:
beq_cont.31830:
	addi	r2, r0, 2				# li	r2, 2
	lw	r1, 15(r3)
	lw	r5, 2(r1)
	addi	r6, r0, 0				# li	r6, 0
	lw	r5, 2(r5)
	ble	r6, r5, ble_then.31831
	j	ble_cont.31832
ble_then.31831:
	lw	r5, 3(r1)
	lw	r5, 2(r5)
	addi	r6, r0, 0				# li	r6, 0
	beq	r5, r6, beq_then.31833
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31834
beq_then.31833:
beq_cont.31834:
	addi	r2, r0, 3				# li	r2, 3
	lw	r1, 15(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.31832:
ble_cont.31828:
ble_cont.31824:
beq_cont.31800:
	lw	r1, 12(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 255				# li	r2, 255
	ble	r1, r2, ble_then.31835
	addi	r1, r0, 255				# li	r1, 255
	j	ble_cont.31836
ble_then.31835:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31837
	addi	r1, r0, 0				# li	r1, 0
	j	ble_cont.31838
ble_then.31837:
ble_cont.31838:
ble_cont.31836:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_print_int				#	bl	lib_print_int
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 32				# li	r1, 32
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 12(r3)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 255				# li	r2, 255
	ble	r1, r2, ble_then.31839
	addi	r1, r0, 255				# li	r1, 255
	j	ble_cont.31840
ble_then.31839:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31841
	addi	r1, r0, 0				# li	r1, 0
	j	ble_cont.31842
ble_then.31841:
ble_cont.31842:
ble_cont.31840:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_print_int				#	bl	lib_print_int
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 32				# li	r1, 32
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 12(r3)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 255				# li	r2, 255
	ble	r1, r2, ble_then.31843
	addi	r1, r0, 255				# li	r1, 255
	j	ble_cont.31844
ble_then.31843:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31845
	addi	r1, r0, 0				# li	r1, 0
	j	ble_cont.31846
ble_then.31845:
ble_cont.31846:
ble_cont.31844:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_print_int				#	bl	lib_print_int
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 10				# li	r1, 10
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 10(r3)
	lw	r5, 0(r2)
	ble	r5, r1, ble_then.31847
	lw	r6, 9(r3)
	add	r30, r6, r1
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r7, 12(r3)
	fmvtr	r30, f1
	sw	r30, 0(r7)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r7)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r7)
	lw	r5, 1(r2)
	lw	r8, 8(r3)
	addi	r9, r8, 1
	ble	r5, r9, ble_then.31848
	addi	r5, r0, 0				# li	r5, 0
	ble	r8, r5, ble_then.31850
	lw	r2, 0(r2)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.31852
	addi	r2, r0, 0				# li	r2, 0
	ble	r1, r2, ble_then.31854
	addi	r2, r0, 1				# li	r2, 1
	j	ble_cont.31855
ble_then.31854:
	addi	r2, r0, 0				# li	r2, 0
ble_cont.31855:
	j	ble_cont.31853
ble_then.31852:
	addi	r2, r0, 0				# li	r2, 0
ble_cont.31853:
	j	ble_cont.31851
ble_then.31850:
	addi	r2, r0, 0				# li	r2, 0
ble_cont.31851:
	j	ble_cont.31849
ble_then.31848:
	addi	r2, r0, 0				# li	r2, 0
ble_cont.31849:
	addi	r5, r0, 0				# li	r5, 0
	sw	r1, 17(r3)
	beq	r2, r5, beq_then.31856
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 2(r3)
	lw	r9, 1(r3)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r7, r0, r9				# mr	r7, r9
	add	r27, r0, r8				# mr	r27, r8
	add	r8, r0, r2				# mr	r8, r2
	add	r2, r0, r27				# mr	r2, r27
	sw	r30, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31857
beq_then.31856:
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	addi	r9, r0, 0				# li	r9, 0
	lw	r5, 0(r5)
	ble	r9, r5, ble_then.31858
	j	ble_cont.31859
ble_then.31858:
	lw	r5, 3(r2)
	lw	r5, 0(r5)
	addi	r9, r0, 0				# li	r9, 0
	sw	r2, 18(r3)
	beq	r5, r9, beq_then.31860
	lw	r5, 5(r2)
	lw	r9, 7(r2)
	lw	r10, 1(r2)
	lw	r11, 4(r2)
	lw	r5, 0(r5)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r12, 7(r3)
	fmvtr	r30, f1
	sw	r30, 0(r12)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r12)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r12)
	lw	r5, 6(r2)
	lw	r5, 0(r5)
	lw	r9, 0(r9)
	lw	r10, 0(r10)
	lw	r28, 6(r3)
	sw	r11, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r10				# mr	r5, r10
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 19(r3)
	lw	r1, 0(r1)
	lw	r2, 12(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r30, 0(r1)
	fmvfr	f2, r30
	lw	r5, 7(r3)
	lw	r30, 0(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r2)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r2)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r2)
	j	beq_cont.31861
beq_then.31860:
beq_cont.31861:
	addi	r2, r0, 1				# li	r2, 1
	lw	r1, 18(r3)
	lw	r5, 2(r1)
	addi	r6, r0, 0				# li	r6, 0
	lw	r5, 1(r5)
	ble	r6, r5, ble_then.31862
	j	ble_cont.31863
ble_then.31862:
	lw	r5, 3(r1)
	lw	r5, 1(r5)
	addi	r6, r0, 0				# li	r6, 0
	beq	r5, r6, beq_then.31864
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31865
beq_then.31864:
beq_cont.31865:
	addi	r2, r0, 2				# li	r2, 2
	lw	r1, 18(r3)
	lw	r28, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.31863:
ble_cont.31859:
beq_cont.31857:
	lw	r1, 12(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 255				# li	r2, 255
	ble	r1, r2, ble_then.31866
	addi	r1, r0, 255				# li	r1, 255
	j	ble_cont.31867
ble_then.31866:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31868
	addi	r1, r0, 0				# li	r1, 0
	j	ble_cont.31869
ble_then.31868:
ble_cont.31869:
ble_cont.31867:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_print_int				#	bl	lib_print_int
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 32				# li	r1, 32
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 12(r3)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 255				# li	r2, 255
	ble	r1, r2, ble_then.31870
	addi	r1, r0, 255				# li	r1, 255
	j	ble_cont.31871
ble_then.31870:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31872
	addi	r1, r0, 0				# li	r1, 0
	j	ble_cont.31873
ble_then.31872:
ble_cont.31873:
ble_cont.31871:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_print_int				#	bl	lib_print_int
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 32				# li	r1, 32
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 12(r3)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 255				# li	r2, 255
	ble	r1, r2, ble_then.31874
	addi	r1, r0, 255				# li	r1, 255
	j	ble_cont.31875
ble_then.31874:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31876
	addi	r1, r0, 0				# li	r1, 0
	j	ble_cont.31877
ble_then.31876:
ble_cont.31877:
ble_cont.31875:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_print_int				#	bl	lib_print_int
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 10				# li	r1, 10
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 17(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 2(r3)
	lw	r6, 9(r3)
	lw	r7, 1(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
ble_then.31847:
	jr	r31				#	blr
ble_then.31790:
	jr	r31				#	blr
scan_line.2880:
	lw	r8, 14(r28)
	lw	r9, 13(r28)
	lw	r10, 12(r28)
	lw	r11, 11(r28)
	lw	r12, 10(r28)
	lw	r13, 9(r28)
	lw	r14, 8(r28)
	lw	r15, 7(r28)
	lw	r16, 6(r28)
	lw	r17, 5(r28)
	lw	r18, 4(r28)
	lw	r19, 3(r28)
	lw	r20, 2(r28)
	lw	r21, 1(r28)
	lw	r22, 1(r17)
	ble	r22, r1, ble_then.31880
	lw	r22, 1(r17)
	addi	r23, r0, 1				# li	r23, 1
	sub	r22, r22, r23
	sw	r28, 0(r3)
	sw	r16, 1(r3)
	sw	r7, 2(r3)
	sw	r12, 3(r3)
	sw	r6, 4(r3)
	sw	r2, 5(r3)
	sw	r8, 6(r3)
	sw	r19, 7(r3)
	sw	r21, 8(r3)
	sw	r9, 9(r3)
	sw	r20, 10(r3)
	sw	r1, 11(r3)
	sw	r14, 12(r3)
	sw	r5, 13(r3)
	sw	r17, 14(r3)
	ble	r22, r1, ble_then.31881
	addi	r22, r1, 1
	lw	r30, 0(r13)
	fmvfr	f1, r30
	lw	r13, 1(r18)
	sub	r13, r22, r13
	sw	r15, 15(r3)
	sw	r10, 16(r3)
	sw	r11, 17(r3)
	fmvtr	r30, f1
	sw	r30, 18(r3)				#stfd	f1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r13				# mr	r1, r13
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 18(r3)				#lfd	f2, 18(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	lw	r1, 17(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r2, 16(r3)
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
	lw	r1, 14(r3)
	lw	r2, 0(r1)
	addi	r5, r0, 1				# li	r5, 1
	sub	r2, r2, r5
	lw	r5, 4(r3)
	lw	r6, 2(r3)
	lw	r28, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	j	ble_cont.31882
ble_then.31881:
ble_cont.31882:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 14(r3)
	lw	r5, 0(r2)
	ble	r5, r1, ble_then.31883
	lw	r6, 13(r3)
	lw	r5, 0(r6)
	lw	r5, 0(r5)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r7, 12(r3)
	fmvtr	r30, f1
	sw	r30, 0(r7)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r7)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r7)
	lw	r5, 1(r2)
	lw	r8, 11(r3)
	addi	r9, r8, 1
	ble	r5, r9, ble_then.31885
	addi	r5, r0, 0				# li	r5, 0
	ble	r8, r5, ble_then.31887
	lw	r5, 0(r2)
	addi	r9, r0, 1				# li	r9, 1
	ble	r5, r9, ble_then.31889
	addi	r5, r0, 0				# li	r5, 0
	j	ble_cont.31890
ble_then.31889:
	addi	r5, r0, 0				# li	r5, 0
ble_cont.31890:
	j	ble_cont.31888
ble_then.31887:
	addi	r5, r0, 0				# li	r5, 0
ble_cont.31888:
	j	ble_cont.31886
ble_then.31885:
	addi	r5, r0, 0				# li	r5, 0
ble_cont.31886:
	addi	r9, r0, 0				# li	r9, 0
	beq	r5, r9, beq_then.31891
	addi	r5, r0, 0				# li	r5, 0
	lw	r9, 5(r3)
	lw	r10, 4(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r7, r0, r10				# mr	r7, r10
	add	r2, r0, r8				# mr	r2, r8
	add	r8, r0, r5				# mr	r8, r5
	add	r5, r0, r9				# mr	r5, r9
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31892
beq_then.31891:
	lw	r1, 0(r6)
	lw	r5, 2(r1)
	addi	r9, r0, 0				# li	r9, 0
	lw	r5, 0(r5)
	ble	r9, r5, ble_then.31893
	j	ble_cont.31894
ble_then.31893:
	lw	r5, 3(r1)
	lw	r5, 0(r5)
	addi	r9, r0, 0				# li	r9, 0
	sw	r1, 20(r3)
	beq	r5, r9, beq_then.31895
	lw	r5, 5(r1)
	lw	r9, 7(r1)
	lw	r10, 1(r1)
	lw	r11, 4(r1)
	lw	r5, 0(r5)
	lw	r30, 0(r5)
	fmvfr	f1, r30
	lw	r12, 10(r3)
	fmvtr	r30, f1
	sw	r30, 0(r12)
	lw	r30, 1(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r12)
	lw	r30, 2(r5)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r12)
	lw	r5, 6(r1)
	lw	r5, 0(r5)
	lw	r9, 0(r9)
	lw	r10, 0(r10)
	lw	r28, 9(r3)
	sw	r11, 21(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r10				# mr	r5, r10
	sw	r30, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 21(r3)
	lw	r1, 0(r1)
	lw	r2, 12(r3)
	lw	r30, 0(r2)
	fmvfr	f1, r30
	lw	r30, 0(r1)
	fmvfr	f2, r30
	lw	r5, 10(r3)
	lw	r30, 0(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 0(r2)
	lw	r30, 1(r2)
	fmvfr	f1, r30
	lw	r30, 1(r1)
	fmvfr	f2, r30
	lw	r30, 1(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 1(r2)
	lw	r30, 2(r2)
	fmvfr	f1, r30
	lw	r30, 2(r1)
	fmvfr	f2, r30
	lw	r30, 2(r5)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 2(r2)
	j	beq_cont.31896
beq_then.31895:
beq_cont.31896:
	addi	r2, r0, 1				# li	r2, 1
	lw	r1, 20(r3)
	lw	r5, 2(r1)
	addi	r6, r0, 0				# li	r6, 0
	lw	r5, 1(r5)
	ble	r6, r5, ble_then.31897
	j	ble_cont.31898
ble_then.31897:
	lw	r5, 3(r1)
	lw	r5, 1(r5)
	addi	r6, r0, 0				# li	r6, 0
	beq	r5, r6, beq_then.31899
	lw	r28, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	j	beq_cont.31900
beq_then.31899:
beq_cont.31900:
	addi	r2, r0, 2				# li	r2, 2
	lw	r1, 20(r3)
	lw	r28, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.31898:
ble_cont.31894:
beq_cont.31892:
	lw	r1, 12(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 255				# li	r2, 255
	ble	r1, r2, ble_then.31901
	addi	r1, r0, 255				# li	r1, 255
	j	ble_cont.31902
ble_then.31901:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31903
	addi	r1, r0, 0				# li	r1, 0
	j	ble_cont.31904
ble_then.31903:
ble_cont.31904:
ble_cont.31902:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_print_int				#	bl	lib_print_int
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 32				# li	r1, 32
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 12(r3)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 255				# li	r2, 255
	ble	r1, r2, ble_then.31905
	addi	r1, r0, 255				# li	r1, 255
	j	ble_cont.31906
ble_then.31905:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31907
	addi	r1, r0, 0				# li	r1, 0
	j	ble_cont.31908
ble_then.31907:
ble_cont.31908:
ble_cont.31906:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_print_int				#	bl	lib_print_int
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 32				# li	r1, 32
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 12(r3)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 255				# li	r2, 255
	ble	r1, r2, ble_then.31909
	addi	r1, r0, 255				# li	r1, 255
	j	ble_cont.31910
ble_then.31909:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31911
	addi	r1, r0, 0				# li	r1, 0
	j	ble_cont.31912
ble_then.31911:
ble_cont.31912:
ble_cont.31910:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_print_int				#	bl	lib_print_int
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 10				# li	r1, 10
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 11(r3)
	lw	r5, 5(r3)
	lw	r6, 13(r3)
	lw	r7, 4(r3)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	j	ble_cont.31884
ble_then.31883:
ble_cont.31884:
	lw	r1, 11(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	addi	r1, r1, 2
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r1, ble_then.31913
	add	r5, r0, r1				# mr	r5, r1
	j	ble_cont.31914
ble_then.31913:
	addi	r5, r0, 5				# li	r5, 5
	sub	r5, r1, r5
ble_cont.31914:
	lw	r1, 14(r3)
	lw	r6, 1(r1)
	ble	r6, r2, ble_then.31915
	lw	r1, 1(r1)
	addi	r6, r0, 1				# li	r6, 1
	sub	r1, r1, r6
	sw	r5, 22(r3)
	sw	r2, 23(r3)
	ble	r1, r2, ble_then.31917
	addi	r1, r2, 1
	lw	r6, 5(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	j	ble_cont.31918
ble_then.31917:
ble_cont.31918:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 23(r3)
	lw	r5, 13(r3)
	lw	r6, 4(r3)
	lw	r7, 5(r3)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 23(r3)
	addi	r1, r1, 1
	lw	r2, 22(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r2, ble_then.31919
	add	r7, r0, r2				# mr	r7, r2
	j	ble_cont.31920
ble_then.31919:
	addi	r5, r0, 5				# li	r5, 5
	sub	r7, r2, r5
ble_cont.31920:
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	lw	r6, 13(r3)
	lw	r28, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	j	ble_cont.31916
ble_then.31915:
ble_cont.31916:
	jr	r31				#	blr
ble_then.31880:
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
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
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
	lw	r2, 2(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -4
	lw	r30, 3(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 5				# li	r1, 5
	addi	r5, r0, 0				# li	r5, 0
	addi	r30, r31, 0				#mflr	r30
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
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				#	bl	lib_create_array
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
	lw	r2, 5(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 5(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
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
	lw	r2, 6(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 6(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 6(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 6(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 1				# li	r1, 1
	addi	r5, r0, 0				# li	r5, 0
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
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
	lw	r2, 8(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 8(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 8(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 8(r3)
	sw	r1, 4(r2)
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 8
	sw	r2, 7(r1)
	lw	r2, 7(r3)
	sw	r2, 6(r1)
	lw	r2, 6(r3)
	sw	r2, 5(r1)
	lw	r2, 5(r3)
	sw	r2, 4(r1)
	lw	r2, 4(r3)
	sw	r2, 3(r1)
	lw	r2, 3(r3)
	sw	r2, 2(r1)
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	jr	r31				#	blr
init_line_elements.2890:
	lw	r5, 2(r28)
	lw	r6, 1(r28)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r2, ble_then.31923
	jr	r31				#	blr
ble_then.31923:
	addi	r7, r0, 3				# li	r7, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r28, 0(r3)
	sw	r6, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r7				# mr	r1, r7
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
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
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
	lw	r2, 6(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 6(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 6(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 6(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 5				# li	r1, 5
	addi	r5, r0, 0				# li	r5, 0
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 5				# li	r2, 5
	lw	r5, 4(r3)
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
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
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 9(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 9(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 9(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 9(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 10(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 10(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 10(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 10(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 1				# li	r1, 1
	addi	r5, r0, 0				# li	r5, 0
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
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
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 12(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 12(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 12(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 12(r3)
	sw	r1, 4(r2)
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 8
	sw	r2, 7(r1)
	lw	r2, 11(r3)
	sw	r2, 6(r1)
	lw	r2, 10(r3)
	sw	r2, 5(r1)
	lw	r2, 9(r3)
	sw	r2, 4(r1)
	lw	r2, 8(r3)
	sw	r2, 3(r1)
	lw	r2, 7(r3)
	sw	r2, 2(r1)
	lw	r2, 6(r3)
	sw	r2, 1(r1)
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31924
	add	r1, r0, r5				# mr	r1, r5
	jr	r31				#	blr
ble_then.31924:
	lw	r28, 1(r3)
	sw	r1, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 13(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31925
	add	r1, r0, r5				# mr	r1, r5
	jr	r31				#	blr
ble_then.31925:
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
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
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
	lw	r2, 16(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 16(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 16(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 16(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 5				# li	r1, 5
	addi	r5, r0, 0				# li	r5, 0
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 5				# li	r2, 5
	lw	r5, 4(r3)
	sw	r1, 17(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_create_array				#	bl	lib_create_array
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
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	lib_create_array				#	bl	lib_create_array
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
	lw	r2, 19(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 19(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 19(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 19(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 20(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 20(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 20(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 20(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 1				# li	r1, 1
	addi	r5, r0, 0				# li	r5, 0
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 21(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
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
	lw	r2, 22(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 22(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 22(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 22(r3)
	sw	r1, 4(r2)
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 8
	sw	r2, 7(r1)
	lw	r2, 21(r3)
	sw	r2, 6(r1)
	lw	r2, 20(r3)
	sw	r2, 5(r1)
	lw	r2, 19(r3)
	sw	r2, 4(r1)
	lw	r2, 18(r3)
	sw	r2, 3(r1)
	lw	r2, 17(r3)
	sw	r2, 2(r1)
	lw	r2, 16(r3)
	sw	r2, 1(r1)
	lw	r2, 15(r3)
	sw	r2, 0(r1)
	lw	r2, 14(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31926
	add	r1, r0, r5				# mr	r1, r5
	jr	r31				#	blr
ble_then.31926:
	lw	r28, 1(r3)
	sw	r1, 23(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 23(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r2, r2, r1
	lw	r28, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r27, 0(r28)
	jr	r27
calc_dirvec.2900:
	lw	r6, 1(r28)
	addi	r7, r0, 5				# li	r7, 5
	ble	r7, r1, ble_then.31927
	fmul	f1, f2, f2
	addi	r30, r0, 52429
	lui	r30, r30, 15820	# to load float		0.100000
	fmvfr	f2, r30
	fadd	f1, f1, f2
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r28, 2(r3)
	fmvtr	r30, f4
	sw	r30, 4(r3)				#stfd	f4, 4(r3)
	sw	r1, 6(r3)
	fmvtr	r30, f3
	sw	r30, 8(r3)				#stfd	f3, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fdiv	f2, f2, f1
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_atan				#	bl	lib_atan
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 12(r3)				#stfd	f1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_sin				#	bl	lib_sin
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
	jal	lib_cos				#	bl	lib_cos
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 14(r3)				#lfd	f2, 14(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r30, 10(r3)				#lfd	f2, 10(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	lw	r1, 6(r3)
	addi	r1, r1, 1
	fmul	f2, f1, f1
	addi	r30, r0, 52429
	lui	r30, r30, 15820	# to load float		0.100000
	fmvfr	f3, r30
	fadd	f2, f2, f3
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	sw	r1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fdiv	f2, f2, f1
	fmvtr	r30, f1
	sw	r30, 20(r3)				#stfd	f1, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_atan				#	bl	lib_atan
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 4(r3)				#lfd	f2, 4(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_sin				#	bl	lib_sin
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
	jal	lib_cos				#	bl	lib_cos
	addi	r3, r3, -27
	lw	r30, 26(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r30, 20(r3)				#lfd	f2, 20(r3)
	fmvfr	f2, r30
	fmul	f2, f1, f2
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	lw	r30, 8(r3)				#lfd	f3, 8(r3)
	fmvfr	f3, r30
	lw	r30, 4(r3)				#lfd	f4, 4(r3)
	fmvfr	f4, r30
	lw	r1, 18(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r28, 2(r3)
	lw	r27, 0(r28)
	jr	r27
ble_then.31927:
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r6, 26(r3)
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	fmvtr	r30, f2
	sw	r30, 30(r3)				#stfd	f2, 30(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 30(r3)				#lfd	f2, 30(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 32(r3)				#stfd	f1, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_fsqr				#	bl	lib_fsqr
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	fadd	f1, f1, f2
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 34(r3)
	addi	r3, r3, 35
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 28(r3)				#lfd	f2, 28(r3)
	fmvfr	f2, r30
	fdiv	f2, f2, f1
	lw	r30, 30(r3)				#lfd	f3, 30(r3)
	fmvfr	f3, r30
	fdiv	f3, f3, f1
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f4, r30
	fdiv	f1, f4, f1
	lw	r1, 1(r3)
	lw	r2, 26(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 0(r3)
	add	r30, r1, r2
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	fmvtr	r30, f2
	sw	r30, 0(r5)
	fmvtr	r30, f3
	sw	r30, 1(r5)
	fmvtr	r30, f1
	sw	r30, 2(r5)
	addi	r5, r2, 40
	add	r30, r1, r5
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	fmvtr	r30, f3
	sw	r30, 34(r3)				#stfd	f3, 34(r3)
	sw	r1, 36(r3)
	fmvtr	r30, f1
	sw	r30, 38(r3)				#stfd	f1, 38(r3)
	sw	r5, 40(r3)
	fmvtr	r30, f2
	sw	r30, 42(r3)				#stfd	f2, 42(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 44(r3)
	addi	r3, r3, 45
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 40(r3)
	lw	r30, 42(r3)				#lfd	f2, 42(r3)
	fmvfr	f2, r30
	fmvtr	r30, f2
	sw	r30, 0(r1)
	lw	r30, 38(r3)				#lfd	f3, 38(r3)
	fmvfr	f3, r30
	fmvtr	r30, f3
	sw	r30, 1(r1)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r1, 0(r3)
	addi	r2, r1, 80
	lw	r5, 36(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 0(r2)
	sw	r2, 44(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 45(r3)
	addi	r3, r3, 46
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -46
	lw	r30, 45(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 46(r3)				#stfd	f1, 46(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 44(r3)
	lw	r30, 38(r3)				#lfd	f2, 38(r3)
	fmvfr	f2, r30
	fmvtr	r30, f2
	sw	r30, 0(r1)
	lw	r30, 46(r3)				#lfd	f3, 46(r3)
	fmvfr	f3, r30
	fmvtr	r30, f3
	sw	r30, 1(r1)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r1, 0(r3)
	addi	r2, r1, 1
	lw	r5, 36(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 0(r2)
	lw	r30, 42(r3)				#lfd	f1, 42(r3)
	fmvfr	f1, r30
	sw	r2, 48(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 49(r3)
	addi	r3, r3, 50
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -50
	lw	r30, 49(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 34(r3)				#lfd	f2, 34(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 50(r3)				#stfd	f1, 50(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 52(r3)
	addi	r3, r3, 53
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -53
	lw	r30, 52(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 38(r3)				#lfd	f2, 38(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 52(r3)				#stfd	f1, 52(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 54(r3)
	addi	r3, r3, 55
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -55
	lw	r30, 54(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 48(r3)
	lw	r30, 50(r3)				#lfd	f2, 50(r3)
	fmvfr	f2, r30
	fmvtr	r30, f2
	sw	r30, 0(r1)
	lw	r30, 52(r3)				#lfd	f2, 52(r3)
	fmvfr	f2, r30
	fmvtr	r30, f2
	sw	r30, 1(r1)
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r1, 0(r3)
	addi	r2, r1, 41
	lw	r5, 36(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 0(r2)
	lw	r30, 42(r3)				#lfd	f1, 42(r3)
	fmvfr	f1, r30
	sw	r2, 54(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 55(r3)
	addi	r3, r3, 56
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -56
	lw	r30, 55(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 38(r3)				#lfd	f2, 38(r3)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 56(r3)				#stfd	f1, 56(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 58(r3)
	addi	r3, r3, 59
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -59
	lw	r30, 58(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 54(r3)
	lw	r30, 56(r3)				#lfd	f2, 56(r3)
	fmvfr	f2, r30
	fmvtr	r30, f2
	sw	r30, 0(r1)
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 34(r3)				#lfd	f1, 34(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r1, 0(r3)
	addi	r1, r1, 81
	lw	r2, 36(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 0(r1)
	lw	r30, 38(r3)				#lfd	f2, 38(r3)
	fmvfr	f2, r30
	sw	r1, 58(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 59(r3)
	addi	r3, r3, 60
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -60
	lw	r30, 59(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 58(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 42(r3)				#lfd	f1, 42(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 34(r3)				#lfd	f1, 34(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r1)
	jr	r31				#	blr
calc_dirvecs.2908:
	lw	r6, 1(r28)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.31938
	jr	r31				#	blr
ble_then.31938:
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
	ble	r5, r2, ble_then.31940
	j	ble_cont.31941
ble_then.31940:
	addi	r5, r0, 5				# li	r5, 5
	sub	r2, r2, r5
ble_cont.31941:
	addi	r5, r0, 0				# li	r5, 0
	ble	r5, r1, ble_then.31942
	jr	r31				#	blr
ble_then.31942:
	sw	r1, 7(r3)
	sw	r2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -10
	lw	r30, 9(r3)
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
	lw	r2, 8(r3)
	lw	r5, 4(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -10
	lw	r30, 9(r3)
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
	lw	r6, 8(r3)
	lw	r28, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	sw	r30, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 7(r3)
	sub	r1, r2, r1
	lw	r2, 8(r3)
	addi	r2, r2, 1
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r2, ble_then.31944
	j	ble_cont.31945
ble_then.31944:
	addi	r5, r0, 5				# li	r5, 5
	sub	r2, r2, r5
ble_cont.31945:
	lw	r30, 2(r3)				#lfd	f1, 2(r3)
	fmvfr	f1, r30
	lw	r5, 4(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
calc_dirvec_rows.2913:
	lw	r6, 2(r28)
	lw	r7, 1(r28)
	addi	r8, r0, 0				# li	r8, 0
	ble	r8, r1, ble_then.31946
	jr	r31				#	blr
ble_then.31946:
	sw	r28, 0(r3)
	sw	r1, 1(r3)
	sw	r6, 2(r3)
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	sw	r7, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -7
	lw	r30, 6(r3)
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
	sw	r1, 6(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -11
	lw	r30, 10(r3)
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
	lw	r30, 8(r3)				#lfd	f4, 8(r3)
	fmvfr	f4, r30
	lw	r2, 4(r3)
	lw	r5, 3(r3)
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -11
	lw	r30, 10(r3)
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
	lw	r2, 3(r3)
	addi	r5, r2, 2
	lw	r30, 8(r3)				#lfd	f4, 8(r3)
	fmvfr	f4, r30
	lw	r6, 4(r3)
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	sw	r30, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 3				# li	r1, 3
	lw	r2, 4(r3)
	addi	r5, r2, 1
	addi	r6, r0, 5				# li	r6, 5
	ble	r6, r5, ble_then.31949
	j	ble_cont.31950
ble_then.31949:
	addi	r6, r0, 5				# li	r6, 5
	sub	r5, r5, r6
ble_cont.31950:
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r6, 3(r3)
	lw	r28, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r30, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 1(r3)
	sub	r1, r2, r1
	lw	r2, 4(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r2, ble_then.31951
	j	ble_cont.31952
ble_then.31951:
	addi	r5, r0, 5				# li	r5, 5
	sub	r2, r2, r5
ble_cont.31952:
	lw	r5, 3(r3)
	addi	r5, r5, 4
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r1, ble_then.31953
	jr	r31				#	blr
ble_then.31953:
	sw	r1, 10(r3)
	sw	r5, 11(r3)
	sw	r2, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -14
	lw	r30, 13(r3)
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
	lw	r2, 12(r3)
	lw	r5, 11(r3)
	lw	r28, 2(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 10(r3)
	sub	r1, r2, r1
	lw	r2, 12(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r2, ble_then.31955
	j	ble_cont.31956
ble_then.31955:
	addi	r5, r0, 5				# li	r5, 5
	sub	r2, r2, r5
ble_cont.31956:
	lw	r5, 11(r3)
	addi	r5, r5, 4
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
create_dirvec_elements.2919:
	lw	r5, 1(r28)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.31957
	jr	r31				#	blr
ble_then.31957:
	addi	r6, r0, 3				# li	r6, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r28, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	lw	r5, 0(r1)
	sw	r2, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -6
	lw	r30, 5(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 4(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31959
	jr	r31				#	blr
ble_then.31959:
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
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	lw	r5, 0(r1)
	sw	r2, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 6(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 5(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31961
	jr	r31				#	blr
ble_then.31961:
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	lw	r5, 0(r1)
	sw	r2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 8(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 7(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31963
	jr	r31				#	blr
ble_then.31963:
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	lw	r5, 0(r1)
	sw	r2, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 10(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 9(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31965
	jr	r31				#	blr
ble_then.31965:
	addi	r2, r0, 3				# li	r2, 3
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
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	lw	r5, 0(r1)
	sw	r2, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 12(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 11(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31967
	jr	r31				#	blr
ble_then.31967:
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	lw	r5, 0(r1)
	sw	r2, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 14(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 13(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31969
	jr	r31				#	blr
ble_then.31969:
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	lw	r5, 0(r1)
	sw	r2, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 16(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 15(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31971
	jr	r31				#	blr
ble_then.31971:
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
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	lw	r1, 0(r1)
	sw	r2, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 18(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 17(r3)
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
	ble	r7, r1, ble_then.31973
	jr	r31				#	blr
ble_then.31973:
	addi	r7, r0, 120				# li	r7, 120
	addi	r8, r0, 3				# li	r8, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r28, 0(r3)
	sw	r6, 1(r3)
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	sw	r7, 4(r3)
	sw	r2, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r8				# mr	r1, r8
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 6(r3)
	sw	r1, 0(r2)
	lw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	add	r30, r5, r2
	lw	r1, 0(r30)
	addi	r6, r0, 3				# li	r6, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 7(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 8(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 7(r3)
	sw	r1, 118(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -10
	lw	r30, 9(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 9(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 7(r3)
	sw	r1, 117(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 10(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 7(r3)
	sw	r1, 116(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 11(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 11(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 7(r3)
	sw	r1, 115(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -13
	lw	r30, 12(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 12(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 7(r3)
	sw	r1, 114(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -14
	lw	r30, 13(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 13(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 7(r3)
	sw	r1, 113(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 14(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 7(r3)
	sw	r1, 112(r2)
	addi	r1, r0, 111				# li	r1, 111
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	sw	r30, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 2(r3)
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31975
	jr	r31				#	blr
ble_then.31975:
	addi	r2, r0, 120				# li	r2, 120
	addi	r5, r0, 3				# li	r5, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 15(r3)
	sw	r2, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -18
	lw	r30, 17(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 17(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 17(r3)
	sw	r1, 0(r2)
	lw	r1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 15(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	add	r30, r5, r2
	lw	r1, 0(r30)
	addi	r6, r0, 3				# li	r6, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 19(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 18(r3)
	sw	r1, 118(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 21
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 20(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 20(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 18(r3)
	sw	r1, 117(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -22
	lw	r30, 21(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 21(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 21(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 18(r3)
	sw	r1, 116(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -23
	lw	r30, 22(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 22(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 22(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 18(r3)
	sw	r1, 115(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -24
	lw	r30, 23(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 23(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 23(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 18(r3)
	sw	r1, 114(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 25(r3)
	addi	r3, r3, 26
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -26
	lw	r30, 25(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 24(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 18(r3)
	sw	r1, 113(r2)
	addi	r1, r0, 112				# li	r1, 112
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	sw	r30, 25(r3)
	addi	r3, r3, 26
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -26
	lw	r30, 25(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 15(r3)
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31977
	jr	r31				#	blr
ble_then.31977:
	addi	r2, r0, 120				# li	r2, 120
	addi	r5, r0, 3				# li	r5, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 25(r3)
	sw	r2, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 27(r3)
	addi	r3, r3, 28
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -28
	lw	r30, 27(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 27(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 27(r3)
	sw	r1, 0(r2)
	lw	r1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 25(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	add	r30, r5, r2
	lw	r1, 0(r30)
	addi	r6, r0, 3				# li	r6, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 29(r3)
	addi	r3, r3, 30
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -30
	lw	r30, 29(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 29(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 29(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 28(r3)
	sw	r1, 118(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 30(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r30, 31(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 30(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 28(r3)
	sw	r1, 117(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -32
	lw	r30, 31(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 31(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 31(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 28(r3)
	sw	r1, 116(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 32(r3)
	addi	r3, r3, 33
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -33
	lw	r30, 32(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 33(r3)
	addi	r3, r3, 34
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 32(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 28(r3)
	sw	r1, 115(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 33(r3)
	addi	r3, r3, 34
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -34
	lw	r30, 33(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 33(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
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
	lw	r2, 28(r3)
	sw	r1, 114(r2)
	addi	r1, r0, 113				# li	r1, 113
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	sw	r30, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -35
	lw	r30, 34(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 25(r3)
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31979
	jr	r31				#	blr
ble_then.31979:
	addi	r2, r0, 120				# li	r2, 120
	addi	r5, r0, 3				# li	r5, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 34(r3)
	sw	r2, 35(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 36(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 37(r3)
	addi	r3, r3, 38
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -38
	lw	r30, 37(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 36(r3)
	sw	r1, 0(r2)
	lw	r1, 35(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 37(r3)
	addi	r3, r3, 38
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -38
	lw	r30, 37(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 34(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	add	r30, r5, r2
	lw	r1, 0(r30)
	addi	r5, r0, 3				# li	r5, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 37(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 38(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 39(r3)
	addi	r3, r3, 40
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -40
	lw	r30, 39(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 38(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 37(r3)
	sw	r1, 118(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 39(r3)
	addi	r3, r3, 40
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -40
	lw	r30, 39(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 39(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 39(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 37(r3)
	sw	r1, 117(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 40(r3)
	addi	r3, r3, 41
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -41
	lw	r30, 40(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r5, 0(r1)
	sw	r2, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 41(r3)
	addi	r3, r3, 42
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 40(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 37(r3)
	sw	r1, 116(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 41(r3)
	addi	r3, r3, 42
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -42
	lw	r30, 41(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 5(r3)
	lw	r1, 0(r1)
	sw	r2, 41(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 41(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 37(r3)
	sw	r1, 115(r2)
	addi	r1, r0, 114				# li	r1, 114
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	sw	r30, 42(r3)
	addi	r3, r3, 43
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 34(r3)
	sub	r1, r2, r1
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
init_dirvec_constants.2924:
	lw	r5, 3(r28)
	lw	r6, 2(r28)
	lw	r7, 1(r28)
	addi	r8, r0, 0				# li	r8, 0
	ble	r8, r2, ble_then.31981
	jr	r31				#	blr
ble_then.31981:
	add	r30, r1, r2
	lw	r8, 0(r30)
	lw	r9, 0(r6)
	addi	r10, r0, 1				# li	r10, 1
	sub	r9, r9, r10
	sw	r28, 0(r3)
	sw	r7, 1(r3)
	sw	r5, 2(r3)
	sw	r6, 3(r3)
	sw	r1, 4(r3)
	sw	r2, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	add	r28, r0, r7				# mr	r28, r7
	sw	r30, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 5(r3)
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31983
	jr	r31				#	blr
ble_then.31983:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	lw	r7, 0(r6)
	addi	r8, r0, 1				# li	r8, 1
	sub	r7, r7, r8
	addi	r8, r0, 0				# li	r8, 0
	sw	r1, 6(r3)
	ble	r8, r7, ble_then.31985
	j	ble_cont.31986
ble_then.31985:
	lw	r8, 2(r3)
	add	r30, r8, r7
	lw	r9, 0(r30)
	lw	r10, 1(r5)
	lw	r11, 0(r5)
	lw	r12, 1(r9)
	addi	r13, r0, 1				# li	r13, 1
	sw	r5, 7(r3)
	beq	r12, r13, beq_then.31987
	addi	r13, r0, 2				# li	r13, 2
	beq	r12, r13, beq_then.31989
	sw	r7, 8(r3)
	sw	r10, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	setup_second_table.2703				#	bl	setup_second_table.2703
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.31990
beq_then.31989:
	sw	r7, 8(r3)
	sw	r10, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	setup_surface_table.2700				#	bl	setup_surface_table.2700
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.31990:
	j	beq_cont.31988
beq_then.31987:
	sw	r7, 8(r3)
	sw	r10, 9(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal	setup_rect_table.2697				#	bl	setup_rect_table.2697
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.31988:
	addi	r1, r0, 1				# li	r1, 1
	sub	r2, r2, r1
	lw	r1, 7(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.31986:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 6(r3)
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31991
	jr	r31				#	blr
ble_then.31991:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	lw	r7, 0(r6)
	addi	r8, r0, 1				# li	r8, 1
	sub	r7, r7, r8
	lw	r28, 1(r3)
	sw	r1, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 10(r3)
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.31993
	jr	r31				#	blr
ble_then.31993:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	lw	r6, 0(r6)
	addi	r7, r0, 1				# li	r7, 1
	sub	r6, r6, r7
	addi	r7, r0, 0				# li	r7, 0
	sw	r1, 11(r3)
	ble	r7, r6, ble_then.31995
	j	ble_cont.31996
ble_then.31995:
	lw	r7, 2(r3)
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	addi	r11, r0, 1				# li	r11, 1
	sw	r5, 12(r3)
	beq	r10, r11, beq_then.31997
	addi	r11, r0, 2				# li	r11, 2
	beq	r10, r11, beq_then.31999
	sw	r6, 13(r3)
	sw	r8, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	setup_second_table.2703				#	bl	setup_second_table.2703
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.32000
beq_then.31999:
	sw	r6, 13(r3)
	sw	r8, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	setup_surface_table.2700				#	bl	setup_surface_table.2700
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.32000:
	j	beq_cont.31998
beq_then.31997:
	sw	r6, 13(r3)
	sw	r8, 14(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r30, 15(r3)
	addi	r3, r3, 16
	jal	setup_rect_table.2697				#	bl	setup_rect_table.2697
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.31998:
	addi	r1, r0, 1				# li	r1, 1
	sub	r2, r2, r1
	lw	r1, 12(r3)
	lw	r28, 1(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -16
	lw	r30, 15(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.31996:
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 11(r3)
	sub	r2, r2, r1
	lw	r1, 4(r3)
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
init_vecset_constants.2927:
	lw	r2, 5(r28)
	lw	r5, 4(r28)
	lw	r6, 3(r28)
	lw	r7, 2(r28)
	lw	r8, 1(r28)
	addi	r9, r0, 0				# li	r9, 0
	ble	r9, r1, ble_then.32001
	jr	r31				#	blr
ble_then.32001:
	add	r30, r8, r1
	lw	r9, 0(r30)
	lw	r10, 119(r9)
	lw	r11, 0(r5)
	addi	r12, r0, 1				# li	r12, 1
	sub	r11, r11, r12
	addi	r12, r0, 0				# li	r12, 0
	sw	r28, 0(r3)
	sw	r8, 1(r3)
	sw	r1, 2(r3)
	sw	r7, 3(r3)
	sw	r2, 4(r3)
	sw	r6, 5(r3)
	sw	r5, 6(r3)
	sw	r9, 7(r3)
	ble	r12, r11, ble_then.32003
	j	ble_cont.32004
ble_then.32003:
	add	r30, r2, r11
	lw	r12, 0(r30)
	lw	r13, 1(r10)
	lw	r14, 0(r10)
	lw	r15, 1(r12)
	addi	r16, r0, 1				# li	r16, 1
	sw	r10, 8(r3)
	beq	r15, r16, beq_then.32005
	addi	r16, r0, 2				# li	r16, 2
	beq	r15, r16, beq_then.32007
	sw	r11, 9(r3)
	sw	r13, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r14				# mr	r1, r14
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	setup_second_table.2703				#	bl	setup_second_table.2703
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.32008
beq_then.32007:
	sw	r11, 9(r3)
	sw	r13, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r14				# mr	r1, r14
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	setup_surface_table.2700				#	bl	setup_surface_table.2700
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.32008:
	j	beq_cont.32006
beq_then.32005:
	sw	r11, 9(r3)
	sw	r13, 10(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r14				# mr	r1, r14
	sw	r30, 11(r3)
	addi	r3, r3, 12
	jal	setup_rect_table.2697				#	bl	setup_rect_table.2697
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.32006:
	addi	r1, r0, 1				# li	r1, 1
	sub	r2, r2, r1
	lw	r1, 8(r3)
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.32004:
	lw	r1, 7(r3)
	lw	r2, 118(r1)
	lw	r5, 6(r3)
	lw	r6, 0(r5)
	addi	r7, r0, 1				# li	r7, 1
	sub	r6, r6, r7
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r6				# mr	r2, r6
	sw	r30, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -12
	lw	r30, 11(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 7(r3)
	lw	r2, 117(r1)
	lw	r5, 6(r3)
	lw	r6, 0(r5)
	addi	r7, r0, 1				# li	r7, 1
	sub	r6, r6, r7
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r6, ble_then.32009
	j	ble_cont.32010
ble_then.32009:
	lw	r7, 4(r3)
	add	r30, r7, r6
	lw	r8, 0(r30)
	lw	r9, 1(r2)
	lw	r10, 0(r2)
	lw	r11, 1(r8)
	addi	r12, r0, 1				# li	r12, 1
	sw	r2, 11(r3)
	beq	r11, r12, beq_then.32011
	addi	r12, r0, 2				# li	r12, 2
	beq	r11, r12, beq_then.32013
	sw	r6, 12(r3)
	sw	r9, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	setup_second_table.2703				#	bl	setup_second_table.2703
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.32014
beq_then.32013:
	sw	r6, 12(r3)
	sw	r9, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	setup_surface_table.2700				#	bl	setup_surface_table.2700
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.32014:
	j	beq_cont.32012
beq_then.32011:
	sw	r6, 12(r3)
	sw	r9, 13(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 14(r3)
	addi	r3, r3, 15
	jal	setup_rect_table.2697				#	bl	setup_rect_table.2697
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.32012:
	addi	r1, r0, 1				# li	r1, 1
	sub	r2, r2, r1
	lw	r1, 11(r3)
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.32010:
	addi	r2, r0, 116				# li	r2, 116
	lw	r1, 7(r3)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -15
	lw	r30, 14(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 2(r3)
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.32015
	jr	r31				#	blr
ble_then.32015:
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 119(r5)
	lw	r7, 6(r3)
	lw	r8, 0(r7)
	addi	r9, r0, 1				# li	r9, 1
	sub	r8, r8, r9
	lw	r28, 5(r3)
	sw	r1, 14(r3)
	sw	r5, 15(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -17
	lw	r30, 16(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 15(r3)
	lw	r2, 118(r1)
	lw	r5, 6(r3)
	lw	r6, 0(r5)
	addi	r7, r0, 1				# li	r7, 1
	sub	r6, r6, r7
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r6, ble_then.32017
	j	ble_cont.32018
ble_then.32017:
	lw	r7, 4(r3)
	add	r30, r7, r6
	lw	r8, 0(r30)
	lw	r9, 1(r2)
	lw	r10, 0(r2)
	lw	r11, 1(r8)
	addi	r12, r0, 1				# li	r12, 1
	sw	r2, 16(r3)
	beq	r11, r12, beq_then.32019
	addi	r12, r0, 2				# li	r12, 2
	beq	r11, r12, beq_then.32021
	sw	r6, 17(r3)
	sw	r9, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	setup_second_table.2703				#	bl	setup_second_table.2703
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.32022
beq_then.32021:
	sw	r6, 17(r3)
	sw	r9, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	setup_surface_table.2700				#	bl	setup_surface_table.2700
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.32022:
	j	beq_cont.32020
beq_then.32019:
	sw	r6, 17(r3)
	sw	r9, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	setup_rect_table.2697				#	bl	setup_rect_table.2697
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 17(r3)
	lw	r5, 18(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.32020:
	addi	r1, r0, 1				# li	r1, 1
	sub	r2, r2, r1
	lw	r1, 16(r3)
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.32018:
	addi	r2, r0, 117				# li	r2, 117
	lw	r1, 15(r3)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 14(r3)
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.32023
	jr	r31				#	blr
ble_then.32023:
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 119(r5)
	lw	r7, 6(r3)
	lw	r7, 0(r7)
	addi	r8, r0, 1				# li	r8, 1
	sub	r7, r7, r8
	addi	r8, r0, 0				# li	r8, 0
	sw	r1, 19(r3)
	sw	r5, 20(r3)
	ble	r8, r7, ble_then.32025
	j	ble_cont.32026
ble_then.32025:
	lw	r8, 4(r3)
	add	r30, r8, r7
	lw	r8, 0(r30)
	lw	r9, 1(r6)
	lw	r10, 0(r6)
	lw	r11, 1(r8)
	addi	r12, r0, 1				# li	r12, 1
	sw	r6, 21(r3)
	beq	r11, r12, beq_then.32027
	addi	r12, r0, 2				# li	r12, 2
	beq	r11, r12, beq_then.32029
	sw	r7, 22(r3)
	sw	r9, 23(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	setup_second_table.2703				#	bl	setup_second_table.2703
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 22(r3)
	lw	r5, 23(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.32030
beq_then.32029:
	sw	r7, 22(r3)
	sw	r9, 23(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	setup_surface_table.2700				#	bl	setup_surface_table.2700
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 22(r3)
	lw	r5, 23(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.32030:
	j	beq_cont.32028
beq_then.32027:
	sw	r7, 22(r3)
	sw	r9, 23(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r10				# mr	r1, r10
	sw	r30, 24(r3)
	addi	r3, r3, 25
	jal	setup_rect_table.2697				#	bl	setup_rect_table.2697
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 22(r3)
	lw	r5, 23(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.32028:
	addi	r1, r0, 1				# li	r1, 1
	sub	r2, r2, r1
	lw	r1, 21(r3)
	lw	r28, 5(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.32026:
	addi	r2, r0, 118				# li	r2, 118
	lw	r1, 20(r3)
	lw	r28, 3(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -25
	lw	r30, 24(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 19(r3)
	sub	r1, r2, r1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.32031
	jr	r31				#	blr
ble_then.32031:
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	addi	r5, r0, 119				# li	r5, 119
	lw	r28, 3(r3)
	sw	r1, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 25(r3)
	addi	r3, r3, 26
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -26
	lw	r30, 25(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 24(r3)
	sub	r1, r2, r1
	lw	r28, 0(r3)
	lw	r27, 0(r28)
	jr	r27
setup_reflections.2944:
	lw	r2, 6(r28)
	lw	r5, 5(r28)
	lw	r6, 4(r28)
	lw	r7, 3(r28)
	lw	r8, 2(r28)
	lw	r9, 1(r28)
	addi	r10, r0, 0				# li	r10, 0
	ble	r10, r1, ble_then.32033
	jr	r31				#	blr
ble_then.32033:
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r10, 2(r5)
	addi	r11, r0, 2				# li	r11, 2
	beq	r10, r11, beq_then.32035
	jr	r31				#	blr
beq_then.32035:
	lw	r10, 7(r5)
	lw	r30, 0(r10)
	fmvfr	f1, r30
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f2, r30
	sw	r2, 0(r3)
	sw	r9, 1(r3)
	sw	r7, 2(r3)
	sw	r8, 3(r3)
	sw	r6, 4(r3)
	sw	r1, 5(r3)
	sw	r5, 6(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 7(r3)
	addi	r3, r3, 8
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -8
	lw	r30, 7(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, beq_then.32037
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	addi	r5, r0, 1				# li	r5, 1
	beq	r2, r5, beq_then.32038
	addi	r5, r0, 2				# li	r5, 2
	beq	r2, r5, beq_then.32039
	jr	r31				#	blr
beq_then.32039:
	lw	r2, 5(r3)
	slli	r2, r2, 2
	addi	r2, r2, 1
	lw	r5, 4(r3)
	lw	r6, 0(r5)
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r7, 7(r1)
	lw	r30, 0(r7)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r7, 4(r1)
	lw	r8, 3(r3)
	lw	r30, 0(r8)
	fmvfr	f2, r30
	lw	r30, 0(r7)
	fmvfr	f3, r30
	fmul	f2, f2, f3
	lw	r30, 1(r8)
	fmvfr	f3, r30
	lw	r30, 1(r7)
	fmvfr	f4, r30
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	lw	r30, 2(r8)
	fmvfr	f3, r30
	lw	r30, 2(r7)
	fmvfr	f4, r30
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f3, r30
	lw	r7, 4(r1)
	lw	r30, 0(r7)
	fmvfr	f4, r30
	fmul	f3, f3, f4
	fmul	f3, f3, f2
	lw	r30, 0(r8)
	fmvfr	f4, r30
	fsub	f3, f3, f4
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f4, r30
	lw	r7, 4(r1)
	lw	r30, 1(r7)
	fmvfr	f5, r30
	fmul	f4, f4, f5
	fmul	f4, f4, f2
	lw	r30, 1(r8)
	fmvfr	f5, r30
	fsub	f4, f4, f5
	addi	r30, r0, 0
	lui	r30, r30, 16384	# to load float		2.000000
	fmvfr	f5, r30
	lw	r1, 4(r1)
	lw	r30, 2(r1)
	fmvfr	f6, r30
	fmul	f5, f5, f6
	fmul	f2, f5, f2
	lw	r30, 2(r8)
	fmvfr	f5, r30
	fsub	f2, f2, f5
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f5, r30
	sw	r6, 7(r3)
	sw	r2, 8(r3)
	fmvtr	r30, f1
	sw	r30, 10(r3)				#stfd	f1, 10(r3)
	fmvtr	r30, f2
	sw	r30, 12(r3)				#stfd	f2, 12(r3)
	fmvtr	r30, f4
	sw	r30, 14(r3)				#stfd	f4, 14(r3)
	fmvtr	r30, f3
	sw	r30, 16(r3)				#stfd	f3, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f5				# fmr	f1, f5
	sw	r30, 18(r3)
	addi	r3, r3, 19
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -19
	lw	r30, 18(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r5, 0(r1)
	sw	r2, 18(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 19(r3)
	addi	r3, r3, 20
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -20
	lw	r30, 19(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 18(r3)
	sw	r1, 0(r2)
	lw	r30, 16(r3)				#lfd	f1, 16(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 14(r3)				#lfd	f1, 14(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 12(r3)				#lfd	f1, 12(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r1, 2(r3)
	lw	r1, 0(r1)
	addi	r5, r0, 1				# li	r5, 1
	sub	r1, r1, r5
	lw	r28, 1(r3)
	sw	r2, 19(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	sw	r30, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -21
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 3
	lw	r30, 10(r3)				#lfd	f1, 10(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r2, 19(r3)
	sw	r2, 1(r1)
	lw	r2, 8(r3)
	sw	r2, 0(r1)
	lw	r2, 7(r3)
	lw	r5, 0(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	r2, 4(r3)
	sw	r1, 0(r2)
	jr	r31				#	blr
beq_then.32038:
	lw	r2, 5(r3)
	slli	r2, r2, 2
	lw	r5, 4(r3)
	lw	r6, 0(r5)
	addi	r30, r0, 0
	lui	r30, r30, 16256	# to load float		1.000000
	fmvfr	f1, r30
	lw	r1, 7(r1)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	fsub	f1, f1, f2
	lw	r1, 3(r3)
	lw	r30, 0(r1)
	fmvfr	f2, r30
	sw	r6, 20(r3)
	fmvtr	r30, f1
	sw	r30, 22(r3)				#stfd	f1, 22(r3)
	sw	r2, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 25(r3)
	addi	r3, r3, 26
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -26
	lw	r30, 25(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	lw	r30, 1(r1)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 26(r3)				#stfd	f1, 26(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 28(r3)
	addi	r3, r3, 29
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -29
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 3(r3)
	lw	r30, 2(r1)
	fmvfr	f2, r30
	fmvtr	r30, f1
	sw	r30, 28(r3)				#stfd	f1, 28(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r30, 30(r3)
	addi	r3, r3, 31
	jal	lib_fneg				#	bl	lib_fneg
	addi	r3, r3, -31
	lw	r30, 30(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 24(r3)
	addi	r2, r1, 1
	lw	r5, 3(r3)
	lw	r30, 0(r5)
	fmvfr	f2, r30
	addi	r6, r0, 3				# li	r6, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f3, r30
	sw	r2, 30(r3)
	fmvtr	r30, f1
	sw	r30, 32(r3)				#stfd	f1, 32(r3)
	fmvtr	r30, f2
	sw	r30, 34(r3)				#stfd	f2, 34(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r5, 0(r1)
	sw	r2, 36(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 37(r3)
	addi	r3, r3, 38
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -38
	lw	r30, 37(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 36(r3)
	sw	r1, 0(r2)
	lw	r30, 34(r3)				#lfd	f1, 34(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 28(r3)				#lfd	f1, 28(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fmvtr	r30, f2
	sw	r30, 2(r1)
	lw	r1, 2(r3)
	lw	r5, 0(r1)
	addi	r6, r0, 1				# li	r6, 1
	sub	r5, r5, r6
	lw	r28, 1(r3)
	sw	r2, 37(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 38(r3)
	addi	r3, r3, 39
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -39
	lw	r30, 38(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 3
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r2, 37(r3)
	sw	r2, 1(r1)
	lw	r2, 30(r3)
	sw	r2, 0(r1)
	lw	r2, 20(r3)
	lw	r5, 0(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	r6, 24(r3)
	addi	r7, r6, 2
	lw	r8, 3(r3)
	lw	r30, 1(r8)
	fmvfr	f2, r30
	addi	r9, r0, 3				# li	r9, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f3, r30
	sw	r1, 38(r3)
	sw	r7, 39(r3)
	fmvtr	r30, f2
	sw	r30, 40(r3)				#stfd	f2, 40(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r9				# mr	r1, r9
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 42(r3)
	addi	r3, r3, 43
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -43
	lw	r30, 42(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r5, 0(r1)
	sw	r2, 42(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 43(r3)
	addi	r3, r3, 44
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -44
	lw	r30, 43(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 42(r3)
	sw	r1, 0(r2)
	lw	r30, 26(r3)				#lfd	f1, 26(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 40(r3)				#lfd	f2, 40(r3)
	fmvfr	f2, r30
	fmvtr	r30, f2
	sw	r30, 1(r1)
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fmvtr	r30, f2
	sw	r30, 2(r1)
	lw	r1, 2(r3)
	lw	r5, 0(r1)
	addi	r6, r0, 1				# li	r6, 1
	sub	r5, r5, r6
	lw	r28, 1(r3)
	sw	r2, 43(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 44(r3)
	addi	r3, r3, 45
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -45
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 3
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r2, 43(r3)
	sw	r2, 1(r1)
	lw	r2, 39(r3)
	sw	r2, 0(r1)
	lw	r2, 38(r3)
	lw	r5, 0(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 20(r3)
	addi	r2, r1, 2
	lw	r6, 24(r3)
	addi	r6, r6, 3
	lw	r7, 3(r3)
	lw	r30, 2(r7)
	fmvfr	f2, r30
	addi	r7, r0, 3				# li	r7, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f3, r30
	sw	r2, 44(r3)
	sw	r6, 45(r3)
	fmvtr	r30, f2
	sw	r30, 46(r3)				#stfd	f2, 46(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r7				# mr	r1, r7
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r30, 48(r3)
	addi	r3, r3, 49
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -49
	lw	r30, 48(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r5, 0(r1)
	sw	r2, 48(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 49(r3)
	addi	r3, r3, 50
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -50
	lw	r30, 49(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 48(r3)
	sw	r1, 0(r2)
	lw	r30, 26(r3)				#lfd	f1, 26(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r30, 28(r3)				#lfd	f1, 28(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r1)
	lw	r30, 46(r3)				#lfd	f1, 46(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r1, 2(r3)
	lw	r1, 0(r1)
	addi	r5, r0, 1				# li	r5, 1
	sub	r1, r1, r5
	lw	r28, 1(r3)
	sw	r2, 49(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	sw	r30, 50(r3)
	addi	r3, r3, 51
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -51
	lw	r30, 50(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 3
	lw	r30, 22(r3)				#lfd	f1, 22(r3)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r1)
	lw	r2, 49(r3)
	sw	r2, 1(r1)
	lw	r2, 45(r3)
	sw	r2, 0(r1)
	lw	r2, 44(r3)
	lw	r5, 0(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 20(r3)
	addi	r1, r1, 3
	lw	r2, 4(r3)
	sw	r1, 0(r2)
	jr	r31				#	blr
beq_then.32037:
	jr	r31				#	blr
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
	lw	r5, 33(r3)
	sw	r5, 0(r2)
	addi	r6, r0, 0				# li	r6, 0
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 34(r3)
	sw	r2, 35(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 36(r3)
	addi	r3, r3, 37
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -37
	lw	r30, 36(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	sw	r2, 36(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 37(r3)
	addi	r3, r3, 38
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -38
	lw	r30, 37(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 36(r3)
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
	sw	r30, 37(r3)
	addi	r3, r3, 38
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -38
	lw	r30, 37(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	addi	r5, r0, 0				# li	r5, 0
	sw	r1, 37(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 38(r3)
	addi	r3, r3, 39
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -39
	lw	r30, 38(r3)
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
	addi	r4, r4, 2
	addi	r10, r0, read_nth_object.2599
	sw	r10, 0(r9)
	lw	r10, 3(r3)
	sw	r10, 1(r9)
	add	r11, r0, r4				# mr	r11, r4
	addi	r4, r4, 3
	addi	r12, r0, read_object.2601
	sw	r12, 0(r11)
	sw	r9, 2(r11)
	lw	r12, 2(r3)
	sw	r12, 1(r11)
	add	r13, r0, r4				# mr	r13, r4
	addi	r4, r4, 2
	addi	r14, r0, read_and_network.2609
	sw	r14, 0(r13)
	lw	r14, 9(r3)
	sw	r14, 1(r13)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 10
	addi	r16, r0, read_parameter.2611
	sw	r16, 0(r15)
	sw	r2, 9(r15)
	sw	r11, 8(r15)
	sw	r9, 7(r15)
	sw	r13, 6(r15)
	lw	r2, 11(r3)
	sw	r2, 5(r15)
	sw	r12, 4(r15)
	lw	r9, 6(r3)
	sw	r9, 3(r15)
	lw	r11, 7(r3)
	sw	r11, 2(r15)
	sw	r14, 1(r15)
	add	r13, r0, r4				# mr	r13, r4
	addi	r4, r4, 2
	addi	r16, r0, solver_rect.2622
	sw	r16, 0(r13)
	lw	r16, 12(r3)
	sw	r16, 1(r13)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 2
	addi	r18, r0, solver_second.2647
	sw	r18, 0(r17)
	sw	r16, 1(r17)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 3
	addi	r19, r0, solver.2653
	sw	r19, 0(r18)
	sw	r16, 2(r18)
	sw	r10, 1(r18)
	add	r19, r0, r4				# mr	r19, r4
	addi	r4, r4, 2
	addi	r20, r0, solver_rect_fast.2657
	sw	r20, 0(r19)
	sw	r16, 1(r19)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 2
	addi	r21, r0, solver_second_fast.2670
	sw	r21, 0(r20)
	sw	r16, 1(r20)
	add	r21, r0, r4				# mr	r21, r4
	addi	r4, r4, 4
	addi	r22, r0, solver_fast.2676
	sw	r22, 0(r21)
	sw	r19, 3(r21)
	sw	r16, 2(r21)
	sw	r10, 1(r21)
	add	r22, r0, r4				# mr	r22, r4
	addi	r4, r4, 4
	addi	r23, r0, solver_fast2.2694
	sw	r23, 0(r22)
	sw	r19, 3(r22)
	sw	r16, 2(r22)
	sw	r10, 1(r22)
	add	r23, r0, r4				# mr	r23, r4
	addi	r4, r4, 2
	addi	r24, r0, iter_setup_dirvec_constants.2706
	sw	r24, 0(r23)
	sw	r10, 1(r23)
	add	r24, r0, r4				# mr	r24, r4
	addi	r4, r4, 2
	addi	r25, r0, setup_startp_constants.2711
	sw	r25, 0(r24)
	sw	r10, 1(r24)
	add	r25, r0, r4				# mr	r25, r4
	addi	r4, r4, 2
	addi	r26, r0, check_all_inside.2736
	sw	r26, 0(r25)
	sw	r10, 1(r25)
	add	r26, r0, r4				# mr	r26, r4
	addi	r4, r4, 12
	addi	r27, r0, shadow_check_and_group.2742
	sw	r27, 0(r26)
	lw	r27, 33(r3)
	sw	r27, 11(r26)
	sw	r20, 10(r26)
	sw	r19, 9(r26)
	sw	r21, 8(r26)
	sw	r16, 7(r26)
	sw	r10, 6(r26)
	lw	r28, 35(r3)
	sw	r28, 5(r26)
	sw	r9, 4(r26)
	sw	r15, 38(r3)
	lw	r15, 15(r3)
	sw	r15, 3(r26)
	sw	r23, 39(r3)
	lw	r23, 34(r3)
	sw	r23, 2(r26)
	sw	r25, 1(r26)
	add	r7, r0, r4				# mr	r7, r4
	addi	r4, r4, 10
	addi	r6, r0, shadow_check_one_or_group.2745
	sw	r6, 0(r7)
	sw	r21, 9(r7)
	sw	r16, 8(r7)
	sw	r26, 7(r7)
	sw	r10, 6(r7)
	sw	r28, 5(r7)
	sw	r9, 4(r7)
	sw	r15, 3(r7)
	sw	r25, 2(r7)
	sw	r14, 1(r7)
	add	r6, r0, r4				# mr	r6, r4
	addi	r4, r4, 13
	addi	r8, r0, shadow_check_one_or_matrix.2748
	sw	r8, 0(r6)
	sw	r27, 12(r6)
	sw	r20, 11(r6)
	sw	r19, 10(r6)
	sw	r21, 9(r6)
	sw	r16, 8(r6)
	sw	r7, 7(r6)
	sw	r26, 6(r6)
	sw	r10, 5(r6)
	sw	r28, 4(r6)
	sw	r15, 3(r6)
	sw	r23, 2(r6)
	sw	r14, 1(r6)
	add	r8, r0, r4				# mr	r8, r4
	addi	r4, r4, 11
	addi	r20, r0, solve_each_element.2751
	sw	r20, 0(r8)
	lw	r20, 14(r3)
	sw	r20, 10(r8)
	lw	r26, 24(r3)
	sw	r26, 9(r8)
	sw	r17, 8(r8)
	sw	r13, 7(r8)
	sw	r16, 6(r8)
	sw	r10, 5(r8)
	lw	r23, 13(r3)
	sw	r23, 4(r8)
	sw	r15, 3(r8)
	lw	r27, 16(r3)
	sw	r27, 2(r8)
	sw	r25, 1(r8)
	add	r5, r0, r4				# mr	r5, r4
	addi	r4, r4, 3
	addi	r11, r0, solve_one_or_network.2755
	sw	r11, 0(r5)
	sw	r8, 2(r5)
	sw	r14, 1(r5)
	add	r11, r0, r4				# mr	r11, r4
	addi	r4, r4, 11
	addi	r9, r0, trace_or_matrix.2759
	sw	r9, 0(r11)
	sw	r20, 10(r11)
	sw	r26, 9(r11)
	sw	r17, 8(r11)
	sw	r13, 7(r11)
	sw	r16, 6(r11)
	sw	r18, 5(r11)
	sw	r5, 4(r11)
	sw	r8, 3(r11)
	sw	r10, 2(r11)
	sw	r14, 1(r11)
	add	r5, r0, r4				# mr	r5, r4
	addi	r4, r4, 10
	addi	r8, r0, solve_each_element_fast.2765
	sw	r8, 0(r5)
	sw	r20, 9(r5)
	lw	r8, 25(r3)
	sw	r8, 8(r5)
	sw	r19, 7(r5)
	sw	r16, 6(r5)
	sw	r10, 5(r5)
	sw	r23, 4(r5)
	sw	r15, 3(r5)
	sw	r27, 2(r5)
	sw	r25, 1(r5)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 3
	addi	r13, r0, solve_one_or_network_fast.2769
	sw	r13, 0(r9)
	sw	r5, 2(r9)
	sw	r14, 1(r9)
	add	r13, r0, r4				# mr	r13, r4
	addi	r4, r4, 9
	addi	r17, r0, trace_or_matrix_fast.2773
	sw	r17, 0(r13)
	sw	r20, 8(r13)
	sw	r19, 7(r13)
	sw	r22, 6(r13)
	sw	r16, 5(r13)
	sw	r9, 4(r13)
	sw	r5, 3(r13)
	sw	r10, 2(r13)
	sw	r14, 1(r13)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 3
	addi	r18, r0, get_nvector_second.2783
	sw	r18, 0(r17)
	lw	r18, 17(r3)
	sw	r18, 2(r17)
	sw	r15, 1(r17)
	add	r19, r0, r4				# mr	r19, r4
	addi	r4, r4, 2
	addi	r25, r0, utexture.2788
	sw	r25, 0(r19)
	lw	r25, 18(r3)
	sw	r25, 1(r19)
	sw	r17, 40(r3)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 20
	addi	r12, r0, trace_reflections.2795
	sw	r12, 0(r17)
	sw	r13, 19(r17)
	sw	r20, 18(r17)
	sw	r25, 17(r17)
	sw	r22, 16(r17)
	sw	r21, 15(r17)
	sw	r16, 14(r17)
	sw	r9, 13(r17)
	sw	r5, 12(r17)
	sw	r6, 11(r17)
	sw	r7, 10(r17)
	lw	r12, 20(r3)
	sw	r12, 9(r17)
	sw	r1, 41(r3)
	lw	r1, 37(r3)
	sw	r1, 8(r17)
	sw	r2, 7(r17)
	sw	r18, 6(r17)
	sw	r28, 5(r17)
	sw	r23, 4(r17)
	sw	r15, 3(r17)
	sw	r27, 2(r17)
	sw	r14, 1(r17)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 34
	addi	r27, r0, trace_ray.2800
	sw	r27, 0(r14)
	sw	r19, 33(r14)
	lw	r27, 0(r3)
	sw	r27, 32(r14)
	sw	r17, 31(r14)
	sw	r13, 30(r14)
	sw	r11, 29(r14)
	sw	r20, 28(r14)
	sw	r25, 27(r14)
	sw	r8, 26(r14)
	sw	r26, 25(r14)
	sw	r22, 24(r14)
	sw	r21, 23(r14)
	sw	r16, 22(r14)
	sw	r9, 21(r14)
	sw	r5, 20(r14)
	sw	r6, 19(r14)
	sw	r7, 18(r14)
	sw	r24, 17(r14)
	sw	r12, 16(r14)
	sw	r1, 15(r14)
	sw	r2, 14(r14)
	sw	r10, 13(r14)
	sw	r18, 12(r14)
	lw	r11, 41(r3)
	sw	r11, 11(r14)
	lw	r17, 2(r3)
	sw	r17, 10(r14)
	sw	r28, 9(r14)
	lw	r27, 6(r3)
	sw	r27, 8(r14)
	sw	r23, 7(r14)
	sw	r15, 6(r14)
	lw	r11, 16(r3)
	sw	r11, 5(r14)
	lw	r1, 40(r3)
	sw	r1, 4(r14)
	lw	r26, 1(r3)
	sw	r26, 3(r14)
	lw	r26, 7(r3)
	sw	r26, 2(r14)
	lw	r26, 9(r3)
	sw	r26, 1(r14)
	sw	r14, 42(r3)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 19
	addi	r12, r0, trace_diffuse_ray.2806
	sw	r12, 0(r14)
	sw	r19, 18(r14)
	sw	r13, 17(r14)
	sw	r20, 16(r14)
	sw	r25, 15(r14)
	sw	r21, 14(r14)
	sw	r16, 13(r14)
	sw	r6, 12(r14)
	sw	r7, 11(r14)
	sw	r2, 10(r14)
	sw	r10, 9(r14)
	sw	r18, 8(r14)
	sw	r28, 7(r14)
	sw	r27, 6(r14)
	sw	r23, 5(r14)
	sw	r15, 4(r14)
	sw	r11, 3(r14)
	sw	r1, 2(r14)
	lw	r7, 19(r3)
	sw	r7, 1(r14)
	add	r12, r0, r4				# mr	r12, r4
	addi	r4, r4, 21
	addi	r21, r0, iter_trace_diffuse_rays.2809
	sw	r21, 0(r12)
	sw	r19, 20(r12)
	sw	r13, 19(r12)
	sw	r14, 18(r12)
	sw	r20, 17(r12)
	sw	r25, 16(r12)
	sw	r22, 15(r12)
	sw	r16, 14(r12)
	sw	r9, 13(r12)
	sw	r5, 12(r12)
	sw	r6, 11(r12)
	sw	r2, 10(r12)
	sw	r10, 9(r12)
	sw	r18, 8(r12)
	sw	r27, 7(r12)
	sw	r23, 6(r12)
	sw	r15, 5(r12)
	sw	r11, 4(r12)
	sw	r1, 3(r12)
	sw	r7, 2(r12)
	sw	r26, 1(r12)
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 6
	addi	r2, r0, trace_diffuse_ray_80percent.2818
	sw	r2, 0(r1)
	sw	r8, 5(r1)
	sw	r24, 4(r1)
	sw	r17, 3(r1)
	sw	r12, 2(r1)
	lw	r2, 31(r3)
	sw	r2, 1(r1)
	add	r5, r0, r4				# mr	r5, r4
	addi	r4, r4, 9
	addi	r6, r0, calc_diffuse_using_1point.2822
	sw	r6, 0(r5)
	sw	r14, 8(r5)
	sw	r8, 7(r5)
	sw	r24, 6(r5)
	lw	r6, 20(r3)
	sw	r6, 5(r5)
	sw	r17, 4(r5)
	sw	r12, 3(r5)
	sw	r2, 2(r5)
	sw	r7, 1(r5)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 3
	addi	r11, r0, calc_diffuse_using_5points.2825
	sw	r11, 0(r9)
	sw	r6, 2(r9)
	sw	r7, 1(r9)
	add	r11, r0, r4				# mr	r11, r4
	addi	r4, r4, 10
	addi	r13, r0, do_without_neighbors.2831
	sw	r13, 0(r11)
	sw	r1, 9(r11)
	sw	r8, 8(r11)
	sw	r24, 7(r11)
	sw	r6, 6(r11)
	sw	r17, 5(r11)
	sw	r12, 4(r11)
	sw	r2, 3(r11)
	sw	r7, 2(r11)
	sw	r5, 1(r11)
	add	r13, r0, r4				# mr	r13, r4
	addi	r4, r4, 7
	addi	r15, r0, try_exploit_neighbors.2847
	sw	r15, 0(r13)
	sw	r1, 6(r13)
	sw	r6, 5(r13)
	sw	r11, 4(r13)
	sw	r7, 3(r13)
	sw	r9, 2(r13)
	sw	r5, 1(r13)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 8
	addi	r16, r0, pretrace_diffuse_rays.2860
	sw	r16, 0(r15)
	sw	r14, 7(r15)
	sw	r8, 6(r15)
	sw	r24, 5(r15)
	sw	r17, 4(r15)
	sw	r12, 3(r15)
	sw	r2, 2(r15)
	sw	r7, 1(r15)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 17
	addi	r18, r0, pretrace_pixels.2863
	sw	r18, 0(r16)
	lw	r18, 5(r3)
	sw	r18, 16(r16)
	lw	r19, 42(r3)
	sw	r19, 15(r16)
	sw	r14, 14(r16)
	sw	r8, 13(r16)
	lw	r8, 24(r3)
	sw	r8, 12(r16)
	sw	r24, 11(r16)
	lw	r14, 26(r3)
	sw	r14, 10(r16)
	lw	r20, 23(r3)
	sw	r20, 9(r16)
	sw	r6, 8(r16)
	lw	r21, 29(r3)
	sw	r21, 7(r16)
	sw	r15, 6(r16)
	sw	r17, 5(r16)
	sw	r12, 4(r16)
	lw	r12, 22(r3)
	sw	r12, 3(r16)
	sw	r2, 2(r16)
	sw	r7, 1(r16)
	add	r22, r0, r4				# mr	r22, r4
	addi	r4, r4, 14
	addi	r23, r0, pretrace_line.2870
	sw	r23, 0(r22)
	sw	r18, 13(r22)
	sw	r19, 12(r22)
	sw	r8, 11(r22)
	lw	r8, 28(r3)
	sw	r8, 10(r22)
	lw	r18, 27(r3)
	sw	r18, 9(r22)
	sw	r14, 8(r22)
	sw	r20, 7(r22)
	sw	r6, 6(r22)
	sw	r21, 5(r22)
	sw	r16, 4(r22)
	sw	r15, 3(r22)
	lw	r14, 21(r3)
	sw	r14, 2(r22)
	sw	r12, 1(r22)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 9
	addi	r19, r0, scan_pixel.2874
	sw	r19, 0(r15)
	sw	r13, 8(r15)
	sw	r1, 7(r15)
	sw	r6, 6(r15)
	sw	r14, 5(r15)
	sw	r11, 4(r15)
	sw	r7, 3(r15)
	sw	r9, 2(r15)
	sw	r5, 1(r15)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 15
	addi	r19, r0, scan_line.2880
	sw	r19, 0(r9)
	sw	r13, 14(r9)
	sw	r1, 13(r9)
	sw	r8, 12(r9)
	sw	r18, 11(r9)
	sw	r15, 10(r9)
	sw	r20, 9(r9)
	sw	r6, 8(r9)
	sw	r16, 7(r9)
	sw	r22, 6(r9)
	sw	r14, 5(r9)
	sw	r12, 4(r9)
	sw	r11, 3(r9)
	sw	r7, 2(r9)
	sw	r5, 1(r9)
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 2
	addi	r5, r0, create_pixel.2888
	sw	r5, 0(r1)
	lw	r5, 1(r3)
	sw	r5, 1(r1)
	add	r6, r0, r4				# mr	r6, r4
	addi	r4, r4, 3
	addi	r7, r0, init_line_elements.2890
	sw	r7, 0(r6)
	sw	r5, 2(r6)
	sw	r1, 1(r6)
	add	r7, r0, r4				# mr	r7, r4
	addi	r4, r4, 2
	addi	r8, r0, calc_dirvec.2900
	sw	r8, 0(r7)
	sw	r2, 1(r7)
	add	r8, r0, r4				# mr	r8, r4
	addi	r4, r4, 2
	addi	r11, r0, calc_dirvecs.2908
	sw	r11, 0(r8)
	sw	r7, 1(r8)
	add	r11, r0, r4				# mr	r11, r4
	addi	r4, r4, 3
	addi	r13, r0, calc_dirvec_rows.2913
	sw	r13, 0(r11)
	sw	r8, 2(r11)
	sw	r7, 1(r11)
	add	r7, r0, r4				# mr	r7, r4
	addi	r4, r4, 2
	addi	r13, r0, create_dirvec_elements.2919
	sw	r13, 0(r7)
	sw	r17, 1(r7)
	add	r13, r0, r4				# mr	r13, r4
	addi	r4, r4, 4
	addi	r15, r0, create_dirvecs.2922
	sw	r15, 0(r13)
	sw	r17, 3(r13)
	sw	r2, 2(r13)
	sw	r7, 1(r13)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 4
	addi	r16, r0, init_dirvec_constants.2924
	sw	r16, 0(r15)
	sw	r10, 3(r15)
	sw	r17, 2(r15)
	lw	r16, 39(r3)
	sw	r16, 1(r15)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 6
	addi	r19, r0, init_vecset_constants.2927
	sw	r19, 0(r18)
	sw	r10, 5(r18)
	sw	r17, 4(r18)
	sw	r16, 3(r18)
	sw	r15, 2(r18)
	sw	r2, 1(r18)
	add	r19, r0, r4				# mr	r19, r4
	addi	r4, r4, 7
	addi	r21, r0, setup_reflections.2944
	sw	r21, 0(r19)
	lw	r21, 37(r3)
	sw	r21, 6(r19)
	sw	r10, 5(r19)
	lw	r21, 41(r3)
	sw	r21, 4(r19)
	sw	r17, 3(r19)
	sw	r27, 2(r19)
	sw	r16, 1(r19)
	addi	r21, r0, 128				# li	r21, 128
	addi	r23, r0, 128				# li	r23, 128
	sw	r21, 0(r14)
	sw	r23, 1(r14)
	addi	r23, r0, 64				# li	r23, 64
	sw	r23, 0(r12)
	addi	r23, r0, 64				# li	r23, 64
	sw	r23, 1(r12)
	addi	r30, r0, 0
	lui	r30, r30, 17152	# to load float		128.000000
	fmvfr	f1, r30
	sw	r9, 43(r3)
	sw	r22, 44(r3)
	sw	r19, 45(r3)
	sw	r18, 46(r3)
	sw	r15, 47(r3)
	sw	r11, 48(r3)
	sw	r8, 49(r3)
	sw	r13, 50(r3)
	sw	r7, 51(r3)
	sw	r6, 52(r3)
	sw	r1, 53(r3)
	fmvtr	r30, f1
	sw	r30, 54(r3)				#stfd	f1, 54(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r21				# mr	r1, r21
	sw	r30, 56(r3)
	addi	r3, r3, 57
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -57
	lw	r30, 56(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 54(r3)				#lfd	f2, 54(r3)
	fmvfr	f2, r30
	fdiv	f1, f2, f1
	lw	r1, 23(r3)
	fmvtr	r30, f1
	sw	r30, 0(r1)
	lw	r1, 21(r3)
	lw	r2, 0(r1)
	addi	r5, r0, 3				# li	r5, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r2, 56(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 57(r3)
	addi	r3, r3, 58
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -58
	lw	r30, 57(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 57(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 58(r3)
	addi	r3, r3, 59
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -59
	lw	r30, 58(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 58(r3)
	addi	r3, r3, 59
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -59
	lw	r30, 58(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 58(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 59(r3)
	addi	r3, r3, 60
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -60
	lw	r30, 59(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 58(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 59(r3)
	addi	r3, r3, 60
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -60
	lw	r30, 59(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 58(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 59(r3)
	addi	r3, r3, 60
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -60
	lw	r30, 59(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 58(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 59(r3)
	addi	r3, r3, 60
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -60
	lw	r30, 59(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 58(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 5				# li	r1, 5
	addi	r5, r0, 0				# li	r5, 0
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 59(r3)
	addi	r3, r3, 60
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -60
	lw	r30, 59(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 5				# li	r2, 5
	lw	r5, 1(r3)
	sw	r1, 59(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 60(r3)
	addi	r3, r3, 61
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -61
	lw	r30, 60(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 60(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 61(r3)
	addi	r3, r3, 62
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -62
	lw	r30, 61(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 61(r3)
	addi	r3, r3, 62
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -62
	lw	r30, 61(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 61(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 62(r3)
	addi	r3, r3, 63
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -63
	lw	r30, 62(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 61(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 62(r3)
	addi	r3, r3, 63
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -63
	lw	r30, 62(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 61(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 62(r3)
	addi	r3, r3, 63
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -63
	lw	r30, 62(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 61(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 62(r3)
	addi	r3, r3, 63
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -63
	lw	r30, 62(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 61(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 62(r3)
	addi	r3, r3, 63
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -63
	lw	r30, 62(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 62(r3)
	addi	r3, r3, 63
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -63
	lw	r30, 62(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 62(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 63(r3)
	addi	r3, r3, 64
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -64
	lw	r30, 63(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 62(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 63(r3)
	addi	r3, r3, 64
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -64
	lw	r30, 63(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 62(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 63(r3)
	addi	r3, r3, 64
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -64
	lw	r30, 63(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 62(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 63(r3)
	addi	r3, r3, 64
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -64
	lw	r30, 63(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 62(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 1				# li	r1, 1
	addi	r5, r0, 0				# li	r5, 0
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 63(r3)
	addi	r3, r3, 64
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -64
	lw	r30, 63(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 63(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 64(r3)
	addi	r3, r3, 65
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -65
	lw	r30, 64(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 64(r3)
	addi	r3, r3, 65
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -65
	lw	r30, 64(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 64(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 65(r3)
	addi	r3, r3, 66
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -66
	lw	r30, 65(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 64(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 65(r3)
	addi	r3, r3, 66
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -66
	lw	r30, 65(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 64(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 65(r3)
	addi	r3, r3, 66
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -66
	lw	r30, 65(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 64(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 65(r3)
	addi	r3, r3, 66
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -66
	lw	r30, 65(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 64(r3)
	sw	r1, 4(r2)
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 8
	sw	r2, 7(r1)
	lw	r2, 63(r3)
	sw	r2, 6(r1)
	lw	r2, 62(r3)
	sw	r2, 5(r1)
	lw	r2, 61(r3)
	sw	r2, 4(r1)
	lw	r2, 60(r3)
	sw	r2, 3(r1)
	lw	r2, 59(r3)
	sw	r2, 2(r1)
	lw	r2, 58(r3)
	sw	r2, 1(r1)
	lw	r2, 57(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 56(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 65(r3)
	addi	r3, r3, 66
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -66
	lw	r30, 65(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 21(r3)
	lw	r5, 0(r2)
	addi	r6, r0, 2				# li	r6, 2
	sub	r5, r5, r6
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r5, ble_then.32048
	j	ble_cont.32049
ble_then.32048:
	lw	r28, 53(r3)
	sw	r5, 65(r3)
	sw	r1, 66(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 67(r3)
	addi	r3, r3, 68
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -68
	lw	r30, 67(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 65(r3)
	lw	r5, 66(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r2, r2, r1
	lw	r28, 52(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 67(r3)
	addi	r3, r3, 68
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -68
	lw	r30, 67(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.32049:
	lw	r2, 21(r3)
	lw	r5, 0(r2)
	addi	r6, r0, 3				# li	r6, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 67(r3)
	sw	r5, 68(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 69(r3)
	addi	r3, r3, 70
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -70
	lw	r30, 69(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 69(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 70(r3)
	addi	r3, r3, 71
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -71
	lw	r30, 70(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 70(r3)
	addi	r3, r3, 71
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -71
	lw	r30, 70(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 70(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 71(r3)
	addi	r3, r3, 72
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -72
	lw	r30, 71(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 70(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 71(r3)
	addi	r3, r3, 72
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -72
	lw	r30, 71(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 70(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 71(r3)
	addi	r3, r3, 72
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -72
	lw	r30, 71(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 70(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 71(r3)
	addi	r3, r3, 72
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -72
	lw	r30, 71(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 70(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 5				# li	r1, 5
	addi	r5, r0, 0				# li	r5, 0
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 71(r3)
	addi	r3, r3, 72
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -72
	lw	r30, 71(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 5				# li	r2, 5
	lw	r5, 1(r3)
	sw	r1, 71(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 72(r3)
	addi	r3, r3, 73
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -73
	lw	r30, 72(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 72(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 73(r3)
	addi	r3, r3, 74
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -74
	lw	r30, 73(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 73(r3)
	addi	r3, r3, 74
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -74
	lw	r30, 73(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 73(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 74(r3)
	addi	r3, r3, 75
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -75
	lw	r30, 74(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 73(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 74(r3)
	addi	r3, r3, 75
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -75
	lw	r30, 74(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 73(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 74(r3)
	addi	r3, r3, 75
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -75
	lw	r30, 74(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 73(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 74(r3)
	addi	r3, r3, 75
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -75
	lw	r30, 74(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 73(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 74(r3)
	addi	r3, r3, 75
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -75
	lw	r30, 74(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 74(r3)
	addi	r3, r3, 75
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -75
	lw	r30, 74(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 74(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 75(r3)
	addi	r3, r3, 76
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -76
	lw	r30, 75(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 74(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 75(r3)
	addi	r3, r3, 76
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -76
	lw	r30, 75(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 74(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 75(r3)
	addi	r3, r3, 76
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -76
	lw	r30, 75(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 74(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 75(r3)
	addi	r3, r3, 76
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -76
	lw	r30, 75(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 74(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 1				# li	r1, 1
	addi	r5, r0, 0				# li	r5, 0
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 75(r3)
	addi	r3, r3, 76
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -76
	lw	r30, 75(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 75(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 76(r3)
	addi	r3, r3, 77
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -77
	lw	r30, 76(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 76(r3)
	addi	r3, r3, 77
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -77
	lw	r30, 76(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 76(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 77(r3)
	addi	r3, r3, 78
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -78
	lw	r30, 77(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 76(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 77(r3)
	addi	r3, r3, 78
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -78
	lw	r30, 77(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 76(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 77(r3)
	addi	r3, r3, 78
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -78
	lw	r30, 77(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 76(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 77(r3)
	addi	r3, r3, 78
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -78
	lw	r30, 77(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 76(r3)
	sw	r1, 4(r2)
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 8
	sw	r2, 7(r1)
	lw	r2, 75(r3)
	sw	r2, 6(r1)
	lw	r2, 74(r3)
	sw	r2, 5(r1)
	lw	r2, 73(r3)
	sw	r2, 4(r1)
	lw	r2, 72(r3)
	sw	r2, 3(r1)
	lw	r2, 71(r3)
	sw	r2, 2(r1)
	lw	r2, 70(r3)
	sw	r2, 1(r1)
	lw	r2, 69(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 68(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 77(r3)
	addi	r3, r3, 78
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -78
	lw	r30, 77(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 21(r3)
	lw	r5, 0(r2)
	addi	r6, r0, 2				# li	r6, 2
	sub	r5, r5, r6
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r5, ble_then.32050
	j	ble_cont.32051
ble_then.32050:
	lw	r28, 53(r3)
	sw	r5, 77(r3)
	sw	r1, 78(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 79(r3)
	addi	r3, r3, 80
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -80
	lw	r30, 79(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 77(r3)
	lw	r5, 78(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r2, r2, r1
	lw	r28, 52(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 79(r3)
	addi	r3, r3, 80
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -80
	lw	r30, 79(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.32051:
	lw	r2, 21(r3)
	lw	r5, 0(r2)
	addi	r6, r0, 3				# li	r6, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 79(r3)
	sw	r5, 80(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 81(r3)
	addi	r3, r3, 82
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -82
	lw	r30, 81(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 81(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 82(r3)
	addi	r3, r3, 83
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -83
	lw	r30, 82(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 82(r3)
	addi	r3, r3, 83
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -83
	lw	r30, 82(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 82(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 83(r3)
	addi	r3, r3, 84
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -84
	lw	r30, 83(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 82(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 83(r3)
	addi	r3, r3, 84
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -84
	lw	r30, 83(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 82(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 83(r3)
	addi	r3, r3, 84
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -84
	lw	r30, 83(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 82(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 83(r3)
	addi	r3, r3, 84
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -84
	lw	r30, 83(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 82(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 5				# li	r1, 5
	addi	r5, r0, 0				# li	r5, 0
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 83(r3)
	addi	r3, r3, 84
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -84
	lw	r30, 83(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 5				# li	r2, 5
	lw	r5, 1(r3)
	sw	r1, 83(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 84(r3)
	addi	r3, r3, 85
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -85
	lw	r30, 84(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 84(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 85(r3)
	addi	r3, r3, 86
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -86
	lw	r30, 85(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 85(r3)
	addi	r3, r3, 86
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -86
	lw	r30, 85(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 85(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 86(r3)
	addi	r3, r3, 87
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -87
	lw	r30, 86(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 85(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 86(r3)
	addi	r3, r3, 87
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -87
	lw	r30, 86(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 85(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 86(r3)
	addi	r3, r3, 87
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -87
	lw	r30, 86(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 85(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 86(r3)
	addi	r3, r3, 87
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -87
	lw	r30, 86(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 85(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 86(r3)
	addi	r3, r3, 87
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -87
	lw	r30, 86(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 86(r3)
	addi	r3, r3, 87
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -87
	lw	r30, 86(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 86(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 87(r3)
	addi	r3, r3, 88
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -88
	lw	r30, 87(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 86(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 87(r3)
	addi	r3, r3, 88
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -88
	lw	r30, 87(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 86(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 87(r3)
	addi	r3, r3, 88
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -88
	lw	r30, 87(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 86(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 87(r3)
	addi	r3, r3, 88
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -88
	lw	r30, 87(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 86(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 1				# li	r1, 1
	addi	r5, r0, 0				# li	r5, 0
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r5				# mr	r2, r5
	sw	r30, 87(r3)
	addi	r3, r3, 88
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -88
	lw	r30, 87(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 87(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 88(r3)
	addi	r3, r3, 89
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -89
	lw	r30, 88(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 5				# li	r1, 5
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 88(r3)
	addi	r3, r3, 89
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -89
	lw	r30, 88(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 88(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 89(r3)
	addi	r3, r3, 90
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -90
	lw	r30, 89(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 88(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 89(r3)
	addi	r3, r3, 90
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -90
	lw	r30, 89(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 88(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 89(r3)
	addi	r3, r3, 90
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -90
	lw	r30, 89(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 88(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 89(r3)
	addi	r3, r3, 90
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -90
	lw	r30, 89(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 88(r3)
	sw	r1, 4(r2)
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 8
	sw	r2, 7(r1)
	lw	r2, 87(r3)
	sw	r2, 6(r1)
	lw	r2, 86(r3)
	sw	r2, 5(r1)
	lw	r2, 85(r3)
	sw	r2, 4(r1)
	lw	r2, 84(r3)
	sw	r2, 3(r1)
	lw	r2, 83(r3)
	sw	r2, 2(r1)
	lw	r2, 82(r3)
	sw	r2, 1(r1)
	lw	r2, 81(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 80(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 89(r3)
	addi	r3, r3, 90
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -90
	lw	r30, 89(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 21(r3)
	lw	r5, 0(r2)
	addi	r6, r0, 2				# li	r6, 2
	sub	r5, r5, r6
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r5, ble_then.32052
	j	ble_cont.32053
ble_then.32052:
	lw	r28, 53(r3)
	sw	r5, 89(r3)
	sw	r1, 90(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 91(r3)
	addi	r3, r3, 92
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -92
	lw	r30, 91(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 89(r3)
	lw	r5, 90(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 1				# li	r1, 1
	sub	r2, r2, r1
	lw	r28, 52(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 91(r3)
	addi	r3, r3, 92
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -92
	lw	r30, 91(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.32053:
	lw	r28, 38(r3)
	sw	r1, 91(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 92(r3)
	addi	r3, r3, 93
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -93
	lw	r30, 92(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 80				# li	r1, 80
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 92(r3)
	addi	r3, r3, 93
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -93
	lw	r30, 92(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 51				# li	r1, 51
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 92(r3)
	addi	r3, r3, 93
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -93
	lw	r30, 92(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 10				# li	r1, 10
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 92(r3)
	addi	r3, r3, 93
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -93
	lw	r30, 92(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 21(r3)
	lw	r2, 0(r1)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 92(r3)
	addi	r3, r3, 93
	jal	lib_print_int				#	bl	lib_print_int
	addi	r3, r3, -93
	lw	r30, 92(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 32				# li	r1, 32
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 92(r3)
	addi	r3, r3, 93
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -93
	lw	r30, 92(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 21(r3)
	lw	r1, 1(r1)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 92(r3)
	addi	r3, r3, 93
	jal	lib_print_int				#	bl	lib_print_int
	addi	r3, r3, -93
	lw	r30, 92(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 32				# li	r1, 32
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 92(r3)
	addi	r3, r3, 93
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -93
	lw	r30, 92(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 255				# li	r1, 255
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 92(r3)
	addi	r3, r3, 93
	jal	lib_print_int				#	bl	lib_print_int
	addi	r3, r3, -93
	lw	r30, 92(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 10				# li	r1, 10
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 92(r3)
	addi	r3, r3, 93
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -93
	lw	r30, 92(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 120				# li	r1, 120
	addi	r2, r0, 3				# li	r2, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 92(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 93(r3)
	addi	r3, r3, 94
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -94
	lw	r30, 93(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r5, 0(r1)
	sw	r2, 93(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 94(r3)
	addi	r3, r3, 95
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -95
	lw	r30, 94(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 93(r3)
	sw	r1, 0(r2)
	lw	r1, 92(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 94(r3)
	addi	r3, r3, 95
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -95
	lw	r30, 94(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 31(r3)
	sw	r1, 4(r2)
	lw	r1, 4(r2)
	addi	r5, r0, 3				# li	r5, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	sw	r1, 94(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 95(r3)
	addi	r3, r3, 96
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -96
	lw	r30, 95(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r5, 0(r1)
	sw	r2, 95(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 96(r3)
	addi	r3, r3, 97
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -97
	lw	r30, 96(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 95(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 94(r3)
	sw	r1, 118(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 96(r3)
	addi	r3, r3, 97
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -97
	lw	r30, 96(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r5, 0(r1)
	sw	r2, 96(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 97(r3)
	addi	r3, r3, 98
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -98
	lw	r30, 97(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 96(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 94(r3)
	sw	r1, 117(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 97(r3)
	addi	r3, r3, 98
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -98
	lw	r30, 97(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r5, 0(r1)
	sw	r2, 97(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 98(r3)
	addi	r3, r3, 99
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -99
	lw	r30, 98(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 97(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 94(r3)
	sw	r1, 116(r2)
	addi	r1, r0, 3				# li	r1, 3
	addi	r30, r0, 0
	lui	r30, r30, 0	# to load float		0.000000
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 98(r3)
	addi	r3, r3, 99
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -99
	lw	r30, 98(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 2(r3)
	lw	r5, 0(r1)
	sw	r2, 98(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 99(r3)
	addi	r3, r3, 100
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -100
	lw	r30, 99(r3)
	add	r31, r0, r30				#mtlr	r30
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 98(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 94(r3)
	sw	r1, 115(r2)
	addi	r1, r0, 114				# li	r1, 114
	lw	r28, 51(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	sw	r30, 99(r3)
	addi	r3, r3, 100
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -100
	lw	r30, 99(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 3				# li	r1, 3
	lw	r28, 50(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 99(r3)
	addi	r3, r3, 100
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -100
	lw	r30, 99(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 9				# li	r1, 9
	addi	r2, r0, 0				# li	r2, 0
	addi	r5, r0, 0				# li	r5, 0
	sw	r5, 99(r3)
	sw	r2, 100(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 101(r3)
	addi	r3, r3, 102
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -102
	lw	r30, 101(r3)
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
	lw	r2, 100(r3)
	lw	r5, 99(r3)
	lw	r28, 49(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 101(r3)
	addi	r3, r3, 102
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -102
	lw	r30, 101(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 8				# li	r1, 8
	addi	r2, r0, 2				# li	r2, 2
	addi	r5, r0, 4				# li	r5, 4
	lw	r28, 48(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 101(r3)
	addi	r3, r3, 102
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -102
	lw	r30, 101(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 31(r3)
	lw	r1, 4(r1)
	addi	r2, r0, 119				# li	r2, 119
	lw	r28, 47(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 101(r3)
	addi	r3, r3, 102
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -102
	lw	r30, 101(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 3				# li	r1, 3
	lw	r28, 46(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 101(r3)
	addi	r3, r3, 102
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -102
	lw	r30, 101(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 6(r3)
	lw	r30, 0(r1)
	fmvfr	f1, r30
	lw	r2, 33(r3)
	fmvtr	r30, f1
	sw	r30, 0(r2)
	lw	r30, 1(r1)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 1(r2)
	lw	r30, 2(r1)
	fmvfr	f1, r30
	fmvtr	r30, f1
	sw	r30, 2(r2)
	lw	r1, 2(r3)
	lw	r5, 0(r1)
	addi	r6, r0, 1				# li	r6, 1
	sub	r5, r5, r6
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r5, ble_then.32054
	j	ble_cont.32055
ble_then.32054:
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r6)
	addi	r8, r0, 1				# li	r8, 1
	beq	r7, r8, beq_then.32056
	addi	r8, r0, 2				# li	r8, 2
	beq	r7, r8, beq_then.32058
	sw	r5, 101(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r6				# mr	r2, r6
	sw	r30, 102(r3)
	addi	r3, r3, 103
	jal	setup_second_table.2703				#	bl	setup_second_table.2703
	addi	r3, r3, -103
	lw	r30, 102(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 101(r3)
	lw	r5, 34(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.32059
beq_then.32058:
	sw	r5, 101(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r6				# mr	r2, r6
	sw	r30, 102(r3)
	addi	r3, r3, 103
	jal	setup_surface_table.2700				#	bl	setup_surface_table.2700
	addi	r3, r3, -103
	lw	r30, 102(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 101(r3)
	lw	r5, 34(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.32059:
	j	beq_cont.32057
beq_then.32056:
	sw	r5, 101(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r6				# mr	r2, r6
	sw	r30, 102(r3)
	addi	r3, r3, 103
	jal	setup_rect_table.2697				#	bl	setup_rect_table.2697
	addi	r3, r3, -103
	lw	r30, 102(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 101(r3)
	lw	r5, 34(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.32057:
	addi	r1, r0, 1				# li	r1, 1
	sub	r2, r2, r1
	lw	r1, 35(r3)
	lw	r28, 39(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 102(r3)
	addi	r3, r3, 103
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -103
	lw	r30, 102(r3)
	add	r31, r0, r30				#mtlr	r30
ble_cont.32055:
	lw	r1, 2(r3)
	lw	r1, 0(r1)
	addi	r2, r0, 1				# li	r2, 1
	sub	r1, r1, r2
	lw	r28, 45(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 102(r3)
	addi	r3, r3, 103
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -103
	lw	r30, 102(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 0				# li	r2, 0
	addi	r5, r0, 0				# li	r5, 0
	lw	r1, 79(r3)
	lw	r28, 44(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 102(r3)
	addi	r3, r3, 103
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -103
	lw	r30, 102(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	addi	r7, r0, 2				# li	r7, 2
	lw	r2, 67(r3)
	lw	r5, 79(r3)
	lw	r6, 91(r3)
	lw	r28, 43(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 102(r3)
	addi	r3, r3, 103
	lw	r30, 0(r28)
	jalr	r30
	addi	r3, r3, -103
	lw	r30, 102(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	_R_0, r0, 0				# li	_R_0, 0
