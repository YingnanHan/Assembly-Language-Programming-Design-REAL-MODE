;db declare byte
;dw declare word
;dq declare quad word
;dd declare double word

;观察下面数据在内存中的分布情况
db 'I miss you' ;内存中如下形式存储数据   49 20 6D 69 73 73 20 79  6F 75 
;小端模式的特点
dw 0x1122,0x3344;内存中如下形式存储数据   22 11 44 33 

dd 0x11223344	;内存中如下形式存储数据	  44 33 22 11


;值得注意的是，在主引导扇区编写汇编指令的时候
;文件的最后 标志末尾 的两个字节的两种形式如下
;① db 0x55,0xAA
;② dw 0xAA55