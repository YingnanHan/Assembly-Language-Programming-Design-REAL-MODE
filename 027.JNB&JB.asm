;程序设计：输入一个年龄，如果这个年龄是18岁以上（包括18）岁，就在屏幕上显示“Adult”，如果这个年龄小于18岁，在屏幕上显示“Minor”

mov ax,0xB800
mov es,ax	;使用ex来定位显存的段地址，初始化显存的段寄存器

mov ax,0x07C0	;注意这里不要写错
mov ds,ax	;初始化数据段寄存器

mov si,0	;初始化数据段偏移寄存器
mov di,0	;初始化显存段的偏移寄存器


jmp	near code ;使用近距离跳转，类似于正常的跳转 段内近转移


Age:
db 17	;输入年龄

Adult:
db 'Adult'

Minor:
db 'Minor'


code:
	mov al,byte[ds:Age]
	cmp al,18		;如果产生借位，也就是al比18小，CF=1；CF=0说明al大于18岁，或者等于18岁
	JB PrintMinor		;如果al<18,则跳转

PrintAdult:
	;在屏幕上输出成年人
	mov cx,Minor-Adult	;确定要输出几个字节
	;mov si,Adult
	Adultloop:
		mov al,[ds:Adult+si]
		mov byte [es:di],al
		inc di
		mov byte [es:di],0x07
		inc si
		inc di
		loop Adultloop

jmp near end	;避免调用PrintMinor

PrintMinor:
	;在屏幕上输出未成年人
	mov cx,code-Minor
	;mov si,Minor
	Minorloop:
		mov al,[ds:Minor+si]
		mov byte [es:di],al
		inc di
		mov byte [es:di],0x07
		inc si
		inc di
		loop Minorloop


end:
	jmp 0x07C0:end

	times 510-($-$$) db 0x00
	db 0x55,0xAA