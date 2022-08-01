
mov ax,0xB800
mov es,ax;   初始化显示段寄存器

mov ax,0x07C0
mov ds,ax;   初始化数据段寄存器

mov si,0;   初始化数据段 偏移寄存器
mov di,0;   初始化显示段 偏移寄存器

jmp near code

Age:
db 17;   输入年龄的地方

Adult:
db 'Adult'

Minor:
db 'Minor'


code:
mov al,byte[ds:Age]
cmp al,18  ;CF=1，也就是输入的年龄比18岁小，     ;CF=0  说明输入的年龄大于18岁，或者等于18岁。 把代码赋予了我们现实的意义（灵魂）
JNB PrintAdult  ;如果al小于18岁，则跳转。

PrintMinor: ;在屏幕上输出未成年人
mov cx,code-Minor   ;确定要输出几个字节
mov si,Minor
jmp near StartPrint

PrintAdult: ;在屏幕上输出成年人
mov cx,Minor-Adult  ;确定要输出几个字节
mov si,Adult

 

StartPrint:
mov al,[ds:si]
mov byte [es:di],al
inc di
mov byte [es:di],0x07
inc si
inc di
loop StartPrint


end:
jmp 0x07C0:end

times 510-($-$$) db 0x00
db 0x55,0xAA
