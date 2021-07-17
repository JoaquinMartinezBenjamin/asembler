.286
pila segment stack
db 32 dup('stack_')
pila ends

data segment
    
msj db 'Presione s para salir, <--para rol , --> para ror$' ;
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
 ;RETORNO enter
MOV cx,0
MOV ah,02h
MOV dl,10
INT 21h
;_________________
volver:

;INT 10H 
MOV AH,01H
MOV CL,0
MOV CH,0
MOV BH,00
INT 10H
;_________________
;RETORNO DE CARRO
MOV cx,0
MOV ah,02h
MOV dl,13
INT 21h
;__________________

;__________________

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
JNE volver
;_________________
izquierda:
rol bl,1
JMP volver
;_________________
derecha:
ror bl,1
JMP volver
;_________________

salir:
mov ax,4c00h
int 21h
inicio endp
code ends

end inicio