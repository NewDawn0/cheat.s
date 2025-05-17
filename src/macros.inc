	; Syscalls (macOS)
	sys_exit    equ 0x02000001 ; Linux -> 60
	sys_write   equ 0x02000004 ; Linux -> 1

	; x86-64 Calling conv
	; Input: rdi, rsi, rdx, rcx, r8, r9
	; Output: rax

	; Exit the program : inline void exit(const int)
	; Args:
	; - %1 -> const int code

	%macro exit 1
	mov    rdi, dword %1
	mov    rax, dword sys_exit
	syscall
	%endmacro

	; Print inline bytes : inline void printb(const char* ...)
	; Args:
	; - %1 -> const char* bytes ...

	%macro printb 1+
	jmp    %%done

%%str:
	db %1

%%done:
	push   rax
	push   rdi
	lea    rdi, [%%str]
	strlen rdi
	printr rdi, rax
	pop    rdi
	pop    rax
	%endmacro

	; Prints an inline error message : inline void printErr(const char* ...)
	; Args:
	; - %1 -> const char* bytes ...

	%macro printErr 1+
	printv cRed
	printb "ERROR: ", 0
	printv cNoCol
	printb %1, 10, 0
	%endmacro

	; Prints a string range : inline void printr(const char**, const int)
	; Args:
	; - %1 -> const char** string
	; - %2 -> const int len

	%macro printr 2
	;      Save state
	push   rax
	push   rdi
	push   rsi
	push   rcx
	push   rdx
	push   r10
	push   r11
	;      Write
	mov    r10, qword %1
	mov    r11, qword %2
	mov    rax, dword sys_write; Write
	mov    rdi, dword 1; Stdout
	mov    rsi, qword r10
	mov    rdx, qword r11
	syscall
	;      Restore state
	pop    r11
	pop    r10
	pop    rdx
	pop    rcx
	pop    rsi
	pop    rdi
	pop    rax
	%endmacro

	; Print inline variables : inline void printv(const char* ...)
	; Args:
	; - %1 -> const bool isReg (whether input is  registers or variables)
	; - %2 -> const char** input ...

	%macro  printv 1-*
	push    rax
	push    rdi
	%rep    %0
	lea     rdi, [%1]
	strlen  %1
	printr  rdi, rax
	%rotate 1
	%endrep
	pop     rdi
	pop     rax
	%endmacro

	; Compare 2 strings : inline int strcmp(const char**, const char**)
	; Args:
	; - %1 -> const char** string1
	; - %2 -> const char** string2
	; Output:
	; - eax -> bool equal

	%macro strcmp 2
	push   rdi
	push   rsi
	push   rcx
	mov    rdi, qword %1
	mov    rsi, qword %2
	;      Compare lengths
	strlen rdi
	mov    rcx, rax
	strlen rsi
	cmp    rcx, rax
	jne    %%neql
	;      Compare chars
	cld
	repe   cmpsb
	jne    %%neql
	xor    eax, eax
	jmp    %%done

%%neql:
	mov eax, 1

%%done:
	;   Restore state
	pop rcx
	pop rsi
	pop rdi
	%endmacro

	; Get length of str : inline int strlen(const char**)
	; Clobbers:
	; - al
	; Args:
	; - %1 -> const char** string
	; Output:
	; - rax -> int len

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

	; Get tail part of a string : inline  char* tail(const char**, const int, const char*)
	; Args:
	; - %1 -> const char** string (ptr to string)
	; - %2 -> const int len (length of string)
	; - %3 -> const char* delim
	; Output:
	; - rax -> int offset (from start to delim)
	; Clobbers:
	; - al

	%macro tail 3
	;      Save state
	push   rdi
	push   rsi
	push   rcx
	;      Search for delim
	cld
	std
	lea    rdi, [%1+%2-1]
	mov    rsi, dword %2
	mov    al, byte %3
	repne  scasb
	jz     %%found
	mov    rax, -1
	jmp    %%done

%%found:
	mov rax, 3
	jmp %%done

	; Restore state

%%done:
	pop rcx
	pop rsi
	pop rdi
	%endmacro

	; Stringify number (0-99) : inline char* toStr(const char**, const int)
	; Clobbers:
	; - al, dl
	; Args:
	; - %1 -> const char** buf (at least 3 bytes)
	; - %2 -> const int number

	%macro toStr 2
	;      Save state
	push   rax
	push   rdi
	push   rcx
	push   rdx
	;      Divide number by 10
	mov    rdi, %1
	mov    rax, %2
	xor    rdx, rdx
	mov    rcx, 10
	div    rcx
	;      Convert to ASCII
	add    al, '0'
	add    dl, '0'
	mov    [%1], al
	mov    [%1+1], dl
	mov    byte [%1+2], 0
	;      Return ptr to str in rax
	mov    rax, rdi
	;      Restore state
	pop    rdx
	pop    rcx
	pop    rdi
	pop    rax
	%endmacro
