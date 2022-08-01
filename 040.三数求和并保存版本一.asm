mov ax,100
mov ax,200
mov cx,300

add ax,bx
add ax,cx
mov dx,ax

End:
	jmp near End
	times 510-($-$$) db 0x00
	db 0x55,0xAA