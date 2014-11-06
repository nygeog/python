# Given an input layer, return an output *.lyr layer file containing a random
# selection of features.
#
# Original author: Leah Saunders, ESRI Inc, on Arcscripts.com. July 2007
# Major modification by Stephen Lead, 21st Feb 2008

import os, sys, random, arcgisscripting
try:
    gp = arcgisscripting.create()
    gp.overwriteoutput = 1

    # Specify input featureclass, output *.lyr file and the percentage of
    # random points to return. Set these parameters in ArcToolbox as shown.
    inputFC = sys.argv[1] # Feature Class or Feature Layer
    outputLyr = sys.argv[2] # Layer File
    inpct = sys.argv[3] # Long

    # Ensure that the input percentage is between 1 and 100%
    inpct = min(int(inpct),100)
    inpct = max(int(inpct),1)

    # Work out how many features to select
    inputDirname = os.path.dirname(inputFC)
    inputBasename = os.path.basename(inputFC)

    gp.workspace = inputDirname
    desc = gp.describe(inputFC)
    totpnts = gp.getcount(inputFC)
    numValues = int(round(totpnts * float(inpct) / 100.0))
    gp.addmessage("Selecting " + str(numValues) + " random features")

    # Generate a list of all features, and select randomly from this
    inList = []
    randomList = []
    fldname = desc.OIDFieldName
    rows = gp.SearchCursor(inputFC)
    row = rows.next()
    gp.addmessage ("Loading all IDs into a list")
    while row:
        id = row.GetValue(fldname)
        inList.append(id)
        row = rows.next()

    selpnts = 0
    gp.addmessage("Creating the list of randomly selected features")
    while len(randomList) < numValues:
        selpnts += 1
        selItem = random.choice(inList)
        randomList.append(selItem)
        inList.remove(selItem)

    # Select features whose OID value occurs in the random list, generate
    # a *.lyr file from this selection. (Leading and trailing [ and ] marks
    # need to be removed from the list object)
    theLen = len(str(randomList))
    sqlexp = '"' + fldname + '"' + " in " + "(" + str(randomList)[1:theLen - 1] + ")"
    selectionLyr = inputBasename + " selection"
    gp.MakeFeatureLayer_management(inputFC, selectionLyr, sqlexp)
    gp.SaveToLayerFile_management(selectionLyr, outputLyr)

    gp.addmessage("\nOutput layer " + outputLyr + " contains features randomly selected from " + inputBasename + "\n")
except:
    gp.adderror("Error running script. Try specifying the full path to the input layer")

# END OF FILE
