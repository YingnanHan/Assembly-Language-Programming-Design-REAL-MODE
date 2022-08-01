;继续上面一段代码的优化，这里使用栈结构来完成这个工作
;ss:sp栈顶地址  ss:bp 栈底地址

mov sp,0xffff
mov ss,0xffff

;计算100+200+300
push 100
push 200
push 300

mov ax,word[ss:bp-2];把第一个加数放到ax中
mov ax,word[ss:bp-4];第一个数和第二个数相加，结果放到ax中
add ax,word[ss:bp-6];三个数的和，放到了ax中

add sp,6	;注意这里没使用pop指令所以使用栈完毕之后要手动修改栈顶指针
End:	
	jmp near End
	times 510-($-$$) db 0x00
	db 0x55,0xAA