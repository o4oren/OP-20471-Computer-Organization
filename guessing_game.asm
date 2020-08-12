# Guessing game
.data
	guess_string:	.asciiz	"I picked a random number. Can you guess it?!\n"
	high_string:	.asciiz	"Too high, guess again!\n"
	low_string:	.asciiz	"Too low, guess again!\n"
	right_string:	.asciiz	"You nailed it! Game over.\n"

.text 
main:    
generate_radnom:  
	li $a1, 101 		# set range for 0-100
	li $v0, 42   		# Generate random number syscall
	syscall
	move $s0, $a0 		# keep the number in $s0

print_rand:	# li $v0, 1 # prepare syscall to print integer
		# move $a0, $s0 #copy t0 to a0
		# syscall

start_game:
        li $v0, 4
        la $a0, guess_string 	#load the string into $a0 (that's what the syscall will use)
        syscall	
        j get_input
	
too_high:       
	li $v0, 4		#print too high string
        la $a0, high_string 
        syscall	
        j get_input

too_low:        
	li $v0, 4
        la $a0, low_string 	#print too high string
        syscall	
        j get_input
        	
get_input:	
	li $v0, 5		#read user input, store int in $v0
	syscall
		
compare:
	slt $t1,$s0,$v0      	# checks if $generated number < $input number, puts 1 in $t1 if so
	beq $t1, 1, too_high	# branch to too_high if the random number is less than the guessed number
		
	slt $t1, $v0, $s0	# checks if $t0 < $s0, puts 1 in $t1 if 
	beq $t1, 1, too_low	# branch to too_high if the random number is less than the guessed number
		
	li $v0, 4
        la $a0, right_string 	# load the string into $a0 (that's what the syscall will use)
        syscall	
		
	li $v0, 10	
	syscall
