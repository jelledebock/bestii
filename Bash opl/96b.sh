#!/bin/bash

exec 3< /etc/group

while IFS=$'\n': read -u3 groep passwd ggid rest ; do						#regel per regel inlezen uit /etc/group
    echo -n "$groep ($ggid):"							#-n : no newline
    accounts=( $(egrep "^([^:]*:){3}$ggid:" /etc/passwd | cut -d : -f1 ) )	#output van cut na grep op /etc/passwd opslaan in array
    echo -n " ${accounts[@]}"
    echo
done 

#Het grep-commando hierin is niet waterdicht. Het volstaat immers dat de regel het groepsnummer, omgeven door dubbelepunten, op eender welke plaats bevat. Beter is dan ook een reguliere expressie:
#vandaar tweede mogelijkheid zoals hierboven ingevoegd
#egrep "^([^:]*:){3}$ggid:" /etc/passwd | cut -d : -f1
