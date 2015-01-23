from arcpy import env
import os
env.workspace = 'U:/naas/tasks/201411_grid/data/processing/intersects/tree_canopy/gr0500m.gdb'
theList = []

fcList = arcpy.ListFeatureClasses()

for fc in fcList:
	fc = fc.encode('utf-8')
	theList.append(fc)

sortedList = sorted(theList)

for i in sortedList:
	print i
