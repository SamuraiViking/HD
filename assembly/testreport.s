prodplus:
	push {fp, lr}
	add	fp, sp, #0
	sub	sp, sp, #20
	mul	r2, r2, r1
	add	r3, r2, r3
	ldr r0, helloP
	bl  printf
	mov	r0, r3
	sub	sp, fp, #0
	pop {fp, pc}

report:
	bl	prodplus

prompt:
	.asciz	"Enter three integers: "

input:
	.asciz	"%d %d %d"

test:
	.asciz "The entered the numbers: %d %d %d"

hello:
	.asciz "Hello"

result:
	.asciz	"The call prodplus(%d, %d, %d) returns %d\n"
	.align	2
	.global	main

main:
	push	{fp, lr}	@ stackframe
	add	fp, sp, #4
	sub	sp, sp, #20

	ldr	r0, promptP
	bl	printf

	ldr	r0, inputP
	sub	r1, fp, #8
	sub	r3, fp, #16
	sub	r2, fp, #12
	bl	__isoc99_scanf

	ldr r0, testP
	ldr r1, [fp, #-8]
	ldr r2, [fp, #-12]
	ldr r3, [fp, #-16]
	bl printf

	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-12]
	ldr r1, [fp, #-8]
	mov	r0, r3
	bl	prodplus

	str	r0, [sp]
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-12]
	ldr	r1, [fp, #-8]
	ldr	r0, resultP
	bl	printf

	mov	r0, #0
	sub	sp, fp, #4
	pop	{fp, pc}

promptP: .word prompt
inputP: .word input
resultP: .word result
testP: .word test
helloP: .word hello
