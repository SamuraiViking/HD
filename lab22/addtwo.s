/* String Constants */

	.section	.rodata
	.align 2

prompt: /* Format string for printf */
	.asciz "Enter two integers: "

input:
	.asciz "%d %d" 

results:
	.asciz "The sum of %d and %d is %d\n"

/* main program */
	.text
	.align 2
	.global main

main:
	push {fp, lr} /* setup stack frame */
	add fp, sp, #4
	sub sp, sp, #16
	# [fp, #-8] holds x, first input integer
	# [fp, #-12] holds y, second input integer
	# [fp, #-16] holds sum, sum of x and y

	ldr r0, promptP  
	bl printf

	ldr r0, inputP
	sub r1, fp, #8
	sub r2, fp, #12
	bl __isoc99_scanf

	ldr r2, [fp, #-8] 
	ldr r3, [fp, #-12] 
	add r1, r2, r3
	str r1, [fp, #-16]

	ldr r0, resultsP 
	ldr r1, [fp, #-8] 
	ldr r2, [fp, #-12]
	ldr r3, [fp, #-16]
	bl printf

	mov r0, #0 
	sub sp, fp, #4
	pop {fp, pc}

# Pointer variables for format strings

promptP: .word prompt
inputP: .word input
resultsP: .word results


