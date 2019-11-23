

input:
	.ascii	"%d %d\000"
	.align	2

getTwoNums:
	push {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8

	str	r1, [fp, #-8]
	str	r2, [fp, #-12]

	ldr	r1, [fp, #-8]
	ldr	r2, [fp, #-12]

	ldr	r0, inputP
	bl	__isoc99_scanf

	sub	sp, fp, #4
	pop	{fp, pc}

	.align	2
	.global	main

main:
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8

    sub r1, fp, #8
    sub r2, fp, #12
	bl	getTwoNums

	ldr	r1, [fp, #-8]
	ldr	r2, [fp, #-12]
	ldr	r0, inputP
	bl	printf

	sub	sp, fp, #4
	pop	{fp, pc}

inputP: .word	input
