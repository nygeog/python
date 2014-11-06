#SplitLayerByAttributes.py
'''
Author:
  Dan Patterson
  Dept of Geography and Environmental Studies
  Carleton University, Ottawa, Canada
  Dan_Patterson@carleton.ca

Date created June 23 2005
Modified     Jan  24 2010

Purpose:
  Converts each shape in a feature class to a separate shapefile

Properties (right-click on the tool and specify the following)
General
  Name   SplitLayerByAttributes
  Label  Split Layer By Attributes
  Desc   Splits a layer according to attributes within the selected field producing
         a separate shapefile for common attributes.

Source script SplitLayerByAttributes.py

Parameter list
                              Parameter Properties
          Display Name         Data type        Type      Direction  MultiValue
  argv[1]  Input feature class  Feature Layer    Required  Input      No
  argv[2]  Field to query       Field            Required  Input      No
  argv[3]  File basename        String           Optional  Input      No
  argv[4]  Output folder        Folder           Required  Input      No
'''
#--------------------------------------------------------------------
#Functions

def gp_create(vers=None):
  '''create the geoprocessor, 9.3, 9.2 or empty for win32com.client.Dispatch'''
  if vers >= 9.2:   #try 9.2 or above
    try:
      import arcgisscripting
      gp = arcgisscripting.create(vers)
      gp_version = vers
    except:
      import arcgisscripting
      gp = arcgisscripting.create()
      gp_version = 9.2
  else:
    try:
      import win32com.client
      gp = win32com.client.Dispatch("esriGeoprocessing.GpDispatch.1")
      gp_version = 9.1
    except:
      gp = None
      gp_version = 9.1
  #
  return [gp, gp_version]

def gp_toolboxes(toolboxes, gp):
  '''a list of toolboxes to add to the geoprocessor, gp'''
  tbx_home = os.environ['ARCGISHOME'].replace("\\","/") + \
             "ArcToolbox/Toolboxes/"
  msg = ""
  passed = True
  for a_tbx in toolboxes:
    try:
      tbx = tbx_home + a_tbx
      gp.AddToolbox(tbx)
      msg = msg + "\n  Adding toolbox: " + str(tbx)
    except:
      msg = msg + "\n  The toolbox:  " + str(tbx) + \
            "\n  could not be loaded.  Check your toolbox path " + \
            "\n  and availability, edit BoundingContainers.py to " + \
            "\n  reflect its location."
      passed = False
  return [gp, msg, passed]

#--------------------------------------------------------------------
#Import the standard modules and the geoprocessor
#
import os, sys, string  #common examples

gp, gp_version = gp_create(9.2)  #use 9.2 gp to permit enumerations

gp, msg, passed = gp_toolboxes(["Data Management Tools.tbx"], gp)

gp.AddMessage(msg)
if not passed:
  gp.AddMessage("\n  Exiting ..... \n")
  del gp
  sys.exit()
  
gp.OverWriteOutput = 1
#
#Get the input feature class, optional fields and the output filename
inFC = sys.argv[1]
inField = sys.argv[2]
theFName = sys.argv[3]
outFolder = sys.argv[4]
desc = gp.Describe
theType = desc(inFC).ShapeType
FullName = desc(inFC).CatalogPath
thePath = (os.path.split(FullName)[0]).replace("\\","/")
if theFName != "#":
  theFName = theFName.replace(" ","_")
else:
  theFName = (os.path.split(FullName)[1]).replace(".shp","")

outFolder = outFolder.replace("\\","/")

#Determine if the field is integer, decimal (0 scale) or string field

gp.AddMessage("\n  Checking for appropriate field type" \
              + "(  string, decimal (0 scale) or integer)")


theFields = gp.ListFields(inFC)
inType = ""
OIDField = desc(inFC).OIDFieldName
OKFields = [OIDField]
aField = theFields.next()
gp.AddMessage("%-10s %-10s %-6s %-6s " % ("Field","Type","Scale","Useable"))

while aField:
  fType = aField.Type
  fScale = aField.Scale
  fName = aField.Name
  if fName == inField:
    inType = fType   #used to determine field type later on
    inScale = fScale
    inName = fName
  isOK = "Y"
  if (fType == "String"):
    OKFields.append(fName)
  elif ((fScale == 0) and (fType not in ["Geometry", "Date"])):
    OKFields.append(fName)
  else:
    isOK = "N"
    
  gp.AddMessage("%-10s %-10s %-6s %-6s " % (fName, fType, fScale,isOK))
  aField = theFields.next()
#
if inField not in OKFields:
  gp.AddMessage("The field " + inField + " is not an appropriate" + \
                " field type.  Terminating operation.  " + \
                "Convert date fiels to strings, and ensure integers " \
                "are positive" + "\n")  
  del gp
  sys.exit()
#  
#Determine unique values in the selected field

gp.AddMessage(inField + " is being queried for unique values.")
valueList = []
rows = gp.SearchCursor(inFC)
row = rows.next()
aString = ""
aLen = 0; aFac = 1

while row:
  aVal = row.GetValue(inField)
  if aVal not in valueList:
    valueList.append(aVal)
    aLen = len(aString)
    if aLen > 50 * aFac:
      aString = aString + "\n"
      aFac = aFac + 1
    aString = aString + " " + str(aVal)
  row = rows.next()
gp.AddMessage("Unique values: " + "\n" + aString)
#
gp.AddMessage("\n  Processing: " + FullName )
#
#Do the actual work of producing the unique shapefiles
aMax = 1
for aVal in valueList:
  aMax = max(aMax, len(str(aVal)))
for aVal in valueList:
  if (str(aVal).isdigit()) and (not inType == "String"):
    fs = '"' + "%" + str(aMax) + "." + str(aMax) + 'i"'
    aSuffix = fs % aVal
    aVal = str(aVal)
  elif inType == "Double" and inScale == 0:
    aSuffix = str(aVal).replace(".0","")  ###### 
    aVal = str(aVal).replace(".0","")
  else:
    aSuffix = str(aVal) 
    aVal = str(aVal)
  try:
    aSuffix = aSuffix.replace(" ","_")  #replace garbage in output files
    aSuffix = aSuffix.replace('"',"")
    aSuffix = aSuffix.replace("/","")
    aSuffix = aSuffix.replace("-","")
    outName = theFName + aSuffix + ".shp"
    outShapeFile = outFolder + "/" + outName
    outShapeFile = outShapeFile.replace("\\","/")
    # 
    #Create a query and produce the file
    if (not aVal.isdigit()) or (inType == "String"):
      aVal = "'" + aVal + "'"
    whereClause = "%s = %s" % (inField, aVal)
    gp.MakeFeatureLayer(inFC, "TempLayer", whereClause)
    gp.CopyFeatures("TempLayer",outShapeFile)
    gp.AddMessage("Output and query: " + outShapeFile + "  " + whereClause)
  except:
    #gp.AddMessage("did not work")
    whereClause = "%s = %s" % (inField, aVal)
    gp.AddMessage("Output and query: " + outShapeFile + "  " + whereClause + " did not work ")
#
gp.Addmessage("\n  Processing complete" + "\n")
del gp
