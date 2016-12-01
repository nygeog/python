from cartodb import CartoDBAPIKey, CartoDBException, FileImport
from _secret_info import cartodb_domain, API_KEY # gitignored secret info 

cl = CartoDBAPIKey(API_KEY, cartodb_domain)

inCSV = "data.csv"

fi = FileImport(inCSV, cl, create_vis='true', privacy='public') # Import csv file, set privacy as 'link' and create a default viz
fi.run() #https://github.com/CartoDB/cartodb-python
