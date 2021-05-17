#! /bin/bash/

## Installing compiler
tar -xf gcc-arm-none-eabi*.tar.bz2

## Installing the virtual machine environment
wget https://download.qemu.org/qemu-2.11.0.tar.xz
tar xvJf qemu-2.11.0.tar.xz && cd qemu-2.11.0
./configure --target-list=arm-softmmu,arm-linux-user
make -j 2 && sudo make install

## Compiles the scripts
./gcc-arm-none-eabi-*/bin/arm-none-eabi-gcc -mcpu=cortex-a7 -fpic -ffreestanding -c boot.S -o boot.o
./gcc-arm-none-eabi-*/bin/arm-none-eabi-gcc -mcpu=cortex-a7 -fpic -ffreestanding -std=gnu99 -c kernel.c -o kernel.o -O2 -Wall -Wextra
./gcc-arm-none-eabi-*/bin/arm-none-eabi-gcc -T linker.ld -o myos.elf -ffreestanding -O2 -nostdlib boot.o kernel.o

## To run bode in the VM environment
qemu-system-arm -m 256 -M raspi2 -serial stdio -kernel myos.elf
