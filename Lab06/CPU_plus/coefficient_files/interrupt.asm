sw x0, 0x420(zero)
sw t0, 0xFC(zero)
lw t0, 0x410(zero)
sw t0, 0x408(zero)
addi t0 x0, 1
sw t0, 0x420(zero)
lw t0, 0xFC(zero)
jalr x0, x0, 0
