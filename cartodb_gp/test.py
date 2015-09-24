from cartodbAWCCensus import cartodbAWCensus

cartoDBusername = 'dms8md23'
cartoDBapikey = 'fc4b0fe709cc086fd177768e648694d6be3170dc'

latlngList = [['40.6400','-73.7800'],['40.7127','-74.0059'],['40.730278','-73.954167']] #JFK multipoly prob's and City Hall and Greenpoint and #JFK

for idx, item in enumerate(latlngList):
    cartodbAWCensus(item[0],item[1],'2500','nyct2010_explode',idx,cartoDBusername, cartoDBapikey)
	#cartodbAWCensus(inLat,  inLng,  bufDist,censusFeature,  inFeatureID,username,  apikey):