mov eax,0x22222222
mov al,-3	;al=0xFD
mov ax,-3	;ax=0xFFFD
mov eax,-3	;eax=0xFFFF FFFD
mov eax,3	;eax=0x0000 0003

end:
	jmp 0x07C00:end
	
	times 510-($-$$) db 0x00
	dw 0xAA55