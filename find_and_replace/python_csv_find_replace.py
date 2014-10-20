import csv, sys, traceback, time, datetime

#This script scrolls through every line of a csv and does a little find and replace action

#-----------------------
# Update thse variables
orig_csv    = "path_and_name.csv"
outp_csv    = "path_and_name_replace.csv"

find_text   = "some_text"
replactxt   = "new_text"
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

print 'Replace CSV text ended at this time: ' + time.strftime('%c') 

#leave next line commented out if in ArcGIS, uncomment if in python.exe
#raw_input("Congrats! Processing has been completed effectively. Press any key to exit") 