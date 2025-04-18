	;        Exec section & imports & exports
	section  .text
	global   ansi
	%include "src/macros.inc"

ansi:
	prints "Hello Ansi", 10, 0
