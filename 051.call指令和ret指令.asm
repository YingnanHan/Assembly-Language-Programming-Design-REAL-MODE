mov ax,0x07C0				;
mov ds,ax				;��ʼ�����ݼĴ���
mov ax,0x0000				;
mov bp,0xFFFF				;��ʼ��ջ�μĴ���
					;����100+200+300;	ջ 0x0000FFFF

jmp near Code

Return:
	dw 0x0000,0x07C0		;ƫ�Ƶ�ַ���ε�ַ


Sum:
	dw 0x0000			;�洢�ӿڷ��ص�����


					;��������������ͨ��push���ڴ���һ�����ص��ڴ�ƫ�Ƶ�ַ
Function:				;����ͳ����һ����װ
	push ax				;����ax�Ĵ���ԭ�е�ֵ
	mov ax,word[ss:bp-2]		;�ѵ�һ�������ŵ�ax��
	add ax,word[ss:bp-4]		;�ѵ�һ�����͵ڶ�������ӣ�����ŵ�ax��
	add ax,word[ss:bp-6]		;���������ĺͷŵ�ax��
	mov word[ds:Sum],ax		;������ݵĴ洢
	pop ax				;�ָ�֮ǰax�е�ֵ	
	ret				;��֮ǰѹ���IP CS���� ��������sp�Ĵ�����ֵ��û�б��޸�

Code:
	push 100
	push 200
	push 300
	call near Function
	add sp,6			;��ƽջ

	push 400
	push 500
	push 600
	call near Function
	add sp,6
	
	push 50
	push 100
	push 150
	call near Function
	add sp,6

End:
	jmp near End

	times 510-($-$$) db 0x00
	db 0xAA55