section .data

msg:
	;  Alphabet with newline
	db 'a b c d e f g h i j k l m n o p q r s t u v w x y z', 10

.len:	equ $ - msg

	section .text
	global  _main

_main:
	call print
	call exit

print:
	;   Sys write
	mov rax, 0x02000004
	;   To stdout
	mov rdi, 1
	;   Addr of alphabet
	mov rsi, msg
	;   Len of alphabet
	mov rdx, msg.len
	syscall
	ret

exit:
	;   Sys exit
	mov rax, 0x02000001
	;   Exit 0
	xor rdi, rdi
	syscall
