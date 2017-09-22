# Compute first twelve Fibonacci numbers and put in array, then print
    .data
fibs: .word  0 : 20                 # "array" of 20 words to contain fib values
nouse: .word 0
size: .word  20                     # size of "array" 
      
    .text

    la      $t0, fibs               # $t0 = &fibs
    la      $t5, size               # $t5 = &size
    lw      $t5, 0($t5)             # $t5 = *$t5 --> $t5 = 20
    
    li      $t2, 1                  # $t2 = 1 
    sw      $t2, 0($t0)             # store F[0] with 1
    sw      $t2, 4($t0)             # store F[1] with 1
    
    ori     $t6, $zero, 2           # $t6 = 2
    sub    $t1, $t5, $t6           # the number of loop is (size-2)
    ori     $t7, $zero, 1           # the lastest loop 

Loop:
    slt     $t4, $t1, $t7           # $t4 = ($t1 < 1) ? 1 : 0
    beq	    $t4, $t7, Loop_End      # repeat if not finished yet   error
    lw      $a0, 0($t0)             # $a0 = F[n]
    lw      $a1, 4($t0)             # $a1 = F[n+1]
    jal     fibonacci               # $v0 = fibonacci( F[n], F[n+1] )
    sw      $v0, 8($t0)             # store F[n+2]
    addi    $t0, $t0, 4             # $t0 point to F[n+1]
    addi    $t1, $t1, -1            # loop counter decreased by 1
	j       Loop
	
Loop_End:    
     lui     $t6, 0xABCD             # $t6 = 0xABCD0000   #    addi  $t6,$0,0xABCD#
    addi    $t0, $t0, 8             # point to the next address of the lastest fibonacci unit
    sw      $t6, 0($t0)             # *$t0 = $t6
Loop_Forever:
    j       Loop_Forever            # loop forever

fibonacci :
    add    $v0, $a0, $a1	# $v0 = x + y
    jr      $ra             # return
