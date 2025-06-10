.extern _start

.section .text
.global execute
execute:
    /* bx lr */
    ldr r3, =_start
    bx r3
