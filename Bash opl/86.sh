#!/bin/bash
data=(a b c d e)
data[20]=z
echo data: ${data[@]}
echo indices: ${!data[@]}
indices=(${!data[@]})
echo indices in een array: ${indices[@]}
echo
echo BASH_VERSINFO: ${BASH_VERSINFO[@]}
echo BASH_VERSINFO indices: ${!BASH_VERSINFO[@]}
