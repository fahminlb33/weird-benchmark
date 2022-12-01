	.file	"mat.c"
	.text
	.comm	matrix_a,4194304,32
	.comm	matrix_b,4194304,32
	.comm	result_matrix,4194304,32
	.globl	chunked_mm
	.type	chunked_mm, @function
chunked_mm:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	$1024, %eax
	cltd
	idivl	-24(%rbp)
	movl	%eax, %edx
	movl	-20(%rbp), %eax
	imull	%edx, %eax
	movl	%eax, -12(%rbp)
	jmp	.L2
.L7:
	movl	$0, -8(%rbp)
	jmp	.L3
.L6:
	movl	$0, -4(%rbp)
	jmp	.L4
.L5:
	movl	-8(%rbp), %eax
	cltq
	movl	-12(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	result_matrix(%rip), %rax
	movss	(%rdx,%rax), %xmm1
	movl	-4(%rbp), %eax
	cltq
	movl	-12(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	matrix_a(%rip), %rax
	movss	(%rdx,%rax), %xmm2
	movl	-8(%rbp), %eax
	cltq
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	matrix_b(%rip), %rax
	movss	(%rdx,%rax), %xmm0
	mulss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movl	-8(%rbp), %eax
	cltq
	movl	-12(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	result_matrix(%rip), %rax
	movss	%xmm0, (%rdx,%rax)
	addl	$1, -4(%rbp)
.L4:
	cmpl	$1023, -4(%rbp)
	jle	.L5
	addl	$1, -8(%rbp)
.L3:
	cmpl	$1023, -8(%rbp)
	jle	.L6
	addl	$1, -12(%rbp)
.L2:
	movl	-20(%rbp), %eax
	leal	1(%rax), %ecx
	movl	$1024, %eax
	cltd
	idivl	-24(%rbp)
	imull	%ecx, %eax
	cmpl	%eax, -12(%rbp)
	jl	.L7
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	chunked_mm, .-chunked_mm
	.section	.rodata
.LC3:
	.string	"%f "
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movq	%rsi, -48(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L9
.L12:
	movl	$0, -16(%rbp)
	jmp	.L10
.L11:
	movl	-16(%rbp), %eax
	cltq
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	matrix_a(%rip), %rax
	movss	.LC0(%rip), %xmm0
	movss	%xmm0, (%rdx,%rax)
	movl	-16(%rbp), %eax
	cltq
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	matrix_b(%rip), %rax
	movss	.LC1(%rip), %xmm0
	movss	%xmm0, (%rdx,%rax)
	movl	-16(%rbp), %eax
	cltq
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	result_matrix(%rip), %rax
	pxor	%xmm0, %xmm0
	movss	%xmm0, (%rdx,%rax)
	addl	$1, -16(%rbp)
.L10:
	cmpl	$1023, -16(%rbp)
	jle	.L11
	addl	$1, -20(%rbp)
.L9:
	cmpl	$1023, -20(%rbp)
	jle	.L12
	movl	$0, -12(%rbp)
	jmp	.L13
.L14:
	movl	-12(%rbp), %eax
	movl	$4, %esi
	movl	%eax, %edi
	call	chunked_mm
	addl	$1, -12(%rbp)
.L13:
	cmpl	$3, -12(%rbp)
	jle	.L14
	movl	$0, -8(%rbp)
	jmp	.L15
.L18:
	movl	$0, -4(%rbp)
	jmp	.L16
.L17:
	movl	-4(%rbp), %eax
	cltq
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	result_matrix(%rip), %rax
	movss	(%rdx,%rax), %xmm0
	cvtss2sd	%xmm0, %xmm0
	leaq	.LC3(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	addl	$1, -4(%rbp)
.L16:
	cmpl	$1023, -4(%rbp)
	jle	.L17
	movl	$10, %edi
	call	putchar@PLT
	addl	$1, -8(%rbp)
.L15:
	cmpl	$1023, -8(%rbp)
	jle	.L18
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC0:
	.long	1036831949
	.align 4
.LC1:
	.long	1045220557
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
