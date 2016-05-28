#!/bin/bash

#oplossing met if en ${x,,} (vanaf bashv4)
(( $# != 0 )) || { echo "Gebruik $0 argumenten" >&2 ; exit 1 ; }

if [[ $1 == -[iI] ]] ; then
    shift
    for x ; do
        echo "${x,,}"		#${x,,}: string operator: converteert hele string naar lowercase
    done | sort | uniq -d
else
    for x ; do
        echo "$x"
    done | sort | uniq -d
fi


