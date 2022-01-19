out1:
sw a1, 0x408(x0)
jalr x0, x0, 0

char_to_uart:
sw a1, 0x40c(x0)
jalr x0, x0, 0

str_to_uart:
sw a1, 0x330(x0)
sw t0, 0x334(x0)
str_next_char:
lw t0, (a1)
beq t0, zero, str_to_uart_exit
sw t0, 0x40c(x0)
addi, a1, a1, 4
j str_next_char
str_to_uart_exit:
lw a1, 0x330(x0)
lw t0, 0x334(x0)
jalr x0, x0, 0

get_valid:
polling:
sw t0, 0x330(x0)
lw a1, 0x414(x0)
beq a1, zero polling
lw a1, 0x410
polling_for_exit:
lw t0, 0x414(x0)
beq t0, x0, exit
j polling_for_exit
exit:
lw t0, 0x330(x0)
jalr x0, x0, 0
