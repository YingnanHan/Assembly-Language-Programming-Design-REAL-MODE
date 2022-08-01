mov ax,0x07C0
mov ds,ax

jmp near Code

Data:
	dw 0x0020,0x0100,0x000f,0x0300,0xff00

Code:
	inc word[ds:Data+0];Ö±½ÓÄÚ´æÑ°Ö·
	inc word[ds:Data+2]
	inc word[ds:Data+4]
	inc word[ds:Data+6]
	inc word[ds:Data+8]