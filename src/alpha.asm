section .data

msg:
	db 'a b c d e f g h i j k l m n o p q r s t u v w x y z', 10; Alphabet with newline
	;  asmfmt off

.len:	equ $ - msg
	;   asmfmt on

	section .text
	global  _main

_main:
	call print
	call exit

print:
	mov rax, 0x02000004; Sys write
	mov rdi, 1; To stdout
	mov rsi, msg; Addr of alphabet
	mov rdx, msg.len; Len of alphabet
	syscall
	ret

exit:
	mov rax, 0x02000001; Sys exit
	xor rdi, rdi; Exit 0
	syscall
