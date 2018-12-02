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
print_char.2886:
	out	r1
	jr	r31				#
fispos.2888:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17124
	addi	r1, r0, 0
	jr	r31				#
fle_else.17124:
	addi	r1, r0, 1
	jr	r31				#
fisneg.2890:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17125
	addi	r1, r0, 0
	jr	r31				#
fle_else.17125:
	addi	r1, r0, 1
	jr	r31				#
fiszero.2892:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17126
	addi	r1, r0, 1
	jr	r31				#
feq_else.17126:
	addi	r1, r0, 0
	jr	r31				#
xor.2894:
	beq	r1, r2, beq_then.17127
	addi	r1, r0, 1
	jr	r31				#
beq_then.17127:
	addi	r1, r0, 0
	jr	r31				#
fhalf.2897:
	flup	f2, 1		# fli	f2, 0.500000
	fmul	f1, f1, f2
	jr	r31				#
fsqr.2899:
	fmul	f1, f1, f1
	jr	r31				#
fabs.2901:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17128
	jr	r31				#
fle_else.17128:
	fneg	f1, f1
	jr	r31				#
int_of_float.2903:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17129
	addi	r1, r0, 0
	jr	r31				#
feq_else.17129:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17130
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
fle_else.17130:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
float_of_int.2905:
	itof	r1, r1
	jr	r31				#
floor.2907:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17131
	addi	r1, r0, 0
	j	feq_cont.17132
feq_else.17131:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17133
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.17134
fle_else.17133:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.17134:
feq_cont.17132:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17135
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17135:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
	jr	r31				#
hoge.2909:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17136
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17137
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17138
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17139
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17140
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17141
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17142
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17143
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17144
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17145
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17146
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17147
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17148
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17149
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17150
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17151
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2909
fle_else.17151:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17150:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17149:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17148:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17147:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17146:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17145:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17144:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17143:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17142:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17141:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17140:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17139:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17138:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17137:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.17136:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2912:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17152
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17153
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17154
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17155
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2912
fle_else.17155:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2912
fle_else.17154:
	jr	r31				#
fle_else.17153:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17156
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17157
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2912
fle_else.17157:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2912
fle_else.17156:
	jr	r31				#
fle_else.17152:
	jr	r31				#
modulo_2pi.2916:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 0(r3)
	fsw	f1, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17158
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17160
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17162
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17164
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17166
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17168
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17170
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17172
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17174
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17176
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17178
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17180
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17182
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17184
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17186
	addi	r30, r0, 4060
	lui	r30, r30, 18505	# to load float		205887.438848
	fmvfr	f2, r30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	hoge.2909				#	bl	hoge.2909
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	fle_cont.17187
fle_else.17186:
	fadd	f1, f0, f2
fle_cont.17187:
	j	fle_cont.17185
fle_else.17184:
	fadd	f1, f0, f2
fle_cont.17185:
	j	fle_cont.17183
fle_else.17182:
	fadd	f1, f0, f2
fle_cont.17183:
	j	fle_cont.17181
fle_else.17180:
	fadd	f1, f0, f2
fle_cont.17181:
	j	fle_cont.17179
fle_else.17178:
	fadd	f1, f0, f2
fle_cont.17179:
	j	fle_cont.17177
fle_else.17176:
	fadd	f1, f0, f2
fle_cont.17177:
	j	fle_cont.17175
fle_else.17174:
	fadd	f1, f0, f2
fle_cont.17175:
	j	fle_cont.17173
fle_else.17172:
	fadd	f1, f0, f2
fle_cont.17173:
	j	fle_cont.17171
fle_else.17170:
	fadd	f1, f0, f2
fle_cont.17171:
	j	fle_cont.17169
fle_else.17168:
	fadd	f1, f0, f2
fle_cont.17169:
	j	fle_cont.17167
fle_else.17166:
	fadd	f1, f0, f2
fle_cont.17167:
	j	fle_cont.17165
fle_else.17164:
	fadd	f1, f0, f2
fle_cont.17165:
	j	fle_cont.17163
fle_else.17162:
	fadd	f1, f0, f2
fle_cont.17163:
	j	fle_cont.17161
fle_else.17160:
	fadd	f1, f0, f2
fle_cont.17161:
	j	fle_cont.17159
fle_else.17158:
	fadd	f1, f0, f2
fle_cont.17159:
	flup	f2, 5		# fli	f2, 6.283186
	flw	f3, 2(r3)
	fle	r30, f2, f3
	beq	r0, r30, fle_else.17188
	fle	r30, f1, f3
	beq	r0, r30, fle_else.17189
	fsub	f2, f3, f1
	flup	f3, 3		# fli	f3, 2.000000
	fdiv	f1, f1, f3
	flw	f3, 0(r3)
	fadd	f30, f0, f2				# fmr	f30, f2
	fadd	f2, f0, f1				# fmr	f2, f1
	fadd	f1, f0, f30				# fmr	f1, f30
	j	fuga.2912
fle_else.17189:
	flup	f2, 3		# fli	f2, 2.000000
	fdiv	f2, f1, f2
	flw	f1, 0(r3)
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f30				# fmr	f1, f30
	j	fuga.2912
fle_else.17188:
	fadd	f1, f0, f3
	jr	r31				#
sin_body.2918:
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
cos_body.2920:
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
sin.2922:
	flup	f2, 14		# fli	f2, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17190
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.17191
fle_else.17190:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.17191:
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
	beq	r0, r30, fle_else.17192
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17194
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17196
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17198
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17200
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17202
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17204
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17206
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17208
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17210
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17212
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17214
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17216
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17218
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2909				#	bl	hoge.2909
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.17219
fle_else.17218:
fle_cont.17219:
	j	fle_cont.17217
fle_else.17216:
fle_cont.17217:
	j	fle_cont.17215
fle_else.17214:
fle_cont.17215:
	j	fle_cont.17213
fle_else.17212:
fle_cont.17213:
	j	fle_cont.17211
fle_else.17210:
fle_cont.17211:
	j	fle_cont.17209
fle_else.17208:
fle_cont.17209:
	j	fle_cont.17207
fle_else.17206:
fle_cont.17207:
	j	fle_cont.17205
fle_else.17204:
fle_cont.17205:
	j	fle_cont.17203
fle_else.17202:
fle_cont.17203:
	j	fle_cont.17201
fle_else.17200:
fle_cont.17201:
	j	fle_cont.17199
fle_else.17198:
fle_cont.17199:
	j	fle_cont.17197
fle_else.17196:
fle_cont.17197:
	j	fle_cont.17195
fle_else.17194:
fle_cont.17195:
	j	fle_cont.17193
fle_else.17192:
fle_cont.17193:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2912				#	bl	fuga.2912
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17220
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17221
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17222
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
fle_else.17222:
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
fle_else.17221:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17223
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
fle_else.17223:
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
fle_else.17220:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.17224
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17225
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
fle_else.17225:
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
fle_else.17224:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17226
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
fle_else.17226:
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
cos.2924:
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
	beq	r0, r30, fle_else.17227
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17229
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17231
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17233
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17235
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17237
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17239
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17241
	addi	r30, r0, 4060
	lui	r30, r30, 17609	# to load float		1608.495616
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17243
	addi	r30, r0, 4060
	lui	r30, r30, 17737	# to load float		3216.991232
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17245
	addi	r30, r0, 4060
	lui	r30, r30, 17865	# to load float		6433.982464
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17247
	addi	r30, r0, 4060
	lui	r30, r30, 17993	# to load float		12867.964928
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17249
	addi	r30, r0, 4060
	lui	r30, r30, 18121	# to load float		25735.929856
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17251
	addi	r30, r0, 4060
	lui	r30, r30, 18249	# to load float		51471.859712
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17253
	addi	r30, r0, 4060
	lui	r30, r30, 18377	# to load float		102943.719424
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2909				#	bl	hoge.2909
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.17254
fle_else.17253:
fle_cont.17254:
	j	fle_cont.17252
fle_else.17251:
fle_cont.17252:
	j	fle_cont.17250
fle_else.17249:
fle_cont.17250:
	j	fle_cont.17248
fle_else.17247:
fle_cont.17248:
	j	fle_cont.17246
fle_else.17245:
fle_cont.17246:
	j	fle_cont.17244
fle_else.17243:
fle_cont.17244:
	j	fle_cont.17242
fle_else.17241:
fle_cont.17242:
	j	fle_cont.17240
fle_else.17239:
fle_cont.17240:
	j	fle_cont.17238
fle_else.17237:
fle_cont.17238:
	j	fle_cont.17236
fle_else.17235:
fle_cont.17236:
	j	fle_cont.17234
fle_else.17233:
fle_cont.17234:
	j	fle_cont.17232
fle_else.17231:
fle_cont.17232:
	j	fle_cont.17230
fle_else.17229:
fle_cont.17230:
	j	fle_cont.17228
fle_else.17227:
fle_cont.17228:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2912				#	bl	fuga.2912
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17255
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17256
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.17257
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
fle_else.17257:
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
fle_else.17256:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17258
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
fle_else.17258:
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
fle_else.17255:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.17259
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.17260
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
fle_else.17260:
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
fle_else.17259:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17261
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
fle_else.17261:
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
atan_body.2926:
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
atan.2928:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17262
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.17263
fle_else.17262:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.17263:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.17264
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.17265
	flup	f3, 15		# fli	f3, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.17265:
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
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.17264:
	j	atan_body.2926
print_num.2930:
	addi	r1, r1, 48
	out	r1
	jr	r31				#
mul10.2932:
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	jr	r31				#
div10_sub.2934:
	add	r6, r2, r5
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.17266
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r7, r5, 3
	slli	r8, r5, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.17267
	j	div10_sub.2934
ble_then.17267:
	slli	r2, r5, 3
	slli	r7, r5, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.17268
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	j	div10_sub.2934
ble_then.17268:
	add	r1, r0, r5
	jr	r31				#
ble_then.17266:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.17269
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r7, r2, 3
	slli	r8, r2, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.17270
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r6				# mr	r2, r6
	j	div10_sub.2934
ble_then.17270:
	slli	r6, r2, 3
	slli	r7, r2, 1
	add	r6, r6, r7
	addi	r6, r6, 9
	ble	r1, r6, ble_then.17271
	j	div10_sub.2934
ble_then.17271:
	add	r1, r0, r2
	jr	r31				#
ble_then.17269:
	add	r1, r0, r6
	jr	r31				#
div10.2938:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.17272
	j	div10_sub.2934
ble_then.17272:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.17273
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	j	div10_sub.2934
ble_then.17273:
	add	r1, r0, r5
	jr	r31				#
iter_mul10.2940:
	beqi	0, r2, beq_then.17274
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	beqi	0, r2, beq_then.17275
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	beqi	0, r2, beq_then.17276
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	beqi	0, r2, beq_then.17277
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	j	iter_mul10.2940
beq_then.17277:
	jr	r31				#
beq_then.17276:
	jr	r31				#
beq_then.17275:
	jr	r31				#
beq_then.17274:
	jr	r31				#
iter_div10.2943:
	beqi	0, r2, beq_then.17278
	addi	r5, r0, 0
	sw	r2, 0(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.17279
	addi	r5, r0, 0
	addi	r6, r1, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r2, 1(r3)
	ble	r7, r1, ble_then.17280
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.17281
ble_then.17280:
	slli	r5, r6, 3
	slli	r7, r6, 1
	add	r5, r5, r7
	addi	r5, r5, 9
	ble	r1, r5, ble_then.17282
	add	r5, r0, r1				# mr	r5, r1
	add	r2, r0, r6				# mr	r2, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.17283
ble_then.17282:
	add	r1, r0, r6
ble_cont.17283:
ble_cont.17281:
	lw	r2, 1(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.17284
	addi	r5, r0, 0
	sw	r2, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 2(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.17285
	addi	r5, r0, 0
	addi	r6, r1, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r2, 3(r3)
	ble	r7, r1, ble_then.17286
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.17287
ble_then.17286:
	slli	r5, r6, 3
	slli	r7, r6, 1
	add	r5, r5, r7
	addi	r5, r5, 9
	ble	r1, r5, ble_then.17288
	add	r5, r0, r1				# mr	r5, r1
	add	r2, r0, r6				# mr	r2, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.17289
ble_then.17288:
	add	r1, r0, r6
ble_cont.17289:
ble_cont.17287:
	lw	r2, 3(r3)
	addi	r2, r2, -1
	j	iter_div10.2943
beq_then.17285:
	jr	r31				#
beq_then.17284:
	jr	r31				#
beq_then.17279:
	jr	r31				#
beq_then.17278:
	jr	r31				#
keta_sub.2946:
	addi	r5, r0, 10
	ble	r5, r1, ble_then.17290
	addi	r1, r2, 1
	jr	r31				#
ble_then.17290:
	addi	r5, r0, 0
	sw	r2, 0(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	addi	r2, r2, 1
	addi	r5, r0, 10
	ble	r5, r1, ble_then.17291
	addi	r1, r2, 1
	jr	r31				#
ble_then.17291:
	addi	r5, r0, 0
	addi	r6, r1, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r2, 1(r3)
	ble	r7, r1, ble_then.17292
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.17293
ble_then.17292:
	slli	r5, r6, 3
	slli	r7, r6, 1
	add	r5, r5, r7
	addi	r5, r5, 9
	ble	r1, r5, ble_then.17294
	add	r5, r0, r1				# mr	r5, r1
	add	r2, r0, r6				# mr	r2, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.17295
ble_then.17294:
	add	r1, r0, r6
ble_cont.17295:
ble_cont.17293:
	lw	r2, 1(r3)
	addi	r2, r2, 1
	addi	r5, r0, 10
	ble	r5, r1, ble_then.17296
	addi	r1, r2, 1
	jr	r31				#
ble_then.17296:
	addi	r5, r0, 0
	sw	r2, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 2(r3)
	addi	r2, r2, 1
	addi	r5, r0, 10
	ble	r5, r1, ble_then.17297
	addi	r1, r2, 1
	jr	r31				#
ble_then.17297:
	addi	r5, r0, 0
	addi	r6, r1, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r2, 3(r3)
	ble	r7, r1, ble_then.17298
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.17299
ble_then.17298:
	slli	r5, r6, 3
	slli	r7, r6, 1
	add	r5, r5, r7
	addi	r5, r5, 9
	ble	r1, r5, ble_then.17300
	add	r5, r0, r1				# mr	r5, r1
	add	r2, r0, r6				# mr	r2, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.17301
ble_then.17300:
	add	r1, r0, r6
ble_cont.17301:
ble_cont.17299:
	lw	r2, 3(r3)
	addi	r2, r2, 1
	j	keta_sub.2946
keta.2949:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.17302
	addi	r1, r0, 1
	jr	r31				#
ble_then.17302:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.17303
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	ble_cont.17304
ble_then.17303:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.17305
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	ble_cont.17306
ble_then.17305:
	add	r1, r0, r5
ble_cont.17306:
ble_cont.17304:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.17307
	addi	r1, r0, 2
	jr	r31				#
ble_then.17307:
	addi	r2, r0, 0
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r2, r0, 10
	ble	r2, r1, ble_then.17308
	addi	r1, r0, 3
	jr	r31				#
ble_then.17308:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.17309
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	ble_cont.17310
ble_then.17309:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.17311
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	ble_cont.17312
ble_then.17311:
	add	r1, r0, r5
ble_cont.17312:
ble_cont.17310:
	addi	r2, r0, 3
	j	keta_sub.2946
print_uint_keta.2951:
	beqi	1, r2, beq_then.17313
	addi	r5, r2, -1
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	beqi	0, r5, beq_then.17314
	addi	r5, r5, -1
	beqi	0, r5, beq_then.17316
	addi	r5, r5, -1
	beqi	0, r5, beq_then.17318
	addi	r6, r0, 1000
	addi	r5, r5, -1
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	iter_mul10.2940				#	bl	iter_mul10.2940
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.17319
beq_then.17318:
	addi	r1, r0, 100
beq_cont.17319:
	j	beq_cont.17317
beq_then.17316:
	addi	r1, r0, 10
beq_cont.17317:
	j	beq_cont.17315
beq_then.17314:
	addi	r1, r0, 1
beq_cont.17315:
	lw	r5, 1(r3)
	ble	r1, r5, ble_then.17320
	addi	r1, r0, 48
	out	r1
	lw	r1, 0(r3)
	addi	r1, r1, -1
	beqi	1, r1, beq_then.17321
	addi	r2, r1, -1
	sw	r1, 2(r3)
	beqi	0, r2, beq_then.17322
	addi	r2, r2, -1
	beqi	0, r2, beq_then.17324
	addi	r6, r0, 100
	addi	r2, r2, -1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	iter_mul10.2940				#	bl	iter_mul10.2940
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.17325
beq_then.17324:
	addi	r1, r0, 10
beq_cont.17325:
	j	beq_cont.17323
beq_then.17322:
	addi	r1, r0, 1
beq_cont.17323:
	lw	r5, 1(r3)
	ble	r1, r5, ble_then.17326
	addi	r1, r0, 48
	out	r1
	lw	r1, 2(r3)
	addi	r2, r1, -1
	add	r1, r0, r5				# mr	r1, r5
	j	print_uint_keta.2951
ble_then.17326:
	lw	r1, 2(r3)
	addi	r2, r1, -1
	beqi	0, r2, beq_then.17327
	addi	r6, r0, 0
	sw	r2, 3(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.17329
	addi	r5, r0, 0
	addi	r6, r1, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r2, 4(r3)
	ble	r7, r1, ble_then.17331
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	ble_cont.17332
ble_then.17331:
	slli	r5, r6, 3
	slli	r7, r6, 1
	add	r5, r5, r7
	addi	r5, r5, 9
	ble	r1, r5, ble_then.17333
	add	r5, r0, r1				# mr	r5, r1
	add	r2, r0, r6				# mr	r2, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	ble_cont.17334
ble_then.17333:
	add	r1, r0, r6
ble_cont.17334:
ble_cont.17332:
	lw	r2, 4(r3)
	addi	r2, r2, -1
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_div10.2943				#	bl	iter_div10.2943
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.17330
beq_then.17329:
beq_cont.17330:
	j	beq_cont.17328
beq_then.17327:
	add	r1, r0, r5
beq_cont.17328:
	addi	r2, r1, 48
	out	r2
	lw	r2, 2(r3)
	addi	r5, r2, -1
	beqi	0, r5, beq_then.17335
	slli	r6, r1, 3
	slli	r1, r1, 1
	add	r1, r6, r1
	addi	r5, r5, -1
	beqi	0, r5, beq_then.17337
	slli	r6, r1, 3
	slli	r1, r1, 1
	add	r1, r6, r1
	addi	r5, r5, -1
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_mul10.2940				#	bl	iter_mul10.2940
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.17338
beq_then.17337:
beq_cont.17338:
	j	beq_cont.17336
beq_then.17335:
beq_cont.17336:
	lw	r2, 1(r3)
	sub	r1, r2, r1
	lw	r2, 2(r3)
	addi	r2, r2, -1
	j	print_uint_keta.2951
beq_then.17321:
	addi	r1, r5, 48
	out	r1
	jr	r31				#
ble_then.17320:
	lw	r1, 0(r3)
	addi	r2, r1, -1
	beqi	0, r2, beq_then.17339
	addi	r6, r0, 0
	addi	r7, r5, 0
	srai	r7, r7, 1
	slli	r8, r7, 3
	slli	r9, r7, 1
	add	r8, r8, r9
	sw	r2, 5(r3)
	ble	r8, r5, ble_then.17341
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	ble_cont.17342
ble_then.17341:
	slli	r6, r7, 3
	slli	r8, r7, 1
	add	r6, r6, r8
	addi	r6, r6, 9
	ble	r5, r6, ble_then.17343
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	ble_cont.17344
ble_then.17343:
	add	r1, r0, r7
ble_cont.17344:
ble_cont.17342:
	lw	r2, 5(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.17345
	addi	r5, r0, 0
	sw	r2, 6(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.17347
	addi	r5, r0, 0
	addi	r6, r1, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r2, 7(r3)
	ble	r7, r1, ble_then.17349
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	ble_cont.17350
ble_then.17349:
	slli	r5, r6, 3
	slli	r7, r6, 1
	add	r5, r5, r7
	addi	r5, r5, 9
	ble	r1, r5, ble_then.17351
	add	r5, r0, r1				# mr	r5, r1
	add	r2, r0, r6				# mr	r2, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	ble_cont.17352
ble_then.17351:
	add	r1, r0, r6
ble_cont.17352:
ble_cont.17350:
	lw	r2, 7(r3)
	addi	r2, r2, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	iter_div10.2943				#	bl	iter_div10.2943
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.17348
beq_then.17347:
beq_cont.17348:
	j	beq_cont.17346
beq_then.17345:
beq_cont.17346:
	j	beq_cont.17340
beq_then.17339:
	add	r1, r0, r5
beq_cont.17340:
	addi	r2, r1, 48
	out	r2
	lw	r2, 0(r3)
	addi	r5, r2, -1
	beqi	0, r5, beq_then.17353
	slli	r6, r1, 3
	slli	r1, r1, 1
	add	r1, r6, r1
	addi	r5, r5, -1
	beqi	0, r5, beq_then.17355
	slli	r6, r1, 3
	slli	r1, r1, 1
	add	r1, r6, r1
	addi	r5, r5, -1
	beqi	0, r5, beq_then.17357
	slli	r6, r1, 3
	slli	r1, r1, 1
	add	r1, r6, r1
	addi	r5, r5, -1
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	iter_mul10.2940				#	bl	iter_mul10.2940
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.17358
beq_then.17357:
beq_cont.17358:
	j	beq_cont.17356
beq_then.17355:
beq_cont.17356:
	j	beq_cont.17354
beq_then.17353:
beq_cont.17354:
	lw	r2, 1(r3)
	sub	r1, r2, r1
	lw	r2, 0(r3)
	addi	r2, r2, -1
	beqi	1, r2, beq_then.17359
	addi	r5, r2, -1
	sw	r2, 8(r3)
	sw	r1, 9(r3)
	beqi	0, r5, beq_then.17360
	addi	r5, r5, -1
	beqi	0, r5, beq_then.17362
	addi	r6, r0, 100
	addi	r5, r5, -1
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	iter_mul10.2940				#	bl	iter_mul10.2940
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.17363
beq_then.17362:
	addi	r1, r0, 10
beq_cont.17363:
	j	beq_cont.17361
beq_then.17360:
	addi	r1, r0, 1
beq_cont.17361:
	lw	r5, 9(r3)
	ble	r1, r5, ble_then.17364
	addi	r1, r0, 48
	out	r1
	lw	r1, 8(r3)
	addi	r2, r1, -1
	add	r1, r0, r5				# mr	r1, r5
	j	print_uint_keta.2951
ble_then.17364:
	lw	r1, 8(r3)
	addi	r2, r1, -1
	beqi	0, r2, beq_then.17365
	addi	r6, r0, 0
	sw	r2, 10(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 10(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.17367
	addi	r5, r0, 0
	addi	r6, r1, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r2, 11(r3)
	ble	r7, r1, ble_then.17369
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.17370
ble_then.17369:
	slli	r5, r6, 3
	slli	r7, r6, 1
	add	r5, r5, r7
	addi	r5, r5, 9
	ble	r1, r5, ble_then.17371
	add	r5, r0, r1				# mr	r5, r1
	add	r2, r0, r6				# mr	r2, r6
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.17372
ble_then.17371:
	add	r1, r0, r6
ble_cont.17372:
ble_cont.17370:
	lw	r2, 11(r3)
	addi	r2, r2, -1
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	iter_div10.2943				#	bl	iter_div10.2943
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.17368
beq_then.17367:
beq_cont.17368:
	j	beq_cont.17366
beq_then.17365:
	add	r1, r0, r5
beq_cont.17366:
	addi	r2, r1, 48
	out	r2
	lw	r2, 8(r3)
	addi	r5, r2, -1
	beqi	0, r5, beq_then.17373
	slli	r6, r1, 3
	slli	r1, r1, 1
	add	r1, r6, r1
	addi	r5, r5, -1
	beqi	0, r5, beq_then.17375
	slli	r6, r1, 3
	slli	r1, r1, 1
	add	r1, r6, r1
	addi	r5, r5, -1
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	iter_mul10.2940				#	bl	iter_mul10.2940
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.17376
beq_then.17375:
beq_cont.17376:
	j	beq_cont.17374
beq_then.17373:
beq_cont.17374:
	lw	r2, 9(r3)
	sub	r1, r2, r1
	lw	r2, 8(r3)
	addi	r2, r2, -1
	j	print_uint_keta.2951
beq_then.17359:
	addi	r1, r1, 48
	out	r1
	jr	r31				#
beq_then.17313:
	addi	r1, r1, 48
	out	r1
	jr	r31				#
print_uint.2954:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.17377
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.17377:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 10
	sw	r1, 1(r3)
	ble	r2, r1, ble_then.17378
	addi	r2, r1, 48
	out	r2
	j	ble_cont.17379
ble_then.17378:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.17380
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.17381
ble_then.17380:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.17382
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.17383
ble_then.17382:
	add	r1, r0, r5
ble_cont.17383:
ble_cont.17381:
	addi	r2, r0, 10
	sw	r1, 2(r3)
	ble	r2, r1, ble_then.17384
	addi	r2, r1, 48
	out	r2
	j	ble_cont.17385
ble_then.17384:
	addi	r2, r0, 0
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 10
	sw	r1, 3(r3)
	ble	r2, r1, ble_then.17386
	addi	r2, r1, 48
	out	r2
	j	ble_cont.17387
ble_then.17386:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.17388
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.17389
ble_then.17388:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.17390
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2934				#	bl	div10_sub.2934
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	ble_cont.17391
ble_then.17390:
	add	r1, r0, r5
ble_cont.17391:
ble_cont.17389:
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	print_uint.2954				#	bl	print_uint.2954
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
ble_cont.17387:
	lw	r1, 3(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 2(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.17385:
	lw	r1, 2(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 1(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
ble_cont.17379:
	lw	r1, 1(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
	jr	r31				#
print_int.2956:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17392
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	j	print_int.2956
ble_then.17392:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.17393
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.17393:
	addi	r2, r0, 100
	ble	r2, r1, ble_then.17394
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
ble_then.17394:
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
read_token.2958:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_char				#	bl	lib_read_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 32
	beq	r1, r2, beq_then.17395
	beqi	9, r1, beq_then.17396
	beqi	13, r1, beq_then.17397
	beqi	10, r1, beq_then.17398
	addi	r2, r0, 26
	beq	r1, r2, beq_then.17399
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_buffer_add_char				#	bl	lib_buffer_add_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 1
	j	read_token.2958
beq_then.17399:
	jr	r31				#
beq_then.17398:
	lw	r1, 0(r3)
	beqi	0, r1, beq_then.17401
	jr	r31				#
beq_then.17401:
	addi	r1, r0, 0
	j	read_token.2958
beq_then.17397:
	lw	r1, 0(r3)
	beqi	0, r1, beq_then.17403
	jr	r31				#
beq_then.17403:
	addi	r1, r0, 0
	j	read_token.2958
beq_then.17396:
	lw	r1, 0(r3)
	beqi	0, r1, beq_then.17405
	jr	r31				#
beq_then.17405:
	addi	r1, r0, 0
	j	read_token.2958
beq_then.17395:
	lw	r1, 0(r3)
	beqi	0, r1, beq_then.17407
	jr	r31				#
beq_then.17407:
	addi	r1, r0, 0
	j	read_token.2958
read_int_ascii.2960:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_buffer_clear				#	bl	lib_buffer_clear
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_token.2958				#	bl	read_token.2958
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	lib_buffer_to_int
iter_div10_float.2962:
	beqi	0, r1, beq_then.17409
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17410
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17411
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17412
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17413
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17414
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17415
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17416
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	j	iter_div10_float.2962
beq_then.17416:
	jr	r31				#
beq_then.17415:
	jr	r31				#
beq_then.17414:
	jr	r31				#
beq_then.17413:
	jr	r31				#
beq_then.17412:
	jr	r31				#
beq_then.17411:
	jr	r31				#
beq_then.17410:
	jr	r31				#
beq_then.17409:
	jr	r31				#
read_float_ascii.2965:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_buffer_clear				#	bl	lib_buffer_clear
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_token.2958				#	bl	read_token.2958
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_buffer_get				#	bl	lib_buffer_get
	addi	r3, r3, -1
	lw	r31, 0(r3)
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_buffer_to_int_of_float				#	bl	lib_buffer_to_int_of_float
	addi	r3, r3, -2
	lw	r31, 1(r3)
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_buffer_to_dec_of_float				#	bl	lib_buffer_to_dec_of_float
	addi	r3, r3, -3
	lw	r31, 2(r3)
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_buffer_to_ika_keta_of_float				#	bl	lib_buffer_to_ika_keta_of_float
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 45
	lw	r5, 0(r3)
	beq	r5, r2, beq_then.17417
	lw	r2, 1(r3)
	itof	f1, r2
	lw	r2, 2(r3)
	itof	f2, r2
	fsw	f1, 4(r3)
	beqi	0, r1, beq_then.17419
	flup	f3, 39		# fli	f3, 10.000000
	fdiv	f2, f2, f3
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17421
	flup	f3, 39		# fli	f3, 10.000000
	fdiv	f2, f2, f3
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17423
	flup	f3, 39		# fli	f3, 10.000000
	fdiv	f2, f2, f3
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17425
	flup	f3, 39		# fli	f3, 10.000000
	fdiv	f2, f2, f3
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17427
	flup	f3, 39		# fli	f3, 10.000000
	fdiv	f2, f2, f3
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17429
	flup	f3, 39		# fli	f3, 10.000000
	fdiv	f2, f2, f3
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17431
	flup	f3, 39		# fli	f3, 10.000000
	fdiv	f2, f2, f3
	addi	r1, r1, -1
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_div10_float.2962				#	bl	iter_div10_float.2962
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.17432
beq_then.17431:
	fadd	f1, f0, f2
beq_cont.17432:
	j	beq_cont.17430
beq_then.17429:
	fadd	f1, f0, f2
beq_cont.17430:
	j	beq_cont.17428
beq_then.17427:
	fadd	f1, f0, f2
beq_cont.17428:
	j	beq_cont.17426
beq_then.17425:
	fadd	f1, f0, f2
beq_cont.17426:
	j	beq_cont.17424
beq_then.17423:
	fadd	f1, f0, f2
beq_cont.17424:
	j	beq_cont.17422
beq_then.17421:
	fadd	f1, f0, f2
beq_cont.17422:
	j	beq_cont.17420
beq_then.17419:
	fadd	f1, f0, f2
beq_cont.17420:
	flw	f2, 4(r3)
	fadd	f1, f2, f1
	jr	r31				#
beq_then.17417:
	flup	f1, 11		# fli	f1, -1.000000
	lw	r2, 1(r3)
	itof	f2, r2
	lw	r2, 2(r3)
	itof	f3, r2
	fsw	f1, 6(r3)
	fsw	f2, 8(r3)
	beqi	0, r1, beq_then.17433
	flup	f4, 39		# fli	f4, 10.000000
	fdiv	f3, f3, f4
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17435
	flup	f4, 39		# fli	f4, 10.000000
	fdiv	f3, f3, f4
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17437
	flup	f4, 39		# fli	f4, 10.000000
	fdiv	f3, f3, f4
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17439
	flup	f4, 39		# fli	f4, 10.000000
	fdiv	f3, f3, f4
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17441
	flup	f4, 39		# fli	f4, 10.000000
	fdiv	f3, f3, f4
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17443
	flup	f4, 39		# fli	f4, 10.000000
	fdiv	f3, f3, f4
	addi	r1, r1, -1
	beqi	0, r1, beq_then.17445
	flup	f4, 39		# fli	f4, 10.000000
	fdiv	f3, f3, f4
	addi	r1, r1, -1
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	iter_div10_float.2962				#	bl	iter_div10_float.2962
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.17446
beq_then.17445:
	fadd	f1, f0, f3
beq_cont.17446:
	j	beq_cont.17444
beq_then.17443:
	fadd	f1, f0, f3
beq_cont.17444:
	j	beq_cont.17442
beq_then.17441:
	fadd	f1, f0, f3
beq_cont.17442:
	j	beq_cont.17440
beq_then.17439:
	fadd	f1, f0, f3
beq_cont.17440:
	j	beq_cont.17438
beq_then.17437:
	fadd	f1, f0, f3
beq_cont.17438:
	j	beq_cont.17436
beq_then.17435:
	fadd	f1, f0, f3
beq_cont.17436:
	j	beq_cont.17434
beq_then.17433:
	fadd	f1, f0, f3
beq_cont.17434:
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	flw	f2, 6(r3)
	fmul	f1, f2, f1
	jr	r31				#
truncate.2967:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17447
	addi	r1, r0, 0
	jr	r31				#
feq_else.17447:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17448
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
fle_else.17448:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
abs_float.2969:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17449
	jr	r31				#
fle_else.17449:
	fneg	f1, f1
	jr	r31				#
print_dec.2971:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17450
	jr	r31				#
feq_else.17450:
	flup	f2, 39		# fli	f2, 10.000000
	fmul	f1, f2, f1
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17452
	addi	r1, r0, 0
	j	feq_cont.17453
feq_else.17452:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17454
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.17455
fle_else.17454:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.17455:
feq_cont.17453:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f1, 0(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17456
	addi	r1, r0, 0
	j	feq_cont.17457
feq_else.17456:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17458
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.17459
fle_else.17458:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.17459:
feq_cont.17457:
	itof	f2, r1
	fsub	f1, f1, f2
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17460
	jr	r31				#
feq_else.17460:
	flup	f2, 39		# fli	f2, 10.000000
	fmul	f1, f2, f1
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17462
	addi	r1, r0, 0
	j	feq_cont.17463
feq_else.17462:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17464
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.17465
fle_else.17464:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.17465:
feq_cont.17463:
	fsw	f1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f1, 2(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17466
	addi	r1, r0, 0
	j	feq_cont.17467
feq_else.17466:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17468
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.17469
fle_else.17468:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.17469:
feq_cont.17467:
	itof	f2, r1
	fsub	f1, f1, f2
	j	print_dec.2971
print_ufloat.2973:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17470
	addi	r1, r0, 0
	j	feq_cont.17471
feq_else.17470:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17472
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.17473
fle_else.17472:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.17473:
feq_cont.17471:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r1, r0, 46
	out	r1
	flw	f1, 0(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17474
	addi	r1, r0, 0
	j	feq_cont.17475
feq_else.17474:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17476
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.17477
fle_else.17476:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.17477:
feq_cont.17475:
	itof	f2, r1
	fsub	f1, f1, f2
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17478
	jr	r31				#
feq_else.17478:
	flup	f2, 39		# fli	f2, 10.000000
	fmul	f1, f2, f1
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17480
	addi	r1, r0, 0
	j	feq_cont.17481
feq_else.17480:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17482
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.17483
fle_else.17482:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.17483:
feq_cont.17481:
	fsw	f1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f1, 2(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17484
	addi	r1, r0, 0
	j	feq_cont.17485
feq_else.17484:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17486
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.17487
fle_else.17486:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.17487:
feq_cont.17485:
	itof	f2, r1
	fsub	f1, f1, f2
	j	print_dec.2971
print_float.2975:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17488
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17489
	addi	r1, r0, 0
	j	feq_cont.17490
feq_else.17489:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17491
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.17492
fle_else.17491:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.17492:
feq_cont.17490:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r1, r0, 46
	out	r1
	flw	f1, 0(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17493
	addi	r1, r0, 0
	j	feq_cont.17494
feq_else.17493:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17495
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.17496
fle_else.17495:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.17496:
feq_cont.17494:
	itof	f2, r1
	fsub	f1, f1, f2
	j	print_dec.2971
fle_else.17488:
	addi	r1, r0, 45
	out	r1
	fneg	f1, f1
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17497
	addi	r1, r0, 0
	j	feq_cont.17498
feq_else.17497:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17499
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.17500
fle_else.17499:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.17500:
feq_cont.17498:
	fsw	f1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 46
	out	r1
	flw	f1, 2(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17501
	addi	r1, r0, 0
	j	feq_cont.17502
feq_else.17501:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17503
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.17504
fle_else.17503:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.17504:
feq_cont.17502:
	itof	f2, r1
	fsub	f1, f1, f2
	j	print_dec.2971
xor.2980:
	beqi	0, r1, beq_then.17505
	beqi	0, r2, beq_then.17506
	addi	r1, r0, 0
	jr	r31				#
beq_then.17506:
	addi	r1, r0, 1
	jr	r31				#
beq_then.17505:
	add	r1, r0, r2
	jr	r31				#
sgn.2983:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17507
	addi	r1, r0, 1
	j	feq_cont.17508
feq_else.17507:
	addi	r1, r0, 0
feq_cont.17508:
	beqi	0, r1, beq_then.17509
	flup	f1, 0		# fli	f1, 0.000000
	jr	r31				#
beq_then.17509:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17510
	addi	r1, r0, 0
	j	fle_cont.17511
fle_else.17510:
	addi	r1, r0, 1
fle_cont.17511:
	beqi	0, r1, beq_then.17512
	flup	f1, 2		# fli	f1, 1.000000
	jr	r31				#
beq_then.17512:
	flup	f1, 11		# fli	f1, -1.000000
	jr	r31				#
fneg_cond.2985:
	beqi	0, r1, beq_then.17513
	jr	r31				#
beq_then.17513:
	fneg	f1, f1
	jr	r31				#
add_mod5.2988:
	add	r1, r1, r2
	addi	r2, r0, 5
	ble	r2, r1, ble_then.17514
	jr	r31				#
ble_then.17514:
	addi	r1, r1, -5
	jr	r31				#
vecset.2991:
	fsw	f1, 0(r1)
	fsw	f2, 1(r1)
	fsw	f3, 2(r1)
	jr	r31				#
vecfill.2996:
	fsw	f1, 0(r1)
	fsw	f1, 1(r1)
	fsw	f1, 2(r1)
	jr	r31				#
vecbzero.2999:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
	fsw	f1, 1(r1)
	fsw	f1, 2(r1)
	jr	r31				#
veccpy.3001:
	flw	f1, 0(r2)
	fsw	f1, 0(r1)
	flw	f1, 1(r2)
	fsw	f1, 1(r1)
	flw	f1, 2(r2)
	fsw	f1, 2(r1)
	jr	r31				#
vecdist2.3004:
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
vecunit.3007:
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
vecunit_sgn.3009:
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
	beq	r0, r30, feq_else.17520
	addi	r5, r0, 1
	j	feq_cont.17521
feq_else.17520:
	addi	r5, r0, 0
feq_cont.17521:
	beqi	0, r5, beq_then.17522
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.17523
beq_then.17522:
	beqi	0, r2, beq_then.17524
	flup	f2, 11		# fli	f2, -1.000000
	fdiv	f1, f2, f1
	j	beq_cont.17525
beq_then.17524:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
beq_cont.17525:
beq_cont.17523:
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
veciprod.3012:
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
veciprod2.3015:
	flw	f4, 0(r1)
	fmul	f1, f4, f1
	flw	f4, 1(r1)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	jr	r31				#
vecaccum.3020:
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
vecadd.3024:
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
vecmul.3027:
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
vecscale.3030:
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
vecaccumv.3033:
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
o_texturetype.3037:
	lw	r1, 0(r1)
	jr	r31				#
o_form.3039:
	lw	r1, 1(r1)
	jr	r31				#
o_reflectiontype.3041:
	lw	r1, 2(r1)
	jr	r31				#
o_isinvert.3043:
	lw	r1, 6(r1)
	jr	r31				#
o_isrot.3045:
	lw	r1, 3(r1)
	jr	r31				#
o_param_a.3047:
	lw	r1, 4(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_param_b.3049:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_param_c.3051:
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_param_abc.3053:
	lw	r1, 4(r1)
	jr	r31				#
o_param_x.3055:
	lw	r1, 5(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_param_y.3057:
	lw	r1, 5(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_param_z.3059:
	lw	r1, 5(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_diffuse.3061:
	lw	r1, 7(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_hilight.3063:
	lw	r1, 7(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_color_red.3065:
	lw	r1, 8(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_color_green.3067:
	lw	r1, 8(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_color_blue.3069:
	lw	r1, 8(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_param_r1.3071:
	lw	r1, 9(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_param_r2.3073:
	lw	r1, 9(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_param_r3.3075:
	lw	r1, 9(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_param_ctbl.3077:
	lw	r1, 10(r1)
	jr	r31				#
p_rgb.3079:
	lw	r1, 0(r1)
	jr	r31				#
p_intersection_points.3081:
	lw	r1, 1(r1)
	jr	r31				#
p_surface_ids.3083:
	lw	r1, 2(r1)
	jr	r31				#
p_calc_diffuse.3085:
	lw	r1, 3(r1)
	jr	r31				#
p_energy.3087:
	lw	r1, 4(r1)
	jr	r31				#
p_received_ray_20percent.3089:
	lw	r1, 5(r1)
	jr	r31				#
p_group_id.3091:
	lw	r1, 6(r1)
	lw	r1, 0(r1)
	jr	r31				#
p_set_group_id.3093:
	lw	r1, 6(r1)
	sw	r2, 0(r1)
	jr	r31				#
p_nvectors.3096:
	lw	r1, 7(r1)
	jr	r31				#
d_vec.3098:
	lw	r1, 0(r1)
	jr	r31				#
d_const.3100:
	lw	r1, 1(r1)
	jr	r31				#
r_surface_id.3102:
	lw	r1, 0(r1)
	jr	r31				#
r_dvec.3104:
	lw	r1, 1(r1)
	jr	r31				#
r_bright.3106:
	flw	f1, 2(r1)
	jr	r31				#
rad.3108:
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	jr	r31				#
read_screen_settings.3110:
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
	jal	cos.2924				#	bl	cos.2924
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2922				#	bl	sin.2922
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
	jal	cos.2924				#	bl	cos.2924
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fsw	f1, 12(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin.2922				#	bl	sin.2922
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
read_light.3112:
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
	jal	sin.2922				#	bl	sin.2922
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
	jal	cos.2924				#	bl	cos.2924
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin.2922				#	bl	sin.2922
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 10667
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	flw	f1, 2(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2924				#	bl	cos.2924
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
rotate_quadratic_matrix.3114:
	flw	f1, 0(r2)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	cos.2924				#	bl	cos.2924
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2922				#	bl	sin.2922
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2924				#	bl	cos.2924
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2922				#	bl	sin.2922
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos.2924				#	bl	cos.2924
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 10(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2922				#	bl	sin.2922
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
read_nth_object.3117:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.17537
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
	beq	r0, r30, fle_else.17538
	addi	r1, r0, 0
	j	fle_cont.17539
fle_else.17538:
	addi	r1, r0, 1
fle_cont.17539:
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
	beqi	0, r2, beq_then.17540
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
	j	beq_cont.17541
beq_then.17540:
beq_cont.17541:
	lw	r2, 2(r3)
	beqi	2, r2, beq_then.17542
	lw	r5, 7(r3)
	j	beq_cont.17543
beq_then.17542:
	addi	r5, r0, 1
beq_cont.17543:
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
	beqi	3, r7, beq_then.17544
	beqi	2, r7, beq_then.17546
	j	beq_cont.17547
beq_then.17546:
	lw	r2, 7(r3)
	beqi	0, r2, beq_then.17548
	addi	r2, r0, 0
	j	beq_cont.17549
beq_then.17548:
	addi	r2, r0, 1
beq_cont.17549:
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	vecunit_sgn.3009				#	bl	vecunit_sgn.3009
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.17547:
	j	beq_cont.17545
beq_then.17544:
	flw	f1, 0(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17550
	addi	r2, r0, 1
	j	feq_cont.17551
feq_else.17550:
	addi	r2, r0, 0
feq_cont.17551:
	beqi	0, r2, beq_then.17552
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.17553
beq_then.17552:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17554
	addi	r2, r0, 1
	j	feq_cont.17555
feq_else.17554:
	addi	r2, r0, 0
feq_cont.17555:
	beqi	0, r2, beq_then.17556
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.17557
beq_then.17556:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17558
	addi	r2, r0, 0
	j	fle_cont.17559
fle_else.17558:
	addi	r2, r0, 1
fle_cont.17559:
	beqi	0, r2, beq_then.17560
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.17561
beq_then.17560:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.17561:
beq_cont.17557:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.17553:
	fsw	f1, 0(r5)
	flw	f1, 1(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17562
	addi	r2, r0, 1
	j	feq_cont.17563
feq_else.17562:
	addi	r2, r0, 0
feq_cont.17563:
	beqi	0, r2, beq_then.17564
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.17565
beq_then.17564:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17566
	addi	r2, r0, 1
	j	feq_cont.17567
feq_else.17566:
	addi	r2, r0, 0
feq_cont.17567:
	beqi	0, r2, beq_then.17568
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.17569
beq_then.17568:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17570
	addi	r2, r0, 0
	j	fle_cont.17571
fle_else.17570:
	addi	r2, r0, 1
fle_cont.17571:
	beqi	0, r2, beq_then.17572
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.17573
beq_then.17572:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.17573:
beq_cont.17569:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.17565:
	fsw	f1, 1(r5)
	flw	f1, 2(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17574
	addi	r2, r0, 1
	j	feq_cont.17575
feq_else.17574:
	addi	r2, r0, 0
feq_cont.17575:
	beqi	0, r2, beq_then.17576
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.17577
beq_then.17576:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17578
	addi	r2, r0, 1
	j	feq_cont.17579
feq_else.17578:
	addi	r2, r0, 0
feq_cont.17579:
	beqi	0, r2, beq_then.17580
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.17581
beq_then.17580:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17582
	addi	r2, r0, 0
	j	fle_cont.17583
fle_else.17582:
	addi	r2, r0, 1
fle_cont.17583:
	beqi	0, r2, beq_then.17584
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.17585
beq_then.17584:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.17585:
beq_cont.17581:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.17577:
	fsw	f1, 2(r5)
beq_cont.17545:
	lw	r1, 4(r3)
	beqi	0, r1, beq_then.17586
	lw	r1, 5(r3)
	lw	r2, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	rotate_quadratic_matrix.3114				#	bl	rotate_quadratic_matrix.3114
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.17587
beq_then.17586:
beq_cont.17587:
	addi	r1, r0, 1
	jr	r31				#
beq_then.17537:
	addi	r1, r0, 0
	jr	r31				#
read_object.3119:
	addi	r2, r0, 60
	ble	r2, r1, ble_then.17588
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.3117				#	bl	read_nth_object.3117
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.17589
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.17590
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.3117				#	bl	read_nth_object.3117
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.17591
	lw	r1, 1(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.17592
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_nth_object.3117				#	bl	read_nth_object.3117
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.17593
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.17594
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_nth_object.3117				#	bl	read_nth_object.3117
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.17595
	lw	r1, 3(r3)
	addi	r1, r1, 1
	j	read_object.3119
beq_then.17595:
	addi	r1, r0, 10000
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.17594:
	jr	r31				#
beq_then.17593:
	addi	r1, r0, 10000
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.17592:
	jr	r31				#
beq_then.17591:
	addi	r1, r0, 10000
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.17590:
	jr	r31				#
beq_then.17589:
	addi	r1, r0, 10000
	lw	r2, 0(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.17588:
	jr	r31				#
read_all_object.3121:
	addi	r1, r0, 0
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.3117				#	bl	read_nth_object.3117
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.17604
	addi	r1, r0, 1
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.3117				#	bl	read_nth_object.3117
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.17605
	addi	r1, r0, 2
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_nth_object.3117				#	bl	read_nth_object.3117
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.17606
	addi	r1, r0, 3
	j	read_object.3119
beq_then.17606:
	addi	r1, r0, 10000
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	jr	r31				#
beq_then.17605:
	addi	r1, r0, 10000
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	jr	r31				#
beq_then.17604:
	addi	r1, r0, 10000
	lw	r2, 0(r3)
	sw	r2, 0(r1)
	jr	r31				#
read_net_item.3123:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.17610
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.17611
	lw	r2, 2(r3)
	addi	r5, r2, 1
	sw	r1, 3(r3)
	sw	r5, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.17613
	lw	r2, 4(r3)
	addi	r5, r2, 1
	sw	r1, 5(r3)
	sw	r5, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.17615
	lw	r2, 6(r3)
	addi	r5, r2, 1
	sw	r1, 7(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.3123				#	bl	read_net_item.3123
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.17616
beq_then.17615:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.17616:
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.17614
beq_then.17613:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.17614:
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.17612
beq_then.17611:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.17612:
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.17610:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	j	lib_create_array
read_or_network.3125:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.17617
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.17619
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.17621
	addi	r2, r0, 3
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3123				#	bl	read_net_item.3123
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 2(r1)
	j	beq_cont.17622
beq_then.17621:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.17622:
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.17620
beq_then.17619:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.17620:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.17618
beq_then.17617:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.17618:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.17623
	lw	r1, 0(r3)
	addi	r5, r1, 1
	sw	r2, 4(r3)
	sw	r5, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.17624
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	-1, r1, beq_then.17626
	addi	r2, r0, 2
	sw	r1, 7(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_net_item.3123				#	bl	read_net_item.3123
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 7(r3)
	sw	r2, 1(r1)
	j	beq_cont.17627
beq_then.17626:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.17627:
	lw	r2, 6(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.17625
beq_then.17624:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.17625:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.17628
	lw	r1, 5(r3)
	addi	r5, r1, 1
	sw	r2, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	read_or_network.3125				#	bl	read_or_network.3125
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r2, 5(r3)
	lw	r5, 8(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.17629
beq_then.17628:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.17629:
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.17623:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.3127:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.17630
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.17632
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.17634
	addi	r2, r0, 3
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3123				#	bl	read_net_item.3123
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 2(r1)
	j	beq_cont.17635
beq_then.17634:
	addi	r1, r0, 3
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.17635:
	lw	r2, 2(r3)
	sw	r2, 1(r1)
	j	beq_cont.17633
beq_then.17632:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.17633:
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	j	beq_cont.17631
beq_then.17630:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.17631:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.17636
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
	beqi	-1, r1, beq_then.17637
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.17639
	addi	r2, r0, 2
	sw	r1, 6(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	read_net_item.3123				#	bl	read_net_item.3123
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	sw	r2, 1(r1)
	j	beq_cont.17640
beq_then.17639:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.17640:
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	j	beq_cont.17638
beq_then.17637:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.17638:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.17641
	addi	r2, r0, 10672
	lw	r5, 4(r3)
	add	r30, r2, r5
	sw	r1, 0(r30)
	addi	r1, r5, 1
	j	read_and_network.3127
beq_then.17641:
	jr	r31				#
beq_then.17636:
	jr	r31				#
read_parameter.3129:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_screen_settings.3110				#	bl	read_screen_settings.3110
	addi	r3, r3, -1
	lw	r31, 0(r3)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_light.3112				#	bl	read_light.3112
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.3117				#	bl	read_nth_object.3117
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.17644
	addi	r1, r0, 1
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.3117				#	bl	read_nth_object.3117
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.17646
	addi	r1, r0, 2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_object.3119				#	bl	read_object.3119
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.17647
beq_then.17646:
	addi	r1, r0, 10000
	lw	r2, 1(r3)
	sw	r2, 0(r1)
beq_cont.17647:
	j	beq_cont.17645
beq_then.17644:
	addi	r1, r0, 10000
	lw	r2, 0(r3)
	sw	r2, 0(r1)
beq_cont.17645:
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	-1, r1, beq_then.17648
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.17650
	addi	r2, r0, 2
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3123				#	bl	read_net_item.3123
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	sw	r2, 1(r1)
	j	beq_cont.17651
beq_then.17650:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.17651:
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	j	beq_cont.17649
beq_then.17648:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.17649:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.17652
	addi	r2, r0, 10672
	sw	r1, 0(r2)
	addi	r1, r0, 1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_and_network.3127				#	bl	read_and_network.3127
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.17653
beq_then.17652:
beq_cont.17653:
	addi	r1, r0, 10723
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	-1, r1, beq_then.17654
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	-1, r1, beq_then.17656
	addi	r2, r0, 2
	sw	r1, 6(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	read_net_item.3123				#	bl	read_net_item.3123
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	sw	r2, 1(r1)
	j	beq_cont.17657
beq_then.17656:
	addi	r1, r0, 2
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.17657:
	lw	r2, 5(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.17655
beq_then.17654:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.17655:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.17658
	addi	r1, r0, 1
	sw	r2, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	read_or_network.3125				#	bl	read_or_network.3125
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 7(r3)
	sw	r2, 0(r1)
	j	beq_cont.17659
beq_then.17658:
	addi	r1, r0, 1
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.17659:
	lw	r2, 4(r3)
	sw	r1, 0(r2)
	jr	r31				#
solver_rect_surface.3131:
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.17661
	addi	r8, r0, 1
	j	feq_cont.17662
feq_else.17661:
	addi	r8, r0, 0
feq_cont.17662:
	beqi	0, r8, beq_then.17663
	addi	r1, r0, 0
	jr	r31				#
beq_then.17663:
	lw	r8, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.17664
	addi	r9, r0, 0
	j	fle_cont.17665
fle_else.17664:
	addi	r9, r0, 1
fle_cont.17665:
	beqi	0, r1, beq_then.17666
	beqi	0, r9, beq_then.17668
	addi	r1, r0, 0
	j	beq_cont.17669
beq_then.17668:
	addi	r1, r0, 1
beq_cont.17669:
	j	beq_cont.17667
beq_then.17666:
	add	r1, r0, r9
beq_cont.17667:
	add	r30, r8, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.17670
	j	beq_cont.17671
beq_then.17670:
	fneg	f4, f4
beq_cont.17671:
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
	beq	r0, r30, fle_else.17672
	j	fle_cont.17673
fle_else.17672:
	fneg	f2, f2
fle_cont.17673:
	fle	r30, f4, f2
	beq	r0, r30, fle_else.17674
	addi	r1, r0, 0
	jr	r31				#
fle_else.17674:
	add	r30, r8, r7
	flw	f2, 0(r30)
	add	r30, r2, r7
	flw	f4, 0(r30)
	fmul	f4, f1, f4
	fadd	f3, f4, f3
	fle	r30, f0, f3
	beq	r0, r30, fle_else.17675
	j	fle_cont.17676
fle_else.17675:
	fneg	f3, f3
fle_cont.17676:
	fle	r30, f2, f3
	beq	r0, r30, fle_else.17677
	addi	r1, r0, 0
	jr	r31				#
fle_else.17677:
	addi	r1, r0, 10724
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
solver_rect.3140:
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
	jal	solver_rect_surface.3131				#	bl	solver_rect_surface.3131
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.17678
	addi	r1, r0, 1
	jr	r31				#
beq_then.17678:
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
	jal	solver_rect_surface.3131				#	bl	solver_rect_surface.3131
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.17679
	addi	r1, r0, 2
	jr	r31				#
beq_then.17679:
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
	jal	solver_rect_surface.3131				#	bl	solver_rect_surface.3131
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.17680
	addi	r1, r0, 3
	jr	r31				#
beq_then.17680:
	addi	r1, r0, 0
	jr	r31				#
solver_surface.3146:
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
	beq	r0, r30, fle_else.17681
	addi	r2, r0, 0
	j	fle_cont.17682
fle_else.17681:
	addi	r2, r0, 1
fle_cont.17682:
	beqi	0, r2, beq_then.17683
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
beq_then.17683:
	addi	r1, r0, 0
	jr	r31				#
quadratic.3152:
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
	beqi	0, r2, beq_then.17684
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
beq_then.17684:
	fadd	f1, f0, f4
	jr	r31				#
bilinear.3157:
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
	beqi	0, r2, beq_then.17685
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
beq_then.17685:
	fadd	f1, f0, f7
	jr	r31				#
solver_second.3165:
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
	jal	quadratic.3152				#	bl	quadratic.3152
	addi	r3, r3, -9
	lw	r31, 8(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17686
	addi	r1, r0, 1
	j	feq_cont.17687
feq_else.17686:
	addi	r1, r0, 0
feq_cont.17687:
	beqi	0, r1, beq_then.17688
	addi	r1, r0, 0
	jr	r31				#
beq_then.17688:
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
	jal	bilinear.3157				#	bl	bilinear.3157
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
	jal	quadratic.3152				#	bl	quadratic.3152
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.17689
	j	beq_cont.17690
beq_then.17689:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.17690:
	flw	f2, 10(r3)
	fmul	f3, f2, f2
	flw	f4, 8(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17691
	addi	r2, r0, 0
	j	fle_cont.17692
fle_else.17691:
	addi	r2, r0, 1
fle_cont.17692:
	beqi	0, r2, beq_then.17693
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.17694
	j	beq_cont.17695
beq_then.17694:
	fneg	f1, f1
beq_cont.17695:
	addi	r1, r0, 10724
	fsub	f1, f1, f2
	fdiv	f1, f1, f4
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.17693:
	addi	r1, r0, 0
	jr	r31				#
solver.3171:
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
	beqi	1, r5, beq_then.17696
	beqi	2, r5, beq_then.17697
	j	solver_second.3165
beq_then.17697:
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
	beq	r0, r30, fle_else.17698
	addi	r2, r0, 0
	j	fle_cont.17699
fle_else.17698:
	addi	r2, r0, 1
fle_cont.17699:
	beqi	0, r2, beq_then.17700
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
beq_then.17700:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17696:
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
	jal	solver_rect_surface.3131				#	bl	solver_rect_surface.3131
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.17701
	addi	r1, r0, 1
	jr	r31				#
beq_then.17701:
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
	jal	solver_rect_surface.3131				#	bl	solver_rect_surface.3131
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.17702
	addi	r1, r0, 2
	jr	r31				#
beq_then.17702:
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
	jal	solver_rect_surface.3131				#	bl	solver_rect_surface.3131
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.17703
	addi	r1, r0, 3
	jr	r31				#
beq_then.17703:
	addi	r1, r0, 0
	jr	r31				#
solver_rect_fast.3175:
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
	beq	r0, r30, fle_else.17704
	j	fle_cont.17705
fle_else.17704:
	fneg	f6, f6
fle_cont.17705:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.17706
	addi	r6, r0, 0
	j	fle_cont.17707
fle_else.17706:
	lw	r6, 4(r1)
	flw	f5, 2(r6)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.17708
	j	fle_cont.17709
fle_else.17708:
	fneg	f6, f6
fle_cont.17709:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.17710
	addi	r6, r0, 0
	j	fle_cont.17711
fle_else.17710:
	flw	f5, 1(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.17712
	addi	r6, r0, 1
	j	feq_cont.17713
feq_else.17712:
	addi	r6, r0, 0
feq_cont.17713:
	beqi	0, r6, beq_then.17714
	addi	r6, r0, 0
	j	beq_cont.17715
beq_then.17714:
	addi	r6, r0, 1
beq_cont.17715:
fle_cont.17711:
fle_cont.17707:
	beqi	0, r6, beq_then.17716
	addi	r1, r0, 10724
	fsw	f4, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.17716:
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
	beq	r0, r30, fle_else.17717
	j	fle_cont.17718
fle_else.17717:
	fneg	f6, f6
fle_cont.17718:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.17719
	addi	r6, r0, 0
	j	fle_cont.17720
fle_else.17719:
	lw	r6, 4(r1)
	flw	f5, 2(r6)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.17721
	j	fle_cont.17722
fle_else.17721:
	fneg	f6, f6
fle_cont.17722:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.17723
	addi	r6, r0, 0
	j	fle_cont.17724
fle_else.17723:
	flw	f5, 3(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.17725
	addi	r6, r0, 1
	j	feq_cont.17726
feq_else.17725:
	addi	r6, r0, 0
feq_cont.17726:
	beqi	0, r6, beq_then.17727
	addi	r6, r0, 0
	j	beq_cont.17728
beq_then.17727:
	addi	r6, r0, 1
beq_cont.17728:
fle_cont.17724:
fle_cont.17720:
	beqi	0, r6, beq_then.17729
	addi	r1, r0, 10724
	fsw	f4, 0(r1)
	addi	r1, r0, 2
	jr	r31				#
beq_then.17729:
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
	beq	r0, r30, fle_else.17730
	j	fle_cont.17731
fle_else.17730:
	fneg	f1, f1
fle_cont.17731:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17732
	addi	r1, r0, 0
	j	fle_cont.17733
fle_else.17732:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	flw	f4, 1(r2)
	fmul	f4, f3, f4
	fadd	f2, f4, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.17734
	j	fle_cont.17735
fle_else.17734:
	fneg	f2, f2
fle_cont.17735:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17736
	addi	r1, r0, 0
	j	fle_cont.17737
fle_else.17736:
	flw	f1, 5(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17738
	addi	r1, r0, 1
	j	feq_cont.17739
feq_else.17738:
	addi	r1, r0, 0
feq_cont.17739:
	beqi	0, r1, beq_then.17740
	addi	r1, r0, 0
	j	beq_cont.17741
beq_then.17740:
	addi	r1, r0, 1
beq_cont.17741:
fle_cont.17737:
fle_cont.17733:
	beqi	0, r1, beq_then.17742
	addi	r1, r0, 10724
	fsw	f3, 0(r1)
	addi	r1, r0, 3
	jr	r31				#
beq_then.17742:
	addi	r1, r0, 0
	jr	r31				#
solver_surface_fast.3182:
	flw	f4, 0(r2)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.17743
	addi	r1, r0, 0
	j	fle_cont.17744
fle_else.17743:
	addi	r1, r0, 1
fle_cont.17744:
	beqi	0, r1, beq_then.17745
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
beq_then.17745:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3188:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.17746
	addi	r5, r0, 1
	j	feq_cont.17747
feq_else.17746:
	addi	r5, r0, 0
feq_cont.17747:
	beqi	0, r5, beq_then.17748
	addi	r1, r0, 0
	jr	r31				#
beq_then.17748:
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
	jal	quadratic.3152				#	bl	quadratic.3152
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.17750
	j	beq_cont.17751
beq_then.17750:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.17751:
	flw	f2, 4(r3)
	fmul	f3, f2, f2
	flw	f4, 2(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.17752
	addi	r2, r0, 0
	j	fle_cont.17753
fle_else.17752:
	addi	r2, r0, 1
fle_cont.17753:
	beqi	0, r2, beq_then.17754
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.17755
	addi	r1, r0, 10724
	fsqrt	f1, f1
	fadd	f1, f2, f1
	lw	r2, 0(r3)
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	j	beq_cont.17756
beq_then.17755:
	addi	r1, r0, 10724
	fsqrt	f1, f1
	fsub	f1, f2, f1
	lw	r2, 0(r3)
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
beq_cont.17756:
	addi	r1, r0, 1
	jr	r31				#
beq_then.17754:
	addi	r1, r0, 0
	jr	r31				#
solver_fast.3194:
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
	beqi	1, r1, beq_then.17757
	beqi	2, r1, beq_then.17758
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	j	solver_second_fast.3188
beq_then.17758:
	flw	f4, 0(r5)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.17759
	addi	r1, r0, 0
	j	fle_cont.17760
fle_else.17759:
	addi	r1, r0, 1
fle_cont.17760:
	beqi	0, r1, beq_then.17761
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
beq_then.17761:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17757:
	lw	r2, 0(r2)
	add	r1, r0, r6				# mr	r1, r6
	j	solver_rect_fast.3175
solver_surface_fast2.3198:
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17762
	addi	r1, r0, 0
	j	fle_cont.17763
fle_else.17762:
	addi	r1, r0, 1
fle_cont.17763:
	beqi	0, r1, beq_then.17764
	addi	r1, r0, 10724
	flw	f1, 0(r2)
	flw	f2, 3(r5)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.17764:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3205:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.17765
	addi	r6, r0, 1
	j	feq_cont.17766
feq_else.17765:
	addi	r6, r0, 0
feq_cont.17766:
	beqi	0, r6, beq_then.17767
	addi	r1, r0, 0
	jr	r31				#
beq_then.17767:
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
	beq	r0, r30, fle_else.17768
	addi	r5, r0, 0
	j	fle_cont.17769
fle_else.17768:
	addi	r5, r0, 1
fle_cont.17769:
	beqi	0, r5, beq_then.17770
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.17771
	addi	r1, r0, 10724
	fsqrt	f2, f2
	fadd	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	j	beq_cont.17772
beq_then.17771:
	addi	r1, r0, 10724
	fsqrt	f2, f2
	fsub	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
beq_cont.17772:
	addi	r1, r0, 1
	jr	r31				#
beq_then.17770:
	addi	r1, r0, 0
	jr	r31				#
solver_fast2.3212:
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
	beqi	1, r7, beq_then.17773
	beqi	2, r7, beq_then.17774
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	j	solver_second_fast2.3205
beq_then.17774:
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17775
	addi	r2, r0, 0
	j	fle_cont.17776
fle_else.17775:
	addi	r2, r0, 1
fle_cont.17776:
	beqi	0, r2, beq_then.17777
	addi	r2, r0, 10724
	flw	f1, 0(r1)
	flw	f2, 3(r6)
	fmul	f1, f1, f2
	fsw	f1, 0(r2)
	addi	r1, r0, 1
	jr	r31				#
beq_then.17777:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17773:
	lw	r2, 0(r2)
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r1				# mr	r5, r1
	add	r1, r0, r28				# mr	r1, r28
	j	solver_rect_fast.3175
setup_rect_table.3215:
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
	beq	r0, r30, feq_else.17778
	addi	r5, r0, 1
	j	feq_cont.17779
feq_else.17778:
	addi	r5, r0, 0
feq_cont.17779:
	beqi	0, r5, beq_then.17780
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 1(r1)
	j	beq_cont.17781
beq_then.17780:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17782
	addi	r7, r0, 0
	j	fle_cont.17783
fle_else.17782:
	addi	r7, r0, 1
fle_cont.17783:
	beqi	0, r6, beq_then.17784
	beqi	0, r7, beq_then.17786
	addi	r6, r0, 0
	j	beq_cont.17787
beq_then.17786:
	addi	r6, r0, 1
beq_cont.17787:
	j	beq_cont.17785
beq_then.17784:
	add	r6, r0, r7
beq_cont.17785:
	lw	r7, 4(r5)
	flw	f1, 0(r7)
	beqi	0, r6, beq_then.17788
	j	beq_cont.17789
beq_then.17788:
	fneg	f1, f1
beq_cont.17789:
	fsw	f1, 0(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r2)
	fdiv	f1, f1, f2
	fsw	f1, 1(r1)
beq_cont.17781:
	flw	f1, 1(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17790
	addi	r5, r0, 1
	j	feq_cont.17791
feq_else.17790:
	addi	r5, r0, 0
feq_cont.17791:
	beqi	0, r5, beq_then.17792
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 3(r1)
	j	beq_cont.17793
beq_then.17792:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 1(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17794
	addi	r7, r0, 0
	j	fle_cont.17795
fle_else.17794:
	addi	r7, r0, 1
fle_cont.17795:
	beqi	0, r6, beq_then.17796
	beqi	0, r7, beq_then.17798
	addi	r6, r0, 0
	j	beq_cont.17799
beq_then.17798:
	addi	r6, r0, 1
beq_cont.17799:
	j	beq_cont.17797
beq_then.17796:
	add	r6, r0, r7
beq_cont.17797:
	lw	r7, 4(r5)
	flw	f1, 1(r7)
	beqi	0, r6, beq_then.17800
	j	beq_cont.17801
beq_then.17800:
	fneg	f1, f1
beq_cont.17801:
	fsw	f1, 2(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 1(r2)
	fdiv	f1, f1, f2
	fsw	f1, 3(r1)
beq_cont.17793:
	flw	f1, 2(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17802
	addi	r5, r0, 1
	j	feq_cont.17803
feq_else.17802:
	addi	r5, r0, 0
feq_cont.17803:
	beqi	0, r5, beq_then.17804
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 5(r1)
	j	beq_cont.17805
beq_then.17804:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 2(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17806
	addi	r7, r0, 0
	j	fle_cont.17807
fle_else.17806:
	addi	r7, r0, 1
fle_cont.17807:
	beqi	0, r6, beq_then.17808
	beqi	0, r7, beq_then.17810
	addi	r6, r0, 0
	j	beq_cont.17811
beq_then.17810:
	addi	r6, r0, 1
beq_cont.17811:
	j	beq_cont.17809
beq_then.17808:
	add	r6, r0, r7
beq_cont.17809:
	lw	r5, 4(r5)
	flw	f1, 2(r5)
	beqi	0, r6, beq_then.17812
	j	beq_cont.17813
beq_then.17812:
	fneg	f1, f1
beq_cont.17813:
	fsw	f1, 4(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 2(r2)
	fdiv	f1, f1, f2
	fsw	f1, 5(r1)
beq_cont.17805:
	jr	r31				#
setup_surface_table.3218:
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
	beq	r0, r30, fle_else.17814
	addi	r2, r0, 0
	j	fle_cont.17815
fle_else.17814:
	addi	r2, r0, 1
fle_cont.17815:
	beqi	0, r2, beq_then.17816
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
	j	beq_cont.17817
beq_then.17816:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
beq_cont.17817:
	jr	r31				#
setup_second_table.3221:
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
	jal	quadratic.3152				#	bl	quadratic.3152
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
	beqi	0, r6, beq_then.17818
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
	j	beq_cont.17819
beq_then.17818:
	fsw	f2, 1(r5)
	fsw	f3, 2(r5)
	fsw	f4, 3(r5)
beq_cont.17819:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.17820
	addi	r1, r0, 1
	j	feq_cont.17821
feq_else.17820:
	addi	r1, r0, 0
feq_cont.17821:
	beqi	0, r1, beq_then.17822
	j	beq_cont.17823
beq_then.17822:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
	fsw	f1, 4(r5)
beq_cont.17823:
	add	r1, r0, r5
	jr	r31				#
iter_setup_dirvec_constants.3224:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.17824
	jr	r31				#
ble_then.17824:
	addi	r5, r0, 10001
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 1(r1)
	lw	r7, 0(r1)
	lw	r8, 1(r5)
	sw	r1, 0(r3)
	beqi	1, r8, beq_then.17826
	beqi	2, r8, beq_then.17828
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17829
beq_then.17828:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17829:
	j	beq_cont.17827
beq_then.17826:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17827:
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.17830
	jr	r31				#
ble_then.17830:
	addi	r2, r0, 10001
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 0(r3)
	lw	r6, 1(r5)
	lw	r7, 0(r5)
	lw	r8, 1(r2)
	beqi	1, r8, beq_then.17832
	beqi	2, r8, beq_then.17834
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17835
beq_then.17834:
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17835:
	j	beq_cont.17833
beq_then.17832:
	sw	r1, 3(r3)
	sw	r6, 4(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17833:
	addi	r2, r2, -1
	lw	r1, 0(r3)
	j	iter_setup_dirvec_constants.3224
setup_dirvec_constants.3227:
	addi	r2, r0, 10000
	lw	r2, 0(r2)
	addi	r2, r2, -1
	addi	r5, r0, 0
	ble	r5, r2, ble_then.17836
	jr	r31				#
ble_then.17836:
	addi	r5, r0, 10001
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 1(r1)
	lw	r7, 0(r1)
	lw	r8, 1(r5)
	sw	r1, 0(r3)
	beqi	1, r8, beq_then.17838
	beqi	2, r8, beq_then.17840
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.17841
beq_then.17840:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17841:
	j	beq_cont.17839
beq_then.17838:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.17839:
	addi	r2, r2, -1
	lw	r1, 0(r3)
	j	iter_setup_dirvec_constants.3224
setup_startp_constants.3229:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.17842
	jr	r31				#
ble_then.17842:
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
	beqi	2, r7, beq_then.17844
	blei	2, r7, ble_then.17846
	flw	f1, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 2(r6)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	quadratic.3152				#	bl	quadratic.3152
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	beqi	3, r1, beq_then.17848
	j	beq_cont.17849
beq_then.17848:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.17849:
	lw	r1, 2(r3)
	fsw	f1, 3(r1)
	j	ble_cont.17847
ble_then.17846:
ble_cont.17847:
	j	beq_cont.17845
beq_then.17844:
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
beq_cont.17845:
	lw	r1, 1(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	j	setup_startp_constants.3229
setup_startp.3232:
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
	j	setup_startp_constants.3229
is_rect_outside.3234:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17850
	j	fle_cont.17851
fle_else.17850:
	fneg	f1, f1
fle_cont.17851:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17852
	addi	r2, r0, 0
	j	fle_cont.17853
fle_else.17852:
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.17854
	j	fle_cont.17855
fle_else.17854:
	fneg	f2, f2
fle_cont.17855:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17856
	addi	r2, r0, 0
	j	fle_cont.17857
fle_else.17856:
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.17858
	fadd	f2, f0, f3
	j	fle_cont.17859
fle_else.17858:
	fneg	f2, f3
fle_cont.17859:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17860
	addi	r2, r0, 0
	j	fle_cont.17861
fle_else.17860:
	addi	r2, r0, 1
fle_cont.17861:
fle_cont.17857:
fle_cont.17853:
	beqi	0, r2, beq_then.17862
	lw	r1, 6(r1)
	jr	r31				#
beq_then.17862:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.17863
	addi	r1, r0, 0
	jr	r31				#
beq_then.17863:
	addi	r1, r0, 1
	jr	r31				#
is_plane_outside.3239:
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
	beq	r0, r30, fle_else.17864
	addi	r2, r0, 0
	j	fle_cont.17865
fle_else.17864:
	addi	r2, r0, 1
fle_cont.17865:
	beqi	0, r1, beq_then.17866
	beqi	0, r2, beq_then.17868
	addi	r1, r0, 0
	j	beq_cont.17869
beq_then.17868:
	addi	r1, r0, 1
beq_cont.17869:
	j	beq_cont.17867
beq_then.17866:
	add	r1, r0, r2
beq_cont.17867:
	beqi	0, r1, beq_then.17870
	addi	r1, r0, 0
	jr	r31				#
beq_then.17870:
	addi	r1, r0, 1
	jr	r31				#
is_second_outside.3244:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3152				#	bl	quadratic.3152
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.17871
	j	beq_cont.17872
beq_then.17871:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.17872:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17873
	addi	r2, r0, 0
	j	fle_cont.17874
fle_else.17873:
	addi	r2, r0, 1
fle_cont.17874:
	beqi	0, r1, beq_then.17875
	beqi	0, r2, beq_then.17877
	addi	r1, r0, 0
	j	beq_cont.17878
beq_then.17877:
	addi	r1, r0, 1
beq_cont.17878:
	j	beq_cont.17876
beq_then.17875:
	add	r1, r0, r2
beq_cont.17876:
	beqi	0, r1, beq_then.17879
	addi	r1, r0, 0
	jr	r31				#
beq_then.17879:
	addi	r1, r0, 1
	jr	r31				#
is_outside.3249:
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
	beqi	1, r2, beq_then.17880
	beqi	2, r2, beq_then.17881
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3152				#	bl	quadratic.3152
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.17882
	j	beq_cont.17883
beq_then.17882:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.17883:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17884
	addi	r2, r0, 0
	j	fle_cont.17885
fle_else.17884:
	addi	r2, r0, 1
fle_cont.17885:
	beqi	0, r1, beq_then.17886
	beqi	0, r2, beq_then.17888
	addi	r1, r0, 0
	j	beq_cont.17889
beq_then.17888:
	addi	r1, r0, 1
beq_cont.17889:
	j	beq_cont.17887
beq_then.17886:
	add	r1, r0, r2
beq_cont.17887:
	beqi	0, r1, beq_then.17890
	addi	r1, r0, 0
	jr	r31				#
beq_then.17890:
	addi	r1, r0, 1
	jr	r31				#
beq_then.17881:
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
	beq	r0, r30, fle_else.17891
	addi	r2, r0, 0
	j	fle_cont.17892
fle_else.17891:
	addi	r2, r0, 1
fle_cont.17892:
	beqi	0, r1, beq_then.17893
	beqi	0, r2, beq_then.17895
	addi	r1, r0, 0
	j	beq_cont.17896
beq_then.17895:
	addi	r1, r0, 1
beq_cont.17896:
	j	beq_cont.17894
beq_then.17893:
	add	r1, r0, r2
beq_cont.17894:
	beqi	0, r1, beq_then.17897
	addi	r1, r0, 0
	jr	r31				#
beq_then.17897:
	addi	r1, r0, 1
	jr	r31				#
beq_then.17880:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17898
	j	fle_cont.17899
fle_else.17898:
	fneg	f1, f1
fle_cont.17899:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.17900
	addi	r2, r0, 0
	j	fle_cont.17901
fle_else.17900:
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.17902
	j	fle_cont.17903
fle_else.17902:
	fneg	f2, f2
fle_cont.17903:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17904
	addi	r2, r0, 0
	j	fle_cont.17905
fle_else.17904:
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.17906
	fadd	f2, f0, f3
	j	fle_cont.17907
fle_else.17906:
	fneg	f2, f3
fle_cont.17907:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17908
	addi	r2, r0, 0
	j	fle_cont.17909
fle_else.17908:
	addi	r2, r0, 1
fle_cont.17909:
fle_cont.17905:
fle_cont.17901:
	beqi	0, r2, beq_then.17910
	lw	r1, 6(r1)
	jr	r31				#
beq_then.17910:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.17911
	addi	r1, r0, 0
	jr	r31				#
beq_then.17911:
	addi	r1, r0, 1
	jr	r31				#
check_all_inside.3254:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.17912
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
	beqi	1, r6, beq_then.17913
	beqi	2, r6, beq_then.17915
	sw	r5, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	quadratic.3152				#	bl	quadratic.3152
	addi	r3, r3, -10
	lw	r31, 9(r3)
	lw	r1, 8(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.17917
	j	beq_cont.17918
beq_then.17917:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.17918:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.17919
	addi	r2, r0, 0
	j	fle_cont.17920
fle_else.17919:
	addi	r2, r0, 1
fle_cont.17920:
	beqi	0, r1, beq_then.17921
	beqi	0, r2, beq_then.17923
	addi	r1, r0, 0
	j	beq_cont.17924
beq_then.17923:
	addi	r1, r0, 1
beq_cont.17924:
	j	beq_cont.17922
beq_then.17921:
	add	r1, r0, r2
beq_cont.17922:
	beqi	0, r1, beq_then.17925
	addi	r1, r0, 0
	j	beq_cont.17926
beq_then.17925:
	addi	r1, r0, 1
beq_cont.17926:
	j	beq_cont.17916
beq_then.17915:
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
	beq	r0, r30, fle_else.17927
	addi	r6, r0, 0
	j	fle_cont.17928
fle_else.17927:
	addi	r6, r0, 1
fle_cont.17928:
	beqi	0, r5, beq_then.17929
	beqi	0, r6, beq_then.17931
	addi	r5, r0, 0
	j	beq_cont.17932
beq_then.17931:
	addi	r5, r0, 1
beq_cont.17932:
	j	beq_cont.17930
beq_then.17929:
	add	r5, r0, r6
beq_cont.17930:
	beqi	0, r5, beq_then.17933
	addi	r1, r0, 0
	j	beq_cont.17934
beq_then.17933:
	addi	r1, r0, 1
beq_cont.17934:
beq_cont.17916:
	j	beq_cont.17914
beq_then.17913:
	add	r1, r0, r5				# mr	r1, r5
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	is_rect_outside.3234				#	bl	is_rect_outside.3234
	addi	r3, r3, -10
	lw	r31, 9(r3)
beq_cont.17914:
	beqi	0, r1, beq_then.17935
	addi	r1, r0, 0
	jr	r31				#
beq_then.17935:
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 6(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.17936
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
	jal	is_outside.3249				#	bl	is_outside.3249
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.17937
	addi	r1, r0, 0
	jr	r31				#
beq_then.17937:
	lw	r1, 9(r3)
	addi	r1, r1, 1
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r2, 6(r3)
	j	check_all_inside.3254
beq_then.17936:
	addi	r1, r0, 1
	jr	r31				#
beq_then.17912:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3260:
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.17938
	add	r30, r2, r1
	lw	r7, 0(r30)
	addi	r8, r0, 10727
	addi	r9, r0, 10001
	add	r30, r9, r7
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
	add	r30, r6, r7
	lw	r6, 0(r30)
	lw	r8, 1(r9)
	sw	r2, 0(r3)
	sw	r29, 1(r3)
	sw	r1, 2(r3)
	sw	r7, 3(r3)
	beqi	1, r8, beq_then.17939
	beqi	2, r8, beq_then.17941
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second_fast.3188				#	bl	solver_second_fast.3188
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.17942
beq_then.17941:
	flw	f4, 0(r6)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.17943
	addi	r5, r0, 0
	j	fle_cont.17944
fle_else.17943:
	addi	r5, r0, 1
fle_cont.17944:
	beqi	0, r5, beq_then.17945
	addi	r5, r0, 10724
	flw	f4, 1(r6)
	fmul	f1, f4, f1
	flw	f4, 2(r6)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 3(r6)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 0(r5)
	addi	r1, r0, 1
	j	beq_cont.17946
beq_then.17945:
	addi	r1, r0, 0
beq_cont.17946:
beq_cont.17942:
	j	beq_cont.17940
beq_then.17939:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r9				# mr	r1, r9
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_rect_fast.3175				#	bl	solver_rect_fast.3175
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.17940:
	addi	r2, r0, 10724
	flw	f1, 0(r2)
	beqi	0, r1, beq_then.17947
	flup	f2, 28		# fli	f2, -0.200000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.17949
	addi	r1, r0, 0
	j	fle_cont.17950
fle_else.17949:
	addi	r1, r0, 1
fle_cont.17950:
	j	beq_cont.17948
beq_then.17947:
	addi	r1, r0, 0
beq_cont.17948:
	beqi	0, r1, beq_then.17951
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
	beqi	-1, r1, beq_then.17952
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
	jal	is_outside.3249				#	bl	is_outside.3249
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.17954
	addi	r1, r0, 0
	j	beq_cont.17955
beq_then.17954:
	addi	r1, r0, 1
	flw	f1, 8(r3)
	flw	f2, 6(r3)
	flw	f3, 4(r3)
	lw	r2, 0(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	check_all_inside.3254				#	bl	check_all_inside.3254
	addi	r3, r3, -11
	lw	r31, 10(r3)
beq_cont.17955:
	j	beq_cont.17953
beq_then.17952:
	addi	r1, r0, 1
beq_cont.17953:
	beqi	0, r1, beq_then.17956
	addi	r1, r0, 1
	jr	r31				#
beq_then.17956:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.17951:
	addi	r1, r0, 10001
	lw	r2, 3(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.17957
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.17957:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17938:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3263:
	lw	r5, 1(r29)
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.17958
	addi	r7, r0, 10672
	add	r30, r7, r6
	lw	r6, 0(r30)
	addi	r7, r0, 0
	sw	r29, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r7				# mr	r1, r7
	add	r29, r0, r5				# mr	r29, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.17959
	addi	r1, r0, 1
	jr	r31				#
beq_then.17959:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.17960
	addi	r6, r0, 10672
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r29, 1(r3)
	sw	r1, 4(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.17961
	addi	r1, r0, 1
	jr	r31				#
beq_then.17961:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.17962
	addi	r6, r0, 10672
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r29, 1(r3)
	sw	r1, 5(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.17963
	addi	r1, r0, 1
	jr	r31				#
beq_then.17963:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.17964
	addi	r6, r0, 10672
	add	r30, r6, r5
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r29, 1(r3)
	sw	r1, 6(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	beqi	0, r1, beq_then.17965
	addi	r1, r0, 1
	jr	r31				#
beq_then.17965:
	lw	r1, 6(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.17964:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17962:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17960:
	addi	r1, r0, 0
	jr	r31				#
beq_then.17958:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3266:
	lw	r5, 4(r29)
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	add	r30, r2, r1
	lw	r9, 0(r30)
	lw	r10, 0(r9)
	beqi	-1, r10, beq_then.17966
	addi	r11, r0, 99
	sw	r6, 0(r3)
	sw	r7, 1(r3)
	sw	r9, 2(r3)
	sw	r2, 3(r3)
	sw	r29, 4(r3)
	sw	r1, 5(r3)
	beq	r10, r11, beq_then.17967
	addi	r11, r0, 10727
	addi	r12, r0, 10001
	add	r30, r12, r10
	lw	r12, 0(r30)
	flw	f1, 0(r11)
	lw	r13, 5(r12)
	flw	f2, 0(r13)
	fsub	f1, f1, f2
	flw	f2, 1(r11)
	lw	r13, 5(r12)
	flw	f3, 1(r13)
	fsub	f2, f2, f3
	flw	f3, 2(r11)
	lw	r11, 5(r12)
	flw	f4, 2(r11)
	fsub	f3, f3, f4
	add	r30, r8, r10
	lw	r8, 0(r30)
	lw	r10, 1(r12)
	beqi	1, r10, beq_then.17969
	beqi	2, r10, beq_then.17971
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r12				# mr	r1, r12
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solver_second_fast.3188				#	bl	solver_second_fast.3188
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.17972
beq_then.17971:
	flw	f4, 0(r8)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.17973
	addi	r5, r0, 0
	j	fle_cont.17974
fle_else.17973:
	addi	r5, r0, 1
fle_cont.17974:
	beqi	0, r5, beq_then.17975
	addi	r5, r0, 10724
	flw	f4, 1(r8)
	fmul	f1, f4, f1
	flw	f4, 2(r8)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 3(r8)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fsw	f1, 0(r5)
	addi	r1, r0, 1
	j	beq_cont.17976
beq_then.17975:
	addi	r1, r0, 0
beq_cont.17976:
beq_cont.17972:
	j	beq_cont.17970
beq_then.17969:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r12				# mr	r1, r12
	add	r5, r0, r8				# mr	r5, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solver_rect_fast.3175				#	bl	solver_rect_fast.3175
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.17970:
	beqi	0, r1, beq_then.17977
	flup	f1, 30		# fli	f1, -0.100000
	addi	r1, r0, 10724
	flw	f2, 0(r1)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.17979
	addi	r1, r0, 0
	j	fle_cont.17980
fle_else.17979:
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.17981
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r29, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.17983
	addi	r1, r0, 1
	j	beq_cont.17984
beq_then.17983:
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.17985
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r29, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.17987
	addi	r1, r0, 1
	j	beq_cont.17988
beq_then.17987:
	lw	r1, 2(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.17989
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r29, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.17991
	addi	r1, r0, 1
	j	beq_cont.17992
beq_then.17991:
	addi	r1, r0, 4
	lw	r2, 2(r3)
	lw	r29, 0(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.17992:
	j	beq_cont.17990
beq_then.17989:
	addi	r1, r0, 0
beq_cont.17990:
beq_cont.17988:
	j	beq_cont.17986
beq_then.17985:
	addi	r1, r0, 0
beq_cont.17986:
beq_cont.17984:
	j	beq_cont.17982
beq_then.17981:
	addi	r1, r0, 0
beq_cont.17982:
	beqi	0, r1, beq_then.17993
	addi	r1, r0, 1
	j	beq_cont.17994
beq_then.17993:
	addi	r1, r0, 0
beq_cont.17994:
fle_cont.17980:
	j	beq_cont.17978
beq_then.17977:
	addi	r1, r0, 0
beq_cont.17978:
	j	beq_cont.17968
beq_then.17967:
	addi	r1, r0, 1
beq_cont.17968:
	beqi	0, r1, beq_then.17995
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.17996
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r29, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.17998
	addi	r1, r0, 1
	j	beq_cont.17999
beq_then.17998:
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18000
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r29, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.18002
	addi	r1, r0, 1
	j	beq_cont.18003
beq_then.18002:
	lw	r1, 2(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.18004
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r29, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.18006
	addi	r1, r0, 1
	j	beq_cont.18007
beq_then.18006:
	addi	r1, r0, 4
	lw	r2, 2(r3)
	lw	r29, 0(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.18007:
	j	beq_cont.18005
beq_then.18004:
	addi	r1, r0, 0
beq_cont.18005:
beq_cont.18003:
	j	beq_cont.18001
beq_then.18000:
	addi	r1, r0, 0
beq_cont.18001:
beq_cont.17999:
	j	beq_cont.17997
beq_then.17996:
	addi	r1, r0, 0
beq_cont.17997:
	beqi	0, r1, beq_then.18008
	addi	r1, r0, 1
	jr	r31				#
beq_then.18008:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.17995:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.17966:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3269:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.18009
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
	beqi	1, r7, beq_then.18010
	beqi	2, r7, beq_then.18012
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second.3165				#	bl	solver_second.3165
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.18013
beq_then.18012:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_surface.3146				#	bl	solver_surface.3146
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.18013:
	j	beq_cont.18011
beq_then.18010:
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
	jal	solver_rect_surface.3131				#	bl	solver_rect_surface.3131
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.18014
	addi	r1, r0, 1
	j	beq_cont.18015
beq_then.18014:
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
	jal	solver_rect_surface.3131				#	bl	solver_rect_surface.3131
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.18016
	addi	r1, r0, 2
	j	beq_cont.18017
beq_then.18016:
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
	jal	solver_rect_surface.3131				#	bl	solver_rect_surface.3131
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.18018
	addi	r1, r0, 3
	j	beq_cont.18019
beq_then.18018:
	addi	r1, r0, 0
beq_cont.18019:
beq_cont.18017:
beq_cont.18015:
beq_cont.18011:
	beqi	0, r1, beq_then.18020
	addi	r2, r0, 10724
	flw	f1, 0(r2)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18021
	j	fle_cont.18022
fle_else.18021:
	addi	r2, r0, 10726
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18023
	j	fle_cont.18024
fle_else.18023:
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
	beqi	-1, r6, beq_then.18025
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r6, 0(r30)
	add	r1, r0, r6				# mr	r1, r6
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	is_outside.3249				#	bl	is_outside.3249
	addi	r3, r3, -21
	lw	r31, 20(r3)
	beqi	0, r1, beq_then.18027
	addi	r1, r0, 0
	j	beq_cont.18028
beq_then.18027:
	addi	r1, r0, 1
	flw	f1, 16(r3)
	flw	f2, 14(r3)
	flw	f3, 12(r3)
	lw	r2, 1(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	check_all_inside.3254				#	bl	check_all_inside.3254
	addi	r3, r3, -21
	lw	r31, 20(r3)
beq_cont.18028:
	j	beq_cont.18026
beq_then.18025:
	addi	r1, r0, 1
beq_cont.18026:
	beqi	0, r1, beq_then.18029
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
	j	beq_cont.18030
beq_then.18029:
beq_cont.18030:
fle_cont.18024:
fle_cont.18022:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3269
beq_then.18020:
	addi	r1, r0, 10001
	lw	r2, 3(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18031
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3269
beq_then.18031:
	jr	r31				#
beq_then.18009:
	jr	r31				#
solve_one_or_network.3273:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.18034
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
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18035
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
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18036
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
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18037
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
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_one_or_network.3273
beq_then.18037:
	jr	r31				#
beq_then.18036:
	jr	r31				#
beq_then.18035:
	jr	r31				#
beq_then.18034:
	jr	r31				#
trace_or_matrix.3277:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.18042
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.18043
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
	beqi	1, r8, beq_then.18045
	beqi	2, r8, beq_then.18047
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second.3165				#	bl	solver_second.3165
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.18048
beq_then.18047:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_surface.3146				#	bl	solver_surface.3146
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.18048:
	j	beq_cont.18046
beq_then.18045:
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
	jal	solver_rect_surface.3131				#	bl	solver_rect_surface.3131
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.18049
	addi	r1, r0, 1
	j	beq_cont.18050
beq_then.18049:
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
	jal	solver_rect_surface.3131				#	bl	solver_rect_surface.3131
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.18051
	addi	r1, r0, 2
	j	beq_cont.18052
beq_then.18051:
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
	jal	solver_rect_surface.3131				#	bl	solver_rect_surface.3131
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.18053
	addi	r1, r0, 3
	j	beq_cont.18054
beq_then.18053:
	addi	r1, r0, 0
beq_cont.18054:
beq_cont.18052:
beq_cont.18050:
beq_cont.18046:
	beqi	0, r1, beq_then.18055
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18057
	j	fle_cont.18058
fle_else.18057:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18059
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18061
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.18063
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_one_or_network.3273				#	bl	solve_one_or_network.3273
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.18064
beq_then.18063:
beq_cont.18064:
	j	beq_cont.18062
beq_then.18061:
beq_cont.18062:
	j	beq_cont.18060
beq_then.18059:
beq_cont.18060:
fle_cont.18058:
	j	beq_cont.18056
beq_then.18055:
beq_cont.18056:
	j	beq_cont.18044
beq_then.18043:
	lw	r7, 1(r6)
	beqi	-1, r7, beq_then.18065
	addi	r8, r0, 10672
	add	r30, r8, r7
	lw	r7, 0(r30)
	addi	r8, r0, 0
	sw	r6, 3(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18067
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.18069
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	solve_one_or_network.3273				#	bl	solve_one_or_network.3273
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.18070
beq_then.18069:
beq_cont.18070:
	j	beq_cont.18068
beq_then.18067:
beq_cont.18068:
	j	beq_cont.18066
beq_then.18065:
beq_cont.18066:
beq_cont.18044:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.18071
	addi	r7, r0, 99
	sw	r1, 11(r3)
	beq	r6, r7, beq_then.18072
	addi	r7, r0, 10748
	lw	r8, 0(r3)
	sw	r5, 12(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solver.3171				#	bl	solver.3171
	addi	r3, r3, -14
	lw	r31, 13(r3)
	beqi	0, r1, beq_then.18074
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18076
	j	fle_cont.18077
fle_else.18076:
	lw	r1, 12(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18078
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 12(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18080
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r1, r0, 3
	lw	r2, 12(r3)
	lw	r5, 0(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_one_or_network.3273				#	bl	solve_one_or_network.3273
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.18081
beq_then.18080:
beq_cont.18081:
	j	beq_cont.18079
beq_then.18078:
beq_cont.18079:
fle_cont.18077:
	j	beq_cont.18075
beq_then.18074:
beq_cont.18075:
	j	beq_cont.18073
beq_then.18072:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.18082
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
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 12(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18084
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r1, r0, 3
	lw	r2, 12(r3)
	lw	r5, 0(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	solve_one_or_network.3273				#	bl	solve_one_or_network.3273
	addi	r3, r3, -14
	lw	r31, 13(r3)
	j	beq_cont.18085
beq_then.18084:
beq_cont.18085:
	j	beq_cont.18083
beq_then.18082:
beq_cont.18083:
beq_cont.18073:
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix.3277
beq_then.18071:
	jr	r31				#
beq_then.18042:
	jr	r31				#
judge_intersection.3281:
	addi	r2, r0, 10726
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r2)
	addi	r2, r0, 10723
	lw	r2, 0(r2)
	lw	r5, 0(r2)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.18088
	addi	r7, r0, 99
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	beq	r6, r7, beq_then.18090
	addi	r7, r0, 10748
	sw	r5, 2(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver.3171				#	bl	solver.3171
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.18092
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18094
	j	fle_cont.18095
fle_else.18094:
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18096
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18098
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network.3273				#	bl	solve_one_or_network.3273
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.18099
beq_then.18098:
beq_cont.18099:
	j	beq_cont.18097
beq_then.18096:
beq_cont.18097:
fle_cont.18095:
	j	beq_cont.18093
beq_then.18092:
beq_cont.18093:
	j	beq_cont.18091
beq_then.18090:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.18100
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
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18102
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element.3269				#	bl	solve_each_element.3269
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network.3273				#	bl	solve_one_or_network.3273
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.18103
beq_then.18102:
beq_cont.18103:
	j	beq_cont.18101
beq_then.18100:
beq_cont.18101:
beq_cont.18091:
	addi	r1, r0, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix.3277				#	bl	trace_or_matrix.3277
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.18089
beq_then.18088:
beq_cont.18089:
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18104
	addi	r1, r0, 0
	jr	r31				#
fle_else.18104:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18105
	addi	r1, r0, 0
	jr	r31				#
fle_else.18105:
	addi	r1, r0, 1
	jr	r31				#
solve_each_element_fast.3283:
	lw	r6, 0(r5)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.18106
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
	beqi	1, r11, beq_then.18107
	beqi	2, r11, beq_then.18109
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_second_fast2.3205				#	bl	solver_second_fast2.3205
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.18110
beq_then.18109:
	flw	f1, 0(r10)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18111
	addi	r8, r0, 0
	j	fle_cont.18112
fle_else.18111:
	addi	r8, r0, 1
fle_cont.18112:
	beqi	0, r8, beq_then.18113
	addi	r8, r0, 10724
	flw	f1, 0(r10)
	flw	f2, 3(r9)
	fmul	f1, f1, f2
	fsw	f1, 0(r8)
	addi	r1, r0, 1
	j	beq_cont.18114
beq_then.18113:
	addi	r1, r0, 0
beq_cont.18114:
beq_cont.18110:
	j	beq_cont.18108
beq_then.18107:
	lw	r9, 0(r5)
	add	r5, r0, r10				# mr	r5, r10
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_rect_fast.3175				#	bl	solver_rect_fast.3175
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.18108:
	beqi	0, r1, beq_then.18115
	addi	r2, r0, 10724
	flw	f1, 0(r2)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18116
	j	fle_cont.18117
fle_else.18116:
	addi	r2, r0, 10726
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18118
	j	fle_cont.18119
fle_else.18118:
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
	beqi	-1, r5, beq_then.18120
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r5, 0(r30)
	add	r1, r0, r5				# mr	r1, r5
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	is_outside.3249				#	bl	is_outside.3249
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.18122
	addi	r1, r0, 0
	j	beq_cont.18123
beq_then.18122:
	addi	r1, r0, 1
	flw	f1, 10(r3)
	flw	f2, 8(r3)
	flw	f3, 6(r3)
	lw	r2, 2(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	check_all_inside.3254				#	bl	check_all_inside.3254
	addi	r3, r3, -15
	lw	r31, 14(r3)
beq_cont.18123:
	j	beq_cont.18121
beq_then.18120:
	addi	r1, r0, 1
beq_cont.18121:
	beqi	0, r1, beq_then.18124
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
	j	beq_cont.18125
beq_then.18124:
beq_cont.18125:
fle_cont.18119:
fle_cont.18117:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	j	solve_each_element_fast.3283
beq_then.18115:
	addi	r1, r0, 10001
	lw	r2, 4(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.18126
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	j	solve_each_element_fast.3283
beq_then.18126:
	jr	r31				#
beq_then.18106:
	jr	r31				#
solve_one_or_network_fast.3287:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.18129
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
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18130
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
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18131
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
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.18132
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
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_one_or_network_fast.3287
beq_then.18132:
	jr	r31				#
beq_then.18131:
	jr	r31				#
beq_then.18130:
	jr	r31				#
beq_then.18129:
	jr	r31				#
trace_or_matrix_fast.3291:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.18137
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.18138
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
	beqi	1, r10, beq_then.18140
	beqi	2, r10, beq_then.18142
	add	r5, r0, r9				# mr	r5, r9
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_second_fast2.3205				#	bl	solver_second_fast2.3205
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.18143
beq_then.18142:
	flw	f1, 0(r7)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18144
	addi	r8, r0, 0
	j	fle_cont.18145
fle_else.18144:
	addi	r8, r0, 1
fle_cont.18145:
	beqi	0, r8, beq_then.18146
	addi	r8, r0, 10724
	flw	f1, 0(r7)
	flw	f2, 3(r9)
	fmul	f1, f1, f2
	fsw	f1, 0(r8)
	addi	r1, r0, 1
	j	beq_cont.18147
beq_then.18146:
	addi	r1, r0, 0
beq_cont.18147:
beq_cont.18143:
	j	beq_cont.18141
beq_then.18140:
	lw	r9, 0(r5)
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_rect_fast.3175				#	bl	solver_rect_fast.3175
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.18141:
	beqi	0, r1, beq_then.18148
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18150
	j	fle_cont.18151
fle_else.18150:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18152
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18154
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.18156
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3287				#	bl	solve_one_or_network_fast.3287
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.18157
beq_then.18156:
beq_cont.18157:
	j	beq_cont.18155
beq_then.18154:
beq_cont.18155:
	j	beq_cont.18153
beq_then.18152:
beq_cont.18153:
fle_cont.18151:
	j	beq_cont.18149
beq_then.18148:
beq_cont.18149:
	j	beq_cont.18139
beq_then.18138:
	lw	r7, 1(r6)
	beqi	-1, r7, beq_then.18158
	addi	r8, r0, 10672
	add	r30, r8, r7
	lw	r7, 0(r30)
	addi	r8, r0, 0
	sw	r6, 3(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18160
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	lw	r2, 3(r1)
	beqi	-1, r2, beq_then.18162
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 4
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3287				#	bl	solve_one_or_network_fast.3287
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.18163
beq_then.18162:
beq_cont.18163:
	j	beq_cont.18161
beq_then.18160:
beq_cont.18161:
	j	beq_cont.18159
beq_then.18158:
beq_cont.18159:
beq_cont.18139:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.18164
	addi	r7, r0, 99
	sw	r1, 4(r3)
	beq	r6, r7, beq_then.18165
	lw	r7, 0(r3)
	sw	r5, 5(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solver_fast2.3212				#	bl	solver_fast2.3212
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.18167
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18169
	j	fle_cont.18170
fle_else.18169:
	lw	r1, 5(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18171
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18173
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 3
	lw	r2, 5(r3)
	lw	r5, 0(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_one_or_network_fast.3287				#	bl	solve_one_or_network_fast.3287
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.18174
beq_then.18173:
beq_cont.18174:
	j	beq_cont.18172
beq_then.18171:
beq_cont.18172:
fle_cont.18170:
	j	beq_cont.18168
beq_then.18167:
beq_cont.18168:
	j	beq_cont.18166
beq_then.18165:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.18175
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
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18177
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 3
	lw	r2, 5(r3)
	lw	r5, 0(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solve_one_or_network_fast.3287				#	bl	solve_one_or_network_fast.3287
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.18178
beq_then.18177:
beq_cont.18178:
	j	beq_cont.18176
beq_then.18175:
beq_cont.18176:
beq_cont.18166:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix_fast.3291
beq_then.18164:
	jr	r31				#
beq_then.18137:
	jr	r31				#
judge_intersection_fast.3295:
	addi	r2, r0, 10726
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r2)
	addi	r2, r0, 10723
	lw	r2, 0(r2)
	lw	r5, 0(r2)
	lw	r6, 0(r5)
	beqi	-1, r6, beq_then.18181
	addi	r7, r0, 99
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	beq	r6, r7, beq_then.18183
	sw	r5, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solver_fast2.3212				#	bl	solver_fast2.3212
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	0, r1, beq_then.18185
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18187
	j	fle_cont.18188
fle_else.18187:
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.18189
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18191
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network_fast.3287				#	bl	solve_one_or_network_fast.3287
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.18192
beq_then.18191:
beq_cont.18192:
	j	beq_cont.18190
beq_then.18189:
beq_cont.18190:
fle_cont.18188:
	j	beq_cont.18186
beq_then.18185:
beq_cont.18186:
	j	beq_cont.18184
beq_then.18183:
	lw	r6, 1(r5)
	beqi	-1, r6, beq_then.18193
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
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	lw	r2, 2(r1)
	beqi	-1, r2, beq_then.18195
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_each_element_fast.3283				#	bl	solve_each_element_fast.3283
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r1, r0, 3
	lw	r2, 2(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	solve_one_or_network_fast.3287				#	bl	solve_one_or_network_fast.3287
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.18196
beq_then.18195:
beq_cont.18196:
	j	beq_cont.18194
beq_then.18193:
beq_cont.18194:
beq_cont.18184:
	addi	r1, r0, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	trace_or_matrix_fast.3291				#	bl	trace_or_matrix_fast.3291
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	beq_cont.18182
beq_then.18181:
beq_cont.18182:
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18197
	addi	r1, r0, 0
	jr	r31				#
fle_else.18197:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18198
	addi	r1, r0, 0
	jr	r31				#
fle_else.18198:
	addi	r1, r0, 1
	jr	r31				#
get_nvector_rect.3297:
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
	beq	r0, r30, feq_else.18199
	addi	r1, r0, 1
	j	feq_cont.18200
feq_else.18199:
	addi	r1, r0, 0
feq_cont.18200:
	beqi	0, r1, beq_then.18201
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18202
beq_then.18201:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18203
	addi	r1, r0, 0
	j	fle_cont.18204
fle_else.18203:
	addi	r1, r0, 1
fle_cont.18204:
	beqi	0, r1, beq_then.18205
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.18206
beq_then.18205:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.18206:
beq_cont.18202:
	fneg	f1, f1
	add	r30, r5, r6
	fsw	f1, 0(r30)
	jr	r31				#
get_nvector_plane.3299:
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
get_nvector_second.3301:
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
	beqi	0, r2, beq_then.18209
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
	j	beq_cont.18210
beq_then.18209:
	addi	r2, r0, 10731
	fsw	f4, 0(r2)
	addi	r2, r0, 10731
	fsw	f5, 1(r2)
	addi	r2, r0, 10731
	fsw	f6, 2(r2)
beq_cont.18210:
	addi	r2, r0, 10731
	lw	r1, 6(r1)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	vecunit_sgn.3009
get_nvector.3303:
	lw	r5, 1(r1)
	beqi	1, r5, beq_then.18211
	beqi	2, r5, beq_then.18212
	j	get_nvector_second.3301
beq_then.18212:
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
beq_then.18211:
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
	beq	r0, r30, feq_else.18214
	addi	r1, r0, 1
	j	feq_cont.18215
feq_else.18214:
	addi	r1, r0, 0
feq_cont.18215:
	beqi	0, r1, beq_then.18216
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18217
beq_then.18216:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18218
	addi	r1, r0, 0
	j	fle_cont.18219
fle_else.18218:
	addi	r1, r0, 1
fle_cont.18219:
	beqi	0, r1, beq_then.18220
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.18221
beq_then.18220:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.18221:
beq_cont.18217:
	fneg	f1, f1
	add	r30, r5, r6
	fsw	f1, 0(r30)
	jr	r31				#
utexture.3306:
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
	beqi	1, r5, beq_then.18223
	beqi	2, r5, beq_then.18224
	beqi	3, r5, beq_then.18225
	beqi	4, r5, beq_then.18226
	jr	r31				#
beq_then.18226:
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
	beq	r0, r30, fle_else.18228
	fadd	f5, f0, f1
	j	fle_cont.18229
fle_else.18228:
	fneg	f5, f1
fle_cont.18229:
	fsw	f3, 0(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	fle	r30, f4, f5
	beq	r0, r30, fle_else.18230
	fdiv	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18232
	j	fle_cont.18233
fle_else.18232:
	fneg	f1, f1
fle_cont.18233:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18234
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.18235
fle_else.18234:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.18235:
	fmul	f1, f1, f2
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f1
	beq	r0, r30, fle_else.18236
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f1
	beq	r0, r30, fle_else.18238
	flup	f4, 15		# fli	f4, 1.570796
	flup	f5, 2		# fli	f5, 1.000000
	fdiv	f1, f5, f1
	fsw	f2, 4(r3)
	fsw	f4, 6(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	j	fle_cont.18239
fle_else.18238:
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
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
fle_cont.18239:
	j	fle_cont.18237
fle_else.18236:
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -11
	lw	r31, 10(r3)
fle_cont.18237:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.18231
fle_else.18230:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.18231:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18240
	addi	r1, r0, 0
	j	feq_cont.18241
feq_else.18240:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18242
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.18243
fle_else.18242:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.18243:
feq_cont.18241:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18244
	j	fle_cont.18245
fle_else.18244:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.18245:
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
	beq	r0, r30, fle_else.18246
	fadd	f5, f0, f4
	j	fle_cont.18247
fle_else.18246:
	fneg	f5, f4
fle_cont.18247:
	fsw	f1, 10(r3)
	fle	r30, f3, f5
	beq	r0, r30, fle_else.18248
	fdiv	f2, f2, f4
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18250
	j	fle_cont.18251
fle_else.18250:
	fneg	f2, f2
fle_cont.18251:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18252
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.18253
fle_else.18252:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.18253:
	fmul	f2, f2, f3
	flup	f4, 23		# fli	f4, 4.375000
	fle	r30, f4, f2
	beq	r0, r30, fle_else.18254
	flup	f4, 24		# fli	f4, 2.437500
	fle	r30, f4, f2
	beq	r0, r30, fle_else.18256
	flup	f4, 15		# fli	f4, 1.570796
	flup	f5, 2		# fli	f5, 1.000000
	fdiv	f2, f5, f2
	fsw	f3, 12(r3)
	fsw	f4, 14(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	flw	f2, 12(r3)
	fmul	f1, f1, f2
	j	fle_cont.18257
fle_else.18256:
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
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fadd	f1, f2, f1
	flw	f2, 12(r3)
	fmul	f1, f1, f2
fle_cont.18257:
	j	fle_cont.18255
fle_else.18254:
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -19
	lw	r31, 18(r3)
fle_cont.18255:
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.18249
fle_else.18248:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.18249:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18258
	addi	r1, r0, 0
	j	feq_cont.18259
feq_else.18258:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18260
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.18261
fle_else.18260:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.18261:
feq_cont.18259:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18262
	j	fle_cont.18263
fle_else.18262:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.18263:
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
	beq	r0, r30, fle_else.18264
	addi	r1, r0, 0
	j	fle_cont.18265
fle_else.18264:
	addi	r1, r0, 1
fle_cont.18265:
	beqi	0, r1, beq_then.18266
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18267
beq_then.18266:
beq_cont.18267:
	addi	r1, r0, 10734
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f2, f1
	flup	f2, 38		# fli	f2, 0.300000
	fdiv	f1, f1, f2
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.18225:
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
	beq	r0, r30, feq_else.18269
	addi	r1, r0, 0
	j	feq_cont.18270
feq_else.18269:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18271
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.18272
fle_else.18271:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.18272:
feq_cont.18270:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18273
	j	fle_cont.18274
fle_else.18273:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.18274:
	fsub	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fmul	f1, f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	cos.2924				#	bl	cos.2924
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
beq_then.18224:
	flw	f1, 1(r2)
	flup	f2, 40		# fli	f2, 0.250000
	fmul	f1, f1, f2
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	sin.2922				#	bl	sin.2922
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
beq_then.18223:
	flw	f1, 0(r2)
	lw	r5, 5(r1)
	flw	f2, 0(r5)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	feq	r30, f2, f0
	beq	r0, r30, feq_else.18277
	addi	r5, r0, 0
	j	feq_cont.18278
feq_else.18277:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18279
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r5, f3
	j	fle_cont.18280
fle_else.18279:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r5, f3
fle_cont.18280:
feq_cont.18278:
	itof	f3, r5
	fle	r30, f3, f2
	beq	r0, r30, fle_else.18281
	fadd	f2, f0, f3
	j	fle_cont.18282
fle_else.18281:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.18282:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.18283
	addi	r5, r0, 0
	j	fle_cont.18284
fle_else.18283:
	addi	r5, r0, 1
fle_cont.18284:
	flw	f1, 2(r2)
	lw	r1, 5(r1)
	flw	f2, 2(r1)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	feq	r30, f2, f0
	beq	r0, r30, feq_else.18285
	addi	r1, r0, 0
	j	feq_cont.18286
feq_else.18285:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18287
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r1, f3
	j	fle_cont.18288
fle_else.18287:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r1, f3
fle_cont.18288:
feq_cont.18286:
	itof	f3, r1
	fle	r30, f3, f2
	beq	r0, r30, fle_else.18289
	fadd	f2, f0, f3
	j	fle_cont.18290
fle_else.18289:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.18290:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.18291
	addi	r1, r0, 0
	j	fle_cont.18292
fle_else.18291:
	addi	r1, r0, 1
fle_cont.18292:
	addi	r2, r0, 10734
	beqi	0, r5, beq_then.18293
	beqi	0, r1, beq_then.18295
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.18296
beq_then.18295:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.18296:
	j	beq_cont.18294
beq_then.18293:
	beqi	0, r1, beq_then.18297
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18298
beq_then.18297:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.18298:
beq_cont.18294:
	fsw	f1, 1(r2)
	jr	r31				#
add_light.3309:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18300
	addi	r1, r0, 0
	j	fle_cont.18301
fle_else.18300:
	addi	r1, r0, 1
fle_cont.18301:
	beqi	0, r1, beq_then.18302
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
	j	beq_cont.18303
beq_then.18302:
beq_cont.18303:
	fle	r30, f2, f0
	beq	r0, r30, fle_else.18304
	addi	r1, r0, 0
	j	fle_cont.18305
fle_else.18304:
	addi	r1, r0, 1
fle_cont.18305:
	beqi	0, r1, beq_then.18306
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
beq_then.18306:
	jr	r31				#
trace_reflections.3313:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r1, ble_then.18309
	jr	r31				#
ble_then.18309:
	addi	r6, r0, 10778
	add	r30, r6, r1
	lw	r6, 0(r30)
	lw	r7, 1(r6)
	addi	r8, r0, 10726
	flup	f3, 31		# fli	f3, 1000000000.000000
	fsw	f3, 0(r8)
	addi	r8, r0, 0
	addi	r9, r0, 10723
	lw	r9, 0(r9)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	fsw	f2, 2(r3)
	sw	r2, 4(r3)
	fsw	f1, 6(r3)
	sw	r7, 8(r3)
	sw	r5, 9(r3)
	sw	r6, 10(r3)
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	trace_or_matrix_fast.3291				#	bl	trace_or_matrix_fast.3291
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18312
	addi	r1, r0, 0
	j	fle_cont.18313
fle_else.18312:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18314
	addi	r1, r0, 0
	j	fle_cont.18315
fle_else.18314:
	addi	r1, r0, 1
fle_cont.18315:
fle_cont.18313:
	beqi	0, r1, beq_then.18316
	addi	r1, r0, 10730
	lw	r1, 0(r1)
	slli	r1, r1, 2
	addi	r2, r0, 10725
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 10(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.18318
	j	beq_cont.18319
beq_then.18318:
	addi	r1, r0, 0
	addi	r5, r0, 10723
	lw	r5, 0(r5)
	lw	r29, 9(r3)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.18320
	j	beq_cont.18321
beq_then.18320:
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
	lw	r1, 10(r3)
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
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	add_light.3309				#	bl	add_light.3309
	addi	r3, r3, -12
	lw	r31, 11(r3)
beq_cont.18321:
beq_cont.18319:
	j	beq_cont.18317
beq_then.18316:
beq_cont.18317:
	lw	r1, 1(r3)
	addi	r1, r1, -1
	flw	f1, 6(r3)
	flw	f2, 2(r3)
	lw	r2, 4(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
trace_ray.3318:
	lw	r6, 4(r29)
	lw	r7, 3(r29)
	lw	r8, 2(r29)
	lw	r9, 1(r29)
	blei	4, r1, ble_then.18322
	jr	r31				#
ble_then.18322:
	lw	r10, 2(r5)
	addi	r11, r0, 10726
	flup	f3, 31		# fli	f3, 1000000000.000000
	fsw	f3, 0(r11)
	addi	r11, r0, 0
	addi	r12, r0, 10723
	lw	r12, 0(r12)
	sw	r29, 0(r3)
	fsw	f2, 2(r3)
	sw	r7, 4(r3)
	sw	r8, 5(r3)
	sw	r9, 6(r3)
	sw	r6, 7(r3)
	sw	r5, 8(r3)
	fsw	f1, 10(r3)
	sw	r2, 12(r3)
	sw	r1, 13(r3)
	sw	r10, 14(r3)
	add	r5, r0, r2				# mr	r5, r2
	add	r1, r0, r11				# mr	r1, r11
	add	r2, r0, r12				# mr	r2, r12
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	trace_or_matrix.3277				#	bl	trace_or_matrix.3277
	addi	r3, r3, -16
	lw	r31, 15(r3)
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18326
	addi	r1, r0, 0
	j	fle_cont.18327
fle_else.18326:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18328
	addi	r1, r0, 0
	j	fle_cont.18329
fle_else.18328:
	addi	r1, r0, 1
fle_cont.18329:
fle_cont.18327:
	beqi	0, r1, beq_then.18330
	addi	r1, r0, 10730
	lw	r1, 0(r1)
	addi	r2, r0, 10001
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	lw	r6, 7(r2)
	flw	f1, 0(r6)
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	lw	r6, 1(r2)
	sw	r5, 15(r3)
	fsw	f1, 16(r3)
	sw	r1, 18(r3)
	sw	r2, 19(r3)
	beqi	1, r6, beq_then.18331
	beqi	2, r6, beq_then.18333
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	get_nvector_second.3301				#	bl	get_nvector_second.3301
	addi	r3, r3, -21
	lw	r31, 20(r3)
	j	beq_cont.18334
beq_then.18333:
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
beq_cont.18334:
	j	beq_cont.18332
beq_then.18331:
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
	lw	r9, 12(r3)
	add	r30, r9, r6
	flw	f3, 0(r30)
	feq	r30, f3, f0
	beq	r0, r30, feq_else.18335
	addi	r6, r0, 1
	j	feq_cont.18336
feq_else.18335:
	addi	r6, r0, 0
feq_cont.18336:
	beqi	0, r6, beq_then.18337
	flup	f3, 0		# fli	f3, 0.000000
	j	beq_cont.18338
beq_then.18337:
	fle	r30, f3, f0
	beq	r0, r30, fle_else.18339
	addi	r6, r0, 0
	j	fle_cont.18340
fle_else.18339:
	addi	r6, r0, 1
fle_cont.18340:
	beqi	0, r6, beq_then.18341
	flup	f3, 2		# fli	f3, 1.000000
	j	beq_cont.18342
beq_then.18341:
	flup	f3, 11		# fli	f3, -1.000000
beq_cont.18342:
beq_cont.18338:
	fneg	f3, f3
	add	r30, r7, r8
	fsw	f3, 0(r30)
beq_cont.18332:
	addi	r1, r0, 10748
	addi	r2, r0, 10727
	flw	f1, 0(r2)
	fsw	f1, 0(r1)
	flw	f1, 1(r2)
	fsw	f1, 1(r1)
	flw	f1, 2(r2)
	fsw	f1, 2(r1)
	addi	r2, r0, 10727
	lw	r1, 19(r3)
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	utexture.3306				#	bl	utexture.3306
	addi	r3, r3, -21
	lw	r31, 20(r3)
	lw	r1, 18(r3)
	slli	r1, r1, 2
	addi	r2, r0, 10725
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 8(r3)
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
	lw	r7, 19(r3)
	lw	r8, 7(r7)
	flw	f2, 0(r8)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18343
	lw	r8, 7(r3)
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
	flw	f2, 16(r3)
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
	j	fle_cont.18344
fle_else.18343:
	lw	r8, 6(r3)
	add	r30, r6, r2
	sw	r8, 0(r30)
fle_cont.18344:
	flup	f1, 44		# fli	f1, -2.000000
	addi	r6, r0, 10731
	lw	r8, 12(r3)
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
	flw	f2, 10(r3)
	fmul	f1, f2, f1
	addi	r6, r0, 0
	addi	r9, r0, 10723
	lw	r9, 0(r9)
	lw	r29, 5(r3)
	fsw	f1, 20(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
	beqi	0, r1, beq_then.18345
	j	beq_cont.18346
beq_then.18345:
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
	flw	f2, 16(r3)
	fmul	f1, f1, f2
	addi	r1, r0, 10667
	lw	r2, 12(r3)
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
	flw	f4, 20(r3)
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	add_light.3309				#	bl	add_light.3309
	addi	r3, r3, -23
	lw	r31, 22(r3)
beq_cont.18346:
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
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	setup_startp_constants.3229				#	bl	setup_startp_constants.3229
	addi	r3, r3, -23
	lw	r31, 22(r3)
	addi	r1, r0, 10958
	lw	r1, 0(r1)
	addi	r1, r1, -1
	flw	f1, 16(r3)
	flw	f2, 20(r3)
	lw	r2, 12(r3)
	lw	r29, 4(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flup	f1, 45		# fli	f1, 0.100000
	flw	f2, 10(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18347
	jr	r31				#
fle_else.18347:
	addi	r1, r0, 4
	lw	r2, 13(r3)
	ble	r1, r2, ble_then.18349
	addi	r1, r2, 1
	addi	r5, r0, -1
	lw	r6, 14(r3)
	add	r30, r6, r1
	sw	r5, 0(r30)
	j	ble_cont.18350
ble_then.18349:
ble_cont.18350:
	lw	r1, 15(r3)
	beqi	2, r1, beq_then.18351
	j	beq_cont.18352
beq_then.18351:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r1, 19(r3)
	lw	r1, 7(r1)
	flw	f3, 0(r1)
	fsub	f1, f1, f3
	fmul	f1, f2, f1
	addi	r1, r2, 1
	addi	r2, r0, 10726
	flw	f2, 0(r2)
	flw	f3, 2(r3)
	fadd	f2, f3, f2
	lw	r2, 12(r3)
	lw	r5, 8(r3)
	lw	r29, 0(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -23
	lw	r31, 22(r3)
beq_cont.18352:
	jr	r31				#
beq_then.18330:
	addi	r1, r0, -1
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	0, r2, beq_then.18354
	addi	r1, r0, 10667
	lw	r2, 12(r3)
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
	beq	r0, r30, fle_else.18355
	addi	r1, r0, 0
	j	fle_cont.18356
fle_else.18355:
	addi	r1, r0, 1
fle_cont.18356:
	beqi	0, r1, beq_then.18357
	fmul	f2, f1, f1
	fmul	f1, f2, f1
	flw	f2, 10(r3)
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
beq_then.18357:
	jr	r31				#
beq_then.18354:
	jr	r31				#
trace_diffuse_ray.3324:
	lw	r2, 1(r29)
	addi	r5, r0, 10726
	flup	f2, 31		# fli	f2, 1000000000.000000
	fsw	f2, 0(r5)
	addi	r5, r0, 0
	addi	r6, r0, 10723
	lw	r6, 0(r6)
	fsw	f1, 0(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r1				# mr	r5, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	trace_or_matrix_fast.3291				#	bl	trace_or_matrix_fast.3291
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18361
	addi	r1, r0, 0
	j	fle_cont.18362
fle_else.18361:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.18363
	addi	r1, r0, 0
	j	fle_cont.18364
fle_else.18363:
	addi	r1, r0, 1
fle_cont.18364:
fle_cont.18362:
	beqi	0, r1, beq_then.18365
	addi	r1, r0, 10001
	addi	r2, r0, 10730
	lw	r2, 0(r2)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r2, 3(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	sw	r1, 4(r3)
	beqi	1, r5, beq_then.18366
	beqi	2, r5, beq_then.18368
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	get_nvector_second.3301				#	bl	get_nvector_second.3301
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.18369
beq_then.18368:
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
beq_cont.18369:
	j	beq_cont.18367
beq_then.18366:
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
	beq	r0, r30, feq_else.18370
	addi	r2, r0, 1
	j	feq_cont.18371
feq_else.18370:
	addi	r2, r0, 0
feq_cont.18371:
	beqi	0, r2, beq_then.18372
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.18373
beq_then.18372:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.18374
	addi	r2, r0, 0
	j	fle_cont.18375
fle_else.18374:
	addi	r2, r0, 1
fle_cont.18375:
	beqi	0, r2, beq_then.18376
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.18377
beq_then.18376:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.18377:
beq_cont.18373:
	fneg	f1, f1
	add	r30, r6, r7
	fsw	f1, 0(r30)
beq_cont.18367:
	addi	r2, r0, 10727
	lw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	utexture.3306				#	bl	utexture.3306
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r1, r0, 0
	addi	r2, r0, 10723
	lw	r2, 0(r2)
	lw	r29, 2(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.18378
	jr	r31				#
beq_then.18378:
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
	beq	r0, r30, fle_else.18380
	addi	r1, r0, 0
	j	fle_cont.18381
fle_else.18380:
	addi	r1, r0, 1
fle_cont.18381:
	beqi	0, r1, beq_then.18382
	j	beq_cont.18383
beq_then.18382:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.18383:
	addi	r1, r0, 10737
	flw	f2, 0(r3)
	fmul	f1, f2, f1
	lw	r2, 4(r3)
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
beq_then.18365:
	jr	r31				#
iter_trace_diffuse_rays.3327:
	lw	r7, 1(r29)
	addi	r8, r0, 0
	ble	r8, r6, ble_then.18386
	jr	r31				#
ble_then.18386:
	add	r30, r1, r6
	lw	r8, 0(r30)
	lw	r8, 0(r8)
	flw	f1, 0(r8)
	flw	f2, 0(r2)
	fmul	f1, f1, f2
	flw	f2, 1(r8)
	flw	f3, 1(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	flw	f2, 2(r8)
	flw	f3, 2(r2)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18388
	addi	r8, r0, 0
	j	fle_cont.18389
fle_else.18388:
	addi	r8, r0, 1
fle_cont.18389:
	sw	r5, 0(r3)
	sw	r29, 1(r3)
	sw	r7, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	sw	r6, 5(r3)
	beqi	0, r8, beq_then.18390
	addi	r8, r6, 1
	add	r30, r1, r8
	lw	r8, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r8				# mr	r1, r8
	add	r29, r0, r7				# mr	r29, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.18391
beq_then.18390:
	add	r30, r1, r6
	lw	r8, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	add	r1, r0, r8				# mr	r1, r8
	add	r29, r0, r7				# mr	r29, r7
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.18391:
	lw	r1, 5(r3)
	addi	r1, r1, -2
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18392
	jr	r31				#
ble_then.18392:
	lw	r2, 4(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r5, 0(r5)
	flw	f1, 0(r5)
	lw	r6, 3(r3)
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
	beq	r0, r30, fle_else.18394
	addi	r5, r0, 0
	j	fle_cont.18395
fle_else.18394:
	addi	r5, r0, 1
fle_cont.18395:
	sw	r1, 6(r3)
	beqi	0, r5, beq_then.18396
	addi	r5, r1, 1
	add	r30, r2, r5
	lw	r5, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	lw	r29, 2(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.18397
beq_then.18396:
	add	r30, r2, r1
	lw	r5, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	lw	r29, 2(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
beq_cont.18397:
	lw	r1, 6(r3)
	addi	r6, r1, -2
	lw	r1, 4(r3)
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
trace_diffuse_rays.3332:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	addi	r8, r0, 10751
	flw	f1, 0(r5)
	fsw	f1, 0(r8)
	flw	f1, 1(r5)
	fsw	f1, 1(r8)
	flw	f1, 2(r5)
	fsw	f1, 2(r8)
	addi	r8, r0, 10000
	lw	r8, 0(r8)
	addi	r8, r8, -1
	sw	r5, 0(r3)
	sw	r7, 1(r3)
	sw	r6, 2(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_startp_constants.3229				#	bl	setup_startp_constants.3229
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	lw	r2, 118(r1)
	lw	r2, 0(r2)
	flw	f1, 0(r2)
	lw	r5, 3(r3)
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
	beq	r0, r30, fle_else.18398
	addi	r2, r0, 0
	j	fle_cont.18399
fle_else.18398:
	addi	r2, r0, 1
fle_cont.18399:
	beqi	0, r2, beq_then.18400
	lw	r2, 119(r1)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	lw	r29, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.18401
beq_then.18400:
	lw	r2, 118(r1)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	lw	r29, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.18401:
	addi	r6, r0, 116
	lw	r1, 4(r3)
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
trace_diffuse_ray_80percent.3336:
	lw	r6, 1(r29)
	sw	r2, 0(r3)
	sw	r6, 1(r3)
	sw	r5, 2(r3)
	sw	r1, 3(r3)
	beqi	0, r1, beq_then.18402
	addi	r7, r0, 10766
	lw	r7, 0(r7)
	addi	r8, r0, 10751
	flw	f1, 0(r5)
	fsw	f1, 0(r8)
	flw	f1, 1(r5)
	fsw	f1, 1(r8)
	flw	f1, 2(r5)
	fsw	f1, 2(r8)
	addi	r8, r0, 10000
	lw	r8, 0(r8)
	addi	r8, r8, -1
	sw	r7, 4(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_startp_constants.3229				#	bl	setup_startp_constants.3229
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r6, r0, 118
	lw	r1, 4(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r29, 1(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.18403
beq_then.18402:
beq_cont.18403:
	lw	r1, 3(r3)
	beqi	1, r1, beq_then.18404
	addi	r2, r0, 10766
	lw	r2, 1(r2)
	addi	r5, r0, 10751
	lw	r6, 2(r3)
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
	jal	setup_startp_constants.3229				#	bl	setup_startp_constants.3229
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r6, r0, 118
	lw	r1, 5(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r29, 1(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.18405
beq_then.18404:
beq_cont.18405:
	lw	r1, 3(r3)
	beqi	2, r1, beq_then.18406
	addi	r2, r0, 10766
	lw	r2, 2(r2)
	addi	r5, r0, 10751
	lw	r6, 2(r3)
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
	jal	setup_startp_constants.3229				#	bl	setup_startp_constants.3229
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r6, r0, 118
	lw	r1, 6(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r29, 1(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.18407
beq_then.18406:
beq_cont.18407:
	lw	r1, 3(r3)
	beqi	3, r1, beq_then.18408
	addi	r2, r0, 10766
	lw	r2, 3(r2)
	addi	r5, r0, 10751
	lw	r6, 2(r3)
	flw	f1, 0(r6)
	fsw	f1, 0(r5)
	flw	f1, 1(r6)
	fsw	f1, 1(r5)
	flw	f1, 2(r6)
	fsw	f1, 2(r5)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	sw	r2, 7(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_startp_constants.3229				#	bl	setup_startp_constants.3229
	addi	r3, r3, -9
	lw	r31, 8(r3)
	addi	r6, r0, 118
	lw	r1, 7(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r29, 1(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.18409
beq_then.18408:
beq_cont.18409:
	lw	r1, 3(r3)
	beqi	4, r1, beq_then.18410
	addi	r1, r0, 10766
	lw	r1, 4(r1)
	addi	r2, r0, 10751
	lw	r5, 2(r3)
	flw	f1, 0(r5)
	fsw	f1, 0(r2)
	flw	f1, 1(r5)
	fsw	f1, 1(r2)
	flw	f1, 2(r5)
	fsw	f1, 2(r2)
	addi	r2, r0, 10000
	lw	r2, 0(r2)
	addi	r2, r2, -1
	sw	r1, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_startp_constants.3229				#	bl	setup_startp_constants.3229
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r6, r0, 118
	lw	r1, 8(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18410:
	jr	r31				#
calc_diffuse_using_1point.3340:
	lw	r29, 1(r29)
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
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r1, r0, 10740
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 10737
	j	vecaccumv.3033
calc_diffuse_using_5points.3343:
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
	j	vecaccumv.3033
do_without_neighbors.3349:
	lw	r5, 1(r29)
	blei	4, r2, ble_then.18412
	jr	r31				#
ble_then.18412:
	lw	r6, 2(r1)
	addi	r7, r0, 0
	add	r30, r6, r2
	lw	r6, 0(r30)
	ble	r7, r6, ble_then.18414
	jr	r31				#
ble_then.18414:
	lw	r6, 3(r1)
	add	r30, r6, r2
	lw	r6, 0(r30)
	sw	r29, 0(r3)
	sw	r5, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	beqi	0, r6, beq_then.18416
	lw	r6, 5(r1)
	lw	r7, 7(r1)
	lw	r8, 1(r1)
	lw	r9, 4(r1)
	addi	r10, r0, 10737
	add	r30, r6, r2
	lw	r6, 0(r30)
	flw	f1, 0(r6)
	fsw	f1, 0(r10)
	flw	f1, 1(r6)
	fsw	f1, 1(r10)
	flw	f1, 2(r6)
	fsw	f1, 2(r10)
	lw	r6, 6(r1)
	lw	r6, 0(r6)
	add	r30, r7, r2
	lw	r7, 0(r30)
	add	r30, r8, r2
	lw	r8, 0(r30)
	sw	r9, 4(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r8				# mr	r5, r8
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
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
	jal	vecaccumv.3033				#	bl	vecaccumv.3033
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.18417
beq_then.18416:
beq_cont.18417:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	blei	4, r1, ble_then.18418
	jr	r31				#
ble_then.18418:
	lw	r2, 2(r3)
	lw	r5, 2(r2)
	addi	r6, r0, 0
	add	r30, r5, r1
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.18420
	jr	r31				#
ble_then.18420:
	lw	r5, 3(r2)
	add	r30, r5, r1
	lw	r5, 0(r30)
	sw	r1, 5(r3)
	beqi	0, r5, beq_then.18422
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
	lw	r29, 1(r3)
	sw	r8, 6(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r1, r0, 10740
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 10737
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	vecaccumv.3033				#	bl	vecaccumv.3033
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	beq_cont.18423
beq_then.18422:
beq_cont.18423:
	lw	r1, 5(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
neighbors_exist.3352:
	addi	r5, r0, 10743
	lw	r5, 1(r5)
	addi	r6, r2, 1
	ble	r5, r6, ble_then.18424
	blei	0, r2, ble_then.18425
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.18426
	blei	0, r1, ble_then.18427
	addi	r1, r0, 1
	jr	r31				#
ble_then.18427:
	addi	r1, r0, 0
	jr	r31				#
ble_then.18426:
	addi	r1, r0, 0
	jr	r31				#
ble_then.18425:
	addi	r1, r0, 0
	jr	r31				#
ble_then.18424:
	addi	r1, r0, 0
	jr	r31				#
get_surface_id.3356:
	lw	r1, 2(r1)
	add	r30, r1, r2
	lw	r1, 0(r30)
	jr	r31				#
neighbors_are_available.3359:
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
	beq	r2, r8, beq_then.18428
	addi	r1, r0, 0
	jr	r31				#
beq_then.18428:
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.18429
	addi	r1, r0, 0
	jr	r31				#
beq_then.18429:
	addi	r2, r1, -1
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.18430
	addi	r1, r0, 0
	jr	r31				#
beq_then.18430:
	addi	r1, r1, 1
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beq	r1, r8, beq_then.18431
	addi	r1, r0, 0
	jr	r31				#
beq_then.18431:
	addi	r1, r0, 1
	jr	r31				#
try_exploit_neighbors.3365:
	lw	r9, 2(r29)
	lw	r10, 1(r29)
	add	r30, r6, r1
	lw	r11, 0(r30)
	blei	4, r8, ble_then.18432
	jr	r31				#
ble_then.18432:
	addi	r12, r0, 0
	lw	r13, 2(r11)
	add	r30, r13, r8
	lw	r13, 0(r30)
	ble	r12, r13, ble_then.18434
	jr	r31				#
ble_then.18434:
	add	r30, r6, r1
	lw	r12, 0(r30)
	lw	r12, 2(r12)
	add	r30, r12, r8
	lw	r12, 0(r30)
	add	r30, r5, r1
	lw	r13, 0(r30)
	lw	r13, 2(r13)
	add	r30, r13, r8
	lw	r13, 0(r30)
	beq	r13, r12, beq_then.18436
	addi	r12, r0, 0
	j	beq_cont.18437
beq_then.18436:
	add	r30, r7, r1
	lw	r13, 0(r30)
	lw	r13, 2(r13)
	add	r30, r13, r8
	lw	r13, 0(r30)
	beq	r13, r12, beq_then.18438
	addi	r12, r0, 0
	j	beq_cont.18439
beq_then.18438:
	addi	r13, r1, -1
	add	r30, r6, r13
	lw	r13, 0(r30)
	lw	r13, 2(r13)
	add	r30, r13, r8
	lw	r13, 0(r30)
	beq	r13, r12, beq_then.18440
	addi	r12, r0, 0
	j	beq_cont.18441
beq_then.18440:
	addi	r13, r1, 1
	add	r30, r6, r13
	lw	r13, 0(r30)
	lw	r13, 2(r13)
	add	r30, r13, r8
	lw	r13, 0(r30)
	beq	r13, r12, beq_then.18442
	addi	r12, r0, 0
	j	beq_cont.18443
beq_then.18442:
	addi	r12, r0, 1
beq_cont.18443:
beq_cont.18441:
beq_cont.18439:
beq_cont.18437:
	beqi	0, r12, beq_then.18444
	lw	r9, 3(r11)
	add	r30, r9, r8
	lw	r9, 0(r30)
	sw	r2, 0(r3)
	sw	r29, 1(r3)
	sw	r10, 2(r3)
	sw	r7, 3(r3)
	sw	r5, 4(r3)
	sw	r1, 5(r3)
	sw	r6, 6(r3)
	sw	r8, 7(r3)
	beqi	0, r9, beq_then.18445
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r8				# mr	r7, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	calc_diffuse_using_5points.3343				#	bl	calc_diffuse_using_5points.3343
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.18446
beq_then.18445:
beq_cont.18446:
	lw	r1, 7(r3)
	addi	r2, r1, 1
	lw	r1, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r1
	lw	r6, 0(r30)
	blei	4, r2, ble_then.18447
	jr	r31				#
ble_then.18447:
	addi	r7, r0, 0
	lw	r8, 2(r6)
	add	r30, r8, r2
	lw	r8, 0(r30)
	ble	r7, r8, ble_then.18449
	jr	r31				#
ble_then.18449:
	add	r30, r5, r1
	lw	r7, 0(r30)
	lw	r7, 2(r7)
	add	r30, r7, r2
	lw	r7, 0(r30)
	lw	r8, 4(r3)
	add	r30, r8, r1
	lw	r9, 0(r30)
	lw	r9, 2(r9)
	add	r30, r9, r2
	lw	r9, 0(r30)
	beq	r9, r7, beq_then.18451
	addi	r7, r0, 0
	j	beq_cont.18452
beq_then.18451:
	lw	r9, 3(r3)
	add	r30, r9, r1
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.18453
	addi	r7, r0, 0
	j	beq_cont.18454
beq_then.18453:
	addi	r10, r1, -1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.18455
	addi	r7, r0, 0
	j	beq_cont.18456
beq_then.18455:
	addi	r10, r1, 1
	add	r30, r5, r10
	lw	r10, 0(r30)
	lw	r10, 2(r10)
	add	r30, r10, r2
	lw	r10, 0(r30)
	beq	r10, r7, beq_then.18457
	addi	r7, r0, 0
	j	beq_cont.18458
beq_then.18457:
	addi	r7, r0, 1
beq_cont.18458:
beq_cont.18456:
beq_cont.18454:
beq_cont.18452:
	beqi	0, r7, beq_then.18459
	lw	r6, 3(r6)
	add	r30, r6, r2
	lw	r6, 0(r30)
	sw	r2, 8(r3)
	beqi	0, r6, beq_then.18460
	lw	r6, 3(r3)
	add	r7, r0, r2				# mr	r7, r2
	add	r2, r0, r8				# mr	r2, r8
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	calc_diffuse_using_5points.3343				#	bl	calc_diffuse_using_5points.3343
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.18461
beq_then.18460:
beq_cont.18461:
	lw	r1, 8(r3)
	addi	r8, r1, 1
	lw	r1, 5(r3)
	lw	r2, 0(r3)
	lw	r5, 4(r3)
	lw	r6, 6(r3)
	lw	r7, 3(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18459:
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.18444:
	add	r30, r6, r1
	lw	r1, 0(r30)
	blei	4, r8, ble_then.18462
	jr	r31				#
ble_then.18462:
	lw	r2, 2(r1)
	addi	r5, r0, 0
	add	r30, r2, r8
	lw	r2, 0(r30)
	ble	r5, r2, ble_then.18464
	jr	r31				#
ble_then.18464:
	lw	r2, 3(r1)
	add	r30, r2, r8
	lw	r2, 0(r30)
	sw	r1, 9(r3)
	sw	r10, 2(r3)
	sw	r8, 7(r3)
	beqi	0, r2, beq_then.18466
	lw	r2, 5(r1)
	lw	r5, 7(r1)
	lw	r6, 1(r1)
	lw	r7, 4(r1)
	addi	r11, r0, 10737
	add	r30, r2, r8
	lw	r2, 0(r30)
	flw	f1, 0(r2)
	fsw	f1, 0(r11)
	flw	f1, 1(r2)
	fsw	f1, 1(r11)
	flw	f1, 2(r2)
	fsw	f1, 2(r11)
	lw	r2, 6(r1)
	lw	r2, 0(r2)
	add	r30, r5, r8
	lw	r5, 0(r30)
	add	r30, r6, r8
	lw	r6, 0(r30)
	sw	r7, 10(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r29, r0, r9				# mr	r29, r9
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r1, r0, 10740
	lw	r2, 7(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	addi	r6, r0, 10737
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	vecaccumv.3033				#	bl	vecaccumv.3033
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.18467
beq_then.18466:
beq_cont.18467:
	lw	r1, 7(r3)
	addi	r2, r1, 1
	lw	r1, 9(r3)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
write_ppm_header.3372:
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
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 255
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
write_rgb_element.3374:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18468
	addi	r1, r0, 0
	j	feq_cont.18469
feq_else.18468:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18470
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.18471
fle_else.18470:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.18471:
feq_cont.18469:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.18472
	addi	r1, r0, 255
	j	ble_cont.18473
ble_then.18472:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18474
	addi	r1, r0, 0
	j	ble_cont.18475
ble_then.18474:
ble_cont.18475:
ble_cont.18473:
	j	print_int.2956
write_rgb.3376:
	addi	r1, r0, 10740
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18476
	addi	r1, r0, 0
	j	feq_cont.18477
feq_else.18476:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18478
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.18479
fle_else.18478:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.18479:
feq_cont.18477:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.18480
	addi	r1, r0, 255
	j	ble_cont.18481
ble_then.18480:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18482
	addi	r1, r0, 0
	j	ble_cont.18483
ble_then.18482:
ble_cont.18483:
ble_cont.18481:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10740
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18484
	addi	r1, r0, 0
	j	feq_cont.18485
feq_else.18484:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18486
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.18487
fle_else.18486:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.18487:
feq_cont.18485:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.18488
	addi	r1, r0, 255
	j	ble_cont.18489
ble_then.18488:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18490
	addi	r1, r0, 0
	j	ble_cont.18491
ble_then.18490:
ble_cont.18491:
ble_cont.18489:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10740
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18492
	addi	r1, r0, 0
	j	feq_cont.18493
feq_else.18492:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18494
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.18495
fle_else.18494:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.18495:
feq_cont.18493:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.18496
	addi	r1, r0, 255
	j	ble_cont.18497
ble_then.18496:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18498
	addi	r1, r0, 0
	j	ble_cont.18499
ble_then.18498:
ble_cont.18499:
ble_cont.18497:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
pretrace_diffuse_rays.3378:
	lw	r5, 1(r29)
	blei	4, r2, ble_then.18500
	jr	r31				#
ble_then.18500:
	lw	r6, 2(r1)
	add	r30, r6, r2
	lw	r6, 0(r30)
	addi	r7, r0, 0
	ble	r7, r6, ble_then.18502
	jr	r31				#
ble_then.18502:
	lw	r6, 3(r1)
	add	r30, r6, r2
	lw	r6, 0(r30)
	sw	r29, 0(r3)
	sw	r2, 1(r3)
	beqi	0, r6, beq_then.18504
	lw	r6, 6(r1)
	lw	r6, 0(r6)
	addi	r7, r0, 10737
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r7)
	fsw	f1, 1(r7)
	fsw	f1, 2(r7)
	lw	r7, 7(r1)
	lw	r8, 1(r1)
	addi	r9, r0, 10766
	add	r30, r9, r6
	lw	r6, 0(r30)
	add	r30, r7, r2
	lw	r7, 0(r30)
	add	r30, r8, r2
	lw	r8, 0(r30)
	addi	r9, r0, 10751
	flw	f1, 0(r8)
	fsw	f1, 0(r9)
	flw	f1, 1(r8)
	fsw	f1, 1(r9)
	flw	f1, 2(r8)
	fsw	f1, 2(r9)
	addi	r9, r0, 10000
	lw	r9, 0(r9)
	addi	r9, r9, -1
	sw	r1, 2(r3)
	sw	r8, 3(r3)
	sw	r7, 4(r3)
	sw	r6, 5(r3)
	sw	r5, 6(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_startp_constants.3229				#	bl	setup_startp_constants.3229
	addi	r3, r3, -8
	lw	r31, 7(r3)
	addi	r6, r0, 118
	lw	r1, 5(r3)
	lw	r2, 4(r3)
	lw	r5, 3(r3)
	lw	r29, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 2(r3)
	lw	r2, 5(r1)
	lw	r5, 1(r3)
	add	r30, r2, r5
	lw	r2, 0(r30)
	addi	r6, r0, 10737
	flw	f1, 0(r6)
	fsw	f1, 0(r2)
	flw	f1, 1(r6)
	fsw	f1, 1(r2)
	flw	f1, 2(r6)
	fsw	f1, 2(r2)
	j	beq_cont.18505
beq_then.18504:
beq_cont.18505:
	lw	r2, 1(r3)
	addi	r2, r2, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_pixels.3381:
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	addi	r9, r0, 0
	ble	r9, r2, ble_then.18506
	jr	r31				#
ble_then.18506:
	addi	r9, r0, 10747
	flw	f4, 0(r9)
	addi	r9, r0, 10745
	lw	r9, 0(r9)
	sub	r9, r2, r9
	itof	f5, r9
	fmul	f4, f4, f5
	addi	r9, r0, 10763
	addi	r10, r0, 10754
	flw	f5, 0(r10)
	fmul	f5, f4, f5
	fadd	f5, f5, f1
	fsw	f5, 0(r9)
	addi	r9, r0, 10763
	addi	r10, r0, 10754
	flw	f5, 1(r10)
	fmul	f5, f4, f5
	fadd	f5, f5, f2
	fsw	f5, 1(r9)
	addi	r9, r0, 10763
	addi	r10, r0, 10754
	flw	f5, 2(r10)
	fmul	f4, f4, f5
	fadd	f4, f4, f3
	fsw	f4, 2(r9)
	addi	r9, r0, 10763
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r29, 6(r3)
	sw	r7, 7(r3)
	sw	r5, 8(r3)
	sw	r6, 9(r3)
	sw	r2, 10(r3)
	sw	r1, 11(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	vecunit_sgn.3009				#	bl	vecunit_sgn.3009
	addi	r3, r3, -13
	lw	r31, 12(r3)
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
	lw	r5, 10(r3)
	lw	r6, 11(r3)
	add	r30, r6, r5
	lw	r7, 0(r30)
	flup	f2, 0		# fli	f2, 0.000000
	lw	r29, 9(r3)
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 10(r3)
	lw	r2, 11(r3)
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
	lw	r6, 8(r3)
	sw	r6, 0(r5)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r7, r0, 0
	lw	r29, 7(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 10(r3)
	addi	r2, r1, -1
	lw	r1, 8(r3)
	addi	r1, r1, 1
	addi	r5, r0, 5
	ble	r5, r1, ble_then.18508
	add	r5, r0, r1
	j	ble_cont.18509
ble_then.18508:
	addi	r5, r1, -5
ble_cont.18509:
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r1, 11(r3)
	lw	r29, 6(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_line.3388:
	lw	r29, 1(r29)
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
	lw	r28, 0(r29)
	jr	r28
scan_pixel.3392:
	lw	r8, 3(r29)
	lw	r9, 2(r29)
	lw	r10, 1(r29)
	addi	r11, r0, 10743
	lw	r11, 0(r11)
	ble	r11, r1, ble_then.18510
	addi	r11, r0, 10740
	add	r30, r6, r1
	lw	r12, 0(r30)
	lw	r12, 0(r12)
	flw	f1, 0(r12)
	fsw	f1, 0(r11)
	flw	f1, 1(r12)
	fsw	f1, 1(r11)
	flw	f1, 2(r12)
	fsw	f1, 2(r11)
	addi	r11, r0, 10743
	lw	r11, 1(r11)
	addi	r12, r2, 1
	ble	r11, r12, ble_then.18511
	blei	0, r2, ble_then.18513
	addi	r11, r0, 10743
	lw	r11, 0(r11)
	addi	r12, r1, 1
	ble	r11, r12, ble_then.18515
	blei	0, r1, ble_then.18517
	addi	r11, r0, 1
	j	ble_cont.18518
ble_then.18517:
	addi	r11, r0, 0
ble_cont.18518:
	j	ble_cont.18516
ble_then.18515:
	addi	r11, r0, 0
ble_cont.18516:
	j	ble_cont.18514
ble_then.18513:
	addi	r11, r0, 0
ble_cont.18514:
	j	ble_cont.18512
ble_then.18511:
	addi	r11, r0, 0
ble_cont.18512:
	sw	r29, 0(r3)
	sw	r7, 1(r3)
	sw	r5, 2(r3)
	sw	r8, 3(r3)
	sw	r10, 4(r3)
	sw	r2, 5(r3)
	sw	r6, 6(r3)
	sw	r1, 7(r3)
	beqi	0, r11, beq_then.18519
	addi	r9, r0, 0
	add	r30, r6, r1
	lw	r11, 0(r30)
	addi	r12, r0, 0
	lw	r13, 2(r11)
	lw	r13, 0(r13)
	ble	r12, r13, ble_then.18521
	j	ble_cont.18522
ble_then.18521:
	add	r30, r6, r1
	lw	r12, 0(r30)
	lw	r12, 2(r12)
	lw	r12, 0(r12)
	add	r30, r5, r1
	lw	r13, 0(r30)
	lw	r13, 2(r13)
	lw	r13, 0(r13)
	beq	r13, r12, beq_then.18523
	addi	r12, r0, 0
	j	beq_cont.18524
beq_then.18523:
	add	r30, r7, r1
	lw	r13, 0(r30)
	lw	r13, 2(r13)
	lw	r13, 0(r13)
	beq	r13, r12, beq_then.18525
	addi	r12, r0, 0
	j	beq_cont.18526
beq_then.18525:
	addi	r13, r1, -1
	add	r30, r6, r13
	lw	r13, 0(r30)
	lw	r13, 2(r13)
	lw	r13, 0(r13)
	beq	r13, r12, beq_then.18527
	addi	r12, r0, 0
	j	beq_cont.18528
beq_then.18527:
	addi	r13, r1, 1
	add	r30, r6, r13
	lw	r13, 0(r30)
	lw	r13, 2(r13)
	lw	r13, 0(r13)
	beq	r13, r12, beq_then.18529
	addi	r12, r0, 0
	j	beq_cont.18530
beq_then.18529:
	addi	r12, r0, 1
beq_cont.18530:
beq_cont.18528:
beq_cont.18526:
beq_cont.18524:
	beqi	0, r12, beq_then.18531
	lw	r11, 3(r11)
	lw	r11, 0(r11)
	beqi	0, r11, beq_then.18533
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r9				# mr	r7, r9
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	calc_diffuse_using_5points.3343				#	bl	calc_diffuse_using_5points.3343
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.18534
beq_then.18533:
beq_cont.18534:
	addi	r8, r0, 1
	lw	r1, 7(r3)
	lw	r2, 5(r3)
	lw	r5, 2(r3)
	lw	r6, 6(r3)
	lw	r7, 1(r3)
	lw	r29, 3(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.18532
beq_then.18531:
	add	r30, r6, r1
	lw	r11, 0(r30)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r11				# mr	r1, r11
	add	r29, r0, r10				# mr	r29, r10
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.18532:
ble_cont.18522:
	j	beq_cont.18520
beq_then.18519:
	add	r30, r6, r1
	lw	r11, 0(r30)
	lw	r12, 2(r11)
	addi	r13, r0, 0
	lw	r12, 0(r12)
	ble	r13, r12, ble_then.18535
	j	ble_cont.18536
ble_then.18535:
	lw	r12, 3(r11)
	lw	r12, 0(r12)
	sw	r11, 8(r3)
	beqi	0, r12, beq_then.18537
	lw	r12, 5(r11)
	lw	r13, 7(r11)
	lw	r14, 1(r11)
	lw	r15, 4(r11)
	addi	r16, r0, 10737
	lw	r12, 0(r12)
	flw	f1, 0(r12)
	fsw	f1, 0(r16)
	flw	f1, 1(r12)
	fsw	f1, 1(r16)
	flw	f1, 2(r12)
	fsw	f1, 2(r16)
	lw	r12, 6(r11)
	lw	r12, 0(r12)
	lw	r13, 0(r13)
	lw	r14, 0(r14)
	sw	r15, 9(r3)
	add	r5, r0, r14				# mr	r5, r14
	add	r2, r0, r13				# mr	r2, r13
	add	r1, r0, r12				# mr	r1, r12
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r1, r0, 10740
	lw	r2, 9(r3)
	lw	r2, 0(r2)
	addi	r5, r0, 10737
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	vecaccumv.3033				#	bl	vecaccumv.3033
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.18538
beq_then.18537:
beq_cont.18538:
	addi	r2, r0, 1
	lw	r1, 8(r3)
	lw	r29, 4(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
ble_cont.18536:
beq_cont.18520:
	addi	r1, r0, 10740
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18539
	addi	r1, r0, 0
	j	feq_cont.18540
feq_else.18539:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18541
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.18542
fle_else.18541:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.18542:
feq_cont.18540:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.18543
	addi	r1, r0, 255
	j	ble_cont.18544
ble_then.18543:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18545
	addi	r1, r0, 0
	j	ble_cont.18546
ble_then.18545:
ble_cont.18546:
ble_cont.18544:
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10740
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18547
	addi	r1, r0, 0
	j	feq_cont.18548
feq_else.18547:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18549
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.18550
fle_else.18549:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.18550:
feq_cont.18548:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.18551
	addi	r1, r0, 255
	j	ble_cont.18552
ble_then.18551:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18553
	addi	r1, r0, 0
	j	ble_cont.18554
ble_then.18553:
ble_cont.18554:
ble_cont.18552:
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10740
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.18555
	addi	r1, r0, 0
	j	feq_cont.18556
feq_else.18555:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.18557
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.18558
fle_else.18557:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.18558:
feq_cont.18556:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.18559
	addi	r1, r0, 255
	j	ble_cont.18560
ble_then.18559:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18561
	addi	r1, r0, 0
	j	ble_cont.18562
ble_then.18561:
ble_cont.18562:
ble_cont.18560:
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r1, r0, 10
	out	r1
	lw	r1, 7(r3)
	addi	r1, r1, 1
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	ble	r2, r1, ble_then.18563
	addi	r2, r0, 10740
	lw	r6, 6(r3)
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
	lw	r5, 5(r3)
	addi	r7, r5, 1
	ble	r2, r7, ble_then.18564
	blei	0, r5, ble_then.18566
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r7, r1, 1
	ble	r2, r7, ble_then.18568
	blei	0, r1, ble_then.18570
	addi	r2, r0, 1
	j	ble_cont.18571
ble_then.18570:
	addi	r2, r0, 0
ble_cont.18571:
	j	ble_cont.18569
ble_then.18568:
	addi	r2, r0, 0
ble_cont.18569:
	j	ble_cont.18567
ble_then.18566:
	addi	r2, r0, 0
ble_cont.18567:
	j	ble_cont.18565
ble_then.18564:
	addi	r2, r0, 0
ble_cont.18565:
	sw	r1, 10(r3)
	beqi	0, r2, beq_then.18572
	addi	r8, r0, 0
	lw	r2, 2(r3)
	lw	r7, 1(r3)
	lw	r29, 3(r3)
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r28				# mr	r2, r28
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.18573
beq_then.18572:
	add	r30, r6, r1
	lw	r2, 0(r30)
	addi	r7, r0, 0
	lw	r29, 4(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r7				# mr	r2, r7
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
beq_cont.18573:
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	write_rgb.3376				#	bl	write_rgb.3376
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 10(r3)
	addi	r1, r1, 1
	lw	r2, 5(r3)
	lw	r5, 2(r3)
	lw	r6, 6(r3)
	lw	r7, 1(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
ble_then.18563:
	jr	r31				#
ble_then.18510:
	jr	r31				#
scan_line.3398:
	lw	r8, 4(r29)
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	addi	r12, r0, 10743
	lw	r12, 1(r12)
	ble	r12, r1, ble_then.18576
	addi	r12, r0, 10743
	lw	r12, 1(r12)
	addi	r12, r12, -1
	sw	r29, 0(r3)
	sw	r10, 1(r3)
	sw	r7, 2(r3)
	sw	r9, 3(r3)
	sw	r6, 4(r3)
	sw	r2, 5(r3)
	sw	r8, 6(r3)
	sw	r11, 7(r3)
	sw	r1, 8(r3)
	sw	r5, 9(r3)
	ble	r12, r1, ble_then.18577
	addi	r12, r1, 1
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r12				# mr	r2, r12
	add	r1, r0, r6				# mr	r1, r6
	add	r29, r0, r10				# mr	r29, r10
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	ble_cont.18578
ble_then.18577:
ble_cont.18578:
	addi	r1, r0, 0
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	blei	0, r2, ble_then.18579
	addi	r2, r0, 10740
	lw	r6, 9(r3)
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
	lw	r5, 8(r3)
	addi	r7, r5, 1
	ble	r2, r7, ble_then.18581
	blei	0, r5, ble_then.18583
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	blei	1, r2, ble_then.18585
	addi	r2, r0, 0
	j	ble_cont.18586
ble_then.18585:
	addi	r2, r0, 0
ble_cont.18586:
	j	ble_cont.18584
ble_then.18583:
	addi	r2, r0, 0
ble_cont.18584:
	j	ble_cont.18582
ble_then.18581:
	addi	r2, r0, 0
ble_cont.18582:
	beqi	0, r2, beq_then.18587
	addi	r8, r0, 0
	lw	r2, 5(r3)
	lw	r7, 4(r3)
	lw	r29, 6(r3)
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r28				# mr	r2, r28
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.18588
beq_then.18587:
	lw	r1, 0(r6)
	addi	r2, r0, 0
	lw	r29, 7(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
beq_cont.18588:
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	write_rgb.3376				#	bl	write_rgb.3376
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r1, r0, 1
	lw	r2, 8(r3)
	lw	r5, 5(r3)
	lw	r6, 9(r3)
	lw	r7, 4(r3)
	lw	r29, 3(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	ble_cont.18580
ble_then.18579:
ble_cont.18580:
	lw	r1, 8(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	addi	r1, r1, 2
	addi	r5, r0, 5
	ble	r5, r1, ble_then.18589
	add	r5, r0, r1
	j	ble_cont.18590
ble_then.18589:
	addi	r5, r1, -5
ble_cont.18590:
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	ble	r1, r2, ble_then.18591
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r5, 10(r3)
	sw	r2, 11(r3)
	ble	r1, r2, ble_then.18593
	addi	r1, r2, 1
	lw	r6, 5(r3)
	lw	r29, 1(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.18594
ble_then.18593:
ble_cont.18594:
	addi	r1, r0, 0
	lw	r2, 11(r3)
	lw	r5, 9(r3)
	lw	r6, 4(r3)
	lw	r7, 5(r3)
	lw	r29, 3(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 11(r3)
	addi	r1, r1, 1
	lw	r2, 10(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5
	ble	r5, r2, ble_then.18595
	add	r7, r0, r2
	j	ble_cont.18596
ble_then.18595:
	addi	r7, r2, -5
ble_cont.18596:
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	lw	r6, 9(r3)
	lw	r29, 0(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	ble_cont.18592
ble_then.18591:
ble_cont.18592:
	jr	r31				#
ble_then.18576:
	jr	r31				#
create_float5x3array.3404:
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
create_pixel.3406:
	lw	r1, 1(r29)
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
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
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
	lw	r5, 0(r3)
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
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -6
	lw	r31, 5(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
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
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
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
	add	r1, r0, r2
	jr	r31				#
init_line_elements.3408:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.18599
	jr	r31				#
ble_then.18599:
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r29, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -6
	lw	r31, 5(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r2, r0, 5
	lw	r5, 3(r3)
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
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -9
	lw	r31, 8(r3)
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 9(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -11
	lw	r31, 10(r3)
	sw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 10(r3)
	sw	r1, 6(r2)
	lw	r1, 9(r3)
	sw	r1, 5(r2)
	lw	r1, 8(r3)
	sw	r1, 4(r2)
	lw	r1, 7(r3)
	sw	r1, 3(r2)
	lw	r1, 6(r3)
	sw	r1, 2(r2)
	lw	r1, 5(r3)
	sw	r1, 1(r2)
	lw	r1, 4(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18600
	add	r1, r0, r5
	jr	r31				#
ble_then.18600:
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 11(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -13
	lw	r31, 12(r3)
	sw	r1, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 13(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r2, r0, 5
	lw	r5, 3(r3)
	sw	r1, 14(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -16
	lw	r31, 15(r3)
	sw	r1, 15(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -17
	lw	r31, 16(r3)
	sw	r1, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -18
	lw	r31, 17(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 17(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -19
	lw	r31, 18(r3)
	sw	r1, 18(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -20
	lw	r31, 19(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 18(r3)
	sw	r1, 6(r2)
	lw	r1, 17(r3)
	sw	r1, 5(r2)
	lw	r1, 16(r3)
	sw	r1, 4(r2)
	lw	r1, 15(r3)
	sw	r1, 3(r2)
	lw	r1, 14(r3)
	sw	r1, 2(r2)
	lw	r1, 13(r3)
	sw	r1, 1(r2)
	lw	r1, 12(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 11(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r28, 0(r29)
	jr	r28
create_pixelline.3411:
	lw	r1, 2(r29)
	lw	r2, 1(r29)
	addi	r5, r0, 10743
	lw	r5, 0(r5)
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
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
	addi	r2, r0, 5
	lw	r5, 2(r3)
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
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -8
	lw	r31, 7(r3)
	sw	r1, 7(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -9
	lw	r31, 8(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 8(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
	sw	r1, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -11
	lw	r31, 10(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 9(r3)
	sw	r1, 6(r2)
	lw	r1, 8(r3)
	sw	r1, 5(r2)
	lw	r1, 7(r3)
	sw	r1, 4(r2)
	lw	r1, 6(r3)
	sw	r1, 3(r2)
	lw	r1, 5(r3)
	sw	r1, 2(r2)
	lw	r1, 4(r3)
	sw	r1, 1(r2)
	lw	r1, 3(r3)
	sw	r1, 0(r2)
	lw	r1, 1(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r2, r2, -2
	addi	r5, r0, 0
	ble	r5, r2, ble_then.18601
	jr	r31				#
ble_then.18601:
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 10(r3)
	sw	r1, 11(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -13
	lw	r31, 12(r3)
	sw	r1, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 13(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r2, r0, 5
	lw	r5, 2(r3)
	sw	r1, 14(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -16
	lw	r31, 15(r3)
	sw	r1, 15(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -17
	lw	r31, 16(r3)
	sw	r1, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -18
	lw	r31, 17(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 17(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -19
	lw	r31, 18(r3)
	sw	r1, 18(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -20
	lw	r31, 19(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 18(r3)
	sw	r1, 6(r2)
	lw	r1, 17(r3)
	sw	r1, 5(r2)
	lw	r1, 16(r3)
	sw	r1, 4(r2)
	lw	r1, 15(r3)
	sw	r1, 3(r2)
	lw	r1, 14(r3)
	sw	r1, 2(r2)
	lw	r1, 13(r3)
	sw	r1, 1(r2)
	lw	r1, 12(r3)
	sw	r1, 0(r2)
	add	r1, r0, r2
	lw	r2, 10(r3)
	lw	r5, 11(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r28, 0(r29)
	jr	r28
tan.3413:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	sin.2922				#	bl	sin.2922
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f2, 0(r3)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	cos.2924				#	bl	cos.2924
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fdiv	f1, f2, f1
	jr	r31				#
adjust_position.3415:
	fmul	f1, f1, f1
	flup	f3, 45		# fli	f3, 0.100000
	fadd	f1, f1, f3
	fsqrt	f1, f1
	flup	f3, 2		# fli	f3, 1.000000
	fdiv	f3, f3, f1
	fle	r30, f0, f3
	beq	r0, r30, fle_else.18602
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.18603
fle_else.18602:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.18603:
	fmul	f3, f3, f4
	flup	f5, 23		# fli	f5, 4.375000
	fsw	f1, 0(r3)
	fsw	f2, 2(r3)
	fle	r30, f5, f3
	beq	r0, r30, fle_else.18604
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f3
	beq	r0, r30, fle_else.18606
	flup	f5, 15		# fli	f5, 1.570796
	flup	f6, 2		# fli	f6, 1.000000
	fdiv	f3, f6, f3
	fsw	f4, 4(r3)
	fsw	f5, 6(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	j	fle_cont.18607
fle_else.18606:
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
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	flw	f2, 4(r3)
	fmul	f1, f1, f2
fle_cont.18607:
	j	fle_cont.18605
fle_else.18604:
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -11
	lw	r31, 10(r3)
fle_cont.18605:
	flw	f2, 2(r3)
	fmul	f1, f1, f2
	fsw	f1, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2922				#	bl	sin.2922
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fsw	f1, 12(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	cos.2924				#	bl	cos.2924
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fdiv	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
calc_dirvec.3418:
	addi	r6, r0, 5
	ble	r6, r1, ble_then.18608
	fmul	f1, f2, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f1, f1, f2
	fsqrt	f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f2, f2, f1
	fle	r30, f0, f2
	beq	r0, r30, fle_else.18609
	flup	f5, 2		# fli	f5, 1.000000
	j	fle_cont.18610
fle_else.18609:
	flup	f5, 11		# fli	f5, -1.000000
fle_cont.18610:
	fmul	f2, f2, f5
	flup	f6, 23		# fli	f6, 4.375000
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	fsw	f4, 2(r3)
	sw	r1, 4(r3)
	fsw	f1, 6(r3)
	fsw	f3, 8(r3)
	fle	r30, f6, f2
	beq	r0, r30, fle_else.18612
	flup	f6, 24		# fli	f6, 2.437500
	fle	r30, f6, f2
	beq	r0, r30, fle_else.18614
	flup	f6, 15		# fli	f6, 1.570796
	flup	f7, 2		# fli	f7, 1.000000
	fdiv	f2, f7, f2
	fsw	f5, 10(r3)
	fsw	f6, 12(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fadd	f1, f2, f1
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	j	fle_cont.18615
fle_else.18614:
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
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fadd	f1, f2, f1
	flw	f2, 10(r3)
	fmul	f1, f1, f2
fle_cont.18615:
	j	fle_cont.18613
fle_else.18612:
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -17
	lw	r31, 16(r3)
fle_cont.18613:
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	fsw	f1, 16(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	sin.2922				#	bl	sin.2922
	addi	r3, r3, -19
	lw	r31, 18(r3)
	flw	f2, 16(r3)
	fsw	f1, 18(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	cos.2924				#	bl	cos.2924
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
	beq	r0, r30, fle_else.18616
	flup	f4, 2		# fli	f4, 1.000000
	j	fle_cont.18617
fle_else.18616:
	flup	f4, 11		# fli	f4, -1.000000
fle_cont.18617:
	fmul	f3, f3, f4
	flup	f5, 23		# fli	f5, 4.375000
	fsw	f1, 20(r3)
	sw	r1, 22(r3)
	fsw	f2, 24(r3)
	fle	r30, f5, f3
	beq	r0, r30, fle_else.18619
	flup	f5, 24		# fli	f5, 2.437500
	fle	r30, f5, f3
	beq	r0, r30, fle_else.18621
	flup	f5, 15		# fli	f5, 1.570796
	flup	f6, 2		# fli	f6, 1.000000
	fdiv	f3, f6, f3
	fsw	f4, 26(r3)
	fsw	f5, 28(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -31
	lw	r31, 30(r3)
	flw	f2, 28(r3)
	fadd	f1, f2, f1
	flw	f2, 26(r3)
	fmul	f1, f1, f2
	j	fle_cont.18622
fle_else.18621:
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
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -33
	lw	r31, 32(r3)
	flw	f2, 30(r3)
	fadd	f1, f2, f1
	flw	f2, 26(r3)
	fmul	f1, f1, f2
fle_cont.18622:
	j	fle_cont.18620
fle_else.18619:
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	atan_body.2926				#	bl	atan_body.2926
	addi	r3, r3, -33
	lw	r31, 32(r3)
fle_cont.18620:
	flw	f2, 2(r3)
	fmul	f1, f1, f2
	fsw	f1, 32(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	sin.2922				#	bl	sin.2922
	addi	r3, r3, -35
	lw	r31, 34(r3)
	flw	f2, 32(r3)
	fsw	f1, 34(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	cos.2924				#	bl	cos.2924
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
	j	calc_dirvec.3418
ble_then.18608:
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
calc_dirvecs.3426:
	addi	r6, r0, 0
	ble	r6, r1, ble_then.18624
	jr	r31				#
ble_then.18624:
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
	jal	calc_dirvec.3418				#	bl	calc_dirvec.3418
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
	jal	calc_dirvec.3418				#	bl	calc_dirvec.3418
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r1, r1, -1
	lw	r2, 2(r3)
	addi	r2, r2, 1
	addi	r5, r0, 5
	ble	r5, r2, ble_then.18626
	j	ble_cont.18627
ble_then.18626:
	addi	r2, r2, -5
ble_cont.18627:
	flw	f1, 0(r3)
	lw	r5, 3(r3)
	j	calc_dirvecs.3426
calc_dirvec_rows.3431:
	addi	r6, r0, 0
	ble	r6, r1, ble_then.18628
	jr	r31				#
ble_then.18628:
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
	jal	calc_dirvecs.3426				#	bl	calc_dirvecs.3426
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r1, r1, -1
	lw	r2, 1(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5
	ble	r5, r2, ble_then.18630
	j	ble_cont.18631
ble_then.18630:
	addi	r2, r2, -5
ble_cont.18631:
	lw	r5, 0(r3)
	addi	r5, r5, 4
	addi	r6, r0, 0
	ble	r6, r1, ble_then.18632
	jr	r31				#
ble_then.18632:
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
	jal	calc_dirvecs.3426				#	bl	calc_dirvecs.3426
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 5(r3)
	addi	r1, r1, -1
	lw	r2, 4(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5
	ble	r5, r2, ble_then.18634
	j	ble_cont.18635
ble_then.18634:
	addi	r2, r2, -5
ble_cont.18635:
	lw	r5, 3(r3)
	addi	r5, r5, 4
	j	calc_dirvec_rows.3431
create_dirvec.3435:
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
create_dirvec_elements.3437:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.18636
	jr	r31				#
ble_then.18636:
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
	ble	r2, r1, ble_then.18638
	jr	r31				#
ble_then.18638:
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
	ble	r2, r1, ble_then.18640
	jr	r31				#
ble_then.18640:
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
	ble	r2, r1, ble_then.18642
	jr	r31				#
ble_then.18642:
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
	j	create_dirvec_elements.3437
create_dirvecs.3440:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18644
	jr	r31				#
ble_then.18644:
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
	jal	create_dirvec_elements.3437				#	bl	create_dirvec_elements.3437
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18646
	jr	r31				#
ble_then.18646:
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
	jal	create_dirvec_elements.3437				#	bl	create_dirvec_elements.3437
	addi	r3, r3, -16
	lw	r31, 15(r3)
	lw	r1, 8(r3)
	addi	r1, r1, -1
	j	create_dirvecs.3440
init_dirvec_constants.3442:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.18648
	jr	r31				#
ble_then.18648:
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
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18650
	jr	r31				#
ble_then.18650:
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 10000
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r1, 2(r3)
	ble	r7, r6, ble_then.18652
	j	ble_cont.18653
ble_then.18652:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 3(r3)
	beqi	1, r10, beq_then.18654
	beqi	2, r10, beq_then.18656
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18657
beq_then.18656:
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18657:
	j	beq_cont.18655
beq_then.18654:
	sw	r6, 4(r3)
	sw	r8, 5(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18655:
	addi	r2, r2, -1
	lw	r1, 3(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -7
	lw	r31, 6(r3)
ble_cont.18653:
	lw	r1, 2(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18658
	jr	r31				#
ble_then.18658:
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
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18660
	jr	r31				#
ble_then.18660:
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 10000
	lw	r6, 0(r6)
	addi	r6, r6, -1
	addi	r7, r0, 0
	sw	r1, 7(r3)
	ble	r7, r6, ble_then.18662
	j	ble_cont.18663
ble_then.18662:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 8(r3)
	beqi	1, r10, beq_then.18664
	beqi	2, r10, beq_then.18666
	sw	r6, 9(r3)
	sw	r8, 10(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18667
beq_then.18666:
	sw	r6, 9(r3)
	sw	r8, 10(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18667:
	j	beq_cont.18665
beq_then.18664:
	sw	r6, 9(r3)
	sw	r8, 10(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r2, 9(r3)
	lw	r5, 10(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18665:
	addi	r2, r2, -1
	lw	r1, 8(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -12
	lw	r31, 11(r3)
ble_cont.18663:
	lw	r1, 7(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	j	init_dirvec_constants.3442
init_vecset_constants.3445:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18668
	jr	r31				#
ble_then.18668:
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
	ble	r7, r6, ble_then.18670
	j	ble_cont.18671
ble_then.18670:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 2(r3)
	beqi	1, r10, beq_then.18672
	beqi	2, r10, beq_then.18674
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18675
beq_then.18674:
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18675:
	j	beq_cont.18673
beq_then.18672:
	sw	r6, 3(r3)
	sw	r8, 4(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18673:
	addi	r2, r2, -1
	lw	r1, 2(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -6
	lw	r31, 5(r3)
ble_cont.18671:
	lw	r1, 1(r3)
	lw	r2, 118(r1)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 1(r3)
	lw	r2, 117(r1)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	addi	r6, r0, 0
	ble	r6, r5, ble_then.18676
	j	ble_cont.18677
ble_then.18676:
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 5(r3)
	beqi	1, r9, beq_then.18678
	beqi	2, r9, beq_then.18680
	sw	r5, 6(r3)
	sw	r7, 7(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18681
beq_then.18680:
	sw	r5, 6(r3)
	sw	r7, 7(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18681:
	j	beq_cont.18679
beq_then.18678:
	sw	r5, 6(r3)
	sw	r7, 7(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r2, 6(r3)
	lw	r5, 7(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18679:
	addi	r2, r2, -1
	lw	r1, 5(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -9
	lw	r31, 8(r3)
ble_cont.18677:
	addi	r2, r0, 116
	lw	r1, 1(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	init_dirvec_constants.3442				#	bl	init_dirvec_constants.3442
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 0(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18682
	jr	r31				#
ble_then.18682:
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
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 9(r3)
	lw	r2, 118(r1)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	addi	r6, r0, 0
	ble	r6, r5, ble_then.18684
	j	ble_cont.18685
ble_then.18684:
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 10(r3)
	beqi	1, r9, beq_then.18686
	beqi	2, r9, beq_then.18688
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18689
beq_then.18688:
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18689:
	j	beq_cont.18687
beq_then.18686:
	sw	r5, 11(r3)
	sw	r7, 12(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18687:
	addi	r2, r2, -1
	lw	r1, 10(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -14
	lw	r31, 13(r3)
ble_cont.18685:
	addi	r2, r0, 117
	lw	r1, 9(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	init_dirvec_constants.3442				#	bl	init_dirvec_constants.3442
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r1, 8(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18690
	jr	r31				#
ble_then.18690:
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
	ble	r7, r6, ble_then.18692
	j	ble_cont.18693
ble_then.18692:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r5)
	lw	r9, 0(r5)
	lw	r10, 1(r7)
	sw	r5, 15(r3)
	beqi	1, r10, beq_then.18694
	beqi	2, r10, beq_then.18696
	sw	r6, 16(r3)
	sw	r8, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18697
beq_then.18696:
	sw	r6, 16(r3)
	sw	r8, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18697:
	j	beq_cont.18695
beq_then.18694:
	sw	r6, 16(r3)
	sw	r8, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18695:
	addi	r2, r2, -1
	lw	r1, 15(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -19
	lw	r31, 18(r3)
ble_cont.18693:
	addi	r2, r0, 118
	lw	r1, 14(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	init_dirvec_constants.3442				#	bl	init_dirvec_constants.3442
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r1, 13(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18698
	jr	r31				#
ble_then.18698:
	addi	r2, r0, 10766
	add	r30, r2, r1
	lw	r2, 0(r30)
	addi	r5, r0, 119
	sw	r1, 18(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	init_dirvec_constants.3442				#	bl	init_dirvec_constants.3442
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r1, 18(r3)
	addi	r1, r1, -1
	j	init_vecset_constants.3445
init_dirvecs.3447:
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
	jal	create_dirvec_elements.3437				#	bl	create_dirvec_elements.3437
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 3
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_dirvecs.3440				#	bl	create_dirvecs.3440
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
	jal	calc_dirvecs.3426				#	bl	calc_dirvecs.3426
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 8
	addi	r2, r0, 2
	addi	r5, r0, 4
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	calc_dirvec_rows.3431				#	bl	calc_dirvec_rows.3431
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
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 118(r1)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	addi	r6, r0, 0
	ble	r6, r5, ble_then.18700
	j	ble_cont.18701
ble_then.18700:
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 7(r3)
	beqi	1, r9, beq_then.18702
	beqi	2, r9, beq_then.18704
	sw	r5, 8(r3)
	sw	r7, 9(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18705
beq_then.18704:
	sw	r5, 8(r3)
	sw	r7, 9(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18705:
	j	beq_cont.18703
beq_then.18702:
	sw	r5, 8(r3)
	sw	r7, 9(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 8(r3)
	lw	r5, 9(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18703:
	addi	r2, r2, -1
	lw	r1, 7(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -11
	lw	r31, 10(r3)
ble_cont.18701:
	addi	r2, r0, 117
	lw	r1, 6(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	init_dirvec_constants.3442				#	bl	init_dirvec_constants.3442
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
	ble	r6, r5, ble_then.18706
	j	ble_cont.18707
ble_then.18706:
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 11(r3)
	beqi	1, r9, beq_then.18708
	beqi	2, r9, beq_then.18710
	sw	r5, 12(r3)
	sw	r7, 13(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18711
beq_then.18710:
	sw	r5, 12(r3)
	sw	r7, 13(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18711:
	j	beq_cont.18709
beq_then.18708:
	sw	r5, 12(r3)
	sw	r7, 13(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18709:
	addi	r2, r2, -1
	lw	r1, 11(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -15
	lw	r31, 14(r3)
ble_cont.18707:
	addi	r2, r0, 118
	lw	r1, 10(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	init_dirvec_constants.3442				#	bl	init_dirvec_constants.3442
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r1, r0, 10766
	lw	r1, 2(r1)
	addi	r2, r0, 119
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	init_dirvec_constants.3442				#	bl	init_dirvec_constants.3442
	addi	r3, r3, -15
	lw	r31, 14(r3)
	addi	r1, r0, 1
	j	init_vecset_constants.3445
add_reflection.3449:
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
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
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
setup_rect_reflection.3456:
	slli	r1, r1, 2
	addi	r5, r0, 10958
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
	ble	r7, r6, ble_then.18714
	j	ble_cont.18715
ble_then.18714:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.18716
	beqi	2, r8, beq_then.18718
	sw	r6, 16(r3)
	sw	r1, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18719
beq_then.18718:
	sw	r6, 16(r3)
	sw	r1, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18719:
	j	beq_cont.18717
beq_then.18716:
	sw	r6, 16(r3)
	sw	r1, 17(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18717:
	addi	r2, r2, -1
	lw	r1, 15(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -19
	lw	r31, 18(r3)
ble_cont.18715:
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
	ble	r7, r6, ble_then.18720
	j	ble_cont.18721
ble_then.18720:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.18722
	beqi	2, r8, beq_then.18724
	sw	r6, 24(r3)
	sw	r1, 25(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 24(r3)
	lw	r5, 25(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18725
beq_then.18724:
	sw	r6, 24(r3)
	sw	r1, 25(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 24(r3)
	lw	r5, 25(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18725:
	j	beq_cont.18723
beq_then.18722:
	sw	r6, 24(r3)
	sw	r1, 25(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r2, 24(r3)
	lw	r5, 25(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18723:
	addi	r2, r2, -1
	lw	r1, 23(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -27
	lw	r31, 26(r3)
ble_cont.18721:
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
	ble	r7, r6, ble_then.18726
	j	ble_cont.18727
ble_then.18726:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.18728
	beqi	2, r8, beq_then.18730
	sw	r6, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18731
beq_then.18730:
	sw	r6, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18731:
	j	beq_cont.18729
beq_then.18728:
	sw	r6, 32(r3)
	sw	r1, 33(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -35
	lw	r31, 34(r3)
	lw	r2, 32(r3)
	lw	r5, 33(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18729:
	addi	r2, r2, -1
	lw	r1, 31(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -35
	lw	r31, 34(r3)
ble_cont.18727:
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
	addi	r1, r0, 10958
	lw	r2, 3(r3)
	addi	r2, r2, 3
	sw	r2, 0(r1)
	jr	r31				#
setup_surface_reflection.3459:
	slli	r1, r1, 2
	addi	r1, r1, 1
	addi	r5, r0, 10958
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
	ble	r7, r6, ble_then.18733
	j	ble_cont.18734
ble_then.18733:
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r7, 0(r30)
	lw	r8, 1(r7)
	beqi	1, r8, beq_then.18735
	beqi	2, r8, beq_then.18737
	sw	r6, 12(r3)
	sw	r1, 13(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18738
beq_then.18737:
	sw	r6, 12(r3)
	sw	r1, 13(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18738:
	j	beq_cont.18736
beq_then.18735:
	sw	r6, 12(r3)
	sw	r1, 13(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 12(r3)
	lw	r5, 13(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18736:
	addi	r2, r2, -1
	lw	r1, 11(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -15
	lw	r31, 14(r3)
ble_cont.18734:
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
	addi	r1, r0, 10958
	addi	r2, r5, 1
	sw	r2, 0(r1)
	jr	r31				#
setup_reflections.3462:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18740
	jr	r31				#
ble_then.18740:
	addi	r2, r0, 10001
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.18742
	jr	r31				#
beq_then.18742:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 7(r2)
	flw	f2, 0(r5)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18744
	jr	r31				#
fle_else.18744:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.18746
	beqi	2, r5, beq_then.18747
	jr	r31				#
beq_then.18747:
	j	setup_surface_reflection.3459
beq_then.18746:
	j	setup_rect_reflection.3456
rt.3464:
	lw	r5, 7(r29)
	lw	r6, 6(r29)
	lw	r7, 5(r29)
	lw	r8, 4(r29)
	lw	r9, 3(r29)
	lw	r10, 2(r29)
	lw	r11, 1(r29)
	addi	r12, r0, 10743
	sw	r1, 0(r12)
	addi	r12, r0, 10743
	sw	r2, 1(r12)
	addi	r12, r0, 10745
	srai	r13, r1, 1
	sw	r13, 0(r12)
	addi	r12, r0, 10745
	srai	r2, r2, 1
	sw	r2, 1(r12)
	addi	r2, r0, 10747
	flup	f1, 49		# fli	f1, 128.000000
	itof	f2, r1
	fdiv	f1, f1, f2
	fsw	f1, 0(r2)
	addi	r1, r0, 10743
	lw	r1, 0(r1)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r7, 0(r3)
	sw	r6, 1(r3)
	sw	r8, 2(r3)
	sw	r9, 3(r3)
	sw	r5, 4(r3)
	sw	r10, 5(r3)
	sw	r1, 6(r3)
	sw	r11, 7(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -9
	lw	r31, 8(r3)
	sw	r1, 8(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 9(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r2, r0, 5
	lw	r5, 7(r3)
	sw	r1, 10(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -12
	lw	r31, 11(r3)
	sw	r1, 11(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -13
	lw	r31, 12(r3)
	sw	r1, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -14
	lw	r31, 13(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 13(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -15
	lw	r31, 14(r3)
	sw	r1, 14(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -16
	lw	r31, 15(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 14(r3)
	sw	r1, 6(r2)
	lw	r1, 13(r3)
	sw	r1, 5(r2)
	lw	r1, 12(r3)
	sw	r1, 4(r2)
	lw	r1, 11(r3)
	sw	r1, 3(r2)
	lw	r1, 10(r3)
	sw	r1, 2(r2)
	lw	r1, 9(r3)
	sw	r1, 1(r2)
	lw	r1, 8(r3)
	sw	r1, 0(r2)
	lw	r1, 6(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -16
	lw	r31, 15(r3)
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r2, r2, -2
	lw	r29, 5(r3)
	sw	r31, 15(r3)
	addi	r3, r3, 16
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -16
	lw	r31, 15(r3)
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 15(r3)
	sw	r2, 16(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -18
	lw	r31, 17(r3)
	sw	r1, 17(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -19
	lw	r31, 18(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 18(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -20
	lw	r31, 19(r3)
	addi	r2, r0, 5
	lw	r5, 7(r3)
	sw	r1, 19(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -21
	lw	r31, 20(r3)
	sw	r1, 20(r3)
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -22
	lw	r31, 21(r3)
	sw	r1, 21(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -23
	lw	r31, 22(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 22(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 23(r3)
	addi	r3, r3, 24
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -24
	lw	r31, 23(r3)
	sw	r1, 23(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -25
	lw	r31, 24(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 23(r3)
	sw	r1, 6(r2)
	lw	r1, 22(r3)
	sw	r1, 5(r2)
	lw	r1, 21(r3)
	sw	r1, 4(r2)
	lw	r1, 20(r3)
	sw	r1, 3(r2)
	lw	r1, 19(r3)
	sw	r1, 2(r2)
	lw	r1, 18(r3)
	sw	r1, 1(r2)
	lw	r1, 17(r3)
	sw	r1, 0(r2)
	lw	r1, 16(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -25
	lw	r31, 24(r3)
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r2, r2, -2
	lw	r29, 5(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -25
	lw	r31, 24(r3)
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 24(r3)
	sw	r2, 25(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -27
	lw	r31, 26(r3)
	sw	r1, 26(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r2, r0, 5
	addi	r5, r0, 0
	sw	r1, 27(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -29
	lw	r31, 28(r3)
	addi	r2, r0, 5
	lw	r5, 7(r3)
	sw	r1, 28(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -30
	lw	r31, 29(r3)
	sw	r1, 29(r3)
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -31
	lw	r31, 30(r3)
	sw	r1, 30(r3)
	sw	r31, 31(r3)
	addi	r3, r3, 32
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -32
	lw	r31, 31(r3)
	addi	r2, r0, 1
	addi	r5, r0, 0
	sw	r1, 31(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 32(r3)
	addi	r3, r3, 33
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -33
	lw	r31, 32(r3)
	sw	r1, 32(r3)
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	create_float5x3array.3404				#	bl	create_float5x3array.3404
	addi	r3, r3, -34
	lw	r31, 33(r3)
	add	r2, r0, r4
	addi	r4, r4, 8
	sw	r1, 7(r2)
	lw	r1, 32(r3)
	sw	r1, 6(r2)
	lw	r1, 31(r3)
	sw	r1, 5(r2)
	lw	r1, 30(r3)
	sw	r1, 4(r2)
	lw	r1, 29(r3)
	sw	r1, 3(r2)
	lw	r1, 28(r3)
	sw	r1, 2(r2)
	lw	r1, 27(r3)
	sw	r1, 1(r2)
	lw	r1, 26(r3)
	sw	r1, 0(r2)
	lw	r1, 25(r3)
	sw	r31, 33(r3)
	addi	r3, r3, 34
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -34
	lw	r31, 33(r3)
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r2, r2, -2
	lw	r29, 5(r3)
	sw	r31, 33(r3)
	addi	r3, r3, 34
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -34
	lw	r31, 33(r3)
	sw	r1, 33(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	read_screen_settings.3110				#	bl	read_screen_settings.3110
	addi	r3, r3, -35
	lw	r31, 34(r3)
	sw	r31, 34(r3)
	addi	r3, r3, 35
	jal	read_light.3112				#	bl	read_light.3112
	addi	r3, r3, -35
	lw	r31, 34(r3)
	addi	r1, r0, 0
	sw	r1, 34(r3)
	sw	r31, 35(r3)
	addi	r3, r3, 36
	jal	read_nth_object.3117				#	bl	read_nth_object.3117
	addi	r3, r3, -36
	lw	r31, 35(r3)
	beqi	0, r1, beq_then.18749
	addi	r1, r0, 1
	sw	r31, 35(r3)
	addi	r3, r3, 36
	jal	read_object.3119				#	bl	read_object.3119
	addi	r3, r3, -36
	lw	r31, 35(r3)
	j	beq_cont.18750
beq_then.18749:
	addi	r1, r0, 10000
	lw	r2, 34(r3)
	sw	r2, 0(r1)
beq_cont.18750:
	addi	r1, r0, 0
	sw	r31, 35(r3)
	addi	r3, r3, 36
	jal	read_and_network.3127				#	bl	read_and_network.3127
	addi	r3, r3, -36
	lw	r31, 35(r3)
	addi	r1, r0, 10723
	addi	r2, r0, 0
	sw	r1, 35(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	read_or_network.3125				#	bl	read_or_network.3125
	addi	r3, r3, -37
	lw	r31, 36(r3)
	lw	r2, 35(r3)
	sw	r1, 0(r2)
	addi	r1, r0, 80
	out	r1
	addi	r1, r0, 51
	out	r1
	addi	r1, r0, 10
	out	r1
	addi	r1, r0, 10743
	lw	r1, 0(r1)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -37
	lw	r31, 36(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -37
	lw	r31, 36(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 255
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	print_int.2956				#	bl	print_int.2956
	addi	r3, r3, -37
	lw	r31, 36(r3)
	addi	r1, r0, 10
	out	r1
	addi	r1, r0, 4
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	create_dirvecs.3440				#	bl	create_dirvecs.3440
	addi	r3, r3, -37
	lw	r31, 36(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	sw	r31, 36(r3)
	addi	r3, r3, 37
	jal	calc_dirvec_rows.3431				#	bl	calc_dirvec_rows.3431
	addi	r3, r3, -37
	lw	r31, 36(r3)
	addi	r1, r0, 10766
	lw	r1, 4(r1)
	lw	r2, 119(r1)
	addi	r5, r0, 10000
	lw	r5, 0(r5)
	addi	r5, r5, -1
	addi	r6, r0, 0
	sw	r1, 36(r3)
	ble	r6, r5, ble_then.18751
	j	ble_cont.18752
ble_then.18751:
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r6, 0(r30)
	lw	r7, 1(r2)
	lw	r8, 0(r2)
	lw	r9, 1(r6)
	sw	r2, 37(r3)
	beqi	1, r9, beq_then.18753
	beqi	2, r9, beq_then.18755
	sw	r5, 38(r3)
	sw	r7, 39(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	setup_second_table.3221				#	bl	setup_second_table.3221
	addi	r3, r3, -41
	lw	r31, 40(r3)
	lw	r2, 38(r3)
	lw	r5, 39(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.18756
beq_then.18755:
	sw	r5, 38(r3)
	sw	r7, 39(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	setup_surface_table.3218				#	bl	setup_surface_table.3218
	addi	r3, r3, -41
	lw	r31, 40(r3)
	lw	r2, 38(r3)
	lw	r5, 39(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18756:
	j	beq_cont.18754
beq_then.18753:
	sw	r5, 38(r3)
	sw	r7, 39(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	setup_rect_table.3215				#	bl	setup_rect_table.3215
	addi	r3, r3, -41
	lw	r31, 40(r3)
	lw	r2, 38(r3)
	lw	r5, 39(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.18754:
	addi	r2, r2, -1
	lw	r1, 37(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -41
	lw	r31, 40(r3)
ble_cont.18752:
	addi	r2, r0, 118
	lw	r1, 36(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	init_dirvec_constants.3442				#	bl	init_dirvec_constants.3442
	addi	r3, r3, -41
	lw	r31, 40(r3)
	addi	r1, r0, 10766
	lw	r1, 3(r1)
	addi	r2, r0, 119
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	init_dirvec_constants.3442				#	bl	init_dirvec_constants.3442
	addi	r3, r3, -41
	lw	r31, 40(r3)
	addi	r1, r0, 2
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	init_vecset_constants.3445				#	bl	init_vecset_constants.3445
	addi	r3, r3, -41
	lw	r31, 40(r3)
	addi	r1, r0, 10667
	flw	f1, 0(r1)
	lw	r2, 4(r3)
	fsw	f1, 0(r2)
	flw	f1, 1(r1)
	fsw	f1, 1(r2)
	flw	f1, 2(r1)
	fsw	f1, 2(r2)
	addi	r1, r0, 10000
	lw	r1, 0(r1)
	addi	r2, r1, -1
	lw	r1, 3(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	iter_setup_dirvec_constants.3224				#	bl	iter_setup_dirvec_constants.3224
	addi	r3, r3, -41
	lw	r31, 40(r3)
	addi	r1, r0, 10000
	lw	r1, 0(r1)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.18757
	j	ble_cont.18758
ble_then.18757:
	addi	r2, r0, 10001
	add	r30, r2, r1
	lw	r2, 0(r30)
	lw	r5, 2(r2)
	beqi	2, r5, beq_then.18759
	j	beq_cont.18760
beq_then.18759:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r5, 7(r2)
	flw	f2, 0(r5)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.18761
	j	fle_cont.18762
fle_else.18761:
	lw	r5, 1(r2)
	beqi	1, r5, beq_then.18763
	beqi	2, r5, beq_then.18765
	j	beq_cont.18766
beq_then.18765:
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	setup_surface_reflection.3459				#	bl	setup_surface_reflection.3459
	addi	r3, r3, -41
	lw	r31, 40(r3)
beq_cont.18766:
	j	beq_cont.18764
beq_then.18763:
	sw	r31, 40(r3)
	addi	r3, r3, 41
	jal	setup_rect_reflection.3456				#	bl	setup_rect_reflection.3456
	addi	r3, r3, -41
	lw	r31, 40(r3)
beq_cont.18764:
fle_cont.18762:
beq_cont.18760:
ble_cont.18758:
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r1, 24(r3)
	lw	r29, 2(r3)
	sw	r31, 40(r3)
	addi	r3, r3, 41
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -41
	lw	r31, 40(r3)
	addi	r2, r0, 0
	addi	r5, r0, 2
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	blei	0, r1, ble_then.18767
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	addi	r1, r1, -1
	sw	r2, 40(r3)
	blei	0, r1, ble_then.18768
	addi	r1, r0, 1
	lw	r6, 33(r3)
	lw	r29, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 41(r3)
	addi	r3, r3, 42
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -42
	lw	r31, 41(r3)
	j	ble_cont.18769
ble_then.18768:
ble_cont.18769:
	addi	r1, r0, 0
	lw	r2, 40(r3)
	lw	r5, 15(r3)
	lw	r6, 24(r3)
	lw	r7, 33(r3)
	lw	r29, 1(r3)
	sw	r31, 41(r3)
	addi	r3, r3, 42
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -42
	lw	r31, 41(r3)
	addi	r1, r0, 1
	addi	r7, r0, 4
	lw	r2, 24(r3)
	lw	r5, 33(r3)
	lw	r6, 15(r3)
	lw	r29, 0(r3)
	sw	r31, 41(r3)
	addi	r3, r3, 42
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -42
	lw	r31, 41(r3)
	jr	r31				#
ble_then.18767:
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
# n_reflections
  sw r0, 958(r4)
  addi  r4, r4, 959
#	main program starts
	addi	r1, r0, 1
	addi	r2, r0, 0
	addi	r5, r0, 0
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r2, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 60
	lw	r5, 2(r3)
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r5, 3(r3)
	sw	r5, 0(r2)
	add	r6, r0, r4
	addi	r4, r4, 3
	addi	r7, r0, shadow_check_and_group.3260
	sw	r7, 0(r6)
	sw	r5, 2(r6)
	sw	r1, 1(r6)
	add	r7, r0, r4
	addi	r4, r4, 2
	addi	r8, r0, shadow_check_one_or_group.3263
	sw	r8, 0(r7)
	sw	r6, 1(r7)
	add	r8, r0, r4
	addi	r4, r4, 5
	addi	r9, r0, shadow_check_one_or_matrix.3266
	sw	r9, 0(r8)
	sw	r5, 4(r8)
	sw	r7, 3(r8)
	sw	r6, 2(r8)
	sw	r1, 1(r8)
	add	r1, r0, r4
	addi	r4, r4, 2
	addi	r6, r0, trace_reflections.3313
	sw	r6, 0(r1)
	sw	r8, 1(r1)
	add	r6, r0, r4
	addi	r4, r4, 5
	addi	r7, r0, trace_ray.3318
	sw	r7, 0(r6)
	lw	r7, 1(r3)
	sw	r7, 4(r6)
	sw	r1, 3(r6)
	sw	r8, 2(r6)
	lw	r1, 0(r3)
	sw	r1, 1(r6)
	add	r7, r0, r4
	addi	r4, r4, 2
	addi	r9, r0, trace_diffuse_ray.3324
	sw	r9, 0(r7)
	sw	r8, 1(r7)
	add	r8, r0, r4
	addi	r4, r4, 2
	addi	r9, r0, iter_trace_diffuse_rays.3327
	sw	r9, 0(r8)
	sw	r7, 1(r8)
	add	r7, r0, r4
	addi	r4, r4, 2
	addi	r9, r0, trace_diffuse_ray_80percent.3336
	sw	r9, 0(r7)
	sw	r8, 1(r7)
	add	r9, r0, r4
	addi	r4, r4, 2
	addi	r10, r0, do_without_neighbors.3349
	sw	r10, 0(r9)
	sw	r7, 1(r9)
	add	r10, r0, r4
	addi	r4, r4, 3
	addi	r11, r0, try_exploit_neighbors.3365
	sw	r11, 0(r10)
	sw	r7, 2(r10)
	sw	r9, 1(r10)
	add	r11, r0, r4
	addi	r4, r4, 2
	addi	r12, r0, pretrace_diffuse_rays.3378
	sw	r12, 0(r11)
	sw	r8, 1(r11)
	add	r8, r0, r4
	addi	r4, r4, 4
	addi	r12, r0, pretrace_pixels.3381
	sw	r12, 0(r8)
	sw	r6, 3(r8)
	sw	r11, 2(r8)
	sw	r1, 1(r8)
	add	r6, r0, r4
	addi	r4, r4, 2
	addi	r11, r0, pretrace_line.3388
	sw	r11, 0(r6)
	sw	r8, 1(r6)
	add	r8, r0, r4
	addi	r4, r4, 4
	addi	r11, r0, scan_pixel.3392
	sw	r11, 0(r8)
	sw	r10, 3(r8)
	sw	r7, 2(r8)
	sw	r9, 1(r8)
	add	r7, r0, r4
	addi	r4, r4, 5
	addi	r11, r0, scan_line.3398
	sw	r11, 0(r7)
	sw	r10, 4(r7)
	sw	r8, 3(r7)
	sw	r6, 2(r7)
	sw	r9, 1(r7)
	add	r9, r0, r4
	addi	r4, r4, 2
	addi	r10, r0, init_line_elements.3408
	sw	r10, 0(r9)
	sw	r1, 1(r9)
	add	r29, r0, r4
	addi	r4, r4, 8
	addi	r10, r0, rt.3464
	sw	r10, 0(r29)
	sw	r5, 7(r29)
	sw	r8, 6(r29)
	sw	r7, 5(r29)
	sw	r6, 4(r29)
	sw	r2, 3(r29)
	sw	r9, 2(r29)
	sw	r1, 1(r29)
	addi	r1, r0, 128
	addi	r2, r0, 128
	sw	r31, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	_R_0, r0, 0
