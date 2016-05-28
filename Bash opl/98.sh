#!/bin/bash
(( $# > 1 ))  || { echo Gebruik: $0 bestandsnaam string1 ... >&2 ; exit 1 ; }
[[ -f "$1" ]] || { echo "$1" is geen bestand >&2 ; exit 1 ; }
[[ -r "$1" ]] || { echo "$1" is niet leesbaar voor de gebruiker >&2 ; exit 1 ; }

f=$1
shift  							# De parameterlijst bevat nu enkel nog de te vinden strings
for s ; do						# for s zonder woordenlijst kijkt naar de $@ lijst, dus alle overgebleven parameters
    grep -E "$s" "$f" > /dev/null && echo "$s"
done
