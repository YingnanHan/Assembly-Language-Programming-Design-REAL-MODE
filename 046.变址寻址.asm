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


;��������ڴ��ʱ��ʹ�õ���bp������bx����ô���ǻ�ַѰַ
;��������ڴ��ʱ��ʹ�õ���si������di����ô���Ǳ�ַѰַ
;������Ѱַ��ʽ�ڻ���������������û��ʲô�����