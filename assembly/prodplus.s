prodplus:
	push {fp, lr}
	add	fp, sp, #0
	sub	sp, sp, #16
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	str	r2, [fp, #-16]
	ldr	r3, [fp, #-8]
	ldr	r2, [fp, #-12]
	mul	r2, r2, r3
	ldr	r3, [fp, #-16]
	add	r3, r2, r3
	mov	r0, r3
	add	sp, fp, #0
	pop {fp, pc}

prompt:
	.ascii	"Enter three integers: \000"
input:
	.ascii	"%d %d %d\000"
result:
	.ascii	"The call prodplus(%d, %d, %d) returns %d\012\000"
	.align	2
	.global	main

main:
	push	{fp, lr}
	add	fp, sp, #16
	sub	sp, sp, #28
	ldr	r0, promptP
	bl	printf
	sub	r3, fp, #32
	sub	r2, fp, #28
	sub	r1, fp, #24
	ldr	r0, inputP
	bl	__isoc99_scanf
	ldr	r4, [fp, #-24]
	ldr	r5, [fp, #-28]
	ldr	r6, [fp, #-32]
	ldr	r3, [fp, #-24]
	ldr	r1, [fp, #-28]
	ldr	r2, [fp, #-32]
	mov	r0, r3
	bl	prodplus
	mov	r3, r0
	str	r3, [sp]
	mov	r3, r6
	mov	r2, r5
	mov	r1, r4
	ldr	r0, resultP
	bl	printf
	mov	r0, #100 	 	@ cause why not
	sub	sp, fp, #16
	pop	{fp, pc}

promptP: .word prompt
inputP: .word input
resultP: .word result

