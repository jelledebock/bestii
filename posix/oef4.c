#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#define ARR_SIZE 100000000
#include <time.h>

void merge(int *tab, int n){
   int l=0,r=n/2,t=0;
   int *arr = malloc(sizeof(int)*ARR_SIZE);
   
   while(l<n/2 && r<n){
        if(tab[l]<tab[r])
            arr[t++]=tab[l++];
        else
            arr[t++]=tab[r++];
   }

   while(l<n/2)
       arr[t++]=tab[l++];
   while(r<n)
       arr[t++]=tab[r++];
   
   for(t=0;t<n;t++){
        tab[t] = arr[t];
   }
   free(arr);
}

void sort (int *tab, int n){
    if (n>1){
        /* sorteer linkerhelft */
        sort (tab,n/2);
        /*sorteer rechterhelft*/
        sort(tab+n/2,n-n/2);
        merge(tab,n);
    }
}

int* generate_table(int offset){
    int i;
    int * table = malloc(sizeof(int)*ARR_SIZE);
    for(i=0;i<ARR_SIZE;i++){
        table[ARR_SIZE-1-i]=i+offset;
    }

    return table;
}

void *generate_sort(void * params){
    int offset = *((int *)params);
    
    int *table = generate_table(offset);
    sort(table, ARR_SIZE);
}

void zonder_pthread(){
    int *tab1 = generate_table(2);
    int *tab2 = generate_table(3);

    sort(tab1,ARR_SIZE);
    sort(tab2,ARR_SIZE);
}

int main(int argc, char *argv[])
{
    int i;
    clock_t start,diff;
    printf("**Met** een pthread\n");
    pthread_t pthreads[2];
    int offset_1 = 2;
    int offset_2 = 3;
    start = clock();
    pthread_create(&pthreads[0],NULL,generate_sort,&offset_1); 
    pthread_create(&pthreads[1],NULL,generate_sort,&offset_2); 
    pthread_join(pthreads[0],NULL);
    pthread_join(pthreads[1],NULL);
    diff = clock()-start;
    printf("\t Voltooid: %ldms\n", diff*1000/CLOCKS_PER_SEC);
    printf("**Zonder** een pthread\n");
    start = clock();
    zonder_pthread();
    diff = clock()-start;
    printf("\t Voltooid: %ldms\n", diff*1000/CLOCKS_PER_SEC);

    return 0;
}
