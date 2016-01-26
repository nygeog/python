import glob, os

rawDir = 'raw_data/20160114/Revised Driscoll Output/'
aclDir = 'RM_SLD_2015012_ACTICAL_WRIST_T6/'

aclLoc = wdi + rawDir + aclDir

os.chdir(aclLoc)
aclFiles = glob.glob('*.csv')