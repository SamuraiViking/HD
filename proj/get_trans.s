
space_guard_text:
	.asciz	"There was not a \" \" in str[1]"
	.align	2

guard_two_text:
	.asciz	"There was not a \\n in str[3]"
	.align	2

result_text:
	.asciz	"%s"
	.text
	.align	2
	.global	get_trans

get_trans:
	push {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]

	add	r3, r3, #1
	ldrb r3, [r3]	@ zero_extendqisi2
	cmp	r3, #32
	beq	space_at_one
	ldr	r0, space_guard_textP
	bl	printf
	mov	r3, #0
	b	end_function

space_at_one:
	ldr	r3, [fp, #-8]
	add	r3, r3, #3
	ldrb r3, [r3]	@ zero_extendqisi2
	cmp	r3, #10
	beq	newline_at_three
	ldr	r0, guard_two_textP
	bl	printf
	mov	r3, #0
	b	end_function

newline_at_three:
	ldr	r1, [fp, #-8]
	ldr	r0, result_textP
	bl	printf
	mov	r3, #0

end_function:
	mov	r0, r3
	sub	sp, fp, #4
	pop	{fp, pc}

inputChars:
	.ascii	"H E\012\000"
	.text
	.align	2
	.global	main

main:
	push {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8



	ldr	r0, inputCharsP		@ get input
	mov r1, #100
	bl get_line

	@ ldr r0, inputCharsP
	@ bl printf

	@ ldr	r0, inputCharsP		@ call get_trans(r0)
	@ bl	get_trans
	@ mov	r3, #0
	@ mov	r0, r3
	sub	sp, fp, #4
	pop	{fp, pc}

	.align 2

@ inputCharsP: .word inputChars
space_guard_textP: .word space_guard_text
guard_two_textP: .word guard_two_text
result_textP: .word result_text

inputCharsP:	.skip	100


