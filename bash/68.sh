#!/bin/bash

start=$SECONDS
ls -lR / > /dev/null 2>&1
printf "Elapsed time: %d"  $(($SECONDS-start))
