;_______________________________________________________
.286
pila SEGMENT STACK
DB 32 DUP('stack____')
pila ENDS

;_______________________________________________________
datos SEGMENT 
arreglo DB 5 DUP(?),'$'


let1 DB 'Ingrese arreglo$',0AH,0DH
let2 DB 'Arreglo despues de ordenar$',0AH,0DH
datos ENDS
;_______________________________________________________

codigo SEGMENT 'CODE'
assume ss:pila, ds:datos, cs:codigo
Main PROC FAR
push DS;
push 0
MOV AX,datos;
MOV DS, AX
MOV ES,AX

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
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::;
continuar:
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::;

;---salto----;
MOV AH,02H
MOV DL,0AH
INT 21H 
;------------;


mov si, 0
mov di, 0           
mov bl,'$'


ciclo:

mov al,arreglo[si]
cmp bl, al
je incrementa
cmp al, arreglo[di]
ja cambiar
inc si
jmp ciclo 



cambiar:

mov ah, arreglo[di]
mov arreglo[di],al
mov arreglo[si],ah

inc si

jmp ciclo 


incrementa:

inc di
cmp arreglo[di],'$'
je salir
mov si,di
jmp ciclo



salir:
             

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
            mov AH, 09H
            LEA dx, arreglo
            INT 21H

;_______________________________________________________
fin:
RET

Main endp
codigo ENDS
END Main