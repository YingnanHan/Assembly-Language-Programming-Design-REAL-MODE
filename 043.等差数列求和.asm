;����˵��������һ����ʼ���֣�һ���������֣�������м������е����֮��
;����ʱ�䣺2020-5-27

mov ax,0x07C0				;����ε�ַ
mov ds,ax

mov ax,0x0000				;ջ�׵�ַ
mov ss,ax

mov sp,0xFFFF				;ջ����־��ַ
mov bp,0xFFFF	

jmp near Code

StartNumber:
	dw 1

EndNumber:
	dw 100

Divisor:
	dw 10

Count:					;����ۼӵĺͣ��Ǽ�λ��
	dw 0

					;�����ǵ��ۼӽ���洢��ax��
Code:
	mov ax,word[ds:StartNumber]
	mov cx,ax			;cx����������ʼ������
	xor ax,ax			;��ax����

Sum:
	add ax,cx
	inc cx				;���cx<=11 �ۼ�
	cmp cx,word[ds:EndNumber]
	jbe Sum

Split:
				;�ֽ�ax�е�ֵ 5050 �������
				; ��������DX:AX�У���Ϊһ���Ĵ����治�£�����AX�У�������DX��
	xor  dx,dx		;��DX����
	div  word[ds:Divisor]
	add  dx,0x30		;��dx���������ֱ��ת����ASCII������д���Դ�
	push dx
	inc  word[ds:Count]	;���������λ��
	cmp  ax,0		;�жϵ�ǰ�����Ƿ�Ϊ0
	jne  near Split

	mov  cx,word[ds:Count]
	mov  ax,0xB800
	mov  es,ax
	xor  di,di

Print:
	pop  ax
	mov  byte[es:di],al
	inc  di
	mov  byte[es:di],0x07
	inc  di
	loop Print
End:
	jmp  near End

	times 510-($-$$) db 0x00
	db 0x55,0xAA