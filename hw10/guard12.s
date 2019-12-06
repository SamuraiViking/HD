    .align 2    
    .global main

guard:
    @       [fp, #-8] = x
    @       [fp, #-12] = y
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #16

    str     r1, [fp, #-8]
    str     r2, [fp, #-12]

    ldr     r1, [fp, #-8]
    ldr     r2, [fp, #-12]

    add     r3, r1, r2
    cmp     r3, #7
    ble     else

    ldr     r1, [fp, #-8]
    cmp     r1, #0
    bge     else

    ldr     r1, [fp, #-8]
    cmp     r1, #-11
    ble     else

    ldr     r0, true_textP
    bl      printf

    mov     r0, #0
    bl      end_guard

else:
    ldr     r0, false_textP
    ldr     r1, [fp, #-8]
    ldr     r2, [fp, #-12]
    bl      printf

    mov     r0, #0
    bl      end_guard


end_guard:
    sub     sp, fp, #0
    pop     {fp, pc}

main:
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #16

    ldr     r0, enter_two_nums_textP
    bl      printf

    ldr     r0, two_intP
    sub     r1, fp, #8
    sub     r2, fp, #12
    bl      __isoc99_scanf

    ldr     r1, [fp, #-8]
    ldr     r2, [fp, #-12]

    bl      guard

    mov     r0, #0
    sub     sp, fp, #0
    pop     {fp, pc}

two_intP:               .word   two_int
enter_two_nums_textP:   .word   enter_two_nums_text
false_textP:            .word   false_text
true_textP:             .word   true_text

enter_two_nums_text:
    .asciz      "Enter two nums: "
    .align 2

two_int:
    .asciz      "%d %d"
    .align 2

false_text:
    .asciz      "%d and %d do not follow the condition: x+y > 7 && x <= 0 && x >= -10\n"
    .align 2

true_text:
    .asciz      "valid numbers\n"
    .align 2
