selExp = """MOD("OBJECTID" ,100) = 0""" #grab every hundreth record for testing/coding purposes

print 'select input data'
arcpy.Select_analysis(wd+"data/gps_data.gdb/gpspoints",wi+"gps_data.gdb/gps_points",selExp)