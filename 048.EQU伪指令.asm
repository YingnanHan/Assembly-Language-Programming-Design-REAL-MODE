;equ指令的作用是定义常量
;使用equ的好处就是可以为常量起名字
;equ在汇编语言中的作用就相当于宏
price equ 100;这句话的意思是将Price定义为100

mov ax,price ;编译之后equ被解释为一个立即数
mov bx,price
mov cx,price
mov dx,price

times	510-($-$$) db 0x00
dw 0xAA55