.286
pila segment stack
db 32 dup ('stack__')

pila ends 
data segment
cadena db 'INSTITUTO TECNOLOGICO DE OAXACA $'
indice1 db 8 dup(0)
indice2 db 8 dup(0)
CONTADOR1 DB (?),'$'
CONTADOR2 DB (?),'$'

data ends 


code segment 'code'
assume cs:code,ds:data,ss:pila
inicio proc far 

 push ds 
 push 0
 mov ax,data
 mov ds,ax
 ;______________________
 
 
 
 lea dx, cadena
  mov ah, 09h
  int 21h
 ;_________PEDIR IHDICES 
 

 
 ;_______Pedir indice1
; lea si, indice1

mov cl,1
 pedir1:
 mov ah,01h
 int 21h
 cmp al,0dh
 je seguir
 
 mov indice1[si],al
 inc si 
 
 jmp pedir1
 seguir:
 mov indice1[si],'$'
 
 ;__________
  decimal1:
 lea di,indice1
 dec di
 finalcadena:
 inc di
 mov al,[di]
 cmp al,'$'
 jne finalcadena
 dec di
 mov ch, 1

 lea si,indice1
 
 mov dx,0
 valordecimal1:
 cmp si,di
 ja guardar
 mov al,[di]
 sub al,30h
 mul ch
 add dx,ax
 mov al,10
 mul ch
 mov ch, al
 dec di
 jmp valordecimal1
 
 
 guardar:
 cmp cl,1
 ja salto
 mov contador1, dl
 inc cl
 sub si,si
 jmp pedir1
 salto:
 mov contador2, dl
 
 


;____seleccionar donde empezar

empiezaen:
mov cl,0
mov ch,0
lea si, cadena

ciclo:
cmp cl,contador1
je imprimir
inc cl
inc si
jmp ciclo


imprimir:
 inc ch
 cmp ch,contador2
 ja salir
  mov al,cadena[si]
  MOV ah,02h
  MOV dl,al
  INT 21h
  inc si
  jmp imprimir
  
 
 
 ;______________________
 salir:
 mov ax,4c00h
 int 21h
 inicio endp
 code ends
 end inicio
 