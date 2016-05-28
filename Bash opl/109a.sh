#!/bin/bash
(( $# == 2 )) || { echo "Gebruik: $0 bestandsnaam tag" >&2 ; exit 1 ; }
[[ -f "$1" ]] || { echo "$1 is geen bestand" >&2 ; exit 1 ; }

while read lijn ; do					#filteren op alle regels alles waar <tag voorkomt en dit doorgeven aan een while lus + read
    lijn=$(echo $lijn | egrep -o "<$2[ >].*</$2>")	#enkel overhouden wat begint met <tag , gevolgd door ofwel spatie ofwel > (om html attributen mee te nemen), en eindigt op </tag>
    while [[ $lijn == *"</$2>"* ]] ; do    
      lijn=${lijn#*<$2*>}		  		#lijn aanpassen door alles wegknippen vooraan van <tag xxxx>
      woord=${lijn%%</$2*}				#om woord te bekomen: alles wegknippen achteraan vanaf </tag
      echo $woord
      lijn=${lijn#*</$2>}				#lijn aanpassen om tem de eerste </tag> weg te knippen
    done
done < <(egrep "<$2" "$1") | sort | uniq 


