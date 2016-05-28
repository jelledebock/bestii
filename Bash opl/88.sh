#!/bin/bash
declare -A dagnummer
#dagnummer[zondag]=0 ; dagnummer[maandag]=1 ; dagnummer[dinsdag]=2  # enz.
# Korter:
dagnummer=( [zondag]=0 [maandag]=1 [dinsdag]=2 [woensdag]=3 [donderdag]=4 [vrijdag]=5 [zaterdag]=6 )
echo dagnummer: ${dagnummer[@]}
echo dagnummer indices: ${!dagnummer[@]}
echo dagnummer van woensdag: ${dagnummer[woensdag]}
unset dagnummer[woensdag]
echo resterend aantal: ${#dagnummer[@]} 
echo ${!dagnummer[@]} | xargs -n 1

#een beter alternatief voor de laatste uitschrijfopdracht vind je hieronder!

printf "%s \n" ${!dagnummer[@]}
