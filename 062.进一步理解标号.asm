section Mbr vstart=0x7C00
;�����ַ�ʽʹ������Ķε��׵�ַ���޸�Ϊ0x7C00
jmp near Code

Data:
	db 0x11,0x22,0x33

Code:
;��λ�ڴ��ַ��ʽ��
	;Ĭ�������ds�Ĵ����ᱻ��ʼ��Ϊ0
	mov al,byte[ds:Data+0];ds:0x0000,ƫ�Ƶ�ַ0x7C03   0x0000+x7C03=0x07C03
	mov al,byte[ds:Data+1]
	mov al,byte[ds:Data+2]

jmp $
times 510-($-$$) db 0x00
db 0xAA55

