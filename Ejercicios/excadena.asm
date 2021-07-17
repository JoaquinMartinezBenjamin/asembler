    .MODEL small
    include libre.lib
    .STACK
    .DATA
    nombre db 'archivo.txt',0
    handle dw 0 ;
    letrero db 'Dame caracter a buscar: ','$'
    let1    db 'El caracter se encuentra en la posicion: ','$'
    let2    db 'Dame la cadena a leer: ','$'
    let3    db 'El caracter no existe en la cadena ','$'
    ;let4    db 'Dame el nombre del archivo: ', '$'
    posic   dw  (0)
    espacio db  0DH,0AH,'$'
    caracter db ?

    .CODE
main:
    MOV AX,@DATA
    MOV DS, AX
    MOV ES,AX
    clrscr

    Crear nombre
    gotoxy 8,20
    write let2
ciclo1:
    Read
    CMP AL,0DH
    JZ sig ;JE
    MOV caracter,AL
    Escritura caracter
    INC SI
    JMP ciclo1
sig:
    Cerrar
    Abrir nombre
    Leer nombre
    MOV CX,SI
    gotoxy 10,20
    write letrero
    Read
    CLD
    LEA DI,OFFSET nombre
    REPNE SCASB
    JNE noexiste
    gotoxy  12,20
    write let1
    sub DI,4
    add DI,30H
    MOV posic,DI
    write posic
    JMP salir
noexiste:
    gotoxy 14,20
    write let3
salir:
    .exit

End main

    End
