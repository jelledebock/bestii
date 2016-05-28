#!/bin/bash
IFS=':'
x=ik:ben:groot
echo x = $x 
echo x = "$x"
echo x = '$x'
grep -E ^x= < <(set)
grep -E ^x < <(set)	
declare -p x
declare -p ${!x*}
