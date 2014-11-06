import arcpy, time, datetime, csv, sys, traceback
from arcpy import env
env.overwriteOutput = True

"C:/output/output.gdb"
in_rows  = "D:/GIS/Data/Commercial/NETS/_from_tanya/nets.csv"
out_path = "D:/GIS/Data/Commercial/NETS/nets.gdb"
out_name = "nets"

print 'Script 02_import_csv.py to gdb started at this time: ' + time.strftime('%c') 

try:
	arcpy.TableToTable_conversion(in_rows, out_path, out_name)

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
