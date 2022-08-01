;0x00501=0x01
;0x00502=0x02
;0x00503=0x03
;0x00504=0x04

jmp near Code

Data:
	db 0xAA,0x11,0x22,0x33,0x44

Code:
	mov ax,0x0050
	mov es,ax	;目标地址段寄存器初始化
	mov di,0	;目标地址偏移寄存器初始化

	mov ax,0x07C0	
	mov ds,ax	;原始地址段寄存器初始化
	mov si,Data	;原始地址偏移寄存器初始化

	movsb		;每一次移动的时候si di自动加一
	movsb		;但是注意一次只能移动一个字节的数字
	movsb		;这种移动方法是从低地址向高地址移动
	movsb
	movsb
End:
	jmp near End
	times 510-($-$$) db 0x00
	db 0x55,0xAA