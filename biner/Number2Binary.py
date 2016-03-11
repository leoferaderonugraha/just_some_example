#----------------------------------------
#Author : Leo Feradero Nugraha
#Date : 06-05-2016
#Email : leoferaderonugraha@yahoo.com
#File Name : Number2Binary.py
#----------------------------------------

#define
store = []
numb = raw_input("Masukkan Angka : ")
hasil = "Biner : "
#end-define

angka1 = int(numb)
if(angka1 < 0):
	print "Angka Harus Positif"
elif(angka1 == 0):
	print hasil + "0"
else:
	while angka1 > 0:
		store.append(angka1%2)
		angka1 /= 2
	store.reverse()
	for i in store:
		hasil += str(i)
	print hasil
