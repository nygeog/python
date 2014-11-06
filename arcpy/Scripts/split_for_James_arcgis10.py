## --------------------------------------------------------------------------------
## Description:  Split a large input feature class into a number of subset pieces.
##
## Author:  Marc Peterson
## Date:  8/24/2007
## Software:  ArcGIS 9.2 and Python 2.4.1
## --------------------------------------------------------------------------------

# Set up the geoprocessor
import arcpy
from arcpy import env
env.overwriteOutput = True

# Import common Python modules
import os, sys, string, math

inFCtoSplit = r"D:\gis\projects\chicago\dhl\geographies\batch"
inFCtoSplit = r"D:\gis\projects\chicago\dhl\geographies\batch\dhl.shp"
batchCount = 15
outFCdir = r"D:\gis\projects\chicago\dhl\geographies\batch"

if not os.path.isdir(outFCdir):
    try:
        os.mkdir(outFCdir)
    except:
        print "Output directory could not be created."
        sys.exit(1)

try:
    # Initialize the batch counter
    batch = 1

    # Get the ID Field Name (usually "FID")
    OIDname = arcpy.Describe(inFCtoSplit).OIDFieldName

    # Get the full list of IDs
    scur = arcpy.SearchCursor(inFCtoSplit)
    row = scur.next()
    IDlist = []
    while row:
        IDlist.append(row.getValue(OIDname))
        row = scur.next()

    # Calculate the number of features to go in each batch
    batchSize = math.ceil(int(float(len(IDlist))/(batchCount-1)))

    # Do the batches
    while (batch-1)*batchSize < len(IDlist):

        # Calculate the portion of the IDlist for this batch
        first = int((batch-1)*batchSize)
        last = int(batch*batchSize)
        if last > len(IDlist):
            last = len(IDlist)
        subsetIDlist = IDlist[first:last]

        # Make a feature layer based on the selection
        where_clause = OIDname + " in (" + str(subsetIDlist)[1:-1] + ")"
        arcpy.MakeFeatureLayer_management (inFCtoSplit, "SplitLayer", where_clause)

        # Write this selection to a new FC
        outName = os.path.splitext(os.path.basename(inFCtoSplit))[0] + "_" + str(batch)
        arcpy.CopyFeatures_management ("SplitLayer", os.path.join(outFCdir, outName))

        batch = batch+1

except:
    print arcpy.GetMessages()
    raise
