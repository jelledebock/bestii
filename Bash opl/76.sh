#!/bin/bash

wissel(){
	local temp1=$1
	local temp2=$2
	eval "$1=${!temp2} $2=${!temp1}"
}

a=7
b=12

wissel a b  #opgelet, hier geen $-tekens gebruiken!

printf "%d %d \n" $a $b
	
