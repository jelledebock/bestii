#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <time.h>
#include <limits.h>

void *zoek_min(void * list)
{
    int min = INT_MAX;
    int i;
    for(i=0;i<1000000;i++)
    {
        if(((int *)list)[i]<min)
            min = ((int *)list)[i];
    }
    printf("Smallest of the list %d\n",min);
}

void *zoek_max(void * list)
{
    int max= INT_MIN;
    int i;
    for(i=0;i<1000000;i++)
    {
        if(((int *)list)[i]>max)
            max = ((int *)list)[i];
    }
    printf("Biggest of the list %d\n",max);
}

int main(int argc, char *argv[])
{
    pthread_t minproc, maxproc;
    int retvalmin, retvalmax;
    int biglist[1000000];
    int i;
    srand(time(NULL));
    //Generate 1 000 000 random numbers
    for(i=0;i<1000000;i++)
    {
        biglist[i]=rand()%1000000;
    }
    //Start minimum search
    retvalmin = pthread_create(&minproc, NULL, &zoek_min, biglist);
    if(retvalmin){
        perror("Error: min kon niet gezocht worden!");
        exit(0);
    }
    //Start maximum search
    retvalmin = pthread_create(&maxproc, NULL, &zoek_max, biglist);
    if(retvalmin){
        perror("Error: max kon niet gezocht worden!");
        exit(0);
    }

    //Join threads
    pthread_join(minproc,NULL);
    pthread_join(maxproc,NULL);

    return 0;
}
