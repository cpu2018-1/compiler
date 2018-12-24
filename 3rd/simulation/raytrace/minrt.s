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
	beq	r0, r30, fle_else.16561
	addi	r1, r0, 0
	jr	r31				#
fle_else.16561:
	addi	r1, r0, 1
	jr	r31				#
fisneg.2805:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16562
	addi	r1, r0, 0
	jr	r31				#
fle_else.16562:
	addi	r1, r0, 1
	jr	r31				#
fiszero.2807:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16563
	addi	r1, r0, 1
	jr	r31				#
feq_else.16563:
	addi	r1, r0, 0
	jr	r31				#
xor.2809:
	beq	r1, r2, beq_then.16564
	addi	r1, r0, 1
	jr	r31				#
beq_then.16564:
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
	beq	r0, r30, fle_else.16565
	jr	r31				#
fle_else.16565:
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
	beq	r0, r30, fle_else.16566
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16566:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
	jr	r31				#
hoge.2824:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16567
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16568
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16569
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16570
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16571
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16572
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16573
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16574
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16575
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16576
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16577
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16578
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16579
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16580
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16581
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16582
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2824
fle_else.16582:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16581:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16580:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16579:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16578:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16577:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16576:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16575:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16574:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16573:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16572:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16571:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16570:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16569:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16568:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.16567:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2827:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16583
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16584
	fsub	f4, f1, f2
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	flup	f1, 3		# fli	f1, 2.000000
	fmul	f1, f3, f1
	fle	r30, f1, f4
	beq	r0, r30, fle_else.16585
	fle	r30, f2, f4
	beq	r0, r30, fle_else.16586
	fsub	f4, f4, f2
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.16586:
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.16585:
	fadd	f1, f0, f4
	jr	r31				#
fle_else.16584:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16587
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16588
	fsub	f4, f1, f2
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.16588:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	j	fuga.2827
fle_else.16587:
	jr	r31				#
fle_else.16583:
	jr	r31				#
modulo_2pi.2831:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16589
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16591
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16593
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16595
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16597
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16599
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16601
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16603
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16605
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16607
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16609
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16611
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16613
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16615
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16617
	addi	r30, r0, 4060
	lui	r30, r30, 18505	# to load float		205887.438848
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
	flw	f1, 0(r3)
	flw	f3, 2(r3)
	j	fle_cont.16618
fle_else.16617:
fle_cont.16618:
	j	fle_cont.16616
fle_else.16615:
fle_cont.16616:
	j	fle_cont.16614
fle_else.16613:
fle_cont.16614:
	j	fle_cont.16612
fle_else.16611:
fle_cont.16612:
	j	fle_cont.16610
fle_else.16609:
fle_cont.16610:
	j	fle_cont.16608
fle_else.16607:
fle_cont.16608:
	j	fle_cont.16606
fle_else.16605:
fle_cont.16606:
	j	fle_cont.16604
fle_else.16603:
fle_cont.16604:
	j	fle_cont.16602
fle_else.16601:
fle_cont.16602:
	j	fle_cont.16600
fle_else.16599:
fle_cont.16600:
	j	fle_cont.16598
fle_else.16597:
fle_cont.16598:
	j	fle_cont.16596
fle_else.16595:
fle_cont.16596:
	j	fle_cont.16594
fle_else.16593:
fle_cont.16594:
	j	fle_cont.16592
fle_else.16591:
fle_cont.16592:
	j	fle_cont.16590
fle_else.16589:
fle_cont.16590:
	flup	f4, 5		# fli	f4, 6.283186
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16619
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16620
	fsub	f4, f1, f2
	flup	f1, 3		# fli	f1, 2.000000
	finv	f31, f1
	fmul	f2, f2, f31
	fadd	f1, f0, f4
	j	fuga.2827
fle_else.16620:
	flup	f4, 3		# fli	f4, 2.000000
	finv	f31, f4
	fmul	f2, f2, f31
	j	fuga.2827
fle_else.16619:
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
	beq	r0, r30, fle_else.16621
	flup	f5, 2		# fli	f5, 1.000000
	j	fle_cont.16622
fle_else.16621:
	flup	f5, 11		# fli	f5, -1.000000
fle_cont.16622:
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
	beq	r0, r30, fle_else.16623
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16625
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16627
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16629
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16631
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16633
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16635
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16637
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16639
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16641
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16643
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16645
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16647
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f1, r30
	fle	r30, f1, f6
	beq	r0, r30, fle_else.16649
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f1, r30
	fsw	f3, 4(r3)
	fsw	f2, 6(r3)
	fsw	f6, 8(r3)
	fadd	f2, f0, f1
	fadd	f1, f0, f6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	hoge.2824				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	fadd	f2, f0, f1
	flw	f3, 4(r3)
	flw	f4, 0(r3)
	flw	f5, 2(r3)
	flw	f6, 8(r3)
	j	fle_cont.16650
fle_else.16649:
	fadd	f2, f0, f1
fle_cont.16650:
	j	fle_cont.16648
fle_else.16647:
	fadd	f2, f0, f1
fle_cont.16648:
	j	fle_cont.16646
fle_else.16645:
	fadd	f2, f0, f1
fle_cont.16646:
	j	fle_cont.16644
fle_else.16643:
	fadd	f2, f0, f1
fle_cont.16644:
	j	fle_cont.16642
fle_else.16641:
	fadd	f2, f0, f1
fle_cont.16642:
	j	fle_cont.16640
fle_else.16639:
	fadd	f2, f0, f1
fle_cont.16640:
	j	fle_cont.16638
fle_else.16637:
	fadd	f2, f0, f1
fle_cont.16638:
	j	fle_cont.16636
fle_else.16635:
	fadd	f2, f0, f1
fle_cont.16636:
	j	fle_cont.16634
fle_else.16633:
	fadd	f2, f0, f1
fle_cont.16634:
	j	fle_cont.16632
fle_else.16631:
	fadd	f2, f0, f1
fle_cont.16632:
	j	fle_cont.16630
fle_else.16629:
	fadd	f2, f0, f1
fle_cont.16630:
	j	fle_cont.16628
fle_else.16627:
	fadd	f2, f0, f1
fle_cont.16628:
	j	fle_cont.16626
fle_else.16625:
	fadd	f2, f0, f1
fle_cont.16626:
	j	fle_cont.16624
fle_else.16623:
	fadd	f2, f0, f1
fle_cont.16624:
	fadd	f1, f0, f6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	fuga.2827				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	fadd	f2, f0, f1
	flw	f4, 0(r3)
	flw	f5, 2(r3)
	fle	r30, f4, f2
	beq	r0, r30, fle_else.16651
	fsub	f2, f2, f4
	fneg	f3, f5
	flup	f1, 15		# fli	f1, 1.570796
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16652
	fsub	f2, f4, f2
	flup	f1, 16		# fli	f1, 0.785398
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16653
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
fle_else.16653:
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
fle_else.16652:
	flup	f1, 16		# fli	f1, 0.785398
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16654
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
fle_else.16654:
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
fle_else.16651:
	flup	f1, 15		# fli	f1, 1.570796
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16655
	fsub	f2, f4, f2
	flup	f1, 16		# fli	f1, 0.785398
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16656
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
fle_else.16656:
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
fle_else.16655:
	flup	f1, 16		# fli	f1, 0.785398
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16657
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
fle_else.16657:
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
	beq	r0, r30, fle_else.16658
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16660
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16662
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16664
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16666
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16668
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16670
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16672
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16674
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16676
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16678
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16680
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16682
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f1, r30
	fle	r30, f1, f5
	beq	r0, r30, fle_else.16684
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
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
	flw	f3, 4(r3)
	flw	f2, 0(r3)
	flw	f4, 2(r3)
	flw	f5, 8(r3)
	j	fle_cont.16685
fle_else.16684:
fle_cont.16685:
	j	fle_cont.16683
fle_else.16682:
fle_cont.16683:
	j	fle_cont.16681
fle_else.16680:
fle_cont.16681:
	j	fle_cont.16679
fle_else.16678:
fle_cont.16679:
	j	fle_cont.16677
fle_else.16676:
fle_cont.16677:
	j	fle_cont.16675
fle_else.16674:
fle_cont.16675:
	j	fle_cont.16673
fle_else.16672:
fle_cont.16673:
	j	fle_cont.16671
fle_else.16670:
fle_cont.16671:
	j	fle_cont.16669
fle_else.16668:
fle_cont.16669:
	j	fle_cont.16667
fle_else.16666:
fle_cont.16667:
	j	fle_cont.16665
fle_else.16664:
fle_cont.16665:
	j	fle_cont.16663
fle_else.16662:
fle_cont.16663:
	j	fle_cont.16661
fle_else.16660:
fle_cont.16661:
	j	fle_cont.16659
fle_else.16658:
fle_cont.16659:
	fadd	f2, f0, f1
	fadd	f1, f0, f5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	fuga.2827				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	flw	f4, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16686
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16687
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.16688
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
fle_else.16688:
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
fle_else.16687:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16689
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
fle_else.16689:
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
fle_else.16686:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16690
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.16691
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
fle_else.16691:
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
fle_else.16690:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16692
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
fle_else.16692:
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
	beq	r0, r30, fle_else.16693
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.16694
fle_else.16693:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.16694:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16695
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16696
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
fle_else.16696:
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
fle_else.16695:
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
	ble	r7, r1, ble_then.16697
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r8, r5, 3
	slli	r7, r5, 1
	add	r7, r8, r7
	ble	r7, r1, ble_then.16698
	j	div10_sub.2849
ble_then.16698:
	slli	r7, r5, 3
	slli	r2, r5, 1
	add	r2, r7, r2
	addi	r2, r2, 9
	ble	r1, r2, ble_then.16699
	add	r2, r0, r5
	add	r5, r0, r6
	j	div10_sub.2849
ble_then.16699:
	add	r1, r0, r5
	jr	r31				#
ble_then.16697:
	slli	r7, r6, 3
	slli	r2, r6, 1
	add	r2, r7, r2
	addi	r2, r2, 9
	ble	r1, r2, ble_then.16700
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r8, r2, 3
	slli	r7, r2, 1
	add	r7, r8, r7
	ble	r7, r1, ble_then.16701
	add	r5, r0, r2
	add	r2, r0, r6
	j	div10_sub.2849
ble_then.16701:
	slli	r7, r2, 3
	slli	r6, r2, 1
	add	r6, r7, r6
	addi	r6, r6, 9
	ble	r1, r6, ble_then.16702
	j	div10_sub.2849
ble_then.16702:
	add	r1, r0, r2
	jr	r31				#
ble_then.16700:
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
	bgei	10, r1, bge_then.16703
	addi	r1, r1, 48
	out	r1
	jr	r31				#
bge_then.16703:
	slli	r5, r1, 7
	slli	r2, r1, 6
	add	r5, r5, r2
	slli	r2, r1, 3
	add	r5, r5, r2
	slli	r2, r1, 2
	add	r2, r5, r2
	add	r2, r2, r1
	srli	r6, r2, 11
	bgei	10, r6, bge_then.16704
	addi	r2, r6, 48
	out	r2
	j	bge_cont.16705
bge_then.16704:
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
bge_cont.16705:
	slli	r5, r6, 3
	slli	r2, r6, 1
	add	r2, r5, r2
	sub	r1, r1, r2
	addi	r1, r1, 48
	out	r1
	jr	r31				#
print_int.2857:
	bgei	0, r1, bge_then.16706
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	j	print_int.2857
bge_then.16706:
	bgei	10, r1, bge_then.16707
	addi	r1, r1, 48
	out	r1
	jr	r31				#
bge_then.16707:
	addi	r2, r0, 100
	ble	r2, r1, ble_then.16708
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
ble_then.16708:
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
	beqi	0, r1, beq_then.16709
	beqi	0, r2, beq_then.16710
	addi	r1, r0, 0
	jr	r31				#
beq_then.16710:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16709:
	add	r1, r0, r2
	jr	r31				#
sgn.2862:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16711
	addi	r1, r0, 1
	j	feq_cont.16712
feq_else.16711:
	addi	r1, r0, 0
feq_cont.16712:
	beqi	0, r1, beq_then.16713
	flup	f1, 0		# fli	f1, 0.000000
	jr	r31				#
beq_then.16713:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16714
	addi	r1, r0, 0
	j	fle_cont.16715
fle_else.16714:
	addi	r1, r0, 1
fle_cont.16715:
	beqi	0, r1, beq_then.16716
	flup	f1, 2		# fli	f1, 1.000000
	jr	r31				#
beq_then.16716:
	flup	f1, 11		# fli	f1, -1.000000
	jr	r31				#
fneg_cond.2864:
	beqi	0, r1, beq_then.16717
	jr	r31				#
beq_then.16717:
	fneg	f1, f1
	jr	r31				#
add_mod5.2867:
	add	r1, r1, r2
	bgei	5, r1, bge_then.16718
	jr	r31				#
bge_then.16718:
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
	beq	r0, r30, feq_else.16724
	addi	r5, r0, 1
	j	feq_cont.16725
feq_else.16724:
	addi	r5, r0, 0
feq_cont.16725:
	beqi	0, r5, beq_then.16726
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16727
beq_then.16726:
	beqi	0, r2, beq_then.16728
	flup	f2, 11		# fli	f2, -1.000000
	finv	f31, f1
	fmul	f1, f2, f31
	j	beq_cont.16729
beq_then.16728:
	flup	f2, 2		# fli	f2, 1.000000
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.16729:
beq_cont.16727:
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
	beqi	-1, r5, beq_then.16741
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
	beq	r0, r30, fle_else.16742
	addi	r11, r0, 0
	j	fle_cont.16743
fle_else.16742:
	addi	r11, r0, 1
fle_cont.16743:
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
	beqi	0, r12, beq_then.16744
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
	j	beq_cont.16745
beq_then.16744:
beq_cont.16745:
	beqi	2, r13, beq_then.16746
	add	r10, r0, r11
	j	beq_cont.16747
beq_then.16746:
	addi	r10, r0, 1
beq_cont.16747:
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
	beqi	3, r13, beq_then.16748
	beqi	2, r13, beq_then.16750
	j	beq_cont.16751
beq_then.16750:
	beqi	0, r11, beq_then.16752
	addi	r1, r0, 0
	j	beq_cont.16753
beq_then.16752:
	addi	r1, r0, 1
beq_cont.16753:
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
beq_cont.16751:
	j	beq_cont.16749
beq_then.16748:
	flw	f1, 0(r16)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16754
	addi	r1, r0, 1
	j	feq_cont.16755
feq_else.16754:
	addi	r1, r0, 0
feq_cont.16755:
	beqi	0, r1, beq_then.16756
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16757
beq_then.16756:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16758
	addi	r1, r0, 1
	j	feq_cont.16759
feq_else.16758:
	addi	r1, r0, 0
feq_cont.16759:
	beqi	0, r1, beq_then.16760
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16761
beq_then.16760:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16762
	addi	r1, r0, 0
	j	fle_cont.16763
fle_else.16762:
	addi	r1, r0, 1
fle_cont.16763:
	beqi	0, r1, beq_then.16764
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.16765
beq_then.16764:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.16765:
beq_cont.16761:
	fmul	f1, f1, f1
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.16757:
	fsw	f1, 0(r16)
	flw	f1, 1(r16)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16766
	addi	r1, r0, 1
	j	feq_cont.16767
feq_else.16766:
	addi	r1, r0, 0
feq_cont.16767:
	beqi	0, r1, beq_then.16768
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16769
beq_then.16768:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16770
	addi	r1, r0, 1
	j	feq_cont.16771
feq_else.16770:
	addi	r1, r0, 0
feq_cont.16771:
	beqi	0, r1, beq_then.16772
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16773
beq_then.16772:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16774
	addi	r1, r0, 0
	j	fle_cont.16775
fle_else.16774:
	addi	r1, r0, 1
fle_cont.16775:
	beqi	0, r1, beq_then.16776
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.16777
beq_then.16776:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.16777:
beq_cont.16773:
	fmul	f1, f1, f1
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.16769:
	fsw	f1, 1(r16)
	flw	f1, 2(r16)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16778
	addi	r1, r0, 1
	j	feq_cont.16779
feq_else.16778:
	addi	r1, r0, 0
feq_cont.16779:
	beqi	0, r1, beq_then.16780
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16781
beq_then.16780:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16782
	addi	r1, r0, 1
	j	feq_cont.16783
feq_else.16782:
	addi	r1, r0, 0
feq_cont.16783:
	beqi	0, r1, beq_then.16784
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16785
beq_then.16784:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16786
	addi	r1, r0, 0
	j	fle_cont.16787
fle_else.16786:
	addi	r1, r0, 1
fle_cont.16787:
	beqi	0, r1, beq_then.16788
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.16789
beq_then.16788:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.16789:
beq_cont.16785:
	fmul	f1, f1, f1
	finv	f31, f1
	fmul	f1, f2, f31
beq_cont.16781:
	fsw	f1, 2(r16)
beq_cont.16749:
	beqi	0, r12, beq_then.16790
	add	r2, r0, r7
	add	r1, r0, r16
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	rotate_quadratic_matrix.2993				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.16791
beq_then.16790:
beq_cont.16791:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16741:
	addi	r1, r0, 0
	jr	r31				#
read_object.2998:
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16792
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2996				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1
	lw	r1, 0(r3)
	beqi	0, r2, beq_then.16793
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16794
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	beqi	0, r2, beq_then.16795
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16796
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_nth_object.2996				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r1, 2(r3)
	beqi	0, r2, beq_then.16797
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16798
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_nth_object.2996				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1
	lw	r1, 3(r3)
	beqi	0, r2, beq_then.16799
	addi	r1, r1, 1
	j	read_object.2998
beq_then.16799:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
	jr	r31				#
ble_then.16798:
	jr	r31				#
beq_then.16797:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
	jr	r31				#
ble_then.16796:
	jr	r31				#
beq_then.16795:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
	jr	r31				#
ble_then.16794:
	jr	r31				#
beq_then.16793:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
	jr	r31				#
ble_then.16792:
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
	beqi	0, r2, beq_then.16808
	addi	r1, r0, 1
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	beqi	0, r2, beq_then.16809
	addi	r1, r0, 2
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_nth_object.2996				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1
	lw	r1, 2(r3)
	beqi	0, r2, beq_then.16810
	addi	r1, r0, 3
	j	read_object.2998
beq_then.16810:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
	jr	r31				#
beq_then.16809:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
	jr	r31				#
beq_then.16808:
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
	beqi	-1, r8, beq_then.16814
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
	beqi	-1, r7, beq_then.16815
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
	beqi	-1, r5, beq_then.16817
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
	beqi	-1, r6, beq_then.16819
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
	j	beq_cont.16820
beq_then.16819:
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
	lw	r1, 0(r3)
	lw	r5, 5(r3)
	lw	r7, 3(r3)
	lw	r8, 1(r3)
	lw	r10, 4(r3)
	lw	r11, 2(r3)
beq_cont.16820:
	add	r30, r2, r10
	sw	r5, 0(r30)
	j	beq_cont.16818
beq_then.16817:
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
	lw	r1, 0(r3)
	lw	r7, 3(r3)
	lw	r8, 1(r3)
	lw	r11, 2(r3)
beq_cont.16818:
	add	r30, r2, r11
	sw	r7, 0(r30)
	j	beq_cont.16816
beq_then.16815:
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
	lw	r1, 0(r3)
	lw	r8, 1(r3)
beq_cont.16816:
	add	r30, r2, r1
	sw	r8, 0(r30)
	add	r1, r0, r2
	jr	r31				#
beq_then.16814:
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
	beqi	-1, r7, beq_then.16821
	sw	r7, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r5, r0, r1
	lw	r1, 0(r3)
	lw	r7, 1(r3)
	beqi	-1, r5, beq_then.16823
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
	beqi	-1, r6, beq_then.16825
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
	j	beq_cont.16826
beq_then.16825:
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
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 1(r3)
beq_cont.16826:
	sw	r5, 1(r2)
	j	beq_cont.16824
beq_then.16823:
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
	lw	r1, 0(r3)
	lw	r7, 1(r3)
beq_cont.16824:
	sw	r7, 0(r2)
	add	r6, r0, r2
	j	beq_cont.16822
beq_then.16821:
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
	lw	r1, 0(r3)
beq_cont.16822:
	lw	r2, 0(r6)
	beqi	-1, r2, beq_then.16827
	addi	r8, r1, 1
	sw	r6, 6(r3)
	sw	r8, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_int				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r5, r0, r1
	lw	r6, 6(r3)
	lw	r1, 0(r3)
	lw	r8, 7(r3)
	beqi	-1, r5, beq_then.16828
	sw	r5, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_read_int				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r7, r0, r1
	lw	r6, 6(r3)
	lw	r1, 0(r3)
	lw	r5, 8(r3)
	lw	r8, 7(r3)
	beqi	-1, r7, beq_then.16830
	addi	r2, r0, 2
	sw	r7, 9(r3)
	add	r1, r0, r2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	read_net_item.3002				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r2, r0, r1
	lw	r6, 6(r3)
	lw	r1, 0(r3)
	lw	r5, 8(r3)
	lw	r7, 9(r3)
	lw	r8, 7(r3)
	sw	r7, 1(r2)
	j	beq_cont.16831
beq_then.16830:
	addi	r7, r0, 2
	addi	r2, r0, -1
	sw	r2, 10(r3)
	add	r1, r0, r7
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1
	lw	r6, 6(r3)
	lw	r1, 0(r3)
	lw	r5, 8(r3)
	lw	r8, 7(r3)
beq_cont.16831:
	sw	r5, 0(r2)
	add	r5, r0, r2
	j	beq_cont.16829
beq_then.16828:
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
	lw	r6, 6(r3)
	lw	r1, 0(r3)
	lw	r8, 7(r3)
beq_cont.16829:
	lw	r2, 0(r5)
	beqi	-1, r2, beq_then.16832
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
	j	beq_cont.16833
beq_then.16832:
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
	lw	r6, 6(r3)
	lw	r1, 0(r3)
beq_cont.16833:
	add	r30, r2, r1
	sw	r6, 0(r30)
	add	r1, r0, r2
	jr	r31				#
beq_then.16827:
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
	beqi	-1, r7, beq_then.16834
	sw	r7, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r5, r0, r1
	lw	r1, 0(r3)
	lw	r7, 1(r3)
	beqi	-1, r5, beq_then.16836
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
	beqi	-1, r6, beq_then.16838
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
	j	beq_cont.16839
beq_then.16838:
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
	lw	r1, 0(r3)
	lw	r5, 2(r3)
	lw	r7, 1(r3)
beq_cont.16839:
	sw	r5, 1(r2)
	j	beq_cont.16837
beq_then.16836:
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
	lw	r1, 0(r3)
	lw	r7, 1(r3)
beq_cont.16837:
	sw	r7, 0(r2)
	j	beq_cont.16835
beq_then.16834:
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
	lw	r1, 0(r3)
beq_cont.16835:
	lw	r5, 0(r2)
	beqi	-1, r5, beq_then.16840
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
	beqi	-1, r2, beq_then.16841
	sw	r2, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_read_int				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r5, r0, r1
	lw	r2, 8(r3)
	lw	r6, 7(r3)
	beqi	-1, r5, beq_then.16843
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
	j	beq_cont.16844
beq_then.16843:
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
	lw	r2, 8(r3)
	lw	r6, 7(r3)
beq_cont.16844:
	sw	r2, 0(r1)
	j	beq_cont.16842
beq_then.16841:
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
	lw	r6, 7(r3)
beq_cont.16842:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.16845
	addi	r2, r0, 672				# set min_caml_and_net
	add	r30, r2, r6
	sw	r1, 0(r30)
	addi	r1, r6, 1
	j	read_and_network.3006
beq_then.16845:
	jr	r31				#
beq_then.16840:
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
	beqi	0, r2, beq_then.16848
	addi	r1, r0, 1
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2996				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	lw	r1, 1(r3)
	beqi	0, r2, beq_then.16850
	addi	r1, r0, 2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_object.2998				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.16851
beq_then.16850:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
beq_cont.16851:
	j	beq_cont.16849
beq_then.16848:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
beq_cont.16849:
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1
	beqi	-1, r2, beq_then.16852
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r5, r0, r1
	lw	r2, 2(r3)
	beqi	-1, r5, beq_then.16854
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
	j	beq_cont.16855
beq_then.16854:
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
	lw	r2, 2(r3)
beq_cont.16855:
	sw	r2, 0(r1)
	j	beq_cont.16853
beq_then.16852:
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
beq_cont.16853:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.16856
	addi	r2, r0, 672				# set min_caml_and_net
	sw	r1, 0(r2)
	addi	r1, r0, 1
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	read_and_network.3006				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16857
beq_then.16856:
beq_cont.16857:
	addi	r6, r0, 723				# set min_caml_or_net
	sw	r6, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r1
	lw	r6, 6(r3)
	beqi	-1, r2, beq_then.16858
	sw	r2, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_read_int				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r5, r0, r1
	lw	r2, 7(r3)
	lw	r6, 6(r3)
	beqi	-1, r5, beq_then.16860
	addi	r1, r0, 2
	sw	r5, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	read_net_item.3002				
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	lw	r6, 6(r3)
	sw	r5, 1(r1)
	j	beq_cont.16861
beq_then.16860:
	addi	r5, r0, 2
	addi	r1, r0, -1
	sw	r1, 9(r3)
	add	r2, r0, r1
	add	r1, r0, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 7(r3)
	lw	r6, 6(r3)
beq_cont.16861:
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.16859
beq_then.16858:
	addi	r2, r0, 1
	addi	r1, r0, -1
	sw	r2, 10(r3)
	add	r28, r0, r2
	add	r2, r0, r1
	add	r1, r0, r28
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1
	lw	r6, 6(r3)
beq_cont.16859:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.16862
	addi	r1, r0, 1
	sw	r2, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	read_or_network.3004				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 10(r3)
	lw	r6, 6(r3)
	sw	r2, 0(r1)
	j	beq_cont.16863
beq_then.16862:
	addi	r1, r0, 1
	sw	r1, 11(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_array				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r6, 6(r3)
beq_cont.16863:
	sw	r1, 0(r6)
	jr	r31				#
solver_rect_surface.3010:
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16865
	addi	r8, r0, 1
	j	feq_cont.16866
feq_else.16865:
	addi	r8, r0, 0
feq_cont.16866:
	beqi	0, r8, beq_then.16867
	addi	r1, r0, 0
	jr	r31				#
beq_then.16867:
	lw	r8, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16868
	addi	r9, r0, 0
	j	fle_cont.16869
fle_else.16868:
	addi	r9, r0, 1
fle_cont.16869:
	beqi	0, r1, beq_then.16870
	beqi	0, r9, beq_then.16872
	addi	r1, r0, 0
	j	beq_cont.16873
beq_then.16872:
	addi	r1, r0, 1
beq_cont.16873:
	j	beq_cont.16871
beq_then.16870:
	add	r1, r0, r9
beq_cont.16871:
	add	r30, r8, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.16874
	j	beq_cont.16875
beq_then.16874:
	fneg	f4, f4
beq_cont.16875:
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
	beq	r0, r30, fle_else.16876
	j	fle_cont.16877
fle_else.16876:
	fneg	f2, f2
fle_cont.16877:
	fle	r30, f5, f2
	beq	r0, r30, fle_else.16878
	addi	r1, r0, 0
	jr	r31				#
fle_else.16878:
	add	r30, r8, r7
	flw	f4, 0(r30)
	add	r30, r2, r7
	flw	f2, 0(r30)
	fmul	f2, f1, f2
	fadd	f2, f2, f3
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16879
	j	fle_cont.16880
fle_else.16879:
	fneg	f2, f2
fle_cont.16880:
	fle	r30, f4, f2
	beq	r0, r30, fle_else.16881
	addi	r1, r0, 0
	jr	r31				#
fle_else.16881:
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
	beqi	0, r5, beq_then.16882
	addi	r1, r0, 1
	jr	r31				#
beq_then.16882:
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
	beqi	0, r5, beq_then.16883
	addi	r1, r0, 2
	jr	r31				#
beq_then.16883:
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
	beqi	0, r1, beq_then.16884
	addi	r1, r0, 3
	jr	r31				#
beq_then.16884:
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
	beq	r0, r30, fle_else.16885
	addi	r2, r0, 0
	j	fle_cont.16886
fle_else.16885:
	addi	r2, r0, 1
fle_cont.16886:
	beqi	0, r2, beq_then.16887
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
beq_then.16887:
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
	beqi	0, r2, beq_then.16888
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
beq_then.16888:
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
	beqi	0, r2, beq_then.16889
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
beq_then.16889:
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
	beq	r0, r30, feq_else.16890
	addi	r5, r0, 1
	j	feq_cont.16891
feq_else.16890:
	addi	r5, r0, 0
feq_cont.16891:
	beqi	0, r5, beq_then.16892
	addi	r1, r0, 0
	jr	r31				#
beq_then.16892:
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
	beqi	3, r2, beq_then.16893
	j	beq_cont.16894
beq_then.16893:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16894:
	fmul	f2, f4, f4
	fmul	f1, f5, f1
	fsub	f1, f2, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16895
	addi	r2, r0, 0
	j	fle_cont.16896
fle_else.16895:
	addi	r2, r0, 1
fle_cont.16896:
	beqi	0, r2, beq_then.16897
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16898
	j	beq_cont.16899
beq_then.16898:
	fneg	f1, f1
beq_cont.16899:
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsub	f1, f1, f4
	finv	f31, f5
	fmul	f1, f1, f31
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16897:
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
	beqi	1, r1, beq_then.16900
	beqi	2, r1, beq_then.16901
	add	r1, r0, r6
	fadd	f1, f0, f4
	j	solver_second.3044
beq_then.16901:
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
	beq	r0, r30, fle_else.16902
	addi	r2, r0, 0
	j	fle_cont.16903
fle_else.16902:
	addi	r2, r0, 1
fle_cont.16903:
	beqi	0, r2, beq_then.16904
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
beq_then.16904:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16900:
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
	beqi	0, r1, beq_then.16905
	addi	r1, r0, 1
	jr	r31				#
beq_then.16905:
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
	beqi	0, r1, beq_then.16906
	addi	r1, r0, 2
	jr	r31				#
beq_then.16906:
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
	beqi	0, r1, beq_then.16907
	addi	r1, r0, 3
	jr	r31				#
beq_then.16907:
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
	beq	r0, r30, fle_else.16908
	j	fle_cont.16909
fle_else.16908:
	fneg	f5, f5
fle_cont.16909:
	fle	r30, f6, f5
	beq	r0, r30, fle_else.16910
	addi	r6, r0, 0
	j	fle_cont.16911
fle_else.16910:
	lw	r6, 4(r1)
	flw	f6, 2(r6)
	flw	f5, 2(r2)
	fmul	f5, f4, f5
	fadd	f5, f5, f3
	fle	r30, f0, f5
	beq	r0, r30, fle_else.16912
	j	fle_cont.16913
fle_else.16912:
	fneg	f5, f5
fle_cont.16913:
	fle	r30, f6, f5
	beq	r0, r30, fle_else.16914
	addi	r6, r0, 0
	j	fle_cont.16915
fle_else.16914:
	flw	f5, 1(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16916
	addi	r6, r0, 1
	j	feq_cont.16917
feq_else.16916:
	addi	r6, r0, 0
feq_cont.16917:
	beqi	0, r6, beq_then.16918
	addi	r6, r0, 0
	j	beq_cont.16919
beq_then.16918:
	addi	r6, r0, 1
beq_cont.16919:
fle_cont.16915:
fle_cont.16911:
	beqi	0, r6, beq_then.16920
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsw	f4, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16920:
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
	beq	r0, r30, fle_else.16921
	j	fle_cont.16922
fle_else.16921:
	fneg	f5, f5
fle_cont.16922:
	fle	r30, f6, f5
	beq	r0, r30, fle_else.16923
	addi	r6, r0, 0
	j	fle_cont.16924
fle_else.16923:
	lw	r6, 4(r1)
	flw	f6, 2(r6)
	flw	f5, 2(r2)
	fmul	f5, f4, f5
	fadd	f5, f5, f3
	fle	r30, f0, f5
	beq	r0, r30, fle_else.16925
	j	fle_cont.16926
fle_else.16925:
	fneg	f5, f5
fle_cont.16926:
	fle	r30, f6, f5
	beq	r0, r30, fle_else.16927
	addi	r6, r0, 0
	j	fle_cont.16928
fle_else.16927:
	flw	f5, 3(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16929
	addi	r6, r0, 1
	j	feq_cont.16930
feq_else.16929:
	addi	r6, r0, 0
feq_cont.16930:
	beqi	0, r6, beq_then.16931
	addi	r6, r0, 0
	j	beq_cont.16932
beq_then.16931:
	addi	r6, r0, 1
beq_cont.16932:
fle_cont.16928:
fle_cont.16924:
	beqi	0, r6, beq_then.16933
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsw	f4, 0(r1)
	addi	r1, r0, 2
	jr	r31				#
beq_then.16933:
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
	beq	r0, r30, fle_else.16934
	j	fle_cont.16935
fle_else.16934:
	fneg	f1, f1
fle_cont.16935:
	fle	r30, f5, f1
	beq	r0, r30, fle_else.16936
	addi	r1, r0, 0
	j	fle_cont.16937
fle_else.16936:
	lw	r1, 4(r1)
	flw	f4, 1(r1)
	flw	f1, 1(r2)
	fmul	f1, f3, f1
	fadd	f1, f1, f2
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16938
	j	fle_cont.16939
fle_else.16938:
	fneg	f1, f1
fle_cont.16939:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16940
	addi	r1, r0, 0
	j	fle_cont.16941
fle_else.16940:
	flw	f1, 5(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16942
	addi	r1, r0, 1
	j	feq_cont.16943
feq_else.16942:
	addi	r1, r0, 0
feq_cont.16943:
	beqi	0, r1, beq_then.16944
	addi	r1, r0, 0
	j	beq_cont.16945
beq_then.16944:
	addi	r1, r0, 1
beq_cont.16945:
fle_cont.16941:
fle_cont.16937:
	beqi	0, r1, beq_then.16946
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsw	f3, 0(r1)
	addi	r1, r0, 3
	jr	r31				#
beq_then.16946:
	addi	r1, r0, 0
	jr	r31				#
solver_surface_fast.3061:
	flw	f4, 0(r2)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16947
	addi	r1, r0, 0
	j	fle_cont.16948
fle_else.16947:
	addi	r1, r0, 1
fle_cont.16948:
	beqi	0, r1, beq_then.16949
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
beq_then.16949:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3067:
	flw	f5, 0(r2)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16950
	addi	r5, r0, 1
	j	feq_cont.16951
feq_else.16950:
	addi	r5, r0, 0
feq_cont.16951:
	beqi	0, r5, beq_then.16952
	addi	r1, r0, 0
	jr	r31				#
beq_then.16952:
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
	beqi	3, r5, beq_then.16953
	j	beq_cont.16954
beq_then.16953:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16954:
	fmul	f2, f4, f4
	fmul	f1, f5, f1
	fsub	f1, f2, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16955
	addi	r5, r0, 0
	j	fle_cont.16956
fle_else.16955:
	addi	r5, r0, 1
fle_cont.16956:
	beqi	0, r5, beq_then.16957
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16958
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsqrt	f1, f1
	fadd	f2, f4, f1
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	j	beq_cont.16959
beq_then.16958:
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsqrt	f1, f1
	fsub	f2, f4, f1
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
beq_cont.16959:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16957:
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
	beqi	1, r1, beq_then.16960
	beqi	2, r1, beq_then.16961
	add	r2, r0, r5
	add	r1, r0, r7
	j	solver_second_fast.3067
beq_then.16961:
	flw	f4, 0(r5)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16962
	addi	r1, r0, 0
	j	fle_cont.16963
fle_else.16962:
	addi	r1, r0, 1
fle_cont.16963:
	beqi	0, r1, beq_then.16964
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
beq_then.16964:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16960:
	lw	r2, 0(r2)
	add	r1, r0, r7
	j	solver_rect_fast.3054
solver_surface_fast2.3077:
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16965
	addi	r1, r0, 0
	j	fle_cont.16966
fle_else.16965:
	addi	r1, r0, 1
fle_cont.16966:
	beqi	0, r1, beq_then.16967
	addi	r1, r0, 724				# set min_caml_solver_dist
	flw	f2, 0(r2)
	flw	f1, 3(r5)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16967:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3084:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16968
	addi	r6, r0, 1
	j	feq_cont.16969
feq_else.16968:
	addi	r6, r0, 0
feq_cont.16969:
	beqi	0, r6, beq_then.16970
	addi	r1, r0, 0
	jr	r31				#
beq_then.16970:
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
	beq	r0, r30, fle_else.16971
	addi	r5, r0, 0
	j	fle_cont.16972
fle_else.16971:
	addi	r5, r0, 1
fle_cont.16972:
	beqi	0, r5, beq_then.16973
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16974
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsqrt	f2, f2
	fadd	f2, f1, f2
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	j	beq_cont.16975
beq_then.16974:
	addi	r1, r0, 724				# set min_caml_solver_dist
	fsqrt	f2, f2
	fsub	f2, f1, f2
	flw	f1, 4(r2)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
beq_cont.16975:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16973:
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
	beqi	1, r1, beq_then.16976
	beqi	2, r1, beq_then.16977
	add	r2, r0, r6
	add	r1, r0, r7
	j	solver_second_fast2.3084
beq_then.16977:
	flw	f1, 0(r6)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16978
	addi	r1, r0, 0
	j	fle_cont.16979
fle_else.16978:
	addi	r1, r0, 1
fle_cont.16979:
	beqi	0, r1, beq_then.16980
	addi	r1, r0, 724				# set min_caml_solver_dist
	flw	f2, 0(r6)
	flw	f1, 3(r5)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16980:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16976:
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
	beq	r0, r30, feq_else.16981
	addi	r5, r0, 1
	j	feq_cont.16982
feq_else.16981:
	addi	r5, r0, 0
feq_cont.16982:
	beqi	0, r5, beq_then.16983
	fsw	f0, 1(r6)
	j	beq_cont.16984
beq_then.16983:
	lw	r5, 6(r2)
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16985
	addi	r7, r0, 0
	j	fle_cont.16986
fle_else.16985:
	addi	r7, r0, 1
fle_cont.16986:
	beqi	0, r5, beq_then.16987
	beqi	0, r7, beq_then.16989
	addi	r7, r0, 0
	j	beq_cont.16990
beq_then.16989:
	addi	r7, r0, 1
beq_cont.16990:
	j	beq_cont.16988
beq_then.16987:
beq_cont.16988:
	lw	r5, 4(r2)
	flw	f1, 0(r5)
	beqi	0, r7, beq_then.16991
	j	beq_cont.16992
beq_then.16991:
	fneg	f1, f1
beq_cont.16992:
	fsw	f1, 0(r6)
	flup	f2, 2		# fli	f2, 1.000000
	flw	f1, 0(r1)
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 1(r6)
beq_cont.16984:
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16993
	addi	r5, r0, 1
	j	feq_cont.16994
feq_else.16993:
	addi	r5, r0, 0
feq_cont.16994:
	beqi	0, r5, beq_then.16995
	fsw	f0, 3(r6)
	j	beq_cont.16996
beq_then.16995:
	lw	r5, 6(r2)
	flw	f1, 1(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16997
	addi	r7, r0, 0
	j	fle_cont.16998
fle_else.16997:
	addi	r7, r0, 1
fle_cont.16998:
	beqi	0, r5, beq_then.16999
	beqi	0, r7, beq_then.17001
	addi	r7, r0, 0
	j	beq_cont.17002
beq_then.17001:
	addi	r7, r0, 1
beq_cont.17002:
	j	beq_cont.17000
beq_then.16999:
beq_cont.17000:
	lw	r5, 4(r2)
	flw	f1, 1(r5)
	beqi	0, r7, beq_then.17003
	j	beq_cont.17004
beq_then.17003:
	fneg	f1, f1
beq_cont.17004:
	fsw	f1, 2(r6)
	flup	f2, 2		# fli	f2, 1.000000
	flw	f1, 1(r1)
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 3(r6)
beq_cont.16996:
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17005
	addi	r5, r0, 1
	j	feq_cont.17006
feq_else.17005:
	addi	r5, r0, 0
feq_cont.17006:
	beqi	0, r5, beq_then.17007
	fsw	f0, 5(r6)
	j	beq_cont.17008
beq_then.17007:
	lw	r5, 6(r2)
	flw	f1, 2(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17009
	addi	r7, r0, 0
	j	fle_cont.17010
fle_else.17009:
	addi	r7, r0, 1
fle_cont.17010:
	beqi	0, r5, beq_then.17011
	beqi	0, r7, beq_then.17013
	addi	r5, r0, 0
	j	beq_cont.17014
beq_then.17013:
	addi	r5, r0, 1
beq_cont.17014:
	j	beq_cont.17012
beq_then.17011:
	add	r5, r0, r7
beq_cont.17012:
	lw	r2, 4(r2)
	flw	f1, 2(r2)
	beqi	0, r5, beq_then.17015
	j	beq_cont.17016
beq_then.17015:
	fneg	f1, f1
beq_cont.17016:
	fsw	f1, 4(r6)
	flup	f2, 2		# fli	f2, 1.000000
	flw	f1, 2(r1)
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 5(r6)
beq_cont.17008:
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
	beq	r0, r30, fle_else.17017
	addi	r1, r0, 0
	j	fle_cont.17018
fle_else.17017:
	addi	r1, r0, 1
fle_cont.17018:
	beqi	0, r1, beq_then.17019
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
	j	beq_cont.17020
beq_then.17019:
	fsw	f0, 0(r6)
beq_cont.17020:
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
	beqi	0, r5, beq_then.17021
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
	j	beq_cont.17022
beq_then.17021:
	fsw	f3, 1(r6)
	fsw	f2, 2(r6)
	fsw	f1, 3(r6)
beq_cont.17022:
	feq	r30, f4, f0
	beq	r0, r30, feq_else.17023
	addi	r1, r0, 1
	j	feq_cont.17024
feq_else.17023:
	addi	r1, r0, 0
feq_cont.17024:
	beqi	0, r1, beq_then.17025
	j	beq_cont.17026
beq_then.17025:
	flup	f1, 2		# fli	f1, 1.000000
	finv	f31, f4
	fmul	f1, f1, f31
	fsw	f1, 4(r6)
beq_cont.17026:
	add	r1, r0, r6
	jr	r31				#
iter_setup_dirvec_constants.3103:
	bgei	0, r2, bge_then.17027
	jr	r31				#
bge_then.17027:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r2
	lw	r8, 0(r30)
	lw	r7, 1(r1)
	lw	r5, 0(r1)
	lw	r6, 1(r8)
	beqi	1, r6, beq_then.17029
	beqi	2, r6, beq_then.17031
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
	j	beq_cont.17032
beq_then.17031:
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
beq_cont.17032:
	j	beq_cont.17030
beq_then.17029:
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
beq_cont.17030:
	addi	r8, r2, -1
	bgei	0, r8, bge_then.17033
	jr	r31				#
bge_then.17033:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r8
	lw	r7, 0(r30)
	lw	r6, 1(r1)
	lw	r2, 0(r1)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17035
	beqi	2, r5, beq_then.17037
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
	j	beq_cont.17038
beq_then.17037:
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
beq_cont.17038:
	j	beq_cont.17036
beq_then.17035:
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
beq_cont.17036:
	addi	r2, r8, -1
	j	iter_setup_dirvec_constants.3103
setup_dirvec_constants.3106:
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r2, 0(r2)
	addi	r8, r2, -1
	bgei	0, r8, bge_then.17039
	jr	r31				#
bge_then.17039:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r8
	lw	r7, 0(r30)
	lw	r6, 1(r1)
	lw	r2, 0(r1)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17041
	beqi	2, r5, beq_then.17043
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
	j	beq_cont.17044
beq_then.17043:
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
beq_cont.17044:
	j	beq_cont.17042
beq_then.17041:
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
beq_cont.17042:
	addi	r2, r8, -1
	j	iter_setup_dirvec_constants.3103
setup_startp_constants.3108:
	bgei	0, r2, bge_then.17045
	jr	r31				#
bge_then.17045:
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
	beqi	2, r7, beq_then.17047
	blei	2, r7, ble_then.17049
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
	beqi	3, r7, beq_then.17051
	j	beq_cont.17052
beq_then.17051:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.17052:
	fsw	f1, 3(r8)
	j	ble_cont.17050
ble_then.17049:
ble_cont.17050:
	j	beq_cont.17048
beq_then.17047:
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
beq_cont.17048:
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
	beq	r0, r30, fle_else.17053
	j	fle_cont.17054
fle_else.17053:
	fneg	f1, f1
fle_cont.17054:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17055
	addi	r2, r0, 0
	j	fle_cont.17056
fle_else.17055:
	lw	r2, 4(r1)
	flw	f4, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.17057
	fadd	f1, f0, f2
	j	fle_cont.17058
fle_else.17057:
	fneg	f1, f2
fle_cont.17058:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17059
	addi	r2, r0, 0
	j	fle_cont.17060
fle_else.17059:
	lw	r2, 4(r1)
	flw	f2, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.17061
	fadd	f1, f0, f3
	j	fle_cont.17062
fle_else.17061:
	fneg	f1, f3
fle_cont.17062:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17063
	addi	r2, r0, 0
	j	fle_cont.17064
fle_else.17063:
	addi	r2, r0, 1
fle_cont.17064:
fle_cont.17060:
fle_cont.17056:
	beqi	0, r2, beq_then.17065
	lw	r1, 6(r1)
	jr	r31				#
beq_then.17065:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.17066
	addi	r1, r0, 0
	jr	r31				#
beq_then.17066:
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
	beq	r0, r30, fle_else.17067
	addi	r2, r0, 0
	j	fle_cont.17068
fle_else.17067:
	addi	r2, r0, 1
fle_cont.17068:
	beqi	0, r1, beq_then.17069
	beqi	0, r2, beq_then.17071
	addi	r1, r0, 0
	j	beq_cont.17072
beq_then.17071:
	addi	r1, r0, 1
beq_cont.17072:
	j	beq_cont.17070
beq_then.17069:
	add	r1, r0, r2
beq_cont.17070:
	beqi	0, r1, beq_then.17073
	addi	r1, r0, 0
	jr	r31				#
beq_then.17073:
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
	beqi	3, r2, beq_then.17074
	j	beq_cont.17075
beq_then.17074:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.17075:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17076
	addi	r2, r0, 0
	j	fle_cont.17077
fle_else.17076:
	addi	r2, r0, 1
fle_cont.17077:
	beqi	0, r1, beq_then.17078
	beqi	0, r2, beq_then.17080
	addi	r1, r0, 0
	j	beq_cont.17081
beq_then.17080:
	addi	r1, r0, 1
beq_cont.17081:
	j	beq_cont.17079
beq_then.17078:
	add	r1, r0, r2
beq_cont.17079:
	beqi	0, r1, beq_then.17082
	addi	r1, r0, 0
	jr	r31				#
beq_then.17082:
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
	beqi	1, r2, beq_then.17083
	beqi	2, r2, beq_then.17084
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3031				
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.17085
	j	beq_cont.17086
beq_then.17085:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.17086:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17087
	addi	r2, r0, 0
	j	fle_cont.17088
fle_else.17087:
	addi	r2, r0, 1
fle_cont.17088:
	beqi	0, r1, beq_then.17089
	beqi	0, r2, beq_then.17091
	addi	r1, r0, 0
	j	beq_cont.17092
beq_then.17091:
	addi	r1, r0, 1
beq_cont.17092:
	j	beq_cont.17090
beq_then.17089:
	add	r1, r0, r2
beq_cont.17090:
	beqi	0, r1, beq_then.17093
	addi	r1, r0, 0
	jr	r31				#
beq_then.17093:
	addi	r1, r0, 1
	jr	r31				#
beq_then.17084:
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
	beq	r0, r30, fle_else.17094
	addi	r2, r0, 0
	j	fle_cont.17095
fle_else.17094:
	addi	r2, r0, 1
fle_cont.17095:
	beqi	0, r1, beq_then.17096
	beqi	0, r2, beq_then.17098
	addi	r1, r0, 0
	j	beq_cont.17099
beq_then.17098:
	addi	r1, r0, 1
beq_cont.17099:
	j	beq_cont.17097
beq_then.17096:
	add	r1, r0, r2
beq_cont.17097:
	beqi	0, r1, beq_then.17100
	addi	r1, r0, 0
	jr	r31				#
beq_then.17100:
	addi	r1, r0, 1
	jr	r31				#
beq_then.17083:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17101
	j	fle_cont.17102
fle_else.17101:
	fneg	f1, f1
fle_cont.17102:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17103
	addi	r2, r0, 0
	j	fle_cont.17104
fle_else.17103:
	lw	r2, 4(r1)
	flw	f4, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.17105
	fadd	f1, f0, f2
	j	fle_cont.17106
fle_else.17105:
	fneg	f1, f2
fle_cont.17106:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17107
	addi	r2, r0, 0
	j	fle_cont.17108
fle_else.17107:
	lw	r2, 4(r1)
	flw	f2, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.17109
	fadd	f1, f0, f3
	j	fle_cont.17110
fle_else.17109:
	fneg	f1, f3
fle_cont.17110:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17111
	addi	r2, r0, 0
	j	fle_cont.17112
fle_else.17111:
	addi	r2, r0, 1
fle_cont.17112:
fle_cont.17108:
fle_cont.17104:
	beqi	0, r2, beq_then.17113
	lw	r1, 6(r1)
	jr	r31				#
beq_then.17113:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.17114
	addi	r1, r0, 0
	jr	r31				#
beq_then.17114:
	addi	r1, r0, 1
	jr	r31				#
check_all_inside.3133:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.17115
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
	beqi	1, r5, beq_then.17116
	beqi	2, r5, beq_then.17118
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
	beqi	3, r5, beq_then.17120
	j	beq_cont.17121
beq_then.17120:
	flup	f5, 2		# fli	f5, 1.000000
	fsub	f4, f4, f5
beq_cont.17121:
	lw	r5, 6(r6)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.17122
	addi	r6, r0, 0
	j	fle_cont.17123
fle_else.17122:
	addi	r6, r0, 1
fle_cont.17123:
	beqi	0, r5, beq_then.17124
	beqi	0, r6, beq_then.17126
	addi	r5, r0, 0
	j	beq_cont.17127
beq_then.17126:
	addi	r5, r0, 1
beq_cont.17127:
	j	beq_cont.17125
beq_then.17124:
	add	r5, r0, r6
beq_cont.17125:
	beqi	0, r5, beq_then.17128
	addi	r5, r0, 0
	j	beq_cont.17129
beq_then.17128:
	addi	r5, r0, 1
beq_cont.17129:
	j	beq_cont.17119
beq_then.17118:
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
	beq	r0, r30, fle_else.17130
	addi	r6, r0, 0
	j	fle_cont.17131
fle_else.17130:
	addi	r6, r0, 1
fle_cont.17131:
	beqi	0, r5, beq_then.17132
	beqi	0, r6, beq_then.17134
	addi	r5, r0, 0
	j	beq_cont.17135
beq_then.17134:
	addi	r5, r0, 1
beq_cont.17135:
	j	beq_cont.17133
beq_then.17132:
	add	r5, r0, r6
beq_cont.17133:
	beqi	0, r5, beq_then.17136
	addi	r5, r0, 0
	j	beq_cont.17137
beq_then.17136:
	addi	r5, r0, 1
beq_cont.17137:
beq_cont.17119:
	j	beq_cont.17117
beq_then.17116:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r1, 6(r3)
	sw	r2, 7(r3)
	sw	r5, 9(r3)
	add	r1, r0, r6
	fadd	f3, f0, f4
	fadd	f2, f0, f5
	fadd	f1, f0, f6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	is_rect_outside.3113				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r5, r0, r1
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	lw	r1, 6(r3)
	lw	r2, 7(r3)
beq_cont.17117:
	beqi	0, r5, beq_then.17138
	addi	r1, r0, 0
	jr	r31				#
beq_then.17138:
	addi	r5, r1, 1
	add	r30, r2, r5
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.17139
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r1
	lw	r1, 0(r30)
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r2, 7(r3)
	sw	r5, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	is_outside.3128				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	flw	f3, 0(r3)
	flw	f2, 2(r3)
	flw	f1, 4(r3)
	lw	r2, 7(r3)
	lw	r5, 10(r3)
	beqi	0, r1, beq_then.17140
	addi	r1, r0, 0
	jr	r31				#
beq_then.17140:
	addi	r1, r5, 1
	j	check_all_inside.3133
beq_then.17139:
	addi	r1, r0, 1
	jr	r31				#
beq_then.17115:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3139:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.17141
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
	beqi	1, r5, beq_then.17142
	beqi	2, r5, beq_then.17144
	sw	r5, 0(r3)
	sw	r6, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	add	r2, r0, r8
	add	r1, r0, r7
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second_fast.3067				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r5, r0, r1
	lw	r6, 1(r3)
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	j	beq_cont.17145
beq_then.17144:
	flw	f4, 0(r8)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.17146
	addi	r5, r0, 0
	j	fle_cont.17147
fle_else.17146:
	addi	r5, r0, 1
fle_cont.17147:
	beqi	0, r5, beq_then.17148
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
	j	beq_cont.17149
beq_then.17148:
	addi	r5, r0, 0
beq_cont.17149:
beq_cont.17145:
	j	beq_cont.17143
beq_then.17142:
	lw	r5, 0(r9)
	sw	r5, 0(r3)
	sw	r6, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	add	r5, r0, r8
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_rect_fast.3054				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r5, r0, r1
	lw	r6, 1(r3)
	lw	r1, 2(r3)
	lw	r2, 3(r3)
beq_cont.17143:
	addi	r7, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r7)
	beqi	0, r5, beq_then.17150
	flup	f2, 28		# fli	f2, -0.200000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17152
	addi	r5, r0, 0
	j	fle_cont.17153
fle_else.17152:
	addi	r5, r0, 1
fle_cont.17153:
	j	beq_cont.17151
beq_then.17150:
	addi	r5, r0, 0
beq_cont.17151:
	beqi	0, r5, beq_then.17154
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
	beqi	-1, r5, beq_then.17155
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r5
	lw	r5, 0(r30)
	fsw	f3, 4(r3)
	fsw	f2, 6(r3)
	fsw	f4, 8(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
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
	lw	r1, 2(r3)
	lw	r2, 3(r3)
	beqi	0, r5, beq_then.17157
	addi	r5, r0, 0
	j	beq_cont.17158
beq_then.17157:
	addi	r5, r0, 1
	sw	r5, 10(r3)
	add	r1, r0, r5
	fadd	f1, f0, f4
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	check_all_inside.3133				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r5, r0, r1
	lw	r1, 2(r3)
	lw	r2, 3(r3)
beq_cont.17158:
	j	beq_cont.17156
beq_then.17155:
	addi	r5, r0, 1
beq_cont.17156:
	beqi	0, r5, beq_then.17159
	addi	r1, r0, 1
	jr	r31				#
beq_then.17159:
	addi	r1, r1, 1
	j	shadow_check_and_group.3139
beq_then.17154:
	addi	r5, r0, 1				# set min_caml_objects
	add	r30, r5, r6
	lw	r5, 0(r30)
	lw	r5, 6(r5)
	beqi	0, r5, beq_then.17160
	addi	r1, r1, 1
	j	shadow_check_and_group.3139
beq_then.17160:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17141:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3142:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.17161
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
	beqi	0, r5, beq_then.17162
	addi	r1, r0, 1
	jr	r31				#
beq_then.17162:
	addi	r5, r1, 1
	add	r30, r2, r5
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.17163
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
	beqi	0, r1, beq_then.17164
	addi	r1, r0, 1
	jr	r31				#
beq_then.17164:
	addi	r5, r5, 1
	add	r30, r2, r5
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.17165
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
	beqi	0, r1, beq_then.17166
	addi	r1, r0, 1
	jr	r31				#
beq_then.17166:
	addi	r5, r5, 1
	add	r30, r2, r5
	lw	r1, 0(r30)
	beqi	-1, r1, beq_then.17167
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
	beqi	0, r1, beq_then.17168
	addi	r1, r0, 1
	jr	r31				#
beq_then.17168:
	addi	r1, r5, 1
	j	shadow_check_one_or_group.3142
beq_then.17167:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17165:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17163:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17161:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3145:
	add	r30, r2, r1
	lw	r8, 0(r30)
	lw	r5, 0(r8)
	beqi	-1, r5, beq_then.17169
	addi	r6, r0, 99
	beq	r5, r6, beq_then.17170
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
	beqi	1, r5, beq_then.17172
	beqi	2, r5, beq_then.17174
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r8, 3(r3)
	add	r2, r0, r6
	add	r1, r0, r7
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second_fast.3067				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r5, r0, r1
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	j	beq_cont.17175
beq_then.17174:
	flw	f4, 0(r6)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.17176
	addi	r5, r0, 0
	j	fle_cont.17177
fle_else.17176:
	addi	r5, r0, 1
fle_cont.17177:
	beqi	0, r5, beq_then.17178
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
	j	beq_cont.17179
beq_then.17178:
	addi	r5, r0, 0
beq_cont.17179:
beq_cont.17175:
	j	beq_cont.17173
beq_then.17172:
	lw	r5, 0(r9)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r8, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	add	r5, r0, r6
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_rect_fast.3054				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r5, r0, r1
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
beq_cont.17173:
	beqi	0, r5, beq_then.17180
	flup	f2, 30		# fli	f2, -0.100000
	addi	r5, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r5)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17182
	addi	r5, r0, 0
	j	fle_cont.17183
fle_else.17182:
	lw	r5, 1(r8)
	beqi	-1, r5, beq_then.17184
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r8, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r5, r0, r1
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	beqi	0, r5, beq_then.17186
	addi	r5, r0, 1
	j	beq_cont.17187
beq_then.17186:
	lw	r5, 2(r8)
	beqi	-1, r5, beq_then.17188
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r5, r0, r1
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	beqi	0, r5, beq_then.17190
	addi	r5, r0, 1
	j	beq_cont.17191
beq_then.17190:
	lw	r5, 3(r8)
	beqi	-1, r5, beq_then.17192
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r5, r0, r1
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	beqi	0, r5, beq_then.17194
	addi	r5, r0, 1
	j	beq_cont.17195
beq_then.17194:
	addi	r5, r0, 4
	sw	r5, 4(r3)
	add	r2, r0, r8
	add	r1, r0, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	shadow_check_one_or_group.3142				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r5, r0, r1
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
beq_cont.17195:
	j	beq_cont.17193
beq_then.17192:
	addi	r5, r0, 0
beq_cont.17193:
beq_cont.17191:
	j	beq_cont.17189
beq_then.17188:
	addi	r5, r0, 0
beq_cont.17189:
beq_cont.17187:
	j	beq_cont.17185
beq_then.17184:
	addi	r5, r0, 0
beq_cont.17185:
	beqi	0, r5, beq_then.17196
	addi	r5, r0, 1
	j	beq_cont.17197
beq_then.17196:
	addi	r5, r0, 0
beq_cont.17197:
fle_cont.17183:
	j	beq_cont.17181
beq_then.17180:
	addi	r5, r0, 0
beq_cont.17181:
	j	beq_cont.17171
beq_then.17170:
	addi	r5, r0, 1
beq_cont.17171:
	beqi	0, r5, beq_then.17198
	lw	r5, 1(r8)
	beqi	-1, r5, beq_then.17199
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r8, 3(r3)
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r5, r0, r1
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	beqi	0, r5, beq_then.17201
	addi	r5, r0, 1
	j	beq_cont.17202
beq_then.17201:
	lw	r5, 2(r8)
	beqi	-1, r5, beq_then.17203
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r5, r0, r1
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	beqi	0, r5, beq_then.17205
	addi	r5, r0, 1
	j	beq_cont.17206
beq_then.17205:
	lw	r5, 3(r8)
	beqi	-1, r5, beq_then.17207
	addi	r6, r0, 672				# set min_caml_and_net
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	add	r2, r0, r5
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	shadow_check_and_group.3139				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r5, r0, r1
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	beqi	0, r5, beq_then.17209
	addi	r5, r0, 1
	j	beq_cont.17210
beq_then.17209:
	addi	r5, r0, 4
	sw	r5, 5(r3)
	add	r2, r0, r8
	add	r1, r0, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	shadow_check_one_or_group.3142				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r5, r0, r1
	lw	r2, 1(r3)
	lw	r1, 2(r3)
beq_cont.17210:
	j	beq_cont.17208
beq_then.17207:
	addi	r5, r0, 0
beq_cont.17208:
beq_cont.17206:
	j	beq_cont.17204
beq_then.17203:
	addi	r5, r0, 0
beq_cont.17204:
beq_cont.17202:
	j	beq_cont.17200
beq_then.17199:
	addi	r5, r0, 0
beq_cont.17200:
	beqi	0, r5, beq_then.17211
	addi	r1, r0, 1
	jr	r31				#
beq_then.17211:
	addi	r1, r1, 1
	j	shadow_check_one_or_matrix.3145
beq_then.17198:
	addi	r1, r1, 1
	j	shadow_check_one_or_matrix.3145
beq_then.17169:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3148:
	add	r30, r2, r1
	lw	r8, 0(r30)
	beqi	-1, r8, beq_then.17212
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
	beqi	1, r6, beq_then.17213
	beqi	2, r6, beq_then.17215
	sw	r6, 0(r3)
	sw	r8, 1(r3)
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_second.3044				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r6, r0, r1
	lw	r8, 1(r3)
	lw	r1, 2(r3)
	lw	r5, 3(r3)
	lw	r2, 4(r3)
	j	beq_cont.17216
beq_then.17215:
	sw	r6, 0(r3)
	sw	r8, 1(r3)
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_surface.3025				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r6, r0, r1
	lw	r8, 1(r3)
	lw	r1, 2(r3)
	lw	r5, 3(r3)
	lw	r2, 4(r3)
beq_cont.17216:
	j	beq_cont.17214
beq_then.17213:
	addi	r10, r0, 0
	addi	r9, r0, 1
	addi	r6, r0, 2
	fsw	f3, 6(r3)
	fsw	f2, 8(r3)
	fsw	f1, 10(r3)
	sw	r7, 12(r3)
	sw	r8, 1(r3)
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	add	r7, r0, r6
	add	r5, r0, r10
	add	r6, r0, r9
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solver_rect_surface.3010				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r6, r0, r1
	flw	f3, 6(r3)
	flw	f2, 8(r3)
	flw	f1, 10(r3)
	lw	r7, 12(r3)
	lw	r8, 1(r3)
	lw	r1, 2(r3)
	lw	r5, 3(r3)
	lw	r2, 4(r3)
	beqi	0, r6, beq_then.17218
	addi	r6, r0, 1
	j	beq_cont.17219
beq_then.17218:
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
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solver_rect_surface.3010				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r6, r0, r1
	flw	f3, 6(r3)
	flw	f2, 8(r3)
	flw	f1, 10(r3)
	lw	r7, 12(r3)
	lw	r8, 1(r3)
	lw	r1, 2(r3)
	lw	r5, 3(r3)
	lw	r2, 4(r3)
	beqi	0, r6, beq_then.17220
	addi	r6, r0, 2
	j	beq_cont.17221
beq_then.17220:
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
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solver_rect_surface.3010				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r6, r0, r1
	lw	r8, 1(r3)
	lw	r1, 2(r3)
	lw	r5, 3(r3)
	lw	r2, 4(r3)
	beqi	0, r6, beq_then.17222
	addi	r6, r0, 3
	j	beq_cont.17223
beq_then.17222:
	addi	r6, r0, 0
beq_cont.17223:
beq_cont.17221:
beq_cont.17219:
beq_cont.17214:
	beqi	0, r6, beq_then.17224
	addi	r7, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r7)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17225
	j	fle_cont.17226
fle_else.17225:
	addi	r7, r0, 726				# set min_caml_tmin
	flw	f2, 0(r7)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17227
	j	fle_cont.17228
fle_else.17227:
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
	beqi	-1, r7, beq_then.17229
	addi	r9, r0, 1				# set min_caml_objects
	add	r30, r9, r7
	lw	r7, 0(r30)
	fsw	f1, 14(r3)
	fsw	f3, 16(r3)
	fsw	f2, 18(r3)
	fsw	f4, 20(r3)
	sw	r6, 0(r3)
	add	r1, r0, r7
	fadd	f1, f0, f4
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	is_outside.3128				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	add	r7, r0, r1
	flw	f1, 14(r3)
	flw	f3, 16(r3)
	flw	f2, 18(r3)
	flw	f4, 20(r3)
	lw	r6, 0(r3)
	lw	r8, 1(r3)
	lw	r1, 2(r3)
	lw	r5, 3(r3)
	lw	r2, 4(r3)
	beqi	0, r7, beq_then.17232
	addi	r7, r0, 0
	j	beq_cont.17233
beq_then.17232:
	addi	r7, r0, 1
	sw	r7, 22(r3)
	add	r1, r0, r7
	fadd	f1, f0, f4
	sw	r31, 23(r3)
	addi	r3, r3, 24
	jal	check_all_inside.3133				
	addi	r3, r3, -24
	lw	r31, 23(r3)
	add	r7, r0, r1
	flw	f1, 14(r3)
	flw	f3, 16(r3)
	flw	f2, 18(r3)
	flw	f4, 20(r3)
	lw	r6, 0(r3)
	lw	r8, 1(r3)
	lw	r1, 2(r3)
	lw	r5, 3(r3)
	lw	r2, 4(r3)
beq_cont.17233:
	j	beq_cont.17230
beq_then.17229:
	addi	r7, r0, 1
beq_cont.17230:
	beqi	0, r7, beq_then.17234
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
	j	beq_cont.17235
beq_then.17234:
beq_cont.17235:
fle_cont.17228:
fle_cont.17226:
	addi	r1, r1, 1
	j	solve_each_element.3148
beq_then.17224:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r8
	lw	r6, 0(r30)
	lw	r6, 6(r6)
	beqi	0, r6, beq_then.17236
	addi	r1, r1, 1
	j	solve_each_element.3148
beq_then.17236:
	jr	r31				#
beq_then.17212:
	jr	r31				#
solve_one_or_network.3152:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.17239
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
	beqi	-1, r1, beq_then.17240
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
	beqi	-1, r1, beq_then.17241
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
	beqi	-1, r1, beq_then.17242
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
beq_then.17242:
	jr	r31				#
beq_then.17241:
	jr	r31				#
beq_then.17240:
	jr	r31				#
beq_then.17239:
	jr	r31				#
trace_or_matrix.3156:
	add	r30, r2, r1
	lw	r8, 0(r30)
	lw	r6, 0(r8)
	beqi	-1, r6, beq_then.17247
	addi	r7, r0, 99
	beq	r6, r7, beq_then.17248
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
	beqi	1, r6, beq_then.17250
	beqi	2, r6, beq_then.17252
	sw	r6, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r8, 3(r3)
	sw	r5, 4(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_second.3044				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r6, r0, r1
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	lw	r5, 4(r3)
	j	beq_cont.17253
beq_then.17252:
	sw	r6, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r8, 3(r3)
	sw	r5, 4(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_surface.3025				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	add	r6, r0, r1
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	lw	r5, 4(r3)
beq_cont.17253:
	j	beq_cont.17251
beq_then.17250:
	addi	r10, r0, 0
	addi	r9, r0, 1
	addi	r6, r0, 2
	fsw	f3, 6(r3)
	fsw	f2, 8(r3)
	fsw	f1, 10(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r7, 12(r3)
	sw	r8, 3(r3)
	sw	r5, 4(r3)
	add	r2, r0, r5
	add	r1, r0, r7
	add	r7, r0, r6
	add	r5, r0, r10
	add	r6, r0, r9
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solver_rect_surface.3010				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r6, r0, r1
	flw	f3, 6(r3)
	flw	f2, 8(r3)
	flw	f1, 10(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r7, 12(r3)
	lw	r8, 3(r3)
	lw	r5, 4(r3)
	beqi	0, r6, beq_then.17255
	addi	r6, r0, 1
	j	beq_cont.17256
beq_then.17255:
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
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solver_rect_surface.3010				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r6, r0, r1
	flw	f3, 6(r3)
	flw	f2, 8(r3)
	flw	f1, 10(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r7, 12(r3)
	lw	r8, 3(r3)
	lw	r5, 4(r3)
	beqi	0, r6, beq_then.17257
	addi	r6, r0, 2
	j	beq_cont.17258
beq_then.17257:
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
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solver_rect_surface.3010				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	add	r6, r0, r1
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	lw	r5, 4(r3)
	beqi	0, r6, beq_then.17259
	addi	r6, r0, 3
	j	beq_cont.17260
beq_then.17259:
	addi	r6, r0, 0
beq_cont.17260:
beq_cont.17258:
beq_cont.17256:
beq_cont.17251:
	beqi	0, r6, beq_then.17261
	addi	r6, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r6)
	addi	r6, r0, 726				# set min_caml_tmin
	flw	f2, 0(r6)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17263
	j	fle_cont.17264
fle_else.17263:
	lw	r6, 1(r8)
	beqi	-1, r6, beq_then.17265
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	lw	r5, 4(r3)
	lw	r6, 2(r8)
	beqi	-1, r6, beq_then.17267
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	lw	r5, 4(r3)
	lw	r6, 3(r8)
	beqi	-1, r6, beq_then.17269
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	lw	r5, 4(r3)
	addi	r6, r0, 4
	add	r2, r0, r8
	add	r1, r0, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_one_or_network.3152				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r5, 4(r3)
	j	beq_cont.17270
beq_then.17269:
beq_cont.17270:
	j	beq_cont.17268
beq_then.17267:
beq_cont.17268:
	j	beq_cont.17266
beq_then.17265:
beq_cont.17266:
fle_cont.17264:
	j	beq_cont.17262
beq_then.17261:
beq_cont.17262:
	j	beq_cont.17249
beq_then.17248:
	lw	r6, 1(r8)
	beqi	-1, r6, beq_then.17271
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r8, 3(r3)
	sw	r5, 4(r3)
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	lw	r5, 4(r3)
	lw	r6, 2(r8)
	beqi	-1, r6, beq_then.17273
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	lw	r5, 4(r3)
	lw	r6, 3(r8)
	beqi	-1, r6, beq_then.17275
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3148				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r8, 3(r3)
	lw	r5, 4(r3)
	addi	r6, r0, 4
	add	r2, r0, r8
	add	r1, r0, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_one_or_network.3152				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r5, 4(r3)
	j	beq_cont.17276
beq_then.17275:
beq_cont.17276:
	j	beq_cont.17274
beq_then.17273:
beq_cont.17274:
	j	beq_cont.17272
beq_then.17271:
beq_cont.17272:
beq_cont.17249:
	addi	r8, r1, 1
	add	r30, r2, r8
	lw	r6, 0(r30)
	lw	r1, 0(r6)
	beqi	-1, r1, beq_then.17277
	addi	r7, r0, 99
	beq	r1, r7, beq_then.17278
	addi	r7, r0, 748				# set min_caml_startp
	sw	r2, 1(r3)
	sw	r6, 13(r3)
	sw	r5, 4(r3)
	sw	r8, 14(r3)
	add	r2, r0, r5
	add	r5, r0, r7
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	solver.3050				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 1(r3)
	lw	r6, 13(r3)
	lw	r5, 4(r3)
	lw	r8, 14(r3)
	beqi	0, r1, beq_then.17280
	addi	r1, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r1)
	addi	r1, r0, 726				# set min_caml_tmin
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17282
	j	fle_cont.17283
fle_else.17282:
	lw	r1, 1(r6)
	beqi	-1, r1, beq_then.17284
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	solve_each_element.3148				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 1(r3)
	lw	r6, 13(r3)
	lw	r5, 4(r3)
	lw	r8, 14(r3)
	lw	r1, 2(r6)
	beqi	-1, r1, beq_then.17286
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	solve_each_element.3148				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 1(r3)
	lw	r6, 13(r3)
	lw	r5, 4(r3)
	lw	r8, 14(r3)
	addi	r1, r0, 3
	add	r2, r0, r6
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	solve_one_or_network.3152				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 1(r3)
	lw	r5, 4(r3)
	lw	r8, 14(r3)
	j	beq_cont.17287
beq_then.17286:
beq_cont.17287:
	j	beq_cont.17285
beq_then.17284:
beq_cont.17285:
fle_cont.17283:
	j	beq_cont.17281
beq_then.17280:
beq_cont.17281:
	j	beq_cont.17279
beq_then.17278:
	lw	r1, 1(r6)
	beqi	-1, r1, beq_then.17288
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	sw	r2, 1(r3)
	sw	r6, 13(r3)
	sw	r5, 4(r3)
	sw	r8, 14(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	solve_each_element.3148				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 1(r3)
	lw	r6, 13(r3)
	lw	r5, 4(r3)
	lw	r8, 14(r3)
	lw	r1, 2(r6)
	beqi	-1, r1, beq_then.17290
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	solve_each_element.3148				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 1(r3)
	lw	r6, 13(r3)
	lw	r5, 4(r3)
	lw	r8, 14(r3)
	addi	r1, r0, 3
	add	r2, r0, r6
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	solve_one_or_network.3152				
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r2, 1(r3)
	lw	r5, 4(r3)
	lw	r8, 14(r3)
	j	beq_cont.17291
beq_then.17290:
beq_cont.17291:
	j	beq_cont.17289
beq_then.17288:
beq_cont.17289:
beq_cont.17279:
	addi	r1, r8, 1
	j	trace_or_matrix.3156
beq_then.17277:
	jr	r31				#
beq_then.17247:
	jr	r31				#
judge_intersection.3160:
	addi	r2, r0, 726				# set min_caml_tmin
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r2)
	addi	r2, r0, 723				# set min_caml_or_net
	lw	r7, 0(r2)
	lw	r5, 0(r7)
	lw	r2, 0(r5)
	beqi	-1, r2, beq_then.17294
	addi	r6, r0, 99
	beq	r2, r6, beq_then.17296
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
	beqi	0, r2, beq_then.17298
	addi	r2, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r2)
	addi	r2, r0, 726				# set min_caml_tmin
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17300
	j	fle_cont.17301
fle_else.17300:
	lw	r2, 1(r5)
	beqi	-1, r2, beq_then.17302
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
	beqi	-1, r2, beq_then.17304
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
	j	beq_cont.17305
beq_then.17304:
beq_cont.17305:
	j	beq_cont.17303
beq_then.17302:
beq_cont.17303:
fle_cont.17301:
	j	beq_cont.17299
beq_then.17298:
beq_cont.17299:
	j	beq_cont.17297
beq_then.17296:
	lw	r2, 1(r5)
	beqi	-1, r2, beq_then.17306
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
	beqi	-1, r2, beq_then.17308
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
	j	beq_cont.17309
beq_then.17308:
beq_cont.17309:
	j	beq_cont.17307
beq_then.17306:
beq_cont.17307:
beq_cont.17297:
	addi	r2, r0, 1
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix.3156				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.17295
beq_then.17294:
beq_cont.17295:
	addi	r1, r0, 726				# set min_caml_tmin
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17310
	addi	r1, r0, 0
	jr	r31				#
fle_else.17310:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17311
	addi	r1, r0, 0
	jr	r31				#
fle_else.17311:
	addi	r1, r0, 1
	jr	r31				#
solve_each_element_fast.3162:
	lw	r7, 0(r5)
	add	r30, r2, r1
	lw	r10, 0(r30)
	beqi	-1, r10, beq_then.17312
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
	beqi	1, r6, beq_then.17313
	beqi	2, r6, beq_then.17315
	sw	r6, 0(r3)
	sw	r7, 1(r3)
	sw	r10, 2(r3)
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	sw	r2, 5(r3)
	add	r5, r0, r8
	add	r2, r0, r11
	add	r1, r0, r9
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solver_second_fast2.3084				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r6, r0, r1
	lw	r7, 1(r3)
	lw	r10, 2(r3)
	lw	r1, 3(r3)
	lw	r5, 4(r3)
	lw	r2, 5(r3)
	j	beq_cont.17316
beq_then.17315:
	flw	f1, 0(r11)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17317
	addi	r6, r0, 0
	j	fle_cont.17318
fle_else.17317:
	addi	r6, r0, 1
fle_cont.17318:
	beqi	0, r6, beq_then.17319
	addi	r6, r0, 724				# set min_caml_solver_dist
	flw	f2, 0(r11)
	flw	f1, 3(r8)
	fmul	f1, f2, f1
	fsw	f1, 0(r6)
	addi	r6, r0, 1
	j	beq_cont.17320
beq_then.17319:
	addi	r6, r0, 0
beq_cont.17320:
beq_cont.17316:
	j	beq_cont.17314
beq_then.17313:
	lw	r6, 0(r5)
	sw	r6, 0(r3)
	sw	r7, 1(r3)
	sw	r10, 2(r3)
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	sw	r2, 5(r3)
	add	r5, r0, r11
	add	r2, r0, r6
	add	r1, r0, r9
	fadd	f30, f0, f3
	fadd	f3, f0, f1
	fadd	f1, f0, f30
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solver_rect_fast.3054				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	add	r6, r0, r1
	lw	r7, 1(r3)
	lw	r10, 2(r3)
	lw	r1, 3(r3)
	lw	r5, 4(r3)
	lw	r2, 5(r3)
beq_cont.17314:
	beqi	0, r6, beq_then.17321
	addi	r8, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r8)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17322
	j	fle_cont.17323
fle_else.17322:
	addi	r8, r0, 726				# set min_caml_tmin
	flw	f2, 0(r8)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17324
	j	fle_cont.17325
fle_else.17324:
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
	beqi	-1, r7, beq_then.17326
	addi	r8, r0, 1				# set min_caml_objects
	add	r30, r8, r7
	lw	r7, 0(r30)
	fsw	f1, 6(r3)
	fsw	f3, 8(r3)
	fsw	f2, 10(r3)
	fsw	f4, 12(r3)
	sw	r6, 0(r3)
	sw	r10, 2(r3)
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	sw	r2, 5(r3)
	add	r1, r0, r7
	fadd	f1, f0, f4
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	is_outside.3128				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r7, r0, r1
	flw	f1, 6(r3)
	flw	f3, 8(r3)
	flw	f2, 10(r3)
	flw	f4, 12(r3)
	lw	r6, 0(r3)
	lw	r10, 2(r3)
	lw	r1, 3(r3)
	lw	r5, 4(r3)
	lw	r2, 5(r3)
	beqi	0, r7, beq_then.17328
	addi	r7, r0, 0
	j	beq_cont.17329
beq_then.17328:
	addi	r7, r0, 1
	sw	r7, 14(r3)
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
	lw	r6, 0(r3)
	lw	r10, 2(r3)
	lw	r1, 3(r3)
	lw	r5, 4(r3)
	lw	r2, 5(r3)
beq_cont.17329:
	j	beq_cont.17327
beq_then.17326:
	addi	r7, r0, 1
beq_cont.17327:
	beqi	0, r7, beq_then.17330
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
	j	beq_cont.17331
beq_then.17330:
beq_cont.17331:
fle_cont.17325:
fle_cont.17323:
	addi	r1, r1, 1
	j	solve_each_element_fast.3162
beq_then.17321:
	addi	r6, r0, 1				# set min_caml_objects
	add	r30, r6, r10
	lw	r6, 0(r30)
	lw	r6, 6(r6)
	beqi	0, r6, beq_then.17332
	addi	r1, r1, 1
	j	solve_each_element_fast.3162
beq_then.17332:
	jr	r31				#
beq_then.17312:
	jr	r31				#
solve_one_or_network_fast.3166:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.17335
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
	beqi	-1, r1, beq_then.17336
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
	beqi	-1, r1, beq_then.17337
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
	beqi	-1, r1, beq_then.17338
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
beq_then.17338:
	jr	r31				#
beq_then.17337:
	jr	r31				#
beq_then.17336:
	jr	r31				#
beq_then.17335:
	jr	r31				#
trace_or_matrix_fast.3170:
	add	r30, r2, r1
	lw	r10, 0(r30)
	lw	r6, 0(r10)
	beqi	-1, r6, beq_then.17343
	addi	r7, r0, 99
	beq	r6, r7, beq_then.17344
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
	beqi	1, r6, beq_then.17346
	beqi	2, r6, beq_then.17348
	sw	r6, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r10, 3(r3)
	sw	r5, 4(r3)
	add	r5, r0, r7
	add	r2, r0, r8
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
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r10, 3(r3)
	lw	r5, 4(r3)
	j	beq_cont.17349
beq_then.17348:
	flw	f1, 0(r8)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17350
	addi	r6, r0, 0
	j	fle_cont.17351
fle_else.17350:
	addi	r6, r0, 1
fle_cont.17351:
	beqi	0, r6, beq_then.17352
	addi	r6, r0, 724				# set min_caml_solver_dist
	flw	f2, 0(r8)
	flw	f1, 3(r7)
	fmul	f1, f2, f1
	fsw	f1, 0(r6)
	addi	r6, r0, 1
	j	beq_cont.17353
beq_then.17352:
	addi	r6, r0, 0
beq_cont.17353:
beq_cont.17349:
	j	beq_cont.17347
beq_then.17346:
	lw	r6, 0(r5)
	sw	r6, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r10, 3(r3)
	sw	r5, 4(r3)
	add	r5, r0, r8
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
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r10, 3(r3)
	lw	r5, 4(r3)
beq_cont.17347:
	beqi	0, r6, beq_then.17354
	addi	r6, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r6)
	addi	r6, r0, 726				# set min_caml_tmin
	flw	f2, 0(r6)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17356
	j	fle_cont.17357
fle_else.17356:
	lw	r6, 1(r10)
	beqi	-1, r6, beq_then.17358
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r10, 3(r3)
	sw	r5, 4(r3)
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r10, 3(r3)
	lw	r5, 4(r3)
	lw	r6, 2(r10)
	beqi	-1, r6, beq_then.17360
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r10, 3(r3)
	lw	r5, 4(r3)
	lw	r6, 3(r10)
	beqi	-1, r6, beq_then.17362
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r10, 3(r3)
	lw	r5, 4(r3)
	addi	r6, r0, 4
	add	r2, r0, r10
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r5, 4(r3)
	j	beq_cont.17363
beq_then.17362:
beq_cont.17363:
	j	beq_cont.17361
beq_then.17360:
beq_cont.17361:
	j	beq_cont.17359
beq_then.17358:
beq_cont.17359:
fle_cont.17357:
	j	beq_cont.17355
beq_then.17354:
beq_cont.17355:
	j	beq_cont.17345
beq_then.17344:
	lw	r6, 1(r10)
	beqi	-1, r6, beq_then.17364
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r10, 3(r3)
	sw	r5, 4(r3)
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r10, 3(r3)
	lw	r5, 4(r3)
	lw	r6, 2(r10)
	beqi	-1, r6, beq_then.17366
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r10, 3(r3)
	lw	r5, 4(r3)
	lw	r6, 3(r10)
	beqi	-1, r6, beq_then.17368
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r6
	add	r1, r0, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r10, 3(r3)
	lw	r5, 4(r3)
	addi	r6, r0, 4
	add	r2, r0, r10
	add	r1, r0, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 1(r3)
	lw	r1, 2(r3)
	lw	r5, 4(r3)
	j	beq_cont.17369
beq_then.17368:
beq_cont.17369:
	j	beq_cont.17367
beq_then.17366:
beq_cont.17367:
	j	beq_cont.17365
beq_then.17364:
beq_cont.17365:
beq_cont.17345:
	addi	r8, r1, 1
	add	r30, r2, r8
	lw	r6, 0(r30)
	lw	r1, 0(r6)
	beqi	-1, r1, beq_then.17370
	addi	r7, r0, 99
	beq	r1, r7, beq_then.17371
	sw	r2, 1(r3)
	sw	r6, 5(r3)
	sw	r5, 4(r3)
	sw	r8, 6(r3)
	add	r2, r0, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	solver_fast2.3091				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 1(r3)
	lw	r6, 5(r3)
	lw	r5, 4(r3)
	lw	r8, 6(r3)
	beqi	0, r1, beq_then.17373
	addi	r1, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r1)
	addi	r1, r0, 726				# set min_caml_tmin
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17375
	j	fle_cont.17376
fle_else.17375:
	lw	r1, 1(r6)
	beqi	-1, r1, beq_then.17377
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 1(r3)
	lw	r6, 5(r3)
	lw	r5, 4(r3)
	lw	r8, 6(r3)
	lw	r1, 2(r6)
	beqi	-1, r1, beq_then.17379
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 1(r3)
	lw	r6, 5(r3)
	lw	r5, 4(r3)
	lw	r8, 6(r3)
	addi	r1, r0, 3
	add	r2, r0, r6
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 1(r3)
	lw	r5, 4(r3)
	lw	r8, 6(r3)
	j	beq_cont.17380
beq_then.17379:
beq_cont.17380:
	j	beq_cont.17378
beq_then.17377:
beq_cont.17378:
fle_cont.17376:
	j	beq_cont.17374
beq_then.17373:
beq_cont.17374:
	j	beq_cont.17372
beq_then.17371:
	lw	r1, 1(r6)
	beqi	-1, r1, beq_then.17381
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	sw	r2, 1(r3)
	sw	r6, 5(r3)
	sw	r5, 4(r3)
	sw	r8, 6(r3)
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 1(r3)
	lw	r6, 5(r3)
	lw	r5, 4(r3)
	lw	r8, 6(r3)
	lw	r1, 2(r6)
	beqi	-1, r1, beq_then.17383
	addi	r7, r0, 672				# set min_caml_and_net
	add	r30, r7, r1
	lw	r1, 0(r30)
	addi	r7, r0, 0
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	solve_each_element_fast.3162				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 1(r3)
	lw	r6, 5(r3)
	lw	r5, 4(r3)
	lw	r8, 6(r3)
	addi	r1, r0, 3
	add	r2, r0, r6
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	solve_one_or_network_fast.3166				
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 1(r3)
	lw	r5, 4(r3)
	lw	r8, 6(r3)
	j	beq_cont.17384
beq_then.17383:
beq_cont.17384:
	j	beq_cont.17382
beq_then.17381:
beq_cont.17382:
beq_cont.17372:
	addi	r1, r8, 1
	j	trace_or_matrix_fast.3170
beq_then.17370:
	jr	r31				#
beq_then.17343:
	jr	r31				#
judge_intersection_fast.3174:
	addi	r2, r0, 726				# set min_caml_tmin
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r2)
	addi	r2, r0, 723				# set min_caml_or_net
	lw	r7, 0(r2)
	lw	r5, 0(r7)
	lw	r2, 0(r5)
	beqi	-1, r2, beq_then.17387
	addi	r6, r0, 99
	beq	r2, r6, beq_then.17389
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
	beqi	0, r2, beq_then.17391
	addi	r2, r0, 724				# set min_caml_solver_dist
	flw	f1, 0(r2)
	addi	r2, r0, 726				# set min_caml_tmin
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17393
	j	fle_cont.17394
fle_else.17393:
	lw	r2, 1(r5)
	beqi	-1, r2, beq_then.17395
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
	beqi	-1, r2, beq_then.17397
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
	j	beq_cont.17398
beq_then.17397:
beq_cont.17398:
	j	beq_cont.17396
beq_then.17395:
beq_cont.17396:
fle_cont.17394:
	j	beq_cont.17392
beq_then.17391:
beq_cont.17392:
	j	beq_cont.17390
beq_then.17389:
	lw	r2, 1(r5)
	beqi	-1, r2, beq_then.17399
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
	beqi	-1, r2, beq_then.17401
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
	j	beq_cont.17402
beq_then.17401:
beq_cont.17402:
	j	beq_cont.17400
beq_then.17399:
beq_cont.17400:
beq_cont.17390:
	addi	r2, r0, 1
	add	r5, r0, r1
	add	r1, r0, r2
	add	r2, r0, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix_fast.3170				
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.17388
beq_then.17387:
beq_cont.17388:
	addi	r1, r0, 726				# set min_caml_tmin
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17403
	addi	r1, r0, 0
	jr	r31				#
fle_else.17403:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17404
	addi	r1, r0, 0
	jr	r31				#
fle_else.17404:
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
	beq	r0, r30, feq_else.17405
	addi	r1, r0, 1
	j	feq_cont.17406
feq_else.17405:
	addi	r1, r0, 0
feq_cont.17406:
	beqi	0, r1, beq_then.17407
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.17408
beq_then.17407:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17409
	addi	r1, r0, 0
	j	fle_cont.17410
fle_else.17409:
	addi	r1, r0, 1
fle_cont.17410:
	beqi	0, r1, beq_then.17411
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.17412
beq_then.17411:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.17412:
beq_cont.17408:
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
	beqi	0, r2, beq_then.17415
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
	j	beq_cont.17416
beq_then.17415:
	addi	r2, r0, 731				# set min_caml_nvector
	fsw	f6, 0(r2)
	addi	r2, r0, 731				# set min_caml_nvector
	fsw	f5, 1(r2)
	addi	r2, r0, 731				# set min_caml_nvector
	fsw	f4, 2(r2)
beq_cont.17416:
	addi	r5, r0, 731				# set min_caml_nvector
	lw	r2, 6(r1)
	add	r1, r0, r5
	j	vecunit_sgn.2888
get_nvector.3182:
	lw	r5, 1(r1)
	beqi	1, r5, beq_then.17417
	beqi	2, r5, beq_then.17418
	j	get_nvector_second.3180
beq_then.17418:
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
beq_then.17417:
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
	beq	r0, r30, feq_else.17420
	addi	r1, r0, 1
	j	feq_cont.17421
feq_else.17420:
	addi	r1, r0, 0
feq_cont.17421:
	beqi	0, r1, beq_then.17422
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.17423
beq_then.17422:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17424
	addi	r1, r0, 0
	j	fle_cont.17425
fle_else.17424:
	addi	r1, r0, 1
fle_cont.17425:
	beqi	0, r1, beq_then.17426
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.17427
beq_then.17426:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.17427:
beq_cont.17423:
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
	beqi	1, r5, beq_then.17429
	beqi	2, r5, beq_then.17430
	beqi	3, r5, beq_then.17431
	beqi	4, r5, beq_then.17432
	jr	r31				#
beq_then.17432:
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
	beq	r0, r30, fle_else.17434
	fadd	f4, f0, f2
	j	fle_cont.17435
fle_else.17434:
	fneg	f4, f2
fle_cont.17435:
	fle	r30, f5, f4
	beq	r0, r30, fle_else.17436
	finv	f31, f2
	fmul	f1, f1, f31
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17438
	j	fle_cont.17439
fle_else.17438:
	fneg	f1, f1
fle_cont.17439:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17440
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.17441
fle_else.17440:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.17441:
	fmul	f1, f1, f2
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17442
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17444
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
	j	fle_cont.17445
fle_else.17444:
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
fle_cont.17445:
	j	fle_cont.17443
fle_else.17442:
	fsw	f3, 0(r3)
	fsw	f2, 10(r3)
	sw	r2, 6(r3)
	sw	r1, 7(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	atan_body.2841				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	fadd	f2, f0, f1
	flw	f3, 0(r3)
	lw	r2, 6(r3)
	lw	r1, 7(r3)
fle_cont.17443:
	flup	f1, 35		# fli	f1, 30.000000
	fmul	f2, f2, f1
	flup	f1, 14		# fli	f1, 3.141593
	finv	f31, f1
	fmul	f2, f2, f31
	j	fle_cont.17437
fle_else.17436:
	flup	f2, 34		# fli	f2, 15.000000
fle_cont.17437:
	ftoi	r5, f2
	itof	f1, r5
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17446
	j	fle_cont.17447
fle_else.17446:
	flup	f4, 2		# fli	f4, 1.000000
	fsub	f1, f1, f4
fle_cont.17447:
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
	beq	r0, r30, fle_else.17448
	fadd	f4, f0, f3
	j	fle_cont.17449
fle_else.17448:
	fneg	f4, f3
fle_cont.17449:
	fle	r30, f5, f4
	beq	r0, r30, fle_else.17450
	finv	f31, f3
	fmul	f1, f1, f31
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17452
	j	fle_cont.17453
fle_else.17452:
	fneg	f1, f1
fle_cont.17453:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17454
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.17455
fle_else.17454:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.17455:
	fmul	f1, f1, f3
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17456
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17458
	flup	f5, 15		# fli	f5, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	finv	f31, f1
	fmul	f1, f4, f31
	fsw	f2, 12(r3)
	fsw	f3, 14(r3)
	fsw	f5, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2841				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 12(r3)
	flw	f3, 14(r3)
	flw	f5, 16(r3)
	fadd	f1, f5, f1
	fmul	f3, f1, f3
	j	fle_cont.17459
fle_else.17458:
	flup	f6, 16		# fli	f6, 0.785398
	flup	f4, 2		# fli	f4, 1.000000
	fsub	f5, f1, f4
	flup	f4, 2		# fli	f4, 1.000000
	fadd	f1, f1, f4
	finv	f31, f1
	fmul	f1, f5, f31
	fsw	f2, 12(r3)
	fsw	f3, 14(r3)
	fsw	f6, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	atan_body.2841				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	flw	f2, 12(r3)
	flw	f3, 14(r3)
	flw	f6, 18(r3)
	fadd	f1, f6, f1
	fmul	f3, f1, f3
fle_cont.17459:
	j	fle_cont.17457
fle_else.17456:
	fsw	f2, 12(r3)
	fsw	f3, 20(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	atan_body.2841				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	fadd	f3, f0, f1
	flw	f2, 12(r3)
fle_cont.17457:
	flup	f1, 35		# fli	f1, 30.000000
	fmul	f3, f3, f1
	flup	f1, 14		# fli	f1, 3.141593
	finv	f31, f1
	fmul	f3, f3, f31
	j	fle_cont.17451
fle_else.17450:
	flup	f3, 34		# fli	f3, 15.000000
fle_cont.17451:
	ftoi	r1, f3
	itof	f1, r1
	fle	r30, f1, f3
	beq	r0, r30, fle_else.17460
	j	fle_cont.17461
fle_else.17460:
	flup	f4, 2		# fli	f4, 1.000000
	fsub	f1, f1, f4
fle_cont.17461:
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
	beq	r0, r30, fle_else.17462
	addi	r1, r0, 0
	j	fle_cont.17463
fle_else.17462:
	addi	r1, r0, 1
fle_cont.17463:
	beqi	0, r1, beq_then.17464
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.17465
beq_then.17464:
beq_cont.17465:
	addi	r1, r0, 734				# set min_caml_texture_color
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f2, f2, f1
	flup	f1, 38		# fli	f1, 0.300000
	finv	f31, f1
	fmul	f1, f2, f31
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.17431:
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
	beq	r0, r30, fle_else.17467
	j	fle_cont.17468
fle_else.17467:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f1, f1, f3
fle_cont.17468:
	fsub	f2, f2, f1
	flup	f1, 14		# fli	f1, 3.141593
	fmul	f1, f2, f1
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	cos.2839				
	addi	r3, r3, -23
	lw	r31, 22(r3)
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
beq_then.17430:
	flw	f2, 1(r2)
	flup	f1, 40		# fli	f1, 0.250000
	fmul	f1, f2, f1
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	sin.2837				
	addi	r3, r3, -23
	lw	r31, 22(r3)
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
beq_then.17429:
	flw	f1, 0(r2)
	lw	r5, 5(r1)
	flw	f2, 0(r5)
	fsub	f2, f1, f2
	flup	f1, 41		# fli	f1, 0.050000
	fmul	f3, f2, f1
	ftoi	r5, f3
	itof	f1, r5
	fle	r30, f1, f3
	beq	r0, r30, fle_else.17471
	fadd	f3, f0, f1
	j	fle_cont.17472
fle_else.17471:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f3, f1, f3
fle_cont.17472:
	flup	f1, 42		# fli	f1, 20.000000
	fmul	f1, f3, f1
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f2, f1
	fle	r30, f3, f1
	beq	r0, r30, fle_else.17473
	addi	r5, r0, 0
	j	fle_cont.17474
fle_else.17473:
	addi	r5, r0, 1
fle_cont.17474:
	flw	f2, 2(r2)
	lw	r1, 5(r1)
	flw	f1, 2(r1)
	fsub	f2, f2, f1
	flup	f1, 41		# fli	f1, 0.050000
	fmul	f3, f2, f1
	ftoi	r1, f3
	itof	f1, r1
	fle	r30, f1, f3
	beq	r0, r30, fle_else.17475
	fadd	f3, f0, f1
	j	fle_cont.17476
fle_else.17475:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f3, f1, f3
fle_cont.17476:
	flup	f1, 42		# fli	f1, 20.000000
	fmul	f1, f3, f1
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f2, f1
	fle	r30, f3, f1
	beq	r0, r30, fle_else.17477
	addi	r1, r0, 0
	j	fle_cont.17478
fle_else.17477:
	addi	r1, r0, 1
fle_cont.17478:
	addi	r2, r0, 734				# set min_caml_texture_color
	beqi	0, r5, beq_then.17479
	beqi	0, r1, beq_then.17481
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.17482
beq_then.17481:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.17482:
	j	beq_cont.17480
beq_then.17479:
	beqi	0, r1, beq_then.17483
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.17484
beq_then.17483:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.17484:
beq_cont.17480:
	fsw	f1, 1(r2)
	jr	r31				#
add_light.3188:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17486
	addi	r1, r0, 0
	j	fle_cont.17487
fle_else.17486:
	addi	r1, r0, 1
fle_cont.17487:
	beqi	0, r1, beq_then.17488
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
	j	beq_cont.17489
beq_then.17488:
beq_cont.17489:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.17490
	addi	r1, r0, 0
	j	fle_cont.17491
fle_else.17490:
	addi	r1, r0, 1
fle_cont.17491:
	beqi	0, r1, beq_then.17492
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
beq_then.17492:
	jr	r31				#
trace_reflections.3192:
	bgei	0, r1, bge_then.17495
	jr	r31				#
bge_then.17495:
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
	beq	r0, r30, fle_else.17497
	addi	r5, r0, 0
	j	fle_cont.17498
fle_else.17497:
	flup	f4, 32		# fli	f4, 100000000.000000
	fle	r30, f4, f3
	beq	r0, r30, fle_else.17499
	addi	r5, r0, 0
	j	fle_cont.17500
fle_else.17499:
	addi	r5, r0, 1
fle_cont.17500:
fle_cont.17498:
	beqi	0, r5, beq_then.17501
	addi	r5, r0, 730				# set min_caml_intersected_object_id
	lw	r5, 0(r5)
	slli	r7, r5, 2
	addi	r5, r0, 725				# set min_caml_intsec_rectside
	lw	r5, 0(r5)
	add	r5, r7, r5
	lw	r7, 0(r6)
	beq	r5, r7, beq_then.17503
	j	beq_cont.17504
beq_then.17503:
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
	beqi	0, r5, beq_then.17505
	j	beq_cont.17506
beq_then.17505:
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
beq_cont.17506:
beq_cont.17504:
	j	beq_cont.17502
beq_then.17501:
beq_cont.17502:
	addi	r1, r1, -1
	j	trace_reflections.3192
trace_ray.3197:
	blei	4, r1, ble_then.17507
	jr	r31				#
ble_then.17507:
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
	beq	r0, r30, fle_else.17509
	addi	r6, r0, 0
	j	fle_cont.17510
fle_else.17509:
	flup	f4, 32		# fli	f4, 100000000.000000
	fle	r30, f4, f3
	beq	r0, r30, fle_else.17511
	addi	r6, r0, 0
	j	fle_cont.17512
fle_else.17511:
	addi	r6, r0, 1
fle_cont.17512:
fle_cont.17510:
	beqi	0, r6, beq_then.17513
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
	beqi	1, r6, beq_then.17514
	beqi	2, r6, beq_then.17516
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
	j	beq_cont.17517
beq_then.17516:
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
beq_cont.17517:
	j	beq_cont.17515
beq_then.17514:
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
	beq	r0, r30, feq_else.17518
	addi	r6, r0, 1
	j	feq_cont.17519
feq_else.17518:
	addi	r6, r0, 0
feq_cont.17519:
	beqi	0, r6, beq_then.17520
	flup	f3, 0		# fli	f3, 0.000000
	j	beq_cont.17521
beq_then.17520:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.17522
	addi	r6, r0, 0
	j	fle_cont.17523
fle_else.17522:
	addi	r6, r0, 1
fle_cont.17523:
	beqi	0, r6, beq_then.17524
	flup	f3, 2		# fli	f3, 1.000000
	j	beq_cont.17525
beq_then.17524:
	flup	f3, 11		# fli	f3, -1.000000
beq_cont.17525:
beq_cont.17521:
	fneg	f3, f3
	add	r30, r12, r11
	fsw	f3, 0(r30)
beq_cont.17515:
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
	beq	r0, r30, fle_else.17526
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
	j	fle_cont.17527
fle_else.17526:
	addi	r6, r0, 0
	add	r30, r7, r1
	sw	r6, 0(r30)
fle_cont.17527:
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
	beqi	0, r6, beq_then.17529
	j	beq_cont.17530
beq_then.17529:
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
beq_cont.17530:
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
	beq	r0, r30, fle_else.17531
	jr	r31				#
fle_else.17531:
	bgei	4, r1, bge_then.17533
	addi	r7, r1, 1
	addi	r6, r0, -1
	add	r30, r10, r7
	sw	r6, 0(r30)
	j	bge_cont.17534
bge_then.17533:
bge_cont.17534:
	beqi	2, r9, beq_then.17535
	j	beq_cont.17536
beq_then.17535:
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
beq_cont.17536:
	jr	r31				#
beq_then.17513:
	addi	r5, r0, -1
	add	r30, r10, r1
	sw	r5, 0(r30)
	beqi	0, r1, beq_then.17538
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
	beq	r0, r30, fle_else.17539
	addi	r1, r0, 0
	j	fle_cont.17540
fle_else.17539:
	addi	r1, r0, 1
fle_cont.17540:
	beqi	0, r1, beq_then.17541
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
beq_then.17541:
	jr	r31				#
beq_then.17538:
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
	beq	r0, r30, fle_else.17545
	addi	r2, r0, 0
	j	fle_cont.17546
fle_else.17545:
	flup	f3, 32		# fli	f3, 100000000.000000
	fle	r30, f3, f2
	beq	r0, r30, fle_else.17547
	addi	r2, r0, 0
	j	fle_cont.17548
fle_else.17547:
	addi	r2, r0, 1
fle_cont.17548:
fle_cont.17546:
	beqi	0, r2, beq_then.17549
	addi	r5, r0, 1				# set min_caml_objects
	addi	r2, r0, 730				# set min_caml_intersected_object_id
	lw	r2, 0(r2)
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r5, 0(r1)
	lw	r1, 1(r2)
	beqi	1, r1, beq_then.17550
	beqi	2, r1, beq_then.17552
	sw	r2, 3(r3)
	add	r1, r0, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	get_nvector_second.3180				
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f1, 0(r3)
	lw	r2, 3(r3)
	j	beq_cont.17553
beq_then.17552:
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
beq_cont.17553:
	j	beq_cont.17551
beq_then.17550:
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
	beq	r0, r30, feq_else.17554
	addi	r1, r0, 1
	j	feq_cont.17555
feq_else.17554:
	addi	r1, r0, 0
feq_cont.17555:
	beqi	0, r1, beq_then.17556
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.17557
beq_then.17556:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.17558
	addi	r1, r0, 0
	j	fle_cont.17559
fle_else.17558:
	addi	r1, r0, 1
fle_cont.17559:
	beqi	0, r1, beq_then.17560
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.17561
beq_then.17560:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.17561:
beq_cont.17557:
	fneg	f2, f2
	add	r30, r7, r6
	fsw	f2, 0(r30)
beq_cont.17551:
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
	beqi	0, r1, beq_then.17562
	jr	r31				#
beq_then.17562:
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
	beq	r0, r30, fle_else.17564
	addi	r1, r0, 0
	j	fle_cont.17565
fle_else.17564:
	addi	r1, r0, 1
fle_cont.17565:
	beqi	0, r1, beq_then.17566
	j	beq_cont.17567
beq_then.17566:
	flup	f2, 0		# fli	f2, 0.000000
beq_cont.17567:
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
beq_then.17549:
	jr	r31				#
iter_trace_diffuse_rays.3206:
	bgei	0, r6, bge_then.17570
	jr	r31				#
bge_then.17570:
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
	beq	r0, r30, fle_else.17572
	addi	r7, r0, 0
	j	fle_cont.17573
fle_else.17572:
	addi	r7, r0, 1
fle_cont.17573:
	beqi	0, r7, beq_then.17574
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
	j	beq_cont.17575
beq_then.17574:
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
beq_cont.17575:
	addi	r7, r6, -2
	bgei	0, r7, bge_then.17576
	jr	r31				#
bge_then.17576:
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
	beq	r0, r30, fle_else.17578
	addi	r6, r0, 0
	j	fle_cont.17579
fle_else.17578:
	addi	r6, r0, 1
fle_cont.17579:
	beqi	0, r6, beq_then.17580
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
	j	beq_cont.17581
beq_then.17580:
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
beq_cont.17581:
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
	beq	r0, r30, fle_else.17582
	addi	r6, r0, 0
	j	fle_cont.17583
fle_else.17582:
	addi	r6, r0, 1
fle_cont.17583:
	beqi	0, r6, beq_then.17584
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
	j	beq_cont.17585
beq_then.17584:
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
beq_cont.17585:
	addi	r6, r0, 116
	j	iter_trace_diffuse_rays.3206
trace_diffuse_ray_80percent.3215:
	beqi	0, r1, beq_then.17586
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
	j	beq_cont.17587
beq_then.17586:
beq_cont.17587:
	beqi	1, r1, beq_then.17588
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
	j	beq_cont.17589
beq_then.17588:
beq_cont.17589:
	beqi	2, r1, beq_then.17590
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
	j	beq_cont.17591
beq_then.17590:
beq_cont.17591:
	beqi	3, r1, beq_then.17592
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
	j	beq_cont.17593
beq_then.17592:
beq_cont.17593:
	beqi	4, r1, beq_then.17594
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
beq_then.17594:
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
	blei	4, r2, ble_then.17596
	jr	r31				#
ble_then.17596:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.17598
	jr	r31				#
bge_then.17598:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	beqi	0, r5, beq_then.17600
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
	j	beq_cont.17601
beq_then.17600:
beq_cont.17601:
	addi	r8, r2, 1
	blei	4, r8, ble_then.17602
	jr	r31				#
ble_then.17602:
	lw	r2, 2(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	bgei	0, r2, bge_then.17604
	jr	r31				#
bge_then.17604:
	lw	r2, 3(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	beqi	0, r2, beq_then.17606
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
	j	beq_cont.17607
beq_then.17606:
beq_cont.17607:
	addi	r2, r8, 1
	j	do_without_neighbors.3228
neighbors_exist.3231:
	addi	r5, r0, 743				# set min_caml_image_size
	lw	r6, 1(r5)
	addi	r5, r2, 1
	ble	r6, r5, ble_then.17608
	blei	0, r2, ble_then.17609
	addi	r2, r0, 743				# set min_caml_image_size
	lw	r5, 0(r2)
	addi	r2, r1, 1
	ble	r5, r2, ble_then.17610
	blei	0, r1, ble_then.17611
	addi	r1, r0, 1
	jr	r31				#
ble_then.17611:
	addi	r1, r0, 0
	jr	r31				#
ble_then.17610:
	addi	r1, r0, 0
	jr	r31				#
ble_then.17609:
	addi	r1, r0, 0
	jr	r31				#
ble_then.17608:
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
	beq	r2, r8, beq_then.17612
	addi	r1, r0, 0
	jr	r31				#
beq_then.17612:
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.17613
	addi	r1, r0, 0
	jr	r31				#
beq_then.17613:
	addi	r2, r1, -1
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.17614
	addi	r1, r0, 0
	jr	r31				#
beq_then.17614:
	addi	r1, r1, 1
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beq	r1, r8, beq_then.17615
	addi	r1, r0, 0
	jr	r31				#
beq_then.17615:
	addi	r1, r0, 1
	jr	r31				#
try_exploit_neighbors.3244:
	add	r30, r6, r1
	lw	r10, 0(r30)
	blei	4, r8, ble_then.17616
	jr	r31				#
ble_then.17616:
	lw	r9, 2(r10)
	add	r30, r9, r8
	lw	r9, 0(r30)
	bgei	0, r9, bge_then.17618
	jr	r31				#
bge_then.17618:
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
	beq	r11, r9, beq_then.17620
	addi	r9, r0, 0
	j	beq_cont.17621
beq_then.17620:
	add	r30, r7, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r9, beq_then.17622
	addi	r9, r0, 0
	j	beq_cont.17623
beq_then.17622:
	addi	r11, r1, -1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r9, beq_then.17624
	addi	r9, r0, 0
	j	beq_cont.17625
beq_then.17624:
	addi	r11, r1, 1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r9, beq_then.17626
	addi	r9, r0, 0
	j	beq_cont.17627
beq_then.17626:
	addi	r9, r0, 1
beq_cont.17627:
beq_cont.17625:
beq_cont.17623:
beq_cont.17621:
	beqi	0, r9, beq_then.17628
	lw	r9, 3(r10)
	add	r30, r9, r8
	lw	r9, 0(r30)
	beqi	0, r9, beq_then.17629
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
	j	beq_cont.17630
beq_then.17629:
beq_cont.17630:
	addi	r11, r8, 1
	add	r30, r6, r1
	lw	r9, 0(r30)
	blei	4, r11, ble_then.17631
	jr	r31				#
ble_then.17631:
	lw	r8, 2(r9)
	add	r30, r8, r11
	lw	r8, 0(r30)
	bgei	0, r8, bge_then.17633
	jr	r31				#
bge_then.17633:
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
	beq	r10, r8, beq_then.17635
	addi	r8, r0, 0
	j	beq_cont.17636
beq_then.17635:
	add	r30, r7, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r11
	lw	r10, 0(r30)
	beq	r10, r8, beq_then.17637
	addi	r8, r0, 0
	j	beq_cont.17638
beq_then.17637:
	addi	r10, r1, -1
	add	r30, r6, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r11
	lw	r10, 0(r30)
	beq	r10, r8, beq_then.17639
	addi	r8, r0, 0
	j	beq_cont.17640
beq_then.17639:
	addi	r10, r1, 1
	add	r30, r6, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r11
	lw	r10, 0(r30)
	beq	r10, r8, beq_then.17641
	addi	r8, r0, 0
	j	beq_cont.17642
beq_then.17641:
	addi	r8, r0, 1
beq_cont.17642:
beq_cont.17640:
beq_cont.17638:
beq_cont.17636:
	beqi	0, r8, beq_then.17643
	lw	r8, 3(r9)
	add	r30, r8, r11
	lw	r8, 0(r30)
	beqi	0, r8, beq_then.17644
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
	j	beq_cont.17645
beq_then.17644:
beq_cont.17645:
	addi	r8, r11, 1
	j	try_exploit_neighbors.3244
beq_then.17643:
	add	r30, r6, r1
	lw	r1, 0(r30)
	add	r2, r0, r11
	j	do_without_neighbors.3228
beq_then.17628:
	add	r30, r6, r1
	lw	r7, 0(r30)
	blei	4, r8, ble_then.17646
	jr	r31				#
ble_then.17646:
	lw	r1, 2(r7)
	add	r30, r1, r8
	lw	r1, 0(r30)
	bgei	0, r1, bge_then.17648
	jr	r31				#
bge_then.17648:
	lw	r1, 3(r7)
	add	r30, r1, r8
	lw	r1, 0(r30)
	beqi	0, r1, beq_then.17650
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
	j	beq_cont.17651
beq_then.17650:
beq_cont.17651:
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
	ble	r1, r2, ble_then.17652
	addi	r1, r0, 255
	j	ble_cont.17653
ble_then.17652:
	bgei	0, r1, bge_then.17654
	addi	r1, r0, 0
	j	bge_cont.17655
bge_then.17654:
bge_cont.17655:
ble_cont.17653:
	j	print_int.2857
write_rgb.3255:
	addi	r1, r0, 740				# set min_caml_rgb
	flw	f1, 0(r1)
	ftoi	r1, f1
	addi	r2, r0, 255
	ble	r1, r2, ble_then.17656
	addi	r1, r0, 255
	j	ble_cont.17657
ble_then.17656:
	bgei	0, r1, bge_then.17658
	addi	r1, r0, 0
	j	bge_cont.17659
bge_then.17658:
bge_cont.17659:
ble_cont.17657:
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
	ble	r1, r2, ble_then.17660
	addi	r1, r0, 255
	j	ble_cont.17661
ble_then.17660:
	bgei	0, r1, bge_then.17662
	addi	r1, r0, 0
	j	bge_cont.17663
bge_then.17662:
bge_cont.17663:
ble_cont.17661:
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
	ble	r1, r2, ble_then.17664
	addi	r1, r0, 255
	j	ble_cont.17665
ble_then.17664:
	bgei	0, r1, bge_then.17666
	addi	r1, r0, 0
	j	bge_cont.17667
bge_then.17666:
bge_cont.17667:
ble_cont.17665:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2857				
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
pretrace_diffuse_rays.3257:
	blei	4, r2, ble_then.17668
	jr	r31				#
ble_then.17668:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	bgei	0, r5, bge_then.17670
	jr	r31				#
bge_then.17670:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	beqi	0, r5, beq_then.17672
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
	j	beq_cont.17673
beq_then.17672:
beq_cont.17673:
	addi	r2, r2, 1
	j	pretrace_diffuse_rays.3257
pretrace_pixels.3260:
	bgei	0, r2, bge_then.17674
	jr	r31				#
bge_then.17674:
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
	bgei	5, r2, bge_then.17676
	add	r5, r0, r2
	j	bge_cont.17677
bge_then.17676:
	addi	r5, r2, -5
bge_cont.17677:
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
	ble	r8, r1, ble_then.17678
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
	ble	r9, r8, ble_then.17679
	blei	0, r2, ble_then.17681
	addi	r8, r0, 743				# set min_caml_image_size
	lw	r9, 0(r8)
	addi	r8, r1, 1
	ble	r9, r8, ble_then.17683
	blei	0, r1, ble_then.17685
	addi	r8, r0, 1
	j	ble_cont.17686
ble_then.17685:
	addi	r8, r0, 0
ble_cont.17686:
	j	ble_cont.17684
ble_then.17683:
	addi	r8, r0, 0
ble_cont.17684:
	j	ble_cont.17682
ble_then.17681:
	addi	r8, r0, 0
ble_cont.17682:
	j	ble_cont.17680
ble_then.17679:
	addi	r8, r0, 0
ble_cont.17680:
	beqi	0, r8, beq_then.17687
	addi	r11, r0, 0
	add	r30, r6, r1
	lw	r9, 0(r30)
	lw	r8, 2(r9)
	lw	r8, 0(r8)
	bgei	0, r8, bge_then.17689
	j	bge_cont.17690
bge_then.17689:
	add	r30, r6, r1
	lw	r8, 0(r30)
	lw	r8, 2(r8)
	lw	r8, 0(r8)
	add	r30, r5, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	lw	r10, 0(r10)
	beq	r10, r8, beq_then.17691
	addi	r8, r0, 0
	j	beq_cont.17692
beq_then.17691:
	add	r30, r7, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	lw	r10, 0(r10)
	beq	r10, r8, beq_then.17693
	addi	r8, r0, 0
	j	beq_cont.17694
beq_then.17693:
	addi	r10, r1, -1
	add	r30, r6, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	lw	r10, 0(r10)
	beq	r10, r8, beq_then.17695
	addi	r8, r0, 0
	j	beq_cont.17696
beq_then.17695:
	addi	r10, r1, 1
	add	r30, r6, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	lw	r10, 0(r10)
	beq	r10, r8, beq_then.17697
	addi	r8, r0, 0
	j	beq_cont.17698
beq_then.17697:
	addi	r8, r0, 1
beq_cont.17698:
beq_cont.17696:
beq_cont.17694:
beq_cont.17692:
	beqi	0, r8, beq_then.17699
	lw	r8, 3(r9)
	lw	r8, 0(r8)
	beqi	0, r8, beq_then.17701
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
	j	beq_cont.17702
beq_then.17701:
beq_cont.17702:
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
	j	beq_cont.17700
beq_then.17699:
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
beq_cont.17700:
bge_cont.17690:
	j	beq_cont.17688
beq_then.17687:
	add	r30, r6, r1
	lw	r12, 0(r30)
	lw	r8, 2(r12)
	lw	r8, 0(r8)
	bgei	0, r8, bge_then.17703
	j	bge_cont.17704
bge_then.17703:
	lw	r8, 3(r12)
	lw	r8, 0(r8)
	beqi	0, r8, beq_then.17705
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
	j	beq_cont.17706
beq_then.17705:
beq_cont.17706:
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
bge_cont.17704:
beq_cont.17688:
	addi	r8, r0, 740				# set min_caml_rgb
	flw	f1, 0(r8)
	ftoi	r8, f1
	addi	r9, r0, 255
	ble	r8, r9, ble_then.17707
	addi	r8, r0, 255
	j	ble_cont.17708
ble_then.17707:
	bgei	0, r8, bge_then.17709
	addi	r8, r0, 0
	j	bge_cont.17710
bge_then.17709:
bge_cont.17710:
ble_cont.17708:
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
	ble	r8, r9, ble_then.17711
	addi	r8, r0, 255
	j	ble_cont.17712
ble_then.17711:
	bgei	0, r8, bge_then.17713
	addi	r8, r0, 0
	j	bge_cont.17714
bge_then.17713:
bge_cont.17714:
ble_cont.17712:
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
	ble	r8, r9, ble_then.17715
	addi	r8, r0, 255
	j	ble_cont.17716
ble_then.17715:
	bgei	0, r8, bge_then.17717
	addi	r8, r0, 0
	j	bge_cont.17718
bge_then.17717:
bge_cont.17718:
ble_cont.17716:
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
	ble	r1, r9, ble_then.17719
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
	ble	r8, r1, ble_then.17720
	blei	0, r2, ble_then.17722
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r8, 0(r1)
	addi	r1, r9, 1
	ble	r8, r1, ble_then.17724
	blei	0, r9, ble_then.17726
	addi	r1, r0, 1
	j	ble_cont.17727
ble_then.17726:
	addi	r1, r0, 0
ble_cont.17727:
	j	ble_cont.17725
ble_then.17724:
	addi	r1, r0, 0
ble_cont.17725:
	j	ble_cont.17723
ble_then.17722:
	addi	r1, r0, 0
ble_cont.17723:
	j	ble_cont.17721
ble_then.17720:
	addi	r1, r0, 0
ble_cont.17721:
	beqi	0, r1, beq_then.17728
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
	j	beq_cont.17729
beq_then.17728:
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
beq_cont.17729:
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
ble_then.17719:
	jr	r31				#
ble_then.17678:
	jr	r31				#
scan_line.3277:
	addi	r8, r0, 743				# set min_caml_image_size
	lw	r8, 1(r8)
	ble	r8, r1, ble_then.17732
	addi	r8, r0, 743				# set min_caml_image_size
	lw	r8, 1(r8)
	addi	r8, r8, -1
	ble	r8, r1, ble_then.17733
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
	j	ble_cont.17734
ble_then.17733:
ble_cont.17734:
	addi	r10, r0, 0
	addi	r8, r0, 743				# set min_caml_image_size
	lw	r8, 0(r8)
	blei	0, r8, ble_then.17735
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
	ble	r9, r8, ble_then.17737
	blei	0, r1, ble_then.17739
	addi	r8, r0, 743				# set min_caml_image_size
	lw	r8, 0(r8)
	blei	1, r8, ble_then.17741
	addi	r8, r0, 0
	j	ble_cont.17742
ble_then.17741:
	addi	r8, r0, 0
ble_cont.17742:
	j	ble_cont.17740
ble_then.17739:
	addi	r8, r0, 0
ble_cont.17740:
	j	ble_cont.17738
ble_then.17737:
	addi	r8, r0, 0
ble_cont.17738:
	beqi	0, r8, beq_then.17743
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
	j	beq_cont.17744
beq_then.17743:
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
beq_cont.17744:
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
	j	ble_cont.17736
ble_then.17735:
ble_cont.17736:
	addi	r8, r1, 1
	addi	r1, r7, 2
	bgei	5, r1, bge_then.17745
	j	bge_cont.17746
bge_then.17745:
	addi	r1, r1, -5
bge_cont.17746:
	addi	r7, r0, 743				# set min_caml_image_size
	lw	r7, 1(r7)
	ble	r7, r8, ble_then.17747
	addi	r7, r0, 743				# set min_caml_image_size
	lw	r7, 1(r7)
	addi	r7, r7, -1
	ble	r7, r8, ble_then.17749
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
	j	ble_cont.17750
ble_then.17749:
ble_cont.17750:
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
	bgei	5, r1, bge_then.17751
	add	r7, r0, r1
	j	bge_cont.17752
bge_then.17751:
	addi	r7, r1, -5
bge_cont.17752:
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
	j	ble_cont.17748
ble_then.17747:
ble_cont.17748:
	jr	r31				#
ble_then.17732:
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
	bgei	0, r2, bge_then.17755
	jr	r31				#
bge_then.17755:
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
	bgei	0, r13, bge_then.17756
	jr	r31				#
bge_then.17756:
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
	bgei	0, r14, bge_then.17757
	add	r1, r0, r12
	jr	r31				#
bge_then.17757:
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
	beq	r0, r30, fle_else.17758
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.17759
fle_else.17758:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.17759:
	fmul	f1, f1, f4
	flup	f5, 23		# fli	f5, 4.375000
	fle	r30, f5, f1
	beq	r0, r30, fle_else.17760
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f1
	beq	r0, r30, fle_else.17762
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
	j	fle_cont.17763
fle_else.17762:
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
fle_cont.17763:
	j	fle_cont.17761
fle_else.17760:
	fsw	f1, 10(r3)
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	atan_body.2841				
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 0(r3)
	flw	f3, 2(r3)
fle_cont.17761:
	fmul	f1, f1, f2
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin.2837				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	fadd	f2, f0, f1
	flw	f3, 2(r3)
	flw	f1, 12(r3)
	fsw	f2, 14(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	cos.2839				
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f3, 2(r3)
	flw	f2, 14(r3)
	finv	f31, f1
	fmul	f1, f2, f31
	fmul	f1, f1, f3
	jr	r31				#
calc_dirvec.3297:
	bgei	5, r1, bge_then.17764
	fmul	f2, f2, f2
	flup	f1, 45		# fli	f1, 0.100000
	fadd	f1, f2, f1
	fsqrt	f2, f1
	flup	f1, 2		# fli	f1, 1.000000
	finv	f31, f2
	fmul	f1, f1, f31
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17765
	flup	f5, 2		# fli	f5, 1.000000
	j	fle_cont.17766
fle_else.17765:
	flup	f5, 11		# fli	f5, -1.000000
fle_cont.17766:
	fmul	f1, f1, f5
	flup	f6, 23		# fli	f6, 4.375000
	fle	r30, f6, f1
	beq	r0, r30, fle_else.17767
	flup	f6, 24		# fli	f6, 2.437500
	fle	r30, f6, f1
	beq	r0, r30, fle_else.17769
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
	j	fle_cont.17770
fle_else.17769:
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
fle_cont.17770:
	j	fle_cont.17768
fle_else.17767:
	fsw	f1, 16(r3)
	fsw	f4, 0(r3)
	fsw	f3, 2(r3)
	fsw	f2, 4(r3)
	sw	r5, 10(r3)
	sw	r1, 11(r3)
	sw	r2, 12(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2841				
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f2, 4(r3)
	lw	r5, 10(r3)
	lw	r1, 11(r3)
	lw	r2, 12(r3)
fle_cont.17768:
	fmul	f1, f1, f3
	fsw	f1, 18(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	sin.2837				
	addi	r3, r3, -21
	lw	r31, 20(r3)
	fadd	f5, f0, f1
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f2, 4(r3)
	flw	f1, 18(r3)
	lw	r5, 10(r3)
	lw	r1, 11(r3)
	lw	r2, 12(r3)
	fsw	f5, 20(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	cos.2839				
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f2, 4(r3)
	flw	f5, 20(r3)
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
	beq	r0, r30, fle_else.17772
	flup	f6, 2		# fli	f6, 1.000000
	j	fle_cont.17773
fle_else.17772:
	flup	f6, 11		# fli	f6, -1.000000
fle_cont.17773:
	fmul	f2, f2, f6
	flup	f7, 23		# fli	f7, 4.375000
	fle	r30, f7, f2
	beq	r0, r30, fle_else.17774
	flup	f7, 24		# fli	f7, 2.437500
	fle	r30, f7, f2
	beq	r0, r30, fle_else.17776
	flup	f8, 15		# fli	f8, 1.570796
	flup	f7, 2		# fli	f7, 1.000000
	finv	f31, f2
	fmul	f2, f7, f31
	fsw	f1, 22(r3)
	fsw	f5, 24(r3)
	fsw	f6, 26(r3)
	fsw	f8, 28(r3)
	sw	r1, 30(r3)
	fadd	f1, f0, f2
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	atan_body.2841				
	addi	r3, r3, -32
	lw	r31, 31(r3)
	fadd	f2, f0, f1
	flw	f1, 22(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f5, 24(r3)
	flw	f6, 26(r3)
	flw	f8, 28(r3)
	lw	r5, 10(r3)
	lw	r2, 12(r3)
	lw	r1, 30(r3)
	fadd	f2, f8, f2
	fmul	f2, f2, f6
	j	fle_cont.17777
fle_else.17776:
	flup	f9, 16		# fli	f9, 0.785398
	flup	f7, 2		# fli	f7, 1.000000
	fsub	f8, f2, f7
	flup	f7, 2		# fli	f7, 1.000000
	fadd	f2, f2, f7
	finv	f31, f2
	fmul	f2, f8, f31
	fsw	f1, 22(r3)
	fsw	f5, 24(r3)
	fsw	f6, 26(r3)
	fsw	f9, 32(r3)
	sw	r1, 30(r3)
	fadd	f1, f0, f2
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	atan_body.2841				
	addi	r3, r3, -35
	lw	r31, 34(r3)
	fadd	f2, f0, f1
	flw	f1, 22(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f5, 24(r3)
	flw	f6, 26(r3)
	flw	f9, 32(r3)
	lw	r5, 10(r3)
	lw	r2, 12(r3)
	lw	r1, 30(r3)
	fadd	f2, f9, f2
	fmul	f2, f2, f6
fle_cont.17777:
	j	fle_cont.17775
fle_else.17774:
	fsw	f1, 22(r3)
	fsw	f2, 34(r3)
	fsw	f5, 24(r3)
	sw	r1, 30(r3)
	fadd	f1, f0, f2
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	atan_body.2841				
	addi	r3, r3, -37
	lw	r31, 36(r3)
	fadd	f2, f0, f1
	flw	f1, 22(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f5, 24(r3)
	lw	r5, 10(r3)
	lw	r2, 12(r3)
	lw	r1, 30(r3)
fle_cont.17775:
	fmul	f2, f2, f4
	fsw	f2, 36(r3)
	fadd	f1, f0, f2
	sw	r31, 38(r3)
	addi	r3, r3, 39
	jal	sin.2837				
	addi	r3, r3, -39
	lw	r31, 38(r3)
	fadd	f6, f0, f1
	flw	f1, 22(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f5, 24(r3)
	flw	f2, 36(r3)
	lw	r5, 10(r3)
	lw	r2, 12(r3)
	lw	r1, 30(r3)
	fsw	f6, 38(r3)
	fadd	f1, f0, f2
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	cos.2839				
	addi	r3, r3, -41
	lw	r31, 40(r3)
	fadd	f2, f0, f1
	flw	f1, 22(r3)
	flw	f4, 0(r3)
	flw	f3, 2(r3)
	flw	f5, 24(r3)
	flw	f6, 38(r3)
	lw	r5, 10(r3)
	lw	r2, 12(r3)
	lw	r1, 30(r3)
	finv	f31, f2
	fmul	f2, f6, f31
	fmul	f2, f2, f5
	j	calc_dirvec.3297
bge_then.17764:
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
	bgei	0, r1, bge_then.17780
	jr	r31				#
bge_then.17780:
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
	bgei	5, r1, bge_then.17782
	add	r2, r0, r1
	j	bge_cont.17783
bge_then.17782:
	addi	r2, r1, -5
bge_cont.17783:
	add	r1, r0, r6
	j	calc_dirvecs.3305
calc_dirvec_rows.3310:
	bgei	0, r1, bge_then.17784
	jr	r31				#
bge_then.17784:
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
	bgei	5, r1, bge_then.17786
	add	r2, r0, r1
	j	bge_cont.17787
bge_then.17786:
	addi	r2, r1, -5
bge_cont.17787:
	addi	r5, r5, 4
	bgei	0, r6, bge_then.17788
	jr	r31				#
bge_then.17788:
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
	bgei	5, r1, bge_then.17790
	add	r2, r0, r1
	j	bge_cont.17791
bge_then.17790:
	addi	r2, r1, -5
bge_cont.17791:
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
	bgei	0, r2, bge_then.17792
	jr	r31				#
bge_then.17792:
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
	bgei	0, r7, bge_then.17794
	jr	r31				#
bge_then.17794:
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
	bgei	0, r7, bge_then.17796
	jr	r31				#
bge_then.17796:
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
	bgei	0, r7, bge_then.17798
	jr	r31				#
bge_then.17798:
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
	bgei	0, r1, bge_then.17800
	jr	r31				#
bge_then.17800:
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
	bgei	0, r6, bge_then.17802
	jr	r31				#
bge_then.17802:
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
	bgei	0, r2, bge_then.17804
	jr	r31				#
bge_then.17804:
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
	bgei	0, r9, bge_then.17806
	jr	r31				#
bge_then.17806:
	add	r30, r1, r9
	lw	r8, 0(r30)
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r2, 0(r2)
	addi	r10, r2, -1
	bgei	0, r10, bge_then.17808
	j	bge_cont.17809
bge_then.17808:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r10
	lw	r7, 0(r30)
	lw	r6, 1(r8)
	lw	r2, 0(r8)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17810
	beqi	2, r5, beq_then.17812
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
	j	beq_cont.17813
beq_then.17812:
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
beq_cont.17813:
	j	beq_cont.17811
beq_then.17810:
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
beq_cont.17811:
	addi	r2, r10, -1
	add	r1, r0, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 0(r3)
	lw	r9, 4(r3)
bge_cont.17809:
	addi	r5, r9, -1
	bgei	0, r5, bge_then.17814
	jr	r31				#
bge_then.17814:
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
	bgei	0, r9, bge_then.17816
	jr	r31				#
bge_then.17816:
	add	r30, r1, r9
	lw	r8, 0(r30)
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r2, 0(r2)
	addi	r10, r2, -1
	bgei	0, r10, bge_then.17818
	j	bge_cont.17819
bge_then.17818:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r10
	lw	r7, 0(r30)
	lw	r6, 1(r8)
	lw	r2, 0(r8)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17820
	beqi	2, r5, beq_then.17822
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
	j	beq_cont.17823
beq_then.17822:
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
beq_cont.17823:
	j	beq_cont.17821
beq_then.17820:
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
beq_cont.17821:
	addi	r2, r10, -1
	add	r1, r0, r8
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 0(r3)
	lw	r9, 9(r3)
bge_cont.17819:
	addi	r2, r9, -1
	j	init_dirvec_constants.3321
init_vecset_constants.3324:
	bgei	0, r1, bge_then.17824
	jr	r31				#
bge_then.17824:
	addi	r2, r0, 766				# set min_caml_dirvecs
	add	r30, r2, r1
	lw	r10, 0(r30)
	lw	r8, 119(r10)
	addi	r2, r0, 0				# set min_caml_n_objects
	lw	r2, 0(r2)
	addi	r9, r2, -1
	bgei	0, r9, bge_then.17826
	j	bge_cont.17827
bge_then.17826:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r9
	lw	r7, 0(r30)
	lw	r6, 1(r8)
	lw	r2, 0(r8)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17828
	beqi	2, r5, beq_then.17830
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
	j	beq_cont.17831
beq_then.17830:
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
beq_cont.17831:
	j	beq_cont.17829
beq_then.17828:
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
beq_cont.17829:
	addi	r2, r9, -1
	add	r1, r0, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 1(r3)
	lw	r10, 4(r3)
bge_cont.17827:
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
	bgei	0, r9, bge_then.17832
	j	bge_cont.17833
bge_then.17832:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r9
	lw	r7, 0(r30)
	lw	r6, 1(r8)
	lw	r2, 0(r8)
	lw	r5, 1(r7)
	beqi	1, r5, beq_then.17834
	beqi	2, r5, beq_then.17836
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
	j	beq_cont.17837
beq_then.17836:
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
beq_cont.17837:
	j	beq_cont.17835
beq_then.17834:
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
beq_cont.17835:
	addi	r2, r9, -1
	add	r1, r0, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	lw	r10, 4(r3)
bge_cont.17833:
	addi	r2, r0, 116
	add	r1, r0, r10
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	addi	r8, r1, -1
	bgei	0, r8, bge_then.17838
	jr	r31				#
bge_then.17838:
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
	bgei	0, r9, bge_then.17840
	j	bge_cont.17841
bge_then.17840:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r9
	lw	r6, 0(r30)
	lw	r5, 1(r7)
	lw	r1, 0(r7)
	lw	r2, 1(r6)
	beqi	1, r2, beq_then.17842
	beqi	2, r2, beq_then.17844
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
	j	beq_cont.17845
beq_then.17844:
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
beq_cont.17845:
	j	beq_cont.17843
beq_then.17842:
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
beq_cont.17843:
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
bge_cont.17841:
	addi	r2, r0, 117
	add	r1, r0, r10
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	init_dirvec_constants.3321				
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r8, 8(r3)
	addi	r8, r8, -1
	bgei	0, r8, bge_then.17846
	jr	r31				#
bge_then.17846:
	addi	r1, r0, 766				# set min_caml_dirvecs
	add	r30, r1, r8
	lw	r10, 0(r30)
	lw	r7, 119(r10)
	addi	r1, r0, 0				# set min_caml_n_objects
	lw	r1, 0(r1)
	addi	r9, r1, -1
	bgei	0, r9, bge_then.17848
	j	bge_cont.17849
bge_then.17848:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r9
	lw	r6, 0(r30)
	lw	r5, 1(r7)
	lw	r1, 0(r7)
	lw	r2, 1(r6)
	beqi	1, r2, beq_then.17850
	beqi	2, r2, beq_then.17852
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
	j	beq_cont.17853
beq_then.17852:
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
beq_cont.17853:
	j	beq_cont.17851
beq_then.17850:
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
beq_cont.17851:
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
bge_cont.17849:
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
	bgei	0, r1, bge_then.17854
	jr	r31				#
bge_then.17854:
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
	bgei	0, r8, bge_then.17856
	j	bge_cont.17857
bge_then.17856:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r8
	lw	r6, 0(r30)
	lw	r5, 1(r7)
	lw	r1, 0(r7)
	lw	r2, 1(r6)
	beqi	1, r2, beq_then.17858
	beqi	2, r2, beq_then.17860
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
	j	beq_cont.17861
beq_then.17860:
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
beq_cont.17861:
	j	beq_cont.17859
beq_then.17858:
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
beq_cont.17859:
	addi	r1, r8, -1
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r9, 6(r3)
bge_cont.17857:
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
	bgei	0, r8, bge_then.17862
	j	bge_cont.17863
bge_then.17862:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r8
	lw	r6, 0(r30)
	lw	r5, 1(r7)
	lw	r1, 0(r7)
	lw	r2, 1(r6)
	beqi	1, r2, beq_then.17864
	beqi	2, r2, beq_then.17866
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
	j	beq_cont.17867
beq_then.17866:
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
beq_cont.17867:
	j	beq_cont.17865
beq_then.17864:
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
beq_cont.17865:
	addi	r1, r8, -1
	add	r2, r0, r1
	add	r1, r0, r7
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	iter_setup_dirvec_constants.3103				
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r9, 13(r3)
bge_cont.17863:
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
	bgei	0, r12, bge_then.17869
	j	bge_cont.17870
bge_then.17869:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r12
	lw	r7, 0(r30)
	lw	r1, 1(r7)
	beqi	1, r1, beq_then.17871
	beqi	2, r1, beq_then.17873
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
	j	beq_cont.17874
beq_then.17873:
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
beq_cont.17874:
	j	beq_cont.17872
beq_then.17871:
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
beq_cont.17872:
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
bge_cont.17870:
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
	bgei	0, r13, bge_then.17876
	j	bge_cont.17877
bge_then.17876:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r13
	lw	r7, 0(r30)
	lw	r1, 1(r7)
	beqi	1, r1, beq_then.17878
	beqi	2, r1, beq_then.17880
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
	j	beq_cont.17881
beq_then.17880:
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
beq_cont.17881:
	j	beq_cont.17879
beq_then.17878:
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
beq_cont.17879:
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
bge_cont.17877:
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
	bgei	0, r12, bge_then.17882
	j	bge_cont.17883
bge_then.17882:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r12
	lw	r5, 0(r30)
	lw	r1, 1(r5)
	beqi	1, r1, beq_then.17884
	beqi	2, r1, beq_then.17886
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
	j	beq_cont.17887
beq_then.17886:
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
beq_cont.17887:
	j	beq_cont.17885
beq_then.17884:
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
beq_cont.17885:
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
bge_cont.17883:
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
	bgei	0, r10, bge_then.17889
	j	bge_cont.17890
bge_then.17889:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r10
	lw	r7, 0(r30)
	lw	r1, 1(r7)
	beqi	1, r1, beq_then.17891
	beqi	2, r1, beq_then.17893
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
	j	beq_cont.17894
beq_then.17893:
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
beq_cont.17894:
	j	beq_cont.17892
beq_then.17891:
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
beq_cont.17892:
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
bge_cont.17890:
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
	bgei	0, r1, bge_then.17896
	jr	r31				#
bge_then.17896:
	addi	r2, r0, 1				# set min_caml_objects
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.17898
	jr	r31				#
beq_then.17898:
	flup	f2, 2		# fli	f2, 1.000000
	lw	r5, 7(r2)
	flw	f1, 0(r5)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17900
	jr	r31				#
fle_else.17900:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.17902
	beqi	2, r5, beq_then.17903
	jr	r31				#
beq_then.17903:
	j	setup_surface_reflection.3338
beq_then.17902:
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
	add	r11, r0, r1
	lw	r2, 3(r3)
	lw	r5, 1(r3)
	lw	r8, 2(r3)
	lw	r13, 0(r3)
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
	lw	r11, 4(r3)
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
	lw	r11, 4(r3)
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
	lw	r11, 4(r3)
	lw	r13, 0(r3)
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
	add	r11, r0, r1
	lw	r6, 8(r3)
	lw	r2, 12(r3)
	lw	r5, 10(r3)
	lw	r9, 11(r3)
	lw	r13, 13(r3)
	lw	r14, 9(r3)
	sw	r11, 14(r3)
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
	lw	r11, 14(r3)
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
	lw	r11, 14(r3)
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
	lw	r11, 14(r3)
	lw	r13, 13(r3)
	lw	r14, 9(r3)
	add	r1, r0, r4
	addi	r4, r4, 8
	sw	r8, 7(r1)
	sw	r10, 6(r1)
	sw	r7, 5(r1)
	sw	r11, 4(r1)
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
	add	r11, r0, r1
	lw	r6, 8(r3)
	lw	r2, 21(r3)
	lw	r5, 19(r3)
	lw	r9, 20(r3)
	lw	r13, 22(r3)
	lw	r14, 17(r3)
	lw	r15, 18(r3)
	sw	r11, 23(r3)
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
	lw	r11, 23(r3)
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
	lw	r11, 23(r3)
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
	lw	r11, 23(r3)
	lw	r13, 22(r3)
	lw	r14, 17(r3)
	lw	r15, 18(r3)
	add	r1, r0, r4
	addi	r4, r4, 8
	sw	r8, 7(r1)
	sw	r10, 6(r1)
	sw	r7, 5(r1)
	sw	r11, 4(r1)
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
	beqi	0, r2, beq_then.17905
	addi	r1, r0, 1
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_object.2998				
	addi	r3, r3, -29
	lw	r31, 28(r3)
	lw	r6, 8(r3)
	lw	r7, 26(r3)
	lw	r14, 17(r3)
	j	beq_cont.17906
beq_then.17905:
	addi	r2, r0, 0				# set min_caml_n_objects
	sw	r1, 0(r2)
beq_cont.17906:
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
	bgei	0, r10, bge_then.17907
	j	bge_cont.17908
bge_then.17907:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r10
	lw	r8, 0(r30)
	lw	r5, 1(r9)
	lw	r1, 0(r9)
	lw	r2, 1(r8)
	beqi	1, r2, beq_then.17909
	beqi	2, r2, beq_then.17911
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
	j	beq_cont.17912
beq_then.17911:
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
beq_cont.17912:
	j	beq_cont.17910
beq_then.17909:
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
beq_cont.17910:
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
bge_cont.17908:
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
	bgei	0, r5, bge_then.17913
	j	bge_cont.17914
bge_then.17913:
	addi	r1, r0, 1				# set min_caml_objects
	add	r30, r1, r5
	lw	r1, 0(r30)
	lw	r2, 2(r1)
	beqi	2, r2, beq_then.17915
	j	beq_cont.17916
beq_then.17915:
	flup	f2, 2		# fli	f2, 1.000000
	lw	r2, 7(r1)
	flw	f1, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17917
	j	fle_cont.17918
fle_else.17917:
	lw	r2, 1(r1)
	beqi	1, r2, beq_then.17919
	beqi	2, r2, beq_then.17921
	j	beq_cont.17922
beq_then.17921:
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
beq_cont.17922:
	j	beq_cont.17920
beq_then.17919:
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
beq_cont.17920:
fle_cont.17918:
beq_cont.17916:
bge_cont.17914:
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
	blei	0, r1, ble_then.17923
	addi	r1, r0, 743				# set min_caml_image_size
	lw	r1, 1(r1)
	addi	r1, r1, -1
	blei	0, r1, ble_then.17924
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
	j	ble_cont.17925
ble_then.17924:
ble_cont.17925:
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
ble_then.17923:
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
