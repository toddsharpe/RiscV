.align 4

.text
_boot:
    li t0, 0    # Current count
    li t1, 4096 # Max count
    li t2, 1024 # GPIO Base

loop:
    add t0, t0, 1
    sw t0, 0(t2) # Send value to display
    #NOTE: not working
    #sw t0, 4(t2) # Send value to leds
    bne t0, t1, loop
    ebreak
