.data
kte:	.word 0xFACACAFE
msk:	.word 0x0000FFFF
ipw:	.word 0x01020304
ipb:	.byte 01 02 03 04 
.text
	la s0, kte
	lw t0, 0(s0)
	lw t1, 4(s0)
	lw t2, 8(s0)
	
	mv a0, t0
	jal lsw16
	
	li a7, 34
	ecall
	
	li a7, 10
	ecall
	
	la a0, msk
	lw a0, 0(a0)
	and s0, t0, a0
	srli s1, t0, 16 #faca vai se alinhar a direita
	
lsw16: #a's e t's
	la a1, msk
	lw a1, 0(a1)
	and a0, a0, a1
	ret#botar o resultado onde quer e dar o return