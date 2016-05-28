#!/bin/bash

#oplossing met case
(( $# != 0 )) || { echo "Gebruik: $0 argumenten" >&2 ; exit 1 ; }
case $1 in
    -i|-I )
        shift
        for x ; do
            echo "$x"
        done | tr A-Z a-z | sort | uniq -d
        ;;						#case: info bash: Each clause must be terminated with ';;', ';&', or ';;&'.
    * )
        for x ; do
            echo "$x"
        done | sort | uniq -d
        ;;
esac
