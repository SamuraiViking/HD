
fact:
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8

	str	r0, [fp, #-8]

	ldr	r3, [fp, #-8]
	cmp	r3, #1
	bgt	bigger_than_one

	mov	r3, #1
	b	end_function

bigger_than_one:
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1

	mov	r0, r3
	bl	fact

	mov	r2, r0
	ldr	r3, [fp, #-8]
	mul	r3, r3, r2

end_function:
	mov	r0, r3
	sub	sp, fp, #4
	pop	{fp, pc}
	.align	2

fact_result_text:
	.ascii	"The fact of %d is %d\012\000"

	.align	2
	.global	main

main:
	push {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8

	mov	r3, #5
	str	r3, [fp, #-8]
	ldr	r0, [fp, #-8]
	bl	fact

	str	r0, [fp, #-12]
	ldr	r2, [fp, #-12]
	ldr	r1, [fp, #-8]
	ldr	r0, fact_result_textP
	bl	printf

	mov	r0, #0
	sub	sp, fp, #4
	pop	{fp, pc}

fact_result_textP: .word fact_result_text




