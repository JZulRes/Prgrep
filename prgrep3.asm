sys_open equ 5
sys_exit equ 1
sys_read equ 3
sys_write equ 4
stdin equ 0
stdout equ 1
stderr equ 3

section .data
archivo db "./test.txt", 0
len equ 10000

section .bss
buffer: resb 1024
msg: resb 32
section .text

global _start

_start:
;*********ABRIR ARCHIVO******
	mov eax, sys_open
	mov ebx, archivo
	mov ecx, 0
	int 80h
;****************************
;*******LEER ARCHIVO********
	mov eax, sys_read
	mov ebx, eax
	mov ecx, buffer
	mov edx, len
	int 80h
;***************************
;******Guardar la direccion del buffer
	mov dword [msg], ecx
	
;***IMPRIMIR PARA PRUEBAS***
	mov eax, sys_write
	mov ebx, stdout
	mov ecx, msg
	mov edx, len
	int 80h

;***********SALIR*****
mov eax, sys_exit
xor ebx, ebx
int 80h
