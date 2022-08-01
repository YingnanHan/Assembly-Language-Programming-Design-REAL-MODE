mov ax,0xB800
mov ds:ax

mov byte[ds:0000],0x03;注意这里要加上指明大小的byte标记 同样的对于其他的标记word也是类似的
neg byte[ds:0000]

mov word[ds:0000],0xEDCC;注意这里要加上指明大小的byte标记 同样的对于其他的标记word也是类似的
neg word[ds:0000],0x1234;小端模式

end:
	jmp 0x7C00:end

	times 510-($-$$) db 0x00
	dw 0xAA55