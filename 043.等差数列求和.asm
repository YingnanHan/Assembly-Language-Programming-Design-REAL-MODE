;代码说明：输入一个起始数字，一个结束数字，计算出中间数所有的相加之和
;创建时间：2020-5-27

mov ax,0x07C0				;代码段地址
mov ds,ax

mov ax,0x0000				;栈底地址
mov ss,ax

mov sp,0xFFFF				;栈顶标志地址
mov bp,0xFFFF	

jmp near Code

StartNumber:
	dw 1

EndNumber:
	dw 100

Divisor:
	dw 10

Count:					;最后累加的和，是几位数
	dw 0

					;把我们的累加结果存储到ax中
Code:
	mov ax,word[ds:StartNumber]
	mov cx,ax			;cx里面存的是起始的数字
	xor ax,ax			;将ax清零

Sum:
	add ax,cx
	inc cx				;如果cx<=11 累加
	cmp cx,word[ds:EndNumber]
	jbe Sum

Split:
				;分解ax中的值 5050 并且输出
				; 被除数在DX:AX中，因为一个寄存器存不下，商在AX中，余数在DX中
	xor  dx,dx		;将DX清零
	div  word[ds:Divisor]
	add  dx,0x30		;将dx里面的余数直接转化成ASCII码用来写进显存
	push dx
	inc  word[ds:Count]	;计算和数的位数
	cmp  ax,0		;判断当前和数是否为0
	jne  near Split

	mov  cx,word[ds:Count]
	mov  ax,0xB800
	mov  es,ax
	xor  di,di

Print:
	pop  ax
	mov  byte[es:di],al
	inc  di
	mov  byte[es:di],0x07
	inc  di
	loop Print
End:
	jmp  near End

	times 510-($-$$) db 0x00
	db 0x55,0xAA