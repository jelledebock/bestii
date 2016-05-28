#!/bin/bash
(( $# == 1 )) || { echo "Gebruik: $0 directory" >&2 ; exit 1 ; }

[[ $1 == /* ]] && DIR= || DIR=.		#als $1 met / begint, dan DIR= ; indien niet dan DIR=.

IFS=/
for d in $1 ; do			#$1 bevat xxx/yyy/zzz en IFS is / , dus wordt elke gevraagde subfolder nu bekeken
    DIR="$DIR/$d"
    if [[ ! -d "$DIR" ]]; then		#als $DIR geen bestaande directory is
        mkdir "$DIR" || exit $?		#dan aanmaken, maar ||: als mkdir faalt (bv naam bestaat al als bestand), dan exit
    fi
done
