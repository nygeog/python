#------------------------------------------------------------------
# makeZones.py
#   Find zonal statistics as a table in a features class that
#   has overlapping polygons.
#   Author: Sue Clark, 8/20/2012
#   Parameters:
#     inFeatures = polygon feature class with overlapping polygons
#     zoneField = polygon identification field
#     valueRaster = Raster containing values for statistics
#     workspace = Output workspace
#     zoneName = A string containing the name of the output table
#     numDivides = number of divisions of inFeatures 
#   Modifications:
#       8/31/2012 Added a parameter to divide the feature class up
#       into 1-10 pieces prior to calling makeZones
#
#       9/5/2012 Added code to copy the input features to a scratch
#       database.
#------------------------------------------------------------------

import arcpy
import os
from arcpy import env
from arcpy.sa import *

# Set the environmental variable to overwrite output
env.overwriteOutput = True
#
# makeZones
#    Given a polygon feature layer divide the features up
#    into feature sets with non-overlapping polygons and
#    run zonal statistics  on the feature layer
#    Inputs:
#       inFeatures - A polygon feature layer
#       numIter - number of iterations through the  routine
#       zoneField - The identifier for the polygons
#       valueRaster - The raster containing values for analysis
#    Note:  The routine does recurse.
#
def makeZones(inFeatures, numIter, zoneField, valueRaster, fname):
    
    global tlist
    
    jName = "j"
    jLayer = "joinLayer"
    zName = os.path.join(env.scratchWorkspace,"z")
    zLayer = "zLayer"
    oName = "o"
    zTbl = os.path.join(env.workspace,"zTbl")
    olayer = "olayer"

    # Spatially join the features to themselves to see which
    # features intersect
    joinName = jName + str(numIter)
    jFeat = os.path.join(env.scratchWorkspace,joinName)

    arcpy.AddMessage ("Iteration %d, Spatial Join" % (numIter))
    arcpy.SpatialJoin_analysis(inFeatures, inFeatures, jFeat)

    # Make a layer for the spatial join file, jFeat
    arcpy.MakeFeatureLayer_management(jFeat, jLayer)

    # Join the ovelayed polygon field to the feature class
    arcpy.AddMessage ("Iteration %d, Join" % (numIter))
    arcpy.AddJoin_management (inFeatures, zoneField, jLayer, zoneField)

    # Select the fields where the the value of the
    # zoneField = the value of zoneField_1, this
    # set will not intersect other polygons
    selString = fname + "." + zoneField + " = " + joinName + "." + zoneField + "_1"
    arcpy.AddMessage("Select %s" % selString)
    arcpy.SelectLayerByAttribute_management(inFeatures, "NEW_SELECTION", selString)

    # Remove the join
    arcpy.AddMessage("Removing Join...")
    arcpy.RemoveJoin_management (inFeatures, joinName)
    arcpy.Delete_management(jFeat)

    # Save the selected fields in the zone file
    zfeat = zName + str(numIter)
    arcpy.CopyFeatures_management(inFeatures, zfeat)

    # Make a feature layer for zfeat
    arcpy.MakeFeatureLayer_management (zfeat, zLayer)

    # Run the zonal statistics
    arcpy.AddMessage ("Iteration %d, Zonal Statistics" % (numIter))
    tblName = zTbl + str(numIter)
    zOut = ZonalStatisticsAsTable(zLayer, zoneField, valueRaster, tblName, "DATA", "ALL")

    tlist.append(tblName)

    # Switch selections
    arcpy.SelectLayerByAttribute_management(inFeatures, "SWITCH_SELECTION")

    # Copy the selected fields in the overlap layer
    ovName = oName + str(numIter)
    ofeat = os.path.join(env.scratchWorkspace, ovName)
    arcpy.CopyFeatures_management(inFeatures, ofeat)

    # Make a feature layer
    arcpy.MakeFeatureLayer_management (ofeat, olayer)

    # Get a count of the number of records in the overlap layer
    rCount = int(arcpy.GetCount_management(olayer).getOutput(0))
    arcpy.AddMessage ("Iteration %d, %d polygons to go" % (numIter, rCount))

    # Increment the iterations variable
    numIter = numIter + 1

    # if the overlap count is greater than 1,
    # make zones with the overlap layer, i.e. recurse
    if (rCount > 1):
         makeZones(olayer, numIter, zoneField, valueRaster, ovName)
         arcpy.Delete_management(ofeat)

    # if the overlap count is 1
    # save the overlap layer to a zone file
    else:
        if rCount == 1:
            zfeat = zName + str(numIter)
            arcpy.CopyFeatures_management(olayer, zfeat)
            arcpy.Delete_management(ofeat)
            
            # Make a feature layer for zfeat
            arcpy.MakeFeatureLayer_management (zfeat, zLayer)


            # Get the zonal data for the last table
            tblName = zTbl + str(numIter)
            arcpy.AddMessage ("Final Iteration %d, Zonal Statistics" % (numIter))
            zOut = ZonalStatisticsAsTable(zLayer, zoneField, valueRaster, tblName, "DATA", "ALL")
            tlist.append(tblName)
    return tlist            
#--------------------Main--------------------------------------

# Variables
inFeat = arcpy.GetParameterAsText(0)
zoneField = arcpy.GetParameterAsText(1)
valueRaster = arcpy.GetParameterAsText(2)
workspace = arcpy.GetParameterAsText(3)
zoneName = arcpy.GetParameterAsText(4)
numDivides = int(arcpy.GetParameter(5))

# Set the environmental variable to overwrite output
env.overwriteOutput = True

env.workspace = workspace

# Create the zone table output path
zoneTbl = os.path.join(workspace, zoneName)

# Make a scratch workspace
# Create a unique name for the scratch output.
scratchName = arcpy.CreateUniqueName("Scratch.mdb", workspace)

# Get the foldername from the scratchName (entire path)
scratchFldr = os.path.split(scratchName)[1]

# Create the folder.
arcpy.CreatePersonalGDB_management(workspace, scratchFldr)

# Set the scratch workspace to the environment variable workspace
env.scratchWorkspace = workspace + os.sep + scratchFldr

# Create a temporary file for the features
inFeatures = os.path.join(env.scratchWorkspace, inFeat)

# Copy the input features to a feature class
arcpy.CopyFeatures_management(inFeat, inFeatures)

# Add a field for numDivides
fCount = "fCount"
arcpy.AddField_management(inFeatures, fCount, "SHORT")

# Set the fCount field to the OBJECTID % numDivides
# This will give the records a fCount between 0 and
# numDivides
expr = "!OBJECTID! % " + str(numDivides)
arcpy.CalculateField_management(inFeatures, fCount, expr, "PYTHON")

# Create an empty table
tblList = []

# Get the path for the inFeatures
desc = arcpy.Describe(inFeatures)
fPath = desc.path

for i in range(0,numDivides):

    # Make a layer from inFeatures
    featlayer = "feat_lyr"
    arcpy.MakeFeatureLayer_management (inFeatures, featlayer)

    # Select the i numbered records
    newName = arcpy.AddFieldDelimiters(fPath, fCount)
    selString = newName + " = " + str(i)
    arcpy.AddMessage("Selecting the %s..." % (selString))
    arcpy.SelectLayerByAttribute_management(featlayer, "NEW_SELECTION", selString)

    # Make a layer from the selection
    selLayer = "selLayer"
    arcpy.MakeFeatureLayer_management (featlayer, selLayer)

    arcpy.AddMessage("Feature layer number %d of %d" %(i + 1, numDivides))

    arcpy.CheckOutExtension("Spatial")

    # Initialize the tlist
    tlist = []

    tlist = makeZones(selLayer, 1, zoneField, valueRaster, inFeat)

    arcpy.CheckInExtension("Spatial")

    # Merge the tables
    arcpy.AddMessage("Merging tables for feature layer %d of %d" % (i + 1, numDivides))
    iterTbl = os.path.join(env.scratchWorkspace, "iterTbl" + str(i))
    arcpy.Merge_management(tlist, iterTbl)

    # Join this iterations tables together
    tblList.append(iterTbl)

# Merge the interation tables
arcpy.AddMessage("Final merge of zonal statistic tables...")
arcpy.Merge_management(tblList, zoneTbl)

