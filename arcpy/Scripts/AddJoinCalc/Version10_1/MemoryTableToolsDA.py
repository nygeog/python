'''
Creates a dictionary to be used to update rows in a table to replace the
Add Join and Calculate Field routines.  Attribute Update updates only one
field in source table, OR the user can choose multiple fields to update
by providing a list.  Dictionaries will be created for each join value
field and are used to update the update fields.

Written by: Caleb Mackey  11\14\2012
'''

def AttributeUpdate(source_table, in_field, update_field, join_table, join_key, join_value):
    try:
        import arcpy, os, sys, traceback
        from os import path as p

        # Check input parameters
        if not arcpy.Exists(source_table):
            print source_table + ' not found!\nPlease verify that full path of table exists'
            sys.exit()
        elif not arcpy.Exists(join_table):
            print join_table + ' not found!\nPlease verify that full path of table exists'
            sys.exit()
        elif in_field not in [f.name for f in arcpy.ListFields(source_table)]:
            print in_field + ' not found in ' + p.basename(source_table)
            sys.exit()
        elif join_key not in [f.name for f in arcpy.ListFields(join_table)]:
            print join_key + ' not found in ' + p.basename(join_table)
            sys.exit()
        elif update_field not in [f.name for f in arcpy.ListFields(source_table)]:
            print update_field + ' not found in ' + p.basename(source_table)
            print 'Please verify that field names match in ' + p.basename(source_table)
            sys.exit()
        elif join_value not in [f.name for f in arcpy.ListFields(join_table)]:
            print join_value + ' not found in ' + p.basename(join_table)
            print 'Please verify that field names match in ' + p.basename(join_table)
            sys.exit()
        
        # Create Dictionary
        with arcpy.da.SearchCursor(join_table,[join_key, join_value]) as srows:
            path_dict = dict([srow[0], srow[1]] for srow in srows)
            
        # Update Cursor
        with arcpy.da.UpdateCursor(source_table,[in_field, update_field]) as urows:
            for row in urows:
                if row[0] in path_dict:
                    row[1] = path_dict[row[0]]
                    urows.updateRow(row)

        print "'" + update_field + "'" + ' field in ' + '"' + p.basename(source_table) + '"' + ' updated successfully'
    
    except:
        print '\nERROR in AttributeUpdate Function.\nPlease Check input parameters and try again.'

def MultipleAttributeUpdate(source_table, in_field, update_fields, join_table, join_key, join_values):
    try:
        import arcpy, os, sys, traceback
        from os import path as p
        
        # Check input parameters
        if not arcpy.Exists(source_table):
            print source_table + ' not found!\nPlease verify that full path of table exists'
            sys.exit()
        elif not arcpy.Exists(join_table):
            print join_table + ' not found!\nPlease verify that full path of table exists'
            sys.exit()
        elif in_field not in [f.name for f in arcpy.ListFields(source_table)]:
            print in_field + ' not found in ' + p.basename(source_table)
            sys.exit()
        elif join_key not in [f.name for f in arcpy.ListFields(join_table)]:
            print join_key + ' not found in ' + p.basename(join_table)
            sys.exit()
        for fld in update_fields:
            if fld not in [f.name for f in arcpy.ListFields(source_table)]:
                print fld + ' not found in ' + p.basename(source_table)
                print 'Please verify that field names match in ' + p.basename(source_table)
                sys.exit()
        for fldb in join_values:
            if fldb not in [f.name for f in arcpy.ListFields(join_table)]:
                print fldb + ' not found in ' + p.basename(join_table)
                print 'Please verify that field names match in ' + p.basename(join_table)
                sys.exit()

        # Make sure there is matching number of join and update fields
        if len(update_fields) == len(join_values):
            fieldsDict = {}
            ind = 0
            while ind < len(update_fields):
                for field in update_fields:
                    fieldsDict[field] = join_values[ind]
                    
                    # Create Dictionary
                    with arcpy.da.SearchCursor(join_table,[join_key, join_values[ind]]) as srows:
                        path_dict = dict([srow[0], srow[1]] for srow in srows)
        
                    # Update Cursor
                    with arcpy.da.UpdateCursor(source_table,[in_field, field]) as urows:
                        for row in urows:
                            if row[0] in path_dict:
                                row[1] = path_dict[row[0]]
                                urows.updateRow(row)

                    print "'" + field + "'" + ' field in ' + '"' + p.basename(source_table) + '"' + ' updated successfully'
                    ind += 1
          
        else:
            print 'ERROR:  Number of update fields and value fields does not match'
                
    except:
        print '\nERROR in AttributeUpdate Function.\nPlease Check input parameters and try again.'        
