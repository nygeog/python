import datetime
mylist = []
today = datetime.date.today()
mylist.append(today)
print mylist[0] # print the date object, not the container ;-)
2008-11-22

# It's better to always use str() because :

print "This is a new day : ", mylist[0] # will work
#This is a new day : 2008-11-22

print "This is a new day : " + mylist[0] # will crash
#cannot concatenate 'str' and 'datetime.date' objects

print "This is a new day : " + str(mylist[0]) 
#This is a new day : 2008-11-22