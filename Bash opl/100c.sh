#!/bin/bash

#oplossing met if en ${x,,} (vanaf bashv4) met [[...]] ipv if

(( $# != 0 )) || { echo "Gebruik $0 argumenten" >&2 ; exit 1 ; }

[[ $1 == -[iI] ]] && { shift ; set "${@,,}" ; } #argumenten van script ev door lowercase overschrijven door met set de pos params in te vullen, ${x,,] string operator toepassen, op $@ nl alle pos params

for x ; do				#for-lus zonder paramlijst betekent kijken naar $@, alle pos pars
    echo "$x"
done | sort | uniq -d

