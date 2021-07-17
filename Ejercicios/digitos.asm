;_______________________________________________________
.286


include libreria.lib

pila SEGMENT STACK
DB 32 DUP('stack____')
pila ENDS

;_______________________________________________________
datos SEGMENT 
arreglo DB 5 DUP(?),'$'


let1 DB 'Ingrese arreglo$',0AH,0DH
let2 DB 'numeros   $',0AH,0DH
let3 DB 'letras    $',0AH,0DH
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
inicio:
;---salto----;
MOV AH,02H
MOV DL,0AH
INT 21H 
;------------;


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



;_______________________________________________________
                             ; imprimir arreglo 
;---salto----;
MOV AH,02H
MOV DL,0AH
INT 21H 
;------------;
	 
	 
;---mensaje---;
MOV DX,offset arreglo       
MOV AH,09
INT 21h
;-------------;


;_______________________________________________________


mov si, 0
mov di, 0           
mov bl,'$'
mov ch, 0
mov cl, 0

mov si, offset arreglo

ciclo:


cmp arreglo[si], bl
je salir
cmp arreglo[si],30h
jae validad
inc si
jmp ciclo


validad:

cmp arreglo[si], 39h
jbe   incrementad            ; menor o igual
cmp arreglo[si],41h
jae validam
inc si
jmp ciclo

;validad:
;cmp arreglo[si],30h 
;jae incrementad
;inc si 
;jmp ciclo




incrementad:
inc ch        ; incremento contador de digitos
inc si
jmp ciclo     ; regreso al ciclo 

validam:

cmp arreglo[si],5AH
jbe incremental
jmp validami


incremental:
inc cl       ; incremento contador de letras por mayuscula o minuscula 
inc si
jmp ciclo      ; regreso al ciclo 


validami:

cmp arreglo[si], 7AH 
jbe validami2 
inc si 
jmp ciclo 


validami2:
cmp arreglo[si],61h
jae incremental
inc si
jmp ciclo










salir:
             
			 
			 add ch, 30h      ;contador de numeros
			 add cl, 30h       ; contador de letras 
			 
			  ;---salto----;
MOV AH,02H
MOV DL,0AH
INT 21H 
;------------;

;---mensaje---;
MOV DX,offset let2     
MOV AH,09
INT 21h
;-------------;
 ;-------;
MOV AH,02H
MOV DL,ch
INT 21H 
;------------;

 ;---salto----;
MOV AH,02H
MOV DL,0AH
INT 21H 
;------------;

;---mensaje---;
MOV DX,offset let3     
MOV AH,09
INT 21h
;-------------;
 ;---cl----;
MOV AH,02H
MOV DL,cl
INT 21H 
;------------;
			 
;---salto----;
MOV AH,02H
MOV DL,0AH
INT 21H 
;------------;

 ;---cl----;
MOV AH,01H
INT 21H 
;------------;

cmp al,'x'
jne inicio

			 
;_______________________________________________________
fin:
RET

Main endp
codigo ENDS
END Main