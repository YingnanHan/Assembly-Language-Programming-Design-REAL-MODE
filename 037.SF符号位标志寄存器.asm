mov al,0x7F	;al=0x0111 1111 ;�������λ��0�Ļ���al��������һ���������������1�Ļ���al��������һ��������
add al,0	;al=0x1111 1111
add al,2	;al=0x0000 0000
End:
	jmp near End
	times 510-($-$$) db 0x00
	db 0x55,0xAA
