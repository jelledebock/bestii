#!/bin/bash

echo "Laatste: ${@:$#:1}"  #van $@ (alle positionele parameters) vertrek je van offset $# (index van laatste pos par) en neem je 1 pos par

echo "Voorlaatste: ${@:$#-1:1}"
echo "Twee laatste: ${@:$#-1:2}"
echo "Andere manier voorlaatste: ${@: -2:1}"  # Spatie niet vergeten! . Betekent: van $@ (alle positionele parameters) vertrek je van offset -2 (index van voorlaatste pos par) en neem je 1 pos par
echo "Foute manier voorlaatste: ${@:-2:1}"  # verklaring zie hieronder
echo "Foute manier voorlaatste verduidelijking: ${onbestaandevar:-2:1}"  # zonder spatie heb je ${var:-value} wat betekent "gebruik $variabele; indien niet gedefinieerd of leeg, gebruik waarde"

