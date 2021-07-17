.286
pila segment stack
db 32 dup('stack_')
pila ends

data segment
    
msj db 'Presione s para salir, flecha izquierda <--para rol ,flecha derecha --> para ror$' ;
msj1 db 'Presione s para salir, flecha arriba para shr, flecha abajo para shl$' ;
data ends


code segment para 'code'
inicio proc far

assume cs:code,ds:data,ss:pila

push ds
push 0
mov ax,data
mov ds,ax
MOV bl,11110100b
;_________________
 lea dx, msj
 mov ah, 09
 int 21h
 mov ah,02h
 ; enter
MOV cx,0
MOV ah,02h
MOV dl,10
INT 21h
 lea dx, msj1
 mov ah, 09
 int 21h
 mov ah,02h
 ; enter
MOV cx,0
MOV ah,02h
MOV dl,10
INT 21h
;_________________
volver:
;_________________
;RETORNO DE CARRO
MOV cx,0
MOV ah,02h
MOV dl,13
INT 21h
;__________________


ciclo:

inc cx
cmp cx,9
je recorrer
ROL bl,1

JC etiqueta1
JNC etiqueta2


etiqueta1:

MOV dl,'1'
INT 21h
JMP ciclo

etiqueta2:
MOV dl,'0'
INT 21h
JMP ciclo
;_________________

recorrer:
MOV ah,10h
INT 16h
CMP ah,31
JE salir
CMP ah,4bh;80
JE izquierda
CMP ah,4dh;75
JE derecha
CMP ah,48h
JE izquierdaS
CMP ah,50h
JE derechaS
JNE volver
;meter aqui lo del shl shr y hacer otra iz y otra der
;_________________
izquierda:
rol bl,1
JMP volver
;_________________
derecha:
ror bl,1
JMP volver
;_________________
izquierdaS:
shl bl,1
JMP volver
;_________________

derechaS:
shr bl,1
JMP volver
;_________________

salir:
mov ax,4c00h
int 21h
inicio endp
code ends

end inicio