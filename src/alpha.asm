sys_write   equ 0x02000004
section .text
global  alpha

%include "src/codes.inc"
%include "src/macros.inc"

alpha:
	lea    rdi, [rel test]
	strlen rdi
	xor    rcx, rcx

.loop:
	print rdi
	inc   rcx
	cmp   rcx, rax
	jne   .loop
	print rdi
	exit  0

	section .data

test:
	db "HI", 10, 0

alphaStr:
	db "abcdefghijklmnopqrstuvwxyz", 10, 0
