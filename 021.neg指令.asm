;��3ȡ����
mov al,3;	0x03
;mov al,-3;	0xFD
;��-3����al�е���һ����ʽ
mov dl,al	;dl=0x03
mov al,0	;al=0
mov al,dl	;0-3=-3

;ʹ��negָ��

mov ax,3
neg ax

end:
	jmp 0x7C00:end
	times 510-($-$$) db 0x00
	dw 0xAA55