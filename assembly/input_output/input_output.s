
enter_numbers_prompt:
	.ascii	"Enter 3 numbers: \000"
	.align	2

input:
	.ascii	"%d %d %d\000"
	.align	2

numbers_entered_prompt:
	.ascii	"You entered the numbers: %d %d and %d\012\000"

	.align	2
	.global	main

main:
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16

	ldr	r0, enter_numbers_promptP
	bl	printf

	sub	r3, fp, #16
	sub	r2, fp, #12
	sub	r1, fp, #8
	ldr	r0, inputP
	bl	__isoc99_scanf

	ldr	r1, [fp, #-8]
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-16]
	ldr	r0, numbers_entered_promptP
	bl	printf

	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	pop	{fp, pc}

enter_numbers_promptP: .word enter_numbers_prompt
inputP: .word input
numbers_entered_promptP: .word numbers_entered_prompt
