#!/bin/bash
exec 3< pagefile.out
while read -u3 -r p1 p2 p3 ; do			#-r optie interpreteert slashes niet als escape characters (anders wat onverwachte effecten met \\ in computernaam en path)
    [[ "$p1 $p2" == "Directory of" ]] && { 
	c=${p3:2}				#${variabele:offset}: deelstring vanaf positie offset
	c=${c%???}				#${variabele%pattern} verwijdert de kortst mogelijke substring achteraan de variabele die aan het pattern voldoet. Wij willen 3 laatste karakters verwijderen (\c$)
	}
    [[ "$p2 $p3" == "bytes free" ]]   && { 
	p1=${p1//./}				#${variabele//pattern/string} : alle substrings die voldoen aan pattern vervangen door string : hier alle punten wissen
	((p1 < 80000000)) && echo $c 		#indien kleiner dan 80 MB, echo de computernaam
	}
done 
exec 3<&-
