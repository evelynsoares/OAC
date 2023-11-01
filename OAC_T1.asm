.data
blk_in:	.word 0, 1, 2, 3
blk_out:	.word 0, 0, 0, 0
keys: 	.word 1, 2, 3, 4, 5, 6
num:	.word 0x10001 #65537 in hexa
mask: 	.word 0xffff 

.text	#loades the addresses of the words in the memory to the registers
	la a0, blk_in
	la a1, blk_out
	la a2, keys
	
	#loades the words defined with constant value 
	lw s10, num
	lw s11, mask
	
	#loades the value of the keys to the registers
	lw s0, 0(a2)
	lw s1, 4(a2)
	lw s2, 8(a2)
	lw s3, 12(a2)
	lw s4, 16(a2)
	lw s5, 20(a2)
	
	#loades the value of blk_in to the registers
	lw a4, 0(a0)
	lw a5, 4(a0)
	lw a6, 8(a0)
	lw a7, 12(a0)
	
	jal idea_round	
	
idea_round:
	#loades the values of blk_in in separate words
	add t1, zero, a4
	add t2, zero, a5
	add t3, zero, a6
	add t4, zero, a7
	
	#coloco em t0 o valor de x (blk_in) e em t1 o valor de y (keys) e mascaro os 16 bits menos significativos	  
	lw t0, 0(a0)
	and t0, t0, s11
	lw t5, 0(a2)
	and t5, t5, s11
	
	#chamo multiply e armazeno o valor de x na word1 = t1
	jal multiply
	and t0, t0, s11
	add t1, zero, t0
	
	#faço a operação bitwise AND e armazeno o valor na word2 = t2
	add t2, a5, zero
	add t0, t2, s1 #*key_ptr+
	and t2, t0, s11 
	
	#faço a operação bitwise AND e armazeno o valor na word3 = t3
	add t3, a6, zero 
	add t0, t3, s2 #*key_ptr++
	and t3, t0, s11 
	
	#chamo multiply novamente e mascaro os 16 bits menos significativos de x e y, armazeno o valor de x na word4 = t4
	lw t0, 12(a0)
	and t0, t0, s11
	lw t5, 12(a2) #*key_ptr++
	and t5, t5, s11
	jal multiply
	add t4, t0, zero 
	
	#uso os registradores s1 e s2, daqui pra frente como t1 e t2 no código c, respectivamente
	xor t0, t1, t3
	and t0, t0, s11
	add t5, s4, zero #*key_ptr++
	and t5, t5, s11
	jal multiply
	add s2, zero, t0 
	xor t0, t2, t4
	add t0, t0, s2
	and t0, t0, s11
	add t5, s5, zero #*key_ptr++
	and t5, t5, s11
	jal multiply
	add s1, zero, t0 
	add t0, s1, s2
	and t0, t0, s11
	add s2, t0, zero 
	xor t1, t1, s1
	xor t4, t4, s2
	xor s2, t2, s2
	xor t2, t3, s1
	add t3, zero, s2
	
	#armazeno os valores da saída em blk_out
	sw t1, 0(a1)
	sw t2, 4(a1)
	sw t3, 8(a1)
	sw t4, 12(a1)
	
	li t0, 0 #i = 0
	jal print_values

multiply:
	mul t6, t0, t5 #p = x*y - > t0 = x, t5 = y
	beqz t6, equal_to_zero 
	srli t0, t6, 16 
	add t5, t6, zero
	sub t0, t5, t0
	blt t5, t0, x_greater
	ret
	
equal_to_zero:
	sub t0, s10, t0
	sub t0, t0, t5
	ret
	
x_greater: 
	add t0, t0, s10
	ret 

print_values:
    	lw a2, 0(a1)  
    	mv a0, a2  
    	li a7, 1   
    	ecall
    	addi a1, a1, 4
    	addi t0, t0, 1
    	li t1, 4  
    	blt t0, t1, print_values
	j exit
exit:
