[org 0x0100]
jmp start

h1: db 'Word Hunt Game', 0
h2: db 'Score: ', 0
h3: db 'Enter Word: ', 0
m1: db 'S', 0
m2: db 'K', 0
m3: db 'Y', 0
m4: db 'N', 0
m5: db 'S', 0
m6: db 'A', 0
m7: db 'N', 0
m8: db 'U', 0
m9: db 'B', 0
m10: db 'I', 0
m11: db 'O', 0
m12: db 'S', 0
m13: db 'W', 0
m14: db 'O', 0
m15: db 'N', 0
m16: db 'S', 0

maxlength: dw 80
buffer: times 81 db 0
points: dw 0
words: db "skyn", "sanu", "bios", "wons", "snow", "soib", "ssun", "bay", "winn", "yab", "nniw", "uoo"
msg2: db 'InCorrect', 10, 13, '$'
msg1: db 10, 13, 'YOU WON!! :)', 10, 13, '$'

clrscr:
mov ax, 0xb800
mov es, ax
xor di, di
mov ax, 0x0720
mov cx, 2000
cld
rep stosw
ret

drawrect:
push bp
mov  bp, sp
pusha

mov al, 80
mul byte [bp + 10] 
add ax,  [bp + 6]		 
shl ax, 1

mov di, ax
push di

mov ah, 0x07
mov cx, [bp + 4]
sub cx, [bp + 6]
push cx
mov al, '-'

l1:
rep stosw
pop bx
pop di
push bx
dec bx	

shl bx, 1
add di, 160
mov cx, [bp + 8]
sub cx, [bp + 10] 
sub cx, 2
mov al, '|' 

l2:
mov si, di
mov word [es:si], ax

add si, bx
mov word [es:si], ax

sub si, bx
add di, 160
loop l2

pop cx
mov al, '-'

l3:
rep stosw

return:	
popa
pop bp
ret 8		

strlen: 
push bp
mov bp,sp
push es
push cx
push di

les di, [bp + 4] 
mov cx, 0xffff
xor al, al
repne scasb

mov ax, 0xffff
sub ax, cx
dec ax 

pop di
pop cx
pop es
pop bp
ret 4

printstr: 
push bp
mov bp, sp
push es
push ax
push cx
push si
push di

push ds
mov ax, [bp + 4]
push ax

call strlen

cmp ax, 0
jz exit

mov cx, ax

mov ax, 0xb800
mov es, ax
mov al, 80
mul byte [bp + 8]
add ax, [bp + 10]
shl ax, 1
mov di, ax
mov si, [bp + 4]
mov ah, [bp + 6]

cld

nextchar: 
lodsb
stosw
loop nextchar

exit:
pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 8		

printnum1: 
push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di

mov ax, 0xb800
mov es, ax 
mov ax, [bp + 4]
mov bx, 10
mov cx, 0

nextdigit1: 
mov dx, 0
div bx
add dl, 0x30
push dx
inc cx
cmp ax, 0
jnz nextdigit1

mov di, 18 

nextpos1: 
pop dx 
mov dh, 0x09
mov [es:di], dx
add di, 2
loop nextpos1

pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 2

grid:
push word 6
push word 19
push word 20
push word 49
call drawrect

push word 6
push word 10
push word 20
push word 49
call drawrect

push word 6
push word 13
push word 20
push word 49
call drawrect

push word 6
push word 16
push word 20
push word 49
call drawrect

push word 6
push word 19
push word 20
push word 42
call drawrect

push word 6
push word 19
push word 20
push word 35
call drawrect

push word 6
push word 19
push word 20
push word 28
call drawrect

mov ax, 23
push ax
mov ax, 8
push ax
mov ax, 0x2
push ax
mov ax, m1
push ax
call printstr

mov ax, 30
push ax
mov ax, 8
push ax
mov ax, 0x2
push ax
mov ax, m2
push ax
call printstr

mov ax, 37
push ax
mov ax, 8
push ax
mov ax, 0x2
push ax
mov ax, m3
push ax
call printstr

mov ax, 44
push ax
mov ax, 8
push ax
mov ax, 0x2
push ax
mov ax, m4
push ax
call printstr

mov ax, 23
push ax
mov ax, 11
push ax
mov ax, 0x2
push ax
mov ax, m5
push ax
call printstr

mov ax, 30
push ax
mov ax, 11
push ax
mov ax, 0x2
push ax
mov ax, m6
push ax
call printstr

mov ax, 37
push ax
mov ax, 11
push ax
mov ax, 0x2
push ax
mov ax, m7
push ax
call printstr

mov ax, 44
push ax
mov ax, 11
push ax
mov ax, 0x2
push ax
mov ax, m8
push ax
call printstr

mov ax, 23
push ax
mov ax, 14
push ax
mov ax, 0x2
push ax
mov ax, m9
push ax
call printstr

mov ax, 30
push ax
mov ax, 14
push ax
mov ax, 0x2
push ax
mov ax, m10
push ax
call printstr

mov ax, 37
push ax
mov ax, 14
push ax
mov ax, 0x2
push ax
mov ax, m11
push ax
call printstr

mov ax, 44
push ax
mov ax, 14
push ax
mov ax, 0x2
push ax
mov ax, m12
push ax
call printstr

mov ax, 23
push ax
mov ax, 17
push ax
mov ax, 0x2
push ax
mov ax, m13
push ax
call printstr

mov ax, 30
push ax
mov ax, 17
push ax
mov ax, 0x2
push ax
mov ax, m14
push ax
call printstr

mov ax, 37
push ax
mov ax, 17
push ax
mov ax, 0x2
push ax
mov ax, m15
push ax
call printstr

mov ax, 44
push ax
mov ax, 17
push ax
mov ax, 0x2
push ax
mov ax, m16
push ax
call printstr

ret 10



start:
call clrscr

mov ax, 29
push ax
mov ax, 4
push ax
mov ax, 0x6
push ax
mov ax, h1
push ax
call printstr

mov ax, 0
push ax
mov ax, 1
push ax
mov ax, 0x9
push ax
mov ax, h2
push ax
call printstr

mov ax, 1
push ax
mov ax, 5
push ax
mov ax, 0x3
push ax
mov ax, h3
push ax
call printstr

call grid

setcursor:
mov ah, 2
mov bh, 0
mov dl, 0
mov dh, 7
int 10h
mov ah, 01
int 21h

input:
mov cx, [maxlength] 		; load maximum length in cx
mov si, buffer 			; point si to start of buffer
nextchar0: 
mov ah, 1 			; service 1 – rsead character
int 0x21 			; dos services
cmp al, 13 			; is enter pressed
je ex 				; yes, leave input
mov [si], al 			; no, save this character
inc si 				; increment buffer pointer
loop nextchar0 			; repeat for next input char
ex: 
mov byte [si], '$' 		; append $ to user input

push ds
push words
push ds
push buffer
call comp

comp:
push bp
mov  bp, sp
pusha
mov  dx, (45 - 4) + 1   ; Possible finds
next:
mov  cx, 3
lds  si, [bp + 4]       ; *words (constant)
les  di, [bp + 8]       ; *buffer (varying)
repe cmpsb
je   Found
inc  word [bp + 8]
dec  dx
jnz  next

notFound:
mov dx, msg2
mov ah, 9
int 21h
jmp input

Found:
mov ax, [points]
add ax, 10
mov [points], ax
push ax
call printnum1

cmp ax, 70
je victory
jmp input

victory:
mov dx, msg1
mov ah, 9
int 21h

terminate:
mov ax, 0x4c00
int 21h
