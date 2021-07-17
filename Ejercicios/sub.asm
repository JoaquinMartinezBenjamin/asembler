;_______________________________________________________
.286
pila SEGMENT STACK
DB 32 DUP('stack____')
pila ENDS

;_______________________________________________________
datos SEGMENT 
arreglo DB 5 DUP(?),'$'
arreglo2 DB 5 DUP(?),'$'

let1 DB 'Ingrese arreglo$',0AH,0DH
let2 DB 'Si es subcadena $',0AH,0DH
let3 DB 'No es subcadena $',0AH,0DH
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

cadena2:

MOV AH,01H ;leo un solo caracter
INT 21H 
CMP AL,0DH ;comparo si corresponde con enter
je ciclo

MOV arreglo[SI],AL ;muevo a la cadena en posicion si caracter en al
INC SI ;incremento si
CMP SI,5 ;compara si llene la capacidad de mi cadena
JAE ciclo ;si es mayor o igual continua a capturar la segunda cadena
JMP cadena2 ;regreso al ciclo


   ciclo:
mov si, 0
mov di, 0   

	;mov di, 1
	
	comienzo: 
		mov al, arreglo2[0] ;copiar la primera letra de la palabra a al
		cmp arreglo[si],'$' ;si es el fin de la cadena mandar a salir
		jz resultado2     ;je
		cmp arreglo[si], al ;comparar si encuentra la primera letra de la cadena
		jne seguir     ;si no es igual seguir

 		mov di, 1
 
 	comprobar:
 		mov al, arreglo2[di]
 		mov bx, di
 		cmp arreglo[si+bx], al
 		jne seguir ;si no coincide mandar a seguir
		inc di ;incrementar di para seguir recorriendo cadena 
		cmp arreglo2[di],'$' ;si es el fin de la cadena y el programa llego aca quiere decir que la cadena es parte de la palabra
		
		jz comienzo
       
 	jmp comprobar ;bucle para recorrer cadena 

	seguir: 
		inc si ;para seguir recorriendo la palabra
		jmp comienzo ;bucle principal para recorrer palabra
	
	resultado:
		mov dx, offset let2    ;'si es subcadena'
		mov ah, 09h ;
		int 21h 
	jmp salir

resultado2:
        mov dx, offset let3   ;'No es subcadena'
		mov ah, 09h ;
		int 21h 
		
		salir:
	
			 
		



;_______________________________________________________
fin:
RET

Main endp
codigo ENDS
END Main