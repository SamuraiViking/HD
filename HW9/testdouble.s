

double:
	push {fp, lr}
	add	fp, sp, #0
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #1
	mov	r0, r3
	add	sp, fp, #0
	pop {fp, pc}


prompt:
	.ascii	"Enter a integer: \000"

input:
	.ascii	"%d\000"

result:
	.ascii	"The call double(%d) returns %d\012\000"

.align	2
.global	main

main:
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8

	ldr	r0, promptP
	bl	printf

	sub	r3, fp, #12
	mov	r1, r3
	ldr	r0, inputP
	bl	__isoc99_scanf

	ldr r0, [fp, #-12]
	bl	double

	str	r0, [fp, #-8]
	ldr	r3, [fp, #-12]
	ldr	r2, [fp, #-8]
	mov	r1, r3
	ldr	r0, resultP
	bl	printf

	mov	r0, #0
	sub	sp, fp, #4
	pop	{fp, pc}

promptP: .word prompt
inputP: .word input
resultP: .word result

