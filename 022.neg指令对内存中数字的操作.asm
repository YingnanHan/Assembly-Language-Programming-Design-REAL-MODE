mov ax,0xB800
mov ds:ax

mov byte[ds:0000],0x03;ע������Ҫ����ָ����С��byte��� ͬ���Ķ��������ı��wordҲ�����Ƶ�
neg byte[ds:0000]

mov word[ds:0000],0xEDCC;ע������Ҫ����ָ����С��byte��� ͬ���Ķ��������ı��wordҲ�����Ƶ�
neg word[ds:0000],0x1234;С��ģʽ

end:
	jmp 0x7C00:end

	times 510-($-$$) db 0x00
	dw 0xAA55