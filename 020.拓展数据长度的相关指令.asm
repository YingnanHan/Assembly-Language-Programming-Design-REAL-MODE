mov eax,0x22222222
mov edx,0x22222222

mov al,15;mov al,0x0F
;������չָ��ʹ��ʵ��
cbw	;��al������չ��axֻ����з�����

;��ָ����չ��32λ���������ڵļ����ֻ��16λ���治��32λ���ͽ�AX��DX�ֱ������洢��չ֮���ֽڵ�λ�͸�λ
mov ax,-3	;ax=0xFFFD
cwd		;dx:ax=���Ϊһ��32λ�Ĵ��� ����Ϊ0xFFFFFFFD

;��ָ����չ��32λ�����������ֱ����չ��EAX�Ĵ����д洢
mov ax,-3	;ax=0xFFFD
cwde		;EAX=����Ϊ0xFFFFFFFD


;��ָ����չ��64λ�Ĵ����������ڵ�32λ������� ��EAX,EDX�����������һ��64λ�Ĵ���
mov ax,-3	;EAX=0xFFFFFFFD
cdq


end:
jmp 0x7C00:end

times 510-($-$$) db 0x00
dw 0xAA55