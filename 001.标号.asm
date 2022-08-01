;执行完下面的三条汇编指令，直接跳过第四条指令，执行第五条指令

mov ax,0x0000
mov ax,0x0001
mov ax,0x0002
jmp 0x07C0:mark  ;0x7C00是主引导扇区的内存地址。

add ax,0x0003
add ax,0x0004

mark:			;标号指代了当前位置距离起始位置的偏移量
add ax,0x0005

times 510-($-$$) db 0x00
db 0x55,0xAA