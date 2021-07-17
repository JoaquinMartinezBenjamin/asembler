.286
pila SEGMENT STACK
    
   DB 32 DUP ('stack___')
pila ENDS

datos SEGMENT 'DATA'
    letrero DB 'Hola,primer programa$',0AH,0DH
datos ENDS

codigo SEGMENT 'CODE'
    
    ASSUME SS: pila, DS: datos ,cs:codigo
    Main PROC FAR
     
    
    Push DS
    Push 0
    Mov Ax ,datos
    Mov Ds, AX
    
    MOV AH,09H
    LEA DX, letrero
    INT 21H
    RET
     
    
    
    Main ENDP 
   codigo ENDS
     END MAIN
