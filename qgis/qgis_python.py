ogr2ogr -f GPX /Users/danielmsheehan/Dropbox/GIS/Projects/GPS/2014/data/students/ds/15761-ds-20140605.gpx /Users/danielmsheehan/Dropbox/GIS/Projects/GPS/2014/data/students/ds/15761-ds-20140605.shp

ogr2ogr -f CSV /Users/danielmsheehan/Dropbox/GIS/Projects/GPS/2014/data/students/ds/test1.csv  /Users/danielmsheehan/Dropbox/GIS/Projects/GPS/2014/data/students/ds/15761-ds-20140605.gpx  -lco GEOMETRY=AS_XY FORCE_GPX_TRACK=YES 

vlayer = QgsVectorLayer("/Users/danielmsheehan/Dropbox/GIS/Projects/GPS/2014/data/students/ds/15761-ds-20140605.gpx", "layer_name_you_like", "ogr")

uri = "/Users/danielmsheehan/Dropbox/GIS/Projects/GPS/2014/data/students/ds/15761-ds-20140605.gpx?type=points"
vlayer = QgsVectorLayer(uri, "test", "gpx")

QgsMapLayerRegistry.instance().addMapLayer(vlayer)