jmp near Code 
Data:
	db 0xAA,0x11,0x22,0x33,0x44,0x55


Code:
	mov ax,0x0050
	mov es,ax    ;目标地址段寄存器初始化
	mov di,0;目标地址偏移寄存器初始化

	mov ax,0x07C0
	mov ds,ax  ;原始地址段寄存器初始化
	mov si,Data ;原始地址偏移寄存器初始化


	mov cx,(Code-Data)/2
	rep movsw  ;rep movsb是一条指令


End:
	jmp near End

	times 510-($-$$) db 0x00
	db 0x55,0xAA 
