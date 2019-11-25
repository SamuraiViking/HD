/* test program for mylib.s
   RAB 11/2018 */

	
/* test function for print_dec
	1 arg - 4-byte integer to print
	state change - prints labelled output fro print_dec
	return - none */
	.text
	.align	2
print_decT:	
	push	{fp, lr}	@ setup stack frame
	add 	fp, sp, #4
	sub	sp, sp, #8	@ 1 arg
	@ [fp, #-8] is val, an integer value for testing
	
	str	r0, [fp, #-8]	@ initialize val

	ldr	r0, print_dec_fmt1P	@ call printf(...fmt1P, val)
	ldr	r1, [fp, #-8]
	bl	printf
	ldr	r0, [fp, #-8]	@ call print_dec(val)
	bl	print_dec
	ldr	r0, print_dec_fmt2P	@ call printf(...fmt2P)
	bl	printf

	sub	sp, fp, #4	@ tear down stack frame and return
	pop	{fp, pc}
	
	@ pointer variables for format strings
	.align	2
print_dec_fmt1P:
	.word	print_dec_fmt1
print_dec_fmt2P:
	.word	print_dec_fmt2
	
	@ format strings
	.section	.rodata
	.align 	2
print_dec_fmt1:
	.asciz	"print_dec(%d) prints '"
	.align	2
print_dec_fmt2:
	.asciz	"'\n"
	.align 	2


/* test function for print_hex
	1 arg - 4-byte integer to print
	state change - prints labelled output fro print_hex
	return - none */
	.text
	.align	2
print_hexT:	
	push	{fp, lr}	@ setup stack frame
	add 	fp, sp, #4
	sub	sp, sp, #8	@ 1 arg
	@ [fp, #-8] is val, an integer value for testing
	
	str	r0, [fp, #-8]	@ initialize val

	ldr	r0, print_hex_fmt1P	@ call printf(...fmt1P, val)
	ldr	r1, [fp, #-8]
	bl	printf
	ldr	r0, [fp, #-8]	@ call print_hex(val)
	bl	print_hex
	ldr	r0, print_hex_fmt2P	@ call printf(...fmt2P)
	bl	printf

	sub	sp, fp, #4	@ tear down stack frame and return
	pop	{fp, pc}
	
	@ pointer variables for format strings
	.align	2
print_hex_fmt1P:
	.word	print_hex_fmt1
print_hex_fmt2P:
	.word	print_hex_fmt2
	
	@ format strings
	.section	.rodata
	.align 	2
print_hex_fmt1:
	.asciz	"print_hex(%d) prints '"
	.align	2
print_hex_fmt2:
	.asciz	"'\n"
	.align 	2

	
/* test function for get_byte
	2 args - word-aligned memory address and non-negative integer index
	return - integer whose lowest 8 bits are byte arg2 after that address
	    arg1, and whose other bits are 0 */
	.text
	.align	2
get_byteT:
	push	{fp, lr}	@ setup stack frame
	add 	fp, sp, #4
	sub	sp, sp, #16	@ 2 args, one more local variable
	@ [fp, #-8] holds addr, address of a word in memory
	@ [fp, #-12] holds offset, index of desired byte relative to addr
	@ [fp, #-16] holds b, desired byte value

	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	ldr	r0, get_byte_fmt1P	@ label printf(...fmt1P, addr, offset)
	ldr	r1, [fp, #-8]
	ldr	r2, [fp, #-12]
	bl	printf
	ldr	r0, [fp, #-8]		@ call get_byte(addr, offset)
	ldr	r1, [fp, #-12]
	bl	get_byte
	str	r0, [fp, #-16]
	
	ldr	r0, get_byte_fmt2P	@ print b in hex
	ldr	r1, [fp, #-16]
	bl	printf
	ldr	r0, [fp, #-16]		@ if 32 <= b < 255
	cmp	r0, #32
	blt	get_byte_nl
	cmp	r0, #255
	bge	get_byte_nl
	ldr	r0, get_byte_fmt3P	@ print b as a character
	ldr	r1, [fp, #-16]
	bl	printf
get_byte_nl:	
	ldr	r0, get_byte_fmt4P	@ print newline
	bl	printf

	sub	sp, fp, #4		@ tear down stack frame and return
	pop	{fp, pc}
	
	@ pointer variables for format strings
	.align	2
get_byte_fmt1P:
	.word	get_byte_fmt1
get_byte_fmt2P:
	.word	get_byte_fmt2
get_byte_fmt3P:
	.word	get_byte_fmt3
get_byte_fmt4P:
	.word	get_byte_fmt4

	@ format strings
	.section	.rodata
	.align 	2
get_byte_fmt1:
	.asciz	"get_byte(0x%x, %d) returns "
	.align	2
get_byte_fmt2:
	.asciz	"0x%x"
	.align	2
get_byte_fmt3:
	.asciz	" '%c'"
	.align	2
get_byte_fmt4:
	.asciz	"\n"

	

	/* test function for put_byte
	2 args - word-aligned memory address and non-negative integer index
	return - integer whose lowest 8 bits are byte arg2 after that address
	    arg1, and whose other bits are 0 */
	.text
	.align	2
put_byteT:
	push	{fp, lr}	@ setup stack frame
	add 	fp, sp, #4
	sub	sp, sp, #16	@ 3 args
	@ [fp, #-8] holds addr, address of a word in memory
	@ [fp, #-12] holds offset, index of desired byte relative to addr
	@ [fp, #-16] holds val, ascii code to assign

	str	r0, [fp, #-8]		@ save arg values
	str	r1, [fp, #-12]
	str	r2, [fp, #-16]

	ldr	r1, [fp, #-8]
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-16]

	ldr	r0, [fp, #-8]		@ call put_byte(addr, offset)
	ldr	r1, [fp, #-12]
	ldr	r2, [fp, #-16]
	bl	put_byte

	sub	sp, fp, #4		@ tear down stack frame and return
	pop	{fp, pc}
	
	@ pointer variables for format strings
	.align	2
put_byte_fmt1P:
	.word	put_byte_fmt1
	
	@ format strings
	.section	.rodata
	.align 	2
put_byte_fmt1:
	.asciz	"\nafter put_byte(0x%x, %d, '%c'), quote becomes\n"
	.align	2


/* main program */
	.text
	.align	2
	.global	main
main:
	push	{fp, lr}	@ setup stack frame
	add 	fp, sp, #4
	@sub	sp, sp, #8	@ 0 arg

	ldr	r0, get_line_promptP
	bl	puts
	ldr	r0, buffP
	mov	r1, #100
	bl	get_line

    mov r1, r0
    ldr r0, testP
    bl printf

	ldr r0, buffP
    mov r1, #1
    mov r2, #'X'
    bl put_byteT

    ldr r0, buffP
    bl  puts

	mov	r0, #0
	sub	sp, fp, #4	@ tear down stack frame and return
	pop	{fp, pc}

	@ pointer variables for format strings
	.align	2
helloP:		.word	hello
hello_fmtP:	.word	hello_fmt
quoteP:		.word	quote
quote_fmtP:	.word	quote_fmt
buffP:		.word	buff
testP:      .word   test
get_line_promptP: .word get_line_prompt
	
	@ strings
	.section	.rodata
	.align 	2
hello:	
	.asciz	"Hello, world!\n"
	.align 	2

test:
    .asciz "%d\n"
    .align 2

hello_fmt:	
	.asciz	"\nTesting get_byte with string at address 0x%x, \"%s\"\n"
quote_fmt:	
	.asciz	"\nTesting put_byte with quote at address 0x%x\n%s\n"

get_line_prompt:
	.asciz	"\nEnter a line of input (up to 99 chars):"

	.data
	.align	2
quote:	.asciz ""
	.align	2
buff:	.skip	100
