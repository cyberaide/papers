#! /bin/env python

import csv

with open('keyword-cloud.txt', 'rb') as csvfile:
    linereader = csv.reader(csvfile, delimiter=',')
    for (count,words) in linereader:
        print int(count) * words
        # for c in range(1,int(count)):
        #   print words
