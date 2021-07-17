.286
pila SEGMENT STACK
 DB 32 dup ('stack---')
 pila ENDS
 Datos SEGMENT
 cadena1 db 6 dup(?),'$'
 cadena2 db 6 dup(?),'$'
 Datos ENDS
 codigo SEGMENT 'CODE'
 Assume ss:pila,ds:datos,cs:codigo
 Main PROC FAR
 push ds
 push 0
 mov ax, datos
 mov ds,ax
 mov es,ax
 mov si,0
 mov di,0
 lee1:
 mov ah,01h
 int 21h
 cmp al,0dh
 je lee2
 mov cadena1[si],al
 inc si
 jmp lee1
 lee2:
 mov ah,01h
 int 21h
 cmp al,0dh
 je continua
 mov cadena2[di],al
 inc di
 jmp lee2
 continua:
 cld
 mov cx,si
 mov si,offset cadena1
 mov di,offset cadena2 
 rep MOVSB

 mov ah,09h
 lea dx,cadena2
 int 21h

 ret
 main endp
 codigo ENDS
 END Main