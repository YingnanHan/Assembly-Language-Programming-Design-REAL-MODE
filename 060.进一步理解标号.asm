jmp near Code

Data:
	db 0x11,0x22,0x33

Code:
	mov ax,0x07C0
	mov ds,ax
;定位内存地址方式①
	;mov al,byte[ds:Data+0]
	;mov al,byte[ds:Data+1]
	;mov al,byte[ds:Data+2]

;定位内存地址方式②


jmp $
times 510-($-$$) db 0x00
db 0xAA55
