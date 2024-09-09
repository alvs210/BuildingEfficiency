.data 
    prompt:
    .asciiz "Input number:"
    newline:
    .asciiz "\n"
    
    input:      .word       0
    answer:     .word       0

.text   

# main: #f(N) = 3*(N-1)+f(N-1)+1.
    
main:

    #input prompts
    li $v0, 4
    la $a0, prompt
    syscall

    #get number  from the user
    li $v0, 5
    syscall
    sw $v0, input

    #call the recursive function
    lw $a0,input
    jal recurse
    sw $v0,answer   #storing the answer

    li $v0, 1
    lw $a0, answer
    syscall

main_exit:

    li      $v0,10
    syscall

recurse:

    addi $sp, $sp -8  #space for two words
    sw $a0, 0 ($sp)    #first word AKA return address
    sw $ra, 4($sp)

    li $v0,2
    
    beqz $a0, _done #base case

    addi $a0, $a0, -1   #$a0 = n -1
    jal recurse    #call f(n-1)
    lw $a0,0($sp)   #get input number back back

    addi $v0, $v0, 1  #recursed answer plus 1
    addi $a0,$a0,-1  #N-1
    mul $a0, $a0, 3 #multiplying it by 3

    add $v0, $v0, $a0

_done:
    
    lw      $a0,0($sp)
    lw      $ra,4($sp)
    addi    $sp,$sp, 8
    jr      $ra



    
    

