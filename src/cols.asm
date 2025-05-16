global cGreen, cNoCol, cPrefix, cRed, cSuffix, cYellow

section .data

cPrefix:
	db 0x1b, "[", 0

cSuffix:
	db ";1m", 0

cNoCol:
	db 0x1b, "[0m", 0

cYellow:
	db 0x1b, "[33;1m", 0

cGreen:
	db 0x1b, "[32;1m", 0

cRed:
	db 0x1b, "[31;1m", 0
