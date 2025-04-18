	;        Exec section & imports & exports
	section  .text
	global   alpha
	%include "src/macros.inc"

	; Alpha program
	; Clobbers:
	; -  dl

alpha:
	;      Restore state
	push   rdi
	push   rsi
	push   rcx
	;      Write
	lea    rdi, [rel alphabet]
	strlen rdi
	xor    rcx, rcx
	xor    dl, dl

.loop:
	;      Check if bold
	not    dl
	test   dl, dl
	jnz    .if
	;      Bold space
	printb 0x1b, "[33m ", 0
	jmp    .endif

.if:
	;      Not bold space
	printb 0x1b, "[0m ", 0

.endif:
	;      Print char
	lea    rsi, [rdi+rcx]
	printr rsi, 1
	;      Check + loop
	inc    rcx
	cmp    rax, rcx
	jg     .loop
	;      Reset term + newline
	printb 0x1b, "[0m", 10, 0
	;      Save state
	pop    rcx
	pop    rsi
	pop    rdi
	ret

	;       Static vars section
	section .data

alphabet:
	db "abcdefghijklmnopqrstuvwxyz", 0
