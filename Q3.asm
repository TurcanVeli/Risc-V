.data
space: .string" "
arraylenght: .string"enter lenght of array: "
arrayelement: .string"enter array element: "


.text
main:
	la   a0, arraylenght
        li   a7, 4
        ecall
	#a0 = N = lenght of array
	li a0, 0 # File descriptor, 0 for STDIN
	li a7, 5 # System call code for read integer. The value will be in a7
	ecall
	
	
	add a1,a0,x0 #a1 is lenght -1  of array
	add a2 ,a0,x0 #a1 is lenght -1  of array, Temp value 
	addi a1,a1,-1 #reducing 1, because this reqister will bi index
	addi a2,a2,-1
	addi a3, x0, -4
	mul a3, a3, a0 # sp miktarý N kadar
	add sp, sp, a3
	add x22,x22,sp #temp value of base adress
	jal  x1, userinput
	li a1,0 #i = 0 again
	j print
	
.text		
userinput:
	blt a1,x0, Loopi
	slli s0,a1,2
	add s0,s0,x22
	la   a0, arrayelement
        li   a7, 4
        ecall
	li a0, 0 # File descriptor, 0 for STDIN
	li a7, 5 # System call code for read integer. The value will be in a7
	ecall
	sw  a0, 0(s0)
	addi a1,a1,-1
	j userinput



#insertion sort
#----------------------------------------------
#a1 = i
#a4 = j
#a2 = arr.lenght
#a6 = key
Loopi:
        addi a1, a1, 1     # i++
        slli s0, a1, 2     
        add  s0, s0, x22   # Setting base adress of array into s0, 
        lw   a0, 0(s0)     # a0 = arr[i]
        add  a6, a0, x0    # key = arr[i]
        addi a4, a1, -1    # j=i-1
        ble  a1, a2, Loopj # if(i<n) jump
        jr x1 #jumping 27. instructor


Loopj:
	slli s0, a4, 2     # get the address of data[j]
        add  s0, s0, x22
        lw   x30, 0(s0)     # t6=data[j]
        blt  a4, x0, changekey # if(j<0) leave Loopj
        bge  a6, x30, changekey # if(temp>=data[j]) leave Loopj
        sw   x30, 4(s0)     # arr[j+1] = arr[j]
        addi a4, a4, -1    # j--
        j   Loopj


changekey: 
	 sw   a6, 4(s0)     # arr[j] = temp 
	 j Loopi
#----------------------------------------------
.text
print:
	bgt a1,a2, exit 
	slli s0,a1,2
	add s0,s0,x22
	lw a0, 0(s0)
	li a7, 1 # Print integer. (the value is taken from a0)
	ecall
	la   a0, space
        li   a7, 4
        ecall
	addi a1,a1,1
	j print
	
	
exit:
	addi a7, x0, 93 #Exit process
	addi a0, x0, 13
	ecall
