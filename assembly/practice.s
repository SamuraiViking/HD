
prompt:
    .asciz "Give me three numbers: "

input:
    .asciz "%d %d %d"

result:
    .asciz "prodplus(%d, %d, %d) is %d\n"

.align 2
.global main

prodplus:
    push {fp, lr}
    add fp, sp, #0
    sub sp, sp, #20

    mul r4, r1, r2
    add r4, r4, r3
    mov r0, r4

    sub sp, fp, #0
    pop {fp, pc}

main:
    push {fp, lr}
    add fp, sp, #0
    sub sp, sp, #20

    ldr r0, promptP
    bl printf

    sub r1, fp, #8
    sub r2, fp, #12
    sub r3, fp, #16
    ldr r0, inputP
    bl  __isoc99_scanf

    ldr r1, [fp, #-8]
    ldr r2, [fp, #-12]
    ldr r3, [fp, #-16]
    bl  prodplus

    str r0, [sp]
    ldr r0, resultP
    bl  printf

    mov r0, #0
    sub sp, fp, #0
    pop {fp, pc}

promptP: .word prompt
inputP: .word input
resultP: .word result
