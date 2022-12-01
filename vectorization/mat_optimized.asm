	.file	"mat.c"
	.text
	.p2align 4
	.globl	chunked_mm
	.type	chunked_mm, @function
chunked_mm:
.LFB23:
	.cfi_startproc
	endbr64
	movl	$1024, %eax
	cltd
	idivl	%esi
	imull	%eax, %edi
	addl	%edi, %eax
	movl	%edi, %edx
	cmpl	%eax, %edi
	jge	.L9
	movslq	%edi, %rcx
	leaq	matrix_a(%rip), %rsi
	subl	$1, %eax
	movq	%rcx, %r8
	leaq	result_matrix(%rip), %rdi
	leaq	4194304+matrix_b(%rip), %r11
	salq	$12, %r8
	addq	%r8, %rdi
	addq	%rsi, %r8
	movl	%eax, %esi
	subl	%edx, %esi
	leaq	4096+matrix_a(%rip), %rax
	addq	%rcx, %rsi
	salq	$12, %rsi
	addq	%rax, %rsi
.L3:
	leaq	matrix_b(%rip), %r10
	movq	%r11, %rcx
	xorl	%r9d, %r9d
.L6:
	vmovups	(%rdi,%r9), %xmm4
	movq	%r8, %rdx
	movq	%r10, %rax
	vinsertf128	$0x1, 16(%rdi,%r9), %ymm4, %ymm1
	.p2align 4,,10
	.p2align 3
.L4:
	vmovups	(%rax), %xmm3
	vbroadcastss	(%rdx), %ymm2
	addq	$4096, %rax
	addq	$4, %rdx
	vinsertf128	$0x1, -4080(%rax), %ymm3, %ymm0
	vmulps	%ymm2, %ymm0, %ymm0
	vaddps	%ymm0, %ymm1, %ymm1
	cmpq	%rcx, %rax
	jne	.L4
	vmovups	%xmm1, (%rdi,%r9)
	vextractf128	$0x1, %ymm1, 16(%rdi,%r9)
	addq	$32, %r9
	addq	$32, %r10
	leaq	32(%rax), %rcx
	cmpq	$4096, %r9
	jne	.L6
	addq	$4096, %r8
	addq	$4096, %rdi
	cmpq	%rsi, %r8
	jne	.L3
	vzeroupper
.L9:
	ret
	.cfi_endproc
.LFE23:
	.size	chunked_mm, .-chunked_mm
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"%f "
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	endbr64
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x60,0x6
	.cfi_escape 0x10,0xe,0x2,0x76,0x78
	.cfi_escape 0x10,0xd,0x2,0x76,0x70
	.cfi_escape 0x10,0xc,0x2,0x76,0x68
	pushq	%rbx
	.cfi_escape 0x10,0x3,0x2,0x76,0x58
	leaq	matrix_a(%rip), %rbx
	leaq	4096(%rbx), %rdx
	movq	%rbx, %rcx
	leaq	4194304(%rdx), %rsi
	subq	$8, %rsp
	vmovaps	.LC0(%rip), %ymm0
.L13:
	movq	%rcx, %rax
	.p2align 4,,10
	.p2align 3
.L12:
	vmovups	%xmm0, (%rax)
	vextractf128	$0x1, %ymm0, 16(%rax)
	addq	$32, %rax
	cmpq	%rdx, %rax
	jne	.L12
	leaq	4096(%rax), %rdx
	addq	$4096, %rcx
	cmpq	%rsi, %rdx
	jne	.L13
	leaq	matrix_b(%rip), %r12
	vmovaps	.LC1(%rip), %ymm0
	leaq	4096(%r12), %rdx
	movq	%r12, %rcx
	leaq	4194304(%rdx), %rsi
.L17:
	movq	%rcx, %rax
	.p2align 4,,10
	.p2align 3
.L16:
	vmovups	%xmm0, (%rax)
	vextractf128	$0x1, %ymm0, 16(%rax)
	addq	$32, %rax
	cmpq	%rdx, %rax
	jne	.L16
	leaq	4096(%rax), %rdx
	addq	$4096, %rcx
	cmpq	%rsi, %rdx
	jne	.L17
	movl	$4194304, %edx
	xorl	%esi, %esi
	leaq	result_matrix(%rip), %rdi
	vzeroupper
	call	memset@PLT
	leaq	result_matrix(%rip), %r14
	movl	$256, %r11d
	leaq	4194304(%r12), %r13
.L25:
	leal	-256(%r11), %r10d
	movq	%rbx, %r9
	movq	%r14, %rdi
.L20:
	movq	%r13, %rcx
	movq	%r12, %r8
	xorl	%esi, %esi
	.p2align 4,,10
	.p2align 3
.L24:
	vmovups	(%rdi,%rsi), %xmm5
	vinsertf128	$0x1, 16(%rdi,%rsi), %ymm5, %ymm1
	movq	%r9, %rdx
	movq	%r8, %rax
	.p2align 4,,10
	.p2align 3
.L21:
	vmovups	(%rax), %xmm3
	vbroadcastss	(%rdx), %ymm2
	addq	$4096, %rax
	addq	$4, %rdx
	vinsertf128	$0x1, -4080(%rax), %ymm3, %ymm0
	vmulps	%ymm2, %ymm0, %ymm0
	vaddps	%ymm0, %ymm1, %ymm1
	cmpq	%rcx, %rax
	jne	.L21
	vmovups	%xmm1, (%rdi,%rsi)
	vextractf128	$0x1, %ymm1, 16(%rdi,%rsi)
	addq	$32, %rsi
	addq	$32, %r8
	leaq	32(%rax), %rcx
	cmpq	$4096, %rsi
	jne	.L24
	addl	$1, %r10d
	addq	$4096, %rdi
	addq	$4096, %r9
	cmpl	%r11d, %r10d
	jl	.L20
	addl	$256, %r11d
	addq	$1048576, %r14
	addq	$1048576, %rbx
	cmpl	$1280, %r11d
	jne	.L25
	leaq	4096+result_matrix(%rip), %r12
	leaq	.LC2(%rip), %r13
	leaq	4194304(%r12), %r14
	vzeroupper
	.p2align 4,,10
	.p2align 3
.L26:
	leaq	-4096(%r12), %rbx
	.p2align 4,,10
	.p2align 3
.L27:
	vxorpd	%xmm4, %xmm4, %xmm4
	movq	%r13, %rsi
	movl	$1, %edi
	addq	$4, %rbx
	movl	$1, %eax
	vcvtss2sd	-4(%rbx), %xmm4, %xmm0
	call	__printf_chk@PLT
	cmpq	%rbx, %r12
	jne	.L27
	movl	$10, %edi
	addq	$4096, %r12
	call	putchar@PLT
	cmpq	%r14, %r12
	jne	.L26
	addq	$8, %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%r10
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.comm	result_matrix,4194304,32
	.comm	matrix_b,4194304,32
	.comm	matrix_a,4194304,32
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC0:
	.long	1036831949
	.long	1036831949
	.long	1036831949
	.long	1036831949
	.long	1036831949
	.long	1036831949
	.long	1036831949
	.long	1036831949
	.align 32
.LC1:
	.long	1045220557
	.long	1045220557
	.long	1045220557
	.long	1045220557
	.long	1045220557
	.long	1045220557
	.long	1045220557
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
