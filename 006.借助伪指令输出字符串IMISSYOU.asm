mov ax,0xB800;显存地址
mov es,ax
mov ax,0x07C0
mov ds,ax

jmp 0x07C0:code

string:
db 'I miss you'

code:
mov al,[ds:string+0]	;<=>mov al,[0x07C0A]
mov byte [es:0x0000],al
mov byte [es:0x0001],0x70

mov al,[ds:string+1]
mov byte [es:0x0002],al
mov byte [es:0x0003],0x70

mov al,[ds:string+2]
mov byte [es:0x0004],al
mov byte [es:0x0005],0x70

mov al,[ds:string+3]
mov byte [es:0x0006],al
mov byte [es:0x0007],0x70

mov al,[ds:string+4]
mov byte [es:0x0008],al
mov byte [es:0x0009],0x70

mov al,[ds:string+5]
mov byte [es:0x000A],al
mov byte [es:0x000B],0x70

mov al,[ds:string+6]
mov byte [es:0x000C],al
mov byte [es:0x000D],0x70

mov al,[ds:string+7]
mov byte [es:0x000E],al
mov byte [es:0x000F],0x70

mov al,[ds:string+8]
mov byte [es:0x0010],al
mov byte [es:0x0011],0x70

mov al,[ds:string+9]
mov byte [es:0x0012],al
mov byte [es:0x0013],0x70

mov al,[ds:string+A]
mov byte [es:0x0014],al
mov byte [es:0x0015],0x70

end:
jmp 0x07C0:end

times 510-($-$$) db 0x00   ;注意这里一定是512个字节，不然主引导扇区会崩溃
db 0x55,0xAA
