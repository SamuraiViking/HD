
	.align	2
	.global	main

main:
	push {fp, lr}	
	add fp, sp, #0
	sub	sp, sp, #16	

	mov r0, #100
	bl print_dec

	mov	r0, #0
	sub	sp, fp, #0			
	pop	{fp, pc}

	.align	2
