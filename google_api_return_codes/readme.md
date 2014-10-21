#Google API Accuracy return codes 

Reference V3 API method: 
https://developers.google.com/maps/documentation/javascript/geocoding

location_type stores additional data about the specified location. The following values are currently supported:

- google.maps.GeocoderLocationType.ROOFTOP indicates that the returned result reflects a precise geocode.

- google.maps.GeocoderLocationType.RANGE_INTERPOLATED indicates that the returned result reflects an approximation (usually on a road) interpolated between two precise points (such as intersections). Interpolated results are generally returned when rooftop geocodes are unavailable for a street address.

- google.maps.GeocoderLocationType.GEOMETRIC_CENTER indicates that the returned result is the geometric center of a result such as a polyline (for example, a street) or polygon (region).

- google.maps.GeocoderLocationType.APPROXIMATE indicates that the returned result is approximate.


Reference V2 API method: 
https://developers.google.com/maps/documentation/geocoding/v2/

0 = Unknown accuracy.
1 = Country level accuracy. 
2 = Region (state, province, prefecture, etc.) level accuracy. 
3 = Sub-region (county, municipality, etc.) level accuracy. 
4 = Town (city, village) level accuracy. 
5 = Post code (zip code) level accuracy. 
6 = Street level accuracy.
7 = Intersection level accuracy.
8 = Address level accuracy.
9 = Premise (building name, property name, shopping center, etc.) level accuracy.