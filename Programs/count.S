.align 4
.text

_boot:
    add x1, x0, x0
    addi x2, x0, 32
loop:
    bne x1, x2, loop
    ebreak
