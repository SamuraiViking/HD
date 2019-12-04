    .section    .rodata
    .align      2
    .global     main

main:
    @       [fp, #-8] = user_input
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #16

    bl      get_int_from_user

get_int_from_user:
    @       [fp, #-8] = user_input
    ldr     r0, enter_an_integerP
    bl      printf

    sub     r1, fp, #8
    ldr     r0, user_inputP
    bl      __isoc99_scanf

    ldr     r1, [fp, #-8]
    str     r1, [fp, #-8]
    b       is_neg

is_neg:
    @       [fp, #-8] = user_input
    ldr     r1, [fp, #-8]
    
    mov     r2, #0
    cmp     r1, r2
    blt     true

    b       false

false:
    @       [fp, #-8] = user_input
    ldr     r1, [fp, #-8]
    ldr     r0, pos_textP
    bl      printf

    mov     r0, #0
    b      end_function

true:
    @       [fp, #-8] = user_input
    ldr     r1, [fp, #-8]
    ldr     r0, neg_textP
    bl      printf

    mov     r0, #1
    b       end_function

end_function:
    sub     sp, fp, #0
    pop     {fp, pc}

    .align 2

enter_an_integerP:  .word   enter_an_integer
neg_textP:          .word   neg_text
pos_textP:          .word   pos_text
user_inputP:        .word   user_input


enter_an_integer:
    .asciz  "Enter an integer: "
    .align 2

neg_text:
    .asciz  "%d is negative\n"
    .align  2

pos_text:
    .asciz  "%d is positive\n"
    .align  2

user_input:
    .asciz  "%d"
    .align 2



