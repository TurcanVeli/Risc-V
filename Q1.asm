.global _main
.data
inputmsg: .string"enter positive integer:"
errormsg: .string"you should enter a positive integer!"
newline: .string"\n"
star: .ascii"*"

.text
_main:
	la x1, _main
	la   a0, inputmsg
        li   a7, 4
        ecall
	li a0, 0 # File descriptor, 0 for STDIN
	li a7, 5 # System call code for read integer. The value will be in a7
	ecall
	blt a0 , x0, error
	li a6, 0 #a6  = i
	li a2, 0 #a2 =  j
	add a4,a4,a0 #a4 is input value
	jal x1, loop1
	la a0, newline # prepare to print string
	li a7, 4 # print string
	ecall
	j loop2
	
	
	
error:
	la   a0, errormsg
        li   a7, 4
        ecall
        la   a0, newline
        li   a7, 4
        ecall
        jr x1
        	
loop1:
	beq a6,a4,exit
	li a2,0
	addi a6,a6,1
	jr x1
	 
	
loop2:
	beq a2,a6, loop1 #a2 =  J a6 = i
	la a0, star # prepare to print string
	li a7, 4 # print string
	ecall
	addi a2,a2,1
	j loop2
	

exit:
	addi a7, x0, 93 #Exit process
	addi a0, x0, 13
	ecall



	
	
	
