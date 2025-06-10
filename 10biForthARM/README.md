# ARM port of [10biForth](https://git.sr.ht/~hocwp/10biForthOS)

Make sure you have@
- arm-none-eabi toolchain
- qemu-system-arm

## Usage
The port is located in forth.S, and is built with placeholder.S, which provides a stub for the location `execute` where code is loaded

Run the forth in qemu with `make run`

To send programs to the forth, run qemu with a tcp server using `make tcp`

Then, run `make send` to send the default example program. Specify an assembly file using `make PROG=examples/add send`

You can trigger the forth to jump to the loaded code with `make trigger`

In qemu, you can use commands `xp /16xw 0x18fc0` to view the stack, `xp /16xw 0x1007c` to view the memory section where the program is loaded, and `info registers` to view the state of the registers.
