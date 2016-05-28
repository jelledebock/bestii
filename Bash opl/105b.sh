#!/bin/bash
(( $# == 2 )) || { echo "Gebruik: $0 bestandsnaam tag" >&2 ; exit 1 ; }
[[ -f "$1" ]] || { echo "$1 is geen bestand" >&2 ; exit 1 ; }

while read lijn ; do					#filteren op alle regels alles waar <tag voorkomt en dit doorgeven aan een while lus + read
    lijn=$(echo $lijn | egrep -o "<$2[ >].*</$2>")	#enkel overhouden wat begint met <tag , gevolgd door ofwel spatie ofwel > (om html attributen mee te nemen), en eindigt op </tag>
    lijn=${lijn/*<$2>/""}				#alles vooraan van <tag xxxx> vervangen door lege string, lukt niet bij attributen met *<$2*> want expressie zoekt langste string, wat zal zijn: <tag       /tag> !
    woord=${lijn/<\/$2*/""}				#alles achteraan vanaf </tag vervangen door lege string
    echo $woord
done < <(egrep "<$2" "$1")| sort | uniq


