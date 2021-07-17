;Joaquin Martinez Benjamin

.286
pila segment stack
db 32 dup('stack_')
pila ends

data segment
sies db 'Palidromo$'
noes db 'No Palidromo$'
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

lea si,cadena
lea di,[cadena+long_letre-2]

ciclo:
mov al,[si] ;mueve el caracter de si
mov ah,[di] ;mueve el caracter de di
cmp al,ah   ;compara caracteres
jne nopali  ;si no son iguales salta a nopali
inc si      ; si si son iguales incrementa si
dec di      ;incrementa di
cmp si,di   ;compara si "si" es menor a "di"
jb ciclo   ; si "si" sigue siendo menor que "di" vuelve al ciclo 
           ; esto para evaluar cadenas de longitud par




palidromo:             ; si "si" ya es mayor que di no hay nada que evaluar m?s, y si llego a esta parte sin -->
                       ; ir a nopali entonces es un palindromo y salta a salir
mov ah,09h
lea dx,sies
int 21h
jmp salir

nopali:              ; si llega a esta parte es que antes de que "si" fuera mayor que "di" hay un caracter no igual
                     ; y salta a salir
mov ah,09h
lea dx,noes
int 21h
jmp salir

salir:
mov ax,4c00h
int 21h

inicio endp
code ends

end inicio


