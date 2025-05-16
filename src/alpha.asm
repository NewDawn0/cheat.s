	;        Exec section & imports & exports
	section  .text
	default  rel
	extern   cYellow, cNoCol
	global   alpha
	%include "src/macros.inc"

	; Alpha program : void alpha()
	; Clobbers:
	; -  dl

alpha:
	;      Restore state
	push   rdi
	push   rsi
	push   rcx
	;      Write
	lea    rdi, [alphabet]
	strlen rdi
	xor    rcx, rcx
	xor    dl, dl

.loop:
	;      Check if bold
	printb " ", 0
	not    dl
	test   dl, dl
	jnz    .if
	;      Bold space
	printv cYellow
	jmp    .endif

.if:
	;      Not bold space
	printv cNoCol

.endif:
	;      Print char
	lea    rsi, [rdi+rcx]
	printr rsi, 1
	;      Check + loop
	inc    rcx
	cmp    rax, rcx
	jg     .loop
	;      Reset term + newline
	printv cNoCol
	printb 10, 0
	;      Save state
	pop    rcx
	pop    rsi
	pop    rdi
	ret

	;       Static vars section
	section .data

alphabet:
	db "abcdefghijklmnopqrstuvwxyz", 0
