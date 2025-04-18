;Executable & imports & exports
section .text
extern alpha
global  _main

; Main entrypoint
_main:
	call alpha
