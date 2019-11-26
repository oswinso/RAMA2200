main:	  addi $t0, $zero, 0xDEAD
        addi $t1, $zero, 0x1DEAD
        sw $t0, 0($t1)
        halt
