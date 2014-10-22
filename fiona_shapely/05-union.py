from shapely.geometry import mapping, shape
from shapely.ops import cascaded_union
from fiona import collection

with collection("some_buffer.shp", "r") as input:
    schema = input.schema.copy()
    with collection(
            "some_union.shp", "w", "ESRI Shapefile", schema) as output:
        shapes = []
        for f in input:
            shapes.append(shape(f['geometry']))
        merged = cascaded_union(shapes)
        output.write({
            'properties': {
                'name': 'Buffer Area'
                },
            'geometry': mapping(merged)
            })