#!/bin/bash

exec 3< stud.txt

while IFS=: read -u3 nr fullnaam post groep gemeente geboren klas ; do
    voornaam=${fullnaam/ */""}			#in fullnaam alles inclusief en na de spatie vervangen door lege string om voornaam te bekomen (zoekt langste string dus inclusief 'van der' of dergelijke
    naam=${fullnaam/$voornaam /""}		#in fullnaam de voornaam en de spatie vervangen door lege string om familienaam te bekomen
    while : ; do				#oneindige lus om telkens onderstaande mogelijkheden te blijven zoeken
        case $naam in
            [vV]an\ *)
                naam=${naam/[vV]an /""} 	#"van"-varianten weglaten uit familienaam
                ;;
            [Dd]e[rn]\ *)
                naam=${naam/[Dd]e[rn] /""}	#"der/den"-varianten weglaten uit familienaam
                ;;
            [Dd]e\ *)
                naam=${naam/[Dd]e /""}		#"de"-varianten weglaten uit familienaam
                ;; 
            *)
                break				#oneindige while-lus stoppen eens niets van bovenstaande meer gevonden is
                ;;
        esac     
    done
    login=${voornaam:0:1}${naam:0:1}${nr:2:6}	#login maken door met stringoperator karakters te selecteren van bepaalde lengte op bepaalde offset in een variabele
    echo $login 
done

exec 3<&-
