.286
pila segment stack
db 32 dup('stack___')
pila ends

data segment
saltoLinea db 0DH, 0AH,'$'
aviso db '...::: ENTER PARA CONTINUAR :::... $', 0DH, 0AH
mensaje db 'Ingrese elementos arreglo: $', 0DH, 0AH

cadena db 5 dup(0)
data ends

code segment 'code'
assume cs:code,ds:data,ss:pila
inicio proc far

push ds
push 0
mov ax,data
mov ds,ax

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




    MOV AH,09H
    LEA DX, cadena
    INT 21H
    mov si,0
   
    mov al,cadena[si]
    
    
    
MOV AH,09H              ;Imprimimos 
MOV DX,OFFSET saltoLinea   ;el 
INT 21H                 ;saltoLinea
    
     ciclo:
    mov al, cadena[si]
	
comparar:

cmp cadena[si],'$'
je salir

cmp cadena[si],al
jb continuar 
mov al, cadena [si]


continuar:
inc si
jmp comparar



salir:
  
  
    MOV AH,02H
    MOV DL, al
    INT 21H
  
ret

inicio endp
code ends

end inicio