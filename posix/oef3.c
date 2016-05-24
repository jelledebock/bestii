#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>
#define AANTAL_THREADS 8
#define ARR_SIZE 1000 
struct Calculate_params{
    int ** matrix1;
    int ** matrix2;
    int ** result;
    int start_row;
};

void *calculate_row(void *);
void multiply(int);

int main(int argc, char *argv[])
{
    printf("Met Pthreads\n");
    multiply(1);
    printf("Zonder Pthreads\n");
    multiply(0);
    return 0;
}

void *calculate_row(void *params){
    struct Calculate_params * calc_params = (struct Calculate_params*)params;
    int i= calc_params->start_row,j,k,sum;
    while(i<ARR_SIZE){
        for(j=0;j<ARR_SIZE;j++){
            sum = 0;
            for(k=0;k<ARR_SIZE;k++){
                sum += calc_params->matrix1[i][k]*calc_params->matrix2[k][j];           
            }
            calc_params->result[i][j]=sum;
        }
        i+=AANTAL_THREADS;
    }
}

void print_array(int ** array){
    int i,j;
    if(ARR_SIZE>100){
        printf("Array to big to display!\n");
    }
    else{
        for(i=0;i<ARR_SIZE;i++){
            for(j=0;j<ARR_SIZE;j++){
                printf("%6d",array[i][j]);
            }
            printf("\n");
        }
    }
}

void multiply(int pthreads){
    int ** matrix1;
    int ** matrix2;
    int ** result;
    int i,j,k,sum;
    clock_t start, diff;
    int retval;
    double msec;

    //Fill the matrix
    matrix1 = malloc(sizeof(int *)*ARR_SIZE);
    matrix2 = malloc(sizeof(int *)*ARR_SIZE);
    result  = malloc(sizeof(int *)*ARR_SIZE);
    for(i=0;i<ARR_SIZE;i++){
        matrix1[i] =malloc(sizeof(int)*ARR_SIZE);
        matrix2[i] =malloc(sizeof(int)*ARR_SIZE);
        result[i]  =malloc(sizeof(int)*ARR_SIZE);
        for(j=0;j<ARR_SIZE;j++){
            matrix1[i][j] = i+j;     
            matrix2[i][j] = i+j;     
            result[i][j] = 0;
        }
    }
    //Print array
    printf("Array 1: \n");
    print_array(matrix1);
    printf("Array 2: \n");
    print_array(matrix2);

    //Execute using threads
    if(pthreads==1){
        start = clock();
        pthread_t pthreads[AANTAL_THREADS];

        //Start AANTAL_THREADS seperate threads
        for(i=0;i<AANTAL_THREADS;i++){
            struct Calculate_params params;
            params.matrix1 = matrix1;
            params.matrix2 = matrix2;
            params.result = result;
            params.start_row = i;
            retval = pthread_create(&pthreads[i],NULL, calculate_row, &params);
        }
        //join threads
        for(i=0;i<AANTAL_THREADS;i++){
            pthread_join(pthreads[i],NULL);
        }
    }
    //zonder pthreads
    else{
        start = clock();
        for(i=0;i<ARR_SIZE;i++){
            for(j=0;j<ARR_SIZE;j++){
                sum = 0;
                for(k=0;k<ARR_SIZE;k++){
                    sum += matrix1[i][k]*matrix2[k][j];
                }
                result[i][j] = sum;
            }
        }
    }
    
    diff = clock() - start;
    //print result
    printf("Result array: \n");
    print_array(result);
    msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Calculated %s pthreads: execution time %.3f\n",(pthreads>0?"using":"not using"),msec);
    
    for(i=0;i<ARR_SIZE;i++){
        free(matrix1[i]);
        free(matrix2[i]);
        free(result[i]);
    }

    free(matrix1);
    free(matrix2);
    free(result);
}
