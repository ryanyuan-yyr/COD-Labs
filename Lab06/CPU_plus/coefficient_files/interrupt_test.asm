addi x1, x0, 0x1
addi x2, x0, 0x400
loop: sw x1, (x2)
addi x1, x1, 1
j loop