;CF�Ĵ�����Ӱ��

;mov al,0xFE
;add al,1
;sub al,1
;inc al	;incһ������ѭ��������incָ�Ӱ��CF


;���н�λ�����,CFͬ����Ӱ�죬����ͬ����dec���ᱻӰ��
mov ax,0x0002
sub ax,1
sub ax,1
sub ax,1

end:
	jmp 0x07C00:end

	times 510-($-$$) db 0x00
	dw 0xAA55