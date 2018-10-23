	.text
	.globl _min_caml_start
putchar:
  out r1
  jalr  r31
print_num:
	addi	r1, r1, 48
	ble	r0, r0, putchar
mul10:
	addi	r2, r0, 3				# li	r2, 3
	sll	r2, r1, r2
	addi	r5, r0, 1				# li	r5, 1
	sll	r1, r1, r5
	add	r1, r2, r1
	jalr	r31				#	blr
div10_sub:
	add	r6, r2, r5
	addi	r7, r0, 1				# li	r7, 1
	sra	r6, r6, r7
	sw	r2, 0(r3)
	sw	r5, 4(r3)
	sw	r6, 8(r3)
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	mul10				#	bl	mul10
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 12(r3)
	ble	r1, r2, ble_then.137
	lw	r1, 0(r3)
	lw	r5, 8(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	ble	r0, r0, div10_sub
ble_then.137:
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	mul10				#	bl	mul10
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r1, 9
	lw	r2, 12(r3)
	ble	r2, r1, ble_then.138
	lw	r1, 8(r3)
	lw	r5, 4(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	ble	r0, r0, div10_sub
ble_then.138:
	lw	r1, 8(r3)
	jalr	r31				#	blr
div10:
	addi	r2, r0, 0				# li	r2, 0
	add	r5, r0, r1				# mr	r5, r1
	ble	r0, r0, div10_sub
iter_mul10:
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.139
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	mul10				#	bl	mul10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	ble	r0, r0, iter_mul10
beq_then.139:
	jalr	r31				#	blr
iter_div10:
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.140
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	div10				#	bl	div10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	ble	r0, r0, iter_div10
beq_then.140:
	jalr	r31				#	blr
keta_sub:
	addi	r5, r0, 10				# li	r5, 10
	ble	r5, r1, ble_then.141
	addi	r1, r2, 1
	jalr	r31				#	blr
ble_then.141:
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	div10				#	bl	div10
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	addi	r2, r2, 1
	ble	r0, r0, keta_sub
keta:
	addi	r2, r0, 0				# li	r2, 0
	ble	r0, r0, keta_sub
print_uint.64:
	addi	r2, r0, 10				# li	r2, 10
	ble	r2, r1, ble_then.142
	ble	r0, r0, print_num
ble_then.142:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	keta				#	bl	keta
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	sub	r2, r1, r2
	lw	r5, 0(r3)
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	iter_div10				#	bl	iter_div10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	print_num				#	bl	print_num
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 10				# li	r1, 10
	lw	r2, 0(r3)
	ble	r1, r2, ble_then.143
	addi	r1, r0, 1				# li	r1, 1
	lw	r5, 4(r3)
	sub	r1, r5, r1
	lw	r5, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	iter_mul10				#	bl	iter_mul10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sub	r1, r2, r1
	ble	r0, r0, print_uint.64
ble_then.143:
	addi	r1, r0, 1				# li	r1, 1
	lw	r5, 4(r3)
	sub	r1, r5, r1
	lw	r5, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	iter_mul10				#	bl	iter_mul10
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sub	r1, r2, r1
	ble	r0, r0, print_uint.64
print_int:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.144
	addi	r2, r0, 45				# li	r2, 45
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	putchar				#	bl	putchar
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	sub	r1, r0, r1
	ble	r0, r0, print_uint.64
ble_then.144:
	ble	r0, r0, print_uint.64

# library ends
print_num.38:
	addi	r1, r1, 48
	j	putchar
mul10.40:
	addi	r2, r0, 3				# li	r2, 3
	sll	r2, r1, r2
	addi	r5, r0, 1				# li	r5, 1
	sll	r1, r1, r5
	add	r1, r2, r1
	jalr	r31				#	blr
div10_sub.42:
	add	r6, r2, r5
	addi	r7, r0, 1				# li	r7, 1
	sra	r6, r6, r7
	sw	r2, 0(r3)
	sw	r5, 4(r3)
	sw	r6, 8(r3)
	sw	r1, 12(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r6				# mr	r1, r6
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	mul10.40				#	bl	mul10.40
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 12(r3)
	ble	r1, r2, ble_then.125
	lw	r1, 0(r3)
	lw	r5, 8(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	div10_sub.42
ble_then.125:
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 20(r3)
	addi	r3, r3, 24
	jal	mul10.40				#	bl	mul10.40
	addi	r30, r0, 24
	sub	r3, r3, r30
	lw	r30, 20(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r1, 9
	lw	r2, 12(r3)
	ble	r2, r1, ble_then.126
	lw	r1, 8(r3)
	lw	r5, 4(r3)
	add	r28, r0, r2				# mr	r28, r2
	add	r2, r0, r1				# mr	r2, r1
	add	r1, r0, r28				# mr	r1, r28
	j	div10_sub.42
ble_then.126:
	lw	r1, 8(r3)
	jalr	r31				#	blr
div10.46:
	addi	r2, r0, 0				# li	r2, 0
	add	r5, r0, r1				# mr	r5, r1
	j	div10_sub.42
iter_mul10.48:
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.127
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	mul10.40				#	bl	mul10.40
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j	iter_mul10.48
beq_then.127:
	jalr	r31				#	blr
iter_div10.51:
	addi	r5, r0, 0				# li	r5, 0
	beq	r2, r5, beq_then.128
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	div10.46				#	bl	div10.46
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	lw	r5, 0(r3)
	sub	r2, r5, r2
	j	iter_div10.51
beq_then.128:
	jalr	r31				#	blr
keta_sub.54:
	addi	r5, r0, 10				# li	r5, 10
	ble	r5, r1, ble_then.129
	addi	r1, r2, 1
	jalr	r31				#	blr
ble_then.129:
	sw	r2, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	div10.46				#	bl	div10.46
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	addi	r2, r2, 1
	j	keta_sub.54
keta.57:
	addi	r2, r0, 0				# li	r2, 0
	j	keta_sub.54
print_uint.59:
	addi	r2, r0, 10				# li	r2, 10
	ble	r2, r1, ble_then.130
	j	print_num.38
ble_then.130:
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	keta.57				#	bl	keta.57
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r2, r0, 1				# li	r2, 1
	sub	r2, r1, r2
	lw	r5, 0(r3)
	sw	r1, 4(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r5				# mr	r1, r5
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	iter_div10.51				#	bl	iter_div10.51
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	sw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	print_num.38				#	bl	print_num.38
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	addi	r1, r0, 1				# li	r1, 1
	lw	r2, 4(r3)
	sub	r2, r2, r1
	lw	r1, 8(r3)
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 12(r3)
	addi	r3, r3, 16
	jal	iter_mul10.48				#	bl	iter_mul10.48
	addi	r30, r0, 16
	sub	r3, r3, r30
	lw	r30, 12(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r2, 0(r3)
	sub	r1, r2, r1
	j	print_uint.59
print_int.61:
	addi	r2, r0, 0				# li	r2, 0
	ble	r2, r1, ble_then.131
	addi	r2, r0, 45				# li	r2, 45
	sw	r1, 0(r3)
	addi	r30, r31, 0				#mflr	r30
	add	r1, r0, r2				# mr	r1, r2
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	putchar				#	bl	putchar
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
	lw	r1, 0(r3)
	sub	r1, r0, r1
	j	print_uint.59
ble_then.131:
	j	print_uint.59
_min_caml_start: # main entry point
#	main program starts
	addi	r1, r0, 32				# li	r1, 32
	addi	r30, r31, 0				#mflr	r30
	sw	r30, 4(r3)
	addi	r3, r3, 8
	jal	print_int.61				#	bl	print_int.61
	addi	r30, r0, 8
	sub	r3, r3, r30
	lw	r30, 4(r3)
	add	r31, r0, r30				#mtlr	r30
