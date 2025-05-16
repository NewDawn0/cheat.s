	;        Exec section & imports & exports
	section  .text
	default  rel
	extern   cNoCol, cYellow, cPrefix, cSuffix, cBlue, cCyan
	global   months
	%include "src/macros.inc"

	; months program : void months()
	; Clobbers:
	; -  dl

months:
	;    Save state
	push rdi
	push rsi
	push rcx
	push rdx
	;    Print month
	lea  rdi, [monthsStr]
	lea  rsi, [buf]
	xor  rcx, rcx

.loopStart:
	test   rcx, 1
	jnz    .col
	printv cBlue
	jmp    .days

.col:
	printv cCyan

.days:
	;      Print days
	printb " ", 0
	printr rdi, 2
	add    rdi, 3
	printb "d  ", 0

.abbrev:
	xor rdx, rdx

.abbrevLoop:
	mov al, byte [rdi]
	cmp al, 'a'
	jb  .abbrevPrint
	cmp al, 'z'
	ja  .abbrevPrint
	sub al, 0x20

.abbrevPrint:
	;      Print
	mov    byte [rsi], al
	printr rsi, 1
	;      End loop
	inc    rdi
	inc    rdx
	cmp    rdx, 3
	jb     .abbrevLoop
	sub    rdi, 3
	printb "  ", 0

.months:
	strlen rdi
	printr rdi, rax
	printv cNoCol

.loopEnd:
	strlen rdi
	add    rdi, rax
	inc    rdi
	inc    rcx
	cmp    rcx, 12
	jb     .loopStart
	;      Restore state
	pop    rdx
	pop    rcx
	pop    rsi
	pop    rdi
	ret

section .bss

buf:
	resb 1

	section .data

monthsStr:
	db "31 January", 10, 0
	db "28 February", 10, 0
	db "31 March", 10, 0
	db "30 April", 10, 0
	db "30 May", 10, 0
	db "30 June", 10, 0
	db "30 July", 10, 0
	db "30 August", 10, 0
	db "30 September", 10, 0
	db "31 October", 10, 0
	db "30 November", 10, 0
	db "31 December", 10, 0
