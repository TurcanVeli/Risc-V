.global _main
.data
inputmsg: .string"enter positive integer: "
newline: .string"\n"

.text
_main:	
	
	addi a2,a2,2
	addi a5,a5,5
	la   a0, inputmsg
        li   a7, 4
        ecall
	li a0, 0 # File descriptor, 0 for STDIN
	li a7, 5 # System call code for read integer. The value will be in a7
	ecall
	add a4,a4,a0 #a4 is input value
	la x1,print # store print label adrees to first stack pointer 
	j method




#recursive method
method:
	#
    	addi  sp, sp, -8
    	sw    x1, 4(sp)# stroe adreess of ins
    	sw    a4, 0(sp)
    	bgt   a4, x0, L1
    	add  a4,a5,x0
    	addi sp,sp,8
    	jalr x0, 0(x1)
    
 L1:
 	addi a4,a4, -1
 	jal x1, method#x1 reqister holds 32. ins adress.
 	add a6,a4,x0 #firstly a4 is 5, a6 will store a4, a6 is temp
 	lw x1, 4(sp) #load second reqister adress
 	lw a4, 0(sp) #load second value of a4
	addi sp,sp,8 #pop up
	mul a6,a6,a2 # 2*f(x)
	add a4,a4,a6 # 2*f(x) + x
	jalr x0, 0(x1)
	

print:
	add a0,a4,x0
	li a7,1
	ecall
	addi a7, x0, 93 #Exit process
	addi a0, x0, 13
	ecall

