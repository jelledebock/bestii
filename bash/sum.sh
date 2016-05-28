#!/bin/bash

if [ $# -ge 1 ]; then 
    sum=0;
    numargs=$#
    for (( i=0; i<numargs; i++ )) 
    do
        val=$1
        shift
        sum=$((sum+val))
    done
    echo "Sum = $sum"
fi
