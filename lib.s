putchar:
  out r1
  jr  r31
itof:
  itof  r1
  jr  r31
ftoi:
  ftoi  r1
  jr  r31
sqrt:
  sqrt  r1
  jr  r31
print_num:
	addi	r1, r1, 48
	j	putchar
mul10:
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	jr	r31				#	blr
div10_sub:
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
	jal	mul10				#	bl	mul10
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 12(r3)
	fle	r1, r2, fle_then.495
	lw	r1, 0(r3)
	lw	r5, 8(r3)
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	j	div10_sub
fle_then.495:
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	mul10				#	bl	mul10
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r1, 9
	lw	r2, 12(r3)
	fle	r2, r1, fle_then.496
	lw	r1, 8(r3)
	lw	r5, 4(r3)
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	j	div10_sub
fle_then.496:
	lw	r1, 8(r3)
	jr	r31				#	blr
div10:
	addi	r2, r0, 0				# li	r2, 0
	add	r5, r0, r1				# mr	r5, r1
	j	div10_sub
iter_mul10:
	addi	r5, r0, 0				# li	r5, 0
	feq	r2, r5, feq_then.497
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	mul10				#	bl	mul10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j	iter_mul10
feq_then.497:
	jr	r31				#	blr
iter_div10:
	addi	r5, r0, 0				# li	r5, 0
	feq	r2, r5, feq_then.498
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	div10				#	bl	div10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j	iter_div10
feq_then.498:
	jr	r31				#	blr
keta_sub:
	addi	r5, r0, 10				# li	r5, 10
	fle	r5, r1, fle_then.499
	addi	r1, r2, 1
	jr	r31				#	blr
fle_then.499:
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	div10				#	bl	div10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	addi	r2, r2, 1
	j	keta_sub
keta:
	addi	r2, r0, 0				# li	r2, 0
	j	keta_sub
print_uint_keta:
	addi	r5, r0, 1				# li	r5, 1
	feq	r2, r5, feq_then.500
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
	jal	iter_mul10				#	bl	iter_mul10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	fle	r1, r2, fle_then.501
	addi	r1, r0, 0				# li	r1, 0
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	print_num				#	bl	print_num
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 0(r3)
	sub	r2, r2, r1
	lw	r1, 4(r3)
	j	print_uint_keta
fle_then.501:
	addi	r1, r0, 1				# li	r1, 1
	lw	r5, 0(r3)
	sub	r1, r5, r1
	addi	r30, r31, 0				#mflr	r30
	add	r27, r0, r2				# mr	r27, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r27				# mr	r1, r27
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	iter_div10				#	bl	iter_div10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	print_num				#	bl	print_num
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
	jal	iter_mul10				#	bl	iter_mul10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 4(r3)
	sub	r1, r2, r1
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j	print_uint_keta
feq_then.500:
	j	print_num
print_uint:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	keta				#	bl	keta
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	j	print_uint_keta
print_int:
	addi	r2, r0, 0				# li	r2, 0
	fle	r2, r1, fle_then.502
	addi	r2, r0, 45				# li	r2, 45
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	putchar				#	bl	putchar
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	sub	r1, r0, r1
	j	print_uint
fle_then.502:
	j	print_uint
modulo_pi:
	addi	r30, r0, 4059	# to load float		3.141593
	lui	r30, r30, 16457
	fmvfr	f2, r30
	fle	f1, f2, fle_then.503
	fsub	f1, f1, f2
	j	modulo_pi
fle_then.503:
	addi	r30, r0, 4059	# to load float		-3.141593
	lui	r30, r30, 49225
	fmvfr	f3, r30
	fle	f1, f3, fle_then.504
	jr	r31				#	blr
fle_then.504:
	fadd	f1, f1, f2
	j	modulo_pi
sin_body:
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
cos_body:
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
sin:
	addi	r30, r0, 4059	# to load float		3.141593
	lui	r30, r30, 16457
	fmvfr	f2, r30
	addi	r30, r0, 0	# to load float		0.000000
	lui	r30, r30, 0
	fmvfr	f3, r30
	fle	f3, f1, fle_then.505
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f3, r30
	addi	r30, r0, 0	# to load float		-1.000000
	lui	r30, r30, 49024
	fmvfr	f3, r30
	j	fle_cont.506
fle_then.505:
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f3, r30
fle_cont.506:
	fmvtr	r30, f3
	sw	r30, 0(r3)				#stfd	f3, 0(r3)
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	modulo_pi				#	bl	modulo_pi
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fle	f2, f1, fle_then.507
	j	fle_cont.508
fle_then.507:
	fsub	f3, f1, f2
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f3, r30
	lw	r30, 0(r3)				#lfd	f4, 0(r3)
	fmvfr	f4, r30
	fsub	f3, f3, f4
fle_cont.508:
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f3, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f3, r30
	fle	f3, f1, fle_then.509
	j	fle_cont.510
fle_then.509:
	fsub	f2, f1, f2
fle_cont.510:
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	f1, f2, fle_then.511
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
	jal	cos_body				#	bl	cos_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_then.511:
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	sin_body				#	bl	sin_body
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fmul	f1, f1, f2
	jr	r31				#	blr
cos:
	addi	r30, r0, 4059	# to load float		3.141593
	lui	r30, r30, 16457
	fmvfr	f2, r30
	addi	r30, r0, 0	# to load float		0.000000
	lui	r30, r30, 0
	fmvfr	f3, r30
	fle	f3, f1, fle_then.512
	addi	r1, r0, 1				# li	r1, 1
	j	fle_cont.513
fle_then.512:
	addi	r1, r0, 0				# li	r1, 0
fle_cont.513:
	sw	r1, 0(r3)
	fmvtr	r30, f2
	sw	r30, 8(r3)				#stfd	f2, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	modulo_pi				#	bl	modulo_pi
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 8(r3)				#lfd	f2, 8(r3)
	fmvfr	f2, r30
	fle	f2, f1, fle_then.515
	j	fle_cont.516
fle_then.515:
	fsub	f3, f1, f2
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 0(r3)
	sub	r1, r1, r2
fle_cont.516:
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f3, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f3, r30
	fle	f3, f1, fle_then.517
	j	fle_cont.518
fle_then.517:
	fsub	f2, f1, f2
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 0(r3)
	sub	r1, r1, r2
fle_cont.518:
	addi	r30, r0, 0	# to load float		4.000000
	lui	r30, r30, 16512
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		0.785398
	lui	r30, r30, 16201
	fmvfr	f2, r30
	fle	f1, f2, fle_then.519
	addi	r30, r0, 0	# to load float		2.000000
	lui	r30, r30, 16384
	fmvfr	f2, r30
	addi	r30, r0, 4059	# to load float		1.570796
	lui	r30, r30, 16329
	fmvfr	f2, r30
	fsub	f1, f2, f1
	j	sin_body
fle_then.519:
	j	cos_body
atan_body:
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
atan:
	addi	r30, r0, 4059	# to load float		3.141593
	lui	r30, r30, 16457
	fmvfr	f2, r30
	addi	r30, r0, 0	# to load float		0.000000
	lui	r30, r30, 0
	fmvfr	f2, r30
	fle	f2, f1, fle_then.520
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f2, r30
	addi	r30, r0, 0	# to load float		-1.000000
	lui	r30, r30, 49024
	fmvfr	f2, r30
	j	fle_cont.521
fle_then.520:
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f2, r30
fle_cont.521:
	fmul	f1, f1, f2
	addi	r30, r0, 0	# to load float		4.375000
	lui	r30, r30, 16524
	fmvfr	f3, r30
	fle	f3, f1, fle_then.522
	j	atan_body
fle_then.522:
	addi	r30, r0, 0	# to load float		2.437500
	lui	r30, r30, 16412
	fmvfr	f3, r30
	fle	f3, f1, fle_then.523
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
	jal	atan_body				#	bl	atan_body
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
fle_then.523:
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
	jal	atan_body				#	bl	atan_body
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
floor.238:
	fmvtr	r30, f1
	sw	r30, 0(r3)				#stfd	f1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	ftoi				#	bl	ftoi
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	itof				#	bl	itof
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r30, 0(r3)				#lfd	f2, 0(r3)
	fmvfr	f2, r30
	fle	f1, f2, fle_then.524
	addi	r30, r0, 0	# to load float		1.000000
	lui	r30, r30, 16256
	fmvfr	f2, r30
	fsub	f1, f1, f2
	jr	r31				#	blr
fle_then.524:
	jr	r31				#	blr
