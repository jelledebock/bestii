#include <stdio.h>
#include <unistd.h>

int main(int argc, char ** argv)
{
    printf("%d : %s\n",getpid(),argv[1]);
    sleep(10);    
    return 0;
}
