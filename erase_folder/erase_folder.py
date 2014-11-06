print 'try to erase a folder'

theFolderPath = '<the folder path>'
 
try:
	shutil.rmtree(theFolderPath)
except:
	print 'the folder was already missing'