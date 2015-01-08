from arcpy import env
import os
env.workspace = r'V:\naas\tasks\201411_grid\data\processing\intersects\tree_canopy\gr0500m.gdb'
fcList = arcpy.ListFeatureClasses()
for fc in fcList:
	print fc