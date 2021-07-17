.286
pila segment stack
db 32 dup('stack_')
pila ends

data segment
 CAD DB 0DH,0AH,'ESTE PROGRAMA CALCULA EL FACTORIAL  $'
 DATO DB ?,'$'
 DATO1 DB ?,'$'
 
data ends


code segment para 'code'
inicio proc far

assume cs:code,ds:data,ss:pila

push ds
push 0
mov ax,data
mov ds,ax



FIN:
  mov ax,4c00h
int 21h
inicio endp
code ends

end inicio