import urllib
import urllib2
import cartodb

username = 'dms8md23'
apikey = 'fc4b0fe709cc086fd177768e648694d6be3170dc'

insert = "INSERT INTO testCREATE AS SELECT ST_Buffer(the_geom_webmercator, 3000) AS the_geom_webmercator, cartodb_id FROM test_table1"

url = "https://%s.cartodb.com/api/v1/sql" % username

params = {
    'api_key' : apikey, # our account apikey, don't share!
    'q'       : insert  # our insert statement above
}

req = urllib2.Request(url, urllib.urlencode(params))
response = urllib2.urlopen(req)