
import csv, time, datetime



fin = csv.reader(open("E:/SpiderOak/projects/nets/all/geocoding_beta/geosupport/GBATOut_test_1A.csv", 'rb'), delimiter=',')
fout = open("E:/SpiderOak/projects/nets/all/geocoding_beta/geosupport/GBATOut_test_1A_replace.csv", 'w')

print 'Replace Geosupport header CSV started at this time: ' + time.strftime('%c') 

for row in fin:
  for item in row:
		str_row = item     
		fout.write(str_row.replace('geosupport_test.csv_',''))
		fout.write(",")
	fout.write("\n")

fout.close()

print "finished..."
print 'Replace Geosupport header CSV ended at this time: ' + time.strftime('%c') 

fin = csv.reader(open("E:/SpiderOak/projects/nets/all/geocoding_beta/geosupport/GBATOut_test_1E.csv", 'rb'), delimiter=',')
fout = open("E:/SpiderOak/projects/nets/all/geocoding_beta/geosupport/GBATOut_test_1E_replace.csv", 'w')

print 'Replace Geosupport header CSV started at this time: ' + time.strftime('%c') 

for row in fin:
	for item in row:
		str_row = item     
		fout.write(str_row.replace('geosupport_test.csv_',''))
		fout.write(",")
	fout.write("\n")

fout.close()

print "finished..."
print 'Replace Geosupport header CSV ended at this time: ' + time.strftime('%c') 
