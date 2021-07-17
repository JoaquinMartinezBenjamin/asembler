.286
pila segment stack
db 32 dup('stack___')
pila ends

data segment
saltoLinea db 0DH, 0AH,'$'
aviso db 'ENTER PARA CONTINUAR $', 0DH, 0AH
mensaje db 'Ingresa una cadena: $', 0DH, 0AH
mensajeb db 'Binario: $', 0DH, 0AH
mensajeh db 'Hexadecimal: $', 0DH, 0AH
mensajeo db 'Octal: $', 0DH, 0AH

cadena db 20 dup(0)

data ends

code segment 'code'
assume cs:code,ds:data,ss:pila
inicio proc far

push ds
push 0
mov ax,data
mov ds,ax
;___________________________
 lea dx, aviso
 mov ah, 09h
 int 21h
               

 lea dx, saltoLinea
 mov ah, 09h
 int 21h
                 

 lea dx, mensaje
 mov ah, 09h
 int 21h                
 
pedir:
mov ah,01h              
int 21h     

cmp al,0dh; enter
je seguir

mov cadena[si],al          
inc si
jmp pedir

seguir:
mov cadena[si],'$'


 lea dx, saltoLinea
 mov ah, 09h
 int 21h
;___________________________
mov dx,00h
lea si,cadena
mov al,[si]
sub al,30h
mov bl,100
mul bl
add dx,ax
inc si

mov al,[si]
sub al,30h
mov bl,10
mul bl
add dx,ax
inc si

mov al,[si]
sub al,30h
add dl,al

;_________________
mov ch,dl ;guarda el valor
;_______________

MOV bl,dl
MOV cl,0



 lea dx,mensajeb
 mov ah, 09h
 int 21h

MOV ah,02h 
 
ciclo:
inc cl
cmp cl,9
je conversionh
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
;___________________________
conversionh:

lea dx, saltoLinea
 mov ah, 09h
 int 21h
           
 lea dx,mensajeh
 mov ah, 09h
 int 21h
 
 mov dh,00h; contador ciclos
MOV bl,ch

hexadecimal:
mov cl,0
mov al,0

ciclohex:
cmp cl,4
je imprimehex

ROL bl,1

JC etiqueta1h
inc cl
JMP ciclohex


etiqueta1h:

cmp cl,0
je potencia0
cmp cl,1
je potencia1
cmp cl,2
je potencia2
cmp cl,3
je potencia4
jmp ciclohex


potencia0:
add al,8
inc cl
jmp ciclohex

potencia1:
add al,4
inc cl
jmp ciclohex

potencia2:
add al,2
inc cl
jmp ciclohex

potencia4:
add al,1
inc cl
jmp ciclohex

imprimehex:
cmp al,9
ja caracter
num:
add al,30h
jmp imprime
caracter:
add al,41h
sub al,10d

imprime:
mov ah,02h
mov dl,al             
int 21h  

inc dh
cmp dh,2
je conversionoct

jmp hexadecimal

;_________________
conversionoct:
lea dx, saltoLinea
 mov ah, 09h
 int 21h
           
 lea dx,mensajeo
 mov ah, 09h
 int 21h
 
mov dh,00h; contador ciclos
MOV bl,ch

octal:
mov cl,0
mov al,0

ciclooct:
cmp dh,0
jne normal1
cmp cl,2
je imprimeoct
normal1:
cmp cl,3
je imprimeoct
ROL bl,1

JC etiqueta1o
inc cl
JMP ciclooct


etiqueta1o:

cmp cl,0
je potencia0o
cmp cl,1
je potencia1o
cmp cl,2
je potencia2o

jmp ciclooct


potencia0o:
cmp dh,0
jne normal2
add al,2
inc cl
jmp ciclooct
normal2:
add al,4
inc cl
jmp ciclooct

potencia1o:
cmp dh,0
jne normal3
add al,1
inc cl
jmp ciclooct
normal3:
add al,2
inc cl
jmp ciclooct

potencia2o:
add al,1
inc cl
jmp ciclooct



imprimeoct:

add al,30h
mov ah,02h
mov dl,al             
int 21h  

inc dh
cmp dh,3
je salir

jmp octal
;___________________________
salir:

ret
inicio endp
code ends

end inicio