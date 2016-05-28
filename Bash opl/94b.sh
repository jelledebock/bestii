#!/bin/bash
# (Traditionele) array als stapel gebruiken (trager)

unset c										# c wordt onze array waar we niet-actieve computers opslaan
actief=0									# actief is de index

exec 3< ping.out

while read -u3 p1 p2 p3 ; do							# eerste 3 woorden van elke regel inlezen
    [[ "$p1" == "Pinging" ]] && { (( actief++ )) ; c=( $p2 ${c[@]} ) ; } 	## bij "Pinging": computernaam toevoegen aan array als eerste element door nieuwe c te maken met dit element en de reeds aanwezige elementen in c
    [[ "$p1 $p2" == "Reply from" ]] && unset c[0]				# als een "Reply from" volgt, dan eerste element uit de array verwijderen
done 

exec 3<&-

echo ${c[@]} | xargs -n 1 | sort 
#alternatief met printf 
#printf "%s\n" ${c[@]} | sort

# alle element in c geordend printen (de niet-actieve computers)

printf "\nAantal computers  :% 5d\n" $actief
printf   "Aantal niet actief:% 5d\n" ${#c[@]}

