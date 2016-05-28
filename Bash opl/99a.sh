#!/bin/bash
(( $# == 1 )) || { echo "Gebruik: $0 groepsnummer" >&2 ; exit 1 ; }

#oplossing via temp file
users=$( grep -E ":$1:" /etc/group | cut -d: -f4 )	#regels met telkens de kommagescheiden lijst van users van een regel waar :$1: voorkomt (users die dit secundaire groep hebben)
groep=$( grep -E ":$1:" /etc/group | cut -d: -f1 )	#regels met telkens enkel de groepnaam van een regel waar :$1: voorkomt

f=$( mktemp XXXXXX )
exec 3> $f
IFS=","							#4e veld van /etc/group bevatten kommagescheiden waarden, dus hierop controleren
for i in $users ; do					#$users is gewoon de kommagescheiden string die gegeven wordt aan de for-lus
    echo $i >&3 					#de gevonden users wegschrijven naar $f
done

							#zoek nu ook de accounts in /etc/passwd die $1 als groep hebben (primair nu)
while IFS=: read account passwd uid gid rest ; do
    (( $1 == gid )) && echo $account >&3 		#gevonden users op deze manier ook wegschrijven naar $f
done < <(grep ":$1:" /etc/passwd)

aant=$( sort $f | uniq | wc -l )			#duplicaten in $f wegfilteren en tellen
users=""						#var users gebruiken om string op te stellen van alle users
 
while read user ; do
    users="$users${user} "				#de tekst in var users aanvullen: users overschrijven met zichzelf, de ingelezen var user en een spatie
done < <(sort $f | uniq | wc -l) 
echo Groep $groep\($1\) bevat $aant gebruikers: $users

exec 3>&-
rm -f "$f"
