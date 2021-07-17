.286
pila segment stack
db 32 dup('stack___')
pila ends

data segment
saltoLinea db 0DH, 0AH,'$'
aviso db '...::: ENTER PARA CONTINUAR :::... $', 0DH, 0AH
mensaje db 'Ingresa una cadena: $', 0DH, 0AH
mensajeb db 'Binario: $', 0DH, 0AH
contador db (?),'$'
cadena db 20 dup(0)
data ends

code segment 'code'
assume cs:code,ds:data,ss:pila
inicio proc far
assume cs:code,ds:data,ss:pila

push ds
push 0
mov ax,data
mov ds,ax
;_________________


 
mov dh,00h; contador ciclos
MOV bl,240d

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
jne normal2
add al,2
inc cl
jmp ciclooct
normal2:
add al,4
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

salir:

mov ax,4c00h
int 21h
inicio endp
code ends

end inicio