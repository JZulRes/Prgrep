;nasm 
sys_open equ 5
sys_exit equ 1			;
sys_read equ 3
sys_write equ 4
stdin equ 0
stdout equ 1
stderr equ 3
archivo db "./test.txt", 0


section .data
menosefe: db 'Escribiste -f', 10
menosefe_t: equ $-menosefe

nomenosefe: db 'No escribiste -f', 10
nomenosefe_t: equ $-nomenosefe 

msg_sin_args: db 'No hay nada para buscar', 10
msg_sin_args_t: equ $-msg_sin_args

msga: db 'El segundo argumento lo encontre!!!!', 10
msga_t: equ $-msga

section .text
global _start

_start:
	push ebp
	mov ebp, esp
	cmp dword [ebp +4], 1 ;mira si no hay args
	je SinArgs ;sub-rutina
	mov ebx, 3

next_arg:
	mov edi, dword [ebp+4*ebx]
	test edi, edi ; lo mismo que cmp edi, 0. pregunta si ya no hay mas args
	jz salir
	call arg_len ;trae el tamaño del argumento (string)
	push edx
	mov ecx, dword [ebp+4*ebx] ;mueve el argumento a ecx
	call mostrar_arg
	inc ebx
	jmp next_arg

SinArgs:
	;si no hay ningun argumento se debe imprimir ERROR
	mov eax, sys_write
	mov ebx, stdout
	mov ecx, msg_sin_args
	mov edx, msg_sin_args_t
	int 80h
	jmp salir 

mostrar_arg:
	push ebx ;parametro para el sys_write
	mov eax, sys_write ;llamo el sys_write
	mov ebx, stdout ;que lo muestre en salida estandar
	int 80h ;interrupcion del OS
	pop ebx ;traigo el ebx que tenía antes
	ret ;termina la subrutina

arg_len:
	push ebx
	xor ecx, ecx ;lo mismo que mov ecx, 0
	not ecx
	xor eax, eax
	cld ;limpia el flag de direccion
	repne scasb ;REPeat until Not Equal SCAn String b
	;scanea el string hasta que sea NUL (ASCII)
	mov byte[edi -1], 10
	not ecx
	pop ebx
	lea edx, [ecx - 1]
	ret


salir:
	mov esp, ebp
	pop ebp
	mov eax, sys_exit
	xor ebx, ebx
	int 80h
