;0x00501=0x01
;0x00502=0x02
;0x00503=0x03
;0x00504=0x04

jmp near Code

Data:
	db 0xAA,0x11,0x22,0x33,0x44

Code:
	mov ax,0x0050
	mov es,ax	;Ŀ���ַ�μĴ�����ʼ��
	mov di,0	;Ŀ���ַƫ�ƼĴ�����ʼ��

	mov ax,0x07C0	
	mov ds,ax	;ԭʼ��ַ�μĴ�����ʼ��
	mov si,Data	;ԭʼ��ַƫ�ƼĴ�����ʼ��

	movsb		;ÿһ���ƶ���ʱ��si di�Զ���һ
	movsb		;����ע��һ��ֻ���ƶ�һ���ֽڵ�����
	movsb		;�����ƶ������Ǵӵ͵�ַ��ߵ�ַ�ƶ�
	movsb
	movsb
End:
	jmp near End
	times 510-($-$$) db 0x00
	db 0x55,0xAA