#!/bin/bash
regel=($(wc /etc/passwd))
echo "regel[0]: ${regel[0]}"
echo "regel[1]: ${regel[1]}"
echo "regel[@]: ${regel[@]}"
declare -p regel
grep ^regel= < <(set)
