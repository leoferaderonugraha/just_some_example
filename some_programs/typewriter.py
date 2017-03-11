#!/usr/bin/env python

from __future__ import print_function
from time import sleep
from random import randint as rand
import sys

txt = "TypeWriter is an amazing effect,\n Created by rion :)\n"
for i in txt:
	print(i, end='')
	sleep(rand(0,1)/10.)
	sys.stdout.flush()
