#!/bin/bash
dagen=( zondag maandag dinsdag woensdag donderdag vrijdag zaterdag )
echo ${dagen[$1]}

#met als parameter $(date '+%w')
