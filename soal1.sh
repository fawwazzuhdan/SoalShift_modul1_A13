#!/bin/bash

cd ~/Downloads
wget "https://doc-0o-ac-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/qisl67kasogvjuho0aju8aepd7qrcnhi/1550476800000/07028514913725966899/*/1Rl1ddBeb2EnAY8hnEwb7vLJZYvZ3mkQc?e=download" -O nature.zip
unzip nature.zip

for foto in ~/Downloads/nature/*
do
	base64 -d "$foto" | xxd -r > "$foto""sementara"
	rm "$foto"
	mv "$foto""sementara" "$foto"
done

zip -r nature.zip nature