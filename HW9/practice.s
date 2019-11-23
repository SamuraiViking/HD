
output:
	.asciz	"%d %d %d\n"
	.align	2

printNum:
	push	{fp, lr}
    add fp, sp, #0
    sub sp, sp, #16

    str r1, [fp, #-8]
    str r2, [fp, #-12]
    str r3, [fp, #-16]

    ldr r4, [fp, #-8]
    ldr r5, [fp, #-12]
    ldr r6, [fp, #-16]



    mul r4, r4, r5
    add r4, r4, r6

    mov r1, r4 
    mov r2, r5
    mov r3, r6
    
    ldr r0, outputP 
	bl	printf
    add sp, fp, #0
	pop	{fp, pc}

	.align	2
	.global	main

main:
	push	{fp, lr}
	add	fp, sp, #0
    sub sp, sp, #20
    mov r1, #1
    mov r2, #2
    mov r3, #3
	bl	printNum
	mov	r3, #0
	mov	r0, r3
    sub sp, fp, #0
	pop	{fp, pc}

outputP: .word output
