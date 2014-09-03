import arcpy, time, datetime, csv, sys, traceback
from arcpy import env
env.overwriteOutput = True

print 'copy 2010 tracts'
arcpy.Copy_management("W:/GIS/Data/Census/census_2010/tracts/census.gdb","V:/GIS/projects/transit/tasks/201405_transit/data/input/census.gdb","Workspace")