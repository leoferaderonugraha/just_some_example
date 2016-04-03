#----------------------------------------
#Author		: Leo Feradero Nugraha
#Date		: 02-04-2016
#Email		: leoferaderonugraha@yahoo.com
#File Name	: Photoshop_Detector.py
#----------------------------------------


from os import system
filename = raw_input("Filename : ")
ext = filename[-3:].lower()
if ext == "png" or ext == "jpg" or ext == "jpe" or ext == "jpeg" or ext == "gif" or ext == "bmp" or ext == "rle" or ext =="dib":
	fp = open(filename, 'rb')
	data = fp.readlines()
	warn = 0
	for i in data:
		if "Photoshop" in i:
			system("msg * Photoshop detected!!!")
			warn += 1
	if not warn:
		system("msg * Photoshop not detected...")
else:
	system("msg * Extension not valid!!!")