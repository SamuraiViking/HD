




prompt:
    .asciz "Enter two integer values: "

input:
    .asciz "%d %d"

result:
    .asciz "The sum of %d and %d is %d"

.align 2
.global main

main:
    push {fp, lr}
    add fp, sp, #0
    sub sp, sp, #16

    ldr r0, promptP
    bl printf

    sub r1, fp, #8
    sub r2, fp, #12
    ldr r0, inputP
    bl __isoc99_scanf

    ldr r1, [fp, #-8]
    ldr r2, [fp, #-12]
    add r3, r1, r2
    ldr r0, resultP
    bl printf

    mov r0, #0

    sub sp, fp, #0
    pop {fp, pc}


inputP: .word input
promptP: .word prompt
resultP: .word result
