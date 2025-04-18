sys_write   equ 0x02000004
section .text
global  alpha

%include "src/macros.inc"
extern   escPrefix, escSuffix

alpha:
	lea    rdi, [rel alphabet]
	strlen rdi
	xor    rcx, rcx
	xor    dl, dl

.loop0:
	not    dl
	test   dl, dl
	jnz    .if
	prints 0x1b, "[0m ", 0
	jmp    .loop1

.if:
	prints 0x1b, "[33m ", 0
	jmp    .loop1

.loop1:
	lea    rsi, [rdi+rcx]
	printr rsi, 1
	inc    rcx
	cmp    rcx, rax
	jne    .loop0
	prints 10, 0
	exit   0

	section .data

alphabet:
	db "abcdefghijklmnopqrstuvwxyz", 0
