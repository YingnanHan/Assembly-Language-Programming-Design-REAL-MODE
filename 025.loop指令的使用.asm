mov ax,0xB800
mov es,ax
mov ax,0x07C0
mov ds,ax
mov cx,code-string
mov si,0
mov di,0

jmp 0x07C0:code

string :
	db 'This is a string'
code:
	;注意定位字符串偏移地址的寄存器只有2组，ds:si   es:di其它标志位由于底层电路的设计是不允许这样做的
	mov al,[ds:string+si]      ;ds:si=0x07C0*0x10+string+0
	mov byte[es:di],al	   ;
	inc di
	mov byte[es:di],0x07
	inc si
	inc di			   ;这里需要增加两次di
	loop code

	end :
	jmp 0x07C00:end		   ;循环不让程序执行在内存中存放在后面的代码

	times 510-($-$$) db 0x00   ;注意这里一定是512个字节，不然主引导扇区会崩溃
	db 0x55,0xAA
