# MedianNumbers.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
#

.data

	# TODO: Complete these declarations / initializations

	.asciiz "Enter the next number:\n"

	.asciiz "Median: "


#Text Area (i.e. instructions)
.text

main:

	# TODO: Write your code here

exit:
	# Exit
	li $v0, 10
	syscall

