jmp near Code

Data:
	db 0x11,0x22,0x33

Code:
	mov ax,0x07C0
	mov ds,ax
;��λ�ڴ��ַ��ʽ��
	;mov al,byte[ds:Data+0]
	;mov al,byte[ds:Data+1]
	;mov al,byte[ds:Data+2]

;��λ�ڴ��ַ��ʽ��


jmp $
times 510-($-$$) db 0x00
db 0xAA55
