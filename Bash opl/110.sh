#!/bin/bash
(( $# == 2 )) || { echo "Gebruik: $0 directory_tree size" >&2 ; exit 1 ; }
[[ -d "$1" ]] || { echo "$1 is geen directory" >&2 ; exit 1 ; }

a=( $(find $1 -size +$2c -type f -printf '%10s %p ' 2>/dev/null ) )  #weergeven van %s size en %p file

n=0
s=0
while : ; do
    (( s += a[n] ))			#eerste element is size 
    echo ${a[n]} " " ${a[n+1]}		#volgend element is file
    (( n += 2 ))			#n met 2 posities opschuiven om volgend size straks te bekijken
    [[ -z ${a[n]} ]] && break		#als er de array geen element heeft voor index n, dan stop de while lus met break
done

tot=$(( n / 2 ))			#de array bevat zowel de size als de filenames in aparate elementen, dus dubbel zoveel elementen als er files zijn
echo "$s bytes in $tot bestand(en)"
