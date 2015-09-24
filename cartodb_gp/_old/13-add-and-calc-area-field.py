import urllib
import urllib2
import cartodb

username = 'dms8md23'
apikey = 'fc4b0fe709cc086fd177768e648694d6be3170dc'

insert = "CREATE TABLE test_tableintersect_area_calc51 AS SELECT ST_Area(the_geom::geography) area_sqmeters, geoid, observation FROM test_tableintersect50"

url = "https://%s.cartodb.com/api/v1/sql" % username

params = {
    'api_key' : apikey, # our account apikey, don't share!
    'q'       : insert  # our insert statement above
}

req = urllib2.Request(url, urllib.urlencode(params))
response = urllib2.urlopen(req)