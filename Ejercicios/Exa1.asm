.286
    
    write MACRO mensaje
        lea dx, mensaje
        mov ah,09h
        int 21h
    endm
    
    exhibe_caracter MACRO reg
        mov ah,02h
        mov dl,reg
        int 21h
    endm
    
    posiciona_cursor MACRO renglon,columna
        mov ah,02h  
        mov dh, renglon    
        mov dl, columna
        mov bh,00h
        int 10h 
     endm

pila segment stack
    db 32 dup ('stack__')
pila ends 
    
    data segment
        cad db 'INSTITUTO TECNOLOGICO DE OAXACA$'
        ;cad2 db 50 dup ('$')
        msj DB 'Posicion a iniciar: $'
        msj2 DB 'Cantidad de elementos a copiar: $'
        msj3 DB 'Cadena copiada: $'
        posi db 3 dup('$')
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
 
 
            call clrscr
            posiciona_cursor 08,10
            write cad

            mov cl,1
            
            posiciona_cursor 10,10
            write msj
            mov si,0
        pedir:
            call pide
            
            cmp al,0dh;enter
            je seguir
            
            mov posi[si],al
            inc si 
            jmp pedir
            
        seguir:
            mov posi[si],'$' ;para saber q acaba la cadena
             ;__________
        conv_decimal:
             lea di,posi
             dec di
        fin_cad:
             inc di
             mov al,[di]
             cmp al,'$'
             jne fin_cad
             dec di
             mov ch, 1

             lea si,posi
             
             mov dx,0
        valordecimal:
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
             jmp valordecimal
             
             
        guardar:
             cmp cl,1
             ja salto
             mov contador1, dl
             inc cl
             sub si,si
             
             posiciona_cursor 11,10
             write msj2
             
             jmp pedir
        salto:
             mov contador2, dl

    ;____seleccionar donde empezar

        empiezaen:
            mov cl,0
            mov ch,0
            lea si, cad

        ciclo:
            cmp cl,contador1
            je imprimir
            inc cl
            inc si
            jmp ciclo

            
        imprimir:
            posiciona_cursor 12,10
            write msj3
            
        imprimir2:
            inc ch
            cmp ch,contador2
            ja salir
            mov al,cad[si]
            exhibe_caracter al
            inc si
            jmp imprimir2

 salir:
     mov ax,4c00h
     int 21h
 
    pide proc
        mov ah,01h
        int 21h
        ret
    pide endp
    
    clrscr proc                     
        mov ax,0600h    ;AH 06 (recorrido), AL 00 (pantalla completa)
        mov bh,50H      ;Atributo para color
        mov cx,0000h    ;Esquina superior izquierda renglon : columna 
        mov dx,184FH    ;Esquina inferior derecha renglon : columna
        int 10H         ;Interrupcion que llama al BIOS
        ret
    clrscr ENDP
 
 inicio endp
 code ends
 end inicio