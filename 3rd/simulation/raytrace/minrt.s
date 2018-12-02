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
	beq	r0, r30, _fle_else.749
	addi	r1, r0, 0
	jr	r31				#
_fle_else.749:
	addi	r1, r0, 1
	jr	r31				#
lib_fisneg:
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.750
	addi	r1, r0, 0
	jr	r31				#
_fle_else.750:
	addi	r1, r0, 1
	jr	r31				#
lib_fiszero:
	feq	r30, f1, f0
	beq	r0, r30, _feq_else.751
	addi	r1, r0, 1
	jr	r31				#
_feq_else.751:
	addi	r1, r0, 0
	jr	r31				#
lib_xor:
	beq	r1, r2, _beq_then.752
	addi	r1, r0, 1
	jr	r31				#
_beq_then.752:
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
	beq	r0, r30, _fle_else.753
	jr	r31				#
_fle_else.753:
	fneg	f1, f1
	jr	r31				#
lib_int_of_float:
	feq	r30, f1, f0
	beq	r0, r30, _feq_else.754
	addi	r1, r0, 0
	jr	r31				#
_feq_else.754:
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.755
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
_fle_else.755:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
lib_float_of_int:
	itof	r1, r1
	jr	r31				#
lib_floor:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
	itof	f1, r1
	flw	f2, 0(r3)
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.756
	jr	r31				#
_fle_else.756:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
	jr	r31				#
lib_hoge:
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.757
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.758
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j lib_hoge
_fle_else.758:
	fadd	f1, f0, f2
	jr	r31				#
_fle_else.757:
	fadd	f1, f0, f2
	jr	r31				#
lib_fuga:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.759
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.760
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j lib_fuga
_fle_else.760:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j lib_fuga
_fle_else.759:
	jr	r31				#
lib_modulo_2pi:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 0(r3)
	fsw	f1, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.761
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal lib_hoge				#	bl lib_hoge
	addi	r3, r3, -5
	lw	r31, 4(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	_fle_cont.762
_fle_else.761:
_fle_cont.762:
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
	beq	r0, r30, _fle_else.763
	jr	r31				#
_fle_else.763:
	fneg	f1, f1
	jr	r31				#
lib_sin:
	flup	f2, 14		# fli	f2, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.764
	flup	f3, 2		# fli	f3, 1.000000
	j	_fle_cont.765
_fle_else.764:
	flup	f3, 11		# fli	f3, -1.000000
_fle_cont.765:
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.766
	j	_fle_cont.767
_fle_else.766:
	fneg	f1, f1
_fle_cont.767:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal lib_modulo_2pi				#	bl lib_modulo_2pi
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.768
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.769
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.770
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.770:
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
_fle_else.769:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.771
	fsw	f3, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.771:
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
_fle_else.768:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.772
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.773
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.773:
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
_fle_else.772:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.774
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_sin_body				#	bl lib_sin_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.774:
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
	beq	r0, r30, _fle_else.775
	j	_fle_cont.776
_fle_else.775:
	fneg	f1, f1
_fle_cont.776:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal lib_modulo_2pi				#	bl lib_modulo_2pi
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, _fle_else.777
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, _fle_else.778
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, _fle_else.779
	fsw	f2, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.779:
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
_fle_else.778:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.780
	fsw	f3, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.780:
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
_fle_else.777:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.781
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, _fle_else.782
	fsw	f2, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.782:
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
_fle_else.781:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.783
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal lib_cos_body				#	bl lib_cos_body
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
_fle_else.783:
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
	beq	r0, r30, _fle_else.784
	flup	f2, 2		# fli	f2, 1.000000
	j	_fle_cont.785
_fle_else.784:
	flup	f2, 11		# fli	f2, -1.000000
_fle_cont.785:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.786
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, _fle_else.787
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
_fle_else.787:
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
_fle_else.786:
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
	ble	r7, r1, _ble_then.788
	add	r5, r0, r6				# mr	r5, r6
	j lib_div10_sub
_ble_then.788:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, _ble_then.789
	add	r2, r0, r6				# mr	r2, r6
	j lib_div10_sub
_ble_then.789:
	add	r1, r0, r6
	jr	r31				#
lib_div10:
	addi	r2, r0, 0
	add	r5, r0, r1				# mr	r5, r1
	j lib_div10_sub
lib_iter_mul10:
	beqi	0, r2, _beq_then.790
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	j lib_iter_mul10
_beq_then.790:
	jr	r31				#
lib_iter_div10:
	beqi	0, r2, _beq_then.791
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
_beq_then.791:
	jr	r31				#
lib_keta_sub:
	addi	r5, r0, 10
	ble	r5, r1, _ble_then.792
	addi	r1, r2, 1
	jr	r31				#
_ble_then.792:
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
	beqi	1, r2, _beq_then.793
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
	ble	r1, r2, _ble_then.794
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
_ble_then.794:
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
_beq_then.793:
	addi	r1, r1, 48
	j	lib_print_char
lib_print_uint:
	addi	r2, r0, 10
	ble	r2, r1, _ble_then.795
	addi	r1, r1, 48
	j	lib_print_char
_ble_then.795:
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
	ble	r2, r1, _ble_then.796
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
_ble_then.796:
	j lib_print_uint
lib_truncate:
	j lib_int_of_float
lib_print_dec:
	feq	r30, f1, f0
	beq	r0, r30, _feq_else.797
	jr	r31				#
_feq_else.797:
	flup	f2, 39		# fli	f2, 10.000000
	fmul	f1, f2, f1
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_print_int				#	bl lib_print_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
	itof	f1, r1
	flw	f2, 0(r3)
	fsub	f1, f2, f1
	j lib_print_dec
lib_print_ufloat:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
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
	flw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal lib_int_of_float				#	bl lib_int_of_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
	itof	f1, r1
	flw	f2, 0(r3)
	fle	r30, f1, f2
	beq	r0, r30, _fle_else.799
	j	_fle_cont.800
_fle_else.799:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f1, f1, f3
_fle_cont.800:
	fsub	f1, f2, f1
	j lib_print_dec
lib_print_float:
	fle	r30, f0, f1
	beq	r0, r30, _fle_else.801
	j lib_print_ufloat
_fle_else.801:
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
print_char.2795:
	out	r1
	jr	r31				#
fispos.2797:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15798
	addi	r1, r0, 0
	jr	r31				#
fle_else.15798:
	addi	r1, r0, 1
	jr	r31				#
fisneg.2799:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15799
	addi	r1, r0, 0
	jr	r31				#
fle_else.15799:
	addi	r1, r0, 1
	jr	r31				#
fiszero.2801:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15800
	addi	r1, r0, 1
	jr	r31				#
feq_else.15800:
	addi	r1, r0, 0
	jr	r31				#
xor.2803:
	beq	r1, r2, beq_then.15801
	addi	r1, r0, 1
	jr	r31				#
beq_then.15801:
	addi	r1, r0, 0
	jr	r31				#
fhalf.2806:
	flup	f2, 1		# fli	f2, 0.500000
	fmul	f1, f1, f2
	jr	r31				#
fsqr.2808:
	fmul	f1, f1, f1
	jr	r31				#
fabs.2810:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15802
	jr	r31				#
fle_else.15802:
	fneg	f1, f1
	jr	r31				#
int_of_float.2812:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15803
	addi	r1, r0, 0
	jr	r31				#
feq_else.15803:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15804
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
fle_else.15804:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
float_of_int.2814:
	itof	r1, r1
	jr	r31				#
floor.2816:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15805
	addi	r1, r0, 0
	j	feq_cont.15806
feq_else.15805:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15807
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.15808
fle_else.15807:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.15808:
feq_cont.15806:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15809
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15809:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
	jr	r31				#
hoge.2818:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15810
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15811
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15812
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15813
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15814
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15815
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15816
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15817
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15818
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15819
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15820
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15821
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15822
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15823
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15824
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15825
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2818
fle_else.15825:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15824:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15823:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15822:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15821:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15820:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15819:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15818:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15817:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15816:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15815:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15814:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15813:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15812:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15811:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.15810:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2821:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15826
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15827
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15828
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15829
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2821
fle_else.15829:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2821
fle_else.15828:
	jr	r31				#
fle_else.15827:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15830
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15831
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2821
fle_else.15831:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2821
fle_else.15830:
	jr	r31				#
fle_else.15826:
	jr	r31				#
modulo_2pi.2825:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 0(r3)
	fsw	f1, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15832
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15834
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15836
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15838
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15840
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15842
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15844
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15846
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15848
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15850
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15852
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15854
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15856
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15858
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15860
	addi	r30, r0, 4060
	lui	r30, r30, 18505	# to load float		205887.438848
	fmvfr	f2, r30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	hoge.2818				#	bl	hoge.2818
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	fle_cont.15861
fle_else.15860:
	fadd	f1, f0, f2
fle_cont.15861:
	j	fle_cont.15859
fle_else.15858:
	fadd	f1, f0, f2
fle_cont.15859:
	j	fle_cont.15857
fle_else.15856:
	fadd	f1, f0, f2
fle_cont.15857:
	j	fle_cont.15855
fle_else.15854:
	fadd	f1, f0, f2
fle_cont.15855:
	j	fle_cont.15853
fle_else.15852:
	fadd	f1, f0, f2
fle_cont.15853:
	j	fle_cont.15851
fle_else.15850:
	fadd	f1, f0, f2
fle_cont.15851:
	j	fle_cont.15849
fle_else.15848:
	fadd	f1, f0, f2
fle_cont.15849:
	j	fle_cont.15847
fle_else.15846:
	fadd	f1, f0, f2
fle_cont.15847:
	j	fle_cont.15845
fle_else.15844:
	fadd	f1, f0, f2
fle_cont.15845:
	j	fle_cont.15843
fle_else.15842:
	fadd	f1, f0, f2
fle_cont.15843:
	j	fle_cont.15841
fle_else.15840:
	fadd	f1, f0, f2
fle_cont.15841:
	j	fle_cont.15839
fle_else.15838:
	fadd	f1, f0, f2
fle_cont.15839:
	j	fle_cont.15837
fle_else.15836:
	fadd	f1, f0, f2
fle_cont.15837:
	j	fle_cont.15835
fle_else.15834:
	fadd	f1, f0, f2
fle_cont.15835:
	j	fle_cont.15833
fle_else.15832:
	fadd	f1, f0, f2
fle_cont.15833:
	flup	f2, 5		# fli	f2, 6.283186
	flw	f3, 2(r3)
	fle	r30, f2, f3
	beq	r0, r30, fle_else.15862
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15863
	fsub	f2, f3, f1
	flup	f3, 3		# fli	f3, 2.000000
	fdiv	f1, f1, f3
	flw	f3, 0(r3)
	fadd	f30, f0, f2				# fmr	f30, f2
	fadd	f2, f0, f1				# fmr	f2, f1
	fadd	f1, f0, f30				# fmr	f1, f30
	j	fuga.2821
fle_else.15863:
	flup	f2, 3		# fli	f2, 2.000000
	fdiv	f2, f1, f2
	flw	f1, 0(r3)
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f30				# fmr	f1, f30
	j	fuga.2821
fle_else.15862:
	fadd	f1, f0, f3
	jr	r31				#
sin_body.2827:
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
cos_body.2829:
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
sin.2831:
	flup	f2, 14		# fli	f2, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15864
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.15865
fle_else.15864:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.15865:
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
	beq	r0, r30, fle_else.15866
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15868
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15870
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15872
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15874
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15876
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15878
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15880
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15882
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15884
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15886
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15888
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15890
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15892
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2818				#	bl	hoge.2818
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.15893
fle_else.15892:
fle_cont.15893:
	j	fle_cont.15891
fle_else.15890:
fle_cont.15891:
	j	fle_cont.15889
fle_else.15888:
fle_cont.15889:
	j	fle_cont.15887
fle_else.15886:
fle_cont.15887:
	j	fle_cont.15885
fle_else.15884:
fle_cont.15885:
	j	fle_cont.15883
fle_else.15882:
fle_cont.15883:
	j	fle_cont.15881
fle_else.15880:
fle_cont.15881:
	j	fle_cont.15879
fle_else.15878:
fle_cont.15879:
	j	fle_cont.15877
fle_else.15876:
fle_cont.15877:
	j	fle_cont.15875
fle_else.15874:
fle_cont.15875:
	j	fle_cont.15873
fle_else.15872:
fle_cont.15873:
	j	fle_cont.15871
fle_else.15870:
fle_cont.15871:
	j	fle_cont.15869
fle_else.15868:
fle_cont.15869:
	j	fle_cont.15867
fle_else.15866:
fle_cont.15867:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2821				#	bl	fuga.2821
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15894
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15895
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15896
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
fle_else.15896:
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
fle_else.15895:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15897
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
fle_else.15897:
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
fle_else.15894:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15898
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15899
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
fle_else.15899:
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
fle_else.15898:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15900
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
fle_else.15900:
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
cos.2833:
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
	beq	r0, r30, fle_else.15901
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15903
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15905
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15907
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15909
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15911
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15913
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15915
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15917
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15919
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15921
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15923
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15925
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15927
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2818				#	bl	hoge.2818
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.15928
fle_else.15927:
fle_cont.15928:
	j	fle_cont.15926
fle_else.15925:
fle_cont.15926:
	j	fle_cont.15924
fle_else.15923:
fle_cont.15924:
	j	fle_cont.15922
fle_else.15921:
fle_cont.15922:
	j	fle_cont.15920
fle_else.15919:
fle_cont.15920:
	j	fle_cont.15918
fle_else.15917:
fle_cont.15918:
	j	fle_cont.15916
fle_else.15915:
fle_cont.15916:
	j	fle_cont.15914
fle_else.15913:
fle_cont.15914:
	j	fle_cont.15912
fle_else.15911:
fle_cont.15912:
	j	fle_cont.15910
fle_else.15909:
fle_cont.15910:
	j	fle_cont.15908
fle_else.15907:
fle_cont.15908:
	j	fle_cont.15906
fle_else.15905:
fle_cont.15906:
	j	fle_cont.15904
fle_else.15903:
fle_cont.15904:
	j	fle_cont.15902
fle_else.15901:
fle_cont.15902:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2821				#	bl	fuga.2821
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.15929
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.15930
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15931
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
fle_else.15931:
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
fle_else.15930:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15932
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
fle_else.15932:
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
fle_else.15929:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15933
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.15934
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
fle_else.15934:
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
fle_else.15933:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.15935
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
fle_else.15935:
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
atan_body.2835:
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
atan.2837:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.15936
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.15937
fle_else.15936:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.15937:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15938
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.15939
	flup	f3, 15		# fli	f3, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.15939:
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
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.15938:
	j	atan_body.2835
print_num.2839:
	addi	r1, r1, 48
	out	r1
	jr	r31				#
mul10.2841:
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	jr	r31				#
div10_sub.2843:
	add	r6, r2, r5
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.15940
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r7, r5, 3
	slli	r8, r5, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.15941
	j	div10_sub.2843
ble_then.15941:
	slli	r2, r5, 3
	slli	r7, r5, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15942
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	j	div10_sub.2843
ble_then.15942:
	add	r1, r0, r5
	jr	r31				#
ble_then.15940:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15943
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r7, r2, 3
	slli	r8, r2, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.15944
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r6				# mr	r2, r6
	j	div10_sub.2843
ble_then.15944:
	slli	r6, r2, 3
	slli	r7, r2, 1
	add	r6, r6, r7
	addi	r6, r6, 9
	ble	r1, r6, ble_then.15945
	j	div10_sub.2843
ble_then.15945:
	add	r1, r0, r2
	jr	r31				#
ble_then.15943:
	add	r1, r0, r6
	jr	r31				#
div10.2847:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.15946
	j	div10_sub.2843
ble_then.15946:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15947
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	j	div10_sub.2843
ble_then.15947:
	add	r1, r0, r5
	jr	r31				#
print_uint.2849:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.15948
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.15948:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10_sub.2843				#	bl	div10_sub.2843
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 10
	sw	r1, 1(r3)
	ble	r2, r1, ble_then.15949
	addi	r2, r1, 48
	out	r2
	j	ble_cont.15950
ble_then.15949:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.15951
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2843				#	bl	div10_sub.2843
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.15952
ble_then.15951:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15953
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2843				#	bl	div10_sub.2843
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.15954
ble_then.15953:
	add	r1, r0, r5
ble_cont.15954:
ble_cont.15952:
	addi	r2, r0, 10
	sw	r1, 2(r3)
	ble	r2, r1, ble_then.15955
	addi	r2, r1, 48
	out	r2
	j	ble_cont.15956
ble_then.15955:
	addi	r2, r0, 0
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2843				#	bl	div10_sub.2843
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 10
	sw	r1, 3(r3)
	ble	r2, r1, ble_then.15957
	addi	r2, r1, 48
	out	r2
	j	ble_cont.15958
ble_then.15957:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.15959
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2843				#	bl	div10_sub.2843
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.15960
ble_then.15959:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.15961
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2843				#	bl	div10_sub.2843
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.15962
ble_then.15961:
	add	r1, r0, r5
ble_cont.15962:
ble_cont.15960:
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	print_uint.2849				#	bl	print_uint.2849
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 3(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.15958:
	lw	r1, 3(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 2(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.15956:
	lw	r1, 2(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 1(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.15950:
	lw	r1, 1(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
	jr	r31				#
print_int.2851:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.15963
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	j	print_int.2851
ble_then.15963:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.15964
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.15964:
	addi	r2, r0, 100
	ble	r2, r1, ble_then.15965
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
ble_then.15965:
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
xor.2853:
	beqi	0, r1, beq_then.15966
	beqi	0, r2, beq_then.15967
	addi	r1, r0, 0
	jr	r31				#
beq_then.15967:
	addi	r1, r0, 1
	jr	r31				#
beq_then.15966:
	add	r1, r0, r2
	jr	r31				#
sgn.2856:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.15968
	addi	r1, r0, 1
	j	feq_cont.15969
feq_else.15968:
	addi	r1, r0, 0
feq_cont.15969:
	beqi	0, r1, beq_then.15970
	flup	f1, 0		# fli	f1, 0.000000
	jr	r31				#
beq_then.15970:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.15971
	addi	r1, r0, 0
	j	fle_cont.15972
fle_else.15971:
	addi	r1, r0, 1
fle_cont.15972:
	beqi	0, r1, beq_then.15973
	flup	f1, 2		# fli	f1, 1.000000
	jr	r31				#
beq_then.15973:
	flup	f1, 11		# fli	f1, -1.000000
	jr	r31				#
fneg_cond.2858:
	beqi	0, r1, beq_then.15974
	jr	r31				#
beq_then.15974:
	fneg	f1, f1
	jr	r31				#
add_mod5.2861:
	add	r1, r1, r2
	addi	r2, r0, 5
	ble	r2, r1, ble_then.15975
	jr	r31				#
ble_then.15975:
	addi	r1, r1, -5
	jr	r31				#
vecset.2864:
	fsw	f1, 0(r1)
	fsw	f2, 1(r1)
	fsw	f3, 2(r1)
	jr	r31				#
vecfill.2869:
	fsw	f1, 0(r1)
	fsw	f1, 1(r1)
	fsw	f1, 2(r1)
	jr	r31				#
vecbzero.2872:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
	fsw	f1, 1(r1)
	fsw	f1, 2(r1)
	jr	r31				#
veccpy.2874:
	flw	f1, 0(r2)
	fsw	f1, 0(r1)
	flw	f1, 1(r2)
	fsw	f1, 1(r1)
	flw	f1, 2(r2)
	fsw	f1, 2(r1)
	jr	r31				#
vecdist2.2877:
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
vecunit.2880:
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
vecunit_sgn.2882:
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
	beq	r0, r30, feq_else.15981
	addi	r5, r0, 1
	j	feq_cont.15982
feq_else.15981:
	addi	r5, r0, 0
feq_cont.15982:
	beqi	0, r5, beq_then.15983
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.15984
beq_then.15983:
	beqi	0, r2, beq_then.15985
	flup	f2, 11		# fli	f2, -1.000000
	fdiv	f1, f2, f1
	j	beq_cont.15986
beq_then.15985:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
beq_cont.15986:
beq_cont.15984:
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
veciprod.2885:
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
veciprod2.2888:
	flw	f4, 0(r1)
	fmul	f1, f4, f1
	flw	f4, 1(r1)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	jr	r31				#
vecaccum.2893:
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
vecadd.2897:
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
vecmul.2900:
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
vecscale.2903:
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
vecaccumv.2906:
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
o_texturetype.2910:
	lw	r1, 0(r1)
	jr	r31				#
o_form.2912:
	lw	r1, 1(r1)
	jr	r31				#
o_reflectiontype.2914:
	lw	r1, 2(r1)
	jr	r31				#
o_isinvert.2916:
	lw	r1, 6(r1)
	jr	r31				#
o_isrot.2918:
	lw	r1, 3(r1)
	jr	r31				#
o_param_a.2920:
	lw	r1, 4(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_param_b.2922:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_param_c.2924:
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_param_abc.2926:
	lw	r1, 4(r1)
	jr	r31				#
o_param_x.2928:
	lw	r1, 5(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_param_y.2930:
	lw	r1, 5(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_param_z.2932:
	lw	r1, 5(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_diffuse.2934:
	lw	r1, 7(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_hilight.2936:
	lw	r1, 7(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_color_red.2938:
	lw	r1, 8(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_color_green.2940:
	lw	r1, 8(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_color_blue.2942:
	lw	r1, 8(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_param_r1.2944:
	lw	r1, 9(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_param_r2.2946:
	lw	r1, 9(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_param_r3.2948:
	lw	r1, 9(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_param_ctbl.2950:
	lw	r1, 10(r1)
	jr	r31				#
p_rgb.2952:
	lw	r1, 0(r1)
	jr	r31				#
p_intersection_points.2954:
	lw	r1, 1(r1)
	jr	r31				#
p_surface_ids.2956:
	lw	r1, 2(r1)
	jr	r31				#
p_calc_diffuse.2958:
	lw	r1, 3(r1)
	jr	r31				#
p_energy.2960:
	lw	r1, 4(r1)
	jr	r31				#
p_received_ray_20percent.2962:
	lw	r1, 5(r1)
	jr	r31				#
p_group_id.2964:
	lw	r1, 6(r1)
	lw	r1, 0(r1)
	jr	r31				#
p_set_group_id.2966:
	lw	r1, 6(r1)
	sw	r2, 0(r1)
	jr	r31				#
p_nvectors.2969:
	lw	r1, 7(r1)
	jr	r31				#
d_vec.2971:
	lw	r1, 0(r1)
	jr	r31				#
d_const.2973:
	lw	r1, 1(r1)
	jr	r31				#
r_surface_id.2975:
	lw	r1, 0(r1)
	jr	r31				#
r_dvec.2977:
	lw	r1, 1(r1)
	jr	r31				#
r_bright.2979:
	flw	f1, 2(r1)
	jr	r31				#
rad.2981:
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	jr	r31				#
read_screen_settings.2983:
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
	jal	cos.2833				#	bl	cos.2833
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2831				#	bl	sin.2831
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
	jal	cos.2833				#	bl	cos.2833
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fsw	f1, 12(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin.2831				#	bl	sin.2831
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
read_light.2985:
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
	jal	sin.2831				#	bl	sin.2831
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
	jal	cos.2833				#	bl	cos.2833
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin.2831				#	bl	sin.2831
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 10667
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	flw	f1, 2(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2833				#	bl	cos.2833
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
rotate_quadratic_matrix.2987:
	flw	f1, 0(r2)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	cos.2833				#	bl	cos.2833
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2831				#	bl	sin.2831
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2833				#	bl	cos.2833
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2831				#	bl	sin.2831
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos.2833				#	bl	cos.2833
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 10(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2831				#	bl	sin.2831
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
read_nth_object.2990:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.15998
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
	beq	r0, r30, fle_else.15999
	addi	r1, r0, 0
	j	fle_cont.16000
fle_else.15999:
	addi	r1, r0, 1
fle_cont.16000:
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
	beqi	0, r2, beq_then.16001
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
	j	beq_cont.16002
beq_then.16001:
beq_cont.16002:
	lw	r2, 2(r3)
	beqi	2, r2, beq_then.16003
	lw	r5, 7(r3)
	j	beq_cont.16004
beq_then.16003:
	addi	r5, r0, 1
beq_cont.16004:
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
	beqi	3, r7, beq_then.16005
	beqi	2, r7, beq_then.16007
	j	beq_cont.16008
beq_then.16007:
	lw	r2, 7(r3)
	beqi	0, r2, beq_then.16009
	addi	r2, r0, 0
	j	beq_cont.16010
beq_then.16009:
	addi	r2, r0, 1
beq_cont.16010:
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	vecunit_sgn.2882				#	bl	vecunit_sgn.2882
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.16008:
	j	beq_cont.16006
beq_then.16005:
	flw	f1, 0(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16011
	addi	r2, r0, 1
	j	feq_cont.16012
feq_else.16011:
	addi	r2, r0, 0
feq_cont.16012:
	beqi	0, r2, beq_then.16013
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16014
beq_then.16013:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16015
	addi	r2, r0, 1
	j	feq_cont.16016
feq_else.16015:
	addi	r2, r0, 0
feq_cont.16016:
	beqi	0, r2, beq_then.16017
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16018
beq_then.16017:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16019
	addi	r2, r0, 0
	j	fle_cont.16020
fle_else.16019:
	addi	r2, r0, 1
fle_cont.16020:
	beqi	0, r2, beq_then.16021
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.16022
beq_then.16021:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.16022:
beq_cont.16018:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.16014:
	fsw	f1, 0(r5)
	flw	f1, 1(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16023
	addi	r2, r0, 1
	j	feq_cont.16024
feq_else.16023:
	addi	r2, r0, 0
feq_cont.16024:
	beqi	0, r2, beq_then.16025
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16026
beq_then.16025:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16027
	addi	r2, r0, 1
	j	feq_cont.16028
feq_else.16027:
	addi	r2, r0, 0
feq_cont.16028:
	beqi	0, r2, beq_then.16029
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16030
beq_then.16029:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16031
	addi	r2, r0, 0
	j	fle_cont.16032
fle_else.16031:
	addi	r2, r0, 1
fle_cont.16032:
	beqi	0, r2, beq_then.16033
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.16034
beq_then.16033:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.16034:
beq_cont.16030:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.16026:
	fsw	f1, 1(r5)
	flw	f1, 2(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16035
	addi	r2, r0, 1
	j	feq_cont.16036
feq_else.16035:
	addi	r2, r0, 0
feq_cont.16036:
	beqi	0, r2, beq_then.16037
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16038
beq_then.16037:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16039
	addi	r2, r0, 1
	j	feq_cont.16040
feq_else.16039:
	addi	r2, r0, 0
feq_cont.16040:
	beqi	0, r2, beq_then.16041
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.16042
beq_then.16041:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16043
	addi	r2, r0, 0
	j	fle_cont.16044
fle_else.16043:
	addi	r2, r0, 1
fle_cont.16044:
	beqi	0, r2, beq_then.16045
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.16046
beq_then.16045:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.16046:
beq_cont.16042:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.16038:
	fsw	f1, 2(r5)
beq_cont.16006:
	lw	r1, 4(r3)
	beqi	0, r1, beq_then.16047
	lw	r1, 5(r3)
	lw	r2, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	rotate_quadratic_matrix.2987				#	bl	rotate_quadratic_matrix.2987
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.16048
beq_then.16047:
beq_cont.16048:
	addi	r1, r0, 1
	jr	r31				#
beq_then.15998:
	addi	r1, r0, 0
	jr	r31				#
read_object.2992:
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16049
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2990				#	bl	read_nth_object.2990
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.16050
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16051
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2990				#	bl	read_nth_object.2990
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.16052
	lw	r1, 1(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16053
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_nth_object.2990				#	bl	read_nth_object.2990
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16054
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.16055
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_nth_object.2990				#	bl	read_nth_object.2990
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.16056
	lw	r1, 3(r3)
	addi	r1, r1, 1
	j	read_object.2992
beq_then.16056:
	addi	r1, r0, 10000
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.16055:
	jr	r31				#
beq_then.16054:
	addi	r1, r0, 10000
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.16053:
	jr	r31				#
beq_then.16052:
	addi	r1, r0, 10000
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.16051:
	jr	r31				#
beq_then.16050:
	addi	r1, r0, 10000
	lw	r2, 0(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.16049:
	jr	r31				#
read_all_object.2994:
	addi	r1, r0, 0
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2990				#	bl	read_nth_object.2990
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.16065
	addi	r1, r0, 1
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2990				#	bl	read_nth_object.2990
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.16066
	addi	r1, r0, 2
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_nth_object.2990				#	bl	read_nth_object.2990
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16067
	addi	r1, r0, 3
	j	read_object.2992
beq_then.16067:
	addi	r1, r0, 10000
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	jr	r31				#
beq_then.16066:
	addi	r1, r0, 10000
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	jr	r31				#
beq_then.16065:
	addi	r1, r0, 10000
	lw	r2, 0(r3)
	sw	r2, 0(r1)
	jr	r31				#
read_net_item.2996:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.16071
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.16072
	lw	r2, 2(r3)
	addi	r5, r2, 1
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.16074
	lw	r2, 4(r3)
	addi	r5, r2, 1
	sw	r1, 5(r3)
	sw	r5, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.16076
	lw	r2, 6(r3)
	addi	r5, r2, 1
	sw	r1, 7(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.2996				#	bl	read_net_item.2996
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.16077
beq_then.16076:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.16077:
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.16075
beq_then.16074:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.16075:
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.16073
beq_then.16072:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.16073:
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.16071:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	j	lib_create_array
read_or_network.2998:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.16078
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.16080
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.16082
	addi	r2, r0, 3
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.2996				#	bl	read_net_item.2996
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 2(r1)
	j	beq_cont.16083
beq_then.16082:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16083:
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.16081
beq_then.16080:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16081:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.16079
beq_then.16078:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.16079:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.16084
	lw	r1, 0(r3)
	addi	r5, r1, 1
	sw	r2, 4(r3)
	sw	r5, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.16085
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.16087
	addi	r2, r0, 2
	sw	r1, 7(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.2996				#	bl	read_net_item.2996
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 7(r3)
	sw	r2, 1(r1)
	j	beq_cont.16088
beq_then.16087:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.16088:
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.16086
beq_then.16085:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.16086:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.16089
	lw	r1, 5(r3)
	addi	r5, r1, 1
	sw	r2, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	read_or_network.2998				#	bl	read_or_network.2998
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 5(r3)
	lw	r5, 8(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.16090
beq_then.16089:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.16090:
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.16084:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.3000:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.16091
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.16093
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.16095
	addi	r2, r0, 3
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.2996				#	bl	read_net_item.2996
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 2(r1)
	j	beq_cont.16096
beq_then.16095:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16096:
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.16094
beq_then.16093:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16094:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	j	beq_cont.16092
beq_then.16091:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16092:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.16097
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
	beqi	-1, r1, beq_then.16098
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.16100
	addi	r2, r0, 2
	sw	r1, 6(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	read_net_item.2996				#	bl	read_net_item.2996
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	sw	r2, 1(r1)
	j	beq_cont.16101
beq_then.16100:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.16101:
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	j	beq_cont.16099
beq_then.16098:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.16099:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.16102
	addi	r2, r0, 10672
	lw	r5, 4(r3)
	add	r30, r2, r5
	sw	r1, 0(r30)
	addi	r1, r5, 1
	j	read_and_network.3000
beq_then.16102:
	jr	r31				#
beq_then.16097:
	jr	r31				#
read_parameter.3002:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_screen_settings.2983				#	bl	read_screen_settings.2983
	addi	r3, r3, -1
	lw	r31, 0(r3)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_light.2985				#	bl	read_light.2985
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.2990				#	bl	read_nth_object.2990
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.16105
	addi	r1, r0, 1
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.2990				#	bl	read_nth_object.2990
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.16107
	addi	r1, r0, 2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_object.2992				#	bl	read_object.2992
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.16108
beq_then.16107:
	addi	r1, r0, 10000
	lw	r2, 1(r3)
	sw	r2, 0(r1)
beq_cont.16108:
	j	beq_cont.16106
beq_then.16105:
	addi	r1, r0, 10000
	lw	r2, 0(r3)
	sw	r2, 0(r1)
beq_cont.16106:
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.16109
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.16111
	addi	r2, r0, 2
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.2996				#	bl	read_net_item.2996
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 1(r1)
	j	beq_cont.16112
beq_then.16111:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16112:
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	j	beq_cont.16110
beq_then.16109:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16110:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.16113
	addi	r2, r0, 10672
	sw	r1, 0(r2)
	addi	r1, r0, 1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_and_network.3000				#	bl	read_and_network.3000
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16114
beq_then.16113:
beq_cont.16114:
	addi	r1, r0, 10723
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.16115
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.16117
	addi	r2, r0, 2
	sw	r1, 6(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	read_net_item.2996				#	bl	read_net_item.2996
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	sw	r2, 1(r1)
	j	beq_cont.16118
beq_then.16117:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.16118:
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.16116
beq_then.16115:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.16116:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.16119
	addi	r1, r0, 1
	sw	r2, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_or_network.2998				#	bl	read_or_network.2998
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 7(r3)
	sw	r2, 0(r1)
	j	beq_cont.16120
beq_then.16119:
	addi	r1, r0, 1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.16120:
	lw	r2, 4(r3)
	sw	r1, 0(r2)
	jr	r31				#
solver_rect_surface.3004:
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16122
	addi	r8, r0, 1
	j	feq_cont.16123
feq_else.16122:
	addi	r8, r0, 0
feq_cont.16123:
	beqi	0, r8, beq_then.16124
	addi	r1, r0, 0
	jr	r31				#
beq_then.16124:
	lw	r8, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16125
	addi	r9, r0, 0
	j	fle_cont.16126
fle_else.16125:
	addi	r9, r0, 1
fle_cont.16126:
	beqi	0, r1, beq_then.16127
	beqi	0, r9, beq_then.16129
	addi	r1, r0, 0
	j	beq_cont.16130
beq_then.16129:
	addi	r1, r0, 1
beq_cont.16130:
	j	beq_cont.16128
beq_then.16127:
	add	r1, r0, r9
beq_cont.16128:
	add	r30, r8, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.16131
	j	beq_cont.16132
beq_then.16131:
	fneg	f4, f4
beq_cont.16132:
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
	beq	r0, r30, fle_else.16133
	j	fle_cont.16134
fle_else.16133:
	fneg	f2, f2
fle_cont.16134:
	fle	r30, f4, f2
	beq	r0, r30, fle_else.16135
	addi	r1, r0, 0
	jr	r31				#
fle_else.16135:
	add	r30, r8, r7
	flw	f2, 0(r30)
	add	r30, r2, r7
	flw	f4, 0(r30)
	fmul	f4, f1, f4
	fadd	f3, f4, f3
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16136
	j	fle_cont.16137
fle_else.16136:
	fneg	f3, f3
fle_cont.16137:
	fle	r30, f2, f3
	beq	r0, r30, fle_else.16138
	addi	r1, r0, 0
	jr	r31				#
fle_else.16138:
	addi	r1, r0, 10724
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
solver_rect.3013:
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
	jal	solver_rect_surface.3004				#	bl	solver_rect_surface.3004
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.16139
	addi	r1, r0, 1
	jr	r31				#
beq_then.16139:
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
	jal	solver_rect_surface.3004				#	bl	solver_rect_surface.3004
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.16140
	addi	r1, r0, 2
	jr	r31				#
beq_then.16140:
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
	jal	solver_rect_surface.3004				#	bl	solver_rect_surface.3004
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.16141
	addi	r1, r0, 3
	jr	r31				#
beq_then.16141:
	addi	r1, r0, 0
	jr	r31				#
solver_surface.3019:
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
	beq	r0, r30, fle_else.16142
	addi	r2, r0, 0
	j	fle_cont.16143
fle_else.16142:
	addi	r2, r0, 1
fle_cont.16143:
	beqi	0, r2, beq_then.16144
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
beq_then.16144:
	addi	r1, r0, 0
	jr	r31				#
quadratic.3025:
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
	beqi	0, r2, beq_then.16145
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
beq_then.16145:
	fadd	f1, f0, f4
	jr	r31				#
bilinear.3030:
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
	beqi	0, r2, beq_then.16146
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
beq_then.16146:
	fadd	f1, f0, f7
	jr	r31				#
solver_second.3038:
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
	jal	quadratic.3025				#	bl	quadratic.3025
	addi	r3, r3, -9
	lw	r31, 8(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16147
	addi	r1, r0, 1
	j	feq_cont.16148
feq_else.16147:
	addi	r1, r0, 0
feq_cont.16148:
	beqi	0, r1, beq_then.16149
	addi	r1, r0, 0
	jr	r31				#
beq_then.16149:
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
	jal	bilinear.3030				#	bl	bilinear.3030
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
	jal	quadratic.3025				#	bl	quadratic.3025
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16150
	j	beq_cont.16151
beq_then.16150:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16151:
	flw	f2, 10(r3)
	fmul	f3, f2, f2
	flw	f4, 8(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16152
	addi	r2, r0, 0
	j	fle_cont.16153
fle_else.16152:
	addi	r2, r0, 1
fle_cont.16153:
	beqi	0, r2, beq_then.16154
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16155
	j	beq_cont.16156
beq_then.16155:
	fneg	f1, f1
beq_cont.16156:
	addi	r1, r0, 10724
	fsub	f1, f1, f2
	fdiv	f1, f1, f4
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16154:
	addi	r1, r0, 0
	jr	r31				#
solver.3044:
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
	beqi	1, r5, beq_then.16157
	beqi	2, r5, beq_then.16158
	j	solver_second.3038
beq_then.16158:
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
	beq	r0, r30, fle_else.16159
	addi	r2, r0, 0
	j	fle_cont.16160
fle_else.16159:
	addi	r2, r0, 1
fle_cont.16160:
	beqi	0, r2, beq_then.16161
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
beq_then.16161:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16157:
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
	jal	solver_rect_surface.3004				#	bl	solver_rect_surface.3004
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.16162
	addi	r1, r0, 1
	jr	r31				#
beq_then.16162:
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
	jal	solver_rect_surface.3004				#	bl	solver_rect_surface.3004
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.16163
	addi	r1, r0, 2
	jr	r31				#
beq_then.16163:
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
	jal	solver_rect_surface.3004				#	bl	solver_rect_surface.3004
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.16164
	addi	r1, r0, 3
	jr	r31				#
beq_then.16164:
	addi	r1, r0, 0
	jr	r31				#
solver_rect_fast.3048:
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
	beq	r0, r30, fle_else.16165
	j	fle_cont.16166
fle_else.16165:
	fneg	f6, f6
fle_cont.16166:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16167
	addi	r6, r0, 0
	j	fle_cont.16168
fle_else.16167:
	lw	r6, 4(r1)
	flw	f5, 2(r6)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.16169
	j	fle_cont.16170
fle_else.16169:
	fneg	f6, f6
fle_cont.16170:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16171
	addi	r6, r0, 0
	j	fle_cont.16172
fle_else.16171:
	flw	f5, 1(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16173
	addi	r6, r0, 1
	j	feq_cont.16174
feq_else.16173:
	addi	r6, r0, 0
feq_cont.16174:
	beqi	0, r6, beq_then.16175
	addi	r6, r0, 0
	j	beq_cont.16176
beq_then.16175:
	addi	r6, r0, 1
beq_cont.16176:
fle_cont.16172:
fle_cont.16168:
	beqi	0, r6, beq_then.16177
	addi	r1, r0, 10724
	fsw	f4, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16177:
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
	beq	r0, r30, fle_else.16178
	j	fle_cont.16179
fle_else.16178:
	fneg	f6, f6
fle_cont.16179:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16180
	addi	r6, r0, 0
	j	fle_cont.16181
fle_else.16180:
	lw	r6, 4(r1)
	flw	f5, 2(r6)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.16182
	j	fle_cont.16183
fle_else.16182:
	fneg	f6, f6
fle_cont.16183:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.16184
	addi	r6, r0, 0
	j	fle_cont.16185
fle_else.16184:
	flw	f5, 3(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.16186
	addi	r6, r0, 1
	j	feq_cont.16187
feq_else.16186:
	addi	r6, r0, 0
feq_cont.16187:
	beqi	0, r6, beq_then.16188
	addi	r6, r0, 0
	j	beq_cont.16189
beq_then.16188:
	addi	r6, r0, 1
beq_cont.16189:
fle_cont.16185:
fle_cont.16181:
	beqi	0, r6, beq_then.16190
	addi	r1, r0, 10724
	fsw	f4, 0(r1)
	addi	r1, r0, 2
	jr	r31				#
beq_then.16190:
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
	beq	r0, r30, fle_else.16191
	j	fle_cont.16192
fle_else.16191:
	fneg	f1, f1
fle_cont.16192:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16193
	addi	r1, r0, 0
	j	fle_cont.16194
fle_else.16193:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	flw	f4, 1(r2)
	fmul	f4, f3, f4
	fadd	f2, f4, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16195
	j	fle_cont.16196
fle_else.16195:
	fneg	f2, f2
fle_cont.16196:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16197
	addi	r1, r0, 0
	j	fle_cont.16198
fle_else.16197:
	flw	f1, 5(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16199
	addi	r1, r0, 1
	j	feq_cont.16200
feq_else.16199:
	addi	r1, r0, 0
feq_cont.16200:
	beqi	0, r1, beq_then.16201
	addi	r1, r0, 0
	j	beq_cont.16202
beq_then.16201:
	addi	r1, r0, 1
beq_cont.16202:
fle_cont.16198:
fle_cont.16194:
	beqi	0, r1, beq_then.16203
	addi	r1, r0, 10724
	fsw	f3, 0(r1)
	addi	r1, r0, 3
	jr	r31				#
beq_then.16203:
	addi	r1, r0, 0
	jr	r31				#
solver_surface_fast.3055:
	flw	f4, 0(r2)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16204
	addi	r1, r0, 0
	j	fle_cont.16205
fle_else.16204:
	addi	r1, r0, 1
fle_cont.16205:
	beqi	0, r1, beq_then.16206
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
beq_then.16206:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3061:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16207
	addi	r5, r0, 1
	j	feq_cont.16208
feq_else.16207:
	addi	r5, r0, 0
feq_cont.16208:
	beqi	0, r5, beq_then.16209
	addi	r1, r0, 0
	jr	r31				#
beq_then.16209:
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
	jal	quadratic.3025				#	bl	quadratic.3025
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16211
	j	beq_cont.16212
beq_then.16211:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16212:
	flw	f2, 4(r3)
	fmul	f3, f2, f2
	flw	f4, 2(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16213
	addi	r2, r0, 0
	j	fle_cont.16214
fle_else.16213:
	addi	r2, r0, 1
fle_cont.16214:
	beqi	0, r2, beq_then.16215
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16216
	addi	r1, r0, 10724
	fsqrt	f1, f1
	fadd	f1, f2, f1
	lw	r2, 0(r3)
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	j	beq_cont.16217
beq_then.16216:
	addi	r1, r0, 10724
	fsqrt	f1, f1
	fsub	f1, f2, f1
	lw	r2, 0(r3)
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
beq_cont.16217:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16215:
	addi	r1, r0, 0
	jr	r31				#
solver_fast.3067:
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
	beqi	1, r1, beq_then.16218
	beqi	2, r1, beq_then.16219
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	j	solver_second_fast.3061
beq_then.16219:
	flw	f4, 0(r5)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16220
	addi	r1, r0, 0
	j	fle_cont.16221
fle_else.16220:
	addi	r1, r0, 1
fle_cont.16221:
	beqi	0, r1, beq_then.16222
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
beq_then.16222:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16218:
	lw	r2, 0(r2)
	add	r1, r0, r6				# mr	r1, r6
	j	solver_rect_fast.3048
solver_surface_fast2.3071:
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16223
	addi	r1, r0, 0
	j	fle_cont.16224
fle_else.16223:
	addi	r1, r0, 1
fle_cont.16224:
	beqi	0, r1, beq_then.16225
	addi	r1, r0, 10724
	flw	f1, 0(r2)
	flw	f2, 3(r5)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16225:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3078:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.16226
	addi	r6, r0, 1
	j	feq_cont.16227
feq_else.16226:
	addi	r6, r0, 0
feq_cont.16227:
	beqi	0, r6, beq_then.16228
	addi	r1, r0, 0
	jr	r31				#
beq_then.16228:
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
	beq	r0, r30, fle_else.16229
	addi	r5, r0, 0
	j	fle_cont.16230
fle_else.16229:
	addi	r5, r0, 1
fle_cont.16230:
	beqi	0, r5, beq_then.16231
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16232
	addi	r1, r0, 10724
	fsqrt	f2, f2
	fadd	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	j	beq_cont.16233
beq_then.16232:
	addi	r1, r0, 10724
	fsqrt	f2, f2
	fsub	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
beq_cont.16233:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16231:
	addi	r1, r0, 0
	jr	r31				#
solver_fast2.3085:
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
	beqi	1, r7, beq_then.16234
	beqi	2, r7, beq_then.16235
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	j	solver_second_fast2.3078
beq_then.16235:
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16236
	addi	r2, r0, 0
	j	fle_cont.16237
fle_else.16236:
	addi	r2, r0, 1
fle_cont.16237:
	beqi	0, r2, beq_then.16238
	addi	r2, r0, 10724
	flw	f1, 0(r1)
	flw	f2, 3(r6)
	fmul	f1, f1, f2
	fsw	f1, 0(r2)
	addi	r1, r0, 1
	jr	r31				#
beq_then.16238:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16234:
	lw	r2, 0(r2)
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r1				# mr	r5, r1
	add	r1, r0, r28				# mr	r1, r28
	j	solver_rect_fast.3048
setup_rect_table.3088:
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
	beq	r0, r30, feq_else.16239
	addi	r5, r0, 1
	j	feq_cont.16240
feq_else.16239:
	addi	r5, r0, 0
feq_cont.16240:
	beqi	0, r5, beq_then.16241
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 1(r1)
	j	beq_cont.16242
beq_then.16241:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16243
	addi	r7, r0, 0
	j	fle_cont.16244
fle_else.16243:
	addi	r7, r0, 1
fle_cont.16244:
	beqi	0, r6, beq_then.16245
	beqi	0, r7, beq_then.16247
	addi	r6, r0, 0
	j	beq_cont.16248
beq_then.16247:
	addi	r6, r0, 1
beq_cont.16248:
	j	beq_cont.16246
beq_then.16245:
	add	r6, r0, r7
beq_cont.16246:
	lw	r7, 4(r5)
	flw	f1, 0(r7)
	beqi	0, r6, beq_then.16249
	j	beq_cont.16250
beq_then.16249:
	fneg	f1, f1
beq_cont.16250:
	fsw	f1, 0(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r2)
	fdiv	f1, f1, f2
	fsw	f1, 1(r1)
beq_cont.16242:
	flw	f1, 1(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16251
	addi	r5, r0, 1
	j	feq_cont.16252
feq_else.16251:
	addi	r5, r0, 0
feq_cont.16252:
	beqi	0, r5, beq_then.16253
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 3(r1)
	j	beq_cont.16254
beq_then.16253:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 1(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16255
	addi	r7, r0, 0
	j	fle_cont.16256
fle_else.16255:
	addi	r7, r0, 1
fle_cont.16256:
	beqi	0, r6, beq_then.16257
	beqi	0, r7, beq_then.16259
	addi	r6, r0, 0
	j	beq_cont.16260
beq_then.16259:
	addi	r6, r0, 1
beq_cont.16260:
	j	beq_cont.16258
beq_then.16257:
	add	r6, r0, r7
beq_cont.16258:
	lw	r7, 4(r5)
	flw	f1, 1(r7)
	beqi	0, r6, beq_then.16261
	j	beq_cont.16262
beq_then.16261:
	fneg	f1, f1
beq_cont.16262:
	fsw	f1, 2(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 1(r2)
	fdiv	f1, f1, f2
	fsw	f1, 3(r1)
beq_cont.16254:
	flw	f1, 2(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16263
	addi	r5, r0, 1
	j	feq_cont.16264
feq_else.16263:
	addi	r5, r0, 0
feq_cont.16264:
	beqi	0, r5, beq_then.16265
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 5(r1)
	j	beq_cont.16266
beq_then.16265:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 2(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16267
	addi	r7, r0, 0
	j	fle_cont.16268
fle_else.16267:
	addi	r7, r0, 1
fle_cont.16268:
	beqi	0, r6, beq_then.16269
	beqi	0, r7, beq_then.16271
	addi	r6, r0, 0
	j	beq_cont.16272
beq_then.16271:
	addi	r6, r0, 1
beq_cont.16272:
	j	beq_cont.16270
beq_then.16269:
	add	r6, r0, r7
beq_cont.16270:
	lw	r5, 4(r5)
	flw	f1, 2(r5)
	beqi	0, r6, beq_then.16273
	j	beq_cont.16274
beq_then.16273:
	fneg	f1, f1
beq_cont.16274:
	fsw	f1, 4(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 2(r2)
	fdiv	f1, f1, f2
	fsw	f1, 5(r1)
beq_cont.16266:
	jr	r31				#
setup_surface_table.3091:
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
	beq	r0, r30, fle_else.16275
	addi	r2, r0, 0
	j	fle_cont.16276
fle_else.16275:
	addi	r2, r0, 1
fle_cont.16276:
	beqi	0, r2, beq_then.16277
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
	j	beq_cont.16278
beq_then.16277:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
beq_cont.16278:
	jr	r31				#
setup_second_table.3094:
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
	jal	quadratic.3025				#	bl	quadratic.3025
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
	beqi	0, r6, beq_then.16279
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
	j	beq_cont.16280
beq_then.16279:
	fsw	f2, 1(r5)
	fsw	f3, 2(r5)
	fsw	f4, 3(r5)
beq_cont.16280:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16281
	addi	r1, r0, 1
	j	feq_cont.16282
feq_else.16281:
	addi	r1, r0, 0
feq_cont.16282:
	beqi	0, r1, beq_then.16283
	j	beq_cont.16284
beq_then.16283:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
	fsw	f1, 4(r5)
beq_cont.16284:
	add	r1, r0, r5
	jr	r31				#
iter_setup_dirvec_constants.3097:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16285
	jr	r31				#
ble_then.16285:
	addi	r5, r0, 10001
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 1(r1)
	lw	r7, 0(r1)
	lw	r8, 1(r5)
	sw	r1, 0(r3)
	beqi	1, r8, beq_then.16287
	beqi	2, r8, beq_then.16289
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16290
beq_then.16289:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16290:
	j	beq_cont.16288
beq_then.16287:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16288:
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16291
	jr	r31				#
ble_then.16291:
	addi	r2, r0, 10001
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 0(r3)
	lw	r6, 1(r5)
	lw	r7, 0(r5)
	lw	r8, 1(r2)
	beqi	1, r8, beq_then.16293
	beqi	2, r8, beq_then.16295
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16296
beq_then.16295:
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16296:
	j	beq_cont.16294
beq_then.16293:
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16294:
	addi	r2, r2, -1
	lw	r1, 0(r3)
	j	iter_setup_dirvec_constants.3097
setup_dirvec_constants.3100:
	addi	r2, r0, 10000
	lw	r2, 0(r2)
	addi	r2, r2, -1
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16297
	jr	r31				#
ble_then.16297:
	addi	r5, r0, 10001
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 1(r1)
	lw	r7, 0(r1)
	lw	r8, 1(r5)
	sw	r1, 0(r3)
	beqi	1, r8, beq_then.16299
	beqi	2, r8, beq_then.16301
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.16302
beq_then.16301:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16302:
	j	beq_cont.16300
beq_then.16299:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.16300:
	addi	r2, r2, -1
	lw	r1, 0(r3)
	j	iter_setup_dirvec_constants.3097
setup_startp_constants.3102:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.16303
	jr	r31				#
ble_then.16303:
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
	beqi	2, r7, beq_then.16305
	blei	2, r7, ble_then.16307
	flw	f1, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 2(r6)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	quadratic.3025				#	bl	quadratic.3025
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	beqi	3, r1, beq_then.16309
	j	beq_cont.16310
beq_then.16309:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16310:
	lw	r1, 2(r3)
	fsw	f1, 3(r1)
	j	ble_cont.16308
ble_then.16307:
ble_cont.16308:
	j	beq_cont.16306
beq_then.16305:
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
beq_cont.16306:
	lw	r1, 1(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	j	setup_startp_constants.3102
setup_startp.3105:
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
	j	setup_startp_constants.3102
is_rect_outside.3107:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16311
	j	fle_cont.16312
fle_else.16311:
	fneg	f1, f1
fle_cont.16312:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16313
	addi	r2, r0, 0
	j	fle_cont.16314
fle_else.16313:
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16315
	j	fle_cont.16316
fle_else.16315:
	fneg	f2, f2
fle_cont.16316:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16317
	addi	r2, r0, 0
	j	fle_cont.16318
fle_else.16317:
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16319
	fadd	f2, f0, f3
	j	fle_cont.16320
fle_else.16319:
	fneg	f2, f3
fle_cont.16320:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16321
	addi	r2, r0, 0
	j	fle_cont.16322
fle_else.16321:
	addi	r2, r0, 1
fle_cont.16322:
fle_cont.16318:
fle_cont.16314:
	beqi	0, r2, beq_then.16323
	lw	r1, 6(r1)
	jr	r31				#
beq_then.16323:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16324
	addi	r1, r0, 0
	jr	r31				#
beq_then.16324:
	addi	r1, r0, 1
	jr	r31				#
is_plane_outside.3112:
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
	beq	r0, r30, fle_else.16325
	addi	r2, r0, 0
	j	fle_cont.16326
fle_else.16325:
	addi	r2, r0, 1
fle_cont.16326:
	beqi	0, r1, beq_then.16327
	beqi	0, r2, beq_then.16329
	addi	r1, r0, 0
	j	beq_cont.16330
beq_then.16329:
	addi	r1, r0, 1
beq_cont.16330:
	j	beq_cont.16328
beq_then.16327:
	add	r1, r0, r2
beq_cont.16328:
	beqi	0, r1, beq_then.16331
	addi	r1, r0, 0
	jr	r31				#
beq_then.16331:
	addi	r1, r0, 1
	jr	r31				#
is_second_outside.3117:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3025				#	bl	quadratic.3025
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16332
	j	beq_cont.16333
beq_then.16332:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16333:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16334
	addi	r2, r0, 0
	j	fle_cont.16335
fle_else.16334:
	addi	r2, r0, 1
fle_cont.16335:
	beqi	0, r1, beq_then.16336
	beqi	0, r2, beq_then.16338
	addi	r1, r0, 0
	j	beq_cont.16339
beq_then.16338:
	addi	r1, r0, 1
beq_cont.16339:
	j	beq_cont.16337
beq_then.16336:
	add	r1, r0, r2
beq_cont.16337:
	beqi	0, r1, beq_then.16340
	addi	r1, r0, 0
	jr	r31				#
beq_then.16340:
	addi	r1, r0, 1
	jr	r31				#
is_outside.3122:
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
	beqi	1, r2, beq_then.16341
	beqi	2, r2, beq_then.16342
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3025				#	bl	quadratic.3025
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16343
	j	beq_cont.16344
beq_then.16343:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16344:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16345
	addi	r2, r0, 0
	j	fle_cont.16346
fle_else.16345:
	addi	r2, r0, 1
fle_cont.16346:
	beqi	0, r1, beq_then.16347
	beqi	0, r2, beq_then.16349
	addi	r1, r0, 0
	j	beq_cont.16350
beq_then.16349:
	addi	r1, r0, 1
beq_cont.16350:
	j	beq_cont.16348
beq_then.16347:
	add	r1, r0, r2
beq_cont.16348:
	beqi	0, r1, beq_then.16351
	addi	r1, r0, 0
	jr	r31				#
beq_then.16351:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16342:
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
	beq	r0, r30, fle_else.16352
	addi	r2, r0, 0
	j	fle_cont.16353
fle_else.16352:
	addi	r2, r0, 1
fle_cont.16353:
	beqi	0, r1, beq_then.16354
	beqi	0, r2, beq_then.16356
	addi	r1, r0, 0
	j	beq_cont.16357
beq_then.16356:
	addi	r1, r0, 1
beq_cont.16357:
	j	beq_cont.16355
beq_then.16354:
	add	r1, r0, r2
beq_cont.16355:
	beqi	0, r1, beq_then.16358
	addi	r1, r0, 0
	jr	r31				#
beq_then.16358:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16341:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16359
	j	fle_cont.16360
fle_else.16359:
	fneg	f1, f1
fle_cont.16360:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16361
	addi	r2, r0, 0
	j	fle_cont.16362
fle_else.16361:
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16363
	j	fle_cont.16364
fle_else.16363:
	fneg	f2, f2
fle_cont.16364:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16365
	addi	r2, r0, 0
	j	fle_cont.16366
fle_else.16365:
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.16367
	fadd	f2, f0, f3
	j	fle_cont.16368
fle_else.16367:
	fneg	f2, f3
fle_cont.16368:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16369
	addi	r2, r0, 0
	j	fle_cont.16370
fle_else.16369:
	addi	r2, r0, 1
fle_cont.16370:
fle_cont.16366:
fle_cont.16362:
	beqi	0, r2, beq_then.16371
	lw	r1, 6(r1)
	jr	r31				#
beq_then.16371:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16372
	addi	r1, r0, 0
	jr	r31				#
beq_then.16372:
	addi	r1, r0, 1
	jr	r31				#
check_all_inside.3127:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16373
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
	beqi	1, r6, beq_then.16374
	beqi	2, r6, beq_then.16376
	sw	r5, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	quadratic.3025				#	bl	quadratic.3025
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 8(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.16378
	j	beq_cont.16379
beq_then.16378:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.16379:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16380
	addi	r2, r0, 0
	j	fle_cont.16381
fle_else.16380:
	addi	r2, r0, 1
fle_cont.16381:
	beqi	0, r1, beq_then.16382
	beqi	0, r2, beq_then.16384
	addi	r1, r0, 0
	j	beq_cont.16385
beq_then.16384:
	addi	r1, r0, 1
beq_cont.16385:
	j	beq_cont.16383
beq_then.16382:
	add	r1, r0, r2
beq_cont.16383:
	beqi	0, r1, beq_then.16386
	addi	r1, r0, 0
	j	beq_cont.16387
beq_then.16386:
	addi	r1, r0, 1
beq_cont.16387:
	j	beq_cont.16377
beq_then.16376:
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
	beq	r0, r30, fle_else.16388
	addi	r6, r0, 0
	j	fle_cont.16389
fle_else.16388:
	addi	r6, r0, 1
fle_cont.16389:
	beqi	0, r5, beq_then.16390
	beqi	0, r6, beq_then.16392
	addi	r5, r0, 0
	j	beq_cont.16393
beq_then.16392:
	addi	r5, r0, 1
beq_cont.16393:
	j	beq_cont.16391
beq_then.16390:
	add	r5, r0, r6
beq_cont.16391:
	beqi	0, r5, beq_then.16394
	addi	r1, r0, 0
	j	beq_cont.16395
beq_then.16394:
	addi	r1, r0, 1
beq_cont.16395:
beq_cont.16377:
	j	beq_cont.16375
beq_then.16374:
	add	r1, r0, r5				# mr	r1, r5
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	is_rect_outside.3107				#	bl	is_rect_outside.3107
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.16375:
	beqi	0, r1, beq_then.16396
	addi	r1, r0, 0
	jr	r31				#
beq_then.16396:
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 6(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16397
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
	jal	is_outside.3122				#	bl	is_outside.3122
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.16398
	addi	r1, r0, 0
	jr	r31				#
beq_then.16398:
	lw	r1, 9(r3)
	addi	r1, r1, 1
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r2, 6(r3)
	j	check_all_inside.3127
beq_then.16397:
	addi	r1, r0, 1
	jr	r31				#
beq_then.16373:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3133:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16399
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
	beqi	1, r9, beq_then.16400
	beqi	2, r9, beq_then.16402
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_second_fast.3061				#	bl	solver_second_fast.3061
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16403
beq_then.16402:
	flw	f4, 0(r7)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16404
	addi	r6, r0, 0
	j	fle_cont.16405
fle_else.16404:
	addi	r6, r0, 1
fle_cont.16405:
	beqi	0, r6, beq_then.16406
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
	j	beq_cont.16407
beq_then.16406:
	addi	r1, r0, 0
beq_cont.16407:
beq_cont.16403:
	j	beq_cont.16401
beq_then.16400:
	lw	r6, 0(r6)
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_rect_fast.3048				#	bl	solver_rect_fast.3048
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16401:
	addi	r2, r0, 10724
	flw	f1, 0(r2)
	beqi	0, r1, beq_then.16408
	flup	f2, 28		# fli	f2, -0.200000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16410
	addi	r1, r0, 0
	j	fle_cont.16411
fle_else.16410:
	addi	r1, r0, 1
fle_cont.16411:
	j	beq_cont.16409
beq_then.16408:
	addi	r1, r0, 0
beq_cont.16409:
	beqi	0, r1, beq_then.16412
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
	beqi	-1, r1, beq_then.16413
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
	jal	is_outside.3122				#	bl	is_outside.3122
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.16416
	addi	r1, r0, 0
	j	beq_cont.16417
beq_then.16416:
	addi	r1, r0, 1
	flw	f1, 8(r3)
	flw	f2, 6(r3)
	flw	f3, 4(r3)
	lw	r2, 0(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	check_all_inside.3127				#	bl	check_all_inside.3127
	addi	r3, r3, -11
	lw	r31, 10(r3)
beq_cont.16417:
	j	beq_cont.16414
beq_then.16413:
	addi	r1, r0, 1
beq_cont.16414:
	beqi	0, r1, beq_then.16418
	addi	r1, r0, 1
	jr	r31				#
beq_then.16418:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_and_group.3133
beq_then.16412:
	addi	r1, r0, 10001
	lw	r2, 2(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16419
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_and_group.3133
beq_then.16419:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16399:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3136:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16420
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
	jal	shadow_check_and_group.3133				#	bl	shadow_check_and_group.3133
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.16421
	addi	r1, r0, 1
	jr	r31				#
beq_then.16421:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16422
	addi	r6, r0, 10672
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	sw	r1, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3133				#	bl	shadow_check_and_group.3133
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16423
	addi	r1, r0, 1
	jr	r31				#
beq_then.16423:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16424
	addi	r6, r0, 10672
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	sw	r1, 3(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_and_group.3133				#	bl	shadow_check_and_group.3133
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.16425
	addi	r1, r0, 1
	jr	r31				#
beq_then.16425:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16426
	addi	r6, r0, 10672
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	sw	r1, 4(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	shadow_check_and_group.3133				#	bl	shadow_check_and_group.3133
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.16427
	addi	r1, r0, 1
	jr	r31				#
beq_then.16427:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	j	shadow_check_one_or_group.3136
beq_then.16426:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16424:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16422:
	addi	r1, r0, 0
	jr	r31				#
beq_then.16420:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3139:
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16428
	addi	r7, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r6, r7, beq_then.16429
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
	beqi	1, r8, beq_then.16431
	beqi	2, r8, beq_then.16433
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_second_fast.3061				#	bl	solver_second_fast.3061
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16434
beq_then.16433:
	flw	f4, 0(r6)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.16435
	addi	r7, r0, 0
	j	fle_cont.16436
fle_else.16435:
	addi	r7, r0, 1
fle_cont.16436:
	beqi	0, r7, beq_then.16437
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
	j	beq_cont.16438
beq_then.16437:
	addi	r1, r0, 0
beq_cont.16438:
beq_cont.16434:
	j	beq_cont.16432
beq_then.16431:
	lw	r7, 0(r7)
	add	r5, r0, r6				# mr	r5, r6
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_rect_fast.3048				#	bl	solver_rect_fast.3048
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16432:
	beqi	0, r1, beq_then.16439
	flup	f1, 30		# fli	f1, -0.100000
	addi	r1, r0, 10724
	flw	f2, 0(r1)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16441
	addi	r1, r0, 0
	j	fle_cont.16442
fle_else.16441:
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16443
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3133				#	bl	shadow_check_and_group.3133
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16445
	addi	r1, r0, 1
	j	beq_cont.16446
beq_then.16445:
	lw	r1, 0(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16447
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3133				#	bl	shadow_check_and_group.3133
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16449
	addi	r1, r0, 1
	j	beq_cont.16450
beq_then.16449:
	lw	r1, 0(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16451
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3133				#	bl	shadow_check_and_group.3133
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16453
	addi	r1, r0, 1
	j	beq_cont.16454
beq_then.16453:
	addi	r1, r0, 4
	lw	r2, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_one_or_group.3136				#	bl	shadow_check_one_or_group.3136
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16454:
	j	beq_cont.16452
beq_then.16451:
	addi	r1, r0, 0
beq_cont.16452:
beq_cont.16450:
	j	beq_cont.16448
beq_then.16447:
	addi	r1, r0, 0
beq_cont.16448:
beq_cont.16446:
	j	beq_cont.16444
beq_then.16443:
	addi	r1, r0, 0
beq_cont.16444:
	beqi	0, r1, beq_then.16455
	addi	r1, r0, 1
	j	beq_cont.16456
beq_then.16455:
	addi	r1, r0, 0
beq_cont.16456:
fle_cont.16442:
	j	beq_cont.16440
beq_then.16439:
	addi	r1, r0, 0
beq_cont.16440:
	j	beq_cont.16430
beq_then.16429:
	addi	r1, r0, 1
beq_cont.16430:
	beqi	0, r1, beq_then.16457
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16458
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3133				#	bl	shadow_check_and_group.3133
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16460
	addi	r1, r0, 1
	j	beq_cont.16461
beq_then.16460:
	lw	r1, 0(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16462
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3133				#	bl	shadow_check_and_group.3133
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16464
	addi	r1, r0, 1
	j	beq_cont.16465
beq_then.16464:
	lw	r1, 0(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16466
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_and_group.3133				#	bl	shadow_check_and_group.3133
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16468
	addi	r1, r0, 1
	j	beq_cont.16469
beq_then.16468:
	addi	r1, r0, 4
	lw	r2, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	shadow_check_one_or_group.3136				#	bl	shadow_check_one_or_group.3136
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16469:
	j	beq_cont.16467
beq_then.16466:
	addi	r1, r0, 0
beq_cont.16467:
beq_cont.16465:
	j	beq_cont.16463
beq_then.16462:
	addi	r1, r0, 0
beq_cont.16463:
beq_cont.16461:
	j	beq_cont.16459
beq_then.16458:
	addi	r1, r0, 0
beq_cont.16459:
	beqi	0, r1, beq_then.16470
	addi	r1, r0, 1
	jr	r31				#
beq_then.16470:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	j	shadow_check_one_or_matrix.3139
beq_then.16457:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	j	shadow_check_one_or_matrix.3139
beq_then.16428:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3142:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.16471
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
	beqi	1, r7, beq_then.16472
	beqi	2, r7, beq_then.16474
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second.3038				#	bl	solver_second.3038
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16475
beq_then.16474:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_surface.3019				#	bl	solver_surface.3019
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16475:
	j	beq_cont.16473
beq_then.16472:
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
	jal	solver_rect_surface.3004				#	bl	solver_rect_surface.3004
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16476
	addi	r1, r0, 1
	j	beq_cont.16477
beq_then.16476:
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
	jal	solver_rect_surface.3004				#	bl	solver_rect_surface.3004
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16478
	addi	r1, r0, 2
	j	beq_cont.16479
beq_then.16478:
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
	jal	solver_rect_surface.3004				#	bl	solver_rect_surface.3004
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16480
	addi	r1, r0, 3
	j	beq_cont.16481
beq_then.16480:
	addi	r1, r0, 0
beq_cont.16481:
beq_cont.16479:
beq_cont.16477:
beq_cont.16473:
	beqi	0, r1, beq_then.16482
	addi	r2, r0, 10724
	flw	f1, 0(r2)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16483
	j	fle_cont.16484
fle_else.16483:
	addi	r2, r0, 10726
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16485
	j	fle_cont.16486
fle_else.16485:
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
	beqi	-1, r6, beq_then.16487
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r6, 0(r30)
	add	r1, r0, r6				# mr	r1, r6
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	is_outside.3122				#	bl	is_outside.3122
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.16489
	addi	r1, r0, 0
	j	beq_cont.16490
beq_then.16489:
	addi	r1, r0, 1
	flw	f1, 16(r3)
	flw	f2, 14(r3)
	flw	f3, 12(r3)
	lw	r2, 1(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	check_all_inside.3127				#	bl	check_all_inside.3127
	addi	r3, r3, -21
	lw	r31, 20(r3)
beq_cont.16490:
	j	beq_cont.16488
beq_then.16487:
	addi	r1, r0, 1
beq_cont.16488:
	beqi	0, r1, beq_then.16491
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
	j	beq_cont.16492
beq_then.16491:
beq_cont.16492:
fle_cont.16486:
fle_cont.16484:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3142
beq_then.16482:
	addi	r1, r0, 10001
	lw	r2, 3(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16493
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3142
beq_then.16493:
	jr	r31				#
beq_then.16471:
	jr	r31				#
solve_one_or_network.3146:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.16496
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
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16497
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
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16498
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
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16499
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
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_one_or_network.3146
beq_then.16499:
	jr	r31				#
beq_then.16498:
	jr	r31				#
beq_then.16497:
	jr	r31				#
beq_then.16496:
	jr	r31				#
trace_or_matrix.3150:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.16504
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.16505
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
	beqi	1, r8, beq_then.16507
	beqi	2, r8, beq_then.16509
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second.3038				#	bl	solver_second.3038
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16510
beq_then.16509:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_surface.3019				#	bl	solver_surface.3019
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16510:
	j	beq_cont.16508
beq_then.16507:
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
	jal	solver_rect_surface.3004				#	bl	solver_rect_surface.3004
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16511
	addi	r1, r0, 1
	j	beq_cont.16512
beq_then.16511:
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
	jal	solver_rect_surface.3004				#	bl	solver_rect_surface.3004
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16513
	addi	r1, r0, 2
	j	beq_cont.16514
beq_then.16513:
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
	jal	solver_rect_surface.3004				#	bl	solver_rect_surface.3004
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.16515
	addi	r1, r0, 3
	j	beq_cont.16516
beq_then.16515:
	addi	r1, r0, 0
beq_cont.16516:
beq_cont.16514:
beq_cont.16512:
beq_cont.16508:
	beqi	0, r1, beq_then.16517
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16519
	j	fle_cont.16520
fle_else.16519:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16521
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16523
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16525
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_one_or_network.3146				#	bl	solve_one_or_network.3146
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.16526
beq_then.16525:
beq_cont.16526:
	j	beq_cont.16524
beq_then.16523:
beq_cont.16524:
	j	beq_cont.16522
beq_then.16521:
beq_cont.16522:
fle_cont.16520:
	j	beq_cont.16518
beq_then.16517:
beq_cont.16518:
	j	beq_cont.16506
beq_then.16505:
	lw	r7, 1(r6)
	beqi	-1, r7, beq_then.16527
	addi	r8, r0, 10672
	add	r30, r8, r7
	lw	r7, 0(r30)
	addi	r8, r0, 0
	sw	r6, 3(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16529
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16531
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_one_or_network.3146				#	bl	solve_one_or_network.3146
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.16532
beq_then.16531:
beq_cont.16532:
	j	beq_cont.16530
beq_then.16529:
beq_cont.16530:
	j	beq_cont.16528
beq_then.16527:
beq_cont.16528:
beq_cont.16506:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16533
	addi	r7, r0, 99
	sw	r1, 11(r3)
	beq	r6, r7, beq_then.16534
	addi	r7, r0, 10748
	lw	r8, 0(r3)
	sw	r5, 12(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solver.3044				#	bl	solver.3044
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.16536
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16538
	j	fle_cont.16539
fle_else.16538:
	lw	r1, 12(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16540
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 12(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16542
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r1, r0, 3
	lw	r2, 12(r3)
	lw	r5, 0(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_one_or_network.3146				#	bl	solve_one_or_network.3146
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.16543
beq_then.16542:
beq_cont.16543:
	j	beq_cont.16541
beq_then.16540:
beq_cont.16541:
fle_cont.16539:
	j	beq_cont.16537
beq_then.16536:
beq_cont.16537:
	j	beq_cont.16535
beq_then.16534:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16544
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
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 12(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16546
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r1, r0, 3
	lw	r2, 12(r3)
	lw	r5, 0(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_one_or_network.3146				#	bl	solve_one_or_network.3146
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.16547
beq_then.16546:
beq_cont.16547:
	j	beq_cont.16545
beq_then.16544:
beq_cont.16545:
beq_cont.16535:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix.3150
beq_then.16533:
	jr	r31				#
beq_then.16504:
	jr	r31				#
judge_intersection.3154:
	addi	r2, r0, 10726
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r2)
	addi	r2, r0, 10723
	lw	r2, 0(r2)
	lw	r5, 0(r2)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16550
	addi	r7, r0, 99
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	beq	r6, r7, beq_then.16552
	addi	r7, r0, 10748
	sw	r5, 2(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver.3044				#	bl	solver.3044
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16554
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16556
	j	fle_cont.16557
fle_else.16556:
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16558
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16560
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network.3146				#	bl	solve_one_or_network.3146
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16561
beq_then.16560:
beq_cont.16561:
	j	beq_cont.16559
beq_then.16558:
beq_cont.16559:
fle_cont.16557:
	j	beq_cont.16555
beq_then.16554:
beq_cont.16555:
	j	beq_cont.16553
beq_then.16552:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16562
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
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16564
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3142				#	bl	solve_each_element.3142
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network.3146				#	bl	solve_one_or_network.3146
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16565
beq_then.16564:
beq_cont.16565:
	j	beq_cont.16563
beq_then.16562:
beq_cont.16563:
beq_cont.16553:
	addi	r1, r0, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix.3150				#	bl	trace_or_matrix.3150
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16551
beq_then.16550:
beq_cont.16551:
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16566
	addi	r1, r0, 0
	jr	r31				#
fle_else.16566:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16567
	addi	r1, r0, 0
	jr	r31				#
fle_else.16567:
	addi	r1, r0, 1
	jr	r31				#
solve_each_element_fast.3156:
	lw	r6, 0(r5)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.16568
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
	beqi	1, r11, beq_then.16569
	beqi	2, r11, beq_then.16571
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_second_fast2.3078				#	bl	solver_second_fast2.3078
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16572
beq_then.16571:
	flw	f1, 0(r10)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16573
	addi	r8, r0, 0
	j	fle_cont.16574
fle_else.16573:
	addi	r8, r0, 1
fle_cont.16574:
	beqi	0, r8, beq_then.16575
	addi	r8, r0, 10724
	flw	f1, 0(r10)
	flw	f2, 3(r9)
	fmul	f1, f1, f2
	fsw	f1, 0(r8)
	addi	r1, r0, 1
	j	beq_cont.16576
beq_then.16575:
	addi	r1, r0, 0
beq_cont.16576:
beq_cont.16572:
	j	beq_cont.16570
beq_then.16569:
	lw	r9, 0(r5)
	add	r5, r0, r10				# mr	r5, r10
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_rect_fast.3048				#	bl	solver_rect_fast.3048
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16570:
	beqi	0, r1, beq_then.16577
	addi	r2, r0, 10724
	flw	f1, 0(r2)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16578
	j	fle_cont.16579
fle_else.16578:
	addi	r2, r0, 10726
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16580
	j	fle_cont.16581
fle_else.16580:
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
	beqi	-1, r5, beq_then.16582
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r5, 0(r30)
	add	r1, r0, r5				# mr	r1, r5
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	is_outside.3122				#	bl	is_outside.3122
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.16584
	addi	r1, r0, 0
	j	beq_cont.16585
beq_then.16584:
	addi	r1, r0, 1
	flw	f1, 10(r3)
	flw	f2, 8(r3)
	flw	f3, 6(r3)
	lw	r2, 2(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	check_all_inside.3127				#	bl	check_all_inside.3127
	addi	r3, r3, -15
	lw	r31, 14(r3)
beq_cont.16585:
	j	beq_cont.16583
beq_then.16582:
	addi	r1, r0, 1
beq_cont.16583:
	beqi	0, r1, beq_then.16586
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
	j	beq_cont.16587
beq_then.16586:
beq_cont.16587:
fle_cont.16581:
fle_cont.16579:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	j	solve_each_element_fast.3156
beq_then.16577:
	addi	r1, r0, 10001
	lw	r2, 4(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.16588
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	j	solve_each_element_fast.3156
beq_then.16588:
	jr	r31				#
beq_then.16568:
	jr	r31				#
solve_one_or_network_fast.3160:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.16591
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
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16592
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
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16593
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
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.16594
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
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_one_or_network_fast.3160
beq_then.16594:
	jr	r31				#
beq_then.16593:
	jr	r31				#
beq_then.16592:
	jr	r31				#
beq_then.16591:
	jr	r31				#
trace_or_matrix_fast.3164:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.16599
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.16600
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
	beqi	1, r10, beq_then.16602
	beqi	2, r10, beq_then.16604
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second_fast2.3078				#	bl	solver_second_fast2.3078
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16605
beq_then.16604:
	flw	f1, 0(r7)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16606
	addi	r8, r0, 0
	j	fle_cont.16607
fle_else.16606:
	addi	r8, r0, 1
fle_cont.16607:
	beqi	0, r8, beq_then.16608
	addi	r8, r0, 10724
	flw	f1, 0(r7)
	flw	f2, 3(r9)
	fmul	f1, f1, f2
	fsw	f1, 0(r8)
	addi	r1, r0, 1
	j	beq_cont.16609
beq_then.16608:
	addi	r1, r0, 0
beq_cont.16609:
beq_cont.16605:
	j	beq_cont.16603
beq_then.16602:
	lw	r9, 0(r5)
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_rect_fast.3048				#	bl	solver_rect_fast.3048
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16603:
	beqi	0, r1, beq_then.16610
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16612
	j	fle_cont.16613
fle_else.16612:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16614
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16616
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16618
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3160				#	bl	solve_one_or_network_fast.3160
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16619
beq_then.16618:
beq_cont.16619:
	j	beq_cont.16617
beq_then.16616:
beq_cont.16617:
	j	beq_cont.16615
beq_then.16614:
beq_cont.16615:
fle_cont.16613:
	j	beq_cont.16611
beq_then.16610:
beq_cont.16611:
	j	beq_cont.16601
beq_then.16600:
	lw	r7, 1(r6)
	beqi	-1, r7, beq_then.16620
	addi	r8, r0, 10672
	add	r30, r8, r7
	lw	r7, 0(r30)
	addi	r8, r0, 0
	sw	r6, 3(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16622
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.16624
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3160				#	bl	solve_one_or_network_fast.3160
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16625
beq_then.16624:
beq_cont.16625:
	j	beq_cont.16623
beq_then.16622:
beq_cont.16623:
	j	beq_cont.16621
beq_then.16620:
beq_cont.16621:
beq_cont.16601:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16626
	addi	r7, r0, 99
	sw	r1, 4(r3)
	beq	r6, r7, beq_then.16627
	lw	r7, 0(r3)
	sw	r5, 5(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solver_fast2.3085				#	bl	solver_fast2.3085
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.16629
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16631
	j	fle_cont.16632
fle_else.16631:
	lw	r1, 5(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16633
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16635
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 3
	lw	r2, 5(r3)
	lw	r5, 0(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_one_or_network_fast.3160				#	bl	solve_one_or_network_fast.3160
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16636
beq_then.16635:
beq_cont.16636:
	j	beq_cont.16634
beq_then.16633:
beq_cont.16634:
fle_cont.16632:
	j	beq_cont.16630
beq_then.16629:
beq_cont.16630:
	j	beq_cont.16628
beq_then.16627:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16637
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
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16639
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 3
	lw	r2, 5(r3)
	lw	r5, 0(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_one_or_network_fast.3160				#	bl	solve_one_or_network_fast.3160
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16640
beq_then.16639:
beq_cont.16640:
	j	beq_cont.16638
beq_then.16637:
beq_cont.16638:
beq_cont.16628:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix_fast.3164
beq_then.16626:
	jr	r31				#
beq_then.16599:
	jr	r31				#
judge_intersection_fast.3168:
	addi	r2, r0, 10726
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r2)
	addi	r2, r0, 10723
	lw	r2, 0(r2)
	lw	r5, 0(r2)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.16643
	addi	r7, r0, 99
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	beq	r6, r7, beq_then.16645
	sw	r5, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_fast2.3085				#	bl	solver_fast2.3085
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.16647
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16649
	j	fle_cont.16650
fle_else.16649:
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.16651
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16653
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network_fast.3160				#	bl	solve_one_or_network_fast.3160
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16654
beq_then.16653:
beq_cont.16654:
	j	beq_cont.16652
beq_then.16651:
beq_cont.16652:
fle_cont.16650:
	j	beq_cont.16648
beq_then.16647:
beq_cont.16648:
	j	beq_cont.16646
beq_then.16645:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.16655
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
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.16657
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3156				#	bl	solve_each_element_fast.3156
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network_fast.3160				#	bl	solve_one_or_network_fast.3160
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16658
beq_then.16657:
beq_cont.16658:
	j	beq_cont.16656
beq_then.16655:
beq_cont.16656:
beq_cont.16646:
	addi	r1, r0, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix_fast.3164				#	bl	trace_or_matrix_fast.3164
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16644
beq_then.16643:
beq_cont.16644:
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16659
	addi	r1, r0, 0
	jr	r31				#
fle_else.16659:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16660
	addi	r1, r0, 0
	jr	r31				#
fle_else.16660:
	addi	r1, r0, 1
	jr	r31				#
get_nvector_rect.3170:
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
	beq	r0, r30, feq_else.16661
	addi	r1, r0, 1
	j	feq_cont.16662
feq_else.16661:
	addi	r1, r0, 0
feq_cont.16662:
	beqi	0, r1, beq_then.16663
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16664
beq_then.16663:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16665
	addi	r1, r0, 0
	j	fle_cont.16666
fle_else.16665:
	addi	r1, r0, 1
fle_cont.16666:
	beqi	0, r1, beq_then.16667
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16668
beq_then.16667:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.16668:
beq_cont.16664:
	fneg	f1, f1
	add	r30, r5, r6
	fsw	f1, 0(r30)
	jr	r31				#
get_nvector_plane.3172:
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
get_nvector_second.3174:
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
	beqi	0, r2, beq_then.16671
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
	j	beq_cont.16672
beq_then.16671:
	addi	r2, r0, 10731
	fsw	f4, 0(r2)
	addi	r2, r0, 10731
	fsw	f5, 1(r2)
	addi	r2, r0, 10731
	fsw	f6, 2(r2)
beq_cont.16672:
	addi	r2, r0, 10731
	lw	r1, 6(r1)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	vecunit_sgn.2882
get_nvector.3176:
	lw	r5, 1(r1)
	beqi	1, r5, beq_then.16673
	beqi	2, r5, beq_then.16674
	j	get_nvector_second.3174
beq_then.16674:
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
beq_then.16673:
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
	beq	r0, r30, feq_else.16676
	addi	r1, r0, 1
	j	feq_cont.16677
feq_else.16676:
	addi	r1, r0, 0
feq_cont.16677:
	beqi	0, r1, beq_then.16678
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16679
beq_then.16678:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16680
	addi	r1, r0, 0
	j	fle_cont.16681
fle_else.16680:
	addi	r1, r0, 1
fle_cont.16681:
	beqi	0, r1, beq_then.16682
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16683
beq_then.16682:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.16683:
beq_cont.16679:
	fneg	f1, f1
	add	r30, r5, r6
	fsw	f1, 0(r30)
	jr	r31				#
utexture.3179:
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
	beqi	1, r5, beq_then.16685
	beqi	2, r5, beq_then.16686
	beqi	3, r5, beq_then.16687
	beqi	4, r5, beq_then.16688
	jr	r31				#
beq_then.16688:
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
	beq	r0, r30, fle_else.16690
	fadd	f5, f0, f1
	j	fle_cont.16691
fle_else.16690:
	fneg	f5, f1
fle_cont.16691:
	fsw	f3, 0(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	fle	r30, f4, f5
	beq	r0, r30, fle_else.16692
	fdiv	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16694
	j	fle_cont.16695
fle_else.16694:
	fneg	f1, f1
fle_cont.16695:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16696
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.16697
fle_else.16696:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.16697:
	fmul	f1, f1, f2
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16698
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f1
	beq	r0, r30, fle_else.16700
	flup	f4, 15		# fli	f4, 1.570796
	flup	f5, 2		# fli	f5, 1.000000
	fdiv	f1, f5, f1
	fsw	f2, 4(r3)
	fsw	f4, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	j	fle_cont.16701
fle_else.16700:
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
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
fle_cont.16701:
	j	fle_cont.16699
fle_else.16698:
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -11
	lw	r31, 10(r3)
fle_cont.16699:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.16693
fle_else.16692:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.16693:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16702
	addi	r1, r0, 0
	j	feq_cont.16703
feq_else.16702:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16704
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.16705
fle_else.16704:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.16705:
feq_cont.16703:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16706
	j	fle_cont.16707
fle_else.16706:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.16707:
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
	beq	r0, r30, fle_else.16708
	fadd	f5, f0, f4
	j	fle_cont.16709
fle_else.16708:
	fneg	f5, f4
fle_cont.16709:
	fsw	f1, 10(r3)
	fle	r30, f3, f5
	beq	r0, r30, fle_else.16710
	fdiv	f2, f2, f4
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16712
	j	fle_cont.16713
fle_else.16712:
	fneg	f2, f2
fle_cont.16713:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16714
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.16715
fle_else.16714:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.16715:
	fmul	f2, f2, f3
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f2
	beq	r0, r30, fle_else.16716
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f2
	beq	r0, r30, fle_else.16718
	flup	f4, 15		# fli	f4, 1.570796
	flup	f5, 2		# fli	f5, 1.000000
	fdiv	f2, f5, f2
	fsw	f3, 12(r3)
	fsw	f4, 14(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	flw	f2, 12(r3)
	fmul	f1, f1, f2
	j	fle_cont.16719
fle_else.16718:
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
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fadd	f1, f2, f1
	flw	f2, 12(r3)
	fmul	f1, f1, f2
fle_cont.16719:
	j	fle_cont.16717
fle_else.16716:
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -19
	lw	r31, 18(r3)
fle_cont.16717:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.16711
fle_else.16710:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.16711:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16720
	addi	r1, r0, 0
	j	feq_cont.16721
feq_else.16720:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16722
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.16723
fle_else.16722:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.16723:
feq_cont.16721:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16724
	j	fle_cont.16725
fle_else.16724:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.16725:
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
	beq	r0, r30, fle_else.16726
	addi	r1, r0, 0
	j	fle_cont.16727
fle_else.16726:
	addi	r1, r0, 1
fle_cont.16727:
	beqi	0, r1, beq_then.16728
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16729
beq_then.16728:
beq_cont.16729:
	addi	r1, r0, 10734
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f2, f1
	flup	f2, 38		# fli	f2, 0.300000
	fdiv	f1, f1, f2
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.16687:
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
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16731
	addi	r1, r0, 0
	j	feq_cont.16732
feq_else.16731:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16733
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.16734
fle_else.16733:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.16734:
feq_cont.16732:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16735
	j	fle_cont.16736
fle_else.16735:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.16736:
	fsub	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fmul	f1, f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	cos.2833				#	bl	cos.2833
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
beq_then.16686:
	flw	f1, 1(r2)
	flup	f2, 40		# fli	f2, 0.250000
	fmul	f1, f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	sin.2831				#	bl	sin.2831
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
beq_then.16685:
	flw	f1, 0(r2)
	lw	r5, 5(r1)
	flw	f2, 0(r5)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	feq	r30, f2, f0
	beq	r0, r30, feq_else.16739
	addi	r5, r0, 0
	j	feq_cont.16740
feq_else.16739:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16741
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r5, f3
	j	fle_cont.16742
fle_else.16741:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r5, f3
fle_cont.16742:
feq_cont.16740:
	itof	f3, r5
	fle	r30, f3, f2
	beq	r0, r30, fle_else.16743
	fadd	f2, f0, f3
	j	fle_cont.16744
fle_else.16743:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.16744:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16745
	addi	r5, r0, 0
	j	fle_cont.16746
fle_else.16745:
	addi	r5, r0, 1
fle_cont.16746:
	flw	f1, 2(r2)
	lw	r1, 5(r1)
	flw	f2, 2(r1)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	feq	r30, f2, f0
	beq	r0, r30, feq_else.16747
	addi	r1, r0, 0
	j	feq_cont.16748
feq_else.16747:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.16749
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r1, f3
	j	fle_cont.16750
fle_else.16749:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r1, f3
fle_cont.16750:
feq_cont.16748:
	itof	f3, r1
	fle	r30, f3, f2
	beq	r0, r30, fle_else.16751
	fadd	f2, f0, f3
	j	fle_cont.16752
fle_else.16751:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.16752:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.16753
	addi	r1, r0, 0
	j	fle_cont.16754
fle_else.16753:
	addi	r1, r0, 1
fle_cont.16754:
	addi	r2, r0, 10734
	beqi	0, r5, beq_then.16755
	beqi	0, r1, beq_then.16757
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.16758
beq_then.16757:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.16758:
	j	beq_cont.16756
beq_then.16755:
	beqi	0, r1, beq_then.16759
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16760
beq_then.16759:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.16760:
beq_cont.16756:
	fsw	f1, 1(r2)
	jr	r31				#
add_light.3182:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16762
	addi	r1, r0, 0
	j	fle_cont.16763
fle_else.16762:
	addi	r1, r0, 1
fle_cont.16763:
	beqi	0, r1, beq_then.16764
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
	j	beq_cont.16765
beq_then.16764:
beq_cont.16765:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.16766
	addi	r1, r0, 0
	j	fle_cont.16767
fle_else.16766:
	addi	r1, r0, 1
fle_cont.16767:
	beqi	0, r1, beq_then.16768
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
beq_then.16768:
	jr	r31				#
trace_reflections.3186:
	addi	r5, r0, 0
	ble	r5, r1, ble_then.16771
	jr	r31				#
ble_then.16771:
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
	jal	trace_or_matrix_fast.3164				#	bl	trace_or_matrix_fast.3164
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16775
	addi	r1, r0, 0
	j	fle_cont.16776
fle_else.16775:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16777
	addi	r1, r0, 0
	j	fle_cont.16778
fle_else.16777:
	addi	r1, r0, 1
fle_cont.16778:
fle_cont.16776:
	beqi	0, r1, beq_then.16779
	addi	r1, r0, 10730
	lw	r1, 0(r1)
	slli	r1, r1, 2
	addi	r2, r0, 10725
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 9(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.16781
	j	beq_cont.16782
beq_then.16781:
	addi	r1, r0, 0
	addi	r5, r0, 10723
	lw	r5, 0(r5)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	shadow_check_one_or_matrix.3139				#	bl	shadow_check_one_or_matrix.3139
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.16783
	j	beq_cont.16784
beq_then.16783:
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
	jal	add_light.3182				#	bl	add_light.3182
	addi	r3, r3, -11
	lw	r31, 10(r3)
beq_cont.16784:
beq_cont.16782:
	j	beq_cont.16780
beq_then.16779:
beq_cont.16780:
	lw	r1, 0(r3)
	addi	r1, r1, -1
	flw	f1, 6(r3)
	flw	f2, 2(r3)
	lw	r2, 4(r3)
	j	trace_reflections.3186
trace_ray.3191:
	blei	4, r1, ble_then.16785
	jr	r31				#
ble_then.16785:
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
	jal	trace_or_matrix.3150				#	bl	trace_or_matrix.3150
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16788
	addi	r1, r0, 0
	j	fle_cont.16789
fle_else.16788:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16790
	addi	r1, r0, 0
	j	fle_cont.16791
fle_else.16790:
	addi	r1, r0, 1
fle_cont.16791:
fle_cont.16789:
	beqi	0, r1, beq_then.16792
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
	beqi	1, r6, beq_then.16793
	beqi	2, r6, beq_then.16795
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	get_nvector_second.3174				#	bl	get_nvector_second.3174
	addi	r3, r3, -15
	lw	r31, 14(r3)
	j	beq_cont.16796
beq_then.16795:
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
beq_cont.16796:
	j	beq_cont.16794
beq_then.16793:
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
	beq	r0, r30, feq_else.16797
	addi	r6, r0, 1
	j	feq_cont.16798
feq_else.16797:
	addi	r6, r0, 0
feq_cont.16798:
	beqi	0, r6, beq_then.16799
	flup	f3, 0		# fli	f3, 0.000000
	j	beq_cont.16800
beq_then.16799:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.16801
	addi	r6, r0, 0
	j	fle_cont.16802
fle_else.16801:
	addi	r6, r0, 1
fle_cont.16802:
	beqi	0, r6, beq_then.16803
	flup	f3, 2		# fli	f3, 1.000000
	j	beq_cont.16804
beq_then.16803:
	flup	f3, 11		# fli	f3, -1.000000
beq_cont.16804:
beq_cont.16800:
	fneg	f3, f3
	add	r30, r7, r8
	fsw	f3, 0(r30)
beq_cont.16794:
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
	jal	utexture.3179				#	bl	utexture.3179
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
	beq	r0, r30, fle_else.16805
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
	j	fle_cont.16806
fle_else.16805:
	addi	r8, r0, 0
	add	r30, r6, r2
	sw	r8, 0(r30)
fle_cont.16806:
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
	jal	shadow_check_one_or_matrix.3139				#	bl	shadow_check_one_or_matrix.3139
	addi	r3, r3, -17
	lw	r31, 16(r3)
	beqi	0, r1, beq_then.16807
	j	beq_cont.16808
beq_then.16807:
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
	jal	add_light.3182				#	bl	add_light.3182
	addi	r3, r3, -17
	lw	r31, 16(r3)
beq_cont.16808:
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
	jal	setup_startp_constants.3102				#	bl	setup_startp_constants.3102
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
	jal	trace_reflections.3186				#	bl	trace_reflections.3186
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flup	f1, 45		# fli	f1, 0.100000
	flw	f2, 4(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16809
	jr	r31				#
fle_else.16809:
	addi	r1, r0, 4
	lw	r2, 7(r3)
	ble	r1, r2, ble_then.16811
	addi	r1, r2, 1
	addi	r5, r0, -1
	lw	r6, 8(r3)
	add	r30, r6, r1
	sw	r5, 0(r30)
	j	ble_cont.16812
ble_then.16811:
ble_cont.16812:
	lw	r1, 9(r3)
	beqi	2, r1, beq_then.16813
	j	beq_cont.16814
beq_then.16813:
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
	jal	trace_ray.3191				#	bl	trace_ray.3191
	addi	r3, r3, -17
	lw	r31, 16(r3)
beq_cont.16814:
	jr	r31				#
beq_then.16792:
	addi	r1, r0, -1
	lw	r2, 7(r3)
	lw	r5, 8(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	0, r2, beq_then.16816
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
	beq	r0, r30, fle_else.16817
	addi	r1, r0, 0
	j	fle_cont.16818
fle_else.16817:
	addi	r1, r0, 1
fle_cont.16818:
	beqi	0, r1, beq_then.16819
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
beq_then.16819:
	jr	r31				#
beq_then.16816:
	jr	r31				#
trace_diffuse_ray.3197:
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
	jal	trace_or_matrix_fast.3164				#	bl	trace_or_matrix_fast.3164
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.16823
	addi	r1, r0, 0
	j	fle_cont.16824
fle_else.16823:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.16825
	addi	r1, r0, 0
	j	fle_cont.16826
fle_else.16825:
	addi	r1, r0, 1
fle_cont.16826:
fle_cont.16824:
	beqi	0, r1, beq_then.16827
	addi	r1, r0, 10001
	addi	r2, r0, 10730
	lw	r2, 0(r2)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r2, 2(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	sw	r1, 3(r3)
	beqi	1, r5, beq_then.16828
	beqi	2, r5, beq_then.16830
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	get_nvector_second.3174				#	bl	get_nvector_second.3174
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16831
beq_then.16830:
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
beq_cont.16831:
	j	beq_cont.16829
beq_then.16828:
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
	beq	r0, r30, feq_else.16832
	addi	r2, r0, 1
	j	feq_cont.16833
feq_else.16832:
	addi	r2, r0, 0
feq_cont.16833:
	beqi	0, r2, beq_then.16834
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.16835
beq_then.16834:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.16836
	addi	r2, r0, 0
	j	fle_cont.16837
fle_else.16836:
	addi	r2, r0, 1
fle_cont.16837:
	beqi	0, r2, beq_then.16838
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.16839
beq_then.16838:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.16839:
beq_cont.16835:
	fneg	f1, f1
	add	r30, r6, r7
	fsw	f1, 0(r30)
beq_cont.16829:
	addi	r2, r0, 10727
	lw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	utexture.3179				#	bl	utexture.3179
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 0
	addi	r2, r0, 10723
	lw	r2, 0(r2)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	shadow_check_one_or_matrix.3139				#	bl	shadow_check_one_or_matrix.3139
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.16840
	jr	r31				#
beq_then.16840:
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
	beq	r0, r30, fle_else.16842
	addi	r1, r0, 0
	j	fle_cont.16843
fle_else.16842:
	addi	r1, r0, 1
fle_cont.16843:
	beqi	0, r1, beq_then.16844
	j	beq_cont.16845
beq_then.16844:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.16845:
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
beq_then.16827:
	jr	r31				#
iter_trace_diffuse_rays.3200:
	addi	r7, r0, 0
	ble	r7, r6, ble_then.16848
	jr	r31				#
ble_then.16848:
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
	beq	r0, r30, fle_else.16850
	addi	r7, r0, 0
	j	fle_cont.16851
fle_else.16850:
	addi	r7, r0, 1
fle_cont.16851:
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r6, 3(r3)
	beqi	0, r7, beq_then.16852
	addi	r7, r6, 1
	add	r30, r1, r7
	lw	r7, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_diffuse_ray.3197				#	bl	trace_diffuse_ray.3197
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16853
beq_then.16852:
	add	r30, r1, r6
	lw	r7, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_diffuse_ray.3197				#	bl	trace_diffuse_ray.3197
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.16853:
	lw	r1, 3(r3)
	addi	r1, r1, -2
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16854
	jr	r31				#
ble_then.16854:
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
	beq	r0, r30, fle_else.16856
	addi	r5, r0, 0
	j	fle_cont.16857
fle_else.16856:
	addi	r5, r0, 1
fle_cont.16857:
	sw	r1, 4(r3)
	beqi	0, r5, beq_then.16858
	addi	r5, r1, 1
	add	r30, r2, r5
	lw	r5, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	trace_diffuse_ray.3197				#	bl	trace_diffuse_ray.3197
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16859
beq_then.16858:
	add	r30, r2, r1
	lw	r5, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	trace_diffuse_ray.3197				#	bl	trace_diffuse_ray.3197
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16859:
	lw	r1, 4(r3)
	addi	r6, r1, -2
	lw	r1, 2(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	iter_trace_diffuse_rays.3200
trace_diffuse_rays.3205:
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
	jal	setup_startp_constants.3102				#	bl	setup_startp_constants.3102
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
	beq	r0, r30, fle_else.16860
	addi	r2, r0, 0
	j	fle_cont.16861
fle_else.16860:
	addi	r2, r0, 1
fle_cont.16861:
	beqi	0, r2, beq_then.16862
	lw	r2, 119(r1)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_ray.3197				#	bl	trace_diffuse_ray.3197
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16863
beq_then.16862:
	lw	r2, 118(r1)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_diffuse_ray.3197				#	bl	trace_diffuse_ray.3197
	addi	r3, r3, -4
	lw	r31, 3(r3)
beq_cont.16863:
	addi	r6, r0, 116
	lw	r1, 2(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	iter_trace_diffuse_rays.3200
trace_diffuse_ray_80percent.3209:
	sw	r2, 0(r3)
	sw	r5, 1(r3)
	sw	r1, 2(r3)
	beqi	0, r1, beq_then.16864
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
	jal	setup_startp_constants.3102				#	bl	setup_startp_constants.3102
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r6, r0, 118
	lw	r1, 3(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	iter_trace_diffuse_rays.3200				#	bl	iter_trace_diffuse_rays.3200
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.16865
beq_then.16864:
beq_cont.16865:
	lw	r1, 2(r3)
	beqi	1, r1, beq_then.16866
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
	jal	setup_startp_constants.3102				#	bl	setup_startp_constants.3102
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r6, r0, 118
	lw	r1, 4(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_trace_diffuse_rays.3200				#	bl	iter_trace_diffuse_rays.3200
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16867
beq_then.16866:
beq_cont.16867:
	lw	r1, 2(r3)
	beqi	2, r1, beq_then.16868
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
	jal	setup_startp_constants.3102				#	bl	setup_startp_constants.3102
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r6, r0, 118
	lw	r1, 5(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_trace_diffuse_rays.3200				#	bl	iter_trace_diffuse_rays.3200
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16869
beq_then.16868:
beq_cont.16869:
	lw	r1, 2(r3)
	beqi	3, r1, beq_then.16870
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
	jal	setup_startp_constants.3102				#	bl	setup_startp_constants.3102
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r6, r0, 118
	lw	r1, 6(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	iter_trace_diffuse_rays.3200				#	bl	iter_trace_diffuse_rays.3200
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.16871
beq_then.16870:
beq_cont.16871:
	lw	r1, 2(r3)
	beqi	4, r1, beq_then.16872
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
	jal	setup_startp_constants.3102				#	bl	setup_startp_constants.3102
	addi	r3, r3, -9
	lw	r31, 8(r3)
	addi	r6, r0, 118
	lw	r1, 7(r3)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	j	iter_trace_diffuse_rays.3200
beq_then.16872:
	jr	r31				#
calc_diffuse_using_1point.3213:
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
	jal	trace_diffuse_ray_80percent.3209				#	bl	trace_diffuse_ray_80percent.3209
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r1, r0, 10740
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 10737
	j	vecaccumv.2906
calc_diffuse_using_5points.3216:
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
	j	vecaccumv.2906
do_without_neighbors.3222:
	blei	4, r2, ble_then.16874
	jr	r31				#
ble_then.16874:
	lw	r5, 2(r1)
	addi	r6, r0, 0
	add	r30, r5, r2
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.16876
	jr	r31				#
ble_then.16876:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	beqi	0, r5, beq_then.16878
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
	jal	trace_diffuse_ray_80percent.3209				#	bl	trace_diffuse_ray_80percent.3209
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
	jal	vecaccumv.2906				#	bl	vecaccumv.2906
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.16879
beq_then.16878:
beq_cont.16879:
	lw	r1, 1(r3)
	addi	r1, r1, 1
	blei	4, r1, ble_then.16880
	jr	r31				#
ble_then.16880:
	lw	r2, 0(r3)
	lw	r5, 2(r2)
	addi	r6, r0, 0
	add	r30, r5, r1
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.16882
	jr	r31				#
ble_then.16882:
	lw	r5, 3(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	sw	r1, 3(r3)
	beqi	0, r5, beq_then.16884
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
	jal	trace_diffuse_ray_80percent.3209				#	bl	trace_diffuse_ray_80percent.3209
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
	jal	vecaccumv.2906				#	bl	vecaccumv.2906
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16885
beq_then.16884:
beq_cont.16885:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	lw	r1, 0(r3)
	j	do_without_neighbors.3222
neighbors_exist.3225:
	addi	r5, r0, 10743
	lw	r5, 1(r5)
	addi	r6, r2, 1
	ble	r5, r6, ble_then.16886
	blei	0, r2, ble_then.16887
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.16888
	blei	0, r1, ble_then.16889
	addi	r1, r0, 1
	jr	r31				#
ble_then.16889:
	addi	r1, r0, 0
	jr	r31				#
ble_then.16888:
	addi	r1, r0, 0
	jr	r31				#
ble_then.16887:
	addi	r1, r0, 0
	jr	r31				#
ble_then.16886:
	addi	r1, r0, 0
	jr	r31				#
get_surface_id.3229:
	lw	r1, 2(r1)
	add	r30, r1, r2
	lw	r1, 0(r30)
	jr	r31				#
neighbors_are_available.3232:
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
	beq	r2, r8, beq_then.16890
	addi	r1, r0, 0
	jr	r31				#
beq_then.16890:
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.16891
	addi	r1, r0, 0
	jr	r31				#
beq_then.16891:
	addi	r2, r1, -1
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.16892
	addi	r1, r0, 0
	jr	r31				#
beq_then.16892:
	addi	r1, r1, 1
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beq	r1, r8, beq_then.16893
	addi	r1, r0, 0
	jr	r31				#
beq_then.16893:
	addi	r1, r0, 1
	jr	r31				#
try_exploit_neighbors.3238:
	add	r30, r6, r1
	lw	r9, 0(r30)
	blei	4, r8, ble_then.16894
	jr	r31				#
ble_then.16894:
	addi	r10, r0, 0
	lw	r11, 2(r9)
	add	r30, r11, r8
	lw	r11, 0(r30)
	ble	r10, r11, ble_then.16896
	jr	r31				#
ble_then.16896:
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
	beq	r11, r10, beq_then.16898
	addi	r10, r0, 0
	j	beq_cont.16899
beq_then.16898:
	add	r30, r7, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r10, beq_then.16900
	addi	r10, r0, 0
	j	beq_cont.16901
beq_then.16900:
	addi	r11, r1, -1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r10, beq_then.16902
	addi	r10, r0, 0
	j	beq_cont.16903
beq_then.16902:
	addi	r11, r1, 1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	add	r30, r11, r8
	lw	r11, 0(r30)
	beq	r11, r10, beq_then.16904
	addi	r10, r0, 0
	j	beq_cont.16905
beq_then.16904:
	addi	r10, r0, 1
beq_cont.16905:
beq_cont.16903:
beq_cont.16901:
beq_cont.16899:
	beqi	0, r10, beq_then.16906
	lw	r9, 3(r9)
	add	r30, r9, r8
	lw	r9, 0(r30)
	sw	r2, 0(r3)
	sw	r7, 1(r3)
	sw	r5, 2(r3)
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	beqi	0, r9, beq_then.16907
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r8				# mr	r7, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_diffuse_using_5points.3216				#	bl	calc_diffuse_using_5points.3216
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.16908
beq_then.16907:
beq_cont.16908:
	lw	r1, 5(r3)
	addi	r2, r1, 1
	lw	r1, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r1
	lw	r6, 0(r30)
	blei	4, r2, ble_then.16909
	jr	r31				#
ble_then.16909:
	addi	r7, r0, 0
	lw	r8, 2(r6)
	add	r30, r8, r2
	lw	r8, 0(r30)
	ble	r7, r8, ble_then.16911
	jr	r31				#
ble_then.16911:
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
	beq	r9, r7, beq_then.16913
	addi	r7, r0, 0
	j	beq_cont.16914
beq_then.16913:
	lw	r9, 1(r3)
	add	r30, r9, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.16915
	addi	r7, r0, 0
	j	beq_cont.16916
beq_then.16915:
	addi	r10, r1, -1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.16917
	addi	r7, r0, 0
	j	beq_cont.16918
beq_then.16917:
	addi	r10, r1, 1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.16919
	addi	r7, r0, 0
	j	beq_cont.16920
beq_then.16919:
	addi	r7, r0, 1
beq_cont.16920:
beq_cont.16918:
beq_cont.16916:
beq_cont.16914:
	beqi	0, r7, beq_then.16921
	lw	r6, 3(r6)
	add	r30, r6, r2
	lw	r6, 0(r30)
	sw	r2, 6(r3)
	beqi	0, r6, beq_then.16922
	lw	r6, 1(r3)
	add	r7, r0, r2				# mr	r7, r2
	add	r2, r0, r8				# mr	r2, r8
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	calc_diffuse_using_5points.3216				#	bl	calc_diffuse_using_5points.3216
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.16923
beq_then.16922:
beq_cont.16923:
	lw	r1, 6(r3)
	addi	r8, r1, 1
	lw	r1, 3(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	lw	r7, 1(r3)
	j	try_exploit_neighbors.3238
beq_then.16921:
	add	r30, r5, r1
	lw	r1, 0(r30)
	j	do_without_neighbors.3222
beq_then.16906:
	add	r30, r6, r1
	lw	r1, 0(r30)
	blei	4, r8, ble_then.16924
	jr	r31				#
ble_then.16924:
	lw	r2, 2(r1)
	addi	r5, r0, 0
	add	r30, r2, r8
	lw	r2, 0(r30)
	ble	r5, r2, ble_then.16926
	jr	r31				#
ble_then.16926:
	lw	r2, 3(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	sw	r1, 7(r3)
	sw	r8, 5(r3)
	beqi	0, r2, beq_then.16928
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
	jal	trace_diffuse_ray_80percent.3209				#	bl	trace_diffuse_ray_80percent.3209
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
	jal	vecaccumv.2906				#	bl	vecaccumv.2906
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.16929
beq_then.16928:
beq_cont.16929:
	lw	r1, 5(r3)
	addi	r2, r1, 1
	lw	r1, 7(r3)
	j	do_without_neighbors.3222
write_ppm_header.3245:
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
	jal	print_int.2851				#	bl	print_int.2851
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2851				#	bl	print_int.2851
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 255
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2851				#	bl	print_int.2851
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
write_rgb_element.3247:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16930
	addi	r1, r0, 0
	j	feq_cont.16931
feq_else.16930:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16932
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.16933
fle_else.16932:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.16933:
feq_cont.16931:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16934
	addi	r1, r0, 255
	j	ble_cont.16935
ble_then.16934:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16936
	addi	r1, r0, 0
	j	ble_cont.16937
ble_then.16936:
ble_cont.16937:
ble_cont.16935:
	j	print_int.2851
write_rgb.3249:
	addi	r1, r0, 10740
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16938
	addi	r1, r0, 0
	j	feq_cont.16939
feq_else.16938:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16940
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.16941
fle_else.16940:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.16941:
feq_cont.16939:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16942
	addi	r1, r0, 255
	j	ble_cont.16943
ble_then.16942:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16944
	addi	r1, r0, 0
	j	ble_cont.16945
ble_then.16944:
ble_cont.16945:
ble_cont.16943:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2851				#	bl	print_int.2851
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10740
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16946
	addi	r1, r0, 0
	j	feq_cont.16947
feq_else.16946:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16948
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.16949
fle_else.16948:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.16949:
feq_cont.16947:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16950
	addi	r1, r0, 255
	j	ble_cont.16951
ble_then.16950:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16952
	addi	r1, r0, 0
	j	ble_cont.16953
ble_then.16952:
ble_cont.16953:
ble_cont.16951:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2851				#	bl	print_int.2851
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10740
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.16954
	addi	r1, r0, 0
	j	feq_cont.16955
feq_else.16954:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.16956
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.16957
fle_else.16956:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.16957:
feq_cont.16955:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.16958
	addi	r1, r0, 255
	j	ble_cont.16959
ble_then.16958:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.16960
	addi	r1, r0, 0
	j	ble_cont.16961
ble_then.16960:
ble_cont.16961:
ble_cont.16959:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2851				#	bl	print_int.2851
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
pretrace_diffuse_rays.3251:
	blei	4, r2, ble_then.16962
	jr	r31				#
ble_then.16962:
	lw	r5, 2(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 0
	ble	r6, r5, ble_then.16964
	jr	r31				#
ble_then.16964:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 0(r3)
	beqi	0, r5, beq_then.16966
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
	jal	setup_startp_constants.3102				#	bl	setup_startp_constants.3102
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r6, r0, 118
	lw	r1, 4(r3)
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_trace_diffuse_rays.3200				#	bl	iter_trace_diffuse_rays.3200
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
	j	beq_cont.16967
beq_then.16966:
beq_cont.16967:
	lw	r2, 0(r3)
	addi	r2, r2, 1
	j	pretrace_diffuse_rays.3251
pretrace_pixels.3254:
	addi	r6, r0, 0
	ble	r6, r2, ble_then.16968
	jr	r31				#
ble_then.16968:
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
	jal	vecunit_sgn.2882				#	bl	vecunit_sgn.2882
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
	jal	trace_ray.3191				#	bl	trace_ray.3191
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
	jal	pretrace_diffuse_rays.3251				#	bl	pretrace_diffuse_rays.3251
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 7(r3)
	addi	r2, r1, -1
	lw	r1, 6(r3)
	addi	r1, r1, 1
	addi	r5, r0, 5
	ble	r5, r1, ble_then.16970
	add	r5, r0, r1
	j	ble_cont.16971
ble_then.16970:
	addi	r5, r1, -5
ble_cont.16971:
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r1, 8(r3)
	j	pretrace_pixels.3254
pretrace_line.3261:
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
	j	pretrace_pixels.3254
scan_pixel.3265:
	addi	r8, r0, 10743
	lw	r8, 0(r8)
	ble	r8, r1, ble_then.16972
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
	ble	r8, r9, ble_then.16973
	blei	0, r2, ble_then.16975
	addi	r8, r0, 10743
	lw	r8, 0(r8)
	addi	r9, r1, 1
	ble	r8, r9, ble_then.16977
	blei	0, r1, ble_then.16979
	addi	r8, r0, 1
	j	ble_cont.16980
ble_then.16979:
	addi	r8, r0, 0
ble_cont.16980:
	j	ble_cont.16978
ble_then.16977:
	addi	r8, r0, 0
ble_cont.16978:
	j	ble_cont.16976
ble_then.16975:
	addi	r8, r0, 0
ble_cont.16976:
	j	ble_cont.16974
ble_then.16973:
	addi	r8, r0, 0
ble_cont.16974:
	sw	r7, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r6, 3(r3)
	sw	r1, 4(r3)
	beqi	0, r8, beq_then.16981
	addi	r8, r0, 0
	add	r30, r6, r1
	lw	r9, 0(r30)
	addi	r10, r0, 0
	lw	r11, 2(r9)
	lw	r11, 0(r11)
	ble	r10, r11, ble_then.16983
	j	ble_cont.16984
ble_then.16983:
	add	r30, r6, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	lw	r10, 0(r10)
	add	r30, r5, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16985
	addi	r10, r0, 0
	j	beq_cont.16986
beq_then.16985:
	add	r30, r7, r1
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16987
	addi	r10, r0, 0
	j	beq_cont.16988
beq_then.16987:
	addi	r11, r1, -1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16989
	addi	r10, r0, 0
	j	beq_cont.16990
beq_then.16989:
	addi	r11, r1, 1
	add	r30, r6, r11
	lw	r11, 0(r30)
	lw	r11, 2(r11)
	lw	r11, 0(r11)
	beq	r11, r10, beq_then.16991
	addi	r10, r0, 0
	j	beq_cont.16992
beq_then.16991:
	addi	r10, r0, 1
beq_cont.16992:
beq_cont.16990:
beq_cont.16988:
beq_cont.16986:
	beqi	0, r10, beq_then.16993
	lw	r9, 3(r9)
	lw	r9, 0(r9)
	beqi	0, r9, beq_then.16995
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r8				# mr	r7, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	calc_diffuse_using_5points.3216				#	bl	calc_diffuse_using_5points.3216
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16996
beq_then.16995:
beq_cont.16996:
	addi	r8, r0, 1
	lw	r1, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	lw	r6, 3(r3)
	lw	r7, 0(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	try_exploit_neighbors.3238				#	bl	try_exploit_neighbors.3238
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.16994
beq_then.16993:
	add	r30, r6, r1
	lw	r9, 0(r30)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	do_without_neighbors.3222				#	bl	do_without_neighbors.3222
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.16994:
ble_cont.16984:
	j	beq_cont.16982
beq_then.16981:
	add	r30, r6, r1
	lw	r8, 0(r30)
	lw	r9, 2(r8)
	addi	r10, r0, 0
	lw	r9, 0(r9)
	ble	r10, r9, ble_then.16997
	j	ble_cont.16998
ble_then.16997:
	lw	r9, 3(r8)
	lw	r9, 0(r9)
	sw	r8, 5(r3)
	beqi	0, r9, beq_then.16999
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
	jal	trace_diffuse_ray_80percent.3209				#	bl	trace_diffuse_ray_80percent.3209
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 10740
	lw	r2, 6(r3)
	lw	r2, 0(r2)
	addi	r5, r0, 10737
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	vecaccumv.2906				#	bl	vecaccumv.2906
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.17000
beq_then.16999:
beq_cont.17000:
	addi	r2, r0, 1
	lw	r1, 5(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	do_without_neighbors.3222				#	bl	do_without_neighbors.3222
	addi	r3, r3, -8
	lw	r31, 7(r3)
ble_cont.16998:
beq_cont.16982:
	addi	r1, r0, 10740
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17001
	addi	r1, r0, 0
	j	feq_cont.17002
feq_else.17001:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17003
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.17004
fle_else.17003:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.17004:
feq_cont.17002:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.17005
	addi	r1, r0, 255
	j	ble_cont.17006
ble_then.17005:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17007
	addi	r1, r0, 0
	j	ble_cont.17008
ble_then.17007:
ble_cont.17008:
ble_cont.17006:
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_int.2851				#	bl	print_int.2851
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10740
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17009
	addi	r1, r0, 0
	j	feq_cont.17010
feq_else.17009:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17011
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.17012
fle_else.17011:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.17012:
feq_cont.17010:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.17013
	addi	r1, r0, 255
	j	ble_cont.17014
ble_then.17013:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17015
	addi	r1, r0, 0
	j	ble_cont.17016
ble_then.17015:
ble_cont.17016:
ble_cont.17014:
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_int.2851				#	bl	print_int.2851
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10740
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17017
	addi	r1, r0, 0
	j	feq_cont.17018
feq_else.17017:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17019
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.17020
fle_else.17019:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.17020:
feq_cont.17018:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.17021
	addi	r1, r0, 255
	j	ble_cont.17022
ble_then.17021:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17023
	addi	r1, r0, 0
	j	ble_cont.17024
ble_then.17023:
ble_cont.17024:
ble_cont.17022:
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	print_int.2851				#	bl	print_int.2851
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 10
	out	r1
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	ble	r2, r1, ble_then.17025
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
	ble	r2, r7, ble_then.17026
	blei	0, r5, ble_then.17028
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r7, r1, 1
	ble	r2, r7, ble_then.17030
	blei	0, r1, ble_then.17032
	addi	r2, r0, 1
	j	ble_cont.17033
ble_then.17032:
	addi	r2, r0, 0
ble_cont.17033:
	j	ble_cont.17031
ble_then.17030:
	addi	r2, r0, 0
ble_cont.17031:
	j	ble_cont.17029
ble_then.17028:
	addi	r2, r0, 0
ble_cont.17029:
	j	ble_cont.17027
ble_then.17026:
	addi	r2, r0, 0
ble_cont.17027:
	sw	r1, 7(r3)
	beqi	0, r2, beq_then.17034
	addi	r8, r0, 0
	lw	r2, 1(r3)
	lw	r7, 0(r3)
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r28				# mr	r2, r28
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	try_exploit_neighbors.3238				#	bl	try_exploit_neighbors.3238
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.17035
beq_then.17034:
	add	r30, r6, r1
	lw	r2, 0(r30)
	addi	r7, r0, 0
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r7				# mr	r2, r7
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	do_without_neighbors.3222				#	bl	do_without_neighbors.3222
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.17035:
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	write_rgb.3249				#	bl	write_rgb.3249
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	lw	r6, 3(r3)
	lw	r7, 0(r3)
	j	scan_pixel.3265
ble_then.17025:
	jr	r31				#
ble_then.16972:
	jr	r31				#
scan_line.3271:
	addi	r8, r0, 10743
	lw	r8, 1(r8)
	ble	r8, r1, ble_then.17038
	addi	r8, r0, 10743
	lw	r8, 1(r8)
	addi	r8, r8, -1
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	ble	r8, r1, ble_then.17039
	addi	r8, r1, 1
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	pretrace_line.3261				#	bl	pretrace_line.3261
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	ble_cont.17040
ble_then.17039:
ble_cont.17040:
	addi	r1, r0, 0
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	blei	0, r2, ble_then.17041
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
	ble	r2, r7, ble_then.17043
	blei	0, r5, ble_then.17045
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	blei	1, r2, ble_then.17047
	addi	r2, r0, 0
	j	ble_cont.17048
ble_then.17047:
	addi	r2, r0, 0
ble_cont.17048:
	j	ble_cont.17046
ble_then.17045:
	addi	r2, r0, 0
ble_cont.17046:
	j	ble_cont.17044
ble_then.17043:
	addi	r2, r0, 0
ble_cont.17044:
	beqi	0, r2, beq_then.17049
	addi	r8, r0, 0
	lw	r2, 2(r3)
	lw	r7, 1(r3)
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r28				# mr	r2, r28
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	try_exploit_neighbors.3238				#	bl	try_exploit_neighbors.3238
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.17050
beq_then.17049:
	lw	r1, 0(r6)
	addi	r2, r0, 0
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	do_without_neighbors.3222				#	bl	do_without_neighbors.3222
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.17050:
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	write_rgb.3249				#	bl	write_rgb.3249
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r1, r0, 1
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	lw	r7, 1(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	scan_pixel.3265				#	bl	scan_pixel.3265
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	ble_cont.17042
ble_then.17041:
ble_cont.17042:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	lw	r1, 0(r3)
	addi	r1, r1, 2
	addi	r5, r0, 5
	ble	r5, r1, ble_then.17051
	add	r5, r0, r1
	j	ble_cont.17052
ble_then.17051:
	addi	r5, r1, -5
ble_cont.17052:
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	ble	r1, r2, ble_then.17053
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r5, 5(r3)
	sw	r2, 6(r3)
	ble	r1, r2, ble_then.17055
	addi	r1, r2, 1
	lw	r6, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	pretrace_line.3261				#	bl	pretrace_line.3261
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	ble_cont.17056
ble_then.17055:
ble_cont.17056:
	addi	r1, r0, 0
	lw	r2, 6(r3)
	lw	r5, 4(r3)
	lw	r6, 1(r3)
	lw	r7, 2(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	scan_pixel.3265				#	bl	scan_pixel.3265
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 5(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5
	ble	r5, r2, ble_then.17057
	add	r7, r0, r2
	j	ble_cont.17058
ble_then.17057:
	addi	r7, r2, -5
ble_cont.17058:
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	scan_line.3271				#	bl	scan_line.3271
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	ble_cont.17054
ble_then.17053:
ble_cont.17054:
	jr	r31				#
ble_then.17038:
	jr	r31				#
create_float5x3array.3277:
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
create_pixel.3279:
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
	addi	r3, r3, -5
	lw	r31, 4(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
init_line_elements.3281:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.17061
	jr	r31				#
ble_then.17061:
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
	addi	r3, r3, -7
	lw	r31, 6(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	ble	r2, r1, ble_then.17062
	add	r1, r0, r5
	jr	r31				#
ble_then.17062:
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
	addi	r3, r3, -15
	lw	r31, 14(r3)
	sw	r1, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	j	init_line_elements.3281
create_pixelline.3284:
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
	addi	r3, r3, -6
	lw	r31, 5(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	ble	r5, r2, ble_then.17063
	jr	r31				#
ble_then.17063:
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
	addi	r3, r3, -15
	lw	r31, 14(r3)
	sw	r1, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	j	init_line_elements.3281
tan.3286:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	sin.2831				#	bl	sin.2831
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f2, 0(r3)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	cos.2833				#	bl	cos.2833
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fdiv	f1, f2, f1
	jr	r31				#
adjust_position.3288:
	fmul	f1, f1, f1
	flup	f3, 45		# fli	f3, 0.100000
	fadd	f1, f1, f3
	fsqrt	f1, f1
	flup	f3, 2		# fli	f3, 1.000000
	fdiv	f3, f3, f1
	fle	r30, f0, f3
	beq	r0, r30, fle_else.17064
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.17065
fle_else.17064:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.17065:
	fmul	f3, f3, f4
	flup	f5, 23		# fli	f5, 4.375000
	fsw	f1, 0(r3)
	fsw	f2, 2(r3)
	fle	r30, f5, f3
	beq	r0, r30, fle_else.17066
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f3
	beq	r0, r30, fle_else.17068
	flup	f5, 15		# fli	f5, 1.570796
	flup	f6, 2		# fli	f6, 1.000000
	fdiv	f3, f6, f3
	fsw	f4, 4(r3)
	fsw	f5, 6(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	j	fle_cont.17069
fle_else.17068:
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
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
fle_cont.17069:
	j	fle_cont.17067
fle_else.17066:
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -11
	lw	r31, 10(r3)
fle_cont.17067:
	flw	f2, 2(r3)
	fmul	f1, f1, f2
	fsw	f1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2831				#	bl	sin.2831
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fsw	f1, 12(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	cos.2833				#	bl	cos.2833
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fdiv	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
calc_dirvec.3291:
	addi	r6, r0, 5
	ble	r6, r1, ble_then.17070
	fmul	f1, f2, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f1, f1, f2
	fsqrt	f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f2, f2, f1
	fle	r30, f0, f2
	beq	r0, r30, fle_else.17071
	flup	f5, 2		# fli	f5, 1.000000
	j	fle_cont.17072
fle_else.17071:
	flup	f5, 11		# fli	f5, -1.000000
fle_cont.17072:
	fmul	f2, f2, f5
	flup	f6, 23		# fli	f6, 4.375000
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	fsw	f4, 2(r3)
	sw	r1, 4(r3)
	fsw	f1, 6(r3)
	fsw	f3, 8(r3)
	fle	r30, f6, f2
	beq	r0, r30, fle_else.17074
	flup	f6, 24		# fli	f6, 2.437500
	fle	r30, f6, f2
	beq	r0, r30, fle_else.17076
	flup	f6, 15		# fli	f6, 1.570796
	flup	f7, 2		# fli	f7, 1.000000
	fdiv	f2, f7, f2
	fsw	f5, 10(r3)
	fsw	f6, 12(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fadd	f1, f2, f1
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	j	fle_cont.17077
fle_else.17076:
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
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	flw	f2, 10(r3)
	fmul	f1, f1, f2
fle_cont.17077:
	j	fle_cont.17075
fle_else.17074:
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -17
	lw	r31, 16(r3)
fle_cont.17075:
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	fsw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	sin.2831				#	bl	sin.2831
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fsw	f1, 18(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	cos.2833				#	bl	cos.2833
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
	beq	r0, r30, fle_else.17078
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.17079
fle_else.17078:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.17079:
	fmul	f3, f3, f4
	flup	f5, 23		# fli	f5, 4.375000
	fsw	f1, 20(r3)
	sw	r1, 22(r3)
	fsw	f2, 24(r3)
	fle	r30, f5, f3
	beq	r0, r30, fle_else.17081
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f3
	beq	r0, r30, fle_else.17083
	flup	f5, 15		# fli	f5, 1.570796
	flup	f6, 2		# fli	f6, 1.000000
	fdiv	f3, f6, f3
	fsw	f4, 26(r3)
	fsw	f5, 28(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -31
	lw	r31, 30(r3)
	flw	f2, 28(r3)
	fadd	f1, f2, f1
	flw	f2, 26(r3)
	fmul	f1, f1, f2
	j	fle_cont.17084
fle_else.17083:
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
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -33
	lw	r31, 32(r3)
	flw	f2, 30(r3)
	fadd	f1, f2, f1
	flw	f2, 26(r3)
	fmul	f1, f1, f2
fle_cont.17084:
	j	fle_cont.17082
fle_else.17081:
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	atan_body.2835				#	bl	atan_body.2835
	addi	r3, r3, -33
	lw	r31, 32(r3)
fle_cont.17082:
	flw	f2, 2(r3)
	fmul	f1, f1, f2
	fsw	f1, 32(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	sin.2831				#	bl	sin.2831
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flw	f2, 32(r3)
	fsw	f1, 34(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	cos.2833				#	bl	cos.2833
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
	j	calc_dirvec.3291
ble_then.17070:
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
calc_dirvecs.3299:
	addi	r6, r0, 0
	ble	r6, r1, ble_then.17086
	jr	r31				#
ble_then.17086:
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
	jal	calc_dirvec.3291				#	bl	calc_dirvec.3291
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
	jal	calc_dirvec.3291				#	bl	calc_dirvec.3291
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r1, r1, -1
	lw	r2, 2(r3)
	addi	r2, r2, 1
	addi	r5, r0, 5
	ble	r5, r2, ble_then.17088
	j	ble_cont.17089
ble_then.17088:
	addi	r2, r2, -5
ble_cont.17089:
	flw	f1, 0(r3)
	lw	r5, 3(r3)
	j	calc_dirvecs.3299
calc_dirvec_rows.3304:
	addi	r6, r0, 0
	ble	r6, r1, ble_then.17090
	jr	r31				#
ble_then.17090:
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
	jal	calc_dirvecs.3299				#	bl	calc_dirvecs.3299
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r1, r1, -1
	lw	r2, 1(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5
	ble	r5, r2, ble_then.17092
	j	ble_cont.17093
ble_then.17092:
	addi	r2, r2, -5
ble_cont.17093:
	lw	r5, 0(r3)
	addi	r5, r5, 4
	addi	r6, r0, 0
	ble	r6, r1, ble_then.17094
	jr	r31				#
ble_then.17094:
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
	jal	calc_dirvecs.3299				#	bl	calc_dirvecs.3299
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, -1
	lw	r2, 4(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5
	ble	r5, r2, ble_then.17096
	j	ble_cont.17097
ble_then.17096:
	addi	r2, r2, -5
ble_cont.17097:
	lw	r5, 3(r3)
	addi	r5, r5, 4
	j	calc_dirvec_rows.3304
create_dirvec.3308:
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
create_dirvec_elements.3310:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.17098
	jr	r31				#
ble_then.17098:
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
	ble	r2, r1, ble_then.17100
	jr	r31				#
ble_then.17100:
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
	ble	r2, r1, ble_then.17102
	jr	r31				#
ble_then.17102:
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
	ble	r2, r1, ble_then.17104
	jr	r31				#
ble_then.17104:
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
	j	create_dirvec_elements.3310
create_dirvecs.3313:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17106
	jr	r31				#
ble_then.17106:
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
	jal	create_dirvec_elements.3310				#	bl	create_dirvec_elements.3310
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17108
	jr	r31				#
ble_then.17108:
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
	jal	create_dirvec_elements.3310				#	bl	create_dirvec_elements.3310
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r1, 8(r3)
	addi	r1, r1, -1
	j	create_dirvecs.3313
init_dirvec_constants.3315:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.17110
	jr	r31				#
ble_then.17110:
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
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17112
	jr	r31				#
ble_then.17112:
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 10000
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r1, 2(r3)
	ble	r7, r6, ble_then.17114
	j	ble_cont.17115
ble_then.17114:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 3(r3)
	beqi	1, r10, beq_then.17116
	beqi	2, r10, beq_then.17118
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17119
beq_then.17118:
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17119:
	j	beq_cont.17117
beq_then.17116:
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17117:
	addi	r2, r2, -1
	lw	r1, 3(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -7
	lw	r31, 6(r3)
ble_cont.17115:
	lw	r1, 2(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17120
	jr	r31				#
ble_then.17120:
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
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17122
	jr	r31				#
ble_then.17122:
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 10000
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r1, 7(r3)
	ble	r7, r6, ble_then.17124
	j	ble_cont.17125
ble_then.17124:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 8(r3)
	beqi	1, r10, beq_then.17126
	beqi	2, r10, beq_then.17128
	sw	r6, 9(r3)
	sw	r8, 10(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17129
beq_then.17128:
	sw	r6, 9(r3)
	sw	r8, 10(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17129:
	j	beq_cont.17127
beq_then.17126:
	sw	r6, 9(r3)
	sw	r8, 10(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17127:
	addi	r2, r2, -1
	lw	r1, 8(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -12
	lw	r31, 11(r3)
ble_cont.17125:
	lw	r1, 7(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	j	init_dirvec_constants.3315
init_vecset_constants.3318:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17130
	jr	r31				#
ble_then.17130:
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
	ble	r7, r6, ble_then.17132
	j	ble_cont.17133
ble_then.17132:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 2(r3)
	beqi	1, r10, beq_then.17134
	beqi	2, r10, beq_then.17136
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17137
beq_then.17136:
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17137:
	j	beq_cont.17135
beq_then.17134:
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17135:
	addi	r2, r2, -1
	lw	r1, 2(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -6
	lw	r31, 5(r3)
ble_cont.17133:
	lw	r1, 1(r3)
	lw	r2, 118(r1)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 1(r3)
	lw	r2, 117(r1)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	addi	r6, r0, 0
	ble	r6, r5, ble_then.17138
	j	ble_cont.17139
ble_then.17138:
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 5(r3)
	beqi	1, r9, beq_then.17140
	beqi	2, r9, beq_then.17142
	sw	r5, 6(r3)
	sw	r7, 7(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17143
beq_then.17142:
	sw	r5, 6(r3)
	sw	r7, 7(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17143:
	j	beq_cont.17141
beq_then.17140:
	sw	r5, 6(r3)
	sw	r7, 7(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17141:
	addi	r2, r2, -1
	lw	r1, 5(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -9
	lw	r31, 8(r3)
ble_cont.17139:
	addi	r2, r0, 116
	lw	r1, 1(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	init_dirvec_constants.3315				#	bl	init_dirvec_constants.3315
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17144
	jr	r31				#
ble_then.17144:
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
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 9(r3)
	lw	r2, 118(r1)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	addi	r6, r0, 0
	ble	r6, r5, ble_then.17146
	j	ble_cont.17147
ble_then.17146:
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 10(r3)
	beqi	1, r9, beq_then.17148
	beqi	2, r9, beq_then.17150
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17151
beq_then.17150:
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17151:
	j	beq_cont.17149
beq_then.17148:
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17149:
	addi	r2, r2, -1
	lw	r1, 10(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -14
	lw	r31, 13(r3)
ble_cont.17147:
	addi	r2, r0, 117
	lw	r1, 9(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	init_dirvec_constants.3315				#	bl	init_dirvec_constants.3315
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 8(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17152
	jr	r31				#
ble_then.17152:
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
	ble	r7, r6, ble_then.17154
	j	ble_cont.17155
ble_then.17154:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 15(r3)
	beqi	1, r10, beq_then.17156
	beqi	2, r10, beq_then.17158
	sw	r6, 16(r3)
	sw	r8, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17159
beq_then.17158:
	sw	r6, 16(r3)
	sw	r8, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17159:
	j	beq_cont.17157
beq_then.17156:
	sw	r6, 16(r3)
	sw	r8, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17157:
	addi	r2, r2, -1
	lw	r1, 15(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -19
	lw	r31, 18(r3)
ble_cont.17155:
	addi	r2, r0, 118
	lw	r1, 14(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	init_dirvec_constants.3315				#	bl	init_dirvec_constants.3315
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r1, 13(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17160
	jr	r31				#
ble_then.17160:
	addi	r2, r0, 10766
	add	r30, r2, r1
	lw	r2, 0(r30)
	addi	r5, r0, 119
	sw	r1, 18(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	init_dirvec_constants.3315				#	bl	init_dirvec_constants.3315
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r1, 18(r3)
	addi	r1, r1, -1
	j	init_vecset_constants.3318
init_dirvecs.3320:
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
	jal	create_dirvec_elements.3310				#	bl	create_dirvec_elements.3310
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 3
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_dirvecs.3313				#	bl	create_dirvecs.3313
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
	jal	calc_dirvecs.3299				#	bl	calc_dirvecs.3299
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 8
	addi	r2, r0, 2
	addi	r5, r0, 4
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_dirvec_rows.3304				#	bl	calc_dirvec_rows.3304
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
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 118(r1)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	addi	r6, r0, 0
	ble	r6, r5, ble_then.17162
	j	ble_cont.17163
ble_then.17162:
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 7(r3)
	beqi	1, r9, beq_then.17164
	beqi	2, r9, beq_then.17166
	sw	r5, 8(r3)
	sw	r7, 9(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17167
beq_then.17166:
	sw	r5, 8(r3)
	sw	r7, 9(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17167:
	j	beq_cont.17165
beq_then.17164:
	sw	r5, 8(r3)
	sw	r7, 9(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17165:
	addi	r2, r2, -1
	lw	r1, 7(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -11
	lw	r31, 10(r3)
ble_cont.17163:
	addi	r2, r0, 117
	lw	r1, 6(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	init_dirvec_constants.3315				#	bl	init_dirvec_constants.3315
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
	ble	r6, r5, ble_then.17168
	j	ble_cont.17169
ble_then.17168:
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 11(r3)
	beqi	1, r9, beq_then.17170
	beqi	2, r9, beq_then.17172
	sw	r5, 12(r3)
	sw	r7, 13(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17173
beq_then.17172:
	sw	r5, 12(r3)
	sw	r7, 13(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17173:
	j	beq_cont.17171
beq_then.17170:
	sw	r5, 12(r3)
	sw	r7, 13(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17171:
	addi	r2, r2, -1
	lw	r1, 11(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -15
	lw	r31, 14(r3)
ble_cont.17169:
	addi	r2, r0, 118
	lw	r1, 10(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	init_dirvec_constants.3315				#	bl	init_dirvec_constants.3315
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r1, r0, 10766
	lw	r1, 2(r1)
	addi	r2, r0, 119
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	init_dirvec_constants.3315				#	bl	init_dirvec_constants.3315
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r1, r0, 1
	j	init_vecset_constants.3318
add_reflection.3322:
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
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
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
setup_rect_reflection.3329:
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
	ble	r7, r6, ble_then.17176
	j	ble_cont.17177
ble_then.17176:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.17178
	beqi	2, r8, beq_then.17180
	sw	r6, 16(r3)
	sw	r1, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17181
beq_then.17180:
	sw	r6, 16(r3)
	sw	r1, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17181:
	j	beq_cont.17179
beq_then.17178:
	sw	r6, 16(r3)
	sw	r1, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17179:
	addi	r2, r2, -1
	lw	r1, 15(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -19
	lw	r31, 18(r3)
ble_cont.17177:
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
	ble	r7, r6, ble_then.17182
	j	ble_cont.17183
ble_then.17182:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.17184
	beqi	2, r8, beq_then.17186
	sw	r6, 24(r3)
	sw	r1, 25(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 24(r3)
	lw	r5, 25(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17187
beq_then.17186:
	sw	r6, 24(r3)
	sw	r1, 25(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 24(r3)
	lw	r5, 25(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17187:
	j	beq_cont.17185
beq_then.17184:
	sw	r6, 24(r3)
	sw	r1, 25(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 24(r3)
	lw	r5, 25(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17185:
	addi	r2, r2, -1
	lw	r1, 23(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -27
	lw	r31, 26(r3)
ble_cont.17183:
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
	ble	r7, r6, ble_then.17188
	j	ble_cont.17189
ble_then.17188:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.17190
	beqi	2, r8, beq_then.17192
	sw	r6, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17193
beq_then.17192:
	sw	r6, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17193:
	j	beq_cont.17191
beq_then.17190:
	sw	r6, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17191:
	addi	r2, r2, -1
	lw	r1, 31(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -35
	lw	r31, 34(r3)
ble_cont.17189:
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
setup_surface_reflection.3332:
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
	ble	r7, r6, ble_then.17195
	j	ble_cont.17196
ble_then.17195:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.17197
	beqi	2, r8, beq_then.17199
	sw	r6, 12(r3)
	sw	r1, 13(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17200
beq_then.17199:
	sw	r6, 12(r3)
	sw	r1, 13(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17200:
	j	beq_cont.17198
beq_then.17197:
	sw	r6, 12(r3)
	sw	r1, 13(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17198:
	addi	r2, r2, -1
	lw	r1, 11(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -15
	lw	r31, 14(r3)
ble_cont.17196:
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
setup_reflections.3335:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17202
	jr	r31				#
ble_then.17202:
	addi	r2, r0, 10001
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.17204
	jr	r31				#
beq_then.17204:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 7(r2)
	flw	f2, 0(r5)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17206
	jr	r31				#
fle_else.17206:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.17208
	beqi	2, r5, beq_then.17209
	jr	r31				#
beq_then.17209:
	j	setup_surface_reflection.3332
beq_then.17208:
	j	setup_rect_reflection.3329
rt.3337:
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
	addi	r3, r3, -6
	lw	r31, 5(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	init_line_elements.3281				#	bl	init_line_elements.3281
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
	addi	r3, r3, -15
	lw	r31, 14(r3)
	sw	r1, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	init_line_elements.3281				#	bl	init_line_elements.3281
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
	addi	r3, r3, -24
	lw	r31, 23(r3)
	sw	r1, 23(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	create_float5x3array.3277				#	bl	create_float5x3array.3277
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
	jal	init_line_elements.3281				#	bl	init_line_elements.3281
	addi	r3, r3, -27
	lw	r31, 26(r3)
	sw	r1, 26(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	read_screen_settings.2983				#	bl	read_screen_settings.2983
	addi	r3, r3, -28
	lw	r31, 27(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	read_light.2985				#	bl	read_light.2985
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r1, r0, 0
	sw	r1, 27(r3)
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_nth_object.2990				#	bl	read_nth_object.2990
	addi	r3, r3, -29
	lw	r31, 28(r3)
	beqi	0, r1, beq_then.17211
	addi	r1, r0, 1
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_object.2992				#	bl	read_object.2992
	addi	r3, r3, -29
	lw	r31, 28(r3)
	j	beq_cont.17212
beq_then.17211:
	addi	r1, r0, 10000
	lw	r2, 27(r3)
	sw	r2, 0(r1)
beq_cont.17212:
	addi	r1, r0, 0
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	read_and_network.3000				#	bl	read_and_network.3000
	addi	r3, r3, -29
	lw	r31, 28(r3)
	addi	r1, r0, 10723
	addi	r2, r0, 0
	sw	r1, 28(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	read_or_network.2998				#	bl	read_or_network.2998
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
	jal	print_int.2851				#	bl	print_int.2851
	addi	r3, r3, -30
	lw	r31, 29(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	print_int.2851				#	bl	print_int.2851
	addi	r3, r3, -30
	lw	r31, 29(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 255
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	print_int.2851				#	bl	print_int.2851
	addi	r3, r3, -30
	lw	r31, 29(r3)
	addi	r1, r0, 10
	out	r1
	addi	r1, r0, 4
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	create_dirvecs.3313				#	bl	create_dirvecs.3313
	addi	r3, r3, -30
	lw	r31, 29(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	calc_dirvec_rows.3304				#	bl	calc_dirvec_rows.3304
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
	ble	r6, r5, ble_then.17213
	j	ble_cont.17214
ble_then.17213:
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 30(r3)
	beqi	1, r9, beq_then.17215
	beqi	2, r9, beq_then.17217
	sw	r5, 31(r3)
	sw	r7, 32(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_second_table.3094				#	bl	setup_second_table.3094
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r2, 31(r3)
	lw	r5, 32(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17218
beq_then.17217:
	sw	r5, 31(r3)
	sw	r7, 32(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_surface_table.3091				#	bl	setup_surface_table.3091
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r2, 31(r3)
	lw	r5, 32(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17218:
	j	beq_cont.17216
beq_then.17215:
	sw	r5, 31(r3)
	sw	r7, 32(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_rect_table.3088				#	bl	setup_rect_table.3088
	addi	r3, r3, -34
	lw	r31, 33(r3)
	lw	r2, 31(r3)
	lw	r5, 32(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17216:
	addi	r2, r2, -1
	lw	r1, 30(r3)
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -34
	lw	r31, 33(r3)
ble_cont.17214:
	addi	r2, r0, 118
	lw	r1, 29(r3)
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	init_dirvec_constants.3315				#	bl	init_dirvec_constants.3315
	addi	r3, r3, -34
	lw	r31, 33(r3)
	addi	r1, r0, 10766
	lw	r1, 3(r1)
	addi	r2, r0, 119
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	init_dirvec_constants.3315				#	bl	init_dirvec_constants.3315
	addi	r3, r3, -34
	lw	r31, 33(r3)
	addi	r1, r0, 2
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	init_vecset_constants.3318				#	bl	init_vecset_constants.3318
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
	jal	iter_setup_dirvec_constants.3097				#	bl	iter_setup_dirvec_constants.3097
	addi	r3, r3, -34
	lw	r31, 33(r3)
	addi	r1, r0, 10000
	lw	r1, 0(r1)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17219
	j	ble_cont.17220
ble_then.17219:
	addi	r2, r0, 10001
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.17221
	j	beq_cont.17222
beq_then.17221:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 7(r2)
	flw	f2, 0(r5)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17223
	j	fle_cont.17224
fle_else.17223:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.17225
	beqi	2, r5, beq_then.17227
	j	beq_cont.17228
beq_then.17227:
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_surface_reflection.3332				#	bl	setup_surface_reflection.3332
	addi	r3, r3, -34
	lw	r31, 33(r3)
beq_cont.17228:
	j	beq_cont.17226
beq_then.17225:
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	setup_rect_reflection.3329				#	bl	setup_rect_reflection.3329
	addi	r3, r3, -34
	lw	r31, 33(r3)
beq_cont.17226:
fle_cont.17224:
beq_cont.17222:
ble_cont.17220:
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r1, 17(r3)
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	pretrace_line.3261				#	bl	pretrace_line.3261
	addi	r3, r3, -34
	lw	r31, 33(r3)
	addi	r2, r0, 0
	addi	r5, r0, 2
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	blei	0, r1, ble_then.17229
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r2, 33(r3)
	blei	0, r1, ble_then.17230
	addi	r1, r0, 1
	lw	r6, 26(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	pretrace_line.3261				#	bl	pretrace_line.3261
	addi	r3, r3, -35
	lw	r31, 34(r3)
	j	ble_cont.17231
ble_then.17230:
ble_cont.17231:
	addi	r1, r0, 0
	lw	r2, 33(r3)
	lw	r5, 8(r3)
	lw	r6, 17(r3)
	lw	r7, 26(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	scan_pixel.3265				#	bl	scan_pixel.3265
	addi	r3, r3, -35
	lw	r31, 34(r3)
	addi	r1, r0, 1
	addi	r7, r0, 4
	lw	r2, 17(r3)
	lw	r5, 26(r3)
	lw	r6, 8(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	scan_line.3271				#	bl	scan_line.3271
	addi	r3, r3, -35
	lw	r31, 34(r3)
	jr	r31				#
ble_then.17229:
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
	jal	rt.3337				#	bl	rt.3337
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	_R_0, r0, 0
