#!/bin/bash
#geen array maar tempfile

temp=$( mktemp XXXXXX )
exec 3> $temp
#sort -t : -k 4,4n /etc/passwd | cut -d : -f 4 >&3 			# /etc/passwd numeriek sorteren op 4e veld, dan 4e veld eruithalen
cut /etc/passwd -d : -f 4 | sort -n >&3 				# zelfde maar eenvoudiger
exec 3>&-

exec 3< $temp

while read -u3 gid ; do							# regel per regel gid inlezen vanuit $temp file, deze bevat aantal zelfde gids onder elkaar
    if [[ "$gid" == "$ogid" ]] ; then					# als gid gelijk is aan huidig beschouwde ogid, teller verhogen
        ((tel+=1))
    else    								#else: scenario waar gid verschillend is van laatst beschouwde ogid
        [[ -z "$ogid" ]] || echo "Groep $ogid bevat $tel gebruikers"	# als ogid geen lege string is, weten we dat we nu nieuwe serie van zelfde gid gaan bekijken en printen we teller van laatste ogid
        ogid=$gid							# we stellen nieuw beschouwde ogid in op de nieuw gedetecteerde gid
        tel=1								# met nieuwe teller
    fi
done 
# Verwerk laatste groep
echo "Groep $ogid bevat $tel gebruikers"
exec 3<&-
rm -f "$temp"
