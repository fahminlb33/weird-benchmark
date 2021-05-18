	.file	"mat.c"
	.text
	.comm	_matrix_a, 4194304, 5
	.comm	_matrix_b, 4194304, 5
	.comm	_result_matrix, 4194304, 5
	.globl	_chunked_mm
	.def	_chunked_mm;	.scl	2;	.type	32;	.endef
_chunked_mm:
LFB13:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$1024, %eax
	cltd
	idivl	12(%ebp)
	movl	%eax, %edx
	movl	8(%ebp), %eax
	imull	%edx, %eax
	movl	%eax, -4(%ebp)
	jmp	L2
L7:
	movl	$0, -8(%ebp)
	jmp	L3
L6:
	movl	$0, -12(%ebp)
	jmp	L4
L5:
	movl	-4(%ebp), %eax
	sall	$10, %eax
	movl	%eax, %edx
	movl	-8(%ebp), %eax
	addl	%edx, %eax
	flds	_result_matrix(,%eax,4)
	movl	-4(%ebp), %eax
	sall	$10, %eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	flds	_matrix_a(,%eax,4)
	movl	-12(%ebp), %eax
	sall	$10, %eax
	movl	%eax, %edx
	movl	-8(%ebp), %eax
	addl	%edx, %eax
	flds	_matrix_b(,%eax,4)
	fmulp	%st, %st(1)
	faddp	%st, %st(1)
	movl	-4(%ebp), %eax
	sall	$10, %eax
	movl	%eax, %edx
	movl	-8(%ebp), %eax
	addl	%edx, %eax
	fstps	_result_matrix(,%eax,4)
	addl	$1, -12(%ebp)
L4:
	cmpl	$1023, -12(%ebp)
	jle	L5
	addl	$1, -8(%ebp)
L3:
	cmpl	$1023, -8(%ebp)
	jle	L6
	addl	$1, -4(%ebp)
L2:
	movl	8(%ebp), %eax
	leal	1(%eax), %ecx
	movl	$1024, %eax
	cltd
	idivl	12(%ebp)
	imull	%ecx, %eax
	cmpl	%eax, -4(%ebp)
	jl	L7
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE13:
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC4:
	.ascii "%f \0"
	.text
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
	andl	$-16, %esp
	subl	$48, %esp
	call	___main
	movl	$0, 44(%esp)
	jmp	L9
L12:
	movl	$0, 40(%esp)
	jmp	L10
L11:
	movl	44(%esp), %eax
	sall	$10, %eax
	movl	%eax, %edx
	movl	40(%esp), %eax
	addl	%edx, %eax
	flds	LC1
	fstps	_matrix_a(,%eax,4)
	movl	44(%esp), %eax
	sall	$10, %eax
	movl	%eax, %edx
	movl	40(%esp), %eax
	addl	%edx, %eax
	flds	LC2
	fstps	_matrix_b(,%eax,4)
	movl	44(%esp), %eax
	sall	$10, %eax
	movl	%eax, %edx
	movl	40(%esp), %eax
	addl	%edx, %eax
	fldz
	fstps	_result_matrix(,%eax,4)
	addl	$1, 40(%esp)
L10:
	cmpl	$1023, 40(%esp)
	jle	L11
	addl	$1, 44(%esp)
L9:
	cmpl	$1023, 44(%esp)
	jle	L12
	movl	$0, 36(%esp)
	jmp	L13
L14:
	movl	$4, 4(%esp)
	movl	36(%esp), %eax
	movl	%eax, (%esp)
	call	_chunked_mm
	addl	$1, 36(%esp)
L13:
	cmpl	$3, 36(%esp)
	jle	L14
	movl	$0, 32(%esp)
	jmp	L15
L18:
	movl	$0, 28(%esp)
	jmp	L16
L17:
	movl	32(%esp), %eax
	sall	$10, %eax
	movl	%eax, %edx
	movl	28(%esp), %eax
	addl	%edx, %eax
	flds	_result_matrix(,%eax,4)
	fstpl	4(%esp)
	movl	$LC4, (%esp)
	call	_printf
	addl	$1, 28(%esp)
L16:
	cmpl	$1023, 28(%esp)
	jle	L17
	movl	$10, (%esp)
	call	_putchar
	addl	$1, 32(%esp)
L15:
	cmpl	$1023, 32(%esp)
	jle	L18
	movl	$0, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE14:
	.section .rdata,"dr"
	.align 4
LC1:
	.long	1036831949
	.align 4
LC2:
	.long	1045220557
	.ident	"GCC: (i686-posix-dwarf-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_putchar;	.scl	2;	.type	32;	.endef
