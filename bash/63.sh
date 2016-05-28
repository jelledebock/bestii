#!/bin/bash

exec 3< passwd.sample
read -u3 a b c d
exec 3<&-

