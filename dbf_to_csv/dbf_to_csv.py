import csv
from dbfpy import dbf
import os
import sys
import glob


g = "gr0250m"

tabFold = '/Volumes/Hotel/naas/tasks/201411_grid/data/processing/zonal_stats/'+g+'/'

exp = g+"*.dbf"
all_dbfs = glob.glob(tabFold+exp)

for i in all_dbfs:


    filename = i
    if filename.endswith('.dbf'):
        print "Converting %s to csv" % filename
        csv_fn = filename[:-4]+ ".csv"
        with open(csv_fn,'wb') as csvfile:
            in_db = dbf.Dbf(filename)
            out_csv = csv.writer(csvfile)
            names = []
            for field in in_db.header.fields:
                names.append(field.name)
            out_csv.writerow(names)
            for rec in in_db:
                out_csv.writerow(rec.fieldData)
            in_db.close()
            print "Done..."
    else:
      print "Filename does not end with .dbf"