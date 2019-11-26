

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
	mov r1, #2				@ r1 = 2
	bl get_byte				@ r0 = r0[r1]

	mov r4, r0

	ldr r0, inputCharsP		@ r0 = inputChars
	mov r1, #4				@ r1 = 4
	bl get_byte				@ r0 = r0[r1]

	mov r5, r0				@ r5 = r0

	sub sp, fp, #0			@ collapse
	pop {r4, r5, fp, pc}	

	.align 2

/* main program */
	.text
	.align	2
	.global	main

print_summary:
	push {fp, lr}			@ setup stack
	add fp, sp, #0
	sub sp, sp, #20

	ldr r0, print_summary_textP
	mov r1, r4				@ r1 = inChar
	mov r2, r5				@ r2 = outChar
	bl printf				@ print(r0, r1, r2)

	sub sp, fp, #0
	pop {fp, pc}



main:
	push {r4, r5, fp, lr}	@ setup stack frame
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
	pop	{r4, r5, fp, pc}

	@ pointer variables for format strings
	.align	2

inputCharsP:	  	 .word	inputChars
testOuputP: 	  	 .word testOuput
charFormatP:      	 .word charFormat
print_summary_textP: .word print_summary_text
get_line_promptP:    .word get_line_prompt

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
	.asciz "This problem should print only the header line of print_summary out.\nWhat is a header line???\nWhat is print summary output???\nAn example input and output would be extremely helpful\n"
	.align 2

get_line_prompt:
	.asciz	"\nEnter a line of input (up to 99 chars):"

	.data
	.align	2

inputChars:	.skip	100
