jmp 0x07C0:0xffff	;最大偏移地址
;在内存中确实存在0x07C0:0xffff之后的内存地址，但是
;根据内存分段机制段偏移寄存器已经达到了它的最大值，
;因此想要访问这个地址后面的内存地址，只能使用修改，
;短地址寄存器的方法。
End:
	jmp near End
	times 510-($-$$) db 0x00
	db 0xAA55

;段间转移 near
;段内转移 far