;equָ��������Ƕ��峣��
;ʹ��equ�ĺô����ǿ���Ϊ����������
;equ�ڻ�������е����þ��൱�ں�
price equ 100;��仰����˼�ǽ�Price����Ϊ100

mov ax,price ;����֮��equ������Ϊһ��������
mov bx,price
mov cx,price
mov dx,price

times	510-($-$$) db 0x00
dw 0xAA55