#!/bin/bash

besar=ABCDEFGHIJKLMNOPQRSTUVWXYZ
kecil=abcdefghijklmnopqrstuvwxyz
cd ~/SISOP/modul1
kata=$(echo $1 | awk -F ':' '{print $1}')
# echo $kata
cat "$1" | tr "${besar:kata}${besar:0:kata}${kecil:kata}${kecil:0:kata}" "$besar$kecil" > ~/SISOP/modul1/"$1"_dekripsi.txt