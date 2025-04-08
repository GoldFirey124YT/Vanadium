CC=i686-elf-gcc
AS=nasm
LD=i686-elf-ld
CFLAGS=-ffreestanding -O2 -Wall -Wextra
LDFLAGS=-T linker.ld

all: os-image.bin

bootloader.bin: bootloader/boot.asm
	$(AS) -f bin bootloader/boot.asm -o $@

kernel.o: kernel/main.c kernel/gdt.c
	$(CC) $(CFLAGS) -c kernel/main.c -o main.o
	$(CC) $(CFLAGS) -c kernel/gdt.c -o gdt.o

kernel.bin: kernel.o
	$(LD) $(LDFLAGS) -o $@ main.o gdt.o

os-image.bin: bootloader.bin kernel.bin
	cat bootloader.bin kernel.bin > $@

run: os-image.bin
	qemu-system-i386 -drive format=raw,file=os-image.bin

clean:
	rm -f *.o *.bin
