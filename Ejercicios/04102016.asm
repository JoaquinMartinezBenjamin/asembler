.286
pila segment stack
db 32 dup ('stack_')
pila ends

data segment 
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

mov cx, 10
;CONTEO DE CARACTERES PARA 0AH_10H

mov dh, 7
mov dl, 35
ciclo:
mov ah, 02h
INT 10H

mov ah, 0Ah
mov al, 42h
INT 10H

add dh, 1

cmp dh, 17
JNE ciclo

ret 
principal endp
code ends
end principal