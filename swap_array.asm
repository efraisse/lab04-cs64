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
        
        li $t0, 32 #first element in myarray index
        li $t1, 0 #last element in myarray index
        la $t3, myArray
        j whileloop

whileloop:
        #$t2 stores x
        #$t4 stores the address of myArray[x]
        #$t5 stores the address of myArray[y]
        #$t6 stores the temp variable required for the switch
        addu $t6, $t3, $t0 #$t6 contains the address of the first element
        addu $t7, $t3, $t1 #$t7 contains the address of the last element
        lw $t4, 0($t6) #$t4 now contains the first element of my array
        lw $t5, 0($t7) #$t5 now contains the last element of my array

        #im doing the swap over here
        addiu $t2, $t4, 0
        li $t4, 0
        addu $t4, $t4, $t5
        li $t5, 0
        addu $t5, $t5, $t2
        
        sw $t4, 0($t6) #saving value of $t4 into memory
        sw $t5, 0($t7) #saving value of $t5 into memory

        #$t0 and $t1 here represent the array indexes so i'm doing x++ and y-- here
        addiu $t1, $t1, 4
        subu $t0, $t0, 4
        
        ble, $t6, $t7, whileloop 

        # do not remove this last line
        jr $ra
