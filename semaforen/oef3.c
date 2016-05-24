#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

#define AANTAL_FILOSOFEN 4

pthread_t pthreads[AANTAL_FILOSOFEN];
pthread_mutex_t locks[AANTAL_FILOSOFEN];
char *topics[3] = {"life","death","world hunger"};

void *philosopher(void *arg){
    int philonum = *((int *)arg);
    int left_fork;                  //left fork index
    int right_fork;                 //right fork index
    left_fork=philonum;
    if(philonum==AANTAL_FILOSOFEN-1)
        right_fork = 0;
    else
        right_fork = philonum+1;
    
    printf("New philosopher detected (#%d), will be using forks %d and %d to eat.\n",philonum,left_fork,right_fork);

    while(1){
        sleep(rand()%3);
        printf("[#%d] Philosophing about %s.\n",philonum,topics[rand()%3]);        
        //simulating thinking state for 0-10 seconds
        sleep(rand()%10);
        //Hungry!! First try to lock the lower indexed fork
        pthread_mutex_lock(&locks[left_fork]);
        pthread_mutex_lock(&locks[right_fork]);
        printf("[#%d] Mmmm, spaghettis!!! Nom...nom...nom!\n",philonum);
        //simulate eating state for 0-10 seconds
        sleep(rand()%10);
        //Stop eating
        pthread_mutex_unlock(&locks[left_fork]);
        pthread_mutex_unlock(&locks[right_fork]);
    }
}
int main(int argc, char *argv[])
{
    int i;
    int philonums[AANTAL_FILOSOFEN];
    //init locks
    for(i=0;i<AANTAL_FILOSOFEN;i++){
        philonums[i]=i;
        pthread_mutex_init(&locks[i],NULL);
        pthread_create(&pthreads[i],NULL,philosopher,&philonums[i]);

    }
    for(i=0;i<AANTAL_FILOSOFEN;i++){
        pthread_join(pthreads[i],NULL);
    }
    return 0;
}
