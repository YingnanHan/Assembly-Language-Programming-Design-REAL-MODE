Progarm_Start_Section equ 1;被加载的程序起始扇区。
section Mbr vstart=0x7C00
jmp near Code 

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
shl cx,8    ;cx= cx *256   cx里面现在存储着要读写的循环次数< /FONT> 

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

 


Physical_Address dd 0x00010000

Code:
;cs、ds、es、ss默认都是0x0000
;ss栈段寄存器默认是0x0000   主引导扇区的栈段范围就是0x00000-0x0FFFF之间，也就是64KB。
;sp将在0xFFFF和0x0000之间变化。
mov sp,0x0000
mov bp,0x0000 

;dx:ax
mov dx,word[ds:Physical_Address+2]
mov ax,word[ds:Physical_Address]
mov bx,16  ;除数等于16
div bx   ;商在ax中，余数放到dx中。
;这条指令，相当于把20位的绝对物理地址，分离成段地址：偏移地址的形式。
;段地址位于ax中，偏移地址位于dx中。ax=0x1000 dx=0x0000< /FONT>

mov ds,ax; 把段地址给了ds段寄存器.
mov es,ax; 把段地址给了es段寄存器 


push 0xE000
push Progarm_Start_Section
push 0x0120  ;高8位代表读写扇区长度，低8位0x20代表读,0x30代表写。
push ds
push 0x0000
call 0x0000:Read_Or_Write_HardDisk
add sp,10 

mov dx,word[ds:0x0002]
mov ax,word[ds:0x0000];取出了被加载程序到底有多大。
;现在dx和ax里面存放着，被加载程序的大小。
mov bx,512
div bx ;算出这个程序到底在硬盘上占了几个扇区。
;商在ax中，余数在dx中。

;1.判断dx中的余数是0，减去一个扇区，跳到3.
;2.判断dx中的余数不是0的话，跳到3.
;3.检测AX是不是0.如果是0，跳到5。如果不是0，则跳转到4，再跳转到5.
;4.开始读取剩余的扇区。
;5.把被加载程序的段地址进行全部重定位。 相对地址取出来+0x10000（物理地址）=每个段的绝对物理地址。< /FONT>


cmp dx,0
jnz @3
dec ax 

@3:
cmp ax,0
jz Init_Work

mov cx,ax ;ax里面存放着剩余扇区数。
mov bx,Progarm_Start_Section 


Read_Other_Section:
inc bx
mov ax,ds
add ax,0x0020 ;相当于把内存地址，增加了512个字节。
mov ds,ax 


push 0xE000
push bx  ;要把读的起始扇区，放到了bx里面。
push 0x0120     ;高8位代表读写扇区长度，低8位0x20代表读,0x30代表写。
push ds
push 0x0000
call 0x0000:Read_Or_Write_HardDisk
add sp,10
loop Read_Other_Section 

mov ax,es
mov ds,ax

 

Init_Work:
mov dx,word[ds:0x0008]
mov ax,word[ds:0x0006]
call 0x0000:Calc_Section_Address
;现在dx和ax中存放的是相对汇编地址。
;相对汇编地址加0x10000,算出了绝对物理地址。
;绝对物理地址 除以 16 就得到了绝对的段地址。 

mov word[ds:0x0006],ax  ;Code_Init在内存里面的绝对段地址。
mov cx,[ds:0x000A] ; 把要重定位的段项目数取出来，循环处理
mov bx,0x000C 

Loop_Redirect:
mov dx,word[ds:bx+2]
mov ax,word[ds:bx]
call 0x0000:Calc_Section_Address
mov word[ds:bx],ax
add bx,4
loop Loop_Redirect 

;所有的加载工作，段地址重定位工作，都已经完成了。
;那么就开始，把这个CPU的控制权，交给被加载程序了。
;也就是执行《被加载程序》的第一条指令

call far [ds:0x0004]
jmp near End 

Calc_Section_Address:  ;计算出各个段的绝对段地址，并存放到ax中。
push bx
add ax,word[cs:Physical_Address] ;如果它们产生进位，溢出。cf=1，如果没有产生进位，cf=0
adc dx,word[cs:Physical_Address+2]
;现在dx和ax中存放的，就是某个段的绝对物理地址。
mov bx,16
div bx
;绝对的段地址就肯定是ax中。
pop bx
retf


End:
jmp near End 

times 510-($-$$) db 0x00
dw 0xAA55