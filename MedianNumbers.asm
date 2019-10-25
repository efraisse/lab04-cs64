# MedianNumbers.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
#

.data

# TODO: Complete these declarations / initializations

nextNum = .asciiz "Enter the next number:\n"

median = .asciiz "Median: "

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

    blt $t0, $t1, t0LessThan
    blt $t1, $t0, t1LessThan

t0LessThan:
    blt $t2, $t0, t0IsMedian
    blt $t0, $t2, t2IsMedian

t1LessThan:
    blt $t2, $t1, t1IsMedian
    blt $t1, $t2, t2IsMedian

t0IsMedian:
    li $v0, 4
    la $a0, median
    syscall
    
    li $v0, 1
    move $a0, $t0
    syscall
    J exit

t1IsMedian:

    li $v0, 4
    la $a0, median
    syscall
    
    li $v0, 1
    move $a0, $t1
    syscall
    J exit

t2IsMedian:

    li $v0, 4
    la $a0, median
    syscall
    
    li $v0, 1
    move $a0, $t2
    syscall
    J exit

    // if (t0 < t1) {
    //    if (t1 < t2) {
    //      cout << t1;
    //    }
    // } else if (t0 < t2) {
    //   if (t0 > t1) {
    //      cout << t0;
    //   }
    // } else {
    //   if (t2 < t1) 
    // }

exit:
	# Exit
	li $v0, 10
	syscall

