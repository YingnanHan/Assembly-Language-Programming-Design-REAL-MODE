mov ax,0x04     ;0x06 星期  0x04 时间(小时部分24h计时) 
		;0x02 分钟
or  al,0x80	;0000 0110 or 1000 000 = 1000 0110
		;将0x70处内存写入 1000 0100 
out 0x70,al	;将不可屏蔽中断屏蔽
in al,0x71

times 510-($-$$) db 0x00
dw 0xAA55

;值得注意的是，从CMOS中读取出来的时钟信息是以BCD的形式编码的
;40(D)<=> 0x0100 0000 BCD编码
;	  0x0010 1000 纯二进制编码