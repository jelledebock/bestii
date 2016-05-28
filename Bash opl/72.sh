#!/bin/bash
echo Dit script heet $0 en heeft ID $$
echo Er werden $# argumenten opgegeven
echo Eerste argument: $1
echo Laatste argument: ${!#}
# Alternatief
shift $(($#-1))
echo Laatste argument: $1
