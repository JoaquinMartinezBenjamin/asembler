;JOAQUIN MARTINEZ BENJAMIN
;MOVER EL CONTENIDO DE UNA CADENA A OTRA 
.286
PILA SEGMENT STACK
    DB 32 DUP ('STACK___')
PILA ENDS

DATOS SEGMENT
  cad1 DB 'HOLA',0AH,'$'
  cad2 DB 'ADIOS',0AH,'$'
   
DATOS ENDS

CODIGO SEGMENT 'CODE'
    ASSUME SS:PILA, DS: DATOS, CS:CODIGO
    main PROC FAR
        PUSH DS
        PUSH 0
        MOV AX, DATOS
        MOV DS, AX
		MOV ES, AX
		
		
		
		
		
		
		CLD
		
		MOV SI, OFFSET cad2
		MOV DI, OFFSET cad1
		
		MOV CX, 4
		
		REP MOVSB
		
		
		mov dx,offset cad1
mov ah,09
int 21h
		
		
		SALIR:
RET

      
Main ENDP
codigo ENDS
END Main 