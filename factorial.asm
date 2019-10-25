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

	# TODO: Write your initializations here

#Text Area (i.e. instructions)
.text
main:

	# TODO: Write your code here

exit:
	# Exit
	li $v0, 10
	syscall
