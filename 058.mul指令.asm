;8bit�˷�
mov al,125
mov bl,230
mul bl

;16bit�˷�
mov ax,200
mov bx,300
mul bx

jmp $
times 510-($-$$) db 0x00
db 0xAA55
