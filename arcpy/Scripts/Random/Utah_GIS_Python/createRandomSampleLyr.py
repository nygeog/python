# Name:  createRandomSampleLyr.py
# Author: Kevin Bell SLC UT DOT
# Date:  20080822
# Purpose: this is an ArcToolbox tool to build a random subset of
#             a feature class, the user determines the sample size

'''---------------------------------------------------------------------------------------------------------------------------------------------
right click a toolbox and hit add new script, name it and
point to this file on disk. Once it shows up in the toolbox,
right click the new script tool and hit Properties.
Fill in the following parameters

Toolbox parameters:
Display Name                  Data Type         Type          Direction   Multivalue

Feature Class to Sample   Feature Class    Required     input        no
Sample Size                    String                Required     input        no
outLyr                              Layer                 Derived       output      no
-------------------------------------------------------------------------------------------------------------------------------------------------'''


import sys, os, random
import arcgisscripting

gp = arcgisscripting.create(9.3)
gp.overwriteoutput = 1

fc = gp.GetParameterAsText(0)
sampleSize = int(gp.GetParameterAsText(1))
gp.workspace = os.path.dirname(fc)

fcname = os.path.splitext(os.path.basename(fc))
fcname = fcname[0]

dsc = gp.describe(fc)
rows = gp.SearchCursor(fc)
row = rows.Next()
l = []
oidField = dsc.OIDFieldname
while row:
    if oidField == "OBJECTID":
        l.append(row.OBJECTID)
        row = rows.Next()
    elif oidField == "FID":
        l.append(row.FID)
        row = rows.Next()

#get a "random" sample and reformat as whereclause
sample = random.sample(l, sampleSize)
s = str(sample)
s = s.replace("[", "(")
s = s.replace("]", ")")
whereclause = oidField + " IN " + s
print whereclause

subsetLyrName = "subsetOf_" + fcname + ".lyr"
subsetLyr = "subsetOf_" + fcname

gp.MakeFeatureLayer_management (fc, subsetLyr, whereclause)
gp.SaveToLayerFile_management (subsetLyr, subsetLyrName)

print "made a subset of " + str(sampleSize) + " features from " + fc
print "your new subset lyr is in " + str(gp.workspace)
gp.AddMessage("\n made a subset of " + str(sampleSize) + " features from " + fc + "\n")
gp.AddMessage("your new subset lyr is in " + str(gp.workspace) + "\n")

gp.SetParameterAsText(2, subsetLyrName)