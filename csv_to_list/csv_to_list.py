import csv

inCSV = '/Volumes/Echo/GIS/projects/naas/tasks/201410_pollen_sites/data/input/pollen_sites/siteid_list.csv'

with open(inCSV, 'rb') as f:
    reader = csv.reader(f)
    your_list = list(reader)

idList = []
for i in your_list:
	idList.append(i[2])

print idList
