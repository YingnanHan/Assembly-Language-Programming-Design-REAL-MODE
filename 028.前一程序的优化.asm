
mov ax,0xB800
mov es,ax;   ��ʼ����ʾ�μĴ���

mov ax,0x07C0
mov ds,ax;   ��ʼ�����ݶμĴ���

mov si,0;   ��ʼ�����ݶ� ƫ�ƼĴ���
mov di,0;   ��ʼ����ʾ�� ƫ�ƼĴ���

jmp near code

Age:
db 17;   ��������ĵط�

Adult:
db 'Adult'

Minor:
db 'Minor'


code:
mov al,byte[ds:Age]
cmp al,18  ;CF=1��Ҳ��������������18��С��     ;CF=0  ˵��������������18�꣬���ߵ���18�ꡣ �Ѵ��븳����������ʵ�����壨��꣩
JNB PrintAdult  ;���alС��18�꣬����ת��

PrintMinor: ;����Ļ�����δ������
mov cx,code-Minor   ;ȷ��Ҫ��������ֽ�
mov si,Minor
jmp near StartPrint

PrintAdult: ;����Ļ�����������
mov cx,Minor-Adult  ;ȷ��Ҫ��������ֽ�
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
