##""********************************************************************************************************************
##TOOL NAME: DEP_File_Processing.py
##SOURCE NAME: DEP_File_Processing.py
##VERSION: 
##AUTHOR: Matthew Starry, SRA International, Inc.
##DATE: 08/07/2012
##REQUIRED ARGUMENTS: Input directory, Output csv file name
##OPTIONAL ARGUMENTS: 
##TOOL DESCRIPTION: Formats & appends data from csv files - adds filenames
##*********************************************************************************************************************"""
import os, string
indir = "C:\\Users\\dms2203\\Dropbox\\GIS\\Projects\\DOH\\gps\\scripts\\02_processing"

for fileStr in os.listdir(indir):
    #if fileStr[-3:] == ".py":
    f = open(indir + os.sep + fileStr, 'w')
    data = f.readlines()
    f.close()
    data1 = data[0:]
    for line in data1:
        line1 = line.replace("MACARONI", "CHEESE")
        outname = "a"+fileStr
        outfile = open(outname, 'w')
        outfile.write(line1)

        #line2 = line1.strip("\n")
        #if line2.endswith(","):
        #    line3 = line2 + fileStr + "\n"
        #else:
        #    line3 = line2 + "," + fileStr + "\n"
        #outfile.write(line1)
outfile.close