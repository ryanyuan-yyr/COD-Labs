addi a0, zero, 2
addi a1, zero, 0
ecall

init:
addi t0, zero, 1
next_cyc:
addi t1, zero, 1024
sw t0, 0x400(zero)
add t0, t0, t0
beq t0, zero, init
wait:
beq t1, zero, next_cyc
addi t1, t1, -1
j wait