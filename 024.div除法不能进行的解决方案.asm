;为了解决022中出现的问题后来人们又想出了将高位以及低位字节分开存储的方式，这样就会大大减少溢出的可能
;mov dx,0x0000
;mov ax,0xFFFF  ;dx:ax=0x 0000FFFF 
;mov cx,0x000A
;div cx				;导致崩溃


;要想程序“不崩溃”：
;被除数的高一半，必须小于除数。
;如果数据不满足这样的条件，被除数的高一半大于或者等于除数，就会产生除法溢出，继而引发程序“崩溃”

mov dx,0x000A
mov ax,0xFFFF  ;dx:ax=0x 0000FFFF 
mov cx,0x00AA
div cx

end:
	jmp 0x07C0:end
	
	times 510-($-$$) db 0x00
	dw 0xAA55