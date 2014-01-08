# ---------------------------------------------------------------------------
# HUClipper1b.py
# Created on: Thu Jun 02 2011 07:17:47 PM
#   (generated by ArcGIS/ModelBuilder)
# Usage: HUClipper1b <fid0> 
# ---------------------------------------------------------------------------

# Import system modules
import sys, string, os, arcgisscripting

# Create the Geoprocessor object
gp = arcgisscripting.create(9.3)

# Load required toolboxes...
gp.AddToolbox("C:/Program Files (x86)/ArcGIS/ArcToolbox/Toolboxes/Data Management Tools.tbx")

# Script arguments...
fid0 = sys.argv[1]
if fid0 == '#':
 fid0 = "D:\\biodiversity\\EnvFactors\\vdof treecover & landcover data\\vfcm05_l1_grid\\vfcm05_lev1a_Clip1.img" # provide a default value if unspecified
#Needs changing for looping...otherwise it will overwrite

# Local variables...
HUs_Project = "HUs_Project"
vfcm05_lev1a = "vfcm05_lev1a"
HUs_Project__2_ = "HUs_Project"
inField = "\'VAHU6\'"

rows = gp.SearchCursor(HUs_Project__2_)
row = rows.Next()

while row:

	HUCInput = row.GetValue(inField)
	
	# Process: Select Layer By Attribute...
	gp.SelectLayerByAttribute_management(HUs_Project__2_, "NEW_SELECTION", inField = HUCInput)

	#Describe object
	desc = gp.describe(fc)
	extent = desc.extent
	#Returns an extent object

	minx = extent.xmin

	miny = extent.ymin

	maxx = extent.xmax

	maxy = extent.ymax

	# Process: Clip...
	gp.Clip_management(vfcm05_lev1a, minx, miny, maxx, maxy, fid0, HUs_Project, "", "ClippingGeometry")

	row = rows.Next()

del row
del rows
