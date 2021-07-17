
    .286
    Write MACRO letrero
       MOV AH,09H
       LEA DX,letrero
       INT 21H
    ENDM
    pila SEGMENT STACK
         DB 32 DUP ('stack___')
    pila ENDS
    datos SEGMENT
         cadena DB 'Hola',0DH,0AH,'$'
         let1 DB 'Dame valor',0DH,0AH,'$'
         let2 DB 'Gracias',0DH,0AH,'$'
         let3 DB  'No existe el caracter',0DH,0AH,'$'
         let4 DB 'El caracter existe en la posicion:',0DH,0AH,'$'                                                                                                                         
         posic DB  (0) 
    datos ENDS
    codigo  SEGMENT 'CODE'
       ASSUME SS:pila, DS:datos, CS:codigo
    Main PROC FAR
         PUSH DS
         PUSH 0
         MOV AX,datos
         MOV DS,AX
         CALL clrscr
         Write let1
         Write let2
         
         Write cadena
         CALL Read
         
         CLD
         MOV CX,4
         MOV SI,OFFSET cadena
         REPE SCASB
         CMP CX,0
         JB encontro
         Write let3
         JMP FIN
    encontro:
         Write let4
         MOV AX,SI
         MOV posic,AL
         WRITE posic     
    Fin: RET
    Main Endp
    Read Proc
       MOV AH,01
       INT 21H
       RET
    Read ENDP
    clrscr PROC
       MOV AH,07H
       MOV BH,00H
       MOV CX,00H
       MOV DX,184FH
       INT 10H
       RET
    clrscr ENDP
    codigo Ends
         End Main      
         
                                      