/* String constants */
	.section	.rodata
	.align 2

greeting:
	.asciz "Hello, World!\n"

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

	mov r0, #0
	sub sp, fp, #4
	pop {fp, pc}

/* pointer variables(s) for format strings */
	.align 2

greetingP:
	.word greeting
