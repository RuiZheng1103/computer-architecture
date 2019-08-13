# Project 2 - String Match

	.data
success:	.asciiz "\r\nSuccess! Location: "
failure:	.asciiz "\r\nFail!"
end:		.asciiz "\r\n"
buf: 		.space 1000
	
	.text
	.globl main
	 # store the first address of input string in $s0
	 # store the location of character in $s1
	 # store the character in $t0
main:	la $a0,buf 	# address of input buffer
	la $a1,1000 	# maxium number of characters
	li $v0,8	# read string
	syscall
	 
input:	li $v0,12 	# read a character		
	syscall
	beq $v0,63,exit	# equal to '?'
	move $t0,$v0
	la $s0,buf
	la $s1,1
	
loop:	lb $t1,($s0)
	beq $t1,$zero,fail
	beq $t1,$t0,succ
	add $s1,$s1,1
	add $s0,$s0,1
	j loop
	
succ:	li $v0,4
	la $a0,success
	syscall 
	li $v0,1
	move $a0,$s1
	syscall
	li $v0,4
	la $a0,end
	syscall
	j input

fail:	li $v0,4
	la $a0,failure
	syscall
	li $v0,4
	la $a0,end
	syscall
	j input
	
exit:	li $v0,10
	syscall
 