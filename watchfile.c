#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
    struct stat file;
    int rc;
    time_t edited;

    if(argc==2)
    {
        while(1)
        {
            rc = stat(argv[1],&file);        
            if(rc==-1)
                perror(argv[0]);
            if(edited!=file.st_mtime)
            {
                printf("File %s changed!\n",argv[1]);
                edited = file.st_mtime;
            }
            sleep(2);
        } 
    }
    else
    {
        perror(argv[0]);
    }
    return 0;
}
