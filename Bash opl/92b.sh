#!/bin/bash
(( $# >= 1 )) || { echo Gebruik: "$0" bestandsnaam aantal >&2 ; exit 1 ; }
[[ -f "$1" ]] || { echo $1 is geen bestand  >&2  ; exit 1 ; }

aantal=${2-10}					#${parameter-value}: gebruik parameter $2 als die bestaat, zoniet gebruik value 10
lengte=$(wc -l < "$1")				# redirect $1 als input voor wc -l . De output daarvan (aantal lijnen) opslaan in var lengte
(( aantal <= lengte )) || aantal=$lengte	# als er minder lijnen zijn dan gevraagd, geef je enkel beschikbaar aantal lijnen, dus aantal aanpassen indien nodig

start=$(( lengte - aantal ))			# bepaal de lijn vanaf waar je moet starten met lijnen te printen
exec 3< "$1"
tel=0
while IFS='' read -u3 lijn ; do				# while lus om file in te lezen regel per regel
    (( tel >= start )) && echo $lijn		# als tel<start stopt conditie. Indien tel>=start gaat conditie verder en wordt lijn geprint met echo $lijn
    (( tel += 1 ))
done 	 				

exec 3<&-
