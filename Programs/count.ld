MEMORY
{
   BRAM (RWX) : ORIGIN = 0x0000, LENGTH = 0x200  /* 512B RAM */
}
SECTIONS
{
    everything :
    {
    . = ALIGN(4);
    ../build/fpga/count.o (.text)
        *(.*)
    } >BRAM
}
