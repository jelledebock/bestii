#include <stdlib.h>
#include <stdio.h>
#include <semaphore.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <unistd.h>
#include <time.h>
#define AANTAL_KINDEREN 200

sem_t read_sem;
int read_sem_v;
void * map_value;
void * map_pid;

int main(int argc, char *argv[])
{
    int i;
    int j;
    int pid;
    int num;

    pthread_t children[AANTAL_KINDEREN];

    sem_init(&read_sem, read_sem_v, AANTAL_KINDEREN);
    //create a shared object
    int  fd_value = shm_open("getal", O_CREAT|O_RDWR,0777);
    int  fd_pid= shm_open("pid", O_CREAT|O_RDWR,0777);

    if(fd_value==-1 || fd_pid==-1){
        perror("OEF2");
        exit(1);
    }
    
    ftruncate(fd_value,sizeof(int)*AANTAL_KINDEREN);
    ftruncate(fd_pid,sizeof(int)*AANTAL_KINDEREN);

    map_value = mmap(NULL, sizeof(int)*AANTAL_KINDEREN, PROT_READ|PROT_WRITE, MAP_SHARED, fd_value, 0);
    map_pid   = mmap(NULL, sizeof(int)*AANTAL_KINDEREN, PROT_READ|PROT_WRITE, MAP_SHARED, fd_pid, 0);

    //Start child threads
    for(i=0;i<AANTAL_KINDEREN;i++){
        pid = fork();
        if(pid==0){
            //in child proc
            srand(getpid());
            num = rand()%1000;
            ((int *)map_value)[i] = num;
            ((int *)map_pid)[i] = getpid();
            sem_wait(&read_sem);
            sem_post(&read_sem);
            //get highest pid
            pid = -999999;
            num = -999999;
            for(j=0;j<AANTAL_KINDEREN;j++){
                if(((int *)map_value)[j]>num){
                    num = ((int *)map_value)[j];
                    pid = ((int *)map_pid)[j];
                }
            }
            sem_post(&read_sem);
            printf("[#%d] Process %d has the highest value (%d)\n",getpid(),pid,num);
            return 0;
        }
        else{
            waitid(P_ALL, pid, NULL, WEXITED);
        }

    }
    munmap(map_value, sizeof(int)*AANTAL_KINDEREN);
    munmap(map_pid, sizeof(int)*AANTAL_KINDEREN);

    return 0;
}
