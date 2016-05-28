#!/bin/bash
een=hallo
twee=een
echo '${een}:' ${een}
echo '${twee}:' ${twee}
echo '${!twee}:' ${!twee}
echo '${$twee}:' ${$twee}

eval $twee=7 #dit stopt de waarde 7 in de variabele "een"