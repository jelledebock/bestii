#!/bin/bash

tel=0
exec 3< /etc/passwd 
while IFS=: read -u3  account passwd uid gid rest ; do		#regels van /etc/passwd inlezen
    (( tot[gid]++ ))					#frequentietabel opstellen per gid
done

for gid in ${!tot[@]} ; do				#alle indices overlopen van de array
    echo "Groep $gid bevat ${tot[gid]} gebruikers"
done
exec 3<&-
