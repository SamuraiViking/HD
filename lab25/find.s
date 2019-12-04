/* main program */
	.text
	.align	2
	.global	main

find_chars_in_input:
	@ [fp, #-12] = index
	@ [fp, #-8]  = input_char
	push	{fp, lr}
	add		fp, sp, #0
	sub		sp, sp, #16

	mov		r1, #0				 
	ldr		r0, input_charP		
	bl		get_byte			@ returns input_char[0]


	str		r0, [fp, #-8]		@ store input char
	mov		r1, #0
	str		r1, [fp, #-12]		@ store index
	b		loop_through_input_chars

char_eq_input_char:
	@ [fp, #-8]  = input_char
	ldr		r1, [fp, #-8]				@ input char
	ldr		r0, print_one_charP
	bl		printf

next_char:
	@ [fp, #-16] = char
	@ [fp, #-12] = index
	@ [fp, #-8]  = input_char
	ldr		r1, [fp, #-12]	@ index
	ldr		r2, [fp, #-8]	@ input char

	add		r1, r1, #1		@ add one to index
	str		r1, [fp, #-12]	@ store index

	ldr		r1, [fp, #-12]
	ldr		r0, input_charsP
	bl		get_byte			@ returns input_chars[index]

	str		r0, [fp, #-16]		@ value input_chars[index]

	b		loop_through_input_chars

loop_through_input_chars:
	@ [fp, #-16] = char
	@ [fp, #-12] = index
	@ [fp, #-8]  = input_char
	ldr		r1, [fp, #-12]
	cmp		r1, #''
	beq		end_function

	ldr		r1, [fp, #-16]
	ldr		r2, [fp, #-8]
	cmp		r1, r2
	beq		char_eq_input_char

	b next_char


end_function:
	mov 	r0, #0
	sub		sp, fp, #0
	pop		{fp, pc}



main:
	push 	{fp, lr}	
	add 	fp, sp, #0
	sub		sp, sp, #16	

	ldr 	r0, enter_char_promptP
	bl  	printf


	ldr		r0, input_charP		
	mov		r1, #3			
	bl		get_line

	ldr 	r0, enter_line_promptP
	bl  	printf

	ldr		r0, input_charsP		
	mov		r1, #100			
	bl		get_line

	bl		find_chars_in_input

	mov		r0, #0
	sub		sp, fp, #0			
	pop		{fp, pc}

	.align	2

input_charsP:	  	 .word input_chars
input_charP:		 .word input_char
enter_line_promptP:  .word enter_line_prompt
enter_char_promptP:	 .word enter_char_prompt
user_inputP:		 .word user_input

print_one_charP:	 .word print_one_char
print_two_charsP:	 .word print_two_chars
print_three_charsP:	 .word print_three_chars

	.section	.rodata
	.align 	2

enter_char_prompt:
	.asciz	"Enter a char:\t"
	.align 2

enter_line_prompt:
	.asciz	"Enter a line of input:\t"
	.align 2

user_input:
	.asciz	"%d"
	.align	2

print_one_char:
	.asciz	"%c "
	.align 2

print_two_chars:
	.asciz	"Two Chars: %c %c\n"
	.align 2

print_three_chars:
	.asciz	"Three Chars: %c %c %c\n"
	.align 2
	.data

input_chars:	.skip	100
input_char: 	.skip	1
