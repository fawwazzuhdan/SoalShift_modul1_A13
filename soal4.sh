#!/bin/bash

nama=$(date '+%H:%M %d-%m-%Y')
id=$(date '+%H')

besar=ABCDEFGHIJKLMNOPQRSTUVWXYZ
kecil=abcdefghijklmnopqrstuvwxyz

awk '{a[$0]} END{for (i in a) print i}' /var/log/syslog | tr "$besar$kecil" "${besar:id}${besar:0:id}${kecil:id}${kecil:0:id}" > ~/SISOP/modul1/"$nama".txt