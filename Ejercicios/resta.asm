.286
pila SEGMENT STACK
    
   DB 32 DUP ('stack___')
pila ENDS

datos SEGMENT 'DATA'
    letrero DB 'Introduzca numero$',0AH,0DH
    a DB (?),'$'
    b DB (?),'$'
    result db(?) ,'$'
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
   
   MOV AH, 01h
   int 21h 
   mov a , al
   
   
   MOV AH,09H
    LEA DX, letrero
    INT 21H
   
   
   MOV AH, 01h
   int 21h 
   mov b , al
   
   
   
   mov dl,b
   mov dh,a
   cmp dh,dl
   ja bmenor
   sub dl,dh
   
   mov result,dl
   
   add result,30h
    MOV AH,09H
    LEA DX,result
    INT 21H
   jmp salir
   
   bmenor:
   sub dh,dl
  
   mov result,dh
  add result,30h 
   
    MOV AH,09H
     LEA DX, result
    INT 21H
   salir:
   
    
   
   
    RET
     
    
    
    
    Main ENDP 
   codigo ENDS
     END MAIN

