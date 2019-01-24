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
	beq	r0, r30, fle_else.16516
	addi	r1, r0, 0
	jr	r31				#
fle_else.16516:
	addi	r1, r0, 1
	jr	r31				#
fisneg.2805:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16517
	addi	r1, r0, 0
	jr	r31				#
fle_else.16517:
	addi	r1, r0, 1
	jr	r31				#
fiszero.2807:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16518
	addi	r1, r0, 1
	jr	r31				#
feq_else.16518:
	addi	r1, r0, 0
	jr	r31				#
xor.2809:
	beq	r1, r2, beq_then.16519
	addi	r1, r0, 1
	jr	r31				#
beq_then.16519:
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
	beq	r0, r30, fle_else.16520
	jr	r31				#
fle_else.16520:
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
	beq	r0, r30, fle_else.16521
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16521:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
	jr	r31				#
hoge.2824:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16522
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16523
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16524
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16525
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16526
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16527
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16528
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16529
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16530
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16531
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16532
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16533
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16534
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16535
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16536
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16537
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2824
fle_else.16537:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16536:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16535:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16534:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16533:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16532:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16531:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16530:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16529:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16528:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16527:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16526:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16525:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16524:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16523:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16522:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2827:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16538
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16539
	fsub	f4, f1, f2
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	flup	f1, 3		# fli	f1, 2.000000
	fmul	f1, f3, f1
	fle	r30, f1, f4
	beq	r0, r30, fle_else.16540
	fle	r30, f2, f4
	beq	r0, r30, fle_else.16541
	fsub	f4, f4, f2
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.16541:
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.16540:
	fadd	f1, f0, f4
	jr	r31				#
fle_else.16539:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16542
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16543
	fsub	f4, f1, f2
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.16543:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	j	fuga.2827
fle_else.16542:
	jr	r31				#
fle_else.16538:
	jr	r31				#
modulo_2pi.2831:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16544
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16546
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16548
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16550
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16552
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16554
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16556
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16558
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16560
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16562
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16564
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16566
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16568
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16570
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16572
	addi	r30, r0, 4060
	lui	r30, r30, 18505	# to load float		205887.438848
	fmvfr	f2, r30
	fsw	f1, 0(r3)
	fsw	f3, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	hoge.2824				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f2, f0, f1
	flw	f1, 0(r3)
	flw	f3, 2(r3)
	j	fle_cont.16573
fle_else.16572:
fle_cont.16573:
	j	fle_cont.16571
fle_else.16570:
fle_cont.16571:
	j	fle_cont.16569
fle_else.16568:
fle_cont.16569:
	j	fle_cont.16567
fle_else.16566:
fle_cont.16567:
	j	fle_cont.16565
fle_else.16564:
fle_cont.16565:
	j	fle_cont.16563
fle_else.16562:
fle_cont.16563:
	j	fle_cont.16561
fle_else.16560:
fle_cont.16561:
	j	fle_cont.16559
fle_else.16558:
fle_cont.16559:
	j	fle_cont.16557
fle_else.16556:
fle_cont.16557:
	j	fle_cont.16555
fle_else.16554:
fle_cont.16555:
	j	fle_cont.16553
fle_else.16552:
fle_cont.16553:
	j	fle_cont.16551
fle_else.16550:
fle_cont.16551:
	j	fle_cont.16549
fle_else.16548:
fle_cont.16549:
	j	fle_cont.16547
fle_else.16546:
fle_cont.16547:
	j	fle_cont.16545
fle_else.16544:
fle_cont.16545:
	flup	f4, 5		# fli	f4, 6.283186
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16574
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16575
	fsub	f4, f1, f2
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.16575:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	j	fuga.2827
fle_else.16574:
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
	flup	f4, 14		# fli	f4, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16576
	flup	f5, 2		# fli	f5, 1.000000
	j	fle_cont.16577
fle_else.16576:
	flup	f5, 11		# fli	f5, -1.000000
fle_cont.16577:
	fsw	f4, 0(r3)
	fsw	f5, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f6, f0, f1
	flw	f4, 0(r3)
	flw	f5, 2(r3)
	flup	f3, 14		# fli	f3, 3.141593
	flup	f1, 5		# fli	f1, 6.283186
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16578
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16580
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16582
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16584
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16586
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16588
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16590
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16592
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16594
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16596
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16598
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16600
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16602
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16604
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f1, r30
	fsw	f3, 4(r3)
	fsw	f6, 6(r3)
	fadd	f2, f0, f1
	fadd	f1, f0, f6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2824				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1
	flw	f3, 4(r3)
	flw	f4, 0(r3)
	flw	f5, 2(r3)
	flw	f6, 6(r3)
	j	fle_cont.16605
fle_else.16604:
	fadd	f2, f0, f1
fle_cont.16605:
	j	fle_cont.16603
fle_else.16602:
	fadd	f2, f0, f1
fle_cont.16603:
	j	fle_cont.16601
fle_else.16600:
	fadd	f2, f0, f1
fle_cont.16601:
	j	fle_cont.16599
fle_else.16598:
	fadd	f2, f0, f1
fle_cont.16599:
	j	fle_cont.16597
fle_else.16596:
	fadd	f2, f0, f1
fle_cont.16597:
	j	fle_cont.16595
fle_else.16594:
	fadd	f2, f0, f1
fle_cont.16595:
	j	fle_cont.16593
fle_else.16592:
	fadd	f2, f0, f1
fle_cont.16593:
	j	fle_cont.16591
fle_else.16590:
	fadd	f2, f0, f1
fle_cont.16591:
	j	fle_cont.16589
fle_else.16588:
	fadd	f2, f0, f1
fle_cont.16589:
	j	fle_cont.16587
fle_else.16586:
	fadd	f2, f0, f1
fle_cont.16587:
	j	fle_cont.16585
fle_else.16584:
	fadd	f2, f0, f1
fle_cont.16585:
	j	fle_cont.16583
fle_else.16582:
	fadd	f2, f0, f1
fle_cont.16583:
	j	fle_cont.16581
fle_else.16580:
	fadd	f2, f0, f1
fle_cont.16581:
	j	fle_cont.16579
fle_else.16578:
	fadd	f2, f0, f1
fle_cont.16579:
	fadd	f1, f0, f6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2827				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1
	flw	f4, 0(r3)
	flw	f5, 2(r3)
	fle	r30, f4, f2
	beq	r0, r30, fle_else.16606
	fsub	f2, f2, f4
	fneg	f3, f5
	flup	f1, 15		# fli	f1, 1.570796
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16607
	fsub	f2, f4, f2
	flup	f1, 16		# fli	f1, 0.785398
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16608
	fmul	f1, f2, f2
	flup	f4, 6		# fli	f4, 0.166667
	fmul	f4, f4, f2
	fmul	f4, f4, f1
	fsub	f5, f2, f4
	flup	f4, 7		# fli	f4, 0.008333
	fmul	f4, f4, f2
	fmul	f4, f4, f1
	fmul	f4, f4, f1
	fadd	f5, f5, f4
	flup	f4, 8		# fli	f4, 0.000196
	fmul	f2, f4, f2
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fmul	f1, f2, f1
	fsub	f1, f5, f1
	fmul	f1, f1, f3
	jr	r31				#
fle_else.16608:
	flup	f1, 15		# fli	f1, 1.570796
	fsub	f1, f1, f2
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
fle_else.16607:
	flup	f1, 16		# fli	f1, 0.785398
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16609
	fmul	f1, f2, f2
	flup	f4, 6		# fli	f4, 0.166667
	fmul	f4, f4, f2
	fmul	f4, f4, f1
	fsub	f5, f2, f4
	flup	f4, 7		# fli	f4, 0.008333
	fmul	f4, f4, f2
	fmul	f4, f4, f1
	fmul	f4, f4, f1
	fadd	f5, f5, f4
	flup	f4, 8		# fli	f4, 0.000196
	fmul	f2, f4, f2
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fmul	f1, f2, f1
	fsub	f1, f5, f1
	fmul	f1, f1, f3
	jr	r31				#
fle_else.16609:
	flup	f1, 15		# fli	f1, 1.570796
	fsub	f1, f1, f2
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
fle_else.16606:
	flup	f1, 15		# fli	f1, 1.570796
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16610
	fsub	f2, f4, f2
	flup	f1, 16		# fli	f1, 0.785398
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16611
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
fle_else.16611:
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
fle_else.16610:
	flup	f1, 16		# fli	f1, 0.785398
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16612
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
fle_else.16612:
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
	flup	f4, 2		# fli	f4, 1.000000
	fsw	f2, 0(r3)
	fsw	f4, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_abs_float				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f5, f0, f1
	flw	f2, 0(r3)
	flw	f4, 2(r3)
	flup	f3, 14		# fli	f3, 3.141593
	flup	f1, 5		# fli	f1, 6.283186
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16613
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16615
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16617
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16619
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16621
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16623
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16625
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16627
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16629
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16631
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16633
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16635
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16637
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16639
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f1, r30
	fsw	f3, 4(r3)
	fsw	f5, 6(r3)
	fadd	f2, f0, f1
	fadd	f1, f0, f5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2824				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f3, 4(r3)
	flw	f2, 0(r3)
	flw	f4, 2(r3)
	flw	f5, 6(r3)
	j	fle_cont.16640
fle_else.16639:
fle_cont.16640:
	j	fle_cont.16638
fle_else.16637:
fle_cont.16638:
	j	fle_cont.16636
fle_else.16635:
fle_cont.16636:
	j	fle_cont.16634
fle_else.16633:
fle_cont.16634:
	j	fle_cont.16632
fle_else.16631:
fle_cont.16632:
	j	fle_cont.16630
fle_else.16629:
fle_cont.16630:
	j	fle_cont.16628
fle_else.16627:
fle_cont.16628:
	j	fle_cont.16626
fle_else.16625:
fle_cont.16626:
	j	fle_cont.16624
fle_else.16623:
fle_cont.16624:
	j	fle_cont.16622
fle_else.16621:
fle_cont.16622:
	j	fle_cont.16620
fle_else.16619:
fle_cont.16620:
	j	fle_cont.16618
fle_else.16617:
fle_cont.16618:
	j	fle_cont.16616
fle_else.16615:
fle_cont.16616:
	j	fle_cont.16614
fle_else.16613:
fle_cont.16614:
	fadd	f2, f0, f1
	fadd	f1, f0, f5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2827				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 0(r3)
	flw	f4, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16641
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16642
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.16643
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
fle_else.16643:
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
fle_else.16642:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16644
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
fle_else.16644:
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
fle_else.16641:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16645
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.16646
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
fle_else.16646:
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
fle_else.16645:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16647
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
fle_else.16647:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f5, f2, f1
	fmul	f1, f5, f5
	flup	f2, 6		# fli	f2, 0.166667
	fmul	f2, f2, f5
	fmul	f2, f2, f1
	fsub	f3, f5, f2
	flup	f2, 7		# fli	f2, 0.008333
	fmul	f2, f2, f5
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fadd	f3, f3, f2
	flup	f2, 8		# fli	f2, 0.000196
	fmul	f2, f2, f5
	fmul	f2, f2, f1
	fmul	f2, f2, f1
	fmul	f1, f2, f1
	fsub	f1, f3, f1
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
	beq	r0, r30, fle_else.16648
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.16649
fle_else.16648:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.16649:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16650
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16651
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
fle_else.16651:
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
fle_else.16650:
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
	ble	r7, r1, ble_then.16652
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r8, r5, 3
	slli	r7, r5, 1
	add	r7, r8, r7
	ble	r7, r1, ble_then.16653
	j	div10_sub.2849
ble_then.16653:
	slli	r7, r5, 3
	slli	r2, r5, 1
	add	r2, r7, r2
	addi	r2, r2, 9
	ble	r1, r2, ble_then.16654
	add	r2, r0, r5
	add	r5, r0, r6
	j	div10_sub.2849
ble_then.16654:
	add	r1, r0, r5
	jr	r31				#
ble_then.16652:
	slli	r7, r6, 3
	slli	r2, r6, 1
	add	r2, r7, r2
	addi	r2, r2, 9
	ble	r1, r2, ble_then.16655
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r8, r2, 3
	slli	r7, r2, 1
	add	r7, r8, r7
	ble	r7, r1, ble_then.16656
	add	r5, r0, r2
	add	r2, r0, r6
	j	div10_sub.2849
ble_then.16656:
	slli	r7, r2, 3
	slli	r6, r2, 1
	add	r6, r7, r6
	addi	r6, r6, 9
	ble	r1, r6, ble_then.16657
	j	div10_sub.2849
ble_then.16657:
	add	r1, r0, r2
	jr	r31				#
ble_then.16655:
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
	bgei	10, r1, bge_then.16658
	addi	r1, r1, 48
	out	r1
	jr	r31				#
bge_then.16658:
	slli	r5, r1, 7
	slli	r2, r1, 6
	add	r5, r5, r2
	slli	r2, r1, 3
	add	r5, r5, r2
	slli	r2, r1, 2
	add	r2, r5, r2
	add	r2, r2, r1
	srli	r6, r2, 11
	bgei	10, r6, bge_then.16659
	addi	r2, r6, 48
	out	r2
	j	bge_cont.16660
bge_then.16659:
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
bge_cont.16660:
	slli	r5, r6, 3
	slli	r2, r6, 1
	add	r2, r5, r2
	sub	r1, r1, r2
	addi	r1, r1, 48
	out	r1
	jr	r31				#
print_int.2857:
	bgei	0, r1, bge_then.16661
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	j	print_int.2857
bge_then.16661:
	bgei	10, r1, bge_then.16662
	addi	r1, r1, 48
	out	r1
	jr	r31				#
bge_then.16662:
	addi	r2, r0, 100
	ble	r2, r1, ble_then.16663
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
ble_then.16663:
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
	beqi	0, r1, beq_then.16664
	beqi	0, r2, beq_then.16665
	addi	r1, r0, 0
	jr	r31				#
beq_then.16665:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16664:
	add	r1, r0, r2
	jr	r31				#
sgn.2862:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16666
	addi	r1, r0, 1
	j	feq_cont.16667
feq_else.16666:
	addi	r1, r0, 0
feq_cont.16667:
	beqi	0, r1, beq_then.16668
	flup	f1, 0		# fli	f1, 0.000000
	jr	r31				#
beq_then.16668:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16669
	addi	r1, r0, 0
	j	fle_cont.16670
fle_else.16669:
	addi	r1, r0, 1
fle_cont.16670:
	beqi	0, r1, beq_then.16671
	flup	f1, 2		# fli	f1, 1.000000
	jr	r31				#
beq_then.16671:
	flup	f1, 11		# fli	f1, -1.000000
	jr	r31				#
fneg_cond.2864:
	beqi	0, r1, beq_then.16672
	jr	r31				#
beq_then.16672:
	fneg	f1, f1
	jr	r31				#
add_mod5.2867:
	add	r1, r1, r2
	bgei	5, r1, bge_then.16673
	jr	r31				#
bge_then.16673:
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
	beq	r0, r30, feq_else.16679
	addi	r5, r0, 1
	j	feq_cont.16680
feq_else.16679:
	addi	r5, r0, 0
feq_cont.16680:
	beqi	0, r5, beq_then.16681
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16682
beq_then.16681:
	beqi	0, r2, beq_then.16683
	flup	f2, 11		# fli	f2, -1.000000
	finv	f31, f1
	fmul	f1, f2, f31
	j	beq_cont.16684
beq_then.16683:
	flup	f2, 2		# fli	f2, 1.000000
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.16684:
beq_cont.16682:
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
	flw	f4, 6(r3)
	fsw	f2, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_read_float				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	fadd	f3, f0, f1
	flw	f2, 8(r3)
	flw	f4, 6(r3)
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
	flw	f2, 8(r3)
	flw	f4, 6(r3)
	fsw	f3, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin.2837				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 8(r3)
	flw	f3, 12(r3)
	flw	f4, 6(r3)
	addi	r1, r0, 760				# set min_caml_screenz_dir
	fmul	f6, f4, f1
	flup	f5, 26		# fli	f5, 200.000000
	fmul	f5, f6, f5
	fsw	f5, 0(r1)
	addi	r1, r0, 760				# set min_caml_screenz_dir
	flup	f5, 27		# fli	f5, -200.000000
	fmul	f5, f2, f5
	fsw	f5, 1(r1)
	addi	r1, r0, 760				# set min_caml_screenz_dir
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
	flw	f3, 0(r3)
	addi	r1, r0, 667				# set min_caml_light
	fneg	f1, f1
	fsw	f1, 1(r1)
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
	addi	r1, r0, 667				# set min_caml_light
	fmul	f1, f3, f1
	fsw	f1, 0(r1)
	fadd	f1, f0, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2839				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f3, 4(r3)
	addi	r1, r0, 667				# set min_caml_light
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
	beqi	-1, r5, beq_then.16696
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
	beq	r0, r30, fle_else.16697
	addi	r11, r0, 0
	j	fle_cont.16698
fle_else.16697:
	addi	r11, r0, 1
fle_cont.16698:
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
	beqi	0, r12, beq_then.16699
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
	j	beq_cont.16700
beq_then.16699:
beq_cont.16700:
	beqi	2, r13, beq_then.16701
	add	r10, r0, r11
	j	beq_cont.16702
beq_then.16701:
	addi	r10, r0, 1
beq_cont.16702:
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
	beqi	3, r13, beq_then.16703
	beqi	2, r13, beq_then.16705
	j	beq_cont.16706
beq_then.16705:
	beqi	0, r11, beq_then.16707
	addi	r1, r0, 0
	j	beq_cont.16708
beq_then.16707:
	addi	r1, r0, 1
beq_cont.16708:
	add	r2, r0, r1
	add	r1, r0, r16
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	vecunit_sgn.2888				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r7, 10(r3)
	lw	r12, 4(r3)
	lw	r16, 5(r3)
beq_cont.16706:
	j	beq_cont.16704
beq_then.16703:
	flw	f1, 0(r16)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16709
	addi	r1, r0, 1
	j	feq_cont.16710
feq_else.16709:
	addi	r1, r0, 0
feq_cont.16710:
	beqi	0, r1, beq_then.16711
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16712
beq_then.16711:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16713
	addi	r1, r0, 1
	j	feq_cont.16714
feq_else.16713:
	addi	r1, r0, 0
feq_cont.16714:
	beqi	0, r1, beq_then.16715
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16716
beq_then.16715:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16717
	addi	r1, r0, 0
	j	fle_cont.16718
fle_else.16717:
	addi	r1, r0, 1
fle_cont.16718:
	beqi	0, r1, beq_then.16719
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.16720
beq_then.16719:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.16720:
beq_cont.16716:
	fmul	f1, f1, f1
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.16712:
	fsw	f1, 0(r16)
	flw	f1, 1(r16)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16721
	addi	r1, r0, 1
	j	feq_cont.16722
feq_else.16721:
	addi	r1, r0, 0
feq_cont.16722:
	beqi	0, r1, beq_then.16723
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16724
beq_then.16723:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16725
	addi	r1, r0, 1
	j	feq_cont.16726
feq_else.16725:
	addi	r1, r0, 0
feq_cont.16726:
	beqi	0, r1, beq_then.16727
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16728
beq_then.16727:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16729
	addi	r1, r0, 0
	j	fle_cont.16730
fle_else.16729:
	addi	r1, r0, 1
fle_cont.16730:
	beqi	0, r1, beq_then.16731
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.16732
beq_then.16731:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.16732:
beq_cont.16728:
	fmul	f1, f1, f1
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.16724:
	fsw	f1, 1(r16)
	flw	f1, 2(r16)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16733
	addi	r1, r0, 1
	j	feq_cont.16734
feq_else.16733:
	addi	r1, r0, 0
feq_cont.16734:
	beqi	0, r1, beq_then.16735
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16736
beq_then.16735:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16737
	addi	r1, r0, 1
	j	feq_cont.16738
feq_else.16737:
	addi	r1, r0, 0
feq_cont.16738:
	beqi	0, r1, beq_then.16739
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16740
beq_then.16739:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16741
	addi	r1, r0, 0
	j	fle_cont.16742
fle_else.16741:
	addi	r1, r0, 1
fle_cont.16742:
	beqi	0, r1, beq_then.16743
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.16744
beq_then.16743:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.16744:
beq_cont.16740:
	fmul	f1, f1, f1
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.16736:
	fsw	f1, 2(r16)
beq_cont.16704:
	beqi	0, r12, beq_then.16745
	add	r2, r0, r7
	add	r1, r0, r16
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	rotate_quadratic_matrix.2993				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.16746
beq_then.16745:
beq_cont.16746:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16696:
	addi	r1, r0, 0
	jr	r31				#
read_object.2998:
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16747
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	beqi	0, r2, beq_then.16748
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16749
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	beqi	0, r2, beq_then.16750
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16751
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_nth_object.2996				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r1, 2(r3)
	beqi	0, r2, beq_then.16752
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16753
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_nth_object.2996				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 3(r3)
	beqi	0, r2, beq_then.16754
	addi	r1, r1, 1
	j	read_object.2998
beq_then.16754:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
	jr	r31				#
ble_then.16753:
	jr	r31				#
beq_then.16752:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
	jr	r31				#
ble_then.16751:
	jr	r31				#
beq_then.16750:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
	jr	r31				#
ble_then.16749:
	jr	r31				#
beq_then.16748:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
	jr	r31				#
ble_then.16747:
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
	beqi	0, r2, beq_then.16763
	addi	r1, r0, 1
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	beqi	0, r2, beq_then.16764
	addi	r1, r0, 2
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_nth_object.2996				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r1, 2(r3)
	beqi	0, r2, beq_then.16765
	addi	r1, r0, 3
	j	read_object.2998
beq_then.16765:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
	jr	r31				#
beq_then.16764:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
	jr	r31				#
beq_then.16763:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
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
	beqi	-1, r8, beq_then.16769
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
	beqi	-1, r7, beq_then.16770
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
	beqi	-1, r5, beq_then.16772
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
	beqi	-1, r6, beq_then.16774
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
	j	beq_cont.16775
beq_then.16774:
	addi	r6, r9, 1
	addi	r2, r0, -1
	add	r1, r0, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r5, 5(r3)
	lw	r7, 3(r3)
	lw	r8, 1(r3)
	lw	r10, 4(r3)
	lw	r11, 2(r3)
beq_cont.16775:
	add	r30, r2, r10
	sw	r5, 0(r30)
	j	beq_cont.16773
beq_then.16772:
	addi	r5, r10, 1
	addi	r2, r0, -1
	add	r1, r0, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r7, 3(r3)
	lw	r8, 1(r3)
	lw	r11, 2(r3)
beq_cont.16773:
	add	r30, r2, r11
	sw	r7, 0(r30)
	j	beq_cont.16771
beq_then.16770:
	addi	r5, r11, 1
	addi	r2, r0, -1
	add	r1, r0, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r8, 1(r3)
beq_cont.16771:
	add	r30, r2, r1
	sw	r8, 0(r30)
	add	r1, r0, r2
	jr	r31				#
beq_then.16769:
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
	add	r7, r0, r1
	lw	r1, 0(r3)
	beqi	-1, r7, beq_then.16776
	sw	r7, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r5, r0, r1
	lw	r1, 0(r3)
	lw	r7, 1(r3)
	beqi	-1, r5, beq_then.16778
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
	beqi	-1, r6, beq_then.16780
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
	j	beq_cont.16781
beq_then.16780:
	addi	r6, r0, 3
	addi	r2, r0, -1
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 1(r3)
beq_cont.16781:
	sw	r5, 1(r2)
	j	beq_cont.16779
beq_then.16778:
	addi	r5, r0, 2
	addi	r2, r0, -1
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r7, 1(r3)
beq_cont.16779:
	sw	r7, 0(r2)
	add	r6, r0, r2
	j	beq_cont.16777
beq_then.16776:
	addi	r5, r0, 1
	addi	r2, r0, -1
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r6, r0, r1
	lw	r1, 0(r3)
beq_cont.16777:
	lw	r2, 0(r6)
	beqi	-1, r2, beq_then.16782
	addi	r8, r1, 1
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r5, r0, r1
	lw	r6, 4(r3)
	lw	r1, 0(r3)
	lw	r8, 5(r3)
	beqi	-1, r5, beq_then.16783
	sw	r5, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r7, r0, r1
	lw	r6, 4(r3)
	lw	r1, 0(r3)
	lw	r5, 6(r3)
	lw	r8, 5(r3)
	beqi	-1, r7, beq_then.16785
	addi	r2, r0, 2
	sw	r7, 7(r3)
	add	r1, r0, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.3002				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1
	lw	r6, 4(r3)
	lw	r1, 0(r3)
	lw	r5, 6(r3)
	lw	r7, 7(r3)
	lw	r8, 5(r3)
	sw	r7, 1(r2)
	j	beq_cont.16786
beq_then.16785:
	addi	r7, r0, 2
	addi	r2, r0, -1
	add	r1, r0, r7
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1
	lw	r6, 4(r3)
	lw	r1, 0(r3)
	lw	r5, 6(r3)
	lw	r8, 5(r3)
beq_cont.16786:
	sw	r5, 0(r2)
	add	r5, r0, r2
	j	beq_cont.16784
beq_then.16783:
	addi	r5, r0, 1
	addi	r2, r0, -1
	add	r1, r0, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r5, r0, r1
	lw	r6, 4(r3)
	lw	r1, 0(r3)
	lw	r8, 5(r3)
beq_cont.16784:
	lw	r2, 0(r5)
	beqi	-1, r2, beq_then.16787
	addi	r2, r8, 1
	sw	r5, 8(r3)
	add	r1, r0, r2
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	read_or_network.3004				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r2, r0, r1
	lw	r5, 8(r3)
	lw	r6, 4(r3)
	lw	r1, 0(r3)
	lw	r8, 5(r3)
	add	r30, r2, r8
	sw	r5, 0(r30)
	j	beq_cont.16788
beq_then.16787:
	addi	r2, r8, 1
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r2, r0, r1
	lw	r6, 4(r3)
	lw	r1, 0(r3)
beq_cont.16788:
	add	r30, r2, r1
	sw	r6, 0(r30)
	add	r1, r0, r2
	jr	r31				#
beq_then.16782:
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
	beqi	-1, r7, beq_then.16789
	sw	r7, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r5, r0, r1
	lw	r1, 0(r3)
	lw	r7, 1(r3)
	beqi	-1, r5, beq_then.16791
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
	beqi	-1, r6, beq_then.16793
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
	j	beq_cont.16794
beq_then.16793:
	addi	r6, r0, 3
	addi	r2, r0, -1
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 1(r3)
beq_cont.16794:
	sw	r5, 1(r2)
	j	beq_cont.16792
beq_then.16791:
	addi	r5, r0, 2
	addi	r2, r0, -1
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r7, 1(r3)
beq_cont.16792:
	sw	r7, 0(r2)
	j	beq_cont.16790
beq_then.16789:
	addi	r5, r0, 1
	addi	r2, r0, -1
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
beq_cont.16790:
	lw	r5, 0(r2)
	beqi	-1, r5, beq_then.16795
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r1
	sw	r2, 0(r30)
	addi	r6, r1, 1
	sw	r6, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
	lw	r6, 4(r3)
	beqi	-1, r2, beq_then.16796
	sw	r2, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r5, r0, r1
	lw	r2, 5(r3)
	lw	r6, 4(r3)
	beqi	-1, r5, beq_then.16798
	addi	r1, r0, 2
	sw	r5, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	read_net_item.3002				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	lw	r6, 4(r3)
	sw	r5, 1(r1)
	j	beq_cont.16799
beq_then.16798:
	addi	r5, r0, 2
	addi	r1, r0, -1
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r6, 4(r3)
beq_cont.16799:
	sw	r2, 0(r1)
	j	beq_cont.16797
beq_then.16796:
	addi	r2, r0, 1
	addi	r1, r0, -1
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r6, 4(r3)
beq_cont.16797:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.16800
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r6
	sw	r1, 0(r30)
	addi	r1, r6, 1
	j	read_and_network.3006
beq_then.16800:
	jr	r31				#
beq_then.16795:
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
	beqi	0, r2, beq_then.16803
	addi	r1, r0, 1
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	beqi	0, r2, beq_then.16805
	addi	r1, r0, 2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_object.2998				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.16806
beq_then.16805:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
beq_cont.16806:
	j	beq_cont.16804
beq_then.16803:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
beq_cont.16804:
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	beqi	-1, r2, beq_then.16807
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r2, 2(r3)
	beqi	-1, r5, beq_then.16809
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
	j	beq_cont.16810
beq_then.16809:
	addi	r5, r0, 2
	addi	r1, r0, -1
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
beq_cont.16810:
	sw	r2, 0(r1)
	j	beq_cont.16808
beq_then.16807:
	addi	r2, r0, 1
	addi	r1, r0, -1
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16808:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.16811
	addi	r2, r0, 672				# set min_caml_and_net
	sw	r1, 0(r2)
	addi	r1, r0, 1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_and_network.3006				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16812
beq_then.16811:
beq_cont.16812:
	addi	r6, r0, 723				# set min_caml_or_net
	sw	r6, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
	lw	r6, 4(r3)
	beqi	-1, r2, beq_then.16813
	sw	r2, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r5, r0, r1
	lw	r2, 5(r3)
	lw	r6, 4(r3)
	beqi	-1, r5, beq_then.16815
	addi	r1, r0, 2
	sw	r5, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	read_net_item.3002				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	lw	r6, 4(r3)
	sw	r5, 1(r1)
	j	beq_cont.16816
beq_then.16815:
	addi	r5, r0, 2
	addi	r1, r0, -1
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 5(r3)
	lw	r6, 4(r3)
beq_cont.16816:
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.16814
beq_then.16813:
	addi	r2, r0, 1
	addi	r1, r0, -1
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r1
	lw	r6, 4(r3)
beq_cont.16814:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.16817
	addi	r1, r0, 1
	sw	r2, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_or_network.3004				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 7(r3)
	lw	r6, 4(r3)
	sw	r2, 0(r1)
	j	beq_cont.16818
beq_then.16817:
	addi	r1, r0, 1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r6, 4(r3)
beq_cont.16818:
	sw	r1, 0(r6)
	jr	r31				#
solver_rect_surface.3010:
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16820
	addi	r8, r0, 1
	j	feq_cont.16821
feq_else.16820:
	addi	r8, r0, 0
feq_cont.16821:
	beqi	0, r8, beq_then.16822
	addi	r1, r0, 0
	jr	r31				#
beq_then.16822:
	lw	r8, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16823
	addi	r9, r0, 0
	j	fle_cont.16824
fle_else.16823:
	addi	r9, r0, 1
fle_cont.16824:
	beqi	0, r1, beq_then.16825
	beqi	0, r9, beq_then.16827
	addi	r1, r0, 0
	j	beq_cont.16828
beq_then.16827:
	addi	r1, r0, 1
beq_cont.16828:
	j	beq_cont.16826
beq_then.16825:
	add	r1, r0, r9
beq_cont.16826:
	add	r30, r8, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.16829
	j	beq_cont.16830
beq_then.16829:
	fneg	f4, f4
beq_cont.16830:
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
	beq	r0, r30, fle_else.16831
	j	fle_cont.16832
fle_else.16831:
	fneg	f2, f2
fle_cont.16832:
	fle	r30, f5, f2
	beq	r0, r30, fle_else.16833
	addi	r1, r0, 0
	jr	r31				#
fle_else.16833:
	add	r30, r8, r7
	flw	f4, 0(r30)
	add	r30, r2, r7
	flw	f2, 0(r30)
	fmul	f2, f1, f2
	fadd	f2, f2, f3
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16834
	j	fle_cont.16835
fle_else.16834:
	fneg	f2, f2
fle_cont.16835:
	fle	r30, f4, f2
	beq	r0, r30, fle_else.16836
	addi	r1, r0, 0
	jr	r31				#
fle_else.16836:
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
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	beqi	0, r5, beq_then.16837
	addi	r1, r0, 1
	jr	r31				#
beq_then.16837:
	addi	r5, r0, 1
	addi	r6, r0, 2
	addi	r7, r0, 0
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
	beqi	0, r5, beq_then.16838
	addi	r1, r0, 2
	jr	r31				#
beq_then.16838:
	addi	r5, r0, 2
	addi	r6, r0, 0
	addi	r7, r0, 1
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f1
	fadd	f1, f0, f30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.16839
	addi	r1, r0, 3
	jr	r31				#
beq_then.16839:
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
	beq	r0, r30, fle_else.16840
	addi	r2, r0, 0
	j	fle_cont.16841
fle_else.16840:
	addi	r2, r0, 1
fle_cont.16841:
	beqi	0, r2, beq_then.16842
	addi	r2, r0, 724				# set min_caml_solver_dist
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
	fsw	f1, 0(r2)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16842:
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
	beqi	0, r2, beq_then.16843
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
beq_then.16843:
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
	beqi	0, r2, beq_then.16844
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
beq_then.16844:
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
	beq	r0, r30, feq_else.16845
	addi	r5, r0, 1
	j	feq_cont.16846
feq_else.16845:
	addi	r5, r0, 0
feq_cont.16846:
	beqi	0, r5, beq_then.16847
	addi	r1, r0, 0
	jr	r31				#
beq_then.16847:
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
	beqi	3, r2, beq_then.16848
	j	beq_cont.16849
beq_then.16848:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16849:
	fmul	f2, f4, f4
	fmul	f1, f5, f1
	fsub	f1, f2, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16850
	addi	r2, r0, 0
	j	fle_cont.16851
fle_else.16850:
	addi	r2, r0, 1
fle_cont.16851:
	beqi	0, r2, beq_then.16852
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16853
	j	beq_cont.16854
beq_then.16853:
	fneg	f1, f1
beq_cont.16854:
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsub	f1, f1, f4
	finv	f31, f5
	fmul	f1, f1, f31
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16852:
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
	beqi	1, r1, beq_then.16855
	beqi	2, r1, beq_then.16856
	add	r1, r0, r6
	fadd	f1, f0, f4
	j	solver_second.3044
beq_then.16856:
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
	beq	r0, r30, fle_else.16857
	addi	r2, r0, 0
	j	fle_cont.16858
fle_else.16857:
	addi	r2, r0, 1
fle_cont.16858:
	beqi	0, r2, beq_then.16859
	addi	r2, r0, 724				# set min_caml_solver_dist
	flw	f5, 0(r1)
	fmul	f5, f5, f4
	flw	f4, 1(r1)
	fmul	f2, f4, f2
	fadd	f4, f5, f2
	flw	f2, 2(r1)
	fmul	f2, f2, f3
	fadd	f2, f4, f2
	fneg	f2, f2
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 0(r2)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16859:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16855:
	addi	r5, r0, 0
	addi	r1, r0, 1
	addi	r7, r0, 2
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f4, 4(r3)
	sw	r6, 6(r3)
	sw	r2, 7(r3)
	add	r28, r0, r6
	add	r6, r0, r1
	add	r1, r0, r28
	fadd	f1, f0, f4
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f4, 4(r3)
	lw	r6, 6(r3)
	lw	r2, 7(r3)
	beqi	0, r1, beq_then.16860
	addi	r1, r0, 1
	jr	r31				#
beq_then.16860:
	addi	r5, r0, 1
	addi	r1, r0, 2
	addi	r7, r0, 0
	add	r28, r0, r6
	add	r6, r0, r1
	add	r1, r0, r28
	fadd	f1, f0, f2
	fadd	f2, f0, f3
	fadd	f3, f0, f4
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f4, 4(r3)
	lw	r6, 6(r3)
	lw	r2, 7(r3)
	beqi	0, r1, beq_then.16861
	addi	r1, r0, 2
	jr	r31				#
beq_then.16861:
	addi	r5, r0, 2
	addi	r1, r0, 0
	addi	r7, r0, 1
	add	r28, r0, r6
	add	r6, r0, r1
	add	r1, r0, r28
	fadd	f1, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f4
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	solver_rect_surface.3010				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.16862
	addi	r1, r0, 3
	jr	r31				#
beq_then.16862:
	addi	r1, r0, 0
	jr	r31				#
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
	beq	r0, r30, fle_else.16863
	j	fle_cont.16864
fle_else.16863:
	fneg	f5, f5
fle_cont.16864:
	fle	r30, f6, f5
	beq	r0, r30, fle_else.16865
	addi	r6, r0, 0
	j	fle_cont.16866
fle_else.16865:
	lw	r6, 4(r1)
	flw	f6, 2(r6)
	flw	f5, 2(r2)
	fmul	f5, f4, f5
	fadd	f5, f5, f3
	fle	r30, f0, f5
	beq	r0, r30, fle_else.16867
	j	fle_cont.16868
fle_else.16867:
	fneg	f5, f5
fle_cont.16868:
	fle	r30, f6, f5
	beq	r0, r30, fle_else.16869
	addi	r6, r0, 0
	j	fle_cont.16870
fle_else.16869:
	flw	f5, 1(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16871
	addi	r6, r0, 1
	j	feq_cont.16872
feq_else.16871:
	addi	r6, r0, 0
feq_cont.16872:
	beqi	0, r6, beq_then.16873
	addi	r6, r0, 0
	j	beq_cont.16874
beq_then.16873:
	addi	r6, r0, 1
beq_cont.16874:
fle_cont.16870:
fle_cont.16866:
	beqi	0, r6, beq_then.16875
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsw	f4, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16875:
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
	beq	r0, r30, fle_else.16876
	j	fle_cont.16877
fle_else.16876:
	fneg	f5, f5
fle_cont.16877:
	fle	r30, f6, f5
	beq	r0, r30, fle_else.16878
	addi	r6, r0, 0
	j	fle_cont.16879
fle_else.16878:
	lw	r6, 4(r1)
	flw	f6, 2(r6)
	flw	f5, 2(r2)
	fmul	f5, f4, f5
	fadd	f5, f5, f3
	fle	r30, f0, f5
	beq	r0, r30, fle_else.16880
	j	fle_cont.16881
fle_else.16880:
	fneg	f5, f5
fle_cont.16881:
	fle	r30, f6, f5
	beq	r0, r30, fle_else.16882
	addi	r6, r0, 0
	j	fle_cont.16883
fle_else.16882:
	flw	f5, 3(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16884
	addi	r6, r0, 1
	j	feq_cont.16885
feq_else.16884:
	addi	r6, r0, 0
feq_cont.16885:
	beqi	0, r6, beq_then.16886
	addi	r6, r0, 0
	j	beq_cont.16887
beq_then.16886:
	addi	r6, r0, 1
beq_cont.16887:
fle_cont.16883:
fle_cont.16879:
	beqi	0, r6, beq_then.16888
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsw	f4, 0(r1)
	addi	r1, r0, 2
	jr	r31				#
beq_then.16888:
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
	beq	r0, r30, fle_else.16889
	j	fle_cont.16890
fle_else.16889:
	fneg	f1, f1
fle_cont.16890:
	fle	r30, f5, f1
	beq	r0, r30, fle_else.16891
	addi	r1, r0, 0
	j	fle_cont.16892
fle_else.16891:
	lw	r1, 4(r1)
	flw	f4, 1(r1)
	flw	f1, 1(r2)
	fmul	f1, f3, f1
	fadd	f1, f1, f2
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16893
	j	fle_cont.16894
fle_else.16893:
	fneg	f1, f1
fle_cont.16894:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16895
	addi	r1, r0, 0
	j	fle_cont.16896
fle_else.16895:
	flw	f1, 5(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16897
	addi	r1, r0, 1
	j	feq_cont.16898
feq_else.16897:
	addi	r1, r0, 0
feq_cont.16898:
	beqi	0, r1, beq_then.16899
	addi	r1, r0, 0
	j	beq_cont.16900
beq_then.16899:
	addi	r1, r0, 1
beq_cont.16900:
fle_cont.16896:
fle_cont.16892:
	beqi	0, r1, beq_then.16901
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsw	f3, 0(r1)
	addi	r1, r0, 3
	jr	r31				#
beq_then.16901:
	addi	r1, r0, 0
	jr	r31				#
solver_surface_fast.3061:
	flw	f4, 0(r2)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16902
	addi	r1, r0, 0
	j	fle_cont.16903
fle_else.16902:
	addi	r1, r0, 1
fle_cont.16903:
	beqi	0, r1, beq_then.16904
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
beq_then.16904:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3067:
	flw	f5, 0(r2)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16905
	addi	r5, r0, 1
	j	feq_cont.16906
feq_else.16905:
	addi	r5, r0, 0
feq_cont.16906:
	beqi	0, r5, beq_then.16907
	addi	r1, r0, 0
	jr	r31				#
beq_then.16907:
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
	beqi	3, r5, beq_then.16908
	j	beq_cont.16909
beq_then.16908:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16909:
	fmul	f2, f4, f4
	fmul	f1, f5, f1
	fsub	f1, f2, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16910
	addi	r5, r0, 0
	j	fle_cont.16911
fle_else.16910:
	addi	r5, r0, 1
fle_cont.16911:
	beqi	0, r5, beq_then.16912
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16913
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsqrt	f1, f1
	fadd	f2, f4, f1
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	j	beq_cont.16914
beq_then.16913:
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsqrt	f1, f1
	fsub	f2, f4, f1
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
beq_cont.16914:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16912:
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
	beqi	1, r1, beq_then.16915
	beqi	2, r1, beq_then.16916
	add	r2, r0, r5
	add	r1, r0, r7
	j	solver_second_fast.3067
beq_then.16916:
	flw	f4, 0(r5)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16917
	addi	r1, r0, 0
	j	fle_cont.16918
fle_else.16917:
	addi	r1, r0, 1
fle_cont.16918:
	beqi	0, r1, beq_then.16919
	addi	r1, r0, 724				# set min_caml_solver_dist
	flw	f4, 1(r5)
	fmul	f4, f4, f1
	flw	f1, 2(r5)
	fmul	f1, f1, f2
	fadd	f2, f4, f1
	flw	f1, 3(r5)
	fmul	f1, f1, f3
	fadd	f1, f2, f1
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16919:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16915:
	lw	r2, 0(r2)
	add	r1, r0, r7
	j	solver_rect_fast.3054
solver_surface_fast2.3077:
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16920
	addi	r1, r0, 0
	j	fle_cont.16921
fle_else.16920:
	addi	r1, r0, 1
fle_cont.16921:
	beqi	0, r1, beq_then.16922
	addi	r1, r0, 724				# set min_caml_solver_dist
	flw	f2, 0(r2)
	flw	f1, 3(r5)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16922:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3084:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16923
	addi	r6, r0, 1
	j	feq_cont.16924
feq_else.16923:
	addi	r6, r0, 0
feq_cont.16924:
	beqi	0, r6, beq_then.16925
	addi	r1, r0, 0
	jr	r31				#
beq_then.16925:
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
	beq	r0, r30, fle_else.16926
	addi	r5, r0, 0
	j	fle_cont.16927
fle_else.16926:
	addi	r5, r0, 1
fle_cont.16927:
	beqi	0, r5, beq_then.16928
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16929
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsqrt	f2, f2
	fadd	f2, f1, f2
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	j	beq_cont.16930
beq_then.16929:
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsqrt	f2, f2
	fsub	f2, f1, f2
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
beq_cont.16930:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16928:
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
	beqi	1, r1, beq_then.16931
	beqi	2, r1, beq_then.16932
	add	r2, r0, r6
	add	r1, r0, r7
	j	solver_second_fast2.3084
beq_then.16932:
	flw	f1, 0(r6)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16933
	addi	r1, r0, 0
	j	fle_cont.16934
fle_else.16933:
	addi	r1, r0, 1
fle_cont.16934:
	beqi	0, r1, beq_then.16935
	addi	r1, r0, 724				# set min_caml_solver_dist
	flw	f2, 0(r6)
	flw	f1, 3(r5)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16935:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16931:
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
	lw	r2, 1(r3)
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16936
	addi	r5, r0, 1
	j	feq_cont.16937
feq_else.16936:
	addi	r5, r0, 0
feq_cont.16937:
	beqi	0, r5, beq_then.16938
	fsw	f0, 1(r6)
	j	beq_cont.16939
beq_then.16938:
	lw	r5, 6(r2)
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16940
	addi	r7, r0, 0
	j	fle_cont.16941
fle_else.16940:
	addi	r7, r0, 1
fle_cont.16941:
	beqi	0, r5, beq_then.16942
	beqi	0, r7, beq_then.16944
	addi	r7, r0, 0
	j	beq_cont.16945
beq_then.16944:
	addi	r7, r0, 1
beq_cont.16945:
	j	beq_cont.16943
beq_then.16942:
beq_cont.16943:
	lw	r5, 4(r2)
	flw	f1, 0(r5)
	beqi	0, r7, beq_then.16946
	j	beq_cont.16947
beq_then.16946:
	fneg	f1, f1
beq_cont.16947:
	fsw	f1, 0(r6)
	flup	f2, 2		# fli	f2, 1.000000
	flw	f1, 0(r1)
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 1(r6)
beq_cont.16939:
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16948
	addi	r5, r0, 1
	j	feq_cont.16949
feq_else.16948:
	addi	r5, r0, 0
feq_cont.16949:
	beqi	0, r5, beq_then.16950
	fsw	f0, 3(r6)
	j	beq_cont.16951
beq_then.16950:
	lw	r5, 6(r2)
	flw	f1, 1(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16952
	addi	r7, r0, 0
	j	fle_cont.16953
fle_else.16952:
	addi	r7, r0, 1
fle_cont.16953:
	beqi	0, r5, beq_then.16954
	beqi	0, r7, beq_then.16956
	addi	r7, r0, 0
	j	beq_cont.16957
beq_then.16956:
	addi	r7, r0, 1
beq_cont.16957:
	j	beq_cont.16955
beq_then.16954:
beq_cont.16955:
	lw	r5, 4(r2)
	flw	f1, 1(r5)
	beqi	0, r7, beq_then.16958
	j	beq_cont.16959
beq_then.16958:
	fneg	f1, f1
beq_cont.16959:
	fsw	f1, 2(r6)
	flup	f2, 2		# fli	f2, 1.000000
	flw	f1, 1(r1)
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 3(r6)
beq_cont.16951:
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16960
	addi	r5, r0, 1
	j	feq_cont.16961
feq_else.16960:
	addi	r5, r0, 0
feq_cont.16961:
	beqi	0, r5, beq_then.16962
	fsw	f0, 5(r6)
	j	beq_cont.16963
beq_then.16962:
	lw	r5, 6(r2)
	flw	f1, 2(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16964
	addi	r7, r0, 0
	j	fle_cont.16965
fle_else.16964:
	addi	r7, r0, 1
fle_cont.16965:
	beqi	0, r5, beq_then.16966
	beqi	0, r7, beq_then.16968
	addi	r5, r0, 0
	j	beq_cont.16969
beq_then.16968:
	addi	r5, r0, 1
beq_cont.16969:
	j	beq_cont.16967
beq_then.16966:
	add	r5, r0, r7
beq_cont.16967:
	lw	r2, 4(r2)
	flw	f1, 2(r2)
	beqi	0, r5, beq_then.16970
	j	beq_cont.16971
beq_then.16970:
	fneg	f1, f1
beq_cont.16971:
	fsw	f1, 4(r6)
	flup	f2, 2		# fli	f2, 1.000000
	flw	f1, 2(r1)
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 5(r6)
beq_cont.16963:
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
	beq	r0, r30, fle_else.16972
	addi	r1, r0, 0
	j	fle_cont.16973
fle_else.16972:
	addi	r1, r0, 1
fle_cont.16973:
	beqi	0, r1, beq_then.16974
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
	j	beq_cont.16975
beq_then.16974:
	fsw	f0, 0(r6)
beq_cont.16975:
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
	flw	f1, 0(r1)
	flw	f2, 1(r1)
	flw	f3, 2(r1)
	sw	r6, 2(r3)
	add	r1, r0, r2
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
	beqi	0, r5, beq_then.16976
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
	j	beq_cont.16977
beq_then.16976:
	fsw	f3, 1(r6)
	fsw	f2, 2(r6)
	fsw	f1, 3(r6)
beq_cont.16977:
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16978
	addi	r1, r0, 1
	j	feq_cont.16979
feq_else.16978:
	addi	r1, r0, 0
feq_cont.16979:
	beqi	0, r1, beq_then.16980
	j	beq_cont.16981
beq_then.16980:
	flup	f1, 2		# fli	f1, 1.000000
	finv	f31, f4
	fmul	f1, f1, f31
	fsw	f1, 4(r6)
beq_cont.16981:
	add	r1, r0, r6
	jr	r31				#
iter_setup_dirvec_constants.3103:
	bgei	0, r2, bge_then.16982
	jr	r31				#
bge_then.16982:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r2
	lw	r8, 0(r30)
	lw	r7, 1(r1)
	lw	r5, 0(r1)
	lw	r6, 1(r8)
	beqi	1, r6, beq_then.16984
	beqi	2, r6, beq_then.16986
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
	lw	r1, 2(r3)
	add	r30, r7, r2
	sw	r5, 0(r30)
	j	beq_cont.16987
beq_then.16986:
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
	lw	r1, 2(r3)
	add	r30, r7, r2
	sw	r5, 0(r30)
beq_cont.16987:
	j	beq_cont.16985
beq_then.16984:
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
beq_cont.16985:
	addi	r8, r2, -1
	bgei	0, r8, bge_then.16988
	jr	r31				#
bge_then.16988:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r8
	lw	r7, 0(r30)
	lw	r6, 1(r1)
	lw	r2, 0(r1)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.16990
	beqi	2, r5, beq_then.16992
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3100				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
	lw	r6, 3(r3)
	lw	r1, 2(r3)
	lw	r8, 4(r3)
	add	r30, r6, r8
	sw	r2, 0(r30)
	j	beq_cont.16993
beq_then.16992:
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3097				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
	lw	r6, 3(r3)
	lw	r1, 2(r3)
	lw	r8, 4(r3)
	add	r30, r6, r8
	sw	r2, 0(r30)
beq_cont.16993:
	j	beq_cont.16991
beq_then.16990:
	sw	r6, 3(r3)
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
beq_cont.16991:
	addi	r2, r8, -1
	j	iter_setup_dirvec_constants.3103
setup_dirvec_constants.3106:
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r2, 0(r2)
	addi	r8, r2, -1
	bgei	0, r8, bge_then.16994
	jr	r31				#
bge_then.16994:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r8
	lw	r7, 0(r30)
	lw	r6, 1(r1)
	lw	r2, 0(r1)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.16996
	beqi	2, r5, beq_then.16998
	sw	r6, 0(r3)
	sw	r1, 1(r3)
	sw	r8, 2(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_second_table.3100				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r6, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	add	r30, r6, r8
	sw	r2, 0(r30)
	j	beq_cont.16999
beq_then.16998:
	sw	r6, 0(r3)
	sw	r1, 1(r3)
	sw	r8, 2(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_surface_table.3097				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r6, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	add	r30, r6, r8
	sw	r2, 0(r30)
beq_cont.16999:
	j	beq_cont.16997
beq_then.16996:
	sw	r6, 0(r3)
	sw	r1, 1(r3)
	sw	r8, 2(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_rect_table.3094				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r6, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	add	r30, r6, r8
	sw	r2, 0(r30)
beq_cont.16997:
	addi	r2, r8, -1
	j	iter_setup_dirvec_constants.3103
setup_startp_constants.3108:
	bgei	0, r2, bge_then.17000
	jr	r31				#
bge_then.17000:
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
	beqi	2, r7, beq_then.17002
	blei	2, r7, ble_then.17004
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
	lw	r1, 0(r3)
	lw	r7, 1(r3)
	lw	r8, 2(r3)
	lw	r2, 3(r3)
	beqi	3, r7, beq_then.17006
	j	beq_cont.17007
beq_then.17006:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.17007:
	fsw	f1, 3(r8)
	j	ble_cont.17005
ble_then.17004:
ble_cont.17005:
	j	beq_cont.17003
beq_then.17002:
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
beq_cont.17003:
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
	beq	r0, r30, fle_else.17008
	j	fle_cont.17009
fle_else.17008:
	fneg	f1, f1
fle_cont.17009:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17010
	addi	r2, r0, 0
	j	fle_cont.17011
fle_else.17010:
	lw	r2, 4(r1)
	flw	f4, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.17012
	fadd	f1, f0, f2
	j	fle_cont.17013
fle_else.17012:
	fneg	f1, f2
fle_cont.17013:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17014
	addi	r2, r0, 0
	j	fle_cont.17015
fle_else.17014:
	lw	r2, 4(r1)
	flw	f2, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.17016
	fadd	f1, f0, f3
	j	fle_cont.17017
fle_else.17016:
	fneg	f1, f3
fle_cont.17017:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17018
	addi	r2, r0, 0
	j	fle_cont.17019
fle_else.17018:
	addi	r2, r0, 1
fle_cont.17019:
fle_cont.17015:
fle_cont.17011:
	beqi	0, r2, beq_then.17020
	lw	r1, 6(r1)
	jr	r31				#
beq_then.17020:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.17021
	addi	r1, r0, 0
	jr	r31				#
beq_then.17021:
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
	beq	r0, r30, fle_else.17022
	addi	r2, r0, 0
	j	fle_cont.17023
fle_else.17022:
	addi	r2, r0, 1
fle_cont.17023:
	beqi	0, r1, beq_then.17024
	beqi	0, r2, beq_then.17026
	addi	r1, r0, 0
	j	beq_cont.17027
beq_then.17026:
	addi	r1, r0, 1
beq_cont.17027:
	j	beq_cont.17025
beq_then.17024:
	add	r1, r0, r2
beq_cont.17025:
	beqi	0, r1, beq_then.17028
	addi	r1, r0, 0
	jr	r31				#
beq_then.17028:
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
	beqi	3, r2, beq_then.17029
	j	beq_cont.17030
beq_then.17029:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.17030:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17031
	addi	r2, r0, 0
	j	fle_cont.17032
fle_else.17031:
	addi	r2, r0, 1
fle_cont.17032:
	beqi	0, r1, beq_then.17033
	beqi	0, r2, beq_then.17035
	addi	r1, r0, 0
	j	beq_cont.17036
beq_then.17035:
	addi	r1, r0, 1
beq_cont.17036:
	j	beq_cont.17034
beq_then.17033:
	add	r1, r0, r2
beq_cont.17034:
	beqi	0, r1, beq_then.17037
	addi	r1, r0, 0
	jr	r31				#
beq_then.17037:
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
	beqi	1, r2, beq_then.17038
	beqi	2, r2, beq_then.17039
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3031				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.17040
	j	beq_cont.17041
beq_then.17040:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.17041:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17042
	addi	r2, r0, 0
	j	fle_cont.17043
fle_else.17042:
	addi	r2, r0, 1
fle_cont.17043:
	beqi	0, r1, beq_then.17044
	beqi	0, r2, beq_then.17046
	addi	r1, r0, 0
	j	beq_cont.17047
beq_then.17046:
	addi	r1, r0, 1
beq_cont.17047:
	j	beq_cont.17045
beq_then.17044:
	add	r1, r0, r2
beq_cont.17045:
	beqi	0, r1, beq_then.17048
	addi	r1, r0, 0
	jr	r31				#
beq_then.17048:
	addi	r1, r0, 1
	jr	r31				#
beq_then.17039:
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
	beq	r0, r30, fle_else.17049
	addi	r2, r0, 0
	j	fle_cont.17050
fle_else.17049:
	addi	r2, r0, 1
fle_cont.17050:
	beqi	0, r1, beq_then.17051
	beqi	0, r2, beq_then.17053
	addi	r1, r0, 0
	j	beq_cont.17054
beq_then.17053:
	addi	r1, r0, 1
beq_cont.17054:
	j	beq_cont.17052
beq_then.17051:
	add	r1, r0, r2
beq_cont.17052:
	beqi	0, r1, beq_then.17055
	addi	r1, r0, 0
	jr	r31				#
beq_then.17055:
	addi	r1, r0, 1
	jr	r31				#
beq_then.17038:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17056
	j	fle_cont.17057
fle_else.17056:
	fneg	f1, f1
fle_cont.17057:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17058
	addi	r2, r0, 0
	j	fle_cont.17059
fle_else.17058:
	lw	r2, 4(r1)
	flw	f4, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.17060
	fadd	f1, f0, f2
	j	fle_cont.17061
fle_else.17060:
	fneg	f1, f2
fle_cont.17061:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17062
	addi	r2, r0, 0
	j	fle_cont.17063
fle_else.17062:
	lw	r2, 4(r1)
	flw	f2, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.17064
	fadd	f1, f0, f3
	j	fle_cont.17065
fle_else.17064:
	fneg	f1, f3
fle_cont.17065:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17066
	addi	r2, r0, 0
	j	fle_cont.17067
fle_else.17066:
	addi	r2, r0, 1
fle_cont.17067:
fle_cont.17063:
fle_cont.17059:
	beqi	0, r2, beq_then.17068
	lw	r1, 6(r1)
	jr	r31				#
beq_then.17068:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.17069
	addi	r1, r0, 0
	jr	r31				#
beq_then.17069:
	addi	r1, r0, 1
	jr	r31				#
check_all_inside.3133:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.17070
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
	beqi	1, r5, beq_then.17071
	beqi	2, r5, beq_then.17073
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	sw	r6, 8(r3)
	add	r1, r0, r6
	fadd	f3, f0, f4
	fadd	f2, f0, f5
	fadd	f1, f0, f6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	quadratic.3031				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	fadd	f4, f0, f1
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	lw	r6, 8(r3)
	lw	r5, 1(r6)
	beqi	3, r5, beq_then.17075
	j	beq_cont.17076
beq_then.17075:
	flup	f5, 2		# fli	f5, 1.000000
	fsub	f4, f4, f5
beq_cont.17076:
	lw	r5, 6(r6)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.17077
	addi	r6, r0, 0
	j	fle_cont.17078
fle_else.17077:
	addi	r6, r0, 1
fle_cont.17078:
	beqi	0, r5, beq_then.17079
	beqi	0, r6, beq_then.17081
	addi	r5, r0, 0
	j	beq_cont.17082
beq_then.17081:
	addi	r5, r0, 1
beq_cont.17082:
	j	beq_cont.17080
beq_then.17079:
	add	r5, r0, r6
beq_cont.17080:
	beqi	0, r5, beq_then.17083
	addi	r5, r0, 0
	j	beq_cont.17084
beq_then.17083:
	addi	r5, r0, 1
beq_cont.17084:
	j	beq_cont.17074
beq_then.17073:
	lw	r5, 4(r6)
	flw	f7, 0(r5)
	fmul	f7, f7, f6
	flw	f6, 1(r5)
	fmul	f5, f6, f5
	fadd	f6, f7, f5
	flw	f5, 2(r5)
	fmul	f4, f5, f4
	fadd	f4, f6, f4
	lw	r5, 6(r6)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.17085
	addi	r6, r0, 0
	j	fle_cont.17086
fle_else.17085:
	addi	r6, r0, 1
fle_cont.17086:
	beqi	0, r5, beq_then.17087
	beqi	0, r6, beq_then.17089
	addi	r5, r0, 0
	j	beq_cont.17090
beq_then.17089:
	addi	r5, r0, 1
beq_cont.17090:
	j	beq_cont.17088
beq_then.17087:
	add	r5, r0, r6
beq_cont.17088:
	beqi	0, r5, beq_then.17091
	addi	r5, r0, 0
	j	beq_cont.17092
beq_then.17091:
	addi	r5, r0, 1
beq_cont.17092:
beq_cont.17074:
	j	beq_cont.17072
beq_then.17071:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
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
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	lw	r1, 6(r3)
	lw	r2, 7(r3)
beq_cont.17072:
	beqi	0, r5, beq_then.17093
	addi	r1, r0, 0
	jr	r31				#
beq_then.17093:
	addi	r5, r1, 1
	add	r30, r2, r5
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.17094
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r1
	lw	r1, 0(r30)
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r2, 7(r3)
	sw	r5, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	is_outside.3128				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	lw	r2, 7(r3)
	lw	r5, 9(r3)
	beqi	0, r1, beq_then.17095
	addi	r1, r0, 0
	jr	r31				#
beq_then.17095:
	addi	r1, r5, 1
	j	check_all_inside.3133
beq_then.17094:
	addi	r1, r0, 1
	jr	r31				#
beq_then.17070:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3139:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.17096
	add	r30, r2, r1
	lw	r6, 0(r30)
	addi	r9, r0, 1021				# set min_caml_light_dirvec
	addi	r8, r0, 727				# set min_caml_intersection_point
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r6
	lw	r7, 0(r30)
	flw	f2, 0(r8)
	lw	r5, 5(r7)
	flw	f1, 0(r5)
	fsub	f3, f2, f1
	flw	f2, 1(r8)
	lw	r5, 5(r7)
	flw	f1, 1(r5)
	fsub	f2, f2, f1
	flw	f4, 2(r8)
	lw	r5, 5(r7)
	flw	f1, 2(r5)
	fsub	f1, f4, f1
	lw	r5, 1(r9)
	add	r30, r5, r6
	lw	r8, 0(r30)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17097
	beqi	2, r5, beq_then.17099
	sw	r6, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	add	r2, r0, r8
	add	r1, r0, r7
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_second_fast.3067				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r6, 0(r3)
	lw	r1, 1(r3)
	lw	r2, 2(r3)
	j	beq_cont.17100
beq_then.17099:
	flw	f4, 0(r8)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.17101
	addi	r5, r0, 0
	j	fle_cont.17102
fle_else.17101:
	addi	r5, r0, 1
fle_cont.17102:
	beqi	0, r5, beq_then.17103
	addi	r5, r0, 724				# set min_caml_solver_dist
	flw	f4, 1(r8)
	fmul	f4, f4, f3
	flw	f3, 2(r8)
	fmul	f2, f3, f2
	fadd	f3, f4, f2
	flw	f2, 3(r8)
	fmul	f1, f2, f1
	fadd	f1, f3, f1
	fsw	f1, 0(r5)
	addi	r5, r0, 1
	j	beq_cont.17104
beq_then.17103:
	addi	r5, r0, 0
beq_cont.17104:
beq_cont.17100:
	j	beq_cont.17098
beq_then.17097:
	lw	r5, 0(r9)
	sw	r6, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	add	r5, r0, r8
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_rect_fast.3054				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r6, 0(r3)
	lw	r1, 1(r3)
	lw	r2, 2(r3)
beq_cont.17098:
	addi	r7, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r7)
	beqi	0, r5, beq_then.17105
	flup	f2, 28		# fli	f2, -0.200000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17107
	addi	r5, r0, 0
	j	fle_cont.17108
fle_else.17107:
	addi	r5, r0, 1
fle_cont.17108:
	j	beq_cont.17106
beq_then.17105:
	addi	r5, r0, 0
beq_cont.17106:
	beqi	0, r5, beq_then.17109
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
	lw	r5, 0(r2)
	beqi	-1, r5, beq_then.17110
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r5, 0(r30)
	fsw	f3, 4(r3)
	fsw	f2, 6(r3)
	fsw	f4, 8(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	add	r1, r0, r5
	fadd	f1, f0, f4
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	is_outside.3128				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r5, r0, r1
	flw	f3, 4(r3)
	flw	f2, 6(r3)
	flw	f4, 8(r3)
	lw	r1, 1(r3)
	lw	r2, 2(r3)
	beqi	0, r5, beq_then.17113
	addi	r5, r0, 0
	j	beq_cont.17114
beq_then.17113:
	addi	r5, r0, 1
	add	r1, r0, r5
	fadd	f1, f0, f4
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	check_all_inside.3133				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r5, r0, r1
	lw	r1, 1(r3)
	lw	r2, 2(r3)
beq_cont.17114:
	j	beq_cont.17111
beq_then.17110:
	addi	r5, r0, 1
beq_cont.17111:
	beqi	0, r5, beq_then.17115
	addi	r1, r0, 1
	jr	r31				#
beq_then.17115:
	addi	r1, r1, 1
	j	shadow_check_and_group.3139
beq_then.17109:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r6
	lw	r5, 0(r30)
	lw	r5, 6(r5)
	beqi	0, r5, beq_then.17116
	addi	r1, r1, 1
	j	shadow_check_and_group.3139
beq_then.17116:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17096:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3142:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.17117
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
	beqi	0, r5, beq_then.17118
	addi	r1, r0, 1
	jr	r31				#
beq_then.17118:
	addi	r5, r1, 1
	add	r30, r2, r5
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.17119
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
	beqi	0, r1, beq_then.17120
	addi	r1, r0, 1
	jr	r31				#
beq_then.17120:
	addi	r5, r5, 1
	add	r30, r2, r5
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.17121
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
	beqi	0, r1, beq_then.17122
	addi	r1, r0, 1
	jr	r31				#
beq_then.17122:
	addi	r5, r5, 1
	add	r30, r2, r5
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.17123
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
	beqi	0, r1, beq_then.17124
	addi	r1, r0, 1
	jr	r31				#
beq_then.17124:
	addi	r1, r5, 1
	j	shadow_check_one_or_group.3142
beq_then.17123:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17121:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17119:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17117:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3145:
	add	r30, r2, r1
	lw	r8, 0(r30)
	lw	r5, 0(r8)
	beqi	-1, r5, beq_then.17125
	addi	r6, r0, 99
	beq	r5, r6, beq_then.17126
	addi	r9, r0, 1021				# set min_caml_light_dirvec
	addi	r10, r0, 727				# set min_caml_intersection_point
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r7, 0(r30)
	flw	f2, 0(r10)
	lw	r6, 5(r7)
	flw	f1, 0(r6)
	fsub	f3, f2, f1
	flw	f2, 1(r10)
	lw	r6, 5(r7)
	flw	f1, 1(r6)
	fsub	f2, f2, f1
	flw	f4, 2(r10)
	lw	r6, 5(r7)
	flw	f1, 2(r6)
	fsub	f1, f4, f1
	lw	r6, 1(r9)
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17128
	beqi	2, r5, beq_then.17130
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r8, 2(r3)
	add	r2, r0, r6
	add	r1, r0, r7
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_second_fast.3067				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	j	beq_cont.17131
beq_then.17130:
	flw	f4, 0(r6)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.17132
	addi	r5, r0, 0
	j	fle_cont.17133
fle_else.17132:
	addi	r5, r0, 1
fle_cont.17133:
	beqi	0, r5, beq_then.17134
	addi	r5, r0, 724				# set min_caml_solver_dist
	flw	f4, 1(r6)
	fmul	f4, f4, f3
	flw	f3, 2(r6)
	fmul	f2, f3, f2
	fadd	f3, f4, f2
	flw	f2, 3(r6)
	fmul	f1, f2, f1
	fadd	f1, f3, f1
	fsw	f1, 0(r5)
	addi	r5, r0, 1
	j	beq_cont.17135
beq_then.17134:
	addi	r5, r0, 0
beq_cont.17135:
beq_cont.17131:
	j	beq_cont.17129
beq_then.17128:
	lw	r5, 0(r9)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r8, 2(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	add	r5, r0, r6
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_rect_fast.3054				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
beq_cont.17129:
	beqi	0, r5, beq_then.17136
	flup	f2, 30		# fli	f2, -0.100000
	addi	r5, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r5)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17138
	addi	r5, r0, 0
	j	fle_cont.17139
fle_else.17138:
	lw	r5, 1(r8)
	beqi	-1, r5, beq_then.17140
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r8, 2(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	beqi	0, r5, beq_then.17142
	addi	r5, r0, 1
	j	beq_cont.17143
beq_then.17142:
	lw	r5, 2(r8)
	beqi	-1, r5, beq_then.17144
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	beqi	0, r5, beq_then.17146
	addi	r5, r0, 1
	j	beq_cont.17147
beq_then.17146:
	lw	r5, 3(r8)
	beqi	-1, r5, beq_then.17148
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	beqi	0, r5, beq_then.17150
	addi	r5, r0, 1
	j	beq_cont.17151
beq_then.17150:
	addi	r5, r0, 4
	add	r2, r0, r8
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_one_or_group.3142				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
beq_cont.17151:
	j	beq_cont.17149
beq_then.17148:
	addi	r5, r0, 0
beq_cont.17149:
beq_cont.17147:
	j	beq_cont.17145
beq_then.17144:
	addi	r5, r0, 0
beq_cont.17145:
beq_cont.17143:
	j	beq_cont.17141
beq_then.17140:
	addi	r5, r0, 0
beq_cont.17141:
	beqi	0, r5, beq_then.17152
	addi	r5, r0, 1
	j	beq_cont.17153
beq_then.17152:
	addi	r5, r0, 0
beq_cont.17153:
fle_cont.17139:
	j	beq_cont.17137
beq_then.17136:
	addi	r5, r0, 0
beq_cont.17137:
	j	beq_cont.17127
beq_then.17126:
	addi	r5, r0, 1
beq_cont.17127:
	beqi	0, r5, beq_then.17154
	lw	r5, 1(r8)
	beqi	-1, r5, beq_then.17155
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r8, 2(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	beqi	0, r5, beq_then.17157
	addi	r5, r0, 1
	j	beq_cont.17158
beq_then.17157:
	lw	r5, 2(r8)
	beqi	-1, r5, beq_then.17159
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	beqi	0, r5, beq_then.17161
	addi	r5, r0, 1
	j	beq_cont.17162
beq_then.17161:
	lw	r5, 3(r8)
	beqi	-1, r5, beq_then.17163
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	beqi	0, r5, beq_then.17165
	addi	r5, r0, 1
	j	beq_cont.17166
beq_then.17165:
	addi	r5, r0, 4
	add	r2, r0, r8
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_one_or_group.3142				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
beq_cont.17166:
	j	beq_cont.17164
beq_then.17163:
	addi	r5, r0, 0
beq_cont.17164:
beq_cont.17162:
	j	beq_cont.17160
beq_then.17159:
	addi	r5, r0, 0
beq_cont.17160:
beq_cont.17158:
	j	beq_cont.17156
beq_then.17155:
	addi	r5, r0, 0
beq_cont.17156:
	beqi	0, r5, beq_then.17167
	addi	r1, r0, 1
	jr	r31				#
beq_then.17167:
	addi	r1, r1, 1
	j	shadow_check_one_or_matrix.3145
beq_then.17154:
	addi	r1, r1, 1
	j	shadow_check_one_or_matrix.3145
beq_then.17125:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3148:
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.17168
	addi	r9, r0, 748				# set min_caml_startp
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r8
	lw	r7, 0(r30)
	flw	f2, 0(r9)
	lw	r6, 5(r7)
	flw	f1, 0(r6)
	fsub	f1, f2, f1
	flw	f3, 1(r9)
	lw	r6, 5(r7)
	flw	f2, 1(r6)
	fsub	f2, f3, f2
	flw	f4, 2(r9)
	lw	r6, 5(r7)
	flw	f3, 2(r6)
	fsub	f3, f4, f3
	lw	r6, 1(r7)
	beqi	1, r6, beq_then.17169
	beqi	2, r6, beq_then.17171
	sw	r8, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second.3044				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r6, r0, r1
	lw	r8, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r2, 3(r3)
	j	beq_cont.17172
beq_then.17171:
	sw	r8, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_surface.3025				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r6, r0, r1
	lw	r8, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r2, 3(r3)
beq_cont.17172:
	j	beq_cont.17170
beq_then.17169:
	addi	r10, r0, 0
	addi	r9, r0, 1
	addi	r6, r0, 2
	fsw	f3, 4(r3)
	fsw	f2, 6(r3)
	fsw	f1, 8(r3)
	sw	r7, 10(r3)
	sw	r8, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	add	r7, r0, r6
	add	r5, r0, r10
	add	r6, r0, r9
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solver_rect_surface.3010				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r6, r0, r1
	flw	f3, 4(r3)
	flw	f2, 6(r3)
	flw	f1, 8(r3)
	lw	r7, 10(r3)
	lw	r8, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r2, 3(r3)
	beqi	0, r6, beq_then.17173
	addi	r6, r0, 1
	j	beq_cont.17174
beq_then.17173:
	addi	r10, r0, 1
	addi	r9, r0, 2
	addi	r6, r0, 0
	add	r2, r0, r5
	add	r1, r0, r7
	add	r7, r0, r6
	add	r5, r0, r10
	add	r6, r0, r9
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f2
	fadd	f2, f0, f30
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solver_rect_surface.3010				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r6, r0, r1
	flw	f3, 4(r3)
	flw	f2, 6(r3)
	flw	f1, 8(r3)
	lw	r7, 10(r3)
	lw	r8, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r2, 3(r3)
	beqi	0, r6, beq_then.17175
	addi	r6, r0, 2
	j	beq_cont.17176
beq_then.17175:
	addi	r10, r0, 2
	addi	r9, r0, 0
	addi	r6, r0, 1
	add	r2, r0, r5
	add	r1, r0, r7
	add	r7, r0, r6
	add	r5, r0, r10
	add	r6, r0, r9
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f1
	fadd	f1, f0, f30
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solver_rect_surface.3010				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r6, r0, r1
	lw	r8, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r2, 3(r3)
	beqi	0, r6, beq_then.17177
	addi	r6, r0, 3
	j	beq_cont.17178
beq_then.17177:
	addi	r6, r0, 0
beq_cont.17178:
beq_cont.17176:
beq_cont.17174:
beq_cont.17170:
	beqi	0, r6, beq_then.17179
	addi	r7, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r7)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17180
	j	fle_cont.17181
fle_else.17180:
	addi	r7, r0, 726				# set min_caml_tmin
	flw	f2, 0(r7)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17182
	j	fle_cont.17183
fle_else.17182:
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	flw	f2, 0(r5)
	fmul	f3, f2, f1
	addi	r7, r0, 748				# set min_caml_startp
	flw	f2, 0(r7)
	fadd	f4, f3, f2
	flw	f2, 1(r5)
	fmul	f3, f2, f1
	addi	r7, r0, 748				# set min_caml_startp
	flw	f2, 1(r7)
	fadd	f2, f3, f2
	flw	f3, 2(r5)
	fmul	f5, f3, f1
	addi	r7, r0, 748				# set min_caml_startp
	flw	f3, 2(r7)
	fadd	f3, f5, f3
	lw	r7, 0(r2)
	beqi	-1, r7, beq_then.17184
	addi	r9, r0, 1				# set min_caml_objects
	add	r30, r9, r7
	lw	r7, 0(r30)
	fsw	f1, 12(r3)
	fsw	f3, 14(r3)
	fsw	f2, 16(r3)
	fsw	f4, 18(r3)
	sw	r6, 20(r3)
	add	r1, r0, r7
	fadd	f1, f0, f4
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	is_outside.3128				
	addi	r3, r3, -22
	lw	r31, 21(r3)
	add	r7, r0, r1
	flw	f1, 12(r3)
	flw	f3, 14(r3)
	flw	f2, 16(r3)
	flw	f4, 18(r3)
	lw	r6, 20(r3)
	lw	r8, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r2, 3(r3)
	beqi	0, r7, beq_then.17187
	addi	r7, r0, 0
	j	beq_cont.17188
beq_then.17187:
	addi	r7, r0, 1
	add	r1, r0, r7
	fadd	f1, f0, f4
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	check_all_inside.3133				
	addi	r3, r3, -22
	lw	r31, 21(r3)
	add	r7, r0, r1
	flw	f1, 12(r3)
	flw	f3, 14(r3)
	flw	f2, 16(r3)
	flw	f4, 18(r3)
	lw	r6, 20(r3)
	lw	r8, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r2, 3(r3)
beq_cont.17188:
	j	beq_cont.17185
beq_then.17184:
	addi	r7, r0, 1
beq_cont.17185:
	beqi	0, r7, beq_then.17189
	addi	r7, r0, 726				# set min_caml_tmin
	fsw	f1, 0(r7)
	addi	r7, r0, 727				# set min_caml_intersection_point
	fsw	f4, 0(r7)
	fsw	f2, 1(r7)
	fsw	f3, 2(r7)
	addi	r7, r0, 730				# set min_caml_intersected_object_id
	sw	r8, 0(r7)
	addi	r7, r0, 725				# set min_caml_intsec_rectside
	sw	r6, 0(r7)
	j	beq_cont.17190
beq_then.17189:
beq_cont.17190:
fle_cont.17183:
fle_cont.17181:
	addi	r1, r1, 1
	j	solve_each_element.3148
beq_then.17179:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r8
	lw	r6, 0(r30)
	lw	r6, 6(r6)
	beqi	0, r6, beq_then.17191
	addi	r1, r1, 1
	j	solve_each_element.3148
beq_then.17191:
	jr	r31				#
beq_then.17168:
	jr	r31				#
solve_one_or_network.3152:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.17194
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
	beqi	-1, r1, beq_then.17195
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
	beqi	-1, r1, beq_then.17196
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
	beqi	-1, r1, beq_then.17197
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
beq_then.17197:
	jr	r31				#
beq_then.17196:
	jr	r31				#
beq_then.17195:
	jr	r31				#
beq_then.17194:
	jr	r31				#
trace_or_matrix.3156:
	add	r30, r2, r1
	lw	r8, 0(r30)
	lw	r6, 0(r8)
	beqi	-1, r6, beq_then.17202
	addi	r7, r0, 99
	beq	r6, r7, beq_then.17203
	addi	r9, r0, 748				# set min_caml_startp
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r7, 0(r30)
	flw	f2, 0(r9)
	lw	r6, 5(r7)
	flw	f1, 0(r6)
	fsub	f1, f2, f1
	flw	f3, 1(r9)
	lw	r6, 5(r7)
	flw	f2, 1(r6)
	fsub	f2, f3, f2
	flw	f4, 2(r9)
	lw	r6, 5(r7)
	flw	f3, 2(r6)
	fsub	f3, f4, f3
	lw	r6, 1(r7)
	beqi	1, r6, beq_then.17205
	beqi	2, r6, beq_then.17207
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r8, 2(r3)
	sw	r5, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second.3044				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r6, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	lw	r5, 3(r3)
	j	beq_cont.17208
beq_then.17207:
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r8, 2(r3)
	sw	r5, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_surface.3025				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r6, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	lw	r5, 3(r3)
beq_cont.17208:
	j	beq_cont.17206
beq_then.17205:
	addi	r10, r0, 0
	addi	r9, r0, 1
	addi	r6, r0, 2
	fsw	f3, 4(r3)
	fsw	f2, 6(r3)
	fsw	f1, 8(r3)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r7, 10(r3)
	sw	r8, 2(r3)
	sw	r5, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	add	r7, r0, r6
	add	r5, r0, r10
	add	r6, r0, r9
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solver_rect_surface.3010				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r6, r0, r1
	flw	f3, 4(r3)
	flw	f2, 6(r3)
	flw	f1, 8(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r7, 10(r3)
	lw	r8, 2(r3)
	lw	r5, 3(r3)
	beqi	0, r6, beq_then.17209
	addi	r6, r0, 1
	j	beq_cont.17210
beq_then.17209:
	addi	r10, r0, 1
	addi	r9, r0, 2
	addi	r6, r0, 0
	add	r2, r0, r5
	add	r1, r0, r7
	add	r7, r0, r6
	add	r5, r0, r10
	add	r6, r0, r9
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f2
	fadd	f2, f0, f30
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solver_rect_surface.3010				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r6, r0, r1
	flw	f3, 4(r3)
	flw	f2, 6(r3)
	flw	f1, 8(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r7, 10(r3)
	lw	r8, 2(r3)
	lw	r5, 3(r3)
	beqi	0, r6, beq_then.17211
	addi	r6, r0, 2
	j	beq_cont.17212
beq_then.17211:
	addi	r10, r0, 2
	addi	r9, r0, 0
	addi	r6, r0, 1
	add	r2, r0, r5
	add	r1, r0, r7
	add	r7, r0, r6
	add	r5, r0, r10
	add	r6, r0, r9
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f1
	fadd	f1, f0, f30
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solver_rect_surface.3010				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r6, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	lw	r5, 3(r3)
	beqi	0, r6, beq_then.17213
	addi	r6, r0, 3
	j	beq_cont.17214
beq_then.17213:
	addi	r6, r0, 0
beq_cont.17214:
beq_cont.17212:
beq_cont.17210:
beq_cont.17206:
	beqi	0, r6, beq_then.17215
	addi	r6, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r6)
	addi	r6, r0, 726				# set min_caml_tmin
	flw	f2, 0(r6)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17217
	j	fle_cont.17218
fle_else.17217:
	lw	r6, 1(r8)
	beqi	-1, r6, beq_then.17219
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	lw	r5, 3(r3)
	lw	r6, 2(r8)
	beqi	-1, r6, beq_then.17221
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	lw	r5, 3(r3)
	lw	r6, 3(r8)
	beqi	-1, r6, beq_then.17223
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	lw	r5, 3(r3)
	addi	r6, r0, 4
	add	r2, r0, r8
	add	r1, r0, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_one_or_network.3152				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 3(r3)
	j	beq_cont.17224
beq_then.17223:
beq_cont.17224:
	j	beq_cont.17222
beq_then.17221:
beq_cont.17222:
	j	beq_cont.17220
beq_then.17219:
beq_cont.17220:
fle_cont.17218:
	j	beq_cont.17216
beq_then.17215:
beq_cont.17216:
	j	beq_cont.17204
beq_then.17203:
	lw	r6, 1(r8)
	beqi	-1, r6, beq_then.17225
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r8, 2(r3)
	sw	r5, 3(r3)
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	lw	r5, 3(r3)
	lw	r6, 2(r8)
	beqi	-1, r6, beq_then.17227
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	lw	r5, 3(r3)
	lw	r6, 3(r8)
	beqi	-1, r6, beq_then.17229
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3148				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	lw	r5, 3(r3)
	addi	r6, r0, 4
	add	r2, r0, r8
	add	r1, r0, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_one_or_network.3152				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 3(r3)
	j	beq_cont.17230
beq_then.17229:
beq_cont.17230:
	j	beq_cont.17228
beq_then.17227:
beq_cont.17228:
	j	beq_cont.17226
beq_then.17225:
beq_cont.17226:
beq_cont.17204:
	addi	r8, r1, 1
	add	r30, r2, r8
	lw	r6, 0(r30)
	lw	r1, 0(r6)
	beqi	-1, r1, beq_then.17231
	addi	r7, r0, 99
	beq	r1, r7, beq_then.17232
	addi	r7, r0, 748				# set min_caml_startp
	sw	r2, 0(r3)
	sw	r6, 11(r3)
	sw	r5, 3(r3)
	sw	r8, 12(r3)
	add	r2, r0, r5
	add	r5, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solver.3050				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 0(r3)
	lw	r6, 11(r3)
	lw	r5, 3(r3)
	lw	r8, 12(r3)
	beqi	0, r1, beq_then.17234
	addi	r1, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r1)
	addi	r1, r0, 726				# set min_caml_tmin
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17236
	j	fle_cont.17237
fle_else.17236:
	lw	r1, 1(r6)
	beqi	-1, r1, beq_then.17238
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 0(r3)
	lw	r6, 11(r3)
	lw	r5, 3(r3)
	lw	r8, 12(r3)
	lw	r1, 2(r6)
	beqi	-1, r1, beq_then.17240
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 0(r3)
	lw	r6, 11(r3)
	lw	r5, 3(r3)
	lw	r8, 12(r3)
	addi	r1, r0, 3
	add	r2, r0, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_one_or_network.3152				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 0(r3)
	lw	r5, 3(r3)
	lw	r8, 12(r3)
	j	beq_cont.17241
beq_then.17240:
beq_cont.17241:
	j	beq_cont.17239
beq_then.17238:
beq_cont.17239:
fle_cont.17237:
	j	beq_cont.17235
beq_then.17234:
beq_cont.17235:
	j	beq_cont.17233
beq_then.17232:
	lw	r1, 1(r6)
	beqi	-1, r1, beq_then.17242
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	sw	r2, 0(r3)
	sw	r6, 11(r3)
	sw	r5, 3(r3)
	sw	r8, 12(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 0(r3)
	lw	r6, 11(r3)
	lw	r5, 3(r3)
	lw	r8, 12(r3)
	lw	r1, 2(r6)
	beqi	-1, r1, beq_then.17244
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 0(r3)
	lw	r6, 11(r3)
	lw	r5, 3(r3)
	lw	r8, 12(r3)
	addi	r1, r0, 3
	add	r2, r0, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_one_or_network.3152				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 0(r3)
	lw	r5, 3(r3)
	lw	r8, 12(r3)
	j	beq_cont.17245
beq_then.17244:
beq_cont.17245:
	j	beq_cont.17243
beq_then.17242:
beq_cont.17243:
beq_cont.17233:
	addi	r1, r8, 1
	j	trace_or_matrix.3156
beq_then.17231:
	jr	r31				#
beq_then.17202:
	jr	r31				#
judge_intersection.3160:
	addi	r2, r0, 726				# set min_caml_tmin
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r2)
	addi	r2, r0, 723				# set min_caml_or_net
	lw	r7, 0(r2)
	lw	r5, 0(r7)
	lw	r2, 0(r5)
	beqi	-1, r2, beq_then.17248
	addi	r6, r0, 99
	beq	r2, r6, beq_then.17250
	addi	r6, r0, 748				# set min_caml_startp
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	sw	r7, 2(r3)
	add	r5, r0, r6
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver.3050				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	lw	r7, 2(r3)
	beqi	0, r2, beq_then.17252
	addi	r2, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r2)
	addi	r2, r0, 726				# set min_caml_tmin
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17254
	j	fle_cont.17255
fle_else.17254:
	lw	r2, 1(r5)
	beqi	-1, r2, beq_then.17256
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	lw	r7, 2(r3)
	lw	r2, 2(r5)
	beqi	-1, r2, beq_then.17258
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	lw	r7, 2(r3)
	addi	r2, r0, 3
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network.3152				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 1(r3)
	lw	r7, 2(r3)
	j	beq_cont.17259
beq_then.17258:
beq_cont.17259:
	j	beq_cont.17257
beq_then.17256:
beq_cont.17257:
fle_cont.17255:
	j	beq_cont.17253
beq_then.17252:
beq_cont.17253:
	j	beq_cont.17251
beq_then.17250:
	lw	r2, 1(r5)
	beqi	-1, r2, beq_then.17260
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	sw	r7, 2(r3)
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	lw	r7, 2(r3)
	lw	r2, 2(r5)
	beqi	-1, r2, beq_then.17262
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3148				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	lw	r7, 2(r3)
	addi	r2, r0, 3
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network.3152				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 1(r3)
	lw	r7, 2(r3)
	j	beq_cont.17263
beq_then.17262:
beq_cont.17263:
	j	beq_cont.17261
beq_then.17260:
beq_cont.17261:
beq_cont.17251:
	addi	r2, r0, 1
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix.3156				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.17249
beq_then.17248:
beq_cont.17249:
	addi	r1, r0, 726				# set min_caml_tmin
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17264
	addi	r1, r0, 0
	jr	r31				#
fle_else.17264:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17265
	addi	r1, r0, 0
	jr	r31				#
fle_else.17265:
	addi	r1, r0, 1
	jr	r31				#
solve_each_element_fast.3162:
	lw	r7, 0(r5)
	add	r30, r2, r1
	lw	r10, 0(r30)
	beqi	-1, r10, beq_then.17266
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r10
	lw	r9, 0(r30)
	lw	r8, 10(r9)
	flw	f3, 0(r8)
	flw	f2, 1(r8)
	flw	f1, 2(r8)
	lw	r6, 1(r5)
	add	r30, r6, r10
	lw	r11, 0(r30)
	lw	r6, 1(r9)
	beqi	1, r6, beq_then.17267
	beqi	2, r6, beq_then.17269
	sw	r7, 0(r3)
	sw	r10, 1(r3)
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	add	r5, r0, r8
	add	r2, r0, r11
	add	r1, r0, r9
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_second_fast2.3084				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r6, r0, r1
	lw	r7, 0(r3)
	lw	r10, 1(r3)
	lw	r1, 2(r3)
	lw	r5, 3(r3)
	lw	r2, 4(r3)
	j	beq_cont.17270
beq_then.17269:
	flw	f1, 0(r11)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17271
	addi	r6, r0, 0
	j	fle_cont.17272
fle_else.17271:
	addi	r6, r0, 1
fle_cont.17272:
	beqi	0, r6, beq_then.17273
	addi	r6, r0, 724				# set min_caml_solver_dist
	flw	f2, 0(r11)
	flw	f1, 3(r8)
	fmul	f1, f2, f1
	fsw	f1, 0(r6)
	addi	r6, r0, 1
	j	beq_cont.17274
beq_then.17273:
	addi	r6, r0, 0
beq_cont.17274:
beq_cont.17270:
	j	beq_cont.17268
beq_then.17267:
	lw	r6, 0(r5)
	sw	r7, 0(r3)
	sw	r10, 1(r3)
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	add	r5, r0, r11
	add	r2, r0, r6
	add	r1, r0, r9
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_rect_fast.3054				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r6, r0, r1
	lw	r7, 0(r3)
	lw	r10, 1(r3)
	lw	r1, 2(r3)
	lw	r5, 3(r3)
	lw	r2, 4(r3)
beq_cont.17268:
	beqi	0, r6, beq_then.17275
	addi	r8, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r8)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17276
	j	fle_cont.17277
fle_else.17276:
	addi	r8, r0, 726				# set min_caml_tmin
	flw	f2, 0(r8)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17278
	j	fle_cont.17279
fle_else.17278:
	flup	f2, 29		# fli	f2, 0.010000
	fadd	f1, f1, f2
	flw	f2, 0(r7)
	fmul	f3, f2, f1
	addi	r8, r0, 751				# set min_caml_startp_fast
	flw	f2, 0(r8)
	fadd	f4, f3, f2
	flw	f2, 1(r7)
	fmul	f3, f2, f1
	addi	r8, r0, 751				# set min_caml_startp_fast
	flw	f2, 1(r8)
	fadd	f2, f3, f2
	flw	f3, 2(r7)
	fmul	f5, f3, f1
	addi	r7, r0, 751				# set min_caml_startp_fast
	flw	f3, 2(r7)
	fadd	f3, f5, f3
	lw	r7, 0(r2)
	beqi	-1, r7, beq_then.17280
	addi	r8, r0, 1				# set min_caml_objects
	add	r30, r8, r7
	lw	r7, 0(r30)
	fsw	f1, 6(r3)
	fsw	f3, 8(r3)
	fsw	f2, 10(r3)
	fsw	f4, 12(r3)
	sw	r6, 14(r3)
	sw	r10, 1(r3)
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	add	r1, r0, r7
	fadd	f1, f0, f4
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	is_outside.3128				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r7, r0, r1
	flw	f1, 6(r3)
	flw	f3, 8(r3)
	flw	f2, 10(r3)
	flw	f4, 12(r3)
	lw	r6, 14(r3)
	lw	r10, 1(r3)
	lw	r1, 2(r3)
	lw	r5, 3(r3)
	lw	r2, 4(r3)
	beqi	0, r7, beq_then.17283
	addi	r7, r0, 0
	j	beq_cont.17284
beq_then.17283:
	addi	r7, r0, 1
	add	r1, r0, r7
	fadd	f1, f0, f4
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	check_all_inside.3133				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r7, r0, r1
	flw	f1, 6(r3)
	flw	f3, 8(r3)
	flw	f2, 10(r3)
	flw	f4, 12(r3)
	lw	r6, 14(r3)
	lw	r10, 1(r3)
	lw	r1, 2(r3)
	lw	r5, 3(r3)
	lw	r2, 4(r3)
beq_cont.17284:
	j	beq_cont.17281
beq_then.17280:
	addi	r7, r0, 1
beq_cont.17281:
	beqi	0, r7, beq_then.17285
	addi	r7, r0, 726				# set min_caml_tmin
	fsw	f1, 0(r7)
	addi	r7, r0, 727				# set min_caml_intersection_point
	fsw	f4, 0(r7)
	fsw	f2, 1(r7)
	fsw	f3, 2(r7)
	addi	r7, r0, 730				# set min_caml_intersected_object_id
	sw	r10, 0(r7)
	addi	r7, r0, 725				# set min_caml_intsec_rectside
	sw	r6, 0(r7)
	j	beq_cont.17286
beq_then.17285:
beq_cont.17286:
fle_cont.17279:
fle_cont.17277:
	addi	r1, r1, 1
	j	solve_each_element_fast.3162
beq_then.17275:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r10
	lw	r6, 0(r30)
	lw	r6, 6(r6)
	beqi	0, r6, beq_then.17287
	addi	r1, r1, 1
	j	solve_each_element_fast.3162
beq_then.17287:
	jr	r31				#
beq_then.17266:
	jr	r31				#
solve_one_or_network_fast.3166:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.17290
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
	beqi	-1, r1, beq_then.17291
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
	beqi	-1, r1, beq_then.17292
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
	beqi	-1, r1, beq_then.17293
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
beq_then.17293:
	jr	r31				#
beq_then.17292:
	jr	r31				#
beq_then.17291:
	jr	r31				#
beq_then.17290:
	jr	r31				#
trace_or_matrix_fast.3170:
	add	r30, r2, r1
	lw	r10, 0(r30)
	lw	r6, 0(r10)
	beqi	-1, r6, beq_then.17298
	addi	r7, r0, 99
	beq	r6, r7, beq_then.17299
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r9, 0(r30)
	lw	r7, 10(r9)
	flw	f3, 0(r7)
	flw	f2, 1(r7)
	flw	f1, 2(r7)
	lw	r8, 1(r5)
	add	r30, r8, r6
	lw	r8, 0(r30)
	lw	r6, 1(r9)
	beqi	1, r6, beq_then.17301
	beqi	2, r6, beq_then.17303
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r10, 2(r3)
	sw	r5, 3(r3)
	add	r5, r0, r7
	add	r2, r0, r8
	add	r1, r0, r9
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second_fast2.3084				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r6, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r10, 2(r3)
	lw	r5, 3(r3)
	j	beq_cont.17304
beq_then.17303:
	flw	f1, 0(r8)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17305
	addi	r6, r0, 0
	j	fle_cont.17306
fle_else.17305:
	addi	r6, r0, 1
fle_cont.17306:
	beqi	0, r6, beq_then.17307
	addi	r6, r0, 724				# set min_caml_solver_dist
	flw	f2, 0(r8)
	flw	f1, 3(r7)
	fmul	f1, f2, f1
	fsw	f1, 0(r6)
	addi	r6, r0, 1
	j	beq_cont.17308
beq_then.17307:
	addi	r6, r0, 0
beq_cont.17308:
beq_cont.17304:
	j	beq_cont.17302
beq_then.17301:
	lw	r6, 0(r5)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r10, 2(r3)
	sw	r5, 3(r3)
	add	r5, r0, r8
	add	r2, r0, r6
	add	r1, r0, r9
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_rect_fast.3054				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r6, r0, r1
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r10, 2(r3)
	lw	r5, 3(r3)
beq_cont.17302:
	beqi	0, r6, beq_then.17309
	addi	r6, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r6)
	addi	r6, r0, 726				# set min_caml_tmin
	flw	f2, 0(r6)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17311
	j	fle_cont.17312
fle_else.17311:
	lw	r6, 1(r10)
	beqi	-1, r6, beq_then.17313
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r10, 2(r3)
	sw	r5, 3(r3)
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r10, 2(r3)
	lw	r5, 3(r3)
	lw	r6, 2(r10)
	beqi	-1, r6, beq_then.17315
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r10, 2(r3)
	lw	r5, 3(r3)
	lw	r6, 3(r10)
	beqi	-1, r6, beq_then.17317
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r10, 2(r3)
	lw	r5, 3(r3)
	addi	r6, r0, 4
	add	r2, r0, r10
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 3(r3)
	j	beq_cont.17318
beq_then.17317:
beq_cont.17318:
	j	beq_cont.17316
beq_then.17315:
beq_cont.17316:
	j	beq_cont.17314
beq_then.17313:
beq_cont.17314:
fle_cont.17312:
	j	beq_cont.17310
beq_then.17309:
beq_cont.17310:
	j	beq_cont.17300
beq_then.17299:
	lw	r6, 1(r10)
	beqi	-1, r6, beq_then.17319
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r10, 2(r3)
	sw	r5, 3(r3)
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r10, 2(r3)
	lw	r5, 3(r3)
	lw	r6, 2(r10)
	beqi	-1, r6, beq_then.17321
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r10, 2(r3)
	lw	r5, 3(r3)
	lw	r6, 3(r10)
	beqi	-1, r6, beq_then.17323
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r10, 2(r3)
	lw	r5, 3(r3)
	addi	r6, r0, 4
	add	r2, r0, r10
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 3(r3)
	j	beq_cont.17324
beq_then.17323:
beq_cont.17324:
	j	beq_cont.17322
beq_then.17321:
beq_cont.17322:
	j	beq_cont.17320
beq_then.17319:
beq_cont.17320:
beq_cont.17300:
	addi	r8, r1, 1
	add	r30, r2, r8
	lw	r6, 0(r30)
	lw	r1, 0(r6)
	beqi	-1, r1, beq_then.17325
	addi	r7, r0, 99
	beq	r1, r7, beq_then.17326
	sw	r2, 0(r3)
	sw	r6, 4(r3)
	sw	r5, 3(r3)
	sw	r8, 5(r3)
	add	r2, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solver_fast2.3091				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 0(r3)
	lw	r6, 4(r3)
	lw	r5, 3(r3)
	lw	r8, 5(r3)
	beqi	0, r1, beq_then.17328
	addi	r1, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r1)
	addi	r1, r0, 726				# set min_caml_tmin
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17330
	j	fle_cont.17331
fle_else.17330:
	lw	r1, 1(r6)
	beqi	-1, r1, beq_then.17332
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 0(r3)
	lw	r6, 4(r3)
	lw	r5, 3(r3)
	lw	r8, 5(r3)
	lw	r1, 2(r6)
	beqi	-1, r1, beq_then.17334
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 0(r3)
	lw	r6, 4(r3)
	lw	r5, 3(r3)
	lw	r8, 5(r3)
	addi	r1, r0, 3
	add	r2, r0, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 0(r3)
	lw	r5, 3(r3)
	lw	r8, 5(r3)
	j	beq_cont.17335
beq_then.17334:
beq_cont.17335:
	j	beq_cont.17333
beq_then.17332:
beq_cont.17333:
fle_cont.17331:
	j	beq_cont.17329
beq_then.17328:
beq_cont.17329:
	j	beq_cont.17327
beq_then.17326:
	lw	r1, 1(r6)
	beqi	-1, r1, beq_then.17336
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	sw	r2, 0(r3)
	sw	r6, 4(r3)
	sw	r5, 3(r3)
	sw	r8, 5(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 0(r3)
	lw	r6, 4(r3)
	lw	r5, 3(r3)
	lw	r8, 5(r3)
	lw	r1, 2(r6)
	beqi	-1, r1, beq_then.17338
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 0(r3)
	lw	r6, 4(r3)
	lw	r5, 3(r3)
	lw	r8, 5(r3)
	addi	r1, r0, 3
	add	r2, r0, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 0(r3)
	lw	r5, 3(r3)
	lw	r8, 5(r3)
	j	beq_cont.17339
beq_then.17338:
beq_cont.17339:
	j	beq_cont.17337
beq_then.17336:
beq_cont.17337:
beq_cont.17327:
	addi	r1, r8, 1
	j	trace_or_matrix_fast.3170
beq_then.17325:
	jr	r31				#
beq_then.17298:
	jr	r31				#
judge_intersection_fast.3174:
	addi	r2, r0, 726				# set min_caml_tmin
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r2)
	addi	r2, r0, 723				# set min_caml_or_net
	lw	r7, 0(r2)
	lw	r5, 0(r7)
	lw	r2, 0(r5)
	beqi	-1, r2, beq_then.17342
	addi	r6, r0, 99
	beq	r2, r6, beq_then.17344
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	sw	r7, 2(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_fast2.3091				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	lw	r7, 2(r3)
	beqi	0, r2, beq_then.17346
	addi	r2, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r2)
	addi	r2, r0, 726				# set min_caml_tmin
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17348
	j	fle_cont.17349
fle_else.17348:
	lw	r2, 1(r5)
	beqi	-1, r2, beq_then.17350
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	lw	r7, 2(r3)
	lw	r2, 2(r5)
	beqi	-1, r2, beq_then.17352
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	lw	r7, 2(r3)
	addi	r2, r0, 3
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 1(r3)
	lw	r7, 2(r3)
	j	beq_cont.17353
beq_then.17352:
beq_cont.17353:
	j	beq_cont.17351
beq_then.17350:
beq_cont.17351:
fle_cont.17349:
	j	beq_cont.17347
beq_then.17346:
beq_cont.17347:
	j	beq_cont.17345
beq_then.17344:
	lw	r2, 1(r5)
	beqi	-1, r2, beq_then.17354
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	sw	r7, 2(r3)
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	lw	r7, 2(r3)
	lw	r2, 2(r5)
	beqi	-1, r2, beq_then.17356
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r2
	lw	r2, 0(r30)
	addi	r6, r0, 0
	add	r5, r0, r1
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r5, 0(r3)
	lw	r1, 1(r3)
	lw	r7, 2(r3)
	addi	r2, r0, 3
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 1(r3)
	lw	r7, 2(r3)
	j	beq_cont.17357
beq_then.17356:
beq_cont.17357:
	j	beq_cont.17355
beq_then.17354:
beq_cont.17355:
beq_cont.17345:
	addi	r2, r0, 1
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix_fast.3170				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.17343
beq_then.17342:
beq_cont.17343:
	addi	r1, r0, 726				# set min_caml_tmin
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17358
	addi	r1, r0, 0
	jr	r31				#
fle_else.17358:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17359
	addi	r1, r0, 0
	jr	r31				#
fle_else.17359:
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
	beq	r0, r30, feq_else.17360
	addi	r1, r0, 1
	j	feq_cont.17361
feq_else.17360:
	addi	r1, r0, 0
feq_cont.17361:
	beqi	0, r1, beq_then.17362
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.17363
beq_then.17362:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17364
	addi	r1, r0, 0
	j	fle_cont.17365
fle_else.17364:
	addi	r1, r0, 1
fle_cont.17365:
	beqi	0, r1, beq_then.17366
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.17367
beq_then.17366:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.17367:
beq_cont.17363:
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
	beqi	0, r2, beq_then.17370
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
	j	beq_cont.17371
beq_then.17370:
	addi	r2, r0, 731				# set min_caml_nvector
	fsw	f6, 0(r2)
	addi	r2, r0, 731				# set min_caml_nvector
	fsw	f5, 1(r2)
	addi	r2, r0, 731				# set min_caml_nvector
	fsw	f4, 2(r2)
beq_cont.17371:
	addi	r5, r0, 731				# set min_caml_nvector
	lw	r2, 6(r1)
	add	r1, r0, r5
	j	vecunit_sgn.2888
get_nvector.3182:
	lw	r5, 1(r1)
	beqi	1, r5, beq_then.17372
	beqi	2, r5, beq_then.17373
	j	get_nvector_second.3180
beq_then.17373:
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
beq_then.17372:
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
	beq	r0, r30, feq_else.17375
	addi	r1, r0, 1
	j	feq_cont.17376
feq_else.17375:
	addi	r1, r0, 0
feq_cont.17376:
	beqi	0, r1, beq_then.17377
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.17378
beq_then.17377:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17379
	addi	r1, r0, 0
	j	fle_cont.17380
fle_else.17379:
	addi	r1, r0, 1
fle_cont.17380:
	beqi	0, r1, beq_then.17381
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.17382
beq_then.17381:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.17382:
beq_cont.17378:
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
	beqi	1, r5, beq_then.17384
	beqi	2, r5, beq_then.17385
	beqi	3, r5, beq_then.17386
	beqi	4, r5, beq_then.17387
	jr	r31				#
beq_then.17387:
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
	beq	r0, r30, fle_else.17389
	fadd	f4, f0, f2
	j	fle_cont.17390
fle_else.17389:
	fneg	f4, f2
fle_cont.17390:
	fle	r30, f5, f4
	beq	r0, r30, fle_else.17391
	finv	f31, f2
	fmul	f1, f1, f31
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17393
	j	fle_cont.17394
fle_else.17393:
	fneg	f1, f1
fle_cont.17394:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17395
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.17396
fle_else.17395:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.17396:
	fmul	f1, f1, f2
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17397
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17399
	flup	f5, 15		# fli	f5, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	finv	f31, f1
	fmul	f1, f4, f31
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f5, 4(r3)
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	atan_body.2841				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f5, 4(r3)
	lw	r2, 6(r3)
	lw	r1, 7(r3)
	fadd	f1, f5, f1
	fmul	f2, f1, f2
	j	fle_cont.17400
fle_else.17399:
	flup	f6, 16		# fli	f6, 0.785398
	flup	f4, 2		# fli	f4, 1.000000
	fsub	f5, f1, f4
	flup	f4, 2		# fli	f4, 1.000000
	fadd	f1, f1, f4
	finv	f31, f1
	fmul	f1, f5, f31
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f6, 8(r3)
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2841				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f6, 8(r3)
	lw	r2, 6(r3)
	lw	r1, 7(r3)
	fadd	f1, f6, f1
	fmul	f2, f1, f2
fle_cont.17400:
	j	fle_cont.17398
fle_else.17397:
	fsw	f3, 0(r3)
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2841				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	fadd	f2, f0, f1
	flw	f3, 0(r3)
	lw	r2, 6(r3)
	lw	r1, 7(r3)
fle_cont.17398:
	flup	f1, 35		# fli	f1, 30.000000
	fmul	f2, f2, f1
	flup	f1, 14		# fli	f1, 3.141593
	finv	f31, f1
	fmul	f2, f2, f31
	j	fle_cont.17392
fle_else.17391:
	flup	f2, 34		# fli	f2, 15.000000
fle_cont.17392:
	ftoi	r5, f2
	itof	f1, r5
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17401
	j	fle_cont.17402
fle_else.17401:
	flup	f4, 2		# fli	f4, 1.000000
	fsub	f1, f1, f4
fle_cont.17402:
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
	beq	r0, r30, fle_else.17403
	fadd	f4, f0, f3
	j	fle_cont.17404
fle_else.17403:
	fneg	f4, f3
fle_cont.17404:
	fle	r30, f5, f4
	beq	r0, r30, fle_else.17405
	finv	f31, f3
	fmul	f1, f1, f31
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17407
	j	fle_cont.17408
fle_else.17407:
	fneg	f1, f1
fle_cont.17408:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17409
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.17410
fle_else.17409:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.17410:
	fmul	f1, f1, f3
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17411
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17413
	flup	f5, 15		# fli	f5, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	finv	f31, f1
	fmul	f1, f4, f31
	fsw	f2, 10(r3)
	fsw	f3, 12(r3)
	fsw	f5, 14(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2841				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 10(r3)
	flw	f3, 12(r3)
	flw	f5, 14(r3)
	fadd	f1, f5, f1
	fmul	f3, f1, f3
	j	fle_cont.17414
fle_else.17413:
	flup	f6, 16		# fli	f6, 0.785398
	flup	f4, 2		# fli	f4, 1.000000
	fsub	f5, f1, f4
	flup	f4, 2		# fli	f4, 1.000000
	fadd	f1, f1, f4
	finv	f31, f1
	fmul	f1, f5, f31
	fsw	f2, 10(r3)
	fsw	f3, 12(r3)
	fsw	f6, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2841				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 10(r3)
	flw	f3, 12(r3)
	flw	f6, 16(r3)
	fadd	f1, f6, f1
	fmul	f3, f1, f3
fle_cont.17414:
	j	fle_cont.17412
fle_else.17411:
	fsw	f2, 10(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2841				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	fadd	f3, f0, f1
	flw	f2, 10(r3)
fle_cont.17412:
	flup	f1, 35		# fli	f1, 30.000000
	fmul	f3, f3, f1
	flup	f1, 14		# fli	f1, 3.141593
	finv	f31, f1
	fmul	f3, f3, f31
	j	fle_cont.17406
fle_else.17405:
	flup	f3, 34		# fli	f3, 15.000000
fle_cont.17406:
	ftoi	r1, f3
	itof	f1, r1
	fle	r30, f1, f3
	beq	r0, r30, fle_else.17415
	j	fle_cont.17416
fle_else.17415:
	flup	f4, 2		# fli	f4, 1.000000
	fsub	f1, f1, f4
fle_cont.17416:
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
	beq	r0, r30, fle_else.17417
	addi	r1, r0, 0
	j	fle_cont.17418
fle_else.17417:
	addi	r1, r0, 1
fle_cont.17418:
	beqi	0, r1, beq_then.17419
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.17420
beq_then.17419:
beq_cont.17420:
	addi	r1, r0, 734				# set min_caml_texture_color
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f2, f1
	flup	f1, 38		# fli	f1, 0.300000
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.17386:
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
	beq	r0, r30, fle_else.17422
	j	fle_cont.17423
fle_else.17422:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f1, f1, f3
fle_cont.17423:
	fsub	f2, f2, f1
	flup	f1, 14		# fli	f1, 3.141593
	fmul	f1, f2, f1
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	cos.2839				
	addi	r3, r3, -19
	lw	r31, 18(r3)
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
beq_then.17385:
	flw	f2, 1(r2)
	flup	f1, 40		# fli	f1, 0.250000
	fmul	f1, f2, f1
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	sin.2837				
	addi	r3, r3, -19
	lw	r31, 18(r3)
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
beq_then.17384:
	flw	f1, 0(r2)
	lw	r5, 5(r1)
	flw	f2, 0(r5)
	fsub	f2, f1, f2
	flup	f1, 41		# fli	f1, 0.050000
	fmul	f3, f2, f1
	ftoi	r5, f3
	itof	f1, r5
	fle	r30, f1, f3
	beq	r0, r30, fle_else.17426
	fadd	f3, f0, f1
	j	fle_cont.17427
fle_else.17426:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f3, f1, f3
fle_cont.17427:
	flup	f1, 42		# fli	f1, 20.000000
	fmul	f1, f3, f1
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f2, f1
	fle	r30, f3, f1
	beq	r0, r30, fle_else.17428
	addi	r5, r0, 0
	j	fle_cont.17429
fle_else.17428:
	addi	r5, r0, 1
fle_cont.17429:
	flw	f2, 2(r2)
	lw	r1, 5(r1)
	flw	f1, 2(r1)
	fsub	f2, f2, f1
	flup	f1, 41		# fli	f1, 0.050000
	fmul	f3, f2, f1
	ftoi	r1, f3
	itof	f1, r1
	fle	r30, f1, f3
	beq	r0, r30, fle_else.17430
	fadd	f3, f0, f1
	j	fle_cont.17431
fle_else.17430:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f3, f1, f3
fle_cont.17431:
	flup	f1, 42		# fli	f1, 20.000000
	fmul	f1, f3, f1
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f2, f1
	fle	r30, f3, f1
	beq	r0, r30, fle_else.17432
	addi	r1, r0, 0
	j	fle_cont.17433
fle_else.17432:
	addi	r1, r0, 1
fle_cont.17433:
	addi	r2, r0, 734				# set min_caml_texture_color
	beqi	0, r5, beq_then.17434
	beqi	0, r1, beq_then.17436
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.17437
beq_then.17436:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.17437:
	j	beq_cont.17435
beq_then.17434:
	beqi	0, r1, beq_then.17438
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.17439
beq_then.17438:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.17439:
beq_cont.17435:
	fsw	f1, 1(r2)
	jr	r31				#
add_light.3188:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17441
	addi	r1, r0, 0
	j	fle_cont.17442
fle_else.17441:
	addi	r1, r0, 1
fle_cont.17442:
	beqi	0, r1, beq_then.17443
	addi	r2, r0, 740				# set min_caml_rgb
	addi	r1, r0, 734				# set min_caml_texture_color
	flw	f5, 0(r2)
	flw	f4, 0(r1)
	fmul	f4, f1, f4
	fadd	f4, f5, f4
	fsw	f4, 0(r2)
	flw	f5, 1(r2)
	flw	f4, 1(r1)
	fmul	f4, f1, f4
	fadd	f4, f5, f4
	fsw	f4, 1(r2)
	flw	f5, 2(r2)
	flw	f4, 2(r1)
	fmul	f1, f1, f4
	fadd	f1, f5, f1
	fsw	f1, 2(r2)
	j	beq_cont.17444
beq_then.17443:
beq_cont.17444:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.17445
	addi	r1, r0, 0
	j	fle_cont.17446
fle_else.17445:
	addi	r1, r0, 1
fle_cont.17446:
	beqi	0, r1, beq_then.17447
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
beq_then.17447:
	jr	r31				#
trace_reflections.3192:
	bgei	0, r1, bge_then.17450
	jr	r31				#
bge_then.17450:
	addi	r5, r0, 778				# set min_caml_reflections
	add	r30, r5, r1
	lw	r6, 0(r30)
	lw	r8, 1(r6)
	addi	r5, r0, 726				# set min_caml_tmin
	flup	f3, 31		# fli	f3, 1000000000.000000
	fsw	f3, 0(r5)
	addi	r5, r0, 0
	addi	r7, r0, 723				# set min_caml_or_net
	lw	r7, 0(r7)
	fsw	f2, 0(r3)
	fsw	f1, 2(r3)
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	add	r2, r0, r7
	add	r1, r0, r5
	add	r5, r0, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	trace_or_matrix_fast.3170				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 0(r3)
	flw	f1, 2(r3)
	lw	r6, 4(r3)
	lw	r8, 5(r3)
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	addi	r5, r0, 726				# set min_caml_tmin
	flw	f3, 0(r5)
	flup	f4, 30		# fli	f4, -0.100000
	fle	r30, f3, f4
	beq	r0, r30, fle_else.17452
	addi	r5, r0, 0
	j	fle_cont.17453
fle_else.17452:
	flup	f4, 32		# fli	f4, 100000000.000000
	fle	r30, f4, f3
	beq	r0, r30, fle_else.17454
	addi	r5, r0, 0
	j	fle_cont.17455
fle_else.17454:
	addi	r5, r0, 1
fle_cont.17455:
fle_cont.17453:
	beqi	0, r5, beq_then.17456
	addi	r5, r0, 730				# set min_caml_intersected_object_id
	lw	r5, 0(r5)
	slli	r7, r5, 2
	addi	r5, r0, 725				# set min_caml_intsec_rectside
	lw	r5, 0(r5)
	add	r5, r7, r5
	lw	r7, 0(r6)
	beq	r5, r7, beq_then.17458
	j	beq_cont.17459
beq_then.17458:
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
	flw	f2, 0(r3)
	flw	f1, 2(r3)
	lw	r6, 4(r3)
	lw	r8, 5(r3)
	lw	r1, 6(r3)
	lw	r2, 7(r3)
	beqi	0, r5, beq_then.17460
	j	beq_cont.17461
beq_then.17460:
	addi	r7, r0, 731				# set min_caml_nvector
	lw	r5, 0(r8)
	flw	f4, 0(r7)
	flw	f3, 0(r5)
	fmul	f5, f4, f3
	flw	f4, 1(r7)
	flw	f3, 1(r5)
	fmul	f3, f4, f3
	fadd	f5, f5, f3
	flw	f4, 2(r7)
	flw	f3, 2(r5)
	fmul	f3, f4, f3
	fadd	f3, f5, f3
	flw	f4, 2(r6)
	fmul	f5, f4, f1
	fmul	f5, f5, f3
	lw	r5, 0(r8)
	flw	f6, 0(r2)
	flw	f3, 0(r5)
	fmul	f7, f6, f3
	flw	f6, 1(r2)
	flw	f3, 1(r5)
	fmul	f3, f6, f3
	fadd	f7, f7, f3
	flw	f6, 2(r2)
	flw	f3, 2(r5)
	fmul	f3, f6, f3
	fadd	f3, f7, f3
	fmul	f3, f4, f3
	fadd	f1, f0, f5
	fadd	f30, f0, f3
	fadd	f3, f0, f2
	fadd	f2, f0, f30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	add_light.3188				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 0(r3)
	flw	f1, 2(r3)
	lw	r1, 6(r3)
	lw	r2, 7(r3)
beq_cont.17461:
beq_cont.17459:
	j	beq_cont.17457
beq_then.17456:
beq_cont.17457:
	addi	r1, r1, -1
	j	trace_reflections.3192
trace_ray.3197:
	blei	4, r1, ble_then.17462
	jr	r31				#
ble_then.17462:
	lw	r10, 2(r5)
	addi	r6, r0, 726				# set min_caml_tmin
	flup	f3, 31		# fli	f3, 1000000000.000000
	fsw	f3, 0(r6)
	addi	r6, r0, 0
	addi	r7, r0, 723				# set min_caml_or_net
	lw	r7, 0(r7)
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
	addi	r6, r0, 726				# set min_caml_tmin
	flw	f3, 0(r6)
	flup	f4, 30		# fli	f4, -0.100000
	fle	r30, f3, f4
	beq	r0, r30, fle_else.17464
	addi	r6, r0, 0
	j	fle_cont.17465
fle_else.17464:
	flup	f4, 32		# fli	f4, 100000000.000000
	fle	r30, f4, f3
	beq	r0, r30, fle_else.17466
	addi	r6, r0, 0
	j	fle_cont.17467
fle_else.17466:
	addi	r6, r0, 1
fle_cont.17467:
fle_cont.17465:
	beqi	0, r6, beq_then.17468
	addi	r6, r0, 730				# set min_caml_intersected_object_id
	lw	r7, 0(r6)
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r7
	lw	r8, 0(r30)
	lw	r9, 2(r8)
	lw	r6, 7(r8)
	flw	f3, 0(r6)
	fmul	f5, f3, f1
	lw	r6, 1(r8)
	beqi	1, r6, beq_then.17469
	beqi	2, r6, beq_then.17471
	fsw	f5, 8(r3)
	sw	r7, 10(r3)
	sw	r8, 11(r3)
	sw	r9, 12(r3)
	add	r1, r0, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	get_nvector_second.3180				
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
	j	beq_cont.17472
beq_then.17471:
	addi	r11, r0, 731				# set min_caml_nvector
	lw	r6, 4(r8)
	flw	f3, 0(r6)
	fneg	f3, f3
	fsw	f3, 0(r11)
	addi	r11, r0, 731				# set min_caml_nvector
	lw	r6, 4(r8)
	flw	f3, 1(r6)
	fneg	f3, f3
	fsw	f3, 1(r11)
	addi	r11, r0, 731				# set min_caml_nvector
	lw	r6, 4(r8)
	flw	f3, 2(r6)
	fneg	f3, f3
	fsw	f3, 2(r11)
beq_cont.17472:
	j	beq_cont.17470
beq_then.17469:
	addi	r6, r0, 725				# set min_caml_intsec_rectside
	lw	r6, 0(r6)
	addi	r11, r0, 731				# set min_caml_nvector
	fsw	f0, 0(r11)
	fsw	f0, 1(r11)
	fsw	f0, 2(r11)
	addi	r12, r0, 731				# set min_caml_nvector
	addi	r11, r6, -1
	addi	r6, r6, -1
	add	r30, r2, r6
	flw	f3, 0(r30)
	feq	r30, f3, f0
	beq	r0, r30, feq_else.17473
	addi	r6, r0, 1
	j	feq_cont.17474
feq_else.17473:
	addi	r6, r0, 0
feq_cont.17474:
	beqi	0, r6, beq_then.17475
	flup	f3, 0		# fli	f3, 0.000000
	j	beq_cont.17476
beq_then.17475:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.17477
	addi	r6, r0, 0
	j	fle_cont.17478
fle_else.17477:
	addi	r6, r0, 1
fle_cont.17478:
	beqi	0, r6, beq_then.17479
	flup	f3, 2		# fli	f3, 1.000000
	j	beq_cont.17480
beq_then.17479:
	flup	f3, 11		# fli	f3, -1.000000
beq_cont.17480:
beq_cont.17476:
	fneg	f3, f3
	add	r30, r12, r11
	fsw	f3, 0(r30)
beq_cont.17470:
	addi	r11, r0, 748				# set min_caml_startp
	addi	r6, r0, 727				# set min_caml_intersection_point
	flw	f3, 0(r6)
	fsw	f3, 0(r11)
	flw	f3, 1(r6)
	fsw	f3, 1(r11)
	flw	f3, 2(r6)
	fsw	f3, 2(r11)
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
	addi	r6, r0, 725				# set min_caml_intsec_rectside
	lw	r6, 0(r6)
	add	r6, r7, r6
	add	r30, r10, r1
	sw	r6, 0(r30)
	lw	r6, 1(r5)
	add	r30, r6, r1
	lw	r7, 0(r30)
	addi	r6, r0, 727				# set min_caml_intersection_point
	flw	f3, 0(r6)
	fsw	f3, 0(r7)
	flw	f3, 1(r6)
	fsw	f3, 1(r7)
	flw	f3, 2(r6)
	fsw	f3, 2(r7)
	lw	r7, 3(r5)
	flup	f4, 1		# fli	f4, 0.500000
	lw	r6, 7(r8)
	flw	f3, 0(r6)
	fle	r30, f4, f3
	beq	r0, r30, fle_else.17481
	addi	r6, r0, 1
	add	r30, r7, r1
	sw	r6, 0(r30)
	lw	r6, 4(r5)
	add	r30, r6, r1
	lw	r11, 0(r30)
	addi	r7, r0, 734				# set min_caml_texture_color
	flw	f3, 0(r7)
	fsw	f3, 0(r11)
	flw	f3, 1(r7)
	fsw	f3, 1(r11)
	flw	f3, 2(r7)
	fsw	f3, 2(r11)
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
	lw	r7, 0(r30)
	addi	r6, r0, 731				# set min_caml_nvector
	flw	f3, 0(r6)
	fsw	f3, 0(r7)
	flw	f3, 1(r6)
	fsw	f3, 1(r7)
	flw	f3, 2(r6)
	fsw	f3, 2(r7)
	j	fle_cont.17482
fle_else.17481:
	addi	r6, r0, 0
	add	r30, r7, r1
	sw	r6, 0(r30)
fle_cont.17482:
	flup	f4, 44		# fli	f4, -2.000000
	addi	r6, r0, 731				# set min_caml_nvector
	flw	f6, 0(r2)
	flw	f3, 0(r6)
	fmul	f7, f6, f3
	flw	f6, 1(r2)
	flw	f3, 1(r6)
	fmul	f3, f6, f3
	fadd	f7, f7, f3
	flw	f6, 2(r2)
	flw	f3, 2(r6)
	fmul	f3, f6, f3
	fadd	f3, f7, f3
	fmul	f3, f4, f3
	addi	r6, r0, 731				# set min_caml_nvector
	flw	f6, 0(r2)
	flw	f4, 0(r6)
	fmul	f4, f3, f4
	fadd	f4, f6, f4
	fsw	f4, 0(r2)
	flw	f6, 1(r2)
	flw	f4, 1(r6)
	fmul	f4, f3, f4
	fadd	f4, f6, f4
	fsw	f4, 1(r2)
	flw	f6, 2(r2)
	flw	f4, 2(r6)
	fmul	f3, f3, f4
	fadd	f3, f6, f3
	fsw	f3, 2(r2)
	lw	r6, 7(r8)
	flw	f3, 1(r6)
	fmul	f3, f1, f3
	addi	r6, r0, 0
	addi	r7, r0, 723				# set min_caml_or_net
	lw	r7, 0(r7)
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
	beqi	0, r6, beq_then.17484
	j	beq_cont.17485
beq_then.17484:
	addi	r7, r0, 731				# set min_caml_nvector
	addi	r6, r0, 667				# set min_caml_light
	flw	f6, 0(r7)
	flw	f4, 0(r6)
	fmul	f7, f6, f4
	flw	f6, 1(r7)
	flw	f4, 1(r6)
	fmul	f4, f6, f4
	fadd	f7, f7, f4
	flw	f6, 2(r7)
	flw	f4, 2(r6)
	fmul	f4, f6, f4
	fadd	f4, f7, f4
	fneg	f4, f4
	fmul	f6, f4, f5
	addi	r6, r0, 667				# set min_caml_light
	flw	f7, 0(r2)
	flw	f4, 0(r6)
	fmul	f8, f7, f4
	flw	f7, 1(r2)
	flw	f4, 1(r6)
	fmul	f4, f7, f4
	fadd	f8, f8, f4
	flw	f7, 2(r2)
	flw	f4, 2(r6)
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
beq_cont.17485:
	addi	r7, r0, 727				# set min_caml_intersection_point
	addi	r6, r0, 751				# set min_caml_startp_fast
	flw	f4, 0(r7)
	fsw	f4, 0(r6)
	flw	f4, 1(r7)
	fsw	f4, 1(r6)
	flw	f4, 2(r7)
	fsw	f4, 2(r6)
	addi	r6, r0, 0				# set min_caml_n_objects
	lw	r6, 0(r6)
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
	addi	r6, r0, 1023				# set min_caml_n_reflections
	lw	r6, 0(r6)
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
	beq	r0, r30, fle_else.17486
	jr	r31				#
fle_else.17486:
	bgei	4, r1, bge_then.17488
	addi	r7, r1, 1
	addi	r6, r0, -1
	add	r30, r10, r7
	sw	r6, 0(r30)
	j	bge_cont.17489
bge_then.17488:
bge_cont.17489:
	beqi	2, r9, beq_then.17490
	j	beq_cont.17491
beq_then.17490:
	flup	f4, 2		# fli	f4, 1.000000
	lw	r6, 7(r8)
	flw	f3, 0(r6)
	fsub	f3, f4, f3
	fmul	f1, f1, f3
	addi	r1, r1, 1
	addi	r6, r0, 726				# set min_caml_tmin
	flw	f3, 0(r6)
	fadd	f2, f2, f3
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	trace_ray.3197				
	addi	r3, r3, -17
	lw	r31, 16(r3)
beq_cont.17491:
	jr	r31				#
beq_then.17468:
	addi	r5, r0, -1
	add	r30, r10, r1
	sw	r5, 0(r30)
	beqi	0, r1, beq_then.17493
	addi	r1, r0, 667				# set min_caml_light
	flw	f3, 0(r2)
	flw	f2, 0(r1)
	fmul	f4, f3, f2
	flw	f3, 1(r2)
	flw	f2, 1(r1)
	fmul	f2, f3, f2
	fadd	f4, f4, f2
	flw	f3, 2(r2)
	flw	f2, 2(r1)
	fmul	f2, f3, f2
	fadd	f2, f4, f2
	fneg	f2, f2
	fle	r30, f2, f0
	beq	r0, r30, fle_else.17494
	addi	r1, r0, 0
	j	fle_cont.17495
fle_else.17494:
	addi	r1, r0, 1
fle_cont.17495:
	beqi	0, r1, beq_then.17496
	fmul	f3, f2, f2
	fmul	f2, f3, f2
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
beq_then.17496:
	jr	r31				#
beq_then.17493:
	jr	r31				#
trace_diffuse_ray.3203:
	addi	r2, r0, 726				# set min_caml_tmin
	flup	f2, 31		# fli	f2, 1000000000.000000
	fsw	f2, 0(r2)
	addi	r2, r0, 0
	addi	r5, r0, 723				# set min_caml_or_net
	lw	r5, 0(r5)
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
	addi	r2, r0, 726				# set min_caml_tmin
	flw	f2, 0(r2)
	flup	f3, 30		# fli	f3, -0.100000
	fle	r30, f2, f3
	beq	r0, r30, fle_else.17500
	addi	r2, r0, 0
	j	fle_cont.17501
fle_else.17500:
	flup	f3, 32		# fli	f3, 100000000.000000
	fle	r30, f3, f2
	beq	r0, r30, fle_else.17502
	addi	r2, r0, 0
	j	fle_cont.17503
fle_else.17502:
	addi	r2, r0, 1
fle_cont.17503:
fle_cont.17501:
	beqi	0, r2, beq_then.17504
	addi	r5, r0, 1				# set min_caml_objects
	addi	r2, r0, 730				# set min_caml_intersected_object_id
	lw	r2, 0(r2)
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r5, 0(r1)
	lw	r1, 1(r2)
	beqi	1, r1, beq_then.17505
	beqi	2, r1, beq_then.17507
	sw	r2, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	get_nvector_second.3180				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f1, 0(r3)
	lw	r2, 3(r3)
	j	beq_cont.17508
beq_then.17507:
	addi	r5, r0, 731				# set min_caml_nvector
	lw	r1, 4(r2)
	flw	f2, 0(r1)
	fneg	f2, f2
	fsw	f2, 0(r5)
	addi	r5, r0, 731				# set min_caml_nvector
	lw	r1, 4(r2)
	flw	f2, 1(r1)
	fneg	f2, f2
	fsw	f2, 1(r5)
	addi	r5, r0, 731				# set min_caml_nvector
	lw	r1, 4(r2)
	flw	f2, 2(r1)
	fneg	f2, f2
	fsw	f2, 2(r5)
beq_cont.17508:
	j	beq_cont.17506
beq_then.17505:
	addi	r1, r0, 725				# set min_caml_intsec_rectside
	lw	r1, 0(r1)
	addi	r6, r0, 731				# set min_caml_nvector
	fsw	f0, 0(r6)
	fsw	f0, 1(r6)
	fsw	f0, 2(r6)
	addi	r7, r0, 731				# set min_caml_nvector
	addi	r6, r1, -1
	addi	r1, r1, -1
	add	r30, r5, r1
	flw	f2, 0(r30)
	feq	r30, f2, f0
	beq	r0, r30, feq_else.17509
	addi	r1, r0, 1
	j	feq_cont.17510
feq_else.17509:
	addi	r1, r0, 0
feq_cont.17510:
	beqi	0, r1, beq_then.17511
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.17512
beq_then.17511:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.17513
	addi	r1, r0, 0
	j	fle_cont.17514
fle_else.17513:
	addi	r1, r0, 1
fle_cont.17514:
	beqi	0, r1, beq_then.17515
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.17516
beq_then.17515:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.17516:
beq_cont.17512:
	fneg	f2, f2
	add	r30, r7, r6
	fsw	f2, 0(r30)
beq_cont.17506:
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
	addi	r5, r0, 723				# set min_caml_or_net
	lw	r5, 0(r5)
	add	r2, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_one_or_matrix.3145				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f1, 0(r3)
	lw	r2, 3(r3)
	beqi	0, r1, beq_then.17517
	jr	r31				#
beq_then.17517:
	addi	r5, r0, 731				# set min_caml_nvector
	addi	r1, r0, 667				# set min_caml_light
	flw	f3, 0(r5)
	flw	f2, 0(r1)
	fmul	f4, f3, f2
	flw	f3, 1(r5)
	flw	f2, 1(r1)
	fmul	f2, f3, f2
	fadd	f4, f4, f2
	flw	f3, 2(r5)
	flw	f2, 2(r1)
	fmul	f2, f3, f2
	fadd	f2, f4, f2
	fneg	f2, f2
	fle	r30, f2, f0
	beq	r0, r30, fle_else.17519
	addi	r1, r0, 0
	j	fle_cont.17520
fle_else.17519:
	addi	r1, r0, 1
fle_cont.17520:
	beqi	0, r1, beq_then.17521
	j	beq_cont.17522
beq_then.17521:
	flup	f2, 0		# fli	f2, 0.000000
beq_cont.17522:
	addi	r5, r0, 737				# set min_caml_diffuse_ray
	fmul	f2, f1, f2
	lw	r1, 7(r2)
	flw	f1, 0(r1)
	fmul	f1, f2, f1
	addi	r1, r0, 734				# set min_caml_texture_color
	flw	f3, 0(r5)
	flw	f2, 0(r1)
	fmul	f2, f1, f2
	fadd	f2, f3, f2
	fsw	f2, 0(r5)
	flw	f3, 1(r5)
	flw	f2, 1(r1)
	fmul	f2, f1, f2
	fadd	f2, f3, f2
	fsw	f2, 1(r5)
	flw	f3, 2(r5)
	flw	f2, 2(r1)
	fmul	f1, f1, f2
	fadd	f1, f3, f1
	fsw	f1, 2(r5)
	jr	r31				#
beq_then.17504:
	jr	r31				#
iter_trace_diffuse_rays.3206:
	bgei	0, r6, bge_then.17525
	jr	r31				#
bge_then.17525:
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
	beq	r0, r30, fle_else.17527
	addi	r7, r0, 0
	j	fle_cont.17528
fle_else.17527:
	addi	r7, r0, 1
fle_cont.17528:
	beqi	0, r7, beq_then.17529
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
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r1, 3(r3)
	j	beq_cont.17530
beq_then.17529:
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
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r1, 3(r3)
beq_cont.17530:
	addi	r7, r6, -2
	bgei	0, r7, bge_then.17531
	jr	r31				#
bge_then.17531:
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
	beq	r0, r30, fle_else.17533
	addi	r6, r0, 0
	j	fle_cont.17534
fle_else.17533:
	addi	r6, r0, 1
fle_cont.17534:
	beqi	0, r6, beq_then.17535
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
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 3(r3)
	lw	r7, 4(r3)
	j	beq_cont.17536
beq_then.17535:
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
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 3(r3)
	lw	r7, 4(r3)
beq_cont.17536:
	addi	r6, r7, -2
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
	beq	r0, r30, fle_else.17537
	addi	r6, r0, 0
	j	fle_cont.17538
fle_else.17537:
	addi	r6, r0, 1
fle_cont.17538:
	beqi	0, r6, beq_then.17539
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
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	j	beq_cont.17540
beq_then.17539:
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
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
beq_cont.17540:
	addi	r6, r0, 116
	j	iter_trace_diffuse_rays.3206
trace_diffuse_ray_80percent.3215:
	beqi	0, r1, beq_then.17541
	addi	r6, r0, 766				# set min_caml_dirvecs
	lw	r7, 0(r6)
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
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	j	beq_cont.17542
beq_then.17541:
beq_cont.17542:
	beqi	1, r1, beq_then.17543
	addi	r6, r0, 766				# set min_caml_dirvecs
	lw	r7, 1(r6)
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
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	j	beq_cont.17544
beq_then.17543:
beq_cont.17544:
	beqi	2, r1, beq_then.17545
	addi	r6, r0, 766				# set min_caml_dirvecs
	lw	r7, 2(r6)
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
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	j	beq_cont.17546
beq_then.17545:
beq_cont.17546:
	beqi	3, r1, beq_then.17547
	addi	r6, r0, 766				# set min_caml_dirvecs
	lw	r7, 3(r6)
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
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	j	beq_cont.17548
beq_then.17547:
beq_cont.17548:
	beqi	4, r1, beq_then.17549
	addi	r1, r0, 766				# set min_caml_dirvecs
	lw	r7, 4(r1)
	addi	r1, r0, 751				# set min_caml_startp_fast
	flw	f1, 0(r5)
	fsw	f1, 0(r1)
	flw	f1, 1(r5)
	fsw	f1, 1(r1)
	flw	f1, 2(r5)
	fsw	f1, 2(r1)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r1, r1, -1
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r7, 7(r3)
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_startp_constants.3108				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r5, 0(r3)
	lw	r2, 1(r3)
	lw	r7, 7(r3)
	addi	r6, r0, 118
	add	r1, r0, r7
	j	iter_trace_diffuse_rays.3206
beq_then.17549:
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
	lw	r2, 0(r3)
	lw	r8, 1(r3)
	addi	r1, r0, 740				# set min_caml_rgb
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
	flw	f2, 0(r11)
	flw	f1, 0(r2)
	fadd	f1, f2, f1
	fsw	f1, 0(r11)
	flw	f2, 1(r11)
	flw	f1, 1(r2)
	fadd	f1, f2, f1
	fsw	f1, 1(r11)
	flw	f2, 2(r11)
	flw	f1, 2(r2)
	fadd	f1, f2, f1
	fsw	f1, 2(r11)
	addi	r8, r0, 737				# set min_caml_diffuse_ray
	add	r30, r9, r7
	lw	r2, 0(r30)
	flw	f2, 0(r8)
	flw	f1, 0(r2)
	fadd	f1, f2, f1
	fsw	f1, 0(r8)
	flw	f2, 1(r8)
	flw	f1, 1(r2)
	fadd	f1, f2, f1
	fsw	f1, 1(r8)
	flw	f2, 2(r8)
	flw	f1, 2(r2)
	fadd	f1, f2, f1
	fsw	f1, 2(r8)
	addi	r8, r0, 737				# set min_caml_diffuse_ray
	add	r30, r10, r7
	lw	r2, 0(r30)
	flw	f2, 0(r8)
	flw	f1, 0(r2)
	fadd	f1, f2, f1
	fsw	f1, 0(r8)
	flw	f2, 1(r8)
	flw	f1, 1(r2)
	fadd	f1, f2, f1
	fsw	f1, 1(r8)
	flw	f2, 2(r8)
	flw	f1, 2(r2)
	fadd	f1, f2, f1
	fsw	f1, 2(r8)
	addi	r8, r0, 737				# set min_caml_diffuse_ray
	add	r30, r6, r7
	lw	r2, 0(r30)
	flw	f2, 0(r8)
	flw	f1, 0(r2)
	fadd	f1, f2, f1
	fsw	f1, 0(r8)
	flw	f2, 1(r8)
	flw	f1, 1(r2)
	fadd	f1, f2, f1
	fsw	f1, 1(r8)
	flw	f2, 2(r8)
	flw	f1, 2(r2)
	fadd	f1, f2, f1
	fsw	f1, 2(r8)
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 4(r1)
	addi	r6, r0, 740				# set min_caml_rgb
	add	r30, r1, r7
	lw	r2, 0(r30)
	addi	r5, r0, 737				# set min_caml_diffuse_ray
	add	r1, r0, r6
	j	vecaccumv.2912
do_without_neighbors.3228:
	blei	4, r2, ble_then.17551
	jr	r31				#
ble_then.17551:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.17553
	jr	r31				#
bge_then.17553:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	beqi	0, r5, beq_then.17555
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
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	j	beq_cont.17556
beq_then.17555:
beq_cont.17556:
	addi	r8, r2, 1
	blei	4, r8, ble_then.17557
	jr	r31				#
ble_then.17557:
	lw	r2, 2(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	bgei	0, r2, bge_then.17559
	jr	r31				#
bge_then.17559:
	lw	r2, 3(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	beqi	0, r2, beq_then.17561
	lw	r2, 5(r1)
	lw	r5, 7(r1)
	lw	r6, 1(r1)
	lw	r7, 4(r1)
	addi	r9, r0, 737				# set min_caml_diffuse_ray
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
	lw	r1, 0(r3)
	lw	r8, 4(r3)
	j	beq_cont.17562
beq_then.17561:
beq_cont.17562:
	addi	r2, r8, 1
	j	do_without_neighbors.3228
neighbors_exist.3231:
	addi	r5, r0, 743				# set min_caml_image_size
	lw	r6, 1(r5)
	addi	r5, r2, 1
	ble	r6, r5, ble_then.17563
	blei	0, r2, ble_then.17564
	addi	r2, r0, 743				# set min_caml_image_size
	lw	r5, 0(r2)
	addi	r2, r1, 1
	ble	r5, r2, ble_then.17565
	blei	0, r1, ble_then.17566
	addi	r1, r0, 1
	jr	r31				#
ble_then.17566:
	addi	r1, r0, 0
	jr	r31				#
ble_then.17565:
	addi	r1, r0, 0
	jr	r31				#
ble_then.17564:
	addi	r1, r0, 0
	jr	r31				#
ble_then.17563:
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
	beq	r2, r8, beq_then.17567
	addi	r1, r0, 0
	jr	r31				#
beq_then.17567:
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.17568
	addi	r1, r0, 0
	jr	r31				#
beq_then.17568:
	addi	r2, r1, -1
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.17569
	addi	r1, r0, 0
	jr	r31				#
beq_then.17569:
	addi	r1, r1, 1
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beq	r1, r8, beq_then.17570
	addi	r1, r0, 0
	jr	r31				#
beq_then.17570:
	addi	r1, r0, 1
	jr	r31				#
try_exploit_neighbors.3244:
	add	r30, r6, r1
	lw	r10, 0(r30)
	blei	4, r8, ble_then.17571
	jr	r31				#
ble_then.17571:
	lw	r9, 2(r10)
	add	r30, r9, r8
	lw	r9, 0(r30)
	bgei	0, r9, bge_then.17573
	jr	r31				#
bge_then.17573:
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
	beq	r11, r9, beq_then.17575
	addi	r9, r0, 0
	j	beq_cont.17576
beq_then.17575:
	add	r30, r7, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r9, beq_then.17577
	addi	r9, r0, 0
	j	beq_cont.17578
beq_then.17577:
	addi	r11, r1, -1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r9, beq_then.17579
	addi	r9, r0, 0
	j	beq_cont.17580
beq_then.17579:
	addi	r11, r1, 1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r9, beq_then.17581
	addi	r9, r0, 0
	j	beq_cont.17582
beq_then.17581:
	addi	r9, r0, 1
beq_cont.17582:
beq_cont.17580:
beq_cont.17578:
beq_cont.17576:
	beqi	0, r9, beq_then.17583
	lw	r9, 3(r10)
	add	r30, r9, r8
	lw	r9, 0(r30)
	beqi	0, r9, beq_then.17584
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
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r8, 3(r3)
	lw	r7, 4(r3)
	lw	r6, 5(r3)
	j	beq_cont.17585
beq_then.17584:
beq_cont.17585:
	addi	r11, r8, 1
	add	r30, r6, r1
	lw	r9, 0(r30)
	blei	4, r11, ble_then.17586
	jr	r31				#
ble_then.17586:
	lw	r8, 2(r9)
	add	r30, r8, r11
	lw	r8, 0(r30)
	bgei	0, r8, bge_then.17588
	jr	r31				#
bge_then.17588:
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
	beq	r10, r8, beq_then.17590
	addi	r8, r0, 0
	j	beq_cont.17591
beq_then.17590:
	add	r30, r7, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r11
	lw	r10, 0(r30)
	beq	r10, r8, beq_then.17592
	addi	r8, r0, 0
	j	beq_cont.17593
beq_then.17592:
	addi	r10, r1, -1
	add	r30, r6, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r11
	lw	r10, 0(r30)
	beq	r10, r8, beq_then.17594
	addi	r8, r0, 0
	j	beq_cont.17595
beq_then.17594:
	addi	r10, r1, 1
	add	r30, r6, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r11
	lw	r10, 0(r30)
	beq	r10, r8, beq_then.17596
	addi	r8, r0, 0
	j	beq_cont.17597
beq_then.17596:
	addi	r8, r0, 1
beq_cont.17597:
beq_cont.17595:
beq_cont.17593:
beq_cont.17591:
	beqi	0, r8, beq_then.17598
	lw	r8, 3(r9)
	add	r30, r8, r11
	lw	r8, 0(r30)
	beqi	0, r8, beq_then.17599
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
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r7, 4(r3)
	lw	r6, 5(r3)
	lw	r11, 6(r3)
	j	beq_cont.17600
beq_then.17599:
beq_cont.17600:
	addi	r8, r11, 1
	j	try_exploit_neighbors.3244
beq_then.17598:
	add	r30, r6, r1
	lw	r1, 0(r30)
	add	r2, r0, r11
	j	do_without_neighbors.3228
beq_then.17583:
	add	r30, r6, r1
	lw	r7, 0(r30)
	blei	4, r8, ble_then.17601
	jr	r31				#
ble_then.17601:
	lw	r1, 2(r7)
	add	r30, r1, r8
	lw	r1, 0(r30)
	bgei	0, r1, bge_then.17603
	jr	r31				#
bge_then.17603:
	lw	r1, 3(r7)
	add	r30, r1, r8
	lw	r1, 0(r30)
	beqi	0, r1, beq_then.17605
	lw	r1, 5(r7)
	lw	r2, 7(r7)
	lw	r5, 1(r7)
	lw	r6, 4(r7)
	addi	r9, r0, 737				# set min_caml_diffuse_ray
	add	r30, r1, r8
	lw	r1, 0(r30)
	flw	f1, 0(r1)
	fsw	f1, 0(r9)
	flw	f1, 1(r1)
	fsw	f1, 1(r9)
	flw	f1, 2(r1)
	fsw	f1, 2(r9)
	lw	r1, 6(r7)
	lw	r1, 0(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	add	r30, r5, r8
	lw	r5, 0(r30)
	sw	r8, 3(r3)
	sw	r6, 7(r3)
	sw	r7, 8(r3)
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
	lw	r8, 3(r3)
	lw	r7, 8(r3)
	j	beq_cont.17606
beq_then.17605:
beq_cont.17606:
	addi	r2, r8, 1
	add	r1, r0, r7
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
	ble	r1, r2, ble_then.17607
	addi	r1, r0, 255
	j	ble_cont.17608
ble_then.17607:
	bgei	0, r1, bge_then.17609
	addi	r1, r0, 0
	j	bge_cont.17610
bge_then.17609:
bge_cont.17610:
ble_cont.17608:
	j	print_int.2857
write_rgb.3255:
	addi	r1, r0, 740				# set min_caml_rgb
	flw	f1, 0(r1)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.17611
	addi	r1, r0, 255
	j	ble_cont.17612
ble_then.17611:
	bgei	0, r1, bge_then.17613
	addi	r1, r0, 0
	j	bge_cont.17614
bge_then.17613:
bge_cont.17614:
ble_cont.17612:
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
	ble	r1, r2, ble_then.17615
	addi	r1, r0, 255
	j	ble_cont.17616
ble_then.17615:
	bgei	0, r1, bge_then.17617
	addi	r1, r0, 0
	j	bge_cont.17618
bge_then.17617:
bge_cont.17618:
ble_cont.17616:
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
	ble	r1, r2, ble_then.17619
	addi	r1, r0, 255
	j	ble_cont.17620
ble_then.17619:
	bgei	0, r1, bge_then.17621
	addi	r1, r0, 0
	j	bge_cont.17622
bge_then.17621:
bge_cont.17622:
ble_cont.17620:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
pretrace_diffuse_rays.3257:
	blei	4, r2, ble_then.17623
	jr	r31				#
ble_then.17623:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.17625
	jr	r31				#
bge_then.17625:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	beqi	0, r5, beq_then.17627
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
	lw	r9, 0(r30)
	add	r30, r5, r2
	lw	r8, 0(r30)
	add	r30, r6, r2
	lw	r7, 0(r30)
	addi	r5, r0, 751				# set min_caml_startp_fast
	flw	f1, 0(r7)
	fsw	f1, 0(r5)
	flw	f1, 1(r7)
	fsw	f1, 1(r5)
	flw	f1, 2(r7)
	fsw	f1, 2(r5)
	addi	r5, r0, 0				# set min_caml_n_objects
	lw	r5, 0(r5)
	addi	r5, r5, -1
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r7, 2(r3)
	sw	r8, 3(r3)
	sw	r9, 4(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_startp_constants.3108				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	lw	r7, 2(r3)
	lw	r8, 3(r3)
	lw	r9, 4(r3)
	addi	r6, r0, 118
	add	r5, r0, r7
	add	r2, r0, r8
	add	r1, r0, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_trace_diffuse_rays.3206				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	lw	r5, 5(r1)
	add	r30, r5, r2
	lw	r6, 0(r30)
	addi	r5, r0, 737				# set min_caml_diffuse_ray
	flw	f1, 0(r5)
	fsw	f1, 0(r6)
	flw	f1, 1(r5)
	fsw	f1, 1(r6)
	flw	f1, 2(r5)
	fsw	f1, 2(r6)
	j	beq_cont.17628
beq_then.17627:
beq_cont.17628:
	addi	r2, r2, 1
	j	pretrace_diffuse_rays.3257
pretrace_pixels.3260:
	bgei	0, r2, bge_then.17629
	jr	r31				#
bge_then.17629:
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
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	lw	r2, 6(r3)
	lw	r1, 7(r3)
	lw	r5, 8(r3)
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
	bgei	5, r2, bge_then.17631
	add	r5, r0, r2
	j	bge_cont.17632
bge_then.17631:
	addi	r5, r2, -5
bge_cont.17632:
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
	ble	r8, r1, ble_then.17633
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
	addi	r8, r0, 743				# set min_caml_image_size
	lw	r9, 1(r8)
	addi	r8, r2, 1
	ble	r9, r8, ble_then.17634
	blei	0, r2, ble_then.17636
	addi	r8, r0, 743				# set min_caml_image_size
	lw	r9, 0(r8)
	addi	r8, r1, 1
	ble	r9, r8, ble_then.17638
	blei	0, r1, ble_then.17640
	addi	r8, r0, 1
	j	ble_cont.17641
ble_then.17640:
	addi	r8, r0, 0
ble_cont.17641:
	j	ble_cont.17639
ble_then.17638:
	addi	r8, r0, 0
ble_cont.17639:
	j	ble_cont.17637
ble_then.17636:
	addi	r8, r0, 0
ble_cont.17637:
	j	ble_cont.17635
ble_then.17634:
	addi	r8, r0, 0
ble_cont.17635:
	beqi	0, r8, beq_then.17642
	addi	r11, r0, 0
	add	r30, r6, r1
	lw	r9, 0(r30)
	lw	r8, 2(r9)
	lw	r8, 0(r8)
	bgei	0, r8, bge_then.17644
	j	bge_cont.17645
bge_then.17644:
	add	r30, r6, r1
	lw	r8, 0(r30)
	lw	r8, 2(r8)
	lw	r8, 0(r8)
	add	r30, r5, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	lw	r10, 0(r10)
	beq	r10, r8, beq_then.17646
	addi	r8, r0, 0
	j	beq_cont.17647
beq_then.17646:
	add	r30, r7, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	lw	r10, 0(r10)
	beq	r10, r8, beq_then.17648
	addi	r8, r0, 0
	j	beq_cont.17649
beq_then.17648:
	addi	r10, r1, -1
	add	r30, r6, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	lw	r10, 0(r10)
	beq	r10, r8, beq_then.17650
	addi	r8, r0, 0
	j	beq_cont.17651
beq_then.17650:
	addi	r10, r1, 1
	add	r30, r6, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	lw	r10, 0(r10)
	beq	r10, r8, beq_then.17652
	addi	r8, r0, 0
	j	beq_cont.17653
beq_then.17652:
	addi	r8, r0, 1
beq_cont.17653:
beq_cont.17651:
beq_cont.17649:
beq_cont.17647:
	beqi	0, r8, beq_then.17654
	lw	r8, 3(r9)
	lw	r8, 0(r8)
	beqi	0, r8, beq_then.17656
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
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r6, 4(r3)
	j	beq_cont.17657
beq_then.17656:
beq_cont.17657:
	addi	r8, r0, 1
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	sw	r6, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	try_exploit_neighbors.3244				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r6, 4(r3)
	j	beq_cont.17655
beq_then.17654:
	add	r30, r6, r1
	lw	r8, 0(r30)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	sw	r6, 4(r3)
	add	r2, r0, r11
	add	r1, r0, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	do_without_neighbors.3228				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r6, 4(r3)
beq_cont.17655:
bge_cont.17645:
	j	beq_cont.17643
beq_then.17642:
	add	r30, r6, r1
	lw	r12, 0(r30)
	lw	r8, 2(r12)
	lw	r8, 0(r8)
	bgei	0, r8, bge_then.17658
	j	bge_cont.17659
bge_then.17658:
	lw	r8, 3(r12)
	lw	r8, 0(r8)
	beqi	0, r8, beq_then.17660
	lw	r8, 5(r12)
	lw	r9, 7(r12)
	lw	r10, 1(r12)
	lw	r11, 4(r12)
	addi	r13, r0, 737				# set min_caml_diffuse_ray
	lw	r8, 0(r8)
	flw	f1, 0(r8)
	fsw	f1, 0(r13)
	flw	f1, 1(r8)
	fsw	f1, 1(r13)
	flw	f1, 2(r8)
	fsw	f1, 2(r13)
	lw	r8, 6(r12)
	lw	r8, 0(r8)
	lw	r13, 0(r9)
	lw	r9, 0(r10)
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	sw	r11, 5(r3)
	sw	r6, 4(r3)
	sw	r12, 6(r3)
	add	r5, r0, r9
	add	r2, r0, r13
	add	r1, r0, r8
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	trace_diffuse_ray_80percent.3215				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r11, 5(r3)
	lw	r6, 4(r3)
	lw	r12, 6(r3)
	addi	r10, r0, 740				# set min_caml_rgb
	lw	r9, 0(r11)
	addi	r8, r0, 737				# set min_caml_diffuse_ray
	add	r5, r0, r8
	add	r2, r0, r9
	add	r1, r0, r10
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	vecaccumv.2912				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r6, 4(r3)
	lw	r12, 6(r3)
	j	beq_cont.17661
beq_then.17660:
beq_cont.17661:
	addi	r8, r0, 1
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	sw	r6, 4(r3)
	add	r2, r0, r8
	add	r1, r0, r12
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	do_without_neighbors.3228				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 0(r3)
	lw	r1, 1(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r6, 4(r3)
bge_cont.17659:
beq_cont.17643:
	addi	r8, r0, 740				# set min_caml_rgb
	flw	f1, 0(r8)
	ftoi	r8, f1
	addi	r9, r0, 255
	ble	r8, r9, ble_then.17662
	addi	r8, r0, 255
	j	ble_cont.17663
ble_then.17662:
	bgei	0, r8, bge_then.17664
	addi	r8, r0, 0
	j	bge_cont.17665
bge_then.17664:
bge_cont.17665:
ble_cont.17663:
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	sw	r6, 4(r3)
	add	r1, r0, r8
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
	addi	r8, r0, 740				# set min_caml_rgb
	flw	f1, 1(r8)
	ftoi	r8, f1
	addi	r9, r0, 255
	ble	r8, r9, ble_then.17666
	addi	r8, r0, 255
	j	ble_cont.17667
ble_then.17666:
	bgei	0, r8, bge_then.17668
	addi	r8, r0, 0
	j	bge_cont.17669
bge_then.17668:
bge_cont.17669:
ble_cont.17667:
	add	r1, r0, r8
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
	addi	r8, r0, 740				# set min_caml_rgb
	flw	f1, 2(r8)
	ftoi	r8, f1
	addi	r9, r0, 255
	ble	r8, r9, ble_then.17670
	addi	r8, r0, 255
	j	ble_cont.17671
ble_then.17670:
	bgei	0, r8, bge_then.17672
	addi	r8, r0, 0
	j	bge_cont.17673
bge_then.17672:
bge_cont.17673:
ble_cont.17671:
	add	r1, r0, r8
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
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r1, 0(r1)
	ble	r1, r9, ble_then.17674
	addi	r8, r0, 740				# set min_caml_rgb
	add	r30, r6, r9
	lw	r1, 0(r30)
	lw	r1, 0(r1)
	flw	f1, 0(r1)
	fsw	f1, 0(r8)
	flw	f1, 1(r1)
	fsw	f1, 1(r8)
	flw	f1, 2(r1)
	fsw	f1, 2(r8)
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r8, 1(r1)
	addi	r1, r2, 1
	ble	r8, r1, ble_then.17675
	blei	0, r2, ble_then.17677
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r8, 0(r1)
	addi	r1, r9, 1
	ble	r8, r1, ble_then.17679
	blei	0, r9, ble_then.17681
	addi	r1, r0, 1
	j	ble_cont.17682
ble_then.17681:
	addi	r1, r0, 0
ble_cont.17682:
	j	ble_cont.17680
ble_then.17679:
	addi	r1, r0, 0
ble_cont.17680:
	j	ble_cont.17678
ble_then.17677:
	addi	r1, r0, 0
ble_cont.17678:
	j	ble_cont.17676
ble_then.17675:
	addi	r1, r0, 0
ble_cont.17676:
	beqi	0, r1, beq_then.17683
	addi	r1, r0, 0
	sw	r9, 7(r3)
	add	r8, r0, r1
	add	r1, r0, r9
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	try_exploit_neighbors.3244				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r6, 4(r3)
	lw	r9, 7(r3)
	j	beq_cont.17684
beq_then.17683:
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
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 3(r3)
	lw	r6, 4(r3)
	lw	r9, 7(r3)
beq_cont.17684:
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
ble_then.17674:
	jr	r31				#
ble_then.17633:
	jr	r31				#
scan_line.3277:
	addi	r8, r0, 743				# set min_caml_image_size
	lw	r8, 1(r8)
	ble	r8, r1, ble_then.17687
	addi	r8, r0, 743				# set min_caml_image_size
	lw	r8, 1(r8)
	addi	r8, r8, -1
	ble	r8, r1, ble_then.17688
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
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r7, 3(r3)
	lw	r5, 4(r3)
	j	ble_cont.17689
ble_then.17688:
ble_cont.17689:
	addi	r10, r0, 0
	addi	r8, r0, 743				# set min_caml_image_size
	lw	r8, 0(r8)
	blei	0, r8, ble_then.17690
	addi	r9, r0, 740				# set min_caml_rgb
	lw	r8, 0(r5)
	lw	r8, 0(r8)
	flw	f1, 0(r8)
	fsw	f1, 0(r9)
	flw	f1, 1(r8)
	fsw	f1, 1(r9)
	flw	f1, 2(r8)
	fsw	f1, 2(r9)
	addi	r8, r0, 743				# set min_caml_image_size
	lw	r9, 1(r8)
	addi	r8, r1, 1
	ble	r9, r8, ble_then.17692
	blei	0, r1, ble_then.17694
	addi	r8, r0, 743				# set min_caml_image_size
	lw	r8, 0(r8)
	blei	1, r8, ble_then.17696
	addi	r8, r0, 0
	j	ble_cont.17697
ble_then.17696:
	addi	r8, r0, 0
ble_cont.17697:
	j	ble_cont.17695
ble_then.17694:
	addi	r8, r0, 0
ble_cont.17695:
	j	ble_cont.17693
ble_then.17692:
	addi	r8, r0, 0
ble_cont.17693:
	beqi	0, r8, beq_then.17698
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
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r7, 3(r3)
	lw	r5, 4(r3)
	j	beq_cont.17699
beq_then.17698:
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
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r7, 3(r3)
	lw	r5, 4(r3)
beq_cont.17699:
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
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r7, 3(r3)
	lw	r5, 4(r3)
	j	ble_cont.17691
ble_then.17690:
ble_cont.17691:
	addi	r8, r1, 1
	addi	r1, r7, 2
	bgei	5, r1, bge_then.17700
	j	bge_cont.17701
bge_then.17700:
	addi	r1, r1, -5
bge_cont.17701:
	addi	r7, r0, 743				# set min_caml_image_size
	lw	r7, 1(r7)
	ble	r7, r8, ble_then.17702
	addi	r7, r0, 743				# set min_caml_image_size
	lw	r7, 1(r7)
	addi	r7, r7, -1
	ble	r7, r8, ble_then.17704
	addi	r7, r8, 1
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	sw	r5, 4(r3)
	sw	r1, 5(r3)
	sw	r8, 6(r3)
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	pretrace_line.3267				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 1(r3)
	lw	r6, 2(r3)
	lw	r5, 4(r3)
	lw	r1, 5(r3)
	lw	r8, 6(r3)
	j	ble_cont.17705
ble_then.17704:
ble_cont.17705:
	addi	r7, r0, 0
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	sw	r5, 4(r3)
	sw	r1, 5(r3)
	sw	r8, 6(r3)
	add	r1, r0, r7
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
	lw	r1, 5(r3)
	lw	r8, 6(r3)
	addi	r8, r8, 1
	addi	r1, r1, 2
	bgei	5, r1, bge_then.17706
	add	r7, r0, r1
	j	bge_cont.17707
bge_then.17706:
	addi	r7, r1, -5
bge_cont.17707:
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
	j	ble_cont.17703
ble_then.17702:
ble_cont.17703:
	jr	r31				#
ble_then.17687:
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
	lw	r5, 0(r3)
	addi	r1, r0, 5
	addi	r2, r0, 0
	sw	r8, 1(r3)
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
	bgei	0, r2, bge_then.17710
	jr	r31				#
bge_then.17710:
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
	bgei	0, r13, bge_then.17711
	jr	r31				#
bge_then.17711:
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
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r12, 0(r1)
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
	addi	r1, r0, 5
	addi	r2, r0, 0
	sw	r8, 2(r3)
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
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r1, 0(r1)
	addi	r14, r1, -2
	bgei	0, r14, bge_then.17712
	add	r1, r0, r12
	jr	r31				#
bge_then.17712:
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r12, 8(r3)
	sw	r14, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r5, r0, r1
	lw	r12, 8(r3)
	lw	r14, 9(r3)
	sw	r5, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_float5x3array.3283				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r8, r0, r1
	lw	r5, 10(r3)
	lw	r12, 8(r3)
	lw	r14, 9(r3)
	addi	r1, r0, 5
	addi	r2, r0, 0
	sw	r8, 11(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r2, r0, r1
	lw	r5, 10(r3)
	lw	r8, 11(r3)
	lw	r12, 8(r3)
	lw	r14, 9(r3)
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
	lw	r14, 9(r3)
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
	lw	r14, 9(r3)
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
	lw	r14, 9(r3)
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
	lw	r14, 9(r3)
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
	lw	r14, 9(r3)
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
	add	r30, r12, r14
	sw	r1, 0(r30)
	addi	r2, r14, -1
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
	fsqrt	f3, f1
	flup	f1, 2		# fli	f1, 1.000000
	finv	f31, f3
	fmul	f1, f1, f31
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17713
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.17714
fle_else.17713:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.17714:
	fmul	f1, f1, f4
	flup	f5, 23		# fli	f5, 4.375000
	fle	r30, f5, f1
	beq	r0, r30, fle_else.17715
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f1
	beq	r0, r30, fle_else.17717
	flup	f6, 15		# fli	f6, 1.570796
	flup	f5, 2		# fli	f5, 1.000000
	finv	f31, f1
	fmul	f1, f5, f31
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
	fsw	f4, 4(r3)
	fsw	f6, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	atan_body.2841				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 0(r3)
	flw	f3, 2(r3)
	flw	f4, 4(r3)
	flw	f6, 6(r3)
	fadd	f1, f6, f1
	fmul	f1, f1, f4
	j	fle_cont.17718
fle_else.17717:
	flup	f7, 16		# fli	f7, 0.785398
	flup	f5, 2		# fli	f5, 1.000000
	fsub	f6, f1, f5
	flup	f5, 2		# fli	f5, 1.000000
	fadd	f1, f1, f5
	finv	f31, f1
	fmul	f1, f6, f31
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
	fsw	f4, 4(r3)
	fsw	f7, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2841				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	flw	f3, 2(r3)
	flw	f4, 4(r3)
	flw	f7, 8(r3)
	fadd	f1, f7, f1
	fmul	f1, f1, f4
fle_cont.17718:
	j	fle_cont.17716
fle_else.17715:
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2841				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	flw	f3, 2(r3)
fle_cont.17716:
	fmul	f1, f1, f2
	fsw	f1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2837				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	fadd	f2, f0, f1
	flw	f3, 2(r3)
	flw	f1, 10(r3)
	fsw	f2, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	cos.2839				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f3, 2(r3)
	flw	f2, 12(r3)
	finv	f31, f1
	fmul	f1, f2, f31
	fmul	f1, f1, f3
	jr	r31				#
calc_dirvec.3297:
	bgei	5, r1, bge_then.17719
	fmul	f2, f2, f2
	flup	f1, 45		# fli	f1, 0.100000
	fadd	f1, f2, f1
	fsqrt	f2, f1
	flup	f1, 2		# fli	f1, 1.000000
	finv	f31, f2
	fmul	f1, f1, f31
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17720
	flup	f5, 2		# fli	f5, 1.000000
	j	fle_cont.17721
fle_else.17720:
	flup	f5, 11		# fli	f5, -1.000000
fle_cont.17721:
	fmul	f1, f1, f5
	flup	f6, 23		# fli	f6, 4.375000
	fle	r30, f6, f1
	beq	r0, r30, fle_else.17722
	flup	f6, 24		# fli	f6, 2.437500
	fle	r30, f6, f1
	beq	r0, r30, fle_else.17724
	flup	f7, 15		# fli	f7, 1.570796
	flup	f6, 2		# fli	f6, 1.000000
	finv	f31, f1
	fmul	f1, f6, f31
	fsw	f4, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	fsw	f5, 6(r3)
	fsw	f7, 8(r3)
	sw	r5, 10(r3)
	sw	r1, 11(r3)
	sw	r2, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	atan_body.2841				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f2, 4(r3)
	flw	f5, 6(r3)
	flw	f7, 8(r3)
	lw	r5, 10(r3)
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	fadd	f1, f7, f1
	fmul	f1, f1, f5
	j	fle_cont.17725
fle_else.17724:
	flup	f8, 16		# fli	f8, 0.785398
	flup	f6, 2		# fli	f6, 1.000000
	fsub	f7, f1, f6
	flup	f6, 2		# fli	f6, 1.000000
	fadd	f1, f1, f6
	finv	f31, f1
	fmul	f1, f7, f31
	fsw	f4, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	fsw	f5, 6(r3)
	fsw	f8, 14(r3)
	sw	r5, 10(r3)
	sw	r1, 11(r3)
	sw	r2, 12(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2841				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f2, 4(r3)
	flw	f5, 6(r3)
	flw	f8, 14(r3)
	lw	r5, 10(r3)
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	fadd	f1, f8, f1
	fmul	f1, f1, f5
fle_cont.17725:
	j	fle_cont.17723
fle_else.17722:
	fsw	f4, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	sw	r5, 10(r3)
	sw	r1, 11(r3)
	sw	r2, 12(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2841				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f2, 4(r3)
	lw	r5, 10(r3)
	lw	r1, 11(r3)
	lw	r2, 12(r3)
fle_cont.17723:
	fmul	f1, f1, f3
	fsw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	sin.2837				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	fadd	f5, f0, f1
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f2, 4(r3)
	flw	f1, 16(r3)
	lw	r5, 10(r3)
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	fsw	f5, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	cos.2839				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f2, 4(r3)
	flw	f5, 18(r3)
	lw	r5, 10(r3)
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	finv	f31, f1
	fmul	f1, f5, f31
	fmul	f1, f1, f2
	addi	r1, r1, 1
	fmul	f5, f1, f1
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f2, f5, f2
	fsqrt	f5, f2
	flup	f2, 2		# fli	f2, 1.000000
	finv	f31, f5
	fmul	f2, f2, f31
	fle	r30, f0, f2
	beq	r0, r30, fle_else.17727
	flup	f6, 2		# fli	f6, 1.000000
	j	fle_cont.17728
fle_else.17727:
	flup	f6, 11		# fli	f6, -1.000000
fle_cont.17728:
	fmul	f2, f2, f6
	flup	f7, 23		# fli	f7, 4.375000
	fle	r30, f7, f2
	beq	r0, r30, fle_else.17729
	flup	f7, 24		# fli	f7, 2.437500
	fle	r30, f7, f2
	beq	r0, r30, fle_else.17731
	flup	f8, 15		# fli	f8, 1.570796
	flup	f7, 2		# fli	f7, 1.000000
	finv	f31, f2
	fmul	f2, f7, f31
	fsw	f1, 20(r3)
	fsw	f5, 22(r3)
	fsw	f6, 24(r3)
	fsw	f8, 26(r3)
	sw	r1, 28(r3)
	fadd	f1, f0, f2
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	atan_body.2841				
	addi	r3, r3, -30
	lw	r31, 29(r3)
	fadd	f2, f0, f1
	flw	f1, 20(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f5, 22(r3)
	flw	f6, 24(r3)
	flw	f8, 26(r3)
	lw	r5, 10(r3)
	lw	r2, 12(r3)
	lw	r1, 28(r3)
	fadd	f2, f8, f2
	fmul	f2, f2, f6
	j	fle_cont.17732
fle_else.17731:
	flup	f9, 16		# fli	f9, 0.785398
	flup	f7, 2		# fli	f7, 1.000000
	fsub	f8, f2, f7
	flup	f7, 2		# fli	f7, 1.000000
	fadd	f2, f2, f7
	finv	f31, f2
	fmul	f2, f8, f31
	fsw	f1, 20(r3)
	fsw	f5, 22(r3)
	fsw	f6, 24(r3)
	fsw	f9, 30(r3)
	sw	r1, 28(r3)
	fadd	f1, f0, f2
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	atan_body.2841				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	fadd	f2, f0, f1
	flw	f1, 20(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f5, 22(r3)
	flw	f6, 24(r3)
	flw	f9, 30(r3)
	lw	r5, 10(r3)
	lw	r2, 12(r3)
	lw	r1, 28(r3)
	fadd	f2, f9, f2
	fmul	f2, f2, f6
fle_cont.17732:
	j	fle_cont.17730
fle_else.17729:
	fsw	f1, 20(r3)
	fsw	f5, 22(r3)
	sw	r1, 28(r3)
	fadd	f1, f0, f2
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	atan_body.2841				
	addi	r3, r3, -33
	lw	r31, 32(r3)
	fadd	f2, f0, f1
	flw	f1, 20(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f5, 22(r3)
	lw	r5, 10(r3)
	lw	r2, 12(r3)
	lw	r1, 28(r3)
fle_cont.17730:
	fmul	f2, f2, f4
	fsw	f2, 32(r3)
	fadd	f1, f0, f2
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	sin.2837				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	fadd	f6, f0, f1
	flw	f1, 20(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f5, 22(r3)
	flw	f2, 32(r3)
	lw	r5, 10(r3)
	lw	r2, 12(r3)
	lw	r1, 28(r3)
	fsw	f6, 34(r3)
	fadd	f1, f0, f2
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	cos.2839				
	addi	r3, r3, -37
	lw	r31, 36(r3)
	fadd	f2, f0, f1
	flw	f1, 20(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f5, 22(r3)
	flw	f6, 34(r3)
	lw	r5, 10(r3)
	lw	r2, 12(r3)
	lw	r1, 28(r3)
	finv	f31, f2
	fmul	f2, f6, f31
	fmul	f2, f2, f5
	j	calc_dirvec.3297
bge_then.17719:
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
	bgei	0, r1, bge_then.17735
	jr	r31				#
bge_then.17735:
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
	flw	f1, 0(r3)
	lw	r5, 2(r3)
	lw	r2, 3(r3)
	lw	r1, 4(r3)
	itof	f3, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f3, f3, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f3, f3, f2
	addi	r7, r0, 0
	flup	f4, 0		# fli	f4, 0.000000
	flup	f2, 0		# fli	f2, 0.000000
	addi	r6, r5, 2
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
	flw	f1, 0(r3)
	lw	r5, 2(r3)
	lw	r2, 3(r3)
	lw	r1, 4(r3)
	addi	r6, r1, -1
	addi	r1, r2, 1
	bgei	5, r1, bge_then.17737
	add	r2, r0, r1
	j	bge_cont.17738
bge_then.17737:
	addi	r2, r1, -5
bge_cont.17738:
	add	r1, r0, r6
	j	calc_dirvecs.3305
calc_dirvec_rows.3310:
	bgei	0, r1, bge_then.17739
	jr	r31				#
bge_then.17739:
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
	addi	r6, r1, -1
	addi	r1, r2, 2
	bgei	5, r1, bge_then.17741
	add	r2, r0, r1
	j	bge_cont.17742
bge_then.17741:
	addi	r2, r1, -5
bge_cont.17742:
	addi	r5, r5, 4
	bgei	0, r6, bge_then.17743
	jr	r31				#
bge_then.17743:
	itof	f2, r6
	flup	f1, 18		# fli	f1, 0.200000
	fmul	f2, f2, f1
	flup	f1, 48		# fli	f1, 0.900000
	fsub	f1, f2, f1
	addi	r1, r0, 4
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	sw	r6, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_dirvecs.3305				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r5, 3(r3)
	lw	r2, 4(r3)
	lw	r6, 5(r3)
	addi	r6, r6, -1
	addi	r1, r2, 2
	bgei	5, r1, bge_then.17745
	add	r2, r0, r1
	j	bge_cont.17746
bge_then.17745:
	addi	r2, r1, -5
bge_cont.17746:
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
	lw	r2, 0(r3)
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r1)
	sw	r2, 0(r1)
	jr	r31				#
create_dirvec_elements.3316:
	bgei	0, r2, bge_then.17747
	jr	r31				#
bge_then.17747:
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
	bgei	0, r7, bge_then.17749
	jr	r31				#
bge_then.17749:
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
	bgei	0, r7, bge_then.17751
	jr	r31				#
bge_then.17751:
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
	addi	r5, r0, 0				# set min_caml_n_objects
	lw	r5, 0(r5)
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
	bgei	0, r7, bge_then.17753
	jr	r31				#
bge_then.17753:
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
	addi	r5, r0, 0				# set min_caml_n_objects
	lw	r5, 0(r5)
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
	bgei	0, r1, bge_then.17755
	jr	r31				#
bge_then.17755:
	addi	r9, r0, 766				# set min_caml_dirvecs
	addi	r8, r0, 120
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	sw	r8, 1(r3)
	sw	r9, 2(r3)
	add	r1, r0, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r8, 1(r3)
	lw	r9, 2(r3)
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
	lw	r2, 3(r3)
	lw	r1, 0(r3)
	lw	r8, 1(r3)
	lw	r9, 2(r3)
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r6, 1(r5)
	sw	r2, 0(r5)
	add	r2, r0, r5
	add	r1, r0, r8
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
	lw	r8, 0(r30)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r8, 4(r3)
	add	r1, r0, r2
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_float_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r8, 4(r3)
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
	lw	r2, 5(r3)
	lw	r1, 0(r3)
	lw	r8, 4(r3)
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r6, 1(r5)
	sw	r2, 0(r5)
	add	r2, r0, r5
	sw	r2, 118(r8)
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
	lw	r8, 4(r3)
	addi	r5, r0, 0				# set min_caml_n_objects
	lw	r5, 0(r5)
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
	lw	r8, 4(r3)
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r6, 1(r5)
	sw	r2, 0(r5)
	add	r2, r0, r5
	sw	r2, 117(r8)
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
	lw	r8, 4(r3)
	addi	r5, r0, 0				# set min_caml_n_objects
	lw	r5, 0(r5)
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
	lw	r8, 4(r3)
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r6, 1(r5)
	sw	r2, 0(r5)
	add	r2, r0, r5
	sw	r2, 116(r8)
	addi	r2, r0, 115
	add	r1, r0, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	create_dirvec_elements.3316				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 0(r3)
	addi	r6, r1, -1
	bgei	0, r6, bge_then.17757
	jr	r31				#
bge_then.17757:
	addi	r9, r0, 766				# set min_caml_dirvecs
	addi	r8, r0, 120
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r6, 8(r3)
	sw	r8, 9(r3)
	sw	r9, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_float_array				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1
	lw	r6, 8(r3)
	lw	r8, 9(r3)
	lw	r9, 10(r3)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 11(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r5, r0, r1
	lw	r2, 11(r3)
	lw	r6, 8(r3)
	lw	r8, 9(r3)
	lw	r9, 10(r3)
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r1)
	sw	r2, 0(r1)
	add	r2, r0, r1
	add	r1, r0, r8
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r6, 8(r3)
	lw	r9, 10(r3)
	add	r30, r9, r6
	sw	r1, 0(r30)
	addi	r1, r0, 766				# set min_caml_dirvecs
	add	r30, r1, r6
	lw	r8, 0(r30)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r8, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r2, r0, r1
	lw	r6, 8(r3)
	lw	r8, 12(r3)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_array				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r5, r0, r1
	lw	r2, 13(r3)
	lw	r6, 8(r3)
	lw	r8, 12(r3)
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r1)
	sw	r2, 0(r1)
	sw	r1, 118(r8)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_float_array				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r2, r0, r1
	lw	r6, 8(r3)
	lw	r8, 12(r3)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_array				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r5, r0, r1
	lw	r2, 14(r3)
	lw	r6, 8(r3)
	lw	r8, 12(r3)
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r1)
	sw	r2, 0(r1)
	sw	r1, 117(r8)
	addi	r2, r0, 116
	add	r1, r0, r8
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_dirvec_elements.3316				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r6, 8(r3)
	addi	r1, r6, -1
	j	create_dirvecs.3319
init_dirvec_constants.3321:
	bgei	0, r2, bge_then.17759
	jr	r31				#
bge_then.17759:
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
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	addi	r9, r2, -1
	bgei	0, r9, bge_then.17761
	jr	r31				#
bge_then.17761:
	add	r30, r1, r9
	lw	r8, 0(r30)
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r2, 0(r2)
	addi	r10, r2, -1
	bgei	0, r10, bge_then.17763
	j	bge_cont.17764
bge_then.17763:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r10
	lw	r7, 0(r30)
	lw	r6, 1(r8)
	lw	r2, 0(r8)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17765
	beqi	2, r5, beq_then.17767
	sw	r6, 2(r3)
	sw	r8, 3(r3)
	sw	r9, 4(r3)
	sw	r10, 5(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_second_table.3100				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r6, 2(r3)
	lw	r8, 3(r3)
	lw	r9, 4(r3)
	lw	r10, 5(r3)
	add	r30, r6, r10
	sw	r2, 0(r30)
	j	beq_cont.17768
beq_then.17767:
	sw	r6, 2(r3)
	sw	r8, 3(r3)
	sw	r9, 4(r3)
	sw	r10, 5(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_surface_table.3097				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r6, 2(r3)
	lw	r8, 3(r3)
	lw	r9, 4(r3)
	lw	r10, 5(r3)
	add	r30, r6, r10
	sw	r2, 0(r30)
beq_cont.17768:
	j	beq_cont.17766
beq_then.17765:
	sw	r6, 2(r3)
	sw	r8, 3(r3)
	sw	r9, 4(r3)
	sw	r10, 5(r3)
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
	lw	r8, 3(r3)
	lw	r9, 4(r3)
	lw	r10, 5(r3)
	add	r30, r6, r10
	sw	r2, 0(r30)
beq_cont.17766:
	addi	r2, r10, -1
	add	r1, r0, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 0(r3)
	lw	r9, 4(r3)
bge_cont.17764:
	addi	r5, r9, -1
	bgei	0, r5, bge_then.17769
	jr	r31				#
bge_then.17769:
	add	r30, r1, r5
	lw	r2, 0(r30)
	addi	r6, r0, 0				# set min_caml_n_objects
	lw	r6, 0(r6)
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
	bgei	0, r9, bge_then.17771
	jr	r31				#
bge_then.17771:
	add	r30, r1, r9
	lw	r8, 0(r30)
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r2, 0(r2)
	addi	r10, r2, -1
	bgei	0, r10, bge_then.17773
	j	bge_cont.17774
bge_then.17773:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r10
	lw	r7, 0(r30)
	lw	r6, 1(r8)
	lw	r2, 0(r8)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17775
	beqi	2, r5, beq_then.17777
	sw	r6, 7(r3)
	sw	r8, 8(r3)
	sw	r9, 9(r3)
	sw	r10, 10(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_second_table.3100				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r6, 7(r3)
	lw	r8, 8(r3)
	lw	r9, 9(r3)
	lw	r10, 10(r3)
	add	r30, r6, r10
	sw	r2, 0(r30)
	j	beq_cont.17778
beq_then.17777:
	sw	r6, 7(r3)
	sw	r8, 8(r3)
	sw	r9, 9(r3)
	sw	r10, 10(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_surface_table.3097				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	lw	r6, 7(r3)
	lw	r8, 8(r3)
	lw	r9, 9(r3)
	lw	r10, 10(r3)
	add	r30, r6, r10
	sw	r2, 0(r30)
beq_cont.17778:
	j	beq_cont.17776
beq_then.17775:
	sw	r6, 7(r3)
	sw	r8, 8(r3)
	sw	r9, 9(r3)
	sw	r10, 10(r3)
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
	lw	r8, 8(r3)
	lw	r9, 9(r3)
	lw	r10, 10(r3)
	add	r30, r6, r10
	sw	r2, 0(r30)
beq_cont.17776:
	addi	r2, r10, -1
	add	r1, r0, r8
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 0(r3)
	lw	r9, 9(r3)
bge_cont.17774:
	addi	r2, r9, -1
	j	init_dirvec_constants.3321
init_vecset_constants.3324:
	bgei	0, r1, bge_then.17779
	jr	r31				#
bge_then.17779:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r10, 0(r30)
	lw	r8, 119(r10)
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r2, 0(r2)
	addi	r9, r2, -1
	bgei	0, r9, bge_then.17781
	j	bge_cont.17782
bge_then.17781:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r9
	lw	r7, 0(r30)
	lw	r6, 1(r8)
	lw	r2, 0(r8)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17783
	beqi	2, r5, beq_then.17785
	sw	r6, 0(r3)
	sw	r1, 1(r3)
	sw	r8, 2(r3)
	sw	r9, 3(r3)
	sw	r10, 4(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3100				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
	lw	r6, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	lw	r9, 3(r3)
	lw	r10, 4(r3)
	add	r30, r6, r9
	sw	r2, 0(r30)
	j	beq_cont.17786
beq_then.17785:
	sw	r6, 0(r3)
	sw	r1, 1(r3)
	sw	r8, 2(r3)
	sw	r9, 3(r3)
	sw	r10, 4(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3097				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
	lw	r6, 0(r3)
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	lw	r9, 3(r3)
	lw	r10, 4(r3)
	add	r30, r6, r9
	sw	r2, 0(r30)
beq_cont.17786:
	j	beq_cont.17784
beq_then.17783:
	sw	r6, 0(r3)
	sw	r1, 1(r3)
	sw	r8, 2(r3)
	sw	r9, 3(r3)
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
	lw	r1, 1(r3)
	lw	r8, 2(r3)
	lw	r9, 3(r3)
	lw	r10, 4(r3)
	add	r30, r6, r9
	sw	r2, 0(r30)
beq_cont.17784:
	addi	r2, r9, -1
	add	r1, r0, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 1(r3)
	lw	r10, 4(r3)
bge_cont.17782:
	lw	r2, 118(r10)
	addi	r5, r0, 0				# set min_caml_n_objects
	lw	r5, 0(r5)
	addi	r5, r5, -1
	sw	r1, 1(r3)
	sw	r10, 4(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 1(r3)
	lw	r10, 4(r3)
	lw	r8, 117(r10)
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r2, 0(r2)
	addi	r9, r2, -1
	bgei	0, r9, bge_then.17787
	j	bge_cont.17788
bge_then.17787:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r9
	lw	r7, 0(r30)
	lw	r6, 1(r8)
	lw	r2, 0(r8)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17789
	beqi	2, r5, beq_then.17791
	sw	r6, 5(r3)
	sw	r8, 6(r3)
	sw	r9, 7(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_second_table.3100				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1
	lw	r6, 5(r3)
	lw	r1, 1(r3)
	lw	r8, 6(r3)
	lw	r9, 7(r3)
	lw	r10, 4(r3)
	add	r30, r6, r9
	sw	r2, 0(r30)
	j	beq_cont.17792
beq_then.17791:
	sw	r6, 5(r3)
	sw	r8, 6(r3)
	sw	r9, 7(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_surface_table.3097				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1
	lw	r6, 5(r3)
	lw	r1, 1(r3)
	lw	r8, 6(r3)
	lw	r9, 7(r3)
	lw	r10, 4(r3)
	add	r30, r6, r9
	sw	r2, 0(r30)
beq_cont.17792:
	j	beq_cont.17790
beq_then.17789:
	sw	r6, 5(r3)
	sw	r8, 6(r3)
	sw	r9, 7(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_rect_table.3094				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1
	lw	r6, 5(r3)
	lw	r1, 1(r3)
	lw	r8, 6(r3)
	lw	r9, 7(r3)
	lw	r10, 4(r3)
	add	r30, r6, r9
	sw	r2, 0(r30)
beq_cont.17790:
	addi	r2, r9, -1
	add	r1, r0, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	lw	r10, 4(r3)
bge_cont.17788:
	addi	r2, r0, 116
	add	r1, r0, r10
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	addi	r8, r1, -1
	bgei	0, r8, bge_then.17793
	jr	r31				#
bge_then.17793:
	addi	r1, r0, 766				# set min_caml_dirvecs
	add	r30, r1, r8
	lw	r10, 0(r30)
	lw	r1, 119(r10)
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r2, 0(r2)
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
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r9, r1, -1
	bgei	0, r9, bge_then.17795
	j	bge_cont.17796
bge_then.17795:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r9
	lw	r6, 0(r30)
	lw	r5, 1(r7)
	lw	r1, 0(r7)
	lw	r2, 1(r6)
	beqi	1, r2, beq_then.17797
	beqi	2, r2, beq_then.17799
	sw	r5, 10(r3)
	sw	r7, 11(r3)
	sw	r9, 12(r3)
	add	r2, r0, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_second_table.3100				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r5, 10(r3)
	lw	r7, 11(r3)
	lw	r8, 8(r3)
	lw	r9, 12(r3)
	lw	r10, 9(r3)
	add	r30, r5, r9
	sw	r1, 0(r30)
	j	beq_cont.17800
beq_then.17799:
	sw	r5, 10(r3)
	sw	r7, 11(r3)
	sw	r9, 12(r3)
	add	r2, r0, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_surface_table.3097				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r5, 10(r3)
	lw	r7, 11(r3)
	lw	r8, 8(r3)
	lw	r9, 12(r3)
	lw	r10, 9(r3)
	add	r30, r5, r9
	sw	r1, 0(r30)
beq_cont.17800:
	j	beq_cont.17798
beq_then.17797:
	sw	r5, 10(r3)
	sw	r7, 11(r3)
	sw	r9, 12(r3)
	add	r2, r0, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_rect_table.3094				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r5, 10(r3)
	lw	r7, 11(r3)
	lw	r8, 8(r3)
	lw	r9, 12(r3)
	lw	r10, 9(r3)
	add	r30, r5, r9
	sw	r1, 0(r30)
beq_cont.17798:
	addi	r1, r9, -1
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r8, 8(r3)
	lw	r10, 9(r3)
bge_cont.17796:
	addi	r2, r0, 117
	add	r1, r0, r10
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r8, 8(r3)
	addi	r8, r8, -1
	bgei	0, r8, bge_then.17801
	jr	r31				#
bge_then.17801:
	addi	r1, r0, 766				# set min_caml_dirvecs
	add	r30, r1, r8
	lw	r10, 0(r30)
	lw	r7, 119(r10)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r9, r1, -1
	bgei	0, r9, bge_then.17803
	j	bge_cont.17804
bge_then.17803:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r9
	lw	r6, 0(r30)
	lw	r5, 1(r7)
	lw	r1, 0(r7)
	lw	r2, 1(r6)
	beqi	1, r2, beq_then.17805
	beqi	2, r2, beq_then.17807
	sw	r5, 13(r3)
	sw	r7, 14(r3)
	sw	r8, 15(r3)
	sw	r9, 16(r3)
	sw	r10, 17(r3)
	add	r2, r0, r6
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_second_table.3100				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r5, 13(r3)
	lw	r7, 14(r3)
	lw	r8, 15(r3)
	lw	r9, 16(r3)
	lw	r10, 17(r3)
	add	r30, r5, r9
	sw	r1, 0(r30)
	j	beq_cont.17808
beq_then.17807:
	sw	r5, 13(r3)
	sw	r7, 14(r3)
	sw	r8, 15(r3)
	sw	r9, 16(r3)
	sw	r10, 17(r3)
	add	r2, r0, r6
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_surface_table.3097				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r5, 13(r3)
	lw	r7, 14(r3)
	lw	r8, 15(r3)
	lw	r9, 16(r3)
	lw	r10, 17(r3)
	add	r30, r5, r9
	sw	r1, 0(r30)
beq_cont.17808:
	j	beq_cont.17806
beq_then.17805:
	sw	r5, 13(r3)
	sw	r7, 14(r3)
	sw	r8, 15(r3)
	sw	r9, 16(r3)
	sw	r10, 17(r3)
	add	r2, r0, r6
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_rect_table.3094				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r5, 13(r3)
	lw	r7, 14(r3)
	lw	r8, 15(r3)
	lw	r9, 16(r3)
	lw	r10, 17(r3)
	add	r30, r5, r9
	sw	r1, 0(r30)
beq_cont.17806:
	addi	r1, r9, -1
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r8, 15(r3)
	lw	r10, 17(r3)
bge_cont.17804:
	addi	r2, r0, 118
	sw	r8, 15(r3)
	add	r1, r0, r10
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r8, 15(r3)
	addi	r1, r8, -1
	bgei	0, r1, bge_then.17809
	jr	r31				#
bge_then.17809:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r5, 0(r30)
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
	lw	r6, 0(r3)
	lw	r7, 1(r3)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r2, 2(r3)
	lw	r6, 0(r3)
	lw	r7, 1(r3)
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r1)
	sw	r2, 0(r1)
	add	r2, r0, r1
	add	r1, r0, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r7, 1(r3)
	sw	r1, 4(r7)
	addi	r1, r0, 766				# set min_caml_dirvecs
	lw	r6, 4(r1)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r6, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_float_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r6, 3(r3)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r5, r0, r1
	lw	r2, 4(r3)
	lw	r6, 3(r3)
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r1)
	sw	r2, 0(r1)
	sw	r1, 118(r6)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_float_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r2, r0, r1
	lw	r6, 3(r3)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r5, r0, r1
	lw	r2, 5(r3)
	lw	r6, 3(r3)
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r5, 1(r1)
	sw	r2, 0(r1)
	sw	r1, 117(r6)
	addi	r2, r0, 116
	add	r1, r0, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_dirvec_elements.3316				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 3
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_dirvecs.3319				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	itof	f2, r1
	flup	f1, 18		# fli	f1, 0.200000
	fmul	f2, f2, f1
	flup	f1, 48		# fli	f1, 0.900000
	fsub	f1, f2, f1
	addi	r1, r0, 4
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_dirvecs.3305				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 8
	addi	r2, r0, 2
	addi	r5, r0, 4
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_dirvec_rows.3310				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 766				# set min_caml_dirvecs
	lw	r9, 4(r1)
	lw	r1, 119(r9)
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r2, 0(r2)
	addi	r2, r2, -1
	sw	r9, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r9, 6(r3)
	lw	r7, 118(r9)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r8, r1, -1
	bgei	0, r8, bge_then.17811
	j	bge_cont.17812
bge_then.17811:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r8
	lw	r6, 0(r30)
	lw	r5, 1(r7)
	lw	r1, 0(r7)
	lw	r2, 1(r6)
	beqi	1, r2, beq_then.17813
	beqi	2, r2, beq_then.17815
	sw	r5, 7(r3)
	sw	r7, 8(r3)
	sw	r8, 9(r3)
	add	r2, r0, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_second_table.3100				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r5, 7(r3)
	lw	r7, 8(r3)
	lw	r8, 9(r3)
	lw	r9, 6(r3)
	add	r30, r5, r8
	sw	r1, 0(r30)
	j	beq_cont.17816
beq_then.17815:
	sw	r5, 7(r3)
	sw	r7, 8(r3)
	sw	r8, 9(r3)
	add	r2, r0, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_surface_table.3097				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r5, 7(r3)
	lw	r7, 8(r3)
	lw	r8, 9(r3)
	lw	r9, 6(r3)
	add	r30, r5, r8
	sw	r1, 0(r30)
beq_cont.17816:
	j	beq_cont.17814
beq_then.17813:
	sw	r5, 7(r3)
	sw	r7, 8(r3)
	sw	r8, 9(r3)
	add	r2, r0, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_rect_table.3094				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r5, 7(r3)
	lw	r7, 8(r3)
	lw	r8, 9(r3)
	lw	r9, 6(r3)
	add	r30, r5, r8
	sw	r1, 0(r30)
beq_cont.17814:
	addi	r1, r8, -1
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r9, 6(r3)
bge_cont.17812:
	addi	r2, r0, 117
	add	r1, r0, r9
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r1, r0, 766				# set min_caml_dirvecs
	lw	r9, 3(r1)
	lw	r7, 119(r9)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r8, r1, -1
	bgei	0, r8, bge_then.17817
	j	bge_cont.17818
bge_then.17817:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r8
	lw	r6, 0(r30)
	lw	r5, 1(r7)
	lw	r1, 0(r7)
	lw	r2, 1(r6)
	beqi	1, r2, beq_then.17819
	beqi	2, r2, beq_then.17821
	sw	r5, 10(r3)
	sw	r7, 11(r3)
	sw	r8, 12(r3)
	sw	r9, 13(r3)
	add	r2, r0, r6
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_second_table.3100				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r5, 10(r3)
	lw	r7, 11(r3)
	lw	r8, 12(r3)
	lw	r9, 13(r3)
	add	r30, r5, r8
	sw	r1, 0(r30)
	j	beq_cont.17822
beq_then.17821:
	sw	r5, 10(r3)
	sw	r7, 11(r3)
	sw	r8, 12(r3)
	sw	r9, 13(r3)
	add	r2, r0, r6
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_surface_table.3097				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r5, 10(r3)
	lw	r7, 11(r3)
	lw	r8, 12(r3)
	lw	r9, 13(r3)
	add	r30, r5, r8
	sw	r1, 0(r30)
beq_cont.17822:
	j	beq_cont.17820
beq_then.17819:
	sw	r5, 10(r3)
	sw	r7, 11(r3)
	sw	r8, 12(r3)
	sw	r9, 13(r3)
	add	r2, r0, r6
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_rect_table.3094				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r5, 10(r3)
	lw	r7, 11(r3)
	lw	r8, 12(r3)
	lw	r9, 13(r3)
	add	r30, r5, r8
	sw	r1, 0(r30)
beq_cont.17820:
	addi	r1, r8, -1
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r9, 13(r3)
bge_cont.17818:
	addi	r2, r0, 118
	add	r1, r0, r9
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r1, r0, 766				# set min_caml_dirvecs
	lw	r1, 2(r1)
	addi	r2, r0, 119
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -15
	lw	r31, 14(r3)
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
	addi	r11, r5, 1
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
	sw	r11, 12(r3)
	fadd	f1, f0, f5
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_float_array				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r2, r0, r1
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	flw	f6, 8(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r11, 12(r3)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 13(r3)
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
	lw	r2, 13(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r11, 12(r3)
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r9, 1(r1)
	sw	r2, 0(r1)
	add	r8, r0, r1
	fsw	f6, 0(r2)
	fsw	f2, 1(r2)
	fsw	f1, 2(r2)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r12, r1, -1
	bgei	0, r12, bge_then.17824
	j	bge_cont.17825
bge_then.17824:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r12
	lw	r7, 0(r30)
	lw	r1, 1(r7)
	beqi	1, r1, beq_then.17826
	beqi	2, r1, beq_then.17828
	sw	r8, 14(r3)
	sw	r9, 15(r3)
	sw	r12, 16(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	setup_second_table.3100				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r8, 14(r3)
	lw	r9, 15(r3)
	lw	r11, 12(r3)
	lw	r12, 16(r3)
	add	r30, r9, r12
	sw	r1, 0(r30)
	j	beq_cont.17829
beq_then.17828:
	sw	r8, 14(r3)
	sw	r9, 15(r3)
	sw	r12, 16(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	setup_surface_table.3097				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r8, 14(r3)
	lw	r9, 15(r3)
	lw	r11, 12(r3)
	lw	r12, 16(r3)
	add	r30, r9, r12
	sw	r1, 0(r30)
beq_cont.17829:
	j	beq_cont.17827
beq_then.17826:
	sw	r8, 14(r3)
	sw	r9, 15(r3)
	sw	r12, 16(r3)
	add	r1, r0, r2
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
	lw	r8, 14(r3)
	lw	r9, 15(r3)
	lw	r11, 12(r3)
	lw	r12, 16(r3)
	add	r30, r9, r12
	sw	r1, 0(r30)
beq_cont.17827:
	addi	r1, r12, -1
	add	r2, r0, r1
	add	r1, r0, r8
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r8, 14(r3)
	lw	r11, 12(r3)
bge_cont.17825:
	addi	r2, r0, 778				# set min_caml_reflections
	add	r1, r0, r4
	addi	r4, r4, 3
	fsw	f4, 2(r1)
	sw	r8, 1(r1)
	sw	r11, 0(r1)
	add	r30, r2, r6
	sw	r1, 0(r30)
	addi	r12, r6, 1
	addi	r11, r5, 2
	addi	r1, r0, 667				# set min_caml_light
	flw	f6, 1(r1)
	addi	r1, r0, 3
	flup	f5, 0		# fli	f5, 0.000000
	fsw	f6, 18(r3)
	sw	r11, 20(r3)
	sw	r12, 21(r3)
	fadd	f1, f0, f5
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_float_array				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	add	r2, r0, r1
	flw	f1, 0(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	flw	f6, 18(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r11, 20(r3)
	lw	r12, 21(r3)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 22(r3)
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
	lw	r2, 22(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r11, 20(r3)
	lw	r12, 21(r3)
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r9, 1(r1)
	sw	r2, 0(r1)
	add	r8, r0, r1
	fsw	f3, 0(r2)
	fsw	f6, 1(r2)
	fsw	f1, 2(r2)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r13, r1, -1
	bgei	0, r13, bge_then.17831
	j	bge_cont.17832
bge_then.17831:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r13
	lw	r7, 0(r30)
	lw	r1, 1(r7)
	beqi	1, r1, beq_then.17833
	beqi	2, r1, beq_then.17835
	sw	r8, 23(r3)
	sw	r9, 24(r3)
	sw	r13, 25(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_second_table.3100				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r8, 23(r3)
	lw	r9, 24(r3)
	lw	r11, 20(r3)
	lw	r12, 21(r3)
	lw	r13, 25(r3)
	add	r30, r9, r13
	sw	r1, 0(r30)
	j	beq_cont.17836
beq_then.17835:
	sw	r8, 23(r3)
	sw	r9, 24(r3)
	sw	r13, 25(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_surface_table.3097				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r8, 23(r3)
	lw	r9, 24(r3)
	lw	r11, 20(r3)
	lw	r12, 21(r3)
	lw	r13, 25(r3)
	add	r30, r9, r13
	sw	r1, 0(r30)
beq_cont.17836:
	j	beq_cont.17834
beq_then.17833:
	sw	r8, 23(r3)
	sw	r9, 24(r3)
	sw	r13, 25(r3)
	add	r1, r0, r2
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
	lw	r8, 23(r3)
	lw	r9, 24(r3)
	lw	r11, 20(r3)
	lw	r12, 21(r3)
	lw	r13, 25(r3)
	add	r30, r9, r13
	sw	r1, 0(r30)
beq_cont.17834:
	addi	r1, r13, -1
	add	r2, r0, r1
	add	r1, r0, r8
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	lw	r8, 23(r3)
	lw	r11, 20(r3)
	lw	r12, 21(r3)
bge_cont.17832:
	addi	r2, r0, 778				# set min_caml_reflections
	add	r1, r0, r4
	addi	r4, r4, 3
	fsw	f4, 2(r1)
	sw	r8, 1(r1)
	sw	r11, 0(r1)
	add	r30, r2, r12
	sw	r1, 0(r30)
	addi	r11, r6, 2
	addi	r9, r5, 3
	addi	r1, r0, 667				# set min_caml_light
	flw	f5, 2(r1)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f5, 26(r3)
	sw	r9, 28(r3)
	sw	r11, 29(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	lib_create_float_array				
	addi	r3, r3, -31
	lw	r31, 30(r3)
	add	r2, r0, r1
	flw	f2, 2(r3)
	flw	f3, 4(r3)
	flw	f4, 6(r3)
	flw	f5, 26(r3)
	lw	r6, 11(r3)
	lw	r9, 28(r3)
	lw	r11, 29(r3)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 30(r3)
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
	lw	r2, 30(r3)
	lw	r6, 11(r3)
	lw	r9, 28(r3)
	lw	r11, 29(r3)
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r8, 1(r1)
	sw	r2, 0(r1)
	add	r7, r0, r1
	fsw	f3, 0(r2)
	fsw	f2, 1(r2)
	fsw	f5, 2(r2)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r12, r1, -1
	bgei	0, r12, bge_then.17837
	j	bge_cont.17838
bge_then.17837:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r12
	lw	r5, 0(r30)
	lw	r1, 1(r5)
	beqi	1, r1, beq_then.17839
	beqi	2, r1, beq_then.17841
	sw	r7, 31(r3)
	sw	r8, 32(r3)
	sw	r12, 33(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_second_table.3100				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flw	f4, 6(r3)
	lw	r6, 11(r3)
	lw	r7, 31(r3)
	lw	r8, 32(r3)
	lw	r9, 28(r3)
	lw	r11, 29(r3)
	lw	r12, 33(r3)
	add	r30, r8, r12
	sw	r1, 0(r30)
	j	beq_cont.17842
beq_then.17841:
	sw	r7, 31(r3)
	sw	r8, 32(r3)
	sw	r12, 33(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_surface_table.3097				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flw	f4, 6(r3)
	lw	r6, 11(r3)
	lw	r7, 31(r3)
	lw	r8, 32(r3)
	lw	r9, 28(r3)
	lw	r11, 29(r3)
	lw	r12, 33(r3)
	add	r30, r8, r12
	sw	r1, 0(r30)
beq_cont.17842:
	j	beq_cont.17840
beq_then.17839:
	sw	r7, 31(r3)
	sw	r8, 32(r3)
	sw	r12, 33(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_rect_table.3094				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flw	f4, 6(r3)
	lw	r6, 11(r3)
	lw	r7, 31(r3)
	lw	r8, 32(r3)
	lw	r9, 28(r3)
	lw	r11, 29(r3)
	lw	r12, 33(r3)
	add	r30, r8, r12
	sw	r1, 0(r30)
beq_cont.17840:
	addi	r1, r12, -1
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flw	f4, 6(r3)
	lw	r6, 11(r3)
	lw	r7, 31(r3)
	lw	r9, 28(r3)
	lw	r11, 29(r3)
bge_cont.17838:
	addi	r2, r0, 778				# set min_caml_reflections
	add	r1, r0, r4
	addi	r4, r4, 3
	fsw	f4, 2(r1)
	sw	r7, 1(r1)
	sw	r9, 0(r1)
	add	r30, r2, r11
	sw	r1, 0(r30)
	addi	r2, r0, 1023				# set min_caml_n_reflections
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
	flw	f3, 0(r7)
	flw	f1, 0(r1)
	fmul	f4, f3, f1
	flw	f3, 1(r7)
	flw	f1, 1(r1)
	fmul	f1, f3, f1
	fadd	f4, f4, f1
	flw	f3, 2(r7)
	flw	f1, 2(r1)
	fmul	f1, f3, f1
	fadd	f1, f4, f1
	flup	f4, 3		# fli	f4, 2.000000
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
	add	r2, r0, r1
	flw	f2, 0(r3)
	flw	f3, 2(r3)
	flw	f5, 4(r3)
	flw	f6, 6(r3)
	lw	r5, 8(r3)
	lw	r6, 9(r3)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	sw	r2, 10(r3)
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
	lw	r2, 10(r3)
	lw	r5, 8(r3)
	lw	r6, 9(r3)
	add	r1, r0, r4
	addi	r4, r4, 2
	sw	r9, 1(r1)
	sw	r2, 0(r1)
	add	r8, r0, r1
	fsw	f6, 0(r2)
	fsw	f5, 1(r2)
	fsw	f3, 2(r2)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r10, r1, -1
	bgei	0, r10, bge_then.17844
	j	bge_cont.17845
bge_then.17844:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r10
	lw	r7, 0(r30)
	lw	r1, 1(r7)
	beqi	1, r1, beq_then.17846
	beqi	2, r1, beq_then.17848
	sw	r8, 11(r3)
	sw	r9, 12(r3)
	sw	r10, 13(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_second_table.3100				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 0(r3)
	lw	r5, 8(r3)
	lw	r6, 9(r3)
	lw	r8, 11(r3)
	lw	r9, 12(r3)
	lw	r10, 13(r3)
	add	r30, r9, r10
	sw	r1, 0(r30)
	j	beq_cont.17849
beq_then.17848:
	sw	r8, 11(r3)
	sw	r9, 12(r3)
	sw	r10, 13(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_surface_table.3097				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 0(r3)
	lw	r5, 8(r3)
	lw	r6, 9(r3)
	lw	r8, 11(r3)
	lw	r9, 12(r3)
	lw	r10, 13(r3)
	add	r30, r9, r10
	sw	r1, 0(r30)
beq_cont.17849:
	j	beq_cont.17847
beq_then.17846:
	sw	r8, 11(r3)
	sw	r9, 12(r3)
	sw	r10, 13(r3)
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_rect_table.3094				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 0(r3)
	lw	r5, 8(r3)
	lw	r6, 9(r3)
	lw	r8, 11(r3)
	lw	r9, 12(r3)
	lw	r10, 13(r3)
	add	r30, r9, r10
	sw	r1, 0(r30)
beq_cont.17847:
	addi	r1, r10, -1
	add	r2, r0, r1
	add	r1, r0, r8
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 0(r3)
	lw	r5, 8(r3)
	lw	r6, 9(r3)
	lw	r8, 11(r3)
bge_cont.17845:
	addi	r2, r0, 778				# set min_caml_reflections
	add	r1, r0, r4
	addi	r4, r4, 3
	fsw	f2, 2(r1)
	sw	r8, 1(r1)
	sw	r5, 0(r1)
	add	r30, r2, r6
	sw	r1, 0(r30)
	addi	r2, r0, 1023				# set min_caml_n_reflections
	addi	r1, r6, 1
	sw	r1, 0(r2)
	jr	r31				#
setup_reflections.3341:
	bgei	0, r1, bge_then.17851
	jr	r31				#
bge_then.17851:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.17853
	jr	r31				#
beq_then.17853:
	flup	f2, 2		# fli	f2, 1.000000
	lw	r5, 7(r2)
	flw	f1, 0(r5)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17855
	jr	r31				#
fle_else.17855:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.17857
	beqi	2, r5, beq_then.17858
	jr	r31				#
beq_then.17858:
	j	setup_surface_reflection.3338
beq_then.17857:
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
	lw	r13, 0(r1)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r13, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_float_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r5, r0, r1
	lw	r13, 0(r3)
	sw	r5, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	create_float5x3array.3283				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r8, r0, r1
	lw	r5, 1(r3)
	lw	r13, 0(r3)
	addi	r1, r0, 5
	addi	r2, r0, 0
	sw	r8, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r5, 1(r3)
	lw	r8, 2(r3)
	lw	r13, 0(r3)
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
	add	r12, r0, r1
	lw	r2, 3(r3)
	lw	r5, 1(r3)
	lw	r8, 2(r3)
	lw	r13, 0(r3)
	sw	r12, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_float5x3array.3283				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r10, r0, r1
	lw	r2, 3(r3)
	lw	r5, 1(r3)
	lw	r8, 2(r3)
	lw	r12, 4(r3)
	lw	r13, 0(r3)
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
	lw	r12, 4(r3)
	lw	r13, 0(r3)
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
	lw	r12, 4(r3)
	lw	r13, 0(r3)
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
	lw	r12, 4(r3)
	lw	r13, 0(r3)
	add	r1, r0, r4
	addi	r4, r4, 8
	sw	r7, 7(r1)
	sw	r9, 6(r1)
	sw	r6, 5(r1)
	sw	r10, 4(r1)
	sw	r12, 3(r1)
	sw	r2, 2(r1)
	sw	r8, 1(r1)
	sw	r5, 0(r1)
	add	r2, r0, r1
	add	r1, r0, r13
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	addi	r2, r0, 743				# set min_caml_image_size
	lw	r2, 0(r2)
	addi	r2, r2, -2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	init_line_elements.3287				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r6, r0, r1
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r14, 0(r1)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r6, 8(r3)
	sw	r14, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_float_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r5, r0, r1
	lw	r6, 8(r3)
	lw	r14, 9(r3)
	sw	r5, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_float5x3array.3283				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r9, r0, r1
	lw	r6, 8(r3)
	lw	r5, 10(r3)
	lw	r14, 9(r3)
	addi	r1, r0, 5
	addi	r2, r0, 0
	sw	r9, 11(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r2, r0, r1
	lw	r6, 8(r3)
	lw	r5, 10(r3)
	lw	r9, 11(r3)
	lw	r14, 9(r3)
	addi	r7, r0, 5
	addi	r1, r0, 0
	sw	r2, 12(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r13, r0, r1
	lw	r6, 8(r3)
	lw	r2, 12(r3)
	lw	r5, 10(r3)
	lw	r9, 11(r3)
	lw	r14, 9(r3)
	sw	r13, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	create_float5x3array.3283				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r12, r0, r1
	lw	r6, 8(r3)
	lw	r2, 12(r3)
	lw	r5, 10(r3)
	lw	r9, 11(r3)
	lw	r13, 13(r3)
	lw	r14, 9(r3)
	sw	r12, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_float5x3array.3283				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r7, r0, r1
	lw	r6, 8(r3)
	lw	r2, 12(r3)
	lw	r5, 10(r3)
	lw	r9, 11(r3)
	lw	r12, 14(r3)
	lw	r13, 13(r3)
	lw	r14, 9(r3)
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
	lw	r6, 8(r3)
	lw	r2, 12(r3)
	lw	r5, 10(r3)
	lw	r7, 15(r3)
	lw	r9, 11(r3)
	lw	r12, 14(r3)
	lw	r13, 13(r3)
	lw	r14, 9(r3)
	sw	r10, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3283				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	add	r8, r0, r1
	lw	r6, 8(r3)
	lw	r2, 12(r3)
	lw	r5, 10(r3)
	lw	r7, 15(r3)
	lw	r9, 11(r3)
	lw	r10, 16(r3)
	lw	r12, 14(r3)
	lw	r13, 13(r3)
	lw	r14, 9(r3)
	add	r1, r0, r4
	addi	r4, r4, 8
	sw	r8, 7(r1)
	sw	r10, 6(r1)
	sw	r7, 5(r1)
	sw	r12, 4(r1)
	sw	r13, 3(r1)
	sw	r2, 2(r1)
	sw	r9, 1(r1)
	sw	r5, 0(r1)
	add	r2, r0, r1
	add	r1, r0, r14
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_array				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	lw	r6, 8(r3)
	addi	r2, r0, 743				# set min_caml_image_size
	lw	r2, 0(r2)
	addi	r2, r2, -2
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	init_line_elements.3287				
	addi	r3, r3, -18
	lw	r31, 17(r3)
	add	r14, r0, r1
	lw	r6, 8(r3)
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r15, 0(r1)
	addi	r1, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r14, 17(r3)
	sw	r15, 18(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	lib_create_float_array				
	addi	r3, r3, -20
	lw	r31, 19(r3)
	add	r5, r0, r1
	lw	r6, 8(r3)
	lw	r14, 17(r3)
	lw	r15, 18(r3)
	sw	r5, 19(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	create_float5x3array.3283				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	add	r9, r0, r1
	lw	r6, 8(r3)
	lw	r5, 19(r3)
	lw	r14, 17(r3)
	lw	r15, 18(r3)
	addi	r1, r0, 5
	addi	r2, r0, 0
	sw	r9, 20(r3)
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_array				
	addi	r3, r3, -22
	lw	r31, 21(r3)
	add	r2, r0, r1
	lw	r6, 8(r3)
	lw	r5, 19(r3)
	lw	r9, 20(r3)
	lw	r14, 17(r3)
	lw	r15, 18(r3)
	addi	r7, r0, 5
	addi	r1, r0, 0
	sw	r2, 21(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	lib_create_array				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	add	r13, r0, r1
	lw	r6, 8(r3)
	lw	r2, 21(r3)
	lw	r5, 19(r3)
	lw	r9, 20(r3)
	lw	r14, 17(r3)
	lw	r15, 18(r3)
	sw	r13, 22(r3)
	sw	r31, 23(r3)
	addi	r3, r3, 24
	jal	create_float5x3array.3283				
	addi	r3, r3, -24
	lw	r31, 23(r3)
	add	r12, r0, r1
	lw	r6, 8(r3)
	lw	r2, 21(r3)
	lw	r5, 19(r3)
	lw	r9, 20(r3)
	lw	r13, 22(r3)
	lw	r14, 17(r3)
	lw	r15, 18(r3)
	sw	r12, 23(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	create_float5x3array.3283				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	add	r7, r0, r1
	lw	r6, 8(r3)
	lw	r2, 21(r3)
	lw	r5, 19(r3)
	lw	r9, 20(r3)
	lw	r12, 23(r3)
	lw	r13, 22(r3)
	lw	r14, 17(r3)
	lw	r15, 18(r3)
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
	lw	r6, 8(r3)
	lw	r2, 21(r3)
	lw	r5, 19(r3)
	lw	r7, 24(r3)
	lw	r9, 20(r3)
	lw	r12, 23(r3)
	lw	r13, 22(r3)
	lw	r14, 17(r3)
	lw	r15, 18(r3)
	sw	r10, 25(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	create_float5x3array.3283				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	add	r8, r0, r1
	lw	r6, 8(r3)
	lw	r2, 21(r3)
	lw	r5, 19(r3)
	lw	r7, 24(r3)
	lw	r9, 20(r3)
	lw	r10, 25(r3)
	lw	r12, 23(r3)
	lw	r13, 22(r3)
	lw	r14, 17(r3)
	lw	r15, 18(r3)
	add	r1, r0, r4
	addi	r4, r4, 8
	sw	r8, 7(r1)
	sw	r10, 6(r1)
	sw	r7, 5(r1)
	sw	r12, 4(r1)
	sw	r13, 3(r1)
	sw	r2, 2(r1)
	sw	r9, 1(r1)
	sw	r5, 0(r1)
	add	r2, r0, r1
	add	r1, r0, r15
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_array				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r6, 8(r3)
	lw	r14, 17(r3)
	addi	r2, r0, 743				# set min_caml_image_size
	lw	r2, 0(r2)
	addi	r2, r2, -2
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	init_line_elements.3287				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	add	r7, r0, r1
	lw	r6, 8(r3)
	lw	r14, 17(r3)
	sw	r7, 26(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	read_screen_settings.2989				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	read_light.2991				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	addi	r1, r0, 0
	sw	r1, 27(r3)
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_nth_object.2996				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	add	r2, r0, r1
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	lw	r1, 27(r3)
	beqi	0, r2, beq_then.17860
	addi	r1, r0, 1
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_object.2998				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	j	beq_cont.17861
beq_then.17860:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
beq_cont.17861:
	addi	r1, r0, 0
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_and_network.3006				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	addi	r2, r0, 723				# set min_caml_or_net
	addi	r1, r0, 0
	sw	r2, 28(r3)
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	read_or_network.3004				
	addi	r3, r3, -30
	lw	r31, 29(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	lw	r2, 28(r3)
	sw	r1, 0(r2)
	addi	r1, r0, 80
	out	r1
	addi	r1, r0, 51
	out	r1
	addi	r1, r0, 10
	out	r1
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r1, 0(r1)
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	print_int.2857				
	addi	r3, r3, -30
	lw	r31, 29(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r1, 1(r1)
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	print_int.2857				
	addi	r3, r3, -30
	lw	r31, 29(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 255
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	print_int.2857				
	addi	r3, r3, -30
	lw	r31, 29(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	addi	r1, r0, 10
	out	r1
	addi	r1, r0, 4
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	create_dirvecs.3319				
	addi	r3, r3, -30
	lw	r31, 29(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	calc_dirvec_rows.3310				
	addi	r3, r3, -30
	lw	r31, 29(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	addi	r1, r0, 766				# set min_caml_dirvecs
	lw	r11, 4(r1)
	lw	r9, 119(r11)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r10, r1, -1
	bgei	0, r10, bge_then.17862
	j	bge_cont.17863
bge_then.17862:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r10
	lw	r8, 0(r30)
	lw	r5, 1(r9)
	lw	r1, 0(r9)
	lw	r2, 1(r8)
	beqi	1, r2, beq_then.17864
	beqi	2, r2, beq_then.17866
	sw	r5, 29(r3)
	sw	r9, 30(r3)
	sw	r10, 31(r3)
	sw	r11, 32(r3)
	add	r2, r0, r8
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_second_table.3100				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r5, 29(r3)
	lw	r14, 17(r3)
	lw	r9, 30(r3)
	lw	r10, 31(r3)
	lw	r11, 32(r3)
	add	r30, r5, r10
	sw	r1, 0(r30)
	j	beq_cont.17867
beq_then.17866:
	sw	r5, 29(r3)
	sw	r9, 30(r3)
	sw	r10, 31(r3)
	sw	r11, 32(r3)
	add	r2, r0, r8
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_surface_table.3097				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r5, 29(r3)
	lw	r14, 17(r3)
	lw	r9, 30(r3)
	lw	r10, 31(r3)
	lw	r11, 32(r3)
	add	r30, r5, r10
	sw	r1, 0(r30)
beq_cont.17867:
	j	beq_cont.17865
beq_then.17864:
	sw	r5, 29(r3)
	sw	r9, 30(r3)
	sw	r10, 31(r3)
	sw	r11, 32(r3)
	add	r2, r0, r8
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_rect_table.3094				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r5, 29(r3)
	lw	r14, 17(r3)
	lw	r9, 30(r3)
	lw	r10, 31(r3)
	lw	r11, 32(r3)
	add	r30, r5, r10
	sw	r1, 0(r30)
beq_cont.17865:
	addi	r1, r10, -1
	add	r2, r0, r1
	add	r1, r0, r9
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	lw	r11, 32(r3)
bge_cont.17863:
	addi	r2, r0, 118
	add	r1, r0, r11
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	addi	r1, r0, 766				# set min_caml_dirvecs
	lw	r1, 3(r1)
	addi	r2, r0, 119
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	addi	r1, r0, 2
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	init_vecset_constants.3324				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	addi	r1, r0, 1021				# set min_caml_light_dirvec
	lw	r1, 0(r1)
	addi	r2, r0, 667				# set min_caml_light
	flw	f1, 0(r2)
	fsw	f1, 0(r1)
	flw	f1, 1(r2)
	fsw	f1, 1(r1)
	flw	f1, 2(r2)
	fsw	f1, 2(r1)
	addi	r1, r0, 1021				# set min_caml_light_dirvec
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r2, 0(r2)
	addi	r2, r2, -1
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r5, r1, -1
	bgei	0, r5, bge_then.17868
	j	bge_cont.17869
bge_then.17868:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r5
	lw	r1, 0(r30)
	lw	r2, 2(r1)
	beqi	2, r2, beq_then.17870
	j	beq_cont.17871
beq_then.17870:
	flup	f2, 2		# fli	f2, 1.000000
	lw	r2, 7(r1)
	flw	f1, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17872
	j	fle_cont.17873
fle_else.17872:
	lw	r2, 1(r1)
	beqi	1, r2, beq_then.17874
	beqi	2, r2, beq_then.17876
	j	beq_cont.17877
beq_then.17876:
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_surface_reflection.3338				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
beq_cont.17877:
	j	beq_cont.17875
beq_then.17874:
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_rect_reflection.3335				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
beq_cont.17875:
fle_cont.17873:
beq_cont.17871:
bge_cont.17869:
	addi	r2, r0, 0
	addi	r5, r0, 0
	add	r1, r0, r14
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	pretrace_line.3267				
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	addi	r5, r0, 0
	addi	r2, r0, 2
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r1, 1(r1)
	blei	0, r1, ble_then.17878
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r1, 1(r1)
	addi	r1, r1, -1
	blei	0, r1, ble_then.17879
	addi	r1, r0, 1
	sw	r5, 33(r3)
	add	r5, r0, r2
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	pretrace_line.3267				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	lw	r5, 33(r3)
	j	ble_cont.17880
ble_then.17879:
ble_cont.17880:
	addi	r1, r0, 0
	add	r2, r0, r5
	add	r5, r0, r6
	add	r6, r0, r14
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	scan_pixel.3271				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	addi	r2, r0, 1
	addi	r1, r0, 4
	add	r5, r0, r7
	add	r7, r0, r1
	add	r1, r0, r2
	add	r2, r0, r14
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	scan_line.3277				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	jr	r31				#
ble_then.17878:
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
