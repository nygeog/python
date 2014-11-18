import re, urllib, os 

inTXT = open("list_of_ny_counties.txt")

countyList = []

for row in inTXT:
	r = row[16:28]
	countyList.append(r)
