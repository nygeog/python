import urllib2
import json
import csv

url = "http://www.yahoo.com/something"
data = urllib2.urlopen(url).read()
data = json.loads(data)

fname = "mydata.csv"
with open(fname,'wb') as outf:
    outcsv = csv.writer(outf)
    outcsv.writerows(getRows(data))