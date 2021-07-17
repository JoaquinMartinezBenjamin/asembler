
.286
PILA SEGMENT STACK
    DB 32 DUP ('STACK___')
PILA ENDS

DATOS SEGMENT
    let1 DB 'A E I O U     salir',0AH,'$'
    x DB  ' '
    y DB  ' '
    xi db ' '
    yi db ' '
    divi db 8
    coor db 25,1,55,1
   
DATOS ENDS

CODIGO SEGMENT 'CODE'
    ASSUME SS:PILA, DS: DATOS, CS:CODIGO
    main PROC FAR
        PUSH DS
        PUSH 0
        MOV AX, DATOS
        MOV DS, AX
        
        mov ah,6
        mov al,0
        mov bh,27
        mov ch,0
        mov cl,0
        mov dh,25
        mov dl,80
        int 10h

        mov ah,6
        mov al,0
        mov bh,32
        mov ch,coor[1]
        mov cl,coor[0]
        mov dh,coor[3]
        mov dl,coor[2]
        int 10h
            mov ah,02h
            mov bh,0
            mov dh,coor[1]
            mov dl,coor[0]
            add dl,6
            int 10h
            mov xi,dl
            mov yi,dh
                mov ah, 09h
                lea dx, let1
                int 21h
                mov ah, 02h
                int 21h
                mov ax, 0001h
                int 33h
repite:
        mov ax, 6
        mov bx, 0
        int 33H
        cmp bx, 1
        jne repite
        mov ax,cx
        div divi
        mov x,al
        mov ax,dx
        div divi
        mov y,al
        mov cl,yi
        cmp y,cl
        jne repite
        mov cl,xi
        cmp x, cl
        mov dl,"A"
        je imp
        add cl,2
        cmp x,cl
        mov dl,"E"
        je imp
        add cl,2
        cmp x, cl
        mov dl,"I"
        je imP
        add cl,2
        cmp x, cl
        mov dl,"O"
        je imp
        add cl,2
        cmp x,cl
        mov dl,"U"
        je imp
        add cl,6
        cmp x,cl
        jb repite
        add cl,4
        cmp x,cl
        jg repite
        jmp salir
        imp:
        mov ah, 02h
        int 21h
        jmp repite

salir:  MOV AH, 00H
        MOV AL, 03H
        INT 10H
        MOV AH,4CH
        INT 21H
        ret
    main ENDP
    CODIGO ENDS

END main