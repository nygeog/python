import arcpy
from arcpy import env
import os
import string
import csv

#Local Variables
workspace = "CHANGE THIS TO THE FOLDER PATH WHERE YOUR TABLE IS STORED. EXAMPLE: C:/TEST"
tableinput = "CHANGE THIS TO THE FULL PATH OF YOUR TABLE.  EXAMPLE C:/TEST/TABLE.DBF"

#Define Workspace
env.workspace = workspace

 #Create a new CSV file in this location
writer = csv.writer(file('C:/test/attributes.csv', 'wb'))  #Change"C:/test/attributes.csv" to the location where you want your new table to be
writer.writerows([['Name', 'Formation', 'Class']])  #In this new CSV file you created above, write "Name", "Formation", "Class" as the new columns
rows = arcpy.SearchCursor(tableinput)  #Use a SearchCursor to search through your table that you defined in the Local Variabled above
for row in rows:  #A For Loop that will loop through each of your rows in your table
    attributes = row.Attributes  #Here we tell it to search only the rows that occur in the field name Attributes.  NOTE:  Change "Attributes" to whatever the name of the field is that you want in separate columns
    newattr = str(attributes).split(',')  #This defines the delimiter (",") that will allow you to separate your attributes
    loganroad = newattr[0]  #With the comma delimiter specified we can now start counting how many attributes you want to separate.  This line equals the first value (Logan Road) in your comma separate list of attributes
    sealed = newattr[1]  #This equals the second value (Sealed) in your comma separated list of attributes
    major = newattr[2]  #This equals the third value (Major) in your comma separated list of attributes
    #With your attributes split up into three separate new names(loganroad, sealed, major), we are going to assign these new names to your new columns
    Name = loganroad
    Formation = sealed
    Class = major
    #Finally we tell the code to permanently write "Name" , "Formation" , "Class" to your CSV File
    writer.writerows([[Name, Formation, Class]])  
    print "split attributes"
del row
del rows
del writer
print "completed table"
    
    
    
    
    
    
    

    