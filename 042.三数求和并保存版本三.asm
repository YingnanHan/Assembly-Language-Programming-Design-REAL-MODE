;��������һ�δ�����Ż�������ʹ��ջ�ṹ������������
;ss:spջ����ַ  ss:bp ջ�׵�ַ

mov sp,0xffff
mov ss,0xffff

;����100+200+300
push 100
push 200
push 300

mov ax,word[ss:bp-2];�ѵ�һ�������ŵ�ax��
mov ax,word[ss:bp-4];��һ�����͵ڶ�������ӣ�����ŵ�ax��
add ax,word[ss:bp-6];�������ĺͣ��ŵ���ax��

add sp,6	;ע������ûʹ��popָ������ʹ��ջ���֮��Ҫ�ֶ��޸�ջ��ָ��
End:	
	jmp near End
	times 510-($-$$) db 0x00
	db 0x55,0xAA