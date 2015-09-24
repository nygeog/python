import urllib
import urllib2
import cartodb

username = 'dms8md23'
apikey = 'fc4b0fe709cc086fd177768e648694d6be3170dc'

#Next, lets create an INSERT statement to use

'nyct2010'
'test_tablebuffer'

insert = """CREATE TABLE test_tableintersect20 AS 
    SELECT  ST_Intersection(test_tablebuffer.geom, nyct2010.geom) As intersect_ab
    FROM test_tablebuffer INNER JOIN nyct2010 ON ST_Intersection(test_tablebuffer,nyct2010)
    WHERE ST_Intersects(test_tablebuffer.geom, nyct2010.geom)
    ;"""

url = "https://%s.cartodb.com/api/v1/sql" % username

#Create an object containing the parameters of our request

params = {
    'api_key' : apikey, # our account apikey, don't share!
    'q'       : insert  # our insert statement above
}

#Send the request using urllib2

req = urllib2.Request(url, urllib.urlencode(params))
response = urllib2.urlopen(req)