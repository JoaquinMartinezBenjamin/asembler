.286
pila segment stack
db 32 dup('stack___')
pila ends

data segment
cadena1 db 'ensamblador$', 0DH, 0AH
cadena2 db 'ensamblador$', 0DH, 0AH
iguales db 'Son iguales$', 0DH, 0AH
diferentes db 'Son diferentes$', 0DH, 0AH
data ends

code segment 'code'
assume cs:code,ds:data,ss:pila
inicio proc far

push ds
push 0
mov ax,data
mov ds,ax
mov si,0
mov di,0


volver:
mov al,cadena1[si]
mov bl, cadena2[di]

cmp al,'$'
je termino

cmp al,bl 
jne salir

inc si 
inc di
jmp volver


termino:
cmp bl,'$'
je imprimir
jmp salir

imprimir:
mov ah,09h
mov dx,offset iguales
int 21h
ret

salir:
mov ah,09h
mov dx,offset diferentes
int 21h
ret

inicio endp
code ends
end inicio
