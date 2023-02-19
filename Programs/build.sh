# Build SiFive binaries
export TOOLCHAIN_PATH=/opt/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/bin

GCC=$TOOLCHAIN_PATH/riscv64-unknown-elf-gcc
LD=$TOOLCHAIN_PATH/riscv64-unknown-elf-ld
OBJCOPY=$TOOLCHAIN_PATH/riscv64-unknown-elf-objcopy
OBJDUMP=$TOOLCHAIN_PATH/riscv64-unknown-elf-objdump
AS=$TOOLCHAIN_PATH/riscv64-unknown-elf-as

# Binary has extra attribute arch "rv32i2p0_m2p0_a2p0" for example

# Build ELF (no c, no compression)
$AS count.S -o count.o -march=rv32ima -mabi=ilp32
$LD -march=rv32imac -mabi=ilp32 -o count.elf -T count.ld -m elf32lriscv -nostdlib --no-relax

# Disassemble
$OBJDUMP -S --disassemble count.elf > count.disasm

# Hex and Bin
$OBJCOPY -O ihex count.elf count.mem
$OBJCOPY -O binary count.elf count.bin