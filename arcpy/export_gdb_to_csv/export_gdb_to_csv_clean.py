import arcpy
import csv

wd = "C:/GIS/project/" #<working directory>
table   = wd+"processing.gdb/table" #table or could be a feature class in a geodatabase
outfile = wd+"output.csv" #output csv file in the project directory

fields = arcpy.ListFields(table)
field_names = [field.name for field in fields]

with open(outfile,'wb') as f:
    w = csv.writer(f)
    w.writerow(field_names)
    for row in arcpy.SearchCursor(table):
        field_vals = [row.getValue(field.name) for field in fields]
        w.writerow(field_vals)
    del row
