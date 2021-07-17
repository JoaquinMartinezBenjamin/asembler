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
call iniciarRaton 
call mostrarRaton

inicio:
call limpiarPantalla
posicionCursor  5,5
write let1

;::::::::::::::::::::::::::::::::::::::::::::::::::::::::; 
posicionCursor  6,11
capturarCadena arreglo,5 , localidad + logitud_localicad 
;_______________________________________________________
; imprimir arreglo 
posicionCursor  7,16   ;fila 16 columna 7

;_______________________________________________________

preguntar:
mov dl, 0 ; valor que cambia a 1 si mouse dentro de las coordenadas
mouse_dentro_click_derecho 6,11,11,11
cmp dl,1
je sigue
jmp preguntar 
sigue:

;_______________________________________________________

contarNumerosLetras arreglo  ; numeros en ch, letras en cl 
			 
call        salto 
write       let2
writeLetra  ch
call        salto
write       let3
writeLetra  cl
call        salto
call        read 

cmp al,'x'
jne inicio

			 
;_______________________________________________________
fin:
RET

Main endp
codigo ENDS
END Main