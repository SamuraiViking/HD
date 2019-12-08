    
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
    bne     invalidFormat

    mov     r1, #3
    ldr     r0, trans_charsP
    bl      get_byte                @ r0 = input_charsP[3]

    cmp     r0, #'\n'
    bne     invalidFormat

    bl      validFormat

invalidFormat:
    mov     r0, #0
    sub     sp, fp, #0
    pop     {fp, pc}

validFormat:
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

    bl      loop_through_chars

translate_char:
    ldr     r0, input_charsP
    ldr     r1, [fp, #-16]
    ldr     r2, [fp, #-12]
    bl      put_byte

next_char:
    ldr     r0, [fp, #-16]
    add     r0, r0, #1
    str     r0, [fp, #-16]

    add     r6, r6, #1

loop_through_chars:
    ldr     r0, input_charsP
    ldr     r1, [fp, #-16]
    bl      get_byte

    ldr     r1, [fp, #-8]

    cmp     r0, r1
    beq     translate_char

    cmp     r0, #0
    bne     next_char

    add     r5, r5, #1

    sub     sp, fp, #0
    pop     {fp, pc}

print_summary:
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #16

    ldr     r0, summary_headerP
    bl      printf

    ldr     r0, num_of_charactersP
    mov     r1, r6
    bl      printf

    ldr     r0, num_of_new_linesP
    mov     r1, r5
    bl      printf

    sub     sp, fp, #0
    pop     {fp, pc}

main:
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #16
    
    bl      get_trans  @ r0 == (input_chars[3] == '\n' && input_chars[1] == ' ') ? 1 : 0

    cmp     r0, #0
    beq     end_main

    ldr     r0, enter_input_charsP
    bl      printf

    mov     r4, #0      @ r4 = nLines
    mov     r5, #0      @ r5 = nWords
    mov     r6, #0      @ r6 = nChars
    bl      get_lines

run_get_lines_again:
    add     r4, r4, #1  @ nLines += 1

get_lines:
    ldr     r0, input_charsP
    mov     r1, #100
    bl      get_line    @ get line from user

    ldr     r0, input_charsP
    mov     r1, #0
    bl      get_byte    @ r0 = input_chars[0]

    cmp     r0, #'\n'
    beq     end_get_lines    @ if r0[0] != '\n'

    bl      translate

    ldr     r0, input_charsP
    bl      printf

    bl      run_get_lines_again

end_get_lines:
    bl      print_summary
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





