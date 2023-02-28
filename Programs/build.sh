# Create directories
mkdir -p ../build/fpga
OUTPUT_DIR=../build/fpga

# Build SiFive binaries
export TOOLCHAIN_PATH=/opt/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/bin

GCC=$TOOLCHAIN_PATH/riscv64-unknown-elf-gcc
LD=$TOOLCHAIN_PATH/riscv64-unknown-elf-ld
OBJCOPY=$TOOLCHAIN_PATH/riscv64-unknown-elf-objcopy
OBJDUMP=$TOOLCHAIN_PATH/riscv64-unknown-elf-objdump
AS=$TOOLCHAIN_PATH/riscv64-unknown-elf-as

# Binary has extra attribute arch "rv32i2p0_m2p0_a2p0" for example

# Build ELF (no c, no compression)
$AS count.S -o $OUTPUT_DIR/count.o -march=rv32ima -mabi=ilp32
$LD $OUTPUT_DIR/count.o -march=rv32imac -mabi=ilp32 -o $OUTPUT_DIR/count.elf -T count.ld -m elf32lriscv -nostdlib --no-relax

# Disassemble
$OBJDUMP -S --disassemble $OUTPUT_DIR/count.elf > $OUTPUT_DIR/count.disasm

# Hex and Bin
#$OBJCOPY -O ihex count.elf count.mem
$OBJCOPY -O binary $OUTPUT_DIR/count.elf $OUTPUT_DIR/count.bin
hexdump -e '"%08x\n"' $OUTPUT_DIR/count.bin > $OUTPUT_DIR/count.mem