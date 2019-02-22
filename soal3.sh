#!/bin/bash

cd ~/SISOP/modul1/SoalShift_modul1_A13

fungsi_random() {
	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 12 > sementara.txt
}

j=1

for file1 in password*
do
	if [[ $file1 == "password""$j".txt ]]; then
		j=$((j + 1))
	else
		break
	fi
done

fungsi_random
out='a'
while [[ $out ]]
do
	for file in sementara*
	do
		out=$(grep -f sementara1.txt $file)	
		if [[ $out ]]; then
			fungsi_random
			break
		fi
	done
done

cat sementara.txt > "password""$j".txt
rm sementara.txt