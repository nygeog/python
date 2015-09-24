import urllib
import urllib2
import cartodb

username = 'dms8md23'
apikey = 'fc4b0fe709cc086fd177768e648694d6be3170dc'

insert = "INSERT INTO test_table1 (the_geom, observation) VALUES (CDB_LatLng(40.7127, -74.0059), 'TEST')"

url = "https://%s.cartodb.com/api/v1/sql" % username

params = {
    'api_key' : apikey, # our account apikey, don't share!
    'q'       : insert  # our insert statement above
}

req = urllib2.Request(url, urllib.urlencode(params))
response = urllib2.urlopen(req)