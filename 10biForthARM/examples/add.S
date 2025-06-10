.extern _start
.extern putchar

.section .text
.global execute
execute:
    mov r1, #0xA5
    bl putchar
    ldr r1, =0xDEAD0000
    ldr r2, =0x0000BEEF
    add r1, r1, r2
    push {r1}
    bl putchar
    str r1, [r3]
    ldr r3, =_start
    bx r3
