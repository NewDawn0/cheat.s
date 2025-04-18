	; Syscalls (macOS)
	; @TODO: Look up codes
	sys_execve  equ 0x02000059 ; Linux ->  4
	sys_exit    equ 0x02000001 ; Linux -> 60
	sys_write   equ 0x02000004 ; Linux ->  1

	; Exit the program : <code>
	; Args:
	; -  %1 -> code

	%macro exit 1
	mov    rdi, dword %1
	mov    rax, dword sys_exit
	syscall
	%endmacro

	; Prints a string range : <str ptr>, <len>
	; Args:
	; -  %1 -> str ptr
	; -  %2 -> len

	%macro printr 2
	;      Save state
	push   rax
	push   rdi
	push   rsi
	push   rdx
	push   rbx
	push   rcx
	;      Write
	mov    rbx, qword %1
	mov    rcx, %2
	mov    rax, dword sys_write; Write
	mov    rsi, qword rbx; Str ptr
	mov    rdi, 1; Stdout
	mov    rdx, qword rcx; Len
	syscall
	;      Restore state
	pop    rcx
	pop    rbx
	pop    rdx
	pop    rsi
	pop    rdi
	pop    rax
	%endmacro

	; Print inline bytes : <bytes> ...
	; Args:
	; -  %1 -> bytes ...

	%macro printb 1+
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

	; Get length of str : <str ptr>
	; Clobbers:
	; -  al
	; Args:
	; -  %1 -> str ptr
	; Output:
	; -  rax -> len

	%macro strlen 1
	;      Save state
	push   rdi
	push   rcx
	;      Search for null
	mov    rdi, qword %1
	mov    rcx, dword -1
	xor    al, al
	repne  scasb; Search
	not    rcx
	dec    rcx
	mov    rax, qword rcx
	;      Restore state
	pop    rcx
	pop    rdi
	%endmacro
