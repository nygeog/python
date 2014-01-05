import arcpy, time, datetime, csv, sys, traceback
from arcpy import env
env.overwriteOutput = True

proj_path = "U:/GIS/projects/.../"
pp = proj_path
pd = pp + 'data'

print 'check out Network Analyst extension'
arcpy.CheckOutExtension("Network")

print 'create network buffer for 2640 ft'
#2640 Feet to meters is 804.672 Meters, the lion_ped_nd.nd is in meters. 
arcpy.MakeServiceAreaLayer_na("U:/GIS/projects/.../data/input/streets/nyc_lion_2012a/lion/lion_ped/lion_ped_nd.ND","Service_Area","Length","TRAVEL_FROM","804.672","NO_POLYS","NO_MERGE","RINGS","TRUE_LINES","OVERLAP","NO_SPLIT","#","Length","ALLOW_UTURNS","#","NO_TRIM_POLYS","2640 Feet","NO_LINES_SOURCE_FIELDS","NO_HIERARCHY","#")

print 'add locations'
arcpy.AddLocations_na("Service_Area","Facilities","U:/GIS/projects/.../data/input/geogs/geogs.gdb/points","#","2640 Feet","#","lion_ped SHAPE;lion_ped_nd_Junctions NONE","MATCH_TO_CLOSEST","APPEND","SNAP","0 Feet","INCLUDE","lion_ped #;lion_ped_nd_Junctions #")

print 'solve'
arcpy.Solve_na("Service_Area","SKIP","TERMINATE","#")

print 'feature class to feature class: lines'
arcpy.FeatureClassToFeatureClass_conversion("Service_Area/Lines","U:/GIS/projects/.../data/input/geogs/geogs.gdb","n2_preclip_lines","#","#","#")

print 'convex hull'
arcpy.MinimumBoundingGeometry_management("U:/GIS/projects/.../data/input/geogs/geogs.gdb/n2_preclip_lines","U:/GIS/projects/.../data/input/geogs/geogs.gdb/n2_preclip_lines_hull","CONVEX_HULL","LIST","FacilityID","NO_MBG_FIELDS")
