;���� ��26����ĸ��ԭλ���ϵߵ�

mov ax,0x07C0
mov ds,ax
jmp near Code

String:
	db 'abcdefghijklmnopqrstuvwxyz'

Code:
	mov bx,String
	mov si,0
	mov di,25

Exchange:
	mov ah,byte[ds:bx+si]
	mov al,byte[ds:bx+di]
	
	mov byte[ds:bx+di],ah
	mov byte[ds:bx+si],al
	
	inc si
	dec di

	cmp si,di
	jb Exchange


End:
	jmp near End
	times 510-($-$$) db 0x00
	db 0x55,0xAA