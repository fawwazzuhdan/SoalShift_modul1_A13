# SoalShift_modul1_A13
  - [Nomor 1](#nomor-1)
  - [Nomor 2](#nomor-2)
    - [a.](#a)
    - [b.](#b)
    - [c.](#c)
  - [Nomor 3](#nomor-3)
  - [Nomor 4](#nomor-4)
  - [Nomor 5](#nomor-5)

## Nomor 1
**Soal**

Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah
dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah
nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh
file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.
Hint: Base64, Hexdump

**Jawaban :**

Pertama-tama atur konfigurasi crontab terlebih dahulu. Untuk mengatur konfigurasi crontrab. bisa mengetikkan command ``` crontab -e``` di terminal. Kemudian tambahkan isi file dari [soal1.txt](soal1.txt) ke konfigurasi crontab tersebut. Isi dari file soal1.txt adalah
```
14 14 14 2 5 /bin/bash ~/SISOP/SoalShift_modul1_A13/soal1.sh
```
Baris diatas untuk menjalankan script ```/bin/bash ~/SISOP/SoalShift_modul1_A13/soal1.sh``` setiap jam 14:14 pada tanggal 14 februari atau atau hari tersebut adalah hari jumat pada bulan Februari. Setelah mengatur konfigurasi crontab download file nature.zip di google drive terlebih dahulu setelah itu di-ekstrak menggunakan syntax ```unzip nature.zip```. Isi dari script [soal1.sh](soal1.sh) adalah
```
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
```
Syntax dibawah ini digunakan untuk  melakukan looping disetiap file yang berada di direktori tersebut. Untuk setiap nama file tersimpan di variabel *foto*
```
for foto in *
do
	...
done
```
Syntax ```base64 -d "$foto"``` digunakan untuk meng-decode file yang memiliki bervariabel *foto*. Syntax ```xxd -r > "$foto""sementara"``` untuk me-reverse hasil dari decode yang tadi agar bisa menjadi file yang bernama seperti nama file sebelum di-decode dengan tambahan nama "sementara".

Syntax dibawah ini digunakan untuk merubah file lama dengan file yang baru dengan nama yang sama
```
rm "$foto"
mv "$foto""sementara" "$foto"
```
Setelah semua file ter-dekripsi, *archive* semua file tersebut

## Nomor 2
**Soal**

Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta
untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv.
Laporan yang diminta berupa:

a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun
2012.
b. Tentukan tiga product line yang memberikan penjualan(quantity)
terbanyak pada soal poin a.
c. Tentukan tiga product yang memberikan penjualan(quantity)
terbanyak berdasarkan tiga product line yang didapatkan pada soal
poin b.

**Jawaban :**

Jalankan script [soal2.sh](soal2.sh) dengan menngetikkan command ```/bin/bash ~/SISOP/modul1/SoalShift_modul1_A13.soal2.sh```. Isi dari script tersebut adalah
```
#!/bin/bash

cd ~/Downloads

negara=$((awk -F ',' '{ if ($7 == 2012) {a[$1] += $10}} END{for (i in a) print a[i] "," i}' WA_Sales_Products_2012-14.csv | sort -nr | head -n 1) | awk -F ',' '{print $2}')

#a.
echo "Jawaban 2.a"
echo $negara
echo -e "\n"

#b.
echo "Jawaban 2.b"
produk=$(awk -F ',' -v negara="$negara" '{ if (($7 == 2012) && ($1~negara)) {a[$4] += $10}} END{for (i in a) print a[i] "," i ","}' WA_Sales_Products_2012-14.csv | sort -nr | head -n 3 | awk -F ',' '{print $2 $4 $6}')

awk -F ',' -v negara="$negara" '{ if (($7 == 2012) && ($1~negara)) {a[$4] += $10}} END{for (i in a) print a[i] "," i ","}' WA_Sales_Products_2012-14.csv | sort -nr | head -n 3 | awk -F ',' '{print $2 $4 $6}'
 

produk1=$(echo $produk | awk -F ',' '{print $1}')
produk2=$(echo $produk | awk -F ',' '{print $2}')
produk3=$(echo $produk | awk -F ',' '{print $3}')

echo -e "\n"
#c
echo "Jawaban 2.c"
awk -F ',' -v negara="$negara" -v produk1="$produk1" -v produk2="$produk2" -v produk3="$produk3" '{ if (($7 == 2012) && ($1~negara) && (($4~produk1) || ($4~produk2) || ($4~produk3))) {a[$6] += $10}} END{for (i in a) print a[i] "," i ","}' WA_Sales_Products_2012-14.csv | sort -nr | head -n 3 | awk -F ',' '{print $2 $4 $6}'
```
### a.
Fungsi dari syntax dibawah ini adalah untuk mendapatkan nama negara yang memiliki total penjualan(quantity) terbanyak pada tahun 2012
```
negara=$((awk -F ',' '{ if ($7 == 2012) {a[$1] += $10}} END{for (i in a) print a[i] "," i}' WA_Sales_Products_2012-14.csv | sort -nr | head -n 1) | awk -F ',' '{print $2}')
```
Syntax ```if ($7 == 2012) {a[$1] += $10}``` untuk menjumlahkan penjualan(quantity) tiap negara pada tahun 2012. Syntax ```for (i in a) print a[i] "," i ","``` untuk mencetak total penjualan(quantity) per negara dan seluruh negara yang memenuhi sayrat sebelumnya. Syntax ```sort -nr``` untuk mengurutkan semua negara berdasarkan angka (total penjualan(quantity)) dari tertinggi ke rendah. Syntax ```head -n 1``` untuk mencetak baris sebanyak 1 baris dari atas. Setelah itu ambil nama negaranya dengan syntax ```awk -F ',' '{print $2}'```.
### b.
Hampir sama dengan poin a, adanya tambahan syarat sesuai poin a yaitu syarat negaranya harus jawaban dari poin a. 
```
awk -F ',' -v negara="$negara" '{ if (($7 == 2012) && ($1~negara)) {a[$4] += $10}} END{for (i in a) print a[i] "," i ","}' WA_Sales_Products_2012-14.csv | sort -nr | head -n 3 | awk -F ',' '{print $2 $4 $6}'
```
Syntax ```-v negara="$negara"``` digunakan untuk memasukkan variabel ke dalam comman awk. Syntax ```print a[i] "," i ","``` berfungsi untuk menjadikan koma(",") sebagai *field separator* agar bisa digunakan untuk poin c.Karena hasilnya satu baris maka tiap kolom dipisahkan dengan koma(","). Kemudian diurutkan yang memiliki total penjualan(quantity) dari terbesar ke terkecil menggunakan syntax ```sort -nr```. Setelah itu diambil 3 baris dari atas menggunakan syntax ```head -n 3```. Kemudian cetak semua produk menggunakan syntax ```awk -F ',' '{print $2 $4 $6}'```.

Syntax dibawah ini untuk mendapatkan *product_line* tiap kolom kemudian disimpan dalam variabel
```
produk1=$(echo $produk | awk -F ',' '{print $1}')
produk2=$(echo $produk | awk -F ',' '{print $2}')
produk3=$(echo $produk | awk -F ',' '{print $3}')
```

### c.
Hampir sama dengan poin b, adanya tambahan syarat sesuai poin b yaitu syarat *product line* harus berdasarkan yang didapatkan dari poin b
```
awk -F ',' -v negara="$negara" -v produk1="$produk1" -v produk2="$produk2" -v produk3="$produk3" '{ if (($7 == 2012) && ($1~negara) && (($4~produk1) || ($4~produk2) || ($4~produk3))) {a[$6] += $10}} END{for (i in a) print a[i] "," i ","}' WA_Sales_Products_2012-14.csv | sort -nr | head -n 3 | awk -F ',' '{print $2 $4 $6}'
```
Penjelasan hampir sama dengan poin b, adanya tambahan variabel yang didapatkan dari poin b agar memenuhi syarat yang diinginkan.

## Nomor 3
**Soal**

Buatlah sebuah script bash yang dapat menghasilkan password secara acak
sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password
acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama
sebagai berikut:

a. Jika tidak ditemukan file password1.txt maka password acak tersebut
disimpan pada file bernama password1.txt
b. Jika file password1.txt sudah ada maka password acak baru akan
disimpan pada file bernama password2.txt dan begitu seterusnya.
c. Urutan nama file tidak boleh ada yang terlewatkan meski filenya
dihapus.
d. Password yang dihasilkan tidak boleh sama.

**Jawaban :**

Jalankan script [soal3.sh](soal3.sh) dengan menngetikkan command ```/bin/bash ~/SISOP/modul1/SoalShift_modul1_A13.soal3.sh```. Isi dari script tersebut adalah
```
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
	for file in password*
	do
		out=$(grep -f sementara.txt $file)	
		if [[ $out ]]; then
			fungsi_random
			break
		fi
	done
done

cat sementara.txt > "password""$j".txt
rm sementara.txt
```
Fungsi dibawah ini digunakan untuk mendapatkan password secara random yang terdiri dari 12 karakter
```
fungsi_random() {
	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 12 > sementara.txt
}
```
Syntak dibawah ini digunakan untuk mengecek apakah file yang mengandung nama "password" dan diikuti dengan angka secara berurutan ada apa tidak. Jika tidak ada maka akan mendapatkan angka untuk penamaan file tersebut.
```
j=1

for file1 in password*
do
	if [[ $file1 == "password""$j".txt ]]; then
		j=$((j + 1))
	else
		break
	fi
done
```
Penjelasan syntax dibawah ini yaitu pertama-tama menjalankan fungsi ```fungsi_random``` terlebih dahulu. Kemudian mengecek disetiap file yang memiliki nama password diikuti dengan angka. Jika ditemukan password yang sama, maka akan menjalankan fungsi ```fungsi_random``` lagi. Jika tidak ditemukan sama sekali maka password tersebut disimpan di file yang bernama password dan diikuti dengan angka yang diperoleh dari syntax sebelumnya.
```
fungsi_random
out='a'
while [[ $out ]]
do
	for file in password*
	do
		out=$(grep -f sementara.txt $file)	
		if [[ $out ]]; then
			fungsi_random
			break
		fi
	done
done

cat sementara.txt > "password""$j".txt
rm sementara.txt
```


## Nomor 4
**Soal**

Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-
bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string
manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai
berikut:

a. Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan
pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki
urutan ke 12+2 = 14.
b. Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke
empat belas, dan seterusnya.
c. setelah huruf z akan kembali ke huruf a
d. Backup file syslog setiap jam.
e. dan buatkan juga bash script untuk dekripsinya.

**Jawaban :**

**backup & enkripsi**

Pertama-tama atur konfigurasi crontab terlebih dahulu. Untuk mengatur konfigurasi crontrab. bisa mengetikkan command crontab -e di terminal. Kemudian tambahkan isi file dari soal4.txt ke konfigurasi crontab tersebut. Isi dari file soal4.txt adalah
```
0 * * * * /bin/bash ~/SISOP/modul1/SoalShift_modul1_A13/soal4.sh
```
Isi dari script [soal4.sh](soal4.sh) adalah
```
#!/bin/bash

nama=$(date '+%H:%M %d-%m-%Y')
id=$(date '+%H')

besar=ABCDEFGHIJKLMNOPQRSTUVWXYZ
kecil=abcdefghijklmnopqrstuvwxyz

awk '{a[$0]} END{for (i in a) print i}' /var/log/syslog | tr "$besar$kecil" "${besar:id}${besar:0:id}${kecil:id}${kecil:0:id}" > ~/SISOP/modul1/"$nama".txt
```
Syntax ```nama=$(date '+%H:%M %d-%m-%Y')``` untuk mendapatkan waktu ketika script berjalan agar digunakan untuk penamaan file. Syntax ```id=$(date '+%H')``` untuk mendapatkan jam agar digunakan menjadi *cipher key*. Hasil dari enkripsi tersebut disimpan di file dengan nama yang telah didapatkan sebelumnya.

**dekripsi**

Menjalankan script [soal4_dekripsi.sh](soal4_dekripsi.sh). Isi dari script tersebut adalah
```
#!/bin/bash

besar=ABCDEFGHIJKLMNOPQRSTUVWXYZ
kecil=abcdefghijklmnopqrstuvwxyz

kata=$(echo $1 | awk -F ':' '{print $1}')

cd ~/SISOP/modul1

cat "$1" | tr "${besar:kata}${besar:0:kata}${kecil:kata}${kecil:0:kata}" "$besar$kecil" > ~/SISOP/modul1/"$1"_dekripsi.txt
```
Ambil jam pada nama file yang ingin didekripsi menggunakan command ```echo $1``` dengan argumen nama filenya setelah itu menggunakan syntax ```awk -F ':' '{print $1}'``` agar digunakan sebagai *cipher key* . Kemudian dekripsi menggukan script [soal4_dekripsi.sh](soal4_dekripsi.sh). Kemudian simpan hasil tersebut dalam file txt dengan nama file tersebut.


## Nomor 5
**Soal**

Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi
kriteria berikut:

a. Tidak mengandung string “sudo”, tetapi mengandung string “cron”,
serta buatlah pencarian stringnya tidak bersifat case sensitive,
sehingga huruf kapital atau tidak, tidak menjadi masalah.
b. Jumlah field (number of field) pada baris tersebut berjumlah kurang
dari 13.
c. Masukkan record tadi ke dalam file logs yang berada pada direktori
/home/[user]/modul1.

d. Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh
13:02, 13:08, 13:14, dst.

**Jawaban :**

Pertama-tama atur konfigurasi crontab terlebih dahulu. Untuk mengatur konfigurasi crontrab. bisa mengetikkan command ``` crontab -e``` di terminal. Kemudian tambahkan isi file dari [soal5.txt](soal5.txt) ke konfigurasi crontab tersebut. Isi dari file soal5.txt adalah
```
2-30/6 * * * * /bin/bash ~/SISOP/modul1/SoalShift_modul1_A13/soal5.sh
```
```2-30``` menyatakan untuk range dari menitnya, sedangkan ```/6``` menyatakan untuk setiap 6 menit. Jadi, setiap 6 menit yang dimulai dari menit 2 sampai menit 30 akan menjalankan ```/bin/bash ~/SISOP/modul1/SoalShift_modul1_A13/soal5.sh```

Isi dari script [soal5.sh](soal5.sh) adalah
```
#!/bin/bash

cd ~/SISOP/modul1/SoalShift_modul1_A13

awk 'BEGIN{IGNORECASE=1} (!/sudo/ && (/cron/ || /CRON/) ) { if (NF < 13) print $0}' /var/log/syslog > ~/SISOP/modul1/logs.txt
```
Syntax ```BEGIN{IGNORECASE=1}``` berfungsi agar tidak terjadi sensitive case. Syntanx ```!/sudo/ && (/cron/ || /CRON/)``` berfungsi untung mengambil baris yg mengandung kata ***CRON*** tetapi tidang mengandung kata ***sudo*** Syntax ```if (NF < 13) print $0}``` berfungsi untuk mencetak suatu baris yang memiliki *number of field* kurang dari 13. Setelah mendapatkan baris dari file ```/var/log/syslog``` yang memenuhi syarat, kemudian akan disimpan di file yang memiliki *fullpath* ```~/SISOP/modul1/logs.txt```
