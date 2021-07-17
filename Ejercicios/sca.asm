;_______________________________________________________
.286
pila SEGMENT STACK
DB 32 DUP('stack____')
pila ENDS

;_______________________________________________________
datos SEGMENT 
arreglo DB 5 DUP(?),'$'


let1 DB 'Ingrese arreglo$',0AH,0DH
let2 DB 'Encontrado$',0AH,0DH
let3 DB 'No encontrado$',0AH,0DH
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

mov ah,01h
	int 21h
	
	cld 
	mov di, offset arreglo
	mov cx,5
	repne scasb
	
	je encontrado
	jmp noencontrado 
	
	 encontrado:
	 ;---salto----;
MOV AH,02H
MOV DL,0AH
INT 21H 
;------------;
	 
	 
;---mensaje---;
MOV DX,offset let2       ;ingrese arreglo
MOV AH,09
INT 21h
;-------------;

;---salto----;
MOV AH,02H
MOV DL,0AH
INT 21H 
;------------;
jmp salir

	 noencontrado:
	 
	 	 ;---salto----;
MOV AH,02H
MOV DL,0AH
INT 21H 
;------------;
	 
	 
;---mensaje---;
MOV DX,offset let3       ;ingrese arreglo
MOV AH,09
INT 21h
;-------------;

;---salto----;
MOV AH,02H
MOV DL,0AH
INT 21H 
;------------;

salir:
             



;_______________________________________________________
fin:
RET

Main endp
codigo ENDS
END Main