.model small
;include libre.lib
pinta macro color,let
	MOV AL,let
    MOV BL,color
    MOV BH,0
    MOV CX,25
    MOV AH,09H
    INT 10H
endm

dec2d macro X,num1,num2
			mov ah, 00
			mov al,X
			mov bl,10
			div bl
			add al, 30H
			mov num1, al
			add ah, 30h
			mov num2, ah
endm dec2d

initMause macro
	mov ax, 0001h
	int 33h
endm initMause

estado_mouse macro
	mov ax,03h
	int 33h
	cmp bx,01
endm
	
getclick2 macro x,y,ocho
	mov ax, 003h
    int 33H
    mov ax,cx
    div ocho
    mov x,al
    mov ax,dx
    div ocho
    mov y,al
endm getclick2

write MACRO mensaje
	LEA DX, mensaje
	MOV AH, 09H
	INT 21H
ENDM

gotoxy MACRO fila, columna
	MOV AH, 02H
	MOV BH, 00H
	MOV DH, fila
	MOV DL, columna
	INT 10H
ENDM

clrscr MACRO
	MOV AX, 0600H
	MOV BH, 17H
	MOV CX, 0000H
	MOV DX, 184FH
	INT 10H
ENDM

pinta_caracter macro
	mov ah,09h	;Peticion de despliegue 
	mov al,219	;Caracter que se despliegue
	mov bh,00H	;Pagina numero 0
	mov bl,4FH	;Atributo de caracter [Fondo][Frente]
	mov cx,5	;Numero de veces a mostrar
	int 10h		;Llama al BIOS
endm

.stack
.data
	uno db 'Mostrar las coordenadas del cursor y clics para estados del mouse$'
	izquierdo db 'Clic izquierdo presionado$'
	derecho db 'Clic derecho presionado$'
	valx db 'X:  $'
	valy db 'Y:  $'
	
	ocho db (8)
	X DB ?
	Y DB ?
	res db ?,'$'
	ex db ?,'$'
	msj db 'Boton$'
	bot db 'Mouse encima del boton$'
	bot2 db 'Boton presionado$'
.code
	main:
		mov ax, @data
		mov ds, ax
		mov es, ax
		
		clrscr
		
		gotoxy 5,10
		write UNO	
		
		gotoxy 12,35
		pinta_caracter
		gotoxy 12,35
		write msj
		
	ciclo:			
			initMause
			getclick2 X,Y,ocho	
			estado_mouse
			cmp bx,2
			je salir1
			cmp bx,1
			je espera
			
			
			cmp X,37
			jne espera2
			cmp Y,12
			je mostrar
			
			jmp ciclo
			
		mostrar:
			gotoxy 13,35
			write bot
			gotoxy 14,35
			write bot2
			gotoxy 13,35
			pinta 17h,' '
			gotoxy 14,35
			pinta 17h,' '
			jmp ciclo
		salir1:
			jmp salir
		espera:
			gotoxy 10,35
			write izquierdo
		espera2:
			dec2d X,res,ex
			
			gotoxy 07,35
			write valx
			write res
			write ex
			
			dec2d Y,res,ex
			
			gotoxy 08,35
			write valy
			write res
			write ex
			gotoxy 10,35
			pinta 17h,' '
		jmp ciclo
			
		salir:
			gotoxy 10,35
			write derecho
			mov ax, 4c00H
			int 21h
	end main
	
end