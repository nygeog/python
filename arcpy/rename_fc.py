import arcpy
from arcpy import env
import os

# Set workspace
env.workspace = r'U:\naas\tasks\201411_grid\data\processing\geogs\buffers_subset.gdb'

# Set local variables
data_type = "FeatureClass"

fcList = arcpy.ListFeatureClasses()

for fc in fcList:
	print fc
	try:
		arcpy.Rename_management(fc, fc.replace('_',''), data_type)
	except:
		print 'this fc has no _' 