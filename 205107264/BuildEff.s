.data

    buffer: .space 64   #space for building name

    zip: .float 0.0 #for zero case comparisonn

    EOF: .asciiz "DONE\n"   #check for end of file

    space: .asciiz " "  #adding a sapce

    newline: .asciiz "\n"   #newline

    building: .asciiz "Input buildinng name:"

    sqft: .asciiz "Input square footage:"

    electricity: .asciiz "Input electricity used per year:"

.text

#NOT MERGE SORT but sorting in place
#must compare, if same move on

main:
    li $t0, 0

_loop:

    #input building name prompts
    li $v0, 4
    la $a0, building 
    syscall

    #ask for buildings
    li $v0, 8
    la $a0, buffer
    li $a1, 64
    syscall

    la $t4, buffer
    la $t1, EOF

_DONE:

    lb $t3, ($t4)
    lb, $t2, ($t1)

    bne $t2, $t3, _next     #if not equal, then go to next
    beqz, $t3, _end     #if equal to 0, then end the loop

    addi $t4, $t4, 1
    addi $t1, $t1, 1    #space in address memory location
    j _DONE

_next:

    #input electricity wattage asking prompts
    li $v0, 4
    la $a0, sqft 
    syscall

    #ask for sqft
    li $v0, 6
    # la $a0, buffer
    # li $a0, 64 ##not buffers needed bc not string
    syscall
    mov.s $f1, $f0  #f1 = sqft
    
    l.s $f3, zip
    # c.eq.s $f1, $f3
    # bc1t _bruh

    #input the electricity prompt
    li $v0, 4
    la $a0, electricity
    syscall

    #get the sqft
    li $v0, 6
    syscall
    mov.s $f2, $f0     #f2 = sqft

    # #handle zero cases
    # l.s $f3, zip
    # c.eq.s $f1, $f3
    # bc1t _bruh
    l.s $f3, zip
    # c.eq.s $f1, $f3
    c.eq.s $f1, $f3
    bc1t _zero
    
    j _bruh

    # bnez, $f2, _zero
    # bnez, $f1, _zero
    
    #find efficiency

_zero:

    mov.s, $f11, $f3    #f11 = efficiency

    j _fixinf

_bruh:

    div.s $f11 $f2, $f1 #f11 is my efficiency

_fixinf:
    
    li $a0, 72
    li $v0, 9   #dynamic memory allocation
    syscall
    
    move $t6, $v0,
    la $t5, buffer

_addingbuildingname:  #character by character bc this assignment is horrid

    lb $t4, ($t5)  #loading in the buffer
    sb $t4, ($t6)
    addiu $t5, $t5, 1
    addiu $t6, $t6, 1
    bnez $t4, _addingbuildingname  #until there are no more chars

_makingtheNode:

    move $t6, $v0  #return value into t
    s.s $f11, 64($t6)    #efficiency at the end of the name?

    beq $t0, 0, _headCreation  #empty, so it is the first node

    move $t8, $t7

    l.s $f8, 64($t6)
    l.s $f9, 64($t8)    #loading in efficiencies

    c.lt.s $f9, $f8 #comparing efficiencies
    bc1t _begin #put at the start
    
    c.lt.s $f8, $f9
    bc1t _middle #put middle else

    j _same #or, they're the same!

_headCreation:

    addi $t0, 1
    li $t7, 0
    sw $t7, 68($t6)   #adding the whole new first node!
    move $t7, $t6

    j _loop #go back and then ask as regular
    
_begin: #moving it to the start
    
    sw $t7, 68($t6)
    move $t7, $t6
    j _loop


_middle: #it should just be middle
    lw $s0, 68($t8)
    l.s $f5, 64($t6)
    beq $s0, $zero, _anotherstep

_movePointer:
    l.s $f6, 64($s0)
    c.lt.s $f6, $f5
    bc1t _anotherstep
    c.eq.s $f5, $f6
    bc1t _same
    lw $t8, 68($t8)

    j _middle

#_null:

#     move $s1, $v0
#     j loop

_anotherstep:
    lw $t9, 68($t8)
    sw $t6, 68($t8)
    sw $t9, 68($t6)

    j _loop

_same:  #they are the same  #so lets compare letters
    move $s2, $t6
    move $s3, $s0

_comparison:    #comparing efficiencies

    lb $t3, ($s2)
    lb $t2, ($s3)

    bgt $t3, $t2, _more
    blt $t3, $t2, _less

    addiu $s2, $s2, 1
    addiu $s3, $s3, 1

    j _comparison

_more:
    lw $t8, 68($t8)
    j _middle

# last:
#     l.s $f7, 64($t0)
#     l.s $f8, 64($t2)
#     c.eq.s $f7, $f8
#     bc1t greater
#     loop7:
#     lb $t7, 0($t5)
#     lb $t8, 0($t6)
#     sgt $t9,$t7,$t8
#     bnez $t9, greater
#     slt $a3, $t7, $t8
#     bnez $a3, Exitaddnodeloop
#     addi $t5,$t5,1
#     addi $t6,$t6,1
#     j _comparison

_less:
    j _anotherstep


_end:
    beq $t0, $0, _return
    move $t9,$t7


# _words: #PRINT WHOLE STRINNG 
#     lb $t1, ($t9)
#     li $t4, 10
#     beq $t1, $t4, _numbs
#     li $v0, 11
#     move $a0, $t1
#     syscall
#     addi $t9, $t9, 1
#     j _words

_words: #PRINT WHOLE STRINNG 
    lb $t1, ($t9)
    li $t4, 10
    beq $t1, $t4, _numbs
    li $v0, 11
    move $a0, $t1
    syscall
    addi $t9, $t9, 1
    j _words


_numbs:
    li $v0, 4
    la $a0, space
    syscall

    l.s $f11, 64($t7)
    li $v0, 2
    mov.s $f12, $f11
    syscall

    lw $t1, 68($t7)
    beqz $t1, _return
    lw $t7, 68($t7)

    li $v0, 4
    la $a0, newline
    syscall

    j _end


_return:

    jr $ra

