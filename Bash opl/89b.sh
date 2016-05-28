#!/bin/bash
(( $# == 1 )) || { echo Gebruik: "$0" bestandsnaam >&2 ; exit 1 ; }
[[ -f "$1" ]] || { echo "$1" is geen bestand >&2 ; exit 1 ; }

#gebruik van array
x=($(wc "$1")) 
l=${x[0]}
w=${x[1]}
c=${x[2]}
naam=${x[3]}
#correcte afronding ipv naar beneden afronden bij deling
#er wordt steeds naar beneden afgerond. Als we bij een willekeurig getal eerst 0,5 optellen en dit vervolgens naar beneden afronden, dan krijgen we het gewenste resultaat. Als we echter gewoon $(( c/L + 1/2 )) zouden schrijven, zou de gehele deling eenvoudigweg nul geven. Door deze som vooraf om te vormen, vinden we echter: c/L + 1/2 = (c*2+L)/(L*2) = (c + L / 2)/L
(( c += l / 2 ))
(( w += l / 2 ))
echo "$naam" $(( c / l )) $(( w / l ))
