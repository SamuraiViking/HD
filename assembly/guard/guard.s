
less_than_five_text:
	.asciz	"%d is less than 5\n"
	.align	2

equal_to_five_text:
	.asciz	"%d is equal to\n"
	.align	2

greater_than_five_text:
	.asciz	"%d is greater than\n"
	.align	2

	.align 2
	.global	main

main:
	push {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	mov	r3, #5
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #4
	bgt	less_than_five
	ldr	r1, [fp, #-8]
	ldr	r0, less_than_five_textP
	bl	printf
	b	end_function

less_than_five:
	ldr	r3, [fp, #-8]
	cmp	r3, #5
	bne	equal_to_five
	ldr	r1, [fp, #-8]
	ldr	r0, equal_to_five_textP
	bl	printf
	b	end_function

equal_to_five:
	ldr	r1, [fp, #-8]
	ldr	r0, greater_than_five_textP
	bl	printf

end_function:
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	pop	{fp, pc}

less_than_five_textP: .word less_than_five_text
equal_to_five_textP: .word equal_to_five_text
greater_than_five_textP: .word greater_than_five_text
