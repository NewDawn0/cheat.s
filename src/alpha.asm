	;        Exec section & imports & exports
	section  .text
	global   alpha
	%include "src/macros.inc"

	; Alpha program
	; Clobbers:
	; -> dl, rcx, rdi, rsi

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

	;       Static vars section
	section .data

alphabet:
	db "abcdefghijklmnopqrstuvwxyz", 0
