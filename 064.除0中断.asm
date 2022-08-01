mov ax,0x0000
mov ss,ax
mov sp,0xFFFF
mov bp,0xFFFF

mov bl,0
div bl

End:
	jmp near End
	times 510-($-$$) db 0x00
	db 0xAA55