import pandas as pd

a = pd.read_csv("filea.txt")
b = pd.read_csv("fileb.txt")
c = pd.read_csv("filec.txt")
d = pd.read_csv("filed.txt")
print a
print b 
print c
print d
#b = b.dropna(axis=1)



#merged = a.merge(b, on='title')#.merge(c, on='title')
merged = pd.merge(a, b, how='left', on='title')

listy = ['c','d']

for listvar in listy:
	def_file = pd.read_csv("file"+listvar+".txt")

	allmerged = merged.merge(def_file, how='left', on='title')

print allmerged
allmerged.to_csv("output.txt", index=False)