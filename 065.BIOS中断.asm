mov ax,0x0000
mov ss,ax
mov sp,0xffff
mov bp,0xffff


mov ax,0x07C0
mov ds,ax

;ʹ��10���жϵĶ��Ź��ܣ����ù��ͣ��λ��Ϊ��������
mov dh,0x00
mov dl,0x00
mov ah,0x02
int 10h
;�����жϵ�ʹ�÷�ʽ��һ�µ�

mov cx,End-String
mov bx,String

Printf:
	push bx
	mov ah,0x0E
	mov al,byte [ds:bx]
	int 0x10
	pop bx
	inc bx
	loop Printf

String:
	db '123456'

End:
	jmp near End
	times 510-($-$$) db 0x00
	db 0xAA55