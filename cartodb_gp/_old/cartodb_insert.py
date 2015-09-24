from cartodb import CartoDBAPIKey, CartoDBException

API_KEY ='fc4b0fe709cc086fd177768e648694d6be3170dc'
cartodb_domain = 'dms8md23'
cl = CartoDBAPIKey(API_KEY, cartodb_domain)
try:
   print cl.sql('select * from nyct2010')
# except CartoDBException as e:
#    print ("some error ocurred", e)
except:
	print 'whoa'