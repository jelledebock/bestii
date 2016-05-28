#!/bin/bash

x="/usr/share/emacs/24.5/etc/tutorials/TUTORIAL.nl"

printf "directory=%s bestandsnaam=%s\n" ${x%/*} ${x##*/}


