.equ UART_BASE, 0x101f1000
.equ UART_DR, 0x00 /* data register */
.equ UART_FR, 0x18 /* flag register */
.equ RXFE, 0x10  /* bit 4 receive fifo empty */
.equ TXFF, 0x20  /* bit 5 transmit fifo full */

.global _Reset
_Reset:
    ldr sp, =_estack /* stack top defined in link step */
    bl _start

.global _start
_start:
    ldr r4, =execute

loop:
    bl getchar

    cmp r0, #0
    bne skip
    mov r0, #1
    bl execute

skip:
    cmp r0, #1
    beq compile

    b loop

compile:
    bl getchar
    mov r1, r0
    bl putchar
    strb r0, [r4], #1
    b loop

getchar:
    ldr r1, =UART_BASE
wait_rx:
    ldr r2, [r1, #UART_FR]
    tst r2, #RXFE
    bne wait_rx

    ldrb r0, [r1, #UART_DR]
    bx lr

.global putchar
putchar:
    ldr r2, =UART_BASE
wait_tx:
    ldr r3, [r2, #UART_FR]
    tst r3, #TXFF
    bne wait_tx
    strb r1, [r2, #UART_DR]
    bx lr
