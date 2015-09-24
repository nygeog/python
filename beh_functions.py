import os

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
    outDir = theDir+'/data/tables' 
    if not os.path.exists(outDir):
        os.makedirs(outDir)

def copyanything(src, dst):
    try:
        shutil.copytree(src, dst)
    except OSError as exc: # python >2.5
        if exc.errno == errno.ENOTDIR:
            shutil.copy(src, dst)
        else: raise