myField = "MY_FIELD"  
minValue = arcpy.SearchCursor(inlayer, "", "", "", myField + " A").next().getValue(myField) #Get 1st row in ascending cursor sort  
maxValue = arcpy.SearchCursor(inlayer, "", "", "", myField + " D").next().getValue(myField) #Get 1st row in descending cursor sort 


#from this website https://geonet.esri.com/thread/44338