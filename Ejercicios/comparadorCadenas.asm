;Joaquin Martinez Benjamin

.286
pila segment stack
db 32 dup('stack_')
pila ends

data segment

     cadena db 'Assembler$'
     cadena2 db 'Assembler$'
    sies db 'Las cadenas son iguales$'
    noes db 'Las cadenas no son iguales$' 
long_letre equ $-cadena
long_letre2 equ $-cadena2
data ends

code segment para 'code'
inicio proc far

assume cs:code,ds:data,ss:pila

push ds
push 0
mov ax,data
mov ds,ax
;_______________________

lea si, [cadena+long_letre-2]
lea di, [cadena2+long_letre2-2]
cmp si,di               ;si las longitudes de las cadenas no son iguales en automatico las cadenas no lo son
jne noiguales

;_______________________
lea si,cadena           ;leo ambas cadenas e inicializo los indices
lea di,cadena2

;_______________________
comparaciones:        
mov bh,[si]             ;muevo a bh el contenido de la primer cadena en si, ya que  verifique que ambas son de --->
cmp bh,'$'              ;la misma longitud no evaluo ambas, solo la primera con el centinela
   je iguales           ;si a llegado al centinela la otra cadena tambien lo hizo y por  tanto son iguales
mov ah,[si]
mov al,[di]
cmp ah,al               ; si no, compara lo que hay en el mismo indice de cada cadena
   jne noiguales        ; si no es igual salto a noiguales
inc si                  ; si es igual incremento si y di
inc di
jmp comparaciones       ; regreso a comparar de nuevo, ya que aun quedan caracteres en la cadena
;_______________________

iguales:
                        ;imprimo mensaje de que son iguales
mov ah,09h
lea dx,sies
int 21h
jmp salir
;_______________________
noiguales:              ;imprimo mensaje de que no son iguales

mov ah,09h
lea dx,noes
int 21h

;_______________________

salir:
mov ax,4c00h
int 21h

inicio endp
code ends

end inicio