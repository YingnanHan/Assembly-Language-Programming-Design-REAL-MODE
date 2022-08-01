mov ax,0x0000
mov ss,ax  ;初始化栈段寄存器
mov sp,0xFFFF ;初始化栈底偏移地址
mov bp,0xFFFF ;初始化栈顶偏移地址

jmp near Code

;封装屏幕输出接口，代码如下

PrintfStr:
push ds  ;保存ds段寄存器的值
push es  ;保存es段寄存器的值
push ax  ;保存ax寄存器的值
push di  ;保存目标地址偏移寄存器
push si  ;保存原始地址偏移寄存器

mov ds,word[ss:bp-2] ;初始化要输出的文本数据段寄存器
mov si,word[ss:bp-4] ;初始化要输出的文本数据偏移寄存器

mov ax,0xB800
mov es,ax  ;初始化显示段寄存器
mov di,word[ds:DisPlayIndex]

PrintfLoop:
mov al,byte [ds:si]
cmp al,0
jz PrintfEnd
mov byte[es:di],al
inc di
mov byte[es:di],0x07
inc di
inc si
jmp near PrintfLoop

PrintfEnd:
mov word[ds:DisPlayIndex],di
pop si
pop di
pop ax
pop es
pop ds
retf

 

String: 
db '123456789',0x00

String2:
db '       I  Like  You',0x00

DisPlayIndex:
dw 0x0000

 

Code:
push 0x07C0;  压入文本所在段寄存器
push String;  压入文本所在偏移寄存器
call 0x07C0:PrintfStr  ;调用输出接口
add sp,4   ;清空栈内垃圾数据
 
push 0x07C0;  压入文本所在段寄存器
push String2;  压入文本所在偏移寄存器
call 0x07C0:PrintfStr  ;调用输出接口
add sp,4  ;清空栈内垃圾数据


End:
jmp near End

times 510-($-$$) db 0x00
dw 0xAA55
