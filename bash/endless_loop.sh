#!/bin/bash

seconds=5
[ $# -eq 1 ] && seconds=$1

while :; do
    echo "yes"
    sleep ${seconds}s
done
