;��ջ���嵽0x0ffff
mov ax,0x0000
mov ss,ax

mov bp,0xffff	;ss:bp�ϳ���20bit���ڴ��ַ	ջ��
mov sp,0xffff	;ss:sp�ϳ���20bit���ڴ��ַ	ջ��	һģһ����

;�ѼĴ��������һЩ����
mov ax,0x1234
mov bx,0x2345
mov cx,0x3456
mov dx,0x4567

;ջ�����ݵ���ʱ��תվ
;���������ʦΪ�������ʹ�����ṩ��pop pushָ�����������ݷŵ�ջ���Լ�ȡ��
;��ջ
push ax
push bx
push cx
push dx 

;����pushִ���൱����������й���
;sub sp,2
;mov word[ss:sp],ax
;
;sub sp,2
;mov word[ss:sp],bx
;
;sub sp,2
;mov word[ss:sp],cx
;
;sub sp,2
;mov word[ss:sp],dx

;��ջ
pop dx	;�ȼ��� mov dx,word[ss:sp]
	;	add sp,2
pop cx
pop bx
pop ax

End:
	jmp near End

	times 510-($-$$) db 0x00
	db 0x55,0xAA