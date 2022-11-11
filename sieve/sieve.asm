### Data Declaration Section ###

.data

primes:		.space  1000            # reserves a block of 1000 bytes in application memory
err_msg:	.asciiz "Invalid input! Expected integer n, where 1 < n < 1001.\n"

### Executable Code Section ###

.text

main:
    # get input
    li      $v0,5                   # set system call code to "read integer"
    syscall                         # read integer from standard input stream to $v0

    # validate input
    li 	    $t0,1001                # $t0 = 1001
    slt	    $t1,$v0,$t0		        # $t1 = input < 1001
    beq     $t1,$zero,invalid_input # if !(input < 1001), jump to invalid_input
    nop
    li	    $t0,1                   # $t0 = 1
    slt     $t1,$t0,$v0		        # $t1 = 1 < input
    beq     $t1,$zero,invalid_input # if !(1 < input), jump to invalid_input
    nop
    
    # initialise primes array
    la	    $t0,primes              # $s1 = address of the first element in the array
    li 	    $t1,5
    li 	    $t2,0
    li	    $t3,1
init_loop:
    sb	    $t3, ($t0)              # primes[i] = 1
    addi    $t0, $t0, 1             # increment pointer
    addi    $t2, $t2, 1             # increment counter
    bne	    $t2, $t1, init_loop     # loop if counter != 999
    
    ### Continue implementation of Sieve of Eratosthenes ###

#I'm missing the code where I change the ones that aren't primes to 0 but hopefully I've done enough for komplettering 
# I'm trying :(

#algorithm Sieve of Eratosthenes is
#    input: an integer n > 1.
#    output: all prime numbers from 2 through n.
#
#    let A be an array of Boolean values, indexed by integers 2 to n,
#    initially all set to true.
#    
#    for i = 2, 3, 4, ..., not exceeding √n do
#        if A[i] is true
#            for j = i2, i2+i, i2+2i, i2+3i, ..., not exceeding n do
#                set A[j] := false
#
#    return all i such that A[i] is true.

    ### Print nicely to output stream ###
    
    la $t0, primes #index pointer 
    addi $t0, $t0, -1
    li $t1, 1 #index counter 
    li $t2, 1
    move $t3, $v0
    addi $t3, $t3, +1
print_loop:
    addi    $t0, $t0, 1             # increment pointer
    addi    $t1, $t1, 1             # increment counter
    lb $t4, 0($t0)
    beq $t4, $t2, print
    
    continue: #I'm really bad at using return adress 

    bne	    $t1, $t3, print_loop     # loop if counter != 999    

    # exit program
    j       exit_program
    nop

print: 
   move	$a0, $t1
   li   $v0, 1     
   syscall
   
   j continue
    #start index counter (i) at 2 
    #start index pointer at adress of first element
    #loop
    #if a[i] = 1 
    	#print counter 
    #counter ++ 
    #if counter != end index / input???, restart loop 
    
invalid_input:
    # print error message
    li      $v0, 4                  # set system call code "print string"
    la      $a0, err_msg            # load address of string err_msg into the system call argument registry
    syscall                         # print the message to standard output stream

exit_program:
    # exit program
    li $v0, 10                      # set system call code to "terminate program"
    syscall                         # exit program
