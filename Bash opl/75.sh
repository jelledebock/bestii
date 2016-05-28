#!/bin/bash

faculteit(){
	res=1
	for((i=$1;i>1;i--));do
		((res*=i))
	done
	return $res
}

faculteit 5
echo $?
