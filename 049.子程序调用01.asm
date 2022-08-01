mov bp,0xFFFF
;计算100+200+300

push 100
push 200
push 300

mov ax,word[ss:bp-2];把第一个加数放到ax中
add ax,word[ss:bp-4];把第一个数和第二个数相加，结果放到ax中
add ax,word[ss:bp-6];将三个数的和放到ax中
add sp,6	    ;栈是临时的内存，工作完成了之后，就把sp&bp栈底指针置为一致，清空栈里面的临时数据

push 400
push 500
push 600

mov ax,word[ss:bp-2];把第一个加数放到ax中
add ax,word[ss:bp-4];把第一个数和第二个数相加，结果放到ax中
add ax,word[ss:bp-6];将三个数的和放到ax中
add sp,6	    ;栈是临时的内存，工作完成了之后，就把sp&bp栈底指针置为一致，清空栈里面的临时数据

End:
	jmp near End

	times 510-($-$$) db 0x00
	db 0xAA55