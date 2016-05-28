#!/bin/bash

(( $# == 2 )) || { echo Gebruik: "$0" directory_tree size >&2 ; exit 1 ; }
[[ -d "$1" ]] || { echo "$1" is geen directory >&2 ; exit 1 ; }
IFS="§"
n=0
s=0
while read x y ; do 	#kies een delimiter die niet voorkomt in de bestandsnamen
	echo $x $y
	(( n++ ))
	(( s += x ))
done < <(find $1 -size +$2c -type f -printf "%10s$IFS%p\n" 2>/dev/null)
printf "\n%10s bytes in %d bestand(en)\n" $s $n

