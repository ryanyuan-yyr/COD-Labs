.text
    lw      x9, 0(x0)       #get io base address
ready1:
    lw      x6, 16(x9)      #read valid
    beq     x6, x0, ready1  #if valid==1 then read data1
    lw      x1, 12(x9)      #read data_in
    sw      x1, 8(x9)       #display f1
wating1:    
    lw      x6, 16(x9)      #read valid
    beq     x6, x0, ready2  #if valid==0 then data1 read done
    jal     x8, wating1
ready2: 
    lw      x6, 16(x9)      #read valid
    beq     x6, x0, ready2
    lw      x2, 12(x9)      #read data_in
    sw      x2, 8(x9)       #display f2
wating2:    
    lw      x6, 16(x9)      #read valid
    beq     x6, x0, fib	    #if valid==0 then data1 read done
    jal     x8, wating2
fib:
    add     x7, x1,x2
    add     x1, x2,x0
    add     x2, x7,x0
ready3:
    lw      x6, 16(x9)      #read valid
    beq     x6, x0, ready3
    sw      x7, 8(x9)       #display fn
wating3:
    lw      x6, 16(x9)
    beq     x6, x0, fib
    jal     x8, wating3
.data
    0x400
