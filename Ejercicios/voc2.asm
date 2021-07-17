;JOAQUIN MARTINEZ BENJAMIN
;OBTENER LA VOCAL AL DAR CLICK IZQUIERDO

.286
pila SEGMENT stack
DB 32 DUP ('stack___')
pila ENDS
datos SEGMENT

   
ARRE DB  'a e i o u','$'
SALTO DB 0DH, 0AH,,'$'
    
let1 DB 'seleccionar una vocal (salir con click derecho)',0DH,0AH,'$'

fila db (?),'$'
columna db (?),'$'
valorx dw (0),'$'
valory dw (0),'$'

    
datos ENDS
codigo SEGMENT 'CODE'
Assume ss:pila, ds:datos, cs:codigo
Main PROC FAR
PUSH DS
PUSH 0
MOV AX, datos
MOV DS,AX

      
; limpiar pantalla
mov ax,0600h    ;AH 06 (recorrido), AL 00 (pantalla completa)
mov bh,70H      ;Atributo; blanco (7) sobre azul(1)
mov cx,0000h    ;Esquina superior izquierda renglon : columna 
mov dx,184FH    ;Esquina inferior derecha renglon : columna
int 10H         ;Interrupcion que llama al BIOS

      
      
      
;posicionar cursor 

mov ah,02h
mov bh,00
mov dh,0
mov dl,0
int 10h

; imprimir aviso 

    
mov dx,offset let1
mov ah,09
int 21h

mov dx,offset salto
mov ah,09
int 21h  

mov dx,offset ARRE
mov ah,09
int 21h

; inicializo mouse 
mov ax,00
int 33h

;____________________________

seleccionar:
; muestro mouse 
mov ax,01h 
int 33h 

        
; selecciono estado mouse 

mov ax,03
int 33h

cmp bx,1  
je izquierdo
cmp bx,2
je salir 
jmp seleccionar

        
izquierdo:
mov valorx, cx    ;coordenada x en pixeles
;aqui obtengo la columna
mov ax,valorx
mov bl,8
div bl

mov columna,al  ; resultado de la divisi?n previa para columna

mov valory,dx    ; coordenada y en pixeles
;aqui obtengo la fila
mov ax,valory
mov bl,8
div bl

mov fila,al ; resultado de la division previa para columna
;posiciono cursor en la fila y columna 
mov ah,02h
mov bh,00
mov dh,fila      ; posiciono el cursor en esa fila y columna
mov dl,columna   ; para despues preguntar que caracter esta donde el cursor
int 10h

; obtengo el caracter en la posici?n
mov ah,08h   ; leer caracter en posici?n actual del cursor
mov bh,00h
int 10h  

    
; posciono cursor
mov ah,02h
mov bh,00
mov dh,5d
mov dl,5d
int 10h

mov dl, al
mov ah, 02h
int 21h 
jmp seleccionar

       
SALIR:
RET

      
Main ENDP
codigo ENDS
END Main 