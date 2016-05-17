/**************************************
 SuperH (SH-2) C Compiler Linker Script
 **************************************/ 

OUTPUT_FORMAT("elf32-sh")
OUTPUT_ARCH(sh)



MEMORY
{
    rom    : o = 0x00000000, l = 0x00008000 /* 32kB @ 0x00000000 */
	ram    : o = 0x10000000, l = 0x04000000 /* 64MB @ 0x10000000 */
}

SECTIONS 				
{
.text :	{
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

__idata_start = ADDR(.text) + SIZEOF(.text) + SIZEOF(.tors) + SIZEOF(.rodata); 
.data : AT(__idata_start) {
	__idata_start = .;
        _sdata = . ;
	*(.got)
	*(.got.*)
	*(.data)
	*(.data.*)
	_edata = . ;
	}  > ram
__idata_end = __idata_start + SIZEOF(.data);

.bss : {
	_bss_start = .;
	*(.bss)
	*(COMMON)
	_end = .;
	}  >ram
	. = . + STACK_SIZE
	_stack = .;

/*
.stack :
	{
	_stack = .;
	*(.stack)
	} > stack
*/
}
