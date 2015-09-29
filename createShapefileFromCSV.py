import re
import pandas as pd
from shapely.geometry import Point, mapping
from fiona import collection
import glob
import os
import shutil

def createShapefileFromCSV(inCSV): 
    #need dataframe as df
    #need uid as unique ID
    #need lng field as longitude
    #need lat field as latitude
    
    df = pd.read_csv(inCSV)
    ioSHP = inCSV.replace('.csv','.shp')
    data  = df

    lng = 'lng'
    lat = 'lat'

    data = data

    schema = { 'geometry': 'Point', 'properties': { 'uid': 'str','lat':'float','lng':'float'} }

    with collection(ioSHP, "w", "ESRI Shapefile", schema) as output:
        for index, row in data.iterrows():
            point = Point(row[lng], row[lat])
            output.write({

                'properties': {'uid': row['uid'],'lat': row['lat'],'lng': row['lng']},
                'geometry': mapping(point)
            })

    print 'shapefile has a shapefile created'

ioCSV = wi+'addresses/ccceh_grocery/addresses_xy_uid.csv'

createShapefileFromCSV(ioCSV)