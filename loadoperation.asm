.data
byte: .byte 7 8 9 10 11
word: .word 0x3332

.text
	la s0, word
	lb t0, 1(s0)
	lw t1, 0(s0)
	
