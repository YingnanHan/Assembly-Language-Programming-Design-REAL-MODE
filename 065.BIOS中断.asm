mov ax,0x0000
mov ss,ax
mov sp,0xffff
mov bp,0xffff


mov ax,0x07C0
mov ds,ax

;使用10号中断的二号功能，设置光标停靠位置为零行零列
mov dh,0x00
mov dl,0x00
mov ah,0x02
int 10h
;其他中断的使用方式是一致的

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