#!/bin/bash
data=(0 1 2 3 4)
data[20]=20
echo "Fout: $data[1]"
echo "Juist: ${data[1]}"

echo Alle getallen: ${data[@]}
echo Aantal getallen: ${#data[@]}
echo Getal met index 2: ${data[2]}
echo Getal met index 5: ${data[5]}  
echo Getal met index 20: ${data[20]}

echo Getal op positie 2: ${data[@]:2:1}
echo Getal op positie 5: ${data[@]:5:1}
echo Getal op positie 20: ${data[@]:20:1}
echo Laatste getal: ${data[@]:${#data[@]}-1:1}  # of ${data[@]: -1:1}
