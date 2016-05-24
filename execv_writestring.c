#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc, char **argv)
{
    char * command [] = {"./writestring","hello"};
    int pid = fork();
    if(pid==0)
    {
        printf("System call execve\n");
        execve("./writestring",command,NULL);
    }
    else
    {
        pid = fork();
        if(pid==0)
        {
            printf("Stdl call excecl\n");
            execl("./writestring","./writestring","hello",NULL);
        }
    }
    waitid(P_ALL,pid,NULL,WEXITED);
    printf("Closing parent process...\n");
    return 0;
}
