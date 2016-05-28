#!/bin/bash
if (( $# == 0 )) ; then					#indien geen argumenten, dan lijst van commando's weergeven
    while read pid tty time command ; do		#elke outputregel van ps -e doorgeven aan read
        echo $command
    done < <(ps -e) | sort | uniq
else
    for command in "$@" ; do
        while read pid rest ; do			#elke outputregel van ps -e eerst met grep filteren en dan doorgeven aan read
            echo kill -KILL $pid  			# Laat 'echo' weg om uit te voeren
        done < <(ps -e | grep "$command")
    done
fi
