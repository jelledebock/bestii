#!/bin/bash
totaal_lijnen=0

for file in ${@:-*} ; do   #ofwel ${@} (alle arg), ofwel indien argumenten leeg zijn, dan: * (die gebruikt zal worden voor pathname expansion om alle files op te vragen)
    if [[ -f "$file" ]] ; then
        lijnen=0
	exec 3< "$file"
        while read -u3 lijn ; do
            (( lijnen++ ))
        done 
	exec 3<&-
        printf "%10d %s\n" $lijnen "$file"

        (( totaal_lijnen += lijnen ))
    fi
done

printf "\n%10d totaal aantal lijnen\n" $totaal_lijnen
