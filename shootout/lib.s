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
  addi  r4, r4, 4
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
  addi  r4, r4, 4
  j lib_create_float_array_loop:
lib_create_float_array_exit:
  jr  r31
lib_read_char:
  in  r1
  jr  r31
lib_buffer_add_char:
  addi  r30, r0, 30000
  add r30, r30, r30
  lw  r29, 64(r30)
  addi  r29, r29, 1
  sw  r29, 64(r30)
  addi  r29, r29, -1
  slli  r29, r29, 2
  add r30, r30, r29
  sw  r1, 0(r30)
  jr  r31  
lib_buffer_clear:
  addi  r30, r0, 30000
  add r30, r30, r30
  sw  r0, 0(r30)
  sw  r0, 4(r30)
  sw  r0, 8(r30)
  sw  r0, 12(r30)
  sw  r0, 16(r30)
  sw  r0, 20(r30)
  sw  r0, 24(r30)
  sw  r0, 28(r30)
  sw  r0, 32(r30)
  sw  r0, 36(r30)
  sw  r0, 40(r30)
  sw  r0, 44(r30)
  sw  r0, 48(r30)
  sw  r0, 52(r30)
  sw  r0, 56(r30)
  sw  r0, 60(r30)
  sw  r0, 64(r30)
  jr  r31
lib_buffer_get:
  addi  r30, r0, 30000
  add r30, r30, r30
  slli  r1, r1, 2
  add r30, r30, r1
  lw  r1, 0(r30)
  jr r31
lib_buffer_to_int:
  addi  r30, r0, 30000
  add r30, r30, r30
  lw  r2, 64(r30)
  addi  r1, r0, 0
  lw  r5, 0(r30)
  addi  r29, r0, 45
  ble r5, r29, lib_buffer_to_int_minus
lib_buffer_to_int_cont:
  beq r2, r0, lib_buffer_to_int_exit
  sw  r1, 0(r3)
  sw  r2, 4(r3)
  sw  r30, 8(r3)
  sw  r31, 12(r3)
  lw  r1, 0(r30)
  addi  r1, r1, -48
  addi  r2, r2, -1
  addi  r3, r3, 16
  jal lib_iter_mul10
  addi  r3, r3, -16
  lw  r5, 0(r3)
  lw  r2, 4(r3)
  lw  r30, 8(r3)
  lw  r31, 12(r3)
  addi  r30, r30, 4
  add r1, r1, r5
  addi  r2, r2, -1
  j lib_buffer_to_int_cont:
lib_buffer_to_int_exit:
  jr  r31
lib_buffer_to_int_minus:
  addi  r30, r30, 4
  addi  r2, r2, -1
lib_buffer_to_int_minus_cont:
  beq r2, r0, lib_buffer_to_int_minus_exit
  sw  r1, 0(r3)
  sw  r2, 4(r3)
  sw  r30, 8(r3)
  sw  r31, 12(r3)
  lw  r1, 0(r30)
  addi  r1, r1, -48
  addi  r2, r2, -1
  addi  r3, r3, 16
  jal lib_iter_mul10
  addi  r3, r3, -16
  lw  r5, 0(r3)
  lw  r2, 4(r3)
  lw  r30, 8(r3)
  lw  r31, 12(r3)
  addi  r30, r30, 4
  add r1, r1, r5
  addi  r2, r2, -1
  j lib_buffer_to_int_minus_cont:
lib_buffer_to_int_minus_exit:
  sub r1, r0, r1
  jr  r31
lib_buffer_to_int_of_float:
  addi  r30, r0, 30000
  add r30, r30, r30
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
  addi r30, r30, 4
  j lib_buffer_to_pos_loop
lib_buffer_to_int_of_float_minus:
  addi  r30, r30, 4
  addi  r8, r0, 4
  j lib_buffer_to_pos_loop
lib_buffer_to_int_cont_ready:
  addi r30, r0, 30000
  add r30, r30, r30
  add r30, r30, r8
  j lib_buffer_to_int_cont
# for read_float
lib_buffer_to_dec_of_float:
  addi  r30, r0, 30000
  add r30, r30, r30
  addi  r1, r0, 0
  addi  r5, r0, 46
  addi  r2, r0, 0
lib_buffer_to_pos_loop_dec:
  lw  r6, 0(r30)
  beq r6, r5, lib_buffer_to_dec_of_float_cont
  beq r6, r0, lib_buffer_to_dec_zero
  addi  r2, r2, 1
  addi r30, r30, 4
  j lib_buffer_to_pos_loop_dec
lib_buffer_to_dec_zero:
  addi r1, r0, 0
  jr  r31
lib_buffer_to_dec_of_float_cont:
  addi  r29, r0, 30000
  add r29, r29, r29
  addi  r2, r2, 1
  lw  r7, 64(r29)
  sub r2, r7, r2
  addi  r1, r0, 0
  addi  r30, r30, 4
  j lib_buffer_to_int_cont
lib_buffer_to_ika_keta_of_float:
  addi  r30, r0, 30000
  add r30, r30, r30
  addi  r1, r0, 0
  addi  r5, r0, 46
  addi  r2, r0, 0
lib_buffer_to_pos_loop_keta:
  lw  r6, 0(r30)
  beq r6, r5, lib_buffer_to_ika_keta_of_float_cont
  beq r6, r0, lib_buffer_to_ika_keta_zero
  addi  r2, r2, 1
  addi r30, r30, 4
  j lib_buffer_to_pos_loop_keta
lib_buffer_to_ika_keta_zero:
  addi r1, r0, 0
  jr  r31
lib_buffer_to_ika_keta_of_float_cont:
  addi  r29, r0, 30000
  add r29, r29, r29
  addi  r2, r2, 1
  lw  r7, 64(r29)
  sub r1, r7, r2
  jr  r31
lib_fless:
	flt r1, f1, f2
	jr	r31				#	blr
lib_fispos:
	addi	r30, r0, 0	# to load float		0.000000
	lui	r30, r30, 0
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.828
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
_fle_then.828:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
lib_fisneg:
	addi	r30, r0, 0	# to load float		0.000000
	lui	r30, r30, 0
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.829
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
_fle_then.829:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
lib_fiszero:
	addi	r30, r0, 0	# to load float		0.000000
	lui	r30, r30, 0
	fmvfr	f2, r30
	feq	r30, f1, f2
	bne	r0, r30, _feq_then.830
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
_feq_then.830:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
lib_xor:
	beq	r1, r2, _beq_then.831
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
_beq_then.831:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
lib_fhalf:
	addi	r30, r0, 0	# to load float		0.500000
	lui	r30, r30, 16128
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
lib_fsqr:
	fmul	f1, f1, f1
	jr	r31				#	blr
lib_fabs:
	addi	r30, r0, 0	# to load float		0.000000
	lui	r30, r30, 0
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.832
 lib_fneg	f1, f1
	jr	r31				#	blr
_fle_then.832:
	jr	r31				#	blr
lib_fneg:
 lib_fneg	f1, f1
	jr	r31				#	blr
lib_floor:
	fmvtr	r30, f1
	sw	r30, 0(r3)				#stfd	f1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	lib_ftoi				#	bl	lib_ftoi
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	lib_itof				#	bl	lib_itof
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.833
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f2, r30
	fsub	f1, f1, f2
	jr	r31				#	blr
_fle_then.833:
	jr	r31				#	blr
lib_int_of_float:
	j	lib_ftoi
lib_float_of_int:
	j	lib_itof
hoge.721:
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.834
	fadd	f1, f0, f2				# fmr	f1, f2
	jr	r31				#	blr
_fle_then.834:
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f3, r30
	fmul	f2, f3, f2
	j	hoge.721
fuga.725:
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f4, r30
	fmul	f4, f3, f4
	fle	r30, f4, f1
	bne	r0, r30, _fle_then.835
	jr	r31				#	blr
_fle_then.835:
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.836
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f4, r30
	fdiv	f2, f2, f4
	j	fuga.725
_fle_then.836:
	fsub	f1, f1, f2
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f4, r30
	fdiv	f2, f2, f4
	j	fuga.725
lib_modulo_2pi:
	addi	r30, r0, 4059	# to load float		3.141593
	lui	r30, r30, 16457
	fmvfr	f2, r30
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f3, r30
	addi	r30, r0, 4059	# to load float		6.283185
	lui	r30, r30, 16585
	fmvfr	f3, r30
	fmvtr	r30, f2
	sw	r30, 0(r3)				#stfd	f2, 0(r3)
	fmvtr	r30, f1
	sw	r30, 8(r3)				#stfd	f1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	fadd	f2, f0, f3				# fmr	f2, f3
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	hoge.721				#	bl	hoge.721
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
	j	fuga.725
lib_sin_body:
	addi	r30, r0, 43692	# to load float		0.166667
	lui	r30, r30, 15914
	fmvfr	f2, r30
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fsub	f2, f1, f2
	addi	r30, r0, 34406	# to load float		0.008333
	lui	r30, r30, 15368
	fmvfr	f3, r30
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fadd	f2, f2, f3
	addi	r30, r0, 25782	# to load float		0.000196
	lui	r30, r30, 14669
	fmvfr	f3, r30
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f1, f3, f1
	fsub	f1, f2, f1
	jr	r31				#	blr
lib_cos_body:
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f2, r30
	addi	r30, r0, 0	# to load float		0.500000
	lui	r30, r30, 16128
	fmvfr	f3, r30
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fsub	f2, f2, f3
	addi	r30, r0, 42889	# to load float		0.041664
	lui	r30, r30, 15658
	fmvfr	f3, r30
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fadd	f2, f2, f3
	addi	r30, r0, 33030	# to load float		0.001370
	lui	r30, r30, 15027
	fmvfr	f3, r30
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f1, f3, f1
	fsub	f1, f2, f1
	jr	r31				#	blr
lib_sin:
	addi	r30, r0, 4059	# to load float		3.141593
	lui	r30, r30, 16457
	fmvfr	f2, r30
	addi	r30, r0, 0	# to load float		0.000000
	lui	r30, r30, 0
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.837
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f3, r30
	addi	r30, r0, 0	# to load float		-1.000000
	lui	r30, r30, 49024
	fmvfr	f3, r30
	j	fle_cont.838
_fle_then.837:
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f3, r30
fle_cont.838:
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	lib_abs_float				#	bl	lib_abs_float
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal lib_modulo_2pi				#	bl lib_modulo_2pi
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.839
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f3, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.840
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.841
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal lib_cos_body				#	bl lib_cos_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.841:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal lib_sin_body				#	bl lib_sin_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.840:
	fsub	f1, f2, f1
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.842
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal lib_cos_body				#	bl lib_cos_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.842:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal lib_sin_body				#	bl lib_sin_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.839:
	fsub	f1, f1, f2
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
 lib_fneg	f3, f3
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f4, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f4, r30
	fle	r30, f4, f1
	bne	r0, r30, _fle_then.843
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.844
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f2, r30
	fsub	f1, f2, f1
	fmvtr	r30, f3
	sw	r30, 16(r3)				#stfd	f3, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 32
	jal lib_cos_body				#	bl lib_cos_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.844:
	fmvtr	r30, f3
	sw	r30, 16(r3)				#stfd	f3, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 32
	jal lib_sin_body				#	bl lib_sin_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.843:
	fsub	f1, f2, f1
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.845
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f2, r30
	fsub	f1, f2, f1
	fmvtr	r30, f3
	sw	r30, 16(r3)				#stfd	f3, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 32
	jal lib_cos_body				#	bl lib_cos_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.845:
	fmvtr	r30, f3
	sw	r30, 16(r3)				#stfd	f3, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 32
	jal lib_sin_body				#	bl lib_sin_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
lib_cos:
	addi	r30, r0, 4059	# to load float		3.141593
	lui	r30, r30, 16457
	fmvfr	f2, r30
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f3, r30
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	lib_abs_float				#	bl	lib_abs_float
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal lib_modulo_2pi				#	bl lib_modulo_2pi
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.846
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f3, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.847
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.848
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f2, r30
	fsub	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal lib_sin_body				#	bl lib_sin_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.848:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal lib_cos_body				#	bl lib_cos_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.847:
	fsub	f1, f2, f1
	addi	r30, r0, 0	# to load float		-1.000000
	lui	r30, r30, 49024
	fmvfr	f2, r30
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f3, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f3, r30
	fle	r30, f1, f3
	bne	r0, r30, _fle_then.849
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f3, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f3, r30
	fsub	f1, f3, f1
	fmvtr	r30, f2
	sw	r30, 16(r3)				#stfd	f2, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 32
	jal lib_sin_body				#	bl lib_sin_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.849:
	fmvtr	r30, f2
	sw	r30, 16(r3)				#stfd	f2, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 32
	jal lib_cos_body				#	bl lib_cos_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.846:
	fsub	f1, f1, f2
	addi	r30, r0, 0	# to load float		-1.000000
	lui	r30, r30, 49024
	fmvfr	f3, r30
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f4, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f4, r30
	fle	r30, f4, f1
	bne	r0, r30, _fle_then.850
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.851
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f2, r30
	fsub	f1, f2, f1
	fmvtr	r30, f3
	sw	r30, 24(r3)				#stfd	f3, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 40
	jal lib_sin_body				#	bl lib_sin_body
	addi	r30, r0, 40
	sub	r3, r3, r30
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.851:
	fmvtr	r30, f3
	sw	r30, 24(r3)				#stfd	f3, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 40
	jal lib_cos_body				#	bl lib_cos_body
	addi	r30, r0, 40
	sub	r3, r3, r30
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.850:
	fsub	f1, f2, f1
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f2, r30
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f3, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f3, r30
	fle	r30, f1, f3
	bne	r0, r30, _fle_then.852
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f3, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f3, r30
	fsub	f1, f3, f1
	fmvtr	r30, f2
	sw	r30, 32(r3)				#stfd	f2, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 48
	jal lib_sin_body				#	bl lib_sin_body
	addi	r30, r0, 48
	sub	r3, r3, r30
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.852:
	fmvtr	r30, f2
	sw	r30, 32(r3)				#stfd	f2, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 48
	jal lib_cos_body				#	bl lib_cos_body
	addi	r30, r0, 48
	sub	r3, r3, r30
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
lib_atan_body:
	addi	r30, r0, 43690	# to load float		0.333333
	lui	r30, r30, 16042
	fmvfr	f2, r30
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fsub	f2, f1, f2
	addi	r30, r0, 52429	# to load float		0.200000
	lui	r30, r30, 15948
	fmvfr	f3, r30
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fadd	f2, f2, f3
	addi	r30, r0, 18725	# to load float		0.142857
	lui	r30, r30, 15890
	fmvfr	f3, r30
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fsub	f2, f2, f3
	addi	r30, r0, 36408	# to load float		0.111111
	lui	r30, r30, 15843
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
	addi	r30, r0, 54894	# to load float		0.089764
	lui	r30, r30, 15799
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
	addi	r30, r0, 59333	# to load float		0.060035
	lui	r30, r30, 15733
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
	addi	r30, r0, 4059	# to load float		3.141593
	lui	r30, r30, 16457
	fmvfr	f2, r30
	addi	r30, r0, 0	# to load float		0.000000
	lui	r30, r30, 0
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.853
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f2, r30
	addi	r30, r0, 0	# to load float		-1.000000
	lui	r30, r30, 49024
	fmvfr	f2, r30
	j	fle_cont.854
_fle_then.853:
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f2, r30
fle_cont.854:
	fmul	f1, f1, f2
	addi	r30, r0, 0	# to load float		4.375000
	lui	r30, r30, 16524
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.855
	j lib_atan_body
_fle_then.855:
	addi	r30, r0, 0	# to load float		2.437500
	lui	r30, r30, 16412
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.856
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f3, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f3, r30
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f4, r30
	fsub	f4, f1, f4
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f5, r30
	fadd	f1, f1, f5
	fdiv	f1, f4, f1
	fmvtr	r30, f2
	sw	r30, 0(r3)				#stfd	f2, 0(r3)
	fmvtr	r30, f3
	sw	r30, 8(r3)				#stfd	f3, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal lib_atan_body				#	bl lib_atan_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.856:
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f3, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f3, r30
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f4, r30
	fdiv	f1, f4, f1
	fmvtr	r30, f2
	sw	r30, 0(r3)				#stfd	f2, 0(r3)
	fmvtr	r30, f3
	sw	r30, 16(r3)				#stfd	f3, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 32
	jal lib_atan_body				#	bl lib_atan_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
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
	sw	r2, 0(r3)
	sw	r5, 4(r3)
	sw	r6, 8(r3)
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal lib_mul10				#	bl lib_mul10
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 12(r3)
	ble	r1, r2, _ble_then.857
	lw	r1, 0(r3)
	lw	r5, 8(r3)
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	j lib_div10_sub
_ble_then.857:
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal lib_mul10				#	bl lib_mul10
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r1, 9
	lw	r2, 12(r3)
	ble	r2, r1, _ble_then.858
	lw	r1, 8(r3)
	lw	r5, 4(r3)
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	j lib_div10_sub
_ble_then.858:
	lw	r1, 8(r3)
	jr	r31				#	blr
lib_div10:
	addi	r2, r0, 0				# li	r2, 0
	add	r5, r0, r1				# mr	r5, r1
	j lib_div10_sub
lib_iter_mul10:
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, _beq_then.859
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal lib_mul10				#	bl lib_mul10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j lib_iter_mul10
_beq_then.859:
	jr	r31				#	blr
lib_iter_div10:
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, _beq_then.860
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal lib_div10				#	bl lib_div10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j lib_iter_div10
_beq_then.860:
	jr	r31				#	blr
lib_keta_sub:
	addi	r5, r0, 10				# li	r5, 10
	ble	r5, r1, _ble_then.861
	addi	r1, r2, 1
	jr	r31				#	blr
_ble_then.861:
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal lib_div10				#	bl lib_div10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	addi	r2, r2, 1
	j lib_keta_sub
lib_keta:
	addi	r2, r0, 0				# li	r2, 0
	j lib_keta_sub
lib_print_uint_keta:
	addi	r5, r0, 1				# li	r5, 1
	beq	r2, r5, _beq_then.862
	addi	r5, r0, 1				# li	r5, 1
	addi	r6, r0, 1				# li	r6, 1
	sub	r6, r2, r6
	sw	r2, 0(r3)
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal lib_iter_mul10				#	bl lib_iter_mul10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	ble	r1, r2, _ble_then.863
	addi	r1, r0, 0				# li	r1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal lib_print_num				#	bl lib_print_num
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 0(r3)
	sub	r2, r2, r1
	lw	r1, 4(r3)
	j lib_print_uint_keta
_ble_then.863:
	addi	r1, r0, 1				# li	r1, 1
	lw	r5, 0(r3)
	sub	r1, r5, r1
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal lib_iter_div10				#	bl lib_iter_div10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal lib_print_num				#	bl lib_print_num
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 0(r3)
	sub	r1, r2, r1
	lw	r5, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal lib_iter_mul10				#	bl lib_iter_mul10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	sub	r1, r2, r1
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j lib_print_uint_keta
_beq_then.862:
	j lib_print_num
lib_print_uint:
	addi	r2, r0, 10				# li	r2, 10
	ble	r2, r1, _ble_then.864
	j lib_print_num
_ble_then.864:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal lib_div10				#	bl lib_div10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal lib_print_uint				#	bl lib_print_uint
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal lib_mul10				#	bl lib_mul10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sub	r1, r2, r1
	j lib_print_num
lib_print_int:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, _ble_then.865
	addi	r2, r0, 45				# li	r2, 45
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_print_char				#	bl	lib_print_char
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	sub	r1, r0, r1
	j lib_print_uint
_ble_then.865:
	j lib_print_uint
lib_read_token:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_read_char				#	bl	lib_read_char
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 32				# li	r2, 32
	beq	r1, r2, _beq_then.866
	addi	r2, r0, 9				# li	r2, 9
	beq	r1, r2, _beq_then.867
	addi	r2, r0, 13				# li	r2, 13
	beq	r1, r2, _beq_then.868
	addi	r2, r0, 10				# li	r2, 10
	beq	r1, r2, _beq_then.869
	addi	r2, r0, 26				# li	r2, 26
	beq	r1, r2, _beq_then.870
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_buffer_add_char				#	bl	lib_buffer_add_char
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	j lib_read_token
_beq_then.870:
	jr	r31				#	blr
_beq_then.869:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 0(r3)
	beq	r2, r1, _beq_then.872
	jr	r31				#	blr
_beq_then.872:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
_beq_then.868:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 0(r3)
	beq	r2, r1, _beq_then.874
	jr	r31				#	blr
_beq_then.874:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
_beq_then.867:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 0(r3)
	beq	r2, r1, _beq_then.876
	jr	r31				#	blr
_beq_then.876:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
_beq_then.866:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 0(r3)
	beq	r2, r1, _beq_then.878
	jr	r31				#	blr
_beq_then.878:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
lib_read_int:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_buffer_clear				#	bl	lib_buffer_clear
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal lib_read_token				#	bl lib_read_token
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	j	lib_buffer_to_int
lib_iter_div10_float:
	addi	r2, r0, 0				# li	r2, 0
	beq	r1, r2, _beq_then.880
	addi	r30, r0, 0	# to load float		10.000000
	lui	r30, r30, 16672
	fmvfr	f2, r30
	fdiv	f1, f1, f2
	addi	r2, r0, 1				# li	r2, 1
	sub	r1, r1, r2
	j lib_iter_div10_float
_beq_then.880:
	jr	r31				#	blr
lib_read_float:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_buffer_clear				#	bl	lib_buffer_clear
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal lib_read_token				#	bl lib_read_token
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 0				# li	r1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_buffer_get				#	bl	lib_buffer_get
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_buffer_to_int_of_float				#	bl	lib_buffer_to_int_of_float
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	lib_buffer_to_dec_of_float				#	bl	lib_buffer_to_dec_of_float
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	lib_buffer_to_ika_keta_of_float				#	bl	lib_buffer_to_ika_keta_of_float
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 45				# li	r2, 45
	lw	r5, 0(r3)
	beq	r5, r2, _beq_then.881
	lw	r2, 4(r3)
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal lib_float_of_int				#	bl lib_float_of_int
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	fmvtr	r30, f1
	sw	r30, 16(r3)				#stfd	f1, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 32
	jal lib_float_of_int				#	bl lib_float_of_int
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 32
	jal lib_iter_div10_float				#	bl lib_iter_div10_float
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	jr	r31				#	blr
_beq_then.881:
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f1, r30
	addi	r30, r0, 0	# to load float		-1.000000
	lui	r30, r30, 49024
	fmvfr	f1, r30
	lw	r2, 4(r3)
	fmvtr	r30, f1
	sw	r30, 24(r3)				#stfd	f1, 24(r3)
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 36(r3)
	addi	r3, r3, 40
	jal lib_float_of_int				#	bl lib_float_of_int
	addi	r30, r0, 40
	sub	r3, r3, r30
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 8(r3)
	fmvtr	r30, f1
	sw	r30, 32(r3)				#stfd	f1, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 48
	jal lib_float_of_int				#	bl lib_float_of_int
	addi	r30, r0, 48
	sub	r3, r3, r30
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 48
	jal lib_iter_div10_float				#	bl lib_iter_div10_float
	addi	r30, r0, 48
	sub	r3, r3, r30
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fadd	f1, f2, f1
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fmul	f1, f2, f1
	jr	r31				#	blr
lib_truncate:
	j	lib_ftoi
lib_abs_float:
	addi	r30, r0, 0	# to load float		0.000000
	lui	r30, r30, 0
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.882
 lib_fneg	f1, f1
	jr	r31				#	blr
_fle_then.882:
	jr	r31				#	blr
lib_print_dec:
	addi	r30, r0, 0	# to load float		0.000000
	lui	r30, r30, 0
	fmvfr	f2, r30
	feq	r30, f1, f2
	bne	r0, r30, _feq_then.883
	addi	r30, r0, 0	# to load float		10.000000
	lui	r30, r30, 16672
	fmvfr	f2, r30
	fmul	f1, f2, f1
	fmvtr	r30, f1
	sw	r30, 0(r3)				#stfd	f1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal lib_print_int				#	bl lib_print_int
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f1, 0(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal lib_float_of_int				#	bl lib_float_of_int
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	j lib_print_dec
_feq_then.883:
	jr	r31				#	blr
lib_print_float:
	fmvtr	r30, f1
	sw	r30, 0(r3)				#stfd	f1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal lib_print_int				#	bl lib_print_int
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 46				# li	r1, 46
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	lib_print_char				#	bl	lib_print_char
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f1, 0(r3)
	fmvfr	f1, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal lib_float_of_int				#	bl lib_float_of_int
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fsub	f1, f2, f1
	j lib_print_dec
