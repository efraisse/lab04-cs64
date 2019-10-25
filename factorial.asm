# Factorial.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
#

# Assembly version of:
#   int n, fn=1;
#   cout << "Enter the number:\n";
#   cin >> n;
#   for (int x = 2; x <= n; x++) {
#       fn = fn * x;
#   }
#   cout << "Factorial is:\n" << fn << "\n";
#
.data

phrase1: .asciiz "Enter the number:\n"
phrase2: .asciiz "Factorial is:\n"

#Text Area (i.e. instructions)
.text
main:

	li $v0, 4
    la $a0, phrase1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0
    li $t3, 1
    addi $t1, $t0, -1

    li $v0, 4
    la $a0, phrase2
    syscall
    ble, $t0, $t3, print1
    j loop

loop:
    mult $t0, $t1
    mflo $t0
    addi $t1, $t1, -1
    ble $t1, $t3, printFactorial
    j loop

printFactorial:
    li $v0, 1
    move $a0, $t0
    syscall
    j exit

print1:
    li $v0, 1
    move $a0, $t3
    syscall
    j exit
    
exit:
	# Exit
	li $v0, 10
	syscall
