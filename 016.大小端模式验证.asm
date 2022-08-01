mov ax,0x0800
mov ds,ax 

;×Ö½Ú
;mov byte[ds:0001],0x11
;mov byte[ds:0002],0x22
;mov byte[ds:0003],0x33
;mov byte[ds:0004],0x44
;mov byte[ds:0005],0x55
;mov byte[ds:0006],0x66
;mov byte[ds:0007],0x77
;mov byte[ds:0008],0x88
;mov byte[ds:0009],0x99 

;byte
;mov byte[ds:0001],0x11
;mov dx,byte[ds:0001]

;word
;mov word[ds:0001],0x1122;
;mov dx,word[ds:0001]


;dword
mov dword[ds:0001],0x11223344
mov edx,dword[ds:0001]

end:
jmp 0x07C0:end 

times 510-($-$$) db 0x00
db 0x55,0xAA 
