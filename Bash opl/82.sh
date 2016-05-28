#!/bin/bash

#1

x=$(($#-1))
echo ${!x}

#2

eval echo '$'$(($#-1))
