;--------------------------------------------------------------------------------
;�����������������磺123��456��������Ļ�������123+456=579
;�磺10000��33333��������Ļ�������43333  

mov ax,0xB800
mov es,ax

mov ax,0x07C0
mov ds,ax

mov di,0  ;��Ŀ���ڴ��ַƫ�ƼĴ���

jmp near Code

Number1:
dw 888  ;�����һ������λ�á�

Number2:
dw 111  ;����ڶ�������λ�á�


;Si=0x0017
;bx=5
Split:
; ����ʮ���٣�ǧ����
db 0,0,0,0,0

Divisor:
dw 10

;�ڶ����÷���
;32λ����16λ
;div 16λ�Ĵ���
;div 16λ�ڴ�
;��������DX:AX�У�����AX�У�������DX�С�

Code:
;==============�����һ����===============================
;=��ʼ��������===
mov dx,0
mov ax,word[ds:Number1]   ;ds:ax=123
mov bx,Split


;=�ֽⱻ����===
StartSplit1:
div word[ds:Divisor]
mov byte[ds:bx],dl
mov dx,0
inc bx
cmp ax,0
jne near StartSplit1

;=Ϊ���������Ļ����׼������===
sub bx,Split ;  bx���������ľ�������һ����λ��
mov cx,bx  ; cx�Ǵ���loopָ���ѭ������
mov si,Split  ;��ԭʼ�ڴ��ַƫ�ƼĴ���
add si,bx
dec si

Print1:
mov al,byte[ds:si]
add al,48
mov byte[es:di],al
inc di
mov byte[es:di],0x07
dec si
inc di
loop Print1


;================���+��===============================
mov byte[es:di],'+'
inc di
mov byte[es:di],0x07
inc di

;==============����ڶ�����===============================
;=��ʼ��������===
mov dx,0
mov ax,word[ds:Number2]   ;ds:ax=123
mov bx,Split


;=�ֽⱻ����===
StartSplit2:
div word[ds:Divisor]
mov byte[ds:bx],dl
mov dx,0
inc bx
cmp ax,0
jne near StartSplit2

;=Ϊ���������Ļ����׼������===
sub bx,Split ;  bx���������ľ�������һ����λ��
mov cx,bx  ; cx�Ǵ���loopָ���ѭ������
mov si,Split  ;��ԭʼ�ڴ��ַƫ�ƼĴ���
add si,bx
dec si

Print2:
mov al,byte[ds:si]
add al,48
mov byte[es:di],al
inc di
mov byte[es:di],0x07
dec si
inc di
loop Print2

;================���=��===============================
mov byte[es:di],'='
inc di
mov byte[es:di],0x07
inc di


;==============�����������===============================
;=��ʼ��������===
mov dx,0
mov ax,word[ds:Number1]   ;ds:ax=123
add ax,word[ds:Number2]
mov bx,Split


;=�ֽⱻ����===
StartSplit3:
div word[ds:Divisor]
mov byte[ds:bx],dl
mov dx,0
inc bx
cmp ax,0
jne near StartSplit3

;=Ϊ���������Ļ����׼������===
sub bx,Split ;  bx���������ľ�������һ����λ��
mov cx,bx  ; cx�Ǵ���loopָ���ѭ������
mov si,Split  ;��ԭʼ�ڴ��ַƫ�ƼĴ���
add si,bx
dec si

Print3:
mov al,byte[ds:si]
add al,48
mov byte[es:di],al
inc di
mov byte[es:di],0x07
dec si
inc di
loop Print3


End:
jmp near End

times 510-($-$$) db 0x00
db 0x55,0xAA
