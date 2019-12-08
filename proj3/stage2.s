    
    .align      2
    .global     main

get_trans:
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #16

    ldr     r0, enter_trans_charsP
    bl      printf

    ldr     r0, trans_charsP
    mov     r1, #100
    bl      get_line                @ prompt user for input and hold input in input_chars

    mov     r1, #1
    ldr     r0, trans_charsP
    bl      get_byte                @ r0 = input_charsP[1]

    cmp     r0, #' '
    bne     false

    mov     r1, #3
    ldr     r0, trans_charsP
    bl      get_byte                @ r0 = input_charsP[3]

    cmp     r0, #'\n'
    bne     false

    bl      true

false:
    mov     r0, #0
    sub     sp, fp, #0
    pop     {fp, pc}

true:
    mov     r0, #1
    sub     sp, fp, #0
    pop     {fp, pc}

translate:
    @       [fp, #-8] = trans_chars[0]
    @       [fp, #-12] = trans_chars[2]
    @       [fp, #-16] = index
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #40

    ldr     r0, trans_charsP
    mov     r1, #0
    bl      get_byte

    str     r0, [fp, #-8]

    ldr     r0, trans_charsP
    mov     r1, #2
    bl      get_byte

    str     r0, [fp, #-12]

    mov     r1, #0
    str     r1, [fp, #-16]

    bl      translate_loop

char_to_trans_found:
    ldr     r0, input_charsP
    ldr     r1, [fp, #-16]
    ldr     r2, [fp, #-12]
    bl      put_byte

translate_increase_index:
    ldr     r0, [fp, #-16]
    add     r0, r0, #1
    str     r0, [fp, #-16]

translate_loop:
    ldr     r0, input_charsP
    ldr     r1, [fp, #-16]
    bl      get_byte

    ldr     r1, [fp, #-8]

    cmp     r0, r1
    beq     char_to_trans_found

    cmp     r0, #0
    bne     translate_increase_index

    sub     sp, fp, #0
    pop     {fp, pc}

print_summary:
    @ [fp, #-8] = index
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #16

    ldr     r0, input_charsP
    mov     r1, #'\n'
    bl      num_of_char_in_chars

    str     r0, [fp, #-8]

    ldr     r0, input_charsP
    mov     r1, #' '
    bl      num_of_char_in_chars

    str     r0, [fp, #-12]
    ldr     r0, [fp, #-12]
    add     r0, r0, #1
    str     r0, [fp, #-12]

    ldr     r0, input_charsP
    bl      num_of_chars

    str     r0, [fp, #-16]

    ldr     r0, summary_headerP
    bl      printf

    ldr     r0, num_of_charactersP
    ldr     r1, [fp, #-16]
    bl      printf

    ldr     r0, num_of_new_linesP
    ldr     r1, [fp, #-8]
    bl      printf

    ldr     r0, num_of_wordsP
    ldr     r1, [fp, #-12]
    bl      printf


    sub     sp, fp, #0
    pop     {fp, pc}

num_of_chars:
    @       [fp, #-8] = input_chars
    @       [fp, #-12] = index
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #20

    str     r0, [fp, #-8]

    mov     r1, #0
    str     r1, [fp, #-12]

    bl      char_at_index

add_one_to_index:
    ldr     r1, [fp, #-12]
    add     r1, r1, #1
    str     r1, [fp, #-12]

char_at_index:
    ldr     r0, [fp, #-8]
    ldr     r1, [fp, #-12]
    bl      get_byte

    cmp     r0, #0
    bne     add_one_to_index

    ldr     r0, [fp, #-12]

    sub     sp, fp, #0
    pop     {fp, pc}


num_of_char_in_chars:
    @       [fp, #-8]   = input_chars
    @       [fp, #-12]  = char
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #20

    str     r0, [fp, #-8]   @ input_chars
    str     r1, [fp, #-12]  @ char

    mov     r1, #0
    str     r1, [fp, #-16]  @ index
    str     r1, [fp, #-20]  @ number of occurences

    bl      current_char

char_found:
    ldr     r1, [fp, #-20]
    add     r1, r1, #1
    str     r1, [fp, #-20]

next_char:
    ldr     r1, [fp, #-16]
    add     r1, r1, #1
    str     r1, [fp, #-16]

current_char:
    ldr     r0, [fp, #-8]   @ input_chars
    ldr     r1, [fp, #-16]  @ index
    bl      get_byte

    ldr     r1, [fp, #-12]  @ char to find

    cmp     r0, r1
    beq     char_found

    cmp     r0, #0
    bne     next_char

    ldr     r0, [fp, #-20]

    sub     sp, fp, #0
    pop     {fp, pc}

main:
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #16
    
    bl      get_trans                   @ r0 == (input_chars[3] == '\n' && input_chars[1] == ' ') ? 1 : 0

    cmp     r0, #0
    beq     end_main

    ldr     r0, enter_input_charsP
    bl      printf

    mov     r4, #0
    mov     r5, #0
    mov     r6, #0
    bl      get_lines

get_another_line:
    add     r4, r4, #1
    mov     r1, r4
    ldr     r0, one_decP
    bl      printf

get_lines:
    ldr     r0, input_charsP
    mov     r1, #100
    bl      get_line

    ldr     r0, input_charsP
    mov     r1, #0
    bl      get_byte

    cmp     r0, #'\n'
    beq     end_main

    bl      translate

    ldr     r0, input_charsP
    bl      printf   

    bl      get_another_line


    bl      translate                   @ input_chars[0] = *

    ldr     r0, input_charsP
    bl      printf                      @ print translated input_chars

    bl      print_summary               @ 
    bl      end_main

end_main:
    mov     r0, #0
    sub     sp, fp, #0
    pop     {fp, pc}

input_charsP       :     .word   input_chars
trans_charsP       :     .word   trans_chars
enter_trans_charsP :     .word   enter_trans_chars
enter_input_charsP :     .word   enter_input_chars
one_charP          :     .word   one_char  
one_decP           :     .word   one_dec    
one_dec_one_charP  :     .word   one_dec_one_char
summary_headerP    :     .word   summary_header
num_of_new_linesP  :     .word   num_of_new_lines
num_of_wordsP      :     .word   num_of_words
num_of_charactersP :     .word   num_of_characters
two_charsP         :     .word   two_chars           

num_of_characters:
    .asciz      "\tnum of characters: %d\n"
    .align 2

num_of_new_lines:
    .asciz      "\tnum of new lines: %d\n"
    .align 2

num_of_words:
    .asciz      "\tnum of words: %d\n"
    .align 2

summary_header:
    .asciz      "Summary:\n"
    .align 2

enter_trans_chars:
    .asciz      "Enter a trans chars: "
    .align 2

enter_input_chars:
    .asciz      "Enter a line of input: "
    .align 2

one_char:
    .asciz      "%c\n"
    .align 2

two_chars:
    .asciz      "%c\t%c"
    .align 2

one_dec:
    .asciz      "%d\n"
    .align 2

one_dec_one_char:
    .asciz      "%d\t%c\n"
    .align 2

    .data
    .align 2

input_chars:    .skip   100
trans_chars:    .skip   100





