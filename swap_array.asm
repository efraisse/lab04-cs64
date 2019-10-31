# swap_array.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
#

.data
# Data Area.  Note that while this is typically only
# For global immutable data, for SPIM, this also includes
# mutable data.        

incorrect:  .asciiz "---TEST FAILED---\n"
before:     .asciiz "Before:\n"
after:      .asciiz "After:\n"
comma:      .asciiz ", "
newline:    .asciiz "\n"
        
expectedMyArray:
        .word 29 28 27 26 25 24 23 22 21
myArray:
        .word 21 22 23 24 25 26 27 28 29

.text
# Print everything in the array (without use of a loop)
# Used as a function/sub-routine

printArray:
        la $t0, myArray

        li $v0, 1
        lw $a0, 0($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall
        
        li $v0, 1
        lw $a0, 4($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 8($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 12($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 16($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 20($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 24($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 28($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 32($t0)
        syscall
        li $v0, 4
        la $a0, newline
        syscall

        jr $ra
        
# unsigned int* p1 = expectedMyArray
# unsigned int* p2 = myArray
# unsigned int* limit = expectedMyArray + 9
#
# while (p1 < limit) {
#   if (*p1 != *p2) {
#     return 0                  
#   }
#   p1++                        
#   p2++
# }
# return 1                      

checkArrays:
        # $t0: p1
        # $t1: p2
        # $t2: limit
        
        la $t0, expectedMyArray
        la $t1, myArray
        addiu $t2, $t0, 36

checkArrays_loop:
        slt $t3, $t0, $t2
        beq $t3, $zero, checkArrays_exit

        lw $t4, 0($t0)
        lw $t5, 0($t1)
        bne $t4, $t5, checkArrays_nonequal
        addiu $t0, $t0, 4
        addiu $t1, $t1, 4
        j checkArrays_loop
        
checkArrays_nonequal:
        li $v0, 0
        jr $ra
        
checkArrays_exit:
        li $v0, 1
        jr $ra
        
main:   
        # Print array "before"
        la $a0, before
        li $v0, 4
        syscall

        jal printArray
        
        # Do swap function 
        jal doSwap

        # Print array "after"
        la $a0, after
        li $v0, 4
        syscall
        
        jal printArray

        # Perform check on array
        jal checkArrays
        beq $v0, $zero, main_failed
        j main_exit
        
main_failed:
        la $a0, incorrect
        li $v0, 4
        syscall
        
main_exit:      
        li $v0, 10
        syscall

        
# COPYFROMHERE - DO NOT REMOVE THIS LINE

doSwap:
        # TODO: translate the following C code into MIPS
        # assembly here.
        # Use only regs $v0-$v1, $t0-$t7, $a0-$a3.
        # You may assume nothing about their starting values.
        #
        #
        # unsigned int x = 0
        # unsigned int y = 8
        #
        # while (x != 4) {
        #   int temp = myArray[x]
        #   myArray[x] = myArray[y]
        #   myArray[y] = temp
        #   x++
        #   y--
        # }

        # TODO: fill in the code
        
        li $t0, 0 #variable x which will keep track of the loop
        la $t1, myArray #loading address of first element of myArray into $t3
        
whileloop:
        li $t2, 4 #amount of times x has to loop before exiting
        beq $t0, $t2, exit #if x has looped enough times then exit the loop
        sll $t3, $t0, 2 #shift x by 4 in order to obtain the appropriate address for the location of the element
        add $t4, $t1, $t3 #shift index to the right to obtain the next value in memory (this is x from the c++ program)
        sub $t5, $t1, $t3 #shift index to the left to obtain the next value in memory (this is y from the c++ program)

        lw $t2, 0($t4) #this entire portion: load the words from memory and then store them in the other address, no temporary variable
        lw $t6, 32($t5) #needs to be assigned in order to swap x and y
        sw $t6, 0($t4) 
        sw $t2, 32($t5) 

        addiu $t0, $t0, 1 #increment x by 1 at the end of the loop       
        j whileloop #jump back to the top to loop again
exit:
        jr $ra
