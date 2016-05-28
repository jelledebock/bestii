#!/bin/bash

lines=10

if [ $1 ]; then
    lines=$1    
fi

tail -n $lines ~/.bash_history
