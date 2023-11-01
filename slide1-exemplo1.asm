.data
b:	.half 10
c: 	.half 5
e:	.half 20

.text
	lh t0 b
	lh t1 c
	lh t2 e
	add t0 t0 t1 #a = b + c 
	sub t1 t0 t2 #d = a – e