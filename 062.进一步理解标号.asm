section Mbr vstart=0x7C00
;用这种方式使得下面的段的首地址被修改为0x7C00
jmp near Code

Data:
	db 0x11,0x22,0x33

Code:
;定位内存地址方式③
	;默认情况下ds寄存器会被初始化为0
	mov al,byte[ds:Data+0];ds:0x0000,偏移地址0x7C03   0x0000+x7C03=0x07C03
	mov al,byte[ds:Data+1]
	mov al,byte[ds:Data+2]

jmp $
times 510-($-$$) db 0x00
db 0xAA55

