
square: 
    push {fp, lr}
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	ldr	r2, [fp, #-8]
	mul	r3, r2, r3
	mov	r0, r3
	add	sp, fp, #0
    pop {fp, pc}
	.align	2

prompt:
	.ascii	"Enter a positive integer:  \000"
	.align	2

input:
	.ascii	"%d\000"
	.align	2

result:
	.ascii	"The sum of the first %d squares is %d.\012\000"
	.text
	.align	2
	.global	main

main:
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	mov	r3, #0
	str	r3, [fp, #-8]
	ldr	r0, promptP
	bl	printf
	sub	r3, fp, #16
	mov	r1, r3
	ldr	r0, inputP
	bl	__isoc99_scanf
	mov	r3, #0
	str	r3, [fp, #-12]
	b	compare_i_and_n

add_sq_to_result:
	ldr	r0, [fp, #-12]
	bl	square
	mov	r2, r0
	ldr	r3, [fp, #-8]
	add	r3, r3, r2
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]

compare_i_and_n:
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-12]
	cmp	r2, r3
	ble	add_sq_to_result
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-8]
	mov	r1, r3
	ldr	r0, resultP
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	pop	{fp, pc}

promptP: .word prompt
inputP:  .word input
resultP: .word result




