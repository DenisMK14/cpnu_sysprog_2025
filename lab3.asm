global _start

section .data
    msg db "Group: KI-221", 10
    len equ $ - msg

section .text
_start:
    ; Виведення тексту
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, len
    syscall

    ; Завершення програми
    mov rax, 60
    xor rdi, rdi
    syscall
