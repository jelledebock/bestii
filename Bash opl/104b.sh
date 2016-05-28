#!/bin/bash
#Alternatief met for:
for x ; do										#geen expliciete lijst dus: for x in $@ (alle argumenten)
    [[ $x == -?* ]] && for (( i = 1 ; i < ${#x} ; i++ )) ; do echo ${x:$i:1} ; done	#${#variabele} geeft de lengte van de waarde van de variabele in karakters; ${variabele:offset:length} geeft de deelstring vanaf positie offset met length tekens.
done
