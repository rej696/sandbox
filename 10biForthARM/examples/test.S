.extern _start
.extern putchar

.section .text
.global execute
execute:
    mov r1, #0xBA
    push {r1}
    bl putchar
    mov r1, #0xBE
    push {r1}
    bl putchar
    mov r1, #0xCA
    push {r1}
    bl putchar
    mov r1, #0xFE
    push {r1}
    bl putchar
    ldr lr, =_start
    bx lr
