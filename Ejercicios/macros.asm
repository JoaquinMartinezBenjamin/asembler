 .286
 ;______________________MACROS____________________

    Write MACRO letrero
       MOV AH,09H
       LEA DX,letrero
       INT 21H
  ENDM
  
 ;________________________________________________
	
	pila SEGMENT STACK
       DB 32 DUP ('stack___')
    pila ENDS
	
 ;________________________________________________	
	datos SEGMENT
         
    datos ENDS
	
 ;________________________________________________
  codigo  SEGMENT 'CODE'
       ASSUME SS:pila, DS:datos, CS:codigo
    Main PROC FAR
         PUSH DS
         PUSH 0
         MOV AX,datos
         MOV DS,AX
 ;------------------------------------------------	 
		 
    Fin: RET
    Main Endp
 ;________________PROCEDIMIENTOS___________________	
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
;________________________________________________	
	
    codigo Ends
         End Main      
         
                                      