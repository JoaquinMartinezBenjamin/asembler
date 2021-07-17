.286
include benja.lib

pila SEGMENT stack
	DB 32 DUP ('stack___')
pila ENDS

datos SEGMENT
	cad1 db  5 dup(?),0DH, 0AH,'$'
	cad2 db  5 dup(?),0DH, 0AH,'$'
	let1 db  'Ingresa una cadena: ', 0DH, 0AH,'$'
	let2 db  'Ingresa la cadena a comparar: ', 0DH, 0AH,'$'
	igual db  'Cadenas iguales', 0DH, 0AH,'$'
	dif db  'Cadenas diferentes', 0DH, 0AH,'$'


		 
		 datos ENDS
codigo SEGMENT 'CODE'
Assume ss:pila, ds:datos, cs:codigo
Main PROC FAR
PUSH DS
PUSH 0
MOV AX, datos
MOV DS,AX
		 

	MOV ES,AX 
		
		clear
		write let1
		llenar cad1
		write let2
		llenar cad2
		
		write let2  ;
		call leer   ;

		lea si, cad1
		lea di, cad2
		mov cx,lengthof cad1
		repe cmpsb
		jne diferentes
		jmp iguales

		diferentes:
			write dif
			jmp salir
		iguales:
			write igual
			jmp salir

		salir:
			RET
	Main ENDP

codigo ENDS
END Main