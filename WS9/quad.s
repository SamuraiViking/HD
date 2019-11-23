prompt:
    .asciz "Enter four integer values: "

input:
    .asciz "%d %d %d %d"

quad:
    push {fp, lr}
    add fp, sp, #0
    sub sp, sp, #16

    @ r0 = x
    @ r1 = a
    @ r2 = b
    @ r3 = c

    mul r2, r2, r0 @ b * x
    mul r3, r3, r0 @ c * x
    mul r3, r3, r0 @ c * x

    add r1, r1, r2 @ a + b*x
    add r1, r1, r3 @ a + c*x*x

    mov r0, r1

    sub sp, fp, #0
    pop {fp, pc}

result:
    .asciz "The quad is %d"

.align 2
.global main

main:
    push {fp, lr}
    add fp, sp, #0
    sub sp, sp, #24

    ldr r0, promptP
    bl printf

    sub r0, fp, #8
    sub r1, fp, #12
    sub r2, fp, #16
    sub r3, fp, #20
    str r3, [sp]
    mov r3, r0
    ldr r0, inputP
    bl __isoc99_scanf

    ldr r0, [fp, #-8]
    ldr r1, [fp, #-12]
    ldr r2, [fp, #-16]
    ldr r3, [fp, #-20]

    bl quad

    mov r1, r2
    ldr r0, resultP
    bl printf

    mov r0, #0

    sub sp, fp, #0
    pop {fp, pc}


inputP:  .word input
promptP: .word prompt
resultP: .word result
