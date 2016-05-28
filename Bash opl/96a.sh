#!/bin/bash

exec 3< /etc/group
while IFS=$'\n': read -u3 groep passwd ggid rest ; do						#regel per regel inlezen uit /etc/group
    echo -n "$groep ($ggid):"							#-n : no newline

    #grep ":$ggid:" /etc/passwd | while read account passwd uid gid rest ; do	#zoek via extra while loop overal waar gid voorkomt in /etc/passwd, maar toon enkel die waar gid value ook echt de gid voorstelt (en vb geen user id)
    #    (( ggid == gid )) && echo -n " $account"

    egrep "^([^:]*:){3}$ggid:" /etc/passwd | cut -d : -f1 | while read account; do  #met egrep direct enkel filteren op effectieve gid
    echo -n " $account"
    
    done
    echo
done 
exec 3<&-

#Het grep-commando hierin is niet waterdicht. Het volstaat immers dat de regel het groepsnummer, omgeven door dubbelepunten, op eender welke plaats bevat. Beter is dan ook een reguliere expressie:
#vandaar tweede mogelijkheid zoals hierboven ingevoegd
#egrep "^([^:]*:){3}$ggid:" /etc/passwd | cut -d : -f1
