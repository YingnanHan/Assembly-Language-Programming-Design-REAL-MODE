mov bp,0xFFFF
;����100+200+300

push 100
push 200
push 300

mov ax,word[ss:bp-2];�ѵ�һ�������ŵ�ax��
add ax,word[ss:bp-4];�ѵ�һ�����͵ڶ�������ӣ�����ŵ�ax��
add ax,word[ss:bp-6];���������ĺͷŵ�ax��
add sp,6	    ;ջ����ʱ���ڴ棬���������֮�󣬾Ͱ�sp&bpջ��ָ����Ϊһ�£����ջ�������ʱ����

push 400
push 500
push 600

mov ax,word[ss:bp-2];�ѵ�һ�������ŵ�ax��
add ax,word[ss:bp-4];�ѵ�һ�����͵ڶ�������ӣ�����ŵ�ax��
add ax,word[ss:bp-6];���������ĺͷŵ�ax��
add sp,6	    ;ջ����ʱ���ڴ棬���������֮�󣬾Ͱ�sp&bpջ��ָ����Ϊһ�£����ջ�������ʱ����

End:
	jmp near End

	times 510-($-$$) db 0x00
	db 0xAA55