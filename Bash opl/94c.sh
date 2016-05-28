#!/bin/bash
# (Traditionele) array rechtstreeks indexeren

unset c										# c wordt onze array waar we niet-actieve computers opslaan
declare -A c									# c als associatieve array declareren
actief=0									# actief is een teller
exec 3< ping.out
while read -u3 p1 p2 p3 ; do							# eerste 3 woorden van elke regel inlezen
    [[ "$p1" == "Pinging" ]] && { (( actief++ )) ; t=$p2 ; c[$t]="" ; }		# indien "Pinging": teller verhogen en voor index computernaam nemen en value een lege string
    [[ "$p1 $p2" == "Reply from" ]] && unset c[$t]				# indien een "Reply" volgt, verwijder waarde met index die computernaam
done 										## m.o. daarom moest je computernaam wel in aparte var t opslaan in vorig lijntje, want je krijgt die niet bij reply

exec 3<&-

printf "%s\n" ${!c[@]} | sort							#${!c[@]}: alle indexes van array c

printf "\nAantal computers  :% 5d\n" $actief
printf   "Aantal niet actief:% 5d\n" ${#c[@]}

