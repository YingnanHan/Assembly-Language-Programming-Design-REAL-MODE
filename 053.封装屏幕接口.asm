mov ax,0x0000
mov ss,ax  ;��ʼ��ջ�μĴ���
mov sp,0xFFFF ;��ʼ��ջ��ƫ�Ƶ�ַ
mov bp,0xFFFF ;��ʼ��ջ��ƫ�Ƶ�ַ

jmp near Code

;��װ��Ļ����ӿڣ���������

PrintfStr:
push ds  ;����ds�μĴ�����ֵ
push es  ;����es�μĴ�����ֵ
push ax  ;����ax�Ĵ�����ֵ
push di  ;����Ŀ���ַƫ�ƼĴ���
push si  ;����ԭʼ��ַƫ�ƼĴ���

mov ds,word[ss:bp-2] ;��ʼ��Ҫ������ı����ݶμĴ���
mov si,word[ss:bp-4] ;��ʼ��Ҫ������ı�����ƫ�ƼĴ���

mov ax,0xB800
mov es,ax  ;��ʼ����ʾ�μĴ���
mov di,word[ds:DisPlayIndex]

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
mov word[ds:DisPlayIndex],di
pop si
pop di
pop ax
pop es
pop ds
retf

 

String: 
db '123456789',0x00

String2:
db '       I  Like  You',0x00

DisPlayIndex:
dw 0x0000

 

Code:
push 0x07C0;  ѹ���ı����ڶμĴ���
push String;  ѹ���ı�����ƫ�ƼĴ���
call 0x07C0:PrintfStr  ;��������ӿ�
add sp,4   ;���ջ����������
 
push 0x07C0;  ѹ���ı����ڶμĴ���
push String2;  ѹ���ı�����ƫ�ƼĴ���
call 0x07C0:PrintfStr  ;��������ӿ�
add sp,4  ;���ջ����������


End:
jmp near End

times 510-($-$$) db 0x00
dw 0xAA55
