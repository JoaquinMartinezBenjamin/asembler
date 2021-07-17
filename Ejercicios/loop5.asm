.286
pila SEGMENT stack
      DB 32 DUP ('stack___')
pila ENDS
datos SEGMENT
    
    ARRE DB 0AH,0DH,5 DUP(?),'$'
    SALTO DB 0DH, 0AH,,'$'
    MEN DB 0DH, 0AH,('INGRESE UN NUMERO'),'$'
   
datos ENDS
codigo SEGMENT 'CODE'
       Assume ss:pila, ds:datos, cs:codigo
Main PROC FAR
      PUSH DS
      PUSH 0
      MOV AX, datos
      MOV DS,AX

      
      LEA dx, men
      int 21h
      
      
      mov cx,5  
      DEC: 
      
      
      
      MOV AH, 01H
      INT 21H
      MOV ARRE[si] , al
      inc si
      loop DEC
      
      
      
      lea dx, arre
      int 21h
      
      
      
      
      SALIR:
      RET
      
      
      
      
Main ENDP
codigo ENDS
END Main  