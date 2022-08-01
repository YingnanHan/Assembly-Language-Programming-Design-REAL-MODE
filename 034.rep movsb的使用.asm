;不知道你发现没有，前面的四个例子一次性只可以复制一个字节的数据，很繁琐
;那么如果涉及到1000个指令又该如何解决问题呢？


;0x00501=0x01
;0x00502=0x02
;0x00503=0x03
;0x00504=0x04

jmp near Code

Data:
	db 0xAA,0x11,0x22,0x33,0x44

;在版本三中默认情况下si  di都是每一次移动加一，这是由DF方向寄存器来确定的
Code:
	mov cx,Code-Data
	std		;set direction 设置方向寄存器为1，使得si  di是随着执行次数递增，cls指的是std的逆操作
	mov ax,0x0050
	mov es,ax	;目标地址段寄存器初始化
	mov di,0+4	;目标地址偏移寄存器初始化

	mov ax,0x07C0	
	mov ds,ax	;原始地址段寄存器初始化
	mov si,Data+4	;原始地址偏移寄存器初始化

	rep movsb	;每一次移动的时候si di自动减一 cx寄存器每一次也会减一，用来计数

End:
	jmp near End
	times 510-($-$$) db 0x00
	db 0x55,0xAA