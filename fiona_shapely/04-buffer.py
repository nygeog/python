from shapely.geometry import mapping, shape
from fiona import collection

with collection("some.shp", "r") as input:
    # schema = input.schema.copy()
    schema = { 'geometry': 'Polygon', 'properties': { 'name': 'str' } }
    with collection(
        "some_buffer.shp", "w", "ESRI Shapefile", schema) as output:
        for point in input:
            output.write({
                'properties': {
                    'name': point['properties']['name']
                },
                'geometry': mapping(shape(point['geometry']).buffer(5.0))
            })