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
	beq	r0, r30, fle_else.11253
	addi	r1, r0, 0
	jr	r31				#
fle_else.11253:
	addi	r1, r0, 1
	jr	r31				#
fisneg.2805:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11254
	addi	r1, r0, 0
	jr	r31				#
fle_else.11254:
	addi	r1, r0, 1
	jr	r31				#
fiszero.2807:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11255
	addi	r1, r0, 1
	jr	r31				#
feq_else.11255:
	addi	r1, r0, 0
	jr	r31				#
xor.2809:
	beq	r1, r2, beq_then.11256
	addi	r1, r0, 1
	jr	r31				#
beq_then.11256:
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
	beq	r0, r30, fle_else.11257
	jr	r31				#
fle_else.11257:
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
	beq	r0, r30, fle_else.11258
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11258:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
	jr	r31				#
hoge.2824:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11259
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11260
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11261
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11262
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11263
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11264
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11265
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11266
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2824
fle_else.11266:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11265:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11264:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11263:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11262:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11261:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11260:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.11259:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2827:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11267
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11268
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11269
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11270
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	j	fuga.2827
fle_else.11270:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	j	fuga.2827
fle_else.11269:
	jr	r31				#
fle_else.11268:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11271
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11272
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	j	fuga.2827
fle_else.11272:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	j	fuga.2827
fle_else.11271:
	jr	r31				#
fle_else.11267:
	jr	r31				#
modulo_2pi.2831:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 0(r3)
	fsw	f1, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11273
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11275
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11277
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11279
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11281
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11283
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11285
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	hoge.2824				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	fle_cont.11286
fle_else.11285:
	fadd	f1, f0, f2
fle_cont.11286:
	j	fle_cont.11284
fle_else.11283:
	fadd	f1, f0, f2
fle_cont.11284:
	j	fle_cont.11282
fle_else.11281:
	fadd	f1, f0, f2
fle_cont.11282:
	j	fle_cont.11280
fle_else.11279:
	fadd	f1, f0, f2
fle_cont.11280:
	j	fle_cont.11278
fle_else.11277:
	fadd	f1, f0, f2
fle_cont.11278:
	j	fle_cont.11276
fle_else.11275:
	fadd	f1, f0, f2
fle_cont.11276:
	j	fle_cont.11274
fle_else.11273:
	fadd	f1, f0, f2
fle_cont.11274:
	flup	f2, 5		# fli	f2, 6.283186
	flw	f3, 2(r3)
	fle	r30, f2, f3
	beq	r0, r30, fle_else.11287
	fle	r30, f1, f3
	beq	r0, r30, fle_else.11288
	fsub	f2, f3, f1
	flup	f3, 3		# fli	f3, 2.000000
	finv	f31, f3
	fmul	f1, f1, f31
	flw	f3, 0(r3)
	fadd	f30, f0, f2
	fadd	f2, f0, f1
	fadd	f1, f0, f30
	j	fuga.2827
fle_else.11288:
	flup	f2, 3		# fli	f2, 2.000000
	finv	f31, f2
	fmul	f2, f1, f31
	flw	f1, 0(r3)
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	j	fuga.2827
fle_else.11287:
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
	beq	r0, r30, fle_else.11289
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.11290
fle_else.11289:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.11290:
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
	beq	r0, r30, fle_else.11291
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11293
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11295
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11297
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11299
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11301
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2824				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1
	j	fle_cont.11302
fle_else.11301:
fle_cont.11302:
	j	fle_cont.11300
fle_else.11299:
fle_cont.11300:
	j	fle_cont.11298
fle_else.11297:
fle_cont.11298:
	j	fle_cont.11296
fle_else.11295:
fle_cont.11296:
	j	fle_cont.11294
fle_else.11293:
fle_cont.11294:
	j	fle_cont.11292
fle_else.11291:
fle_cont.11292:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2827				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11303
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11304
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11305
	fsw	f3, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2833				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.11305:
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
fle_else.11304:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11306
	fsw	f3, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2833				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.11306:
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
fle_else.11303:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11307
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11308
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2833				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.11308:
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
fle_else.11307:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11309
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2833				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.11309:
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
	beq	r0, r30, fle_else.11310
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11312
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11314
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11316
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11318
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11320
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2824				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1
	j	fle_cont.11321
fle_else.11320:
fle_cont.11321:
	j	fle_cont.11319
fle_else.11318:
fle_cont.11319:
	j	fle_cont.11317
fle_else.11316:
fle_cont.11317:
	j	fle_cont.11315
fle_else.11314:
fle_cont.11315:
	j	fle_cont.11313
fle_else.11312:
fle_cont.11313:
	j	fle_cont.11311
fle_else.11310:
fle_cont.11311:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2827				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11322
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11323
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.11324
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
fle_else.11324:
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
fle_else.11323:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11325
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
fle_else.11325:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin_body.2833				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.11322:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11326
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.11327
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
fle_else.11327:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fsw	f2, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin_body.2833				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.11326:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11328
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
fle_else.11328:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin_body.2833				
	addi	r3, r3, -15
	lw	r31, 14(r3)
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
	beq	r0, r30, fle_else.11329
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.11330
fle_else.11329:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.11330:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11331
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11332
	flup	f3, 15		# fli	f3, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	finv	f31, f1
	fmul	f1, f4, f31
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
fle_else.11332:
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
	jal	atan_body.2841				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.11331:
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
	ble	r7, r1, ble_then.11333
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r7, r5, 3
	slli	r8, r5, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.11334
	j	div10_sub.2849
ble_then.11334:
	slli	r2, r5, 3
	slli	r7, r5, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.11335
	add	r2, r0, r5
	add	r5, r0, r6
	j	div10_sub.2849
ble_then.11335:
	add	r1, r0, r5
	jr	r31				#
ble_then.11333:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.11336
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r7, r2, 3
	slli	r8, r2, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.11337
	add	r5, r0, r2
	add	r2, r0, r6
	j	div10_sub.2849
ble_then.11337:
	slli	r6, r2, 3
	slli	r7, r2, 1
	add	r6, r6, r7
	addi	r6, r6, 9
	ble	r1, r6, ble_then.11338
	j	div10_sub.2849
ble_then.11338:
	add	r1, r0, r2
	jr	r31				#
ble_then.11336:
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
	bgei	10, r1, bge_then.11339
	addi	r1, r1, 48
	out	r1
	jr	r31				#
bge_then.11339:
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
	bgei	10, r2, bge_then.11340
	addi	r5, r2, 48
	out	r5
	j	bge_cont.11341
bge_then.11340:
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
bge_cont.11341:
	slli	r1, r2, 3
	slli	r2, r2, 1
	add	r1, r1, r2
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
	jr	r31				#
print_int.2857:
	bgei	0, r1, bge_then.11342
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	j	print_int.2857
bge_then.11342:
	bgei	10, r1, bge_then.11343
	addi	r1, r1, 48
	out	r1
	jr	r31				#
bge_then.11343:
	addi	r2, r0, 100
	ble	r2, r1, ble_then.11344
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
ble_then.11344:
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
	beqi	0, r1, beq_then.11345
	beqi	0, r2, beq_then.11346
	addi	r1, r0, 0
	jr	r31				#
beq_then.11346:
	addi	r1, r0, 1
	jr	r31				#
beq_then.11345:
	add	r1, r0, r2
	jr	r31				#
sgn.2862:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11347
	addi	r1, r0, 1
	j	feq_cont.11348
feq_else.11347:
	addi	r1, r0, 0
feq_cont.11348:
	beqi	0, r1, beq_then.11349
	flup	f1, 0		# fli	f1, 0.000000
	jr	r31				#
beq_then.11349:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11350
	addi	r1, r0, 0
	j	fle_cont.11351
fle_else.11350:
	addi	r1, r0, 1
fle_cont.11351:
	beqi	0, r1, beq_then.11352
	flup	f1, 2		# fli	f1, 1.000000
	jr	r31				#
beq_then.11352:
	flup	f1, 11		# fli	f1, -1.000000
	jr	r31				#
fneg_cond.2864:
	beqi	0, r1, beq_then.11353
	jr	r31				#
beq_then.11353:
	fneg	f1, f1
	jr	r31				#
add_mod5.2867:
	add	r1, r1, r2
	bgei	5, r1, bge_then.11354
	jr	r31				#
bge_then.11354:
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
	finv	f31, f2
	fmul	f1, f1, f31
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
	beq	r0, r30, feq_else.11360
	addi	r5, r0, 1
	j	feq_cont.11361
feq_else.11360:
	addi	r5, r0, 0
feq_cont.11361:
	beqi	0, r5, beq_then.11362
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.11363
beq_then.11362:
	beqi	0, r2, beq_then.11364
	flup	f2, 11		# fli	f2, -1.000000
	finv	f31, f1
	fmul	f1, f2, f31
	j	beq_cont.11365
beq_then.11364:
	flup	f2, 2		# fli	f2, 1.000000
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.11365:
beq_cont.11363:
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
	beqi	-1, r1, beq_then.11376
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
	beq	r0, r30, fle_else.11377
	addi	r1, r0, 0
	j	fle_cont.11378
fle_else.11377:
	addi	r1, r0, 1
fle_cont.11378:
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
	beqi	0, r2, beq_then.11379
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
	j	beq_cont.11380
beq_then.11379:
beq_cont.11380:
	lw	r2, 2(r3)
	beqi	2, r2, beq_then.11381
	lw	r5, 7(r3)
	j	beq_cont.11382
beq_then.11381:
	addi	r5, r0, 1
beq_cont.11382:
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
	beqi	3, r7, beq_then.11383
	beqi	2, r7, beq_then.11385
	j	beq_cont.11386
beq_then.11385:
	lw	r2, 7(r3)
	beqi	0, r2, beq_then.11387
	addi	r2, r0, 0
	j	beq_cont.11388
beq_then.11387:
	addi	r2, r0, 1
beq_cont.11388:
	add	r1, r0, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	vecunit_sgn.2888				
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.11386:
	j	beq_cont.11384
beq_then.11383:
	flw	f1, 0(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11389
	addi	r2, r0, 1
	j	feq_cont.11390
feq_else.11389:
	addi	r2, r0, 0
feq_cont.11390:
	beqi	0, r2, beq_then.11391
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11392
beq_then.11391:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11393
	addi	r2, r0, 1
	j	feq_cont.11394
feq_else.11393:
	addi	r2, r0, 0
feq_cont.11394:
	beqi	0, r2, beq_then.11395
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.11396
beq_then.11395:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11397
	addi	r2, r0, 0
	j	fle_cont.11398
fle_else.11397:
	addi	r2, r0, 1
fle_cont.11398:
	beqi	0, r2, beq_then.11399
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.11400
beq_then.11399:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.11400:
beq_cont.11396:
	fmul	f1, f1, f1
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.11392:
	fsw	f1, 0(r5)
	flw	f1, 1(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11401
	addi	r2, r0, 1
	j	feq_cont.11402
feq_else.11401:
	addi	r2, r0, 0
feq_cont.11402:
	beqi	0, r2, beq_then.11403
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11404
beq_then.11403:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11405
	addi	r2, r0, 1
	j	feq_cont.11406
feq_else.11405:
	addi	r2, r0, 0
feq_cont.11406:
	beqi	0, r2, beq_then.11407
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.11408
beq_then.11407:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11409
	addi	r2, r0, 0
	j	fle_cont.11410
fle_else.11409:
	addi	r2, r0, 1
fle_cont.11410:
	beqi	0, r2, beq_then.11411
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.11412
beq_then.11411:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.11412:
beq_cont.11408:
	fmul	f1, f1, f1
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.11404:
	fsw	f1, 1(r5)
	flw	f1, 2(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11413
	addi	r2, r0, 1
	j	feq_cont.11414
feq_else.11413:
	addi	r2, r0, 0
feq_cont.11414:
	beqi	0, r2, beq_then.11415
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11416
beq_then.11415:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11417
	addi	r2, r0, 1
	j	feq_cont.11418
feq_else.11417:
	addi	r2, r0, 0
feq_cont.11418:
	beqi	0, r2, beq_then.11419
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.11420
beq_then.11419:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11421
	addi	r2, r0, 0
	j	fle_cont.11422
fle_else.11421:
	addi	r2, r0, 1
fle_cont.11422:
	beqi	0, r2, beq_then.11423
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.11424
beq_then.11423:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.11424:
beq_cont.11420:
	fmul	f1, f1, f1
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.11416:
	fsw	f1, 2(r5)
beq_cont.11384:
	lw	r1, 4(r3)
	beqi	0, r1, beq_then.11425
	lw	r1, 5(r3)
	lw	r2, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	rotate_quadratic_matrix.2993				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.11426
beq_then.11425:
beq_cont.11426:
	addi	r1, r0, 1
	jr	r31				#
beq_then.11376:
	addi	r1, r0, 0
	jr	r31				#
read_object.2998:
	addi	r2, r0, 60
	ble	r2, r1, ble_then.11427
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.11428
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.11429
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.11430
	lw	r1, 1(r3)
	addi	r1, r1, 1
	j	read_object.2998
beq_then.11430:
	lw	r1, 1(r3)
	sw	r1, 0(r0)
	jr	r31				#
ble_then.11429:
	jr	r31				#
beq_then.11428:
	lw	r1, 0(r3)
	sw	r1, 0(r0)
	jr	r31				#
ble_then.11427:
	jr	r31				#
read_all_object.3000:
	addi	r1, r0, 0
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.11435
	addi	r1, r0, 1
	j	read_object.2998
beq_then.11435:
	lw	r1, 0(r3)
	sw	r1, 0(r0)
	jr	r31				#
read_net_item.3002:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.11437
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.11438
	lw	r2, 2(r3)
	addi	r5, r2, 1
	sw	r1, 3(r3)
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3002				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.11439
beq_then.11438:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.11439:
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.11437:
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
	beqi	-1, r1, beq_then.11440
	addi	r2, r0, 1
	sw	r1, 1(r3)
	add	r1, r0, r2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_net_item.3002				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.11441
beq_then.11440:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
beq_cont.11441:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.11442
	lw	r1, 0(r3)
	addi	r5, r1, 1
	addi	r6, r0, 0
	sw	r2, 2(r3)
	sw	r5, 3(r3)
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3002				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.11443
	lw	r1, 3(r3)
	addi	r5, r1, 1
	sw	r2, 4(r3)
	add	r1, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	read_or_network.3004				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.11444
beq_then.11443:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.11444:
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.11442:
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
	beqi	-1, r1, beq_then.11445
	addi	r2, r0, 1
	sw	r1, 1(r3)
	add	r1, r0, r2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_net_item.3002				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	j	beq_cont.11446
beq_then.11445:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				
	addi	r3, r3, -3
	lw	r31, 2(r3)
beq_cont.11446:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.11447
	addi	r2, r0, 672				# set min_caml_and_net
	lw	r5, 0(r3)
	add	r30, r2, r5
	sw	r1, 0(r30)
	addi	r1, r5, 1
	addi	r2, r0, 0
	sw	r1, 2(r3)
	add	r1, r0, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_net_item.3002				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.11448
	addi	r2, r0, 672				# set min_caml_and_net
	lw	r5, 2(r3)
	add	r30, r2, r5
	sw	r1, 0(r30)
	addi	r1, r5, 1
	j	read_and_network.3006
beq_then.11448:
	jr	r31				#
beq_then.11447:
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
	beqi	-1, r2, beq_then.11451
	sw	r1, 672(r0)
	addi	r1, r0, 1
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_and_network.3006				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	beq_cont.11452
beq_then.11451:
beq_cont.11452:
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_net_item.3002				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	add	r2, r0, r1
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.11453
	addi	r1, r0, 1
	sw	r2, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_or_network.3004				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	sw	r2, 0(r1)
	j	beq_cont.11454
beq_then.11453:
	addi	r1, r0, 1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_create_array				
	addi	r3, r3, -2
	lw	r31, 1(r3)
beq_cont.11454:
	sw	r1, 723(r0)
	jr	r31				#
solver_rect_surface.3010:
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.11456
	addi	r8, r0, 1
	j	feq_cont.11457
feq_else.11456:
	addi	r8, r0, 0
feq_cont.11457:
	beqi	0, r8, beq_then.11458
	addi	r1, r0, 0
	jr	r31				#
beq_then.11458:
	lw	r8, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.11459
	addi	r9, r0, 0
	j	fle_cont.11460
fle_else.11459:
	addi	r9, r0, 1
fle_cont.11460:
	beqi	0, r1, beq_then.11461
	beqi	0, r9, beq_then.11463
	addi	r1, r0, 0
	j	beq_cont.11464
beq_then.11463:
	addi	r1, r0, 1
beq_cont.11464:
	j	beq_cont.11462
beq_then.11461:
	add	r1, r0, r9
beq_cont.11462:
	add	r30, r8, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.11465
	j	beq_cont.11466
beq_then.11465:
	fneg	f4, f4
beq_cont.11466:
	fsub	f1, f4, f1
	add	r30, r2, r5
	flw	f4, 0(r30)
	finv	f31, f4
	fmul	f1, f1, f31
	add	r30, r8, r6
	flw	f4, 0(r30)
	add	r30, r2, r6
	flw	f5, 0(r30)
	fmul	f5, f1, f5
	fadd	f2, f5, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.11467
	j	fle_cont.11468
fle_else.11467:
	fneg	f2, f2
fle_cont.11468:
	fle	r30, f4, f2
	beq	r0, r30, fle_else.11469
	addi	r1, r0, 0
	jr	r31				#
fle_else.11469:
	add	r30, r8, r7
	flw	f2, 0(r30)
	add	r30, r2, r7
	flw	f4, 0(r30)
	fmul	f4, f1, f4
	fadd	f3, f4, f3
	fle	r30, f0, f3
	beq	r0, r30, fle_else.11470
	j	fle_cont.11471
fle_else.11470:
	fneg	f3, f3
fle_cont.11471:
	fle	r30, f2, f3
	beq	r0, r30, fle_else.11472
	addi	r1, r0, 0
	jr	r31				#
fle_else.11472:
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
	beqi	0, r1, beq_then.11473
	addi	r1, r0, 1
	jr	r31				#
beq_then.11473:
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
	beqi	0, r1, beq_then.11474
	addi	r1, r0, 2
	jr	r31				#
beq_then.11474:
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
	beqi	0, r1, beq_then.11475
	addi	r1, r0, 3
	jr	r31				#
beq_then.11475:
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
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11476
	addi	r1, r0, 0
	j	fle_cont.11477
fle_else.11476:
	addi	r1, r0, 1
fle_cont.11477:
	beqi	0, r1, beq_then.11478
	lw	r1, 6(r3)
	flw	f2, 0(r1)
	flw	f3, 4(r3)
	fmul	f2, f2, f3
	flw	f3, 1(r1)
	flw	f4, 2(r3)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flw	f3, 2(r1)
	flw	f4, 0(r3)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	fneg	f2, f2
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.11478:
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
	beqi	0, r2, beq_then.11479
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
beq_then.11479:
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
	beqi	0, r2, beq_then.11480
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
beq_then.11480:
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
	beq	r0, r30, feq_else.11481
	addi	r1, r0, 1
	j	feq_cont.11482
feq_else.11481:
	addi	r1, r0, 0
feq_cont.11482:
	beqi	0, r1, beq_then.11483
	addi	r1, r0, 0
	jr	r31				#
beq_then.11483:
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
	beqi	3, r2, beq_then.11484
	j	beq_cont.11485
beq_then.11484:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.11485:
	flw	f2, 10(r3)
	fmul	f3, f2, f2
	flw	f4, 8(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11486
	addi	r2, r0, 0
	j	fle_cont.11487
fle_else.11486:
	addi	r2, r0, 1
fle_cont.11487:
	beqi	0, r2, beq_then.11488
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11489
	j	beq_cont.11490
beq_then.11489:
	fneg	f1, f1
beq_cont.11490:
	fsub	f1, f1, f2
	finv	f31, f4
	fmul	f1, f1, f31
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.11488:
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
	beqi	1, r5, beq_then.11491
	beqi	2, r5, beq_then.11492
	j	solver_second.3044
beq_then.11492:
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
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11493
	addi	r1, r0, 0
	j	fle_cont.11494
fle_else.11493:
	addi	r1, r0, 1
fle_cont.11494:
	beqi	0, r1, beq_then.11495
	lw	r1, 6(r3)
	flw	f2, 0(r1)
	flw	f3, 4(r3)
	fmul	f2, f2, f3
	flw	f3, 1(r1)
	flw	f4, 2(r3)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flw	f3, 2(r1)
	flw	f4, 0(r3)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	fneg	f2, f2
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.11495:
	addi	r1, r0, 0
	jr	r31				#
beq_then.11491:
	j	solver_rect.3019
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
	beq	r0, r30, fle_else.11496
	j	fle_cont.11497
fle_else.11496:
	fneg	f6, f6
fle_cont.11497:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.11498
	addi	r6, r0, 0
	j	fle_cont.11499
fle_else.11498:
	lw	r6, 4(r1)
	flw	f5, 2(r6)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.11500
	j	fle_cont.11501
fle_else.11500:
	fneg	f6, f6
fle_cont.11501:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.11502
	addi	r6, r0, 0
	j	fle_cont.11503
fle_else.11502:
	flw	f5, 1(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.11504
	addi	r6, r0, 1
	j	feq_cont.11505
feq_else.11504:
	addi	r6, r0, 0
feq_cont.11505:
	beqi	0, r6, beq_then.11506
	addi	r6, r0, 0
	j	beq_cont.11507
beq_then.11506:
	addi	r6, r0, 1
beq_cont.11507:
fle_cont.11503:
fle_cont.11499:
	beqi	0, r6, beq_then.11508
	fsw	f4, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.11508:
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
	beq	r0, r30, fle_else.11509
	j	fle_cont.11510
fle_else.11509:
	fneg	f6, f6
fle_cont.11510:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.11511
	addi	r6, r0, 0
	j	fle_cont.11512
fle_else.11511:
	lw	r6, 4(r1)
	flw	f5, 2(r6)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.11513
	j	fle_cont.11514
fle_else.11513:
	fneg	f6, f6
fle_cont.11514:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.11515
	addi	r6, r0, 0
	j	fle_cont.11516
fle_else.11515:
	flw	f5, 3(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.11517
	addi	r6, r0, 1
	j	feq_cont.11518
feq_else.11517:
	addi	r6, r0, 0
feq_cont.11518:
	beqi	0, r6, beq_then.11519
	addi	r6, r0, 0
	j	beq_cont.11520
beq_then.11519:
	addi	r6, r0, 1
beq_cont.11520:
fle_cont.11516:
fle_cont.11512:
	beqi	0, r6, beq_then.11521
	fsw	f4, 724(r0)
	addi	r1, r0, 2
	jr	r31				#
beq_then.11521:
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
	beq	r0, r30, fle_else.11522
	j	fle_cont.11523
fle_else.11522:
	fneg	f1, f1
fle_cont.11523:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11524
	addi	r1, r0, 0
	j	fle_cont.11525
fle_else.11524:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	flw	f4, 1(r2)
	fmul	f4, f3, f4
	fadd	f2, f4, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.11526
	j	fle_cont.11527
fle_else.11526:
	fneg	f2, f2
fle_cont.11527:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11528
	addi	r1, r0, 0
	j	fle_cont.11529
fle_else.11528:
	flw	f1, 5(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11530
	addi	r1, r0, 1
	j	feq_cont.11531
feq_else.11530:
	addi	r1, r0, 0
feq_cont.11531:
	beqi	0, r1, beq_then.11532
	addi	r1, r0, 0
	j	beq_cont.11533
beq_then.11532:
	addi	r1, r0, 1
beq_cont.11533:
fle_cont.11529:
fle_cont.11525:
	beqi	0, r1, beq_then.11534
	fsw	f3, 724(r0)
	addi	r1, r0, 3
	jr	r31				#
beq_then.11534:
	addi	r1, r0, 0
	jr	r31				#
solver_surface_fast.3061:
	flw	f4, 0(r2)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.11535
	addi	r1, r0, 0
	j	fle_cont.11536
fle_else.11535:
	addi	r1, r0, 1
fle_cont.11536:
	beqi	0, r1, beq_then.11537
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
beq_then.11537:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3067:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.11538
	addi	r5, r0, 1
	j	feq_cont.11539
feq_else.11538:
	addi	r5, r0, 0
feq_cont.11539:
	beqi	0, r5, beq_then.11540
	addi	r1, r0, 0
	jr	r31				#
beq_then.11540:
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
	beqi	3, r2, beq_then.11542
	j	beq_cont.11543
beq_then.11542:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.11543:
	flw	f2, 4(r3)
	fmul	f3, f2, f2
	flw	f4, 2(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11544
	addi	r2, r0, 0
	j	fle_cont.11545
fle_else.11544:
	addi	r2, r0, 1
fle_cont.11545:
	beqi	0, r2, beq_then.11546
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11547
	fsqrt	f1, f1
	fadd	f1, f2, f1
	lw	r1, 0(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	j	beq_cont.11548
beq_then.11547:
	fsqrt	f1, f1
	fsub	f1, f2, f1
	lw	r1, 0(r3)
	flw	f2, 4(r1)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
beq_cont.11548:
	addi	r1, r0, 1
	jr	r31				#
beq_then.11546:
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
	beqi	1, r1, beq_then.11549
	beqi	2, r1, beq_then.11550
	add	r2, r0, r5
	add	r1, r0, r6
	j	solver_second_fast.3067
beq_then.11550:
	add	r2, r0, r5
	add	r1, r0, r6
	j	solver_surface_fast.3061
beq_then.11549:
	lw	r2, 0(r2)
	add	r1, r0, r6
	j	solver_rect_fast.3054
solver_surface_fast2.3077:
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11551
	addi	r1, r0, 0
	j	fle_cont.11552
fle_else.11551:
	addi	r1, r0, 1
fle_cont.11552:
	beqi	0, r1, beq_then.11553
	flw	f1, 0(r2)
	flw	f2, 3(r5)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.11553:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3084:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.11554
	addi	r6, r0, 1
	j	feq_cont.11555
feq_else.11554:
	addi	r6, r0, 0
feq_cont.11555:
	beqi	0, r6, beq_then.11556
	addi	r1, r0, 0
	jr	r31				#
beq_then.11556:
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
	beq	r0, r30, fle_else.11557
	addi	r5, r0, 0
	j	fle_cont.11558
fle_else.11557:
	addi	r5, r0, 1
fle_cont.11558:
	beqi	0, r5, beq_then.11559
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11560
	fsqrt	f2, f2
	fadd	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	j	beq_cont.11561
beq_then.11560:
	fsqrt	f2, f2
	fsub	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
beq_cont.11561:
	addi	r1, r0, 1
	jr	r31				#
beq_then.11559:
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
	beqi	1, r7, beq_then.11562
	beqi	2, r7, beq_then.11563
	add	r2, r0, r1
	add	r1, r0, r5
	add	r5, r0, r6
	j	solver_second_fast2.3084
beq_then.11563:
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11564
	addi	r2, r0, 0
	j	fle_cont.11565
fle_else.11564:
	addi	r2, r0, 1
fle_cont.11565:
	beqi	0, r2, beq_then.11566
	flw	f1, 0(r1)
	flw	f2, 3(r6)
	fmul	f1, f1, f2
	fsw	f1, 724(r0)
	addi	r1, r0, 1
	jr	r31				#
beq_then.11566:
	addi	r1, r0, 0
	jr	r31				#
beq_then.11562:
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
	beq	r0, r30, feq_else.11567
	addi	r5, r0, 1
	j	feq_cont.11568
feq_else.11567:
	addi	r5, r0, 0
feq_cont.11568:
	beqi	0, r5, beq_then.11569
	fsw	f0, 1(r1)
	j	beq_cont.11570
beq_then.11569:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11571
	addi	r7, r0, 0
	j	fle_cont.11572
fle_else.11571:
	addi	r7, r0, 1
fle_cont.11572:
	beqi	0, r6, beq_then.11573
	beqi	0, r7, beq_then.11575
	addi	r6, r0, 0
	j	beq_cont.11576
beq_then.11575:
	addi	r6, r0, 1
beq_cont.11576:
	j	beq_cont.11574
beq_then.11573:
	add	r6, r0, r7
beq_cont.11574:
	lw	r7, 4(r5)
	flw	f1, 0(r7)
	beqi	0, r6, beq_then.11577
	j	beq_cont.11578
beq_then.11577:
	fneg	f1, f1
beq_cont.11578:
	fsw	f1, 0(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r2)
	finv	f31, f2
	fmul	f1, f1, f31
	fsw	f1, 1(r1)
beq_cont.11570:
	flw	f1, 1(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11579
	addi	r5, r0, 1
	j	feq_cont.11580
feq_else.11579:
	addi	r5, r0, 0
feq_cont.11580:
	beqi	0, r5, beq_then.11581
	fsw	f0, 3(r1)
	j	beq_cont.11582
beq_then.11581:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 1(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11583
	addi	r7, r0, 0
	j	fle_cont.11584
fle_else.11583:
	addi	r7, r0, 1
fle_cont.11584:
	beqi	0, r6, beq_then.11585
	beqi	0, r7, beq_then.11587
	addi	r6, r0, 0
	j	beq_cont.11588
beq_then.11587:
	addi	r6, r0, 1
beq_cont.11588:
	j	beq_cont.11586
beq_then.11585:
	add	r6, r0, r7
beq_cont.11586:
	lw	r7, 4(r5)
	flw	f1, 1(r7)
	beqi	0, r6, beq_then.11589
	j	beq_cont.11590
beq_then.11589:
	fneg	f1, f1
beq_cont.11590:
	fsw	f1, 2(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 1(r2)
	finv	f31, f2
	fmul	f1, f1, f31
	fsw	f1, 3(r1)
beq_cont.11582:
	flw	f1, 2(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11591
	addi	r5, r0, 1
	j	feq_cont.11592
feq_else.11591:
	addi	r5, r0, 0
feq_cont.11592:
	beqi	0, r5, beq_then.11593
	fsw	f0, 5(r1)
	j	beq_cont.11594
beq_then.11593:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 2(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11595
	addi	r7, r0, 0
	j	fle_cont.11596
fle_else.11595:
	addi	r7, r0, 1
fle_cont.11596:
	beqi	0, r6, beq_then.11597
	beqi	0, r7, beq_then.11599
	addi	r6, r0, 0
	j	beq_cont.11600
beq_then.11599:
	addi	r6, r0, 1
beq_cont.11600:
	j	beq_cont.11598
beq_then.11597:
	add	r6, r0, r7
beq_cont.11598:
	lw	r5, 4(r5)
	flw	f1, 2(r5)
	beqi	0, r6, beq_then.11601
	j	beq_cont.11602
beq_then.11601:
	fneg	f1, f1
beq_cont.11602:
	fsw	f1, 4(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 2(r2)
	finv	f31, f2
	fmul	f1, f1, f31
	fsw	f1, 5(r1)
beq_cont.11594:
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
	beq	r0, r30, fle_else.11603
	addi	r2, r0, 0
	j	fle_cont.11604
fle_else.11603:
	addi	r2, r0, 1
fle_cont.11604:
	beqi	0, r2, beq_then.11605
	flup	f2, 11		# fli	f2, -1.000000
	finv	f31, f1
	fmul	f2, f2, f31
	fsw	f2, 0(r1)
	lw	r2, 4(r5)
	flw	f2, 0(r2)
	finv	f31, f1
	fmul	f2, f2, f31
	fneg	f2, f2
	fsw	f2, 1(r1)
	lw	r2, 4(r5)
	flw	f2, 1(r2)
	finv	f31, f1
	fmul	f2, f2, f31
	fneg	f2, f2
	fsw	f2, 2(r1)
	lw	r2, 4(r5)
	flw	f2, 2(r2)
	finv	f31, f1
	fmul	f1, f2, f31
	fneg	f1, f1
	fsw	f1, 3(r1)
	j	beq_cont.11606
beq_then.11605:
	fsw	f0, 0(r1)
beq_cont.11606:
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
	beqi	0, r6, beq_then.11607
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
	j	beq_cont.11608
beq_then.11607:
	fsw	f2, 1(r5)
	fsw	f3, 2(r5)
	fsw	f4, 3(r5)
beq_cont.11608:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.11609
	addi	r1, r0, 1
	j	feq_cont.11610
feq_else.11609:
	addi	r1, r0, 0
feq_cont.11610:
	beqi	0, r1, beq_then.11611
	j	beq_cont.11612
beq_then.11611:
	flup	f2, 2		# fli	f2, 1.000000
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 4(r5)
beq_cont.11612:
	add	r1, r0, r5
	jr	r31				#
iter_setup_dirvec_constants.3103:
	bgei	0, r2, bge_then.11613
	jr	r31				#
bge_then.11613:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 1(r1)
	lw	r7, 0(r1)
	lw	r8, 1(r5)
	sw	r1, 0(r3)
	beqi	1, r8, beq_then.11615
	beqi	2, r8, beq_then.11617
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
	j	beq_cont.11618
beq_then.11617:
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
beq_cont.11618:
	j	beq_cont.11616
beq_then.11615:
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
beq_cont.11616:
	addi	r2, r2, -1
	lw	r1, 0(r3)
	j	iter_setup_dirvec_constants.3103
setup_dirvec_constants.3106:
	lw	r2, 0(r0)
	addi	r2, r2, -1
	j	iter_setup_dirvec_constants.3103
setup_startp_constants.3108:
	bgei	0, r2, bge_then.11619
	jr	r31				#
bge_then.11619:
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
	beqi	2, r7, beq_then.11621
	blei	2, r7, ble_then.11623
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
	beqi	3, r1, beq_then.11625
	j	beq_cont.11626
beq_then.11625:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.11626:
	lw	r1, 2(r3)
	fsw	f1, 3(r1)
	j	ble_cont.11624
ble_then.11623:
ble_cont.11624:
	j	beq_cont.11622
beq_then.11621:
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
beq_cont.11622:
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
	beq	r0, r30, fle_else.11627
	j	fle_cont.11628
fle_else.11627:
	fneg	f1, f1
fle_cont.11628:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.11629
	addi	r2, r0, 0
	j	fle_cont.11630
fle_else.11629:
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.11631
	j	fle_cont.11632
fle_else.11631:
	fneg	f2, f2
fle_cont.11632:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11633
	addi	r2, r0, 0
	j	fle_cont.11634
fle_else.11633:
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.11635
	fadd	f2, f0, f3
	j	fle_cont.11636
fle_else.11635:
	fneg	f2, f3
fle_cont.11636:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11637
	addi	r2, r0, 0
	j	fle_cont.11638
fle_else.11637:
	addi	r2, r0, 1
fle_cont.11638:
fle_cont.11634:
fle_cont.11630:
	beqi	0, r2, beq_then.11639
	lw	r1, 6(r1)
	jr	r31				#
beq_then.11639:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11640
	addi	r1, r0, 0
	jr	r31				#
beq_then.11640:
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
	beq	r0, r30, fle_else.11641
	addi	r2, r0, 0
	j	fle_cont.11642
fle_else.11641:
	addi	r2, r0, 1
fle_cont.11642:
	beqi	0, r1, beq_then.11643
	beqi	0, r2, beq_then.11645
	addi	r1, r0, 0
	j	beq_cont.11646
beq_then.11645:
	addi	r1, r0, 1
beq_cont.11646:
	j	beq_cont.11644
beq_then.11643:
	add	r1, r0, r2
beq_cont.11644:
	beqi	0, r1, beq_then.11647
	addi	r1, r0, 0
	jr	r31				#
beq_then.11647:
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
	beqi	3, r2, beq_then.11648
	j	beq_cont.11649
beq_then.11648:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.11649:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11650
	addi	r2, r0, 0
	j	fle_cont.11651
fle_else.11650:
	addi	r2, r0, 1
fle_cont.11651:
	beqi	0, r1, beq_then.11652
	beqi	0, r2, beq_then.11654
	addi	r1, r0, 0
	j	beq_cont.11655
beq_then.11654:
	addi	r1, r0, 1
beq_cont.11655:
	j	beq_cont.11653
beq_then.11652:
	add	r1, r0, r2
beq_cont.11653:
	beqi	0, r1, beq_then.11656
	addi	r1, r0, 0
	jr	r31				#
beq_then.11656:
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
	beqi	1, r2, beq_then.11657
	beqi	2, r2, beq_then.11658
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3031				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.11659
	j	beq_cont.11660
beq_then.11659:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.11660:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11661
	addi	r2, r0, 0
	j	fle_cont.11662
fle_else.11661:
	addi	r2, r0, 1
fle_cont.11662:
	beqi	0, r1, beq_then.11663
	beqi	0, r2, beq_then.11665
	addi	r1, r0, 0
	j	beq_cont.11666
beq_then.11665:
	addi	r1, r0, 1
beq_cont.11666:
	j	beq_cont.11664
beq_then.11663:
	add	r1, r0, r2
beq_cont.11664:
	beqi	0, r1, beq_then.11667
	addi	r1, r0, 0
	jr	r31				#
beq_then.11667:
	addi	r1, r0, 1
	jr	r31				#
beq_then.11658:
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
	beq	r0, r30, fle_else.11668
	addi	r2, r0, 0
	j	fle_cont.11669
fle_else.11668:
	addi	r2, r0, 1
fle_cont.11669:
	beqi	0, r1, beq_then.11670
	beqi	0, r2, beq_then.11672
	addi	r1, r0, 0
	j	beq_cont.11673
beq_then.11672:
	addi	r1, r0, 1
beq_cont.11673:
	j	beq_cont.11671
beq_then.11670:
	add	r1, r0, r2
beq_cont.11671:
	beqi	0, r1, beq_then.11674
	addi	r1, r0, 0
	jr	r31				#
beq_then.11674:
	addi	r1, r0, 1
	jr	r31				#
beq_then.11657:
	j	is_rect_outside.3113
check_all_inside.3133:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.11675
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
	beqi	1, r6, beq_then.11676
	beqi	2, r6, beq_then.11678
	add	r1, r0, r5
	fadd	f3, f0, f6
	fadd	f2, f0, f5
	fadd	f1, f0, f4
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	is_second_outside.3123				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.11679
beq_then.11678:
	add	r1, r0, r5
	fadd	f3, f0, f6
	fadd	f2, f0, f5
	fadd	f1, f0, f4
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	is_plane_outside.3118				
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.11679:
	j	beq_cont.11677
beq_then.11676:
	add	r1, r0, r5
	fadd	f3, f0, f6
	fadd	f2, f0, f5
	fadd	f1, f0, f4
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	is_rect_outside.3113				
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.11677:
	beqi	0, r1, beq_then.11680
	addi	r1, r0, 0
	jr	r31				#
beq_then.11680:
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 6(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.11681
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r5, 0(r30)
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	sw	r1, 8(r3)
	add	r1, r0, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	is_outside.3128				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	beqi	0, r1, beq_then.11682
	addi	r1, r0, 0
	jr	r31				#
beq_then.11682:
	lw	r1, 8(r3)
	addi	r1, r1, 1
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r2, 6(r3)
	j	check_all_inside.3133
beq_then.11681:
	addi	r1, r0, 1
	jr	r31				#
beq_then.11675:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3139:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.11683
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 1021				# set min_caml_light_dirvec
	addi	r7, r0, 727				# set min_caml_intersection_point
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	add	r5, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_fast.3073				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	flw	f1, 724(r0)
	beqi	0, r1, beq_then.11684
	flup	f2, 28		# fli	f2, -0.200000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11686
	addi	r1, r0, 0
	j	fle_cont.11687
fle_else.11686:
	addi	r1, r0, 1
fle_cont.11687:
	j	beq_cont.11685
beq_then.11684:
	addi	r1, r0, 0
beq_cont.11685:
	beqi	0, r1, beq_then.11688
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
	beqi	-1, r1, beq_then.11689
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
	beqi	0, r1, beq_then.11692
	addi	r1, r0, 0
	j	beq_cont.11693
beq_then.11692:
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
beq_cont.11693:
	j	beq_cont.11690
beq_then.11689:
	addi	r1, r0, 1
beq_cont.11690:
	beqi	0, r1, beq_then.11694
	addi	r1, r0, 1
	jr	r31				#
beq_then.11694:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_and_group.3139
beq_then.11688:
	addi	r1, r0, 1				# set min_caml_objects
	lw	r2, 2(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11695
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_and_group.3139
beq_then.11695:
	addi	r1, r0, 0
	jr	r31				#
beq_then.11683:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3142:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.11696
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
	beqi	0, r1, beq_then.11697
	addi	r1, r0, 1
	jr	r31				#
beq_then.11697:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.11698
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
	beqi	0, r1, beq_then.11699
	addi	r1, r0, 1
	jr	r31				#
beq_then.11699:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_one_or_group.3142
beq_then.11698:
	addi	r1, r0, 0
	jr	r31				#
beq_then.11696:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3145:
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.11700
	addi	r7, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r6, r7, beq_then.11701
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
	beqi	0, r1, beq_then.11703
	flup	f1, 30		# fli	f1, -0.100000
	flw	f2, 724(r0)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11705
	addi	r1, r0, 0
	j	fle_cont.11706
fle_else.11705:
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.11707
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
	beqi	0, r1, beq_then.11709
	addi	r1, r0, 1
	j	beq_cont.11710
beq_then.11709:
	addi	r1, r0, 2
	lw	r2, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_one_or_group.3142				
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.11710:
	j	beq_cont.11708
beq_then.11707:
	addi	r1, r0, 0
beq_cont.11708:
	beqi	0, r1, beq_then.11711
	addi	r1, r0, 1
	j	beq_cont.11712
beq_then.11711:
	addi	r1, r0, 0
beq_cont.11712:
fle_cont.11706:
	j	beq_cont.11704
beq_then.11703:
	addi	r1, r0, 0
beq_cont.11704:
	j	beq_cont.11702
beq_then.11701:
	addi	r1, r0, 1
beq_cont.11702:
	beqi	0, r1, beq_then.11713
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.11714
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
	beqi	0, r1, beq_then.11716
	addi	r1, r0, 1
	j	beq_cont.11717
beq_then.11716:
	addi	r1, r0, 2
	lw	r2, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_one_or_group.3142				
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.11717:
	j	beq_cont.11715
beq_then.11714:
	addi	r1, r0, 0
beq_cont.11715:
	beqi	0, r1, beq_then.11718
	addi	r1, r0, 1
	jr	r31				#
beq_then.11718:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	j	shadow_check_one_or_matrix.3145
beq_then.11713:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	j	shadow_check_one_or_matrix.3145
beq_then.11700:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3148:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.11719
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
	beqi	0, r1, beq_then.11720
	flw	f1, 724(r0)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11721
	j	fle_cont.11722
fle_else.11721:
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11723
	j	fle_cont.11724
fle_else.11723:
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
	sw	r1, 4(r3)
	fsw	f4, 6(r3)
	fsw	f3, 8(r3)
	fsw	f2, 10(r3)
	fsw	f1, 12(r3)
	beqi	-1, r6, beq_then.11726
	addi	r7, r0, 1				# set min_caml_objects
	add	r30, r7, r6
	lw	r6, 0(r30)
	add	r1, r0, r6
	fadd	f1, f0, f2
	fadd	f2, f0, f3
	fadd	f3, f0, f4
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	is_outside.3128				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.11728
	addi	r1, r0, 0
	j	beq_cont.11729
beq_then.11728:
	addi	r1, r0, 1
	flw	f1, 10(r3)
	flw	f2, 8(r3)
	flw	f3, 6(r3)
	lw	r2, 1(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	check_all_inside.3133				
	addi	r3, r3, -15
	lw	r31, 14(r3)
beq_cont.11729:
	j	beq_cont.11727
beq_then.11726:
	addi	r1, r0, 1
beq_cont.11727:
	beqi	0, r1, beq_then.11730
	flw	f1, 12(r3)
	fsw	f1, 726(r0)
	flw	f1, 10(r3)
	fsw	f1, 727(r0)
	flw	f1, 8(r3)
	fsw	f1, 728(r0)
	flw	f1, 6(r3)
	fsw	f1, 729(r0)
	lw	r1, 3(r3)
	sw	r1, 730(r0)
	lw	r1, 4(r3)
	sw	r1, 725(r0)
	j	beq_cont.11731
beq_then.11730:
beq_cont.11731:
fle_cont.11724:
fle_cont.11722:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3148
beq_then.11720:
	addi	r1, r0, 1				# set min_caml_objects
	lw	r2, 3(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11732
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3148
beq_then.11732:
	jr	r31				#
beq_then.11719:
	jr	r31				#
solve_one_or_network.3152:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.11735
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
	beqi	-1, r5, beq_then.11736
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
	lw	r5, 0(r3)
	j	solve_one_or_network.3152
beq_then.11736:
	jr	r31				#
beq_then.11735:
	jr	r31				#
trace_or_matrix.3156:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.11739
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.11740
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
	beqi	0, r1, beq_then.11742
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11744
	j	fle_cont.11745
fle_else.11744:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.11746
	addi	r5, r0, 672				# set min_caml_and_net
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5
	add	r5, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element.3148				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 2
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network.3152				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11747
beq_then.11746:
beq_cont.11747:
fle_cont.11745:
	j	beq_cont.11743
beq_then.11742:
beq_cont.11743:
	j	beq_cont.11741
beq_then.11740:
	lw	r7, 1(r6)
	beqi	-1, r7, beq_then.11748
	addi	r8, r0, 672				# set min_caml_and_net
	add	r30, r8, r7
	lw	r7, 0(r30)
	addi	r8, r0, 0
	sw	r6, 3(r3)
	add	r2, r0, r7
	add	r1, r0, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element.3148				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 2
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network.3152				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11749
beq_then.11748:
beq_cont.11749:
beq_cont.11741:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix.3156
beq_then.11739:
	jr	r31				#
judge_intersection.3160:
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 726(r0)
	addi	r2, r0, 0
	lw	r5, 723(r0)
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r28
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	trace_or_matrix.3156				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	flw	f1, 726(r0)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11751
	addi	r1, r0, 0
	jr	r31				#
fle_else.11751:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11752
	addi	r1, r0, 0
	jr	r31				#
fle_else.11752:
	addi	r1, r0, 1
	jr	r31				#
solve_each_element_fast.3162:
	lw	r6, 0(r5)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.11753
	sw	r6, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_fast2.3091				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.11754
	flw	f1, 724(r0)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11755
	j	fle_cont.11756
fle_else.11755:
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11757
	j	fle_cont.11758
fle_else.11757:
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
	beqi	-1, r5, beq_then.11759
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
	beqi	0, r1, beq_then.11761
	addi	r1, r0, 0
	j	beq_cont.11762
beq_then.11761:
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
beq_cont.11762:
	j	beq_cont.11760
beq_then.11759:
	addi	r1, r0, 1
beq_cont.11760:
	beqi	0, r1, beq_then.11763
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
	j	beq_cont.11764
beq_then.11763:
beq_cont.11764:
fle_cont.11758:
fle_cont.11756:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	j	solve_each_element_fast.3162
beq_then.11754:
	addi	r1, r0, 1				# set min_caml_objects
	lw	r2, 4(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.11765
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	j	solve_each_element_fast.3162
beq_then.11765:
	jr	r31				#
beq_then.11753:
	jr	r31				#
solve_one_or_network_fast.3166:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.11768
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
	beqi	-1, r5, beq_then.11769
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
	lw	r5, 0(r3)
	j	solve_one_or_network_fast.3166
beq_then.11769:
	jr	r31				#
beq_then.11768:
	jr	r31				#
trace_or_matrix_fast.3170:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.11772
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.11773
	sw	r6, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_fast2.3091				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.11775
	flw	f1, 724(r0)
	flw	f2, 726(r0)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11777
	j	fle_cont.11778
fle_else.11777:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.11779
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
	addi	r1, r0, 2
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11780
beq_then.11779:
beq_cont.11780:
fle_cont.11778:
	j	beq_cont.11776
beq_then.11775:
beq_cont.11776:
	j	beq_cont.11774
beq_then.11773:
	lw	r7, 1(r6)
	beqi	-1, r7, beq_then.11781
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
	addi	r1, r0, 2
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11782
beq_then.11781:
beq_cont.11782:
beq_cont.11774:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix_fast.3170
beq_then.11772:
	jr	r31				#
judge_intersection_fast.3174:
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 726(r0)
	addi	r2, r0, 0
	lw	r5, 723(r0)
	add	r28, r0, r5
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r28
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	trace_or_matrix_fast.3170				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	flw	f1, 726(r0)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.11784
	addi	r1, r0, 0
	jr	r31				#
fle_else.11784:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11785
	addi	r1, r0, 0
	jr	r31				#
fle_else.11785:
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
	beq	r0, r30, feq_else.11786
	addi	r1, r0, 1
	j	feq_cont.11787
feq_else.11786:
	addi	r1, r0, 0
feq_cont.11787:
	beqi	0, r1, beq_then.11788
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11789
beq_then.11788:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11790
	addi	r1, r0, 0
	j	fle_cont.11791
fle_else.11790:
	addi	r1, r0, 1
fle_cont.11791:
	beqi	0, r1, beq_then.11792
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.11793
beq_then.11792:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.11793:
beq_cont.11789:
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
	beqi	0, r2, beq_then.11796
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
	j	beq_cont.11797
beq_then.11796:
	fsw	f4, 731(r0)
	fsw	f5, 732(r0)
	fsw	f6, 733(r0)
beq_cont.11797:
	addi	r2, r0, 731				# set min_caml_nvector
	lw	r1, 6(r1)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	j	vecunit_sgn.2888
get_nvector.3182:
	lw	r5, 1(r1)
	beqi	1, r5, beq_then.11798
	beqi	2, r5, beq_then.11799
	j	get_nvector_second.3180
beq_then.11799:
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
beq_then.11798:
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
	beq	r0, r30, feq_else.11801
	addi	r1, r0, 1
	j	feq_cont.11802
feq_else.11801:
	addi	r1, r0, 0
feq_cont.11802:
	beqi	0, r1, beq_then.11803
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11804
beq_then.11803:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11805
	addi	r1, r0, 0
	j	fle_cont.11806
fle_else.11805:
	addi	r1, r0, 1
fle_cont.11806:
	beqi	0, r1, beq_then.11807
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.11808
beq_then.11807:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.11808:
beq_cont.11804:
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
	beqi	1, r5, beq_then.11810
	beqi	2, r5, beq_then.11811
	beqi	3, r5, beq_then.11812
	beqi	4, r5, beq_then.11813
	jr	r31				#
beq_then.11813:
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
	beq	r0, r30, fle_else.11815
	fadd	f5, f0, f1
	j	fle_cont.11816
fle_else.11815:
	fneg	f5, f1
fle_cont.11816:
	fsw	f3, 0(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	fle	r30, f4, f5
	beq	r0, r30, fle_else.11817
	finv	f31, f1
	fmul	f1, f2, f31
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11819
	j	fle_cont.11820
fle_else.11819:
	fneg	f1, f1
fle_cont.11820:
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan.2843				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	finv	f31, f2
	fmul	f1, f1, f31
	j	fle_cont.11818
fle_else.11817:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.11818:
	ftoi	r1, f1
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11821
	j	fle_cont.11822
fle_else.11821:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.11822:
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
	beq	r0, r30, fle_else.11823
	fadd	f5, f0, f4
	j	fle_cont.11824
fle_else.11823:
	fneg	f5, f4
fle_cont.11824:
	fsw	f1, 4(r3)
	fle	r30, f3, f5
	beq	r0, r30, fle_else.11825
	finv	f31, f4
	fmul	f2, f2, f31
	fle	r30, f0, f2
	beq	r0, r30, fle_else.11827
	j	fle_cont.11828
fle_else.11827:
	fneg	f2, f2
fle_cont.11828:
	fadd	f1, f0, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	atan.2843				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	finv	f31, f2
	fmul	f1, f1, f31
	j	fle_cont.11826
fle_else.11825:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.11826:
	ftoi	r1, f1
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11829
	j	fle_cont.11830
fle_else.11829:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.11830:
	fsub	f1, f1, f2
	flup	f2, 36		# fli	f2, 0.150000
	flup	f3, 1		# fli	f3, 0.500000
	flw	f4, 4(r3)
	fsub	f3, f3, f4
	fmul	f3, f3, f3
	fsub	f2, f2, f3
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f1, f3, f1
	fmul	f1, f1, f1
	fsub	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.11831
	addi	r1, r0, 0
	j	fle_cont.11832
fle_else.11831:
	addi	r1, r0, 1
fle_cont.11832:
	beqi	0, r1, beq_then.11833
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11834
beq_then.11833:
beq_cont.11834:
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f2, f1
	flup	f2, 38		# fli	f2, 0.300000
	finv	f31, f2
	fmul	f1, f1, f31
	fsw	f1, 736(r0)
	jr	r31				#
beq_then.11812:
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
	finv	f31, f2
	fmul	f1, f1, f31
	ftoi	r1, f1
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11836
	j	fle_cont.11837
fle_else.11836:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.11837:
	fsub	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fmul	f1, f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2839				
	addi	r3, r3, -7
	lw	r31, 6(r3)
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
beq_then.11811:
	flw	f1, 1(r2)
	flup	f2, 40		# fli	f2, 0.250000
	fmul	f1, f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin.2837				
	addi	r3, r3, -7
	lw	r31, 6(r3)
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
beq_then.11810:
	flw	f1, 0(r2)
	lw	r5, 5(r1)
	flw	f2, 0(r5)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	ftoi	r5, f2
	itof	f3, r5
	fle	r30, f3, f2
	beq	r0, r30, fle_else.11840
	fadd	f2, f0, f3
	j	fle_cont.11841
fle_else.11840:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.11841:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11842
	addi	r5, r0, 0
	j	fle_cont.11843
fle_else.11842:
	addi	r5, r0, 1
fle_cont.11843:
	flw	f1, 2(r2)
	lw	r1, 5(r1)
	flw	f2, 2(r1)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	ftoi	r1, f2
	itof	f3, r1
	fle	r30, f3, f2
	beq	r0, r30, fle_else.11844
	fadd	f2, f0, f3
	j	fle_cont.11845
fle_else.11844:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.11845:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.11846
	addi	r1, r0, 0
	j	fle_cont.11847
fle_else.11846:
	addi	r1, r0, 1
fle_cont.11847:
	beqi	0, r5, beq_then.11848
	beqi	0, r1, beq_then.11850
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.11851
beq_then.11850:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.11851:
	j	beq_cont.11849
beq_then.11848:
	beqi	0, r1, beq_then.11852
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.11853
beq_then.11852:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.11853:
beq_cont.11849:
	fsw	f1, 735(r0)
	jr	r31				#
add_light.3188:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11855
	addi	r1, r0, 0
	j	fle_cont.11856
fle_else.11855:
	addi	r1, r0, 1
fle_cont.11856:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	beqi	0, r1, beq_then.11857
	addi	r1, r0, 740				# set min_caml_rgb
	addi	r2, r0, 734				# set min_caml_texture_color
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	vecaccum.2899				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11858
beq_then.11857:
beq_cont.11858:
	flw	f1, 2(r3)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11859
	addi	r1, r0, 0
	j	fle_cont.11860
fle_else.11859:
	addi	r1, r0, 1
fle_cont.11860:
	beqi	0, r1, beq_then.11861
	fmul	f1, f1, f1
	fmul	f1, f1, f1
	flw	f2, 0(r3)
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
beq_then.11861:
	jr	r31				#
trace_reflections.3192:
	bgei	0, r1, bge_then.11864
	jr	r31				#
bge_then.11864:
	addi	r5, r0, 778				# set min_caml_reflections
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r6, 1(r5)
	sw	r1, 0(r3)
	fsw	f2, 2(r3)
	sw	r2, 4(r3)
	fsw	f1, 6(r3)
	sw	r6, 8(r3)
	sw	r5, 9(r3)
	add	r1, r0, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	judge_intersection_fast.3174				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.11868
	lw	r1, 730(r0)
	slli	r1, r1, 2
	lw	r2, 725(r0)
	add	r1, r1, r2
	lw	r2, 9(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.11870
	j	beq_cont.11871
beq_then.11870:
	addi	r1, r0, 0
	lw	r5, 723(r0)
	add	r2, r0, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	shadow_check_one_or_matrix.3145				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.11872
	j	beq_cont.11873
beq_then.11872:
	addi	r1, r0, 731				# set min_caml_nvector
	lw	r2, 8(r3)
	lw	r5, 0(r2)
	add	r2, r0, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	veciprod.2891				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 9(r3)
	flw	f2, 2(r1)
	flw	f3, 6(r3)
	fmul	f4, f2, f3
	fmul	f1, f4, f1
	lw	r1, 8(r3)
	lw	r2, 0(r1)
	lw	r1, 4(r3)
	fsw	f1, 10(r3)
	fsw	f2, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	veciprod.2891				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fmul	f2, f2, f1
	flw	f1, 10(r3)
	flw	f3, 2(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	add_light.3188				
	addi	r3, r3, -15
	lw	r31, 14(r3)
beq_cont.11873:
beq_cont.11871:
	j	beq_cont.11869
beq_then.11868:
beq_cont.11869:
	lw	r1, 0(r3)
	addi	r1, r1, -1
	flw	f1, 6(r3)
	flw	f2, 2(r3)
	lw	r2, 4(r3)
	j	trace_reflections.3192
trace_ray.3197:
	blei	4, r1, ble_then.11874
	jr	r31				#
ble_then.11874:
	lw	r6, 2(r5)
	fsw	f2, 0(r3)
	sw	r5, 2(r3)
	fsw	f1, 4(r3)
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	sw	r6, 8(r3)
	add	r1, r0, r2
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	judge_intersection.3160				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	beqi	0, r1, beq_then.11877
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
	beqi	1, r6, beq_then.11878
	beqi	2, r6, beq_then.11880
	add	r1, r0, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	get_nvector_second.3180				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	j	beq_cont.11881
beq_then.11880:
	add	r1, r0, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	get_nvector_plane.3178				
	addi	r3, r3, -15
	lw	r31, 14(r3)
beq_cont.11881:
	j	beq_cont.11879
beq_then.11878:
	lw	r6, 6(r3)
	add	r1, r0, r6
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	get_nvector_rect.3176				
	addi	r3, r3, -15
	lw	r31, 14(r3)
beq_cont.11879:
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
	beq	r0, r30, fle_else.11882
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
	j	fle_cont.11883
fle_else.11882:
	addi	r8, r0, 0
	add	r30, r6, r2
	sw	r8, 0(r30)
fle_cont.11883:
	flup	f1, 44		# fli	f1, -2.000000
	addi	r6, r0, 731				# set min_caml_nvector
	lw	r8, 6(r3)
	fsw	f1, 14(r3)
	add	r2, r0, r6
	add	r1, r0, r8
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	veciprod.2891				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fmul	f1, f2, f1
	addi	r2, r0, 731				# set min_caml_nvector
	lw	r1, 6(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	vecaccum.2899				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r1, 13(r3)
	lw	r2, 7(r1)
	flw	f1, 1(r2)
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	addi	r2, r0, 0
	lw	r5, 723(r0)
	fsw	f1, 16(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	shadow_check_one_or_matrix.3145				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	beqi	0, r1, beq_then.11884
	j	beq_cont.11885
beq_then.11884:
	addi	r1, r0, 731				# set min_caml_nvector
	addi	r2, r0, 667				# set min_caml_light
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	veciprod.2891				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	fneg	f1, f1
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	addi	r2, r0, 667				# set min_caml_light
	lw	r1, 6(r3)
	fsw	f1, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	veciprod.2891				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	fneg	f2, f1
	flw	f1, 18(r3)
	flw	f3, 16(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	add_light.3188				
	addi	r3, r3, -21
	lw	r31, 20(r3)
beq_cont.11885:
	addi	r1, r0, 727				# set min_caml_intersection_point
	flw	f1, 727(r0)
	fsw	f1, 751(r0)
	flw	f1, 728(r0)
	fsw	f1, 752(r0)
	flw	f1, 729(r0)
	fsw	f1, 753(r0)
	lw	r2, 0(r0)
	addi	r2, r2, -1
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	setup_startp_constants.3108				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	lw	r1, 1023(r0)
	addi	r1, r1, -1
	flw	f1, 10(r3)
	flw	f2, 16(r3)
	lw	r2, 6(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	trace_reflections.3192				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flup	f1, 45		# fli	f1, 0.100000
	flw	f2, 4(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.11886
	jr	r31				#
fle_else.11886:
	lw	r1, 7(r3)
	bgei	4, r1, bge_then.11888
	addi	r2, r1, 1
	addi	r5, r0, -1
	lw	r6, 8(r3)
	add	r30, r6, r2
	sw	r5, 0(r30)
	j	bge_cont.11889
bge_then.11888:
bge_cont.11889:
	lw	r2, 9(r3)
	beqi	2, r2, beq_then.11890
	j	beq_cont.11891
beq_then.11890:
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
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	trace_ray.3197				
	addi	r3, r3, -21
	lw	r31, 20(r3)
beq_cont.11891:
	jr	r31				#
beq_then.11877:
	addi	r1, r0, -1
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	0, r2, beq_then.11893
	addi	r2, r0, 667				# set min_caml_light
	lw	r1, 6(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	veciprod.2891				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	fneg	f1, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11894
	addi	r1, r0, 0
	j	fle_cont.11895
fle_else.11894:
	addi	r1, r0, 1
fle_cont.11895:
	beqi	0, r1, beq_then.11896
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
beq_then.11896:
	jr	r31				#
beq_then.11893:
	jr	r31				#
trace_diffuse_ray.3203:
	fsw	f1, 0(r3)
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	judge_intersection_fast.3174				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.11900
	addi	r1, r0, 1				# set min_caml_objects
	lw	r2, 730(r0)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r2, 2(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	sw	r1, 3(r3)
	beqi	1, r5, beq_then.11901
	beqi	2, r5, beq_then.11903
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	get_nvector_second.3180				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11904
beq_then.11903:
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	get_nvector_plane.3178				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.11904:
	j	beq_cont.11902
beq_then.11901:
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	get_nvector_rect.3176				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.11902:
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
	beqi	0, r1, beq_then.11905
	jr	r31				#
beq_then.11905:
	addi	r1, r0, 731				# set min_caml_nvector
	addi	r2, r0, 667				# set min_caml_light
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	veciprod.2891				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fneg	f1, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.11907
	addi	r1, r0, 0
	j	fle_cont.11908
fle_else.11907:
	addi	r1, r0, 1
fle_cont.11908:
	beqi	0, r1, beq_then.11909
	j	beq_cont.11910
beq_then.11909:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.11910:
	addi	r1, r0, 737				# set min_caml_diffuse_ray
	flw	f2, 0(r3)
	fmul	f1, f2, f1
	lw	r2, 3(r3)
	lw	r2, 7(r2)
	flw	f2, 0(r2)
	fmul	f1, f1, f2
	addi	r2, r0, 734				# set min_caml_texture_color
	j	vecaccum.2899
beq_then.11900:
	jr	r31				#
iter_trace_diffuse_rays.3206:
	bgei	0, r6, bge_then.11912
	jr	r31				#
bge_then.11912:
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
	beq	r0, r30, fle_else.11914
	addi	r1, r0, 0
	j	fle_cont.11915
fle_else.11914:
	addi	r1, r0, 1
fle_cont.11915:
	beqi	0, r1, beq_then.11916
	lw	r1, 2(r3)
	addi	r2, r1, 1
	lw	r5, 3(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	finv	f31, f2
	fmul	f1, f1, f31
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11917
beq_then.11916:
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	finv	f31, f2
	fmul	f1, f1, f31
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_diffuse_ray.3203				
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.11917:
	lw	r1, 2(r3)
	addi	r6, r1, -2
	lw	r1, 3(r3)
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
	addi	r6, r0, 118
	lw	r1, 2(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	iter_trace_diffuse_rays.3206
trace_diffuse_ray_80percent.3215:
	sw	r2, 0(r3)
	sw	r5, 1(r3)
	sw	r1, 2(r3)
	beqi	0, r1, beq_then.11918
	lw	r6, 766(r0)
	sw	r6, 3(r3)
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	setup_startp.3111				
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
	j	beq_cont.11919
beq_then.11918:
beq_cont.11919:
	lw	r1, 2(r3)
	beqi	1, r1, beq_then.11920
	lw	r2, 767(r0)
	lw	r5, 1(r3)
	sw	r2, 4(r3)
	add	r1, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_startp.3111				
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
	j	beq_cont.11921
beq_then.11920:
beq_cont.11921:
	lw	r1, 2(r3)
	beqi	2, r1, beq_then.11922
	lw	r2, 768(r0)
	lw	r5, 1(r3)
	sw	r2, 5(r3)
	add	r1, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_startp.3111				
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
	j	beq_cont.11923
beq_then.11922:
beq_cont.11923:
	lw	r1, 2(r3)
	beqi	3, r1, beq_then.11924
	lw	r2, 769(r0)
	lw	r5, 1(r3)
	sw	r2, 6(r3)
	add	r1, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_startp.3111				
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
	j	beq_cont.11925
beq_then.11924:
beq_cont.11925:
	lw	r1, 2(r3)
	beqi	4, r1, beq_then.11926
	lw	r1, 770(r0)
	lw	r2, 1(r3)
	sw	r1, 7(r3)
	add	r1, r0, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_startp.3111				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	addi	r6, r0, 118
	lw	r1, 7(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	j	iter_trace_diffuse_rays.3206
beq_then.11926:
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
	addi	r2, r0, 737				# set min_caml_diffuse_ray
	add	r30, r8, r7
	lw	r8, 0(r30)
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	sw	r10, 3(r3)
	sw	r7, 4(r3)
	sw	r9, 5(r3)
	add	r1, r0, r2
	add	r2, r0, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecadd.2903				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 737				# set min_caml_diffuse_ray
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	add	r2, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecadd.2903				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 737				# set min_caml_diffuse_ray
	lw	r2, 4(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	add	r2, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecadd.2903				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 737				# set min_caml_diffuse_ray
	lw	r2, 4(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	add	r2, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecadd.2903				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 4(r1)
	addi	r2, r0, 740				# set min_caml_rgb
	lw	r5, 4(r3)
	add	r30, r1, r5
	lw	r1, 0(r30)
	addi	r5, r0, 737				# set min_caml_diffuse_ray
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	j	vecaccumv.2912
do_without_neighbors.3228:
	blei	4, r2, ble_then.11928
	jr	r31				#
ble_then.11928:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.11930
	jr	r31				#
bge_then.11930:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	beqi	0, r5, beq_then.11932
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
	j	beq_cont.11933
beq_then.11932:
beq_cont.11933:
	lw	r1, 1(r3)
	addi	r2, r1, 1
	blei	4, r2, ble_then.11934
	jr	r31				#
ble_then.11934:
	lw	r1, 0(r3)
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.11936
	jr	r31				#
bge_then.11936:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 3(r3)
	beqi	0, r5, beq_then.11938
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	calc_diffuse_using_1point.3219				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.11939
beq_then.11938:
beq_cont.11939:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	lw	r1, 0(r3)
	j	do_without_neighbors.3228
neighbors_exist.3231:
	lw	r5, 744(r0)
	addi	r6, r2, 1
	ble	r5, r6, ble_then.11940
	blei	0, r2, ble_then.11941
	lw	r2, 743(r0)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.11942
	blei	0, r1, ble_then.11943
	addi	r1, r0, 1
	jr	r31				#
ble_then.11943:
	addi	r1, r0, 0
	jr	r31				#
ble_then.11942:
	addi	r1, r0, 0
	jr	r31				#
ble_then.11941:
	addi	r1, r0, 0
	jr	r31				#
ble_then.11940:
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
	beq	r2, r8, beq_then.11944
	addi	r1, r0, 0
	jr	r31				#
beq_then.11944:
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.11945
	addi	r1, r0, 0
	jr	r31				#
beq_then.11945:
	addi	r2, r1, -1
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.11946
	addi	r1, r0, 0
	jr	r31				#
beq_then.11946:
	addi	r1, r1, 1
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beq	r1, r8, beq_then.11947
	addi	r1, r0, 0
	jr	r31				#
beq_then.11947:
	addi	r1, r0, 1
	jr	r31				#
try_exploit_neighbors.3244:
	add	r30, r6, r1
	lw	r9, 0(r30)
	blei	4, r8, ble_then.11948
	jr	r31				#
ble_then.11948:
	lw	r10, 2(r9)
	add	r30, r10, r8
	lw	r10, 0(r30)
	bgei	0, r10, bge_then.11950
	jr	r31				#
bge_then.11950:
	sw	r2, 0(r3)
	sw	r7, 1(r3)
	sw	r5, 2(r3)
	sw	r9, 3(r3)
	sw	r8, 4(r3)
	sw	r1, 5(r3)
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
	beqi	0, r1, beq_then.11952
	lw	r1, 3(r3)
	lw	r1, 3(r1)
	lw	r7, 4(r3)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beqi	0, r1, beq_then.11953
	lw	r1, 5(r3)
	lw	r2, 2(r3)
	lw	r5, 6(r3)
	lw	r6, 1(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	calc_diffuse_using_5points.3222				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.11954
beq_then.11953:
beq_cont.11954:
	lw	r1, 4(r3)
	addi	r8, r1, 1
	lw	r1, 5(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r6, 6(r3)
	lw	r7, 1(r3)
	j	try_exploit_neighbors.3244
beq_then.11952:
	lw	r1, 5(r3)
	lw	r2, 6(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 4(r3)
	blei	4, r2, ble_then.11955
	jr	r31				#
ble_then.11955:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.11957
	jr	r31				#
bge_then.11957:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r1, 7(r3)
	beqi	0, r5, beq_then.11959
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	calc_diffuse_using_1point.3219				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.11960
beq_then.11959:
beq_cont.11960:
	lw	r1, 4(r3)
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
	ble	r1, r2, ble_then.11961
	addi	r1, r0, 255
	j	ble_cont.11962
ble_then.11961:
	bgei	0, r1, bge_then.11963
	addi	r1, r0, 0
	j	bge_cont.11964
bge_then.11963:
bge_cont.11964:
ble_cont.11962:
	j	print_int.2857
write_rgb.3255:
	flw	f1, 740(r0)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.11965
	addi	r1, r0, 255
	j	ble_cont.11966
ble_then.11965:
	bgei	0, r1, bge_then.11967
	addi	r1, r0, 0
	j	bge_cont.11968
bge_then.11967:
bge_cont.11968:
ble_cont.11966:
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
	ble	r1, r2, ble_then.11969
	addi	r1, r0, 255
	j	ble_cont.11970
ble_then.11969:
	bgei	0, r1, bge_then.11971
	addi	r1, r0, 0
	j	bge_cont.11972
bge_then.11971:
bge_cont.11972:
ble_cont.11970:
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
	ble	r1, r2, ble_then.11973
	addi	r1, r0, 255
	j	ble_cont.11974
ble_then.11973:
	bgei	0, r1, bge_then.11975
	addi	r1, r0, 0
	j	bge_cont.11976
bge_then.11975:
bge_cont.11976:
ble_cont.11974:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
pretrace_diffuse_rays.3257:
	blei	4, r2, ble_then.11977
	jr	r31				#
ble_then.11977:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.11979
	jr	r31				#
bge_then.11979:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 0(r3)
	beqi	0, r5, beq_then.11981
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
	sw	r1, 1(r3)
	sw	r7, 2(r3)
	sw	r6, 3(r3)
	sw	r5, 4(r3)
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_startp.3111				
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
	j	beq_cont.11982
beq_then.11981:
beq_cont.11982:
	lw	r2, 0(r3)
	addi	r2, r2, 1
	j	pretrace_diffuse_rays.3257
pretrace_pixels.3260:
	bgei	0, r2, bge_then.11983
	jr	r31				#
bge_then.11983:
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
	bgei	5, r1, bge_then.11985
	add	r5, r0, r1
	j	bge_cont.11986
bge_then.11985:
	addi	r5, r1, -5
bge_cont.11986:
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
	ble	r8, r1, ble_then.11987
	add	r30, r6, r1
	lw	r8, 0(r30)
	lw	r8, 0(r8)
	flw	f1, 0(r8)
	fsw	f1, 740(r0)
	flw	f1, 1(r8)
	fsw	f1, 741(r0)
	flw	f1, 2(r8)
	fsw	f1, 742(r0)
	sw	r7, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	add	r5, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	neighbors_exist.3231				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.11988
	addi	r8, r0, 0
	lw	r1, 3(r3)
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	lw	r6, 4(r3)
	lw	r7, 0(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	try_exploit_neighbors.3244				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.11989
beq_then.11988:
	lw	r1, 3(r3)
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 2(r5)
	lw	r7, 0(r7)
	bgei	0, r7, bge_then.11990
	j	bge_cont.11991
bge_then.11990:
	lw	r7, 3(r5)
	lw	r7, 0(r7)
	sw	r5, 5(r3)
	beqi	0, r7, beq_then.11992
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_diffuse_using_1point.3219				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.11993
beq_then.11992:
beq_cont.11993:
	addi	r2, r0, 1
	lw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	do_without_neighbors.3228				
	addi	r3, r3, -7
	lw	r31, 6(r3)
bge_cont.11991:
beq_cont.11989:
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	write_rgb.3255				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	lw	r6, 4(r3)
	lw	r7, 0(r3)
	j	scan_pixel.3271
ble_then.11987:
	jr	r31				#
scan_line.3277:
	lw	r8, 744(r0)
	ble	r8, r1, ble_then.11995
	lw	r8, 744(r0)
	addi	r8, r8, -1
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	ble	r8, r1, ble_then.11996
	addi	r8, r1, 1
	add	r5, r0, r7
	add	r2, r0, r8
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	pretrace_line.3267				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	ble_cont.11997
ble_then.11996:
ble_cont.11997:
	addi	r1, r0, 0
	lw	r2, 4(r3)
	lw	r5, 3(r3)
	lw	r6, 2(r3)
	lw	r7, 1(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	scan_pixel.3271				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	addi	r2, r2, 2
	bgei	5, r2, bge_then.11998
	add	r7, r0, r2
	j	bge_cont.11999
bge_then.11998:
	addi	r7, r2, -5
bge_cont.11999:
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	lw	r6, 3(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	scan_line.3277				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	jr	r31				#
ble_then.11995:
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
	bgei	0, r2, bge_then.12002
	jr	r31				#
bge_then.12002:
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
	addi	r1, r2, -1
	bgei	0, r1, bge_then.12003
	add	r1, r0, r5
	jr	r31				#
bge_then.12003:
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	create_pixel.3285				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	bgei	0, r1, bge_then.12004
	add	r1, r0, r5
	jr	r31				#
bge_then.12004:
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	create_pixel.3285				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	bgei	0, r1, bge_then.12005
	add	r1, r0, r5
	jr	r31				#
bge_then.12005:
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_pixel.3285				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 4(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	add	r1, r0, r5
	j	init_line_elements.3287
create_pixelline.3290:
	lw	r1, 743(r0)
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
	lw	r2, 743(r0)
	addi	r2, r2, -2
	bgei	0, r2, bge_then.12006
	jr	r31				#
bge_then.12006:
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	create_pixel.3285				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	bgei	0, r1, bge_then.12007
	add	r1, r0, r5
	jr	r31				#
bge_then.12007:
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	create_pixel.3285				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	bgei	0, r1, bge_then.12008
	add	r1, r0, r5
	jr	r31				#
bge_then.12008:
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_pixel.3285				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 4(r3)
	lw	r5, 2(r3)
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
	finv	f31, f1
	fmul	f1, f2, f31
	jr	r31				#
adjust_position.3294:
	fmul	f1, f1, f1
	flup	f3, 45		# fli	f3, 0.100000
	fadd	f1, f1, f3
	fsqrt	f1, f1
	flup	f3, 2		# fli	f3, 1.000000
	finv	f31, f1
	fmul	f3, f3, f31
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
	fsw	f1, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin.2837				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos.2839				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	finv	f31, f1
	fmul	f1, f2, f31
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
calc_dirvec.3297:
	bgei	5, r1, bge_then.12009
	fmul	f1, f2, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f1, f1, f2
	fsqrt	f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	finv	f31, f1
	fmul	f2, f2, f31
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	fsw	f4, 2(r3)
	sw	r1, 4(r3)
	fsw	f1, 6(r3)
	fsw	f3, 8(r3)
	fadd	f1, f0, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan.2843				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
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
	finv	f31, f1
	fmul	f1, f2, f31
	flw	f2, 6(r3)
	fmul	f1, f1, f2
	lw	r1, 4(r3)
	addi	r1, r1, 1
	fmul	f2, f1, f1
	flup	f3, 45		# fli	f3, 0.100000
	fadd	f2, f2, f3
	fsqrt	f2, f2
	flup	f3, 2		# fli	f3, 1.000000
	finv	f31, f2
	fmul	f3, f3, f31
	fsw	f1, 14(r3)
	sw	r1, 16(r3)
	fsw	f2, 18(r3)
	fadd	f1, f0, f3
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	atan.2843				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 2(r3)
	fmul	f1, f1, f2
	fsw	f1, 20(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	sin.2837				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 20(r3)
	fsw	f1, 22(r3)
	fadd	f1, f0, f2
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	cos.2839				
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 22(r3)
	finv	f31, f1
	fmul	f1, f2, f31
	flw	f2, 18(r3)
	fmul	f2, f1, f2
	flw	f1, 14(r3)
	flw	f3, 8(r3)
	flw	f4, 2(r3)
	lw	r1, 16(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	calc_dirvec.3297
bge_then.12009:
	fmul	f3, f1, f1
	fmul	f4, f2, f2
	fadd	f3, f3, f4
	flup	f4, 2		# fli	f4, 1.000000
	fadd	f3, f3, f4
	fsqrt	f3, f3
	finv	f31, f3
	fmul	f1, f1, f31
	finv	f31, f3
	fmul	f2, f2, f31
	flup	f4, 2		# fli	f4, 1.000000
	finv	f31, f3
	fmul	f3, f4, f31
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
	bgei	0, r1, bge_then.12013
	jr	r31				#
bge_then.12013:
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
	bgei	5, r2, bge_then.12015
	j	bge_cont.12016
bge_then.12015:
	addi	r2, r2, -5
bge_cont.12016:
	flw	f1, 0(r3)
	lw	r5, 3(r3)
	j	calc_dirvecs.3305
calc_dirvec_rows.3310:
	bgei	0, r1, bge_then.12017
	jr	r31				#
bge_then.12017:
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
	bgei	5, r2, bge_then.12019
	j	bge_cont.12020
bge_then.12019:
	addi	r2, r2, -5
bge_cont.12020:
	lw	r5, 0(r3)
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
	bgei	0, r2, bge_then.12021
	jr	r31				#
bge_then.12021:
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
	bgei	0, r1, bge_then.12023
	jr	r31				#
bge_then.12023:
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
	addi	r2, r2, -1
	add	r1, r0, r5
	j	create_dirvec_elements.3316
create_dirvecs.3319:
	bgei	0, r1, bge_then.12025
	jr	r31				#
bge_then.12025:
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
	addi	r1, r0, 117
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_dirvec_elements.3316				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.12027
	jr	r31				#
bge_then.12027:
	addi	r2, r0, 766				# set min_caml_dirvecs
	addi	r5, r0, 120
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	sw	r5, 8(r3)
	add	r1, r0, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_float_array				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 9(r3)
	sw	r1, 0(r2)
	lw	r1, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r0, 766				# set min_caml_dirvecs
	add	r30, r1, r2
	lw	r1, 0(r30)
	addi	r5, r0, 118
	add	r2, r0, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	create_dirvec_elements.3316				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 6(r3)
	addi	r1, r1, -1
	j	create_dirvecs.3319
init_dirvec_constants.3321:
	bgei	0, r2, bge_then.12029
	jr	r31				#
bge_then.12029:
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
	bgei	0, r1, bge_then.12031
	jr	r31				#
bge_then.12031:
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r0)
	addi	r6, r6, -1
	sw	r1, 2(r3)
	add	r2, r0, r6
	add	r1, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	j	init_dirvec_constants.3321
init_vecset_constants.3324:
	bgei	0, r1, bge_then.12033
	jr	r31				#
bge_then.12033:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 119(r2)
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
	addi	r2, r0, 118
	lw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	bgei	0, r1, bge_then.12035
	jr	r31				#
bge_then.12035:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r2, 0(r30)
	addi	r5, r0, 119
	sw	r1, 2(r3)
	add	r1, r0, r2
	add	r2, r0, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
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
	addi	r2, r0, 118
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	create_dirvec_elements.3316				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r1, r0, 3
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	create_dirvecs.3319				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	calc_dirvec_rows.3310				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 770(r0)
	addi	r2, r0, 119
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r1, r0, 3
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
	lw	r1, 14(r3)
	sw	r1, 0(r2)
	flw	f1, 12(r3)
	fsw	f1, 0(r1)
	flw	f1, 10(r3)
	fsw	f1, 1(r1)
	flw	f2, 8(r3)
	fsw	f2, 2(r1)
	lw	r1, 0(r0)
	addi	r1, r1, -1
	sw	r2, 15(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -17
	lw	r31, 16(r3)
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
	sw	r1, 16(r3)
	sw	r6, 17(r3)
	fsw	f2, 18(r3)
	add	r1, r0, r7
	fadd	f1, f0, f3
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	lib_create_float_array				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 20(r3)
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_array				
	addi	r3, r3, -22
	lw	r31, 21(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 20(r3)
	sw	r1, 0(r2)
	flw	f1, 0(r3)
	fsw	f1, 0(r1)
	flw	f2, 18(r3)
	fsw	f2, 1(r1)
	flw	f2, 8(r3)
	fsw	f2, 2(r1)
	lw	r1, 0(r0)
	addi	r1, r1, -1
	sw	r2, 21(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	addi	r1, r0, 778				# set min_caml_reflections
	add	r2, r0, r4
	addi	r4, r4, 3
	flw	f1, 6(r3)
	fsw	f1, 2(r2)
	lw	r5, 21(r3)
	sw	r5, 1(r2)
	lw	r5, 17(r3)
	sw	r5, 0(r2)
	lw	r5, 16(r3)
	add	r30, r1, r5
	sw	r2, 0(r30)
	lw	r1, 3(r3)
	addi	r2, r1, 2
	lw	r5, 2(r3)
	addi	r5, r5, 3
	flw	f2, 669(r0)
	addi	r6, r0, 3
	flup	f3, 0		# fli	f3, 0.000000
	sw	r2, 22(r3)
	sw	r5, 23(r3)
	fsw	f2, 24(r3)
	add	r1, r0, r6
	fadd	f1, f0, f3
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_float_array				
	addi	r3, r3, -27
	lw	r31, 26(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 26(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	lib_create_array				
	addi	r3, r3, -28
	lw	r31, 27(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 26(r3)
	sw	r1, 0(r2)
	flw	f1, 0(r3)
	fsw	f1, 0(r1)
	flw	f1, 10(r3)
	fsw	f1, 1(r1)
	flw	f1, 24(r3)
	fsw	f1, 2(r1)
	lw	r1, 0(r0)
	addi	r1, r1, -1
	sw	r2, 27(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	addi	r1, r0, 778				# set min_caml_reflections
	add	r2, r0, r4
	addi	r4, r4, 3
	flw	f1, 6(r3)
	fsw	f1, 2(r2)
	lw	r5, 27(r3)
	sw	r5, 1(r2)
	lw	r5, 23(r3)
	sw	r5, 0(r2)
	lw	r5, 22(r3)
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
	addi	r6, r0, 667				# set min_caml_light
	lw	r7, 4(r2)
	sw	r5, 0(r3)
	sw	r1, 1(r3)
	fsw	f1, 2(r3)
	sw	r2, 4(r3)
	add	r2, r0, r7
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	veciprod.2891				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	flup	f2, 3		# fli	f2, 2.000000
	lw	r1, 4(r3)
	lw	r2, 4(r1)
	flw	f3, 0(r2)
	fmul	f2, f2, f3
	fmul	f2, f2, f1
	flw	f3, 667(r0)
	fsub	f2, f2, f3
	flup	f3, 3		# fli	f3, 2.000000
	lw	r2, 4(r1)
	flw	f4, 1(r2)
	fmul	f3, f3, f4
	fmul	f3, f3, f1
	flw	f4, 668(r0)
	fsub	f3, f3, f4
	flup	f4, 3		# fli	f4, 2.000000
	lw	r1, 4(r1)
	flw	f5, 2(r1)
	fmul	f4, f4, f5
	fmul	f1, f4, f1
	flw	f4, 669(r0)
	fsub	f1, f1, f4
	addi	r1, r0, 3
	flup	f4, 0		# fli	f4, 0.000000
	fsw	f1, 6(r3)
	fsw	f3, 8(r3)
	fsw	f2, 10(r3)
	fadd	f1, f0, f4
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_float_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r2, r0, r1
	lw	r1, 0(r0)
	sw	r2, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 12(r3)
	sw	r1, 0(r2)
	flw	f1, 10(r3)
	fsw	f1, 0(r1)
	flw	f1, 8(r3)
	fsw	f1, 1(r1)
	flw	f1, 6(r3)
	fsw	f1, 2(r1)
	lw	r1, 0(r0)
	addi	r1, r1, -1
	sw	r2, 13(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r1, r0, 778				# set min_caml_reflections
	add	r2, r0, r4
	addi	r4, r4, 3
	flw	f1, 2(r3)
	fsw	f1, 2(r2)
	lw	r5, 13(r3)
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
	bgei	0, r1, bge_then.12042
	jr	r31				#
bge_then.12042:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.12044
	jr	r31				#
beq_then.12044:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 7(r2)
	flw	f2, 0(r5)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.12046
	jr	r31				#
fle_else.12046:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.12048
	beqi	2, r5, beq_then.12049
	jr	r31				#
beq_then.12049:
	j	setup_surface_reflection.3338
beq_then.12048:
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
	finv	f31, f2
	fmul	f1, f1, f31
	fsw	f1, 747(r0)
	lw	r1, 743(r0)
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
	lw	r2, 743(r0)
	addi	r2, r2, -2
	bgei	0, r2, bge_then.12051
	j	bge_cont.12052
bge_then.12051:
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	create_pixel.3285				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	bgei	0, r1, bge_then.12053
	add	r1, r0, r5
	j	bge_cont.12054
bge_then.12053:
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	create_pixel.3285				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	add	r1, r0, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	init_line_elements.3287				
	addi	r3, r3, -5
	lw	r31, 4(r3)
bge_cont.12054:
bge_cont.12052:
	lw	r2, 743(r0)
	sw	r1, 4(r3)
	sw	r2, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_pixel.3285				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r2, r0, r1
	lw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 743(r0)
	addi	r2, r2, -2
	bgei	0, r2, bge_then.12055
	j	bge_cont.12056
bge_then.12055:
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	create_pixel.3285				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	bgei	0, r1, bge_then.12057
	add	r1, r0, r5
	j	bge_cont.12058
bge_then.12057:
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	create_pixel.3285				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 8(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	add	r1, r0, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	init_line_elements.3287				
	addi	r3, r3, -10
	lw	r31, 9(r3)
bge_cont.12058:
bge_cont.12056:
	lw	r2, 743(r0)
	sw	r1, 9(r3)
	sw	r2, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_pixel.3285				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1
	lw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 743(r0)
	addi	r2, r2, -2
	bgei	0, r2, bge_then.12059
	j	bge_cont.12060
bge_then.12059:
	sw	r2, 11(r3)
	sw	r1, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	create_pixel.3285				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	bgei	0, r1, bge_then.12061
	add	r1, r0, r5
	j	bge_cont.12062
bge_then.12061:
	sw	r1, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	create_pixel.3285				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 13(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	add	r1, r0, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	init_line_elements.3287				
	addi	r3, r3, -15
	lw	r31, 14(r3)
bge_cont.12062:
bge_cont.12060:
	sw	r1, 14(r3)
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
	beqi	0, r1, beq_then.12063
	addi	r1, r0, 1
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	read_object.2998				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	j	beq_cont.12064
beq_then.12063:
	lw	r1, 15(r3)
	sw	r1, 0(r0)
beq_cont.12064:
	addi	r1, r0, 0
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	read_and_network.3006				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	addi	r1, r0, 0
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	read_or_network.3004				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	sw	r1, 723(r0)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	write_ppm_header.3251				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	addi	r1, r0, 4
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	create_dirvecs.3319				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	calc_dirvec_rows.3310				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	addi	r1, r0, 4
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	init_vecset_constants.3324				
	addi	r3, r3, -17
	lw	r31, 16(r3)
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
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	lw	r1, 0(r0)
	addi	r1, r1, -1
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	setup_reflections.3341				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r1, 9(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	pretrace_line.3267				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	addi	r1, r0, 0
	addi	r7, r0, 2
	lw	r2, 4(r3)
	lw	r5, 9(r3)
	lw	r6, 14(r3)
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
