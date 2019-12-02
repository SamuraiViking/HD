	.align	2
	.global	main

main:
	push {fp, lr}
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, #0
	str	r3, [fp, #-8]
	b	less_than_ten

add_one:
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]

less_than_ten:
	ldr	r3, [fp, #-8]
	cmp	r3, #9
	ble	add_one
	mov	r3, #0
	mov	r0, r3
	add	sp, fp, #0
	pop {fp, pc}
