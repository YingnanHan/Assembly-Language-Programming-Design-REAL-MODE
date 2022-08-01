;--------------------------------------------------------------------------------
;任意输入两个数，如：123和456，并在屏幕上输出：123+456=579
;如：10000和33333，并在屏幕上输出：43333  

mov ax,0xB800
mov es,ax

mov ax,0x07C0
mov ds,ax

mov di,0  ;是目标内存地址偏移寄存器

jmp near Code

Number1:
dw 888  ;输入第一个数的位置。

Number2:
dw 111  ;输入第二个数的位置。


;Si=0x0017
;bx=5
Split:
; 个，十，百，千，万
db 0,0,0,0,0

Divisor:
dw 10

;第二种用法：
;32位除以16位
;div 16位寄存器
;div 16位内存
;被除数在DX:AX中，商在AX中，余数在DX中。

Code:
;==============输出第一个数===============================
;=初始化被除数===
mov dx,0
mov ax,word[ds:Number1]   ;ds:ax=123
mov bx,Split


;=分解被除数===
StartSplit1:
div word[ds:Divisor]
mov byte[ds:bx],dl
mov dx,0
inc bx
cmp ax,0
jne near StartSplit1

;=为了输出到屏幕上做准备工作===
sub bx,Split ;  bx现在里面存的就是这是一个几位数
mov cx,bx  ; cx是代表loop指令的循环次数
mov si,Split  ;是原始内存地址偏移寄存器
add si,bx
dec si

Print1:
mov al,byte[ds:si]
add al,48
mov byte[es:di],al
inc di
mov byte[es:di],0x07
dec si
inc di
loop Print1


;================输出+号===============================
mov byte[es:di],'+'
inc di
mov byte[es:di],0x07
inc di

;==============输出第二个数===============================
;=初始化被除数===
mov dx,0
mov ax,word[ds:Number2]   ;ds:ax=123
mov bx,Split


;=分解被除数===
StartSplit2:
div word[ds:Divisor]
mov byte[ds:bx],dl
mov dx,0
inc bx
cmp ax,0
jne near StartSplit2

;=为了输出到屏幕上做准备工作===
sub bx,Split ;  bx现在里面存的就是这是一个几位数
mov cx,bx  ; cx是代表loop指令的循环次数
mov si,Split  ;是原始内存地址偏移寄存器
add si,bx
dec si

Print2:
mov al,byte[ds:si]
add al,48
mov byte[es:di],al
inc di
mov byte[es:di],0x07
dec si
inc di
loop Print2

;================输出=号===============================
mov byte[es:di],'='
inc di
mov byte[es:di],0x07
inc di


;==============输出第三个数===============================
;=初始化被除数===
mov dx,0
mov ax,word[ds:Number1]   ;ds:ax=123
add ax,word[ds:Number2]
mov bx,Split


;=分解被除数===
StartSplit3:
div word[ds:Divisor]
mov byte[ds:bx],dl
mov dx,0
inc bx
cmp ax,0
jne near StartSplit3

;=为了输出到屏幕上做准备工作===
sub bx,Split ;  bx现在里面存的就是这是一个几位数
mov cx,bx  ; cx是代表loop指令的循环次数
mov si,Split  ;是原始内存地址偏移寄存器
add si,bx
dec si

Print3:
mov al,byte[ds:si]
add al,48
mov byte[es:di],al
inc di
mov byte[es:di],0x07
dec si
inc di
loop Print3


End:
jmp near End

times 510-($-$$) db 0x00
db 0x55,0xAA
