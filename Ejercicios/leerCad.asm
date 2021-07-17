;_______________________________________________________
.286
pila SEGMENT STACK
    DB 32 DUP('stack____')
pila ENDS

;_______________________________________________________
datos SEGMENT 
    cadena1 DB 5 DUP(?),'$'
    cadena2 DB 5 DUP(?),'$'
    
    let1  DB 'Ingrese cadena$',0AH,0DH
    let2  DB 'Cadenas despues de mover$',0AH,0DH
datos ENDS
;_______________________________________________________

codigo SEGMENT 'CODE'
    assume ss:pila, ds:datos, cs:codigo
    Main PROC FAR
    push DS;
    push 0
    MOV AX,datos;
    MOV DS, AX
    MOV ES,AX
    
;_______________________code_____________________________

        mov dx,offset let1
        mov ah,09
        int 21h

    ;_____salto____   
    MOV AH,02H
    MOV DL,0AH
    INT 21H 
	;______________
	
    MOV DL,0DH               ;enter
    MOV SI,0                 ;7478 11161086
    
        
    Cad1:
    MOV AH,01H               ;leo un solo caracter
    INT 21H 
    CMP AL,DL                ;comparo si corresponde con enter
    je continuar             ;si es enter sigo con la cadena2
    
    MOV cadena1[SI],AL       ;muevo a la cadena en posición si caracter en al
    INC SI                   ;incremento si
    JMP Cad1                 ;regreso al ciclo
    
    continuar:
  
    MOV AH,02H               ; para dar un salto de linea
    MOV DL,0AH
    INT 21H 
                             ; reinicio para pedir la cadena2
    
        mov dx,offset let1
        mov ah,09
        int 21h                   

 ;_____salto____   
    MOV AH,02H
    MOV DL,0AH
    INT 21H 
;______________		
                             
    MOV DL,0DH
    MOV SI,0
    
        
    
    Cad2:
    MOV AH,01H               ; pido caracter por caracter
    INT 21H 
    CMP AL,DL                ; compara si se dio enter
    je mover                 ; si es igual que enter continuo a mover las cadenas
  
    MOV cadena2[SI],AL       ; si no es enter muevo a cadena2 el caracter en al
    INC SI
    JMP Cad2                 ; incremento si y vuelvo al ciclo
    
    
    
    mover:
    
  CLD
   mov dx,offset let2
        mov ah,09
        int 21h
        
  MOV SI, OFFSET cadena1
  MOV DI, OFFSET cadena2
        
  MOV CX, si
        
        REP MOVSB
        
        
    ;_____salto____   
    MOV AH,02H
    MOV DL,0AH
    INT 21H 
	;______________
        mov dx,offset cadena2
        mov ah,09
        int 21h
    ;_____salto____   
    MOV AH,02H
    MOV DL,0AH
    INT 21H 
	;______________
 
        mov dx,offset cadena1
        mov ah,09
        int 21h
;_______________________________________________________
    fin:
    RET
        
    Main endp
    codigo ENDS
END Main