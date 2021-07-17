.286
pila segment stack
db 32 dup('stack_')
pila ends

data segment
   
   mensaje db 'El rat?n no esta' ;

data ends


code segment para 'code'
inicio proc far

assume cs:code,ds:data,ss:pila

push ds
push 0
mov ax,data
mov ds,ax


MOV AX,0000f
INT 33h
CMP AX,FFFFh
JE NOESTARATON
MOV AX, 0001h
INT 33H


NOESTARATON:
lea dx,mensaje   
mov ah,09h
int 21h

salir:



mov ax,4c00h
int 21h
inicio endp
code ends

end inicio