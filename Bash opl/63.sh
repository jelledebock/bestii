#!/bin/bash

exec 3< /etc/passwd
read -u3 a b c d
exec 3<&-
