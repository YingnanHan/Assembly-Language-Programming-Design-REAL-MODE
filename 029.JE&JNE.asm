;�����������
;�������������������������ͬ�Ļ���������Ļ����ʾ��Two numbers the same����
;�������������ͬ�Ļ�������Ļ����ʾ��Two different numbers��

mov ax,0xB800
mov es,ax

mov ax,0x07C0
mov ds,ax

mov si,0
mov di,0

jmp near code

number1:
dw 200;�����һ�����֡�

number2:
dw 20;����ڶ�������

string1:
db 'Two numbers the same'

string2:
db 'Two numbers the not same'


code:
	mov ax,word[ds:number1]
	mov bx,word[ds:number2]
	cmp ax,bx
	;je printstring1		;zf=1��ʱ������ת
	jne printstring2		;zf=0��ʱ������ת


	printstring1:
	mov cx,string2-string1
	mov si,string1
	jmp near startprint

	printstring2:
	mov cx,code-string2
	mov si,string2


	startprint:
	mov al,byte [ds:si]
	mov byte[es:di],al
	inc di
	mov byte[es:di],0x07
	inc di
	inc si
	loop startprint


end:
	jmp 0x07C0:end

	times 510-($-$$) db 0x00
	db 0x55,0xAA