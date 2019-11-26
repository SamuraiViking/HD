

translate:
	push {fp, lr}			@ setup stack
	add fp, sp, #0
	sub sp, sp, #20

	ldr r0, inputCharsP		@ r0 = inputChars
	mov r1, #0				@ r1 = 0
	mov r2, #'*'			@ r2 = '*'
	bl put_byte				@ inputChars[r1] = inputChars[r2]

	ldr r0, inputCharsP		@ r0 = inputChars
    bl  puts				@ print(r0)

	sub sp, fp, #0			@ collapse stack
	pop {fp, pc}

	.align 2

get_trans:
	push {r4, r5, fp, lr}	@ setup stack
	add fp, sp, #0
	sub sp, sp, #20

	ldr r0, inputCharsP 	@ r0 = inputChars
	mov r1, #1				@ r1 = 2
	bl get_byte				@ r0 = r0[r1]

	mov r4, r0
	cmp r4, #' '
	bne no_space_at_one

	ldr r0, inputCharsP		@ r0 = inputChars
	mov r1, #3				@ r1 = 4
	bl get_byte				@ r0 = r0[r1]

	mov r5, r0				@ r5 = r0
	cmp r5, #'\n'
	bne no_newline_at_three

	ldr r0, inputCharsP
	mov r1, #5
	bl get_byte

	cmp r0, #0
	bne no_nullbyte_at_four

	b end_function
	.align 2

	mov r0, #0
	sub sp, fp, #4
	pop {fp, pc}

no_space_at_one:
	ldr r0, no_space_at_one_textP
	bl printf
	b end_function

no_newline_at_three:
	ldr r0, no_newline_at_index_fourP
	bl printf
	b end_function

no_nullbyte_at_four:
	ldr r0, no_nullbyte_at_four_textP
	bl printf
	b end_function

end_function:
	mov r0, #0
	sub sp, fp, #0			@ collapse
	pop {r4, r5, fp, pc}

/* main program */
	.text
	.align	2
	.global	main

print_summary:
	push {fp, lr}			@ setup stack
	add fp, sp, #0
	sub sp, sp, #20

	ldr r0, print_summary_textP
	bl printf				@ print(r0, r1, r2)

	sub sp, fp, #0
	pop {fp, pc}

main:
	push {fp, lr}	@ setup stack frame
	add fp, sp, #0
	sub	sp, sp, #16	

	ldr	r0, get_line_promptP @ r0 = get_line_printP
	bl	puts				 @ print(r0)

	ldr	r0, inputCharsP		@ r0 = inputCharsP
	mov	r1, #100			@ r1 = 100
	bl	get_line			@ get input string

	bl get_trans			@ call get_trans

	ldr	r0, inputCharsP		@ r0 = inputChars
	mov	r1, #100			@ r1 = 100
	bl	get_line			@ get input string

	ldr r0, inputCharsP		@ r0 = inputChars
	mov r1, #0				@ r1 = 0
	bl  get_byte			@ 


	ldr r0, inputCharsP		@ r0 = inputChars
	bl translate			@ call translate 

	ldr r0, print_summary_textP		
	mov r1, r4				@ r4 = inChar
	mov r2, r5				@ r5 = outChar
	bl print_summary		@ print(r0, r1, r2)

	mov	r0, #0
	sub	sp, fp, #0			@ tear down stack frame and return
	pop	{fp, pc}

	@ pointer variables for format strings
	.align	2

inputCharsP:	  	 .word	inputChars
testOuputP: 	  	 .word testOuput
charFormatP:      	 .word charFormat
print_summary_textP: .word print_summary_text
get_line_promptP:    .word get_line_prompt
no_newline_at_index_fourP: .word no_newline_at_index_four
no_space_at_one_textP: .word no_space_at_one_text
no_nullbyte_at_four_textP: .word no_nullbyte_at_four_text

	@ strings
	.section	.rodata
	.align 	2

hello:	
	.asciz	"Hello, world!\n"
	.align 	2

testOuput:
	.asciz "Test Output\n"
	.align 2

charFormat:
    .asciz "%c %c\n"
    .align 2

print_summary_text:
	.asciz "Primary Text\n"
	.align 2

get_line_prompt:
	.asciz	"Enter a line of input (up to 99 chars):"

no_space_at_one_text:
	.asciz "There was no space at index one\n"

no_newline_at_index_four:
	.asciz "There was no newline at index three\n"

no_nullbyte_at_four_text:
	.asciz "No nullbyte at four\n"

	.data
	.align	2

inputChars:	.skip	100
