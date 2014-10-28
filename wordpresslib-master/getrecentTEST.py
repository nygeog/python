import wordpresslib


url = "http://www.romanceatrandom.com/"
user = "Kimberly Cowser"
password = "loveswept"

# prepare client object
wp = wordpresslib.WordPressClient(url+"xmlrpc.php", user, password)

# select blog id
wp.selectBlog(0)

z = wp.getRecentPosts(20)

for i in z:
	try:
		print str(i.id) + '; ' +  str(i.tags) + '; ' +  str(i.title) + '; ' +  str(i.categories)
	except:
		print str(i.id) + '; ' +  str(i.tags) + '; ' + 'THIS RECORD sucks nuts MOTHEREFUCCKCKKKA'  #str(i.title) + '; ' + 'THIS RECORD sucks nuts' 

# theText2 = theText.id

# for i in theText2:
# 	print i


#print theText