;①一个会导致程序崩溃的例子
;mov ax,65535
;mov dl,10
;div dl		;div后面是8位的寄存器或者内存，那么div指令会自动执行8位除法


;②另外一个例子，不会导致崩溃的最大八位被除数
mov ax,0x09FB	;这是根据除数商，还有余数大致推测出来的被除数的大小
;要想程序不崩溃只要被除数的高一半的字节小于除数就可以
mov dl,0x0A
div dl

end:
	jmp 0x07C0:end
	
	times 510-($-$$) db 0x00
	dw 0xAA55