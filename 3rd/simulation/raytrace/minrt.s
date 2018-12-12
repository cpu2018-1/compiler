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
	fle	r30, f1, f0
	beq	r0, r30, _fle_else.733
	addi	r1, r0, 0
	jr	r31				#
_fle_else.733:
	addi	r1, r0, 1
	jr	r31				#
lib_fisneg:
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.734
	addi	r1, r0, 0
	jr	r31				#
_fle_else.734:
	addi	r1, r0, 1
	jr	r31				#
lib_fiszero:
	feq	r30, f1, f0
	beq	r0, r30, _feq_else.735
	addi	r1, r0, 1
	jr	r31				#
_feq_else.735:
	addi	r1, r0, 0
	jr	r31				#
lib_xor:
	beq	r1, r2, _beq_then.736
	addi	r1, r0, 1
	jr	r31				#
_beq_then.736:
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
	addi	r1, r0, 48
	out	r1
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.737
	jr	r31				#
_fle_else.737:
	fneg	f1, f1
	jr	r31				#
lib_int_of_float:
	ftoi	f1, f1
	jr	r31				#
lib_float_of_int:
	itof	r1, r1
	jr	r31				#
lib_floor:
	ftoi	r1, f1
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.738
	fadd	f1, f0, f2
	jr	r31				#
_fle_else.738:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
	jr	r31				#
lib_hoge:
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.739
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.740
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j lib_hoge
_fle_else.740:
	fadd	f1, f0, f2
	jr	r31				#
_fle_else.739:
	fadd	f1, f0, f2
	jr	r31				#
lib_fuga:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.741
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.742
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j lib_fuga
_fle_else.742:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j lib_fuga
_fle_else.741:
	jr	r31				#
lib_modulo_2pi:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 0(r3)
	fsw	f1, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.743
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal lib_hoge				#	bl lib_hoge
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	_fle_cont.744
_fle_else.743:
_fle_cont.744:
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
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.745
	jr	r31				#
_fle_else.745:
	fneg	f1, f1
	jr	r31				#
lib_sin:
	flup	f2, 14		# fli	f2, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.746
	flup	f3, 2		# fli	f3, 1.000000
	j	_fle_cont.747
_fle_else.746:
	flup	f3, 11		# fli	f3, -1.000000
_fle_cont.747:
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.748
	j	_fle_cont.749
_fle_else.748:
	fneg	f1, f1
_fle_cont.749:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal lib_modulo_2pi				#	bl lib_modulo_2pi
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.750
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.751
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.752
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.752:
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
_fle_else.751:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.753
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.753:
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
_fle_else.750:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.754
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.755
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.755:
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
_fle_else.754:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.756
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.756:
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
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.757
	j	_fle_cont.758
_fle_else.757:
	fneg	f1, f1
_fle_cont.758:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal lib_modulo_2pi				#	bl lib_modulo_2pi
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.759
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.760
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, _fle_else.761
	fsw	f2, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.761:
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
_fle_else.760:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.762
	fsw	f3, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.762:
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
_fle_else.759:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.763
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, _fle_else.764
	fsw	f2, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.764:
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
_fle_else.763:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.765
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.765:
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
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.766
	flup	f2, 2		# fli	f2, 1.000000
	j	_fle_cont.767
_fle_else.766:
	flup	f2, 11		# fli	f2, -1.000000
_fle_cont.767:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.768
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.769
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
_fle_else.769:
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
_fle_else.768:
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
	ble	r7, r1, _ble_then.770
	add	r5, r0, r6				# mr	r5, r6
	j lib_div10_sub
_ble_then.770:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, _ble_then.771
	add	r2, r0, r6				# mr	r2, r6
	j lib_div10_sub
_ble_then.771:
	add	r1, r0, r6
	jr	r31				#
lib_div10:
	addi	r2, r0, 0
	add	r5, r0, r1				# mr	r5, r1
	j lib_div10_sub
lib_iter_mul10:
	beqi	0, r2, _beq_then.772
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	j lib_iter_mul10
_beq_then.772:
	jr	r31				#
lib_iter_div10:
	beqi	0, r2, _beq_then.773
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
_beq_then.773:
	jr	r31				#
lib_keta_sub:
	addi	r5, r0, 10
	ble	r5, r1, _ble_then.774
	addi	r1, r2, 1
	jr	r31				#
_ble_then.774:
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
	beqi	1, r2, _beq_then.775
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
	ble	r1, r2, _ble_then.776
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
_ble_then.776:
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
_beq_then.775:
	addi	r1, r1, 48
	j	lib_print_char
lib_print_uint:
	addi	r2, r0, 10
	ble	r2, r1, _ble_then.777
	addi	r1, r1, 48
	j	lib_print_char
_ble_then.777:
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
	ble	r2, r1, _ble_then.778
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
_ble_then.778:
	j lib_print_uint
lib_truncate:
	ftoi	f1, f1
	jr	r31				#
lib_print_dec:
	feq	r30, f1, f0
	beq	r0, r30, _feq_else.779
	jr	r31				#
_feq_else.779:
	flup	f2, 39		# fli	f2, 10.000000
	fmul	f1, f2, f1
	ftoi	r1, f1
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_print_int				#	bl lib_print_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 0(r3)
	ftoi	r2, r1
	itof	f1, r2
	fsub	f1, r1, f1
	j lib_print_dec
lib_print_ufloat:
	ftoi	r1, f1
	fsw	f1, 0(r3)
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
	lw	r1, 0(r3)
	ftoi	r2, r1
	itof	f1, r2
	fle	r30, f1, r1
	beq	r0, r30, _fle_else.781
	j	_fle_cont.782
_fle_else.781:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
_fle_cont.782:
	fsub	f1, r1, f1
	j lib_print_dec
lib_print_float:
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.783
	j lib_print_ufloat
_fle_else.783:
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
print_char.2801:
	out	r1
	jr	r31				#
fispos.2803:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.8359
	addi	r1, r0, 0
	jr	r31				#
fle_else.8359:
	addi	r1, r0, 1
	jr	r31				#
fisneg.2805:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.8360
	addi	r1, r0, 0
	jr	r31				#
fle_else.8360:
	addi	r1, r0, 1
	jr	r31				#
fiszero.2807:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.8361
	addi	r1, r0, 1
	jr	r31				#
feq_else.8361:
	addi	r1, r0, 0
	jr	r31				#
xor.2809:
	beq	r1, r2, beq_then.8362
	addi	r1, r0, 1
	jr	r31				#
beq_then.8362:
	addi	r1, r0, 0
	jr	r31				#
fhalf.2812:
	flup	f2, 1		# fli	f2, 0.500000
	fmul	f1, f1, f2
	jr	r31				#
fsqr.2814:
	fmul	f1, f1, f1
	jr	r31				#
fabs.2816:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.8363
	jr	r31				#
fle_else.8363:
	fneg	f1, f1
	jr	r31				#
int_of_float.2818:
	ftoi	f1, f1
	jr	r31				#
float_of_int.2820:
	itof	r1, r1
	jr	r31				#
floor.2822:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	int_of_float.2818				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	float_of_int.2820				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f2, 0(r3)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8364
	jr	r31				#
fle_else.8364:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
	jr	r31				#
hoge.2824:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8365
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2824
fle_else.8365:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2827:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.8366
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8367
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2827
fle_else.8367:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2827
fle_else.8366:
	jr	r31				#
modulo_2pi.2831:
	flup	f2, 5		# fli	f2, 6.283186
	flup	f3, 14		# fli	f3, 3.141593
	fsw	f3, 0(r3)
	fsw	f1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	hoge.2824				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f2, f0, f1
	flw	f1, 2(r3)
	flw	f3, 0(r3)
	j	fuga.2827
sin_body.2833:
	flup	f2, 6		# fli	f2, 0.166667
	flup	f3, 7		# fli	f3, 0.008333
	flup	f4, 8		# fli	f4, 0.000196
	fmul	f5, f1, f1
	fmul	f2, f2, f1
	fmul	f2, f2, f5
	fsub	f2, f1, f2
	fmul	f3, f3, f1
	fmul	f3, f3, f5
	fmul	f3, f3, f5
	fadd	f2, f2, f3
	fmul	f1, f4, f1
	fmul	f1, f1, f5
	fmul	f1, f1, f5
	fmul	f1, f1, f5
	fsub	f1, f2, f1
	jr	r31				#
cos_body.2835:
	fmul	f1, f1, f1
	flup	f2, 10		# fli	f2, 0.001370
	flup	f3, 9		# fli	f3, 0.041664
	flup	f4, 1		# fli	f4, 0.500000
	flup	f5, 2		# fli	f5, 1.000000
	fmul	f2, f1, f2
	fsub	f2, f3, f2
	fmul	f2, f1, f2
	fsub	f2, f4, f2
	fmul	f1, f1, f2
	fsub	f1, f5, f1
	jr	r31				#
sin.2837:
	flup	f2, 14		# fli	f2, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, fle_else.8368
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.8369
fle_else.8368:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.8369:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	modulo_2pi.2831				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8370
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.8371
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8372
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin_body.2833				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8372:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos_body.2835				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8371:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8373
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin_body.2833				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8373:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos_body.2835				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8370:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.8374
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8375
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin_body.2833				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8375:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos_body.2835				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8374:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8376
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin_body.2833				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8376:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos_body.2835				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
cos.2839:
	flup	f2, 14		# fli	f2, 3.141593
	flup	f3, 2		# fli	f3, 1.000000
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	modulo_2pi.2831				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8377
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.8378
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.8379
	fsw	f2, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos_body.2835				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8379:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fsw	f2, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin_body.2833				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8378:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8380
	fsw	f3, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos_body.2835				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8380:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin_body.2833				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8377:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.8381
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.8382
	fsw	f2, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos_body.2835				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8382:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fsw	f2, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2833				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8381:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8383
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos_body.2835				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8383:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2833				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
atan_body.2841:
	flup	f2, 17		# fli	f2, 0.333333
	fmul	f3, f1, f1
	flup	f4, 18		# fli	f4, 0.200000
	flup	f5, 19		# fli	f5, 0.142857
	flup	f6, 20		# fli	f6, 0.111111
	flup	f7, 21		# fli	f7, 0.089764
	flup	f8, 22		# fli	f8, 0.060035
	fmul	f9, f3, f3
	fmul	f10, f9, f9
	fmul	f2, f2, f1
	fmul	f2, f2, f3
	fsub	f2, f1, f2
	fmul	f4, f4, f1
	fmul	f4, f4, f9
	fadd	f2, f2, f4
	fmul	f4, f5, f1
	fmul	f4, f4, f3
	fmul	f4, f4, f9
	fsub	f2, f2, f4
	fmul	f4, f6, f1
	fmul	f4, f4, f9
	fmul	f4, f4, f9
	fadd	f2, f2, f4
	fmul	f4, f7, f1
	fmul	f3, f4, f3
	fmul	f3, f3, f10
	fsub	f2, f2, f3
	fmul	f1, f8, f1
	fmul	f1, f1, f9
	fmul	f1, f1, f10
	fadd	f1, f2, f1
	jr	r31				#
atan.2843:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.8384
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.8385
fle_else.8384:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.8385:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.8386
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.8387
	flup	f3, 2		# fli	f3, 1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fdiv	f1, f3, f1
	fsw	f2, 0(r3)
	fsw	f4, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan_body.2841				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8387:
	flup	f3, 2		# fli	f3, 1.000000
	flup	f4, 2		# fli	f4, 1.000000
	flup	f5, 16		# fli	f5, 0.785398
	fsub	f3, f1, f3
	fadd	f1, f1, f4
	fdiv	f1, f3, f1
	fsw	f2, 0(r3)
	fsw	f5, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	atan_body.2841				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.8386:
	j	atan_body.2841
print_num.2845:
	addi	r1, r1, 48
	out	r1
	jr	r31				#
mul10.2847:
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	jr	r31				#
div10_sub.2849:
	add	r6, r2, r5
	srai	r6, r6, 1
	sw	r2, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	sw	r1, 3(r3)
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	mul10.2847				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	ble	r1, r2, ble_then.8388
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	j	div10_sub.2849
ble_then.8388:
	lw	r1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	mul10.2847				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r1, 9
	lw	r2, 3(r3)
	ble	r2, r1, ble_then.8389
	lw	r1, 2(r3)
	lw	r5, 1(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	j	div10_sub.2849
ble_then.8389:
	lw	r1, 2(r3)
	jr	r31				#
div10.2853:
	slli	r2, r1, 7
	slli	r5, r1, 6
	slli	r6, r1, 3
	slli	r7, r1, 2
	add	r2, r2, r5
	add	r2, r2, r6
	add	r2, r2, r7
	add	r1, r2, r1
	srli	r1, r1, 11
	jr	r31				#
print_uint.2855:
	bgei	10, r1, bge_then.8390
	j	print_num.2845
bge_then.8390:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10.2853				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	print_uint.2855				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	mul10.2847				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 0(r3)
	sub	r1, r2, r1
	j	print_num.2845
print_int.2857:
	bgei	0, r1, bge_then.8391
	addi	r2, r0, 45
	sw	r1, 0(r3)
	add	r1, r0, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	print_char.2801				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	sub	r1, r0, r1
	j	print_int.2857
bge_then.8391:
	bgei	10, r1, bge_then.8392
	j	print_num.2845
bge_then.8392:
	addi	r2, r0, 100
	ble	r2, r1, ble_then.8393
	slli	r2, r1, 7
	slli	r5, r1, 6
	add	r2, r2, r5
	slli	r5, r1, 3
	add	r2, r2, r5
	slli	r5, r1, 2
	add	r2, r2, r5
	add	r2, r2, r1
	srli	r2, r2, 11
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	add	r1, r0, r2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	print_num.2845				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 0(r3)
	sub	r1, r2, r1
	j	print_num.2845
ble_then.8393:
	slli	r2, r1, 7
	slli	r5, r1, 5
	add	r2, r2, r5
	slli	r5, r1, 2
	add	r2, r2, r5
	srli	r2, r2, 14
	slli	r5, r2, 6
	slli	r6, r2, 5
	add	r5, r5, r6
	slli	r6, r2, 2
	add	r5, r5, r6
	sub	r1, r1, r5
	slli	r5, r1, 7
	slli	r6, r1, 6
	add	r5, r5, r6
	slli	r6, r1, 3
	add	r5, r5, r6
	slli	r6, r1, 2
	add	r5, r5, r6
	add	r5, r5, r1
	srli	r5, r5, 11
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	print_num.2845				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	print_num.2845				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 2(r3)
	sub	r1, r2, r1
	j	print_num.2845
xor.2859:
	beqi	0, r1, beq_then.8394
	beqi	0, r2, beq_then.8395
	addi	r1, r0, 0
	jr	r31				#
beq_then.8395:
	addi	r1, r0, 1
	jr	r31				#
beq_then.8394:
	add	r1, r0, r2
	jr	r31				#
sgn.2862:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	fiszero.2807				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.8396
	flup	f1, 0		# fli	f1, 0.000000
	jr	r31				#
beq_then.8396:
	flw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	fispos.2803				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.8397
	flup	f1, 2		# fli	f1, 1.000000
	jr	r31				#
beq_then.8397:
	flup	f1, 11		# fli	f1, -1.000000
	jr	r31				#
fneg_cond.2864:
	beqi	0, r1, beq_then.8398
	jr	r31				#
beq_then.8398:
	fneg	f1, f1
	jr	r31				#
add_mod5.2867:
	add	r1, r1, r2
	bgei	5, r1, bge_then.8399
	jr	r31				#
bge_then.8399:
	addi	r1, r1, -5
	jr	r31				#
vecset.2870:
	fsw	f1, 0(r1)
	fsw	f2, 1(r1)
	fsw	f3, 2(r1)
	jr	r31				#
vecfill.2875:
	fsw	f1, 0(r1)
	fsw	f1, 1(r1)
	fsw	f1, 2(r1)
	jr	r31				#
vecbzero.2878:
	flup	f1, 0		# fli	f1, 0.000000
	j	vecfill.2875
veccpy.2880:
	flw	f1, 0(r2)
	flw	f2, 1(r2)
	flw	f3, 2(r2)
	fsw	f1, 0(r1)
	fsw	f2, 1(r1)
	fsw	f3, 2(r1)
	jr	r31				#
vecdist2.2883:
	flw	f1, 0(r1)
	flw	f2, 0(r2)
	flw	f3, 1(r1)
	flw	f4, 1(r2)
	flw	f5, 2(r1)
	flw	f6, 2(r2)
	fsub	f1, f1, f2
	fsw	f6, 0(r3)
	fsw	f5, 2(r3)
	fsw	f4, 4(r3)
	fsw	f3, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fsqr.2814				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 4(r3)
	flw	f3, 6(r3)
	fsub	f2, f3, f2
	fsw	f1, 8(r3)
	fadd	f1, f0, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	fsqr.2814				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	flw	f3, 2(r3)
	fsub	f2, f3, f2
	fsw	f1, 10(r3)
	fadd	f1, f0, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	fsqr.2814				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fadd	f1, f2, f1
	jr	r31				#
vecunit.2886:
	flw	f1, 0(r1)
	flw	f2, 1(r1)
	flup	f3, 2		# fli	f3, 1.000000
	flw	f4, 2(r1)
	flw	f5, 0(r1)
	flw	f6, 1(r1)
	flw	f7, 2(r1)
	fsw	f7, 0(r3)
	fsw	f6, 2(r3)
	sw	r1, 4(r3)
	fsw	f5, 6(r3)
	fsw	f3, 8(r3)
	fsw	f4, 10(r3)
	fsw	f2, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	fsqr.2814				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fsw	f1, 14(r3)
	fadd	f1, f0, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	fsqr.2814				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	flw	f2, 10(r3)
	fsw	f1, 16(r3)
	fadd	f1, f0, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	fsqr.2814				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fadd	f1, f2, f1
	fsqrt	f1, f1
	flw	f2, 8(r3)
	fdiv	f1, f2, f1
	flw	f2, 6(r3)
	fmul	f2, f2, f1
	lw	r1, 4(r3)
	fsw	f2, 0(r1)
	flw	f2, 2(r3)
	fmul	f2, f2, f1
	fsw	f2, 1(r1)
	flw	f2, 0(r3)
	fmul	f1, f2, f1
	fsw	f1, 2(r1)
	jr	r31				#
vecunit_sgn.2888:
	flw	f1, 0(r1)
	flw	f2, 1(r1)
	flw	f3, 2(r1)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	fsqr.2814				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fsqr.2814				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fadd	f1, f2, f1
	flw	f2, 2(r3)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	fsqr.2814				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	fsqrt	f1, f1
	fsw	f1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	fiszero.2807				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	beqi	0, r1, beq_then.8405
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.8406
beq_then.8405:
	lw	r1, 1(r3)
	beqi	0, r1, beq_then.8407
	flup	f1, 11		# fli	f1, -1.000000
	flw	f2, 10(r3)
	fdiv	f1, f1, f2
	j	beq_cont.8408
beq_then.8407:
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 10(r3)
	fdiv	f1, f1, f2
beq_cont.8408:
beq_cont.8406:
	lw	r1, 0(r3)
	flw	f2, 0(r1)
	flw	f3, 1(r1)
	flw	f4, 2(r1)
	fmul	f2, f2, f1
	fsw	f2, 0(r1)
	fmul	f2, f3, f1
	fsw	f2, 1(r1)
	fmul	f1, f4, f1
	fsw	f1, 2(r1)
	jr	r31				#
veciprod.2891:
	flw	f1, 0(r1)
	flw	f2, 0(r2)
	flw	f3, 1(r1)
	flw	f4, 1(r2)
	flw	f5, 2(r1)
	flw	f6, 2(r2)
	fmul	f1, f1, f2
	fmul	f2, f3, f4
	fadd	f1, f1, f2
	fmul	f2, f5, f6
	fadd	f1, f1, f2
	jr	r31				#
veciprod2.2894:
	flw	f4, 0(r1)
	flw	f5, 1(r1)
	flw	f6, 2(r1)
	fmul	f1, f4, f1
	fmul	f2, f5, f2
	fadd	f1, f1, f2
	fmul	f2, f6, f3
	fadd	f1, f1, f2
	jr	r31				#
vecaccum.2899:
	flw	f2, 0(r2)
	flw	f3, 1(r2)
	flw	f4, 2(r2)
	flw	f5, 0(r1)
	flw	f6, 1(r1)
	flw	f7, 2(r1)
	fmul	f2, f1, f2
	fadd	f2, f5, f2
	fsw	f2, 0(r1)
	fmul	f2, f1, f3
	fadd	f2, f6, f2
	fsw	f2, 1(r1)
	fmul	f1, f1, f4
	fadd	f1, f7, f1
	fsw	f1, 2(r1)
	jr	r31				#
vecadd.2903:
	flw	f1, 0(r1)
	flw	f2, 0(r2)
	flw	f3, 1(r1)
	flw	f4, 1(r2)
	flw	f5, 2(r1)
	flw	f6, 2(r2)
	fadd	f1, f1, f2
	fsw	f1, 0(r1)
	fadd	f1, f3, f4
	fsw	f1, 1(r1)
	fadd	f1, f5, f6
	fsw	f1, 2(r1)
	jr	r31				#
vecmul.2906:
	flw	f1, 0(r1)
	flw	f2, 0(r2)
	flw	f3, 1(r1)
	flw	f4, 1(r2)
	flw	f5, 2(r1)
	flw	f6, 2(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	fmul	f1, f3, f4
	fsw	f1, 1(r1)
	fmul	f1, f5, f6
	fsw	f1, 2(r1)
	jr	r31				#
vecscale.2909:
	flw	f2, 0(r1)
	flw	f3, 1(r1)
	flw	f4, 2(r1)
	fmul	f2, f2, f1
	fsw	f2, 0(r1)
	fmul	f2, f3, f1
	fsw	f2, 1(r1)
	fmul	f1, f4, f1
	fsw	f1, 2(r1)
	jr	r31				#
vecaccumv.2912:
	flw	f1, 0(r2)
	flw	f2, 0(r5)
	flw	f3, 1(r2)
	flw	f4, 1(r5)
	flw	f5, 2(r2)
	flw	f6, 2(r5)
	flw	f7, 0(r1)
	flw	f8, 1(r1)
	flw	f9, 2(r1)
	fmul	f1, f1, f2
	fadd	f1, f7, f1
	fsw	f1, 0(r1)
	fmul	f1, f3, f4
	fadd	f1, f8, f1
	fsw	f1, 1(r1)
	fmul	f1, f5, f6
	fadd	f1, f9, f1
	fsw	f1, 2(r1)
	jr	r31				#
o_texturetype.2916:
	lw	r1, 0(r1)
	jr	r31				#
o_form.2918:
	lw	r1, 1(r1)
	jr	r31				#
o_reflectiontype.2920:
	lw	r1, 2(r1)
	jr	r31				#
o_isinvert.2922:
	lw	r1, 6(r1)
	jr	r31				#
o_isrot.2924:
	lw	r1, 3(r1)
	jr	r31				#
o_param_a.2926:
	lw	r1, 4(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_param_b.2928:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_param_c.2930:
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_param_abc.2932:
	lw	r1, 4(r1)
	jr	r31				#
o_param_x.2934:
	lw	r1, 5(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_param_y.2936:
	lw	r1, 5(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_param_z.2938:
	lw	r1, 5(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_diffuse.2940:
	lw	r1, 7(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_hilight.2942:
	lw	r1, 7(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_color_red.2944:
	lw	r1, 8(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_color_green.2946:
	lw	r1, 8(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_color_blue.2948:
	lw	r1, 8(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_param_r1.2950:
	lw	r1, 9(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_param_r2.2952:
	lw	r1, 9(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_param_r3.2954:
	lw	r1, 9(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_param_ctbl.2956:
	lw	r1, 10(r1)
	jr	r31				#
p_rgb.2958:
	lw	r1, 0(r1)
	jr	r31				#
p_intersection_points.2960:
	lw	r1, 1(r1)
	jr	r31				#
p_surface_ids.2962:
	lw	r1, 2(r1)
	jr	r31				#
p_calc_diffuse.2964:
	lw	r1, 3(r1)
	jr	r31				#
p_energy.2966:
	lw	r1, 4(r1)
	jr	r31				#
p_received_ray_20percent.2968:
	lw	r1, 5(r1)
	jr	r31				#
p_group_id.2970:
	lw	r1, 6(r1)
	lw	r1, 0(r1)
	jr	r31				#
p_set_group_id.2972:
	lw	r1, 6(r1)
	sw	r2, 0(r1)
	jr	r31				#
p_nvectors.2975:
	lw	r1, 7(r1)
	jr	r31				#
d_vec.2977:
	lw	r1, 0(r1)
	jr	r31				#
d_const.2979:
	lw	r1, 1(r1)
	jr	r31				#
r_surface_id.2981:
	lw	r1, 0(r1)
	jr	r31				#
r_dvec.2983:
	lw	r1, 1(r1)
	jr	r31				#
r_bright.2985:
	flw	f1, 2(r1)
	jr	r31				#
rad.2987:
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	jr	r31				#
read_screen_settings.2989:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_read_float				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	flup	f2, 26		# fli	f2, 200.000000
	flup	f3, 27		# fli	f3, -200.000000
	flup	f4, 26		# fli	f4, 200.000000
	flw	f5, 661(r0)
	flw	f6, 760(r0)
	flw	f7, 662(r0)
	flw	f8, 761(r0)
	flw	f9, 663(r0)
	flw	f10, 762(r0)
	fsw	f0, 755(r0)
	fsw	f1, 661(r0)
	fsw	f10, 0(r3)
	fsw	f9, 2(r3)
	fsw	f8, 4(r3)
	fsw	f7, 6(r3)
	fsw	f6, 8(r3)
	fsw	f5, 10(r3)
	fsw	f4, 12(r3)
	fsw	f3, 14(r3)
	fsw	f2, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_read_float				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	fsw	f1, 662(r0)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_read_float				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	fsw	f1, 663(r0)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_read_float				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	rad.2987				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	fsw	f1, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	cos.2839				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 18(r3)
	fsw	f1, 20(r3)
	fadd	f1, f0, f2
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	sin.2837				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	fsw	f1, 22(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	lib_read_float				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	rad.2987				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	fsw	f1, 24(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	cos.2839				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 24(r3)
	fsw	f1, 26(r3)
	fadd	f1, f0, f2
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	sin.2837				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	flw	f2, 20(r3)
	fmul	f3, f2, f1
	flw	f4, 16(r3)
	fmul	f3, f3, f4
	fsw	f3, 760(r0)
	flw	f3, 14(r3)
	flw	f4, 22(r3)
	fmul	f3, f4, f3
	fsw	f3, 761(r0)
	flw	f3, 26(r3)
	fmul	f5, f2, f3
	flw	f6, 12(r3)
	fmul	f5, f5, f6
	fsw	f5, 762(r0)
	fsw	f3, 754(r0)
	fneg	f5, f1
	fsw	f5, 756(r0)
	fneg	f4, f4
	fmul	f1, f4, f1
	fsw	f1, 757(r0)
	fneg	f1, f2
	fsw	f1, 758(r0)
	fmul	f1, f4, f3
	fsw	f1, 759(r0)
	flw	f1, 8(r3)
	flw	f2, 10(r3)
	fsub	f1, f2, f1
	fsw	f1, 664(r0)
	flw	f1, 4(r3)
	flw	f2, 6(r3)
	fsub	f1, f2, f1
	fsw	f1, 665(r0)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	fsub	f1, f2, f1
	fsw	f1, 666(r0)
	jr	r31				#
read_light.2991:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_read_int				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_read_float				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	rad.2987				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	sin.2837				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	fneg	f1, f1
	fsw	f1, 668(r0)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_float				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	rad.2987				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f2, 0(r3)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	cos.2839				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin.2837				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	fsw	f1, 667(r0)
	flw	f1, 2(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2839				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	fsw	f1, 669(r0)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	fsw	f1, 670(r0)
	jr	r31				#
rotate_quadratic_matrix.2993:
	flw	f1, 0(r2)
	flw	f2, 0(r2)
	flw	f3, 1(r2)
	flw	f4, 1(r2)
	flw	f5, 2(r2)
	flw	f6, 2(r2)
	flw	f7, 0(r1)
	flw	f8, 1(r1)
	flw	f9, 2(r1)
	flup	f10, 3		# fli	f10, 2.000000
	flup	f11, 3		# fli	f11, 2.000000
	flup	f12, 3		# fli	f12, 2.000000
	fsw	f12, 0(r3)
	fsw	f11, 2(r3)
	sw	r2, 4(r3)
	fsw	f10, 6(r3)
	sw	r1, 8(r3)
	fsw	f9, 10(r3)
	fsw	f8, 12(r3)
	fsw	f7, 14(r3)
	fsw	f6, 16(r3)
	fsw	f5, 18(r3)
	fsw	f4, 20(r3)
	fsw	f3, 22(r3)
	fsw	f2, 24(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	cos.2839				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 24(r3)
	fsw	f1, 26(r3)
	fadd	f1, f0, f2
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	sin.2837				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	flw	f2, 22(r3)
	fsw	f1, 28(r3)
	fadd	f1, f0, f2
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	cos.2839				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	flw	f2, 20(r3)
	fsw	f1, 30(r3)
	fadd	f1, f0, f2
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	sin.2837				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	flw	f2, 18(r3)
	fsw	f1, 32(r3)
	fadd	f1, f0, f2
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	cos.2839				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flw	f2, 16(r3)
	fsw	f1, 34(r3)
	fadd	f1, f0, f2
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	sin.2837				
	addi	r3, r3, -37
	lw	r31, 36(r3)
	flw	f2, 34(r3)
	flw	f3, 30(r3)
	fmul	f4, f3, f2
	flw	f5, 32(r3)
	flw	f6, 28(r3)
	fmul	f7, f6, f5
	fmul	f8, f7, f2
	flw	f9, 26(r3)
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
	fsw	f4, 36(r3)
	fsw	f3, 38(r3)
	fsw	f1, 40(r3)
	fsw	f11, 42(r3)
	fsw	f5, 44(r3)
	fsw	f7, 46(r3)
	fsw	f8, 48(r3)
	fsw	f2, 50(r3)
	fsw	f12, 52(r3)
	fadd	f1, f0, f4
	sw	r31, 54(r3)
	addi	r3, r3, 55
	jal	fsqr.2814				
	addi	r3, r3, -55
	lw	r31, 54(r3)
	flw	f2, 14(r3)
	fmul	f1, f2, f1
	flw	f3, 52(r3)
	fsw	f1, 54(r3)
	fadd	f1, f0, f3
	sw	r31, 56(r3)
	addi	r3, r3, 57
	jal	fsqr.2814				
	addi	r3, r3, -57
	lw	r31, 56(r3)
	flw	f2, 12(r3)
	fmul	f1, f2, f1
	flw	f3, 54(r3)
	fadd	f1, f3, f1
	flw	f3, 50(r3)
	fsw	f1, 56(r3)
	fadd	f1, f0, f3
	sw	r31, 58(r3)
	addi	r3, r3, 59
	jal	fsqr.2814				
	addi	r3, r3, -59
	lw	r31, 58(r3)
	flw	f2, 10(r3)
	fmul	f1, f2, f1
	flw	f3, 56(r3)
	fadd	f1, f3, f1
	lw	r1, 8(r3)
	fsw	f1, 0(r1)
	flw	f1, 48(r3)
	sw	r31, 58(r3)
	addi	r3, r3, 59
	jal	fsqr.2814				
	addi	r3, r3, -59
	lw	r31, 58(r3)
	flw	f2, 14(r3)
	fmul	f1, f2, f1
	flw	f3, 46(r3)
	fsw	f1, 58(r3)
	fadd	f1, f0, f3
	sw	r31, 60(r3)
	addi	r3, r3, 61
	jal	fsqr.2814				
	addi	r3, r3, -61
	lw	r31, 60(r3)
	flw	f2, 12(r3)
	fmul	f1, f2, f1
	flw	f3, 58(r3)
	fadd	f1, f3, f1
	flw	f3, 44(r3)
	fsw	f1, 60(r3)
	fadd	f1, f0, f3
	sw	r31, 62(r3)
	addi	r3, r3, 63
	jal	fsqr.2814				
	addi	r3, r3, -63
	lw	r31, 62(r3)
	flw	f2, 10(r3)
	fmul	f1, f2, f1
	flw	f3, 60(r3)
	fadd	f1, f3, f1
	lw	r1, 8(r3)
	fsw	f1, 1(r1)
	flw	f1, 42(r3)
	sw	r31, 62(r3)
	addi	r3, r3, 63
	jal	fsqr.2814				
	addi	r3, r3, -63
	lw	r31, 62(r3)
	flw	f2, 14(r3)
	fmul	f1, f2, f1
	flw	f3, 40(r3)
	fsw	f1, 62(r3)
	fadd	f1, f0, f3
	sw	r31, 64(r3)
	addi	r3, r3, 65
	jal	fsqr.2814				
	addi	r3, r3, -65
	lw	r31, 64(r3)
	flw	f2, 12(r3)
	fmul	f1, f2, f1
	flw	f3, 62(r3)
	fadd	f1, f3, f1
	flw	f3, 38(r3)
	fsw	f1, 64(r3)
	fadd	f1, f0, f3
	sw	r31, 66(r3)
	addi	r3, r3, 67
	jal	fsqr.2814				
	addi	r3, r3, -67
	lw	r31, 66(r3)
	flw	f2, 10(r3)
	fmul	f1, f2, f1
	flw	f3, 64(r3)
	fadd	f1, f3, f1
	lw	r1, 8(r3)
	fsw	f1, 2(r1)
	flw	f1, 48(r3)
	flw	f3, 14(r3)
	fmul	f4, f3, f1
	flw	f5, 42(r3)
	fmul	f4, f4, f5
	flw	f6, 46(r3)
	flw	f7, 12(r3)
	fmul	f8, f7, f6
	flw	f9, 40(r3)
	fmul	f8, f8, f9
	fadd	f4, f4, f8
	flw	f8, 44(r3)
	fmul	f10, f2, f8
	flw	f11, 38(r3)
	fmul	f10, f10, f11
	fadd	f4, f4, f10
	flw	f10, 6(r3)
	fmul	f4, f10, f4
	lw	r1, 4(r3)
	fsw	f4, 0(r1)
	flw	f4, 36(r3)
	fmul	f3, f3, f4
	fmul	f4, f3, f5
	flw	f5, 52(r3)
	fmul	f5, f7, f5
	fmul	f7, f5, f9
	fadd	f4, f4, f7
	flw	f7, 50(r3)
	fmul	f2, f2, f7
	fmul	f7, f2, f11
	fadd	f4, f4, f7
	flw	f7, 2(r3)
	fmul	f4, f7, f4
	fsw	f4, 1(r1)
	fmul	f1, f3, f1
	fmul	f3, f5, f6
	fadd	f1, f1, f3
	fmul	f2, f2, f8
	fadd	f1, f1, f2
	flw	f2, 0(r3)
	fmul	f1, f2, f1
	fsw	f1, 2(r1)
	jr	r31				#
read_nth_object.2996:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.8421
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 1(r3)
	fsw	f1, 2(r3)
	sw	r2, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	flw	f1, 2(r3)
	lw	r2, 4(r3)
	sw	r1, 7(r3)
	add	r1, r0, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_float_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_read_float				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r1, r0, 3
	flup	f2, 0		# fli	f2, 0.000000
	addi	r2, r0, 2
	flup	f3, 0		# fli	f3, 0.000000
	addi	r5, r0, 3
	flup	f4, 0		# fli	f4, 0.000000
	addi	r6, r0, 3
	flup	f5, 0		# fli	f5, 0.000000
	lw	r7, 8(r3)
	fsw	f1, 0(r7)
	fsw	f5, 10(r3)
	sw	r6, 12(r3)
	fsw	f4, 14(r3)
	sw	r5, 16(r3)
	fsw	f3, 18(r3)
	sw	r2, 20(r3)
	fsw	f2, 22(r3)
	sw	r1, 24(r3)
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	lib_read_float				
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r1, 8(r3)
	fsw	f1, 1(r1)
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	lib_read_float				
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r1, 8(r3)
	fsw	f1, 2(r1)
	flw	f1, 22(r3)
	lw	r2, 24(r3)
	add	r1, r0, r2
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	lib_create_float_array				
	addi	r3, r3, -26
	lw	r31, 25(r3)
	sw	r1, 25(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_read_float				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r1, 25(r3)
	fsw	f1, 0(r1)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_read_float				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r1, 25(r3)
	fsw	f1, 1(r1)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_read_float				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r1, 25(r3)
	fsw	f1, 2(r1)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_read_float				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	fisneg.2805				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f1, 18(r3)
	lw	r2, 20(r3)
	sw	r1, 26(r3)
	add	r1, r0, r2
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	lib_create_float_array				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	sw	r1, 27(r3)
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	lib_read_float				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	lw	r1, 27(r3)
	fsw	f1, 0(r1)
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	lib_read_float				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	lw	r1, 27(r3)
	fsw	f1, 1(r1)
	flw	f1, 14(r3)
	lw	r2, 16(r3)
	add	r1, r0, r2
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	lib_create_float_array				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	sw	r1, 28(r3)
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	lib_read_float				
	addi	r3, r3, -30
	lw	r31, 29(r3)
	lw	r1, 28(r3)
	fsw	f1, 0(r1)
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	lib_read_float				
	addi	r3, r3, -30
	lw	r31, 29(r3)
	lw	r1, 28(r3)
	fsw	f1, 1(r1)
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	lib_read_float				
	addi	r3, r3, -30
	lw	r31, 29(r3)
	lw	r1, 28(r3)
	fsw	f1, 2(r1)
	flw	f1, 10(r3)
	lw	r2, 12(r3)
	add	r1, r0, r2
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	lib_create_float_array				
	addi	r3, r3, -30
	lw	r31, 29(r3)
	lw	r2, 7(r3)
	beqi	0, r2, beq_then.8426
	sw	r1, 29(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	lib_read_float				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	rad.2987				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	lw	r1, 29(r3)
	fsw	f1, 0(r1)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	lib_read_float				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	rad.2987				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	lw	r1, 29(r3)
	fsw	f1, 1(r1)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	lib_read_float				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	rad.2987				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	lw	r1, 29(r3)
	fsw	f1, 2(r1)
	j	beq_cont.8427
beq_then.8426:
beq_cont.8427:
	lw	r2, 5(r3)
	beqi	2, r2, beq_then.8428
	lw	r5, 26(r3)
	j	beq_cont.8429
beq_then.8428:
	addi	r5, r0, 1
beq_cont.8429:
	add	r6, r0, r4
	addi	r7, r0, 4
	flup	f1, 0		# fli	f1, 0.000000
	addi	r8, r0, 1				# set min_caml_objects
	sw	r8, 30(r3)
	sw	r5, 31(r3)
	sw	r1, 29(r3)
	sw	r6, 32(r3)
	add	r1, r0, r7
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	lib_create_float_array				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	addi	r4, r4, 11
	lw	r2, 32(r3)
	sw	r1, 10(r2)
	lw	r1, 29(r3)
	sw	r1, 9(r2)
	lw	r5, 28(r3)
	sw	r5, 8(r2)
	lw	r5, 27(r3)
	sw	r5, 7(r2)
	lw	r5, 31(r3)
	sw	r5, 6(r2)
	lw	r5, 25(r3)
	sw	r5, 5(r2)
	lw	r5, 8(r3)
	sw	r5, 4(r2)
	lw	r6, 7(r3)
	sw	r6, 3(r2)
	lw	r7, 6(r3)
	sw	r7, 2(r2)
	lw	r7, 5(r3)
	sw	r7, 1(r2)
	lw	r8, 1(r3)
	sw	r8, 0(r2)
	lw	r8, 0(r3)
	lw	r9, 30(r3)
	add	r30, r9, r8
	sw	r2, 0(r30)
	beqi	3, r7, beq_then.8430
	beqi	2, r7, beq_then.8432
	j	beq_cont.8433
beq_then.8432:
	lw	r2, 26(r3)
	beqi	0, r2, beq_then.8434
	addi	r2, r0, 0
	j	beq_cont.8435
beq_then.8434:
	addi	r2, r0, 1
beq_cont.8435:
	add	r1, r0, r5
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	vecunit_sgn.2888				
	addi	r3, r3, -34
	lw	r31, 33(r3)
beq_cont.8433:
	j	beq_cont.8431
beq_then.8430:
	flw	f1, 0(r5)
	fsw	f1, 34(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	fiszero.2807				
	addi	r3, r3, -37
	lw	r31, 36(r3)
	beqi	0, r1, beq_then.8437
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.8438
beq_then.8437:
	flw	f1, 34(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	sgn.2862				
	addi	r3, r3, -37
	lw	r31, 36(r3)
	flw	f2, 34(r3)
	fsw	f1, 36(r3)
	fadd	f1, f0, f2
	sw	r31, 38(r3)
	addi	r3, r3, 39
	jal	fsqr.2814				
	addi	r3, r3, -39
	lw	r31, 38(r3)
	flw	f2, 36(r3)
	fdiv	f1, f2, f1
beq_cont.8438:
	lw	r1, 8(r3)
	flw	f2, 1(r1)
	fsw	f1, 0(r1)
	fsw	f2, 38(r3)
	fadd	f1, f0, f2
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	fiszero.2807				
	addi	r3, r3, -41
	lw	r31, 40(r3)
	beqi	0, r1, beq_then.8439
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.8440
beq_then.8439:
	flw	f1, 38(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	sgn.2862				
	addi	r3, r3, -41
	lw	r31, 40(r3)
	flw	f2, 38(r3)
	fsw	f1, 40(r3)
	fadd	f1, f0, f2
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	fsqr.2814				
	addi	r3, r3, -43
	lw	r31, 42(r3)
	flw	f2, 40(r3)
	fdiv	f1, f2, f1
beq_cont.8440:
	lw	r1, 8(r3)
	flw	f2, 2(r1)
	fsw	f1, 1(r1)
	fsw	f2, 42(r3)
	fadd	f1, f0, f2
	sw	r31, 44(r3)
	addi	r3, r3, 45
	jal	fiszero.2807				
	addi	r3, r3, -45
	lw	r31, 44(r3)
	beqi	0, r1, beq_then.8441
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.8442
beq_then.8441:
	flw	f1, 42(r3)
	sw	r31, 44(r3)
	addi	r3, r3, 45
	jal	sgn.2862				
	addi	r3, r3, -45
	lw	r31, 44(r3)
	flw	f2, 42(r3)
	fsw	f1, 44(r3)
	fadd	f1, f0, f2
	sw	r31, 46(r3)
	addi	r3, r3, 47
	jal	fsqr.2814				
	addi	r3, r3, -47
	lw	r31, 46(r3)
	flw	f2, 44(r3)
	fdiv	f1, f2, f1
beq_cont.8442:
	lw	r1, 8(r3)
	fsw	f1, 2(r1)
beq_cont.8431:
	lw	r1, 7(r3)
	beqi	0, r1, beq_then.8443
	lw	r1, 8(r3)
	lw	r2, 29(r3)
	sw	r31, 46(r3)
	addi	r3, r3, 47
	jal	rotate_quadratic_matrix.2993				
	addi	r3, r3, -47
	lw	r31, 46(r3)
	j	beq_cont.8444
beq_then.8443:
beq_cont.8444:
	addi	r1, r0, 1
	jr	r31				#
beq_then.8421:
	addi	r1, r0, 0
	jr	r31				#
read_object.2998:
	addi	r2, r0, 60
	ble	r2, r1, ble_then.8445
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.8446
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	read_object.2998
beq_then.8446:
	lw	r1, 0(r3)
	sw	r1, 0(r0)
	jr	r31				#
ble_then.8445:
	jr	r31				#
read_all_object.3000:
	addi	r1, r0, 0
	j	read_object.2998
read_net_item.3002:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.8449
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_net_item.3002				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.8449:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	j	lib_create_array
read_or_network.3004:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	add	r1, r0, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_net_item.3002				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.8450
	lw	r1, 0(r3)
	addi	r5, r1, 1
	sw	r2, 1(r3)
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_or_network.3004				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.8450:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.3006:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	add	r1, r0, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_net_item.3002				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.8451
	addi	r2, r0, 672				# set min_caml_and_net
	lw	r5, 0(r3)
	addi	r6, r5, 1
	add	r30, r2, r5
	sw	r1, 0(r30)
	add	r1, r0, r6
	j	read_and_network.3006
beq_then.8451:
	jr	r31				#
read_parameter.3008:
	addi	r1, r0, 0
	addi	r2, r0, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_screen_settings.2989				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_light.2991				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_all_object.3000				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_and_network.3006				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_or_network.3004				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r1, 723(r0)
	jr	r31				#
solver_rect_surface.3010:
	add	r30, r2, r5
	flw	f4, 0(r30)
	fsw	f3, 0(r3)
	sw	r7, 2(r3)
	fsw	f2, 4(r3)
	fsw	f1, 6(r3)
	sw	r6, 8(r3)
	sw	r1, 9(r3)
	sw	r5, 10(r3)
	sw	r2, 11(r3)
	fadd	f1, f0, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	fiszero.2807				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	beqi	0, r1, beq_then.8455
	addi	r1, r0, 0
	jr	r31				#
beq_then.8455:
	lw	r1, 10(r3)
	lw	r2, 11(r3)
	add	r30, r2, r1
	flw	f1, 0(r30)
	lw	r5, 9(r3)
	fsw	f1, 12(r3)
	add	r1, r0, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_param_abc.2932				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 9(r3)
	sw	r1, 14(r3)
	add	r1, r0, r2
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	o_isinvert.2922				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	flw	f1, 12(r3)
	sw	r1, 15(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	fisneg.2805				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	add	r2, r0, r1
	lw	r1, 10(r3)
	lw	r5, 11(r3)
	add	r30, r5, r1
	flw	f1, 0(r30)
	lw	r6, 8(r3)
	add	r30, r5, r6
	flw	f2, 0(r30)
	lw	r7, 15(r3)
	fsw	f2, 16(r3)
	fsw	f1, 18(r3)
	add	r1, r0, r7
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	xor.2859				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	lw	r2, 10(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	flw	f1, 0(r30)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	fneg_cond.2864				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 6(r3)
	fsub	f1, f1, f2
	flw	f2, 18(r3)
	fdiv	f1, f1, f2
	lw	r1, 8(r3)
	lw	r2, 14(r3)
	add	r30, r2, r1
	flw	f2, 0(r30)
	flw	f3, 16(r3)
	fmul	f3, f1, f3
	flw	f4, 4(r3)
	fadd	f3, f3, f4
	fsw	f1, 20(r3)
	fsw	f2, 22(r3)
	fadd	f1, f0, f3
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	fabs.2816				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 22(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8456
	addi	r1, r0, 0
	jr	r31				#
fle_else.8456:
	lw	r1, 2(r3)
	lw	r2, 11(r3)
	add	r30, r2, r1
	flw	f1, 0(r30)
	lw	r2, 14(r3)
	add	r30, r2, r1
	flw	f2, 0(r30)
	flw	f3, 20(r3)
	fmul	f1, f3, f1
	flw	f4, 0(r3)
	fadd	f1, f1, f4
	fsw	f2, 24(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	fabs.2816				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 24(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8457
	addi	r1, r0, 0
	jr	r31				#
fle_else.8457:
	flw	f1, 20(r3)
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
solver_rect.3019:
	addi	r5, r0, 0
	addi	r6, r0, 1
	addi	r7, r0, 2
	fsw	f1, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.8458
	addi	r1, r0, 1
	jr	r31				#
beq_then.8458:
	addi	r5, r0, 1
	addi	r6, r0, 2
	addi	r7, r0, 0
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r1, 7(r3)
	lw	r2, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.8459
	addi	r1, r0, 2
	jr	r31				#
beq_then.8459:
	addi	r5, r0, 2
	addi	r6, r0, 0
	addi	r7, r0, 1
	flw	f1, 2(r3)
	flw	f2, 0(r3)
	flw	f3, 4(r3)
	lw	r1, 7(r3)
	lw	r2, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.8460
	addi	r1, r0, 3
	jr	r31				#
beq_then.8460:
	addi	r1, r0, 0
	jr	r31				#
solver_surface.3025:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r2, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	o_param_abc.2932				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r1
	lw	r1, 6(r3)
	sw	r2, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	veciprod.2891				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fsw	f1, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	fispos.2803				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.8461
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r1, 7(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	veciprod2.2894				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	fneg	f1, f1
	flw	f2, 8(r3)
	fdiv	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.8461:
	addi	r1, r0, 0
	jr	r31				#
quadratic.3031:
	fsw	f1, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	fsqr.2814				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	fsw	f1, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	o_param_a.2926				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f2, f1
	flw	f2, 4(r3)
	fsw	f1, 10(r3)
	fadd	f1, f0, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	fsqr.2814				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 6(r3)
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_param_b.2928				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fmul	f1, f2, f1
	flw	f2, 10(r3)
	fadd	f1, f2, f1
	flw	f2, 2(r3)
	fsw	f1, 14(r3)
	fadd	f1, f0, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	fsqr.2814				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r1, 6(r3)
	fsw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	o_param_c.2930				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fmul	f1, f2, f1
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	lw	r1, 6(r3)
	fsw	f1, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	o_isrot.2924				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.8463
	flw	f1, 2(r3)
	flw	f2, 4(r3)
	fmul	f3, f2, f1
	lw	r1, 6(r3)
	fsw	f3, 20(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	o_param_r1.2950				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 0(r3)
	flw	f3, 2(r3)
	fmul	f3, f3, f2
	flw	f4, 4(r3)
	fmul	f2, f2, f4
	flw	f4, 20(r3)
	fmul	f1, f4, f1
	flw	f4, 18(r3)
	fadd	f1, f4, f1
	lw	r1, 6(r3)
	fsw	f2, 22(r3)
	fsw	f1, 24(r3)
	fsw	f3, 26(r3)
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	o_param_r2.2952				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	flw	f2, 26(r3)
	fmul	f1, f2, f1
	flw	f2, 24(r3)
	fadd	f1, f2, f1
	lw	r1, 6(r3)
	fsw	f1, 28(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	o_param_r3.2954				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	flw	f2, 22(r3)
	fmul	f1, f2, f1
	flw	f2, 28(r3)
	fadd	f1, f2, f1
	jr	r31				#
beq_then.8463:
	flw	f1, 18(r3)
	jr	r31				#
bilinear.3036:
	fmul	f7, f1, f4
	fsw	f4, 0(r3)
	fsw	f1, 2(r3)
	sw	r1, 4(r3)
	fsw	f7, 6(r3)
	fsw	f6, 8(r3)
	fsw	f3, 10(r3)
	fsw	f5, 12(r3)
	fsw	f2, 14(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	o_param_a.2926				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 12(r3)
	flw	f3, 14(r3)
	fmul	f4, f3, f2
	flw	f5, 8(r3)
	flw	f6, 10(r3)
	fmul	f7, f6, f5
	flw	f8, 6(r3)
	fmul	f1, f8, f1
	lw	r1, 4(r3)
	fsw	f7, 16(r3)
	fsw	f1, 18(r3)
	fsw	f4, 20(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	o_param_b.2928				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 20(r3)
	fmul	f1, f2, f1
	flw	f2, 18(r3)
	fadd	f1, f2, f1
	lw	r1, 4(r3)
	fsw	f1, 22(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	o_param_c.2930				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 16(r3)
	fmul	f1, f2, f1
	flw	f2, 22(r3)
	fadd	f1, f2, f1
	lw	r1, 4(r3)
	fsw	f1, 24(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	o_isrot.2924				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	beqi	0, r1, beq_then.8465
	flw	f1, 12(r3)
	flw	f2, 10(r3)
	fmul	f3, f2, f1
	flw	f4, 8(r3)
	flw	f5, 14(r3)
	fmul	f6, f5, f4
	flw	f7, 2(r3)
	fmul	f4, f7, f4
	flw	f8, 0(r3)
	fmul	f2, f2, f8
	fmul	f1, f7, f1
	fmul	f5, f5, f8
	fadd	f3, f3, f6
	lw	r1, 4(r3)
	fsw	f5, 26(r3)
	fsw	f1, 28(r3)
	fsw	f2, 30(r3)
	fsw	f4, 32(r3)
	fsw	f3, 34(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	o_param_r1.2950				
	addi	r3, r3, -37
	lw	r31, 36(r3)
	flw	f2, 34(r3)
	fmul	f1, f2, f1
	flw	f2, 30(r3)
	flw	f3, 32(r3)
	fadd	f2, f3, f2
	lw	r1, 4(r3)
	fsw	f1, 36(r3)
	fsw	f2, 38(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	o_param_r2.2952				
	addi	r3, r3, -41
	lw	r31, 40(r3)
	flw	f2, 38(r3)
	fmul	f1, f2, f1
	flw	f2, 36(r3)
	fadd	f1, f2, f1
	flw	f2, 26(r3)
	flw	f3, 28(r3)
	fadd	f2, f3, f2
	lw	r1, 4(r3)
	fsw	f1, 40(r3)
	fsw	f2, 42(r3)
	sw	r31, 44(r3)
	addi	r3, r3, 45
	jal	o_param_r3.2954				
	addi	r3, r3, -45
	lw	r31, 44(r3)
	flw	f2, 42(r3)
	fmul	f1, f2, f1
	flw	f2, 40(r3)
	fadd	f1, f2, f1
	sw	r31, 44(r3)
	addi	r3, r3, 45
	jal	fhalf.2812				
	addi	r3, r3, -45
	lw	r31, 44(r3)
	flw	f2, 24(r3)
	fadd	f1, f2, f1
	jr	r31				#
beq_then.8465:
	flw	f1, 24(r3)
	jr	r31				#
solver_second.3044:
	flw	f4, 0(r2)
	flw	f5, 1(r2)
	flw	f6, 2(r2)
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	fadd	f3, f0, f6
	fadd	f2, f0, f5
	fadd	f1, f0, f4
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	quadratic.3031				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fsw	f1, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	fiszero.2807				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.8466
	addi	r1, r0, 0
	jr	r31				#
beq_then.8466:
	lw	r1, 7(r3)
	flw	f1, 0(r1)
	flw	f2, 1(r1)
	flw	f3, 2(r1)
	flw	f4, 4(r3)
	flw	f5, 2(r3)
	flw	f6, 0(r3)
	lw	r1, 6(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	bilinear.3036				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 4(r3)
	flw	f3, 2(r3)
	flw	f4, 0(r3)
	lw	r1, 6(r3)
	fsw	f1, 10(r3)
	fadd	f1, f0, f2
	fadd	f2, f0, f3
	fadd	f3, f0, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	quadratic.3031				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 6(r3)
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_form.2918				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	3, r1, beq_then.8467
	flw	f1, 12(r3)
	j	beq_cont.8468
beq_then.8467:
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 12(r3)
	fsub	f1, f2, f1
beq_cont.8468:
	flw	f2, 8(r3)
	fmul	f1, f2, f1
	flw	f3, 10(r3)
	fsw	f1, 14(r3)
	fadd	f1, f0, f3
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	fsqr.2814				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fsub	f1, f1, f2
	fsw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	fispos.2803				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.8469
	flw	f1, 16(r3)
	fsqrt	f1, f1
	lw	r1, 6(r3)
	fsw	f1, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	o_isinvert.2922				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.8470
	flw	f1, 18(r3)
	j	beq_cont.8471
beq_then.8470:
	flw	f1, 18(r3)
	fneg	f1, f1
beq_cont.8471:
	flw	f2, 10(r3)
	fsub	f1, f1, f2
	flw	f2, 8(r3)
	fdiv	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.8469:
	addi	r1, r0, 0
	jr	r31				#
solver.3050:
	addi	r6, r0, 1				# set min_caml_objects
	flw	f1, 0(r5)
	flw	f2, 1(r5)
	flw	f3, 2(r5)
	add	r30, r6, r1
	lw	r1, 0(r30)
	sw	r2, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	sw	r1, 6(r3)
	fsw	f1, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	o_param_x.2934				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fsub	f1, f2, f1
	lw	r1, 6(r3)
	fsw	f1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	o_param_y.2936				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 4(r3)
	fsub	f1, f2, f1
	lw	r1, 6(r3)
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_param_z.2938				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 2(r3)
	fsub	f1, f2, f1
	lw	r1, 6(r3)
	fsw	f1, 14(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	o_form.2918				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	1, r1, beq_then.8474
	beqi	2, r1, beq_then.8475
	flw	f1, 10(r3)
	flw	f2, 12(r3)
	flw	f3, 14(r3)
	lw	r1, 6(r3)
	lw	r2, 0(r3)
	j	solver_second.3044
beq_then.8475:
	flw	f1, 10(r3)
	flw	f2, 12(r3)
	flw	f3, 14(r3)
	lw	r1, 6(r3)
	lw	r2, 0(r3)
	j	solver_surface.3025
beq_then.8474:
	flw	f1, 10(r3)
	flw	f2, 12(r3)
	flw	f3, 14(r3)
	lw	r1, 6(r3)
	lw	r2, 0(r3)
	j	solver_rect.3019
solver_rect_fast.3054:
	flw	f4, 0(r5)
	flw	f5, 1(r5)
	flw	f6, 1(r2)
	fsub	f4, f4, f1
	fmul	f4, f4, f5
	fsw	f1, 0(r3)
	sw	r5, 2(r3)
	fsw	f3, 4(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	fsw	f2, 8(r3)
	fsw	f6, 10(r3)
	fsw	f4, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_param_b.2928				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 10(r3)
	flw	f3, 12(r3)
	fmul	f2, f3, f2
	flw	f4, 8(r3)
	fadd	f2, f2, f4
	fsw	f1, 14(r3)
	fadd	f1, f0, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	fabs.2816				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8477
	addi	r1, r0, 0
	j	fle_cont.8478
fle_else.8477:
	lw	r1, 7(r3)
	flw	f1, 2(r1)
	lw	r2, 6(r3)
	fsw	f1, 16(r3)
	add	r1, r0, r2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	o_param_c.2930				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	flw	f3, 12(r3)
	fmul	f2, f3, f2
	flw	f4, 4(r3)
	fadd	f2, f2, f4
	fsw	f1, 18(r3)
	fadd	f1, f0, f2
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	fabs.2816				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 18(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8479
	addi	r1, r0, 0
	j	fle_cont.8480
fle_else.8479:
	lw	r1, 2(r3)
	flw	f1, 1(r1)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	fiszero.2807				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.8481
	addi	r1, r0, 0
	j	beq_cont.8482
beq_then.8481:
	addi	r1, r0, 1
beq_cont.8482:
fle_cont.8480:
fle_cont.8478:
	beqi	0, r1, beq_then.8483
	flw	f1, 12(r3)
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.8483:
	lw	r1, 2(r3)
	flw	f1, 2(r1)
	flw	f2, 3(r1)
	lw	r2, 7(r3)
	flw	f3, 0(r2)
	flw	f4, 8(r3)
	fsub	f1, f1, f4
	fmul	f1, f1, f2
	lw	r5, 6(r3)
	fsw	f3, 20(r3)
	fsw	f1, 22(r3)
	add	r1, r0, r5
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	o_param_a.2926				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 20(r3)
	flw	f3, 22(r3)
	fmul	f2, f3, f2
	flw	f4, 0(r3)
	fadd	f2, f2, f4
	fsw	f1, 24(r3)
	fadd	f1, f0, f2
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	fabs.2816				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 24(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8484
	addi	r1, r0, 0
	j	fle_cont.8485
fle_else.8484:
	lw	r1, 7(r3)
	flw	f1, 2(r1)
	lw	r2, 6(r3)
	fsw	f1, 26(r3)
	add	r1, r0, r2
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	o_param_c.2930				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	flw	f2, 26(r3)
	flw	f3, 22(r3)
	fmul	f2, f3, f2
	flw	f4, 4(r3)
	fadd	f2, f2, f4
	fsw	f1, 28(r3)
	fadd	f1, f0, f2
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	fabs.2816				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	flw	f2, 28(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8486
	addi	r1, r0, 0
	j	fle_cont.8487
fle_else.8486:
	lw	r1, 2(r3)
	flw	f1, 3(r1)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	fiszero.2807				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	beqi	0, r1, beq_then.8488
	addi	r1, r0, 0
	j	beq_cont.8489
beq_then.8488:
	addi	r1, r0, 1
beq_cont.8489:
fle_cont.8487:
fle_cont.8485:
	beqi	0, r1, beq_then.8490
	flw	f1, 22(r3)
	fsw	f1, 724(r0)
	addi	r1, r0, 2
	jr	r31				#
beq_then.8490:
	lw	r1, 2(r3)
	flw	f1, 4(r1)
	flw	f2, 5(r1)
	lw	r2, 7(r3)
	flw	f3, 0(r2)
	flw	f4, 4(r3)
	fsub	f1, f1, f4
	fmul	f1, f1, f2
	lw	r5, 6(r3)
	fsw	f3, 30(r3)
	fsw	f1, 32(r3)
	add	r1, r0, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	o_param_a.2926				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flw	f2, 30(r3)
	flw	f3, 32(r3)
	fmul	f2, f3, f2
	flw	f4, 0(r3)
	fadd	f2, f2, f4
	fsw	f1, 34(r3)
	fadd	f1, f0, f2
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	fabs.2816				
	addi	r3, r3, -37
	lw	r31, 36(r3)
	flw	f2, 34(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8491
	addi	r1, r0, 0
	j	fle_cont.8492
fle_else.8491:
	lw	r1, 7(r3)
	flw	f1, 1(r1)
	lw	r1, 6(r3)
	fsw	f1, 36(r3)
	sw	r31, 38(r3)
	addi	r3, r3, 39
	jal	o_param_b.2928				
	addi	r3, r3, -39
	lw	r31, 38(r3)
	flw	f2, 36(r3)
	flw	f3, 32(r3)
	fmul	f2, f3, f2
	flw	f4, 8(r3)
	fadd	f2, f2, f4
	fsw	f1, 38(r3)
	fadd	f1, f0, f2
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	fabs.2816				
	addi	r3, r3, -41
	lw	r31, 40(r3)
	flw	f2, 38(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8493
	addi	r1, r0, 0
	j	fle_cont.8494
fle_else.8493:
	lw	r1, 2(r3)
	flw	f1, 5(r1)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	fiszero.2807				
	addi	r3, r3, -41
	lw	r31, 40(r3)
	beqi	0, r1, beq_then.8495
	addi	r1, r0, 0
	j	beq_cont.8496
beq_then.8495:
	addi	r1, r0, 1
beq_cont.8496:
fle_cont.8494:
fle_cont.8492:
	beqi	0, r1, beq_then.8497
	flw	f1, 32(r3)
	fsw	f1, 724(r0)
	addi	r1, r0, 3
	jr	r31				#
beq_then.8497:
	addi	r1, r0, 0
	jr	r31				#
solver_surface_fast.3061:
	flw	f4, 0(r2)
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r2, 6(r3)
	fadd	f1, f0, f4
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	fisneg.2805				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	0, r1, beq_then.8498
	lw	r1, 6(r3)
	flw	f1, 1(r1)
	flw	f2, 2(r1)
	flw	f3, 3(r1)
	flw	f4, 4(r3)
	fmul	f1, f1, f4
	flw	f4, 2(r3)
	fmul	f2, f2, f4
	fadd	f1, f1, f2
	flw	f2, 0(r3)
	fmul	f2, f3, f2
	fadd	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.8498:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3067:
	flw	f4, 0(r2)
	fsw	f4, 0(r3)
	sw	r1, 2(r3)
	fsw	f3, 4(r3)
	fsw	f2, 6(r3)
	fsw	f1, 8(r3)
	sw	r2, 10(r3)
	fadd	f1, f0, f4
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	fiszero.2807				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.8500
	addi	r1, r0, 0
	jr	r31				#
beq_then.8500:
	lw	r1, 10(r3)
	flw	f1, 1(r1)
	flw	f2, 2(r1)
	flw	f3, 3(r1)
	flw	f4, 8(r3)
	fmul	f1, f1, f4
	flw	f5, 6(r3)
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	flw	f2, 4(r3)
	fmul	f3, f3, f2
	fadd	f1, f1, f3
	lw	r2, 2(r3)
	fsw	f1, 12(r3)
	add	r1, r0, r2
	fadd	f3, f0, f2
	fadd	f1, f0, f4
	fadd	f2, f0, f5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	quadratic.3031				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 2(r3)
	fsw	f1, 14(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	o_form.2918				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	3, r1, beq_then.8502
	flw	f1, 14(r3)
	j	beq_cont.8503
beq_then.8502:
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 14(r3)
	fsub	f1, f2, f1
beq_cont.8503:
	flw	f2, 0(r3)
	fmul	f1, f2, f1
	flw	f2, 12(r3)
	fsw	f1, 16(r3)
	fadd	f1, f0, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	fsqr.2814				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fsub	f1, f1, f2
	fsw	f1, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	fispos.2803				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.8504
	lw	r1, 2(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	o_isinvert.2922				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.8505
	flw	f1, 18(r3)
	fsqrt	f1, f1
	lw	r1, 10(r3)
	flw	f2, 4(r1)
	flw	f3, 12(r3)
	fadd	f1, f3, f1
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	j	beq_cont.8506
beq_then.8505:
	flw	f1, 18(r3)
	fsqrt	f1, f1
	lw	r1, 10(r3)
	flw	f2, 4(r1)
	flw	f3, 12(r3)
	fsub	f1, f3, f1
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
beq_cont.8506:
	addi	r1, r0, 1
	jr	r31				#
beq_then.8504:
	addi	r1, r0, 0
	jr	r31				#
solver_fast.3073:
	addi	r6, r0, 1				# set min_caml_objects
	flw	f1, 0(r5)
	flw	f2, 1(r5)
	flw	f3, 2(r5)
	add	r30, r6, r1
	lw	r5, 0(r30)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	sw	r5, 6(r3)
	fsw	f1, 8(r3)
	add	r1, r0, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	o_param_x.2934				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fsub	f1, f2, f1
	lw	r1, 6(r3)
	fsw	f1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	o_param_y.2936				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 4(r3)
	fsub	f1, f2, f1
	lw	r1, 6(r3)
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_param_z.2938				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 2(r3)
	fsub	f1, f2, f1
	lw	r1, 1(r3)
	fsw	f1, 14(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	d_const.2979				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r2, 0(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r2, 6(r3)
	sw	r1, 16(r3)
	add	r1, r0, r2
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	o_form.2918				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	beqi	1, r1, beq_then.8508
	beqi	2, r1, beq_then.8509
	flw	f1, 10(r3)
	flw	f2, 12(r3)
	flw	f3, 14(r3)
	lw	r1, 6(r3)
	lw	r2, 16(r3)
	j	solver_second_fast.3067
beq_then.8509:
	flw	f1, 10(r3)
	flw	f2, 12(r3)
	flw	f3, 14(r3)
	lw	r1, 6(r3)
	lw	r2, 16(r3)
	j	solver_surface_fast.3061
beq_then.8508:
	lw	r1, 1(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	d_vec.2977				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	add	r2, r0, r1
	flw	f1, 10(r3)
	flw	f2, 12(r3)
	flw	f3, 14(r3)
	lw	r1, 6(r3)
	lw	r5, 16(r3)
	j	solver_rect_fast.3054
solver_surface_fast2.3077:
	flw	f1, 0(r2)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	fisneg.2805				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.8510
	lw	r1, 1(r3)
	flw	f1, 0(r1)
	lw	r1, 0(r3)
	flw	f2, 3(r1)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.8510:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3084:
	flw	f4, 0(r2)
	sw	r1, 0(r3)
	fsw	f4, 2(r3)
	fsw	f3, 4(r3)
	fsw	f2, 6(r3)
	fsw	f1, 8(r3)
	sw	r5, 10(r3)
	sw	r2, 11(r3)
	fadd	f1, f0, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	fiszero.2807				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	beqi	0, r1, beq_then.8512
	addi	r1, r0, 0
	jr	r31				#
beq_then.8512:
	lw	r1, 11(r3)
	flw	f1, 1(r1)
	flw	f2, 2(r1)
	flw	f3, 3(r1)
	lw	r2, 10(r3)
	flw	f4, 3(r2)
	flw	f5, 8(r3)
	fmul	f1, f1, f5
	flw	f5, 6(r3)
	fmul	f2, f2, f5
	fadd	f1, f1, f2
	flw	f2, 4(r3)
	fmul	f2, f3, f2
	fadd	f1, f1, f2
	fsw	f1, 12(r3)
	fsw	f4, 14(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	fsqr.2814				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	flw	f3, 2(r3)
	fmul	f2, f3, f2
	fsub	f1, f1, f2
	fsw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	fispos.2803				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.8513
	lw	r1, 0(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	o_isinvert.2922				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.8514
	flw	f1, 16(r3)
	fsqrt	f1, f1
	lw	r1, 11(r3)
	flw	f2, 4(r1)
	flw	f3, 12(r3)
	fadd	f1, f3, f1
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	j	beq_cont.8515
beq_then.8514:
	flw	f1, 16(r3)
	fsqrt	f1, f1
	lw	r1, 11(r3)
	flw	f2, 4(r1)
	flw	f3, 12(r3)
	fsub	f1, f3, f1
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
beq_cont.8515:
	addi	r1, r0, 1
	jr	r31				#
beq_then.8513:
	addi	r1, r0, 0
	jr	r31				#
solver_fast2.3091:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r1
	lw	r5, 0(r30)
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	o_param_ctbl.2956				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	flw	f1, 0(r1)
	flw	f2, 1(r1)
	flw	f3, 2(r1)
	lw	r2, 2(r3)
	sw	r1, 3(r3)
	fsw	f3, 4(r3)
	fsw	f2, 6(r3)
	fsw	f1, 8(r3)
	add	r1, r0, r2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	d_const.2979				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 1(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r2, 0(r3)
	sw	r1, 10(r3)
	add	r1, r0, r2
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	o_form.2918				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	1, r1, beq_then.8516
	beqi	2, r1, beq_then.8517
	flw	f1, 8(r3)
	flw	f2, 6(r3)
	flw	f3, 4(r3)
	lw	r1, 0(r3)
	lw	r2, 10(r3)
	lw	r5, 3(r3)
	j	solver_second_fast2.3084
beq_then.8517:
	flw	f1, 8(r3)
	flw	f2, 6(r3)
	flw	f3, 4(r3)
	lw	r1, 0(r3)
	lw	r2, 10(r3)
	lw	r5, 3(r3)
	j	solver_surface_fast2.3077
beq_then.8516:
	lw	r1, 2(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	d_vec.2977				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1
	flw	f1, 8(r3)
	flw	f2, 6(r3)
	flw	f3, 4(r3)
	lw	r1, 0(r3)
	lw	r5, 10(r3)
	j	solver_rect_fast.3054
setup_rect_table.3094:
	flw	f1, 0(r1)
	addi	r5, r0, 6
	flup	f2, 0		# fli	f2, 0.000000
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	fsw	f1, 2(r3)
	add	r1, r0, r5
	fadd	f1, f0, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_float_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f1, 2(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	fiszero.2807				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.8518
	lw	r1, 4(r3)
	fsw	f0, 1(r1)
	j	beq_cont.8519
beq_then.8518:
	lw	r1, 1(r3)
	flw	f1, 0(r1)
	lw	r2, 0(r3)
	fsw	f1, 6(r3)
	add	r1, r0, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	o_isinvert.2922				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flup	f1, 2		# fli	f1, 1.000000
	lw	r2, 1(r3)
	flw	f2, 0(r2)
	flw	f3, 6(r3)
	fsw	f2, 8(r3)
	fsw	f1, 10(r3)
	sw	r1, 12(r3)
	fadd	f1, f0, f3
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	fisneg.2805				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r2, r0, r1
	lw	r1, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	xor.2859				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 0(r3)
	sw	r1, 13(r3)
	add	r1, r0, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_param_a.2926				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	fneg_cond.2864				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 4(r3)
	fsw	f1, 0(r1)
	flw	f1, 8(r3)
	flw	f2, 10(r3)
	fdiv	f1, f2, f1
	fsw	f1, 1(r1)
beq_cont.8519:
	lw	r2, 1(r3)
	flw	f1, 1(r2)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	fiszero.2807				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.8521
	lw	r1, 4(r3)
	fsw	f0, 3(r1)
	j	beq_cont.8522
beq_then.8521:
	lw	r1, 1(r3)
	flw	f1, 1(r1)
	lw	r2, 0(r3)
	fsw	f1, 14(r3)
	add	r1, r0, r2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	o_isinvert.2922				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flup	f1, 2		# fli	f1, 1.000000
	lw	r2, 1(r3)
	flw	f2, 1(r2)
	flw	f3, 14(r3)
	fsw	f2, 16(r3)
	fsw	f1, 18(r3)
	sw	r1, 20(r3)
	fadd	f1, f0, f3
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	fisneg.2805				
	addi	r3, r3, -22
	lw	r31, 21(r3)
	add	r2, r0, r1
	lw	r1, 20(r3)
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	xor.2859				
	addi	r3, r3, -22
	lw	r31, 21(r3)
	lw	r2, 0(r3)
	sw	r1, 21(r3)
	add	r1, r0, r2
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	o_param_b.2928				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	lw	r1, 21(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	fneg_cond.2864				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	lw	r1, 4(r3)
	fsw	f1, 2(r1)
	flw	f1, 16(r3)
	flw	f2, 18(r3)
	fdiv	f1, f2, f1
	fsw	f1, 3(r1)
beq_cont.8522:
	lw	r2, 1(r3)
	flw	f1, 2(r2)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	fiszero.2807				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	beqi	0, r1, beq_then.8523
	lw	r1, 4(r3)
	fsw	f0, 5(r1)
	j	beq_cont.8524
beq_then.8523:
	lw	r1, 1(r3)
	flw	f1, 2(r1)
	lw	r2, 0(r3)
	fsw	f1, 22(r3)
	add	r1, r0, r2
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	o_isinvert.2922				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flup	f1, 2		# fli	f1, 1.000000
	lw	r2, 1(r3)
	flw	f2, 2(r2)
	flw	f3, 22(r3)
	fsw	f2, 24(r3)
	fsw	f1, 26(r3)
	sw	r1, 28(r3)
	fadd	f1, f0, f3
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	fisneg.2805				
	addi	r3, r3, -30
	lw	r31, 29(r3)
	add	r2, r0, r1
	lw	r1, 28(r3)
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	xor.2859				
	addi	r3, r3, -30
	lw	r31, 29(r3)
	lw	r2, 0(r3)
	sw	r1, 29(r3)
	add	r1, r0, r2
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	o_param_c.2930				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	lw	r1, 29(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	fneg_cond.2864				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	lw	r1, 4(r3)
	fsw	f1, 4(r1)
	flw	f1, 24(r3)
	flw	f2, 26(r3)
	fdiv	f1, f2, f1
	fsw	f1, 5(r1)
beq_cont.8524:
	jr	r31				#
setup_surface_table.3097:
	addi	r5, r0, 4
	flup	f1, 0		# fli	f1, 0.000000
	flw	f2, 0(r1)
	flw	f3, 1(r1)
	flw	f4, 2(r1)
	fsw	f4, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	sw	r2, 6(r3)
	add	r1, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	sw	r1, 7(r3)
	add	r1, r0, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	o_param_a.2926				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	lw	r1, 6(r3)
	fsw	f1, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	o_param_b.2928				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 2(r3)
	fmul	f1, f2, f1
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	lw	r1, 6(r3)
	fsw	f1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	o_param_c.2930				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 0(r3)
	fmul	f1, f2, f1
	flw	f2, 10(r3)
	fadd	f1, f2, f1
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	fispos.2803				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.8525
	flup	f1, 11		# fli	f1, -1.000000
	flw	f2, 12(r3)
	fdiv	f1, f1, f2
	lw	r1, 7(r3)
	fsw	f1, 0(r1)
	lw	r2, 6(r3)
	add	r1, r0, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_param_a.2926				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fdiv	f1, f1, f2
	fneg	f1, f1
	lw	r1, 7(r3)
	fsw	f1, 1(r1)
	lw	r2, 6(r3)
	add	r1, r0, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_param_b.2928				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fdiv	f1, f1, f2
	fneg	f1, f1
	lw	r1, 7(r3)
	fsw	f1, 2(r1)
	lw	r2, 6(r3)
	add	r1, r0, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_param_c.2930				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fdiv	f1, f1, f2
	fneg	f1, f1
	lw	r1, 7(r3)
	fsw	f1, 3(r1)
	j	beq_cont.8526
beq_then.8525:
	lw	r1, 7(r3)
	fsw	f0, 0(r1)
beq_cont.8526:
	jr	r31				#
setup_second_table.3100:
	flw	f1, 0(r1)
	flw	f2, 1(r1)
	flw	f3, 2(r1)
	addi	r5, r0, 5
	flup	f4, 0		# fli	f4, 0.000000
	flw	f5, 0(r1)
	flw	f6, 1(r1)
	flw	f7, 2(r1)
	sw	r1, 0(r3)
	fsw	f7, 2(r3)
	fsw	f6, 4(r3)
	fsw	f5, 6(r3)
	fsw	f3, 8(r3)
	fsw	f2, 10(r3)
	fsw	f1, 12(r3)
	sw	r2, 14(r3)
	add	r1, r0, r5
	fadd	f1, f0, f4
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_float_array				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	flw	f1, 12(r3)
	flw	f2, 10(r3)
	flw	f3, 8(r3)
	lw	r2, 14(r3)
	sw	r1, 15(r3)
	add	r1, r0, r2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	quadratic.3031				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r1, 14(r3)
	fsw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	o_param_a.2926				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 6(r3)
	fmul	f1, f2, f1
	fneg	f1, f1
	lw	r1, 14(r3)
	fsw	f1, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	o_param_b.2928				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	fneg	f1, f1
	lw	r1, 14(r3)
	fsw	f1, 20(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	o_param_c.2930				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 2(r3)
	fmul	f1, f2, f1
	fneg	f1, f1
	lw	r1, 15(r3)
	flw	f2, 16(r3)
	fsw	f2, 0(r1)
	lw	r2, 14(r3)
	fsw	f1, 22(r3)
	add	r1, r0, r2
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	o_isrot.2924				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	beqi	0, r1, beq_then.8528
	lw	r1, 0(r3)
	flw	f1, 2(r1)
	lw	r2, 14(r3)
	fsw	f1, 24(r3)
	add	r1, r0, r2
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	o_param_r2.2952				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r1, 0(r3)
	flw	f2, 1(r1)
	flw	f3, 2(r1)
	flw	f4, 0(r1)
	flw	f5, 1(r1)
	flw	f6, 0(r1)
	flw	f7, 24(r3)
	fmul	f1, f7, f1
	lw	r1, 14(r3)
	fsw	f6, 26(r3)
	fsw	f5, 28(r3)
	fsw	f4, 30(r3)
	fsw	f3, 32(r3)
	fsw	f1, 34(r3)
	fsw	f2, 36(r3)
	sw	r31, 38(r3)
	addi	r3, r3, 39
	jal	o_param_r3.2954				
	addi	r3, r3, -39
	lw	r31, 38(r3)
	flw	f2, 36(r3)
	fmul	f1, f2, f1
	flw	f2, 34(r3)
	fadd	f1, f2, f1
	sw	r31, 38(r3)
	addi	r3, r3, 39
	jal	fhalf.2812				
	addi	r3, r3, -39
	lw	r31, 38(r3)
	flw	f2, 18(r3)
	fsub	f1, f2, f1
	lw	r1, 15(r3)
	fsw	f1, 1(r1)
	lw	r2, 14(r3)
	add	r1, r0, r2
	sw	r31, 38(r3)
	addi	r3, r3, 39
	jal	o_param_r1.2950				
	addi	r3, r3, -39
	lw	r31, 38(r3)
	flw	f2, 32(r3)
	fmul	f1, f2, f1
	lw	r1, 14(r3)
	fsw	f1, 38(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	o_param_r3.2954				
	addi	r3, r3, -41
	lw	r31, 40(r3)
	flw	f2, 30(r3)
	fmul	f1, f2, f1
	flw	f2, 38(r3)
	fadd	f1, f2, f1
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	fhalf.2812				
	addi	r3, r3, -41
	lw	r31, 40(r3)
	flw	f2, 20(r3)
	fsub	f1, f2, f1
	lw	r1, 15(r3)
	fsw	f1, 2(r1)
	lw	r2, 14(r3)
	add	r1, r0, r2
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	o_param_r1.2950				
	addi	r3, r3, -41
	lw	r31, 40(r3)
	flw	f2, 28(r3)
	fmul	f1, f2, f1
	lw	r1, 14(r3)
	fsw	f1, 40(r3)
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	o_param_r2.2952				
	addi	r3, r3, -43
	lw	r31, 42(r3)
	flw	f2, 26(r3)
	fmul	f1, f2, f1
	flw	f2, 40(r3)
	fadd	f1, f2, f1
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	fhalf.2812				
	addi	r3, r3, -43
	lw	r31, 42(r3)
	flw	f2, 22(r3)
	fsub	f1, f2, f1
	lw	r1, 15(r3)
	fsw	f1, 3(r1)
	j	beq_cont.8529
beq_then.8528:
	lw	r1, 15(r3)
	flw	f1, 18(r3)
	fsw	f1, 1(r1)
	flw	f1, 20(r3)
	fsw	f1, 2(r1)
	flw	f1, 22(r3)
	fsw	f1, 3(r1)
beq_cont.8529:
	flw	f1, 16(r3)
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	fiszero.2807				
	addi	r3, r3, -43
	lw	r31, 42(r3)
	beqi	0, r1, beq_then.8530
	j	beq_cont.8531
beq_then.8530:
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 16(r3)
	fdiv	f1, f1, f2
	lw	r1, 15(r3)
	fsw	f1, 4(r1)
beq_cont.8531:
	lw	r1, 15(r3)
	jr	r31				#
iter_setup_dirvec_constants.3103:
	bgei	0, r2, bge_then.8532
	jr	r31				#
bge_then.8532:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 0(r3)
	sw	r5, 1(r3)
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	d_const.2979				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 2(r3)
	sw	r1, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	d_vec.2977				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 1(r3)
	sw	r1, 4(r3)
	add	r1, r0, r2
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	o_form.2918				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	1, r1, beq_then.8534
	beqi	2, r1, beq_then.8536
	lw	r1, 4(r3)
	lw	r2, 1(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3100				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 0(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.8537
beq_then.8536:
	lw	r1, 4(r3)
	lw	r2, 1(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3097				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 0(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.8537:
	j	beq_cont.8535
beq_then.8534:
	lw	r1, 4(r3)
	lw	r2, 1(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3094				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 0(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.8535:
	addi	r2, r2, -1
	lw	r1, 2(r3)
	j	iter_setup_dirvec_constants.3103
setup_dirvec_constants.3106:
	lw	r2, 0(r0)
	addi	r2, r2, -1
	j	iter_setup_dirvec_constants.3103
setup_startp_constants.3108:
	bgei	0, r2, bge_then.8538
	jr	r31				#
bge_then.8538:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	o_param_ctbl.2956				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 2(r3)
	sw	r1, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	o_form.2918				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 1(r3)
	flw	f1, 0(r2)
	lw	r5, 2(r3)
	sw	r1, 4(r3)
	fsw	f1, 6(r3)
	add	r1, r0, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	o_param_x.2934				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fsub	f1, f2, f1
	lw	r1, 3(r3)
	fsw	f1, 0(r1)
	lw	r2, 1(r3)
	flw	f1, 1(r2)
	lw	r5, 2(r3)
	fsw	f1, 8(r3)
	add	r1, r0, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	o_param_y.2936				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fsub	f1, f2, f1
	lw	r1, 3(r3)
	fsw	f1, 1(r1)
	lw	r2, 1(r3)
	flw	f1, 2(r2)
	lw	r5, 2(r3)
	fsw	f1, 10(r3)
	add	r1, r0, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	o_param_z.2938				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fsub	f1, f2, f1
	lw	r1, 3(r3)
	fsw	f1, 2(r1)
	lw	r2, 4(r3)
	beqi	2, r2, beq_then.8541
	blei	2, r2, ble_then.8543
	flw	f1, 0(r1)
	flw	f2, 1(r1)
	flw	f3, 2(r1)
	lw	r5, 2(r3)
	add	r1, r0, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	quadratic.3031				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 4(r3)
	beqi	3, r1, beq_then.8545
	j	beq_cont.8546
beq_then.8545:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.8546:
	lw	r1, 3(r3)
	fsw	f1, 3(r1)
	j	ble_cont.8544
ble_then.8543:
ble_cont.8544:
	j	beq_cont.8542
beq_then.8541:
	lw	r2, 2(r3)
	add	r1, r0, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	o_param_abc.2932				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r2, 3(r3)
	flw	f1, 0(r2)
	flw	f2, 1(r2)
	flw	f3, 2(r2)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	veciprod2.2894				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 3(r3)
	fsw	f1, 3(r1)
beq_cont.8542:
	lw	r1, 0(r3)
	addi	r2, r1, -1
	lw	r1, 1(r3)
	j	setup_startp_constants.3108
setup_startp.3111:
	lw	r2, 0(r0)
	addi	r5, r0, 751				# set min_caml_startp_fast
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	veccpy.2880				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	j	setup_startp_constants.3108
is_rect_outside.3113:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	sw	r1, 4(r3)
	fsw	f1, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	o_param_a.2926				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	fabs.2816				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8548
	addi	r1, r0, 0
	j	fle_cont.8549
fle_else.8548:
	lw	r1, 4(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	o_param_b.2928				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 2(r3)
	fsw	f1, 10(r3)
	fadd	f1, f0, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	fabs.2816				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8550
	addi	r1, r0, 0
	j	fle_cont.8551
fle_else.8550:
	lw	r1, 4(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	o_param_c.2930				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 0(r3)
	fsw	f1, 12(r3)
	fadd	f1, f0, f2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	fabs.2816				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8552
	addi	r1, r0, 0
	j	fle_cont.8553
fle_else.8552:
	addi	r1, r0, 1
fle_cont.8553:
fle_cont.8551:
fle_cont.8549:
	beqi	0, r1, beq_then.8554
	lw	r1, 4(r3)
	j	o_isinvert.2922
beq_then.8554:
	lw	r1, 4(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_isinvert.2922				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.8555
	addi	r1, r0, 0
	jr	r31				#
beq_then.8555:
	addi	r1, r0, 1
	jr	r31				#
is_plane_outside.3118:
	sw	r1, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	fsw	f1, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	o_param_abc.2932				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f1, 6(r3)
	flw	f2, 4(r3)
	flw	f3, 2(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	veciprod2.2894				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 0(r3)
	fsw	f1, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	o_isinvert.2922				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f1, 8(r3)
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	fisneg.2805				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1
	lw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	xor.2859				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.8557
	addi	r1, r0, 0
	jr	r31				#
beq_then.8557:
	addi	r1, r0, 1
	jr	r31				#
is_second_outside.3123:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3031				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	fsw	f1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	o_form.2918				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	3, r1, beq_then.8559
	flw	f1, 2(r3)
	j	beq_cont.8560
beq_then.8559:
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 2(r3)
	fsub	f1, f2, f1
beq_cont.8560:
	lw	r1, 0(r3)
	fsw	f1, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	o_isinvert.2922				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f1, 4(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	fisneg.2805				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r1
	lw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	xor.2859				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	0, r1, beq_then.8561
	addi	r1, r0, 0
	jr	r31				#
beq_then.8561:
	addi	r1, r0, 1
	jr	r31				#
is_outside.3128:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	sw	r1, 4(r3)
	fsw	f1, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	o_param_x.2934				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fsub	f1, f2, f1
	lw	r1, 4(r3)
	fsw	f1, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	o_param_y.2936				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 2(r3)
	fsub	f1, f2, f1
	lw	r1, 4(r3)
	fsw	f1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	o_param_z.2938				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 0(r3)
	fsub	f1, f2, f1
	lw	r1, 4(r3)
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_form.2918				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	1, r1, beq_then.8563
	beqi	2, r1, beq_then.8564
	flw	f1, 8(r3)
	flw	f2, 10(r3)
	flw	f3, 12(r3)
	lw	r1, 4(r3)
	j	is_second_outside.3123
beq_then.8564:
	flw	f1, 8(r3)
	flw	f2, 10(r3)
	flw	f3, 12(r3)
	lw	r1, 4(r3)
	j	is_plane_outside.3118
beq_then.8563:
	flw	f1, 8(r3)
	flw	f2, 10(r3)
	flw	f3, 12(r3)
	lw	r1, 4(r3)
	j	is_rect_outside.3113
check_all_inside.3133:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.8565
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r5, 0(r30)
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	add	r1, r0, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	is_outside.3128				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.8566
	addi	r1, r0, 0
	jr	r31				#
beq_then.8566:
	lw	r1, 7(r3)
	addi	r1, r1, 1
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r2, 6(r3)
	j	check_all_inside.3133
beq_then.8565:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3139:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.8567
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 1021				# set min_caml_light_dirvec
	addi	r7, r0, 727				# set min_caml_intersection_point
	flw	f1, 724(r0)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	fsw	f1, 4(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	add	r5, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solver_fast.3073				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.8569
	flup	f1, 28		# fli	f1, -0.200000
	flw	f2, 4(r3)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8571
	addi	r1, r0, 0
	j	fle_cont.8572
fle_else.8571:
	addi	r1, r0, 1
fle_cont.8572:
	j	beq_cont.8570
beq_then.8569:
	addi	r1, r0, 0
beq_cont.8570:
	beqi	0, r1, beq_then.8573
	flup	f1, 29		# fli	f1, 0.010000
	flw	f2, 667(r0)
	flw	f3, 668(r0)
	flw	f4, 669(r0)
	flw	f5, 727(r0)
	flw	f6, 728(r0)
	flw	f7, 729(r0)
	addi	r1, r0, 0
	flw	f8, 4(r3)
	fadd	f1, f8, f1
	fmul	f2, f2, f1
	fadd	f2, f2, f5
	fmul	f3, f3, f1
	fadd	f3, f3, f6
	fmul	f1, f4, f1
	fadd	f1, f1, f7
	lw	r2, 0(r3)
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f2
	fadd	f2, f0, f30
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	check_all_inside.3133				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.8574
	addi	r1, r0, 1
	jr	r31				#
beq_then.8574:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_and_group.3139
beq_then.8573:
	addi	r1, r0, 1				# set min_caml_objects
	lw	r2, 2(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	o_isinvert.2922				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.8575
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_and_group.3139
beq_then.8575:
	addi	r1, r0, 0
	jr	r31				#
beq_then.8567:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3142:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.8576
	addi	r6, r0, 672				# set min_caml_and_net
	addi	r7, r0, 0
	add	r30, r6, r5
	lw	r5, 0(r30)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.8577
	addi	r1, r0, 1
	jr	r31				#
beq_then.8577:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_one_or_group.3142
beq_then.8576:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3145:
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.8578
	addi	r7, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r6, r7, beq_then.8579
	addi	r7, r0, 1021				# set min_caml_light_dirvec
	addi	r8, r0, 727				# set min_caml_intersection_point
	add	r5, r0, r8
	add	r2, r0, r7
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_fast.3073				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.8581
	flw	f1, 724(r0)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8583
	addi	r1, r0, 0
	j	fle_cont.8584
fle_else.8583:
	addi	r1, r0, 1
	lw	r2, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_one_or_group.3142				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.8585
	addi	r1, r0, 1
	j	beq_cont.8586
beq_then.8585:
	addi	r1, r0, 0
beq_cont.8586:
fle_cont.8584:
	j	beq_cont.8582
beq_then.8581:
	addi	r1, r0, 0
beq_cont.8582:
	j	beq_cont.8580
beq_then.8579:
	addi	r1, r0, 1
beq_cont.8580:
	beqi	0, r1, beq_then.8587
	addi	r1, r0, 1
	lw	r2, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_one_or_group.3142				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.8588
	addi	r1, r0, 1
	jr	r31				#
beq_then.8588:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	j	shadow_check_one_or_matrix.3145
beq_then.8587:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	j	shadow_check_one_or_matrix.3145
beq_then.8578:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3148:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.8589
	addi	r7, r0, 748				# set min_caml_startp
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r6, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	add	r5, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver.3050				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.8590
	flw	f1, 724(r0)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.8591
	j	fle_cont.8592
fle_else.8591:
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8593
	j	fle_cont.8594
fle_else.8593:
	flup	f2, 29		# fli	f2, 0.010000
	lw	r2, 0(r3)
	flw	f3, 0(r2)
	flw	f4, 1(r2)
	flw	f5, 2(r2)
	flw	f6, 748(r0)
	flw	f7, 749(r0)
	flw	f8, 750(r0)
	addi	r5, r0, 0
	fadd	f1, f1, f2
	fmul	f2, f3, f1
	fadd	f2, f2, f6
	fmul	f3, f4, f1
	fadd	f3, f3, f7
	fmul	f4, f5, f1
	fadd	f4, f4, f8
	lw	r6, 1(r3)
	sw	r1, 4(r3)
	fsw	f4, 6(r3)
	fsw	f3, 8(r3)
	fsw	f2, 10(r3)
	fsw	f1, 12(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	fadd	f1, f0, f2
	fadd	f2, f0, f3
	fadd	f3, f0, f4
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	check_all_inside.3133				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.8596
	addi	r1, r0, 727				# set min_caml_intersection_point
	flw	f1, 12(r3)
	fsw	f1, 726(r0)
	flw	f1, 10(r3)
	flw	f2, 8(r3)
	flw	f3, 6(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	vecset.2870				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 3(r3)
	sw	r1, 730(r0)
	lw	r1, 4(r3)
	sw	r1, 725(r0)
	j	beq_cont.8597
beq_then.8596:
beq_cont.8597:
fle_cont.8594:
fle_cont.8592:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3148
beq_then.8590:
	addi	r1, r0, 1				# set min_caml_objects
	lw	r2, 3(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_isinvert.2922				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.8598
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3148
beq_then.8598:
	jr	r31				#
beq_then.8589:
	jr	r31				#
solve_one_or_network.3152:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.8601
	addi	r7, r0, 672				# set min_caml_and_net
	addi	r8, r0, 0
	addi	r1, r1, 1
	add	r30, r7, r6
	lw	r6, 0(r30)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_one_or_network.3152
beq_then.8601:
	jr	r31				#
trace_or_matrix.3156:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.8603
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.8604
	addi	r8, r0, 748				# set min_caml_startp
	sw	r6, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	add	r5, r0, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver.3050				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.8606
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8608
	j	fle_cont.8609
fle_else.8608:
	addi	r1, r0, 1
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network.3152				
	addi	r3, r3, -5
	lw	r31, 4(r3)
fle_cont.8609:
	j	beq_cont.8607
beq_then.8606:
beq_cont.8607:
	j	beq_cont.8605
beq_then.8604:
	addi	r7, r0, 1
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network.3152				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.8605:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix.3156
beq_then.8603:
	jr	r31				#
judge_intersection.3160:
	lw	r2, 723(r0)
	flup	f1, 31		# fli	f1, 1000000000.000000
	addi	r5, r0, 0
	flw	f2, 726(r0)
	flup	f3, 30		# fli	f3, -0.100000
	fsw	f1, 726(r0)
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r28
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_or_matrix.3156				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8611
	addi	r1, r0, 0
	jr	r31				#
fle_else.8611:
	flup	f1, 32		# fli	f1, 100000000.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8612
	addi	r1, r0, 0
	jr	r31				#
fle_else.8612:
	addi	r1, r0, 1
	jr	r31				#
solve_each_element_fast.3162:
	add	r30, r2, r1
	lw	r6, 0(r30)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r6, 3(r3)
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	d_vec.2977				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	beqi	-1, r2, beq_then.8613
	lw	r5, 2(r3)
	sw	r1, 4(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_fast2.3091				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.8614
	flw	f1, 724(r0)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.8615
	j	fle_cont.8616
fle_else.8615:
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8617
	j	fle_cont.8618
fle_else.8617:
	flup	f2, 29		# fli	f2, 0.010000
	lw	r2, 4(r3)
	flw	f3, 0(r2)
	flw	f4, 1(r2)
	flw	f5, 2(r2)
	flw	f6, 751(r0)
	flw	f7, 752(r0)
	flw	f8, 753(r0)
	addi	r2, r0, 0
	fadd	f1, f1, f2
	fmul	f2, f3, f1
	fadd	f2, f2, f6
	fmul	f3, f4, f1
	fadd	f3, f3, f7
	fmul	f4, f5, f1
	fadd	f4, f4, f8
	lw	r5, 0(r3)
	sw	r1, 5(r3)
	fsw	f4, 6(r3)
	fsw	f3, 8(r3)
	fsw	f2, 10(r3)
	fsw	f1, 12(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	fadd	f1, f0, f2
	fadd	f2, f0, f3
	fadd	f3, f0, f4
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	check_all_inside.3133				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.8619
	addi	r1, r0, 727				# set min_caml_intersection_point
	flw	f1, 12(r3)
	fsw	f1, 726(r0)
	flw	f1, 10(r3)
	flw	f2, 8(r3)
	flw	f3, 6(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	vecset.2870				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 3(r3)
	sw	r1, 730(r0)
	lw	r1, 5(r3)
	sw	r1, 725(r0)
	j	beq_cont.8620
beq_then.8619:
beq_cont.8620:
fle_cont.8618:
fle_cont.8616:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	j	solve_each_element_fast.3162
beq_then.8614:
	addi	r1, r0, 1				# set min_caml_objects
	lw	r2, 3(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_isinvert.2922				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.8621
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	j	solve_each_element_fast.3162
beq_then.8621:
	jr	r31				#
beq_then.8613:
	jr	r31				#
solve_one_or_network_fast.3166:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.8624
	addi	r7, r0, 672				# set min_caml_and_net
	addi	r8, r0, 0
	addi	r1, r1, 1
	add	r30, r7, r6
	lw	r6, 0(r30)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_one_or_network_fast.3166
beq_then.8624:
	jr	r31				#
trace_or_matrix_fast.3170:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.8626
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.8627
	sw	r6, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_fast2.3091				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.8629
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8631
	j	fle_cont.8632
fle_else.8631:
	addi	r1, r0, 1
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -5
	lw	r31, 4(r3)
fle_cont.8632:
	j	beq_cont.8630
beq_then.8629:
beq_cont.8630:
	j	beq_cont.8628
beq_then.8627:
	addi	r7, r0, 1
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.8628:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix_fast.3170
beq_then.8626:
	jr	r31				#
judge_intersection_fast.3174:
	lw	r2, 723(r0)
	flup	f1, 31		# fli	f1, 1000000000.000000
	addi	r5, r0, 0
	flw	f2, 726(r0)
	flup	f3, 30		# fli	f3, -0.100000
	fsw	f1, 726(r0)
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r28
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_or_matrix_fast.3170				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8634
	addi	r1, r0, 0
	jr	r31				#
fle_else.8634:
	flup	f1, 32		# fli	f1, 100000000.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.8635
	addi	r1, r0, 0
	jr	r31				#
fle_else.8635:
	addi	r1, r0, 1
	jr	r31				#
get_nvector_rect.3176:
	lw	r2, 725(r0)
	addi	r5, r0, 731				# set min_caml_nvector
	addi	r6, r0, 731				# set min_caml_nvector
	sw	r6, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	vecbzero.2878				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r2, r1, -1
	addi	r1, r1, -1
	lw	r5, 1(r3)
	add	r30, r5, r1
	flw	f1, 0(r30)
	sw	r2, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sgn.2862				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fneg	f1, f1
	lw	r1, 3(r3)
	lw	r2, 0(r3)
	add	r30, r2, r1
	fsw	f1, 0(r30)
	jr	r31				#
get_nvector_plane.3178:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	o_param_a.2926				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	fneg	f1, f1
	fsw	f1, 731(r0)
	lw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	o_param_b.2928				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	fneg	f1, f1
	fsw	f1, 732(r0)
	lw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	o_param_c.2930				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	fneg	f1, f1
	fsw	f1, 733(r0)
	jr	r31				#
get_nvector_second.3180:
	flw	f1, 727(r0)
	sw	r1, 0(r3)
	fsw	f1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	o_param_x.2934				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 728(r0)
	flw	f3, 729(r0)
	flw	f4, 2(r3)
	fsub	f1, f4, f1
	lw	r1, 0(r3)
	fsw	f1, 4(r3)
	fsw	f3, 6(r3)
	fsw	f2, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	o_param_y.2936				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fsub	f1, f2, f1
	lw	r1, 0(r3)
	fsw	f1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	o_param_z.2938				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 6(r3)
	fsub	f1, f2, f1
	lw	r1, 0(r3)
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_param_a.2926				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	lw	r1, 0(r3)
	fsw	f1, 14(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	o_param_b.2928				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 10(r3)
	fmul	f1, f2, f1
	lw	r1, 0(r3)
	fsw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	o_param_c.2930				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 12(r3)
	fmul	f1, f2, f1
	lw	r1, 0(r3)
	fsw	f1, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	o_isrot.2924				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.8639
	lw	r1, 0(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	o_param_r3.2954				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 10(r3)
	fmul	f1, f2, f1
	lw	r1, 0(r3)
	fsw	f1, 20(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	o_param_r2.2952				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 12(r3)
	fmul	f1, f2, f1
	flw	f3, 20(r3)
	fadd	f1, f3, f1
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	fhalf.2812				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	fsw	f1, 731(r0)
	lw	r1, 0(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	o_param_r3.2954				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	lw	r1, 0(r3)
	fsw	f1, 22(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	o_param_r1.2950				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 12(r3)
	fmul	f1, f2, f1
	flw	f2, 22(r3)
	fadd	f1, f2, f1
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	fhalf.2812				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 16(r3)
	fadd	f1, f2, f1
	fsw	f1, 732(r0)
	lw	r1, 0(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	o_param_r2.2952				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	lw	r1, 0(r3)
	fsw	f1, 24(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	o_param_r1.2950				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 10(r3)
	fmul	f1, f2, f1
	flw	f2, 24(r3)
	fadd	f1, f2, f1
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	fhalf.2812				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 18(r3)
	fadd	f1, f2, f1
	fsw	f1, 733(r0)
	j	beq_cont.8640
beq_then.8639:
	flw	f1, 14(r3)
	fsw	f1, 731(r0)
	flw	f1, 16(r3)
	fsw	f1, 732(r0)
	flw	f1, 18(r3)
	fsw	f1, 733(r0)
beq_cont.8640:
	addi	r1, r0, 731				# set min_caml_nvector
	lw	r2, 0(r3)
	sw	r1, 26(r3)
	add	r1, r0, r2
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	o_isinvert.2922				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	add	r2, r0, r1
	lw	r1, 26(r3)
	j	vecunit_sgn.2888
get_nvector.3182:
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	o_form.2918				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	1, r1, beq_then.8641
	beqi	2, r1, beq_then.8642
	lw	r1, 0(r3)
	j	get_nvector_second.3180
beq_then.8642:
	lw	r1, 0(r3)
	j	get_nvector_plane.3178
beq_then.8641:
	lw	r1, 1(r3)
	j	get_nvector_rect.3176
utexture.3185:
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	o_texturetype.2916				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	sw	r1, 2(r3)
	add	r1, r0, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	o_color_red.2944				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	fsw	f1, 734(r0)
	lw	r1, 1(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	o_color_green.2946				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	fsw	f1, 735(r0)
	lw	r1, 1(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	o_color_blue.2948				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	fsw	f1, 736(r0)
	lw	r1, 2(r3)
	beqi	1, r1, beq_then.8643
	beqi	2, r1, beq_then.8644
	beqi	3, r1, beq_then.8645
	beqi	4, r1, beq_then.8646
	jr	r31				#
beq_then.8646:
	lw	r1, 0(r3)
	flw	f1, 0(r1)
	lw	r2, 1(r3)
	fsw	f1, 4(r3)
	add	r1, r0, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	o_param_x.2934				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fsub	f1, f2, f1
	lw	r1, 1(r3)
	fsw	f1, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	o_param_a.2926				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fsqrt	f1, f1
	flw	f2, 6(r3)
	fmul	f1, f2, f1
	lw	r1, 0(r3)
	flw	f2, 2(r1)
	lw	r2, 1(r3)
	fsw	f1, 8(r3)
	fsw	f2, 10(r3)
	add	r1, r0, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	o_param_z.2938				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fsub	f1, f2, f1
	lw	r1, 1(r3)
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_param_c.2930				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	fsqrt	f1, f1
	flw	f2, 12(r3)
	fmul	f1, f2, f1
	flw	f2, 8(r3)
	fsw	f1, 14(r3)
	fadd	f1, f0, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	fsqr.2814				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fsw	f1, 16(r3)
	fadd	f1, f0, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	fsqr.2814				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fadd	f1, f2, f1
	flup	f2, 33		# fli	f2, 0.000100
	flw	f3, 8(r3)
	fsw	f1, 18(r3)
	fsw	f2, 20(r3)
	fadd	f1, f0, f3
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	fabs.2816				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 20(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8649
	flw	f1, 8(r3)
	flw	f2, 14(r3)
	fdiv	f1, f2, f1
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	fabs.2816				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	atan.2843				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.8650
fle_else.8649:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.8650:
	fsw	f1, 22(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	floor.2822				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 22(r3)
	fsub	f1, f2, f1
	lw	r1, 0(r3)
	flw	f2, 1(r1)
	lw	r1, 1(r3)
	fsw	f1, 24(r3)
	fsw	f2, 26(r3)
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	o_param_y.2936				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	flw	f2, 26(r3)
	fsub	f1, f2, f1
	lw	r1, 1(r3)
	fsw	f1, 28(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	o_param_b.2928				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	fsqrt	f1, f1
	flw	f2, 28(r3)
	fmul	f1, f2, f1
	flup	f2, 33		# fli	f2, 0.000100
	flw	f3, 18(r3)
	fsw	f1, 30(r3)
	fsw	f2, 32(r3)
	fadd	f1, f0, f3
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	fabs.2816				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flw	f2, 32(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8651
	flw	f1, 18(r3)
	flw	f2, 30(r3)
	fdiv	f1, f2, f1
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	fabs.2816				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	atan.2843				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.8652
fle_else.8651:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.8652:
	fsw	f1, 34(r3)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	floor.2822				
	addi	r3, r3, -37
	lw	r31, 36(r3)
	flw	f2, 34(r3)
	fsub	f1, f2, f1
	flup	f2, 36		# fli	f2, 0.150000
	flup	f3, 1		# fli	f3, 0.500000
	flw	f4, 24(r3)
	fsub	f3, f3, f4
	fsw	f1, 36(r3)
	fsw	f2, 38(r3)
	fadd	f1, f0, f3
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	fsqr.2814				
	addi	r3, r3, -41
	lw	r31, 40(r3)
	flw	f2, 38(r3)
	fsub	f1, f2, f1
	flup	f2, 1		# fli	f2, 0.500000
	flw	f3, 36(r3)
	fsub	f2, f2, f3
	fsw	f1, 40(r3)
	fadd	f1, f0, f2
	sw	r31, 42(r3)
	addi	r3, r3, 43
	jal	fsqr.2814				
	addi	r3, r3, -43
	lw	r31, 42(r3)
	flw	f2, 40(r3)
	fsub	f1, f2, f1
	fsw	f1, 42(r3)
	sw	r31, 44(r3)
	addi	r3, r3, 45
	jal	fisneg.2805				
	addi	r3, r3, -45
	lw	r31, 44(r3)
	beqi	0, r1, beq_then.8653
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.8654
beq_then.8653:
	flw	f1, 42(r3)
beq_cont.8654:
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f2, f1
	flup	f2, 38		# fli	f2, 0.300000
	fdiv	f1, f1, f2
	fsw	f1, 736(r0)
	jr	r31				#
beq_then.8645:
	lw	r1, 0(r3)
	flw	f1, 0(r1)
	lw	r2, 1(r3)
	fsw	f1, 44(r3)
	add	r1, r0, r2
	sw	r31, 46(r3)
	addi	r3, r3, 47
	jal	o_param_x.2934				
	addi	r3, r3, -47
	lw	r31, 46(r3)
	flw	f2, 44(r3)
	fsub	f1, f2, f1
	lw	r1, 0(r3)
	flw	f2, 2(r1)
	lw	r1, 1(r3)
	fsw	f1, 46(r3)
	fsw	f2, 48(r3)
	sw	r31, 50(r3)
	addi	r3, r3, 51
	jal	o_param_z.2938				
	addi	r3, r3, -51
	lw	r31, 50(r3)
	flw	f2, 48(r3)
	fsub	f1, f2, f1
	flw	f2, 46(r3)
	fsw	f1, 50(r3)
	fadd	f1, f0, f2
	sw	r31, 52(r3)
	addi	r3, r3, 53
	jal	fsqr.2814				
	addi	r3, r3, -53
	lw	r31, 52(r3)
	flw	f2, 50(r3)
	fsw	f1, 52(r3)
	fadd	f1, f0, f2
	sw	r31, 54(r3)
	addi	r3, r3, 55
	jal	fsqr.2814				
	addi	r3, r3, -55
	lw	r31, 54(r3)
	flw	f2, 52(r3)
	fadd	f1, f2, f1
	fsqrt	f1, f1
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	fsw	f1, 54(r3)
	sw	r31, 56(r3)
	addi	r3, r3, 57
	jal	floor.2822				
	addi	r3, r3, -57
	lw	r31, 56(r3)
	flw	f2, 54(r3)
	fsub	f1, f2, f1
	flup	f2, 14		# fli	f2, 3.141593
	fmul	f1, f1, f2
	sw	r31, 56(r3)
	addi	r3, r3, 57
	jal	cos.2839				
	addi	r3, r3, -57
	lw	r31, 56(r3)
	sw	r31, 56(r3)
	addi	r3, r3, 57
	jal	fsqr.2814				
	addi	r3, r3, -57
	lw	r31, 56(r3)
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f1, f2
	fsw	f2, 735(r0)
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f2, f1
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f1, f2
	fsw	f1, 736(r0)
	jr	r31				#
beq_then.8644:
	lw	r1, 0(r3)
	flw	f1, 1(r1)
	flup	f2, 40		# fli	f2, 0.250000
	fmul	f1, f1, f2
	sw	r31, 56(r3)
	addi	r3, r3, 57
	jal	sin.2837				
	addi	r3, r3, -57
	lw	r31, 56(r3)
	sw	r31, 56(r3)
	addi	r3, r3, 57
	jal	fsqr.2814				
	addi	r3, r3, -57
	lw	r31, 56(r3)
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f2, f1
	fsw	f2, 734(r0)
	flup	f2, 37		# fli	f2, 255.000000
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f1, f3, f1
	fmul	f1, f2, f1
	fsw	f1, 735(r0)
	jr	r31				#
beq_then.8643:
	lw	r1, 0(r3)
	flw	f1, 0(r1)
	lw	r2, 1(r3)
	fsw	f1, 56(r3)
	add	r1, r0, r2
	sw	r31, 58(r3)
	addi	r3, r3, 59
	jal	o_param_x.2934				
	addi	r3, r3, -59
	lw	r31, 58(r3)
	flup	f2, 41		# fli	f2, 0.050000
	flup	f3, 42		# fli	f3, 20.000000
	flup	f4, 39		# fli	f4, 10.000000
	flw	f5, 56(r3)
	fsub	f1, f5, f1
	fmul	f2, f1, f2
	fsw	f4, 58(r3)
	fsw	f1, 60(r3)
	fsw	f3, 62(r3)
	fadd	f1, f0, f2
	sw	r31, 64(r3)
	addi	r3, r3, 65
	jal	floor.2822				
	addi	r3, r3, -65
	lw	r31, 64(r3)
	flw	f2, 62(r3)
	fmul	f1, f1, f2
	flw	f2, 60(r3)
	fsub	f1, f2, f1
	flw	f2, 58(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8658
	addi	r1, r0, 0
	j	fle_cont.8659
fle_else.8658:
	addi	r1, r0, 1
fle_cont.8659:
	lw	r2, 0(r3)
	flw	f1, 2(r2)
	lw	r2, 1(r3)
	sw	r1, 64(r3)
	fsw	f1, 66(r3)
	add	r1, r0, r2
	sw	r31, 68(r3)
	addi	r3, r3, 69
	jal	o_param_z.2938				
	addi	r3, r3, -69
	lw	r31, 68(r3)
	flup	f2, 41		# fli	f2, 0.050000
	flup	f3, 42		# fli	f3, 20.000000
	flup	f4, 39		# fli	f4, 10.000000
	flw	f5, 66(r3)
	fsub	f1, f5, f1
	fmul	f2, f1, f2
	fsw	f4, 68(r3)
	fsw	f1, 70(r3)
	fsw	f3, 72(r3)
	fadd	f1, f0, f2
	sw	r31, 74(r3)
	addi	r3, r3, 75
	jal	floor.2822				
	addi	r3, r3, -75
	lw	r31, 74(r3)
	flw	f2, 72(r3)
	fmul	f1, f1, f2
	flw	f2, 70(r3)
	fsub	f1, f2, f1
	flw	f2, 68(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8661
	addi	r1, r0, 0
	j	fle_cont.8662
fle_else.8661:
	addi	r1, r0, 1
fle_cont.8662:
	lw	r2, 64(r3)
	beqi	0, r2, beq_then.8663
	beqi	0, r1, beq_then.8665
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.8666
beq_then.8665:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.8666:
	j	beq_cont.8664
beq_then.8663:
	beqi	0, r1, beq_then.8667
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.8668
beq_then.8667:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.8668:
beq_cont.8664:
	fsw	f1, 735(r0)
	jr	r31				#
add_light.3188:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	fispos.2803				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.8670
	addi	r1, r0, 740				# set min_caml_rgb
	addi	r2, r0, 734				# set min_caml_texture_color
	flw	f1, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecaccum.2899				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.8671
beq_then.8670:
beq_cont.8671:
	flw	f1, 2(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	fispos.2803				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.8672
	flw	f1, 2(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	fsqr.2814				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 740(r0)
	flw	f3, 741(r0)
	flw	f4, 742(r0)
	fsw	f4, 6(r3)
	fsw	f3, 8(r3)
	fsw	f2, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	fsqr.2814				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	flw	f2, 10(r3)
	fadd	f2, f2, f1
	fsw	f2, 740(r0)
	flw	f2, 8(r3)
	fadd	f2, f2, f1
	fsw	f2, 741(r0)
	flw	f2, 6(r3)
	fadd	f1, f2, f1
	fsw	f1, 742(r0)
	jr	r31				#
beq_then.8672:
	jr	r31				#
trace_reflections.3192:
	bgei	0, r1, bge_then.8675
	jr	r31				#
bge_then.8675:
	addi	r5, r0, 778				# set min_caml_reflections
	add	r30, r5, r1
	lw	r5, 0(r30)
	sw	r1, 0(r3)
	fsw	f2, 2(r3)
	sw	r2, 4(r3)
	fsw	f1, 6(r3)
	sw	r5, 8(r3)
	add	r1, r0, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	r_dvec.2983				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	sw	r1, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	judge_intersection_fast.3174				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.8679
	lw	r1, 730(r0)
	slli	r1, r1, 2
	lw	r2, 725(r0)
	add	r1, r1, r2
	lw	r2, 8(r3)
	sw	r1, 10(r3)
	add	r1, r0, r2
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	r_surface_id.2981				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 10(r3)
	beq	r2, r1, beq_then.8681
	j	beq_cont.8682
beq_then.8681:
	addi	r1, r0, 0
	lw	r2, 723(r0)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	shadow_check_one_or_matrix.3145				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.8683
	j	beq_cont.8684
beq_then.8683:
	addi	r1, r0, 731				# set min_caml_nvector
	lw	r2, 9(r3)
	sw	r1, 11(r3)
	add	r1, r0, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	d_vec.2977				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r2, r0, r1
	lw	r1, 11(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	veciprod.2891				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 8(r3)
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	r_bright.2985				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 6(r3)
	fmul	f3, f1, f2
	flw	f4, 12(r3)
	fmul	f3, f3, f4
	lw	r1, 9(r3)
	fsw	f3, 14(r3)
	fsw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	d_vec.2977				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	add	r2, r0, r1
	lw	r1, 4(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	veciprod.2891				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fmul	f2, f2, f1
	flw	f1, 14(r3)
	flw	f3, 2(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	add_light.3188				
	addi	r3, r3, -19
	lw	r31, 18(r3)
beq_cont.8684:
beq_cont.8682:
	j	beq_cont.8680
beq_then.8679:
beq_cont.8680:
	lw	r1, 0(r3)
	addi	r1, r1, -1
	flw	f1, 6(r3)
	flw	f2, 2(r3)
	lw	r2, 4(r3)
	j	trace_reflections.3192
trace_ray.3197:
	blei	4, r1, ble_then.8685
	jr	r31				#
ble_then.8685:
	fsw	f2, 0(r3)
	sw	r5, 2(r3)
	fsw	f1, 4(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	add	r1, r0, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	p_surface_ids.2962				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 7(r3)
	sw	r1, 8(r3)
	add	r1, r0, r2
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	judge_intersection.3160				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	beqi	0, r1, beq_then.8688
	lw	r1, 730(r0)
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r1
	lw	r2, 0(r30)
	sw	r1, 9(r3)
	sw	r2, 10(r3)
	add	r1, r0, r2
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	o_reflectiontype.2920				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 10(r3)
	sw	r1, 11(r3)
	add	r1, r0, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	o_diffuse.2940				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	lw	r1, 10(r3)
	lw	r2, 7(r3)
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	get_nvector.3182				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r1, r0, 748				# set min_caml_startp
	addi	r2, r0, 727				# set min_caml_intersection_point
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	veccpy.2880				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r2, r0, 727				# set min_caml_intersection_point
	lw	r1, 10(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	utexture.3185				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 9(r3)
	slli	r1, r1, 2
	lw	r2, 725(r0)
	add	r1, r1, r2
	lw	r2, 6(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 2(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	p_intersection_points.2960				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 6(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	addi	r5, r0, 727				# set min_caml_intersection_point
	add	r2, r0, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	veccpy.2880				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 2(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	p_calc_diffuse.2964				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flup	f1, 1		# fli	f1, 0.500000
	lw	r2, 10(r3)
	sw	r1, 14(r3)
	fsw	f1, 16(r3)
	add	r1, r0, r2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	o_diffuse.2940				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8690
	addi	r1, r0, 1
	lw	r2, 6(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 2(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	p_energy.2966				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 6(r3)
	add	r30, r1, r2
	lw	r5, 0(r30)
	addi	r6, r0, 734				# set min_caml_texture_color
	sw	r1, 18(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	veccpy.2880				
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r1, 6(r3)
	lw	r2, 18(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	flup	f1, 43		# fli	f1, 0.003906
	flw	f2, 12(r3)
	fmul	f1, f1, f2
	add	r1, r0, r2
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	vecscale.2909				
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r1, 2(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	p_nvectors.2975				
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 6(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	addi	r5, r0, 731				# set min_caml_nvector
	add	r2, r0, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	veccpy.2880				
	addi	r3, r3, -20
	lw	r31, 19(r3)
	j	fle_cont.8691
fle_else.8690:
	lw	r1, 6(r3)
	lw	r2, 14(r3)
	add	r30, r2, r1
	sw	r0, 0(r30)
fle_cont.8691:
	flup	f1, 44		# fli	f1, -2.000000
	addi	r2, r0, 731				# set min_caml_nvector
	lw	r1, 7(r3)
	fsw	f1, 20(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	veciprod.2891				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 20(r3)
	fmul	f1, f2, f1
	addi	r2, r0, 731				# set min_caml_nvector
	lw	r1, 7(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	vecaccum.2899				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	lw	r1, 10(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	o_hilight.2942				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	addi	r1, r0, 0
	lw	r2, 723(r0)
	fsw	f1, 22(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	shadow_check_one_or_matrix.3145				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	beqi	0, r1, beq_then.8693
	j	beq_cont.8694
beq_then.8693:
	addi	r1, r0, 731				# set min_caml_nvector
	addi	r2, r0, 667				# set min_caml_light
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	veciprod.2891				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	fneg	f1, f1
	flw	f2, 12(r3)
	fmul	f1, f1, f2
	addi	r2, r0, 667				# set min_caml_light
	lw	r1, 7(r3)
	fsw	f1, 24(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	veciprod.2891				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	fneg	f2, f1
	flw	f1, 24(r3)
	flw	f3, 22(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	add_light.3188				
	addi	r3, r3, -27
	lw	r31, 26(r3)
beq_cont.8694:
	addi	r1, r0, 727				# set min_caml_intersection_point
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_startp.3111				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r1, 1023(r0)
	addi	r1, r1, -1
	flw	f1, 12(r3)
	flw	f2, 22(r3)
	lw	r2, 7(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	trace_reflections.3192				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flup	f1, 45		# fli	f1, 0.100000
	flw	f2, 4(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8695
	jr	r31				#
fle_else.8695:
	lw	r1, 6(r3)
	bgei	4, r1, bge_then.8697
	addi	r2, r1, 1
	addi	r5, r0, -1
	lw	r6, 8(r3)
	add	r30, r6, r2
	sw	r5, 0(r30)
	j	bge_cont.8698
bge_then.8697:
bge_cont.8698:
	lw	r2, 11(r3)
	beqi	2, r2, beq_then.8699
	j	beq_cont.8700
beq_then.8699:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r2, 10(r3)
	fsw	f1, 26(r3)
	add	r1, r0, r2
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	o_diffuse.2940				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	flw	f2, 26(r3)
	fsub	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	lw	r1, 6(r3)
	addi	r1, r1, 1
	flw	f2, 726(r0)
	flw	f3, 0(r3)
	fadd	f2, f3, f2
	lw	r2, 7(r3)
	lw	r5, 2(r3)
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	trace_ray.3197				
	addi	r3, r3, -29
	lw	r31, 28(r3)
beq_cont.8700:
	jr	r31				#
beq_then.8688:
	addi	r1, r0, -1
	lw	r2, 6(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	0, r2, beq_then.8702
	addi	r2, r0, 667				# set min_caml_light
	lw	r1, 7(r3)
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	veciprod.2891				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	fneg	f1, f1
	fsw	f1, 28(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	fispos.2803				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	beqi	0, r1, beq_then.8703
	flw	f1, 28(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	fsqr.2814				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	flw	f2, 28(r3)
	fmul	f1, f1, f2
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	flw	f2, 670(r0)
	fmul	f1, f1, f2
	flw	f2, 740(r0)
	fadd	f2, f2, f1
	fsw	f2, 740(r0)
	flw	f2, 741(r0)
	fadd	f2, f2, f1
	fsw	f2, 741(r0)
	flw	f2, 742(r0)
	fadd	f1, f2, f1
	fsw	f1, 742(r0)
	jr	r31				#
beq_then.8703:
	jr	r31				#
beq_then.8702:
	jr	r31				#
trace_diffuse_ray.3203:
	fsw	f1, 0(r3)
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	judge_intersection_fast.3174				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.8707
	lw	r1, 730(r0)
	addi	r2, r0, 1				# set min_caml_objects
	lw	r5, 723(r0)
	addi	r6, r0, 727				# set min_caml_intersection_point
	addi	r7, r0, 0
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 2(r3)
	sw	r5, 3(r3)
	sw	r7, 4(r3)
	sw	r6, 5(r3)
	sw	r1, 6(r3)
	add	r1, r0, r2
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	d_vec.2977				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r1
	lw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	get_nvector.3182				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 5(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	utexture.3185				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 4(r3)
	lw	r2, 3(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	shadow_check_one_or_matrix.3145				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	0, r1, beq_then.8708
	jr	r31				#
beq_then.8708:
	addi	r1, r0, 731				# set min_caml_nvector
	addi	r2, r0, 667				# set min_caml_light
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	veciprod.2891				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	fneg	f1, f1
	fsw	f1, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	fispos.2803				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.8711
	flw	f1, 8(r3)
	j	beq_cont.8712
beq_then.8711:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.8712:
	flw	f2, 0(r3)
	fmul	f1, f2, f1
	addi	r1, r0, 737				# set min_caml_diffuse_ray
	lw	r2, 6(r3)
	sw	r1, 10(r3)
	fsw	f1, 12(r3)
	add	r1, r0, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	o_diffuse.2940				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r2, r0, 734				# set min_caml_texture_color
	flw	f2, 12(r3)
	fmul	f1, f2, f1
	lw	r1, 10(r3)
	j	vecaccum.2899
beq_then.8707:
	jr	r31				#
iter_trace_diffuse_rays.3206:
	bgei	0, r6, bge_then.8715
	jr	r31				#
bge_then.8715:
	add	r30, r1, r6
	lw	r7, 0(r30)
	sw	r5, 0(r3)
	sw	r6, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	d_vec.2977				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	veciprod.2891				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fsw	f1, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	fisneg.2805				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.8717
	lw	r1, 1(r3)
	addi	r2, r1, 1
	lw	r5, 2(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	flup	f1, 46		# fli	f1, -150.000000
	flw	f2, 4(r3)
	fdiv	f1, f2, f1
	add	r1, r0, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.8718
beq_then.8717:
	lw	r1, 1(r3)
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	flup	f1, 47		# fli	f1, 150.000000
	flw	f2, 4(r3)
	fdiv	f1, f2, f1
	add	r1, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.8718:
	lw	r1, 1(r3)
	addi	r6, r1, -2
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	j	iter_trace_diffuse_rays.3206
trace_diffuse_rays.3211:
	addi	r6, r0, 118
	sw	r6, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	setup_startp.3111				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	lw	r6, 0(r3)
	j	iter_trace_diffuse_rays.3206
trace_diffuse_ray_80percent.3215:
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beqi	0, r1, beq_then.8719
	lw	r6, 766(r0)
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_rays.3211				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.8720
beq_then.8719:
beq_cont.8720:
	lw	r1, 2(r3)
	beqi	1, r1, beq_then.8721
	lw	r2, 767(r0)
	lw	r5, 1(r3)
	lw	r6, 0(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	add	r5, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_rays.3211				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.8722
beq_then.8721:
beq_cont.8722:
	lw	r1, 2(r3)
	beqi	2, r1, beq_then.8723
	lw	r2, 768(r0)
	lw	r5, 1(r3)
	lw	r6, 0(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	add	r5, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_rays.3211				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.8724
beq_then.8723:
beq_cont.8724:
	lw	r1, 2(r3)
	beqi	3, r1, beq_then.8725
	lw	r2, 769(r0)
	lw	r5, 1(r3)
	lw	r6, 0(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	add	r5, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_rays.3211				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.8726
beq_then.8725:
beq_cont.8726:
	lw	r1, 2(r3)
	beqi	4, r1, beq_then.8727
	lw	r1, 770(r0)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_diffuse_rays.3211
beq_then.8727:
	jr	r31				#
calc_diffuse_using_1point.3219:
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	p_received_ray_20percent.2968				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	sw	r1, 2(r3)
	add	r1, r0, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	p_nvectors.2975				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	sw	r1, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	p_intersection_points.2960				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 1(r3)
	sw	r1, 4(r3)
	add	r1, r0, r2
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	p_energy.2966				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r2, r0, 737				# set min_caml_diffuse_ray
	addi	r5, r0, 740				# set min_caml_rgb
	addi	r6, r0, 737				# set min_caml_diffuse_ray
	lw	r7, 0(r3)
	lw	r8, 2(r3)
	add	r30, r8, r7
	lw	r8, 0(r30)
	sw	r6, 5(r3)
	sw	r5, 6(r3)
	sw	r1, 7(r3)
	add	r1, r0, r2
	add	r2, r0, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	veccpy.2880				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	p_group_id.2970				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 0(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 4(r3)
	add	r30, r6, r2
	lw	r6, 0(r30)
	add	r2, r0, r5
	add	r5, r0, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	trace_diffuse_ray_80percent.3215				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 0(r3)
	lw	r2, 7(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r1, 6(r3)
	lw	r5, 5(r3)
	j	vecaccumv.2912
calc_diffuse_using_5points.3222:
	addi	r8, r1, -1
	addi	r9, r1, 1
	add	r30, r2, r1
	lw	r2, 0(r30)
	add	r30, r5, r1
	lw	r10, 0(r30)
	add	r30, r6, r1
	lw	r6, 0(r30)
	add	r30, r5, r1
	lw	r1, 0(r30)
	addi	r11, r0, 737				# set min_caml_diffuse_ray
	addi	r12, r0, 737				# set min_caml_diffuse_ray
	addi	r13, r0, 737				# set min_caml_diffuse_ray
	addi	r14, r0, 737				# set min_caml_diffuse_ray
	addi	r15, r0, 737				# set min_caml_diffuse_ray
	addi	r16, r0, 740				# set min_caml_rgb
	addi	r17, r0, 737				# set min_caml_diffuse_ray
	sw	r17, 0(r3)
	sw	r16, 1(r3)
	sw	r1, 2(r3)
	sw	r15, 3(r3)
	sw	r14, 4(r3)
	sw	r13, 5(r3)
	sw	r12, 6(r3)
	sw	r11, 7(r3)
	sw	r7, 8(r3)
	sw	r6, 9(r3)
	sw	r9, 10(r3)
	sw	r10, 11(r3)
	sw	r8, 12(r3)
	sw	r5, 13(r3)
	add	r1, r0, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	p_received_ray_20percent.2968				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	sw	r1, 14(r3)
	add	r1, r0, r2
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	p_received_ray_20percent.2968				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 11(r3)
	sw	r1, 15(r3)
	add	r1, r0, r2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	p_received_ray_20percent.2968				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r2, 10(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	sw	r1, 16(r3)
	add	r1, r0, r2
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	p_received_ray_20percent.2968				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r2, 9(r3)
	sw	r1, 17(r3)
	add	r1, r0, r2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	p_received_ray_20percent.2968				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 8(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 7(r3)
	sw	r1, 18(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	veccpy.2880				
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r1, 8(r3)
	lw	r2, 15(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 6(r3)
	add	r1, r0, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	vecadd.2903				
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r1, 8(r3)
	lw	r2, 16(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 5(r3)
	add	r1, r0, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	vecadd.2903				
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r1, 8(r3)
	lw	r2, 17(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 4(r3)
	add	r1, r0, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	vecadd.2903				
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r1, 8(r3)
	lw	r2, 18(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 3(r3)
	add	r1, r0, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	vecadd.2903				
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r1, 2(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	p_energy.2966				
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 8(r3)
	add	r30, r1, r2
	lw	r2, 0(r30)
	lw	r1, 1(r3)
	lw	r5, 0(r3)
	j	vecaccumv.2912
do_without_neighbors.3228:
	blei	4, r2, ble_then.8729
	jr	r31				#
ble_then.8729:
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	p_surface_ids.2962				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	bgei	0, r1, bge_then.8731
	jr	r31				#
bge_then.8731:
	lw	r1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	p_calc_diffuse.2964				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	beqi	0, r1, beq_then.8733
	lw	r1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	calc_diffuse_using_1point.3219				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.8734
beq_then.8733:
beq_cont.8734:
	lw	r1, 1(r3)
	addi	r2, r1, 1
	lw	r1, 0(r3)
	j	do_without_neighbors.3228
neighbors_exist.3231:
	lw	r5, 744(r0)
	addi	r6, r2, 1
	ble	r5, r6, ble_then.8735
	blei	0, r2, ble_then.8736
	lw	r2, 743(r0)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.8737
	blei	0, r1, ble_then.8738
	addi	r1, r0, 1
	jr	r31				#
ble_then.8738:
	addi	r1, r0, 0
	jr	r31				#
ble_then.8737:
	addi	r1, r0, 0
	jr	r31				#
ble_then.8736:
	addi	r1, r0, 0
	jr	r31				#
ble_then.8735:
	addi	r1, r0, 0
	jr	r31				#
get_surface_id.3235:
	sw	r2, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	p_surface_ids.2962				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	jr	r31				#
neighbors_are_available.3238:
	add	r30, r5, r1
	lw	r8, 0(r30)
	add	r30, r2, r1
	lw	r2, 0(r30)
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	sw	r2, 4(r3)
	add	r2, r0, r7
	add	r1, r0, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	get_surface_id.3235				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 4(r3)
	lw	r5, 3(r3)
	sw	r1, 5(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	get_surface_id.3235				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 5(r3)
	beq	r1, r2, beq_then.8739
	addi	r1, r0, 0
	jr	r31				#
beq_then.8739:
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r6, 3(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	get_surface_id.3235				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 5(r3)
	beq	r1, r2, beq_then.8740
	addi	r1, r0, 0
	jr	r31				#
beq_then.8740:
	lw	r1, 1(r3)
	addi	r5, r1, -1
	lw	r6, 0(r3)
	add	r30, r6, r5
	lw	r5, 0(r30)
	lw	r7, 3(r3)
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	get_surface_id.3235				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 5(r3)
	beq	r1, r2, beq_then.8741
	addi	r1, r0, 0
	jr	r31				#
beq_then.8741:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r5, 0(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r5, 3(r3)
	add	r2, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	get_surface_id.3235				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 5(r3)
	beq	r1, r2, beq_then.8742
	addi	r1, r0, 0
	jr	r31				#
beq_then.8742:
	addi	r1, r0, 1
	jr	r31				#
try_exploit_neighbors.3244:
	add	r30, r6, r1
	lw	r9, 0(r30)
	blei	4, r8, ble_then.8743
	jr	r31				#
ble_then.8743:
	sw	r2, 0(r3)
	sw	r9, 1(r3)
	sw	r8, 2(r3)
	sw	r7, 3(r3)
	sw	r6, 4(r3)
	sw	r5, 5(r3)
	sw	r1, 6(r3)
	add	r2, r0, r8
	add	r1, r0, r9
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	get_surface_id.3235				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	bgei	0, r1, bge_then.8745
	jr	r31				#
bge_then.8745:
	lw	r1, 6(r3)
	lw	r2, 5(r3)
	lw	r5, 4(r3)
	lw	r6, 3(r3)
	lw	r7, 2(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	neighbors_are_available.3238				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	0, r1, beq_then.8747
	lw	r1, 1(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	p_calc_diffuse.2964				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r7, 2(r3)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beqi	0, r1, beq_then.8748
	lw	r1, 6(r3)
	lw	r2, 5(r3)
	lw	r5, 4(r3)
	lw	r6, 3(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	calc_diffuse_using_5points.3222				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.8749
beq_then.8748:
beq_cont.8749:
	lw	r1, 2(r3)
	addi	r8, r1, 1
	lw	r1, 6(r3)
	lw	r2, 0(r3)
	lw	r5, 5(r3)
	lw	r6, 4(r3)
	lw	r7, 3(r3)
	j	try_exploit_neighbors.3244
beq_then.8747:
	lw	r1, 6(r3)
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 2(r3)
	j	do_without_neighbors.3228
write_ppm_header.3251:
	lw	r1, 743(r0)
	lw	r2, 744(r0)
	addi	r5, r0, 80
	addi	r6, r0, 51
	addi	r7, r0, 10
	addi	r8, r0, 32
	addi	r9, r0, 32
	addi	r10, r0, 255
	addi	r11, r0, 10
	sw	r11, 0(r3)
	sw	r10, 1(r3)
	sw	r9, 2(r3)
	sw	r2, 3(r3)
	sw	r8, 4(r3)
	sw	r1, 5(r3)
	sw	r7, 6(r3)
	sw	r6, 7(r3)
	add	r1, r0, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	print_char.2801				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	print_char.2801				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	print_char.2801				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 5(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	print_int.2857				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	print_char.2801				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 3(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	print_int.2857				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 2(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	print_char.2801				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	print_int.2857				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 0(r3)
	j	print_char.2801
write_rgb_element.3253:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	int_of_float.2818				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r2, r0, 255
	ble	r1, r2, ble_then.8750
	addi	r1, r0, 255
	j	ble_cont.8751
ble_then.8750:
	bgei	0, r1, bge_then.8752
	addi	r1, r0, 0
	j	bge_cont.8753
bge_then.8752:
bge_cont.8753:
ble_cont.8751:
	j	print_int.2857
write_rgb.3255:
	flw	f1, 740(r0)
	flw	f2, 741(r0)
	flw	f3, 742(r0)
	addi	r1, r0, 32
	addi	r2, r0, 32
	addi	r5, r0, 10
	sw	r5, 0(r3)
	fsw	f3, 2(r3)
	sw	r2, 4(r3)
	fsw	f2, 6(r3)
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	write_rgb_element.3253				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	print_char.2801				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	flw	f1, 6(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	write_rgb_element.3253				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 4(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	print_char.2801				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	flw	f1, 2(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	write_rgb_element.3253				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 0(r3)
	j	print_char.2801
pretrace_diffuse_rays.3257:
	blei	4, r2, ble_then.8756
	jr	r31				#
ble_then.8756:
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	get_surface_id.3235				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	bgei	0, r1, bge_then.8758
	jr	r31				#
bge_then.8758:
	lw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	p_calc_diffuse.2964				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 0(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	beqi	0, r1, beq_then.8760
	lw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	p_group_id.2970				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r2, r0, 737				# set min_caml_diffuse_ray
	sw	r1, 2(r3)
	add	r1, r0, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	vecbzero.2878				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 1(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	p_nvectors.2975				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	sw	r1, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	p_intersection_points.2960				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r2, r0, 766				# set min_caml_dirvecs
	lw	r5, 2(r3)
	add	r30, r2, r5
	lw	r2, 0(r30)
	lw	r5, 0(r3)
	lw	r6, 3(r3)
	add	r30, r6, r5
	lw	r6, 0(r30)
	add	r30, r1, r5
	lw	r1, 0(r30)
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_diffuse_rays.3211				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 1(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	p_received_ray_20percent.2968				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 0(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	addi	r5, r0, 737				# set min_caml_diffuse_ray
	add	r2, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	veccpy.2880				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.8761
beq_then.8760:
beq_cont.8761:
	lw	r1, 0(r3)
	addi	r2, r1, 1
	lw	r1, 1(r3)
	j	pretrace_diffuse_rays.3257
pretrace_pixels.3260:
	bgei	0, r2, bge_then.8762
	jr	r31				#
bge_then.8762:
	flw	f4, 747(r0)
	lw	r6, 745(r0)
	sub	r6, r2, r6
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	fsw	f3, 4(r3)
	fsw	f2, 6(r3)
	fsw	f1, 8(r3)
	fsw	f4, 10(r3)
	add	r1, r0, r6
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	float_of_int.2820				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fmul	f1, f2, f1
	flw	f2, 754(r0)
	fmul	f2, f1, f2
	flw	f3, 8(r3)
	fadd	f2, f2, f3
	fsw	f2, 763(r0)
	flw	f2, 755(r0)
	fmul	f2, f1, f2
	flw	f4, 6(r3)
	fadd	f2, f2, f4
	fsw	f2, 764(r0)
	flw	f2, 756(r0)
	fmul	f1, f1, f2
	flw	f2, 4(r3)
	fadd	f1, f1, f2
	fsw	f1, 765(r0)
	addi	r1, r0, 763				# set min_caml_ptrace_dirvec
	addi	r2, r0, 0
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	vecunit_sgn.2888				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r1, r0, 740				# set min_caml_rgb
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	vecbzero.2878				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r1, r0, 748				# set min_caml_startp
	addi	r2, r0, 664				# set min_caml_viewpoint
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	veccpy.2880				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r1, r0, 0
	flup	f1, 2		# fli	f1, 1.000000
	addi	r2, r0, 763				# set min_caml_ptrace_dirvec
	lw	r5, 1(r3)
	lw	r6, 2(r3)
	add	r30, r6, r5
	lw	r7, 0(r30)
	flup	f2, 0		# fli	f2, 0.000000
	add	r5, r0, r7
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	trace_ray.3197				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 1(r3)
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	add	r1, r0, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	p_rgb.2958				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r2, r0, 740				# set min_caml_rgb
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	veccpy.2880				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 1(r3)
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	p_set_group_id.2972				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 1(r3)
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 0
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	pretrace_diffuse_rays.3257				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 1(r3)
	addi	r1, r1, -1
	addi	r2, r0, 1
	lw	r5, 0(r3)
	sw	r1, 12(r3)
	add	r1, r0, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	add_mod5.2867				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r5, r0, r1
	flw	f1, 8(r3)
	flw	f2, 6(r3)
	flw	f3, 4(r3)
	lw	r1, 2(r3)
	lw	r2, 12(r3)
	j	pretrace_pixels.3260
pretrace_line.3267:
	lw	r6, 746(r0)
	flw	f1, 747(r0)
	flw	f2, 757(r0)
	flw	f3, 758(r0)
	flw	f4, 759(r0)
	flw	f5, 760(r0)
	flw	f6, 761(r0)
	flw	f7, 762(r0)
	lw	r7, 743(r0)
	sub	r2, r2, r6
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	sw	r7, 2(r3)
	fsw	f7, 4(r3)
	fsw	f4, 6(r3)
	fsw	f6, 8(r3)
	fsw	f3, 10(r3)
	fsw	f5, 12(r3)
	fsw	f2, 14(r3)
	fsw	f1, 16(r3)
	add	r1, r0, r2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	float_of_int.2820				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fmul	f1, f2, f1
	flw	f2, 14(r3)
	fmul	f2, f1, f2
	flw	f3, 12(r3)
	fadd	f2, f2, f3
	flw	f3, 10(r3)
	fmul	f3, f1, f3
	flw	f4, 8(r3)
	fadd	f3, f3, f4
	flw	f4, 6(r3)
	fmul	f1, f1, f4
	flw	f4, 4(r3)
	fadd	f1, f1, f4
	lw	r1, 2(r3)
	addi	r2, r1, -1
	lw	r1, 1(r3)
	lw	r5, 0(r3)
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f2
	fadd	f2, f0, f30
	j	pretrace_pixels.3260
scan_pixel.3271:
	lw	r8, 743(r0)
	ble	r8, r1, ble_then.8766
	add	r30, r6, r1
	lw	r8, 0(r30)
	addi	r9, r0, 740				# set min_caml_rgb
	sw	r5, 0(r3)
	sw	r6, 1(r3)
	sw	r7, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	sw	r9, 5(r3)
	add	r1, r0, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	p_rgb.2958				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1
	lw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	veccpy.2880				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 4(r3)
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	neighbors_exist.3231				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.8767
	addi	r8, r0, 0
	lw	r1, 4(r3)
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	lw	r6, 1(r3)
	lw	r7, 2(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	try_exploit_neighbors.3244				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.8768
beq_then.8767:
	lw	r1, 4(r3)
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 0
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	do_without_neighbors.3228				
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.8768:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	write_rgb.3255				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	lw	r6, 1(r3)
	lw	r7, 2(r3)
	j	scan_pixel.3271
ble_then.8766:
	jr	r31				#
scan_line.3277:
	lw	r8, 744(r0)
	ble	r8, r1, ble_then.8770
	lw	r8, 744(r0)
	addi	r8, r8, -1
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	ble	r8, r1, ble_then.8771
	addi	r8, r1, 1
	add	r5, r0, r7
	add	r2, r0, r8
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	pretrace_line.3267				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	ble_cont.8772
ble_then.8771:
ble_cont.8772:
	addi	r1, r0, 0
	addi	r2, r0, 2
	lw	r5, 4(r3)
	addi	r6, r5, 1
	lw	r7, 3(r3)
	lw	r8, 2(r3)
	lw	r9, 1(r3)
	sw	r6, 5(r3)
	sw	r2, 6(r3)
	add	r6, r0, r8
	add	r2, r0, r5
	add	r5, r0, r7
	add	r7, r0, r9
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	scan_pixel.3271				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 0(r3)
	lw	r2, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	add_mod5.2867				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r7, r0, r1
	lw	r1, 5(r3)
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	lw	r6, 3(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	scan_line.3277				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	jr	r31				#
ble_then.8770:
	jr	r31				#
create_float5x3array.3283:
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	addi	r2, r0, 5
	addi	r5, r0, 3
	flup	f2, 0		# fli	f2, 0.000000
	addi	r6, r0, 3
	flup	f3, 0		# fli	f3, 0.000000
	addi	r7, r0, 3
	flup	f4, 0		# fli	f4, 0.000000
	addi	r8, r0, 3
	flup	f5, 0		# fli	f5, 0.000000
	fsw	f5, 0(r3)
	sw	r8, 2(r3)
	fsw	f4, 4(r3)
	sw	r7, 6(r3)
	fsw	f3, 8(r3)
	sw	r6, 10(r3)
	fsw	f2, 12(r3)
	sw	r5, 14(r3)
	sw	r2, 15(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_float_array				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	add	r2, r0, r1
	lw	r1, 15(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f1, 12(r3)
	lw	r2, 14(r3)
	sw	r1, 16(r3)
	add	r1, r0, r2
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_float_array				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r2, 16(r3)
	sw	r1, 1(r2)
	flw	f1, 8(r3)
	lw	r1, 10(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_float_array				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r2, 16(r3)
	sw	r1, 2(r2)
	flw	f1, 4(r3)
	lw	r1, 6(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_float_array				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r2, 16(r3)
	sw	r1, 3(r2)
	flw	f1, 0(r3)
	lw	r1, 2(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_float_array				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r2, 16(r3)
	sw	r1, 4(r2)
	add	r1, r0, r2
	jr	r31				#
create_pixel.3285:
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	addi	r2, r0, 5
	addi	r5, r0, 0
	addi	r6, r0, 5
	addi	r7, r0, 0
	addi	r8, r0, 1
	addi	r9, r0, 0
	add	r10, r0, r4
	sw	r10, 0(r3)
	sw	r9, 1(r3)
	sw	r8, 2(r3)
	sw	r7, 3(r3)
	sw	r6, 4(r3)
	sw	r5, 5(r3)
	sw	r2, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	sw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	create_float5x3array.3283				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 5(r3)
	sw	r1, 8(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 4(r3)
	lw	r5, 3(r3)
	sw	r1, 9(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_float5x3array.3283				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	sw	r1, 11(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	create_float5x3array.3283				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	sw	r1, 12(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	sw	r1, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	create_float5x3array.3283				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r4, r4, 8
	lw	r2, 0(r3)
	sw	r1, 7(r2)
	lw	r1, 13(r3)
	sw	r1, 6(r2)
	lw	r1, 12(r3)
	sw	r1, 5(r2)
	lw	r1, 11(r3)
	sw	r1, 4(r2)
	lw	r1, 10(r3)
	sw	r1, 3(r2)
	lw	r1, 9(r3)
	sw	r1, 2(r2)
	lw	r1, 8(r3)
	sw	r1, 1(r2)
	lw	r1, 7(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	jr	r31				#
init_line_elements.3287:
	bgei	0, r2, bge_then.8778
	jr	r31				#
bge_then.8778:
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	create_pixel.3285				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	add	r1, r0, r5
	j	init_line_elements.3287
create_pixelline.3290:
	lw	r1, 743(r0)
	lw	r2, 743(r0)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	create_pixel.3285				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 0(r3)
	addi	r2, r2, -2
	j	init_line_elements.3287
tan.3292:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	sin.2837				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f2, 0(r3)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	cos.2839				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fdiv	f1, f2, f1
	jr	r31				#
adjust_position.3294:
	fmul	f1, f1, f1
	flup	f3, 45		# fli	f3, 0.100000
	flup	f4, 2		# fli	f4, 1.000000
	fadd	f1, f1, f3
	fsqrt	f1, f1
	fdiv	f3, f4, f1
	fsw	f1, 0(r3)
	fsw	f2, 2(r3)
	fadd	f1, f0, f3
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan.2843				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fmul	f1, f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	tan.3292				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
calc_dirvec.3297:
	bgei	5, r1, bge_then.8779
	fsw	f3, 0(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	fsw	f4, 4(r3)
	sw	r1, 6(r3)
	fadd	f1, f0, f2
	fadd	f2, f0, f3
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	adjust_position.3294				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	addi	r1, r1, 1
	flw	f2, 4(r3)
	fsw	f1, 8(r3)
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	adjust_position.3294				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	fadd	f2, f0, f1
	flw	f1, 8(r3)
	flw	f3, 0(r3)
	flw	f4, 4(r3)
	lw	r1, 10(r3)
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	j	calc_dirvec.3297
bge_then.8779:
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	fsw	f1, 12(r3)
	fsw	f2, 14(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	fsqr.2814				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fsw	f1, 16(r3)
	fadd	f1, f0, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	fsqr.2814				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fadd	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	fadd	f1, f1, f2
	fsqrt	f1, f1
	flw	f2, 12(r3)
	fdiv	f2, f2, f1
	flw	f3, 14(r3)
	fdiv	f3, f3, f1
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	addi	r1, r0, 766				# set min_caml_dirvecs
	lw	r2, 3(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r2, 2(r3)
	add	r30, r1, r2
	lw	r5, 0(r30)
	sw	r1, 18(r3)
	fsw	f1, 20(r3)
	fsw	f3, 22(r3)
	fsw	f2, 24(r3)
	add	r1, r0, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	d_vec.2977				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f1, 24(r3)
	flw	f2, 22(r3)
	flw	f3, 20(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	vecset.2870				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r1, 2(r3)
	addi	r2, r1, 40
	lw	r5, 18(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	add	r1, r0, r2
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	d_vec.2977				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f1, 22(r3)
	fneg	f3, f1
	flw	f2, 24(r3)
	flw	f4, 20(r3)
	fsw	f3, 26(r3)
	fadd	f1, f0, f2
	fadd	f2, f0, f4
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	vecset.2870				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	lw	r1, 2(r3)
	addi	r2, r1, 80
	lw	r5, 18(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	add	r1, r0, r2
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	d_vec.2977				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	flw	f1, 24(r3)
	fneg	f2, f1
	flw	f3, 20(r3)
	flw	f4, 26(r3)
	fsw	f2, 28(r3)
	fadd	f1, f0, f3
	fadd	f3, f0, f4
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	vecset.2870				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	lw	r1, 2(r3)
	addi	r2, r1, 1
	lw	r5, 18(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	add	r1, r0, r2
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	d_vec.2977				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	flw	f1, 20(r3)
	fneg	f3, f1
	flw	f1, 28(r3)
	flw	f2, 26(r3)
	fsw	f3, 30(r3)
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	vecset.2870				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	lw	r1, 2(r3)
	addi	r2, r1, 41
	lw	r5, 18(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	add	r1, r0, r2
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	d_vec.2977				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	flw	f1, 28(r3)
	flw	f2, 30(r3)
	flw	f3, 22(r3)
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	vecset.2870				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	lw	r1, 2(r3)
	addi	r1, r1, 81
	lw	r2, 18(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	d_vec.2977				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	flw	f1, 30(r3)
	flw	f2, 24(r3)
	flw	f3, 22(r3)
	j	vecset.2870
calc_dirvecs.3305:
	bgei	0, r1, bge_then.8783
	jr	r31				#
bge_then.8783:
	sw	r1, 0(r3)
	fsw	f1, 2(r3)
	sw	r5, 4(r3)
	sw	r2, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	float_of_int.2820				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f3, f1, f2
	addi	r1, r0, 0
	flup	f1, 0		# fli	f1, 0.000000
	flup	f2, 0		# fli	f2, 0.000000
	flw	f4, 2(r3)
	lw	r2, 5(r3)
	lw	r5, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_dirvec.3297				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 0(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	float_of_int.2820				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f3, f1, f2
	addi	r1, r0, 0
	flup	f1, 0		# fli	f1, 0.000000
	flup	f2, 0		# fli	f2, 0.000000
	lw	r2, 4(r3)
	addi	r5, r2, 2
	flw	f4, 2(r3)
	lw	r6, 5(r3)
	add	r2, r0, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_dirvec.3297				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	addi	r2, r0, 1
	lw	r5, 5(r3)
	sw	r1, 6(r3)
	add	r1, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	add_mod5.2867				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r1
	flw	f1, 2(r3)
	lw	r1, 6(r3)
	lw	r5, 4(r3)
	j	calc_dirvecs.3305
calc_dirvec_rows.3310:
	bgei	0, r1, bge_then.8786
	jr	r31				#
bge_then.8786:
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	float_of_int.2820				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f1, f1, f2
	addi	r1, r0, 4
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	calc_dirvecs.3305				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	addi	r2, r0, 2
	lw	r5, 2(r3)
	sw	r1, 3(r3)
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	add_mod5.2867				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	addi	r5, r1, 4
	lw	r1, 3(r3)
	j	calc_dirvec_rows.3310
create_dirvec.3314:
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	lw	r2, 0(r0)
	add	r5, r0, r4
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r4, r4, 2
	lw	r2, 0(r3)
	sw	r1, 1(r2)
	lw	r1, 2(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	jr	r31				#
create_dirvec_elements.3316:
	bgei	0, r2, bge_then.8788
	jr	r31				#
bge_then.8788:
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	create_dirvec.3314				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	add	r1, r0, r5
	j	create_dirvec_elements.3316
create_dirvecs.3319:
	bgei	0, r1, bge_then.8790
	jr	r31				#
bge_then.8790:
	addi	r2, r0, 766				# set min_caml_dirvecs
	addi	r5, r0, 120
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	create_dirvec.3314				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 766				# set min_caml_dirvecs
	add	r30, r1, r2
	lw	r1, 0(r30)
	addi	r5, r0, 118
	add	r2, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	create_dirvec_elements.3316				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	j	create_dirvecs.3319
init_dirvec_constants.3321:
	bgei	0, r2, bge_then.8792
	jr	r31				#
bge_then.8792:
	add	r30, r1, r2
	lw	r5, 0(r30)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	setup_dirvec_constants.3106				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	j	init_dirvec_constants.3321
init_vecset_constants.3324:
	bgei	0, r1, bge_then.8794
	jr	r31				#
bge_then.8794:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r2, 0(r30)
	addi	r5, r0, 119
	sw	r1, 0(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	j	init_vecset_constants.3324
init_dirvecs.3326:
	addi	r1, r0, 4
	addi	r2, r0, 9
	addi	r5, r0, 0
	addi	r6, r0, 0
	addi	r7, r0, 4
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	create_dirvecs.3319				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	calc_dirvec_rows.3310				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 0(r3)
	j	init_vecset_constants.3324
add_reflection.3328:
	add	r5, r0, r4
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r5, 2(r3)
	fsw	f1, 4(r3)
	fsw	f4, 6(r3)
	fsw	f3, 8(r3)
	fsw	f2, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	create_dirvec.3314				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r2, r0, 778				# set min_caml_reflections
	sw	r2, 12(r3)
	sw	r1, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	d_vec.2977				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f1, 10(r3)
	flw	f2, 8(r3)
	flw	f3, 6(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	vecset.2870				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_dirvec_constants.3106				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r4, r4, 3
	lw	r1, 2(r3)
	flw	f1, 4(r3)
	fsw	f1, 2(r1)
	lw	r2, 13(r3)
	sw	r2, 1(r1)
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	lw	r2, 0(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	jr	r31				#
setup_rect_reflection.3335:
	slli	r1, r1, 2
	lw	r5, 1023(r0)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 667(r0)
	flw	f3, 668(r0)
	flw	f4, 669(r0)
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	fsw	f4, 2(r3)
	fsw	f3, 4(r3)
	fsw	f2, 6(r3)
	fsw	f1, 8(r3)
	add	r1, r0, r2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	o_diffuse.2940				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 667(r0)
	flw	f3, 668(r0)
	flw	f4, 669(r0)
	flw	f5, 8(r3)
	fsub	f1, f5, f1
	flw	f5, 6(r3)
	fneg	f5, f5
	flw	f6, 4(r3)
	fneg	f6, f6
	flw	f7, 2(r3)
	fneg	f7, f7
	lw	r1, 1(r3)
	addi	r2, r1, 1
	lw	r5, 0(r3)
	fsw	f4, 10(r3)
	fsw	f6, 12(r3)
	fsw	f7, 14(r3)
	fsw	f3, 16(r3)
	fsw	f5, 18(r3)
	fsw	f1, 20(r3)
	add	r1, r0, r5
	fadd	f4, f0, f7
	fadd	f3, f0, f6
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	add_reflection.3328				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	lw	r1, 0(r3)
	addi	r2, r1, 1
	lw	r5, 1(r3)
	addi	r6, r5, 2
	flw	f1, 20(r3)
	flw	f2, 18(r3)
	flw	f3, 16(r3)
	flw	f4, 14(r3)
	add	r1, r0, r2
	add	r2, r0, r6
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	add_reflection.3328				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	lw	r1, 0(r3)
	addi	r2, r1, 2
	lw	r5, 1(r3)
	addi	r5, r5, 3
	flw	f1, 20(r3)
	flw	f2, 18(r3)
	flw	f3, 12(r3)
	flw	f4, 10(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	add_reflection.3328				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	lw	r1, 0(r3)
	addi	r1, r1, 3
	sw	r1, 1023(r0)
	jr	r31				#
setup_surface_reflection.3338:
	slli	r1, r1, 2
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 1023(r0)
	addi	r6, r0, 667				# set min_caml_light
	flup	f2, 3		# fli	f2, 2.000000
	flw	f3, 667(r0)
	flup	f4, 3		# fli	f4, 2.000000
	flw	f5, 668(r0)
	flup	f6, 3		# fli	f6, 2.000000
	flw	f7, 669(r0)
	addi	r1, r1, 1
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	fsw	f7, 2(r3)
	fsw	f6, 4(r3)
	fsw	f5, 6(r3)
	fsw	f4, 8(r3)
	fsw	f3, 10(r3)
	fsw	f2, 12(r3)
	sw	r6, 14(r3)
	sw	r2, 15(r3)
	fsw	f1, 16(r3)
	add	r1, r0, r2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	o_diffuse.2940				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fsub	f1, f2, f1
	lw	r1, 15(r3)
	fsw	f1, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	o_param_abc.2932				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	add	r2, r0, r1
	lw	r1, 14(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	veciprod.2891				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	lw	r1, 15(r3)
	fsw	f1, 20(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	o_param_a.2926				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 12(r3)
	fmul	f1, f2, f1
	flw	f2, 20(r3)
	fmul	f1, f1, f2
	flw	f3, 10(r3)
	fsub	f1, f1, f3
	lw	r1, 15(r3)
	fsw	f1, 22(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	o_param_b.2928				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 8(r3)
	fmul	f1, f2, f1
	flw	f2, 20(r3)
	fmul	f1, f1, f2
	flw	f3, 6(r3)
	fsub	f1, f1, f3
	lw	r1, 15(r3)
	fsw	f1, 24(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	o_param_c.2930				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	flw	f2, 20(r3)
	fmul	f1, f1, f2
	flw	f2, 2(r3)
	fsub	f4, f1, f2
	flw	f1, 18(r3)
	flw	f2, 22(r3)
	flw	f3, 24(r3)
	lw	r1, 1(r3)
	lw	r2, 0(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	add_reflection.3328				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r1, 1(r3)
	addi	r1, r1, 1
	sw	r1, 1023(r0)
	jr	r31				#
setup_reflections.3341:
	bgei	0, r1, bge_then.8800
	jr	r31				#
bge_then.8800:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r1
	lw	r2, 0(r30)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	add	r1, r0, r2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	o_reflectiontype.2920				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	2, r1, beq_then.8802
	jr	r31				#
beq_then.8802:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r1, 1(r3)
	fsw	f1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	o_diffuse.2940				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.8804
	jr	r31				#
fle_else.8804:
	lw	r1, 1(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	o_form.2918				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	1, r1, beq_then.8806
	beqi	2, r1, beq_then.8807
	jr	r31				#
beq_then.8807:
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	j	setup_surface_reflection.3338
beq_then.8806:
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	j	setup_rect_reflection.3335
rt.3343:
	srai	r5, r1, 1
	srai	r6, r2, 1
	flup	f1, 49		# fli	f1, 128.000000
	sw	r1, 743(r0)
	sw	r2, 744(r0)
	lw	r2, 0(r0)
	addi	r7, r0, 1021				# set min_caml_light_dirvec
	addi	r8, r0, 667				# set min_caml_light
	addi	r9, r0, 1021				# set min_caml_light_dirvec
	addi	r10, r0, 0
	addi	r11, r0, 0
	addi	r12, r0, 0
	addi	r13, r0, 2
	sw	r5, 745(r0)
	sw	r6, 746(r0)
	sw	r13, 0(r3)
	sw	r12, 1(r3)
	sw	r11, 2(r3)
	sw	r10, 3(r3)
	sw	r2, 4(r3)
	sw	r9, 5(r3)
	sw	r8, 6(r3)
	sw	r7, 7(r3)
	fsw	f1, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	float_of_int.2820				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fdiv	f1, f2, f1
	fsw	f1, 747(r0)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	create_pixelline.3290				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_pixelline.3290				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	sw	r1, 11(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	create_pixelline.3290				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	sw	r1, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	read_parameter.3008				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	write_ppm_header.3251				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	init_dirvecs.3326				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 7(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	d_vec.2977				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 6(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	veccpy.2880				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 5(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_dirvec_constants.3106				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 4(r3)
	addi	r1, r1, -1
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_reflections.3341				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 11(r3)
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	pretrace_line.3267				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 1(r3)
	lw	r2, 10(r3)
	lw	r5, 11(r3)
	lw	r6, 12(r3)
	lw	r7, 0(r3)
	j	scan_line.3277
_R_0:
_min_caml_start: # main entry point
  addi  r3, r0, 32500
  slli   r3, r3, 2
  addi  r4, r0, 0
# n_objects
  sw  r0, 0(r4)
# objects
  sw  r0, 1(r4)
  sw  r0, 2(r4)
  sw  r0, 3(r4)
  sw  r0, 4(r4)
  sw  r0, 5(r4) # dummy
  sw  r0, 6(r4) # dummy
  sw  r0, 7(r4) # false
  sw  r0, 8(r4) # dummy
  sw  r0, 9(r4) # dummy
  sw  r0, 10(r4) # dummy
  sw  r0, 11(r4) # dummy
  sw  r0, 12(r4)
  sw  r0, 13(r4)
  sw  r0, 14(r4)
  sw  r0, 15(r4)
  sw  r0, 16(r4) # dummy
  sw  r0, 17(r4) # dummy
  sw  r0, 18(r4) # false
  sw  r0, 19(r4) # dummy
  sw  r0, 20(r4) # dummy
  sw  r0, 21(r4) # dummy
  sw  r0, 22(r4) # dummy
  sw  r0, 23(r4)
  sw  r0, 24(r4)
  sw  r0, 25(r4)
  sw  r0, 26(r4)
  sw  r0, 27(r4) # dummy
  sw  r0, 28(r4) # dummy
  sw  r0, 29(r4) # false
  sw  r0, 30(r4) # dummy
  sw  r0, 31(r4) # dummy
  sw  r0, 32(r4) # dummy
  sw  r0, 33(r4) # dummy
  sw  r0, 34(r4)
  sw  r0, 35(r4)
  sw  r0, 36(r4)
  sw  r0, 37(r4)
  sw  r0, 38(r4) # dummy
  sw  r0, 39(r4) # dummy
  sw  r0, 40(r4) # false
  sw  r0, 41(r4) # dummy
  sw  r0, 42(r4) # dummy
  sw  r0, 43(r4) # dummy
  sw  r0, 44(r4) # dummy
  sw  r0, 45(r4)
  sw  r0, 46(r4)
  sw  r0, 47(r4)
  sw  r0, 48(r4)
  sw  r0, 49(r4) # dummy
  sw  r0, 50(r4) # dummy
  sw  r0, 51(r4) # false
  sw  r0, 52(r4) # dummy
  sw  r0, 53(r4) # dummy
  sw  r0, 54(r4) # dummy
  sw  r0, 55(r4) # dummy
  sw  r0, 56(r4)
  sw  r0, 57(r4)
  sw  r0, 58(r4)
  sw  r0, 59(r4)
  sw  r0, 60(r4) # dummy
  sw  r0, 61(r4) # dummy
  sw  r0, 62(r4) # false
  sw  r0, 63(r4) # dummy
  sw  r0, 64(r4) # dummy
  sw  r0, 65(r4) # dummy
  sw  r0, 66(r4) # dummy
  sw  r0, 67(r4)
  sw  r0, 68(r4)
  sw  r0, 69(r4)
  sw  r0, 70(r4)
  sw  r0, 71(r4) # dummy
  sw  r0, 72(r4) # dummy
  sw  r0, 73(r4) # false
  sw  r0, 74(r4) # dummy
  sw  r0, 75(r4) # dummy
  sw  r0, 76(r4) # dummy
  sw  r0, 77(r4) # dummy
  sw  r0, 78(r4)
  sw  r0, 79(r4)
  sw  r0, 80(r4)
  sw  r0, 81(r4)
  sw  r0, 82(r4) # dummy
  sw  r0, 83(r4) # dummy
  sw  r0, 84(r4) # false
  sw  r0, 85(r4) # dummy
  sw  r0, 86(r4) # dummy
  sw  r0, 87(r4) # dummy
  sw  r0, 88(r4) # dummy
  sw  r0, 89(r4)
  sw  r0, 90(r4)
  sw  r0, 91(r4)
  sw  r0, 92(r4)
  sw  r0, 93(r4) # dummy
  sw  r0, 94(r4) # dummy
  sw  r0, 95(r4) # false
  sw  r0, 96(r4) # dummy
  sw  r0, 97(r4) # dummy
  sw  r0, 98(r4) # dummy
  sw  r0, 99(r4) # dummy
  sw  r0, 100(r4)
  sw  r0, 101(r4)
  sw  r0, 102(r4)
  sw  r0, 103(r4)
  sw  r0, 104(r4) # dummy
  sw  r0, 105(r4) # dummy
  sw  r0, 106(r4) # false
  sw  r0, 107(r4) # dummy
  sw  r0, 108(r4) # dummy
  sw  r0, 109(r4) # dummy
  sw  r0, 110(r4) # dummy
  sw  r0, 111(r4)
  sw  r0, 112(r4)
  sw  r0, 113(r4)
  sw  r0, 114(r4)
  sw  r0, 115(r4) # dummy
  sw  r0, 116(r4) # dummy
  sw  r0, 117(r4) # false
  sw  r0, 118(r4) # dummy
  sw  r0, 119(r4) # dummy
  sw  r0, 120(r4) # dummy
  sw  r0, 121(r4) # dummy
  sw  r0, 122(r4)
  sw  r0, 123(r4)
  sw  r0, 124(r4)
  sw  r0, 125(r4)
  sw  r0, 126(r4) # dummy
  sw  r0, 127(r4) # dummy
  sw  r0, 128(r4) # false
  sw  r0, 129(r4) # dummy
  sw  r0, 130(r4) # dummy
  sw  r0, 131(r4) # dummy
  sw  r0, 132(r4) # dummy
  sw  r0, 133(r4)
  sw  r0, 134(r4)
  sw  r0, 135(r4)
  sw  r0, 136(r4)
  sw  r0, 137(r4) # dummy
  sw  r0, 138(r4) # dummy
  sw  r0, 139(r4) # false
  sw  r0, 140(r4) # dummy
  sw  r0, 141(r4) # dummy
  sw  r0, 142(r4) # dummy
  sw  r0, 143(r4) # dummy
  sw  r0, 144(r4)
  sw  r0, 145(r4)
  sw  r0, 146(r4)
  sw  r0, 147(r4)
  sw  r0, 148(r4) # dummy
  sw  r0, 149(r4) # dummy
  sw  r0, 150(r4) # false
  sw  r0, 151(r4) # dummy
  sw  r0, 152(r4) # dummy
  sw  r0, 153(r4) # dummy
  sw  r0, 154(r4) # dummy
  sw  r0, 155(r4)
  sw  r0, 156(r4)
  sw  r0, 157(r4)
  sw  r0, 158(r4)
  sw  r0, 159(r4) # dummy
  sw  r0, 160(r4) # dummy
  sw  r0, 161(r4) # false
  sw  r0, 162(r4) # dummy
  sw  r0, 163(r4) # dummy
  sw  r0, 164(r4) # dummy
  sw  r0, 165(r4) # dummy
  sw  r0, 166(r4)
  sw  r0, 167(r4)
  sw  r0, 168(r4)
  sw  r0, 169(r4)
  sw  r0, 170(r4) # dummy
  sw  r0, 171(r4) # dummy
  sw  r0, 172(r4) # false
  sw  r0, 173(r4) # dummy
  sw  r0, 174(r4) # dummy
  sw  r0, 175(r4) # dummy
  sw  r0, 176(r4) # dummy
  sw  r0, 177(r4)
  sw  r0, 178(r4)
  sw  r0, 179(r4)
  sw  r0, 180(r4)
  sw  r0, 181(r4) # dummy
  sw  r0, 182(r4) # dummy
  sw  r0, 183(r4) # false
  sw  r0, 184(r4) # dummy
  sw  r0, 185(r4) # dummy
  sw  r0, 186(r4) # dummy
  sw  r0, 187(r4) # dummy
  sw  r0, 188(r4)
  sw  r0, 189(r4)
  sw  r0, 190(r4)
  sw  r0, 191(r4)
  sw  r0, 192(r4) # dummy
  sw  r0, 193(r4) # dummy
  sw  r0, 194(r4) # false
  sw  r0, 195(r4) # dummy
  sw  r0, 196(r4) # dummy
  sw  r0, 197(r4) # dummy
  sw  r0, 198(r4) # dummy
  sw  r0, 199(r4)
  sw  r0, 200(r4)
  sw  r0, 201(r4)
  sw  r0, 202(r4)
  sw  r0, 203(r4) # dummy
  sw  r0, 204(r4) # dummy
  sw  r0, 205(r4) # false
  sw  r0, 206(r4) # dummy
  sw  r0, 207(r4) # dummy
  sw  r0, 208(r4) # dummy
  sw  r0, 209(r4) # dummy
  sw  r0, 210(r4)
  sw  r0, 211(r4)
  sw  r0, 212(r4)
  sw  r0, 213(r4)
  sw  r0, 214(r4) # dummy
  sw  r0, 215(r4) # dummy
  sw  r0, 216(r4) # false
  sw  r0, 217(r4) # dummy
  sw  r0, 218(r4) # dummy
  sw  r0, 219(r4) # dummy
  sw  r0, 220(r4) # dummy
  sw  r0, 221(r4)
  sw  r0, 222(r4)
  sw  r0, 223(r4)
  sw  r0, 224(r4)
  sw  r0, 225(r4) # dummy
  sw  r0, 226(r4) # dummy
  sw  r0, 227(r4) # false
  sw  r0, 228(r4) # dummy
  sw  r0, 229(r4) # dummy
  sw  r0, 230(r4) # dummy
  sw  r0, 231(r4) # dummy
  sw  r0, 232(r4)
  sw  r0, 233(r4)
  sw  r0, 234(r4)
  sw  r0, 235(r4)
  sw  r0, 236(r4) # dummy
  sw  r0, 237(r4) # dummy
  sw  r0, 238(r4) # false
  sw  r0, 239(r4) # dummy
  sw  r0, 240(r4) # dummy
  sw  r0, 241(r4) # dummy
  sw  r0, 242(r4) # dummy
  sw  r0, 243(r4)
  sw  r0, 244(r4)
  sw  r0, 245(r4)
  sw  r0, 246(r4)
  sw  r0, 247(r4) # dummy
  sw  r0, 248(r4) # dummy
  sw  r0, 249(r4) # false
  sw  r0, 250(r4) # dummy
  sw  r0, 251(r4) # dummy
  sw  r0, 252(r4) # dummy
  sw  r0, 253(r4) # dummy
  sw  r0, 254(r4)
  sw  r0, 255(r4)
  sw  r0, 256(r4)
  sw  r0, 257(r4)
  sw  r0, 258(r4) # dummy
  sw  r0, 259(r4) # dummy
  sw  r0, 260(r4) # false
  sw  r0, 261(r4) # dummy
  sw  r0, 262(r4) # dummy
  sw  r0, 263(r4) # dummy
  sw  r0, 264(r4) # dummy
  sw  r0, 265(r4)
  sw  r0, 266(r4)
  sw  r0, 267(r4)
  sw  r0, 268(r4)
  sw  r0, 269(r4) # dummy
  sw  r0, 270(r4) # dummy
  sw  r0, 271(r4) # false
  sw  r0, 272(r4) # dummy
  sw  r0, 273(r4) # dummy
  sw  r0, 274(r4) # dummy
  sw  r0, 275(r4) # dummy
  sw  r0, 276(r4)
  sw  r0, 277(r4)
  sw  r0, 278(r4)
  sw  r0, 279(r4)
  sw  r0, 280(r4) # dummy
  sw  r0, 281(r4) # dummy
  sw  r0, 282(r4) # false
  sw  r0, 283(r4) # dummy
  sw  r0, 284(r4) # dummy
  sw  r0, 285(r4) # dummy
  sw  r0, 286(r4) # dummy
  sw  r0, 287(r4)
  sw  r0, 288(r4)
  sw  r0, 289(r4)
  sw  r0, 290(r4)
  sw  r0, 291(r4) # dummy
  sw  r0, 292(r4) # dummy
  sw  r0, 293(r4) # false
  sw  r0, 294(r4) # dummy
  sw  r0, 295(r4) # dummy
  sw  r0, 296(r4) # dummy
  sw  r0, 297(r4) # dummy
  sw  r0, 298(r4)
  sw  r0, 299(r4)
  sw  r0, 300(r4)
  sw  r0, 301(r4)
  sw  r0, 302(r4) # dummy
  sw  r0, 303(r4) # dummy
  sw  r0, 304(r4) # false
  sw  r0, 305(r4) # dummy
  sw  r0, 306(r4) # dummy
  sw  r0, 307(r4) # dummy
  sw  r0, 308(r4) # dummy
  sw  r0, 309(r4)
  sw  r0, 310(r4)
  sw  r0, 311(r4)
  sw  r0, 312(r4)
  sw  r0, 313(r4) # dummy
  sw  r0, 314(r4) # dummy
  sw  r0, 315(r4) # false
  sw  r0, 316(r4) # dummy
  sw  r0, 317(r4) # dummy
  sw  r0, 318(r4) # dummy
  sw  r0, 319(r4) # dummy
  sw  r0, 320(r4)
  sw  r0, 321(r4)
  sw  r0, 322(r4)
  sw  r0, 323(r4)
  sw  r0, 324(r4) # dummy
  sw  r0, 325(r4) # dummy
  sw  r0, 326(r4) # false
  sw  r0, 327(r4) # dummy
  sw  r0, 328(r4) # dummy
  sw  r0, 329(r4) # dummy
  sw  r0, 330(r4) # dummy
  sw  r0, 331(r4)
  sw  r0, 332(r4)
  sw  r0, 333(r4)
  sw  r0, 334(r4)
  sw  r0, 335(r4) # dummy
  sw  r0, 336(r4) # dummy
  sw  r0, 337(r4) # false
  sw  r0, 338(r4) # dummy
  sw  r0, 339(r4) # dummy
  sw  r0, 340(r4) # dummy
  sw  r0, 341(r4) # dummy
  sw  r0, 342(r4)
  sw  r0, 343(r4)
  sw  r0, 344(r4)
  sw  r0, 345(r4)
  sw  r0, 346(r4) # dummy
  sw  r0, 347(r4) # dummy
  sw  r0, 348(r4) # false
  sw  r0, 349(r4) # dummy
  sw  r0, 350(r4) # dummy
  sw  r0, 351(r4) # dummy
  sw  r0, 352(r4) # dummy
  sw  r0, 353(r4)
  sw  r0, 354(r4)
  sw  r0, 355(r4)
  sw  r0, 356(r4)
  sw  r0, 357(r4) # dummy
  sw  r0, 358(r4) # dummy
  sw  r0, 359(r4) # false
  sw  r0, 360(r4) # dummy
  sw  r0, 361(r4) # dummy
  sw  r0, 362(r4) # dummy
  sw  r0, 363(r4) # dummy
  sw  r0, 364(r4)
  sw  r0, 365(r4)
  sw  r0, 366(r4)
  sw  r0, 367(r4)
  sw  r0, 368(r4) # dummy
  sw  r0, 369(r4) # dummy
  sw  r0, 370(r4) # false
  sw  r0, 371(r4) # dummy
  sw  r0, 372(r4) # dummy
  sw  r0, 373(r4) # dummy
  sw  r0, 374(r4) # dummy
  sw  r0, 375(r4)
  sw  r0, 376(r4)
  sw  r0, 377(r4)
  sw  r0, 378(r4)
  sw  r0, 379(r4) # dummy
  sw  r0, 380(r4) # dummy
  sw  r0, 381(r4) # false
  sw  r0, 382(r4) # dummy
  sw  r0, 383(r4) # dummy
  sw  r0, 384(r4) # dummy
  sw  r0, 385(r4) # dummy
  sw  r0, 386(r4)
  sw  r0, 387(r4)
  sw  r0, 388(r4)
  sw  r0, 389(r4)
  sw  r0, 390(r4) # dummy
  sw  r0, 391(r4) # dummy
  sw  r0, 392(r4) # false
  sw  r0, 393(r4) # dummy
  sw  r0, 394(r4) # dummy
  sw  r0, 395(r4) # dummy
  sw  r0, 396(r4) # dummy
  sw  r0, 397(r4)
  sw  r0, 398(r4)
  sw  r0, 399(r4)
  sw  r0, 400(r4)
  sw  r0, 401(r4) # dummy
  sw  r0, 402(r4) # dummy
  sw  r0, 403(r4) # false
  sw  r0, 404(r4) # dummy
  sw  r0, 405(r4) # dummy
  sw  r0, 406(r4) # dummy
  sw  r0, 407(r4) # dummy
  sw  r0, 408(r4)
  sw  r0, 409(r4)
  sw  r0, 410(r4)
  sw  r0, 411(r4)
  sw  r0, 412(r4) # dummy
  sw  r0, 413(r4) # dummy
  sw  r0, 414(r4) # false
  sw  r0, 415(r4) # dummy
  sw  r0, 416(r4) # dummy
  sw  r0, 417(r4) # dummy
  sw  r0, 418(r4) # dummy
  sw  r0, 419(r4)
  sw  r0, 420(r4)
  sw  r0, 421(r4)
  sw  r0, 422(r4)
  sw  r0, 423(r4) # dummy
  sw  r0, 424(r4) # dummy
  sw  r0, 425(r4) # false
  sw  r0, 426(r4) # dummy
  sw  r0, 427(r4) # dummy
  sw  r0, 428(r4) # dummy
  sw  r0, 429(r4) # dummy
  sw  r0, 430(r4)
  sw  r0, 431(r4)
  sw  r0, 432(r4)
  sw  r0, 433(r4)
  sw  r0, 434(r4) # dummy
  sw  r0, 435(r4) # dummy
  sw  r0, 436(r4) # false
  sw  r0, 437(r4) # dummy
  sw  r0, 438(r4) # dummy
  sw  r0, 439(r4) # dummy
  sw  r0, 440(r4) # dummy
  sw  r0, 441(r4)
  sw  r0, 442(r4)
  sw  r0, 443(r4)
  sw  r0, 444(r4)
  sw  r0, 445(r4) # dummy
  sw  r0, 446(r4) # dummy
  sw  r0, 447(r4) # false
  sw  r0, 448(r4) # dummy
  sw  r0, 449(r4) # dummy
  sw  r0, 450(r4) # dummy
  sw  r0, 451(r4) # dummy
  sw  r0, 452(r4)
  sw  r0, 453(r4)
  sw  r0, 454(r4)
  sw  r0, 455(r4)
  sw  r0, 456(r4) # dummy
  sw  r0, 457(r4) # dummy
  sw  r0, 458(r4) # false
  sw  r0, 459(r4) # dummy
  sw  r0, 460(r4) # dummy
  sw  r0, 461(r4) # dummy
  sw  r0, 462(r4) # dummy
  sw  r0, 463(r4)
  sw  r0, 464(r4)
  sw  r0, 465(r4)
  sw  r0, 466(r4)
  sw  r0, 467(r4) # dummy
  sw  r0, 468(r4) # dummy
  sw  r0, 469(r4) # false
  sw  r0, 470(r4) # dummy
  sw  r0, 471(r4) # dummy
  sw  r0, 472(r4) # dummy
  sw  r0, 473(r4) # dummy
  sw  r0, 474(r4)
  sw  r0, 475(r4)
  sw  r0, 476(r4)
  sw  r0, 477(r4)
  sw  r0, 478(r4) # dummy
  sw  r0, 479(r4) # dummy
  sw  r0, 480(r4) # false
  sw  r0, 481(r4) # dummy
  sw  r0, 482(r4) # dummy
  sw  r0, 483(r4) # dummy
  sw  r0, 484(r4) # dummy
  sw  r0, 485(r4)
  sw  r0, 486(r4)
  sw  r0, 487(r4)
  sw  r0, 488(r4)
  sw  r0, 489(r4) # dummy
  sw  r0, 490(r4) # dummy
  sw  r0, 491(r4) # false
  sw  r0, 492(r4) # dummy
  sw  r0, 493(r4) # dummy
  sw  r0, 494(r4) # dummy
  sw  r0, 495(r4) # dummy
  sw  r0, 496(r4)
  sw  r0, 497(r4)
  sw  r0, 498(r4)
  sw  r0, 499(r4)
  sw  r0, 500(r4) # dummy
  sw  r0, 501(r4) # dummy
  sw  r0, 502(r4) # false
  sw  r0, 503(r4) # dummy
  sw  r0, 504(r4) # dummy
  sw  r0, 505(r4) # dummy
  sw  r0, 506(r4) # dummy
  sw  r0, 507(r4)
  sw  r0, 508(r4)
  sw  r0, 509(r4)
  sw  r0, 510(r4)
  sw  r0, 511(r4) # dummy
  sw  r0, 512(r4) # dummy
  sw  r0, 513(r4) # false
  sw  r0, 514(r4) # dummy
  sw  r0, 515(r4) # dummy
  sw  r0, 516(r4) # dummy
  sw  r0, 517(r4) # dummy
  sw  r0, 518(r4)
  sw  r0, 519(r4)
  sw  r0, 520(r4)
  sw  r0, 521(r4)
  sw  r0, 522(r4) # dummy
  sw  r0, 523(r4) # dummy
  sw  r0, 524(r4) # false
  sw  r0, 525(r4) # dummy
  sw  r0, 526(r4) # dummy
  sw  r0, 527(r4) # dummy
  sw  r0, 528(r4) # dummy
  sw  r0, 529(r4)
  sw  r0, 530(r4)
  sw  r0, 531(r4)
  sw  r0, 532(r4)
  sw  r0, 533(r4) # dummy
  sw  r0, 534(r4) # dummy
  sw  r0, 535(r4) # false
  sw  r0, 536(r4) # dummy
  sw  r0, 537(r4) # dummy
  sw  r0, 538(r4) # dummy
  sw  r0, 539(r4) # dummy
  sw  r0, 540(r4)
  sw  r0, 541(r4)
  sw  r0, 542(r4)
  sw  r0, 543(r4)
  sw  r0, 544(r4) # dummy
  sw  r0, 545(r4) # dummy
  sw  r0, 546(r4) # false
  sw  r0, 547(r4) # dummy
  sw  r0, 548(r4) # dummy
  sw  r0, 549(r4) # dummy
  sw  r0, 550(r4) # dummy
  sw  r0, 551(r4)
  sw  r0, 552(r4)
  sw  r0, 553(r4)
  sw  r0, 554(r4)
  sw  r0, 555(r4) # dummy
  sw  r0, 556(r4) # dummy
  sw  r0, 557(r4) # false
  sw  r0, 558(r4) # dummy
  sw  r0, 559(r4) # dummy
  sw  r0, 560(r4) # dummy
  sw  r0, 561(r4) # dummy
  sw  r0, 562(r4)
  sw  r0, 563(r4)
  sw  r0, 564(r4)
  sw  r0, 565(r4)
  sw  r0, 566(r4) # dummy
  sw  r0, 567(r4) # dummy
  sw  r0, 568(r4) # false
  sw  r0, 569(r4) # dummy
  sw  r0, 570(r4) # dummy
  sw  r0, 571(r4) # dummy
  sw  r0, 572(r4) # dummy
  sw  r0, 573(r4)
  sw  r0, 574(r4)
  sw  r0, 575(r4)
  sw  r0, 576(r4)
  sw  r0, 577(r4) # dummy
  sw  r0, 578(r4) # dummy
  sw  r0, 579(r4) # false
  sw  r0, 580(r4) # dummy
  sw  r0, 581(r4) # dummy
  sw  r0, 582(r4) # dummy
  sw  r0, 583(r4) # dummy
  sw  r0, 584(r4)
  sw  r0, 585(r4)
  sw  r0, 586(r4)
  sw  r0, 587(r4)
  sw  r0, 588(r4) # dummy
  sw  r0, 589(r4) # dummy
  sw  r0, 590(r4) # false
  sw  r0, 591(r4) # dummy
  sw  r0, 592(r4) # dummy
  sw  r0, 593(r4) # dummy
  sw  r0, 594(r4) # dummy
  sw  r0, 595(r4)
  sw  r0, 596(r4)
  sw  r0, 597(r4)
  sw  r0, 598(r4)
  sw  r0, 599(r4) # dummy
  sw  r0, 600(r4) # dummy
  sw  r0, 601(r4) # false
  sw  r0, 602(r4) # dummy
  sw  r0, 603(r4) # dummy
  sw  r0, 604(r4) # dummy
  sw  r0, 605(r4) # dummy
  sw  r0, 606(r4)
  sw  r0, 607(r4)
  sw  r0, 608(r4)
  sw  r0, 609(r4)
  sw  r0, 610(r4) # dummy
  sw  r0, 611(r4) # dummy
  sw  r0, 612(r4) # false
  sw  r0, 613(r4) # dummy
  sw  r0, 614(r4) # dummy
  sw  r0, 615(r4) # dummy
  sw  r0, 616(r4) # dummy
  sw  r0, 617(r4)
  sw  r0, 618(r4)
  sw  r0, 619(r4)
  sw  r0, 620(r4)
  sw  r0, 621(r4) # dummy
  sw  r0, 622(r4) # dummy
  sw  r0, 623(r4) # false
  sw  r0, 624(r4) # dummy
  sw  r0, 625(r4) # dummy
  sw  r0, 626(r4) # dummy
  sw  r0, 627(r4) # dummy
  sw  r0, 628(r4)
  sw  r0, 629(r4)
  sw  r0, 630(r4)
  sw  r0, 631(r4)
  sw  r0, 632(r4) # dummy
  sw  r0, 633(r4) # dummy
  sw  r0, 634(r4) # false
  sw  r0, 635(r4) # dummy
  sw  r0, 636(r4) # dummy
  sw  r0, 637(r4) # dummy
  sw  r0, 638(r4) # dummy
  sw  r0, 639(r4)
  sw  r0, 640(r4)
  sw  r0, 641(r4)
  sw  r0, 642(r4)
  sw  r0, 643(r4) # dummy
  sw  r0, 644(r4) # dummy
  sw  r0, 645(r4) # false
  sw  r0, 646(r4) # dummy
  sw  r0, 647(r4) # dummy
  sw  r0, 648(r4) # dummy
  sw  r0, 649(r4) # dummy
  sw  r0, 650(r4)
  sw  r0, 651(r4)
  sw  r0, 652(r4)
  sw  r0, 653(r4)
  sw  r0, 654(r4) # dummy
  sw  r0, 655(r4) # dummy
  sw  r0, 656(r4) # false
  sw  r0, 657(r4) # dummy
  sw  r0, 658(r4) # dummy
  sw  r0, 659(r4) # dummy
  sw  r0, 660(r4) # dummy
# screen
  fsw f0, 661(r4)
  fsw f0, 662(r4)
  fsw f0, 663(r4)
# viewpoint
  fsw f0, 664(r4)
  fsw f0, 665(r4)
  fsw f0, 666(r4)
# light
  fsw f0, 667(r4)
  fsw f0, 668(r4)
  fsw f0, 669(r4)
# beam
  flup f1, 37
  fsw f1, 670(r4)
# and_net
  addi  r1, r4, 671
  addi  r2, r0, -1
  sw  r2, 0(r1)
  sw  r1, 672(r4)
  sw  r1, 673(r4)
  sw  r1, 674(r4)
  sw  r1, 675(r4)
  sw  r1, 676(r4)
  sw  r1, 677(r4)
  sw  r1, 678(r4)
  sw  r1, 679(r4)
  sw  r1, 680(r4)
  sw  r1, 681(r4)
  sw  r1, 682(r4)
  sw  r1, 683(r4)
  sw  r1, 684(r4)
  sw  r1, 685(r4)
  sw  r1, 686(r4)
  sw  r1, 687(r4)
  sw  r1, 688(r4)
  sw  r1, 689(r4)
  sw  r1, 690(r4)
  sw  r1, 691(r4)
  sw  r1, 692(r4)
  sw  r1, 693(r4)
  sw  r1, 694(r4)
  sw  r1, 695(r4)
  sw  r1, 696(r4)
  sw  r1, 697(r4)
  sw  r1, 698(r4)
  sw  r1, 699(r4)
  sw  r1, 700(r4)
  sw  r1, 701(r4)
  sw  r1, 702(r4)
  sw  r1, 703(r4)
  sw  r1, 704(r4)
  sw  r1, 705(r4)
  sw  r1, 706(r4)
  sw  r1, 707(r4)
  sw  r1, 708(r4)
  sw  r1, 709(r4)
  sw  r1, 710(r4)
  sw  r1, 711(r4)
  sw  r1, 712(r4)
  sw  r1, 713(r4)
  sw  r1, 714(r4)
  sw  r1, 715(r4)
  sw  r1, 716(r4)
  sw  r1, 717(r4)
  sw  r1, 718(r4)
  sw  r1, 719(r4)
  sw  r1, 720(r4)
  sw  r1, 721(r4)
# or_net
  sw  r1, 722(r4)
  addi  r1, r4, 722
  sw  r1, 723(r4)
# solver_dist
  fsw f0, 724(r4)
# intsec_rectside
  sw r0, 725(r4)
# tmin
  flup f1, 31
  fsw f1, 726(r4)
# intersection_point
  fsw f0, 727(r4)
  fsw f0, 728(r4)
  fsw f0, 729(r4)
# intersected_object_id
  sw r0, 730(r4)
# nvector
  fsw f0, 731(r4)
  fsw f0, 732(r4)
  fsw f0, 733(r4)
# texture_color
  fsw f0, 734(r4)
  fsw f0, 735(r4)
  fsw f0, 736(r4)
# diffuse_ray
  fsw f0, 737(r4)
  fsw f0, 738(r4)
  fsw f0, 739(r4)
# rgb
  fsw f0, 740(r4)
  fsw f0, 741(r4)
  fsw f0, 742(r4)
# image_size
  sw r0, 743(r4)
  sw r0, 744(r4)
# image_center
  sw r0, 745(r4)
  sw r0, 746(r4)
# scan_pitch
  fsw f0, 747(r4)
# startp
  fsw f0, 748(r4)
  fsw f0, 749(r4)
  fsw f0, 750(r4)
# startp_fast
  fsw f0, 751(r4)
  fsw f0, 752(r4)
  fsw f0, 753(r4)
# screenx_dir
  fsw f0, 754(r4)
  fsw f0, 755(r4)
  fsw f0, 756(r4)
# screeny_dir
  fsw f0, 757(r4)
  fsw f0, 758(r4)
  fsw f0, 759(r4)
# screenz_dir
  fsw f0, 760(r4)
  fsw f0, 761(r4)
  fsw f0, 762(r4)
# ptrace_dirvec
  fsw f0, 763(r4)
  fsw f0, 764(r4)
  fsw f0, 765(r4)
# dirvecs
  addi  r1, r4, 766
  sw  r1, 766(r4)
  sw  r1, 767(r4)
  sw  r1, 768(r4)
  sw  r1, 769(r4)
  sw  r1, 770(r4)
  sw  r1, 771(r4)
  sw  r1, 772(r4)
# reflections
  addi  r1, r4, 773
  sw  r1, 773(r4)
  sw  r1, 774(r4)
  sw  r2, r4, 775
  sw  r0, 775(r4)
  sw  r1, 776(r4)
  fsw  f1, 777(r4)
  sw  r2, 778(r4)
  sw  r2, 779(r4)
  sw  r2, 780(r4)
  sw  r2, 781(r4)
  sw  r2, 782(r4)
  sw  r2, 783(r4)
  sw  r2, 784(r4)
  sw  r2, 785(r4)
  sw  r2, 786(r4)
  sw  r2, 787(r4)
  sw  r2, 788(r4)
  sw  r2, 789(r4)
  sw  r2, 790(r4)
  sw  r2, 791(r4)
  sw  r2, 792(r4)
  sw  r2, 793(r4)
  sw  r2, 794(r4)
  sw  r2, 795(r4)
  sw  r2, 796(r4)
  sw  r2, 797(r4)
  sw  r2, 798(r4)
  sw  r2, 799(r4)
  sw  r2, 800(r4)
  sw  r2, 801(r4)
  sw  r2, 802(r4)
  sw  r2, 803(r4)
  sw  r2, 804(r4)
  sw  r2, 805(r4)
  sw  r2, 806(r4)
  sw  r2, 807(r4)
  sw  r2, 808(r4)
  sw  r2, 809(r4)
  sw  r2, 810(r4)
  sw  r2, 811(r4)
  sw  r2, 812(r4)
  sw  r2, 813(r4)
  sw  r2, 814(r4)
  sw  r2, 815(r4)
  sw  r2, 816(r4)
  sw  r2, 817(r4)
  sw  r2, 818(r4)
  sw  r2, 819(r4)
  sw  r2, 820(r4)
  sw  r2, 821(r4)
  sw  r2, 822(r4)
  sw  r2, 823(r4)
  sw  r2, 824(r4)
  sw  r2, 825(r4)
  sw  r2, 826(r4)
  sw  r2, 827(r4)
  sw  r2, 828(r4)
  sw  r2, 829(r4)
  sw  r2, 830(r4)
  sw  r2, 831(r4)
  sw  r2, 832(r4)
  sw  r2, 833(r4)
  sw  r2, 834(r4)
  sw  r2, 835(r4)
  sw  r2, 836(r4)
  sw  r2, 837(r4)
  sw  r2, 838(r4)
  sw  r2, 839(r4)
  sw  r2, 840(r4)
  sw  r2, 841(r4)
  sw  r2, 842(r4)
  sw  r2, 843(r4)
  sw  r2, 844(r4)
  sw  r2, 845(r4)
  sw  r2, 846(r4)
  sw  r2, 847(r4)
  sw  r2, 848(r4)
  sw  r2, 849(r4)
  sw  r2, 850(r4)
  sw  r2, 851(r4)
  sw  r2, 852(r4)
  sw  r2, 853(r4)
  sw  r2, 854(r4)
  sw  r2, 855(r4)
  sw  r2, 856(r4)
  sw  r2, 857(r4)
  sw  r2, 858(r4)
  sw  r2, 859(r4)
  sw  r2, 860(r4)
  sw  r2, 861(r4)
  sw  r2, 862(r4)
  sw  r2, 863(r4)
  sw  r2, 864(r4)
  sw  r2, 865(r4)
  sw  r2, 866(r4)
  sw  r2, 867(r4)
  sw  r2, 868(r4)
  sw  r2, 869(r4)
  sw  r2, 870(r4)
  sw  r2, 871(r4)
  sw  r2, 872(r4)
  sw  r2, 873(r4)
  sw  r2, 874(r4)
  sw  r2, 875(r4)
  sw  r2, 876(r4)
  sw  r2, 877(r4)
  sw  r2, 878(r4)
  sw  r2, 879(r4)
  sw  r2, 880(r4)
  sw  r2, 881(r4)
  sw  r2, 882(r4)
  sw  r2, 883(r4)
  sw  r2, 884(r4)
  sw  r2, 885(r4)
  sw  r2, 886(r4)
  sw  r2, 887(r4)
  sw  r2, 888(r4)
  sw  r2, 889(r4)
  sw  r2, 890(r4)
  sw  r2, 891(r4)
  sw  r2, 892(r4)
  sw  r2, 893(r4)
  sw  r2, 894(r4)
  sw  r2, 895(r4)
  sw  r2, 896(r4)
  sw  r2, 897(r4)
  sw  r2, 898(r4)
  sw  r2, 899(r4)
  sw  r2, 900(r4)
  sw  r2, 901(r4)
  sw  r2, 902(r4)
  sw  r2, 903(r4)
  sw  r2, 904(r4)
  sw  r2, 905(r4)
  sw  r2, 906(r4)
  sw  r2, 907(r4)
  sw  r2, 908(r4)
  sw  r2, 909(r4)
  sw  r2, 910(r4)
  sw  r2, 911(r4)
  sw  r2, 912(r4)
  sw  r2, 913(r4)
  sw  r2, 914(r4)
  sw  r2, 915(r4)
  sw  r2, 916(r4)
  sw  r2, 917(r4)
  sw  r2, 918(r4)
  sw  r2, 919(r4)
  sw  r2, 920(r4)
  sw  r2, 921(r4)
  sw  r2, 922(r4)
  sw  r2, 923(r4)
  sw  r2, 924(r4)
  sw  r2, 925(r4)
  sw  r2, 926(r4)
  sw  r2, 927(r4)
  sw  r2, 928(r4)
  sw  r2, 929(r4)
  sw  r2, 930(r4)
  sw  r2, 931(r4)
  sw  r2, 932(r4)
  sw  r2, 933(r4)
  sw  r2, 934(r4)
  sw  r2, 935(r4)
  sw  r2, 936(r4)
  sw  r2, 937(r4)
  sw  r2, 938(r4)
  sw  r2, 939(r4)
  sw  r2, 940(r4)
  sw  r2, 941(r4)
  sw  r2, 942(r4)
  sw  r2, 943(r4)
  sw  r2, 944(r4)
  sw  r2, 945(r4)
  sw  r2, 946(r4)
  sw  r2, 947(r4)
  sw  r2, 948(r4)
  sw  r2, 949(r4)
  sw  r2, 950(r4)
  sw  r2, 951(r4)
  sw  r2, 952(r4)
  sw  r2, 953(r4)
  sw  r2, 954(r4)
  sw  r2, 955(r4)
  sw  r2, 956(r4)
  sw  r2, 957(r4)
# light_dirvec
  addi  r1, r4, 958
  fsw  f0, 958(r4)
  fsw  f0, 959(r4)
  fsw  f0, 960(r4)
  addi  r2, r4, 961
  sw  r1, 961(r4)
  sw  r1, 962(r4)
  sw  r1, 963(r4)
  sw  r1, 964(r4)
  sw  r1, 965(r4)
  sw  r1, 966(r4)
  sw  r1, 967(r4)
  sw  r1, 968(r4)
  sw  r1, 969(r4)
  sw  r1, 970(r4)
  sw  r1, 971(r4)
  sw  r1, 972(r4)
  sw  r1, 973(r4)
  sw  r1, 974(r4)
  sw  r1, 975(r4)
  sw  r1, 976(r4)
  sw  r1, 977(r4)
  sw  r1, 978(r4)
  sw  r1, 979(r4)
  sw  r1, 980(r4)
  sw  r1, 981(r4)
  sw  r1, 982(r4)
  sw  r1, 983(r4)
  sw  r1, 984(r4)
  sw  r1, 985(r4)
  sw  r1, 986(r4)
  sw  r1, 987(r4)
  sw  r1, 988(r4)
  sw  r1, 989(r4)
  sw  r1, 990(r4)
  sw  r1, 991(r4)
  sw  r1, 992(r4)
  sw  r1, 993(r4)
  sw  r1, 994(r4)
  sw  r1, 995(r4)
  sw  r1, 996(r4)
  sw  r1, 997(r4)
  sw  r1, 998(r4)
  sw  r1, 999(r4)
  sw  r1, 1000(r4)
  sw  r1, 1001(r4)
  sw  r1, 1002(r4)
  sw  r1, 1003(r4)
  sw  r1, 1004(r4)
  sw  r1, 1005(r4)
  sw  r1, 1006(r4)
  sw  r1, 1007(r4)
  sw  r1, 1008(r4)
  sw  r1, 1009(r4)
  sw  r1, 1010(r4)
  sw  r1, 1011(r4)
  sw  r1, 1012(r4)
  sw  r1, 1013(r4)
  sw  r1, 1014(r4)
  sw  r1, 1015(r4)
  sw  r1, 1016(r4)
  sw  r1, 1017(r4)
  sw  r1, 1018(r4)
  sw  r1, 1019(r4)
  sw  r1, 1020(r4)
  sw  r1, 1021(r4)
  sw  r2, 1022(r4)
# n_reflections
  sw r0, 1023(r4)
  addi  r4, r4, 1024
#	main program starts
	addi	r1, r0, 128
	addi	r2, r0, 128
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	rt.3343				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	_R_0, r0, 0
