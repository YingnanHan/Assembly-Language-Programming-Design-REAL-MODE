mov al,0x7F	;al=0x0111 1111 ;如果符号位是0的话，al里面存的是一个正整数，如果是1的话，al里面存的是一个负整数
add al,0	;al=0x1111 1111
add al,2	;al=0x0000 0000
End:
	jmp near End
	times 510-($-$$) db 0x00
	db 0x55,0xAA
