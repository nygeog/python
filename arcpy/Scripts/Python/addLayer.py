import arcpy
mxd = arcpy.mapping.MapDocument("CURRENT")
df = arcpy.mapping.ListDataFrames(mxd, "Layers")[0]
addLayer = arcpy.mapping.Layer(r"D:\GIS\Data\DATA_NAME")
arcpy.mapping.AddLayer(df, addLayer, "AUTO_ARRANGE")

