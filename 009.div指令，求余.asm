mov ax,0xB800
mov es,ax 
mov ax,0x07C0
mov ds,ax
jmp 0x07C0:code 
;  百位,十位,个位
temp:
db 0x00,0x00,0x00
;通过求余数来输出一个数字上的每一位
code:
mov ax,123   ;准备好被除数
mov cl,10D    ;准备好除数
;===================================
div cl ; al=C,ah=3		不断的取余数
mov byte[ds:temp+2],ah

mov ah,0x00
div cl
mov byte[ds:temp+1],ah


mov ah,0x00
div cl
mov byte[ds:temp+0],ah

;===================================
mov al,byte [ds:temp+0]
add al,48
mov byte[es:0],al
mov byte[es:1],7


mov al,byte [ds:temp+1]
add al,48
mov byte[es:2],al
mov byte[es:3],7

mov al,byte [ds:temp+2]
add al,48
mov byte[es:4],al
mov byte[es:5],7


;===================================

end:
jmp 0x07C0:end

times 510-($-$$) db 0x00
db 0x55,0xAA 

