;_______________________________________________________
.286
pila SEGMENT STACK
DB 32 DUP('stack____')
pila ENDS

;_______________________________________________________
datos SEGMENT 
arreglo DB 5 DUP(?),'$'


let1 DB 'Ingrese arreglo$',0AH,0DH
let2 DB   'a e i o u   x','$',0AH,0DH
vocal db 1 DUP (?),'$'
aparece DB 'La vocal aparece en la posicion $',0AH,0DH
noaparece DB 'La vocal no aparece                $',0AH,0DH
limpia DB '                                   $',0AH,0DH


fila db 2 DUP(?),'$'
columna db 2 DUP(?),'$'
valorx dw 2 DUP(?),'$'
valory dw 2 DUP(?),'$'

impr db 2 DUP(?),'$'

datos ENDS
;_______________________________________________________

codigo SEGMENT 'CODE'
assume ss:pila, ds:datos, cs:codigo
Main PROC FAR
push DS;
push 0
MOV AX,datos;
MOV DS, AX
;MOV ES,AX

;_______________________code_____________________________

; limpiar pantalla
mov ax,0600h ;AH 06 (recorrido), AL 00 (pantalla completa)
mov bh,70H ;Atributo; blanco (7) sobre azul(1)
mov cx,0000h ;Esquina superior izquierda renglon : columna 
mov dx,184FH ;Esquina inferior derecha renglon : columna
int 10H ;Interrupcion que llama al BIOS



;---mensaje---;
MOV DX,offset let1       ;ingrese arreglo
MOV AH,09
INT 21h
;-------------;

;---salto----;
MOV AH,02H
MOV DL,0AH
INT 21H 
;------------;


MOV SI,0 
MOV impr,7d
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::; 
Cad1: 
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::;
MOV AH,01H ;leo un solo caracter
INT 21H 
CMP AL,0DH ;comparo si corresponde con enter
je continuar 

MOV arreglo[SI],AL ;muevo a la cadena en posicion si caracter en al
INC SI ;incremento si
CMP SI,5 ;compara si llene la capacidad de mi cadena
JAE continuar ;si es mayor o igual continua a capturar la segunda cadena
JMP Cad1 ;regreso al ciclo


continuar:




;posicionar cursor 

mov ah,02h
mov bh,00
mov dh,0
mov dl,0
int 10h


;---mensaje---;
LEA DX, arreglo
MOV AH,09
INT 21h
;-------------;


;posicionar cursor 

mov ah,02h
mov bh,00
mov dh,5
mov dl,5
int 10h
			 
			 
			 
;---mensaje---;
MOV DX,offset let2
MOV AH,09
INT 21h
;-------------;
;---salto----;
MOV AH,02H
MOV DL,0AH
INT 21H 
;------------;





; muestro mouse 
mov ax,01h 
int 33h 


;::::::::::::::::::::::::::::::::::::::::::::::::::::::::;
seleccionar:
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::;

mov impr,7d

int 33h
mov ax,03h



cmp bx,1 
je izquierdo
cmp bx,2
je fin

jmp seleccionar


izquierdo:
mov valorx, cx
;aqui obtengo la columna
mov ax,valorx
mov bl,8
div bl

mov columna,al

mov valory,dx
;aqui obtengo la fila
mov ax,valory
mov bl,8
div bl

mov fila,al
;posiciono cursor en la fila y columna 
mov ah,02h
mov bh,00
mov dh,fila
mov dl,columna
int 10h

; obtengo el caracter en la posici?n
mov ah,08h
mov bh,00h
int 10h 
mov si,0

cmp al, 'a'
je capturar

cmp al, 'e'
je capturar

cmp al, 'i'
je capturar

cmp al, 'o'
je capturar

cmp al, 'u'
je capturar

cmp al,'x'
je fin

jmp seleccionar

capturar:

mov vocal, al


ciclo:

cmp arreglo[si], '$'
je continuar
mov bl, vocal
cmp arreglo[si],bl
je imprimir
inc si
jmp ciclo

imprimir:

mov ah,02h
mov bh,00
mov dh,6d
mov dl,0d
int 10h

;---mensaje---;
LEA DX, aparece
MOV AH,09
INT 21h
;-------------;





mov ah,02h
mov bh,00
mov dh,impr
mov dl, 7d
int 10h

;---mensaje---;
mov bx, si
add bl,30h
mov dl, bl
mov ah, 02h
int 21h 
;-------------;

inc impr
inc si

jmp ciclo



           
;_______________________________________________________
fin:
RET

Main endp
codigo ENDS
END Main