import os

theDirToAddFolders = '/Volumes/Echo/GIS/projects/rio/tasks/201508_fulcrum_pts_to_streets'

def makeBEHDirectoryStructure(theDir):
	print 'testing and adding folders for ' + theDir
	dataDir = theDir+'/data' 
	if not os.path.exists(dataDir):
		os.makedirs(dataDir)
	inpDir = theDir+'/data/input' 
	if not os.path.exists(inpDir):
		os.makedirs(inpDir)
	proDir = theDir+'/data/processing' 
	if not os.path.exists(proDir):
		os.makedirs(proDir)
	outDir = theDir+'/data/output' 
	if not os.path.exists(outDir):
		os.makedirs(outDir)

makeBEHDirectoryStructure(theDirToAddFolders)