/**************************************
 SuperH (SH-2) C Compiler Linker Script
 **************************************/ 

OUTPUT_FORMAT("elf32-sh")
OUTPUT_ARCH(sh)

/* ROM_SIZE was chosen based on the size of boot.bin */
ROM_BASE   = 0x00000000; /* 32kB @ 0x00000000 */
ROM_SIZE   = 0x00008000;

/* RAM_BASE chosen based on targets/boards/mimas_v2/board.h */
/* RAM_SIZE chosen based on mimas_v2 specs (64 MB SDRAM) */
RAM_BASE   = 0x10000000; /* 64MB @ 0x10000000 */
RAM_SIZE   = 0x04000000;

/* STACK_SIZE chosen based on typical requirements */
/* STACK_BASE chosen to be last word in SDRAM (stack grows down) */
STACK_SIZE = 0x00000400;
STACK_BASE = RAM_BASE + RAM_SIZE - 4;

MEMORY
{
    rom    : o = 0x00000000, l = 0x00008000 /* 32kB @ 0x00000000 */
    ram    : o = 0x10000000, l = 0x04000000 /* 64MB @ 0x10000000 */
}

SECTIONS                
{
.text : {
    *(.vect)
    *(.text)                
    *(.strings)
     _etext = . ; 
    }  > rom

.tors : {
    ___ctors = . ;
    *(.ctors)
    ___ctors_end = . ;
    ___dtors = . ;
    *(.dtors)
    ___dtors_end = . ;
    }  > rom

.rodata : {
    *(.rodata*)
    } > rom

.data : {
    _sdata = . ;
    *(.got)
    *(.got.*)
    *(.data)
    *(.data.*)
    _edata = . ;
    }  > ram

.bss : {
    _bss_start = .;
    *(.bss)
    *(COMMON)
    _end = .;
    }  >ram

    . = STACK_BASE;
    _stack = .;
}
