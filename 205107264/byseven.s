.data 
    prompt:
    .asciiz "Input number of sevens:"
    newline:
    .asciiz "\n"
.text

main:
    #save return address pointer
    addi, $sp, $sp, -4
    sw $ra, 0($sp)

    # input 7s prompt
    li $v0, 4
    la $a0, prompt
    syscall

    #get 7s call
    li $v0, 5
    syscall

    #that number is now in v0
    move $t0, $v0

    li $t3, 7 #loading 7 in the number 7
    li $t1, 1

    _loop: 
        
        bgt, $t1, $t0 _endloop #if it is equal, break the loop
        
        mul $t2, $t1, $t3   #multiply 7 and the number, then store in t2
        
        li $v0, 1   #printing integer syscall
        move $a0, $t2   #loading in the integer to print
        syscall   #calling it

        #print newline
        li $v0, 4
        la $a0, newline
        syscall

        addi $t1, 1
        j _loop
    
    _endloop:

        lw $ra, 0($sp)
        addi, $sp, $sp, 4

        li $v0, 0 #return exit success

        jr  $ra #return to whoever called main


