import pandas as pd
from shapely.geometry import Point, mapping
from fiona import collection

inCSV  = '/Users/....../sites_xy_data.csv'
shpOut = '/Users/....../sites.shp'
lngField = 'Longitude'
latField = 'Latitude'

schema = { 'geometry': 'Point', 'properties': { 'SITEID': 'str' } }

df = pd.read_csv(inCSV) 

data = df
with collection(shpOut, "w", "ESRI Shapefile", schema) as output:
    for index, row in data.iterrows():
        point = Point(row[lng], row[lat])
        output.write({
            'properties': {'SITEID': row['SITEID']},
            'geometry': mapping(point)
        })