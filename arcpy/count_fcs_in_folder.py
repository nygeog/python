arcpy.env.workspace = NAME OF GDB HERE

# Get stand alone FCs
fccount = len(arcpy.ListFeatureClasses("",""))

# Get list of Feature Datasets and loop through them
fds = arcpy.ListDatasets("","")
for fd in fds:
    oldws = arcpy.env.workspace
    arcpy.env.workspace = oldws + "\\" + fd
    fccount = fccount + len(arcpy.ListFeatureClasses("",""))
    arcpy.env.workspace = oldws


print fccount