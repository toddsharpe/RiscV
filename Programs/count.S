.align 4
.text

_boot:
    li x1, 0
    li x2, 32
loop:
    add x1, x1, 1
    bne x1, x2, loop
    ebreak
