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
	beq	r0, r30, fle_else.15663
	addi	r1, r0, 0
	jr	r31				#
fle_else.15663:
	addi	r1, r0, 1
	jr	r31				#
fisneg.2805:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15664
	addi	r1, r0, 0
	jr	r31				#
fle_else.15664:
	addi	r1, r0, 1
	jr	r31				#
fiszero.2807:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15665
	addi	r1, r0, 1
	jr	r31				#
feq_else.15665:
	addi	r1, r0, 0
	jr	r31				#
xor.2809:
	beq	r1, r2, beq_then.15666
	addi	r1, r0, 1
	jr	r31				#
beq_then.15666:
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
	beq	r0, r30, fle_else.15667
	jr	r31				#
fle_else.15667:
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
	beq	r0, r30, fle_else.15668
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15668:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
	jr	r31				#
hoge.2824:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15669
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15670
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15671
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
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
	j	hoge.2824
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
fle_else.15671:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15670:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15669:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2827:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15685
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15686
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15687
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15688
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2827
fle_else.15688:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2827
fle_else.15687:
	jr	r31				#
fle_else.15686:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15689
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15690
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2827
fle_else.15690:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2827
fle_else.15689:
	jr	r31				#
fle_else.15685:
	jr	r31				#
modulo_2pi.2831:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 0(r3)
	fsw	f1, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15691
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15693
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15695
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15697
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15699
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15701
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15703
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15705
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15707
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15709
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15711
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15713
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15715
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15717
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15719
	addi	r30, r0, 4060
	lui	r30, r30, 18505	# to load float		205887.438848
	fmvfr	f2, r30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	hoge.2824				
	addi	r3, r3, -5
	lw	r31, 4(r3)
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
	j	fle_cont.15700
fle_else.15699:
	fadd	f1, f0, f2
fle_cont.15700:
	j	fle_cont.15698
fle_else.15697:
	fadd	f1, f0, f2
fle_cont.15698:
	j	fle_cont.15696
fle_else.15695:
	fadd	f1, f0, f2
fle_cont.15696:
	j	fle_cont.15694
fle_else.15693:
	fadd	f1, f0, f2
fle_cont.15694:
	j	fle_cont.15692
fle_else.15691:
	fadd	f1, f0, f2
fle_cont.15692:
	flup	f2, 5		# fli	f2, 6.283186
	flw	f3, 2(r3)
	fle	r30, f2, f3
	beq	r0, r30, fle_else.15721
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15722
	fsub	f2, f3, f1
	flup	f3, 3		# fli	f3, 2.000000
	fdiv	f1, f1, f3
	flw	f3, 0(r3)
	fadd	f30, f0, f2
	fadd	f2, f0, f1
	fadd	f1, f0, f30
	j	fuga.2827
fle_else.15722:
	flup	f2, 3		# fli	f2, 2.000000
	fdiv	f2, f1, f2
	flw	f1, 0(r3)
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	j	fuga.2827
fle_else.15721:
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
	beq	r0, r30, fle_else.15723
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.15724
fle_else.15723:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.15724:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 4(r3)
	fsw	f1, 6(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15725
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15727
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15729
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15731
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15733
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15735
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15737
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15739
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15741
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15743
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15745
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15747
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15749
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15751
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2824				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1
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
	j	fle_cont.15734
fle_else.15733:
fle_cont.15734:
	j	fle_cont.15732
fle_else.15731:
fle_cont.15732:
	j	fle_cont.15730
fle_else.15729:
fle_cont.15730:
	j	fle_cont.15728
fle_else.15727:
fle_cont.15728:
	j	fle_cont.15726
fle_else.15725:
fle_cont.15726:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2827				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15753
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15754
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15755
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
fle_else.15755:
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
fle_else.15754:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15756
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
fle_else.15756:
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
fle_else.15753:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15757
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15758
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
fle_else.15758:
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
fle_else.15757:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15759
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
fle_else.15759:
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
	jal	lib_abs_float				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 4(r3)
	fsw	f1, 6(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15760
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15762
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15764
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15766
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15768
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15770
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15772
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15774
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15776
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15778
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15780
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15782
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15784
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15786
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2824				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1
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
	j	fle_cont.15769
fle_else.15768:
fle_cont.15769:
	j	fle_cont.15767
fle_else.15766:
fle_cont.15767:
	j	fle_cont.15765
fle_else.15764:
fle_cont.15765:
	j	fle_cont.15763
fle_else.15762:
fle_cont.15763:
	j	fle_cont.15761
fle_else.15760:
fle_cont.15761:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2827				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15788
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15789
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15790
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
fle_else.15790:
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
fle_else.15789:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15791
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
fle_else.15791:
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
fle_else.15788:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15792
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
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
fle_else.15794:
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
	beq	r0, r30, fle_else.15795
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.15796
fle_else.15795:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.15796:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15797
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15798
	flup	f3, 15		# fli	f3, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
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
fle_else.15798:
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
	jal	atan_body.2841				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.15797:
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
	ble	r7, r1, ble_then.15799
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r7, r5, 3
	slli	r8, r5, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.15800
	j	div10_sub.2849
ble_then.15800:
	slli	r2, r5, 3
	slli	r7, r5, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15801
	add	r2, r0, r5
	add	r5, r0, r6
	j	div10_sub.2849
ble_then.15801:
	add	r1, r0, r5
	jr	r31				#
ble_then.15799:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15802
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r7, r2, 3
	slli	r8, r2, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.15803
	add	r5, r0, r2
	add	r2, r0, r6
	j	div10_sub.2849
ble_then.15803:
	slli	r6, r2, 3
	slli	r7, r2, 1
	add	r6, r6, r7
	addi	r6, r6, 9
	ble	r1, r6, ble_then.15804
	j	div10_sub.2849
ble_then.15804:
	add	r1, r0, r2
	jr	r31				#
ble_then.15802:
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
	bgei	10, r1, bge_then.15805
	addi	r1, r1, 48
	out	r1
	jr	r31				#
bge_then.15805:
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
	bgei	10, r2, bge_then.15806
	addi	r5, r2, 48
	out	r5
	j	bge_cont.15807
bge_then.15806:
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
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2855				
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
bge_cont.15807:
	slli	r1, r2, 3
	slli	r2, r2, 1
	add	r1, r1, r2
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
	jr	r31				#
print_int.2857:
	bgei	0, r1, bge_then.15808
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	j	print_int.2857
bge_then.15808:
	bgei	10, r1, bge_then.15809
	addi	r1, r1, 48
	out	r1
	jr	r31				#
bge_then.15809:
	addi	r2, r0, 100
	ble	r2, r1, ble_then.15810
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
ble_then.15810:
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
	beqi	0, r1, beq_then.15811
	beqi	0, r2, beq_then.15812
	addi	r1, r0, 0
	jr	r31				#
beq_then.15812:
	addi	r1, r0, 1
	jr	r31				#
beq_then.15811:
	add	r1, r0, r2
	jr	r31				#
sgn.2862:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15813
	addi	r1, r0, 1
	j	feq_cont.15814
feq_else.15813:
	addi	r1, r0, 0
feq_cont.15814:
	beqi	0, r1, beq_then.15815
	flup	f1, 0		# fli	f1, 0.000000
	jr	r31				#
beq_then.15815:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15816
	addi	r1, r0, 0
	j	fle_cont.15817
fle_else.15816:
	addi	r1, r0, 1
fle_cont.15817:
	beqi	0, r1, beq_then.15818
	flup	f1, 2		# fli	f1, 1.000000
	jr	r31				#
beq_then.15818:
	flup	f1, 11		# fli	f1, -1.000000
	jr	r31				#
fneg_cond.2864:
	beqi	0, r1, beq_then.15819
	jr	r31				#
beq_then.15819:
	fneg	f1, f1
	jr	r31				#
add_mod5.2867:
	add	r1, r1, r2
	bgei	5, r1, bge_then.15820
	jr	r31				#
bge_then.15820:
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
	fsw	f0, 0(r1)
	fsw	f0, 1(r1)
	fsw	f0, 2(r1)
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
	beq	r0, r30, feq_else.15826
	addi	r5, r0, 1
	j	feq_cont.15827
feq_else.15826:
	addi	r5, r0, 0
feq_cont.15827:
	beqi	0, r5, beq_then.15828
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.15829
beq_then.15828:
	beqi	0, r2, beq_then.15830
	flup	f2, 11		# fli	f2, -1.000000
	fdiv	f1, f2, f1
	j	beq_cont.15831
beq_then.15830:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
beq_cont.15831:
beq_cont.15829:
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
	jal	lib_read_float				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	fsw	f1, 661(r0)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_read_float				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	fsw	f1, 662(r0)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_read_float				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	fsw	f1, 663(r0)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_read_float				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	cos.2839				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f2, 0(r3)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2837				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fsw	f1, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	fsw	f1, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos.2839				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin.2837				
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
	fsw	f0, 755(r0)
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
	jal	lib_read_int				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_read_float				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
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
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
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
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	cos.2839				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2837				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2839				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2837				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos.2839				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 10(r3)
	fadd	f1, f0, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2837				
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
	jal	lib_read_int				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.15842
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_int				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 4(r3)
	add	r1, r0, r2
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_float_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	fsw	f1, 0(r1)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	fsw	f1, 1(r1)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	fsw	f1, 2(r1)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	fsw	f1, 0(r1)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	fsw	f1, 1(r1)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	fsw	f1, 2(r1)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15843
	addi	r1, r0, 0
	j	fle_cont.15844
fle_else.15843:
	addi	r1, r0, 1
fle_cont.15844:
	addi	r2, r0, 2
	flup	f1, 0		# fli	f1, 0.000000
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
	lw	r1, 8(r3)
	fsw	f1, 0(r1)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_read_float				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 8(r3)
	fsw	f1, 1(r1)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r2
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_float_array				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	sw	r1, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 9(r3)
	fsw	f1, 0(r1)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 9(r3)
	fsw	f1, 1(r1)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 9(r3)
	fsw	f1, 2(r1)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 4(r3)
	beqi	0, r2, beq_then.15845
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	lw	r1, 10(r3)
	fsw	f1, 0(r1)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	lw	r1, 10(r3)
	fsw	f1, 1(r1)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	lw	r1, 10(r3)
	fsw	f1, 2(r1)
	j	beq_cont.15846
beq_then.15845:
beq_cont.15846:
	lw	r2, 2(r3)
	beqi	2, r2, beq_then.15847
	lw	r5, 7(r3)
	j	beq_cont.15848
beq_then.15847:
	addi	r5, r0, 1
beq_cont.15848:
	addi	r6, r0, 4
	flup	f1, 0		# fli	f1, 0.000000
	sw	r5, 11(r3)
	sw	r1, 10(r3)
	add	r1, r0, r6
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_float_array				
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
	beqi	3, r7, beq_then.15849
	beqi	2, r7, beq_then.15851
	j	beq_cont.15852
beq_then.15851:
	lw	r2, 7(r3)
	beqi	0, r2, beq_then.15853
	addi	r2, r0, 0
	j	beq_cont.15854
beq_then.15853:
	addi	r2, r0, 1
beq_cont.15854:
	add	r1, r0, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	vecunit_sgn.2888				
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.15852:
	j	beq_cont.15850
beq_then.15849:
	flw	f1, 0(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15855
	addi	r2, r0, 1
	j	feq_cont.15856
feq_else.15855:
	addi	r2, r0, 0
feq_cont.15856:
	beqi	0, r2, beq_then.15857
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.15858
beq_then.15857:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15859
	addi	r2, r0, 1
	j	feq_cont.15860
feq_else.15859:
	addi	r2, r0, 0
feq_cont.15860:
	beqi	0, r2, beq_then.15861
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.15862
beq_then.15861:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15863
	addi	r2, r0, 0
	j	fle_cont.15864
fle_else.15863:
	addi	r2, r0, 1
fle_cont.15864:
	beqi	0, r2, beq_then.15865
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.15866
beq_then.15865:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.15866:
beq_cont.15862:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.15858:
	fsw	f1, 0(r5)
	flw	f1, 1(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15867
	addi	r2, r0, 1
	j	feq_cont.15868
feq_else.15867:
	addi	r2, r0, 0
feq_cont.15868:
	beqi	0, r2, beq_then.15869
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.15870
beq_then.15869:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15871
	addi	r2, r0, 1
	j	feq_cont.15872
feq_else.15871:
	addi	r2, r0, 0
feq_cont.15872:
	beqi	0, r2, beq_then.15873
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.15874
beq_then.15873:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15875
	addi	r2, r0, 0
	j	fle_cont.15876
fle_else.15875:
	addi	r2, r0, 1
fle_cont.15876:
	beqi	0, r2, beq_then.15877
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.15878
beq_then.15877:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.15878:
beq_cont.15874:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.15870:
	fsw	f1, 1(r5)
	flw	f1, 2(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15879
	addi	r2, r0, 1
	j	feq_cont.15880
feq_else.15879:
	addi	r2, r0, 0
feq_cont.15880:
	beqi	0, r2, beq_then.15881
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.15882
beq_then.15881:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15883
	addi	r2, r0, 1
	j	feq_cont.15884
feq_else.15883:
	addi	r2, r0, 0
feq_cont.15884:
	beqi	0, r2, beq_then.15885
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.15886
beq_then.15885:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15887
	addi	r2, r0, 0
	j	fle_cont.15888
fle_else.15887:
	addi	r2, r0, 1
fle_cont.15888:
	beqi	0, r2, beq_then.15889
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.15890
beq_then.15889:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.15890:
beq_cont.15886:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.15882:
	fsw	f1, 2(r5)
beq_cont.15850:
	lw	r1, 4(r3)
	beqi	0, r1, beq_then.15891
	lw	r1, 5(r3)
	lw	r2, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	rotate_quadratic_matrix.2993				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.15892
beq_then.15891:
beq_cont.15892:
	addi	r1, r0, 1
	jr	r31				#
beq_then.15842:
	addi	r1, r0, 0
	jr	r31				#
read_object.2998:
	addi	r2, r0, 60
	ble	r2, r1, ble_then.15893
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.15894
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.15895
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.15896
	lw	r1, 1(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.15897
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_nth_object.2996				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.15898
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.15899
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_nth_object.2996				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.15900
	lw	r1, 3(r3)
	addi	r1, r1, 1
	j	read_object.2998
beq_then.15900:
	lw	r1, 3(r3)
	sw	r1, 0(r0)
	jr	r31				#
ble_then.15899:
	jr	r31				#
beq_then.15898:
	lw	r1, 2(r3)
	sw	r1, 0(r0)
	jr	r31				#
ble_then.15897:
	jr	r31				#
beq_then.15896:
	lw	r1, 1(r3)
	sw	r1, 0(r0)
	jr	r31				#
ble_then.15895:
	jr	r31				#
beq_then.15894:
	lw	r1, 0(r3)
	sw	r1, 0(r0)
	jr	r31				#
ble_then.15893:
	jr	r31				#
read_all_object.3000:
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_nth_object.2996				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	beqi	0, r1, beq_then.15909
	addi	r1, r0, 1
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.15910
	addi	r1, r0, 2
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.15911
	addi	r1, r0, 3
	j	read_object.2998
beq_then.15911:
	lw	r1, 1(r3)
	sw	r1, 0(r0)
	jr	r31				#
beq_then.15910:
	lw	r1, 0(r3)
	sw	r1, 0(r0)
	jr	r31				#
beq_then.15909:
	sw	r0, 0(r0)
	jr	r31				#
read_net_item.3002:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.15915
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.15916
	lw	r2, 2(r3)
	addi	r5, r2, 1
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.15918
	lw	r2, 4(r3)
	addi	r5, r2, 1
	sw	r1, 5(r3)
	sw	r5, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.15920
	lw	r2, 6(r3)
	addi	r5, r2, 1
	sw	r1, 7(r3)
	add	r1, r0, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.3002				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.15921
beq_then.15920:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.15921:
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.15919
beq_then.15918:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.15919:
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.15917
beq_then.15916:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.15917:
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.15915:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	j	lib_create_array
read_or_network.3004:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.15922
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.15924
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.15926
	addi	r2, r0, 3
	sw	r1, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3002				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 2(r1)
	j	beq_cont.15927
beq_then.15926:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15927:
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.15925
beq_then.15924:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15925:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.15923
beq_then.15922:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
beq_cont.15923:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.15928
	lw	r1, 0(r3)
	addi	r5, r1, 1
	sw	r2, 4(r3)
	sw	r5, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.15929
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.15931
	addi	r2, r0, 2
	sw	r1, 7(r3)
	add	r1, r0, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.3002				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 7(r3)
	sw	r2, 1(r1)
	j	beq_cont.15932
beq_then.15931:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.15932:
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.15930
beq_then.15929:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1
beq_cont.15930:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.15933
	lw	r1, 5(r3)
	addi	r5, r1, 1
	sw	r2, 8(r3)
	add	r1, r0, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	read_or_network.3004				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 5(r3)
	lw	r5, 8(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.15934
beq_then.15933:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.15934:
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.15928:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.3006:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.15935
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.15937
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.15939
	addi	r2, r0, 3
	sw	r1, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3002				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 2(r1)
	j	beq_cont.15940
beq_then.15939:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15940:
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.15938
beq_then.15937:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15938:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	j	beq_cont.15936
beq_then.15935:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.15936:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.15941
	addi	r2, r0, 672				# set min_caml_and_net
	lw	r5, 0(r3)
	add	r30, r2, r5
	sw	r1, 0(r30)
	addi	r1, r5, 1
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.15942
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.15944
	addi	r2, r0, 2
	sw	r1, 6(r3)
	add	r1, r0, r2
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	read_net_item.3002				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	sw	r2, 1(r1)
	j	beq_cont.15945
beq_then.15944:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.15945:
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	j	beq_cont.15943
beq_then.15942:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.15943:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.15946
	addi	r2, r0, 672				# set min_caml_and_net
	lw	r5, 4(r3)
	add	r30, r2, r5
	sw	r1, 0(r30)
	addi	r1, r5, 1
	j	read_and_network.3006
beq_then.15946:
	jr	r31				#
beq_then.15941:
	jr	r31				#
read_parameter.3008:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_screen_settings.2989				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_light.2991				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_nth_object.2996				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	beqi	0, r1, beq_then.15949
	addi	r1, r0, 1
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.15951
	addi	r1, r0, 2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_object.2998				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	j	beq_cont.15952
beq_then.15951:
	lw	r1, 0(r3)
	sw	r1, 0(r0)
beq_cont.15952:
	j	beq_cont.15950
beq_then.15949:
	sw	r0, 0(r0)
beq_cont.15950:
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.15953
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.15955
	addi	r2, r0, 2
	sw	r1, 2(r3)
	add	r1, r0, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_net_item.3002				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.15956
beq_then.15955:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.15956:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	j	beq_cont.15954
beq_then.15953:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.15954:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.15957
	sw	r1, 672(r0)
	addi	r1, r0, 1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_and_network.3006				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.15958
beq_then.15957:
beq_cont.15958:
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.15959
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_int				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	-1, r1, beq_then.15961
	addi	r2, r0, 2
	sw	r1, 4(r3)
	add	r1, r0, r2
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	read_net_item.3002				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 4(r3)
	sw	r2, 1(r1)
	j	beq_cont.15962
beq_then.15961:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.15962:
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.15960
beq_then.15959:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
beq_cont.15960:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.15963
	addi	r1, r0, 1
	sw	r2, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	read_or_network.3004				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	j	beq_cont.15964
beq_then.15963:
	addi	r1, r0, 1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.15964:
	sw	r1, 723(r0)
	jr	r31				#
solver_rect_surface.3010:
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.15966
	addi	r8, r0, 1
	j	feq_cont.15967
feq_else.15966:
	addi	r8, r0, 0
feq_cont.15967:
	beqi	0, r8, beq_then.15968
	addi	r1, r0, 0
	jr	r31				#
beq_then.15968:
	lw	r8, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.15969
	addi	r9, r0, 0
	j	fle_cont.15970
fle_else.15969:
	addi	r9, r0, 1
fle_cont.15970:
	beqi	0, r1, beq_then.15971
	beqi	0, r9, beq_then.15973
	addi	r1, r0, 0
	j	beq_cont.15974
beq_then.15973:
	addi	r1, r0, 1
beq_cont.15974:
	j	beq_cont.15972
beq_then.15971:
	add	r1, r0, r9
beq_cont.15972:
	add	r30, r8, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.15975
	j	beq_cont.15976
beq_then.15975:
	fneg	f4, f4
beq_cont.15976:
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
	beq	r0, r30, fle_else.15977
	j	fle_cont.15978
fle_else.15977:
	fneg	f2, f2
fle_cont.15978:
	fle	r30, f4, f2
	beq	r0, r30, fle_else.15979
	addi	r1, r0, 0
	jr	r31				#
fle_else.15979:
	add	r30, r8, r7
	flw	f2, 0(r30)
	add	r30, r2, r7
	flw	f4, 0(r30)
	fmul	f4, f1, f4
	fadd	f3, f4, f3
	fle	r30, f0, f3
	beq	r0, r30, fle_else.15980
	j	fle_cont.15981
fle_else.15980:
	fneg	f3, f3
fle_cont.15981:
	fle	r30, f2, f3
	beq	r0, r30, fle_else.15982
	addi	r1, r0, 0
	jr	r31				#
fle_else.15982:
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
	beqi	0, r1, beq_then.15983
	addi	r1, r0, 1
	jr	r31				#
beq_then.15983:
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
	beqi	0, r1, beq_then.15984
	addi	r1, r0, 2
	jr	r31				#
beq_then.15984:
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
	beqi	0, r1, beq_then.15985
	addi	r1, r0, 3
	jr	r31				#
beq_then.15985:
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
	beq	r0, r30, fle_else.15986
	addi	r2, r0, 0
	j	fle_cont.15987
fle_else.15986:
	addi	r2, r0, 1
fle_cont.15987:
	beqi	0, r2, beq_then.15988
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
beq_then.15988:
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
	beqi	0, r2, beq_then.15989
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
beq_then.15989:
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
	beqi	0, r2, beq_then.15990
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
beq_then.15990:
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
	fadd	f3, f0, f6
	fadd	f2, f0, f5
	fadd	f1, f0, f4
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	quadratic.3031				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15991
	addi	r1, r0, 1
	j	feq_cont.15992
feq_else.15991:
	addi	r1, r0, 0
feq_cont.15992:
	beqi	0, r1, beq_then.15993
	addi	r1, r0, 0
	jr	r31				#
beq_then.15993:
	lw	r1, 7(r3)
	flw	f2, 0(r1)
	flw	f3, 1(r1)
	flw	f4, 2(r1)
	flw	f5, 4(r3)
	flw	f6, 2(r3)
	flw	f7, 0(r3)
	lw	r1, 6(r3)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2
	fadd	f2, f0, f3
	fadd	f3, f0, f4
	fadd	f4, f0, f5
	fadd	f5, f0, f6
	fadd	f6, f0, f7
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
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.15994
	j	beq_cont.15995
beq_then.15994:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.15995:
	flw	f2, 10(r3)
	fmul	f3, f2, f2
	flw	f4, 8(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15996
	addi	r2, r0, 0
	j	fle_cont.15997
fle_else.15996:
	addi	r2, r0, 1
fle_cont.15997:
	beqi	0, r2, beq_then.15998
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.15999
	j	beq_cont.16000
beq_then.15999:
	fneg	f1, f1
beq_cont.16000:
	fsub	f1, f1, f2
	fdiv	f1, f1, f4
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.15998:
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
	beqi	1, r5, beq_then.16001
	beqi	2, r5, beq_then.16002
	j	solver_second.3044
beq_then.16002:
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
	beq	r0, r30, fle_else.16003
	addi	r2, r0, 0
	j	fle_cont.16004
fle_else.16003:
	addi	r2, r0, 1
fle_cont.16004:
	beqi	0, r2, beq_then.16005
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
beq_then.16005:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16001:
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
	beqi	0, r1, beq_then.16006
	addi	r1, r0, 1
	jr	r31				#
beq_then.16006:
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
	beqi	0, r1, beq_then.16007
	addi	r1, r0, 2
	jr	r31				#
beq_then.16007:
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
	beqi	0, r1, beq_then.16008
	addi	r1, r0, 3
	jr	r31				#
beq_then.16008:
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
	beq	r0, r30, fle_else.16009
	j	fle_cont.16010
fle_else.16009:
	fneg	f6, f6
fle_cont.16010:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16011
	addi	r6, r0, 0
	j	fle_cont.16012
fle_else.16011:
	lw	r6, 4(r1)
	flw	f5, 2(r6)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.16013
	j	fle_cont.16014
fle_else.16013:
	fneg	f6, f6
fle_cont.16014:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16015
	addi	r6, r0, 0
	j	fle_cont.16016
fle_else.16015:
	flw	f5, 1(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16017
	addi	r6, r0, 1
	j	feq_cont.16018
feq_else.16017:
	addi	r6, r0, 0
feq_cont.16018:
	beqi	0, r6, beq_then.16019
	addi	r6, r0, 0
	j	beq_cont.16020
beq_then.16019:
	addi	r6, r0, 1
beq_cont.16020:
fle_cont.16016:
fle_cont.16012:
	beqi	0, r6, beq_then.16021
	fsw	f4, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16021:
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
	beq	r0, r30, fle_else.16022
	j	fle_cont.16023
fle_else.16022:
	fneg	f6, f6
fle_cont.16023:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16024
	addi	r6, r0, 0
	j	fle_cont.16025
fle_else.16024:
	lw	r6, 4(r1)
	flw	f5, 2(r6)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.16026
	j	fle_cont.16027
fle_else.16026:
	fneg	f6, f6
fle_cont.16027:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16028
	addi	r6, r0, 0
	j	fle_cont.16029
fle_else.16028:
	flw	f5, 3(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16030
	addi	r6, r0, 1
	j	feq_cont.16031
feq_else.16030:
	addi	r6, r0, 0
feq_cont.16031:
	beqi	0, r6, beq_then.16032
	addi	r6, r0, 0
	j	beq_cont.16033
beq_then.16032:
	addi	r6, r0, 1
beq_cont.16033:
fle_cont.16029:
fle_cont.16025:
	beqi	0, r6, beq_then.16034
	fsw	f4, 724(r0)
	addi	r1, r0, 2
	jr	r31				#
beq_then.16034:
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
	beq	r0, r30, fle_else.16035
	j	fle_cont.16036
fle_else.16035:
	fneg	f1, f1
fle_cont.16036:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16037
	addi	r1, r0, 0
	j	fle_cont.16038
fle_else.16037:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	flw	f4, 1(r2)
	fmul	f4, f3, f4
	fadd	f2, f4, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16039
	j	fle_cont.16040
fle_else.16039:
	fneg	f2, f2
fle_cont.16040:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16041
	addi	r1, r0, 0
	j	fle_cont.16042
fle_else.16041:
	flw	f1, 5(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16043
	addi	r1, r0, 1
	j	feq_cont.16044
feq_else.16043:
	addi	r1, r0, 0
feq_cont.16044:
	beqi	0, r1, beq_then.16045
	addi	r1, r0, 0
	j	beq_cont.16046
beq_then.16045:
	addi	r1, r0, 1
beq_cont.16046:
fle_cont.16042:
fle_cont.16038:
	beqi	0, r1, beq_then.16047
	fsw	f3, 724(r0)
	addi	r1, r0, 3
	jr	r31				#
beq_then.16047:
	addi	r1, r0, 0
	jr	r31				#
solver_surface_fast.3061:
	flw	f4, 0(r2)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16048
	addi	r1, r0, 0
	j	fle_cont.16049
fle_else.16048:
	addi	r1, r0, 1
fle_cont.16049:
	beqi	0, r1, beq_then.16050
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
beq_then.16050:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3067:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16051
	addi	r5, r0, 1
	j	feq_cont.16052
feq_else.16051:
	addi	r5, r0, 0
feq_cont.16052:
	beqi	0, r5, beq_then.16053
	addi	r1, r0, 0
	jr	r31				#
beq_then.16053:
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
	jal	quadratic.3031				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16055
	j	beq_cont.16056
beq_then.16055:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16056:
	flw	f2, 4(r3)
	fmul	f3, f2, f2
	flw	f4, 2(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16057
	addi	r2, r0, 0
	j	fle_cont.16058
fle_else.16057:
	addi	r2, r0, 1
fle_cont.16058:
	beqi	0, r2, beq_then.16059
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16060
	fsqrt	f1, f1
	fadd	f1, f2, f1
	lw	r1, 0(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	j	beq_cont.16061
beq_then.16060:
	fsqrt	f1, f1
	fsub	f1, f2, f1
	lw	r1, 0(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
beq_cont.16061:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16059:
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
	beqi	1, r1, beq_then.16062
	beqi	2, r1, beq_then.16063
	add	r2, r0, r5
	add	r1, r0, r6
	j	solver_second_fast.3067
beq_then.16063:
	flw	f4, 0(r5)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16064
	addi	r1, r0, 0
	j	fle_cont.16065
fle_else.16064:
	addi	r1, r0, 1
fle_cont.16065:
	beqi	0, r1, beq_then.16066
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
beq_then.16066:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16062:
	lw	r2, 0(r2)
	add	r1, r0, r6
	j	solver_rect_fast.3054
solver_surface_fast2.3077:
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16067
	addi	r1, r0, 0
	j	fle_cont.16068
fle_else.16067:
	addi	r1, r0, 1
fle_cont.16068:
	beqi	0, r1, beq_then.16069
	flw	f1, 0(r2)
	flw	f2, 3(r5)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16069:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3084:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16070
	addi	r6, r0, 1
	j	feq_cont.16071
feq_else.16070:
	addi	r6, r0, 0
feq_cont.16071:
	beqi	0, r6, beq_then.16072
	addi	r1, r0, 0
	jr	r31				#
beq_then.16072:
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
	beq	r0, r30, fle_else.16073
	addi	r5, r0, 0
	j	fle_cont.16074
fle_else.16073:
	addi	r5, r0, 1
fle_cont.16074:
	beqi	0, r5, beq_then.16075
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16076
	fsqrt	f2, f2
	fadd	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	j	beq_cont.16077
beq_then.16076:
	fsqrt	f2, f2
	fsub	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
beq_cont.16077:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16075:
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
	beqi	1, r7, beq_then.16078
	beqi	2, r7, beq_then.16079
	add	r2, r0, r1
	add	r1, r0, r5
	add	r5, r0, r6
	j	solver_second_fast2.3084
beq_then.16079:
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16080
	addi	r2, r0, 0
	j	fle_cont.16081
fle_else.16080:
	addi	r2, r0, 1
fle_cont.16081:
	beqi	0, r2, beq_then.16082
	flw	f1, 0(r1)
	flw	f2, 3(r6)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16082:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16078:
	lw	r2, 0(r2)
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r28
	j	solver_rect_fast.3054
setup_rect_table.3094:
	addi	r5, r0, 6
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	flw	f1, 0(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16083
	addi	r5, r0, 1
	j	feq_cont.16084
feq_else.16083:
	addi	r5, r0, 0
feq_cont.16084:
	beqi	0, r5, beq_then.16085
	fsw	f0, 1(r1)
	j	beq_cont.16086
beq_then.16085:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16087
	addi	r7, r0, 0
	j	fle_cont.16088
fle_else.16087:
	addi	r7, r0, 1
fle_cont.16088:
	beqi	0, r6, beq_then.16089
	beqi	0, r7, beq_then.16091
	addi	r6, r0, 0
	j	beq_cont.16092
beq_then.16091:
	addi	r6, r0, 1
beq_cont.16092:
	j	beq_cont.16090
beq_then.16089:
	add	r6, r0, r7
beq_cont.16090:
	lw	r7, 4(r5)
	flw	f1, 0(r7)
	beqi	0, r6, beq_then.16093
	j	beq_cont.16094
beq_then.16093:
	fneg	f1, f1
beq_cont.16094:
	fsw	f1, 0(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r2)
	fdiv	f1, f1, f2
	fsw	f1, 1(r1)
beq_cont.16086:
	flw	f1, 1(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16095
	addi	r5, r0, 1
	j	feq_cont.16096
feq_else.16095:
	addi	r5, r0, 0
feq_cont.16096:
	beqi	0, r5, beq_then.16097
	fsw	f0, 3(r1)
	j	beq_cont.16098
beq_then.16097:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 1(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16099
	addi	r7, r0, 0
	j	fle_cont.16100
fle_else.16099:
	addi	r7, r0, 1
fle_cont.16100:
	beqi	0, r6, beq_then.16101
	beqi	0, r7, beq_then.16103
	addi	r6, r0, 0
	j	beq_cont.16104
beq_then.16103:
	addi	r6, r0, 1
beq_cont.16104:
	j	beq_cont.16102
beq_then.16101:
	add	r6, r0, r7
beq_cont.16102:
	lw	r7, 4(r5)
	flw	f1, 1(r7)
	beqi	0, r6, beq_then.16105
	j	beq_cont.16106
beq_then.16105:
	fneg	f1, f1
beq_cont.16106:
	fsw	f1, 2(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 1(r2)
	fdiv	f1, f1, f2
	fsw	f1, 3(r1)
beq_cont.16098:
	flw	f1, 2(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16107
	addi	r5, r0, 1
	j	feq_cont.16108
feq_else.16107:
	addi	r5, r0, 0
feq_cont.16108:
	beqi	0, r5, beq_then.16109
	fsw	f0, 5(r1)
	j	beq_cont.16110
beq_then.16109:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 2(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16111
	addi	r7, r0, 0
	j	fle_cont.16112
fle_else.16111:
	addi	r7, r0, 1
fle_cont.16112:
	beqi	0, r6, beq_then.16113
	beqi	0, r7, beq_then.16115
	addi	r6, r0, 0
	j	beq_cont.16116
beq_then.16115:
	addi	r6, r0, 1
beq_cont.16116:
	j	beq_cont.16114
beq_then.16113:
	add	r6, r0, r7
beq_cont.16114:
	lw	r5, 4(r5)
	flw	f1, 2(r5)
	beqi	0, r6, beq_then.16117
	j	beq_cont.16118
beq_then.16117:
	fneg	f1, f1
beq_cont.16118:
	fsw	f1, 4(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 2(r2)
	fdiv	f1, f1, f2
	fsw	f1, 5(r1)
beq_cont.16110:
	jr	r31				#
setup_surface_table.3097:
	addi	r5, r0, 4
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				
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
	beq	r0, r30, fle_else.16119
	addi	r2, r0, 0
	j	fle_cont.16120
fle_else.16119:
	addi	r2, r0, 1
fle_cont.16120:
	beqi	0, r2, beq_then.16121
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
	j	beq_cont.16122
beq_then.16121:
	fsw	f0, 0(r1)
beq_cont.16122:
	jr	r31				#
setup_second_table.3100:
	addi	r5, r0, 5
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	flw	f1, 0(r2)
	flw	f2, 1(r2)
	flw	f3, 2(r2)
	lw	r5, 0(r3)
	sw	r1, 2(r3)
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	quadratic.3031				
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
	beqi	0, r6, beq_then.16123
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
	j	beq_cont.16124
beq_then.16123:
	fsw	f2, 1(r5)
	fsw	f3, 2(r5)
	fsw	f4, 3(r5)
beq_cont.16124:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16125
	addi	r1, r0, 1
	j	feq_cont.16126
feq_else.16125:
	addi	r1, r0, 0
feq_cont.16126:
	beqi	0, r1, beq_then.16127
	j	beq_cont.16128
beq_then.16127:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
	fsw	f1, 4(r5)
beq_cont.16128:
	add	r1, r0, r5
	jr	r31				#
iter_setup_dirvec_constants.3103:
	bgei	0, r2, bge_then.16129
	jr	r31				#
bge_then.16129:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 1(r1)
	lw	r7, 0(r1)
	lw	r8, 1(r5)
	sw	r1, 0(r3)
	beqi	1, r8, beq_then.16131
	beqi	2, r8, beq_then.16133
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_second_table.3100				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16134
beq_then.16133:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_surface_table.3097				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16134:
	j	beq_cont.16132
beq_then.16131:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_rect_table.3094				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16132:
	addi	r1, r2, -1
	bgei	0, r1, bge_then.16135
	jr	r31				#
bge_then.16135:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 0(r3)
	lw	r6, 1(r5)
	lw	r7, 0(r5)
	lw	r8, 1(r2)
	beqi	1, r8, beq_then.16137
	beqi	2, r8, beq_then.16139
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3100				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16140
beq_then.16139:
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3097				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16140:
	j	beq_cont.16138
beq_then.16137:
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3094				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16138:
	addi	r2, r2, -1
	lw	r1, 0(r3)
	j	iter_setup_dirvec_constants.3103
setup_dirvec_constants.3106:
	lw	r2, 0(r0)
	addi	r2, r2, -1
	bgei	0, r2, bge_then.16141
	jr	r31				#
bge_then.16141:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 1(r1)
	lw	r7, 0(r1)
	lw	r8, 1(r5)
	sw	r1, 0(r3)
	beqi	1, r8, beq_then.16143
	beqi	2, r8, beq_then.16145
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_second_table.3100				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16146
beq_then.16145:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_surface_table.3097				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16146:
	j	beq_cont.16144
beq_then.16143:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_rect_table.3094				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16144:
	addi	r2, r2, -1
	lw	r1, 0(r3)
	j	iter_setup_dirvec_constants.3103
setup_startp_constants.3108:
	bgei	0, r2, bge_then.16147
	jr	r31				#
bge_then.16147:
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
	beqi	2, r7, beq_then.16149
	blei	2, r7, ble_then.16151
	flw	f1, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 2(r6)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	quadratic.3031				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	beqi	3, r1, beq_then.16153
	j	beq_cont.16154
beq_then.16153:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16154:
	lw	r1, 2(r3)
	fsw	f1, 3(r1)
	j	ble_cont.16152
ble_then.16151:
ble_cont.16152:
	j	beq_cont.16150
beq_then.16149:
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
beq_cont.16150:
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
	beq	r0, r30, fle_else.16155
	j	fle_cont.16156
fle_else.16155:
	fneg	f1, f1
fle_cont.16156:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16157
	addi	r2, r0, 0
	j	fle_cont.16158
fle_else.16157:
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16159
	j	fle_cont.16160
fle_else.16159:
	fneg	f2, f2
fle_cont.16160:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16161
	addi	r2, r0, 0
	j	fle_cont.16162
fle_else.16161:
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16163
	fadd	f2, f0, f3
	j	fle_cont.16164
fle_else.16163:
	fneg	f2, f3
fle_cont.16164:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16165
	addi	r2, r0, 0
	j	fle_cont.16166
fle_else.16165:
	addi	r2, r0, 1
fle_cont.16166:
fle_cont.16162:
fle_cont.16158:
	beqi	0, r2, beq_then.16167
	lw	r1, 6(r1)
	jr	r31				#
beq_then.16167:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16168
	addi	r1, r0, 0
	jr	r31				#
beq_then.16168:
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
	beq	r0, r30, fle_else.16169
	addi	r2, r0, 0
	j	fle_cont.16170
fle_else.16169:
	addi	r2, r0, 1
fle_cont.16170:
	beqi	0, r1, beq_then.16171
	beqi	0, r2, beq_then.16173
	addi	r1, r0, 0
	j	beq_cont.16174
beq_then.16173:
	addi	r1, r0, 1
beq_cont.16174:
	j	beq_cont.16172
beq_then.16171:
	add	r1, r0, r2
beq_cont.16172:
	beqi	0, r1, beq_then.16175
	addi	r1, r0, 0
	jr	r31				#
beq_then.16175:
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
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16176
	j	beq_cont.16177
beq_then.16176:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16177:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16178
	addi	r2, r0, 0
	j	fle_cont.16179
fle_else.16178:
	addi	r2, r0, 1
fle_cont.16179:
	beqi	0, r1, beq_then.16180
	beqi	0, r2, beq_then.16182
	addi	r1, r0, 0
	j	beq_cont.16183
beq_then.16182:
	addi	r1, r0, 1
beq_cont.16183:
	j	beq_cont.16181
beq_then.16180:
	add	r1, r0, r2
beq_cont.16181:
	beqi	0, r1, beq_then.16184
	addi	r1, r0, 0
	jr	r31				#
beq_then.16184:
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
	beqi	1, r2, beq_then.16185
	beqi	2, r2, beq_then.16186
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3031				
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
beq_then.16186:
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
	beq	r0, r30, fle_else.16196
	addi	r2, r0, 0
	j	fle_cont.16197
fle_else.16196:
	addi	r2, r0, 1
fle_cont.16197:
	beqi	0, r1, beq_then.16198
	beqi	0, r2, beq_then.16200
	addi	r1, r0, 0
	j	beq_cont.16201
beq_then.16200:
	addi	r1, r0, 1
beq_cont.16201:
	j	beq_cont.16199
beq_then.16198:
	add	r1, r0, r2
beq_cont.16199:
	beqi	0, r1, beq_then.16202
	addi	r1, r0, 0
	jr	r31				#
beq_then.16202:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16185:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16203
	j	fle_cont.16204
fle_else.16203:
	fneg	f1, f1
fle_cont.16204:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16205
	addi	r2, r0, 0
	j	fle_cont.16206
fle_else.16205:
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16207
	j	fle_cont.16208
fle_else.16207:
	fneg	f2, f2
fle_cont.16208:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16209
	addi	r2, r0, 0
	j	fle_cont.16210
fle_else.16209:
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16211
	fadd	f2, f0, f3
	j	fle_cont.16212
fle_else.16211:
	fneg	f2, f3
fle_cont.16212:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16213
	addi	r2, r0, 0
	j	fle_cont.16214
fle_else.16213:
	addi	r2, r0, 1
fle_cont.16214:
fle_cont.16210:
fle_cont.16206:
	beqi	0, r2, beq_then.16215
	lw	r1, 6(r1)
	jr	r31				#
beq_then.16215:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16216
	addi	r1, r0, 0
	jr	r31				#
beq_then.16216:
	addi	r1, r0, 1
	jr	r31				#
check_all_inside.3133:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16217
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
	beqi	1, r6, beq_then.16218
	beqi	2, r6, beq_then.16220
	sw	r5, 8(r3)
	add	r1, r0, r5
	fadd	f3, f0, f6
	fadd	f2, f0, f5
	fadd	f1, f0, f4
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	quadratic.3031				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 8(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16222
	j	beq_cont.16223
beq_then.16222:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16223:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16224
	addi	r2, r0, 0
	j	fle_cont.16225
fle_else.16224:
	addi	r2, r0, 1
fle_cont.16225:
	beqi	0, r1, beq_then.16226
	beqi	0, r2, beq_then.16228
	addi	r1, r0, 0
	j	beq_cont.16229
beq_then.16228:
	addi	r1, r0, 1
beq_cont.16229:
	j	beq_cont.16227
beq_then.16226:
	add	r1, r0, r2
beq_cont.16227:
	beqi	0, r1, beq_then.16230
	addi	r1, r0, 0
	j	beq_cont.16231
beq_then.16230:
	addi	r1, r0, 1
beq_cont.16231:
	j	beq_cont.16221
beq_then.16220:
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
	beq	r0, r30, fle_else.16232
	addi	r6, r0, 0
	j	fle_cont.16233
fle_else.16232:
	addi	r6, r0, 1
fle_cont.16233:
	beqi	0, r5, beq_then.16234
	beqi	0, r6, beq_then.16236
	addi	r5, r0, 0
	j	beq_cont.16237
beq_then.16236:
	addi	r5, r0, 1
beq_cont.16237:
	j	beq_cont.16235
beq_then.16234:
	add	r5, r0, r6
beq_cont.16235:
	beqi	0, r5, beq_then.16238
	addi	r1, r0, 0
	j	beq_cont.16239
beq_then.16238:
	addi	r1, r0, 1
beq_cont.16239:
beq_cont.16221:
	j	beq_cont.16219
beq_then.16218:
	add	r1, r0, r5
	fadd	f3, f0, f6
	fadd	f2, f0, f5
	fadd	f1, f0, f4
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	is_rect_outside.3113				
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.16219:
	beqi	0, r1, beq_then.16240
	addi	r1, r0, 0
	jr	r31				#
beq_then.16240:
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 6(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16241
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r5, 0(r30)
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	sw	r1, 9(r3)
	add	r1, r0, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	is_outside.3128				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.16242
	addi	r1, r0, 0
	jr	r31				#
beq_then.16242:
	lw	r1, 9(r3)
	addi	r1, r1, 1
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r2, 6(r3)
	j	check_all_inside.3133
beq_then.16241:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16217:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3139:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16243
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
	beqi	1, r9, beq_then.16244
	beqi	2, r9, beq_then.16246
	add	r2, r0, r8
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_second_fast.3067				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16247
beq_then.16246:
	flw	f4, 0(r8)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16248
	addi	r6, r0, 0
	j	fle_cont.16249
fle_else.16248:
	addi	r6, r0, 1
fle_cont.16249:
	beqi	0, r6, beq_then.16250
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
	j	beq_cont.16251
beq_then.16250:
	addi	r1, r0, 0
beq_cont.16251:
beq_cont.16247:
	j	beq_cont.16245
beq_then.16244:
	lw	r6, 0(r6)
	add	r5, r0, r8
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_rect_fast.3054				
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16245:
	flw	f1, 724(r0)
	beqi	0, r1, beq_then.16252
	flup	f2, 28		# fli	f2, -0.200000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16254
	addi	r1, r0, 0
	j	fle_cont.16255
fle_else.16254:
	addi	r1, r0, 1
fle_cont.16255:
	j	beq_cont.16253
beq_then.16252:
	addi	r1, r0, 0
beq_cont.16253:
	beqi	0, r1, beq_then.16256
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
	beqi	-1, r1, beq_then.16257
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r1
	lw	r1, 0(r30)
	fsw	f1, 4(r3)
	fsw	f3, 6(r3)
	fsw	f2, 8(r3)
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f2
	fadd	f2, f0, f30
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	is_outside.3128				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.16260
	addi	r1, r0, 0
	j	beq_cont.16261
beq_then.16260:
	addi	r1, r0, 1
	flw	f1, 8(r3)
	flw	f2, 6(r3)
	flw	f3, 4(r3)
	lw	r2, 0(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	check_all_inside.3133				
	addi	r3, r3, -11
	lw	r31, 10(r3)
beq_cont.16261:
	j	beq_cont.16258
beq_then.16257:
	addi	r1, r0, 1
beq_cont.16258:
	beqi	0, r1, beq_then.16262
	addi	r1, r0, 1
	jr	r31				#
beq_then.16262:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_and_group.3139
beq_then.16256:
	addi	r1, r0, 1				# set min_caml_objects
	lw	r2, 2(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16263
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_and_group.3139
beq_then.16263:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16243:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3142:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16264
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.16265
	addi	r1, r0, 1
	jr	r31				#
beq_then.16265:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16266
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	sw	r1, 2(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16267
	addi	r1, r0, 1
	jr	r31				#
beq_then.16267:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16268
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	sw	r1, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.16269
	addi	r1, r0, 1
	jr	r31				#
beq_then.16269:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16270
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	sw	r1, 4(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.16271
	addi	r1, r0, 1
	jr	r31				#
beq_then.16271:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_one_or_group.3142
beq_then.16270:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16268:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16266:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16264:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3145:
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16272
	addi	r7, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r6, r7, beq_then.16273
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
	beqi	1, r9, beq_then.16275
	beqi	2, r9, beq_then.16277
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_second_fast.3067				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16278
beq_then.16277:
	flw	f4, 0(r6)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16279
	addi	r7, r0, 0
	j	fle_cont.16280
fle_else.16279:
	addi	r7, r0, 1
fle_cont.16280:
	beqi	0, r7, beq_then.16281
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
	j	beq_cont.16282
beq_then.16281:
	addi	r1, r0, 0
beq_cont.16282:
beq_cont.16278:
	j	beq_cont.16276
beq_then.16275:
	lw	r7, 0(r7)
	add	r5, r0, r6
	add	r2, r0, r7
	add	r1, r0, r8
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_rect_fast.3054				
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16276:
	beqi	0, r1, beq_then.16283
	flup	f1, 30		# fli	f1, -0.100000
	flw	f2, 724(r0)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16285
	addi	r1, r0, 0
	j	fle_cont.16286
fle_else.16285:
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16287
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16289
	addi	r1, r0, 1
	j	beq_cont.16290
beq_then.16289:
	lw	r1, 0(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16291
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16293
	addi	r1, r0, 1
	j	beq_cont.16294
beq_then.16293:
	lw	r1, 0(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16295
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16297
	addi	r1, r0, 1
	j	beq_cont.16298
beq_then.16297:
	addi	r1, r0, 4
	lw	r2, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_one_or_group.3142				
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16298:
	j	beq_cont.16296
beq_then.16295:
	addi	r1, r0, 0
beq_cont.16296:
beq_cont.16294:
	j	beq_cont.16292
beq_then.16291:
	addi	r1, r0, 0
beq_cont.16292:
beq_cont.16290:
	j	beq_cont.16288
beq_then.16287:
	addi	r1, r0, 0
beq_cont.16288:
	beqi	0, r1, beq_then.16299
	addi	r1, r0, 1
	j	beq_cont.16300
beq_then.16299:
	addi	r1, r0, 0
beq_cont.16300:
fle_cont.16286:
	j	beq_cont.16284
beq_then.16283:
	addi	r1, r0, 0
beq_cont.16284:
	j	beq_cont.16274
beq_then.16273:
	addi	r1, r0, 1
beq_cont.16274:
	beqi	0, r1, beq_then.16301
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16302
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16304
	addi	r1, r0, 1
	j	beq_cont.16305
beq_then.16304:
	lw	r1, 0(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16306
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16308
	addi	r1, r0, 1
	j	beq_cont.16309
beq_then.16308:
	lw	r1, 0(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16310
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16312
	addi	r1, r0, 1
	j	beq_cont.16313
beq_then.16312:
	addi	r1, r0, 4
	lw	r2, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_one_or_group.3142				
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16313:
	j	beq_cont.16311
beq_then.16310:
	addi	r1, r0, 0
beq_cont.16311:
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
	beqi	0, r1, beq_then.16314
	addi	r1, r0, 1
	jr	r31				#
beq_then.16314:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	j	shadow_check_one_or_matrix.3145
beq_then.16301:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	j	shadow_check_one_or_matrix.3145
beq_then.16272:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3148:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.16315
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
	beqi	1, r8, beq_then.16316
	beqi	2, r8, beq_then.16318
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second.3044				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16319
beq_then.16318:
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_surface.3025				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16319:
	j	beq_cont.16317
beq_then.16316:
	addi	r8, r0, 0
	addi	r9, r0, 1
	addi	r10, r0, 2
	fsw	f1, 4(r3)
	fsw	f3, 6(r3)
	fsw	f2, 8(r3)
	sw	r7, 10(r3)
	add	r6, r0, r9
	add	r2, r0, r5
	add	r1, r0, r7
	add	r7, r0, r10
	add	r5, r0, r8
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solver_rect_surface.3010				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16320
	addi	r1, r0, 1
	j	beq_cont.16321
beq_then.16320:
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
	jal	solver_rect_surface.3010				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16322
	addi	r1, r0, 2
	j	beq_cont.16323
beq_then.16322:
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
	jal	solver_rect_surface.3010				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16324
	addi	r1, r0, 3
	j	beq_cont.16325
beq_then.16324:
	addi	r1, r0, 0
beq_cont.16325:
beq_cont.16323:
beq_cont.16321:
beq_cont.16317:
	beqi	0, r1, beq_then.16326
	flw	f1, 724(r0)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16327
	j	fle_cont.16328
fle_else.16327:
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16329
	j	fle_cont.16330
fle_else.16329:
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
	beqi	-1, r6, beq_then.16331
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r6, 0(r30)
	add	r1, r0, r6
	fadd	f1, f0, f2
	fadd	f2, f0, f3
	fadd	f3, f0, f4
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	is_outside.3128				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.16333
	addi	r1, r0, 0
	j	beq_cont.16334
beq_then.16333:
	addi	r1, r0, 1
	flw	f1, 16(r3)
	flw	f2, 14(r3)
	flw	f3, 12(r3)
	lw	r2, 1(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	check_all_inside.3133				
	addi	r3, r3, -21
	lw	r31, 20(r3)
beq_cont.16334:
	j	beq_cont.16332
beq_then.16331:
	addi	r1, r0, 1
beq_cont.16332:
	beqi	0, r1, beq_then.16335
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
	j	beq_cont.16336
beq_then.16335:
beq_cont.16336:
fle_cont.16330:
fle_cont.16328:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3148
beq_then.16326:
	addi	r1, r0, 1				# set min_caml_objects
	lw	r2, 3(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16337
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3148
beq_then.16337:
	jr	r31				#
beq_then.16315:
	jr	r31				#
solve_one_or_network.3152:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.16340
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16341
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	sw	r1, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	add	r5, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element.3148				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16342
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	sw	r1, 4(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	add	r5, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solve_each_element.3148				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16343
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	sw	r1, 5(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	add	r5, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element.3148				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_one_or_network.3152
beq_then.16343:
	jr	r31				#
beq_then.16342:
	jr	r31				#
beq_then.16341:
	jr	r31				#
beq_then.16340:
	jr	r31				#
trace_or_matrix.3156:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.16348
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.16349
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
	beqi	1, r8, beq_then.16351
	beqi	2, r8, beq_then.16353
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second.3044				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16354
beq_then.16353:
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_surface.3025				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16354:
	j	beq_cont.16352
beq_then.16351:
	addi	r8, r0, 0
	addi	r9, r0, 1
	addi	r10, r0, 2
	fsw	f1, 4(r3)
	fsw	f3, 6(r3)
	fsw	f2, 8(r3)
	sw	r7, 10(r3)
	add	r6, r0, r9
	add	r2, r0, r5
	add	r1, r0, r7
	add	r7, r0, r10
	add	r5, r0, r8
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solver_rect_surface.3010				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16355
	addi	r1, r0, 1
	j	beq_cont.16356
beq_then.16355:
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
	jal	solver_rect_surface.3010				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16357
	addi	r1, r0, 2
	j	beq_cont.16358
beq_then.16357:
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
	jal	solver_rect_surface.3010				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16359
	addi	r1, r0, 3
	j	beq_cont.16360
beq_then.16359:
	addi	r1, r0, 0
beq_cont.16360:
beq_cont.16358:
beq_cont.16356:
beq_cont.16352:
	beqi	0, r1, beq_then.16361
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16363
	j	fle_cont.16364
fle_else.16363:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16365
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16367
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16369
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_one_or_network.3152				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.16370
beq_then.16369:
beq_cont.16370:
	j	beq_cont.16368
beq_then.16367:
beq_cont.16368:
	j	beq_cont.16366
beq_then.16365:
beq_cont.16366:
fle_cont.16364:
	j	beq_cont.16362
beq_then.16361:
beq_cont.16362:
	j	beq_cont.16350
beq_then.16349:
	lw	r7, 1(r6)
	beqi	-1, r7, beq_then.16371
	addi	r8, r0, 672				# set min_caml_and_net
	add	r30, r8, r7
	lw	r7, 0(r30)
	addi	r8, r0, 0
	sw	r6, 3(r3)
	add	r2, r0, r7
	add	r1, r0, r8
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16373
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16375
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_one_or_network.3152				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.16376
beq_then.16375:
beq_cont.16376:
	j	beq_cont.16374
beq_then.16373:
beq_cont.16374:
	j	beq_cont.16372
beq_then.16371:
beq_cont.16372:
beq_cont.16350:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16377
	addi	r7, r0, 99
	sw	r1, 11(r3)
	beq	r6, r7, beq_then.16378
	addi	r7, r0, 748				# set min_caml_startp
	lw	r8, 0(r3)
	sw	r5, 12(r3)
	add	r5, r0, r7
	add	r2, r0, r8
	add	r1, r0, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solver.3050				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.16380
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16382
	j	fle_cont.16383
fle_else.16382:
	lw	r1, 12(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16384
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 12(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16386
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r1, r0, 3
	lw	r2, 12(r3)
	lw	r5, 0(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_one_or_network.3152				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.16387
beq_then.16386:
beq_cont.16387:
	j	beq_cont.16385
beq_then.16384:
beq_cont.16385:
fle_cont.16383:
	j	beq_cont.16381
beq_then.16380:
beq_cont.16381:
	j	beq_cont.16379
beq_then.16378:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16388
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	lw	r8, 0(r3)
	sw	r5, 12(r3)
	add	r5, r0, r8
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 12(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16390
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r1, r0, 3
	lw	r2, 12(r3)
	lw	r5, 0(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_one_or_network.3152				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.16391
beq_then.16390:
beq_cont.16391:
	j	beq_cont.16389
beq_then.16388:
beq_cont.16389:
beq_cont.16379:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix.3156
beq_then.16377:
	jr	r31				#
beq_then.16348:
	jr	r31				#
judge_intersection.3160:
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 726(r0)
	lw	r2, 723(r0)
	lw	r5, 0(r2)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16394
	addi	r7, r0, 99
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	beq	r6, r7, beq_then.16396
	addi	r7, r0, 748				# set min_caml_startp
	sw	r5, 2(r3)
	add	r5, r0, r7
	add	r2, r0, r1
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver.3050				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16398
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16400
	j	fle_cont.16401
fle_else.16400:
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16402
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16404
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network.3152				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16405
beq_then.16404:
beq_cont.16405:
	j	beq_cont.16403
beq_then.16402:
beq_cont.16403:
fle_cont.16401:
	j	beq_cont.16399
beq_then.16398:
beq_cont.16399:
	j	beq_cont.16397
beq_then.16396:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16406
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r5, 2(r3)
	add	r5, r0, r1
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16408
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network.3152				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16409
beq_then.16408:
beq_cont.16409:
	j	beq_cont.16407
beq_then.16406:
beq_cont.16407:
beq_cont.16397:
	addi	r1, r0, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix.3156				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16395
beq_then.16394:
beq_cont.16395:
	flw	f1, 726(r0)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16410
	addi	r1, r0, 0
	jr	r31				#
fle_else.16410:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16411
	addi	r1, r0, 0
	jr	r31				#
fle_else.16411:
	addi	r1, r0, 1
	jr	r31				#
solve_each_element_fast.3162:
	lw	r6, 0(r5)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.16412
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
	beqi	1, r11, beq_then.16413
	beqi	2, r11, beq_then.16415
	add	r5, r0, r9
	add	r2, r0, r10
	add	r1, r0, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_second_fast2.3084				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16416
beq_then.16415:
	flw	f1, 0(r10)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16417
	addi	r8, r0, 0
	j	fle_cont.16418
fle_else.16417:
	addi	r8, r0, 1
fle_cont.16418:
	beqi	0, r8, beq_then.16419
	flw	f1, 0(r10)
	flw	f2, 3(r9)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	j	beq_cont.16420
beq_then.16419:
	addi	r1, r0, 0
beq_cont.16420:
beq_cont.16416:
	j	beq_cont.16414
beq_then.16413:
	lw	r9, 0(r5)
	add	r5, r0, r10
	add	r2, r0, r9
	add	r1, r0, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_rect_fast.3054				
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16414:
	beqi	0, r1, beq_then.16421
	flw	f1, 724(r0)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16422
	j	fle_cont.16423
fle_else.16422:
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16424
	j	fle_cont.16425
fle_else.16424:
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
	beqi	-1, r5, beq_then.16426
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r5, 0(r30)
	add	r1, r0, r5
	fadd	f1, f0, f2
	fadd	f2, f0, f3
	fadd	f3, f0, f4
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	is_outside.3128				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.16428
	addi	r1, r0, 0
	j	beq_cont.16429
beq_then.16428:
	addi	r1, r0, 1
	flw	f1, 10(r3)
	flw	f2, 8(r3)
	flw	f3, 6(r3)
	lw	r2, 2(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	check_all_inside.3133				
	addi	r3, r3, -15
	lw	r31, 14(r3)
beq_cont.16429:
	j	beq_cont.16427
beq_then.16426:
	addi	r1, r0, 1
beq_cont.16427:
	beqi	0, r1, beq_then.16430
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
	j	beq_cont.16431
beq_then.16430:
beq_cont.16431:
fle_cont.16425:
fle_cont.16423:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	j	solve_each_element_fast.3162
beq_then.16421:
	addi	r1, r0, 1				# set min_caml_objects
	lw	r2, 4(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16432
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	j	solve_each_element_fast.3162
beq_then.16432:
	jr	r31				#
beq_then.16412:
	jr	r31				#
solve_one_or_network_fast.3166:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.16435
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16436
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	sw	r1, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	add	r5, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16437
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	sw	r1, 4(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	add	r5, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16438
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 0(r3)
	sw	r1, 5(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	add	r5, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_one_or_network_fast.3166
beq_then.16438:
	jr	r31				#
beq_then.16437:
	jr	r31				#
beq_then.16436:
	jr	r31				#
beq_then.16435:
	jr	r31				#
trace_or_matrix_fast.3170:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.16443
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.16444
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
	beqi	1, r10, beq_then.16446
	beqi	2, r10, beq_then.16448
	add	r5, r0, r9
	add	r2, r0, r7
	add	r1, r0, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second_fast2.3084				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16449
beq_then.16448:
	flw	f1, 0(r7)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16450
	addi	r8, r0, 0
	j	fle_cont.16451
fle_else.16450:
	addi	r8, r0, 1
fle_cont.16451:
	beqi	0, r8, beq_then.16452
	flw	f1, 0(r7)
	flw	f2, 3(r9)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	j	beq_cont.16453
beq_then.16452:
	addi	r1, r0, 0
beq_cont.16453:
beq_cont.16449:
	j	beq_cont.16447
beq_then.16446:
	lw	r9, 0(r5)
	add	r5, r0, r7
	add	r2, r0, r9
	add	r1, r0, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_rect_fast.3054				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16447:
	beqi	0, r1, beq_then.16454
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16456
	j	fle_cont.16457
fle_else.16456:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16458
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16460
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16462
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16463
beq_then.16462:
beq_cont.16463:
	j	beq_cont.16461
beq_then.16460:
beq_cont.16461:
	j	beq_cont.16459
beq_then.16458:
beq_cont.16459:
fle_cont.16457:
	j	beq_cont.16455
beq_then.16454:
beq_cont.16455:
	j	beq_cont.16445
beq_then.16444:
	lw	r7, 1(r6)
	beqi	-1, r7, beq_then.16464
	addi	r8, r0, 672				# set min_caml_and_net
	add	r30, r8, r7
	lw	r7, 0(r30)
	addi	r8, r0, 0
	sw	r6, 3(r3)
	add	r2, r0, r7
	add	r1, r0, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16466
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16468
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16469
beq_then.16468:
beq_cont.16469:
	j	beq_cont.16467
beq_then.16466:
beq_cont.16467:
	j	beq_cont.16465
beq_then.16464:
beq_cont.16465:
beq_cont.16445:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16470
	addi	r7, r0, 99
	sw	r1, 4(r3)
	beq	r6, r7, beq_then.16471
	lw	r7, 0(r3)
	sw	r5, 5(r3)
	add	r2, r0, r7
	add	r1, r0, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solver_fast2.3091				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.16473
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16475
	j	fle_cont.16476
fle_else.16475:
	lw	r1, 5(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16477
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16479
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 3
	lw	r2, 5(r3)
	lw	r5, 0(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16480
beq_then.16479:
beq_cont.16480:
	j	beq_cont.16478
beq_then.16477:
beq_cont.16478:
fle_cont.16476:
	j	beq_cont.16474
beq_then.16473:
beq_cont.16474:
	j	beq_cont.16472
beq_then.16471:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16481
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	lw	r8, 0(r3)
	sw	r5, 5(r3)
	add	r5, r0, r8
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16483
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 3
	lw	r2, 5(r3)
	lw	r5, 0(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16484
beq_then.16483:
beq_cont.16484:
	j	beq_cont.16482
beq_then.16481:
beq_cont.16482:
beq_cont.16472:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix_fast.3170
beq_then.16470:
	jr	r31				#
beq_then.16443:
	jr	r31				#
judge_intersection_fast.3174:
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 726(r0)
	lw	r2, 723(r0)
	lw	r5, 0(r2)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16487
	addi	r7, r0, 99
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	beq	r6, r7, beq_then.16489
	sw	r5, 2(r3)
	add	r2, r0, r1
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_fast2.3091				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16491
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16493
	j	fle_cont.16494
fle_else.16493:
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16495
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16497
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16498
beq_then.16497:
beq_cont.16498:
	j	beq_cont.16496
beq_then.16495:
beq_cont.16496:
fle_cont.16494:
	j	beq_cont.16492
beq_then.16491:
beq_cont.16492:
	j	beq_cont.16490
beq_then.16489:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16499
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r5, 2(r3)
	add	r5, r0, r1
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16501
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16502
beq_then.16501:
beq_cont.16502:
	j	beq_cont.16500
beq_then.16499:
beq_cont.16500:
beq_cont.16490:
	addi	r1, r0, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix_fast.3170				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16488
beq_then.16487:
beq_cont.16488:
	flw	f1, 726(r0)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16503
	addi	r1, r0, 0
	jr	r31				#
fle_else.16503:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16504
	addi	r1, r0, 0
	jr	r31				#
fle_else.16504:
	addi	r1, r0, 1
	jr	r31				#
get_nvector_rect.3176:
	lw	r2, 725(r0)
	fsw	f0, 731(r0)
	fsw	f0, 732(r0)
	fsw	f0, 733(r0)
	addi	r5, r0, 731				# set min_caml_nvector
	addi	r6, r2, -1
	addi	r2, r2, -1
	add	r30, r1, r2
	flw	f1, 0(r30)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16505
	addi	r1, r0, 1
	j	feq_cont.16506
feq_else.16505:
	addi	r1, r0, 0
feq_cont.16506:
	beqi	0, r1, beq_then.16507
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16508
beq_then.16507:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16509
	addi	r1, r0, 0
	j	fle_cont.16510
fle_else.16509:
	addi	r1, r0, 1
fle_cont.16510:
	beqi	0, r1, beq_then.16511
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16512
beq_then.16511:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.16512:
beq_cont.16508:
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
	beqi	0, r2, beq_then.16515
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
	j	beq_cont.16516
beq_then.16515:
	fsw	f4, 731(r0)
	fsw	f5, 732(r0)
	fsw	f6, 733(r0)
beq_cont.16516:
	addi	r2, r0, 731				# set min_caml_nvector
	lw	r1, 6(r1)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	j	vecunit_sgn.2888
get_nvector.3182:
	lw	r5, 1(r1)
	beqi	1, r5, beq_then.16517
	beqi	2, r5, beq_then.16518
	j	get_nvector_second.3180
beq_then.16518:
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
beq_then.16517:
	lw	r1, 725(r0)
	fsw	f0, 731(r0)
	fsw	f0, 732(r0)
	fsw	f0, 733(r0)
	addi	r5, r0, 731				# set min_caml_nvector
	addi	r6, r1, -1
	addi	r1, r1, -1
	add	r30, r2, r1
	flw	f1, 0(r30)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16520
	addi	r1, r0, 1
	j	feq_cont.16521
feq_else.16520:
	addi	r1, r0, 0
feq_cont.16521:
	beqi	0, r1, beq_then.16522
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16523
beq_then.16522:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16524
	addi	r1, r0, 0
	j	fle_cont.16525
fle_else.16524:
	addi	r1, r0, 1
fle_cont.16525:
	beqi	0, r1, beq_then.16526
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16527
beq_then.16526:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.16527:
beq_cont.16523:
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
	beqi	1, r5, beq_then.16529
	beqi	2, r5, beq_then.16530
	beqi	3, r5, beq_then.16531
	beqi	4, r5, beq_then.16532
	jr	r31				#
beq_then.16532:
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
	beq	r0, r30, fle_else.16534
	fadd	f5, f0, f1
	j	fle_cont.16535
fle_else.16534:
	fneg	f5, f1
fle_cont.16535:
	fsw	f3, 0(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	fle	r30, f4, f5
	beq	r0, r30, fle_else.16536
	fdiv	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16538
	j	fle_cont.16539
fle_else.16538:
	fneg	f1, f1
fle_cont.16539:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16540
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.16541
fle_else.16540:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.16541:
	fmul	f1, f1, f2
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16542
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16544
	flup	f4, 15		# fli	f4, 1.570796
	flup	f5, 2		# fli	f5, 1.000000
	fdiv	f1, f5, f1
	fsw	f2, 4(r3)
	fsw	f4, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	atan_body.2841				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	j	fle_cont.16545
fle_else.16544:
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
	jal	atan_body.2841				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
fle_cont.16545:
	j	fle_cont.16543
fle_else.16542:
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2841				
	addi	r3, r3, -11
	lw	r31, 10(r3)
fle_cont.16543:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.16537
fle_else.16536:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.16537:
	ftoi	r1, f1
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16546
	j	fle_cont.16547
fle_else.16546:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.16547:
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
	beq	r0, r30, fle_else.16548
	fadd	f5, f0, f4
	j	fle_cont.16549
fle_else.16548:
	fneg	f5, f4
fle_cont.16549:
	fsw	f1, 10(r3)
	fle	r30, f3, f5
	beq	r0, r30, fle_else.16550
	fdiv	f2, f2, f4
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16552
	j	fle_cont.16553
fle_else.16552:
	fneg	f2, f2
fle_cont.16553:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16554
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.16555
fle_else.16554:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.16555:
	fmul	f2, f2, f3
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f2
	beq	r0, r30, fle_else.16556
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f2
	beq	r0, r30, fle_else.16558
	flup	f4, 15		# fli	f4, 1.570796
	flup	f5, 2		# fli	f5, 1.000000
	fdiv	f2, f5, f2
	fsw	f3, 12(r3)
	fsw	f4, 14(r3)
	fadd	f1, f0, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2841				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	flw	f2, 12(r3)
	fmul	f1, f1, f2
	j	fle_cont.16559
fle_else.16558:
	flup	f4, 16		# fli	f4, 0.785398
	flup	f5, 2		# fli	f5, 1.000000
	fsub	f5, f2, f5
	flup	f6, 2		# fli	f6, 1.000000
	fadd	f2, f2, f6
	fdiv	f2, f5, f2
	fsw	f3, 12(r3)
	fsw	f4, 16(r3)
	fadd	f1, f0, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2841				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fadd	f1, f2, f1
	flw	f2, 12(r3)
	fmul	f1, f1, f2
fle_cont.16559:
	j	fle_cont.16557
fle_else.16556:
	fadd	f1, f0, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2841				
	addi	r3, r3, -19
	lw	r31, 18(r3)
fle_cont.16557:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.16551
fle_else.16550:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.16551:
	ftoi	r1, f1
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16560
	j	fle_cont.16561
fle_else.16560:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.16561:
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
	beq	r0, r30, fle_else.16562
	addi	r1, r0, 0
	j	fle_cont.16563
fle_else.16562:
	addi	r1, r0, 1
fle_cont.16563:
	beqi	0, r1, beq_then.16564
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16565
beq_then.16564:
beq_cont.16565:
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f2, f1
	flup	f2, 38		# fli	f2, 0.300000
	fdiv	f1, f1, f2
	fsw	f1, 736(r0)
	jr	r31				#
beq_then.16531:
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
	beq	r0, r30, fle_else.16567
	j	fle_cont.16568
fle_else.16567:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.16568:
	fsub	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fmul	f1, f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	cos.2839				
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
beq_then.16530:
	flw	f1, 1(r2)
	flup	f2, 40		# fli	f2, 0.250000
	fmul	f1, f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	sin.2837				
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
beq_then.16529:
	flw	f1, 0(r2)
	lw	r5, 5(r1)
	flw	f2, 0(r5)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	ftoi	r5, f2
	itof	f3, r5
	fle	r30, f3, f2
	beq	r0, r30, fle_else.16571
	fadd	f2, f0, f3
	j	fle_cont.16572
fle_else.16571:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.16572:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16573
	addi	r5, r0, 0
	j	fle_cont.16574
fle_else.16573:
	addi	r5, r0, 1
fle_cont.16574:
	flw	f1, 2(r2)
	lw	r1, 5(r1)
	flw	f2, 2(r1)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	ftoi	r1, f2
	itof	f3, r1
	fle	r30, f3, f2
	beq	r0, r30, fle_else.16575
	fadd	f2, f0, f3
	j	fle_cont.16576
fle_else.16575:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.16576:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16577
	addi	r1, r0, 0
	j	fle_cont.16578
fle_else.16577:
	addi	r1, r0, 1
fle_cont.16578:
	beqi	0, r5, beq_then.16579
	beqi	0, r1, beq_then.16581
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.16582
beq_then.16581:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.16582:
	j	beq_cont.16580
beq_then.16579:
	beqi	0, r1, beq_then.16583
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16584
beq_then.16583:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.16584:
beq_cont.16580:
	fsw	f1, 735(r0)
	jr	r31				#
add_light.3188:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16586
	addi	r1, r0, 0
	j	fle_cont.16587
fle_else.16586:
	addi	r1, r0, 1
fle_cont.16587:
	beqi	0, r1, beq_then.16588
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
	j	beq_cont.16589
beq_then.16588:
beq_cont.16589:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.16590
	addi	r1, r0, 0
	j	fle_cont.16591
fle_else.16590:
	addi	r1, r0, 1
fle_cont.16591:
	beqi	0, r1, beq_then.16592
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
beq_then.16592:
	jr	r31				#
trace_reflections.3192:
	bgei	0, r1, bge_then.16595
	jr	r31				#
bge_then.16595:
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
	add	r5, r0, r6
	add	r2, r0, r8
	add	r1, r0, r7
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	trace_or_matrix_fast.3170				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f1, 726(r0)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16599
	addi	r1, r0, 0
	j	fle_cont.16600
fle_else.16599:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16601
	addi	r1, r0, 0
	j	fle_cont.16602
fle_else.16601:
	addi	r1, r0, 1
fle_cont.16602:
fle_cont.16600:
	beqi	0, r1, beq_then.16603
	lw	r1, 730(r0)
	slli	r1, r1, 2
	lw	r2, 725(r0)
	add	r1, r1, r2
	lw	r2, 9(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.16605
	j	beq_cont.16606
beq_then.16605:
	addi	r1, r0, 0
	lw	r5, 723(r0)
	add	r2, r0, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	shadow_check_one_or_matrix.3145				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.16607
	j	beq_cont.16608
beq_then.16607:
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
	fadd	f3, f0, f4
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	add_light.3188				
	addi	r3, r3, -11
	lw	r31, 10(r3)
beq_cont.16608:
beq_cont.16606:
	j	beq_cont.16604
beq_then.16603:
beq_cont.16604:
	lw	r1, 0(r3)
	addi	r1, r1, -1
	flw	f1, 6(r3)
	flw	f2, 2(r3)
	lw	r2, 4(r3)
	j	trace_reflections.3192
trace_ray.3197:
	blei	4, r1, ble_then.16609
	jr	r31				#
ble_then.16609:
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
	add	r5, r0, r2
	add	r1, r0, r7
	add	r2, r0, r8
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	trace_or_matrix.3156				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	flw	f1, 726(r0)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16612
	addi	r1, r0, 0
	j	fle_cont.16613
fle_else.16612:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16614
	addi	r1, r0, 0
	j	fle_cont.16615
fle_else.16614:
	addi	r1, r0, 1
fle_cont.16615:
fle_cont.16613:
	beqi	0, r1, beq_then.16616
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
	beqi	1, r6, beq_then.16617
	beqi	2, r6, beq_then.16619
	add	r1, r0, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	get_nvector_second.3180				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	j	beq_cont.16620
beq_then.16619:
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
beq_cont.16620:
	j	beq_cont.16618
beq_then.16617:
	lw	r6, 725(r0)
	fsw	f0, 731(r0)
	fsw	f0, 732(r0)
	fsw	f0, 733(r0)
	addi	r7, r0, 731				# set min_caml_nvector
	addi	r8, r6, -1
	addi	r6, r6, -1
	lw	r9, 6(r3)
	add	r30, r9, r6
	flw	f3, 0(r30)
	feq	r30, f3, f0
	beq	r0, r30, feq_else.16621
	addi	r6, r0, 1
	j	feq_cont.16622
feq_else.16621:
	addi	r6, r0, 0
feq_cont.16622:
	beqi	0, r6, beq_then.16623
	flup	f3, 0		# fli	f3, 0.000000
	j	beq_cont.16624
beq_then.16623:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.16625
	addi	r6, r0, 0
	j	fle_cont.16626
fle_else.16625:
	addi	r6, r0, 1
fle_cont.16626:
	beqi	0, r6, beq_then.16627
	flup	f3, 2		# fli	f3, 1.000000
	j	beq_cont.16628
beq_then.16627:
	flup	f3, 11		# fli	f3, -1.000000
beq_cont.16628:
beq_cont.16624:
	fneg	f3, f3
	add	r30, r7, r8
	fsw	f3, 0(r30)
beq_cont.16618:
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
	jal	utexture.3185				
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
	beq	r0, r30, fle_else.16629
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
	j	fle_cont.16630
fle_else.16629:
	add	r30, r6, r2
	sw	r0, 0(r30)
fle_cont.16630:
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
	add	r2, r0, r9
	add	r1, r0, r8
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	shadow_check_one_or_matrix.3145				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.16631
	j	beq_cont.16632
beq_then.16631:
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
	fadd	f2, f0, f3
	fadd	f3, f0, f4
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	add_light.3188				
	addi	r3, r3, -17
	lw	r31, 16(r3)
beq_cont.16632:
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
	jal	setup_startp_constants.3108				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r1, 1023(r0)
	addi	r1, r1, -1
	flw	f1, 10(r3)
	flw	f2, 14(r3)
	lw	r2, 6(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	trace_reflections.3192				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flup	f1, 45		# fli	f1, 0.100000
	flw	f2, 4(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16633
	jr	r31				#
fle_else.16633:
	lw	r1, 7(r3)
	bgei	4, r1, bge_then.16635
	addi	r2, r1, 1
	addi	r5, r0, -1
	lw	r6, 8(r3)
	add	r30, r6, r2
	sw	r5, 0(r30)
	j	bge_cont.16636
bge_then.16635:
bge_cont.16636:
	lw	r2, 9(r3)
	beqi	2, r2, beq_then.16637
	j	beq_cont.16638
beq_then.16637:
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
	jal	trace_ray.3197				
	addi	r3, r3, -17
	lw	r31, 16(r3)
beq_cont.16638:
	jr	r31				#
beq_then.16616:
	addi	r1, r0, -1
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	0, r2, beq_then.16640
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
	beq	r0, r30, fle_else.16641
	addi	r1, r0, 0
	j	fle_cont.16642
fle_else.16641:
	addi	r1, r0, 1
fle_cont.16642:
	beqi	0, r1, beq_then.16643
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
beq_then.16643:
	jr	r31				#
beq_then.16640:
	jr	r31				#
trace_diffuse_ray.3203:
	flup	f2, 31		# fli	f2, 1000000000.000000
	fsw	f2, 726(r0)
	addi	r2, r0, 0
	lw	r5, 723(r0)
	fsw	f1, 0(r3)
	sw	r1, 2(r3)
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix_fast.3170				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	flw	f1, 726(r0)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16647
	addi	r1, r0, 0
	j	fle_cont.16648
fle_else.16647:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16649
	addi	r1, r0, 0
	j	fle_cont.16650
fle_else.16649:
	addi	r1, r0, 1
fle_cont.16650:
fle_cont.16648:
	beqi	0, r1, beq_then.16651
	addi	r1, r0, 1				# set min_caml_objects
	lw	r2, 730(r0)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r2, 2(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	sw	r1, 3(r3)
	beqi	1, r5, beq_then.16652
	beqi	2, r5, beq_then.16654
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	get_nvector_second.3180				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16655
beq_then.16654:
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
beq_cont.16655:
	j	beq_cont.16653
beq_then.16652:
	lw	r5, 725(r0)
	fsw	f0, 731(r0)
	fsw	f0, 732(r0)
	fsw	f0, 733(r0)
	addi	r6, r0, 731				# set min_caml_nvector
	addi	r7, r5, -1
	addi	r5, r5, -1
	add	r30, r2, r5
	flw	f1, 0(r30)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16656
	addi	r2, r0, 1
	j	feq_cont.16657
feq_else.16656:
	addi	r2, r0, 0
feq_cont.16657:
	beqi	0, r2, beq_then.16658
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16659
beq_then.16658:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16660
	addi	r2, r0, 0
	j	fle_cont.16661
fle_else.16660:
	addi	r2, r0, 1
fle_cont.16661:
	beqi	0, r2, beq_then.16662
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16663
beq_then.16662:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.16663:
beq_cont.16659:
	fneg	f1, f1
	add	r30, r6, r7
	fsw	f1, 0(r30)
beq_cont.16653:
	addi	r2, r0, 727				# set min_caml_intersection_point
	lw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	utexture.3185				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 0
	lw	r2, 723(r0)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_one_or_matrix.3145				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.16664
	jr	r31				#
beq_then.16664:
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
	beq	r0, r30, fle_else.16666
	addi	r1, r0, 0
	j	fle_cont.16667
fle_else.16666:
	addi	r1, r0, 1
fle_cont.16667:
	beqi	0, r1, beq_then.16668
	j	beq_cont.16669
beq_then.16668:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.16669:
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
beq_then.16651:
	jr	r31				#
iter_trace_diffuse_rays.3206:
	bgei	0, r6, bge_then.16672
	jr	r31				#
bge_then.16672:
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
	beq	r0, r30, fle_else.16674
	addi	r7, r0, 0
	j	fle_cont.16675
fle_else.16674:
	addi	r7, r0, 1
fle_cont.16675:
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r6, 3(r3)
	beqi	0, r7, beq_then.16676
	addi	r7, r6, 1
	add	r30, r1, r7
	lw	r7, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16677
beq_then.16676:
	add	r30, r1, r6
	lw	r7, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16677:
	lw	r1, 3(r3)
	addi	r1, r1, -2
	bgei	0, r1, bge_then.16678
	jr	r31				#
bge_then.16678:
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
	beq	r0, r30, fle_else.16680
	addi	r5, r0, 0
	j	fle_cont.16681
fle_else.16680:
	addi	r5, r0, 1
fle_cont.16681:
	sw	r1, 4(r3)
	beqi	0, r5, beq_then.16682
	addi	r5, r1, 1
	add	r30, r2, r5
	lw	r5, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16683
beq_then.16682:
	add	r30, r2, r1
	lw	r5, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16683:
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
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_startp_constants.3108				
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
	beq	r0, r30, fle_else.16684
	addi	r2, r0, 0
	j	fle_cont.16685
fle_else.16684:
	addi	r2, r0, 1
fle_cont.16685:
	beqi	0, r2, beq_then.16686
	lw	r2, 119(r1)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16687
beq_then.16686:
	lw	r2, 118(r1)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16687:
	addi	r6, r0, 116
	lw	r1, 2(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	iter_trace_diffuse_rays.3206
trace_diffuse_ray_80percent.3215:
	sw	r2, 0(r3)
	sw	r5, 1(r3)
	sw	r1, 2(r3)
	beqi	0, r1, beq_then.16688
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
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	setup_startp_constants.3108				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r6, r0, 118
	lw	r1, 3(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	iter_trace_diffuse_rays.3206				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16689
beq_then.16688:
beq_cont.16689:
	lw	r1, 2(r3)
	beqi	1, r1, beq_then.16690
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
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_startp_constants.3108				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r6, r0, 118
	lw	r1, 4(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_trace_diffuse_rays.3206				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16691
beq_then.16690:
beq_cont.16691:
	lw	r1, 2(r3)
	beqi	2, r1, beq_then.16692
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
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_startp_constants.3108				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r6, r0, 118
	lw	r1, 5(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_trace_diffuse_rays.3206				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16693
beq_then.16692:
beq_cont.16693:
	lw	r1, 2(r3)
	beqi	3, r1, beq_then.16694
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
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_startp_constants.3108				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r6, r0, 118
	lw	r1, 6(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	iter_trace_diffuse_rays.3206				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.16695
beq_then.16694:
beq_cont.16695:
	lw	r1, 2(r3)
	beqi	4, r1, beq_then.16696
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
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_startp_constants.3108				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	addi	r6, r0, 118
	lw	r1, 7(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	j	iter_trace_diffuse_rays.3206
beq_then.16696:
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
	add	r2, r0, r5
	add	r5, r0, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	trace_diffuse_ray_80percent.3215				
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
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	j	vecaccumv.2912
do_without_neighbors.3228:
	blei	4, r2, ble_then.16698
	jr	r31				#
ble_then.16698:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.16700
	jr	r31				#
bge_then.16700:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	beqi	0, r5, beq_then.16702
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
	add	r2, r0, r6
	add	r1, r0, r5
	add	r5, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_ray_80percent.3215				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 740				# set min_caml_rgb
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 737				# set min_caml_diffuse_ray
	add	r2, r0, r5
	add	r5, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	vecaccumv.2912				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16703
beq_then.16702:
beq_cont.16703:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	blei	4, r1, ble_then.16704
	jr	r31				#
ble_then.16704:
	lw	r2, 0(r3)
	lw	r5, 2(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.16706
	jr	r31				#
bge_then.16706:
	lw	r5, 3(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	sw	r1, 3(r3)
	beqi	0, r5, beq_then.16708
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
	add	r2, r0, r6
	add	r1, r0, r5
	add	r5, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	trace_diffuse_ray_80percent.3215				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r1, r0, 740				# set min_caml_rgb
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 737				# set min_caml_diffuse_ray
	add	r2, r0, r5
	add	r5, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	vecaccumv.2912				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16709
beq_then.16708:
beq_cont.16709:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	lw	r1, 0(r3)
	j	do_without_neighbors.3228
neighbors_exist.3231:
	lw	r5, 744(r0)
	addi	r6, r2, 1
	ble	r5, r6, ble_then.16710
	blei	0, r2, ble_then.16711
	lw	r2, 743(r0)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.16712
	blei	0, r1, ble_then.16713
	addi	r1, r0, 1
	jr	r31				#
ble_then.16713:
	addi	r1, r0, 0
	jr	r31				#
ble_then.16712:
	addi	r1, r0, 0
	jr	r31				#
ble_then.16711:
	addi	r1, r0, 0
	jr	r31				#
ble_then.16710:
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
	beq	r2, r8, beq_then.16714
	addi	r1, r0, 0
	jr	r31				#
beq_then.16714:
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.16715
	addi	r1, r0, 0
	jr	r31				#
beq_then.16715:
	addi	r2, r1, -1
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.16716
	addi	r1, r0, 0
	jr	r31				#
beq_then.16716:
	addi	r1, r1, 1
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beq	r1, r8, beq_then.16717
	addi	r1, r0, 0
	jr	r31				#
beq_then.16717:
	addi	r1, r0, 1
	jr	r31				#
try_exploit_neighbors.3244:
	add	r30, r6, r1
	lw	r9, 0(r30)
	blei	4, r8, ble_then.16718
	jr	r31				#
ble_then.16718:
	lw	r10, 2(r9)
	add	r30, r10, r8
	lw	r10, 0(r30)
	bgei	0, r10, bge_then.16720
	jr	r31				#
bge_then.16720:
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
	beq	r11, r10, beq_then.16722
	addi	r10, r0, 0
	j	beq_cont.16723
beq_then.16722:
	add	r30, r7, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r10, beq_then.16724
	addi	r10, r0, 0
	j	beq_cont.16725
beq_then.16724:
	addi	r11, r1, -1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r10, beq_then.16726
	addi	r10, r0, 0
	j	beq_cont.16727
beq_then.16726:
	addi	r11, r1, 1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r10, beq_then.16728
	addi	r10, r0, 0
	j	beq_cont.16729
beq_then.16728:
	addi	r10, r0, 1
beq_cont.16729:
beq_cont.16727:
beq_cont.16725:
beq_cont.16723:
	beqi	0, r10, beq_then.16730
	lw	r9, 3(r9)
	add	r30, r9, r8
	lw	r9, 0(r30)
	sw	r2, 0(r3)
	sw	r7, 1(r3)
	sw	r5, 2(r3)
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	beqi	0, r9, beq_then.16731
	add	r2, r0, r5
	add	r5, r0, r6
	add	r6, r0, r7
	add	r7, r0, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_diffuse_using_5points.3222				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16732
beq_then.16731:
beq_cont.16732:
	lw	r1, 5(r3)
	addi	r2, r1, 1
	lw	r1, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r1
	lw	r6, 0(r30)
	blei	4, r2, ble_then.16733
	jr	r31				#
ble_then.16733:
	lw	r7, 2(r6)
	add	r30, r7, r2
	lw	r7, 0(r30)
	bgei	0, r7, bge_then.16735
	jr	r31				#
bge_then.16735:
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
	beq	r9, r7, beq_then.16737
	addi	r7, r0, 0
	j	beq_cont.16738
beq_then.16737:
	lw	r9, 1(r3)
	add	r30, r9, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.16739
	addi	r7, r0, 0
	j	beq_cont.16740
beq_then.16739:
	addi	r10, r1, -1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.16741
	addi	r7, r0, 0
	j	beq_cont.16742
beq_then.16741:
	addi	r10, r1, 1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.16743
	addi	r7, r0, 0
	j	beq_cont.16744
beq_then.16743:
	addi	r7, r0, 1
beq_cont.16744:
beq_cont.16742:
beq_cont.16740:
beq_cont.16738:
	beqi	0, r7, beq_then.16745
	lw	r6, 3(r6)
	add	r30, r6, r2
	lw	r6, 0(r30)
	sw	r2, 6(r3)
	beqi	0, r6, beq_then.16746
	lw	r6, 1(r3)
	add	r7, r0, r2
	add	r2, r0, r8
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	calc_diffuse_using_5points.3222				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.16747
beq_then.16746:
beq_cont.16747:
	lw	r1, 6(r3)
	addi	r8, r1, 1
	lw	r1, 3(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	lw	r7, 1(r3)
	j	try_exploit_neighbors.3244
beq_then.16745:
	add	r30, r5, r1
	lw	r1, 0(r30)
	j	do_without_neighbors.3228
beq_then.16730:
	add	r30, r6, r1
	lw	r1, 0(r30)
	blei	4, r8, ble_then.16748
	jr	r31				#
ble_then.16748:
	lw	r2, 2(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	bgei	0, r2, bge_then.16750
	jr	r31				#
bge_then.16750:
	lw	r2, 3(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	sw	r1, 7(r3)
	sw	r8, 5(r3)
	beqi	0, r2, beq_then.16752
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
	add	r1, r0, r2
	add	r2, r0, r5
	add	r5, r0, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	trace_diffuse_ray_80percent.3215				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r1, r0, 740				# set min_caml_rgb
	lw	r2, 5(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 737				# set min_caml_diffuse_ray
	add	r2, r0, r5
	add	r5, r0, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	vecaccumv.2912				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.16753
beq_then.16752:
beq_cont.16753:
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
	jal	print_int.2857				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	lw	r1, 744(r0)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 255
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
write_rgb_element.3253:
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16754
	addi	r1, r0, 255
	j	ble_cont.16755
ble_then.16754:
	bgei	0, r1, bge_then.16756
	addi	r1, r0, 0
	j	bge_cont.16757
bge_then.16756:
bge_cont.16757:
ble_cont.16755:
	j	print_int.2857
write_rgb.3255:
	flw	f1, 740(r0)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16758
	addi	r1, r0, 255
	j	ble_cont.16759
ble_then.16758:
	bgei	0, r1, bge_then.16760
	addi	r1, r0, 0
	j	bge_cont.16761
bge_then.16760:
bge_cont.16761:
ble_cont.16759:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	flw	f1, 741(r0)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16762
	addi	r1, r0, 255
	j	ble_cont.16763
ble_then.16762:
	bgei	0, r1, bge_then.16764
	addi	r1, r0, 0
	j	bge_cont.16765
bge_then.16764:
bge_cont.16765:
ble_cont.16763:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	flw	f1, 742(r0)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16766
	addi	r1, r0, 255
	j	ble_cont.16767
ble_then.16766:
	bgei	0, r1, bge_then.16768
	addi	r1, r0, 0
	j	bge_cont.16769
bge_then.16768:
bge_cont.16769:
ble_cont.16767:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
pretrace_diffuse_rays.3257:
	blei	4, r2, ble_then.16770
	jr	r31				#
ble_then.16770:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.16772
	jr	r31				#
bge_then.16772:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 0(r3)
	beqi	0, r5, beq_then.16774
	lw	r5, 6(r1)
	lw	r5, 0(r5)
	fsw	f0, 737(r0)
	fsw	f0, 738(r0)
	fsw	f0, 739(r0)
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
	add	r2, r0, r8
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_startp_constants.3108				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r6, r0, 118
	lw	r1, 4(r3)
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_trace_diffuse_rays.3206				
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
	j	beq_cont.16775
beq_then.16774:
beq_cont.16775:
	lw	r2, 0(r3)
	addi	r2, r2, 1
	j	pretrace_diffuse_rays.3257
pretrace_pixels.3260:
	bgei	0, r2, bge_then.16776
	jr	r31				#
bge_then.16776:
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
	add	r2, r0, r7
	add	r1, r0, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	vecunit_sgn.2888				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	fsw	f0, 740(r0)
	fsw	f0, 741(r0)
	fsw	f0, 742(r0)
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
	add	r5, r0, r7
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	trace_ray.3197				
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
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	pretrace_diffuse_rays.3257				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 7(r3)
	addi	r2, r1, -1
	lw	r1, 6(r3)
	addi	r1, r1, 1
	bgei	5, r1, bge_then.16778
	add	r5, r0, r1
	j	bge_cont.16779
bge_then.16778:
	addi	r5, r1, -5
bge_cont.16779:
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
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f2
	fadd	f2, f0, f30
	j	pretrace_pixels.3260
scan_pixel.3271:
	lw	r8, 743(r0)
	ble	r8, r1, ble_then.16780
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
	ble	r8, r9, ble_then.16781
	blei	0, r2, ble_then.16783
	lw	r8, 743(r0)
	addi	r9, r1, 1
	ble	r8, r9, ble_then.16785
	blei	0, r1, ble_then.16787
	addi	r8, r0, 1
	j	ble_cont.16788
ble_then.16787:
	addi	r8, r0, 0
ble_cont.16788:
	j	ble_cont.16786
ble_then.16785:
	addi	r8, r0, 0
ble_cont.16786:
	j	ble_cont.16784
ble_then.16783:
	addi	r8, r0, 0
ble_cont.16784:
	j	ble_cont.16782
ble_then.16781:
	addi	r8, r0, 0
ble_cont.16782:
	sw	r7, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r6, 3(r3)
	sw	r1, 4(r3)
	beqi	0, r8, beq_then.16789
	addi	r8, r0, 0
	add	r30, r6, r1
	lw	r9, 0(r30)
	lw	r10, 2(r9)
	lw	r10, 0(r10)
	bgei	0, r10, bge_then.16791
	j	bge_cont.16792
bge_then.16791:
	add	r30, r6, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	lw	r10, 0(r10)
	add	r30, r5, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16793
	addi	r10, r0, 0
	j	beq_cont.16794
beq_then.16793:
	add	r30, r7, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16795
	addi	r10, r0, 0
	j	beq_cont.16796
beq_then.16795:
	addi	r11, r1, -1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16797
	addi	r10, r0, 0
	j	beq_cont.16798
beq_then.16797:
	addi	r11, r1, 1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16799
	addi	r10, r0, 0
	j	beq_cont.16800
beq_then.16799:
	addi	r10, r0, 1
beq_cont.16800:
beq_cont.16798:
beq_cont.16796:
beq_cont.16794:
	beqi	0, r10, beq_then.16801
	lw	r9, 3(r9)
	lw	r9, 0(r9)
	beqi	0, r9, beq_then.16803
	add	r2, r0, r5
	add	r5, r0, r6
	add	r6, r0, r7
	add	r7, r0, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_diffuse_using_5points.3222				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16804
beq_then.16803:
beq_cont.16804:
	addi	r8, r0, 1
	lw	r1, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	lw	r6, 3(r3)
	lw	r7, 0(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	try_exploit_neighbors.3244				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16802
beq_then.16801:
	add	r30, r6, r1
	lw	r9, 0(r30)
	add	r2, r0, r8
	add	r1, r0, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	do_without_neighbors.3228				
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16802:
bge_cont.16792:
	j	beq_cont.16790
beq_then.16789:
	add	r30, r6, r1
	lw	r8, 0(r30)
	lw	r9, 2(r8)
	lw	r9, 0(r9)
	bgei	0, r9, bge_then.16805
	j	bge_cont.16806
bge_then.16805:
	lw	r9, 3(r8)
	lw	r9, 0(r9)
	sw	r8, 5(r3)
	beqi	0, r9, beq_then.16807
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
	add	r5, r0, r11
	add	r2, r0, r10
	add	r1, r0, r9
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	trace_diffuse_ray_80percent.3215				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 740				# set min_caml_rgb
	lw	r2, 6(r3)
	lw	r2, 0(r2)
	addi	r5, r0, 737				# set min_caml_diffuse_ray
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	vecaccumv.2912				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.16808
beq_then.16807:
beq_cont.16808:
	addi	r2, r0, 1
	lw	r1, 5(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	do_without_neighbors.3228				
	addi	r3, r3, -8
	lw	r31, 7(r3)
bge_cont.16806:
beq_cont.16790:
	flw	f1, 740(r0)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16809
	addi	r1, r0, 255
	j	ble_cont.16810
ble_then.16809:
	bgei	0, r1, bge_then.16811
	addi	r1, r0, 0
	j	bge_cont.16812
bge_then.16811:
bge_cont.16812:
ble_cont.16810:
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_int.2857				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 32
	out	r1
	flw	f1, 741(r0)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16813
	addi	r1, r0, 255
	j	ble_cont.16814
ble_then.16813:
	bgei	0, r1, bge_then.16815
	addi	r1, r0, 0
	j	bge_cont.16816
bge_then.16815:
bge_cont.16816:
ble_cont.16814:
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_int.2857				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 32
	out	r1
	flw	f1, 742(r0)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16817
	addi	r1, r0, 255
	j	ble_cont.16818
ble_then.16817:
	bgei	0, r1, bge_then.16819
	addi	r1, r0, 0
	j	bge_cont.16820
bge_then.16819:
bge_cont.16820:
ble_cont.16818:
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_int.2857				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 10
	out	r1
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 743(r0)
	ble	r2, r1, ble_then.16821
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
	ble	r2, r7, ble_then.16822
	blei	0, r5, ble_then.16824
	lw	r2, 743(r0)
	addi	r7, r1, 1
	ble	r2, r7, ble_then.16826
	blei	0, r1, ble_then.16828
	addi	r2, r0, 1
	j	ble_cont.16829
ble_then.16828:
	addi	r2, r0, 0
ble_cont.16829:
	j	ble_cont.16827
ble_then.16826:
	addi	r2, r0, 0
ble_cont.16827:
	j	ble_cont.16825
ble_then.16824:
	addi	r2, r0, 0
ble_cont.16825:
	j	ble_cont.16823
ble_then.16822:
	addi	r2, r0, 0
ble_cont.16823:
	sw	r1, 7(r3)
	beqi	0, r2, beq_then.16830
	addi	r8, r0, 0
	lw	r2, 1(r3)
	lw	r7, 0(r3)
	add	r28, r0, r5
	add	r5, r0, r2
	add	r2, r0, r28
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	try_exploit_neighbors.3244				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.16831
beq_then.16830:
	add	r30, r6, r1
	lw	r2, 0(r30)
	addi	r7, r0, 0
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	do_without_neighbors.3228				
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.16831:
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	write_rgb.3255				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	lw	r6, 3(r3)
	lw	r7, 0(r3)
	j	scan_pixel.3271
ble_then.16821:
	jr	r31				#
ble_then.16780:
	jr	r31				#
scan_line.3277:
	lw	r8, 744(r0)
	ble	r8, r1, ble_then.16834
	lw	r8, 744(r0)
	addi	r8, r8, -1
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	ble	r8, r1, ble_then.16835
	addi	r8, r1, 1
	add	r5, r0, r7
	add	r2, r0, r8
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	pretrace_line.3267				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	ble_cont.16836
ble_then.16835:
ble_cont.16836:
	addi	r1, r0, 0
	lw	r2, 743(r0)
	blei	0, r2, ble_then.16837
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
	ble	r2, r7, ble_then.16839
	blei	0, r5, ble_then.16841
	lw	r2, 743(r0)
	blei	1, r2, ble_then.16843
	addi	r2, r0, 0
	j	ble_cont.16844
ble_then.16843:
	addi	r2, r0, 0
ble_cont.16844:
	j	ble_cont.16842
ble_then.16841:
	addi	r2, r0, 0
ble_cont.16842:
	j	ble_cont.16840
ble_then.16839:
	addi	r2, r0, 0
ble_cont.16840:
	beqi	0, r2, beq_then.16845
	addi	r8, r0, 0
	lw	r2, 2(r3)
	lw	r7, 1(r3)
	add	r28, r0, r5
	add	r5, r0, r2
	add	r2, r0, r28
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	try_exploit_neighbors.3244				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16846
beq_then.16845:
	lw	r1, 0(r6)
	addi	r2, r0, 0
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	do_without_neighbors.3228				
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16846:
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	write_rgb.3255				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r1, r0, 1
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	lw	r7, 1(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	scan_pixel.3271				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	ble_cont.16838
ble_then.16837:
ble_cont.16838:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	lw	r1, 0(r3)
	addi	r1, r1, 2
	bgei	5, r1, bge_then.16847
	add	r5, r0, r1
	j	bge_cont.16848
bge_then.16847:
	addi	r5, r1, -5
bge_cont.16848:
	lw	r1, 744(r0)
	ble	r1, r2, ble_then.16849
	lw	r1, 744(r0)
	addi	r1, r1, -1
	sw	r5, 5(r3)
	sw	r2, 6(r3)
	ble	r1, r2, ble_then.16851
	addi	r1, r2, 1
	lw	r6, 2(r3)
	add	r2, r0, r1
	add	r1, r0, r6
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	pretrace_line.3267				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	ble_cont.16852
ble_then.16851:
ble_cont.16852:
	addi	r1, r0, 0
	lw	r2, 6(r3)
	lw	r5, 4(r3)
	lw	r6, 1(r3)
	lw	r7, 2(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	scan_pixel.3271				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 5(r3)
	addi	r2, r2, 2
	bgei	5, r2, bge_then.16853
	add	r7, r0, r2
	j	bge_cont.16854
bge_then.16853:
	addi	r7, r2, -5
bge_cont.16854:
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	scan_line.3277				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	ble_cont.16850
ble_then.16849:
ble_cont.16850:
	jr	r31				#
ble_then.16834:
	jr	r31				#
create_float5x3array.3283:
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_create_float_array				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	add	r2, r0, r1
	addi	r1, r0, 5
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_create_array				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	add	r1, r0, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	sw	r1, 1(r2)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	sw	r1, 2(r2)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	sw	r1, 3(r2)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				
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
	jal	lib_create_float_array				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	create_float5x3array.3283				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 1(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 2(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	create_float5x3array.3283				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_float5x3array.3283				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 5(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	create_float5x3array.3283				
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
	bgei	0, r2, bge_then.16857
	jr	r31				#
bge_then.16857:
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	create_float5x3array.3283				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 3(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 4(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3283				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	create_float5x3array.3283				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 7(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	create_float5x3array.3283				
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
	bgei	0, r1, bge_then.16858
	add	r1, r0, r5
	jr	r31				#
bge_then.16858:
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 9(r3)
	add	r1, r0, r2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_float5x3array.3283				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 11(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
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
	sw	r1, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_float5x3array.3283				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 15(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	sw	r1, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3283				
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
	add	r1, r0, r5
	j	init_line_elements.3287
create_pixelline.3290:
	lw	r1, 743(r0)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	add	r1, r0, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	create_float5x3array.3283				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 2(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 3(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_float5x3array.3283				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3283				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 6(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	sw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	create_float5x3array.3283				
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
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 743(r0)
	addi	r2, r2, -2
	bgei	0, r2, bge_then.16859
	jr	r31				#
bge_then.16859:
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 8(r3)
	sw	r1, 9(r3)
	add	r1, r0, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_float5x3array.3283				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 11(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
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
	sw	r1, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_float5x3array.3283				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 15(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	sw	r1, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3283				
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
	add	r1, r0, r5
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
	fadd	f1, f1, f3
	fsqrt	f1, f1
	flup	f3, 2		# fli	f3, 1.000000
	fdiv	f3, f3, f1
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16860
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.16861
fle_else.16860:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.16861:
	fmul	f3, f3, f4
	flup	f5, 23		# fli	f5, 4.375000
	fsw	f1, 0(r3)
	fsw	f2, 2(r3)
	fle	r30, f5, f3
	beq	r0, r30, fle_else.16862
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f3
	beq	r0, r30, fle_else.16864
	flup	f5, 15		# fli	f5, 1.570796
	flup	f6, 2		# fli	f6, 1.000000
	fdiv	f3, f6, f3
	fsw	f4, 4(r3)
	fsw	f5, 6(r3)
	fadd	f1, f0, f3
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	atan_body.2841				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	j	fle_cont.16865
fle_else.16864:
	flup	f5, 16		# fli	f5, 0.785398
	flup	f6, 2		# fli	f6, 1.000000
	fsub	f6, f3, f6
	flup	f7, 2		# fli	f7, 1.000000
	fadd	f3, f3, f7
	fdiv	f3, f6, f3
	fsw	f4, 4(r3)
	fsw	f5, 8(r3)
	fadd	f1, f0, f3
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2841				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
fle_cont.16865:
	j	fle_cont.16863
fle_else.16862:
	fadd	f1, f0, f3
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2841				
	addi	r3, r3, -11
	lw	r31, 10(r3)
fle_cont.16863:
	flw	f2, 2(r3)
	fmul	f1, f1, f2
	fsw	f1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2837				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fsw	f1, 12(r3)
	fadd	f1, f0, f2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	cos.2839				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fdiv	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
calc_dirvec.3297:
	bgei	5, r1, bge_then.16866
	fmul	f1, f2, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f1, f1, f2
	fsqrt	f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f2, f2, f1
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16867
	flup	f5, 2		# fli	f5, 1.000000
	j	fle_cont.16868
fle_else.16867:
	flup	f5, 11		# fli	f5, -1.000000
fle_cont.16868:
	fmul	f2, f2, f5
	flup	f6, 23		# fli	f6, 4.375000
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	fsw	f4, 2(r3)
	sw	r1, 4(r3)
	fsw	f1, 6(r3)
	fsw	f3, 8(r3)
	fle	r30, f6, f2
	beq	r0, r30, fle_else.16870
	flup	f6, 24		# fli	f6, 2.437500
	fle	r30, f6, f2
	beq	r0, r30, fle_else.16872
	flup	f6, 15		# fli	f6, 1.570796
	flup	f7, 2		# fli	f7, 1.000000
	fdiv	f2, f7, f2
	fsw	f5, 10(r3)
	fsw	f6, 12(r3)
	fadd	f1, f0, f2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	atan_body.2841				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fadd	f1, f2, f1
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	j	fle_cont.16873
fle_else.16872:
	flup	f6, 16		# fli	f6, 0.785398
	flup	f7, 2		# fli	f7, 1.000000
	fsub	f7, f2, f7
	flup	f8, 2		# fli	f8, 1.000000
	fadd	f2, f2, f8
	fdiv	f2, f7, f2
	fsw	f5, 10(r3)
	fsw	f6, 14(r3)
	fadd	f1, f0, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2841				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	flw	f2, 10(r3)
	fmul	f1, f1, f2
fle_cont.16873:
	j	fle_cont.16871
fle_else.16870:
	fadd	f1, f0, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2841				
	addi	r3, r3, -17
	lw	r31, 16(r3)
fle_cont.16871:
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	fsw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	sin.2837				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fsw	f1, 18(r3)
	fadd	f1, f0, f2
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	cos.2839				
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
	beq	r0, r30, fle_else.16874
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.16875
fle_else.16874:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.16875:
	fmul	f3, f3, f4
	flup	f5, 23		# fli	f5, 4.375000
	fsw	f1, 20(r3)
	sw	r1, 22(r3)
	fsw	f2, 24(r3)
	fle	r30, f5, f3
	beq	r0, r30, fle_else.16877
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f3
	beq	r0, r30, fle_else.16879
	flup	f5, 15		# fli	f5, 1.570796
	flup	f6, 2		# fli	f6, 1.000000
	fdiv	f3, f6, f3
	fsw	f4, 26(r3)
	fsw	f5, 28(r3)
	fadd	f1, f0, f3
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	atan_body.2841				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	flw	f2, 28(r3)
	fadd	f1, f2, f1
	flw	f2, 26(r3)
	fmul	f1, f1, f2
	j	fle_cont.16880
fle_else.16879:
	flup	f5, 16		# fli	f5, 0.785398
	flup	f6, 2		# fli	f6, 1.000000
	fsub	f6, f3, f6
	flup	f7, 2		# fli	f7, 1.000000
	fadd	f3, f3, f7
	fdiv	f3, f6, f3
	fsw	f4, 26(r3)
	fsw	f5, 30(r3)
	fadd	f1, f0, f3
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	atan_body.2841				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	flw	f2, 30(r3)
	fadd	f1, f2, f1
	flw	f2, 26(r3)
	fmul	f1, f1, f2
fle_cont.16880:
	j	fle_cont.16878
fle_else.16877:
	fadd	f1, f0, f3
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	atan_body.2841				
	addi	r3, r3, -33
	lw	r31, 32(r3)
fle_cont.16878:
	flw	f2, 2(r3)
	fmul	f1, f1, f2
	fsw	f1, 32(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	sin.2837				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flw	f2, 32(r3)
	fsw	f1, 34(r3)
	fadd	f1, f0, f2
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	cos.2839				
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
bge_then.16866:
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
	bgei	0, r1, bge_then.16882
	jr	r31				#
bge_then.16882:
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
	add	r1, r0, r6
	fadd	f30, f0, f4
	fadd	f4, f0, f1
	fadd	f1, f0, f2
	fadd	f2, f0, f30
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_dirvec.3297				
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
	add	r5, r0, r6
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_dirvec.3297				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r1, r1, -1
	lw	r2, 2(r3)
	addi	r2, r2, 1
	bgei	5, r2, bge_then.16884
	j	bge_cont.16885
bge_then.16884:
	addi	r2, r2, -5
bge_cont.16885:
	flw	f1, 0(r3)
	lw	r5, 3(r3)
	j	calc_dirvecs.3305
calc_dirvec_rows.3310:
	bgei	0, r1, bge_then.16886
	jr	r31				#
bge_then.16886:
	itof	f1, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f1, f1, f2
	addi	r6, r0, 4
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	calc_dirvecs.3305				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r1, r1, -1
	lw	r2, 1(r3)
	addi	r2, r2, 2
	bgei	5, r2, bge_then.16888
	j	bge_cont.16889
bge_then.16888:
	addi	r2, r2, -5
bge_cont.16889:
	lw	r5, 0(r3)
	addi	r5, r5, 4
	bgei	0, r1, bge_then.16890
	jr	r31				#
bge_then.16890:
	itof	f1, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f1, f1, f2
	addi	r6, r0, 4
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	add	r1, r0, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_dirvecs.3305				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, -1
	lw	r2, 4(r3)
	addi	r2, r2, 2
	bgei	5, r2, bge_then.16892
	j	bge_cont.16893
bge_then.16892:
	addi	r2, r2, -5
bge_cont.16893:
	lw	r5, 3(r3)
	addi	r5, r5, 4
	j	calc_dirvec_rows.3310
create_dirvec.3314:
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_create_float_array				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_array				
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
	bgei	0, r2, bge_then.16894
	jr	r31				#
bge_then.16894:
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
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
	bgei	0, r1, bge_then.16896
	jr	r31				#
bge_then.16896:
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_float_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				
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
	bgei	0, r1, bge_then.16898
	jr	r31				#
bge_then.16898:
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 5(r3)
	add	r1, r0, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
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
	bgei	0, r1, bge_then.16900
	jr	r31				#
bge_then.16900:
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 7(r3)
	add	r1, r0, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_float_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				
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
	add	r1, r0, r5
	j	create_dirvec_elements.3316
create_dirvecs.3319:
	bgei	0, r1, bge_then.16902
	jr	r31				#
bge_then.16902:
	addi	r2, r0, 766				# set min_caml_dirvecs
	addi	r5, r0, 120
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r5, 2(r3)
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
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
	jal	lib_create_array				
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
	add	r1, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_float_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				
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
	jal	lib_create_float_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
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
	jal	lib_create_float_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
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
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	create_dirvec_elements.3316				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.16904
	jr	r31				#
bge_then.16904:
	addi	r2, r0, 766				# set min_caml_dirvecs
	addi	r5, r0, 120
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 8(r3)
	sw	r2, 9(r3)
	sw	r5, 10(r3)
	add	r1, r0, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_float_array				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 11(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
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
	jal	lib_create_array				
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
	add	r1, r0, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_array				
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
	jal	lib_create_float_array				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_array				
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
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_dirvec_elements.3316				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r1, 8(r3)
	addi	r1, r1, -1
	j	create_dirvecs.3319
init_dirvec_constants.3321:
	bgei	0, r2, bge_then.16906
	jr	r31				#
bge_then.16906:
	add	r30, r1, r2
	lw	r5, 0(r30)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.16908
	jr	r31				#
bge_then.16908:
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r1, 2(r3)
	bgei	0, r6, bge_then.16910
	j	bge_cont.16911
bge_then.16910:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 3(r3)
	beqi	1, r10, beq_then.16912
	beqi	2, r10, beq_then.16914
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	add	r2, r0, r7
	add	r1, r0, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_second_table.3100				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16915
beq_then.16914:
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	add	r2, r0, r7
	add	r1, r0, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_surface_table.3097				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16915:
	j	beq_cont.16913
beq_then.16912:
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	add	r2, r0, r7
	add	r1, r0, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_rect_table.3094				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16913:
	addi	r2, r2, -1
	lw	r1, 3(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -7
	lw	r31, 6(r3)
bge_cont.16911:
	lw	r1, 2(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.16916
	jr	r31				#
bge_then.16916:
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r1, 6(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.16918
	jr	r31				#
bge_then.16918:
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r1, 7(r3)
	bgei	0, r6, bge_then.16920
	j	bge_cont.16921
bge_then.16920:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 8(r3)
	beqi	1, r10, beq_then.16922
	beqi	2, r10, beq_then.16924
	sw	r6, 9(r3)
	sw	r8, 10(r3)
	add	r2, r0, r7
	add	r1, r0, r9
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_second_table.3100				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16925
beq_then.16924:
	sw	r6, 9(r3)
	sw	r8, 10(r3)
	add	r2, r0, r7
	add	r1, r0, r9
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_surface_table.3097				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16925:
	j	beq_cont.16923
beq_then.16922:
	sw	r6, 9(r3)
	sw	r8, 10(r3)
	add	r2, r0, r7
	add	r1, r0, r9
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_rect_table.3094				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16923:
	addi	r2, r2, -1
	lw	r1, 8(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -12
	lw	r31, 11(r3)
bge_cont.16921:
	lw	r1, 7(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	j	init_dirvec_constants.3321
init_vecset_constants.3324:
	bgei	0, r1, bge_then.16926
	jr	r31				#
bge_then.16926:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 119(r2)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	bgei	0, r6, bge_then.16928
	j	bge_cont.16929
bge_then.16928:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 2(r3)
	beqi	1, r10, beq_then.16930
	beqi	2, r10, beq_then.16932
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r2, r0, r7
	add	r1, r0, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3100				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16933
beq_then.16932:
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r2, r0, r7
	add	r1, r0, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3097				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16933:
	j	beq_cont.16931
beq_then.16930:
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r2, r0, r7
	add	r1, r0, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3094				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16931:
	addi	r2, r2, -1
	lw	r1, 2(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -6
	lw	r31, 5(r3)
bge_cont.16929:
	lw	r1, 1(r3)
	lw	r2, 118(r1)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 1(r3)
	lw	r2, 117(r1)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	bgei	0, r5, bge_then.16934
	j	bge_cont.16935
bge_then.16934:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 5(r3)
	beqi	1, r9, beq_then.16936
	beqi	2, r9, beq_then.16938
	sw	r5, 6(r3)
	sw	r7, 7(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_second_table.3100				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16939
beq_then.16938:
	sw	r5, 6(r3)
	sw	r7, 7(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_surface_table.3097				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16939:
	j	beq_cont.16937
beq_then.16936:
	sw	r5, 6(r3)
	sw	r7, 7(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_rect_table.3094				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16937:
	addi	r2, r2, -1
	lw	r1, 5(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -9
	lw	r31, 8(r3)
bge_cont.16935:
	addi	r2, r0, 116
	lw	r1, 1(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.16940
	jr	r31				#
bge_then.16940:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 119(r2)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r1, 8(r3)
	sw	r2, 9(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 9(r3)
	lw	r2, 118(r1)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	bgei	0, r5, bge_then.16942
	j	bge_cont.16943
bge_then.16942:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 10(r3)
	beqi	1, r9, beq_then.16944
	beqi	2, r9, beq_then.16946
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_second_table.3100				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16947
beq_then.16946:
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_surface_table.3097				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16947:
	j	beq_cont.16945
beq_then.16944:
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_rect_table.3094				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16945:
	addi	r2, r2, -1
	lw	r1, 10(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -14
	lw	r31, 13(r3)
bge_cont.16943:
	addi	r2, r0, 117
	lw	r1, 9(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 8(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.16948
	jr	r31				#
bge_then.16948:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 119(r2)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r1, 13(r3)
	sw	r2, 14(r3)
	bgei	0, r6, bge_then.16950
	j	bge_cont.16951
bge_then.16950:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 15(r3)
	beqi	1, r10, beq_then.16952
	beqi	2, r10, beq_then.16954
	sw	r6, 16(r3)
	sw	r8, 17(r3)
	add	r2, r0, r7
	add	r1, r0, r9
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_second_table.3100				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16955
beq_then.16954:
	sw	r6, 16(r3)
	sw	r8, 17(r3)
	add	r2, r0, r7
	add	r1, r0, r9
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_surface_table.3097				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16955:
	j	beq_cont.16953
beq_then.16952:
	sw	r6, 16(r3)
	sw	r8, 17(r3)
	add	r2, r0, r7
	add	r1, r0, r9
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_rect_table.3094				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16953:
	addi	r2, r2, -1
	lw	r1, 15(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -19
	lw	r31, 18(r3)
bge_cont.16951:
	addi	r2, r0, 118
	lw	r1, 14(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r1, 13(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.16956
	jr	r31				#
bge_then.16956:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r2, 0(r30)
	addi	r5, r0, 119
	sw	r1, 18(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	init_dirvec_constants.3321				
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
	add	r1, r0, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				
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
	jal	lib_create_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r1, 770(r0)
	lw	r1, 770(r0)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 2(r3)
	add	r1, r0, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
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
	jal	lib_create_float_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				
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
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_dirvec_elements.3316				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r1, r0, 3
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_dirvecs.3319				
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
	jal	calc_dirvecs.3305				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r1, r0, 8
	addi	r2, r0, 2
	addi	r5, r0, 4
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_dirvec_rows.3310				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 770(r0)
	lw	r2, 119(r1)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	sw	r1, 5(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	lw	r2, 118(r1)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	bgei	0, r5, bge_then.16958
	j	bge_cont.16959
bge_then.16958:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 6(r3)
	beqi	1, r9, beq_then.16960
	beqi	2, r9, beq_then.16962
	sw	r5, 7(r3)
	sw	r7, 8(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_second_table.3100				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16963
beq_then.16962:
	sw	r5, 7(r3)
	sw	r7, 8(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_surface_table.3097				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16963:
	j	beq_cont.16961
beq_then.16960:
	sw	r5, 7(r3)
	sw	r7, 8(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_rect_table.3094				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16961:
	addi	r2, r2, -1
	lw	r1, 6(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -10
	lw	r31, 9(r3)
bge_cont.16959:
	addi	r2, r0, 117
	lw	r1, 5(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 769(r0)
	lw	r2, 119(r1)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	sw	r1, 9(r3)
	bgei	0, r5, bge_then.16964
	j	bge_cont.16965
bge_then.16964:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 10(r3)
	beqi	1, r9, beq_then.16966
	beqi	2, r9, beq_then.16968
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_second_table.3100				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16969
beq_then.16968:
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_surface_table.3097				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16969:
	j	beq_cont.16967
beq_then.16966:
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_rect_table.3094				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16967:
	addi	r2, r2, -1
	lw	r1, 10(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -14
	lw	r31, 13(r3)
bge_cont.16965:
	addi	r2, r0, 118
	lw	r1, 9(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 768(r0)
	addi	r2, r0, 119
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	init_dirvec_constants.3321				
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
	add	r1, r0, r5
	fadd	f1, f0, f5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				
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
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	iter_setup_dirvec_constants.3103				
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
	add	r1, r0, r6
	fadd	f1, f0, f6
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_float_array				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_array				
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
	bgei	0, r6, bge_then.16972
	j	bge_cont.16973
bge_then.16972:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.16974
	beqi	2, r8, beq_then.16976
	sw	r6, 16(r3)
	sw	r1, 17(r3)
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_second_table.3100				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16977
beq_then.16976:
	sw	r6, 16(r3)
	sw	r1, 17(r3)
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_surface_table.3097				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16977:
	j	beq_cont.16975
beq_then.16974:
	sw	r6, 16(r3)
	sw	r1, 17(r3)
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_rect_table.3094				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16975:
	addi	r2, r2, -1
	lw	r1, 15(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -19
	lw	r31, 18(r3)
bge_cont.16973:
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
	add	r1, r0, r7
	fadd	f1, f0, f3
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_float_array				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 22(r3)
	sw	r31, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				
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
	bgei	0, r6, bge_then.16978
	j	bge_cont.16979
bge_then.16978:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.16980
	beqi	2, r8, beq_then.16982
	sw	r6, 24(r3)
	sw	r1, 25(r3)
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_second_table.3100				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 24(r3)
	lw	r5, 25(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16983
beq_then.16982:
	sw	r6, 24(r3)
	sw	r1, 25(r3)
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_surface_table.3097				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 24(r3)
	lw	r5, 25(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16983:
	j	beq_cont.16981
beq_then.16980:
	sw	r6, 24(r3)
	sw	r1, 25(r3)
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_rect_table.3094				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 24(r3)
	lw	r5, 25(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16981:
	addi	r2, r2, -1
	lw	r1, 23(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -27
	lw	r31, 26(r3)
bge_cont.16979:
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
	add	r1, r0, r6
	fadd	f1, f0, f3
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	lib_create_float_array				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 30(r3)
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				
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
	bgei	0, r6, bge_then.16984
	j	bge_cont.16985
bge_then.16984:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.16986
	beqi	2, r8, beq_then.16988
	sw	r6, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_second_table.3100				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16989
beq_then.16988:
	sw	r6, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_surface_table.3097				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16989:
	j	beq_cont.16987
beq_then.16986:
	sw	r6, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_rect_table.3094				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16987:
	addi	r2, r2, -1
	lw	r1, 31(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -35
	lw	r31, 34(r3)
bge_cont.16985:
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
	add	r1, r0, r2
	fadd	f1, f0, f5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				
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
	bgei	0, r6, bge_then.16991
	j	bge_cont.16992
bge_then.16991:
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.16993
	beqi	2, r8, beq_then.16995
	sw	r6, 12(r3)
	sw	r1, 13(r3)
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_second_table.3100				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16996
beq_then.16995:
	sw	r6, 12(r3)
	sw	r1, 13(r3)
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_surface_table.3097				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16996:
	j	beq_cont.16994
beq_then.16993:
	sw	r6, 12(r3)
	sw	r1, 13(r3)
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_rect_table.3094				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16994:
	addi	r2, r2, -1
	lw	r1, 11(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -15
	lw	r31, 14(r3)
bge_cont.16992:
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
	bgei	0, r1, bge_then.16998
	jr	r31				#
bge_then.16998:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.17000
	jr	r31				#
beq_then.17000:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 7(r2)
	flw	f2, 0(r5)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17002
	jr	r31				#
fle_else.17002:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.17004
	beqi	2, r5, beq_then.17005
	jr	r31				#
beq_then.17005:
	j	setup_surface_reflection.3338
beq_then.17004:
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
	add	r1, r0, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	create_float5x3array.3283				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 2(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 3(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_float5x3array.3283				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3283				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 6(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	sw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	create_float5x3array.3283				
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
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 743(r0)
	addi	r2, r2, -2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	init_line_elements.3287				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 743(r0)
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 8(r3)
	sw	r2, 9(r3)
	add	r1, r0, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_float5x3array.3283				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 11(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
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
	sw	r1, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_float5x3array.3283				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 15(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	sw	r1, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3283				
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
	jal	lib_create_array				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r2, 743(r0)
	addi	r2, r2, -2
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	init_line_elements.3287				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r2, 743(r0)
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 17(r3)
	sw	r2, 18(r3)
	add	r1, r0, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	lib_create_float_array				
	addi	r3, r3, -20
	lw	r31, 19(r3)
	sw	r1, 19(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	create_float5x3array.3283				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 20(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_array				
	addi	r3, r3, -22
	lw	r31, 21(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 21(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_array				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	sw	r1, 22(r3)
	sw	r31, 23(r3)
	addi	r3, r3, 24
	jal	create_float5x3array.3283				
	addi	r3, r3, -24
	lw	r31, 23(r3)
	sw	r1, 23(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	create_float5x3array.3283				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 24(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	lib_create_array				
	addi	r3, r3, -26
	lw	r31, 25(r3)
	sw	r1, 25(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	create_float5x3array.3283				
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
	jal	lib_create_array				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 743(r0)
	addi	r2, r2, -2
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	init_line_elements.3287				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	sw	r1, 26(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	read_screen_settings.2989				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	read_light.2991				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r1, r0, 0
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	read_nth_object.2996				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	beqi	0, r1, beq_then.17007
	addi	r1, r0, 1
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	read_object.2998				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	j	beq_cont.17008
beq_then.17007:
	sw	r0, 0(r0)
beq_cont.17008:
	addi	r1, r0, 0
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	read_and_network.3006				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r1, r0, 0
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	read_or_network.3004				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	sw	r1, 723(r0)
	addi	r1, r0, 80
	out	r1
	addi	r1, r0, 51
	out	r1
	addi	r1, r0, 10
	out	r1
	lw	r1, 743(r0)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	print_int.2857				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r1, r0, 32
	out	r1
	lw	r1, 744(r0)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	print_int.2857				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 255
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	print_int.2857				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r1, r0, 10
	out	r1
	addi	r1, r0, 4
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	create_dirvecs.3319				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	calc_dirvec_rows.3310				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	lw	r1, 770(r0)
	lw	r2, 119(r1)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	sw	r1, 27(r3)
	bgei	0, r5, bge_then.17009
	j	bge_cont.17010
bge_then.17009:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 28(r3)
	beqi	1, r9, beq_then.17011
	beqi	2, r9, beq_then.17013
	sw	r5, 29(r3)
	sw	r7, 30(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	setup_second_table.3100				
	addi	r3, r3, -32
	lw	r31, 31(r3)
	lw	r2, 29(r3)
	lw	r5, 30(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17014
beq_then.17013:
	sw	r5, 29(r3)
	sw	r7, 30(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	setup_surface_table.3097				
	addi	r3, r3, -32
	lw	r31, 31(r3)
	lw	r2, 29(r3)
	lw	r5, 30(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17014:
	j	beq_cont.17012
beq_then.17011:
	sw	r5, 29(r3)
	sw	r7, 30(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	setup_rect_table.3094				
	addi	r3, r3, -32
	lw	r31, 31(r3)
	lw	r2, 29(r3)
	lw	r5, 30(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17012:
	addi	r2, r2, -1
	lw	r1, 28(r3)
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -32
	lw	r31, 31(r3)
bge_cont.17010:
	addi	r2, r0, 118
	lw	r1, 27(r3)
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -32
	lw	r31, 31(r3)
	lw	r1, 769(r0)
	addi	r2, r0, 119
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -32
	lw	r31, 31(r3)
	addi	r1, r0, 2
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	init_vecset_constants.3324				
	addi	r3, r3, -32
	lw	r31, 31(r3)
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
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -32
	lw	r31, 31(r3)
	lw	r1, 0(r0)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.17015
	j	bge_cont.17016
bge_then.17015:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.17017
	j	beq_cont.17018
beq_then.17017:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 7(r2)
	flw	f2, 0(r5)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17019
	j	fle_cont.17020
fle_else.17019:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.17021
	beqi	2, r5, beq_then.17023
	j	beq_cont.17024
beq_then.17023:
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	setup_surface_reflection.3338				
	addi	r3, r3, -32
	lw	r31, 31(r3)
beq_cont.17024:
	j	beq_cont.17022
beq_then.17021:
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	setup_rect_reflection.3335				
	addi	r3, r3, -32
	lw	r31, 31(r3)
beq_cont.17022:
fle_cont.17020:
beq_cont.17018:
bge_cont.17016:
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r1, 17(r3)
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	pretrace_line.3267				
	addi	r3, r3, -32
	lw	r31, 31(r3)
	addi	r2, r0, 0
	addi	r5, r0, 2
	lw	r1, 744(r0)
	blei	0, r1, ble_then.17025
	lw	r1, 744(r0)
	addi	r1, r1, -1
	sw	r2, 31(r3)
	blei	0, r1, ble_then.17026
	addi	r1, r0, 1
	lw	r6, 26(r3)
	add	r2, r0, r1
	add	r1, r0, r6
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	pretrace_line.3267				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	j	ble_cont.17027
ble_then.17026:
ble_cont.17027:
	addi	r1, r0, 0
	lw	r2, 31(r3)
	lw	r5, 8(r3)
	lw	r6, 17(r3)
	lw	r7, 26(r3)
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	scan_pixel.3271				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	addi	r1, r0, 1
	addi	r7, r0, 4
	lw	r2, 17(r3)
	lw	r5, 26(r3)
	lw	r6, 8(r3)
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	scan_line.3277				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	jr	r31				#
ble_then.17025:
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
	jal	rt.3343				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	_R_0, r0, 0
