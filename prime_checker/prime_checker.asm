section .data
    prompt db "Enter a number: ", 0
    msg_prime db "It is a prime number.", 0
    msg_not_prime db "It is not a prime number.", 0
    number db 0
    result db 0

section .text
    global _start

_start:
    ; طباعة الرسالة
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, prompt     ; الرسالة
    mov edx, 15         ; طول الرسالة
    int 0x80

    ; قراءة الرقم من المستخدم
    call read_number
    mov [number], al    ; تخزين الرقم المدخل

    ; التحقق مما إذا كان الرقم أوليًا
    mov al, [number]
    call is_prime

    ; عرض النتيجة
    cmp al, 1
    je print_prime
    jmp print_not_prime

print_prime:
    mov eax, 4
    mov ebx, 1
    mov ecx, number
    add byte [number], '0' ; تحويل الرقم إلى حرف
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_prime
    mov edx, 15
    int 0x80
    jmp exit

print_not_prime:
    mov eax, 4
    mov ebx, 1
    mov ecx, number
    add byte [number], '0' ; تحويل الرقم إلى حرف
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_not_prime
    mov edx, 20
    int 0x80

exit:
    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; حالة الخروج
    int 0x80

read_number:
    mov eax, 3          ; sys_read
    mov ebx, 0          ; stdin
    lea ecx, [number]   ; عنوان المخزن
    mov edx, 1          ; عدد البايتات
    int 0x80
    ret

is_prime:
    cmp al, 2
    jl not_prime        ; الأعداد < 2 ليست أولية
    cmp al, 2
    je is_prime_end     ; العدد 2 هو عدد أولي

    mov bl, 2           ; بدء القسمة من 2
check_loop:
    mov dl, 0           ; إعداد باقي القسمة
    mov cl, al          ; تحميل العدد
    xor ah, ah          ; إعداد ah للصفر
    div bl              ; القسمة
    cmp dl, 0          ; تحقق من باقي القسمة
    je not_prime        ; إذا كان باقي القسمة 0، العدد ليس أوليًا
    inc bl              ; زيادة القاسم
    cmp bl, al          ; تحقق مما إذا كان القاسم أكبر من العدد
    jl check_loop       ; إذا لم يكن، استمر في الحلقة

is_prime_end:
    mov al, 1           ; العدد أولي
    ret

not_prime:
    mov al, 0           ; العدد ليس أوليًا
    ret