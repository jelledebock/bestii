#!/bin/bash
#met array
tel=0
exec 3< /etc/passwd
while IFS=: read -u3 account passwd uid gid rest ; do
    (( tot[gid]+=1 ))							# we gebruiken een array met indices de gid's en values het aantal gebruikers
done 
exec 3<&-

gids=( ${!tot[@]} )							# alle indices (gid's) die in gebruik zijn steken we in een array
									# of via for-lus: zie oef 106

while (( i < ${#gids[@]} )) ; do					# voor al die relevante gid's printen we info
    echo "Groep ${gids[i]} bevat ${tot[${gids[i]}]} gebruikers"
    (( i++ ))
done
