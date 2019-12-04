
is_lower_case_char_text:
	.ascii	"%c is a lower case char\012\000"
	.align	2

not_lower_case_char_text:
	.ascii	"%c is not a lower case char\012\000"
	.align	2

is_lower_case_char:
	push {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8

	str	r0, [fp, #-8]

	ldr	r3, [fp, #-8]
	cmp	r3, #96
	ble	not_lowercase_char

	ldr	r3, [fp, #-8]
	cmp	r3, #122
	bgt	not_lowercase_char

	ldr	r1, [fp, #-8]
	ldr	r0, is_lower_case_char_textP
	bl	printf

	mov	r3, #1
	b	end_function

not_lowercase_char:
	ldr	r1, [fp, #-8]
	ldr	r0, not_lower_case_char_textP
	bl	printf
	mov	r3, #0

end_function:
	mov	r0, r3
	sub	sp, fp, #4
	pop	{fp, pc}

enter_char_prompt:
	.ascii	"Enter one char x: \000"
	.align	2

user_input:
	.ascii	"%c\000"
	.text
	.align	2
	.global	main

main:
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8

	ldr	r0, enter_char_promptP
	bl	printf

	sub	r1, fp, #8
	ldr	r0, user_inputP
	bl	__isoc99_scanf

	ldr	r3, [fp, #-8]

	mov	r0, r3
	bl	is_lower_case_char

	mov	r0, #0
	sub	sp, fp, #4
	pop	{fp, pc}

is_lower_case_char_textP: .word is_lower_case_char_text
not_lower_case_char_textP: .word not_lower_case_char_text

enter_char_promptP: .word enter_char_prompt
user_inputP: .word user_input
