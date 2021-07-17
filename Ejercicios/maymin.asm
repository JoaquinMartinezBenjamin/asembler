.286
pila segment stack
db 32 dup('stack___')
pila ends

data segment
cadena1 db 'ensamblador$', 0DH, 0AH
cadena2 db 'eNsaMblaDoR$', 0DH, 0AH
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
jne comparar

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

comparar:
mov ah,al
add ah,20h ;si fuera mayuscula lo que hay en la primera cadena lo convierto a minuscula para comparar

cmp ah,bl
je regresar

sub al,20h ;si fuera minuscula cadena 1 le resto para hacerla mayuscula

cmp al,bl
je regresar

jmp salir

regresar: 
inc si
inc di
jmp volver



salir:
mov ah,09h
mov dx,offset diferentes
int 21h
ret

inicio endp
code ends
end inicio
