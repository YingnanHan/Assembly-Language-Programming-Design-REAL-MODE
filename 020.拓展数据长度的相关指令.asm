mov eax,0x22222222
mov edx,0x22222222

mov al,15;mov al,0x0F
;数据拓展指令使用实例
cbw	;将al数据拓展到ax只针对有符号数

;将指令拓展到32位，由于早期的计算机只有16位，存不下32位，就将AX，DX分别用来存储拓展之后字节低位和高位
mov ax,-3	;ax=0xFFFD
cwd		;dx:ax=组合为一个32位寄存器 其结果为0xFFFFFFFD

;将指令拓展到32位近代计算机，直接拓展到EAX寄存器中存储
mov ax,-3	;ax=0xFFFD
cwde		;EAX=其结果为0xFFFFFFFD


;将指令拓展到64位寄存器，在早期的32位计算机中 将EAX,EDX组合起来构成一个64位寄存器
mov ax,-3	;EAX=0xFFFFFFFD
cdq


end:
jmp 0x7C00:end

times 510-($-$$) db 0x00
dw 0xAA55