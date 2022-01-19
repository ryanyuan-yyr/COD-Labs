.data
    prompt1: .string "Input f1: \n"
    prompt2: .string "Input f0: \n"
    msg1: .string "Fibonacci "
    msg2: .string ": "

.text

# get f1 and f2

    li a7, 4
    la a0, prompt1
    ecall

    li a7, 5
    ecall
    mv t0, a0

    li a7, 4
    la a0, prompt2
    ecall

    li a7, 5
    ecall
    mv t1, a0

# t4 is the index of current number 
    li t4, 3

calculate:
    
# output 'Fibonacci n: '
    li a7, 4
    la a0, msg1
    ecall

    li a7, 1
    mv a0, t4
    ecall

    li a7, 4
    la a0, msg2
    ecall

# output next item
    li a7, 1
    add a0, t0, t1
    ecall

    mv t0, t1
    mv t1, a0

# wait for keyboard input to continue
    li a7, 12
    ecall
    addi t4, t4, 1
    j calculate
