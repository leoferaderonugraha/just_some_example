#----------------------------------------
#Author : Leo Feradero Nugraha
#Date : 06-05-2016
#Email : leoferaderonugraha@yahoo.com
#File Name : Words2Binary.py
#----------------------------------------

#define
store = []
chars = []
cache = []
hasil = ""
words = raw_input("Masukkan kalimat : ")
#end-define

for i in words:
	char = ord(i)
	while char > 0:
		store.append(char%2)
		char /= 2
	store.append(' ')
	chars.append(i)
store.reverse()

for x in store:
	hasil += str(x)
for i in range(len(hasil), -1, -1):
	j = hasil.split(" ")
	try:
		cache.append(j[i])
	except:
		pass
	
for i in range(0,100,1):
	try:
		if(chars[i] == ' '):
			print str(cache[i]) + ' = ' + '[spasi]'
		else:
			print str(cache[i]) + ' = ' + chars[i]
	except:
		pass