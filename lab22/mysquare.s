

square:
	/* Set up stackframe */
	push {fp, lr}
	add	fp, sp, #0

	/* one local variable */  
	/* [fp, #-8] holds x */
	sub	sp, sp, #8

	/* x = r0  */
	str	r0, [fp, #-8]

	/* r3 = x  */
	ldr	r3, [fp, #-8]

	/* r2 = x  */
	ldr	r2, [fp, #-8]

	/* r3 *= r3 */
	mul	r3, r2, r3

	/* r0 = r3 */
	mov	r0, r3

	/* collapse stack frame  */
	add	sp, fp, #0
	pop {fp, pc}

.result:
	.ascii	"The square of %d is %d\000"
	.align	2
	.global	main

main:
	push	{fp, lr}	@ setup stack
	add	fp, sp, #4
	sub	sp, sp, #8		@ one local variable

	/* [fp, #-8] holds x */

	mov	r3, #10			@ mov the value 10 into r3
	str	r3, [fp, #-8]	@ store r3's value (10) into x
	ldr	r0, [fp, #-8]	@ load x into r0
	bl	square			@ branch to square function
	str	r0, [fp, #-12]  @ x = r0
	ldr	r2, [fp, #-12]  @ r2 = squaredX
	ldr	r1, [fp, #-8]   @ r1 = x
	ldr	r0, .resultP	@ r0 = results
	bl	printf			
	mov	r0, #0			@ collapse stack frame
	sub	sp, fp, #4
	pop	{fp, pc}

.resultP:	.word	.result
