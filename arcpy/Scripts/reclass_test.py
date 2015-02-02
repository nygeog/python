# ---------------------------------------------------------------------------
# reclass_test.py
# Created on: 2012-03-02 13:36:27.00000
#   (generated by ArcGIS/ModelBuilder)
# Description: 
# ---------------------------------------------------------------------------

# Import arcpy module
import arcpy

# Check out any necessary licenses
arcpy.CheckOutExtension("spatial")


# Local variables:
KernelD_B01_1 = "D:\\GIS\\Projects\\Farmers_Markets\\rwj\\Healthy_Eating_Research_Program\\Data\\GIS\\Food_Outlet_GDB\\Bodegas_by_Study_Area.gdb\\KernelD_B01_1"
Output_raster = "D:\\GIS\\Projects\\Farmers_Markets\\rwj\\Healthy_Eating_Research_Program\\Data\\GIS\\Food_Outlet_GDB\\Bodegas_by_Study_Area.gdb\\Reclass_Kern1"

# Process: Reclassify
arcpy.gp.Reclassify_sa(KernelD_B01_1, "Value", "0 0.089566651512594755 1;0.089566651512594755 0.29109161741593309 2;0.29109161741593309 0.51500824619741958 3;0.51500824619741958 0.74638876260495557 4;0.74638876260495557 0.97030539138644201 5;0.97030539138644201 1.186758132541879 6;1.186758132541879 1.4032108736973159 7;1.4032108736973159 1.6420552777309014 8;1.6420552777309014 1.9032913446426392 9", Output_raster, "DATA")
