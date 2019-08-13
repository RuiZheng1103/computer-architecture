# Project 1 - Input and Output System 
	.data 
Upper:  .asciiz   
	"Alpha ","Bravo ","China ","Delta ","Echo ","Foxtrot ",
        "Golf ","Hotel ","India ","Juliet ","Kilo ","Lima ",
        "Mary ","November ","Oscar ","Paper ","Quebec ","Research ",
        "Sierra ","Tango ","Uniform ","Victor ","Whisky ","X-ray ",
        "Yankee ","Zulu "
S_offset:.word
	 0,7,14,21,28,34,43,49,56,63,71,
         77,83,89,99,106,113,121,131,
         139,146,155,163,171,178,186  
		      
Number:	.asciiz 
        "zero ", "First ", "Second ", "Third ", "Fourth ",
        "Fifth ", "Sixth ", "Seventh ","Eighth ","Ninth "	
N_offset:.word
	 0,6,13,21,28,36,43,50,59,67

Lower:	.asciiz  
        "alpha ","bravo ","china ","delta ","echo ","foxtrot ",
   	"golf ","hotel ","india ","juliet ","kilo ","lima ",
      	"mary ","november ","oscar ","paper ","quebec ","research ",
	"sierra ","tango ","uniform ","victor ","whisky ","x-ray ",
  	"yankee ","zulu "
  		
	.text 
	.globl main
main:	li $v0,12
	syscall
	beq $v0,63,exit	# if input equals to '?'
	
	sub $t1,$v0,48 
	blt $t1,$0,other 	# if less than '0', input belongs to symble
	
	sub $t2,$t1,10 		# if less than or equal to '9', input belongs to number
	blt $t2,$0,num	
	
	sub $t1,$v0,65
	blt $t1,$0,other 	# if less than 'A', input belongs to symble
	sub $t2,$t1,26
	blt $t2,$0,upper 	# if less than 'Z', input belongs to Upper
		
	sub $t1,$v0,97
	blt $t1,$0,other 	# if less than 'a',then $t2 = 1, else $t2 = 0
	sub $t2,$t1,26 		
	blt $t2,$0,lower		# if less than 'z',then $t2 = 1, else $t2 = 0 
	
	j other
			
num:	la $s0,N_offset
	sll $t1,$t1,2
	add $s0,$s0,$t1
	lw $s1,($s0)
	la $a0,Number
	add $a0,$a0,$s1
	li $v0,4
	syscall
	j main
	
upper:	la $s0,S_offset
	sll $t1,$t1,2
	add $s0,$s0,$t1
	lw $s1,($s0)
	la $a0,Upper
	add $a0,$a0,$s1
	li $v0,4
	syscall
	j main

lower:	la $s0,S_offset
	sll $t1,$t1,2
	add $s0,$s0,$t1
	lw $s1,($s0)
	la $a0,Lower
	add $a0,$a0,$s1
	li $v0,4
	syscall
	j main

other:	li $v0,11
	and $a0,$0,$0
	add $a0,$a0,42 
	syscall
	j main
				
exit:	li $v0,10
	syscall
