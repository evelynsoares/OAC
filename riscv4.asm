.data
addi: .word 0x03300393

.text
	lui s0, 2 
	jalr x0, s0, 0
	
	lui s0, 0xFACAC
	addi s0, s0, 0x0FE
	
	addi t1, zero, 7
	li t2, 0x33 # ou 33
	add t0, t1, t2
	sub s1, t1, t2

	bne t1, t2, else
	addi t1, t1, 1
	mv a0, t1
#	jal ra, inc #funcao, vai gauardr no reg (descarata o end de retorno case vc coloque em x0})  salto para perto do pc
	# jal usa o pc, jalr usa um reg

	
	jalr ra, s0, 100 # spega o end que esta dentro do reg
	
	j segue
else: addi t2, t2, 1 #t2++
segue:
	li a7, 1
	mv a0,t1
	ecall 