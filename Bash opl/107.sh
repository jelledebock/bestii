#!/bin/bash
(( $# == 3 )) || { echo "Gebruik: $0 directory pattern regexp" >&2 ; exit 1 ; }
[[ -d "$1" ]] || { echo "$1 is geen directory" >&2 ; exit 1 ; }

for d in $( find "$1" -type d 2>/dev/null ) ; do					#voor alle subdirs d in directory $1
    for f in $( find "$d" -maxdepth 1 -type f -name "$2" 2>/dev/null ) ; do		#voor alle files in directory d die matchen met pattern $2
        grep -E $3 "$f" > /dev/null 2>&1 && { echo $f ; break ; }			#zoek regex $3 in file f en indien gevonden: echo en break uit binnenste for-lus
    done
done
