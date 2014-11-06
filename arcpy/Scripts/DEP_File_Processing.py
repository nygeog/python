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
outname = "C:\\Users\\dms2203\\Dropbox\\GIS\\Projects\\DOH\\gps\\scripts\\02_processingDEP_Out01.csv"
outfile = open(outname, 'w')
outfile.write("Ping,Date,Time,Latitude,Longitude,Depth,cDepth,Type,E0,E1,E2,E1_,Sediment,FD,File\n")
for fileStr in os.listdir(indir):
    if fileStr[-4:] == ".csv":
        f = open(indir + os.sep + fileStr, 'r')
        data = f.readlines()
        f.close()
        data1 = data[1:]
        for line in data1:
            line1 = line.replace("SHIT", "")
            line2 = line1.strip("\n")
            if line2.endswith(","):
                line3 = line2 + fileStr + "\n"
            else:
                line3 = line2 + "," + fileStr + "\n"
            outfile.write(line3)
outfile.close