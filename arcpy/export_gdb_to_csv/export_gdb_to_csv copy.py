wd = #<working directory>
table   = pd+"/treedn.gdb/"+geo+"_trees_int_dis"
outfile = pd+"/treedn/"+geo+"_trees.csv"      

fields = arcpy.ListFields(table)
field_names = [field.name for field in fields]

with open(outfile,'wb') as f:
    w = csv.writer(f)
    w.writerow(field_names)
    for row in arcpy.SearchCursor(table):
        field_vals = [row.getValue(field.name) for field in fields]
        w.writerow(field_vals)
    del row