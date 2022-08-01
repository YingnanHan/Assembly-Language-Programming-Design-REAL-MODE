mov ax,0x07C0				;
mov ds,ax				;初始化数据寄存器
mov ax,0x0000				;
mov bp,0xFFFF				;初始化栈段寄存器
					;计算100+200+300;	栈 0x0000FFFF

jmp near Code

Return:
	dw 0x0000,0x07C0		;偏移地址，段地址


Sum:
	dw 0x0000			;存储接口返回的数据


					;输入三个参数，通过push，在传递一个返回的内存偏移地址
Function:				;对求和程序的一个封装
	push ax				;保存ax寄存器原有的值
	mov ax,word[ss:bp-2]		;把第一个加数放到ax中
	add ax,word[ss:bp-4]		;把第一个数和第二个数相加，结果放到ax中
	add ax,word[ss:bp-6]		;将三个数的和放到ax中
	mov word[ds:Sum],ax		;结果数据的存储
	pop ax				;恢复之前ax中的值	

	pop word[ds:Return]
	add sp,6			;栈是临时的内存，工作完成了之后，就把sp&bp栈底指针置为一致，清空栈里面的临时数据
	jmp far [ds:Return]

Code:
	push 100
	push 200
	push 300
	push $+6
	jmp near Function		;调用接口的下一条指令除继续执行代码
	
	push 400
	push 500
	push 600
	push $+6
	jmp near Function		;调用接口的下一条指令除继续执行代码

	push 50
	push 100
	push 150
	push $+6
	jmp near Function		;调用接口的下一条指令除继续执行代码

End:
	jmp near End

	times 510-($-$$) db 0x00
	db 0xAA55