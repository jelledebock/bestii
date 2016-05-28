#!/bin/bash

printf "%s\n" "Voer drie waarden in, gescheiden door spatie, dubbelepunt of komma."
IFS=' :,' read a b c
printf "a = %s\nb = %s\nc = %s\n" $a $b $c

