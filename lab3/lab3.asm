global _start

section .bss
fib resq 20       ; Масив для 20 чисел Фібоначчі
i   resq 1        ; Лічильник

section .data
n       dq 10     ; Кількість чисел Фібоначчі
newline db 10     ; Символ нового рядка

section .text
_start:
    ; Ініціалізація перших двох чисел
    mov qword [fib], 0
    mov qword [fib+8], 1
    mov qword [i], 2

generate_fib:
    mov rax, [i]
    cmp rax, [n]
    jge print_fib

    mov rbx, rax
    dec rbx
    mov rdx, [fib + rbx*8]
    dec rbx
    add rdx, [fib + rbx*8]
    mov [fib + rax*8], rdx

    inc qword [i]
    jmp generate_fib

print_fib:
    xor rax, rax
    mov [i], rax

print_loop:
    mov rax, [i]
    cmp rax, [n]
    jge exit_program

    mov rdi, [fib + rax*8]
    call print_number

    ; Новий рядок
    mov rax, 1
    mov rdi, 1
    lea rsi, [newline]
    mov rdx, 1
    syscall

    inc qword [i]
    jmp print_loop

exit_program:
    mov rax, 60
    xor rdi, rdi
    syscall

;-----------------------------------
; Вивід числа в stdout
; Вхід: rdi = число
;-----------------------------------
print_number:
    mov rax, rdi        ; копіюємо число
    mov rcx, 10         ; дільник для ділення на 10
    lea rbx, [rsp+32]   ; буфер на стеку
    mov rsi, rbx        ; покажчик на поточну позицію
    add rsi, 32         ; починаємо з кінця буфера

convert_loop:
    xor rdx, rdx
    div rcx              ; rax / 10 -> rax, залишок в rdx
    dec rsi
    add dl, '0'          ; цифра в ASCII
    mov [rsi], dl
    test rax, rax
    jnz convert_loop

write_number:
    mov rdx, 32
    sub rdx, rsi         ; довжина рядка
    mov rax, 1           ; sys_write
    mov rdi, 1           ; stdout
    mov rdx, rdx         ; довжина
    mov rsi, rsi         ; адреса
    syscall
    ret


