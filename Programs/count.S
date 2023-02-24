.align 4
.text

_boot:
    li x1, 0
    li x2, 512
#    li x3, 1024
    lw x3, GpioBase
loop:
    add x1, x1, 1
    sw x1, 0(x3)
    bne x1, x2, loop
    ebreak
GpioBase:
    .word 1024
