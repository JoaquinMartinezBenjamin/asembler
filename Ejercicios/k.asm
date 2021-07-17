LLENA macro buffer 
       local bucle, getout ; 
        MOV si, 0
bucle:  
        mov ah,01h
     int 21h
        CMP al, 0dh
        JE getout
        MOV buffer[si], al
        INC si
        JMP bucle
getout: 
        MOV buffer[si],'$' 
        
ENDM

.286
pila segment stack
db 32 dup ('stack___')
pila ends

datos segment 
nombre1 db "dato.txt", 0
 ARCHIVO DB 'dato. txt' 
manejador dw ?
buffer db 255 DUP ('$'),'$',0
menE db 'se a producido un error $'

espacio DB '-*ñ$'
ARREGLO db 6 DUP (?)
        PREGUNTA DB 'INGRESAR figuara? S/N','$'
        BUSQUEDA DB 'CADENA A BUSCAR:',0AH,0DH,'$'
        TARGETX DB 30 DUP (?) ; ACA GUARDAREMOS LO QUE SE VAYA LEYENDO DEL ARCHIVO
        AFIRMA DB 'SI ESTA!',0AH,0DH,'$'
        NEGATIVO DB 'NO ESTA!',0AH,0DH,'$'
        
        HANDLE DW ?                   ;ACA GUARDAREMOS EL MANEJADOR DE ARCHIVO
        NOMBRE db 30 dup (?)            ;ARREGLO PARA GUARDAR LAS CADENAS LEIDAS
        FILEPOS DW ?                 ;ALMACENA EL TOTAL DE CARACTERES ESCRITOS EN EL ARCHIVO
        SIZEX DW ?                    ;ACA GUARDAREMOS EL TAMA?O DE CADA CADENA
        LEIDOS DW ?,'$'
        POINTERF DW (0)
datos ends

codigo segment 'CODE'

assume ss:pila,  ds:datos, cs: codigo
main proc far
push ds
push 0
mov ax, datos
mov ds, ax
mov es,ax
;-------------------



abrir:
mov ah,03dh; interruccion para abrir
mov dx,offset nombre1
mov al, 0h; solo lectura 1h escritura 2h lectura escritura
int 21h
jc mal; si la badera de acarreo se prendio hay un error
mov manejador,ax
buscar:
mov ah, 09h
lea dx, BUSQUEDA
int 21h
LLENA NOMBRE; macro para llenar la cadena que va a buscar
MOV SIZEX,SI; GUARDA EL TAMAÑO DE LA CADENA QUE VA A BUSCAR
 
puntero:
MOV AH , 42H ; se vuelve a posicionar el puntero 
MOV AL,00h ; utilizando el modo de posicion absoluta para llegar al inicio del archivo
mov bx, ax
mov cx,3
INT 21H 
mov si,0
leerBus:
MOV AH,3FH
    MOV BX,manejador
    MOV CX,1
    LEA DX, TARGETX;donde estara lo que compara
    int 21h
    jc mal
    cmp ax,0
    je noesta; si llefo al final del archivo no esta 
MOV AL,TARGETX
CMP NOMBRE[SI], AL
JE AHIVA 
MOV SI,0
CMP NOMBRE [SI],AL
JE AHIVA
JMP leerBus
AHIVA:
INC SI
CMP  SIZEX,SI
JE SIESTA
JMP leerBus
SIESTA: 
mov ah, 09h
lea dx, AFIRMA
int 21h
mov si,0
leerArr:
MOV AH,3FH
    MOV BX,manejador
    MOV CX,3
    LEA DX, buffer
    int 21h
inc si
cmp si,7
jb muestra 
;jmp muestra
jmp FIN
muestra: 
mov di,0
ci:
mov ah, 09h
lea dx, buffer
 int 21h
 mov ah, 09h
 lea dx, espacio
  int 21h
  ;inc di
  ;cmp di,5
  ;jb ci
 jmp leerArr



NOESTA:
 mov ah, 09h
lea dx, NEGATIVO
int 21h
JMP FIN

MAL:
mov ah,09h
    lea dx,menE
    int 21h
jmp FIN
FIN:
MOV AH,3EH
    MOV BX, HANDLE
    INT 21H

ret
main endp
codigo ends
end main
