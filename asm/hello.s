.text
.global _start
_start:
mov x0, #1
ldr x1, =message
ldr x2, =len
mov w8, #64
svc #0

mov x7, #0
mov w8, #93
svc #0


.data
message:
.ascii "hello world\n"
len = .-message


