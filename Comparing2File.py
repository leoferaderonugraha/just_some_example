#----------------------------------------
#Author		: Leo Feradero Nugraha
#Date		: 02-04-2016
#Email		: leoferaderonugraha@yahoo.com
#File Name	: Comparing2File.py
#----------------------------------------

first = raw_input("First file: ")
second = raw_input("Second file: ")

if first and second:
	fp1 = open(first, 'rb')
	fp2 = open(second, 'rb')
	tmp1 = fp1.readlines()
	tmp2 = fp2.readlines()
	x = 0
	y = 0
	same = False
	for i in tmp1:
		x += 1
	for i in tmp2:
		y += 1
	if x >= y:
		for i in range(x):
			if tmp1[i] != tmp2[i]:
				a = "\nFile isn't same on line : " + str(i+1)
				b = "\n\nFirst file	: %s" % tmp1[i]
				c = "\nLength		: %d\n" % len(tmp1[i])
				d = "\nSecond file	: %s" % tmp2[i]
				e = "\nLength		: %d" % len(tmp2[i])
				if len(tmp1) > 50:
					b = "\n\nFirst file	: %s" % tmp1[i][:50] + "[-SNIPPED-]"
				if len(tmp2) > 50:
					d = "\b\nSecond file	: %s" % tmp2[i][:50] + "[-SNIPPED-]"
				print a,b,c,d,e
				same = False
				break
			else:
				same = True
	else:
		for i in range(y):
			if tmp1[i] != tmp2[i]:
				a = "\nFile isn't same on line : " + str(i+1)
				b = "\n\nFirst file	: %s" % tmp1[i]
				c = "\nLength		: %d\n" % len(tmp1[i])
				d = "\nSecond file	: %s" % tmp2[i]
				e = "\nLength		: %d" % len(tmp2[i])
				if len(tmp1) > 50:
					b = "\n\nFirst file	: %s" % tmp1[i][:50] + "[-SNIPPED-]"
				if len(tmp2) > 50:
					d = "\n\nSecond file	: %s" % tmp2[i][:50] + "[-SNIPPED-]"
				print a,b,c,d,e
				same = False
				break
			else:
				same = True
	if same:
		print "\nFile is same...\n"
	raw_input("Press enter to continue... ")
else:
	print "You must fill all filename!"
	raw_input("Press enter to continue... ")