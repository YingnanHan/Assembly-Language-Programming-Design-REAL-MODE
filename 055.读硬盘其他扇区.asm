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

 


;设置起始扇区
mov al,0x01
mov dx,HD_PORT_LBA28_4
out dx,al 

mov al,0x00
mov dx,HD_PORT_LBA28_3
out dx,al 

mov dx,HD_PORT_LBA28_2
out dx,al 

mov al,0xE0
mov dx,HD_PORT_LBA28_1
out dx,al 

;设置要操作几个扇区。
mov al,HD_SECTION_COUNT
mov dx,HD_PORT_COUNT
out dx,al 

 

;告诉命令端口我要写硬盘
mov al,HD_READ
mov dx,HD_PORT_COMMAND
out dx,al 

 


Waits:  
	in al,dx
	;0x1F1=0010 0000 写
	;为了方便只关注第7位和第3位的状态，我们把其他位都变为0
	;0x1F1=1010 0000 忙碌   1011 0000 and 1000 1000 = 1000 0000
	;0x1F1=0010 1000 请就发送数据，或者接受数据 0011 1000 and 1000 1000=0000 1000

	and al,0x88 ;0x88=0x10001000  两种可能性：1000 0000=忙碌  0000 1000=开始工作
	cmp al,0x08
	jnz Waits  


;把要读的数据放入到数据端口中
mov dx,HD_PORT_DATA
mov cx,HD_SECTION_COUNT * 512 / 2
mov ax,0x07E0
mov ds,ax
mov di,0  

WriteLoop:
	in ax,dx
	mov word[ds:di],ax  
	add di,2
	loop WriteLoop  


;准备屏幕输出工作：
mov ax,0x0000
mov ss,ax  ;初始化栈段寄存器
mov sp,0xFFFF ;初始化栈底偏移地址
mov bp,0xFFFF ;初始化栈顶偏移地址  

jmp near Code  

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


