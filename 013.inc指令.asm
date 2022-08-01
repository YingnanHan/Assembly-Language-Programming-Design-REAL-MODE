mov ax,10

add ax,1
inc ax ;<=> add ax,1
sub ax,3
dec ax	;<=> sub ax,1

xor ax,ax

end:
jmp 0x7c00:end

times 510-($-$$) db 0x00
db 0x55,0xAA