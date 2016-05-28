#!/bin/bash
while [[ $1 ]] ; do
    [[ $1 == -?* ]] && for (( i = 1 ; i < ${#1} ; i++ )) ; do echo ${1:$i:1} ; done	#${#variabele} geeft de lengte van de waarde van de variabele in karakters; ${variabele:offset:length} geeft de deelstring vanaf positie offset met length tekens.
    shift										#pos params opschuiven zodat $2 $1 wordt
done
