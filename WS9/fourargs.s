
.LC0:
	.ascii	"%d %d %d %d\000"
	.align	2
.LC1:
	.ascii	"You enterd the four numbers: %d %d %d %d\000"
	.text
	.align	2
	.global	main
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	push {fp, lr}
	add	fp, sp, #0
	sub	sp, sp, #24

	sub	r0, fp, #8
	sub	r1, fp, #12
	sub	r2, fp, #16
	sub	r3, fp, #20
	str	r3, [sp]
	mov	r3, r0
	ldr	r0, .L3
	bl	__isoc99_scanf
	ldr	r0, [fp, #-8]
	ldr	r1, [fp, #-12]
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-20]
	str	r3, [sp]
	mov	r3, r0
	ldr	r0, .L3+4
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #0
	@ sp needed
	pop	{fp, pc}
.L4:
	.align	2
.L3:
	.word	.LC0
	.word	.LC1
	.size	main, .-main
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
