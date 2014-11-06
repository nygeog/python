#Script created by Chris Snyder; modified by C. Denninger
# Script resulted from ESRI Forum posts dated 04FEB2010.

# This script is used in a script tool within ArcGIS and calculates
#..the median value of one entire field and posts that single median
#...value to every row in one other entire field.

import sys, arcgisscripting
gp = arcgisscripting.create(9.3)


inputTable = gp.GetParameterAsText(0)
readField = gp.GetParameterAsText(1) #this needs to be a numeric field
writeField = gp.GetParameterAsText(2) #this needs to be a double or float


valueList = []
searchRows = gp.searchcursor(inputTable)
searchRow = searchRows.next()
while searchRow:
   searchRowValue = searchRow.getvalue(readField)
   if searchRowValue == None:
      pass #don't add a null value to the list!
   else:
      valueList.append(searchRowValue)
   searchRow = searchRows.next()
del searchRow
del searchRows


valueList.sort()
listLength = len(valueList)
if listLength == 0:
   print "Every value was null! Exiting script..."; sys.exit()
elif listLength % 2 == 0: #even, so get the mean of the 2 center values
   medianValue = (valueList[listLength / 2] + valueList[listLength / 2 - 1]) / 2.0
else: #odd, so it's easy!
   medianValue = valueList[listLength / 2]
updateRows = gp.updatecursor(inputTable)
updateRow = updateRows.next()
while updateRow:
   updateRow.setvalue(writeField, medianValue)
   updateRows.UpdateRow(updateRow)
   updateRow = updateRows.next()
del updateRow
del updateRows


