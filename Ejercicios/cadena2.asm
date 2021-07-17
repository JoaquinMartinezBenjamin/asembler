.286
pila segment stack
db 32 dup('stack___')
pila ends

data segment
saltoLinea db 0DH, 0AH,'$'
aviso db '...::: ENTER PARA CONTINUAR :::... $', 0DH, 0AH
mensaje db 'Ingresa una cadena: $', 0DH, 0AH
contador db (?),'$'
cadena db 20 dup(0)
data ends

code segment 'code'
assume cs:code,ds:data,ss:pila
inicio proc far

push ds
push 0
mov ax,data
mov ds,ax
mov contador,0
mov di,0

MOV AH,09H              ;Imprimimos 
MOV DX,OFFSET aviso     ;el 
INT 21H                 ;aviso

MOV AH,09H              ;Imprimimos 
MOV DX,OFFSET saltoLinea   ;el 
INT 21H                 ;saltoLinea

MOV AH,09H              ;Imprimimos 
MOV DX,OFFSET mensaje   ;el 
INT 21H                 ;mensaje
 
pedir:
mov ah,01h              ;Leer caracter desde el teclado
int 21h     

cmp al,0dh; enter
je seguir

mov cadena[di],al             ;Lee primer caracter
inc di
jmp pedir

seguir:
mov cadena[di],'$'
lea si,cadena

comparar:
mov al,[si]

cmp al,'$'
je mostrar

cmp al,'a'
je contar_mas
cmp al,'A'
je contar_mas

inc si
jmp comparar

contar_mas:
inc contador
inc si
jmp comparar

mostrar:
add contador,30h
MOV AH,09H                ;imprimimos 
MOV DX,OFFSET contador    ;el resultado
INT 21H 
ret

inicio endp
code ends

end inicio
