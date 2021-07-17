;Joaquin Martinez Benjamin

.286
pila segment stack
db 32 dup('stack_')
pila ends

data segment

    cadena db 'reconocer$'
long_letre equ $-cadena
data ends

code segment para 'code'
inicio proc far

assume cs:code,ds:data,ss:pila

push ds
push 0
mov ax,data
mov ds,ax

salir:
mov ax,4c00h
int 21h

inicio endp
code ends

end inicio
