
#include<stdio.h>

#include<errno.h>

#include<string.h>

#include<sys/socket.h>

#include<arpa/inet.h>

#include<pthread.h>

#include<unistd.h>

 

#define DEST_PORT 18096

#define DEST_IP "127.0.0.1"

#define MAX_DATA 1024

 

int main()

{

    int sockfd;

    struct sockaddr_in dest_addr;

 

    sockfd=socket(AF_INET,SOCK_STREAM,0);

    if(sockfd==-1){

    	printf("socket failed:%d",errno);

    }

 

    dest_addr.sin_family=AF_INET;

    dest_addr.sin_port=htons(DEST_PORT);

    dest_addr.sin_addr.s_addr=inet_addr(DEST_IP);

    bzero(&(dest_addr.sin_zero),8);

 

    if(connect(sockfd,(struct sockaddr*)&dest_addr,sizeof(struct sockaddr))==-1){

    	printf("connect failed:%d",errno);

    } else{

        char data[] = "{\"id\":1000,\"method\":\"Arith.Divide\",\"params\":[{\"A\":9,\"B\":2}]}";

        send(sockfd,data,strlen(data),0);
        send(sockfd,data,strlen(data),0);

        printf("send success\n");

        char buf[MAX_DATA] = {0};

        while(1)

        {

            recv(sockfd,buf,MAX_DATA,0);

            if(strlen(buf) > 0){

                printf("%s\n",buf);

                break;

            }

        }

    }

    close(sockfd);

    return 0;

}
