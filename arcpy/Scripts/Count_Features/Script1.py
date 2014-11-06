import arcpy
from arcpy import env
env.workspace = arcpy.GetParameterAsText(0)

list = []

for dataset in arcpy.ListDatasets("*"):
    for fc in arcpy.ListFeatureClasses("*", "", dataset):
        list.append(fc)

for fc in arcpy.ListFeatureClasses("*"):
    list.append(fc)

print len(list)    

arcpy.AddMessage("There are " + str(len(list)) + " feature classes within the geodatabase")
