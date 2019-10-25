# MedianNumbers.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
#

.data

# TODO: Complete these declarations / initializations

nextNum: .asciiz "Enter the next number:\n"

med: .asciiz "Median: "

#Text Area (i.e. instructions)
.text

main:

    li $v0, 4
    la $a0,nextNum
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 4
    la $a0,nextNum
    syscall

    li $v0, 5
    syscall
    move $t1, $v0

    li $v0, 4
    la $a0,nextNum
    syscall

    li $v0, 5
    syscall
    move $t2, $v0

    blt $t0, $t1, t1GreaterThan
    blt $t1, $t0, t0GreaterThan

t1GreaterThan:
    blt $t1, $t2, t1IsMedian
    blt $t2, $t0, t0IsMedian
    blt $t0, $t2, t2IsMedian

t0GreaterThan:
    blt $t0, $t2, t0IsMedian
    blt $t2, $t1, t1IsMedian
    blt $t1, $t2, t2IsMedian

t0IsMedian:
    li $v0, 4
    la $a0, med
    syscall
    
    li $v0, 1
    move $a0, $t0
    syscall
    j exit

t1IsMedian:

    li $v0, 4
    la $a0, med
    syscall
    
    li $v0, 1
    move $a0, $t1
    syscall
    j exit

t2IsMedian:

    li $v0, 4
    la $a0, med
    syscall
    
    li $v0, 1
    move $a0, $t2
    syscall
    j exit

exit:
	# Exit
	li $v0, 10
	syscall

