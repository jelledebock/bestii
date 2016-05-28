#!/bin/bash
# (Traditionele) array rechtstreeks indexeren
unset c										# c wordt onze array waar we niet-actieve computers opslaan
actief=0									# actief is de index
exec 3< ping.out

while read -u3 p1 p2 p3 ; do							# eerste 3 woorden van elke regel inlezen
    [[ "$p1" == "Pinging" ]] && { (( actief++ )) ; c[$actief]=$p2 ; }		# indien eerste woord "Pinging" is, dan index verhogen en computernaam opslaan in array bij die index
    [[ "$p1 $p2" == "Reply from" ]] && { unset c[$actief] ; }			# als een "Reply from" volgt, dan voor laatste index het element uit de array verwijderen
done 

exec 3<&-

for i in ${c[@]} ; do echo $i ; done | sort					# alle element in c geordend printen (de niet-actieve computers)
# Deze for-lus kan vermeden worden met:
#     echo ${c[@]} | xargs -n 1 | sort
# of nog:
#     printf "%s\n" ${c[@]} | sort

printf "\nAantal computers  :% 5d\n" $actief
printf   "Aantal niet actief:% 5d\n" ${#c[@]}
