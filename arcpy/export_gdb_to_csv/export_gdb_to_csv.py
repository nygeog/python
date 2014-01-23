print 'export to csv'
for geo in geos:
	table   = pd+"/processing/treedn/treedn.gdb/"+geo+"_trees_int_dis"
	outfile = pd+"/processing/treedn/"+geo+"_trees.csv"      

	#--first lets make a list of all of the fields in the table
	fields = arcpy.ListFields(table)
	field_names = [field.name for field in fields]

	with open(outfile,'wb') as f:
	    w = csv.writer(f)
	    #--write all field names to the output file
	    w.writerow(field_names)

	    #--now we make the search cursor that will iterate through the rows of the table
	    for row in arcpy.SearchCursor(table):
	        field_vals = [row.getValue(field.name) for field in fields]
	        w.writerow(field_vals)
	    del row