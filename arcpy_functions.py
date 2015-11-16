#import arcpy

def addCalc(inFeature,inField,inFieldType,inExpression):
    ### Example:
    ### AddCalc(inFeature,'addcalcfield',   "DOUBLE", "!Shape!.positionAlongLine(1.0,True).firstPoint.Y")
    arcpy.AddField_management(      inFeature, inField, inFieldType,"#","#","#","#","NULLABLE","NON_REQUIRED","#")
    arcpy.CalculateField_management(inFeature, inField, inExpression,"PYTHON_9.3","#")

def nearJoin(inFeature,nearFeature,nearDistance,outFileLocation,outFeature):
    ### Normal Near Function doesn't carry over all the attributes of inFeature or nearFeature.
    ### To Do: 
    ### Error handling in try: except: should handle OBJECTID vs. FID issues. 
    ### Example:
    ### inF = wd+"input/fulcrum.gdb/street_segment_questions_v2_prj"
    ### nrF = wd+"processing/gar.gdb/gar_roads_ftl"
    ### nrD = "20 Meters"
    ### ouL = wd+"processing/fulcrum.gdb"
    ### ouF = "TEST"
    ###
    ### NearJoin(inF,nrF,nrD,ouL,ouF)
    outFeature_temp = outFeature.replace('.shp','_temp.shp')
    print 'copy inFeature to temporary dataset, why, b/c the Near_analysis function appends dist,direction info to main dataset w/o creating an output dataset, problematic, if you want to run near for many feature classes'
    arcpy.FeatureClassToFeatureClass_conversion(inFeature,outFileLocation,outFeature_temp)

    print 'find nearest feature to inFeature'
    arcpy.Near_analysis(outFileLocation+'/'+outFeature_temp,nearFeature,nearDistance,"LOCATION","ANGLE")

    print 'make feature layer for both inFeature and nearFeature'
    arcpy.MakeFeatureLayer_management(outFileLocation+'/'+outFeature_temp,  "inFeature_Layer")
    arcpy.MakeFeatureLayer_management(nearFeature,"nearFeature_Layer")

    print 'join nearFeature attributes to inFeature'
    try:
        arcpy.AddJoin_management("inFeature_Layer","NEAR_FID","nearFeature_Layer","OBJECTID","KEEP_ALL")
    except:
        arcpy.AddJoin_management("inFeature_Layer","NEAR_FID","nearFeature_Layer","FID","KEEP_ALL")

    print 'feature class to feature class'
    arcpy.FeatureClassToFeatureClass_conversion("inFeature_Layer",outFileLocation,outFeature)
    
    print 'delete intermediate temp input data'
    arcpy.Delete_management(outFileLocation+'/'+outFeature_temp)