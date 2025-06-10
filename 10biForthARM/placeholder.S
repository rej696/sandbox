.extern _start

.section .text
.global execute
execute:
    ldr r3, =_start
    bx r3
