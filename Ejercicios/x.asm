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

mov cx, 1
;CONTEO DE CARACTERES PARA 0AH_10H

mov dh, 00
mov dl, 00
ciclo:
mov ah, 02h
INT 10H

mov ah, 0Ah
mov al, 42h
INT 10H

add dh, 1
add dl, 3

cmp dh, 25 ; para que no salga de 24
JNE ciclo


mov dh, 24
mov dl, 0
ciclo2:
mov ah, 02h
INT 10H

mov ah, 0Ah
mov al, 42h
INT 10H

sub dh, 1
add dl, 3

cmp dh, -1 ;para que no salga de cero
JNE ciclo2



ret 
principal endp
code ends
end principal