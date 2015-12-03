#list of unique field values

def unique_values(table, field):
    with arcpy.da.SearchCursor(table, [field]) as cursor:
        return sorted({row[0] for row in cursor})


# Here is an example of the return values:

# >>> unique_values(r’C:\boston\city.gdb\crime’, ‘DAY’)
# [u’Mon’, u’Sun’, u’Tues’, u’Wed’]

#https://arcpy.wordpress.com/2012/02/01/create-a-list-of-unique-field-values/