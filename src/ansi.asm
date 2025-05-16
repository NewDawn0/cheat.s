	;        Exec section & imports & exports
	section  .text
	default  rel
	extern   cGreen, cNoCol, cPrefix, cRed, cSuffix, cYellow
	global   ansi
	%include "src/macros.inc"

	; Ansi program : void ansi()
	; Clobbers:
	; -  dl

	; Ansi program : void ansi()
	; Clobbers:
	; -  al, dl

ansi:
	;      Save state
	push   rax
	push   rdi
	push   rcx
	;      Print title
	printv cNoCol, title.p0, cRed, title.p1, cYellow, title.p2, cRed, title.p3, cGreen, title.p4, cRed, title.p5, cYellow, title.p6, cNoCol, title.p7
	;      Print cols
	printv cYellow, cols.title, cNoCol
	;      Setup loop
	mov    rcx, 31
	lea    rdi, [colBuf]

.loop:
	;      Stringify number (0-99)
	toStr  rdi, rcx
	lea    rdi, [colBuf]
	;      Print number + space
	printb " ", 0
	strlen rdi
	printv cPrefix
	printr rdi, rax
	printv cSuffix
	printr rdi, rax
	inc    rcx
	cmp    rcx, 37
	jne    .loop
	printb 10, 10, 0
	;      Print mods
	printv cGreen, mods.title, cNoCol
	printv mods.normal, cNoCol
	printv mods.bold, cNoCol
	printv mods.italic, cNoCol
	printv mods.underline, cNoCol
	printv mods.inverse, cNoCol
	printv mods.crossedOut, cNoCol
	;      Restore state
	pop    rcx
	pop    rdi
	pop    rax
	ret

	;       Static Section
	section .bss

colBuf:
	resb 4

	;       Colours
	section .data

cols.title:
	db "COLOURS:", 10, 0

	; Mods

mods:
.title:
	db "MODIFIERS:", 10, 0

.normal:
	db "  0  ", 0x1b, "[0mNormal", 10, 0

.bold:
	db "  1  ", 0x1b, "[1mBold", 10, 0

.italic:
	db "  3  ", 0x1b, "[3mItalic", 10, 0

.underline:
	db "  4  ", 0x1b, "[4mUnderline", 10, 0

.inverse:
	db "  7  ", 0x1b, "[7mInverse", 10, 0

.crossedOut:
	db "  9  ", 0x1b, "[9mCrossed out", 10, 0

	; Title

title.p0:
	db "$ echo -e '", 0

title.p1:
	db "\x1b[", 0

title.p2:
	db "<COL>", 0

title.p3:
	db ";", 0

title.p4:
	db "<MOD>", 0

title.p5:
	db "m ", 0

title.p6:
	db "text", 0

title.p7:
	db "'", 10, 10, 0
