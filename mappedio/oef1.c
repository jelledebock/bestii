#include <stdlib.h>
#include <stdio.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
    int rc;
    struct stat filestat;
    if(argc==2){
        //reserve space for argv, reserve space for the file
        int fd = open(argv[1],O_RDONLY);
        if(fd==-1){
            perror("Could not find file!");
            exit(-1);
        }
        fstat(fd, &filestat);

        void * map = mmap(NULL, filestat.st_size,PROT_READ,MAP_SHARED,fd,0);
        //map is completed, you can now close the fd
        rc=close(fd);
        if(rc==-1){
            perror("Error closing FD!");
            return(-1);
        }
        //start reading mapped memory of the file and print to stdout
        printf("%s",(char *)map); 
        //release mapped io
        munmap(map,filestat.st_size);
    }
    else{
        perror("Invalid syntax: usage cat [filename]");
        exit(-1);
    }
    return 0;
}
