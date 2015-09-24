import urllib
import urllib2
import cartodb

username = 'dms8md23'
apikey = 'fc4b0fe709cc086fd177768e648694d6be3170dc'

insert = "select cdb_cartodbfytable('testCREATE');"

url = "https://%s.cartodb.com/api/v1/sql" % username

params = {
    'api_key' : apikey, # our account apikey, don't share!
    'q'       : insert  # our insert statement above
}

req = urllib2.Request(url, urllib.urlencode(params))
response = urllib2.urlopen(req)