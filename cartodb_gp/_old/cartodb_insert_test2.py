import urllib
import urllib2
import json

username = 'dms8md23'
apikey = 'fc4b0fe709cc086fd177768e648694d6be3170dc'
query = "INSERT INTO test_table1 (the_geom, observation) VALUES (ST_GeomFromText(’POINT(-71.2 42.5)’, 4326),'rare bird spotted')"

url = "https://dms8md23.cartodb.com/api/v1/sql"

# prams object that holds our api key and query.
params = {
    'api_key' : apikey,
    'q'       : query  
}

req = urllib2.Request(url, urllib.urlencode(params))
res = urllib2.urlopen(req)
res.getcode()

for i in res:
	print i