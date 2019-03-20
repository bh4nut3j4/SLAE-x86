#include <stdio.h>
#include <string.h>

unsigned char code[] = \

int main(){
	printf("Shellcode Length:  %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();
}

//Compilation : gcc shellcode.c -o shellcode -fno-stack-protector -z execstack
