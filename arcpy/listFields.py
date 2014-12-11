flds=[]
fldObj=arcpy.ListFields(yourfeatureclass)
for fld in fldObj:
    flds.append(fld.name)

#then loop through your list of variables that the search cursor is looking for:
missingvar=[]
for v in variables:
    if v not in flds:
        missingvar.append(v)

#and print the missing variables
for m in missingvar:
    print m,'\n'