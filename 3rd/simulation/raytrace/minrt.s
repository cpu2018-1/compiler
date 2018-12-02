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
print_char.2884:
	out	r1
	jr	r31				#
fispos.2886:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.12239
	addi	r1, r0, 0
	jr	r31				#
fle_else.12239:
	addi	r1, r0, 1
	jr	r31				#
fisneg.2888:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12240
	addi	r1, r0, 0
	jr	r31				#
fle_else.12240:
	addi	r1, r0, 1
	jr	r31				#
fiszero.2890:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12241
	addi	r1, r0, 1
	jr	r31				#
feq_else.12241:
	addi	r1, r0, 0
	jr	r31				#
xor.2892:
	beq	r1, r2, beq_then.12242
	addi	r1, r0, 1
	jr	r31				#
beq_then.12242:
	addi	r1, r0, 0
	jr	r31				#
fhalf.2895:
	flup	f2, 1		# fli	f2, 0.500000
	fmul	f1, f1, f2
	jr	r31				#
fsqr.2897:
	fmul	f1, f1, f1
	jr	r31				#
fabs.2899:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12243
	jr	r31				#
fle_else.12243:
	fneg	f1, f1
	jr	r31				#
int_of_float.2901:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12244
	addi	r1, r0, 0
	jr	r31				#
feq_else.12244:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12245
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
fle_else.12245:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
float_of_int.2903:
	itof	r1, r1
	jr	r31				#
floor.2905:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12246
	addi	r1, r0, 0
	j	feq_cont.12247
feq_else.12246:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12248
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12249
fle_else.12248:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12249:
feq_cont.12247:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12250
	fadd	f1, f0, f2
	jr	r31				#
fle_else.12250:
	flup	f1, 2		# fli	f1, 1.000000
	fsub	f1, f2, f1
	jr	r31				#
hoge.2907:
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12251
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12252
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12253
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12254
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12255
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12256
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12257
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12258
	flup	f3, 3		# fli	f3, 2.000000
	fmul	f2, f3, f2
	j	hoge.2907
fle_else.12258:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.12257:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.12256:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.12255:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.12254:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.12253:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.12252:
	fadd	f1, f0, f2
	jr	r31				#
fle_else.12251:
	fadd	f1, f0, f2
	jr	r31				#
fuga.2910:
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.12259
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12260
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.12261
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12262
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2910
fle_else.12262:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2910
fle_else.12261:
	jr	r31				#
fle_else.12260:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	flup	f4, 3		# fli	f4, 2.000000
	fmul	f4, f3, f4
	fle	r30, f4, f1
	beq	r0, r30, fle_else.12263
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12264
	fsub	f1, f1, f2
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2910
fle_else.12264:
	flup	f4, 3		# fli	f4, 2.000000
	fdiv	f2, f2, f4
	j	fuga.2910
fle_else.12263:
	jr	r31				#
fle_else.12259:
	jr	r31				#
modulo_2pi.2914:
	flup	f3, 14		# fli	f3, 3.141593
	flup	f2, 5		# fli	f2, 6.283186
	fsw	f3, 0(r3)
	fsw	f1, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12265
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12267
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12269
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12271
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12273
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12275
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12277
	addi	r30, r0, 4060
	lui	r30, r30, 17481	# to load float		804.247808
	fmvfr	f2, r30
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	hoge.2907				#	bl	hoge.2907
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	fle_cont.12278
fle_else.12277:
	fadd	f1, f0, f2
fle_cont.12278:
	j	fle_cont.12276
fle_else.12275:
	fadd	f1, f0, f2
fle_cont.12276:
	j	fle_cont.12274
fle_else.12273:
	fadd	f1, f0, f2
fle_cont.12274:
	j	fle_cont.12272
fle_else.12271:
	fadd	f1, f0, f2
fle_cont.12272:
	j	fle_cont.12270
fle_else.12269:
	fadd	f1, f0, f2
fle_cont.12270:
	j	fle_cont.12268
fle_else.12267:
	fadd	f1, f0, f2
fle_cont.12268:
	j	fle_cont.12266
fle_else.12265:
	fadd	f1, f0, f2
fle_cont.12266:
	flup	f2, 5		# fli	f2, 6.283186
	flw	f3, 2(r3)
	fle	r30, f2, f3
	beq	r0, r30, fle_else.12279
	fle	r30, f1, f3
	beq	r0, r30, fle_else.12280
	fsub	f2, f3, f1
	flup	f3, 3		# fli	f3, 2.000000
	fdiv	f1, f1, f3
	flw	f3, 0(r3)
	fadd	f30, f0, f2				# fmr	f30, f2
	fadd	f2, f0, f1				# fmr	f2, f1
	fadd	f1, f0, f30				# fmr	f1, f30
	j	fuga.2910
fle_else.12280:
	flup	f2, 3		# fli	f2, 2.000000
	fdiv	f2, f1, f2
	flw	f1, 0(r3)
	fadd	f30, f0, f3				# fmr	f30, f3
	fadd	f3, f0, f1				# fmr	f3, f1
	fadd	f1, f0, f30				# fmr	f1, f30
	j	fuga.2910
fle_else.12279:
	fadd	f1, f0, f3
	jr	r31				#
sin_body.2916:
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
cos_body.2918:
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
sin.2920:
	flup	f2, 14		# fli	f2, 3.141593
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12281
	flup	f3, 2		# fli	f3, 1.000000
	j	fle_cont.12282
fle_else.12281:
	flup	f3, 11		# fli	f3, -1.000000
fle_cont.12282:
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
	beq	r0, r30, fle_else.12283
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12285
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12287
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12289
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12291
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12293
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2907				#	bl	hoge.2907
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.12294
fle_else.12293:
fle_cont.12294:
	j	fle_cont.12292
fle_else.12291:
fle_cont.12292:
	j	fle_cont.12290
fle_else.12289:
fle_cont.12290:
	j	fle_cont.12288
fle_else.12287:
fle_cont.12288:
	j	fle_cont.12286
fle_else.12285:
fle_cont.12286:
	j	fle_cont.12284
fle_else.12283:
fle_cont.12284:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2910				#	bl	fuga.2910
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12295
	fsub	f1, f1, f2
	flw	f3, 0(r3)
	fneg	f3, f3
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.12296
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.12297
	fsw	f3, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2916				#	bl	sin_body.2916
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.12297:
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
fle_else.12296:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.12298
	fsw	f3, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2916				#	bl	sin_body.2916
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.12298:
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
fle_else.12295:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.12299
	fsub	f1, f2, f1
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.12300
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2916				#	bl	sin_body.2916
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.12300:
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
fle_else.12299:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.12301
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2916				#	bl	sin_body.2916
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.12301:
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
cos.2922:
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
	beq	r0, r30, fle_else.12302
	addi	r30, r0, 4060
	lui	r30, r30, 16713	# to load float		12.566372
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12304
	addi	r30, r0, 4060
	lui	r30, r30, 16841	# to load float		25.132744
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12306
	addi	r30, r0, 4060
	lui	r30, r30, 16969	# to load float		50.265488
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12308
	addi	r30, r0, 4060
	lui	r30, r30, 17097	# to load float		100.530976
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12310
	addi	r30, r0, 4060
	lui	r30, r30, 17225	# to load float		201.061952
	fmvfr	f2, r30
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12312
	addi	r30, r0, 4060
	lui	r30, r30, 17353	# to load float		402.123904
	fmvfr	f2, r30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	hoge.2907				#	bl	hoge.2907
	addi	r3, r3, -9
	lw	r31, 8(r3)
	fadd	f2, f0, f1				# fmr	f2, f1
	j	fle_cont.12313
fle_else.12312:
fle_cont.12313:
	j	fle_cont.12311
fle_else.12310:
fle_cont.12311:
	j	fle_cont.12309
fle_else.12308:
fle_cont.12309:
	j	fle_cont.12307
fle_else.12306:
fle_cont.12307:
	j	fle_cont.12305
fle_else.12304:
fle_cont.12305:
	j	fle_cont.12303
fle_else.12302:
fle_cont.12303:
	flw	f1, 6(r3)
	flw	f3, 4(r3)
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	fuga.2910				#	bl	fuga.2910
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 2(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12314
	fsub	f1, f1, f2
	flup	f3, 11		# fli	f3, -1.000000
	flup	f4, 15		# fli	f4, 1.570796
	fle	r30, f4, f1
	beq	r0, r30, fle_else.12315
	fsub	f1, f2, f1
	flup	f2, 2		# fli	f2, 1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.12316
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
fle_else.12316:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fsw	f2, 8(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	sin_body.2916				#	bl	sin_body.2916
	addi	r3, r3, -11
	lw	r31, 10(r3)
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.12315:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.12317
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
fle_else.12317:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	fsw	f3, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin_body.2916				#	bl	sin_body.2916
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.12314:
	flup	f3, 15		# fli	f3, 1.570796
	fle	r30, f3, f1
	beq	r0, r30, fle_else.12318
	fsub	f1, f2, f1
	flup	f2, 11		# fli	f2, -1.000000
	flup	f3, 16		# fli	f3, 0.785398
	fle	r30, f1, f3
	beq	r0, r30, fle_else.12319
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
fle_else.12319:
	flup	f3, 15		# fli	f3, 1.570796
	fsub	f1, f3, f1
	fsw	f2, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin_body.2916				#	bl	sin_body.2916
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.12318:
	flup	f2, 16		# fli	f2, 0.785398
	fle	r30, f1, f2
	beq	r0, r30, fle_else.12320
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
fle_else.12320:
	flup	f2, 15		# fli	f2, 1.570796
	fsub	f1, f2, f1
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin_body.2916				#	bl	sin_body.2916
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
atan_body.2924:
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
atan.2926:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12321
	flup	f2, 2		# fli	f2, 1.000000
	j	fle_cont.12322
fle_else.12321:
	flup	f2, 11		# fli	f2, -1.000000
fle_cont.12322:
	fmul	f1, f1, f2
	flup	f3, 23		# fli	f3, 4.375000
	fle	r30, f3, f1
	beq	r0, r30, fle_else.12323
	flup	f3, 24		# fli	f3, 2.437500
	fle	r30, f3, f1
	beq	r0, r30, fle_else.12324
	flup	f3, 15		# fli	f3, 1.570796
	flup	f4, 2		# fli	f4, 1.000000
	fdiv	f1, f4, f1
	fsw	f2, 0(r3)
	fsw	f3, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan_body.2924				#	bl	atan_body.2924
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.12324:
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
	jal	atan_body.2924				#	bl	atan_body.2924
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fadd	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
fle_else.12323:
	j	atan_body.2924
print_num.2928:
	addi	r1, r1, 48
	out	r1
	jr	r31				#
mul10.2930:
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	jr	r31				#
div10_sub.2932:
	add	r6, r2, r5
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.12325
	add	r5, r2, r6
	srai	r5, r5, 1
	slli	r7, r5, 3
	slli	r8, r5, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.12326
	j	div10_sub.2932
ble_then.12326:
	slli	r2, r5, 3
	slli	r7, r5, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.12327
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	j	div10_sub.2932
ble_then.12327:
	add	r1, r0, r5
	jr	r31				#
ble_then.12325:
	slli	r2, r6, 3
	slli	r7, r6, 1
	add	r2, r2, r7
	addi	r2, r2, 9
	ble	r1, r2, ble_then.12328
	add	r2, r6, r5
	srai	r2, r2, 1
	slli	r7, r2, 3
	slli	r8, r2, 1
	add	r7, r7, r8
	ble	r7, r1, ble_then.12329
	add	r5, r0, r2				# mr	r5, r2
	add	r2, r0, r6				# mr	r2, r6
	j	div10_sub.2932
ble_then.12329:
	slli	r6, r2, 3
	slli	r7, r2, 1
	add	r6, r6, r7
	addi	r6, r6, 9
	ble	r1, r6, ble_then.12330
	j	div10_sub.2932
ble_then.12330:
	add	r1, r0, r2
	jr	r31				#
ble_then.12328:
	add	r1, r0, r6
	jr	r31				#
div10.2936:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.12331
	j	div10_sub.2932
ble_then.12331:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.12332
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	j	div10_sub.2932
ble_then.12332:
	add	r1, r0, r5
	jr	r31				#
iter_mul10.2938:
	beqi	0, r2, beq_then.12333
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	beqi	0, r2, beq_then.12334
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	beqi	0, r2, beq_then.12335
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	beqi	0, r2, beq_then.12336
	slli	r5, r1, 3
	slli	r1, r1, 1
	add	r1, r5, r1
	addi	r2, r2, -1
	j	iter_mul10.2938
beq_then.12336:
	jr	r31				#
beq_then.12335:
	jr	r31				#
beq_then.12334:
	jr	r31				#
beq_then.12333:
	jr	r31				#
iter_div10.2941:
	beqi	0, r2, beq_then.12337
	addi	r5, r0, 0
	sw	r2, 0(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.12338
	addi	r5, r0, 0
	addi	r6, r1, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r2, 1(r3)
	ble	r7, r1, ble_then.12339
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.12340
ble_then.12339:
	slli	r5, r6, 3
	slli	r7, r6, 1
	add	r5, r5, r7
	addi	r5, r5, 9
	ble	r1, r5, ble_then.12341
	add	r5, r0, r1				# mr	r5, r1
	add	r2, r0, r6				# mr	r2, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.12342
ble_then.12341:
	add	r1, r0, r6
ble_cont.12342:
ble_cont.12340:
	lw	r2, 1(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.12343
	addi	r5, r0, 0
	sw	r2, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 2(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.12344
	sw	r2, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10.2936				#	bl	div10.2936
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	addi	r2, r2, -1
	j	iter_div10.2941
beq_then.12344:
	jr	r31				#
beq_then.12343:
	jr	r31				#
beq_then.12338:
	jr	r31				#
beq_then.12337:
	jr	r31				#
keta_sub.2944:
	addi	r5, r0, 10
	ble	r5, r1, ble_then.12345
	addi	r1, r2, 1
	jr	r31				#
ble_then.12345:
	addi	r5, r0, 0
	sw	r2, 0(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r2, 0(r3)
	addi	r2, r2, 1
	addi	r5, r0, 10
	ble	r5, r1, ble_then.12346
	addi	r1, r2, 1
	jr	r31				#
ble_then.12346:
	addi	r5, r0, 0
	addi	r6, r1, 0
	srai	r6, r6, 1
	slli	r7, r6, 3
	slli	r8, r6, 1
	add	r7, r7, r8
	sw	r2, 1(r3)
	ble	r7, r1, ble_then.12347
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.12348
ble_then.12347:
	slli	r5, r6, 3
	slli	r7, r6, 1
	add	r5, r5, r7
	addi	r5, r5, 9
	ble	r1, r5, ble_then.12349
	add	r5, r0, r1				# mr	r5, r1
	add	r2, r0, r6				# mr	r2, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.12350
ble_then.12349:
	add	r1, r0, r6
ble_cont.12350:
ble_cont.12348:
	lw	r2, 1(r3)
	addi	r2, r2, 1
	addi	r5, r0, 10
	ble	r5, r1, ble_then.12351
	addi	r1, r2, 1
	jr	r31				#
ble_then.12351:
	addi	r5, r0, 0
	sw	r2, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 2(r3)
	addi	r2, r2, 1
	addi	r5, r0, 10
	ble	r5, r1, ble_then.12352
	addi	r1, r2, 1
	jr	r31				#
ble_then.12352:
	sw	r2, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10.2936				#	bl	div10.2936
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	addi	r2, r2, 1
	j	keta_sub.2944
keta.2947:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.12353
	addi	r1, r0, 1
	jr	r31				#
ble_then.12353:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.12354
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	ble_cont.12355
ble_then.12354:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.12356
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	ble_cont.12357
ble_then.12356:
	add	r1, r0, r5
ble_cont.12357:
ble_cont.12355:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.12358
	addi	r1, r0, 2
	jr	r31				#
ble_then.12358:
	addi	r2, r0, 0
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r2, r0, 10
	ble	r2, r1, ble_then.12359
	addi	r1, r0, 3
	jr	r31				#
ble_then.12359:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	div10.2936				#	bl	div10.2936
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r2, r0, 3
	j	keta_sub.2944
print_uint_keta.2949:
	beqi	1, r2, beq_then.12360
	addi	r5, r2, -1
	sw	r2, 0(r3)
	sw	r1, 1(r3)
	beqi	0, r5, beq_then.12361
	addi	r5, r5, -1
	beqi	0, r5, beq_then.12363
	addi	r5, r5, -1
	beqi	0, r5, beq_then.12365
	addi	r6, r0, 1000
	addi	r5, r5, -1
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	iter_mul10.2938				#	bl	iter_mul10.2938
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	beq_cont.12366
beq_then.12365:
	addi	r1, r0, 100
beq_cont.12366:
	j	beq_cont.12364
beq_then.12363:
	addi	r1, r0, 10
beq_cont.12364:
	j	beq_cont.12362
beq_then.12361:
	addi	r1, r0, 1
beq_cont.12362:
	lw	r5, 1(r3)
	ble	r1, r5, ble_then.12367
	addi	r1, r0, 48
	out	r1
	lw	r1, 0(r3)
	addi	r2, r1, -1
	add	r1, r0, r5				# mr	r1, r5
	j	print_uint_keta.2949
ble_then.12367:
	lw	r1, 0(r3)
	addi	r2, r1, -1
	beqi	0, r2, beq_then.12368
	addi	r6, r0, 0
	addi	r7, r5, 0
	srai	r7, r7, 1
	slli	r8, r7, 3
	slli	r9, r7, 1
	add	r8, r8, r9
	sw	r2, 2(r3)
	ble	r8, r5, ble_then.12370
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	ble_cont.12371
ble_then.12370:
	slli	r6, r7, 3
	slli	r8, r7, 1
	add	r6, r6, r8
	addi	r6, r6, 9
	ble	r5, r6, ble_then.12372
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -4
	lw	r31, 3(r3)
	j	ble_cont.12373
ble_then.12372:
	add	r1, r0, r7
ble_cont.12373:
ble_cont.12371:
	lw	r2, 2(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.12374
	addi	r5, r0, 0
	sw	r2, 3(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 3(r3)
	addi	r2, r2, -1
	beqi	0, r2, beq_then.12376
	sw	r2, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	div10.2936				#	bl	div10.2936
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 4(r3)
	addi	r2, r2, -1
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_div10.2941				#	bl	iter_div10.2941
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.12377
beq_then.12376:
beq_cont.12377:
	j	beq_cont.12375
beq_then.12374:
beq_cont.12375:
	j	beq_cont.12369
beq_then.12368:
	add	r1, r0, r5
beq_cont.12369:
	addi	r2, r1, 48
	out	r2
	lw	r2, 0(r3)
	addi	r5, r2, -1
	beqi	0, r5, beq_then.12378
	slli	r6, r1, 3
	slli	r1, r1, 1
	add	r1, r6, r1
	addi	r5, r5, -1
	beqi	0, r5, beq_then.12380
	slli	r6, r1, 3
	slli	r1, r1, 1
	add	r1, r6, r1
	addi	r5, r5, -1
	beqi	0, r5, beq_then.12382
	slli	r6, r1, 3
	slli	r1, r1, 1
	add	r1, r6, r1
	addi	r5, r5, -1
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	iter_mul10.2938				#	bl	iter_mul10.2938
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.12383
beq_then.12382:
beq_cont.12383:
	j	beq_cont.12381
beq_then.12380:
beq_cont.12381:
	j	beq_cont.12379
beq_then.12378:
beq_cont.12379:
	lw	r2, 1(r3)
	sub	r1, r2, r1
	lw	r2, 0(r3)
	addi	r2, r2, -1
	j	print_uint_keta.2949
beq_then.12360:
	addi	r1, r1, 48
	out	r1
	jr	r31				#
print_uint.2952:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.12384
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.12384:
	addi	r2, r0, 0
	sw	r1, 0(r3)
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 10
	sw	r1, 1(r3)
	ble	r2, r1, ble_then.12385
	addi	r2, r1, 48
	out	r2
	j	ble_cont.12386
ble_then.12385:
	addi	r2, r0, 0
	addi	r5, r1, 0
	srai	r5, r5, 1
	slli	r6, r5, 3
	slli	r7, r5, 1
	add	r6, r6, r7
	ble	r6, r1, ble_then.12387
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.12388
ble_then.12387:
	slli	r2, r5, 3
	slli	r6, r5, 1
	add	r2, r2, r6
	addi	r2, r2, 9
	ble	r1, r2, ble_then.12389
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r1				# mr	r5, r1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	div10_sub.2932				#	bl	div10_sub.2932
	addi	r3, r3, -3
	lw	r31, 2(r3)
	j	ble_cont.12390
ble_then.12389:
	add	r1, r0, r5
ble_cont.12390:
ble_cont.12388:
	sw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	print_uint.2952				#	bl	print_uint.2952
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
ble_cont.12386:
	lw	r1, 1(r3)
	slli	r2, r1, 3
	slli	r1, r1, 1
	add	r1, r2, r1
	lw	r2, 0(r3)
	sub	r1, r2, r1
	addi	r1, r1, 48
	out	r1
	jr	r31				#
print_int.2954:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.12391
	addi	r2, r0, 45
	out	r2
	sub	r1, r0, r1
	j	print_int.2954
ble_then.12391:
	addi	r2, r0, 10
	ble	r2, r1, ble_then.12392
	addi	r1, r1, 48
	out	r1
	jr	r31				#
ble_then.12392:
	addi	r2, r0, 100
	ble	r2, r1, ble_then.12393
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
ble_then.12393:
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
read_token.2956:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_char				#	bl	lib_read_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r2, r0, 32
	beq	r1, r2, beq_then.12394
	beqi	9, r1, beq_then.12395
	beqi	13, r1, beq_then.12396
	beqi	10, r1, beq_then.12397
	addi	r2, r0, 26
	beq	r1, r2, beq_then.12398
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_buffer_add_char				#	bl	lib_buffer_add_char
	addi	r3, r3, -2
	lw	r31, 1(r3)
	addi	r1, r0, 1
	j	read_token.2956
beq_then.12398:
	jr	r31				#
beq_then.12397:
	lw	r1, 0(r3)
	beqi	0, r1, beq_then.12400
	jr	r31				#
beq_then.12400:
	addi	r1, r0, 0
	j	read_token.2956
beq_then.12396:
	lw	r1, 0(r3)
	beqi	0, r1, beq_then.12402
	jr	r31				#
beq_then.12402:
	addi	r1, r0, 0
	j	read_token.2956
beq_then.12395:
	lw	r1, 0(r3)
	beqi	0, r1, beq_then.12404
	jr	r31				#
beq_then.12404:
	addi	r1, r0, 0
	j	read_token.2956
beq_then.12394:
	lw	r1, 0(r3)
	beqi	0, r1, beq_then.12406
	jr	r31				#
beq_then.12406:
	addi	r1, r0, 0
	j	read_token.2956
read_int_ascii.2958:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_buffer_clear				#	bl	lib_buffer_clear
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_token.2956				#	bl	read_token.2956
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	lib_buffer_to_int
iter_div10_float.2960:
	beqi	0, r1, beq_then.12408
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	beqi	0, r1, beq_then.12409
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	beqi	0, r1, beq_then.12410
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	beqi	0, r1, beq_then.12411
	flup	f2, 39		# fli	f2, 10.000000
	fdiv	f1, f1, f2
	addi	r1, r1, -1
	j	iter_div10_float.2960
beq_then.12411:
	jr	r31				#
beq_then.12410:
	jr	r31				#
beq_then.12409:
	jr	r31				#
beq_then.12408:
	jr	r31				#
read_float_ascii.2963:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	lib_buffer_clear				#	bl	lib_buffer_clear
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_token.2956				#	bl	read_token.2956
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
	beq	r5, r2, beq_then.12412
	lw	r2, 1(r3)
	itof	f1, r2
	lw	r2, 2(r3)
	itof	f2, r2
	fsw	f1, 4(r3)
	beqi	0, r1, beq_then.12414
	flup	f3, 39		# fli	f3, 10.000000
	fdiv	f2, f2, f3
	addi	r1, r1, -1
	beqi	0, r1, beq_then.12416
	flup	f3, 39		# fli	f3, 10.000000
	fdiv	f2, f2, f3
	addi	r1, r1, -1
	beqi	0, r1, beq_then.12418
	flup	f3, 39		# fli	f3, 10.000000
	fdiv	f2, f2, f3
	addi	r1, r1, -1
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	iter_div10_float.2960				#	bl	iter_div10_float.2960
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.12419
beq_then.12418:
	fadd	f1, f0, f2
beq_cont.12419:
	j	beq_cont.12417
beq_then.12416:
	fadd	f1, f0, f2
beq_cont.12417:
	j	beq_cont.12415
beq_then.12414:
	fadd	f1, f0, f2
beq_cont.12415:
	flw	f2, 4(r3)
	fadd	f1, f2, f1
	jr	r31				#
beq_then.12412:
	flup	f1, 11		# fli	f1, -1.000000
	lw	r2, 1(r3)
	itof	f2, r2
	lw	r2, 2(r3)
	itof	f3, r2
	fsw	f1, 6(r3)
	fsw	f2, 8(r3)
	beqi	0, r1, beq_then.12420
	flup	f4, 39		# fli	f4, 10.000000
	fdiv	f3, f3, f4
	addi	r1, r1, -1
	beqi	0, r1, beq_then.12422
	flup	f4, 39		# fli	f4, 10.000000
	fdiv	f3, f3, f4
	addi	r1, r1, -1
	beqi	0, r1, beq_then.12424
	flup	f4, 39		# fli	f4, 10.000000
	fdiv	f3, f3, f4
	addi	r1, r1, -1
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	iter_div10_float.2960				#	bl	iter_div10_float.2960
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.12425
beq_then.12424:
	fadd	f1, f0, f3
beq_cont.12425:
	j	beq_cont.12423
beq_then.12422:
	fadd	f1, f0, f3
beq_cont.12423:
	j	beq_cont.12421
beq_then.12420:
	fadd	f1, f0, f3
beq_cont.12421:
	flw	f2, 8(r3)
	fadd	f1, f2, f1
	flw	f2, 6(r3)
	fmul	f1, f2, f1
	jr	r31				#
truncate.2965:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12426
	addi	r1, r0, 0
	jr	r31				#
feq_else.12426:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12427
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
fle_else.12427:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	f1, f1
	jr	r31				#
abs_float.2967:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12428
	jr	r31				#
fle_else.12428:
	fneg	f1, f1
	jr	r31				#
print_dec.2969:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12429
	jr	r31				#
feq_else.12429:
	flup	f2, 39		# fli	f2, 10.000000
	fmul	f1, f2, f1
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12431
	addi	r1, r0, 0
	j	feq_cont.12432
feq_else.12431:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12433
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12434
fle_else.12433:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12434:
feq_cont.12432:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	print_int.2954				#	bl	print_int.2954
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f1, 0(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12435
	addi	r1, r0, 0
	j	feq_cont.12436
feq_else.12435:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12437
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12438
fle_else.12437:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12438:
feq_cont.12436:
	itof	f2, r1
	fsub	f1, f1, f2
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12439
	jr	r31				#
feq_else.12439:
	flup	f2, 39		# fli	f2, 10.000000
	fmul	f1, f2, f1
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12441
	addi	r1, r0, 0
	j	feq_cont.12442
feq_else.12441:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12443
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12444
fle_else.12443:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12444:
feq_cont.12442:
	fsw	f1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	print_int.2954				#	bl	print_int.2954
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f1, 2(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12445
	addi	r1, r0, 0
	j	feq_cont.12446
feq_else.12445:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12447
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12448
fle_else.12447:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12448:
feq_cont.12446:
	itof	f2, r1
	fsub	f1, f1, f2
	j	print_dec.2969
print_ufloat.2971:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12449
	addi	r1, r0, 0
	j	feq_cont.12450
feq_else.12449:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12451
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12452
fle_else.12451:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12452:
feq_cont.12450:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	print_int.2954				#	bl	print_int.2954
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r1, r0, 46
	out	r1
	flw	f1, 0(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12453
	addi	r1, r0, 0
	j	feq_cont.12454
feq_else.12453:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12455
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12456
fle_else.12455:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12456:
feq_cont.12454:
	itof	f2, r1
	fsub	f1, f1, f2
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12457
	jr	r31				#
feq_else.12457:
	flup	f2, 39		# fli	f2, 10.000000
	fmul	f1, f2, f1
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12459
	addi	r1, r0, 0
	j	feq_cont.12460
feq_else.12459:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12461
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12462
fle_else.12461:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12462:
feq_cont.12460:
	fsw	f1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	print_int.2954				#	bl	print_int.2954
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f1, 2(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12463
	addi	r1, r0, 0
	j	feq_cont.12464
feq_else.12463:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12465
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12466
fle_else.12465:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12466:
feq_cont.12464:
	itof	f2, r1
	fsub	f1, f1, f2
	j	print_dec.2969
print_float.2973:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12467
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12468
	addi	r1, r0, 0
	j	feq_cont.12469
feq_else.12468:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12470
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12471
fle_else.12470:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12471:
feq_cont.12469:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	print_int.2954				#	bl	print_int.2954
	addi	r3, r3, -3
	lw	r31, 2(r3)
	addi	r1, r0, 46
	out	r1
	flw	f1, 0(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12472
	addi	r1, r0, 0
	j	feq_cont.12473
feq_else.12472:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12474
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12475
fle_else.12474:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12475:
feq_cont.12473:
	itof	f2, r1
	fsub	f1, f1, f2
	j	print_dec.2969
fle_else.12467:
	addi	r1, r0, 45
	out	r1
	fneg	f1, f1
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12476
	addi	r1, r0, 0
	j	feq_cont.12477
feq_else.12476:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12478
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12479
fle_else.12478:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12479:
feq_cont.12477:
	fsw	f1, 2(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	print_int.2954				#	bl	print_int.2954
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 46
	out	r1
	flw	f1, 2(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12480
	addi	r1, r0, 0
	j	feq_cont.12481
feq_else.12480:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12482
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12483
fle_else.12482:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12483:
feq_cont.12481:
	itof	f2, r1
	fsub	f1, f1, f2
	j	print_dec.2969
xor.2981:
	beqi	0, r1, beq_then.12484
	beqi	0, r2, beq_then.12485
	addi	r1, r0, 0
	jr	r31				#
beq_then.12485:
	addi	r1, r0, 1
	jr	r31				#
beq_then.12484:
	add	r1, r0, r2
	jr	r31				#
sgn.2984:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12486
	addi	r1, r0, 1
	j	feq_cont.12487
feq_else.12486:
	addi	r1, r0, 0
feq_cont.12487:
	beqi	0, r1, beq_then.12488
	flup	f1, 0		# fli	f1, 0.000000
	jr	r31				#
beq_then.12488:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.12489
	addi	r1, r0, 0
	j	fle_cont.12490
fle_else.12489:
	addi	r1, r0, 1
fle_cont.12490:
	beqi	0, r1, beq_then.12491
	flup	f1, 2		# fli	f1, 1.000000
	jr	r31				#
beq_then.12491:
	flup	f1, 11		# fli	f1, -1.000000
	jr	r31				#
fneg_cond.2986:
	beqi	0, r1, beq_then.12492
	jr	r31				#
beq_then.12492:
	fneg	f1, f1
	jr	r31				#
add_mod5.2989:
	add	r1, r1, r2
	addi	r2, r0, 5
	ble	r2, r1, ble_then.12493
	jr	r31				#
ble_then.12493:
	addi	r1, r1, -5
	jr	r31				#
vecset.2992:
	fsw	f1, 0(r1)
	fsw	f2, 1(r1)
	fsw	f3, 2(r1)
	jr	r31				#
vecfill.2997:
	fsw	f1, 0(r1)
	fsw	f1, 1(r1)
	fsw	f1, 2(r1)
	jr	r31				#
vecbzero.3000:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
	fsw	f1, 1(r1)
	fsw	f1, 2(r1)
	jr	r31				#
veccpy.3002:
	flw	f1, 0(r2)
	fsw	f1, 0(r1)
	flw	f1, 1(r2)
	fsw	f1, 1(r1)
	flw	f1, 2(r2)
	fsw	f1, 2(r1)
	jr	r31				#
vecdist2.3005:
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
vecunit.3008:
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
vecunit_sgn.3010:
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
	beq	r0, r30, feq_else.12499
	addi	r5, r0, 1
	j	feq_cont.12500
feq_else.12499:
	addi	r5, r0, 0
feq_cont.12500:
	beqi	0, r5, beq_then.12501
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.12502
beq_then.12501:
	beqi	0, r2, beq_then.12503
	flup	f2, 11		# fli	f2, -1.000000
	fdiv	f1, f2, f1
	j	beq_cont.12504
beq_then.12503:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
beq_cont.12504:
beq_cont.12502:
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
veciprod.3013:
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
veciprod2.3016:
	flw	f4, 0(r1)
	fmul	f1, f4, f1
	flw	f4, 1(r1)
	fmul	f2, f4, f2
	fadd	f1, f1, f2
	flw	f2, 2(r1)
	fmul	f2, f2, f3
	fadd	f1, f1, f2
	jr	r31				#
vecaccum.3021:
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
vecadd.3025:
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
vecmul.3028:
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
vecscale.3031:
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
vecaccumv.3034:
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
o_texturetype.3038:
	lw	r1, 0(r1)
	jr	r31				#
o_form.3040:
	lw	r1, 1(r1)
	jr	r31				#
o_reflectiontype.3042:
	lw	r1, 2(r1)
	jr	r31				#
o_isinvert.3044:
	lw	r1, 6(r1)
	jr	r31				#
o_isrot.3046:
	lw	r1, 3(r1)
	jr	r31				#
o_param_a.3048:
	lw	r1, 4(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_param_b.3050:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_param_c.3052:
	lw	r1, 4(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_param_abc.3054:
	lw	r1, 4(r1)
	jr	r31				#
o_param_x.3056:
	lw	r1, 5(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_param_y.3058:
	lw	r1, 5(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_param_z.3060:
	lw	r1, 5(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_diffuse.3062:
	lw	r1, 7(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_hilight.3064:
	lw	r1, 7(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_color_red.3066:
	lw	r1, 8(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_color_green.3068:
	lw	r1, 8(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_color_blue.3070:
	lw	r1, 8(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_param_r1.3072:
	lw	r1, 9(r1)
	flw	f1, 0(r1)
	jr	r31				#
o_param_r2.3074:
	lw	r1, 9(r1)
	flw	f1, 1(r1)
	jr	r31				#
o_param_r3.3076:
	lw	r1, 9(r1)
	flw	f1, 2(r1)
	jr	r31				#
o_param_ctbl.3078:
	lw	r1, 10(r1)
	jr	r31				#
p_rgb.3080:
	lw	r1, 0(r1)
	jr	r31				#
p_intersection_points.3082:
	lw	r1, 1(r1)
	jr	r31				#
p_surface_ids.3084:
	lw	r1, 2(r1)
	jr	r31				#
p_calc_diffuse.3086:
	lw	r1, 3(r1)
	jr	r31				#
p_energy.3088:
	lw	r1, 4(r1)
	jr	r31				#
p_received_ray_20percent.3090:
	lw	r1, 5(r1)
	jr	r31				#
p_group_id.3092:
	lw	r1, 6(r1)
	lw	r1, 0(r1)
	jr	r31				#
p_set_group_id.3094:
	lw	r1, 6(r1)
	sw	r2, 0(r1)
	jr	r31				#
p_nvectors.3097:
	lw	r1, 7(r1)
	jr	r31				#
d_vec.3099:
	lw	r1, 0(r1)
	jr	r31				#
d_const.3101:
	lw	r1, 1(r1)
	jr	r31				#
r_surface_id.3103:
	lw	r1, 0(r1)
	jr	r31				#
r_dvec.3105:
	lw	r1, 1(r1)
	jr	r31				#
r_bright.3107:
	flw	f1, 2(r1)
	jr	r31				#
rad.3109:
	flup	f2, 25		# fli	f2, 0.017453
	fmul	f1, f1, f2
	jr	r31				#
read_screen_settings.3111:
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
	jal	cos.2922				#	bl	cos.2922
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2920				#	bl	sin.2920
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
	jal	cos.2922				#	bl	cos.2922
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fsw	f1, 12(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin.2920				#	bl	sin.2920
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
read_light.3113:
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
	jal	sin.2920				#	bl	sin.2920
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
	jal	cos.2922				#	bl	cos.2922
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin.2920				#	bl	sin.2920
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 10667
	flw	f2, 4(r3)
	fmul	f1, f2, f1
	fsw	f1, 0(r1)
	flw	f1, 2(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2922				#	bl	cos.2922
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
rotate_quadratic_matrix.3115:
	flw	f1, 0(r2)
	sw	r1, 0(r3)
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	cos.2922				#	bl	cos.2922
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	flw	f2, 0(r1)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	sin.2920				#	bl	sin.2920
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 4(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2922				#	bl	cos.2922
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 1(r3)
	flw	f2, 1(r1)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	sin.2920				#	bl	sin.2920
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 8(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	cos.2922				#	bl	cos.2922
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 1(r3)
	flw	f2, 2(r1)
	fsw	f1, 10(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	sin.2920				#	bl	sin.2920
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
read_nth_object.3118:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.12516
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
	beq	r0, r30, fle_else.12517
	addi	r1, r0, 0
	j	fle_cont.12518
fle_else.12517:
	addi	r1, r0, 1
fle_cont.12518:
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
	beqi	0, r2, beq_then.12519
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
	j	beq_cont.12520
beq_then.12519:
beq_cont.12520:
	lw	r2, 2(r3)
	beqi	2, r2, beq_then.12521
	lw	r5, 7(r3)
	j	beq_cont.12522
beq_then.12521:
	addi	r5, r0, 1
beq_cont.12522:
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
	beqi	3, r7, beq_then.12523
	beqi	2, r7, beq_then.12525
	j	beq_cont.12526
beq_then.12525:
	lw	r2, 7(r3)
	beqi	0, r2, beq_then.12527
	addi	r2, r0, 0
	j	beq_cont.12528
beq_then.12527:
	addi	r2, r0, 1
beq_cont.12528:
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	vecunit_sgn.3010				#	bl	vecunit_sgn.3010
	addi	r3, r3, -13
	lw	r31, 12(r3)
beq_cont.12526:
	j	beq_cont.12524
beq_then.12523:
	flw	f1, 0(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12529
	addi	r2, r0, 1
	j	feq_cont.12530
feq_else.12529:
	addi	r2, r0, 0
feq_cont.12530:
	beqi	0, r2, beq_then.12531
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.12532
beq_then.12531:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12533
	addi	r2, r0, 1
	j	feq_cont.12534
feq_else.12533:
	addi	r2, r0, 0
feq_cont.12534:
	beqi	0, r2, beq_then.12535
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.12536
beq_then.12535:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.12537
	addi	r2, r0, 0
	j	fle_cont.12538
fle_else.12537:
	addi	r2, r0, 1
fle_cont.12538:
	beqi	0, r2, beq_then.12539
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.12540
beq_then.12539:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.12540:
beq_cont.12536:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.12532:
	fsw	f1, 0(r5)
	flw	f1, 1(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12541
	addi	r2, r0, 1
	j	feq_cont.12542
feq_else.12541:
	addi	r2, r0, 0
feq_cont.12542:
	beqi	0, r2, beq_then.12543
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.12544
beq_then.12543:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12545
	addi	r2, r0, 1
	j	feq_cont.12546
feq_else.12545:
	addi	r2, r0, 0
feq_cont.12546:
	beqi	0, r2, beq_then.12547
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.12548
beq_then.12547:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.12549
	addi	r2, r0, 0
	j	fle_cont.12550
fle_else.12549:
	addi	r2, r0, 1
fle_cont.12550:
	beqi	0, r2, beq_then.12551
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.12552
beq_then.12551:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.12552:
beq_cont.12548:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.12544:
	fsw	f1, 1(r5)
	flw	f1, 2(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12553
	addi	r2, r0, 1
	j	feq_cont.12554
feq_else.12553:
	addi	r2, r0, 0
feq_cont.12554:
	beqi	0, r2, beq_then.12555
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.12556
beq_then.12555:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12557
	addi	r2, r0, 1
	j	feq_cont.12558
feq_else.12557:
	addi	r2, r0, 0
feq_cont.12558:
	beqi	0, r2, beq_then.12559
	flup	f2, 0		# fli	f2, 0.000000
	j	beq_cont.12560
beq_then.12559:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.12561
	addi	r2, r0, 0
	j	fle_cont.12562
fle_else.12561:
	addi	r2, r0, 1
fle_cont.12562:
	beqi	0, r2, beq_then.12563
	flup	f2, 2		# fli	f2, 1.000000
	j	beq_cont.12564
beq_then.12563:
	flup	f2, 11		# fli	f2, -1.000000
beq_cont.12564:
beq_cont.12560:
	fmul	f1, f1, f1
	fdiv	f1, f2, f1
beq_cont.12556:
	fsw	f1, 2(r5)
beq_cont.12524:
	lw	r1, 4(r3)
	beqi	0, r1, beq_then.12565
	lw	r1, 5(r3)
	lw	r2, 10(r3)
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	rotate_quadratic_matrix.3115				#	bl	rotate_quadratic_matrix.3115
	addi	r3, r3, -13
	lw	r31, 12(r3)
	j	beq_cont.12566
beq_then.12565:
beq_cont.12566:
	addi	r1, r0, 1
	jr	r31				#
beq_then.12516:
	addi	r1, r0, 0
	jr	r31				#
read_object.3120:
	addi	r2, r0, 60
	ble	r2, r1, ble_then.12567
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.3118				#	bl	read_nth_object.3118
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.12568
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, 60
	ble	r2, r1, ble_then.12569
	sw	r1, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_nth_object.3118				#	bl	read_nth_object.3118
	addi	r3, r3, -3
	lw	r31, 2(r3)
	beqi	0, r1, beq_then.12570
	lw	r1, 1(r3)
	addi	r1, r1, 1
	j	read_object.3120
beq_then.12570:
	addi	r1, r0, 10000
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.12569:
	jr	r31				#
beq_then.12568:
	addi	r1, r0, 10000
	lw	r2, 0(r3)
	sw	r2, 0(r1)
	jr	r31				#
ble_then.12567:
	jr	r31				#
read_all_object.3122:
	addi	r1, r0, 0
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_nth_object.3118				#	bl	read_nth_object.3118
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	0, r1, beq_then.12575
	addi	r1, r0, 1
	j	read_object.3120
beq_then.12575:
	addi	r1, r0, 10000
	lw	r2, 0(r3)
	sw	r2, 0(r1)
	jr	r31				#
read_net_item.3124:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.12577
	lw	r2, 0(r3)
	addi	r5, r2, 1
	sw	r1, 1(r3)
	sw	r5, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -4
	lw	r31, 3(r3)
	beqi	-1, r1, beq_then.12578
	lw	r2, 2(r3)
	addi	r5, r2, 1
	sw	r1, 3(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3124				#	bl	read_net_item.3124
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.12579
beq_then.12578:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -5
	lw	r31, 4(r3)
beq_cont.12579:
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.12577:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	addi	r2, r0, -1
	j	lib_create_array
read_or_network.3126:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.12580
	addi	r2, r0, 1
	sw	r1, 1(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_net_item.3124				#	bl	read_net_item.3124
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	add	r2, r0, r1
	j	beq_cont.12581
beq_then.12580:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
	add	r2, r0, r1				# mr	r2, r1
beq_cont.12581:
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.12582
	lw	r1, 0(r3)
	addi	r5, r1, 1
	addi	r6, r0, 0
	sw	r2, 2(r3)
	sw	r5, 3(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	read_net_item.3124				#	bl	read_net_item.3124
	addi	r3, r3, -5
	lw	r31, 4(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.12583
	lw	r1, 3(r3)
	addi	r5, r1, 1
	sw	r2, 4(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	read_or_network.3126				#	bl	read_or_network.3126
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	j	beq_cont.12584
beq_then.12583:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.12584:
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	add	r30, r1, r2
	sw	r5, 0(r30)
	jr	r31				#
beq_then.12582:
	lw	r1, 0(r3)
	addi	r1, r1, 1
	j	lib_create_array
read_and_network.3128:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	lib_read_int				#	bl	lib_read_int
	addi	r3, r3, -2
	lw	r31, 1(r3)
	beqi	-1, r1, beq_then.12585
	addi	r2, r0, 1
	sw	r1, 1(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_net_item.3124				#	bl	read_net_item.3124
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	j	beq_cont.12586
beq_then.12585:
	addi	r1, r0, 1
	addi	r2, r0, -1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
beq_cont.12586:
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.12587
	addi	r2, r0, 10672
	lw	r5, 0(r3)
	add	r30, r2, r5
	sw	r1, 0(r30)
	addi	r1, r5, 1
	addi	r2, r0, 0
	sw	r1, 2(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	read_net_item.3124				#	bl	read_net_item.3124
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.12588
	addi	r2, r0, 10672
	lw	r5, 2(r3)
	add	r30, r2, r5
	sw	r1, 0(r30)
	addi	r1, r5, 1
	j	read_and_network.3128
beq_then.12588:
	jr	r31				#
beq_then.12587:
	jr	r31				#
read_parameter.3130:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_screen_settings.3111				#	bl	read_screen_settings.3111
	addi	r3, r3, -1
	lw	r31, 0(r3)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_light.3113				#	bl	read_light.3113
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_object.3120				#	bl	read_object.3120
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 0
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_net_item.3124				#	bl	read_net_item.3124
	addi	r3, r3, -1
	lw	r31, 0(r3)
	lw	r2, 0(r1)
	beqi	-1, r2, beq_then.12591
	addi	r2, r0, 10672
	sw	r1, 0(r2)
	addi	r1, r0, 1
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	read_and_network.3128				#	bl	read_and_network.3128
	addi	r3, r3, -1
	lw	r31, 0(r3)
	j	beq_cont.12592
beq_then.12591:
beq_cont.12592:
	addi	r1, r0, 10723
	addi	r2, r0, 0
	sw	r1, 0(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	read_net_item.3124				#	bl	read_net_item.3124
	addi	r3, r3, -2
	lw	r31, 1(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 0(r2)
	beqi	-1, r1, beq_then.12593
	addi	r1, r0, 1
	sw	r2, 1(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	read_or_network.3126				#	bl	read_or_network.3126
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r2, 1(r3)
	sw	r2, 0(r1)
	j	beq_cont.12594
beq_then.12593:
	addi	r1, r0, 1
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -3
	lw	r31, 2(r3)
beq_cont.12594:
	lw	r2, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#
solver_rect_surface.3132:
	add	r30, r2, r5
	flw	f4, 0(r30)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.12596
	addi	r8, r0, 1
	j	feq_cont.12597
feq_else.12596:
	addi	r8, r0, 0
feq_cont.12597:
	beqi	0, r8, beq_then.12598
	addi	r1, r0, 0
	jr	r31				#
beq_then.12598:
	lw	r8, 4(r1)
	lw	r1, 6(r1)
	add	r30, r2, r5
	flw	f4, 0(r30)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.12599
	addi	r9, r0, 0
	j	fle_cont.12600
fle_else.12599:
	addi	r9, r0, 1
fle_cont.12600:
	beqi	0, r1, beq_then.12601
	beqi	0, r9, beq_then.12603
	addi	r1, r0, 0
	j	beq_cont.12604
beq_then.12603:
	addi	r1, r0, 1
beq_cont.12604:
	j	beq_cont.12602
beq_then.12601:
	add	r1, r0, r9
beq_cont.12602:
	add	r30, r8, r5
	flw	f4, 0(r30)
	beqi	0, r1, beq_then.12605
	j	beq_cont.12606
beq_then.12605:
	fneg	f4, f4
beq_cont.12606:
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
	beq	r0, r30, fle_else.12607
	j	fle_cont.12608
fle_else.12607:
	fneg	f2, f2
fle_cont.12608:
	fle	r30, f4, f2
	beq	r0, r30, fle_else.12609
	addi	r1, r0, 0
	jr	r31				#
fle_else.12609:
	add	r30, r8, r7
	flw	f2, 0(r30)
	add	r30, r2, r7
	flw	f4, 0(r30)
	fmul	f4, f1, f4
	fadd	f3, f4, f3
	fle	r30, f0, f3
	beq	r0, r30, fle_else.12610
	j	fle_cont.12611
fle_else.12610:
	fneg	f3, f3
fle_cont.12611:
	fle	r30, f2, f3
	beq	r0, r30, fle_else.12612
	addi	r1, r0, 0
	jr	r31				#
fle_else.12612:
	addi	r1, r0, 10724
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
solver_rect.3141:
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
	jal	solver_rect_surface.3132				#	bl	solver_rect_surface.3132
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.12613
	addi	r1, r0, 1
	jr	r31				#
beq_then.12613:
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
	jal	solver_rect_surface.3132				#	bl	solver_rect_surface.3132
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.12614
	addi	r1, r0, 2
	jr	r31				#
beq_then.12614:
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
	jal	solver_rect_surface.3132				#	bl	solver_rect_surface.3132
	addi	r3, r3, -9
	lw	r31, 8(r3)
	beqi	0, r1, beq_then.12615
	addi	r1, r0, 3
	jr	r31				#
beq_then.12615:
	addi	r1, r0, 0
	jr	r31				#
solver_surface.3147:
	lw	r1, 4(r1)
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r1, 6(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	veciprod.3013				#	bl	veciprod.3013
	addi	r3, r3, -8
	lw	r31, 7(r3)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.12616
	addi	r1, r0, 0
	j	fle_cont.12617
fle_else.12616:
	addi	r1, r0, 1
fle_cont.12617:
	beqi	0, r1, beq_then.12618
	addi	r1, r0, 10724
	lw	r2, 6(r3)
	flw	f2, 0(r2)
	flw	f3, 4(r3)
	fmul	f2, f2, f3
	flw	f3, 1(r2)
	flw	f4, 2(r3)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flw	f3, 2(r2)
	flw	f4, 0(r3)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	fneg	f2, f2
	fdiv	f1, f2, f1
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.12618:
	addi	r1, r0, 0
	jr	r31				#
quadratic.3153:
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
	beqi	0, r2, beq_then.12619
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
beq_then.12619:
	fadd	f1, f0, f4
	jr	r31				#
bilinear.3158:
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
	beqi	0, r2, beq_then.12620
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
beq_then.12620:
	fadd	f1, f0, f7
	jr	r31				#
solver_second.3166:
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
	jal	quadratic.3153				#	bl	quadratic.3153
	addi	r3, r3, -9
	lw	r31, 8(r3)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12621
	addi	r1, r0, 1
	j	feq_cont.12622
feq_else.12621:
	addi	r1, r0, 0
feq_cont.12622:
	beqi	0, r1, beq_then.12623
	addi	r1, r0, 0
	jr	r31				#
beq_then.12623:
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
	jal	bilinear.3158				#	bl	bilinear.3158
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
	jal	quadratic.3153				#	bl	quadratic.3153
	addi	r3, r3, -13
	lw	r31, 12(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.12624
	j	beq_cont.12625
beq_then.12624:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.12625:
	flw	f2, 10(r3)
	fmul	f3, f2, f2
	flw	f4, 8(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.12626
	addi	r2, r0, 0
	j	fle_cont.12627
fle_else.12626:
	addi	r2, r0, 1
fle_cont.12627:
	beqi	0, r2, beq_then.12628
	fsqrt	f1, f1
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.12629
	j	beq_cont.12630
beq_then.12629:
	fneg	f1, f1
beq_cont.12630:
	addi	r1, r0, 10724
	fsub	f1, f1, f2
	fdiv	f1, f1, f4
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.12628:
	addi	r1, r0, 0
	jr	r31				#
solver.3172:
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
	beqi	1, r5, beq_then.12631
	beqi	2, r5, beq_then.12632
	j	solver_second.3166
beq_then.12632:
	lw	r1, 4(r1)
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	fsw	f1, 4(r3)
	sw	r1, 6(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	veciprod.3013				#	bl	veciprod.3013
	addi	r3, r3, -8
	lw	r31, 7(r3)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.12633
	addi	r1, r0, 0
	j	fle_cont.12634
fle_else.12633:
	addi	r1, r0, 1
fle_cont.12634:
	beqi	0, r1, beq_then.12635
	addi	r1, r0, 10724
	lw	r2, 6(r3)
	flw	f2, 0(r2)
	flw	f3, 4(r3)
	fmul	f2, f2, f3
	flw	f3, 1(r2)
	flw	f4, 2(r3)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	flw	f3, 2(r2)
	flw	f4, 0(r3)
	fmul	f3, f3, f4
	fadd	f2, f2, f3
	fneg	f2, f2
	fdiv	f1, f2, f1
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.12635:
	addi	r1, r0, 0
	jr	r31				#
beq_then.12631:
	j	solver_rect.3141
solver_rect_fast.3176:
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
	beq	r0, r30, fle_else.12636
	j	fle_cont.12637
fle_else.12636:
	fneg	f6, f6
fle_cont.12637:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.12638
	addi	r6, r0, 0
	j	fle_cont.12639
fle_else.12638:
	lw	r6, 4(r1)
	flw	f5, 2(r6)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.12640
	j	fle_cont.12641
fle_else.12640:
	fneg	f6, f6
fle_cont.12641:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.12642
	addi	r6, r0, 0
	j	fle_cont.12643
fle_else.12642:
	flw	f5, 1(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.12644
	addi	r6, r0, 1
	j	feq_cont.12645
feq_else.12644:
	addi	r6, r0, 0
feq_cont.12645:
	beqi	0, r6, beq_then.12646
	addi	r6, r0, 0
	j	beq_cont.12647
beq_then.12646:
	addi	r6, r0, 1
beq_cont.12647:
fle_cont.12643:
fle_cont.12639:
	beqi	0, r6, beq_then.12648
	addi	r1, r0, 10724
	fsw	f4, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.12648:
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
	beq	r0, r30, fle_else.12649
	j	fle_cont.12650
fle_else.12649:
	fneg	f6, f6
fle_cont.12650:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.12651
	addi	r6, r0, 0
	j	fle_cont.12652
fle_else.12651:
	lw	r6, 4(r1)
	flw	f5, 2(r6)
	flw	f6, 2(r2)
	fmul	f6, f4, f6
	fadd	f6, f6, f3
	fle	r30, f0, f6
	beq	r0, r30, fle_else.12653
	j	fle_cont.12654
fle_else.12653:
	fneg	f6, f6
fle_cont.12654:
	fle	r30, f5, f6
	beq	r0, r30, fle_else.12655
	addi	r6, r0, 0
	j	fle_cont.12656
fle_else.12655:
	flw	f5, 3(r5)
	feq	r30, f5, f0
	beq	r0, r30, feq_else.12657
	addi	r6, r0, 1
	j	feq_cont.12658
feq_else.12657:
	addi	r6, r0, 0
feq_cont.12658:
	beqi	0, r6, beq_then.12659
	addi	r6, r0, 0
	j	beq_cont.12660
beq_then.12659:
	addi	r6, r0, 1
beq_cont.12660:
fle_cont.12656:
fle_cont.12652:
	beqi	0, r6, beq_then.12661
	addi	r1, r0, 10724
	fsw	f4, 0(r1)
	addi	r1, r0, 2
	jr	r31				#
beq_then.12661:
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
	beq	r0, r30, fle_else.12662
	j	fle_cont.12663
fle_else.12662:
	fneg	f1, f1
fle_cont.12663:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.12664
	addi	r1, r0, 0
	j	fle_cont.12665
fle_else.12664:
	lw	r1, 4(r1)
	flw	f1, 1(r1)
	flw	f4, 1(r2)
	fmul	f4, f3, f4
	fadd	f2, f4, f2
	fle	r30, f0, f2
	beq	r0, r30, fle_else.12666
	j	fle_cont.12667
fle_else.12666:
	fneg	f2, f2
fle_cont.12667:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.12668
	addi	r1, r0, 0
	j	fle_cont.12669
fle_else.12668:
	flw	f1, 5(r5)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12670
	addi	r1, r0, 1
	j	feq_cont.12671
feq_else.12670:
	addi	r1, r0, 0
feq_cont.12671:
	beqi	0, r1, beq_then.12672
	addi	r1, r0, 0
	j	beq_cont.12673
beq_then.12672:
	addi	r1, r0, 1
beq_cont.12673:
fle_cont.12669:
fle_cont.12665:
	beqi	0, r1, beq_then.12674
	addi	r1, r0, 10724
	fsw	f3, 0(r1)
	addi	r1, r0, 3
	jr	r31				#
beq_then.12674:
	addi	r1, r0, 0
	jr	r31				#
solver_surface_fast.3183:
	flw	f4, 0(r2)
	fle	r30, f0, f4
	beq	r0, r30, fle_else.12675
	addi	r1, r0, 0
	j	fle_cont.12676
fle_else.12675:
	addi	r1, r0, 1
fle_cont.12676:
	beqi	0, r1, beq_then.12677
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
beq_then.12677:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast.3189:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.12678
	addi	r5, r0, 1
	j	feq_cont.12679
feq_else.12678:
	addi	r5, r0, 0
feq_cont.12679:
	beqi	0, r5, beq_then.12680
	addi	r1, r0, 0
	jr	r31				#
beq_then.12680:
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
	jal	quadratic.3153				#	bl	quadratic.3153
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 6(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.12682
	j	beq_cont.12683
beq_then.12682:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.12683:
	flw	f2, 4(r3)
	fmul	f3, f2, f2
	flw	f4, 2(r3)
	fmul	f1, f4, f1
	fsub	f1, f3, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.12684
	addi	r2, r0, 0
	j	fle_cont.12685
fle_else.12684:
	addi	r2, r0, 1
fle_cont.12685:
	beqi	0, r2, beq_then.12686
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.12687
	addi	r1, r0, 10724
	fsqrt	f1, f1
	fadd	f1, f2, f1
	lw	r2, 0(r3)
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	j	beq_cont.12688
beq_then.12687:
	addi	r1, r0, 10724
	fsqrt	f1, f1
	fsub	f1, f2, f1
	lw	r2, 0(r3)
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
beq_cont.12688:
	addi	r1, r0, 1
	jr	r31				#
beq_then.12686:
	addi	r1, r0, 0
	jr	r31				#
solver_fast.3195:
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
	beqi	1, r1, beq_then.12689
	beqi	2, r1, beq_then.12690
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	j	solver_second_fast.3189
beq_then.12690:
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	j	solver_surface_fast.3183
beq_then.12689:
	lw	r2, 0(r2)
	add	r1, r0, r6				# mr	r1, r6
	j	solver_rect_fast.3176
solver_surface_fast2.3199:
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12691
	addi	r1, r0, 0
	j	fle_cont.12692
fle_else.12691:
	addi	r1, r0, 1
fle_cont.12692:
	beqi	0, r1, beq_then.12693
	addi	r1, r0, 10724
	flw	f1, 0(r2)
	flw	f2, 3(r5)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	addi	r1, r0, 1
	jr	r31				#
beq_then.12693:
	addi	r1, r0, 0
	jr	r31				#
solver_second_fast2.3206:
	flw	f4, 0(r2)
	feq	r30, f4, f0
	beq	r0, r30, feq_else.12694
	addi	r6, r0, 1
	j	feq_cont.12695
feq_else.12694:
	addi	r6, r0, 0
feq_cont.12695:
	beqi	0, r6, beq_then.12696
	addi	r1, r0, 0
	jr	r31				#
beq_then.12696:
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
	beq	r0, r30, fle_else.12697
	addi	r5, r0, 0
	j	fle_cont.12698
fle_else.12697:
	addi	r5, r0, 1
fle_cont.12698:
	beqi	0, r5, beq_then.12699
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.12700
	addi	r1, r0, 10724
	fsqrt	f2, f2
	fadd	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
	j	beq_cont.12701
beq_then.12700:
	addi	r1, r0, 10724
	fsqrt	f2, f2
	fsub	f1, f1, f2
	flw	f2, 4(r2)
	fmul	f1, f1, f2
	fsw	f1, 0(r1)
beq_cont.12701:
	addi	r1, r0, 1
	jr	r31				#
beq_then.12699:
	addi	r1, r0, 0
	jr	r31				#
solver_fast2.3213:
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
	beqi	1, r7, beq_then.12702
	beqi	2, r7, beq_then.12703
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	j	solver_second_fast2.3206
beq_then.12703:
	flw	f1, 0(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12704
	addi	r2, r0, 0
	j	fle_cont.12705
fle_else.12704:
	addi	r2, r0, 1
fle_cont.12705:
	beqi	0, r2, beq_then.12706
	addi	r2, r0, 10724
	flw	f1, 0(r1)
	flw	f2, 3(r6)
	fmul	f1, f1, f2
	fsw	f1, 0(r2)
	addi	r1, r0, 1
	jr	r31				#
beq_then.12706:
	addi	r1, r0, 0
	jr	r31				#
beq_then.12702:
	lw	r2, 0(r2)
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r1				# mr	r5, r1
	add	r1, r0, r28				# mr	r1, r28
	j	solver_rect_fast.3176
setup_rect_table.3216:
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
	beq	r0, r30, feq_else.12707
	addi	r5, r0, 1
	j	feq_cont.12708
feq_else.12707:
	addi	r5, r0, 0
feq_cont.12708:
	beqi	0, r5, beq_then.12709
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 1(r1)
	j	beq_cont.12710
beq_then.12709:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12711
	addi	r7, r0, 0
	j	fle_cont.12712
fle_else.12711:
	addi	r7, r0, 1
fle_cont.12712:
	beqi	0, r6, beq_then.12713
	beqi	0, r7, beq_then.12715
	addi	r6, r0, 0
	j	beq_cont.12716
beq_then.12715:
	addi	r6, r0, 1
beq_cont.12716:
	j	beq_cont.12714
beq_then.12713:
	add	r6, r0, r7
beq_cont.12714:
	lw	r7, 4(r5)
	flw	f1, 0(r7)
	beqi	0, r6, beq_then.12717
	j	beq_cont.12718
beq_then.12717:
	fneg	f1, f1
beq_cont.12718:
	fsw	f1, 0(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 0(r2)
	fdiv	f1, f1, f2
	fsw	f1, 1(r1)
beq_cont.12710:
	flw	f1, 1(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12719
	addi	r5, r0, 1
	j	feq_cont.12720
feq_else.12719:
	addi	r5, r0, 0
feq_cont.12720:
	beqi	0, r5, beq_then.12721
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 3(r1)
	j	beq_cont.12722
beq_then.12721:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 1(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12723
	addi	r7, r0, 0
	j	fle_cont.12724
fle_else.12723:
	addi	r7, r0, 1
fle_cont.12724:
	beqi	0, r6, beq_then.12725
	beqi	0, r7, beq_then.12727
	addi	r6, r0, 0
	j	beq_cont.12728
beq_then.12727:
	addi	r6, r0, 1
beq_cont.12728:
	j	beq_cont.12726
beq_then.12725:
	add	r6, r0, r7
beq_cont.12726:
	lw	r7, 4(r5)
	flw	f1, 1(r7)
	beqi	0, r6, beq_then.12729
	j	beq_cont.12730
beq_then.12729:
	fneg	f1, f1
beq_cont.12730:
	fsw	f1, 2(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 1(r2)
	fdiv	f1, f1, f2
	fsw	f1, 3(r1)
beq_cont.12722:
	flw	f1, 2(r2)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12731
	addi	r5, r0, 1
	j	feq_cont.12732
feq_else.12731:
	addi	r5, r0, 0
feq_cont.12732:
	beqi	0, r5, beq_then.12733
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 5(r1)
	j	beq_cont.12734
beq_then.12733:
	lw	r5, 0(r3)
	lw	r6, 6(r5)
	flw	f1, 2(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12735
	addi	r7, r0, 0
	j	fle_cont.12736
fle_else.12735:
	addi	r7, r0, 1
fle_cont.12736:
	beqi	0, r6, beq_then.12737
	beqi	0, r7, beq_then.12739
	addi	r6, r0, 0
	j	beq_cont.12740
beq_then.12739:
	addi	r6, r0, 1
beq_cont.12740:
	j	beq_cont.12738
beq_then.12737:
	add	r6, r0, r7
beq_cont.12738:
	lw	r5, 4(r5)
	flw	f1, 2(r5)
	beqi	0, r6, beq_then.12741
	j	beq_cont.12742
beq_then.12741:
	fneg	f1, f1
beq_cont.12742:
	fsw	f1, 4(r1)
	flup	f1, 2		# fli	f1, 1.000000
	flw	f2, 2(r2)
	fdiv	f1, f1, f2
	fsw	f1, 5(r1)
beq_cont.12734:
	jr	r31				#
setup_surface_table.3219:
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
	beq	r0, r30, fle_else.12743
	addi	r2, r0, 0
	j	fle_cont.12744
fle_else.12743:
	addi	r2, r0, 1
fle_cont.12744:
	beqi	0, r2, beq_then.12745
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
	j	beq_cont.12746
beq_then.12745:
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r1)
beq_cont.12746:
	jr	r31				#
setup_second_table.3222:
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
	jal	quadratic.3153				#	bl	quadratic.3153
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
	beqi	0, r6, beq_then.12747
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
	j	beq_cont.12748
beq_then.12747:
	fsw	f2, 1(r5)
	fsw	f3, 2(r5)
	fsw	f4, 3(r5)
beq_cont.12748:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12749
	addi	r1, r0, 1
	j	feq_cont.12750
feq_else.12749:
	addi	r1, r0, 0
feq_cont.12750:
	beqi	0, r1, beq_then.12751
	j	beq_cont.12752
beq_then.12751:
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f1, f2, f1
	fsw	f1, 4(r5)
beq_cont.12752:
	add	r1, r0, r5
	jr	r31				#
iter_setup_dirvec_constants.3225:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.12753
	jr	r31				#
ble_then.12753:
	addi	r5, r0, 10001
	add	r30, r5, r2
	lw	r5, 0(r30)
	lw	r6, 1(r1)
	lw	r7, 0(r1)
	lw	r8, 1(r5)
	sw	r1, 0(r3)
	beqi	1, r8, beq_then.12755
	beqi	2, r8, beq_then.12757
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_second_table.3222				#	bl	setup_second_table.3222
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	j	beq_cont.12758
beq_then.12757:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_surface_table.3219				#	bl	setup_surface_table.3219
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.12758:
	j	beq_cont.12756
beq_then.12755:
	sw	r2, 1(r3)
	sw	r6, 2(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	setup_rect_table.3216				#	bl	setup_rect_table.3216
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
beq_cont.12756:
	addi	r2, r2, -1
	lw	r1, 0(r3)
	j	iter_setup_dirvec_constants.3225
setup_dirvec_constants.3228:
	addi	r2, r0, 10000
	lw	r2, 0(r2)
	addi	r2, r2, -1
	j	iter_setup_dirvec_constants.3225
setup_startp_constants.3230:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.12759
	jr	r31				#
ble_then.12759:
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
	beqi	2, r7, beq_then.12761
	blei	2, r7, ble_then.12763
	flw	f1, 0(r6)
	flw	f2, 1(r6)
	flw	f3, 2(r6)
	sw	r6, 2(r3)
	sw	r7, 3(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	quadratic.3153				#	bl	quadratic.3153
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	beqi	3, r1, beq_then.12765
	j	beq_cont.12766
beq_then.12765:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.12766:
	lw	r1, 2(r3)
	fsw	f1, 3(r1)
	j	ble_cont.12764
ble_then.12763:
ble_cont.12764:
	j	beq_cont.12762
beq_then.12761:
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
beq_cont.12762:
	lw	r1, 1(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	j	setup_startp_constants.3230
setup_startp.3233:
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
	j	setup_startp_constants.3230
is_rect_outside.3235:
	lw	r2, 4(r1)
	flw	f4, 0(r2)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12767
	j	fle_cont.12768
fle_else.12767:
	fneg	f1, f1
fle_cont.12768:
	fle	r30, f4, f1
	beq	r0, r30, fle_else.12769
	addi	r2, r0, 0
	j	fle_cont.12770
fle_else.12769:
	lw	r2, 4(r1)
	flw	f1, 1(r2)
	fle	r30, f0, f2
	beq	r0, r30, fle_else.12771
	j	fle_cont.12772
fle_else.12771:
	fneg	f2, f2
fle_cont.12772:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.12773
	addi	r2, r0, 0
	j	fle_cont.12774
fle_else.12773:
	lw	r2, 4(r1)
	flw	f1, 2(r2)
	fle	r30, f0, f3
	beq	r0, r30, fle_else.12775
	fadd	f2, f0, f3
	j	fle_cont.12776
fle_else.12775:
	fneg	f2, f3
fle_cont.12776:
	fle	r30, f1, f2
	beq	r0, r30, fle_else.12777
	addi	r2, r0, 0
	j	fle_cont.12778
fle_else.12777:
	addi	r2, r0, 1
fle_cont.12778:
fle_cont.12774:
fle_cont.12770:
	beqi	0, r2, beq_then.12779
	lw	r1, 6(r1)
	jr	r31				#
beq_then.12779:
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.12780
	addi	r1, r0, 0
	jr	r31				#
beq_then.12780:
	addi	r1, r0, 1
	jr	r31				#
is_plane_outside.3240:
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
	beq	r0, r30, fle_else.12781
	addi	r2, r0, 0
	j	fle_cont.12782
fle_else.12781:
	addi	r2, r0, 1
fle_cont.12782:
	beqi	0, r1, beq_then.12783
	beqi	0, r2, beq_then.12785
	addi	r1, r0, 0
	j	beq_cont.12786
beq_then.12785:
	addi	r1, r0, 1
beq_cont.12786:
	j	beq_cont.12784
beq_then.12783:
	add	r1, r0, r2
beq_cont.12784:
	beqi	0, r1, beq_then.12787
	addi	r1, r0, 0
	jr	r31				#
beq_then.12787:
	addi	r1, r0, 1
	jr	r31				#
is_second_outside.3245:
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3153				#	bl	quadratic.3153
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.12788
	j	beq_cont.12789
beq_then.12788:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.12789:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12790
	addi	r2, r0, 0
	j	fle_cont.12791
fle_else.12790:
	addi	r2, r0, 1
fle_cont.12791:
	beqi	0, r1, beq_then.12792
	beqi	0, r2, beq_then.12794
	addi	r1, r0, 0
	j	beq_cont.12795
beq_then.12794:
	addi	r1, r0, 1
beq_cont.12795:
	j	beq_cont.12793
beq_then.12792:
	add	r1, r0, r2
beq_cont.12793:
	beqi	0, r1, beq_then.12796
	addi	r1, r0, 0
	jr	r31				#
beq_then.12796:
	addi	r1, r0, 1
	jr	r31				#
is_outside.3250:
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
	beqi	1, r2, beq_then.12797
	beqi	2, r2, beq_then.12798
	sw	r1, 0(r3)
	sw	r31, 1(r3)
	addi	r3, r3, 2
	jal	quadratic.3153				#	bl	quadratic.3153
	addi	r3, r3, -2
	lw	r31, 1(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r1)
	beqi	3, r2, beq_then.12799
	j	beq_cont.12800
beq_then.12799:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f1, f1, f2
beq_cont.12800:
	lw	r1, 6(r1)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12801
	addi	r2, r0, 0
	j	fle_cont.12802
fle_else.12801:
	addi	r2, r0, 1
fle_cont.12802:
	beqi	0, r1, beq_then.12803
	beqi	0, r2, beq_then.12805
	addi	r1, r0, 0
	j	beq_cont.12806
beq_then.12805:
	addi	r1, r0, 1
beq_cont.12806:
	j	beq_cont.12804
beq_then.12803:
	add	r1, r0, r2
beq_cont.12804:
	beqi	0, r1, beq_then.12807
	addi	r1, r0, 0
	jr	r31				#
beq_then.12807:
	addi	r1, r0, 1
	jr	r31				#
beq_then.12798:
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
	beq	r0, r30, fle_else.12808
	addi	r2, r0, 0
	j	fle_cont.12809
fle_else.12808:
	addi	r2, r0, 1
fle_cont.12809:
	beqi	0, r1, beq_then.12810
	beqi	0, r2, beq_then.12812
	addi	r1, r0, 0
	j	beq_cont.12813
beq_then.12812:
	addi	r1, r0, 1
beq_cont.12813:
	j	beq_cont.12811
beq_then.12810:
	add	r1, r0, r2
beq_cont.12811:
	beqi	0, r1, beq_then.12814
	addi	r1, r0, 0
	jr	r31				#
beq_then.12814:
	addi	r1, r0, 1
	jr	r31				#
beq_then.12797:
	j	is_rect_outside.3235
check_all_inside.3255:
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.12815
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
	beqi	1, r6, beq_then.12816
	beqi	2, r6, beq_then.12818
	add	r1, r0, r5				# mr	r1, r5
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	is_second_outside.3245				#	bl	is_second_outside.3245
	addi	r3, r3, -9
	lw	r31, 8(r3)
	j	beq_cont.12819
beq_then.12818:
	add	r1, r0, r5				# mr	r1, r5
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	is_plane_outside.3240				#	bl	is_plane_outside.3240
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.12819:
	j	beq_cont.12817
beq_then.12816:
	add	r1, r0, r5				# mr	r1, r5
	fadd	f3, f0, f6				# fmr	f3, f6
	fadd	f2, f0, f5				# fmr	f2, f5
	fadd	f1, f0, f4				# fmr	f1, f4
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	is_rect_outside.3235				#	bl	is_rect_outside.3235
	addi	r3, r3, -9
	lw	r31, 8(r3)
beq_cont.12817:
	beqi	0, r1, beq_then.12820
	addi	r1, r0, 0
	jr	r31				#
beq_then.12820:
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 6(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.12821
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r5, 0(r30)
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	sw	r1, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	is_outside.3250				#	bl	is_outside.3250
	addi	r3, r3, -10
	lw	r31, 9(r3)
	beqi	0, r1, beq_then.12822
	addi	r1, r0, 0
	jr	r31				#
beq_then.12822:
	lw	r1, 8(r3)
	addi	r1, r1, 1
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r2, 6(r3)
	j	check_all_inside.3255
beq_then.12821:
	addi	r1, r0, 1
	jr	r31				#
beq_then.12815:
	addi	r1, r0, 1
	jr	r31				#
shadow_check_and_group.3261:
	lw	r5, 1(r29)
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.12823
	add	r30, r2, r1
	lw	r6, 0(r30)
	addi	r7, r0, 10727
	sw	r2, 0(r3)
	sw	r29, 1(r3)
	sw	r1, 2(r3)
	sw	r6, 3(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_fast.3195				#	bl	solver_fast.3195
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r2, r0, 10724
	flw	f1, 0(r2)
	beqi	0, r1, beq_then.12824
	flup	f2, 28		# fli	f2, -0.200000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12826
	addi	r1, r0, 0
	j	fle_cont.12827
fle_else.12826:
	addi	r1, r0, 1
fle_cont.12827:
	j	beq_cont.12825
beq_then.12824:
	addi	r1, r0, 0
beq_cont.12825:
	beqi	0, r1, beq_then.12828
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
	beqi	-1, r1, beq_then.12829
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
	jal	is_outside.3250				#	bl	is_outside.3250
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.12831
	addi	r1, r0, 0
	j	beq_cont.12832
beq_then.12831:
	addi	r1, r0, 1
	flw	f1, 8(r3)
	flw	f2, 6(r3)
	flw	f3, 4(r3)
	lw	r2, 0(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	check_all_inside.3255				#	bl	check_all_inside.3255
	addi	r3, r3, -11
	lw	r31, 10(r3)
beq_cont.12832:
	j	beq_cont.12830
beq_then.12829:
	addi	r1, r0, 1
beq_cont.12830:
	beqi	0, r1, beq_then.12833
	addi	r1, r0, 1
	jr	r31				#
beq_then.12833:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.12828:
	addi	r1, r0, 10001
	lw	r2, 3(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.12834
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 0(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.12834:
	addi	r1, r0, 0
	jr	r31				#
beq_then.12823:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_group.3264:
	lw	r5, 1(r29)
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.12835
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
	beqi	0, r1, beq_then.12836
	addi	r1, r0, 1
	jr	r31				#
beq_then.12836:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.12837
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
	beqi	0, r1, beq_then.12838
	addi	r1, r0, 1
	jr	r31				#
beq_then.12838:
	lw	r1, 4(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.12837:
	addi	r1, r0, 0
	jr	r31				#
beq_then.12835:
	addi	r1, r0, 0
	jr	r31				#
shadow_check_one_or_matrix.3267:
	lw	r5, 3(r29)
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	add	r30, r2, r1
	lw	r8, 0(r30)
	lw	r9, 0(r8)
	beqi	-1, r9, beq_then.12839
	addi	r10, r0, 99
	sw	r5, 0(r3)
	sw	r6, 1(r3)
	sw	r8, 2(r3)
	sw	r2, 3(r3)
	sw	r29, 4(r3)
	sw	r1, 5(r3)
	beq	r9, r10, beq_then.12840
	addi	r10, r0, 10727
	add	r5, r0, r10				# mr	r5, r10
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r9				# mr	r1, r9
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	solver_fast.3195				#	bl	solver_fast.3195
	addi	r3, r3, -7
	lw	r31, 6(r3)
	beqi	0, r1, beq_then.12842
	flup	f1, 30		# fli	f1, -0.100000
	addi	r1, r0, 10724
	flw	f2, 0(r1)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.12844
	addi	r1, r0, 0
	j	fle_cont.12845
fle_else.12844:
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.12846
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
	beqi	0, r1, beq_then.12848
	addi	r1, r0, 1
	j	beq_cont.12849
beq_then.12848:
	addi	r1, r0, 2
	lw	r2, 2(r3)
	lw	r29, 0(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.12849:
	j	beq_cont.12847
beq_then.12846:
	addi	r1, r0, 0
beq_cont.12847:
	beqi	0, r1, beq_then.12850
	addi	r1, r0, 1
	j	beq_cont.12851
beq_then.12850:
	addi	r1, r0, 0
beq_cont.12851:
fle_cont.12845:
	j	beq_cont.12843
beq_then.12842:
	addi	r1, r0, 0
beq_cont.12843:
	j	beq_cont.12841
beq_then.12840:
	addi	r1, r0, 1
beq_cont.12841:
	beqi	0, r1, beq_then.12852
	lw	r1, 2(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.12853
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
	beqi	0, r1, beq_then.12855
	addi	r1, r0, 1
	j	beq_cont.12856
beq_then.12855:
	addi	r1, r0, 2
	lw	r2, 2(r3)
	lw	r29, 0(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.12856:
	j	beq_cont.12854
beq_then.12853:
	addi	r1, r0, 0
beq_cont.12854:
	beqi	0, r1, beq_then.12857
	addi	r1, r0, 1
	jr	r31				#
beq_then.12857:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.12852:
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r29, 4(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.12839:
	addi	r1, r0, 0
	jr	r31				#
solve_each_element.3270:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.12858
	addi	r7, r0, 10748
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r6, 3(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r6				# mr	r1, r6
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver.3172				#	bl	solver.3172
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.12859
	addi	r2, r0, 10724
	flw	f1, 0(r2)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.12860
	j	fle_cont.12861
fle_else.12860:
	addi	r2, r0, 10726
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12862
	j	fle_cont.12863
fle_else.12862:
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
	sw	r1, 4(r3)
	fsw	f4, 6(r3)
	fsw	f3, 8(r3)
	fsw	f2, 10(r3)
	fsw	f1, 12(r3)
	beqi	-1, r6, beq_then.12865
	addi	r7, r0, 10001
	add	r30, r7, r6
	lw	r6, 0(r30)
	add	r1, r0, r6				# mr	r1, r6
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	is_outside.3250				#	bl	is_outside.3250
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.12867
	addi	r1, r0, 0
	j	beq_cont.12868
beq_then.12867:
	addi	r1, r0, 1
	flw	f1, 10(r3)
	flw	f2, 8(r3)
	flw	f3, 6(r3)
	lw	r2, 1(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	check_all_inside.3255				#	bl	check_all_inside.3255
	addi	r3, r3, -15
	lw	r31, 14(r3)
beq_cont.12868:
	j	beq_cont.12866
beq_then.12865:
	addi	r1, r0, 1
beq_cont.12866:
	beqi	0, r1, beq_then.12869
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
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	addi	r1, r0, 10725
	lw	r2, 4(r3)
	sw	r2, 0(r1)
	j	beq_cont.12870
beq_then.12869:
beq_cont.12870:
fle_cont.12863:
fle_cont.12861:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3270
beq_then.12859:
	addi	r1, r0, 10001
	lw	r2, 3(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.12871
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_each_element.3270
beq_then.12871:
	jr	r31				#
beq_then.12858:
	jr	r31				#
solve_one_or_network.3274:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.12874
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
	jal	solve_each_element.3270				#	bl	solve_each_element.3270
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.12875
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
	jal	solve_each_element.3270				#	bl	solve_each_element.3270
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_one_or_network.3274
beq_then.12875:
	jr	r31				#
beq_then.12874:
	jr	r31				#
trace_or_matrix.3278:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.12878
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.12879
	addi	r8, r0, 10748
	sw	r6, 3(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	add	r5, r0, r8				# mr	r5, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver.3172				#	bl	solver.3172
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.12881
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12883
	j	fle_cont.12884
fle_else.12883:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.12885
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element.3270				#	bl	solve_each_element.3270
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 2
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network.3274				#	bl	solve_one_or_network.3274
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.12886
beq_then.12885:
beq_cont.12886:
fle_cont.12884:
	j	beq_cont.12882
beq_then.12881:
beq_cont.12882:
	j	beq_cont.12880
beq_then.12879:
	lw	r7, 1(r6)
	beqi	-1, r7, beq_then.12887
	addi	r8, r0, 10672
	add	r30, r8, r7
	lw	r7, 0(r30)
	addi	r8, r0, 0
	sw	r6, 3(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element.3270				#	bl	solve_each_element.3270
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 2
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network.3274				#	bl	solve_one_or_network.3274
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.12888
beq_then.12887:
beq_cont.12888:
beq_cont.12880:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix.3278
beq_then.12878:
	jr	r31				#
judge_intersection.3282:
	addi	r2, r0, 10726
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r2)
	addi	r2, r0, 0
	addi	r5, r0, 10723
	lw	r5, 0(r5)
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r1				# mr	r5, r1
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r28				# mr	r2, r28
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	trace_or_matrix.3278				#	bl	trace_or_matrix.3278
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.12890
	addi	r1, r0, 0
	jr	r31				#
fle_else.12890:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12891
	addi	r1, r0, 0
	jr	r31				#
fle_else.12891:
	addi	r1, r0, 1
	jr	r31				#
solve_each_element_fast.3284:
	lw	r6, 0(r5)
	add	r30, r2, r1
	lw	r7, 0(r30)
	beqi	-1, r7, beq_then.12892
	sw	r6, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	sw	r7, 4(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	solver_fast2.3213				#	bl	solver_fast2.3213
	addi	r3, r3, -6
	lw	r31, 5(r3)
	beqi	0, r1, beq_then.12893
	addi	r2, r0, 10724
	flw	f1, 0(r2)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.12894
	j	fle_cont.12895
fle_else.12894:
	addi	r2, r0, 10726
	flw	f2, 0(r2)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12896
	j	fle_cont.12897
fle_else.12896:
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
	beqi	-1, r5, beq_then.12898
	addi	r6, r0, 10001
	add	r30, r6, r5
	lw	r5, 0(r30)
	add	r1, r0, r5				# mr	r1, r5
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f3				# fmr	f2, f3
	fadd	f3, f0, f4				# fmr	f3, f4
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	is_outside.3250				#	bl	is_outside.3250
	addi	r3, r3, -15
	lw	r31, 14(r3)
	beqi	0, r1, beq_then.12900
	addi	r1, r0, 0
	j	beq_cont.12901
beq_then.12900:
	addi	r1, r0, 1
	flw	f1, 10(r3)
	flw	f2, 8(r3)
	flw	f3, 6(r3)
	lw	r2, 2(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	check_all_inside.3255				#	bl	check_all_inside.3255
	addi	r3, r3, -15
	lw	r31, 14(r3)
beq_cont.12901:
	j	beq_cont.12899
beq_then.12898:
	addi	r1, r0, 1
beq_cont.12899:
	beqi	0, r1, beq_then.12902
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
	j	beq_cont.12903
beq_then.12902:
beq_cont.12903:
fle_cont.12897:
fle_cont.12895:
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	j	solve_each_element_fast.3284
beq_then.12893:
	addi	r1, r0, 10001
	lw	r2, 4(r3)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r1, 6(r1)
	beqi	0, r1, beq_then.12904
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 2(r3)
	lw	r5, 1(r3)
	j	solve_each_element_fast.3284
beq_then.12904:
	jr	r31				#
beq_then.12892:
	jr	r31				#
solve_one_or_network_fast.3288:
	add	r30, r2, r1
	lw	r6, 0(r30)
	beqi	-1, r6, beq_then.12907
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
	jal	solve_each_element_fast.3284				#	bl	solve_each_element_fast.3284
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	beqi	-1, r5, beq_then.12908
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
	jal	solve_each_element_fast.3284				#	bl	solve_each_element_fast.3284
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	solve_one_or_network_fast.3288
beq_then.12908:
	jr	r31				#
beq_then.12907:
	jr	r31				#
trace_or_matrix_fast.3292:
	add	r30, r2, r1
	lw	r6, 0(r30)
	lw	r7, 0(r6)
	beqi	-1, r7, beq_then.12911
	addi	r8, r0, 99
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	beq	r7, r8, beq_then.12912
	sw	r6, 3(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solver_fast2.3213				#	bl	solver_fast2.3213
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.12914
	addi	r1, r0, 10724
	flw	f1, 0(r1)
	addi	r1, r0, 10726
	flw	f2, 0(r1)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12916
	j	fle_cont.12917
fle_else.12916:
	lw	r1, 3(r3)
	lw	r2, 1(r1)
	beqi	-1, r2, beq_then.12918
	addi	r5, r0, 10672
	add	r30, r5, r2
	lw	r2, 0(r30)
	addi	r5, r0, 0
	lw	r6, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	add	r5, r0, r6				# mr	r5, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3284				#	bl	solve_each_element_fast.3284
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 2
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3288				#	bl	solve_one_or_network_fast.3288
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.12919
beq_then.12918:
beq_cont.12919:
fle_cont.12917:
	j	beq_cont.12915
beq_then.12914:
beq_cont.12915:
	j	beq_cont.12913
beq_then.12912:
	lw	r7, 1(r6)
	beqi	-1, r7, beq_then.12920
	addi	r8, r0, 10672
	add	r30, r8, r7
	lw	r7, 0(r30)
	addi	r8, r0, 0
	sw	r6, 3(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_each_element_fast.3284				#	bl	solve_each_element_fast.3284
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r1, r0, 2
	lw	r2, 3(r3)
	lw	r5, 0(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	solve_one_or_network_fast.3288				#	bl	solve_one_or_network_fast.3288
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.12921
beq_then.12920:
beq_cont.12921:
beq_cont.12913:
	lw	r1, 2(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	j	trace_or_matrix_fast.3292
beq_then.12911:
	jr	r31				#
judge_intersection_fast.3296:
	addi	r2, r0, 10726
	flup	f1, 31		# fli	f1, 1000000000.000000
	fsw	f1, 0(r2)
	addi	r2, r0, 0
	addi	r5, r0, 10723
	lw	r5, 0(r5)
	add	r28, r0, r5				# mr	r28, r5
	add	r5, r0, r1				# mr	r5, r1
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r28				# mr	r2, r28
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	trace_or_matrix_fast.3292				#	bl	trace_or_matrix_fast.3292
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10726
	flw	f1, 0(r1)
	flup	f2, 30		# fli	f2, -0.100000
	fle	r30, f1, f2
	beq	r0, r30, fle_else.12923
	addi	r1, r0, 0
	jr	r31				#
fle_else.12923:
	flup	f2, 32		# fli	f2, 100000000.000000
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12924
	addi	r1, r0, 0
	jr	r31				#
fle_else.12924:
	addi	r1, r0, 1
	jr	r31				#
get_nvector_rect.3298:
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
	beq	r0, r30, feq_else.12925
	addi	r1, r0, 1
	j	feq_cont.12926
feq_else.12925:
	addi	r1, r0, 0
feq_cont.12926:
	beqi	0, r1, beq_then.12927
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.12928
beq_then.12927:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.12929
	addi	r1, r0, 0
	j	fle_cont.12930
fle_else.12929:
	addi	r1, r0, 1
fle_cont.12930:
	beqi	0, r1, beq_then.12931
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.12932
beq_then.12931:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.12932:
beq_cont.12928:
	fneg	f1, f1
	add	r30, r5, r6
	fsw	f1, 0(r30)
	jr	r31				#
get_nvector_plane.3300:
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
get_nvector_second.3302:
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
	beqi	0, r2, beq_then.12935
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
	j	beq_cont.12936
beq_then.12935:
	addi	r2, r0, 10731
	fsw	f4, 0(r2)
	addi	r2, r0, 10731
	fsw	f5, 1(r2)
	addi	r2, r0, 10731
	fsw	f6, 2(r2)
beq_cont.12936:
	addi	r2, r0, 10731
	lw	r1, 6(r1)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	vecunit_sgn.3010
get_nvector.3304:
	lw	r5, 1(r1)
	beqi	1, r5, beq_then.12937
	beqi	2, r5, beq_then.12938
	j	get_nvector_second.3302
beq_then.12938:
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
beq_then.12937:
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
	beq	r0, r30, feq_else.12940
	addi	r1, r0, 1
	j	feq_cont.12941
feq_else.12940:
	addi	r1, r0, 0
feq_cont.12941:
	beqi	0, r1, beq_then.12942
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.12943
beq_then.12942:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.12944
	addi	r1, r0, 0
	j	fle_cont.12945
fle_else.12944:
	addi	r1, r0, 1
fle_cont.12945:
	beqi	0, r1, beq_then.12946
	flup	f1, 2		# fli	f1, 1.000000
	j	beq_cont.12947
beq_then.12946:
	flup	f1, 11		# fli	f1, -1.000000
beq_cont.12947:
beq_cont.12943:
	fneg	f1, f1
	add	r30, r5, r6
	fsw	f1, 0(r30)
	jr	r31				#
utexture.3307:
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
	beqi	1, r5, beq_then.12949
	beqi	2, r5, beq_then.12950
	beqi	3, r5, beq_then.12951
	beqi	4, r5, beq_then.12952
	jr	r31				#
beq_then.12952:
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
	beq	r0, r30, fle_else.12954
	fadd	f5, f0, f1
	j	fle_cont.12955
fle_else.12954:
	fneg	f5, f1
fle_cont.12955:
	fsw	f3, 0(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	fle	r30, f4, f5
	beq	r0, r30, fle_else.12956
	fdiv	f1, f2, f1
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12958
	j	fle_cont.12959
fle_else.12958:
	fneg	f1, f1
fle_cont.12959:
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan.2926				#	bl	atan.2926
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.12957
fle_else.12956:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.12957:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12960
	addi	r1, r0, 0
	j	feq_cont.12961
feq_else.12960:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12962
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12963
fle_else.12962:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12963:
feq_cont.12961:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12964
	j	fle_cont.12965
fle_else.12964:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.12965:
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
	beq	r0, r30, fle_else.12966
	fadd	f5, f0, f4
	j	fle_cont.12967
fle_else.12966:
	fneg	f5, f4
fle_cont.12967:
	fsw	f1, 4(r3)
	fle	r30, f3, f5
	beq	r0, r30, fle_else.12968
	fdiv	f2, f2, f4
	fle	r30, f0, f2
	beq	r0, r30, fle_else.12970
	j	fle_cont.12971
fle_else.12970:
	fneg	f2, f2
fle_cont.12971:
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	atan.2926				#	bl	atan.2926
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flup	f2, 35		# fli	f2, 30.000000
	fmul	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fdiv	f1, f1, f2
	j	fle_cont.12969
fle_else.12968:
	flup	f1, 34		# fli	f1, 15.000000
fle_cont.12969:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.12972
	addi	r1, r0, 0
	j	feq_cont.12973
feq_else.12972:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12974
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12975
fle_else.12974:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12975:
feq_cont.12973:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12976
	j	fle_cont.12977
fle_else.12976:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.12977:
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
	beq	r0, r30, fle_else.12978
	addi	r1, r0, 0
	j	fle_cont.12979
fle_else.12978:
	addi	r1, r0, 1
fle_cont.12979:
	beqi	0, r1, beq_then.12980
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.12981
beq_then.12980:
beq_cont.12981:
	addi	r1, r0, 10734
	flup	f2, 37		# fli	f2, 255.000000
	fmul	f1, f2, f1
	flup	f2, 38		# fli	f2, 0.300000
	fdiv	f1, f1, f2
	fsw	f1, 2(r1)
	jr	r31				#
beq_then.12951:
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
	beq	r0, r30, feq_else.12983
	addi	r1, r0, 0
	j	feq_cont.12984
feq_else.12983:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.12985
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f2, f1, f2
	ftoi	r1, f2
	j	fle_cont.12986
fle_else.12985:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f2, f1, f2
	ftoi	r1, f2
fle_cont.12986:
feq_cont.12984:
	itof	f2, r1
	fle	r30, f2, f1
	beq	r0, r30, fle_else.12987
	j	fle_cont.12988
fle_else.12987:
	flup	f3, 2		# fli	f3, 1.000000
	fsub	f2, f2, f3
fle_cont.12988:
	fsub	f1, f1, f2
	flup	f2, 14		# fli	f2, 3.141593
	fmul	f1, f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	cos.2922				#	bl	cos.2922
	addi	r3, r3, -7
	lw	r31, 6(r3)
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
beq_then.12950:
	flw	f1, 1(r2)
	flup	f2, 40		# fli	f2, 0.250000
	fmul	f1, f1, f2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin.2920				#	bl	sin.2920
	addi	r3, r3, -7
	lw	r31, 6(r3)
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
beq_then.12949:
	flw	f1, 0(r2)
	lw	r5, 5(r1)
	flw	f2, 0(r5)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	feq	r30, f2, f0
	beq	r0, r30, feq_else.12991
	addi	r5, r0, 0
	j	feq_cont.12992
feq_else.12991:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.12993
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r5, f3
	j	fle_cont.12994
fle_else.12993:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r5, f3
fle_cont.12994:
feq_cont.12992:
	itof	f3, r5
	fle	r30, f3, f2
	beq	r0, r30, fle_else.12995
	fadd	f2, f0, f3
	j	fle_cont.12996
fle_else.12995:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.12996:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.12997
	addi	r5, r0, 0
	j	fle_cont.12998
fle_else.12997:
	addi	r5, r0, 1
fle_cont.12998:
	flw	f1, 2(r2)
	lw	r1, 5(r1)
	flw	f2, 2(r1)
	fsub	f1, f1, f2
	flup	f2, 41		# fli	f2, 0.050000
	fmul	f2, f1, f2
	feq	r30, f2, f0
	beq	r0, r30, feq_else.12999
	addi	r1, r0, 0
	j	feq_cont.13000
feq_else.12999:
	fle	r30, f0, f2
	beq	r0, r30, fle_else.13001
	flup	f3, 1		# fli	f3, 0.500000
	fsub	f3, f2, f3
	ftoi	r1, f3
	j	fle_cont.13002
fle_else.13001:
	flup	f3, 1		# fli	f3, 0.500000
	fadd	f3, f2, f3
	ftoi	r1, f3
fle_cont.13002:
feq_cont.13000:
	itof	f3, r1
	fle	r30, f3, f2
	beq	r0, r30, fle_else.13003
	fadd	f2, f0, f3
	j	fle_cont.13004
fle_else.13003:
	flup	f2, 2		# fli	f2, 1.000000
	fsub	f2, f3, f2
fle_cont.13004:
	flup	f3, 42		# fli	f3, 20.000000
	fmul	f2, f2, f3
	flup	f3, 39		# fli	f3, 10.000000
	fsub	f1, f1, f2
	fle	r30, f3, f1
	beq	r0, r30, fle_else.13005
	addi	r1, r0, 0
	j	fle_cont.13006
fle_else.13005:
	addi	r1, r0, 1
fle_cont.13006:
	addi	r2, r0, 10734
	beqi	0, r5, beq_then.13007
	beqi	0, r1, beq_then.13009
	flup	f1, 37		# fli	f1, 255.000000
	j	beq_cont.13010
beq_then.13009:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.13010:
	j	beq_cont.13008
beq_then.13007:
	beqi	0, r1, beq_then.13011
	flup	f1, 0		# fli	f1, 0.000000
	j	beq_cont.13012
beq_then.13011:
	flup	f1, 37		# fli	f1, 255.000000
beq_cont.13012:
beq_cont.13008:
	fsw	f1, 1(r2)
	jr	r31				#
add_light.3310:
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13014
	addi	r1, r0, 0
	j	fle_cont.13015
fle_else.13014:
	addi	r1, r0, 1
fle_cont.13015:
	fsw	f3, 0(r3)
	fsw	f2, 2(r3)
	beqi	0, r1, beq_then.13016
	addi	r1, r0, 10740
	addi	r2, r0, 10734
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	vecaccum.3021				#	bl	vecaccum.3021
	addi	r3, r3, -5
	lw	r31, 4(r3)
	j	beq_cont.13017
beq_then.13016:
beq_cont.13017:
	flw	f1, 2(r3)
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13018
	addi	r1, r0, 0
	j	fle_cont.13019
fle_else.13018:
	addi	r1, r0, 1
fle_cont.13019:
	beqi	0, r1, beq_then.13020
	fmul	f1, f1, f1
	fmul	f1, f1, f1
	flw	f2, 0(r3)
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
beq_then.13020:
	jr	r31				#
trace_reflections.3314:
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.13023
	jr	r31				#
ble_then.13023:
	add	r30, r6, r1
	lw	r6, 0(r30)
	lw	r7, 1(r6)
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	fsw	f2, 2(r3)
	sw	r2, 4(r3)
	fsw	f1, 6(r3)
	sw	r7, 8(r3)
	sw	r5, 9(r3)
	sw	r6, 10(r3)
	add	r1, r0, r7				# mr	r1, r7
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	judge_intersection_fast.3296				#	bl	judge_intersection_fast.3296
	addi	r3, r3, -12
	lw	r31, 11(r3)
	beqi	0, r1, beq_then.13026
	addi	r1, r0, 10730
	lw	r1, 0(r1)
	slli	r1, r1, 2
	addi	r2, r0, 10725
	lw	r2, 0(r2)
	add	r1, r1, r2
	lw	r2, 10(r3)
	lw	r5, 0(r2)
	beq	r1, r5, beq_then.13028
	j	beq_cont.13029
beq_then.13028:
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
	beqi	0, r1, beq_then.13030
	j	beq_cont.13031
beq_then.13030:
	addi	r1, r0, 10731
	lw	r2, 8(r3)
	lw	r5, 0(r2)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	veciprod.3013				#	bl	veciprod.3013
	addi	r3, r3, -12
	lw	r31, 11(r3)
	lw	r1, 10(r3)
	flw	f2, 2(r1)
	flw	f3, 6(r3)
	fmul	f4, f2, f3
	fmul	f1, f4, f1
	lw	r1, 8(r3)
	lw	r2, 0(r1)
	lw	r1, 4(r3)
	fsw	f1, 12(r3)
	fsw	f2, 14(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	veciprod.3013				#	bl	veciprod.3013
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fmul	f2, f2, f1
	flw	f1, 12(r3)
	flw	f3, 2(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	add_light.3310				#	bl	add_light.3310
	addi	r3, r3, -17
	lw	r31, 16(r3)
beq_cont.13031:
beq_cont.13029:
	j	beq_cont.13027
beq_then.13026:
beq_cont.13027:
	lw	r1, 1(r3)
	addi	r1, r1, -1
	flw	f1, 6(r3)
	flw	f2, 2(r3)
	lw	r2, 4(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
trace_ray.3319:
	lw	r6, 5(r29)
	lw	r7, 4(r29)
	lw	r8, 3(r29)
	lw	r9, 2(r29)
	lw	r10, 1(r29)
	blei	4, r1, ble_then.13033
	jr	r31				#
ble_then.13033:
	lw	r11, 2(r5)
	sw	r29, 0(r3)
	fsw	f2, 2(r3)
	sw	r7, 4(r3)
	sw	r9, 5(r3)
	sw	r8, 6(r3)
	sw	r10, 7(r3)
	sw	r6, 8(r3)
	sw	r5, 9(r3)
	fsw	f1, 10(r3)
	sw	r2, 12(r3)
	sw	r1, 13(r3)
	sw	r11, 14(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 15(r3)
	addi	r3, r3, 16
	jal	judge_intersection.3282				#	bl	judge_intersection.3282
	addi	r3, r3, -16
	lw	r31, 15(r3)
	beqi	0, r1, beq_then.13036
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
	beqi	1, r6, beq_then.13037
	beqi	2, r6, beq_then.13039
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	get_nvector_second.3302				#	bl	get_nvector_second.3302
	addi	r3, r3, -21
	lw	r31, 20(r3)
	j	beq_cont.13040
beq_then.13039:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	get_nvector_plane.3300				#	bl	get_nvector_plane.3300
	addi	r3, r3, -21
	lw	r31, 20(r3)
beq_cont.13040:
	j	beq_cont.13038
beq_then.13037:
	lw	r6, 12(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 20(r3)
	addi	r3, r3, 21
	jal	get_nvector_rect.3298				#	bl	get_nvector_rect.3298
	addi	r3, r3, -21
	lw	r31, 20(r3)
beq_cont.13038:
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
	jal	utexture.3307				#	bl	utexture.3307
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
	lw	r1, 9(r3)
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
	beq	r0, r30, fle_else.13041
	lw	r8, 8(r3)
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
	j	fle_cont.13042
fle_else.13041:
	lw	r8, 7(r3)
	add	r30, r6, r2
	sw	r8, 0(r30)
fle_cont.13042:
	flup	f1, 44		# fli	f1, -2.000000
	addi	r6, r0, 10731
	lw	r8, 12(r3)
	fsw	f1, 20(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	veciprod.3013				#	bl	veciprod.3013
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 20(r3)
	fmul	f1, f2, f1
	addi	r2, r0, 10731
	lw	r1, 12(r3)
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	vecaccum.3021				#	bl	vecaccum.3021
	addi	r3, r3, -23
	lw	r31, 22(r3)
	lw	r1, 19(r3)
	lw	r2, 7(r1)
	flw	f1, 1(r2)
	flw	f2, 10(r3)
	fmul	f1, f2, f1
	addi	r2, r0, 0
	addi	r5, r0, 10723
	lw	r5, 0(r5)
	lw	r29, 6(r3)
	fsw	f1, 22(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -25
	lw	r31, 24(r3)
	beqi	0, r1, beq_then.13043
	j	beq_cont.13044
beq_then.13043:
	addi	r1, r0, 10731
	addi	r2, r0, 10667
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	veciprod.3013				#	bl	veciprod.3013
	addi	r3, r3, -25
	lw	r31, 24(r3)
	fneg	f1, f1
	flw	f2, 16(r3)
	fmul	f1, f1, f2
	addi	r2, r0, 10667
	lw	r1, 12(r3)
	fsw	f1, 24(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	veciprod.3013				#	bl	veciprod.3013
	addi	r3, r3, -27
	lw	r31, 26(r3)
	fneg	f2, f1
	flw	f1, 24(r3)
	flw	f3, 22(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	add_light.3310				#	bl	add_light.3310
	addi	r3, r3, -27
	lw	r31, 26(r3)
beq_cont.13044:
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
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	setup_startp_constants.3230				#	bl	setup_startp_constants.3230
	addi	r3, r3, -27
	lw	r31, 26(r3)
	lw	r1, 5(r3)
	lw	r1, 0(r1)
	addi	r1, r1, -1
	flw	f1, 16(r3)
	flw	f2, 22(r3)
	lw	r2, 12(r3)
	lw	r29, 4(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flup	f1, 45		# fli	f1, 0.100000
	flw	f2, 10(r3)
	fle	r30, f2, f1
	beq	r0, r30, fle_else.13045
	jr	r31				#
fle_else.13045:
	addi	r1, r0, 4
	lw	r2, 13(r3)
	ble	r1, r2, ble_then.13047
	addi	r1, r2, 1
	addi	r5, r0, -1
	lw	r6, 14(r3)
	add	r30, r6, r1
	sw	r5, 0(r30)
	j	ble_cont.13048
ble_then.13047:
ble_cont.13048:
	lw	r1, 15(r3)
	beqi	2, r1, beq_then.13049
	j	beq_cont.13050
beq_then.13049:
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
	lw	r5, 9(r3)
	lw	r29, 0(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -27
	lw	r31, 26(r3)
beq_cont.13050:
	jr	r31				#
beq_then.13036:
	addi	r1, r0, -1
	lw	r2, 13(r3)
	lw	r5, 14(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	beqi	0, r2, beq_then.13052
	addi	r2, r0, 10667
	lw	r1, 12(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	veciprod.3013				#	bl	veciprod.3013
	addi	r3, r3, -27
	lw	r31, 26(r3)
	fneg	f1, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13053
	addi	r1, r0, 0
	j	fle_cont.13054
fle_else.13053:
	addi	r1, r0, 1
fle_cont.13054:
	beqi	0, r1, beq_then.13055
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
beq_then.13055:
	jr	r31				#
beq_then.13052:
	jr	r31				#
trace_diffuse_ray.3325:
	lw	r2, 1(r29)
	fsw	f1, 0(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	judge_intersection_fast.3296				#	bl	judge_intersection_fast.3296
	addi	r3, r3, -5
	lw	r31, 4(r3)
	beqi	0, r1, beq_then.13059
	addi	r1, r0, 10001
	addi	r2, r0, 10730
	lw	r2, 0(r2)
	add	r30, r1, r2
	lw	r1, 0(r30)
	lw	r2, 3(r3)
	lw	r2, 0(r2)
	lw	r5, 1(r1)
	sw	r1, 4(r3)
	beqi	1, r5, beq_then.13060
	beqi	2, r5, beq_then.13062
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	get_nvector_second.3302				#	bl	get_nvector_second.3302
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.13063
beq_then.13062:
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	get_nvector_plane.3300				#	bl	get_nvector_plane.3300
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.13063:
	j	beq_cont.13061
beq_then.13060:
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	get_nvector_rect.3298				#	bl	get_nvector_rect.3298
	addi	r3, r3, -6
	lw	r31, 5(r3)
beq_cont.13061:
	addi	r2, r0, 10727
	lw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	utexture.3307				#	bl	utexture.3307
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
	beqi	0, r1, beq_then.13064
	jr	r31				#
beq_then.13064:
	addi	r1, r0, 10731
	addi	r2, r0, 10667
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	veciprod.3013				#	bl	veciprod.3013
	addi	r3, r3, -6
	lw	r31, 5(r3)
	fneg	f1, f1
	fle	r30, f1, f0
	beq	r0, r30, fle_else.13066
	addi	r1, r0, 0
	j	fle_cont.13067
fle_else.13066:
	addi	r1, r0, 1
fle_cont.13067:
	beqi	0, r1, beq_then.13068
	j	beq_cont.13069
beq_then.13068:
	flup	f1, 0		# fli	f1, 0.000000
beq_cont.13069:
	addi	r1, r0, 10737
	flw	f2, 0(r3)
	fmul	f1, f2, f1
	lw	r2, 4(r3)
	lw	r2, 7(r2)
	flw	f2, 0(r2)
	fmul	f1, f1, f2
	addi	r2, r0, 10734
	j	vecaccum.3021
beq_then.13059:
	jr	r31				#
iter_trace_diffuse_rays.3328:
	lw	r7, 1(r29)
	addi	r8, r0, 0
	ble	r8, r6, ble_then.13071
	jr	r31				#
ble_then.13071:
	add	r30, r1, r6
	lw	r8, 0(r30)
	lw	r8, 0(r8)
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r29, 2(r3)
	sw	r7, 3(r3)
	sw	r6, 4(r3)
	sw	r1, 5(r3)
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	veciprod.3013				#	bl	veciprod.3013
	addi	r3, r3, -7
	lw	r31, 6(r3)
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13073
	addi	r1, r0, 0
	j	fle_cont.13074
fle_else.13073:
	addi	r1, r0, 1
fle_cont.13074:
	beqi	0, r1, beq_then.13075
	lw	r1, 4(r3)
	addi	r2, r1, 1
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r2, 0(r30)
	flup	f2, 46		# fli	f2, -150.000000
	fdiv	f1, f1, f2
	lw	r29, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.13076
beq_then.13075:
	lw	r1, 4(r3)
	lw	r2, 5(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	flup	f2, 47		# fli	f2, 150.000000
	fdiv	f1, f1, f2
	lw	r29, 3(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
beq_cont.13076:
	lw	r1, 4(r3)
	addi	r6, r1, -2
	lw	r1, 5(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
trace_diffuse_rays.3333:
	lw	r6, 1(r29)
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
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r6, 3(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	setup_startp_constants.3230				#	bl	setup_startp_constants.3230
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r6, r0, 118
	lw	r1, 2(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 3(r3)
	lw	r28, 0(r29)
	jr	r28
trace_diffuse_ray_80percent.3337:
	lw	r6, 2(r29)
	lw	r7, 1(r29)
	sw	r2, 0(r3)
	sw	r6, 1(r3)
	sw	r5, 2(r3)
	sw	r7, 3(r3)
	sw	r1, 4(r3)
	beqi	0, r1, beq_then.13077
	lw	r8, 0(r7)
	sw	r8, 5(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	setup_startp.3233				#	bl	setup_startp.3233
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
	j	beq_cont.13078
beq_then.13077:
beq_cont.13078:
	lw	r1, 4(r3)
	beqi	1, r1, beq_then.13079
	lw	r2, 3(r3)
	lw	r5, 1(r2)
	lw	r6, 2(r3)
	sw	r5, 6(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_startp.3233				#	bl	setup_startp.3233
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
	j	beq_cont.13080
beq_then.13079:
beq_cont.13080:
	lw	r1, 4(r3)
	beqi	2, r1, beq_then.13081
	lw	r2, 3(r3)
	lw	r5, 2(r2)
	lw	r6, 2(r3)
	sw	r5, 7(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	setup_startp.3233				#	bl	setup_startp.3233
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
	j	beq_cont.13082
beq_then.13081:
beq_cont.13082:
	lw	r1, 4(r3)
	beqi	3, r1, beq_then.13083
	lw	r2, 3(r3)
	lw	r5, 3(r2)
	lw	r6, 2(r3)
	sw	r5, 8(r3)
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	setup_startp.3233				#	bl	setup_startp.3233
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	r6, r0, 118
	lw	r1, 8(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r29, 1(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.13084
beq_then.13083:
beq_cont.13084:
	lw	r1, 4(r3)
	beqi	4, r1, beq_then.13085
	lw	r1, 3(r3)
	lw	r1, 4(r1)
	lw	r2, 2(r3)
	sw	r1, 9(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	setup_startp.3233				#	bl	setup_startp.3233
	addi	r3, r3, -11
	lw	r31, 10(r3)
	addi	r6, r0, 118
	lw	r1, 9(r3)
	lw	r2, 0(r3)
	lw	r5, 2(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13085:
	jr	r31				#
calc_diffuse_using_1point.3341:
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
	j	vecaccumv.3034
calc_diffuse_using_5points.3344:
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
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	sw	r6, 2(r3)
	sw	r10, 3(r3)
	sw	r7, 4(r3)
	sw	r9, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r8				# mr	r2, r8
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecadd.3025				#	bl	vecadd.3025
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 10737
	lw	r2, 4(r3)
	lw	r5, 5(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecadd.3025				#	bl	vecadd.3025
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 10737
	lw	r2, 4(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecadd.3025				#	bl	vecadd.3025
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 10737
	lw	r2, 4(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	lw	r5, 0(r30)
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	vecadd.3025				#	bl	vecadd.3025
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 0(r3)
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r1, 4(r1)
	addi	r2, r0, 10740
	lw	r5, 4(r3)
	add	r30, r1, r5
	lw	r1, 0(r30)
	addi	r5, r0, 10737
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	vecaccumv.3034
do_without_neighbors.3350:
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	blei	4, r2, ble_then.13087
	jr	r31				#
ble_then.13087:
	lw	r7, 2(r1)
	addi	r8, r0, 0
	add	r30, r7, r2
	lw	r7, 0(r30)
	ble	r8, r7, ble_then.13089
	jr	r31				#
ble_then.13089:
	lw	r7, 3(r1)
	add	r30, r7, r2
	lw	r7, 0(r30)
	sw	r29, 0(r3)
	sw	r6, 1(r3)
	sw	r1, 2(r3)
	sw	r2, 3(r3)
	beqi	0, r7, beq_then.13091
	lw	r7, 5(r1)
	lw	r8, 7(r1)
	lw	r9, 1(r1)
	lw	r10, 4(r1)
	addi	r11, r0, 10737
	add	r30, r7, r2
	lw	r7, 0(r30)
	flw	f1, 0(r7)
	fsw	f1, 0(r11)
	flw	f1, 1(r7)
	fsw	f1, 1(r11)
	flw	f1, 2(r7)
	fsw	f1, 2(r11)
	lw	r7, 6(r1)
	lw	r7, 0(r7)
	add	r30, r8, r2
	lw	r8, 0(r30)
	add	r30, r9, r2
	lw	r9, 0(r30)
	sw	r10, 4(r3)
	add	r2, r0, r8				# mr	r2, r8
	add	r1, r0, r7				# mr	r1, r7
	add	r29, r0, r5				# mr	r29, r5
	add	r5, r0, r9				# mr	r5, r9
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
	jal	vecaccumv.3034				#	bl	vecaccumv.3034
	addi	r3, r3, -6
	lw	r31, 5(r3)
	j	beq_cont.13092
beq_then.13091:
beq_cont.13092:
	lw	r1, 3(r3)
	addi	r2, r1, 1
	blei	4, r2, ble_then.13093
	jr	r31				#
ble_then.13093:
	lw	r1, 2(r3)
	lw	r5, 2(r1)
	addi	r6, r0, 0
	add	r30, r5, r2
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.13095
	jr	r31				#
ble_then.13095:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r2, 5(r3)
	beqi	0, r5, beq_then.13097
	lw	r29, 1(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	j	beq_cont.13098
beq_then.13097:
beq_cont.13098:
	lw	r1, 5(r3)
	addi	r2, r1, 1
	lw	r1, 2(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
neighbors_exist.3353:
	addi	r5, r0, 10743
	lw	r5, 1(r5)
	addi	r6, r2, 1
	ble	r5, r6, ble_then.13099
	blei	0, r2, ble_then.13100
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r5, r1, 1
	ble	r2, r5, ble_then.13101
	blei	0, r1, ble_then.13102
	addi	r1, r0, 1
	jr	r31				#
ble_then.13102:
	addi	r1, r0, 0
	jr	r31				#
ble_then.13101:
	addi	r1, r0, 0
	jr	r31				#
ble_then.13100:
	addi	r1, r0, 0
	jr	r31				#
ble_then.13099:
	addi	r1, r0, 0
	jr	r31				#
get_surface_id.3357:
	lw	r1, 2(r1)
	add	r30, r1, r2
	lw	r1, 0(r30)
	jr	r31				#
neighbors_are_available.3360:
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
	beq	r2, r8, beq_then.13103
	addi	r1, r0, 0
	jr	r31				#
beq_then.13103:
	add	r30, r6, r1
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.13104
	addi	r1, r0, 0
	jr	r31				#
beq_then.13104:
	addi	r2, r1, -1
	add	r30, r5, r2
	lw	r2, 0(r30)
	lw	r2, 2(r2)
	add	r30, r2, r7
	lw	r2, 0(r30)
	beq	r2, r8, beq_then.13105
	addi	r1, r0, 0
	jr	r31				#
beq_then.13105:
	addi	r1, r1, 1
	add	r30, r5, r1
	lw	r1, 0(r30)
	lw	r1, 2(r1)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beq	r1, r8, beq_then.13106
	addi	r1, r0, 0
	jr	r31				#
beq_then.13106:
	addi	r1, r0, 1
	jr	r31				#
try_exploit_neighbors.3366:
	lw	r9, 2(r29)
	lw	r10, 1(r29)
	add	r30, r6, r1
	lw	r11, 0(r30)
	blei	4, r8, ble_then.13107
	jr	r31				#
ble_then.13107:
	addi	r12, r0, 0
	lw	r13, 2(r11)
	add	r30, r13, r8
	lw	r13, 0(r30)
	ble	r12, r13, ble_then.13109
	jr	r31				#
ble_then.13109:
	sw	r2, 0(r3)
	sw	r29, 1(r3)
	sw	r7, 2(r3)
	sw	r5, 3(r3)
	sw	r11, 4(r3)
	sw	r9, 5(r3)
	sw	r10, 6(r3)
	sw	r8, 7(r3)
	sw	r1, 8(r3)
	sw	r6, 9(r3)
	add	r2, r0, r5				# mr	r2, r5
	add	r5, r0, r6				# mr	r5, r6
	add	r6, r0, r7				# mr	r6, r7
	add	r7, r0, r8				# mr	r7, r8
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	neighbors_are_available.3360				#	bl	neighbors_are_available.3360
	addi	r3, r3, -11
	lw	r31, 10(r3)
	beqi	0, r1, beq_then.13111
	lw	r1, 4(r3)
	lw	r1, 3(r1)
	lw	r7, 7(r3)
	add	r30, r1, r7
	lw	r1, 0(r30)
	beqi	0, r1, beq_then.13112
	lw	r1, 8(r3)
	lw	r2, 3(r3)
	lw	r5, 9(r3)
	lw	r6, 2(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	calc_diffuse_using_5points.3344				#	bl	calc_diffuse_using_5points.3344
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.13113
beq_then.13112:
beq_cont.13113:
	lw	r1, 7(r3)
	addi	r8, r1, 1
	lw	r1, 8(r3)
	lw	r2, 0(r3)
	lw	r5, 3(r3)
	lw	r6, 9(r3)
	lw	r7, 2(r3)
	lw	r29, 1(r3)
	lw	r28, 0(r29)
	jr	r28
beq_then.13111:
	lw	r1, 8(r3)
	lw	r2, 9(r3)
	add	r30, r2, r1
	lw	r1, 0(r30)
	lw	r2, 7(r3)
	blei	4, r2, ble_then.13114
	jr	r31				#
ble_then.13114:
	lw	r5, 2(r1)
	addi	r6, r0, 0
	add	r30, r5, r2
	lw	r5, 0(r30)
	ble	r6, r5, ble_then.13116
	jr	r31				#
ble_then.13116:
	lw	r5, 3(r1)
	add	r30, r5, r2
	lw	r5, 0(r30)
	sw	r1, 10(r3)
	beqi	0, r5, beq_then.13118
	lw	r29, 6(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	j	beq_cont.13119
beq_then.13118:
beq_cont.13119:
	lw	r1, 7(r3)
	addi	r2, r1, 1
	lw	r1, 10(r3)
	lw	r29, 5(r3)
	lw	r28, 0(r29)
	jr	r28
write_ppm_header.3373:
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
	jal	print_int.2954				#	bl	print_int.2954
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10743
	lw	r1, 1(r1)
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2954				#	bl	print_int.2954
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 255
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2954				#	bl	print_int.2954
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
write_rgb_element.3375:
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13120
	addi	r1, r0, 0
	j	feq_cont.13121
feq_else.13120:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13122
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.13123
fle_else.13122:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.13123:
feq_cont.13121:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.13124
	addi	r1, r0, 255
	j	ble_cont.13125
ble_then.13124:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13126
	addi	r1, r0, 0
	j	ble_cont.13127
ble_then.13126:
ble_cont.13127:
ble_cont.13125:
	j	print_int.2954
write_rgb.3377:
	addi	r1, r0, 10740
	flw	f1, 0(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13128
	addi	r1, r0, 0
	j	feq_cont.13129
feq_else.13128:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13130
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.13131
fle_else.13130:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.13131:
feq_cont.13129:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.13132
	addi	r1, r0, 255
	j	ble_cont.13133
ble_then.13132:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13134
	addi	r1, r0, 0
	j	ble_cont.13135
ble_then.13134:
ble_cont.13135:
ble_cont.13133:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2954				#	bl	print_int.2954
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10740
	flw	f1, 1(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13136
	addi	r1, r0, 0
	j	feq_cont.13137
feq_else.13136:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13138
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.13139
fle_else.13138:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.13139:
feq_cont.13137:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.13140
	addi	r1, r0, 255
	j	ble_cont.13141
ble_then.13140:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13142
	addi	r1, r0, 0
	j	ble_cont.13143
ble_then.13142:
ble_cont.13143:
ble_cont.13141:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2954				#	bl	print_int.2954
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 32
	out	r1
	addi	r1, r0, 10740
	flw	f1, 2(r1)
	feq	r30, f1, f0
	beq	r0, r30, feq_else.13144
	addi	r1, r0, 0
	j	feq_cont.13145
feq_else.13144:
	fle	r30, f0, f1
	beq	r0, r30, fle_else.13146
	flup	f2, 1		# fli	f2, 0.500000
	fsub	f1, f1, f2
	ftoi	r1, f1
	j	fle_cont.13147
fle_else.13146:
	flup	f2, 1		# fli	f2, 0.500000
	fadd	f1, f1, f2
	ftoi	r1, f1
fle_cont.13147:
feq_cont.13145:
	addi	r2, r0, 255
	ble	r1, r2, ble_then.13148
	addi	r1, r0, 255
	j	ble_cont.13149
ble_then.13148:
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13150
	addi	r1, r0, 0
	j	ble_cont.13151
ble_then.13150:
ble_cont.13151:
ble_cont.13149:
	sw	r31, 0(r3)
	addi	r3, r3, 1
	jal	print_int.2954				#	bl	print_int.2954
	addi	r3, r3, -1
	lw	r31, 0(r3)
	addi	r1, r0, 10
	out	r1
	jr	r31				#
pretrace_diffuse_rays.3379:
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	blei	4, r2, ble_then.13152
	jr	r31				#
ble_then.13152:
	lw	r7, 2(r1)
	add	r30, r7, r2
	lw	r7, 0(r30)
	addi	r8, r0, 0
	ble	r8, r7, ble_then.13154
	jr	r31				#
ble_then.13154:
	lw	r7, 3(r1)
	add	r30, r7, r2
	lw	r7, 0(r30)
	sw	r29, 0(r3)
	sw	r2, 1(r3)
	beqi	0, r7, beq_then.13156
	lw	r7, 6(r1)
	lw	r7, 0(r7)
	addi	r8, r0, 10737
	flup	f1, 0		# fli	f1, 0.000000
	fsw	f1, 0(r8)
	fsw	f1, 1(r8)
	fsw	f1, 2(r8)
	lw	r8, 7(r1)
	lw	r9, 1(r1)
	add	r30, r6, r7
	lw	r6, 0(r30)
	add	r30, r8, r2
	lw	r7, 0(r30)
	add	r30, r9, r2
	lw	r8, 0(r30)
	sw	r1, 2(r3)
	sw	r8, 3(r3)
	sw	r7, 4(r3)
	sw	r6, 5(r3)
	sw	r5, 6(r3)
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	setup_startp.3233				#	bl	setup_startp.3233
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
	j	beq_cont.13157
beq_then.13156:
beq_cont.13157:
	lw	r2, 1(r3)
	addi	r2, r2, 1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_pixels.3382:
	lw	r6, 3(r29)
	lw	r7, 2(r29)
	lw	r8, 1(r29)
	addi	r9, r0, 0
	ble	r9, r2, ble_then.13158
	jr	r31				#
ble_then.13158:
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
	jal	vecunit_sgn.3010				#	bl	vecunit_sgn.3010
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
	ble	r5, r1, ble_then.13160
	add	r5, r0, r1
	j	ble_cont.13161
ble_then.13160:
	addi	r5, r1, -5
ble_cont.13161:
	flw	f1, 4(r3)
	flw	f2, 2(r3)
	flw	f3, 0(r3)
	lw	r1, 11(r3)
	lw	r29, 6(r3)
	lw	r28, 0(r29)
	jr	r28
pretrace_line.3389:
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
scan_pixel.3393:
	lw	r8, 3(r29)
	lw	r9, 2(r29)
	lw	r10, 1(r29)
	addi	r11, r0, 10743
	lw	r11, 0(r11)
	ble	r11, r1, ble_then.13162
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
	sw	r29, 0(r3)
	sw	r7, 1(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r8, 4(r3)
	sw	r9, 5(r3)
	sw	r10, 6(r3)
	sw	r1, 7(r3)
	sw	r6, 8(r3)
	add	r5, r0, r7				# mr	r5, r7
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	neighbors_exist.3353				#	bl	neighbors_exist.3353
	addi	r3, r3, -10
	lw	r31, 9(r3)
	beqi	0, r1, beq_then.13163
	addi	r8, r0, 0
	lw	r1, 7(r3)
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	lw	r6, 8(r3)
	lw	r7, 1(r3)
	lw	r29, 4(r3)
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	j	beq_cont.13164
beq_then.13163:
	lw	r1, 7(r3)
	lw	r2, 8(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 0
	lw	r7, 2(r5)
	addi	r8, r0, 0
	lw	r7, 0(r7)
	ble	r8, r7, ble_then.13165
	j	ble_cont.13166
ble_then.13165:
	lw	r7, 3(r5)
	lw	r7, 0(r7)
	sw	r5, 9(r3)
	beqi	0, r7, beq_then.13167
	lw	r29, 6(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
	j	beq_cont.13168
beq_then.13167:
beq_cont.13168:
	addi	r2, r0, 1
	lw	r1, 9(r3)
	lw	r29, 5(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -11
	lw	r31, 10(r3)
ble_cont.13166:
beq_cont.13164:
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	write_rgb.3377				#	bl	write_rgb.3377
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 7(r3)
	addi	r1, r1, 1
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	lw	r6, 8(r3)
	lw	r7, 1(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
ble_then.13162:
	jr	r31				#
scan_line.3399:
	lw	r8, 2(r29)
	lw	r9, 1(r29)
	addi	r10, r0, 10743
	lw	r10, 1(r10)
	ble	r10, r1, ble_then.13170
	addi	r10, r0, 10743
	lw	r10, 1(r10)
	addi	r10, r10, -1
	sw	r29, 0(r3)
	sw	r7, 1(r3)
	sw	r6, 2(r3)
	sw	r5, 3(r3)
	sw	r2, 4(r3)
	sw	r1, 5(r3)
	sw	r8, 6(r3)
	ble	r10, r1, ble_then.13171
	addi	r10, r1, 1
	add	r5, r0, r7				# mr	r5, r7
	add	r2, r0, r10				# mr	r2, r10
	add	r1, r0, r6				# mr	r1, r6
	add	r29, r0, r9				# mr	r29, r9
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	j	ble_cont.13172
ble_then.13171:
ble_cont.13172:
	addi	r1, r0, 0
	lw	r2, 5(r3)
	lw	r5, 4(r3)
	lw	r6, 3(r3)
	lw	r7, 2(r3)
	lw	r29, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 5(r3)
	addi	r1, r1, 1
	lw	r2, 1(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5
	ble	r5, r2, ble_then.13173
	add	r7, r0, r2
	j	ble_cont.13174
ble_then.13173:
	addi	r7, r2, -5
ble_cont.13174:
	lw	r2, 3(r3)
	lw	r5, 2(r3)
	lw	r6, 4(r3)
	lw	r29, 0(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	jr	r31				#
ble_then.13170:
	jr	r31				#
create_float5x3array.3405:
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
create_pixel.3407:
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
	jal	create_float5x3array.3405				#	bl	create_float5x3array.3405
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
	jal	create_float5x3array.3405				#	bl	create_float5x3array.3405
	addi	r3, r3, -6
	lw	r31, 5(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_float5x3array.3405				#	bl	create_float5x3array.3405
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
	jal	create_float5x3array.3405				#	bl	create_float5x3array.3405
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
init_line_elements.3409:
	lw	r5, 1(r29)
	addi	r6, r0, 0
	ble	r6, r2, ble_then.13177
	jr	r31				#
ble_then.13177:
	sw	r29, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	add	r29, r0, r5				# mr	r29, r5
	sw	r31, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r2, 2(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13178
	add	r1, r0, r5
	jr	r31				#
ble_then.13178:
	lw	r29, 1(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 4(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13179
	add	r1, r0, r5
	jr	r31				#
ble_then.13179:
	lw	r29, 1(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 5(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13180
	add	r1, r0, r5
	jr	r31				#
ble_then.13180:
	lw	r29, 1(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	lw	r5, 3(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r28, 0(r29)
	jr	r28
create_pixelline.3412:
	lw	r1, 2(r29)
	lw	r29, 1(r29)
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	sw	r1, 0(r3)
	sw	r29, 1(r3)
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r2, r2, -2
	addi	r5, r0, 0
	ble	r5, r2, ble_then.13181
	jr	r31				#
ble_then.13181:
	lw	r29, 1(r3)
	sw	r2, 3(r3)
	sw	r1, 4(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 3(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13182
	add	r1, r0, r5
	jr	r31				#
ble_then.13182:
	lw	r29, 1(r3)
	sw	r1, 5(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 5(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13183
	add	r1, r0, r5
	jr	r31				#
ble_then.13183:
	lw	r29, 1(r3)
	sw	r1, 6(r3)
	sw	r31, 7(r3)
	addi	r3, r3, 8
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r2, 6(r3)
	lw	r5, 4(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 0(r3)
	add	r1, r0, r5				# mr	r1, r5
	lw	r28, 0(r29)
	jr	r28
tan.3414:
	fsw	f1, 0(r3)
	sw	r31, 2(r3)
	addi	r3, r3, 3
	jal	sin.2920				#	bl	sin.2920
	addi	r3, r3, -3
	lw	r31, 2(r3)
	flw	f2, 0(r3)
	fsw	f1, 2(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	cos.2922				#	bl	cos.2922
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fdiv	f1, f2, f1
	jr	r31				#
adjust_position.3416:
	fmul	f1, f1, f1
	flup	f3, 45		# fli	f3, 0.100000
	fadd	f1, f1, f3
	fsqrt	f1, f1
	flup	f3, 2		# fli	f3, 1.000000
	fdiv	f3, f3, f1
	fsw	f1, 0(r3)
	fsw	f2, 2(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	atan.2926				#	bl	atan.2926
	addi	r3, r3, -5
	lw	r31, 4(r3)
	flw	f2, 2(r3)
	fmul	f1, f1, f2
	fsw	f1, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	sin.2920				#	bl	sin.2920
	addi	r3, r3, -7
	lw	r31, 6(r3)
	flw	f2, 4(r3)
	fsw	f1, 6(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	cos.2922				#	bl	cos.2922
	addi	r3, r3, -9
	lw	r31, 8(r3)
	flw	f2, 6(r3)
	fdiv	f1, f2, f1
	flw	f2, 0(r3)
	fmul	f1, f1, f2
	jr	r31				#
calc_dirvec.3419:
	lw	r6, 1(r29)
	addi	r7, r0, 5
	ble	r7, r1, ble_then.13184
	fmul	f1, f2, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f1, f1, f2
	fsqrt	f1, f1
	flup	f2, 2		# fli	f2, 1.000000
	fdiv	f2, f2, f1
	sw	r5, 0(r3)
	sw	r2, 1(r3)
	sw	r29, 2(r3)
	fsw	f4, 4(r3)
	sw	r1, 6(r3)
	fsw	f1, 8(r3)
	fsw	f3, 10(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	atan.2926				#	bl	atan.2926
	addi	r3, r3, -13
	lw	r31, 12(r3)
	flw	f2, 10(r3)
	fmul	f1, f1, f2
	fsw	f1, 12(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	sin.2920				#	bl	sin.2920
	addi	r3, r3, -15
	lw	r31, 14(r3)
	flw	f2, 12(r3)
	fsw	f1, 14(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	cos.2922				#	bl	cos.2922
	addi	r3, r3, -17
	lw	r31, 16(r3)
	flw	f2, 14(r3)
	fdiv	f1, f2, f1
	flw	f2, 8(r3)
	fmul	f1, f1, f2
	lw	r1, 6(r3)
	addi	r1, r1, 1
	fmul	f2, f1, f1
	flup	f3, 45		# fli	f3, 0.100000
	fadd	f2, f2, f3
	fsqrt	f2, f2
	flup	f3, 2		# fli	f3, 1.000000
	fdiv	f3, f3, f2
	fsw	f1, 16(r3)
	sw	r1, 18(r3)
	fsw	f2, 20(r3)
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 22(r3)
	addi	r3, r3, 23
	jal	atan.2926				#	bl	atan.2926
	addi	r3, r3, -23
	lw	r31, 22(r3)
	flw	f2, 4(r3)
	fmul	f1, f1, f2
	fsw	f1, 22(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	sin.2920				#	bl	sin.2920
	addi	r3, r3, -25
	lw	r31, 24(r3)
	flw	f2, 22(r3)
	fsw	f1, 24(r3)
	fadd	f1, f0, f2				# fmr	f1, f2
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	cos.2922				#	bl	cos.2922
	addi	r3, r3, -27
	lw	r31, 26(r3)
	flw	f2, 24(r3)
	fdiv	f1, f2, f1
	flw	f2, 20(r3)
	fmul	f2, f1, f2
	flw	f1, 16(r3)
	flw	f3, 10(r3)
	flw	f4, 4(r3)
	lw	r1, 18(r3)
	lw	r2, 1(r3)
	lw	r5, 0(r3)
	lw	r29, 2(r3)
	lw	r28, 0(r29)
	jr	r28
ble_then.13184:
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
	add	r30, r6, r2
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
calc_dirvecs.3427:
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.13189
	jr	r31				#
ble_then.13189:
	itof	f2, r1
	flup	f3, 18		# fli	f3, 0.200000
	fmul	f2, f2, f3
	flup	f3, 48		# fli	f3, 0.900000
	fsub	f3, f2, f3
	addi	r7, r0, 0
	flup	f2, 0		# fli	f2, 0.000000
	flup	f4, 0		# fli	f4, 0.000000
	sw	r29, 0(r3)
	fsw	f1, 2(r3)
	sw	r2, 4(r3)
	sw	r6, 5(r3)
	sw	r5, 6(r3)
	sw	r1, 7(r3)
	add	r1, r0, r7				# mr	r1, r7
	add	r29, r0, r6				# mr	r29, r6
	fadd	f30, f0, f4				# fmr	f30, f4
	fadd	f4, f0, f1				# fmr	f4, f1
	fadd	f1, f0, f2				# fmr	f1, f2
	fadd	f2, f0, f30				# fmr	f2, f30
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 7(r3)
	itof	f1, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 45		# fli	f2, 0.100000
	fadd	f3, f1, f2
	addi	r2, r0, 0
	flup	f1, 0		# fli	f1, 0.000000
	flup	f2, 0		# fli	f2, 0.000000
	lw	r5, 6(r3)
	addi	r6, r5, 2
	flw	f4, 2(r3)
	lw	r7, 4(r3)
	lw	r29, 5(r3)
	add	r5, r0, r6				# mr	r5, r6
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r7				# mr	r2, r7
	sw	r31, 8(r3)
	addi	r3, r3, 9
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -9
	lw	r31, 8(r3)
	lw	r1, 7(r3)
	addi	r1, r1, -1
	lw	r2, 4(r3)
	addi	r2, r2, 1
	addi	r5, r0, 5
	ble	r5, r2, ble_then.13192
	j	ble_cont.13193
ble_then.13192:
	addi	r2, r2, -5
ble_cont.13193:
	flw	f1, 2(r3)
	lw	r5, 6(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
calc_dirvec_rows.3432:
	lw	r6, 1(r29)
	addi	r7, r0, 0
	ble	r7, r1, ble_then.13194
	jr	r31				#
ble_then.13194:
	itof	f1, r1
	flup	f2, 18		# fli	f2, 0.200000
	fmul	f1, f1, f2
	flup	f2, 48		# fli	f2, 0.900000
	fsub	f1, f1, f2
	addi	r7, r0, 4
	sw	r29, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	sw	r1, 3(r3)
	add	r1, r0, r7				# mr	r1, r7
	add	r29, r0, r6				# mr	r29, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 3(r3)
	addi	r1, r1, -1
	lw	r2, 2(r3)
	addi	r2, r2, 2
	addi	r5, r0, 5
	ble	r5, r2, ble_then.13196
	j	ble_cont.13197
ble_then.13196:
	addi	r2, r2, -5
ble_cont.13197:
	lw	r5, 1(r3)
	addi	r5, r5, 4
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
create_dirvec.3436:
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
create_dirvec_elements.3438:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.13198
	jr	r31				#
ble_then.13198:
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
	ble	r2, r1, ble_then.13200
	jr	r31				#
ble_then.13200:
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
	addi	r2, r2, -1
	add	r1, r0, r5				# mr	r1, r5
	j	create_dirvec_elements.3438
create_dirvecs.3441:
	lw	r2, 1(r29)
	addi	r5, r0, 0
	ble	r5, r1, ble_then.13202
	jr	r31				#
ble_then.13202:
	addi	r5, r0, 120
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r29, 0(r3)
	sw	r1, 1(r3)
	sw	r2, 2(r3)
	sw	r5, 3(r3)
	add	r1, r0, r6				# mr	r1, r6
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
	lw	r1, 3(r3)
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	add	r30, r5, r2
	lw	r1, 0(r30)
	addi	r6, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 5(r3)
	add	r1, r0, r6				# mr	r1, r6
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
	sw	r1, 118(r2)
	addi	r1, r0, 117
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	create_dirvec_elements.3438				#	bl	create_dirvec_elements.3438
	addi	r3, r3, -8
	lw	r31, 7(r3)
	lw	r1, 1(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13204
	jr	r31				#
ble_then.13204:
	addi	r2, r0, 120
	addi	r5, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 7(r3)
	sw	r2, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 9(r3)
	addi	r3, r3, 10
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -10
	lw	r31, 9(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 10000
	lw	r1, 0(r1)
	sw	r2, 9(r3)
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	lib_create_array				#	bl	lib_create_array
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
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r2, 7(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	add	r30, r5, r2
	lw	r1, 0(r30)
	addi	r5, r0, 118
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 10(r3)
	addi	r3, r3, 11
	jal	create_dirvec_elements.3438				#	bl	create_dirvec_elements.3438
	addi	r3, r3, -11
	lw	r31, 10(r3)
	lw	r1, 7(r3)
	addi	r1, r1, -1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
init_dirvec_constants.3443:
	addi	r5, r0, 0
	ble	r5, r2, ble_then.13206
	jr	r31				#
ble_then.13206:
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
	jal	iter_setup_dirvec_constants.3225				#	bl	iter_setup_dirvec_constants.3225
	addi	r3, r3, -3
	lw	r31, 2(r3)
	lw	r1, 1(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13208
	jr	r31				#
ble_then.13208:
	lw	r2, 0(r3)
	add	r30, r2, r1
	lw	r5, 0(r30)
	addi	r6, r0, 10000
	lw	r6, 0(r6)
	addi	r6, r6, -1
	sw	r1, 2(r3)
	add	r2, r0, r6				# mr	r2, r6
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	iter_setup_dirvec_constants.3225				#	bl	iter_setup_dirvec_constants.3225
	addi	r3, r3, -4
	lw	r31, 3(r3)
	lw	r1, 2(r3)
	addi	r2, r1, -1
	lw	r1, 0(r3)
	j	init_dirvec_constants.3443
init_vecset_constants.3446:
	lw	r2, 1(r29)
	addi	r5, r0, 0
	ble	r5, r1, ble_then.13210
	jr	r31				#
ble_then.13210:
	add	r30, r2, r1
	lw	r5, 0(r30)
	lw	r6, 119(r5)
	addi	r7, r0, 10000
	lw	r7, 0(r7)
	addi	r7, r7, -1
	sw	r29, 0(r3)
	sw	r2, 1(r3)
	sw	r1, 2(r3)
	sw	r5, 3(r3)
	add	r2, r0, r7				# mr	r2, r7
	add	r1, r0, r6				# mr	r1, r6
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	iter_setup_dirvec_constants.3225				#	bl	iter_setup_dirvec_constants.3225
	addi	r3, r3, -5
	lw	r31, 4(r3)
	addi	r2, r0, 118
	lw	r1, 3(r3)
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	init_dirvec_constants.3443				#	bl	init_dirvec_constants.3443
	addi	r3, r3, -5
	lw	r31, 4(r3)
	lw	r1, 2(r3)
	addi	r1, r1, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13212
	jr	r31				#
ble_then.13212:
	lw	r2, 1(r3)
	add	r30, r2, r1
	lw	r2, 0(r30)
	addi	r5, r0, 119
	sw	r1, 4(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 5(r3)
	addi	r3, r3, 6
	jal	init_dirvec_constants.3443				#	bl	init_dirvec_constants.3443
	addi	r3, r3, -6
	lw	r31, 5(r3)
	lw	r1, 4(r3)
	addi	r1, r1, -1
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
init_dirvecs.3448:
	lw	r1, 4(r29)
	lw	r2, 3(r29)
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	addi	r7, r0, 120
	addi	r8, r0, 3
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 0(r3)
	sw	r6, 1(r3)
	sw	r5, 2(r3)
	sw	r2, 3(r3)
	sw	r7, 4(r3)
	add	r1, r0, r8				# mr	r1, r8
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
	lw	r1, 4(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r2, 3(r3)
	sw	r1, 4(r2)
	lw	r1, 4(r2)
	addi	r5, r0, 118
	add	r2, r0, r5				# mr	r2, r5
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	create_dirvec_elements.3438				#	bl	create_dirvec_elements.3438
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 3
	lw	r29, 2(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r29, 1(r3)
	sw	r31, 6(r3)
	addi	r3, r3, 7
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -7
	lw	r31, 6(r3)
	lw	r1, 3(r3)
	lw	r1, 4(r1)
	addi	r2, r0, 119
	sw	r31, 6(r3)
	addi	r3, r3, 7
	jal	init_dirvec_constants.3443				#	bl	init_dirvec_constants.3443
	addi	r3, r3, -7
	lw	r31, 6(r3)
	addi	r1, r0, 3
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
add_reflection.3450:
	lw	r5, 1(r29)
	addi	r6, r0, 3
	flup	f5, 0		# fli	f5, 0.000000
	sw	r1, 0(r3)
	sw	r5, 1(r3)
	sw	r2, 2(r3)
	fsw	f1, 4(r3)
	fsw	f4, 6(r3)
	fsw	f3, 8(r3)
	fsw	f2, 10(r3)
	add	r1, r0, r6				# mr	r1, r6
	fadd	f1, f0, f5				# fmr	f1, f5
	sw	r31, 12(r3)
	addi	r3, r3, 13
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -13
	lw	r31, 12(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 10000
	lw	r1, 0(r1)
	sw	r2, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	jal	lib_create_array				#	bl	lib_create_array
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
	addi	r1, r0, 10000
	lw	r1, 0(r1)
	addi	r1, r1, -1
	sw	r2, 13(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 14(r3)
	addi	r3, r3, 15
	jal	iter_setup_dirvec_constants.3225				#	bl	iter_setup_dirvec_constants.3225
	addi	r3, r3, -15
	lw	r31, 14(r3)
	add	r1, r0, r4
	addi	r4, r4, 3
	flw	f1, 4(r3)
	fsw	f1, 2(r1)
	lw	r2, 13(r3)
	sw	r2, 1(r1)
	lw	r2, 2(r3)
	sw	r2, 0(r1)
	lw	r2, 0(r3)
	lw	r5, 1(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	jr	r31				#
setup_rect_reflection.3457:
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	slli	r1, r1, 2
	lw	r7, 0(r6)
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
	addi	r8, r0, 10667
	flw	f5, 0(r8)
	addi	r8, r0, 3
	flup	f6, 0		# fli	f6, 0.000000
	sw	r6, 0(r3)
	fsw	f2, 2(r3)
	sw	r1, 4(r3)
	sw	r7, 5(r3)
	sw	r5, 6(r3)
	sw	r2, 7(r3)
	fsw	f1, 8(r3)
	fsw	f4, 10(r3)
	fsw	f3, 12(r3)
	fsw	f5, 14(r3)
	add	r1, r0, r8				# mr	r1, r8
	fadd	f1, f0, f6				# fmr	f1, f6
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -17
	lw	r31, 16(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 10000
	lw	r1, 0(r1)
	sw	r2, 16(r3)
	sw	r31, 17(r3)
	addi	r3, r3, 18
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -18
	lw	r31, 17(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 16(r3)
	sw	r1, 0(r2)
	flw	f1, 14(r3)
	fsw	f1, 0(r1)
	flw	f1, 12(r3)
	fsw	f1, 1(r1)
	flw	f2, 10(r3)
	fsw	f2, 2(r1)
	addi	r1, r0, 10000
	lw	r1, 0(r1)
	addi	r1, r1, -1
	sw	r2, 17(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 18(r3)
	addi	r3, r3, 19
	jal	iter_setup_dirvec_constants.3225				#	bl	iter_setup_dirvec_constants.3225
	addi	r3, r3, -19
	lw	r31, 18(r3)
	add	r1, r0, r4
	addi	r4, r4, 3
	flw	f1, 8(r3)
	fsw	f1, 2(r1)
	lw	r2, 17(r3)
	sw	r2, 1(r1)
	lw	r2, 7(r3)
	sw	r2, 0(r1)
	lw	r2, 5(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	r6, 4(r3)
	addi	r7, r6, 2
	addi	r8, r0, 10667
	flw	f2, 1(r8)
	addi	r8, r0, 3
	flup	f3, 0		# fli	f3, 0.000000
	sw	r1, 18(r3)
	sw	r7, 19(r3)
	fsw	f2, 20(r3)
	add	r1, r0, r8				# mr	r1, r8
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
	lw	r1, 22(r3)
	sw	r1, 0(r2)
	flw	f1, 2(r3)
	fsw	f1, 0(r1)
	flw	f2, 20(r3)
	fsw	f2, 1(r1)
	flw	f2, 10(r3)
	fsw	f2, 2(r1)
	addi	r1, r0, 10000
	lw	r1, 0(r1)
	addi	r1, r1, -1
	sw	r2, 23(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 24(r3)
	addi	r3, r3, 25
	jal	iter_setup_dirvec_constants.3225				#	bl	iter_setup_dirvec_constants.3225
	addi	r3, r3, -25
	lw	r31, 24(r3)
	add	r1, r0, r4
	addi	r4, r4, 3
	flw	f1, 8(r3)
	fsw	f1, 2(r1)
	lw	r2, 23(r3)
	sw	r2, 1(r1)
	lw	r2, 19(r3)
	sw	r2, 0(r1)
	lw	r2, 18(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 5(r3)
	addi	r2, r1, 2
	lw	r6, 4(r3)
	addi	r6, r6, 3
	addi	r7, r0, 10667
	flw	f2, 2(r7)
	addi	r7, r0, 3
	flup	f3, 0		# fli	f3, 0.000000
	sw	r2, 24(r3)
	sw	r6, 25(r3)
	fsw	f2, 26(r3)
	add	r1, r0, r7				# mr	r1, r7
	fadd	f1, f0, f3				# fmr	f1, f3
	sw	r31, 28(r3)
	addi	r3, r3, 29
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -29
	lw	r31, 28(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 10000
	lw	r1, 0(r1)
	sw	r2, 28(r3)
	sw	r31, 29(r3)
	addi	r3, r3, 30
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -30
	lw	r31, 29(r3)
	add	r2, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r2)
	lw	r1, 28(r3)
	sw	r1, 0(r2)
	flw	f1, 2(r3)
	fsw	f1, 0(r1)
	flw	f1, 12(r3)
	fsw	f1, 1(r1)
	flw	f1, 26(r3)
	fsw	f1, 2(r1)
	addi	r1, r0, 10000
	lw	r1, 0(r1)
	addi	r1, r1, -1
	sw	r2, 29(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 30(r3)
	addi	r3, r3, 31
	jal	iter_setup_dirvec_constants.3225				#	bl	iter_setup_dirvec_constants.3225
	addi	r3, r3, -31
	lw	r31, 30(r3)
	add	r1, r0, r4
	addi	r4, r4, 3
	flw	f1, 8(r3)
	fsw	f1, 2(r1)
	lw	r2, 29(r3)
	sw	r2, 1(r1)
	lw	r2, 25(r3)
	sw	r2, 0(r1)
	lw	r2, 24(r3)
	lw	r5, 6(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	lw	r1, 5(r3)
	addi	r1, r1, 3
	lw	r2, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#
setup_surface_reflection.3460:
	lw	r5, 2(r29)
	lw	r6, 1(r29)
	slli	r1, r1, 2
	addi	r1, r1, 1
	lw	r7, 0(r6)
	flup	f1, 2		# fli	f1, 1.000000
	lw	r8, 7(r2)
	flw	f2, 0(r8)
	fsub	f1, f1, f2
	addi	r8, r0, 10667
	lw	r9, 4(r2)
	sw	r6, 0(r3)
	sw	r7, 1(r3)
	sw	r5, 2(r3)
	sw	r1, 3(r3)
	fsw	f1, 4(r3)
	sw	r2, 6(r3)
	add	r2, r0, r9				# mr	r2, r9
	add	r1, r0, r8				# mr	r1, r8
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	veciprod.3013				#	bl	veciprod.3013
	addi	r3, r3, -8
	lw	r31, 7(r3)
	flup	f2, 3		# fli	f2, 2.000000
	lw	r1, 6(r3)
	lw	r2, 4(r1)
	flw	f3, 0(r2)
	fmul	f2, f2, f3
	fmul	f2, f2, f1
	addi	r2, r0, 10667
	flw	f3, 0(r2)
	fsub	f2, f2, f3
	flup	f3, 3		# fli	f3, 2.000000
	lw	r2, 4(r1)
	flw	f4, 1(r2)
	fmul	f3, f3, f4
	fmul	f3, f3, f1
	addi	r2, r0, 10667
	flw	f4, 1(r2)
	fsub	f3, f3, f4
	flup	f4, 3		# fli	f4, 2.000000
	lw	r1, 4(r1)
	flw	f5, 2(r1)
	fmul	f4, f4, f5
	fmul	f1, f4, f1
	addi	r1, r0, 10667
	flw	f4, 2(r1)
	fsub	f1, f1, f4
	addi	r1, r0, 3
	flup	f4, 0		# fli	f4, 0.000000
	fsw	f1, 8(r3)
	fsw	f3, 10(r3)
	fsw	f2, 12(r3)
	fadd	f1, f0, f4				# fmr	f1, f4
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
	flw	f1, 12(r3)
	fsw	f1, 0(r1)
	flw	f1, 10(r3)
	fsw	f1, 1(r1)
	flw	f1, 8(r3)
	fsw	f1, 2(r1)
	addi	r1, r0, 10000
	lw	r1, 0(r1)
	addi	r1, r1, -1
	sw	r2, 15(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	iter_setup_dirvec_constants.3225				#	bl	iter_setup_dirvec_constants.3225
	addi	r3, r3, -17
	lw	r31, 16(r3)
	add	r1, r0, r4
	addi	r4, r4, 3
	flw	f1, 4(r3)
	fsw	f1, 2(r1)
	lw	r2, 15(r3)
	sw	r2, 1(r1)
	lw	r2, 3(r3)
	sw	r2, 0(r1)
	lw	r2, 1(r3)
	lw	r5, 2(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, 1
	lw	r2, 0(r3)
	sw	r1, 0(r2)
	jr	r31				#
setup_reflections.3463:
	lw	r2, 2(r29)
	lw	r29, 1(r29)
	addi	r5, r0, 0
	ble	r5, r1, ble_then.13220
	jr	r31				#
ble_then.13220:
	addi	r5, r0, 10001
	add	r30, r5, r1
	lw	r5, 0(r30)
	lw	r6, 2(r5)
	beqi	2, r6, beq_then.13222
	jr	r31				#
beq_then.13222:
	flup	f1, 2		# fli	f1, 1.000000
	lw	r6, 7(r5)
	flw	f2, 0(r6)
	fle	r30, f1, f2
	beq	r0, r30, fle_else.13224
	jr	r31				#
fle_else.13224:
	lw	r6, 1(r5)
	beqi	1, r6, beq_then.13226
	beqi	2, r6, beq_then.13227
	jr	r31				#
beq_then.13227:
	add	r29, r0, r2				# mr	r29, r2
	add	r2, r0, r5				# mr	r2, r5
	lw	r28, 0(r29)
	jr	r28
beq_then.13226:
	add	r2, r0, r5				# mr	r2, r5
	lw	r28, 0(r29)
	jr	r28
rt.3465:
	lw	r5, 10(r29)
	lw	r6, 9(r29)
	lw	r7, 8(r29)
	lw	r8, 7(r29)
	lw	r9, 6(r29)
	lw	r10, 5(r29)
	lw	r11, 4(r29)
	lw	r12, 3(r29)
	lw	r13, 2(r29)
	lw	r14, 1(r29)
	addi	r15, r0, 10743
	sw	r1, 0(r15)
	addi	r15, r0, 10743
	sw	r2, 1(r15)
	addi	r15, r0, 10745
	srai	r16, r1, 1
	sw	r16, 0(r15)
	addi	r15, r0, 10745
	srai	r2, r2, 1
	sw	r2, 1(r15)
	addi	r2, r0, 10747
	flup	f1, 49		# fli	f1, 128.000000
	itof	f2, r1
	fdiv	f1, f1, f2
	fsw	f1, 0(r2)
	addi	r1, r0, 10743
	lw	r1, 0(r1)
	sw	r7, 0(r3)
	sw	r8, 1(r3)
	sw	r6, 2(r3)
	sw	r9, 3(r3)
	sw	r5, 4(r3)
	sw	r10, 5(r3)
	sw	r14, 6(r3)
	sw	r13, 7(r3)
	sw	r11, 8(r3)
	sw	r12, 9(r3)
	sw	r1, 10(r3)
	add	r29, r0, r12				# mr	r29, r12
	sw	r31, 11(r3)
	addi	r3, r3, 12
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -12
	lw	r31, 11(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 10(r3)
	sw	r31, 11(r3)
	addi	r3, r3, 12
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -12
	lw	r31, 11(r3)
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r2, r2, -2
	addi	r5, r0, 0
	ble	r5, r2, ble_then.13229
	j	ble_cont.13230
ble_then.13229:
	lw	r29, 9(r3)
	sw	r2, 11(r3)
	sw	r1, 12(r3)
	sw	r31, 13(r3)
	addi	r3, r3, 14
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -14
	lw	r31, 13(r3)
	lw	r2, 11(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13231
	add	r1, r0, r5
	j	ble_cont.13232
ble_then.13231:
	lw	r29, 9(r3)
	sw	r1, 13(r3)
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
	lw	r2, 13(r3)
	lw	r5, 12(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 14(r3)
	addi	r3, r3, 15
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -15
	lw	r31, 14(r3)
ble_cont.13232:
ble_cont.13230:
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	lw	r29, 9(r3)
	sw	r1, 14(r3)
	sw	r2, 15(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -17
	lw	r31, 16(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 15(r3)
	sw	r31, 16(r3)
	addi	r3, r3, 17
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -17
	lw	r31, 16(r3)
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r2, r2, -2
	addi	r5, r0, 0
	ble	r5, r2, ble_then.13233
	j	ble_cont.13234
ble_then.13233:
	lw	r29, 9(r3)
	sw	r2, 16(r3)
	sw	r1, 17(r3)
	sw	r31, 18(r3)
	addi	r3, r3, 19
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -19
	lw	r31, 18(r3)
	lw	r2, 16(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13235
	add	r1, r0, r5
	j	ble_cont.13236
ble_then.13235:
	lw	r29, 9(r3)
	sw	r1, 18(r3)
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
	lw	r2, 18(r3)
	lw	r5, 17(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 19(r3)
	addi	r3, r3, 20
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -20
	lw	r31, 19(r3)
ble_cont.13236:
ble_cont.13234:
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	lw	r29, 9(r3)
	sw	r1, 19(r3)
	sw	r2, 20(r3)
	sw	r31, 21(r3)
	addi	r3, r3, 22
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -22
	lw	r31, 21(r3)
	add	r2, r0, r1				# mr	r2, r1
	lw	r1, 20(r3)
	sw	r31, 21(r3)
	addi	r3, r3, 22
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -22
	lw	r31, 21(r3)
	addi	r2, r0, 10743
	lw	r2, 0(r2)
	addi	r2, r2, -2
	addi	r5, r0, 0
	ble	r5, r2, ble_then.13237
	j	ble_cont.13238
ble_then.13237:
	lw	r29, 9(r3)
	sw	r2, 21(r3)
	sw	r1, 22(r3)
	sw	r31, 23(r3)
	addi	r3, r3, 24
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -24
	lw	r31, 23(r3)
	lw	r2, 21(r3)
	lw	r5, 22(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r1, r2, -1
	addi	r2, r0, 0
	ble	r2, r1, ble_then.13239
	add	r1, r0, r5
	j	ble_cont.13240
ble_then.13239:
	lw	r29, 9(r3)
	sw	r1, 23(r3)
	sw	r31, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -25
	lw	r31, 24(r3)
	lw	r2, 23(r3)
	lw	r5, 22(r3)
	add	r30, r5, r2
	sw	r1, 0(r30)
	addi	r2, r2, -1
	lw	r29, 8(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 24(r3)
	addi	r3, r3, 25
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -25
	lw	r31, 24(r3)
ble_cont.13240:
ble_cont.13238:
	sw	r1, 24(r3)
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	read_screen_settings.3111				#	bl	read_screen_settings.3111
	addi	r3, r3, -26
	lw	r31, 25(r3)
	sw	r31, 25(r3)
	addi	r3, r3, 26
	jal	read_light.3113				#	bl	read_light.3113
	addi	r3, r3, -26
	lw	r31, 25(r3)
	addi	r1, r0, 0
	sw	r1, 25(r3)
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	read_nth_object.3118				#	bl	read_nth_object.3118
	addi	r3, r3, -27
	lw	r31, 26(r3)
	beqi	0, r1, beq_then.13241
	addi	r1, r0, 1
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	read_object.3120				#	bl	read_object.3120
	addi	r3, r3, -27
	lw	r31, 26(r3)
	j	beq_cont.13242
beq_then.13241:
	addi	r1, r0, 10000
	lw	r2, 25(r3)
	sw	r2, 0(r1)
beq_cont.13242:
	addi	r1, r0, 0
	sw	r31, 26(r3)
	addi	r3, r3, 27
	jal	read_and_network.3128				#	bl	read_and_network.3128
	addi	r3, r3, -27
	lw	r31, 26(r3)
	addi	r1, r0, 10723
	addi	r2, r0, 0
	sw	r1, 26(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	read_or_network.3126				#	bl	read_or_network.3126
	addi	r3, r3, -28
	lw	r31, 27(r3)
	lw	r2, 26(r3)
	sw	r1, 0(r2)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	write_ppm_header.3373				#	bl	write_ppm_header.3373
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r1, r0, 4
	lw	r29, 7(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r1, r0, 9
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r29, 6(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r1, r0, 4
	lw	r29, 5(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
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
	sw	r31, 27(r3)
	addi	r3, r3, 28
	jal	iter_setup_dirvec_constants.3225				#	bl	iter_setup_dirvec_constants.3225
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r1, r0, 10000
	lw	r1, 0(r1)
	addi	r1, r1, -1
	lw	r29, 2(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r2, r0, 0
	addi	r5, r0, 0
	lw	r1, 19(r3)
	lw	r29, 1(r3)
	sw	r31, 27(r3)
	addi	r3, r3, 28
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -28
	lw	r31, 27(r3)
	addi	r1, r0, 0
	addi	r7, r0, 2
	lw	r2, 14(r3)
	lw	r5, 19(r3)
	lw	r6, 24(r3)
	lw	r29, 0(r3)
	lw	r28, 0(r29)
	jr	r28
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
  sw  r1  672(r4)
  sw  r1  673(r4)
  sw  r1  674(r4)
  sw  r1  675(r4)
  sw  r1  676(r4)
  sw  r1  677(r4)
  sw  r1  678(r4)
  sw  r1  679(r4)
  sw  r1  680(r4)
  sw  r1  681(r4)
  sw  r1  682(r4)
  sw  r1  683(r4)
  sw  r1  684(r4)
  sw  r1  685(r4)
  sw  r1  686(r4)
  sw  r1  687(r4)
  sw  r1  688(r4)
  sw  r1  689(r4)
  sw  r1  690(r4)
  sw  r1  691(r4)
  sw  r1  692(r4)
  sw  r1  693(r4)
  sw  r1  694(r4)
  sw  r1  695(r4)
  sw  r1  696(r4)
  sw  r1  697(r4)
  sw  r1  698(r4)
  sw  r1  699(r4)
  sw  r1  700(r4)
  sw  r1  701(r4)
  sw  r1  702(r4)
  sw  r1  703(r4)
  sw  r1  704(r4)
  sw  r1  705(r4)
  sw  r1  706(r4)
  sw  r1  707(r4)
  sw  r1  708(r4)
  sw  r1  709(r4)
  sw  r1  710(r4)
  sw  r1  711(r4)
  sw  r1  712(r4)
  sw  r1  713(r4)
  sw  r1  714(r4)
  sw  r1  715(r4)
  sw  r1  716(r4)
  sw  r1  717(r4)
  sw  r1  718(r4)
  sw  r1  719(r4)
  sw  r1  720(r4)
  sw  r1  721(r4)
# or_net
  sw  r1  722(r4)
  addi  r1, r4, 10722
  sw  r1  723(r4)
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
  addi  r4, r4, 766
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
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 0
	sw	r2, 2(r3)
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 0
	add	r5, r0, r4
	addi	r4, r4, 2
	sw	r1, 1(r5)
	lw	r1, 2(r3)
	sw	r1, 0(r5)
	add	r1, r0, r5
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 5
	sw	r31, 3(r3)
	addi	r3, r3, 4
	jal	lib_create_array				#	bl	lib_create_array
	addi	r3, r3, -4
	lw	r31, 3(r3)
	addi	r2, r0, 0
	flup	f1, 0		# fli	f1, 0.000000
	sw	r1, 3(r3)
	add	r1, r0, r2				# mr	r1, r2
	sw	r31, 4(r3)
	addi	r3, r3, 5
	jal	lib_create_float_array				#	bl	lib_create_float_array
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
	addi	r2, r0, 60
	lw	r5, 4(r3)
	sw	r1, 5(r3)
	add	r1, r0, r2				# mr	r1, r2
	add	r2, r0, r5				# mr	r2, r5
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
	addi	r5, r0, 0
	flup	f1, 0		# fli	f1, 0.000000
	sw	r2, 6(r3)
	add	r1, r0, r5				# mr	r1, r5
	sw	r31, 7(r3)
	addi	r3, r3, 8
	jal	lib_create_float_array				#	bl	lib_create_float_array
	addi	r3, r3, -8
	lw	r31, 7(r3)
	add	r2, r0, r1				# mr	r2, r1
	addi	r1, r0, 0
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
	addi	r2, r0, 180
	addi	r5, r0, 0
	flup	f1, 0		# fli	f1, 0.000000
	add	r6, r0, r4
	addi	r4, r4, 3
	fsw	f1, 2(r6)
	sw	r1, 1(r6)
	sw	r5, 0(r6)
	add	r1, r0, r6
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	sw	r31, 8(r3)
	addi	r3, r3, 9
	jal	lib_create_array				#	bl	lib_create_array
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
	add	r2, r0, r4
	addi	r4, r4, 2
	addi	r5, r0, shadow_check_and_group.3261
	sw	r5, 0(r2)
	lw	r5, 6(r3)
	sw	r5, 1(r2)
	add	r6, r0, r4
	addi	r4, r4, 2
	addi	r7, r0, shadow_check_one_or_group.3264
	sw	r7, 0(r6)
	sw	r2, 1(r6)
	add	r7, r0, r4
	addi	r4, r4, 4
	addi	r8, r0, shadow_check_one_or_matrix.3267
	sw	r8, 0(r7)
	sw	r6, 3(r7)
	sw	r2, 2(r7)
	sw	r5, 1(r7)
	add	r2, r0, r4
	addi	r4, r4, 3
	addi	r6, r0, trace_reflections.3314
	sw	r6, 0(r2)
	sw	r7, 2(r2)
	lw	r6, 8(r3)
	sw	r6, 1(r2)
	add	r8, r0, r4
	addi	r4, r4, 6
	addi	r9, r0, trace_ray.3319
	sw	r9, 0(r8)
	lw	r9, 1(r3)
	sw	r9, 5(r8)
	sw	r2, 4(r8)
	sw	r7, 3(r8)
	sw	r1, 2(r8)
	lw	r2, 0(r3)
	sw	r2, 1(r8)
	add	r9, r0, r4
	addi	r4, r4, 2
	addi	r10, r0, trace_diffuse_ray.3325
	sw	r10, 0(r9)
	sw	r7, 1(r9)
	add	r7, r0, r4
	addi	r4, r4, 2
	addi	r10, r0, iter_trace_diffuse_rays.3328
	sw	r10, 0(r7)
	sw	r9, 1(r7)
	add	r9, r0, r4
	addi	r4, r4, 3
	addi	r10, r0, trace_diffuse_ray_80percent.3337
	sw	r10, 0(r9)
	sw	r7, 2(r9)
	lw	r10, 3(r3)
	sw	r10, 1(r9)
	add	r11, r0, r4
	addi	r4, r4, 2
	addi	r12, r0, calc_diffuse_using_1point.3341
	sw	r12, 0(r11)
	sw	r9, 1(r11)
	add	r12, r0, r4
	addi	r4, r4, 3
	addi	r13, r0, do_without_neighbors.3350
	sw	r13, 0(r12)
	sw	r9, 2(r12)
	sw	r11, 1(r12)
	add	r9, r0, r4
	addi	r4, r4, 3
	addi	r13, r0, try_exploit_neighbors.3366
	sw	r13, 0(r9)
	sw	r12, 2(r9)
	sw	r11, 1(r9)
	add	r13, r0, r4
	addi	r4, r4, 3
	addi	r14, r0, pretrace_diffuse_rays.3379
	sw	r14, 0(r13)
	sw	r7, 2(r13)
	sw	r10, 1(r13)
	add	r7, r0, r4
	addi	r4, r4, 4
	addi	r14, r0, pretrace_pixels.3382
	sw	r14, 0(r7)
	sw	r8, 3(r7)
	sw	r13, 2(r7)
	sw	r2, 1(r7)
	add	r8, r0, r4
	addi	r4, r4, 2
	addi	r13, r0, pretrace_line.3389
	sw	r13, 0(r8)
	sw	r7, 1(r8)
	add	r7, r0, r4
	addi	r4, r4, 4
	addi	r13, r0, scan_pixel.3393
	sw	r13, 0(r7)
	sw	r9, 3(r7)
	sw	r12, 2(r7)
	sw	r11, 1(r7)
	add	r9, r0, r4
	addi	r4, r4, 3
	addi	r11, r0, scan_line.3399
	sw	r11, 0(r9)
	sw	r7, 2(r9)
	sw	r8, 1(r9)
	add	r7, r0, r4
	addi	r4, r4, 2
	addi	r11, r0, create_pixel.3407
	sw	r11, 0(r7)
	sw	r2, 1(r7)
	add	r2, r0, r4
	addi	r4, r4, 2
	addi	r11, r0, init_line_elements.3409
	sw	r11, 0(r2)
	sw	r7, 1(r2)
	add	r11, r0, r4
	addi	r4, r4, 2
	addi	r12, r0, calc_dirvec.3419
	sw	r12, 0(r11)
	sw	r10, 1(r11)
	add	r12, r0, r4
	addi	r4, r4, 2
	addi	r13, r0, calc_dirvecs.3427
	sw	r13, 0(r12)
	sw	r11, 1(r12)
	add	r11, r0, r4
	addi	r4, r4, 2
	addi	r13, r0, calc_dirvec_rows.3432
	sw	r13, 0(r11)
	sw	r12, 1(r11)
	add	r12, r0, r4
	addi	r4, r4, 2
	addi	r13, r0, create_dirvecs.3441
	sw	r13, 0(r12)
	sw	r10, 1(r12)
	add	r13, r0, r4
	addi	r4, r4, 2
	addi	r14, r0, init_vecset_constants.3446
	sw	r14, 0(r13)
	sw	r10, 1(r13)
	add	r10, r0, r4
	addi	r4, r4, 3
	addi	r14, r0, setup_rect_reflection.3457
	sw	r14, 0(r10)
	sw	r6, 2(r10)
	sw	r1, 1(r10)
	add	r14, r0, r4
	addi	r4, r4, 3
	addi	r15, r0, setup_surface_reflection.3460
	sw	r15, 0(r14)
	sw	r6, 2(r14)
	sw	r1, 1(r14)
	add	r1, r0, r4
	addi	r4, r4, 3
	addi	r6, r0, setup_reflections.3463
	sw	r6, 0(r1)
	sw	r14, 2(r1)
	sw	r10, 1(r1)
	add	r29, r0, r4
	addi	r4, r4, 11
	addi	r6, r0, rt.3465
	sw	r6, 0(r29)
	lw	r6, 5(r3)
	sw	r6, 10(r29)
	sw	r1, 9(r29)
	sw	r9, 8(r29)
	sw	r8, 7(r29)
	sw	r5, 6(r29)
	sw	r13, 5(r29)
	sw	r2, 4(r29)
	sw	r7, 3(r29)
	sw	r12, 2(r29)
	sw	r11, 1(r29)
	addi	r1, r0, 128
	addi	r2, r0, 128
	sw	r31, 9(r3)
	addi	r3, r3, 10
	lw	r30, 0(r29)
	jalr	r30
	addi	r3, r3, -10
	lw	r31, 9(r3)
	addi	_R_0, r0, 0
