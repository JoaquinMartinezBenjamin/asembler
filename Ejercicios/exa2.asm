.286
;Programa que compara si dos cadenas son iguales o no.
	
	write MACRO mensaje
		lea dx, mensaje
		mov ah,09h
		int 21h
	endm
	
	exhibe_caracter MACRO reg
		mov ah,02h
		mov dl,reg
		int 21h
	endm
	
	posiciona_cursor MACRO renglon,columna
		mov ah,02h  
		mov dh, renglon    
		mov dl, columna
		mov bh,00h
		int 10h	
	 endm
	
	
pila segment stack
	db 32 dup ('stack_')
pila ends

	data segment 
		;cad db'hola$'
		;cad2 db 'hola$'
		cad db 'INSTITUTO TECNOLOGICO DE OAXACA$'
		cad2 db 'INSTITUTO TECNOLOGICO DEL ITSMO$'
		cad3 db 50 dup ('$')
		cad4 db 'hola$'
		;cad db'ive$'
		;cad2 db 'ive$'
		;cad db'instituto tecnologico de oaxaca$'
		;cad2 db 'instituto tecnologico de oaxaca$'
		iguales db 'Son iguales$'
		desiguales db 'No son iguales$'
		x dw (?),'$'
		y dw (?),'$'
	data ends

	code segment
	
	principal proc far
		assume cs:code, ds:data, ss:pila

	push ds
	push 0

	mov ax, data
	mov ds, ax
		
		call clrscr
	
		mov si,0
		mov di,0
		;lea si,cad
		;lea di,cad2
		posiciona_cursor 08,10
		write cad
		posiciona_cursor 09,10
		write cad2
		
		;sub ax,ax ;limpio el registro

	compara:
		mov x,si
		mov y,di
		
		mov al,cad[si]  
		mov ah,cad2[di]
		
		cmp al,ah
		jne no_es 
	
		cmp ah,24h;'$'
		je si_es

		inc si
		inc di
		jmp compara
	
	si_es:
		posiciona_cursor 11,10
		write iguales
		jmp salir
		
	no_es:
		posiciona_cursor 11,10
		write desiguales
		;mov y,di
		mov si,x
		mov di,0
	copiar:	
		mov al,cad[si]
		mov cad3[di],al
		cmp al,'$'
		je cop
		inc si
		inc di
		jmp copiar
		
	cop:
		mov si,y
	copiar2:
		mov al,cad2[si]
		mov cad3[di],al
		cmp al,'$'
		je imprimir
		inc si
		inc di
		jmp copiar2
	imprimir:
		posiciona_cursor 12,10
		lea bx,cad3
		write [bx]
	salir:
		mov ax,4c00h
		int 21h
		
	pide proc
		mov ah,01h
		int 21h
		ret
	pide endp
	
	clrscr proc						
		mov ax,0600h
		mov bh,50H
		mov cx,0000h
		mov dx,184FH
		int 10H			
		ret
	clrscr ENDP
		
principal endp
code ends
end principal