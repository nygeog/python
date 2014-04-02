import Image

imageList = ["test",
"LoveCraft",
"test3"]

for imageItem in imageList:

	basewidth = 650
	img = Image.open(imageItem+'.jpg')
	width, height = img.size
	print 'width is: ' + str(width) + ' and height is: ' + str(height)
	wpercent = (basewidth/float(img.size[0]))
	hsize = int((float(img.size[1])*float(wpercent)))
	img = img.resize((basewidth,hsize), Image.ANTIALIAS)
	img.save(imageItem+'_rescaled.jpg')
	img = Image.open(imageItem+'_rescaled.jpg')
	width, height = img.size
	print 'width is: ' + str(width) + ' and height is: ' + str(height)

	print 'done resizing image' + imageItem




