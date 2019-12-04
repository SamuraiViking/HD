/* example of guard in assembly */

/* format strings for I/O */    
        .section .rodata
        .align  2
prompt: .asciz "Enter two integers x and y: "
        .align  2
scanf_fmt:
        .asciz "%d %d"
        .align  2
not_gt_msg: .asciz "%d is not greater than %d\n"
        .align  2
gt_msg: .asciz "%d is greater than %d\n"

/* main program */
        .text
        .align  2
        .global main
main:
        push    {fp, lr}        @ setup stack frame
        add     fp, sp, #4
        sub     sp, sp, #8      @ #8 for 2 local variables
        @ [fp, #-8] is x, first integer variable
        @ [fp, #-12] is y, second integer variable

        ldr     r0, promptP     @ print prompt
        bl      printf
        ldr     r0, scanf_fmtP  @ read values of x and y
        sub     r1, fp, #12
        sub     r2, fp, #8
        bl      __isoc99_scanf

        ldr     r0, [fp, #-12]   @ if y > x
        ldr     r1, [fp, #-8]  
        cmp     r0, r1          
        bgt     else
        ldr     r0, not_gt_msgP     @ print less-than/equal-to message
        ldr     r1, [fp, #-12]   
        ldr     r2, [fp, #-8]  
        bl      printf
        b       next

else:
        ldr     r0, gt_msgP     @ otherwise print greater-than message
        ldr     r1, [fp, #-12]   
        ldr     r2, [fp, #-8]  
        bl      printf

next:
        mov     r0, #0          @ assign 0 as return value
        sub     sp, fp, #4      @ tear down stack frame
        pop     {fp, pc}

/* pointer variables for format strings */
        .align  2
promptP:
        .word   prompt
scanf_fmtP:
        .word   scanf_fmt       
not_gt_msgP:
        .word   not_gt_msg
gt_msgP:
        .word   gt_msg
