
hello_world_text:
	.asciz	"Hello World\n"

	.align	2
	.global	main

main:
	push {fp, lr}
	add	fp, sp, #4

	ldr	r0, hello_world_textP
	bl	printf

	mov	r3, #0
	mov	r0, r3
	pop	{fp, pc}

hello_world_textP: .word hello_world_text


