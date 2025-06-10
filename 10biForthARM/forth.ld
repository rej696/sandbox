ENTRY(_Reset)
SECTIONS
{
    . = 0x10000;
    .forth . : { build/forth.o(.text) }
    .text : {
        *(*.text)
    }
    .data : {
        *(*.data)
    }
    .bss : {
        *(*.bss COMMON)
    }
    . = 0x18000; /* hardcode stack location */
    . = . + 0x1000; /* 4kb of stack memory */
    _estack = .;
}
