#  Calculate Zonal Statistics for Overlapping Zones
# ---------------------------------------------------------------------------
# Import system modules

import sys, string, os, gc, shutil
import arcpy
from arcpy import env
from arcpy.sa import *
#enable garbage collection
gc.enable()

# Get the system TEMP variable value
# 
tempDIR = arcpy.GetSystemEnvironment("TEMP")
#create scratch workspace name
tempWorkspace = "tempWorkspaceForStats"

if not arcpy.Exists(tempDIR + os.sep + tempWorkspace):
    arcpy.CreateFolder_management(tempDIR, tempWorkspace)
    
arcpy.env.workspace = tempDIR + os.sep + tempWorkspace

# Check out any necessary licenses
arcpy.CheckOutExtension("Spatial")

# Set geoprocessor object property to overwrite existing output, by default
arcpy.env.overwriteOutput = True

# Local variables...
inputFeatureZone = arcpy.GetParameterAsText(0)
joinField = arcpy.GetParameterAsText(1)
valueRaster = arcpy.GetParameterAsText(2)
joinedFC = arcpy.GetParameterAsText(3)

#Loop through features
inRows = arcpy.SearchCursor(inputFeatureZone)
inRow = inRows.next()

#input variables
strFID = '"FID" ='
zone = "zone"

cellAssign = "CELL_CENTER"
priority = "NONE"
newSelection = "NEW_SELECTION"

# Make a layer from the feature class
arcpy.MakeFeatureLayer_management(inputFeatureZone, zone) 

while inRow:
    #selct the fid to process
    arcpy.SelectLayerByAttribute_management(zone, newSelection, strFID + str(inRow.FID))
   
    #create a unique name for the zone
    uniqueZone = arcpy.CreateUniqueName("zone.shp", arcpy.env.workspace)
    uniqueTable = arcpy.CreateUniqueName("ZSasT", arcpy.env.workspace)
    #create a temporary feature to use for zonal stats as table
    arcpy.CopyFeatures_management(zone, uniqueZone)
    outZSaT = ZonalStatisticsAsTable(uniqueZone, joinField, valueRaster, uniqueTable, "NODATA", "ALL")

    #move to next record.
    inRow = inRows.next()

#Clear the last selection.
arcpy.SelectLayerByAttribute_management(zone, "CLEAR_SELECTION")
#merge the tables so the can be joined to the zone feature class
mergedTable = arcpy.CreateUniqueName("merge.dbf", arcpy.env.workspace)
tableList = arcpy.ListTables()
fullPathTableList = []
for table in tableList:
    fullPathTableList.append(arcpy.Describe(table).catalogPath)
    
arcpy.Merge_management(fullPathTableList, mergedTable)

#join them
arcpy.AddJoin_management(zone, joinField, mergedTable, joinField)
#save the joined data as a new feature
arcpy.CopyFeatures_management(zone, joinedFC)

# clean up old output features
arcpy.Delete_management(tempDIR + os.sep + tempWorkspace)

print "Process Complete"

#free memory
del inRow, tableList, zone

