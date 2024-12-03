section .data
    prompt1 db "Enter first number: ", 0
    prompt2 db "Enter last number: ", 0
    prompt_op db "Enter operation (+ , -): ", 0
    result_msg db "Result: ", 0
    buffer db 10, 0
    num1 db 0
    num2 db 0
    op db 0

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt1
    mov edx, 20
    int 0x80

    call read_number
    mov [num1], al

    
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, 20
    int 0x80

    call read_number
    mov [num2], al

    
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_op
    mov edx, 30
    int 0x80

    call read_operator
    mov [op], al

    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'

    cmp byte [op], '+'
    je addition
    cmp byte [op], '-'
    je subtraction

addition:
    add al, bl
    jmp display_result

subtraction:
    sub al, bl

display_result:
    add al, '0'
    mov [result_msg + 10], al

    
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 20
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80

read_number:
    mov eax, 3
    mov ebx, 0
    lea ecx, [buffer]
    mov edx, 10
    int 0x80
    mov al, [buffer]
    ret

read_operator:
    mov eax, 3
    mov ebx, 0
    lea ecx, [buffer]
    mov edx, 1
    int 0x80
    mov al, [buffer]
    ret