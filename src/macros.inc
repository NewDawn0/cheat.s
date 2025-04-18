	; Syscalls (macOS)
	sys_execve  equ 0x02000059 ; Linux ->  4
	sys_exit    equ 0x02000001 ; Linux -> 60
	sys_write   equ 0x02000004 ; Linux ->  1

	;      Exit the program : <code>
	;      Args:
	;      -> %1 -> code
	%macro exit 1
	mov    rdi, %1
	mov    rax, sys_exit
	syscall
	%endmacro

	;      Prints a string : <str ptr>
	;      Args:
	;      => %1 -> str
	%macro print 1
	;      Save state
	push   rdi
	push   rax
	;      Get strlen
	strlen %1
	printr %1, rax
	;      Restore state
	pop    rax
	pop    rdi
	%endmacro

	;      Prints a string range : <str ptr>, <len>
	;      Args:
	;      => %1 -> str ptr
	;      => %2 -> len
	%macro printr 2
	;      Save state
	push   rax
	push   rdi
	push   rsi
	push   rcx
	push   rdx
	push   r8
	push   r9
	;      Save args
	mov    r8, %1
	mov    r9, %2
	;      Call write
	mov    rax, sys_write; Write
	mov    rsi, r8; Str ptr
	mov    rdi, 1; Stdout
	mov    rdx, r9; Len
	syscall
	;      Restore state
	pop    r9
	pop    r8
	pop    rdx
	pop    rcx
	pop    rsi
	pop    rdi
	pop    rax
	%endmacro

	;      Print inline string : <bytes> ...
	;      Args:
	;      => %1 -> string bytes ...
	%macro prints 1+
	jmp    %%done

%%str:
	db %1

%%done:
	push   rax
	push   rdi
	lea    rdi, [rel %%str]
	strlen rdi
	printr rdi, rax
	pop    rdi
	pop    rax
	%endmacro

	;      Get lenght of str : <str ptr>
	;      Clobbers:
	;      => al
	;      Args:
	;      => %1 -> str ptr
	;      Output:
	;      => rax -> len
	%macro strlen 1
	;      Save state
	push   rdi
	push   rcx
	;      Search for null
	mov    rdi, %1
	mov    rcx, -1
	xor    al, al
	repne  scasb; Search
	not    rcx
	dec    rcx
	mov    rax, rcx
	;      Restore state
	pop    rcx
	pop    rdi
	%endmacro
