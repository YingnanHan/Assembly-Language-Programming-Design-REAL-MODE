xor ax,ax
;inc ax
;inc ax
;inc ax
;inc ax
;inc ax
;inc ax
;inc ax
;inc ax
;inc ax
;inc ax
;注意上述代码的目的是对ax寄存器增加一定的次数，然而主引导扇区只能粗出512字节的代码，
;但是这种方式由于需要过多的指令，于是就会大量的浪费内存空间，下面利用loop指令解决这个问题
end:
jmp	0x7C00:end

times 210-($-$$) db 0x00
db 0x55,0xAA