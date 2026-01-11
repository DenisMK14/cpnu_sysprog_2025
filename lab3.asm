global _start

section .text
_start:
    ; sys_write(stdout, message, len)
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, message    ; адреса рядка
    mov rdx, message_len ; довжина рядка
    syscall

    ; sys_exit(0)
    mov rax, 60         ; syscall: exit
    xor rdi, rdi
    syscall

section .data
message db "KI-242 Knyr", 10
message_len equ $ - message

