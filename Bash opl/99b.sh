#!/bin/bash
(( $# == 1 )) || { echo "Gebruik: $0 groepsnummer" >&2 ; exit 1 ; }

#oplossing via associatieve array
users=$( grep -E ":$1:" /etc/group | cut -d: -f4 )	#regels met telkens de kommagescheiden lijst van users van een regel waar :$1: voorkomt (users die dit secundaire groep hebben)
groep=$( grep -E ":$1:" /etc/group | cut -d: -f1 )	#regels met telkens enkel de groepnaam van een regel waar :$1: voorkomt

declare -A array

IFS=","							#4e veld van /etc/group bevatten kommagescheiden waarden, dus hierop controleren
for i in $users ; do					#$users is gewoon de kommagescheiden string die gegeven wordt aan de for-lus
    array[$i]=""					#de gevonden users wegschrijven in een associatieve array met als index username en dummy value (lege string)
done

							#zoek nu ook de accounts in /etc/passwd die $1 als groep hebben (primair nu)
while IFS=: read account passwd uid gid rest ; do
    (( $1 == gid )) && array[$account]=""		#gevonden users op deze manier toevoegen aan ass array (als waarde al bestond met lege string) wordt die overschreven met ook een lege string
done < <(grep ":$1:" /etc/passwd)
echo Groep $groep\($1\) bevat ${#array[@]} gebruikers: ${!array[@]} #duplicaten bestaan niet, direct printen

