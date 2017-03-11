#!/usr/bin/env python
'''TypeWriter is an cool effect, Created by rion'''

from __future__ import print_function
from time import sleep
from random import randint as rand
import sys

if(len(sys.argv) != 2):
	print("Usage <%s> <filename>" % sys.argv[0], end='\n')
	sys.exit()
fp = open(sys.argv[1], 'r').read()
for i in fp:
	print(i, end='')
	sleep(rand(0,1)/10.)
	sys.stdout.flush()
sleep(0.3)
