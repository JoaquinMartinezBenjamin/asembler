.286
pila segment stack
db 32 dup('stack_')
pila ends

data segment
   
arreglo db '9817365493210$' ; leo el arreglo
long_letre equ $-arreglo  ; obtengo su longitud incluyendo el centinela
data ends


code segment para 'code'
inicio proc far

assume cs:code,ds:data,ss:pila

push ds
push 0
mov ax,data
mov ds,ax

;______________________

lea si,arreglo ;agrego si el subindice 0 del arreglo

;______________________

ciclo1:
cmp si,long_letre-2 ; pregunto si "si" es menor que tamanio del arreglo -1 (si es igual ya no es menor),
                     ;-2 porque empieza en 0 y hay un $ de mas
                     je salir            ; si es igual voy a salir, ya que termino el for principal (for (int x=0;x<max-1;x++))
mov di,si           ; muevo a di lo que vale si
inc di               ; incremento di para iniciar lo del segundo for ( for (int y=x+1; y<max; y++))
;___________________________
comparacion:
mov ah,[si]           ;muevo lo del arreglo en los subindices si,di, para poder compararlos
mov al,[di]

cmp ah,al           ; pregunto si ah es menor mayor que al
ja burbuja          ; si es mayor ah que al salto a la etiqueta burbuja para intercambiarlos 
jna ciclo2          ; si no es mayor salto al ciclo 2

;___________________________

burbuja:
mov bh,ah           ;uso bh como auxiliar
mov ah,al
mov al,bh

mov [si], ah        ; ya que tengo correctamente ordenado de menor a mayor ah y al, los paso al arreglo en si y di
mov [di], al
;___________________________

ciclo2:
inc di                ; incremento di (que viene siendo y de mi segundo for)
cmp di,long_letre-1   ; pregunto si di es menor que la longitud del arreglo
jne comparacion       ; si no es menor es igual, pero si no es igual salto a comparaci?n de nuevo, pues no he salido de este for
inc si                 ; si es igual entonces ya no es menor, asi que incremento "si" del primer for
jmp ciclo1             ; salto al ciclo 1 de nuevo

;___________________________
salir:

lea dx,arreglo         ;imprimo el arreglo ya ordenado
mov ah,09h
int 21h

mov ax,4c00h
int 21h
inicio endp
code ends

end inicio
