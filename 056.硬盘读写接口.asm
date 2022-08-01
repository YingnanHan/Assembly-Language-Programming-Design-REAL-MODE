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

mov ax,0x0000
mov ss,ax  ;��ʼ��ջ�μĴ���
mov sp,0xFFFF ;��ʼ��ջ��ƫ�Ƶ�ַ
mov bp,0xFFFF ;��ʼ��ջ��ƫ�Ƶ�ַ


jmp near Code
;�ӿڴ���ȫ��д�����

Temp:
db '123456789 987654321 123456789 987654321 123456789 987654321 123456789 987654321 123456789 987654321 123456789 987654321 123456789 987654321 123456789 987654321 123456789 987654321',0x00

Read_Or_Write_HardDisk:
;ʵ�ֽӿڣ�Ҫ���ǣ�����ӿ�����ʹ�õ���Щ�Ĵ������ȱ���������
;�����ֳ�
push ds
push ax
push dx
push di
push cx

;�ӿ�����ʵ�ִ������£�

;������ʼ��������
mov ds,word[ss:bp-8]   ;��ʼ��Ҫ��д���ڴ�Ķε�ַ
mov di,word[ss:bp-10]   ;��ʼ��Ҫ��д���ڴ��ƫ�Ƶ�ַ

mov al,byte[ss:bp-1]
mov dx,0x1F6;HD_PORT_LBA28_1
out dx,al


mov al,byte[ss:bp-2]
mov dx,0x1F5;HD_PORT_LBA28_2
out dx,al

mov al,byte[ss:bp-3]
mov dx,0x1F4;HD_PORT_LBA28_3
out dx,al


mov al,byte[ss:bp-4]
mov dx,0x1F3;HD_PORT_LBA28_4
out dx,al

mov al,byte[ss:bp-5]
mov dx,0x1F2
out dx,al   ;HD_PORT_COUNT   8λ����������������

mov al,byte[ss:bp-6]
mov dx,0x1F7
out dx,al   ;HD_PORT_COMMAND   8λ ����Ӳ�̣���Ҫ׼����������д��


Waits:
in al,dx
and al,0x88
cmp al,0x08
jnz Waits

mov dx,0x1F0  ;��dx��ʼ���ɶ�д���ݶ˿�
xor ch,ch   ;��cx�Ĵ�����8λ��0
mov cl,byte[ss:bp-5]      ;cx����洢����ѭ���Ĵ�����   2 * 256
shl cx,8    ;cx= cx *256   cx�������ڴ洢��Ҫ��д��ѭ������

cmp byte[ss:bp-6],0x20  ; �������0����������������������������0,���������д����
jnz Write_Loop


Read_Loop:
in ax,dx
mov word [ds:di],ax
add di,2
loop Read_Loop
jmp near Read_Or_Write_HardDisk_End


Write_Loop:
mov ax,word [ds:di]
out dx,ax
add di,2
loop Write_Loop


;�ָ��ֳ�
Read_Or_Write_HardDisk_End:
pop cx
pop di
pop dx
pop ax
pop ds
retf

;��װ��Ļ����ӿڣ���������
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
push 0xE000
push 0x0001  ;0xE000 0001  ʹ��LBA28ģʽ����ʼ������λ����0x000 0001
push 0x0320  ;��8λ�����д�������ȣ���8λ0x20�������0x30����д��
push 0x07E0
push 0x0000
call 0x07C0:Read_Or_Write_HardDisk
add sp,10


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
