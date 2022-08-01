;���³���Ϊ����Ӳ�̵�8���˿ڼ�ע��
HD_PORT_DATA equ 0x1F0 ;16λ ���ݶ˿�
HD_PORT_ERROR equ 0x1F1 ;8λ ������ʾ
HD_PORT_COUNT equ 0x1F2 ;8λ ����������������
HD_PORT_LBA28_4 equ 0x1F3 ;8λ LBA28 0~7λ
HD_PORT_LBA28_3 equ 0x1F4 ;8λ LBA28 8~15λ
HD_PORT_LBA28_2 equ 0x1F5 ;8λ LBA28 16~23λ
HD_PORT_LBA28_1 equ 0x1F6 ;8λ LBA28 24~27λ 28~31λҪ����0xE����������LBA28ģʽ
HD_PORT_STATUS equ 0x1F7 ;8λ ��ʾӲ�̵Ĺ���״̬
HD_PORT_COMMAND equ 0x1F7 ;8λ ����Ӳ�̶�����д��
HD_READ  equ 0x20 ;������
HD_WRITE equ 0x30 ;д����
HD_SECTION_COUNT equ 1;Ҫ��д���������ĳ���

 


;������ʼ����
mov al,0x01
mov dx,HD_PORT_LBA28_4
out dx,al 

mov al,0x00
mov dx,HD_PORT_LBA28_3
out dx,al 

mov dx,HD_PORT_LBA28_2
out dx,al 

mov al,0xE0
mov dx,HD_PORT_LBA28_1
out dx,al 

;����Ҫ��������������
mov al,HD_SECTION_COUNT
mov dx,HD_PORT_COUNT
out dx,al 

 

;��������˿���ҪдӲ��
mov al,HD_READ
mov dx,HD_PORT_COMMAND
out dx,al 

 


Waits:  
	in al,dx
	;0x1F1=0010 0000 д
	;Ϊ�˷���ֻ��ע��7λ�͵�3λ��״̬�����ǰ�����λ����Ϊ0
	;0x1F1=1010 0000 æµ   1011 0000 and 1000 1000 = 1000 0000
	;0x1F1=0010 1000 ��ͷ������ݣ����߽������� 0011 1000 and 1000 1000=0000 1000

	and al,0x88 ;0x88=0x10001000  ���ֿ����ԣ�1000 0000=æµ  0000 1000=��ʼ����
	cmp al,0x08
	jnz Waits  


;��Ҫ�������ݷ��뵽���ݶ˿���
mov dx,HD_PORT_DATA
mov cx,HD_SECTION_COUNT * 512 / 2
mov ax,0x07E0
mov ds,ax
mov di,0  

WriteLoop:
	in ax,dx
	mov word[ds:di],ax  
	add di,2
	loop WriteLoop  


;׼����Ļ���������
mov ax,0x0000
mov ss,ax  ;��ʼ��ջ�μĴ���
mov sp,0xFFFF ;��ʼ��ջ��ƫ�Ƶ�ַ
mov bp,0xFFFF ;��ʼ��ջ��ƫ�Ƶ�ַ  

jmp near Code  

DisPlayIndex:
dw 0x0000  


PrintfStr:
;�ӿ�ʹ��˵�����£�

;push 0x07C0;  ѹ����Ļ����ı����ڶμĴ���
;push String;  ѹ����Ļ����ı�����ƫ�ƼĴ���
;push 0x07C0;  ѹ��DisPlayIndex���ڵĶμĴ�����
;push DisPlayIndex;ѹ��DisPlayIndex���ڵ�ƫ�ƼĴ�����
;call 0x07C0:PrintfStr  ;��������ӿ�
;add sp,8   ;���ջ����������  

push ds  ;����ds�μĴ�����ֵ
push es  ;����es�μĴ�����ֵ
push ax  ;����ax�Ĵ�����ֵ
push di  ;����Ŀ���ַƫ�ƼĴ���
push si  ;����ԭʼ��ַƫ�ƼĴ���  

mov ds,word[ss:bp-6] ;��ʼ��DisPlayIndex�ĶμĴ���
mov si,word[ss:bp-8] ;��ʼ��DI�Ĵ�����DI�Ĵ����ڲ��洢����Ļ�ϵ����λ�á� 
mov di,word[ds:si] 

mov ds,word[ss:bp-2] ;��ʼ��Ҫ������ı����ݶμĴ���
mov si,word[ss:bp-4] ;��ʼ��Ҫ������ı�����ƫ�ƼĴ���  

mov ax,0xB800
mov es,ax  ;��ʼ����ʾ�μĴ���  


PrintfLoop:
	mov al,byte [ds:si]
	cmp al,0
	jz PrintfEnd
	mov byte[es:di],al
	inc di
	mov byte[es:di],0x07
	inc di
	inc si
	jmp near PrintfLoop  

PrintfEnd:
	mov ds,word[ss:bp-6] 
	mov si,word[ss:bp-8] 
	mov word[ds:si],di 
	pop si
	pop di
	pop ax
	pop es
	pop ds
	retf

 


Code:

	push 0x07E0;  ѹ����Ļ����ı����ڶμĴ���
	push 0x0000;  ѹ����Ļ����ı�����ƫ�ƼĴ���
	push 0x07C0;  ѹ��DisPlayIndex���ڵĶμĴ�����
	push DisPlayIndex;ѹ��DisPlayIndex���ڵ�ƫ�ƼĴ�����
	call 0x07C0:PrintfStr  ;��������ӿ�
	add sp,8   ;���ջ����������
 

End:
jmp near End  

times 510-($-$$) db 0x00
dw 0xAA55


