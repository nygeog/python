import os
import glob

files = glob.glob('/Users/danielmsheehan/Desktop/images/*01.png')
for f in files:
    os.remove(f)

