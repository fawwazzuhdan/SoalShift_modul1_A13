#!/bin/bash

cd ~/Downloads
# wget "https://drive.google.com/uc?export=download&confirm=xRQo&id=1Rl1ddBeb2EnAY8hnEwb7vLJZYvZ3mkQc" -O nature.zip
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
# rm -rf  nature