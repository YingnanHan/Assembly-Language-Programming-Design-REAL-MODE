mov al,0x04	;0000 0100
shr al,1
shr al,1

shl al,1

End:
	jmp near End
	times 510-($-$$) db 0x00
	dw 0xAA55