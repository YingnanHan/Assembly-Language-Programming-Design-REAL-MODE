;将栈定义到0x0ffff
mov ax,0x0000
mov ss,ax

mov bp,0xffff	;ss:bp合成了20bit的内存地址	栈底
mov sp,0xffff	;ss:sp合成了20bit的内存地址	栈顶	一模一样的

;把寄存器里面放一些数据
mov ax,0x1234
mov bx,0x2345
mov cx,0x3456
mov dx,0x4567

;栈是数据的临时中转站
;计算机工程师为计算机的使用者提供了pop push指令用来将数据放到栈里以及取出
;入栈
push ax
push bx
push cx
push dx 

;上述push执行相当于完成了下列工作
;sub sp,2
;mov word[ss:sp],ax
;
;sub sp,2
;mov word[ss:sp],bx
;
;sub sp,2
;mov word[ss:sp],cx
;
;sub sp,2
;mov word[ss:sp],dx

;出栈
pop dx	;等价于 mov dx,word[ss:sp]
	;	add sp,2
pop cx
pop bx
pop ax

End:
	jmp near End

	times 510-($-$$) db 0x00
	db 0x55,0xAA