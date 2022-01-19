# t0: F(n)
# t1: F(n+1)

addi a0, zero, 3
ecall
addi t0, a1, 0
addi a0, zero 0
ecall

addi a0, zero, 3
ecall
addi t1, a1, 0
addi a0, zero, 0
ecall

loop:
addi a0, zero, 3
ecall
add t2, t0, zero
add t0, t1, zero
add t1, t1, t2
addi a0, zero, 0
add a1, t1, zero
ecall
j loop
