    
    .align      2
    .global     main
/*
///////////////
// get_trans //
///////////////

get trans chars from user

if trans_chars[0] == ' ' return false
if trans_chars[1] != ' ' return false
if trans_chars[2] != '\n' return false
return true

 */
get_trans:
    push    {fp, lr}                @ setup stackframe
    add     fp, sp, #0
    sub     sp, sp, #16

    ldr     r0, enter_trans_charsP  @ prompt user to input trans chars
    bl      printf

    ldr     r0, trans_charsP
    mov     r1, #100
    bl      get_line                @ get trans chars from user

    mov     r1, #0
    ldr     r0, trans_charsP
    bl      get_byte

    cmp     r0, #' '                @ check if first char is space
    beq     invalidFormat

    mov     r1, #1                  @ get input char
    ldr     r0, trans_charsP
    bl      get_byte        

    cmp     r0, #' '                @ input char does not equal 
    bne     invalidFormat

    mov     r1, #3                  @ get output char
    ldr     r0, trans_charsP
    bl      get_byte

    cmp     r0, #'\n'               @ output char does not equal new line
    bne     invalidFormat

    bl      validFormat

invalidFormat:                      @ return 0 and collapse stack frame
    mov     r0, #0
    sub     sp, fp, #0
    pop     {fp, pc}

validFormat:                        @ return 1 and collapse stack frame
    mov     r0, #1
    sub     sp, fp, #0
    pop     {fp, pc}

/* 
Input: char 
Output: 1 (true) or 0 (false)
*/
is_letter: 
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #10

    @ [fp, #-8] is the argument char

    str     r0, [fp, #-8]
    ldr     r1, [fp, #-8]

    cmp     r1, #'\n'
    beq     is_whitespace

    cmp     r1, #' '
    beq     is_whitespace

    cmp     r1, #'\t'
    beq     is_whitespace

    cmp     r1, #'A'            @ not letter if r1 < A
    ble     not_letter

    cmp     r1, #'z'            @ not letter if r1 > z
    bgt     not_letter

    cmp     r1, #'Z'            @ maybe letter if r1 > Z
    bgt     maybe_letter

    bl      char_is_letter 

is_whitespace:
    add     r9, r9, #1
    bl      not_letter

maybe_letter:
    cmp     r1, #'a'            @ not letter if r1 < a
    blt     not_letter

    bl      char_is_letter

not_letter:
    mov     r0, #0              @ return 0
    sub     sp, fp, #0
    pop     {fp, pc}

char_is_letter:
    add     r8, r8, #1
    mov     r0, #1              @ return 1
    sub     sp, fp, #0
    pop     {fp, pc}



/*
///////////////
// translate //
///////////////
 */
translate:
    @       [fp, #-8] = trans_chars[0]
    @       [fp, #-12] = trans_chars[2]
    @       [fp, #-16] = index
    @       [fp, #-20] = between_words (1 = true, 0 = false)
    push    {fp, lr}
    add     fp, sp, #0
    sub     sp, sp, #40

    ldr     r0, trans_charsP    @ get inner char
    mov     r1, #0
    bl      get_byte

    str     r0, [fp, #-8]       @ store inner char 

    ldr     r0, trans_charsP    @ get outer char
    mov     r1, #2
    bl      get_byte

    str     r0, [fp, #-12]      @ store outer char

    mov     r1, #0              @ init index as 0
    str     r1, [fp, #-16]

    mov     r1, #1              @ init between_words (boolean) as 1
    str     r1, [fp, #-20]

    bl      loop_through_chars

translate_char:
    ldr     r0, input_charsP    @ load input chars
    ldr     r1, [fp, #-16]      @ load index
    ldr     r2, [fp, #-12]      @ load out char
    bl      put_byte            @ replace input char with output char
    add     r7, r7, #1          @ add 1 to number of replacements
    bl      next_char           

not_between_words:
    ldr     r1, [fp, #-20]      @ check if between_words
    cmp     r1, #1
    beq     count_word
    bl      translate_char_guard

count_word:
    add     r5, r5, #1          @ add 1 to num of words
    mov     r1, #0
    str     r1, [fp, #-20]
    bl      translate_char_guard

between_words:
    mov     r1, #1              @ between_words = true
    str     r1, [fp, #-20]

    bl      translate_char_guard

next_char:                      @ increase index 
    ldr     r0, [fp, #-16]
    add     r0, r0, #1
    str     r0, [fp, #-16]

    add     r6, r6, #1
    bl      loop_through_chars

loop_through_chars:
    ldr     r0, input_charsP    @ get char of input char at index
    ldr     r1, [fp, #-16]
    bl      get_byte

    str     r0, [fp, #-24]      @ store char

    ldr     r0, [fp, #-24]      @ check if char equals space
    cmp     r0, #' '
    beq     between_words

    ldr     r0, [fp, #-24]      @ check if char is letter
    bl      is_letter

    cmp     r0, #1              @ if is letter then not_between_words
    beq     not_between_words

translate_char_guard:
    ldr     r0, [fp, #-24]      @ load current char
    ldr     r1, [fp, #-8]       @ load inchar
    cmp     r0, r1              @ check if current char equals inchar
    beq     translate_char      @ translate inchar with outchar

    ldr     r0, [fp, #-24]      @ load current char

    cmp     r0, #0              @ check if current char is 0
    bne     next_char           @ if not 0 then go to next char

    add     r4, r4, #1          @ add 1 to num of chars

    sub     sp, fp, #0
    pop     {fp, pc}

/*
///////////////////
// print_summary //
//////////////////
*/
print_summary:
    push    {fp, lr}                @ set stack frame
    add     fp, sp, #0
    sub     sp, sp, #16

    ldr     r0, summary_headerP     @ print header
    bl      printf

    ldr     r0, num_of_charactersP  @ print num of chars
    mov     r1, r6
    bl      printf

    ldr     r0, num_of_wordsP       @ print num of words
    mov     r1, r5
    bl      printf

    ldr     r0, num_of_new_linesP   @ print num of new lines
    mov     r1, r4
    bl      printf

    ldr     r0, num_of_replacementsP    @ print num of replacements
    mov     r1, r7
    bl      printf

    ldr     r0, num_of_charactersP
    mov     r1, r8
    bl      printf

    ldr     r0, num_of_whitespacesP
    mov     r1, r9
    bl      printf

    sub     sp, fp, #0              @ colapse stack frame
    pop     {fp, pc}

/*
//////////
// main //
//////////
*/
main:
    push    {fp, lr}                @ setup stackframe 
    add     fp, sp, #0
    sub     sp, sp, #16
    
    bl      get_trans               @ get in char
                                    @ get out char

    cmp     r0, #0
    beq     end_main

    ldr     r0, enter_input_charsP  @ print input_chars
    bl      printf                  

    mov     r4, #0      @ r4 = nLines
    mov     r5, #0      @ r5 = nWords
    mov     r6, #0      @ r6 = nChars
    mov     r7, #0      @ r7 = number of replacements
    mov     r8, #0      @ r8 = num of letters
    mov     r9, #0      @ r9 = num of whitespaces
    bl      get_lines

run_get_lines_again:

get_lines:
    ldr     r0, input_charsP        @ get line from user
    mov     r1, #100
    bl      get_line

    ldr     r0, input_charsP        @ get in char
    mov     r1, #0
    bl      get_byte

    cmp     r0, #'\n'               @ end if line is new line
    beq     end_get_lines

    bl      translate               @ replace all inchars with outchars

    ldr     r0, input_charsP        @ print input chars
    bl      printf

    bl      run_get_lines_again     @ get another line

end_get_lines:
    bl      print_summary
    bl      end_main

end_main:   
    mov     r0, #0                  @ colapse stack frame
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
num_of_replacementsP:    .word   num_of_replacements   
num_of_lettersP:         .word   num_of_letters
num_of_whitespacesP:     .word   num_of_whitespaces

num_of_characters:
    .asciz      "\tnum of characters: %d\n"
    .align 2

num_of_new_lines:
    .asciz      "\tnum of new lines: %d\n"
    .align 2

num_of_words:
    .asciz      "\tnum of words: %d\n"
    .align 2

num_of_replacements:
    .asciz      "\tnum of replacements: %d\n"
    .align 2

num_of_letters:
    .asciz      "\tnum of letters: %d\n"
    .align 2

num_of_whitespaces:
    .asciz      "\tnum of whitespaces: %d\n"
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





