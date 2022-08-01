mov ax,0x07C0
mov ds,ax

jmp near code

Number1:
	dw 100
Number2:
	dw 200
Number3:
	dw 300
Sum:
	dw 0

code:
	add ax,word[ds:Number1]
	add ax,word[ds:Number2]
	add ax,word[ds:Number3]
	mov word[ds:Sum],ax

End:
	jmp near End
	times 510-($-$$) db 0x00
	db 0x55,0xAA