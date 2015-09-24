import urllib
import urllib2
import cartodb

username = 'dms8md23'
apikey = 'fc4b0fe709cc086fd177768e648694d6be3170dc'

#Next, lets create an INSERT statement to use

#insert = "INSERT INTO testcreate (the_geom) VALUES (ST_Buffer(CDB_LatLng(40.7127, -74.0059),0.11));"
#insert = "UPDATE table_test1 SET buffer = (SELECT ST_Buffer(table_test2.the_geom,100) FROM table_test2 WHERE table_test1.cartodb_id=table_test2.cartodb_id)"
insert = "UPDATE t2 SET buffer = (SELECT ST_Buffer(t1.the_geom,100) FROM t1 WHERE t1.cartodb_id=t2.cartodb_id)"
#Create the URL endpoint for our account API

url = "https://%s.cartodb.com/api/v1/sql" % username

#Create an object containing the parameters of our request

params = {
    'api_key' : apikey, # our account apikey, don't share!
    'q'       : insert  # our insert statement above
}

#Send the request using urllib2

req = urllib2.Request(url, urllib.urlencode(params))
response = urllib2.urlopen(req)