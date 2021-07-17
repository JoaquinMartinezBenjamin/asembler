;_______________________________________________________
.286
pila SEGMENT STACK
DB 32 DUP('stack____')
pila ENDS

;_______________________________________________________
datos SEGMENT 
cadena1 DB 5 DUP(?),'$'
cadena2 DB 5 DUP(?),'$'
iguales DB 'Son iguales$'
diferentes DB 'Son diferentes$'

let1 DB 'Ingrese cadena$',0AH,0DH
let2 DB 'Cadenas despues de mover$',0AH,0DH
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
MOV DX,offset let1
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
je continuar ;si es enter sigo con la cadena2

MOV cadena1[SI],AL ;muevo a la cadena en posicion si caracter en al
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
;---mensaje---;
MOV DX,offset let1
MOV AH,09
INT 21h
;-------------;
;---salto----;
MOV AH,02H
MOV DL,0AH
INT 21H 
;------------;
mov si, 0
mov dl,0dh               ;muevo a dl el enter

;::::::::::::::::::::::::::::::::::::::::::::::::::::::::; 
Cad2:
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::; 
MOV AH,01H ; pido caracter por caracter
INT 21H 
CMP AL,DL ; compara si se dio enter
je comparar ; si es igual que enter continuo a mover las cadenas

MOV cadena2[SI],AL ; si no es enter muevo a cadena2 el caracter en al
INC SI
CMP SI,5 ; compara si llene la capacidad de mi cadena
JAE comparar ; si es mayor o igual continua a mover
JMP Cad2 

;::::::::::::::::::::::::::::::::::::::::::::::::::::::::; 
comparar:
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::;

CLD
;---salto----;
MOV AH,02H
MOV DL,0AH
INT 21H 
;------------;

        MOV AL, lengthof cadena1
		cmp AL, lengthof cadena2
		JNE dif                  ;si no iguales

		MOV CX, lengthof cadena1
		
		MOV DI, offset   cadena1
		MOV SI, offset   cadena2
		
		REPE cmpsb
		
		JNE dif                  ;Si no son iguales salta a imprimir diferentes
			
	    MOV AH, 09H
	    LEA DX, iguales
		INT 21H
		
		jmp fin
		
		
		
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::; 
dif:
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::; 

;---salto----;
MOV AH,02H
MOV DL,0AH
INT 21H 
;------------;
			mov AH, 09H
			LEA dx, diferentes
			INT 21H



;_______________________________________________________
fin:
RET

Main endp
codigo ENDS
END Main