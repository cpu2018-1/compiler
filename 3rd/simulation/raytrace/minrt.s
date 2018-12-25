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
	beq	r0, r30, fle_else.11086
	addi	r1, r0, 0
	jr	r31				#
fle_else.11086:
	addi	r1, r0, 1
	jr	r31				#
fisneg.2805:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11087
	addi	r1, r0, 0
	jr	r31				#
fle_else.11087:
	addi	r1, r0, 1
	jr	r31				#
fiszero.2807:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11088
	addi	r1, r0, 1
	jr	r31				#
feq_else.11088:
	addi	r1, r0, 0
	jr	r31				#
xor.2809:
	beq	r1, r2, beq_then.11089
	addi	r1, r0, 1
	jr	r31				#
beq_then.11089:
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
	beq	r0, r30, fle_else.11090
	jr	r31				#
fle_else.11090:
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
	beq	r0, r30, fle_else.11091
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11091:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
	jr	r31				#
hoge.2824:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11092
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11093
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11094
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11095
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11096
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11097
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11098
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11099
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2824
fle_else.11099:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11098:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11097:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11096:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11095:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11094:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11093:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11092:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2827:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11100
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11101
	fsub	f4, f1, f2
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	flup	f1, 3		# fli	f1, 2.000000
	fmul	f1, f3, f1
	fle	r30, f1, f4
	beq	r0, r30, fle_else.11102
	fle	r30, f2, f4
	beq	r0, r30, fle_else.11103
	fsub	f4, f4, f2
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.11103:
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.11102:
	fadd	f1, f0, f4
	jr	r31				#
fle_else.11101:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11104
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11105
	fsub	f4, f1, f2
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.11105:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	j	fuga.2827
fle_else.11104:
	jr	r31				#
fle_else.11100:
	jr	r31				#
modulo_2pi.2831:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11106
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11108
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11110
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11112
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11114
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11116
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11118
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fsw	f1, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	hoge.2824				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	fadd	f2, f0, f1
	j	fle_cont.11119
fle_else.11118:
fle_cont.11119:
	j	fle_cont.11117
fle_else.11116:
fle_cont.11117:
	j	fle_cont.11115
fle_else.11114:
fle_cont.11115:
	j	fle_cont.11113
fle_else.11112:
fle_cont.11113:
	j	fle_cont.11111
fle_else.11110:
fle_cont.11111:
	j	fle_cont.11109
fle_else.11108:
fle_cont.11109:
	j	fle_cont.11107
fle_else.11106:
fle_cont.11107:
	flup	f4, 5		# fli	f4, 6.283186
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11120
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11121
	fsub	f4, f1, f2
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.11121:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	j	fuga.2827
fle_else.11120:
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
	flup	f2, 14		# fli	f2, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11122
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.11123
fle_else.11122:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.11123:
	fsw	f2, 0(r3)
	fsw	f4, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f5, f0, f1
	flup	f3, 14		# fli	f3, 3.141593
	flup	f1, 5		# fli	f1, 6.283186
	fle	r30, f1, f5
	beq	r0, r30, fle_else.11124
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.11126
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.11128
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.11130
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.11132
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.11134
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f1, r30
	fsw	f3, 4(r3)
	fsw	f1, 6(r3)
	fsw	f5, 8(r3)
	fadd	f2, f0, f1
	fadd	f1, f0, f5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	hoge.2824				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	fle_cont.11135
fle_else.11134:
fle_cont.11135:
	j	fle_cont.11133
fle_else.11132:
fle_cont.11133:
	j	fle_cont.11131
fle_else.11130:
fle_cont.11131:
	j	fle_cont.11129
fle_else.11128:
fle_cont.11129:
	j	fle_cont.11127
fle_else.11126:
fle_cont.11127:
	j	fle_cont.11125
fle_else.11124:
fle_cont.11125:
	fadd	f2, f0, f1
	fadd	f1, f0, f5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	fuga.2827				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11136
	fsub	f1, f1, f2
	flw	f4, 2(r3)
	fneg	f3, f4
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11137
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11138
	fsw	f3, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin_body.2833				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f3, 10(r3)
	fmul	f1, f1, f3
	jr	r31				#
fle_else.11138:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
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
fle_else.11137:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11139
	fsw	f3, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin_body.2833				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f3, 10(r3)
	fmul	f1, f1, f3
	jr	r31				#
fle_else.11139:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
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
fle_else.11136:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11140
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11141
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin_body.2833				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f4, 2(r3)
	fmul	f1, f1, f4
	jr	r31				#
fle_else.11141:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
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
	flw	f4, 2(r3)
	fmul	f1, f1, f4
	jr	r31				#
fle_else.11140:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11142
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin_body.2833				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f4, 2(r3)
	fmul	f1, f1, f4
	jr	r31				#
fle_else.11142:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
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
	flw	f4, 2(r3)
	fmul	f1, f1, f4
	jr	r31				#
cos.2839:
	flup	f2, 14		# fli	f2, 3.141593
	flup	f4, 2		# fli	f4, 1.000000
	fsw	f2, 0(r3)
	fsw	f4, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f5, f0, f1
	flup	f3, 14		# fli	f3, 3.141593
	flup	f1, 5		# fli	f1, 6.283186
	fle	r30, f1, f5
	beq	r0, r30, fle_else.11143
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.11145
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.11147
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.11149
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.11151
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.11153
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f1, r30
	fsw	f3, 4(r3)
	fsw	f1, 6(r3)
	fsw	f5, 8(r3)
	fadd	f2, f0, f1
	fadd	f1, f0, f5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	hoge.2824				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	fle_cont.11154
fle_else.11153:
fle_cont.11154:
	j	fle_cont.11152
fle_else.11151:
fle_cont.11152:
	j	fle_cont.11150
fle_else.11149:
fle_cont.11150:
	j	fle_cont.11148
fle_else.11147:
fle_cont.11148:
	j	fle_cont.11146
fle_else.11145:
fle_cont.11146:
	j	fle_cont.11144
fle_else.11143:
fle_cont.11144:
	fadd	f2, f0, f1
	fadd	f1, f0, f5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	fuga.2827				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11155
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11156
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.11157
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
fle_else.11157:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fsw	f2, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin_body.2833				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.11156:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11158
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
fle_else.11158:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin_body.2833				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f3, 12(r3)
	fmul	f1, f1, f3
	jr	r31				#
fle_else.11155:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11159
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.11160
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
fle_else.11160:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fsw	f2, 14(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	sin_body.2833				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.11159:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11161
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
	flw	f4, 2(r3)
	fmul	f1, f1, f4
	jr	r31				#
fle_else.11161:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	sin_body.2833				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f4, 2(r3)
	fmul	f1, f1, f4
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
	beq	r0, r30, fle_else.11162
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.11163
fle_else.11162:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.11163:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11164
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11165
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
	flw	f4, 2(r3)
	fadd	f1, f4, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.11165:
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
	flw	f5, 4(r3)
	fadd	f1, f5, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.11164:
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
	ble	r7, r1, ble_then.11166
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r8, r5, 3
	slli	r7, r5, 1
	add	r7, r8, r7
	ble	r7, r1, ble_then.11167
	j	div10_sub.2849
ble_then.11167:
	slli	r7, r5, 3
	slli	r2, r5, 1
	add	r2, r7, r2
	addi	r2, r2, 9
	ble	r1, r2, ble_then.11168
	add	r2, r0, r5
	add	r5, r0, r6
	j	div10_sub.2849
ble_then.11168:
	add	r1, r0, r5
	jr	r31				#
ble_then.11166:
	slli	r7, r6, 3
	slli	r2, r6, 1
	add	r2, r7, r2
	addi	r2, r2, 9
	ble	r1, r2, ble_then.11169
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r8, r2, 3
	slli	r7, r2, 1
	add	r7, r8, r7
	ble	r7, r1, ble_then.11170
	add	r5, r0, r2
	add	r2, r0, r6
	j	div10_sub.2849
ble_then.11170:
	slli	r7, r2, 3
	slli	r6, r2, 1
	add	r6, r7, r6
	addi	r6, r6, 9
	ble	r1, r6, ble_then.11171
	j	div10_sub.2849
ble_then.11171:
	add	r1, r0, r2
	jr	r31				#
ble_then.11169:
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
	bgei	10, r1, bge_then.11172
	addi	r1, r1, 48
	out	r1
	jr	r31				#
bge_then.11172:
	slli	r5, r1, 7
	slli	r2, r1, 6
	add	r5, r5, r2
	slli	r2, r1, 3
	add	r5, r5, r2
	slli	r2, r1, 2
	add	r2, r5, r2
	add	r2, r2, r1
	srli	r6, r2, 11
	bgei	10, r6, bge_then.11173
	addi	r2, r6, 48
	out	r2
	j	bge_cont.11174
bge_then.11173:
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
	lw	r2, 1(r3)
	slli	r5, r2, 3
	slli	r2, r2, 1
	add	r2, r5, r2
	lw	r6, 2(r3)
	sub	r2, r6, r2
	addi	r2, r2, 48
	out	r2
bge_cont.11174:
	slli	r5, r6, 3
	slli	r2, r6, 1
	add	r2, r5, r2
	sub	r1, r1, r2
	addi	r1, r1, 48
	out	r1
	jr	r31				#
print_int.2857:
	bgei	0, r1, bge_then.11175
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	j	print_int.2857
bge_then.11175:
	bgei	10, r1, bge_then.11176
	addi	r1, r1, 48
	out	r1
	jr	r31				#
bge_then.11176:
	addi	r2, r0, 100
	ble	r2, r1, ble_then.11177
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
ble_then.11177:
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
	beqi	0, r1, beq_then.11178
	beqi	0, r2, beq_then.11179
	addi	r1, r0, 0
	jr	r31				#
beq_then.11179:
	addi	r1, r0, 1
	jr	r31				#
beq_then.11178:
	add	r1, r0, r2
	jr	r31				#
sgn.2862:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11180
	addi	r1, r0, 1
	j	feq_cont.11181
feq_else.11180:
	addi	r1, r0, 0
feq_cont.11181:
	beqi	0, r1, beq_then.11182
	flup	f1, 0		# fli	f1, 0.000000
	jr	r31				#
beq_then.11182:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11183
	addi	r1, r0, 0
	j	fle_cont.11184
fle_else.11183:
	addi	r1, r0, 1
fle_cont.11184:
	beqi	0, r1, beq_then.11185
	flup	f1, 2		# fli	f1, 1.000000
	jr	r31				#
beq_then.11185:
	flup	f1, 11		# fli	f1, -1.000000
	jr	r31				#
fneg_cond.2864:
	beqi	0, r1, beq_then.11186
	jr	r31				#
beq_then.11186:
	fneg	f1, f1
	jr	r31				#
add_mod5.2867:
	add	r1, r1, r2
	bgei	5, r1, bge_then.11187
	jr	r31				#
bge_then.11187:
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
	beq	r0, r30, feq_else.11193
	addi	r5, r0, 1
	j	feq_cont.11194
feq_else.11193:
	addi	r5, r0, 0
feq_cont.11194:
	beqi	0, r5, beq_then.11195
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.11196
beq_then.11195:
	beqi	0, r2, beq_then.11197
	flup	f2, 11		# fli	f2, -1.000000
	finv	f31, f1
	fmul	f1, f2, f31
	j	beq_cont.11198
beq_then.11197:
	flup	f2, 2		# fli	f2, 1.000000
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.11198:
beq_cont.11196:
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
	addi	r1, r0, 661				# set min_caml_screen
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_float				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	fsw	f1, 0(r1)
	addi	r1, r0, 661				# set min_caml_screen
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_float				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	fsw	f1, 1(r1)
	addi	r1, r0, 661				# set min_caml_screen
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_float				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	fsw	f1, 2(r1)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_float				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	fadd	f2, f0, f1
	flup	f1, 25		# fli	f1, 0.017453
	fmul	f1, f2, f1
	fsw	f1, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2839				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	fadd	f4, f0, f1
	flw	f1, 4(r3)
	fsw	f4, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2837				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1
	fsw	f2, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	fadd	f3, f0, f1
	flup	f1, 25		# fli	f1, 0.017453
	fmul	f1, f3, f1
	fsw	f1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	cos.2839				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	fadd	f3, f0, f1
	flw	f1, 10(r3)
	fsw	f3, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin.2837				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r1, r0, 760				# set min_caml_screenz_dir
	flw	f4, 6(r3)
	fmul	f6, f4, f1
	flup	f5, 26		# fli	f5, 200.000000
	fmul	f5, f6, f5
	fsw	f5, 0(r1)
	addi	r1, r0, 760				# set min_caml_screenz_dir
	flup	f5, 27		# fli	f5, -200.000000
	flw	f2, 8(r3)
	fmul	f5, f2, f5
	fsw	f5, 1(r1)
	addi	r1, r0, 760				# set min_caml_screenz_dir
	flw	f3, 12(r3)
	fmul	f6, f4, f3
	flup	f5, 26		# fli	f5, 200.000000
	fmul	f5, f6, f5
	fsw	f5, 2(r1)
	addi	r1, r0, 754				# set min_caml_screenx_dir
	fsw	f3, 0(r1)
	addi	r1, r0, 754				# set min_caml_screenx_dir
	fsw	f0, 1(r1)
	addi	r1, r0, 754				# set min_caml_screenx_dir
	fneg	f5, f1
	fsw	f5, 2(r1)
	addi	r1, r0, 757				# set min_caml_screeny_dir
	fneg	f2, f2
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	addi	r1, r0, 757				# set min_caml_screeny_dir
	fneg	f1, f4
	fsw	f1, 1(r1)
	addi	r1, r0, 757				# set min_caml_screeny_dir
	fmul	f1, f2, f3
	fsw	f1, 2(r1)
	addi	r2, r0, 664				# set min_caml_viewpoint
	addi	r1, r0, 661				# set min_caml_screen
	flw	f2, 0(r1)
	addi	r1, r0, 760				# set min_caml_screenz_dir
	flw	f1, 0(r1)
	fsub	f1, f2, f1
	fsw	f1, 0(r2)
	addi	r2, r0, 664				# set min_caml_viewpoint
	addi	r1, r0, 661				# set min_caml_screen
	flw	f2, 1(r1)
	addi	r1, r0, 760				# set min_caml_screenz_dir
	flw	f1, 1(r1)
	fsub	f1, f2, f1
	fsw	f1, 1(r2)
	addi	r2, r0, 664				# set min_caml_viewpoint
	addi	r1, r0, 661				# set min_caml_screen
	flw	f2, 2(r1)
	addi	r1, r0, 760				# set min_caml_screenz_dir
	flw	f1, 2(r1)
	fsub	f1, f2, f1
	fsw	f1, 2(r2)
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
	addi	r1, r0, 667				# set min_caml_light
	fneg	f1, f1
	fsw	f1, 1(r1)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_float				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	fadd	f2, f0, f1
	flup	f1, 25		# fli	f1, 0.017453
	fmul	f2, f2, f1
	flw	f3, 0(r3)
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
	addi	r1, r0, 667				# set min_caml_light
	flw	f3, 4(r3)
	fmul	f1, f3, f1
	fsw	f1, 0(r1)
	flw	f2, 2(r3)
	fadd	f1, f0, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2839				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 667				# set min_caml_light
	flw	f3, 4(r3)
	fmul	f1, f3, f1
	fsw	f1, 2(r1)
	addi	r1, r0, 670				# set min_caml_beam
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	fsw	f1, 0(r1)
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
	flw	f1, 0(r2)
	fsw	f12, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2837				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f3, f0, f1
	lw	r2, 0(r3)
	flw	f1, 1(r2)
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2839				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	fadd	f11, f0, f1
	lw	r2, 0(r3)
	flw	f1, 1(r2)
	fsw	f11, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2837				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1
	lw	r2, 0(r3)
	flw	f1, 2(r2)
	fsw	f2, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos.2839				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	fadd	f4, f0, f1
	lw	r2, 0(r3)
	flw	f1, 2(r2)
	fsw	f4, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2837				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f11, 6(r3)
	flw	f4, 10(r3)
	fmul	f10, f11, f4
	flw	f3, 4(r3)
	flw	f2, 8(r3)
	fmul	f14, f3, f2
	fmul	f6, f14, f4
	flw	f12, 2(r3)
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
	lw	r1, 1(r3)
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
	lw	r2, 0(r3)
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
	beqi	-1, r5, beq_then.11210
	sw	r5, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r13, r0, r1
	sw	r13, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r8, r0, r1
	sw	r8, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_read_int				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r12, r0, r1
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
	sw	r16, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r16, 5(r3)
	fsw	f1, 0(r16)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r16, 5(r3)
	fsw	f1, 1(r16)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_float				
	addi	r3, r3, -7
	lw	r31, 6(r3)
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
	sw	r2, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	fsw	f1, 0(r2)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	fsw	f1, 1(r2)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	fsw	f1, 2(r2)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_float				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11211
	addi	r11, r0, 0
	j	fle_cont.11212
fle_else.11211:
	addi	r11, r0, 1
fle_cont.11212:
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
	sw	r9, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_read_float				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r9, 8(r3)
	fsw	f1, 0(r9)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_read_float				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r9, 8(r3)
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
	sw	r15, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r15, 9(r3)
	fsw	f1, 0(r15)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r15, 9(r3)
	fsw	f1, 1(r15)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r15, 9(r3)
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
	lw	r12, 4(r3)
	beqi	0, r12, beq_then.11213
	sw	r7, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	fadd	f2, f0, f1
	flup	f1, 25		# fli	f1, 0.017453
	fmul	f1, f2, f1
	lw	r7, 10(r3)
	fsw	f1, 0(r7)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	fadd	f2, f0, f1
	flup	f1, 25		# fli	f1, 0.017453
	fmul	f1, f2, f1
	lw	r7, 10(r3)
	fsw	f1, 1(r7)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_read_float				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	fadd	f2, f0, f1
	flup	f1, 25		# fli	f1, 0.017453
	fmul	f1, f2, f1
	lw	r7, 10(r3)
	fsw	f1, 2(r7)
	j	beq_cont.11214
beq_then.11213:
beq_cont.11214:
	lw	r13, 2(r3)
	beqi	2, r13, beq_then.11215
	lw	r11, 7(r3)
	add	r10, r0, r11
	j	beq_cont.11216
beq_then.11215:
	addi	r10, r0, 1
beq_cont.11216:
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
	add	r6, r0, r4
	addi	r4, r4, 11
	sw	r14, 10(r6)
	lw	r7, 10(r3)
	sw	r7, 9(r6)
	lw	r15, 9(r3)
	sw	r15, 8(r6)
	lw	r9, 8(r3)
	sw	r9, 7(r6)
	lw	r10, 11(r3)
	sw	r10, 6(r6)
	lw	r2, 6(r3)
	sw	r2, 5(r6)
	lw	r16, 5(r3)
	sw	r16, 4(r6)
	lw	r12, 4(r3)
	sw	r12, 3(r6)
	lw	r8, 3(r3)
	sw	r8, 2(r6)
	lw	r13, 2(r3)
	sw	r13, 1(r6)
	lw	r5, 1(r3)
	sw	r5, 0(r6)
	add	r2, r0, r6
	addi	r5, r0, 1				# set min_caml_objects
	lw	r1, 0(r3)
	add	r30, r5, r1
	sw	r2, 0(r30)
	beqi	3, r13, beq_then.11217
	beqi	2, r13, beq_then.11219
	j	beq_cont.11220
beq_then.11219:
	lw	r11, 7(r3)
	beqi	0, r11, beq_then.11221
	addi	r1, r0, 0
	j	beq_cont.11222
beq_then.11221:
	addi	r1, r0, 1
beq_cont.11222:
	add	r2, r0, r1
	add	r1, r0, r16
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	vecunit_sgn.2888				
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.11220:
	j	beq_cont.11218
beq_then.11217:
	flw	f1, 0(r16)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11223
	addi	r1, r0, 1
	j	feq_cont.11224
feq_else.11223:
	addi	r1, r0, 0
feq_cont.11224:
	beqi	0, r1, beq_then.11225
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11226
beq_then.11225:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11227
	addi	r1, r0, 1
	j	feq_cont.11228
feq_else.11227:
	addi	r1, r0, 0
feq_cont.11228:
	beqi	0, r1, beq_then.11229
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.11230
beq_then.11229:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11231
	addi	r1, r0, 0
	j	fle_cont.11232
fle_else.11231:
	addi	r1, r0, 1
fle_cont.11232:
	beqi	0, r1, beq_then.11233
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.11234
beq_then.11233:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.11234:
beq_cont.11230:
	fmul	f1, f1, f1
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.11226:
	fsw	f1, 0(r16)
	flw	f1, 1(r16)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11235
	addi	r1, r0, 1
	j	feq_cont.11236
feq_else.11235:
	addi	r1, r0, 0
feq_cont.11236:
	beqi	0, r1, beq_then.11237
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11238
beq_then.11237:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11239
	addi	r1, r0, 1
	j	feq_cont.11240
feq_else.11239:
	addi	r1, r0, 0
feq_cont.11240:
	beqi	0, r1, beq_then.11241
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.11242
beq_then.11241:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11243
	addi	r1, r0, 0
	j	fle_cont.11244
fle_else.11243:
	addi	r1, r0, 1
fle_cont.11244:
	beqi	0, r1, beq_then.11245
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.11246
beq_then.11245:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.11246:
beq_cont.11242:
	fmul	f1, f1, f1
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.11238:
	fsw	f1, 1(r16)
	flw	f1, 2(r16)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11247
	addi	r1, r0, 1
	j	feq_cont.11248
feq_else.11247:
	addi	r1, r0, 0
feq_cont.11248:
	beqi	0, r1, beq_then.11249
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11250
beq_then.11249:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11251
	addi	r1, r0, 1
	j	feq_cont.11252
feq_else.11251:
	addi	r1, r0, 0
feq_cont.11252:
	beqi	0, r1, beq_then.11253
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.11254
beq_then.11253:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11255
	addi	r1, r0, 0
	j	fle_cont.11256
fle_else.11255:
	addi	r1, r0, 1
fle_cont.11256:
	beqi	0, r1, beq_then.11257
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.11258
beq_then.11257:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.11258:
beq_cont.11254:
	fmul	f1, f1, f1
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.11250:
	fsw	f1, 2(r16)
beq_cont.11218:
	beqi	0, r12, beq_then.11259
	add	r2, r0, r7
	add	r1, r0, r16
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	rotate_quadratic_matrix.2993				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.11260
beq_then.11259:
beq_cont.11260:
	addi	r1, r0, 1
	jr	r31				#
beq_then.11210:
	addi	r1, r0, 0
	jr	r31				#
read_object.2998:
	addi	r2, r0, 60
	ble	r2, r1, ble_then.11261
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1
	beqi	0, r2, beq_then.11262
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.11263
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	beqi	0, r2, beq_then.11264
	lw	r1, 1(r3)
	addi	r1, r1, 1
	j	read_object.2998
beq_then.11264:
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r1, 1(r3)
	sw	r1, 0(r2)
	jr	r31				#
ble_then.11263:
	jr	r31				#
beq_then.11262:
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#
ble_then.11261:
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
	beqi	0, r2, beq_then.11269
	addi	r1, r0, 1
	j	read_object.2998
beq_then.11269:
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#
read_net_item.3002:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r6, r0, r1
	beqi	-1, r6, beq_then.11271
	lw	r1, 0(r3)
	addi	r7, r1, 1
	sw	r6, 1(r3)
	sw	r7, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	beqi	-1, r5, beq_then.11272
	lw	r7, 2(r3)
	addi	r2, r7, 1
	sw	r5, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3002				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r5, 3(r3)
	lw	r7, 2(r3)
	add	r30, r2, r7
	sw	r5, 0(r30)
	j	beq_cont.11273
beq_then.11272:
	lw	r7, 2(r3)
	addi	r5, r7, 1
	addi	r2, r0, -1
	sw	r2, 4(r3)
	add	r1, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
beq_cont.11273:
	lw	r1, 0(r3)
	lw	r6, 1(r3)
	add	r30, r2, r1
	sw	r6, 0(r30)
	add	r1, r0, r2
	jr	r31				#
beq_then.11271:
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
	add	r5, r0, r1
	beqi	-1, r5, beq_then.11274
	addi	r2, r0, 1
	sw	r5, 1(r3)
	add	r1, r0, r2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_net_item.3002				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r5, 1(r3)
	sw	r5, 0(r2)
	add	r6, r0, r2
	j	beq_cont.11275
beq_then.11274:
	addi	r5, r0, 1
	addi	r2, r0, -1
	sw	r6, 2(r3)
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r6, r0, r1
beq_cont.11275:
	lw	r2, 0(r6)
	beqi	-1, r2, beq_then.11276
	lw	r1, 0(r3)
	addi	r7, r1, 1
	addi	r2, r0, 0
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3002				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r5, r0, r1
	lw	r2, 0(r5)
	beqi	-1, r2, beq_then.11277
	lw	r7, 3(r3)
	addi	r2, r7, 1
	sw	r5, 4(r3)
	add	r1, r0, r2
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	read_or_network.3004				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
	lw	r5, 4(r3)
	lw	r7, 3(r3)
	add	r30, r2, r7
	sw	r5, 0(r30)
	j	beq_cont.11278
beq_then.11277:
	lw	r7, 3(r3)
	addi	r2, r7, 1
	sw	r2, 5(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1
beq_cont.11278:
	lw	r6, 2(r3)
	lw	r1, 0(r3)
	add	r30, r2, r1
	sw	r6, 0(r30)
	add	r1, r0, r2
	jr	r31				#
beq_then.11276:
	lw	r1, 0(r3)
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
	add	r5, r0, r1
	beqi	-1, r5, beq_then.11279
	addi	r2, r0, 1
	sw	r5, 1(r3)
	add	r1, r0, r2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_net_item.3002				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r5, 1(r3)
	sw	r5, 0(r2)
	j	beq_cont.11280
beq_then.11279:
	addi	r5, r0, 1
	addi	r2, r0, -1
	sw	r2, 2(r3)
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
beq_cont.11280:
	lw	r5, 0(r2)
	beqi	-1, r5, beq_then.11281
	addi	r5, r0, 672				# set min_caml_and_net
	lw	r1, 0(r3)
	add	r30, r5, r1
	sw	r2, 0(r30)
	addi	r2, r1, 1
	addi	r1, r0, 0
	sw	r2, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3002				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r5, 0(r1)
	beqi	-1, r5, beq_then.11282
	addi	r5, r0, 672				# set min_caml_and_net
	lw	r2, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	j	read_and_network.3006
beq_then.11282:
	jr	r31				#
beq_then.11281:
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
	jal	read_object.2998				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_net_item.3002				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.11285
	addi	r2, r0, 672				# set min_caml_and_net
	sw	r1, 0(r2)
	addi	r1, r0, 1
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_and_network.3006				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	beq_cont.11286
beq_then.11285:
beq_cont.11286:
	addi	r5, r0, 723				# set min_caml_or_net
	addi	r1, r0, 0
	sw	r5, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_net_item.3002				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.11287
	addi	r1, r0, 1
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_or_network.3004				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	j	beq_cont.11288
beq_then.11287:
	addi	r1, r0, 1
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.11288:
	lw	r5, 0(r3)
	sw	r1, 0(r5)
	jr	r31				#
solver_rect_surface.3010:
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.11290
	addi	r8, r0, 1
	j	feq_cont.11291
feq_else.11290:
	addi	r8, r0, 0
feq_cont.11291:
	beqi	0, r8, beq_then.11292
	addi	r1, r0, 0
	jr	r31				#
beq_then.11292:
	lw	r8, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.11293
	addi	r9, r0, 0
	j	fle_cont.11294
fle_else.11293:
	addi	r9, r0, 1
fle_cont.11294:
	beqi	0, r1, beq_then.11295
	beqi	0, r9, beq_then.11297
	addi	r1, r0, 0
	j	beq_cont.11298
beq_then.11297:
	addi	r1, r0, 1
beq_cont.11298:
	j	beq_cont.11296
beq_then.11295:
	add	r1, r0, r9
beq_cont.11296:
	add	r30, r8, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.11299
	j	beq_cont.11300
beq_then.11299:
	fneg	f4, f4
beq_cont.11300:
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
	fadd	f2, f4, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.11301
	j	fle_cont.11302
fle_else.11301:
	fneg	f2, f2
fle_cont.11302:
	fle	r30, f5, f2
	beq	r0, r30, fle_else.11303
	addi	r1, r0, 0
	jr	r31				#
fle_else.11303:
	add	r30, r8, r7
	flw	f4, 0(r30)
	add	r30, r2, r7
	flw	f2, 0(r30)
	fmul	f2, f1, f2
	fadd	f2, f2, f3
	fle	r30, f0, f2
	beq	r0, r30, fle_else.11304
	j	fle_cont.11305
fle_else.11304:
	fneg	f2, f2
fle_cont.11305:
	fle	r30, f4, f2
	beq	r0, r30, fle_else.11306
	addi	r1, r0, 0
	jr	r31				#
fle_else.11306:
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
solver_rect.3019:
	addi	r5, r0, 0
	addi	r6, r0, 1
	addi	r7, r0, 2
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r5, r0, r1
	beqi	0, r5, beq_then.11307
	addi	r1, r0, 1
	jr	r31				#
beq_then.11307:
	addi	r5, r0, 1
	addi	r6, r0, 2
	addi	r7, r0, 0
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
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
	beqi	0, r5, beq_then.11308
	addi	r1, r0, 2
	jr	r31				#
beq_then.11308:
	addi	r5, r0, 2
	addi	r6, r0, 0
	addi	r7, r0, 1
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f1
	fadd	f1, f0, f30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.11309
	addi	r1, r0, 3
	jr	r31				#
beq_then.11309:
	addi	r1, r0, 0
	jr	r31				#
solver_surface.3025:
	lw	r1, 4(r1)
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r1, 6(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	veciprod.2891				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	fadd	f4, f0, f1
	fle	r30, f4, f0
	beq	r0, r30, fle_else.11310
	addi	r2, r0, 0
	j	fle_cont.11311
fle_else.11310:
	addi	r2, r0, 1
fle_cont.11311:
	beqi	0, r2, beq_then.11312
	addi	r2, r0, 724				# set min_caml_solver_dist
	lw	r1, 6(r3)
	flw	f5, 0(r1)
	flw	f1, 4(r3)
	fmul	f5, f5, f1
	flw	f1, 1(r1)
	flw	f2, 2(r3)
	fmul	f1, f1, f2
	fadd	f2, f5, f1
	flw	f1, 2(r1)
	flw	f3, 0(r3)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	fneg	f1, f1
	finv	f31, f4
	fmul	f1, f1, f31
	fsw	f1, 0(r2)
	addi	r1, r0, 1
	jr	r31				#
beq_then.11312:
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
	beqi	0, r2, beq_then.11313
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
beq_then.11313:
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
	beqi	0, r2, beq_then.11314
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
beq_then.11314:
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
	feq	r30, f5, f0
	beq	r0, r30, feq_else.11315
	addi	r5, r0, 1
	j	feq_cont.11316
feq_else.11315:
	addi	r5, r0, 0
feq_cont.11316:
	beqi	0, r5, beq_then.11317
	addi	r1, r0, 0
	jr	r31				#
beq_then.11317:
	lw	r2, 7(r3)
	flw	f7, 0(r2)
	flw	f6, 1(r2)
	flw	f4, 2(r2)
	lw	r1, 6(r3)
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
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
	lw	r1, 6(r3)
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	fsw	f4, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	quadratic.3031				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.11318
	j	beq_cont.11319
beq_then.11318:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.11319:
	flw	f4, 10(r3)
	fmul	f2, f4, f4
	flw	f5, 8(r3)
	fmul	f1, f5, f1
	fsub	f1, f2, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11320
	addi	r2, r0, 0
	j	fle_cont.11321
fle_else.11320:
	addi	r2, r0, 1
fle_cont.11321:
	beqi	0, r2, beq_then.11322
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11323
	j	beq_cont.11324
beq_then.11323:
	fneg	f1, f1
beq_cont.11324:
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsub	f1, f1, f4
	finv	f31, f5
	fmul	f1, f1, f31
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.11322:
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
	fsub	f2, f2, f1
	flw	f3, 2(r5)
	lw	r1, 5(r6)
	flw	f1, 2(r1)
	fsub	f3, f3, f1
	lw	r1, 1(r6)
	beqi	1, r1, beq_then.11325
	beqi	2, r1, beq_then.11326
	add	r1, r0, r6
	fadd	f1, f0, f4
	j	solver_second.3044
beq_then.11326:
	lw	r1, 4(r6)
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f4, 4(r3)
	sw	r1, 6(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	veciprod.2891				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11327
	addi	r2, r0, 0
	j	fle_cont.11328
fle_else.11327:
	addi	r2, r0, 1
fle_cont.11328:
	beqi	0, r2, beq_then.11329
	addi	r2, r0, 724				# set min_caml_solver_dist
	lw	r1, 6(r3)
	flw	f5, 0(r1)
	flw	f4, 4(r3)
	fmul	f5, f5, f4
	flw	f4, 1(r1)
	flw	f2, 2(r3)
	fmul	f2, f4, f2
	fadd	f4, f5, f2
	flw	f2, 2(r1)
	flw	f3, 0(r3)
	fmul	f2, f2, f3
	fadd	f2, f4, f2
	fneg	f2, f2
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 0(r2)
	addi	r1, r0, 1
	jr	r31				#
beq_then.11329:
	addi	r1, r0, 0
	jr	r31				#
beq_then.11325:
	add	r1, r0, r6
	fadd	f1, f0, f4
	j	solver_rect.3019
solver_rect_fast.3054:
	flw	f4, 0(r5)
	fsub	f5, f4, f1
	flw	f4, 1(r5)
	fmul	f4, f5, f4
	lw	r6, 4(r1)
	flw	f6, 1(r6)
	flw	f5, 1(r2)
	fmul	f5, f4, f5
	fadd	f5, f5, f2
	fle	r30, f0, f5
	beq	r0, r30, fle_else.11330
	j	fle_cont.11331
fle_else.11330:
	fneg	f5, f5
fle_cont.11331:
	fle	r30, f6, f5
	beq	r0, r30, fle_else.11332
	addi	r6, r0, 0
	j	fle_cont.11333
fle_else.11332:
	lw	r6, 4(r1)
	flw	f6, 2(r6)
	flw	f5, 2(r2)
	fmul	f5, f4, f5
	fadd	f5, f5, f3
	fle	r30, f0, f5
	beq	r0, r30, fle_else.11334
	j	fle_cont.11335
fle_else.11334:
	fneg	f5, f5
fle_cont.11335:
	fle	r30, f6, f5
	beq	r0, r30, fle_else.11336
	addi	r6, r0, 0
	j	fle_cont.11337
fle_else.11336:
	flw	f5, 1(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.11338
	addi	r6, r0, 1
	j	feq_cont.11339
feq_else.11338:
	addi	r6, r0, 0
feq_cont.11339:
	beqi	0, r6, beq_then.11340
	addi	r6, r0, 0
	j	beq_cont.11341
beq_then.11340:
	addi	r6, r0, 1
beq_cont.11341:
fle_cont.11337:
fle_cont.11333:
	beqi	0, r6, beq_then.11342
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsw	f4, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.11342:
	flw	f4, 2(r5)
	fsub	f5, f4, f2
	flw	f4, 3(r5)
	fmul	f4, f5, f4
	lw	r6, 4(r1)
	flw	f6, 0(r6)
	flw	f5, 0(r2)
	fmul	f5, f4, f5
	fadd	f5, f5, f1
	fle	r30, f0, f5
	beq	r0, r30, fle_else.11343
	j	fle_cont.11344
fle_else.11343:
	fneg	f5, f5
fle_cont.11344:
	fle	r30, f6, f5
	beq	r0, r30, fle_else.11345
	addi	r6, r0, 0
	j	fle_cont.11346
fle_else.11345:
	lw	r6, 4(r1)
	flw	f6, 2(r6)
	flw	f5, 2(r2)
	fmul	f5, f4, f5
	fadd	f5, f5, f3
	fle	r30, f0, f5
	beq	r0, r30, fle_else.11347
	j	fle_cont.11348
fle_else.11347:
	fneg	f5, f5
fle_cont.11348:
	fle	r30, f6, f5
	beq	r0, r30, fle_else.11349
	addi	r6, r0, 0
	j	fle_cont.11350
fle_else.11349:
	flw	f5, 3(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.11351
	addi	r6, r0, 1
	j	feq_cont.11352
feq_else.11351:
	addi	r6, r0, 0
feq_cont.11352:
	beqi	0, r6, beq_then.11353
	addi	r6, r0, 0
	j	beq_cont.11354
beq_then.11353:
	addi	r6, r0, 1
beq_cont.11354:
fle_cont.11350:
fle_cont.11346:
	beqi	0, r6, beq_then.11355
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsw	f4, 0(r1)
	addi	r1, r0, 2
	jr	r31				#
beq_then.11355:
	flw	f4, 4(r5)
	fsub	f4, f4, f3
	flw	f3, 5(r5)
	fmul	f3, f4, f3
	lw	r6, 4(r1)
	flw	f5, 0(r6)
	flw	f4, 0(r2)
	fmul	f4, f3, f4
	fadd	f1, f4, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11356
	j	fle_cont.11357
fle_else.11356:
	fneg	f1, f1
fle_cont.11357:
	fle	r30, f5, f1
	beq	r0, r30, fle_else.11358
	addi	r1, r0, 0
	j	fle_cont.11359
fle_else.11358:
	lw	r1, 4(r1)
	flw	f4, 1(r1)
	flw	f1, 1(r2)
	fmul	f1, f3, f1
	fadd	f1, f1, f2
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11360
	j	fle_cont.11361
fle_else.11360:
	fneg	f1, f1
fle_cont.11361:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11362
	addi	r1, r0, 0
	j	fle_cont.11363
fle_else.11362:
	flw	f1, 5(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11364
	addi	r1, r0, 1
	j	feq_cont.11365
feq_else.11364:
	addi	r1, r0, 0
feq_cont.11365:
	beqi	0, r1, beq_then.11366
	addi	r1, r0, 0
	j	beq_cont.11367
beq_then.11366:
	addi	r1, r0, 1
beq_cont.11367:
fle_cont.11363:
fle_cont.11359:
	beqi	0, r1, beq_then.11368
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsw	f3, 0(r1)
	addi	r1, r0, 3
	jr	r31				#
beq_then.11368:
	addi	r1, r0, 0
	jr	r31				#
solver_surface_fast.3061:
	flw	f4, 0(r2)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.11369
	addi	r1, r0, 0
	j	fle_cont.11370
fle_else.11369:
	addi	r1, r0, 1
fle_cont.11370:
	beqi	0, r1, beq_then.11371
	addi	r1, r0, 724				# set min_caml_solver_dist
	flw	f4, 1(r2)
	fmul	f4, f4, f1
	flw	f1, 2(r2)
	fmul	f1, f1, f2
	fadd	f2, f4, f1
	flw	f1, 3(r2)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.11371:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3067:
	flw	f5, 0(r2)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.11372
	addi	r5, r0, 1
	j	feq_cont.11373
feq_else.11372:
	addi	r5, r0, 0
feq_cont.11373:
	beqi	0, r5, beq_then.11374
	addi	r1, r0, 0
	jr	r31				#
beq_then.11374:
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
	lw	r1, 4(r3)
	lw	r5, 1(r1)
	beqi	3, r5, beq_then.11375
	j	beq_cont.11376
beq_then.11375:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.11376:
	flw	f4, 0(r3)
	fmul	f2, f4, f4
	flw	f5, 2(r3)
	fmul	f1, f5, f1
	fsub	f1, f2, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11377
	addi	r5, r0, 0
	j	fle_cont.11378
fle_else.11377:
	addi	r5, r0, 1
fle_cont.11378:
	beqi	0, r5, beq_then.11379
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11380
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsqrt	f1, f1
	fadd	f2, f4, f1
	lw	r2, 5(r3)
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	j	beq_cont.11381
beq_then.11380:
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsqrt	f1, f1
	fsub	f2, f4, f1
	lw	r2, 5(r3)
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
beq_cont.11381:
	addi	r1, r0, 1
	jr	r31				#
beq_then.11379:
	addi	r1, r0, 0
	jr	r31				#
solver_fast.3073:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r1
	lw	r7, 0(r30)
	flw	f2, 0(r5)
	lw	r6, 5(r7)
	flw	f1, 0(r6)
	fsub	f1, f2, f1
	flw	f3, 1(r5)
	lw	r6, 5(r7)
	flw	f2, 1(r6)
	fsub	f2, f3, f2
	flw	f4, 2(r5)
	lw	r5, 5(r7)
	flw	f3, 2(r5)
	fsub	f3, f4, f3
	lw	r5, 1(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r1, 1(r7)
	beqi	1, r1, beq_then.11382
	beqi	2, r1, beq_then.11383
	add	r2, r0, r5
	add	r1, r0, r7
	j	solver_second_fast.3067
beq_then.11383:
	add	r2, r0, r5
	add	r1, r0, r7
	j	solver_surface_fast.3061
beq_then.11382:
	lw	r2, 0(r2)
	add	r1, r0, r7
	j	solver_rect_fast.3054
solver_surface_fast2.3077:
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11384
	addi	r1, r0, 0
	j	fle_cont.11385
fle_else.11384:
	addi	r1, r0, 1
fle_cont.11385:
	beqi	0, r1, beq_then.11386
	addi	r1, r0, 724				# set min_caml_solver_dist
	flw	f2, 0(r2)
	flw	f1, 3(r5)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.11386:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3084:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.11387
	addi	r6, r0, 1
	j	feq_cont.11388
feq_else.11387:
	addi	r6, r0, 0
feq_cont.11388:
	beqi	0, r6, beq_then.11389
	addi	r1, r0, 0
	jr	r31				#
beq_then.11389:
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
	beq	r0, r30, fle_else.11390
	addi	r5, r0, 0
	j	fle_cont.11391
fle_else.11390:
	addi	r5, r0, 1
fle_cont.11391:
	beqi	0, r5, beq_then.11392
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11393
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsqrt	f2, f2
	fadd	f2, f1, f2
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	j	beq_cont.11394
beq_then.11393:
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsqrt	f2, f2
	fsub	f2, f1, f2
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
beq_cont.11394:
	addi	r1, r0, 1
	jr	r31				#
beq_then.11392:
	addi	r1, r0, 0
	jr	r31				#
solver_fast2.3091:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r1
	lw	r7, 0(r30)
	lw	r5, 10(r7)
	flw	f1, 0(r5)
	flw	f2, 1(r5)
	flw	f3, 2(r5)
	lw	r6, 1(r2)
	add	r30, r6, r1
	lw	r6, 0(r30)
	lw	r1, 1(r7)
	beqi	1, r1, beq_then.11395
	beqi	2, r1, beq_then.11396
	add	r2, r0, r6
	add	r1, r0, r7
	j	solver_second_fast2.3084
beq_then.11396:
	flw	f1, 0(r6)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11397
	addi	r1, r0, 0
	j	fle_cont.11398
fle_else.11397:
	addi	r1, r0, 1
fle_cont.11398:
	beqi	0, r1, beq_then.11399
	addi	r1, r0, 724				# set min_caml_solver_dist
	flw	f2, 0(r6)
	flw	f1, 3(r5)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.11399:
	addi	r1, r0, 0
	jr	r31				#
beq_then.11395:
	lw	r2, 0(r2)
	add	r5, r0, r6
	add	r1, r0, r7
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
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11400
	addi	r5, r0, 1
	j	feq_cont.11401
feq_else.11400:
	addi	r5, r0, 0
feq_cont.11401:
	beqi	0, r5, beq_then.11402
	fsw	f0, 1(r6)
	j	beq_cont.11403
beq_then.11402:
	lw	r2, 1(r3)
	lw	r5, 6(r2)
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11404
	addi	r7, r0, 0
	j	fle_cont.11405
fle_else.11404:
	addi	r7, r0, 1
fle_cont.11405:
	beqi	0, r5, beq_then.11406
	beqi	0, r7, beq_then.11408
	addi	r7, r0, 0
	j	beq_cont.11409
beq_then.11408:
	addi	r7, r0, 1
beq_cont.11409:
	j	beq_cont.11407
beq_then.11406:
beq_cont.11407:
	lw	r5, 4(r2)
	flw	f1, 0(r5)
	beqi	0, r7, beq_then.11410
	j	beq_cont.11411
beq_then.11410:
	fneg	f1, f1
beq_cont.11411:
	fsw	f1, 0(r6)
	flup	f2, 2		# fli	f2, 1.000000
	flw	f1, 0(r1)
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 1(r6)
beq_cont.11403:
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11412
	addi	r5, r0, 1
	j	feq_cont.11413
feq_else.11412:
	addi	r5, r0, 0
feq_cont.11413:
	beqi	0, r5, beq_then.11414
	fsw	f0, 3(r6)
	j	beq_cont.11415
beq_then.11414:
	lw	r2, 1(r3)
	lw	r5, 6(r2)
	flw	f1, 1(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11416
	addi	r7, r0, 0
	j	fle_cont.11417
fle_else.11416:
	addi	r7, r0, 1
fle_cont.11417:
	beqi	0, r5, beq_then.11418
	beqi	0, r7, beq_then.11420
	addi	r7, r0, 0
	j	beq_cont.11421
beq_then.11420:
	addi	r7, r0, 1
beq_cont.11421:
	j	beq_cont.11419
beq_then.11418:
beq_cont.11419:
	lw	r5, 4(r2)
	flw	f1, 1(r5)
	beqi	0, r7, beq_then.11422
	j	beq_cont.11423
beq_then.11422:
	fneg	f1, f1
beq_cont.11423:
	fsw	f1, 2(r6)
	flup	f2, 2		# fli	f2, 1.000000
	flw	f1, 1(r1)
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 3(r6)
beq_cont.11415:
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11424
	addi	r5, r0, 1
	j	feq_cont.11425
feq_else.11424:
	addi	r5, r0, 0
feq_cont.11425:
	beqi	0, r5, beq_then.11426
	fsw	f0, 5(r6)
	j	beq_cont.11427
beq_then.11426:
	lw	r2, 1(r3)
	lw	r5, 6(r2)
	flw	f1, 2(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11428
	addi	r7, r0, 0
	j	fle_cont.11429
fle_else.11428:
	addi	r7, r0, 1
fle_cont.11429:
	beqi	0, r5, beq_then.11430
	beqi	0, r7, beq_then.11432
	addi	r5, r0, 0
	j	beq_cont.11433
beq_then.11432:
	addi	r5, r0, 1
beq_cont.11433:
	j	beq_cont.11431
beq_then.11430:
	add	r5, r0, r7
beq_cont.11431:
	lw	r2, 4(r2)
	flw	f1, 2(r2)
	beqi	0, r5, beq_then.11434
	j	beq_cont.11435
beq_then.11434:
	fneg	f1, f1
beq_cont.11435:
	fsw	f1, 4(r6)
	flup	f2, 2		# fli	f2, 1.000000
	flw	f1, 2(r1)
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 5(r6)
beq_cont.11427:
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
	flw	f2, 0(r1)
	lw	r2, 1(r3)
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
	beq	r0, r30, fle_else.11436
	addi	r1, r0, 0
	j	fle_cont.11437
fle_else.11436:
	addi	r1, r0, 1
fle_cont.11437:
	beqi	0, r1, beq_then.11438
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
	j	beq_cont.11439
beq_then.11438:
	fsw	f0, 0(r6)
beq_cont.11439:
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
	flw	f1, 0(r1)
	flw	f2, 1(r1)
	flw	f3, 2(r1)
	lw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r1, r0, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	quadratic.3031				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	fadd	f4, f0, f1
	lw	r1, 0(r3)
	flw	f2, 0(r1)
	lw	r2, 1(r3)
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
	lw	r6, 2(r3)
	fsw	f4, 0(r6)
	lw	r5, 3(r2)
	beqi	0, r5, beq_then.11440
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
	j	beq_cont.11441
beq_then.11440:
	fsw	f3, 1(r6)
	fsw	f2, 2(r6)
	fsw	f1, 3(r6)
beq_cont.11441:
	feq	r30, f4, f0
	beq	r0, r30, feq_else.11442
	addi	r1, r0, 1
	j	feq_cont.11443
feq_else.11442:
	addi	r1, r0, 0
feq_cont.11443:
	beqi	0, r1, beq_then.11444
	j	beq_cont.11445
beq_then.11444:
	flup	f1, 2		# fli	f1, 1.000000
	finv	f31, f4
	fmul	f1, f1, f31
	fsw	f1, 4(r6)
beq_cont.11445:
	add	r1, r0, r6
	jr	r31				#
iter_setup_dirvec_constants.3103:
	bgei	0, r2, bge_then.11446
	jr	r31				#
bge_then.11446:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r2
	lw	r8, 0(r30)
	lw	r7, 1(r1)
	lw	r5, 0(r1)
	lw	r6, 1(r8)
	beqi	1, r6, beq_then.11448
	beqi	2, r6, beq_then.11450
	sw	r7, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	add	r2, r0, r8
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_second_table.3100				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r7, 0(r3)
	lw	r2, 1(r3)
	add	r30, r7, r2
	sw	r5, 0(r30)
	j	beq_cont.11451
beq_then.11450:
	sw	r7, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	add	r2, r0, r8
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_surface_table.3097				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r7, 0(r3)
	lw	r2, 1(r3)
	add	r30, r7, r2
	sw	r5, 0(r30)
beq_cont.11451:
	j	beq_cont.11449
beq_then.11448:
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
	add	r30, r7, r2
	sw	r5, 0(r30)
beq_cont.11449:
	addi	r2, r2, -1
	j	iter_setup_dirvec_constants.3103
setup_dirvec_constants.3106:
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r2, 0(r2)
	addi	r2, r2, -1
	j	iter_setup_dirvec_constants.3103
setup_startp_constants.3108:
	bgei	0, r2, bge_then.11452
	jr	r31				#
bge_then.11452:
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
	beqi	2, r7, beq_then.11454
	blei	2, r7, ble_then.11456
	flw	f1, 0(r8)
	flw	f2, 1(r8)
	flw	f3, 2(r8)
	sw	r1, 0(r3)
	sw	r7, 1(r3)
	sw	r8, 2(r3)
	sw	r2, 3(r3)
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	quadratic.3031				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r7, 1(r3)
	beqi	3, r7, beq_then.11458
	j	beq_cont.11459
beq_then.11458:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.11459:
	lw	r8, 2(r3)
	fsw	f1, 3(r8)
	j	ble_cont.11457
ble_then.11456:
ble_cont.11457:
	j	beq_cont.11455
beq_then.11454:
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
beq_cont.11455:
	addi	r2, r2, -1
	j	setup_startp_constants.3108
setup_startp.3111:
	addi	r2, r0, 751				# set min_caml_startp_fast
	flw	f1, 0(r1)
	fsw	f1, 0(r2)
	flw	f1, 1(r1)
	fsw	f1, 1(r2)
	flw	f1, 2(r1)
	fsw	f1, 2(r2)
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r2, 0(r2)
	addi	r2, r2, -1
	j	setup_startp_constants.3108
is_rect_outside.3113:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11460
	j	fle_cont.11461
fle_else.11460:
	fneg	f1, f1
fle_cont.11461:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11462
	addi	r2, r0, 0
	j	fle_cont.11463
fle_else.11462:
	lw	r2, 4(r1)
	flw	f4, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.11464
	fadd	f1, f0, f2
	j	fle_cont.11465
fle_else.11464:
	fneg	f1, f2
fle_cont.11465:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11466
	addi	r2, r0, 0
	j	fle_cont.11467
fle_else.11466:
	lw	r2, 4(r1)
	flw	f2, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.11468
	fadd	f1, f0, f3
	j	fle_cont.11469
fle_else.11468:
	fneg	f1, f3
fle_cont.11469:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11470
	addi	r2, r0, 0
	j	fle_cont.11471
fle_else.11470:
	addi	r2, r0, 1
fle_cont.11471:
fle_cont.11467:
fle_cont.11463:
	beqi	0, r2, beq_then.11472
	lw	r1, 6(r1)
	jr	r31				#
beq_then.11472:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11473
	addi	r1, r0, 0
	jr	r31				#
beq_then.11473:
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
	beq	r0, r30, fle_else.11474
	addi	r2, r0, 0
	j	fle_cont.11475
fle_else.11474:
	addi	r2, r0, 1
fle_cont.11475:
	beqi	0, r1, beq_then.11476
	beqi	0, r2, beq_then.11478
	addi	r1, r0, 0
	j	beq_cont.11479
beq_then.11478:
	addi	r1, r0, 1
beq_cont.11479:
	j	beq_cont.11477
beq_then.11476:
	add	r1, r0, r2
beq_cont.11477:
	beqi	0, r1, beq_then.11480
	addi	r1, r0, 0
	jr	r31				#
beq_then.11480:
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
	beqi	3, r2, beq_then.11481
	j	beq_cont.11482
beq_then.11481:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.11482:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11483
	addi	r2, r0, 0
	j	fle_cont.11484
fle_else.11483:
	addi	r2, r0, 1
fle_cont.11484:
	beqi	0, r1, beq_then.11485
	beqi	0, r2, beq_then.11487
	addi	r1, r0, 0
	j	beq_cont.11488
beq_then.11487:
	addi	r1, r0, 1
beq_cont.11488:
	j	beq_cont.11486
beq_then.11485:
	add	r1, r0, r2
beq_cont.11486:
	beqi	0, r1, beq_then.11489
	addi	r1, r0, 0
	jr	r31				#
beq_then.11489:
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
	beqi	1, r2, beq_then.11490
	beqi	2, r2, beq_then.11491
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3031				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.11492
	j	beq_cont.11493
beq_then.11492:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.11493:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11494
	addi	r2, r0, 0
	j	fle_cont.11495
fle_else.11494:
	addi	r2, r0, 1
fle_cont.11495:
	beqi	0, r1, beq_then.11496
	beqi	0, r2, beq_then.11498
	addi	r1, r0, 0
	j	beq_cont.11499
beq_then.11498:
	addi	r1, r0, 1
beq_cont.11499:
	j	beq_cont.11497
beq_then.11496:
	add	r1, r0, r2
beq_cont.11497:
	beqi	0, r1, beq_then.11500
	addi	r1, r0, 0
	jr	r31				#
beq_then.11500:
	addi	r1, r0, 1
	jr	r31				#
beq_then.11491:
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
	beq	r0, r30, fle_else.11501
	addi	r2, r0, 0
	j	fle_cont.11502
fle_else.11501:
	addi	r2, r0, 1
fle_cont.11502:
	beqi	0, r1, beq_then.11503
	beqi	0, r2, beq_then.11505
	addi	r1, r0, 0
	j	beq_cont.11506
beq_then.11505:
	addi	r1, r0, 1
beq_cont.11506:
	j	beq_cont.11504
beq_then.11503:
	add	r1, r0, r2
beq_cont.11504:
	beqi	0, r1, beq_then.11507
	addi	r1, r0, 0
	jr	r31				#
beq_then.11507:
	addi	r1, r0, 1
	jr	r31				#
beq_then.11490:
	j	is_rect_outside.3113
check_all_inside.3133:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.11508
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
	beqi	1, r5, beq_then.11509
	beqi	2, r5, beq_then.11511
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	sw	r5, 8(r3)
	add	r1, r0, r6
	fadd	f3, f0, f4
	fadd	f2, f0, f5
	fadd	f1, f0, f6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	is_second_outside.3123				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r5, r0, r1
	j	beq_cont.11512
beq_then.11511:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	sw	r5, 8(r3)
	add	r1, r0, r6
	fadd	f3, f0, f4
	fadd	f2, f0, f5
	fadd	f1, f0, f6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	is_plane_outside.3118				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r5, r0, r1
beq_cont.11512:
	j	beq_cont.11510
beq_then.11509:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	sw	r5, 8(r3)
	add	r1, r0, r6
	fadd	f3, f0, f4
	fadd	f2, f0, f5
	fadd	f1, f0, f6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	is_rect_outside.3113				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r5, r0, r1
beq_cont.11510:
	beqi	0, r5, beq_then.11513
	addi	r1, r0, 0
	jr	r31				#
beq_then.11513:
	addi	r5, r1, 1
	add	r30, r2, r5
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.11514
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r1
	lw	r1, 0(r30)
	sw	r5, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	is_outside.3128				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.11515
	addi	r1, r0, 0
	jr	r31				#
beq_then.11515:
	lw	r5, 9(r3)
	addi	r1, r5, 1
	lw	r2, 7(r3)
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	j	check_all_inside.3133
beq_then.11514:
	addi	r1, r0, 1
	jr	r31				#
beq_then.11508:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3139:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.11516
	add	r30, r2, r1
	lw	r6, 0(r30)
	addi	r5, r0, 1021				# set min_caml_light_dirvec
	addi	r7, r0, 727				# set min_caml_intersection_point
	sw	r6, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	add	r5, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_fast.3073				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	addi	r7, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r7)
	beqi	0, r5, beq_then.11517
	flup	f2, 28		# fli	f2, -0.200000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11519
	addi	r5, r0, 0
	j	fle_cont.11520
fle_else.11519:
	addi	r5, r0, 1
fle_cont.11520:
	j	beq_cont.11518
beq_then.11517:
	addi	r5, r0, 0
beq_cont.11518:
	beqi	0, r5, beq_then.11521
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	addi	r5, r0, 667				# set min_caml_light
	flw	f2, 0(r5)
	fmul	f3, f2, f1
	addi	r5, r0, 727				# set min_caml_intersection_point
	flw	f2, 0(r5)
	fadd	f4, f3, f2
	addi	r5, r0, 667				# set min_caml_light
	flw	f2, 1(r5)
	fmul	f3, f2, f1
	addi	r5, r0, 727				# set min_caml_intersection_point
	flw	f2, 1(r5)
	fadd	f2, f3, f2
	addi	r5, r0, 667				# set min_caml_light
	flw	f3, 2(r5)
	fmul	f3, f3, f1
	addi	r5, r0, 727				# set min_caml_intersection_point
	flw	f1, 2(r5)
	fadd	f3, f3, f1
	lw	r2, 2(r3)
	lw	r5, 0(r2)
	beqi	-1, r5, beq_then.11522
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r5, 0(r30)
	fsw	f3, 4(r3)
	fsw	f2, 6(r3)
	fsw	f4, 8(r3)
	add	r1, r0, r5
	fadd	f1, f0, f4
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	is_outside.3128				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r5, r0, r1
	beqi	0, r5, beq_then.11525
	addi	r5, r0, 0
	j	beq_cont.11526
beq_then.11525:
	addi	r5, r0, 1
	lw	r2, 2(r3)
	flw	f3, 4(r3)
	flw	f2, 6(r3)
	flw	f4, 8(r3)
	sw	r5, 10(r3)
	add	r1, r0, r5
	fadd	f1, f0, f4
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	check_all_inside.3133				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r5, r0, r1
beq_cont.11526:
	j	beq_cont.11523
beq_then.11522:
	addi	r5, r0, 1
beq_cont.11523:
	beqi	0, r5, beq_then.11527
	addi	r1, r0, 1
	jr	r31				#
beq_then.11527:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	j	shadow_check_and_group.3139
beq_then.11521:
	addi	r5, r0, 1				# set min_caml_objects
	lw	r6, 0(r3)
	add	r30, r5, r6
	lw	r5, 0(r30)
	lw	r5, 6(r5)
	beqi	0, r5, beq_then.11528
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	j	shadow_check_and_group.3139
beq_then.11528:
	addi	r1, r0, 0
	jr	r31				#
beq_then.11516:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3142:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.11529
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
	beqi	0, r5, beq_then.11530
	addi	r1, r0, 1
	jr	r31				#
beq_then.11530:
	lw	r1, 1(r3)
	addi	r5, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r5
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.11531
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
	beqi	0, r1, beq_then.11532
	addi	r1, r0, 1
	jr	r31				#
beq_then.11532:
	lw	r5, 2(r3)
	addi	r1, r5, 1
	lw	r2, 0(r3)
	j	shadow_check_one_or_group.3142
beq_then.11531:
	addi	r1, r0, 0
	jr	r31				#
beq_then.11529:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3145:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r5, 0(r6)
	beqi	-1, r5, beq_then.11533
	addi	r7, r0, 99
	beq	r5, r7, beq_then.11534
	addi	r7, r0, 1021				# set min_caml_light_dirvec
	addi	r8, r0, 727				# set min_caml_intersection_point
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r7
	add	r1, r0, r5
	add	r5, r0, r8
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_fast.3073				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	beqi	0, r5, beq_then.11536
	flup	f2, 30		# fli	f2, -0.100000
	addi	r5, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r5)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11538
	addi	r5, r0, 0
	j	fle_cont.11539
fle_else.11538:
	lw	r6, 2(r3)
	lw	r5, 1(r6)
	beqi	-1, r5, beq_then.11540
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	beqi	0, r5, beq_then.11542
	addi	r5, r0, 1
	j	beq_cont.11543
beq_then.11542:
	addi	r5, r0, 2
	lw	r6, 2(r3)
	sw	r5, 3(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_one_or_group.3142				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r5, r0, r1
beq_cont.11543:
	j	beq_cont.11541
beq_then.11540:
	addi	r5, r0, 0
beq_cont.11541:
	beqi	0, r5, beq_then.11544
	addi	r5, r0, 1
	j	beq_cont.11545
beq_then.11544:
	addi	r5, r0, 0
beq_cont.11545:
fle_cont.11539:
	j	beq_cont.11537
beq_then.11536:
	addi	r5, r0, 0
beq_cont.11537:
	j	beq_cont.11535
beq_then.11534:
	addi	r5, r0, 1
beq_cont.11535:
	beqi	0, r5, beq_then.11546
	lw	r5, 1(r6)
	beqi	-1, r5, beq_then.11547
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r5
	lw	r5, 0(r30)
	addi	r7, r0, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r5, r0, r1
	beqi	0, r5, beq_then.11549
	addi	r5, r0, 1
	j	beq_cont.11550
beq_then.11549:
	addi	r5, r0, 2
	lw	r6, 2(r3)
	sw	r5, 4(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	shadow_check_one_or_group.3142				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r5, r0, r1
beq_cont.11550:
	j	beq_cont.11548
beq_then.11547:
	addi	r5, r0, 0
beq_cont.11548:
	beqi	0, r5, beq_then.11551
	addi	r1, r0, 1
	jr	r31				#
beq_then.11551:
	addi	r1, r1, 1
	j	shadow_check_one_or_matrix.3145
beq_then.11546:
	addi	r1, r1, 1
	j	shadow_check_one_or_matrix.3145
beq_then.11533:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3148:
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.11552
	addi	r6, r0, 748				# set min_caml_startp
	sw	r7, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	add	r5, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver.3050				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r6, r0, r1
	beqi	0, r6, beq_then.11553
	addi	r8, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r8)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11554
	j	fle_cont.11555
fle_else.11554:
	addi	r8, r0, 726				# set min_caml_tmin
	flw	f2, 0(r8)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11556
	j	fle_cont.11557
fle_else.11556:
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	lw	r5, 2(r3)
	flw	f2, 0(r5)
	fmul	f3, f2, f1
	addi	r8, r0, 748				# set min_caml_startp
	flw	f2, 0(r8)
	fadd	f4, f3, f2
	flw	f2, 1(r5)
	fmul	f3, f2, f1
	addi	r8, r0, 748				# set min_caml_startp
	flw	f2, 1(r8)
	fadd	f2, f3, f2
	flw	f3, 2(r5)
	fmul	f5, f3, f1
	addi	r8, r0, 748				# set min_caml_startp
	flw	f3, 2(r8)
	fadd	f3, f5, f3
	lw	r2, 3(r3)
	lw	r8, 0(r2)
	beqi	-1, r8, beq_then.11558
	addi	r9, r0, 1				# set min_caml_objects
	add	r30, r9, r8
	lw	r8, 0(r30)
	fsw	f1, 4(r3)
	fsw	f3, 6(r3)
	fsw	f2, 8(r3)
	fsw	f4, 10(r3)
	sw	r6, 12(r3)
	add	r1, r0, r8
	fadd	f1, f0, f4
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	is_outside.3128				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r8, r0, r1
	beqi	0, r8, beq_then.11560
	addi	r8, r0, 0
	j	beq_cont.11561
beq_then.11560:
	addi	r8, r0, 1
	lw	r2, 3(r3)
	flw	f3, 6(r3)
	flw	f2, 8(r3)
	flw	f4, 10(r3)
	sw	r8, 13(r3)
	add	r1, r0, r8
	fadd	f1, f0, f4
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	check_all_inside.3133				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r8, r0, r1
beq_cont.11561:
	j	beq_cont.11559
beq_then.11558:
	addi	r8, r0, 1
beq_cont.11559:
	beqi	0, r8, beq_then.11562
	addi	r8, r0, 726				# set min_caml_tmin
	fsw	f1, 0(r8)
	addi	r8, r0, 727				# set min_caml_intersection_point
	fsw	f4, 0(r8)
	fsw	f2, 1(r8)
	fsw	f3, 2(r8)
	addi	r8, r0, 730				# set min_caml_intersected_object_id
	lw	r7, 0(r3)
	sw	r7, 0(r8)
	addi	r7, r0, 725				# set min_caml_intsec_rectside
	sw	r6, 0(r7)
	j	beq_cont.11563
beq_then.11562:
beq_cont.11563:
fle_cont.11557:
fle_cont.11555:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r5, 2(r3)
	lw	r2, 3(r3)
	j	solve_each_element.3148
beq_then.11553:
	addi	r6, r0, 1				# set min_caml_objects
	lw	r7, 0(r3)
	add	r30, r6, r7
	lw	r6, 0(r30)
	lw	r6, 6(r6)
	beqi	0, r6, beq_then.11564
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r5, 2(r3)
	lw	r2, 3(r3)
	j	solve_each_element.3148
beq_then.11564:
	jr	r31				#
beq_then.11552:
	jr	r31				#
solve_one_or_network.3152:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.11567
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
	lw	r1, 1(r3)
	addi	r6, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r6
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.11568
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	lw	r5, 2(r3)
	sw	r6, 3(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element.3148				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r6, 3(r3)
	addi	r1, r6, 1
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	j	solve_one_or_network.3152
beq_then.11568:
	jr	r31				#
beq_then.11567:
	jr	r31				#
trace_or_matrix.3156:
	add	r30, r2, r1
	lw	r7, 0(r30)
	lw	r6, 0(r7)
	beqi	-1, r6, beq_then.11571
	addi	r8, r0, 99
	beq	r6, r8, beq_then.11572
	addi	r8, r0, 748				# set min_caml_startp
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r7, 2(r3)
	sw	r5, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	add	r5, r0, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver.3050				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r6, r0, r1
	beqi	0, r6, beq_then.11574
	addi	r6, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r6)
	addi	r6, r0, 726				# set min_caml_tmin
	flw	f2, 0(r6)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11576
	j	fle_cont.11577
fle_else.11576:
	lw	r7, 2(r3)
	lw	r6, 1(r7)
	beqi	-1, r6, beq_then.11578
	addi	r8, r0, 672				# set min_caml_and_net
	add	r30, r8, r6
	lw	r6, 0(r30)
	addi	r8, r0, 0
	lw	r5, 3(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element.3148				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r6, r0, 2
	lw	r7, 2(r3)
	lw	r5, 3(r3)
	add	r2, r0, r7
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network.3152				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11579
beq_then.11578:
beq_cont.11579:
fle_cont.11577:
	j	beq_cont.11575
beq_then.11574:
beq_cont.11575:
	j	beq_cont.11573
beq_then.11572:
	lw	r6, 1(r7)
	beqi	-1, r6, beq_then.11580
	addi	r8, r0, 672				# set min_caml_and_net
	add	r30, r8, r6
	lw	r6, 0(r30)
	addi	r8, r0, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r7, 2(r3)
	sw	r5, 3(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element.3148				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r6, r0, 2
	lw	r7, 2(r3)
	lw	r5, 3(r3)
	add	r2, r0, r7
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network.3152				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11581
beq_then.11580:
beq_cont.11581:
beq_cont.11573:
	addi	r1, r1, 1
	j	trace_or_matrix.3156
beq_then.11571:
	jr	r31				#
judge_intersection.3160:
	addi	r2, r0, 726				# set min_caml_tmin
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r2)
	addi	r2, r0, 0
	addi	r5, r0, 723				# set min_caml_or_net
	lw	r5, 0(r5)
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r28
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	trace_or_matrix.3156				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 726				# set min_caml_tmin
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11583
	addi	r1, r0, 0
	jr	r31				#
fle_else.11583:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11584
	addi	r1, r0, 0
	jr	r31				#
fle_else.11584:
	addi	r1, r0, 1
	jr	r31				#
solve_each_element_fast.3162:
	lw	r7, 0(r5)
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.11585
	sw	r7, 0(r3)
	sw	r8, 1(r3)
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	add	r2, r0, r5
	add	r1, r0, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_fast2.3091				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r6, r0, r1
	beqi	0, r6, beq_then.11586
	addi	r9, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r9)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11587
	j	fle_cont.11588
fle_else.11587:
	addi	r9, r0, 726				# set min_caml_tmin
	flw	f2, 0(r9)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11589
	j	fle_cont.11590
fle_else.11589:
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	lw	r7, 0(r3)
	flw	f2, 0(r7)
	fmul	f3, f2, f1
	addi	r9, r0, 751				# set min_caml_startp_fast
	flw	f2, 0(r9)
	fadd	f4, f3, f2
	flw	f2, 1(r7)
	fmul	f3, f2, f1
	addi	r9, r0, 751				# set min_caml_startp_fast
	flw	f2, 1(r9)
	fadd	f2, f3, f2
	flw	f3, 2(r7)
	fmul	f5, f3, f1
	addi	r7, r0, 751				# set min_caml_startp_fast
	flw	f3, 2(r7)
	fadd	f3, f5, f3
	lw	r2, 4(r3)
	lw	r7, 0(r2)
	beqi	-1, r7, beq_then.11591
	addi	r9, r0, 1				# set min_caml_objects
	add	r30, r9, r7
	lw	r7, 0(r30)
	fsw	f1, 6(r3)
	fsw	f3, 8(r3)
	fsw	f2, 10(r3)
	fsw	f4, 12(r3)
	sw	r6, 14(r3)
	add	r1, r0, r7
	fadd	f1, f0, f4
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	is_outside.3128				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r7, r0, r1
	beqi	0, r7, beq_then.11594
	addi	r7, r0, 0
	j	beq_cont.11595
beq_then.11594:
	addi	r7, r0, 1
	lw	r2, 4(r3)
	flw	f3, 8(r3)
	flw	f2, 10(r3)
	flw	f4, 12(r3)
	sw	r7, 15(r3)
	add	r1, r0, r7
	fadd	f1, f0, f4
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	check_all_inside.3133				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	add	r7, r0, r1
beq_cont.11595:
	j	beq_cont.11592
beq_then.11591:
	addi	r7, r0, 1
beq_cont.11592:
	beqi	0, r7, beq_then.11596
	addi	r7, r0, 726				# set min_caml_tmin
	fsw	f1, 0(r7)
	addi	r7, r0, 727				# set min_caml_intersection_point
	fsw	f4, 0(r7)
	fsw	f2, 1(r7)
	fsw	f3, 2(r7)
	addi	r7, r0, 730				# set min_caml_intersected_object_id
	lw	r8, 1(r3)
	sw	r8, 0(r7)
	addi	r7, r0, 725				# set min_caml_intsec_rectside
	sw	r6, 0(r7)
	j	beq_cont.11597
beq_then.11596:
beq_cont.11597:
fle_cont.11590:
fle_cont.11588:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r5, 3(r3)
	lw	r2, 4(r3)
	j	solve_each_element_fast.3162
beq_then.11586:
	addi	r6, r0, 1				# set min_caml_objects
	lw	r8, 1(r3)
	add	r30, r6, r8
	lw	r6, 0(r30)
	lw	r6, 6(r6)
	beqi	0, r6, beq_then.11598
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r5, 3(r3)
	lw	r2, 4(r3)
	j	solve_each_element_fast.3162
beq_then.11598:
	jr	r31				#
beq_then.11585:
	jr	r31				#
solve_one_or_network_fast.3166:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.11601
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
	lw	r1, 1(r3)
	addi	r6, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r6
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.11602
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	lw	r5, 2(r3)
	sw	r6, 3(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r6, 3(r3)
	addi	r1, r6, 1
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	j	solve_one_or_network_fast.3166
beq_then.11602:
	jr	r31				#
beq_then.11601:
	jr	r31				#
trace_or_matrix_fast.3170:
	add	r30, r2, r1
	lw	r7, 0(r30)
	lw	r6, 0(r7)
	beqi	-1, r6, beq_then.11605
	addi	r8, r0, 99
	beq	r6, r8, beq_then.11606
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r7, 2(r3)
	sw	r5, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_fast2.3091				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r6, r0, r1
	beqi	0, r6, beq_then.11608
	addi	r6, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r6)
	addi	r6, r0, 726				# set min_caml_tmin
	flw	f2, 0(r6)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11610
	j	fle_cont.11611
fle_else.11610:
	lw	r7, 2(r3)
	lw	r6, 1(r7)
	beqi	-1, r6, beq_then.11612
	addi	r8, r0, 672				# set min_caml_and_net
	add	r30, r8, r6
	lw	r6, 0(r30)
	addi	r8, r0, 0
	lw	r5, 3(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r6, r0, 2
	lw	r7, 2(r3)
	lw	r5, 3(r3)
	add	r2, r0, r7
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11613
beq_then.11612:
beq_cont.11613:
fle_cont.11611:
	j	beq_cont.11609
beq_then.11608:
beq_cont.11609:
	j	beq_cont.11607
beq_then.11606:
	lw	r6, 1(r7)
	beqi	-1, r6, beq_then.11614
	addi	r8, r0, 672				# set min_caml_and_net
	add	r30, r8, r6
	lw	r6, 0(r30)
	addi	r8, r0, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r7, 2(r3)
	sw	r5, 3(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r6, r0, 2
	lw	r7, 2(r3)
	lw	r5, 3(r3)
	add	r2, r0, r7
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11615
beq_then.11614:
beq_cont.11615:
beq_cont.11607:
	addi	r1, r1, 1
	j	trace_or_matrix_fast.3170
beq_then.11605:
	jr	r31				#
judge_intersection_fast.3174:
	addi	r2, r0, 726				# set min_caml_tmin
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r2)
	addi	r2, r0, 0
	addi	r5, r0, 723				# set min_caml_or_net
	lw	r5, 0(r5)
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r28
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	trace_or_matrix_fast.3170				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 726				# set min_caml_tmin
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11617
	addi	r1, r0, 0
	jr	r31				#
fle_else.11617:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11618
	addi	r1, r0, 0
	jr	r31				#
fle_else.11618:
	addi	r1, r0, 1
	jr	r31				#
get_nvector_rect.3176:
	addi	r2, r0, 725				# set min_caml_intsec_rectside
	lw	r2, 0(r2)
	addi	r5, r0, 731				# set min_caml_nvector
	fsw	f0, 0(r5)
	fsw	f0, 1(r5)
	fsw	f0, 2(r5)
	addi	r6, r0, 731				# set min_caml_nvector
	addi	r5, r2, -1
	addi	r2, r2, -1
	add	r30, r1, r2
	flw	f1, 0(r30)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11619
	addi	r1, r0, 1
	j	feq_cont.11620
feq_else.11619:
	addi	r1, r0, 0
feq_cont.11620:
	beqi	0, r1, beq_then.11621
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11622
beq_then.11621:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11623
	addi	r1, r0, 0
	j	fle_cont.11624
fle_else.11623:
	addi	r1, r0, 1
fle_cont.11624:
	beqi	0, r1, beq_then.11625
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.11626
beq_then.11625:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.11626:
beq_cont.11622:
	fneg	f1, f1
	add	r30, r6, r5
	fsw	f1, 0(r30)
	jr	r31				#
get_nvector_plane.3178:
	addi	r5, r0, 731				# set min_caml_nvector
	lw	r2, 4(r1)
	flw	f1, 0(r2)
	fneg	f1, f1
	fsw	f1, 0(r5)
	addi	r5, r0, 731				# set min_caml_nvector
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fneg	f1, f1
	fsw	f1, 1(r5)
	addi	r2, r0, 731				# set min_caml_nvector
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	fneg	f1, f1
	fsw	f1, 2(r2)
	jr	r31				#
get_nvector_second.3180:
	addi	r2, r0, 727				# set min_caml_intersection_point
	flw	f2, 0(r2)
	lw	r2, 5(r1)
	flw	f1, 0(r2)
	fsub	f3, f2, f1
	addi	r2, r0, 727				# set min_caml_intersection_point
	flw	f2, 1(r2)
	lw	r2, 5(r1)
	flw	f1, 1(r2)
	fsub	f2, f2, f1
	addi	r2, r0, 727				# set min_caml_intersection_point
	flw	f4, 2(r2)
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
	beqi	0, r2, beq_then.11629
	addi	r5, r0, 731				# set min_caml_nvector
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
	fsw	f6, 0(r5)
	addi	r5, r0, 731				# set min_caml_nvector
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
	fsw	f1, 1(r5)
	addi	r5, r0, 731				# set min_caml_nvector
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
	fsw	f1, 2(r5)
	j	beq_cont.11630
beq_then.11629:
	addi	r2, r0, 731				# set min_caml_nvector
	fsw	f6, 0(r2)
	addi	r2, r0, 731				# set min_caml_nvector
	fsw	f5, 1(r2)
	addi	r2, r0, 731				# set min_caml_nvector
	fsw	f4, 2(r2)
beq_cont.11630:
	addi	r5, r0, 731				# set min_caml_nvector
	lw	r2, 6(r1)
	add	r1, r0, r5
	j	vecunit_sgn.2888
get_nvector.3182:
	lw	r5, 1(r1)
	beqi	1, r5, beq_then.11631
	beqi	2, r5, beq_then.11632
	j	get_nvector_second.3180
beq_then.11632:
	addi	r5, r0, 731				# set min_caml_nvector
	lw	r2, 4(r1)
	flw	f1, 0(r2)
	fneg	f1, f1
	fsw	f1, 0(r5)
	addi	r5, r0, 731				# set min_caml_nvector
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fneg	f1, f1
	fsw	f1, 1(r5)
	addi	r2, r0, 731				# set min_caml_nvector
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	fneg	f1, f1
	fsw	f1, 2(r2)
	jr	r31				#
beq_then.11631:
	addi	r1, r0, 725				# set min_caml_intsec_rectside
	lw	r1, 0(r1)
	addi	r5, r0, 731				# set min_caml_nvector
	fsw	f0, 0(r5)
	fsw	f0, 1(r5)
	fsw	f0, 2(r5)
	addi	r6, r0, 731				# set min_caml_nvector
	addi	r5, r1, -1
	addi	r1, r1, -1
	add	r30, r2, r1
	flw	f1, 0(r30)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11634
	addi	r1, r0, 1
	j	feq_cont.11635
feq_else.11634:
	addi	r1, r0, 0
feq_cont.11635:
	beqi	0, r1, beq_then.11636
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11637
beq_then.11636:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11638
	addi	r1, r0, 0
	j	fle_cont.11639
fle_else.11638:
	addi	r1, r0, 1
fle_cont.11639:
	beqi	0, r1, beq_then.11640
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.11641
beq_then.11640:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.11641:
beq_cont.11637:
	fneg	f1, f1
	add	r30, r6, r5
	fsw	f1, 0(r30)
	jr	r31				#
utexture.3185:
	lw	r5, 0(r1)
	addi	r7, r0, 734				# set min_caml_texture_color
	lw	r6, 8(r1)
	flw	f1, 0(r6)
	fsw	f1, 0(r7)
	addi	r7, r0, 734				# set min_caml_texture_color
	lw	r6, 8(r1)
	flw	f1, 1(r6)
	fsw	f1, 1(r7)
	addi	r7, r0, 734				# set min_caml_texture_color
	lw	r6, 8(r1)
	flw	f1, 2(r6)
	fsw	f1, 2(r7)
	beqi	1, r5, beq_then.11643
	beqi	2, r5, beq_then.11644
	beqi	3, r5, beq_then.11645
	beqi	4, r5, beq_then.11646
	jr	r31				#
beq_then.11646:
	flw	f2, 0(r2)
	lw	r5, 5(r1)
	flw	f1, 0(r5)
	fsub	f2, f2, f1
	lw	r5, 4(r1)
	flw	f1, 0(r5)
	fsqrt	f1, f1
	fmul	f2, f2, f1
	flw	f3, 2(r2)
	lw	r5, 5(r1)
	flw	f1, 2(r5)
	fsub	f3, f3, f1
	lw	r5, 4(r1)
	flw	f1, 2(r5)
	fsqrt	f1, f1
	fmul	f1, f3, f1
	fmul	f4, f2, f2
	fmul	f3, f1, f1
	fadd	f3, f4, f3
	flup	f5, 33		# fli	f5, 0.000100
	fle	r30, f0, f2
	beq	r0, r30, fle_else.11648
	fadd	f4, f0, f2
	j	fle_cont.11649
fle_else.11648:
	fneg	f4, f2
fle_cont.11649:
	fle	r30, f5, f4
	beq	r0, r30, fle_else.11650
	finv	f31, f2
	fmul	f1, f1, f31
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11652
	j	fle_cont.11653
fle_else.11652:
	fneg	f1, f1
fle_cont.11653:
	fsw	f3, 0(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan.2843				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f2, f0, f1
	flup	f1, 35		# fli	f1, 30.000000
	fmul	f2, f2, f1
	flup	f1, 14		# fli	f1, 3.141593
	finv	f31, f1
	fmul	f2, f2, f31
	j	fle_cont.11651
fle_else.11650:
	flup	f2, 34		# fli	f2, 15.000000
fle_cont.11651:
	ftoi	r5, f2
	itof	f1, r5
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11654
	j	fle_cont.11655
fle_else.11654:
	flup	f4, 2		# fli	f4, 1.000000
	fsub	f1, f1, f4
fle_cont.11655:
	fsub	f2, f2, f1
	flw	f4, 1(r2)
	lw	r2, 5(r1)
	flw	f1, 1(r2)
	fsub	f4, f4, f1
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	fsqrt	f1, f1
	fmul	f1, f4, f1
	flup	f5, 33		# fli	f5, 0.000100
	fle	r30, f0, f3
	beq	r0, r30, fle_else.11656
	fadd	f4, f0, f3
	j	fle_cont.11657
fle_else.11656:
	fneg	f4, f3
fle_cont.11657:
	fle	r30, f5, f4
	beq	r0, r30, fle_else.11658
	finv	f31, f3
	fmul	f1, f1, f31
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11660
	j	fle_cont.11661
fle_else.11660:
	fneg	f1, f1
fle_cont.11661:
	fsw	f2, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	atan.2843				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	fadd	f3, f0, f1
	flup	f1, 35		# fli	f1, 30.000000
	fmul	f3, f3, f1
	flup	f1, 14		# fli	f1, 3.141593
	finv	f31, f1
	fmul	f3, f3, f31
	j	fle_cont.11659
fle_else.11658:
	flup	f3, 34		# fli	f3, 15.000000
fle_cont.11659:
	ftoi	r1, f3
	itof	f1, r1
	fle	r30, f1, f3
	beq	r0, r30, fle_else.11662
	j	fle_cont.11663
fle_else.11662:
	flup	f4, 2		# fli	f4, 1.000000
	fsub	f1, f1, f4
fle_cont.11663:
	fsub	f1, f3, f1
	flup	f4, 36		# fli	f4, 0.150000
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f2, f3, f2
	fmul	f2, f2, f2
	fsub	f3, f4, f2
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f2, f1
	fmul	f1, f1, f1
	fsub	f1, f3, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11664
	addi	r1, r0, 0
	j	fle_cont.11665
fle_else.11664:
	addi	r1, r0, 1
fle_cont.11665:
	beqi	0, r1, beq_then.11666
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11667
beq_then.11666:
beq_cont.11667:
	addi	r1, r0, 734				# set min_caml_texture_color
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f2, f1
	flup	f1, 38		# fli	f1, 0.300000
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.11645:
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
	beq	r0, r30, fle_else.11669
	j	fle_cont.11670
fle_else.11669:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f1, f1, f3
fle_cont.11670:
	fsub	f2, f2, f1
	flup	f1, 14		# fli	f1, 3.141593
	fmul	f1, f2, f1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2839				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	fmul	f1, f1, f1
	addi	r1, r0, 734				# set min_caml_texture_color
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f1, f2
	fsw	f2, 1(r1)
	addi	r1, r0, 734				# set min_caml_texture_color
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f2, f1
	flup	f1, 37		# fli	f1, 255.000000
	fmul	f1, f2, f1
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.11644:
	flw	f2, 1(r2)
	flup	f1, 40		# fli	f1, 0.250000
	fmul	f1, f2, f1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin.2837				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	fmul	f1, f1, f1
	addi	r1, r0, 734				# set min_caml_texture_color
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f2, f1
	fsw	f2, 0(r1)
	addi	r1, r0, 734				# set min_caml_texture_color
	flup	f3, 37		# fli	f3, 255.000000
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f2, f1
	fmul	f1, f3, f1
	fsw	f1, 1(r1)
	jr	r31				#
beq_then.11643:
	flw	f1, 0(r2)
	lw	r5, 5(r1)
	flw	f2, 0(r5)
	fsub	f2, f1, f2
	flup	f1, 41		# fli	f1, 0.050000
	fmul	f3, f2, f1
	ftoi	r5, f3
	itof	f1, r5
	fle	r30, f1, f3
	beq	r0, r30, fle_else.11673
	fadd	f3, f0, f1
	j	fle_cont.11674
fle_else.11673:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f3, f1, f3
fle_cont.11674:
	flup	f1, 42		# fli	f1, 20.000000
	fmul	f1, f3, f1
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f2, f1
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11675
	addi	r5, r0, 0
	j	fle_cont.11676
fle_else.11675:
	addi	r5, r0, 1
fle_cont.11676:
	flw	f2, 2(r2)
	lw	r1, 5(r1)
	flw	f1, 2(r1)
	fsub	f2, f2, f1
	flup	f1, 41		# fli	f1, 0.050000
	fmul	f3, f2, f1
	ftoi	r1, f3
	itof	f1, r1
	fle	r30, f1, f3
	beq	r0, r30, fle_else.11677
	fadd	f3, f0, f1
	j	fle_cont.11678
fle_else.11677:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f3, f1, f3
fle_cont.11678:
	flup	f1, 42		# fli	f1, 20.000000
	fmul	f1, f3, f1
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f2, f1
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11679
	addi	r1, r0, 0
	j	fle_cont.11680
fle_else.11679:
	addi	r1, r0, 1
fle_cont.11680:
	addi	r2, r0, 734				# set min_caml_texture_color
	beqi	0, r5, beq_then.11681
	beqi	0, r1, beq_then.11683
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.11684
beq_then.11683:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.11684:
	j	beq_cont.11682
beq_then.11681:
	beqi	0, r1, beq_then.11685
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11686
beq_then.11685:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.11686:
beq_cont.11682:
	fsw	f1, 1(r2)
	jr	r31				#
add_light.3188:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11688
	addi	r1, r0, 0
	j	fle_cont.11689
fle_else.11688:
	addi	r1, r0, 1
fle_cont.11689:
	beqi	0, r1, beq_then.11690
	addi	r2, r0, 740				# set min_caml_rgb
	addi	r1, r0, 734				# set min_caml_texture_color
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	vecaccum.2899				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11691
beq_then.11690:
beq_cont.11691:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.11692
	addi	r1, r0, 0
	j	fle_cont.11693
fle_else.11692:
	addi	r1, r0, 1
fle_cont.11693:
	beqi	0, r1, beq_then.11694
	fmul	f1, f2, f2
	fmul	f1, f1, f1
	fmul	f1, f1, f3
	addi	r2, r0, 740				# set min_caml_rgb
	addi	r1, r0, 740				# set min_caml_rgb
	flw	f2, 0(r1)
	fadd	f2, f2, f1
	fsw	f2, 0(r2)
	addi	r2, r0, 740				# set min_caml_rgb
	addi	r1, r0, 740				# set min_caml_rgb
	flw	f2, 1(r1)
	fadd	f2, f2, f1
	fsw	f2, 1(r2)
	addi	r2, r0, 740				# set min_caml_rgb
	addi	r1, r0, 740				# set min_caml_rgb
	flw	f2, 2(r1)
	fadd	f1, f2, f1
	fsw	f1, 2(r2)
	jr	r31				#
beq_then.11694:
	jr	r31				#
trace_reflections.3192:
	bgei	0, r1, bge_then.11697
	jr	r31				#
bge_then.11697:
	addi	r5, r0, 778				# set min_caml_reflections
	add	r30, r5, r1
	lw	r6, 0(r30)
	lw	r8, 1(r6)
	fsw	f2, 0(r3)
	fsw	f1, 2(r3)
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	add	r1, r0, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	judge_intersection_fast.3174				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r5, r0, r1
	beqi	0, r5, beq_then.11699
	addi	r5, r0, 730				# set min_caml_intersected_object_id
	lw	r5, 0(r5)
	slli	r7, r5, 2
	addi	r5, r0, 725				# set min_caml_intsec_rectside
	lw	r5, 0(r5)
	add	r5, r7, r5
	lw	r6, 4(r3)
	lw	r7, 0(r6)
	beq	r5, r7, beq_then.11701
	j	beq_cont.11702
beq_then.11701:
	addi	r5, r0, 0
	addi	r7, r0, 723				# set min_caml_or_net
	lw	r7, 0(r7)
	add	r2, r0, r7
	add	r1, r0, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	shadow_check_one_or_matrix.3145				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r5, r0, r1
	beqi	0, r5, beq_then.11703
	j	beq_cont.11704
beq_then.11703:
	addi	r7, r0, 731				# set min_caml_nvector
	lw	r8, 5(r3)
	lw	r5, 0(r8)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	veciprod.2891				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f3, f0, f1
	lw	r6, 4(r3)
	flw	f4, 2(r6)
	flw	f1, 2(r3)
	fmul	f5, f4, f1
	fmul	f5, f5, f3
	lw	r8, 5(r3)
	lw	r5, 0(r8)
	lw	r2, 7(r3)
	fsw	f4, 8(r3)
	fsw	f5, 10(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	veciprod.2891				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	fadd	f3, f0, f1
	flw	f4, 8(r3)
	fmul	f3, f4, f3
	flw	f2, 0(r3)
	flw	f5, 10(r3)
	fadd	f1, f0, f5
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f30
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	add_light.3188				
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.11704:
beq_cont.11702:
	j	beq_cont.11700
beq_then.11699:
beq_cont.11700:
	lw	r1, 6(r3)
	addi	r1, r1, -1
	lw	r2, 7(r3)
	flw	f2, 0(r3)
	flw	f1, 2(r3)
	j	trace_reflections.3192
trace_ray.3197:
	blei	4, r1, ble_then.11705
	jr	r31				#
ble_then.11705:
	lw	r10, 2(r5)
	fsw	f1, 0(r3)
	fsw	f2, 2(r3)
	sw	r5, 4(r3)
	sw	r1, 5(r3)
	sw	r10, 6(r3)
	sw	r2, 7(r3)
	add	r1, r0, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	judge_intersection.3160				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r6, r0, r1
	beqi	0, r6, beq_then.11707
	addi	r6, r0, 730				# set min_caml_intersected_object_id
	lw	r6, 0(r6)
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r9, 2(r7)
	lw	r8, 7(r7)
	flw	f3, 0(r8)
	flw	f1, 0(r3)
	fmul	f5, f3, f1
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.11708
	beqi	2, r8, beq_then.11710
	fsw	f5, 8(r3)
	sw	r6, 10(r3)
	sw	r7, 11(r3)
	sw	r9, 12(r3)
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	get_nvector_second.3180				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.11711
beq_then.11710:
	fsw	f5, 8(r3)
	sw	r6, 10(r3)
	sw	r7, 11(r3)
	sw	r9, 12(r3)
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	get_nvector_plane.3178				
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.11711:
	j	beq_cont.11709
beq_then.11708:
	lw	r2, 7(r3)
	fsw	f5, 8(r3)
	sw	r6, 10(r3)
	sw	r7, 11(r3)
	sw	r9, 12(r3)
	add	r1, r0, r2
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	get_nvector_rect.3176				
	addi	r3, r3, -14
	lw	r31, 13(r3)
beq_cont.11709:
	addi	r11, r0, 748				# set min_caml_startp
	addi	r8, r0, 727				# set min_caml_intersection_point
	flw	f3, 0(r8)
	fsw	f3, 0(r11)
	flw	f3, 1(r8)
	fsw	f3, 1(r11)
	flw	f3, 2(r8)
	fsw	f3, 2(r11)
	addi	r8, r0, 727				# set min_caml_intersection_point
	add	r2, r0, r8
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	utexture.3185				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r6, 10(r3)
	slli	r8, r6, 2
	addi	r6, r0, 725				# set min_caml_intsec_rectside
	lw	r6, 0(r6)
	add	r6, r8, r6
	lw	r1, 5(r3)
	lw	r10, 6(r3)
	add	r30, r10, r1
	sw	r6, 0(r30)
	lw	r5, 4(r3)
	lw	r6, 1(r5)
	add	r30, r6, r1
	lw	r8, 0(r30)
	addi	r6, r0, 727				# set min_caml_intersection_point
	flw	f3, 0(r6)
	fsw	f3, 0(r8)
	flw	f3, 1(r6)
	fsw	f3, 1(r8)
	flw	f3, 2(r6)
	fsw	f3, 2(r8)
	lw	r8, 3(r5)
	flup	f4, 1		# fli	f4, 0.500000
	lw	r7, 11(r3)
	lw	r6, 7(r7)
	flw	f3, 0(r6)
	fle	r30, f4, f3
	beq	r0, r30, fle_else.11712
	addi	r6, r0, 1
	add	r30, r8, r1
	sw	r6, 0(r30)
	lw	r6, 4(r5)
	add	r30, r6, r1
	lw	r11, 0(r30)
	addi	r8, r0, 734				# set min_caml_texture_color
	flw	f3, 0(r8)
	fsw	f3, 0(r11)
	flw	f3, 1(r8)
	fsw	f3, 1(r11)
	flw	f3, 2(r8)
	fsw	f3, 2(r11)
	add	r30, r6, r1
	lw	r6, 0(r30)
	flup	f3, 43		# fli	f3, 0.003906
	flw	f5, 8(r3)
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
	lw	r8, 0(r30)
	addi	r6, r0, 731				# set min_caml_nvector
	flw	f3, 0(r6)
	fsw	f3, 0(r8)
	flw	f3, 1(r6)
	fsw	f3, 1(r8)
	flw	f3, 2(r6)
	fsw	f3, 2(r8)
	j	fle_cont.11713
fle_else.11712:
	addi	r6, r0, 0
	add	r30, r8, r1
	sw	r6, 0(r30)
fle_cont.11713:
	flup	f4, 44		# fli	f4, -2.000000
	addi	r6, r0, 731				# set min_caml_nvector
	lw	r2, 7(r3)
	fsw	f4, 14(r3)
	add	r1, r0, r2
	add	r2, r0, r6
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	veciprod.2891				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	fadd	f3, f0, f1
	flw	f4, 14(r3)
	fmul	f3, f4, f3
	addi	r6, r0, 731				# set min_caml_nvector
	lw	r2, 7(r3)
	add	r1, r0, r2
	add	r2, r0, r6
	fadd	f1, f0, f3
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	vecaccum.2899				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r7, 11(r3)
	lw	r6, 7(r7)
	flw	f3, 1(r6)
	flw	f1, 0(r3)
	fmul	f3, f1, f3
	addi	r6, r0, 0
	addi	r8, r0, 723				# set min_caml_or_net
	lw	r8, 0(r8)
	fsw	f3, 16(r3)
	add	r2, r0, r8
	add	r1, r0, r6
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	shadow_check_one_or_matrix.3145				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	add	r6, r0, r1
	beqi	0, r6, beq_then.11715
	j	beq_cont.11716
beq_then.11715:
	addi	r8, r0, 731				# set min_caml_nvector
	addi	r6, r0, 667				# set min_caml_light
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	veciprod.2891				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	fadd	f4, f0, f1
	fneg	f4, f4
	flw	f5, 8(r3)
	fmul	f6, f4, f5
	addi	r6, r0, 667				# set min_caml_light
	lw	r2, 7(r3)
	fsw	f6, 18(r3)
	add	r1, r0, r2
	add	r2, r0, r6
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	veciprod.2891				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	fadd	f4, f0, f1
	fneg	f4, f4
	flw	f3, 16(r3)
	flw	f6, 18(r3)
	fadd	f2, f0, f4
	fadd	f1, f0, f6
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	add_light.3188				
	addi	r3, r3, -21
	lw	r31, 20(r3)
beq_cont.11716:
	addi	r8, r0, 727				# set min_caml_intersection_point
	addi	r6, r0, 751				# set min_caml_startp_fast
	flw	f4, 0(r8)
	fsw	f4, 0(r6)
	flw	f4, 1(r8)
	fsw	f4, 1(r6)
	flw	f4, 2(r8)
	fsw	f4, 2(r6)
	addi	r6, r0, 0				# set min_caml_n_objects
	lw	r6, 0(r6)
	addi	r6, r6, -1
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	setup_startp_constants.3108				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	addi	r6, r0, 1023				# set min_caml_n_reflections
	lw	r6, 0(r6)
	addi	r6, r6, -1
	flw	f5, 8(r3)
	lw	r2, 7(r3)
	flw	f3, 16(r3)
	add	r1, r0, r6
	fadd	f2, f0, f3
	fadd	f1, f0, f5
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	trace_reflections.3192				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flup	f3, 45		# fli	f3, 0.100000
	flw	f1, 0(r3)
	fle	r30, f1, f3
	beq	r0, r30, fle_else.11717
	jr	r31				#
fle_else.11717:
	lw	r1, 5(r3)
	bgei	4, r1, bge_then.11719
	addi	r8, r1, 1
	addi	r6, r0, -1
	lw	r10, 6(r3)
	add	r30, r10, r8
	sw	r6, 0(r30)
	j	bge_cont.11720
bge_then.11719:
bge_cont.11720:
	lw	r9, 12(r3)
	beqi	2, r9, beq_then.11721
	j	beq_cont.11722
beq_then.11721:
	flup	f4, 2		# fli	f4, 1.000000
	lw	r7, 11(r3)
	lw	r6, 7(r7)
	flw	f3, 0(r6)
	fsub	f3, f4, f3
	fmul	f1, f1, f3
	addi	r1, r1, 1
	addi	r6, r0, 726				# set min_caml_tmin
	flw	f3, 0(r6)
	flw	f2, 2(r3)
	fadd	f2, f2, f3
	lw	r5, 4(r3)
	lw	r2, 7(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	trace_ray.3197				
	addi	r3, r3, -21
	lw	r31, 20(r3)
beq_cont.11722:
	jr	r31				#
beq_then.11707:
	addi	r5, r0, -1
	lw	r1, 5(r3)
	lw	r10, 6(r3)
	add	r30, r10, r1
	sw	r5, 0(r30)
	beqi	0, r1, beq_then.11724
	addi	r1, r0, 667				# set min_caml_light
	lw	r2, 7(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	veciprod.2891				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	fadd	f2, f0, f1
	fneg	f2, f2
	fle	r30, f2, f0
	beq	r0, r30, fle_else.11725
	addi	r1, r0, 0
	j	fle_cont.11726
fle_else.11725:
	addi	r1, r0, 1
fle_cont.11726:
	beqi	0, r1, beq_then.11727
	fmul	f3, f2, f2
	fmul	f2, f3, f2
	flw	f1, 0(r3)
	fmul	f2, f2, f1
	addi	r1, r0, 670				# set min_caml_beam
	flw	f1, 0(r1)
	fmul	f1, f2, f1
	addi	r2, r0, 740				# set min_caml_rgb
	addi	r1, r0, 740				# set min_caml_rgb
	flw	f2, 0(r1)
	fadd	f2, f2, f1
	fsw	f2, 0(r2)
	addi	r2, r0, 740				# set min_caml_rgb
	addi	r1, r0, 740				# set min_caml_rgb
	flw	f2, 1(r1)
	fadd	f2, f2, f1
	fsw	f2, 1(r2)
	addi	r2, r0, 740				# set min_caml_rgb
	addi	r1, r0, 740				# set min_caml_rgb
	flw	f2, 2(r1)
	fadd	f1, f2, f1
	fsw	f1, 2(r2)
	jr	r31				#
beq_then.11727:
	jr	r31				#
beq_then.11724:
	jr	r31				#
trace_diffuse_ray.3203:
	fsw	f1, 0(r3)
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	judge_intersection_fast.3174				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	beqi	0, r2, beq_then.11731
	addi	r5, r0, 1				# set min_caml_objects
	addi	r2, r0, 730				# set min_caml_intersected_object_id
	lw	r2, 0(r2)
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r1, 2(r3)
	lw	r1, 0(r1)
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.11732
	beqi	2, r5, beq_then.11734
	sw	r2, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	get_nvector_second.3180				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11735
beq_then.11734:
	sw	r2, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	get_nvector_plane.3178				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.11735:
	j	beq_cont.11733
beq_then.11732:
	sw	r2, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	get_nvector_rect.3176				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.11733:
	addi	r1, r0, 727				# set min_caml_intersection_point
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	utexture.3185				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 0
	addi	r5, r0, 723				# set min_caml_or_net
	lw	r5, 0(r5)
	add	r2, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_one_or_matrix.3145				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.11736
	jr	r31				#
beq_then.11736:
	addi	r5, r0, 731				# set min_caml_nvector
	addi	r1, r0, 667				# set min_caml_light
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	veciprod.2891				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f2, f0, f1
	fneg	f2, f2
	fle	r30, f2, f0
	beq	r0, r30, fle_else.11738
	addi	r1, r0, 0
	j	fle_cont.11739
fle_else.11738:
	addi	r1, r0, 1
fle_cont.11739:
	beqi	0, r1, beq_then.11740
	j	beq_cont.11741
beq_then.11740:
	flup	f2, 0		# fli	f2, 0.000000
beq_cont.11741:
	addi	r5, r0, 737				# set min_caml_diffuse_ray
	flw	f1, 0(r3)
	fmul	f2, f1, f2
	lw	r2, 3(r3)
	lw	r1, 7(r2)
	flw	f1, 0(r1)
	fmul	f1, f2, f1
	addi	r2, r0, 734				# set min_caml_texture_color
	add	r1, r0, r5
	j	vecaccum.2899
beq_then.11731:
	jr	r31				#
iter_trace_diffuse_rays.3206:
	bgei	0, r6, bge_then.11743
	jr	r31				#
bge_then.11743:
	add	r30, r1, r6
	lw	r7, 0(r30)
	lw	r7, 0(r7)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	sw	r1, 3(r3)
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	veciprod.2891				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11745
	addi	r7, r0, 0
	j	fle_cont.11746
fle_else.11745:
	addi	r7, r0, 1
fle_cont.11746:
	beqi	0, r7, beq_then.11747
	lw	r6, 2(r3)
	addi	r7, r6, 1
	lw	r1, 3(r3)
	add	r30, r1, r7
	lw	r7, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	finv	f31, f2
	fmul	f1, f1, f31
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11748
beq_then.11747:
	lw	r6, 2(r3)
	lw	r1, 3(r3)
	add	r30, r1, r6
	lw	r7, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	finv	f31, f2
	fmul	f1, f1, f31
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.11748:
	lw	r6, 2(r3)
	addi	r6, r6, -2
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 3(r3)
	j	iter_trace_diffuse_rays.3206
trace_diffuse_rays.3211:
	addi	r6, r0, 751				# set min_caml_startp_fast
	flw	f1, 0(r5)
	fsw	f1, 0(r6)
	flw	f1, 1(r5)
	fsw	f1, 1(r6)
	flw	f1, 2(r5)
	fsw	f1, 2(r6)
	addi	r6, r0, 0				# set min_caml_n_objects
	lw	r6, 0(r6)
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
	addi	r6, r0, 118
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	j	iter_trace_diffuse_rays.3206
trace_diffuse_ray_80percent.3215:
	beqi	0, r1, beq_then.11749
	addi	r6, r0, 766				# set min_caml_dirvecs
	lw	r7, 0(r6)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r7, 3(r3)
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	setup_startp.3111				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r6, r0, 118
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r7, 3(r3)
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	iter_trace_diffuse_rays.3206				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11750
beq_then.11749:
beq_cont.11750:
	beqi	1, r1, beq_then.11751
	addi	r6, r0, 766				# set min_caml_dirvecs
	lw	r7, 1(r6)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r7, 4(r3)
	add	r1, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_startp.3111				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r6, r0, 118
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r7, 4(r3)
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_trace_diffuse_rays.3206				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.11752
beq_then.11751:
beq_cont.11752:
	beqi	2, r1, beq_then.11753
	addi	r6, r0, 766				# set min_caml_dirvecs
	lw	r7, 2(r6)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r7, 5(r3)
	add	r1, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_startp.3111				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r6, r0, 118
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r7, 5(r3)
	add	r1, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_trace_diffuse_rays.3206				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.11754
beq_then.11753:
beq_cont.11754:
	beqi	3, r1, beq_then.11755
	addi	r6, r0, 766				# set min_caml_dirvecs
	lw	r7, 3(r6)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r7, 6(r3)
	add	r1, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_startp.3111				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r6, r0, 118
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r7, 6(r3)
	add	r1, r0, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	iter_trace_diffuse_rays.3206				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.11756
beq_then.11755:
beq_cont.11756:
	beqi	4, r1, beq_then.11757
	addi	r1, r0, 766				# set min_caml_dirvecs
	lw	r1, 4(r1)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 7(r3)
	add	r1, r0, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_startp.3111				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	addi	r6, r0, 118
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 7(r3)
	j	iter_trace_diffuse_rays.3206
beq_then.11757:
	jr	r31				#
calc_diffuse_using_1point.3219:
	lw	r5, 5(r1)
	lw	r6, 7(r1)
	lw	r7, 1(r1)
	lw	r8, 4(r1)
	addi	r9, r0, 737				# set min_caml_diffuse_ray
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
	addi	r1, r0, 740				# set min_caml_rgb
	lw	r2, 0(r3)
	lw	r8, 1(r3)
	add	r30, r8, r2
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
	addi	r11, r0, 737				# set min_caml_diffuse_ray
	add	r30, r2, r7
	lw	r2, 0(r30)
	flw	f1, 0(r2)
	fsw	f1, 0(r11)
	flw	f1, 1(r2)
	fsw	f1, 1(r11)
	flw	f1, 2(r2)
	fsw	f1, 2(r11)
	addi	r11, r0, 737				# set min_caml_diffuse_ray
	add	r30, r8, r7
	lw	r2, 0(r30)
	sw	r1, 0(r3)
	sw	r7, 1(r3)
	sw	r9, 2(r3)
	sw	r10, 3(r3)
	sw	r6, 4(r3)
	sw	r5, 5(r3)
	add	r1, r0, r11
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecadd.2903				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r8, r0, 737				# set min_caml_diffuse_ray
	lw	r7, 1(r3)
	lw	r9, 2(r3)
	add	r30, r9, r7
	lw	r2, 0(r30)
	add	r1, r0, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecadd.2903				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r8, r0, 737				# set min_caml_diffuse_ray
	lw	r10, 3(r3)
	lw	r7, 1(r3)
	add	r30, r10, r7
	lw	r2, 0(r30)
	add	r1, r0, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecadd.2903				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r8, r0, 737				# set min_caml_diffuse_ray
	lw	r6, 4(r3)
	lw	r7, 1(r3)
	add	r30, r6, r7
	lw	r2, 0(r30)
	add	r1, r0, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecadd.2903				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 0(r3)
	lw	r5, 5(r3)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 4(r1)
	addi	r6, r0, 740				# set min_caml_rgb
	lw	r7, 1(r3)
	add	r30, r1, r7
	lw	r2, 0(r30)
	addi	r5, r0, 737				# set min_caml_diffuse_ray
	add	r1, r0, r6
	j	vecaccumv.2912
do_without_neighbors.3228:
	blei	4, r2, ble_then.11759
	jr	r31				#
ble_then.11759:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.11761
	jr	r31				#
bge_then.11761:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	beqi	0, r5, beq_then.11763
	lw	r5, 5(r1)
	lw	r6, 7(r1)
	lw	r7, 1(r1)
	lw	r8, 4(r1)
	addi	r9, r0, 737				# set min_caml_diffuse_ray
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
	addi	r7, r0, 740				# set min_caml_rgb
	lw	r2, 1(r3)
	lw	r8, 2(r3)
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
	j	beq_cont.11764
beq_then.11763:
beq_cont.11764:
	addi	r5, r2, 1
	blei	4, r5, ble_then.11765
	jr	r31				#
ble_then.11765:
	lw	r2, 2(r1)
	add	r30, r2, r5
	lw	r2, 0(r30)
	bgei	0, r2, bge_then.11767
	jr	r31				#
bge_then.11767:
	lw	r2, 3(r1)
	add	r30, r2, r5
	lw	r2, 0(r30)
	beqi	0, r2, beq_then.11769
	sw	r1, 0(r3)
	sw	r5, 3(r3)
	add	r2, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	calc_diffuse_using_1point.3219				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11770
beq_then.11769:
beq_cont.11770:
	addi	r2, r5, 1
	j	do_without_neighbors.3228
neighbors_exist.3231:
	addi	r5, r0, 743				# set min_caml_image_size
	lw	r6, 1(r5)
	addi	r5, r2, 1
	ble	r6, r5, ble_then.11771
	blei	0, r2, ble_then.11772
	addi	r2, r0, 743				# set min_caml_image_size
	lw	r5, 0(r2)
	addi	r2, r1, 1
	ble	r5, r2, ble_then.11773
	blei	0, r1, ble_then.11774
	addi	r1, r0, 1
	jr	r31				#
ble_then.11774:
	addi	r1, r0, 0
	jr	r31				#
ble_then.11773:
	addi	r1, r0, 0
	jr	r31				#
ble_then.11772:
	addi	r1, r0, 0
	jr	r31				#
ble_then.11771:
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
	beq	r2, r8, beq_then.11775
	addi	r1, r0, 0
	jr	r31				#
beq_then.11775:
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.11776
	addi	r1, r0, 0
	jr	r31				#
beq_then.11776:
	addi	r2, r1, -1
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.11777
	addi	r1, r0, 0
	jr	r31				#
beq_then.11777:
	addi	r1, r1, 1
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beq	r1, r8, beq_then.11778
	addi	r1, r0, 0
	jr	r31				#
beq_then.11778:
	addi	r1, r0, 1
	jr	r31				#
try_exploit_neighbors.3244:
	add	r30, r6, r1
	lw	r9, 0(r30)
	blei	4, r8, ble_then.11779
	jr	r31				#
ble_then.11779:
	lw	r10, 2(r9)
	add	r30, r10, r8
	lw	r10, 0(r30)
	bgei	0, r10, bge_then.11781
	jr	r31				#
bge_then.11781:
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r9, 3(r3)
	sw	r8, 4(r3)
	sw	r7, 5(r3)
	sw	r6, 6(r3)
	add	r2, r0, r5
	add	r5, r0, r6
	add	r6, r0, r7
	add	r7, r0, r8
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	neighbors_are_available.3238				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r10, r0, r1
	beqi	0, r10, beq_then.11783
	lw	r9, 3(r3)
	lw	r9, 3(r9)
	lw	r8, 4(r3)
	add	r30, r9, r8
	lw	r9, 0(r30)
	beqi	0, r9, beq_then.11784
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r7, 5(r3)
	lw	r6, 6(r3)
	add	r2, r0, r5
	add	r5, r0, r6
	add	r6, r0, r7
	add	r7, r0, r8
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	calc_diffuse_using_5points.3222				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.11785
beq_then.11784:
beq_cont.11785:
	addi	r8, r8, 1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r7, 5(r3)
	lw	r6, 6(r3)
	j	try_exploit_neighbors.3244
beq_then.11783:
	lw	r1, 1(r3)
	lw	r6, 6(r3)
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r8, 4(r3)
	blei	4, r8, ble_then.11786
	jr	r31				#
ble_then.11786:
	lw	r1, 2(r2)
	add	r30, r1, r8
	lw	r1, 0(r30)
	bgei	0, r1, bge_then.11788
	jr	r31				#
bge_then.11788:
	lw	r1, 3(r2)
	add	r30, r1, r8
	lw	r1, 0(r30)
	beqi	0, r1, beq_then.11790
	sw	r2, 7(r3)
	add	r1, r0, r2
	add	r2, r0, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	calc_diffuse_using_1point.3219				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.11791
beq_then.11790:
beq_cont.11791:
	addi	r1, r8, 1
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	j	do_without_neighbors.3228
write_ppm_header.3251:
	addi	r1, r0, 80
	out	r1
	addi	r1, r0, 51
	out	r1
	addi	r1, r0, 10
	out	r1
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r1, 0(r1)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r1, 1(r1)
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
	ble	r1, r2, ble_then.11792
	addi	r1, r0, 255
	j	ble_cont.11793
ble_then.11792:
	bgei	0, r1, bge_then.11794
	addi	r1, r0, 0
	j	bge_cont.11795
bge_then.11794:
bge_cont.11795:
ble_cont.11793:
	j	print_int.2857
write_rgb.3255:
	addi	r1, r0, 740				# set min_caml_rgb
	flw	f1, 0(r1)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.11796
	addi	r1, r0, 255
	j	ble_cont.11797
ble_then.11796:
	bgei	0, r1, bge_then.11798
	addi	r1, r0, 0
	j	bge_cont.11799
bge_then.11798:
bge_cont.11799:
ble_cont.11797:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 740				# set min_caml_rgb
	flw	f1, 1(r1)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.11800
	addi	r1, r0, 255
	j	ble_cont.11801
ble_then.11800:
	bgei	0, r1, bge_then.11802
	addi	r1, r0, 0
	j	bge_cont.11803
bge_then.11802:
bge_cont.11803:
ble_cont.11801:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 740				# set min_caml_rgb
	flw	f1, 2(r1)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.11804
	addi	r1, r0, 255
	j	ble_cont.11805
ble_then.11804:
	bgei	0, r1, bge_then.11806
	addi	r1, r0, 0
	j	bge_cont.11807
bge_then.11806:
bge_cont.11807:
ble_cont.11805:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
pretrace_diffuse_rays.3257:
	blei	4, r2, ble_then.11808
	jr	r31				#
ble_then.11808:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.11810
	jr	r31				#
bge_then.11810:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	beqi	0, r5, beq_then.11812
	lw	r5, 6(r1)
	lw	r7, 0(r5)
	addi	r5, r0, 737				# set min_caml_diffuse_ray
	fsw	f0, 0(r5)
	fsw	f0, 1(r5)
	fsw	f0, 2(r5)
	lw	r5, 7(r1)
	lw	r6, 1(r1)
	addi	r8, r0, 766				# set min_caml_dirvecs
	add	r30, r8, r7
	lw	r8, 0(r30)
	add	r30, r5, r2
	lw	r7, 0(r30)
	add	r30, r6, r2
	lw	r5, 0(r30)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	sw	r8, 4(r3)
	add	r1, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_startp.3111				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r6, r0, 118
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r8, 4(r3)
	add	r2, r0, r7
	add	r1, r0, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_trace_diffuse_rays.3206				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 0(r3)
	lw	r5, 5(r1)
	lw	r2, 1(r3)
	add	r30, r5, r2
	lw	r6, 0(r30)
	addi	r5, r0, 737				# set min_caml_diffuse_ray
	flw	f1, 0(r5)
	fsw	f1, 0(r6)
	flw	f1, 1(r5)
	fsw	f1, 1(r6)
	flw	f1, 2(r5)
	fsw	f1, 2(r6)
	j	beq_cont.11813
beq_then.11812:
beq_cont.11813:
	addi	r2, r2, 1
	j	pretrace_diffuse_rays.3257
pretrace_pixels.3260:
	bgei	0, r2, bge_then.11814
	jr	r31				#
bge_then.11814:
	addi	r6, r0, 747				# set min_caml_scan_pitch
	flw	f5, 0(r6)
	addi	r6, r0, 745				# set min_caml_image_center
	lw	r6, 0(r6)
	sub	r6, r2, r6
	itof	f4, r6
	fmul	f4, f5, f4
	addi	r7, r0, 763				# set min_caml_ptrace_dirvec
	addi	r6, r0, 754				# set min_caml_screenx_dir
	flw	f5, 0(r6)
	fmul	f5, f4, f5
	fadd	f5, f5, f1
	fsw	f5, 0(r7)
	addi	r7, r0, 763				# set min_caml_ptrace_dirvec
	addi	r6, r0, 754				# set min_caml_screenx_dir
	flw	f5, 1(r6)
	fmul	f5, f4, f5
	fadd	f5, f5, f2
	fsw	f5, 1(r7)
	addi	r7, r0, 763				# set min_caml_ptrace_dirvec
	addi	r6, r0, 754				# set min_caml_screenx_dir
	flw	f5, 2(r6)
	fmul	f4, f4, f5
	fadd	f4, f4, f3
	fsw	f4, 2(r7)
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
	addi	r6, r0, 740				# set min_caml_rgb
	fsw	f0, 0(r6)
	fsw	f0, 1(r6)
	fsw	f0, 2(r6)
	addi	r7, r0, 748				# set min_caml_startp
	addi	r6, r0, 664				# set min_caml_viewpoint
	flw	f4, 0(r6)
	fsw	f4, 0(r7)
	flw	f4, 1(r6)
	fsw	f4, 1(r7)
	flw	f4, 2(r6)
	fsw	f4, 2(r7)
	addi	r7, r0, 0
	flup	f5, 2		# fli	f5, 1.000000
	addi	r8, r0, 763				# set min_caml_ptrace_dirvec
	lw	r2, 6(r3)
	lw	r1, 7(r3)
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
	lw	r2, 6(r3)
	lw	r1, 7(r3)
	add	r30, r1, r2
	lw	r6, 0(r30)
	lw	r6, 0(r6)
	addi	r7, r0, 740				# set min_caml_rgb
	flw	f4, 0(r7)
	fsw	f4, 0(r6)
	flw	f4, 1(r7)
	fsw	f4, 1(r6)
	flw	f4, 2(r7)
	fsw	f4, 2(r6)
	add	r30, r1, r2
	lw	r6, 0(r30)
	lw	r6, 6(r6)
	lw	r5, 8(r3)
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
	lw	r2, 6(r3)
	addi	r6, r2, -1
	lw	r5, 8(r3)
	addi	r2, r5, 1
	bgei	5, r2, bge_then.11816
	add	r5, r0, r2
	j	bge_cont.11817
bge_then.11816:
	addi	r5, r2, -5
bge_cont.11817:
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	lw	r1, 7(r3)
	add	r2, r0, r6
	j	pretrace_pixels.3260
pretrace_line.3267:
	addi	r6, r0, 747				# set min_caml_scan_pitch
	flw	f2, 0(r6)
	addi	r6, r0, 745				# set min_caml_image_center
	lw	r6, 1(r6)
	sub	r2, r2, r6
	itof	f1, r2
	fmul	f1, f2, f1
	addi	r2, r0, 757				# set min_caml_screeny_dir
	flw	f2, 0(r2)
	fmul	f3, f1, f2
	addi	r2, r0, 760				# set min_caml_screenz_dir
	flw	f2, 0(r2)
	fadd	f4, f3, f2
	addi	r2, r0, 757				# set min_caml_screeny_dir
	flw	f2, 1(r2)
	fmul	f3, f1, f2
	addi	r2, r0, 760				# set min_caml_screenz_dir
	flw	f2, 1(r2)
	fadd	f2, f3, f2
	addi	r2, r0, 757				# set min_caml_screeny_dir
	flw	f3, 2(r2)
	fmul	f3, f1, f3
	addi	r2, r0, 760				# set min_caml_screenz_dir
	flw	f1, 2(r2)
	fadd	f3, f3, f1
	addi	r2, r0, 743				# set min_caml_image_size
	lw	r2, 0(r2)
	addi	r2, r2, -1
	fadd	f1, f0, f4
	j	pretrace_pixels.3260
scan_pixel.3271:
	addi	r8, r0, 743				# set min_caml_image_size
	lw	r8, 0(r8)
	ble	r8, r1, ble_then.11818
	addi	r9, r0, 740				# set min_caml_rgb
	add	r30, r6, r1
	lw	r8, 0(r30)
	lw	r8, 0(r8)
	flw	f1, 0(r8)
	fsw	f1, 0(r9)
	flw	f1, 1(r8)
	fsw	f1, 1(r9)
	flw	f1, 2(r8)
	fsw	f1, 2(r9)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	sw	r6, 4(r3)
	add	r5, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	neighbors_exist.3231				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r8, r0, r1
	beqi	0, r8, beq_then.11819
	addi	r8, r0, 0
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r6, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	try_exploit_neighbors.3244				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.11820
beq_then.11819:
	lw	r1, 1(r3)
	lw	r6, 4(r3)
	add	r30, r6, r1
	lw	r9, 0(r30)
	addi	r10, r0, 0
	lw	r8, 2(r9)
	lw	r8, 0(r8)
	bgei	0, r8, bge_then.11821
	j	bge_cont.11822
bge_then.11821:
	lw	r8, 3(r9)
	lw	r8, 0(r8)
	beqi	0, r8, beq_then.11823
	sw	r9, 5(r3)
	add	r2, r0, r10
	add	r1, r0, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_diffuse_using_1point.3219				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.11824
beq_then.11823:
beq_cont.11824:
	addi	r8, r0, 1
	add	r2, r0, r8
	add	r1, r0, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	do_without_neighbors.3228				
	addi	r3, r3, -7
	lw	r31, 6(r3)
bge_cont.11822:
beq_cont.11820:
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	write_rgb.3255				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r6, 4(r3)
	j	scan_pixel.3271
ble_then.11818:
	jr	r31				#
scan_line.3277:
	addi	r8, r0, 743				# set min_caml_image_size
	lw	r8, 1(r8)
	ble	r8, r1, ble_then.11826
	addi	r8, r0, 743				# set min_caml_image_size
	lw	r8, 1(r8)
	addi	r8, r8, -1
	ble	r8, r1, ble_then.11827
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
	j	ble_cont.11828
ble_then.11827:
ble_cont.11828:
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
	add	r1, r0, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	scan_pixel.3271				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 0(r3)
	addi	r8, r1, 1
	lw	r7, 3(r3)
	addi	r1, r7, 2
	bgei	5, r1, bge_then.11829
	add	r7, r0, r1
	j	bge_cont.11830
bge_then.11829:
	addi	r7, r1, -5
bge_cont.11830:
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r5, 4(r3)
	add	r1, r0, r8
	add	r28, r0, r6
	add	r6, r0, r2
	add	r2, r0, r5
	add	r5, r0, r28
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	scan_line.3277				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	jr	r31				#
ble_then.11826:
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
	addi	r1, r0, 5
	addi	r2, r0, 0
	sw	r8, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
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
	sw	r11, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	create_float5x3array.3283				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r10, r0, r1
	sw	r10, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_float5x3array.3283				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r6, r0, r1
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
	sw	r9, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	create_float5x3array.3283				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r7, r0, r1
	add	r1, r0, r4
	addi	r4, r4, 8
	sw	r7, 7(r1)
	lw	r9, 6(r3)
	sw	r9, 6(r1)
	lw	r6, 5(r3)
	sw	r6, 5(r1)
	lw	r10, 4(r3)
	sw	r10, 4(r1)
	lw	r11, 3(r3)
	sw	r11, 3(r1)
	lw	r2, 2(r3)
	sw	r2, 2(r1)
	lw	r8, 1(r3)
	sw	r8, 1(r1)
	lw	r5, 0(r3)
	sw	r5, 0(r1)
	jr	r31				#
init_line_elements.3287:
	bgei	0, r2, bge_then.11833
	jr	r31				#
bge_then.11833:
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	create_pixel.3285				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r5, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	addi	r5, r2, -1
	bgei	0, r5, bge_then.11834
	jr	r31				#
bge_then.11834:
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	create_pixel.3285				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	add	r30, r1, r5
	sw	r2, 0(r30)
	addi	r5, r5, -1
	bgei	0, r5, bge_then.11835
	jr	r31				#
bge_then.11835:
	sw	r5, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	create_pixel.3285				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	lw	r5, 3(r3)
	add	r30, r1, r5
	sw	r2, 0(r30)
	addi	r5, r5, -1
	bgei	0, r5, bge_then.11836
	jr	r31				#
bge_then.11836:
	sw	r5, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_pixel.3285				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	lw	r5, 4(r3)
	add	r30, r1, r5
	sw	r2, 0(r30)
	addi	r2, r5, -1
	j	init_line_elements.3287
create_pixelline.3290:
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r1, 0(r1)
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	create_pixel.3285				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 743				# set min_caml_image_size
	lw	r2, 0(r2)
	addi	r5, r2, -2
	bgei	0, r5, bge_then.11837
	jr	r31				#
bge_then.11837:
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	create_pixel.3285				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	add	r30, r1, r5
	sw	r2, 0(r30)
	addi	r5, r5, -1
	bgei	0, r5, bge_then.11838
	jr	r31				#
bge_then.11838:
	sw	r5, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	create_pixel.3285				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	lw	r5, 3(r3)
	add	r30, r1, r5
	sw	r2, 0(r30)
	addi	r5, r5, -1
	bgei	0, r5, bge_then.11839
	jr	r31				#
bge_then.11839:
	sw	r5, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_pixel.3285				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	lw	r5, 4(r3)
	add	r30, r1, r5
	sw	r2, 0(r30)
	addi	r2, r5, -1
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
	fsqrt	f3, f1
	flup	f1, 2		# fli	f1, 1.000000
	finv	f31, f3
	fmul	f1, f1, f31
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan.2843				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	fsw	f1, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin.2837				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	fadd	f2, f0, f1
	flw	f1, 4(r3)
	fsw	f2, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos.2839				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	finv	f31, f1
	fmul	f1, f2, f31
	flw	f3, 2(r3)
	fmul	f1, f1, f3
	jr	r31				#
calc_dirvec.3297:
	bgei	5, r1, bge_then.11840
	fmul	f2, f2, f2
	flup	f1, 45		# fli	f1, 0.100000
	fadd	f1, f2, f1
	fsqrt	f2, f1
	flup	f1, 2		# fli	f1, 1.000000
	finv	f31, f2
	fmul	f1, f1, f31
	fsw	f4, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	sw	r5, 6(r3)
	sw	r1, 7(r3)
	sw	r2, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	atan.2843				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	flw	f3, 2(r3)
	fmul	f1, f1, f3
	fsw	f1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2837				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	fadd	f5, f0, f1
	flw	f1, 10(r3)
	fsw	f5, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	cos.2839				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f5, 12(r3)
	finv	f31, f1
	fmul	f1, f5, f31
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	lw	r1, 7(r3)
	addi	r1, r1, 1
	fmul	f5, f1, f1
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f2, f5, f2
	fsqrt	f5, f2
	flup	f2, 2		# fli	f2, 1.000000
	finv	f31, f5
	fmul	f2, f2, f31
	fsw	f1, 14(r3)
	fsw	f5, 16(r3)
	sw	r1, 18(r3)
	fadd	f1, f0, f2
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	atan.2843				
	addi	r3, r3, -20
	lw	r31, 19(r3)
	fadd	f2, f0, f1
	flw	f4, 0(r3)
	fmul	f2, f2, f4
	fsw	f2, 20(r3)
	fadd	f1, f0, f2
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	sin.2837				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	fadd	f6, f0, f1
	flw	f2, 20(r3)
	fsw	f6, 22(r3)
	fadd	f1, f0, f2
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	cos.2839				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	fadd	f2, f0, f1
	flw	f6, 22(r3)
	finv	f31, f2
	fmul	f2, f6, f31
	flw	f5, 16(r3)
	fmul	f2, f2, f5
	lw	r5, 6(r3)
	lw	r2, 8(r3)
	flw	f3, 2(r3)
	lw	r1, 18(r3)
	flw	f1, 14(r3)
	flw	f4, 0(r3)
	j	calc_dirvec.3297
bge_then.11840:
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
	bgei	0, r1, bge_then.11844
	jr	r31				#
bge_then.11844:
	itof	f3, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f3, f3, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f3, f3, f2
	addi	r6, r0, 0
	flup	f4, 0		# fli	f4, 0.000000
	flup	f2, 0		# fli	f2, 0.000000
	fsw	f1, 0(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	add	r1, r0, r6
	fadd	f30, f0, f4
	fadd	f4, f0, f1
	fadd	f1, f0, f30
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_dirvec.3297				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	itof	f3, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f3, f3, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f3, f3, f2
	addi	r7, r0, 0
	flup	f4, 0		# fli	f4, 0.000000
	flup	f2, 0		# fli	f2, 0.000000
	lw	r5, 2(r3)
	addi	r6, r5, 2
	lw	r2, 3(r3)
	flw	f1, 0(r3)
	add	r5, r0, r6
	add	r1, r0, r7
	fadd	f30, f0, f4
	fadd	f4, f0, f1
	fadd	f1, f0, f30
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_dirvec.3297				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r6, r1, -1
	lw	r2, 3(r3)
	addi	r1, r2, 1
	bgei	5, r1, bge_then.11846
	add	r2, r0, r1
	j	bge_cont.11847
bge_then.11846:
	addi	r2, r1, -5
bge_cont.11847:
	lw	r5, 2(r3)
	flw	f1, 0(r3)
	add	r1, r0, r6
	j	calc_dirvecs.3305
calc_dirvec_rows.3310:
	bgei	0, r1, bge_then.11848
	jr	r31				#
bge_then.11848:
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
	addi	r6, r1, -1
	lw	r2, 2(r3)
	addi	r1, r2, 2
	bgei	5, r1, bge_then.11850
	add	r2, r0, r1
	j	bge_cont.11851
bge_then.11850:
	addi	r2, r1, -5
bge_cont.11851:
	lw	r5, 1(r3)
	addi	r5, r5, 4
	add	r1, r0, r6
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
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r5, r0, r1
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r1)
	lw	r2, 0(r3)
	sw	r2, 0(r1)
	jr	r31				#
create_dirvec_elements.3316:
	bgei	0, r2, bge_then.11852
	jr	r31				#
bge_then.11852:
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
	addi	r6, r0, 0				# set min_caml_n_objects
	lw	r6, 0(r6)
	sw	r5, 2(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r7, r0, r1
	add	r6, r0, r4
	addi	r4, r4, 2
	sw	r7, 1(r6)
	lw	r5, 2(r3)
	sw	r5, 0(r6)
	add	r5, r0, r6
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	addi	r7, r2, -1
	bgei	0, r7, bge_then.11854
	jr	r31				#
bge_then.11854:
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
	addi	r5, r0, 0				# set min_caml_n_objects
	lw	r5, 0(r5)
	sw	r2, 4(r3)
	add	r1, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r6, r0, r1
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r6, 1(r5)
	lw	r2, 4(r3)
	sw	r2, 0(r5)
	add	r2, r0, r5
	lw	r1, 1(r3)
	lw	r7, 3(r3)
	add	r30, r1, r7
	sw	r2, 0(r30)
	addi	r2, r7, -1
	j	create_dirvec_elements.3316
create_dirvecs.3319:
	bgei	0, r1, bge_then.11856
	jr	r31				#
bge_then.11856:
	addi	r9, r0, 766				# set min_caml_dirvecs
	addi	r7, r0, 120
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	sw	r7, 1(r3)
	sw	r9, 2(r3)
	add	r1, r0, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	addi	r5, r0, 0				# set min_caml_n_objects
	lw	r5, 0(r5)
	sw	r2, 3(r3)
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r6, r0, r1
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r6, 1(r5)
	lw	r2, 3(r3)
	sw	r2, 0(r5)
	add	r2, r0, r5
	lw	r7, 1(r3)
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r9, 2(r3)
	add	r30, r9, r1
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
	addi	r5, r0, 0				# set min_caml_n_objects
	lw	r5, 0(r5)
	sw	r2, 5(r3)
	add	r1, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r6, r0, r1
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r6, 1(r5)
	lw	r2, 5(r3)
	sw	r2, 0(r5)
	add	r2, r0, r5
	lw	r7, 4(r3)
	sw	r2, 118(r7)
	addi	r2, r0, 117
	add	r1, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_dirvec_elements.3316				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 0(r3)
	addi	r6, r1, -1
	bgei	0, r6, bge_then.11858
	jr	r31				#
bge_then.11858:
	addi	r9, r0, 766				# set min_caml_dirvecs
	addi	r7, r0, 120
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r6, 6(r3)
	sw	r7, 7(r3)
	sw	r9, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_float_array				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r2, r0, r1
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r5, r0, r1
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r1)
	lw	r2, 9(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	lw	r7, 7(r3)
	add	r1, r0, r7
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r6, 6(r3)
	lw	r9, 8(r3)
	add	r30, r9, r6
	sw	r1, 0(r30)
	addi	r1, r0, 766				# set min_caml_dirvecs
	add	r30, r1, r6
	lw	r1, 0(r30)
	addi	r2, r0, 118
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	create_dirvec_elements.3316				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r6, 6(r3)
	addi	r1, r6, -1
	j	create_dirvecs.3319
init_dirvec_constants.3321:
	bgei	0, r2, bge_then.11860
	jr	r31				#
bge_then.11860:
	add	r30, r1, r2
	lw	r5, 0(r30)
	addi	r6, r0, 0				# set min_caml_n_objects
	lw	r6, 0(r6)
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
	lw	r2, 1(r3)
	addi	r5, r2, -1
	bgei	0, r5, bge_then.11862
	jr	r31				#
bge_then.11862:
	lw	r1, 0(r3)
	add	r30, r1, r5
	lw	r2, 0(r30)
	addi	r6, r0, 0				# set min_caml_n_objects
	lw	r6, 0(r6)
	addi	r6, r6, -1
	sw	r5, 2(r3)
	add	r1, r0, r2
	add	r2, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r5, 2(r3)
	addi	r2, r5, -1
	lw	r1, 0(r3)
	j	init_dirvec_constants.3321
init_vecset_constants.3324:
	bgei	0, r1, bge_then.11864
	jr	r31				#
bge_then.11864:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r2, 119(r6)
	addi	r5, r0, 0				# set min_caml_n_objects
	lw	r5, 0(r5)
	addi	r5, r5, -1
	sw	r1, 0(r3)
	sw	r6, 1(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r2, r0, 118
	lw	r6, 1(r3)
	add	r1, r0, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.11866
	jr	r31				#
bge_then.11866:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r2, r0, 119
	sw	r1, 2(r3)
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r1, r1, -1
	j	init_vecset_constants.3324
init_dirvecs.3326:
	addi	r7, r0, 766				# set min_caml_dirvecs
	addi	r6, r0, 120
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r6, 0(r3)
	sw	r7, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r1)
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	lw	r6, 0(r3)
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r7, 1(r3)
	sw	r1, 4(r7)
	addi	r1, r0, 766				# set min_caml_dirvecs
	lw	r1, 4(r1)
	addi	r2, r0, 118
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	create_dirvec_elements.3316				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	create_dirvecs.3319				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	calc_dirvec_rows.3310				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 766				# set min_caml_dirvecs
	lw	r1, 4(r1)
	addi	r2, r0, 119
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
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
	addi	r6, r0, 0				# set min_caml_n_objects
	lw	r6, 0(r6)
	sw	r5, 10(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r7, r0, r1
	add	r6, r0, r4
	addi	r4, r4, 2
	sw	r7, 1(r6)
	lw	r5, 10(r3)
	sw	r5, 0(r6)
	flw	f2, 4(r3)
	fsw	f2, 0(r5)
	flw	f3, 2(r3)
	fsw	f3, 1(r5)
	flw	f4, 0(r3)
	fsw	f4, 2(r5)
	addi	r5, r0, 0				# set min_caml_n_objects
	lw	r5, 0(r5)
	addi	r5, r5, -1
	sw	r6, 11(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	addi	r7, r0, 778				# set min_caml_reflections
	add	r5, r0, r4
	addi	r4, r4, 3
	flw	f1, 6(r3)
	fsw	f1, 2(r5)
	lw	r6, 11(r3)
	sw	r6, 1(r5)
	lw	r2, 8(r3)
	sw	r2, 0(r5)
	add	r2, r0, r5
	lw	r1, 9(r3)
	add	r30, r7, r1
	sw	r2, 0(r30)
	jr	r31				#
setup_rect_reflection.3335:
	slli	r5, r1, 2
	addi	r1, r0, 1023				# set min_caml_n_reflections
	lw	r6, 0(r1)
	flup	f2, 2		# fli	f2, 1.000000
	lw	r1, 7(r2)
	flw	f1, 0(r1)
	fsub	f4, f2, f1
	addi	r1, r0, 667				# set min_caml_light
	flw	f1, 0(r1)
	fneg	f3, f1
	addi	r1, r0, 667				# set min_caml_light
	flw	f1, 1(r1)
	fneg	f2, f1
	addi	r1, r0, 667				# set min_caml_light
	flw	f1, 2(r1)
	fneg	f1, f1
	addi	r9, r5, 1
	addi	r1, r0, 667				# set min_caml_light
	flw	f6, 0(r1)
	addi	r1, r0, 3
	flup	f5, 0		# fli	f5, 0.000000
	fsw	f1, 0(r3)
	fsw	f2, 2(r3)
	fsw	f3, 4(r3)
	fsw	f4, 6(r3)
	fsw	f6, 8(r3)
	sw	r5, 10(r3)
	sw	r6, 11(r3)
	sw	r9, 12(r3)
	fadd	f1, f0, f5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r2, r0, r1
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_array				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r7, r0, r1
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r7, 1(r1)
	lw	r2, 13(r3)
	sw	r2, 0(r1)
	add	r7, r0, r1
	flw	f6, 8(r3)
	fsw	f6, 0(r2)
	flw	f2, 2(r3)
	fsw	f2, 1(r2)
	flw	f1, 0(r3)
	fsw	f1, 2(r2)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r2, r1, -1
	sw	r7, 14(r3)
	add	r1, r0, r7
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	addi	r2, r0, 778				# set min_caml_reflections
	add	r1, r0, r4
	addi	r4, r4, 3
	flw	f4, 6(r3)
	fsw	f4, 2(r1)
	lw	r7, 14(r3)
	sw	r7, 1(r1)
	lw	r9, 12(r3)
	sw	r9, 0(r1)
	lw	r6, 11(r3)
	add	r30, r2, r6
	sw	r1, 0(r30)
	addi	r10, r6, 1
	lw	r5, 10(r3)
	addi	r9, r5, 2
	addi	r1, r0, 667				# set min_caml_light
	flw	f6, 1(r1)
	addi	r1, r0, 3
	flup	f5, 0		# fli	f5, 0.000000
	fsw	f6, 16(r3)
	sw	r9, 18(r3)
	sw	r10, 19(r3)
	fadd	f1, f0, f5
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	lib_create_float_array				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	add	r2, r0, r1
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 20(r3)
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_array				
	addi	r3, r3, -22
	lw	r31, 21(r3)
	add	r7, r0, r1
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r7, 1(r1)
	lw	r2, 20(r3)
	sw	r2, 0(r1)
	add	r7, r0, r1
	flw	f3, 4(r3)
	fsw	f3, 0(r2)
	flw	f6, 16(r3)
	fsw	f6, 1(r2)
	flw	f1, 0(r3)
	fsw	f1, 2(r2)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r2, r1, -1
	sw	r7, 21(r3)
	add	r1, r0, r7
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	addi	r2, r0, 778				# set min_caml_reflections
	add	r1, r0, r4
	addi	r4, r4, 3
	flw	f4, 6(r3)
	fsw	f4, 2(r1)
	lw	r7, 21(r3)
	sw	r7, 1(r1)
	lw	r9, 18(r3)
	sw	r9, 0(r1)
	lw	r10, 19(r3)
	add	r30, r2, r10
	sw	r1, 0(r30)
	lw	r6, 11(r3)
	addi	r9, r6, 2
	lw	r5, 10(r3)
	addi	r7, r5, 3
	addi	r1, r0, 667				# set min_caml_light
	flw	f5, 2(r1)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f5, 22(r3)
	sw	r7, 24(r3)
	sw	r9, 25(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_float_array				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	add	r2, r0, r1
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 26(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	lib_create_array				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	add	r5, r0, r1
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r1)
	lw	r2, 26(r3)
	sw	r2, 0(r1)
	add	r5, r0, r1
	flw	f3, 4(r3)
	fsw	f3, 0(r2)
	flw	f2, 2(r3)
	fsw	f2, 1(r2)
	flw	f5, 22(r3)
	fsw	f5, 2(r2)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r2, r1, -1
	sw	r5, 27(r3)
	add	r1, r0, r5
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	addi	r2, r0, 778				# set min_caml_reflections
	add	r1, r0, r4
	addi	r4, r4, 3
	flw	f4, 6(r3)
	fsw	f4, 2(r1)
	lw	r5, 27(r3)
	sw	r5, 1(r1)
	lw	r7, 24(r3)
	sw	r7, 0(r1)
	lw	r9, 25(r3)
	add	r30, r2, r9
	sw	r1, 0(r30)
	addi	r2, r0, 1023				# set min_caml_n_reflections
	lw	r6, 11(r3)
	addi	r1, r6, 3
	sw	r1, 0(r2)
	jr	r31				#
setup_surface_reflection.3338:
	slli	r1, r1, 2
	addi	r5, r1, 1
	addi	r1, r0, 1023				# set min_caml_n_reflections
	lw	r6, 0(r1)
	flup	f2, 2		# fli	f2, 1.000000
	lw	r1, 7(r2)
	flw	f1, 0(r1)
	fsub	f2, f2, f1
	addi	r7, r0, 667				# set min_caml_light
	lw	r1, 4(r2)
	fsw	f2, 0(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r6, 4(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	veciprod.2891				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	flup	f4, 3		# fli	f4, 2.000000
	lw	r2, 3(r3)
	lw	r1, 4(r2)
	flw	f3, 0(r1)
	fmul	f3, f4, f3
	fmul	f4, f3, f1
	addi	r1, r0, 667				# set min_caml_light
	flw	f3, 0(r1)
	fsub	f6, f4, f3
	flup	f4, 3		# fli	f4, 2.000000
	lw	r1, 4(r2)
	flw	f3, 1(r1)
	fmul	f3, f4, f3
	fmul	f4, f3, f1
	addi	r1, r0, 667				# set min_caml_light
	flw	f3, 1(r1)
	fsub	f5, f4, f3
	flup	f4, 3		# fli	f4, 2.000000
	lw	r1, 4(r2)
	flw	f3, 2(r1)
	fmul	f3, f4, f3
	fmul	f3, f3, f1
	addi	r1, r0, 667				# set min_caml_light
	flw	f1, 2(r1)
	fsub	f3, f3, f1
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f3, 6(r3)
	fsw	f5, 8(r3)
	fsw	f6, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_float_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r2, r0, r1
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r7, r0, r1
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r7, 1(r1)
	lw	r2, 12(r3)
	sw	r2, 0(r1)
	add	r7, r0, r1
	flw	f6, 10(r3)
	fsw	f6, 0(r2)
	flw	f5, 8(r3)
	fsw	f5, 1(r2)
	flw	f3, 6(r3)
	fsw	f3, 2(r2)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r2, r1, -1
	sw	r7, 13(r3)
	add	r1, r0, r7
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r2, r0, 778				# set min_caml_reflections
	add	r1, r0, r4
	addi	r4, r4, 3
	flw	f2, 0(r3)
	fsw	f2, 2(r1)
	lw	r7, 13(r3)
	sw	r7, 1(r1)
	lw	r5, 2(r3)
	sw	r5, 0(r1)
	lw	r6, 4(r3)
	add	r30, r2, r6
	sw	r1, 0(r30)
	addi	r2, r0, 1023				# set min_caml_n_reflections
	addi	r1, r6, 1
	sw	r1, 0(r2)
	jr	r31				#
setup_reflections.3341:
	bgei	0, r1, bge_then.11873
	jr	r31				#
bge_then.11873:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.11875
	jr	r31				#
beq_then.11875:
	flup	f2, 2		# fli	f2, 1.000000
	lw	r5, 7(r2)
	flw	f1, 0(r5)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11877
	jr	r31				#
fle_else.11877:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.11879
	beqi	2, r5, beq_then.11880
	jr	r31				#
beq_then.11880:
	j	setup_surface_reflection.3338
beq_then.11879:
	j	setup_rect_reflection.3335
rt.3343:
	addi	r5, r0, 743				# set min_caml_image_size
	sw	r1, 0(r5)
	addi	r5, r0, 743				# set min_caml_image_size
	sw	r2, 1(r5)
	addi	r6, r0, 745				# set min_caml_image_center
	srai	r5, r1, 1
	sw	r5, 0(r6)
	addi	r5, r0, 745				# set min_caml_image_center
	srai	r2, r2, 1
	sw	r2, 1(r5)
	addi	r2, r0, 747				# set min_caml_scan_pitch
	flup	f2, 49		# fli	f2, 128.000000
	itof	f1, r1
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 0(r2)
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r1, 0(r1)
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	create_pixel.3285				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 743				# set min_caml_image_size
	lw	r2, 0(r2)
	addi	r5, r2, -2
	bgei	0, r5, bge_then.11882
	add	r2, r0, r1
	j	bge_cont.11883
bge_then.11882:
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	create_pixel.3285				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	add	r30, r1, r5
	sw	r2, 0(r30)
	addi	r5, r5, -1
	bgei	0, r5, bge_then.11884
	add	r2, r0, r1
	j	bge_cont.11885
bge_then.11884:
	sw	r5, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	create_pixel.3285				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	lw	r5, 3(r3)
	add	r30, r1, r5
	sw	r2, 0(r30)
	addi	r2, r5, -1
	sw	r2, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	init_line_elements.3287				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
bge_cont.11885:
bge_cont.11883:
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r5, 0(r1)
	sw	r2, 4(r3)
	sw	r5, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_pixel.3285				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r5, 5(r3)
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r5, r0, 743				# set min_caml_image_size
	lw	r5, 0(r5)
	addi	r6, r5, -2
	bgei	0, r6, bge_then.11886
	add	r5, r0, r1
	j	bge_cont.11887
bge_then.11886:
	sw	r1, 6(r3)
	sw	r6, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	create_pixel.3285				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r5, r0, r1
	lw	r1, 6(r3)
	lw	r6, 7(r3)
	add	r30, r1, r6
	sw	r5, 0(r30)
	addi	r6, r6, -1
	bgei	0, r6, bge_then.11888
	add	r5, r0, r1
	j	bge_cont.11889
bge_then.11888:
	sw	r6, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	create_pixel.3285				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r5, r0, r1
	lw	r1, 6(r3)
	lw	r6, 8(r3)
	add	r30, r1, r6
	sw	r5, 0(r30)
	addi	r5, r6, -1
	sw	r5, 9(r3)
	add	r2, r0, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	init_line_elements.3287				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r5, r0, r1
bge_cont.11889:
bge_cont.11887:
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r6, 0(r1)
	sw	r5, 9(r3)
	sw	r6, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_pixel.3285				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r6, 10(r3)
	add	r2, r0, r1
	add	r1, r0, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r6, r0, 743				# set min_caml_image_size
	lw	r6, 0(r6)
	addi	r7, r6, -2
	bgei	0, r7, bge_then.11890
	add	r6, r0, r1
	j	bge_cont.11891
bge_then.11890:
	sw	r1, 11(r3)
	sw	r7, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	create_pixel.3285				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r6, r0, r1
	lw	r1, 11(r3)
	lw	r7, 12(r3)
	add	r30, r1, r7
	sw	r6, 0(r30)
	addi	r7, r7, -1
	bgei	0, r7, bge_then.11892
	add	r6, r0, r1
	j	bge_cont.11893
bge_then.11892:
	sw	r7, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	create_pixel.3285				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r6, r0, r1
	lw	r1, 11(r3)
	lw	r7, 13(r3)
	add	r30, r1, r7
	sw	r6, 0(r30)
	addi	r6, r7, -1
	sw	r6, 14(r3)
	add	r2, r0, r6
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	init_line_elements.3287				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r6, r0, r1
bge_cont.11893:
bge_cont.11891:
	sw	r6, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	read_screen_settings.2989				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	read_light.2991				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	addi	r1, r0, 0
	sw	r1, 15(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	read_nth_object.2996				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	add	r7, r0, r1
	beqi	0, r7, beq_then.11894
	addi	r1, r0, 1
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	read_object.2998				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	j	beq_cont.11895
beq_then.11894:
	addi	r7, r0, 0				# set min_caml_n_objects
	lw	r1, 15(r3)
	sw	r1, 0(r7)
beq_cont.11895:
	addi	r1, r0, 0
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	read_and_network.3006				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	addi	r7, r0, 723				# set min_caml_or_net
	addi	r1, r0, 0
	sw	r7, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	read_or_network.3004				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r7, 16(r3)
	sw	r1, 0(r7)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	write_ppm_header.3251				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	addi	r1, r0, 4
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_dirvecs.3319				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	addi	r8, r0, 9
	addi	r7, r0, 0
	addi	r1, r0, 0
	add	r5, r0, r1
	add	r2, r0, r7
	add	r1, r0, r8
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	calc_dirvec_rows.3310				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	addi	r1, r0, 4
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	init_vecset_constants.3324				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	addi	r1, r0, 1021				# set min_caml_light_dirvec
	lw	r1, 0(r1)
	addi	r7, r0, 667				# set min_caml_light
	flw	f1, 0(r7)
	fsw	f1, 0(r1)
	flw	f1, 1(r7)
	fsw	f1, 1(r1)
	flw	f1, 2(r7)
	fsw	f1, 2(r1)
	addi	r1, r0, 1021				# set min_caml_light_dirvec
	addi	r7, r0, 0				# set min_caml_n_objects
	lw	r7, 0(r7)
	addi	r7, r7, -1
	add	r2, r0, r7
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r1, r1, -1
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	setup_reflections.3341				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	addi	r7, r0, 0
	addi	r1, r0, 0
	lw	r5, 9(r3)
	add	r2, r0, r7
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r28
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	pretrace_line.3267				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	addi	r1, r0, 0
	addi	r7, r0, 2
	lw	r2, 4(r3)
	lw	r6, 14(r3)
	lw	r5, 9(r3)
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
