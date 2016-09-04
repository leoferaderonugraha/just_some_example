#----------------------------------------
#Author		: Leo Feradero Nugraha
#Date		: 02-04-2016
#Email		: leoferaderonugraha@yahoo.com
#File Name	: TypeWrite_Effect.py
#----------------------------------------
from random import randint
from time import sleep

words = raw_input("Type a word(s) : ")
print
for i in range(len(words)):
	sleep(randint(1,2))
	print words[i]
print
raw_input("Press enter to continue... ")
