;以下常量为操作硬盘的八个端口以及注释
HD_PORT_DATA		equ	0x1F0	;16bit	数据端口
HD_PORT_ERROR		equ	0x1F1	;8bit	错误提示
HD_PORT_COUNT		equ	0x1F2	;8bit	操作扇区数量长度
HD_PORT_LBA28_4		equ	0x1F3	;8bit	LBA28	0-7bit
HD_PORT_LBA28_3		equ	0x1F4	;8bit	LBA28	8-15bit
HD_PORT_LBA28_2		equ	0x1F5	;8bit	LBA28	16-23bit
HD_PORT_LBA28_1		equ	0x1F6	;8bit	LBA28	24-27bit 28-31要求是0xE，代表启动LBA28模式
HD_PORT_STATUS		equ	0x1F7	;8bit	显示硬盘的工作状态
HD_PORT_COMMAND		equ	0x1F7	;8bit	告诉硬盘读或者写
HD_READ			equ	0x20	;读扇区
HD_WRITE		equ	0x30	;写扇区
HD_SECTION_COUNT	equ	1	;要读些扇区的数量长度

;假设现在要往第一个扇区写入512字节，并且每一个字节都是0x99
;设置起始扇区

;0xE0000001
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

;设置从起始扇区开始操作几个扇区
mov al,HD_SECTION_COUNT
mov dx,HD_PORT_COMMAND
out dx,al

;给硬盘下命令,告诉硬盘，需要往里面写东西了
mov al,HD_WRITE
mov dx,HD_PORT_COMMAND
out dx,al

Waits:
	in al,dx
	and al,0x88	;0x88=1000 1000
	cmp al,0x08	;如果是0，说明准备工作完成，如果结果不是零，那么就继续等
	jnz	Waits
	
	mov ax,0x1234			;准备好要写的数据
	mov dx,HD_PORT_DATA

	mov cx,HD_SECTION_COUNT*512/2	;准备好循环次数


	WriteLoop:
		out dx,ax
		loop WriteLoop
	
	End:
		jmp near End
	times 510-($-$$) db 0x00
	db 0xAA55
	;0x1F7=0011 0000 开始准备写工作
	;0x1F7=1011 0000 硬盘进入准备工作
	;0x1F7=0011 1000 硬盘准备工作完成