4sqnswy
=======
 Created with the end goal of getting venueids resolved from 4sq, saved as a CSV and brought into CartoDB.
 
 
I got data from 4sq in the format:

(Time)/(Venue)
_c0	/venueid	

1377540000/4ab427dff964a520227020e3
1378180800/4ab427dff964a520227020e3
1376586000/4ab427dff964a520227020e3
1376586000/4ab427dff964a520227020e3
1376082000/4ab427dff964a520227020e3


I've been able to pull ten venueids and insert them into the API URL, but now I need to get the JSON for them and then vconvert that to GeoJSON to get it into CArtoDB. 

I'm only using these ten as a test. The full file is 300K listings, and I'm not uploading that to GitHub, as it is under licensing agreement. I just need the process. 

To summarize:

> Pull venueID from CSV (checkins_mini.csv)
> turn venuID to string
> Insert string into URL and getJSON 
 https://api.foursquare.com/v2/venues/'+ venueURL + '?oauth_token=DKMQRQ5G33P5B1XQIHBJRPPVS2QXJ1NX4US0CWOEFEOJDLIK&v=20131013
> Get JSON of VenueIDs for all venues
> Open in Refine and Eliminate unnecessary columns
> Convert to GeoJSON or csv and geocode
