;���³���Ϊ����Ӳ�̵İ˸��˿��Լ�ע��
HD_PORT_DATA		equ	0x1F0	;16bit	���ݶ˿�
HD_PORT_ERROR		equ	0x1F1	;8bit	������ʾ
HD_PORT_COUNT		equ	0x1F2	;8bit	����������������
HD_PORT_LBA28_4		equ	0x1F3	;8bit	LBA28	0-7bit
HD_PORT_LBA28_3		equ	0x1F4	;8bit	LBA28	8-15bit
HD_PORT_LBA28_2		equ	0x1F5	;8bit	LBA28	16-23bit
HD_PORT_LBA28_1		equ	0x1F6	;8bit	LBA28	24-27bit 28-31Ҫ����0xE����������LBA28ģʽ
HD_PORT_STATUS		equ	0x1F7	;8bit	��ʾӲ�̵Ĺ���״̬
HD_PORT_COMMAND		equ	0x1F7	;8bit	����Ӳ�̶�����д
HD_READ			equ	0x20	;������
HD_WRITE		equ	0x30	;д����
HD_SECTION_COUNT	equ	1	;Ҫ��Щ��������������

;��������Ҫ����һ������д��512�ֽڣ�����ÿһ���ֽڶ���0x99
;������ʼ����

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

;���ô���ʼ������ʼ������������
mov al,HD_SECTION_COUNT
mov dx,HD_PORT_COMMAND
out dx,al

;��Ӳ��������,����Ӳ�̣���Ҫ������д������
mov al,HD_WRITE
mov dx,HD_PORT_COMMAND
out dx,al

Waits:
	in al,dx
	and al,0x88	;0x88=1000 1000
	cmp al,0x08	;�����0��˵��׼��������ɣ������������㣬��ô�ͼ�����
	jnz	Waits
	
	mov ax,0x1234			;׼����Ҫд������
	mov dx,HD_PORT_DATA

	mov cx,HD_SECTION_COUNT*512/2	;׼����ѭ������


	WriteLoop:
		out dx,ax
		loop WriteLoop
	
	End:
		jmp near End
	times 510-($-$$) db 0x00
	db 0xAA55
	;0x1F7=0011 0000 ��ʼ׼��д����
	;0x1F7=1011 0000 Ӳ�̽���׼������
	;0x1F7=0011 1000 Ӳ��׼���������