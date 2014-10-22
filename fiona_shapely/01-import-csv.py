import csv
with open('some.csv', 'rb') as f:
    reader = csv.DictReader(f)
    for row in reader:
        print row