#!/bin/bash
unset tel_lijnen     # Aantal regels tellen? als boolean gebruiken 0/1
unset tel_woorden    # Aantal woorden tellen? als boolean gebruiken 0/1
unset tel_karakters  # Aantal karakters tellen? als boolean gebruiken 0/1
totaal_lijnen=0
totaal_woorden=0
totaal_karakters=0

while : ; do									# Verwerk en verwijder opties, typisch met een case en een oneindige while + break
    case $1 in
        -c)
            tel_karakters=1
            shift								# optie -c verwijderen uit argumenten
            ;;
        -l)
            tel_lijnen=1
            shift								# optie -l verwijderen uit argumenten
            ;;
        -w)
            tel_woorden=1
            shift								# optie -w verwijderen uit argumenten
            ;;
        -*)
            echo "Gebruik: $0 [-c][-l][-w] [bestand|directory ...]" >&2		# Foutmelding bij optie -x wanneer dit geen -c, -l of -w is
            exit 1
            ;;
        *)
            break  								# Beëindig lus bij eerste niet-optie
            ;;
    esac
done

if [[ -z "$tel_lijnen" && -z "$tel_woorden" && -z "$tel_karakters" ]] ; then 	#indien geen opties meegegeven, dan wordt alles uitgevoerd
    tel_lijnen=1
    tel_woorden=1
    tel_karakters=1
fi

TMP=$( mktemp XXXXXX )  							# Tijdelijk bestand voor uitvoer wc
exec 3> $TMP
for parm in "${@:-.}" ; do							# ${variable:-value} indien $@ leeg is (na wissen opties) of ongedefinieerd (niets meegegeven als argument), dan wordt als argumenten '.' genomen (de huidige werkdirectory)
    [[ -f "$parm" ]] && bestanden=$parm						# indien argument een file is, dan beschouwen we die file

    # Invullen met namen van alle bestanden in directory tree
    [[ -d "$parm" ]] && bestanden=$( find "$parm" -type f )			# indien argument een directory is, dan beschouwen we alle files in die directory

    [[ -n "$bestanden" ]] && wc $bestanden 2>/dev/null | grep -v " total$" >&3  # TMP bestand aanvullen met uitvoer van wc voor bestanden
										# Enkel uitvoeren indien minstens één bestand
										# Indien meerdere bestanden verschijnt ook "total", dus verwijder dit
done
exec 3>&-
exec 3< $TMP
										# Haal interessante kolommen uit TMP en bereken totalen
while read -u3 lijnen woorden karakters bestandsnaam ; do
    [[ "$tel_lijnen" ]]    && { (( totaal_lijnen += lijnen ))       ; printf "% 10d" $lijnen ; }
    [[ "$tel_woorden" ]]   && { (( totaal_woorden += woorden ))     ; printf "% 10d" $woorden ; }
    [[ "$tel_karakters" ]] && { (( totaal_karakters += karakters )) ; printf "% 10d" $karakters ; }
    echo "    $bestandsnaam"
done 

exec 3<&-

										# Druk totalen af
[[ "$tel_lijnen" ]]    && printf "% 10d" $totaal_lijnen
[[ "$tel_woorden" ]]   && printf "% 10d" $totaal_woorden
[[ "$tel_karakters" ]] && printf "% 10d" $totaal_karakters
echo "    total"

rm -f $TMP
