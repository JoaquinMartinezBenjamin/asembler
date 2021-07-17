;_______________________________________________________
.286
include libreria.lib
pila SEGMENT STACK
DB 32 DUP('stack____')
pila ENDS
;_______________________________________________________
datos SEGMENT 
arreglo DB 5 DUP(?),'$'

fila db (0),'$'
columna db (0),'$'


naranja DB 'naranja$',0AH,0DH      ;8
verde DB 'verde$',0AH,0DH     ;7
morado DB 'morado$',0AH,0DH      ;7
azul DB 'azul$',0AH,0DH      ;5
salir DB 'salir$',0AH,0DH     ;6


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
mov dl,0
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::;
posicionCursor  1,1      ; columna, fila1 
write naranja

 
posicionCursor  10,1 
write verde



posicionCursor  20,1 
write morado 

posicionCursor  30,1 
write azul 

posicionCursor  50,1 
write salir   


;_______________________________________________________


preguntar:
;mov bl, 0 ; 

estado_mouse
cmp bx,1
je sigue
jmp preguntar 
sigue:

;_______________________________________________________


mouse_dentro_click_izquierdo  1,1,9,1
cmp dl,1
je pintarNaranja                              ;___________


mouse_dentro_click_izquierdo2  10,1,17,1
cmp dl,1
je pintarVerde                               ;___________



mouse_dentro_click_izquierdo3 20,1,27,1
cmp dl,1
je pintarMorado                              ;___________



mouse_dentro_click_izquierdo4  30,1,35,1
cmp dl,1
je pintarAzul                              ;___________

;para salir 
mouse_dentro_click_izquierdo5  50,1,56,1
cmp dl,1
jne inicio
jmp fin





pintarNaranja:
call pintaNaranja
jmp inicio
pintarVerde:
call pintaVerde
jmp inicio
pintarMorado:
call pintaMorado
jmp inicio
pintarAzul:
call pintaAzul
jmp inicio
			 
;_______________________________________________________
fin:
RET

Main endp
codigo ENDS
END Main