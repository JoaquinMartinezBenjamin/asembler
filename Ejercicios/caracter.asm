.286
; Donaldo Garcia Justiniano, lenguajes de Interfaz, 1-2 pm
include donaldo.lib

spila SEGMENT stack
	DB 32 DUP ('stack___')
spila ENDS

sdatos SEGMENT
	msj1 db 'Ingresa un caracter: ','$'
	msj2 db 'Es un numero ','$'
	msj3 db 'Es una letra ','$'
	msj4 db 'Precione esc para salir ','$'
sdatos ENDS

scodigo SEGMENT 'CODE'
	ASSUME SS:SPILA, DS:SDATOS, CS:SCODIGO

	PRINC PROC FAR
	PUSH DS
    PUSH 0
    MOV AX,sdatos
	MOV DS,AX 
		
		clear
		ciclo:
			clear
			gotoxy 10,20
			write msj4
			gotoxy 1,20
			write msj1
			gotoxy 2,25
			read
			cmp al, 27 ; compara con esc
			je salir

			cmp al,97 ; compara codigo ascci con letra a
			jb num ; salta si es inferior
			cmp al,122 ; compara con codigo asccci la letra z
			ja ciclo ;salta si es superior

			gotoxy 4,20
			write msj3
			read
			jmp ciclo

		num:
			cmp al,57
			ja letra  ; salta si es superior
			cmp al,48 ; compara con codigo assi rango de numero
			jb ciclo  ; salta si es inferior
			gotoxy 5,20
			write msj2
			read
			jmp ciclo

		letra:
			cmp al,65
			jb ciclo
			cmp al,90
			ja ciclo
			gotoxy 5,20
			write msj3
			read
			sub al,32h
			jmp ciclo


		salir:
		clear
		RET
	princ ENDP




scodigo ENDS
END princ