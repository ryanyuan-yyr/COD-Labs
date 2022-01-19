    .data
out1:
    .word 0x400
out2:
    .word 0x408

    .text

    addi a1, zero, 1
    addi a2, zero, 4
    add a0, a1, a2
    
 loop:
    beq a0, zero, done
    addi t0, zero, 0x400
    sw a0, 0(t0)
    addi a0, a0, -1
    j loop
 done: