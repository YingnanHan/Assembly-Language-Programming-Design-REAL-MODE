jmp near Code 
Data:
	db 0xAA,0x11,0x22,0x33,0x44,0x55


Code:
	mov ax,0x0050
	mov es,ax    ;Ŀ���ַ�μĴ�����ʼ��
	mov di,0;Ŀ���ַƫ�ƼĴ�����ʼ��

	mov ax,0x07C0
	mov ds,ax  ;ԭʼ��ַ�μĴ�����ʼ��
	mov si,Data ;ԭʼ��ַƫ�ƼĴ�����ʼ��


	mov cx,(Code-Data)/2
	rep movsw  ;rep movsb��һ��ָ��


End:
	jmp near End

	times 510-($-$$) db 0x00
	db 0x55,0xAA 
