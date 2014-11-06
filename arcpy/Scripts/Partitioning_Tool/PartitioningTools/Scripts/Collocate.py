#*****************************************************************************************
#Description: 
#      This script assigns a class number to features in a feature class based on accumulated
#      attribute values, a visit order and capacity. This script is similar to the ArcInfo 
#      workstation COLLOCATE command
#Inputs:
#      1)Input feature class
#      2)The field containing the order values for the feature
#      3)The field specifying the accumulated attribute for the feature
#      4)The numeric value specifying the capacity or size of the class
#      5)The new field name which will contain the class number assigned by this tool.
#Outputs:
#      1)Input feature class as derived output with the newly added field
#*****************************************************************************************

#prints a GP message and writes the same message to a log file
def PrintAndWriteMessages(msg,severity=0):
    if severity == 0:
        gp.AddMessage(msg)
    elif severity == 1:
        gp.AddWarning(msg)
    elif severity == 2:
        gp.AddError(msg)
    logfile.write(msg + "\n")
    
#Import the modules
import arcgisscripting, sys,os, traceback

#Create the 93 geoprocessor to use native python objects returned by list methods on geoprocessor
gp = arcgisscripting.create(9.3)

#Use the lowest available license
for product in ['Engine','ArcView', 'ArcEditor', 'EngineGeoDB','ArcInfo', 'ArcServer']:
    if gp.CheckProduct(product).lower() == 'available':
        gp.SetProduct(product)
        break

gp.Overwriteoutput = True
try:
    #Create a log file with messages in the same location as the script
    logfile = open(os.path.splitext(sys.argv[0])[0] + "_log.txt","w",0)

    #Get the inputs
    inp_fc = gp.GetParameterAsText(0)
    order_item = gp.GetParameterAsText(1)
    transfer_item = gp.GetParameterAsText(2)
    capacity = float(gp.GetParameterAsText(3))
    out_class_item = gp.GetParameterAsText(4)
    
    #gp.AddWarning("DataType: " + desc.DataType)
    #gp.AddWarning("DatasetType: " + desc.DatasetType)
    #gp.AddWarning("CatalogPath: " + desc.CatalogPath)
    #fc_path = desc.CatalogPath
    
    #Get a feature count to set up the progressor
    tot_features = long(gp.GetCount(inp_fc).GetOutput(0))
    
    #Create a progressor
    gp.SetProgressor("step","Executing Collocate",0,tot_features + 1,1)
    
    msg = "Adding the class field " + out_class_item
    gp.SetProgressorLabel(msg)
    PrintAndWriteMessages(msg,0)
    #Validate the output field name for the workspace
    out_class_item = gp.ValidateFieldName(out_class_item,os.path.dirname(inp_fc))
    
    #Add the new field. If the field already exists, AddField has a warning
    result = gp.AddField_management(inp_fc,out_class_item,"Double")
    if result.MaxSeverity == 1:
        msg = result.GetMessages(1).split(':')[1].lstrip() + "Existing values will be overwritten."
        PrintAndWriteMessages(msg,1)
    gp.SetProgressorPosition()
    
    msg = "Calculating class values for features....."
    gp.SetProgressorLabel(msg)
    PrintAndWriteMessages(msg,0)
    
    #Assign the value of -1 for class field for rows where transfer_item > capacity
    where_clause = transfer_item + " > " + str(capacity)
    inp_fc_layer = "inp_fc_layer"
    #Create a new layer containing only exceeding rows
    gp.MakeFeatureLayer_management(inp_fc,inp_fc_layer,where_clause,"#","#")
    exceed_count = long(gp.GetCount(inp_fc_layer).GetOutput(0)) 
    if  exceed_count > 0:
        #Assign -1 to class field
        gp.CalculateField_management(inp_fc_layer,out_class_item,-1,"PYTHON_9.3","#")
        gp.SetProgressorPosition(exceed_count)
    
    #Delete the new layer
    gp.Delete_management(inp_fc_layer)
    
    #Update the total_features that are to be processed further
    tot_features = tot_features - exceed_count
    
    #Calculate the Class field
    #Get an update cursor such that values are in ascending order based on OrderItem field
    #Don't get the rows where transfer_item > capacity
    fields = [order_item,transfer_item]
    fields = ";".join(fields)
    where_clause = transfer_item + " <= " + str(capacity)
    
    #Get the OID field name
    desc = gp.Describe(inp_fc)
    oid_fld = desc.OIDFieldName
    rows = gp.SearchCursor(inp_fc,where_clause,"",fields,order_item + " A")
    rows.reset()
    row = rows.next()
    acc_capacity = 0
    class_value = 1
    count = 0
    #Store the class value and the list of OIDs in that class in a dict.
    classValueDict = {class_value : []}
    while row: 
        count += 1 #counter for rows
        cur_capacity = row.GetValue(transfer_item)
        acc_capacity += cur_capacity
        #Accumulate the transfer item till it is less than capacity
        if acc_capacity <= capacity:
            classValueDict[class_value].append(str(row.GetValue(oid_fld)))
        else:
            acc_capacity = cur_capacity
            class_value += 1
            classValueDict[class_value] = []
            classValueDict[class_value].append(str(row.GetValue(oid_fld)))
        del row
        row = rows.next()
        #Update the progressor after processing 5% rows
        if count % (int(0.05 * tot_features)) == 0:
            #msg = "Completed processing %s out of %s features" % (count,tot_features)
            #PrintAndWriteMessages(msg,0)
            gp.SetProgressorPosition(count / 2.0)
    del rows
    
    msg = "Assigning class values to features......"
    gp.SetProgressorLabel(msg)
    PrintAndWriteMessages(msg,0)
    
    position = tot_features / 2.0
    #Update the class values by first making a selection set and then using Calculate field.
    for k in classValueDict.keys():
        where_clause = oid_fld + " IN " + '(' + ",".join(classValueDict[k]) + ')'
        lyr = "inp_fc_lyr"
        gp.MakeFeatureLayer(inp_fc,lyr,where_clause)
        gp.CalculateField(lyr,out_class_item,k,"PYTHON_9.3","#")
        gp.Delete_management(lyr)
        position += len(classValueDict[k]) /2.0
        gp.SetProgressorPosition(position)
    
    #Set the output to be same as input
    #Useful to show the output when the tool is used in model builder
    gp.SetParameterAsText(5,inp_fc)
except:
    # Return any python specific errors as well as any errors from the geoprocessor
    tb = sys.exc_info()[2]
    tbinfo = traceback.format_tb(tb)[0]
    pymsg = "PYTHON ERRORS:\nTraceback Info:\n" + tbinfo + "\nError Info:\n    " + \
            str(sys.exc_type)+ ": " + str(sys.exc_value) + "\n"
    PrintAndWriteMessages(pymsg,2)

    msgs = "GP ERRORS:\n" + gp.GetMessages(2) + "\n"
    PrintAndWriteMessages(msgs,2)
