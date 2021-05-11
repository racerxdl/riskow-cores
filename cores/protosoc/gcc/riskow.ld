/* Thanks https://github.com/darklife/darkriscv */

__heap_size     = 0x200;    /* required amount of heap  */
__stack_size    = 0x800;    /* required amount of stack */

MEMORY
{
    ROM         (rwx) : ORIGIN = 0x00000000, LENGTH = 0x10000
    RAM         (rwx) : ORIGIN = 0x00010000, LENGTH = 0x08000
    RESERVED    (rwx) : ORIGIN = 0x00018000, LENGTH = 0xF0000
    IO          (rw)  : ORIGIN = 0xF0000000, LENGTH = 0x00010
    TIMER0      (rw)  : ORIGIN = 0xF1000000, LENGTH = 0x00010
    SPI         (rw)  : ORIGIN = 0xF2000000, LENGTH = 0x00010
    UART        (rw)  : ORIGIN = 0xF3000000, LENGTH = 0x00100
}
SECTIONS
{
    .text :
    {
        *(.boot)
        *(.text)
        *(.text)
        *(.rodata*)
    } > ROM
    .data :
    {
        *(.sbss)
        *(.data)
        *(.bss)
        *(.rela*)
        *(COMMON)
    } > RAM

    .heap :
    {
        . = ALIGN(4);
        PROVIDE ( end = . );
        _sheap = .;
        . = . + __heap_size;
        . = ALIGN(4);
        _eheap = .;
    } >RAM


    .stack :
    {
        . = ALIGN(4);
        _estack = .;
        . = . + __stack_size;
        . = ALIGN(4);
        _sstack = .;
    } >RAM
}
