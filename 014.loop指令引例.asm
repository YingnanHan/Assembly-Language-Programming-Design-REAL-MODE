xor ax,ax
;inc ax
;inc ax
;inc ax
;inc ax
;inc ax
;inc ax
;inc ax
;inc ax
;inc ax
;inc ax
;ע�����������Ŀ���Ƕ�ax�Ĵ�������һ���Ĵ�����Ȼ������������ֻ�ֳܴ�512�ֽڵĴ��룬
;�������ַ�ʽ������Ҫ�����ָ����Ǿͻ�������˷��ڴ�ռ䣬��������loopָ�����������
end:
jmp	0x7C00:end

times 210-($-$$) db 0x00
db 0x55,0xAA