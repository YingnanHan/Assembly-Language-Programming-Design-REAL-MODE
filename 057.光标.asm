mov ax,0xB800
mov es,ax
mov di,0x0000

mov cx,2000	;设置循环次数，遍历每一个小格子

;清除屏幕->全设置为黑色
Clear_Screen:	
	mov word[es:di],0x0720
	add di,2
	loop Clear_Screen


;确定光标位置，在固定的屏幕位置显示字符
;根据教程的图片虽规定的字符显示位置 *2是为了可以定位到显存地址
;位置计算公式：(x-1) x 80 + y-1  
;计算 'A' 就等于 (1-1)x80+1-1=0
;计算 'B' 就等于 (1-1)x80+3-1=2
;计算 'C' 就等于 (2-1)x80+1-1=80
;计算 'D' 就等于 (2-1)x80+4-1=83
mov di,0*2	;di=0x0000 es:0x0000
mov byte[es:di],'A'

mov di,2*2	
mov byte[es:di],'B'

mov di,80*2	
mov byte[es:di],'C'

mov di,83*2	
mov byte[es:di],'D'

mov di,167*2	
mov byte[es:di],'E'

mov di,1920*2	
mov byte[es:di],'F'

mov di,1999*2	
mov byte[es:di],'G'

;--------------------------

mov dx,0x3D4
mov al,0x0E	;代表光标所在寄存器名字
out dx,al

;1920=0x0780
mov dx,0x3D5
mov al,0x07
out dx,al

mov dx,0x3D4
mov al,0x0F	;代表光标所在寄存器名字
out dx,al

;1920=0x0780
mov dx,0x3D5
mov al,0x80
out dx,al

;采用如上的方式写就会使得语句更加精炼
jmp $
	times 510-($-$$) db 0x00
	db 0xAA55