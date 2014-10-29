datasetList = arcpy.ListDatasets("*", "Feature")  
for dataset in datasetList:  
    print dataset  
    fcList = arcpy.ListFeatureClasses("*","",dataset)  
    for fc in fcList:  
        print fc  