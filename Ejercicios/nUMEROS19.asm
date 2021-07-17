.286
pila segment stack
db 32 dup ('stack_')
pila ends

data segment 

data ends

code segment
principal proc far
assume cs:code, ds:data, ss:pila

push ds
push 0

mov ax, data
mov ds, ax
mov ah, 00h
mov al, 03h
INT 10H

; IMPRIMIR LOS N?MEROS DEL 0 AL 9


MOV CX, 0AH; 
eti: 

 MOV BL,30H

 MOV AH,02H
 MOV DL, BL
 ADD BL, 1
 INT 21H

LOOP eti
  

ret 
principal endp
code ends
end principal