#!/bin/bash

cd ~/Downloads

negara=$(awk -F ',' '{ if ($7 == 2012) {a[$1] += $10}} END{for (i in a) print i}' WA_Sales_Products_2012-14.csv | sort -rV | head -n 1)


#a.
echo $negara
tes=$(echo $negara)

#b.
awk -F ',' '{ if ($7 == 2012 && $1 == $tes) {a[$4] += $10}} END{for (i in a) print i}' WA_Sales_Products_2012-14.csv | sort -rV | head -n 3

#c
awk -F ',' '{ if ($7 == 2012 && $1 == $tes) {a[$6] += $10}} END{for (i in a) print i}' WA_Sales_Products_2012-14.csv | sort -rV | head -n 3