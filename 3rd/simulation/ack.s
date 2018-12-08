	.file "ack.ml"
	.section .rodata.cst8,"a",@progbits
	.align	16
caml_negf_mask:	.quad   0x8000000000000000, 0
	.align	16
caml_absf_mask:	.quad   0x7FFFFFFFFFFFFFFF, 0xFFFFFFFFFFFFFFFF
	.data
	.globl	camlAck__data_begin
camlAck__data_begin:
	.text
	.globl	camlAck__code_begin
camlAck__code_begin:
	.data
	.quad	768
	.globl	camlAck
camlAck:
	.data
	.quad	4087
camlAck__1:
	.quad	caml_curry2
	.quad	5
	.quad	camlAck__ack_1008
	.text
	.align	16
	.globl	camlAck__ack_1008
camlAck__ack_1008:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_adjust_cfa_offset	8
.L102:
	cmpq	$1, %rax
	jg	.L101
	movq	%rbx, %rax
	addq	$2, %rax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset	-8
	ret
	.cfi_adjust_cfa_offset	8
	.align	4
.L101:
	cmpq	$1, %rbx
	jg	.L100
	movq	$3, %rbx
	addq	$-2, %rax
	jmp	.L102
	.align	4
.L100:
	movq	%rax, 0(%rsp)
	addq	$-2, %rbx
	call	camlAck__ack_1008@PLT
.L103:
	movq	%rax, %rbx
	movq	0(%rsp), %rax
	addq	$-2, %rax
	jmp	.L102
	.cfi_endproc
	.type	camlAck__ack_1008,@function
	.size	camlAck__ack_1008,.-camlAck__ack_1008
	.text
	.align	16
	.globl	camlAck__entry
camlAck__entry:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_adjust_cfa_offset	8
.L104:
	movq	$21, %rbx
	movq	$5, %rax
	call	camlAck__ack_1008@PLT
.L105:
	call	camlPervasives__string_of_int_1143@PLT
.L106:
	movq	%rax, %rbx
	movq	camlPervasives@GOTPCREL(%rip), %rax
	movq	184(%rax), %rax
	call	camlPervasives__output_string_1198@PLT
.L107:
	movq	$1, %rax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset	-8
	ret
	.cfi_adjust_cfa_offset	8
	.cfi_endproc
	.type	camlAck__entry,@function
	.size	camlAck__entry,.-camlAck__entry
	.data
	.text
	.globl	camlAck__code_end
camlAck__code_end:
	.data
	.globl	camlAck__data_end
camlAck__data_end:
	.long	0
	.globl	camlAck__frametable
camlAck__frametable:
	.quad	4
	.quad	.L107
	.word	17
	.word	0
	.align	8
	.long	(.L108 - .) + 0xe0000000
	.long	0x1a1120
	.quad	.L106
	.word	17
	.word	0
	.align	8
	.long	(.L108 - .) + 0xe0000000
	.long	0x1a1270
	.quad	.L105
	.word	16
	.word	0
	.align	8
	.quad	.L103
	.word	16
	.word	1
	.word	0
	.align	8
.L108:
	.asciz	"pervasives.ml"
	.align	8
	.section .note.GNU-stack,"",%progbits
