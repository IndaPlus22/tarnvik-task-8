main: 
   li $v0, 5
   syscall 
   move $a0, $v0 #a 

   li $v0, 5
   syscall 
   move $a1, $v0 #b

   jal multiply

   #print the thing 
   move	$a0, $v0
   li   $v0, 1     
   syscall

   li $v0, 5
   syscall 
   move $a0, $v0 #n
   nop

   jal faculty

   #print the thing 
   move	$a0, $v0
   li   $v0, 1     
   syscall

   # exit program
   li $v0, 10                     
   syscall 

multiply: #uses a0 as a, a1 as b and returns v0
   li	$v0, 0
   li   $t0, 0  #loop index      
   m_loop:
      add   $v0, $v0, $a0
      addi  $t0,$t0,1    
      bne   $t0,$a1,m_loop 
  
  jr	$ra 

faculty: 
   move $t4, $ra  #save return adress to main
   move	$t1, $a0  #loop index   
   li 	$t3, 1 # end index 
   li	$t2, 1	#fac 
   f_loop:
      move $a0, $t2 
      move $a1, $t1 
      jal multiply
      move $t2, $v0
      addi  $t1,$t1,-1    
      bne   $t1,$t3,f_loop 
   
   move $ra, $t4  
   jr	$ra 
