.text
	addi t1, zero, 7
	li t2, 0x33 # ou 33
	add t0, t1, t2
	sub s1, t1, t2

	beq t1, t2, then #será uma label
	addi t2, t2, 1 # t2++
	j segue
then: 	addi t1, t1, 1 #t1++ (pular a instrucao com j)
segue: # pulou e parte para cá
	
	li a7, 1
	mv a0, s1
	ecall
	
	#e se usar BNE?#######################################################3
	bne t1, t2, else
	addi t1, t1, 1
	j segue
else: addi t2, t2, 1
segue:
	li a7, 1
	ecall 