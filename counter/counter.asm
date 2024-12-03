section .data
    msg db "Counter: ", 0
    counter db 0

section .bss
    input resb 1

section .text
    global _start

_start:
    
    mov edx, 9
    mov ecx, msg
    mov ebx, 1
    mov eax, 4
    int 0x80

    
    call print_counter

read_input:
    
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 1
    int 0x80

    cmp byte [input], 'u'
    je increment
    cmp byte [input], 'd'
    je decrement
    jmp read_input

increment:
    inc byte [counter]
    jmp display_counter

decrement:
    dec byte [counter]
    jmp display_counter

display_counter:
    call print_counter
    jmp read_input

print_counter:
    
    movzx eax, byte [counter]
    add eax, '0'
    mov [msg + 9], al
    mov edx, 10
    mov ecx, msg
    mov ebx, 1
    mov eax, 4
    int 0x80
    ret

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80