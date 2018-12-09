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
	beq	r0, r30, fle_else.15673
	addi	r1, r0, 0
	jr	r31				#
fle_else.15673:
	addi	r1, r0, 1
	jr	r31				#
fisneg.2805:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15674
	addi	r1, r0, 0
	jr	r31				#
fle_else.15674:
	addi	r1, r0, 1
	jr	r31				#
fiszero.2807:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15675
	addi	r1, r0, 1
	jr	r31				#
feq_else.15675:
	addi	r1, r0, 0
	jr	r31				#
xor.2809:
	beq	r1, r2, beq_then.15676
	addi	r1, r0, 1
	jr	r31				#
beq_then.15676:
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
	beq	r0, r30, fle_else.15677
	jr	r31				#
fle_else.15677:
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
	beq	r0, r30, fle_else.15678
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15678:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
	jr	r31				#
hoge.2824:
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
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15688
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15689
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15690
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15691
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15692
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15693
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15694
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2824
fle_else.15694:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15693:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15692:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15691:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15690:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15689:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15688:
	fadd	f1, f0, f2
	jr	r31				#
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
fuga.2827:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15695
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15696
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15697
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15698
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2827
fle_else.15698:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2827
fle_else.15697:
	jr	r31				#
fle_else.15696:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15699
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15700
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2827
fle_else.15700:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2827
fle_else.15699:
	jr	r31				#
fle_else.15695:
	jr	r31				#
modulo_2pi.2831:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 0(r3)
	fsw	f1, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15701
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15703
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15705
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15707
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15709
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15711
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15713
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15715
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15717
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15719
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15721
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15723
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15725
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15727
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15729
	addi	r30, r0, 4060
	lui	r30, r30, 18505	# to load float		205887.438848
	fmvfr	f2, r30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	hoge.2824				#	bl	hoge.2824
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	fle_cont.15730
fle_else.15729:
	fadd	f1, f0, f2
fle_cont.15730:
	j	fle_cont.15728
fle_else.15727:
	fadd	f1, f0, f2
fle_cont.15728:
	j	fle_cont.15726
fle_else.15725:
	fadd	f1, f0, f2
fle_cont.15726:
	j	fle_cont.15724
fle_else.15723:
	fadd	f1, f0, f2
fle_cont.15724:
	j	fle_cont.15722
fle_else.15721:
	fadd	f1, f0, f2
fle_cont.15722:
	j	fle_cont.15720
fle_else.15719:
	fadd	f1, f0, f2
fle_cont.15720:
	j	fle_cont.15718
fle_else.15717:
	fadd	f1, f0, f2
fle_cont.15718:
	j	fle_cont.15716
fle_else.15715:
	fadd	f1, f0, f2
fle_cont.15716:
	j	fle_cont.15714
fle_else.15713:
	fadd	f1, f0, f2
fle_cont.15714:
	j	fle_cont.15712
fle_else.15711:
	fadd	f1, f0, f2
fle_cont.15712:
	j	fle_cont.15710
fle_else.15709:
	fadd	f1, f0, f2
fle_cont.15710:
	j	fle_cont.15708
fle_else.15707:
	fadd	f1, f0, f2
fle_cont.15708:
	j	fle_cont.15706
fle_else.15705:
	fadd	f1, f0, f2
fle_cont.15706:
	j	fle_cont.15704
fle_else.15703:
	fadd	f1, f0, f2
fle_cont.15704:
	j	fle_cont.15702
fle_else.15701:
	fadd	f1, f0, f2
fle_cont.15702:
	flup	f2, 5		# fli	f2, 6.283186
	flw	f3, 2(r3)
	fle	r30, f2, f3
	beq	r0, r30, fle_else.15731
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15732
	fsub	f2, f3, f1
	flup	f3, 3		# fli	f3, 2.000000
	fdiv	f1, f1, f3
	flw	f3, 0(r3)
	fadd	f30, f0, f2				# fmr	f30, f2
	fadd	f2, f0, f1				# fmr	f2, f1
	fadd	f1, f0, f30				# fmr	f1, f30
	j	fuga.2827
fle_else.15732:
	flup	f2, 3		# fli	f2, 2.000000
	fdiv	f2, f1, f2
	flw	f1, 0(r3)
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f30				# fmr	f1, f30
	j	fuga.2827
fle_else.15731:
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
	beq	r0, r30, fle_else.15733
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.15734
fle_else.15733:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.15734:
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
	beq	r0, r30, fle_else.15735
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15737
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15739
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15741
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15743
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15745
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15747
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15749
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15751
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15753
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15755
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15757
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15759
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15761
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2824				#	bl	hoge.2824
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.15762
fle_else.15761:
fle_cont.15762:
	j	fle_cont.15760
fle_else.15759:
fle_cont.15760:
	j	fle_cont.15758
fle_else.15757:
fle_cont.15758:
	j	fle_cont.15756
fle_else.15755:
fle_cont.15756:
	j	fle_cont.15754
fle_else.15753:
fle_cont.15754:
	j	fle_cont.15752
fle_else.15751:
fle_cont.15752:
	j	fle_cont.15750
fle_else.15749:
fle_cont.15750:
	j	fle_cont.15748
fle_else.15747:
fle_cont.15748:
	j	fle_cont.15746
fle_else.15745:
fle_cont.15746:
	j	fle_cont.15744
fle_else.15743:
fle_cont.15744:
	j	fle_cont.15742
fle_else.15741:
fle_cont.15742:
	j	fle_cont.15740
fle_else.15739:
fle_cont.15740:
	j	fle_cont.15738
fle_else.15737:
fle_cont.15738:
	j	fle_cont.15736
fle_else.15735:
fle_cont.15736:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2827				#	bl	fuga.2827
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15763
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15764
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15765
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
fle_else.15765:
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
fle_else.15764:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15766
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
fle_else.15766:
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
fle_else.15763:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15767
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15768
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
fle_else.15768:
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
fle_else.15767:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15769
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
fle_else.15769:
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
	beq	r0, r30, fle_else.15770
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15772
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15774
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15776
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15778
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15780
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15782
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15784
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15786
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15788
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15790
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15792
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15794
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15796
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2824				#	bl	hoge.2824
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.15797
fle_else.15796:
fle_cont.15797:
	j	fle_cont.15795
fle_else.15794:
fle_cont.15795:
	j	fle_cont.15793
fle_else.15792:
fle_cont.15793:
	j	fle_cont.15791
fle_else.15790:
fle_cont.15791:
	j	fle_cont.15789
fle_else.15788:
fle_cont.15789:
	j	fle_cont.15787
fle_else.15786:
fle_cont.15787:
	j	fle_cont.15785
fle_else.15784:
fle_cont.15785:
	j	fle_cont.15783
fle_else.15782:
fle_cont.15783:
	j	fle_cont.15781
fle_else.15780:
fle_cont.15781:
	j	fle_cont.15779
fle_else.15778:
fle_cont.15779:
	j	fle_cont.15777
fle_else.15776:
fle_cont.15777:
	j	fle_cont.15775
fle_else.15774:
fle_cont.15775:
	j	fle_cont.15773
fle_else.15772:
fle_cont.15773:
	j	fle_cont.15771
fle_else.15770:
fle_cont.15771:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2827				#	bl	fuga.2827
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15798
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15799
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15800
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
fle_else.15800:
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
fle_else.15799:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15801
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
fle_else.15801:
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
fle_else.15798:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15802
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15803
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
fle_else.15803:
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
fle_else.15802:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15804
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
fle_else.15804:
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
	beq	r0, r30, fle_else.15805
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.15806
fle_else.15805:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.15806:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15807
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15808
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
fle_else.15808:
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
fle_else.15807:
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
	ble	r7, r1, ble_then.15809
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r7, r5, 3
	slli	r8, r5, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.15810
	j	div10_sub.2849
ble_then.15810:
	slli	r2, r5, 3
	slli	r7, r5, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15811
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	j	div10_sub.2849
ble_then.15811:
	add	r1, r0, r5
	jr	r31				#
ble_then.15809:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15812
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r7, r2, 3
	slli	r8, r2, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.15813
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r6				# mr	r2, r6
	j	div10_sub.2849
ble_then.15813:
	slli	r6, r2, 3
	slli	r7, r2, 1
	add	r6, r6, r7
	addi	r6, r6, 9
	ble	r1, r6, ble_then.15814
	j	div10_sub.2849
ble_then.15814:
	add	r1, r0, r2
	jr	r31				#
ble_then.15812:
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
	addi	r2, r0, 10
	ble	r2, r1, ble_then.15815
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.15815:
	slli	r2, r1, 7
	slli	r5, r1, 6
	add	r2, r2, r5
	slli	r5, r1, 3
	add	r2, r2, r5
	slli	r5, r1, 2
	add	r2, r2, r5
	add	r2, r2, r1
	srli	r2, r2, 11
	addi	r5, r0, 10
	sw	r1, 0(r3)
	ble	r5, r2, ble_then.15816
	addi	r5, r2, 48
	out	r5
	j	ble_cont.15817
ble_then.15816:
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
ble_cont.15817:
	slli	r1, r2, 3
	slli	r2, r2, 1
	add	r1, r1, r2
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
	jr	r31				#
print_int.2857:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.15818
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	j	print_int.2857
ble_then.15818:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.15819
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.15819:
	addi	r2, r0, 100
	ble	r2, r1, ble_then.15820
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
ble_then.15820:
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
	beqi	0, r1, beq_then.15821
	beqi	0, r2, beq_then.15822
	addi	r1, r0, 0
	jr	r31				#
beq_then.15822:
	addi	r1, r0, 1
	jr	r31				#
beq_then.15821:
	add	r1, r0, r2
	jr	r31				#
sgn.2862:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15823
	addi	r1, r0, 1
	j	feq_cont.15824
feq_else.15823:
	addi	r1, r0, 0
feq_cont.15824:
	beqi	0, r1, beq_then.15825
	flup	f1, 0		# fli	f1, 0.000000
	jr	r31				#
beq_then.15825:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15826
	addi	r1, r0, 0
	j	fle_cont.15827
fle_else.15826:
	addi	r1, r0, 1
fle_cont.15827:
	beqi	0, r1, beq_then.15828
	flup	f1, 2		# fli	f1, 1.000000
	jr	r31				#
beq_then.15828:
	flup	f1, 11		# fli	f1, -1.000000
	jr	r31				#
fneg_cond.2864:
	beqi	0, r1, beq_then.15829
	jr	r31				#
beq_then.15829:
	fneg	f1, f1
	jr	r31				#
add_mod5.2867:
	add	r1, r1, r2
	addi	r2, r0, 5
	ble	r2, r1, ble_then.15830
	jr	r31				#
ble_then.15830:
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
	beq	r0, r30, feq_else.15836
	addi	r5, r0, 1
	j	feq_cont.15837
feq_else.15836:
	addi	r5, r0, 0
feq_cont.15837:
	beqi	0, r5, beq_then.15838
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.15839
beq_then.15838:
	beqi	0, r2, beq_then.15840
	flup	f2, 11		# fli	f2, -1.000000
	fdiv	f1, f2, f1
	j	beq_cont.15841
beq_then.15840:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
beq_cont.15841:
beq_cont.15839:
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
	addi	r1, r0, 10661
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 10661
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	fsw	f1, 1(r1)
	addi	r1, r0, 10661
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	fsw	f1, 2(r1)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -4
	lw	r31, 3(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	fsw	f1, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2837				#	bl	sin.2837
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fsw	f1, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	fsw	f1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fsw	f1, 12(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin.2837				#	bl	sin.2837
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r1, r0, 10760
	flw	f2, 6(r3)
	fmul	f3, f2, f1
	flup	f4, 26		# fli	f4, 200.000000
	fmul	f3, f3, f4
	fsw	f3, 0(r1)
	addi	r1, r0, 10760
	flup	f3, 27		# fli	f3, -200.000000
	flw	f4, 8(r3)
	fmul	f3, f4, f3
	fsw	f3, 1(r1)
	addi	r1, r0, 10760
	flw	f3, 12(r3)
	fmul	f5, f2, f3
	flup	f6, 26		# fli	f6, 200.000000
	fmul	f5, f5, f6
	fsw	f5, 2(r1)
	addi	r1, r0, 10754
	fsw	f3, 0(r1)
	addi	r1, r0, 10754
	flup	f5, 0		# fli	f5, 0.000000
	fsw	f5, 1(r1)
	addi	r1, r0, 10754
	fneg	f5, f1
	fsw	f5, 2(r1)
	addi	r1, r0, 10757
	fneg	f4, f4
	fmul	f1, f4, f1
	fsw	f1, 0(r1)
	addi	r1, r0, 10757
	fneg	f1, f2
	fsw	f1, 1(r1)
	addi	r1, r0, 10757
	fmul	f1, f4, f3
	fsw	f1, 2(r1)
	addi	r1, r0, 10664
	addi	r2, r0, 10661
	flw	f1, 0(r2)
	addi	r2, r0, 10760
	flw	f2, 0(r2)
	fsub	f1, f1, f2
	fsw	f1, 0(r1)
	addi	r1, r0, 10664
	addi	r2, r0, 10661
	flw	f1, 1(r2)
	addi	r2, r0, 10760
	flw	f2, 1(r2)
	fsub	f1, f1, f2
	fsw	f1, 1(r1)
	addi	r1, r0, 10664
	addi	r2, r0, 10661
	flw	f1, 2(r2)
	addi	r2, r0, 10760
	flw	f2, 2(r2)
	fsub	f1, f1, f2
	fsw	f1, 2(r1)
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
	addi	r1, r0, 10667
	fneg	f1, f1
	fsw	f1, 1(r1)
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
	addi	r1, r0, 10667
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	flw	f1, 2(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 10667
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	fsw	f1, 2(r1)
	addi	r1, r0, 10670
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				#	bl	lib_read_float
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	fsw	f1, 0(r1)
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
	beqi	-1, r1, beq_then.15853
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
	beq	r0, r30, fle_else.15854
	addi	r1, r0, 0
	j	fle_cont.15855
fle_else.15854:
	addi	r1, r0, 1
fle_cont.15855:
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
	beqi	0, r2, beq_then.15856
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
	j	beq_cont.15857
beq_then.15856:
beq_cont.15857:
	lw	r2, 2(r3)
	beqi	2, r2, beq_then.15858
	lw	r5, 7(r3)
	j	beq_cont.15859
beq_then.15858:
	addi	r5, r0, 1
beq_cont.15859:
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
	addi	r8, r0, 10001
	lw	r9, 0(r3)
	add	r30, r8, r9
	sw	r2, 0(r30)
	beqi	3, r7, beq_then.15860
	beqi	2, r7, beq_then.15862
	j	beq_cont.15863
beq_then.15862:
	lw	r2, 7(r3)
	beqi	0, r2, beq_then.15864
	addi	r2, r0, 0
	j	beq_cont.15865
beq_then.15864:
	addi	r2, r0, 1
beq_cont.15865:
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	vecunit_sgn.2888				#	bl	vecunit_sgn.2888
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.15863:
	j	beq_cont.15861
beq_then.15860:
	flw	f1, 0(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15866
	addi	r2, r0, 1
	j	feq_cont.15867
feq_else.15866:
	addi	r2, r0, 0
feq_cont.15867:
	beqi	0, r2, beq_then.15868
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.15869
beq_then.15868:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15870
	addi	r2, r0, 1
	j	feq_cont.15871
feq_else.15870:
	addi	r2, r0, 0
feq_cont.15871:
	beqi	0, r2, beq_then.15872
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.15873
beq_then.15872:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15874
	addi	r2, r0, 0
	j	fle_cont.15875
fle_else.15874:
	addi	r2, r0, 1
fle_cont.15875:
	beqi	0, r2, beq_then.15876
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.15877
beq_then.15876:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.15877:
beq_cont.15873:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.15869:
	fsw	f1, 0(r5)
	flw	f1, 1(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15878
	addi	r2, r0, 1
	j	feq_cont.15879
feq_else.15878:
	addi	r2, r0, 0
feq_cont.15879:
	beqi	0, r2, beq_then.15880
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.15881
beq_then.15880:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15882
	addi	r2, r0, 1
	j	feq_cont.15883
feq_else.15882:
	addi	r2, r0, 0
feq_cont.15883:
	beqi	0, r2, beq_then.15884
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.15885
beq_then.15884:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15886
	addi	r2, r0, 0
	j	fle_cont.15887
fle_else.15886:
	addi	r2, r0, 1
fle_cont.15887:
	beqi	0, r2, beq_then.15888
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.15889
beq_then.15888:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.15889:
beq_cont.15885:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.15881:
	fsw	f1, 1(r5)
	flw	f1, 2(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15890
	addi	r2, r0, 1
	j	feq_cont.15891
feq_else.15890:
	addi	r2, r0, 0
feq_cont.15891:
	beqi	0, r2, beq_then.15892
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.15893
beq_then.15892:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15894
	addi	r2, r0, 1
	j	feq_cont.15895
feq_else.15894:
	addi	r2, r0, 0
feq_cont.15895:
	beqi	0, r2, beq_then.15896
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.15897
beq_then.15896:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15898
	addi	r2, r0, 0
	j	fle_cont.15899
fle_else.15898:
	addi	r2, r0, 1
fle_cont.15899:
	beqi	0, r2, beq_then.15900
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.15901
beq_then.15900:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.15901:
beq_cont.15897:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.15893:
	fsw	f1, 2(r5)
beq_cont.15861:
	lw	r1, 4(r3)
	beqi	0, r1, beq_then.15902
	lw	r1, 5(r3)
	lw	r2, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	rotate_quadratic_matrix.2993				#	bl	rotate_quadratic_matrix.2993
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.15903
beq_then.15902:
beq_cont.15903:
	addi	r1, r0, 1
	jr	r31				#
beq_then.15853:
	addi	r1, r0, 0
	jr	r31				#
read_object.2998:
	addi	r2, r0, 60
	ble	r2, r1, ble_then.15904
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.15905
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.15906
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.15907
	lw	r1, 1(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.15908
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.15909
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.15910
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.15911
	lw	r1, 3(r3)
	addi	r1, r1, 1
	j	read_object.2998
beq_then.15911:
	addi	r1, r0, 10000
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.15910:
	jr	r31				#
beq_then.15909:
	addi	r1, r0, 10000
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.15908:
	jr	r31				#
beq_then.15907:
	addi	r1, r0, 10000
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.15906:
	jr	r31				#
beq_then.15905:
	addi	r1, r0, 10000
	lw	r2, 0(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.15904:
	jr	r31				#
read_all_object.3000:
	addi	r1, r0, 0
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.15920
	addi	r1, r0, 1
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.15921
	addi	r1, r0, 2
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.15922
	addi	r1, r0, 3
	j	read_object.2998
beq_then.15922:
	addi	r1, r0, 10000
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	jr	r31				#
beq_then.15921:
	addi	r1, r0, 10000
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	jr	r31				#
beq_then.15920:
	addi	r1, r0, 10000
	lw	r2, 0(r3)
	sw	r2, 0(r1)
	jr	r31				#
read_net_item.3002:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.15926
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.15927
	lw	r2, 2(r3)
	addi	r5, r2, 1
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.15929
	lw	r2, 4(r3)
	addi	r5, r2, 1
	sw	r1, 5(r3)
	sw	r5, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.15931
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
	j	beq_cont.15932
beq_then.15931:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.15932:
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.15930
beq_then.15929:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.15930:
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.15928
beq_then.15927:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.15928:
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.15926:
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
	beqi	-1, r1, beq_then.15933
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.15935
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.15937
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
	j	beq_cont.15938
beq_then.15937:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15938:
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.15936
beq_then.15935:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15936:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.15934
beq_then.15933:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.15934:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.15939
	lw	r1, 0(r3)
	addi	r5, r1, 1
	sw	r2, 4(r3)
	sw	r5, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.15940
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.15942
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
	j	beq_cont.15943
beq_then.15942:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.15943:
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.15941
beq_then.15940:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.15941:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.15944
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
	j	beq_cont.15945
beq_then.15944:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.15945:
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.15939:
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
	beqi	-1, r1, beq_then.15946
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.15948
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.15950
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
	j	beq_cont.15951
beq_then.15950:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15951:
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.15949
beq_then.15948:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15949:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	j	beq_cont.15947
beq_then.15946:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15947:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.15952
	addi	r2, r0, 10672
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
	beqi	-1, r1, beq_then.15953
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.15955
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
	j	beq_cont.15956
beq_then.15955:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.15956:
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	j	beq_cont.15954
beq_then.15953:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.15954:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.15957
	addi	r2, r0, 10672
	lw	r5, 4(r3)
	add	r30, r2, r5
	sw	r1, 0(r30)
	addi	r1, r5, 1
	j	read_and_network.3006
beq_then.15957:
	jr	r31				#
beq_then.15952:
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
	beqi	0, r1, beq_then.15960
	addi	r1, r0, 1
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				#	bl	read_nth_object.2996
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.15962
	addi	r1, r0, 2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_object.2998				#	bl	read_object.2998
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.15963
beq_then.15962:
	addi	r1, r0, 10000
	lw	r2, 1(r3)
	sw	r2, 0(r1)
beq_cont.15963:
	j	beq_cont.15961
beq_then.15960:
	addi	r1, r0, 10000
	lw	r2, 0(r3)
	sw	r2, 0(r1)
beq_cont.15961:
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.15964
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.15966
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
	j	beq_cont.15967
beq_then.15966:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15967:
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	j	beq_cont.15965
beq_then.15964:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15965:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.15968
	addi	r2, r0, 10672
	sw	r1, 0(r2)
	addi	r1, r0, 1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_and_network.3006				#	bl	read_and_network.3006
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.15969
beq_then.15968:
beq_cont.15969:
	addi	r1, r0, 10723
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.15970
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.15972
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
	j	beq_cont.15973
beq_then.15972:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.15973:
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.15971
beq_then.15970:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.15971:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.15974
	addi	r1, r0, 1
	sw	r2, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_or_network.3004				#	bl	read_or_network.3004
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 7(r3)
	sw	r2, 0(r1)
	j	beq_cont.15975
beq_then.15974:
	addi	r1, r0, 1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.15975:
	lw	r2, 4(r3)
	sw	r1, 0(r2)
	jr	r31				#
solver_rect_surface.3010:
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.15977
	addi	r8, r0, 1
	j	feq_cont.15978
feq_else.15977:
	addi	r8, r0, 0
feq_cont.15978:
	beqi	0, r8, beq_then.15979
	addi	r1, r0, 0
	jr	r31				#
beq_then.15979:
	lw	r8, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.15980
	addi	r9, r0, 0
	j	fle_cont.15981
fle_else.15980:
	addi	r9, r0, 1
fle_cont.15981:
	beqi	0, r1, beq_then.15982
	beqi	0, r9, beq_then.15984
	addi	r1, r0, 0
	j	beq_cont.15985
beq_then.15984:
	addi	r1, r0, 1
beq_cont.15985:
	j	beq_cont.15983
beq_then.15982:
	add	r1, r0, r9
beq_cont.15983:
	add	r30, r8, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.15986
	j	beq_cont.15987
beq_then.15986:
	fneg	f4, f4
beq_cont.15987:
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
	beq	r0, r30, fle_else.15988
	j	fle_cont.15989
fle_else.15988:
	fneg	f2, f2
fle_cont.15989:
	fle	r30, f4, f2
	beq	r0, r30, fle_else.15990
	addi	r1, r0, 0
	jr	r31				#
fle_else.15990:
	add	r30, r8, r7
	flw	f2, 0(r30)
	add	r30, r2, r7
	flw	f4, 0(r30)
	fmul	f4, f1, f4
	fadd	f3, f4, f3
	fle	r30, f0, f3
	beq	r0, r30, fle_else.15991
	j	fle_cont.15992
fle_else.15991:
	fneg	f3, f3
fle_cont.15992:
	fle	r30, f2, f3
	beq	r0, r30, fle_else.15993
	addi	r1, r0, 0
	jr	r31				#
fle_else.15993:
	addi	r1, r0, 10724
	fsw	f1, 0(r1)
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
	beqi	0, r1, beq_then.15994
	addi	r1, r0, 1
	jr	r31				#
beq_then.15994:
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
	beqi	0, r1, beq_then.15995
	addi	r1, r0, 2
	jr	r31				#
beq_then.15995:
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
	beqi	0, r1, beq_then.15996
	addi	r1, r0, 3
	jr	r31				#
beq_then.15996:
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
	beq	r0, r30, fle_else.15997
	addi	r2, r0, 0
	j	fle_cont.15998
fle_else.15997:
	addi	r2, r0, 1
fle_cont.15998:
	beqi	0, r2, beq_then.15999
	addi	r2, r0, 10724
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
	fsw	f1, 0(r2)
	addi	r1, r0, 1
	jr	r31				#
beq_then.15999:
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
	beqi	0, r2, beq_then.16000
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
beq_then.16000:
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
	beqi	0, r2, beq_then.16001
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
beq_then.16001:
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
	beq	r0, r30, feq_else.16002
	addi	r1, r0, 1
	j	feq_cont.16003
feq_else.16002:
	addi	r1, r0, 0
feq_cont.16003:
	beqi	0, r1, beq_then.16004
	addi	r1, r0, 0
	jr	r31				#
beq_then.16004:
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
	beqi	3, r2, beq_then.16005
	j	beq_cont.16006
beq_then.16005:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16006:
	flw	f2, 10(r3)
	fmul	f3, f2, f2
	flw	f4, 8(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16007
	addi	r2, r0, 0
	j	fle_cont.16008
fle_else.16007:
	addi	r2, r0, 1
fle_cont.16008:
	beqi	0, r2, beq_then.16009
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16010
	j	beq_cont.16011
beq_then.16010:
	fneg	f1, f1
beq_cont.16011:
	addi	r1, r0, 10724
	fsub	f1, f1, f2
	fdiv	f1, f1, f4
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16009:
	addi	r1, r0, 0
	jr	r31				#
solver.3050:
	addi	r6, r0, 10001
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
	beqi	1, r5, beq_then.16012
	beqi	2, r5, beq_then.16013
	j	solver_second.3044
beq_then.16013:
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
	beq	r0, r30, fle_else.16014
	addi	r2, r0, 0
	j	fle_cont.16015
fle_else.16014:
	addi	r2, r0, 1
fle_cont.16015:
	beqi	0, r2, beq_then.16016
	addi	r2, r0, 10724
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
	fsw	f1, 0(r2)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16016:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16012:
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
	beqi	0, r1, beq_then.16017
	addi	r1, r0, 1
	jr	r31				#
beq_then.16017:
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
	beqi	0, r1, beq_then.16018
	addi	r1, r0, 2
	jr	r31				#
beq_then.16018:
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
	beqi	0, r1, beq_then.16019
	addi	r1, r0, 3
	jr	r31				#
beq_then.16019:
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
	beq	r0, r30, fle_else.16020
	j	fle_cont.16021
fle_else.16020:
	fneg	f6, f6
fle_cont.16021:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16022
	addi	r6, r0, 0
	j	fle_cont.16023
fle_else.16022:
	lw	r6, 4(r1)
	flw	f5, 2(r6)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.16024
	j	fle_cont.16025
fle_else.16024:
	fneg	f6, f6
fle_cont.16025:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16026
	addi	r6, r0, 0
	j	fle_cont.16027
fle_else.16026:
	flw	f5, 1(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16028
	addi	r6, r0, 1
	j	feq_cont.16029
feq_else.16028:
	addi	r6, r0, 0
feq_cont.16029:
	beqi	0, r6, beq_then.16030
	addi	r6, r0, 0
	j	beq_cont.16031
beq_then.16030:
	addi	r6, r0, 1
beq_cont.16031:
fle_cont.16027:
fle_cont.16023:
	beqi	0, r6, beq_then.16032
	addi	r1, r0, 10724
	fsw	f4, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16032:
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
	beq	r0, r30, fle_else.16033
	j	fle_cont.16034
fle_else.16033:
	fneg	f6, f6
fle_cont.16034:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16035
	addi	r6, r0, 0
	j	fle_cont.16036
fle_else.16035:
	lw	r6, 4(r1)
	flw	f5, 2(r6)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.16037
	j	fle_cont.16038
fle_else.16037:
	fneg	f6, f6
fle_cont.16038:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16039
	addi	r6, r0, 0
	j	fle_cont.16040
fle_else.16039:
	flw	f5, 3(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16041
	addi	r6, r0, 1
	j	feq_cont.16042
feq_else.16041:
	addi	r6, r0, 0
feq_cont.16042:
	beqi	0, r6, beq_then.16043
	addi	r6, r0, 0
	j	beq_cont.16044
beq_then.16043:
	addi	r6, r0, 1
beq_cont.16044:
fle_cont.16040:
fle_cont.16036:
	beqi	0, r6, beq_then.16045
	addi	r1, r0, 10724
	fsw	f4, 0(r1)
	addi	r1, r0, 2
	jr	r31				#
beq_then.16045:
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
	beq	r0, r30, fle_else.16046
	j	fle_cont.16047
fle_else.16046:
	fneg	f1, f1
fle_cont.16047:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16048
	addi	r1, r0, 0
	j	fle_cont.16049
fle_else.16048:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	flw	f4, 1(r2)
	fmul	f4, f3, f4
	fadd	f2, f4, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16050
	j	fle_cont.16051
fle_else.16050:
	fneg	f2, f2
fle_cont.16051:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16052
	addi	r1, r0, 0
	j	fle_cont.16053
fle_else.16052:
	flw	f1, 5(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16054
	addi	r1, r0, 1
	j	feq_cont.16055
feq_else.16054:
	addi	r1, r0, 0
feq_cont.16055:
	beqi	0, r1, beq_then.16056
	addi	r1, r0, 0
	j	beq_cont.16057
beq_then.16056:
	addi	r1, r0, 1
beq_cont.16057:
fle_cont.16053:
fle_cont.16049:
	beqi	0, r1, beq_then.16058
	addi	r1, r0, 10724
	fsw	f3, 0(r1)
	addi	r1, r0, 3
	jr	r31				#
beq_then.16058:
	addi	r1, r0, 0
	jr	r31				#
solver_surface_fast.3061:
	flw	f4, 0(r2)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16059
	addi	r1, r0, 0
	j	fle_cont.16060
fle_else.16059:
	addi	r1, r0, 1
fle_cont.16060:
	beqi	0, r1, beq_then.16061
	addi	r1, r0, 10724
	flw	f4, 1(r2)
	fmul	f1, f4, f1
	flw	f4, 2(r2)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 3(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16061:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3067:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16062
	addi	r5, r0, 1
	j	feq_cont.16063
feq_else.16062:
	addi	r5, r0, 0
feq_cont.16063:
	beqi	0, r5, beq_then.16064
	addi	r1, r0, 0
	jr	r31				#
beq_then.16064:
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
	beqi	3, r2, beq_then.16066
	j	beq_cont.16067
beq_then.16066:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16067:
	flw	f2, 4(r3)
	fmul	f3, f2, f2
	flw	f4, 2(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16068
	addi	r2, r0, 0
	j	fle_cont.16069
fle_else.16068:
	addi	r2, r0, 1
fle_cont.16069:
	beqi	0, r2, beq_then.16070
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16071
	addi	r1, r0, 10724
	fsqrt	f1, f1
	fadd	f1, f2, f1
	lw	r2, 0(r3)
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	j	beq_cont.16072
beq_then.16071:
	addi	r1, r0, 10724
	fsqrt	f1, f1
	fsub	f1, f2, f1
	lw	r2, 0(r3)
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
beq_cont.16072:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16070:
	addi	r1, r0, 0
	jr	r31				#
solver_fast.3073:
	addi	r6, r0, 10001
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
	beqi	1, r1, beq_then.16073
	beqi	2, r1, beq_then.16074
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	j	solver_second_fast.3067
beq_then.16074:
	flw	f4, 0(r5)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16075
	addi	r1, r0, 0
	j	fle_cont.16076
fle_else.16075:
	addi	r1, r0, 1
fle_cont.16076:
	beqi	0, r1, beq_then.16077
	addi	r1, r0, 10724
	flw	f4, 1(r5)
	fmul	f1, f4, f1
	flw	f4, 2(r5)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 3(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16077:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16073:
	lw	r2, 0(r2)
	add	r1, r0, r6				# mr	r1, r6
	j	solver_rect_fast.3054
solver_surface_fast2.3077:
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16078
	addi	r1, r0, 0
	j	fle_cont.16079
fle_else.16078:
	addi	r1, r0, 1
fle_cont.16079:
	beqi	0, r1, beq_then.16080
	addi	r1, r0, 10724
	flw	f1, 0(r2)
	flw	f2, 3(r5)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16080:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3084:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16081
	addi	r6, r0, 1
	j	feq_cont.16082
feq_else.16081:
	addi	r6, r0, 0
feq_cont.16082:
	beqi	0, r6, beq_then.16083
	addi	r1, r0, 0
	jr	r31				#
beq_then.16083:
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
	beq	r0, r30, fle_else.16084
	addi	r5, r0, 0
	j	fle_cont.16085
fle_else.16084:
	addi	r5, r0, 1
fle_cont.16085:
	beqi	0, r5, beq_then.16086
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16087
	addi	r1, r0, 10724
	fsqrt	f2, f2
	fadd	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	j	beq_cont.16088
beq_then.16087:
	addi	r1, r0, 10724
	fsqrt	f2, f2
	fsub	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
beq_cont.16088:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16086:
	addi	r1, r0, 0
	jr	r31				#
solver_fast2.3091:
	addi	r5, r0, 10001
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
	beqi	1, r7, beq_then.16089
	beqi	2, r7, beq_then.16090
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	j	solver_second_fast2.3084
beq_then.16090:
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16091
	addi	r2, r0, 0
	j	fle_cont.16092
fle_else.16091:
	addi	r2, r0, 1
fle_cont.16092:
	beqi	0, r2, beq_then.16093
	addi	r2, r0, 10724
	flw	f1, 0(r1)
	flw	f2, 3(r6)
	fmul	f1, f1, f2
	fsw	f1, 0(r2)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16093:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16089:
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
	beq	r0, r30, feq_else.16094
	addi	r5, r0, 1
	j	feq_cont.16095
feq_else.16094:
	addi	r5, r0, 0
feq_cont.16095:
	beqi	0, r5, beq_then.16096
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 1(r1)
	j	beq_cont.16097
beq_then.16096:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16098
	addi	r7, r0, 0
	j	fle_cont.16099
fle_else.16098:
	addi	r7, r0, 1
fle_cont.16099:
	beqi	0, r6, beq_then.16100
	beqi	0, r7, beq_then.16102
	addi	r6, r0, 0
	j	beq_cont.16103
beq_then.16102:
	addi	r6, r0, 1
beq_cont.16103:
	j	beq_cont.16101
beq_then.16100:
	add	r6, r0, r7
beq_cont.16101:
	lw	r7, 4(r5)
	flw	f1, 0(r7)
	beqi	0, r6, beq_then.16104
	j	beq_cont.16105
beq_then.16104:
	fneg	f1, f1
beq_cont.16105:
	fsw	f1, 0(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r2)
	fdiv	f1, f1, f2
	fsw	f1, 1(r1)
beq_cont.16097:
	flw	f1, 1(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16106
	addi	r5, r0, 1
	j	feq_cont.16107
feq_else.16106:
	addi	r5, r0, 0
feq_cont.16107:
	beqi	0, r5, beq_then.16108
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 3(r1)
	j	beq_cont.16109
beq_then.16108:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 1(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16110
	addi	r7, r0, 0
	j	fle_cont.16111
fle_else.16110:
	addi	r7, r0, 1
fle_cont.16111:
	beqi	0, r6, beq_then.16112
	beqi	0, r7, beq_then.16114
	addi	r6, r0, 0
	j	beq_cont.16115
beq_then.16114:
	addi	r6, r0, 1
beq_cont.16115:
	j	beq_cont.16113
beq_then.16112:
	add	r6, r0, r7
beq_cont.16113:
	lw	r7, 4(r5)
	flw	f1, 1(r7)
	beqi	0, r6, beq_then.16116
	j	beq_cont.16117
beq_then.16116:
	fneg	f1, f1
beq_cont.16117:
	fsw	f1, 2(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 1(r2)
	fdiv	f1, f1, f2
	fsw	f1, 3(r1)
beq_cont.16109:
	flw	f1, 2(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16118
	addi	r5, r0, 1
	j	feq_cont.16119
feq_else.16118:
	addi	r5, r0, 0
feq_cont.16119:
	beqi	0, r5, beq_then.16120
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 5(r1)
	j	beq_cont.16121
beq_then.16120:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 2(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16122
	addi	r7, r0, 0
	j	fle_cont.16123
fle_else.16122:
	addi	r7, r0, 1
fle_cont.16123:
	beqi	0, r6, beq_then.16124
	beqi	0, r7, beq_then.16126
	addi	r6, r0, 0
	j	beq_cont.16127
beq_then.16126:
	addi	r6, r0, 1
beq_cont.16127:
	j	beq_cont.16125
beq_then.16124:
	add	r6, r0, r7
beq_cont.16125:
	lw	r5, 4(r5)
	flw	f1, 2(r5)
	beqi	0, r6, beq_then.16128
	j	beq_cont.16129
beq_then.16128:
	fneg	f1, f1
beq_cont.16129:
	fsw	f1, 4(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 2(r2)
	fdiv	f1, f1, f2
	fsw	f1, 5(r1)
beq_cont.16121:
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
	beq	r0, r30, fle_else.16130
	addi	r2, r0, 0
	j	fle_cont.16131
fle_else.16130:
	addi	r2, r0, 1
fle_cont.16131:
	beqi	0, r2, beq_then.16132
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
	j	beq_cont.16133
beq_then.16132:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
beq_cont.16133:
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
	beqi	0, r6, beq_then.16134
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
	j	beq_cont.16135
beq_then.16134:
	fsw	f2, 1(r5)
	fsw	f3, 2(r5)
	fsw	f4, 3(r5)
beq_cont.16135:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16136
	addi	r1, r0, 1
	j	feq_cont.16137
feq_else.16136:
	addi	r1, r0, 0
feq_cont.16137:
	beqi	0, r1, beq_then.16138
	j	beq_cont.16139
beq_then.16138:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
	fsw	f1, 4(r5)
beq_cont.16139:
	add	r1, r0, r5
	jr	r31				#
iter_setup_dirvec_constants.3103:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16140
	jr	r31				#
ble_then.16140:
	addi	r5, r0, 10001
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 1(r1)
	lw	r7, 0(r1)
	lw	r8, 1(r5)
	sw	r1, 0(r3)
	beqi	1, r8, beq_then.16142
	beqi	2, r8, beq_then.16144
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
	j	beq_cont.16145
beq_then.16144:
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
beq_cont.16145:
	j	beq_cont.16143
beq_then.16142:
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
beq_cont.16143:
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16146
	jr	r31				#
ble_then.16146:
	addi	r2, r0, 10001
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 0(r3)
	lw	r6, 1(r5)
	lw	r7, 0(r5)
	lw	r8, 1(r2)
	beqi	1, r8, beq_then.16148
	beqi	2, r8, beq_then.16150
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
	j	beq_cont.16151
beq_then.16150:
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
beq_cont.16151:
	j	beq_cont.16149
beq_then.16148:
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
beq_cont.16149:
	addi	r2, r2, -1
	lw	r1, 0(r3)
	j	iter_setup_dirvec_constants.3103
setup_dirvec_constants.3106:
	addi	r2, r0, 10000
	lw	r2, 0(r2)
	addi	r2, r2, -1
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16152
	jr	r31				#
ble_then.16152:
	addi	r5, r0, 10001
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 1(r1)
	lw	r7, 0(r1)
	lw	r8, 1(r5)
	sw	r1, 0(r3)
	beqi	1, r8, beq_then.16154
	beqi	2, r8, beq_then.16156
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
	j	beq_cont.16157
beq_then.16156:
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
beq_cont.16157:
	j	beq_cont.16155
beq_then.16154:
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
beq_cont.16155:
	addi	r2, r2, -1
	lw	r1, 0(r3)
	j	iter_setup_dirvec_constants.3103
setup_startp_constants.3108:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16158
	jr	r31				#
ble_then.16158:
	addi	r5, r0, 10001
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
	beqi	2, r7, beq_then.16160
	blei	2, r7, ble_then.16162
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
	beqi	3, r1, beq_then.16164
	j	beq_cont.16165
beq_then.16164:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16165:
	lw	r1, 2(r3)
	fsw	f1, 3(r1)
	j	ble_cont.16163
ble_then.16162:
ble_cont.16163:
	j	beq_cont.16161
beq_then.16160:
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
beq_cont.16161:
	lw	r1, 1(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	j	setup_startp_constants.3108
setup_startp.3111:
	addi	r2, r0, 10751
	flw	f1, 0(r1)
	fsw	f1, 0(r2)
	flw	f1, 1(r1)
	fsw	f1, 1(r2)
	flw	f1, 2(r1)
	fsw	f1, 2(r2)
	addi	r2, r0, 10000
	lw	r2, 0(r2)
	addi	r2, r2, -1
	j	setup_startp_constants.3108
is_rect_outside.3113:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16166
	j	fle_cont.16167
fle_else.16166:
	fneg	f1, f1
fle_cont.16167:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16168
	addi	r2, r0, 0
	j	fle_cont.16169
fle_else.16168:
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16170
	j	fle_cont.16171
fle_else.16170:
	fneg	f2, f2
fle_cont.16171:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16172
	addi	r2, r0, 0
	j	fle_cont.16173
fle_else.16172:
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16174
	fadd	f2, f0, f3
	j	fle_cont.16175
fle_else.16174:
	fneg	f2, f3
fle_cont.16175:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16176
	addi	r2, r0, 0
	j	fle_cont.16177
fle_else.16176:
	addi	r2, r0, 1
fle_cont.16177:
fle_cont.16173:
fle_cont.16169:
	beqi	0, r2, beq_then.16178
	lw	r1, 6(r1)
	jr	r31				#
beq_then.16178:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16179
	addi	r1, r0, 0
	jr	r31				#
beq_then.16179:
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
	beq	r0, r30, fle_else.16180
	addi	r2, r0, 0
	j	fle_cont.16181
fle_else.16180:
	addi	r2, r0, 1
fle_cont.16181:
	beqi	0, r1, beq_then.16182
	beqi	0, r2, beq_then.16184
	addi	r1, r0, 0
	j	beq_cont.16185
beq_then.16184:
	addi	r1, r0, 1
beq_cont.16185:
	j	beq_cont.16183
beq_then.16182:
	add	r1, r0, r2
beq_cont.16183:
	beqi	0, r1, beq_then.16186
	addi	r1, r0, 0
	jr	r31				#
beq_then.16186:
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
	beqi	3, r2, beq_then.16187
	j	beq_cont.16188
beq_then.16187:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16188:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16189
	addi	r2, r0, 0
	j	fle_cont.16190
fle_else.16189:
	addi	r2, r0, 1
fle_cont.16190:
	beqi	0, r1, beq_then.16191
	beqi	0, r2, beq_then.16193
	addi	r1, r0, 0
	j	beq_cont.16194
beq_then.16193:
	addi	r1, r0, 1
beq_cont.16194:
	j	beq_cont.16192
beq_then.16191:
	add	r1, r0, r2
beq_cont.16192:
	beqi	0, r1, beq_then.16195
	addi	r1, r0, 0
	jr	r31				#
beq_then.16195:
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
	beqi	1, r2, beq_then.16196
	beqi	2, r2, beq_then.16197
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3031				#	bl	quadratic.3031
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16198
	j	beq_cont.16199
beq_then.16198:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16199:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16200
	addi	r2, r0, 0
	j	fle_cont.16201
fle_else.16200:
	addi	r2, r0, 1
fle_cont.16201:
	beqi	0, r1, beq_then.16202
	beqi	0, r2, beq_then.16204
	addi	r1, r0, 0
	j	beq_cont.16205
beq_then.16204:
	addi	r1, r0, 1
beq_cont.16205:
	j	beq_cont.16203
beq_then.16202:
	add	r1, r0, r2
beq_cont.16203:
	beqi	0, r1, beq_then.16206
	addi	r1, r0, 0
	jr	r31				#
beq_then.16206:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16197:
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
	beq	r0, r30, fle_else.16207
	addi	r2, r0, 0
	j	fle_cont.16208
fle_else.16207:
	addi	r2, r0, 1
fle_cont.16208:
	beqi	0, r1, beq_then.16209
	beqi	0, r2, beq_then.16211
	addi	r1, r0, 0
	j	beq_cont.16212
beq_then.16211:
	addi	r1, r0, 1
beq_cont.16212:
	j	beq_cont.16210
beq_then.16209:
	add	r1, r0, r2
beq_cont.16210:
	beqi	0, r1, beq_then.16213
	addi	r1, r0, 0
	jr	r31				#
beq_then.16213:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16196:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16214
	j	fle_cont.16215
fle_else.16214:
	fneg	f1, f1
fle_cont.16215:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16216
	addi	r2, r0, 0
	j	fle_cont.16217
fle_else.16216:
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16218
	j	fle_cont.16219
fle_else.16218:
	fneg	f2, f2
fle_cont.16219:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16220
	addi	r2, r0, 0
	j	fle_cont.16221
fle_else.16220:
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16222
	fadd	f2, f0, f3
	j	fle_cont.16223
fle_else.16222:
	fneg	f2, f3
fle_cont.16223:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16224
	addi	r2, r0, 0
	j	fle_cont.16225
fle_else.16224:
	addi	r2, r0, 1
fle_cont.16225:
fle_cont.16221:
fle_cont.16217:
	beqi	0, r2, beq_then.16226
	lw	r1, 6(r1)
	jr	r31				#
beq_then.16226:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16227
	addi	r1, r0, 0
	jr	r31				#
beq_then.16227:
	addi	r1, r0, 1
	jr	r31				#
check_all_inside.3133:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16228
	addi	r6, r0, 10001
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
	beqi	1, r6, beq_then.16229
	beqi	2, r6, beq_then.16231
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
	beqi	3, r2, beq_then.16233
	j	beq_cont.16234
beq_then.16233:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16234:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16235
	addi	r2, r0, 0
	j	fle_cont.16236
fle_else.16235:
	addi	r2, r0, 1
fle_cont.16236:
	beqi	0, r1, beq_then.16237
	beqi	0, r2, beq_then.16239
	addi	r1, r0, 0
	j	beq_cont.16240
beq_then.16239:
	addi	r1, r0, 1
beq_cont.16240:
	j	beq_cont.16238
beq_then.16237:
	add	r1, r0, r2
beq_cont.16238:
	beqi	0, r1, beq_then.16241
	addi	r1, r0, 0
	j	beq_cont.16242
beq_then.16241:
	addi	r1, r0, 1
beq_cont.16242:
	j	beq_cont.16232
beq_then.16231:
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
	beq	r0, r30, fle_else.16243
	addi	r6, r0, 0
	j	fle_cont.16244
fle_else.16243:
	addi	r6, r0, 1
fle_cont.16244:
	beqi	0, r5, beq_then.16245
	beqi	0, r6, beq_then.16247
	addi	r5, r0, 0
	j	beq_cont.16248
beq_then.16247:
	addi	r5, r0, 1
beq_cont.16248:
	j	beq_cont.16246
beq_then.16245:
	add	r5, r0, r6
beq_cont.16246:
	beqi	0, r5, beq_then.16249
	addi	r1, r0, 0
	j	beq_cont.16250
beq_then.16249:
	addi	r1, r0, 1
beq_cont.16250:
beq_cont.16232:
	j	beq_cont.16230
beq_then.16229:
	add	r1, r0, r5				# mr	r1, r5
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	is_rect_outside.3113				#	bl	is_rect_outside.3113
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.16230:
	beqi	0, r1, beq_then.16251
	addi	r1, r0, 0
	jr	r31				#
beq_then.16251:
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 6(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16252
	addi	r6, r0, 10001
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
	beqi	0, r1, beq_then.16253
	addi	r1, r0, 0
	jr	r31				#
beq_then.16253:
	lw	r1, 9(r3)
	addi	r1, r1, 1
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r2, 6(r3)
	j	check_all_inside.3133
beq_then.16252:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16228:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3139:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16254
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 11021
	addi	r7, r0, 10727
	addi	r8, r0, 10001
	add	r30, r8, r5
	lw	r8, 0(r30)
	flw	f1, 0(r7)
	lw	r9, 5(r8)
	flw	f2, 0(r9)
	fsub	f1, f1, f2
	flw	f2, 1(r7)
	lw	r9, 5(r8)
	flw	f3, 1(r9)
	fsub	f2, f2, f3
	flw	f3, 2(r7)
	lw	r7, 5(r8)
	flw	f4, 2(r7)
	fsub	f3, f3, f4
	lw	r7, 1(r6)
	add	r30, r7, r5
	lw	r7, 0(r30)
	lw	r9, 1(r8)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	beqi	1, r9, beq_then.16255
	beqi	2, r9, beq_then.16257
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_second_fast.3067				#	bl	solver_second_fast.3067
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16258
beq_then.16257:
	flw	f4, 0(r7)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16259
	addi	r6, r0, 0
	j	fle_cont.16260
fle_else.16259:
	addi	r6, r0, 1
fle_cont.16260:
	beqi	0, r6, beq_then.16261
	addi	r6, r0, 10724
	flw	f4, 1(r7)
	fmul	f1, f4, f1
	flw	f4, 2(r7)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 3(r7)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 0(r6)
	addi	r1, r0, 1
	j	beq_cont.16262
beq_then.16261:
	addi	r1, r0, 0
beq_cont.16262:
beq_cont.16258:
	j	beq_cont.16256
beq_then.16255:
	lw	r6, 0(r6)
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_rect_fast.3054				#	bl	solver_rect_fast.3054
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16256:
	addi	r2, r0, 10724
	flw	f1, 0(r2)
	beqi	0, r1, beq_then.16263
	flup	f2, 28		# fli	f2, -0.200000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16265
	addi	r1, r0, 0
	j	fle_cont.16266
fle_else.16265:
	addi	r1, r0, 1
fle_cont.16266:
	j	beq_cont.16264
beq_then.16263:
	addi	r1, r0, 0
beq_cont.16264:
	beqi	0, r1, beq_then.16267
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	addi	r1, r0, 10667
	flw	f2, 0(r1)
	fmul	f2, f2, f1
	addi	r1, r0, 10727
	flw	f3, 0(r1)
	fadd	f2, f2, f3
	addi	r1, r0, 10667
	flw	f3, 1(r1)
	fmul	f3, f3, f1
	addi	r1, r0, 10727
	flw	f4, 1(r1)
	fadd	f3, f3, f4
	addi	r1, r0, 10667
	flw	f4, 2(r1)
	fmul	f1, f4, f1
	addi	r1, r0, 10727
	flw	f4, 2(r1)
	fadd	f1, f1, f4
	lw	r2, 0(r3)
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.16268
	addi	r5, r0, 10001
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
	beqi	0, r1, beq_then.16271
	addi	r1, r0, 0
	j	beq_cont.16272
beq_then.16271:
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
beq_cont.16272:
	j	beq_cont.16269
beq_then.16268:
	addi	r1, r0, 1
beq_cont.16269:
	beqi	0, r1, beq_then.16273
	addi	r1, r0, 1
	jr	r31				#
beq_then.16273:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_and_group.3139
beq_then.16267:
	addi	r1, r0, 10001
	lw	r2, 2(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16274
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_and_group.3139
beq_then.16274:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16254:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3142:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16275
	addi	r6, r0, 10672
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
	beqi	0, r1, beq_then.16276
	addi	r1, r0, 1
	jr	r31				#
beq_then.16276:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16277
	addi	r6, r0, 10672
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
	beqi	0, r1, beq_then.16278
	addi	r1, r0, 1
	jr	r31				#
beq_then.16278:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16279
	addi	r6, r0, 10672
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
	beqi	0, r1, beq_then.16280
	addi	r1, r0, 1
	jr	r31				#
beq_then.16280:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16281
	addi	r6, r0, 10672
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
	beqi	0, r1, beq_then.16282
	addi	r1, r0, 1
	jr	r31				#
beq_then.16282:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_one_or_group.3142
beq_then.16281:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16279:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16277:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16275:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3145:
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16283
	addi	r7, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r6, r7, beq_then.16284
	addi	r7, r0, 11021
	addi	r8, r0, 10727
	addi	r9, r0, 10001
	add	r30, r9, r6
	lw	r9, 0(r30)
	flw	f1, 0(r8)
	lw	r10, 5(r9)
	flw	f2, 0(r10)
	fsub	f1, f1, f2
	flw	f2, 1(r8)
	lw	r10, 5(r9)
	flw	f3, 1(r10)
	fsub	f2, f2, f3
	flw	f3, 2(r8)
	lw	r8, 5(r9)
	flw	f4, 2(r8)
	fsub	f3, f3, f4
	lw	r8, 1(r7)
	add	r30, r8, r6
	lw	r6, 0(r30)
	lw	r8, 1(r9)
	beqi	1, r8, beq_then.16286
	beqi	2, r8, beq_then.16288
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_second_fast.3067				#	bl	solver_second_fast.3067
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16289
beq_then.16288:
	flw	f4, 0(r6)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16290
	addi	r7, r0, 0
	j	fle_cont.16291
fle_else.16290:
	addi	r7, r0, 1
fle_cont.16291:
	beqi	0, r7, beq_then.16292
	addi	r7, r0, 10724
	flw	f4, 1(r6)
	fmul	f1, f4, f1
	flw	f4, 2(r6)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 3(r6)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 0(r7)
	addi	r1, r0, 1
	j	beq_cont.16293
beq_then.16292:
	addi	r1, r0, 0
beq_cont.16293:
beq_cont.16289:
	j	beq_cont.16287
beq_then.16286:
	lw	r7, 0(r7)
	add	r5, r0, r6				# mr	r5, r6
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_rect_fast.3054				#	bl	solver_rect_fast.3054
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16287:
	beqi	0, r1, beq_then.16294
	flup	f1, 30		# fli	f1, -0.100000
	addi	r1, r0, 10724
	flw	f2, 0(r1)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16296
	addi	r1, r0, 0
	j	fle_cont.16297
fle_else.16296:
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16298
	addi	r5, r0, 10672
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
	lw	r1, 0(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16302
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				#	bl	shadow_check_and_group.3139
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16304
	addi	r1, r0, 1
	j	beq_cont.16305
beq_then.16304:
	lw	r1, 0(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16306
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				#	bl	shadow_check_and_group.3139
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16308
	addi	r1, r0, 1
	j	beq_cont.16309
beq_then.16308:
	addi	r1, r0, 4
	lw	r2, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_one_or_group.3142				#	bl	shadow_check_one_or_group.3142
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16309:
	j	beq_cont.16307
beq_then.16306:
	addi	r1, r0, 0
beq_cont.16307:
beq_cont.16305:
	j	beq_cont.16303
beq_then.16302:
	addi	r1, r0, 0
beq_cont.16303:
beq_cont.16301:
	j	beq_cont.16299
beq_then.16298:
	addi	r1, r0, 0
beq_cont.16299:
	beqi	0, r1, beq_then.16310
	addi	r1, r0, 1
	j	beq_cont.16311
beq_then.16310:
	addi	r1, r0, 0
beq_cont.16311:
fle_cont.16297:
	j	beq_cont.16295
beq_then.16294:
	addi	r1, r0, 0
beq_cont.16295:
	j	beq_cont.16285
beq_then.16284:
	addi	r1, r0, 1
beq_cont.16285:
	beqi	0, r1, beq_then.16312
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16313
	addi	r5, r0, 10672
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
	lw	r1, 0(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16317
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				#	bl	shadow_check_and_group.3139
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16319
	addi	r1, r0, 1
	j	beq_cont.16320
beq_then.16319:
	lw	r1, 0(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16321
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				#	bl	shadow_check_and_group.3139
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16323
	addi	r1, r0, 1
	j	beq_cont.16324
beq_then.16323:
	addi	r1, r0, 4
	lw	r2, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_one_or_group.3142				#	bl	shadow_check_one_or_group.3142
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16324:
	j	beq_cont.16322
beq_then.16321:
	addi	r1, r0, 0
beq_cont.16322:
beq_cont.16320:
	j	beq_cont.16318
beq_then.16317:
	addi	r1, r0, 0
beq_cont.16318:
beq_cont.16316:
	j	beq_cont.16314
beq_then.16313:
	addi	r1, r0, 0
beq_cont.16314:
	beqi	0, r1, beq_then.16325
	addi	r1, r0, 1
	jr	r31				#
beq_then.16325:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	j	shadow_check_one_or_matrix.3145
beq_then.16312:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	j	shadow_check_one_or_matrix.3145
beq_then.16283:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3148:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.16326
	addi	r7, r0, 10748
	addi	r8, r0, 10001
	add	r30, r8, r6
	lw	r8, 0(r30)
	flw	f1, 0(r7)
	lw	r9, 5(r8)
	flw	f2, 0(r9)
	fsub	f1, f1, f2
	flw	f2, 1(r7)
	lw	r9, 5(r8)
	flw	f3, 1(r9)
	fsub	f2, f2, f3
	flw	f3, 2(r7)
	lw	r7, 5(r8)
	flw	f4, 2(r7)
	fsub	f3, f3, f4
	lw	r7, 1(r8)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r6, 3(r3)
	beqi	1, r7, beq_then.16327
	beqi	2, r7, beq_then.16329
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second.3044				#	bl	solver_second.3044
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16330
beq_then.16329:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_surface.3025				#	bl	solver_surface.3025
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16330:
	j	beq_cont.16328
beq_then.16327:
	addi	r7, r0, 0
	addi	r9, r0, 1
	addi	r10, r0, 2
	fsw	f1, 4(r3)
	fsw	f3, 6(r3)
	fsw	f2, 8(r3)
	sw	r8, 10(r3)
	add	r6, r0, r9				# mr	r6, r9
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r8				# mr	r1, r8
	add	r5, r0, r7				# mr	r5, r7
	add	r7, r0, r10				# mr	r7, r10
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solver_rect_surface.3010				#	bl	solver_rect_surface.3010
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16331
	addi	r1, r0, 1
	j	beq_cont.16332
beq_then.16331:
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
	beqi	0, r1, beq_then.16333
	addi	r1, r0, 2
	j	beq_cont.16334
beq_then.16333:
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
	beqi	0, r1, beq_then.16335
	addi	r1, r0, 3
	j	beq_cont.16336
beq_then.16335:
	addi	r1, r0, 0
beq_cont.16336:
beq_cont.16334:
beq_cont.16332:
beq_cont.16328:
	beqi	0, r1, beq_then.16337
	addi	r2, r0, 10724
	flw	f1, 0(r2)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16338
	j	fle_cont.16339
fle_else.16338:
	addi	r2, r0, 10726
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16340
	j	fle_cont.16341
fle_else.16340:
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	lw	r5, 0(r3)
	flw	f2, 0(r5)
	fmul	f2, f2, f1
	addi	r2, r0, 10748
	flw	f3, 0(r2)
	fadd	f2, f2, f3
	flw	f3, 1(r5)
	fmul	f3, f3, f1
	addi	r2, r0, 10748
	flw	f4, 1(r2)
	fadd	f3, f3, f4
	flw	f4, 2(r5)
	fmul	f4, f4, f1
	addi	r2, r0, 10748
	flw	f5, 2(r2)
	fadd	f4, f4, f5
	lw	r2, 1(r3)
	lw	r6, 0(r2)
	sw	r1, 11(r3)
	fsw	f4, 12(r3)
	fsw	f3, 14(r3)
	fsw	f2, 16(r3)
	fsw	f1, 18(r3)
	beqi	-1, r6, beq_then.16342
	addi	r7, r0, 10001
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
	beqi	0, r1, beq_then.16344
	addi	r1, r0, 0
	j	beq_cont.16345
beq_then.16344:
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
beq_cont.16345:
	j	beq_cont.16343
beq_then.16342:
	addi	r1, r0, 1
beq_cont.16343:
	beqi	0, r1, beq_then.16346
	addi	r1, r0, 10726
	flw	f1, 18(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 10727
	flw	f1, 16(r3)
	fsw	f1, 0(r1)
	flw	f1, 14(r3)
	fsw	f1, 1(r1)
	flw	f1, 12(r3)
	fsw	f1, 2(r1)
	addi	r1, r0, 10730
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	addi	r1, r0, 10725
	lw	r2, 11(r3)
	sw	r2, 0(r1)
	j	beq_cont.16347
beq_then.16346:
beq_cont.16347:
fle_cont.16341:
fle_cont.16339:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3148
beq_then.16337:
	addi	r1, r0, 10001
	lw	r2, 3(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16348
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3148
beq_then.16348:
	jr	r31				#
beq_then.16326:
	jr	r31				#
solve_one_or_network.3152:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.16351
	addi	r7, r0, 10672
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
	beqi	-1, r5, beq_then.16352
	addi	r6, r0, 10672
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
	beqi	-1, r5, beq_then.16353
	addi	r6, r0, 10672
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
	beqi	-1, r5, beq_then.16354
	addi	r6, r0, 10672
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
beq_then.16354:
	jr	r31				#
beq_then.16353:
	jr	r31				#
beq_then.16352:
	jr	r31				#
beq_then.16351:
	jr	r31				#
trace_or_matrix.3156:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.16359
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.16360
	addi	r8, r0, 10748
	addi	r9, r0, 10001
	add	r30, r9, r7
	lw	r7, 0(r30)
	flw	f1, 0(r8)
	lw	r9, 5(r7)
	flw	f2, 0(r9)
	fsub	f1, f1, f2
	flw	f2, 1(r8)
	lw	r9, 5(r7)
	flw	f3, 1(r9)
	fsub	f2, f2, f3
	flw	f3, 2(r8)
	lw	r8, 5(r7)
	flw	f4, 2(r8)
	fsub	f3, f3, f4
	lw	r8, 1(r7)
	sw	r6, 3(r3)
	beqi	1, r8, beq_then.16362
	beqi	2, r8, beq_then.16364
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second.3044				#	bl	solver_second.3044
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16365
beq_then.16364:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_surface.3025				#	bl	solver_surface.3025
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16365:
	j	beq_cont.16363
beq_then.16362:
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
	beqi	0, r1, beq_then.16366
	addi	r1, r0, 1
	j	beq_cont.16367
beq_then.16366:
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
	beqi	0, r1, beq_then.16368
	addi	r1, r0, 2
	j	beq_cont.16369
beq_then.16368:
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
	beqi	0, r1, beq_then.16370
	addi	r1, r0, 3
	j	beq_cont.16371
beq_then.16370:
	addi	r1, r0, 0
beq_cont.16371:
beq_cont.16369:
beq_cont.16367:
beq_cont.16363:
	beqi	0, r1, beq_then.16372
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16374
	j	fle_cont.16375
fle_else.16374:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16376
	addi	r5, r0, 10672
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
	beqi	-1, r2, beq_then.16378
	addi	r5, r0, 10672
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
	beqi	-1, r2, beq_then.16380
	addi	r5, r0, 10672
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
	j	beq_cont.16381
beq_then.16380:
beq_cont.16381:
	j	beq_cont.16379
beq_then.16378:
beq_cont.16379:
	j	beq_cont.16377
beq_then.16376:
beq_cont.16377:
fle_cont.16375:
	j	beq_cont.16373
beq_then.16372:
beq_cont.16373:
	j	beq_cont.16361
beq_then.16360:
	lw	r7, 1(r6)
	beqi	-1, r7, beq_then.16382
	addi	r8, r0, 10672
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
	beqi	-1, r2, beq_then.16384
	addi	r5, r0, 10672
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
	beqi	-1, r2, beq_then.16386
	addi	r5, r0, 10672
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
	j	beq_cont.16387
beq_then.16386:
beq_cont.16387:
	j	beq_cont.16385
beq_then.16384:
beq_cont.16385:
	j	beq_cont.16383
beq_then.16382:
beq_cont.16383:
beq_cont.16361:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16388
	addi	r7, r0, 99
	sw	r1, 11(r3)
	beq	r6, r7, beq_then.16389
	addi	r7, r0, 10748
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
	beqi	0, r1, beq_then.16391
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16393
	j	fle_cont.16394
fle_else.16393:
	lw	r1, 12(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16395
	addi	r5, r0, 10672
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
	beqi	-1, r2, beq_then.16397
	addi	r5, r0, 10672
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
	j	beq_cont.16398
beq_then.16397:
beq_cont.16398:
	j	beq_cont.16396
beq_then.16395:
beq_cont.16396:
fle_cont.16394:
	j	beq_cont.16392
beq_then.16391:
beq_cont.16392:
	j	beq_cont.16390
beq_then.16389:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16399
	addi	r7, r0, 10672
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
	beqi	-1, r2, beq_then.16401
	addi	r5, r0, 10672
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
	j	beq_cont.16402
beq_then.16401:
beq_cont.16402:
	j	beq_cont.16400
beq_then.16399:
beq_cont.16400:
beq_cont.16390:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix.3156
beq_then.16388:
	jr	r31				#
beq_then.16359:
	jr	r31				#
judge_intersection.3160:
	addi	r2, r0, 10726
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r2)
	addi	r2, r0, 10723
	lw	r2, 0(r2)
	lw	r5, 0(r2)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16405
	addi	r7, r0, 99
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	beq	r6, r7, beq_then.16407
	addi	r7, r0, 10748
	sw	r5, 2(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver.3050				#	bl	solver.3050
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16409
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16411
	j	fle_cont.16412
fle_else.16411:
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16413
	addi	r5, r0, 10672
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
	beqi	-1, r2, beq_then.16415
	addi	r5, r0, 10672
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
	j	beq_cont.16416
beq_then.16415:
beq_cont.16416:
	j	beq_cont.16414
beq_then.16413:
beq_cont.16414:
fle_cont.16412:
	j	beq_cont.16410
beq_then.16409:
beq_cont.16410:
	j	beq_cont.16408
beq_then.16407:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16417
	addi	r7, r0, 10672
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
	beqi	-1, r2, beq_then.16419
	addi	r5, r0, 10672
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
	j	beq_cont.16420
beq_then.16419:
beq_cont.16420:
	j	beq_cont.16418
beq_then.16417:
beq_cont.16418:
beq_cont.16408:
	addi	r1, r0, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix.3156				#	bl	trace_or_matrix.3156
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16406
beq_then.16405:
beq_cont.16406:
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16421
	addi	r1, r0, 0
	jr	r31				#
fle_else.16421:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16422
	addi	r1, r0, 0
	jr	r31				#
fle_else.16422:
	addi	r1, r0, 1
	jr	r31				#
solve_each_element_fast.3162:
	lw	r6, 0(r5)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.16423
	addi	r8, r0, 10001
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
	beqi	1, r11, beq_then.16424
	beqi	2, r11, beq_then.16426
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_second_fast2.3084				#	bl	solver_second_fast2.3084
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16427
beq_then.16426:
	flw	f1, 0(r10)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16428
	addi	r8, r0, 0
	j	fle_cont.16429
fle_else.16428:
	addi	r8, r0, 1
fle_cont.16429:
	beqi	0, r8, beq_then.16430
	addi	r8, r0, 10724
	flw	f1, 0(r10)
	flw	f2, 3(r9)
	fmul	f1, f1, f2
	fsw	f1, 0(r8)
	addi	r1, r0, 1
	j	beq_cont.16431
beq_then.16430:
	addi	r1, r0, 0
beq_cont.16431:
beq_cont.16427:
	j	beq_cont.16425
beq_then.16424:
	lw	r9, 0(r5)
	add	r5, r0, r10				# mr	r5, r10
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_rect_fast.3054				#	bl	solver_rect_fast.3054
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16425:
	beqi	0, r1, beq_then.16432
	addi	r2, r0, 10724
	flw	f1, 0(r2)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16433
	j	fle_cont.16434
fle_else.16433:
	addi	r2, r0, 10726
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16435
	j	fle_cont.16436
fle_else.16435:
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	lw	r2, 0(r3)
	flw	f2, 0(r2)
	fmul	f2, f2, f1
	addi	r5, r0, 10751
	flw	f3, 0(r5)
	fadd	f2, f2, f3
	flw	f3, 1(r2)
	fmul	f3, f3, f1
	addi	r5, r0, 10751
	flw	f4, 1(r5)
	fadd	f3, f3, f4
	flw	f4, 2(r2)
	fmul	f4, f4, f1
	addi	r2, r0, 10751
	flw	f5, 2(r2)
	fadd	f4, f4, f5
	lw	r2, 2(r3)
	lw	r5, 0(r2)
	sw	r1, 5(r3)
	fsw	f4, 6(r3)
	fsw	f3, 8(r3)
	fsw	f2, 10(r3)
	fsw	f1, 12(r3)
	beqi	-1, r5, beq_then.16437
	addi	r6, r0, 10001
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
	beqi	0, r1, beq_then.16439
	addi	r1, r0, 0
	j	beq_cont.16440
beq_then.16439:
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
beq_cont.16440:
	j	beq_cont.16438
beq_then.16437:
	addi	r1, r0, 1
beq_cont.16438:
	beqi	0, r1, beq_then.16441
	addi	r1, r0, 10726
	flw	f1, 12(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 10727
	flw	f1, 10(r3)
	fsw	f1, 0(r1)
	flw	f1, 8(r3)
	fsw	f1, 1(r1)
	flw	f1, 6(r3)
	fsw	f1, 2(r1)
	addi	r1, r0, 10730
	lw	r2, 4(r3)
	sw	r2, 0(r1)
	addi	r1, r0, 10725
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	j	beq_cont.16442
beq_then.16441:
beq_cont.16442:
fle_cont.16436:
fle_cont.16434:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	j	solve_each_element_fast.3162
beq_then.16432:
	addi	r1, r0, 10001
	lw	r2, 4(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16443
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	j	solve_each_element_fast.3162
beq_then.16443:
	jr	r31				#
beq_then.16423:
	jr	r31				#
solve_one_or_network_fast.3166:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.16446
	addi	r7, r0, 10672
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
	beqi	-1, r5, beq_then.16447
	addi	r6, r0, 10672
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
	beqi	-1, r5, beq_then.16448
	addi	r6, r0, 10672
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
	beqi	-1, r5, beq_then.16449
	addi	r6, r0, 10672
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
beq_then.16449:
	jr	r31				#
beq_then.16448:
	jr	r31				#
beq_then.16447:
	jr	r31				#
beq_then.16446:
	jr	r31				#
trace_or_matrix_fast.3170:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.16454
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.16455
	addi	r8, r0, 10001
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
	beqi	1, r10, beq_then.16457
	beqi	2, r10, beq_then.16459
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second_fast2.3084				#	bl	solver_second_fast2.3084
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16460
beq_then.16459:
	flw	f1, 0(r7)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16461
	addi	r8, r0, 0
	j	fle_cont.16462
fle_else.16461:
	addi	r8, r0, 1
fle_cont.16462:
	beqi	0, r8, beq_then.16463
	addi	r8, r0, 10724
	flw	f1, 0(r7)
	flw	f2, 3(r9)
	fmul	f1, f1, f2
	fsw	f1, 0(r8)
	addi	r1, r0, 1
	j	beq_cont.16464
beq_then.16463:
	addi	r1, r0, 0
beq_cont.16464:
beq_cont.16460:
	j	beq_cont.16458
beq_then.16457:
	lw	r9, 0(r5)
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_rect_fast.3054				#	bl	solver_rect_fast.3054
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16458:
	beqi	0, r1, beq_then.16465
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16467
	j	fle_cont.16468
fle_else.16467:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16469
	addi	r5, r0, 10672
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
	beqi	-1, r2, beq_then.16471
	addi	r5, r0, 10672
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
	beqi	-1, r2, beq_then.16473
	addi	r5, r0, 10672
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
	j	beq_cont.16474
beq_then.16473:
beq_cont.16474:
	j	beq_cont.16472
beq_then.16471:
beq_cont.16472:
	j	beq_cont.16470
beq_then.16469:
beq_cont.16470:
fle_cont.16468:
	j	beq_cont.16466
beq_then.16465:
beq_cont.16466:
	j	beq_cont.16456
beq_then.16455:
	lw	r7, 1(r6)
	beqi	-1, r7, beq_then.16475
	addi	r8, r0, 10672
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
	beqi	-1, r2, beq_then.16477
	addi	r5, r0, 10672
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
	beqi	-1, r2, beq_then.16479
	addi	r5, r0, 10672
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
	j	beq_cont.16480
beq_then.16479:
beq_cont.16480:
	j	beq_cont.16478
beq_then.16477:
beq_cont.16478:
	j	beq_cont.16476
beq_then.16475:
beq_cont.16476:
beq_cont.16456:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16481
	addi	r7, r0, 99
	sw	r1, 4(r3)
	beq	r6, r7, beq_then.16482
	lw	r7, 0(r3)
	sw	r5, 5(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solver_fast2.3091				#	bl	solver_fast2.3091
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.16484
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16486
	j	fle_cont.16487
fle_else.16486:
	lw	r1, 5(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16488
	addi	r5, r0, 10672
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
	beqi	-1, r2, beq_then.16490
	addi	r5, r0, 10672
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
	j	beq_cont.16491
beq_then.16490:
beq_cont.16491:
	j	beq_cont.16489
beq_then.16488:
beq_cont.16489:
fle_cont.16487:
	j	beq_cont.16485
beq_then.16484:
beq_cont.16485:
	j	beq_cont.16483
beq_then.16482:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16492
	addi	r7, r0, 10672
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
	beqi	-1, r2, beq_then.16494
	addi	r5, r0, 10672
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
	j	beq_cont.16495
beq_then.16494:
beq_cont.16495:
	j	beq_cont.16493
beq_then.16492:
beq_cont.16493:
beq_cont.16483:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix_fast.3170
beq_then.16481:
	jr	r31				#
beq_then.16454:
	jr	r31				#
judge_intersection_fast.3174:
	addi	r2, r0, 10726
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r2)
	addi	r2, r0, 10723
	lw	r2, 0(r2)
	lw	r5, 0(r2)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16498
	addi	r7, r0, 99
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	beq	r6, r7, beq_then.16500
	sw	r5, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_fast2.3091				#	bl	solver_fast2.3091
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16502
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16504
	j	fle_cont.16505
fle_else.16504:
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16506
	addi	r5, r0, 10672
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
	beqi	-1, r2, beq_then.16508
	addi	r5, r0, 10672
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
	j	beq_cont.16509
beq_then.16508:
beq_cont.16509:
	j	beq_cont.16507
beq_then.16506:
beq_cont.16507:
fle_cont.16505:
	j	beq_cont.16503
beq_then.16502:
beq_cont.16503:
	j	beq_cont.16501
beq_then.16500:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16510
	addi	r7, r0, 10672
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
	beqi	-1, r2, beq_then.16512
	addi	r5, r0, 10672
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
	j	beq_cont.16513
beq_then.16512:
beq_cont.16513:
	j	beq_cont.16511
beq_then.16510:
beq_cont.16511:
beq_cont.16501:
	addi	r1, r0, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix_fast.3170				#	bl	trace_or_matrix_fast.3170
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16499
beq_then.16498:
beq_cont.16499:
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16514
	addi	r1, r0, 0
	jr	r31				#
fle_else.16514:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16515
	addi	r1, r0, 0
	jr	r31				#
fle_else.16515:
	addi	r1, r0, 1
	jr	r31				#
get_nvector_rect.3176:
	addi	r2, r0, 10725
	lw	r2, 0(r2)
	addi	r5, r0, 10731
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r5)
	fsw	f1, 1(r5)
	fsw	f1, 2(r5)
	addi	r5, r0, 10731
	addi	r6, r2, -1
	addi	r2, r2, -1
	add	r30, r1, r2
	flw	f1, 0(r30)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16516
	addi	r1, r0, 1
	j	feq_cont.16517
feq_else.16516:
	addi	r1, r0, 0
feq_cont.16517:
	beqi	0, r1, beq_then.16518
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16519
beq_then.16518:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16520
	addi	r1, r0, 0
	j	fle_cont.16521
fle_else.16520:
	addi	r1, r0, 1
fle_cont.16521:
	beqi	0, r1, beq_then.16522
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16523
beq_then.16522:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.16523:
beq_cont.16519:
	fneg	f1, f1
	add	r30, r5, r6
	fsw	f1, 0(r30)
	jr	r31				#
get_nvector_plane.3178:
	addi	r2, r0, 10731
	lw	r5, 4(r1)
	flw	f1, 0(r5)
	fneg	f1, f1
	fsw	f1, 0(r2)
	addi	r2, r0, 10731
	lw	r5, 4(r1)
	flw	f1, 1(r5)
	fneg	f1, f1
	fsw	f1, 1(r2)
	addi	r2, r0, 10731
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	fneg	f1, f1
	fsw	f1, 2(r2)
	jr	r31				#
get_nvector_second.3180:
	addi	r2, r0, 10727
	flw	f1, 0(r2)
	lw	r2, 5(r1)
	flw	f2, 0(r2)
	fsub	f1, f1, f2
	addi	r2, r0, 10727
	flw	f2, 1(r2)
	lw	r2, 5(r1)
	flw	f3, 1(r2)
	fsub	f2, f2, f3
	addi	r2, r0, 10727
	flw	f3, 2(r2)
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
	beqi	0, r2, beq_then.16526
	addi	r2, r0, 10731
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
	addi	r2, r0, 10731
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
	addi	r2, r0, 10731
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
	j	beq_cont.16527
beq_then.16526:
	addi	r2, r0, 10731
	fsw	f4, 0(r2)
	addi	r2, r0, 10731
	fsw	f5, 1(r2)
	addi	r2, r0, 10731
	fsw	f6, 2(r2)
beq_cont.16527:
	addi	r2, r0, 10731
	lw	r1, 6(r1)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	vecunit_sgn.2888
get_nvector.3182:
	lw	r5, 1(r1)
	beqi	1, r5, beq_then.16528
	beqi	2, r5, beq_then.16529
	j	get_nvector_second.3180
beq_then.16529:
	addi	r2, r0, 10731
	lw	r5, 4(r1)
	flw	f1, 0(r5)
	fneg	f1, f1
	fsw	f1, 0(r2)
	addi	r2, r0, 10731
	lw	r5, 4(r1)
	flw	f1, 1(r5)
	fneg	f1, f1
	fsw	f1, 1(r2)
	addi	r2, r0, 10731
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	fneg	f1, f1
	fsw	f1, 2(r2)
	jr	r31				#
beq_then.16528:
	addi	r1, r0, 10725
	lw	r1, 0(r1)
	addi	r5, r0, 10731
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r5)
	fsw	f1, 1(r5)
	fsw	f1, 2(r5)
	addi	r5, r0, 10731
	addi	r6, r1, -1
	addi	r1, r1, -1
	add	r30, r2, r1
	flw	f1, 0(r30)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16531
	addi	r1, r0, 1
	j	feq_cont.16532
feq_else.16531:
	addi	r1, r0, 0
feq_cont.16532:
	beqi	0, r1, beq_then.16533
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16534
beq_then.16533:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16535
	addi	r1, r0, 0
	j	fle_cont.16536
fle_else.16535:
	addi	r1, r0, 1
fle_cont.16536:
	beqi	0, r1, beq_then.16537
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16538
beq_then.16537:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.16538:
beq_cont.16534:
	fneg	f1, f1
	add	r30, r5, r6
	fsw	f1, 0(r30)
	jr	r31				#
utexture.3185:
	lw	r5, 0(r1)
	addi	r6, r0, 10734
	lw	r7, 8(r1)
	flw	f1, 0(r7)
	fsw	f1, 0(r6)
	addi	r6, r0, 10734
	lw	r7, 8(r1)
	flw	f1, 1(r7)
	fsw	f1, 1(r6)
	addi	r6, r0, 10734
	lw	r7, 8(r1)
	flw	f1, 2(r7)
	fsw	f1, 2(r6)
	beqi	1, r5, beq_then.16540
	beqi	2, r5, beq_then.16541
	beqi	3, r5, beq_then.16542
	beqi	4, r5, beq_then.16543
	jr	r31				#
beq_then.16543:
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
	beq	r0, r30, fle_else.16545
	fadd	f5, f0, f1
	j	fle_cont.16546
fle_else.16545:
	fneg	f5, f1
fle_cont.16546:
	fsw	f3, 0(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	fle	r30, f4, f5
	beq	r0, r30, fle_else.16547
	fdiv	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16549
	j	fle_cont.16550
fle_else.16549:
	fneg	f1, f1
fle_cont.16550:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16551
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.16552
fle_else.16551:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.16552:
	fmul	f1, f1, f2
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16553
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16555
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
	j	fle_cont.16556
fle_else.16555:
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
fle_cont.16556:
	j	fle_cont.16554
fle_else.16553:
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -11
	lw	r31, 10(r3)
fle_cont.16554:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.16548
fle_else.16547:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.16548:
	ftoi	r1, f1
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16557
	j	fle_cont.16558
fle_else.16557:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.16558:
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
	beq	r0, r30, fle_else.16559
	fadd	f5, f0, f4
	j	fle_cont.16560
fle_else.16559:
	fneg	f5, f4
fle_cont.16560:
	fsw	f1, 10(r3)
	fle	r30, f3, f5
	beq	r0, r30, fle_else.16561
	fdiv	f2, f2, f4
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16563
	j	fle_cont.16564
fle_else.16563:
	fneg	f2, f2
fle_cont.16564:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16565
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.16566
fle_else.16565:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.16566:
	fmul	f2, f2, f3
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f2
	beq	r0, r30, fle_else.16567
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f2
	beq	r0, r30, fle_else.16569
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
	j	fle_cont.16570
fle_else.16569:
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
fle_cont.16570:
	j	fle_cont.16568
fle_else.16567:
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -19
	lw	r31, 18(r3)
fle_cont.16568:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.16562
fle_else.16561:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.16562:
	ftoi	r1, f1
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16571
	j	fle_cont.16572
fle_else.16571:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.16572:
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
	beq	r0, r30, fle_else.16573
	addi	r1, r0, 0
	j	fle_cont.16574
fle_else.16573:
	addi	r1, r0, 1
fle_cont.16574:
	beqi	0, r1, beq_then.16575
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16576
beq_then.16575:
beq_cont.16576:
	addi	r1, r0, 10734
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f2, f1
	flup	f2, 38		# fli	f2, 0.300000
	fdiv	f1, f1, f2
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.16542:
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
	beq	r0, r30, fle_else.16578
	j	fle_cont.16579
fle_else.16578:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.16579:
	fsub	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fmul	f1, f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	cos.2839				#	bl	cos.2839
	addi	r3, r3, -19
	lw	r31, 18(r3)
	fmul	f1, f1, f1
	addi	r1, r0, 10734
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f1, f2
	fsw	f2, 1(r1)
	addi	r1, r0, 10734
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f2, f1
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f1, f2
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.16541:
	flw	f1, 1(r2)
	flup	f2, 40		# fli	f2, 0.250000
	fmul	f1, f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	sin.2837				#	bl	sin.2837
	addi	r3, r3, -19
	lw	r31, 18(r3)
	fmul	f1, f1, f1
	addi	r1, r0, 10734
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f2, f1
	fsw	f2, 0(r1)
	addi	r1, r0, 10734
	flup	f2, 37		# fli	f2, 255.000000
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f1, f3, f1
	fmul	f1, f2, f1
	fsw	f1, 1(r1)
	jr	r31				#
beq_then.16540:
	flw	f1, 0(r2)
	lw	r5, 5(r1)
	flw	f2, 0(r5)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	ftoi	r5, f2
	itof	f3, r5
	fle	r30, f3, f2
	beq	r0, r30, fle_else.16582
	fadd	f2, f0, f3
	j	fle_cont.16583
fle_else.16582:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.16583:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16584
	addi	r5, r0, 0
	j	fle_cont.16585
fle_else.16584:
	addi	r5, r0, 1
fle_cont.16585:
	flw	f1, 2(r2)
	lw	r1, 5(r1)
	flw	f2, 2(r1)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	ftoi	r1, f2
	itof	f3, r1
	fle	r30, f3, f2
	beq	r0, r30, fle_else.16586
	fadd	f2, f0, f3
	j	fle_cont.16587
fle_else.16586:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.16587:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16588
	addi	r1, r0, 0
	j	fle_cont.16589
fle_else.16588:
	addi	r1, r0, 1
fle_cont.16589:
	addi	r2, r0, 10734
	beqi	0, r5, beq_then.16590
	beqi	0, r1, beq_then.16592
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.16593
beq_then.16592:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.16593:
	j	beq_cont.16591
beq_then.16590:
	beqi	0, r1, beq_then.16594
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16595
beq_then.16594:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.16595:
beq_cont.16591:
	fsw	f1, 1(r2)
	jr	r31				#
add_light.3188:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16597
	addi	r1, r0, 0
	j	fle_cont.16598
fle_else.16597:
	addi	r1, r0, 1
fle_cont.16598:
	beqi	0, r1, beq_then.16599
	addi	r1, r0, 10740
	addi	r2, r0, 10734
	flw	f4, 0(r1)
	flw	f5, 0(r2)
	fmul	f5, f1, f5
	fadd	f4, f4, f5
	fsw	f4, 0(r1)
	flw	f4, 1(r1)
	flw	f5, 1(r2)
	fmul	f5, f1, f5
	fadd	f4, f4, f5
	fsw	f4, 1(r1)
	flw	f4, 2(r1)
	flw	f5, 2(r2)
	fmul	f1, f1, f5
	fadd	f1, f4, f1
	fsw	f1, 2(r1)
	j	beq_cont.16600
beq_then.16599:
beq_cont.16600:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.16601
	addi	r1, r0, 0
	j	fle_cont.16602
fle_else.16601:
	addi	r1, r0, 1
fle_cont.16602:
	beqi	0, r1, beq_then.16603
	fmul	f1, f2, f2
	fmul	f1, f1, f1
	fmul	f1, f1, f3
	addi	r1, r0, 10740
	addi	r2, r0, 10740
	flw	f2, 0(r2)
	fadd	f2, f2, f1
	fsw	f2, 0(r1)
	addi	r1, r0, 10740
	addi	r2, r0, 10740
	flw	f2, 1(r2)
	fadd	f2, f2, f1
	fsw	f2, 1(r1)
	addi	r1, r0, 10740
	addi	r2, r0, 10740
	flw	f2, 2(r2)
	fadd	f1, f2, f1
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.16603:
	jr	r31				#
trace_reflections.3192:
	addi	r5, r0, 0
	ble	r5, r1, ble_then.16606
	jr	r31				#
ble_then.16606:
	addi	r5, r0, 10778
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r6, 1(r5)
	addi	r7, r0, 10726
	flup	f3, 31		# fli	f3, 1000000000.000000
	fsw	f3, 0(r7)
	addi	r7, r0, 0
	addi	r8, r0, 10723
	lw	r8, 0(r8)
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
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16610
	addi	r1, r0, 0
	j	fle_cont.16611
fle_else.16610:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16612
	addi	r1, r0, 0
	j	fle_cont.16613
fle_else.16612:
	addi	r1, r0, 1
fle_cont.16613:
fle_cont.16611:
	beqi	0, r1, beq_then.16614
	addi	r1, r0, 10730
	lw	r1, 0(r1)
	slli	r1, r1, 2
	addi	r2, r0, 10725
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 9(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.16616
	j	beq_cont.16617
beq_then.16616:
	addi	r1, r0, 0
	addi	r5, r0, 10723
	lw	r5, 0(r5)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	shadow_check_one_or_matrix.3145				#	bl	shadow_check_one_or_matrix.3145
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.16618
	j	beq_cont.16619
beq_then.16618:
	addi	r1, r0, 10731
	lw	r2, 8(r3)
	lw	r5, 0(r2)
	flw	f1, 0(r1)
	flw	f2, 0(r5)
	fmul	f1, f1, f2
	flw	f2, 1(r1)
	flw	f3, 1(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	flw	f3, 2(r5)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	lw	r1, 9(r3)
	flw	f2, 2(r1)
	flw	f3, 6(r3)
	fmul	f4, f2, f3
	fmul	f1, f4, f1
	lw	r1, 0(r2)
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
beq_cont.16619:
beq_cont.16617:
	j	beq_cont.16615
beq_then.16614:
beq_cont.16615:
	lw	r1, 0(r3)
	addi	r1, r1, -1
	flw	f1, 6(r3)
	flw	f2, 2(r3)
	lw	r2, 4(r3)
	j	trace_reflections.3192
trace_ray.3197:
	blei	4, r1, ble_then.16620
	jr	r31				#
ble_then.16620:
	lw	r6, 2(r5)
	addi	r7, r0, 10726
	flup	f3, 31		# fli	f3, 1000000000.000000
	fsw	f3, 0(r7)
	addi	r7, r0, 0
	addi	r8, r0, 10723
	lw	r8, 0(r8)
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
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16623
	addi	r1, r0, 0
	j	fle_cont.16624
fle_else.16623:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16625
	addi	r1, r0, 0
	j	fle_cont.16626
fle_else.16625:
	addi	r1, r0, 1
fle_cont.16626:
fle_cont.16624:
	beqi	0, r1, beq_then.16627
	addi	r1, r0, 10730
	lw	r1, 0(r1)
	addi	r2, r0, 10001
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
	beqi	1, r6, beq_then.16628
	beqi	2, r6, beq_then.16630
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	get_nvector_second.3180				#	bl	get_nvector_second.3180
	addi	r3, r3, -15
	lw	r31, 14(r3)
	j	beq_cont.16631
beq_then.16630:
	addi	r6, r0, 10731
	lw	r7, 4(r2)
	flw	f3, 0(r7)
	fneg	f3, f3
	fsw	f3, 0(r6)
	addi	r6, r0, 10731
	lw	r7, 4(r2)
	flw	f3, 1(r7)
	fneg	f3, f3
	fsw	f3, 1(r6)
	addi	r6, r0, 10731
	lw	r7, 4(r2)
	flw	f3, 2(r7)
	fneg	f3, f3
	fsw	f3, 2(r6)
beq_cont.16631:
	j	beq_cont.16629
beq_then.16628:
	addi	r6, r0, 10725
	lw	r6, 0(r6)
	addi	r7, r0, 10731
	flup	f3, 0		# fli	f3, 0.000000
	fsw	f3, 0(r7)
	fsw	f3, 1(r7)
	fsw	f3, 2(r7)
	addi	r7, r0, 10731
	addi	r8, r6, -1
	addi	r6, r6, -1
	lw	r9, 6(r3)
	add	r30, r9, r6
	flw	f3, 0(r30)
	feq	r30, f3, f0
	beq	r0, r30, feq_else.16632
	addi	r6, r0, 1
	j	feq_cont.16633
feq_else.16632:
	addi	r6, r0, 0
feq_cont.16633:
	beqi	0, r6, beq_then.16634
	flup	f3, 0		# fli	f3, 0.000000
	j	beq_cont.16635
beq_then.16634:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.16636
	addi	r6, r0, 0
	j	fle_cont.16637
fle_else.16636:
	addi	r6, r0, 1
fle_cont.16637:
	beqi	0, r6, beq_then.16638
	flup	f3, 2		# fli	f3, 1.000000
	j	beq_cont.16639
beq_then.16638:
	flup	f3, 11		# fli	f3, -1.000000
beq_cont.16639:
beq_cont.16635:
	fneg	f3, f3
	add	r30, r7, r8
	fsw	f3, 0(r30)
beq_cont.16629:
	addi	r1, r0, 10748
	addi	r2, r0, 10727
	flw	f1, 0(r2)
	fsw	f1, 0(r1)
	flw	f1, 1(r2)
	fsw	f1, 1(r1)
	flw	f1, 2(r2)
	fsw	f1, 2(r1)
	addi	r2, r0, 10727
	lw	r1, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	utexture.3185				#	bl	utexture.3185
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r1, 12(r3)
	slli	r1, r1, 2
	addi	r2, r0, 10725
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 2(r3)
	lw	r6, 1(r1)
	add	r30, r6, r2
	lw	r6, 0(r30)
	addi	r7, r0, 10727
	flw	f1, 0(r7)
	fsw	f1, 0(r6)
	flw	f1, 1(r7)
	fsw	f1, 1(r6)
	flw	f1, 2(r7)
	fsw	f1, 2(r6)
	lw	r6, 3(r1)
	flup	f1, 1		# fli	f1, 0.500000
	lw	r7, 13(r3)
	lw	r8, 7(r7)
	flw	f2, 0(r8)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16640
	addi	r8, r0, 1
	add	r30, r6, r2
	sw	r8, 0(r30)
	lw	r6, 4(r1)
	add	r30, r6, r2
	lw	r8, 0(r30)
	addi	r9, r0, 10734
	flw	f1, 0(r9)
	fsw	f1, 0(r8)
	flw	f1, 1(r9)
	fsw	f1, 1(r8)
	flw	f1, 2(r9)
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
	addi	r8, r0, 10731
	flw	f1, 0(r8)
	fsw	f1, 0(r6)
	flw	f1, 1(r8)
	fsw	f1, 1(r6)
	flw	f1, 2(r8)
	fsw	f1, 2(r6)
	j	fle_cont.16641
fle_else.16640:
	addi	r8, r0, 0
	add	r30, r6, r2
	sw	r8, 0(r30)
fle_cont.16641:
	flup	f1, 44		# fli	f1, -2.000000
	addi	r6, r0, 10731
	lw	r8, 6(r3)
	flw	f2, 0(r8)
	flw	f3, 0(r6)
	fmul	f2, f2, f3
	flw	f3, 1(r8)
	flw	f4, 1(r6)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flw	f3, 2(r8)
	flw	f4, 2(r6)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	fmul	f1, f1, f2
	addi	r6, r0, 10731
	flw	f2, 0(r8)
	flw	f3, 0(r6)
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fsw	f2, 0(r8)
	flw	f2, 1(r8)
	flw	f3, 1(r6)
	fmul	f3, f1, f3
	fadd	f2, f2, f3
	fsw	f2, 1(r8)
	flw	f2, 2(r8)
	flw	f3, 2(r6)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	fsw	f1, 2(r8)
	lw	r6, 7(r7)
	flw	f1, 1(r6)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	addi	r6, r0, 0
	addi	r9, r0, 10723
	lw	r9, 0(r9)
	fsw	f1, 14(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	shadow_check_one_or_matrix.3145				#	bl	shadow_check_one_or_matrix.3145
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.16642
	j	beq_cont.16643
beq_then.16642:
	addi	r1, r0, 10731
	addi	r2, r0, 10667
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
	fneg	f1, f1
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	addi	r1, r0, 10667
	lw	r2, 6(r3)
	flw	f3, 0(r2)
	flw	f4, 0(r1)
	fmul	f3, f3, f4
	flw	f4, 1(r2)
	flw	f5, 1(r1)
	fmul	f4, f4, f5
	fadd	f3, f3, f4
	flw	f4, 2(r2)
	flw	f5, 2(r1)
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
beq_cont.16643:
	addi	r1, r0, 10727
	addi	r2, r0, 10751
	flw	f1, 0(r1)
	fsw	f1, 0(r2)
	flw	f1, 1(r1)
	fsw	f1, 1(r2)
	flw	f1, 2(r1)
	fsw	f1, 2(r2)
	addi	r2, r0, 10000
	lw	r2, 0(r2)
	addi	r2, r2, -1
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	setup_startp_constants.3108				#	bl	setup_startp_constants.3108
	addi	r3, r3, -17
	lw	r31, 16(r3)
	addi	r1, r0, 11023
	lw	r1, 0(r1)
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
	beq	r0, r30, fle_else.16644
	jr	r31				#
fle_else.16644:
	addi	r1, r0, 4
	lw	r2, 7(r3)
	ble	r1, r2, ble_then.16646
	addi	r1, r2, 1
	addi	r5, r0, -1
	lw	r6, 8(r3)
	add	r30, r6, r1
	sw	r5, 0(r30)
	j	ble_cont.16647
ble_then.16646:
ble_cont.16647:
	lw	r1, 9(r3)
	beqi	2, r1, beq_then.16648
	j	beq_cont.16649
beq_then.16648:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r1, 13(r3)
	lw	r1, 7(r1)
	flw	f3, 0(r1)
	fsub	f1, f1, f3
	fmul	f1, f2, f1
	addi	r1, r2, 1
	addi	r2, r0, 10726
	flw	f2, 0(r2)
	flw	f3, 0(r3)
	fadd	f2, f3, f2
	lw	r2, 6(r3)
	lw	r5, 2(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	trace_ray.3197				#	bl	trace_ray.3197
	addi	r3, r3, -17
	lw	r31, 16(r3)
beq_cont.16649:
	jr	r31				#
beq_then.16627:
	addi	r1, r0, -1
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	0, r2, beq_then.16651
	addi	r1, r0, 10667
	lw	r2, 6(r3)
	flw	f1, 0(r2)
	flw	f2, 0(r1)
	fmul	f1, f1, f2
	flw	f2, 1(r2)
	flw	f3, 1(r1)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r2)
	flw	f3, 2(r1)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fneg	f1, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16652
	addi	r1, r0, 0
	j	fle_cont.16653
fle_else.16652:
	addi	r1, r0, 1
fle_cont.16653:
	beqi	0, r1, beq_then.16654
	fmul	f2, f1, f1
	fmul	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	addi	r1, r0, 10670
	flw	f2, 0(r1)
	fmul	f1, f1, f2
	addi	r1, r0, 10740
	addi	r2, r0, 10740
	flw	f2, 0(r2)
	fadd	f2, f2, f1
	fsw	f2, 0(r1)
	addi	r1, r0, 10740
	addi	r2, r0, 10740
	flw	f2, 1(r2)
	fadd	f2, f2, f1
	fsw	f2, 1(r1)
	addi	r1, r0, 10740
	addi	r2, r0, 10740
	flw	f2, 2(r2)
	fadd	f1, f2, f1
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.16654:
	jr	r31				#
beq_then.16651:
	jr	r31				#
trace_diffuse_ray.3203:
	addi	r2, r0, 10726
	flup	f2, 31		# fli	f2, 1000000000.000000
	fsw	f2, 0(r2)
	addi	r2, r0, 0
	addi	r5, r0, 10723
	lw	r5, 0(r5)
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
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16658
	addi	r1, r0, 0
	j	fle_cont.16659
fle_else.16658:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16660
	addi	r1, r0, 0
	j	fle_cont.16661
fle_else.16660:
	addi	r1, r0, 1
fle_cont.16661:
fle_cont.16659:
	beqi	0, r1, beq_then.16662
	addi	r1, r0, 10001
	addi	r2, r0, 10730
	lw	r2, 0(r2)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r2, 2(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	sw	r1, 3(r3)
	beqi	1, r5, beq_then.16663
	beqi	2, r5, beq_then.16665
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	get_nvector_second.3180				#	bl	get_nvector_second.3180
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16666
beq_then.16665:
	addi	r2, r0, 10731
	lw	r5, 4(r1)
	flw	f1, 0(r5)
	fneg	f1, f1
	fsw	f1, 0(r2)
	addi	r2, r0, 10731
	lw	r5, 4(r1)
	flw	f1, 1(r5)
	fneg	f1, f1
	fsw	f1, 1(r2)
	addi	r2, r0, 10731
	lw	r5, 4(r1)
	flw	f1, 2(r5)
	fneg	f1, f1
	fsw	f1, 2(r2)
beq_cont.16666:
	j	beq_cont.16664
beq_then.16663:
	addi	r5, r0, 10725
	lw	r5, 0(r5)
	addi	r6, r0, 10731
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r6)
	fsw	f1, 1(r6)
	fsw	f1, 2(r6)
	addi	r6, r0, 10731
	addi	r7, r5, -1
	addi	r5, r5, -1
	add	r30, r2, r5
	flw	f1, 0(r30)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16667
	addi	r2, r0, 1
	j	feq_cont.16668
feq_else.16667:
	addi	r2, r0, 0
feq_cont.16668:
	beqi	0, r2, beq_then.16669
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16670
beq_then.16669:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16671
	addi	r2, r0, 0
	j	fle_cont.16672
fle_else.16671:
	addi	r2, r0, 1
fle_cont.16672:
	beqi	0, r2, beq_then.16673
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16674
beq_then.16673:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.16674:
beq_cont.16670:
	fneg	f1, f1
	add	r30, r6, r7
	fsw	f1, 0(r30)
beq_cont.16664:
	addi	r2, r0, 10727
	lw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	utexture.3185				#	bl	utexture.3185
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 0
	addi	r2, r0, 10723
	lw	r2, 0(r2)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_one_or_matrix.3145				#	bl	shadow_check_one_or_matrix.3145
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.16675
	jr	r31				#
beq_then.16675:
	addi	r1, r0, 10731
	addi	r2, r0, 10667
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
	fneg	f1, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16677
	addi	r1, r0, 0
	j	fle_cont.16678
fle_else.16677:
	addi	r1, r0, 1
fle_cont.16678:
	beqi	0, r1, beq_then.16679
	j	beq_cont.16680
beq_then.16679:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.16680:
	addi	r1, r0, 10737
	flw	f2, 0(r3)
	fmul	f1, f2, f1
	lw	r2, 3(r3)
	lw	r2, 7(r2)
	flw	f2, 0(r2)
	fmul	f1, f1, f2
	addi	r2, r0, 10734
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
beq_then.16662:
	jr	r31				#
iter_trace_diffuse_rays.3206:
	addi	r7, r0, 0
	ble	r7, r6, ble_then.16683
	jr	r31				#
ble_then.16683:
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
	beq	r0, r30, fle_else.16685
	addi	r7, r0, 0
	j	fle_cont.16686
fle_else.16685:
	addi	r7, r0, 1
fle_cont.16686:
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r6, 3(r3)
	beqi	0, r7, beq_then.16687
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
	j	beq_cont.16688
beq_then.16687:
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
beq_cont.16688:
	lw	r1, 3(r3)
	addi	r1, r1, -2
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16689
	jr	r31				#
ble_then.16689:
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
	beq	r0, r30, fle_else.16691
	addi	r5, r0, 0
	j	fle_cont.16692
fle_else.16691:
	addi	r5, r0, 1
fle_cont.16692:
	sw	r1, 4(r3)
	beqi	0, r5, beq_then.16693
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
	j	beq_cont.16694
beq_then.16693:
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
beq_cont.16694:
	lw	r1, 4(r3)
	addi	r6, r1, -2
	lw	r1, 2(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	iter_trace_diffuse_rays.3206
trace_diffuse_rays.3211:
	addi	r6, r0, 10751
	flw	f1, 0(r5)
	fsw	f1, 0(r6)
	flw	f1, 1(r5)
	fsw	f1, 1(r6)
	flw	f1, 2(r5)
	fsw	f1, 2(r6)
	addi	r6, r0, 10000
	lw	r6, 0(r6)
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
	beq	r0, r30, fle_else.16695
	addi	r2, r0, 0
	j	fle_cont.16696
fle_else.16695:
	addi	r2, r0, 1
fle_cont.16696:
	beqi	0, r2, beq_then.16697
	lw	r2, 119(r1)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_ray.3203				#	bl	trace_diffuse_ray.3203
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16698
beq_then.16697:
	lw	r2, 118(r1)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_ray.3203				#	bl	trace_diffuse_ray.3203
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16698:
	addi	r6, r0, 116
	lw	r1, 2(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	iter_trace_diffuse_rays.3206
trace_diffuse_ray_80percent.3215:
	sw	r2, 0(r3)
	sw	r5, 1(r3)
	sw	r1, 2(r3)
	beqi	0, r1, beq_then.16699
	addi	r6, r0, 10766
	lw	r6, 0(r6)
	addi	r7, r0, 10751
	flw	f1, 0(r5)
	fsw	f1, 0(r7)
	flw	f1, 1(r5)
	fsw	f1, 1(r7)
	flw	f1, 2(r5)
	fsw	f1, 2(r7)
	addi	r7, r0, 10000
	lw	r7, 0(r7)
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
	j	beq_cont.16700
beq_then.16699:
beq_cont.16700:
	lw	r1, 2(r3)
	beqi	1, r1, beq_then.16701
	addi	r2, r0, 10766
	lw	r2, 1(r2)
	addi	r5, r0, 10751
	lw	r6, 1(r3)
	flw	f1, 0(r6)
	fsw	f1, 0(r5)
	flw	f1, 1(r6)
	fsw	f1, 1(r5)
	flw	f1, 2(r6)
	fsw	f1, 2(r5)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	sw	r2, 4(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
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
	j	beq_cont.16702
beq_then.16701:
beq_cont.16702:
	lw	r1, 2(r3)
	beqi	2, r1, beq_then.16703
	addi	r2, r0, 10766
	lw	r2, 2(r2)
	addi	r5, r0, 10751
	lw	r6, 1(r3)
	flw	f1, 0(r6)
	fsw	f1, 0(r5)
	flw	f1, 1(r6)
	fsw	f1, 1(r5)
	flw	f1, 2(r6)
	fsw	f1, 2(r5)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	sw	r2, 5(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
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
	j	beq_cont.16704
beq_then.16703:
beq_cont.16704:
	lw	r1, 2(r3)
	beqi	3, r1, beq_then.16705
	addi	r2, r0, 10766
	lw	r2, 3(r2)
	addi	r5, r0, 10751
	lw	r6, 1(r3)
	flw	f1, 0(r6)
	fsw	f1, 0(r5)
	flw	f1, 1(r6)
	fsw	f1, 1(r5)
	flw	f1, 2(r6)
	fsw	f1, 2(r5)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	sw	r2, 6(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
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
	j	beq_cont.16706
beq_then.16705:
beq_cont.16706:
	lw	r1, 2(r3)
	beqi	4, r1, beq_then.16707
	addi	r1, r0, 10766
	lw	r1, 4(r1)
	addi	r2, r0, 10751
	lw	r5, 1(r3)
	flw	f1, 0(r5)
	fsw	f1, 0(r2)
	flw	f1, 1(r5)
	fsw	f1, 1(r2)
	flw	f1, 2(r5)
	fsw	f1, 2(r2)
	addi	r2, r0, 10000
	lw	r2, 0(r2)
	addi	r2, r2, -1
	sw	r1, 7(r3)
	add	r1, r0, r5				# mr	r1, r5
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
beq_then.16707:
	jr	r31				#
calc_diffuse_using_1point.3219:
	lw	r5, 5(r1)
	lw	r6, 7(r1)
	lw	r7, 1(r1)
	lw	r8, 4(r1)
	addi	r9, r0, 10737
	add	r30, r5, r2
	lw	r5, 0(r30)
	flw	f1, 0(r5)
	fsw	f1, 0(r9)
	flw	f1, 1(r5)
	fsw	f1, 1(r9)
	flw	f1, 2(r5)
	fsw	f1, 2(r9)
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
	addi	r1, r0, 10740
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 10737
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
	addi	r11, r0, 10737
	add	r30, r2, r7
	lw	r2, 0(r30)
	flw	f1, 0(r2)
	fsw	f1, 0(r11)
	flw	f1, 1(r2)
	fsw	f1, 1(r11)
	flw	f1, 2(r2)
	fsw	f1, 2(r11)
	addi	r2, r0, 10737
	add	r30, r8, r7
	lw	r8, 0(r30)
	flw	f1, 0(r2)
	flw	f2, 0(r8)
	fadd	f1, f1, f2
	fsw	f1, 0(r2)
	flw	f1, 1(r2)
	flw	f2, 1(r8)
	fadd	f1, f1, f2
	fsw	f1, 1(r2)
	flw	f1, 2(r2)
	flw	f2, 2(r8)
	fadd	f1, f1, f2
	fsw	f1, 2(r2)
	addi	r2, r0, 10737
	add	r30, r9, r7
	lw	r8, 0(r30)
	flw	f1, 0(r2)
	flw	f2, 0(r8)
	fadd	f1, f1, f2
	fsw	f1, 0(r2)
	flw	f1, 1(r2)
	flw	f2, 1(r8)
	fadd	f1, f1, f2
	fsw	f1, 1(r2)
	flw	f1, 2(r2)
	flw	f2, 2(r8)
	fadd	f1, f1, f2
	fsw	f1, 2(r2)
	addi	r2, r0, 10737
	add	r30, r10, r7
	lw	r8, 0(r30)
	flw	f1, 0(r2)
	flw	f2, 0(r8)
	fadd	f1, f1, f2
	fsw	f1, 0(r2)
	flw	f1, 1(r2)
	flw	f2, 1(r8)
	fadd	f1, f1, f2
	fsw	f1, 1(r2)
	flw	f1, 2(r2)
	flw	f2, 2(r8)
	fadd	f1, f1, f2
	fsw	f1, 2(r2)
	addi	r2, r0, 10737
	add	r30, r6, r7
	lw	r6, 0(r30)
	flw	f1, 0(r2)
	flw	f2, 0(r6)
	fadd	f1, f1, f2
	fsw	f1, 0(r2)
	flw	f1, 1(r2)
	flw	f2, 1(r6)
	fadd	f1, f1, f2
	fsw	f1, 1(r2)
	flw	f1, 2(r2)
	flw	f2, 2(r6)
	fadd	f1, f1, f2
	fsw	f1, 2(r2)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 4(r1)
	addi	r2, r0, 10740
	add	r30, r1, r7
	lw	r1, 0(r30)
	addi	r5, r0, 10737
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	vecaccumv.2912
do_without_neighbors.3228:
	blei	4, r2, ble_then.16709
	jr	r31				#
ble_then.16709:
	lw	r5, 2(r1)
	addi	r6, r0, 0
	add	r30, r5, r2
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.16711
	jr	r31				#
ble_then.16711:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	beqi	0, r5, beq_then.16713
	lw	r5, 5(r1)
	lw	r6, 7(r1)
	lw	r7, 1(r1)
	lw	r8, 4(r1)
	addi	r9, r0, 10737
	add	r30, r5, r2
	lw	r5, 0(r30)
	flw	f1, 0(r5)
	fsw	f1, 0(r9)
	flw	f1, 1(r5)
	fsw	f1, 1(r9)
	flw	f1, 2(r5)
	fsw	f1, 2(r9)
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
	addi	r1, r0, 10740
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 10737
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	vecaccumv.2912				#	bl	vecaccumv.2912
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16714
beq_then.16713:
beq_cont.16714:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	blei	4, r1, ble_then.16715
	jr	r31				#
ble_then.16715:
	lw	r2, 0(r3)
	lw	r5, 2(r2)
	addi	r6, r0, 0
	add	r30, r5, r1
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.16717
	jr	r31				#
ble_then.16717:
	lw	r5, 3(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	sw	r1, 3(r3)
	beqi	0, r5, beq_then.16719
	lw	r5, 5(r2)
	lw	r6, 7(r2)
	lw	r7, 1(r2)
	lw	r8, 4(r2)
	addi	r9, r0, 10737
	add	r30, r5, r1
	lw	r5, 0(r30)
	flw	f1, 0(r5)
	fsw	f1, 0(r9)
	flw	f1, 1(r5)
	fsw	f1, 1(r9)
	flw	f1, 2(r5)
	fsw	f1, 2(r9)
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
	addi	r1, r0, 10740
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 10737
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	vecaccumv.2912				#	bl	vecaccumv.2912
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16720
beq_then.16719:
beq_cont.16720:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	lw	r1, 0(r3)
	j	do_without_neighbors.3228
neighbors_exist.3231:
	addi	r5, r0, 10743
	lw	r5, 1(r5)
	addi	r6, r2, 1
	ble	r5, r6, ble_then.16721
	blei	0, r2, ble_then.16722
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.16723
	blei	0, r1, ble_then.16724
	addi	r1, r0, 1
	jr	r31				#
ble_then.16724:
	addi	r1, r0, 0
	jr	r31				#
ble_then.16723:
	addi	r1, r0, 0
	jr	r31				#
ble_then.16722:
	addi	r1, r0, 0
	jr	r31				#
ble_then.16721:
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
	beq	r2, r8, beq_then.16725
	addi	r1, r0, 0
	jr	r31				#
beq_then.16725:
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.16726
	addi	r1, r0, 0
	jr	r31				#
beq_then.16726:
	addi	r2, r1, -1
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.16727
	addi	r1, r0, 0
	jr	r31				#
beq_then.16727:
	addi	r1, r1, 1
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beq	r1, r8, beq_then.16728
	addi	r1, r0, 0
	jr	r31				#
beq_then.16728:
	addi	r1, r0, 1
	jr	r31				#
try_exploit_neighbors.3244:
	add	r30, r6, r1
	lw	r9, 0(r30)
	blei	4, r8, ble_then.16729
	jr	r31				#
ble_then.16729:
	addi	r10, r0, 0
	lw	r11, 2(r9)
	add	r30, r11, r8
	lw	r11, 0(r30)
	ble	r10, r11, ble_then.16731
	jr	r31				#
ble_then.16731:
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
	beq	r11, r10, beq_then.16733
	addi	r10, r0, 0
	j	beq_cont.16734
beq_then.16733:
	add	r30, r7, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r10, beq_then.16735
	addi	r10, r0, 0
	j	beq_cont.16736
beq_then.16735:
	addi	r11, r1, -1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r10, beq_then.16737
	addi	r10, r0, 0
	j	beq_cont.16738
beq_then.16737:
	addi	r11, r1, 1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r10, beq_then.16739
	addi	r10, r0, 0
	j	beq_cont.16740
beq_then.16739:
	addi	r10, r0, 1
beq_cont.16740:
beq_cont.16738:
beq_cont.16736:
beq_cont.16734:
	beqi	0, r10, beq_then.16741
	lw	r9, 3(r9)
	add	r30, r9, r8
	lw	r9, 0(r30)
	sw	r2, 0(r3)
	sw	r7, 1(r3)
	sw	r5, 2(r3)
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	beqi	0, r9, beq_then.16742
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r8				# mr	r7, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_diffuse_using_5points.3222				#	bl	calc_diffuse_using_5points.3222
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16743
beq_then.16742:
beq_cont.16743:
	lw	r1, 5(r3)
	addi	r2, r1, 1
	lw	r1, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r1
	lw	r6, 0(r30)
	blei	4, r2, ble_then.16744
	jr	r31				#
ble_then.16744:
	addi	r7, r0, 0
	lw	r8, 2(r6)
	add	r30, r8, r2
	lw	r8, 0(r30)
	ble	r7, r8, ble_then.16746
	jr	r31				#
ble_then.16746:
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
	beq	r9, r7, beq_then.16748
	addi	r7, r0, 0
	j	beq_cont.16749
beq_then.16748:
	lw	r9, 1(r3)
	add	r30, r9, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.16750
	addi	r7, r0, 0
	j	beq_cont.16751
beq_then.16750:
	addi	r10, r1, -1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.16752
	addi	r7, r0, 0
	j	beq_cont.16753
beq_then.16752:
	addi	r10, r1, 1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.16754
	addi	r7, r0, 0
	j	beq_cont.16755
beq_then.16754:
	addi	r7, r0, 1
beq_cont.16755:
beq_cont.16753:
beq_cont.16751:
beq_cont.16749:
	beqi	0, r7, beq_then.16756
	lw	r6, 3(r6)
	add	r30, r6, r2
	lw	r6, 0(r30)
	sw	r2, 6(r3)
	beqi	0, r6, beq_then.16757
	lw	r6, 1(r3)
	add	r7, r0, r2				# mr	r7, r2
	add	r2, r0, r8				# mr	r2, r8
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	calc_diffuse_using_5points.3222				#	bl	calc_diffuse_using_5points.3222
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.16758
beq_then.16757:
beq_cont.16758:
	lw	r1, 6(r3)
	addi	r8, r1, 1
	lw	r1, 3(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	lw	r7, 1(r3)
	j	try_exploit_neighbors.3244
beq_then.16756:
	add	r30, r5, r1
	lw	r1, 0(r30)
	j	do_without_neighbors.3228
beq_then.16741:
	add	r30, r6, r1
	lw	r1, 0(r30)
	blei	4, r8, ble_then.16759
	jr	r31				#
ble_then.16759:
	lw	r2, 2(r1)
	addi	r5, r0, 0
	add	r30, r2, r8
	lw	r2, 0(r30)
	ble	r5, r2, ble_then.16761
	jr	r31				#
ble_then.16761:
	lw	r2, 3(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	sw	r1, 7(r3)
	sw	r8, 5(r3)
	beqi	0, r2, beq_then.16763
	lw	r2, 5(r1)
	lw	r5, 7(r1)
	lw	r6, 1(r1)
	lw	r7, 4(r1)
	addi	r9, r0, 10737
	add	r30, r2, r8
	lw	r2, 0(r30)
	flw	f1, 0(r2)
	fsw	f1, 0(r9)
	flw	f1, 1(r2)
	fsw	f1, 1(r9)
	flw	f1, 2(r2)
	fsw	f1, 2(r9)
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
	addi	r1, r0, 10740
	lw	r2, 5(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 10737
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	vecaccumv.2912				#	bl	vecaccumv.2912
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.16764
beq_then.16763:
beq_cont.16764:
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
	addi	r1, r0, 10743
	lw	r1, 0(r1)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10743
	lw	r1, 1(r1)
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
	ble	r1, r2, ble_then.16765
	addi	r1, r0, 255
	j	ble_cont.16766
ble_then.16765:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16767
	addi	r1, r0, 0
	j	ble_cont.16768
ble_then.16767:
ble_cont.16768:
ble_cont.16766:
	j	print_int.2857
write_rgb.3255:
	addi	r1, r0, 10740
	flw	f1, 0(r1)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16769
	addi	r1, r0, 255
	j	ble_cont.16770
ble_then.16769:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16771
	addi	r1, r0, 0
	j	ble_cont.16772
ble_then.16771:
ble_cont.16772:
ble_cont.16770:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10740
	flw	f1, 1(r1)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16773
	addi	r1, r0, 255
	j	ble_cont.16774
ble_then.16773:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16775
	addi	r1, r0, 0
	j	ble_cont.16776
ble_then.16775:
ble_cont.16776:
ble_cont.16774:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10740
	flw	f1, 2(r1)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16777
	addi	r1, r0, 255
	j	ble_cont.16778
ble_then.16777:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16779
	addi	r1, r0, 0
	j	ble_cont.16780
ble_then.16779:
ble_cont.16780:
ble_cont.16778:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
pretrace_diffuse_rays.3257:
	blei	4, r2, ble_then.16781
	jr	r31				#
ble_then.16781:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 0
	ble	r6, r5, ble_then.16783
	jr	r31				#
ble_then.16783:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 0(r3)
	beqi	0, r5, beq_then.16785
	lw	r5, 6(r1)
	lw	r5, 0(r5)
	addi	r6, r0, 10737
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r6)
	fsw	f1, 1(r6)
	fsw	f1, 2(r6)
	lw	r6, 7(r1)
	lw	r7, 1(r1)
	addi	r8, r0, 10766
	add	r30, r8, r5
	lw	r5, 0(r30)
	add	r30, r6, r2
	lw	r6, 0(r30)
	add	r30, r7, r2
	lw	r7, 0(r30)
	addi	r8, r0, 10751
	flw	f1, 0(r7)
	fsw	f1, 0(r8)
	flw	f1, 1(r7)
	fsw	f1, 1(r8)
	flw	f1, 2(r7)
	fsw	f1, 2(r8)
	addi	r8, r0, 10000
	lw	r8, 0(r8)
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
	addi	r6, r0, 10737
	flw	f1, 0(r6)
	fsw	f1, 0(r2)
	flw	f1, 1(r6)
	fsw	f1, 1(r2)
	flw	f1, 2(r6)
	fsw	f1, 2(r2)
	j	beq_cont.16786
beq_then.16785:
beq_cont.16786:
	lw	r2, 0(r3)
	addi	r2, r2, 1
	j	pretrace_diffuse_rays.3257
pretrace_pixels.3260:
	addi	r6, r0, 0
	ble	r6, r2, ble_then.16787
	jr	r31				#
ble_then.16787:
	addi	r6, r0, 10747
	flw	f4, 0(r6)
	addi	r6, r0, 10745
	lw	r6, 0(r6)
	sub	r6, r2, r6
	itof	f5, r6
	fmul	f4, f4, f5
	addi	r6, r0, 10763
	addi	r7, r0, 10754
	flw	f5, 0(r7)
	fmul	f5, f4, f5
	fadd	f5, f5, f1
	fsw	f5, 0(r6)
	addi	r6, r0, 10763
	addi	r7, r0, 10754
	flw	f5, 1(r7)
	fmul	f5, f4, f5
	fadd	f5, f5, f2
	fsw	f5, 1(r6)
	addi	r6, r0, 10763
	addi	r7, r0, 10754
	flw	f5, 2(r7)
	fmul	f4, f4, f5
	fadd	f4, f4, f3
	fsw	f4, 2(r6)
	addi	r6, r0, 10763
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
	addi	r1, r0, 10740
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
	fsw	f1, 1(r1)
	fsw	f1, 2(r1)
	addi	r1, r0, 10748
	addi	r2, r0, 10664
	flw	f1, 0(r2)
	fsw	f1, 0(r1)
	flw	f1, 1(r2)
	fsw	f1, 1(r1)
	flw	f1, 2(r2)
	fsw	f1, 2(r1)
	addi	r1, r0, 0
	flup	f1, 2		# fli	f1, 1.000000
	addi	r2, r0, 10763
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
	addi	r6, r0, 10740
	flw	f1, 0(r6)
	fsw	f1, 0(r5)
	flw	f1, 1(r6)
	fsw	f1, 1(r5)
	flw	f1, 2(r6)
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
	addi	r5, r0, 5
	ble	r5, r1, ble_then.16789
	add	r5, r0, r1
	j	ble_cont.16790
ble_then.16789:
	addi	r5, r1, -5
ble_cont.16790:
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r1, 8(r3)
	j	pretrace_pixels.3260
pretrace_line.3267:
	addi	r6, r0, 10747
	flw	f1, 0(r6)
	addi	r6, r0, 10745
	lw	r6, 1(r6)
	sub	r2, r2, r6
	itof	f2, r2
	fmul	f1, f1, f2
	addi	r2, r0, 10757
	flw	f2, 0(r2)
	fmul	f2, f1, f2
	addi	r2, r0, 10760
	flw	f3, 0(r2)
	fadd	f2, f2, f3
	addi	r2, r0, 10757
	flw	f3, 1(r2)
	fmul	f3, f1, f3
	addi	r2, r0, 10760
	flw	f4, 1(r2)
	fadd	f3, f3, f4
	addi	r2, r0, 10757
	flw	f4, 2(r2)
	fmul	f1, f1, f4
	addi	r2, r0, 10760
	flw	f4, 2(r2)
	fadd	f1, f1, f4
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r2, r2, -1
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	j	pretrace_pixels.3260
scan_pixel.3271:
	addi	r8, r0, 10743
	lw	r8, 0(r8)
	ble	r8, r1, ble_then.16791
	addi	r8, r0, 10740
	add	r30, r6, r1
	lw	r9, 0(r30)
	lw	r9, 0(r9)
	flw	f1, 0(r9)
	fsw	f1, 0(r8)
	flw	f1, 1(r9)
	fsw	f1, 1(r8)
	flw	f1, 2(r9)
	fsw	f1, 2(r8)
	addi	r8, r0, 10743
	lw	r8, 1(r8)
	addi	r9, r2, 1
	ble	r8, r9, ble_then.16792
	blei	0, r2, ble_then.16794
	addi	r8, r0, 10743
	lw	r8, 0(r8)
	addi	r9, r1, 1
	ble	r8, r9, ble_then.16796
	blei	0, r1, ble_then.16798
	addi	r8, r0, 1
	j	ble_cont.16799
ble_then.16798:
	addi	r8, r0, 0
ble_cont.16799:
	j	ble_cont.16797
ble_then.16796:
	addi	r8, r0, 0
ble_cont.16797:
	j	ble_cont.16795
ble_then.16794:
	addi	r8, r0, 0
ble_cont.16795:
	j	ble_cont.16793
ble_then.16792:
	addi	r8, r0, 0
ble_cont.16793:
	sw	r7, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r6, 3(r3)
	sw	r1, 4(r3)
	beqi	0, r8, beq_then.16800
	addi	r8, r0, 0
	add	r30, r6, r1
	lw	r9, 0(r30)
	addi	r10, r0, 0
	lw	r11, 2(r9)
	lw	r11, 0(r11)
	ble	r10, r11, ble_then.16802
	j	ble_cont.16803
ble_then.16802:
	add	r30, r6, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	lw	r10, 0(r10)
	add	r30, r5, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16804
	addi	r10, r0, 0
	j	beq_cont.16805
beq_then.16804:
	add	r30, r7, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16806
	addi	r10, r0, 0
	j	beq_cont.16807
beq_then.16806:
	addi	r11, r1, -1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16808
	addi	r10, r0, 0
	j	beq_cont.16809
beq_then.16808:
	addi	r11, r1, 1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16810
	addi	r10, r0, 0
	j	beq_cont.16811
beq_then.16810:
	addi	r10, r0, 1
beq_cont.16811:
beq_cont.16809:
beq_cont.16807:
beq_cont.16805:
	beqi	0, r10, beq_then.16812
	lw	r9, 3(r9)
	lw	r9, 0(r9)
	beqi	0, r9, beq_then.16814
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r8				# mr	r7, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_diffuse_using_5points.3222				#	bl	calc_diffuse_using_5points.3222
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16815
beq_then.16814:
beq_cont.16815:
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
	j	beq_cont.16813
beq_then.16812:
	add	r30, r6, r1
	lw	r9, 0(r30)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	do_without_neighbors.3228				#	bl	do_without_neighbors.3228
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16813:
ble_cont.16803:
	j	beq_cont.16801
beq_then.16800:
	add	r30, r6, r1
	lw	r8, 0(r30)
	lw	r9, 2(r8)
	addi	r10, r0, 0
	lw	r9, 0(r9)
	ble	r10, r9, ble_then.16816
	j	ble_cont.16817
ble_then.16816:
	lw	r9, 3(r8)
	lw	r9, 0(r9)
	sw	r8, 5(r3)
	beqi	0, r9, beq_then.16818
	lw	r9, 5(r8)
	lw	r10, 7(r8)
	lw	r11, 1(r8)
	lw	r12, 4(r8)
	addi	r13, r0, 10737
	lw	r9, 0(r9)
	flw	f1, 0(r9)
	fsw	f1, 0(r13)
	flw	f1, 1(r9)
	fsw	f1, 1(r13)
	flw	f1, 2(r9)
	fsw	f1, 2(r13)
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
	addi	r1, r0, 10740
	lw	r2, 6(r3)
	lw	r2, 0(r2)
	addi	r5, r0, 10737
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	vecaccumv.2912				#	bl	vecaccumv.2912
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.16819
beq_then.16818:
beq_cont.16819:
	addi	r2, r0, 1
	lw	r1, 5(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	do_without_neighbors.3228				#	bl	do_without_neighbors.3228
	addi	r3, r3, -8
	lw	r31, 7(r3)
ble_cont.16817:
beq_cont.16801:
	addi	r1, r0, 10740
	flw	f1, 0(r1)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16820
	addi	r1, r0, 255
	j	ble_cont.16821
ble_then.16820:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16822
	addi	r1, r0, 0
	j	ble_cont.16823
ble_then.16822:
ble_cont.16823:
ble_cont.16821:
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10740
	flw	f1, 1(r1)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16824
	addi	r1, r0, 255
	j	ble_cont.16825
ble_then.16824:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16826
	addi	r1, r0, 0
	j	ble_cont.16827
ble_then.16826:
ble_cont.16827:
ble_cont.16825:
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10740
	flw	f1, 2(r1)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16828
	addi	r1, r0, 255
	j	ble_cont.16829
ble_then.16828:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16830
	addi	r1, r0, 0
	j	ble_cont.16831
ble_then.16830:
ble_cont.16831:
ble_cont.16829:
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 10
	out	r1
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	ble	r2, r1, ble_then.16832
	addi	r2, r0, 10740
	lw	r6, 3(r3)
	add	r30, r6, r1
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	flw	f1, 0(r5)
	fsw	f1, 0(r2)
	flw	f1, 1(r5)
	fsw	f1, 1(r2)
	flw	f1, 2(r5)
	fsw	f1, 2(r2)
	addi	r2, r0, 10743
	lw	r2, 1(r2)
	lw	r5, 2(r3)
	addi	r7, r5, 1
	ble	r2, r7, ble_then.16833
	blei	0, r5, ble_then.16835
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r7, r1, 1
	ble	r2, r7, ble_then.16837
	blei	0, r1, ble_then.16839
	addi	r2, r0, 1
	j	ble_cont.16840
ble_then.16839:
	addi	r2, r0, 0
ble_cont.16840:
	j	ble_cont.16838
ble_then.16837:
	addi	r2, r0, 0
ble_cont.16838:
	j	ble_cont.16836
ble_then.16835:
	addi	r2, r0, 0
ble_cont.16836:
	j	ble_cont.16834
ble_then.16833:
	addi	r2, r0, 0
ble_cont.16834:
	sw	r1, 7(r3)
	beqi	0, r2, beq_then.16841
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
	j	beq_cont.16842
beq_then.16841:
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
beq_cont.16842:
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
ble_then.16832:
	jr	r31				#
ble_then.16791:
	jr	r31				#
scan_line.3277:
	addi	r8, r0, 10743
	lw	r8, 1(r8)
	ble	r8, r1, ble_then.16845
	addi	r8, r0, 10743
	lw	r8, 1(r8)
	addi	r8, r8, -1
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	ble	r8, r1, ble_then.16846
	addi	r8, r1, 1
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	pretrace_line.3267				#	bl	pretrace_line.3267
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	ble_cont.16847
ble_then.16846:
ble_cont.16847:
	addi	r1, r0, 0
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	blei	0, r2, ble_then.16848
	addi	r2, r0, 10740
	lw	r6, 4(r3)
	lw	r5, 0(r6)
	lw	r5, 0(r5)
	flw	f1, 0(r5)
	fsw	f1, 0(r2)
	flw	f1, 1(r5)
	fsw	f1, 1(r2)
	flw	f1, 2(r5)
	fsw	f1, 2(r2)
	addi	r2, r0, 10743
	lw	r2, 1(r2)
	lw	r5, 3(r3)
	addi	r7, r5, 1
	ble	r2, r7, ble_then.16850
	blei	0, r5, ble_then.16852
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	blei	1, r2, ble_then.16854
	addi	r2, r0, 0
	j	ble_cont.16855
ble_then.16854:
	addi	r2, r0, 0
ble_cont.16855:
	j	ble_cont.16853
ble_then.16852:
	addi	r2, r0, 0
ble_cont.16853:
	j	ble_cont.16851
ble_then.16850:
	addi	r2, r0, 0
ble_cont.16851:
	beqi	0, r2, beq_then.16856
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
	j	beq_cont.16857
beq_then.16856:
	lw	r1, 0(r6)
	addi	r2, r0, 0
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	do_without_neighbors.3228				#	bl	do_without_neighbors.3228
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16857:
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
	j	ble_cont.16849
ble_then.16848:
ble_cont.16849:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	lw	r1, 0(r3)
	addi	r1, r1, 2
	addi	r5, r0, 5
	ble	r5, r1, ble_then.16858
	add	r5, r0, r1
	j	ble_cont.16859
ble_then.16858:
	addi	r5, r1, -5
ble_cont.16859:
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	ble	r1, r2, ble_then.16860
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r5, 5(r3)
	sw	r2, 6(r3)
	ble	r1, r2, ble_then.16862
	addi	r1, r2, 1
	lw	r6, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	pretrace_line.3267				#	bl	pretrace_line.3267
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	ble_cont.16863
ble_then.16862:
ble_cont.16863:
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
	addi	r5, r0, 5
	ble	r5, r2, ble_then.16864
	add	r7, r0, r2
	j	ble_cont.16865
ble_then.16864:
	addi	r7, r2, -5
ble_cont.16865:
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	scan_line.3277				#	bl	scan_line.3277
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	ble_cont.16861
ble_then.16860:
ble_cont.16861:
	jr	r31				#
ble_then.16845:
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
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16868
	jr	r31				#
ble_then.16868:
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
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16869
	add	r1, r0, r5
	jr	r31				#
ble_then.16869:
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
	addi	r1, r0, 10743
	lw	r1, 0(r1)
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
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r2, r2, -2
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16870
	jr	r31				#
ble_then.16870:
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
	beq	r0, r30, fle_else.16871
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.16872
fle_else.16871:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.16872:
	fmul	f3, f3, f4
	flup	f5, 23		# fli	f5, 4.375000
	fsw	f1, 0(r3)
	fsw	f2, 2(r3)
	fle	r30, f5, f3
	beq	r0, r30, fle_else.16873
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f3
	beq	r0, r30, fle_else.16875
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
	j	fle_cont.16876
fle_else.16875:
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
fle_cont.16876:
	j	fle_cont.16874
fle_else.16873:
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -11
	lw	r31, 10(r3)
fle_cont.16874:
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
	addi	r6, r0, 5
	ble	r6, r1, ble_then.16877
	fmul	f1, f2, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f1, f1, f2
	fsqrt	f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f2, f2, f1
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16878
	flup	f5, 2		# fli	f5, 1.000000
	j	fle_cont.16879
fle_else.16878:
	flup	f5, 11		# fli	f5, -1.000000
fle_cont.16879:
	fmul	f2, f2, f5
	flup	f6, 23		# fli	f6, 4.375000
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	fsw	f4, 2(r3)
	sw	r1, 4(r3)
	fsw	f1, 6(r3)
	fsw	f3, 8(r3)
	fle	r30, f6, f2
	beq	r0, r30, fle_else.16881
	flup	f6, 24		# fli	f6, 2.437500
	fle	r30, f6, f2
	beq	r0, r30, fle_else.16883
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
	j	fle_cont.16884
fle_else.16883:
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
fle_cont.16884:
	j	fle_cont.16882
fle_else.16881:
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -17
	lw	r31, 16(r3)
fle_cont.16882:
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
	beq	r0, r30, fle_else.16885
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.16886
fle_else.16885:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.16886:
	fmul	f3, f3, f4
	flup	f5, 23		# fli	f5, 4.375000
	fsw	f1, 20(r3)
	sw	r1, 22(r3)
	fsw	f2, 24(r3)
	fle	r30, f5, f3
	beq	r0, r30, fle_else.16888
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f3
	beq	r0, r30, fle_else.16890
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
	j	fle_cont.16891
fle_else.16890:
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
fle_cont.16891:
	j	fle_cont.16889
fle_else.16888:
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	atan_body.2841				#	bl	atan_body.2841
	addi	r3, r3, -33
	lw	r31, 32(r3)
fle_cont.16889:
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
ble_then.16877:
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
	addi	r1, r0, 10766
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
	addi	r6, r0, 0
	ble	r6, r1, ble_then.16893
	jr	r31				#
ble_then.16893:
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
	addi	r5, r0, 5
	ble	r5, r2, ble_then.16895
	j	ble_cont.16896
ble_then.16895:
	addi	r2, r2, -5
ble_cont.16896:
	flw	f1, 0(r3)
	lw	r5, 3(r3)
	j	calc_dirvecs.3305
calc_dirvec_rows.3310:
	addi	r6, r0, 0
	ble	r6, r1, ble_then.16897
	jr	r31				#
ble_then.16897:
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
	addi	r5, r0, 5
	ble	r5, r2, ble_then.16899
	j	ble_cont.16900
ble_then.16899:
	addi	r2, r2, -5
ble_cont.16900:
	lw	r5, 0(r3)
	addi	r5, r5, 4
	addi	r6, r0, 0
	ble	r6, r1, ble_then.16901
	jr	r31				#
ble_then.16901:
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
	addi	r5, r0, 5
	ble	r5, r2, ble_then.16903
	j	ble_cont.16904
ble_then.16903:
	addi	r2, r2, -5
ble_cont.16904:
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16905
	jr	r31				#
ble_then.16905:
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16907
	jr	r31				#
ble_then.16907:
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16909
	jr	r31				#
ble_then.16909:
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16911
	jr	r31				#
ble_then.16911:
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16913
	jr	r31				#
ble_then.16913:
	addi	r2, r0, 10766
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r1, r0, 10766
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16915
	jr	r31				#
ble_then.16915:
	addi	r2, r0, 10766
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r1, r0, 10766
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16917
	jr	r31				#
ble_then.16917:
	add	r30, r1, r2
	lw	r5, 0(r30)
	addi	r6, r0, 10000
	lw	r6, 0(r6)
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
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16919
	jr	r31				#
ble_then.16919:
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 10000
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r1, 2(r3)
	ble	r7, r6, ble_then.16921
	j	ble_cont.16922
ble_then.16921:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 3(r3)
	beqi	1, r10, beq_then.16923
	beqi	2, r10, beq_then.16925
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
	j	beq_cont.16926
beq_then.16925:
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
beq_cont.16926:
	j	beq_cont.16924
beq_then.16923:
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
beq_cont.16924:
	addi	r2, r2, -1
	lw	r1, 3(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -7
	lw	r31, 6(r3)
ble_cont.16922:
	lw	r1, 2(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16927
	jr	r31				#
ble_then.16927:
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 10000
	lw	r6, 0(r6)
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
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16929
	jr	r31				#
ble_then.16929:
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 10000
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r1, 7(r3)
	ble	r7, r6, ble_then.16931
	j	ble_cont.16932
ble_then.16931:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 8(r3)
	beqi	1, r10, beq_then.16933
	beqi	2, r10, beq_then.16935
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
	j	beq_cont.16936
beq_then.16935:
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
beq_cont.16936:
	j	beq_cont.16934
beq_then.16933:
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
beq_cont.16934:
	addi	r2, r2, -1
	lw	r1, 8(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -12
	lw	r31, 11(r3)
ble_cont.16932:
	lw	r1, 7(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	j	init_dirvec_constants.3321
init_vecset_constants.3324:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16937
	jr	r31				#
ble_then.16937:
	addi	r2, r0, 10766
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 119(r2)
	addi	r6, r0, 10000
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	ble	r7, r6, ble_then.16939
	j	ble_cont.16940
ble_then.16939:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 2(r3)
	beqi	1, r10, beq_then.16941
	beqi	2, r10, beq_then.16943
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
	j	beq_cont.16944
beq_then.16943:
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
beq_cont.16944:
	j	beq_cont.16942
beq_then.16941:
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
beq_cont.16942:
	addi	r2, r2, -1
	lw	r1, 2(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -6
	lw	r31, 5(r3)
ble_cont.16940:
	lw	r1, 1(r3)
	lw	r2, 118(r1)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
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
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	addi	r6, r0, 0
	ble	r6, r5, ble_then.16945
	j	ble_cont.16946
ble_then.16945:
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 5(r3)
	beqi	1, r9, beq_then.16947
	beqi	2, r9, beq_then.16949
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
	j	beq_cont.16950
beq_then.16949:
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
beq_cont.16950:
	j	beq_cont.16948
beq_then.16947:
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
beq_cont.16948:
	addi	r2, r2, -1
	lw	r1, 5(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -9
	lw	r31, 8(r3)
ble_cont.16946:
	addi	r2, r0, 116
	lw	r1, 1(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16951
	jr	r31				#
ble_then.16951:
	addi	r2, r0, 10766
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 119(r2)
	addi	r6, r0, 10000
	lw	r6, 0(r6)
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
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	addi	r6, r0, 0
	ble	r6, r5, ble_then.16953
	j	ble_cont.16954
ble_then.16953:
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 10(r3)
	beqi	1, r9, beq_then.16955
	beqi	2, r9, beq_then.16957
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
	j	beq_cont.16958
beq_then.16957:
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
beq_cont.16958:
	j	beq_cont.16956
beq_then.16955:
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
beq_cont.16956:
	addi	r2, r2, -1
	lw	r1, 10(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -14
	lw	r31, 13(r3)
ble_cont.16954:
	addi	r2, r0, 117
	lw	r1, 9(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 8(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16959
	jr	r31				#
ble_then.16959:
	addi	r2, r0, 10766
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 119(r2)
	addi	r6, r0, 10000
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r1, 13(r3)
	sw	r2, 14(r3)
	ble	r7, r6, ble_then.16961
	j	ble_cont.16962
ble_then.16961:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 15(r3)
	beqi	1, r10, beq_then.16963
	beqi	2, r10, beq_then.16965
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
	j	beq_cont.16966
beq_then.16965:
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
beq_cont.16966:
	j	beq_cont.16964
beq_then.16963:
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
beq_cont.16964:
	addi	r2, r2, -1
	lw	r1, 15(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -19
	lw	r31, 18(r3)
ble_cont.16962:
	addi	r2, r0, 118
	lw	r1, 14(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r1, 13(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16967
	jr	r31				#
ble_then.16967:
	addi	r2, r0, 10766
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
	addi	r1, r0, 10766
	addi	r2, r0, 120
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	lw	r1, 1(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 0(r3)
	sw	r1, 4(r2)
	addi	r1, r0, 10766
	lw	r1, 4(r1)
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	sw	r1, 118(r2)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	lw	r2, 3(r3)
	sw	r1, 117(r2)
	addi	r1, r0, 116
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_dirvec_elements.3316				#	bl	create_dirvec_elements.3316
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 3
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_dirvecs.3319				#	bl	create_dirvecs.3319
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	itof	f1, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f1, f1, f2
	addi	r1, r0, 4
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_dirvecs.3305				#	bl	calc_dirvecs.3305
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 8
	addi	r2, r0, 2
	addi	r5, r0, 4
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_dirvec_rows.3310				#	bl	calc_dirvec_rows.3310
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 10766
	lw	r1, 4(r1)
	lw	r2, 119(r1)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	sw	r1, 6(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 118(r1)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	addi	r6, r0, 0
	ble	r6, r5, ble_then.16969
	j	ble_cont.16970
ble_then.16969:
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 7(r3)
	beqi	1, r9, beq_then.16971
	beqi	2, r9, beq_then.16973
	sw	r5, 8(r3)
	sw	r7, 9(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16974
beq_then.16973:
	sw	r5, 8(r3)
	sw	r7, 9(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16974:
	j	beq_cont.16972
beq_then.16971:
	sw	r5, 8(r3)
	sw	r7, 9(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16972:
	addi	r2, r2, -1
	lw	r1, 7(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -11
	lw	r31, 10(r3)
ble_cont.16970:
	addi	r2, r0, 117
	lw	r1, 6(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r1, r0, 10766
	lw	r1, 3(r1)
	lw	r2, 119(r1)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	addi	r6, r0, 0
	sw	r1, 10(r3)
	ble	r6, r5, ble_then.16975
	j	ble_cont.16976
ble_then.16975:
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 11(r3)
	beqi	1, r9, beq_then.16977
	beqi	2, r9, beq_then.16979
	sw	r5, 12(r3)
	sw	r7, 13(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16980
beq_then.16979:
	sw	r5, 12(r3)
	sw	r7, 13(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16980:
	j	beq_cont.16978
beq_then.16977:
	sw	r5, 12(r3)
	sw	r7, 13(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16978:
	addi	r2, r2, -1
	lw	r1, 11(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -15
	lw	r31, 14(r3)
ble_cont.16976:
	addi	r2, r0, 118
	lw	r1, 10(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r1, r0, 10766
	lw	r1, 2(r1)
	addi	r2, r0, 119
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -15
	lw	r31, 14(r3)
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
	addi	r1, r0, 10000
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
	flw	f1, 8(r3)
	fsw	f1, 0(r1)
	flw	f1, 6(r3)
	fsw	f1, 1(r1)
	flw	f1, 4(r3)
	fsw	f1, 2(r1)
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r1, r0, 10778
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
	addi	r5, r0, 11023
	lw	r5, 0(r5)
	flup	f1, 2		# fli	f1, 1.000000
	lw	r2, 7(r2)
	flw	f2, 0(r2)
	fsub	f1, f1, f2
	addi	r2, r0, 10667
	flw	f2, 0(r2)
	fneg	f2, f2
	addi	r2, r0, 10667
	flw	f3, 1(r2)
	fneg	f3, f3
	addi	r2, r0, 10667
	flw	f4, 2(r2)
	fneg	f4, f4
	addi	r2, r1, 1
	addi	r6, r0, 10667
	flw	f5, 0(r6)
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r6, r0, 10000
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r2, 15(r3)
	ble	r7, r6, ble_then.16983
	j	ble_cont.16984
ble_then.16983:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.16985
	beqi	2, r8, beq_then.16987
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
	j	beq_cont.16988
beq_then.16987:
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
beq_cont.16988:
	j	beq_cont.16986
beq_then.16985:
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
beq_cont.16986:
	addi	r2, r2, -1
	lw	r1, 15(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -19
	lw	r31, 18(r3)
ble_cont.16984:
	addi	r1, r0, 10778
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
	addi	r7, r0, 10667
	flw	f2, 1(r7)
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r6, r0, 10000
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r2, 23(r3)
	ble	r7, r6, ble_then.16989
	j	ble_cont.16990
ble_then.16989:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.16991
	beqi	2, r8, beq_then.16993
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
	j	beq_cont.16994
beq_then.16993:
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
beq_cont.16994:
	j	beq_cont.16992
beq_then.16991:
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
beq_cont.16992:
	addi	r2, r2, -1
	lw	r1, 23(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -27
	lw	r31, 26(r3)
ble_cont.16990:
	addi	r1, r0, 10778
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
	addi	r6, r0, 10667
	flw	f2, 2(r6)
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
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
	addi	r6, r0, 10000
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r2, 31(r3)
	ble	r7, r6, ble_then.16995
	j	ble_cont.16996
ble_then.16995:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.16997
	beqi	2, r8, beq_then.16999
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
	j	beq_cont.17000
beq_then.16999:
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
beq_cont.17000:
	j	beq_cont.16998
beq_then.16997:
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
beq_cont.16998:
	addi	r2, r2, -1
	lw	r1, 31(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -35
	lw	r31, 34(r3)
ble_cont.16996:
	addi	r1, r0, 10778
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
	addi	r1, r0, 11023
	lw	r2, 3(r3)
	addi	r2, r2, 3
	sw	r2, 0(r1)
	jr	r31				#
setup_surface_reflection.3338:
	slli	r1, r1, 2
	addi	r1, r1, 1
	addi	r5, r0, 11023
	lw	r5, 0(r5)
	flup	f1, 2		# fli	f1, 1.000000
	lw	r6, 7(r2)
	flw	f2, 0(r6)
	fsub	f1, f1, f2
	addi	r6, r0, 10667
	lw	r7, 4(r2)
	flw	f2, 0(r6)
	flw	f3, 0(r7)
	fmul	f2, f2, f3
	flw	f3, 1(r6)
	flw	f4, 1(r7)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flw	f3, 2(r6)
	flw	f4, 2(r7)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flup	f3, 3		# fli	f3, 2.000000
	lw	r6, 4(r2)
	flw	f4, 0(r6)
	fmul	f3, f3, f4
	fmul	f3, f3, f2
	addi	r6, r0, 10667
	flw	f4, 0(r6)
	fsub	f3, f3, f4
	flup	f4, 3		# fli	f4, 2.000000
	lw	r6, 4(r2)
	flw	f5, 1(r6)
	fmul	f4, f4, f5
	fmul	f4, f4, f2
	addi	r6, r0, 10667
	flw	f5, 1(r6)
	fsub	f4, f4, f5
	flup	f5, 3		# fli	f5, 2.000000
	lw	r2, 4(r2)
	flw	f6, 2(r2)
	fmul	f5, f5, f6
	fmul	f2, f5, f2
	addi	r2, r0, 10667
	flw	f5, 2(r2)
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
	addi	r1, r0, 10000
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
	lw	r5, 10(r3)
	sw	r5, 0(r2)
	flw	f1, 8(r3)
	fsw	f1, 0(r5)
	flw	f1, 6(r3)
	fsw	f1, 1(r5)
	flw	f1, 4(r3)
	fsw	f1, 2(r5)
	addi	r6, r0, 10000
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r2, 11(r3)
	ble	r7, r6, ble_then.17002
	j	ble_cont.17003
ble_then.17002:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.17004
	beqi	2, r8, beq_then.17006
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
	j	beq_cont.17007
beq_then.17006:
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
beq_cont.17007:
	j	beq_cont.17005
beq_then.17004:
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
beq_cont.17005:
	addi	r2, r2, -1
	lw	r1, 11(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -15
	lw	r31, 14(r3)
ble_cont.17003:
	addi	r1, r0, 10778
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
	addi	r1, r0, 11023
	addi	r2, r5, 1
	sw	r2, 0(r1)
	jr	r31				#
setup_reflections.3341:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17009
	jr	r31				#
ble_then.17009:
	addi	r2, r0, 10001
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.17011
	jr	r31				#
beq_then.17011:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 7(r2)
	flw	f2, 0(r5)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17013
	jr	r31				#
fle_else.17013:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.17015
	beqi	2, r5, beq_then.17016
	jr	r31				#
beq_then.17016:
	j	setup_surface_reflection.3338
beq_then.17015:
	j	setup_rect_reflection.3335
rt.3343:
	addi	r5, r0, 10743
	sw	r1, 0(r5)
	addi	r5, r0, 10743
	sw	r2, 1(r5)
	addi	r5, r0, 10745
	srai	r6, r1, 1
	sw	r6, 0(r5)
	addi	r5, r0, 10745
	srai	r2, r2, 1
	sw	r2, 1(r5)
	addi	r2, r0, 10747
	flup	f1, 49		# fli	f1, 128.000000
	itof	f2, r1
	fdiv	f1, f1, f2
	fsw	f1, 0(r2)
	addi	r1, r0, 10743
	lw	r1, 0(r1)
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
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r2, r2, -2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	init_line_elements.3287				#	bl	init_line_elements.3287
	addi	r3, r3, -9
	lw	r31, 8(r3)
	addi	r2, r0, 10743
	lw	r2, 0(r2)
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
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r2, r2, -2
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	init_line_elements.3287				#	bl	init_line_elements.3287
	addi	r3, r3, -18
	lw	r31, 17(r3)
	addi	r2, r0, 10743
	lw	r2, 0(r2)
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
	addi	r2, r0, 10743
	lw	r2, 0(r2)
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
	beqi	0, r1, beq_then.17018
	addi	r1, r0, 1
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_object.2998				#	bl	read_object.2998
	addi	r3, r3, -29
	lw	r31, 28(r3)
	j	beq_cont.17019
beq_then.17018:
	addi	r1, r0, 10000
	lw	r2, 27(r3)
	sw	r2, 0(r1)
beq_cont.17019:
	addi	r1, r0, 0
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_and_network.3006				#	bl	read_and_network.3006
	addi	r3, r3, -29
	lw	r31, 28(r3)
	addi	r1, r0, 10723
	addi	r2, r0, 0
	sw	r1, 28(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	read_or_network.3004				#	bl	read_or_network.3004
	addi	r3, r3, -30
	lw	r31, 29(r3)
	lw	r2, 28(r3)
	sw	r1, 0(r2)
	addi	r1, r0, 80
	out	r1
	addi	r1, r0, 51
	out	r1
	addi	r1, r0, 10
	out	r1
	addi	r1, r0, 10743
	lw	r1, 0(r1)
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -30
	lw	r31, 29(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -30
	lw	r31, 29(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 255
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	print_int.2857				#	bl	print_int.2857
	addi	r3, r3, -30
	lw	r31, 29(r3)
	addi	r1, r0, 10
	out	r1
	addi	r1, r0, 4
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	create_dirvecs.3319				#	bl	create_dirvecs.3319
	addi	r3, r3, -30
	lw	r31, 29(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	calc_dirvec_rows.3310				#	bl	calc_dirvec_rows.3310
	addi	r3, r3, -30
	lw	r31, 29(r3)
	addi	r1, r0, 10766
	lw	r1, 4(r1)
	lw	r2, 119(r1)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	addi	r6, r0, 0
	sw	r1, 29(r3)
	ble	r6, r5, ble_then.17020
	j	ble_cont.17021
ble_then.17020:
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 30(r3)
	beqi	1, r9, beq_then.17022
	beqi	2, r9, beq_then.17024
	sw	r5, 31(r3)
	sw	r7, 32(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_second_table.3100				#	bl	setup_second_table.3100
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r2, 31(r3)
	lw	r5, 32(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17025
beq_then.17024:
	sw	r5, 31(r3)
	sw	r7, 32(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_surface_table.3097				#	bl	setup_surface_table.3097
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r2, 31(r3)
	lw	r5, 32(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17025:
	j	beq_cont.17023
beq_then.17022:
	sw	r5, 31(r3)
	sw	r7, 32(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_rect_table.3094				#	bl	setup_rect_table.3094
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r2, 31(r3)
	lw	r5, 32(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17023:
	addi	r2, r2, -1
	lw	r1, 30(r3)
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -34
	lw	r31, 33(r3)
ble_cont.17021:
	addi	r2, r0, 118
	lw	r1, 29(r3)
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -34
	lw	r31, 33(r3)
	addi	r1, r0, 10766
	lw	r1, 3(r1)
	addi	r2, r0, 119
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	init_dirvec_constants.3321				#	bl	init_dirvec_constants.3321
	addi	r3, r3, -34
	lw	r31, 33(r3)
	addi	r1, r0, 2
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	init_vecset_constants.3324				#	bl	init_vecset_constants.3324
	addi	r3, r3, -34
	lw	r31, 33(r3)
	addi	r1, r0, 11021
	lw	r1, 0(r1)
	addi	r2, r0, 10667
	flw	f1, 0(r2)
	fsw	f1, 0(r1)
	flw	f1, 1(r2)
	fsw	f1, 1(r1)
	flw	f1, 2(r2)
	fsw	f1, 2(r1)
	addi	r1, r0, 11021
	addi	r2, r0, 10000
	lw	r2, 0(r2)
	addi	r2, r2, -1
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	iter_setup_dirvec_constants.3103				#	bl	iter_setup_dirvec_constants.3103
	addi	r3, r3, -34
	lw	r31, 33(r3)
	addi	r1, r0, 10000
	lw	r1, 0(r1)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17026
	j	ble_cont.17027
ble_then.17026:
	addi	r2, r0, 10001
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.17028
	j	beq_cont.17029
beq_then.17028:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 7(r2)
	flw	f2, 0(r5)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17030
	j	fle_cont.17031
fle_else.17030:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.17032
	beqi	2, r5, beq_then.17034
	j	beq_cont.17035
beq_then.17034:
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_surface_reflection.3338				#	bl	setup_surface_reflection.3338
	addi	r3, r3, -34
	lw	r31, 33(r3)
beq_cont.17035:
	j	beq_cont.17033
beq_then.17032:
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_rect_reflection.3335				#	bl	setup_rect_reflection.3335
	addi	r3, r3, -34
	lw	r31, 33(r3)
beq_cont.17033:
fle_cont.17031:
beq_cont.17029:
ble_cont.17027:
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r1, 17(r3)
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	pretrace_line.3267				#	bl	pretrace_line.3267
	addi	r3, r3, -34
	lw	r31, 33(r3)
	addi	r2, r0, 0
	addi	r5, r0, 2
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	blei	0, r1, ble_then.17036
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r2, 33(r3)
	blei	0, r1, ble_then.17037
	addi	r1, r0, 1
	lw	r6, 26(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	pretrace_line.3267				#	bl	pretrace_line.3267
	addi	r3, r3, -35
	lw	r31, 34(r3)
	j	ble_cont.17038
ble_then.17037:
ble_cont.17038:
	addi	r1, r0, 0
	lw	r2, 33(r3)
	lw	r5, 8(r3)
	lw	r6, 17(r3)
	lw	r7, 26(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	scan_pixel.3271				#	bl	scan_pixel.3271
	addi	r3, r3, -35
	lw	r31, 34(r3)
	addi	r1, r0, 1
	addi	r7, r0, 4
	lw	r2, 17(r3)
	lw	r5, 26(r3)
	lw	r6, 8(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	scan_line.3277				#	bl	scan_line.3277
	addi	r3, r3, -35
	lw	r31, 34(r3)
	jr	r31				#
ble_then.17036:
	jr	r31				#
_R_0:
_min_caml_start: # main entry point
  addi  r3, r0, 0
  addi  r4, r0, 10000
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
  addi  r1, r4, 10722
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
