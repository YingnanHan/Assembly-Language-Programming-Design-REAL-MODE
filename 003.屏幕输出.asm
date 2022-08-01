mov ax,0xB800
mov es,ax

mov byte [es:0x0000],'H';
mov byte [es:0x0001],0x17;代表黑底白字

mov byte [es:0x0002],'e';
mov byte [es:0x0003],0x17;代表黑底白字

mov byte [es:0x0004],'l';
mov byte [es:0x0005],0x17;代表黑底白字

mov byte [es:0x0006],'l';
mov byte [es:0x0007],0x17;代表黑底白字

mov byte [es:0x0008],'o';
mov byte [es:0x0009],0x17;代表黑底白字

mov byte [es:0x000A],' ';
mov byte [es:0x000B],0x17;代表黑底白字

mov byte [es:0x000C],'W';
mov byte [es:0x000D],0x17;代表黑底白字

mov byte [es:0x000E],'o';
mov byte [es:0x000F],0x17;代表黑底白字

mov byte [es:0x0010],'r';
mov byte [es:0x0011],0x17;代表黑底白字

mov byte [es:0x0012],'l';
mov byte [es:0x0013],0x17;代表黑底白字

mov byte [es:0x0012],'d';
mov byte [es:0x0013],0x17;代表黑底白字

mov byte [es:0x0014],'!';
mov byte [es:0x0015],0x17;代表黑底白字

times 510-($-$$) db 0x00   ;注意这里一定是512个字节，不然主引导扇区会崩溃
db 0x55,0xAA