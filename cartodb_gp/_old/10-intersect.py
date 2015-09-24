import urllib
import urllib2
import cartodb

username = 'dms8md23'
apikey = 'fc4b0fe709cc086fd177768e648694d6be3170dc'

def intersect(table_A, table_B, outtable, geom_A, geom_B):
	"""!Intersects overlapped geometries.
	@param table_A  : Input table for merge.
	@param table_B  : Input table for merge.
	@param outtable : Name of table to store the results.
	@param geom_A   : Name of the geometry column for intersection.
	@param geom_B   : Name of the geometry column for intersection.
	"""
	# Make a SQL statement.
	sql_geom = "a." + geom_A + ", " + "b." + geom_B
	sql_from = " FROM " + table_A + " as a, " + table_B + " as b"
	sql_overlaps = "ST_Intersects(a." + geom_A + ", b." + geom_B + ")"
	sql_intersect = "SELECT  ST_Intersection(" + sql_geom +"), a.geoid, b.observation" + sql_from + " WHERE " + sql_overlaps                
	sql_create = 'CREATE TABLE "' + outtable + '" AS (' + sql_intersect + ')'
	# Excute the SQL statement.
	#self.cursor.execute(sql_create)

	insert = sql_create

	print sql_create

	url = "https://%s.cartodb.com/api/v1/sql" % username

	#Create an object containing the parameters of our request

	params = {
	    'api_key' : apikey, # our account apikey, don't share!
	    'q'       : insert  # our insert statement above
	}

	#Send the request using urllib2

	req = urllib2.Request(url, urllib.urlencode(params))
	response = urllib2.urlopen(req)

intersect('nyct2010', 'test_tablebuffer2', 'test_tableintersect51', 'the_geom','the_geom')
