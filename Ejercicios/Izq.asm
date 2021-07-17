.286
pila segment stack
db 32 dup ('stack_')
pila ends

data segment 
var dw '$'
data ends

code segment
principal proc far
assume cs:code, ds:data, ss:pila
push ds
push 0

mov ax, data
mov ds, ax
mov ah, 00h
mov al, 03h
INT 10H

mov cx, 9
mov ah, 02h
mov dh, 0
mov dl, 30
mov bx, 1

ciclo1:
mov ah, 02h
INT 10H

mov ah, 0Ah
mov al, 42h
mov var, cx
mov cx, bx
INT 10H


add dh, 1
sub dl, 2
add bx, 2
mov cx, var
loop ciclo1

mov cx, 10
mov ah, 02h
mov dh, dh
mov dl, dl
mov bx, bx

ciclo2:
mov ah, 02h
INT 10H

mov ah, 0Ah
mov al, 42h
mov var, cx
mov cx, bx
INT 10H


add dh, 1
add dl, 2
sub bx, 2
mov cx, var
loop ciclo2







ret 
principal endp
code ends
end principal