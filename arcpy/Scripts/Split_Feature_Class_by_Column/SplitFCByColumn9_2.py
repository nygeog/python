#CAD Translation Script Tool
#Creates new Feature Classes from the contents of the Input FC, based on the values in the
#specified column of Input Feature Class.
#The new Feature Classes are created in the specifed Output Geodatabase

#CHANGED:  create GPDispatch object MODIFIED FOR 9.2
#create arcgisscripting instead of GP Dispatch (new way)
print "start"
import arcgisscripting
gp = arcgisscripting.create()

#Access System Arguments
import win32api, sys, os, string, types

#Get Tool Arguments
InputFC = sys.argv[1]
FrequencyField = sys.argv[2]
OutputWorkspace = sys.argv[3]
NamePrefix = sys.argv[4]

#Hardcoded test data
##InputFC = r"C:\Users\drawing.DWG\polyline"
##FrequencyField = "Layer"
##OutputWorkspace = r"C:\Users\"
##NamePrefix = "Lyr_"

#Allow overwriting of temporary files
gp.OverwriteOutput = 1

gp.AddMessage("Splitting FC by Column:" + FrequencyField)
if NamePrefix == None or NamePrefix == "#":
  NamePrefix = ""

#Testing the InputFC datatype find the name of the OID to determine expressioin syntax
OIDFieldList = gp.listfields(InputFC,"*","OID")
OIDObj = OIDFieldList.next()
OIDName = OIDObj.name
gp.AddMessage("OIDName is : " + OIDName)
if OIDName == "FID":
  #If the input is a CAD File or a shapefile use quotes
  LBracket = '"'
  RBracket = '"'

  gp.AddMessage( "Using double Quotes for Field Name in Expression...")
else:
  #if input is a PGDB FC use square brackets
  gp.AddMessage( "Using Square Brackets for Field Name in Expression...")
  LBracket = '['
  RBracket = ']'              

#If the output is a featuredataset find its workspace
WSDescription = gp.describe(OutputWorkspace)
if WSDescription.datatype == 'FeatureDataset':
  NextPart = ''
  TestWorkspace = ''
  for part in OutputWorkspace.split("\\"):
    TestWorkspace = TestWorkspace + NextPart
    if NextPart  == "":
      NextPart = part 
    else:
      NextPart = "\\" + part
else:
  TestWorkspace = OutputWorkspace

#Find a place for the temporary files
scratchWS = gp.scratchWorkspace
if scratchWS:
    desc = gp.Describe(scratchWS)
    if desc.WorkspaceType <> "FileSystem":
        scratchWS = win32api.GetEnvironmentVariable("TEMP")
else:
    scratchWS = win32api.GetEnvironmentVariable("TEMP")

#Local Variables
#The frequency command can take in more than one frequency field
#but is limited here to a single field to get the desired output
SummaryFields = ""
FrequencyTable = scratchWS + "\\GPTemp.dbf"

##if gp.exists(FrequencyTable):
##  print "Overwriting temporary file."
##  gp.delete(FrequencyTable)

#Create Table of Unique Values in the column in Output Workspace

#To overcome a known issue with the Frequency Function in script supporting
#.LYR file all input should be read into an In Memory Layer.
InMemoryFeatureLayer = "FCByColumnLayer"

gp.MakeFeatureLayer(InputFC,InMemoryFeatureLayer)
gp.Frequency_analysis(InMemoryFeatureLayer, FrequencyTable, FrequencyField, SummaryFields)

#OPEN A CURSOR TO THE TABLE
cursor = gp.searchcursor(FrequencyTable)

#GET FIRST RECORD FROM THE CURSOR
row = cursor.next()

#PROCESS FOR EACH UNIQUE RECORD IN THE NEW FREQUENCY TABLE
#The field in the Temporary Frequency Table was probably changed in the .dbf table
#Here we get that deisred column
Fieldlist = gp.listfields(FrequencyTable,"*")
FrequencyFieldObject = Fieldlist.next()
FrequencyFieldObject = Fieldlist.next()
FrequencyFieldObject = Fieldlist.next()
FrequencyTempField = FrequencyFieldObject.name

BadName = 0
while not row is None:
  #GET RECORD VALUE
  UniqueFieldValue = row.getvalue(FrequencyTempField)
  #CHANGED for 9.2: type 'str' or 'unicode' for value type
  if str(type(UniqueFieldValue)) == "<type 'unicode'>" or str(type(UniqueFieldValue)) == "<type 'str'>":
    UniqueIsNumber = "false"
  else:
    UniqueIsNumber = "true"
    UniqueFieldValue = str(UniqueFieldValue)
  gp.AddMessage("Split Value: " + UniqueFieldValue)

  NewName = NamePrefix +  UniqueFieldValue
  #Repair COLUMN Value FOR USE AS FEATURE CLASS NAME
  try:
    #If value has leading number pad with an _ character  
    int(NewName[:1])
    prefixed = "_" + UniqueFieldValue 
    ValidatedTableName = prefixed.replace(" ","_")
    ValidatedTableName = ValidatedTableName.replace(".","_")
    ValidatedTableName = ValidatedTableName.replace("-","_")
  except:
    ValidatedTableName = NewName.replace(".","_")
    ValidatedTableName = ValidatedTableName.replace(" ","_")
    ValidatedTableName = ValidatedTableName.replace("-","_")
  
  #If the column is a blank rename the column
  if ValidatedTableName == "" or ValidatedTableName == " ":
    BadName = BadName + 1
    ValidatedTableName = "BLANK" + str(BadName)

  #CREATE PATH OF NEW FC USING FIELD VALUE
  New_Features_PATH = OutputWorkspace + '\\' + ValidatedTableName
  gp.AddMessage("Creating New Feature Class: " + New_Features_PATH)

  #SELECT FEATURES BASED ON COLUMN VALUE
  if UniqueIsNumber == "true":
    WhereClause = LBracket + FrequencyField + RBracket + " = " + UniqueFieldValue
  else:
    WhereClause = LBracket + FrequencyField + RBracket + " = '" + UniqueFieldValue + "'"
  gp.AddMessage("Where Clause= >" + WhereClause + "<")

  #If the Select function fails the table may already exist try incrementing the table name
  try:
    gp.Select(InMemoryFeatureLayer, New_Features_PATH, WhereClause)
    gp.AddMessage("Created New Feature Class: " + ValidatedTableName)
  except:
      message = gp.getmessages()
      gp.AddMessage(message)
      BadName = BadName + 1
      print "Select Fail 1:" + message
      try:
        New_Features_PATH = OutputWorkspace + '\\' + ValidatedTableName + str(BadName)
        gp.Select(InMemoryFeatureLayer, New_Features_PATH, WhereClause)
      except:
        message = gp.getmessages()
        gp.AddMessage(message)
        print "Select Fail2:" + message

  #GET NEXT RECORD
  row = cursor.next()
print "Done"
gp.AddMessage("End of Function")
del gp

#END