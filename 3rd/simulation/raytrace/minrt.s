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
	beq	r0, r30, fle_else.15666
	addi	r1, r0, 0
	jr	r31				#
fle_else.15666:
	addi	r1, r0, 1
	jr	r31				#
fisneg.2805:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15667
	addi	r1, r0, 0
	jr	r31				#
fle_else.15667:
	addi	r1, r0, 1
	jr	r31				#
fiszero.2807:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15668
	addi	r1, r0, 1
	jr	r31				#
feq_else.15668:
	addi	r1, r0, 0
	jr	r31				#
xor.2809:
	beq	r1, r2, beq_then.15669
	addi	r1, r0, 1
	jr	r31				#
beq_then.15669:
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
	beq	r0, r30, fle_else.15670
	jr	r31				#
fle_else.15670:
	fneg	f1, f1
	jr	r31				#
int_of_float.2818:
	ftoi	f1, f1
	jr	r31				#
float_of_int.2820:
	itof	r1, r1
	jr	r31				#
floor.2822:
	ftoi	r1, f1
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15671
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15671:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
	jr	r31				#
hoge.2824:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15672
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15673
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15674
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15675
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15676
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15677
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15678
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15679
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15680
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15681
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15682
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15683
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15684
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15685
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15686
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15687
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2824
fle_else.15687:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15686:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15685:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15684:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15683:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15682:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15681:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15680:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15679:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15678:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15677:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15676:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15675:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15674:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15673:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15672:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2827:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15688
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15689
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15690
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15691
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2827
fle_else.15691:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2827
fle_else.15690:
	jr	r31				#
fle_else.15689:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15692
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15693
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2827
fle_else.15693:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2827
fle_else.15692:
	jr	r31				#
fle_else.15688:
	jr	r31				#
modulo_2pi.2831:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 0(r3)
	fsw	f1, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15694
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15696
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15698
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15700
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15702
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15704
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15706
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15708
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15710
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15712
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15714
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15716
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15718
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15720
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15722
	addi	r30, r0, 4060
	lui	r30, r30, 18505	# to load float		205887.438848
	fmvfr	f2, r30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	hoge.2824				#	bl	hoge.2824
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	fle_cont.15723
fle_else.15722:
	fadd	f1, f0, f2
fle_cont.15723:
	j	fle_cont.15721
fle_else.15720:
	fadd	f1, f0, f2
fle_cont.15721:
	j	fle_cont.15719
fle_else.15718:
	fadd	f1, f0, f2
fle_cont.15719:
	j	fle_cont.15717
fle_else.15716:
	fadd	f1, f0, f2
fle_cont.15717:
	j	fle_cont.15715
fle_else.15714:
	fadd	f1, f0, f2
fle_cont.15715:
	j	fle_cont.15713
fle_else.15712:
	fadd	f1, f0, f2
fle_cont.15713:
	j	fle_cont.15711
fle_else.15710:
	fadd	f1, f0, f2
fle_cont.15711:
	j	fle_cont.15709
fle_else.15708:
	fadd	f1, f0, f2
fle_cont.15709:
	j	fle_cont.15707
fle_else.15706:
	fadd	f1, f0, f2
fle_cont.15707:
	j	fle_cont.15705
fle_else.15704:
	fadd	f1, f0, f2
fle_cont.15705:
	j	fle_cont.15703
fle_else.15702:
	fadd	f1, f0, f2
fle_cont.15703:
	j	fle_cont.15701
fle_else.15700:
	fadd	f1, f0, f2
fle_cont.15701:
	j	fle_cont.15699
fle_else.15698:
	fadd	f1, f0, f2
fle_cont.15699:
	j	fle_cont.15697
fle_else.15696:
	fadd	f1, f0, f2
fle_cont.15697:
	j	fle_cont.15695
fle_else.15694:
	fadd	f1, f0, f2
fle_cont.15695:
	flup	f2, 5		# fli	f2, 6.283186
	flw	f3, 2(r3)
	fle	r30, f2, f3
	beq	r0, r30, fle_else.15724
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15725
	fsub	f2, f3, f1
	flup	f3, 3		# fli	f3, 2.000000
	fdiv	f1, f1, f3
	flw	f3, 0(r3)
	fadd	f30, f0, f2				# fmr	f30, f2
	fadd	f2, f0, f1				# fmr	f2, f1
	fadd	f1, f0, f30				# fmr	f1, f30
	j	fuga.2827
fle_else.15725:
	flup	f2, 3		# fli	f2, 2.000000
	fdiv	f2, f1, f2
	flw	f1, 0(r3)
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f30				# fmr	f1, f30
	j	fuga.2827
fle_else.15724:
	fadd	f1, f0, f3
	jr	r31				#
sin_body.2833:
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
cos_body.2835:
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
sin.2837:
	flup	f2, 14		# fli	f2, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15726
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.15727
fle_else.15726:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.15727:
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
	beq	r0, r30, fle_else.15728
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15730
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15732
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15734
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15736
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15738
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15740
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15742
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15744
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15746
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15748
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15750
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15752
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15754
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2824				#	bl	hoge.2824
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.15755
fle_else.15754:
fle_cont.15755:
	j	fle_cont.15753
fle_else.15752:
fle_cont.15753:
	j	fle_cont.15751
fle_else.15750:
fle_cont.15751:
	j	fle_cont.15749
fle_else.15748:
fle_cont.15749:
	j	fle_cont.15747
fle_else.15746:
fle_cont.15747:
	j	fle_cont.15745
fle_else.15744:
fle_cont.15745:
	j	fle_cont.15743
fle_else.15742:
fle_cont.15743:
	j	fle_cont.15741
fle_else.15740:
fle_cont.15741:
	j	fle_cont.15739
fle_else.15738:
fle_cont.15739:
	j	fle_cont.15737
fle_else.15736:
fle_cont.15737:
	j	fle_cont.15735
fle_else.15734:
fle_cont.15735:
	j	fle_cont.15733
fle_else.15732:
fle_cont.15733:
	j	fle_cont.15731
fle_else.15730:
fle_cont.15731:
	j	fle_cont.15729
fle_else.15728:
fle_cont.15729:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2827				#	bl	fuga.2827
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15756
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15757
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15758
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
fle_else.15758:
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
fle_else.15757:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15759
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
fle_else.15759:
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
fle_else.15756:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15760
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15761
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
fle_else.15761:
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
fle_else.15760:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15762
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
fle_else.15762:
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
cos.2839:
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
	beq	r0, r30, fle_else.15763
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15765
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15767
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15769
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15771
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15773
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15775
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15777
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15779
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15781
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15783
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15785
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15787
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15789
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2824				#	bl	hoge.2824
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.15790
fle_else.15789:
fle_cont.15790:
	j	fle_cont.15788
fle_else.15787:
fle_cont.15788:
	j	fle_cont.15786
fle_else.15785:
fle_cont.15786:
	j	fle_cont.15784
fle_else.15783:
fle_cont.15784:
	j	fle_cont.15782
fle_else.15781:
fle_cont.15782:
	j	fle_cont.15780
fle_else.15779:
fle_cont.15780:
	j	fle_cont.15778
fle_else.15777:
fle_cont.15778:
	j	fle_cont.15776
fle_else.15775:
fle_cont.15776:
	j	fle_cont.15774
fle_else.15773:
fle_cont.15774:
	j	fle_cont.15772
fle_else.15771:
fle_cont.15772:
	j	fle_cont.15770
fle_else.15769:
fle_cont.15770:
	j	fle_cont.15768
fle_else.15767:
fle_cont.15768:
	j	fle_cont.15766
fle_else.15765:
fle_cont.15766:
	j	fle_cont.15764
fle_else.15763:
fle_cont.15764:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2827				#	bl	fuga.2827
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15791
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15792
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15793
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
fle_else.15793:
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
fle_else.15792:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15794
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
fle_else.15794:
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
fle_else.15791:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15795
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15796
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
fle_else.15796:
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
fle_else.15795:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15797
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
fle_else.15797:
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
atan_body.2841:
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
atan.2843:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15798
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.15799
fle_else.15798:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.15799:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15800
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15801
	flup	f3, 15		# fli	f3, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.15801:
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
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.15800:
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
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.15802
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r7, r5, 3
	slli	r8, r5, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.15803
	j	div10_sub.2849
ble_then.15803:
	slli	r2, r5, 3
	slli	r7, r5, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15804
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	j	div10_sub.2849
ble_then.15804:
	add	r1, r0, r5
	jr	r31				#
ble_then.15802:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15805
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r7, r2, 3
	slli	r8, r2, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.15806
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r6				# mr	r2, r6
	j	div10_sub.2849
ble_then.15806:
	slli	r6, r2, 3
	slli	r7, r2, 1
	add	r6, r6, r7
	addi	r6, r6, 9
	ble	r1, r6, ble_then.15807
	j	div10_sub.2849
ble_then.15807:
	add	r1, r0, r2
	jr	r31				#
ble_then.15805:
	add	r1, r0, r6
	jr	r31				#
div10.2853:
	slli	r2, r1, 7
	slli	r5, r1, 6
	add	r2, r2, r5
	slli	r5, r1, 3
	add	r2, r2, r5
	slli	r5, r1, 2
	add	r2, r2, r5
	add	r1, r2, r1
	srli	r1, r1, 11
	jr	r31				#
print_uint.2855:
	bgei	10, r1, bge_then.15808
	addi	r1, r1, 48
	out	r1
	jr	r31				#
bge_then.15808:
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
	bgei	10, r2, bge_then.15809
	addi	r5, r2, 48
	out	r5
	j	bge_cont.15810
bge_then.15809:
	slli	r5, r2, 7
	slli	r6, r2, 6
	add	r5, r5, r6
	slli	r6, r2, 3
	add	r5, r5, r6
	slli	r6, r2, 2
	add	r5, r5, r6
	add	r5, r5, r2
	srli	r5, r5, 11
	sw	r2, 1(r3)
	sw	r5, 2(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2855				#	bl	print_uint.2855
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
bge_cont.15810:
	slli	r1, r2, 3
	slli	r2, r2, 1
	add	r1, r1, r2
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
	jr	r31				#
print_int.2857:
	bgei	0, r1, bge_then.15811
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	j	print_int.2857
bge_then.15811:
	bgei	10, r1, bge_then.15812
	addi	r1, r1, 48
	out	r1
	jr	r31				#
bge_then.15812:
	addi	r2, r0, 100
	ble	r2, r1, ble_then.15813
	slli	r2, r1, 7
	slli	r5, r1, 6
	add	r2, r2, r5
	slli	r5, r1, 3
	add	r2, r2, r5
	slli	r5, r1, 2
	add	r2, r2, r5
	add	r2, r2, r1
	srli	r2, r2, 11
	addi	r5, r2, 48
	out	r5
	slli	r5, r2, 3
	slli	r2, r2, 1
	add	r2, r5, r2
	sub	r1, r1, r2
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.15813:
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
	addi	r2, r2, 48
	out	r2
	addi	r2, r5, 48
	out	r2
	slli	r2, r5, 3
	slli	r5, r5, 1
	add	r2, r2, r5
	sub	r1, r1, r2
	addi	r1, r1, 48
	out	r1
	jr	r31				#
xor.2859:
	beqi	0, r1, beq_then.15814
	beqi	0, r2, beq_then.15815
	addi	r1, r0, 0
	jr	r31				#
beq_then.15815:
	addi	r1, r0, 1
	jr	r31				#
beq_then.15814:
	add	r1, r0, r2
	jr	r31				#
sgn.2862:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15816
	addi	r1, r0, 1
	j	feq_cont.15817
feq_else.15816:
	addi	r1, r0, 0
feq_cont.15817:
	beqi	0, r1, beq_then.15818
	flup	f1, 0		# fli	f1, 0.000000
	jr	r31				#
beq_then.15818:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15819
	addi	r1, r0, 0
	j	fle_cont.15820
fle_else.15819:
	addi	r1, r0, 1
fle_cont.15820:
	beqi	0, r1, beq_then.15821
	flup	f1, 2		# fli	f1, 1.000000
	jr	r31				#
beq_then.15821:
	flup	f1, 11		# fli	f1, -1.000000
	jr	r31				#
fneg_cond.2864:
	beqi	0, r1, beq_then.15822
	jr	r31				#
beq_then.15822:
	fneg	f1, f1
	jr	r31				#
add_mod5.2867:
	add	r1, r1, r2
	bgei	5, r1, bge_then.15823
	jr	r31				#
bge_then.15823:
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
	fsw	f1, 0(r1)
	fsw	f1, 1(r1)
	fsw	f1, 2(r1)
	jr	r31				#
veccpy.2880:
	flw	f1, 0(r2)
	fsw	f1, 0(r1)
	flw	f1, 1(r2)
	fsw	f1, 1(r1)
	flw	f1, 2(r2)
	fsw	f1, 2(r1)
	jr	r31				#
vecdist2.2883:
	flw	f1, 0(r1)
	flw	f2, 0(r2)
	fsub	f1, f1, f2
	fmul	f1, f1, f1
	flw	f2, 1(r1)
	flw	f3, 1(r2)
	fsub	f2, f2, f3
	fmul	f2, f2, f2
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	flw	f3, 2(r2)
	fsub	f2, f2, f3
	fmul	f2, f2, f2
	fadd	f1, f1, f2
	jr	r31				#
vecunit.2886:
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r1)
	fmul	f2, f2, f2
	flw	f3, 1(r1)
	fmul	f3, f3, f3
	fadd	f2, f2, f3
	flw	f3, 2(r1)
	fmul	f3, f3, f3
	fadd	f2, f2, f3
	fsqrt	f2, f2
	fdiv	f1, f1, f2
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
vecunit_sgn.2888:
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
	beq	r0, r30, feq_else.15829
	addi	r5, r0, 1
	j	feq_cont.15830
feq_else.15829:
	addi	r5, r0, 0
feq_cont.15830:
	beqi	0, r5, beq_then.15831
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.15832
beq_then.15831:
	beqi	0, r2, beq_then.15833
	flup	f2, 11		# fli	f2, -1.000000
	fdiv	f1, f2, f1
	j	beq_cont.15834
beq_then.15833:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
beq_cont.15834:
beq_cont.15832:
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
veciprod.2891:
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
	jr	r31				#
veciprod2.2894:
	flw	f4, 0(r1)
	fmul	f1, f4, f1
	flw	f4, 1(r1)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	jr	r31				#
vecaccum.2899:
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
vecadd.2903:
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
	jr	r31				#
vecmul.2906:
	flw	f1, 0(r1)
	flw	f2, 0(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	flw	f1, 1(r1)
	flw	f2, 1(r2)
	fmul	f1, f1, f2
	fsw	f1, 1(r1)
	flw	f1, 2(r1)
	flw	f2, 2(r2)
	fmul	f1, f1, f2
	fsw	f1, 2(r1)
	jr	r31				#
vecscale.2909:
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
vecaccumv.2912:
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
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -1
	lw	r31, 0(r3)
	fsw	f1, 661(r0)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -1
	lw	r31, 0(r3)
	fsw	f1, 662(r0)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -1
	lw	r31, 0(r3)
	fsw	f1, 663(r0)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -1
	lw	r31, 0(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f2, 0(r3)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2837				#	bl	sin.2837
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fsw	f1, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	fsw	f1, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin.2837				#	bl	sin.2837
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 2(r3)
	fmul	f3, f2, f1
	flup	f4, 26		# fli	f4, 200.000000
	fmul	f3, f3, f4
	fsw	f3, 760(r0)
	flup	f3, 27		# fli	f3, -200.000000
	flw	f4, 4(r3)
	fmul	f3, f4, f3
	fsw	f3, 761(r0)
	flw	f3, 8(r3)
	fmul	f5, f2, f3
	flup	f6, 26		# fli	f6, 200.000000
	fmul	f5, f5, f6
	fsw	f5, 762(r0)
	fsw	f3, 754(r0)
	flup	f5, 0		# fli	f5, 0.000000
	fsw	f5, 755(r0)
	fneg	f5, f1
	fsw	f5, 756(r0)
	fneg	f4, f4
	fmul	f1, f4, f1
	fsw	f1, 757(r0)
	fneg	f1, f2
	fsw	f1, 758(r0)
	fmul	f1, f4, f3
	fsw	f1, 759(r0)
	flw	f1, 661(r0)
	flw	f2, 760(r0)
	fsub	f1, f1, f2
	fsw	f1, 664(r0)
	flw	f1, 662(r0)
	flw	f2, 761(r0)
	fsub	f1, f1, f2
	fsw	f1, 665(r0)
	flw	f1, 663(r0)
	flw	f2, 762(r0)
	fsub	f1, f1, f2
	fsw	f1, 666(r0)
	jr	r31				#
read_light.2991:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -1
	lw	r31, 0(r3)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -1
	lw	r31, 0(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	sin.2837				#	bl	sin.2837
	addi	r3, r3, -3
	lw	r31, 2(r3)
	fneg	f1, f1
	fsw	f1, 668(r0)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	flw	f2, 0(r3)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin.2837				#	bl	sin.2837
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	fsw	f1, 667(r0)
	flw	f1, 2(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	fsw	f1, 669(r0)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -7
	lw	r31, 6(r3)
	fsw	f1, 670(r0)
	jr	r31				#
rotate_quadratic_matrix.2993:
	flw	f1, 0(r2)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2837				#	bl	sin.2837
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2837				#	bl	sin.2837
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 10(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2837				#	bl	sin.2837
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
read_nth_object.2996:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.15845
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
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
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 4(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -6
	lw	r31, 5(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	fsw	f1, 0(r1)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	fsw	f1, 1(r1)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	fsw	f1, 2(r1)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
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
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -8
	lw	r31, 7(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15846
	addi	r1, r0, 0
	j	fle_cont.15847
fle_else.15846:
	addi	r1, r0, 1
fle_cont.15847:
	addi	r2, r0, 2
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 7(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 8(r3)
	fsw	f1, 0(r1)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 8(r3)
	fsw	f1, 1(r1)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
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
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 9(r3)
	fsw	f1, 2(r1)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 4(r3)
	beqi	0, r2, beq_then.15848
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -12
	lw	r31, 11(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	lw	r1, 10(r3)
	fsw	f1, 0(r1)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -12
	lw	r31, 11(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	lw	r1, 10(r3)
	fsw	f1, 1(r1)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -12
	lw	r31, 11(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	lw	r1, 10(r3)
	fsw	f1, 2(r1)
	j	beq_cont.15849
beq_then.15848:
beq_cont.15849:
	lw	r2, 2(r3)
	beqi	2, r2, beq_then.15850
	lw	r5, 7(r3)
	j	beq_cont.15851
beq_then.15850:
	addi	r5, r0, 1
beq_cont.15851:
	addi	r6, r0, 4
	flup	f1, 0		# fli	f1, 0.000000
	sw	r5, 11(r3)
	sw	r1, 10(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r2, r0, r4
	addi	r4, r4, 11
	sw	r1, 10(r2)
	lw	r1, 10(r3)
	sw	r1, 9(r2)
	lw	r5, 9(r3)
	sw	r5, 8(r2)
	lw	r5, 8(r3)
	sw	r5, 7(r2)
	lw	r5, 11(r3)
	sw	r5, 6(r2)
	lw	r5, 6(r3)
	sw	r5, 5(r2)
	lw	r5, 5(r3)
	sw	r5, 4(r2)
	lw	r6, 4(r3)
	sw	r6, 3(r2)
	lw	r7, 3(r3)
	sw	r7, 2(r2)
	lw	r7, 2(r3)
	sw	r7, 1(r2)
	lw	r8, 1(r3)
	sw	r8, 0(r2)
	addi	r8, r0, 1				# set min_caml_objects
	lw	r9, 0(r3)
	add	r30, r8, r9
	sw	r2, 0(r30)
	beqi	3, r7, beq_then.15852
	beqi	2, r7, beq_then.15854
	j	beq_cont.15855
beq_then.15854:
	lw	r2, 7(r3)
	beqi	0, r2, beq_then.15856
	addi	r2, r0, 0
	j	beq_cont.15857
beq_then.15856:
	addi	r2, r0, 1
beq_cont.15857:
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	vecunit_sgn.2888				#	bl	vecunit_sgn.2888
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.15855:
	j	beq_cont.15853
beq_then.15852:
	flw	f1, 0(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15858
	addi	r2, r0, 1
	j	feq_cont.15859
feq_else.15858:
	addi	r2, r0, 0
feq_cont.15859:
	beqi	0, r2, beq_then.15860
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.15861
beq_then.15860:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15862
	addi	r2, r0, 1
	j	feq_cont.15863
feq_else.15862:
	addi	r2, r0, 0
feq_cont.15863:
	beqi	0, r2, beq_then.15864
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.15865
beq_then.15864:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15866
	addi	r2, r0, 0
	j	fle_cont.15867
fle_else.15866:
	addi	r2, r0, 1
fle_cont.15867:
	beqi	0, r2, beq_then.15868
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.15869
beq_then.15868:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.15869:
beq_cont.15865:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.15861:
	fsw	f1, 0(r5)
	flw	f1, 1(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15870
	addi	r2, r0, 1
	j	feq_cont.15871
feq_else.15870:
	addi	r2, r0, 0
feq_cont.15871:
	beqi	0, r2, beq_then.15872
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.15873
beq_then.15872:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15874
	addi	r2, r0, 1
	j	feq_cont.15875
feq_else.15874:
	addi	r2, r0, 0
feq_cont.15875:
	beqi	0, r2, beq_then.15876
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.15877
beq_then.15876:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15878
	addi	r2, r0, 0
	j	fle_cont.15879
fle_else.15878:
	addi	r2, r0, 1
fle_cont.15879:
	beqi	0, r2, beq_then.15880
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.15881
beq_then.15880:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.15881:
beq_cont.15877:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.15873:
	fsw	f1, 1(r5)
	flw	f1, 2(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15882
	addi	r2, r0, 1
	j	feq_cont.15883
feq_else.15882:
	addi	r2, r0, 0
feq_cont.15883:
	beqi	0, r2, beq_then.15884
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.15885
beq_then.15884:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15886
	addi	r2, r0, 1
	j	feq_cont.15887
feq_else.15886:
	addi	r2, r0, 0
feq_cont.15887:
	beqi	0, r2, beq_then.15888
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.15889
beq_then.15888:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15890
	addi	r2, r0, 0
	j	fle_cont.15891
fle_else.15890:
	addi	r2, r0, 1
fle_cont.15891:
	beqi	0, r2, beq_then.15892
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.15893
beq_then.15892:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.15893:
beq_cont.15889:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.15885:
	fsw	f1, 2(r5)
beq_cont.15853:
	lw	r1, 4(r3)
	beqi	0, r1, beq_then.15894
	lw	r1, 5(r3)
	lw	r2, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	rotate_quadratic_matrix.2993				#	bl	rotate_quadratic_matrix.2993
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.15895
beq_then.15894:
beq_cont.15895:
	addi	r1, r0, 1
	jr	r31				#
beq_then.15845:
	addi	r1, r0, 0
	jr	r31				#
read_object.2998:
	addi	r2, r0, 60
	ble	r2, r1, ble_then.15896
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.15897
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.15898
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.15899
	lw	r1, 1(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.15900
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.15901
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.15902
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.15903
	lw	r1, 3(r3)
	addi	r1, r1, 1
	j	read_object.2998
beq_then.15903:
	lw	r1, 3(r3)
	sw	r1, 0(r0)
	jr	r31				#
ble_then.15902:
	jr	r31				#
beq_then.15901:
	lw	r1, 2(r3)
	sw	r1, 0(r0)
	jr	r31				#
ble_then.15900:
	jr	r31				#
beq_then.15899:
	lw	r1, 1(r3)
	sw	r1, 0(r0)
	jr	r31				#
ble_then.15898:
	jr	r31				#
beq_then.15897:
	lw	r1, 0(r3)
	sw	r1, 0(r0)
	jr	r31				#
ble_then.15896:
	jr	r31				#
read_all_object.3000:
	addi	r1, r0, 0
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.15912
	addi	r1, r0, 1
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.15913
	addi	r1, r0, 2
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.15914
	addi	r1, r0, 3
	j	read_object.2998
beq_then.15914:
	lw	r1, 2(r3)
	sw	r1, 0(r0)
	jr	r31				#
beq_then.15913:
	lw	r1, 1(r3)
	sw	r1, 0(r0)
	jr	r31				#
beq_then.15912:
	lw	r1, 0(r3)
	sw	r1, 0(r0)
	jr	r31				#
read_net_item.3002:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.15918
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.15919
	lw	r2, 2(r3)
	addi	r5, r2, 1
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.15921
	lw	r2, 4(r3)
	addi	r5, r2, 1
	sw	r1, 5(r3)
	sw	r5, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.15923
	lw	r2, 6(r3)
	addi	r5, r2, 1
	sw	r1, 7(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.3002				#	bl	read_net_item.3002
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.15924
beq_then.15923:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.15924:
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.15922
beq_then.15921:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.15922:
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.15920
beq_then.15919:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.15920:
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.15918:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	j	lib_create_array
read_or_network.3004:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.15925
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.15927
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.15929
	addi	r2, r0, 3
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3002				#	bl	read_net_item.3002
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 2(r1)
	j	beq_cont.15930
beq_then.15929:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15930:
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.15928
beq_then.15927:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15928:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.15926
beq_then.15925:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.15926:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.15931
	lw	r1, 0(r3)
	addi	r5, r1, 1
	sw	r2, 4(r3)
	sw	r5, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.15932
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.15934
	addi	r2, r0, 2
	sw	r1, 7(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.3002				#	bl	read_net_item.3002
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 7(r3)
	sw	r2, 1(r1)
	j	beq_cont.15935
beq_then.15934:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.15935:
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.15933
beq_then.15932:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.15933:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.15936
	lw	r1, 5(r3)
	addi	r5, r1, 1
	sw	r2, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	read_or_network.3004				#	bl	read_or_network.3004
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 5(r3)
	lw	r5, 8(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.15937
beq_then.15936:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.15937:
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.15931:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.3006:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.15938
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.15940
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.15942
	addi	r2, r0, 3
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3002				#	bl	read_net_item.3002
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 2(r1)
	j	beq_cont.15943
beq_then.15942:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15943:
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.15941
beq_then.15940:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15941:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	j	beq_cont.15939
beq_then.15938:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15939:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.15944
	addi	r2, r0, 672				# set min_caml_and_net
	lw	r5, 0(r3)
	add	r30, r2, r5
	sw	r1, 0(r30)
	addi	r1, r5, 1
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.15945
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.15947
	addi	r2, r0, 2
	sw	r1, 6(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	read_net_item.3002				#	bl	read_net_item.3002
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	sw	r2, 1(r1)
	j	beq_cont.15948
beq_then.15947:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.15948:
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	j	beq_cont.15946
beq_then.15945:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.15946:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.15949
	addi	r2, r0, 672				# set min_caml_and_net
	lw	r5, 4(r3)
	add	r30, r2, r5
	sw	r1, 0(r30)
	addi	r1, r5, 1
	j	read_and_network.3006
beq_then.15949:
	jr	r31				#
beq_then.15944:
	jr	r31				#
read_parameter.3008:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_screen_settings.2989				#	bl	read_screen_settings.2989
	addi	r3, r3, -1
	lw	r31, 0(r3)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_light.2991				#	bl	read_light.2991
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.15952
	addi	r1, r0, 1
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.15954
	addi	r1, r0, 2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_object.2998				#	bl	read_object.2998
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.15955
beq_then.15954:
	lw	r1, 1(r3)
	sw	r1, 0(r0)
beq_cont.15955:
	j	beq_cont.15953
beq_then.15952:
	lw	r1, 0(r3)
	sw	r1, 0(r0)
beq_cont.15953:
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.15956
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.15958
	addi	r2, r0, 2
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3002				#	bl	read_net_item.3002
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 1(r1)
	j	beq_cont.15959
beq_then.15958:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15959:
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	j	beq_cont.15957
beq_then.15956:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15957:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.15960
	sw	r1, 672(r0)
	addi	r1, r0, 1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_and_network.3006				#	bl	read_and_network.3006
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.15961
beq_then.15960:
beq_cont.15961:
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	-1, r1, beq_then.15962
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.15964
	addi	r2, r0, 2
	sw	r1, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	read_net_item.3002				#	bl	read_net_item.3002
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 5(r3)
	sw	r2, 1(r1)
	j	beq_cont.15965
beq_then.15964:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.15965:
	lw	r2, 4(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.15963
beq_then.15962:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.15963:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.15966
	addi	r1, r0, 1
	sw	r2, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	read_or_network.3004				#	bl	read_or_network.3004
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	j	beq_cont.15967
beq_then.15966:
	addi	r1, r0, 1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.15967:
	sw	r1, 723(r0)
	jr	r31				#
solver_rect_surface.3010:
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.15969
	addi	r8, r0, 1
	j	feq_cont.15970
feq_else.15969:
	addi	r8, r0, 0
feq_cont.15970:
	beqi	0, r8, beq_then.15971
	addi	r1, r0, 0
	jr	r31				#
beq_then.15971:
	lw	r8, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.15972
	addi	r9, r0, 0
	j	fle_cont.15973
fle_else.15972:
	addi	r9, r0, 1
fle_cont.15973:
	beqi	0, r1, beq_then.15974
	beqi	0, r9, beq_then.15976
	addi	r1, r0, 0
	j	beq_cont.15977
beq_then.15976:
	addi	r1, r0, 1
beq_cont.15977:
	j	beq_cont.15975
beq_then.15974:
	add	r1, r0, r9
beq_cont.15975:
	add	r30, r8, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.15978
	j	beq_cont.15979
beq_then.15978:
	fneg	f4, f4
beq_cont.15979:
	fsub	f1, f4, f1
	add	r30, r2, r5
	flw	f4, 0(r30)
	fdiv	f1, f1, f4
	add	r30, r8, r6
	flw	f4, 0(r30)
	add	r30, r2, r6
	flw	f5, 0(r30)
	fmul	f5, f1, f5
	fadd	f2, f5, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.15980
	j	fle_cont.15981
fle_else.15980:
	fneg	f2, f2
fle_cont.15981:
	fle	r30, f4, f2
	beq	r0, r30, fle_else.15982
	addi	r1, r0, 0
	jr	r31				#
fle_else.15982:
	add	r30, r8, r7
	flw	f2, 0(r30)
	add	r30, r2, r7
	flw	f4, 0(r30)
	fmul	f4, f1, f4
	fadd	f3, f4, f3
	fle	r30, f0, f3
	beq	r0, r30, fle_else.15983
	j	fle_cont.15984
fle_else.15983:
	fneg	f3, f3
fle_cont.15984:
	fle	r30, f2, f3
	beq	r0, r30, fle_else.15985
	addi	r1, r0, 0
	jr	r31				#
fle_else.15985:
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
	jal	solver_rect_surface.3010				#	bl	solver_rect_surface.3010
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.15986
	addi	r1, r0, 1
	jr	r31				#
beq_then.15986:
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
	jal	solver_rect_surface.3010				#	bl	solver_rect_surface.3010
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.15987
	addi	r1, r0, 2
	jr	r31				#
beq_then.15987:
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
	jal	solver_rect_surface.3010				#	bl	solver_rect_surface.3010
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.15988
	addi	r1, r0, 3
	jr	r31				#
beq_then.15988:
	addi	r1, r0, 0
	jr	r31				#
solver_surface.3025:
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
	beq	r0, r30, fle_else.15989
	addi	r2, r0, 0
	j	fle_cont.15990
fle_else.15989:
	addi	r2, r0, 1
fle_cont.15990:
	beqi	0, r2, beq_then.15991
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
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.15991:
	addi	r1, r0, 0
	jr	r31				#
quadratic.3031:
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
	beqi	0, r2, beq_then.15992
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
beq_then.15992:
	fadd	f1, f0, f4
	jr	r31				#
bilinear.3036:
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
	beqi	0, r2, beq_then.15993
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
beq_then.15993:
	fadd	f1, f0, f7
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
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	quadratic.3031				#	bl	quadratic.3031
	addi	r3, r3, -9
	lw	r31, 8(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15994
	addi	r1, r0, 1
	j	feq_cont.15995
feq_else.15994:
	addi	r1, r0, 0
feq_cont.15995:
	beqi	0, r1, beq_then.15996
	addi	r1, r0, 0
	jr	r31				#
beq_then.15996:
	lw	r1, 7(r3)
	flw	f2, 0(r1)
	flw	f3, 1(r1)
	flw	f4, 2(r1)
	flw	f5, 4(r3)
	flw	f6, 2(r3)
	flw	f7, 0(r3)
	lw	r1, 6(r3)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	fadd	f4, f0, f5				# fmr	f4, f5
	fadd	f5, f0, f6				# fmr	f5, f6
	fadd	f6, f0, f7				# fmr	f6, f7
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	bilinear.3036				#	bl	bilinear.3036
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 4(r3)
	flw	f3, 2(r3)
	flw	f4, 0(r3)
	lw	r1, 6(r3)
	fsw	f1, 10(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	quadratic.3031				#	bl	quadratic.3031
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.15997
	j	beq_cont.15998
beq_then.15997:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.15998:
	flw	f2, 10(r3)
	fmul	f3, f2, f2
	flw	f4, 8(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15999
	addi	r2, r0, 0
	j	fle_cont.16000
fle_else.15999:
	addi	r2, r0, 1
fle_cont.16000:
	beqi	0, r2, beq_then.16001
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16002
	j	beq_cont.16003
beq_then.16002:
	fneg	f1, f1
beq_cont.16003:
	fsub	f1, f1, f2
	fdiv	f1, f1, f4
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16001:
	addi	r1, r0, 0
	jr	r31				#
solver.3050:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r1
	lw	r1, 0(r30)
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
	lw	r5, 1(r1)
	beqi	1, r5, beq_then.16004
	beqi	2, r5, beq_then.16005
	j	solver_second.3044
beq_then.16005:
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
	beq	r0, r30, fle_else.16006
	addi	r2, r0, 0
	j	fle_cont.16007
fle_else.16006:
	addi	r2, r0, 1
fle_cont.16007:
	beqi	0, r2, beq_then.16008
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
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16008:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16004:
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
	jal	solver_rect_surface.3010				#	bl	solver_rect_surface.3010
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.16009
	addi	r1, r0, 1
	jr	r31				#
beq_then.16009:
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
	jal	solver_rect_surface.3010				#	bl	solver_rect_surface.3010
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.16010
	addi	r1, r0, 2
	jr	r31				#
beq_then.16010:
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
	jal	solver_rect_surface.3010				#	bl	solver_rect_surface.3010
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.16011
	addi	r1, r0, 3
	jr	r31				#
beq_then.16011:
	addi	r1, r0, 0
	jr	r31				#
solver_rect_fast.3054:
	flw	f4, 0(r5)
	fsub	f4, f4, f1
	flw	f5, 1(r5)
	fmul	f4, f4, f5
	lw	r6, 4(r1)
	flw	f5, 1(r6)
	flw	f6, 1(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f2
	fle	r30, f0, f6
	beq	r0, r30, fle_else.16012
	j	fle_cont.16013
fle_else.16012:
	fneg	f6, f6
fle_cont.16013:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16014
	addi	r6, r0, 0
	j	fle_cont.16015
fle_else.16014:
	lw	r6, 4(r1)
	flw	f5, 2(r6)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.16016
	j	fle_cont.16017
fle_else.16016:
	fneg	f6, f6
fle_cont.16017:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16018
	addi	r6, r0, 0
	j	fle_cont.16019
fle_else.16018:
	flw	f5, 1(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16020
	addi	r6, r0, 1
	j	feq_cont.16021
feq_else.16020:
	addi	r6, r0, 0
feq_cont.16021:
	beqi	0, r6, beq_then.16022
	addi	r6, r0, 0
	j	beq_cont.16023
beq_then.16022:
	addi	r6, r0, 1
beq_cont.16023:
fle_cont.16019:
fle_cont.16015:
	beqi	0, r6, beq_then.16024
	fsw	f4, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16024:
	flw	f4, 2(r5)
	fsub	f4, f4, f2
	flw	f5, 3(r5)
	fmul	f4, f4, f5
	lw	r6, 4(r1)
	flw	f5, 0(r6)
	flw	f6, 0(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f1
	fle	r30, f0, f6
	beq	r0, r30, fle_else.16025
	j	fle_cont.16026
fle_else.16025:
	fneg	f6, f6
fle_cont.16026:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16027
	addi	r6, r0, 0
	j	fle_cont.16028
fle_else.16027:
	lw	r6, 4(r1)
	flw	f5, 2(r6)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.16029
	j	fle_cont.16030
fle_else.16029:
	fneg	f6, f6
fle_cont.16030:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16031
	addi	r6, r0, 0
	j	fle_cont.16032
fle_else.16031:
	flw	f5, 3(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16033
	addi	r6, r0, 1
	j	feq_cont.16034
feq_else.16033:
	addi	r6, r0, 0
feq_cont.16034:
	beqi	0, r6, beq_then.16035
	addi	r6, r0, 0
	j	beq_cont.16036
beq_then.16035:
	addi	r6, r0, 1
beq_cont.16036:
fle_cont.16032:
fle_cont.16028:
	beqi	0, r6, beq_then.16037
	fsw	f4, 724(r0)
	addi	r1, r0, 2
	jr	r31				#
beq_then.16037:
	flw	f4, 4(r5)
	fsub	f3, f4, f3
	flw	f4, 5(r5)
	fmul	f3, f3, f4
	lw	r6, 4(r1)
	flw	f4, 0(r6)
	flw	f5, 0(r2)
	fmul	f5, f3, f5
	fadd	f1, f5, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16038
	j	fle_cont.16039
fle_else.16038:
	fneg	f1, f1
fle_cont.16039:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16040
	addi	r1, r0, 0
	j	fle_cont.16041
fle_else.16040:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	flw	f4, 1(r2)
	fmul	f4, f3, f4
	fadd	f2, f4, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16042
	j	fle_cont.16043
fle_else.16042:
	fneg	f2, f2
fle_cont.16043:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16044
	addi	r1, r0, 0
	j	fle_cont.16045
fle_else.16044:
	flw	f1, 5(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16046
	addi	r1, r0, 1
	j	feq_cont.16047
feq_else.16046:
	addi	r1, r0, 0
feq_cont.16047:
	beqi	0, r1, beq_then.16048
	addi	r1, r0, 0
	j	beq_cont.16049
beq_then.16048:
	addi	r1, r0, 1
beq_cont.16049:
fle_cont.16045:
fle_cont.16041:
	beqi	0, r1, beq_then.16050
	fsw	f3, 724(r0)
	addi	r1, r0, 3
	jr	r31				#
beq_then.16050:
	addi	r1, r0, 0
	jr	r31				#
solver_surface_fast.3061:
	flw	f4, 0(r2)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16051
	addi	r1, r0, 0
	j	fle_cont.16052
fle_else.16051:
	addi	r1, r0, 1
fle_cont.16052:
	beqi	0, r1, beq_then.16053
	flw	f4, 1(r2)
	fmul	f1, f4, f1
	flw	f4, 2(r2)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 3(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16053:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3067:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16054
	addi	r5, r0, 1
	j	feq_cont.16055
feq_else.16054:
	addi	r5, r0, 0
feq_cont.16055:
	beqi	0, r5, beq_then.16056
	addi	r1, r0, 0
	jr	r31				#
beq_then.16056:
	flw	f5, 1(r2)
	fmul	f5, f5, f1
	flw	f6, 2(r2)
	fmul	f6, f6, f2
	fadd	f5, f5, f6
	flw	f6, 3(r2)
	fmul	f6, f6, f3
	fadd	f5, f5, f6
	sw	r2, 0(r3)
	fsw	f4, 2(r3)
	fsw	f5, 4(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	quadratic.3031				#	bl	quadratic.3031
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16058
	j	beq_cont.16059
beq_then.16058:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16059:
	flw	f2, 4(r3)
	fmul	f3, f2, f2
	flw	f4, 2(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16060
	addi	r2, r0, 0
	j	fle_cont.16061
fle_else.16060:
	addi	r2, r0, 1
fle_cont.16061:
	beqi	0, r2, beq_then.16062
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16063
	fsqrt	f1, f1
	fadd	f1, f2, f1
	lw	r1, 0(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	j	beq_cont.16064
beq_then.16063:
	fsqrt	f1, f1
	fsub	f1, f2, f1
	lw	r1, 0(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
beq_cont.16064:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16062:
	addi	r1, r0, 0
	jr	r31				#
solver_fast.3073:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r1
	lw	r6, 0(r30)
	flw	f1, 0(r5)
	lw	r7, 5(r6)
	flw	f2, 0(r7)
	fsub	f1, f1, f2
	flw	f2, 1(r5)
	lw	r7, 5(r6)
	flw	f3, 1(r7)
	fsub	f2, f2, f3
	flw	f3, 2(r5)
	lw	r5, 5(r6)
	flw	f4, 2(r5)
	fsub	f3, f3, f4
	lw	r5, 1(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r1, 1(r6)
	beqi	1, r1, beq_then.16065
	beqi	2, r1, beq_then.16066
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	j	solver_second_fast.3067
beq_then.16066:
	flw	f4, 0(r5)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16067
	addi	r1, r0, 0
	j	fle_cont.16068
fle_else.16067:
	addi	r1, r0, 1
fle_cont.16068:
	beqi	0, r1, beq_then.16069
	flw	f4, 1(r5)
	fmul	f1, f4, f1
	flw	f4, 2(r5)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 3(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16069:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16065:
	lw	r2, 0(r2)
	add	r1, r0, r6				# mr	r1, r6
	j	solver_rect_fast.3054
solver_surface_fast2.3077:
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16070
	addi	r1, r0, 0
	j	fle_cont.16071
fle_else.16070:
	addi	r1, r0, 1
fle_cont.16071:
	beqi	0, r1, beq_then.16072
	flw	f1, 0(r2)
	flw	f2, 3(r5)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16072:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3084:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16073
	addi	r6, r0, 1
	j	feq_cont.16074
feq_else.16073:
	addi	r6, r0, 0
feq_cont.16074:
	beqi	0, r6, beq_then.16075
	addi	r1, r0, 0
	jr	r31				#
beq_then.16075:
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
	beq	r0, r30, fle_else.16076
	addi	r5, r0, 0
	j	fle_cont.16077
fle_else.16076:
	addi	r5, r0, 1
fle_cont.16077:
	beqi	0, r5, beq_then.16078
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16079
	fsqrt	f2, f2
	fadd	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	j	beq_cont.16080
beq_then.16079:
	fsqrt	f2, f2
	fsub	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
beq_cont.16080:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16078:
	addi	r1, r0, 0
	jr	r31				#
solver_fast2.3091:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r6, 10(r5)
	flw	f1, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 2(r6)
	lw	r7, 1(r2)
	add	r30, r7, r1
	lw	r1, 0(r30)
	lw	r7, 1(r5)
	beqi	1, r7, beq_then.16081
	beqi	2, r7, beq_then.16082
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	j	solver_second_fast2.3084
beq_then.16082:
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16083
	addi	r2, r0, 0
	j	fle_cont.16084
fle_else.16083:
	addi	r2, r0, 1
fle_cont.16084:
	beqi	0, r2, beq_then.16085
	flw	f1, 0(r1)
	flw	f2, 3(r6)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16085:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16081:
	lw	r2, 0(r2)
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r1				# mr	r5, r1
	add	r1, r0, r28				# mr	r1, r28
	j	solver_rect_fast.3054
setup_rect_table.3094:
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
	beq	r0, r30, feq_else.16086
	addi	r5, r0, 1
	j	feq_cont.16087
feq_else.16086:
	addi	r5, r0, 0
feq_cont.16087:
	beqi	0, r5, beq_then.16088
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 1(r1)
	j	beq_cont.16089
beq_then.16088:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16090
	addi	r7, r0, 0
	j	fle_cont.16091
fle_else.16090:
	addi	r7, r0, 1
fle_cont.16091:
	beqi	0, r6, beq_then.16092
	beqi	0, r7, beq_then.16094
	addi	r6, r0, 0
	j	beq_cont.16095
beq_then.16094:
	addi	r6, r0, 1
beq_cont.16095:
	j	beq_cont.16093
beq_then.16092:
	add	r6, r0, r7
beq_cont.16093:
	lw	r7, 4(r5)
	flw	f1, 0(r7)
	beqi	0, r6, beq_then.16096
	j	beq_cont.16097
beq_then.16096:
	fneg	f1, f1
beq_cont.16097:
	fsw	f1, 0(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r2)
	fdiv	f1, f1, f2
	fsw	f1, 1(r1)
beq_cont.16089:
	flw	f1, 1(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16098
	addi	r5, r0, 1
	j	feq_cont.16099
feq_else.16098:
	addi	r5, r0, 0
feq_cont.16099:
	beqi	0, r5, beq_then.16100
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 3(r1)
	j	beq_cont.16101
beq_then.16100:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 1(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16102
	addi	r7, r0, 0
	j	fle_cont.16103
fle_else.16102:
	addi	r7, r0, 1
fle_cont.16103:
	beqi	0, r6, beq_then.16104
	beqi	0, r7, beq_then.16106
	addi	r6, r0, 0
	j	beq_cont.16107
beq_then.16106:
	addi	r6, r0, 1
beq_cont.16107:
	j	beq_cont.16105
beq_then.16104:
	add	r6, r0, r7
beq_cont.16105:
	lw	r7, 4(r5)
	flw	f1, 1(r7)
	beqi	0, r6, beq_then.16108
	j	beq_cont.16109
beq_then.16108:
	fneg	f1, f1
beq_cont.16109:
	fsw	f1, 2(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 1(r2)
	fdiv	f1, f1, f2
	fsw	f1, 3(r1)
beq_cont.16101:
	flw	f1, 2(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16110
	addi	r5, r0, 1
	j	feq_cont.16111
feq_else.16110:
	addi	r5, r0, 0
feq_cont.16111:
	beqi	0, r5, beq_then.16112
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 5(r1)
	j	beq_cont.16113
beq_then.16112:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 2(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16114
	addi	r7, r0, 0
	j	fle_cont.16115
fle_else.16114:
	addi	r7, r0, 1
fle_cont.16115:
	beqi	0, r6, beq_then.16116
	beqi	0, r7, beq_then.16118
	addi	r6, r0, 0
	j	beq_cont.16119
beq_then.16118:
	addi	r6, r0, 1
beq_cont.16119:
	j	beq_cont.16117
beq_then.16116:
	add	r6, r0, r7
beq_cont.16117:
	lw	r5, 4(r5)
	flw	f1, 2(r5)
	beqi	0, r6, beq_then.16120
	j	beq_cont.16121
beq_then.16120:
	fneg	f1, f1
beq_cont.16121:
	fsw	f1, 4(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 2(r2)
	fdiv	f1, f1, f2
	fsw	f1, 5(r1)
beq_cont.16113:
	jr	r31				#
setup_surface_table.3097:
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
	beq	r0, r30, fle_else.16122
	addi	r2, r0, 0
	j	fle_cont.16123
fle_else.16122:
	addi	r2, r0, 1
fle_cont.16123:
	beqi	0, r2, beq_then.16124
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
	j	beq_cont.16125
beq_then.16124:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
beq_cont.16125:
	jr	r31				#
setup_second_table.3100:
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
	jal	quadratic.3031				#	bl	quadratic.3031
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
	beqi	0, r6, beq_then.16126
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
	j	beq_cont.16127
beq_then.16126:
	fsw	f2, 1(r5)
	fsw	f3, 2(r5)
	fsw	f4, 3(r5)
beq_cont.16127:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16128
	addi	r1, r0, 1
	j	feq_cont.16129
feq_else.16128:
	addi	r1, r0, 0
feq_cont.16129:
	beqi	0, r1, beq_then.16130
	j	beq_cont.16131
beq_then.16130:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
	fsw	f1, 4(r5)
beq_cont.16131:
	add	r1, r0, r5
	jr	r31				#
iter_setup_dirvec_constants.3103:
	bgei	0, r2, bge_then.16132
	jr	r31				#
bge_then.16132:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 1(r1)
	lw	r7, 0(r1)
	lw	r8, 1(r5)
	sw	r1, 0(r3)
	beqi	1, r8, beq_then.16134
	beqi	2, r8, beq_then.16136
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16137
beq_then.16136:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16137:
	j	beq_cont.16135
beq_then.16134:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16135:
	addi	r1, r2, -1
	bgei	0, r1, bge_then.16138
	jr	r31				#
bge_then.16138:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 0(r3)
	lw	r6, 1(r5)
	lw	r7, 0(r5)
	lw	r8, 1(r2)
	beqi	1, r8, beq_then.16140
	beqi	2, r8, beq_then.16142
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16143
beq_then.16142:
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16143:
	j	beq_cont.16141
beq_then.16140:
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16141:
	addi	r2, r2, -1
	lw	r1, 0(r3)
	j	iter_setup_dirvec_constants.3103
setup_dirvec_constants.3106:
	lw	r2, 0(r0)
	addi	r2, r2, -1
	bgei	0, r2, bge_then.16144
	jr	r31				#
bge_then.16144:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 1(r1)
	lw	r7, 0(r1)
	lw	r8, 1(r5)
	sw	r1, 0(r3)
	beqi	1, r8, beq_then.16146
	beqi	2, r8, beq_then.16148
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16149
beq_then.16148:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16149:
	j	beq_cont.16147
beq_then.16146:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16147:
	addi	r2, r2, -1
	lw	r1, 0(r3)
	j	iter_setup_dirvec_constants.3103
setup_startp_constants.3108:
	bgei	0, r2, bge_then.16150
	jr	r31				#
bge_then.16150:
	addi	r5, r0, 1				# set min_caml_objects
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
	sw	r2, 1(r3)
	beqi	2, r7, beq_then.16152
	blei	2, r7, ble_then.16154
	flw	f1, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 2(r6)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	quadratic.3031				#	bl	quadratic.3031
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	beqi	3, r1, beq_then.16156
	j	beq_cont.16157
beq_then.16156:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16157:
	lw	r1, 2(r3)
	fsw	f1, 3(r1)
	j	ble_cont.16155
ble_then.16154:
ble_cont.16155:
	j	beq_cont.16153
beq_then.16152:
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
beq_cont.16153:
	lw	r1, 1(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	j	setup_startp_constants.3108
setup_startp.3111:
	flw	f1, 0(r1)
	fsw	f1, 751(r0)
	flw	f1, 1(r1)
	fsw	f1, 752(r0)
	flw	f1, 2(r1)
	fsw	f1, 753(r0)
	lw	r2, 0(r0)
	addi	r2, r2, -1
	j	setup_startp_constants.3108
is_rect_outside.3113:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16158
	j	fle_cont.16159
fle_else.16158:
	fneg	f1, f1
fle_cont.16159:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16160
	addi	r2, r0, 0
	j	fle_cont.16161
fle_else.16160:
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16162
	j	fle_cont.16163
fle_else.16162:
	fneg	f2, f2
fle_cont.16163:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16164
	addi	r2, r0, 0
	j	fle_cont.16165
fle_else.16164:
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16166
	fadd	f2, f0, f3
	j	fle_cont.16167
fle_else.16166:
	fneg	f2, f3
fle_cont.16167:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16168
	addi	r2, r0, 0
	j	fle_cont.16169
fle_else.16168:
	addi	r2, r0, 1
fle_cont.16169:
fle_cont.16165:
fle_cont.16161:
	beqi	0, r2, beq_then.16170
	lw	r1, 6(r1)
	jr	r31				#
beq_then.16170:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16171
	addi	r1, r0, 0
	jr	r31				#
beq_then.16171:
	addi	r1, r0, 1
	jr	r31				#
is_plane_outside.3118:
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
	beq	r0, r30, fle_else.16172
	addi	r2, r0, 0
	j	fle_cont.16173
fle_else.16172:
	addi	r2, r0, 1
fle_cont.16173:
	beqi	0, r1, beq_then.16174
	beqi	0, r2, beq_then.16176
	addi	r1, r0, 0
	j	beq_cont.16177
beq_then.16176:
	addi	r1, r0, 1
beq_cont.16177:
	j	beq_cont.16175
beq_then.16174:
	add	r1, r0, r2
beq_cont.16175:
	beqi	0, r1, beq_then.16178
	addi	r1, r0, 0
	jr	r31				#
beq_then.16178:
	addi	r1, r0, 1
	jr	r31				#
is_second_outside.3123:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3031				#	bl	quadratic.3031
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16179
	j	beq_cont.16180
beq_then.16179:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16180:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16181
	addi	r2, r0, 0
	j	fle_cont.16182
fle_else.16181:
	addi	r2, r0, 1
fle_cont.16182:
	beqi	0, r1, beq_then.16183
	beqi	0, r2, beq_then.16185
	addi	r1, r0, 0
	j	beq_cont.16186
beq_then.16185:
	addi	r1, r0, 1
beq_cont.16186:
	j	beq_cont.16184
beq_then.16183:
	add	r1, r0, r2
beq_cont.16184:
	beqi	0, r1, beq_then.16187
	addi	r1, r0, 0
	jr	r31				#
beq_then.16187:
	addi	r1, r0, 1
	jr	r31				#
is_outside.3128:
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
	beqi	1, r2, beq_then.16188
	beqi	2, r2, beq_then.16189
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3031				#	bl	quadratic.3031
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16190
	j	beq_cont.16191
beq_then.16190:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16191:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16192
	addi	r2, r0, 0
	j	fle_cont.16193
fle_else.16192:
	addi	r2, r0, 1
fle_cont.16193:
	beqi	0, r1, beq_then.16194
	beqi	0, r2, beq_then.16196
	addi	r1, r0, 0
	j	beq_cont.16197
beq_then.16196:
	addi	r1, r0, 1
beq_cont.16197:
	j	beq_cont.16195
beq_then.16194:
	add	r1, r0, r2
beq_cont.16195:
	beqi	0, r1, beq_then.16198
	addi	r1, r0, 0
	jr	r31				#
beq_then.16198:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16189:
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
	beq	r0, r30, fle_else.16199
	addi	r2, r0, 0
	j	fle_cont.16200
fle_else.16199:
	addi	r2, r0, 1
fle_cont.16200:
	beqi	0, r1, beq_then.16201
	beqi	0, r2, beq_then.16203
	addi	r1, r0, 0
	j	beq_cont.16204
beq_then.16203:
	addi	r1, r0, 1
beq_cont.16204:
	j	beq_cont.16202
beq_then.16201:
	add	r1, r0, r2
beq_cont.16202:
	beqi	0, r1, beq_then.16205
	addi	r1, r0, 0
	jr	r31				#
beq_then.16205:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16188:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16206
	j	fle_cont.16207
fle_else.16206:
	fneg	f1, f1
fle_cont.16207:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16208
	addi	r2, r0, 0
	j	fle_cont.16209
fle_else.16208:
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16210
	j	fle_cont.16211
fle_else.16210:
	fneg	f2, f2
fle_cont.16211:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16212
	addi	r2, r0, 0
	j	fle_cont.16213
fle_else.16212:
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16214
	fadd	f2, f0, f3
	j	fle_cont.16215
fle_else.16214:
	fneg	f2, f3
fle_cont.16215:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16216
	addi	r2, r0, 0
	j	fle_cont.16217
fle_else.16216:
	addi	r2, r0, 1
fle_cont.16217:
fle_cont.16213:
fle_cont.16209:
	beqi	0, r2, beq_then.16218
	lw	r1, 6(r1)
	jr	r31				#
beq_then.16218:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16219
	addi	r1, r0, 0
	jr	r31				#
beq_then.16219:
	addi	r1, r0, 1
	jr	r31				#
check_all_inside.3133:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16220
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r5, 0(r30)
	lw	r6, 5(r5)
	flw	f4, 0(r6)
	fsub	f4, f1, f4
	lw	r6, 5(r5)
	flw	f5, 1(r6)
	fsub	f5, f2, f5
	lw	r6, 5(r5)
	flw	f6, 2(r6)
	fsub	f6, f3, f6
	lw	r6, 1(r5)
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	beqi	1, r6, beq_then.16221
	beqi	2, r6, beq_then.16223
	sw	r5, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	quadratic.3031				#	bl	quadratic.3031
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 8(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16225
	j	beq_cont.16226
beq_then.16225:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16226:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16227
	addi	r2, r0, 0
	j	fle_cont.16228
fle_else.16227:
	addi	r2, r0, 1
fle_cont.16228:
	beqi	0, r1, beq_then.16229
	beqi	0, r2, beq_then.16231
	addi	r1, r0, 0
	j	beq_cont.16232
beq_then.16231:
	addi	r1, r0, 1
beq_cont.16232:
	j	beq_cont.16230
beq_then.16229:
	add	r1, r0, r2
beq_cont.16230:
	beqi	0, r1, beq_then.16233
	addi	r1, r0, 0
	j	beq_cont.16234
beq_then.16233:
	addi	r1, r0, 1
beq_cont.16234:
	j	beq_cont.16224
beq_then.16223:
	lw	r6, 4(r5)
	flw	f7, 0(r6)
	fmul	f4, f7, f4
	flw	f7, 1(r6)
	fmul	f5, f7, f5
	fadd	f4, f4, f5
	flw	f5, 2(r6)
	fmul	f5, f5, f6
	fadd	f4, f4, f5
	lw	r5, 6(r5)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16235
	addi	r6, r0, 0
	j	fle_cont.16236
fle_else.16235:
	addi	r6, r0, 1
fle_cont.16236:
	beqi	0, r5, beq_then.16237
	beqi	0, r6, beq_then.16239
	addi	r5, r0, 0
	j	beq_cont.16240
beq_then.16239:
	addi	r5, r0, 1
beq_cont.16240:
	j	beq_cont.16238
beq_then.16237:
	add	r5, r0, r6
beq_cont.16238:
	beqi	0, r5, beq_then.16241
	addi	r1, r0, 0
	j	beq_cont.16242
beq_then.16241:
	addi	r1, r0, 1
beq_cont.16242:
beq_cont.16224:
	j	beq_cont.16222
beq_then.16221:
	add	r1, r0, r5				# mr	r1, r5
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	is_rect_outside.3113				#	bl	is_rect_outside.3113
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.16222:
	beqi	0, r1, beq_then.16243
	addi	r1, r0, 0
	jr	r31				#
beq_then.16243:
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 6(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16244
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r5, 0(r30)
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	sw	r1, 9(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	is_outside.3128				#	bl	is_outside.3128
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.16245
	addi	r1, r0, 0
	jr	r31				#
beq_then.16245:
	lw	r1, 9(r3)
	addi	r1, r1, 1
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r2, 6(r3)
	j	check_all_inside.3133
beq_then.16244:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16220:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3139:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16246
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 1021				# set min_caml_light_dirvec
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r5
	lw	r7, 0(r30)
	flw	f1, 727(r0)
	lw	r8, 5(r7)
	flw	f2, 0(r8)
	fsub	f1, f1, f2
	flw	f2, 728(r0)
	lw	r8, 5(r7)
	flw	f3, 1(r8)
	fsub	f2, f2, f3
	flw	f3, 729(r0)
	lw	r8, 5(r7)
	flw	f4, 2(r8)
	fsub	f3, f3, f4
	lw	r8, 1(r6)
	add	r30, r8, r5
	lw	r8, 0(r30)
	lw	r9, 1(r7)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	beqi	1, r9, beq_then.16247
	beqi	2, r9, beq_then.16249
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_second_fast.3067				#	bl	solver_second_fast.3067
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16250
beq_then.16249:
	flw	f4, 0(r8)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16251
	addi	r6, r0, 0
	j	fle_cont.16252
fle_else.16251:
	addi	r6, r0, 1
fle_cont.16252:
	beqi	0, r6, beq_then.16253
	flw	f4, 1(r8)
	fmul	f1, f4, f1
	flw	f4, 2(r8)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 3(r8)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	j	beq_cont.16254
beq_then.16253:
	addi	r1, r0, 0
beq_cont.16254:
beq_cont.16250:
	j	beq_cont.16248
beq_then.16247:
	lw	r6, 0(r6)
	add	r5, r0, r8				# mr	r5, r8
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_rect_fast.3054				#	bl	solver_rect_fast.3054
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16248:
	flw	f1, 724(r0)
	beqi	0, r1, beq_then.16255
	flup	f2, 28		# fli	f2, -0.200000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16257
	addi	r1, r0, 0
	j	fle_cont.16258
fle_else.16257:
	addi	r1, r0, 1
fle_cont.16258:
	j	beq_cont.16256
beq_then.16255:
	addi	r1, r0, 0
beq_cont.16256:
	beqi	0, r1, beq_then.16259
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	flw	f2, 667(r0)
	fmul	f2, f2, f1
	flw	f3, 727(r0)
	fadd	f2, f2, f3
	flw	f3, 668(r0)
	fmul	f3, f3, f1
	flw	f4, 728(r0)
	fadd	f3, f3, f4
	flw	f4, 669(r0)
	fmul	f1, f4, f1
	flw	f4, 729(r0)
	fadd	f1, f1, f4
	lw	r2, 0(r3)
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.16260
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r1
	lw	r1, 0(r30)
	fsw	f1, 4(r3)
	fsw	f3, 6(r3)
	fsw	f2, 8(r3)
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	is_outside.3128				#	bl	is_outside.3128
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.16263
	addi	r1, r0, 0
	j	beq_cont.16264
beq_then.16263:
	addi	r1, r0, 1
	flw	f1, 8(r3)
	flw	f2, 6(r3)
	flw	f3, 4(r3)
	lw	r2, 0(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	check_all_inside.3133				#	bl	check_all_inside.3133
	addi	r3, r3, -11
	lw	r31, 10(r3)
beq_cont.16264:
	j	beq_cont.16261
beq_then.16260:
	addi	r1, r0, 1
beq_cont.16261:
	beqi	0, r1, beq_then.16265
	addi	r1, r0, 1
	jr	r31				#
beq_then.16265:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_and_group.3139
beq_then.16259:
	addi	r1, r0, 1				# set min_caml_objects
	lw	r2, 2(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16266
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_and_group.3139
beq_then.16266:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16246:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3142:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16267
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	shadow_check_and_group.3139				#	bl	shadow_check_and_group.3139
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.16268
	addi	r1, r0, 1
	jr	r31				#
beq_then.16268:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16269
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	sw	r1, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				#	bl	shadow_check_and_group.3139
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16270
	addi	r1, r0, 1
	jr	r31				#
beq_then.16270:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16271
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	sw	r1, 3(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_and_group.3139				#	bl	shadow_check_and_group.3139
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.16272
	addi	r1, r0, 1
	jr	r31				#
beq_then.16272:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16273
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	sw	r1, 4(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	shadow_check_and_group.3139				#	bl	shadow_check_and_group.3139
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.16274
	addi	r1, r0, 1
	jr	r31				#
beq_then.16274:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_one_or_group.3142
beq_then.16273:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16271:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16269:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16267:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3145:
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16275
	addi	r7, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r6, r7, beq_then.16276
	addi	r7, r0, 1021				# set min_caml_light_dirvec
	addi	r8, r0, 1				# set min_caml_objects
	add	r30, r8, r6
	lw	r8, 0(r30)
	flw	f1, 727(r0)
	lw	r9, 5(r8)
	flw	f2, 0(r9)
	fsub	f1, f1, f2
	flw	f2, 728(r0)
	lw	r9, 5(r8)
	flw	f3, 1(r9)
	fsub	f2, f2, f3
	flw	f3, 729(r0)
	lw	r9, 5(r8)
	flw	f4, 2(r9)
	fsub	f3, f3, f4
	lw	r9, 1(r7)
	add	r30, r9, r6
	lw	r6, 0(r30)
	lw	r9, 1(r8)
	beqi	1, r9, beq_then.16278
	beqi	2, r9, beq_then.16280
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_second_fast.3067				#	bl	solver_second_fast.3067
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16281
beq_then.16280:
	flw	f4, 0(r6)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16282
	addi	r7, r0, 0
	j	fle_cont.16283
fle_else.16282:
	addi	r7, r0, 1
fle_cont.16283:
	beqi	0, r7, beq_then.16284
	flw	f4, 1(r6)
	fmul	f1, f4, f1
	flw	f4, 2(r6)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 3(r6)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	j	beq_cont.16285
beq_then.16284:
	addi	r1, r0, 0
beq_cont.16285:
beq_cont.16281:
	j	beq_cont.16279
beq_then.16278:
	lw	r7, 0(r7)
	add	r5, r0, r6				# mr	r5, r6
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_rect_fast.3054				#	bl	solver_rect_fast.3054
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16279:
	beqi	0, r1, beq_then.16286
	flup	f1, 30		# fli	f1, -0.100000
	flw	f2, 724(r0)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16288
	addi	r1, r0, 0
	j	fle_cont.16289
fle_else.16288:
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16290
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				#	bl	shadow_check_and_group.3139
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16292
	addi	r1, r0, 1
	j	beq_cont.16293
beq_then.16292:
	lw	r1, 0(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16294
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				#	bl	shadow_check_and_group.3139
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16296
	addi	r1, r0, 1
	j	beq_cont.16297
beq_then.16296:
	lw	r1, 0(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16298
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				#	bl	shadow_check_and_group.3139
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16300
	addi	r1, r0, 1
	j	beq_cont.16301
beq_then.16300:
	addi	r1, r0, 4
	lw	r2, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_one_or_group.3142				#	bl	shadow_check_one_or_group.3142
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16301:
	j	beq_cont.16299
beq_then.16298:
	addi	r1, r0, 0
beq_cont.16299:
beq_cont.16297:
	j	beq_cont.16295
beq_then.16294:
	addi	r1, r0, 0
beq_cont.16295:
beq_cont.16293:
	j	beq_cont.16291
beq_then.16290:
	addi	r1, r0, 0
beq_cont.16291:
	beqi	0, r1, beq_then.16302
	addi	r1, r0, 1
	j	beq_cont.16303
beq_then.16302:
	addi	r1, r0, 0
beq_cont.16303:
fle_cont.16289:
	j	beq_cont.16287
beq_then.16286:
	addi	r1, r0, 0
beq_cont.16287:
	j	beq_cont.16277
beq_then.16276:
	addi	r1, r0, 1
beq_cont.16277:
	beqi	0, r1, beq_then.16304
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16305
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				#	bl	shadow_check_and_group.3139
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16307
	addi	r1, r0, 1
	j	beq_cont.16308
beq_then.16307:
	lw	r1, 0(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16309
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				#	bl	shadow_check_and_group.3139
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16311
	addi	r1, r0, 1
	j	beq_cont.16312
beq_then.16311:
	lw	r1, 0(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16313
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				#	bl	shadow_check_and_group.3139
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16315
	addi	r1, r0, 1
	j	beq_cont.16316
beq_then.16315:
	addi	r1, r0, 4
	lw	r2, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_one_or_group.3142				#	bl	shadow_check_one_or_group.3142
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16316:
	j	beq_cont.16314
beq_then.16313:
	addi	r1, r0, 0
beq_cont.16314:
beq_cont.16312:
	j	beq_cont.16310
beq_then.16309:
	addi	r1, r0, 0
beq_cont.16310:
beq_cont.16308:
	j	beq_cont.16306
beq_then.16305:
	addi	r1, r0, 0
beq_cont.16306:
	beqi	0, r1, beq_then.16317
	addi	r1, r0, 1
	jr	r31				#
beq_then.16317:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	j	shadow_check_one_or_matrix.3145
beq_then.16304:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	j	shadow_check_one_or_matrix.3145
beq_then.16275:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3148:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.16318
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	flw	f1, 748(r0)
	lw	r8, 5(r7)
	flw	f2, 0(r8)
	fsub	f1, f1, f2
	flw	f2, 749(r0)
	lw	r8, 5(r7)
	flw	f3, 1(r8)
	fsub	f2, f2, f3
	flw	f3, 750(r0)
	lw	r8, 5(r7)
	flw	f4, 2(r8)
	fsub	f3, f3, f4
	lw	r8, 1(r7)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r6, 3(r3)
	beqi	1, r8, beq_then.16319
	beqi	2, r8, beq_then.16321
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second.3044				#	bl	solver_second.3044
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16322
beq_then.16321:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_surface.3025				#	bl	solver_surface.3025
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16322:
	j	beq_cont.16320
beq_then.16319:
	addi	r8, r0, 0
	addi	r9, r0, 1
	addi	r10, r0, 2
	fsw	f1, 4(r3)
	fsw	f3, 6(r3)
	fsw	f2, 8(r3)
	sw	r7, 10(r3)
	add	r6, r0, r9				# mr	r6, r9
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r7, r0, r10				# mr	r7, r10
	add	r5, r0, r8				# mr	r5, r8
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solver_rect_surface.3010				#	bl	solver_rect_surface.3010
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16323
	addi	r1, r0, 1
	j	beq_cont.16324
beq_then.16323:
	addi	r5, r0, 1
	addi	r6, r0, 2
	addi	r7, r0, 0
	flw	f1, 8(r3)
	flw	f2, 6(r3)
	flw	f3, 4(r3)
	lw	r1, 10(r3)
	lw	r2, 0(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solver_rect_surface.3010				#	bl	solver_rect_surface.3010
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16325
	addi	r1, r0, 2
	j	beq_cont.16326
beq_then.16325:
	addi	r5, r0, 2
	addi	r6, r0, 0
	addi	r7, r0, 1
	flw	f1, 6(r3)
	flw	f2, 4(r3)
	flw	f3, 8(r3)
	lw	r1, 10(r3)
	lw	r2, 0(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solver_rect_surface.3010				#	bl	solver_rect_surface.3010
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16327
	addi	r1, r0, 3
	j	beq_cont.16328
beq_then.16327:
	addi	r1, r0, 0
beq_cont.16328:
beq_cont.16326:
beq_cont.16324:
beq_cont.16320:
	beqi	0, r1, beq_then.16329
	flw	f1, 724(r0)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16330
	j	fle_cont.16331
fle_else.16330:
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16332
	j	fle_cont.16333
fle_else.16332:
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	lw	r5, 0(r3)
	flw	f2, 0(r5)
	fmul	f2, f2, f1
	flw	f3, 748(r0)
	fadd	f2, f2, f3
	flw	f3, 1(r5)
	fmul	f3, f3, f1
	flw	f4, 749(r0)
	fadd	f3, f3, f4
	flw	f4, 2(r5)
	fmul	f4, f4, f1
	flw	f5, 750(r0)
	fadd	f4, f4, f5
	lw	r2, 1(r3)
	lw	r6, 0(r2)
	sw	r1, 11(r3)
	fsw	f4, 12(r3)
	fsw	f3, 14(r3)
	fsw	f2, 16(r3)
	fsw	f1, 18(r3)
	beqi	-1, r6, beq_then.16334
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r6, 0(r30)
	add	r1, r0, r6				# mr	r1, r6
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	is_outside.3128				#	bl	is_outside.3128
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.16336
	addi	r1, r0, 0
	j	beq_cont.16337
beq_then.16336:
	addi	r1, r0, 1
	flw	f1, 16(r3)
	flw	f2, 14(r3)
	flw	f3, 12(r3)
	lw	r2, 1(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	check_all_inside.3133				#	bl	check_all_inside.3133
	addi	r3, r3, -21
	lw	r31, 20(r3)
beq_cont.16337:
	j	beq_cont.16335
beq_then.16334:
	addi	r1, r0, 1
beq_cont.16335:
	beqi	0, r1, beq_then.16338
	flw	f1, 18(r3)
	fsw	f1, 726(r0)
	flw	f1, 16(r3)
	fsw	f1, 727(r0)
	flw	f1, 14(r3)
	fsw	f1, 728(r0)
	flw	f1, 12(r3)
	fsw	f1, 729(r0)
	lw	r1, 3(r3)
	sw	r1, 730(r0)
	lw	r1, 11(r3)
	sw	r1, 725(r0)
	j	beq_cont.16339
beq_then.16338:
beq_cont.16339:
fle_cont.16333:
fle_cont.16331:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3148
beq_then.16329:
	addi	r1, r0, 1				# set min_caml_objects
	lw	r2, 3(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16340
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3148
beq_then.16340:
	jr	r31				#
beq_then.16318:
	jr	r31				#
solve_one_or_network.3152:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.16343
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16344
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	sw	r1, 3(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16345
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	sw	r1, 4(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16346
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	sw	r1, 5(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_one_or_network.3152
beq_then.16346:
	jr	r31				#
beq_then.16345:
	jr	r31				#
beq_then.16344:
	jr	r31				#
beq_then.16343:
	jr	r31				#
trace_or_matrix.3156:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.16351
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.16352
	addi	r8, r0, 1				# set min_caml_objects
	add	r30, r8, r7
	lw	r7, 0(r30)
	flw	f1, 748(r0)
	lw	r8, 5(r7)
	flw	f2, 0(r8)
	fsub	f1, f1, f2
	flw	f2, 749(r0)
	lw	r8, 5(r7)
	flw	f3, 1(r8)
	fsub	f2, f2, f3
	flw	f3, 750(r0)
	lw	r8, 5(r7)
	flw	f4, 2(r8)
	fsub	f3, f3, f4
	lw	r8, 1(r7)
	sw	r6, 3(r3)
	beqi	1, r8, beq_then.16354
	beqi	2, r8, beq_then.16356
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second.3044				#	bl	solver_second.3044
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16357
beq_then.16356:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_surface.3025				#	bl	solver_surface.3025
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16357:
	j	beq_cont.16355
beq_then.16354:
	addi	r8, r0, 0
	addi	r9, r0, 1
	addi	r10, r0, 2
	fsw	f1, 4(r3)
	fsw	f3, 6(r3)
	fsw	f2, 8(r3)
	sw	r7, 10(r3)
	add	r6, r0, r9				# mr	r6, r9
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r7, r0, r10				# mr	r7, r10
	add	r5, r0, r8				# mr	r5, r8
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solver_rect_surface.3010				#	bl	solver_rect_surface.3010
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16358
	addi	r1, r0, 1
	j	beq_cont.16359
beq_then.16358:
	addi	r5, r0, 1
	addi	r6, r0, 2
	addi	r7, r0, 0
	flw	f1, 8(r3)
	flw	f2, 6(r3)
	flw	f3, 4(r3)
	lw	r1, 10(r3)
	lw	r2, 0(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solver_rect_surface.3010				#	bl	solver_rect_surface.3010
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16360
	addi	r1, r0, 2
	j	beq_cont.16361
beq_then.16360:
	addi	r5, r0, 2
	addi	r6, r0, 0
	addi	r7, r0, 1
	flw	f1, 6(r3)
	flw	f2, 4(r3)
	flw	f3, 8(r3)
	lw	r1, 10(r3)
	lw	r2, 0(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solver_rect_surface.3010				#	bl	solver_rect_surface.3010
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16362
	addi	r1, r0, 3
	j	beq_cont.16363
beq_then.16362:
	addi	r1, r0, 0
beq_cont.16363:
beq_cont.16361:
beq_cont.16359:
beq_cont.16355:
	beqi	0, r1, beq_then.16364
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16366
	j	fle_cont.16367
fle_else.16366:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16368
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16370
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16372
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_one_or_network.3152				#	bl	solve_one_or_network.3152
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.16373
beq_then.16372:
beq_cont.16373:
	j	beq_cont.16371
beq_then.16370:
beq_cont.16371:
	j	beq_cont.16369
beq_then.16368:
beq_cont.16369:
fle_cont.16367:
	j	beq_cont.16365
beq_then.16364:
beq_cont.16365:
	j	beq_cont.16353
beq_then.16352:
	lw	r7, 1(r6)
	beqi	-1, r7, beq_then.16374
	addi	r8, r0, 672				# set min_caml_and_net
	add	r30, r8, r7
	lw	r7, 0(r30)
	addi	r8, r0, 0
	sw	r6, 3(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16376
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16378
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_one_or_network.3152				#	bl	solve_one_or_network.3152
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.16379
beq_then.16378:
beq_cont.16379:
	j	beq_cont.16377
beq_then.16376:
beq_cont.16377:
	j	beq_cont.16375
beq_then.16374:
beq_cont.16375:
beq_cont.16353:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16380
	addi	r7, r0, 99
	sw	r1, 11(r3)
	beq	r6, r7, beq_then.16381
	addi	r7, r0, 748				# set min_caml_startp
	lw	r8, 0(r3)
	sw	r5, 12(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solver.3050				#	bl	solver.3050
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.16383
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16385
	j	fle_cont.16386
fle_else.16385:
	lw	r1, 12(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16387
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 12(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16389
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r1, r0, 3
	lw	r2, 12(r3)
	lw	r5, 0(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_one_or_network.3152				#	bl	solve_one_or_network.3152
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.16390
beq_then.16389:
beq_cont.16390:
	j	beq_cont.16388
beq_then.16387:
beq_cont.16388:
fle_cont.16386:
	j	beq_cont.16384
beq_then.16383:
beq_cont.16384:
	j	beq_cont.16382
beq_then.16381:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16391
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	lw	r8, 0(r3)
	sw	r5, 12(r3)
	add	r5, r0, r8				# mr	r5, r8
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 12(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16393
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r1, r0, 3
	lw	r2, 12(r3)
	lw	r5, 0(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_one_or_network.3152				#	bl	solve_one_or_network.3152
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.16394
beq_then.16393:
beq_cont.16394:
	j	beq_cont.16392
beq_then.16391:
beq_cont.16392:
beq_cont.16382:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix.3156
beq_then.16380:
	jr	r31				#
beq_then.16351:
	jr	r31				#
judge_intersection.3160:
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 726(r0)
	lw	r2, 723(r0)
	lw	r5, 0(r2)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16397
	addi	r7, r0, 99
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	beq	r6, r7, beq_then.16399
	addi	r7, r0, 748				# set min_caml_startp
	sw	r5, 2(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver.3050				#	bl	solver.3050
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16401
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16403
	j	fle_cont.16404
fle_else.16403:
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16405
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16407
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network.3152				#	bl	solve_one_or_network.3152
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16408
beq_then.16407:
beq_cont.16408:
	j	beq_cont.16406
beq_then.16405:
beq_cont.16406:
fle_cont.16404:
	j	beq_cont.16402
beq_then.16401:
beq_cont.16402:
	j	beq_cont.16400
beq_then.16399:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16409
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r5, 2(r3)
	add	r5, r0, r1				# mr	r5, r1
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16411
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				#	bl	solve_each_element.3148
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network.3152				#	bl	solve_one_or_network.3152
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16412
beq_then.16411:
beq_cont.16412:
	j	beq_cont.16410
beq_then.16409:
beq_cont.16410:
beq_cont.16400:
	addi	r1, r0, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix.3156				#	bl	trace_or_matrix.3156
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16398
beq_then.16397:
beq_cont.16398:
	flw	f1, 726(r0)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16413
	addi	r1, r0, 0
	jr	r31				#
fle_else.16413:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16414
	addi	r1, r0, 0
	jr	r31				#
fle_else.16414:
	addi	r1, r0, 1
	jr	r31				#
solve_each_element_fast.3162:
	lw	r6, 0(r5)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.16415
	addi	r8, r0, 1				# set min_caml_objects
	add	r30, r8, r7
	lw	r8, 0(r30)
	lw	r9, 10(r8)
	flw	f1, 0(r9)
	flw	f2, 1(r9)
	flw	f3, 2(r9)
	lw	r10, 1(r5)
	add	r30, r10, r7
	lw	r10, 0(r30)
	lw	r11, 1(r8)
	sw	r6, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	sw	r7, 4(r3)
	beqi	1, r11, beq_then.16416
	beqi	2, r11, beq_then.16418
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_second_fast2.3084				#	bl	solver_second_fast2.3084
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16419
beq_then.16418:
	flw	f1, 0(r10)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16420
	addi	r8, r0, 0
	j	fle_cont.16421
fle_else.16420:
	addi	r8, r0, 1
fle_cont.16421:
	beqi	0, r8, beq_then.16422
	flw	f1, 0(r10)
	flw	f2, 3(r9)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	j	beq_cont.16423
beq_then.16422:
	addi	r1, r0, 0
beq_cont.16423:
beq_cont.16419:
	j	beq_cont.16417
beq_then.16416:
	lw	r9, 0(r5)
	add	r5, r0, r10				# mr	r5, r10
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_rect_fast.3054				#	bl	solver_rect_fast.3054
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16417:
	beqi	0, r1, beq_then.16424
	flw	f1, 724(r0)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16425
	j	fle_cont.16426
fle_else.16425:
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16427
	j	fle_cont.16428
fle_else.16427:
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	lw	r2, 0(r3)
	flw	f2, 0(r2)
	fmul	f2, f2, f1
	flw	f3, 751(r0)
	fadd	f2, f2, f3
	flw	f3, 1(r2)
	fmul	f3, f3, f1
	flw	f4, 752(r0)
	fadd	f3, f3, f4
	flw	f4, 2(r2)
	fmul	f4, f4, f1
	flw	f5, 753(r0)
	fadd	f4, f4, f5
	lw	r2, 2(r3)
	lw	r5, 0(r2)
	sw	r1, 5(r3)
	fsw	f4, 6(r3)
	fsw	f3, 8(r3)
	fsw	f2, 10(r3)
	fsw	f1, 12(r3)
	beqi	-1, r5, beq_then.16429
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r5, 0(r30)
	add	r1, r0, r5				# mr	r1, r5
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	is_outside.3128				#	bl	is_outside.3128
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.16431
	addi	r1, r0, 0
	j	beq_cont.16432
beq_then.16431:
	addi	r1, r0, 1
	flw	f1, 10(r3)
	flw	f2, 8(r3)
	flw	f3, 6(r3)
	lw	r2, 2(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	check_all_inside.3133				#	bl	check_all_inside.3133
	addi	r3, r3, -15
	lw	r31, 14(r3)
beq_cont.16432:
	j	beq_cont.16430
beq_then.16429:
	addi	r1, r0, 1
beq_cont.16430:
	beqi	0, r1, beq_then.16433
	flw	f1, 12(r3)
	fsw	f1, 726(r0)
	flw	f1, 10(r3)
	fsw	f1, 727(r0)
	flw	f1, 8(r3)
	fsw	f1, 728(r0)
	flw	f1, 6(r3)
	fsw	f1, 729(r0)
	lw	r1, 4(r3)
	sw	r1, 730(r0)
	lw	r1, 5(r3)
	sw	r1, 725(r0)
	j	beq_cont.16434
beq_then.16433:
beq_cont.16434:
fle_cont.16428:
fle_cont.16426:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	j	solve_each_element_fast.3162
beq_then.16424:
	addi	r1, r0, 1				# set min_caml_objects
	lw	r2, 4(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16435
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	j	solve_each_element_fast.3162
beq_then.16435:
	jr	r31				#
beq_then.16415:
	jr	r31				#
solve_one_or_network_fast.3166:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.16438
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16439
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	sw	r1, 3(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16440
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	sw	r1, 4(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16441
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	sw	r1, 5(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_one_or_network_fast.3166
beq_then.16441:
	jr	r31				#
beq_then.16440:
	jr	r31				#
beq_then.16439:
	jr	r31				#
beq_then.16438:
	jr	r31				#
trace_or_matrix_fast.3170:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.16446
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.16447
	addi	r8, r0, 1				# set min_caml_objects
	add	r30, r8, r7
	lw	r8, 0(r30)
	lw	r9, 10(r8)
	flw	f1, 0(r9)
	flw	f2, 1(r9)
	flw	f3, 2(r9)
	lw	r10, 1(r5)
	add	r30, r10, r7
	lw	r7, 0(r30)
	lw	r10, 1(r8)
	sw	r6, 3(r3)
	beqi	1, r10, beq_then.16449
	beqi	2, r10, beq_then.16451
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second_fast2.3084				#	bl	solver_second_fast2.3084
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16452
beq_then.16451:
	flw	f1, 0(r7)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16453
	addi	r8, r0, 0
	j	fle_cont.16454
fle_else.16453:
	addi	r8, r0, 1
fle_cont.16454:
	beqi	0, r8, beq_then.16455
	flw	f1, 0(r7)
	flw	f2, 3(r9)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	j	beq_cont.16456
beq_then.16455:
	addi	r1, r0, 0
beq_cont.16456:
beq_cont.16452:
	j	beq_cont.16450
beq_then.16449:
	lw	r9, 0(r5)
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_rect_fast.3054				#	bl	solver_rect_fast.3054
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16450:
	beqi	0, r1, beq_then.16457
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16459
	j	fle_cont.16460
fle_else.16459:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16461
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16463
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16465
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3166				#	bl	solve_one_or_network_fast.3166
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16466
beq_then.16465:
beq_cont.16466:
	j	beq_cont.16464
beq_then.16463:
beq_cont.16464:
	j	beq_cont.16462
beq_then.16461:
beq_cont.16462:
fle_cont.16460:
	j	beq_cont.16458
beq_then.16457:
beq_cont.16458:
	j	beq_cont.16448
beq_then.16447:
	lw	r7, 1(r6)
	beqi	-1, r7, beq_then.16467
	addi	r8, r0, 672				# set min_caml_and_net
	add	r30, r8, r7
	lw	r7, 0(r30)
	addi	r8, r0, 0
	sw	r6, 3(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16469
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16471
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3166				#	bl	solve_one_or_network_fast.3166
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16472
beq_then.16471:
beq_cont.16472:
	j	beq_cont.16470
beq_then.16469:
beq_cont.16470:
	j	beq_cont.16468
beq_then.16467:
beq_cont.16468:
beq_cont.16448:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16473
	addi	r7, r0, 99
	sw	r1, 4(r3)
	beq	r6, r7, beq_then.16474
	lw	r7, 0(r3)
	sw	r5, 5(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solver_fast2.3091				#	bl	solver_fast2.3091
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.16476
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16478
	j	fle_cont.16479
fle_else.16478:
	lw	r1, 5(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16480
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16482
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 3
	lw	r2, 5(r3)
	lw	r5, 0(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_one_or_network_fast.3166				#	bl	solve_one_or_network_fast.3166
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16483
beq_then.16482:
beq_cont.16483:
	j	beq_cont.16481
beq_then.16480:
beq_cont.16481:
fle_cont.16479:
	j	beq_cont.16477
beq_then.16476:
beq_cont.16477:
	j	beq_cont.16475
beq_then.16474:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16484
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	lw	r8, 0(r3)
	sw	r5, 5(r3)
	add	r5, r0, r8				# mr	r5, r8
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16486
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 3
	lw	r2, 5(r3)
	lw	r5, 0(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_one_or_network_fast.3166				#	bl	solve_one_or_network_fast.3166
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16487
beq_then.16486:
beq_cont.16487:
	j	beq_cont.16485
beq_then.16484:
beq_cont.16485:
beq_cont.16475:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix_fast.3170
beq_then.16473:
	jr	r31				#
beq_then.16446:
	jr	r31				#
judge_intersection_fast.3174:
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 726(r0)
	lw	r2, 723(r0)
	lw	r5, 0(r2)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16490
	addi	r7, r0, 99
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	beq	r6, r7, beq_then.16492
	sw	r5, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_fast2.3091				#	bl	solver_fast2.3091
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16494
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16496
	j	fle_cont.16497
fle_else.16496:
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16498
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16500
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network_fast.3166				#	bl	solve_one_or_network_fast.3166
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16501
beq_then.16500:
beq_cont.16501:
	j	beq_cont.16499
beq_then.16498:
beq_cont.16499:
fle_cont.16497:
	j	beq_cont.16495
beq_then.16494:
beq_cont.16495:
	j	beq_cont.16493
beq_then.16492:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16502
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r5, 2(r3)
	add	r5, r0, r1				# mr	r5, r1
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16504
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				#	bl	solve_each_element_fast.3162
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network_fast.3166				#	bl	solve_one_or_network_fast.3166
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16505
beq_then.16504:
beq_cont.16505:
	j	beq_cont.16503
beq_then.16502:
beq_cont.16503:
beq_cont.16493:
	addi	r1, r0, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix_fast.3170				#	bl	trace_or_matrix_fast.3170
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16491
beq_then.16490:
beq_cont.16491:
	flw	f1, 726(r0)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16506
	addi	r1, r0, 0
	jr	r31				#
fle_else.16506:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16507
	addi	r1, r0, 0
	jr	r31				#
fle_else.16507:
	addi	r1, r0, 1
	jr	r31				#
get_nvector_rect.3176:
	lw	r2, 725(r0)
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 731(r0)
	fsw	f1, 732(r0)
	fsw	f1, 733(r0)
	addi	r5, r0, 731				# set min_caml_nvector
	addi	r6, r2, -1
	addi	r2, r2, -1
	add	r30, r1, r2
	flw	f1, 0(r30)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16508
	addi	r1, r0, 1
	j	feq_cont.16509
feq_else.16508:
	addi	r1, r0, 0
feq_cont.16509:
	beqi	0, r1, beq_then.16510
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16511
beq_then.16510:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16512
	addi	r1, r0, 0
	j	fle_cont.16513
fle_else.16512:
	addi	r1, r0, 1
fle_cont.16513:
	beqi	0, r1, beq_then.16514
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16515
beq_then.16514:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.16515:
beq_cont.16511:
	fneg	f1, f1
	add	r30, r5, r6
	fsw	f1, 0(r30)
	jr	r31				#
get_nvector_plane.3178:
	lw	r2, 4(r1)
	flw	f1, 0(r2)
	fneg	f1, f1
	fsw	f1, 731(r0)
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fneg	f1, f1
	fsw	f1, 732(r0)
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	fneg	f1, f1
	fsw	f1, 733(r0)
	jr	r31				#
get_nvector_second.3180:
	flw	f1, 727(r0)
	lw	r2, 5(r1)
	flw	f2, 0(r2)
	fsub	f1, f1, f2
	flw	f2, 728(r0)
	lw	r2, 5(r1)
	flw	f3, 1(r2)
	fsub	f2, f2, f3
	flw	f3, 729(r0)
	lw	r2, 5(r1)
	flw	f4, 2(r2)
	fsub	f3, f3, f4
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fmul	f4, f1, f4
	lw	r2, 4(r1)
	flw	f5, 1(r2)
	fmul	f5, f2, f5
	lw	r2, 4(r1)
	flw	f6, 2(r2)
	fmul	f6, f3, f6
	lw	r2, 3(r1)
	beqi	0, r2, beq_then.16518
	lw	r2, 9(r1)
	flw	f7, 2(r2)
	fmul	f7, f2, f7
	lw	r2, 9(r1)
	flw	f8, 1(r2)
	fmul	f8, f3, f8
	fadd	f7, f7, f8
	flup	f8, 1		# fli	f8, 0.500000
	fmul	f7, f7, f8
	fadd	f4, f4, f7
	fsw	f4, 731(r0)
	lw	r2, 9(r1)
	flw	f4, 2(r2)
	fmul	f4, f1, f4
	lw	r2, 9(r1)
	flw	f7, 0(r2)
	fmul	f3, f3, f7
	fadd	f3, f4, f3
	flup	f4, 1		# fli	f4, 0.500000
	fmul	f3, f3, f4
	fadd	f3, f5, f3
	fsw	f3, 732(r0)
	lw	r2, 9(r1)
	flw	f3, 1(r2)
	fmul	f1, f1, f3
	lw	r2, 9(r1)
	flw	f3, 0(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flup	f2, 1		# fli	f2, 0.500000
	fmul	f1, f1, f2
	fadd	f1, f6, f1
	fsw	f1, 733(r0)
	j	beq_cont.16519
beq_then.16518:
	fsw	f4, 731(r0)
	fsw	f5, 732(r0)
	fsw	f6, 733(r0)
beq_cont.16519:
	addi	r2, r0, 731				# set min_caml_nvector
	lw	r1, 6(r1)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	vecunit_sgn.2888
get_nvector.3182:
	lw	r5, 1(r1)
	beqi	1, r5, beq_then.16520
	beqi	2, r5, beq_then.16521
	j	get_nvector_second.3180
beq_then.16521:
	lw	r2, 4(r1)
	flw	f1, 0(r2)
	fneg	f1, f1
	fsw	f1, 731(r0)
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fneg	f1, f1
	fsw	f1, 732(r0)
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	fneg	f1, f1
	fsw	f1, 733(r0)
	jr	r31				#
beq_then.16520:
	lw	r1, 725(r0)
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 731(r0)
	fsw	f1, 732(r0)
	fsw	f1, 733(r0)
	addi	r5, r0, 731				# set min_caml_nvector
	addi	r6, r1, -1
	addi	r1, r1, -1
	add	r30, r2, r1
	flw	f1, 0(r30)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16523
	addi	r1, r0, 1
	j	feq_cont.16524
feq_else.16523:
	addi	r1, r0, 0
feq_cont.16524:
	beqi	0, r1, beq_then.16525
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16526
beq_then.16525:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16527
	addi	r1, r0, 0
	j	fle_cont.16528
fle_else.16527:
	addi	r1, r0, 1
fle_cont.16528:
	beqi	0, r1, beq_then.16529
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16530
beq_then.16529:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.16530:
beq_cont.16526:
	fneg	f1, f1
	add	r30, r5, r6
	fsw	f1, 0(r30)
	jr	r31				#
utexture.3185:
	lw	r5, 0(r1)
	lw	r6, 8(r1)
	flw	f1, 0(r6)
	fsw	f1, 734(r0)
	lw	r6, 8(r1)
	flw	f1, 1(r6)
	fsw	f1, 735(r0)
	lw	r6, 8(r1)
	flw	f1, 2(r6)
	fsw	f1, 736(r0)
	beqi	1, r5, beq_then.16532
	beqi	2, r5, beq_then.16533
	beqi	3, r5, beq_then.16534
	beqi	4, r5, beq_then.16535
	jr	r31				#
beq_then.16535:
	flw	f1, 0(r2)
	lw	r5, 5(r1)
	flw	f2, 0(r5)
	fsub	f1, f1, f2
	lw	r5, 4(r1)
	flw	f2, 0(r5)
	fsqrt	f2, f2
	fmul	f1, f1, f2
	flw	f2, 2(r2)
	lw	r5, 5(r1)
	flw	f3, 2(r5)
	fsub	f2, f2, f3
	lw	r5, 4(r1)
	flw	f3, 2(r5)
	fsqrt	f3, f3
	fmul	f2, f2, f3
	fmul	f3, f1, f1
	fmul	f4, f2, f2
	fadd	f3, f3, f4
	flup	f4, 33		# fli	f4, 0.000100
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16537
	fadd	f5, f0, f1
	j	fle_cont.16538
fle_else.16537:
	fneg	f5, f1
fle_cont.16538:
	fsw	f3, 0(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	fle	r30, f4, f5
	beq	r0, r30, fle_else.16539
	fdiv	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16541
	j	fle_cont.16542
fle_else.16541:
	fneg	f1, f1
fle_cont.16542:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16543
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.16544
fle_else.16543:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.16544:
	fmul	f1, f1, f2
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16545
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16547
	flup	f4, 15		# fli	f4, 1.570796
	flup	f5, 2		# fli	f5, 1.000000
	fdiv	f1, f5, f1
	fsw	f2, 4(r3)
	fsw	f4, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	j	fle_cont.16548
fle_else.16547:
	flup	f4, 16		# fli	f4, 0.785398
	flup	f5, 2		# fli	f5, 1.000000
	fsub	f5, f1, f5
	flup	f6, 2		# fli	f6, 1.000000
	fadd	f1, f1, f6
	fdiv	f1, f5, f1
	fsw	f2, 4(r3)
	fsw	f4, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
fle_cont.16548:
	j	fle_cont.16546
fle_else.16545:
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -11
	lw	r31, 10(r3)
fle_cont.16546:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.16540
fle_else.16539:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.16540:
	ftoi	r1, f1
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16549
	j	fle_cont.16550
fle_else.16549:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.16550:
	fsub	f1, f1, f2
	lw	r1, 3(r3)
	flw	f2, 1(r1)
	lw	r1, 2(r3)
	lw	r2, 5(r1)
	flw	f3, 1(r2)
	fsub	f2, f2, f3
	lw	r1, 4(r1)
	flw	f3, 1(r1)
	fsqrt	f3, f3
	fmul	f2, f2, f3
	flup	f3, 33		# fli	f3, 0.000100
	flw	f4, 0(r3)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16551
	fadd	f5, f0, f4
	j	fle_cont.16552
fle_else.16551:
	fneg	f5, f4
fle_cont.16552:
	fsw	f1, 10(r3)
	fle	r30, f3, f5
	beq	r0, r30, fle_else.16553
	fdiv	f2, f2, f4
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16555
	j	fle_cont.16556
fle_else.16555:
	fneg	f2, f2
fle_cont.16556:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16557
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.16558
fle_else.16557:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.16558:
	fmul	f2, f2, f3
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f2
	beq	r0, r30, fle_else.16559
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f2
	beq	r0, r30, fle_else.16561
	flup	f4, 15		# fli	f4, 1.570796
	flup	f5, 2		# fli	f5, 1.000000
	fdiv	f2, f5, f2
	fsw	f3, 12(r3)
	fsw	f4, 14(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	flw	f2, 12(r3)
	fmul	f1, f1, f2
	j	fle_cont.16562
fle_else.16561:
	flup	f4, 16		# fli	f4, 0.785398
	flup	f5, 2		# fli	f5, 1.000000
	fsub	f5, f2, f5
	flup	f6, 2		# fli	f6, 1.000000
	fadd	f2, f2, f6
	fdiv	f2, f5, f2
	fsw	f3, 12(r3)
	fsw	f4, 16(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fadd	f1, f2, f1
	flw	f2, 12(r3)
	fmul	f1, f1, f2
fle_cont.16562:
	j	fle_cont.16560
fle_else.16559:
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -19
	lw	r31, 18(r3)
fle_cont.16560:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.16554
fle_else.16553:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.16554:
	ftoi	r1, f1
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16563
	j	fle_cont.16564
fle_else.16563:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.16564:
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
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16565
	addi	r1, r0, 0
	j	fle_cont.16566
fle_else.16565:
	addi	r1, r0, 1
fle_cont.16566:
	beqi	0, r1, beq_then.16567
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16568
beq_then.16567:
beq_cont.16568:
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f2, f1
	flup	f2, 38		# fli	f2, 0.300000
	fdiv	f1, f1, f2
	fsw	f1, 736(r0)
	jr	r31				#
beq_then.16534:
	flw	f1, 0(r2)
	lw	r5, 5(r1)
	flw	f2, 0(r5)
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
	ftoi	r1, f1
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16570
	j	fle_cont.16571
fle_else.16570:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.16571:
	fsub	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fmul	f1, f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -19
	lw	r31, 18(r3)
	fmul	f1, f1, f1
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f1, f2
	fsw	f2, 735(r0)
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f2, f1
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f1, f2
	fsw	f1, 736(r0)
	jr	r31				#
beq_then.16533:
	flw	f1, 1(r2)
	flup	f2, 40		# fli	f2, 0.250000
	fmul	f1, f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	sin.2837				#	bl	sin.2837
	addi	r3, r3, -19
	lw	r31, 18(r3)
	fmul	f1, f1, f1
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f2, f1
	fsw	f2, 734(r0)
	flup	f2, 37		# fli	f2, 255.000000
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f1, f3, f1
	fmul	f1, f2, f1
	fsw	f1, 735(r0)
	jr	r31				#
beq_then.16532:
	flw	f1, 0(r2)
	lw	r5, 5(r1)
	flw	f2, 0(r5)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	ftoi	r5, f2
	itof	f3, r5
	fle	r30, f3, f2
	beq	r0, r30, fle_else.16574
	fadd	f2, f0, f3
	j	fle_cont.16575
fle_else.16574:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.16575:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16576
	addi	r5, r0, 0
	j	fle_cont.16577
fle_else.16576:
	addi	r5, r0, 1
fle_cont.16577:
	flw	f1, 2(r2)
	lw	r1, 5(r1)
	flw	f2, 2(r1)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	ftoi	r1, f2
	itof	f3, r1
	fle	r30, f3, f2
	beq	r0, r30, fle_else.16578
	fadd	f2, f0, f3
	j	fle_cont.16579
fle_else.16578:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.16579:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16580
	addi	r1, r0, 0
	j	fle_cont.16581
fle_else.16580:
	addi	r1, r0, 1
fle_cont.16581:
	beqi	0, r5, beq_then.16582
	beqi	0, r1, beq_then.16584
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.16585
beq_then.16584:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.16585:
	j	beq_cont.16583
beq_then.16582:
	beqi	0, r1, beq_then.16586
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16587
beq_then.16586:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.16587:
beq_cont.16583:
	fsw	f1, 735(r0)
	jr	r31				#
add_light.3188:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16589
	addi	r1, r0, 0
	j	fle_cont.16590
fle_else.16589:
	addi	r1, r0, 1
fle_cont.16590:
	beqi	0, r1, beq_then.16591
	flw	f4, 740(r0)
	flw	f5, 734(r0)
	fmul	f5, f1, f5
	fadd	f4, f4, f5
	fsw	f4, 740(r0)
	flw	f4, 741(r0)
	flw	f5, 735(r0)
	fmul	f5, f1, f5
	fadd	f4, f4, f5
	fsw	f4, 741(r0)
	flw	f4, 742(r0)
	flw	f5, 736(r0)
	fmul	f1, f1, f5
	fadd	f1, f4, f1
	fsw	f1, 742(r0)
	j	beq_cont.16592
beq_then.16591:
beq_cont.16592:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.16593
	addi	r1, r0, 0
	j	fle_cont.16594
fle_else.16593:
	addi	r1, r0, 1
fle_cont.16594:
	beqi	0, r1, beq_then.16595
	fmul	f1, f2, f2
	fmul	f1, f1, f1
	fmul	f1, f1, f3
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
beq_then.16595:
	jr	r31				#
trace_reflections.3192:
	bgei	0, r1, bge_then.16598
	jr	r31				#
bge_then.16598:
	addi	r5, r0, 778				# set min_caml_reflections
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r6, 1(r5)
	flup	f3, 31		# fli	f3, 1000000000.000000
	fsw	f3, 726(r0)
	addi	r7, r0, 0
	lw	r8, 723(r0)
	sw	r1, 0(r3)
	fsw	f2, 2(r3)
	sw	r2, 4(r3)
	fsw	f1, 6(r3)
	sw	r6, 8(r3)
	sw	r5, 9(r3)
	add	r5, r0, r6				# mr	r5, r6
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	trace_or_matrix_fast.3170				#	bl	trace_or_matrix_fast.3170
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f1, 726(r0)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16602
	addi	r1, r0, 0
	j	fle_cont.16603
fle_else.16602:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16604
	addi	r1, r0, 0
	j	fle_cont.16605
fle_else.16604:
	addi	r1, r0, 1
fle_cont.16605:
fle_cont.16603:
	beqi	0, r1, beq_then.16606
	lw	r1, 730(r0)
	slli	r1, r1, 2
	lw	r2, 725(r0)
	add	r1, r1, r2
	lw	r2, 9(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.16608
	j	beq_cont.16609
beq_then.16608:
	addi	r1, r0, 0
	lw	r5, 723(r0)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	shadow_check_one_or_matrix.3145				#	bl	shadow_check_one_or_matrix.3145
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.16610
	j	beq_cont.16611
beq_then.16610:
	lw	r1, 8(r3)
	lw	r2, 0(r1)
	flw	f1, 731(r0)
	flw	f2, 0(r2)
	fmul	f1, f1, f2
	flw	f2, 732(r0)
	flw	f3, 1(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 733(r0)
	flw	f3, 2(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r2, 9(r3)
	flw	f2, 2(r2)
	flw	f3, 6(r3)
	fmul	f4, f2, f3
	fmul	f1, f4, f1
	lw	r1, 0(r1)
	lw	r2, 4(r3)
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
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	add_light.3188				#	bl	add_light.3188
	addi	r3, r3, -11
	lw	r31, 10(r3)
beq_cont.16611:
beq_cont.16609:
	j	beq_cont.16607
beq_then.16606:
beq_cont.16607:
	lw	r1, 0(r3)
	addi	r1, r1, -1
	flw	f1, 6(r3)
	flw	f2, 2(r3)
	lw	r2, 4(r3)
	j	trace_reflections.3192
trace_ray.3197:
	blei	4, r1, ble_then.16612
	jr	r31				#
ble_then.16612:
	lw	r6, 2(r5)
	flup	f3, 31		# fli	f3, 1000000000.000000
	fsw	f3, 726(r0)
	addi	r7, r0, 0
	lw	r8, 723(r0)
	fsw	f2, 0(r3)
	sw	r5, 2(r3)
	fsw	f1, 4(r3)
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	sw	r6, 8(r3)
	add	r5, r0, r2				# mr	r5, r2
	add	r1, r0, r7				# mr	r1, r7
	add	r2, r0, r8				# mr	r2, r8
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	trace_or_matrix.3156				#	bl	trace_or_matrix.3156
	addi	r3, r3, -10
	lw	r31, 9(r3)
	flw	f1, 726(r0)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16615
	addi	r1, r0, 0
	j	fle_cont.16616
fle_else.16615:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16617
	addi	r1, r0, 0
	j	fle_cont.16618
fle_else.16617:
	addi	r1, r0, 1
fle_cont.16618:
fle_cont.16616:
	beqi	0, r1, beq_then.16619
	lw	r1, 730(r0)
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	lw	r6, 7(r2)
	flw	f1, 0(r6)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	lw	r6, 1(r2)
	sw	r5, 9(r3)
	fsw	f1, 10(r3)
	sw	r1, 12(r3)
	sw	r2, 13(r3)
	beqi	1, r6, beq_then.16620
	beqi	2, r6, beq_then.16622
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	get_nvector_second.3180				#	bl	get_nvector_second.3180
	addi	r3, r3, -15
	lw	r31, 14(r3)
	j	beq_cont.16623
beq_then.16622:
	lw	r6, 4(r2)
	flw	f3, 0(r6)
	fneg	f3, f3
	fsw	f3, 731(r0)
	lw	r6, 4(r2)
	flw	f3, 1(r6)
	fneg	f3, f3
	fsw	f3, 732(r0)
	lw	r6, 4(r2)
	flw	f3, 2(r6)
	fneg	f3, f3
	fsw	f3, 733(r0)
beq_cont.16623:
	j	beq_cont.16621
beq_then.16620:
	lw	r6, 725(r0)
	flup	f3, 0		# fli	f3, 0.000000
	fsw	f3, 731(r0)
	fsw	f3, 732(r0)
	fsw	f3, 733(r0)
	addi	r7, r0, 731				# set min_caml_nvector
	addi	r8, r6, -1
	addi	r6, r6, -1
	lw	r9, 6(r3)
	add	r30, r9, r6
	flw	f3, 0(r30)
	feq	r30, f3, f0
	beq	r0, r30, feq_else.16624
	addi	r6, r0, 1
	j	feq_cont.16625
feq_else.16624:
	addi	r6, r0, 0
feq_cont.16625:
	beqi	0, r6, beq_then.16626
	flup	f3, 0		# fli	f3, 0.000000
	j	beq_cont.16627
beq_then.16626:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.16628
	addi	r6, r0, 0
	j	fle_cont.16629
fle_else.16628:
	addi	r6, r0, 1
fle_cont.16629:
	beqi	0, r6, beq_then.16630
	flup	f3, 2		# fli	f3, 1.000000
	j	beq_cont.16631
beq_then.16630:
	flup	f3, 11		# fli	f3, -1.000000
beq_cont.16631:
beq_cont.16627:
	fneg	f3, f3
	add	r30, r7, r8
	fsw	f3, 0(r30)
beq_cont.16621:
	flw	f1, 727(r0)
	fsw	f1, 748(r0)
	flw	f1, 728(r0)
	fsw	f1, 749(r0)
	flw	f1, 729(r0)
	fsw	f1, 750(r0)
	addi	r2, r0, 727				# set min_caml_intersection_point
	lw	r1, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	utexture.3185				#	bl	utexture.3185
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 12(r3)
	slli	r1, r1, 2
	lw	r2, 725(r0)
	add	r1, r1, r2
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 2(r3)
	lw	r6, 1(r1)
	add	r30, r6, r2
	lw	r6, 0(r30)
	flw	f1, 727(r0)
	fsw	f1, 0(r6)
	flw	f1, 728(r0)
	fsw	f1, 1(r6)
	flw	f1, 729(r0)
	fsw	f1, 2(r6)
	lw	r6, 3(r1)
	flup	f1, 1		# fli	f1, 0.500000
	lw	r7, 13(r3)
	lw	r8, 7(r7)
	flw	f2, 0(r8)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16632
	addi	r8, r0, 1
	add	r30, r6, r2
	sw	r8, 0(r30)
	lw	r6, 4(r1)
	add	r30, r6, r2
	lw	r8, 0(r30)
	flw	f1, 734(r0)
	fsw	f1, 0(r8)
	flw	f1, 735(r0)
	fsw	f1, 1(r8)
	flw	f1, 736(r0)
	fsw	f1, 2(r8)
	add	r30, r6, r2
	lw	r6, 0(r30)
	flup	f1, 43		# fli	f1, 0.003906
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	flw	f3, 0(r6)
	fmul	f3, f3, f1
	fsw	f3, 0(r6)
	flw	f3, 1(r6)
	fmul	f3, f3, f1
	fsw	f3, 1(r6)
	flw	f3, 2(r6)
	fmul	f1, f3, f1
	fsw	f1, 2(r6)
	lw	r6, 7(r1)
	add	r30, r6, r2
	lw	r6, 0(r30)
	flw	f1, 731(r0)
	fsw	f1, 0(r6)
	flw	f1, 732(r0)
	fsw	f1, 1(r6)
	flw	f1, 733(r0)
	fsw	f1, 2(r6)
	j	fle_cont.16633
fle_else.16632:
	addi	r8, r0, 0
	add	r30, r6, r2
	sw	r8, 0(r30)
fle_cont.16633:
	flup	f1, 44		# fli	f1, -2.000000
	lw	r6, 6(r3)
	flw	f2, 0(r6)
	flw	f3, 731(r0)
	fmul	f2, f2, f3
	flw	f3, 1(r6)
	flw	f4, 732(r0)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flw	f3, 2(r6)
	flw	f4, 733(r0)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	fmul	f1, f1, f2
	flw	f2, 0(r6)
	flw	f3, 731(r0)
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fsw	f2, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 732(r0)
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fsw	f2, 1(r6)
	flw	f2, 2(r6)
	flw	f3, 733(r0)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	fsw	f1, 2(r6)
	lw	r8, 7(r7)
	flw	f1, 1(r8)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	addi	r8, r0, 0
	lw	r9, 723(r0)
	fsw	f1, 14(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	shadow_check_one_or_matrix.3145				#	bl	shadow_check_one_or_matrix.3145
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.16634
	j	beq_cont.16635
beq_then.16634:
	flw	f1, 731(r0)
	flw	f2, 667(r0)
	fmul	f1, f1, f2
	flw	f2, 732(r0)
	flw	f3, 668(r0)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 733(r0)
	flw	f3, 669(r0)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fneg	f1, f1
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	lw	r1, 6(r3)
	flw	f3, 0(r1)
	flw	f4, 667(r0)
	fmul	f3, f3, f4
	flw	f4, 1(r1)
	flw	f5, 668(r0)
	fmul	f4, f4, f5
	fadd	f3, f3, f4
	flw	f4, 2(r1)
	flw	f5, 669(r0)
	fmul	f4, f4, f5
	fadd	f3, f3, f4
	fneg	f3, f3
	flw	f4, 14(r3)
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	add_light.3188				#	bl	add_light.3188
	addi	r3, r3, -17
	lw	r31, 16(r3)
beq_cont.16635:
	addi	r1, r0, 727				# set min_caml_intersection_point
	flw	f1, 727(r0)
	fsw	f1, 751(r0)
	flw	f1, 728(r0)
	fsw	f1, 752(r0)
	flw	f1, 729(r0)
	fsw	f1, 753(r0)
	lw	r2, 0(r0)
	addi	r2, r2, -1
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	setup_startp_constants.3108				#	bl	setup_startp_constants.3108
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r1, 1023(r0)
	addi	r1, r1, -1
	flw	f1, 10(r3)
	flw	f2, 14(r3)
	lw	r2, 6(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	trace_reflections.3192				#	bl	trace_reflections.3192
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flup	f1, 45		# fli	f1, 0.100000
	flw	f2, 4(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16636
	jr	r31				#
fle_else.16636:
	lw	r1, 7(r3)
	bgei	4, r1, bge_then.16638
	addi	r2, r1, 1
	addi	r5, r0, -1
	lw	r6, 8(r3)
	add	r30, r6, r2
	sw	r5, 0(r30)
	j	bge_cont.16639
bge_then.16638:
bge_cont.16639:
	lw	r2, 9(r3)
	beqi	2, r2, beq_then.16640
	j	beq_cont.16641
beq_then.16640:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r2, 13(r3)
	lw	r2, 7(r2)
	flw	f3, 0(r2)
	fsub	f1, f1, f3
	fmul	f1, f2, f1
	addi	r1, r1, 1
	flw	f2, 726(r0)
	flw	f3, 0(r3)
	fadd	f2, f3, f2
	lw	r2, 6(r3)
	lw	r5, 2(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	trace_ray.3197				#	bl	trace_ray.3197
	addi	r3, r3, -17
	lw	r31, 16(r3)
beq_cont.16641:
	jr	r31				#
beq_then.16619:
	addi	r1, r0, -1
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	0, r2, beq_then.16643
	lw	r1, 6(r3)
	flw	f1, 0(r1)
	flw	f2, 667(r0)
	fmul	f1, f1, f2
	flw	f2, 1(r1)
	flw	f3, 668(r0)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	flw	f3, 669(r0)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fneg	f1, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16644
	addi	r1, r0, 0
	j	fle_cont.16645
fle_else.16644:
	addi	r1, r0, 1
fle_cont.16645:
	beqi	0, r1, beq_then.16646
	fmul	f2, f1, f1
	fmul	f1, f2, f1
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
beq_then.16646:
	jr	r31				#
beq_then.16643:
	jr	r31				#
trace_diffuse_ray.3203:
	flup	f2, 31		# fli	f2, 1000000000.000000
	fsw	f2, 726(r0)
	addi	r2, r0, 0
	lw	r5, 723(r0)
	fsw	f1, 0(r3)
	sw	r1, 2(r3)
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r1				# mr	r5, r1
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r28				# mr	r2, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix_fast.3170				#	bl	trace_or_matrix_fast.3170
	addi	r3, r3, -4
	lw	r31, 3(r3)
	flw	f1, 726(r0)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16650
	addi	r1, r0, 0
	j	fle_cont.16651
fle_else.16650:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16652
	addi	r1, r0, 0
	j	fle_cont.16653
fle_else.16652:
	addi	r1, r0, 1
fle_cont.16653:
fle_cont.16651:
	beqi	0, r1, beq_then.16654
	addi	r1, r0, 1				# set min_caml_objects
	lw	r2, 730(r0)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r2, 2(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	sw	r1, 3(r3)
	beqi	1, r5, beq_then.16655
	beqi	2, r5, beq_then.16657
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	get_nvector_second.3180				#	bl	get_nvector_second.3180
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16658
beq_then.16657:
	lw	r2, 4(r1)
	flw	f1, 0(r2)
	fneg	f1, f1
	fsw	f1, 731(r0)
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fneg	f1, f1
	fsw	f1, 732(r0)
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fneg	f1, f1
	fsw	f1, 733(r0)
beq_cont.16658:
	j	beq_cont.16656
beq_then.16655:
	lw	r5, 725(r0)
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 731(r0)
	fsw	f1, 732(r0)
	fsw	f1, 733(r0)
	addi	r6, r0, 731				# set min_caml_nvector
	addi	r7, r5, -1
	addi	r5, r5, -1
	add	r30, r2, r5
	flw	f1, 0(r30)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16659
	addi	r2, r0, 1
	j	feq_cont.16660
feq_else.16659:
	addi	r2, r0, 0
feq_cont.16660:
	beqi	0, r2, beq_then.16661
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16662
beq_then.16661:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16663
	addi	r2, r0, 0
	j	fle_cont.16664
fle_else.16663:
	addi	r2, r0, 1
fle_cont.16664:
	beqi	0, r2, beq_then.16665
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16666
beq_then.16665:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.16666:
beq_cont.16662:
	fneg	f1, f1
	add	r30, r6, r7
	fsw	f1, 0(r30)
beq_cont.16656:
	addi	r2, r0, 727				# set min_caml_intersection_point
	lw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	utexture.3185				#	bl	utexture.3185
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 0
	lw	r2, 723(r0)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_one_or_matrix.3145				#	bl	shadow_check_one_or_matrix.3145
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.16667
	jr	r31				#
beq_then.16667:
	flw	f1, 731(r0)
	flw	f2, 667(r0)
	fmul	f1, f1, f2
	flw	f2, 732(r0)
	flw	f3, 668(r0)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 733(r0)
	flw	f3, 669(r0)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fneg	f1, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16669
	addi	r1, r0, 0
	j	fle_cont.16670
fle_else.16669:
	addi	r1, r0, 1
fle_cont.16670:
	beqi	0, r1, beq_then.16671
	j	beq_cont.16672
beq_then.16671:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.16672:
	flw	f2, 0(r3)
	fmul	f1, f2, f1
	lw	r1, 3(r3)
	lw	r1, 7(r1)
	flw	f2, 0(r1)
	fmul	f1, f1, f2
	flw	f2, 737(r0)
	flw	f3, 734(r0)
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fsw	f2, 737(r0)
	flw	f2, 738(r0)
	flw	f3, 735(r0)
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fsw	f2, 738(r0)
	flw	f2, 739(r0)
	flw	f3, 736(r0)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	fsw	f1, 739(r0)
	jr	r31				#
beq_then.16654:
	jr	r31				#
iter_trace_diffuse_rays.3206:
	bgei	0, r6, bge_then.16675
	jr	r31				#
bge_then.16675:
	add	r30, r1, r6
	lw	r7, 0(r30)
	lw	r7, 0(r7)
	flw	f1, 0(r7)
	flw	f2, 0(r2)
	fmul	f1, f1, f2
	flw	f2, 1(r7)
	flw	f3, 1(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r7)
	flw	f3, 2(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16677
	addi	r7, r0, 0
	j	fle_cont.16678
fle_else.16677:
	addi	r7, r0, 1
fle_cont.16678:
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r6, 3(r3)
	beqi	0, r7, beq_then.16679
	addi	r7, r6, 1
	add	r30, r1, r7
	lw	r7, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_diffuse_ray.3203				#	bl	trace_diffuse_ray.3203
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16680
beq_then.16679:
	add	r30, r1, r6
	lw	r7, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_diffuse_ray.3203				#	bl	trace_diffuse_ray.3203
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16680:
	lw	r1, 3(r3)
	addi	r1, r1, -2
	bgei	0, r1, bge_then.16681
	jr	r31				#
bge_then.16681:
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	flw	f1, 0(r5)
	lw	r6, 1(r3)
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
	beq	r0, r30, fle_else.16683
	addi	r5, r0, 0
	j	fle_cont.16684
fle_else.16683:
	addi	r5, r0, 1
fle_cont.16684:
	sw	r1, 4(r3)
	beqi	0, r5, beq_then.16685
	addi	r5, r1, 1
	add	r30, r2, r5
	lw	r5, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	trace_diffuse_ray.3203				#	bl	trace_diffuse_ray.3203
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16686
beq_then.16685:
	add	r30, r2, r1
	lw	r5, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	trace_diffuse_ray.3203				#	bl	trace_diffuse_ray.3203
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16686:
	lw	r1, 4(r3)
	addi	r6, r1, -2
	lw	r1, 2(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	iter_trace_diffuse_rays.3206
trace_diffuse_rays.3211:
	flw	f1, 0(r5)
	fsw	f1, 751(r0)
	flw	f1, 1(r5)
	fsw	f1, 752(r0)
	flw	f1, 2(r5)
	fsw	f1, 753(r0)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_startp_constants.3108				#	bl	setup_startp_constants.3108
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	flw	f1, 0(r2)
	lw	r5, 1(r3)
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
	beq	r0, r30, fle_else.16687
	addi	r2, r0, 0
	j	fle_cont.16688
fle_else.16687:
	addi	r2, r0, 1
fle_cont.16688:
	beqi	0, r2, beq_then.16689
	lw	r2, 119(r1)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_ray.3203				#	bl	trace_diffuse_ray.3203
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16690
beq_then.16689:
	lw	r2, 118(r1)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_ray.3203				#	bl	trace_diffuse_ray.3203
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16690:
	addi	r6, r0, 116
	lw	r1, 2(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	iter_trace_diffuse_rays.3206
trace_diffuse_ray_80percent.3215:
	sw	r2, 0(r3)
	sw	r5, 1(r3)
	sw	r1, 2(r3)
	beqi	0, r1, beq_then.16691
	lw	r6, 766(r0)
	flw	f1, 0(r5)
	fsw	f1, 751(r0)
	flw	f1, 1(r5)
	fsw	f1, 752(r0)
	flw	f1, 2(r5)
	fsw	f1, 753(r0)
	lw	r7, 0(r0)
	addi	r7, r7, -1
	sw	r6, 3(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	setup_startp_constants.3108				#	bl	setup_startp_constants.3108
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r6, r0, 118
	lw	r1, 3(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	iter_trace_diffuse_rays.3206				#	bl	iter_trace_diffuse_rays.3206
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16692
beq_then.16691:
beq_cont.16692:
	lw	r1, 2(r3)
	beqi	1, r1, beq_then.16693
	lw	r2, 767(r0)
	lw	r5, 1(r3)
	flw	f1, 0(r5)
	fsw	f1, 751(r0)
	flw	f1, 1(r5)
	fsw	f1, 752(r0)
	flw	f1, 2(r5)
	fsw	f1, 753(r0)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r2, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_startp_constants.3108				#	bl	setup_startp_constants.3108
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r6, r0, 118
	lw	r1, 4(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_trace_diffuse_rays.3206				#	bl	iter_trace_diffuse_rays.3206
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16694
beq_then.16693:
beq_cont.16694:
	lw	r1, 2(r3)
	beqi	2, r1, beq_then.16695
	lw	r2, 768(r0)
	lw	r5, 1(r3)
	flw	f1, 0(r5)
	fsw	f1, 751(r0)
	flw	f1, 1(r5)
	fsw	f1, 752(r0)
	flw	f1, 2(r5)
	fsw	f1, 753(r0)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r2, 5(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_startp_constants.3108				#	bl	setup_startp_constants.3108
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r6, r0, 118
	lw	r1, 5(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_trace_diffuse_rays.3206				#	bl	iter_trace_diffuse_rays.3206
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16696
beq_then.16695:
beq_cont.16696:
	lw	r1, 2(r3)
	beqi	3, r1, beq_then.16697
	lw	r2, 769(r0)
	lw	r5, 1(r3)
	flw	f1, 0(r5)
	fsw	f1, 751(r0)
	flw	f1, 1(r5)
	fsw	f1, 752(r0)
	flw	f1, 2(r5)
	fsw	f1, 753(r0)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r2, 6(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_startp_constants.3108				#	bl	setup_startp_constants.3108
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r6, r0, 118
	lw	r1, 6(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	iter_trace_diffuse_rays.3206				#	bl	iter_trace_diffuse_rays.3206
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.16698
beq_then.16697:
beq_cont.16698:
	lw	r1, 2(r3)
	beqi	4, r1, beq_then.16699
	lw	r1, 770(r0)
	lw	r2, 1(r3)
	flw	f1, 0(r2)
	fsw	f1, 751(r0)
	flw	f1, 1(r2)
	fsw	f1, 752(r0)
	flw	f1, 2(r2)
	fsw	f1, 753(r0)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	sw	r1, 7(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_startp_constants.3108				#	bl	setup_startp_constants.3108
	addi	r3, r3, -9
	lw	r31, 8(r3)
	addi	r6, r0, 118
	lw	r1, 7(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	j	iter_trace_diffuse_rays.3206
beq_then.16699:
	jr	r31				#
calc_diffuse_using_1point.3219:
	lw	r5, 5(r1)
	lw	r6, 7(r1)
	lw	r7, 1(r1)
	lw	r8, 4(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	flw	f1, 0(r5)
	fsw	f1, 737(r0)
	flw	f1, 1(r5)
	fsw	f1, 738(r0)
	flw	f1, 2(r5)
	fsw	f1, 739(r0)
	lw	r1, 6(r1)
	lw	r1, 0(r1)
	add	r30, r6, r2
	lw	r5, 0(r30)
	add	r30, r7, r2
	lw	r6, 0(r30)
	sw	r2, 0(r3)
	sw	r8, 1(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	trace_diffuse_ray_80percent.3215				#	bl	trace_diffuse_ray_80percent.3215
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r1, r0, 740				# set min_caml_rgb
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 737				# set min_caml_diffuse_ray
	j	vecaccumv.2912
calc_diffuse_using_5points.3222:
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r2, 5(r2)
	addi	r8, r1, -1
	add	r30, r5, r8
	lw	r8, 0(r30)
	lw	r8, 5(r8)
	add	r30, r5, r1
	lw	r9, 0(r30)
	lw	r9, 5(r9)
	addi	r10, r1, 1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 5(r10)
	add	r30, r6, r1
	lw	r6, 0(r30)
	lw	r6, 5(r6)
	add	r30, r2, r7
	lw	r2, 0(r30)
	flw	f1, 0(r2)
	fsw	f1, 737(r0)
	flw	f1, 1(r2)
	fsw	f1, 738(r0)
	flw	f1, 2(r2)
	fsw	f1, 739(r0)
	add	r30, r8, r7
	lw	r2, 0(r30)
	flw	f1, 737(r0)
	flw	f2, 0(r2)
	fadd	f1, f1, f2
	fsw	f1, 737(r0)
	flw	f1, 738(r0)
	flw	f2, 1(r2)
	fadd	f1, f1, f2
	fsw	f1, 738(r0)
	flw	f1, 739(r0)
	flw	f2, 2(r2)
	fadd	f1, f1, f2
	fsw	f1, 739(r0)
	add	r30, r9, r7
	lw	r2, 0(r30)
	flw	f1, 737(r0)
	flw	f2, 0(r2)
	fadd	f1, f1, f2
	fsw	f1, 737(r0)
	flw	f1, 738(r0)
	flw	f2, 1(r2)
	fadd	f1, f1, f2
	fsw	f1, 738(r0)
	flw	f1, 739(r0)
	flw	f2, 2(r2)
	fadd	f1, f1, f2
	fsw	f1, 739(r0)
	add	r30, r10, r7
	lw	r2, 0(r30)
	flw	f1, 737(r0)
	flw	f2, 0(r2)
	fadd	f1, f1, f2
	fsw	f1, 737(r0)
	flw	f1, 738(r0)
	flw	f2, 1(r2)
	fadd	f1, f1, f2
	fsw	f1, 738(r0)
	flw	f1, 739(r0)
	flw	f2, 2(r2)
	fadd	f1, f1, f2
	fsw	f1, 739(r0)
	add	r30, r6, r7
	lw	r2, 0(r30)
	flw	f1, 737(r0)
	flw	f2, 0(r2)
	fadd	f1, f1, f2
	fsw	f1, 737(r0)
	flw	f1, 738(r0)
	flw	f2, 1(r2)
	fadd	f1, f1, f2
	fsw	f1, 738(r0)
	flw	f1, 739(r0)
	flw	f2, 2(r2)
	fadd	f1, f1, f2
	fsw	f1, 739(r0)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 4(r1)
	addi	r2, r0, 740				# set min_caml_rgb
	add	r30, r1, r7
	lw	r1, 0(r30)
	addi	r5, r0, 737				# set min_caml_diffuse_ray
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	vecaccumv.2912
do_without_neighbors.3228:
	blei	4, r2, ble_then.16701
	jr	r31				#
ble_then.16701:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.16703
	jr	r31				#
bge_then.16703:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	beqi	0, r5, beq_then.16705
	lw	r5, 5(r1)
	lw	r6, 7(r1)
	lw	r7, 1(r1)
	lw	r8, 4(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	flw	f1, 0(r5)
	fsw	f1, 737(r0)
	flw	f1, 1(r5)
	fsw	f1, 738(r0)
	flw	f1, 2(r5)
	fsw	f1, 739(r0)
	lw	r5, 6(r1)
	lw	r5, 0(r5)
	add	r30, r6, r2
	lw	r6, 0(r30)
	add	r30, r7, r2
	lw	r7, 0(r30)
	sw	r8, 2(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_ray_80percent.3215				#	bl	trace_diffuse_ray_80percent.3215
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 740				# set min_caml_rgb
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 737				# set min_caml_diffuse_ray
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	vecaccumv.2912				#	bl	vecaccumv.2912
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16706
beq_then.16705:
beq_cont.16706:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	blei	4, r1, ble_then.16707
	jr	r31				#
ble_then.16707:
	lw	r2, 0(r3)
	lw	r5, 2(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.16709
	jr	r31				#
bge_then.16709:
	lw	r5, 3(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	sw	r1, 3(r3)
	beqi	0, r5, beq_then.16711
	lw	r5, 5(r2)
	lw	r6, 7(r2)
	lw	r7, 1(r2)
	lw	r8, 4(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	flw	f1, 0(r5)
	fsw	f1, 737(r0)
	flw	f1, 1(r5)
	fsw	f1, 738(r0)
	flw	f1, 2(r5)
	fsw	f1, 739(r0)
	lw	r5, 6(r2)
	lw	r5, 0(r5)
	add	r30, r6, r1
	lw	r6, 0(r30)
	add	r30, r7, r1
	lw	r7, 0(r30)
	sw	r8, 4(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	trace_diffuse_ray_80percent.3215				#	bl	trace_diffuse_ray_80percent.3215
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r1, r0, 740				# set min_caml_rgb
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 737				# set min_caml_diffuse_ray
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	vecaccumv.2912				#	bl	vecaccumv.2912
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16712
beq_then.16711:
beq_cont.16712:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	lw	r1, 0(r3)
	j	do_without_neighbors.3228
neighbors_exist.3231:
	lw	r5, 744(r0)
	addi	r6, r2, 1
	ble	r5, r6, ble_then.16713
	blei	0, r2, ble_then.16714
	lw	r2, 743(r0)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.16715
	blei	0, r1, ble_then.16716
	addi	r1, r0, 1
	jr	r31				#
ble_then.16716:
	addi	r1, r0, 0
	jr	r31				#
ble_then.16715:
	addi	r1, r0, 0
	jr	r31				#
ble_then.16714:
	addi	r1, r0, 0
	jr	r31				#
ble_then.16713:
	addi	r1, r0, 0
	jr	r31				#
get_surface_id.3235:
	lw	r1, 2(r1)
	add	r30, r1, r2
	lw	r1, 0(r30)
	jr	r31				#
neighbors_are_available.3238:
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
	beq	r2, r8, beq_then.16717
	addi	r1, r0, 0
	jr	r31				#
beq_then.16717:
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.16718
	addi	r1, r0, 0
	jr	r31				#
beq_then.16718:
	addi	r2, r1, -1
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.16719
	addi	r1, r0, 0
	jr	r31				#
beq_then.16719:
	addi	r1, r1, 1
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beq	r1, r8, beq_then.16720
	addi	r1, r0, 0
	jr	r31				#
beq_then.16720:
	addi	r1, r0, 1
	jr	r31				#
try_exploit_neighbors.3244:
	add	r30, r6, r1
	lw	r9, 0(r30)
	blei	4, r8, ble_then.16721
	jr	r31				#
ble_then.16721:
	lw	r10, 2(r9)
	add	r30, r10, r8
	lw	r10, 0(r30)
	bgei	0, r10, bge_then.16723
	jr	r31				#
bge_then.16723:
	add	r30, r6, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r8
	lw	r10, 0(r30)
	add	r30, r5, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r10, beq_then.16725
	addi	r10, r0, 0
	j	beq_cont.16726
beq_then.16725:
	add	r30, r7, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r10, beq_then.16727
	addi	r10, r0, 0
	j	beq_cont.16728
beq_then.16727:
	addi	r11, r1, -1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r10, beq_then.16729
	addi	r10, r0, 0
	j	beq_cont.16730
beq_then.16729:
	addi	r11, r1, 1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r10, beq_then.16731
	addi	r10, r0, 0
	j	beq_cont.16732
beq_then.16731:
	addi	r10, r0, 1
beq_cont.16732:
beq_cont.16730:
beq_cont.16728:
beq_cont.16726:
	beqi	0, r10, beq_then.16733
	lw	r9, 3(r9)
	add	r30, r9, r8
	lw	r9, 0(r30)
	sw	r2, 0(r3)
	sw	r7, 1(r3)
	sw	r5, 2(r3)
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	beqi	0, r9, beq_then.16734
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r8				# mr	r7, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_diffuse_using_5points.3222				#	bl	calc_diffuse_using_5points.3222
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16735
beq_then.16734:
beq_cont.16735:
	lw	r1, 5(r3)
	addi	r2, r1, 1
	lw	r1, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r1
	lw	r6, 0(r30)
	blei	4, r2, ble_then.16736
	jr	r31				#
ble_then.16736:
	lw	r7, 2(r6)
	add	r30, r7, r2
	lw	r7, 0(r30)
	bgei	0, r7, bge_then.16738
	jr	r31				#
bge_then.16738:
	add	r30, r5, r1
	lw	r7, 0(r30)
	lw	r7, 2(r7)
	add	r30, r7, r2
	lw	r7, 0(r30)
	lw	r8, 2(r3)
	add	r30, r8, r1
	lw	r9, 0(r30)
	lw	r9, 2(r9)
	add	r30, r9, r2
	lw	r9, 0(r30)
	beq	r9, r7, beq_then.16740
	addi	r7, r0, 0
	j	beq_cont.16741
beq_then.16740:
	lw	r9, 1(r3)
	add	r30, r9, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.16742
	addi	r7, r0, 0
	j	beq_cont.16743
beq_then.16742:
	addi	r10, r1, -1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.16744
	addi	r7, r0, 0
	j	beq_cont.16745
beq_then.16744:
	addi	r10, r1, 1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.16746
	addi	r7, r0, 0
	j	beq_cont.16747
beq_then.16746:
	addi	r7, r0, 1
beq_cont.16747:
beq_cont.16745:
beq_cont.16743:
beq_cont.16741:
	beqi	0, r7, beq_then.16748
	lw	r6, 3(r6)
	add	r30, r6, r2
	lw	r6, 0(r30)
	sw	r2, 6(r3)
	beqi	0, r6, beq_then.16749
	lw	r6, 1(r3)
	add	r7, r0, r2				# mr	r7, r2
	add	r2, r0, r8				# mr	r2, r8
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	calc_diffuse_using_5points.3222				#	bl	calc_diffuse_using_5points.3222
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.16750
beq_then.16749:
beq_cont.16750:
	lw	r1, 6(r3)
	addi	r8, r1, 1
	lw	r1, 3(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	lw	r7, 1(r3)
	j	try_exploit_neighbors.3244
beq_then.16748:
	add	r30, r5, r1
	lw	r1, 0(r30)
	j	do_without_neighbors.3228
beq_then.16733:
	add	r30, r6, r1
	lw	r1, 0(r30)
	blei	4, r8, ble_then.16751
	jr	r31				#
ble_then.16751:
	lw	r2, 2(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	bgei	0, r2, bge_then.16753
	jr	r31				#
bge_then.16753:
	lw	r2, 3(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	sw	r1, 7(r3)
	sw	r8, 5(r3)
	beqi	0, r2, beq_then.16755
	lw	r2, 5(r1)
	lw	r5, 7(r1)
	lw	r6, 1(r1)
	lw	r7, 4(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	flw	f1, 0(r2)
	fsw	f1, 737(r0)
	flw	f1, 1(r2)
	fsw	f1, 738(r0)
	flw	f1, 2(r2)
	fsw	f1, 739(r0)
	lw	r2, 6(r1)
	lw	r2, 0(r2)
	add	r30, r5, r8
	lw	r5, 0(r30)
	add	r30, r6, r8
	lw	r6, 0(r30)
	sw	r7, 8(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	trace_diffuse_ray_80percent.3215				#	bl	trace_diffuse_ray_80percent.3215
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r1, r0, 740				# set min_caml_rgb
	lw	r2, 5(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 737				# set min_caml_diffuse_ray
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	vecaccumv.2912				#	bl	vecaccumv.2912
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.16756
beq_then.16755:
beq_cont.16756:
	lw	r1, 5(r3)
	addi	r2, r1, 1
	lw	r1, 7(r3)
	j	do_without_neighbors.3228
write_ppm_header.3251:
	addi	r1, r0, 80
	out	r1
	addi	r1, r0, 51
	out	r1
	addi	r1, r0, 10
	out	r1
	lw	r1, 743(r0)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	lw	r1, 744(r0)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 255
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
write_rgb_element.3253:
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16757
	addi	r1, r0, 255
	j	ble_cont.16758
ble_then.16757:
	bgei	0, r1, bge_then.16759
	addi	r1, r0, 0
	j	bge_cont.16760
bge_then.16759:
bge_cont.16760:
ble_cont.16758:
	j	print_int.2857
write_rgb.3255:
	flw	f1, 740(r0)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16761
	addi	r1, r0, 255
	j	ble_cont.16762
ble_then.16761:
	bgei	0, r1, bge_then.16763
	addi	r1, r0, 0
	j	bge_cont.16764
bge_then.16763:
bge_cont.16764:
ble_cont.16762:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	flw	f1, 741(r0)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16765
	addi	r1, r0, 255
	j	ble_cont.16766
ble_then.16765:
	bgei	0, r1, bge_then.16767
	addi	r1, r0, 0
	j	bge_cont.16768
bge_then.16767:
bge_cont.16768:
ble_cont.16766:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	flw	f1, 742(r0)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16769
	addi	r1, r0, 255
	j	ble_cont.16770
ble_then.16769:
	bgei	0, r1, bge_then.16771
	addi	r1, r0, 0
	j	bge_cont.16772
bge_then.16771:
bge_cont.16772:
ble_cont.16770:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
pretrace_diffuse_rays.3257:
	blei	4, r2, ble_then.16773
	jr	r31				#
ble_then.16773:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.16775
	jr	r31				#
bge_then.16775:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 0(r3)
	beqi	0, r5, beq_then.16777
	lw	r5, 6(r1)
	lw	r5, 0(r5)
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 737(r0)
	fsw	f1, 738(r0)
	fsw	f1, 739(r0)
	lw	r6, 7(r1)
	lw	r7, 1(r1)
	addi	r8, r0, 766				# set min_caml_dirvecs
	add	r30, r8, r5
	lw	r5, 0(r30)
	add	r30, r6, r2
	lw	r6, 0(r30)
	add	r30, r7, r2
	lw	r7, 0(r30)
	flw	f1, 0(r7)
	fsw	f1, 751(r0)
	flw	f1, 1(r7)
	fsw	f1, 752(r0)
	flw	f1, 2(r7)
	fsw	f1, 753(r0)
	lw	r8, 0(r0)
	addi	r8, r8, -1
	sw	r1, 1(r3)
	sw	r7, 2(r3)
	sw	r6, 3(r3)
	sw	r5, 4(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_startp_constants.3108				#	bl	setup_startp_constants.3108
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r6, r0, 118
	lw	r1, 4(r3)
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_trace_diffuse_rays.3206				#	bl	iter_trace_diffuse_rays.3206
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 1(r3)
	lw	r2, 5(r1)
	lw	r5, 0(r3)
	add	r30, r2, r5
	lw	r2, 0(r30)
	flw	f1, 737(r0)
	fsw	f1, 0(r2)
	flw	f1, 738(r0)
	fsw	f1, 1(r2)
	flw	f1, 739(r0)
	fsw	f1, 2(r2)
	j	beq_cont.16778
beq_then.16777:
beq_cont.16778:
	lw	r2, 0(r3)
	addi	r2, r2, 1
	j	pretrace_diffuse_rays.3257
pretrace_pixels.3260:
	bgei	0, r2, bge_then.16779
	jr	r31				#
bge_then.16779:
	flw	f4, 747(r0)
	lw	r6, 745(r0)
	sub	r6, r2, r6
	itof	f5, r6
	fmul	f4, f4, f5
	flw	f5, 754(r0)
	fmul	f5, f4, f5
	fadd	f5, f5, f1
	fsw	f5, 763(r0)
	flw	f5, 755(r0)
	fmul	f5, f4, f5
	fadd	f5, f5, f2
	fsw	f5, 764(r0)
	flw	f5, 756(r0)
	fmul	f4, f4, f5
	fadd	f4, f4, f3
	fsw	f4, 765(r0)
	addi	r6, r0, 763				# set min_caml_ptrace_dirvec
	addi	r7, r0, 0
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r5, 6(r3)
	sw	r2, 7(r3)
	sw	r1, 8(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	vecunit_sgn.2888				#	bl	vecunit_sgn.2888
	addi	r3, r3, -10
	lw	r31, 9(r3)
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 740(r0)
	fsw	f1, 741(r0)
	fsw	f1, 742(r0)
	flw	f1, 664(r0)
	fsw	f1, 748(r0)
	flw	f1, 665(r0)
	fsw	f1, 749(r0)
	flw	f1, 666(r0)
	fsw	f1, 750(r0)
	addi	r1, r0, 0
	flup	f1, 2		# fli	f1, 1.000000
	addi	r2, r0, 763				# set min_caml_ptrace_dirvec
	lw	r5, 7(r3)
	lw	r6, 8(r3)
	add	r30, r6, r5
	lw	r7, 0(r30)
	flup	f2, 0		# fli	f2, 0.000000
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	trace_ray.3197				#	bl	trace_ray.3197
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 7(r3)
	lw	r2, 8(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	flw	f1, 740(r0)
	fsw	f1, 0(r5)
	flw	f1, 741(r0)
	fsw	f1, 1(r5)
	flw	f1, 742(r0)
	fsw	f1, 2(r5)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 6(r5)
	lw	r6, 6(r3)
	sw	r6, 0(r5)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	pretrace_diffuse_rays.3257				#	bl	pretrace_diffuse_rays.3257
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 7(r3)
	addi	r2, r1, -1
	lw	r1, 6(r3)
	addi	r1, r1, 1
	bgei	5, r1, bge_then.16781
	add	r5, r0, r1
	j	bge_cont.16782
bge_then.16781:
	addi	r5, r1, -5
bge_cont.16782:
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r1, 8(r3)
	j	pretrace_pixels.3260
pretrace_line.3267:
	flw	f1, 747(r0)
	lw	r6, 746(r0)
	sub	r2, r2, r6
	itof	f2, r2
	fmul	f1, f1, f2
	flw	f2, 757(r0)
	fmul	f2, f1, f2
	flw	f3, 760(r0)
	fadd	f2, f2, f3
	flw	f3, 758(r0)
	fmul	f3, f1, f3
	flw	f4, 761(r0)
	fadd	f3, f3, f4
	flw	f4, 759(r0)
	fmul	f1, f1, f4
	flw	f4, 762(r0)
	fadd	f1, f1, f4
	lw	r2, 743(r0)
	addi	r2, r2, -1
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	j	pretrace_pixels.3260
scan_pixel.3271:
	lw	r8, 743(r0)
	ble	r8, r1, ble_then.16783
	add	r30, r6, r1
	lw	r8, 0(r30)
	lw	r8, 0(r8)
	flw	f1, 0(r8)
	fsw	f1, 740(r0)
	flw	f1, 1(r8)
	fsw	f1, 741(r0)
	flw	f1, 2(r8)
	fsw	f1, 742(r0)
	lw	r8, 744(r0)
	addi	r9, r2, 1
	ble	r8, r9, ble_then.16784
	blei	0, r2, ble_then.16786
	lw	r8, 743(r0)
	addi	r9, r1, 1
	ble	r8, r9, ble_then.16788
	blei	0, r1, ble_then.16790
	addi	r8, r0, 1
	j	ble_cont.16791
ble_then.16790:
	addi	r8, r0, 0
ble_cont.16791:
	j	ble_cont.16789
ble_then.16788:
	addi	r8, r0, 0
ble_cont.16789:
	j	ble_cont.16787
ble_then.16786:
	addi	r8, r0, 0
ble_cont.16787:
	j	ble_cont.16785
ble_then.16784:
	addi	r8, r0, 0
ble_cont.16785:
	sw	r7, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r6, 3(r3)
	sw	r1, 4(r3)
	beqi	0, r8, beq_then.16792
	addi	r8, r0, 0
	add	r30, r6, r1
	lw	r9, 0(r30)
	lw	r10, 2(r9)
	lw	r10, 0(r10)
	bgei	0, r10, bge_then.16794
	j	bge_cont.16795
bge_then.16794:
	add	r30, r6, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	lw	r10, 0(r10)
	add	r30, r5, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16796
	addi	r10, r0, 0
	j	beq_cont.16797
beq_then.16796:
	add	r30, r7, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16798
	addi	r10, r0, 0
	j	beq_cont.16799
beq_then.16798:
	addi	r11, r1, -1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16800
	addi	r10, r0, 0
	j	beq_cont.16801
beq_then.16800:
	addi	r11, r1, 1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16802
	addi	r10, r0, 0
	j	beq_cont.16803
beq_then.16802:
	addi	r10, r0, 1
beq_cont.16803:
beq_cont.16801:
beq_cont.16799:
beq_cont.16797:
	beqi	0, r10, beq_then.16804
	lw	r9, 3(r9)
	lw	r9, 0(r9)
	beqi	0, r9, beq_then.16806
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r8				# mr	r7, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_diffuse_using_5points.3222				#	bl	calc_diffuse_using_5points.3222
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16807
beq_then.16806:
beq_cont.16807:
	addi	r8, r0, 1
	lw	r1, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	lw	r6, 3(r3)
	lw	r7, 0(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	try_exploit_neighbors.3244				#	bl	try_exploit_neighbors.3244
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16805
beq_then.16804:
	add	r30, r6, r1
	lw	r9, 0(r30)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	do_without_neighbors.3228				#	bl	do_without_neighbors.3228
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16805:
bge_cont.16795:
	j	beq_cont.16793
beq_then.16792:
	add	r30, r6, r1
	lw	r8, 0(r30)
	lw	r9, 2(r8)
	lw	r9, 0(r9)
	bgei	0, r9, bge_then.16808
	j	bge_cont.16809
bge_then.16808:
	lw	r9, 3(r8)
	lw	r9, 0(r9)
	sw	r8, 5(r3)
	beqi	0, r9, beq_then.16810
	lw	r9, 5(r8)
	lw	r10, 7(r8)
	lw	r11, 1(r8)
	lw	r12, 4(r8)
	lw	r9, 0(r9)
	flw	f1, 0(r9)
	fsw	f1, 737(r0)
	flw	f1, 1(r9)
	fsw	f1, 738(r0)
	flw	f1, 2(r9)
	fsw	f1, 739(r0)
	lw	r9, 6(r8)
	lw	r9, 0(r9)
	lw	r10, 0(r10)
	lw	r11, 0(r11)
	sw	r12, 6(r3)
	add	r5, r0, r11				# mr	r5, r11
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	trace_diffuse_ray_80percent.3215				#	bl	trace_diffuse_ray_80percent.3215
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 740				# set min_caml_rgb
	lw	r2, 6(r3)
	lw	r2, 0(r2)
	addi	r5, r0, 737				# set min_caml_diffuse_ray
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	vecaccumv.2912				#	bl	vecaccumv.2912
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.16811
beq_then.16810:
beq_cont.16811:
	addi	r2, r0, 1
	lw	r1, 5(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	do_without_neighbors.3228				#	bl	do_without_neighbors.3228
	addi	r3, r3, -8
	lw	r31, 7(r3)
bge_cont.16809:
beq_cont.16793:
	flw	f1, 740(r0)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16812
	addi	r1, r0, 255
	j	ble_cont.16813
ble_then.16812:
	bgei	0, r1, bge_then.16814
	addi	r1, r0, 0
	j	bge_cont.16815
bge_then.16814:
bge_cont.16815:
ble_cont.16813:
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 32
	out	r1
	flw	f1, 741(r0)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16816
	addi	r1, r0, 255
	j	ble_cont.16817
ble_then.16816:
	bgei	0, r1, bge_then.16818
	addi	r1, r0, 0
	j	bge_cont.16819
bge_then.16818:
bge_cont.16819:
ble_cont.16817:
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 32
	out	r1
	flw	f1, 742(r0)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16820
	addi	r1, r0, 255
	j	ble_cont.16821
ble_then.16820:
	bgei	0, r1, bge_then.16822
	addi	r1, r0, 0
	j	bge_cont.16823
bge_then.16822:
bge_cont.16823:
ble_cont.16821:
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 10
	out	r1
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 743(r0)
	ble	r2, r1, ble_then.16824
	lw	r6, 3(r3)
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r2, 0(r2)
	flw	f1, 0(r2)
	fsw	f1, 740(r0)
	flw	f1, 1(r2)
	fsw	f1, 741(r0)
	flw	f1, 2(r2)
	fsw	f1, 742(r0)
	lw	r2, 744(r0)
	lw	r5, 2(r3)
	addi	r7, r5, 1
	ble	r2, r7, ble_then.16825
	blei	0, r5, ble_then.16827
	lw	r2, 743(r0)
	addi	r7, r1, 1
	ble	r2, r7, ble_then.16829
	blei	0, r1, ble_then.16831
	addi	r2, r0, 1
	j	ble_cont.16832
ble_then.16831:
	addi	r2, r0, 0
ble_cont.16832:
	j	ble_cont.16830
ble_then.16829:
	addi	r2, r0, 0
ble_cont.16830:
	j	ble_cont.16828
ble_then.16827:
	addi	r2, r0, 0
ble_cont.16828:
	j	ble_cont.16826
ble_then.16825:
	addi	r2, r0, 0
ble_cont.16826:
	sw	r1, 7(r3)
	beqi	0, r2, beq_then.16833
	addi	r8, r0, 0
	lw	r2, 1(r3)
	lw	r7, 0(r3)
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r28				# mr	r2, r28
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	try_exploit_neighbors.3244				#	bl	try_exploit_neighbors.3244
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.16834
beq_then.16833:
	add	r30, r6, r1
	lw	r2, 0(r30)
	addi	r7, r0, 0
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r7				# mr	r2, r7
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	do_without_neighbors.3228				#	bl	do_without_neighbors.3228
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.16834:
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	write_rgb.3255				#	bl	write_rgb.3255
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	lw	r6, 3(r3)
	lw	r7, 0(r3)
	j	scan_pixel.3271
ble_then.16824:
	jr	r31				#
ble_then.16783:
	jr	r31				#
scan_line.3277:
	lw	r8, 744(r0)
	ble	r8, r1, ble_then.16837
	lw	r8, 744(r0)
	addi	r8, r8, -1
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	ble	r8, r1, ble_then.16838
	addi	r8, r1, 1
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	pretrace_line.3267				#	bl	pretrace_line.3267
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	ble_cont.16839
ble_then.16838:
ble_cont.16839:
	addi	r1, r0, 0
	lw	r2, 743(r0)
	blei	0, r2, ble_then.16840
	lw	r6, 4(r3)
	lw	r2, 0(r6)
	lw	r2, 0(r2)
	flw	f1, 0(r2)
	fsw	f1, 740(r0)
	flw	f1, 1(r2)
	fsw	f1, 741(r0)
	flw	f1, 2(r2)
	fsw	f1, 742(r0)
	lw	r2, 744(r0)
	lw	r5, 3(r3)
	addi	r7, r5, 1
	ble	r2, r7, ble_then.16842
	blei	0, r5, ble_then.16844
	lw	r2, 743(r0)
	blei	1, r2, ble_then.16846
	addi	r2, r0, 0
	j	ble_cont.16847
ble_then.16846:
	addi	r2, r0, 0
ble_cont.16847:
	j	ble_cont.16845
ble_then.16844:
	addi	r2, r0, 0
ble_cont.16845:
	j	ble_cont.16843
ble_then.16842:
	addi	r2, r0, 0
ble_cont.16843:
	beqi	0, r2, beq_then.16848
	addi	r8, r0, 0
	lw	r2, 2(r3)
	lw	r7, 1(r3)
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r28				# mr	r2, r28
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	try_exploit_neighbors.3244				#	bl	try_exploit_neighbors.3244
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16849
beq_then.16848:
	lw	r1, 0(r6)
	addi	r2, r0, 0
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	do_without_neighbors.3228				#	bl	do_without_neighbors.3228
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16849:
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	write_rgb.3255				#	bl	write_rgb.3255
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r1, r0, 1
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	lw	r7, 1(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	scan_pixel.3271				#	bl	scan_pixel.3271
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	ble_cont.16841
ble_then.16840:
ble_cont.16841:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	lw	r1, 0(r3)
	addi	r1, r1, 2
	bgei	5, r1, bge_then.16850
	add	r5, r0, r1
	j	bge_cont.16851
bge_then.16850:
	addi	r5, r1, -5
bge_cont.16851:
	lw	r1, 744(r0)
	ble	r1, r2, ble_then.16852
	lw	r1, 744(r0)
	addi	r1, r1, -1
	sw	r5, 5(r3)
	sw	r2, 6(r3)
	ble	r1, r2, ble_then.16854
	addi	r1, r2, 1
	lw	r6, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	pretrace_line.3267				#	bl	pretrace_line.3267
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	ble_cont.16855
ble_then.16854:
ble_cont.16855:
	addi	r1, r0, 0
	lw	r2, 6(r3)
	lw	r5, 4(r3)
	lw	r6, 1(r3)
	lw	r7, 2(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	scan_pixel.3271				#	bl	scan_pixel.3271
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 5(r3)
	addi	r2, r2, 2
	bgei	5, r2, bge_then.16856
	add	r7, r0, r2
	j	bge_cont.16857
bge_then.16856:
	addi	r7, r2, -5
bge_cont.16857:
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	scan_line.3277				#	bl	scan_line.3277
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	ble_cont.16853
ble_then.16852:
ble_cont.16853:
	jr	r31				#
ble_then.16837:
	jr	r31				#
create_float5x3array.3283:
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
create_pixel.3285:
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -1
	lw	r31, 0(r3)
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 1(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -5
	lw	r31, 4(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 6(r3)
	sw	r1, 6(r2)
	lw	r1, 5(r3)
	sw	r1, 5(r2)
	lw	r1, 4(r3)
	sw	r1, 4(r2)
	lw	r1, 3(r3)
	sw	r1, 3(r2)
	lw	r1, 2(r3)
	sw	r1, 2(r2)
	lw	r1, 1(r3)
	sw	r1, 1(r2)
	lw	r1, 0(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	jr	r31				#
init_line_elements.3287:
	bgei	0, r2, bge_then.16860
	jr	r31				#
bge_then.16860:
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 4(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -6
	lw	r31, 5(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -7
	lw	r31, 6(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 7(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 8(r3)
	sw	r1, 6(r2)
	lw	r1, 7(r3)
	sw	r1, 5(r2)
	lw	r1, 6(r3)
	sw	r1, 4(r2)
	lw	r1, 5(r3)
	sw	r1, 3(r2)
	lw	r1, 4(r3)
	sw	r1, 2(r2)
	lw	r1, 3(r3)
	sw	r1, 1(r2)
	lw	r1, 2(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	bgei	0, r1, bge_then.16861
	add	r1, r0, r5
	jr	r31				#
bge_then.16861:
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 9(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r31, 10(r3)
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 11(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 12(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -14
	lw	r31, 13(r3)
	sw	r1, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -15
	lw	r31, 14(r3)
	sw	r1, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
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
	sw	r1, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -18
	lw	r31, 17(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 16(r3)
	sw	r1, 6(r2)
	lw	r1, 15(r3)
	sw	r1, 5(r2)
	lw	r1, 14(r3)
	sw	r1, 4(r2)
	lw	r1, 13(r3)
	sw	r1, 3(r2)
	lw	r1, 12(r3)
	sw	r1, 2(r2)
	lw	r1, 11(r3)
	sw	r1, 1(r2)
	lw	r1, 10(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 9(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	add	r1, r0, r5				# mr	r1, r5
	j	init_line_elements.3287
create_pixelline.3290:
	lw	r1, 743(r0)
	addi	r2, r0, 3
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
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
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
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -6
	lw	r31, 5(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
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
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r4
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
	lw	r1, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 743(r0)
	addi	r2, r2, -2
	bgei	0, r2, bge_then.16862
	jr	r31				#
bge_then.16862:
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 8(r3)
	sw	r1, 9(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r31, 10(r3)
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 11(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 12(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -14
	lw	r31, 13(r3)
	sw	r1, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -15
	lw	r31, 14(r3)
	sw	r1, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
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
	sw	r1, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -18
	lw	r31, 17(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 16(r3)
	sw	r1, 6(r2)
	lw	r1, 15(r3)
	sw	r1, 5(r2)
	lw	r1, 14(r3)
	sw	r1, 4(r2)
	lw	r1, 13(r3)
	sw	r1, 3(r2)
	lw	r1, 12(r3)
	sw	r1, 2(r2)
	lw	r1, 11(r3)
	sw	r1, 1(r2)
	lw	r1, 10(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	add	r1, r0, r5				# mr	r1, r5
	j	init_line_elements.3287
tan.3292:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	sin.2837				#	bl	sin.2837
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f2, 0(r3)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fdiv	f1, f2, f1
	jr	r31				#
adjust_position.3294:
	fmul	f1, f1, f1
	flup	f3, 45		# fli	f3, 0.100000
	fadd	f1, f1, f3
	fsqrt	f1, f1
	flup	f3, 2		# fli	f3, 1.000000
	fdiv	f3, f3, f1
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16863
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.16864
fle_else.16863:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.16864:
	fmul	f3, f3, f4
	flup	f5, 23		# fli	f5, 4.375000
	fsw	f1, 0(r3)
	fsw	f2, 2(r3)
	fle	r30, f5, f3
	beq	r0, r30, fle_else.16865
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f3
	beq	r0, r30, fle_else.16867
	flup	f5, 15		# fli	f5, 1.570796
	flup	f6, 2		# fli	f6, 1.000000
	fdiv	f3, f6, f3
	fsw	f4, 4(r3)
	fsw	f5, 6(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	j	fle_cont.16868
fle_else.16867:
	flup	f5, 16		# fli	f5, 0.785398
	flup	f6, 2		# fli	f6, 1.000000
	fsub	f6, f3, f6
	flup	f7, 2		# fli	f7, 1.000000
	fadd	f3, f3, f7
	fdiv	f3, f6, f3
	fsw	f4, 4(r3)
	fsw	f5, 8(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
fle_cont.16868:
	j	fle_cont.16866
fle_else.16865:
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -11
	lw	r31, 10(r3)
fle_cont.16866:
	flw	f2, 2(r3)
	fmul	f1, f1, f2
	fsw	f1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2837				#	bl	sin.2837
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fsw	f1, 12(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fdiv	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
calc_dirvec.3297:
	bgei	5, r1, bge_then.16869
	fmul	f1, f2, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f1, f1, f2
	fsqrt	f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f2, f2, f1
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16870
	flup	f5, 2		# fli	f5, 1.000000
	j	fle_cont.16871
fle_else.16870:
	flup	f5, 11		# fli	f5, -1.000000
fle_cont.16871:
	fmul	f2, f2, f5
	flup	f6, 23		# fli	f6, 4.375000
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	fsw	f4, 2(r3)
	sw	r1, 4(r3)
	fsw	f1, 6(r3)
	fsw	f3, 8(r3)
	fle	r30, f6, f2
	beq	r0, r30, fle_else.16873
	flup	f6, 24		# fli	f6, 2.437500
	fle	r30, f6, f2
	beq	r0, r30, fle_else.16875
	flup	f6, 15		# fli	f6, 1.570796
	flup	f7, 2		# fli	f7, 1.000000
	fdiv	f2, f7, f2
	fsw	f5, 10(r3)
	fsw	f6, 12(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fadd	f1, f2, f1
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	j	fle_cont.16876
fle_else.16875:
	flup	f6, 16		# fli	f6, 0.785398
	flup	f7, 2		# fli	f7, 1.000000
	fsub	f7, f2, f7
	flup	f8, 2		# fli	f8, 1.000000
	fadd	f2, f2, f8
	fdiv	f2, f7, f2
	fsw	f5, 10(r3)
	fsw	f6, 14(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	flw	f2, 10(r3)
	fmul	f1, f1, f2
fle_cont.16876:
	j	fle_cont.16874
fle_else.16873:
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -17
	lw	r31, 16(r3)
fle_cont.16874:
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	fsw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	sin.2837				#	bl	sin.2837
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fsw	f1, 18(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 18(r3)
	fdiv	f1, f2, f1
	flw	f2, 6(r3)
	fmul	f1, f1, f2
	lw	r1, 4(r3)
	addi	r1, r1, 1
	fmul	f2, f1, f1
	flup	f3, 45		# fli	f3, 0.100000
	fadd	f2, f2, f3
	fsqrt	f2, f2
	flup	f3, 2		# fli	f3, 1.000000
	fdiv	f3, f3, f2
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16877
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.16878
fle_else.16877:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.16878:
	fmul	f3, f3, f4
	flup	f5, 23		# fli	f5, 4.375000
	fsw	f1, 20(r3)
	sw	r1, 22(r3)
	fsw	f2, 24(r3)
	fle	r30, f5, f3
	beq	r0, r30, fle_else.16880
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f3
	beq	r0, r30, fle_else.16882
	flup	f5, 15		# fli	f5, 1.570796
	flup	f6, 2		# fli	f6, 1.000000
	fdiv	f3, f6, f3
	fsw	f4, 26(r3)
	fsw	f5, 28(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -31
	lw	r31, 30(r3)
	flw	f2, 28(r3)
	fadd	f1, f2, f1
	flw	f2, 26(r3)
	fmul	f1, f1, f2
	j	fle_cont.16883
fle_else.16882:
	flup	f5, 16		# fli	f5, 0.785398
	flup	f6, 2		# fli	f6, 1.000000
	fsub	f6, f3, f6
	flup	f7, 2		# fli	f7, 1.000000
	fadd	f3, f3, f7
	fdiv	f3, f6, f3
	fsw	f4, 26(r3)
	fsw	f5, 30(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -33
	lw	r31, 32(r3)
	flw	f2, 30(r3)
	fadd	f1, f2, f1
	flw	f2, 26(r3)
	fmul	f1, f1, f2
fle_cont.16883:
	j	fle_cont.16881
fle_else.16880:
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -33
	lw	r31, 32(r3)
fle_cont.16881:
	flw	f2, 2(r3)
	fmul	f1, f1, f2
	fsw	f1, 32(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	sin.2837				#	bl	sin.2837
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flw	f2, 32(r3)
	fsw	f1, 34(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -37
	lw	r31, 36(r3)
	flw	f2, 34(r3)
	fdiv	f1, f2, f1
	flw	f2, 24(r3)
	fmul	f2, f1, f2
	flw	f1, 20(r3)
	flw	f3, 8(r3)
	flw	f4, 2(r3)
	lw	r1, 22(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	calc_dirvec.3297
bge_then.16869:
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
	addi	r1, r0, 766				# set min_caml_dirvecs
	add	r30, r1, r2
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
calc_dirvecs.3305:
	bgei	0, r1, bge_then.16885
	jr	r31				#
bge_then.16885:
	itof	f2, r1
	flup	f3, 18		# fli	f3, 0.200000
	fmul	f2, f2, f3
	flup	f3, 48		# fli	f3, 0.900000
	fsub	f3, f2, f3
	addi	r6, r0, 0
	flup	f2, 0		# fli	f2, 0.000000
	flup	f4, 0		# fli	f4, 0.000000
	fsw	f1, 0(r3)
	sw	r2, 2(r3)
	sw	r5, 3(r3)
	sw	r1, 4(r3)
	add	r1, r0, r6				# mr	r1, r6
	fadd	f30, f0, f4				# fmr	f30, f4
	fadd	f4, f0, f1				# fmr	f4, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_dirvec.3297				#	bl	calc_dirvec.3297
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	itof	f1, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f3, f1, f2
	addi	r2, r0, 0
	flup	f1, 0		# fli	f1, 0.000000
	flup	f2, 0		# fli	f2, 0.000000
	lw	r5, 3(r3)
	addi	r6, r5, 2
	flw	f4, 0(r3)
	lw	r7, 2(r3)
	add	r5, r0, r6				# mr	r5, r6
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r7				# mr	r2, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_dirvec.3297				#	bl	calc_dirvec.3297
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r1, r1, -1
	lw	r2, 2(r3)
	addi	r2, r2, 1
	bgei	5, r2, bge_then.16887
	j	bge_cont.16888
bge_then.16887:
	addi	r2, r2, -5
bge_cont.16888:
	flw	f1, 0(r3)
	lw	r5, 3(r3)
	j	calc_dirvecs.3305
calc_dirvec_rows.3310:
	bgei	0, r1, bge_then.16889
	jr	r31				#
bge_then.16889:
	itof	f1, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f1, f1, f2
	addi	r6, r0, 4
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	calc_dirvecs.3305				#	bl	calc_dirvecs.3305
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r1, r1, -1
	lw	r2, 1(r3)
	addi	r2, r2, 2
	bgei	5, r2, bge_then.16891
	j	bge_cont.16892
bge_then.16891:
	addi	r2, r2, -5
bge_cont.16892:
	lw	r5, 0(r3)
	addi	r5, r5, 4
	bgei	0, r1, bge_then.16893
	jr	r31				#
bge_then.16893:
	itof	f1, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f1, f1, f2
	addi	r6, r0, 4
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_dirvecs.3305				#	bl	calc_dirvecs.3305
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, -1
	lw	r2, 4(r3)
	addi	r2, r2, 2
	bgei	5, r2, bge_then.16895
	j	bge_cont.16896
bge_then.16895:
	addi	r2, r2, -5
bge_cont.16896:
	lw	r5, 3(r3)
	addi	r5, r5, 4
	j	calc_dirvec_rows.3310
create_dirvec.3314:
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -1
	lw	r31, 0(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 0(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	jr	r31				#
create_dirvec_elements.3316:
	bgei	0, r2, bge_then.16897
	jr	r31				#
bge_then.16897:
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 2(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	bgei	0, r1, bge_then.16899
	jr	r31				#
bge_then.16899:
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 4(r3)
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
	lw	r2, 3(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	bgei	0, r1, bge_then.16901
	jr	r31				#
bge_then.16901:
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
	lw	r1, 0(r0)
	sw	r2, 6(r3)
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
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	bgei	0, r1, bge_then.16903
	jr	r31				#
bge_then.16903:
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
	lw	r1, 0(r0)
	sw	r2, 8(r3)
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
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	add	r1, r0, r5				# mr	r1, r5
	j	create_dirvec_elements.3316
create_dirvecs.3319:
	bgei	0, r1, bge_then.16905
	jr	r31				#
bge_then.16905:
	addi	r2, r0, 766				# set min_caml_dirvecs
	addi	r5, r0, 120
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r5, 2(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 3(r3)
	sw	r1, 0(r2)
	lw	r1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 766				# set min_caml_dirvecs
	add	r30, r1, r2
	lw	r1, 0(r30)
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 4(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 5(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 4(r3)
	sw	r1, 118(r2)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 6(r3)
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
	lw	r2, 4(r3)
	sw	r1, 117(r2)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 7(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 4(r3)
	sw	r1, 116(r2)
	addi	r1, r0, 115
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	create_dirvec_elements.3316				#	bl	create_dirvec_elements.3316
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.16907
	jr	r31				#
bge_then.16907:
	addi	r2, r0, 766				# set min_caml_dirvecs
	addi	r5, r0, 120
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 8(r3)
	sw	r2, 9(r3)
	sw	r5, 10(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 11(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 11(r3)
	sw	r1, 0(r2)
	lw	r1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 766				# set min_caml_dirvecs
	add	r30, r1, r2
	lw	r1, 0(r30)
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 12(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 13(r3)
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
	add	r1, r0, r2
	lw	r2, 12(r3)
	sw	r1, 118(r2)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 14(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 12(r3)
	sw	r1, 117(r2)
	addi	r1, r0, 116
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_dirvec_elements.3316				#	bl	create_dirvec_elements.3316
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r1, 8(r3)
	addi	r1, r1, -1
	j	create_dirvecs.3319
init_dirvec_constants.3321:
	bgei	0, r2, bge_then.16909
	jr	r31				#
bge_then.16909:
	add	r30, r1, r2
	lw	r5, 0(r30)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.16911
	jr	r31				#
bge_then.16911:
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r1, 2(r3)
	bgei	0, r6, bge_then.16913
	j	bge_cont.16914
bge_then.16913:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 3(r3)
	beqi	1, r10, beq_then.16915
	beqi	2, r10, beq_then.16917
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16918
beq_then.16917:
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16918:
	j	beq_cont.16916
beq_then.16915:
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16916:
	addi	r2, r2, -1
	lw	r1, 3(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -7
	lw	r31, 6(r3)
bge_cont.16914:
	lw	r1, 2(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.16919
	jr	r31				#
bge_then.16919:
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r1, 6(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.16921
	jr	r31				#
bge_then.16921:
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r1, 7(r3)
	bgei	0, r6, bge_then.16923
	j	bge_cont.16924
bge_then.16923:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 8(r3)
	beqi	1, r10, beq_then.16925
	beqi	2, r10, beq_then.16927
	sw	r6, 9(r3)
	sw	r8, 10(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16928
beq_then.16927:
	sw	r6, 9(r3)
	sw	r8, 10(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16928:
	j	beq_cont.16926
beq_then.16925:
	sw	r6, 9(r3)
	sw	r8, 10(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16926:
	addi	r2, r2, -1
	lw	r1, 8(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -12
	lw	r31, 11(r3)
bge_cont.16924:
	lw	r1, 7(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	j	init_dirvec_constants.3321
init_vecset_constants.3324:
	bgei	0, r1, bge_then.16929
	jr	r31				#
bge_then.16929:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 119(r2)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	bgei	0, r6, bge_then.16931
	j	bge_cont.16932
bge_then.16931:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 2(r3)
	beqi	1, r10, beq_then.16933
	beqi	2, r10, beq_then.16935
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16936
beq_then.16935:
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16936:
	j	beq_cont.16934
beq_then.16933:
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16934:
	addi	r2, r2, -1
	lw	r1, 2(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -6
	lw	r31, 5(r3)
bge_cont.16932:
	lw	r1, 1(r3)
	lw	r2, 118(r1)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 1(r3)
	lw	r2, 117(r1)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	bgei	0, r5, bge_then.16937
	j	bge_cont.16938
bge_then.16937:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 5(r3)
	beqi	1, r9, beq_then.16939
	beqi	2, r9, beq_then.16941
	sw	r5, 6(r3)
	sw	r7, 7(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16942
beq_then.16941:
	sw	r5, 6(r3)
	sw	r7, 7(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16942:
	j	beq_cont.16940
beq_then.16939:
	sw	r5, 6(r3)
	sw	r7, 7(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16940:
	addi	r2, r2, -1
	lw	r1, 5(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -9
	lw	r31, 8(r3)
bge_cont.16938:
	addi	r2, r0, 116
	lw	r1, 1(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.16943
	jr	r31				#
bge_then.16943:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 119(r2)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r1, 8(r3)
	sw	r2, 9(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 9(r3)
	lw	r2, 118(r1)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	bgei	0, r5, bge_then.16945
	j	bge_cont.16946
bge_then.16945:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 10(r3)
	beqi	1, r9, beq_then.16947
	beqi	2, r9, beq_then.16949
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16950
beq_then.16949:
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16950:
	j	beq_cont.16948
beq_then.16947:
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16948:
	addi	r2, r2, -1
	lw	r1, 10(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -14
	lw	r31, 13(r3)
bge_cont.16946:
	addi	r2, r0, 117
	lw	r1, 9(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 8(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.16951
	jr	r31				#
bge_then.16951:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 119(r2)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r1, 13(r3)
	sw	r2, 14(r3)
	bgei	0, r6, bge_then.16953
	j	bge_cont.16954
bge_then.16953:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 15(r3)
	beqi	1, r10, beq_then.16955
	beqi	2, r10, beq_then.16957
	sw	r6, 16(r3)
	sw	r8, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16958
beq_then.16957:
	sw	r6, 16(r3)
	sw	r8, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16958:
	j	beq_cont.16956
beq_then.16955:
	sw	r6, 16(r3)
	sw	r8, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16956:
	addi	r2, r2, -1
	lw	r1, 15(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -19
	lw	r31, 18(r3)
bge_cont.16954:
	addi	r2, r0, 118
	lw	r1, 14(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r1, 13(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.16959
	jr	r31				#
bge_then.16959:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r2, 0(r30)
	addi	r5, r0, 119
	sw	r1, 18(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r1, 18(r3)
	addi	r1, r1, -1
	j	init_vecset_constants.3324
init_dirvecs.3326:
	addi	r1, r0, 120
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 1(r3)
	sw	r1, 0(r2)
	lw	r1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r1, 770(r0)
	lw	r1, 770(r0)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 3(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 2(r3)
	sw	r1, 118(r2)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 4(r3)
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
	lw	r2, 2(r3)
	sw	r1, 117(r2)
	addi	r1, r0, 116
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_dirvec_elements.3316				#	bl	create_dirvec_elements.3316
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r1, r0, 3
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_dirvecs.3319				#	bl	create_dirvecs.3319
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	itof	f1, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f1, f1, f2
	addi	r1, r0, 4
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_dirvecs.3305				#	bl	calc_dirvecs.3305
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r1, r0, 8
	addi	r2, r0, 2
	addi	r5, r0, 4
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_dirvec_rows.3310				#	bl	calc_dirvec_rows.3310
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 770(r0)
	lw	r2, 119(r1)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	sw	r1, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	lw	r2, 118(r1)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	bgei	0, r5, bge_then.16961
	j	bge_cont.16962
bge_then.16961:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 6(r3)
	beqi	1, r9, beq_then.16963
	beqi	2, r9, beq_then.16965
	sw	r5, 7(r3)
	sw	r7, 8(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16966
beq_then.16965:
	sw	r5, 7(r3)
	sw	r7, 8(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16966:
	j	beq_cont.16964
beq_then.16963:
	sw	r5, 7(r3)
	sw	r7, 8(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16964:
	addi	r2, r2, -1
	lw	r1, 6(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -10
	lw	r31, 9(r3)
bge_cont.16962:
	addi	r2, r0, 117
	lw	r1, 5(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 769(r0)
	lw	r2, 119(r1)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	sw	r1, 9(r3)
	bgei	0, r5, bge_then.16967
	j	bge_cont.16968
bge_then.16967:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 10(r3)
	beqi	1, r9, beq_then.16969
	beqi	2, r9, beq_then.16971
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16972
beq_then.16971:
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16972:
	j	beq_cont.16970
beq_then.16969:
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16970:
	addi	r2, r2, -1
	lw	r1, 10(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -14
	lw	r31, 13(r3)
bge_cont.16968:
	addi	r2, r0, 118
	lw	r1, 9(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 768(r0)
	addi	r2, r0, 119
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r1, r0, 1
	j	init_vecset_constants.3324
add_reflection.3328:
	addi	r5, r0, 3
	flup	f5, 0		# fli	f5, 0.000000
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	fsw	f1, 2(r3)
	fsw	f4, 4(r3)
	fsw	f3, 6(r3)
	fsw	f2, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	fadd	f1, f0, f5				# fmr	f1, f5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
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
	flw	f1, 8(r3)
	fsw	f1, 0(r1)
	flw	f1, 6(r3)
	fsw	f1, 1(r1)
	flw	f1, 4(r3)
	fsw	f1, 2(r1)
	lw	r1, 0(r0)
	addi	r1, r1, -1
	sw	r2, 11(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r1, r0, 778				# set min_caml_reflections
	add	r2, r0, r4
	addi	r4, r4, 3
	flw	f1, 2(r3)
	fsw	f1, 2(r2)
	lw	r5, 11(r3)
	sw	r5, 1(r2)
	lw	r5, 1(r3)
	sw	r5, 0(r2)
	lw	r5, 0(r3)
	add	r30, r1, r5
	sw	r2, 0(r30)
	jr	r31				#
setup_rect_reflection.3335:
	slli	r1, r1, 2
	lw	r5, 1023(r0)
	flup	f1, 2		# fli	f1, 1.000000
	lw	r2, 7(r2)
	flw	f2, 0(r2)
	fsub	f1, f1, f2
	flw	f2, 667(r0)
	fneg	f2, f2
	flw	f3, 668(r0)
	fneg	f3, f3
	flw	f4, 669(r0)
	fneg	f4, f4
	addi	r2, r1, 1
	flw	f5, 667(r0)
	addi	r6, r0, 3
	flup	f6, 0		# fli	f6, 0.000000
	fsw	f2, 0(r3)
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	fsw	f1, 6(r3)
	fsw	f4, 8(r3)
	fsw	f3, 10(r3)
	fsw	f5, 12(r3)
	add	r1, r0, r6				# mr	r1, r6
	fadd	f1, f0, f6				# fmr	f1, f6
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r5, 14(r3)
	sw	r5, 0(r2)
	flw	f1, 12(r3)
	fsw	f1, 0(r5)
	flw	f1, 10(r3)
	fsw	f1, 1(r5)
	flw	f2, 8(r3)
	fsw	f2, 2(r5)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r2, 15(r3)
	bgei	0, r6, bge_then.16975
	j	bge_cont.16976
bge_then.16975:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.16977
	beqi	2, r8, beq_then.16979
	sw	r6, 16(r3)
	sw	r1, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16980
beq_then.16979:
	sw	r6, 16(r3)
	sw	r1, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16980:
	j	beq_cont.16978
beq_then.16977:
	sw	r6, 16(r3)
	sw	r1, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16978:
	addi	r2, r2, -1
	lw	r1, 15(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -19
	lw	r31, 18(r3)
bge_cont.16976:
	addi	r1, r0, 778				# set min_caml_reflections
	add	r2, r0, r4
	addi	r4, r4, 3
	flw	f1, 6(r3)
	fsw	f1, 2(r2)
	lw	r5, 15(r3)
	sw	r5, 1(r2)
	lw	r5, 4(r3)
	sw	r5, 0(r2)
	lw	r5, 3(r3)
	add	r30, r1, r5
	sw	r2, 0(r30)
	addi	r1, r5, 1
	lw	r2, 2(r3)
	addi	r6, r2, 2
	flw	f2, 668(r0)
	addi	r7, r0, 3
	flup	f3, 0		# fli	f3, 0.000000
	sw	r1, 18(r3)
	sw	r6, 19(r3)
	fsw	f2, 20(r3)
	add	r1, r0, r7				# mr	r1, r7
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -23
	lw	r31, 22(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 22(r3)
	sw	r31, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -24
	lw	r31, 23(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r5, 22(r3)
	sw	r5, 0(r2)
	flw	f1, 0(r3)
	fsw	f1, 0(r5)
	flw	f2, 20(r3)
	fsw	f2, 1(r5)
	flw	f2, 8(r3)
	fsw	f2, 2(r5)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r2, 23(r3)
	bgei	0, r6, bge_then.16981
	j	bge_cont.16982
bge_then.16981:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.16983
	beqi	2, r8, beq_then.16985
	sw	r6, 24(r3)
	sw	r1, 25(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 24(r3)
	lw	r5, 25(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16986
beq_then.16985:
	sw	r6, 24(r3)
	sw	r1, 25(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 24(r3)
	lw	r5, 25(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16986:
	j	beq_cont.16984
beq_then.16983:
	sw	r6, 24(r3)
	sw	r1, 25(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 24(r3)
	lw	r5, 25(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16984:
	addi	r2, r2, -1
	lw	r1, 23(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -27
	lw	r31, 26(r3)
bge_cont.16982:
	addi	r1, r0, 778				# set min_caml_reflections
	add	r2, r0, r4
	addi	r4, r4, 3
	flw	f1, 6(r3)
	fsw	f1, 2(r2)
	lw	r5, 23(r3)
	sw	r5, 1(r2)
	lw	r5, 19(r3)
	sw	r5, 0(r2)
	lw	r5, 18(r3)
	add	r30, r1, r5
	sw	r2, 0(r30)
	lw	r1, 3(r3)
	addi	r2, r1, 2
	lw	r5, 2(r3)
	addi	r5, r5, 3
	flw	f2, 669(r0)
	addi	r6, r0, 3
	flup	f3, 0		# fli	f3, 0.000000
	sw	r2, 26(r3)
	sw	r5, 27(r3)
	fsw	f2, 28(r3)
	add	r1, r0, r6				# mr	r1, r6
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -31
	lw	r31, 30(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 30(r3)
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
	flw	f1, 0(r3)
	fsw	f1, 0(r5)
	flw	f1, 10(r3)
	fsw	f1, 1(r5)
	flw	f1, 28(r3)
	fsw	f1, 2(r5)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r2, 31(r3)
	bgei	0, r6, bge_then.16987
	j	bge_cont.16988
bge_then.16987:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.16989
	beqi	2, r8, beq_then.16991
	sw	r6, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16992
beq_then.16991:
	sw	r6, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16992:
	j	beq_cont.16990
beq_then.16989:
	sw	r6, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16990:
	addi	r2, r2, -1
	lw	r1, 31(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -35
	lw	r31, 34(r3)
bge_cont.16988:
	addi	r1, r0, 778				# set min_caml_reflections
	add	r2, r0, r4
	addi	r4, r4, 3
	flw	f1, 6(r3)
	fsw	f1, 2(r2)
	lw	r5, 31(r3)
	sw	r5, 1(r2)
	lw	r5, 27(r3)
	sw	r5, 0(r2)
	lw	r5, 26(r3)
	add	r30, r1, r5
	sw	r2, 0(r30)
	lw	r1, 3(r3)
	addi	r1, r1, 3
	sw	r1, 1023(r0)
	jr	r31				#
setup_surface_reflection.3338:
	slli	r1, r1, 2
	addi	r1, r1, 1
	lw	r5, 1023(r0)
	flup	f1, 2		# fli	f1, 1.000000
	lw	r6, 7(r2)
	flw	f2, 0(r6)
	fsub	f1, f1, f2
	lw	r6, 4(r2)
	flw	f2, 667(r0)
	flw	f3, 0(r6)
	fmul	f2, f2, f3
	flw	f3, 668(r0)
	flw	f4, 1(r6)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flw	f3, 669(r0)
	flw	f4, 2(r6)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flup	f3, 3		# fli	f3, 2.000000
	lw	r6, 4(r2)
	flw	f4, 0(r6)
	fmul	f3, f3, f4
	fmul	f3, f3, f2
	flw	f4, 667(r0)
	fsub	f3, f3, f4
	flup	f4, 3		# fli	f4, 2.000000
	lw	r6, 4(r2)
	flw	f5, 1(r6)
	fmul	f4, f4, f5
	fmul	f4, f4, f2
	flw	f5, 668(r0)
	fsub	f4, f4, f5
	flup	f5, 3		# fli	f5, 2.000000
	lw	r2, 4(r2)
	flw	f6, 2(r2)
	fmul	f5, f5, f6
	fmul	f2, f5, f2
	flw	f5, 669(r0)
	fsub	f2, f2, f5
	addi	r2, r0, 3
	flup	f5, 0		# fli	f5, 0.000000
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	fsw	f1, 2(r3)
	fsw	f2, 4(r3)
	fsw	f4, 6(r3)
	fsw	f3, 8(r3)
	add	r1, r0, r2				# mr	r1, r2
	fadd	f1, f0, f5				# fmr	f1, f5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r0)
	sw	r2, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r5, 10(r3)
	sw	r5, 0(r2)
	flw	f1, 8(r3)
	fsw	f1, 0(r5)
	flw	f1, 6(r3)
	fsw	f1, 1(r5)
	flw	f1, 4(r3)
	fsw	f1, 2(r5)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r2, 11(r3)
	bgei	0, r6, bge_then.16994
	j	bge_cont.16995
bge_then.16994:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.16996
	beqi	2, r8, beq_then.16998
	sw	r6, 12(r3)
	sw	r1, 13(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16999
beq_then.16998:
	sw	r6, 12(r3)
	sw	r1, 13(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16999:
	j	beq_cont.16997
beq_then.16996:
	sw	r6, 12(r3)
	sw	r1, 13(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16997:
	addi	r2, r2, -1
	lw	r1, 11(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -15
	lw	r31, 14(r3)
bge_cont.16995:
	addi	r1, r0, 778				# set min_caml_reflections
	add	r2, r0, r4
	addi	r4, r4, 3
	flw	f1, 2(r3)
	fsw	f1, 2(r2)
	lw	r5, 11(r3)
	sw	r5, 1(r2)
	lw	r5, 1(r3)
	sw	r5, 0(r2)
	lw	r5, 0(r3)
	add	r30, r1, r5
	sw	r2, 0(r30)
	addi	r1, r5, 1
	sw	r1, 1023(r0)
	jr	r31				#
setup_reflections.3341:
	bgei	0, r1, bge_then.17001
	jr	r31				#
bge_then.17001:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.17003
	jr	r31				#
beq_then.17003:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 7(r2)
	flw	f2, 0(r5)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17005
	jr	r31				#
fle_else.17005:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.17007
	beqi	2, r5, beq_then.17008
	jr	r31				#
beq_then.17008:
	j	setup_surface_reflection.3338
beq_then.17007:
	j	setup_rect_reflection.3335
rt.3343:
	sw	r1, 743(r0)
	sw	r2, 744(r0)
	srai	r5, r1, 1
	sw	r5, 745(r0)
	srai	r2, r2, 1
	sw	r2, 746(r0)
	flup	f1, 49		# fli	f1, 128.000000
	itof	f2, r1
	fdiv	f1, f1, f2
	fsw	f1, 747(r0)
	lw	r1, 743(r0)
	addi	r2, r0, 3
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
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
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
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -6
	lw	r31, 5(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
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
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r4
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
	lw	r1, 0(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 743(r0)
	addi	r2, r2, -2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	init_line_elements.3287				#	bl	init_line_elements.3287
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 743(r0)
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 8(r3)
	sw	r2, 9(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -11
	lw	r31, 10(r3)
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 11(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 12(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -14
	lw	r31, 13(r3)
	sw	r1, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -15
	lw	r31, 14(r3)
	sw	r1, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
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
	sw	r1, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -18
	lw	r31, 17(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 16(r3)
	sw	r1, 6(r2)
	lw	r1, 15(r3)
	sw	r1, 5(r2)
	lw	r1, 14(r3)
	sw	r1, 4(r2)
	lw	r1, 13(r3)
	sw	r1, 3(r2)
	lw	r1, 12(r3)
	sw	r1, 2(r2)
	lw	r1, 11(r3)
	sw	r1, 1(r2)
	lw	r1, 10(r3)
	sw	r1, 0(r2)
	lw	r1, 9(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r2, 743(r0)
	addi	r2, r2, -2
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	init_line_elements.3287				#	bl	init_line_elements.3287
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r2, 743(r0)
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 17(r3)
	sw	r2, 18(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -20
	lw	r31, 19(r3)
	sw	r1, 19(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -21
	lw	r31, 20(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 20(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -22
	lw	r31, 21(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 21(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -23
	lw	r31, 22(r3)
	sw	r1, 22(r3)
	sw	r31, 23(r3)
	addi	r3, r3, 24
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -24
	lw	r31, 23(r3)
	sw	r1, 23(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -25
	lw	r31, 24(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 24(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -26
	lw	r31, 25(r3)
	sw	r1, 25(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	create_float5x3array.3283				#	bl	create_float5x3array.3283
	addi	r3, r3, -27
	lw	r31, 26(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 25(r3)
	sw	r1, 6(r2)
	lw	r1, 24(r3)
	sw	r1, 5(r2)
	lw	r1, 23(r3)
	sw	r1, 4(r2)
	lw	r1, 22(r3)
	sw	r1, 3(r2)
	lw	r1, 21(r3)
	sw	r1, 2(r2)
	lw	r1, 20(r3)
	sw	r1, 1(r2)
	lw	r1, 19(r3)
	sw	r1, 0(r2)
	lw	r1, 18(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 743(r0)
	addi	r2, r2, -2
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	init_line_elements.3287				#	bl	init_line_elements.3287
	addi	r3, r3, -27
	lw	r31, 26(r3)
	sw	r1, 26(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	read_screen_settings.2989				#	bl	read_screen_settings.2989
	addi	r3, r3, -28
	lw	r31, 27(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	read_light.2991				#	bl	read_light.2991
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r1, r0, 0
	sw	r1, 27(r3)
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -29
	lw	r31, 28(r3)
	beqi	0, r1, beq_then.17010
	addi	r1, r0, 1
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_object.2998				#	bl	read_object.2998
	addi	r3, r3, -29
	lw	r31, 28(r3)
	j	beq_cont.17011
beq_then.17010:
	lw	r1, 27(r3)
	sw	r1, 0(r0)
beq_cont.17011:
	addi	r1, r0, 0
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_and_network.3006				#	bl	read_and_network.3006
	addi	r3, r3, -29
	lw	r31, 28(r3)
	addi	r1, r0, 0
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_or_network.3004				#	bl	read_or_network.3004
	addi	r3, r3, -29
	lw	r31, 28(r3)
	sw	r1, 723(r0)
	addi	r1, r0, 80
	out	r1
	addi	r1, r0, 51
	out	r1
	addi	r1, r0, 10
	out	r1
	lw	r1, 743(r0)
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -29
	lw	r31, 28(r3)
	addi	r1, r0, 32
	out	r1
	lw	r1, 744(r0)
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -29
	lw	r31, 28(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 255
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -29
	lw	r31, 28(r3)
	addi	r1, r0, 10
	out	r1
	addi	r1, r0, 4
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	create_dirvecs.3319				#	bl	create_dirvecs.3319
	addi	r3, r3, -29
	lw	r31, 28(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	calc_dirvec_rows.3310				#	bl	calc_dirvec_rows.3310
	addi	r3, r3, -29
	lw	r31, 28(r3)
	lw	r1, 770(r0)
	lw	r2, 119(r1)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	sw	r1, 28(r3)
	bgei	0, r5, bge_then.17012
	j	bge_cont.17013
bge_then.17012:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 29(r3)
	beqi	1, r9, beq_then.17014
	beqi	2, r9, beq_then.17016
	sw	r5, 30(r3)
	sw	r7, 31(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -33
	lw	r31, 32(r3)
	lw	r2, 30(r3)
	lw	r5, 31(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17017
beq_then.17016:
	sw	r5, 30(r3)
	sw	r7, 31(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -33
	lw	r31, 32(r3)
	lw	r2, 30(r3)
	lw	r5, 31(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17017:
	j	beq_cont.17015
beq_then.17014:
	sw	r5, 30(r3)
	sw	r7, 31(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -33
	lw	r31, 32(r3)
	lw	r2, 30(r3)
	lw	r5, 31(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17015:
	addi	r2, r2, -1
	lw	r1, 29(r3)
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -33
	lw	r31, 32(r3)
bge_cont.17013:
	addi	r2, r0, 118
	lw	r1, 28(r3)
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -33
	lw	r31, 32(r3)
	lw	r1, 769(r0)
	addi	r2, r0, 119
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -33
	lw	r31, 32(r3)
	addi	r1, r0, 2
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	init_vecset_constants.3324				#	bl	init_vecset_constants.3324
	addi	r3, r3, -33
	lw	r31, 32(r3)
	addi	r1, r0, 1021				# set min_caml_light_dirvec
	lw	r1, 0(r1)
	flw	f1, 667(r0)
	fsw	f1, 0(r1)
	flw	f1, 668(r0)
	fsw	f1, 1(r1)
	flw	f1, 669(r0)
	fsw	f1, 2(r1)
	addi	r1, r0, 1021				# set min_caml_light_dirvec
	lw	r2, 0(r0)
	addi	r2, r2, -1
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -33
	lw	r31, 32(r3)
	lw	r1, 0(r0)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.17018
	j	bge_cont.17019
bge_then.17018:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.17020
	j	beq_cont.17021
beq_then.17020:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 7(r2)
	flw	f2, 0(r5)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17022
	j	fle_cont.17023
fle_else.17022:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.17024
	beqi	2, r5, beq_then.17026
	j	beq_cont.17027
beq_then.17026:
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	setup_surface_reflection.3338				#	bl	setup_surface_reflection.3338
	addi	r3, r3, -33
	lw	r31, 32(r3)
beq_cont.17027:
	j	beq_cont.17025
beq_then.17024:
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	setup_rect_reflection.3335				#	bl	setup_rect_reflection.3335
	addi	r3, r3, -33
	lw	r31, 32(r3)
beq_cont.17025:
fle_cont.17023:
beq_cont.17021:
bge_cont.17019:
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r1, 17(r3)
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	pretrace_line.3267				#	bl	pretrace_line.3267
	addi	r3, r3, -33
	lw	r31, 32(r3)
	addi	r2, r0, 0
	addi	r5, r0, 2
	lw	r1, 744(r0)
	blei	0, r1, ble_then.17028
	lw	r1, 744(r0)
	addi	r1, r1, -1
	sw	r2, 32(r3)
	blei	0, r1, ble_then.17029
	addi	r1, r0, 1
	lw	r6, 26(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	pretrace_line.3267				#	bl	pretrace_line.3267
	addi	r3, r3, -34
	lw	r31, 33(r3)
	j	ble_cont.17030
ble_then.17029:
ble_cont.17030:
	addi	r1, r0, 0
	lw	r2, 32(r3)
	lw	r5, 8(r3)
	lw	r6, 17(r3)
	lw	r7, 26(r3)
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	scan_pixel.3271				#	bl	scan_pixel.3271
	addi	r3, r3, -34
	lw	r31, 33(r3)
	addi	r1, r0, 1
	addi	r7, r0, 4
	lw	r2, 17(r3)
	lw	r5, 26(r3)
	lw	r6, 8(r3)
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	scan_line.3277				#	bl	scan_line.3277
	addi	r3, r3, -34
	lw	r31, 33(r3)
	jr	r31				#
ble_then.17028:
	jr	r31				#
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
	jal	rt.3343				#	bl	rt.3343
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	_R_0, r0, 0
