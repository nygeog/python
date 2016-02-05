import shutil, errno
import time

theDate = time.strftime("%Y-%m-%d")
theDate = str(theDate)
print theDate

def copyanything(src, dst):
    try:
        shutil.copytree(src, dst)
    except OSError as exc: # python >2.5
        if exc.errno == errno.ENOTDIR:
            shutil.copy(src, dst)
        else: raise

outF = '/Users/danielmsheehan/GitHub/beh_public/cohd/data_dictionaries/'

print 'copy data dictionary'

flName = '/Users/danielmsheehan/GitHub/beh/cohd/docs/data_dictionaries/'
ddName = 'cohd_geocoding_and_geoprocessing_variables_data_dictionary.pdf'

incopy = flName + ddName 
outcopy = outF + ddName.replace('.pdf','_'+theDate+'.pdf')
copyanything(incopy, outcopy)