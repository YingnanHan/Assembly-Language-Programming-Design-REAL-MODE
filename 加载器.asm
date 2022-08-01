Progarm_Start_Section equ 1;�����صĳ�����ʼ������
section Mbr vstart=0x7C00
jmp near Code 

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
shl cx,8    ;cx= cx *256   cx�������ڴ洢��Ҫ��д��ѭ������< /FONT> 

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

 


Physical_Address dd 0x00010000

Code:
;cs��ds��es��ssĬ�϶���0x0000
;ssջ�μĴ���Ĭ����0x0000   ������������ջ�η�Χ����0x00000-0x0FFFF֮�䣬Ҳ����64KB��
;sp����0xFFFF��0x0000֮��仯��
mov sp,0x0000
mov bp,0x0000 

;dx:ax
mov dx,word[ds:Physical_Address+2]
mov ax,word[ds:Physical_Address]
mov bx,16  ;��������16
div bx   ;����ax�У������ŵ�dx�С�
;����ָ��൱�ڰ�20λ�ľ��������ַ������ɶε�ַ��ƫ�Ƶ�ַ����ʽ��
;�ε�ַλ��ax�У�ƫ�Ƶ�ַλ��dx�С�ax=0x1000 dx=0x0000< /FONT>

mov ds,ax; �Ѷε�ַ����ds�μĴ���.
mov es,ax; �Ѷε�ַ����es�μĴ��� 


push 0xE000
push Progarm_Start_Section
push 0x0120  ;��8λ�����д�������ȣ���8λ0x20�����,0x30����д��
push ds
push 0x0000
call 0x0000:Read_Or_Write_HardDisk
add sp,10 

mov dx,word[ds:0x0002]
mov ax,word[ds:0x0000];ȡ���˱����س��򵽵��ж��
;����dx��ax�������ţ������س���Ĵ�С��
mov bx,512
div bx ;���������򵽵���Ӳ����ռ�˼���������
;����ax�У�������dx�С�

;1.�ж�dx�е�������0����ȥһ������������3.
;2.�ж�dx�е���������0�Ļ�������3.
;3.���AX�ǲ���0.�����0������5���������0������ת��4������ת��5.
;4.��ʼ��ȡʣ���������
;5.�ѱ����س���Ķε�ַ����ȫ���ض�λ�� ��Ե�ַȡ����+0x10000�������ַ��=ÿ���εľ��������ַ��< /FONT>


cmp dx,0
jnz @3
dec ax 

@3:
cmp ax,0
jz Init_Work

mov cx,ax ;ax��������ʣ����������
mov bx,Progarm_Start_Section 


Read_Other_Section:
inc bx
mov ax,ds
add ax,0x0020 ;�൱�ڰ��ڴ��ַ��������512���ֽڡ�
mov ds,ax 


push 0xE000
push bx  ;Ҫ�Ѷ�����ʼ�������ŵ���bx���档
push 0x0120     ;��8λ�����д�������ȣ���8λ0x20�����,0x30����д��
push ds
push 0x0000
call 0x0000:Read_Or_Write_HardDisk
add sp,10
loop Read_Other_Section 

mov ax,es
mov ds,ax

 

Init_Work:
mov dx,word[ds:0x0008]
mov ax,word[ds:0x0006]
call 0x0000:Calc_Section_Address
;����dx��ax�д�ŵ�����Ի���ַ��
;��Ի���ַ��0x10000,����˾��������ַ��
;���������ַ ���� 16 �͵õ��˾��ԵĶε�ַ�� 

mov word[ds:0x0006],ax  ;Code_Init���ڴ�����ľ��Զε�ַ��
mov cx,[ds:0x000A] ; ��Ҫ�ض�λ�Ķ���Ŀ��ȡ������ѭ������
mov bx,0x000C 

Loop_Redirect:
mov dx,word[ds:bx+2]
mov ax,word[ds:bx]
call 0x0000:Calc_Section_Address
mov word[ds:bx],ax
add bx,4
loop Loop_Redirect 

;���еļ��ع������ε�ַ�ض�λ���������Ѿ�����ˡ�
;��ô�Ϳ�ʼ�������CPU�Ŀ���Ȩ�����������س����ˡ�
;Ҳ����ִ�С������س��򡷵ĵ�һ��ָ��

call far [ds:0x0004]
jmp near End 

Calc_Section_Address:  ;����������εľ��Զε�ַ������ŵ�ax�С�
push bx
add ax,word[cs:Physical_Address] ;������ǲ�����λ�������cf=1�����û�в�����λ��cf=0
adc dx,word[cs:Physical_Address+2]
;����dx��ax�д�ŵģ�����ĳ���εľ��������ַ��
mov bx,16
div bx
;���ԵĶε�ַ�Ϳ϶���ax�С�
pop bx
retf


End:
jmp near End 

times 510-($-$$) db 0x00
dw 0xAA55