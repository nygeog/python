import csv
from shapely.geometry import Point
with open('some.csv', 'rb') as f:
    reader = csv.DictReader(f)
    for row in reader:
        point = Point(float(row['lon']), float(row['lat']))