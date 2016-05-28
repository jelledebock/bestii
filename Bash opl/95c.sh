#!/bin/bash
#geen array, geen tempfile, maar gebruik van tijdelijke string

s=""
#s=$(sort -t : -k 4,4n /etc/passwd | cut -d : -f 4) 			# /etc/passwd numeriek sorteren op 4e veld, dan 4e veld eruithalen
s=$(cut /etc/passwd -d : -f 4 | sort -n)				# zelfde maar eenvoudiger

while read gid ; do							# regel per regel gid inlezen vanuit $s string, deze bevat aantal zelfde gids onder elkaar
    if [[ "$gid" == "$ogid" ]] ; then					# als gid gelijk is aan huidig beschouwde ogid, teller verhogen
        ((tel+=1))
    else    								#else: scenario waar gid verschillend is van laatst beschouwde ogid
        [[ -z "$ogid" ]] || echo "Groep $ogid bevat $tel gebruikers"	# als ogid geen lege string is, weten we dat we nu nieuwe serie van zelfde gid gaan bekijken en printen we teller van laatste ogid
        ogid=$gid							# we stellen nieuw beschouwde ogid in op de nieuw gedetecteerde gid
        tel=1								# met nieuwe teller
    fi
done <<< "$s"								#m.o.: "$s" met dubbele quotes en niet $s opdat de newlines in $s niet vervangen worden door spaties (want newlines opgenomen in IFS) 
# Verwerk laatste groep
echo "Groep $ogid bevat $tel gebruikers"

