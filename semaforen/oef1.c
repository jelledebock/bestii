#include <stdio.h>
#include <stdlib.h>
#include <semaphore.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>
#define NUM_THREADS 8
#define AANT_TICKS 1000 

pthread_t pthreads[NUM_THREADS];
int aantal_tickets = AANT_TICKS;
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

void *ticket_broker(void * args){
    int aantal_verkocht=0;
    int brokernum = *((int *)args);
    time_t rawtime;
    struct tm * timeinfo;
    while(1){
        sleep(rand()%3);
        pthread_mutex_lock(&lock);
        if(aantal_tickets>0){
            time(&rawtime);
            timeinfo = localtime(&rawtime);
            printf("[%.24s] Broker %d sold 1 ticket. (only %d tickets left now)\n",asctime(timeinfo),brokernum,aantal_tickets);
            aantal_tickets--;
            aantal_verkocht++;
        }
        else{
            pthread_mutex_unlock(&lock);
            printf("======================\nBroker %d sold %d tickets.\n==========================\n",brokernum,aantal_verkocht);
            return 0;
        }
        pthread_mutex_unlock(&lock);
    }
}

int main(int argc, char *argv[])
{
    int i=0,brokernum[NUM_THREADS];
    for(i=0;i<NUM_THREADS;i++){
        brokernum[i] = i;
        pthread_create(&pthreads[i],NULL,ticket_broker,&brokernum[i]);
    }
    for(i=0;i<NUM_THREADS;i++){
        pthread_join(pthreads[i],NULL);
    }
    return 0;
}


