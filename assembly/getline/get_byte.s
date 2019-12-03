
	.align	2
	.global	main

main:
	push {fp, lr}	
	add fp, sp, #0
	sub	sp, sp, #16	

	ldr	r0, enter_line_promptP 
	bl	puts				 

	mov	r1, #100			
	ldr	r0, inputCharsP		
	bl	get_line			

    mov r1, #0
    mov r2, #'I'
    ldr r0, inputCharsP
    bl put_byte

    ldr r0, inputCharsP
    bl printf

	mov	r0, #0
	sub	sp, fp, #0			
	pop	{fp, pc}

	.align	2

inputCharsP:	  	 .word	inputChars
enter_line_promptP:  .word enter_line_prompt

	.section	.rodata
	.align 	2

enter_line_prompt:
	.asciz	"Enter a line of input (up to 99 chars):"

	.data
	.align	2

inputChars:	.skip	100
