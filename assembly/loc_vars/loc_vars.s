
	.align	2
	.global	sum

sum:
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20

	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	str	r2, [fp, #-16]
	str	r3, [fp, #-20]

	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-12]
	add	r2, r2, r3

	ldr	r3, [fp, #-16]
	add	r2, r2, r3

	ldr	r3, [fp, #-20]
	add	r2, r2, r3

	ldr	r3, [fp, #4]
	add	r3, r2, r3

	mov	r0, r3
	add	sp, fp, #0
	ldr	fp, [sp], #4
	bx	lr
	.align	2

sum_of_inputs_text:
	.asciz	"sum(%d, %d, %d, %d, %d) == %d\n"
	.align	2
	.global	main

main:
	push {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #40

	mov	r3, #1
	str	r3, [fp, #-8]
	mov	r3, #2
	str	r3, [fp, #-12]
	mov	r3, #3
	str	r3, [fp, #-16]
	mov	r3, #4
	str	r3, [fp, #-20]
	mov	r3, #5
	str	r3, [fp, #-24]

	ldr	r3, [fp, #-24]
	str	r3, [sp]
	ldr	r3, [fp, #-20]
	ldr	r2, [fp, #-16]
	ldr	r1, [fp, #-12]
	ldr	r0, [fp, #-8]
	bl	sum

	str	r0, [fp, #-28]
	ldr	r3, [fp, #-28]
	str	r3, [sp, #8]
	ldr	r3, [fp, #-24]
	str	r3, [sp, #4]

	ldr	r3, [fp, #-20]
	str	r3, [sp]
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-12]
	ldr	r1, [fp, #-8]
	ldr	r0, sum_of_inputs_textP
	bl	printf

	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	pop	{fp, pc}

sum_of_inputs_textP: .word sum_of_inputs_text


