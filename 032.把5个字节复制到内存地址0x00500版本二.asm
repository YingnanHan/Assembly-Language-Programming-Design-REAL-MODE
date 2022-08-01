
;我们要把5个字节复制到内存地址0x00500
;0x00500 = 0xAA
;0x00501 = 0x11
;0x00502 = 0x22
;0x00503 = 0x33
;0x00504 = 0x44

mov ax,0x0050
mov es,ax

mov ax,0x07C0
mov ds,ax

jmp near Code

Data:
db 0xAA,0x11,0x22,0x33,0x44


Code:
mov si,Data
mov di,0
mov cx,Code-Data

StartMove:
mov al,byte[ds:si]
mov byte[es:di],al
inc si
inc di
loop StartMove


End:
jmp near End

times 510-($-$$) db 0x00
db 0x55,0xAA
