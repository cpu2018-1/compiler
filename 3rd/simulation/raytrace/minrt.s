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
	finv	f31, f4
	fmul	f2, f2, f31
	j lib_fuga
_fle_else.742:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
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
	jal lib_hoge				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f2, f0, f1
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
	jal lib_modulo_2pi				
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
	jal lib_sin_body				
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
	jal lib_cos_body				
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
	jal lib_sin_body				
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
	jal lib_cos_body				
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
	jal lib_sin_body				
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
	jal lib_cos_body				
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
	jal lib_sin_body				
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
	jal lib_cos_body				
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
	jal lib_modulo_2pi				
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
	jal lib_cos_body				
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
	jal lib_sin_body				
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
	jal lib_cos_body				
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
	jal lib_sin_body				
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
	jal lib_cos_body				
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
	jal lib_sin_body				
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
	jal lib_cos_body				
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
	jal lib_sin_body				
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
	finv	f31, f1
	fmul	f1, f4, f31
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal lib_atan_body				
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
	finv	f31, f1
	fmul	f1, f4, f31
	fsw	f2, 0(r3)
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_atan_body				
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
	add	r5, r0, r6
	j lib_div10_sub
_ble_then.770:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, _ble_then.771
	add	r2, r0, r6
	j lib_div10_sub
_ble_then.771:
	add	r1, r0, r6
	jr	r31				#
lib_div10:
	addi	r2, r0, 0
	add	r5, r0, r1
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
	add	r2, r0, r5
	add	r5, r0, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal lib_div10_sub				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	addi	r2, r2, -1
	j lib_iter_div10
_beq_then.773:
	jr	r31				#
lib_keta_sub:
	bgei	10, r1, bge_then.774
	addi	r1, r2, 1
	jr	r31				#
bge_then.774:
	addi	r5, r0, 0
	sw	r2, 0(r3)
	add	r2, r0, r5
	add	r5, r0, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal lib_div10_sub				
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
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_iter_mul10				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	ble	r1, r2, _ble_then.776
	addi	r1, r0, 48
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 0(r3)
	addi	r2, r1, -1
	lw	r1, 1(r3)
	j lib_print_uint_keta
_ble_then.776:
	lw	r1, 0(r3)
	addi	r5, r1, -1
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_iter_div10				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r2, r1, 48
	sw	r1, 2(r3)
	add	r1, r0, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_print_char				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 0(r3)
	addi	r2, r1, -1
	lw	r5, 2(r3)
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal lib_iter_mul10				
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
	bgei	10, r1, bge_then.777
	addi	r1, r1, 48
	j	lib_print_char
bge_then.777:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	add	r5, r0, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal lib_div10_sub				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_print_uint				
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
	bgei	0, r1, bge_then.778
	addi	r2, r0, 45
	sw	r1, 0(r3)
	add	r1, r0, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_print_char				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	sub	r1, r0, r1
	j lib_print_uint
bge_then.778:
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
	jal lib_print_int				
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
	jal lib_print_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r1, r0, 46
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_print_char				
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
	jal	lib_print_char				
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
	beq	r0, r30, fle_else.15834
	addi	r1, r0, 0
	jr	r31				#
fle_else.15834:
	addi	r1, r0, 1
	jr	r31				#
fisneg.2805:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15835
	addi	r1, r0, 0
	jr	r31				#
fle_else.15835:
	addi	r1, r0, 1
	jr	r31				#
fiszero.2807:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15836
	addi	r1, r0, 1
	jr	r31				#
feq_else.15836:
	addi	r1, r0, 0
	jr	r31				#
xor.2809:
	beq	r1, r2, beq_then.15837
	addi	r1, r0, 1
	jr	r31				#
beq_then.15837:
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
	beq	r0, r30, fle_else.15838
	jr	r31				#
fle_else.15838:
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
	beq	r0, r30, fle_else.15839
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15839:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
	jr	r31				#
hoge.2824:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15840
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15841
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15842
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15843
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15844
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15845
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15846
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15847
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15848
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15849
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15850
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15851
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15852
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15853
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15854
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15855
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2824
fle_else.15855:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15854:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15853:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15852:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15851:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15850:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15849:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15848:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15847:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15846:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15845:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15844:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15843:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15842:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15841:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15840:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2827:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15856
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15857
	fsub	f4, f1, f2
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	flup	f1, 3		# fli	f1, 2.000000
	fmul	f1, f3, f1
	fle	r30, f1, f4
	beq	r0, r30, fle_else.15858
	fle	r30, f2, f4
	beq	r0, r30, fle_else.15859
	fsub	f4, f4, f2
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f1, f2, f31
	fadd	f2, f0, f1
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.15859:
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f1, f2, f31
	fadd	f2, f0, f1
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.15858:
	fadd	f1, f0, f4
	jr	r31				#
fle_else.15857:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15860
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15861
	fsub	f4, f1, f2
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f1, f2, f31
	fadd	f2, f0, f1
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.15861:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	j	fuga.2827
fle_else.15860:
	jr	r31				#
fle_else.15856:
	jr	r31				#
modulo_2pi.2831:
	flup	f2, 14		# fli	f2, 3.141593
	flup	f4, 5		# fli	f4, 6.283186
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15862
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15864
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15866
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15868
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15870
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15872
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15874
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15876
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15878
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15880
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15882
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15884
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15886
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15888
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15890
	addi	r30, r0, 4060
	lui	r30, r30, 18505	# to load float		205887.438848
	fmvfr	f2, r30
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	hoge.2824				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	fadd	f3, f0, f1
	j	fle_cont.15891
fle_else.15890:
	fadd	f3, f0, f2
fle_cont.15891:
	j	fle_cont.15889
fle_else.15888:
	fadd	f3, f0, f2
fle_cont.15889:
	j	fle_cont.15887
fle_else.15886:
	fadd	f3, f0, f2
fle_cont.15887:
	j	fle_cont.15885
fle_else.15884:
	fadd	f3, f0, f2
fle_cont.15885:
	j	fle_cont.15883
fle_else.15882:
	fadd	f3, f0, f2
fle_cont.15883:
	j	fle_cont.15881
fle_else.15880:
	fadd	f3, f0, f2
fle_cont.15881:
	j	fle_cont.15879
fle_else.15878:
	fadd	f3, f0, f2
fle_cont.15879:
	j	fle_cont.15877
fle_else.15876:
	fadd	f3, f0, f2
fle_cont.15877:
	j	fle_cont.15875
fle_else.15874:
	fadd	f3, f0, f2
fle_cont.15875:
	j	fle_cont.15873
fle_else.15872:
	fadd	f3, f0, f2
fle_cont.15873:
	j	fle_cont.15871
fle_else.15870:
	fadd	f3, f0, f2
fle_cont.15871:
	j	fle_cont.15869
fle_else.15868:
	fadd	f3, f0, f2
fle_cont.15869:
	j	fle_cont.15867
fle_else.15866:
	fadd	f3, f0, f2
fle_cont.15867:
	j	fle_cont.15865
fle_else.15864:
	fadd	f3, f0, f2
fle_cont.15865:
	j	fle_cont.15863
fle_else.15862:
	fadd	f3, f0, f4
fle_cont.15863:
	flup	f4, 5		# fli	f4, 6.283186
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15892
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15893
	fsub	f4, f1, f3
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f1, f3, f31
	fadd	f3, f0, f2
	fadd	f2, f0, f1
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.15893:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f3, f3, f31
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f30
	j	fuga.2827
fle_else.15892:
	jr	r31				#
sin_body.2833:
	fmul	f2, f1, f1
	flup	f3, 6		# fli	f3, 0.166667
	fmul	f3, f3, f1
	fmul	f3, f3, f2
	fsub	f4, f1, f3
	flup	f3, 7		# fli	f3, 0.008333
	fmul	f3, f3, f1
	fmul	f3, f3, f2
	fmul	f3, f3, f2
	fadd	f4, f4, f3
	flup	f3, 8		# fli	f3, 0.000196
	fmul	f1, f3, f1
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fmul	f1, f1, f2
	fsub	f1, f4, f1
	jr	r31				#
cos_body.2835:
	fmul	f1, f1, f1
	flup	f5, 2		# fli	f5, 1.000000
	flup	f4, 1		# fli	f4, 0.500000
	flup	f3, 9		# fli	f3, 0.041664
	flup	f2, 10		# fli	f2, 0.001370
	fmul	f2, f1, f2
	fsub	f2, f3, f2
	fmul	f2, f1, f2
	fsub	f2, f4, f2
	fmul	f1, f1, f2
	fsub	f1, f5, f1
	jr	r31				#
sin.2837:
	flup	f3, 14		# fli	f3, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15894
	flup	f5, 2		# fli	f5, 1.000000
	j	fle_cont.15895
fle_else.15894:
	flup	f5, 11		# fli	f5, -1.000000
fle_cont.15895:
	fsw	f3, 0(r3)
	fsw	f5, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f6, f0, f1
	flw	f3, 0(r3)
	flw	f5, 2(r3)
	flup	f1, 14		# fli	f1, 3.141593
	flup	f4, 5		# fli	f4, 6.283186
	fle	r30, f4, f6
	beq	r0, r30, fle_else.15896
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15898
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15900
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15902
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15904
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15906
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15908
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15910
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15912
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15914
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15916
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15918
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15920
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15922
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f1, r30
	fadd	f2, f0, f1
	fadd	f1, f0, f6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	hoge.2824				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f2, f0, f1
	j	fle_cont.15923
fle_else.15922:
	fadd	f2, f0, f1
fle_cont.15923:
	j	fle_cont.15921
fle_else.15920:
	fadd	f2, f0, f1
fle_cont.15921:
	j	fle_cont.15919
fle_else.15918:
	fadd	f2, f0, f1
fle_cont.15919:
	j	fle_cont.15917
fle_else.15916:
	fadd	f2, f0, f1
fle_cont.15917:
	j	fle_cont.15915
fle_else.15914:
	fadd	f2, f0, f1
fle_cont.15915:
	j	fle_cont.15913
fle_else.15912:
	fadd	f2, f0, f1
fle_cont.15913:
	j	fle_cont.15911
fle_else.15910:
	fadd	f2, f0, f1
fle_cont.15911:
	j	fle_cont.15909
fle_else.15908:
	fadd	f2, f0, f1
fle_cont.15909:
	j	fle_cont.15907
fle_else.15906:
	fadd	f2, f0, f1
fle_cont.15907:
	j	fle_cont.15905
fle_else.15904:
	fadd	f2, f0, f1
fle_cont.15905:
	j	fle_cont.15903
fle_else.15902:
	fadd	f2, f0, f1
fle_cont.15903:
	j	fle_cont.15901
fle_else.15900:
	fadd	f2, f0, f1
fle_cont.15901:
	j	fle_cont.15899
fle_else.15898:
	fadd	f2, f0, f1
fle_cont.15899:
	j	fle_cont.15897
fle_else.15896:
	fadd	f2, f0, f4
fle_cont.15897:
	fadd	f3, f0, f1
	fadd	f1, f0, f6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	fuga.2827				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f2, f0, f1
	flw	f3, 0(r3)
	flw	f5, 2(r3)
	fle	r30, f3, f2
	beq	r0, r30, fle_else.15924
	fsub	f2, f2, f3
	fneg	f4, f5
	flup	f1, 15		# fli	f1, 1.570796
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15925
	fsub	f2, f3, f2
	flup	f1, 16		# fli	f1, 0.785398
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15926
	fmul	f1, f2, f2
	flup	f3, 6		# fli	f3, 0.166667
	fmul	f3, f3, f2
	fmul	f3, f3, f1
	fsub	f5, f2, f3
	flup	f3, 7		# fli	f3, 0.008333
	fmul	f3, f3, f2
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fadd	f5, f5, f3
	flup	f3, 8		# fli	f3, 0.000196
	fmul	f2, f3, f2
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fmul	f1, f2, f1
	fsub	f1, f5, f1
	fmul	f1, f1, f4
	jr	r31				#
fle_else.15926:
	flup	f1, 15		# fli	f1, 1.570796
	fsub	f1, f1, f2
	fmul	f1, f1, f1
	flup	f6, 2		# fli	f6, 1.000000
	flup	f5, 1		# fli	f5, 0.500000
	flup	f3, 9		# fli	f3, 0.041664
	flup	f2, 10		# fli	f2, 0.001370
	fmul	f2, f1, f2
	fsub	f2, f3, f2
	fmul	f2, f1, f2
	fsub	f2, f5, f2
	fmul	f1, f1, f2
	fsub	f1, f6, f1
	fmul	f1, f1, f4
	jr	r31				#
fle_else.15925:
	flup	f1, 16		# fli	f1, 0.785398
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15927
	fmul	f1, f2, f2
	flup	f3, 6		# fli	f3, 0.166667
	fmul	f3, f3, f2
	fmul	f3, f3, f1
	fsub	f5, f2, f3
	flup	f3, 7		# fli	f3, 0.008333
	fmul	f3, f3, f2
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fadd	f5, f5, f3
	flup	f3, 8		# fli	f3, 0.000196
	fmul	f2, f3, f2
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fmul	f1, f2, f1
	fsub	f1, f5, f1
	fmul	f1, f1, f4
	jr	r31				#
fle_else.15927:
	flup	f1, 15		# fli	f1, 1.570796
	fsub	f1, f1, f2
	fmul	f1, f1, f1
	flup	f6, 2		# fli	f6, 1.000000
	flup	f5, 1		# fli	f5, 0.500000
	flup	f3, 9		# fli	f3, 0.041664
	flup	f2, 10		# fli	f2, 0.001370
	fmul	f2, f1, f2
	fsub	f2, f3, f2
	fmul	f2, f1, f2
	fsub	f2, f5, f2
	fmul	f1, f1, f2
	fsub	f1, f6, f1
	fmul	f1, f1, f4
	jr	r31				#
fle_else.15924:
	flup	f1, 15		# fli	f1, 1.570796
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15928
	fsub	f2, f3, f2
	flup	f1, 16		# fli	f1, 0.785398
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15929
	fmul	f1, f2, f2
	flup	f3, 6		# fli	f3, 0.166667
	fmul	f3, f3, f2
	fmul	f3, f3, f1
	fsub	f4, f2, f3
	flup	f3, 7		# fli	f3, 0.008333
	fmul	f3, f3, f2
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fadd	f4, f4, f3
	flup	f3, 8		# fli	f3, 0.000196
	fmul	f2, f3, f2
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fmul	f1, f2, f1
	fsub	f1, f4, f1
	fmul	f1, f1, f5
	jr	r31				#
fle_else.15929:
	flup	f1, 15		# fli	f1, 1.570796
	fsub	f1, f1, f2
	fmul	f1, f1, f1
	flup	f6, 2		# fli	f6, 1.000000
	flup	f4, 1		# fli	f4, 0.500000
	flup	f3, 9		# fli	f3, 0.041664
	flup	f2, 10		# fli	f2, 0.001370
	fmul	f2, f1, f2
	fsub	f2, f3, f2
	fmul	f2, f1, f2
	fsub	f2, f4, f2
	fmul	f1, f1, f2
	fsub	f1, f6, f1
	fmul	f1, f1, f5
	jr	r31				#
fle_else.15928:
	flup	f1, 16		# fli	f1, 0.785398
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15930
	fmul	f1, f2, f2
	flup	f3, 6		# fli	f3, 0.166667
	fmul	f3, f3, f2
	fmul	f3, f3, f1
	fsub	f4, f2, f3
	flup	f3, 7		# fli	f3, 0.008333
	fmul	f3, f3, f2
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fadd	f4, f4, f3
	flup	f3, 8		# fli	f3, 0.000196
	fmul	f2, f3, f2
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fmul	f1, f2, f1
	fsub	f1, f4, f1
	fmul	f1, f1, f5
	jr	r31				#
fle_else.15930:
	flup	f1, 15		# fli	f1, 1.570796
	fsub	f1, f1, f2
	fmul	f1, f1, f1
	flup	f6, 2		# fli	f6, 1.000000
	flup	f4, 1		# fli	f4, 0.500000
	flup	f3, 9		# fli	f3, 0.041664
	flup	f2, 10		# fli	f2, 0.001370
	fmul	f2, f1, f2
	fsub	f2, f3, f2
	fmul	f2, f1, f2
	fsub	f2, f4, f2
	fmul	f1, f1, f2
	fsub	f1, f6, f1
	fmul	f1, f1, f5
	jr	r31				#
cos.2839:
	flup	f2, 14		# fli	f2, 3.141593
	flup	f5, 2		# fli	f5, 1.000000
	fsw	f2, 0(r3)
	fsw	f5, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f6, f0, f1
	flw	f2, 0(r3)
	flw	f5, 2(r3)
	flup	f1, 14		# fli	f1, 3.141593
	flup	f4, 5		# fli	f4, 6.283186
	fle	r30, f4, f6
	beq	r0, r30, fle_else.15931
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15933
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15935
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15937
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15939
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15941
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15943
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15945
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15947
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15949
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15951
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15953
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15955
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.15957
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f1, r30
	fadd	f2, f0, f1
	fadd	f1, f0, f6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	hoge.2824				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f3, f0, f1
	j	fle_cont.15958
fle_else.15957:
	fadd	f3, f0, f1
fle_cont.15958:
	j	fle_cont.15956
fle_else.15955:
	fadd	f3, f0, f1
fle_cont.15956:
	j	fle_cont.15954
fle_else.15953:
	fadd	f3, f0, f1
fle_cont.15954:
	j	fle_cont.15952
fle_else.15951:
	fadd	f3, f0, f1
fle_cont.15952:
	j	fle_cont.15950
fle_else.15949:
	fadd	f3, f0, f1
fle_cont.15950:
	j	fle_cont.15948
fle_else.15947:
	fadd	f3, f0, f1
fle_cont.15948:
	j	fle_cont.15946
fle_else.15945:
	fadd	f3, f0, f1
fle_cont.15946:
	j	fle_cont.15944
fle_else.15943:
	fadd	f3, f0, f1
fle_cont.15944:
	j	fle_cont.15942
fle_else.15941:
	fadd	f3, f0, f1
fle_cont.15942:
	j	fle_cont.15940
fle_else.15939:
	fadd	f3, f0, f1
fle_cont.15940:
	j	fle_cont.15938
fle_else.15937:
	fadd	f3, f0, f1
fle_cont.15938:
	j	fle_cont.15936
fle_else.15935:
	fadd	f3, f0, f1
fle_cont.15936:
	j	fle_cont.15934
fle_else.15933:
	fadd	f3, f0, f1
fle_cont.15934:
	j	fle_cont.15932
fle_else.15931:
	fadd	f3, f0, f4
fle_cont.15932:
	fadd	f2, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	fuga.2827				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 0(r3)
	flw	f5, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15959
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15960
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15961
	fmul	f1, f1, f1
	flup	f6, 2		# fli	f6, 1.000000
	flup	f5, 1		# fli	f5, 0.500000
	flup	f4, 9		# fli	f4, 0.041664
	flup	f3, 10		# fli	f3, 0.001370
	fmul	f3, f1, f3
	fsub	f3, f4, f3
	fmul	f3, f1, f3
	fsub	f3, f5, f3
	fmul	f1, f1, f3
	fsub	f1, f6, f1
	fmul	f1, f1, f2
	jr	r31				#
fle_else.15961:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f5, f3, f1
	fmul	f1, f5, f5
	flup	f3, 6		# fli	f3, 0.166667
	fmul	f3, f3, f5
	fmul	f3, f3, f1
	fsub	f4, f5, f3
	flup	f3, 7		# fli	f3, 0.008333
	fmul	f3, f3, f5
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fadd	f4, f4, f3
	flup	f3, 8		# fli	f3, 0.000196
	fmul	f3, f3, f5
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f1, f3, f1
	fsub	f1, f4, f1
	fmul	f1, f1, f2
	jr	r31				#
fle_else.15960:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15962
	fmul	f1, f1, f1
	flup	f6, 2		# fli	f6, 1.000000
	flup	f5, 1		# fli	f5, 0.500000
	flup	f4, 9		# fli	f4, 0.041664
	flup	f2, 10		# fli	f2, 0.001370
	fmul	f2, f1, f2
	fsub	f2, f4, f2
	fmul	f2, f1, f2
	fsub	f2, f5, f2
	fmul	f1, f1, f2
	fsub	f1, f6, f1
	fmul	f1, f1, f3
	jr	r31				#
fle_else.15962:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f5, f2, f1
	fmul	f1, f5, f5
	flup	f2, 6		# fli	f2, 0.166667
	fmul	f2, f2, f5
	fmul	f2, f2, f1
	fsub	f4, f5, f2
	flup	f2, 7		# fli	f2, 0.008333
	fmul	f2, f2, f5
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fadd	f4, f4, f2
	flup	f2, 8		# fli	f2, 0.000196
	fmul	f2, f2, f5
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fmul	f1, f2, f1
	fsub	f1, f4, f1
	fmul	f1, f1, f3
	jr	r31				#
fle_else.15959:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15963
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15964
	fmul	f1, f1, f1
	flup	f6, 2		# fli	f6, 1.000000
	flup	f5, 1		# fli	f5, 0.500000
	flup	f4, 9		# fli	f4, 0.041664
	flup	f3, 10		# fli	f3, 0.001370
	fmul	f3, f1, f3
	fsub	f3, f4, f3
	fmul	f3, f1, f3
	fsub	f3, f5, f3
	fmul	f1, f1, f3
	fsub	f1, f6, f1
	fmul	f1, f1, f2
	jr	r31				#
fle_else.15964:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f5, f3, f1
	fmul	f1, f5, f5
	flup	f3, 6		# fli	f3, 0.166667
	fmul	f3, f3, f5
	fmul	f3, f3, f1
	fsub	f4, f5, f3
	flup	f3, 7		# fli	f3, 0.008333
	fmul	f3, f3, f5
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fadd	f4, f4, f3
	flup	f3, 8		# fli	f3, 0.000196
	fmul	f3, f3, f5
	fmul	f3, f3, f1
	fmul	f3, f3, f1
	fmul	f1, f3, f1
	fsub	f1, f4, f1
	fmul	f1, f1, f2
	jr	r31				#
fle_else.15963:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15965
	fmul	f1, f1, f1
	flup	f6, 2		# fli	f6, 1.000000
	flup	f4, 1		# fli	f4, 0.500000
	flup	f3, 9		# fli	f3, 0.041664
	flup	f2, 10		# fli	f2, 0.001370
	fmul	f2, f1, f2
	fsub	f2, f3, f2
	fmul	f2, f1, f2
	fsub	f2, f4, f2
	fmul	f1, f1, f2
	fsub	f1, f6, f1
	fmul	f1, f1, f5
	jr	r31				#
fle_else.15965:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f4, f2, f1
	fmul	f1, f4, f4
	flup	f2, 6		# fli	f2, 0.166667
	fmul	f2, f2, f4
	fmul	f2, f2, f1
	fsub	f3, f4, f2
	flup	f2, 7		# fli	f2, 0.008333
	fmul	f2, f2, f4
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fadd	f3, f3, f2
	flup	f2, 8		# fli	f2, 0.000196
	fmul	f2, f2, f4
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fmul	f1, f2, f1
	fsub	f1, f3, f1
	fmul	f1, f1, f5
	jr	r31				#
atan_body.2841:
	fmul	f3, f1, f1
	fmul	f2, f3, f3
	fmul	f4, f2, f2
	flup	f5, 17		# fli	f5, 0.333333
	fmul	f5, f5, f1
	fmul	f5, f5, f3
	fsub	f6, f1, f5
	flup	f5, 18		# fli	f5, 0.200000
	fmul	f5, f5, f1
	fmul	f5, f5, f2
	fadd	f6, f6, f5
	flup	f5, 19		# fli	f5, 0.142857
	fmul	f5, f5, f1
	fmul	f5, f5, f3
	fmul	f5, f5, f2
	fsub	f6, f6, f5
	flup	f5, 20		# fli	f5, 0.111111
	fmul	f5, f5, f1
	fmul	f5, f5, f2
	fmul	f5, f5, f2
	fadd	f6, f6, f5
	flup	f5, 21		# fli	f5, 0.089764
	fmul	f5, f5, f1
	fmul	f3, f5, f3
	fmul	f3, f3, f4
	fsub	f5, f6, f3
	flup	f3, 22		# fli	f3, 0.060035
	fmul	f1, f3, f1
	fmul	f1, f1, f2
	fmul	f1, f1, f4
	fadd	f1, f5, f1
	jr	r31				#
atan.2843:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15966
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.15967
fle_else.15966:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.15967:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15968
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15969
	flup	f4, 15		# fli	f4, 1.570796
	flup	f3, 2		# fli	f3, 1.000000
	finv	f31, f1
	fmul	f1, f3, f31
	fsw	f2, 0(r3)
	fsw	f4, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan_body.2841				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 0(r3)
	flw	f4, 2(r3)
	fadd	f1, f4, f1
	fmul	f1, f1, f2
	jr	r31				#
fle_else.15969:
	flup	f5, 16		# fli	f5, 0.785398
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f4, f1, f3
	flup	f3, 2		# fli	f3, 1.000000
	fadd	f1, f1, f3
	finv	f31, f1
	fmul	f1, f4, f31
	fsw	f2, 0(r3)
	fsw	f5, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	atan_body.2841				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	flw	f5, 4(r3)
	fadd	f1, f5, f1
	fmul	f1, f1, f2
	jr	r31				#
fle_else.15968:
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
	slli	r8, r6, 3
	slli	r7, r6, 1
	add	r7, r8, r7
	ble	r7, r1, ble_then.15970
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r8, r5, 3
	slli	r7, r5, 1
	add	r7, r8, r7
	ble	r7, r1, ble_then.15971
	j	div10_sub.2849
ble_then.15971:
	slli	r7, r5, 3
	slli	r2, r5, 1
	add	r2, r7, r2
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15972
	add	r2, r0, r5
	add	r5, r0, r6
	j	div10_sub.2849
ble_then.15972:
	add	r1, r0, r5
	jr	r31				#
ble_then.15970:
	slli	r7, r6, 3
	slli	r2, r6, 1
	add	r2, r7, r2
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15973
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r8, r2, 3
	slli	r7, r2, 1
	add	r7, r8, r7
	ble	r7, r1, ble_then.15974
	add	r5, r0, r2
	add	r2, r0, r6
	j	div10_sub.2849
ble_then.15974:
	slli	r7, r2, 3
	slli	r6, r2, 1
	add	r6, r7, r6
	addi	r6, r6, 9
	ble	r1, r6, ble_then.15975
	j	div10_sub.2849
ble_then.15975:
	add	r1, r0, r2
	jr	r31				#
ble_then.15973:
	add	r1, r0, r6
	jr	r31				#
div10.2853:
	slli	r5, r1, 7
	slli	r2, r1, 6
	add	r5, r5, r2
	slli	r2, r1, 3
	add	r5, r5, r2
	slli	r2, r1, 2
	add	r2, r5, r2
	add	r1, r2, r1
	srli	r1, r1, 11
	jr	r31				#
print_uint.2855:
	bgei	10, r1, bge_then.15976
	addi	r1, r1, 48
	out	r1
	jr	r31				#
bge_then.15976:
	slli	r5, r1, 7
	slli	r2, r1, 6
	add	r5, r5, r2
	slli	r2, r1, 3
	add	r5, r5, r2
	slli	r2, r1, 2
	add	r2, r5, r2
	add	r2, r2, r1
	srli	r6, r2, 11
	bgei	10, r6, bge_then.15977
	addi	r2, r6, 48
	out	r2
	j	bge_cont.15978
bge_then.15977:
	slli	r5, r6, 7
	slli	r2, r6, 6
	add	r5, r5, r2
	slli	r2, r6, 3
	add	r5, r5, r2
	slli	r2, r6, 2
	add	r2, r5, r2
	add	r2, r2, r6
	srli	r2, r2, 11
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r1, r0, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2855				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	slli	r5, r2, 3
	slli	r2, r2, 1
	add	r2, r5, r2
	sub	r2, r6, r2
	addi	r2, r2, 48
	out	r2
bge_cont.15978:
	slli	r5, r6, 3
	slli	r2, r6, 1
	add	r2, r5, r2
	sub	r1, r1, r2
	addi	r1, r1, 48
	out	r1
	jr	r31				#
print_int.2857:
	bgei	0, r1, bge_then.15979
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	j	print_int.2857
bge_then.15979:
	bgei	10, r1, bge_then.15980
	addi	r1, r1, 48
	out	r1
	jr	r31				#
bge_then.15980:
	addi	r2, r0, 100
	ble	r2, r1, ble_then.15981
	slli	r5, r1, 7
	slli	r2, r1, 6
	add	r5, r5, r2
	slli	r2, r1, 3
	add	r5, r5, r2
	slli	r2, r1, 2
	add	r2, r5, r2
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
ble_then.15981:
	slli	r5, r1, 7
	slli	r2, r1, 5
	add	r5, r5, r2
	slli	r2, r1, 2
	add	r2, r5, r2
	srli	r2, r2, 14
	slli	r6, r2, 6
	slli	r5, r2, 5
	add	r6, r6, r5
	slli	r5, r2, 2
	add	r5, r6, r5
	sub	r1, r1, r5
	slli	r6, r1, 7
	slli	r5, r1, 6
	add	r6, r6, r5
	slli	r5, r1, 3
	add	r6, r6, r5
	slli	r5, r1, 2
	add	r5, r6, r5
	add	r5, r5, r1
	srli	r5, r5, 11
	addi	r2, r2, 48
	out	r2
	addi	r2, r5, 48
	out	r2
	slli	r6, r5, 3
	slli	r2, r5, 1
	add	r2, r6, r2
	sub	r1, r1, r2
	addi	r1, r1, 48
	out	r1
	jr	r31				#
xor.2859:
	beqi	0, r1, beq_then.15982
	beqi	0, r2, beq_then.15983
	addi	r1, r0, 0
	jr	r31				#
beq_then.15983:
	addi	r1, r0, 1
	jr	r31				#
beq_then.15982:
	add	r1, r0, r2
	jr	r31				#
sgn.2862:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15984
	addi	r1, r0, 1
	j	feq_cont.15985
feq_else.15984:
	addi	r1, r0, 0
feq_cont.15985:
	beqi	0, r1, beq_then.15986
	flup	f1, 0		# fli	f1, 0.000000
	jr	r31				#
beq_then.15986:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15987
	addi	r1, r0, 0
	j	fle_cont.15988
fle_else.15987:
	addi	r1, r0, 1
fle_cont.15988:
	beqi	0, r1, beq_then.15989
	flup	f1, 2		# fli	f1, 1.000000
	jr	r31				#
beq_then.15989:
	flup	f1, 11		# fli	f1, -1.000000
	jr	r31				#
fneg_cond.2864:
	beqi	0, r1, beq_then.15990
	jr	r31				#
beq_then.15990:
	fneg	f1, f1
	jr	r31				#
add_mod5.2867:
	add	r1, r1, r2
	bgei	5, r1, bge_then.15991
	jr	r31				#
bge_then.15991:
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
	flw	f2, 0(r1)
	flw	f1, 0(r2)
	fsub	f1, f2, f1
	fmul	f3, f1, f1
	flw	f2, 1(r1)
	flw	f1, 1(r2)
	fsub	f1, f2, f1
	fmul	f1, f1, f1
	fadd	f3, f3, f1
	flw	f2, 2(r1)
	flw	f1, 2(r2)
	fsub	f1, f2, f1
	fmul	f1, f1, f1
	fadd	f1, f3, f1
	jr	r31				#
vecunit.2886:
	flup	f3, 2		# fli	f3, 1.000000
	flw	f1, 0(r1)
	fmul	f2, f1, f1
	flw	f1, 1(r1)
	fmul	f1, f1, f1
	fadd	f2, f2, f1
	flw	f1, 2(r1)
	fmul	f1, f1, f1
	fadd	f1, f2, f1
	fsqrt	f1, f1
	finv	f31, f1
	fmul	f1, f3, f31
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
	fmul	f2, f1, f1
	flw	f1, 1(r1)
	fmul	f1, f1, f1
	fadd	f2, f2, f1
	flw	f1, 2(r1)
	fmul	f1, f1, f1
	fadd	f1, f2, f1
	fsqrt	f1, f1
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15997
	addi	r5, r0, 1
	j	feq_cont.15998
feq_else.15997:
	addi	r5, r0, 0
feq_cont.15998:
	beqi	0, r5, beq_then.15999
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.16000
beq_then.15999:
	beqi	0, r2, beq_then.16001
	flup	f2, 11		# fli	f2, -1.000000
	finv	f31, f1
	fmul	f2, f2, f31
	j	beq_cont.16002
beq_then.16001:
	flup	f2, 2		# fli	f2, 1.000000
	finv	f31, f1
	fmul	f2, f2, f31
beq_cont.16002:
beq_cont.16000:
	flw	f1, 0(r1)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	flw	f1, 1(r1)
	fmul	f1, f1, f2
	fsw	f1, 1(r1)
	flw	f1, 2(r1)
	fmul	f1, f1, f2
	fsw	f1, 2(r1)
	jr	r31				#
veciprod.2891:
	flw	f2, 0(r1)
	flw	f1, 0(r2)
	fmul	f3, f2, f1
	flw	f2, 1(r1)
	flw	f1, 1(r2)
	fmul	f1, f2, f1
	fadd	f3, f3, f1
	flw	f2, 2(r1)
	flw	f1, 2(r2)
	fmul	f1, f2, f1
	fadd	f1, f3, f1
	jr	r31				#
veciprod2.2894:
	flw	f4, 0(r1)
	fmul	f4, f4, f1
	flw	f1, 1(r1)
	fmul	f1, f1, f2
	fadd	f2, f4, f1
	flw	f1, 2(r1)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	jr	r31				#
vecaccum.2899:
	flw	f3, 0(r1)
	flw	f2, 0(r2)
	fmul	f2, f1, f2
	fadd	f2, f3, f2
	fsw	f2, 0(r1)
	flw	f3, 1(r1)
	flw	f2, 1(r2)
	fmul	f2, f1, f2
	fadd	f2, f3, f2
	fsw	f2, 1(r1)
	flw	f3, 2(r1)
	flw	f2, 2(r2)
	fmul	f1, f1, f2
	fadd	f1, f3, f1
	fsw	f1, 2(r1)
	jr	r31				#
vecadd.2903:
	flw	f2, 0(r1)
	flw	f1, 0(r2)
	fadd	f1, f2, f1
	fsw	f1, 0(r1)
	flw	f2, 1(r1)
	flw	f1, 1(r2)
	fadd	f1, f2, f1
	fsw	f1, 1(r1)
	flw	f2, 2(r1)
	flw	f1, 2(r2)
	fadd	f1, f2, f1
	fsw	f1, 2(r1)
	jr	r31				#
vecmul.2906:
	flw	f2, 0(r1)
	flw	f1, 0(r2)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	flw	f2, 1(r1)
	flw	f1, 1(r2)
	fmul	f1, f2, f1
	fsw	f1, 1(r1)
	flw	f2, 2(r1)
	flw	f1, 2(r2)
	fmul	f1, f2, f1
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
	flw	f3, 0(r1)
	flw	f2, 0(r2)
	flw	f1, 0(r5)
	fmul	f1, f2, f1
	fadd	f1, f3, f1
	fsw	f1, 0(r1)
	flw	f3, 1(r1)
	flw	f2, 1(r2)
	flw	f1, 1(r5)
	fmul	f1, f2, f1
	fadd	f1, f3, f1
	fsw	f1, 1(r1)
	flw	f3, 2(r1)
	flw	f2, 2(r2)
	flw	f1, 2(r5)
	fmul	f1, f2, f1
	fadd	f1, f3, f1
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
	fadd	f2, f0, f1
	flup	f1, 25		# fli	f1, 0.017453
	fmul	f1, f2, f1
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	cos.2839				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	fadd	f4, f0, f1
	flw	f1, 0(r3)
	fsw	f4, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2837				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f2, f0, f1
	flw	f4, 2(r3)
	fsw	f2, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	fadd	f3, f0, f1
	flw	f2, 4(r3)
	flw	f4, 2(r3)
	flup	f1, 25		# fli	f1, 0.017453
	fmul	f1, f3, f1
	fsw	f1, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos.2839				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f3, f0, f1
	flw	f1, 6(r3)
	flw	f2, 4(r3)
	flw	f4, 2(r3)
	fsw	f3, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin.2837				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 4(r3)
	flw	f3, 8(r3)
	flw	f4, 2(r3)
	fmul	f6, f4, f1
	flup	f5, 26		# fli	f5, 200.000000
	fmul	f5, f6, f5
	fsw	f5, 760(r0)
	flup	f5, 27		# fli	f5, -200.000000
	fmul	f5, f2, f5
	fsw	f5, 761(r0)
	fmul	f6, f4, f3
	flup	f5, 26		# fli	f5, 200.000000
	fmul	f5, f6, f5
	fsw	f5, 762(r0)
	fsw	f3, 754(r0)
	fsw	f0, 755(r0)
	fneg	f5, f1
	fsw	f5, 756(r0)
	fneg	f2, f2
	fmul	f1, f2, f1
	fsw	f1, 757(r0)
	fneg	f1, f4
	fsw	f1, 758(r0)
	fmul	f1, f2, f3
	fsw	f1, 759(r0)
	flw	f2, 661(r0)
	flw	f1, 760(r0)
	fsub	f1, f2, f1
	fsw	f1, 664(r0)
	flw	f2, 662(r0)
	flw	f1, 761(r0)
	fsub	f1, f2, f1
	fsw	f1, 665(r0)
	flw	f2, 663(r0)
	flw	f1, 762(r0)
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
	fadd	f2, f0, f1
	flup	f1, 25		# fli	f1, 0.017453
	fmul	f3, f2, f1
	fsw	f3, 0(r3)
	fadd	f1, f0, f3
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	sin.2837				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f3, 0(r3)
	fneg	f1, f1
	fsw	f1, 668(r0)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_float				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	fadd	f2, f0, f1
	flw	f3, 0(r3)
	flup	f1, 25		# fli	f1, 0.017453
	fmul	f2, f2, f1
	fsw	f2, 2(r3)
	fadd	f1, f0, f3
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	cos.2839				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f3, f0, f1
	flw	f2, 2(r3)
	fsw	f3, 4(r3)
	fadd	f1, f0, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin.2837				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	fmul	f1, f3, f1
	fsw	f1, 667(r0)
	fadd	f1, f0, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2839				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f3, 4(r3)
	fmul	f1, f3, f1
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
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	cos.2839				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	fadd	f12, f0, f1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	flw	f1, 0(r2)
	fsw	f12, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2837				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f3, f0, f1
	flw	f12, 2(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	flw	f1, 1(r2)
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2839				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	fadd	f11, f0, f1
	flw	f3, 4(r3)
	flw	f12, 2(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	flw	f1, 1(r2)
	fsw	f11, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2837				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1
	flw	f3, 4(r3)
	flw	f11, 6(r3)
	flw	f12, 2(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	flw	f1, 2(r2)
	fsw	f2, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos.2839				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	fadd	f4, f0, f1
	flw	f2, 8(r3)
	flw	f3, 4(r3)
	flw	f11, 6(r3)
	flw	f12, 2(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	flw	f1, 2(r2)
	fsw	f4, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2837				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 8(r3)
	flw	f3, 4(r3)
	flw	f4, 10(r3)
	flw	f11, 6(r3)
	flw	f12, 2(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	fmul	f10, f11, f4
	fmul	f14, f3, f2
	fmul	f6, f14, f4
	fmul	f5, f12, f1
	fsub	f9, f6, f5
	fmul	f13, f12, f2
	fmul	f6, f13, f4
	fmul	f5, f3, f1
	fadd	f8, f6, f5
	fmul	f7, f11, f1
	fmul	f6, f14, f1
	fmul	f5, f12, f4
	fadd	f6, f6, f5
	fmul	f5, f13, f1
	fmul	f1, f3, f4
	fsub	f5, f5, f1
	fneg	f4, f2
	fmul	f2, f3, f11
	fmul	f1, f12, f11
	flw	f12, 0(r1)
	flw	f11, 1(r1)
	flw	f3, 2(r1)
	fmul	f13, f10, f10
	fmul	f14, f12, f13
	fmul	f13, f7, f7
	fmul	f13, f11, f13
	fadd	f14, f14, f13
	fmul	f13, f4, f4
	fmul	f13, f3, f13
	fadd	f13, f14, f13
	fsw	f13, 0(r1)
	fmul	f13, f9, f9
	fmul	f14, f12, f13
	fmul	f13, f6, f6
	fmul	f13, f11, f13
	fadd	f14, f14, f13
	fmul	f13, f2, f2
	fmul	f13, f3, f13
	fadd	f13, f14, f13
	fsw	f13, 1(r1)
	fmul	f13, f8, f8
	fmul	f14, f12, f13
	fmul	f13, f5, f5
	fmul	f13, f11, f13
	fadd	f14, f14, f13
	fmul	f13, f1, f1
	fmul	f13, f3, f13
	fadd	f13, f14, f13
	fsw	f13, 2(r1)
	flup	f15, 3		# fli	f15, 2.000000
	fmul	f13, f12, f9
	fmul	f14, f13, f8
	fmul	f13, f11, f6
	fmul	f13, f13, f5
	fadd	f14, f14, f13
	fmul	f13, f3, f2
	fmul	f13, f13, f1
	fadd	f13, f14, f13
	fmul	f13, f15, f13
	fsw	f13, 0(r2)
	flup	f13, 3		# fli	f13, 2.000000
	fmul	f12, f12, f10
	fmul	f10, f12, f8
	fmul	f8, f11, f7
	fmul	f5, f8, f5
	fadd	f7, f10, f5
	fmul	f5, f3, f4
	fmul	f1, f5, f1
	fadd	f1, f7, f1
	fmul	f1, f13, f1
	fsw	f1, 1(r2)
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f3, f12, f9
	fmul	f1, f8, f6
	fadd	f3, f3, f1
	fmul	f1, f5, f2
	fadd	f1, f3, f1
	fmul	f1, f4, f1
	fsw	f1, 2(r2)
	jr	r31				#
read_nth_object.2996:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r5, r0, r1
	lw	r1, 0(r3)
	beqi	-1, r5, beq_then.16013
	sw	r5, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r13, r0, r1
	lw	r5, 1(r3)
	lw	r1, 0(r3)
	sw	r13, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r8, r0, r1
	lw	r5, 1(r3)
	lw	r1, 0(r3)
	lw	r13, 2(r3)
	sw	r8, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_int				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r12, r0, r1
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r1, 0(r3)
	lw	r13, 2(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r12, 4(r3)
	add	r1, r0, r2
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_float_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r16, r0, r1
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r1, 0(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	sw	r16, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r1, 0(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r16, 5(r3)
	fsw	f1, 0(r16)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r1, 0(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r16, 5(r3)
	fsw	f1, 1(r16)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r1, 0(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r16, 5(r3)
	fsw	f1, 2(r16)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r1, 0(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r16, 5(r3)
	sw	r2, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r1, 0(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r16, 5(r3)
	fsw	f1, 0(r2)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r1, 0(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r16, 5(r3)
	fsw	f1, 1(r2)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r1, 0(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r16, 5(r3)
	fsw	f1, 2(r2)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r1, 0(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r16, 5(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16014
	addi	r11, r0, 0
	j	fle_cont.16015
fle_else.16014:
	addi	r11, r0, 1
fle_cont.16015:
	addi	r6, r0, 2
	flup	f1, 0		# fli	f1, 0.000000
	sw	r11, 7(r3)
	add	r1, r0, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_float_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r9, r0, r1
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r1, 0(r3)
	lw	r11, 7(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r16, 5(r3)
	sw	r9, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_read_float				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r9, 8(r3)
	lw	r1, 0(r3)
	lw	r11, 7(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r16, 5(r3)
	fsw	f1, 0(r9)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_read_float				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r9, 8(r3)
	lw	r1, 0(r3)
	lw	r11, 7(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r16, 5(r3)
	fsw	f1, 1(r9)
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_float_array				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r15, r0, r1
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r9, 8(r3)
	lw	r1, 0(r3)
	lw	r11, 7(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r16, 5(r3)
	sw	r15, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r9, 8(r3)
	lw	r1, 0(r3)
	lw	r11, 7(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r15, 9(r3)
	lw	r16, 5(r3)
	fsw	f1, 0(r15)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r9, 8(r3)
	lw	r1, 0(r3)
	lw	r11, 7(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r15, 9(r3)
	lw	r16, 5(r3)
	fsw	f1, 1(r15)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r9, 8(r3)
	lw	r1, 0(r3)
	lw	r11, 7(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r15, 9(r3)
	lw	r16, 5(r3)
	fsw	f1, 2(r15)
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r7, r0, r1
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r8, 3(r3)
	lw	r9, 8(r3)
	lw	r1, 0(r3)
	lw	r11, 7(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r15, 9(r3)
	lw	r16, 5(r3)
	beqi	0, r12, beq_then.16016
	sw	r7, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	fadd	f2, f0, f1
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r7, 10(r3)
	lw	r8, 3(r3)
	lw	r9, 8(r3)
	lw	r1, 0(r3)
	lw	r11, 7(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r15, 9(r3)
	lw	r16, 5(r3)
	flup	f1, 25		# fli	f1, 0.017453
	fmul	f1, f2, f1
	fsw	f1, 0(r7)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	fadd	f2, f0, f1
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r7, 10(r3)
	lw	r8, 3(r3)
	lw	r9, 8(r3)
	lw	r1, 0(r3)
	lw	r11, 7(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r15, 9(r3)
	lw	r16, 5(r3)
	flup	f1, 25		# fli	f1, 0.017453
	fmul	f1, f2, f1
	fsw	f1, 1(r7)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	fadd	f2, f0, f1
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r7, 10(r3)
	lw	r8, 3(r3)
	lw	r9, 8(r3)
	lw	r1, 0(r3)
	lw	r11, 7(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r15, 9(r3)
	lw	r16, 5(r3)
	flup	f1, 25		# fli	f1, 0.017453
	fmul	f1, f2, f1
	fsw	f1, 2(r7)
	j	beq_cont.16017
beq_then.16016:
beq_cont.16017:
	beqi	2, r13, beq_then.16018
	add	r10, r0, r11
	j	beq_cont.16019
beq_then.16018:
	addi	r10, r0, 1
beq_cont.16019:
	addi	r6, r0, 4
	flup	f1, 0		# fli	f1, 0.000000
	sw	r7, 10(r3)
	sw	r10, 11(r3)
	add	r1, r0, r6
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_float_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r14, r0, r1
	lw	r2, 6(r3)
	lw	r5, 1(r3)
	lw	r7, 10(r3)
	lw	r8, 3(r3)
	lw	r9, 8(r3)
	lw	r1, 0(r3)
	lw	r10, 11(r3)
	lw	r11, 7(r3)
	lw	r12, 4(r3)
	lw	r13, 2(r3)
	lw	r15, 9(r3)
	lw	r16, 5(r3)
	add	r6, r0, r4
	addi	r4, r4, 11
	sw	r14, 10(r6)
	sw	r7, 9(r6)
	sw	r15, 8(r6)
	sw	r9, 7(r6)
	sw	r10, 6(r6)
	sw	r2, 5(r6)
	sw	r16, 4(r6)
	sw	r12, 3(r6)
	sw	r8, 2(r6)
	sw	r13, 1(r6)
	sw	r5, 0(r6)
	add	r2, r0, r6
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r1
	sw	r2, 0(r30)
	beqi	3, r13, beq_then.16020
	beqi	2, r13, beq_then.16022
	j	beq_cont.16023
beq_then.16022:
	beqi	0, r11, beq_then.16024
	addi	r1, r0, 0
	j	beq_cont.16025
beq_then.16024:
	addi	r1, r0, 1
beq_cont.16025:
	add	r2, r0, r1
	add	r1, r0, r16
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	vecunit_sgn.2888				
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.16023:
	j	beq_cont.16021
beq_then.16020:
	flw	f1, 0(r16)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16026
	addi	r1, r0, 1
	j	feq_cont.16027
feq_else.16026:
	addi	r1, r0, 0
feq_cont.16027:
	beqi	0, r1, beq_then.16028
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16029
beq_then.16028:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16030
	addi	r1, r0, 1
	j	feq_cont.16031
feq_else.16030:
	addi	r1, r0, 0
feq_cont.16031:
	beqi	0, r1, beq_then.16032
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16033
beq_then.16032:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16034
	addi	r1, r0, 0
	j	fle_cont.16035
fle_else.16034:
	addi	r1, r0, 1
fle_cont.16035:
	beqi	0, r1, beq_then.16036
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.16037
beq_then.16036:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.16037:
beq_cont.16033:
	fmul	f1, f1, f1
	finv	f31, f1
	fmul	f2, f2, f31
beq_cont.16029:
	fsw	f2, 0(r16)
	flw	f1, 1(r16)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16038
	addi	r1, r0, 1
	j	feq_cont.16039
feq_else.16038:
	addi	r1, r0, 0
feq_cont.16039:
	beqi	0, r1, beq_then.16040
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16041
beq_then.16040:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16042
	addi	r1, r0, 1
	j	feq_cont.16043
feq_else.16042:
	addi	r1, r0, 0
feq_cont.16043:
	beqi	0, r1, beq_then.16044
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16045
beq_then.16044:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16046
	addi	r1, r0, 0
	j	fle_cont.16047
fle_else.16046:
	addi	r1, r0, 1
fle_cont.16047:
	beqi	0, r1, beq_then.16048
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.16049
beq_then.16048:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.16049:
beq_cont.16045:
	fmul	f1, f1, f1
	finv	f31, f1
	fmul	f2, f2, f31
beq_cont.16041:
	fsw	f2, 1(r16)
	flw	f1, 2(r16)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16050
	addi	r1, r0, 1
	j	feq_cont.16051
feq_else.16050:
	addi	r1, r0, 0
feq_cont.16051:
	beqi	0, r1, beq_then.16052
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16053
beq_then.16052:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16054
	addi	r1, r0, 1
	j	feq_cont.16055
feq_else.16054:
	addi	r1, r0, 0
feq_cont.16055:
	beqi	0, r1, beq_then.16056
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16057
beq_then.16056:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16058
	addi	r1, r0, 0
	j	fle_cont.16059
fle_else.16058:
	addi	r1, r0, 1
fle_cont.16059:
	beqi	0, r1, beq_then.16060
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.16061
beq_then.16060:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.16061:
beq_cont.16057:
	fmul	f1, f1, f1
	finv	f31, f1
	fmul	f2, f2, f31
beq_cont.16053:
	fsw	f2, 2(r16)
beq_cont.16021:
	beqi	0, r12, beq_then.16062
	add	r2, r0, r7
	add	r1, r0, r16
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	rotate_quadratic_matrix.2993				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.16063
beq_then.16062:
beq_cont.16063:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16013:
	addi	r1, r0, 0
	jr	r31				#
read_object.2998:
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16064
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	beqi	0, r2, beq_then.16065
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16066
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	beqi	0, r2, beq_then.16067
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16068
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_nth_object.2996				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r1, 2(r3)
	beqi	0, r2, beq_then.16069
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16070
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_nth_object.2996				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 3(r3)
	beqi	0, r2, beq_then.16071
	addi	r1, r1, 1
	j	read_object.2998
beq_then.16071:
	sw	r1, 0(r0)
	jr	r31				#
ble_then.16070:
	jr	r31				#
beq_then.16069:
	sw	r1, 0(r0)
	jr	r31				#
ble_then.16068:
	jr	r31				#
beq_then.16067:
	sw	r1, 0(r0)
	jr	r31				#
ble_then.16066:
	jr	r31				#
beq_then.16065:
	sw	r1, 0(r0)
	jr	r31				#
ble_then.16064:
	jr	r31				#
read_all_object.3000:
	addi	r1, r0, 0
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	beqi	0, r2, beq_then.16080
	addi	r1, r0, 1
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	beqi	0, r2, beq_then.16081
	addi	r1, r0, 2
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_nth_object.2996				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r1, 2(r3)
	beqi	0, r2, beq_then.16082
	addi	r1, r0, 3
	j	read_object.2998
beq_then.16082:
	sw	r1, 0(r0)
	jr	r31				#
beq_then.16081:
	sw	r1, 0(r0)
	jr	r31				#
beq_then.16080:
	sw	r1, 0(r0)
	jr	r31				#
read_net_item.3002:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r8, r0, r1
	lw	r1, 0(r3)
	beqi	-1, r8, beq_then.16086
	addi	r11, r1, 1
	sw	r8, 1(r3)
	sw	r11, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r7, r0, r1
	lw	r1, 0(r3)
	lw	r8, 1(r3)
	lw	r11, 2(r3)
	beqi	-1, r7, beq_then.16087
	addi	r10, r11, 1
	sw	r7, 3(r3)
	sw	r10, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r5, r0, r1
	lw	r1, 0(r3)
	lw	r7, 3(r3)
	lw	r8, 1(r3)
	lw	r10, 4(r3)
	lw	r11, 2(r3)
	beqi	-1, r5, beq_then.16089
	addi	r9, r10, 1
	sw	r5, 5(r3)
	sw	r9, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r6, r0, r1
	lw	r1, 0(r3)
	lw	r5, 5(r3)
	lw	r7, 3(r3)
	lw	r8, 1(r3)
	lw	r9, 6(r3)
	lw	r10, 4(r3)
	lw	r11, 2(r3)
	beqi	-1, r6, beq_then.16091
	addi	r2, r9, 1
	sw	r6, 7(r3)
	add	r1, r0, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.3002				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r5, 5(r3)
	lw	r6, 7(r3)
	lw	r7, 3(r3)
	lw	r8, 1(r3)
	lw	r9, 6(r3)
	lw	r10, 4(r3)
	lw	r11, 2(r3)
	add	r30, r2, r9
	sw	r6, 0(r30)
	j	beq_cont.16092
beq_then.16091:
	addi	r6, r9, 1
	addi	r2, r0, -1
	sw	r2, 8(r3)
	add	r1, r0, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r2, r0, r1
beq_cont.16092:
	lw	r1, 0(r3)
	lw	r5, 5(r3)
	lw	r7, 3(r3)
	lw	r8, 1(r3)
	lw	r10, 4(r3)
	lw	r11, 2(r3)
	add	r30, r2, r10
	sw	r5, 0(r30)
	j	beq_cont.16090
beq_then.16089:
	addi	r5, r10, 1
	addi	r2, r0, -1
	sw	r2, 9(r3)
	add	r1, r0, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r2, r0, r1
beq_cont.16090:
	lw	r2, 8(r3)
	lw	r1, 0(r3)
	lw	r5, 5(r3)
	lw	r7, 3(r3)
	lw	r8, 1(r3)
	lw	r10, 4(r3)
	lw	r11, 2(r3)
	add	r30, r2, r11
	sw	r7, 0(r30)
	j	beq_cont.16088
beq_then.16087:
	addi	r5, r11, 1
	addi	r2, r0, -1
	sw	r2, 10(r3)
	add	r1, r0, r5
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1
beq_cont.16088:
	lw	r2, 8(r3)
	lw	r2, 9(r3)
	lw	r1, 0(r3)
	lw	r5, 5(r3)
	lw	r7, 3(r3)
	lw	r8, 1(r3)
	lw	r10, 4(r3)
	lw	r11, 2(r3)
	add	r30, r2, r1
	sw	r8, 0(r30)
	add	r1, r0, r2
	jr	r31				#
beq_then.16086:
	addi	r2, r1, 1
	addi	r1, r0, -1
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	j	lib_create_array
read_or_network.3004:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r7, r0, r1
	lw	r1, 0(r3)
	beqi	-1, r7, beq_then.16093
	sw	r7, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r5, r0, r1
	lw	r1, 0(r3)
	lw	r7, 1(r3)
	beqi	-1, r5, beq_then.16095
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r6, r0, r1
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 1(r3)
	beqi	-1, r6, beq_then.16097
	addi	r2, r0, 3
	sw	r6, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3002				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	lw	r6, 3(r3)
	lw	r7, 1(r3)
	sw	r6, 2(r2)
	j	beq_cont.16098
beq_then.16097:
	addi	r6, r0, 3
	addi	r2, r0, -1
	sw	r2, 4(r3)
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
beq_cont.16098:
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 1(r3)
	sw	r5, 1(r2)
	j	beq_cont.16096
beq_then.16095:
	addi	r5, r0, 2
	addi	r2, r0, -1
	sw	r2, 5(r3)
	add	r1, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1
beq_cont.16096:
	lw	r2, 4(r3)
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 1(r3)
	sw	r7, 0(r2)
	add	r6, r0, r2
	j	beq_cont.16094
beq_then.16093:
	addi	r5, r0, 1
	addi	r2, r0, -1
	sw	r6, 6(r3)
	add	r1, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r6, r0, r1
beq_cont.16094:
	lw	r2, 4(r3)
	lw	r2, 5(r3)
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 1(r3)
	lw	r2, 0(r6)
	beqi	-1, r2, beq_then.16099
	addi	r8, r1, 1
	sw	r6, 6(r3)
	sw	r8, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_int				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r7, r0, r1
	lw	r6, 6(r3)
	lw	r1, 0(r3)
	lw	r8, 7(r3)
	beqi	-1, r7, beq_then.16100
	sw	r7, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_read_int				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r5, r0, r1
	lw	r6, 6(r3)
	lw	r1, 0(r3)
	lw	r7, 8(r3)
	lw	r8, 7(r3)
	beqi	-1, r5, beq_then.16102
	addi	r2, r0, 2
	sw	r5, 9(r3)
	add	r1, r0, r2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	read_net_item.3002				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r2, r0, r1
	lw	r6, 6(r3)
	lw	r1, 0(r3)
	lw	r7, 8(r3)
	lw	r5, 9(r3)
	lw	r8, 7(r3)
	sw	r5, 1(r2)
	j	beq_cont.16103
beq_then.16102:
	addi	r5, r0, 2
	addi	r2, r0, -1
	sw	r2, 10(r3)
	add	r1, r0, r5
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1
beq_cont.16103:
	lw	r6, 6(r3)
	lw	r1, 0(r3)
	lw	r7, 8(r3)
	lw	r8, 7(r3)
	sw	r7, 0(r2)
	add	r5, r0, r2
	j	beq_cont.16101
beq_then.16100:
	addi	r5, r0, 1
	addi	r2, r0, -1
	sw	r5, 11(r3)
	add	r1, r0, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r5, r0, r1
beq_cont.16101:
	lw	r2, 10(r3)
	lw	r6, 6(r3)
	lw	r1, 0(r3)
	lw	r7, 8(r3)
	lw	r8, 7(r3)
	lw	r2, 0(r5)
	beqi	-1, r2, beq_then.16104
	addi	r2, r8, 1
	sw	r5, 11(r3)
	add	r1, r0, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	read_or_network.3004				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r2, r0, r1
	lw	r5, 11(r3)
	lw	r6, 6(r3)
	lw	r1, 0(r3)
	lw	r8, 7(r3)
	add	r30, r2, r8
	sw	r5, 0(r30)
	j	beq_cont.16105
beq_then.16104:
	addi	r2, r8, 1
	sw	r2, 12(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r2, r0, r1
beq_cont.16105:
	lw	r6, 6(r3)
	lw	r1, 0(r3)
	add	r30, r2, r1
	sw	r6, 0(r30)
	add	r1, r0, r2
	jr	r31				#
beq_then.16099:
	addi	r1, r1, 1
	add	r2, r0, r6
	j	lib_create_array
read_and_network.3006:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r7, r0, r1
	lw	r1, 0(r3)
	beqi	-1, r7, beq_then.16106
	sw	r7, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r5, r0, r1
	lw	r1, 0(r3)
	lw	r7, 1(r3)
	beqi	-1, r5, beq_then.16108
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r6, r0, r1
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 1(r3)
	beqi	-1, r6, beq_then.16110
	addi	r2, r0, 3
	sw	r6, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3002				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	lw	r6, 3(r3)
	lw	r7, 1(r3)
	sw	r6, 2(r2)
	j	beq_cont.16111
beq_then.16110:
	addi	r6, r0, 3
	addi	r2, r0, -1
	sw	r2, 4(r3)
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
beq_cont.16111:
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 1(r3)
	sw	r5, 1(r2)
	j	beq_cont.16109
beq_then.16108:
	addi	r5, r0, 2
	addi	r2, r0, -1
	sw	r2, 5(r3)
	add	r1, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1
beq_cont.16109:
	lw	r2, 4(r3)
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 1(r3)
	sw	r7, 0(r2)
	j	beq_cont.16107
beq_then.16106:
	addi	r5, r0, 1
	addi	r2, r0, -1
	sw	r2, 6(r3)
	add	r1, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r1
beq_cont.16107:
	lw	r2, 4(r3)
	lw	r2, 5(r3)
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 1(r3)
	lw	r5, 0(r2)
	beqi	-1, r5, beq_then.16112
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r1
	sw	r2, 0(r30)
	addi	r6, r1, 1
	sw	r6, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_int				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1
	lw	r6, 7(r3)
	beqi	-1, r2, beq_then.16113
	sw	r2, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_read_int				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r5, r0, r1
	lw	r2, 8(r3)
	lw	r6, 7(r3)
	beqi	-1, r5, beq_then.16115
	addi	r1, r0, 2
	sw	r5, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	read_net_item.3002				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	lw	r6, 7(r3)
	sw	r5, 1(r1)
	j	beq_cont.16116
beq_then.16115:
	addi	r5, r0, 2
	addi	r1, r0, -1
	sw	r1, 10(r3)
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				
	addi	r3, r3, -12
	lw	r31, 11(r3)
beq_cont.16116:
	lw	r2, 8(r3)
	lw	r6, 7(r3)
	sw	r2, 0(r1)
	j	beq_cont.16114
beq_then.16113:
	addi	r2, r0, 1
	addi	r1, r0, -1
	sw	r1, 11(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.16114:
	lw	r1, 10(r3)
	lw	r2, 8(r3)
	lw	r6, 7(r3)
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.16117
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r6
	sw	r1, 0(r30)
	addi	r1, r6, 1
	j	read_and_network.3006
beq_then.16117:
	jr	r31				#
beq_then.16112:
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
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	beqi	0, r2, beq_then.16120
	addi	r1, r0, 1
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	beqi	0, r2, beq_then.16122
	addi	r1, r0, 2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_object.2998				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.16123
beq_then.16122:
	sw	r1, 0(r0)
beq_cont.16123:
	j	beq_cont.16121
beq_then.16120:
	sw	r1, 0(r0)
beq_cont.16121:
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	beqi	-1, r2, beq_then.16124
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r2, 2(r3)
	beqi	-1, r5, beq_then.16126
	addi	r1, r0, 2
	sw	r5, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3002				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	sw	r5, 1(r1)
	j	beq_cont.16127
beq_then.16126:
	addi	r5, r0, 2
	addi	r1, r0, -1
	sw	r1, 4(r3)
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16127:
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	j	beq_cont.16125
beq_then.16124:
	addi	r2, r0, 1
	addi	r1, r0, -1
	sw	r1, 5(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.16125:
	lw	r1, 4(r3)
	lw	r2, 2(r3)
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.16128
	sw	r1, 672(r0)
	addi	r1, r0, 1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	read_and_network.3006				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16129
beq_then.16128:
beq_cont.16129:
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r5, r0, r1
	beqi	-1, r5, beq_then.16130
	sw	r5, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r1
	lw	r5, 6(r3)
	beqi	-1, r2, beq_then.16132
	addi	r1, r0, 2
	sw	r2, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.3002				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r5, 6(r3)
	lw	r2, 7(r3)
	sw	r2, 1(r1)
	j	beq_cont.16133
beq_then.16132:
	addi	r2, r0, 2
	addi	r1, r0, -1
	sw	r1, 8(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.16133:
	lw	r5, 6(r3)
	sw	r5, 0(r1)
	add	r2, r0, r1
	j	beq_cont.16131
beq_then.16130:
	addi	r2, r0, 1
	addi	r1, r0, -1
	sw	r2, 9(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r2, r0, r1
beq_cont.16131:
	lw	r1, 8(r3)
	lw	r5, 6(r3)
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.16134
	addi	r1, r0, 1
	sw	r2, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	read_or_network.3004				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 9(r3)
	sw	r2, 0(r1)
	j	beq_cont.16135
beq_then.16134:
	addi	r1, r0, 1
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				
	addi	r3, r3, -12
	lw	r31, 11(r3)
beq_cont.16135:
	sw	r1, 723(r0)
	jr	r31				#
solver_rect_surface.3010:
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16137
	addi	r8, r0, 1
	j	feq_cont.16138
feq_else.16137:
	addi	r8, r0, 0
feq_cont.16138:
	beqi	0, r8, beq_then.16139
	addi	r1, r0, 0
	jr	r31				#
beq_then.16139:
	lw	r8, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16140
	addi	r9, r0, 0
	j	fle_cont.16141
fle_else.16140:
	addi	r9, r0, 1
fle_cont.16141:
	beqi	0, r1, beq_then.16142
	beqi	0, r9, beq_then.16144
	addi	r1, r0, 0
	j	beq_cont.16145
beq_then.16144:
	addi	r1, r0, 1
beq_cont.16145:
	j	beq_cont.16143
beq_then.16142:
	add	r1, r0, r9
beq_cont.16143:
	add	r30, r8, r5
	flw	f5, 0(r30)
	beqi	0, r1, beq_then.16146
	fadd	f4, f0, f5
	j	beq_cont.16147
beq_then.16146:
	fneg	f4, f5
beq_cont.16147:
	fsub	f4, f4, f1
	add	r30, r2, r5
	flw	f1, 0(r30)
	finv	f31, f1
	fmul	f1, f4, f31
	add	r30, r8, r6
	flw	f5, 0(r30)
	add	r30, r2, r6
	flw	f4, 0(r30)
	fmul	f4, f1, f4
	fadd	f4, f4, f2
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16148
	fadd	f2, f0, f4
	j	fle_cont.16149
fle_else.16148:
	fneg	f2, f4
fle_cont.16149:
	fle	r30, f5, f2
	beq	r0, r30, fle_else.16150
	addi	r1, r0, 0
	jr	r31				#
fle_else.16150:
	add	r30, r8, r7
	flw	f4, 0(r30)
	add	r30, r2, r7
	flw	f2, 0(r30)
	fmul	f2, f1, f2
	fadd	f3, f2, f3
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16151
	fadd	f2, f0, f3
	j	fle_cont.16152
fle_else.16151:
	fneg	f2, f3
fle_cont.16152:
	fle	r30, f4, f2
	beq	r0, r30, fle_else.16153
	addi	r1, r0, 0
	jr	r31				#
fle_else.16153:
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
solver_rect.3019:
	addi	r7, r0, 0
	addi	r6, r0, 1
	addi	r5, r0, 2
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	add	r28, r0, r7
	add	r7, r0, r5
	add	r5, r0, r28
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r5, r0, r1
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	beqi	0, r5, beq_then.16154
	addi	r1, r0, 1
	jr	r31				#
beq_then.16154:
	addi	r7, r0, 1
	addi	r6, r0, 2
	addi	r5, r0, 0
	add	r28, r0, r7
	add	r7, r0, r5
	add	r5, r0, r28
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f2
	fadd	f2, f0, f30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r5, r0, r1
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	beqi	0, r5, beq_then.16155
	addi	r1, r0, 2
	jr	r31				#
beq_then.16155:
	addi	r7, r0, 2
	addi	r6, r0, 0
	addi	r5, r0, 1
	add	r28, r0, r7
	add	r7, r0, r5
	add	r5, r0, r28
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f1
	fadd	f1, f0, f30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.16156
	addi	r1, r0, 3
	jr	r31				#
beq_then.16156:
	addi	r1, r0, 0
	jr	r31				#
solver_surface.3025:
	lw	r1, 4(r1)
	flw	f5, 0(r2)
	flw	f4, 0(r1)
	fmul	f6, f5, f4
	flw	f5, 1(r2)
	flw	f4, 1(r1)
	fmul	f4, f5, f4
	fadd	f6, f6, f4
	flw	f5, 2(r2)
	flw	f4, 2(r1)
	fmul	f4, f5, f4
	fadd	f4, f6, f4
	fle	r30, f4, f0
	beq	r0, r30, fle_else.16157
	addi	r2, r0, 0
	j	fle_cont.16158
fle_else.16157:
	addi	r2, r0, 1
fle_cont.16158:
	beqi	0, r2, beq_then.16159
	flw	f5, 0(r1)
	fmul	f5, f5, f1
	flw	f1, 1(r1)
	fmul	f1, f1, f2
	fadd	f2, f5, f1
	flw	f1, 2(r1)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	fneg	f1, f1
	finv	f31, f4
	fmul	f1, f1, f31
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16159:
	addi	r1, r0, 0
	jr	r31				#
quadratic.3031:
	fmul	f5, f1, f1
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fmul	f6, f5, f4
	fmul	f5, f2, f2
	lw	r2, 4(r1)
	flw	f4, 1(r2)
	fmul	f4, f5, f4
	fadd	f6, f6, f4
	fmul	f5, f3, f3
	lw	r2, 4(r1)
	flw	f4, 2(r2)
	fmul	f4, f5, f4
	fadd	f4, f6, f4
	lw	r2, 3(r1)
	beqi	0, r2, beq_then.16160
	fmul	f6, f2, f3
	lw	r2, 9(r1)
	flw	f5, 0(r2)
	fmul	f5, f6, f5
	fadd	f5, f4, f5
	fmul	f4, f3, f1
	lw	r2, 9(r1)
	flw	f3, 1(r2)
	fmul	f3, f4, f3
	fadd	f3, f5, f3
	fmul	f2, f1, f2
	lw	r1, 9(r1)
	flw	f1, 2(r1)
	fmul	f1, f2, f1
	fadd	f1, f3, f1
	jr	r31				#
beq_then.16160:
	fadd	f1, f0, f4
	jr	r31				#
bilinear.3036:
	fmul	f8, f1, f4
	lw	r2, 4(r1)
	flw	f7, 0(r2)
	fmul	f9, f8, f7
	fmul	f8, f2, f5
	lw	r2, 4(r1)
	flw	f7, 1(r2)
	fmul	f7, f8, f7
	fadd	f9, f9, f7
	fmul	f8, f3, f6
	lw	r2, 4(r1)
	flw	f7, 2(r2)
	fmul	f7, f8, f7
	fadd	f7, f9, f7
	lw	r2, 3(r1)
	beqi	0, r2, beq_then.16161
	fmul	f9, f3, f5
	fmul	f8, f2, f6
	fadd	f9, f9, f8
	lw	r2, 9(r1)
	flw	f8, 0(r2)
	fmul	f8, f9, f8
	fmul	f6, f1, f6
	fmul	f3, f3, f4
	fadd	f6, f6, f3
	lw	r2, 9(r1)
	flw	f3, 1(r2)
	fmul	f3, f6, f3
	fadd	f6, f8, f3
	fmul	f3, f1, f5
	fmul	f1, f2, f4
	fadd	f2, f3, f1
	lw	r1, 9(r1)
	flw	f1, 2(r1)
	fmul	f1, f2, f1
	fadd	f2, f6, f1
	flup	f1, 1		# fli	f1, 0.500000
	fmul	f1, f2, f1
	fadd	f1, f7, f1
	jr	r31				#
beq_then.16161:
	fadd	f1, f0, f7
	jr	r31				#
solver_second.3044:
	flw	f6, 0(r2)
	flw	f5, 1(r2)
	flw	f4, 2(r2)
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	fadd	f3, f0, f4
	fadd	f2, f0, f5
	fadd	f1, f0, f6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	quadratic.3031				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f5, f0, f1
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16162
	addi	r5, r0, 1
	j	feq_cont.16163
feq_else.16162:
	addi	r5, r0, 0
feq_cont.16163:
	beqi	0, r5, beq_then.16164
	addi	r1, r0, 0
	jr	r31				#
beq_then.16164:
	flw	f7, 0(r2)
	flw	f6, 1(r2)
	flw	f4, 2(r2)
	fsw	f5, 8(r3)
	fadd	f5, f0, f2
	fadd	f2, f0, f6
	fadd	f6, f0, f3
	fadd	f3, f0, f4
	fadd	f4, f0, f1
	fadd	f1, f0, f7
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	bilinear.3036				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	fadd	f4, f0, f1
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	flw	f5, 8(r3)
	lw	r1, 6(r3)
	fsw	f4, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	quadratic.3031				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f4, 10(r3)
	flw	f5, 8(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16165
	fadd	f2, f0, f1
	j	beq_cont.16166
beq_then.16165:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f1, f2
beq_cont.16166:
	fmul	f3, f4, f4
	fmul	f1, f5, f2
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16167
	addi	r2, r0, 0
	j	fle_cont.16168
fle_else.16167:
	addi	r2, r0, 1
fle_cont.16168:
	beqi	0, r2, beq_then.16169
	fsqrt	f2, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16170
	fadd	f1, f0, f2
	j	beq_cont.16171
beq_then.16170:
	fneg	f1, f2
beq_cont.16171:
	fsub	f1, f1, f4
	finv	f31, f5
	fmul	f1, f1, f31
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16169:
	addi	r1, r0, 0
	jr	r31				#
solver.3050:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r1
	lw	r6, 0(r30)
	flw	f2, 0(r5)
	lw	r1, 5(r6)
	flw	f1, 0(r1)
	fsub	f4, f2, f1
	flw	f2, 1(r5)
	lw	r1, 5(r6)
	flw	f1, 1(r1)
	fsub	f3, f2, f1
	flw	f2, 2(r5)
	lw	r1, 5(r6)
	flw	f1, 2(r1)
	fsub	f2, f2, f1
	lw	r1, 1(r6)
	beqi	1, r1, beq_then.16172
	beqi	2, r1, beq_then.16173
	add	r1, r0, r6
	fadd	f1, f0, f4
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f30
	j	solver_second.3044
beq_then.16173:
	lw	r1, 4(r6)
	flw	f5, 0(r2)
	flw	f1, 0(r1)
	fmul	f6, f5, f1
	flw	f5, 1(r2)
	flw	f1, 1(r1)
	fmul	f1, f5, f1
	fadd	f6, f6, f1
	flw	f5, 2(r2)
	flw	f1, 2(r1)
	fmul	f1, f5, f1
	fadd	f1, f6, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16174
	addi	r2, r0, 0
	j	fle_cont.16175
fle_else.16174:
	addi	r2, r0, 1
fle_cont.16175:
	beqi	0, r2, beq_then.16176
	flw	f5, 0(r1)
	fmul	f5, f5, f4
	flw	f4, 1(r1)
	fmul	f3, f4, f3
	fadd	f4, f5, f3
	flw	f3, 2(r1)
	fmul	f2, f3, f2
	fadd	f2, f4, f2
	fneg	f2, f2
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16176:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16172:
	addi	r7, r0, 0
	addi	r5, r0, 1
	addi	r1, r0, 2
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
	fsw	f4, 4(r3)
	sw	r6, 6(r3)
	sw	r2, 7(r3)
	add	r28, r0, r7
	add	r7, r0, r1
	add	r1, r0, r6
	add	r6, r0, r5
	add	r5, r0, r28
	fadd	f1, f0, f4
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 0(r3)
	flw	f3, 2(r3)
	flw	f4, 4(r3)
	lw	r6, 6(r3)
	lw	r2, 7(r3)
	beqi	0, r1, beq_then.16177
	addi	r1, r0, 1
	jr	r31				#
beq_then.16177:
	addi	r7, r0, 1
	addi	r5, r0, 2
	addi	r1, r0, 0
	add	r28, r0, r7
	add	r7, r0, r1
	add	r1, r0, r6
	add	r6, r0, r5
	add	r5, r0, r28
	fadd	f1, f0, f3
	fadd	f3, f0, f4
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 0(r3)
	flw	f3, 2(r3)
	flw	f4, 4(r3)
	lw	r6, 6(r3)
	lw	r2, 7(r3)
	beqi	0, r1, beq_then.16178
	addi	r1, r0, 2
	jr	r31				#
beq_then.16178:
	addi	r7, r0, 2
	addi	r5, r0, 0
	addi	r1, r0, 1
	add	r28, r0, r7
	add	r7, r0, r1
	add	r1, r0, r6
	add	r6, r0, r5
	add	r5, r0, r28
	fadd	f1, f0, f2
	fadd	f2, f0, f4
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.16179
	addi	r1, r0, 3
	jr	r31				#
beq_then.16179:
	addi	r1, r0, 0
	jr	r31				#
solver_rect_fast.3054:
	flw	f4, 0(r5)
	fsub	f5, f4, f1
	flw	f4, 1(r5)
	fmul	f4, f5, f4
	lw	r6, 4(r1)
	flw	f7, 1(r6)
	flw	f5, 1(r2)
	fmul	f5, f4, f5
	fadd	f6, f5, f2
	fle	r30, f0, f6
	beq	r0, r30, fle_else.16180
	fadd	f5, f0, f6
	j	fle_cont.16181
fle_else.16180:
	fneg	f5, f6
fle_cont.16181:
	fle	r30, f7, f5
	beq	r0, r30, fle_else.16182
	addi	r6, r0, 0
	j	fle_cont.16183
fle_else.16182:
	lw	r1, 4(r1)
	flw	f5, 2(r1)
	flw	f1, 2(r2)
	fmul	f1, f4, f1
	fadd	f2, f1, f3
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16184
	fadd	f1, f0, f2
	j	fle_cont.16185
fle_else.16184:
	fneg	f1, f2
fle_cont.16185:
	fle	r30, f5, f1
	beq	r0, r30, fle_else.16186
	addi	r6, r0, 0
	j	fle_cont.16187
fle_else.16186:
	flw	f1, 1(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16188
	addi	r1, r0, 1
	j	feq_cont.16189
feq_else.16188:
	addi	r1, r0, 0
feq_cont.16189:
	beqi	0, r1, beq_then.16190
	addi	r6, r0, 0
	j	beq_cont.16191
beq_then.16190:
	addi	r6, r0, 1
beq_cont.16191:
fle_cont.16187:
fle_cont.16183:
	beqi	0, r6, beq_then.16192
	fsw	f4, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16192:
	flw	f4, 2(r5)
	fsub	f5, f4, f2
	flw	f4, 3(r5)
	fmul	f4, f5, f4
	lw	r6, 4(r1)
	flw	f7, 0(r6)
	flw	f5, 0(r2)
	fmul	f5, f4, f5
	fadd	f6, f5, f1
	fle	r30, f0, f6
	beq	r0, r30, fle_else.16193
	fadd	f5, f0, f6
	j	fle_cont.16194
fle_else.16193:
	fneg	f5, f6
fle_cont.16194:
	fle	r30, f7, f5
	beq	r0, r30, fle_else.16195
	addi	r6, r0, 0
	j	fle_cont.16196
fle_else.16195:
	lw	r1, 4(r1)
	flw	f5, 2(r1)
	flw	f1, 2(r2)
	fmul	f1, f4, f1
	fadd	f2, f1, f3
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16197
	fadd	f1, f0, f2
	j	fle_cont.16198
fle_else.16197:
	fneg	f1, f2
fle_cont.16198:
	fle	r30, f5, f1
	beq	r0, r30, fle_else.16199
	addi	r6, r0, 0
	j	fle_cont.16200
fle_else.16199:
	flw	f1, 3(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16201
	addi	r1, r0, 1
	j	feq_cont.16202
feq_else.16201:
	addi	r1, r0, 0
feq_cont.16202:
	beqi	0, r1, beq_then.16203
	addi	r6, r0, 0
	j	beq_cont.16204
beq_then.16203:
	addi	r6, r0, 1
beq_cont.16204:
fle_cont.16200:
fle_cont.16196:
	beqi	0, r6, beq_then.16205
	fsw	f4, 724(r0)
	addi	r1, r0, 2
	jr	r31				#
beq_then.16205:
	flw	f4, 4(r5)
	fsub	f4, f4, f3
	flw	f3, 5(r5)
	fmul	f3, f4, f3
	lw	r6, 4(r1)
	flw	f5, 0(r6)
	flw	f4, 0(r2)
	fmul	f4, f3, f4
	fadd	f4, f4, f1
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16206
	fadd	f1, f0, f4
	j	fle_cont.16207
fle_else.16206:
	fneg	f1, f4
fle_cont.16207:
	fle	r30, f5, f1
	beq	r0, r30, fle_else.16208
	addi	r6, r0, 0
	j	fle_cont.16209
fle_else.16208:
	lw	r1, 4(r1)
	flw	f4, 1(r1)
	flw	f1, 1(r2)
	fmul	f1, f3, f1
	fadd	f2, f1, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16210
	fadd	f1, f0, f2
	j	fle_cont.16211
fle_else.16210:
	fneg	f1, f2
fle_cont.16211:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16212
	addi	r6, r0, 0
	j	fle_cont.16213
fle_else.16212:
	flw	f1, 5(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16214
	addi	r1, r0, 1
	j	feq_cont.16215
feq_else.16214:
	addi	r1, r0, 0
feq_cont.16215:
	beqi	0, r1, beq_then.16216
	addi	r6, r0, 0
	j	beq_cont.16217
beq_then.16216:
	addi	r6, r0, 1
beq_cont.16217:
fle_cont.16213:
fle_cont.16209:
	beqi	0, r6, beq_then.16218
	fsw	f3, 724(r0)
	addi	r1, r0, 3
	jr	r31				#
beq_then.16218:
	addi	r1, r0, 0
	jr	r31				#
solver_surface_fast.3061:
	flw	f4, 0(r2)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16219
	addi	r1, r0, 0
	j	fle_cont.16220
fle_else.16219:
	addi	r1, r0, 1
fle_cont.16220:
	beqi	0, r1, beq_then.16221
	flw	f4, 1(r2)
	fmul	f4, f4, f1
	flw	f1, 2(r2)
	fmul	f1, f1, f2
	fadd	f2, f4, f1
	flw	f1, 3(r2)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16221:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3067:
	flw	f5, 0(r2)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16222
	addi	r5, r0, 1
	j	feq_cont.16223
feq_else.16222:
	addi	r5, r0, 0
feq_cont.16223:
	beqi	0, r5, beq_then.16224
	addi	r1, r0, 0
	jr	r31				#
beq_then.16224:
	flw	f4, 1(r2)
	fmul	f6, f4, f1
	flw	f4, 2(r2)
	fmul	f4, f4, f2
	fadd	f6, f6, f4
	flw	f4, 3(r2)
	fmul	f4, f4, f3
	fadd	f4, f6, f4
	fsw	f4, 0(r3)
	fsw	f5, 2(r3)
	sw	r1, 4(r3)
	sw	r2, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	quadratic.3031				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f4, 0(r3)
	flw	f5, 2(r3)
	lw	r1, 4(r3)
	lw	r2, 5(r3)
	lw	r5, 1(r1)
	beqi	3, r5, beq_then.16225
	fadd	f2, f0, f1
	j	beq_cont.16226
beq_then.16225:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f1, f2
beq_cont.16226:
	fmul	f3, f4, f4
	fmul	f1, f5, f2
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16227
	addi	r5, r0, 0
	j	fle_cont.16228
fle_else.16227:
	addi	r5, r0, 1
fle_cont.16228:
	beqi	0, r5, beq_then.16229
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16230
	fsqrt	f1, f1
	fadd	f2, f4, f1
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 724(r0)
	j	beq_cont.16231
beq_then.16230:
	fsqrt	f1, f1
	fsub	f2, f4, f1
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 724(r0)
beq_cont.16231:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16229:
	addi	r1, r0, 0
	jr	r31				#
solver_fast.3073:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r1
	lw	r7, 0(r30)
	flw	f2, 0(r5)
	lw	r6, 5(r7)
	flw	f1, 0(r6)
	fsub	f3, f2, f1
	flw	f2, 1(r5)
	lw	r6, 5(r7)
	flw	f1, 1(r6)
	fsub	f2, f2, f1
	flw	f4, 2(r5)
	lw	r5, 5(r7)
	flw	f1, 2(r5)
	fsub	f1, f4, f1
	lw	r5, 1(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r1, 1(r7)
	beqi	1, r1, beq_then.16232
	beqi	2, r1, beq_then.16233
	add	r2, r0, r5
	add	r1, r0, r7
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	j	solver_second_fast.3067
beq_then.16233:
	flw	f4, 0(r5)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16234
	addi	r1, r0, 0
	j	fle_cont.16235
fle_else.16234:
	addi	r1, r0, 1
fle_cont.16235:
	beqi	0, r1, beq_then.16236
	flw	f4, 1(r5)
	fmul	f4, f4, f3
	flw	f3, 2(r5)
	fmul	f2, f3, f2
	fadd	f3, f4, f2
	flw	f2, 3(r5)
	fmul	f1, f2, f1
	fadd	f1, f3, f1
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16236:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16232:
	lw	r1, 0(r2)
	add	r2, r0, r1
	add	r1, r0, r7
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	j	solver_rect_fast.3054
solver_surface_fast2.3077:
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16237
	addi	r1, r0, 0
	j	fle_cont.16238
fle_else.16237:
	addi	r1, r0, 1
fle_cont.16238:
	beqi	0, r1, beq_then.16239
	flw	f2, 0(r2)
	flw	f1, 3(r5)
	fmul	f1, f2, f1
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16239:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3084:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16240
	addi	r6, r0, 1
	j	feq_cont.16241
feq_else.16240:
	addi	r6, r0, 0
feq_cont.16241:
	beqi	0, r6, beq_then.16242
	addi	r1, r0, 0
	jr	r31				#
beq_then.16242:
	flw	f5, 1(r2)
	fmul	f5, f5, f1
	flw	f1, 2(r2)
	fmul	f1, f1, f2
	fadd	f2, f5, f1
	flw	f1, 3(r2)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	flw	f2, 3(r5)
	fmul	f3, f1, f1
	fmul	f2, f4, f2
	fsub	f2, f3, f2
	fle	r30, f2, f0
	beq	r0, r30, fle_else.16243
	addi	r5, r0, 0
	j	fle_cont.16244
fle_else.16243:
	addi	r5, r0, 1
fle_cont.16244:
	beqi	0, r5, beq_then.16245
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16246
	fsqrt	f2, f2
	fadd	f2, f1, f2
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 724(r0)
	j	beq_cont.16247
beq_then.16246:
	fsqrt	f2, f2
	fsub	f2, f1, f2
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 724(r0)
beq_cont.16247:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16245:
	addi	r1, r0, 0
	jr	r31				#
solver_fast2.3091:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r1
	lw	r7, 0(r30)
	lw	r5, 10(r7)
	flw	f3, 0(r5)
	flw	f2, 1(r5)
	flw	f1, 2(r5)
	lw	r6, 1(r2)
	add	r30, r6, r1
	lw	r6, 0(r30)
	lw	r1, 1(r7)
	beqi	1, r1, beq_then.16248
	beqi	2, r1, beq_then.16249
	add	r2, r0, r6
	add	r1, r0, r7
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	j	solver_second_fast2.3084
beq_then.16249:
	flw	f1, 0(r6)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16250
	addi	r1, r0, 0
	j	fle_cont.16251
fle_else.16250:
	addi	r1, r0, 1
fle_cont.16251:
	beqi	0, r1, beq_then.16252
	flw	f2, 0(r6)
	flw	f1, 3(r5)
	fmul	f1, f2, f1
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16252:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16248:
	lw	r1, 0(r2)
	add	r5, r0, r6
	add	r2, r0, r1
	add	r1, r0, r7
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	j	solver_rect_fast.3054
setup_rect_table.3094:
	addi	r5, r0, 6
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r6, r0, r1
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16253
	addi	r5, r0, 1
	j	feq_cont.16254
feq_else.16253:
	addi	r5, r0, 0
feq_cont.16254:
	beqi	0, r5, beq_then.16255
	fsw	f0, 1(r6)
	j	beq_cont.16256
beq_then.16255:
	lw	r5, 6(r2)
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16257
	addi	r8, r0, 0
	j	fle_cont.16258
fle_else.16257:
	addi	r8, r0, 1
fle_cont.16258:
	beqi	0, r5, beq_then.16259
	beqi	0, r8, beq_then.16261
	addi	r7, r0, 0
	j	beq_cont.16262
beq_then.16261:
	addi	r7, r0, 1
beq_cont.16262:
	j	beq_cont.16260
beq_then.16259:
	add	r7, r0, r8
beq_cont.16260:
	lw	r5, 4(r2)
	flw	f2, 0(r5)
	beqi	0, r7, beq_then.16263
	fadd	f1, f0, f2
	j	beq_cont.16264
beq_then.16263:
	fneg	f1, f2
beq_cont.16264:
	fsw	f1, 0(r6)
	flup	f2, 2		# fli	f2, 1.000000
	flw	f1, 0(r1)
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 1(r6)
beq_cont.16256:
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16265
	addi	r5, r0, 1
	j	feq_cont.16266
feq_else.16265:
	addi	r5, r0, 0
feq_cont.16266:
	beqi	0, r5, beq_then.16267
	fsw	f0, 3(r6)
	j	beq_cont.16268
beq_then.16267:
	lw	r5, 6(r2)
	flw	f1, 1(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16269
	addi	r8, r0, 0
	j	fle_cont.16270
fle_else.16269:
	addi	r8, r0, 1
fle_cont.16270:
	beqi	0, r5, beq_then.16271
	beqi	0, r8, beq_then.16273
	addi	r7, r0, 0
	j	beq_cont.16274
beq_then.16273:
	addi	r7, r0, 1
beq_cont.16274:
	j	beq_cont.16272
beq_then.16271:
	add	r7, r0, r8
beq_cont.16272:
	lw	r5, 4(r2)
	flw	f2, 1(r5)
	beqi	0, r7, beq_then.16275
	fadd	f1, f0, f2
	j	beq_cont.16276
beq_then.16275:
	fneg	f1, f2
beq_cont.16276:
	fsw	f1, 2(r6)
	flup	f2, 2		# fli	f2, 1.000000
	flw	f1, 1(r1)
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 3(r6)
beq_cont.16268:
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16277
	addi	r5, r0, 1
	j	feq_cont.16278
feq_else.16277:
	addi	r5, r0, 0
feq_cont.16278:
	beqi	0, r5, beq_then.16279
	fsw	f0, 5(r6)
	j	beq_cont.16280
beq_then.16279:
	lw	r5, 6(r2)
	flw	f1, 2(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16281
	addi	r7, r0, 0
	j	fle_cont.16282
fle_else.16281:
	addi	r7, r0, 1
fle_cont.16282:
	beqi	0, r5, beq_then.16283
	beqi	0, r7, beq_then.16285
	addi	r5, r0, 0
	j	beq_cont.16286
beq_then.16285:
	addi	r5, r0, 1
beq_cont.16286:
	j	beq_cont.16284
beq_then.16283:
	add	r5, r0, r7
beq_cont.16284:
	lw	r2, 4(r2)
	flw	f2, 2(r2)
	beqi	0, r5, beq_then.16287
	fadd	f1, f0, f2
	j	beq_cont.16288
beq_then.16287:
	fneg	f1, f2
beq_cont.16288:
	fsw	f1, 4(r6)
	flup	f2, 2		# fli	f2, 1.000000
	flw	f1, 2(r1)
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 5(r6)
beq_cont.16280:
	add	r1, r0, r6
	jr	r31				#
setup_surface_table.3097:
	addi	r5, r0, 4
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r6, r0, r1
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	flw	f2, 0(r1)
	lw	r5, 4(r2)
	flw	f1, 0(r5)
	fmul	f3, f2, f1
	flw	f2, 1(r1)
	lw	r5, 4(r2)
	flw	f1, 1(r5)
	fmul	f1, f2, f1
	fadd	f3, f3, f1
	flw	f2, 2(r1)
	lw	r1, 4(r2)
	flw	f1, 2(r1)
	fmul	f1, f2, f1
	fadd	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16289
	addi	r1, r0, 0
	j	fle_cont.16290
fle_else.16289:
	addi	r1, r0, 1
fle_cont.16290:
	beqi	0, r1, beq_then.16291
	flup	f2, 11		# fli	f2, -1.000000
	finv	f31, f1
	fmul	f2, f2, f31
	fsw	f2, 0(r6)
	lw	r1, 4(r2)
	flw	f2, 0(r1)
	finv	f31, f1
	fmul	f2, f2, f31
	fneg	f2, f2
	fsw	f2, 1(r6)
	lw	r1, 4(r2)
	flw	f2, 1(r1)
	finv	f31, f1
	fmul	f2, f2, f31
	fneg	f2, f2
	fsw	f2, 2(r6)
	lw	r1, 4(r2)
	flw	f2, 2(r1)
	finv	f31, f1
	fmul	f1, f2, f31
	fneg	f1, f1
	fsw	f1, 3(r6)
	j	beq_cont.16292
beq_then.16291:
	fsw	f0, 0(r6)
beq_cont.16292:
	add	r1, r0, r6
	jr	r31				#
setup_second_table.3100:
	addi	r5, r0, 5
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r6, r0, r1
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	flw	f3, 0(r1)
	flw	f2, 1(r1)
	flw	f1, 2(r1)
	sw	r6, 2(r3)
	add	r1, r0, r2
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	quadratic.3031				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	fadd	f4, f0, f1
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	flw	f2, 0(r1)
	lw	r5, 4(r2)
	flw	f1, 0(r5)
	fmul	f1, f2, f1
	fneg	f3, f1
	flw	f2, 1(r1)
	lw	r5, 4(r2)
	flw	f1, 1(r5)
	fmul	f1, f2, f1
	fneg	f2, f1
	flw	f5, 2(r1)
	lw	r5, 4(r2)
	flw	f1, 2(r5)
	fmul	f1, f5, f1
	fneg	f1, f1
	fsw	f4, 0(r6)
	lw	r5, 3(r2)
	beqi	0, r5, beq_then.16293
	flw	f6, 2(r1)
	lw	r5, 9(r2)
	flw	f5, 1(r5)
	fmul	f7, f6, f5
	flw	f6, 1(r1)
	lw	r5, 9(r2)
	flw	f5, 2(r5)
	fmul	f5, f6, f5
	fadd	f6, f7, f5
	flup	f5, 1		# fli	f5, 0.500000
	fmul	f5, f6, f5
	fsub	f3, f3, f5
	fsw	f3, 1(r6)
	flw	f5, 2(r1)
	lw	r5, 9(r2)
	flw	f3, 0(r5)
	fmul	f6, f5, f3
	flw	f5, 0(r1)
	lw	r5, 9(r2)
	flw	f3, 2(r5)
	fmul	f3, f5, f3
	fadd	f5, f6, f3
	flup	f3, 1		# fli	f3, 0.500000
	fmul	f3, f5, f3
	fsub	f2, f2, f3
	fsw	f2, 2(r6)
	flw	f3, 1(r1)
	lw	r5, 9(r2)
	flw	f2, 0(r5)
	fmul	f5, f3, f2
	flw	f3, 0(r1)
	lw	r1, 9(r2)
	flw	f2, 1(r1)
	fmul	f2, f3, f2
	fadd	f3, f5, f2
	flup	f2, 1		# fli	f2, 0.500000
	fmul	f2, f3, f2
	fsub	f1, f1, f2
	fsw	f1, 3(r6)
	j	beq_cont.16294
beq_then.16293:
	fsw	f3, 1(r6)
	fsw	f2, 2(r6)
	fsw	f1, 3(r6)
beq_cont.16294:
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16295
	addi	r1, r0, 1
	j	feq_cont.16296
feq_else.16295:
	addi	r1, r0, 0
feq_cont.16296:
	beqi	0, r1, beq_then.16297
	j	beq_cont.16298
beq_then.16297:
	flup	f1, 2		# fli	f1, 1.000000
	finv	f31, f4
	fmul	f1, f1, f31
	fsw	f1, 4(r6)
beq_cont.16298:
	add	r1, r0, r6
	jr	r31				#
iter_setup_dirvec_constants.3103:
	bgei	0, r2, bge_then.16299
	jr	r31				#
bge_then.16299:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r2
	lw	r8, 0(r30)
	lw	r7, 1(r1)
	lw	r5, 0(r1)
	lw	r6, 1(r8)
	beqi	1, r6, beq_then.16301
	beqi	2, r6, beq_then.16303
	sw	r7, 0(r3)
	sw	r2, 1(r3)
	add	r2, r0, r8
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	setup_second_table.3100				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r7, 0(r3)
	lw	r2, 1(r3)
	add	r30, r7, r2
	sw	r1, 0(r30)
	j	beq_cont.16304
beq_then.16303:
	sw	r7, 0(r3)
	sw	r2, 1(r3)
	add	r2, r0, r8
	add	r1, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	setup_surface_table.3097				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r7, 0(r3)
	lw	r2, 1(r3)
	add	r30, r7, r2
	sw	r1, 0(r30)
beq_cont.16304:
	j	beq_cont.16302
beq_then.16301:
	sw	r7, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	add	r2, r0, r8
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_rect_table.3094				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r7, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	add	r30, r7, r2
	sw	r5, 0(r30)
beq_cont.16302:
	addi	r8, r2, -1
	bgei	0, r8, bge_then.16305
	jr	r31				#
bge_then.16305:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r8
	lw	r7, 0(r30)
	lw	r6, 1(r1)
	lw	r2, 0(r1)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.16307
	beqi	2, r5, beq_then.16309
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3100				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r6, 3(r3)
	lw	r8, 4(r3)
	add	r30, r6, r8
	sw	r1, 0(r30)
	j	beq_cont.16310
beq_then.16309:
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3097				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r6, 3(r3)
	lw	r8, 4(r3)
	add	r30, r6, r8
	sw	r1, 0(r30)
beq_cont.16310:
	j	beq_cont.16308
beq_then.16307:
	sw	r6, 3(r3)
	sw	r1, 2(r3)
	sw	r8, 4(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3094				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
	lw	r6, 3(r3)
	lw	r1, 2(r3)
	lw	r8, 4(r3)
	add	r30, r6, r8
	sw	r2, 0(r30)
beq_cont.16308:
	addi	r2, r8, -1
	j	iter_setup_dirvec_constants.3103
setup_dirvec_constants.3106:
	lw	r2, 0(r0)
	addi	r8, r2, -1
	bgei	0, r8, bge_then.16311
	jr	r31				#
bge_then.16311:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r8
	lw	r7, 0(r30)
	lw	r6, 1(r1)
	lw	r2, 0(r1)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.16313
	beqi	2, r5, beq_then.16315
	sw	r6, 0(r3)
	sw	r8, 1(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	setup_second_table.3100				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r6, 0(r3)
	lw	r8, 1(r3)
	add	r30, r6, r8
	sw	r1, 0(r30)
	j	beq_cont.16316
beq_then.16315:
	sw	r6, 0(r3)
	sw	r8, 1(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	setup_surface_table.3097				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r6, 0(r3)
	lw	r8, 1(r3)
	add	r30, r6, r8
	sw	r1, 0(r30)
beq_cont.16316:
	j	beq_cont.16314
beq_then.16313:
	sw	r6, 0(r3)
	sw	r1, 2(r3)
	sw	r8, 1(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_rect_table.3094				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r6, 0(r3)
	lw	r1, 2(r3)
	lw	r8, 1(r3)
	add	r30, r6, r8
	sw	r2, 0(r30)
beq_cont.16314:
	addi	r2, r8, -1
	j	iter_setup_dirvec_constants.3103
setup_startp_constants.3108:
	bgei	0, r2, bge_then.16317
	jr	r31				#
bge_then.16317:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r8, 10(r5)
	lw	r7, 1(r5)
	flw	f2, 0(r1)
	lw	r6, 5(r5)
	flw	f1, 0(r6)
	fsub	f1, f2, f1
	fsw	f1, 0(r8)
	flw	f2, 1(r1)
	lw	r6, 5(r5)
	flw	f1, 1(r6)
	fsub	f1, f2, f1
	fsw	f1, 1(r8)
	flw	f2, 2(r1)
	lw	r6, 5(r5)
	flw	f1, 2(r6)
	fsub	f1, f2, f1
	fsw	f1, 2(r8)
	beqi	2, r7, beq_then.16319
	blei	2, r7, ble_then.16321
	flw	f3, 0(r8)
	flw	f2, 1(r8)
	flw	f1, 2(r8)
	sw	r7, 0(r3)
	sw	r8, 1(r3)
	add	r1, r0, r5
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	quadratic.3031				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r7, 0(r3)
	lw	r8, 1(r3)
	beqi	3, r7, beq_then.16323
	fadd	f2, f0, f1
	j	beq_cont.16324
beq_then.16323:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f1, f2
beq_cont.16324:
	fsw	f2, 3(r8)
	j	ble_cont.16322
ble_then.16321:
ble_cont.16322:
	j	beq_cont.16320
beq_then.16319:
	lw	r5, 4(r5)
	flw	f2, 0(r8)
	flw	f4, 1(r8)
	flw	f3, 2(r8)
	flw	f1, 0(r5)
	fmul	f2, f1, f2
	flw	f1, 1(r5)
	fmul	f1, f1, f4
	fadd	f2, f2, f1
	flw	f1, 2(r5)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	fsw	f1, 3(r8)
beq_cont.16320:
	addi	r2, r2, -1
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
	flw	f5, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16325
	fadd	f4, f0, f1
	j	fle_cont.16326
fle_else.16325:
	fneg	f4, f1
fle_cont.16326:
	fle	r30, f5, f4
	beq	r0, r30, fle_else.16327
	addi	r2, r0, 0
	j	fle_cont.16328
fle_else.16327:
	lw	r2, 4(r1)
	flw	f4, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16329
	fadd	f1, f0, f2
	j	fle_cont.16330
fle_else.16329:
	fneg	f1, f2
fle_cont.16330:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16331
	addi	r2, r0, 0
	j	fle_cont.16332
fle_else.16331:
	lw	r1, 4(r1)
	flw	f2, 2(r1)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16333
	fadd	f1, f0, f3
	j	fle_cont.16334
fle_else.16333:
	fneg	f1, f3
fle_cont.16334:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16335
	addi	r2, r0, 0
	j	fle_cont.16336
fle_else.16335:
	addi	r2, r0, 1
fle_cont.16336:
fle_cont.16332:
fle_cont.16328:
	beqi	0, r2, beq_then.16337
	lw	r1, 6(r1)
	jr	r31				#
beq_then.16337:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16338
	addi	r1, r0, 0
	jr	r31				#
beq_then.16338:
	addi	r1, r0, 1
	jr	r31				#
is_plane_outside.3118:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fmul	f4, f4, f1
	flw	f1, 1(r2)
	fmul	f1, f1, f2
	fadd	f2, f4, f1
	flw	f1, 2(r2)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16339
	addi	r2, r0, 0
	j	fle_cont.16340
fle_else.16339:
	addi	r2, r0, 1
fle_cont.16340:
	beqi	0, r1, beq_then.16341
	beqi	0, r2, beq_then.16343
	addi	r1, r0, 0
	j	beq_cont.16344
beq_then.16343:
	addi	r1, r0, 1
beq_cont.16344:
	j	beq_cont.16342
beq_then.16341:
	add	r1, r0, r2
beq_cont.16342:
	beqi	0, r1, beq_then.16345
	addi	r1, r0, 0
	jr	r31				#
beq_then.16345:
	addi	r1, r0, 1
	jr	r31				#
is_second_outside.3123:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3031				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	fadd	f2, f0, f1
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16346
	fadd	f1, f0, f2
	j	beq_cont.16347
beq_then.16346:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
beq_cont.16347:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16348
	addi	r2, r0, 0
	j	fle_cont.16349
fle_else.16348:
	addi	r2, r0, 1
fle_cont.16349:
	beqi	0, r1, beq_then.16350
	beqi	0, r2, beq_then.16352
	addi	r1, r0, 0
	j	beq_cont.16353
beq_then.16352:
	addi	r1, r0, 1
beq_cont.16353:
	j	beq_cont.16351
beq_then.16350:
	add	r1, r0, r2
beq_cont.16351:
	beqi	0, r1, beq_then.16354
	addi	r1, r0, 0
	jr	r31				#
beq_then.16354:
	addi	r1, r0, 1
	jr	r31				#
is_outside.3128:
	lw	r2, 5(r1)
	flw	f4, 0(r2)
	fsub	f4, f1, f4
	lw	r2, 5(r1)
	flw	f1, 1(r2)
	fsub	f2, f2, f1
	lw	r2, 5(r1)
	flw	f1, 2(r2)
	fsub	f1, f3, f1
	lw	r2, 1(r1)
	beqi	1, r2, beq_then.16355
	beqi	2, r2, beq_then.16356
	sw	r1, 0(r3)
	fadd	f3, f0, f1
	fadd	f1, f0, f4
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3031				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	fadd	f2, f0, f1
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16357
	fadd	f1, f0, f2
	j	beq_cont.16358
beq_then.16357:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
beq_cont.16358:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16359
	addi	r2, r0, 0
	j	fle_cont.16360
fle_else.16359:
	addi	r2, r0, 1
fle_cont.16360:
	beqi	0, r1, beq_then.16361
	beqi	0, r2, beq_then.16363
	addi	r1, r0, 0
	j	beq_cont.16364
beq_then.16363:
	addi	r1, r0, 1
beq_cont.16364:
	j	beq_cont.16362
beq_then.16361:
	add	r1, r0, r2
beq_cont.16362:
	beqi	0, r1, beq_then.16365
	addi	r1, r0, 0
	jr	r31				#
beq_then.16365:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16356:
	lw	r2, 4(r1)
	flw	f3, 0(r2)
	fmul	f4, f3, f4
	flw	f3, 1(r2)
	fmul	f2, f3, f2
	fadd	f3, f4, f2
	flw	f2, 2(r2)
	fmul	f1, f2, f1
	fadd	f1, f3, f1
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16366
	addi	r2, r0, 0
	j	fle_cont.16367
fle_else.16366:
	addi	r2, r0, 1
fle_cont.16367:
	beqi	0, r1, beq_then.16368
	beqi	0, r2, beq_then.16370
	addi	r1, r0, 0
	j	beq_cont.16371
beq_then.16370:
	addi	r1, r0, 1
beq_cont.16371:
	j	beq_cont.16369
beq_then.16368:
	add	r1, r0, r2
beq_cont.16369:
	beqi	0, r1, beq_then.16372
	addi	r1, r0, 0
	jr	r31				#
beq_then.16372:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16355:
	lw	r2, 4(r1)
	flw	f5, 0(r2)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16373
	fadd	f3, f0, f4
	j	fle_cont.16374
fle_else.16373:
	fneg	f3, f4
fle_cont.16374:
	fle	r30, f5, f3
	beq	r0, r30, fle_else.16375
	addi	r2, r0, 0
	j	fle_cont.16376
fle_else.16375:
	lw	r2, 4(r1)
	flw	f4, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16377
	fadd	f3, f0, f2
	j	fle_cont.16378
fle_else.16377:
	fneg	f3, f2
fle_cont.16378:
	fle	r30, f4, f3
	beq	r0, r30, fle_else.16379
	addi	r2, r0, 0
	j	fle_cont.16380
fle_else.16379:
	lw	r1, 4(r1)
	flw	f3, 2(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16381
	fadd	f2, f0, f1
	j	fle_cont.16382
fle_else.16381:
	fneg	f2, f1
fle_cont.16382:
	fle	r30, f3, f2
	beq	r0, r30, fle_else.16383
	addi	r2, r0, 0
	j	fle_cont.16384
fle_else.16383:
	addi	r2, r0, 1
fle_cont.16384:
fle_cont.16380:
fle_cont.16376:
	beqi	0, r2, beq_then.16385
	lw	r1, 6(r1)
	jr	r31				#
beq_then.16385:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16386
	addi	r1, r0, 0
	jr	r31				#
beq_then.16386:
	addi	r1, r0, 1
	jr	r31				#
check_all_inside.3133:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16387
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r5, 5(r6)
	flw	f4, 0(r5)
	fsub	f6, f1, f4
	lw	r5, 5(r6)
	flw	f4, 1(r5)
	fsub	f5, f2, f4
	lw	r5, 5(r6)
	flw	f4, 2(r5)
	fsub	f4, f3, f4
	lw	r5, 1(r6)
	beqi	1, r5, beq_then.16388
	beqi	2, r5, beq_then.16390
	sw	r6, 0(r3)
	add	r1, r0, r6
	fadd	f3, f0, f4
	fadd	f2, f0, f5
	fadd	f1, f0, f6
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3031				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	fadd	f2, f0, f1
	lw	r6, 0(r3)
	lw	r1, 1(r6)
	beqi	3, r1, beq_then.16392
	fadd	f1, f0, f2
	j	beq_cont.16393
beq_then.16392:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
beq_cont.16393:
	lw	r1, 6(r6)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16394
	addi	r2, r0, 0
	j	fle_cont.16395
fle_else.16394:
	addi	r2, r0, 1
fle_cont.16395:
	beqi	0, r1, beq_then.16396
	beqi	0, r2, beq_then.16398
	addi	r1, r0, 0
	j	beq_cont.16399
beq_then.16398:
	addi	r1, r0, 1
beq_cont.16399:
	j	beq_cont.16397
beq_then.16396:
	add	r1, r0, r2
beq_cont.16397:
	beqi	0, r1, beq_then.16400
	addi	r7, r0, 0
	j	beq_cont.16401
beq_then.16400:
	addi	r7, r0, 1
beq_cont.16401:
	j	beq_cont.16391
beq_then.16390:
	lw	r1, 4(r6)
	flw	f1, 0(r1)
	fmul	f2, f1, f6
	flw	f1, 1(r1)
	fmul	f1, f1, f5
	fadd	f2, f2, f1
	flw	f1, 2(r1)
	fmul	f1, f1, f4
	fadd	f1, f2, f1
	lw	r1, 6(r6)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16402
	addi	r2, r0, 0
	j	fle_cont.16403
fle_else.16402:
	addi	r2, r0, 1
fle_cont.16403:
	beqi	0, r1, beq_then.16404
	beqi	0, r2, beq_then.16406
	addi	r1, r0, 0
	j	beq_cont.16407
beq_then.16406:
	addi	r1, r0, 1
beq_cont.16407:
	j	beq_cont.16405
beq_then.16404:
	add	r1, r0, r2
beq_cont.16405:
	beqi	0, r1, beq_then.16408
	addi	r7, r0, 0
	j	beq_cont.16409
beq_then.16408:
	addi	r7, r0, 1
beq_cont.16409:
beq_cont.16391:
	j	beq_cont.16389
beq_then.16388:
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	fsw	f1, 6(r3)
	sw	r1, 8(r3)
	sw	r2, 9(r3)
	sw	r7, 10(r3)
	add	r1, r0, r6
	fadd	f3, f0, f4
	fadd	f2, f0, f5
	fadd	f1, f0, f6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	is_rect_outside.3113				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r7, r0, r1
beq_cont.16389:
	flw	f3, 2(r3)
	flw	f2, 4(r3)
	flw	f1, 6(r3)
	lw	r1, 8(r3)
	lw	r2, 9(r3)
	beqi	0, r7, beq_then.16411
	addi	r1, r0, 0
	jr	r31				#
beq_then.16411:
	addi	r5, r1, 1
	add	r30, r2, r5
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.16412
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r1
	lw	r1, 0(r30)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	fsw	f1, 6(r3)
	sw	r2, 9(r3)
	sw	r5, 11(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	is_outside.3128				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f3, 2(r3)
	flw	f2, 4(r3)
	flw	f1, 6(r3)
	lw	r2, 9(r3)
	lw	r5, 11(r3)
	beqi	0, r1, beq_then.16413
	addi	r1, r0, 0
	jr	r31				#
beq_then.16413:
	addi	r1, r5, 1
	j	check_all_inside.3133
beq_then.16412:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16387:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3139:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16414
	add	r30, r2, r1
	lw	r6, 0(r30)
	addi	r10, r0, 1021				# set min_caml_light_dirvec
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r6
	lw	r8, 0(r30)
	flw	f2, 727(r0)
	lw	r5, 5(r8)
	flw	f1, 0(r5)
	fsub	f3, f2, f1
	flw	f2, 728(r0)
	lw	r5, 5(r8)
	flw	f1, 1(r5)
	fsub	f2, f2, f1
	flw	f4, 729(r0)
	lw	r5, 5(r8)
	flw	f1, 2(r5)
	fsub	f1, f4, f1
	lw	r5, 1(r10)
	add	r30, r5, r6
	lw	r9, 0(r30)
	lw	r7, 1(r8)
	beqi	1, r7, beq_then.16415
	beqi	2, r7, beq_then.16417
	add	r2, r0, r9
	add	r1, r0, r8
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	solver_second_fast.3067				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	add	r5, r0, r1
	j	beq_cont.16418
beq_then.16417:
	flw	f4, 0(r9)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16419
	addi	r1, r0, 0
	j	fle_cont.16420
fle_else.16419:
	addi	r1, r0, 1
fle_cont.16420:
	beqi	0, r1, beq_then.16421
	flw	f4, 1(r9)
	fmul	f4, f4, f3
	flw	f3, 2(r9)
	fmul	f2, f3, f2
	fadd	f3, f4, f2
	flw	f2, 3(r9)
	fmul	f1, f2, f1
	fadd	f1, f3, f1
	fsw	f1, 724(r0)
	addi	r5, r0, 1
	j	beq_cont.16422
beq_then.16421:
	addi	r5, r0, 0
beq_cont.16422:
beq_cont.16418:
	j	beq_cont.16416
beq_then.16415:
	lw	r5, 0(r10)
	sw	r5, 0(r3)
	sw	r6, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r8
	add	r5, r0, r9
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_rect_fast.3054				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r5, r0, r1
beq_cont.16416:
	lw	r6, 1(r3)
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	flw	f1, 724(r0)
	beqi	0, r5, beq_then.16423
	flup	f2, 28		# fli	f2, -0.200000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16425
	addi	r5, r0, 0
	j	fle_cont.16426
fle_else.16425:
	addi	r5, r0, 1
fle_cont.16426:
	j	beq_cont.16424
beq_then.16423:
	addi	r5, r0, 0
beq_cont.16424:
	beqi	0, r5, beq_then.16427
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	flw	f2, 667(r0)
	fmul	f3, f2, f1
	flw	f2, 727(r0)
	fadd	f3, f3, f2
	flw	f2, 668(r0)
	fmul	f4, f2, f1
	flw	f2, 728(r0)
	fadd	f2, f4, f2
	flw	f4, 669(r0)
	fmul	f4, f4, f1
	flw	f1, 729(r0)
	fadd	f1, f4, f1
	lw	r5, 0(r2)
	beqi	-1, r5, beq_then.16428
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r5
	lw	r1, 0(r30)
	fsw	f1, 4(r3)
	fsw	f2, 6(r3)
	fsw	f3, 8(r3)
	sw	r2, 3(r3)
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	is_outside.3128				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f1, 4(r3)
	flw	f2, 6(r3)
	flw	f3, 8(r3)
	lw	r2, 3(r3)
	beqi	0, r1, beq_then.16430
	addi	r6, r0, 0
	j	beq_cont.16431
beq_then.16430:
	addi	r1, r0, 1
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	check_all_inside.3133				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r6, r0, r1
beq_cont.16431:
	j	beq_cont.16429
beq_then.16428:
	addi	r6, r0, 1
beq_cont.16429:
	beqi	0, r6, beq_then.16432
	addi	r1, r0, 1
	jr	r31				#
beq_then.16432:
	addi	r1, r1, 1
	j	shadow_check_and_group.3139
beq_then.16427:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r6
	lw	r5, 0(r30)
	lw	r5, 6(r5)
	beqi	0, r5, beq_then.16433
	addi	r1, r1, 1
	j	shadow_check_and_group.3139
beq_then.16433:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16414:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3142:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16434
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
	add	r5, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	beqi	0, r5, beq_then.16435
	addi	r1, r0, 1
	jr	r31				#
beq_then.16435:
	addi	r5, r1, 1
	add	r30, r2, r5
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.16436
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r1
	lw	r1, 0(r30)
	addi	r6, r0, 0
	sw	r5, 2(r3)
	add	r2, r0, r1
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	beqi	0, r1, beq_then.16437
	addi	r1, r0, 1
	jr	r31				#
beq_then.16437:
	addi	r5, r5, 1
	add	r30, r2, r5
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.16438
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r1
	lw	r1, 0(r30)
	addi	r6, r0, 0
	sw	r5, 3(r3)
	add	r2, r0, r1
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 0(r3)
	lw	r5, 3(r3)
	beqi	0, r1, beq_then.16439
	addi	r1, r0, 1
	jr	r31				#
beq_then.16439:
	addi	r5, r5, 1
	add	r30, r2, r5
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.16440
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r1
	lw	r1, 0(r30)
	addi	r6, r0, 0
	sw	r5, 4(r3)
	add	r2, r0, r1
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	beqi	0, r1, beq_then.16441
	addi	r1, r0, 1
	jr	r31				#
beq_then.16441:
	addi	r1, r5, 1
	j	shadow_check_one_or_group.3142
beq_then.16440:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16438:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16436:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16434:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3145:
	add	r30, r2, r1
	lw	r7, 0(r30)
	lw	r5, 0(r7)
	beqi	-1, r5, beq_then.16442
	addi	r6, r0, 99
	beq	r5, r6, beq_then.16443
	addi	r8, r0, 1021				# set min_caml_light_dirvec
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r5
	lw	r6, 0(r30)
	flw	f2, 727(r0)
	lw	r1, 5(r6)
	flw	f1, 0(r1)
	fsub	f3, f2, f1
	flw	f2, 728(r0)
	lw	r1, 5(r6)
	flw	f1, 1(r1)
	fsub	f2, f2, f1
	flw	f4, 729(r0)
	lw	r1, 5(r6)
	flw	f1, 2(r1)
	fsub	f1, f4, f1
	lw	r1, 1(r8)
	add	r30, r1, r5
	lw	r5, 0(r30)
	lw	r2, 1(r6)
	beqi	1, r2, beq_then.16445
	beqi	2, r2, beq_then.16447
	add	r2, r0, r5
	add	r1, r0, r6
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	solver_second_fast.3067				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	beq_cont.16448
beq_then.16447:
	flw	f4, 0(r5)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16449
	addi	r1, r0, 0
	j	fle_cont.16450
fle_else.16449:
	addi	r1, r0, 1
fle_cont.16450:
	beqi	0, r1, beq_then.16451
	flw	f4, 1(r5)
	fmul	f4, f4, f3
	flw	f3, 2(r5)
	fmul	f2, f3, f2
	fadd	f3, f4, f2
	flw	f2, 3(r5)
	fmul	f1, f2, f1
	fadd	f1, f3, f1
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	j	beq_cont.16452
beq_then.16451:
	addi	r1, r0, 0
beq_cont.16452:
beq_cont.16448:
	j	beq_cont.16446
beq_then.16445:
	lw	r1, 0(r8)
	sw	r1, 0(r3)
	sw	r7, 1(r3)
	add	r2, r0, r1
	add	r1, r0, r6
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	solver_rect_fast.3054				
	addi	r3, r3, -3
	lw	r31, 2(r3)
beq_cont.16446:
	lw	r7, 1(r3)
	beqi	0, r1, beq_then.16453
	flup	f2, 30		# fli	f2, -0.100000
	flw	f1, 724(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16455
	addi	r6, r0, 0
	j	fle_cont.16456
fle_else.16455:
	lw	r1, 1(r7)
	beqi	-1, r1, beq_then.16457
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	sw	r7, 1(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r7, 1(r3)
	beqi	0, r1, beq_then.16459
	addi	r2, r0, 1
	j	beq_cont.16460
beq_then.16459:
	lw	r1, 2(r7)
	beqi	-1, r1, beq_then.16461
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r7, 1(r3)
	beqi	0, r1, beq_then.16463
	addi	r2, r0, 1
	j	beq_cont.16464
beq_then.16463:
	lw	r1, 3(r7)
	beqi	-1, r1, beq_then.16465
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r7, 1(r3)
	beqi	0, r1, beq_then.16467
	addi	r2, r0, 1
	j	beq_cont.16468
beq_then.16467:
	addi	r1, r0, 4
	add	r2, r0, r7
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	shadow_check_one_or_group.3142				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
beq_cont.16468:
	j	beq_cont.16466
beq_then.16465:
	addi	r2, r0, 0
beq_cont.16466:
beq_cont.16464:
	j	beq_cont.16462
beq_then.16461:
	addi	r2, r0, 0
beq_cont.16462:
beq_cont.16460:
	j	beq_cont.16458
beq_then.16457:
	addi	r2, r0, 0
beq_cont.16458:
	beqi	0, r2, beq_then.16469
	addi	r6, r0, 1
	j	beq_cont.16470
beq_then.16469:
	addi	r6, r0, 0
beq_cont.16470:
fle_cont.16456:
	j	beq_cont.16454
beq_then.16453:
	addi	r6, r0, 0
beq_cont.16454:
	j	beq_cont.16444
beq_then.16443:
	addi	r6, r0, 1
beq_cont.16444:
	lw	r1, 0(r3)
	lw	r7, 1(r3)
	beqi	0, r6, beq_then.16471
	lw	r5, 1(r7)
	beqi	-1, r5, beq_then.16472
	addi	r1, r0, 672				# set min_caml_and_net
	add	r30, r1, r5
	lw	r1, 0(r30)
	addi	r2, r0, 0
	sw	r7, 1(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r7, 1(r3)
	beqi	0, r1, beq_then.16474
	addi	r6, r0, 1
	j	beq_cont.16475
beq_then.16474:
	lw	r1, 2(r7)
	beqi	-1, r1, beq_then.16476
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r7, 1(r3)
	beqi	0, r1, beq_then.16478
	addi	r6, r0, 1
	j	beq_cont.16479
beq_then.16478:
	lw	r1, 3(r7)
	beqi	-1, r1, beq_then.16480
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r7, 1(r3)
	beqi	0, r1, beq_then.16482
	addi	r6, r0, 1
	j	beq_cont.16483
beq_then.16482:
	addi	r1, r0, 4
	add	r2, r0, r7
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	shadow_check_one_or_group.3142				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r6, r0, r1
beq_cont.16483:
	j	beq_cont.16481
beq_then.16480:
	addi	r6, r0, 0
beq_cont.16481:
beq_cont.16479:
	j	beq_cont.16477
beq_then.16476:
	addi	r6, r0, 0
beq_cont.16477:
beq_cont.16475:
	j	beq_cont.16473
beq_then.16472:
	addi	r6, r0, 0
beq_cont.16473:
	beqi	0, r6, beq_then.16484
	addi	r1, r0, 1
	jr	r31				#
beq_then.16484:
	addi	r1, r1, 1
	j	shadow_check_one_or_matrix.3145
beq_then.16471:
	addi	r1, r1, 1
	j	shadow_check_one_or_matrix.3145
beq_then.16442:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3148:
	add	r30, r2, r1
	lw	r9, 0(r30)
	beqi	-1, r9, beq_then.16485
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r9
	lw	r8, 0(r30)
	flw	f2, 748(r0)
	lw	r6, 5(r8)
	flw	f1, 0(r6)
	fsub	f3, f2, f1
	flw	f2, 749(r0)
	lw	r6, 5(r8)
	flw	f1, 1(r6)
	fsub	f2, f2, f1
	flw	f4, 750(r0)
	lw	r6, 5(r8)
	flw	f1, 2(r6)
	fsub	f1, f4, f1
	lw	r7, 1(r8)
	beqi	1, r7, beq_then.16486
	beqi	2, r7, beq_then.16488
	add	r2, r0, r5
	add	r1, r0, r8
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	solver_second.3044				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	add	r6, r0, r1
	j	beq_cont.16489
beq_then.16488:
	add	r2, r0, r5
	add	r1, r0, r8
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	solver_surface.3025				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	add	r6, r0, r1
beq_cont.16489:
	j	beq_cont.16487
beq_then.16486:
	addi	r6, r0, 0
	addi	r2, r0, 1
	addi	r1, r0, 2
	fsw	f1, 0(r3)
	fsw	f2, 2(r3)
	fsw	f3, 4(r3)
	sw	r8, 6(r3)
	sw	r5, 7(r3)
	add	r7, r0, r1
	add	r1, r0, r8
	add	r28, r0, r6
	add	r6, r0, r2
	add	r2, r0, r5
	add	r5, r0, r28
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	lw	r8, 6(r3)
	lw	r5, 7(r3)
	beqi	0, r1, beq_then.16490
	addi	r6, r0, 1
	j	beq_cont.16491
beq_then.16490:
	addi	r6, r0, 1
	addi	r2, r0, 2
	addi	r1, r0, 0
	add	r7, r0, r1
	add	r1, r0, r8
	add	r28, r0, r6
	add	r6, r0, r2
	add	r2, r0, r5
	add	r5, r0, r28
	fadd	f30, f0, f2
	fadd	f2, f0, f1
	fadd	f1, f0, f30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	lw	r8, 6(r3)
	lw	r5, 7(r3)
	beqi	0, r1, beq_then.16492
	addi	r6, r0, 2
	j	beq_cont.16493
beq_then.16492:
	addi	r6, r0, 2
	addi	r2, r0, 0
	addi	r1, r0, 1
	add	r7, r0, r1
	add	r1, r0, r8
	add	r28, r0, r6
	add	r6, r0, r2
	add	r2, r0, r5
	add	r5, r0, r28
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.16494
	addi	r6, r0, 3
	j	beq_cont.16495
beq_then.16494:
	addi	r6, r0, 0
beq_cont.16495:
beq_cont.16493:
beq_cont.16491:
beq_cont.16487:
	beqi	0, r6, beq_then.16496
	flw	f1, 724(r0)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16497
	j	fle_cont.16498
fle_else.16497:
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16499
	j	fle_cont.16500
fle_else.16499:
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	flw	f2, 0(r5)
	fmul	f3, f2, f1
	flw	f2, 748(r0)
	fadd	f4, f3, f2
	flw	f2, 1(r5)
	fmul	f3, f2, f1
	flw	f2, 749(r0)
	fadd	f3, f3, f2
	flw	f2, 2(r5)
	fmul	f5, f2, f1
	flw	f2, 750(r0)
	fadd	f2, f5, f2
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.16501
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r1
	lw	r1, 0(r30)
	fsw	f2, 8(r3)
	fsw	f3, 10(r3)
	fsw	f4, 12(r3)
	sw	r2, 14(r3)
	fadd	f1, f0, f4
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f30
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	is_outside.3128				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	flw	f2, 8(r3)
	flw	f3, 10(r3)
	flw	f4, 12(r3)
	lw	r2, 14(r3)
	beqi	0, r1, beq_then.16503
	addi	r5, r0, 0
	j	beq_cont.16504
beq_then.16503:
	addi	r1, r0, 1
	fadd	f1, f0, f4
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f30
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	check_all_inside.3133				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r5, r0, r1
beq_cont.16504:
	j	beq_cont.16502
beq_then.16501:
	addi	r5, r0, 1
beq_cont.16502:
	beqi	0, r5, beq_then.16505
	fsw	f1, 726(r0)
	fsw	f4, 727(r0)
	fsw	f3, 728(r0)
	fsw	f2, 729(r0)
	sw	r9, 730(r0)
	sw	r6, 725(r0)
	j	beq_cont.16506
beq_then.16505:
beq_cont.16506:
fle_cont.16500:
fle_cont.16498:
	addi	r1, r1, 1
	j	solve_each_element.3148
beq_then.16496:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r9
	lw	r6, 0(r30)
	lw	r6, 6(r6)
	beqi	0, r6, beq_then.16507
	addi	r1, r1, 1
	j	solve_each_element.3148
beq_then.16507:
	jr	r31				#
beq_then.16485:
	jr	r31				#
solve_one_or_network.3152:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.16510
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	addi	r6, r1, 1
	add	r30, r2, r6
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.16511
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	sw	r6, 3(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element.3148				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r6, 3(r3)
	addi	r6, r6, 1
	add	r30, r2, r6
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.16512
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	sw	r6, 4(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solve_each_element.3148				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	addi	r6, r6, 1
	add	r30, r2, r6
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.16513
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	sw	r6, 5(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element.3148				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r6, 5(r3)
	addi	r1, r6, 1
	j	solve_one_or_network.3152
beq_then.16513:
	jr	r31				#
beq_then.16512:
	jr	r31				#
beq_then.16511:
	jr	r31				#
beq_then.16510:
	jr	r31				#
trace_or_matrix.3156:
	add	r30, r2, r1
	lw	r7, 0(r30)
	lw	r6, 0(r7)
	beqi	-1, r6, beq_then.16518
	addi	r8, r0, 99
	beq	r6, r8, beq_then.16519
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r6
	lw	r6, 0(r30)
	flw	f2, 748(r0)
	lw	r1, 5(r6)
	flw	f1, 0(r1)
	fsub	f3, f2, f1
	flw	f2, 749(r0)
	lw	r1, 5(r6)
	flw	f1, 1(r1)
	fsub	f2, f2, f1
	flw	f4, 750(r0)
	lw	r1, 5(r6)
	flw	f1, 2(r1)
	fsub	f1, f4, f1
	lw	r2, 1(r6)
	beqi	1, r2, beq_then.16521
	beqi	2, r2, beq_then.16523
	add	r2, r0, r5
	add	r1, r0, r6
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	solver_second.3044				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	beq_cont.16524
beq_then.16523:
	add	r2, r0, r5
	add	r1, r0, r6
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	solver_surface.3025				
	addi	r3, r3, -1
	lw	r31, 0(r3)
beq_cont.16524:
	j	beq_cont.16522
beq_then.16521:
	addi	r7, r0, 0
	addi	r2, r0, 1
	addi	r1, r0, 2
	fsw	f1, 0(r3)
	fsw	f2, 2(r3)
	fsw	f3, 4(r3)
	sw	r6, 6(r3)
	sw	r5, 7(r3)
	add	r28, r0, r7
	add	r7, r0, r1
	add	r1, r0, r6
	add	r6, r0, r2
	add	r2, r0, r5
	add	r5, r0, r28
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	lw	r6, 6(r3)
	lw	r5, 7(r3)
	beqi	0, r1, beq_then.16525
	addi	r1, r0, 1
	j	beq_cont.16526
beq_then.16525:
	addi	r7, r0, 1
	addi	r2, r0, 2
	addi	r1, r0, 0
	add	r28, r0, r7
	add	r7, r0, r1
	add	r1, r0, r6
	add	r6, r0, r2
	add	r2, r0, r5
	add	r5, r0, r28
	fadd	f30, f0, f2
	fadd	f2, f0, f1
	fadd	f1, f0, f30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	lw	r6, 6(r3)
	lw	r5, 7(r3)
	beqi	0, r1, beq_then.16527
	addi	r1, r0, 2
	j	beq_cont.16528
beq_then.16527:
	addi	r7, r0, 2
	addi	r2, r0, 0
	addi	r1, r0, 1
	add	r28, r0, r7
	add	r7, r0, r1
	add	r1, r0, r6
	add	r6, r0, r2
	add	r2, r0, r5
	add	r5, r0, r28
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.16529
	addi	r1, r0, 3
	j	beq_cont.16530
beq_then.16529:
	addi	r1, r0, 0
beq_cont.16530:
beq_cont.16528:
beq_cont.16526:
beq_cont.16522:
	beqi	0, r1, beq_then.16531
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16533
	j	fle_cont.16534
fle_else.16533:
	lw	r1, 1(r7)
	beqi	-1, r1, beq_then.16535
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	sw	r7, 8(r3)
	sw	r5, 7(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	solve_each_element.3148				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r7, 8(r3)
	lw	r5, 7(r3)
	lw	r1, 2(r7)
	beqi	-1, r1, beq_then.16537
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	solve_each_element.3148				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r7, 8(r3)
	lw	r5, 7(r3)
	lw	r1, 3(r7)
	beqi	-1, r1, beq_then.16539
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	solve_each_element.3148				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r7, 8(r3)
	lw	r5, 7(r3)
	addi	r1, r0, 4
	add	r2, r0, r7
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	solve_one_or_network.3152				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.16540
beq_then.16539:
beq_cont.16540:
	j	beq_cont.16538
beq_then.16537:
beq_cont.16538:
	j	beq_cont.16536
beq_then.16535:
beq_cont.16536:
fle_cont.16534:
	j	beq_cont.16532
beq_then.16531:
beq_cont.16532:
	j	beq_cont.16520
beq_then.16519:
	lw	r1, 1(r7)
	beqi	-1, r1, beq_then.16541
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	sw	r7, 8(r3)
	sw	r5, 7(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	solve_each_element.3148				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r7, 8(r3)
	lw	r5, 7(r3)
	lw	r1, 2(r7)
	beqi	-1, r1, beq_then.16543
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	solve_each_element.3148				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r7, 8(r3)
	lw	r5, 7(r3)
	lw	r1, 3(r7)
	beqi	-1, r1, beq_then.16545
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	solve_each_element.3148				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r7, 8(r3)
	lw	r5, 7(r3)
	addi	r1, r0, 4
	add	r2, r0, r7
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	solve_one_or_network.3152				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.16546
beq_then.16545:
beq_cont.16546:
	j	beq_cont.16544
beq_then.16543:
beq_cont.16544:
	j	beq_cont.16542
beq_then.16541:
beq_cont.16542:
beq_cont.16520:
	addi	r7, r1, 1
	add	r30, r2, r7
	lw	r6, 0(r30)
	lw	r1, 0(r6)
	beqi	-1, r1, beq_then.16547
	addi	r8, r0, 99
	beq	r1, r8, beq_then.16548
	addi	r2, r0, 748				# set min_caml_startp
	sw	r6, 9(r3)
	sw	r5, 7(r3)
	add	r28, r0, r5
	add	r5, r0, r2
	add	r2, r0, r28
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	solver.3050				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r6, 9(r3)
	lw	r5, 7(r3)
	beqi	0, r1, beq_then.16550
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16552
	j	fle_cont.16553
fle_else.16552:
	lw	r1, 1(r6)
	beqi	-1, r1, beq_then.16554
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	solve_each_element.3148				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r6, 9(r3)
	lw	r5, 7(r3)
	lw	r1, 2(r6)
	beqi	-1, r1, beq_then.16556
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	solve_each_element.3148				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r6, 9(r3)
	lw	r5, 7(r3)
	addi	r1, r0, 3
	add	r2, r0, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	solve_one_or_network.3152				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.16557
beq_then.16556:
beq_cont.16557:
	j	beq_cont.16555
beq_then.16554:
beq_cont.16555:
fle_cont.16553:
	j	beq_cont.16551
beq_then.16550:
beq_cont.16551:
	j	beq_cont.16549
beq_then.16548:
	lw	r1, 1(r6)
	beqi	-1, r1, beq_then.16558
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	sw	r6, 9(r3)
	sw	r5, 7(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	solve_each_element.3148				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r6, 9(r3)
	lw	r5, 7(r3)
	lw	r1, 2(r6)
	beqi	-1, r1, beq_then.16560
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	solve_each_element.3148				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r6, 9(r3)
	lw	r5, 7(r3)
	addi	r1, r0, 3
	add	r2, r0, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	solve_one_or_network.3152				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.16561
beq_then.16560:
beq_cont.16561:
	j	beq_cont.16559
beq_then.16558:
beq_cont.16559:
beq_cont.16549:
	addi	r1, r7, 1
	j	trace_or_matrix.3156
beq_then.16547:
	jr	r31				#
beq_then.16518:
	jr	r31				#
judge_intersection.3160:
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 726(r0)
	lw	r7, 723(r0)
	lw	r5, 0(r7)
	lw	r2, 0(r5)
	beqi	-1, r2, beq_then.16564
	addi	r6, r0, 99
	beq	r2, r6, beq_then.16566
	addi	r6, r0, 748				# set min_caml_startp
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	add	r5, r0, r6
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	solver.3050				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	beqi	0, r2, beq_then.16568
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16570
	j	fle_cont.16571
fle_else.16570:
	lw	r2, 1(r5)
	beqi	-1, r2, beq_then.16572
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	solve_each_element.3148				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	lw	r2, 2(r5)
	beqi	-1, r2, beq_then.16574
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	solve_each_element.3148				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	addi	r2, r0, 3
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r28
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	solve_one_or_network.3152				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.16575
beq_then.16574:
beq_cont.16575:
	j	beq_cont.16573
beq_then.16572:
beq_cont.16573:
fle_cont.16571:
	j	beq_cont.16569
beq_then.16568:
beq_cont.16569:
	j	beq_cont.16567
beq_then.16566:
	lw	r2, 1(r5)
	beqi	-1, r2, beq_then.16576
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	solve_each_element.3148				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	lw	r2, 2(r5)
	beqi	-1, r2, beq_then.16578
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	solve_each_element.3148				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	addi	r2, r0, 3
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r28
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	solve_one_or_network.3152				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.16579
beq_then.16578:
beq_cont.16579:
	j	beq_cont.16577
beq_then.16576:
beq_cont.16577:
beq_cont.16567:
	addi	r2, r0, 1
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	trace_or_matrix.3156				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.16565
beq_then.16564:
beq_cont.16565:
	flw	f1, 726(r0)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16580
	addi	r1, r0, 0
	jr	r31				#
fle_else.16580:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16581
	addi	r1, r0, 0
	jr	r31				#
fle_else.16581:
	addi	r1, r0, 1
	jr	r31				#
solve_each_element_fast.3162:
	lw	r7, 0(r5)
	add	r30, r2, r1
	lw	r11, 0(r30)
	beqi	-1, r11, beq_then.16582
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r11
	lw	r10, 0(r30)
	lw	r9, 10(r10)
	flw	f3, 0(r9)
	flw	f2, 1(r9)
	flw	f1, 2(r9)
	lw	r6, 1(r5)
	add	r30, r6, r11
	lw	r12, 0(r30)
	lw	r8, 1(r10)
	beqi	1, r8, beq_then.16583
	beqi	2, r8, beq_then.16585
	add	r5, r0, r9
	add	r2, r0, r12
	add	r1, r0, r10
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	solver_second_fast2.3084				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	add	r6, r0, r1
	j	beq_cont.16586
beq_then.16585:
	flw	f1, 0(r12)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16587
	addi	r1, r0, 0
	j	fle_cont.16588
fle_else.16587:
	addi	r1, r0, 1
fle_cont.16588:
	beqi	0, r1, beq_then.16589
	flw	f2, 0(r12)
	flw	f1, 3(r9)
	fmul	f1, f2, f1
	fsw	f1, 724(r0)
	addi	r6, r0, 1
	j	beq_cont.16590
beq_then.16589:
	addi	r6, r0, 0
beq_cont.16590:
beq_cont.16586:
	j	beq_cont.16584
beq_then.16583:
	lw	r6, 0(r5)
	sw	r6, 0(r3)
	sw	r7, 1(r3)
	sw	r11, 2(r3)
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	sw	r2, 5(r3)
	add	r5, r0, r12
	add	r2, r0, r6
	add	r1, r0, r10
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solver_rect_fast.3054				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r6, r0, r1
beq_cont.16584:
	lw	r7, 1(r3)
	lw	r11, 2(r3)
	lw	r1, 3(r3)
	lw	r5, 4(r3)
	lw	r2, 5(r3)
	beqi	0, r6, beq_then.16591
	flw	f1, 724(r0)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16592
	j	fle_cont.16593
fle_else.16592:
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16594
	j	fle_cont.16595
fle_else.16594:
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	flw	f2, 0(r7)
	fmul	f3, f2, f1
	flw	f2, 751(r0)
	fadd	f4, f3, f2
	flw	f2, 1(r7)
	fmul	f3, f2, f1
	flw	f2, 752(r0)
	fadd	f3, f3, f2
	flw	f2, 2(r7)
	fmul	f5, f2, f1
	flw	f2, 753(r0)
	fadd	f2, f5, f2
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.16596
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r1
	lw	r1, 0(r30)
	fsw	f2, 6(r3)
	fsw	f3, 8(r3)
	fsw	f4, 10(r3)
	sw	r2, 5(r3)
	fadd	f1, f0, f4
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f30
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	is_outside.3128				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 6(r3)
	flw	f3, 8(r3)
	flw	f4, 10(r3)
	lw	r2, 5(r3)
	beqi	0, r1, beq_then.16598
	addi	r5, r0, 0
	j	beq_cont.16599
beq_then.16598:
	addi	r1, r0, 1
	fadd	f1, f0, f4
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f30
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	check_all_inside.3133				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r5, r0, r1
beq_cont.16599:
	j	beq_cont.16597
beq_then.16596:
	addi	r5, r0, 1
beq_cont.16597:
	beqi	0, r5, beq_then.16600
	fsw	f1, 726(r0)
	fsw	f4, 727(r0)
	fsw	f3, 728(r0)
	fsw	f2, 729(r0)
	sw	r11, 730(r0)
	sw	r6, 725(r0)
	j	beq_cont.16601
beq_then.16600:
beq_cont.16601:
fle_cont.16595:
fle_cont.16593:
	addi	r1, r1, 1
	j	solve_each_element_fast.3162
beq_then.16591:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r11
	lw	r6, 0(r30)
	lw	r6, 6(r6)
	beqi	0, r6, beq_then.16602
	addi	r1, r1, 1
	j	solve_each_element_fast.3162
beq_then.16602:
	jr	r31				#
beq_then.16582:
	jr	r31				#
solve_one_or_network_fast.3166:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.16605
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	addi	r6, r1, 1
	add	r30, r2, r6
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.16606
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	sw	r6, 3(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r6, 3(r3)
	addi	r6, r6, 1
	add	r30, r2, r6
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.16607
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	sw	r6, 4(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	addi	r6, r6, 1
	add	r30, r2, r6
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.16608
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	sw	r6, 5(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r6, 5(r3)
	addi	r1, r6, 1
	j	solve_one_or_network_fast.3166
beq_then.16608:
	jr	r31				#
beq_then.16607:
	jr	r31				#
beq_then.16606:
	jr	r31				#
beq_then.16605:
	jr	r31				#
trace_or_matrix_fast.3170:
	add	r30, r2, r1
	lw	r9, 0(r30)
	lw	r6, 0(r9)
	beqi	-1, r6, beq_then.16613
	addi	r7, r0, 99
	beq	r6, r7, beq_then.16614
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r6
	lw	r8, 0(r30)
	lw	r7, 10(r8)
	flw	f3, 0(r7)
	flw	f2, 1(r7)
	flw	f1, 2(r7)
	lw	r1, 1(r5)
	add	r30, r1, r6
	lw	r6, 0(r30)
	lw	r2, 1(r8)
	beqi	1, r2, beq_then.16616
	beqi	2, r2, beq_then.16618
	add	r5, r0, r7
	add	r2, r0, r6
	add	r1, r0, r8
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	solver_second_fast2.3084				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	beq_cont.16619
beq_then.16618:
	flw	f1, 0(r6)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16620
	addi	r1, r0, 0
	j	fle_cont.16621
fle_else.16620:
	addi	r1, r0, 1
fle_cont.16621:
	beqi	0, r1, beq_then.16622
	flw	f2, 0(r6)
	flw	f1, 3(r7)
	fmul	f1, f2, f1
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	j	beq_cont.16623
beq_then.16622:
	addi	r1, r0, 0
beq_cont.16623:
beq_cont.16619:
	j	beq_cont.16617
beq_then.16616:
	lw	r1, 0(r5)
	sw	r1, 0(r3)
	sw	r9, 1(r3)
	sw	r5, 2(r3)
	add	r5, r0, r6
	add	r2, r0, r1
	add	r1, r0, r8
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_rect_fast.3054				
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16617:
	lw	r9, 1(r3)
	lw	r5, 2(r3)
	beqi	0, r1, beq_then.16624
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16626
	j	fle_cont.16627
fle_else.16626:
	lw	r1, 1(r9)
	beqi	-1, r1, beq_then.16628
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	sw	r9, 1(r3)
	sw	r5, 2(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r9, 1(r3)
	lw	r5, 2(r3)
	lw	r1, 2(r9)
	beqi	-1, r1, beq_then.16630
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r9, 1(r3)
	lw	r5, 2(r3)
	lw	r1, 3(r9)
	beqi	-1, r1, beq_then.16632
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r9, 1(r3)
	lw	r5, 2(r3)
	addi	r1, r0, 4
	add	r2, r0, r9
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16633
beq_then.16632:
beq_cont.16633:
	j	beq_cont.16631
beq_then.16630:
beq_cont.16631:
	j	beq_cont.16629
beq_then.16628:
beq_cont.16629:
fle_cont.16627:
	j	beq_cont.16625
beq_then.16624:
beq_cont.16625:
	j	beq_cont.16615
beq_then.16614:
	lw	r1, 1(r9)
	beqi	-1, r1, beq_then.16634
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	sw	r9, 1(r3)
	sw	r5, 2(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r9, 1(r3)
	lw	r5, 2(r3)
	lw	r1, 2(r9)
	beqi	-1, r1, beq_then.16636
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r9, 1(r3)
	lw	r5, 2(r3)
	lw	r1, 3(r9)
	beqi	-1, r1, beq_then.16638
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r9, 1(r3)
	lw	r5, 2(r3)
	addi	r1, r0, 4
	add	r2, r0, r9
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16639
beq_then.16638:
beq_cont.16639:
	j	beq_cont.16637
beq_then.16636:
beq_cont.16637:
	j	beq_cont.16635
beq_then.16634:
beq_cont.16635:
beq_cont.16615:
	lw	r1, 0(r3)
	lw	r9, 1(r3)
	lw	r5, 2(r3)
	addi	r7, r1, 1
	add	r30, r2, r7
	lw	r6, 0(r30)
	lw	r1, 0(r6)
	beqi	-1, r1, beq_then.16640
	addi	r8, r0, 99
	beq	r1, r8, beq_then.16641
	sw	r6, 3(r3)
	sw	r5, 2(r3)
	add	r2, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_fast2.3091				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r6, 3(r3)
	lw	r5, 2(r3)
	beqi	0, r1, beq_then.16643
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16645
	j	fle_cont.16646
fle_else.16645:
	lw	r1, 1(r6)
	beqi	-1, r1, beq_then.16647
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r6, 3(r3)
	lw	r5, 2(r3)
	lw	r1, 2(r6)
	beqi	-1, r1, beq_then.16649
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r6, 3(r3)
	lw	r5, 2(r3)
	addi	r1, r0, 3
	add	r2, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16650
beq_then.16649:
beq_cont.16650:
	j	beq_cont.16648
beq_then.16647:
beq_cont.16648:
fle_cont.16646:
	j	beq_cont.16644
beq_then.16643:
beq_cont.16644:
	j	beq_cont.16642
beq_then.16641:
	lw	r1, 1(r6)
	beqi	-1, r1, beq_then.16651
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	sw	r6, 3(r3)
	sw	r5, 2(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r6, 3(r3)
	lw	r5, 2(r3)
	lw	r1, 2(r6)
	beqi	-1, r1, beq_then.16653
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r1
	lw	r1, 0(r30)
	addi	r2, r0, 0
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r6, 3(r3)
	lw	r5, 2(r3)
	addi	r1, r0, 3
	add	r2, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16654
beq_then.16653:
beq_cont.16654:
	j	beq_cont.16652
beq_then.16651:
beq_cont.16652:
beq_cont.16642:
	addi	r1, r7, 1
	j	trace_or_matrix_fast.3170
beq_then.16640:
	jr	r31				#
beq_then.16613:
	jr	r31				#
judge_intersection_fast.3174:
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 726(r0)
	lw	r7, 723(r0)
	lw	r5, 0(r7)
	lw	r2, 0(r5)
	beqi	-1, r2, beq_then.16657
	addi	r6, r0, 99
	beq	r2, r6, beq_then.16659
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	solver_fast2.3091				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	beqi	0, r2, beq_then.16661
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16663
	j	fle_cont.16664
fle_else.16663:
	lw	r2, 1(r5)
	beqi	-1, r2, beq_then.16665
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	lw	r2, 2(r5)
	beqi	-1, r2, beq_then.16667
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	addi	r2, r0, 3
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r28
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.16668
beq_then.16667:
beq_cont.16668:
	j	beq_cont.16666
beq_then.16665:
beq_cont.16666:
fle_cont.16664:
	j	beq_cont.16662
beq_then.16661:
beq_cont.16662:
	j	beq_cont.16660
beq_then.16659:
	lw	r2, 1(r5)
	beqi	-1, r2, beq_then.16669
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	lw	r2, 2(r5)
	beqi	-1, r2, beq_then.16671
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	addi	r2, r0, 3
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r28
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.16672
beq_then.16671:
beq_cont.16672:
	j	beq_cont.16670
beq_then.16669:
beq_cont.16670:
beq_cont.16660:
	addi	r2, r0, 1
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	trace_or_matrix_fast.3170				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.16658
beq_then.16657:
beq_cont.16658:
	flw	f1, 726(r0)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16673
	addi	r1, r0, 0
	jr	r31				#
fle_else.16673:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16674
	addi	r1, r0, 0
	jr	r31				#
fle_else.16674:
	addi	r1, r0, 1
	jr	r31				#
get_nvector_rect.3176:
	lw	r2, 725(r0)
	fsw	f0, 731(r0)
	fsw	f0, 732(r0)
	fsw	f0, 733(r0)
	addi	r6, r0, 731				# set min_caml_nvector
	addi	r5, r2, -1
	addi	r2, r2, -1
	add	r30, r1, r2
	flw	f2, 0(r30)
	feq	r30, f2, f0
	beq	r0, r30, feq_else.16675
	addi	r1, r0, 1
	j	feq_cont.16676
feq_else.16675:
	addi	r1, r0, 0
feq_cont.16676:
	beqi	0, r1, beq_then.16677
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16678
beq_then.16677:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.16679
	addi	r1, r0, 0
	j	fle_cont.16680
fle_else.16679:
	addi	r1, r0, 1
fle_cont.16680:
	beqi	0, r1, beq_then.16681
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16682
beq_then.16681:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.16682:
beq_cont.16678:
	fneg	f1, f1
	add	r30, r6, r5
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
	flw	f2, 727(r0)
	lw	r2, 5(r1)
	flw	f1, 0(r2)
	fsub	f3, f2, f1
	flw	f2, 728(r0)
	lw	r2, 5(r1)
	flw	f1, 1(r2)
	fsub	f2, f2, f1
	flw	f4, 729(r0)
	lw	r2, 5(r1)
	flw	f1, 2(r2)
	fsub	f1, f4, f1
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fmul	f6, f3, f4
	lw	r2, 4(r1)
	flw	f4, 1(r2)
	fmul	f5, f2, f4
	lw	r2, 4(r1)
	flw	f4, 2(r2)
	fmul	f4, f1, f4
	lw	r2, 3(r1)
	beqi	0, r2, beq_then.16685
	lw	r2, 9(r1)
	flw	f7, 2(r2)
	fmul	f8, f2, f7
	lw	r2, 9(r1)
	flw	f7, 1(r2)
	fmul	f7, f1, f7
	fadd	f8, f8, f7
	flup	f7, 1		# fli	f7, 0.500000
	fmul	f7, f8, f7
	fadd	f6, f6, f7
	fsw	f6, 731(r0)
	lw	r2, 9(r1)
	flw	f6, 2(r2)
	fmul	f7, f3, f6
	lw	r2, 9(r1)
	flw	f6, 0(r2)
	fmul	f1, f1, f6
	fadd	f6, f7, f1
	flup	f1, 1		# fli	f1, 0.500000
	fmul	f1, f6, f1
	fadd	f1, f5, f1
	fsw	f1, 732(r0)
	lw	r2, 9(r1)
	flw	f1, 1(r2)
	fmul	f3, f3, f1
	lw	r2, 9(r1)
	flw	f1, 0(r2)
	fmul	f1, f2, f1
	fadd	f2, f3, f1
	flup	f1, 1		# fli	f1, 0.500000
	fmul	f1, f2, f1
	fadd	f1, f4, f1
	fsw	f1, 733(r0)
	j	beq_cont.16686
beq_then.16685:
	fsw	f6, 731(r0)
	fsw	f5, 732(r0)
	fsw	f4, 733(r0)
beq_cont.16686:
	addi	r2, r0, 731				# set min_caml_nvector
	lw	r1, 6(r1)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	j	vecunit_sgn.2888
get_nvector.3182:
	lw	r5, 1(r1)
	beqi	1, r5, beq_then.16687
	beqi	2, r5, beq_then.16688
	j	get_nvector_second.3180
beq_then.16688:
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
beq_then.16687:
	lw	r1, 725(r0)
	fsw	f0, 731(r0)
	fsw	f0, 732(r0)
	fsw	f0, 733(r0)
	addi	r6, r0, 731				# set min_caml_nvector
	addi	r5, r1, -1
	addi	r1, r1, -1
	add	r30, r2, r1
	flw	f2, 0(r30)
	feq	r30, f2, f0
	beq	r0, r30, feq_else.16690
	addi	r1, r0, 1
	j	feq_cont.16691
feq_else.16690:
	addi	r1, r0, 0
feq_cont.16691:
	beqi	0, r1, beq_then.16692
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16693
beq_then.16692:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.16694
	addi	r1, r0, 0
	j	fle_cont.16695
fle_else.16694:
	addi	r1, r0, 1
fle_cont.16695:
	beqi	0, r1, beq_then.16696
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16697
beq_then.16696:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.16697:
beq_cont.16693:
	fneg	f1, f1
	add	r30, r6, r5
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
	beqi	1, r5, beq_then.16699
	beqi	2, r5, beq_then.16700
	beqi	3, r5, beq_then.16701
	beqi	4, r5, beq_then.16702
	jr	r31				#
beq_then.16702:
	flw	f2, 0(r2)
	lw	r5, 5(r1)
	flw	f1, 0(r5)
	fsub	f2, f2, f1
	lw	r5, 4(r1)
	flw	f1, 0(r5)
	fsqrt	f1, f1
	fmul	f3, f2, f1
	flw	f2, 2(r2)
	lw	r5, 5(r1)
	flw	f1, 2(r5)
	fsub	f2, f2, f1
	lw	r5, 4(r1)
	flw	f1, 2(r5)
	fsqrt	f1, f1
	fmul	f1, f2, f1
	fmul	f4, f3, f3
	fmul	f2, f1, f1
	fadd	f4, f4, f2
	flup	f5, 33		# fli	f5, 0.000100
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16704
	fadd	f2, f0, f3
	j	fle_cont.16705
fle_else.16704:
	fneg	f2, f3
fle_cont.16705:
	fle	r30, f5, f2
	beq	r0, r30, fle_else.16706
	finv	f31, f3
	fmul	f2, f1, f31
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16708
	fadd	f1, f0, f2
	j	fle_cont.16709
fle_else.16708:
	fneg	f1, f2
fle_cont.16709:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16710
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.16711
fle_else.16710:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.16711:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16712
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16714
	flup	f4, 15		# fli	f4, 1.570796
	flup	f3, 2		# fli	f3, 1.000000
	finv	f31, f1
	fmul	f1, f3, f31
	fsw	f2, 0(r3)
	fsw	f4, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan_body.2841				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 0(r3)
	flw	f4, 2(r3)
	fadd	f1, f4, f1
	fmul	f3, f1, f2
	j	fle_cont.16715
fle_else.16714:
	flup	f5, 16		# fli	f5, 0.785398
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f4, f1, f3
	flup	f3, 2		# fli	f3, 1.000000
	fadd	f1, f1, f3
	finv	f31, f1
	fmul	f1, f4, f31
	fsw	f2, 0(r3)
	fsw	f5, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	atan_body.2841				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	flw	f5, 4(r3)
	fadd	f1, f5, f1
	fmul	f3, f1, f2
fle_cont.16715:
	j	fle_cont.16713
fle_else.16712:
	fsw	f4, 6(r3)
	fsw	f3, 8(r3)
	sw	r2, 10(r3)
	sw	r1, 11(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	atan_body.2841				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	fadd	f3, f0, f1
fle_cont.16713:
	flw	f4, 6(r3)
	lw	r2, 10(r3)
	lw	r1, 11(r3)
	flup	f1, 35		# fli	f1, 30.000000
	fmul	f2, f3, f1
	flup	f1, 14		# fli	f1, 3.141593
	finv	f31, f1
	fmul	f2, f2, f31
	j	fle_cont.16707
fle_else.16706:
	flup	f2, 34		# fli	f2, 15.000000
fle_cont.16707:
	ftoi	r5, f2
	itof	f1, r5
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16716
	fadd	f3, f0, f1
	j	fle_cont.16717
fle_else.16716:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f3, f1, f3
fle_cont.16717:
	fsub	f2, f2, f3
	flw	f3, 1(r2)
	lw	r2, 5(r1)
	flw	f1, 1(r2)
	fsub	f3, f3, f1
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	fsqrt	f1, f1
	fmul	f1, f3, f1
	flup	f5, 33		# fli	f5, 0.000100
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16718
	fadd	f3, f0, f4
	j	fle_cont.16719
fle_else.16718:
	fneg	f3, f4
fle_cont.16719:
	fle	r30, f5, f3
	beq	r0, r30, fle_else.16720
	finv	f31, f4
	fmul	f3, f1, f31
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16722
	fadd	f1, f0, f3
	j	fle_cont.16723
fle_else.16722:
	fneg	f1, f3
fle_cont.16723:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16724
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.16725
fle_else.16724:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.16725:
	fmul	f1, f1, f3
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16726
	flup	f2, 24		# fli	f2, 2.437500
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16728
	flup	f4, 15		# fli	f4, 1.570796
	flup	f2, 2		# fli	f2, 1.000000
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f3, 12(r3)
	fsw	f4, 14(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2841				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f3, 12(r3)
	flw	f4, 14(r3)
	fadd	f1, f4, f1
	fmul	f4, f1, f3
	j	fle_cont.16729
fle_else.16728:
	flup	f5, 16		# fli	f5, 0.785398
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f4, f1, f2
	flup	f2, 2		# fli	f2, 1.000000
	fadd	f1, f1, f2
	finv	f31, f1
	fmul	f1, f4, f31
	fsw	f3, 12(r3)
	fsw	f5, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2841				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f3, 12(r3)
	flw	f5, 16(r3)
	fadd	f1, f5, f1
	fmul	f4, f1, f3
fle_cont.16729:
	j	fle_cont.16727
fle_else.16726:
	fsw	f2, 18(r3)
	fsw	f4, 20(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	atan_body.2841				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	fadd	f4, f0, f1
fle_cont.16727:
	flw	f2, 18(r3)
	flup	f1, 35		# fli	f1, 30.000000
	fmul	f3, f4, f1
	flup	f1, 14		# fli	f1, 3.141593
	finv	f31, f1
	fmul	f3, f3, f31
	j	fle_cont.16721
fle_else.16720:
	flup	f3, 34		# fli	f3, 15.000000
fle_cont.16721:
	ftoi	r1, f3
	itof	f1, r1
	fle	r30, f1, f3
	beq	r0, r30, fle_else.16730
	fadd	f4, f0, f1
	j	fle_cont.16731
fle_else.16730:
	flup	f4, 2		# fli	f4, 1.000000
	fsub	f4, f1, f4
fle_cont.16731:
	fsub	f1, f3, f4
	flup	f4, 36		# fli	f4, 0.150000
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f2, f3, f2
	fmul	f2, f2, f2
	fsub	f3, f4, f2
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f2, f1
	fmul	f1, f1, f1
	fsub	f2, f3, f1
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16732
	addi	r1, r0, 0
	j	fle_cont.16733
fle_else.16732:
	addi	r1, r0, 1
fle_cont.16733:
	beqi	0, r1, beq_then.16734
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16735
beq_then.16734:
	fadd	f1, f0, f2
beq_cont.16735:
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f2, f1
	flup	f1, 38		# fli	f1, 0.300000
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 736(r0)
	jr	r31				#
beq_then.16701:
	flw	f2, 0(r2)
	lw	r5, 5(r1)
	flw	f1, 0(r5)
	fsub	f2, f2, f1
	flw	f3, 2(r2)
	lw	r1, 5(r1)
	flw	f1, 2(r1)
	fsub	f1, f3, f1
	fmul	f2, f2, f2
	fmul	f1, f1, f1
	fadd	f1, f2, f1
	fsqrt	f2, f1
	flup	f1, 39		# fli	f1, 10.000000
	finv	f31, f1
	fmul	f2, f2, f31
	ftoi	r1, f2
	itof	f1, r1
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16737
	fadd	f3, f0, f1
	j	fle_cont.16738
fle_else.16737:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f3, f1, f3
fle_cont.16738:
	fsub	f2, f2, f3
	flup	f1, 14		# fli	f1, 3.141593
	fmul	f1, f2, f1
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	cos.2839				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	fmul	f1, f1, f1
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f1, f2
	fsw	f2, 735(r0)
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f2, f1
	flup	f1, 37		# fli	f1, 255.000000
	fmul	f1, f2, f1
	fsw	f1, 736(r0)
	jr	r31				#
beq_then.16700:
	flw	f2, 1(r2)
	flup	f1, 40		# fli	f1, 0.250000
	fmul	f1, f2, f1
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	sin.2837				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	fmul	f1, f1, f1
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f2, f1
	fsw	f2, 734(r0)
	flup	f3, 37		# fli	f3, 255.000000
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f2, f1
	fmul	f1, f3, f1
	fsw	f1, 735(r0)
	jr	r31				#
beq_then.16699:
	flw	f1, 0(r2)
	lw	r5, 5(r1)
	flw	f2, 0(r5)
	fsub	f2, f1, f2
	flup	f1, 41		# fli	f1, 0.050000
	fmul	f3, f2, f1
	ftoi	r5, f3
	itof	f1, r5
	fle	r30, f1, f3
	beq	r0, r30, fle_else.16741
	fadd	f3, f0, f1
	j	fle_cont.16742
fle_else.16741:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f3, f1, f3
fle_cont.16742:
	flup	f1, 42		# fli	f1, 20.000000
	fmul	f1, f3, f1
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f2, f1
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16743
	addi	r5, r0, 0
	j	fle_cont.16744
fle_else.16743:
	addi	r5, r0, 1
fle_cont.16744:
	flw	f2, 2(r2)
	lw	r1, 5(r1)
	flw	f1, 2(r1)
	fsub	f2, f2, f1
	flup	f1, 41		# fli	f1, 0.050000
	fmul	f3, f2, f1
	ftoi	r1, f3
	itof	f1, r1
	fle	r30, f1, f3
	beq	r0, r30, fle_else.16745
	fadd	f3, f0, f1
	j	fle_cont.16746
fle_else.16745:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f3, f1, f3
fle_cont.16746:
	flup	f1, 42		# fli	f1, 20.000000
	fmul	f1, f3, f1
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f2, f1
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16747
	addi	r1, r0, 0
	j	fle_cont.16748
fle_else.16747:
	addi	r1, r0, 1
fle_cont.16748:
	beqi	0, r5, beq_then.16749
	beqi	0, r1, beq_then.16751
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.16752
beq_then.16751:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.16752:
	j	beq_cont.16750
beq_then.16749:
	beqi	0, r1, beq_then.16753
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16754
beq_then.16753:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.16754:
beq_cont.16750:
	fsw	f1, 735(r0)
	jr	r31				#
add_light.3188:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16756
	addi	r1, r0, 0
	j	fle_cont.16757
fle_else.16756:
	addi	r1, r0, 1
fle_cont.16757:
	beqi	0, r1, beq_then.16758
	flw	f5, 740(r0)
	flw	f4, 734(r0)
	fmul	f4, f1, f4
	fadd	f4, f5, f4
	fsw	f4, 740(r0)
	flw	f5, 741(r0)
	flw	f4, 735(r0)
	fmul	f4, f1, f4
	fadd	f4, f5, f4
	fsw	f4, 741(r0)
	flw	f5, 742(r0)
	flw	f4, 736(r0)
	fmul	f1, f1, f4
	fadd	f1, f5, f1
	fsw	f1, 742(r0)
	j	beq_cont.16759
beq_then.16758:
beq_cont.16759:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.16760
	addi	r1, r0, 0
	j	fle_cont.16761
fle_else.16760:
	addi	r1, r0, 1
fle_cont.16761:
	beqi	0, r1, beq_then.16762
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
beq_then.16762:
	jr	r31				#
trace_reflections.3192:
	bgei	0, r1, bge_then.16765
	jr	r31				#
bge_then.16765:
	addi	r5, r0, 778				# set min_caml_reflections
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r7, 1(r5)
	flup	f3, 31		# fli	f3, 1000000000.000000
	fsw	f3, 726(r0)
	addi	r6, r0, 0
	lw	r8, 723(r0)
	fsw	f2, 0(r3)
	fsw	f1, 2(r3)
	sw	r5, 4(r3)
	sw	r7, 5(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	add	r5, r0, r7
	add	r2, r0, r8
	add	r1, r0, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	trace_or_matrix_fast.3170				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 0(r3)
	flw	f1, 2(r3)
	lw	r5, 4(r3)
	lw	r7, 5(r3)
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	flw	f3, 726(r0)
	flup	f4, 30		# fli	f4, -0.100000
	fle	r30, f3, f4
	beq	r0, r30, fle_else.16767
	addi	r6, r0, 0
	j	fle_cont.16768
fle_else.16767:
	flup	f1, 32		# fli	f1, 100000000.000000
	fle	r30, f1, f3
	beq	r0, r30, fle_else.16769
	addi	r6, r0, 0
	j	fle_cont.16770
fle_else.16769:
	addi	r6, r0, 1
fle_cont.16770:
fle_cont.16768:
	beqi	0, r6, beq_then.16771
	lw	r1, 730(r0)
	slli	r6, r1, 2
	lw	r1, 725(r0)
	add	r1, r6, r1
	lw	r6, 0(r5)
	beq	r1, r6, beq_then.16773
	j	beq_cont.16774
beq_then.16773:
	addi	r1, r0, 0
	lw	r6, 723(r0)
	add	r2, r0, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	shadow_check_one_or_matrix.3145				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 0(r3)
	flw	f1, 2(r3)
	lw	r5, 4(r3)
	lw	r7, 5(r3)
	lw	r2, 7(r3)
	beqi	0, r1, beq_then.16775
	j	beq_cont.16776
beq_then.16775:
	lw	r1, 0(r7)
	flw	f4, 731(r0)
	flw	f3, 0(r1)
	fmul	f5, f4, f3
	flw	f4, 732(r0)
	flw	f3, 1(r1)
	fmul	f3, f4, f3
	fadd	f5, f5, f3
	flw	f4, 733(r0)
	flw	f3, 2(r1)
	fmul	f3, f4, f3
	fadd	f3, f5, f3
	flw	f4, 2(r5)
	fmul	f1, f4, f1
	fmul	f3, f1, f3
	lw	r1, 0(r7)
	flw	f5, 0(r2)
	flw	f1, 0(r1)
	fmul	f6, f5, f1
	flw	f5, 1(r2)
	flw	f1, 1(r1)
	fmul	f1, f5, f1
	fadd	f6, f6, f1
	flw	f5, 2(r2)
	flw	f1, 2(r1)
	fmul	f1, f5, f1
	fadd	f1, f6, f1
	fmul	f1, f4, f1
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f1
	fadd	f1, f0, f30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	add_light.3188				
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.16776:
beq_cont.16774:
	j	beq_cont.16772
beq_then.16771:
beq_cont.16772:
	addi	r1, r1, -1
	j	trace_reflections.3192
trace_ray.3197:
	blei	4, r1, ble_then.16777
	jr	r31				#
ble_then.16777:
	lw	r10, 2(r5)
	flup	f3, 31		# fli	f3, 1000000000.000000
	fsw	f3, 726(r0)
	addi	r6, r0, 0
	lw	r7, 723(r0)
	fsw	f1, 0(r3)
	fsw	f2, 2(r3)
	sw	r5, 4(r3)
	sw	r1, 5(r3)
	sw	r10, 6(r3)
	sw	r2, 7(r3)
	add	r5, r0, r2
	add	r1, r0, r6
	add	r2, r0, r7
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	trace_or_matrix.3156				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	lw	r5, 4(r3)
	lw	r1, 5(r3)
	lw	r10, 6(r3)
	lw	r2, 7(r3)
	flw	f3, 726(r0)
	flup	f4, 30		# fli	f4, -0.100000
	fle	r30, f3, f4
	beq	r0, r30, fle_else.16779
	addi	r6, r0, 0
	j	fle_cont.16780
fle_else.16779:
	flup	f1, 32		# fli	f1, 100000000.000000
	fle	r30, f1, f3
	beq	r0, r30, fle_else.16781
	addi	r6, r0, 0
	j	fle_cont.16782
fle_else.16781:
	addi	r6, r0, 1
fle_cont.16782:
fle_cont.16780:
	beqi	0, r6, beq_then.16783
	lw	r7, 730(r0)
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r7
	lw	r8, 0(r30)
	lw	r9, 2(r8)
	lw	r6, 7(r8)
	flw	f3, 0(r6)
	fmul	f5, f3, f1
	lw	r6, 1(r8)
	beqi	1, r6, beq_then.16784
	beqi	2, r6, beq_then.16786
	add	r1, r0, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	get_nvector_second.3180				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.16787
beq_then.16786:
	lw	r1, 4(r8)
	flw	f1, 0(r1)
	fneg	f1, f1
	fsw	f1, 731(r0)
	lw	r1, 4(r8)
	flw	f1, 1(r1)
	fneg	f1, f1
	fsw	f1, 732(r0)
	lw	r1, 4(r8)
	flw	f1, 2(r1)
	fneg	f1, f1
	fsw	f1, 733(r0)
beq_cont.16787:
	j	beq_cont.16785
beq_then.16784:
	lw	r6, 725(r0)
	fsw	f0, 731(r0)
	fsw	f0, 732(r0)
	fsw	f0, 733(r0)
	addi	r12, r0, 731				# set min_caml_nvector
	addi	r11, r6, -1
	addi	r6, r6, -1
	add	r30, r2, r6
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16788
	addi	r6, r0, 1
	j	feq_cont.16789
feq_else.16788:
	addi	r6, r0, 0
feq_cont.16789:
	beqi	0, r6, beq_then.16790
	flup	f3, 0		# fli	f3, 0.000000
	j	beq_cont.16791
beq_then.16790:
	fle	r30, f4, f0
	beq	r0, r30, fle_else.16792
	addi	r1, r0, 0
	j	fle_cont.16793
fle_else.16792:
	addi	r1, r0, 1
fle_cont.16793:
	beqi	0, r1, beq_then.16794
	flup	f3, 2		# fli	f3, 1.000000
	j	beq_cont.16795
beq_then.16794:
	flup	f3, 11		# fli	f3, -1.000000
beq_cont.16795:
beq_cont.16791:
	fneg	f3, f3
	add	r30, r12, r11
	fsw	f3, 0(r30)
beq_cont.16785:
	flw	f3, 727(r0)
	fsw	f3, 748(r0)
	flw	f3, 728(r0)
	fsw	f3, 749(r0)
	flw	f3, 729(r0)
	fsw	f3, 750(r0)
	addi	r6, r0, 727				# set min_caml_intersection_point
	fsw	f5, 8(r3)
	sw	r7, 10(r3)
	sw	r8, 11(r3)
	sw	r9, 12(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	utexture.3185				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f5, 8(r3)
	lw	r5, 4(r3)
	lw	r7, 10(r3)
	lw	r8, 11(r3)
	lw	r1, 5(r3)
	lw	r9, 12(r3)
	lw	r10, 6(r3)
	lw	r2, 7(r3)
	slli	r7, r7, 2
	lw	r6, 725(r0)
	add	r6, r7, r6
	add	r30, r10, r1
	sw	r6, 0(r30)
	lw	r6, 1(r5)
	add	r30, r6, r1
	lw	r6, 0(r30)
	flw	f3, 727(r0)
	fsw	f3, 0(r6)
	flw	f3, 728(r0)
	fsw	f3, 1(r6)
	flw	f3, 729(r0)
	fsw	f3, 2(r6)
	lw	r7, 3(r5)
	flup	f4, 1		# fli	f4, 0.500000
	lw	r6, 7(r8)
	flw	f3, 0(r6)
	fle	r30, f4, f3
	beq	r0, r30, fle_else.16796
	addi	r6, r0, 1
	add	r30, r7, r1
	sw	r6, 0(r30)
	lw	r6, 4(r5)
	add	r30, r6, r1
	lw	r7, 0(r30)
	flw	f3, 734(r0)
	fsw	f3, 0(r7)
	flw	f3, 735(r0)
	fsw	f3, 1(r7)
	flw	f3, 736(r0)
	fsw	f3, 2(r7)
	add	r30, r6, r1
	lw	r6, 0(r30)
	flup	f3, 43		# fli	f3, 0.003906
	fmul	f3, f3, f5
	flw	f4, 0(r6)
	fmul	f4, f4, f3
	fsw	f4, 0(r6)
	flw	f4, 1(r6)
	fmul	f4, f4, f3
	fsw	f4, 1(r6)
	flw	f4, 2(r6)
	fmul	f3, f4, f3
	fsw	f3, 2(r6)
	lw	r6, 7(r5)
	add	r30, r6, r1
	lw	r6, 0(r30)
	flw	f3, 731(r0)
	fsw	f3, 0(r6)
	flw	f3, 732(r0)
	fsw	f3, 1(r6)
	flw	f3, 733(r0)
	fsw	f3, 2(r6)
	j	fle_cont.16797
fle_else.16796:
	addi	r6, r0, 0
	add	r30, r7, r1
	sw	r6, 0(r30)
fle_cont.16797:
	flup	f4, 44		# fli	f4, -2.000000
	flw	f6, 0(r2)
	flw	f3, 731(r0)
	fmul	f7, f6, f3
	flw	f6, 1(r2)
	flw	f3, 732(r0)
	fmul	f3, f6, f3
	fadd	f7, f7, f3
	flw	f6, 2(r2)
	flw	f3, 733(r0)
	fmul	f3, f6, f3
	fadd	f3, f7, f3
	fmul	f3, f4, f3
	flw	f6, 0(r2)
	flw	f4, 731(r0)
	fmul	f4, f3, f4
	fadd	f4, f6, f4
	fsw	f4, 0(r2)
	flw	f6, 1(r2)
	flw	f4, 732(r0)
	fmul	f4, f3, f4
	fadd	f4, f6, f4
	fsw	f4, 1(r2)
	flw	f6, 2(r2)
	flw	f4, 733(r0)
	fmul	f3, f3, f4
	fadd	f3, f6, f3
	fsw	f3, 2(r2)
	lw	r6, 7(r8)
	flw	f3, 1(r6)
	fmul	f3, f1, f3
	addi	r6, r0, 0
	lw	r7, 723(r0)
	fsw	f3, 14(r3)
	add	r2, r0, r7
	add	r1, r0, r6
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	shadow_check_one_or_matrix.3145				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	add	r6, r0, r1
	flw	f3, 14(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f5, 8(r3)
	lw	r5, 4(r3)
	lw	r8, 11(r3)
	lw	r1, 5(r3)
	lw	r9, 12(r3)
	lw	r10, 6(r3)
	lw	r2, 7(r3)
	beqi	0, r6, beq_then.16799
	j	beq_cont.16800
beq_then.16799:
	flw	f6, 731(r0)
	flw	f4, 667(r0)
	fmul	f7, f6, f4
	flw	f6, 732(r0)
	flw	f4, 668(r0)
	fmul	f4, f6, f4
	fadd	f7, f7, f4
	flw	f6, 733(r0)
	flw	f4, 669(r0)
	fmul	f4, f6, f4
	fadd	f4, f7, f4
	fneg	f4, f4
	fmul	f6, f4, f5
	flw	f7, 0(r2)
	flw	f4, 667(r0)
	fmul	f8, f7, f4
	flw	f7, 1(r2)
	flw	f4, 668(r0)
	fmul	f4, f7, f4
	fadd	f8, f8, f4
	flw	f7, 2(r2)
	flw	f4, 669(r0)
	fmul	f4, f7, f4
	fadd	f4, f8, f4
	fneg	f4, f4
	fadd	f2, f0, f4
	fadd	f1, f0, f6
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	add_light.3188				
	addi	r3, r3, -17
	lw	r31, 16(r3)
beq_cont.16800:
	flw	f3, 14(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f5, 8(r3)
	lw	r5, 4(r3)
	lw	r8, 11(r3)
	lw	r1, 5(r3)
	lw	r9, 12(r3)
	lw	r10, 6(r3)
	lw	r2, 7(r3)
	addi	r7, r0, 727				# set min_caml_intersection_point
	flw	f4, 727(r0)
	fsw	f4, 751(r0)
	flw	f4, 728(r0)
	fsw	f4, 752(r0)
	flw	f4, 729(r0)
	fsw	f4, 753(r0)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	setup_startp_constants.3108				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f3, 14(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f5, 8(r3)
	lw	r5, 4(r3)
	lw	r8, 11(r3)
	lw	r1, 5(r3)
	lw	r9, 12(r3)
	lw	r10, 6(r3)
	lw	r2, 7(r3)
	lw	r6, 1023(r0)
	addi	r6, r6, -1
	add	r1, r0, r6
	fadd	f2, f0, f3
	fadd	f1, f0, f5
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	trace_reflections.3192				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	lw	r5, 4(r3)
	lw	r8, 11(r3)
	lw	r1, 5(r3)
	lw	r9, 12(r3)
	lw	r10, 6(r3)
	lw	r2, 7(r3)
	flup	f3, 45		# fli	f3, 0.100000
	fle	r30, f1, f3
	beq	r0, r30, fle_else.16801
	jr	r31				#
fle_else.16801:
	bgei	4, r1, bge_then.16803
	addi	r7, r1, 1
	addi	r6, r0, -1
	add	r30, r10, r7
	sw	r6, 0(r30)
	j	bge_cont.16804
bge_then.16803:
bge_cont.16804:
	beqi	2, r9, beq_then.16805
	j	beq_cont.16806
beq_then.16805:
	flup	f4, 2		# fli	f4, 1.000000
	lw	r6, 7(r8)
	flw	f3, 0(r6)
	fsub	f3, f4, f3
	fmul	f1, f1, f3
	addi	r1, r1, 1
	flw	f3, 726(r0)
	fadd	f2, f2, f3
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	trace_ray.3197				
	addi	r3, r3, -17
	lw	r31, 16(r3)
beq_cont.16806:
	jr	r31				#
beq_then.16783:
	addi	r5, r0, -1
	add	r30, r10, r1
	sw	r5, 0(r30)
	beqi	0, r1, beq_then.16808
	flw	f3, 0(r2)
	flw	f2, 667(r0)
	fmul	f4, f3, f2
	flw	f3, 1(r2)
	flw	f2, 668(r0)
	fmul	f2, f3, f2
	fadd	f4, f4, f2
	flw	f3, 2(r2)
	flw	f2, 669(r0)
	fmul	f2, f3, f2
	fadd	f2, f4, f2
	fneg	f2, f2
	fle	r30, f2, f0
	beq	r0, r30, fle_else.16809
	addi	r1, r0, 0
	j	fle_cont.16810
fle_else.16809:
	addi	r1, r0, 1
fle_cont.16810:
	beqi	0, r1, beq_then.16811
	fmul	f3, f2, f2
	fmul	f2, f3, f2
	fmul	f2, f2, f1
	flw	f1, 670(r0)
	fmul	f1, f2, f1
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
beq_then.16811:
	jr	r31				#
beq_then.16808:
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
	flw	f1, 0(r3)
	lw	r1, 2(r3)
	flw	f2, 726(r0)
	flup	f3, 30		# fli	f3, -0.100000
	fle	r30, f2, f3
	beq	r0, r30, fle_else.16815
	addi	r2, r0, 0
	j	fle_cont.16816
fle_else.16815:
	flup	f1, 32		# fli	f1, 100000000.000000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16817
	addi	r2, r0, 0
	j	fle_cont.16818
fle_else.16817:
	addi	r2, r0, 1
fle_cont.16818:
fle_cont.16816:
	beqi	0, r2, beq_then.16819
	lw	r2, 730(r0)
	lw	r2, 1(r0)
	lw	r5, 0(r1)
	lw	r1, 1(r2)
	beqi	1, r1, beq_then.16820
	beqi	2, r1, beq_then.16822
	add	r1, r0, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	get_nvector_second.3180				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16823
beq_then.16822:
	lw	r1, 4(r2)
	flw	f1, 0(r1)
	fneg	f1, f1
	fsw	f1, 731(r0)
	lw	r1, 4(r2)
	flw	f1, 1(r1)
	fneg	f1, f1
	fsw	f1, 732(r0)
	lw	r1, 4(r2)
	flw	f1, 2(r1)
	fneg	f1, f1
	fsw	f1, 733(r0)
beq_cont.16823:
	j	beq_cont.16821
beq_then.16820:
	lw	r1, 725(r0)
	fsw	f0, 731(r0)
	fsw	f0, 732(r0)
	fsw	f0, 733(r0)
	addi	r7, r0, 731				# set min_caml_nvector
	addi	r6, r1, -1
	addi	r1, r1, -1
	add	r30, r5, r1
	flw	f3, 0(r30)
	feq	r30, f3, f0
	beq	r0, r30, feq_else.16824
	addi	r1, r0, 1
	j	feq_cont.16825
feq_else.16824:
	addi	r1, r0, 0
feq_cont.16825:
	beqi	0, r1, beq_then.16826
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16827
beq_then.16826:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.16828
	addi	r1, r0, 0
	j	fle_cont.16829
fle_else.16828:
	addi	r1, r0, 1
fle_cont.16829:
	beqi	0, r1, beq_then.16830
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.16831
beq_then.16830:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.16831:
beq_cont.16827:
	fneg	f2, f2
	add	r30, r7, r6
	fsw	f2, 0(r30)
beq_cont.16821:
	addi	r1, r0, 727				# set min_caml_intersection_point
	sw	r2, 3(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	utexture.3185				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f1, 0(r3)
	lw	r2, 3(r3)
	addi	r1, r0, 0
	lw	r5, 723(r0)
	add	r2, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_one_or_matrix.3145				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f1, 0(r3)
	lw	r2, 3(r3)
	beqi	0, r1, beq_then.16832
	jr	r31				#
beq_then.16832:
	flw	f3, 731(r0)
	flw	f2, 667(r0)
	fmul	f4, f3, f2
	flw	f3, 732(r0)
	flw	f2, 668(r0)
	fmul	f2, f3, f2
	fadd	f4, f4, f2
	flw	f3, 733(r0)
	flw	f2, 669(r0)
	fmul	f2, f3, f2
	fadd	f2, f4, f2
	fneg	f3, f2
	fle	r30, f3, f0
	beq	r0, r30, fle_else.16834
	addi	r1, r0, 0
	j	fle_cont.16835
fle_else.16834:
	addi	r1, r0, 1
fle_cont.16835:
	beqi	0, r1, beq_then.16836
	fadd	f2, f0, f3
	j	beq_cont.16837
beq_then.16836:
	flup	f2, 0		# fli	f2, 0.000000
beq_cont.16837:
	fmul	f2, f1, f2
	lw	r1, 7(r2)
	flw	f1, 0(r1)
	fmul	f1, f2, f1
	flw	f3, 737(r0)
	flw	f2, 734(r0)
	fmul	f2, f1, f2
	fadd	f2, f3, f2
	fsw	f2, 737(r0)
	flw	f3, 738(r0)
	flw	f2, 735(r0)
	fmul	f2, f1, f2
	fadd	f2, f3, f2
	fsw	f2, 738(r0)
	flw	f3, 739(r0)
	flw	f2, 736(r0)
	fmul	f1, f1, f2
	fadd	f1, f3, f1
	fsw	f1, 739(r0)
	jr	r31				#
beq_then.16819:
	jr	r31				#
iter_trace_diffuse_rays.3206:
	bgei	0, r6, bge_then.16840
	jr	r31				#
bge_then.16840:
	add	r30, r1, r6
	lw	r7, 0(r30)
	lw	r7, 0(r7)
	flw	f2, 0(r7)
	flw	f1, 0(r2)
	fmul	f3, f2, f1
	flw	f2, 1(r7)
	flw	f1, 1(r2)
	fmul	f1, f2, f1
	fadd	f3, f3, f1
	flw	f2, 2(r7)
	flw	f1, 2(r2)
	fmul	f1, f2, f1
	fadd	f1, f3, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16842
	addi	r7, r0, 0
	j	fle_cont.16843
fle_else.16842:
	addi	r7, r0, 1
fle_cont.16843:
	beqi	0, r7, beq_then.16844
	addi	r7, r6, 1
	add	r30, r1, r7
	lw	r7, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	finv	f31, f2
	fmul	f1, f1, f31
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	sw	r1, 3(r3)
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16845
beq_then.16844:
	add	r30, r1, r6
	lw	r7, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	finv	f31, f2
	fmul	f1, f1, f31
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	sw	r1, 3(r3)
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16845:
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r1, 3(r3)
	addi	r7, r6, -2
	bgei	0, r7, bge_then.16846
	jr	r31				#
bge_then.16846:
	add	r30, r1, r7
	lw	r6, 0(r30)
	lw	r6, 0(r6)
	flw	f2, 0(r6)
	flw	f1, 0(r2)
	fmul	f3, f2, f1
	flw	f2, 1(r6)
	flw	f1, 1(r2)
	fmul	f1, f2, f1
	fadd	f3, f3, f1
	flw	f2, 2(r6)
	flw	f1, 2(r2)
	fmul	f1, f2, f1
	fadd	f1, f3, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16848
	addi	r6, r0, 0
	j	fle_cont.16849
fle_else.16848:
	addi	r6, r0, 1
fle_cont.16849:
	beqi	0, r6, beq_then.16850
	addi	r6, r7, 1
	add	r30, r1, r6
	lw	r6, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	finv	f31, f2
	fmul	f1, f1, f31
	sw	r7, 4(r3)
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16851
beq_then.16850:
	add	r30, r1, r7
	lw	r6, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	finv	f31, f2
	fmul	f1, f1, f31
	sw	r7, 4(r3)
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16851:
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 3(r3)
	lw	r7, 4(r3)
	addi	r6, r7, -2
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
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r6, 118(r1)
	lw	r6, 0(r6)
	flw	f2, 0(r6)
	flw	f1, 0(r2)
	fmul	f3, f2, f1
	flw	f2, 1(r6)
	flw	f1, 1(r2)
	fmul	f1, f2, f1
	fadd	f3, f3, f1
	flw	f2, 2(r6)
	flw	f1, 2(r2)
	fmul	f1, f2, f1
	fadd	f1, f3, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16852
	addi	r6, r0, 0
	j	fle_cont.16853
fle_else.16852:
	addi	r6, r0, 1
fle_cont.16853:
	beqi	0, r6, beq_then.16854
	lw	r6, 119(r1)
	flup	f2, 46		# fli	f2, -150.000000
	finv	f31, f2
	fmul	f1, f1, f31
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16855
beq_then.16854:
	lw	r6, 118(r1)
	flup	f2, 47		# fli	f2, 150.000000
	finv	f31, f2
	fmul	f1, f1, f31
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16855:
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	addi	r6, r0, 116
	j	iter_trace_diffuse_rays.3206
trace_diffuse_ray_80percent.3215:
	beqi	0, r1, beq_then.16856
	lw	r7, 766(r0)
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
	sw	r7, 3(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	setup_startp_constants.3108				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r7, 3(r3)
	addi	r6, r0, 118
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	iter_trace_diffuse_rays.3206				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16857
beq_then.16856:
beq_cont.16857:
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	beqi	1, r1, beq_then.16858
	lw	r7, 767(r0)
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
	sw	r7, 4(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_startp_constants.3108				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r7, 4(r3)
	addi	r6, r0, 118
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_trace_diffuse_rays.3206				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16859
beq_then.16858:
beq_cont.16859:
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	beqi	2, r1, beq_then.16860
	lw	r7, 768(r0)
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
	sw	r7, 5(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_startp_constants.3108				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r7, 5(r3)
	addi	r6, r0, 118
	add	r1, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_trace_diffuse_rays.3206				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16861
beq_then.16860:
beq_cont.16861:
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	beqi	3, r1, beq_then.16862
	lw	r7, 769(r0)
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
	sw	r7, 6(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_startp_constants.3108				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r7, 6(r3)
	addi	r6, r0, 118
	add	r1, r0, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	iter_trace_diffuse_rays.3206				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.16863
beq_then.16862:
beq_cont.16863:
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	beqi	4, r1, beq_then.16864
	lw	r6, 770(r0)
	flw	f1, 0(r5)
	fsw	f1, 751(r0)
	flw	f1, 1(r5)
	fsw	f1, 752(r0)
	flw	f1, 2(r5)
	fsw	f1, 753(r0)
	lw	r1, 0(r0)
	addi	r1, r1, -1
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r6, 7(r3)
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_startp_constants.3108				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r6, 7(r3)
	addi	r1, r0, 118
	add	r28, r0, r6
	add	r6, r0, r1
	add	r1, r0, r28
	j	iter_trace_diffuse_rays.3206
beq_then.16864:
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
	lw	r6, 0(r30)
	add	r30, r7, r2
	lw	r5, 0(r30)
	sw	r2, 0(r3)
	sw	r8, 1(r3)
	add	r2, r0, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	trace_diffuse_ray_80percent.3215				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 0(r3)
	lw	r8, 1(r3)
	addi	r5, r0, 740				# set min_caml_rgb
	add	r30, r8, r2
	lw	r2, 0(r30)
	addi	r1, r0, 737				# set min_caml_diffuse_ray
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r28
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
	flw	f2, 737(r0)
	flw	f1, 0(r2)
	fadd	f1, f2, f1
	fsw	f1, 737(r0)
	flw	f2, 738(r0)
	flw	f1, 1(r2)
	fadd	f1, f2, f1
	fsw	f1, 738(r0)
	flw	f2, 739(r0)
	flw	f1, 2(r2)
	fadd	f1, f2, f1
	fsw	f1, 739(r0)
	add	r30, r9, r7
	lw	r2, 0(r30)
	flw	f2, 737(r0)
	flw	f1, 0(r2)
	fadd	f1, f2, f1
	fsw	f1, 737(r0)
	flw	f2, 738(r0)
	flw	f1, 1(r2)
	fadd	f1, f2, f1
	fsw	f1, 738(r0)
	flw	f2, 739(r0)
	flw	f1, 2(r2)
	fadd	f1, f2, f1
	fsw	f1, 739(r0)
	add	r30, r10, r7
	lw	r2, 0(r30)
	flw	f2, 737(r0)
	flw	f1, 0(r2)
	fadd	f1, f2, f1
	fsw	f1, 737(r0)
	flw	f2, 738(r0)
	flw	f1, 1(r2)
	fadd	f1, f2, f1
	fsw	f1, 738(r0)
	flw	f2, 739(r0)
	flw	f1, 2(r2)
	fadd	f1, f2, f1
	fsw	f1, 739(r0)
	add	r30, r6, r7
	lw	r2, 0(r30)
	flw	f2, 737(r0)
	flw	f1, 0(r2)
	fadd	f1, f2, f1
	fsw	f1, 737(r0)
	flw	f2, 738(r0)
	flw	f1, 1(r2)
	fadd	f1, f2, f1
	fsw	f1, 738(r0)
	flw	f2, 739(r0)
	flw	f1, 2(r2)
	fadd	f1, f2, f1
	fsw	f1, 739(r0)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 4(r1)
	addi	r5, r0, 740				# set min_caml_rgb
	add	r30, r1, r7
	lw	r2, 0(r30)
	addi	r1, r0, 737				# set min_caml_diffuse_ray
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r28
	j	vecaccumv.2912
do_without_neighbors.3228:
	blei	4, r2, ble_then.16866
	jr	r31				#
ble_then.16866:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.16868
	jr	r31				#
bge_then.16868:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	beqi	0, r5, beq_then.16870
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
	lw	r9, 0(r30)
	add	r30, r7, r2
	lw	r6, 0(r30)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r8, 2(r3)
	add	r2, r0, r9
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_ray_80percent.3215				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	lw	r8, 2(r3)
	addi	r7, r0, 740				# set min_caml_rgb
	add	r30, r8, r2
	lw	r6, 0(r30)
	addi	r5, r0, 737				# set min_caml_diffuse_ray
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	vecaccumv.2912				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16871
beq_then.16870:
beq_cont.16871:
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	addi	r8, r2, 1
	blei	4, r8, ble_then.16872
	jr	r31				#
ble_then.16872:
	lw	r2, 2(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	bgei	0, r2, bge_then.16874
	jr	r31				#
bge_then.16874:
	lw	r2, 3(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	beqi	0, r2, beq_then.16876
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
	lw	r9, 0(r30)
	add	r30, r6, r8
	lw	r5, 0(r30)
	sw	r1, 0(r3)
	sw	r7, 3(r3)
	sw	r8, 4(r3)
	add	r1, r0, r2
	add	r2, r0, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	trace_diffuse_ray_80percent.3215				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 0(r3)
	lw	r7, 3(r3)
	lw	r8, 4(r3)
	addi	r6, r0, 740				# set min_caml_rgb
	add	r30, r7, r8
	lw	r5, 0(r30)
	addi	r2, r0, 737				# set min_caml_diffuse_ray
	add	r1, r0, r6
	add	r28, r0, r5
	add	r5, r0, r2
	add	r2, r0, r28
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	vecaccumv.2912				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16877
beq_then.16876:
beq_cont.16877:
	lw	r1, 0(r3)
	lw	r8, 4(r3)
	addi	r2, r8, 1
	j	do_without_neighbors.3228
neighbors_exist.3231:
	lw	r6, 744(r0)
	addi	r5, r2, 1
	ble	r6, r5, ble_then.16878
	blei	0, r2, ble_then.16879
	lw	r5, 743(r0)
	addi	r2, r1, 1
	ble	r5, r2, ble_then.16880
	blei	0, r1, ble_then.16881
	addi	r1, r0, 1
	jr	r31				#
ble_then.16881:
	addi	r1, r0, 0
	jr	r31				#
ble_then.16880:
	addi	r1, r0, 0
	jr	r31				#
ble_then.16879:
	addi	r1, r0, 0
	jr	r31				#
ble_then.16878:
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
	beq	r2, r8, beq_then.16882
	addi	r1, r0, 0
	jr	r31				#
beq_then.16882:
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.16883
	addi	r1, r0, 0
	jr	r31				#
beq_then.16883:
	addi	r2, r1, -1
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.16884
	addi	r1, r0, 0
	jr	r31				#
beq_then.16884:
	addi	r1, r1, 1
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beq	r1, r8, beq_then.16885
	addi	r1, r0, 0
	jr	r31				#
beq_then.16885:
	addi	r1, r0, 1
	jr	r31				#
try_exploit_neighbors.3244:
	add	r30, r6, r1
	lw	r10, 0(r30)
	blei	4, r8, ble_then.16886
	jr	r31				#
ble_then.16886:
	lw	r9, 2(r10)
	add	r30, r9, r8
	lw	r9, 0(r30)
	bgei	0, r9, bge_then.16888
	jr	r31				#
bge_then.16888:
	add	r30, r6, r1
	lw	r9, 0(r30)
	lw	r9, 2(r9)
	add	r30, r9, r8
	lw	r9, 0(r30)
	add	r30, r5, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r9, beq_then.16890
	addi	r11, r0, 0
	j	beq_cont.16891
beq_then.16890:
	add	r30, r7, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r8
	lw	r2, 0(r30)
	beq	r2, r9, beq_then.16892
	addi	r11, r0, 0
	j	beq_cont.16893
beq_then.16892:
	addi	r2, r1, -1
	add	r30, r6, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r8
	lw	r2, 0(r30)
	beq	r2, r9, beq_then.16894
	addi	r11, r0, 0
	j	beq_cont.16895
beq_then.16894:
	addi	r1, r1, 1
	add	r30, r6, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r8
	lw	r1, 0(r30)
	beq	r1, r9, beq_then.16896
	addi	r11, r0, 0
	j	beq_cont.16897
beq_then.16896:
	addi	r11, r0, 1
beq_cont.16897:
beq_cont.16895:
beq_cont.16893:
beq_cont.16891:
	beqi	0, r11, beq_then.16898
	lw	r9, 3(r10)
	add	r30, r9, r8
	lw	r9, 0(r30)
	beqi	0, r9, beq_then.16899
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r8, 3(r3)
	sw	r7, 4(r3)
	sw	r6, 5(r3)
	add	r2, r0, r5
	add	r5, r0, r6
	add	r6, r0, r7
	add	r7, r0, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_diffuse_using_5points.3222				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16900
beq_then.16899:
beq_cont.16900:
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r8, 3(r3)
	lw	r7, 4(r3)
	lw	r6, 5(r3)
	addi	r11, r8, 1
	add	r30, r6, r1
	lw	r9, 0(r30)
	blei	4, r11, ble_then.16901
	jr	r31				#
ble_then.16901:
	lw	r8, 2(r9)
	add	r30, r8, r11
	lw	r8, 0(r30)
	bgei	0, r8, bge_then.16903
	jr	r31				#
bge_then.16903:
	add	r30, r6, r1
	lw	r8, 0(r30)
	lw	r8, 2(r8)
	add	r30, r8, r11
	lw	r8, 0(r30)
	add	r30, r5, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r11
	lw	r10, 0(r30)
	beq	r10, r8, beq_then.16905
	addi	r10, r0, 0
	j	beq_cont.16906
beq_then.16905:
	add	r30, r7, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r11
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.16907
	addi	r10, r0, 0
	j	beq_cont.16908
beq_then.16907:
	addi	r2, r1, -1
	add	r30, r6, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r11
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.16909
	addi	r10, r0, 0
	j	beq_cont.16910
beq_then.16909:
	addi	r1, r1, 1
	add	r30, r6, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r11
	lw	r1, 0(r30)
	beq	r1, r8, beq_then.16911
	addi	r10, r0, 0
	j	beq_cont.16912
beq_then.16911:
	addi	r10, r0, 1
beq_cont.16912:
beq_cont.16910:
beq_cont.16908:
beq_cont.16906:
	beqi	0, r10, beq_then.16913
	lw	r8, 3(r9)
	add	r30, r8, r11
	lw	r8, 0(r30)
	beqi	0, r8, beq_then.16914
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 4(r3)
	sw	r6, 5(r3)
	sw	r11, 6(r3)
	add	r2, r0, r5
	add	r5, r0, r6
	add	r6, r0, r7
	add	r7, r0, r11
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	calc_diffuse_using_5points.3222				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.16915
beq_then.16914:
beq_cont.16915:
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r7, 4(r3)
	lw	r6, 5(r3)
	lw	r11, 6(r3)
	addi	r8, r11, 1
	j	try_exploit_neighbors.3244
beq_then.16913:
	add	r30, r6, r1
	lw	r1, 0(r30)
	add	r2, r0, r11
	j	do_without_neighbors.3228
beq_then.16898:
	add	r30, r6, r1
	lw	r7, 0(r30)
	blei	4, r8, ble_then.16916
	jr	r31				#
ble_then.16916:
	lw	r1, 2(r7)
	add	r30, r1, r8
	lw	r1, 0(r30)
	bgei	0, r1, bge_then.16918
	jr	r31				#
bge_then.16918:
	lw	r1, 3(r7)
	add	r30, r1, r8
	lw	r1, 0(r30)
	beqi	0, r1, beq_then.16920
	lw	r1, 5(r7)
	lw	r2, 7(r7)
	lw	r5, 1(r7)
	lw	r6, 4(r7)
	add	r30, r1, r8
	lw	r1, 0(r30)
	flw	f1, 0(r1)
	fsw	f1, 737(r0)
	flw	f1, 1(r1)
	fsw	f1, 738(r0)
	flw	f1, 2(r1)
	fsw	f1, 739(r0)
	lw	r1, 6(r7)
	lw	r1, 0(r1)
	add	r30, r2, r8
	lw	r9, 0(r30)
	add	r30, r5, r8
	lw	r2, 0(r30)
	sw	r8, 3(r3)
	sw	r6, 7(r3)
	sw	r7, 8(r3)
	add	r5, r0, r2
	add	r2, r0, r9
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	trace_diffuse_ray_80percent.3215				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r8, 3(r3)
	lw	r6, 7(r3)
	lw	r7, 8(r3)
	addi	r5, r0, 740				# set min_caml_rgb
	add	r30, r6, r8
	lw	r2, 0(r30)
	addi	r1, r0, 737				# set min_caml_diffuse_ray
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r28
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	vecaccumv.2912				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.16921
beq_then.16920:
beq_cont.16921:
	lw	r8, 3(r3)
	lw	r7, 8(r3)
	addi	r1, r8, 1
	add	r2, r0, r1
	add	r1, r0, r7
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
	ble	r1, r2, ble_then.16922
	addi	r2, r0, 255
	j	ble_cont.16923
ble_then.16922:
	bgei	0, r1, bge_then.16924
	addi	r2, r0, 0
	j	bge_cont.16925
bge_then.16924:
	add	r2, r0, r1
bge_cont.16925:
ble_cont.16923:
	add	r1, r0, r2
	j	print_int.2857
write_rgb.3255:
	flw	f1, 740(r0)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16926
	addi	r2, r0, 255
	j	ble_cont.16927
ble_then.16926:
	bgei	0, r1, bge_then.16928
	addi	r2, r0, 0
	j	bge_cont.16929
bge_then.16928:
	add	r2, r0, r1
bge_cont.16929:
ble_cont.16927:
	add	r1, r0, r2
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
	ble	r1, r2, ble_then.16930
	addi	r2, r0, 255
	j	ble_cont.16931
ble_then.16930:
	bgei	0, r1, bge_then.16932
	addi	r2, r0, 0
	j	bge_cont.16933
bge_then.16932:
	add	r2, r0, r1
bge_cont.16933:
ble_cont.16931:
	add	r1, r0, r2
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
	ble	r1, r2, ble_then.16934
	addi	r2, r0, 255
	j	ble_cont.16935
ble_then.16934:
	bgei	0, r1, bge_then.16936
	addi	r2, r0, 0
	j	bge_cont.16937
bge_then.16936:
	add	r2, r0, r1
bge_cont.16937:
ble_cont.16935:
	add	r1, r0, r2
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
pretrace_diffuse_rays.3257:
	blei	4, r2, ble_then.16938
	jr	r31				#
ble_then.16938:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.16940
	jr	r31				#
bge_then.16940:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	beqi	0, r5, beq_then.16942
	lw	r5, 6(r1)
	lw	r7, 0(r5)
	fsw	f0, 737(r0)
	fsw	f0, 738(r0)
	fsw	f0, 739(r0)
	lw	r5, 7(r1)
	lw	r6, 1(r1)
	addi	r8, r0, 766				# set min_caml_dirvecs
	add	r30, r8, r7
	lw	r8, 0(r30)
	add	r30, r5, r2
	lw	r7, 0(r30)
	add	r30, r6, r2
	lw	r6, 0(r30)
	flw	f1, 0(r6)
	fsw	f1, 751(r0)
	flw	f1, 1(r6)
	fsw	f1, 752(r0)
	flw	f1, 2(r6)
	fsw	f1, 753(r0)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	sw	r8, 4(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_startp_constants.3108				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r7, 3(r3)
	lw	r8, 4(r3)
	addi	r5, r0, 118
	add	r2, r0, r7
	add	r1, r0, r8
	add	r28, r0, r6
	add	r6, r0, r5
	add	r5, r0, r28
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_trace_diffuse_rays.3206				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	lw	r5, 5(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	flw	f1, 737(r0)
	fsw	f1, 0(r5)
	flw	f1, 738(r0)
	fsw	f1, 1(r5)
	flw	f1, 739(r0)
	fsw	f1, 2(r5)
	j	beq_cont.16943
beq_then.16942:
beq_cont.16943:
	addi	r2, r2, 1
	j	pretrace_diffuse_rays.3257
pretrace_pixels.3260:
	bgei	0, r2, bge_then.16944
	jr	r31				#
bge_then.16944:
	flw	f5, 747(r0)
	lw	r6, 745(r0)
	sub	r6, r2, r6
	itof	f4, r6
	fmul	f4, f5, f4
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
	addi	r7, r0, 763				# set min_caml_ptrace_dirvec
	addi	r6, r0, 0
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	sw	r5, 8(r3)
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	vecunit_sgn.2888				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	lw	r2, 6(r3)
	lw	r1, 7(r3)
	lw	r5, 8(r3)
	fsw	f0, 740(r0)
	fsw	f0, 741(r0)
	fsw	f0, 742(r0)
	flw	f4, 664(r0)
	fsw	f4, 748(r0)
	flw	f4, 665(r0)
	fsw	f4, 749(r0)
	flw	f4, 666(r0)
	fsw	f4, 750(r0)
	addi	r7, r0, 0
	flup	f5, 2		# fli	f5, 1.000000
	addi	r8, r0, 763				# set min_caml_ptrace_dirvec
	add	r30, r1, r2
	lw	r6, 0(r30)
	flup	f4, 0		# fli	f4, 0.000000
	add	r5, r0, r6
	add	r2, r0, r8
	add	r1, r0, r7
	fadd	f2, f0, f4
	fadd	f1, f0, f5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	trace_ray.3197				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	lw	r2, 6(r3)
	lw	r1, 7(r3)
	lw	r5, 8(r3)
	add	r30, r1, r2
	lw	r6, 0(r30)
	lw	r6, 0(r6)
	flw	f4, 740(r0)
	fsw	f4, 0(r6)
	flw	f4, 741(r0)
	fsw	f4, 1(r6)
	flw	f4, 742(r0)
	fsw	f4, 2(r6)
	add	r30, r1, r2
	lw	r6, 0(r30)
	lw	r6, 6(r6)
	sw	r5, 0(r6)
	add	r30, r1, r2
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r7
	add	r1, r0, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	pretrace_diffuse_rays.3257				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	lw	r2, 6(r3)
	lw	r1, 7(r3)
	lw	r5, 8(r3)
	addi	r6, r2, -1
	addi	r2, r5, 1
	bgei	5, r2, bge_then.16946
	add	r5, r0, r2
	j	bge_cont.16947
bge_then.16946:
	addi	r5, r2, -5
bge_cont.16947:
	add	r2, r0, r6
	j	pretrace_pixels.3260
pretrace_line.3267:
	flw	f2, 747(r0)
	lw	r6, 746(r0)
	sub	r2, r2, r6
	itof	f1, r2
	fmul	f1, f2, f1
	flw	f2, 757(r0)
	fmul	f3, f1, f2
	flw	f2, 760(r0)
	fadd	f3, f3, f2
	flw	f2, 758(r0)
	fmul	f4, f1, f2
	flw	f2, 761(r0)
	fadd	f2, f4, f2
	flw	f4, 759(r0)
	fmul	f4, f1, f4
	flw	f1, 762(r0)
	fadd	f1, f4, f1
	lw	r2, 743(r0)
	addi	r2, r2, -1
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	j	pretrace_pixels.3260
scan_pixel.3271:
	lw	r8, 743(r0)
	ble	r8, r1, ble_then.16948
	add	r30, r6, r1
	lw	r8, 0(r30)
	lw	r8, 0(r8)
	flw	f1, 0(r8)
	fsw	f1, 740(r0)
	flw	f1, 1(r8)
	fsw	f1, 741(r0)
	flw	f1, 2(r8)
	fsw	f1, 742(r0)
	lw	r9, 744(r0)
	addi	r8, r2, 1
	ble	r9, r8, ble_then.16949
	blei	0, r2, ble_then.16951
	lw	r5, 743(r0)
	addi	r2, r1, 1
	ble	r5, r2, ble_then.16953
	blei	0, r1, ble_then.16955
	addi	r8, r0, 1
	j	ble_cont.16956
ble_then.16955:
	addi	r8, r0, 0
ble_cont.16956:
	j	ble_cont.16954
ble_then.16953:
	addi	r8, r0, 0
ble_cont.16954:
	j	ble_cont.16952
ble_then.16951:
	addi	r8, r0, 0
ble_cont.16952:
	j	ble_cont.16950
ble_then.16949:
	addi	r8, r0, 0
ble_cont.16950:
	beqi	0, r8, beq_then.16957
	addi	r11, r0, 0
	add	r30, r6, r1
	lw	r9, 0(r30)
	lw	r8, 2(r9)
	lw	r8, 0(r8)
	bgei	0, r8, bge_then.16959
	j	bge_cont.16960
bge_then.16959:
	add	r30, r6, r1
	lw	r8, 0(r30)
	lw	r8, 2(r8)
	lw	r8, 0(r8)
	add	r30, r5, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	lw	r10, 0(r10)
	beq	r10, r8, beq_then.16961
	addi	r10, r0, 0
	j	beq_cont.16962
beq_then.16961:
	add	r30, r7, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	lw	r2, 0(r2)
	beq	r2, r8, beq_then.16963
	addi	r10, r0, 0
	j	beq_cont.16964
beq_then.16963:
	addi	r2, r1, -1
	add	r30, r6, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	lw	r2, 0(r2)
	beq	r2, r8, beq_then.16965
	addi	r10, r0, 0
	j	beq_cont.16966
beq_then.16965:
	addi	r1, r1, 1
	add	r30, r6, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	lw	r1, 0(r1)
	beq	r1, r8, beq_then.16967
	addi	r10, r0, 0
	j	beq_cont.16968
beq_then.16967:
	addi	r10, r0, 1
beq_cont.16968:
beq_cont.16966:
beq_cont.16964:
beq_cont.16962:
	beqi	0, r10, beq_then.16969
	lw	r8, 3(r9)
	lw	r8, 0(r8)
	beqi	0, r8, beq_then.16971
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	sw	r6, 4(r3)
	add	r2, r0, r5
	add	r5, r0, r6
	add	r6, r0, r7
	add	r7, r0, r11
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_diffuse_using_5points.3222				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16972
beq_then.16971:
beq_cont.16972:
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r6, 4(r3)
	addi	r8, r0, 1
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	try_exploit_neighbors.3244				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16970
beq_then.16969:
	add	r30, r6, r1
	lw	r1, 0(r30)
	add	r2, r0, r11
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	do_without_neighbors.3228				
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16970:
bge_cont.16960:
	j	beq_cont.16958
beq_then.16957:
	add	r30, r6, r1
	lw	r7, 0(r30)
	lw	r1, 2(r7)
	lw	r1, 0(r1)
	bgei	0, r1, bge_then.16973
	j	bge_cont.16974
bge_then.16973:
	lw	r1, 3(r7)
	lw	r1, 0(r1)
	beqi	0, r1, beq_then.16975
	lw	r1, 5(r7)
	lw	r2, 7(r7)
	lw	r5, 1(r7)
	lw	r6, 4(r7)
	lw	r1, 0(r1)
	flw	f1, 0(r1)
	fsw	f1, 737(r0)
	flw	f1, 1(r1)
	fsw	f1, 738(r0)
	flw	f1, 2(r1)
	fsw	f1, 739(r0)
	lw	r1, 6(r7)
	lw	r1, 0(r1)
	lw	r8, 0(r2)
	lw	r2, 0(r5)
	sw	r6, 5(r3)
	sw	r7, 6(r3)
	add	r5, r0, r2
	add	r2, r0, r8
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	trace_diffuse_ray_80percent.3215				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r6, 5(r3)
	lw	r7, 6(r3)
	addi	r5, r0, 740				# set min_caml_rgb
	lw	r2, 0(r6)
	addi	r1, r0, 737				# set min_caml_diffuse_ray
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r28
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	vecaccumv.2912				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.16976
beq_then.16975:
beq_cont.16976:
	lw	r7, 6(r3)
	addi	r1, r0, 1
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	do_without_neighbors.3228				
	addi	r3, r3, -8
	lw	r31, 7(r3)
bge_cont.16974:
beq_cont.16958:
	lw	r7, 6(r3)
	flw	f1, 740(r0)
	ftoi	r8, f1
	addi	r9, r0, 255
	ble	r8, r9, ble_then.16977
	addi	r9, r0, 255
	j	ble_cont.16978
ble_then.16977:
	bgei	0, r8, bge_then.16979
	addi	r9, r0, 0
	j	bge_cont.16980
bge_then.16979:
	add	r9, r0, r8
bge_cont.16980:
ble_cont.16978:
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	sw	r6, 4(r3)
	add	r1, r0, r9
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_int.2857				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r6, 4(r3)
	addi	r8, r0, 32
	out	r8
	flw	f1, 741(r0)
	ftoi	r8, f1
	addi	r9, r0, 255
	ble	r8, r9, ble_then.16981
	addi	r9, r0, 255
	j	ble_cont.16982
ble_then.16981:
	bgei	0, r8, bge_then.16983
	addi	r9, r0, 0
	j	bge_cont.16984
bge_then.16983:
	add	r9, r0, r8
bge_cont.16984:
ble_cont.16982:
	add	r1, r0, r9
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_int.2857				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r6, 4(r3)
	addi	r8, r0, 32
	out	r8
	flw	f1, 742(r0)
	ftoi	r8, f1
	addi	r9, r0, 255
	ble	r8, r9, ble_then.16985
	addi	r9, r0, 255
	j	ble_cont.16986
ble_then.16985:
	bgei	0, r8, bge_then.16987
	addi	r9, r0, 0
	j	bge_cont.16988
bge_then.16987:
	add	r9, r0, r8
bge_cont.16988:
ble_cont.16986:
	add	r1, r0, r9
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_int.2857				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r6, 4(r3)
	addi	r8, r0, 10
	out	r8
	addi	r9, r1, 1
	lw	r1, 743(r0)
	ble	r1, r9, ble_then.16989
	add	r30, r6, r9
	lw	r1, 0(r30)
	lw	r1, 0(r1)
	flw	f1, 0(r1)
	fsw	f1, 740(r0)
	flw	f1, 1(r1)
	fsw	f1, 741(r0)
	flw	f1, 2(r1)
	fsw	f1, 742(r0)
	lw	r8, 744(r0)
	addi	r1, r2, 1
	ble	r8, r1, ble_then.16990
	blei	0, r2, ble_then.16992
	lw	r2, 743(r0)
	addi	r1, r9, 1
	ble	r2, r1, ble_then.16994
	blei	0, r9, ble_then.16996
	addi	r1, r0, 1
	j	ble_cont.16997
ble_then.16996:
	addi	r1, r0, 0
ble_cont.16997:
	j	ble_cont.16995
ble_then.16994:
	addi	r1, r0, 0
ble_cont.16995:
	j	ble_cont.16993
ble_then.16992:
	addi	r1, r0, 0
ble_cont.16993:
	j	ble_cont.16991
ble_then.16990:
	addi	r1, r0, 0
ble_cont.16991:
	beqi	0, r1, beq_then.16998
	addi	r1, r0, 0
	sw	r9, 7(r3)
	add	r8, r0, r1
	add	r1, r0, r9
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	try_exploit_neighbors.3244				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.16999
beq_then.16998:
	add	r30, r6, r9
	lw	r1, 0(r30)
	addi	r8, r0, 0
	sw	r9, 7(r3)
	add	r2, r0, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	do_without_neighbors.3228				
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.16999:
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r6, 4(r3)
	lw	r9, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	write_rgb.3255				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r6, 4(r3)
	lw	r9, 7(r3)
	addi	r1, r9, 1
	j	scan_pixel.3271
ble_then.16989:
	jr	r31				#
ble_then.16948:
	jr	r31				#
scan_line.3277:
	lw	r8, 744(r0)
	ble	r8, r1, ble_then.17002
	lw	r8, 744(r0)
	addi	r8, r8, -1
	ble	r8, r1, ble_then.17003
	addi	r8, r1, 1
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	sw	r5, 4(r3)
	add	r5, r0, r7
	add	r2, r0, r8
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	pretrace_line.3267				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	ble_cont.17004
ble_then.17003:
ble_cont.17004:
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r7, 3(r3)
	lw	r5, 4(r3)
	addi	r10, r0, 0
	lw	r8, 743(r0)
	blei	0, r8, ble_then.17005
	lw	r8, 0(r5)
	lw	r8, 0(r8)
	flw	f1, 0(r8)
	fsw	f1, 740(r0)
	flw	f1, 1(r8)
	fsw	f1, 741(r0)
	flw	f1, 2(r8)
	fsw	f1, 742(r0)
	lw	r9, 744(r0)
	addi	r8, r1, 1
	ble	r9, r8, ble_then.17007
	blei	0, r1, ble_then.17009
	lw	r1, 743(r0)
	blei	1, r1, ble_then.17011
	addi	r8, r0, 0
	j	ble_cont.17012
ble_then.17011:
	addi	r8, r0, 0
ble_cont.17012:
	j	ble_cont.17010
ble_then.17009:
	addi	r8, r0, 0
ble_cont.17010:
	j	ble_cont.17008
ble_then.17007:
	addi	r8, r0, 0
ble_cont.17008:
	beqi	0, r8, beq_then.17013
	addi	r8, r0, 0
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	sw	r5, 4(r3)
	add	r7, r0, r6
	add	r6, r0, r5
	add	r5, r0, r2
	add	r2, r0, r1
	add	r1, r0, r10
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	try_exploit_neighbors.3244				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.17014
beq_then.17013:
	lw	r8, 0(r5)
	addi	r9, r0, 0
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	sw	r5, 4(r3)
	add	r2, r0, r9
	add	r1, r0, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	do_without_neighbors.3228				
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.17014:
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r7, 3(r3)
	lw	r5, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	write_rgb.3255				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r7, 3(r3)
	lw	r5, 4(r3)
	addi	r8, r0, 1
	add	r7, r0, r6
	add	r6, r0, r5
	add	r5, r0, r2
	add	r2, r0, r1
	add	r1, r0, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	scan_pixel.3271				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	ble_cont.17006
ble_then.17005:
ble_cont.17006:
	addi	r8, r1, 1
	addi	r1, r7, 2
	bgei	5, r1, bge_then.17015
	add	r7, r0, r1
	j	bge_cont.17016
bge_then.17015:
	addi	r7, r1, -5
bge_cont.17016:
	lw	r1, 744(r0)
	ble	r1, r8, ble_then.17017
	lw	r1, 744(r0)
	addi	r1, r1, -1
	ble	r1, r8, ble_then.17019
	addi	r1, r8, 1
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	sw	r5, 4(r3)
	sw	r7, 5(r3)
	sw	r8, 6(r3)
	add	r5, r0, r7
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	pretrace_line.3267				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	ble_cont.17020
ble_then.17019:
ble_cont.17020:
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r5, 4(r3)
	lw	r7, 5(r3)
	lw	r8, 6(r3)
	addi	r1, r0, 0
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	sw	r5, 4(r3)
	sw	r7, 5(r3)
	sw	r8, 6(r3)
	add	r7, r0, r2
	add	r2, r0, r8
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	scan_pixel.3271				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r5, 4(r3)
	lw	r7, 5(r3)
	lw	r8, 6(r3)
	addi	r8, r8, 1
	addi	r1, r7, 2
	bgei	5, r1, bge_then.17021
	add	r7, r0, r1
	j	bge_cont.17022
bge_then.17021:
	addi	r7, r1, -5
bge_cont.17022:
	add	r1, r0, r8
	add	r28, r0, r6
	add	r6, r0, r5
	add	r5, r0, r2
	add	r2, r0, r28
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	scan_line.3277				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	ble_cont.17018
ble_then.17017:
ble_cont.17018:
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r5, 4(r3)
	lw	r7, 5(r3)
	lw	r8, 6(r3)
	jr	r31				#
ble_then.17002:
	jr	r31				#
create_float5x3array.3283:
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_create_float_array				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r2, r0, 5
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
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
	add	r2, r0, r1
	lw	r1, 0(r3)
	sw	r2, 1(r1)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	sw	r2, 2(r1)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	sw	r2, 3(r1)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	sw	r2, 4(r1)
	jr	r31				#
create_pixel.3285:
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_create_float_array				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	add	r5, r0, r1
	sw	r5, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	create_float5x3array.3283				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r8, r0, r1
	lw	r5, 0(r3)
	addi	r2, r0, 5
	addi	r1, r0, 0
	sw	r8, 1(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r5, 0(r3)
	lw	r8, 1(r3)
	addi	r6, r0, 5
	addi	r1, r0, 0
	sw	r2, 2(r3)
	add	r2, r0, r1
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r11, r0, r1
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	lw	r8, 1(r3)
	sw	r11, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	create_float5x3array.3283				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r10, r0, r1
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	lw	r8, 1(r3)
	lw	r11, 3(r3)
	sw	r10, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_float5x3array.3283				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r6, r0, r1
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	lw	r8, 1(r3)
	lw	r10, 4(r3)
	lw	r11, 3(r3)
	addi	r7, r0, 1
	addi	r1, r0, 0
	sw	r6, 5(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r9, r0, r1
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	lw	r6, 5(r3)
	lw	r8, 1(r3)
	lw	r10, 4(r3)
	lw	r11, 3(r3)
	sw	r9, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	create_float5x3array.3283				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r7, r0, r1
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	lw	r6, 5(r3)
	lw	r8, 1(r3)
	lw	r9, 6(r3)
	lw	r10, 4(r3)
	lw	r11, 3(r3)
	add	r1, r0, r4
	addi	r4, r4, 8
	sw	r7, 7(r1)
	sw	r9, 6(r1)
	sw	r6, 5(r1)
	sw	r10, 4(r1)
	sw	r11, 3(r1)
	sw	r2, 2(r1)
	sw	r8, 1(r1)
	sw	r5, 0(r1)
	jr	r31				#
init_line_elements.3287:
	bgei	0, r2, bge_then.17025
	jr	r31				#
bge_then.17025:
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
	add	r7, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	sw	r7, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	create_float5x3array.3283				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r10, r0, r1
	lw	r2, 0(r3)
	lw	r7, 2(r3)
	lw	r1, 1(r3)
	addi	r6, r0, 5
	addi	r5, r0, 0
	sw	r10, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r6, r0, r1
	lw	r2, 0(r3)
	lw	r7, 2(r3)
	lw	r10, 3(r3)
	lw	r1, 1(r3)
	addi	r8, r0, 5
	addi	r5, r0, 0
	sw	r6, 4(r3)
	add	r2, r0, r5
	add	r1, r0, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r13, r0, r1
	lw	r2, 0(r3)
	lw	r6, 4(r3)
	lw	r7, 2(r3)
	lw	r10, 3(r3)
	lw	r1, 1(r3)
	sw	r13, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3283				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r12, r0, r1
	lw	r2, 0(r3)
	lw	r6, 4(r3)
	lw	r7, 2(r3)
	lw	r10, 3(r3)
	lw	r13, 5(r3)
	lw	r1, 1(r3)
	sw	r12, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	create_float5x3array.3283				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r8, r0, r1
	lw	r2, 0(r3)
	lw	r6, 4(r3)
	lw	r7, 2(r3)
	lw	r10, 3(r3)
	lw	r12, 6(r3)
	lw	r13, 5(r3)
	lw	r1, 1(r3)
	addi	r9, r0, 1
	addi	r5, r0, 0
	sw	r8, 7(r3)
	add	r2, r0, r5
	add	r1, r0, r9
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r11, r0, r1
	lw	r2, 0(r3)
	lw	r6, 4(r3)
	lw	r7, 2(r3)
	lw	r8, 7(r3)
	lw	r10, 3(r3)
	lw	r12, 6(r3)
	lw	r13, 5(r3)
	lw	r1, 1(r3)
	sw	r11, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	create_float5x3array.3283				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r9, r0, r1
	lw	r2, 0(r3)
	lw	r6, 4(r3)
	lw	r7, 2(r3)
	lw	r8, 7(r3)
	lw	r10, 3(r3)
	lw	r11, 8(r3)
	lw	r12, 6(r3)
	lw	r13, 5(r3)
	lw	r1, 1(r3)
	add	r5, r0, r4
	addi	r4, r4, 8
	sw	r9, 7(r5)
	sw	r11, 6(r5)
	sw	r8, 5(r5)
	sw	r12, 4(r5)
	sw	r13, 3(r5)
	sw	r6, 2(r5)
	sw	r10, 1(r5)
	sw	r7, 0(r5)
	add	r30, r1, r2
	sw	r5, 0(r30)
	addi	r13, r2, -1
	bgei	0, r13, bge_then.17026
	jr	r31				#
bge_then.17026:
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r13, 9(r3)
	add	r1, r0, r2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r6, r0, r1
	lw	r1, 1(r3)
	lw	r13, 9(r3)
	sw	r6, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_float5x3array.3283				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r9, r0, r1
	lw	r6, 10(r3)
	lw	r1, 1(r3)
	lw	r13, 9(r3)
	addi	r5, r0, 5
	addi	r2, r0, 0
	sw	r9, 11(r3)
	add	r1, r0, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r5, r0, r1
	lw	r6, 10(r3)
	lw	r9, 11(r3)
	lw	r1, 1(r3)
	lw	r13, 9(r3)
	addi	r7, r0, 5
	addi	r2, r0, 0
	sw	r5, 12(r3)
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r12, r0, r1
	lw	r5, 12(r3)
	lw	r6, 10(r3)
	lw	r9, 11(r3)
	lw	r1, 1(r3)
	lw	r13, 9(r3)
	sw	r12, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	create_float5x3array.3283				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r11, r0, r1
	lw	r5, 12(r3)
	lw	r6, 10(r3)
	lw	r9, 11(r3)
	lw	r12, 13(r3)
	lw	r1, 1(r3)
	lw	r13, 9(r3)
	sw	r11, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_float5x3array.3283				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r7, r0, r1
	lw	r5, 12(r3)
	lw	r6, 10(r3)
	lw	r9, 11(r3)
	lw	r11, 14(r3)
	lw	r12, 13(r3)
	lw	r1, 1(r3)
	lw	r13, 9(r3)
	addi	r8, r0, 1
	addi	r2, r0, 0
	sw	r7, 15(r3)
	add	r1, r0, r8
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	add	r10, r0, r1
	lw	r5, 12(r3)
	lw	r6, 10(r3)
	lw	r7, 15(r3)
	lw	r9, 11(r3)
	lw	r11, 14(r3)
	lw	r12, 13(r3)
	lw	r1, 1(r3)
	lw	r13, 9(r3)
	sw	r10, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3283				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	add	r8, r0, r1
	lw	r5, 12(r3)
	lw	r6, 10(r3)
	lw	r7, 15(r3)
	lw	r9, 11(r3)
	lw	r10, 16(r3)
	lw	r11, 14(r3)
	lw	r12, 13(r3)
	lw	r1, 1(r3)
	lw	r13, 9(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r8, 7(r2)
	sw	r10, 6(r2)
	sw	r7, 5(r2)
	sw	r11, 4(r2)
	sw	r12, 3(r2)
	sw	r5, 2(r2)
	sw	r9, 1(r2)
	sw	r6, 0(r2)
	add	r30, r1, r13
	sw	r2, 0(r30)
	addi	r2, r13, -1
	j	init_line_elements.3287
create_pixelline.3290:
	lw	r12, 743(r0)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r12, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r5, r0, r1
	lw	r12, 0(r3)
	sw	r5, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	create_float5x3array.3283				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r8, r0, r1
	lw	r5, 1(r3)
	lw	r12, 0(r3)
	addi	r2, r0, 5
	addi	r1, r0, 0
	sw	r8, 2(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r5, 1(r3)
	lw	r8, 2(r3)
	lw	r12, 0(r3)
	addi	r6, r0, 5
	addi	r1, r0, 0
	sw	r2, 3(r3)
	add	r2, r0, r1
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r11, r0, r1
	lw	r2, 3(r3)
	lw	r5, 1(r3)
	lw	r8, 2(r3)
	lw	r12, 0(r3)
	sw	r11, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_float5x3array.3283				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r10, r0, r1
	lw	r2, 3(r3)
	lw	r5, 1(r3)
	lw	r8, 2(r3)
	lw	r11, 4(r3)
	lw	r12, 0(r3)
	sw	r10, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3283				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r6, r0, r1
	lw	r2, 3(r3)
	lw	r5, 1(r3)
	lw	r8, 2(r3)
	lw	r10, 5(r3)
	lw	r11, 4(r3)
	lw	r12, 0(r3)
	addi	r7, r0, 1
	addi	r1, r0, 0
	sw	r6, 6(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r9, r0, r1
	lw	r2, 3(r3)
	lw	r5, 1(r3)
	lw	r6, 6(r3)
	lw	r8, 2(r3)
	lw	r10, 5(r3)
	lw	r11, 4(r3)
	lw	r12, 0(r3)
	sw	r9, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	create_float5x3array.3283				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r7, r0, r1
	lw	r2, 3(r3)
	lw	r5, 1(r3)
	lw	r6, 6(r3)
	lw	r8, 2(r3)
	lw	r9, 7(r3)
	lw	r10, 5(r3)
	lw	r11, 4(r3)
	lw	r12, 0(r3)
	add	r1, r0, r4
	addi	r4, r4, 8
	sw	r7, 7(r1)
	sw	r9, 6(r1)
	sw	r6, 5(r1)
	sw	r10, 4(r1)
	sw	r11, 3(r1)
	sw	r2, 2(r1)
	sw	r8, 1(r1)
	sw	r5, 0(r1)
	add	r2, r0, r1
	add	r1, r0, r12
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r12, r0, r1
	lw	r1, 743(r0)
	addi	r13, r1, -2
	bgei	0, r13, bge_then.17027
	add	r1, r0, r12
	jr	r31				#
bge_then.17027:
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r12, 8(r3)
	sw	r13, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r5, r0, r1
	lw	r12, 8(r3)
	lw	r13, 9(r3)
	sw	r5, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_float5x3array.3283				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r8, r0, r1
	lw	r5, 10(r3)
	lw	r12, 8(r3)
	lw	r13, 9(r3)
	addi	r2, r0, 5
	addi	r1, r0, 0
	sw	r8, 11(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r2, r0, r1
	lw	r5, 10(r3)
	lw	r8, 11(r3)
	lw	r12, 8(r3)
	lw	r13, 9(r3)
	addi	r6, r0, 5
	addi	r1, r0, 0
	sw	r2, 12(r3)
	add	r2, r0, r1
	add	r1, r0, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r11, r0, r1
	lw	r2, 12(r3)
	lw	r5, 10(r3)
	lw	r8, 11(r3)
	lw	r12, 8(r3)
	lw	r13, 9(r3)
	sw	r11, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	create_float5x3array.3283				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r10, r0, r1
	lw	r2, 12(r3)
	lw	r5, 10(r3)
	lw	r8, 11(r3)
	lw	r11, 13(r3)
	lw	r12, 8(r3)
	lw	r13, 9(r3)
	sw	r10, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_float5x3array.3283				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r6, r0, r1
	lw	r2, 12(r3)
	lw	r5, 10(r3)
	lw	r8, 11(r3)
	lw	r10, 14(r3)
	lw	r11, 13(r3)
	lw	r12, 8(r3)
	lw	r13, 9(r3)
	addi	r7, r0, 1
	addi	r1, r0, 0
	sw	r6, 15(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	add	r9, r0, r1
	lw	r2, 12(r3)
	lw	r5, 10(r3)
	lw	r6, 15(r3)
	lw	r8, 11(r3)
	lw	r10, 14(r3)
	lw	r11, 13(r3)
	lw	r12, 8(r3)
	lw	r13, 9(r3)
	sw	r9, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3283				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	add	r7, r0, r1
	lw	r2, 12(r3)
	lw	r5, 10(r3)
	lw	r6, 15(r3)
	lw	r8, 11(r3)
	lw	r9, 16(r3)
	lw	r10, 14(r3)
	lw	r11, 13(r3)
	lw	r12, 8(r3)
	lw	r13, 9(r3)
	add	r1, r0, r4
	addi	r4, r4, 8
	sw	r7, 7(r1)
	sw	r9, 6(r1)
	sw	r6, 5(r1)
	sw	r10, 4(r1)
	sw	r11, 3(r1)
	sw	r2, 2(r1)
	sw	r8, 1(r1)
	sw	r5, 0(r1)
	add	r30, r12, r13
	sw	r1, 0(r30)
	addi	r1, r13, -1
	add	r2, r0, r1
	add	r1, r0, r12
	j	init_line_elements.3287
tan.3292:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	sin.2837				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	fadd	f2, f0, f1
	flw	f1, 0(r3)
	fsw	f2, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	cos.2839				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	finv	f31, f1
	fmul	f1, f2, f31
	jr	r31				#
adjust_position.3294:
	fmul	f3, f1, f1
	flup	f1, 45		# fli	f1, 0.100000
	fadd	f1, f3, f1
	fsqrt	f4, f1
	flup	f1, 2		# fli	f1, 1.000000
	finv	f31, f4
	fmul	f1, f1, f31
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17028
	flup	f5, 2		# fli	f5, 1.000000
	j	fle_cont.17029
fle_else.17028:
	flup	f5, 11		# fli	f5, -1.000000
fle_cont.17029:
	fmul	f1, f1, f5
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.17030
	flup	f2, 24		# fli	f2, 2.437500
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17032
	flup	f3, 15		# fli	f3, 1.570796
	flup	f2, 2		# fli	f2, 1.000000
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f5, 0(r3)
	fsw	f3, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan_body.2841				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f5, 0(r3)
	flw	f3, 2(r3)
	fadd	f1, f3, f1
	fmul	f3, f1, f5
	j	fle_cont.17033
fle_else.17032:
	flup	f4, 16		# fli	f4, 0.785398
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f3, f1, f2
	flup	f2, 2		# fli	f2, 1.000000
	fadd	f1, f1, f2
	finv	f31, f1
	fmul	f1, f3, f31
	fsw	f5, 0(r3)
	fsw	f4, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	atan_body.2841				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f5, 0(r3)
	flw	f4, 4(r3)
	fadd	f1, f4, f1
	fmul	f3, f1, f5
fle_cont.17033:
	j	fle_cont.17031
fle_else.17030:
	fsw	f3, 6(r3)
	fsw	f2, 8(r3)
	fsw	f4, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	atan_body.2841				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	fadd	f3, f0, f1
fle_cont.17031:
	flw	f2, 8(r3)
	flw	f4, 10(r3)
	fmul	f1, f3, f2
	fsw	f4, 10(r3)
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin.2837				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	fadd	f2, f0, f1
	flw	f4, 10(r3)
	flw	f1, 12(r3)
	fsw	f2, 14(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	cos.2839				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f4, 10(r3)
	flw	f2, 14(r3)
	finv	f31, f1
	fmul	f1, f2, f31
	fmul	f1, f1, f4
	jr	r31				#
calc_dirvec.3297:
	bgei	5, r1, bge_then.17034
	fmul	f2, f2, f2
	flup	f1, 45		# fli	f1, 0.100000
	fadd	f1, f2, f1
	fsqrt	f5, f1
	flup	f1, 2		# fli	f1, 1.000000
	finv	f31, f5
	fmul	f1, f1, f31
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17035
	flup	f6, 2		# fli	f6, 1.000000
	j	fle_cont.17036
fle_else.17035:
	flup	f6, 11		# fli	f6, -1.000000
fle_cont.17036:
	fmul	f1, f1, f6
	flup	f2, 23		# fli	f2, 4.375000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17037
	flup	f2, 24		# fli	f2, 2.437500
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17039
	flup	f3, 15		# fli	f3, 1.570796
	flup	f2, 2		# fli	f2, 1.000000
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f6, 0(r3)
	fsw	f3, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan_body.2841				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f6, 0(r3)
	flw	f3, 2(r3)
	fadd	f1, f3, f1
	fmul	f2, f1, f6
	j	fle_cont.17040
fle_else.17039:
	flup	f4, 16		# fli	f4, 0.785398
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f3, f1, f2
	flup	f2, 2		# fli	f2, 1.000000
	fadd	f1, f1, f2
	finv	f31, f1
	fmul	f1, f3, f31
	fsw	f6, 0(r3)
	fsw	f4, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	atan_body.2841				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f6, 0(r3)
	flw	f4, 4(r3)
	fadd	f1, f4, f1
	fmul	f2, f1, f6
fle_cont.17040:
	j	fle_cont.17038
fle_else.17037:
	fsw	f2, 6(r3)
	fsw	f4, 8(r3)
	fsw	f3, 10(r3)
	fsw	f5, 12(r3)
	sw	r5, 14(r3)
	sw	r1, 15(r3)
	sw	r2, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	atan_body.2841				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	fadd	f2, f0, f1
fle_cont.17038:
	flw	f4, 8(r3)
	flw	f3, 10(r3)
	flw	f5, 12(r3)
	lw	r5, 14(r3)
	lw	r1, 15(r3)
	lw	r2, 16(r3)
	fmul	f1, f2, f3
	fsw	f4, 8(r3)
	fsw	f3, 10(r3)
	fsw	f5, 12(r3)
	fsw	f1, 18(r3)
	sw	r5, 14(r3)
	sw	r1, 15(r3)
	sw	r2, 16(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	sin.2837				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	fadd	f2, f0, f1
	flw	f4, 8(r3)
	flw	f3, 10(r3)
	flw	f5, 12(r3)
	flw	f1, 18(r3)
	lw	r5, 14(r3)
	lw	r1, 15(r3)
	lw	r2, 16(r3)
	fsw	f2, 20(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	cos.2839				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f4, 8(r3)
	flw	f3, 10(r3)
	flw	f5, 12(r3)
	flw	f2, 20(r3)
	lw	r5, 14(r3)
	lw	r1, 15(r3)
	lw	r2, 16(r3)
	finv	f31, f1
	fmul	f1, f2, f31
	fmul	f1, f1, f5
	addi	r1, r1, 1
	fmul	f5, f1, f1
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f2, f5, f2
	fsqrt	f6, f2
	flup	f2, 2		# fli	f2, 1.000000
	finv	f31, f6
	fmul	f2, f2, f31
	fle	r30, f0, f2
	beq	r0, r30, fle_else.17042
	flup	f7, 2		# fli	f7, 1.000000
	j	fle_cont.17043
fle_else.17042:
	flup	f7, 11		# fli	f7, -1.000000
fle_cont.17043:
	fmul	f2, f2, f7
	flup	f5, 23		# fli	f5, 4.375000
	fle	r30, f5, f2
	beq	r0, r30, fle_else.17044
	flup	f1, 24		# fli	f1, 2.437500
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17046
	flup	f3, 15		# fli	f3, 1.570796
	flup	f1, 2		# fli	f1, 1.000000
	finv	f31, f2
	fmul	f1, f1, f31
	fsw	f7, 22(r3)
	fsw	f3, 24(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	atan_body.2841				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f7, 22(r3)
	flw	f3, 24(r3)
	fadd	f1, f3, f1
	fmul	f5, f1, f7
	j	fle_cont.17047
fle_else.17046:
	flup	f4, 16		# fli	f4, 0.785398
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f3, f2, f1
	flup	f1, 2		# fli	f1, 1.000000
	fadd	f1, f2, f1
	finv	f31, f1
	fmul	f1, f3, f31
	fsw	f7, 22(r3)
	fsw	f4, 26(r3)
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	atan_body.2841				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	flw	f7, 22(r3)
	flw	f4, 26(r3)
	fadd	f1, f4, f1
	fmul	f5, f1, f7
fle_cont.17047:
	j	fle_cont.17045
fle_else.17044:
	fsw	f1, 28(r3)
	fsw	f5, 30(r3)
	fsw	f6, 32(r3)
	sw	r1, 34(r3)
	fadd	f1, f0, f2
	sw	r31, 35(r3)
	addi	r3, r3, 36
	jal	atan_body.2841				
	addi	r3, r3, -36
	lw	r31, 35(r3)
	fadd	f5, f0, f1
fle_cont.17045:
	flw	f1, 28(r3)
	flw	f4, 8(r3)
	flw	f3, 10(r3)
	flw	f6, 32(r3)
	lw	r5, 14(r3)
	lw	r2, 16(r3)
	lw	r1, 34(r3)
	fmul	f2, f5, f4
	fsw	f1, 28(r3)
	fsw	f6, 32(r3)
	fsw	f2, 36(r3)
	sw	r1, 34(r3)
	fadd	f1, f0, f2
	sw	r31, 38(r3)
	addi	r3, r3, 39
	jal	sin.2837				
	addi	r3, r3, -39
	lw	r31, 38(r3)
	fadd	f5, f0, f1
	flw	f1, 28(r3)
	flw	f4, 8(r3)
	flw	f3, 10(r3)
	flw	f6, 32(r3)
	flw	f2, 36(r3)
	lw	r5, 14(r3)
	lw	r2, 16(r3)
	lw	r1, 34(r3)
	fsw	f5, 38(r3)
	fadd	f1, f0, f2
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	cos.2839				
	addi	r3, r3, -41
	lw	r31, 40(r3)
	fadd	f2, f0, f1
	flw	f1, 28(r3)
	flw	f4, 8(r3)
	flw	f3, 10(r3)
	flw	f6, 32(r3)
	flw	f5, 38(r3)
	lw	r5, 14(r3)
	lw	r2, 16(r3)
	lw	r1, 34(r3)
	finv	f31, f2
	fmul	f2, f5, f31
	fmul	f2, f2, f6
	j	calc_dirvec.3297
bge_then.17034:
	fmul	f4, f1, f1
	fmul	f3, f2, f2
	fadd	f4, f4, f3
	flup	f3, 2		# fli	f3, 1.000000
	fadd	f3, f4, f3
	fsqrt	f4, f3
	finv	f31, f4
	fmul	f3, f1, f31
	finv	f31, f4
	fmul	f2, f2, f31
	flup	f1, 2		# fli	f1, 1.000000
	finv	f31, f4
	fmul	f1, f1, f31
	addi	r1, r0, 766				# set min_caml_dirvecs
	add	r30, r1, r2
	lw	r2, 0(r30)
	add	r30, r2, r5
	lw	r1, 0(r30)
	lw	r1, 0(r1)
	fsw	f3, 0(r1)
	fsw	f2, 1(r1)
	fsw	f1, 2(r1)
	addi	r1, r5, 40
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 0(r1)
	fneg	f5, f2
	fsw	f3, 0(r1)
	fsw	f1, 1(r1)
	fsw	f5, 2(r1)
	addi	r1, r5, 80
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 0(r1)
	fneg	f4, f3
	fsw	f1, 0(r1)
	fsw	f4, 1(r1)
	fsw	f5, 2(r1)
	addi	r1, r5, 1
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 0(r1)
	fneg	f1, f1
	fsw	f4, 0(r1)
	fsw	f5, 1(r1)
	fsw	f1, 2(r1)
	addi	r1, r5, 41
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 0(r1)
	fsw	f4, 0(r1)
	fsw	f1, 1(r1)
	fsw	f2, 2(r1)
	addi	r1, r5, 81
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 0(r1)
	fsw	f1, 0(r1)
	fsw	f3, 1(r1)
	fsw	f2, 2(r1)
	jr	r31				#
calc_dirvecs.3305:
	bgei	0, r1, bge_then.17050
	jr	r31				#
bge_then.17050:
	itof	f3, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f3, f3, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f2, f3, f2
	addi	r6, r0, 0
	flup	f4, 0		# fli	f4, 0.000000
	flup	f3, 0		# fli	f3, 0.000000
	fsw	f1, 0(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	add	r1, r0, r6
	fadd	f30, f0, f4
	fadd	f4, f0, f1
	fadd	f1, f0, f30
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f30
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_dirvec.3297				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	flw	f1, 0(r3)
	lw	r5, 2(r3)
	lw	r2, 3(r3)
	lw	r1, 4(r3)
	itof	f3, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f3, f3, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f2, f3, f2
	addi	r7, r0, 0
	flup	f4, 0		# fli	f4, 0.000000
	flup	f3, 0		# fli	f3, 0.000000
	addi	r6, r5, 2
	add	r5, r0, r6
	add	r1, r0, r7
	fadd	f30, f0, f4
	fadd	f4, f0, f1
	fadd	f1, f0, f30
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f30
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_dirvec.3297				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	flw	f1, 0(r3)
	lw	r5, 2(r3)
	lw	r2, 3(r3)
	lw	r1, 4(r3)
	addi	r6, r1, -1
	addi	r1, r2, 1
	bgei	5, r1, bge_then.17052
	add	r2, r0, r1
	j	bge_cont.17053
bge_then.17052:
	addi	r2, r1, -5
bge_cont.17053:
	add	r1, r0, r6
	j	calc_dirvecs.3305
calc_dirvec_rows.3310:
	bgei	0, r1, bge_then.17054
	jr	r31				#
bge_then.17054:
	itof	f2, r1
	flup	f1, 18		# fli	f1, 0.200000
	fmul	f2, f2, f1
	flup	f1, 48		# fli	f1, 0.900000
	fsub	f1, f2, f1
	addi	r6, r0, 4
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	calc_dirvecs.3305				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 0(r3)
	lw	r5, 1(r3)
	lw	r2, 2(r3)
	addi	r7, r1, -1
	addi	r1, r2, 2
	bgei	5, r1, bge_then.17056
	add	r6, r0, r1
	j	bge_cont.17057
bge_then.17056:
	addi	r6, r1, -5
bge_cont.17057:
	addi	r2, r5, 4
	bgei	0, r7, bge_then.17058
	jr	r31				#
bge_then.17058:
	itof	f2, r7
	flup	f1, 18		# fli	f1, 0.200000
	fmul	f2, f2, f1
	flup	f1, 48		# fli	f1, 0.900000
	fsub	f1, f2, f1
	addi	r1, r0, 4
	sw	r2, 3(r3)
	sw	r6, 4(r3)
	sw	r7, 5(r3)
	add	r5, r0, r2
	add	r2, r0, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_dirvecs.3305				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 3(r3)
	lw	r6, 4(r3)
	lw	r7, 5(r3)
	addi	r7, r7, -1
	addi	r1, r6, 2
	bgei	5, r1, bge_then.17060
	add	r5, r0, r1
	j	bge_cont.17061
bge_then.17060:
	addi	r5, r1, -5
bge_cont.17061:
	addi	r1, r2, 4
	add	r2, r0, r5
	add	r5, r0, r1
	add	r1, r0, r7
	j	calc_dirvec_rows.3310
create_dirvec.3314:
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_create_float_array				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	lw	r2, 0(r0)
	sw	r1, 0(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r5, r0, r1
	lw	r1, 0(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r2)
	sw	r1, 0(r2)
	add	r1, r0, r2
	jr	r31				#
create_dirvec_elements.3316:
	bgei	0, r2, bge_then.17062
	jr	r31				#
bge_then.17062:
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
	add	r5, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r6, 0(r0)
	sw	r5, 2(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r7, r0, r1
	lw	r5, 2(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	add	r6, r0, r4
	addi	r4, r4, 2
	sw	r7, 1(r6)
	sw	r5, 0(r6)
	add	r5, r0, r6
	add	r30, r1, r2
	sw	r5, 0(r30)
	addi	r7, r2, -1
	bgei	0, r7, bge_then.17064
	jr	r31				#
bge_then.17064:
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r7, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_float_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	lw	r7, 3(r3)
	lw	r5, 0(r0)
	sw	r2, 4(r3)
	add	r1, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r6, r0, r1
	lw	r2, 4(r3)
	lw	r1, 1(r3)
	lw	r7, 3(r3)
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r6, 1(r5)
	sw	r2, 0(r5)
	add	r2, r0, r5
	add	r30, r1, r7
	sw	r2, 0(r30)
	addi	r7, r7, -1
	bgei	0, r7, bge_then.17066
	jr	r31				#
bge_then.17066:
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r7, 5(r3)
	add	r1, r0, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	lw	r7, 5(r3)
	lw	r5, 0(r0)
	sw	r2, 6(r3)
	add	r1, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r6, r0, r1
	lw	r2, 6(r3)
	lw	r1, 1(r3)
	lw	r7, 5(r3)
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r6, 1(r5)
	sw	r2, 0(r5)
	add	r2, r0, r5
	add	r30, r1, r7
	sw	r2, 0(r30)
	addi	r7, r7, -1
	bgei	0, r7, bge_then.17068
	jr	r31				#
bge_then.17068:
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r7, 7(r3)
	add	r1, r0, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_float_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	lw	r7, 7(r3)
	lw	r5, 0(r0)
	sw	r2, 8(r3)
	add	r1, r0, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r6, r0, r1
	lw	r2, 8(r3)
	lw	r1, 1(r3)
	lw	r7, 7(r3)
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r6, 1(r5)
	sw	r2, 0(r5)
	add	r2, r0, r5
	add	r30, r1, r7
	sw	r2, 0(r30)
	addi	r2, r7, -1
	j	create_dirvec_elements.3316
create_dirvecs.3319:
	bgei	0, r1, bge_then.17070
	jr	r31				#
bge_then.17070:
	addi	r8, r0, 766				# set min_caml_dirvecs
	addi	r7, r0, 120
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	sw	r7, 1(r3)
	sw	r8, 2(r3)
	add	r1, r0, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r7, 1(r3)
	lw	r8, 2(r3)
	lw	r5, 0(r0)
	sw	r2, 3(r3)
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r6, r0, r1
	lw	r2, 3(r3)
	lw	r1, 0(r3)
	lw	r7, 1(r3)
	lw	r8, 2(r3)
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r6, 1(r5)
	sw	r2, 0(r5)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r8, 2(r3)
	add	r30, r8, r1
	sw	r2, 0(r30)
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r7, 0(r30)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r7, 4(r3)
	add	r1, r0, r2
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_float_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r7, 4(r3)
	lw	r5, 0(r0)
	sw	r2, 5(r3)
	add	r1, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r6, r0, r1
	lw	r2, 5(r3)
	lw	r1, 0(r3)
	lw	r7, 4(r3)
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r6, 1(r5)
	sw	r2, 0(r5)
	add	r2, r0, r5
	sw	r2, 118(r7)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_float_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r7, 4(r3)
	lw	r5, 0(r0)
	sw	r2, 6(r3)
	add	r1, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r6, r0, r1
	lw	r2, 6(r3)
	lw	r1, 0(r3)
	lw	r7, 4(r3)
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r6, 1(r5)
	sw	r2, 0(r5)
	add	r2, r0, r5
	sw	r2, 117(r7)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	add	r1, r0, r2
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r7, 4(r3)
	lw	r5, 0(r0)
	sw	r2, 7(r3)
	add	r1, r0, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r6, r0, r1
	lw	r2, 7(r3)
	lw	r1, 0(r3)
	lw	r7, 4(r3)
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r6, 1(r5)
	sw	r2, 0(r5)
	add	r2, r0, r5
	sw	r2, 116(r7)
	addi	r2, r0, 115
	add	r1, r0, r7
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	create_dirvec_elements.3316				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 0(r3)
	addi	r6, r1, -1
	bgei	0, r6, bge_then.17072
	jr	r31				#
bge_then.17072:
	addi	r8, r0, 766				# set min_caml_dirvecs
	addi	r7, r0, 120
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r6, 8(r3)
	sw	r7, 9(r3)
	sw	r8, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_float_array				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r6, 8(r3)
	lw	r7, 9(r3)
	lw	r8, 10(r3)
	lw	r2, 0(r0)
	sw	r1, 11(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r5, r0, r1
	lw	r1, 11(r3)
	lw	r6, 8(r3)
	lw	r7, 9(r3)
	lw	r8, 10(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r2)
	sw	r1, 0(r2)
	add	r1, r0, r2
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r6, 8(r3)
	lw	r8, 10(r3)
	add	r30, r8, r6
	sw	r1, 0(r30)
	addi	r1, r0, 766				# set min_caml_dirvecs
	add	r30, r1, r6
	lw	r7, 0(r30)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r7, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r6, 8(r3)
	lw	r7, 12(r3)
	lw	r2, 0(r0)
	sw	r1, 13(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_array				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r5, r0, r1
	lw	r1, 13(r3)
	lw	r6, 8(r3)
	lw	r7, 12(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r2)
	sw	r1, 0(r2)
	add	r1, r0, r2
	sw	r1, 118(r7)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_float_array				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r6, 8(r3)
	lw	r7, 12(r3)
	lw	r2, 0(r0)
	sw	r1, 14(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_array				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r5, r0, r1
	lw	r1, 14(r3)
	lw	r6, 8(r3)
	lw	r7, 12(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r2)
	sw	r1, 0(r2)
	add	r1, r0, r2
	sw	r1, 117(r7)
	addi	r1, r0, 116
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_dirvec_elements.3316				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r6, 8(r3)
	addi	r1, r6, -1
	j	create_dirvecs.3319
init_dirvec_constants.3321:
	bgei	0, r2, bge_then.17074
	jr	r31				#
bge_then.17074:
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
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	addi	r9, r2, -1
	bgei	0, r9, bge_then.17076
	jr	r31				#
bge_then.17076:
	add	r30, r1, r9
	lw	r8, 0(r30)
	lw	r2, 0(r0)
	addi	r10, r2, -1
	bgei	0, r10, bge_then.17078
	j	bge_cont.17079
bge_then.17078:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r10
	lw	r7, 0(r30)
	lw	r6, 1(r8)
	lw	r2, 0(r8)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17080
	beqi	2, r5, beq_then.17082
	sw	r6, 2(r3)
	sw	r10, 3(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	setup_second_table.3100				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r6, 2(r3)
	lw	r10, 3(r3)
	add	r30, r6, r10
	sw	r1, 0(r30)
	j	beq_cont.17083
beq_then.17082:
	sw	r6, 2(r3)
	sw	r10, 3(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	setup_surface_table.3097				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r6, 2(r3)
	lw	r10, 3(r3)
	add	r30, r6, r10
	sw	r1, 0(r30)
beq_cont.17083:
	j	beq_cont.17081
beq_then.17080:
	sw	r6, 2(r3)
	sw	r8, 4(r3)
	sw	r9, 5(r3)
	sw	r10, 3(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_rect_table.3094				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r6, 2(r3)
	lw	r8, 4(r3)
	lw	r9, 5(r3)
	lw	r10, 3(r3)
	add	r30, r6, r10
	sw	r2, 0(r30)
beq_cont.17081:
	addi	r2, r10, -1
	sw	r9, 5(r3)
	add	r1, r0, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -7
	lw	r31, 6(r3)
bge_cont.17079:
	addi	r5, r9, -1
	bgei	0, r5, bge_then.17084
	jr	r31				#
bge_then.17084:
	add	r30, r1, r5
	lw	r2, 0(r30)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r5, 6(r3)
	add	r1, r0, r2
	add	r2, r0, r6
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 0(r3)
	lw	r5, 6(r3)
	addi	r9, r5, -1
	bgei	0, r9, bge_then.17086
	jr	r31				#
bge_then.17086:
	add	r30, r1, r9
	lw	r8, 0(r30)
	lw	r2, 0(r0)
	addi	r10, r2, -1
	bgei	0, r10, bge_then.17088
	j	bge_cont.17089
bge_then.17088:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r10
	lw	r7, 0(r30)
	lw	r6, 1(r8)
	lw	r2, 0(r8)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17090
	beqi	2, r5, beq_then.17092
	sw	r6, 7(r3)
	sw	r10, 8(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_second_table.3100				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r6, 7(r3)
	lw	r10, 8(r3)
	add	r30, r6, r10
	sw	r1, 0(r30)
	j	beq_cont.17093
beq_then.17092:
	sw	r6, 7(r3)
	sw	r10, 8(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_surface_table.3097				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r6, 7(r3)
	lw	r10, 8(r3)
	add	r30, r6, r10
	sw	r1, 0(r30)
beq_cont.17093:
	j	beq_cont.17091
beq_then.17090:
	sw	r6, 7(r3)
	sw	r8, 9(r3)
	sw	r9, 10(r3)
	sw	r10, 8(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_rect_table.3094				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r6, 7(r3)
	lw	r8, 9(r3)
	lw	r9, 10(r3)
	lw	r10, 8(r3)
	add	r30, r6, r10
	sw	r2, 0(r30)
beq_cont.17091:
	addi	r2, r10, -1
	sw	r9, 10(r3)
	add	r1, r0, r8
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -12
	lw	r31, 11(r3)
bge_cont.17089:
	addi	r2, r9, -1
	j	init_dirvec_constants.3321
init_vecset_constants.3324:
	bgei	0, r1, bge_then.17094
	jr	r31				#
bge_then.17094:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r10, 0(r30)
	lw	r8, 119(r10)
	lw	r2, 0(r0)
	addi	r9, r2, -1
	bgei	0, r9, bge_then.17096
	j	bge_cont.17097
bge_then.17096:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r9
	lw	r7, 0(r30)
	lw	r6, 1(r8)
	lw	r2, 0(r8)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17098
	beqi	2, r5, beq_then.17100
	sw	r6, 0(r3)
	sw	r9, 1(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	setup_second_table.3100				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r6, 0(r3)
	lw	r9, 1(r3)
	add	r30, r6, r9
	sw	r1, 0(r30)
	j	beq_cont.17101
beq_then.17100:
	sw	r6, 0(r3)
	sw	r9, 1(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	setup_surface_table.3097				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r6, 0(r3)
	lw	r9, 1(r3)
	add	r30, r6, r9
	sw	r1, 0(r30)
beq_cont.17101:
	j	beq_cont.17099
beq_then.17098:
	sw	r6, 0(r3)
	sw	r1, 2(r3)
	sw	r8, 3(r3)
	sw	r9, 1(r3)
	sw	r10, 4(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3094				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
	lw	r6, 0(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	lw	r9, 1(r3)
	lw	r10, 4(r3)
	add	r30, r6, r9
	sw	r2, 0(r30)
beq_cont.17099:
	addi	r2, r9, -1
	sw	r1, 2(r3)
	sw	r10, 4(r3)
	add	r1, r0, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -6
	lw	r31, 5(r3)
bge_cont.17097:
	lw	r2, 118(r10)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	sw	r1, 2(r3)
	sw	r10, 4(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 2(r3)
	lw	r10, 4(r3)
	lw	r8, 117(r10)
	lw	r2, 0(r0)
	addi	r9, r2, -1
	bgei	0, r9, bge_then.17102
	j	bge_cont.17103
bge_then.17102:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r9
	lw	r7, 0(r30)
	lw	r6, 1(r8)
	lw	r2, 0(r8)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17104
	beqi	2, r5, beq_then.17106
	sw	r6, 5(r3)
	sw	r9, 6(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_second_table.3100				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r6, 5(r3)
	lw	r9, 6(r3)
	add	r30, r6, r9
	sw	r1, 0(r30)
	j	beq_cont.17107
beq_then.17106:
	sw	r6, 5(r3)
	sw	r9, 6(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_surface_table.3097				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r6, 5(r3)
	lw	r9, 6(r3)
	add	r30, r6, r9
	sw	r1, 0(r30)
beq_cont.17107:
	j	beq_cont.17105
beq_then.17104:
	sw	r6, 5(r3)
	sw	r8, 7(r3)
	sw	r9, 6(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_rect_table.3094				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1
	lw	r6, 5(r3)
	lw	r1, 2(r3)
	lw	r8, 7(r3)
	lw	r9, 6(r3)
	lw	r10, 4(r3)
	add	r30, r6, r9
	sw	r2, 0(r30)
beq_cont.17105:
	addi	r2, r9, -1
	add	r1, r0, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -9
	lw	r31, 8(r3)
bge_cont.17103:
	addi	r2, r0, 116
	add	r1, r0, r10
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 2(r3)
	addi	r8, r1, -1
	bgei	0, r8, bge_then.17108
	jr	r31				#
bge_then.17108:
	addi	r1, r0, 766				# set min_caml_dirvecs
	add	r30, r1, r8
	lw	r10, 0(r30)
	lw	r1, 119(r10)
	lw	r2, 0(r0)
	addi	r2, r2, -1
	sw	r8, 8(r3)
	sw	r10, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r8, 8(r3)
	lw	r10, 9(r3)
	lw	r7, 118(r10)
	lw	r1, 0(r0)
	addi	r9, r1, -1
	bgei	0, r9, bge_then.17110
	j	bge_cont.17111
bge_then.17110:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r9
	lw	r6, 0(r30)
	lw	r5, 1(r7)
	lw	r1, 0(r7)
	lw	r2, 1(r6)
	beqi	1, r2, beq_then.17112
	beqi	2, r2, beq_then.17114
	sw	r5, 10(r3)
	sw	r9, 11(r3)
	add	r2, r0, r6
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	setup_second_table.3100				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r5, 10(r3)
	lw	r9, 11(r3)
	add	r30, r5, r9
	sw	r1, 0(r30)
	j	beq_cont.17115
beq_then.17114:
	sw	r5, 10(r3)
	sw	r9, 11(r3)
	add	r2, r0, r6
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	setup_surface_table.3097				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r5, 10(r3)
	lw	r9, 11(r3)
	add	r30, r5, r9
	sw	r1, 0(r30)
beq_cont.17115:
	j	beq_cont.17113
beq_then.17112:
	sw	r5, 10(r3)
	sw	r7, 12(r3)
	sw	r9, 11(r3)
	add	r2, r0, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_rect_table.3094				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r5, 10(r3)
	lw	r7, 12(r3)
	lw	r8, 8(r3)
	lw	r9, 11(r3)
	lw	r10, 9(r3)
	add	r30, r5, r9
	sw	r1, 0(r30)
beq_cont.17113:
	addi	r1, r9, -1
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -14
	lw	r31, 13(r3)
bge_cont.17111:
	addi	r1, r0, 117
	add	r2, r0, r1
	add	r1, r0, r10
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r8, 8(r3)
	addi	r8, r8, -1
	bgei	0, r8, bge_then.17116
	jr	r31				#
bge_then.17116:
	addi	r1, r0, 766				# set min_caml_dirvecs
	add	r30, r1, r8
	lw	r10, 0(r30)
	lw	r7, 119(r10)
	lw	r1, 0(r0)
	addi	r9, r1, -1
	bgei	0, r9, bge_then.17118
	j	bge_cont.17119
bge_then.17118:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r9
	lw	r6, 0(r30)
	lw	r5, 1(r7)
	lw	r1, 0(r7)
	lw	r2, 1(r6)
	beqi	1, r2, beq_then.17120
	beqi	2, r2, beq_then.17122
	sw	r5, 13(r3)
	sw	r9, 14(r3)
	add	r2, r0, r6
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	setup_second_table.3100				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r5, 13(r3)
	lw	r9, 14(r3)
	add	r30, r5, r9
	sw	r1, 0(r30)
	j	beq_cont.17123
beq_then.17122:
	sw	r5, 13(r3)
	sw	r9, 14(r3)
	add	r2, r0, r6
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	setup_surface_table.3097				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r5, 13(r3)
	lw	r9, 14(r3)
	add	r30, r5, r9
	sw	r1, 0(r30)
beq_cont.17123:
	j	beq_cont.17121
beq_then.17120:
	sw	r5, 13(r3)
	sw	r7, 15(r3)
	sw	r8, 16(r3)
	sw	r9, 14(r3)
	sw	r10, 17(r3)
	add	r2, r0, r6
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_rect_table.3094				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r5, 13(r3)
	lw	r7, 15(r3)
	lw	r8, 16(r3)
	lw	r9, 14(r3)
	lw	r10, 17(r3)
	add	r30, r5, r9
	sw	r1, 0(r30)
beq_cont.17121:
	addi	r1, r9, -1
	sw	r8, 16(r3)
	sw	r10, 17(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -19
	lw	r31, 18(r3)
bge_cont.17119:
	addi	r1, r0, 118
	sw	r8, 16(r3)
	add	r2, r0, r1
	add	r1, r0, r10
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r8, 16(r3)
	addi	r1, r8, -1
	bgei	0, r1, bge_then.17124
	jr	r31				#
bge_then.17124:
	lw	r5, 884(r0)
	addi	r2, r0, 119
	sw	r1, 18(r3)
	add	r1, r0, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r1, 18(r3)
	addi	r1, r1, -1
	j	init_vecset_constants.3324
init_dirvecs.3326:
	addi	r6, r0, 120
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r6, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r6, 0(r3)
	lw	r2, 0(r0)
	sw	r1, 1(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r5, r0, r1
	lw	r1, 1(r3)
	lw	r6, 0(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r2)
	sw	r1, 0(r2)
	add	r1, r0, r2
	add	r2, r0, r1
	add	r1, r0, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r1, 770(r0)
	lw	r6, 770(r0)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r6, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r6, 2(r3)
	lw	r2, 0(r0)
	sw	r1, 3(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r5, r0, r1
	lw	r1, 3(r3)
	lw	r6, 2(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r2)
	sw	r1, 0(r2)
	add	r1, r0, r2
	sw	r1, 118(r6)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_float_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r6, 2(r3)
	lw	r2, 0(r0)
	sw	r1, 4(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r5, r0, r1
	lw	r1, 4(r3)
	lw	r6, 2(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r2)
	sw	r1, 0(r2)
	add	r1, r0, r2
	sw	r1, 117(r6)
	addi	r1, r0, 116
	add	r2, r0, r1
	add	r1, r0, r6
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
	addi	r5, r0, 0
	addi	r2, r0, 0
	itof	f2, r1
	flup	f1, 18		# fli	f1, 0.200000
	fmul	f2, f2, f1
	flup	f1, 48		# fli	f1, 0.900000
	fsub	f1, f2, f1
	addi	r1, r0, 4
	add	r28, r0, r5
	add	r5, r0, r2
	add	r2, r0, r28
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_dirvecs.3305				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r5, r0, 8
	addi	r2, r0, 2
	addi	r1, r0, 4
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r28
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_dirvec_rows.3310				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r9, 770(r0)
	lw	r1, 119(r9)
	lw	r2, 0(r0)
	addi	r2, r2, -1
	sw	r9, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r9, 5(r3)
	lw	r7, 118(r9)
	lw	r1, 0(r0)
	addi	r8, r1, -1
	bgei	0, r8, bge_then.17126
	j	bge_cont.17127
bge_then.17126:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r8
	lw	r6, 0(r30)
	lw	r5, 1(r7)
	lw	r1, 0(r7)
	lw	r2, 1(r6)
	beqi	1, r2, beq_then.17128
	beqi	2, r2, beq_then.17130
	sw	r5, 6(r3)
	sw	r8, 7(r3)
	add	r2, r0, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_second_table.3100				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r5, 6(r3)
	lw	r8, 7(r3)
	add	r30, r5, r8
	sw	r1, 0(r30)
	j	beq_cont.17131
beq_then.17130:
	sw	r5, 6(r3)
	sw	r8, 7(r3)
	add	r2, r0, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_surface_table.3097				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r5, 6(r3)
	lw	r8, 7(r3)
	add	r30, r5, r8
	sw	r1, 0(r30)
beq_cont.17131:
	j	beq_cont.17129
beq_then.17128:
	sw	r5, 6(r3)
	sw	r7, 8(r3)
	sw	r8, 7(r3)
	add	r2, r0, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_rect_table.3094				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r5, 6(r3)
	lw	r7, 8(r3)
	lw	r8, 7(r3)
	lw	r9, 5(r3)
	add	r30, r5, r8
	sw	r1, 0(r30)
beq_cont.17129:
	addi	r1, r8, -1
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -10
	lw	r31, 9(r3)
bge_cont.17127:
	addi	r1, r0, 117
	add	r2, r0, r1
	add	r1, r0, r9
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r9, 769(r0)
	lw	r7, 119(r9)
	lw	r1, 0(r0)
	addi	r8, r1, -1
	bgei	0, r8, bge_then.17132
	j	bge_cont.17133
bge_then.17132:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r8
	lw	r6, 0(r30)
	lw	r5, 1(r7)
	lw	r1, 0(r7)
	lw	r2, 1(r6)
	beqi	1, r2, beq_then.17134
	beqi	2, r2, beq_then.17136
	sw	r5, 9(r3)
	sw	r8, 10(r3)
	add	r2, r0, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_second_table.3100				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r5, 9(r3)
	lw	r8, 10(r3)
	add	r30, r5, r8
	sw	r1, 0(r30)
	j	beq_cont.17137
beq_then.17136:
	sw	r5, 9(r3)
	sw	r8, 10(r3)
	add	r2, r0, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_surface_table.3097				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r5, 9(r3)
	lw	r8, 10(r3)
	add	r30, r5, r8
	sw	r1, 0(r30)
beq_cont.17137:
	j	beq_cont.17135
beq_then.17134:
	sw	r5, 9(r3)
	sw	r7, 11(r3)
	sw	r8, 10(r3)
	sw	r9, 12(r3)
	add	r2, r0, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_rect_table.3094				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r5, 9(r3)
	lw	r7, 11(r3)
	lw	r8, 10(r3)
	lw	r9, 12(r3)
	add	r30, r5, r8
	sw	r1, 0(r30)
beq_cont.17135:
	addi	r1, r8, -1
	sw	r9, 12(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -14
	lw	r31, 13(r3)
bge_cont.17133:
	addi	r1, r0, 118
	add	r2, r0, r1
	add	r1, r0, r9
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 768(r0)
	addi	r1, r0, 119
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
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
	fsw	f4, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	fsw	f1, 6(r3)
	sw	r2, 8(r3)
	sw	r1, 9(r3)
	add	r1, r0, r5
	fadd	f1, f0, f5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r5, r0, r1
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f2, 4(r3)
	flw	f1, 6(r3)
	lw	r2, 8(r3)
	lw	r1, 9(r3)
	lw	r6, 0(r0)
	sw	r5, 10(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r7, r0, r1
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f2, 4(r3)
	flw	f1, 6(r3)
	lw	r5, 10(r3)
	lw	r2, 8(r3)
	lw	r1, 9(r3)
	add	r6, r0, r4
	addi	r4, r4, 2
	sw	r7, 1(r6)
	sw	r5, 0(r6)
	fsw	f2, 0(r5)
	fsw	f3, 1(r5)
	fsw	f4, 2(r5)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	sw	r6, 11(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f1, 6(r3)
	lw	r2, 8(r3)
	lw	r1, 9(r3)
	lw	r6, 11(r3)
	addi	r7, r0, 778				# set min_caml_reflections
	add	r5, r0, r4
	addi	r4, r4, 3
	fsw	f1, 2(r5)
	sw	r6, 1(r5)
	sw	r2, 0(r5)
	add	r2, r0, r5
	add	r30, r7, r1
	sw	r2, 0(r30)
	jr	r31				#
setup_rect_reflection.3335:
	slli	r5, r1, 2
	lw	r6, 1023(r0)
	flup	f2, 2		# fli	f2, 1.000000
	lw	r1, 7(r2)
	flw	f1, 0(r1)
	fsub	f4, f2, f1
	flw	f1, 667(r0)
	fneg	f3, f1
	flw	f1, 668(r0)
	fneg	f2, f1
	flw	f1, 669(r0)
	fneg	f1, f1
	addi	r10, r5, 1
	flw	f6, 667(r0)
	addi	r1, r0, 3
	flup	f5, 0		# fli	f5, 0.000000
	fsw	f1, 0(r3)
	fsw	f2, 2(r3)
	fsw	f3, 4(r3)
	fsw	f4, 6(r3)
	fsw	f6, 8(r3)
	sw	r5, 10(r3)
	sw	r6, 11(r3)
	sw	r10, 12(r3)
	fadd	f1, f0, f5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	flw	f6, 8(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r10, 12(r3)
	lw	r2, 0(r0)
	sw	r1, 13(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_array				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r9, r0, r1
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	flw	f6, 8(r3)
	lw	r1, 13(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r10, 12(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r9, 1(r2)
	sw	r1, 0(r2)
	add	r8, r0, r2
	fsw	f6, 0(r1)
	fsw	f2, 1(r1)
	fsw	f1, 2(r1)
	lw	r2, 0(r0)
	addi	r11, r2, -1
	bgei	0, r11, bge_then.17139
	j	bge_cont.17140
bge_then.17139:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r11
	lw	r7, 0(r30)
	lw	r2, 1(r7)
	beqi	1, r2, beq_then.17141
	beqi	2, r2, beq_then.17143
	sw	r9, 14(r3)
	sw	r11, 15(r3)
	add	r2, r0, r7
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	setup_second_table.3100				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r9, 14(r3)
	lw	r11, 15(r3)
	add	r30, r9, r11
	sw	r1, 0(r30)
	j	beq_cont.17144
beq_then.17143:
	sw	r9, 14(r3)
	sw	r11, 15(r3)
	add	r2, r0, r7
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	setup_surface_table.3097				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r9, 14(r3)
	lw	r11, 15(r3)
	add	r30, r9, r11
	sw	r1, 0(r30)
beq_cont.17144:
	j	beq_cont.17142
beq_then.17141:
	sw	r8, 16(r3)
	sw	r9, 14(r3)
	sw	r11, 15(r3)
	add	r2, r0, r7
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	setup_rect_table.3094				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r8, 16(r3)
	lw	r9, 14(r3)
	lw	r10, 12(r3)
	lw	r11, 15(r3)
	add	r30, r9, r11
	sw	r1, 0(r30)
beq_cont.17142:
	addi	r1, r11, -1
	sw	r8, 16(r3)
	add	r2, r0, r1
	add	r1, r0, r8
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -18
	lw	r31, 17(r3)
bge_cont.17140:
	addi	r2, r0, 778				# set min_caml_reflections
	add	r1, r0, r4
	addi	r4, r4, 3
	fsw	f4, 2(r1)
	sw	r8, 1(r1)
	sw	r10, 0(r1)
	add	r30, r2, r6
	sw	r1, 0(r30)
	addi	r11, r6, 1
	addi	r10, r5, 2
	flw	f6, 668(r0)
	addi	r1, r0, 3
	flup	f5, 0		# fli	f5, 0.000000
	fsw	f6, 18(r3)
	sw	r10, 20(r3)
	sw	r11, 21(r3)
	fadd	f1, f0, f5
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_float_array				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	flw	f6, 18(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r10, 20(r3)
	lw	r11, 21(r3)
	lw	r2, 0(r0)
	sw	r1, 22(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				
	addi	r3, r3, -24
	lw	r31, 23(r3)
	add	r9, r0, r1
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	flw	f6, 18(r3)
	lw	r1, 22(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r10, 20(r3)
	lw	r11, 21(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r9, 1(r2)
	sw	r1, 0(r2)
	add	r8, r0, r2
	fsw	f3, 0(r1)
	fsw	f6, 1(r1)
	fsw	f1, 2(r1)
	lw	r2, 0(r0)
	addi	r12, r2, -1
	bgei	0, r12, bge_then.17146
	j	bge_cont.17147
bge_then.17146:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r12
	lw	r7, 0(r30)
	lw	r2, 1(r7)
	beqi	1, r2, beq_then.17148
	beqi	2, r2, beq_then.17150
	sw	r9, 23(r3)
	sw	r12, 24(r3)
	add	r2, r0, r7
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_second_table.3100				
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r9, 23(r3)
	lw	r12, 24(r3)
	add	r30, r9, r12
	sw	r1, 0(r30)
	j	beq_cont.17151
beq_then.17150:
	sw	r9, 23(r3)
	sw	r12, 24(r3)
	add	r2, r0, r7
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	setup_surface_table.3097				
	addi	r3, r3, -26
	lw	r31, 25(r3)
	lw	r9, 23(r3)
	lw	r12, 24(r3)
	add	r30, r9, r12
	sw	r1, 0(r30)
beq_cont.17151:
	j	beq_cont.17149
beq_then.17148:
	sw	r8, 25(r3)
	sw	r9, 23(r3)
	sw	r12, 24(r3)
	add	r2, r0, r7
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_rect_table.3094				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r8, 25(r3)
	lw	r9, 23(r3)
	lw	r10, 20(r3)
	lw	r11, 21(r3)
	lw	r12, 24(r3)
	add	r30, r9, r12
	sw	r1, 0(r30)
beq_cont.17149:
	addi	r1, r12, -1
	sw	r8, 25(r3)
	add	r2, r0, r1
	add	r1, r0, r8
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -27
	lw	r31, 26(r3)
bge_cont.17147:
	addi	r2, r0, 778				# set min_caml_reflections
	add	r1, r0, r4
	addi	r4, r4, 3
	fsw	f4, 2(r1)
	sw	r8, 1(r1)
	sw	r10, 0(r1)
	add	r30, r2, r11
	sw	r1, 0(r30)
	addi	r10, r6, 2
	addi	r9, r5, 3
	flw	f5, 669(r0)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f5, 26(r3)
	sw	r9, 28(r3)
	sw	r10, 29(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	lib_create_float_array				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	flw	f5, 26(r3)
	lw	r6, 11(r3)
	lw	r9, 28(r3)
	lw	r10, 29(r3)
	lw	r2, 0(r0)
	sw	r1, 30(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	lib_create_array				
	addi	r3, r3, -32
	lw	r31, 31(r3)
	add	r8, r0, r1
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	flw	f5, 26(r3)
	lw	r1, 30(r3)
	lw	r6, 11(r3)
	lw	r9, 28(r3)
	lw	r10, 29(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r8, 1(r2)
	sw	r1, 0(r2)
	add	r7, r0, r2
	fsw	f3, 0(r1)
	fsw	f2, 1(r1)
	fsw	f5, 2(r1)
	lw	r2, 0(r0)
	addi	r11, r2, -1
	bgei	0, r11, bge_then.17152
	j	bge_cont.17153
bge_then.17152:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r11
	lw	r5, 0(r30)
	lw	r2, 1(r5)
	beqi	1, r2, beq_then.17154
	beqi	2, r2, beq_then.17156
	sw	r8, 31(r3)
	sw	r11, 32(r3)
	add	r2, r0, r5
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_second_table.3100				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r8, 31(r3)
	lw	r11, 32(r3)
	add	r30, r8, r11
	sw	r1, 0(r30)
	j	beq_cont.17157
beq_then.17156:
	sw	r8, 31(r3)
	sw	r11, 32(r3)
	add	r2, r0, r5
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_surface_table.3097				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r8, 31(r3)
	lw	r11, 32(r3)
	add	r30, r8, r11
	sw	r1, 0(r30)
beq_cont.17157:
	j	beq_cont.17155
beq_then.17154:
	sw	r7, 33(r3)
	sw	r8, 31(r3)
	sw	r11, 32(r3)
	add	r2, r0, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_rect_table.3094				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flw	f4, 6(r3)
	lw	r6, 11(r3)
	lw	r7, 33(r3)
	lw	r8, 31(r3)
	lw	r9, 28(r3)
	lw	r10, 29(r3)
	lw	r11, 32(r3)
	add	r30, r8, r11
	sw	r1, 0(r30)
beq_cont.17155:
	addi	r1, r11, -1
	sw	r7, 33(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -35
	lw	r31, 34(r3)
bge_cont.17153:
	addi	r2, r0, 778				# set min_caml_reflections
	add	r1, r0, r4
	addi	r4, r4, 3
	fsw	f4, 2(r1)
	sw	r7, 1(r1)
	sw	r9, 0(r1)
	add	r30, r2, r10
	sw	r1, 0(r30)
	addi	r1, r6, 3
	sw	r1, 1023(r0)
	jr	r31				#
setup_surface_reflection.3338:
	slli	r1, r1, 2
	addi	r5, r1, 1
	lw	r6, 1023(r0)
	flup	f2, 2		# fli	f2, 1.000000
	lw	r1, 7(r2)
	flw	f1, 0(r1)
	fsub	f2, f2, f1
	lw	r1, 4(r2)
	flw	f3, 667(r0)
	flw	f1, 0(r1)
	fmul	f4, f3, f1
	flw	f3, 668(r0)
	flw	f1, 1(r1)
	fmul	f1, f3, f1
	fadd	f4, f4, f1
	flw	f3, 669(r0)
	flw	f1, 2(r1)
	fmul	f1, f3, f1
	fadd	f1, f4, f1
	flup	f4, 3		# fli	f4, 2.000000
	lw	r1, 4(r2)
	flw	f3, 0(r1)
	fmul	f3, f4, f3
	fmul	f4, f3, f1
	flw	f3, 667(r0)
	fsub	f6, f4, f3
	flup	f4, 3		# fli	f4, 2.000000
	lw	r1, 4(r2)
	flw	f3, 1(r1)
	fmul	f3, f4, f3
	fmul	f4, f3, f1
	flw	f3, 668(r0)
	fsub	f5, f4, f3
	flup	f4, 3		# fli	f4, 2.000000
	lw	r1, 4(r2)
	flw	f3, 2(r1)
	fmul	f3, f4, f3
	fmul	f3, f3, f1
	flw	f1, 669(r0)
	fsub	f3, f3, f1
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
	fsw	f5, 4(r3)
	fsw	f6, 6(r3)
	sw	r5, 8(r3)
	sw	r6, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	flw	f3, 2(r3)
	flw	f5, 4(r3)
	flw	f6, 6(r3)
	lw	r5, 8(r3)
	lw	r6, 9(r3)
	lw	r2, 0(r0)
	sw	r1, 10(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r9, r0, r1
	flw	f2, 0(r3)
	flw	f3, 2(r3)
	flw	f5, 4(r3)
	flw	f6, 6(r3)
	lw	r1, 10(r3)
	lw	r5, 8(r3)
	lw	r6, 9(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r9, 1(r2)
	sw	r1, 0(r2)
	add	r8, r0, r2
	fsw	f6, 0(r1)
	fsw	f5, 1(r1)
	fsw	f3, 2(r1)
	lw	r2, 0(r0)
	addi	r10, r2, -1
	bgei	0, r10, bge_then.17159
	j	bge_cont.17160
bge_then.17159:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r10
	lw	r7, 0(r30)
	lw	r2, 1(r7)
	beqi	1, r2, beq_then.17161
	beqi	2, r2, beq_then.17163
	sw	r9, 11(r3)
	sw	r10, 12(r3)
	add	r2, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_second_table.3100				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r9, 11(r3)
	lw	r10, 12(r3)
	add	r30, r9, r10
	sw	r1, 0(r30)
	j	beq_cont.17164
beq_then.17163:
	sw	r9, 11(r3)
	sw	r10, 12(r3)
	add	r2, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_surface_table.3097				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r9, 11(r3)
	lw	r10, 12(r3)
	add	r30, r9, r10
	sw	r1, 0(r30)
beq_cont.17164:
	j	beq_cont.17162
beq_then.17161:
	sw	r8, 13(r3)
	sw	r9, 11(r3)
	sw	r10, 12(r3)
	add	r2, r0, r7
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_rect_table.3094				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 0(r3)
	lw	r5, 8(r3)
	lw	r6, 9(r3)
	lw	r8, 13(r3)
	lw	r9, 11(r3)
	lw	r10, 12(r3)
	add	r30, r9, r10
	sw	r1, 0(r30)
beq_cont.17162:
	addi	r1, r10, -1
	sw	r8, 13(r3)
	add	r2, r0, r1
	add	r1, r0, r8
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -15
	lw	r31, 14(r3)
bge_cont.17160:
	addi	r2, r0, 778				# set min_caml_reflections
	add	r1, r0, r4
	addi	r4, r4, 3
	fsw	f2, 2(r1)
	sw	r8, 1(r1)
	sw	r5, 0(r1)
	add	r30, r2, r6
	sw	r1, 0(r30)
	addi	r1, r6, 1
	sw	r1, 1023(r0)
	jr	r31				#
setup_reflections.3341:
	bgei	0, r1, bge_then.17166
	jr	r31				#
bge_then.17166:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.17168
	jr	r31				#
beq_then.17168:
	flup	f2, 2		# fli	f2, 1.000000
	lw	r5, 7(r2)
	flw	f1, 0(r5)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17170
	jr	r31				#
fle_else.17170:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.17172
	beqi	2, r5, beq_then.17173
	jr	r31				#
beq_then.17173:
	j	setup_surface_reflection.3338
beq_then.17172:
	j	setup_rect_reflection.3335
rt.3343:
	sw	r1, 743(r0)
	sw	r2, 744(r0)
	srai	r5, r1, 1
	sw	r5, 745(r0)
	srai	r2, r2, 1
	sw	r2, 746(r0)
	flup	f2, 49		# fli	f2, 128.000000
	itof	f1, r1
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 747(r0)
	lw	r12, 743(r0)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r12, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r5, r0, r1
	lw	r12, 0(r3)
	sw	r5, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	create_float5x3array.3283				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r8, r0, r1
	lw	r5, 1(r3)
	lw	r12, 0(r3)
	addi	r2, r0, 5
	addi	r1, r0, 0
	sw	r8, 2(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r5, 1(r3)
	lw	r8, 2(r3)
	lw	r12, 0(r3)
	addi	r6, r0, 5
	addi	r1, r0, 0
	sw	r2, 3(r3)
	add	r2, r0, r1
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r11, r0, r1
	lw	r2, 3(r3)
	lw	r5, 1(r3)
	lw	r8, 2(r3)
	lw	r12, 0(r3)
	sw	r11, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_float5x3array.3283				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r10, r0, r1
	lw	r2, 3(r3)
	lw	r5, 1(r3)
	lw	r8, 2(r3)
	lw	r11, 4(r3)
	lw	r12, 0(r3)
	sw	r10, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3283				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r6, r0, r1
	lw	r2, 3(r3)
	lw	r5, 1(r3)
	lw	r8, 2(r3)
	lw	r10, 5(r3)
	lw	r11, 4(r3)
	lw	r12, 0(r3)
	addi	r7, r0, 1
	addi	r1, r0, 0
	sw	r6, 6(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r9, r0, r1
	lw	r2, 3(r3)
	lw	r5, 1(r3)
	lw	r6, 6(r3)
	lw	r8, 2(r3)
	lw	r10, 5(r3)
	lw	r11, 4(r3)
	lw	r12, 0(r3)
	sw	r9, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	create_float5x3array.3283				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r7, r0, r1
	lw	r2, 3(r3)
	lw	r5, 1(r3)
	lw	r6, 6(r3)
	lw	r8, 2(r3)
	lw	r9, 7(r3)
	lw	r10, 5(r3)
	lw	r11, 4(r3)
	lw	r12, 0(r3)
	add	r1, r0, r4
	addi	r4, r4, 8
	sw	r7, 7(r1)
	sw	r9, 6(r1)
	sw	r6, 5(r1)
	sw	r10, 4(r1)
	sw	r11, 3(r1)
	sw	r2, 2(r1)
	sw	r8, 1(r1)
	sw	r5, 0(r1)
	add	r2, r0, r1
	add	r1, r0, r12
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
	add	r2, r0, r1
	lw	r13, 743(r0)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 8(r3)
	sw	r13, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r6, r0, r1
	lw	r2, 8(r3)
	lw	r13, 9(r3)
	sw	r6, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_float5x3array.3283				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r9, r0, r1
	lw	r2, 8(r3)
	lw	r6, 10(r3)
	lw	r13, 9(r3)
	addi	r5, r0, 5
	addi	r1, r0, 0
	sw	r9, 11(r3)
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r5, r0, r1
	lw	r2, 8(r3)
	lw	r6, 10(r3)
	lw	r9, 11(r3)
	lw	r13, 9(r3)
	addi	r7, r0, 5
	addi	r1, r0, 0
	sw	r5, 12(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r12, r0, r1
	lw	r2, 8(r3)
	lw	r5, 12(r3)
	lw	r6, 10(r3)
	lw	r9, 11(r3)
	lw	r13, 9(r3)
	sw	r12, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	create_float5x3array.3283				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r11, r0, r1
	lw	r2, 8(r3)
	lw	r5, 12(r3)
	lw	r6, 10(r3)
	lw	r9, 11(r3)
	lw	r12, 13(r3)
	lw	r13, 9(r3)
	sw	r11, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_float5x3array.3283				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r7, r0, r1
	lw	r2, 8(r3)
	lw	r5, 12(r3)
	lw	r6, 10(r3)
	lw	r9, 11(r3)
	lw	r11, 14(r3)
	lw	r12, 13(r3)
	lw	r13, 9(r3)
	addi	r8, r0, 1
	addi	r1, r0, 0
	sw	r7, 15(r3)
	add	r2, r0, r1
	add	r1, r0, r8
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	add	r10, r0, r1
	lw	r2, 8(r3)
	lw	r5, 12(r3)
	lw	r6, 10(r3)
	lw	r7, 15(r3)
	lw	r9, 11(r3)
	lw	r11, 14(r3)
	lw	r12, 13(r3)
	lw	r13, 9(r3)
	sw	r10, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3283				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	add	r8, r0, r1
	lw	r2, 8(r3)
	lw	r5, 12(r3)
	lw	r6, 10(r3)
	lw	r7, 15(r3)
	lw	r9, 11(r3)
	lw	r10, 16(r3)
	lw	r11, 14(r3)
	lw	r12, 13(r3)
	lw	r13, 9(r3)
	add	r1, r0, r4
	addi	r4, r4, 8
	sw	r8, 7(r1)
	sw	r10, 6(r1)
	sw	r7, 5(r1)
	sw	r11, 4(r1)
	sw	r12, 3(r1)
	sw	r5, 2(r1)
	sw	r9, 1(r1)
	sw	r6, 0(r1)
	add	r2, r0, r1
	add	r1, r0, r13
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_array				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r2, 8(r3)
	lw	r5, 743(r0)
	addi	r5, r5, -2
	add	r2, r0, r5
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	init_line_elements.3287				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	add	r13, r0, r1
	lw	r2, 8(r3)
	lw	r14, 743(r0)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r13, 17(r3)
	sw	r14, 18(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	lib_create_float_array				
	addi	r3, r3, -20
	lw	r31, 19(r3)
	add	r6, r0, r1
	lw	r2, 8(r3)
	lw	r13, 17(r3)
	lw	r14, 18(r3)
	sw	r6, 19(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	create_float5x3array.3283				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	add	r9, r0, r1
	lw	r2, 8(r3)
	lw	r6, 19(r3)
	lw	r13, 17(r3)
	lw	r14, 18(r3)
	addi	r5, r0, 5
	addi	r1, r0, 0
	sw	r9, 20(r3)
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_array				
	addi	r3, r3, -22
	lw	r31, 21(r3)
	add	r5, r0, r1
	lw	r2, 8(r3)
	lw	r6, 19(r3)
	lw	r9, 20(r3)
	lw	r13, 17(r3)
	lw	r14, 18(r3)
	addi	r7, r0, 5
	addi	r1, r0, 0
	sw	r5, 21(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_array				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	add	r12, r0, r1
	lw	r2, 8(r3)
	lw	r5, 21(r3)
	lw	r6, 19(r3)
	lw	r9, 20(r3)
	lw	r13, 17(r3)
	lw	r14, 18(r3)
	sw	r12, 22(r3)
	sw	r31, 23(r3)
	addi	r3, r3, 24
	jal	create_float5x3array.3283				
	addi	r3, r3, -24
	lw	r31, 23(r3)
	add	r11, r0, r1
	lw	r2, 8(r3)
	lw	r5, 21(r3)
	lw	r6, 19(r3)
	lw	r9, 20(r3)
	lw	r12, 22(r3)
	lw	r13, 17(r3)
	lw	r14, 18(r3)
	sw	r11, 23(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	create_float5x3array.3283				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	add	r7, r0, r1
	lw	r2, 8(r3)
	lw	r5, 21(r3)
	lw	r6, 19(r3)
	lw	r9, 20(r3)
	lw	r11, 23(r3)
	lw	r12, 22(r3)
	lw	r13, 17(r3)
	lw	r14, 18(r3)
	addi	r8, r0, 1
	addi	r1, r0, 0
	sw	r7, 24(r3)
	add	r2, r0, r1
	add	r1, r0, r8
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	lib_create_array				
	addi	r3, r3, -26
	lw	r31, 25(r3)
	add	r10, r0, r1
	lw	r2, 8(r3)
	lw	r5, 21(r3)
	lw	r6, 19(r3)
	lw	r7, 24(r3)
	lw	r9, 20(r3)
	lw	r11, 23(r3)
	lw	r12, 22(r3)
	lw	r13, 17(r3)
	lw	r14, 18(r3)
	sw	r10, 25(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	create_float5x3array.3283				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	add	r8, r0, r1
	lw	r2, 8(r3)
	lw	r5, 21(r3)
	lw	r6, 19(r3)
	lw	r7, 24(r3)
	lw	r9, 20(r3)
	lw	r10, 25(r3)
	lw	r11, 23(r3)
	lw	r12, 22(r3)
	lw	r13, 17(r3)
	lw	r14, 18(r3)
	add	r1, r0, r4
	addi	r4, r4, 8
	sw	r8, 7(r1)
	sw	r10, 6(r1)
	sw	r7, 5(r1)
	sw	r11, 4(r1)
	sw	r12, 3(r1)
	sw	r5, 2(r1)
	sw	r9, 1(r1)
	sw	r6, 0(r1)
	add	r2, r0, r1
	add	r1, r0, r14
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_array				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 8(r3)
	lw	r13, 17(r3)
	lw	r5, 743(r0)
	addi	r5, r5, -2
	add	r2, r0, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	init_line_elements.3287				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 8(r3)
	lw	r13, 17(r3)
	sw	r1, 26(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	read_screen_settings.2989				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	read_light.2991				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	addi	r5, r0, 0
	sw	r5, 27(r3)
	add	r1, r0, r5
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_nth_object.2996				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	add	r6, r0, r1
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	lw	r5, 27(r3)
	beqi	0, r6, beq_then.17175
	addi	r5, r0, 1
	add	r1, r0, r5
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_object.2998				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	j	beq_cont.17176
beq_then.17175:
	sw	r5, 0(r0)
beq_cont.17176:
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	addi	r5, r0, 0
	add	r1, r0, r5
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_and_network.3006				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	addi	r5, r0, 0
	add	r1, r0, r5
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_or_network.3004				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	add	r5, r0, r1
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	sw	r5, 723(r0)
	addi	r5, r0, 80
	out	r5
	addi	r5, r0, 51
	out	r5
	addi	r5, r0, 10
	out	r5
	lw	r5, 743(r0)
	add	r1, r0, r5
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	print_int.2857				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	addi	r5, r0, 32
	out	r5
	lw	r5, 744(r0)
	add	r1, r0, r5
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	print_int.2857				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	addi	r5, r0, 32
	out	r5
	addi	r5, r0, 255
	add	r1, r0, r5
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	print_int.2857				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	addi	r5, r0, 10
	out	r5
	addi	r5, r0, 4
	add	r1, r0, r5
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	create_dirvecs.3319				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	addi	r7, r0, 9
	addi	r6, r0, 0
	addi	r5, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	calc_dirvec_rows.3310				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	lw	r11, 770(r0)
	lw	r9, 119(r11)
	lw	r5, 0(r0)
	addi	r10, r5, -1
	bgei	0, r10, bge_then.17177
	j	bge_cont.17178
bge_then.17177:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r10
	lw	r8, 0(r30)
	lw	r7, 1(r9)
	lw	r5, 0(r9)
	lw	r6, 1(r8)
	beqi	1, r6, beq_then.17179
	beqi	2, r6, beq_then.17181
	sw	r7, 28(r3)
	sw	r10, 29(r3)
	add	r2, r0, r8
	add	r1, r0, r5
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	setup_second_table.3100				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	lw	r7, 28(r3)
	lw	r10, 29(r3)
	add	r30, r7, r10
	sw	r1, 0(r30)
	j	beq_cont.17182
beq_then.17181:
	sw	r7, 28(r3)
	sw	r10, 29(r3)
	add	r2, r0, r8
	add	r1, r0, r5
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	setup_surface_table.3097				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	lw	r7, 28(r3)
	lw	r10, 29(r3)
	add	r30, r7, r10
	sw	r1, 0(r30)
beq_cont.17182:
	j	beq_cont.17180
beq_then.17179:
	sw	r7, 28(r3)
	sw	r9, 30(r3)
	sw	r10, 29(r3)
	sw	r11, 31(r3)
	add	r2, r0, r8
	add	r1, r0, r5
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	setup_rect_table.3094				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	add	r5, r0, r1
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r7, 28(r3)
	lw	r13, 17(r3)
	lw	r9, 30(r3)
	lw	r10, 29(r3)
	lw	r11, 31(r3)
	add	r30, r7, r10
	sw	r5, 0(r30)
beq_cont.17180:
	addi	r5, r10, -1
	sw	r11, 31(r3)
	add	r2, r0, r5
	add	r1, r0, r9
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -33
	lw	r31, 32(r3)
bge_cont.17178:
	addi	r5, r0, 118
	add	r2, r0, r5
	add	r1, r0, r11
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	lw	r6, 769(r0)
	addi	r5, r0, 119
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	addi	r5, r0, 2
	add	r1, r0, r5
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	init_vecset_constants.3324				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	addi	r5, r0, 1021				# set min_caml_light_dirvec
	lw	r5, 0(r5)
	flw	f1, 667(r0)
	fsw	f1, 0(r5)
	flw	f1, 668(r0)
	fsw	f1, 1(r5)
	flw	f1, 669(r0)
	fsw	f1, 2(r5)
	addi	r5, r0, 1021				# set min_caml_light_dirvec
	lw	r6, 0(r0)
	addi	r6, r6, -1
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	lw	r5, 0(r0)
	addi	r5, r5, -1
	bgei	0, r5, bge_then.17183
	j	bge_cont.17184
bge_then.17183:
	lw	r1, 3(r0)
	lw	r2, 2(r1)
	beqi	2, r2, beq_then.17185
	j	beq_cont.17186
beq_then.17185:
	flup	f2, 2		# fli	f2, 1.000000
	lw	r2, 7(r1)
	flw	f1, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17187
	j	fle_cont.17188
fle_else.17187:
	lw	r2, 1(r1)
	beqi	1, r2, beq_then.17189
	beqi	2, r2, beq_then.17191
	j	beq_cont.17192
beq_then.17191:
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	setup_surface_reflection.3338				
	addi	r3, r3, -33
	lw	r31, 32(r3)
beq_cont.17192:
	j	beq_cont.17190
beq_then.17189:
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	setup_rect_reflection.3335				
	addi	r3, r3, -33
	lw	r31, 32(r3)
beq_cont.17190:
fle_cont.17188:
beq_cont.17186:
bge_cont.17184:
	addi	r6, r0, 0
	addi	r5, r0, 0
	add	r2, r0, r6
	add	r1, r0, r13
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	pretrace_line.3267				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	addi	r7, r0, 0
	addi	r6, r0, 2
	lw	r5, 744(r0)
	blei	0, r5, ble_then.17193
	lw	r5, 744(r0)
	addi	r5, r5, -1
	blei	0, r5, ble_then.17194
	addi	r5, r0, 1
	sw	r7, 32(r3)
	add	r2, r0, r5
	add	r5, r0, r6
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	pretrace_line.3267				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	j	ble_cont.17195
ble_then.17194:
ble_cont.17195:
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	lw	r7, 32(r3)
	addi	r5, r0, 0
	add	r6, r0, r13
	add	r28, r0, r7
	add	r7, r0, r1
	add	r1, r0, r5
	add	r5, r0, r2
	add	r2, r0, r28
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	scan_pixel.3271				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r2, 8(r3)
	lw	r1, 26(r3)
	lw	r13, 17(r3)
	addi	r6, r0, 1
	addi	r5, r0, 4
	add	r7, r0, r5
	add	r5, r0, r1
	add	r1, r0, r6
	add	r6, r0, r2
	add	r2, r0, r13
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	scan_line.3277				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	jr	r31				#
ble_then.17193:
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
	addi	r2, r0, 128
	addi	r1, r0, 128
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	rt.3343				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	_R_0, r0, 0
