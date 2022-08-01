;以下常量为操作硬盘的8个端口及注释
HD_PORT_DATA equ 0x1F0 ;16位 数据端口
HD_PORT_ERROR equ 0x1F1 ;8位 错误提示
HD_PORT_COUNT equ 0x1F2 ;8位 操作扇区数量长度
HD_PORT_LBA28_4 equ 0x1F3 ;8位 LBA28 0~7位
HD_PORT_LBA28_3 equ 0x1F4 ;8位 LBA28 8~15位
HD_PORT_LBA28_2 equ 0x1F5 ;8位 LBA28 16~23位
HD_PORT_LBA28_1 equ 0x1F6 ;8位 LBA28 24~27位 28~31位要求是0xE，代表启动LBA28模式
HD_PORT_STATUS equ 0x1F7 ;8位 显示硬盘的工作状态
HD_PORT_COMMAND equ 0x1F7 ;8位 告诉硬盘读或者写。
HD_READ  equ 0x20 ;读扇区
HD_WRITE equ 0x30 ;写扇区
HD_SECTION_COUNT equ 1;要读写扇区数量的长度 

mov ax,0x0000
mov ss,ax  ;初始化栈段寄存器
mov sp,0xFFFF ;初始化栈底偏移地址
mov bp,0xFFFF ;初始化栈顶偏移地址


jmp near Code
;接口代码全部写到这里。

Temp:
db '123456789 987654321 123456789 987654321 123456789 987654321 123456789 987654321 123456789 987654321 123456789 987654321 123456789 987654321 123456789 987654321 123456789 987654321',0x00

Read_Or_Write_HardDisk:
;实现接口，要考虑，这个接口里面使用到哪些寄存器，先保护起来。
;保存现场
push ds
push ax
push dx
push di
push cx

;接口真正实现代码如下：

;设置起始操作扇区
mov ds,word[ss:bp-8]   ;初始化要读写的内存的段地址
mov di,word[ss:bp-10]   ;初始化要读写的内存的偏移地址

mov al,byte[ss:bp-1]
mov dx,0x1F6;HD_PORT_LBA28_1
out dx,al


mov al,byte[ss:bp-2]
mov dx,0x1F5;HD_PORT_LBA28_2
out dx,al

mov al,byte[ss:bp-3]
mov dx,0x1F4;HD_PORT_LBA28_3
out dx,al


mov al,byte[ss:bp-4]
mov dx,0x1F3;HD_PORT_LBA28_4
out dx,al

mov al,byte[ss:bp-5]
mov dx,0x1F2
out dx,al   ;HD_PORT_COUNT   8位操作扇区数量长度

mov al,byte[ss:bp-6]
mov dx,0x1F7
out dx,al   ;HD_PORT_COMMAND   8位 告诉硬盘，我要准备读，或者写。


Waits:
in al,dx
and al,0x88
cmp al,0x08
jnz Waits

mov dx,0x1F0  ;把dx初始化成读写数据端口
xor ch,ch   ;把cx寄存器高8位置0
mov cl,byte[ss:bp-5]      ;cx里面存储的是循环的次数。   2 * 256
shl cx,8    ;cx= cx *256   cx里面现在存储着要读写的循环次数

cmp byte[ss:bp-6],0x20  ; 如果等于0，则进行批量读操作，如果不等于0,则进行批量写操作
jnz Write_Loop


Read_Loop:
in ax,dx
mov word [ds:di],ax
add di,2
loop Read_Loop
jmp near Read_Or_Write_HardDisk_End


Write_Loop:
mov ax,word [ds:di]
out dx,ax
add di,2
loop Write_Loop


;恢复现场
Read_Or_Write_HardDisk_End:
pop cx
pop di
pop dx
pop ax
pop ds
retf

;封装屏幕输出接口，代码如下
DisPlayIndex:
dw 0x0000

PrintfStr:
;接口使用说明如下：

;push 0x07C0;  压入屏幕输出文本所在段寄存器
;push String;  压入屏幕输出文本所在偏移寄存器
;push 0x07C0;  压入DisPlayIndex所在的段寄存器。
;push DisPlayIndex;压入DisPlayIndex所在的偏移寄存器。
;call 0x07C0:PrintfStr  ;调用输出接口
;add sp,8   ;清空栈内垃圾数据

push ds  ;保存ds段寄存器的值
push es  ;保存es段寄存器的值
push ax  ;保存ax寄存器的值
push di  ;保存目标地址偏移寄存器
push si  ;保存原始地址偏移寄存器

mov ds,word[ss:bp-6] ;初始化DisPlayIndex的段寄存器
mov si,word[ss:bp-8] ;初始化DI寄存器，DI寄存器内部存储着屏幕上的输出位置。
mov di,word[ds:si]

mov ds,word[ss:bp-2] ;初始化要输出的文本数据段寄存器
mov si,word[ss:bp-4] ;初始化要输出的文本数据偏移寄存器

mov ax,0xB800
mov es,ax  ;初始化显示段寄存器


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
mov ds,word[ss:bp-6]
mov si,word[ss:bp-8]
mov word[ds:si],di
pop si
pop di
pop ax
pop es
pop ds
retf


Code:
push 0xE000
push 0x0001  ;0xE000 0001  使用LBA28模式，起始扇区的位置是0x000 0001
push 0x0320  ;高8位代表读写扇区长度，低8位0x20代表读，0x30代表写。
push 0x07E0
push 0x0000
call 0x07C0:Read_Or_Write_HardDisk
add sp,10


push 0x07E0;  压入屏幕输出文本所在段寄存器
push 0x0000;  压入屏幕输出文本所在偏移寄存器
push 0x07C0;  压入DisPlayIndex所在的段寄存器。
push DisPlayIndex;压入DisPlayIndex所在的偏移寄存器。
call 0x07C0:PrintfStr  ;调用输出接口
add sp,8   ;清空栈内垃圾数据


End:
jmp near End

times 510-($-$$) db 0x00
dw 0xAA55
