;leer numero en ensamblador en decimal e imprimirlo binario


.286
pila segment stack
db 32 dup('stack_')
pila ends

data segment
    cadena db '123$'
num1 dw 02
num2 dw 04
num3 dw 0h
data ends


code segment para 'code'
inicio proc far

assume cs:code,ds:data,ss:pila

push ds
push 0
mov ax,data
mov ds,ax
;_________________

;_________________

mov cx, num2 
mov ax, num1
label:
 mov bx,num1
 mul bx ;ax = ax * bx
 loop label ;c--

mov num3,ax ;copiamos el resultado
;_________________
MOV cx,0
MOV bx,num3
MOV ah,02h

ciclo:
inc cx
cmp cx,9
je salir
ROL bl,1

JC etiqueta1
JNC etiqueta2


etiqueta1:

MOV dl,'1'
INT 21h
JMP ciclo

etiqueta2:
MOV dl,'0'
INT 21h
JMP ciclo
;_________________

salir:

mov ax,4c00h
int 21h
inicio endp
code ends

end inicio