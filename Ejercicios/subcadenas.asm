.286
    write MACRO mensaje
        lea dx, mensaje
        mov ah, 09
        int 21h
    endm


pila segment stack
    db 32 dup('stack_')

pila ends
    
    data segment
        msj db 'ingresa caracteres y presiona enter para terminar$'
        msj1 db 'Ingrese caracter a buscar$'
        salto db 10,13,'$'
        x db (?),'$'
        arreglo db 50 dup ('$')
        temp db (?),'$'
    data ends

    code segment para 'code'
    
    inicio proc far
        assume cs:code,ds:data,ss:pila

    push ds
    push 0
    
    mov ax,data
    mov ds, ax
    
        write msj
        write salto

        mov si,0

pedir:
        call pide
        cmp al,0dh
        je previo_buscar
        mov arreglo[si],al
        inc si
        jmp pedir

        previo_buscar:
        mov si,0
        mov bl,0
        write msj1
        call pide

buscar:
        cmp arreglo[si],al
        je contar
        inc si
        cmp arreglo[si],'$'
        jne buscar
        jmp imprimir

contar:
        add bl,1
        inc si
        cmp arreglo[si],'$'
        jne buscar
imprimir:
        mov temp, bl
        write temp       
    
    salir:
        ret
        
pide proc
        mov ah,01
        int 21h
        ret
    pide endp

inicio endp
code ends
end inicio