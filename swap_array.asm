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
        
        li $t0, 36 #index of last element in myarray
        li $t1, 0 #index of first element in myarray
        la $t3, myArray #the address of the first element in my array
        j whileloop
        
        
whileloop:
        #$t6 stores the address of myArray[x]
        #$t7 stores the address of myArray[y]
        #it make sense to subtract values from $t3 because the stack addresses moves from high values to low values
        subu $t6, $t3, $t1 #t6 contains the address of the first element, subtracting 0 -> points to first element
        subu $t7, $t3, $t0 #t7 contains the address of the last element, subtracting 36 -> points to last element
        
        lw $t4, 0($t6) #$t4 now contains the first element of my array
        lw $t5, 0($t7) #$t5 now contains the last element of my array
        
        #here a swap using registers is not necessary because I can just simply keep the values of 
        #$t4 and $t5 that I got from memory and change their location
        sw $t5, 0($t6) #saving value of $t5 which represents the last element in the spot of the first
        sw $t4, 0($t7) #saving value of $t4 which represents the first element in the spot of the last
        
        #$t0 and $t1 here represent the array indexes so I'm doing x++ and y-- here
        #I'm subtracting and adding 4 because MIPS is a 32 bit machine and addresses move by 4 bytes in memory
        subu $t0, $t0, 4 #subtracting 4 from $t0 to obtain the second to last element in the array
        addiu $t1, $t1, 4 #adding 4 to $t1 to obtain the second element in the array
        
        blt, $t0, $t1, whileloop #when register t0 becomes less than t1, I know what they have passed the middle
        #of the array, therefore, I use blt to find out when $t0 is less than $t1 is true to jump back to main
        #using jr $ra and evaluate my answer as the rest of the program runs 
        
        # do not remove this last line
        jr $ra
