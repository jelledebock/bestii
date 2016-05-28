#!/bin/bash

./76b.sh $*
./76b.sh $@
./76b.sh "$*"
./76b.sh "$@"
IFS=:
./76b.sh $*
./76b.sh $@
./76b.sh "$*"
./76b.sh "$@"
