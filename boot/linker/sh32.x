/**************************************
 SuperH (SH-2) C Compiler Linker Script
 **************************************/

/* OUTPUT_FORMAT("elf32-sh") */
OUTPUT_FORMAT("elf32-shbig-linux")
OUTPUT_ARCH(sh)

SRAM_BASE  = 0x00000000; /* 32kB @ 0x00000000 */
SRAM_SIZE  = 0x00008000;

DRAM_BASE   = 0x01000000; /* 64MB @ 0x01000000 */
DRAM_SIZE   = 0x04000000;

/* STACK_SIZE chosen based on typical requirements */
/* STACK_BASE chosen to be last word in SDRAM (stack grows down) */
STACK_SIZE = 0x00000400;
STACK_BASE = SRAM_BASE + SRAM_SIZE - 4;

MEMORY
{
    sram (rw) : o = 0x00000000, l = 0x00008000 /* 32kB @ 0x00000000 */
    dram (rw) : o = 0x01000000, l = 0x04000000 /* 64MB @ 0x01000000 */
}

SECTIONS
{
.text : {
    *(.vect)
    *(.text)
    *(.strings)
     _etext = . ;
    } > sram

.tors : {
    ___ctors = . ;
    *(.ctors)
    ___ctors_end = . ;
    ___dtors = . ;
    *(.dtors)
    ___dtors_end = . ;
    } > sram

.rodata : {
    *(.rodata*)
    } > sram

.data : {
    _sdata = . ;
    *(.got)
    *(.got.*)
    *(.data)
    *(.data.*)
    _edata = . ;
    } > sram

.bss : {
    _bss_start = .;
    *(.bss)
    *(COMMON)
    _end = .;
    } > sram

stack : {
	ASSERT( ( . < STACK_BASE ), "boot rom has overflowed SRAM" );
	_stack = .;
    *(.stack)
    } > sram
}
