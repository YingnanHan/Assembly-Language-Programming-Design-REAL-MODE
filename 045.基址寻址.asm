mov ax,0x7C00
mov ds,ax
jmp near Code

Data:
	dw 0x0020,0x000f,0x0300,0xff00

Code:
	mov bx,Data
	mov cx,5

IncreaseOne:
	inc word[ds:bx]
	add bx,2
	loop IncreaseOne

End:
	jmp near End
	times 510-($-$$) db 0x00
	db 0x55,0xAA
