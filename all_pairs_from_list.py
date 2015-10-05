#http://www.wellho.net/resources/ex.php4?item=y104/tessapy

people = ["Lisa","Pam","Phil","Maurice","Richard","John","Alan","Graham"]

def tessa(source):
        result = []
        for p1 in range(len(source)):
                for p2 in range(p1+1,len(source)):
                        result.append([source[p1],source[p2]])
        return result

pairings = tessa(people)
print len(pairings)," pairings"
for pair in pairings:
        print pair