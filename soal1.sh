#!/bin/bash

cd ~/Downloads
unzip nature.zip
cd ~/Downloads/nature 

for foto in *
do
	base64 -d "$foto" | xxd -r > "$foto""sementara"
	rm "$foto"
	mv "$foto""sementara" "$foto"
done

cd ..
zip -r nature.zip nature
