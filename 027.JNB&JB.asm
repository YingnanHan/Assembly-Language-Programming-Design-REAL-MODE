;������ƣ�����һ�����䣬������������18�����ϣ�����18���꣬������Ļ����ʾ��Adult��������������С��18�꣬����Ļ����ʾ��Minor��

mov ax,0xB800
mov es,ax	;ʹ��ex����λ�Դ�Ķε�ַ����ʼ���Դ�ĶμĴ���

mov ax,0x07C0	;ע�����ﲻҪд��
mov ds,ax	;��ʼ�����ݶμĴ���

mov si,0	;��ʼ�����ݶ�ƫ�ƼĴ���
mov di,0	;��ʼ���Դ�ε�ƫ�ƼĴ���


jmp	near code ;ʹ�ý�������ת����������������ת ���ڽ�ת��


Age:
db 17	;��������

Adult:
db 'Adult'

Minor:
db 'Minor'


code:
	mov al,byte[ds:Age]
	cmp al,18		;���������λ��Ҳ����al��18С��CF=1��CF=0˵��al����18�꣬���ߵ���18��
	JB PrintMinor		;���al<18,����ת

PrintAdult:
	;����Ļ�����������
	mov cx,Minor-Adult	;ȷ��Ҫ��������ֽ�
	;mov si,Adult
	Adultloop:
		mov al,[ds:Adult+si]
		mov byte [es:di],al
		inc di
		mov byte [es:di],0x07
		inc si
		inc di
		loop Adultloop

jmp near end	;�������PrintMinor

PrintMinor:
	;����Ļ�����δ������
	mov cx,code-Minor
	;mov si,Minor
	Minorloop:
		mov al,[ds:Minor+si]
		mov byte [es:di],al
		inc di
		mov byte [es:di],0x07
		inc si
		inc di
		loop Minorloop


end:
	jmp 0x07C0:end

	times 510-($-$$) db 0x00
	db 0x55,0xAA