#!/bin/bash
(( $# >= 1 )) || { echo Gebruik: "$0" bestandsnaam aantal >&2 ; exit 1 ; }
[[ -f "$1" ]] || { echo $1 is geen bestand  >&2  ; exit 1 ; } 

exec 3< "$1"

aantal=${2-10}				#${parameter-value}: gebruik parameter $2 als die bestaat, zoniet gebruik value 10
tel=0
while IFS='' read -u3 lijn ; do		# while lus om file in te lezen regel per regel in $lijn, IFS='' zorgt dat witruimte vooraan niet wordt weggelaten
    tot[tel % aantal]=$lijn		# $lijn kopieren naar array tot op positie: tel modulo aantal
    (( tel++ ))
done

exec 3<&-

(( aantal <= tel )) || aantal=$tel	# als aantal>tel (maw er zijn minder lijnen in de file dan gevraagd), wordt aantal ingesteld op aantal lijnen in file (huidige teller)

i=0				
while (( i < aantal )) ; do		#while lus om de aantal lijnen, opgeslagen in tot, weer te geven
    echo "${tot[(tel + i) % aantal]}"
    (( i ++ ))
done

