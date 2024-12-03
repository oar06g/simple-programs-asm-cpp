#!/usr/bin/bash

nasm -f elf32 counter.asm -o counter.o
ld -m elf_i386 -s -o counter counter.o
./counter