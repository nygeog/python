#CSV to Shapefile
##Read a CSV file and save as Shapefile.
###You need Fiona, Pandas and Shapely

[Check out my blogpost for more info] http://scriptogr.am/nygeog/post/csv-to-shapefile-conversion-with-pandas-fiona-and-shapely)

	import pandas as pd
	from shapely.geometry import Point, mapping
	from fiona import collection

	inCSV  = 'sample.csv'
	shpOut = 'sites.shp'
	lng = 'Longitude'
	lat = 'Latitude'

	schema = { 'geometry': 'Point', 'properties': { 'Id': 'str' } }

	df = pd.read_csv(inCSV) 

	data = df
	with collection(shpOut, "w", "ESRI Shapefile", schema) as output:
    	for index, row in data.iterrows():
        	point = Point(row[lng], row[lat])
        	output.write({
            	'properties': {'Id': row['Id']},
            	'geometry': mapping(point)
        	})