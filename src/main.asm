	;       Executable & imports & exports
	section .text
	extern  alpha;, ansi
	global  _main

	%include "src/macros.inc"

	; Main entrypoint

_main:
	;    Create stack frame
	push rbp
	mov  rbp, qword rsp
	;    Main code
	call alpha
	;    Restore stack frame
	mov  rsp, qword rbp
	pop  rbp
	exit 0
	ret
