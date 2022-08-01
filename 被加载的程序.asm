section Header vstart=0
Program_Length  dd Program_End ;程序的大小，占4个字节。
Code_Offset  dw 0x0000  ;要执行的第一条指令的偏移地址
Code_Entry  dd section.Code_Init.start;要执行第一条指令的段地址。 

;段个数
Section_Length  dw (Header_End-Code_Init_Section)/4

;各个段的段地址，重定位表。
Code_Init_Section dd section.Code_Init.start
Code_Main_Section dd section.Code_Main.start
Code_End_Section dd section.Code_End.start
Data_Section dd section.Data.start
Stack_Section dd section.Stack.start

Header_End:

 

Section Code_Init align=16 vstart=0 ;0x0020+0x10000=0x10020
mov ax,0x1111  ;内存地址就是0x10020  段地址：1002  偏移地址是0x0000
mov bx,0x2222
mov cx,0x3333
mov dx,0x4444

Section Code_Main align=16 vstart=0

Section Code_End align=16 vstart=0

Section Data align=16 vstart=0

Section Stack align=16 vstart=0
times 256 db 0x00
Stack_End:

section End
Program_End: