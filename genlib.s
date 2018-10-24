	.text
	.globl _min_caml_start
lib_putchar:
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
lib_print_num:
	addi	r1, r1, 48
	j	lib_putchar
lib_mul10:
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	jr	r31				#	blr
lib_lib_div10_sub:
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
	jal	lib_mul10				#	bl	lib_mul10
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 12(r3)
	ble	r1, r2, _ble_then.620
	lw	r1, 0(r3)
	lw	r5, 8(r3)
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	j	lib_lib_div10_sub
_ble_then.620:
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	lib_mul10				#	bl	lib_mul10
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r1, 9
	lw	r2, 12(r3)
	ble	r2, r1, _ble_then.621
	lw	r1, 8(r3)
	lw	r5, 4(r3)
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	j	lib_lib_div10_sub
_ble_then.621:
	lw	r1, 8(r3)
	jr	r31				#	blr
lib_div10:
	addi	r2, r0, 0				# li	r2, 0
	add	r5, r0, r1				# mr	r5, r1
	j	lib_lib_div10_sub
iter_lib_mul10:
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, _beq_then.622
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_mul10				#	bl	lib_mul10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j	iter_lib_mul10
_beq_then.622:
	jr	r31				#	blr
iter_lib_div10:
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, _beq_then.623
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_div10				#	bl	lib_div10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j	iter_lib_div10
_beq_then.623:
	jr	r31				#	blr
lib_lib_keta_sub:
	addi	r5, r0, 10				# li	r5, 10
	ble	r5, r1, _ble_then.624
	addi	r1, r2, 1
	jr	r31				#	blr
_ble_then.624:
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_div10				#	bl	lib_div10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	addi	r2, r2, 1
	j	lib_lib_keta_sub
lib_keta:
	addi	r2, r0, 0				# li	r2, 0
	j	lib_lib_keta_sub
lib_print_uint_lib_keta:
	addi	r5, r0, 1				# li	r5, 1
	beq	r2, r5, _beq_then.625
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
	jal	iter_lib_mul10				#	bl	iter_lib_mul10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	ble	r1, r2, _ble_then.626
	addi	r1, r0, 0				# li	r1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	lib_print_num				#	bl	lib_print_num
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 0(r3)
	sub	r2, r2, r1
	lw	r1, 4(r3)
	j	lib_print_uint_lib_keta
_ble_then.626:
	addi	r1, r0, 1				# li	r1, 1
	lw	r5, 0(r3)
	sub	r1, r5, r1
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	iter_lib_div10				#	bl	iter_lib_div10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	lib_print_num				#	bl	lib_print_num
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
	jal	iter_lib_mul10				#	bl	iter_lib_mul10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	sub	r1, r2, r1
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j	lib_print_uint_lib_keta
_beq_then.625:
	j	lib_print_num
lib_print_uint:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_keta				#	bl	lib_keta
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	j	lib_print_uint_lib_keta
lib_print_int:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, _ble_then.627
	addi	r2, r0, 45				# li	r2, 45
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_putchar				#	bl	lib_putchar
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	sub	r1, r0, r1
	j	lib_print_uint
_ble_then.627:
	j	lib_print_uint
lib_modulo_pi:
	addi	r30, r0, 4059	# to load float		3.141593
	lui	r30, r30, 16457
	fmvfr	f2, r30
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		6.283185
	lui	r30, r30, 16585
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.628
	addi	r30, r0, 0	# to load float		0.000000
	lui	r30, r30, 0
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.629
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		6.283185
	lui	r30, r30, 16585
	fmvfr	f2, r30
	fadd	f1, f1, f2
	j	lib_modulo_pi
_fle_then.629:
	jr	r31				#	blr
_fle_then.628:
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		6.283185
	lui	r30, r30, 16585
	fmvfr	f2, r30
	fsub	f1, f1, f2
	j	lib_modulo_pi
lib_lib_sin_body:
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
lib_lib_cos_body:
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
	bne	r0, r30, _fle_then.630
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f3, r30
	addi	r30, r0, 0	# to load float		-1.000000
	lui	r30, r30, 49024
	fmvfr	f3, r30
	j	fle_cont.631
_fle_then.630:
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f3, r30
fle_cont.631:
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	lib_modulo_pi				#	bl	lib_modulo_pi
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.632
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f3, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.633
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.634
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
	jal	lib_lib_cos_body				#	bl	lib_lib_cos_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.634:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	lib_lib_sin_body				#	bl	lib_lib_sin_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.633:
	fsub	f1, f2, f1
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.635
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
	jal	lib_lib_cos_body				#	bl	lib_lib_cos_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.635:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	lib_lib_sin_body				#	bl	lib_lib_sin_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.632:
	fsub	f1, f1, f2
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
	fneg	f3, f3
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f4, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f4, r30
	fle	r30, f4, f1
	bne	r0, r30, _fle_then.636
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.637
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
	jal	lib_lib_cos_body				#	bl	lib_lib_cos_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.637:
	fmvtr	r30, f3
	sw	r30, 16(r3)				#stfd	f3, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 32
	jal	lib_lib_sin_body				#	bl	lib_lib_sin_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.636:
	fsub	f1, f2, f1
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.638
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
	jal	lib_lib_cos_body				#	bl	lib_lib_cos_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.638:
	fmvtr	r30, f3
	sw	r30, 16(r3)				#stfd	f3, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 32
	jal	lib_lib_sin_body				#	bl	lib_lib_sin_body
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
	jal	lib_modulo_pi				#	bl	lib_modulo_pi
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.639
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f3, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.640
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.641
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
	jal	lib_lib_sin_body				#	bl	lib_lib_sin_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.641:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	lib_lib_cos_body				#	bl	lib_lib_cos_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.640:
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
	bne	r0, r30, _fle_then.642
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
	jal	lib_lib_sin_body				#	bl	lib_lib_sin_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.642:
	fmvtr	r30, f2
	sw	r30, 16(r3)				#stfd	f2, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 32
	jal	lib_lib_cos_body				#	bl	lib_lib_cos_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.639:
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
	bne	r0, r30, _fle_then.643
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.644
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
	jal	lib_lib_sin_body				#	bl	lib_lib_sin_body
	addi	r30, r0, 40
	sub	r3, r3, r30
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.644:
	fmvtr	r30, f3
	sw	r30, 24(r3)				#stfd	f3, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 40
	jal	lib_lib_cos_body				#	bl	lib_lib_cos_body
	addi	r30, r0, 40
	sub	r3, r3, r30
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.643:
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
	bne	r0, r30, _fle_then.645
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
	jal	lib_lib_sin_body				#	bl	lib_lib_sin_body
	addi	r30, r0, 48
	sub	r3, r3, r30
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.645:
	fmvtr	r30, f2
	sw	r30, 32(r3)				#stfd	f2, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 48
	jal	lib_lib_cos_body				#	bl	lib_lib_cos_body
	addi	r30, r0, 48
	sub	r3, r3, r30
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
lib_lib_atan_body:
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
	bne	r0, r30, _fle_then.646
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f2, r30
	addi	r30, r0, 0	# to load float		-1.000000
	lui	r30, r30, 49024
	fmvfr	f2, r30
	j	fle_cont.647
_fle_then.646:
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f2, r30
fle_cont.647:
	fmul	f1, f1, f2
	addi	r30, r0, 0	# to load float		4.375000
	lui	r30, r30, 16524
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.648
	j	lib_lib_atan_body
_fle_then.648:
	addi	r30, r0, 0	# to load float		2.437500
	lui	r30, r30, 16412
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.649
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
	jal	lib_lib_atan_body				#	bl	lib_lib_atan_body
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
_fle_then.649:
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
	jal	lib_lib_atan_body				#	bl	lib_lib_atan_body
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
	bne	r0, r30, _fle_then.650
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f2, r30
	fsub	f1, f1, f2
	jr	r31				#	blr
_fle_then.650:
	jr	r31				#	blr
lib_int_of_float:
	j	lib_ftoi
lib_float_of_int:
	j	lib_itof
lib_abs_float:
	addi	r30, r0, 0	# to load float		0.000000
	lui	r30, r30, 0
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.651
	fneg	f1, f1
	jr	r31				#	blr
_fle_then.651:
	jr	r31				#	blr
lib_truncate:
	j	lib_ftoi
# library ends
lib_print_num:
	addi	r1, r1, 48
	j	lib_putchar
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
	jal	lib_mul10				#	bl	lib_mul10
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 12(r3)
	ble	r1, r2, _ble_then.637
	lw	r1, 0(r3)
	lw	r5, 8(r3)
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	j	lib_div10_sub
_ble_then.637:
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	lib_mul10				#	bl	lib_mul10
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r1, 9
	lw	r2, 12(r3)
	ble	r2, r1, _ble_then.638
	lw	r1, 8(r3)
	lw	r5, 4(r3)
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	j	lib_div10_sub
_ble_then.638:
	lw	r1, 8(r3)
	jr	r31				#	blr
lib_div10:
	addi	r2, r0, 0				# li	r2, 0
	add	r5, r0, r1				# mr	r5, r1
	j	lib_div10_sub
iter_lib_mul10:
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, _beq_then.639
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_mul10				#	bl	lib_mul10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j	iter_lib_mul10
_beq_then.639:
	jr	r31				#	blr
iter_lib_div10:
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, _beq_then.640
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_div10				#	bl	lib_div10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j	iter_lib_div10
_beq_then.640:
	jr	r31				#	blr
lib_keta_sub:
	addi	r5, r0, 10				# li	r5, 10
	ble	r5, r1, _ble_then.641
	addi	r1, r2, 1
	jr	r31				#	blr
_ble_then.641:
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_div10				#	bl	lib_div10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	addi	r2, r2, 1
	j	lib_keta_sub
lib_keta:
	addi	r2, r0, 0				# li	r2, 0
	j	lib_keta_sub
lib_print_uint_lib_keta:
	addi	r5, r0, 1				# li	r5, 1
	beq	r2, r5, _beq_then.642
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
	jal	iter_lib_mul10				#	bl	iter_lib_mul10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	ble	r1, r2, _ble_then.643
	addi	r1, r0, 0				# li	r1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	lib_print_num				#	bl	lib_print_num
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 0(r3)
	sub	r2, r2, r1
	lw	r1, 4(r3)
	j	lib_print_uint_lib_keta
_ble_then.643:
	addi	r1, r0, 1				# li	r1, 1
	lw	r5, 0(r3)
	sub	r1, r5, r1
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	iter_lib_div10				#	bl	iter_lib_div10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	lib_print_num				#	bl	lib_print_num
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
	jal	iter_lib_mul10				#	bl	iter_lib_mul10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	sub	r1, r2, r1
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j	lib_print_uint_lib_keta
_beq_then.642:
	j	lib_print_num
lib_print_uint:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_keta				#	bl	lib_keta
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	j	lib_print_uint_lib_keta
lib_print_int:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, _ble_then.644
	addi	r2, r0, 45				# li	r2, 45
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_putchar				#	bl	lib_putchar
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	sub	r1, r0, r1
	j	lib_print_uint
_ble_then.644:
	j	lib_print_uint
lib_abs_float:
	addi	r30, r0, 0	# to load float		0.000000
	lui	r30, r30, 0
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.645
	fneg	f1, f1
	jr	r31				#	blr
_fle_then.645:
	jr	r31				#	blr
hoge.507:
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.646
	fadd	f1, f0, f2				# fmr	f1, f2
	jr	r31				#	blr
_fle_then.646:
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f3, r30
	fmul	f2, f3, f2
	j	hoge.507
fuga.511:
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f4, r30
	fmul	f4, f3, f4
	fle	r30, f4, f1
	bne	r0, r30, _fle_then.647
	jr	r31				#	blr
_fle_then.647:
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.648
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f4, r30
	fdiv	f2, f2, f4
	j	fuga.511
_fle_then.648:
	fsub	f1, f1, f2
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f4, r30
	fdiv	f2, f2, f4
	j	fuga.511
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
	jal	hoge.507				#	bl	hoge.507
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f1, 8(r3)
	fmvfr	f1, r30
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
	j	fuga.511
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
	bne	r0, r30, _fle_then.649
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f3, r30
	addi	r30, r0, 0	# to load float		-1.000000
	lui	r30, r30, 49024
	fmvfr	f3, r30
	j	fle_cont.650
_fle_then.649:
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f3, r30
fle_cont.650:
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
	jal	lib_modulo_2pi				#	bl	lib_modulo_2pi
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.651
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f3, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.652
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.653
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
	jal	lib_cos_body				#	bl	lib_cos_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.653:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	lib_sin_body				#	bl	lib_sin_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.652:
	fsub	f1, f2, f1
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.654
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
	jal	lib_cos_body				#	bl	lib_cos_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.654:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	lib_sin_body				#	bl	lib_sin_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.651:
	fsub	f1, f1, f2
	lw	r30, 0(r3)				#lfd	f3, 0(r3)
	fmvfr	f3, r30
	fneg	f3, f3
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f4, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f4, r30
	fle	r30, f4, f1
	bne	r0, r30, _fle_then.655
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.656
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
	jal	lib_cos_body				#	bl	lib_cos_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.656:
	fmvtr	r30, f3
	sw	r30, 16(r3)				#stfd	f3, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 32
	jal	lib_sin_body				#	bl	lib_sin_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.655:
	fsub	f1, f2, f1
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.657
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
	jal	lib_cos_body				#	bl	lib_cos_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.657:
	fmvtr	r30, f3
	sw	r30, 16(r3)				#stfd	f3, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 32
	jal	lib_sin_body				#	bl	lib_sin_body
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
	jal	lib_modulo_2pi				#	bl	lib_modulo_2pi
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fle	r30, f2, f1
	bne	r0, r30, _fle_then.658
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f3, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.659
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.660
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
	jal	lib_sin_body				#	bl	lib_sin_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.660:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	lib_cos_body				#	bl	lib_cos_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.659:
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
	bne	r0, r30, _fle_then.661
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
	jal	lib_sin_body				#	bl	lib_sin_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.661:
	fmvtr	r30, f2
	sw	r30, 16(r3)				#stfd	f2, 16(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 28(r3)
	addi	r3, r3, 32
	jal	lib_cos_body				#	bl	lib_cos_body
	addi	r30, r0, 32
	sub	r3, r3, r30
	lw	r30, 28(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 16(r3)				#lfd	f2, 16(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.658:
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
	bne	r0, r30, _fle_then.662
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	r30, f1, f2
	bne	r0, r30, _fle_then.663
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
	jal	lib_sin_body				#	bl	lib_sin_body
	addi	r30, r0, 40
	sub	r3, r3, r30
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.663:
	fmvtr	r30, f3
	sw	r30, 24(r3)				#stfd	f3, 24(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 36(r3)
	addi	r3, r3, 40
	jal	lib_cos_body				#	bl	lib_cos_body
	addi	r30, r0, 40
	sub	r3, r3, r30
	lw	r30, 36(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 24(r3)				#lfd	f2, 24(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.662:
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
	bne	r0, r30, _fle_then.664
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
	jal	lib_sin_body				#	bl	lib_sin_body
	addi	r30, r0, 48
	sub	r3, r3, r30
	lw	r30, 44(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 32(r3)				#lfd	f2, 32(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_then.664:
	fmvtr	r30, f2
	sw	r30, 32(r3)				#stfd	f2, 32(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 44(r3)
	addi	r3, r3, 48
	jal	lib_cos_body				#	bl	lib_cos_body
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
	bne	r0, r30, _fle_then.665
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f2, r30
	addi	r30, r0, 0	# to load float		-1.000000
	lui	r30, r30, 49024
	fmvfr	f2, r30
	j	fle_cont.666
_fle_then.665:
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f2, r30
fle_cont.666:
	fmul	f1, f1, f2
	addi	r30, r0, 0	# to load float		4.375000
	lui	r30, r30, 16524
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.667
	j	lib_atan_body
_fle_then.667:
	addi	r30, r0, 0	# to load float		2.437500
	lui	r30, r30, 16412
	fmvfr	f3, r30
	fle	r30, f3, f1
	bne	r0, r30, _fle_then.668
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
	jal	lib_atan_body				#	bl	lib_atan_body
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
_fle_then.668:
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
	jal	lib_atan_body				#	bl	lib_atan_body
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
	bne	r0, r30, _fle_then.669
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f2, r30
	fsub	f1, f1, f2
	jr	r31				#	blr
_fle_then.669:
	jr	r31				#	blr
lib_int_of_float:
	j	lib_ftoi
lib_float_of_int:
	j	lib_itof
lib_truncate:
	j	lib_ftoi
_min_caml_start: # main entry point
#	main program starts
	addi	r3, r0, 0
	addi	r4, r0, 30000
	add	r4, r4, r4
	addi	r1, r0, 32				# li	r1, 32
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	lib_print_int				#	bl	lib_print_int
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
