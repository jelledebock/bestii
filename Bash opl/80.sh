#!/bin/bash
x='dit is een <b>eenvoudige</b> en <b>nuttige</b> oefening'

#met Bash v1
temp=${x%%</*} 			#verwijdert de langst mogelijke substring achteraan de variabele die aan het pattern </* voldoet
vet1=${temp#*>}			#verwijdert de kortst mogelijke substring vooraan de variabele die aan het pattern *> voldoet
rest=${x##*$vet1}		#verwijdert de langst mogelijke substring vooraan de variabele die aan het pattern *eenvoudige voldoet
temp=${rest%</*}		#verwijdert de kortst mogelijke substring achteraan de variabele die aan het pattern </* voldoet
vet2=${temp##*>}		#verwijdert de langst mogelijke substring vooraan de variabele die aan het pattern *> voldoet
echo "$vet1 *** $vet2"

#vanaf Bash v2
temp=${x/<\/b>*/""}		#geeft de string die ontstaat als je in de variabele de eerste en langste substring die aan pattern </b> voldoet, vervangt door string "".
vet1=${temp/*<b>/""}		#geeft de string die ontstaat als je in de variabele de eerste en langste substring die aan pattern *<b> voldoet, vervangt door string "".
temp=${x/*<b>/""}		
vet2=${temp/<\/b>*/""}
echo "$vet1 *** $vet2"
