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
	jz     .col
	;      Bold space
	printv cNoCol
	jmp    .endCOL

	; Not bold space

.col:
	printv cYellow
	push   rax
	pop    rax

.endCOL:
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
