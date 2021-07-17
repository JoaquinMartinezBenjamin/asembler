.286
pila segment stack
db 32 dup('stack_')
pila ends



ESDISCO STRUCT
sectorInicial DWORD 0    ; número del sector inicial  
 numSectores   WORD 1    ; número de sectores 
 despBufer     WORD OFFSET bufer  ; desplazamiento del búfer  
 segBufer      WORD SEG bufer    ; segmento del búfer 
 ESDISCO ENDS
 
data segment
bufer BYTE 512 DUP(?)
estrucDisco ESDISCO <>
estrucDisco2 ESDISCO<10,5> 


data ends

code segment para 'code'
inicio proc far

assume cs:code,ds:data,ss:pila
push ds 

push ax
mov ax,data
mov ds,ax


  
 mov ax,7305h
 mov cx,0FFFFh
 mov dl,3
 mov bx,offset estrucDisco
 mov si,0
 int 21h;
 salir:
  ret
inicio endp
code ends

end inicio
