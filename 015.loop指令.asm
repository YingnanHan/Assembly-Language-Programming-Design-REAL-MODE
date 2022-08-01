xor ax,ax	;将ax初始化为0
mov cx,3	;cx=3循环计数器的值为3

;使用无条件跳转来完成循环操作
mark:
	inc ax;标号和loop指令之间的代码就是需要重复值执行的代码 执行一次循环 cx-=1
	add ax,0x0002
	loop mark
	;当且仅当cx寄存器中的数值大于0，循环执行
end:
	jmp near end;修改段寄存器CS和IP的值
	;jmp 0c07C0:end

	times 510-($-$$) db 0x00
	db 0x55,0xAA
;使用loop指令的时候，在调试器有如下需要这值得注意的小问题
;
;n:当碰到一些循环指令，n会自动把这个循环过程完成
;s:当碰到一些循环指令，s会把循环过程演示出来
;
;在调试器里面 
;n=单步步过执行指令
;s=单步步入执行指令



;loop 以及 jmp的区别
;loop仅仅修改偏移地址
;jmp则是修改cs:ip整个地址