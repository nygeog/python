import arcpy
import csv

wd = 'V:/GIS/projects/nets/tasks/201410_nets_animation/data/input/'

inTable   = wd+"nets.gdb/by_year/nets_modhealthy_1990"
outGDB    = wd+"nets.gdb/"
countRecords = int(arcpy.GetCount_management(table).getOutput(0))

splitCount   = 1000 #this is the number of records you want in each csv. Keep this in decimal (float) format

for i in range(0 ,countRecords, splitCount):
	j = str(i + splitCount)
	i = str(i)
	splitFC = outGDB + "select_"+i+'_to_'+j

	exp = '"OBJECTID" >' + i +' AND "OBJECTID" <=' + j
	arcpy.Select_analysis(inTable,wd+splitFC,exp)

	table = wd+splitFC

	outfile = wd+"output"+i+'_to_'+j+".csv" #output csv file in the project directory

	fields = arcpy.ListFields(table)
	field_names = [field.name for field in fields]

	with open(outfile,'wb') as f:
	    w = csv.writer(f)
	    w.writerow(field_names)
	    for row in arcpy.SearchCursor(table):
	        field_vals = [row.getValue(field.name) for field in fields]
	        w.writerow(field_vals)
	    del row
