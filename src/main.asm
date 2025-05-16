	;       Executable & imports & exports
	section .text
	default rel
	extern  alpha, ansi, months; Programs
	extern  cNoCol, cRed, cYellow; Colours
	global  _main

	%include "src/macros.inc"

	; Main entrypoint

	; int main(int argc, const char **argv)
	; Args:
	; - edi -> int argc
	; - rsi -> const char **argv
	; Output:
	; - eax -> int

_main:
	push rbp
	mov  rbp, rsp
	cmp  edi, 2
	ja   .moreArgs
	jb   .noArgs
	mov  rdi, [rsi+8]
	call check
	jmp  .done

.noArgs:
	printErr "No arguments"
	printb   "  ->   Showing help instead", 10, 10, 0
	call     help
	exit     1

.moreArgs:
	printErr "Too many arguments"
	printb   "  ->   Showing help instead", 10, 10, 0
	call     help
	exit     1

.done:
	xor eax, eax
	pop rbp
	ret

	; Check if program is valid arg : void check(const char **prog)
	; Args:
	; - rdi -> const char **prog (program name ptr)

check:
	;        Save state
	push     rax
	push     rsi
	;        Compare rdi to program names
	lea      rsi, [progs.help]
	strcmp   rdi, rsi
	je       .help
	lea      rsi, [progs.alpha]
	strcmp   rdi, rsi
	je       .alpha
	lea      rsi, [progs.ansi]
	strcmp   rdi, rsi
	je       .ansi
	lea      rsi, [progs.months]
	strcmp   rdi, rsi
	je       .months
	printErr "Invalid program"
	printb   "  ->   Showing help instead", 10, 10, 0
	call     help
	exit     1

.help:
	call help
	jmp  .done

.alpha:
	call alpha
	jmp  .done

.ansi:
	call ansi
	jmp  .done

.months:
	call months
	jmp  .done

.done:
	pop rsi
	pop rax
	ret

	; Help menu : void help(void)

help:
	printb "$ [", 0
	printv cYellow
	printb "program", 0
	printv cNoCol
	printb "] <", 0
	printv cYellow
	printb "program", 0
	printv cNoCol
	printb " (Optional)>", 10, 10, 0
	printv cYellow
	printb "PROGRAMS:", 10, 0
	printv cNoCol
	printb " ", 0
	printv progs.help
	printb "   ->  Help menu", 10, " ", 0
	printv progs.alpha
	printb "  ->  Alphabet cheatsheet", 10, " ", 0
	printv progs.ansi
	printb "   ->  ANSI escape codes", 10, " ", 0
	printv progs.months
	printb " ->  Months of the year", 10, 0
	ret

section .bss

colBuf:
	resb 4

	section .data

progs:
.help:
	db "help", 0

.alpha:
	db "alpha", 0

.ansi:
	db "ansi", 0

.months:
	db "months", 0
