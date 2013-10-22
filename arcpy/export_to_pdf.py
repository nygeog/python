import arcpy.mapping
output_pdf = r'V:\Dropbox\GIS\Projects\tanzania\images\test.pdf'
mxd = arcpy.mapping.MapDocument("CURRENT")
arcpy.mapping.ExportToPDF(mxd, output_pdf)