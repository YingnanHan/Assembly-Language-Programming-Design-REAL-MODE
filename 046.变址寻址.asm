mov ax,0x7C00
mov ds,ax
jmp near Code

Data:
	dw 0x0020,0x000f,0x0300,0xff00

Code:
	mov bx,Data
	mov cx,5

IncreaseOne:
	inc word[ds:di]
	add di,2
	loop IncreaseOne

End:
	jmp near End
	times 510-($-$$) db 0x00
	db 0x55,0xAA


;如果访问内存的时候，使用的是bp或者是bx，那么就是基址寻址
;如果访问内存的时候，使用的是si或者是di，那么就是变址寻址
;这两种寻址方式在汇编语言这个级别是没有什么区别的