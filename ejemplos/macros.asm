%define sometext "my string"
%strlen sometext_s sometext

%macro print 2 ;macro con dos argumentos de nombre 'print'
	section .data 
	%%fmt: db %1
	section .text
	mov eax, 4 ;imprimir en consola
	mov ebx, 1 ;stdout
	mov ecx, %%fmt ;primer argumento
	mov edx, %2 ;segundo argumento
	int 80h ;interrupcion del SO
%endmacro

%macro exit 0
	mov eax, 1
	mov ebx, 0
	int 80h
%endmacro

section .text

global _start

_start:
	print sometext, sometext_s
	exit

section .data
;text: db 'Hello, world!'
