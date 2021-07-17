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
fila db (0),'$'
columna db (0),'$'



vocales DB 'a e i o u                               x$',0AH,0DH
numeros DB '           0 1 2 3 4 5 6 7 8 9 0 $',0AH,0DH


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
call iniciarRaton 
call mostrarRaton
mov dh, 0   ;;;;;
call limpiarPantalla
inicio:

posicionCursor  4,4
write vocales 

;::::::::::::::::::::::::::::::::::::::::::::::::::::::::; 
posicionCursor  6,7
write numeros 
;_______________________________________________________


preguntar:
;mov bl, 0 ; 
estado_mouse
cmp bx,1
je sigue
jmp preguntar 
sigue:

;_______________________________________________________
mouse_letra     ; guarda caracter en al  


posicionCursor dh,5
    mov ah, 02h
    mov dl, al               ;imprime caracter en dl 
    int 21h
inc dh
cmp dh, 6 
je fin 
;contarNumerosLetras arreglo  ; numeros en ch, letras en cl 
			 
;call        salto 
;write       let2
;writeLetra  ch
;call        salto
;write       let3
;writeLetra  cl


cmp al,'x'
jne inicio

			 
;_______________________________________________________
fin:
RET

Main endp
codigo ENDS
END Main