;CF寄存器被影响

;mov al,0xFE
;add al,1
;sub al,1
;inc al	;inc一般用来循环计数，inc指令不影响CF


;含有借位的情况,CF同样被影响，但是同样的dec不会被影响
mov ax,0x0002
sub ax,1
sub ax,1
sub ax,1

end:
	jmp 0x07C00:end

	times 510-($-$$) db 0x00
	dw 0xAA55