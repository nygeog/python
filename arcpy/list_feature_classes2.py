from arcpy import env
import os

# Set the workspace for the ListFeatureClass function
#
env.workspace = "c:/base"

# Use the ListFeatureClasses function to return a list of 
#  all shapefiles.
#
fcList = arcpy.ListFeatureClasses()

# Copy shapefiles to a file geodatabase
#
for fc in fcList:
	print fc