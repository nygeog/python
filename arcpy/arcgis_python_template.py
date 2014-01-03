# ---------------------------------------------------------------------------
# Created on: 
# Description: 
# This program was created/modified by Daniel M. Sheehan at the Built 
# Environment and Health Project (beh.columbia.edu) of Department of Epidemiology at Columbia University
# Contact Info: dms2203@columbia.edu 
# Project Info: ___________________
# -----------------------------------------------------------------------------------------------------------------

import arcpy, time, datetime, csv, sys, traceback
from arcpy import env
env.overwriteOutput = True

# Check out any necessary licenses
#from arcpy.sa import *
#arcpy.CheckOutExtension("Network")
#arcpy.CheckOutExtension("Spatial")

# -----------------------------------------------------------------------------------------------------------------
# VARIABLES
# -----------------------------------------------------------------------------------------------------------------

# Local variables:
p = "p"
sl = "/"

path = "D:\\GIS\\Projects\\DOH\\gps\\data\\processing\\home_buffers\\neighborhoods_crashes\\"
mascluster = []

print 'Script ______________________ started at this time: ' + time.strftime('%c') 

try:
	for cluster in mascluster:

		ReadList = []
		reader = csv.reader(open("C:/Users/dms2203/Dropbox/GIS/Projects/DOH/gps/scripts/list/list"+cluster+".txt"))
		for row in reader:
			PartReadList.extend(row)

		partlist = ReadList
		for participant in partlist:
			
			glist = []
			for geog in glist:

				
				try:	

					# -----------------------------------------------------------------------------------------------------------------
					# PUT CODE HERE
					# -----------------------------------------------------------------------------------------------------------------


					print " is done for ________________"+' at this time: ' + time.strftime('%c') 

				except:

					print "feature in loop doesn't exist at all or at this time: " + time.strftime('%c') 

# -----------------------------------------------------------------------------------------------------------------
# ERROR HANDLING
# -----------------------------------------------------------------------------------------------------------------
				
except arcpy.ExecuteError: 
    # Get the tool error messages 
    msgs = arcpy.GetMessages(2) 

    # Return tool error messages for use with a script tool 
    arcpy.AddError(msgs) 

    # Print tool error messages for use in Python/PythonWin 
    print msgs

except:
    # Get the traceback object
    tb = sys.exc_info()[2]
    tbinfo = traceback.format_tb(tb)[0]

    # Concatenate information together concerning the error into a message string
    pymsg = "PYTHON ERRORS:\nTraceback info:\n" + tbinfo + "\nError Info:\n" + str(sys.exc_info()[1])
    msgs = "ArcPy ERRORS:\n" + arcpy.GetMessages(2) + "\n"

    # Return python error messages for use in script tool or Python Window
    arcpy.AddError(pymsg)
    arcpy.AddError(msgs)

    # Print Python error messages for use in Python / Python Window
    print pymsg + "\n"
    print msgs

print 'Script ended at this time: ' + time.strftime('%c') 
raw_input("Congrats! Processing has been completed effectively. Press any key to exit") 
