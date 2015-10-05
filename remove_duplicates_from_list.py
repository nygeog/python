mylist = ['a','a','b','c','c','d']

newlist = []
for i in mylist:
  if i not in newlist:
    newlist.append(i)

print newlist