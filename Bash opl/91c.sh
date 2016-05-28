#!/bin/bash
(( $# == 1 )) || { echo Gebruik: $0 gebruikers-id >&2 ; exit 1 ; }

#met read
IFS=: read naam rest < <(grep -E "^([^:]*:){2}$1:" /etc/passwd)  
	#regex "^([^:]*:){2}$1:" betekent: begin van lijn (^), gevolgd door een willekeurig aantal karakter verschillend van dubbele punt ( [^:]*) gevolgd door dubbele punt : en dit tweemaal ( (....){2} ), gevolgd door het argument van dit script $1, gevolgd door dubbele punt
	#op die manier heb je dus de eerste twee velden, gevolgd door je gebruikers-id en dubbele punt

[[ -n "$naam" ]] || { echo "$1 is geen gebruikers-ID" ; exit 1 ; } #controleren of $naam leeg is of niet
echo $naam
