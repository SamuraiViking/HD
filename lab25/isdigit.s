    .section    .rodata
    .align      2
    .global     main

get_int_from_user:
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #16

    ldr     r0, enter_integer_textP
    bl      printf

    sub     r1, fp, #8
    ldr     r0, user_inputP
    bl      __isoc99_scanf

    ldr     r0, [fp, #-8]

    sub     sp, fp, #0
    pop     {fp, pc}

is_digit:
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #16

    str     r0, [fp, #-8]

    ldr     r1, [fp, #-8]
    mov     r2, #0
    cmp     r1, r2
    blt     false

    ldr     r1, [fp, #-8]
    mov     r2, #255
    cmp     r1, r2
    bgt     false

    b       true


false:
    mov     r0, #0
    b       end_function

true:
    mov     r0, #1
    b       end_function

end_function:
    sub     sp, fp, #0
    pop     {fp, pc}

main:
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #16

    bl      get_int_from_user
    @       r0 = int that user entered
    bl      is_digit
    @       r0 = 1 if input was between 0 and 255 else 0

    mov     r1, r0
    ldr     r0, one_decP
    bl      printf

    mov     r0, #0

    sub     sp, fp, #0
    pop     {fp, pc}
    .align  2

user_inputP:           .word user_input
enter_integer_textP:   .word enter_integer_text
one_decP:              .word one_dec

enter_integer_text:
    .asciz  "\nEnter an integer between 0 and 255: "
    .align  2

one_dec:
    .asciz  "is_dec returned: %d\n\n"
    .align  2

user_input:
    .asciz  "%d"
    .align 2



