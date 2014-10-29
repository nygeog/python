def FindField(fc,myField):
    fieldList = arcpy.ListFields(fc)
    for field in fieldList:
        if str.lower(str(field.name)) == str.lower(myField):
            print "    " + fc + " contains fieldname: " + myField