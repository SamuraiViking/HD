	.section	.rodata
	.align 2

prompt:
	.asciz	"Enter an integer: "

input:
	.asciz	"%d"

results:
	.asciz	"The call add1(%d) returns %d\n"
	
	.text
	.align 2

add10:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	# [fp, #8] holds n, integer argument
	str r0, [fp, #-8]

	ldr r0, [fp, #-8]
	add r0, r0, #10

	# r0 now holds desired return value

	sub sp, fp, #4
	pop {fp, pc}

# Main Program
	.text
	.align	2
	.global	main

main:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	# [fp, #-8] holds x, input integer

	ldr r0, promptP
	bl printf

	ldr r0, inputP
	sub r1, fp, #8
	bl __isoc99_scanf

	ldr r0, [fp, #-8]
	bl add10

	mov r2, r0
	ldr r0, resultsP
	ldr r1, [fp, #-8]
	bl printf

	mov r0, #0
	sub sp, fp, #4
	pop {fp, pc}

	.align 2

promptP: .word prompt
inputP: .word input
resultsP: .word results


