#!/bin/bash

cd ~/Downloads

negara=$(awk -F ',' '{ if ($7 == 2012) {a[$1] += $10}} END{for (i in a) print i}' WA_Sales_Products_2012-14.csv | sort -rV | head -n 1)

#a.
echo "Jawaban 2.a"
echo $negara
echo -e "\n"

#b.
echo "Jawaban 2.b"
produk=$(awk -F ',' -v negara="$negara" '{ if (($7 == 2012) && ($1~negara)) {a[$4] += $10}} END{for (i in a) print i ","}' WA_Sales_Products_2012-14.csv | sort -rV | head -n 3)
echo $produk | awk -F ',' '{print $1 $2 $3}' 

produk1=$(echo $produk | awk -F ',' '{print $1}')
produk2=$(echo $produk | awk -F ',' '{print $2}')
produk3=$(echo $produk | awk -F ',' '{print $3}')

echo -e "\n"
#c
echo "Jawaban 2.c"
awk -F ',' -v negara="$negara" -v produk1="$produk1" -v produk2="$produk2" -v produk3="$produk3" '{ if (($7 == 2012) && ($1~negara) && (($4~produk1) || ($4~produk2) || ($4~produk3))) {a[$6] += $10}} END{for (i in a) print i}' WA_Sales_Products_2012-14.csv | sort -rV | head -n 3