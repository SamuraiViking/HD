/* String constants */
	.section	.rodata
	.align 2

greeting:
	.asciz "Hello, World!\n"

goodbye:
	.asciz "Good, Bye\n"

decAndHexMsg:
	.asciz "The number %d in hex is %x\n"

/* Main Program */
	.text 
	.align 2
	.global main

main:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8

	ldr r0, greetingP
	bl printf

	ldr r0, goodbyeP
	bl printf

	ldr r0, decAndHexMsgP
	ldr r1, sevenHundredTwentyNineP
	ldr r2, sevenHundredTwentyNineP
	bl printf

	mov r0, #0
	sub sp, fp, #4
	pop {fp, pc}

/* pointer variables(s) for format strings */
	.align 2

greetingP:
	.word greeting

goodbyeP:
	.word goodbye

decAndHexMsgP:
	.word decAndHexMsg

sevenHundredTwentyNineP:
	.word 729
