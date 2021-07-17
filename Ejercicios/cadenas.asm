;Joaquin Martinez Benjamin

.286
pila segment stack
db 32 dup('stack_')
pila ends

data segment

    cadena db 'AsseMblERZ$'
   cadena2 db 'AsSemBLerz$'
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

dec si                   ;para usar bien el ciclo
dec di
;_______________________
comparaciones:   
inc si
inc di     
mov bh,[si]             ;muevo a bh el contenido de la primer cadena en si, ya que  verifique que ambas son de --->
cmp bh,'$'              ;la misma longitud no evaluo ambas, solo la primera con el centinela
   je iguales           ;si a llegado al centinela la otra cadena tambien lo hizo y por  tanto son iguales
mov ah,[si]
mov al,[di]
cmp ah,al               ; si no, compara lo que hay en el mismo indice de cada cadena
   jne esletra        ; si no es igual salto a ver si es una letra

jmp comparaciones       ; regreso a comparar de nuevo, ya que aun quedan caracteres en la cadena
;_______________________
esletra:                ; en baso los rangos en que estan me doy cuenta si es letra
;_______________________
rangosi:
cmp ah,'a'
jae rango2             ; si es mayor o igual puede ser una minuscula
jnae rango3            ; si no es mayor o igual puede ser una mayuscula
rango2:
cmp ah,'z'                 
jbe rangodi             ; si es menor o igual es minuscula y paso a verificar lo de la otra cadena
;jnbe rango3     
rango3:
cmp ah,'A'
jae rango4             ; si es mayor o igual puede ser una mayuscula
jnae noiguales         ; si despues de no ser minuscula y no ser mayor que 'A' no es letra y no es igual caracter
rango4:
cmp ah,'Z'
jbe rangodi            ; si es menor o igual entonces es una mayuscula y paso a evaluar lo que hay en la otra cadena
jnb noiguales
;_____________________
rangodi:               ; repito el mismo proceso pero esta vez si es una letra salto a compararlas
cmp al,'a'
jae rango5             
jnae rango6
rango5:
cmp al,'z'                 
jbe mayusminus            
;jnbe rango6
rango6:
cmp al,'A'
jae rango7             
jnae noiguales
rango7:
cmp al,'Z'
jbe mayusminus
jnb noiguales
;______________________

mayusminus:   ; para igualar a mayusculas o a minusculas
cmp ah,al
jna igualar   ; si ah es menor que al salto a igualar
sub ah,20h    ; si ah es mayor que al le quito 20
cmp ah,al     ; comparo
jne noiguales ; si no son iguales salto a noiguales
jmp comparaciones ; si son iguales sigo comparando
igualar:
add ah,20h      ;ah era menor que al por tanto se le incrementa 20
cmp ah,al       ; compara y si no son iguales salto a no iguales
jne noiguales
jmp comparaciones  ;si son iguales sigo comparando


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