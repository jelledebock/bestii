#!/bin/bash

#opdracht 101

if [ $# -gt 0 ]; then
    total_lines=0
    for i in ${@:-*}; do
        lines=0
        exec 3< $i
        while read -u3 ; do
            ((lines+=1))
        done
        exec 3<&-
        echo "$i: $lines lines"
        ((total_lines+=lines))
    done
    echo "Total number of lines: $total_lines"
fi
