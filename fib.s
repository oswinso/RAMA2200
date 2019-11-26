!============================================================
! CS 2200 Homework 2 Part 2: fib
!
! Apart from initializing the stack,
! please do not edit main's functionality.
!============================================================

main:
    lea     $sp, stack          ! load ADDRESS of stack label into $sp

    lw $sp, 0($sp)

    lea     $at, fib            ! load address of fib label into $at
    
    addi    $s2, $zero, 0x1DEAD         ! Store address of SSEG in $s2

    addi    $a0, $zero, 12       ! $a0 = 5, the number a to compute fib(n)
    jalr    $ra, $at            ! jump to fib, set $ra to return addr
    halt   


	! globl	fib                     ! -- Begin function fib
fib:                                    ! @fib
! %bb.0:                                ! %entry
	addi	$sp, $sp, -3
	sw	$s0, 1($sp)
	sw	$s1, 0($sp)
	sw	$fp, 2($sp)
	add	$fp, $sp, $zero
	add	$s0, $a0, $zero
	addi	$at, $zero, 1
	skplt	$at, $s0
	goto	1
	goto	_lBB0_3
! %bb.1:                                ! %if.then
	skpe	$s0, $at
	goto	1
	goto	2
	add	$v0, $zero, $zero
	goto	1
	add	$v0, $zero, $at
	nand	$at, $v0, $at
	nand	$v0, $at, $at
	goto	_lBB0_2
_lBB0_3:                                ! %if.else
		
	addi	$a0, $s0, -1
	addi	$sp, $sp, -1
	sw	$ra, 0($sp)
	lea	$at, fib
	jalr	$ra, $at
	lw	$ra, 0($sp)
	addi	$sp, $sp, 1
		
	add	$s1, $v0, $zero
		
	addi	$a0, $s0, -2
	addi	$sp, $sp, -1
	sw	$ra, 0($sp)
	lea	$at, fib
	jalr	$ra, $at
	lw	$ra, 0($sp)
	addi	$sp, $sp, 1
		
	add	$v0, $v0, $s1
_lBB0_2:                                ! %if.then
	lw	$fp, 2($fp)
	lw	$s1, 0($sp)
	lw	$s0, 1($sp)
	addi	$sp, $sp, 3
  sw  $v0, 0($s2)   ! Output result in SSEG
	jalr	$zero, $ra
                                        ! -- End function

stack: .word 0xFFFF
