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
	beq	r0, r30, _fle_else.878
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
_fle_else.878:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
lib_fisneg:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.879
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
_fle_else.879:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
lib_fiszero:
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, _feq_else.880
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
_feq_else.880:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
lib_xor:
	beq	r1, r2, _beq_then.881
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
_beq_then.881:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
lib_fhalf:
	flup	f2, 1		# fli	f2, 0.500000
	fmul	f1, f1, f2
	jr	r31				#	blr
lib_fsqr:
	fmul	f1, f1, f1
	jr	r31				#	blr
lib_fabs:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.882
	jr	r31				#	blr
_fle_else.882:
 lib_fneg	f1, f1
	jr	r31				#	blr
lib_floor:
	fsw	f1, 0(r3)				
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
	flw	f2, 0(r3)				
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.883
	jr	r31				#	blr
_fle_else.883:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
	jr	r31				#	blr
lib_int_of_float:
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, _feq_else.884
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
_feq_else.884:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.885
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	j	lib_ftoi
_fle_else.885:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	j	lib_ftoi
lib_float_of_int:
	j	lib_itof
lib_hoge:
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.886
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.887
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j lib_hoge
_fle_else.887:
	fadd	f1, f0, f2				# fmr	f1, f2
	jr	r31				#	blr
_fle_else.886:
	fadd	f1, f0, f2				# fmr	f1, f2
	jr	r31				#	blr
lib_fuga:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.888
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.889
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j lib_fuga
_fle_else.889:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j lib_fuga
_fle_else.888:
	jr	r31				#	blr
lib_modulo_2pi:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 3		# fli	f2, 2.000000
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 0(r3)				
	fsw	f1, 2(r3)				
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.890
	flup	f2, 3		# fli	f2, 2.000000
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_hoge				#	bl lib_hoge
	addi	r3, r3, -5
	lw	r30, 4(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	add	r31, r0, r30				#mtlr	r30
	j	_fle_cont.891
_fle_else.890:
_fle_cont.891:
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
	jr	r31				#	blr
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
	jr	r31				#	blr
lib_sin:
	flup	f2, 14		# fli	f2, 3.141593
	flup	f3, 0		# fli	f3, 0.000000
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.892
	flup	f3, 2		# fli	f3, 1.000000
	j	_fle_cont.893
_fle_else.892:
	flup	f3, 2		# fli	f3, 1.000000
	flup	f3, 11		# fli	f3, -1.000000
_fle_cont.893:
	fsw	f3, 0(r3)				
	fsw	f2, 2(r3)				
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
	flw	f2, 2(r3)				
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.894
	fsub	f1, f1, f2
	flw	f3, 0(r3)				
 lib_fneg	f3, f3
	flup	f4, 3		# fli	f4, 2.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.895
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.896
	fsw	f3, 4(r3)				
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 4(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.896:
	flup	f2, 3		# fli	f2, 2.000000
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 4(r3)				
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 4(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.895:
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.897
	fsw	f3, 4(r3)				
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 4(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.897:
	flup	f2, 3		# fli	f2, 2.000000
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 4(r3)				
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 4(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.894:
	flup	f3, 3		# fli	f3, 2.000000
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.898
	fsub	f1, f2, f1
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.899
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.899:
	flup	f2, 3		# fli	f2, 2.000000
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.898:
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.900
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.900:
	flup	f2, 3		# fli	f2, 2.000000
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
lib_cos:
	flup	f2, 14		# fli	f2, 3.141593
	flup	f3, 2		# fli	f3, 1.000000
	fsw	f3, 0(r3)				
	fsw	f2, 2(r3)				
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
	flw	f2, 2(r3)				
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.901
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 3		# fli	f4, 2.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.902
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f3, r30
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, _fle_else.903
	fsw	f2, 4(r3)				
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 4(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.903:
	flup	f3, 3		# fli	f3, 2.000000
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fsw	f2, 4(r3)				
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 4(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.902:
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.904
	fsw	f3, 6(r3)				
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 6(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.904:
	flup	f2, 3		# fli	f2, 2.000000
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 6(r3)				
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 8(r3)
	addi	r3, r3, 9
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -9
	lw	r30, 8(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 6(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.901:
	flup	f3, 3		# fli	f3, 2.000000
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.905
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f3, r30
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, _fle_else.906
	fsw	f2, 8(r3)				
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 8(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.906:
	flup	f3, 3		# fli	f3, 2.000000
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fsw	f2, 8(r3)				
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 8(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.905:
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f2, r30
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.907
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.907:
	flup	f2, 3		# fli	f2, 2.000000
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 10(r3)
	addi	r3, r3, 11
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -11
	lw	r30, 10(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
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
	jr	r31				#	blr
lib_atan:
	flup	f2, 14		# fli	f2, 3.141593
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.908
	flup	f2, 2		# fli	f2, 1.000000
	j	_fle_cont.909
_fle_else.908:
	flup	f2, 2		# fli	f2, 1.000000
	flup	f2, 11		# fli	f2, -1.000000
_fle_cont.909:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.910
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.911
	flup	f3, 3		# fli	f3, 2.000000
	flup	f3, 15		# fli	f3, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	fsw	f2, 0(r3)				
	fsw	f3, 2(r3)				
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 5
	jal lib_atan_body				#	bl lib_atan_body
	addi	r3, r3, -5
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 2(r3)				
	fadd	f1, f2, f1
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.911:
	addi	r30, r0, 0
	lui	r30, r30, 16512	# to load float		4.000000
	fmvfr	f3, r30
	flup	f3, 16		# fli	f3, 0.785398
	flup	f4, 2		# fli	f4, 1.000000
	fsub	f4, f1, f4
	flup	f5, 2		# fli	f5, 1.000000
	fadd	f1, f1, f5
	fdiv	f1, f4, f1
	fsw	f2, 0(r3)				
	fsw	f3, 4(r3)				
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 6(r3)
	addi	r3, r3, 7
	jal lib_atan_body				#	bl lib_atan_body
	addi	r3, r3, -7
	lw	r30, 6(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f2, 4(r3)				
	fadd	f1, f2, f1
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
_fle_else.910:
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
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	ble	r7, r1, _ble_then.912
	add	r5, r0, r6				# mr	r5, r6
	j lib_div10_sub
_ble_then.912:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, _ble_then.913
	add	r2, r0, r6				# mr	r2, r6
	j lib_div10_sub
_ble_then.913:
	add	r1, r0, r6				# mr	r1, r6
	jr	r31				#	blr
lib_div10:
	addi	r2, r0, 0				# li	r2, 0
	add	r5, r0, r1				# mr	r5, r1
	j lib_div10_sub
lib_iter_mul10:
	beqi	0, r2, _beq_then.914
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	j lib_iter_mul10
_beq_then.914:
	jr	r31				#	blr
lib_iter_div10:
	beqi	0, r2, _beq_then.915
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
	addi	r2, r2, -1
	j lib_iter_div10
_beq_then.915:
	jr	r31				#	blr
lib_keta_sub:
	addi	r5, r0, 10				# li	r5, 10
	ble	r5, r1, _ble_then.916
	addi	r1, r2, 1
	jr	r31				#	blr
_ble_then.916:
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
	beqi	1, r2, _beq_then.917
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
	ble	r1, r2, _ble_then.918
	addi	r1, r0, 48				# li	r1, 48
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	addi	r2, r1, -1
	lw	r1, 1(r3)
	j lib_print_uint_keta
_ble_then.918:
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
_beq_then.917:
	addi	r1, r1, 48
	j	lib_print_char
lib_print_uint:
	addi	r2, r0, 10				# li	r2, 10
	ble	r2, r1, _ble_then.919
	addi	r1, r1, 48
	j	lib_print_char
_ble_then.919:
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
	ble	r2, r1, _ble_then.920
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
_ble_then.920:
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
	beq	r1, r2, _beq_then.921
	beqi	9, r1, _beq_then.922
	beqi	13, r1, _beq_then.923
	beqi	10, r1, _beq_then.924
	addi	r2, r0, 26				# li	r2, 26
	beq	r1, r2, _beq_then.925
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 1(r3)
	addi	r3, r3, 2
	jal	lib_buffer_add_char				#	bl	lib_buffer_add_char
	addi	r3, r3, -2
	lw	r30, 1(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	j lib_read_token
_beq_then.925:
	jr	r31				#	blr
_beq_then.924:
	lw	r1, 0(r3)
	beqi	0, r1, _beq_then.927
	jr	r31				#	blr
_beq_then.927:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
_beq_then.923:
	lw	r1, 0(r3)
	beqi	0, r1, _beq_then.929
	jr	r31				#	blr
_beq_then.929:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
_beq_then.922:
	lw	r1, 0(r3)
	beqi	0, r1, _beq_then.931
	jr	r31				#	blr
_beq_then.931:
	addi	r1, r0, 0				# li	r1, 0
	j lib_read_token
_beq_then.921:
	lw	r1, 0(r3)
	beqi	0, r1, _beq_then.933
	jr	r31				#	blr
_beq_then.933:
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
	beqi	0, r1, _beq_then.935
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	j lib_iter_div10_float
_beq_then.935:
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
	beq	r5, r2, _beq_then.936
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
	fsw	f1, 4(r3)				
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
	flw	f2, 4(r3)				
	fadd	f1, f2, f1
	jr	r31				#	blr
_beq_then.936:
	flup	f1, 2		# fli	f1, 1.000000
	flup	f1, 11		# fli	f1, -1.000000
	lw	r2, 1(r3)
	fsw	f1, 6(r3)				
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
	fsw	f1, 8(r3)				
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
	flw	f2, 8(r3)				
	fadd	f1, f2, f1
	flw	f2, 6(r3)				
	fmul	f1, f2, f1
	jr	r31				#	blr
lib_truncate:
	j lib_int_of_float
lib_abs_float:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.937
	jr	r31				#	blr
_fle_else.937:
 lib_fneg	f1, f1
	jr	r31				#	blr
lib_print_dec:
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, _feq_else.938
	jr	r31				#	blr
_feq_else.938:
	flup	f2, 39		# fli	f2, 10.000000
	fmul	f1, f2, f1
	fsw	f1, 0(r3)				
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
	flw	f1, 0(r3)				
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
	flw	f2, 0(r3)				
	fsub	f1, f2, f1
	j lib_print_dec
lib_print_ufloat:
	fsw	f1, 0(r3)				
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
	flw	f1, 0(r3)				
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
	flw	f2, 0(r3)				
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.940
	j	_fle_cont.941
_fle_else.940:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f1, f1, f3
_fle_cont.941:
	fsub	f1, f2, f1
	j lib_print_dec
lib_print_float:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.942
	j lib_print_ufloat
_fle_else.942:
	addi	r1, r0, 45				# li	r1, 45
	fsw	f1, 0(r3)				
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -3
	lw	r30, 2(r3)
	add	r31, r0, r30				#mtlr	r30
	flw	f1, 0(r3)				
 lib_fneg	f1, f1
	j lib_print_ufloat
_R_0:
# library ends
hoge.6699:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11257
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11258
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11259
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11260
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.6699
fle_else.11260:
	fadd	f1, f0, f2				# fmr	f1, f2
	jr	r31				#	blr
fle_else.11259:
	fadd	f1, f0, f2				# fmr	f1, f2
	jr	r31				#	blr
fle_else.11258:
	fadd	f1, f0, f2				# fmr	f1, f2
	jr	r31				#	blr
fle_else.11257:
	fadd	f1, f0, f2				# fmr	f1, f2
	jr	r31				#	blr
fuga.6703:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11261
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11262
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11263
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11264
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.6703
fle_else.11264:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.6703
fle_else.11263:
	jr	r31				#	blr
fle_else.11262:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11265
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11266
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.6703
fle_else.11266:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.6703
fle_else.11265:
	jr	r31				#	blr
fle_else.11261:
	jr	r31				#	blr
modulo_2pi.2758:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 0(r3)				
	fsw	f1, 2(r3)				
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11267
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11269
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11271
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	hoge.6699				#	bl	hoge.6699
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	fle_cont.11272
fle_else.11271:
	fadd	f1, f0, f2				# fmr	f1, f2
fle_cont.11272:
	j	fle_cont.11270
fle_else.11269:
	fadd	f1, f0, f2				# fmr	f1, f2
fle_cont.11270:
	j	fle_cont.11268
fle_else.11267:
	fadd	f1, f0, f2				# fmr	f1, f2
fle_cont.11268:
	flup	f2, 5		# fli	f2, 6.283186
	flw	f3, 2(r3)				
	fle	r30, f2, f3
	beq	r0, r30, fle_else.11273
	fle	r30, f1, f3
	beq	r0, r30, fle_else.11274
	fsub	f2, f3, f1
	flup	f3, 3		# fli	f3, 2.000000
	fdiv	f1, f1, f3
	flw	f3, 0(r3)				
	fadd	f30, f0, f2				# fmr	f30, f2
	fadd	f2, f0, f1				# fmr	f2, f1
	fadd	f1, f0, f30				# fmr	f1, f30
	j	fuga.6703
fle_else.11274:
	flup	f2, 3		# fli	f2, 2.000000
	fdiv	f2, f1, f2
	flw	f1, 0(r3)				
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f30				# fmr	f1, f30
	j	fuga.6703
fle_else.11273:
	fadd	f1, f0, f3				# fmr	f1, f3
	jr	r31				#	blr
sin_body.2760:
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
	jr	r31				#	blr
cos_body.2762:
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
	jr	r31				#	blr
sin.2764:
	flup	f2, 14		# fli	f2, 3.141593
	flup	f3, 0		# fli	f3, 0.000000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11275
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.11276
fle_else.11275:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.11276:
	fsw	f3, 0(r3)				
	fsw	f2, 2(r3)				
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				#	bl	lib_abs_float
	addi	r3, r3, -5
	lw	r31, 4(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	modulo_2pi.2758				#	bl	modulo_2pi.2758
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)				
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11277
	fsub	f1, f1, f2
	flw	f3, 0(r3)				
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11278
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11279
	fsw	f3, 4(r3)				
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11279:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 4(r3)				
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11278:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11280
	fsw	f3, 4(r3)				
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11280:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 4(r3)				
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11277:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11281
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11282
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11282:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11281:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11283
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11283:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
cos.2766:
	flup	f2, 14		# fli	f2, 3.141593
	flup	f3, 2		# fli	f3, 1.000000
	fsw	f3, 0(r3)				
	fsw	f2, 2(r3)				
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				#	bl	lib_abs_float
	addi	r3, r3, -5
	lw	r31, 4(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	modulo_2pi.2758				#	bl	modulo_2pi.2758
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)				
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11284
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11285
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.11286
	fsw	f2, 4(r3)				
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11286:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fsw	f2, 4(r3)				
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11285:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11287
	fsw	f3, 6(r3)				
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11287:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 6(r3)				
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11284:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11288
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.11289
	fsw	f2, 8(r3)				
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11289:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fsw	f2, 8(r3)				
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11288:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11290
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos_body.2762				#	bl	cos_body.2762
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11290:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2760				#	bl	sin_body.2760
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
atan_body.2768:
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
	jr	r31				#	blr
atan.2770:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11291
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.11292
fle_else.11291:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.11292:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11293
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11294
	flup	f3, 15		# fli	f3, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	fsw	f2, 0(r3)				
	fsw	f3, 2(r3)				
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan_body.2768				#	bl	atan_body.2768
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)				
	fadd	f1, f2, f1
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11294:
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
	jal	atan_body.2768				#	bl	atan_body.2768
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)				
	fadd	f1, f2, f1
	flw	f2, 0(r3)				
	fmul	f1, f1, f2
	jr	r31				#	blr
fle_else.11293:
	j	atan_body.2768
div10_sub.2776:
	add	r6, r2, r5
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.11295
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r7, r5, 3
	slli	r8, r5, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.11296
	j	div10_sub.2776
ble_then.11296:
	slli	r2, r5, 3
	slli	r7, r5, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.11297
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	j	div10_sub.2776
ble_then.11297:
	add	r1, r0, r5				# mr	r1, r5
	jr	r31				#	blr
ble_then.11295:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.11298
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r7, r2, 3
	slli	r8, r2, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.11299
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r6				# mr	r2, r6
	j	div10_sub.2776
ble_then.11299:
	slli	r6, r2, 3
	slli	r7, r2, 1
	add	r6, r6, r7
	addi	r6, r6, 9
	ble	r1, r6, ble_then.11300
	j	div10_sub.2776
ble_then.11300:
	add	r1, r0, r2				# mr	r1, r2
	jr	r31				#	blr
ble_then.11298:
	add	r1, r0, r6				# mr	r1, r6
	jr	r31				#	blr
div10.2780:
	addi	r2, r0, 0				# li	r2, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.11301
	j	div10_sub.2776
ble_then.11301:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.11302
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	j	div10_sub.2776
ble_then.11302:
	add	r1, r0, r5				# mr	r1, r5
	jr	r31				#	blr
print_uint.2796:
	addi	r2, r0, 10				# li	r2, 10
	ble	r2, r1, ble_then.11303
	addi	r1, r1, 48
	j	lib_print_char
ble_then.11303:
	addi	r2, r0, 0				# li	r2, 0
	sw	r1, 0(r3)
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10_sub.2776				#	bl	div10_sub.2776
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 10				# li	r2, 10
	sw	r1, 1(r3)
	ble	r2, r1, ble_then.11304
	addi	r2, r1, 48
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.11305
ble_then.11304:
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10.2780				#	bl	div10.2780
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2796				#	bl	print_uint.2796
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 1(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -4
	lw	r31, 3(r3)
ble_cont.11305:
	lw	r1, 1(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	j	lib_print_char
print_int.2798:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.11306
	addi	r2, r0, 45				# li	r2, 45
	sw	r1, 0(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	sub	r1, r0, r1
	addi	r2, r0, 10				# li	r2, 10
	ble	r2, r1, ble_then.11307
	addi	r1, r1, 48
	j	lib_print_char
ble_then.11307:
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10.2780				#	bl	div10.2780
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2796				#	bl	print_uint.2796
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 1(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	j	lib_print_char
ble_then.11306:
	addi	r2, r0, 10				# li	r2, 10
	ble	r2, r1, ble_then.11308
	addi	r1, r1, 48
	j	lib_print_char
ble_then.11308:
	sw	r1, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10.2780				#	bl	div10.2780
	addi	r3, r3, -4
	lw	r31, 3(r3)
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	print_uint.2796				#	bl	print_uint.2796
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	j	lib_print_char
veccpy.2872:
	flw	f1, 0(r2)
	fsw	f1, 0(r1)
	flw	f1, 1(r2)
	fsw	f1, 1(r1)
	flw	f1, 2(r2)
	fsw	f1, 2(r1)
	jr	r31				#	blr
vecunit_sgn.2880:
	flw	f1, 0(r1)
	fmul	f1, f1, f1
	flw	f2, 1(r1)
	fmul	f2, f2, f2
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	fmul	f2, f2, f2
	fadd	f1, f1, f2
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11310
	addi	r1, r0, 1				# li	r1, 1
	j	feq_cont.11311
feq_else.11310:
	addi	r1, r0, 0				# li	r1, 0
feq_cont.11311:
	beqi	0, r1, beq_then.11312
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.11313
beq_then.11312:
	lw	r1, 1(r3)
	beqi	0, r1, beq_then.11314
	flup	f2, 11		# fli	f2, -1.000000
	fdiv	f1, f2, f1
	j	beq_cont.11315
beq_then.11314:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
beq_cont.11315:
beq_cont.11313:
	lw	r1, 0(r3)
	flw	f2, 0(r1)
	fmul	f2, f2, f1
	fsw	f2, 0(r1)
	flw	f2, 1(r1)
	fmul	f2, f2, f1
	fsw	f2, 1(r1)
	flw	f2, 2(r1)
	fmul	f1, f2, f1
	fsw	f1, 2(r1)
	jr	r31				#	blr
veciprod.2883:
	flw	f1, 0(r1)
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
	jr	r31				#	blr
veciprod2.2886:
	flw	f4, 0(r1)
	fmul	f1, f4, f1
	flw	f4, 1(r1)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	jr	r31				#	blr
vecaccum.2891:
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
	jr	r31				#	blr
vecadd.2895:
	flw	f1, 0(r1)
	flw	f2, 0(r2)
	fadd	f1, f1, f2
	fsw	f1, 0(r1)
	flw	f1, 1(r1)
	flw	f2, 1(r2)
	fadd	f1, f1, f2
	fsw	f1, 1(r1)
	flw	f1, 2(r1)
	flw	f2, 2(r2)
	fadd	f1, f1, f2
	fsw	f1, 2(r1)
	jr	r31				#	blr
vecscale.2901:
	flw	f2, 0(r1)
	fmul	f2, f2, f1
	fsw	f2, 0(r1)
	flw	f2, 1(r1)
	fmul	f2, f2, f1
	fsw	f2, 1(r1)
	flw	f2, 2(r1)
	fmul	f1, f2, f1
	fsw	f1, 2(r1)
	jr	r31				#	blr
vecaccumv.2904:
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
	jr	r31				#	blr
read_screen_settings.2981:
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
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)				
	fsw	f1, 8(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin.2764				#	bl	sin.2764
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
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)				
	fsw	f1, 14(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	sin.2764				#	bl	sin.2764
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
	jr	r31				#	blr
read_light.2983:
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
	jal	sin.2764				#	bl	sin.2764
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
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)				
	fsw	f1, 6(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2764				#	bl	sin.2764
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)				
	fmul	f1, f2, f1
	lw	r1, 1(r3)
	fsw	f1, 0(r1)
	flw	f1, 4(r3)				
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos.2766				#	bl	cos.2766
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
	jr	r31				#	blr
rotate_quadratic_matrix.2985:
	flw	f1, 0(r2)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	fsw	f1, 2(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2764				#	bl	sin.2764
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 4(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 6(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2764				#	bl	sin.2764
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 8(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 10(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2764				#	bl	sin.2764
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
	jr	r31				#	blr
read_nth_object.2988:
	lw	r2, 1(r29)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.11325
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
	addi	r2, r0, 3				# li	r2, 3
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
	addi	r2, r0, 3				# li	r2, 3
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
	beq	r0, r30, fle_else.11326
	addi	r1, r0, 0				# li	r1, 0
	j	fle_cont.11327
fle_else.11326:
	addi	r1, r0, 1				# li	r1, 1
fle_cont.11327:
	addi	r2, r0, 2				# li	r2, 2
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
	addi	r2, r0, 3				# li	r2, 3
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
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 5(r3)
	beqi	0, r2, beq_then.11328
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
	j	beq_cont.11329
beq_then.11328:
beq_cont.11329:
	lw	r2, 3(r3)
	beqi	2, r2, beq_then.11330
	lw	r5, 8(r3)
	j	beq_cont.11331
beq_then.11330:
	addi	r5, r0, 1				# li	r5, 1
beq_cont.11331:
	addi	r6, r0, 4				# li	r6, 4
	flup	f1, 0		# fli	f1, 0.000000
	sw	r5, 12(r3)
	sw	r1, 11(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -14
	lw	r31, 13(r3)
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
	beqi	3, r7, beq_then.11332
	beqi	2, r7, beq_then.11334
	j	beq_cont.11335
beq_then.11334:
	lw	r2, 8(r3)
	beqi	0, r2, beq_then.11336
	addi	r2, r0, 0				# li	r2, 0
	j	beq_cont.11337
beq_then.11336:
	addi	r2, r0, 1				# li	r2, 1
beq_cont.11337:
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	vecunit_sgn.2880				#	bl	vecunit_sgn.2880
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.11335:
	j	beq_cont.11333
beq_then.11332:
	flw	f1, 0(r5)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11338
	addi	r2, r0, 1				# li	r2, 1
	j	feq_cont.11339
feq_else.11338:
	addi	r2, r0, 0				# li	r2, 0
feq_cont.11339:
	beqi	0, r2, beq_then.11340
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11341
beq_then.11340:
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11342
	addi	r2, r0, 1				# li	r2, 1
	j	feq_cont.11343
feq_else.11342:
	addi	r2, r0, 0				# li	r2, 0
feq_cont.11343:
	beqi	0, r2, beq_then.11344
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.11345
beq_then.11344:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11346
	addi	r2, r0, 0				# li	r2, 0
	j	fle_cont.11347
fle_else.11346:
	addi	r2, r0, 1				# li	r2, 1
fle_cont.11347:
	beqi	0, r2, beq_then.11348
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.11349
beq_then.11348:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.11349:
beq_cont.11345:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.11341:
	fsw	f1, 0(r5)
	flw	f1, 1(r5)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11350
	addi	r2, r0, 1				# li	r2, 1
	j	feq_cont.11351
feq_else.11350:
	addi	r2, r0, 0				# li	r2, 0
feq_cont.11351:
	beqi	0, r2, beq_then.11352
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11353
beq_then.11352:
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11354
	addi	r2, r0, 1				# li	r2, 1
	j	feq_cont.11355
feq_else.11354:
	addi	r2, r0, 0				# li	r2, 0
feq_cont.11355:
	beqi	0, r2, beq_then.11356
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.11357
beq_then.11356:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11358
	addi	r2, r0, 0				# li	r2, 0
	j	fle_cont.11359
fle_else.11358:
	addi	r2, r0, 1				# li	r2, 1
fle_cont.11359:
	beqi	0, r2, beq_then.11360
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.11361
beq_then.11360:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.11361:
beq_cont.11357:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.11353:
	fsw	f1, 1(r5)
	flw	f1, 2(r5)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11362
	addi	r2, r0, 1				# li	r2, 1
	j	feq_cont.11363
feq_else.11362:
	addi	r2, r0, 0				# li	r2, 0
feq_cont.11363:
	beqi	0, r2, beq_then.11364
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11365
beq_then.11364:
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11366
	addi	r2, r0, 1				# li	r2, 1
	j	feq_cont.11367
feq_else.11366:
	addi	r2, r0, 0				# li	r2, 0
feq_cont.11367:
	beqi	0, r2, beq_then.11368
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.11369
beq_then.11368:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11370
	addi	r2, r0, 0				# li	r2, 0
	j	fle_cont.11371
fle_else.11370:
	addi	r2, r0, 1				# li	r2, 1
fle_cont.11371:
	beqi	0, r2, beq_then.11372
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.11373
beq_then.11372:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.11373:
beq_cont.11369:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.11365:
	fsw	f1, 2(r5)
beq_cont.11333:
	lw	r1, 5(r3)
	beqi	0, r1, beq_then.11374
	lw	r1, 6(r3)
	lw	r2, 11(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	rotate_quadratic_matrix.2985				#	bl	rotate_quadratic_matrix.2985
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.11375
beq_then.11374:
beq_cont.11375:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.11325:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
read_object.2990:
	lw	r2, 2(r29)
	lw	r5, 1(r29)
	addi	r6, r0, 60				# li	r6, 60
	ble	r6, r1, ble_then.11376
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
	beqi	0, r1, beq_then.11377
	lw	r1, 3(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60				# li	r2, 60
	ble	r2, r1, ble_then.11378
	lw	r29, 1(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.11379
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11379:
	lw	r1, 2(r3)
	lw	r2, 4(r3)
	sw	r2, 0(r1)
	jr	r31				#	blr
ble_then.11378:
	jr	r31				#	blr
beq_then.11377:
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	jr	r31				#	blr
ble_then.11376:
	jr	r31				#	blr
read_net_item.2994:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.11384
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_net_item.2994				#	bl	read_net_item.2994
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#	blr
beq_then.11384:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1				# li	r2, -1
	j	lib_create_array
read_or_network.2996:
	addi	r2, r0, 0				# li	r2, 0
	sw	r1, 0(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_net_item.2994				#	bl	read_net_item.2994
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.11385
	lw	r1, 0(r3)
	addi	r5, r1, 1
	sw	r2, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_or_network.2996				#	bl	read_or_network.2996
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#	blr
beq_then.11385:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.2998:
	lw	r2, 1(r29)
	addi	r5, r0, 0				# li	r5, 0
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_net_item.2994				#	bl	read_net_item.2994
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.11386
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	addi	r2, r0, 0				# li	r2, 0
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.2994				#	bl	read_net_item.2994
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.11387
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11387:
	jr	r31				#	blr
beq_then.11386:
	jr	r31				#	blr
read_parameter.3000:
	lw	r1, 6(r29)
	lw	r2, 5(r29)
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r8, 2(r3)
	sw	r2, 3(r3)
	sw	r5, 4(r3)
	add	r29, r0, r1				# mr	r29, r1
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r29, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r1, r0, 0				# li	r1, 0
	lw	r29, 3(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r1, r0, 0				# li	r1, 0
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	read_net_item.2994				#	bl	read_net_item.2994
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.11390
	lw	r2, 2(r3)
	sw	r1, 0(r2)
	addi	r1, r0, 1				# li	r1, 1
	lw	r29, 1(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.11391
beq_then.11390:
beq_cont.11391:
	addi	r1, r0, 0				# li	r1, 0
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	read_or_network.2996				#	bl	read_or_network.2996
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#	blr
solver_rect_surface.3002:
	lw	r8, 1(r29)
	add	r30, r2, r5
	flw	f4, 0(r30)
	flup	f5, 0		# fli	f5, 0.000000
	feq	r30, f4, f5
	beq	r0, r30, feq_else.11393
	addi	r9, r0, 1				# li	r9, 1
	j	feq_cont.11394
feq_else.11393:
	addi	r9, r0, 0				# li	r9, 0
feq_cont.11394:
	beqi	0, r9, beq_then.11395
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.11395:
	lw	r9, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	flup	f5, 0		# fli	f5, 0.000000
	fle	r30, f5, f4
	beq	r0, r30, fle_else.11396
	addi	r10, r0, 0				# li	r10, 0
	j	fle_cont.11397
fle_else.11396:
	addi	r10, r0, 1				# li	r10, 1
fle_cont.11397:
	beqi	0, r1, beq_then.11398
	beqi	0, r10, beq_then.11400
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.11401
beq_then.11400:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.11401:
	j	beq_cont.11399
beq_then.11398:
	add	r1, r0, r10				# mr	r1, r10
beq_cont.11399:
	add	r30, r9, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.11402
	j	beq_cont.11403
beq_then.11402:
	fneg	f4, f4
beq_cont.11403:
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
	beq	r0, r30, fle_else.11404
	j	fle_cont.11405
fle_else.11404:
	fneg	f2, f2
fle_cont.11405:
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
	beqi	0, r1, beq_then.11406
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
	beq	r0, r30, fle_else.11407
	j	fle_cont.11408
fle_else.11407:
	fneg	f1, f1
fle_cont.11408:
	lw	r2, 1(r3)
	add	r30, r2, r1
	flw	f3, 0(r30)
	fadd	f2, f0, f3				# fmr	f2, f3
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.11409
	lw	r1, 0(r3)
	flw	f1, 4(r3)				
	fsw	f1, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.11409:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.11406:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_rect.3011:
	lw	r29, 1(r29)
	addi	r5, r0, 0				# li	r5, 0
	addi	r6, r0, 1				# li	r6, 1
	addi	r7, r0, 2				# li	r7, 2
	fsw	f1, 0(r3)				
	fsw	f3, 2(r3)				
	fsw	f2, 4(r3)				
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	sw	r29, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	beqi	0, r1, beq_then.11410
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.11410:
	addi	r5, r0, 1				# li	r5, 1
	addi	r6, r0, 2				# li	r6, 2
	addi	r7, r0, 0				# li	r7, 0
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
	beqi	0, r1, beq_then.11411
	addi	r1, r0, 2				# li	r1, 2
	jr	r31				#	blr
beq_then.11411:
	addi	r5, r0, 2				# li	r5, 2
	addi	r6, r0, 0				# li	r6, 0
	addi	r7, r0, 1				# li	r7, 1
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
	beqi	0, r1, beq_then.11412
	addi	r1, r0, 3				# li	r1, 3
	jr	r31				#	blr
beq_then.11412:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_surface.3017:
	lw	r5, 1(r29)
	lw	r1, 4(r1)
	sw	r5, 0(r3)
	fsw	f3, 2(r3)				
	fsw	f2, 4(r3)				
	fsw	f1, 6(r3)				
	sw	r1, 8(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -10
	lw	r31, 9(r3)
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11414
	addi	r1, r0, 0				# li	r1, 0
	j	fle_cont.11415
fle_else.11414:
	addi	r1, r0, 1				# li	r1, 1
fle_cont.11415:
	beqi	0, r1, beq_then.11416
	flw	f2, 6(r3)				
	flw	f3, 4(r3)				
	flw	f4, 2(r3)				
	lw	r1, 8(r3)
	fsw	f1, 10(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	veciprod2.2886				#	bl	veciprod2.2886
	addi	r3, r3, -13
	lw	r31, 12(r3)
	fneg	f1, f1
	flw	f2, 10(r3)				
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.11416:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
quadratic.3023:
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
	beqi	0, r2, beq_then.11418
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
	jr	r31				#	blr
beq_then.11418:
	fadd	f1, f0, f4				# fmr	f1, f4
	jr	r31				#	blr
bilinear.3028:
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
	beqi	0, r2, beq_then.11419
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
	jr	r31				#	blr
beq_then.11419:
	fadd	f1, f0, f7				# fmr	f1, f7
	jr	r31				#	blr
solver_second.3036:
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
	jal	quadratic.3023				#	bl	quadratic.3023
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11421
	addi	r1, r0, 1				# li	r1, 1
	j	feq_cont.11422
feq_else.11421:
	addi	r1, r0, 0				# li	r1, 0
feq_cont.11422:
	beqi	0, r1, beq_then.11423
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.11423:
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
	jal	bilinear.3028				#	bl	bilinear.3028
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
	jal	quadratic.3023				#	bl	quadratic.3023
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 8(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.11424
	j	beq_cont.11425
beq_then.11424:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.11425:
	flw	f2, 12(r3)				
	fmul	f3, f2, f2
	flw	f4, 10(r3)				
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	flup	f3, 0		# fli	f3, 0.000000
	fle	r30, f1, f3
	beq	r0, r30, fle_else.11426
	addi	r2, r0, 0				# li	r2, 0
	j	fle_cont.11427
fle_else.11426:
	addi	r2, r0, 1				# li	r2, 1
fle_cont.11427:
	beqi	0, r2, beq_then.11428
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 8(r3)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11429
	j	beq_cont.11430
beq_then.11429:
	fneg	f1, f1
beq_cont.11430:
	flw	f2, 12(r3)				
	fsub	f1, f1, f2
	flw	f2, 10(r3)				
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.11428:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver.3042:
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
	beqi	1, r5, beq_then.11431
	beqi	2, r5, beq_then.11432
	add	r29, r0, r7				# mr	r29, r7
	lw	r28, 0(r29)
	jr	r28
beq_then.11432:
	add	r29, r0, r6				# mr	r29, r6
	lw	r28, 0(r29)
	jr	r28
beq_then.11431:
	add	r29, r0, r8				# mr	r29, r8
	lw	r28, 0(r29)
	jr	r28
solver_rect_fast.3046:
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
	beq	r0, r30, fle_else.11433
	j	fle_cont.11434
fle_else.11433:
	fneg	f5, f5
fle_cont.11434:
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
	beqi	0, r1, beq_then.11436
	lw	r1, 12(r3)
	flw	f1, 2(r1)
	flw	f2, 10(r3)				
	fmul	f1, f2, f1
	flw	f3, 8(r3)				
	fadd	f1, f1, f3
	flup	f4, 0		# fli	f4, 0.000000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11438
	j	fle_cont.11439
fle_else.11438:
	fneg	f1, f1
fle_cont.11439:
	lw	r2, 7(r3)
	lw	r5, 4(r2)
	flw	f4, 2(r5)
	fadd	f2, f0, f4				# fmr	f2, f4
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.11440
	lw	r1, 6(r3)
	flw	f1, 1(r1)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11442
	addi	r2, r0, 1				# li	r2, 1
	j	feq_cont.11443
feq_else.11442:
	addi	r2, r0, 0				# li	r2, 0
feq_cont.11443:
	beqi	0, r2, beq_then.11444
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.11445
beq_then.11444:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.11445:
	j	beq_cont.11441
beq_then.11440:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.11441:
	j	beq_cont.11437
beq_then.11436:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.11437:
	beqi	0, r1, beq_then.11446
	lw	r1, 0(r3)
	flw	f1, 10(r3)				
	fsw	f1, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.11446:
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
	beq	r0, r30, fle_else.11447
	j	fle_cont.11448
fle_else.11447:
	fneg	f3, f3
fle_cont.11448:
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
	beqi	0, r1, beq_then.11450
	lw	r1, 12(r3)
	flw	f1, 2(r1)
	flw	f2, 14(r3)				
	fmul	f1, f2, f1
	flw	f3, 8(r3)				
	fadd	f1, f1, f3
	flup	f4, 0		# fli	f4, 0.000000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11452
	j	fle_cont.11453
fle_else.11452:
	fneg	f1, f1
fle_cont.11453:
	lw	r2, 7(r3)
	lw	r5, 4(r2)
	flw	f4, 2(r5)
	fadd	f2, f0, f4				# fmr	f2, f4
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.11454
	lw	r1, 6(r3)
	flw	f1, 3(r1)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11456
	addi	r2, r0, 1				# li	r2, 1
	j	feq_cont.11457
feq_else.11456:
	addi	r2, r0, 0				# li	r2, 0
feq_cont.11457:
	beqi	0, r2, beq_then.11458
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.11459
beq_then.11458:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.11459:
	j	beq_cont.11455
beq_then.11454:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.11455:
	j	beq_cont.11451
beq_then.11450:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.11451:
	beqi	0, r1, beq_then.11460
	lw	r1, 0(r3)
	flw	f1, 14(r3)				
	fsw	f1, 0(r1)
	addi	r1, r0, 2				# li	r1, 2
	jr	r31				#	blr
beq_then.11460:
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
	beq	r0, r30, fle_else.11461
	j	fle_cont.11462
fle_else.11461:
	fneg	f2, f2
fle_cont.11462:
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
	beqi	0, r1, beq_then.11463
	lw	r1, 12(r3)
	flw	f1, 1(r1)
	flw	f2, 16(r3)				
	fmul	f1, f2, f1
	flw	f3, 4(r3)				
	fadd	f1, f1, f3
	flup	f3, 0		# fli	f3, 0.000000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11465
	j	fle_cont.11466
fle_else.11465:
	fneg	f1, f1
fle_cont.11466:
	lw	r1, 7(r3)
	lw	r1, 4(r1)
	flw	f3, 1(r1)
	fadd	f2, f0, f3				# fmr	f2, f3
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.11467
	lw	r1, 6(r3)
	flw	f1, 5(r1)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11469
	addi	r1, r0, 1				# li	r1, 1
	j	feq_cont.11470
feq_else.11469:
	addi	r1, r0, 0				# li	r1, 0
feq_cont.11470:
	beqi	0, r1, beq_then.11471
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.11472
beq_then.11471:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.11472:
	j	beq_cont.11468
beq_then.11467:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.11468:
	j	beq_cont.11464
beq_then.11463:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.11464:
	beqi	0, r1, beq_then.11473
	lw	r1, 0(r3)
	flw	f1, 16(r3)				
	fsw	f1, 0(r1)
	addi	r1, r0, 3				# li	r1, 3
	jr	r31				#	blr
beq_then.11473:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_surface_fast.3053:
	lw	r1, 1(r29)
	flw	f4, 0(r2)
	flup	f5, 0		# fli	f5, 0.000000
	fle	r30, f5, f4
	beq	r0, r30, fle_else.11474
	addi	r5, r0, 0				# li	r5, 0
	j	fle_cont.11475
fle_else.11474:
	addi	r5, r0, 1				# li	r5, 1
fle_cont.11475:
	beqi	0, r5, beq_then.11476
	flw	f4, 1(r2)
	fmul	f1, f4, f1
	flw	f4, 2(r2)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 3(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.11476:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_second_fast.3059:
	lw	r5, 1(r29)
	flw	f4, 0(r2)
	flup	f5, 0		# fli	f5, 0.000000
	feq	r30, f4, f5
	beq	r0, r30, feq_else.11477
	addi	r6, r0, 1				# li	r6, 1
	j	feq_cont.11478
feq_else.11477:
	addi	r6, r0, 0				# li	r6, 0
feq_cont.11478:
	beqi	0, r6, beq_then.11479
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.11479:
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
	jal	quadratic.3023				#	bl	quadratic.3023
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.11480
	j	beq_cont.11481
beq_then.11480:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.11481:
	flw	f2, 4(r3)				
	fmul	f3, f2, f2
	flw	f4, 2(r3)				
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	flup	f3, 0		# fli	f3, 0.000000
	fle	r30, f1, f3
	beq	r0, r30, fle_else.11482
	addi	r2, r0, 0				# li	r2, 0
	j	fle_cont.11483
fle_else.11482:
	addi	r2, r0, 1				# li	r2, 1
fle_cont.11483:
	beqi	0, r2, beq_then.11484
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11485
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -8
	lw	r31, 7(r3)
	flw	f2, 4(r3)				
	fadd	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	j	beq_cont.11486
beq_then.11485:
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -8
	lw	r31, 7(r3)
	flw	f2, 4(r3)				
	fsub	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
beq_cont.11486:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.11484:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_fast.3065:
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
	beqi	1, r1, beq_then.11487
	beqi	2, r1, beq_then.11488
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r9				# mr	r1, r9
	add	r29, r0, r7				# mr	r29, r7
	lw	r28, 0(r29)
	jr	r28
beq_then.11488:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r9				# mr	r1, r9
	add	r29, r0, r6				# mr	r29, r6
	lw	r28, 0(r29)
	jr	r28
beq_then.11487:
	lw	r2, 0(r2)
	add	r1, r0, r9				# mr	r1, r9
	add	r29, r0, r8				# mr	r29, r8
	lw	r28, 0(r29)
	jr	r28
solver_surface_fast2.3069:
	lw	r1, 1(r29)
	flw	f1, 0(r2)
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11489
	addi	r6, r0, 0				# li	r6, 0
	j	fle_cont.11490
fle_else.11489:
	addi	r6, r0, 1				# li	r6, 1
fle_cont.11490:
	beqi	0, r6, beq_then.11491
	flw	f1, 0(r2)
	flw	f2, 3(r5)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.11491:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_second_fast2.3076:
	lw	r6, 1(r29)
	flw	f4, 0(r2)
	flup	f5, 0		# fli	f5, 0.000000
	feq	r30, f4, f5
	beq	r0, r30, feq_else.11492
	addi	r7, r0, 1				# li	r7, 1
	j	feq_cont.11493
feq_else.11492:
	addi	r7, r0, 0				# li	r7, 0
feq_cont.11493:
	beqi	0, r7, beq_then.11494
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.11494:
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
	beq	r0, r30, fle_else.11495
	addi	r5, r0, 0				# li	r5, 0
	j	fle_cont.11496
fle_else.11495:
	addi	r5, r0, 1				# li	r5, 1
fle_cont.11496:
	beqi	0, r5, beq_then.11497
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11498
	sw	r6, 0(r3)
	sw	r2, 1(r3)
	fsw	f1, 2(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)				
	fadd	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	j	beq_cont.11499
beq_then.11498:
	sw	r6, 0(r3)
	sw	r2, 1(r3)
	fsw	f1, 2(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)				
	fsub	f1, f2, f1
	lw	r1, 1(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
beq_cont.11499:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.11497:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solver_fast2.3083:
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
	beqi	1, r10, beq_then.11500
	beqi	2, r10, beq_then.11501
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r1				# mr	r2, r1
	add	r29, r0, r6				# mr	r29, r6
	add	r1, r0, r8				# mr	r1, r8
	lw	r28, 0(r29)
	jr	r28
beq_then.11501:
	add	r2, r0, r1				# mr	r2, r1
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r9				# mr	r5, r9
	add	r1, r0, r8				# mr	r1, r8
	lw	r28, 0(r29)
	jr	r28
beq_then.11500:
	lw	r2, 0(r2)
	add	r5, r0, r1				# mr	r5, r1
	add	r29, r0, r7				# mr	r29, r7
	add	r1, r0, r8				# mr	r1, r8
	lw	r28, 0(r29)
	jr	r28
setup_rect_table.3086:
	addi	r5, r0, 6				# li	r5, 6
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
	beq	r0, r30, feq_else.11502
	addi	r5, r0, 1				# li	r5, 1
	j	feq_cont.11503
feq_else.11502:
	addi	r5, r0, 0				# li	r5, 0
feq_cont.11503:
	beqi	0, r5, beq_then.11504
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 1(r1)
	j	beq_cont.11505
beq_then.11504:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 0(r2)
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11506
	addi	r7, r0, 0				# li	r7, 0
	j	fle_cont.11507
fle_else.11506:
	addi	r7, r0, 1				# li	r7, 1
fle_cont.11507:
	beqi	0, r6, beq_then.11508
	beqi	0, r7, beq_then.11510
	addi	r6, r0, 0				# li	r6, 0
	j	beq_cont.11511
beq_then.11510:
	addi	r6, r0, 1				# li	r6, 1
beq_cont.11511:
	j	beq_cont.11509
beq_then.11508:
	add	r6, r0, r7				# mr	r6, r7
beq_cont.11509:
	lw	r7, 4(r5)
	flw	f1, 0(r7)
	beqi	0, r6, beq_then.11512
	j	beq_cont.11513
beq_then.11512:
	fneg	f1, f1
beq_cont.11513:
	fsw	f1, 0(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r2)
	fdiv	f1, f1, f2
	fsw	f1, 1(r1)
beq_cont.11505:
	flw	f1, 1(r2)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11514
	addi	r5, r0, 1				# li	r5, 1
	j	feq_cont.11515
feq_else.11514:
	addi	r5, r0, 0				# li	r5, 0
feq_cont.11515:
	beqi	0, r5, beq_then.11516
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 3(r1)
	j	beq_cont.11517
beq_then.11516:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 1(r2)
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11518
	addi	r7, r0, 0				# li	r7, 0
	j	fle_cont.11519
fle_else.11518:
	addi	r7, r0, 1				# li	r7, 1
fle_cont.11519:
	beqi	0, r6, beq_then.11520
	beqi	0, r7, beq_then.11522
	addi	r6, r0, 0				# li	r6, 0
	j	beq_cont.11523
beq_then.11522:
	addi	r6, r0, 1				# li	r6, 1
beq_cont.11523:
	j	beq_cont.11521
beq_then.11520:
	add	r6, r0, r7				# mr	r6, r7
beq_cont.11521:
	lw	r7, 4(r5)
	flw	f1, 1(r7)
	beqi	0, r6, beq_then.11524
	j	beq_cont.11525
beq_then.11524:
	fneg	f1, f1
beq_cont.11525:
	fsw	f1, 2(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 1(r2)
	fdiv	f1, f1, f2
	fsw	f1, 3(r1)
beq_cont.11517:
	flw	f1, 2(r2)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11526
	addi	r5, r0, 1				# li	r5, 1
	j	feq_cont.11527
feq_else.11526:
	addi	r5, r0, 0				# li	r5, 0
feq_cont.11527:
	beqi	0, r5, beq_then.11528
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 5(r1)
	j	beq_cont.11529
beq_then.11528:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 2(r2)
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11530
	addi	r7, r0, 0				# li	r7, 0
	j	fle_cont.11531
fle_else.11530:
	addi	r7, r0, 1				# li	r7, 1
fle_cont.11531:
	beqi	0, r6, beq_then.11532
	beqi	0, r7, beq_then.11534
	addi	r6, r0, 0				# li	r6, 0
	j	beq_cont.11535
beq_then.11534:
	addi	r6, r0, 1				# li	r6, 1
beq_cont.11535:
	j	beq_cont.11533
beq_then.11532:
	add	r6, r0, r7				# mr	r6, r7
beq_cont.11533:
	lw	r5, 4(r5)
	flw	f1, 2(r5)
	beqi	0, r6, beq_then.11536
	j	beq_cont.11537
beq_then.11536:
	fneg	f1, f1
beq_cont.11537:
	fsw	f1, 4(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 2(r2)
	fdiv	f1, f1, f2
	fsw	f1, 5(r1)
beq_cont.11529:
	jr	r31				#	blr
setup_surface_table.3089:
	addi	r5, r0, 4				# li	r5, 4
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
	beq	r0, r30, fle_else.11538
	addi	r2, r0, 0				# li	r2, 0
	j	fle_cont.11539
fle_else.11538:
	addi	r2, r0, 1				# li	r2, 1
fle_cont.11539:
	beqi	0, r2, beq_then.11540
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
	j	beq_cont.11541
beq_then.11540:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
beq_cont.11541:
	jr	r31				#	blr
setup_second_table.3092:
	addi	r5, r0, 5				# li	r5, 5
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
	jal	quadratic.3023				#	bl	quadratic.3023
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
	beqi	0, r6, beq_then.11542
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
	j	beq_cont.11543
beq_then.11542:
	fsw	f2, 1(r5)
	fsw	f3, 2(r5)
	fsw	f4, 3(r5)
beq_cont.11543:
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11544
	addi	r1, r0, 1				# li	r1, 1
	j	feq_cont.11545
feq_else.11544:
	addi	r1, r0, 0				# li	r1, 0
feq_cont.11545:
	beqi	0, r1, beq_then.11546
	j	beq_cont.11547
beq_then.11546:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
	fsw	f1, 4(r5)
beq_cont.11547:
	add	r1, r0, r5				# mr	r1, r5
	jr	r31				#	blr
iter_setup_dirvec_constants.3095:
	lw	r5, 1(r29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.11548
	jr	r31				#	blr
ble_then.11548:
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 1(r1)
	lw	r7, 0(r1)
	lw	r8, 1(r5)
	sw	r1, 0(r3)
	sw	r29, 1(r3)
	beqi	1, r8, beq_then.11550
	beqi	2, r8, beq_then.11552
	sw	r2, 2(r3)
	sw	r6, 3(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	setup_second_table.3092				#	bl	setup_second_table.3092
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.11553
beq_then.11552:
	sw	r2, 2(r3)
	sw	r6, 3(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	setup_surface_table.3089				#	bl	setup_surface_table.3089
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.11553:
	j	beq_cont.11551
beq_then.11550:
	sw	r2, 2(r3)
	sw	r6, 3(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	setup_rect_table.3086				#	bl	setup_rect_table.3086
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.11551:
	addi	r2, r2, -1
	lw	r1, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
setup_startp_constants.3100:
	lw	r5, 1(r29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.11554
	jr	r31				#	blr
ble_then.11554:
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
	beqi	2, r7, beq_then.11556
	blei	2, r7, ble_then.11558
	flw	f1, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 2(r6)
	sw	r6, 3(r3)
	sw	r7, 4(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	quadratic.3023				#	bl	quadratic.3023
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	beqi	3, r1, beq_then.11560
	j	beq_cont.11561
beq_then.11560:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.11561:
	lw	r1, 3(r3)
	fsw	f1, 3(r1)
	j	ble_cont.11559
ble_then.11558:
ble_cont.11559:
	j	beq_cont.11557
beq_then.11556:
	lw	r5, 4(r5)
	flw	f1, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 2(r6)
	sw	r6, 3(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	veciprod2.2886				#	bl	veciprod2.2886
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 3(r3)
	fsw	f1, 3(r1)
beq_cont.11557:
	lw	r1, 2(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
is_rect_outside.3105:
	flup	f4, 0		# fli	f4, 0.000000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11562
	j	fle_cont.11563
fle_else.11562:
	fneg	f1, f1
fle_cont.11563:
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
	beqi	0, r1, beq_then.11565
	flup	f1, 0		# fli	f1, 0.000000
	flw	f2, 4(r3)				
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11567
	fadd	f1, f0, f2				# fmr	f1, f2
	j	fle_cont.11568
fle_else.11567:
	fneg	f1, f2
fle_cont.11568:
	lw	r1, 2(r3)
	lw	r2, 4(r1)
	flw	f2, 1(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.11569
	flup	f1, 0		# fli	f1, 0.000000
	flw	f2, 0(r3)				
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11571
	fadd	f1, f0, f2				# fmr	f1, f2
	j	fle_cont.11572
fle_else.11571:
	fneg	f1, f2
fle_cont.11572:
	lw	r1, 2(r3)
	lw	r2, 4(r1)
	flw	f2, 2(r2)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.11570
beq_then.11569:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.11570:
	j	beq_cont.11566
beq_then.11565:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.11566:
	beqi	0, r1, beq_then.11573
	lw	r1, 2(r3)
	lw	r1, 6(r1)
	jr	r31				#	blr
beq_then.11573:
	lw	r1, 2(r3)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11574
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.11574:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
is_second_outside.3115:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3023				#	bl	quadratic.3023
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.11575
	j	beq_cont.11576
beq_then.11575:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.11576:
	lw	r1, 6(r1)
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11577
	addi	r2, r0, 0				# li	r2, 0
	j	fle_cont.11578
fle_else.11577:
	addi	r2, r0, 1				# li	r2, 1
fle_cont.11578:
	beqi	0, r1, beq_then.11579
	beqi	0, r2, beq_then.11581
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.11582
beq_then.11581:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.11582:
	j	beq_cont.11580
beq_then.11579:
	add	r1, r0, r2				# mr	r1, r2
beq_cont.11580:
	beqi	0, r1, beq_then.11583
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.11583:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
is_outside.3120:
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
	beqi	1, r2, beq_then.11584
	beqi	2, r2, beq_then.11585
	j	is_second_outside.3115
beq_then.11585:
	lw	r2, 4(r1)
	sw	r1, 0(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	veciprod2.2886				#	bl	veciprod2.2886
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r1, 6(r1)
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11586
	addi	r2, r0, 0				# li	r2, 0
	j	fle_cont.11587
fle_else.11586:
	addi	r2, r0, 1				# li	r2, 1
fle_cont.11587:
	beqi	0, r1, beq_then.11588
	beqi	0, r2, beq_then.11590
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.11591
beq_then.11590:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.11591:
	j	beq_cont.11589
beq_then.11588:
	add	r1, r0, r2				# mr	r1, r2
beq_cont.11589:
	beqi	0, r1, beq_then.11592
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.11592:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.11584:
	j	is_rect_outside.3105
check_all_inside.3125:
	lw	r5, 1(r29)
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.11593
	add	r30, r5, r6
	lw	r6, 0(r30)
	sw	r29, 0(r3)
	fsw	f3, 2(r3)				
	fsw	f2, 4(r3)				
	fsw	f1, 6(r3)				
	sw	r5, 8(r3)
	sw	r2, 9(r3)
	sw	r1, 10(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	is_outside.3120				#	bl	is_outside.3120
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.11595
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.11595:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.11596
	lw	r6, 8(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	flw	f1, 6(r3)				
	flw	f2, 4(r3)				
	flw	f3, 2(r3)				
	sw	r1, 11(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	is_outside.3120				#	bl	is_outside.3120
	addi	r3, r3, -13
	lw	r31, 12(r3)
	beqi	0, r1, beq_then.11597
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.11597:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	flw	f1, 6(r3)				
	flw	f2, 4(r3)				
	flw	f3, 2(r3)				
	lw	r2, 9(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11596:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.11593:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
shadow_check_and_group.3131:
	lw	r5, 7(r29)
	lw	r6, 6(r29)
	lw	r7, 5(r29)
	lw	r8, 4(r29)
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	add	r30, r2, r1
	lw	r12, 0(r30)
	beqi	-1, r12, beq_then.11598
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
	beqi	0, r1, beq_then.11600
	flup	f2, 28		# fli	f2, -0.200000
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.11601
beq_then.11600:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.11601:
	beqi	0, r1, beq_then.11602
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
	beqi	-1, r1, beq_then.11603
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
	jal	is_outside.3120				#	bl	is_outside.3120
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.11605
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.11606
beq_then.11605:
	addi	r1, r0, 1				# li	r1, 1
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
beq_cont.11606:
	j	beq_cont.11604
beq_then.11603:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.11604:
	beqi	0, r1, beq_then.11607
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.11607:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11602:
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11608
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11608:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.11598:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
shadow_check_one_or_group.3134:
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.11609
	add	r30, r6, r7
	lw	r6, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	sw	r2, 0(r3)
	sw	r29, 1(r3)
	sw	r1, 2(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	add	r29, r0, r5				# mr	r29, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.11610
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.11610:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11609:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
shadow_check_one_or_matrix.3137:
	lw	r5, 5(r29)
	lw	r6, 4(r29)
	lw	r7, 3(r29)
	lw	r8, 2(r29)
	lw	r9, 1(r29)
	add	r30, r2, r1
	lw	r10, 0(r30)
	lw	r11, 0(r10)
	beqi	-1, r11, beq_then.11611
	addi	r12, r0, 99				# li	r12, 99
	sw	r10, 0(r3)
	sw	r7, 1(r3)
	sw	r2, 2(r3)
	sw	r29, 3(r3)
	sw	r1, 4(r3)
	beq	r11, r12, beq_then.11612
	sw	r6, 5(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r11				# mr	r1, r11
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r9				# mr	r5, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.11614
	lw	r1, 5(r3)
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.11616
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 0(r3)
	lw	r29, 1(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.11618
	addi	r1, r0, 1				# li	r1, 1
	j	beq_cont.11619
beq_then.11618:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.11619:
	j	beq_cont.11617
beq_then.11616:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.11617:
	j	beq_cont.11615
beq_then.11614:
	addi	r1, r0, 0				# li	r1, 0
beq_cont.11615:
	j	beq_cont.11613
beq_then.11612:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.11613:
	beqi	0, r1, beq_then.11620
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 0(r3)
	lw	r29, 1(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.11621
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
beq_then.11621:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r29, 3(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11620:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r29, 3(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11611:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solve_each_element.3140:
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
	beqi	-1, r15, beq_then.11622
	sw	r11, 0(r3)
	sw	r13, 1(r3)
	sw	r12, 2(r3)
	sw	r14, 3(r3)
	sw	r7, 4(r3)
	sw	r6, 5(r3)
	sw	r8, 6(r3)
	sw	r5, 7(r3)
	sw	r2, 8(r3)
	sw	r29, 9(r3)
	sw	r1, 10(r3)
	sw	r15, 11(r3)
	sw	r10, 12(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r15				# mr	r1, r15
	add	r29, r0, r9				# mr	r29, r9
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.11623
	lw	r2, 6(r3)
	flw	f2, 0(r2)
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 13(r3)
	fsw	f2, 14(r3)				
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.11624
	lw	r1, 5(r3)
	flw	f2, 0(r1)
	flw	f1, 14(r3)				
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.11626
	flup	f1, 29		# fli	f1, 0.010000
	flw	f2, 14(r3)				
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
	fsw	f4, 16(r3)				
	fsw	f3, 18(r3)				
	fsw	f2, 20(r3)				
	fsw	f1, 22(r3)				
	beqi	-1, r1, beq_then.11628
	lw	r6, 12(r3)
	add	r30, r6, r1
	lw	r1, 0(r30)
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	is_outside.3120				#	bl	is_outside.3120
	addi	r3, r3, -25
	lw	r31, 24(r3)
	beqi	0, r1, beq_then.11630
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.11631
beq_then.11630:
	addi	r1, r0, 1				# li	r1, 1
	flw	f1, 20(r3)				
	flw	f2, 18(r3)				
	flw	f3, 16(r3)				
	lw	r2, 8(r3)
	lw	r29, 3(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -25
	lw	r31, 24(r3)
beq_cont.11631:
	j	beq_cont.11629
beq_then.11628:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.11629:
	beqi	0, r1, beq_then.11632
	lw	r1, 5(r3)
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
	lw	r2, 11(r3)
	sw	r2, 0(r1)
	lw	r1, 0(r3)
	lw	r2, 13(r3)
	sw	r2, 0(r1)
	j	beq_cont.11633
beq_then.11632:
beq_cont.11633:
	j	beq_cont.11627
beq_then.11626:
beq_cont.11627:
	j	beq_cont.11625
beq_then.11624:
beq_cont.11625:
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r29, 9(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11623:
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11634
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	lw	r29, 9(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11634:
	jr	r31				#	blr
beq_then.11622:
	jr	r31				#	blr
solve_one_or_network.3144:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.11637
	add	r30, r7, r8
	lw	r8, 0(r30)
	addi	r9, r0, 0				# li	r9, 0
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
	beqi	-1, r5, beq_then.11638
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 1(r3)
	lw	r29, 2(r3)
	sw	r1, 6(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r5, 1(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11638:
	jr	r31				#	blr
beq_then.11637:
	jr	r31				#	blr
trace_or_matrix.3148:
	lw	r6, 7(r29)
	lw	r7, 6(r29)
	lw	r8, 5(r29)
	lw	r9, 4(r29)
	lw	r10, 3(r29)
	lw	r11, 2(r29)
	lw	r12, 1(r29)
	add	r30, r2, r1
	lw	r13, 0(r30)
	lw	r14, 0(r13)
	beqi	-1, r14, beq_then.11641
	addi	r15, r0, 99				# li	r15, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r29, 2(r3)
	sw	r1, 3(r3)
	beq	r14, r15, beq_then.11642
	sw	r10, 4(r3)
	sw	r11, 5(r3)
	sw	r12, 6(r3)
	sw	r13, 7(r3)
	sw	r6, 8(r3)
	sw	r8, 9(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r14				# mr	r1, r14
	add	r29, r0, r9				# mr	r29, r9
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.11644
	lw	r1, 9(r3)
	flw	f1, 0(r1)
	lw	r1, 8(r3)
	flw	f2, 0(r1)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.11646
	lw	r1, 7(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.11648
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
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
	addi	r1, r0, 2				# li	r1, 2
	lw	r2, 7(r3)
	lw	r5, 0(r3)
	lw	r29, 4(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.11649
beq_then.11648:
beq_cont.11649:
	j	beq_cont.11647
beq_then.11646:
beq_cont.11647:
	j	beq_cont.11645
beq_then.11644:
beq_cont.11645:
	j	beq_cont.11643
beq_then.11642:
	lw	r6, 1(r13)
	beqi	-1, r6, beq_then.11650
	add	r30, r12, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	sw	r13, 7(r3)
	sw	r10, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	add	r29, r0, r11				# mr	r29, r11
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r1, r0, 2				# li	r1, 2
	lw	r2, 7(r3)
	lw	r5, 0(r3)
	lw	r29, 4(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.11651
beq_then.11650:
beq_cont.11651:
beq_cont.11643:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11641:
	jr	r31				#	blr
judge_intersection.3152:
	lw	r2, 3(r29)
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r5)
	addi	r7, r0, 0				# li	r7, 0
	lw	r6, 0(r6)
	sw	r5, 0(r3)
	add	r5, r0, r1				# mr	r5, r1
	add	r29, r0, r2				# mr	r29, r2
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 1(r3)
	addi	r3, r3, 2
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	flw	f2, 0(r1)
	flup	f1, 30		# fli	f1, -0.100000
	fsw	f2, 2(r3)				
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.11654
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 2(r3)				
	j	lib_fless
beq_then.11654:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
solve_each_element_fast.3154:
	lw	r6, 9(r29)
	lw	r7, 8(r29)
	lw	r8, 7(r29)
	lw	r9, 6(r29)
	lw	r10, 5(r29)
	lw	r11, 4(r29)
	lw	r12, 3(r29)
	lw	r13, 2(r29)
	lw	r14, 1(r29)
	lw	r15, 0(r5)
	add	r30, r2, r1
	lw	r16, 0(r30)
	beqi	-1, r16, beq_then.11655
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
	sw	r29, 10(r3)
	sw	r1, 11(r3)
	sw	r16, 12(r3)
	sw	r10, 13(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r16				# mr	r1, r16
	add	r29, r0, r8				# mr	r29, r8
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.11656
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
	beqi	0, r1, beq_then.11658
	lw	r1, 6(r3)
	flw	f2, 0(r1)
	flw	f1, 16(r3)				
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.11660
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
	beqi	-1, r1, beq_then.11662
	lw	r5, 13(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	is_outside.3120				#	bl	is_outside.3120
	addi	r3, r3, -27
	lw	r31, 26(r3)
	beqi	0, r1, beq_then.11664
	addi	r1, r0, 0				# li	r1, 0
	j	beq_cont.11665
beq_then.11664:
	addi	r1, r0, 1				# li	r1, 1
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
beq_cont.11665:
	j	beq_cont.11663
beq_then.11662:
	addi	r1, r0, 1				# li	r1, 1
beq_cont.11663:
	beqi	0, r1, beq_then.11666
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
	j	beq_cont.11667
beq_then.11666:
beq_cont.11667:
	j	beq_cont.11661
beq_then.11660:
beq_cont.11661:
	j	beq_cont.11659
beq_then.11658:
beq_cont.11659:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r29, 10(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11656:
	lw	r1, 12(r3)
	lw	r2, 13(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11668
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 9(r3)
	lw	r5, 8(r3)
	lw	r29, 10(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11668:
	jr	r31				#	blr
beq_then.11655:
	jr	r31				#	blr
solve_one_or_network_fast.3158:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.11671
	add	r30, r7, r8
	lw	r8, 0(r30)
	addi	r9, r0, 0				# li	r9, 0
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
	beqi	-1, r5, beq_then.11672
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r7, 1(r3)
	lw	r29, 2(r3)
	sw	r1, 6(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 4(r3)
	lw	r5, 1(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11672:
	jr	r31				#	blr
beq_then.11671:
	jr	r31				#	blr
trace_or_matrix_fast.3162:
	lw	r6, 6(r29)
	lw	r7, 5(r29)
	lw	r8, 4(r29)
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	add	r30, r2, r1
	lw	r12, 0(r30)
	lw	r13, 0(r12)
	beqi	-1, r13, beq_then.11675
	addi	r14, r0, 99				# li	r14, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r29, 2(r3)
	sw	r1, 3(r3)
	beq	r13, r14, beq_then.11676
	sw	r9, 4(r3)
	sw	r10, 5(r3)
	sw	r11, 6(r3)
	sw	r12, 7(r3)
	sw	r6, 8(r3)
	sw	r8, 9(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r13				# mr	r1, r13
	add	r29, r0, r7				# mr	r29, r7
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.11678
	lw	r1, 9(r3)
	flw	f1, 0(r1)
	lw	r1, 8(r3)
	flw	f2, 0(r1)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.11680
	lw	r1, 7(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.11682
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0				# li	r5, 0
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
	addi	r1, r0, 2				# li	r1, 2
	lw	r2, 7(r3)
	lw	r5, 0(r3)
	lw	r29, 4(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.11683
beq_then.11682:
beq_cont.11683:
	j	beq_cont.11681
beq_then.11680:
beq_cont.11681:
	j	beq_cont.11679
beq_then.11678:
beq_cont.11679:
	j	beq_cont.11677
beq_then.11676:
	lw	r6, 1(r12)
	beqi	-1, r6, beq_then.11684
	add	r30, r11, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0				# li	r7, 0
	sw	r12, 7(r3)
	sw	r9, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	add	r29, r0, r10				# mr	r29, r10
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r1, r0, 2				# li	r1, 2
	lw	r2, 7(r3)
	lw	r5, 0(r3)
	lw	r29, 4(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.11685
beq_then.11684:
beq_cont.11685:
beq_cont.11677:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11675:
	jr	r31				#	blr
judge_intersection_fast.3166:
	lw	r2, 3(r29)
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r5)
	addi	r7, r0, 0				# li	r7, 0
	lw	r6, 0(r6)
	sw	r5, 0(r3)
	add	r5, r0, r1				# mr	r5, r1
	add	r29, r0, r2				# mr	r29, r2
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 1(r3)
	addi	r3, r3, 2
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	flw	f2, 0(r1)
	flup	f1, 30		# fli	f1, -0.100000
	fsw	f2, 2(r3)				
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.11688
	flup	f2, 32		# fli	f2, 100000000.000000
	flw	f1, 2(r3)				
	j	lib_fless
beq_then.11688:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
get_nvector_rect.3168:
	lw	r2, 2(r29)
	lw	r5, 1(r29)
	lw	r5, 0(r5)
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r2)
	fsw	f1, 1(r2)
	fsw	f1, 2(r2)
	addi	r6, r5, -1
	addi	r5, r5, -1
	add	r30, r1, r5
	flw	f1, 0(r30)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11689
	addi	r1, r0, 1				# li	r1, 1
	j	feq_cont.11690
feq_else.11689:
	addi	r1, r0, 0				# li	r1, 0
feq_cont.11690:
	beqi	0, r1, beq_then.11691
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11692
beq_then.11691:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11693
	addi	r1, r0, 0				# li	r1, 0
	j	fle_cont.11694
fle_else.11693:
	addi	r1, r0, 1				# li	r1, 1
fle_cont.11694:
	beqi	0, r1, beq_then.11695
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.11696
beq_then.11695:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.11696:
beq_cont.11692:
	fneg	f1, f1
	add	r30, r2, r6
	fsw	f1, 0(r30)
	jr	r31				#	blr
get_nvector_plane.3170:
	lw	r2, 1(r29)
	lw	r5, 4(r1)
	flw	f1, 0(r5)
	fneg	f1, f1
	fsw	f1, 0(r2)
	lw	r5, 4(r1)
	flw	f1, 1(r5)
	fneg	f1, f1
	fsw	f1, 1(r2)
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	fneg	f1, f1
	fsw	f1, 2(r2)
	jr	r31				#	blr
get_nvector_second.3172:
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
	beqi	0, r5, beq_then.11699
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
	j	beq_cont.11700
beq_then.11699:
	fsw	f4, 0(r2)
	fsw	f5, 1(r2)
	fsw	f6, 2(r2)
beq_cont.11700:
	lw	r1, 6(r1)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	vecunit_sgn.2880
utexture.3177:
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
	beqi	1, r6, beq_then.11701
	beqi	2, r6, beq_then.11702
	beqi	3, r6, beq_then.11703
	beqi	4, r6, beq_then.11704
	jr	r31				#	blr
beq_then.11704:
	flw	f1, 0(r2)
	lw	r6, 5(r1)
	flw	f2, 0(r6)
	fsub	f1, f1, f2
	lw	r6, 4(r1)
	flw	f2, 0(r6)
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	fsw	f1, 4(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)				
	fmul	f1, f2, f1
	lw	r1, 2(r3)
	flw	f2, 2(r1)
	lw	r2, 1(r3)
	lw	r5, 5(r2)
	flw	f3, 2(r5)
	fsub	f2, f2, f3
	lw	r5, 4(r2)
	flw	f3, 2(r5)
	fsw	f1, 6(r3)				
	fsw	f2, 8(r3)				
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)				
	fmul	f1, f2, f1
	flw	f2, 6(r3)				
	fmul	f3, f2, f2
	fmul	f4, f1, f1
	fadd	f3, f3, f4
	flup	f4, 0		# fli	f4, 0.000000
	fle	r30, f4, f2
	beq	r0, r30, fle_else.11707
	fadd	f4, f0, f2				# fmr	f4, f2
	j	fle_cont.11708
fle_else.11707:
	fneg	f4, f2
fle_cont.11708:
	flup	f5, 33		# fli	f5, 0.000100
	fsw	f3, 10(r3)				
	fsw	f1, 12(r3)				
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.11709
	flup	f1, 34		# fli	f1, 15.000000
	j	beq_cont.11710
beq_then.11709:
	flw	f1, 6(r3)				
	flw	f2, 12(r3)				
	fdiv	f1, f2, f1
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11711
	j	fle_cont.11712
fle_else.11711:
	fneg	f1, f1
fle_cont.11712:
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	atan.2770				#	bl	atan.2770
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
beq_cont.11710:
	fsw	f1, 14(r3)				
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -17
	lw	r31, 16(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)				
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11713
	j	fle_cont.11714
fle_else.11713:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f1, f1, f3
fle_cont.11714:
	fsub	f1, f2, f1
	lw	r1, 2(r3)
	flw	f2, 1(r1)
	lw	r1, 1(r3)
	lw	r2, 5(r1)
	flw	f3, 1(r2)
	fsub	f2, f2, f3
	lw	r1, 4(r1)
	flw	f3, 1(r1)
	fsw	f1, 16(r3)				
	fsw	f2, 18(r3)				
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 18(r3)				
	fmul	f1, f2, f1
	flup	f2, 0		# fli	f2, 0.000000
	flw	f3, 10(r3)				
	fle	r30, f2, f3
	beq	r0, r30, fle_else.11715
	fadd	f2, f0, f3				# fmr	f2, f3
	j	fle_cont.11716
fle_else.11715:
	fneg	f2, f3
fle_cont.11716:
	flup	f4, 33		# fli	f4, 0.000100
	fsw	f1, 20(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f4				# fmr	f2, f4
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -23
	lw	r31, 22(r3)
	beqi	0, r1, beq_then.11717
	flup	f1, 34		# fli	f1, 15.000000
	j	beq_cont.11718
beq_then.11717:
	flw	f1, 10(r3)				
	flw	f2, 20(r3)				
	fdiv	f1, f2, f1
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11719
	j	fle_cont.11720
fle_else.11719:
	fneg	f1, f1
fle_cont.11720:
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	atan.2770				#	bl	atan.2770
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
beq_cont.11718:
	fsw	f1, 22(r3)				
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -25
	lw	r31, 24(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 22(r3)				
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11721
	j	fle_cont.11722
fle_else.11721:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f1, f1, f3
fle_cont.11722:
	fsub	f1, f2, f1
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
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11723
	addi	r1, r0, 0				# li	r1, 0
	j	fle_cont.11724
fle_else.11723:
	addi	r1, r0, 1				# li	r1, 1
fle_cont.11724:
	beqi	0, r1, beq_then.11725
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11726
beq_then.11725:
beq_cont.11726:
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f2, f1
	flup	f2, 38		# fli	f2, 0.300000
	fdiv	f1, f1, f2
	lw	r1, 0(r3)
	fsw	f1, 2(r1)
	jr	r31				#	blr
beq_then.11703:
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
	sw	r5, 0(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	fsw	f1, 24(r3)				
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -27
	lw	r31, 26(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 24(r3)				
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11728
	j	fle_cont.11729
fle_else.11728:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f1, f1, f3
fle_cont.11729:
	fsub	f1, f2, f1
	flup	f2, 14		# fli	f2, 3.141593
	fmul	f1, f1, f2
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	cos.2766				#	bl	cos.2766
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
	jr	r31				#	blr
beq_then.11702:
	flw	f1, 1(r2)
	flup	f2, 40		# fli	f2, 0.250000
	fmul	f1, f1, f2
	sw	r5, 0(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	sin.2764				#	bl	sin.2764
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
	jr	r31				#	blr
beq_then.11701:
	flw	f1, 0(r2)
	lw	r6, 5(r1)
	flw	f2, 0(r6)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	fsw	f1, 26(r3)				
	fsw	f2, 28(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -31
	lw	r31, 30(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -31
	lw	r31, 30(r3)
	flw	f2, 28(r3)				
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11732
	j	fle_cont.11733
fle_else.11732:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
fle_cont.11733:
	flup	f2, 42		# fli	f2, 20.000000
	fmul	f1, f1, f2
	flw	f2, 26(r3)				
	fsub	f1, f2, f1
	flup	f2, 39		# fli	f2, 10.000000
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -31
	lw	r31, 30(r3)
	lw	r2, 2(r3)
	flw	f1, 2(r2)
	lw	r2, 1(r3)
	lw	r2, 5(r2)
	flw	f2, 2(r2)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	sw	r1, 30(r3)
	fsw	f1, 32(r3)				
	fsw	f2, 34(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	lib_int_of_float				#	bl	lib_int_of_float
	addi	r3, r3, -37
	lw	r31, 36(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	lib_float_of_int				#	bl	lib_float_of_int
	addi	r3, r3, -37
	lw	r31, 36(r3)
	flw	f2, 34(r3)				
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11735
	j	fle_cont.11736
fle_else.11735:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
fle_cont.11736:
	flup	f2, 42		# fli	f2, 20.000000
	fmul	f1, f1, f2
	flw	f2, 32(r3)				
	fsub	f1, f2, f1
	flup	f2, 39		# fli	f2, 10.000000
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -37
	lw	r31, 36(r3)
	lw	r2, 30(r3)
	beqi	0, r2, beq_then.11737
	beqi	0, r1, beq_then.11739
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.11740
beq_then.11739:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.11740:
	j	beq_cont.11738
beq_then.11737:
	beqi	0, r1, beq_then.11741
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11742
beq_then.11741:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.11742:
beq_cont.11738:
	lw	r1, 0(r3)
	fsw	f1, 1(r1)
	jr	r31				#	blr
add_light.3180:
	lw	r2, 2(r29)
	lw	r1, 1(r29)
	flup	f4, 0		# fli	f4, 0.000000
	fle	r30, f1, f4
	beq	r0, r30, fle_else.11744
	addi	r5, r0, 0				# li	r5, 0
	j	fle_cont.11745
fle_else.11744:
	addi	r5, r0, 1				# li	r5, 1
fle_cont.11745:
	sw	r1, 0(r3)
	fsw	f3, 2(r3)				
	fsw	f2, 4(r3)				
	beqi	0, r5, beq_then.11747
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecaccum.2891				#	bl	vecaccum.2891
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.11748
beq_then.11747:
beq_cont.11748:
	flup	f1, 0		# fli	f1, 0.000000
	flw	f2, 4(r3)				
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11749
	addi	r1, r0, 0				# li	r1, 0
	j	fle_cont.11750
fle_else.11749:
	addi	r1, r0, 1				# li	r1, 1
fle_cont.11750:
	beqi	0, r1, beq_then.11751
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
	jr	r31				#	blr
beq_then.11751:
	jr	r31				#	blr
trace_reflections.3184:
	lw	r5, 8(r29)
	lw	r6, 7(r29)
	lw	r7, 6(r29)
	lw	r8, 5(r29)
	lw	r9, 4(r29)
	lw	r10, 3(r29)
	lw	r11, 2(r29)
	lw	r12, 1(r29)
	addi	r13, r0, 0				# li	r13, 0
	ble	r13, r1, ble_then.11754
	jr	r31				#	blr
ble_then.11754:
	add	r30, r6, r1
	lw	r6, 0(r30)
	lw	r13, 1(r6)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	fsw	f2, 2(r3)				
	sw	r12, 4(r3)
	sw	r2, 5(r3)
	fsw	f1, 6(r3)				
	sw	r8, 8(r3)
	sw	r13, 9(r3)
	sw	r5, 10(r3)
	sw	r7, 11(r3)
	sw	r6, 12(r3)
	sw	r10, 13(r3)
	sw	r11, 14(r3)
	add	r1, r0, r13				# mr	r1, r13
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -16
	lw	r31, 15(r3)
	beqi	0, r1, beq_then.11756
	lw	r1, 14(r3)
	lw	r1, 0(r1)
	slli	r1, r1, 2
	lw	r2, 13(r3)
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 12(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.11758
	j	beq_cont.11759
beq_then.11758:
	addi	r1, r0, 0				# li	r1, 0
	lw	r5, 11(r3)
	lw	r5, 0(r5)
	lw	r29, 10(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -16
	lw	r31, 15(r3)
	beqi	0, r1, beq_then.11760
	j	beq_cont.11761
beq_then.11760:
	lw	r1, 9(r3)
	lw	r2, 0(r1)
	lw	r5, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r1, 12(r3)
	flw	f2, 2(r1)
	flw	f3, 6(r3)				
	fmul	f4, f2, f3
	fmul	f1, f4, f1
	lw	r1, 9(r3)
	lw	r2, 0(r1)
	lw	r1, 5(r3)
	fsw	f1, 16(r3)				
	fsw	f2, 18(r3)				
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 18(r3)				
	fmul	f2, f2, f1
	flw	f1, 16(r3)				
	flw	f3, 2(r3)				
	lw	r29, 4(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -21
	lw	r31, 20(r3)
beq_cont.11761:
beq_cont.11759:
	j	beq_cont.11757
beq_then.11756:
beq_cont.11757:
	lw	r1, 1(r3)
	addi	r1, r1, -1
	flw	f1, 6(r3)				
	flw	f2, 2(r3)				
	lw	r2, 5(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
trace_ray.3189:
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
	sw	r9, 0(r3)
	lw	r9, 3(r29)
	sw	r8, 1(r3)
	lw	r8, 2(r29)
	sw	r29, 2(r3)
	lw	r29, 1(r29)
	blei	4, r1, ble_then.11763
	jr	r31				#	blr
ble_then.11763:
	sw	r19, 3(r3)
	lw	r19, 2(r5)
	fsw	f2, 4(r3)				
	sw	r14, 6(r3)
	sw	r20, 7(r3)
	sw	r11, 8(r3)
	sw	r29, 9(r3)
	sw	r13, 10(r3)
	sw	r16, 11(r3)
	sw	r9, 12(r3)
	sw	r18, 13(r3)
	sw	r10, 14(r3)
	sw	r7, 15(r3)
	sw	r5, 16(r3)
	sw	r23, 17(r3)
	sw	r6, 18(r3)
	sw	r24, 19(r3)
	sw	r12, 20(r3)
	sw	r26, 21(r3)
	sw	r28, 22(r3)
	sw	r27, 23(r3)
	sw	r17, 24(r3)
	sw	r25, 25(r3)
	sw	r15, 26(r3)
	sw	r8, 27(r3)
	fsw	f1, 28(r3)				
	sw	r21, 30(r3)
	sw	r2, 31(r3)
	sw	r1, 32(r3)
	sw	r19, 33(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r29, r0, r22				# mr	r29, r22
	sw	r31, 34(r3)
	addi	r3, r3, 35
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -35
	lw	r31, 34(r3)
	beqi	0, r1, beq_then.11765
	lw	r1, 25(r3)
	lw	r1, 0(r1)
	lw	r2, 24(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	lw	r6, 7(r2)
	flw	f1, 0(r6)
	flw	f2, 28(r3)				
	fmul	f1, f1, f2
	lw	r6, 1(r2)
	sw	r5, 34(r3)
	fsw	f1, 36(r3)				
	sw	r1, 38(r3)
	sw	r2, 39(r3)
	beqi	1, r6, beq_then.11767
	beqi	2, r6, beq_then.11769
	lw	r29, 21(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
	j	beq_cont.11770
beq_then.11769:
	lw	r29, 22(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
beq_cont.11770:
	j	beq_cont.11768
beq_then.11767:
	lw	r6, 31(r3)
	lw	r29, 23(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
beq_cont.11768:
	lw	r1, 20(r3)
	lw	r2, 19(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -41
	lw	r31, 40(r3)
	lw	r1, 39(r3)
	lw	r2, 19(r3)
	lw	r29, 18(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
	lw	r1, 38(r3)
	slli	r1, r1, 2
	lw	r2, 17(r3)
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 16(r3)
	lw	r6, 1(r1)
	add	r30, r6, r2
	lw	r6, 0(r30)
	lw	r7, 19(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -41
	lw	r31, 40(r3)
	lw	r1, 16(r3)
	lw	r2, 3(r1)
	lw	r5, 39(r3)
	lw	r6, 7(r5)
	flw	f1, 0(r6)
	flup	f2, 1		# fli	f2, 0.500000
	sw	r2, 40(r3)
	sw	r31, 41(r3)
	addi	r3, r3, 42
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -42
	lw	r31, 41(r3)
	beqi	0, r1, beq_then.11771
	lw	r1, 32(r3)
	lw	r2, 40(r3)
	lw	r5, 12(r3)
	add	r30, r2, r1
	sw	r5, 0(r30)
	j	beq_cont.11772
beq_then.11771:
	lw	r1, 32(r3)
	lw	r2, 40(r3)
	lw	r5, 15(r3)
	add	r30, r2, r1
	sw	r5, 0(r30)
	lw	r2, 16(r3)
	lw	r5, 4(r2)
	add	r30, r5, r1
	lw	r6, 0(r30)
	lw	r7, 14(r3)
	sw	r5, 41(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r1, 32(r3)
	lw	r2, 41(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	flup	f1, 43		# fli	f1, 0.003906
	flw	f2, 36(r3)				
	fmul	f1, f1, f2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	vecscale.2901				#	bl	vecscale.2901
	addi	r3, r3, -43
	lw	r31, 42(r3)
	lw	r1, 16(r3)
	lw	r2, 7(r1)
	lw	r5, 32(r3)
	add	r30, r2, r5
	lw	r2, 0(r30)
	lw	r6, 13(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r6				# mr	r2, r6
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -43
	lw	r31, 42(r3)
beq_cont.11772:
	flup	f1, 44		# fli	f1, -2.000000
	lw	r1, 31(r3)
	lw	r2, 13(r3)
	fsw	f1, 42(r3)				
	sw	r31, 44(r3)
	addi	r3, r3, 45
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -45
	lw	r31, 44(r3)
	flw	f2, 42(r3)				
	fmul	f1, f2, f1
	lw	r1, 31(r3)
	lw	r2, 13(r3)
	sw	r31, 44(r3)
	addi	r3, r3, 45
	jal	vecaccum.2891				#	bl	vecaccum.2891
	addi	r3, r3, -45
	lw	r31, 44(r3)
	lw	r1, 39(r3)
	lw	r2, 7(r1)
	flw	f1, 1(r2)
	flw	f2, 28(r3)				
	fmul	f1, f2, f1
	addi	r2, r0, 0				# li	r2, 0
	lw	r5, 11(r3)
	lw	r5, 0(r5)
	lw	r29, 10(r3)
	fsw	f1, 44(r3)				
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 46(r3)
	addi	r3, r3, 47
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -47
	lw	r31, 46(r3)
	beqi	0, r1, beq_then.11773
	j	beq_cont.11774
beq_then.11773:
	lw	r1, 13(r3)
	lw	r2, 30(r3)
	sw	r31, 46(r3)
	addi	r3, r3, 47
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -47
	lw	r31, 46(r3)
	fneg	f1, f1
	flw	f2, 36(r3)				
	fmul	f1, f1, f2
	lw	r1, 31(r3)
	lw	r2, 30(r3)
	fsw	f1, 46(r3)				
	sw	r31, 48(r3)
	addi	r3, r3, 49
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -49
	lw	r31, 48(r3)
	fneg	f2, f1
	flw	f1, 46(r3)				
	flw	f3, 44(r3)				
	lw	r29, 9(r3)
	sw	r31, 48(r3)
	addi	r3, r3, 49
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -49
	lw	r31, 48(r3)
beq_cont.11774:
	lw	r1, 8(r3)
	lw	r2, 19(r3)
	sw	r31, 48(r3)
	addi	r3, r3, 49
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -49
	lw	r31, 48(r3)
	lw	r1, 7(r3)
	lw	r1, 0(r1)
	addi	r2, r1, -1
	lw	r1, 19(r3)
	lw	r29, 6(r3)
	sw	r31, 48(r3)
	addi	r3, r3, 49
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -49
	lw	r31, 48(r3)
	lw	r1, 3(r3)
	lw	r1, 0(r1)
	addi	r1, r1, -1
	flw	f1, 36(r3)				
	flw	f2, 44(r3)				
	lw	r2, 31(r3)
	lw	r29, 1(r3)
	sw	r31, 48(r3)
	addi	r3, r3, 49
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -49
	lw	r31, 48(r3)
	flup	f1, 45		# fli	f1, 0.100000
	flw	f2, 28(r3)				
	sw	r31, 48(r3)
	addi	r3, r3, 49
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -49
	lw	r31, 48(r3)
	beqi	0, r1, beq_then.11775
	addi	r1, r0, 4				# li	r1, 4
	lw	r2, 32(r3)
	ble	r1, r2, ble_then.11776
	addi	r1, r2, 1
	addi	r5, r0, -1				# li	r5, -1
	lw	r6, 33(r3)
	add	r30, r6, r1
	sw	r5, 0(r30)
	j	ble_cont.11777
ble_then.11776:
ble_cont.11777:
	lw	r1, 34(r3)
	beqi	2, r1, beq_then.11778
	j	beq_cont.11779
beq_then.11778:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r1, 39(r3)
	lw	r1, 7(r1)
	flw	f2, 0(r1)
	fsub	f1, f1, f2
	flw	f2, 28(r3)				
	fmul	f1, f2, f1
	addi	r1, r2, 1
	lw	r2, 0(r3)
	flw	f2, 0(r2)
	flw	f3, 4(r3)				
	fadd	f2, f3, f2
	lw	r2, 31(r3)
	lw	r5, 16(r3)
	lw	r29, 2(r3)
	sw	r31, 48(r3)
	addi	r3, r3, 49
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -49
	lw	r31, 48(r3)
beq_cont.11779:
	jr	r31				#	blr
beq_then.11775:
	jr	r31				#	blr
beq_then.11765:
	addi	r1, r0, -1				# li	r1, -1
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	0, r2, beq_then.11782
	lw	r1, 31(r3)
	lw	r2, 30(r3)
	sw	r31, 48(r3)
	addi	r3, r3, 49
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -49
	lw	r31, 48(r3)
	fneg	f1, f1
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11783
	addi	r1, r0, 0				# li	r1, 0
	j	fle_cont.11784
fle_else.11783:
	addi	r1, r0, 1				# li	r1, 1
fle_cont.11784:
	beqi	0, r1, beq_then.11785
	fmul	f2, f1, f1
	fmul	f1, f2, f1
	flw	f2, 28(r3)				
	fmul	f1, f1, f2
	lw	r1, 27(r3)
	flw	f2, 0(r1)
	fmul	f1, f1, f2
	lw	r1, 26(r3)
	flw	f2, 0(r1)
	fadd	f2, f2, f1
	fsw	f2, 0(r1)
	flw	f2, 1(r1)
	fadd	f2, f2, f1
	fsw	f2, 1(r1)
	flw	f2, 2(r1)
	fadd	f1, f2, f1
	fsw	f1, 2(r1)
	jr	r31				#	blr
beq_then.11785:
	jr	r31				#	blr
beq_then.11782:
	jr	r31				#	blr
trace_diffuse_ray.3195:
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
	sw	r5, 0(r3)
	sw	r17, 1(r3)
	fsw	f1, 2(r3)				
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
	add	r29, r0, r11				# mr	r29, r11
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.11789
	lw	r1, 15(r3)
	lw	r1, 0(r1)
	lw	r2, 14(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 13(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	sw	r1, 16(r3)
	beqi	1, r5, beq_then.11790
	beqi	2, r5, beq_then.11792
	lw	r29, 10(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
	j	beq_cont.11793
beq_then.11792:
	lw	r29, 11(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
beq_cont.11793:
	j	beq_cont.11791
beq_then.11790:
	lw	r29, 12(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
beq_cont.11791:
	lw	r1, 16(r3)
	lw	r2, 8(r3)
	lw	r29, 9(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 7(r3)
	lw	r2, 0(r2)
	lw	r29, 6(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -18
	lw	r31, 17(r3)
	beqi	0, r1, beq_then.11794
	jr	r31				#	blr
beq_then.11794:
	lw	r1, 5(r3)
	lw	r2, 4(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -18
	lw	r31, 17(r3)
	fneg	f1, f1
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11796
	addi	r1, r0, 0				# li	r1, 0
	j	fle_cont.11797
fle_else.11796:
	addi	r1, r0, 1				# li	r1, 1
fle_cont.11797:
	beqi	0, r1, beq_then.11798
	j	beq_cont.11799
beq_then.11798:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.11799:
	flw	f2, 2(r3)				
	fmul	f1, f2, f1
	lw	r1, 16(r3)
	lw	r1, 7(r1)
	flw	f2, 0(r1)
	fmul	f1, f1, f2
	lw	r1, 1(r3)
	lw	r2, 0(r3)
	j	vecaccum.2891
beq_then.11789:
	jr	r31				#	blr
iter_trace_diffuse_rays.3198:
	lw	r7, 1(r29)
	addi	r8, r0, 0				# li	r8, 0
	ble	r8, r6, ble_then.11801
	jr	r31				#	blr
ble_then.11801:
	add	r30, r1, r6
	lw	r8, 0(r30)
	lw	r8, 0(r8)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r29, 2(r3)
	sw	r7, 3(r3)
	sw	r6, 4(r3)
	sw	r1, 5(r3)
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11803
	addi	r1, r0, 0				# li	r1, 0
	j	fle_cont.11804
fle_else.11803:
	addi	r1, r0, 1				# li	r1, 1
fle_cont.11804:
	beqi	0, r1, beq_then.11805
	lw	r1, 4(r3)
	addi	r2, r1, 1
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	lw	r29, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.11806
beq_then.11805:
	lw	r1, 4(r3)
	lw	r2, 5(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	lw	r29, 3(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.11806:
	lw	r1, 4(r3)
	addi	r6, r1, -2
	lw	r1, 5(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
trace_diffuse_ray_80percent.3207:
	lw	r6, 5(r29)
	lw	r7, 4(r29)
	lw	r8, 3(r29)
	lw	r9, 2(r29)
	lw	r10, 1(r29)
	sw	r2, 0(r3)
	sw	r9, 1(r3)
	sw	r7, 2(r3)
	sw	r8, 3(r3)
	sw	r5, 4(r3)
	sw	r6, 5(r3)
	sw	r10, 6(r3)
	sw	r1, 7(r3)
	beqi	0, r1, beq_then.11807
	lw	r11, 0(r10)
	sw	r11, 8(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 3(r3)
	lw	r2, 0(r1)
	addi	r2, r2, -1
	lw	r5, 4(r3)
	lw	r29, 2(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 8(r3)
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	lw	r29, 1(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.11808
beq_then.11807:
beq_cont.11808:
	lw	r1, 7(r3)
	beqi	1, r1, beq_then.11809
	lw	r2, 6(r3)
	lw	r5, 1(r2)
	lw	r6, 5(r3)
	lw	r7, 4(r3)
	sw	r5, 9(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 3(r3)
	lw	r2, 0(r1)
	addi	r2, r2, -1
	lw	r5, 4(r3)
	lw	r29, 2(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 9(r3)
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	lw	r29, 1(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.11810
beq_then.11809:
beq_cont.11810:
	lw	r1, 7(r3)
	beqi	2, r1, beq_then.11811
	lw	r2, 6(r3)
	lw	r5, 2(r2)
	lw	r6, 5(r3)
	lw	r7, 4(r3)
	sw	r5, 10(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 0(r1)
	addi	r2, r2, -1
	lw	r5, 4(r3)
	lw	r29, 2(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 10(r3)
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	lw	r29, 1(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.11812
beq_then.11811:
beq_cont.11812:
	lw	r1, 7(r3)
	beqi	3, r1, beq_then.11813
	lw	r2, 6(r3)
	lw	r5, 3(r2)
	lw	r6, 5(r3)
	lw	r7, 4(r3)
	sw	r5, 11(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 3(r3)
	lw	r2, 0(r1)
	addi	r2, r2, -1
	lw	r5, 4(r3)
	lw	r29, 2(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 11(r3)
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	lw	r29, 1(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.11814
beq_then.11813:
beq_cont.11814:
	lw	r1, 7(r3)
	beqi	4, r1, beq_then.11815
	lw	r1, 6(r3)
	lw	r1, 4(r1)
	lw	r2, 5(r3)
	lw	r5, 4(r3)
	sw	r1, 12(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 3(r3)
	lw	r1, 0(r1)
	addi	r2, r1, -1
	lw	r1, 4(r3)
	lw	r29, 2(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 12(r3)
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11815:
	jr	r31				#	blr
calc_diffuse_using_1point.3211:
	lw	r5, 3(r29)
	lw	r6, 2(r29)
	lw	r7, 1(r29)
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
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -9
	lw	r31, 8(r3)
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
	lw	r29, 3(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 5(r3)
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r1, 1(r3)
	lw	r5, 0(r3)
	j	vecaccumv.2904
calc_diffuse_using_5points.3214:
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
	sw	r8, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r6, 3(r3)
	sw	r12, 4(r3)
	sw	r11, 5(r3)
	sw	r9, 6(r3)
	sw	r7, 7(r3)
	sw	r10, 8(r3)
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 7(r3)
	lw	r2, 8(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 6(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	vecadd.2895				#	bl	vecadd.2895
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 7(r3)
	lw	r2, 5(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 6(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	vecadd.2895				#	bl	vecadd.2895
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 7(r3)
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 6(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	vecadd.2895				#	bl	vecadd.2895
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 7(r3)
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 6(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	vecadd.2895				#	bl	vecadd.2895
	addi	r3, r3, -10
	lw	r31, 9(r3)
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
	j	vecaccumv.2904
do_without_neighbors.3220:
	lw	r5, 1(r29)
	blei	4, r2, ble_then.11817
	jr	r31				#	blr
ble_then.11817:
	lw	r6, 2(r1)
	addi	r7, r0, 0				# li	r7, 0
	add	r30, r6, r2
	lw	r6, 0(r30)
	ble	r7, r6, ble_then.11819
	jr	r31				#	blr
ble_then.11819:
	lw	r6, 3(r1)
	add	r30, r6, r2
	lw	r6, 0(r30)
	sw	r1, 0(r3)
	sw	r29, 1(r3)
	sw	r2, 2(r3)
	beqi	0, r6, beq_then.11821
	add	r29, r0, r5				# mr	r29, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.11822
beq_then.11821:
beq_cont.11822:
	lw	r1, 2(r3)
	addi	r2, r1, 1
	lw	r1, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
neighbors_exist.3223:
	lw	r5, 1(r29)
	lw	r6, 1(r5)
	addi	r7, r2, 1
	ble	r6, r7, ble_then.11823
	blei	0, r2, ble_then.11824
	lw	r2, 0(r5)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.11825
	blei	0, r1, ble_then.11826
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
ble_then.11826:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
ble_then.11825:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
ble_then.11824:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
ble_then.11823:
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
neighbors_are_available.3230:
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
	beq	r2, r8, beq_then.11827
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.11827:
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.11828
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.11828:
	addi	r2, r1, -1
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.11829
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.11829:
	addi	r1, r1, 1
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beq	r1, r8, beq_then.11830
	addi	r1, r0, 0				# li	r1, 0
	jr	r31				#	blr
beq_then.11830:
	addi	r1, r0, 1				# li	r1, 1
	jr	r31				#	blr
try_exploit_neighbors.3236:
	lw	r9, 2(r29)
	lw	r10, 1(r29)
	add	r30, r6, r1
	lw	r11, 0(r30)
	blei	4, r8, ble_then.11831
	jr	r31				#	blr
ble_then.11831:
	addi	r12, r0, 0				# li	r12, 0
	lw	r13, 2(r11)
	add	r30, r13, r8
	lw	r13, 0(r30)
	ble	r12, r13, ble_then.11833
	jr	r31				#	blr
ble_then.11833:
	sw	r2, 0(r3)
	sw	r29, 1(r3)
	sw	r7, 2(r3)
	sw	r5, 3(r3)
	sw	r10, 4(r3)
	sw	r11, 5(r3)
	sw	r8, 6(r3)
	sw	r9, 7(r3)
	sw	r1, 8(r3)
	sw	r6, 9(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r8				# mr	r7, r8
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	neighbors_are_available.3230				#	bl	neighbors_are_available.3230
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.11835
	lw	r1, 5(r3)
	lw	r1, 3(r1)
	lw	r7, 6(r3)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beqi	0, r1, beq_then.11836
	lw	r1, 8(r3)
	lw	r2, 3(r3)
	lw	r5, 9(r3)
	lw	r6, 2(r3)
	lw	r29, 4(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.11837
beq_then.11836:
beq_cont.11837:
	lw	r1, 6(r3)
	addi	r8, r1, 1
	lw	r1, 8(r3)
	lw	r2, 0(r3)
	lw	r5, 3(r3)
	lw	r6, 9(r3)
	lw	r7, 2(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11835:
	lw	r1, 8(r3)
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 6(r3)
	lw	r29, 7(r3)
	lw	r28, 0(r29)
	jr	r28
write_ppm_header.3243:
	lw	r1, 1(r29)
	addi	r2, r0, 80				# li	r2, 80
	sw	r1, 0(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 51				# li	r1, 51
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 10				# li	r1, 10
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 0(r1)
	addi	r5, r0, 0				# li	r5, 0
	ble	r5, r2, ble_then.11838
	addi	r5, r0, 45				# li	r5, 45
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
	jal	print_uint.2796				#	bl	print_uint.2796
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.11839
ble_then.11838:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	print_uint.2796				#	bl	print_uint.2796
	addi	r3, r3, -3
	lw	r31, 2(r3)
ble_cont.11839:
	addi	r1, r0, 32				# li	r1, 32
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 0(r3)
	lw	r1, 1(r1)
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.11840
	addi	r2, r0, 45				# li	r2, 45
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
	jal	print_uint.2796				#	bl	print_uint.2796
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	ble_cont.11841
ble_then.11840:
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2796				#	bl	print_uint.2796
	addi	r3, r3, -4
	lw	r31, 3(r3)
ble_cont.11841:
	addi	r1, r0, 32				# li	r1, 32
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 255				# li	r1, 255
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2796				#	bl	print_uint.2796
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 10				# li	r1, 10
	j	lib_print_char
write_rgb.3247:
	lw	r1, 1(r29)
	flw	f1, 0(r1)
	flup	f2, 0		# fli	f2, 0.000000
	sw	r1, 0(r3)
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11842
	addi	r1, r0, 0				# li	r1, 0
	j	feq_cont.11843
feq_else.11842:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11844
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_ftoi				#	bl	lib_ftoi
	addi	r3, r3, -2
	lw	r31, 1(r3)
	j	fle_cont.11845
fle_else.11844:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_ftoi				#	bl	lib_ftoi
	addi	r3, r3, -2
	lw	r31, 1(r3)
fle_cont.11845:
feq_cont.11843:
	addi	r2, r0, 255				# li	r2, 255
	ble	r1, r2, ble_then.11846
	addi	r1, r0, 255				# li	r1, 255
	j	ble_cont.11847
ble_then.11846:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.11848
	addi	r1, r0, 0				# li	r1, 0
	j	ble_cont.11849
ble_then.11848:
ble_cont.11849:
ble_cont.11847:
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	print_int.2798				#	bl	print_int.2798
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 32				# li	r1, 32
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	flw	f1, 1(r1)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11850
	addi	r1, r0, 0				# li	r1, 0
	j	feq_cont.11851
feq_else.11850:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11852
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_ftoi				#	bl	lib_ftoi
	addi	r3, r3, -2
	lw	r31, 1(r3)
	j	fle_cont.11853
fle_else.11852:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_ftoi				#	bl	lib_ftoi
	addi	r3, r3, -2
	lw	r31, 1(r3)
fle_cont.11853:
feq_cont.11851:
	addi	r2, r0, 255				# li	r2, 255
	ble	r1, r2, ble_then.11854
	addi	r1, r0, 255				# li	r1, 255
	j	ble_cont.11855
ble_then.11854:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.11856
	addi	r1, r0, 0				# li	r1, 0
	j	ble_cont.11857
ble_then.11856:
ble_cont.11857:
ble_cont.11855:
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	print_int.2798				#	bl	print_int.2798
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 32				# li	r1, 32
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				#	bl	lib_print_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	flw	f1, 2(r1)
	flup	f2, 0		# fli	f2, 0.000000
	feq	r30, f1, f2
	beq	r0, r30, feq_else.11858
	addi	r1, r0, 0				# li	r1, 0
	j	feq_cont.11859
feq_else.11858:
	flup	f2, 0		# fli	f2, 0.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11860
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_ftoi				#	bl	lib_ftoi
	addi	r3, r3, -2
	lw	r31, 1(r3)
	j	fle_cont.11861
fle_else.11860:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_ftoi				#	bl	lib_ftoi
	addi	r3, r3, -2
	lw	r31, 1(r3)
fle_cont.11861:
feq_cont.11859:
	addi	r2, r0, 255				# li	r2, 255
	ble	r1, r2, ble_then.11862
	addi	r1, r0, 255				# li	r1, 255
	j	ble_cont.11863
ble_then.11862:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.11864
	addi	r1, r0, 0				# li	r1, 0
	j	ble_cont.11865
ble_then.11864:
ble_cont.11865:
ble_cont.11863:
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	print_int.2798				#	bl	print_int.2798
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 10				# li	r1, 10
	j	lib_print_char
pretrace_diffuse_rays.3249:
	lw	r5, 6(r29)
	lw	r6, 5(r29)
	lw	r7, 4(r29)
	lw	r8, 3(r29)
	lw	r9, 2(r29)
	lw	r10, 1(r29)
	blei	4, r2, ble_then.11866
	jr	r31				#	blr
ble_then.11866:
	lw	r11, 2(r1)
	add	r30, r11, r2
	lw	r11, 0(r30)
	addi	r12, r0, 0				# li	r12, 0
	ble	r12, r11, ble_then.11868
	jr	r31				#	blr
ble_then.11868:
	lw	r11, 3(r1)
	add	r30, r11, r2
	lw	r11, 0(r30)
	sw	r1, 0(r3)
	sw	r29, 1(r3)
	sw	r2, 2(r3)
	beqi	0, r11, beq_then.11870
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
	sw	r10, 3(r3)
	sw	r11, 4(r3)
	sw	r9, 5(r3)
	sw	r8, 6(r3)
	sw	r12, 7(r3)
	sw	r6, 8(r3)
	sw	r7, 9(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 9(r3)
	lw	r1, 0(r1)
	addi	r2, r1, -1
	lw	r1, 7(r3)
	lw	r29, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r6, r0, 118				# li	r6, 118
	lw	r1, 5(r3)
	lw	r2, 4(r3)
	lw	r5, 7(r3)
	lw	r29, 6(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 0(r3)
	lw	r2, 5(r1)
	lw	r5, 2(r3)
	add	r30, r2, r5
	lw	r2, 0(r30)
	lw	r6, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r6				# mr	r2, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.11871
beq_then.11870:
beq_cont.11871:
	lw	r1, 2(r3)
	addi	r2, r1, 1
	lw	r1, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_pixels.3252:
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
	addi	r16, r0, 0				# li	r16, 0
	ble	r16, r2, ble_then.11872
	jr	r31				#	blr
ble_then.11872:
	flw	f4, 0(r10)
	lw	r10, 0(r14)
	sub	r10, r2, r10
	sw	r29, 0(r3)
	sw	r13, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	sw	r8, 7(r3)
	sw	r11, 8(r3)
	sw	r15, 9(r3)
	fsw	f3, 10(r3)				
	fsw	f2, 12(r3)				
	sw	r12, 14(r3)
	fsw	f1, 16(r3)				
	sw	r9, 18(r3)
	fsw	f4, 20(r3)				
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_itof				#	bl	lib_itof
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 20(r3)				
	fmul	f1, f2, f1
	lw	r1, 18(r3)
	flw	f2, 0(r1)
	fmul	f2, f1, f2
	flw	f3, 16(r3)				
	fadd	f2, f2, f3
	lw	r2, 14(r3)
	fsw	f2, 0(r2)
	flw	f2, 1(r1)
	fmul	f2, f1, f2
	flw	f4, 12(r3)				
	fadd	f2, f2, f4
	fsw	f2, 1(r2)
	flw	f2, 2(r1)
	fmul	f1, f1, f2
	flw	f2, 10(r3)				
	fadd	f1, f1, f2
	fsw	f1, 2(r2)
	lw	r1, 9(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	vecunit_sgn.2880				#	bl	vecunit_sgn.2880
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flup	f1, 0		# fli	f1, 0.000000
	lw	r1, 8(r3)
	fsw	f1, 0(r1)
	fsw	f1, 1(r1)
	fsw	f1, 2(r1)
	lw	r2, 7(r3)
	lw	r5, 6(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -23
	lw	r31, 22(r3)
	addi	r1, r0, 0				# li	r1, 0
	flup	f1, 2		# fli	f1, 1.000000
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r6, 0(r30)
	flup	f2, 0		# fli	f2, 0.000000
	lw	r7, 14(r3)
	lw	r29, 3(r3)
	add	r5, r0, r6				# mr	r5, r6
	add	r2, r0, r7				# mr	r2, r7
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
	lw	r1, 4(r3)
	lw	r2, 5(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	lw	r6, 8(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -23
	lw	r31, 22(r3)
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
	lw	r29, 1(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
	lw	r1, 4(r3)
	addi	r2, r1, -1
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r1, ble_then.11876
	add	r5, r0, r1				# mr	r5, r1
	j	ble_cont.11877
ble_then.11876:
	addi	r5, r1, -5
ble_cont.11877:
	flw	f1, 16(r3)				
	flw	f2, 12(r3)				
	flw	f3, 10(r3)				
	lw	r1, 5(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_line.3259:
	lw	r6, 6(r29)
	lw	r7, 5(r29)
	lw	r8, 4(r29)
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	flw	f1, 0(r8)
	lw	r8, 1(r11)
	sub	r2, r2, r8
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	sw	r9, 2(r3)
	sw	r10, 3(r3)
	sw	r6, 4(r3)
	sw	r7, 5(r3)
	fsw	f1, 6(r3)				
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_itof				#	bl	lib_itof
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)				
	fmul	f1, f2, f1
	lw	r1, 5(r3)
	flw	f2, 0(r1)
	fmul	f2, f1, f2
	lw	r2, 4(r3)
	flw	f3, 0(r2)
	fadd	f2, f2, f3
	flw	f3, 1(r1)
	fmul	f3, f1, f3
	flw	f4, 1(r2)
	fadd	f3, f3, f4
	flw	f4, 2(r1)
	fmul	f1, f1, f4
	flw	f4, 2(r2)
	fadd	f1, f1, f4
	lw	r1, 3(r3)
	lw	r1, 0(r1)
	addi	r2, r1, -1
	lw	r1, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 2(r3)
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	lw	r28, 0(r29)
	jr	r28
scan_pixel.3263:
	lw	r8, 6(r29)
	lw	r9, 5(r29)
	lw	r10, 4(r29)
	lw	r11, 3(r29)
	lw	r12, 2(r29)
	lw	r13, 1(r29)
	lw	r12, 0(r12)
	ble	r12, r1, ble_then.11878
	add	r30, r6, r1
	lw	r12, 0(r30)
	lw	r12, 0(r12)
	sw	r29, 0(r3)
	sw	r8, 1(r3)
	sw	r5, 2(r3)
	sw	r9, 3(r3)
	sw	r13, 4(r3)
	sw	r6, 5(r3)
	sw	r7, 6(r3)
	sw	r2, 7(r3)
	sw	r1, 8(r3)
	sw	r11, 9(r3)
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r10				# mr	r1, r10
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 8(r3)
	lw	r2, 7(r3)
	lw	r5, 6(r3)
	lw	r29, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.11879
	addi	r8, r0, 0				# li	r8, 0
	lw	r1, 8(r3)
	lw	r2, 7(r3)
	lw	r5, 2(r3)
	lw	r6, 5(r3)
	lw	r7, 6(r3)
	lw	r29, 3(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.11880
beq_then.11879:
	lw	r1, 8(r3)
	lw	r2, 5(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 0				# li	r6, 0
	lw	r29, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
beq_cont.11880:
	lw	r29, 1(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 8(r3)
	addi	r1, r1, 1
	lw	r2, 7(r3)
	lw	r5, 2(r3)
	lw	r6, 5(r3)
	lw	r7, 6(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
ble_then.11878:
	jr	r31				#	blr
scan_line.3269:
	lw	r8, 3(r29)
	lw	r9, 2(r29)
	lw	r10, 1(r29)
	lw	r11, 1(r10)
	ble	r11, r1, ble_then.11882
	lw	r10, 1(r10)
	addi	r10, r10, -1
	sw	r29, 0(r3)
	sw	r7, 1(r3)
	sw	r6, 2(r3)
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	sw	r8, 6(r3)
	ble	r10, r1, ble_then.11883
	addi	r10, r1, 1
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r6				# mr	r1, r6
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	ble_cont.11884
ble_then.11883:
ble_cont.11884:
	addi	r1, r0, 0				# li	r1, 0
	lw	r2, 5(r3)
	lw	r5, 4(r3)
	lw	r6, 3(r3)
	lw	r7, 2(r3)
	lw	r29, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r2, ble_then.11885
	add	r7, r0, r2				# mr	r7, r2
	j	ble_cont.11886
ble_then.11885:
	addi	r7, r2, -5
ble_cont.11886:
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	lw	r29, 0(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	jr	r31				#	blr
ble_then.11882:
	jr	r31				#	blr
create_float5x3array.3275:
	addi	r1, r0, 3				# li	r1, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -1
	lw	r31, 0(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 5				# li	r1, 5
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r2, r0, 3				# li	r2, 3
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
	addi	r1, r0, 3				# li	r1, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3				# li	r1, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3				# li	r1, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	sw	r1, 4(r2)
	add	r1, r0, r2				# mr	r1, r2
	jr	r31				#	blr
create_pixel.3277:
	lw	r1, 1(r29)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r31, 1(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	create_float5x3array.3275				#	bl	create_float5x3array.3275
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r2, r0, 5				# li	r2, 5
	addi	r5, r0, 0				# li	r5, 0
	sw	r1, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 5				# li	r2, 5
	lw	r5, 0(r3)
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_float5x3array.3275				#	bl	create_float5x3array.3275
	addi	r3, r3, -6
	lw	r31, 5(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3275				#	bl	create_float5x3array.3275
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r2, r0, 1				# li	r2, 1
	addi	r5, r0, 0				# li	r5, 0
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
	jal	create_float5x3array.3275				#	bl	create_float5x3array.3275
	addi	r3, r3, -9
	lw	r31, 8(r3)
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
init_line_elements.3279:
	lw	r5, 1(r29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.11889
	jr	r31				#	blr
ble_then.11889:
	sw	r29, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	add	r29, r0, r5				# mr	r29, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.11890
	add	r1, r0, r5				# mr	r1, r5
	jr	r31				#	blr
ble_then.11890:
	lw	r29, 1(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 4(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r28, 0(r29)
	jr	r28
calc_dirvec.3289:
	lw	r6, 1(r29)
	addi	r7, r0, 5				# li	r7, 5
	ble	r7, r1, ble_then.11891
	fmul	f1, f2, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f1, f1, f2
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r29, 2(r3)
	fsw	f4, 4(r3)				
	sw	r1, 6(r3)
	fsw	f3, 8(r3)				
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f2, f2, f1
	fsw	f1, 10(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	atan.2770				#	bl	atan.2770
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 8(r3)				
	fmul	f1, f1, f2
	fsw	f1, 12(r3)				
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin.2764				#	bl	sin.2764
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)				
	fsw	f1, 14(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)				
	fdiv	f1, f2, f1
	flw	f2, 10(r3)				
	fmul	f1, f1, f2
	lw	r1, 6(r3)
	addi	r1, r1, 1
	fmul	f2, f1, f1
	flup	f3, 45		# fli	f3, 0.100000
	fadd	f2, f2, f3
	fsw	f1, 16(r3)				
	sw	r1, 18(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -20
	lw	r31, 19(r3)
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f2, f2, f1
	fsw	f1, 20(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	atan.2770				#	bl	atan.2770
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 4(r3)				
	fmul	f1, f1, f2
	fsw	f1, 22(r3)				
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	sin.2764				#	bl	sin.2764
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 22(r3)				
	fsw	f1, 24(r3)				
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	cos.2766				#	bl	cos.2766
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 24(r3)				
	fdiv	f1, f2, f1
	flw	f2, 20(r3)				
	fmul	f2, f1, f2
	flw	f1, 16(r3)				
	flw	f3, 8(r3)				
	flw	f4, 4(r3)				
	lw	r1, 18(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
ble_then.11891:
	fmul	f3, f1, f1
	fmul	f4, f2, f2
	fadd	f3, f3, f4
	flup	f4, 2		# fli	f4, 1.000000
	fadd	f3, f3, f4
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r6, 26(r3)
	fsw	f2, 28(r3)				
	fsw	f1, 30(r3)				
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	lib_sqrt				#	bl	lib_sqrt
	addi	r3, r3, -33
	lw	r31, 32(r3)
	flw	f2, 30(r3)				
	fdiv	f2, f2, f1
	flw	f3, 28(r3)				
	fdiv	f3, f3, f1
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	lw	r1, 1(r3)
	lw	r2, 26(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 0(r3)
	add	r30, r1, r2
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	fsw	f2, 0(r5)
	fsw	f3, 1(r5)
	fsw	f1, 2(r5)
	addi	r5, r2, 40
	add	r30, r1, r5
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	fneg	f4, f3
	fsw	f2, 0(r5)
	fsw	f1, 1(r5)
	fsw	f4, 2(r5)
	addi	r5, r2, 80
	add	r30, r1, r5
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	fneg	f5, f2
	fsw	f1, 0(r5)
	fsw	f5, 1(r5)
	fsw	f4, 2(r5)
	addi	r5, r2, 1
	add	r30, r1, r5
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	fneg	f1, f1
	fsw	f5, 0(r5)
	fsw	f4, 1(r5)
	fsw	f1, 2(r5)
	addi	r5, r2, 41
	add	r30, r1, r5
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	fsw	f5, 0(r5)
	fsw	f1, 1(r5)
	fsw	f3, 2(r5)
	addi	r2, r2, 81
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 0(r1)
	fsw	f1, 0(r1)
	fsw	f2, 1(r1)
	fsw	f3, 2(r1)
	jr	r31				#	blr
calc_dirvecs.3297:
	lw	r6, 1(r29)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.11897
	jr	r31				#	blr
ble_then.11897:
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	fsw	f1, 2(r3)				
	sw	r5, 4(r3)
	sw	r2, 5(r3)
	sw	r6, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_itof				#	bl	lib_itof
	addi	r3, r3, -8
	lw	r31, 7(r3)
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f3, f1, f2
	addi	r1, r0, 0				# li	r1, 0
	flup	f1, 0		# fli	f1, 0.000000
	flup	f2, 0		# fli	f2, 0.000000
	flw	f4, 2(r3)				
	lw	r2, 5(r3)
	lw	r5, 4(r3)
	lw	r29, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 1(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_itof				#	bl	lib_itof
	addi	r3, r3, -8
	lw	r31, 7(r3)
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f3, f1, f2
	addi	r1, r0, 0				# li	r1, 0
	flup	f1, 0		# fli	f1, 0.000000
	flup	f2, 0		# fli	f2, 0.000000
	lw	r2, 4(r3)
	addi	r5, r2, 2
	flw	f4, 2(r3)				
	lw	r6, 5(r3)
	lw	r29, 6(r3)
	add	r2, r0, r6				# mr	r2, r6
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 1(r3)
	addi	r1, r1, -1
	lw	r2, 5(r3)
	addi	r2, r2, 1
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r2, ble_then.11899
	j	ble_cont.11900
ble_then.11899:
	addi	r2, r2, -5
ble_cont.11900:
	flw	f1, 2(r3)				
	lw	r5, 4(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
calc_dirvec_rows.3302:
	lw	r6, 1(r29)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.11901
	jr	r31				#	blr
ble_then.11901:
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r6, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_itof				#	bl	lib_itof
	addi	r3, r3, -6
	lw	r31, 5(r3)
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f1, f1, f2
	addi	r1, r0, 4				# li	r1, 4
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	lw	r29, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 1(r3)
	addi	r1, r1, -1
	lw	r2, 3(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5				# li	r5, 5
	ble	r5, r2, ble_then.11903
	j	ble_cont.11904
ble_then.11903:
	addi	r2, r2, -5
ble_cont.11904:
	lw	r5, 2(r3)
	addi	r5, r5, 4
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
create_dirvec_elements.3308:
	lw	r5, 1(r29)
	addi	r6, r0, 0				# li	r6, 0
	ble	r6, r2, ble_then.11905
	jr	r31				#	blr
ble_then.11905:
	addi	r6, r0, 3				# li	r6, 3
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
	addi	r1, r2, -1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.11907
	jr	r31				#	blr
ble_then.11907:
	addi	r2, r0, 3				# li	r2, 3
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
	lw	r1, 0(r1)
	sw	r2, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
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
	addi	r2, r2, -1
	lw	r29, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r28, 0(r29)
	jr	r28
create_dirvecs.3311:
	lw	r2, 3(r29)
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.11909
	jr	r31				#	blr
ble_then.11909:
	addi	r7, r0, 120				# li	r7, 120
	addi	r8, r0, 3				# li	r8, 3
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
	add	r2, r0, r4				# mr	r2, r4
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
	addi	r5, r0, 3				# li	r5, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 7(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 5(r3)
	lw	r1, 0(r1)
	sw	r2, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 8(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	lw	r2, 7(r3)
	sw	r1, 118(r2)
	addi	r1, r0, 117				# li	r1, 117
	lw	r29, 1(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 2(r3)
	addi	r1, r1, -1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
init_dirvec_constants.3313:
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r2, ble_then.11911
	jr	r31				#	blr
ble_then.11911:
	add	r30, r1, r2
	lw	r7, 0(r30)
	lw	r8, 0(r5)
	addi	r8, r8, -1
	sw	r29, 0(r3)
	sw	r6, 1(r3)
	sw	r5, 2(r3)
	sw	r1, 3(r3)
	sw	r2, 4(r3)
	add	r2, r0, r8				# mr	r2, r8
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
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.11913
	jr	r31				#	blr
ble_then.11913:
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 2(r3)
	lw	r6, 0(r6)
	addi	r6, r6, -1
	lw	r29, 1(r3)
	sw	r1, 5(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r2, r1, -1
	lw	r1, 3(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
init_vecset_constants.3316:
	lw	r2, 4(r29)
	lw	r5, 3(r29)
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	addi	r8, r0, 0				# li	r8, 0
	ble	r8, r1, ble_then.11915
	jr	r31				#	blr
ble_then.11915:
	add	r30, r7, r1
	lw	r8, 0(r30)
	lw	r9, 119(r8)
	lw	r2, 0(r2)
	addi	r2, r2, -1
	sw	r29, 0(r3)
	sw	r7, 1(r3)
	sw	r1, 2(r3)
	sw	r8, 3(r3)
	sw	r6, 4(r3)
	add	r1, r0, r9				# mr	r1, r9
	add	r29, r0, r5				# mr	r29, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r2, r0, 118				# li	r2, 118
	lw	r1, 3(r3)
	lw	r29, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 2(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.11917
	jr	r31				#	blr
ble_then.11917:
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	addi	r5, r0, 119				# li	r5, 119
	lw	r29, 4(r3)
	sw	r1, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, -1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
setup_rect_reflection.3327:
	lw	r5, 5(r29)
	lw	r6, 4(r29)
	lw	r7, 3(r29)
	lw	r8, 2(r29)
	lw	r9, 1(r29)
	slli	r1, r1, 2
	lw	r10, 0(r6)
	flup	f1, 2		# fli	f1, 1.000000
	lw	r2, 7(r2)
	flw	f2, 0(r2)
	fsub	f1, f1, f2
	flw	f2, 0(r8)
	fneg	f2, f2
	flw	f3, 1(r8)
	fneg	f3, f3
	flw	f4, 2(r8)
	fneg	f4, f4
	addi	r2, r1, 1
	flw	f5, 0(r8)
	addi	r11, r0, 3				# li	r11, 3
	flup	f6, 0		# fli	f6, 0.000000
	sw	r6, 0(r3)
	fsw	f2, 2(r3)				
	sw	r8, 4(r3)
	sw	r1, 5(r3)
	sw	r10, 6(r3)
	sw	r5, 7(r3)
	sw	r2, 8(r3)
	fsw	f1, 10(r3)				
	sw	r9, 12(r3)
	fsw	f4, 14(r3)				
	fsw	f3, 16(r3)				
	fsw	f5, 18(r3)				
	sw	r7, 20(r3)
	add	r1, r0, r11				# mr	r1, r11
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
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 21(r3)
	sw	r1, 0(r2)
	flw	f1, 18(r3)				
	fsw	f1, 0(r1)
	flw	f1, 16(r3)				
	fsw	f1, 1(r1)
	flw	f2, 14(r3)				
	fsw	f2, 2(r1)
	lw	r1, 20(r3)
	lw	r5, 0(r1)
	addi	r5, r5, -1
	lw	r29, 12(r3)
	sw	r2, 22(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -24
	lw	r31, 23(r3)
	add	r1, r0, r4				# mr	r1, r4
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
	addi	r9, r0, 3				# li	r9, 3
	flup	f3, 0		# fli	f3, 0.000000
	sw	r1, 23(r3)
	sw	r7, 24(r3)
	fsw	f2, 26(r3)				
	add	r1, r0, r9				# mr	r1, r9
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -29
	lw	r31, 28(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 20(r3)
	lw	r5, 0(r1)
	sw	r2, 28(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -30
	lw	r31, 29(r3)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 28(r3)
	sw	r1, 0(r2)
	flw	f1, 2(r3)				
	fsw	f1, 0(r1)
	flw	f2, 26(r3)				
	fsw	f2, 1(r1)
	flw	f2, 14(r3)				
	fsw	f2, 2(r1)
	lw	r1, 20(r3)
	lw	r5, 0(r1)
	addi	r5, r5, -1
	lw	r29, 12(r3)
	sw	r2, 29(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 30(r3)
	addi	r3, r3, 31
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -31
	lw	r31, 30(r3)
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 3
	flw	f1, 10(r3)				
	fsw	f1, 2(r1)
	lw	r2, 29(r3)
	sw	r2, 1(r1)
	lw	r2, 24(r3)
	sw	r2, 0(r1)
	lw	r2, 23(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 6(r3)
	addi	r2, r1, 2
	lw	r6, 5(r3)
	addi	r6, r6, 3
	lw	r7, 4(r3)
	flw	f2, 2(r7)
	addi	r7, r0, 3				# li	r7, 3
	flup	f3, 0		# fli	f3, 0.000000
	sw	r2, 30(r3)
	sw	r6, 31(r3)
	fsw	f2, 32(r3)				
	add	r1, r0, r7				# mr	r1, r7
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -35
	lw	r31, 34(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 20(r3)
	lw	r5, 0(r1)
	sw	r2, 34(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 35(r3)
	addi	r3, r3, 36
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -36
	lw	r31, 35(r3)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 34(r3)
	sw	r1, 0(r2)
	flw	f1, 2(r3)				
	fsw	f1, 0(r1)
	flw	f1, 16(r3)				
	fsw	f1, 1(r1)
	flw	f1, 32(r3)				
	fsw	f1, 2(r1)
	lw	r1, 20(r3)
	lw	r1, 0(r1)
	addi	r1, r1, -1
	lw	r29, 12(r3)
	sw	r2, 35(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 36(r3)
	addi	r3, r3, 37
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -37
	lw	r31, 36(r3)
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 3
	flw	f1, 10(r3)				
	fsw	f1, 2(r1)
	lw	r2, 35(r3)
	sw	r2, 1(r1)
	lw	r2, 31(r3)
	sw	r2, 0(r1)
	lw	r2, 30(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 6(r3)
	addi	r1, r1, 3
	lw	r2, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#	blr
setup_surface_reflection.3330:
	lw	r5, 5(r29)
	lw	r6, 4(r29)
	lw	r7, 3(r29)
	lw	r8, 2(r29)
	lw	r9, 1(r29)
	slli	r1, r1, 2
	addi	r1, r1, 1
	lw	r10, 0(r6)
	flup	f1, 2		# fli	f1, 1.000000
	lw	r11, 7(r2)
	flw	f2, 0(r11)
	fsub	f1, f1, f2
	lw	r11, 4(r2)
	sw	r6, 0(r3)
	sw	r10, 1(r3)
	sw	r5, 2(r3)
	sw	r1, 3(r3)
	fsw	f1, 4(r3)				
	sw	r9, 6(r3)
	sw	r7, 7(r3)
	sw	r8, 8(r3)
	sw	r2, 9(r3)
	add	r2, r0, r11				# mr	r2, r11
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	veciprod.2883				#	bl	veciprod.2883
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flup	f2, 3		# fli	f2, 2.000000
	lw	r1, 9(r3)
	lw	r2, 4(r1)
	flw	f3, 0(r2)
	fmul	f2, f2, f3
	fmul	f2, f2, f1
	lw	r2, 8(r3)
	flw	f3, 0(r2)
	fsub	f2, f2, f3
	flup	f3, 3		# fli	f3, 2.000000
	lw	r5, 4(r1)
	flw	f4, 1(r5)
	fmul	f3, f3, f4
	fmul	f3, f3, f1
	flw	f4, 1(r2)
	fsub	f3, f3, f4
	flup	f4, 3		# fli	f4, 2.000000
	lw	r1, 4(r1)
	flw	f5, 2(r1)
	fmul	f4, f4, f5
	fmul	f1, f4, f1
	flw	f4, 2(r2)
	fsub	f1, f1, f4
	addi	r1, r0, 3				# li	r1, 3
	flup	f4, 0		# fli	f4, 0.000000
	fsw	f1, 10(r3)				
	fsw	f3, 12(r3)				
	fsw	f2, 14(r3)				
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -17
	lw	r31, 16(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 7(r3)
	lw	r5, 0(r1)
	sw	r2, 16(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -18
	lw	r31, 17(r3)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 16(r3)
	sw	r1, 0(r2)
	flw	f1, 14(r3)				
	fsw	f1, 0(r1)
	flw	f1, 12(r3)				
	fsw	f1, 1(r1)
	flw	f1, 10(r3)				
	fsw	f1, 2(r1)
	lw	r1, 7(r3)
	lw	r1, 0(r1)
	addi	r1, r1, -1
	lw	r29, 6(r3)
	sw	r2, 17(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 3
	flw	f1, 4(r3)				
	fsw	f1, 2(r1)
	lw	r2, 17(r3)
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
	jr	r31				#	blr
setup_reflections.3333:
	lw	r2, 3(r29)
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	addi	r7, r0, 0				# li	r7, 0
	ble	r7, r1, ble_then.11925
	jr	r31				#	blr
ble_then.11925:
	add	r30, r6, r1
	lw	r6, 0(r30)
	lw	r7, 2(r6)
	beqi	2, r7, beq_then.11927
	jr	r31				#	blr
beq_then.11927:
	lw	r7, 7(r6)
	flw	f1, 0(r7)
	flup	f2, 2		# fli	f2, 1.000000
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r6, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_fless				#	bl	lib_fless
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.11929
	lw	r2, 3(r3)
	lw	r1, 1(r2)
	beqi	1, r1, beq_then.11930
	beqi	2, r1, beq_then.11931
	jr	r31				#	blr
beq_then.11931:
	lw	r1, 1(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11930:
	lw	r1, 1(r3)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.11929:
	jr	r31				#	blr
rt.3335:
	lw	r5, 18(r29)
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
	sw	r1, 0(r18)
	sw	r2, 1(r18)
	srai	r23, r1, 1
	sw	r23, 0(r19)
	srai	r2, r2, 1
	sw	r2, 1(r19)
	flup	f1, 49		# fli	f1, 128.000000
	sw	r9, 0(r3)
	sw	r11, 1(r3)
	sw	r7, 2(r3)
	sw	r13, 3(r3)
	sw	r15, 4(r3)
	sw	r12, 5(r3)
	sw	r14, 6(r3)
	sw	r6, 7(r3)
	sw	r16, 8(r3)
	sw	r22, 9(r3)
	sw	r21, 10(r3)
	sw	r5, 11(r3)
	sw	r10, 12(r3)
	sw	r17, 13(r3)
	sw	r20, 14(r3)
	sw	r18, 15(r3)
	sw	r8, 16(r3)
	fsw	f1, 18(r3)				
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	lib_itof				#	bl	lib_itof
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 18(r3)				
	fdiv	f1, f2, f1
	lw	r1, 16(r3)
	fsw	f1, 0(r1)
	lw	r1, 15(r3)
	lw	r2, 0(r1)
	lw	r29, 14(r3)
	sw	r2, 20(r3)
	sw	r31, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -22
	lw	r31, 21(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 20(r3)
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -22
	lw	r31, 21(r3)
	lw	r2, 15(r3)
	lw	r5, 0(r2)
	addi	r5, r5, -2
	lw	r29, 13(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -22
	lw	r31, 21(r3)
	lw	r2, 15(r3)
	lw	r5, 0(r2)
	lw	r29, 14(r3)
	sw	r1, 21(r3)
	sw	r5, 22(r3)
	sw	r31, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -24
	lw	r31, 23(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 22(r3)
	sw	r31, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -24
	lw	r31, 23(r3)
	lw	r2, 15(r3)
	lw	r5, 0(r2)
	addi	r5, r5, -2
	lw	r29, 13(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -24
	lw	r31, 23(r3)
	lw	r2, 15(r3)
	lw	r5, 0(r2)
	lw	r29, 14(r3)
	sw	r1, 23(r3)
	sw	r5, 24(r3)
	sw	r31, 25(r3)
	addi	r3, r3, 26
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -26
	lw	r31, 25(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 24(r3)
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r2, 15(r3)
	lw	r2, 0(r2)
	addi	r2, r2, -2
	lw	r29, 13(r3)
	sw	r31, 25(r3)
	addi	r3, r3, 26
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r29, 12(r3)
	sw	r1, 25(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r29, 11(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -27
	lw	r31, 26(r3)
	addi	r1, r0, 4				# li	r1, 4
	lw	r29, 10(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -27
	lw	r31, 26(r3)
	addi	r1, r0, 9				# li	r1, 9
	addi	r2, r0, 0				# li	r2, 0
	addi	r5, r0, 0				# li	r5, 0
	lw	r29, 9(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -27
	lw	r31, 26(r3)
	addi	r1, r0, 4				# li	r1, 4
	lw	r29, 8(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r1, 7(r3)
	lw	r2, 6(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	veccpy.2872				#	bl	veccpy.2872
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r1, 5(r3)
	lw	r2, 0(r1)
	addi	r2, r2, -1
	lw	r5, 3(r3)
	lw	r29, 4(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r1, 5(r3)
	lw	r1, 0(r1)
	addi	r1, r1, -1
	lw	r29, 2(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -27
	lw	r31, 26(r3)
	addi	r2, r0, 0				# li	r2, 0
	addi	r5, r0, 0				# li	r5, 0
	lw	r1, 23(r3)
	lw	r29, 1(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -27
	lw	r31, 26(r3)
	addi	r1, r0, 0				# li	r1, 0
	addi	r7, r0, 2				# li	r7, 2
	lw	r2, 21(r3)
	lw	r5, 23(r3)
	lw	r6, 25(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
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
	addi	r1, r0, 1				# li	r1, 1
	addi	r2, r0, 0				# li	r2, 0
	addi	r5, r0, 1				# li	r5, 1
	addi	r6, r0, 0				# li	r6, 0
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r2, r0, 0				# li	r2, 0
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
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
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 4(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r2, r0, 1				# li	r2, 1
	flup	f1, 37		# fli	f1, 255.000000
	sw	r1, 6(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r2, r0, 50				# li	r2, 50
	addi	r5, r0, 1				# li	r5, 1
	addi	r6, r0, -1				# li	r6, -1
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
	addi	r2, r0, 1				# li	r2, 1
	addi	r5, r0, 1				# li	r5, 1
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
	addi	r2, r0, 1				# li	r2, 1
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 11(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r2, r0, 1				# li	r2, 1
	addi	r5, r0, 0				# li	r5, 0
	sw	r1, 12(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r2, r0, 1				# li	r2, 1
	flup	f1, 31		# fli	f1, 1000000000.000000
	sw	r1, 13(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 14(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -16
	lw	r31, 15(r3)
	addi	r2, r0, 1				# li	r2, 1
	addi	r5, r0, 0				# li	r5, 0
	sw	r1, 15(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r31, 16(r3)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 16(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -18
	lw	r31, 17(r3)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 17(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -19
	lw	r31, 18(r3)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 18(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -20
	lw	r31, 19(r3)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 19(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -21
	lw	r31, 20(r3)
	addi	r2, r0, 2				# li	r2, 2
	addi	r5, r0, 0				# li	r5, 0
	sw	r1, 20(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -22
	lw	r31, 21(r3)
	addi	r2, r0, 2				# li	r2, 2
	addi	r5, r0, 0				# li	r5, 0
	sw	r1, 21(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -23
	lw	r31, 22(r3)
	addi	r2, r0, 1				# li	r2, 1
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 22(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -24
	lw	r31, 23(r3)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 23(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -25
	lw	r31, 24(r3)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 24(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -26
	lw	r31, 25(r3)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 25(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -27
	lw	r31, 26(r3)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 26(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 27(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -29
	lw	r31, 28(r3)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 28(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -30
	lw	r31, 29(r3)
	addi	r2, r0, 0				# li	r2, 0
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 29(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -31
	lw	r31, 30(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 0				# li	r1, 0
	sw	r2, 30(r3)
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r31, 31(r3)
	addi	r2, r0, 0				# li	r2, 0
	add	r5, r0, r4				# mr	r5, r4
	addi	r4, r4, 2
	sw	r1, 1(r5)
	lw	r1, 30(r3)
	sw	r1, 0(r5)
	add	r1, r0, r5				# mr	r1, r5
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r31, 31(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 5				# li	r1, 5
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -32
	lw	r31, 31(r3)
	addi	r2, r0, 0				# li	r2, 0
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 31(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -33
	lw	r31, 32(r3)
	addi	r2, r0, 3				# li	r2, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 32(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -34
	lw	r31, 33(r3)
	addi	r2, r0, 60				# li	r2, 60
	lw	r5, 32(r3)
	sw	r1, 33(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -35
	lw	r31, 34(r3)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 33(r3)
	sw	r1, 0(r2)
	addi	r5, r0, 0				# li	r5, 0
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 34(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 35(r3)
	addi	r3, r3, 36
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -36
	lw	r31, 35(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 0				# li	r1, 0
	sw	r2, 35(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -37
	lw	r31, 36(r3)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 35(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2				# mr	r1, r2
	addi	r2, r0, 180				# li	r2, 180
	addi	r5, r0, 0				# li	r5, 0
	flup	f1, 0		# fli	f1, 0.000000
	add	r6, r0, r4				# mr	r6, r4
	addi	r4, r4, 3
	fsw	f1, 2(r6)
	sw	r1, 1(r6)
	sw	r5, 0(r6)
	add	r1, r0, r6				# mr	r1, r6
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -37
	lw	r31, 36(r3)
	addi	r2, r0, 1				# li	r2, 1
	addi	r5, r0, 0				# li	r5, 0
	sw	r1, 36(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 37(r3)
	addi	r3, r3, 38
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -38
	lw	r31, 37(r3)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 6
	addi	r5, r0, read_screen_settings.2981
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
	addi	r10, r0, read_light.2983
	sw	r10, 0(r9)
	lw	r10, 6(r3)
	sw	r10, 2(r9)
	lw	r11, 7(r3)
	sw	r11, 1(r9)
	add	r12, r0, r4				# mr	r12, r4
	addi	r4, r4, 2
	addi	r13, r0, read_nth_object.2988
	sw	r13, 0(r12)
	lw	r13, 3(r3)
	sw	r13, 1(r12)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 3
	addi	r15, r0, read_object.2990
	sw	r15, 0(r14)
	sw	r12, 2(r14)
	lw	r12, 2(r3)
	sw	r12, 1(r14)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 2
	addi	r16, r0, read_and_network.2998
	sw	r16, 0(r15)
	lw	r16, 9(r3)
	sw	r16, 1(r15)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 7
	addi	r18, r0, read_parameter.3000
	sw	r18, 0(r17)
	sw	r2, 6(r17)
	sw	r14, 5(r17)
	sw	r9, 4(r17)
	sw	r15, 3(r17)
	lw	r2, 11(r3)
	sw	r2, 2(r17)
	sw	r16, 1(r17)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r14, r0, solver_rect_surface.3002
	sw	r14, 0(r9)
	lw	r14, 12(r3)
	sw	r14, 1(r9)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 2
	addi	r18, r0, solver_rect.3011
	sw	r18, 0(r15)
	sw	r9, 1(r15)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r18, r0, solver_surface.3017
	sw	r18, 0(r9)
	sw	r14, 1(r9)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 2
	addi	r19, r0, solver_second.3036
	sw	r19, 0(r18)
	sw	r14, 1(r18)
	add	r19, r0, r4				# mr	r19, r4
	addi	r4, r4, 5
	addi	r20, r0, solver.3042
	sw	r20, 0(r19)
	sw	r9, 4(r19)
	sw	r18, 3(r19)
	sw	r15, 2(r19)
	sw	r13, 1(r19)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r15, r0, solver_rect_fast.3046
	sw	r15, 0(r9)
	sw	r14, 1(r9)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 2
	addi	r18, r0, solver_surface_fast.3053
	sw	r18, 0(r15)
	sw	r14, 1(r15)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 2
	addi	r20, r0, solver_second_fast.3059
	sw	r20, 0(r18)
	sw	r14, 1(r18)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 5
	addi	r21, r0, solver_fast.3065
	sw	r21, 0(r20)
	sw	r15, 4(r20)
	sw	r18, 3(r20)
	sw	r9, 2(r20)
	sw	r13, 1(r20)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 2
	addi	r18, r0, solver_surface_fast2.3069
	sw	r18, 0(r15)
	sw	r14, 1(r15)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 2
	addi	r21, r0, solver_second_fast2.3076
	sw	r21, 0(r18)
	sw	r14, 1(r18)
	add	r21, r0, r4				# mr	r21, r4
	addi	r4, r4, 5
	addi	r22, r0, solver_fast2.3083
	sw	r22, 0(r21)
	sw	r15, 4(r21)
	sw	r18, 3(r21)
	sw	r9, 2(r21)
	sw	r13, 1(r21)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r15, r0, iter_setup_dirvec_constants.3095
	sw	r15, 0(r9)
	sw	r13, 1(r9)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 2
	addi	r18, r0, setup_startp_constants.3100
	sw	r18, 0(r15)
	sw	r13, 1(r15)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 2
	addi	r22, r0, check_all_inside.3125
	sw	r22, 0(r18)
	sw	r13, 1(r18)
	add	r22, r0, r4				# mr	r22, r4
	addi	r4, r4, 8
	addi	r23, r0, shadow_check_and_group.3131
	sw	r23, 0(r22)
	sw	r20, 7(r22)
	sw	r14, 6(r22)
	sw	r13, 5(r22)
	lw	r23, 34(r3)
	sw	r23, 4(r22)
	sw	r10, 3(r22)
	lw	r24, 15(r3)
	sw	r24, 2(r22)
	sw	r18, 1(r22)
	add	r25, r0, r4				# mr	r25, r4
	addi	r4, r4, 3
	addi	r26, r0, shadow_check_one_or_group.3134
	sw	r26, 0(r25)
	sw	r22, 2(r25)
	sw	r16, 1(r25)
	add	r22, r0, r4				# mr	r22, r4
	addi	r4, r4, 6
	addi	r26, r0, shadow_check_one_or_matrix.3137
	sw	r26, 0(r22)
	sw	r20, 5(r22)
	sw	r14, 4(r22)
	sw	r25, 3(r22)
	sw	r23, 2(r22)
	sw	r24, 1(r22)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 10
	addi	r25, r0, solve_each_element.3140
	sw	r25, 0(r20)
	lw	r25, 14(r3)
	sw	r25, 9(r20)
	lw	r26, 24(r3)
	sw	r26, 8(r20)
	sw	r14, 7(r20)
	sw	r19, 6(r20)
	sw	r13, 5(r20)
	lw	r27, 13(r3)
	sw	r27, 4(r20)
	sw	r24, 3(r20)
	lw	r28, 16(r3)
	sw	r28, 2(r20)
	sw	r18, 1(r20)
	add	r29, r0, r4				# mr	r29, r4
	addi	r4, r4, 3
	addi	r23, r0, solve_one_or_network.3144
	sw	r23, 0(r29)
	sw	r20, 2(r29)
	sw	r16, 1(r29)
	add	r23, r0, r4				# mr	r23, r4
	addi	r4, r4, 8
	sw	r17, 37(r3)
	addi	r17, r0, trace_or_matrix.3148
	sw	r17, 0(r23)
	sw	r25, 7(r23)
	sw	r26, 6(r23)
	sw	r14, 5(r23)
	sw	r19, 4(r23)
	sw	r29, 3(r23)
	sw	r20, 2(r23)
	sw	r16, 1(r23)
	add	r17, r0, r4				# mr	r17, r4
	addi	r4, r4, 4
	addi	r19, r0, judge_intersection.3152
	sw	r19, 0(r17)
	sw	r23, 3(r17)
	sw	r25, 2(r17)
	sw	r2, 1(r17)
	add	r19, r0, r4				# mr	r19, r4
	addi	r4, r4, 10
	addi	r20, r0, solve_each_element_fast.3154
	sw	r20, 0(r19)
	sw	r25, 9(r19)
	lw	r20, 25(r3)
	sw	r20, 8(r19)
	sw	r21, 7(r19)
	sw	r14, 6(r19)
	sw	r13, 5(r19)
	sw	r27, 4(r19)
	sw	r24, 3(r19)
	sw	r28, 2(r19)
	sw	r18, 1(r19)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 3
	addi	r23, r0, solve_one_or_network_fast.3158
	sw	r23, 0(r18)
	sw	r19, 2(r18)
	sw	r16, 1(r18)
	add	r23, r0, r4				# mr	r23, r4
	addi	r4, r4, 7
	addi	r29, r0, trace_or_matrix_fast.3162
	sw	r29, 0(r23)
	sw	r25, 6(r23)
	sw	r21, 5(r23)
	sw	r14, 4(r23)
	sw	r18, 3(r23)
	sw	r19, 2(r23)
	sw	r16, 1(r23)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 4
	addi	r16, r0, judge_intersection_fast.3166
	sw	r16, 0(r14)
	sw	r23, 3(r14)
	sw	r25, 2(r14)
	sw	r2, 1(r14)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 3
	addi	r18, r0, get_nvector_rect.3168
	sw	r18, 0(r16)
	lw	r18, 17(r3)
	sw	r18, 2(r16)
	sw	r27, 1(r16)
	add	r19, r0, r4				# mr	r19, r4
	addi	r4, r4, 2
	addi	r21, r0, get_nvector_plane.3170
	sw	r21, 0(r19)
	sw	r18, 1(r19)
	add	r21, r0, r4				# mr	r21, r4
	addi	r4, r4, 3
	addi	r23, r0, get_nvector_second.3172
	sw	r23, 0(r21)
	sw	r18, 2(r21)
	sw	r24, 1(r21)
	add	r23, r0, r4				# mr	r23, r4
	addi	r4, r4, 2
	addi	r29, r0, utexture.3177
	sw	r29, 0(r23)
	lw	r29, 18(r3)
	sw	r29, 1(r23)
	sw	r9, 38(r3)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 3
	addi	r7, r0, add_light.3180
	sw	r7, 0(r9)
	sw	r29, 2(r9)
	lw	r7, 20(r3)
	sw	r7, 1(r9)
	add	r6, r0, r4				# mr	r6, r4
	addi	r4, r4, 9
	addi	r8, r0, trace_reflections.3184
	sw	r8, 0(r6)
	sw	r22, 8(r6)
	lw	r8, 36(r3)
	sw	r8, 7(r6)
	sw	r2, 6(r6)
	sw	r18, 5(r6)
	sw	r14, 4(r6)
	sw	r27, 3(r6)
	sw	r28, 2(r6)
	sw	r9, 1(r6)
	add	r8, r0, r4				# mr	r8, r4
	addi	r4, r4, 27
	addi	r5, r0, trace_ray.3189
	sw	r5, 0(r8)
	sw	r23, 26(r8)
	lw	r5, 0(r3)
	sw	r5, 25(r8)
	sw	r6, 24(r8)
	sw	r25, 23(r8)
	sw	r29, 22(r8)
	sw	r20, 21(r8)
	sw	r26, 20(r8)
	sw	r22, 19(r8)
	sw	r15, 18(r8)
	sw	r7, 17(r8)
	sw	r2, 16(r8)
	sw	r13, 15(r8)
	sw	r18, 14(r8)
	sw	r1, 13(r8)
	sw	r12, 12(r8)
	sw	r10, 11(r8)
	sw	r17, 10(r8)
	sw	r27, 9(r8)
	sw	r24, 8(r8)
	sw	r28, 7(r8)
	sw	r21, 6(r8)
	sw	r16, 5(r8)
	sw	r19, 4(r8)
	lw	r5, 1(r3)
	sw	r5, 3(r8)
	sw	r11, 2(r8)
	sw	r9, 1(r8)
	add	r6, r0, r4				# mr	r6, r4
	addi	r4, r4, 15
	addi	r9, r0, trace_diffuse_ray.3195
	sw	r9, 0(r6)
	sw	r23, 14(r6)
	sw	r29, 13(r6)
	sw	r22, 12(r6)
	sw	r2, 11(r6)
	sw	r13, 10(r6)
	sw	r18, 9(r6)
	sw	r10, 8(r6)
	sw	r14, 7(r6)
	sw	r24, 6(r6)
	sw	r28, 5(r6)
	sw	r21, 4(r6)
	sw	r16, 3(r6)
	sw	r19, 2(r6)
	lw	r2, 19(r3)
	sw	r2, 1(r6)
	add	r9, r0, r4				# mr	r9, r4
	addi	r4, r4, 2
	addi	r11, r0, iter_trace_diffuse_rays.3198
	sw	r11, 0(r9)
	sw	r6, 1(r9)
	add	r6, r0, r4				# mr	r6, r4
	addi	r4, r4, 6
	addi	r11, r0, trace_diffuse_ray_80percent.3207
	sw	r11, 0(r6)
	sw	r20, 5(r6)
	sw	r15, 4(r6)
	sw	r12, 3(r6)
	sw	r9, 2(r6)
	lw	r11, 31(r3)
	sw	r11, 1(r6)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 4
	addi	r16, r0, calc_diffuse_using_1point.3211
	sw	r16, 0(r14)
	sw	r6, 3(r14)
	sw	r7, 2(r14)
	sw	r2, 1(r14)
	add	r6, r0, r4				# mr	r6, r4
	addi	r4, r4, 3
	addi	r16, r0, calc_diffuse_using_5points.3214
	sw	r16, 0(r6)
	sw	r7, 2(r6)
	sw	r2, 1(r6)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 2
	addi	r17, r0, do_without_neighbors.3220
	sw	r17, 0(r16)
	sw	r14, 1(r16)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 2
	addi	r17, r0, neighbors_exist.3223
	sw	r17, 0(r14)
	lw	r17, 21(r3)
	sw	r17, 1(r14)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 3
	addi	r19, r0, try_exploit_neighbors.3236
	sw	r19, 0(r18)
	sw	r16, 2(r18)
	sw	r6, 1(r18)
	add	r6, r0, r4				# mr	r6, r4
	addi	r4, r4, 2
	addi	r19, r0, write_ppm_header.3243
	sw	r19, 0(r6)
	sw	r17, 1(r6)
	add	r19, r0, r4				# mr	r19, r4
	addi	r4, r4, 2
	addi	r21, r0, write_rgb.3247
	sw	r21, 0(r19)
	sw	r7, 1(r19)
	add	r21, r0, r4				# mr	r21, r4
	addi	r4, r4, 7
	addi	r22, r0, pretrace_diffuse_rays.3249
	sw	r22, 0(r21)
	sw	r20, 6(r21)
	sw	r15, 5(r21)
	sw	r12, 4(r21)
	sw	r9, 3(r21)
	sw	r11, 2(r21)
	sw	r2, 1(r21)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 11
	addi	r9, r0, pretrace_pixels.3252
	sw	r9, 0(r2)
	lw	r9, 5(r3)
	sw	r9, 10(r2)
	sw	r8, 9(r2)
	sw	r26, 8(r2)
	lw	r8, 26(r3)
	sw	r8, 7(r2)
	lw	r8, 23(r3)
	sw	r8, 6(r2)
	sw	r7, 5(r2)
	lw	r9, 29(r3)
	sw	r9, 4(r2)
	sw	r21, 3(r2)
	lw	r9, 22(r3)
	sw	r9, 2(r2)
	sw	r5, 1(r2)
	add	r15, r0, r4				# mr	r15, r4
	addi	r4, r4, 7
	addi	r20, r0, pretrace_line.3259
	sw	r20, 0(r15)
	lw	r20, 28(r3)
	sw	r20, 6(r15)
	lw	r20, 27(r3)
	sw	r20, 5(r15)
	sw	r8, 4(r15)
	sw	r2, 3(r15)
	sw	r17, 2(r15)
	sw	r9, 1(r15)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 7
	addi	r20, r0, scan_pixel.3263
	sw	r20, 0(r2)
	sw	r19, 6(r2)
	sw	r18, 5(r2)
	sw	r7, 4(r2)
	sw	r14, 3(r2)
	sw	r17, 2(r2)
	sw	r16, 1(r2)
	add	r7, r0, r4				# mr	r7, r4
	addi	r4, r4, 4
	addi	r14, r0, scan_line.3269
	sw	r14, 0(r7)
	sw	r2, 3(r7)
	sw	r15, 2(r7)
	sw	r17, 1(r7)
	add	r2, r0, r4				# mr	r2, r4
	addi	r4, r4, 2
	addi	r14, r0, create_pixel.3277
	sw	r14, 0(r2)
	sw	r5, 1(r2)
	add	r5, r0, r4				# mr	r5, r4
	addi	r4, r4, 2
	addi	r14, r0, init_line_elements.3279
	sw	r14, 0(r5)
	sw	r2, 1(r5)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 2
	addi	r16, r0, calc_dirvec.3289
	sw	r16, 0(r14)
	sw	r11, 1(r14)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 2
	addi	r18, r0, calc_dirvecs.3297
	sw	r18, 0(r16)
	sw	r14, 1(r16)
	add	r14, r0, r4				# mr	r14, r4
	addi	r4, r4, 2
	addi	r18, r0, calc_dirvec_rows.3302
	sw	r18, 0(r14)
	sw	r16, 1(r14)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 2
	addi	r18, r0, create_dirvec_elements.3308
	sw	r18, 0(r16)
	sw	r12, 1(r16)
	add	r18, r0, r4				# mr	r18, r4
	addi	r4, r4, 4
	addi	r19, r0, create_dirvecs.3311
	sw	r19, 0(r18)
	sw	r12, 3(r18)
	sw	r11, 2(r18)
	sw	r16, 1(r18)
	add	r16, r0, r4				# mr	r16, r4
	addi	r4, r4, 3
	addi	r19, r0, init_dirvec_constants.3313
	sw	r19, 0(r16)
	sw	r12, 2(r16)
	lw	r19, 38(r3)
	sw	r19, 1(r16)
	add	r20, r0, r4				# mr	r20, r4
	addi	r4, r4, 5
	addi	r21, r0, init_vecset_constants.3316
	sw	r21, 0(r20)
	sw	r12, 4(r20)
	sw	r19, 3(r20)
	sw	r16, 2(r20)
	sw	r11, 1(r20)
	add	r11, r0, r4				# mr	r11, r4
	addi	r4, r4, 6
	addi	r16, r0, setup_rect_reflection.3327
	sw	r16, 0(r11)
	lw	r16, 36(r3)
	sw	r16, 5(r11)
	sw	r1, 4(r11)
	sw	r12, 3(r11)
	sw	r10, 2(r11)
	sw	r19, 1(r11)
	add	r21, r0, r4				# mr	r21, r4
	addi	r4, r4, 6
	addi	r22, r0, setup_surface_reflection.3330
	sw	r22, 0(r21)
	sw	r16, 5(r21)
	sw	r1, 4(r21)
	sw	r12, 3(r21)
	sw	r10, 2(r21)
	sw	r19, 1(r21)
	add	r1, r0, r4				# mr	r1, r4
	addi	r4, r4, 4
	addi	r16, r0, setup_reflections.3333
	sw	r16, 0(r1)
	sw	r21, 3(r1)
	sw	r11, 2(r1)
	sw	r13, 1(r1)
	add	r29, r0, r4				# mr	r29, r4
	addi	r4, r4, 19
	addi	r11, r0, rt.3335
	sw	r11, 0(r29)
	sw	r6, 18(r29)
	lw	r6, 33(r3)
	sw	r6, 17(r29)
	sw	r1, 16(r29)
	sw	r8, 15(r29)
	sw	r7, 14(r29)
	lw	r1, 37(r3)
	sw	r1, 13(r29)
	sw	r15, 12(r29)
	sw	r12, 11(r29)
	lw	r1, 34(r3)
	sw	r1, 10(r29)
	sw	r10, 9(r29)
	sw	r19, 8(r29)
	sw	r20, 7(r29)
	sw	r5, 6(r29)
	sw	r17, 5(r29)
	sw	r9, 4(r29)
	sw	r2, 3(r29)
	sw	r18, 2(r29)
	sw	r14, 1(r29)
	addi	r1, r0, 128				# li	r1, 128
	addi	r2, r0, 128				# li	r2, 128
	sw	r31, 39(r3)
	addi	r3, r3, 40
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -40
	lw	r31, 39(r3)
	addi	_R_0, r0, 0				# li	_R_0, 0
