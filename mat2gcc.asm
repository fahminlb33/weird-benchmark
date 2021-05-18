	.file	"mat.c"
	.text
	.p2align 4,,15
	.globl	_chunked_mm
	.def	_chunked_mm;	.scl	2;	.type	32;	.endef
_chunked_mm:
LFB13:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	$1024, %eax
	cltd
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	idivl	12(%ebp)
	movl	8(%ebp), %edx
	pushl	%esi
	pushl	%ebx
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	imull	%eax, %edx
	addl	%edx, %eax
	cmpl	%edx, %eax
	jle	L9
	sall	$12, %edx
	sall	$12, %eax
	movl	%edx, %esi
	leal	_matrix_a(%edx), %ebx
	leal	_matrix_a(%eax), %edi
	subl	$_matrix_b, %esi
	addl	$_result_matrix, %esi
L3:
	movl	$_matrix_b+4194304, %ecx
L6:
	vmovups	-4194304(%esi,%ecx), %xmm4
	leal	-4194304(%ecx), %eax
	movl	%ebx, %edx
	vinsertf128	$0x1, -4194288(%esi,%ecx), %ymm4, %ymm1
	.p2align 4,,10
L4:
	vmovups	(%eax), %xmm3
	vbroadcastss	(%edx), %ymm2
	addl	$4096, %eax
	addl	$4, %edx
	vinsertf128	$0x1, -4080(%eax), %ymm3, %ymm0
	vmulps	%ymm2, %ymm0, %ymm0
	vaddps	%ymm0, %ymm1, %ymm1
	cmpl	%eax, %ecx
	jne	L4
	vmovups	%xmm1, -4194304(%esi,%ecx)
	vextractf128	$0x1, %ymm1, -4194288(%esi,%ecx)
	addl	$32, %ecx
	cmpl	$_matrix_b+4198400, %ecx
	jne	L6
	addl	$4096, %ebx
	addl	$4096, %esi
	cmpl	%edi, %ebx
	jne	L3
	vzeroupper
L9:
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE13:
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC2:
	.ascii "%f \0"
	.section	.text.startup,"x"
	.p2align 4,,15
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB14:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	andl	$-32, %esp
	subl	$48, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	___main
	movl	$_matrix_a, 36(%esp)
	movl	$_matrix_a+4096, %edx
	vmovaps	LC0, %ymm0
L14:
	leal	-4096(%edx), %eax
	.p2align 4,,10
L13:
	vmovups	%xmm0, (%eax)
	vextractf128	$0x1, %ymm0, 16(%eax)
	addl	$32, %eax
	cmpl	%edx, %eax
	jne	L13
	leal	4096(%eax), %edx
	cmpl	$_matrix_a+4198400, %edx
	jne	L14
	vmovaps	LC1, %ymm0
	movl	$_matrix_b+4096, %edx
L18:
	leal	-4096(%edx), %eax
	.p2align 4,,10
L17:
	vmovups	%xmm0, (%eax)
	vextractf128	$0x1, %ymm0, 16(%eax)
	addl	$32, %eax
	cmpl	%edx, %eax
	jne	L17
	leal	4096(%eax), %edx
	cmpl	$_matrix_b+4198400, %edx
	jne	L18
	movl	$4194304, 8(%esp)
	movl	$0, 4(%esp)
	movl	$_result_matrix, (%esp)
	vzeroupper
	call	_memset
	movl	$_result_matrix, %eax
	movl	$256, 44(%esp)
	subl	$_matrix_b, %eax
	movl	%eax, 40(%esp)
L26:
	movl	44(%esp), %eax
	movl	36(%esp), %esi
	movl	40(%esp), %ebx
	leal	-256(%eax), %edi
L21:
	movl	$_matrix_b+4194304, %ecx
	.p2align 4,,10
L25:
	vmovups	-4194304(%ebx,%ecx), %xmm4
	leal	-4194304(%ecx), %eax
	movl	%esi, %edx
	vinsertf128	$0x1, -4194288(%ebx,%ecx), %ymm4, %ymm1
	.p2align 4,,10
L22:
	vmovups	(%eax), %xmm3
	vbroadcastss	(%edx), %ymm2
	addl	$4096, %eax
	addl	$4, %edx
	vinsertf128	$0x1, -4080(%eax), %ymm3, %ymm0
	vmulps	%ymm2, %ymm0, %ymm0
	vaddps	%ymm0, %ymm1, %ymm1
	cmpl	%ecx, %eax
	jne	L22
	vmovups	%xmm1, -4194304(%ebx,%eax)
	leal	32(%eax), %ecx
	vextractf128	$0x1, %ymm1, -4194288(%ebx,%eax)
	cmpl	$_matrix_b+4198400, %ecx
	jne	L25
	addl	$1, %edi
	addl	$4096, %ebx
	addl	$4096, %esi
	cmpl	44(%esp), %edi
	jl	L21
	addl	$256, 44(%esp)
	movl	44(%esp), %eax
	addl	$1048576, 40(%esp)
	addl	$1048576, 36(%esp)
	cmpl	$1280, %eax
	jne	L26
	movl	$_result_matrix+4096, %esi
	movl	$_result_matrix+4198400, %edi
	vzeroupper
	.p2align 4,,10
L27:
	leal	-4096(%esi), %ebx
	.p2align 4,,10
L28:
	flds	(%ebx)
	movl	$LC2, (%esp)
	addl	$4, %ebx
	fstpl	4(%esp)
	call	_printf
	cmpl	%ebx, %esi
	jne	L28
	movl	$10, (%esp)
	addl	$4096, %esi
	call	_putchar
	cmpl	%esi, %edi
	jne	L27
	leal	-12(%ebp), %esp
	xorl	%eax, %eax
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE14:
	.comm	_result_matrix, 4194304, 5
	.comm	_matrix_b, 4194304, 5
	.comm	_matrix_a, 4194304, 5
	.section .rdata,"dr"
	.align 32
LC0:
	.long	1036831949
	.long	1036831949
	.long	1036831949
	.long	1036831949
	.long	1036831949
	.long	1036831949
	.long	1036831949
	.long	1036831949
	.align 32
LC1:
	.long	1045220557
	.long	1045220557
	.long	1045220557
	.long	1045220557
	.long	1045220557
	.long	1045220557
	.long	1045220557
	.long	1045220557
	.ident	"GCC: (i686-posix-dwarf-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	_memset;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_putchar;	.scl	2;	.type	32;	.endef
