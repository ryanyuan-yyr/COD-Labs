    .data
data:
    .word 0
subroutinemsg:
    .string "Current value of a1: "
msg:
    .align 2
    .string "END\n"

    .text
    la t0, data
    lw a0, 0(t0)
    
    li a7, 1
    ecall

    addi a0, a0, 1
    ecall

    li a1, 2
    add a0, a0, a1
    ecall

    sw a0, 0(t0)

    mv a1, a0

loop:
    beq a1, zero, end
    jal ra, subroutine
    addi a1, a1, -1
    j loop

subroutine:
    la a0, subroutinemsg
    li a7, 4
    ecall

    mv a0, a1
    li a7, 1
    ecall

    li a0, '\n'
    li a7, 11
    ecall

    ret 

end:
