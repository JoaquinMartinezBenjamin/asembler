pila segment stack
db 32 dup('stack_')
pila ends

data segment
    msj db 'El numero de letras "a" en la cadena; $' ;mensaje para imprimir resultado
    msj2 db ' es: $'                         ;mensaje para imprimir resultado
    cadena db '"Ensamblador aaaaaaaaaa"$'             ; cadena para evaluar 12 a's
    long_letre equ $-cadena                      ; para longitud de la cadena (estaba en el programa palindrome)

    ;x db 0                    ; declaro una variable de tipo numerica
data ends

code segment para 'code'
inicio proc far

assume cs:code,ds:data,ss:pila

push ds
push 0
mov ax,data
mov ds,ax


lea si,cadena   ; ingreso en si la cadena
mov ah, 61h     ; ingreso en ah la referencia ascci de 'a' (61h)
mov ch, [long_letre-1] ; ingreso en ch el tama?o real de la cadena
mov cl,0              ; cl ser? el contador de indice   
mov bx,0              ; bx ser? el contador de a?s


ciclo:
mov al,[si]         ; muevo a al lo que hay en el indice [si]

cmp al,ah            ; comparo si lo que hay en ese indice es igual a una 'a'
je contador          ; si si es igual me voy a la etiqueta contador
jne salir;           ; si no es igual me voy a la etiqueta salir para no pasar por contador

contador:
add bx, 1            ; ya que se sabe que es una a bx incrementa en uno pues cuenta las a?s

salir:               ; ya sea por salto o por terminar la etiqueta contador se llega a la etiqueta salir
add cl, 1            ; se aumenta cl que es el contador de indice
inc si               ; se recorre el indice en uno
cmp ch,cl            ; se compara si el ancho de la cadena es el igual al contador de indices

jne ciclo;            ; si no es igual a?n quedan indices por evaluar y se regresa al ciclo

 
  
mov al, bl;           ; si si es igual continua y mueve a al la parte baja de bx, bx es nuestro contador de a?s
aam;                    ;ajusta el valor en Al por: ah=1 y al=2 en el caso de mi cadena que tiene 12 a?s
                        ; esto debido a que sin la separaci?n se obtiene un caracter no numerico, o solo tendr?a
                        ; posibilidad de contar del 0 al 9, en teoria asi se podria contar hasta el 99 en numeros legiblee
mov bh, ah    ;muevo a bh lo que hay en ah, para ingresar despues la funci?n
mov bl, al    ;muevo a bl lo que hay en al, para ingresar despues la funci?n


add bl, 30h   ; sumo 30h para obtener un valor numerico
add bh, 30h   ; sumo 30h para obtener un valor numerico

;;mensaje de cadena
  lea dx, msj
  mov ah, 09
      int 21h
        
  lea dx, cadena
  mov ah, 09
      int 21h
        
  lea dx, msj2
  mov ah, 09
      int 21h
;;;;;;;;;;;;;
;Imprimo lo que hay en la parte alta de bx (1)
mov ah,02h 
mov dl, bh 
int 21h;
 
;Imprimo lo que hay en la parte baja de bx (2)
mov dl, bl ;
int 21h;

;retorno y cierro
 
ret 

inicio endp
code ends

end inicio
