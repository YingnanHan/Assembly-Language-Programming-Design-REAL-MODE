mov ax,0xB800
mov es,ax
mov ax,0x07C0
mov ds,ax
mov cx,code-string
mov si,0
mov di,0

jmp 0x07C0:code

string :
	db 'This is a string'
code:
	;ע�ⶨλ�ַ���ƫ�Ƶ�ַ�ļĴ���ֻ��2�飬ds:si   es:di������־λ���ڵײ��·������ǲ�������������
	mov al,[ds:string+si]      ;ds:si=0x07C0*0x10+string+0
	mov byte[es:di],al	   ;
	inc di
	mov byte[es:di],0x07
	inc si
	inc di			   ;������Ҫ��������di
	loop code

	end :
	jmp 0x07C00:end		   ;ѭ�����ó���ִ�����ڴ��д���ں���Ĵ���

	times 510-($-$$) db 0x00   ;ע������һ����512���ֽڣ���Ȼ���������������
	db 0x55,0xAA
