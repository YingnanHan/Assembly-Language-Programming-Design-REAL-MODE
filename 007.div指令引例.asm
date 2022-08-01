mov ax,0xB800
mov es,ax
mov ax,1230
;=======================
;这里些什么代码比较好呢？
;1:0x31,49 2:0x32,50
;=======================
;下面这6行代码并不能完成任意的将ax中的值输出在屏幕上
mov byte[es:0],49
mov byte[es:1],7

mov byte[es:2],50
mov byte[es:3],7

mov byte[es:4],51
mov byte[es:5],7

times 510-($-$$) db 0x00
db 0x55,0xAA