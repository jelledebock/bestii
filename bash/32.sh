du /etc/ 3>&2 2>&1 1>&3 >/dev/null | wc -l
du /etc/ 3>&1 > /dev/null 2>&3 | wc -l
