#!/bin/bash
data=(0 1 2 3 4)
data[20]=20
echo Alle getallen: ${data[@]}
echo Aantal getallen: ${#data[@]}
echo Getal met index 2: ${data[2]}
echo Getal met index 5: ${data[5]}  
echo Getal met index 20: ${data[20]}

