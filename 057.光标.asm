mov ax,0xB800
mov es,ax
mov di,0x0000

mov cx,2000	;����ѭ������������ÿһ��С����

;�����Ļ->ȫ����Ϊ��ɫ
Clear_Screen:	
	mov word[es:di],0x0720
	add di,2
	loop Clear_Screen


;ȷ�����λ�ã��ڹ̶�����Ļλ����ʾ�ַ�
;���ݽ̵̳�ͼƬ��涨���ַ���ʾλ�� *2��Ϊ�˿��Զ�λ���Դ��ַ
;λ�ü��㹫ʽ��(x-1) x 80 + y-1  
;���� 'A' �͵��� (1-1)x80+1-1=0
;���� 'B' �͵��� (1-1)x80+3-1=2
;���� 'C' �͵��� (2-1)x80+1-1=80
;���� 'D' �͵��� (2-1)x80+4-1=83
mov di,0*2	;di=0x0000 es:0x0000
mov byte[es:di],'A'

mov di,2*2	
mov byte[es:di],'B'

mov di,80*2	
mov byte[es:di],'C'

mov di,83*2	
mov byte[es:di],'D'

mov di,167*2	
mov byte[es:di],'E'

mov di,1920*2	
mov byte[es:di],'F'

mov di,1999*2	
mov byte[es:di],'G'

;--------------------------

mov dx,0x3D4
mov al,0x0E	;���������ڼĴ�������
out dx,al

;1920=0x0780
mov dx,0x3D5
mov al,0x07
out dx,al

mov dx,0x3D4
mov al,0x0F	;���������ڼĴ�������
out dx,al

;1920=0x0780
mov dx,0x3D5
mov al,0x80
out dx,al

;�������ϵķ�ʽд�ͻ�ʹ�������Ӿ���
jmp $
	times 510-($-$$) db 0x00
	db 0xAA55