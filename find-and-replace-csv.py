import csv, sys, traceback, time, datetime

#This script scrolls through every line of a csv and does a little find and replace action

listToFix = ["SID334_GPS_Set2_10Apr13.csv"]

for i in listToFix:
	#-----------------------
	# Update thse variables
	orig_csv    = "SID334_GPS_Set2_10Apr13.csv"
	outp_csv    = "SID334_GPS_Set2_10Apr13_v2.csv"

	find_text   = "013/"
	replactxt   = "2013/"
	#-----------------------

	print 'Replace CSV text started at this time: ' + time.strftime('%c') 

	fin = csv.reader(open(orig_csv, 'rb'), delimiter=',')
	fout = open(outp_csv, 'w')

	for row in fin:
		for item in row:
			str_row = item     
			fout.write(str_row.replace(find_text, replactxt ))
			fout.write(",")
		fout.write("\n")

	fout.close()