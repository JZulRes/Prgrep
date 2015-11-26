; prgrep "texto para buscar" archivo.txt

%macro print 2
	mov ecx, %1
	mov edx, %2	
	mov eax, 4
	mov ebx, 1
	int 80h
%endmacro 

%macro exit 0
	mov eax, 1
	mov ebx, 0
	int 80h
%endmacro

section .bss
buffer: resb 1024

section .data
is_there: db "El patrón está presente en el texto",0
is_there_msg: equ $-is_there

no_args: db "No hay nada para buscar",10,0
no_args_msg: equ $-no_args

espacio: db " ",0
espacio_tam: equ $-espacio

salto_linea: db 10,0
salto_linea_t: equ $-salto_linea

section .text
global _start

_start:
	pop ecx
	cmp ecx, 1
	je sin_args

	pop eax
	pop eax ;el primer argumento
	call length_string
	

	pop eax ;segundo argumento -> nombre del archivo
	call length_string

;******ABRIR ARCHIVO*******
	mov ebx, eax
	mov eax, 5
	mov ecx, 0
	int 80h
	
;******LEER DESDE ARCHIVO*********
	mov eax, 3
	mov ebx, eax
	mov ecx, buffer
	mov edx, 2000
	int 80h

;******IMPRIMIR?***********
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer
	mov edx, 2000
	int 80h

	mov eax, 6
	int 80h

	exit

sin_args:
	print no_args, no_args_msg
	exit

;palabra en eax. tamaño en ebx
length_string:
	mov ebx, 0
_loop:
	cmp byte[eax+ebx], 0
	jz finish
	inc ebx
	jmp _loop
finish:
	ret
