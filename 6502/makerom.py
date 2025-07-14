import sys


def makerom() -> bytearray:
    code = bytearray([
        0xa9, 0xff,  # lda #$ff
        0x8d, 0x02, 0x60, # sta $6002

        0xa9, 0x55,  # lda #$55
        0x8d, 0x00, 0x60, # sta $6002

        0xa9, 0xaa,  # lda #$aa
        0x8d, 0x00, 0x60, # sta $6002

        0x4c, 0x05, 0x80, #jmp $8005

    ])
    rom = code + bytearray([0xea] * (32768 - len(code)))

    rom[0x7ffc] = 0x00
    rom[0x7ffd] = 0x80

    return rom


if __name__ == "__main__":
    if len(sys.argv) > 2:
        sys.exit(-1)
    elif len(sys.argv) == 2:
        output_file = sys.argv[1]
    else:
        output_file = "build/rom.bin"

    rom = makerom()

    with open(output_file, "wb") as f:
        f.write(rom)
