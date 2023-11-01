.data #f = (g+h)-(i+j) 
g:	.half 1
h: 	.half 2
i:	.half 3
j:	.half 4
result: .half 0 #allocating data for the result

.text
	lh t0 g
	lh t1 h
	lh t2 i
	lh t3 j
	add t0 t0 t1
	add t1 t2 t3
	sub t2 t0 t1
	sh t2 result t1
	li a7 10
	ecall