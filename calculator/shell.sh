#!/usr/bin/bash
nasm -f elf32 calculator.asm -o calculator.o
ld -m elf_i386 -s -o calculator calculator.o
./calculator