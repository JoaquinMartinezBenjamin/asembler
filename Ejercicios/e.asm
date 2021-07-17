.286
	write macro mensaje
		lea dx, mensaje
		mov ah,09h
		int 21h
	endm
	
	posiciona_cursor macro reng, col
		mov ah,02h
		mov dh,reng
		mov dl, col
		mov bh,00h
		int 10h
	endm
	
pila segment stack
	db 32 dup ('stack_')
pila ends

data segment
	cad db 30 dup ('$')
	cad2 db 3 dup ('$')
	cad3 db 30 dup ('$')
	msj db 'Ingrese cadena a encriptar: $'
	msj2 db 'Ingresa un numero del 1-3: $'
	msj3 db 'Cadena original: $'
	msj4 db 'Cadena encriptada: $'
	x dw (0),'$'
	
data ends

code segment
	principal proc far
	assume cs:code, ds:data,ss:pila
	
	push ds
	push 0
	
	mov ax,data
	mov ds,ax
	
	
	call clrscr
	posiciona_cursor 08,10
	write msj
	mov si,0
	mov di,0
	
ciclo:
	call pide
	cmp al,0dh
	je eti
	
	mov cad[si],al
	inc si
	jmp ciclo
	
eti:
	mov si,0
	
	posiciona_cursor 09,10
	;write cad
	write msj2
ciclo2:
	call pide
	cmp al,0dh
	je encriptar
	cmp al,31h
	jb ciclo2
	cmp al,33h
	ja ciclo2

	mov cad2[di],al
	inc di
	
	jmp ciclo2

encriptar:
	mov si,0
	mov di,0
	mov cl,255
	
	encriptar2:
		mov al,cad[si]
		mov bl,cad2[di]
		mul bl
		
		
		sub cl,al
		
		mov cad3[si],cl
		inc si
		
		cmp cad[si],'$'
		je imprimir
		jmp encriptar2

imprimir:
	posiciona_cursor 12,10
	write msj3
	write cad
	
	posiciona_cursor 13,10
	write msj4
	write cad3
	
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
		mov bh,30h
		mov cx,0000h
		mov dx,184fh
		int 10h
		ret
	clrscr endp
	
	principal endp
	code ends
	end principal