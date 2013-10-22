# this is curently not working, need to fix
import arcpy
mxd = arcpy.mapping.MapDocument("CURRENT")
for lyr in arcpy.mapping.ListLayers(mxd, "Group", "Layers"):
	print lyr.name
# lyr.visible = False

targetGroupLayer = arcpy.mapping.ListLayers(mxd, "Group", df)[0]