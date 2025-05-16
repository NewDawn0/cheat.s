	;        Exec section & imports & exports
	section  .text
	default  rel
	extern   cNoCol, cYellow
	global   months
	%include "src/macros.inc"

	; months program : void months()
	; Clobbers:
	; -  dl

months:
	;    Save state
	push rdi
	push rsi
	push rbx
	push rcx
	push rdx
	;    Print
	lea  rdi, [monthsStr]
	lea  rbx, [buf]
	xor  rcx, rcx

.upper0:
	mov    rdx, 0
	printb " - [", 0
	printv cYellow

.upper1:
	mov al, byte [rdi+rdx]
	cmp al, 0
	je  .upper2
	cmp al, 'a'
	jb  .upper2
	cmp al, 'z'
	ja  .upper2
	sub al, 0x20

.upper2:
	mov    byte [rbx], al
	printr rbx, 1
	inc    rdx
	cmp    rdx, 3
	jb     .upper1

.loop:
	printv cNoCol
	printb "] ", 0
	strlen rdi
	printr rdi, rax
	;      Inc
	add    rdi, rax
	inc    rdi
	inc    rcx
	cmp    rcx, 12
	jne    .upper0
	;      Restore state
	pop    rdx
	pop    rcx
	pop    rbx
	pop    rsi
	pop    rdi
	ret

section .bss

buf:
	resb 1

	section .data

monthsStr:
	db "January", 10, 0
	db "February", 10, 0
	db "March", 10, 0
	db "April", 10, 0
	db "May", 10, 0
	db "June", 10, 0
	db "July", 10, 0
	db "August", 10, 0
	db "September", 10, 0
	db "October", 10, 0
	db "November", 10, 0
	db "December", 10, 0
