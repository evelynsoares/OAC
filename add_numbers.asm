.data #segmentos de dados, para armazenr na memória
x:	.word 33 
y:	.word 99

.text #segmentos de código
	la t0, x
	lw s0, 0(t0)
	add x2, zero, x4
