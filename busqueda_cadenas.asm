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

section .data
siesta: db "El texto si se encuentra en el archivo",10,0
siesta_len: equ $-siesta

noesta: db "El texto no se encuentra en el archivo", 10, 0
noesta_len: equ $-noesta

section .bss
n resb 1000000
m resb 20000
i resb 1000
j resb 1000
x resb 1000
section .text


string_match:
	;string_match(patron, patron_t, texto, texto_t)
	pop eax ;patron en eax
	pop m ; tamaño del patron en m
	pop ebx ;texto en ebx
	pop n ;tamaño del texto en n
	
	mov i, 0
ciclo1: mov x, n
	sub x, m ;x = m-n
	cmp i, x 
	jge terminar
	mov j, 0
ciclo2: ;calcular j<m && msg[i+j]==p[j]
	cmp j, m
	jb primersi
	;else
	call incr_i
nociclo2: cmp j, m
	jne ciclo1
	print siesta, siesta_len
	exit

primersi:
	push esi
	mov esi, i
	add esi, j
	push edi
	mov edi, j
	cmp byte[ebx+esi], byte[eax+edi]
	pop esi
	pop edi
	je segundosi
	jmp nociclo2

segundosi:
	push eax
	mov eax, j
	inc eax
	mov [j], eax
	pop eax
	jmp ciclo2

incr_i:
	push eax
	mov eax, i
	inc eax
	mov [i], eax
	pop eax
	ret 

terminar:
	print noesta, noesta_len
	exit
