#CartoDB Census Intersect

This application example will rely heavily on [Making calls to the SQL API](http://docs.cartodb.com/cartodb-platform/sql-api.html).

###Dependencies
* [cartodb-python](https://github.com/CartoDB/cartodb-python)
* [pandas](http://pandas.pydata.org/)


![logo](logo/cartodb-arcpy-wrapper-logo.png)


#To Do:
<li><input type="checkbox" disabled> Allow for multiple lat,lng input</li>
<li><input type="checkbox" disabled> Hook up Census API to get generic census data</li>
#Done
<li><input type="checkbox" disabled checked> Remove intermediate tables</li>

##Details 

Account: dms8md23 (log-in with google)
Your API Key: fc4b0fe709cc086fd177768e648694d6be3170dc

 Example write

https://dms8md23.cartodb.com/api/v2/sql?q=INSERT INTO test_table1 (the_geom, observation) VALUES (ST_GeomFromText(’POINT(-71.2 42.5)’, 4326),'rare bird spotted')&api_key=fc4b0fe709cc086fd177768e648694d6be3170dc

##Steps - most SQL steps are now in the actual code:
* Input Table of X,Y's

	* [Write data to your CartoDB account](http://docs.cartodb.com/cartodb-platform/sql-api.html#write-data-to-your-cartodb-account)

			https://{account}.cartodb.com/api/v2/sql?q=INSERT INTO test_table (column_name, column_name_2, the_geom) VALUES ('this is a string', 11, ST_SetSRID(ST_Point(-110, 43),4326))&api_key={Your API key}
		
		* Add and replace a NYC lat, lng. 
	
	* Andrew Hill's response to [What is the simplest way to write data to CartoDB using Python?](http://gis.stackexchange.com/questions/94982/what-is-the-simplest-way-to-write-data-to-cartodb-using-python) on GIS.StackExchange.
			
			import urllib
			import urllib2
			import cartodb
			
			username = 'USERNAME'
			apikey = 'APIKEY'
			
			insert = "INSERT INTO test_table1 (the_geom, observation) VALUES (CDB_LatLng(40.7127, -74.0059), 'TEST')"
			
			url = "https://%s.cartodb.com/api/v1/sql" % username
		
			params = {
			    'api_key' : apikey, # our account apikey, don't share!
			    'q'       : insert  # our insert statement above
		    }
			
			req = urllib2.Request(url, urllib.urlencode(params))
			response = urllib2.urlopen(req)  

* Buffer Feature Layer of X,Y's
	
	* Buffer Query: 

			SELECT
				ST_Buffer(
					the_geom_webmercator,
					100*1609
					) AS the_geom_webmercator,
				cartodb_id
			FROM
				test_table1

* Intersect X,Y's with Census Tracts
	* Maybe this [Geoprocessing with PostGIS - Part 1](http://blog.cartodb.com/geoprocessing-in-postgis/) will help. 
	* [PostGIS Documentation](http://postgis.net/docs/ST_Intersects.html)

	* Code from GIS.StackExchange [Is there a way to clip areas that are intersecting in Cartodb?](http://gis.stackexchange.com/questions/113500/is-there-a-way-to-clip-areas-that-are-intersecting-in-cartodb)
	
			SELECT a.* FROM polygon_table AS a, point_table AS b WHERE ST_Intersects(a.the_geom, b.the_geom)

* Calculate new area of intersect for each feature

	* On GIS.StackExchange topic [How to calculate area or centroid of the_geom in CartoDB?](http://gis.stackexchange.com/questions/84195/how-to-calculate-area-or-centroid-of-the-geom-in-cartodb)

			SELECT ST_Area(the_geom::geography) area_sqm FROM tablename

* Export Buffer/Intersect table

	* Example of calling from BEH-GIS website Bike Routes 


			https://dms2203.cartodb.com/api/v2/sql?filename=beh_bikertlenall_ct2010.csv&amp;format=csv&amp;q=SELECT geoid,t10birtlen FROM ct10

	* As a button 

		<button onclick="location.href=&quot;https://dms2203.cartodb.com/api/v2/sql?filename=beh_bikertlenall_ct2010.csv&amp;format=csv&amp;q=SELECT geoid,t10birtlen FROM ct10&quot;"><strong>Export</strong> Bike Routes Length data as <strong>CSV</strong></button>
		
		<button onclick="location.href="https://dms2203.cartodb.com/api/v2/sql?filename=beh_walkability_ct2010.csv&format=csv&q=SELECT geoid,t10km2,t10lndkm2,t10cnt,t10resdn1,t10intden,t10entrpy,t10rtlfar,t10sub07d,t10walk,t10walkc FROM ct10"">…</button>
		
#Join with US Census API and Calculate Area-Weighted Apportionment Values
