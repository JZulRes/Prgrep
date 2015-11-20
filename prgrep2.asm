sys_open equ 5
len equ 1024
stdout equ 1
sys_write equ 4
sys_exit equ 1
section .data
msg1: db 'Abri el archivo'
msg1_t: equ $-msg1

msg2: db 'No abri el archivo'
msg2_t: equ $-msg2

section .bss
buffer: resb 1024

section .text
global _start

_start:
	mov ebx, 4	
	mov ecx, dword [ebp+4*ebx]

	mov eax, sys_write
	mov ebx, stdout
	mov edx, len 
	

	mov ebx, ecx ;muevo el buffer a ebx
	mov eax, sys_open ;abrir
	mov ecx, 0
	int 80h
	
;***IMPRIMIR LO QUE HAY EN EL ARCHIVO*****

	mov eax, 3
	mov ebx, eax
	mov ecx, buffer
	mov edx, len
	int 80h

;********PRINT MSG1********


	mov eax, sys_write
	mov ebx, stdout
	mov ecx, msg1
	mov edx, msg1_t
	int 80h

;*******EXIT*********
mov eax, sys_exit
mov ebx, 0
int 80h
